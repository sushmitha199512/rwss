<%@ include file="/commons/rws_header1.jsp"%>
<% 

String uId=request.getParameter("userId");
String special=request.getParameter("special");%>

<script language="JavaScript" src="/pred/resources/javascript/md5.js"></script>
<script>


function validatePassword(){

	var pass=document.getElementById('newPassword').value;
	var confirmpass=document.getElementById('confirmPassword').value;

	if(pass.length<8){

		alert("Password should be minimum 8 digit With Combination of Characters and Numbers,Special Symbols");
		return false;
	}
	if(pass!=confirmpass){
  alert("New Password and Confirm Passwod should be Same");
  return false;
	}
	
var lower= false;
	var upper= false;
	var numeric= false;
	var x=0;
	var specialCharsAll =false;
	for(x=0;x<pass.length;x++)
	{
		var c=pass.charAt(x);
		if ((c >= 'a') && (c <= 'z')) lower=true;
		if ((c >= 'A') && (c <= 'Z')) upper=true;
		if ((c >= '0') && (c <= '9')) numeric=true;
		if((c=='@' || c=='#' ||c=='$' || c=='%' || c=='(' ||c==')' || c=='*')) specialCharsAll = true;		
				
	}

	if(lower == false || upper == false || numeric == false || specialCharsAll == false)
	{
		alert("Password should be the combination of Special Characters,Numbers, lowercase and uppercase...");
		return false;
	}
	return true;
	}
function fnSave()
	{
		document.forms[0].userId.value='<%=uId%>';
		if(document.forms[0].userId.value=="")
		{
			alert("User Id  Is Required");
			return false;
		}
		else if(document.forms[0].oldPassword.value=="")
		{
			alert("Old Password  Is Required");
			document.forms[0].oldPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].newPassword.value=="")
		{
			alert("New  Password  Is Required");
			document.forms[0].newPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].confirmPassword.value=="")
		{
			alert("Confirm Password  Is Required");
			document.forms[0].confirmPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].newPassword.value!=document.forms[0].confirmPassword.value)
		{
			alert("New Password and Confirm Password does not match");
			document.forms[0].newPassword.value="";
			document.forms[0].confirmPassword.value="";
			document.forms[0].newPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		 else{

			 if(validatePassword()){
			var user='<%=uId%>';
			document.forms[0].oldPassword.value=hex_md5(document.forms[0].oldPassword.value);
			document.forms[0].newPassword.value=hex_md5(document.forms[0].newPassword.value);
			document.forms[0].confirmPassword.value=hex_md5(document.forms[0].confirmPassword.value);
			
			
			document.forms[0].action="rws_gen_admn_changepass_process.jsp?user="+user+"&special=N";
			document.forms[0].submit();
			 }
		   }
	} 

function fnReset()
{
  document.forms[0].oldPassword.value="";
  document.forms[0].newPassword.value="";
  document.forms[0].confirmPassword.value="";
}
</script>

<html>
<form method="post"><BR><BR>
<div align="right" style="width: 90%; height: 522">
<font color="red"><b>Note:</b></font><font color="green">1.Password Should be minimum 8 and maximum 15 characters Can contain alphabets, numbers and special characters.<br>2.Should not contain space</font>
<table style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 
                  width="236" border=4 align="center">
	<TR>
          <TD width="100%" height=26 bgcolor="#fafad2" align="center"><B><FONT face=Verdana 
                        color=#ffffff size=1 >&nbsp;</FONT></B><FONT face=Verdana 
                        color="#000000" size=2><b>Password Change Form</b></FONT></TD>
        </TR>
 <tr><td>
<table bgcolor="" cellpadding="5" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse" align="center">
	<tbody class="formTBody" >
	<tr>
		<td><font face=Verdana  size="2">User Id:<span class="mandatory">*</span></td>
		<td><font face=Verdana  size="2"><input type="text"  name="userId" value="<%=uId%>" styleClass="text-box"  readonly="true"/></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2">Old Password:</font><span class="mandatory">*</span></td>
		<td><input  type="password"  name="oldPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2" >New Password:</font><span class="mandatory">*</span></td>
		<td><input  type="password"  name="newPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2">Confirm Password:<span class="mandatory">*</span></td>
		<td><input  type="password"  name="confirmPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="button" class="btext" name="Save" value="Save" onclick="fnSave()">
			<input type="button" class="btext" name="Reset" value="Reset" onclick="fnReset()">
		</td>
	</tr>
	</tbody>
	</table>	
</td>
</tr>
</tbody>
</table>

</p>
<input type="hidden" name="special" value="<%=special%>">
</form>
</html>
