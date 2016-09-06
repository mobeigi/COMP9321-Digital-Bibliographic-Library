package dbl;

import java.net.URL;
import java.util.ArrayList;

/**
 * Item class which all DLB publications use.
 * Note: Not all items will have values for every attribute.
 */
public class Item {
  private static int count = 0; //used for auto ID generation per class instance
  
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
  //We will treat all as strings
  private int id;
  private ItemTypes type;
  private ArrayList<String> author = new ArrayList<>();  //multiple, comma safe
  private ArrayList<String> editor = new ArrayList<>(); //multiple, comma safe
  private String title;
  private String booktitle; //part of venue search
  private String pages;
  private String year;
  private String address;
  private String journal; //part of venue search
  private String volume; //can be number or string
  private String number;  //integer
  private String month; //eg april
  private ArrayList<String> url = new ArrayList<>(); //multiple, comma safe
  private ArrayList<String> ee = new ArrayList<>(); //multiple, vertical bar safe
  private String cdrom;
  private ArrayList<String> cite = new ArrayList<>(); //multiple, comma safe
  private String publisher;
  private String note;
  private String crossref;
  private ArrayList<String> isbn = new ArrayList<>(); //multiple, comma safe
  private String series;
  private ArrayList<String> school = new ArrayList<>();  //multiple, semicolon safe, part of venue search
  private String chapter;
  
  /**
   * Default constructor
   */
  public Item() { count += 1; this.id = count; }
  
  /**
   * Constructor specifying items type
   * @param type the type of item
   */
  public Item(ItemTypes type) {
    count += 1;
    this.id = count;
    
    this.type = type;
  }
  
  
  /**
   * Provides a human readable type
   *
   * @param type The item type as an enum
   * @return human readable version of type
   */
  public static String getTypeNiceName(Item.ItemTypes type) {
    
    if (type == Item.ItemTypes.ARTICLE) {
      return "Article (Journal)";
    } else if (type == Item.ItemTypes.PROCEEDINGS) {
      return "Proceedings (Conference)";
    } else if (type == Item.ItemTypes.INPROCEEDINGS) {
      return "Inproceedings (Conference)";
    } else if (type == Item.ItemTypes.BOOK) {
      return "Book";
    } else if (type == Item.ItemTypes.INCOLLECTION) {
      return "Incollection";
    } else if (type == Item.ItemTypes.PHDTHESIS) {
      return "PHD Thesis";
    } else if (type == ItemTypes.MASTERSTHESIS) {
      return "Masters Thesis";
    } else if (type == Item.ItemTypes.WWW) {
      return "Website";
    }
    
    return type.name();
  }
  
  //Getters and Setters for all fields
  public int getId() {
    return id;
  }
  
  public void setId(int id) {
    this.id = id;
  }
  
  public ItemTypes getType() {
    return type;
  }
  
  public void setType(ItemTypes type) {
    this.type = type;
  }
  
  public ArrayList<String> getAuthor() {
    return this.author;
  }
  
  public void setAuthor(String author) {
    this.author.add(author);
  }
  
  public ArrayList<String> getEditor() {
    return this.editor;
  }
  
  public void setEditor(String editor) {
    this.editor.add(editor);
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
  
  public String getYear() {
    return year;
  }
  
  public void setYear(String year) {
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
  
  public String getVolume() {
    return volume;
  }
  
  public void setVolume(String volume) {
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
  
  public ArrayList<String> getUrl() {
    return this.url;
  }
  
  public void setUrl(String url) {
    this.url.add(url);
  }
  
  public ArrayList<String> getEe() {
    return this.ee;
  }
  
  public void setEe(String ee) {
    this.ee.add(ee);
  }
  
  public String getCdrom() {
    return cdrom;
  }
  
  public void setCdrom(String cdrom) {
    this.cdrom = cdrom;
  }
  
  public ArrayList<String> getCite() {
    return this.cite;
  }
  
  public void setCite(String cite) {
    this.cite.add(cite);
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
  
  public ArrayList<String> getIsbn() {
    return this.isbn;
  }
  
  public void setIsbn(String isbn) {
    this.isbn.add(isbn);
  }
  
  public String getSeries() {
    return series;
  }
  
  public void setSeries(String series) {
    this.series = series;
  }
  
  public ArrayList<String> getSchool() {
    return this.school;
  }
  
  public void setSchool(String school) {
    this.school.add(school);
  }
  
  public String getChapter() {
    return chapter;
  }
  
  public void setChapter(String chapter) {
    this.chapter = chapter;
  }
  
}
