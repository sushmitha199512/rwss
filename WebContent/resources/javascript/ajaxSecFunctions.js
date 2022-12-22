
<script language="javascript">

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}


             //Sending message to  all users  

function messageSend(){
  var message=document.getElementById("message").value;
  if(message==""){
    alert("Please Enter Message");
return;
		}
  var priority=getCheckedValue(document.forms['master'].elements['priority']);
var chks = document.getElementsByName('to');
var to="";
for (var i = 0; i < chks.length; i++)
{
if (chks[i].checked)
{

  to+=chks[i].value;
	to+=",";
}
}
 if(to.length<1){
   alert("Please Select To List");
}

  

 var URL="Secretary/rws_sec_message_process.jsp?userid=<%=userid %>&message="+message+"&to="+to+"&priority="+priority;

       ajaxFunction_Messaging(URL);
}


function getWorks()
{
	var finyear=document.getElementById("finyear").value;
	
if(finyear==null){
finyear="2012-2013";}
document.getElementById("hh").innerHTML="("+finyear+")";
document.getElementById("wq").innerHTML="("+finyear+")";

var URL="FinancialYearWorks.jsp?finyear="+finyear;
  	ajaxFunction_Works(URL);

}
	function submitComplaint()
	{
		var userid = '<%=userid%>';
		var urlnew = "works/feedbackSecy.jsp?userid="+userid;
		//alert(urlnew);
		window.open(urlnew,"feedBackPage","width=500,height=400,scrollbars=yes,copyhistory=no,resizable=yes,status=yes");
	}
jQuery(document).ready(function($){
  // set up the options to be used for jqDock...
  var dockOptions =
    { align: 'center' // vertical menu, with expansion LEFT/RIGHT from the center
    , labels: 'br'  // add labels (override the 'tl' default)
    , inactivity: 4000 // set inactivity timeout to 4 seconds
    };
  // ...and apply...
  $('#menu').jqDock(dockOptions);
});
$(document).ready(function(){
$("#btnLoad").click(function(event){
//alert("Get Data","Alert Dialog");
var url = "SecyHomeUpdated.jsp";
ajaxFunction(url);
});
});



function ajaxFunction_Messaging(URL)
{ 
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
        alert(resp);
document.getElementById("message").value="";
      
               //TODO
		}
	
     // document.getElementById('content').style.display='none';
	  }
	  else{
  
		  //document.getElementById('content').style.display='block';
	

//alert("failed");
		// document.getElementById('content').style.display='block';
	  }
	}

	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}
function fnReset(){

document.getElementById("message").value="";
}

function ajaxFunction_Works(URL)
{ 
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
   
			var mytool_array=resp.split("/");
			document.forms[0].ongoing.value = mytool_array[0];
			document.forms[0].ongoing1.value = mytool_array[1];
			
			document.forms[0].notground.value = mytool_array[2];
			document.forms[0].notground1.value = mytool_array[3];

			document.forms[0].completed.value = mytool_array[4];
			document.forms[0].completed1.value = mytool_array[5];
			
			document.forms[0].commissioned.value = mytool_array[6];
			document.forms[0].commissioned1.value = mytool_array[7];
			document.forms[0].phys.value = mytool_array[8];	
			document.forms[0].bact.value = mytool_array[9];
			document.forms[0].mandals.value = mytool_array[10];
			document.forms[0].panchayats.value = mytool_array[11];
			document.forms[0].villages.value = mytool_array[12];
			document.forms[0].habs.value = mytool_array[13];
			document.forms[0].pws.value = mytool_array[14];
			document.forms[0].mpws.value = mytool_array[15];
			document.forms[0].cpws.value = mytool_array[16];
			document.forms[0].borewells.value = mytool_array[17];



			
			document.forms[0].fc.value = mytool_array[18];
			document.forms[0].pc4.value = mytool_array[19];
			document.forms[0].pc3.value = mytool_array[20];
			document.forms[0].pc2.value = mytool_array[21];
			document.forms[0].pc1.value = mytool_array[22];
			document.forms[0].nss.value = mytool_array[23];
			document.forms[0].nc.value = mytool_array[24];
		}
	
      document.getElementById('content').style.display='none';
	  }
	  else{
  
		  document.getElementById('content').style.display='block';
	

//alert("failed");
		  //document.getElementById('content').style.display='block';
	  }
	}

	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}

</script>