package dbl;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import java.util.*;

/**
 * Class to parse our dlb XML file
 *
 * @author Mohammad Ghasembeigi
 */
public class SaxHandler extends DefaultHandler {
  
  private List<Item> items = new ArrayList<Item>();
  public List<Item> getItems() {
    return items;
  }
  
  
  private Item curItem = null;
  
  //Boolean attributes
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
  
  //Holds our intermediate attribute data
  private String tmpAttribute;
  
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
      case "AUTHOR":
        b_author = false;
        curItem.setAuthor(tmpAttribute);
        break;
      case "EDITOR":
        b_editor = false;
        curItem.setEditor(tmpAttribute);
        break;
      case "TITLE":
        b_title = false;
        curItem.setTitle(tmpAttribute);
        break;
      case "BOOKTITLE":
        b_booktitle = false;
        curItem.setBooktitle(tmpAttribute);
        break;
      case "PAGES":
        b_pages = false;
        curItem.setPages(tmpAttribute);
        break;
      case "YEAR":
        b_year = false;
        curItem.setYear(tmpAttribute);
        break;
      case "ADDRESS":
        b_address = false;
        curItem.setAddress(tmpAttribute);
        break;
      case "JOURNAL":
        b_journal = false;
        curItem.setJournal(tmpAttribute);
        break;
      case "VOLUME":
        b_volume = false;
        curItem.setVolume(tmpAttribute);
        break;
      case "NUMBER":
        b_number = false;
        curItem.setNumber(tmpAttribute);
        break;
      case "MONTH":
        b_month = false;
        curItem.setMonth(tmpAttribute);
        break;
      case "URL":
        b_url = false;
        curItem.setUrl(tmpAttribute);
        break;
      case "EE":
        b_ee = false;
        curItem.setEe(tmpAttribute);
        break;
      case "CDROM":
        b_cdrom = false;
        curItem.setCdrom(tmpAttribute);
        break;
      case "CITE":
        b_cite = false;
        curItem.setCite(tmpAttribute);
        break;
      case "PUBLISHER":
        b_publisher = false;
        curItem.setPublisher(tmpAttribute);
        break;
      case "NOTE":
        b_note = false;
        curItem.setNote(tmpAttribute);
        break;
      case "CROSSREF":
        b_crossref = false;
        curItem.setCrossref(tmpAttribute);
        break;
      case "ISBN":
        b_isbn = false;
        curItem.setIsbn(tmpAttribute);
        break;
      case "SERIES":
        b_series = false;
        curItem.setSeries(tmpAttribute);
        break;
      case "SCHOOL":
        b_school = false;
        curItem.setSchool(tmpAttribute);
        break;
      case "CHAPTER":
        b_chapter = false;
        curItem.setChapter(tmpAttribute);
        break;
    }
    
    //Reset tmpAttribute
    tmpAttribute = "";
  }
  
  @Override
  public void characters(char ch[], int start, int length) throws SAXException {
  
    String value = new String(ch, start, length);
    tmpAttribute += value; //accumulate date in our temporary string
  }
}
