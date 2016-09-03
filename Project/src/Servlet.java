import org.w3c.dom.Document;
import org.xml.sax.ErrorHandler;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.w3c.dom.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.InputSource;

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
    session.setAttribute("character", items);
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
