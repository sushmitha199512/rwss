<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
	Statement stmt1 = null,s1=null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null,r1;

	Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	ResultSet rs5=null;
    String temp=null;
	
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
window.history.forward(1);
function unview()
{
   var a=document.getElementById('combo').value;
	//alert(a);
	if(a!="-1")
	{
       document.f1.assetType[0].checked=true;
	}

	
	 
}

	function fnSubmit()
{
	        document.f1.assetType[0].checked=true;
			document.f1.action="./rws_wrks_entered.jsp";
			document.f1.submit();
	
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
<body bgcolor="#edf2f8">

<form name=f1 method="post" onLoad="unview">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 width="40%" rules="rows"   bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width="40%"  align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder">
				<font color="#FFFFFF">Works Entered Status Report</font>
			</td>	
		</tr>

<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String Const=null,consCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;
    
     try
{%>
<TR> 
	<TD  valign=top  align="center">

<table  bordercolor= navy width="100%"  border=1 rules="rows" style="border-collapse:collapse" align = center>

	<% rDist = request.getParameter("district");
	
			
%>
		<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font>
		
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<!--<option value="-1">SELECT...</option>-->
				 <option value="51">ALL</option>
<%
					session.setAttribute("dCode",rDist);
				    session.setAttribute("dName","ALL");
			
				

%>
			</select>
		</td>
	</tr>

   
<!--**************************************************************************************************-->
	
	<tr>
			<td class = btext nowrap >
				<font color=navy><b>Choose Below Option</b> </font>
				<font color="red">*</font></td>
			</td></tr>
			<TR>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" id="combo" value="01"  onClick="showtable('01')" ><font size=2 color="purple">No Of Works Entered</font></td></tr>
		</table>
			
   
<!--<TD  valign=top height=40% align="center" width="70%">-->
   <script>
				function showtable(index)
	{
				    //alert(document.getElementById('assetType').value);
					//temp="01";
					document.f1.action="./rws_works_frm.jsp";
			        document.f1.submit();
					return false;
					//document.f1.assetType[0].checked=true;
				    
	}

	</script>
	<INPUT TYPE="hidden" name="assetType" value="<%=temp%>" checked>


<% if(request.getParameter("assetType").equals("01")) {
	
	%>


	<tr>

		<td  align=center >

		<input type=button onclick="fnSubmit()" value="View Report" class = btext ></td>
	</tr>

<%} 
%>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ 
			//e.printStackTrace();
			}
	finally
	{
		conn.close();
	}%>
