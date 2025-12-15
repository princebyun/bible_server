package bible.bible.service;

import bible.bible.domain.CleanBotResult;
import bible.bible.domain.Gemini.GeminiRequest;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class CleanBotService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    private final String API_KEY = "AIzaSyCuZg02VQ83TaRtmqH3Tah_ic_cx_uv5d0";

    public CleanBotService(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    public CleanBotResult checkContent(String userText) {
        // 모델명: Gemini 2.5 Flash
        String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
                + API_KEY;

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
}