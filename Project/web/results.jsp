<%@ page import="dbl.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.util.Map" %>
<%@ page import="dbl.GeneralUtils" %>
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
        //We decode as UTF-8 to handle special characters coming in from browser
        //We also trim strings as surrounding whitespace does not matter
        String qTitle = (request.getParameter("title") == null || request.getParameter("title").isEmpty()) ? null : new String( request.getParameter("title").getBytes(), "UTF-8").trim();
        String qAuthor = (request.getParameter("author") == null || request.getParameter("author").isEmpty()) ? null : new String( request.getParameter("author").getBytes(), "UTF-8").trim();
        String qYear = (request.getParameter("year") == null || request.getParameter("year").isEmpty()) ? null : new String( request.getParameter("year").getBytes(), "UTF-8").trim();
        String qVenue = (request.getParameter("venue") == null || request.getParameter("venue").isEmpty()) ? null : new String( request.getParameter("venue").getBytes(), "UTF-8").trim();
        String[] qTypes = (request.getParameterValues("type") == null) ? null : request.getParameterValues("type"); //preset doesn't need to be UTF decoded
        String qMonth = (request.getParameter("month") == null || request.getParameter("month").isEmpty()) ? null : new String( request.getParameter("month").getBytes(), "UTF-8").trim();
        String qEditor = (request.getParameter("editor") == null || request.getParameter("editor").isEmpty()) ? null : new String( request.getParameter("editor").getBytes(), "UTF-8").trim();
        String qPublisher = (request.getParameter("publisher") == null || request.getParameter("publisher").isEmpty()) ? null : new String( request.getParameter("publisher").getBytes(), "UTF-8").trim();
        String qAddress = (request.getParameter("address") == null || request.getParameter("address").isEmpty()) ? null : new String( request.getParameter("address").getBytes(), "UTF-8").trim();
        String qPages = (request.getParameter("pages") == null || request.getParameter("pages").isEmpty()) ? null : new String( request.getParameter("pages").getBytes(), "UTF-8").trim();
        String qChapter = (request.getParameter("chapter") == null || request.getParameter("chapter").isEmpty()) ? null : new String( request.getParameter("chapter").getBytes(), "UTF-8").trim();
        String qVolume = (request.getParameter("volume") == null || request.getParameter("volume").isEmpty()) ? null : new String( request.getParameter("volume").getBytes(), "UTF-8").trim();
        String qNumber = (request.getParameter("number") == null || request.getParameter("number").isEmpty()) ? null : new String( request.getParameter("number").getBytes(), "UTF-8").trim();
        String qCrossref = (request.getParameter("crossref") == null || request.getParameter("crossref").isEmpty()) ? null : new String( request.getParameter("crossref").getBytes(), "UTF-8").trim();
        String qSeries = (request.getParameter("series") == null || request.getParameter("series").isEmpty()) ? null : new String( request.getParameter("series").getBytes(), "UTF-8").trim();
        String qCdrom = (request.getParameter("cdrom") == null || request.getParameter("cdrom").isEmpty()) ? null : new String( request.getParameter("cdrom").getBytes(), "UTF-8").trim();
        String qIsbn = (request.getParameter("isbn") == null || request.getParameter("isbn").isEmpty()) ? null : new String( request.getParameter("isbn").getBytes(), "UTF-8").trim();
        String qCite = (request.getParameter("cite") == null || request.getParameter("cite").isEmpty()) ? null : new String( request.getParameter("cite").getBytes(), "UTF-8").trim();
        String qEe = (request.getParameter("ee") == null || request.getParameter("ee").isEmpty()) ? null : new String( request.getParameter("ee").getBytes(), "UTF-8").trim();
        String qUrl = (request.getParameter("url") == null || request.getParameter("url").isEmpty()) ? null : new String( request.getParameter("url").getBytes(), "UTF-8").trim();
        String qNotes = (request.getParameter("note") == null || request.getParameter("note").isEmpty()) ? null : new String( request.getParameter("note").getBytes(), "UTF-8").trim();

        //TODO: Handle array contains (case insensitive) for author, venue
        //Handle separated multiple items
        //We also trim any whitespace around entries
        String[] qAuthorList = new String[0];
        String[] qEditorList = new String[0];
        String[] qUrlList = new String[0];
        String[] qEeList = new String[0];
        String[] qCiteList = new String[0];
        String[] qIsbnList = new String[0];
        String[] qVenueList = new String[0];

        if (qAuthor != null) qAuthorList = qAuthor.trim().split("\\s*,\\s*");
        if (qEditor != null) qEditorList = qEditor.trim().split("\\s*,\\s*");
        if (qUrl != null) qUrlList = qUrl.trim().split("\\s*,\\s*");
        if (qEe != null) qEeList = qEe.trim().split("\\s*|\\s*");
        if (qCite != null) qCiteList = qCite.trim().split("\\s*,\\s*");
        if (qIsbn != null) qIsbnList = qIsbn.trim().split("\\s*,\\s*");
        if (qVenue != null) qVenueList = qVenue.trim().split("\\s*;\\s*");

        //Iterate through items to perform our search
        for (Item item : items) {

          //Check if item matches query
          //We achieve this by skipping items that do not match each query

          //Title
          if (GeneralUtils.querySkip(qTitle, item.getTitle()))
            continue;

          //Year
          if (GeneralUtils.querySkip(qYear, item.getYear()))
            continue;

          //Month
          if (GeneralUtils.querySkip(qMonth, item.getMonth()))
            continue;

          //Publisher
          if (GeneralUtils.querySkip(qPublisher, item.getPublisher()))
            continue;

          //Address
          if (GeneralUtils.querySkip(qAddress, item.getAddress()))
            continue;

          //Pages
          if (GeneralUtils.querySkip(qPages, item.getPages()))
            continue;

          //Chapter
          if (GeneralUtils.querySkip(qChapter, item.getChapter()))
            continue;

          //Volume
          if (GeneralUtils.querySkip(qVolume, item.getVolume()))
            continue;

          //Number
          if (GeneralUtils.querySkip(qNumber, item.getNumber()))
            continue;

          //Crossref
          if (GeneralUtils.querySkip(qCrossref, item.getCrossref()))
            continue;

          //Series
          if (GeneralUtils.querySkip(qSeries, item.getSeries()))
            continue;

          //Cdrom
          if (GeneralUtils.querySkip(qCdrom, item.getCdrom()))
            continue;

          //Notes
          if (GeneralUtils.querySkip(qNotes, item.getNote()))
            continue;

          //Now check multiple fields last
          //Check last for performance reasons

          //Author
          if (GeneralUtils.querySkipArray(qAuthorList, item.getAuthor().toArray(new String[item.getAuthor().size()])))
            continue;

          //Editor
          if (GeneralUtils.querySkipArray(qEditorList, item.getEditor().toArray(new String[item.getEditor().size()])))
            continue;

          //ISBN
          if (GeneralUtils.querySkipArray(qIsbnList, item.getIsbn().toArray(new String[item.getIsbn().size()])))
            continue;

          //Citing
          if (GeneralUtils.querySkipArray(qCiteList, item.getCite().toArray(new String[item.getCite().size()])))
            continue;

          //EE
          if (GeneralUtils.querySkipArray(qEeList, item.getEe().toArray(new String[item.getEe().size()])))
            continue;

          //URL
          if (GeneralUtils.querySkipArray(qUrlList, item.getUrl().toArray(new String[item.getUrl().size()])))
            continue;

          //Venue
          //Books have a field called "booktitle",
          //articles have a field called "journal",
          //thesis have a field called "school"
          boolean schoolSkip = false;

          if (GeneralUtils.querySkipArray(new String[]{qVenue}, item.getSchool().toArray(new String[item.getAuthor().size()])))
            schoolSkip = true;

          //Final check for venues
          if ((GeneralUtils.querySkip(qVenue, item.getBooktitle())) &&
            (GeneralUtils.querySkip(qVenue, item.getJournal())) &&
            (schoolSkip))
            continue;

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

        // END OF MATCHING

        //Generate Search blurp (time elapsed)
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
        <p>Sorry, no results found.</p>
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
