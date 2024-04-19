

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModalAddEvent">
                        <i class="bi bi-calendar"></i>
                        <span>New Event</span>
                    </button>
                    <jsp:include page="../addEvent.jsp"></jsp:include>

                </li>
                <li class="nav-item mx-2">
                    <button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#exampleModalAddCategory">
                        <i class="bi bi-text-center"></i>
                        <span>New Category</span>
                    </button>
                    <jsp:include page="../addCategory.jsp"></jsp:include>
                </li>
                <li class="nav-item dropdown">
                    <button class="btn dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-funnel"></i>
                        <span>Filter</span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li class="m-1">
                            <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                            diennvhe171038
                        </li>
                        <li class="m-1">
                            <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                            ndien9203
                        </li>
                        <li class="m-1">
                            <input class="form-check-input mx-1" type="checkbox" value="" aria-label="...">
                            nguyendien9203
                        </li> 
                    </ul>
                </li>    
            </ul>
            <form class="d-flex" role="search">
                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-primary" type="submit">Search</button>
            </form>
        </div>
    </div>
</nav>
