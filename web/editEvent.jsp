<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.fpt.learning.model.User" %>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login");
    }
%>

<div class="modal fade" id="modalEditEvent" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Event</h5>
            </div>
            <form action="event" method="post">
                <div class="modal-body">

                    <ul class="list-group list-group-flush">    
                        <input type="hidden" name="eventId" value="${eventOfOrganizer.getId()}">
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-calendar4-event m-1"></i>
                            <input type="text" class="form-control" placeholder="Title" name="title" value="${eventOfOrganizer.getTitle()}" style="border: none">
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-clock my-2 mx-1"></i>

                            <input type="date" class="form-control" name="startDate" value="${eventOfOrganizer.getStartDate()}">
                            <span class="p-2">To</span>
                            <input type="date" class="form-control" name="endDate" value="${eventOfOrganizer.getEndDate()}">



                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-geo-alt m-1"></i>
                            <input type="text" class="form-control" placeholder="Location" name="location" value="${eventOfOrganizer.getLocation()}" style="border: none">   
                        </li>                       

                        <%
                            session = request.getSession(false);
                            if (session != null && session.getAttribute("user") != null) {
                            User user = (User) session.getAttribute("user");
                        %>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-person mx-1"></i>                        
                            <div clas="m-3">Organizer:<span class="mx-2"><%= user.getUsername() %></span></div>
                        </li>
                        <%
                            }
                        %>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-people m-1"></i> 

                            <select class="form-select" name="attendeesId" id="multiple-select-field-edit-attendees" data-placeholder="Invite attendees" multiple style="width: 100%">
                                <c:forEach items="${attendees}" var="attendee">
                                    <option value="${attendee.getId()}">${attendee.getUsername()}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-card-text m-1"></i>
                            <textarea class="form-control" id="editor" rows="3" placeholder="Add description" name="description" style="border: none">${eventOfOrganizer.getDescription()}</textarea>
                        </li>                      
                    </ul>
                </div>
                <div class="modal-footer">
                    <input class="btn btn-primary" type="submit" name="editEvent" value="Save">      
                    <input class="btn btn-outline-primary" type="button" value="Cancel" data-bs-dismiss="modal">                                    
                </div>
            </form>
        </div>
    </div>
</div>
