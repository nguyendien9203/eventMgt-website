<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.0/dist/jquery.slim.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
    $('#multiple-select-field-add-attendees').select2({
        theme: 'bootstrap-5'
    });
</script>
<script>
    $('#single-select-field-add-organizer').select2({
        theme: 'bootstrap-5'
    });
</script>

<script>
    $('#single-select-field-edit-organizer').select2({
        theme: 'bootstrap-5'
    });
</script>

<script>
    $('#multiple-select-field-edit-attendees').select2({
        theme: 'bootstrap-5'
    });
</script>

<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        var toasts = document.querySelectorAll('.toast');
        var offset = 0;
        toasts.forEach(function (toast) {
            var bsToast = new bootstrap.Toast(toast);
            bsToast.show();
            // Di chuyển toast
            toast.style.transform = 'translateY(' + offset + 'px)';
            offset += toast.offsetHeight + 10;
        });
    });
</script>



