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
	  
	   
	   
	   month=request.getParameter("cmbMonth");
	   
	   year=request.getParameter("cmbYear");
	   program=request.getParameter("program");
	   subprogram=request.getParameter("subprogram");
	   
	   System.out.println("circle code"+circlecode);
	   System.out.println("subdivisioncode"+subdivisioncode);

	   System.out.println("month"+month);
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
	   
		if (rs.next())
		{
			System.out.println("program name");
			programname = rs.getString(2);
		}
		//rs.close();

		str="select subprogramme_CODE ,subprogramme_NAME from rws_subprogramme_tbl where programme_code=? and subprogramme_code=? ";
	pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,program);
	   pstmt.setString(2,subprogram);
	   
		if (rs.next())
		{
			subprogramname = rs.getString(2);
		}
		//rs.close();
		System.out.println("program"+program);
		System.out.println("subprogram"+subprogram);
		System.out.println("program name"+programname);
		System.out.println("subprogram name"+subprogramname);
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


	   
%>
</table>

<table border=1 cellspacing=1 cellpadding=1 width="100%" >
<tr>
<td colspan=20 align=center class=label bgcolor=#A899FB>Financial Progress Report</b></center></td>
</tr>
<tr>
<td class=label rowspan=2>S.No</b></td>
<%
 
%>
<td class=label rowspan=2>Work ID</b></td>
<td class=label rowspan=2>Work Name</b></td>
<td class=label rowspan=2>Estimated Value</b></td>
<td class=label colspan=3>Value of the Work Done</b></td>
<td class=label colspan=3>Payment Made</b></td>
</tr>
<tr>
<td class=label>Upto last month</b></td>
<td class=label>During this month</b></td>
<td class=label>Total</b></td>
<td class=label>Upto last month</b></td>
<td class=label>During this month</b></td>
<td class=label>Total</b></td>
</tr>
<%
try
{
	if (!request.getParameter("circle").equals("00") && !request.getParameter("division").equals("0") && request.getParameter("subdivision").equals("0") && !request.getParameter("cmbYear").equals("0") && request.getParameter("cmbMonth").equals("0"))
	{
	System.out.println("circle codeeeeeeeee"+circlecode);
	query="select division_office_name,sum(TOTAL_WORK_VAL_CLEAR_DUR_MON  ) as TOTAL_WORK_VAL_CLEAR_DUR_MON  ,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON  ) as TOTAL_WORK_VAL_CLEAR_UPTO_MON  ,sum(EXPENDITURE_UPTO_THE_MONTH  ) as EXPENDITURE_UPTO_THE_MONTH ,sum(EXPENDITURE_DUR_THE_MONTH  ) as EXPENDITURE_DUR_THE_MONTH,substr(b.office_code,5,2) from rws_division_office_tbl co,rws_physical_progress_tbl a,rws_financial_progress_tbl b where co.circle_office_code = substr(a.office_code,2,2) and co.circle_office_code = substr(b.office_code,2,2) and co.division_office_code = substr(a.office_code,4,1) and co.division_office_code = substr(b.office_code,4,1) and a.office_code=b.office_code and substr(b.office_code,2,2)=? and substr(b.office_code,4,1)=? group by division_office_name, substr(b.office_code,5,2)";
	pstmt=conn.prepareStatement(query);
		pstmt.setString(1,circlecode);
	    pstmt.setInt(2,divisioncode);
		
	    

	   rs=pstmt.executeQuery();
	    while(rs.next())
	   {
		   
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><a href="ReleasesExpenditureSubdivisionReport.jsp?circle=<%=circlecode%>&division=<%=divisioncode%>&subdivision=<%=rs.getString(6)%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=sln%></a></td> 
			 <!--  <td class=label><%=sln%></td> -->
			  
			  <td class=label>&nbsp;</td>
			  <td class=label>&nbsp;</td>
			  <td class=label><%=rs.getFloat(3)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=rs.getFloat(3)+rs.getFloat(2)%></td>
			  <td class=label><%=rs.getFloat(4)%></td>
			  <td class=label><%=rs.getFloat(5)%></td>
			  <td class=label><%=rs.getFloat(4)+rs.getFloat(5)%></td>
			  
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;
}
catch(Exception e)
   {
	    System.out.println("Exception"+e);
   }
    finally
	{
		
		
        conn.close();
	}
%>
</table>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>

</body>
</html>
