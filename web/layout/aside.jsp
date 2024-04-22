<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fpt.learning.model.User" %>
<%
    session = request.getSession(false);
    if (session != null && session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user");
%>

<aside class="col-md-2 pt-1">
    <h5 class="text-muted p-2">
        <i class="bi bi-person"></i>
        <span>Account</span>
    </h5>

    <ul class="nav flex-column p-2">
        <li class="nav-item my-3 d-flex">
            <span class="px-2 overflow-hidden-text" style="max-width: 150px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= user.getUsername() %></span>
        </li>           
    </ul>

    <a href="logout" class="btn btn-outline-primary my-4 m-2">
        <i class="bi bi-arrow-left-short"></i>
        <span>Logout</span>
    </a>

</aside>
<%
    }
%>

