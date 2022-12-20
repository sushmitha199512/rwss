<%@page import="nic.watersoft.works.rws_works_WorkStatus_bean"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userid = user.getUserId();
/* if(user!=null){
       if(userid!=null && (!userid.equals("admin") && !userid.equals("100000") && !userid.substring(4, 6).equals("EE")  && !userid.substring(4, 6).equals("AO"))){
      response.sendRedirect("../commons/UnAuthorize.jsp");
       }
}  */
%>
  <html:javascript formName="WorkForm"/>

 <SCRIPT LANGUAGE="JavaScript">
function showSchools()
{
	if(document.forms[0].workId.value!="")
	{
		if(document.getElementById('bb').style.display=='none')
		{document.getElementById('bb').style.display='block';}
		else
		{document.getElementById('bb').style.display='none';}
	}
	else
	{
		alert("Please Select Work");
	}
}
 function addRemarks()
 {
	var zURL="switch.do?prefix=/works&page=/WorkStatus.do&mode=addRemarks&workId="+document.forms[0].workId.value;
	var popFeatures = "width=450,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'expenditure',popFeatures);
	myWin.focus();	
}
function addSchool()
 {
	if(document.forms[0].workId.value!="")
	{
		var zURL="switch.do?prefix=/works&page=/WorkStatus.do&mode=addSchool&workId="+document.forms[0].workId.value;
		var popFeatures = "width=990,height=630,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=10";
		myWin = window.open(zURL,'expenditure',popFeatures);
		myWin.focus();	
	}
	else
	{
		alert("Please Select Work");
	}
}

 function validatePercentage()
 {
	 if(document.forms[0].workStage[3].checked)
 	{
		 if(document.forms[0].workPer1.value=="-")
	{
		document.getElementById('tenPer').disabled = false;
	}
	else if(document.forms[0].workPer1.value=="+")
	{
		document.getElementById('tenPer').disabled = false;
	}
	else if(document.forms[0].workPer1.value=="")
	{
		document.forms[0].tenPer.value='0';
		document.getElementById('tenPer').disabled = true;
	}
	}
 }
 function init()
 {
 document.forms[0].workStage[0].checked=false;
 document.forms[0].workStage[1].checked=false;
 document.forms[0].workStage[2].checked=false;
 document.forms[0].workStage[3].checked=false;
 document.forms[0].workStage[4].checked=false;
 document.forms[0].workStage[5].checked=false;
 document.forms[0].workStage[6].checked=false;
 }
 
function checkMe()
{
	 if(document.forms[0].plan[0].checked)
	 {
		 if(document.forms[0].wrktype[1].checked==false)
		 {
		 document.forms[0].wrktype[0].checked=true;
		 }
	 document.forms[0].wrktype[0].disabled=false;
	 document.forms[0].wrktype[1].disabled=false;
	 document.forms[0].wrktype[2].disabled=true;
	 }
	 else if(document.forms[0].plan[1].checked)
	 {
	 //document.forms[0].wrktype[2].checked=true;
	 document.forms[0].wrktype[0].disabled=true;
	 document.forms[0].wrktype[1].disabled=false;
	 document.forms[0].wrktype[2].disabled=false;
	 }
	 else
	 {
	 document.forms[0].plan[0].checked=true;
	 document.forms[0].wrktype[0].checked=true;
	 document.forms[0].wrktype[0].disabled=false;
	 document.forms[0].wrktype[1].disabled=false;
	 document.forms[0].wrktype[2].disabled=true;
	 }
}
 function submitPage()
 {
	document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do";
   document.forms[0].submit();
 }
 function getDivisions()
 {
 document.getElementById('mode').value='div';
 submitPage();
 }
 function getSubDivisions()
 {
 document.getElementById('mode').value='subdiv';
 submitPage();
 }
 function getProgrammes()
 {
 document.getElementById('mode').value='program';
 submitPage();
 }
  function getSubprogrammes()
 {
 document.getElementById('mode').value='subprogram';
 submitPage();
 }
 function getSchemes()
 {
 document.getElementById('mode').value='schemeslist';
 submitPage();
 }
 function getWorks()
 {
   document.getElementById('mode').value='workcombo';
   submitPage();
 }
 function getWorksDetails()
 {
   document.getElementById('mode').value='details';
   submitPage();
 }

 function validation()
{
alert("Select Circle Program Work");
}
 function includePage()
 {
	//if(editPhases()==true)
	   var workStage;
			   for(var i=0;i<document.forms[0].workStage.length;i++)
			   {
			    if(document.forms[0].workStage[i].checked)
			    {
			     workStage=document.forms[0].workStage[i].value;
			    }
			   }
			 document.getElementById('workStage').value=workStage;   
			 if(workStage=='01')
			     document.getElementById('mode').value='details';
			  else
			  document.getElementById('mode').value='';
			 if(workStage=='02')
			 {
			  document.getElementById('tsMode').value='data'
			 }
			 if(workStage=='03')
			 {
			  document.getElementById('siMode').value='data'
			 }
			 if(workStage=='04')
			 {
			  document.getElementById('conMode').value='data'
			 }
			  var message='';
			  if(document.getElementById('circleCode').value=='')
			  {
			   if(message!='')
			   {
			   message=message+',';
			   }
			   message=message+'Circle';
			  }
			  if(document.getElementById('DivCode').value=='')
			  {
			  if(message!='')
			   {
			   message=message+',';
			   }
			   message=message+'Division';
			  }
			  if(document.getElementById('workCat').value=='')
			   {
			   if(message!='')
			   {
			   message=message+',';
			   }
			     message=message+'Work Category';
			   }
			   if(document.getElementById('workId').value=='')
			   {
			   if(message!='')
			   {
			   message=message+',';
			   }
			     message=message+'Work '
			   }
			  if(message!='')
			  {
			   alert("Select "+message);
			  }
			  
			  else
			  {
			   submitPage();
			  }  }
   function submitPageProgramSchedule()
   {
   		//if(editPhases()==true)
		  	 var workStage;
		 for(var i=0;i<document.forms[0].workStage.length;i++)
		 {
		 	if(document.forms[0].workStage[i].checked)
		    {
		    	workStage=document.forms[0].workStage[i].value;
		    }
		  }
		 document.getElementById('workStage').value=workStage;   
		 if(workStage=='05')
		 {
		  document.getElementById('psMode').value='data';
		 }
		  var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		   if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Circle';
		  }
		  if(document.getElementById('DivCode').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Division';
		  }
		   if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  
		  else
		  {
			 // document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do";
			document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do?mode=refundamount";
	 		  document.forms[0].submit();
		  } }
  /*    function submitPageWorkExpenditure()
   {
	 //  	if(editPhases()==true)
	  	 var workStage;
		 for(var i=0;i<document.forms[0].workStage.length;i++)
		 {
		 	if(document.forms[0].workStage[i].checked)
		    {
		    	workStage = ""+document.forms[0].workStage[i].value;
		    }
		  }
		 document.getElementById('workStage').value=workStage;   
		 if(workStage=='06')
		 {
		  document.getElementById('weMode').value='data';
		 }
		  var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		   if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Circle';
		  }
		  if(document.getElementById('DivCode').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Division';
		  }
		  if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  
		  else
		  {
			  document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do";
	 		  document.forms[0].submit();
		  } } */
  	function submitPageWorkCompletion()
   {
//	  	 if(editPhases1()==true)
		var workStage;
		 for(var i=0;i<document.forms[0].workStage.length;i++)
		 {
		 	if(document.forms[0].workStage[i].checked)
		    {
		    	workStage=document.forms[0].workStage[i].value;
		    }
		  }
		 document.getElementById('workStage').value=workStage;   
		 if(workStage=='07')
		 {
		  document.getElementById('wcMode').value='data';
		 }
		  var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		   if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Circle';
		  }
		  if(document.getElementById('DivCode').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Division';
		  }
		  if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  
		  else
		  {
			  document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do";
	 		  document.forms[0].submit();
		  } }
      function submitPageSourceIdentification()
   {
	  
		   if(document.forms[0].scheme.value=="LAB")
	   {
			   alert("You cannot Enter Source for Lab Type Work");
	   }
	   else
	   {
			var workStage;
		   for(var i=0;i<document.forms[0].workStage.length;i++)
		   {
		    if(document.forms[0].workStage[i].checked)
		    {
		     workStage=document.forms[0].workStage[i].value;
		    }
		   }
		 document.getElementById('workStage').value=workStage;   
		 if(workStage=='03')
		 {
		  document.getElementById('siMode').value='data';
		 }
		  var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		   if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Circle';
		  }
		  if(document.getElementById('DivCode').value=='')
		  {
		  if(message!='')
		   {
		   message=message+',';
		   }
		   message=message+'Division';
		  }
		  if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work '
		   }
		  if(message!='')
		  {
		   alert("Select "+message);
		  }
		  
		  else
		  {
			  document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=data&spradgroup=data";
	 		  document.forms[0].submit();
		  }
	   }
   }
   function getFormmandal()
	{
		document.getElementById('siMode').value='mandals';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=mandals";
		document.forms[0].submit();
	}
	function getFormSource()
	{
		document.getElementById('siMode').value='source';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=source";
		document.forms[0].submit();
	}
	function getFormSrctype()
	{
		document.getElementById('siMode').value='sourceType';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=sourceType";
		document.forms[0].submit();
	}
	function getFormSubSource()
	{
		document.getElementById('siMode').value='sources';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=data";
		document.forms[0].submit();
	}
	function getForm()
	{
		document.getElementById('siMode').value='existNew';
		document.forms[0].action="/pred/works/WorkStatus.do?mode=data";
		document.forms[0].submit();
	}
	function sinsertForSourceIdentification()
   {
	   	 if(document.forms[0].mandalCode.value=="")
		 {
		 	alert("Select Mandal");
		 }
		 else if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
		 else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		 else if(document.forms[0].spradgroup[0].checked)
		 {
		 	if(document.forms[0].srcCode.value=="")
		 	{
		 		alert("Select Source Code");
		 	}
		 	else
		 	{
			 	document.getElementById('siMode').value='save';
		 		document.forms[0].action ="/pred/works/WorkStatus.do?mode=save";
				document.forms[0].submit();
		 	}
		 }
		 else if(document.forms[0].spradgroup[1].checked)
		 {
		 	if(document.forms[0].newsrcName.value=="")
		 	{
		 		alert("Enter Source Name");
		 	}
		 	else
		 	{
			 	document.getElementById('siMode').value='save';
		 		document.forms[0].action ="/pred/works/WorkStatus.do?mode=save";
				document.forms[0].submit();
		 	}
		 }
	}
	function sfndelete()
	{
		if(document.forms[0].mandalCode.value=="")
		 {
		 	alert("Select Mandal");
		 }
		 else if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
		 else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		else if (document.forms[0].spradgroup[0].checked)
		{	
		   if(document.forms[0].srcCode.value == null || document.forms[0].srcCode.value == "")
		   {
		   alert("Select Source Code");
		   }
		   else
		   {
		   document.getElementById('siMode').value='delete';
		   	document.forms[0].revdel.value="srevdel";
			document.forms[0].action="/pred/works/WorkStatus.do?mode=delete";
			document.forms[0].submit();
			}
		 }
		 else if(document.forms[0].spradgroup[1].checked)
		{	
		   if(document.forms[0].newsrcCode.value == null || document.forms[0].newsrcCode.value == "")
		   {
		   alert("Select Source Code");
		   }
			if(document.forms[0].newsrcName.value == null || document.forms[0].newsrcName.value == "")
		   {
		   alert("Enter Source Name");
		   }
		   else
		   {
		    document.getElementById('siMode').value='delete';
		   	document.forms[0].revdel.value="srevdel";
			document.forms[0].action="/pred/works/WorkStatus.do?mode=delete";
			document.forms[0].submit();
			}
		 } 
	}
	function setSourceName()
	{
		var scode = document.forms[0].srcCode.value;
		var sname = scode.substring(25,scode.length);
		document.forms[0].srcName.value=sname;
	}
	   function openDdwsForm()
   {
      var chkVal;
      var workStage;
      //if(editPhases()==true)
			   for(var i=0;i<document.forms[0].workStage.length;i++)
		   {
		    if(document.forms[0].workStage[i].checked)
		    {
		     workStage=document.forms[0].workStage[i].value;
		    }
		   }
        if(workStage=='08')
        {
        chkVal='ddwsData';
        }
     var cmbCircle=document.getElementById('circleCode').value;
     var div=document.getElementById('divCode').value;
     var sdiv=document.getElementById('subdivisioncode').value;
	 var plan = document.getElementById('plan').value;
 	 var wrkType = document.getElementById('wrkType').value;
  	 var workCat = document.getElementById('workCat').value;
   	 var program = document.getElementById('program').value;
  	 var subprogram = document.getElementById('subprogram').value;
  	 var workId = document.getElementById('workId').value;

     var message='';
		  if(document.getElementById('circleCode').value=='')
		  {
		    if(message!='')
		    {
		    message=message+',';
		    }
		   message='Circle';
		  }
		  if(document.getElementById('divCode').value=='')
		  {
		  if(message!='')
		    {
		    message=message+',';
		    }
		    message=message+'Division';
		  }
		  if(document.getElementById('workCat').value=='')
		   {
		   if(message!='')
		   {
		   message=message+',';
		   }
		     message=message+'Work Category';
		   }
		
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		    {
		    message=message+',';
		    }
		     message=message+'Work '
		   }
     
     if(workStage=='08' && message=='')
     {
   	 	var width = 925;
		var height = 660;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		var url = "/pred/works/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&workId="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&circleCode="+cmbCircle+"&divCode="+div+"&subdivisioncode="+sdiv+"&plan="+plan+"&wrkType="+wrkType+"&workCat="+workCat+"&program="+program+"&subprogram="+subprogram+"&mode=details";
		var properties = "width="+width+",height="+height+",screenX="+left+",left=15,screenY="+top+",top=15,toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=no,titlebar=0,fullscreen=0";
		newWindow = window.open(url,"_blank", properties);
		 
		newWindow.focus(); 
      }
     
     else
     {
     alert("Select "+message);
     }
   }
 function showhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=admnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }

function showTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=tsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);

}

function showRevTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=revTsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
 function showRevhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/WorkStatus.do?mode=revAdmnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
 function hideRev()
 {
	 if(document.getElementById('revAdminNo').value=='')
	 {
	  	if(document.getElementById('revAdmin'))
	  	{
	  		document.getElementById('revAdmin').style.display='none';
	  	}
	 }
  
 }
function firstMakeEdit()
{
	var workStage;
	for(var i=0;i<document.forms[0].workStage.length;i++)
	{
		if(document.forms[0].workStage[i].checked)
		{
			workStage=document.forms[0].workStage[i].value;
		}
	}
	if(workStage=='06')
    {
		if(document.getElementById("WORKEXP_LIST[0].expMonth")!=null)
		{	
			if(document.getElementById("WORKEXP_LIST[0].expMonth").value !='1')
				document.getElementById("WORKEXP_LIST[0].expMonthUp").readOnly=false;
		}
	}
}
function ajaxFunction(URL,divobj)
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
		alert(xmlHttp.responseText);
		document.getElementById('load').style.display='none';
		document.getElementById('cancel').style.display='none';
		document.getElementById('continue').style.display='block';
	  }
	  else{
		  document.getElementById('cancel').style.display='none';
		  document.getElementById('load').style.display='block';
	  }
	}
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}
function cancelTheWork()
{	
	if(document.getElementById('workId').value=="")
	{
		alert("Please Select the Work");		
	}
	else if(document.forms[0].workCancelledDate.value==null || document.forms[0].workCancelledDate.value=="")
	{
		alert("Please Enter the Date Of Cancellation");		
	}
	else if(document.forms[0].physicalStatus.value=="Grounded")
	{
		dt1=getDateObject(document.forms[0].workCancelledDate.value,"/");
		dt2=getDateObject(document.forms[0].physicalStatusDetails.value,"/");
		if(dt1<dt2)
		{
			alert("Cancellation Date should not be \n Less than to Grounding Date");
		}
		else
		{
			var url="/pred/works/WorkStatus.do?mode=cancelWork&workId="+document.getElementById('workId').value+"&cancelDate="+document.forms[0].workCancelledDate.value;
			ajaxFunction(url,document.getElementById("mydivid"));
		}
	}
	else{
		var url="/pred/works/WorkStatus.do?mode=cancelWork&workId="+document.getElementById('workId').value+"&cancelDate="+document.forms[0].workCancelledDate.value;
		ajaxFunction(url,document.getElementById("mydivid"));
	    }
}
function getDateObject(dateString,dateSeperator)
{
		var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);			cMonth=dateString.substring(curPos+1,endPos);
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth,cDate);	
	return dtObject;
}
function getWorkDetails(){
var work_id=document.getElementById('nwork').value;
if(work_id==""){
alert("Please Enter WorkId");
return;
} else if(work_id.length<14){
alert("WorkId Should  Be in 14 Didgit.");
return;

}
 document.getElementById('nmode').value='nmode';
getWorksDetails();
}

      function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

         return true;
      }
function continueTheWork()
{	
	if(document.getElementById('workId').value=="")
	{
		alert("Please Select the Work");		
	}
	else if(document.forms[0].workCancelledDate.value!="")
	{
		alert("Please Remove the Date Of Cancellation");		
	}
	else
	{
		var url="/pred/works/WorkStatus.do?mode=continueWork&workId="+document.getElementById('workId').value;
		//alert(url);
		ajaxFunction(url,document.getElementById("mydivid"));
	}
}
function saveReason()
{
	//alert("In reason");
	 document.getElementById('mode').value='saveNotGroundReason';
	 submitPage();	
}
</SCRIPT>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/slidebox.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/Tooltip1.js'/>"></script>
<body  onload="hideRev();checkMe();firstMakeEdit();validatePercentage()">
<html:form  action="WorkStatus.do?mode=circles1" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<html:hidden property="mode"/><html:hidden property="tsMode"/>
<html:hidden property="siMode"/><html:hidden property="psMode"/>
<html:hidden property="weMode"/><html:hidden property="wcMode"/>
<html:hidden property="conMode"/><html:hidden property="revAdminNo"/><html:hidden property="revTsMode"/>
<html:hidden property="nmode"/>
<div id="aa" style="background-color:white;width:550px; height: 49px;filter: alpha(Opacity=125);
opacity:0.15;border: solid 1px gray; background-image: url(./images/bg.jpg); text-align: center;display=none;overflow=scroll">
</div>
<style type="text/css">
.modeltextbox {
	width: 130px;
	background: transparent url('images/bgtext.jpg') no-repeat;
	color : green;
	height:20px;
	border:0;
	padding-top:3px;
	padding-bottom:3px;	
	margin-bottom:0px;
}
.fb5 {
	background-color: #db6600;
	padding-left:6px;
	padding-right:6px;
	padding-top:3px;
	padding-bottom:3px;	
	color: #ffffff;
	border:1px solid #db6600;
	background-image: url(images/button_bg.jpg);
}
.fb5:hover {
	background-color: #000000;	
	border:1px solid #000000;
	background-image: url(images/button_bg_over.jpg);
}
</style>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Status" />
	<jsp:param name="TWidth" value="855" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >

<tr><td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enter WorkId:<html:text    property="nwork" maxlength="14"  styleClass="modeltextbox" onkeypress="return isNumberKey(event)" ></html:text> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Get Details "  onclick="getWorkDetails()"></td></tr>
<tr><td align=center" class="textborder"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">(Or)</font></td></tr>
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		<table cellpadding="0" cellspacing="4" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;">
			<tr>
			<logic:present name="circles">
		 	<logic:notPresent name="fixcircle">
				<td class="textborder" >Circle<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo"  onchange="javascript:init();getDivisions();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="circles" property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:notPresent>
		    <logic:present name="fixcircle">
				<td class="textborder">Circle<span class="mandatory">*</span></td>
				 <logic:present name="RWS_USER" property="circleOfficeName">
				 <html:hidden property="circleCode"/>
			 	<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</logic:present>
			</logic:present>
			<logic:present name="divs" >
		 	<td class="textborder">Division<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="divCode" style="width:143px" styleClass="mycombo" onchange="javascript:init();getSubDivisions();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="divs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="divs">
				<td class="textborder">Division<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="divCode" style="width:143px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent>
			<td>
			<logic:present name="subdivs" >
		 	<td class="textborder">SubDivision</td>
				<td class="textborder">
				<html:select property="subdivisioncode" style="width:143px" styleClass="mycombo" onchange="javascript:init();getSubDivisions();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="subdivs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="subdivs">
			<td class="textborder">SubDivision</td>
				<td class="textborder">
		        <html:select property="subdivisioncode" style="width:143px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent></td>
		</tr><tr>
		<td class="textborder" colspan="2">
		<html:radio property="plan" value="1" onclick="init();checkMe();getProgrammes();">Plan</html:radio>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <html:radio property="plan" value="2" onclick="init();checkMe();getProgrammes();">Non Plan</html:radio>
		</td>
		<td class="textborder" colspan="3">
        <html:radio property="wrktype" value="1" onclick="init();getProgrammes();">MainScheme</html:radio>
        <html:radio property="wrktype" value="2" onclick="init();getProgrammes();">Augmentation</html:radio>
        <html:radio property="wrktype" value="3" onclick="init();getProgrammes();">Maintenance</html:radio>
		</td>
		<td class="textborder">Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="JavaScript:init();getProgrammes();">
		<html:option value="">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/> 
		</logic:present>
		</html:select>
		</td></tr>
		<tr>
		<td class="textborder">Programme<span class="mandatory">*</span></td>
		<td>
		    <html:select property="program" style="width:143px" styleClass="mycombo" onchange="JavaScript:init();getSubprogrammes();">
			<html:option value="">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	   </td>
	   <td  class="textborder">SubProgramme<span class="mandatory">*</span></td>
        <td colspan=2>
		     <html:select property="subprogram" style="width:143px" styleClass="mycombo" onchange="JavaScript:init();getWorks();">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
        <td  class="textborder">Schemes<span class="mandatory">*</span></td>
        <td>
		    <html:select property="schemelist" style="width:143px" styleClass="mycombo"  onchange="JavaScript:init();getWorks();"  >
			<html:option value="">Select...</html:option>
			<logic:present name="assettypes"> 
			<html:options collection="assettypes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td></tr>
        <tr><td class="textborder">Fin. Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=textborder>
		<html:select property="financialyear" style="width:143px" styleClass="mycombo" onchange="JavaScript:init();getWorks();" >
				<html:option value="">Select...</html:option>
				<logic:present name="expyears"> 
				<html:options collection="expyears" property="value" labelProperty="label" />
				</logic:present>
			</html:select>
		</td></tr>		
		<tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6"  >
		        <html:select property="workId" style="width:643px" styleClass="mycombo" onchange="JavaScript:init();getWorksDetails();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="rwsWorks"   property="workId" labelProperty="workName" />
	            </html:select>
				Scheme&nbsp;&nbsp;<html:text property="scheme"  styleClass="mytext" maxlength="10" style="width:80px" readonly="true"/></td>
			</logic:present>
			<logic:notPresent name="rwsWorks">
				<td class="textborder" >Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="4">
		        <html:select property="workId" style="width:527px" styleClass="mycombo"  >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
				<td>Scheme</td>
			    <td><html:text property="scheme"  styleClass="mytext" maxlength="10" style="width:80px" readonly="true"/>
				</td></logic:notPresent></tr>
			<c:set var="sName" value="${WorkForm.scheme}" scope="request"/>
			<%String statss = (String)request.getAttribute("sName");
			session.setAttribute("scode",statss);
			%>
				<c:set var="physicalStatus" value="${WorkForm.physicalStatus}" scope="request"/>
				  <%
					  String physicalStatuss = (String)request.getAttribute("physicalStatus");
					  String workCancelleddDate = "";
					  if(physicalStatuss!=null && !physicalStatuss.equals(""))
					  {
					  if(!physicalStatuss.equals("Not Grounded"))
					  {%>
			     <tr>
				<td class="textborder">Remarks<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6">
					  <html:text property="physicalStatus" style="width:105px" styleClass="noborder-text-box" readonly="true"/>
						&nbsp;&nbsp;&nbsp;&nbsp;<%=physicalStatuss %>&nbsp;Date:
						<html:text property="physicalStatusDetails" style="width:70px" readonly="true"/>
				</td></tr>
				<%} else {%>
				<tr>
				<td class="textborder">Remarks<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6">
				<html:text property="physicalStatus" style="width:70px" styleClass="noborder-text-box" readonly="true"/>
					&nbsp;Reasons For Not Grounding:
				<c:set var="physicalStatusDetails" value="${WorkForm.physicalStatusDetails}" scope="request"/>
				  <%
					  String physicalStatusRemarks = (String)request.getAttribute("physicalStatusDetails");
					  if(physicalStatusRemarks!=null && !physicalStatusRemarks.equals(""))
					  {
					%>
					<html:text property="physicalStatusDetails" style="width:380px" readonly="true"/>
					<a href="#" onClick="addRemarks()">Update Reasons</a>
					<%} else  { %>
					<html:text property="physicalStatusDetails" style="width:400px" readonly="true"/>
					<a href="#" onClick="addRemarks()">Add Reasons</a>
					<% }}%>
				</td>
	 		</tr>
	 		<tr>
					<td class="textborder" colspan="6">
						Reason For Delay:<span class="mandatory">*</span>					
						<html:select property="reasonCodeNotGround" styleClass="mycombo"  style="width:60%">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<logic:notEmpty name="reasons">
								<html:options collection="reasons" name="labelValueBean" property="value" labelProperty="label" />
							</logic:notEmpty>	
						</html:select>
						<a href="#" onClick="saveReason()">Save Reason</a>
					</td>
				</tr>	
	 		<%}%>
	 		<%if(physicalStatuss!=null)
			{ %>
	 		<c:set var="workCancelleddDate" value="${WorkForm.workCancelledDate}" scope="request"/>
 			<%workCancelleddDate = (String)request.getAttribute("workCancelleddDate");
	 			if(workCancelleddDate!=null)
	 			{%>
		 		<tr>
					<td class="textborder" colspan=2>
		 			Work Cancellation &nbsp;&nbsp;&nbsp;
		 			<html:text property="workCancelledDate" style="width:70px" styleClass="mytext"/>
		 			<a href="javascript: showCalendar(document.forms[0].workCancelledDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		 			</td>
		 			<%if(userid.equals("admin") || userid.equals("100000"))
					{
						if(workCancelleddDate!=null && !workCancelleddDate.equals("")){ %>
						<td class="textborder" colspan=3>	
							<div id="continue" style="display:block">
								<html:button property="mode" styleClass="btext" value="Continue the Work" onclick="continueTheWork()" onmouseover="Tip('Work Cancelled, Click to Continue the Work',TITLE,'')" onmouseout="UnTip()" disabled="false"/> 
							</div>
							<div id="cancel" style="display:none">
								<html:button property="mode" styleClass="btext" value="Cancel the Work" onclick="cancelTheWork()" onmouseover="Tip('Click to Cancel the Work',TITLE,'')" onmouseout="UnTip()" disabled="false"/> 
							</div>
							<div id="load" style="display:none"><img src="<%=request.getContextPath()%>/images/loader-3.gif"/></div>
						</td>
						<%}else{
							if(physicalStatuss!=null && (!physicalStatuss.equals("") && !physicalStatuss.equals("Completed") && !physicalStatuss.equals("Commissioned") && !physicalStatuss.equals("Financially Completed")))
							{ %>
							<td class="textborder" colspan=3>	
							<div id="cancel" style="display:block">
								<html:button property="mode" styleClass="btext" value="Cancel the Work" onclick="cancelTheWork()" onmouseover="Tip('Click to Cancel the Work',TITLE,'')" onmouseout="UnTip()" disabled="false"/> 
							</div>
							<div id="continue" style="display:none">
								<html:button property="mode" styleClass="btext" value="Continue the Work" onclick="continueTheWork()" onmouseover="Tip('Work Already Cancelled, Click to Continue the Work',TITLE,'')" onmouseout="UnTip()" disabled="false"/> 
							</div>
							<div id="load" style="display:none"><img src="<%=request.getContextPath()%>/images/loader-3.gif"/></div>
							</td>
							<%}
							else if(physicalStatuss!=null && !physicalStatuss.equals(""))
							{%>
							<td class="textborder" colspan=3>	
							<div id="cancel" style="display:block">
								<html:button property="mode" styleClass="btext" value="Cancel the Work" onclick="cancelTheWork()" title="Work Already Completed/Commissioned, You cannot Cancel the Work"  disabled="true"/> 
							</div>
							<div id="load" style="display:none"><img src="./images/loader-3.gif"/></div>
							</td>
							<%}}}else{%>
						<td class="textborder" colspan=3>	
							<div id="cancel" style="display:block">
								<html:button property="mode" styleClass="btext" value="Cancel the Work" onclick="cancelTheWork()" title="You cannot Cancel the Work - Contact Your Head Office"  disabled="true"/> 
							</div>
						</td>
						<%} %>
					</tr>
					<%} }%>
					<tr>
						<td class="textborder" colspan="7">School Details<span class="mandatory">*</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<html:text property="schoolDetails" style="width:550px;cursor:hand" readonly="true" onclick="showSchools()"/>&nbsp;&nbsp;
						<a href="#" onClick="addSchool()">Add/Remove School Details</a>
					</td>
					</tr>
					<tr><td colspan=7 align=center>
					<div id="bb" style="background-color:white;width:450px; height: 49px;filter: alpha(Opacity=125);opacity:0.15;border: solid 1px gray; background-image: url(./images/bg.jpg);display=none">
					<table bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" align=center>
					<tr><td colspan=11 align="right" onclick="showSchools()" style="cursor:hand">
						<font face=verdana size=2 color="black"><b>&nbsp;&nbsp;&nbsp;Hide&nbsp;&nbsp;&nbsp;</b></font>
					</td></tr>
					<tr><td class="textborder" colspan="11"><div align="center"><font color="black">Linked Schools With this Work</font></div></td>
						  </tr>
						  <TR>
							<td class="btext" nowrap align=center>S.No.</TD>
							<td class="btext" nowrap align=center>Mandal</TD>							
							<td class="btext" nowrap align=center>Panchayat</TD>
							<td class="btext" nowrap align=center>Village</TD>
							<td class="btext" nowrap align=center>Habitation</TD>
							<td class="btext" nowrap align=center>School</TD>
						</TR>
						  <%
						  ArrayList schoolList = (ArrayList)session.getAttribute("workLinkedSchools");
						  if(schoolList!=null)
						  { int count = 0;
								for(int i=0;i<schoolList.size();i++)
								{
									rws_works_WorkStatus_bean rs = (rws_works_WorkStatus_bean)schoolList.get(i);%>
								<tr>
									<td  align="center"><font face=verdana size=2><%= ++count %></font></td>
									<td  align="left" nowrap><font face=verdana size=2><%=rs.getConName()%></font></td>
									<td  align="left" nowrap><font face=verdana size=2><%=rs.getPanchayat()%></font></td>
									<td  align="left" nowrap><font face=verdana size=2><%=rs.getVillage()%></font></td>
									<td  align="left" nowrap><font face=verdana size=2><%=rs.getHabitation()%></font></td>
									<td  align="left" nowrap><font face=verdana size=2><%=rs.getSchoolCode()%></font></td>
								</tr>
								<%}}
							else
							{%>
							<tr><td class="bwborder" align="center" colspan="7">No Schools Linked Yet</td></tr>
							<%}%>
						</table></div>
					</td></tr>
					<%
					if(request.getAttribute("isDdwsWork")!=null && !request.getAttribute("isDdwsWork").equals("")){%>
					<tr>
					<td align="left" colspan="1" style="width:50px">&nbsp;</td>
					<td align="left" colspan="5"><b>
					<%if(request.getAttribute("isDdwsWork").equals("Y")){ %>
					<font face=verdana size=2 color=red><marquee behavior=alternate scrollDelay=120>This Work Sent to DDWS as Project Shelf</marquee></font>
					<%}else if(request.getAttribute("isDdwsWork").equals("N")){ %>
					<font face=verdana size=2 color=blue><marquee behavior=alternate scrollDelay=120>This Work Not Yet Sent to DDWS as Project Shelf</marquee></font>
					<%} %>
					</b></td>
					<td align="left" colspan="1" style="width:50px">&nbsp;</td></tr>
					<%} %>
	 	   </table></label> </fieldset>
    <tr>
		<td class="bwborder" >
		<fieldset>
		<legend> <B>Work Stages</B></legend>
		<label>
		
		<%
				int allowFlag = 0;
				workCancelleddDate = (String)request.getAttribute("workCancelleddDate");
				if((userid.equals("admin") || userid.equals("100000")))
					{
					  if((workCancelleddDate!=null || !workCancelleddDate.equals("")) || (workCancelleddDate==null || workCancelleddDate.equals("")))
					  {
						allowFlag = 1;
					  }
					}
				if((! userid.equals("admin") && ! userid.equals("100000")))
					{
					if(workCancelleddDate.length()>0)
						{
							allowFlag = 0;
						}
					else
						{
							allowFlag = 1;
						}
					}
				if(allowFlag == 1)
				   {
					%>
		
		<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr class="textborder">	
			<td><html:radio property="workStage" value="01" title="Click to view the Admin & Revised Sanction Details" onclick="includePage()"/></td>	
			<td>Admin Sanction </td>
			<td><html:radio property="workStage" value="02" title="Click to view Tecnical & Revised Technical Sanction Details" onclick="includePage()"/></td>	
			<td>Technical Sanction</td>
			<td><html:radio property="workStage" value="03" title="Click to view Source Idetification Details"  onclick="submitPageSourceIdentification()" /></td>	 
			<td>Source Identification </td>
			<td><html:radio property="workStage" value="04" title="Click to view Contractor Management Details" onclick="includePage()"/></td>	 
			<td>Contractor Management </td>
		    </tr>
		    <tr class="textborder">
		    <td><html:radio property="workStage" value="05" title="Click to view Programme Schedule Details" onclick="submitPageProgramSchedule()"/></td>	 
			<td>Programme Schedule </td>
			<%-- <td><html:radio property="workStage" value="06" title="Click to view Work Expenditure Details" onclick="submitPageWorkExpenditure()"/></td>	 
			<td>Work Expenditure </td> --%>
			<td><html:radio property="workStage" value="07" title="Click to view Work Completion Details" onclick="submitPageWorkCompletion()"/></td>
			<td>Work Completion </td>	
			<td><html:radio property="workStage" value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
			<td>DDWS Data Entry </td>
		    </tr>	
		   </table>
		   <%} %>
		   
		   <%if(allowFlag == 0) { %>
		
		<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr class="textborder">	
			<td><html:radio property="workStage" disabled="true"  value="01" title="Click to view the Admin & Revised Sanction Details" onclick="includePage()"/></td>	
			<td>Admin Sanction </td>
			<td><html:radio property="workStage" disabled="true"  value="02" title="Click to view Tecnical & Revised Technical Sanction Details" onclick="includePage()"/></td>	
			<td>Technical Sanction</td>
			<td><html:radio property="workStage" disabled="true"  value="03" title="Click to view Source Idetification Details"  onclick="submitPageSourceIdentification()" /></td>	 
			<td>Source Identification </td>
			<td><html:radio property="workStage" disabled="true"  value="04" title="Click to view Contractor Management Details" onclick="includePage()"/></td>	 
			<td>Contractor Management </td>
		    </tr>
		    <tr class="textborder">
		    <td><html:radio property="workStage" disabled="true"  value="05" title="Click to view Programme Schedule Details" onclick="submitPageProgramSchedule()"/></td>	 
			<td>Programme Schedule </td>
			<%-- <td><html:radio property="workStage" value="06" title="Click to view Work Expenditure Details" onclick="submitPageWorkExpenditure()"/></td>	 
			<td>Work Expenditure </td> --%>
			<td><html:radio property="workStage" disabled="true"  value="07" title="Click to view Work Completion Details" onclick="submitPageWorkCompletion()"/></td>
			<td>Work Completion </td>	
			<td><html:radio property="workStage" disabled="true"  value="08" title="Click to Enter DDWS Details" onclick="openDdwsForm()"/></td>
			<td>DDWS Data Entry </td>
		    </tr>	
		   </table>
		   <%} %>
		   
		   
		    </label> </fieldset>
		 </td> </tr>
	<c:if test="${requestScope.Includepage =='01'}">
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Administrative Sanction (Amount In Rs.Lakhs)</B></legend>
		<label>
		<table cellpadding="0" cellspacing="7" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	 		<tr>
	 		<td colspan="10">
	   		  <fieldset>
			    <legend ><B>.</B> </legend>
			    <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Admin Sanction No</td>
					     <td class="clrborder" align="center">Admin Sanction Date</td>
						 <td class="clrborder" align="center">Admin Sanctioned Amount</td>
					     <td class="clrborder" align="center">Programme</td>
					     <td class="clrborder" align="center">Sub programme</td>
					  </tr> <tr>
					      <td class="bwborder" align="center" >
					      1.
					      </td>
					      <td class="clrborder" align="right">
						  <html:text property="adminNo"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="adminDate"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="adminAmnt"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center">
						  <html:text property="progName"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center"> 
						  <html:text property="subProgName"  styleClass="gridtext"   readonly="true" />
						  </td>
					 </tr>
					 <logic:present name="adminProg">
					  <%int i=2; %>
					  <nested:iterate id="snctions" name="adminProg">
				 	  <tr>
					  <td class="bwborder" align="center">
					  <%=i++ %>.
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminNo" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminDate" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="adminAmnt" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="progName" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="center">
					 	  <nested:text name="snctions" property="subProgName" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  </tr>
					  </nested:iterate>
					 </logic:present>
	 	        </table> </label>  </fieldset>
			   </td> </tr>
	 	 		 <tr class="textborder">
		   <% if(statss.equals("LAB")) {%>
	 	     <td>Total Labs : 
			  <%} else if(statss.equals("SCHOOLS")) {%>
	 	     <td>Total Schools : 
			 <%}else if (statss.equals("PUBLIC INSTITUTES")){%>
				 <td>Total PUBLIC INSTITUTES : 
				 <%}else if (statss.equals("ANGANWADIS")){%>
				 <td>Total ANGANWADIS :
				 <%
			 }
			  else{%>
			 <td>Total Habitations Benefited : 
			   <%}%>
			 <html:text property="adminHabsBen" styleClass="mytext"  readonly="true" style="width:80px"  /> 
            <% if(statss.equals("LAB")) {%>
	 	     <html:button property="mode" styleClass="btext" value="Show Labs" onclick="showhabDetails()" title="show habitation detials"/>
		   <%} else if(statss.equals("SCHOOLS")) {%>
		   <html:button property="mode" styleClass="btext" value="Show Schools" onclick="showhabDetails()" title="show habitation detials"/>
		    <%}else if (statss.equals("PUBLIC INSTITUTES")){%>
		     <html:button property="mode" styleClass="btext" value="Show Public Institutes" onclick="showhabDetails()" title="show Public Institutes detials"/>
		   
		   <%}else if (statss.equals("ANGANWADIS")){%>
		     <html:button property="mode" styleClass="btext" value="Show Anganwadis" onclick="showhabDetails()" title="show Anganwadis detials"/>
		  
		   <%} else{%>
		    <html:button property="mode" styleClass="btext" value="Show Habitations" onclick="showhabDetails()" title="show habitation detials"/>
	       <%}%>
			 </td> </tr>
			 <%if(!(statss.equals("LAB") || statss.equals("SCHOOLS") || statss.equals("PUBLIC INSTITUTES")|| statss.equals("ANGANWADIS"))){%>
			 <tr class="textborder">
			   <td colspan="10">
		   		  <fieldset>
				    <legend ><B>Population Benefited(AS Per Census)</B> </legend>
				    <label>
			 		<table cellpadding="0" cellspacing="3" border="0"   
				   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
				   <tr class="textborder">
				    <td>Plain: <html:text property="adminPlainPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Sc: <html:text property="adminScPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   St: <html:text property="adminSTPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Total: <html:text property="adminTotpopu"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
				   </tr>
			   </table> </label>  </fieldset>
			   </td> </tr>
			   <%}%></table></label></fieldset>
		</td></tr>
		    <tr id="revAdmin">
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Revised Administrative Sanction (Amount In Rs.Lakhs)</B></legend>
		<label>
		<table cellpadding="0" cellspacing="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	 		<tr>
	 		<td colspan="6">
	   		  <fieldset>
			    <legend >	<B>.</B></legend>
			   <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Revised Admin Sanction No</td>
					     <td class="clrborder" align="center">Revised Admin Sanction Date</td>
						 <td class="clrborder" align="center">Revised Sanctioned Amount</td>
					     <td class="clrborder" align="center">Programme</td>
					     <td class="clrborder" align="center">Sub programme</td>
					  </tr> <tr>
					      <td class="bwborder" align="center">
						   1.
						  </td>
					      <td class="clrborder" align="right">
						  <html:text property="revAdminNo"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="revAdminDate"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="right">
						  <html:text property="revAdminAmnt"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center">
						  <html:text property="progName"  styleClass="gridtext"   readonly="true" />
						  </td>
						  <td class="clrborder" align="center"> 
						  <html:text property="subProgName"  styleClass="gridtext"   readonly="true" />
						  </td>
					 </tr>
					 <logic:present name="revAdminProg">
					 <%int j=2; %>
					  <nested:iterate id="snctions" name="revAdminProg">
					  <tr>
					       <td class="bwborder" align="center">
					       <%=j++ %>.
					       </td>
					      <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminNo" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminDate" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="revAdminAmnt" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="progName" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
						  <td class="bwborder" align="center">
						 	  <nested:text name="snctions" property="subProgName" styleClass="gridtext" 
							  indexed="true" readonly="true"/>
						  </td>
					  </tr>
					  </nested:iterate>
					 </logic:present>
	 	        </table> </label> </fieldset>
			   </td></tr>
			 <tr class="textborder">
	 	   <% if(statss.equals("LAB")) {%>
	 	     <td>Total Labs : 
		   <%} else if(statss.equals("SCHOOLS")) {%>
		   <td>Total Schools : 
		   <%} else if(statss.equals("PUBLIC INSTITUTES")) {%>
		   <td>Total Public Institutes : 
		   <%} else if(statss.equals("ANGANWADIS")) {%>
		   <td>Total Anganwadis : 
		   <%} else{%>
		   <td>Total Habitations Benefited : 
	   <%}%>
			 <html:text property="revAdminHabsBen"  styleClass="mytext"  readonly="true" style="width:80px"  /> 
			  <% if(statss.equals("LAB")) {%>
	 	     <html:button property="mode" styleClass="btext" value="Show Labs" onclick="showRevhabDetails()" title="show habitation detials"/>
		   <%} else if(statss.equals("SCHOOLS")) {%>
		   <html:button property="mode" styleClass="btext" value="Show Schools" onclick="showRevhabDetails()" title="show habitation detials"/>
		   <%}else if(statss.equals("PUBLIC INSTITUTES")) {%>
		   <html:button property="mode" styleClass="btext" value="Show Public Institutes" onclick="showRevhabDetails()" title="show public institutes detials"/>
		    <%}else if(statss.equals("ANGANWADIS")) {%>
		   <html:button property="mode" styleClass="btext" value="Show Anganwadis" onclick="showRevhabDetails()" title="Show Anganwadis detials"/>
		   
		   
		   <%} else{%>
		    <html:button property="mode" styleClass="btext" value="Show Habitations" onclick="showRevhabDetails()" title="show habitation detials"/>
	   <%}%>
			  </td>
			  <%if(!(statss.equals("LAB") || statss.equals("SCHOOLS")|| statss.equals("PUBLIC INSTITUTES")|| statss.equals("ANGANWADIS"))){ %>
			  </tr>
			    <tr class="textborder">
			   <td colspan="10">
		   		  <fieldset>
				    <legend >
							<B>Population Benefited(AS Per Census)</B>
				    </legend>
				    <label>
			 		<table cellpadding="0" cellspacing="3" border="0"   
				   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
				   <tr class="textborder">
				   <td>Plain: <html:text property="revPlainPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Sc: <html:text property="revScPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   St: <html:text property="revSTPopu"  styleClass="mytext"   readonly="true" style="width:80px"  />  
				   Total: <html:text property="revTotpopu"  styleClass="mytext"   readonly="true" style="width:80px"  /> </td>
				   </tr>
			   </table> </label></fieldset>
			   </td></tr>
			   <%}%>
	 	</table></label></fieldset>
		</td></tr>
		</c:if>
		  <c:if test="${requestScope.Includepage =='02'}">
	  <%@ include file="/works/rws_works_tecSanction.jsp" %>
	</c:if>  
	 <c:if test="${requestScope.Includepage =='03'}">
	  <%@ include file="/works/Work_Status_Source_Form.jsp"%>
 	</c:if>  
	<c:if test="${requestScope.Includepage =='04'}">
	  <%@ include file="/works/rws_works_contractor.jsp" %>
 	</c:if>
 	<c:if test="${requestScope.Includepage =='05'}">
	  <%@ include file="/works/Work_Status_WIP_Form.jsp"%>
 	</c:if>
 	<%-- <c:if test="${requestScope.Includepage =='06'}">
	  <%@ include file="/works/Work_Status_Work_Exp_Form.jsp"%>
 	</c:if> --%>
 	<c:if test="${requestScope.Includepage =='07'}">
	  <%@ include file="/works/Work_Status_WorkComp_Form.jsp"%>
 	</c:if>
 	</table>		
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="855"/>
</jsp:include>
</html:form>
<table>
<tr><td colspan="2"><font face="verdana" size="2" color="red">Note********:</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">1. You Cannot edit any phase if work is Financially Completed.</td></tr>
<!-- <tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">2. You Can Edit Work Expenditure phase, Work Completion Phase until the Work is Financially Completed.</td></tr> -->
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">2. You Cannot Cancel the work if work is already Completed(either Physically or Financially) or Commissioned.</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">3. Work Cancellation done by Head Office Only.</td></tr>
</table></body>
<%@ include file="/commons/rws_footer.jsp"%>
<%
 if(session.getAttribute("message")!=null)
 {	
	 String message=(String)session.getAttribute("message");
session.removeAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>
