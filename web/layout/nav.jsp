

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
                    <li class="nav-item dropdown mx-2">
                        <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-funnel"></i>
                            <span>Filter</span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                            <li class="m-1">
                                <div class="btn-group">
                                    <input type="checkbox">
                                    <button type="button" class="btn btn-danger">Action</button>
                                    <button type="button" class="btn btn-danger dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                        <span class="visually-hidden">Toggle Dropdown</span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="#">Action</a></li>
                                        <li><a class="dropdown-item" href="#">Another action</a></li>
                                        <li><a class="dropdown-item" href="#">Something else here</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="#">Separated link</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li class="m-1">
                                <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                                ONGOING
                            </li>
                            <li class="m-1">
                                <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                                FINISHED
                            </li> 
                            <li class="m-1">
                                <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                                DAY
                            </li>
                            <li class="m-1">
                                <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                                WEEK
                            </li>
                            <li class="m-1">
                                <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                                MONTH
                            </li> 
                        </ul>
                    </li>    
                </ul>
                <form class="d-flex" role="search" action="home" method="get">
                    <input class="form-control me-2" type="search" name="keywordSearch" id="keywordSearch" value="${keywordSearch}" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-primary" type="submit" >Search</button>
            </form>
        </div>
    </div>
</nav>



