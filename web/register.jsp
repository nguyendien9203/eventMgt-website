<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyEvent - Register</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

    </head>
    <body>
        <div class="container d-flex justify-content-center align-items-center" style="height: 100vh; width: 30%">
            <div>
                <h1 class="text-center mb-4">Register</h1>
                <div class="my-3 text-center">Already have an account? <a href="login">Login here</a></div>
                <form action="register" method="post" class="row g-3">           
                    <input type="hidden" class="form-control" name="id">
                    
                    <div class="col-md-12">
                        <label class="form-label">Fullname</label>
                        <input type="text" class="form-control" name="fullname" value="${fullname}">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" value="${username}">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" value="${password}">
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Confirm password</label>
                        <input type="password" class="form-control" name="rePassword" value="${rePassword}">
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input type="text" class="form-control" name="phone" value="${phone}">
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select">
                            <option value="" selected>Select gender</option>
                            <option value="Male" ${gender eq "Male" ? "selected" : ""}>Male</option>
                            <option value="Female" ${gender eq "Female" ? "selected" : ""}>Female</option>
                        </select>                      
                    </div>
                    
                    <div class="col-md-12">
                        <label class="form-label">Address</label>
                        <input type="text" class="form-control" name="address" value="${address}">
                    </div>
                    
                    
                    <div class="mb-3 d-flex justify-content-end">
                        <input type="submit" class="btn btn-primary" id="liveToastBtn" value="Register" name="register">
                    </div>
                </form>
            </div>
        </div>
    </div>



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

    <jsp:include page="layout/script.jsp"></jsp:include>

</body>
</html>

