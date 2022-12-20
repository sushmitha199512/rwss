<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp" %>
 <%
 System.out.println("in ddws jsp");
String p = (String)request.getAttribute("proove");
				System.out.println("P Value:"+p);
				if(p==null)p="";

java.util.ArrayList wqlist = new java.util.ArrayList();
wqlist = (java.util.ArrayList)request.getAttribute("wqlist");
if(wqlist==null)
{
	wqlist = new java.util.ArrayList(18);
	for(int i=0;i<18;i++)
	{
		wqlist.add(i,"N");
	}
}
String goi = (String)request.getAttribute("goi");
if(goi==null)goi="0";
String state = (String)request.getAttribute("state");
if(state==null)state="0";
String comm1 = (String)request.getAttribute("comm");
if(comm1==null)comm1="0";
String comm = (String)request.getAttribute("proove");
String prooveno = "0";
if(comm!=null && comm.equals("Normal Coverage"))
{
prooveno = "1";
}
else if(comm!=null && comm.equals("Submission(Water Quality)"))
{
prooveno = "2";
}
else if(comm!=null && comm.equals("Sustainability"))
{
prooveno = "3";
}
 %>
 <html:javascript formName="WorkForm"/>
 <SCRIPT LANGUAGE="JavaScript">
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
	 var proov = <%=prooveno%>;
	var goi = <%=goi%>;
	var state = <%=state%>;
	var comm = <%=comm1%>;
	if(proov=="1")
	{
		document.forms[0].goi1.value = goi;
		document.forms[0].state1.value = state;
		document.forms[0].comm1.value = comm;
	}
	else if(proov=="2")
	{
		document.forms[0].goi2.value = goi;
		document.forms[0].state2.value = state;
		document.forms[0].comm2.value = comm;
	}
	else if(proov=="3")
	{
		document.forms[0].goi3.value = goi;
		document.forms[0].state3.value = state;
		document.forms[0].comm3.value = comm;
	}
 }
 function submitPage()
 {
   document.forms[0].action="switch.do?prefix=/works&page=/ddws.do";
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
 function getData()
 {
   document.getElementById('mode').value='getData';
   submitPage();
 }
 function validation()
{
alert("Select Circle Program Work");
}
 
 function includePage()
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
		 if(workStage=='01')
		     document.getElementById('mode').value='details';
		  else
		  document.getElementById('mode').value='';
		 if(workStage=='02')
		 {
		  document.getElementById('tsMode').value='data'
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
		  }
		  
   }
   function includePageWm()
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
        if(workStage=='03')
        {
        chkVal='sitePrep';
        }
        if(workStage=='04')
        {
        chkVal='contMgnt';
        }
        if(workStage=='05')
        {
        chkVal='wip';
        }
        if(workStage=='06')
        {
        chkVal='Wexp';
        }
        if(workStage=='07')
        {
        chkVal='workComp';
        }
         
     var div=document.getElementById('divCode').value;
     var workId=document.getElementById('workId').value;
     var cmbCircle=document.getElementById('circleCode').value;
     
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
		//  if(document.getElementById('program').value=='')
		//   {
		//   if(message!='')
		//    {
		//    message=message+',';
		//    }
		 //    message=message+'Program';
		 //  }
		   //if(document.getElementById('subprogram').value=='')
		  // {
		  // if(message!='')
		 //   {
		  //  message=message+',';
		  //  }
		   //  message=message+'SubProgram';
		  // }
		   if(document.getElementById('workId').value=='')
		   {
		   if(message!='')
		    {
		    message=message+',';
		    }
		     message=message+'Work '
		   }
     
     if(workStage=='06' && message=='')
     {
      	 	document.forms[0].action="/pred/works/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&mode=data";
    	 	document.forms[0].submit();
      }
     else if(workStage=='07' && message=='')
     {
      	 	document.forms[0].action="switch.do?prefix=/works&page=/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&mode=data";
    	 	document.forms[0].submit();
      }
      else if(workStage=='03' && message=='')
     {
      	 document.forms[0].action="switch.do?prefix=/works&page=/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle+"&spradgroup=newSrc";
	     document.forms[0].submit();
      }
      else if(message=='')
     {
        
	     document.forms[0].action="switch.do?prefix=/works&page=/ddws.do?cmbDivision="+div+"&cmbWorks="+workId+"&radgroup="+chkVal+"&cmbCircle="+cmbCircle;
	     document.forms[0].submit();
     }
     else
     {
     alert("Select "+message);
     }
   }
 function showhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/ddws.do?mode=admnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
function showTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/ddws.do?mode=tsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
function showRevTshabDetails()
{
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/ddws.do?mode=revTsHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
}
 function showRevhabDetails()
 {
   var workId=document.getElementById('workId').value;
   var url="switch.do?prefix=/works&page=/ddws.do?mode=revAdmnHabs&workId="+workId+"&workStage=";
   var prop="top=100,left=0,height=300,width=600,location=0,scrollbars=1,directories=0,toolbar=no,resizable=1,status=1";
   window.open(url,'',prop);
 }
 function validate()
 {
 	var approved = document.forms[0].prooved.value;
 	var a="";var b=""; var c="";var d="";var e="";
 	if(approved == "Normal Coverage")
 	{
	 	b = document.forms[0].goi1.value;
	 	c = document.forms[0].state1.value;
	 	d = document.forms[0].comm1.value;
 	}
 	else if(approved == "Submission(Water Quality)")
 	{
	 	b = document.forms[0].goi2.value;
	 	c = document.forms[0].state2.value;
	 	d = document.forms[0].comm2.value;
 	}
 	else if(approved == "Sustainability")
 	{
	 	b = document.forms[0].goi3.value;
	 	c = document.forms[0].state3.value;
	 	d = document.forms[0].comm3.value;
 	}
	e = parseInt(b)+parseInt(c)+parseInt(d);
		document.forms[0].goi.value = b;
		document.forms[0].state.value = c;
		document.forms[0].comm.value = d;
		var est = document.getElementById('estCost').value;
		if(est=="")
		{
			est = 0;
		}
	if(document.forms[0].workId.value == null || document.forms[0].workId.value == "")
 	{
 		alert("Select Work Id");
 		return false;
 	}
 	if(document.forms[0].prooved.value == null || document.forms[0].prooved.value == "")
 	{
 		alert("Select Approved Under");
 		return false;
 	}
 	else if(est<e)
	{
		if(confirm("The total Value of GOI Share, State/Other Share and Community Contribution is Exceed with Estimate Cost!\n Do You Want to Continue!!"))
		{
			return true;
		}
		else
		{
			return false;
		}
		
	}
 	else
 	{
 		return true;
 	}
 	//else if(a < e)
 //	{
 	//	alert("Total of GOI Share,State Share,Community Distribution is Exceed With Estimate Capital Cost");
 //		return true;
 	//}
 	
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
function showWindow()
{
 	document.forms[0].goi.value='';
 	document.forms[0].state.value='';
 	document.forms[0].comm.value='';

	if(document.forms[0].prooved.value == "Submission(Water Quality)")
	{
		document.getElementById('normal').style.display='none';
		document.getElementById('submission').style.display='block';
		document.getElementById('sustainability').style.display='none';
	}
	else if(document.forms[0].prooved.value == "Normal Coverage")
	{
		document.getElementById('normal').style.display='block';
		document.getElementById('submission').style.display='none';
		document.getElementById('sustainability').style.display='none';
	}
	else if(document.forms[0].prooved.value == "Sustainability")
	{
		document.getElementById('normal').style.display='none';
		document.getElementById('submission').style.display='none';
		document.getElementById('sustainability').style.display='block';
	}
	else
	{
		document.getElementById('normal').style.display='none';
		document.getElementById('submission').style.display='none';
		document.getElementById('sustainability').style.display='none';
	}

}
</SCRIPT>
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
 
<body onload="checkMe();showWindow();">
<html:form  action="ddws.do?mode=insert" enctype="multipart/form-data"  onsubmit="return validate()" >
<html:hidden property="mode"/>
<html:hidden property="tsMode"/>
<html:hidden property="conMode"/>
<html:hidden property="revAdminNo"/>
<html:hidden property="revTsMode"/>
 <%System.out.println("1"); %>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="DDWS Data Entry Form" />
	<jsp:param name="TWidth" value="872" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >
	<tr>
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
		        <html:select property="circleCode" style="width:143px" styleClass="mycombo" onchange="getDivisions()" >
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
		        <html:select property="divCode" style="width:143px" styleClass="mycombo" onchange="getSubDivisions()" >
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
				<html:select property="subdivisioncode" style="width:153px" styleClass="mycombo" onchange="JavaScript:init();" >
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="subdivs"   property="value" labelProperty="label" />
	             </html:select>
				</td>
			</logic:present>
			<logic:notPresent name="subdivs">
			
				<td class="textborder">SubDivision</td>
				<td class="textborder">
		        <html:select property="subdivisioncode" style="width:153px" styleClass="mycombo">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
			</logic:notPresent></td>
		</tr>
		<tr>
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
		<td class="textborder">
		Work Category<span class="mandatory">*</span></td>
		<td>
		<html:select property="workCat" style="width:153px" styleClass="mycombo" onchange="getProgrammes();">
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
		    <html:select property="program" style="width:143px" styleClass="mycombo" onchange="getSubprogrammes()">
			<html:option value="">Select...</html:option>
			<logic:present name="programmes"> 
			<html:options collection="programmes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	   </td>
	   
	   <td  class="textborder">SubProgramme<span class="mandatory">*</span></td>
        <td>
		     <html:select property="subprogram" style="width:153px" styleClass="mycombo" onchange="getWorks()">
			<html:option value="">Select...</html:option>
			<logic:present name="subprogrammes"> 
			<html:options collection="subprogrammes" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
	    </td>
		</tr>
		
		<tr class="textborder">
			<logic:present name="rwsWorks">			 
				<td class="textborder">Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="4"  >
		        <html:select property="workId" style="width:527px" styleClass="mycombo" onchange="getWorksDetails()">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            <html:options collection="rwsWorks"   property="workId" labelProperty="workName" />
	            </html:select>
				</td>
				<td>Approved Under<span class="mandatory">*</span></td>
				<%if(p.equals("")){
				System.out.println("in all");%>
				<td>
					<html:select property="prooved" styleClass="mycombo" style="width:153px" onchange="showWindow()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="Normal Coverage">Normal Coverage</html:option>
					<html:option value="Submission(Water Quality)">Submission(Water Quality)</html:option>
					<html:option value="Sustainability">Sustainability</html:option>
					</html:select>
				</td>
				<%}else{
				System.out.println("in one");
				 %>
	        	<td class="textborder">
					<html:text property="prooved" style="width:153px" readonly="true"/>
				</td>
				<%} %>
			</logic:present>
			<logic:notPresent name="rwsWorks">
				<td class="textborder" >Work<span class="mandatory">*</span></td>
				<td class="textborder" colspan="4">
		        <html:select property="workId" style="width:527px" styleClass="mycombo" onchange="getWorksDetails()">
	            <html:option value=""><font class="myfontclr1">Select...</html:option>
	            </html:select>
				</td>
				<td>Approved Under<span class="mandatory">*</span></td>
        	
	        	<%
	        	System.out.println("The P value:"+p);
	        	if(p.equals("")){
	        	System.out.println("in all");%>
				<td>
					<html:select property="prooved" styleClass="mycombo" style="width:153px" onchange="showWindow()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="Normal Coverage">Normal Coverage</html:option>
					<html:option value="Submission(Water Quality)">Submission(Water Quality)</html:option>
					<html:option value="Sustainability">Sustainability</html:option>
					</html:select>
				</td>
				<%}else{System.out.println("in one");
				 %>
	        	<td class="textborder">
					<html:text property="prooved" style="width:153px" readonly="true"/>
				</td>
				<%} %>
				
	 		</logic:notPresent>
	 		 <%System.out.println("222@@@@@@@1"); %>
	 		</tr>
	 	   </table>
		   </label>
		 </fieldset>
		 <tr>
	<td align="right"><font face="verdana" color="red" size="2"><b>*</b>Amount Should Be In Lakhs.</font></td>
	</tr>
	<tr>
	<td>
	<div id="normal" style="position:relative;overflow-y:auto;left:0;height:126;top:0;display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;width:908px" >
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Estimate Capital Cost</td>
				<td class="textborder" colspan="2"><html:text property="estCost" readonly="true"/><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">GOI Share</td>
				<td class="textborder" colspan="2"><input type="text" name="goi1"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">State/Other Share</td>
				<td class="textborder" colspan="2"><input type="text" name="state1"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Community Contribution Deposited(Cash+Kind+Labour)</td>
				<td class="textborder" colspan="2"><input type="text" name="comm1"><font color="red" face="verdana" size="2"></font></td>
			</tr>
		</table>
	</div>
	<div id="submission" style="position:relative;overflow-y:auto;left:0;height:350;top:0;display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
			<tr>
				<td class="textborder" style="width:175px">&nbsp;</td>
				<td class="textborder" style="width:125px" >Physical</td>
				<td class="textborder"  style="width:255px">Chemical</td>
				<td class="textborder"  style="width:175px">Bacteriological</td>
				<td class="textborder"  style="width:175px">Others</td>
			</tr>
			<tr>
				<td class="textborder" style="width:175px">Contamination Tackled</td>
				<%if(wqlist!=null && wqlist.get(0).equals("Y")){ %>
				<td class="textborder" style="width:125px" ><input type="checkbox" name="phy" value="Turbidity" checked>Turbidity</td>
				<%} else{%>
				<td class="textborder" style="width:125px" ><input type="checkbox" name="phy" value="Turbidity">Turbidity</td>
				<%} %>
				<td class="textborder"  style="width:255px">
					<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
						<tr>
						<%if(wqlist!=null && wqlist.get(1).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic" checked>Arsenic</td>
						<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic">Arsenic</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(2).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride" checked>Fluoride</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride">Fluoride</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(3).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Iron" checked>Iron</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Iron">Iron</td>
							<%}%>
							<%if(wqlist!=null && wqlist.get(4).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Chloride" checked>Chloride</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Chloride">Chloride</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(5).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate" checked>Nitrate</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate">Nitrate</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(6).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Sulphates" checked>Sulphates</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Sulphates">Sulphates</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(7).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Calcium" checked>Calcium</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Calcium">Calcium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(8).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Magnesium" checked>Magnesium</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Magnesium">Magnesium</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(9).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Manganese" checked>Manganese</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Manganese">Manganese</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(10).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Copper" checked>Copper</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Copper">Copper</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(11).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity" checked>Salinity</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity">Salinity</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(12).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="TDS" checked>TDS</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="TDS">TDS</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(13).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Hardness" checked>Hardness</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Hardness">Hardness</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(14).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Residual Chlorine" checked>Residual Chlorine</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Residual Chlorine">Residual Chlorine</td>
							<%} %>
						</tr>
						<tr>
							<%if(wqlist!=null && wqlist.get(15).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Alkalinity" checked>Alkalinity</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Alkalinity">Alkalinity</td>
							<%} %>
							<td class="textborder">&nbsp;</td>
						</tr>
					</table>
				</td>
				<%if(wqlist!=null && wqlist.get(16).equals("Y")){ %>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="bac" value="Faecal ColiForm" checked>Faecal ColiForm</td>
				<%} else{%>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="bac" value="Faecal ColiForm">Faecal ColiForm</td>
				<%} %>
				<%if(wqlist!=null && wqlist.get(17).equals("Y")){ %>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="oth" value="pH" checked>pH</td>
				<%} else{%>
				<td class="textborder" style="width:175px" ><input type="checkbox" name="oth" value="pH">pH</td>
				<%} %>
				
			</tr>
			<tr><td><p>&nbsp;</p></td></tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Methodology</td>
				<td class="textborder" colspan="2" >
				<html:select property="method">
					<html:option value="Treatment Plant">Treatment Plant</html:option>
					<html:option value="Alternative Safe Source">Alternative Safe Source</html:option>
				</html:select>
				</td>
			</tr>
			<tr><td><p>&nbsp;</p></td></tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Estimate Capital Cost</td>
				<td class="textborder" colspan="2"><html:text property="estCost" readonly="true"/><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">GOI Share</td>
				<td class="textborder" colspan="2"><input type="text" name="goi2"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">State/Other Share</td>
				<td class="textborder" colspan="2"><input type="text" name="state2"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Community Contribution Deposited(Cash+Kind+Labour)</td>
				<td class="textborder" colspan="2"><input type="text" name="comm2"><font color="red" face="verdana" size="2"></font></td>
			</tr>
		</table>
	</div>
	<div id="sustainability" style="position:relative;overflow-y:auto;left:0;height:126;top:0;display:none">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;width:908px" >
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Estimate Capital Cost</td>
				<td class="textborder" colspan="2"><html:text property="estCost" readonly="true"/><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">GOI Share</td>
				<td class="textborder" colspan="2"><input type="text" name="goi3"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">State/Other Share</td>
				<td class="textborder" colspan="2"><input type="text" name="state3"><font color="red" face="verdana" size="2"></font></td>
			</tr>
			<tr>
				<td class="textborder" colspan="2" style="width:300px">Community Contribution Deposited(Cash+Kind+Labour)</td>
				<td class="textborder" colspan="2"><input type="text" name="comm3"><font color="red" face="verdana" size="2"></font></td>
			</tr>
		</table>
	</div>
	</td>
	</tr>
	<tr>
	<td align="center">
		<input type="submit" value="Submit" onSubmit="return validate()">
		<input type="reset" value="Reset">
		<input type="button" value="Close" onClick="javascript:window.close()">
	</td>
	</tr>
</table>
<html:hidden property="goi"/>
<html:hidden property="state"/>
<html:hidden property="comm"/>
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="872"/>
</jsp:include>
</html:form><!-- -->
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
