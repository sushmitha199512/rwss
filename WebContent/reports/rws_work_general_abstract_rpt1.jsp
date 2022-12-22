<%@ include file = "conn.jsp" %>
<%
	//////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	%>
<html>
<head>

<script language="JavaScript">
function unview()
{
    var a=document.getElementById('combo').value;

	if(a=="-1")
	{
       document.getElementById('vbutton').disabled=true;
	}

}
	function fnSubmit()
	{

		//if(logValue=="admin" || logValue=="100000")
		//{
			if(document.f1.district.value=='00')
				document.f1.drill.value='null';
			else
				document.f1.drill.value='null';
			document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
			document.f1.action="./rws_work_gen1.jsp";
			document.f1.submit();
		//}
		//else
		//{
		//	document.f1.drill.value='1';
			//document.f1.distname.value = document.f1.districts.value;
			//document.f1.action="./rws_work_gen.jsp";
//			document.f1.submit();
	//	}
	}


</script>

<style type="text/css">
<!--
.style4 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style5 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style6 {font-family: Verdana, Arial, Helvetica, sans-serif}
-->
</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<p>&nbsp;</p>
<p>&nbsp;</p>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">
				<tr>
					<td align="right" class="bwborder"><a href="http://aprwss.gov.in/index.html"><span class="style5">Home</span></td>
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align="center" class="rptHeading style4">Works Abstract Report</td>
	</tr>

<%

		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");

try
{
%>
	<tr><td><span class="style5">District</span>&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px">
				<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{

	%>
					<!-- <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> -->
	<%
			}
						rs.close();
						stmt.close();
%>
		</SELECT>		</td></tr>
	   <tr><td><span class="style5">Financial Year&nbsp;&nbsp;<font color="red">*</font></span></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value='2009-10'>2009-2010</option>
		<option value='2008-09'>2008-2009</option></SELECT></td>
		<%

}
catch(Exception e)
{
	//////System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
	</tr>
<tr><td colspan="2" align="center" >
  <span class="style5">
  <input type="radio" value="1" name="planNonplan" checked>
  Plan&nbsp;&nbsp;
  <input type="radio" value ="2" name="planNonplan">
  Non Plan&nbsp;&nbsp;
  <input type="radio" value= "3" name="planNonplan">
  Both  </span></td>
</tr>


<!-- end of habitations -->


<%
	//if(district != null ){	//////System.out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onClick="fnSubmit()" class=btext value="View Report">		</td>
	</tr>
<%
	//}
%>
</table>
</td>
</tr>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>
  <!-- Page footer starts here -->
</p>
<tr height="2%">
	<td align="center" valign="bottom">
	  <div align="center" class="style5">Designed & Developed by National Informatics Centre, AP State Centre </div></td>
</tr>
<span class="style6">
</table>
</span>
</body>
</html>

<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="distname">
</form>
</body>
</html>

