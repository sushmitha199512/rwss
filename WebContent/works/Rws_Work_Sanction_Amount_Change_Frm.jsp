<%@page import="nic.watersoft.works.rws_works_WorkStatus_bean"%>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
 <% userid = users.getUserId();%>
  <html:javascript formName="WorkForm"/>

 <SCRIPT LANGUAGE="JavaScript">
 function fnUpdate(){
	 if(document.forms[0].workId.value=="")
		{
			
			alert("Please Select Work");
			return false;
		}
	 else if(document.forms[0].sanctionAmountChange.value==""){
		 alert("Please Change Sanction Amount for Work");
			return false;
	 }
	 else{
		 document.forms[0].action="switch.do?prefix=/works&page=/WorkSanctionAmount.do?mode=update";
		   document.forms[0].submit();
	 }
 }
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
	// document.forms[0].wrktype[2].checked=true;
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
	
	document.forms[0].action="switch.do?prefix=/works&page=/WorkSanctionAmount.do";
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
     function submitPageWorkExpenditure()
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
		  } }
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
	xmlHttp.open("POST",URL,true);
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
</SCRIPT>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/slidebox.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/Tooltip1.js'/>"></script>
<body  onload="hideRev();checkMe();firstMakeEdit();validatePercentage()">
<html:form  action="WorkSanctionAmount.do?mode=circles1" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<html:hidden property="mode"/><html:hidden property="tsMode"/>
<html:hidden property="siMode"/><html:hidden property="psMode"/>
<html:hidden property="weMode"/><html:hidden property="wcMode"/>
<html:hidden property="conMode"/><html:hidden property="revAdminNo"/><html:hidden property="revTsMode"/>
<html:hidden property="nmode"/>
<% 
	String csrfToken="";
	nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
	csrfToken = valUtil.getCSRFCode();
	session.setAttribute("csrfToken",csrfToken);
%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
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
<table  border=0 rules=none style="border-collapse:collapse" width=90% align="right">		
				<tr>
					 <!-- sairam 05-09-2022
					  <td align="right" class="bwborder"><a href="/pred/admin/rws_general_admn_loginsuccess.jsp">Home|&nbsp; </td>  
					   -->
				<!-- added by sairam -->   <td align="right" class="bwborder"><a href="/pred/home.jsp">Home|&nbsp; </td>  
					<td ><a href="javascript:onclick=history.go(-1)">Back </td>
				</tr>
			</table>
			<br/>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Work Sanction Amount Change" />
	<jsp:param name="TWidth" value="855" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >

<tr><td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enter WorkId:<html:text    property="nwork" maxlength="14"  styleClass="mytext" onkeypress="return isNumberKey(event)" ></html:text> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Get Details "  onclick="getWorkDetails()"></td></tr>
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
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo"  onchange="javascript:getDivisions();" >
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
		        <html:select property="divCode" style="width:143px" styleClass="mycombo" onchange="javascript:getSubDivisions();" >
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
				<html:select property="subdivisioncode" style="width:143px" styleClass="mycombo" onchange="javascript:getSubDivisions();" >
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
		<html:radio property="plan" value="1" onclick="checkMe();getProgrammes();">Plan</html:radio>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <html:radio property="plan" value="2" onclick="checkMe();getProgrammes();">Non Plan</html:radio>
		</td>
		<td class="textborder" colspan="3">
        <html:radio property="wrktype" value="1" onclick="getProgrammes();">MainScheme</html:radio>
        <html:radio property="wrktype" value="2" onclick="getProgrammes();">Augmentation</html:radio>
        <html:radio property="wrktype" value="3" onclick="getProgrammes();">Maintenance</html:radio>
		</td>
		<td class="textborder">Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="JavaScript:getProgrammes();">
		<html:option value="">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/> 
		</logic:present>
		</html:select>
		</td></tr>
		<tr>
		<td class="textborder">Programme<span class="mandatory">*</span></td>
		<td>
		    <html:select property="program" style="width:143px" styleClass="mycombo" onchange="JavaScript:getSubprogrammes();">
			<html:option value="">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	   </td>
	   <td  class="textborder">SubProgramme<span class="mandatory">*</span></td>
        <td colspan=2>
		     <html:select property="subprogram" style="width:143px" styleClass="mycombo" onchange="JavaScript:getWorks();">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
        <td  class="textborder">Schemes<span class="mandatory">*</span></td>
        <td>
		    <html:select property="schemelist" style="width:143px" styleClass="mycombo"  onchange="JavaScript:getWorks();"  >
			<html:option value="">Select...</html:option>
			<logic:present name="assettypes"> 
			<html:options collection="assettypes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td></tr>
        
		<tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6"  >
		        <html:select property="workId" style="width:643px" styleClass="mycombo" onchange="JavaScript:getWorksDetails();" >
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
					<!-- &nbsp;Reasons For Not Grounding: -->
				<c:set var="physicalStatusDetails" value="${WorkForm.physicalStatusDetails}" scope="request"/>
				 
					<%} %>
				</td>
	 		</tr><%}%>
	 		
	 	   </table></label> </fieldset>
   
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Administrative Sanction (Amount In Rs.Lakhs)</B></legend>
		<label>
		<table cellpadding="0" cellspacing="7" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	 		<tr>
	 		<td colspan="10">
	   		  <fieldset>
			    <legend ><B></B> </legend>
			    <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Admin Sanction No</td>
					     <td class="clrborder" align="center">Admin Sanction Date</td>
						 <td class="clrborder" align="center">Admin Sanctioned Amount</td>
					     <td class="clrborder" align="center">Programme</td>
					     <td class="clrborder" align="center">Sub programme</td>
					     <td class="clrborder" align="center">Sanction Amount Change</td>
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
						  <td class="clrborder" align="center"> 
						  <html:text property="sanctionAmountChange"  styleClass="gridtext"    />
						  </td>
					 </tr>
					
	 	        </table> </label>  </fieldset>
			   </td> </tr>
	 	 	
	 	</table></label></fieldset>
		</td></tr> 
		<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Bill Details</B></legend>
		<label>
		<table cellpadding="0" cellspacing="7" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	 		<tr>
	 		<td colspan="10">
	   		  <fieldset>
			    <legend ><B></B> </legend>
			    <label>
		 		<table   width="728" bgcolor="#ffffff" cellpadding="0" cellspacing="0" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <tr class="clrborder">
					     <td class="clrborder" align="center">S.No.</td>
					     <td class="clrborder" align="center">Bill No</td>
					     <td class="clrborder" align="center">Bill Send Date</td>
						 <td class="clrborder" align="center">Bill Amount(in Rs.)</td>
					     <td class="clrborder" align="center">Transaction Id</td>
					  </tr> 
					 <logic:present name="bills">
					  <%int i=1; %>
					  <nested:iterate id="bills" name="bills">
				 	  <tr>
					  <td class="bwborder" align="center">
					  <%=i++ %>
					  </td>
					  <td class="bwborder" align="right">
					 	  <nested:text name="bills" property="billSlNo" styleClass="gridtext" indexed="true" readonly="true" />
					  </td>
					  <td class="bwborder" align="right">
					 	  <nested:text name="bills" property="billDate" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  <td class="bwborder" align="right">
					 	  <nested:text name="bills" property="billReleaseAmount" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  
					  <td class="bwborder" align="right">
					 	  <nested:text name="bills" property="billNo" styleClass="gridtext" indexed="true" readonly="true"/>
					  </td>
					  
					  
					  </tr>
					  </nested:iterate>
					 </logic:present>
	 	        </table> </label>  </fieldset>
			   </td> </tr>
	 	 	<tr>
	 	 	<td colspan="9" align="center"><html:button property="mode" styleClass="btext" value="update" 
				  		 onclick="fnUpdate() " title="Click to update data"/> 
	 	 	</tr>
	 	</table></label></fieldset>
		</td></tr> 
		
 	</table>		
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="855"/>
</jsp:include>
</html:form>
<table>
<!-- <tr><td colspan="2"><font face="verdana" size="2" color="red">Note********:</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">1. You Cannot edit any phase if work is Financially Completed.</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">2. You Can Edit Work Expenditure phase, Work Completion Phase until the Work is Financially Completed.</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">3. You Cannot Cancel the work if work is already Completed(either Physically or Financially) or Commissioned.</td></tr>
<tr><td style="width:15px">&nbsp;</td><td><font face="verdana" size="2" color="red">4. Work Cancellation done by Head Office Only.</td></tr> -->
</table></body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

