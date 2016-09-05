<%@ page import="org.omg.CORBA.Request" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dbl.Item" %>
<%@ page import="java.util.Random" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Set page and invoke servlet --%>
<% request.getSession().setAttribute("page", "index"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ | Homepage</title>
  <%@include file="headerinclude.html"%>
</head>

<body>

<%@include file="header.html"%>

<!-- Slider -->
<div id="owl-hero" class="owl-carousel owl-theme">
  <div class="item" style="background-image: url(images/sliders/Slide1.jpg)">
    <div class="caption">
      <h6>Over 1000 new publications added daily!</h6>
      <h1>Powerful <span>Search</span></h1>
      <a class="btn btn-transparent" href="/search.jsp">Search Now</a>
    </div>
  </div>
  <div class="item" style="background-image: url(images/sliders/Slide2.jpg)">
    <div class="caption">
      <h6>Share your publications with 12.8 million monthly visitors</h6>
      <h1>Get <span>Discovered</span></h1>
    </div>
  </div>
  <div class="item" style="background-image: url(images/sliders/Slide3.jpg)">
    <div class="caption">
      <h6>Mobile apps now available for iOS/Android</h6>
      <h1>Stay <span>Connected</span></h1>
    </div>
  </div>
</div>

<!-- Main container -->
<section id="welcome">
    <div class="container">
        <h2>Welcome To <span>DBL+</span></h2>
        <hr class="sep">
        <p>Leading Digital Bibliographic Library host with over 3.4 million catalogued publications!</p>

        <br />
        <!-- Simple Search -->
        <h4>SEARCH OUR DATABASE</h4>
        <hr class="sep">
        <div class="searchbox">
        <form action="results.jsp" method="get">
          <input type="text" name="title" placeholder="Title" />
          <br />
          <input type="text" name="author" placeholder="Author (comma seperated)" class="left" style="width: 70%;" />
          <input type="text" name="year" maxlength="4" placeholder="Year" class="right" style="width:30%; max-width: calc(30% - 8px);" onkeypress='return event.charCode >= 48 && event.charCode <= 57'/>
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
          <a href="/search.jsp" title="Use Advanced Search" style="float: right;">Advanced Search</a>
          <input type="submit" value="Search" />
        </form>
        </div>

        <br />
        <!-- Random articles -->
        <h4>THESE ARTICLES MAY INTEREST YOU</h4>
        <hr class="sep">

        <table id="randomlist">
        <%
            ArrayList<Item> items = (ArrayList<Item>) request.getSession().getAttribute("itemList");

            //Generate 10 random items
            for (int i = 0; i < 10; ++i) {
              Random rand = new Random();
              int n = rand.nextInt(items.size()) + 1;
              Item item = items.get(n);
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