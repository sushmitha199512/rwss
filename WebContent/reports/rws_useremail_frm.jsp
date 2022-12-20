<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>

<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<SCRIPT LANGUAGE="JavaScript">

	function fnSubmit()
	{
		document.f1.action="./rws_useremail_rpt.jsp";
		document.f1.submit();
				
	}
</SCRIPT>
</head>
	<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
		<form name="f1"  action="" method="post">

	
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=450>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				
				<td class="" align=right>
<a href="/pred/home.jsp"><b>Back</b></a>&nbsp;&nbsp;
</td>
				
				
			</table>
		</caption>
		
		
		<tr bgcolor="#8A9FCD" align="center">
		
		<td align="center" class="rptHeading" > Offices Having Email Id / Not Having Email Id Report  </td>
		
</tr>
		
		
		
		
		
	<tr bgcolor="" align="left">
		<td class=rptLabel> <input type="radio" value="1" name="abc" >Circle Office Users Having Email-Id's</td>&nbsp
		</tr>
	<tr bgcolor="" align="left">
		<td class=rptLabel> <input type="radio" value="2" name="abc" >Circle Office Users Not Having Email-Id's</td>&nbsp
  		</tr>
  	<tr bgcolor="" align="left">
  		<td class=rptLabel> <input type="radio" value="3" name="abc" >Division Office users  Having Email-Id's</td> &nbsp 
    	</tr>
    <tr bgcolor="" align="left">
    	<td class=rptLabel> <input type="radio" value="4" name="abc" >Division Office users Not Having Email-Id's</td>
    	</tr>
    <tr bgcolor="" align="left">
    	<td class=rptLabel> <input type="radio" value="5" name="abc" >SubDivision Office Users  Having Email-Id's</td>
    	</tr>
    <tr bgcolor="" align="left">
    	<td class=rptLabel> <input type="radio" value="6" name="abc" >SubDivision Office Users Not Having Email-Id's</td>
    		
    </tr>	
    
    <tr bgcolor="" align="left">
    	<td class=rptLabel> <input type="radio" value="7" name="abc" >Priveleged Users  Having Email-Id's</td>
    		
    </tr>
    <tr bgcolor="" align="left">
    	<td class=rptLabel> <input type="radio" value="8" name="abc" >Priveleged Users Not Having Email-Id's</td>
    		
    </tr>	
    	</tr>
   	
		
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center" > <input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report"></td>
	</tr>
	
</table>
<table align=center>
<tr>
					<td align="center" class="bwborder" bgcolor="#E6FDFF"><b>Note:<font color=red>*</font>SELECT ANY OPTION<b/></td> 
				</tr>
</table>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>

