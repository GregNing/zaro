// (function () {
//     slideup();
// })();
$(document).on('turbolinks:load', function () {
    slideup();    
});
function slideup() {
    let alertflash = document.getElementById("alert-flash");
    if (alertflash !== null) {
        delay().then(() => {
            alertflash.classList.toggle('alert-hide');
            return delay(1400);
        }).then(() => {
            alertflash.remove();
            return delay(1600);
        });
    }
}