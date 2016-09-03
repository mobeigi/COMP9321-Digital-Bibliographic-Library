import org.xml.sax.InputSource;

import javax.servlet.ServletContext;
import javax.xml.parsers.SAXParserFactory;
import java.io.IOException;

public class Servlet extends javax.servlet.http.HttpServlet {
  protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    
  }
  
  protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
    
    //Parse XML file
    ServletContext context = getServletContext();
    InputSource dbXmlFile = new InputSource(context.getResourceAsStream("/web/dblp/dblp_sample.xml"));
    
    
  }
}
