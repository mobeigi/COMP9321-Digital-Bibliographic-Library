<%@ page import="dbl.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Set page and invoke servlet --%>
<% request.getSession().setAttribute("page", "itemdetails"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ - Item Details <%
    if(request.getParameter("id") != null) {
      out.print("(" + request.getParameter("id") + ")");
    }
  %>
  </title>

  <%@include file="headerinclude.html"%>
</head>

<body>
<%@include file="header.html"%>

<!-- Main container -->
<section id="welcome">
  <div class="headerpadding"></div>
  <div class="container">
    <h2>Item <span>Details</span></h2>
    <hr class="sep">

    <%
      int id = -1;
      if(request.getParameter("id") != null) {
        try {
          id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
          //Number not numerical, throw error
          id = -2;
        }
      }

      ArrayList<Item> items = (ArrayList<Item>) request.getSession().getAttribute("itemList");
      Item item = null;

      if (id >= 1 && id <= items.size()) {
        item = items.get(id - 1);
    %>
    <table id="itemdetails">
      <%

        //ID - Always exists at this stage
      %>
      <tr>
        <td class="firstcol"><strong>ID</strong></td>
        <td><% out.print(item.getId()); %></td>
      </tr>
      <%

        //Title
        if(item.getTitle() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Title</strong></td>
        <td><% out.print(item.getTitle()); %></td>
      </tr>
      <%
        }

        //Book title
        if(item.getBooktitle() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Book Title</strong></td>
        <td><% out.print(item.getBooktitle()); %></td>
      </tr>
      <%
        }

        //Type
        if(item.getType() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Type</strong></td>
        <td><% out.print(item.getType()); %></td>
      </tr>
      <%
        }

        //Author
        if(item.getAuthor().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>Author</strong></td>
        <td><% for (String s : item.getAuthor())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //Editor
        if(item.getEditor().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>Editor</strong></td>
        <td><% for (String s : item.getEditor())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //Pages
        if(item.getPages() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Pages</strong></td>
        <td><% out.print(item.getPages()); %></td>
      </tr>
      <%
        }
        //Year
        if(item.getYear() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Year</strong></td>
        <td><% out.print(item.getYear()); %></td>
      </tr>
      <%
        }
        //Address
        if(item.getAddress() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Address</strong></td>
        <td><% out.print(item.getAddress()); %></td>
      </tr>
      <%
        }
        //Journal
        if(item.getJournal() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Journal</strong></td>
        <td><% out.print(item.getJournal()); %></td>
      </tr>
      <%
        }
        //Volume
        if(item.getVolume() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Volume</strong></td>
        <td><% out.print(item.getVolume()); %></td>
      </tr>
      <%
        }
        //Number
        if(item.getNumber() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Number</strong></td>
        <td><% out.print(item.getNumber()); %></td>
      </tr>
      <%
        }
        //Month
        if(item.getMonth() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Month</strong></td>
        <td><% out.print(item.getMonth()); %></td>
      </tr>
      <%
        }
        //URL
        if(item.getUrl().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>URL</strong></td>
        <td><% for (String s : item.getUrl())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //EE
        if(item.getEe().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>EE</strong></td>
        <td><% for (String s : item.getEe())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //CDROM
        if(item.getCdrom() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>CDROM</strong></td>
        <td><% out.print(item.getCdrom()); %></td>
      </tr>
      <%
        }
        //cite
        if(item.getCite().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>Cite</strong></td>
        <td><% for (String s : item.getCite())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //Publisher
        if(item.getPublisher() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Publisher</strong></td>
        <td><% out.print(item.getPublisher()); %></td>
      </tr>
      <%
        }
        //Note
        if(item.getNote() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Note</strong></td>
        <td><% out.print(item.getNote()); %></td>
      </tr>
      <%
        }
        //Crossref
        if(item.getCrossref() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>CrossRef</strong></td>
        <td><% out.print(item.getCrossref()); %></td>
      </tr>
      <%
        }
        //ISBN
        if(item.getIsbn().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>ISBN</strong></td>
        <td><% for (String s : item.getIsbn())
                 out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //Series
        if(item.getSeries() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Series</strong></td>
        <td><% out.print(item.getSeries()); %></td>
      </tr>
      <%
        }
        //School
        if(item.getSchool().size() != 0) {
      %>
      <tr>
        <td class="firstcol"><strong>School</strong></td>
        <td><% for (String s : item.getSchool())
                out.print(s + "<br />"); %></td>
      </tr>
      <%
        }
        //Chapter
        if(item.getChapter() != null) {
      %>
      <tr>
        <td class="firstcol"><strong>Chapter</strong></td>
        <td><% out.print(item.getChapter()); %></td>
      </tr>
      <%
        }

      %> </table>
    <%
      } else { //Not a valid item

        if (request.getParameter("id") == null || request.getParameter("id").isEmpty()) { //No id
        %>
          <p><strong>Error:</strong> No item ID was provided.</p>
        <%
        }
        else if (id == -2) { //Non numerical
        %>
        <p><strong>Error:</strong> Provided ID '<strong><% out.print(request.getParameter("id")); %></strong>' is not numerical.</p>
        <%
        } else { //General error
        %>
        <p><strong>Error:</strong> No item exists with ID '<strong><% out.print(request.getParameter("id")); %></strong>'.</p>
        <%
        }
      }

      if (item != null) {
        //Show add to cart button
        %>
        <form action="cart.jsp" method="post">
          <input type="hidden" value="addtocart" name="action" />
          <input type="hidden" value="<% out.print(item.getId()); %>" name="itemid" />
          <input type="submit" class="nicebutton" value="Add to Cart" />
        </form>
        <%
      }
    %>


  </div>
  <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
