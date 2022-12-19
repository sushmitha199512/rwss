
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@page import="nic.watersoft.commons.Debug"%>

<html>
<head>
<script language="JavaScript">
 

 function submitPage()
 {
   
   document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&mode=data";
   document.forms[0].submit();
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
	 //document.forms[0].wrktype[1].disabled=true;
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

     //var plan = document.getElementById('plan').value;
 	 //var wrkType = document.getElementById('wrktype').value;
 	 //var workcategory = document.getElementById('workCategory').value;
 	 //var program = document.getElementById('programme').value;
 	
 	function fnSave()
 	{ 
 	    
 	   if(document.forms[0].plan[0].checked==false && document.forms[0].plan[1].checked==false )
 	   {
 	   	  alert("plan or non plan is required");
 	      return;
 	    }	 
 	    else if(document.forms[0].workCategory.value=="")
             {
             alert("Work Category is required");
             return;
             }
             else if(document.forms[0].program.value=="")
             {
              alert("Programme is required");
              return;
              }
             
 	     else 
 	     {
 	        document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&mode=save"; 
 	    	document.forms[0].submit();
 	   		document.forms[0].save.disabled=true;
 	   }
 	}
 	
 	 
 	  	 
 	 function fnView()
 	{
 	  document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&mode=view"; 
 	  document.forms[0].submit();
 	 	  } 
 	  
 	  function fnWchange()
 	  {
 	    document.forms[0].action="switch.do?prefix=/masters&page=/workCategory.do&mode=prog"
 	    document.forms[0].submit();
 	  
 	   }
 	  
 	 	
 </script>
</head>

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
<body />

<html:form action="workCategory.do">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right" colspan="30">
				<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>			
			</tr>  
		</table>
	</caption>
</table>
	<table align="center" cellpadding="0" cellspacing="0" border=0>
		<thead>
			<tr>
				<td><jsp:include page="/commons/TableHeaderWithoutClose.jsp">
					<jsp:param name="TableName" value="Program Linkage Form" />
					<jsp:param name="TWidth" value="100%" />
				</jsp:include></td>
			</tr>
		</thead>

		<tfoot>
			<tr>
				<td><jsp:include page="/commons/TableFotter.jsp">
					<jsp:param name="TWidth" value="100%" />
				</jsp:include></td>
			</tr>
		</tfoot>

		<tbody>
			<tr>
			
				<td>
				<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="none" border=1 style="border-collapse:collapse;">
					<tr>
						<td class="textborder" colspan="2" align="center"><html:radio
							property="plan" value="1" onclick="checkMe()">Plan</html:radio>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<html:radio property="plan" value="2" onclick="checkMe();">Non Plan</html:radio>
						</td>
					</tr>
					
					<tr>
						<td class="textborder" colspan="3"><html:radio property="wrktype"
							value="1">MainScheme</html:radio> <html:radio property="wrktype"
							value="2">Augmentation</html:radio> <html:radio
							property="wrktype" value="3">Maintenance</html:radio></td>
					</tr>
					
					<tr>
						<td class="textborder">Work Category<span class="mandatory">*</span></td>
						<td><html:select property="workCategory" style="width:143px"
							styleClass="mycombo" onchange="fnWchange()">
							<html:option value="">Select...</html:option>
							<logic:present name="workCategory">
								<html:options collection="workCategory" property="value"
									labelProperty="label" />
							</logic:present>
						</html:select></td>
					</tr>
					<tr>
						<td class="textborder">Programme<span class="mandatory">*</span></td>
						<td><html:select property="program" style="width:143px"
							styleClass="mycombo">
							<html:option value="">Select...</html:option>
							<logic:present name="Programme">
								<html:options collection="Programme" property="value"
									labelProperty="label" />
							</logic:present>
						</html:select></td>
					</tr>
					<tr align="center">
						<td class="textborder" align=center colspan="2">&nbsp;</td>
					</tr>
					<tr align="center">
						<td class="textborder" align=center colspan="2">
						<html:button
							property="save" title="Save the Fields" styleClass="btext"
							value="Save" onclick=" return fnSave()" /> <html:button
							property="mode" title="View program linkage" styleClass="btext"
							value="View" onclick="return fnView()" /></td>
					</tr>
				</table>
				</td>
			</tr>
		</tbody>


	</table>

</html:form>
<%@ include file="/commons/rws_alert.jsp"%>