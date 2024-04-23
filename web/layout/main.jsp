<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.Month" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>


<main class="col-md-6 pt-1">
    <div class="card">      
        <h5 class="card-header text-muted">
            List Event
        </h5>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty eventsOfUser}">
                    <div class="list-group list-group-flush">
                        <c:forEach items="${eventsOfUser}" var="event">
                            <a href="home?eventId=${event.getId()}&eventDetail=show" class="list-group-item">

                                <c:choose>
                                    <c:when test="${empty event.getTitle()}">
                                        <div class="fw-bold">(No title)</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="fw-bold">${event.getTitle()}</div>
                                    </c:otherwise>
                                </c:choose>                               

                                <div class="me-auto d-flex justify-content-between align-items-start"> 
                                    ${event.startDate}                                
                                    <c:choose>
                                        <c:when test="${event.getStatus() eq 'ONGOING'}">
                                            <span class="badge bg-success rounded-pill">${event.getStatus()}</span>
                                        </c:when>
                                        <c:when test="${event.getStatus() eq 'WAITING'}">
                                            <span class="badge bg-secondary rounded-pill">${event.getStatus()}</span>
                                        </c:when>
                                        <c:when test="${event.getStatus() eq 'FINISHED'}">
                                            <span class="badge bg-danger rounded-pill">${event.getStatus()}</span>
                                        </c:when>
                                    </c:choose>
                                </div>                           
                            </a>                           
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="d-flex justify-content-center align-items-center">
                        Nothing event for the category
                    </div>
                </c:otherwise>
            </c:choose>                                         
        </div>
    </div>
</main>
<section class="col-md-4 pt-1">                  
    <div class="card" >
        <h5 class="card-header text-muted">
            Event Detail
        </h5>       
        <c:choose>
            <c:when test="${not empty eventOfOrganizer}">
                <div class="card-body">
                    <ul class="list-group list-group-flush">               
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-calendar4-event"></i>
                            <span class="fw-bold mx-2">
                                ${eventOfOrganizer.getTitle()}
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-clock"></i>
                            <span class="mx-2">
                                <span>${eventOfOrganizer.getStartDate()}</span>
                                <span class="mx-2">${eventOfOrganizer.getEndDate()}</span>
                            </span>  
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-geo-alt"></i>
                            <span class="mx-2">
                                ${eventOfOrganizer.getLocation()}
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-person"></i>
                            <span class="mx-2"> 
                                <div class="text-muted">Organizer</div>
                                <div class="my-1">
                                    <div>${organizer.getUsername()}</div>
                                    <small>Sent on<span class="mx-1">${eventOfOrganizer.getCreatedAt()}</span></small>                                  
                                </div>                           
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-people"></i>
                            <span class="mx-2"> 
                                <div class="text-muted">Attendees</div>
                                <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1" style="cursor: pointer">
                                    <i class="bi bi-chevron-right"></i>
                                    <span>Accept:</span> <span class="mx-1">${acceptCount}</span>
                                    <ol class="collapse" id="collapse1">
                                        <c:forEach items="${usersAccept}" var="userAccept">
                                            <li class="my-1">${userAccept.getUsername()}</li>
                                        </c:forEach>                                                 
                                    </ol>
                                </div>

                                <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2" style="cursor: pointer">
                                    <i class="bi bi-chevron-right"></i>
                                    <span>Acceptable:</span> <span class="mx-1">${acceptableCount}</span>
                                    <ol class="collapse" id="collapse2">
                                        <c:forEach items="${usersAcceptable}" var="userAcceptable">
                                            <li class="my-1">${userAcceptable.getUsername()}</li>
                                            </c:forEach>  
                                    </ol>
                                </div>                       

                                <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3" style="cursor: pointer">
                                    <i class="bi bi-chevron-right"></i>
                                    <span>Reject:</span> <span class="mx-1">${rejectCount}</span>
                                    <ol class="collapse" id="collapse3">
                                        <c:forEach items="${usersReject}" var="userReject">
                                            <li class="my-1">${userReject.getUsername()}</li>
                                        </c:forEach>
                                    </ol>
                                </div>

                            </span>
                        </li>

                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-card-text"></i>
                            <span class="mx-2">
                                ${eventOfOrganizer.getDescription()} 
                            </span>
                        </li>
                        <li class="list-group-item mt-3">
                            <form action="home" method="post">
                                <input type="hidden" name="evenId" value="${eventOfOrganizer.getId()}">
                                <input class="btn btn-outline-primary" type="submit" value="Edit" data-bs-toggle="modal" data-bs-target="#modalEditEvent">                                                                   
                                <input class="btn btn-outline-secondary mx-2" type="submit" value="Delete" data-bs-toggle="modal" data-bs-target="#modalDeleteEvent">
                                <jsp:include page="../editEvent.jsp"></jsp:include>        
                                <jsp:include page="../deleteEvent.jsp"></jsp:include>
                                </form>
                            </li>
                        </ul>
                    </div>
            </c:when>
            <c:when test="${not empty eventOfAttendees}">
                <div class="card-body">                   
                    <ul class="list-group list-group-flush">               
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-calendar4-event"></i>
                            <span class="fw-bold mx-2">
                                ${eventOfAttendees.getTitle()}
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-clock"></i>
                            <span class="mx-2">
                                <span>${eventOfAttendees.getStartDate()}</span>
                                <span class="mx-1">${eventOfAttendees.getEndDate()}</span>
                            </span> 
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-geo-alt"></i>
                            <span class="mx-2">
                                ${eventOfAttendees.getLocation()}
                            </span>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-person"></i>
                            <span class="mx-2">
                                <div><span>${organizer.getUsername()}</span> <span class="mx-1">is the organizer</span></div>
                                <small>
                                    <c:choose>
                                        <c:when test="${attendee.getRole() == 'ACCEPT'}">
                                            You have accepted
                                        </c:when>
                                        <c:when test="${attendee.getRole() == 'ACCEPTABLE'}">
                                            You have temporarily accepted
                                        </c:when>
                                        <c:when test="${attendee.getRole() == 'REJECT'}">
                                            You refused
                                        </c:when>
                                        <c:otherwise>
                                            You have not responded yet
                                        </c:otherwise>
                                    </c:choose>
                                </small>  
                            </span>   
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-card-text"></i>
                            <span class="mx-2">
                                ${eventOfAttendees.getDescription()} 
                            </span>
                        </li>
                        <li class="list-group-item mt-3 d-flex justify-content-start">
                            <form action="home" method="post">
                                <input type="hidden" name="eventId" value="${eventOfAttendees.getId()}">
                                <input class="btn btn-outline-success mx-1" type="submit" value="Accept">                                      
                                <input class="btn btn-outline-secondary" type="submit" value="Acceptable">
                                <input class="btn btn-outline-danger mx-1" type="submit" value="Reject">
                            </form>
                        </li>
                    </ul>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card-body">
                    <p class="card-text d-flex justify-content-center align-items-center">Nothing event for the day</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>                
</section>


