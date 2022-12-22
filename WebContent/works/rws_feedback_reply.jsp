<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<%
		String message = "";
		if( request.getAttribute("msg") != null )
		{
			message = (String) request.getAttribute("msg");
		}
	String mail1=request.getParameter("mail");
	//System.out.println("mail1:"+mail1);
	String mail="";
	String qry=" select mail_id from rws_scheme_asset_feedback_tbl where id='"+mail1+"' ";
	stmt = conn.createStatement();
	//System.out.println("qry"+qry);
	rs=stmt.executeQuery(qry);
	if(rs.next())
	{
    mail=rs.getString(1);
	}
	//System.out.println("mail:"+mail);

%>
  
<html>
<head>
<title>Feed Back</title>
<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 18px;
	color: #0000FF;
}
.style4 {font-family: Verdana, Arial, Helvetica, sans-serif; font-weight: bold; }
.style5 {
	color: #000000;
	font-size: 12px;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}
.style6 {font-size: 10px}
.style12 {font-family: verdana; font-size: 12px; }
.style13 {color: #0000FF}
-->
</style>

<script language="javascript" type="text/javascript" >
	function setSubmit(FeedBackForm)
	{
		var desc = document.FeedBackForm.reply.value;
		var flag=true;
		if(desc == "")
		{
			alert("Reply should be Mandatory.");
			flag = false;
		}
		if(flag==true)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	function setReset(FeedBackForm)
	{
		document.FeedBackForm.reset();
		return false;
	}
</script>
    <script LANGUAGE="Javascript" SRC="../images/calender.js"></script>

<style type="text/css">
<!--
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 18px;
}
-->
</style>
</head>
<body>
<right><a href="#" class="style6" onclick="javascript:window.close()"><font face=verdana size=2>Close</a></right>
<table width="250" border="0" cellpadding="0" cellspacing="0" class="mainbox" align="center">
<tr>
<td>
<p>&nbsp;</p>
<%if(mail!=null && !mail.equals("")){%>
<p align="center" ><span class="style1"><font color="#CC0066" face=verdana><u>FeedBack Reply</u></font></span></p>
<form action="rws_feedback_reply_process.jsp" method="POST" name="FeedBackForm" >
<table align="center">
<tr>
  <td align=right valign="top" ><b><font size=2 face=verdana>Mail Id&nbsp;</b></td>
	<td align=left ><font face=verdana size=2><%=mail%></font></td></tr>
	<input type="hidden" name="mail" value="<%=mail%>">
<tr>
  <td align=right valign="top" ><b><font size=2 face=verdana>Reply&nbsp;</b></font><font face=verdana size=2 color=red>*</font></td>
	<td align=left ><textarea name="reply" rows="6" cols="25" ></textarea></td></tr>
<tr><td align=center colspan="2"><br>
	<input type="submit" name="submit" value="Send" onClick="return setSubmit(this)">&nbsp;&nbsp;
	<input type="submit" value="Reset" onClick="return setReset(this)"></td></tr>
</table>
<%}%>
	<input type="hidden" name="userid" value=<%=request.getParameter("userid")%>>
</form>
</td>
</tr>
</table>
<br>
<p align="center"><font color="red" face=verdana size=2><%=message%></font></p>
</body>
</html>