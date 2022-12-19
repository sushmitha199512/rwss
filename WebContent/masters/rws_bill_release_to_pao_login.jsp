<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<script language="JavaScript" src="/pred/resources/javascript/md5.js"></script>
<script>
function fnChangePassword()
{
	var userId=document.forms[0].userId.value;
	var width = 400;
	var height = 280;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=no,status=yes,left=100,top=100";
   var url="rws_bank_chpwd_frm.jsp?special=N&userId="+userId;
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}

function fnInit()
{
	var randomnumber=Math.floor(Math.random()*99999999);
	document.forms[0].slt.value=randomnumber;
	document.forms[0].password1.focus();
}
function submitFn()
	{
		document.forms[0].password.value=hex_md5(document.forms[0].password1.value+document.forms[0].slt.value);
		if(document.forms[0].userId.value!="" && document.forms[0].password1.value!="")
		{
		document.forms[0].password1.value="";
		document.forms[0].action="paoLoginValidate.jsp";
		document.forms[0].submit();
		}
		else if(document.forms[0].userId.value=="")
		{
			alert("UserId is required");
			document.forms[0].userId.focus();
			return false;
		}
		else if(document.forms[0].password1.value=="")
		{
			alert("Password is required");
			document.forms[0].password1.focus();
			return false;
		}
		return false;
	}
</script>
<body onload="fnInit()">
<form  method="post" focus="userId">
<table border = 0>	
		<caption>
			<table  border=0 width="960px" rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
						<a href="../home.jsp">Home</a><a href="../home.jsp"><!-- Print --></a>
					</td>
				</tr>
			</table>
		</caption>
</table>
    <TABLE id=AutoNumber16 style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 
                  width="236" border=4 align="center">
              
        <TBODY >
         <TR>
          <TD width="100%" height=26 bgcolor="#99CC00"><B><FONT face=Verdana 
                        color=#ffffff size=1>&nbsp;</FONT></B><FONT face=Verdana 
                        color="#000000" size=2><b>EE-Budget Login </b></FONT></TD>
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
                          <input type="text" name="userId" value="EE-Budget" styleClass="thin-text-box"  readonly="true" />
                      </P></TD>
                    </TR>
                    <TR>
                      <TD width="32%" bgColor=#ffffff height=32><FONT 
                              face=Verdana color=#000000 
                              size=1><B>&nbsp;Password </B></FONT></TD>
                      <TD width="68%" bgColor=#ffffff height=32><P align=center>
                          <input type="hidden" name="slt">
                          <input type="hidden"  name="password" />
                          <input type="password" name="password1" value="" styleClass="thin-text-box"  />
                      </P></TD>
                    </TR>
                    <TR align=center>
                      <TD width="100%" bgColor=#ffffff colSpan=2><BR>
                            <input name="submit2" type="button" style="BORDER-RIGHT: #ffa87d 2px inset; BORDER-TOP: #ffa87d 2px inset; BORDER-LEFT: #ffa87d 2px inset; COLOR: #000000; BORDER-BOTTOM: #ffa87d 2px inset; BACKGROUND-COLOR: #ffe9d2" value="Submit" styleClass="btext" onclick="submitFn()"/>
                            <input name="reset2" type="reset"   style="BORDER-RIGHT: #ffa87d 2px inset; BORDER-TOP: #ffa87d 2px inset; BORDER-LEFT: #ffa87d 2px inset; COLOR: #000080; BORDER-BOTTOM: #ffa87d 2px inset; BACKGROUND-COLOR: #ffe9d2" value="Reset" styleClass="btext" />
						</TD>
                    </TR>
					<tr><td colSpan=2 align="center">
					<BR><font face=verdana size=2 color=blue ><b><a href="#" onclick="fnChangePassword()">Change Password</a></b></td></tr>
    </TBODY>
    </TABLE>
	</form>
	</body>