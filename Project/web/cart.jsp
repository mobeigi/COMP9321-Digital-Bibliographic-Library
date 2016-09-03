<%--
  Created by IntelliJ IDEA.
  User: Mohammad
  Date: 03/09/16
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- Set page and invoke servlet --%>
<% request.getSession().setAttribute("page", "cart"); %>
<jsp:include page="/servlet" />

<html>
<head>
    <title>Title</title>
</head>
<body>
<p>cart</p>
</body>
</html>
