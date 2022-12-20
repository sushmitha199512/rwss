<%@ include file="/commons/rws_psonly_restrict_frm.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>

<%
		String message = "";
		if( request.getAttribute("msg") != null )
		{
			message = (String) request.getAttribute("msg");
		}
System.out.println("msg:"+message);
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
function echeck(str) {
		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }
		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID7")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

 		 return true					
	}
	function setSubmit(FeedBackForm)
	{
		var desc = document.FeedBackForm.desc.value;
		var flag=true;
		if(desc == "")
		{
			alert("Suggestion should be Mandatory.");
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
<center><img src="../images/suggestion_box.gif" width=150 height=100></center>
<BR>
<center><font color="blue" face=verdana size=2><%=message%></font></center>
<table width="250" border="0" cellpadding="0" cellspacing="0" class="mainbox" align="center">
<tr>
<td>
<p>&nbsp;</p>
<p align="center" ><span class="style1"><font color="#CC0066" face=verdana><u>Suggestion/Feed Back</u></font></span></p>
<form action="feedbackProcess.jsp" method="POST" name="FeedBackForm" >
<table align="center">
	<tr>
  <td align=right valign="top" ><b><font size=2 face=verdana>Suggestion&nbsp;</font></b><font face=verdana size=2 color=red>*</font></td>
	<td align=left ><textarea name="desc" rows="6" cols="25" ></textarea></td></tr>
<tr><td align=center colspan="2"><br>
	<input type="submit" name="submit" value="Submit Feedback" onClick="return setSubmit(this)">&nbsp;&nbsp;
	<input type="submit" value="Reset" onClick="return setReset(this)"></td></tr>
</table>
	<input type="hidden" name="userid" value=<%=request.getParameter("userid")%>>
	<input type="hidden" name="name" value="">
	<input type="hidden" name="desg" value="">
	<input type="hidden" name="mail" value="">
	<input type="hidden" name="serversysdate" value=<%=session.getAttribute("serversysdate")%>>
</form>
</td>
</tr>
</table>
</body>
</html>