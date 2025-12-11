package bible.bible.controller;

import bible.bible.service.BibleService;
import java.util.Optional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BibleController {

    private final BibleService bibleService;

    public BibleController(BibleService bibleService) {
        this.bibleService = bibleService;
    }

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/bible")
    public String bible(
            @RequestParam Optional<Integer> cate,
            @RequestParam Optional<Integer> book,
            @RequestParam Optional<Integer> chapter,
            @RequestParam Optional<Integer> paragraph,
            @RequestParam Optional<String> keyword, // keyword 파라미터 추가
            Model model) {

        // 파라미터가 없으면 초기값 설정
        Integer finalCate = cate.orElse(null);
        Integer finalBook = book.orElse(null);
        Integer finalChapter = chapter.orElse(null);
        Integer finalParagraph = paragraph.orElse(null);
        String finalKeyword = keyword.orElse(null);

        model.addAttribute("verses",
                bibleService.getBibleVerses(finalCate, finalBook, finalChapter, finalParagraph, finalKeyword));
        model.addAttribute("testaments", bibleService.getTestaments());
        model.addAttribute("books", bibleService.getBooks(finalCate));

        // 필터 선택 값을 유지하기 위해 모델에 추가
        model.addAttribute("selectedCate", finalCate);
        model.addAttribute("selectedBook", finalBook);
        model.addAttribute("selectedChapter", finalChapter);
        model.addAttribute("selectedParagraph", finalParagraph);
        model.addAttribute("selectedKeyword", finalKeyword); // keyword 값 유지

        return "view"; // 성경 보기 화면 (view.jsp)
    }
}
