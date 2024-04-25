

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAddEvent">
                        <i class="bi bi-calendar"></i>
                        <span>New Event</span>
                    </button>
                    <jsp:include page="../addEvent.jsp"></jsp:include>

                    </li>
<!--                    <li class="nav-item dropdown mx-2">                       
                        <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside">
                            <i class="bi bi-funnel"></i>
                            <span>Filter</span>
                        </button>
                        <form class="dropdown-menu dropend p-4" style="width: 200px;">
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="day">
                                    <label class="form-check-label" for="dropdownCheck2">DAY</label>
                                </div>
                            </div>
                            
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="week">
                                    <label class="form-check-label" for="dropdownCheck2">WEEK</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="month">
                                    <label class="form-check-label" for="dropdownCheck2">MONTH</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="ongoing">
                                    <label class="form-check-label" for="dropdownCheck2">ONGOING</label>
                                </div>
                            </div>
                            
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="waiting">
                                    <label class="form-check-label" for="dropdownCheck2">WAITING</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="finished">
                                    <label class="form-check-label" for="dropdownCheck2">FINISHED</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="accept">
                                    <label class="form-check-label" for="dropdownCheck2">ACCEPT</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="acceptable">
                                    <label class="form-check-label" for="dropdownCheck2">ACCEPTABLE</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="reject">
                                    <label class="form-check-label" for="dropdownCheck2">REJECT</label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check dropend">
                                    <input type="checkbox" class="form-check-input" id="dropdownCheck2" name="filter" value="notResponded">
                                    <label class="form-check-label" for="dropdownCheck2">NOT RESPONDED</label>
                                </div>
                            </div>
                            
                            <input type="submit" name="sendFilter" value="Send" class="btn btn-primary">
                            
                        </form>
                    </li>    -->
                </ul>
                <form class="d-flex" role="search" action="home" method="get">
                    <input class="form-control me-2" type="search" name="keywordSearch" id="keywordSearch" value="${keywordSearch}" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-primary" type="submit" >Search</button>
                </form>
        </div>
    </div>
</nav>



