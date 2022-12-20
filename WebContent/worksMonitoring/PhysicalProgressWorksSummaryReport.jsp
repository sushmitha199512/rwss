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
	   String nyear="";
	   String month="";
	   String assetName="";
	   String monthName="";
	   String circleofficename="";
	   String str="";
	   String divisionofficename="";
	   String subdivofficename="";
	    System.out.println(circlecode);
		int sln=1;
	   
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

		//str="select distinct asset_type,type_of_asset_name from rws_physical_progress_tbl pp,rws_asset_type_tbl at where pp.asset_type=at.TYPE_OF_ASSET_CODE and pp.asset_type=?"; 
		str="select distinct TYPE_OF_ASSET ,type_of_asset_name from RWS_WORK_ADMN_TBL pp,rws_asset_type_tbl at where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and pp.TYPE_OF_ASSET=?"; 
		pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,AssetType);
	   
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			assetName = rs.getString(2);
		}
		//rs.close();

		//str="select distinct year from rws_physical_progress_tbl where year=?";
		str="select distinct year from RWS_WORK_EXPENDITURE_TBL where year=?";
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

		//str="select month,month_name from rws_physical_progress_tbl pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.month=?";
		str="select month,month_name from RWS_WORK_EXPENDITURE_TBL pp,rws_month_mast_tbl mm where pp.month=mm.month_code and pp.month=?";
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
<td class=label><font face=verdana size=2><b>Circle:<%=circleofficename%></td>      
<%
  }
if (request.getParameter("division")!=null && !request.getParameter("division").equals("0"))
{

%>
	<td class=label><font face=verdana size=2><b>Division:<%=divisionofficename%></td> 
	<%
}
if (request.getParameter("subdivision")!=null && !request.getParameter("subdivision").equals("0"))
{
%>
<td class=label><font face=verdana size=2><b>SubDivision:<%=subdivofficename%></td> 
	<%
}
if (request.getParameter("AssetType")!=null && !request.getParameter("AssetType").equals("0"))
{
%>
<td class=label><font face=verdana size=2><b>Asset Type:<%=assetName%></td> 
	<%
}
if (request.getParameter("cmbYear")!=null && !request.getParameter("cmbYear").equals("0"))
{
%>
<td class=label><font face=verdana size=2><b>Year:<%=nyear%></td> 
	<%
}
//if (request.getParameter("cmbMonth")!=null && !request.getParameter("cmbMonth").equals("0"))
//{
%>
<!-- <td class=label>Month:<%=monthName%></td>  -->
	<%
//}
%>
</table>
<%
	   if (AssetType.equals("01"))
		{
			assetName = "PWS";
		}
		if (AssetType.equals("02"))
		{
			assetName = "MPWS";
		}
		if (AssetType.equals("03"))
		{
			assetName = "CPWS";
		}
		if (AssetType.equals("04"))
		{
			assetName = "Hand PumpS";
		}
		if (AssetType.equals("05"))
		{
			assetName = "Shallow Hand Pumps";
		}
%>
<table border=1 cellspacing=1 cellpadding=1 width="100%" >

<tr>
<td colspan=20 align=center class=label bgcolor=#A899FB><font face=verdana size=2><b>Summary Report of Physical Progress of Works</b></center></td>
</tr>
<tr>
 <td class=label ><font face=verdana size=2>S.No</b></td>  
 <%
 if(circlecode.equals("00"))
 {
%>

<td class=label ><font face=verdana size=2>District </b></td> 
<%
 }
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && month.equals("0"))
{
%>
<td class=label ><font face=verdana size=2>District </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && month.equals("0"))
{
%>
<td class=label ><font face=verdana size=2>Division </b></td> 
<%
}


if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !month.equals("0"))
{
%>
<td class=label ><font face=verdana size=2>Division </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && !month.equals("0"))
{
%>
<td class=label ><font face=verdana size=2>Circle </b></td> 
<%
}
%>
 <td class=label ><font face=verdana size=2>No.of Works Sanctioned </b></td> 
 <td class=label ><font face=verdana size=2>Tendered Cost</b></td>  
 <td class=label ><font face=verdana size=2>Total Expenditure</b></td>  
 <!--  <td class=label colspan=2>Physical Progress</b></td>  -->
  <td class=label ><font face=verdana size=2>% of Physical Progress</b></td>  
  <td class=label ><font face=verdana size=2>% of Overall Expenditure</b></td>  
  </tr>
<!--   <tr>
<td class=label>New</b></td>
<td class=label>Augmentation</b></td>
<td class=label>New</b></td>
<td class=label>Augmentation</b></td>
</tr> -->
<%
try
{
	int no_work = 0;
 //if (!request.getParameter("circle").equals("00") && request.getParameter("division").equals("0") && request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && request.getParameter("cmbMonth").equals("0"))
 query = "select count(work_id) from RWS_WORK_ADMN_TBL";
 pstmt=conn.prepareStatement(query);
	   
	    rs=pstmt.executeQuery();
	   if(rs.next())
	   {
	   no_work = rs.getInt(1);
	   }
	   System.out.println("no_work"+no_work);
 if(circlecode.equals("00"))
	{
 //query="select circle_office_name,sum(NO_NEW_WORKS_SANC_UPTO_MON) as NO_NEW_WORKS_SANC_UPTO_MON ,sum(NO_AUG_WORKS_SANC_UPTO_MON) as NO_AUG_WORKS_SANC_UPTO_MON,sum(WORK_TENDER_COST_UPTO_MON) as WORK_TENDER_COST_UPTO_MON ,sum(TOT_EXP_INLAKHS_UPTO_MON) as TOT_EXP_INLAKHS_UPTO_MON ,sum(NO_NEW_WORKS_INPROG_UPTO_MON) as NO_NEW_WORKS_INPROG_UPTO_MON ,sum(NO_AUG_WORKS_INPROG_UPTO_MON) as NO_AUG_WORKS_INPROG_UPTO_MON,sum(PER_PHY_PROGRESS) as PER_PHY_PROGRESS ,sum(PER_OF_OVERALL_EXP) as PER_OF_OVERALL_EXP,substr(pp.office_code,2,2),substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and year= ? and asset_type = ? group by circle_office_name, substr(pp.office_code,2,2),substr(pp.office_code,4,1)";
query="select circle_office_name,sum(TENDER_AMOUNT) as TENDER_AMOUNT,sum(EXPENDITURE) as EXPENDITURE,sum(PERCENT_COMPLETED) as PERCENT_COMPLETED,substr(wa.office_code,2,2),substr(wa.office_code,4,1) from rws_circle_office_tbl co,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt,RWS_WORK_ADMN_TBL wa where co.circle_office_code = substr(wa.office_code,2,2) and ta.work_id = we.work_id and we.work_id = mt.work_id and mt.work_id = wa.work_id and wa.work_id = ta.work_id and we.year = '" + year + "' and wa.TYPE_OF_ASSET = '" + AssetType + "' group by circle_office_name,substr(wa.office_code,2,2),substr(wa.office_code,4,1)";
 System.out.println("query"+query);
  pstmt=conn.prepareStatement(query);
	   
	  //  pstmt.setString(1,year);
	  // pstmt.setString(2,AssetType);
		
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
 		   <tr>     
			  <td class=label><font face=verdana size=2><%=sln%></td>
			  <td class=label><font face=verdana size=2><a href="PhysicalProgressdivisionReport.jsp?circle=<%=rs.getString(5)%>&division=<%=rs.getInt(6)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td>
			  <td class=label><font face=verdana size=2><%=no_work%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(2)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(4)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)/100%></td>
			  
			  </tr>
			  
  <%
	  sln++;
		 }
	}	  
sln=1;


if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && month.equals("0"))
	{
 query="select circle_office_name,sum(TENDER_AMOUNT) as TENDER_AMOUNT,sum(EXPENDITURE) as EXPENDITURE,sum(PERCENT_COMPLETED) as PERCENT_COMPLETED,substr(wa.office_code,4,1) from rws_circle_office_tbl co,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt,RWS_WORK_ADMN_TBL wa where co.circle_office_code = substr(wa.office_code,2,2) and ta.work_id = we.work_id and we.work_id = mt.work_id and mt.work_id = wa.work_id and wa.work_id = ta.work_id and co.circle_office_code=substr(wa.office_code,2,2) and substr(wa.office_code,2,2)=? and year= ? and TYPE_OF_ASSET = ? group by circle_office_name, substr(wa.office_code,4,1)";

  pstmt=conn.prepareStatement(query);
	    pstmt.setString(1,circlecode);
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
		
		//System.out.println("Entered into Condition");
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   //System.out.println("Entered into while");
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><a href="PhysicalProgressdivisionReport.jsp?circle=<%=circlecode%>&division=<%=rs.getInt(5)%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td>
			  
			  <td class=label><font face=verdana size=2><%=no_work%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(2)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(4)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)/100%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}	  
sln=1;

 
//if (!request.getParameter("circle").equals("0") && !request.getParameter("division").equals("0") && request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && request.getParameter("cmbMonth").equals("0"))
	if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(TENDER_AMOUNT) as TENDER_AMOUNT,sum(EXPENDITURE) as EXPENDITURE,sum(PERCENT_COMPLETED) as PERCENT_COMPLETED,substr(wa.office_code,4,1) from rws_division_office_tbl co,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt,RWS_WORK_ADMN_TBL wa where  ta.work_id = we.work_id and we.work_id = mt.work_id and mt.work_id = wa.work_id and wa.work_id = ta.work_id and co.circle_office_code = substr(wa.office_code,2,2) and co.division_office_code = substr(wa.office_code,4,1) and substr(wa.office_code,2,2)=? and year= ? and TYPE_OF_ASSET = ? and substr(wa.office_code,4,1)=? group by division_office_name, substr(wa.office_code,4,1)";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
	    pstmt.setInt(4,divisioncode);

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
 		   <tr>     
			  <td class=label><font face=verdana size=2><%=sln%></td>
			  <td class=label><font face=verdana size=2><%=rs.getString(1)%></td>
			  
			  <td class=label><font face=verdana size=2><%=no_work%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(2)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(4)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)/100%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;




if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(TENDER_AMOUNT) as TENDER_AMOUNT,sum(EXPENDITURE) as EXPENDITURE,sum(PERCENT_COMPLETED) as PERCENT_COMPLETED from rws_division_office_tbl co,RWS_TENDER_APPL_TBL ta,RWS_WORK_EXPENDITURE_TBL we,rws_milestone_target_ach_tbl mt,RWS_WORK_ADMN_TBL wa where ta.work_id = we.work_id and we.work_id = mt.work_id and mt.work_id = wa.work_id and wa.work_id = ta.work_id and co.circle_office_code = substr(wa.office_code,2,2) and co.division_office_code = substr(wa.office_code,4,1) and substr(wa.office_code,2,2)=? and substr(wa.office_code,4,1)=? and year= ? and TYPE_OF_ASSET = ? and month=? group by division_office_name";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   
	    pstmt.setString(3,year);
	    pstmt.setString(4,AssetType);
		pstmt.setString(5,month);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
 		   <tr>     
			  <td class=label><font face=verdana size=2><%=sln%></td>
			  <td class=label><font face=verdana size=2><%=rs.getString(1)%></td>
			  
			  <td class=label><font face=verdana size=2><%=no_work%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(2)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(4)%></td>
			  <td class=label><font face=verdana size=2><%=rs.getFloat(3)/100%></td>
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;




if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && !month.equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select circle_office_name,NO_NEW_WORKS_SANC_UPTO_MON,NO_AUG_WORKS_SANC_UPTO_MON,WORK_TENDER_COST_UPTO_MON ,TOT_EXP_INLAKHS_UPTO_MON ,NO_NEW_WORKS_INPROG_UPTO_MON ,NO_AUG_WORKS_INPROG_UPTO_MON,PER_PHY_PROGRESS ,PER_OF_OVERALL_EXP,substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? and month=? ";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	   
	   
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
		pstmt.setString(4,month);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><a href="PhysicalProgressdivisionReport.jsp?circle=<%=circlecode%>&division=<%=rs.getInt(10)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td> 
			  
			  <td class=label><%=rs.getInt(2)%></td>
			  <td class=label><%=rs.getInt(3)%></td>
			  <td class=label><%=rs.getFloat(4)%></td>
			  <td class=label><%=rs.getFloat(5)%></td>
			  <td class=label><%=rs.getInt(6)%></td>
			  <td class=label><%=rs.getInt(7)%></td>
			  <td class=label><%=rs.getFloat(8)%></td>
			  <td class=label><%=rs.getFloat(9)%></td>
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