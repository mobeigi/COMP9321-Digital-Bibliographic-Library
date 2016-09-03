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
    }
  }
  
  @Override
  public void characters(char ch[], int start, int length) throws SAXException {
  
    String value = new String(ch, start, length);
  
    if(b_author) {
      curItem.setAuthor(value);
      b_author = false;
    }
    if(b_editor) {
      curItem.setEditor(value);
      b_editor = false;
    }
    if(b_title) {
      curItem.setTitle(value);
      b_title = false;
    }
    if(b_booktitle) {
      curItem.setBooktitle(value);
      b_booktitle = false;
    }
    if(b_pages) {
      curItem.setPages(value);
      b_pages = false;
    }
    if(b_year) {
      curItem.setYear(value);
      b_year = false;
    }
    if(b_address) {
      curItem.setAddress(value);
      b_address = false;
    }
    if(b_journal) {
      curItem.setJournal(value);
      b_journal = false;
    }
    if(b_volume) {
      curItem.setVolume(value);
      b_volume = false;
    }
    if(b_number) {
      curItem.setNumber(value);
      b_number = false;
    }
    if(b_month) {
      curItem.setMonth(value);
      b_month = false;
    }
    if(b_url) {
      curItem.setUrl(value);
      b_url = false;
    }
    if(b_ee) {
      curItem.setEe(value);
      b_ee = false;
    }
    if(b_cdrom) {
      curItem.setCdrom(value);
      b_cdrom = false;
    }
    if(b_cite) {
      curItem.setCite(value);
      b_cite = false;
    }
    if(b_publisher) {
      curItem.setPublisher(value);
      b_publisher = false;
    }
    if(b_note) {
      curItem.setNote(value);
      b_note = false;
    }
    if(b_crossref) {
      curItem.setCrossref(value);
      b_crossref = false;
    }
    if(b_isbn) {
      curItem.setIsbn(value);
      b_isbn = false;
    }
    if(b_series) {
      curItem.setSeries(value);
      b_series = false;
    }
    if(b_school) {
      curItem.setSchool(value);
      b_school = false;
    }
    if(b_chapter) {
      curItem.setChapter(value);
      b_chapter = false;
    }
  }
}
