import dbl.Item;
import dbl.SaxHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.util.List;

import javax.xml.parsers.SAXParser;

@WebServlet("/test")
public class Servlet extends javax.servlet.http.HttpServlet {
  private List<Item> items;
  
  protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    
  }
  
  protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    System.out.println("test");
    
    //Parse XML file
    try {
      parseXML();
    } catch (ParserConfigurationException e) {
      e.printStackTrace();
    } catch (SAXException e) {
      e.printStackTrace();
    }
    
    //Set attribute for items
    HttpSession session = request.getSession();
    session.setAttribute("itemList", items);
    request.getRequestDispatcher("/index.jsp").forward(request, response);
  }
  
  //Helper classes
  
  private void parseXML() throws ParserConfigurationException, IOException, SAXException {
    ServletContext context = getServletContext();
    InputSource xmlFile = new InputSource(context.getResourceAsStream("dblp/dblp_sample.xml"));
    SAXParserFactory factory = SAXParserFactory.newInstance();
    try {
      System.out.println("Parsing XML file...");
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
