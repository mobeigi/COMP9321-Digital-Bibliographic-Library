import java.net.URL;

/**
 * Item class which all DLB articles use
 * Note: Not all items will have values for every attribute
 */
public class Item {
  //Enums
  public static enum ItemTypes {
    ARTICLE,
    INPROCEEDINGS,
    PROCEEDINGS,
    BOOK,
    INCOLLECTION,
    PHDTHESIS,
    MASTERSTHESIS,
    WWW
  }
  
  //Fields
  private ItemTypes type;
  private String author;
  private String editor;
  private String title;
  private String booktitle;
  private String pages;
  private int year;
  private String address;
  private String journal;
  private int volume;
  private String number;
  private String month;
  private String url;
  private String ee;
  private String cdrom;
  private String cite;
  private String publisher;
  private String note;
  private String crossref;
  private String isbn;
  private String series;
  private String school;
  private String chapter;
  
  /**
   * Default constructor
   */
  public Item() {}
  
  /**
   * Constructor specifying items type
   * @param type the type of item
   */
  public Item(ItemTypes type) {
    this.type = type;
  }
  
  //Getters and Setters
  public ItemTypes getType() {
    return type;
  }
  
  public void setType(ItemTypes type) {
    this.type = type;
  }
  
  public String getAuthor() {
    return author;
  }
  
  public void setAuthor(String author) {
    this.author = author;
  }
  
  public String getEditor() {
    return editor;
  }
  
  public void setEditor(String editor) {
    this.editor = editor;
  }
  
  public String getTitle() {
    return title;
  }
  
  public void setTitle(String title) {
    this.title = title;
  }
  
  public String getBooktitle() {
    return booktitle;
  }
  
  public void setBooktitle(String booktitle) {
    this.booktitle = booktitle;
  }
  
  public String getPages() {
    return pages;
  }
  
  public void setPages(String pages) {
    this.pages = pages;
  }
  
  public int getYear() {
    return year;
  }
  
  public void setYear(int year) {
    this.year = year;
  }
  
  public String getAddress() {
    return address;
  }
  
  public void setAddress(String address) {
    this.address = address;
  }
  
  public String getJournal() {
    return journal;
  }
  
  public void setJournal(String journal) {
    this.journal = journal;
  }
  
  public int getVolume() {
    return volume;
  }
  
  public void setVolume(int volume) {
    this.volume = volume;
  }
  
  public String getNumber() {
    return number;
  }
  
  public void setNumber(String number) {
    this.number = number;
  }
  
  public String getMonth() {
    return month;
  }
  
  public void setMonth(String month) {
    this.month = month;
  }
  
  public String getUrl() {
    return url;
  }
  
  public void setUrl(String url) {
    this.url = url;
  }
  
  public String getEe() {
    return ee;
  }
  
  public void setEe(String ee) {
    this.ee = ee;
  }
  
  public String getCdrom() {
    return cdrom;
  }
  
  public void setCdrom(String cdrom) {
    this.cdrom = cdrom;
  }
  
  public String getCite() {
    return cite;
  }
  
  public void setCite(String cite) {
    this.cite = cite;
  }
  
  public String getPublisher() {
    return publisher;
  }
  
  public void setPublisher(String publisher) {
    this.publisher = publisher;
  }
  
  public String getNote() {
    return note;
  }
  
  public void setNote(String note) {
    this.note = note;
  }
  
  public String getCrossref() {
    return crossref;
  }
  
  public void setCrossref(String crossref) {
    this.crossref = crossref;
  }
  
  public String getIsbn() {
    return isbn;
  }
  
  public void setIsbn(String isbn) {
    this.isbn = isbn;
  }
  
  public String getSeries() {
    return series;
  }
  
  public void setSeries(String series) {
    this.series = series;
  }
  
  public String getSchool() {
    return school;
  }
  
  public void setSchool(String school) {
    this.school = school;
  }
  
  public String getChapter() {
    return chapter;
  }
  
  public void setChapter(String chapter) {
    this.chapter = chapter;
  }
  
}
