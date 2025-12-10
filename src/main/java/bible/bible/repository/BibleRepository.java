package bible.bible.repository;

import bible.bible.domain.Bible;
import bible.bible.domain.BookInfo;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

@Repository
public class BibleRepository {

    private final JdbcTemplate jdbcTemplate;

    public BibleRepository(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    private final RowMapper<Bible> bibleRowMapper = (rs, rowNum) -> {
        Bible bible = new Bible();
        bible.setSeq(rs.getInt("seq"));
        bible.setCate(rs.getInt("cate"));
        bible.setBook(rs.getInt("book"));
        bible.setChapter(rs.getInt("chapter"));
        bible.setParagraph(rs.getInt("paragraph"));
        bible.setSentence(rs.getString("sentence"));
        bible.setTestament(rs.getString("testament"));
        bible.setLong_label(rs.getString("long_label"));
        bible.setShort_label(rs.getString("short_label"));
        return bible;
    };

    private final RowMapper<BookInfo> bookInfoRowMapper = (rs, rowNum) -> {
        BookInfo bookInfo = new BookInfo();
        bookInfo.setBook(rs.getInt("book"));
        bookInfo.setLongLabel(rs.getString("long_label"));
        return bookInfo;
    };

    public List<Bible> findByFilter(Integer cate, Integer book, Integer chapter, Integer paragraph) {
        StringBuilder sql = new StringBuilder("SELECT * FROM BIBLE WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (cate != null) {
            sql.append(" AND cate = ?");
            params.add(cate);
        }
        if (book != null) {
            sql.append(" AND book = ?");
            params.add(book);
        }
        if (chapter != null) {
            sql.append(" AND chapter = ?");
            params.add(chapter);
        }
        if (paragraph != null) {
            sql.append(" AND paragraph = ?");
            params.add(paragraph);
        }
        sql.append(" ORDER BY seq"); // 결과를 성경 순서대로 정렬

        return jdbcTemplate.query(sql.toString(), params.toArray(), bibleRowMapper);
    }

    public List<String> findDistinctTestaments() {
        return jdbcTemplate.queryForList("SELECT testament FROM BIBLE GROUP BY testament, cate ORDER BY cate", String.class);
    }

    public List<BookInfo> findDistinctBooks(Integer cate) {
        String sql;
        Object[] params;

        if (cate != null) {
            sql = "SELECT book, long_label FROM BIBLE WHERE cate = ? GROUP BY book, long_label ORDER BY book";
            params = new Object[]{cate};
        } else {
            sql = "SELECT book, long_label FROM BIBLE GROUP BY book, long_label ORDER BY book";
            params = new Object[]{};
        }

        return jdbcTemplate.query(sql, bookInfoRowMapper, params);
    }
}
