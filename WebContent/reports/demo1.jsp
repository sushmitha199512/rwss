<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" dir="ltr">
<head>
<title>RWSS-WATERSOFT</title>


<style type="text/css">
/* --------
  The CSS rules offered here are just an example, you may use them as a base. 
  Shape your 'expand/collapse' content so that it meets the style of your site. 
 --------- */
* {margin:0; padding:0}
/* --- Page Structure  --- */
html {height:100%}
body {
  min-width:400px;
  width:100%;
  height:101%;
  background:#fff;
  color:#333;
  font:76%/1.6 verdana,geneva,lucida,'lucida grande',arial,helvetica,sans-serif;
  text-align:center
}
#wrapper{
  margin:0 auto;
  padding:15px 15%;
  text-align:left
}
#content {
  max-width:70em;
  width:100%;
  margin:0 auto;
  padding-bottom:20px;
  overflow:hidden
}
.demo {
  margin:0;
  padding:1.5em 1.5em 0.75em;
  border:1px solid #ccc;
  position:relative;
  overflow:hidden
}
.collapse p {padding:0 10px 1em}
.top{font-size:.9em; text-align:right}
#switch, .switch {margin-bottom:5px; text-align:right}

/* --- Headings  --- */
h1 {
  margin-bottom:.75em; 
  font-family:georgia,'times new roman',times,serif; 
  font-size:2.5em; 
  font-weight:normal; 
  color:#c30
}
h2{font-size:1em}

.expand{padding-bottom:.75em}

/* --- Links  --- */
a:link, a:visited {
  border:1px dotted #ccc;
  border-width:0 0 1px;
  text-decoration:none;
  color:blue
}
a:hover, a:active, a:focus {
  border-style:solid;
  background-color:#f0f0f0;
  outline:0 none
}
a:active, a:focus {
  color:red;
}
.expand a {
  display:block;
  padding:3px 10px
}
.expand a:link, .expand a:visited {
  border-width:1px;
  background-image:url(/pred/images/arrow-down.gif);
  background-repeat:no-repeat;
  background-position:98% 50%;
}
.expand a:hover, .expand a:active, .expand a:focus {
  text-decoration:underline
}
.expand a.open:link, .expand a.open:visited {
  border-style:solid;
  background:#eee url(/pred/images/arrow-up.gif) no-repeat 98% 50%
}
</style>
<!--[if lte IE 7]>
<style type="text/css">
h2 a, .demo {position:relative; height:1%}
</style>
<![endif]-->

<!--[if lte IE 6]>
<script type="text/javascript">
   try { document.execCommand( "BackgroundImageCache", false, true); } catch(e) {};
</script>
<![endif]-->
<!--[if !lt IE 6]><!-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="/pred/resources/javascript/expand.js"></script>

<script type="text/javascript">
<!--//--><![CDATA[//><!--
$(function() {
    // --- Using the default options:
   // $("h2.expand").toggler();
    // --- Other options:
    //$("h2.expand").toggler({method: "toggle", speed: 0});
    //$("h2.expand").toggler({method: "toggle"});
    //$("h2.expand").toggler({speed: "fast"});
    $("h2.expand").toggler({method: "fadeToggle"});
    //$("h2.expand").toggler({method: "slideFadeToggle"});    
    $("#content").expandAll({trigger: "h2.expand", ref: "div.demo", localLinks: "p.top a"});
});
//--><!]]>
</script>
<!--<![endif]-->
</head>

<body>
    <div id="wrapper"> 
      <div id="content">  
        <h1 class="heading">jQuery experiments: Expand/Collapse demo</h1>
          <div class="demo">
            <h2 class="expand">Title 1</h2>
            <div class="collapse">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Title 2</h2>
            <div class="collapse">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Title 3</h2>
            <div class="collapse">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Title 4</h2>
            <div class="collapse">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
            <h2 class="expand">Title 5</h2>
            <div class="collapse">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore 
                et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip 
                ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore 
                eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa 
                qui officia deserunt mollit anim id est laborum.</p>
                <p class="top"><a href="#content">Top of page</a></p>
            </div>
          </div>
        </div>
    </div>
</body>
</html>