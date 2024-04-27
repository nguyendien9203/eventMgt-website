<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="modalChangePassword" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                <label class="form-label">Old password</label>
                                <input type="password" class="form-control" name="oldPassword" value="">
                            </div>
                            <div class="col-md-12 my-2">
                                <label class="form-label">New password</label>
                                <input type="password" class="form-control" name="newPassword" value="">
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Confirm new password</label>
                                <input type="password" class="form-control" name="confirmNewPassword" value="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input class="btn btn-primary" type="submit" name="changePassword" value="Save">      
                    <input class="btn btn-outline-primary" type="button" value="Cancel" data-bs-dismiss="modal">                                    
                </div>
            </form>
        </div>
    </div>
</div>
