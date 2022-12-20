<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<head>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>
<script language="JavaScript" src="<rws:context page='/FusionCharts/FusionCharts.js' />"></script>
<script language="JavaScript" src="<rws:context page='/dashboards/Includes/rws_dashboard.js' />"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/ajax.js' />"></script>


<script>
var chart1XML="";
var chart2XML="";
function creategraph(){
	physicalChart();
	
	var obj1,obj2;

	createChart("<rws:context page='/FusionCharts/FCF_Bar2D.swf' />",1,800,500,0,0,'','phy',obj1);
	//createChart("<rws:context page='/FusionCharts/FCF_Bar2D.swf' />",2,800,500,0,0,'','fin',obj2);
	
		
	}


function physicalChart(){
	
	if(chart1XML==""){
		var URL1="<rws:context page='/public_domain/rws_process_graph_data.jsp?type=ang' />";
		ajaxFunction_Charts(URL1,1);
		}else {
		updateChartXML('1',chart1XML);
		}
	
	
	document.getElementById('phy').style.display='block';

	 setTimeout('physicalChart();','10000');
	
	
}

function ajaxFunction_Charts(URL,type)
{ 
   //alert(URL);
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;
     	resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{}
		else
		{    
			//alert(resp);  
			//alert(type);       

        if(type==1){
		         chart1XML=resp; 
		updateChartXML('1',resp);
          }else if(type==2){
			chart2XML=resp;
			updateChartXML('2',resp);
                 
		}else if(type==3){
          
			chart3XML=resp;
			updateChartXML('3',resp);
                 }
		}
	
      
	  }else{

	  }
	 
	}
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}
</script>



    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>



<body onload="creategraph();">
    <table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
        <tr>
            <td style="padding-left: 2px; padding-right: 2px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td align="center" valign="top" bgcolor="#f5f5f5" height="348" style="padding: 4px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="padding: 4px;" width="650">
                                        

			<table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="padding: 4px;" >

<!-- Search Panel Starts -->

<!-- Search Panel Ends -->



				    </td>
				</tr>
<tr>
<td height="20"></td>

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr><td><div id='phy' align='center' style="display:none">Chart.</div><div id='fin' align='center' style="display:none">Chart.</div></td></tr>
                                           
                                        </table>
                                        <!-- Grid Table Ends -->


				    </td>
				</tr>
</table>









                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>
</body>
</html>
