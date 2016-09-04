import dbl.Item;
import dbl.SaxHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.util.List;

import javax.xml.parsers.SAXParser;

@WebServlet("/servlet")
public class Servlet extends javax.servlet.http.HttpServlet {
  private List<Item> items;
  private boolean xmlParsed = false;
  
  protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    
  }
  
  protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    
    //Get Page request came from
    String pageName = (String)request.getSession().getAttribute("page");
    System.out.println(pageName);
    
    //Parse XML database if we haven't done so already
    if (!xmlParsed) {
      //Parse XML file
      try {
        parseXML();
        xmlParsed = true;
      } catch (ParserConfigurationException | SAXException e) {}
  
      //Set attribute for items
      HttpSession session = request.getSession();
      session.setAttribute("itemList", items);
    }
  }
  
  //Helper classes
  private void parseXML() throws ParserConfigurationException, IOException, SAXException {
    ServletContext context = getServletContext();
    InputSource xmlFile = new InputSource(context.getResourceAsStream("dblp/dblp_sample.xml"));
    xmlFile.setEncoding("ISO-8859-1");
    
    SAXParserFactory factory = SAXParserFactory.newInstance();
    try {
      SAXParser saxParser = factory.newSAXParser();
      SaxHandler handler = new SaxHandler();
      saxParser.parse(xmlFile,  handler);
    
      this.items = handler.getItems();
    
      System.out.println("Parsed XML file!");
      
    } catch (Throwable err) {
      err.printStackTrace();
    }
  }
}
