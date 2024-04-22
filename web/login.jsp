<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyEvent - Login</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
            <div>
                <h1 class="text-center mb-4">Login</h1>
                <div class="my-3 text-center">Don't have an account? <a href="register">Register here</a></div>
                <form action="login" method="post">              
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" value="${username}">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" value="${password}">
                    </div>
                    <div class="mb-3 d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
            </div>
        </div>

        <% String registerSuccess = (String) request.getSession().getAttribute("registerSuccess"); %>
        <% if (registerSuccess != null && request.getAttribute("errs") == null) { %>
        <div class="toast-container top-0 end-0 p-3">
            <div id="liveToast" class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <%= registerSuccess %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <%            
            session.removeAttribute("registerSuccess");
            }
        %>

        <c:forEach items="${errs}" var="err">
            <div class="toast-container top-0 end-0 p-3">

                <div id="liveToast" class="toast text-bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            ${err}
                        </div>
                        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <jsp:include page="layout/script.jsp"></jsp:include>
</body>
</html>
