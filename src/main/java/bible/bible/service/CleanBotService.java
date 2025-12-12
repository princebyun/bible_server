package bible.bible.service;

import bible.bible.domain.ChatRequest;
import bible.bible.domain.CleanBotResponse;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class CleanBotService {

    private final RestTemplate restTemplate;

    // 생성자 주입 (기사님 모셔오기)
    public CleanBotService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public CleanBotResponse checkContent(String userText) {
        // 1. 목적지 주소 (Ollama API URL)
        String url = "http://localhost:11434/api/chat";

        // 2. 보낼 데이터 채우기 (여기가 핵심!)
        ChatRequest request = new ChatRequest();
        // ... 여기에 코드를 채워야 해요 ...

        // 3. 우편 발송 (POST 요청)
        return restTemplate.postForObject(url, request, CleanBotResponse.class);
    }
}