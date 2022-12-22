<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
    user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
    String loggedUser = user.getUserId();
  	PreparedStatement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String district= null;
    String mandal = null;	
	district = request.getParameter("district");
	mandal = request.getParameter("mandal");	
%>
<html>
<head>
	<script language="JavaScript">
		function fnSubmit(){
		   var tablesName=document.forms[0].tablesName.value;	  
		   if(tablesName=="-1"){
		    alert("Please Select Related Tables");
			return false;
		   } 
		
		  else{
			    document.getElementById("spinner").style.display="";
				document.forms[0].action="/pred/reports/mdbDownload.do";
				document.forms[0].submit(); 
		    }  
		}		
	</script>
</head>
<body bgcolor="#edf2f8" onload="check()">
	<form  action="/mdbDownload.do" method="post">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
		<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
			<caption>
				<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">
					<tr align="right">
						<td ><a href="../../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a><a href="javascript:onclick=history.go(-1)">Back  </td>
					</tr>				
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="rptHeading" colspan=3>MDB File Download</td>	
			</tr>
			<tr>
				<td colspan=2>	
					<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
 						<tr>
							<td class=rptLabel>Select Related Tables&nbsp;&nbsp;<font color="red">*</font></td>
							<td class=btext>
								<SELECT name="tablesName"  class="mycombo" style="width:150px" >
									<option value="-1" >SELECT..</option>		
									<option value="Bank Related Tables">Bank Related Tables</option>
									<option value="Works Related Tables">Works Related Tables</option>
									<option value="Habitation Related Tables">Habitation Related Tables</option>
									<option value="Sources Related Tables">Sources Related Tables</option>
									<option value="Asset Related Tables">Asset Related Tables</option>
									<option value="Drought Related Tables">Drought Related Tables</option>
									<option value="School Related Tables">School Related Tables</option>
									<option value="YDU Related Tables">YDU Related Tables</option>
									<option value="Total Habitations Related Table">Total Habitations Related Table</option>
								</SELECT>
							</td>
						</tr>		
					</table>
				</td>
			</tr>
			<tr>
				<td colspan=3 align=center>
					<input type=button  onclick="fnSubmit()" class=btext value="GetData">
				</td>
			</tr>
		</table><br><br><br><br>
		<div  id="spinner" style="display:none;"><table><tr><td><b><font color="#0066ff">Please Wait, Preparing for Download</font></b></td><td width="20"><marquee direction="right"><b><font color="#0066ff">.....</font></b></marquee></td></tr></table></div>
		<%@ include file = "/reports/footer.jsp" %>
	</form>
</body>
</html>
