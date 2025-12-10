package bible.bible.mapper;

import bible.bible.domain.Bible;
import bible.bible.domain.BookInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BibleMapper {

    List<Bible> findByFilter(@Param("cate") Integer cate,
                             @Param("book") Integer book,
                             @Param("chapter") Integer chapter,
                             @Param("paragraph") Integer paragraph);

    List<String> findDistinctTestaments();

    List<BookInfo> findDistinctBooks(@Param("cate") Integer cate);
}
