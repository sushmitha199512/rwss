<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
 <%
	String leadHab = (String)request.getAttribute("leadHab");
	String pwswork = (String)request.getAttribute("pwsWork");
	System.out.println("leadHab:"+leadHab);
	String page2 = (String)request.getAttribute("Includepage2");
	String augConvertConfirm = (String)request.getAttribute("augConvertConfirm");
	System.out.println("Includepage2:"+request.getAttribute("Includepage2"));
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	System.out.println("user id:"+userid);%>
 <html:javascript formName="WorkForm"/>
<c:set var="schemeCode" value="${WorkForm.assetTypeCode}" scope="request"/> 
<%String schemeCode = (String)request.getAttribute("schemeCode");
System.out.println("schemeCode:"+schemeCode);%>
<SCRIPT LANGUAGE="JavaScript">
 function addSubComponents()
 {
	 var url="switch.do?prefix=/masters&page=/Asset.do&mode=data&spMode=modeScheme&component=pumpCodeChanged&assetTypeCode="+document.forms[0].assetTypeCode.value+"&habCode="+document.forms[0].habCode.value+"&pumpCode="+document.forms[0].pumpCode.value+"&opType=Modify&circleOfficeCode="+document.forms[0].circleCode.value+"&divisionOfficeCode="+document.forms[0].divisionOfficeCode.value+"&subdivisionOfficeCode="+document.forms[0].subdivisionOfficeCode.value+"&convtype=yes&mandal="+document.forms[0].mandal.value+"";
	 //alert(url);
	var popFeatures = "width=950,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	myWin = window.open(url,'addSubcomp',popFeatures);
	myWin.focus();
	//	 document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data&component=pumpCodeChanged";
	// document.forms[0].submit();
 }
 function checkConvertedOrNot()
 {
		var pg2 = '<%=page2%>';
		if(pg2=='02')
		{
			document.getElementById('addandrefresh').style.display='block';
		}
 }
 function refreshTheView()
 {
	 document.getElementById('mode').value='getWorkStatus';
	 submitPage();
 }
 function convertSchemeToAsset()
 {
 	if(document.forms[0].assetTypeCode.value=="01")
 	{
 		//if(confirm("Press OK to Convert this PWS Scheme to MPWS/HAND PUMP/SHALLOW HAND PUMP/OPEN WELL/PONDS \n Press CANCEL to Convert as PWS Asset"))
 		//{
 			//var zURL="switch.do?prefix=/works&page=/SchemeAsset.do&mode=changeAssetType&workId="+document.forms[0].workId.value;
			//var popFeatures = "width=450,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
			//myWin = window.open(zURL,'changeAType',popFeatures);
			//myWin.focus();	
		//	document.forms[0].action="switch.do?prefix=/works&page=/SchemeAsset.do&mode=changeAssetType&workId="+document.forms[0].workId.value;
		//	document.forms[0].submit();
  		//}
  		//else
		//{
			var url="switch.do?prefix=/works&page=/SchemeAsset.do&mode=save&workId="+document.forms[0].workId.value+"&totPopBenfit="+document.forms[0].totPopBenfit.value;
			ajaxFunction(url,document.getElementById("mydivid"));
		//}
 	}
	else if(confirm("Do You want to Convert Scheme to Asset"))
	{
		var url="switch.do?prefix=/works&page=/SchemeAsset.do&mode=save&workId="+document.forms[0].workId.value+"&totPopBenfit="+document.forms[0].totPopBenfit.value;
		ajaxFunction(url,document.getElementById("mydivid"));
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
//				document.getElementById('converted').style.display='none';
				document.getElementById('addandrefresh').style.display='block';
				//submitPage();
			  }
			  else{
				  document.getElementById('convert').style.display='none';
				  document.getElementById('load').style.display='block';
			  }
			}
			xmlHttp.open("POST",URL,true);
			xmlHttp.send(null);  
		}
function checkLeadHab()
{
	var leadHab = '<%=leadHab%>';
	if(leadHab=='Y')
	{
//		alert("open new window for choosing lead habitation");
		var zURL="switch.do?prefix=/works&page=/SchemeAsset.do&mode=leadHab&workId="+document.forms[0].workId.value;
	//	alert(zURL);
		var popFeatures = "width=450,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'leadHab',popFeatures);
		myWin.focus();	
	}
}
function checkPwsWork()
{
	var pwsWork = '<%=pwswork%>';
	if(pwsWork=='Y')
	{
		var zURL="switch.do?prefix=/works&page=/SchemeAsset.do&mode=changeAssetType&workId="+document.forms[0].workId.value;
		var popFeatures = "width=450,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'changeAType',popFeatures);
		myWin.focus();
	}
}
function augConvertConfirm()
{
	var augConvertConfirm = '<%=augConvertConfirm%>';
	if(augConvertConfirm=='Y')
	{
		if(confirm("Click OK to Convert this Scheme to New Asset\nClick CANCEL to treat this Scheme as Augmentation to the Linked MainScheme"))
		{
			document.getElementById('mode').value='getWorkStatus';
			submitPage();
		}
		else
		{
			document.getElementById('mode').value='getAugDetailsNextStep';
			submitPage();
		}
	}
	
}
function addRemarks()
 {
	var zURL="switch.do?prefix=/works&page=/SchemeAsset.do&mode=addRemarks&workId="+document.forms[0].workId.value;
	var popFeatures = "width=450,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'expenditure',popFeatures);
	myWin.focus();	
}

 function validatePercentage()
 {
	
 }
 function init1()
 {
	 document.getElementById('a').style.display=='none';
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
	 document.forms[0].wrktype[2].checked=true;
	 document.forms[0].wrktype[0].disabled=true;
	 document.forms[0].wrktype[1].disabled=true;
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
	document.forms[0].action="switch.do?prefix=/works&page=/SchemeAsset.do";
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
  function getSubDivisions1()
 {
 document.getElementById('mode').value='subdiv1';
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
 function getWorks()
 {
   document.getElementById('mode').value='workcombo';
   submitPage();
 }
 function getWorksDetails()
 {
	if(document.forms[0].wrktype[1].checked==true)
	 {
//		alert("aug");
		document.getElementById('mode').value='getAugDetails';
	 }
	 else
	 {
		document.getElementById('mode').value='getWorkStatus';
	//	 alert("non aug");
	 }
	  submitPage();
 }
 function validation()
{
alert("Select Circle Program Work");
}
 
    function getFormmandal()
	{
		document.getElementById('siMode').value='mandals';
		document.forms[0].action="/pred/works/SchemeAsset.do?mode=mandals";
		document.forms[0].submit();
	}
	function getFormSource()
	{
		document.getElementById('siMode').value='source';
		document.forms[0].action="/pred/works/SchemeAsset.do?mode=source";
		document.forms[0].submit();
	}
	function getFormSrctype()
	{
		document.getElementById('siMode').value='srctype';
		document.forms[0].action="/pred/works/SchemeAsset.do?mode=srctype";
		document.forms[0].submit();
	}
	function getFormSubSource()
	{
		document.getElementById('siMode').value='sources';
		document.forms[0].action="/pred/works/SchemeAsset.do?mode=data";
		document.forms[0].submit();
	}
	function getForm()
	{
		document.getElementById('siMode').value='existNew';
		document.forms[0].action="/pred/works/SchemeAsset.do?mode=data";
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
		 		document.forms[0].action ="/pred/works/SchemeAsset.do?mode=save";
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
		 		document.forms[0].action ="/pred/works/SchemeAsset.do?mode=save";
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
			document.forms[0].action="/pred/works/SchemeAsset.do?mode=delete";
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
			document.forms[0].action="/pred/works/SchemeAsset.do?mode=delete";
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
	//end of the source identification script
   function openDdwsForm()
   {
      var chkVal;
      var workStage;
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
   var url="switch.do?prefix=/works&page=/SchemeAsset.do?mode=admnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
function showTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/SchemeAsset.do?mode=tsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
function aa()
{
alert("hi");
}
function showRevTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/SchemeAsset.do?mode=revTsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
 function showRevhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/SchemeAsset.do?mode=revAdmnHabs&workId="+workId+"&workStage=";
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
}					}
		}
</SCRIPT>
<script>
function submitComplaint()
	{
		var userid = '<%=userid%>';
		var urlnew = "works/feedback.jsp?userid="+userid;
		//alert(urlnew);
		window.open(urlnew,"feedBackPage","width=500,height=500,scrollbar=yes");
	}
function ViewComplaint()
		{
			window.open("works/ViewFeedBacks.jsp","viewfeedBackPage","width=900,height=600,left=50,top=50,scrollbar=yes");
		}
var t1=null;
var l1="table place here";
var l2="Tooltip for line two";
function init()
{
 document.getElementById('a').style.display='none';
 t1 = new ToolTip("a",true,80);
}
function abc()
{
	//alert(document.getElementById('a').style.display);
	if(document.getElementById('a').style.display=='none')
	{t1.Show(event,l1);}
	else
	{t1.Hide(event);}
}
</script>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/slidebox.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/Tooltip1.js'/>"></script>

<body  onload="checkMe();checkLeadHab();checkPwsWork();checkConvertedOrNot();init();augConvertConfirm();">
<html:form  action="SchemeAsset.do?mode=circles1" enctype="multipart/form-data"  onsubmit="return validateWorkForm(this)" >
<html:hidden property="mode"/>
<div id="a" style="background-color:white;width:350px; height: 49px;filter: alpha(Opacity=125);
opacity:0.15;border: solid 1px gray; background-image: url(./images/bg.jpg); text-align: center;display=none;overflow=scroll">
</div>
<%
	if(userid!=null && (userid.equals("100000") || userid.equals("admin")))
	{
	%>
<p align=right>
<font face=verdana size=2 color=blue><a href="#" onClick="ViewComplaint()" title="Click to View FeedBacks">View Suggestion/Feed Back </a>
</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<%}else{%>
<p align=right>
<font face=verdana size=2 color=blue><a href="#" onClick="submitComplaint()" title="Click to Submit FeedBack">Give Suggestion/Feed Back </a>
</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<%}%>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Scheme to Asset Integration" />
	<jsp:param name="TWidth" value="920" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Office Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="4" border="0"   
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<logic:present name="circles">
			<logic:notPresent name="fixcircle">
				<td class="textborder" >Circle<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo" onchange="javascript:init();getDivisions();" >
					<html:option value=""><font class="myfontclr1">Select...</html:option>
					<html:options collection="circles"   property="value" labelProperty="label" />
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
		 	<td class="textborder">SubDivision<span class="mandatory">*</span></td>
				<td class="textborder">
				<html:select property="subdivisioncode" style="width:143px" styleClass="mycombo" onchange="javascript:init();getSubDivisions1();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="subdivs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="subdivs">
			
				<td class="textborder">SubDivision<span class="mandatory">*</span></td>
				<td class="textborder">
		        <html:select property="subdivisioncode" style="width:143px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent></td>
		</tr>
		<tr>
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
		<td class="textborder">
		Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:143px" styleClass="mycombo" onchange="init();getProgrammes();">
		<html:option value="">Select...</html:option>
		<logic:present name="workCategory">
		<html:options collection="workCategory" property="value" labelProperty="label"/> 
		</logic:present>
		</html:select>
		</td>
		</tr>
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
        <td>
		     <html:select property="subprogram" style="width:143px" styleClass="mycombo" onchange="JavaScript:init();getWorks();">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
		</tr>
		
		<tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Commissioned Works<span class="mandatory">*</span></td>
				<td class="textborder" colspan="6"  >
		        <html:select property="workId" style="width:643px" styleClass="mycombo" onchange="JavaScript:init();getWorksDetails();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="rwsWorks"   property="workId" labelProperty="workName" />
	            </html:select>
				<!-- </td>
				<td>Scheme</td>
			    <td> -->   Scheme&nbsp;&nbsp;<html:text property="scheme"  styleClass="mytext"  maxlength="10"  style="width:80px" readonly="true"/></td>
			</logic:present>
			<logic:notPresent name="rwsWorks">
				<td class="textborder" >Commissioned Works<span class="mandatory">*</span></td>
				<td class="textborder" colspan="4">
		        <html:select property="workId" style="width:527px" styleClass="mycombo"  >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
				<td>Scheme</td>
			    <td><html:text property="scheme"  styleClass="mytext" maxlength="10"style="width:80px" readonly="true"/></td>
	 		</logic:notPresent>
	 		</tr>
	 		</table>
		   </label>
		 </fieldset>
    <!-- admin sanction form -->
	<!-- end -->
	<c:if test="${requestScope.Includepage1 =='01'}">
	  <%@ include file="/works/rws_Scheme_AssetDetails_frm.jsp" %>
	</c:if>
	<c:choose>
		<c:when test="${requestScope.buttonDisableStatus =='N'}">
		<tr><td align="center">
			<div id="convert" style="display:block">
				<html:button property="mode" value="Convert Scheme to Asset" styleClass="btext" onclick="convertSchemeToAsset()"/>
			</div>
			<div id="load" style="position:relative;overflow-y:auto;left:15;height:100;width:270;top:5;display:none"><img src="images/loading322.gif"/></div>
			</td></tr>
		</c:when>
		<c:otherwise>
		<tr><td align="center">
		<div id="converted" style="display:none">
			<html:button property="mode" value="Scheme Already Converted to Asset" styleClass="btext" onclick="convertSchemeToAsset()" disabled="true"/>
		</div>
		<div id="load" style="position:relative;overflow-y:auto;left:15;height:100;width:270;top:5;display:none"><img src="images/loading322.gif"/></div>
		</td></tr>
		</c:otherwise>
	</c:choose>
	<tr><td align="center" colspan=4>
		<div id="addandrefresh" style="position:relative;overflow-y:auto;top:5;display:none">
		<img src="images/add12.png" alt="Click to Add SubComponents" onClick="addSubComponents()"/>&nbsp;&nbsp;&nbsp;<img src="images/refresh_icon1.png" alt="Click to View/Refresh the SubComponents" onclick="refreshTheView()" /></div>
	</td></tr>
	<c:if test="${requestScope.Includepage2 =='02'}">
		<%@ include file="/works/rws_Scheme_Asset_SubComp_Yield_frm.jsp" %>
	</c:if>
</table>		
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="920"/>
</jsp:include>
<p align=left>
<font face="verdana" size="2" color="red">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note:**** 1. Scheme will be converted to Asset based on Lead Habitation of this Scheme<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. Division, Sub Division, Mandal details populated by Lead Habitation<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Only Sub Division Works Displayed<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Only PWS, CPWS, MPWS Works displayed.
</font>
</p>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
