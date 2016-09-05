import dbl.Item;
import dbl.SaxHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.ServletContext;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.SAXParser;

@WebServlet("/servlet")
public class Servlet extends javax.servlet.http.HttpServlet {
  private List<Item> items;
  private boolean xmlParsed = false;
  
  protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    initSetup(request, response);
    
    String pageName = (String)request.getSession().getAttribute("page");
    
    if (pageName.equals("shoppingcart")) {
      String action = (request.getParameter("action") == null || request.getParameter("action").isEmpty()) ? null : request.getParameter("action");
      ArrayList<Integer> cart = (ArrayList<Integer>) request.getSession().getAttribute("shoppingcart");
      
      if (action != null) {
        if (action.equals("addtocart")) {
          String idStr = (request.getParameter("itemid") == null || request.getParameter("itemid").isEmpty()) ? null : request.getParameter("itemid");
          if (idStr != null) {
            try {
              int id = Integer.parseInt(idStr);
              
              //Ensure ID is in valid range
              if (id > 0 && id <= items.size()) {
                cart.add(id - 1);
              }
            } catch (NumberFormatException e) {}
          }
        } else if (action.equals("removefromcart")) {
    
          //Get post parameters
          String[] qIDList = (request.getParameterValues("selectedCartItems") == null) ? null : request.getParameterValues("selectedCartItems");
    
          if (qIDList != null) {
            //Remove various items from cart
            for (String id : qIDList) {
              try {
                cart.remove(Integer.valueOf(Integer.parseInt(id) - 1)); //Remove first instance of ID
              } catch (NumberFormatException e) {
              }
            }
          }
        }
      }
    }
  
  }
  
  protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    initSetup(request, response);
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
    
      System.out.println("Parsed XML file! Number of publications: " + this.items.size());
      
    } catch (Throwable err) {
      err.printStackTrace();
    }
  }
  
  private void initSetup(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws IOException {
    //Parse XML database if we haven't done so already
    if (!xmlParsed) {
    
      //Parse XML file
      try {
        parseXML();
        xmlParsed = true;
      } catch (ParserConfigurationException | SAXException e) {}
    
    }
    
    //Set attribute for items if it doesn't already exist
    if (request.getSession().getAttribute("itemList") == null) {
      request.getSession().setAttribute("itemList", this.items);
    }
  
    //Create shopping cart if none exist
    if (request.getSession().getAttribute("shoppingcart") == null) {
      List<Integer> shoppingcart = new ArrayList<Integer>();
      request.getSession().setAttribute("shoppingcart", shoppingcart);
    }
  }
}
