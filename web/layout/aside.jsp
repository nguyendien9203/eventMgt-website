<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fpt.learning.model.User" %>


<aside class="col-md-2 pt-1"> 
    <button class="btn text-muted" data-bs-toggle="modal" data-bs-target="#modalAccount" style="font-size: 1.2em;">
        <i class="bi bi-person"></i>
        <span>Account</span>
    </button>

    <a href="logout" class="btn btn-outline-primary my-4 m-2">
        <i class="bi bi-arrow-left-short"></i>
        <span>Logout</span>
    </a>

    <jsp:include page="../myAccount.jsp"></jsp:include>
    <jsp:include page="../changePassword.jsp"></jsp:include>

</aside>

