
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%> 
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	//////// // System.out.println("***********************FROM BEGINING***********************");
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
   user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user.getUserId();
   //System.out.println("loggeduser:"+loggedUser);
   Statement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String district= null;
    String mandal = null;;
	
	
	district = request.getParameter("district");
	mandal = request.getParameter("mandal");	

	
	
%>
<html>
<head>

<script language="JavaScript">

	function fnSubmit()
	{
	 
	 
	   var tablesName=document.forms[0].tablesName.value;
	
	  
	  
	   if(tablesName=="-1")
	   {
	    alert("Please Select Related Tables");
		return false;
	   }
	   
	
	  else
	  {
		 document.forms[0].action="/pred/reports/mdbDownload.do";
			document.forms[0].submit(); 
	    }
	 
	  
	  
	}

	
		
</script>

</head>
<body bgcolor="#edf2f8" onload="check()">
<form  action="/mdbDownload.do" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			

			<tr align="right">
			<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; <a href="javascript:onclick=history.go(-1)">Back  </td>
			</tr>


				
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>MDB File Download</td>	
	</tr>

	
	

	<tr>
	<td colspan=2>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
 
	
		<tr><td class=rptLabel>Select Related Tables&nbsp;&nbsp;<font color="red">*</font></td>
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
					</SELECT>
					</td></tr>
					
	
	
			
		
</table>

</td></tr>
<tr>
<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit()" class=btext value="GetData">
		</td>
		</tr>
	</table>
	
	

<%@ include file = "/reports/footer.jsp" %>
</form>
</body>
</html>
