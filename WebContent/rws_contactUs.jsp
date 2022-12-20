
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/rws_header2.jsp"%>
<html>
<head>
<title>Welcome to Computerise Rural Information Systems Project(CRISP)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<Style>
<!--
BODY{Margin:0;}
.t3
{
    FONT-WEIGHT: 500;
    FONT-SIZE: 10pt;
    COLOR: slateblue;
    FONT-FAMILY: 'Times New Roman', Arial;
    TEXT-ALIGN: justify
}

.basetxt
{
    FONT-WEIGHT: normal;
    FONT-SIZE: 10px;
    COLOR: #564f21;
    FONT-STYLE: normal;
    FONT-FAMILY: "Times New Roman", Times, serif;
    TEXT-ALIGN: center
}

-->
</Style>

<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<script language="JavaScript1.2" src="verify.js"></script>
<body >
<script language="JavaScript">
 function saverecord()
 {
//  	alert("here")
  	if(!emptyTxtBox(window.document.thisForm.txtName.value,"Name")) { window.document.thisForm.txtName.focus() ;return false;}
//	alert("sadf");
	if(!emptyTxtBox(window.document.thisForm.txtComments.value,"Comments")) {window.document.thisForm.txtComments.focus(); return false;}
  	window.document.thisForm.SubmitFlag.value="true";
    return true;

//thisForm.submit  
 
 }
 </script>


<!--  Page Table -->

<table width="100%" height="100%" border="0" cellspacing=25>
<tr>
		<td valign="top">
			
			
			<br>
				
				<form action="" method="post" id="thisForm" name="thisForm" onsubmit="return saverecord();">
					<table width="100%">
						<tr>
							<td>
							<p class="btext"><font size="2">Thank you for visiting our home page. Please feel free to 
										leave your comments. 
										<br>Fields marked <strong>*</strong> are mandatory</FONT></p>
							</td>
							<td align="right" valign="bottom">
							<a href="../pred">Home</a>
							</td>
						</tr>
					</table>			
			<fieldset>
				<Table  height=253 width="100%" cellspacing=0 cellpadding=0 border=0  style="background-image : url(images2/bgpic1.jpg);background-repeat : no-repeat;background-position : 50% 50%;position : relative;background-attachment : fixed;"> 
					<tr>
						<td>
						</td>
					</tr>
					<TR >
						<TD valign=top colspan=4>
							<input type = "hidden" name = "TFlag" value = "CS" > 
							<input type="hidden" name="SubmitFlag" value="false">
							
							<br>
							
							<!--Start of contact us form table-->
						
						</td>
					</tr>    
					<tr>
						<td align="left"><font class="btext" >Name*&nbsp;:&nbsp;</font></td>
						<td align="left"><input class="textbox1" id="txtName" name="txtName"></td>
					</tr>
					<tr>
						<TD colspan=2 height=5px></td>
					</tr>
				
					<tr>
						<td align="left"><font class="btext">Email 
						:&nbsp;</font></td>
						<td align="left"><input class="textbox1" id="txtEmail" name="txtEmail"></td>
					</tr>
				 
					<tr>
						<TD colspan=2 height=5px></td>
					</tr>
				
					<tr>
						<td align="left"><font class="btext">   
						State/District :&nbsp;</font></td>
						<td align="left"><input class="textbox1"  id="txtFrom" name="txtFrom"></td>
					</tr>
					      
					<tr>
						<TD colspan=2 height=5px></td>
					</tr>
				
				      
					<tr>
						<td align="left"><font class="btext">Referred By&nbsp;</font></td>
						 <td align="left"><select class="textbox1"  name="txtHow" id = "txtHow" >
						 <option name = "www" value = "www" selected>WWW</option>
						 <option name = "Friends" value = "Friends">Friends</option>
						 <option name = "Informatics Issue(NIC Magazine)" value = "Informatics Issue">Informatics Issue(NIC Magazine)</option>
						 <option name = "NIC Official" value = "NIC Official">NIC Official</option>
						 <option name = "NIC Official" value = "NIC Official">Other</option>
						 </select>
						</td>
					</tr>
				
					<tr><TD colspan=2 height=5px></td></tr>
					<tr><td align="left"></td><td align="right"></td></tr>
				       
					<tr><td align="left"><font class="btext">Your Comments*:&nbsp;</font></td>
						<td align="left"><TEXTAREA class=textbox1 id=txtComments style="WIDTH: 307px; HEIGHT: 76px" name=txtComments></TEXTAREA></td>
					</tr>
				
					<tr><td align="right">&nbsp;</td><td align="right">&nbsp;</td>
					</tr>
				
					<tr>
						<td align="middle" colspan=2><input id="submit1" name="submit1" type="submit" value="Submit" >&nbsp;<input id="reset1" name="reset1" type="reset" value="Clear">
						</td>
					</tr>
				</tbody>
				</table>
				<fieldset>
				<!-- End of contact us form table-->
				</form>
				
				
				
				
			
		
			</td>
			</TR>
			<!-- page footer -->
			<tr >
			
			
			
			<td valign="bottom" class="pageFooter" align="center">
				Designed & Developed by National Informatics Centre, AP State Centre
				</td>
			</TR>
			</Table>
			
<!--  end of page table -->
	</td>
</tr>
</table>
<!--  end of page table -->
<h1>heading</h1>
FullName &nbsp;&nbsp; <input type='text' name='tst' id='tsts'>
<br/>
<button onclick='callfnc();'>Submit</button>
</body>
</body>
</html>


<%
try
{

     session.getAttributeNames();
     session.invalidate();
}
catch (java.lang.Exception isse)
{
    System.out.println("session already invalidated");
}

 %>



