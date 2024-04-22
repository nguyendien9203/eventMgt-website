<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<main class="col-md-6">
    <div class="row row-cols-2">
        <c:forEach items="${categories}" var="category">
            <div class="col p-1">           
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title d-flex justify-content-between">
                            <span>${category.getCategoryName()}</span>
                            <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalEditCategory">Edit</a></li>
                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalDeleteCategory">Delete</a></li>
                            </ul>
                            <jsp:include page="../editCategory.jsp"></jsp:include>
                            <jsp:include page="../deleteCategory.jsp"></jsp:include>
                            </h5>
                            <div class="list-group list-group-flush">
                            <c:forEach items="${events}" var="event">
                                <c:if test="${category.getId() eq event.getCategoryId()}">
                                    <a href="home?eventId=${event.getId()}&eventDetail=show" class="list-group-item">
                                        <div class="fw-bold">${event.getTitle()}</div>
                                        <div class="me-auto d-flex justify-content-between align-items-start">                               
                                            ${event.getStartDate()}
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
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="col p-1">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title d-flex justify-content-between">
                        <span>Card title</span>
                        <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-three-dots"></i>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalEditCategory">Edit</a></li>
                            <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalDeleteCategory">Delete</a></li>
                        </ul>
                        <jsp:include page="../editCategory.jsp"></jsp:include>
                        <jsp:include page="../deleteCategory.jsp"></jsp:include>
                        </h5>
                        <div class="d-flex justify-content-center align-items-center">
                            Nothing event for the category
                        </div>
                    </div>
                </div>
            </div>
            <div class="col p-1">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title d-flex justify-content-between">
                            <span>Other</span>
                            <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-three-dots"></i>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalEditCategory">Edit</a></li>
                                <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalDeleteCategory">Delete</a></li>
                            </ul>
                        <jsp:include page="../editCategory.jsp"></jsp:include>
                        <jsp:include page="../deleteCategory.jsp"></jsp:include>
                        </h5>
                        <div class="list-group list-group-flush">
                            <a href="#" class="list-group-item">
                                <div class="fw-bold">Sự kiện của tôi ưeefsdfdf</div>
                                <div class="me-auto d-flex justify-content-between align-items-start">                               
                                    12:00 - 30p 
                                    <span class="badge bg-secondary rounded-pill">Waiting</span>
                                </div>                           
                            </a>
                            <a href="#" class="list-group-item">
                                <div class="fw-bold">Sự kiện của tôi ưeefsdfdf</div>
                                <div class="me-auto d-flex justify-content-between align-items-start">                               
                                    12:00 - 30p 
                                    <span class="badge bg-success rounded-pill">On going</span>
                                </div>                           
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <section class="col-md-4 pt-1">                  
        <div class="card" style="height: 100%">
            <h5 class="card-header text-muted">
                Event Detail
            </h5>
            <div class="card-body d-none">
                <p class="card-text d-flex justify-content-center align-items-center">Nothing event for the day</p>
            </div>
            <div class="card-body  d-none">
                <ul class="list-group list-group-flush">               
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-calendar4-event"></i>
                        <span class="fw-bold mx-2">
                            Sự kiện của tôi
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-clock"></i>
                        <span class="mx-2">
                            <span>Tue 4/16/2024</span>
                            <span>10:30 AM - 11:30 AM</span>
                        </span>  
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-geo-alt"></i>
                        <span class="mx-2">
                            Aptech Computer Education; FPT University Ha Noi; FPT University Ha Noi; FPT University Ha Noi
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-person"></i>
                        <span class="mx-2"> 
                            <div class="text-muted">Organizer</div>
                            <div class="my-2">
                                <div>diennvhe171038</div>
                                <small>Sent on Wednesday, 2024-04-17 at 10:59 AM</small>                                  
                            </div>                           
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-people"></i>
                        <span class="mx-2"> 
                            <div class="text-muted">Attendees</div>
                            <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="false" aria-controls="collapse1" style="cursor: pointer">
                                <i class="bi bi-chevron-right"></i>
                                <span>Accept:</span> <span class="mx-1">1</span>
                                <ol class="collapse" id="collapse1">
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                </ol>
                            </div>

                            <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="false" aria-controls="collapse2" style="cursor: pointer">
                                <i class="bi bi-chevron-right"></i>
                                <span>Acceptable:</span> <span class="mx-1">1</span>
                                <ol class="collapse" id="collapse2">
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                </ol>
                            </div>                       

                            <div class="my-1" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="false" aria-controls="collapse3" style="cursor: pointer">
                                <i class="bi bi-chevron-right"></i>
                                <span>Reject:</span> <span class="mx-1">1</span>
                                <ol class="collapse" id="collapse3">
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                    <li class="my-1">diennvhe171038</li>
                                </ol>
                            </div>

                        </span>
                    </li>

                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-card-text"></i>
                        <span class="mx-2">
                            Đây là phần mô tả hdif sfhssfn shdvi nssidvj isndvi 
                        </span>
                    </li>
                    <li class="list-group-item mt-3">

                        <a class="btn btn-outline-primary" type="button" href="updateEvent.jsp" data-bs-toggle="modal" data-bs-target="#modalEditEvent">
                            <i class="bi bi-pencil mr-2"></i>
                            <span>Edit</span>
                        </a>
                    <jsp:include page="../editEvent.jsp"></jsp:include>
                        <a class="btn btn-outline-secondary mx-2" type="button" href="#" data-bs-toggle="modal" data-bs-target="#modalDeleteEvent">
                            <i class="bi bi-calendar-x mr-2"></i>
                            <span>Delete</span>
                        </a>
                    <jsp:include page="../deleteEvent.jsp"></jsp:include>


                </li>
            </ul>
        </div>
        <div class="card-body">
            <form>
                <ul class="list-group list-group-flush">               
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-calendar4-event"></i>
                        <span class="fw-bold mx-2">
                            Sự kiện của tôi
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-clock"></i>
                        <span class="mx-2">
                            <span>T4 2024-04-03</span>
                            <span>6:30 CH - 8:30 CH</span>
                            <span>Chuỗi</span>
                            <i class="bi bi-arrow-repeat"></i>
                        </span>  
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-geo-alt"></i>
                        <span class="mx-2">
                            Aptech Computer Education; FPT University Ha Noi; FPT University Ha Noi; FPT University Ha Noi
                        </span>
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-person"></i>
                        <span class="mx-2">
                            <div>diennvhe171038 là người tổ chức</div>
                            <small>Bạn chưa phản hồi; Bạn đã tạm chấp nhận; diennvhe171038 đã từ chối</small>  
                        </span>   
                    </li>
                    <li class="list-group-item d-flex justify-content-start">
                        <i class="bi bi-card-text"></i>
                        <span class="mx-2">
                            Đây là phần mô tả hdif sfhssfn shdvi nssidvj isndvi 
                        </span>
                    </li>
                    <li class="list-group-item mt-3 d-flex justify-content-start">
                        <i class="bi bi-reply"></i>
                        <button class="btn btn-outline-success mx-1" type="submit">
                            <i class="bi bi-check2"></i>
                            <span>Accept</span>
                        </button>
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="bi bi-question-lg"></i>
                            <span>Acceptable</span>
                        </button>
                        <button class="btn btn-outline-danger mx-1" type="submit">
                            <i class="bi bi-x-lg"></i>
                            <span>Reject</span>
                        </button>

                    </li>
                </ul>
            </form>
        </div>
    </div>                
</section>


