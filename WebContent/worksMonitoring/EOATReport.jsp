<%@ include file="header_rpt.jsp" %>
<%@ include file="conn3.jsp" %>

<html>

<head>
<script language="JavaScript">
function prifunc()
{
	window.print();
}
</script>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<body>
<!-- <center>
<span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>
</center> -->
<br><br>
<%
String query="";
String circlecode="";
	   int divisioncode=0;
	   String subdivisioncode="";
	   String AssetType="";
	   String year="";
	   String month="";
	   String assetName="";
	   String monthName="";
	   String circleofficename="";
	   String str="";
	   String divisionofficename="";
	   String subdivofficename="";
	   String programname="";
	   String subprogramname="";
	   String program="";
	   String subprogram="";
	   int habs=0;
	   int workstaken=0;
	    System.out.println(circlecode);
		int sln=1;
		int total=0;
		int balance=0;
	   
	   circlecode=request.getParameter("circle");
	   
	   divisioncode=Integer.parseInt(request.getParameter("division"));
	   
	   subdivisioncode=request.getParameter("subdivision");
	  
	   
	   
	  
	   
	   year=request.getParameter("cmbYear");
	   program=request.getParameter("program");
	  System.out.println("program"+program);
	   
	   System.out.println("circle code"+circlecode);
	   System.out.println("subdivisioncode"+subdivisioncode);

	  
		System.out.println("year"+year);
		String officeCode= "1"+circlecode+divisioncode+subdivisioncode;
%>
<%
	str="select CIRCLE_OFFICE_CODE ,CIRCLE_OFFICE_NAME from rws_circle_office_tbl where circle_office_code=? order by circle_office_code";
	pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,circlecode);
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			circleofficename = rs.getString(2);
		}
		//rs.close();

		str="select division_OFFICE_CODE ,division_OFFICE_NAME from rws_division_office_tbl where circle_office_code=? and division_office_code=? order by circle_office_code";
	pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			divisionofficename = rs.getString(2);
		}
		//rs.close();

		str="select subdivision_OFFICE_CODE ,subdivision_OFFICE_NAME from rws_subdivision_office_tbl where circle_office_code=? and division_office_code=? and subdivision_office_code=? order by circle_office_code";
	pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   pstmt.setString(3,subdivisioncode);
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			subdivofficename = rs.getString(2);
		}
		//rs.close();

		String str1="select programme_CODE ,programme_NAME from rws_programme_tbl where programme_code=? ";
	pstmt=conn.prepareStatement(str1);
	   pstmt.setString(1,program);
	   rs=pstmt.executeQuery();
		if (rs.next())
		{
			System.out.println("program name");
			programname = rs.getString(2);
		}
		//rs.close();

		System.out.println("Programmmmmmmm "+programname);

		
	 %>
<table>
		<%
 if (!request.getParameter("circle").equals("00") && !request.getParameter("circle").equals("-1"))
 {
%>
<td class=label>Circle:<%=circleofficename%></td>      
<%
  }
if (request.getParameter("division")!=null && !request.getParameter("division").equals("0"))
{

%>
	<td class=label>Division:<%=divisionofficename%></td> 
	<%
}
if (request.getParameter("subdivision")!=null && !request.getParameter("subdivision").equals("0"))
{
%>
<td class=label>SubDivision:<%=subdivofficename%></td> 
	<%
}

if (request.getParameter("program")!=null && !request.getParameter("program").equals("0"))
{
%>
<td class=label>Program:<%=programname%></td> 
	<%
}
	   
%>
</table>

<table border=1 cellspacing=1 cellpadding=1 width="100%" >
<tr>
<td colspan=20 align=center class=label bgcolor=#A899FB>EOAT Report</b></center></td>
</tr>
<tr>
<td class=label rowspan=2>S.No</b></td>
<%
 
%>
<td class=label >District</b></td>
<td class=label >PWS</b></td>
<td class=label >CPWS</b></td>
<td class=label >MPWS</b></td>
<td class=label >HANDPUMPS</b></td>

<td class=label>SHALLOW HANDPUMPS</b></td>
<td class=label>OPENWELLS</b></td>
<td class=label>PONDS</b></td>
<!-- <td class=label>Upto last month</b></td>
<td class=label>During this month</b></td>
<td class=label>Total</b></td> -->
</tr>
</table>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>
</center>
</body>
</html>
