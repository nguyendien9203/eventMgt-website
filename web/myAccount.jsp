<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="modalAccount" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Account</h5>
            </div>
            <form action="home" method="post" >
                <div class="modal-body row p-3">
                    <div class="col-md-4">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item d-flex justify-content-start" data-bs-toggle="modal" data-bs-target="#modalAccount" style="cursor: pointer">
                                <i class="bi bi-info-circle"></i>
                                <span class="mx-2">Information</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-start" data-bs-toggle="modal" data-bs-target="#modalChangePassword" style="cursor: pointer">
                                <i class="bi bi-shield-lock"></i>
                                <span class="mx-2">Change password</span>
                            </li>                              
                        </ul>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <input type="hidden" class="form-control" name="userId" value="${account.getId()}">

                            <div class="col-md-12">
                                <label class="form-label">Fullname</label>
                                <input type="text" class="form-control" name="fullname" value="${account.getFullname()}">
                            </div>
                            <div class="col-md-12 my-2">
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

                            <div class="col-md-12 my-2">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" name="address" value="${account.getAddress()}">
                            </div>
                        </div>

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
