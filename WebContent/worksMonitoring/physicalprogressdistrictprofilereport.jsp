<%@ include file="conn3.jsp" %>
<%@ include file="header_rpt.jsp" %>
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
	   String divisionofficename="";
	   String subdivofficename="";
	   String str="";
	   int habs=0;
	    System.out.println(circlecode);
		int sln=1;
		String nyear="";
	   
	   if(request.getParameter("circle")!=null)
	   circlecode=request.getParameter("circle");
	   if(request.getParameter("division")!=null)
	   divisioncode=Integer.parseInt(request.getParameter("division"));
	   if(request.getParameter("subdivision")!=null)
	   subdivisioncode=request.getParameter("subdivision");
	  if(request.getParameter("AssetType")!=null)
	   AssetType=request.getParameter("AssetType");
	   if(request.getParameter("cmbMonth")!=null)
	   month=request.getParameter("cmbMonth");
	   if(request.getParameter("cmbYear")!=null)
	   year=request.getParameter("cmbYear");
		System.out.println("circle code"+circlecode);
		System.out.println("division code"+divisioncode);
		System.out.println("subdivision code"+subdivisioncode);
		System.out.println("assettype"+AssetType);
		System.out.println("month"+month);
		System.out.println("year"+year);
		String officeCode= "1"+circlecode+divisioncode+subdivisioncode;
		
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

		str="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type=?"; 
		pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,AssetType);
	   
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			assetName = rs.getString(2);
		}
		//rs.close();

		str="select distinct year from rws_physical_progress_tbl where year=?";
		pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,year);
	   System.out.println("year"+year);
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			System.out.println("year"+year);
			nyear = rs.getString(1);
			System.out.println("nyear"+nyear);
		}
		//rs.close();

		str="select month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.month=?";
		pstmt=conn.prepareStatement(str);
	   System.out.println("month"+month);
	   System.out.println(str);
		pstmt.setString(1,month);
		if (rs.next())
		{
			monthName = rs.getString(2);
			System.out.println("monthName"+monthName);
		}
		//rs.close();
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
if (request.getParameter("AssetType")!=null && !request.getParameter("AssetType").equals("0"))
{
%>
<td class=label>Asset Type:<%=assetName%></td> 
	<%
}
if (request.getParameter("cmbYear")!=null && !request.getParameter("cmbYear").equals("0"))
{
%>
<td class=label>Year:<%=nyear%></td> 
	<%
}
//if (request.getParameter("cmbMonth")!=null && !request.getParameter("cmbMonth").equals("0"))
//{
%>
<!-- <td class=label>Month:<%=monthName%></td>  -->
	<%
//}
%>
		
<table border=1 cellspacing=1 cellpadding=1 width="100%" >
<tr>
<td colspan=20 align=center class=label bgcolor=#A899FB>Physical Progress District Profile</b></center></td>
</tr>
<tr>
<td class=label>S.No</b></td>
<%
 if(circlecode.equals("00"))
 {
%>

<td class=label >District </b></td> 
<%
 }
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label >District </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label >Division </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label >SubDivision </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label >SubDivision </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label >Division </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label >Circle </b></td> 
<%
}
%>

<td class=label>Total Value of Works Cleared</b></td>
<td class=label>No.of Habitations Covered</b></td>
<td class=label>Total No.of Works Completed</b></td>
<!-- <td class=label>Population Benefited</b></td> -->
<!-- <td class=label>Total No.of On-going Works</b></td> -->
<td class=label>Cost of On-going Works</b></td>
<!-- <td class=label>Population to be benefited</b></td> -->
</tr>
<%
try
{
	if (request.getParameter("circle").equals("00"))
	{
	System.out.println("circle code"+circlecode);
	query="select circle_office_name,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON ) as TOTAL_WORK_VAL_CLEAR_UPTO_MON  ,sum(NO_OF_PC_HABS_COV_UPTO_MON ) as NO_OF_PC_HABS_COV_UPTO_MON ,sum(NO_OF_NSS_HABS_COV_UPTO_MON ) as NO_OF_NSS_HABS_COV_UPTO_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON ) as TOT_NO_WORKS_COMP_UPTO_MON  ,sum(COST_OF_ONGO_WORKS_UPTO_MON ) as COST_OF_ONGO_WORKS_UPTO_MON,substr(pp.office_code,2,2),substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and year= ? and asset_type = ? group by circle_office_name, substr(pp.office_code,2,2),substr(pp.office_code,4,1)";
	pstmt=conn.prepareStatement(query);
	   
	 pstmt.setString(1,year);
	    pstmt.setString(2,AssetType);   

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><a href="physicalprogressdisprodivisionreport.jsp?circle=<%=rs.getString(7)%>&division=<%=rs.getInt(8)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td> 
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && month.equals("0"))
	{
 query="select circle_office_name,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON ) as TOTAL_WORK_VAL_CLEAR_UPTO_MON  ,sum(NO_OF_PC_HABS_COV_UPTO_MON ) as NO_OF_PC_HABS_COV_UPTO_MON ,sum(NO_OF_NSS_HABS_COV_UPTO_MON ) as NO_OF_NSS_HABS_COV_UPTO_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON ) as TOT_NO_WORKS_COMP_UPTO_MON  ,sum(COST_OF_ONGO_WORKS_UPTO_MON ) as COST_OF_ONGO_WORKS_UPTO_MON,substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? group by circle_office_name, substr(pp.office_code,4,1)";

  pstmt=conn.prepareStatement(query);
	    pstmt.setString(1,circlecode);
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <!-- <td class=label><a href="PhysicalProgressdivisionReport.jsp?circle=<%=circlecode%>&division=<%=rs.getInt(7)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td> -->
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}	  
sln=1;

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON ) as TOTAL_WORK_VAL_CLEAR_UPTO_MON  ,sum(NO_OF_PC_HABS_COV_UPTO_MON ) as NO_OF_PC_HABS_COV_UPTO_MON ,sum(NO_OF_NSS_HABS_COV_UPTO_MON ) as NO_OF_NSS_HABS_COV_UPTO_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON ) as TOT_NO_WORKS_COMP_UPTO_MON  ,sum(COST_OF_ONGO_WORKS_UPTO_MON ) as COST_OF_ONGO_WORKS_UPTO_MON from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? group by division_office_name, substr(pp.office_code,4,1)";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select subdivision_office_name,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON ) as TOTAL_WORK_VAL_CLEAR_UPTO_MON  ,sum(NO_OF_PC_HABS_COV_UPTO_MON ) as NO_OF_PC_HABS_COV_UPTO_MON ,sum(NO_OF_NSS_HABS_COV_UPTO_MON ) as NO_OF_NSS_HABS_COV_UPTO_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON ) as TOT_NO_WORKS_COMP_UPTO_MON  ,sum(COST_OF_ONGO_WORKS_UPTO_MON ) as COST_OF_ONGO_WORKS_UPTO_MON from rws_subdivision_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and co.subdivision_office_code = substr(pp.office_code,5,2) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and substr(pp.office_code,5,2)=? and year= ? and asset_type = ? group by subdivision_office_name, substr(pp.office_code,5,2)";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   pstmt.setString(3,subdivisioncode);
	    pstmt.setString(4,year);
	    pstmt.setString(5,AssetType);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && !month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,TOTAL_WORK_VAL_CLEAR_UPTO_MON,NO_OF_PC_HABS_COV_UPTO_MON,NO_OF_NSS_HABS_COV_UPTO_MON ,TOT_NO_WORKS_COMP_UPTO_MON ,COST_OF_ONGO_WORKS_UPTO_MON from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and year= ? and asset_type = ? and month=? ";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   
	    pstmt.setString(3,year);
	    pstmt.setString(4,AssetType);
		pstmt.setString(5,month);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && !month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select circle_office_name,TOTAL_WORK_VAL_CLEAR_UPTO_MON,NO_OF_PC_HABS_COV_UPTO_MON,NO_OF_NSS_HABS_COV_UPTO_MON ,TOT_NO_WORKS_COMP_UPTO_MON ,COST_OF_ONGO_WORKS_UPTO_MON,substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? and month=? ";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   
	   
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
		pstmt.setString(4,month);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

//subdivision report

if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && !month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select subdivision_office_name,TOTAL_WORK_VAL_CLEAR_UPTO_MON,NO_OF_PC_HABS_COV_UPTO_MON,NO_OF_NSS_HABS_COV_UPTO_MON ,TOT_NO_WORKS_COMP_UPTO_MON ,COST_OF_ONGO_WORKS_UPTO_MON from rws_subdivision_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and co.subdivision_office_code = substr(pp.office_code,5,2) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and substr(pp.office_code,5,2)=? and year= ? and asset_type = ? and month=? ";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   pstmt.setString(3,subdivisioncode);
	    pstmt.setString(4,year);
	    pstmt.setString(5,AssetType);
		 pstmt.setString(6,month);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   habs=rs.getInt(3)+rs.getInt(4);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=rs.getFloat(2)%></td>
			  <td class=label><%=habs%></td>
			  <td class=label><%=rs.getInt(5)%></td>
			  <td class=label><%=rs.getFloat(6)%></td>
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
</center>
</body>
</html>
