package bible.bible.service;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration  // "여기는 설정 파일입니다"라는 명찰
public class AppConfig {

    @Bean       // "이 메서드가 반환하는 객체를 배달 기사님으로 등록해주세요"
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
