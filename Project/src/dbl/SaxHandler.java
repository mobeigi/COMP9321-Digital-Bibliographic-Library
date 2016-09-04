package dbl;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.util.*;

public class SaxHandler extends DefaultHandler {
  
  
  private List<Item> items = new ArrayList<Item>();
  public List<Item> getItems() {
    return items;
  }
  
  
  private Item curItem = null;
  
  //Boolean attirbutes
  private boolean b_author;
  private boolean b_editor;
  private boolean b_title;
  private boolean b_booktitle;
  private boolean b_pages;
  private boolean b_year;
  private boolean b_address;
  private boolean b_journal;
  private boolean b_volume;
  private boolean b_number;
  private boolean b_month;
  private boolean b_url;
  private boolean b_ee;
  private boolean b_cdrom;
  private boolean b_cite;
  private boolean b_publisher;
  private boolean b_note;
  private boolean b_crossref;
  private boolean b_isbn;
  private boolean b_series;
  private boolean b_school;
  private boolean b_chapter;
  
  @Override
  public void startElement(String uri, String localName, String qName,
                           Attributes attributes) throws SAXException {
    //Check for one of various item types
    switch (qName.toUpperCase()) {
      //dbl.Item types
      case "ARTICLE":
        curItem = new Item(Item.ItemTypes.ARTICLE);
        break;
      case "INPROCEEDINGS":
        curItem = new Item(Item.ItemTypes.INPROCEEDINGS);
        break;
      case "PROCEEDINGS":
        curItem = new Item(Item.ItemTypes.PROCEEDINGS);
        break;
      case "BOOK":
        curItem = new Item(Item.ItemTypes.BOOK);
        break;
      case "INCOLLECTION":
        curItem = new Item(Item.ItemTypes.INCOLLECTION);
        break;
      case "PHDTHESIS":
        curItem = new Item(Item.ItemTypes.PHDTHESIS);
        break;
      case "MASTERSTHESIS":
        curItem = new Item(Item.ItemTypes.MASTERSTHESIS);
        break;
      case "WWW":
        curItem = new Item(Item.ItemTypes.WWW);
        break;
      
      //Attributes
      case "AUTHOR":
        b_author = true;
        break;
      case "EDITOR":
        b_editor = true;
        break;
      case "TITLE":
        b_title = true;
        break;
      case "BOOKTITLE":
        b_booktitle = true;
        break;
      case "PAGES":
        b_pages = true;
        break;
      case "YEAR":
        b_year = true;
        break;
      case "ADDRESS":
        b_address = true;
        break;
      case "JOURNAL":
        b_journal = true;
        break;
      case "VOLUME":
        b_volume = true;
        break;
      case "NUMBER":
        b_number = true;
        break;
      case "MONTH":
        b_month = true;
        break;
      case "URL":
        b_url = true;
        break;
      case "EE":
        b_ee = true;
        break;
      case "CDROM":
        b_cdrom = true;
        break;
      case "CITE":
        b_cite = true;
        break;
      case "PUBLISHER":
        b_publisher = true;
        break;
      case "NOTE":
        b_note = true;
        break;
      case "CROSSREF":
        b_crossref = true;
        break;
      case "ISBN":
        b_isbn = true;
        break;
      case "SERIES":
        b_series = true;
        break;
      case "SCHOOL":
        b_school = true;
        break;
      case "CHAPTER":
        b_chapter = true;
        break;
    }
  }
  
  @Override
  public void endElement(String uri, String localName,
                         String qName) throws SAXException {
    //Handle end of item
    //Add curItem to our item list once we've finished adding all attributes
    switch (qName.toUpperCase()) {
      //dbl.Item types
      case "ARTICLE":
      case "INPROCEEDINGS":
      case "PROCEEDINGS":
      case "BOOK":
      case "INCOLLECTION":
      case "PHDTHESIS":
      case "MASTERSTHESIS":
      case "WWW":
        items.add(curItem);
        break;
      
      //Attributes
      //Attributes
      case "AUTHOR":
        b_author = false;
        break;
      case "EDITOR":
        b_editor = false;
        break;
      case "TITLE":
        b_title = false;
        break;
      case "BOOKTITLE":
        b_booktitle = false;
        break;
      case "PAGES":
        b_pages = false;
        break;
      case "YEAR":
        b_year = false;
        break;
      case "ADDRESS":
        b_address = false;
        break;
      case "JOURNAL":
        b_journal = false;
        break;
      case "VOLUME":
        b_volume = false;
        break;
      case "NUMBER":
        b_number = false;
        break;
      case "MONTH":
        b_month = false;
        break;
      case "URL":
        b_url = false;
        break;
      case "EE":
        b_ee = false;
        break;
      case "CDROM":
        b_cdrom = false;
        break;
      case "CITE":
        b_cite = false;
        break;
      case "PUBLISHER":
        b_publisher = false;
        break;
      case "NOTE":
        b_note = false;
        break;
      case "CROSSREF":
        b_crossref = false;
        break;
      case "ISBN":
        b_isbn = false;
        break;
      case "SERIES":
        b_series = false;
        break;
      case "SCHOOL":
        b_school = false;
        break;
      case "CHAPTER":
        b_chapter = false;
        break;
    }
  }
  
  @Override
  public void characters(char ch[], int start, int length) throws SAXException {
  
    String value = new String(ch, start, length);
    
    if(b_author)
      curItem.setAuthor(((curItem.getAuthor() == null) ? "" : curItem.getAuthor()) + value);
    
    if(b_editor)
      curItem.setEditor(((curItem.getEditor() == null) ? "" : curItem.getEditor()) + value);
    
    if(b_title)
      curItem.setTitle(((curItem.getTitle() == null) ? "" : curItem.getTitle()) + value);

    if(b_booktitle)
      curItem.setBooktitle(((curItem.getBooktitle() == null) ? "" : curItem.getBooktitle()) + value);
    
    if(b_pages)
      curItem.setPages(((curItem.getPages() == null) ? "" : curItem.getPages()) + value);
    
    if(b_year)
      curItem.setYear(((curItem.getYear() == null) ? "" : curItem.getYear()) + value);
    
    if(b_address)
      curItem.setAddress(((curItem.getAddress() == null) ? "" : curItem.getAddress()) + value);
    
    if(b_journal)
      curItem.setJournal(((curItem.getJournal() == null) ? "" : curItem.getJournal()) + value);
    
    if(b_volume)
      curItem.setVolume(((curItem.getVolume() == null) ? "" : curItem.getVolume()) + value);
    
    if(b_number)
      curItem.setNumber(((curItem.getNumber() == null) ? "" : curItem.getNumber()) + value);
    
    if(b_month)
      curItem.setMonth(((curItem.getMonth() == null) ? "" : curItem.getMonth()) + value);
    
    if(b_url)
      curItem.setUrl(((curItem.getUrl() == null) ? "" : curItem.getUrl()) + value);
    
    if(b_ee)
      curItem.setEe(((curItem.getEe() == null) ? "" : curItem.getEe()) + value);
    
    if(b_cdrom)
      curItem.setCdrom(((curItem.getCdrom() == null) ? "" : curItem.getCdrom()) + value);
    
    if(b_cite)
      curItem.setCite(((curItem.getCite() == null) ? "" : curItem.getCite()) + value);
    
    if(b_publisher)
      curItem.setPublisher(((curItem.getPublisher() == null) ? "" : curItem.getPublisher()) + value);
    
    if(b_note)
      curItem.setNote(((curItem.getNote() == null) ? "" : curItem.getNote()) + value);
    
    if(b_crossref)
      curItem.setCrossref(((curItem.getCrossref() == null) ? "" : curItem.getCrossref()) + value);
    
    if(b_isbn)
      curItem.setIsbn(((curItem.getIsbn() == null) ? "" : curItem.getIsbn()) + value);
    
    if(b_series)
      curItem.setSeries(((curItem.getSeries() == null) ? "" : curItem.getSeries()) + value);
    
    if(b_school)
      curItem.setSchool(((curItem.getSchool() == null) ? "" : curItem.getSchool()) + value);
    
    if(b_chapter)
      curItem.setChapter(((curItem.getChapter() == null) ? "" : curItem.getChapter()) + value);
    
  }
}
