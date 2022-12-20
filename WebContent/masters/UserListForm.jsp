<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<script type="text/javascript" src="/resources/javascript/emailValidation.js"></script>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<title>Users List Form</title>
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
</head>

<script type="text/javascript" language="JavaScript">
function getUsers(){
document.forms[0].action="switch.do?prefix=/admin&page=/users.do&mode=get";	
document.forms[0].submit();
}
</script>
<script type="text/javascript" language="JavaScript">
function viewUsers(){
	//alert("Please Update the User Info than only Forget Password User details will be send either Mobile/E-Mail");
document.forms[0].action="switch.do?prefix=/admin&page=/users.do&mode=view";	
document.forms[0].submit();
}
</script>


<script type="text/javascript" language="JavaScript">
function saveUsers(){
	
	var mobile= document.getElementById("usersBean["+0+"].mobileNo").value;
	var email= document.getElementById("usersBean["+0+"].mailId").value;
	
	if((mobile == null || mobile == '') && (email == null || email == '')){
		   alert('Atleast Mobile No. (or) E-Mail is Required');
		   return false;
		}else{
			var mb= mobile.length;
			if((mobile != null && mobile != '') && mb <10){
				alert('Mobile No. Should be 10 digit');
				var mobileNo = mb;
				mobileNo = mobileNo.trim();
				if(mobileNo != null && mobileNo != '') {
					mobile = mobileNo.trim(); 					
			   }				   
			}
			/*if(email != null &&email != ''){					
			   
			   var atpos=email.indexOf("@");
			   var dotpos=email.lastIndexOf(".");
			   var emailid =email;
			   emailid = emailid.trim();
			   if(emailid != null && emailid != '') {				   
				   if (atpos<1 || dotpos<atpos+2)
				     {
				     alert("Invalid e-mail address.");
				     return false;
				     }
			   }			
			}*/
			document.forms[0].action="switch.do?prefix=/admin&page=/users.do&mode=save";	
			document.forms[0].submit();
			return true;	   		   
	   }
}
</script>

<body bgcolor="#edf2f8">

<html:form action="users.do&mode=data" method="post">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Users List Form" />
	<jsp:param name="TWidth" value="670" />
	
</jsp:include>

<table width="50%" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
  <tr>
	    <td class="textborder" width="80">Users<font color="#FF6666">*</font></td>
		<td class="textborder" width="50">
			<html:select property="userId" styleClass="mycombo" style="width:150px" onchange="javascript:getUsers();" >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
	         <logic:present name="users">
			<html:options collection="users" name="rwsLocationBean" property="userId" labelProperty="userId" />
	        </logic:present >
			</html:select>
		</td>
		</tr>
 </table>
 
 <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse">

	<tr >
	<td class="btext" align="center">Mobile NO</td>
	<td class="btext" align="center">E-Mail ID</td>
	</tr>

	<logic:notEmpty name="usersList" property="usersList">
	
	<logic:iterate id="usersBean" name="usersList" property="usersList" indexId="index">	
	<tr>		
		<td align="center">			
				<html:text name="usersBean" property="mobileNo" indexed="true" maxlength="10" onkeyup="" />							
		</td>
				
		<td>
				<html:text name="usersBean" property="mailId" indexed="true" />	
		</td></tr>
	</logic:iterate>
	</logic:notEmpty>
	
		<tr><td colspan="14" align="center"><input type=button value=Save onClick="saveUsers();" class="btext">
		&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value=View onClick="viewUsers();" class="btext">
		</td>
		</tr>
		
	</table>
	
	

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="670" />
</jsp:include>

</html:form>
 
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

