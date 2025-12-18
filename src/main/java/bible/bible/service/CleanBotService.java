package bible.bible.service;

import bible.bible.domain.CleanBotResult;
import bible.bible.domain.Message;
import bible.bible.domain.OllamaRequest;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Base64;
import java.util.Collections;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CleanBotService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;


    public CleanBotService(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    public CleanBotResult checkContent(String userText) {

        String url = "http://129.154.53.65:11434/api/chat";
        String prompt = "너는 게시판 관리자야. 다음 텍스트를 분석해.\n" +
                "텍스트: \"" + userText + "\"\n" +
                "공격적이거나 비속어가 있는지 판단해서 무조건 다음 JSON 형식으로만 답해(마크다운 backtick 없이):\n" +
                "{ \"isSafe\": boolean, \"reason\": string }\n";

        try {
            Message message = new Message("user", prompt);
            OllamaRequest request = new OllamaRequest("qwen2.5:3b", Collections.singletonList(message));

            String responseString = restTemplate.postForObject(url, request, String.class);
            JsonNode root = objectMapper.readTree(responseString);
            String content = root.path("message").path("content").asText();

            return objectMapper.readValue(content, CleanBotResult.class);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("qwen2 API 호출 실패: " + e.getMessage());
        }
    }


    public CleanBotResult checkImage(MultipartFile file) {

        String url = "http://129.154.53.65:11434/api/chat";
        try {
            String base64Image = Base64.getEncoder().encodeToString(file.getBytes());
            String promptText = "이 이미지가 게시판에 올리기에 안전한지 분석해.\n" +
                    "nudity, naked,blood, violence, sexual, weapon같은 요소들이 있는지 판단해서 안전한지 결과를 알려줘.\n" +
                    "결과는 무조건 JSON { \"isSafe\": boolean, \"reason\": string } 으로 답해.\n" +
                    "reason은 한국어로만 대답해.";

            Message message = new Message("user", promptText, Collections.singletonList(base64Image));

            OllamaRequest request = new OllamaRequest("moondream", Collections.singletonList(message));

            String responseString = restTemplate.postForObject(url, request, String.class);
            JsonNode root = objectMapper.readTree(responseString);
            String content = root.path("message").path("content").asText();

            return objectMapper.readValue(content, CleanBotResult.class);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("moondream 이미지 분석 실패: " + e.getMessage());
        }
    }
}