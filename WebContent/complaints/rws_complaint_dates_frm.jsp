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
	 	url = "switch.do?prefix=/complaints&page=/Complaintattended.do"
			+ "&mode=circles";
		
	frm.action = url;
	frm.submit();
}
function getHabDirData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=get2";
	document.forms[0].submit();
}
function getPanchayat2()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=panchayats";
document.forms[0].submit();
}
function getHabs()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=habitations";
document.forms[0].submit();
}
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
	var complaintdate=document.getElementById("COMPNLIST["+index+"].complntdt").value;
	var complaintno=document.getElementById("COMPNLIST["+index+"].complntno").value;
	//alert(complaintno);
	url = "switch.do?prefix=/complaints&page=/ComplaintNo.do&mode=get4&complntno="+complaintno;
	window.open(url,"","width=850,height=500,left=100,top=150,scrollbars=1,resizable=1");
	}
</script>
<script language="JavaScript">
function fnSea()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/ComplaintNo.do&mode=get3";
document.forms[0].submit();

}
function   viewAttended()
  {
  document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do&mode=view";
  document.forms[0].submit();
  }
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="Complaintattended.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Complaints Attended Entry Form" />
	 	
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
	<td class="textborder">
	Complaint Dates<span class="mandatory">*</span>
	</td>
	<td class="column2">
	<logic:present name="dates">
	<html:select property="complntdt" styleClass="mycombo" style="width:125px">
	<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
	<html:options collection="dates" name="compForm"
	property="complntdt" labelProperty="complntdt" />
	</html:select>
	</logic:present>
	</td>
	<td>
	<html:submit property="view" title="Click"  styleClass="btext" value="Click" onclick="fnSea();"/></td>
	</tr>
</td></tr>
		</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;List Of Complaints</font>	
	</td>
	</tr>
<tr>
<td>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="100%" align=center >
	<tr>
	<td class=clrborder align=center>Select</td>
	<td class=clrborder align=center>Complaint No.</td>
	<td class=clrborder align=center>Complaint Date</td>
	</tr>
<%
try{ 
java.util.Collection a = (java.util.Collection)request.getAttribute("cno"); 
//System.out.println("A Size::"+a.size());
if(a.size() > 0)
{
%>
<%//System.out.println("Complaints"); %>
<% int resultCount = 0;%>
<%//System.out.println("Resultcount"+resultCount); %>
<%//System.out.println("Complaints1"); %>
<nested:iterate id="COMPNLIST" property="cno" indexId="ndx" >
<%//System.out.println("Complaints2"); %>
<% resultCount++; %>
	<tr>
	<td  class=bwborder align=center>
	<input type=radio name="assetCd1" title="Select any Complaint to Attend"  value="<%=String.valueOf(ndx)%>"   onclick="getComplaintNot(this);" />
	</td>
	<td  class=bwborder align=center>
	<nested:write  name="COMPNLIST" property="complntno" /> 
	<nested:hidden name="COMPNLIST" property="complntno"indexed="true"/>
	</td>
	<td  class=bwborder align=center>
	<nested:write  name="COMPNLIST" property="complntdt" /> 
	<nested:hidden name="COMPNLIST" property="complntdt"indexed="true"/>
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




