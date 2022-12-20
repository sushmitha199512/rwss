<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		try{
	 

%>
<html>
<head>
<title>WaterSoft EOAT</title>

<script language="JavaScript">

function fnSubmit()
{      
  var  a=document.f1.work_id.value;
     if(a.length != 14)
     {    
	     alert("Work Id must be 14 digits");
		 return false;
  	}
  document.f1.action="./rws_wrk_progress_resource_rpt.jsp?work_id="+document.f1.work_id.value;
document.f1.submit();
}
function init()
{

document.f1.work_id="";
}

function numeralsOnly(evt)
{
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57))
	{
        alert("Only numbers are allowed in this field.");
        return false;
    }
	return true;
}


	
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8" >

<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="2">Work Id - Work Based Report </td>
</tr>

		

<TR> 
	<TD   valign=top  align="center" height="35%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>


<tr align=center>

<td class = btext  ><font color=navy><b>Enter Work Id<font color="red"><b>*</b></font>:</b></font><input type=text name=work_id size="14" maxlength="14" onkeypress="return numeralsOnly(event)" >
		
		</td>
		
</tr>




		
</table>

</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	


			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Work Id Details" class = btext></td>
	</tr>
</table>
	<%
			//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	finally
	{
    try
    {
       
		conn.close();
   }
catch(Exception e)
{
e.printStackTrace();
}
    }

		%>
</TD></TR>
</TABLE>
</form>
<pre>
Note:-<font color="red"><b>Enter 14 digits valid Work Id</b></font>
</pre>
</body>
<%@ include file="/commons/rws_footer.jsp" %>

<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

</html>
