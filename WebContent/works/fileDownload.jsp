
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>jQuery File Tree Demo</title>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
		
		<style type="text/css">
			BODY,
			HTML {
				padding: 0px;
				margin: 0px;
			}
			BODY {
				font-family: Verdana, Arial, Helvetica, sans-serif;
				font-size: 11px;
				background: #EEE;
				padding: 15px;
			}
			
			H1 {
				font-family: Georgia, serif;
				font-size: 20px;
				font-weight: normal;
			}
			
			H2 {
				font-family: Georgia, serif;
				font-size: 16px;
				font-weight: normal;
				margin: 0px 0px 10px 0px;
			}
			
			.example {
				float: left;
				margin: 15px;
			}
			
			.demo {
				width: 200px;
				height: 400px;
				border-top: solid 1px #BBB;
				border-left: solid 1px #BBB;
				border-bottom: solid 1px #FFF;
				border-right: solid 1px #FFF;
				background: #FFF;
				overflow: scroll;
				padding: 5px;
			}
			
		</style>
		
		<script src="./resources/javascript/jquery.js" type="text/javascript"></script>
		<script src="./resources/javascript/jquery.easing.js" type="text/javascript"></script>
		<script src="./resources/javascript/jqueryFileTree.js" type="text/javascript"></script>
		<link href="./resources/javascript/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />
		
		<script type="text/javascript">
			
			$(document).ready( function() {
				
				$('#fileTreeDemo_1').fileTree({ root: '/pred/WebContent/downloads/bank\', script: 'jqueryFileTree.jsp' }, function(file) { 
					alert(file);
				});
				
				$('#fileTreeDemo_2').fileTree({ root: '../../demo/', script: 'connectors/jqueryFileTree.php', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, multiFolder: false }, function(file) { 
					alert(file);
				});
				
				$('#fileTreeDemo_3').fileTree({ root: '../../demo/', script: 'connectors/jqueryFileTree.php', folderEvent: 'click', expandSpeed: 750, collapseSpeed: 750, expandEasing: 'easeOutBounce', collapseEasing: 'easeOutBounce', loadMessage: 'Un momento...' }, function(file) { 
					alert(file);
				});
				
				$('#fileTreeDemo_4').fileTree({ root: '../../demo/', script: 'connectors/jqueryFileTree.php', folderEvent: 'dblclick', expandSpeed: 1, collapseSpeed: 1 }, function(file) { 
					alert(file);
				});
				
			});
		</script>

	</head>
	
	<body>
		
		<h1>jQuery File Tree Demo</h1>
		<p>
			Feel free to view the source code of this page to see how the file tree is being implemented.
		</p>
		
		<p>
			<a href="http://abeautifulsite.net/2008/03/jquery-file-tree/">Back to the project page</a>
		</p>
		
		<div class="example">
			<h2>Default options</h2>
			<div id="fileTreeDemo_1" class="demo"></div>
		</div>
		
		<div class="example">
			<h2>multiFolder = false</h2>
			<div id="fileTreeDemo_2" class="demo"></div>
		</div>
		
		<div class="example">
			<h2>Custom load message &amp; easing</h2>
			<div id="fileTreeDemo_3" class="demo"></div>
		</div>
		
		<div class="example">
			<h2>Double click &amp; no animation</h2>
			<div id="fileTreeDemo_4" class="demo"></div>
		</div>
		
	</body>
	
</html>