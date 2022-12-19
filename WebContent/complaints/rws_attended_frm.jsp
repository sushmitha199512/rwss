<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<script language="JavaScript">
function getCompNotAttended()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=compnotattended";
document.forms[0].submit();
}
</script>
<script language="JavaScript">
function getComplaintNot(that)
	{
	var index=that.value;
	var sourcecode=document.getElementById("COMPNLIST["+index+"].sourceCode").value;
	var assetcode=document.getElementById("COMPNLIST["+index+"].assetCode").value;
	var complaintdate=document.getElementById("COMPNLIST["+index+"].complntdt").value;
	var complaintdes=document.getElementById("COMPNLIST["+index+"].complntdesc").value;
	var complaintno=document.getElementById("COMPNLIST["+index+"].complntno").value;
	var categoryname=document.getElementById("COMPNLIST["+index+"].categoryName").value;
	url = "switch.do?prefix=/complaints&page=/Attend.do&mode=attend&categoryName="+categoryname+"&sourceCode="+sourcecode+"&assetCode="+assetcode+"&complntdt="+complaintdate+"&complntdesc="+complaintdes+"&complntno="+complaintno;
	window.open(url,"","width=850,height=500,left=100,top=150,scrollbars=1,resizable=1");
	}
</script>
<script language="JavaScript">
function   viewAttended()
  {
  document.forms[0].action="switch.do?prefix=/complaints&page=/Attend.do&mode=view";
  document.forms[0].submit();
   }
function getData1()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Attend.do&mode=view";
document.forms[0].submit();
}
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Attend.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Grievance Attend Entry " />
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
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" align="center">
<tr>
<td>
   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
		</html:select>
		</td>
	
	<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
			</html:select>
	</td>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
	</td>
	<td class="textborder" width="100">
	<bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
		</html:select>
	</td>
		</tr>
		<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getCompNotAttended()">
		<html:option value="">SELECT...</html:option>
  	<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
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
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Grievance To be Attended</font>	
	</td>
	</tr>
<tr>
<td>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="100%" align=center >
	<tr>
	<td class=clrborder align=center>Select</td>
	<td class=clrborder align=center>Source Name</td>
	<td class=clrborder align=center>Source Code</td>
	<td class=clrborder align=center>Complaint No.</td>
	<td class=clrborder align=center>Complaint Date</td>
	<td class=clrborder align=center>Complaint Description</td>
	<td class=clrborder align=center>Category Type</td>
	<td class=clrborder align=center>Asset Code</td>
	</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("complaintsnotattended"); 
//System.out.println("A Size::"+a.size());
if(a.size() > 0)
{
%>
<%//System.out.println("Complaints"); %>
<% int resultCount = 0;%>
<%//System.out.println("Resultcount"+resultCount); %>
<%//System.out.println("Complaints1"); %>

<nested:iterate id="COMPNLIST" property="complaintsnotattended" indexId="ndx" >

<%//System.out.println("Complaints2"); %>
<% resultCount++; %>
		<tr>
	<td  class=bwborder align=center>
	<input type=radio name="assetCd1" title="Select any Complaint to Attend"  value="<%=String.valueOf(ndx)%>"   onclick="getComplaintNot(this);" />
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="COMPNLIST" property="assetName" /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write name="COMPNLIST" property="sourceCode"  />
	<nested:hidden name="COMPNLIST" property="sourceCode"indexed="true"/>
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
	<td  class=bwborder align=left>
	<nested:write  name="COMPNLIST" property="categoryName" /> 
	<nested:hidden name="COMPNLIST" property="categoryName"indexed="true"/>
	</td>
	<td class=bwborder align=center>
	<nested:write name="COMPNLIST" property="assetCode"  />
	<nested:hidden name="COMPNLIST" property="assetCode"indexed="true"/>
	</td>
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
	    //System.out.println("Exception"+e);
	  }
	%>
	</table>
	</td>
	</tr>
	<tr>
	<td  bgcolor="#8A9FCD">
	<font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Grievance Attended</font>	
	</td>
	</tr>
	<tr>
	<td>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
	<tr>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source Code</FONT></td>
	<td  class=mycborder align=center>

	<FONT class=myfontclr><font color="#993366">Complaint No.</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint Category</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint Description</FONT></td>
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
	//System.out.println("B size"+b.size());
	if(b.size() > 0)
	{
	int count=0; %>
	<%//System.out.println("Complaints"); %>
	<logic:iterate id="COMPLAINTSALIST" name="complaintsalist">
	<%//System.out.println("Complaints2"); %>
	<% count=count+1;%>

	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
	<td  class="bwborder" ><%=count %></td>
	<td  class=mycborder1 align=left>
	<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="assetName" /></FONT>
	</td>
	<td  class=mycborder1 align=center>
	<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="sourceCode" /></FONT>
	</td>
	<td  class=mycborder1 align=center>
	<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntno" /></FONT>
	</td>
	<td  class=mycborder1 align=center>
	<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntdt" /></FONT>
	</td>
	<td  class=mycborder1 align=left>
	<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="categoryName" /></FONT>
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
//System.out.println("Exception"+e);
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

