<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="modal fade" id="exampleModalAddEvent" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">New Event</h5>
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
                            <i class="bi bi-person m-1"></i>                        
                            <select class="form-select" id="single-select-field-add" data-placeholder="Organizer"  style="width: 100%">
                                <option></option>
                                <option>Reactive</option>
                                <option>Solution</option>
                                <option>Conglomeration</option>
                                <option>Algoritm</option>
                                <option>Holistic</option>
                            </select>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-people m-1"></i>                         
                            <select class="form-select" id="multiple-select-field-add" data-placeholder="Invite attendees" multiple style="width: 100%">
                                <option>Christmas Island</option>
                                <option>South Sudan</option>
                                <option>Jamaica</option>
                                <option>Kenya</option>
                                <option>French Guiana</option>
                                <option>Mayotta</option>
                                <option>Liechtenstein</option>
                                <option>Denmark</option>
                                <option>Eritrea</option>
                                <option>Gibraltar</option>
                                <option>Saint Helena, Ascension and Tristan da Cunha</option>
                                <option>Haiti</option>
                                <option>Namibia</option>
                                <option>South Georgia and the South Sandwich Islands</option>
                                <option>Vietnam</option>
                                <option>Yemen</option>
                                <option>Philippines</option>
                                <option>Benin</option>
                                <option>Czech Republic</option>
                                <option>Russia</option>
                            </select>
                        </li>
                        <li class="list-group-item d-flex justify-content-start">
                            <i class="bi bi-card-text m-1"></i>
                            <textarea class="form-control" id="editor" rows="3" placeholder="Add description" style="border: none"></textarea>
                        </li>                      
                    </ul>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button">
                        <i class="bi bi-floppy"></i>
                        <span>Save</span>
                    </button>
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg"></i>
                        <span>Cancel</span>
                    </button>                  
                </div>
            </form>
        </div>
    </div>
</div>
