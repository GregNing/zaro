$(document).on('turbolinks:load', function () {
    if (document.getElementById('products-index') !== null && document.getElementById('products-index') !== undefined)
    {        
        let counter = 0, // 一開始要顯示的圖，0 的話就是顯示第一張
            slide = document.querySelector('.link_to_pic_products'),
            items = slide.querySelectorAll('a'), // 抓取所有 link img
            itemsCount = items.length, // 圖片總數 
            prevBtn = document.createElement('a'), // 上一張按鈕
            nextBtn = document.createElement('a'), // 下一張按鈕
            timer = 4000, // 4 秒換圖
            interval = window.setInterval(showNext, timer), // 設定循環
            buttoproducts = slide.querySelectorAll('li'); //設定button點選連結至商品

        prevBtn.classList.add('prev'); // 幫上一張按鈕加 class＝"prev" 給 CSS 指定樣式用
        nextBtn.classList.add('next'); // 幫下一張按鈕加 class＝"next" 給 CSS 指定樣式用
        slide.appendChild(prevBtn); // 將按鈕加到 #slide 裡
        slide.appendChild(nextBtn);

        // 帶入目前要顯示第幾張圖 
        let showCurrent = function () {
            let itemToShow = Math.abs(counter % itemsCount); // 取餘數才能無限循環
            [].forEach.call(items, (el) => {
                el.children[0].classList.remove('show'); // 將所有 img 的 class="show" 移除
            });
            buttoproducts.forEach((item) => {
                item.children[0].classList.remove('show'); 
            });
            buttoproducts[itemToShow].children[0].classList.add('show');
            items[itemToShow].children[0].classList.add('show'); // 將要顯示的 img 加入 class="show"
        };

        function showNext() {
            counter++; // 將 counter+1 指定下一張圖
            showCurrent();
        }

        function showPrev() {
            counter--; // 將 counter－1 指定上一張圖
            showCurrent();
        }

        // 滑鼠移到 #slider 上方時，停止循環計時
        slide.addEventListener('mouseover', function () {
            interval = clearInterval(interval);
        });

        // 滑鼠離開 #slider 時，重新開始循環計時
        slide.addEventListener('mouseout', function () {
            interval = window.setInterval(showNext, timer);
        });

        // 綁定點擊上一張，下一張按鈕的事件
        nextBtn.addEventListener('click', showNext, false);
        prevBtn.addEventListener('click', showPrev, false);
        // 一開始秀出第一張圖，也可以在 HTML 的第一個 img 裡加上 class="show"
        items[0].children[0].classList.add('show');
        //一開始直接顯示第一個button顏色
        buttoproducts[0].children[0].classList.add('show');
        //點選按鈕啟動
        buttoproducts.forEach((item,index) => {  
            item.children[0].addEventListener("click", function () {
                counter = index;
                showCurrent();
            });
        });
    }
    
    if (document.getElementById('products-show') !== null && document.getElementById('products-show') !== undefined) 
    {
        function DropDownfor(el) {
            this.siezslect = el;
            this.placeholder = this.siezslect.children('span');
            this.opts = this.siezslect.find('ul.select_list > li');
            this.val = '';
            this.index = -1;
            this.initEvents();
        }
        DropDownfor.prototype = {
            initEvents: function () {
                let obj = this;

                obj.siezslect.on('click', function (event) {                    
                    $(this).toggleClass('active');                                        
                });
                obj.opts.on('click', function () {                    
                    let opt = $(this);
                    obj.val = opt.text();
                    obj.index = opt.index();
                    obj.placeholder.text(obj.val);
                    document.getElementsByClassName('size-info')[0].children[0].innerHTML = obj.val;
                    document.getElementById('size').value = obj.val;
                    let cartElement = document.getElementById('add_to_cart');
                    if (cartElement.innerText === "請選擇尺寸") {                        
                        let i = document.createElement("i");
                        i.classList.add('fa', 'fa-cart-arrow-down');
                        i.innerText = "ADD TO CART";
                        cartElement.firstChild.replaceWith(i);
                        cartElement.setAttribute('data-original-title',"加入購物車");
                    }                    
                });
            },
            getValue: function () {
                return this.val;
            },
            getIndex: function () {
                return this.index;
            }
        }
        
        let siezslect = new DropDownfor($('#wrapper_select_text'));
        $(document).click(function () {            
            $('.wrapper_select_text').removeClass('active');
        });
        document.getElementById('wrapper_select_text').addEventListener('mouseenter', (event) => {
            document.getElementById('wrapper_select_text').classList.add('active');
            event.preventDefault();
        }, false);
        document.getElementById('wrapper_select_text').addEventListener('mouseleave', (event) => {
            document.getElementById('wrapper_select_text').classList.remove('active');
            event.preventDefault();
        }, false);
        //設定點選商品訂購數量--
        document.getElementById('quantity-minus').addEventListener('click', (e) => {
            setquantity(2);
            e.preventDefault();
        }, false)
        //設定點選商品訂購數量++
        document.getElementById('quantity-plus').addEventListener('click', (e) => {
            setquantity(1);
            e.preventDefault();
        }, false)
        //plusormine = 1 代表 要加++ = 2 代表 --
        function setquantity(plusormine){
            let quantityelement = document.getElementById('quantity-input'); 
            let quantity = parseInt(quantityelement.value);
            let minus = document.getElementById('quantity-minus');
            let plus = document.getElementById('quantity-plus');
            if (plusormine === 1) {
                let max = parseInt(quantityelement.getAttribute('max'));
                quantity ++;
                quantity >= max ? ((quantityelement.value = max), (quantityelement.disabled = true),
                                (plus.classList.add('disabled'))) :
                                ((quantityelement.value = quantity), (quantityelement.disabled = false),
                                (minus.classList.remove('disabled')));
            }
            else if (plusormine === 2){
                quantity > 1 ? ((quantity --), (quantityelement.value = quantity),
                                (plus.classList.remove('disabled'), 
                                (quantityelement.disabled = false))) : 
                                ((quantityelement.disabled = true), 
                                (minus.classList.add('disabled')),
                                (quantityelement.value = 1));
            }
        };
        //plusormine end
        //輸入時限制數字
        function parseToInt(value) {            
            while (value.match(/[^\d]/)) {
                value = value.replace(/[^\d]/, '');
            }
            //回傳數字            
            return parseInt(value == '' ? 0 : value);
        };
        //輸入數量時加入檢查
        document.getElementById('quantity-input').addEventListener('input', function () {
            let max = this.getAttribute('max');
            let inputvalue = parseToInt(this.value);
            inputvalue <= 1 ? ((this.value = 1), (document.getElementById('quantity-minus').classList.add('disabled'))) :
                document.getElementById('quantity-minus').classList.remove('disabled');
            inputvalue >= max ? ((this.value = max), (document.getElementById('quantity-plus').classList.add('disabled'))) :
                document.getElementById('quantity-plus').classList.remove('disabled');
            this.value === '' && (this.value = 1)
        });
        let commitparams = document.getElementById('commit');
        //使用 javascript click送出加入購物車
        document.getElementById('add_to_cart').addEventListener('click', function (e) {        
            commitparams.value = this.value;            
            $("#add_to_cart").trigger('submit.rails');
            e.preventDefault(); 
        });
        //使用 javascript click送出加入購物車
        document.getElementById('buy_product').addEventListener('click', function (e) {
            commitparams.value = this.value;
            $("#buy_product").trigger('submit.rails');
            e.preventDefault();
        });                
    }    
 
});
//===================== products show

var confirm = (function () {
    var dialog = document.getElementById('confirm-dialog');
    //移除購物車(單一)
    let confirmRemoveCartItem = (id, message) => {
        if (message !== undefined && message !== "") {
            
            dialog.querySelector(".modal-body").innerHTML = message;
        }
        dialog.querySelector(".btn-confirm").addEventListener('click',
            (e) => { console.log(e); e.preventDefault(); }, false);
    }
    return {
        confirmRemoveCartItem: confirmRemoveCartItem,

    };
}());
