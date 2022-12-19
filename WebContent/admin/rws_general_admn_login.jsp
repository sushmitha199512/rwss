<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
	<head>
		<script language="JavaScript" src="/pred/resources/javascript/md5.js"></script>
		<script language="JavaScript">
		function fnChangePassword(){
			var userId=document.forms[0].userId.value;
			var width = 400;
			var height = 280;
			var left = parseInt((screen.availWidth/2)-(width/2));
			var top = parseInt((screen.availHeight/2)-(height/2));
			var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
							   + "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
							   + "resizable=no,status=yes,left=100,top=100";
		     var url="rws_gen_admn_changepass_frm.jsp?special=N&userId="+userId;
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
				
		}
		function fnInit(){
			document.forms[0].userId.focus();
			userCheck();
		}
		function submitFn(){
				if(document.forms[0].userId.value!="" && document.forms[0].password.value!="" && document.forms[0].number.value!=""){	
				var width = 1000;
				var height = 650;
				var left = parseInt((screen.availWidth/2)-(width/2));
				var top = parseInt((screen.availHeight/2)-(height/2));
				var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
								   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
								   + "resizable=yes,status=yes,left=10,top=10";
					newWindow = window.open("rws_general_admn_loginvalidate.jsp?userId="+document.forms[0].userId.value+"&password="+document.forms[0].password.value+"&captcha="+document.forms[0].number.value, "_New", properties);
					newWindow.focus();
					//document.forms[0].submit();
				}
				else if(document.forms[0].userId.value==""){
					alert("UserId is required");
					document.forms[0].userId.focus();
					return false;
				}
				else if(document.forms[0].password.value==""){
					alert("Password is required");
					document.forms[0].password.focus();
					return false;
				}
				/* else if(document.forms[0].number.value==""){
					alert("Please Enter Captch code");
					return false;
					} */
				return false;
			}
		
		function validPassword()
		{
		var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$%\^&\*\-\+_\=]){2,})(?=.{8,})");
		var validPassword = strongRegex.test(document.forms[0].password.value);//alert(validPassword);
		//encryptPassword();
		//submitFn();

		  if(document.forms[0].password.value.length>0)
		{
		    if(validPassword==true)
		       {
		    	//encryptPassword();
		    	submitFn();
		       }
		    else
		       {
			    	document.forms[0].password.value="";
			    	document.forms[0].number.value="";
			    	//alert("The password must have atleast 8 chars with two uppercase letter, two lower case letter, two digit and any two of !@#$%^&*-_+= this Special Character");
			    	alert("The password does not meet the below password policy requirements :\n\n  * Minimum password length 8 characters\n  * Two upper case letters\n  * Two lower case letters\n  * Two numbers\n  * Two Special Character ( !@#$*_ )");
			    	document.forms[0].password.focus();
			    	location.reload();
		       }
		       } 
		}
		
		function userCheck()
		{
			var response = '';
			 var path=  window.location.href;
			 var arr  = path.split("pred/");
			 $.ajax({ type: "POST",   
			          url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
			          async: false,
			          success : function(resp)
			          {
			        	  resp;
			             // window.location = '/../commons/UnAuthorize.jsp';

			          }
			 });  
		}
		</script>	
	</head>
<body bgcolor="#edf2f8" onload="fnInit();">
	<form  method="post" focus="userId">
	<table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=200>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<TABLE id=AutoNumber16 style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 
                  width="236" border=4 align="center">
              
        <TBODY >
         <TR>
          <TD width="100%" height=26 bgcolor="#f5deb3"><B><FONT face=Verdana 
                        color=#ffffff size=1>&nbsp;</FONT></B><FONT face=Verdana 
                        color="#000000" size=2><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Super User Login </b></FONT></TD>
        </TR>
        <TR>
          <TD width="100%" height=19><DIV align=center>
              <CENTER>
                <TABLE id=AutoNumber14 style="BORDER-COLLAPSE: collapse" 
                        borderColor=#111111 height=69 cellSpacing=0 
                        cellPadding=0 width="96%" border=0>
                  <TBODY>
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 size=1><B>&nbsp;User 
                        Id</B></FONT></TD>
                      <TD width="68%" bgColor=#ffffff height=32><P align=center>
                          <input type="text" name="userId" value="" styleClass="thin-text-box"  onKeyUp="this.value=this.value.toUpperCase();"/>
                      </P></TD>
                    </TR>
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 
                              size=1><B>&nbsp;Password </B></FONT></TD>
                      <TD width="68%" bgColor=#ffffff height=32><P align=center>
                         <input type="password" name="password"   />
                      </P></TD>
                    </TR>
                    <tr ><td width="100%" bgcolor="#ffffff" colspan="2" height="10" >Security Code

	                   <%@include file="/Captcha/form.jsp"%>
	                              </td></tr>
                    <TR align=center>
                      <TD width="100%" bgColor=#ffffff colSpan=2><BR>
                            <input name="submit2" type="button" style="BORDER-RIGHT: #ffa87d 2px inset; BORDER-TOP: #ffa87d 2px inset; BORDER-LEFT: #ffa87d 2px inset; COLOR: #000000; BORDER-BOTTOM: #ffa87d 2px inset; BACKGROUND-COLOR: #ffe9d2" value="Submit" styleClass="btext" onclick="validPassword()"/>
                            <input name="reset2" type="reset"   style="BORDER-RIGHT: #ffa87d 2px inset; BORDER-TOP: #ffa87d 2px inset; BORDER-LEFT: #ffa87d 2px inset; COLOR: #000080; BORDER-BOTTOM: #ffa87d 2px inset; BACKGROUND-COLOR: #ffe9d2" value="Reset" styleClass="btext" onclick="location.reload();" />
						</TD>
                    </TR>
					<tr><td colSpan=2 align="center">

					  <BR><font face=verdana size=2 color=blue ><b><a href="#" onclick="fnChangePassword()">Change Password</a></b></td></tr> 
					<tr><td>
					
					</td></tr>
    </TBODY>
    </TABLE>
</form>
</body>
</html>