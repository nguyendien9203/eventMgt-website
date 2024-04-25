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

                                <c:set var="startDate" value="${LocalDate.parse(event.getStartDate())}" />
                                <c:set var="endDate" value="${LocalDate.parse(event.getEndDate())}" />

                                <div class="me-auto d-flex justify-content-between align-items-start"> 
                                    ${event.startDate}                                
                                    <c:choose>
                                        
                                        <c:when test="${LocalDate.now().isBefore(startDate)}">
                                            <span class="badge bg-secondary rounded-pill">WAITING</span>
                                        </c:when>
                                        <c:when test="${LocalDate.now().isAfter(endDate)}">
                                            <span class="badge bg-danger rounded-pill">FINISHED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-success rounded-pill">ONGOING</span>
                                        </c:otherwise>
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
                                    
                                <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse3" style="cursor: pointer">
                                    <i class="bi bi-chevron-right"></i>
                                    <span>Not responded:</span> <span class="mx-1">${notRespondedCount}</span>
                                    <ol class="collapse" id="collapse4">
                                        <c:forEach items="${usersNotResponded}" var="notResponded">
                                            <li class="my-1">${notResponded.getUsername()}</li>
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
                            <button class="btn btn-outline-primary" type="button" data-bs-toggle="modal" data-bs-target="#modalEditEvent">
                                <i class="bi bi-pencil"></i>
                                <span>Edit</span>
                            </button>
                            <button class="btn btn-outline-secondary mx-1" type="button" data-bs-toggle="modal" data-bs-target="#modalDeleteEvent">
                                <i class="bi bi-calendar-x"></i>
                                <span>Delete</span>
                            </button>

                            <jsp:include page="../editEvent.jsp"></jsp:include>        
                            <jsp:include page="../deleteEvent.jsp"></jsp:include>

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
                                        <c:when test="${attendee.getStatusAttendees() == 'ACCEPT'}">
                                            You have accepted
                                        </c:when>
                                        <c:when test="${attendee.getStatusAttendees() == 'ACCEPTABLE'}">
                                            You have temporarily accepted
                                        </c:when>
                                        <c:when test="${attendee.getStatusAttendees() == 'REJECT'}">
                                            You rejected
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
                        <c:set var="endDateLocalDate" value="${LocalDate.parse(eventOfAttendees.getEndDate())}" />


                        <c:choose>
                            <c:when test="${LocalDate.now().isAfter(endDateLocalDate)}">
                                <li class="list-group-item mt-3 d-flex justify-content-start">
                                    The event has ended
                                </li>
                            </c:when>
                            <c:otherwise>

                                <li class="list-group-item mt-3 d-flex justify-content-start">
                                    <form action="home" method="post">
                                        <input type="hidden" name="eventId" value="${eventOfAttendees.getId()}">
                                        <input type="hidden" name="userId" value="${attendee.getId()}">
                                        <input class="btn btn-outline-success mx-1" type="submit" name="confirmStatusAttendees" value="Accept">                                      
                                        <input class="btn btn-outline-secondary" type="submit" name="confirmStatusAttendees" value="Acceptable">
                                        <input class="btn btn-outline-danger mx-1" type="submit" name="confirmStatusAttendees" value="Reject">
                                    </form>
                                </li>
                            </c:otherwise>
                        </c:choose>

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


