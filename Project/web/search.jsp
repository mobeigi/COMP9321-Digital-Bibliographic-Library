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
    <h2>Advanced <span>Search</span></h2>
    <hr class="sep">
    <p>Search for publications in our extensive catalogue using our advanced search below.</p>
    <div class="searchbox">
      <form action="results.jsp" method="get">
        <input type="text" name="title" placeholder="Title" />
        <input type="text" name="author" placeholder="Author (comma separated)" />

        <select name="month" class="left" style="width: 50%; padding: 10px 20px;">
          <option value="" disabled selected>Month</option>
          <option value="January">January</option>
          <option value="February">February</option>
          <option value="March">March</option>
          <option value="April">April</option>
          <option value="May">May</option>
          <option value="June">June</option>
          <option value="July">July</option>
          <option value="August">August</option>
          <option value="September">September</option>
          <option value="October">October</option>
          <option value="November">November</option>
          <option value="December">December</option>
        </select>
        <input type="text" name="year" class="right" style="width:50%; max-width: calc(50% - 8px);" maxlength="4" placeholder="Year" onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>

        <input type="month" name="fromdate" placeholder="From" class="left" style="width: 50%;"/>
        <input type="month" name="todate" placeholder="To" class="right" style="width:50%; max-width: calc(50% - 8px);"/>

        <input type="text" name="venue" placeholder="Venue (semicolon separated)"/>
        <input type="text" name="editor" placeholder="Editor (comma separated)"  />
        <input type="text" name="publisher" placeholder="Publisher" />
        <input type="text" name="address" placeholder="Address" />

        <input type="text" name="pages" placeholder="Pages" class="left" style="width: 25%;" />
        <input type="text" name="chapter" placeholder="Chapter"  class="right" style="width:25%; max-width: calc(25% - 8px);" />
        <input type="text" name="volume" placeholder="Volume"  class="right" style="width:25%; max-width: calc(25% - 8px);" />
        <input type="text" name="number" placeholder="Number"  class="right" style="width:25%; max-width: calc(25% - 8px);" />

        <input type="text" name="crossref" placeholder="CrossRef" class="left" style="width: 33.3%;"/>
        <input type="text" name="series" placeholder="Series" class="right" style="width:33.3%; max-width: calc(33.3% - 8px);"/>
        <input type="text" name="cdrom" placeholder="CDROM"  class="right" style="width:33.3%; max-width: calc(33.3% - 8px);"/>

        <input type="text" name="isbn" placeholder="ISBN (comma separated)"  />
        <input type="text" name="cite" placeholder="Citing (comma separated)"  />
        <input type="text" name="ee" placeholder="EE (vertical bar '|' separated)"  />
        <input type="text" name="url" placeholder="URL (comma separated)"  />

        <input type="text" name="note" placeholder="Notes"  />

        <select name="type" multiple id="type" size="9" title="Control click to select multiple options">
          <option disabled="disabled" style="font-weight: bold;">Publication Type:</option>
          <option value="<% out.print(Item.ItemTypes.ARTICLE); %>">Article (Journal)</option>
          <option value="<% out.print(Item.ItemTypes.PROCEEDINGS); %>">Proceedings (Conference)</option>
          <option value="<% out.print(Item.ItemTypes.INPROCEEDINGS); %>">Inproceedings (Conference)</option>
          <option value="<% out.print(Item.ItemTypes.BOOK); %>">Book</option>
          <option value="<% out.print(Item.ItemTypes.INCOLLECTION); %>">Incollection</option>
          <option value="<% out.print(Item.ItemTypes.PHDTHESIS); %>">PHD Thesis</option>
          <option value="<% out.print(Item.ItemTypes.MASTERSTHESIS); %>">Masters Thesis</option>
          <option value="<% out.print(Item.ItemTypes.WWW); %>">Website</option>
        </select>
        <table style="text-align: center; margin: 0 auto;">
          <tr>
            <td><label>Match CaSe</label></td>
            <td><input type="checkbox" name="matchcase" style="margin-left: 5px;" /></td>
          </tr>
          <tr>
            <td><label>Exact Match</label></td>
            <td><input type="checkbox" name="exactmatch" style="margin-left: 5px;" /></td>
          </tr>
        </table>
        <input type="submit" value="Search" />
      </form>
    </div>
    <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
