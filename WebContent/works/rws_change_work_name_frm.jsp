<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%-- <%@ include file="/commons/rws_generaladmin_header.jsp"%> --%>
<html:html>
<script language="JavaScript">
	function fnSea(){       
	        if(document.forms[0].workId.value=="" || document.forms[0].workId.value==null) {
		        alert("Enter WorkId");
		        return false;
	        }
	        else{
		        document.forms[0].action="switch.do?prefix=/works&page=/WorkNameChange.do?mode=data"
				document.forms[0].submit;
	        }
	  }
	
	function fnSea1(){     
	       if(document.forms[0].changeWorkName.value=="" || document.forms[0].changeWorkName.value==null){
		       alert("Please Enter Work Name");
		       document.forms[0].changeWorkName.focus();
		       return false;
	       }      
	       else{             
		       document.forms[0].action="switch.do?prefix=/works&page=/WorkNameChange.do?mode=update";
			   document.forms[0].submit;
	       }        
	}
</script>
<body>
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<!-- <tr align="right">
				<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>			
			</tr>  --> 
			<%if(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)) {%>
			  				<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>			
			  
			  <%}else{ %>
			  
			  			  				<td class="bwborder"><a href="<rws:context page='/home.jsp'/>">Back</a>&nbsp;|&nbsp;<a href="<rws:context page='/home.jsp'/>">Home</a></td>			
			  
			  <%} %>
		</table>
	</caption>
</table>
<html:form action="WorkNameChange.do">
<% 
	String csrfToken="";
	nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
	csrfToken = valUtil.getCSRFCode();
	session.setAttribute("csrfToken",csrfToken);
%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Work Name Change Form " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" align="center">
	<tr>
		<td align=center>Enter Work Id:<font color="#FF6666">*</font>:<html:text property="workId" styleClass="mytext" style="width:95px"   maxlength="14" size="14"  onkeypress="numeralsOnly(event)"  />
	 		<html:submit property="mode" title="Submit"  styleClass="btext"  onclick="return fnSea();"/> 
		</td>
	</tr>
	<tr>
 		<td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1" style="border-collapse:collapse;" width="50%" align=center>
				<tr  align=center>
					<td class=clrborder colspan=7  >Works details</td>
				</tr>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					<td class=clrborder align=center nowrap>Office</td>
				    <td class=clrborder align=center nowrap>Work Id</td>
                    <td class=clrborder align=center nowrap width="300">Work Name</td>
                    <td class=clrborder align=center nowrap>Admin No</td>
                    <td class=clrborder align=center nowrap>Admin Date</td>
                    <td class=clrborder align=center nowrap>Sanction Amount( In Rs. Lakhs )</td>    
				</tr>
				<%
					try{
						int count=0;
						java.util.Collection a = (java.util.Collection)session.getAttribute("works"); 
						if( a != null && a.size() > 0) {
				%>
				<nested:iterate id="COMPLIST" name="works" indexId="ndx">	
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
        	<td class=bwborder align=left nowrap><%=count%></td>		
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST"	property="officeEntered" indexed="true" />
				 <nested:write name="COMPLIST" property="officeEntered" />
			</td>		
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST" property="workId" indexed="true" /> 
				<nested:write name="COMPLIST" property="workId" />				
			</td>
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST" property="workName" indexed="true" /> 
				<nested:write name="COMPLIST" property="workName" />
			</td>
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST" property="adminNo" indexed="true" /> 
				<nested:write name="COMPLIST" property="adminNo" />
			</td>
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST" property="adminDate" indexed="true" /> 
				<nested:write name="COMPLIST" property="adminDate" />
			</td>
			<td class=bwborder align=left nowrap>
				<nested:hidden name="COMPLIST" property="sanctionAmount" indexed="true" /> 
				<nested:write name="COMPLIST" property="sanctionAmount" />
			</td>						
		</tr>
	</nested:iterate>
	<%	} else 	{ %>
	<tr>
	<td colspan=10 align=center>No Records</td>
	</tr>
	<% 		}
		}catch(Exception p) {
			p.printStackTrace();
		}
	%>
	</table>
	</td>
	</tr>
<tr>
<td>
<table align=center>

<tr>
	    <td class="textborder" >Work Name<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<nested:text  property="changeWorkName" styleClass="mytext" size="100"/>
		</td>
</tr>


</table>
</td>
</tr>
<tr align=center>
<td>
<html:submit property="mode" title="UpDate" value="Update" styleClass="btext"  onclick=" return fnSea1();"/>
</td>
</tr>
	

	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</table>

</html:form>
</html:html>

<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>

<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>





