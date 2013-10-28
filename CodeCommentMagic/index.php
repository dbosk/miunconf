 <!DOCTYPE HTML>
 <html>
    <head>
 <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>        
        <title>C</title>
        <link type="text/css" rel="stylesheet" href="codestyle.css" /> 
<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>
        <script src="carousel.js" type="text/javascript"></script>
        <script type="text/javascript" >

        </script>
    </head>

    <body>
        <div id="codeView">

            <span id="leftButton"><a id="leftAnchor" name=""><img id="leftButtonImage" src="left.png"/></a></span>
            <span id="rightButton" onclick="getFile('main.cpp','codeSection')"><a id="rightAnchor" name=""><img id="rightButtonImage" src="right.png"/></a></span>
            <div id="codeTitle">
                <br/>
            </div>
            <pre class="prettyprint lang-cpp" id="codeSection">
                        <pre id="overlay"></pre>
&#35;include&lt;iostream&gt;
main
int main(){
    cout&lt;&lt;"hello";
}
            </pre>
            <div id="codeFooter">
                
            </div>
            <div id="codeComments">
                <form id="draggable-form" class="ui-widget-content draggable-holder">
                    <input id="codeCommentInfo" type="textarea" cols="80" rows="4"/>
                    <br/>
                    <input type="submit" value="Skicka kommentar"/>
                </form>
            </div>
        </div>
        <script src="comments.js" type="text/javascript"></script>        
    </body>
</html>
