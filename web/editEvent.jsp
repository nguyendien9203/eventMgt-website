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
                <h5 class="modal-title" id="exampleModalLabel">Edit event</h5>
            </div>
            <form>
                <div class="modal-body">                   
                    <ul class="list-group list-group-flush">               
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-calendar4-event m-1"></i>
                            <input type="text" class="form-control" placeholder="Title" style="border: none">
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-clock my-2 mx-1"></i>

                            <input type="date" class="form-control">
                            <input type="time" class="form-control mx-2">
                            <span class="p-2">To</span>
                            <input type="date" class="form-control mx-2">
                            <input type="time" class="form-control">


                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-geo-alt m-1"></i>
                            <input type="text" class="form-control" placeholder="Location" style="border: none">   

                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-text-center m-1"></i>                       
                            <select class="form-select" style="border: none">
                                <option selected>Select category</option>
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.getId()}">${category.getCategoryName()}</option>
                                </c:forEach>
                            </select>
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
                            <select class="form-select" id="multiple-select-field-add-attendees" data-placeholder="Invite attendees" multiple style="width: 100%">
                                <c:forEach items="${users}" var="user">
                                    <option value="${user.getId()}">${user.getUsername()}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-card-text m-1"></i>
                            <textarea class="form-control" id="editor" rows="3" placeholder="Add description" style="border: none"></textarea>
                        </li>                     
                    </ul>
                </div>
                <div class="modal-footer">
                    <input class="btn btn-primary" type="submit" name="addEvent" value="Save">      
                    <input class="btn btn-outline-primary" type="button" value="Cancel" data-bs-dismiss="modal">                                    
                </div>
            </form>
        </div>
    </div>
</div>

