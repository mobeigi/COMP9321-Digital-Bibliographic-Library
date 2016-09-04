<%@ page import="dbl.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Set page and invoke servlet --%>
<% request.getSession().setAttribute("page", "results"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ - Search Results</title>
  <%@include file="headerinclude.html"%>
</head>

<body>
<%@include file="header.html"%>

<!-- Main container -->
<section id="welcome">
  <div class="headerpadding"></div>
  <div class="container">
    <h2>Search <span>Results</span></h2>
    <hr class="sep">

    <table id="resultslist">
      <%
        ArrayList<Item> items = (ArrayList<Item>) request.getSession().getAttribute("itemList");
        ArrayList<Item> matchedItems = new ArrayList<Item>();

        int numResults = 0;
        long searchStartTime = System.nanoTime();

        //Gather search query
        String qTitle = (request.getParameter("title") == null || request.getParameter("title").isEmpty()) ? null : request.getParameter("title");
        String qAuthor = (request.getParameter("author") == null || request.getParameter("author").isEmpty()) ? null : request.getParameter("author");
        String qYear = (request.getParameter("year") == null || request.getParameter("year").isEmpty()) ? null : request.getParameter("year");
        String qVenue = (request.getParameter("venue") == null || request.getParameter("venue").isEmpty()) ? null : request.getParameter("venue");
        String[] qTypes = (request.getParameterValues("type") == null) ? null : request.getParameterValues("type");

        //Iterate through items
        for (Item item : items) {

          //Check if item matches query

          //Title
          if (qTitle != null)
            if (item.getTitle() == null || !item.getTitle().contains(qTitle))
              continue;

          System.out.println("passed title");

          //Author
          if (qAuthor != null)
            if (item.getAuthor() == null || !item.getAuthor().contains(qAuthor))
              continue;

          System.out.println("passed author");

          //Year
          if (qYear != null)
            if (item.getYear() == null || !item.getYear().equals(qYear))
              continue;

          System.out.println("passed year");

          //Venue
          //Books have a field called "booktitle",
          //articles have a field called "journal",
          //thesis have a field called "school"
          if (qVenue != null)
            if ((item.getBooktitle() == null || !item.getBooktitle().contains(qVenue)) &&
              (item.getJournal() == null || !item.getJournal().contains(qVenue)) &&
              (item.getSchool() == null || !item.getSchool().contains(qVenue)))
              continue;

          System.out.println("passed venue");

          //Type
          if (qTypes != null) {
            boolean typeMatched = false;
            for (String qType : qTypes) {
              if (item.getType() != null && item.getType().name().equals(qType)) {
                typeMatched = true;
                break;
              }
            }

            if (!typeMatched)
              continue;
          }

          //Item matched at this point
          ++numResults;
          matchedItems.add(item);
        }

        //Print out results

        //Search blurp
        long elapsedTime = System.nanoTime() - searchStartTime;
        double searchTime = (double)(elapsedTime) / 1000000000.0; //in seconds, nano time * 10^9

      %>
        <p>Found <strong><% out.print(NumberFormat.getInstance().format(numResults)); %></strong> results in <strong><% out.write(new DecimalFormat("0.000000").format(searchTime)); %> seconds</strong></p>
        <%

        //Print matched results
        for (Item item: matchedItems) {
          //Format output for this item
          String title = item.getTitle();

          //Shorten long titles
          if (title.length() > 110) {
            title = title.substring(0, 110);
            title += "...";
          }

      %>
      <tr>
        <td class="faCol"><i class="fa fa-newspaper-o"></i></td>
        <td><a href="/itemdetails.jsp?id=<% out.print(item.getId()); %>" title="View item details"><% out.print(title); %></a></td>
      </tr>
      <%
        }
      %>

    </table>
  </div>
  <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
