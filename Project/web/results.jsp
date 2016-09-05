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
<% request.getSession().setAttribute("page", "results"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ | Search Results</title>
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
          //We achieve this by skipping items that do not match each query

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
              if (!item.getAuthor().contains(author)) { //TODO: This should do a contains on string, not exact string match
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

        //Search blurp (time elapsed)
        long elapsedTime = System.nanoTime() - searchStartTime;
        double searchTime = (double)(elapsedTime) / 1000000000.0; //in seconds, nano time * 10^9

        //Pagination based on: http://www.tonymarston.net/php-mysql/pagination.html
        int pageNo = 1;

        //Try to parse page number as integer
        if (request.getParameter("pageNo") != null) {
          try {
            pageNo = Integer.parseInt(request.getParameter("pageNo"));
          } catch (NumberFormatException e) {}
        }

        int resultsPerPage = 10;
        int lastPage = (int)Math.ceil((double)matchedItems.size() / resultsPerPage);

        //Ensure pageNo is within range
        if (pageNo > lastPage)
          pageNo = lastPage;

        if (pageNo < 1)
          pageNo = 1;

        int startIndex = (pageNo - 1) * resultsPerPage;

        //Print out top of results summary
        if (numResults > 0) { %>
        <p>Found <strong><% out.print(NumberFormat.getInstance().format(numResults)); %></strong> results in <strong><% out.write(new DecimalFormat("0.000000").format(searchTime)); %> seconds</strong></p>
        <p class="result_summary">Showing results <strong><% out.print(startIndex + 1);%></strong> to <strong><% out.print(Math.min(startIndex + resultsPerPage, matchedItems.size())); %></strong></p>
        <%
        } else { //No results found %>
        <p>Sorry, no matching datasets found!</p>
        <%
        }

        // Print matched results
        for (int i = startIndex; i < Math.min(startIndex + resultsPerPage, matchedItems.size()); ++i) { //use min to ensure we cap at last item

          Item item = matchedItems.get(i);

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
      %></table><%

        if (numResults > 0) { //don't show pagination box if no results found
          //Print pagination icons
          %>
          <div id="paginationbox">
          <%
          String currentFullUrl = request.getRequestURL().toString();

          //Ensure query string is not empty
          if (request.getQueryString() != null && !request.getQueryString().isEmpty()) {
            String[] queries = request.getQueryString().split("&");
            ArrayList<String> finalQueryStringArray = new ArrayList<String>();

            //Remove current pageNo parameters
            for (String s : queries) {
              if (!s.startsWith("pageNo="))
                finalQueryStringArray.add(s);
            }

            //Recombine all other parameters in same order
            StringBuilder sb = new StringBuilder();
            for (String s : finalQueryStringArray)
            {
              sb.append(s);
              sb.append("&");
            }

            String finalQueryString = sb.toString();
            if (finalQueryString.endsWith("&")) //remove final '&' from join
              finalQueryString = finalQueryString.substring(0, finalQueryString.length() - 1);

            currentFullUrl += ("?" + finalQueryString);
          }

          if (pageNo == 1) {
          %>
          <img style="vertical-align:middle;" src="/images/results/resultset_first_gray.png" title="First Page">
          <img style="vertical-align:middle;" src="/images/results/resultset_previous_gray.png" title="Previous Page">
          <%
            } else { %>
          <a href="<% out.print(currentFullUrl + "&pageNo=1");%>"><img style="vertical-align:middle;" src="/images/results/resultset_first.png" title="First Page"></a>
          <a href="<% out.print(currentFullUrl + "&pageNo=" + (pageNo - 1));%>"><img style="vertical-align:middle;" src="/images/results/resultset_previous.png" title="Previous Page"></a>
          <%
            }

            out.write("<p class=\"pageNoOf\">Page " + pageNo + " of " + lastPage + "</p>");

            if (pageNo == lastPage) {
          %>
          <img style="vertical-align:middle;" src="/images/results/resultset_next_gray.png" title="Next Page">
          <img style="vertical-align:middle;" src="/images/results/resultset_last_gray.png" title="Last Page">
          <%
          } else { %>
          <a href="<% out.print(currentFullUrl + "&pageNo=" + (pageNo + 1));%>"><img style="vertical-align:middle;" src="/images/results/resultset_next.png" title="Next Page"></a>
          <a href="<% out.print(currentFullUrl + "&pageNo=" + lastPage);%>"><img style="vertical-align:middle;" src="/images/results/resultset_last.png" title="Last Page"></a>
          <%
            }
          %>
          </div>
        <%
        }
        %>
  </div>
  <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
