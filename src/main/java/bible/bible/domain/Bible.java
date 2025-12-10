package bible.bible.domain;

public class Bible {

    private int seq;
    private int cate;
    private int book;
    private int chapter;
    private int paragraph;
    private String sentence;
    private String testament;
    private String long_label;
    private String short_label;

    // Getters and Setters
    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public int getCate() {
        return cate;
    }

    public void setCate(int cate) {
        this.cate = cate;
    }

    public int getBook() {
        return book;
    }

    public void setBook(int book) {
        this.book = book;
    }

    public int getChapter() {
        return chapter;
    }

    public void setChapter(int chapter) {
        this.chapter = chapter;
    }

    public int getParagraph() {
        return paragraph;
    }

    public void setParagraph(int paragraph) {
        this.paragraph = paragraph;
    }

    public String getSentence() {
        return sentence;
    }

    public void setSentence(String sentence) {
        this.sentence = sentence;
    }

    public String getTestament() {
        return testament;
    }

    public void setTestament(String testament) {
        this.testament = testament;
    }

    public String getLong_label() {
        return long_label;
    }

    public void setLong_label(String long_label) {
        this.long_label = long_label;
    }

    public String getShort_label() {
        return short_label;
    }

    public void setShort_label(String short_label) {
        this.short_label = short_label;
    }
}
