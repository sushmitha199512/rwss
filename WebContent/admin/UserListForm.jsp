<%	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String GeneralUser = (String) session.getAttribute("GeneralAdmin");
	String GeneralSuccess = (String) session.getAttribute("su");	
	if(users != null ){
		if(GeneralUser != null && GeneralSuccess!=null){	
			String userid = users.getUserId();	
             if(userid!=null && (!userid.equals("admin") && !userid.equals("100000") && !userid.equals("EE-Budget"))){		            	   
          	   response.sendRedirect("../commons/rws_not_authorization.jsp");
             }
%> 
	<%@ include file="/commons/rws_header1.jsp" %>
	<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%		}else{ %>
<body topmargin="0" leftmargin="0">

<table bgcolor="#F8FCEE" width="100%" height="100%" cellspacing="0" cellpadding="0" border="0" >
<!-- Page content starts here -->
<tr height="93%">
	<td align="center">	
<%			}
	}else{
		 response.sendRedirect("../masters/sessionExpired.jsp");
	}	 
%>
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



function validateEmail() {
    var emailText = document.forms[0].elements["mailId"].value;
    var pattern = /^[a-zA-Z0-9\-_]+(\.[a-zA-Z0-9\-_]+)*@[a-z0-9]+(\-[a-z0-9]+)*(\.[a-z0-9]+(\-[a-z0-9]+)*)*\.[a-z]{2,4}$/;
    if (pattern.test(emailText)) {
    	    return true;
    } else {
        alert('Please Enter Proper Email ID: ' + emailText);
        return false;
    }
}
function saveUsers(){
	var email= document.forms[0].elements["mailId"].value;
	var mobile= document.forms[0].elements["mobileNo"].value;
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
			if(validateEmail()){
					document.forms[0].elements["userId"].disabled=false;				
					document.forms[0].action="switch.do?prefix=/admin&page=/users.do&mode=save";	
					document.forms[0].submit();
					return true;
			}
			return false;
				   		   
	   }
}
</script>

<body >

<html:form action="users.do&mode=data" method="post">
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
						<td class="bwborder"><a href="javascript:history.go(-1)">Back&nbsp;</a></td>		
				</tr>  
			</table>
		</caption>
	</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="User Details" />
	<jsp:param name="TWidth" value="320" />
	
</jsp:include>

<table  width="360" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
  <tr>
	    <td class="textborder" align="right">Users<font color="#FF6666">*</font></td>
		<td class="textborder" >
		
		    <logic:equal name="usersList" property="superUser" value="yes">
			<html:select property="userId" styleClass="mycombo" style="width:150px" onchange="javascript:getUsers();"  >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
	         <logic:present name="users">
			<html:options collection="users" name="rwsLocationBean" property="userId" labelProperty="userId" />
	        </logic:present >
			</html:select>
			
			</logic:equal>
			
			<logic:equal name="usersList" property="superUser" value="no">
			<html:select property="userId" styleClass="mycombo" disabled="true" style="width:150px" onchange="javascript:getUsers();"  >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
	        <logic:present name="users">
				<html:options collection="users" name="rwsLocationBean" property="userId" labelProperty="userId" />
	        </logic:present >
			</html:select>
			
			</logic:equal>
		</td>
		</tr>
		<tr >
	<td class="textborder" align="right">Circle</td><td class="btext"><bean:write property="circle" name="usersList"/></td>
	</tr>
	<tr >
	<td class="textborder" align="right">Division</td><td class="btext"><bean:write property="division" name="usersList"/></td>
	</tr>
	<tr >
	<td class="textborder" align="right">Sub Division</td><td class="btext"><bean:write property="subdivision" name="usersList"/></td>
	</tr>
	<tr >
	<td class="textborder" align="right">Mobile NO</td><td><html:text  property="mobileNo" maxlength="10" /></td>
	</tr>
	<tr>
	<td class="textborder" align="right">E-Mail ID <font color="#FF6666">*</font></td><td><html:text  property="mailId" /></td>
	</tr>

	
	
		
	
	
		<tr><td colspan="14" align="center"><input type=button value=Save onClick="saveUsers();" class="btext">&nbsp;&nbsp;&nbsp;&nbsp;
		<logic:equal name="usersList" property="superUser" value="yes">
			<input type=button value=View onClick="viewUsers();" class="btext">
		</logic:equal>
		</td>
		</tr>
		
	</table>
	
	

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="320" />
</jsp:include>

</html:form>
 
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

