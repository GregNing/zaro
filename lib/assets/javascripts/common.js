// (function () {
//     slideup();
// })();
$(document).on('turbolinks:load', function () {
    slideup();
});

function delay(s) {
    return new Promise((resolve, reject) => {
        setTimeout(resolve, s);
    });
};

function slideup() {
    let alertflash = document.getElementById("alert-flash");
    if (alertflash !== null) {
        delay().then(() => {
            alertflash.classList.toggle('alert-hide');
            return delay(1200);
        }).then(() => {
            alertflash.remove();
            return delay(1400);
        });
    }
}