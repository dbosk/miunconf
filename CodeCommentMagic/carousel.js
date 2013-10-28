/* 
 */
var files = new Array();
files['0'] = "main.cpp";
 

function getFile( fileName, elementId ){
    var request = XMLHttpRequest();
    //request.onload = requestProcessor(elementId);
    request.overrideMimeType("text/plain; charset=x-user-defined");
//    request.addEventListener("progress", updateProgress, false);
    request.addEventListener("load", transferComplete(elementId, request), false);
//    request.addEventListener("error", transferFailed, false);
//    request.addEventListener("abort", transferCanceled, false);
    request.open("get", fileName, true);
    request.send();
    $('#codeTitle').html(fileName);
}

function transferComplete(elementId, request){
    return function(evt){
        $('#'+elementId).removeClass('prettyprinted');
        // Replace < and > to entities
        var code = request.responseText.replace(/</g,'&lt;').replace(/>/g,'&gt;');
        var lines = code.split("\r").length;
        oLay = $('#overlay').clone(); // #overlay is about to be removed
        oLay.empty();
        for( var i = 0; i< lines; i++){
            oLay.append('<div class="overlay-line">Kommentar:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>');
        }
        // Add code and prepend the highlight overlay.
        $('#'+elementId).html(code);
        PR.prettyPrint();
        oLay.width( $('#'+elementId).width() );
        $('#'+elementId).prepend(oLay);
        $("#codeView").dblclick(newComment);
        
        $('.overlay-line').disableTextSelect();
        
    }
}