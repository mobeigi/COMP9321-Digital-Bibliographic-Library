<%@ page import="dbl.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="java.nio.charset.Charset" %>
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
        //Empty or unspecified parameters result in a null string and won't be used when reducing the set of items
        String qTitle = (request.getParameter("title") == null || request.getParameter("title").isEmpty()) ? null : request.getParameter("title");
        String qAuthor = (request.getParameter("author") == null || request.getParameter("author").isEmpty()) ? null : request.getParameter("author");
        String qYear = (request.getParameter("year") == null || request.getParameter("year").isEmpty()) ? null : request.getParameter("year");
        String qVenue = (request.getParameter("venue") == null || request.getParameter("venue").isEmpty()) ? null : request.getParameter("venue");
        String[] qTypes = (request.getParameterValues("type") == null) ? null : request.getParameterValues("type");

        //We decode as UTF-8 to handle special characters coming in from browser
        if (qTitle != null) qTitle = new String(qTitle.getBytes(), "UTF-8");
        if (qAuthor != null) qAuthor = new String(qAuthor.getBytes(), "UTF-8");
        if (qYear != null) qYear = new String(qYear.getBytes(), "UTF-8");
        if (qVenue != null) qVenue = new String(qVenue.getBytes(), "UTF-8");

        if (qTypes != null) {
          for (String qType : qTypes) {
            qType = new String(qType.getBytes(), "UTF-8");
          }
        }

        //TODO: Handle array contains (case insensitive) for author, venue
        //Handle separated multiple items
        //We also trim any whitespace around entries
        String[] qAuthorList = new String[0];
        String[] qVenueList = new String[0];

        if (qAuthor != null) qAuthorList = qAuthor.trim().split("\\s*,\\s*");
        if (qVenue != null) qVenueList = qVenue.trim().split("\\s*;\\s*");

        if(qTitle != null) qTitle = qTitle.trim();
        if(qYear != null) qYear = qYear.trim();

        //Iterate through items to perform our search
        for (Item item : items) {

          //Check if item matches query

          //Title
          if (qTitle != null)
            if (item.getTitle() == null || !item.getTitle().toLowerCase().contains(qTitle.toLowerCase()))
              continue;

          //Author
          if (qAuthorList.length != 0) {
            if (item.getAuthor().size() == 0)
              continue;

            boolean skip = false;

            for (String author : qAuthorList) {
              if (!item.getAuthor().contains(author)) {
                skip = true;
                break;
              }
            }
            if (skip)
              continue;
          }

          //Year
          if (qYear != null)
            if (item.getYear() == null || !item.getYear().equals(qYear))
              continue;

          //Venue
          //Books have a field called "booktitle",
          //articles have a field called "journal",
          //thesis have a field called "school"
          if (qVenueList.length != 0) {
            //Get school multiple attribute
            boolean schoolSkip = false;
            if (item.getSchool().size() != 0) {
              for (String venue : qVenueList) {
                if (!item.getSchool().contains(venue)) {
                  schoolSkip = true;
                  break;
                }
              }
            } else { //no school attribute, so skip school
              schoolSkip = true;
            }

            //Final check
            if ((item.getBooktitle() == null || !item.getBooktitle().toLowerCase().contains(qVenue.toLowerCase())) &&
              (item.getJournal() == null || !item.getJournal().toLowerCase().contains(qVenue.toLowerCase())) &&
              (schoolSkip))
              continue;
          }

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
        <% if (numResults > 0) { %>
        <p>Found <strong><% out.print(NumberFormat.getInstance().format(numResults)); %></strong> results in <strong><% out.write(new DecimalFormat("0.000000").format(searchTime)); %> seconds</strong></p>
        <%
        } else { //No results found %>
        <p>Sorry, no matching datasets found!</p>
        <%
        }

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
