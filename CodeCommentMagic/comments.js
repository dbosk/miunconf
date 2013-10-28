$("#codeView").dblclick(newComment);
$(function() {
    $("#codeComments").draggable();
});


/**
    Disable text selection by Chris Barr, of chris-barr.com
*/
$.fn.disableTextSelect = function() {
    return this.each(function(){
        //if($.browser.mozilla){//Firefox
            $(this).css('MozUserSelect','none');
        //}else if($.browser.msie){//IE
        //    $(this).bind('selectstart',function(){return false;});
        //}else{//Opera, etc.
        //    $(this).mousedown(function(){return false;});
        //}
    });
}
function newComment(event) {
    left = (event.pageX + 10) + "px";
    right = (event.pageY + 10) + "px";

    $("#codeComments").css("left", left);
    $("#codeComments").css("top", right);
    
    event.target.style.color ="black";
    event.target.style.backgroundColor = "green";
    event.target.opacity = "1.0";
    //alert( (event.clientX +10) + "px" );
    event.defaultPrevented = true;
    event.stopPropagation();
    
    return false;
}



