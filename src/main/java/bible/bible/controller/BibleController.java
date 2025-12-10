package bible.bible.controller;

import bible.bible.service.BibleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class BibleController {

    private final BibleService bibleService;

    public BibleController(BibleService bibleService) {
        this.bibleService = bibleService;
    }

    @GetMapping("/")
    public String home() {
        return "index"; // 메인 화면 (index.html)
    }

    @GetMapping("/bible")
    public String bible(
            @RequestParam Optional<Integer> cate,
            @RequestParam Optional<Integer> book,
            @RequestParam Optional<Integer> chapter,
            @RequestParam Optional<Integer> paragraph,
            Model model) {

        // 파라미터가 없으면 초기값 설정 (구약:1, 창세기:1, 1장)
        Integer finalCate = cate.orElse(1);
        Integer finalBook = book.orElse(1);
        Integer finalChapter = chapter.orElse(1);
        Integer finalParagraph = paragraph.orElse(null); // 절은 선택 사항

        model.addAttribute("verses", bibleService.getBibleVerses(finalCate, finalBook, finalChapter, finalParagraph));
        model.addAttribute("testaments", bibleService.getTestaments());
        model.addAttribute("books", bibleService.getBooks(finalCate));

        // 필터 선택 값을 유지하기 위해 모델에 추가
        model.addAttribute("selectedCate", finalCate);
        model.addAttribute("selectedBook", finalBook);
        model.addAttribute("selectedChapter", finalChapter);
        model.addAttribute("selectedParagraph", finalParagraph);

        return "view"; // 성경 보기 화면 (view.html)
    }
}
