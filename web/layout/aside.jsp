<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="col-md-2 pt-1">
    <h5 class="text-muted p-2">
        <i class="bi bi-person"></i>
        <span>Account</span>
    </h5>
    <form>
        <ul class="nav flex-column p-2">
            <li class="nav-item my-3 d-flex">
                <input class="form-check-input" type="checkbox" value="" aria-label="...">
                <span class="px-2 overflow-hidden-text" style="max-width: 140px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">diennvhe171038dsfjdskgjdg</span>
                <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-three-dots"></i>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalRemoveAccount">Remove</a></li>
                </ul>
            </li>
            <li class="nav-item my-3 d-flex">
                <input class="form-check-input" type="checkbox" value="" aria-label="...">
                <span class="px-2 overflow-hidden-text" style="max-width: 140px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">diennvhe171038dsfjdskgjdg</span>
                <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-three-dots"></i>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalRemoveAccount">Remove</a></li>
                </ul>
            </li>
            <li class="nav-item my-3 d-flex">
                <input class="form-check-input" type="checkbox" value="" aria-label="...">
                <span class="px-2 overflow-hidden-text" style="max-width: 140px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">diennvhe171038dsfjdskgjdg</span>
                <button type="button" class="btn" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-three-dots"></i>
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#modalRemoveAccount">Remove</a></li>
                </ul>
            </li>
            <jsp:include page="../removeAccount.jsp"></jsp:include>

        </ul>

        <a href="login" class="btn btn-primary my-4 m-2">
            <i class="bi bi-person-plus"></i>
            <span>New Account</span>
        </a>
    </form>
</aside>
