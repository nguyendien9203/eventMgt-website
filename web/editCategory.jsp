<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="modalEditCategory" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit category</h5>
            </div>
            <form>
                <div class="modal-body">

                    <ul class="list-group list-group-flush">               
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-text-center m-1"></i>
                            <input type="text" class="form-control" placeholder="Update category" style="border: none">
                        </li>
                    </ul>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button">
                        <i class="bi bi-floppy"></i>
                        <span>Save</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg"></i>
                        <span>Cancel</span>
                    </button> 
                </div>
            </form>
        </div>
    </div>
</div>


