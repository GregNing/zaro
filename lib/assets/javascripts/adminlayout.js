(function () {
    setsidebaractive(); 
    slideup();
})();

function  delay(s){
    return new Promise((resolve, reject) => {
        setTimeout(resolve, s);
    });
};

function slideup(){
    let alertflash = document.getElementById("alert-flash");
    if (alertflash !== null)
    {
        delay().then(() => {
            alertflash.classList.toggle('alert-hide');
            return delay(1200);
        }).then(() => {
            alertflash.remove();
            return delay(1400);
        });
    }
}

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