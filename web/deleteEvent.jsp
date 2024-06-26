<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login");
    }
%>
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
                <form action="event" method="post">
                    <input type="hidden" name="eventId" value="${eventOfOrganizer.getId()}">
                    <input type="submit" class="btn btn-primary" name="deleteEvent" value="Delete">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">
                        <span>Cancel</span>
                    </button>  
                </form>                            
            </div>
        </div>
    </div>
</div>
