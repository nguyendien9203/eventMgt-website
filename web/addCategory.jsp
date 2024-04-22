<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login");
    }
%>
<div class="modal fade" id="exampleModalAddCategory" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New Category</h5>
            </div>
            <form action="category" method="post">
                <div class="modal-body">

                    <ul class="list-group list-group-flush">               
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-text-center m-1"></i>
                            <input type="text" class="form-control" name="categoryName" placeholder="Add category" style="border: none">
                        </li>
                    </ul>

                </div>
                <div class="modal-footer">
                    <input class="btn btn-primary" type="submit" name="addCategory" value="Save">
                    <input class="btn btn-outline-primary" type="button" value="Cancel" data-bs-dismiss="modal">
                </div>

            </form>
        </div>
    </div>
</div>


