
function chatting(){

    let url="Chat"; // ?p_id="+"${product.p_id}
    let w = 450;
    let h = 600;
    let popupX = (window.screen.width/2)-(w/2);
    let popupY = (window.screen.height/2)-(h/2);;

    window.open(url, '_blank_1',
		'toolbar=no, menubar=no, scrollbars=yes, resizeable=no'+
		', width='+w+', height='+h+', left='+popupX+', top='+popupY);

}

function eixt(){
	self.close();
}