<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyEvent</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <!-- Styles -->

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css" />
        <!-- Or for RTL support -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.rtl.min.css" />

    </head>
    <body>
        <%
            session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("login");
            }
        %>
        <div class="container" style="height: 100vh;">
            <jsp:include page="layout/nav.jsp"></jsp:include>
            <div class="row mt-2" style="height: 90%;">
                <jsp:include page="layout/aside.jsp"></jsp:include>
                <jsp:include page="layout/main.jsp"></jsp:include>
            </div>
        </div>
            
        <% String addSuccess = (String) request.getSession().getAttribute("addSuccess"); %>
        <% if (addSuccess != null && request.getAttribute("errs") == null) { %>
        <div class="toast-container top-0 end-0 p-3">
            <div id="liveToast" class="toast text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <%= addSuccess %>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        </div>
        <%            
            session.removeAttribute("addSuccess");
            }
        %>

        <jsp:include page="layout/script.jsp"></jsp:include>
    </body>
</html>
