<%@ page import="dbl.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Set page and invoke servlet --%>
<% request.getSession().setAttribute("page", "search"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ | Search</title>
  <%@include file="headerinclude.html"%>
</head>

<body>
<%@include file="header.html"%>

<!-- Main container -->
<section id="welcome">
  <div class="headerpadding"></div>
  <div class="container">
    <h2>DLB+ <span>Search</span></h2>
    <hr class="sep">
    <div class="searchbox">
      <form action="results.jsp" method="get">
        <input type="text" name="title" placeholder="Publication Title" />
        <br />
        <input type="text" name="author" placeholder="Author (comma seperated)" id="author"/>
        <input type="text" name="year" maxlength="4" placeholder="Publication Year" id="year" onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>
        <br />
        <input type="text" name="venue" placeholder="Venue (semicolon seperated)"/>
        <br />
        <select name="type" multiple id="type" size="9" title="Control click to select multiple options">
          <option disabled="disabled" style="font-weight: bold;">Publication Type:</option>
          <option value="<% out.print(Item.ItemTypes.ARTICLE); %>">Article (Journal)</option>
          <option value="<% out.print(Item.ItemTypes.INPROCEEDINGS); %>">Proceedings (Conference)</option>
          <option value="<% out.print(Item.ItemTypes.PROCEEDINGS); %>">Proceedings (Conference)</option>
          <option value="<% out.print(Item.ItemTypes.BOOK); %>">Book</option>
          <option value="<% out.print(Item.ItemTypes.INPROCEEDINGS); %>">Incollection</option>
          <option value="<% out.print(Item.ItemTypes.PHDTHESIS); %>">PHD Thesis</option>
          <option value="<% out.print(Item.ItemTypes.MASTERSTHESIS); %>">Masters Thesis</option>
          <option value="<% out.print(Item.ItemTypes.WWW); %>">Website</option>
        </select>
        <br />
        <input type="submit" value="Search" />
      </form>
    </div>
    <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
