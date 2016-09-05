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
<% request.getSession().setAttribute("page", "shoppingcart"); %>
<jsp:include page="/servlet" />

<html>
<head>
  <title>DBL+ | Shopping Cart</title>
  <%@include file="headerinclude.html"%>

  <script type="text/javascript">
  function inverseCheck() {
    var allInputs = document.getElementsByTagName("input");
    for (var i = 0, max = allInputs.length; i < max; i++) {
      if (allInputs[i].type === 'checkbox')
        if (allInputs[i].name === 'selectedCartItems')
          allInputs[i].checked = !allInputs[i].checked;
    }
  }

  function emptyCheck() {
    var allInputs = document.getElementsByTagName("input");
    var oneChecked = false;
    for (var i = 0, max = allInputs.length; i < max; i++) {
      if (allInputs[i].type === 'checkbox')
        if (allInputs[i].name === 'selectedCartItems')
          if (allInputs[i].checked) {
            oneChecked = true;
            break;
          }

    }

    //If no checkboxes were checked, then we are trying to
    //remove from cart no items, let user know of this issue
    if (!oneChecked) {
      document.getElementById("errorbox").innerHTML = "<strong>Error:</strong> No items are marked for removal.";
      return false;
    }

    return true;
  }

  function resetError() {
    document.getElementById("errorbox").innerHTML = "";
  }
  </script>
</head>

<body>
<%@include file="header.html"%>

<!-- Main container -->
<section id="welcome">
  <div class="headerpadding"></div>
  <div class="container">
    <h2>Shopping <span>Cart</span></h2>
    <hr class="sep">

      <%
        ArrayList<Item> items = (ArrayList<Item>) request.getSession().getAttribute("itemList");
        ArrayList<Integer> cartContents = (ArrayList<Integer>)request.getSession().getAttribute("shoppingcart");

        //Print out cart size information
      if (cartContents.size() > 0) { %>
     <form action="cart.jsp" method="post" onsubmit="return emptyCheck();">
      <table id="cartlist">
      <p>There are currently <strong><% out.print(cartContents.size()); %></strong> items in your shopping cart.</p>
        <tr>
          <th></th>
          <th></th>
          <th class="checkboxheadcol"><i class="fa fa-minus-square" title="Check items for removal"></i>
          <br /><input type="checkbox" onchange="inverseCheck();resetError();" title="Inverse selection"/></th>
        </tr>
      <%
      } else { //Empty cart %>
      <p>Your shopping cart is empty.</p>
      <%
        }

        // Print cart contents
        for (Integer itemNum : cartContents) {
          Item item = items.get(itemNum);

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
        <td style="text-align: center;"><input type="checkbox" name="selectedCartItems" value="<% out.print(item.getId()); %>" title="Check to mark this item for removal" onchange="resetError();"/></td>
      </tr>
      <%
        }

        %>
      </table>
       <p id="errorbox"></p>
       <a href="/search.jsp"><input class="nicebutton" type="button" value="Return to search" /></a>
        <%
        if (cartContents.size() > 0) {
        %>
          <input type="hidden" value="removefromcart" name="action" />
          <input class="nicebutton" type="submit" value="Remove items from cart" /> <%
        }
        %></form><%
      %>
  <div class="push"></div>
</section>

<%@include file="footer.html"%>

</body>

</html>
