package bible.bible.service;

import bible.bible.domain.CleanBotResult;
import bible.bible.domain.Gemini.GeminiRequest;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Base64;
import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CleanBotService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Value("${gemini.api.key}")
    private String apiKey;

    public CleanBotService(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    public CleanBotResult checkContent(String userText) {
        // 모델명: Gemini 2.5 Flash
        String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
                + apiKey;

        String prompt = "너는 게시판 관리자야. 다음 텍스트를 분석해.\n" +
                "텍스트: \"" + userText + "\"\n" +
                "공격적이거나 비속어가 있는지 판단해서 무조건 다음 JSON 형식으로만 답해(마크다운 backtick 없이):\n" +
                "{ \"isSafe\": boolean, \"reason\": string }\n" +
                "안전하다면 reason은 '건전한 게시글입니다'라고 써.";

        try {
            GeminiRequest request = new GeminiRequest(prompt);

            String responseString = restTemplate.postForObject(url, request, String.class);

            JsonNode root = objectMapper.readTree(responseString);
            String text = root.path("candidates").get(0)
                    .path("content").path("parts").get(0)
                    .path("text").asText();

            text = text.replace("```json", "").replace("```", "").trim();

            return objectMapper.readValue(text, CleanBotResult.class);

        } catch (HttpClientErrorException e) {
            throw new RuntimeException("Google API 호출 실패: " + e.getResponseBodyAsString());
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("알 수 없는 오류: " + e.getMessage());
        }
    }


    public CleanBotResult checkImage(MultipartFile file) {
        String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
                + apiKey;

        try {
            String base64Image = Base64.getEncoder().encodeToString(file.getBytes());
            String mimeType = file.getContentType();

            String promptText = "이 이미지가 게시판에 올리기에 안전한지 분석해. " +
                    "선정적이거나 폭력적이거나 혐오스러운 요소가 있는지 확인해. " +
                    "결과는 무조건 JSON { \"isSafe\": boolean, \"reason\": string } 으로 답해.";

            GeminiRequest request = new GeminiRequest();

            GeminiRequest.Part textPart = new GeminiRequest.Part(promptText);
            GeminiRequest.Part imagePart = new GeminiRequest.Part(new GeminiRequest.InlineData(mimeType, base64Image));

            GeminiRequest.Content content = new GeminiRequest.Content(List.of(textPart, imagePart));

            request.setContents(List.of(content));

            String responseString = restTemplate.postForObject(url, request, String.class);

            JsonNode root = objectMapper.readTree(responseString);
            String text = root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
            text = text.replace("```json", "").replace("```", "").trim();
            return objectMapper.readValue(text, CleanBotResult.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("이미지 분석 실패: " + e.getMessage());
        }
    }
}