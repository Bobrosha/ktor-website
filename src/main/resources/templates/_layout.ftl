<#macro header>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>Kotlin Shulte Event</title>
    </head>
    <body style="text-align: center; font-family: sans-serif; -moz-user-select: none; -webkit-user-select: none; user-select: none">
    <#--noinspection HtmlUnknownTarget-->
    <a href="/"><img src="/static/ktor_logo.png" alt="logo"></a>
    <h1>Kotlin Ktor</h1>
    <p><i>Powered by Ktor & Freemarker!</i></p>
    <hr>
    <#nested>
    <div id="getBack" style="position: relative; width: 25vw; height: auto; transition: left 3s;">
        <a href="/">Back to the main page</a>
    </div>
    <div id="getMetrics" style="position: relative; width: 25vw; height: auto; transition: left 3s;">
        <a href="/">Show metrics</a>
    </div>
    <script type="text/javascript">
        const blockGetBack = document.getElementById("getBack");
        const blockGetMetrics = document.getElementById("getMetrics");

        setInterval(move, 3000)
        <#--noinspection ES6ConvertVarToLetConst-->
        var moved = false;

        function move() {
            if (moved) {
                moved = false;
                blockGetBack.style.left = "70vw";
                blockGetMetrics.style.left = "0vw";
            } else {
                moved = true;
                blockGetBack.style.left = "0vw"
                blockGetMetrics.style.left = "70vw";
            }
        }
    </script>
    </body>
    </html>
</#macro>