<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<script language="JavaScript">
function getHead(that)
{
	var field = that.name;
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do"
			+ "&mode=circles";
			frm.action = url;
	frm.submit();
}
function getHabDirData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=get2";
	document.forms[0].submit();
}
function getPanchayat2()
{

document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=panchayats";
document.forms[0].submit();
}
function getHabs()
{

document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=habitations";
document.forms[0].submit();
}
function getCompNotAttended()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=compnotattended";
document.forms[0].submit();
}
</script>
<script language="JavaScript">
function getComplaintNot(that)
	{
		var index=that.value;
		var componentname=document.getElementById("COMPNLIST["+index+"].componentName").value;
		var complaintdate=document.getElementById("COMPNLIST["+index+"].complntdt").value;
		var complaintdes=document.getElementById("COMPNLIST["+index+"].complntdesc").value;
		var complaintno=document.getElementById("COMPNLIST["+index+"].complntno").value;
		var repname=document.getElementById("COMPNLIST["+index+"].repName").value;
		var rname=document.getElementById("COMPNLIST["+index+"].name").value;  
		var raddress=document.getElementById("COMPNLIST["+index+"].address").value;  
	url = "switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=attend&name="+rname+"&address="+raddress+"&repName="+repname+"&componentName="+componentname+"&complntdt="+complaintdate+"&complntdesc="+complaintdes+"&complntno="+complaintno;
		window.open(url,"","width=850,height=500,left=100,top=150,scrollbars=1,resizable=1");
		}
</script>
<script language="JavaScript">
function   viewAttended()
  {
  document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattendedgeneric.do&mode=view";
  document.forms[0].submit();
 }
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Complaintattendedgeneric.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Generic Grievance Attend Entry " />
	 	
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="100%" >
<tr>
<td>
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table  border=0  width="100%">
				<tr>
			<td class="textborder"><bean:message key="app.headoffice" />
			<span class="mandatory">*</span>
		</td>
		<td class="textborder" >
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" style="width:140px"   onchange="javascript: getHead(this)"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" style="width:140px"  styleClass="mytext" 
						   name="RWS_USER" readonly="true"/>
			</logic:notEqual>
		</td>
		<td class="textborder">Circle
		<span class="mandatory">*</span>
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode"  style="width:140px" onchange="javascript: getHabDirData1(this)" 
							 styleClass="mycombo"> 
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:present>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
	<tr>
	<td>
	<fieldset>
	<legend>Habitation Details</legend>
	<label>
	<table border=0 width="850" align="center" border=0>
	<tr>
	<td class="textborder" width="80"><bean:message key="app.district" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:text property="dist" style="width:150px" value="<%=(String)request.getAttribute("district1")%>" styleClass="mytext" readonly="true" />
	<html:hidden property="districtCode" value="<%=(String)request.getAttribute("circleOfficeCode")%>" />
	<html:hidden property="init" />
	</td>
		<td class="textborder" width="100">Mandal<font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
	<html:select property="mandal" styleClass="mycombo" style="width:150px" onchange="javascript:getHabDirData1()">
	<html:option value="">SELECT...</html:option>
	<logic:present name="mandals">
	<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
</td>
		<td class="textborder" width="100"><bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="pcode" styleClass="mycombo" style="width:150px"  onchange="javascript:getHabDirData1()">
		
			<html:option value="">SELECT...</html:option>
			<logic:present name="panchayats">
			<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
		</html:select>
	</td>
	</tr>
	<tr>
	
	<td class="textborder" nowrap width="100"><bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getCompNotAttended()">
			<html:option value="">SELECT...</html:option>
			<logic:present name="habs">
						<html:options collection="habs" name="labelValueBean" property="value" labelProperty="label" />
						</logic:present>
		</html:select>
	</td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Generic Grievance To be Attended</font>	
	</td>
	</tr>
<tr>
<td>
  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="100%" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Component Name</td>
			   <!-- <td class=clrborder align=center>Source Code</td>-->
                <td class=clrborder align=center>Complaint Given By</td> 
                <td class=clrborder align=center>Name</td> 
                <td class=clrborder align=center>Address</td> 
			    <td class=clrborder align=center>Complaint No.</td>
				<td class=clrborder align=center>Complaint Date</td>
				
				<td class=clrborder align=center>Problem  Description</td>
				<!--<td class=clrborder align=center>Asset Code</td>-->
								</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("complaintsnotattended"); 
//System.out.println("A Size::"+a.size());

if(a != null && a.size() > 0)
{
%>
<%System.out.println("Complaints"); %>
<% int resultCount = 0;%>
<%System.out.println("Resultcount"+resultCount); %>
<%System.out.println("Complaints1"); %>

<nested:iterate id="COMPNLIST" property="complaintsnotattended" indexId="ndx" >

<%System.out.println("Complaints2"); %>
<% resultCount++; %>
	
	<tr>	<td  class=bwborder align=center>
	    <input type=radio name="assetCd1" title="Select any Complaint to Attend"  value="<%=String.valueOf(ndx)%>"   onclick="getComplaintNot(this);" />
	</td>
       	
		<td  class=bwborder align=left>
        <nested:write  name="COMPNLIST" property="componentName" /> 
        <nested:hidden name="COMPNLIST" property="componentName"indexed="true"/>
        </td>

       	
		<td  class=bwborder align=left>
		<nested:write name="COMPNLIST" property="repName"  />
		<nested:hidden name="COMPNLIST" property="repName"indexed="true"/>
		</td>
        <td  class=bwborder align=left>
		<nested:write name="COMPNLIST" property="name"  />
		<nested:hidden name="COMPNLIST" property="name"indexed="true"/>
		</td>
				<td  class=bwborder align=left>
		<nested:write name="COMPNLIST" property="address"  />
		<nested:hidden name="COMPNLIST" property="address"indexed="true"/>
		</td>
		        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="complntno" /> 
        <nested:hidden name="COMPNLIST" property="complntno"indexed="true"/>
        </td>
        		<td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="complntdt" /> 
        <nested:hidden name="COMPNLIST" property="complntdt"indexed="true"/>
        </td>
		
        <td  class=bwborder align=left>
        <nested:write  name="COMPNLIST" property="complntdesc" /> 
        <nested:hidden name="COMPNLIST" property="complntdesc"indexed="true"/>
        </td>
        <!--<nested:write name="COMPNLIST" property="assetCode"  />-->
		<nested:hidden name="COMPNLIST" property="assetCode"indexed="true"/>
			</tr>
</nested:iterate>
<%
}
else 
{
%>
<tr>
<td colspan=7 align=center>No Records</td>
</tr>
<%
}
}catch(Exception e)
{
System.out.println("Exception"+e);
}
%>
  </table>
</td>
</tr>
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Generic Grievance Attended</font>	

	</td>
	</tr>
<tr>
<td>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Component Name</FONT></td>
		
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Given By</FONT></td>
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Name</FONT></td>
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Address</FONT></td>
				
		<td  class=mycborder align=center>
				<FONT class=myfontclr><font color="#993366">Complaint No.</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Date</FONT></td>
		
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Problem Description</FONT></td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Attended By</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Attended Date</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Status</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Remarks</FONT>	</td>
		
</tr>

<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("complaintsalist"); 
////System.out.println("B size"+b.size());
if(b != null && b.size() > 0)
{

 int count=0; %>
<%System.out.println("Complaints"); %>
<logic:iterate id="COMPLAINTSALIST" name="complaintsalist">
<%//System.out.println("Complaints2"); %>
<% count=count+1;%>

<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>





<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="componentName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="repName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="name" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="address" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntno" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntdt" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntdesc" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="attenby" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="attendt" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="status" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="remarksby" /></FONT>
</td>
</tr>
</logic:iterate>
<%}
else
{
%>
<tr>
<td colspan=11 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}
%>
</table>
</td>
</tr>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

