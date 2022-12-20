<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javascript">
function validate()
{
		
	 if(document.forms[0].bankName.value=='')
	{

		alert("please Enter Bank Name ");
				return false;
	}
	else if(document.forms[0].branchName.value=='')
	{
		alert("please Enter Branch Name ");
				return false;
	}
	 if(document.forms[0].ifscCode.value=='')
	{

		alert("please Enter IFSC Code ");
				return false;
	}
	 if(document.forms[0].contactNumber.value=='')
	{
		alert("please Enter Contact Number ");
				return false;
	}
	else if(document.forms[0].city.value=='')
	{
		alert("please Enter City ");
				return false;
	}
	 if(document.forms[0].district.value=='')
	{
		alert("please Enter District ");
				return false;
	}
	else if(document.forms[0].address.value=='')
	{
		alert("please Enter Address ");
				return false;
	}
	else
	{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/IFSCEntry.do?mode=Update";
	document.forms[0].submit();
	}
}
</script>
<html:form action="IFSCEntry.do">
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
			<tr align="right">
				<!-- <td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td> -->
				<%
			if(userid!=null && userid.substring(userid.length()-2).equals("EE")){		            	   
	          	  %>
	          	  <td class="bwborder"><a href="/pred/home.jsp">&nbsp;Back</a></td>
	          	  <%
	             }else{
	            	 %>
	            	 <td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
	            	 <%
	             }
			%>
			
			</tr>  
		</table>
	</caption>

</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="IFSC Code Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Bank Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="bankName"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Branch Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="branchName"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>IFSC Code:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="ifscCode"  styleClass="thin-text-box" readonly="true"/>
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>MICR Code:</FONT>
	</td>
	<td class=mycborder >
	<html:text property="micrCode"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Contact Number:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="contactNumber"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>CITY:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="city"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>District:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="district"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>Address:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:textarea property="address"  styleClass="thin-text-box" rows="3"/>
	</td>
	</tr>
</table>

<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Save the Fields" styleClass="btext" value="Update" onclick="return validate()"/> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

