// (function () {
//     setsidebaractive(); 
// })();
$(document).on('turbolinks:load', function () {
    setsidebaractive();
});

function setsidebaractive() {
    let list = document.getElementsByClassName('sidebar-nav')[0].children;
    for (let value of list) {
        value.onclick = () => {
            let liactive = document.querySelectorAll('.sidebar-nav .active');
            liactive.length > 0 && liactive[0].classList.remove("active")
            value.className += "active";           
        }
    }
}