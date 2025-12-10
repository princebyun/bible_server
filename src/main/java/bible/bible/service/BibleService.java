package bible.bible.service;

import bible.bible.domain.Bible;
import bible.bible.domain.BookInfo;
import bible.bible.repository.BibleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BibleService {

    private final BibleRepository bibleRepository;

    public BibleService(BibleRepository bibleRepository) {
        this.bibleRepository = bibleRepository;
    }

    public List<Bible> getBibleVerses(Integer cate, Integer book, Integer chapter, Integer paragraph) {
        return bibleRepository.findByFilter(cate, book, chapter, paragraph);
    }

    public List<String> getTestaments() {
        return bibleRepository.findDistinctTestaments();
    }

    public List<BookInfo> getBooks(Integer cate) {
        return bibleRepository.findDistinctBooks(cate);
    }
}
