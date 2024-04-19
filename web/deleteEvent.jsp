<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="modalDeleteEvent" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Delete event</h5>
            </div>
            <div class="modal-body">
                <p class="fw-normal">Are you sure you want to delete this event?</p>
            </div>
            <div class="modal-footer">
                <a type="button" class="btn btn-primary">
                    <i class="bi bi-calendar-x mr-2"></i>
                    <span>Delete</span>
                </a>
                <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg"></i>
                    <span>Cancel</span>
                </button>                
            </div>
        </div>
    </div>
</div>