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

    <div class="modal fade" id="modalAccount" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Account</h5>
                </div>
                <form action="home" method="post" >
                    <div class="modal-body row p-3">
                        <input type="hidden" class="form-control" name="userId" value="${account.getId()}">

                        <div class="col-md-12">
                            <label class="form-label">Fullname</label>
                            <input type="text" class="form-control" name="fullname" value="${account.getFullname()}">
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" value="${account.getUsername()}" disabled>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Phone</label>
                            <input type="text" class="form-control" name="phone" value="${account.getPhone()}">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select">
                                <option value="Male" ${account.getGender() eq "Male" ? "selected" : ""}>Male</option>
                                <option value="Female" ${account.getGender() eq "Female" ? "selected" : ""}>Female</option>
                            </select>                      
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Address</label>
                            <input type="text" class="form-control" name="address" value="${account.getAddress()}">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input class="btn btn-primary" type="submit" name="editInfo" value="Save">      
                        <input class="btn btn-outline-primary" type="button" value="Cancel" data-bs-dismiss="modal">                                    
                    </div>
                </form>
            </div>
        </div>
    </div>

</aside>

