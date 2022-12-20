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
<!-- <p align=right> -->
<%
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
	   String query="";
	   int sln=1;
	   int habs=0;
	   int total=0;
		int balance=0;
		int workstaken=0;
		//------------------------
		int works_spover=0;
		int workstaken_new=0;
		int workstaken_total=0;
		float estimate_spover=0;
		float estimate_new=0;
		float estimate_total=0;
		int workflow_techsan=0;
		float workflow_tender=0;
		int workflow_agreement=0;
		int workflow_grd=0;
		int workflow_comp=0;
		int tar_nss=0;
		int tar_pc=0;
		int cov_nss=0;
		int cov_pc=0;
	   String divisionofficename="";
		String subdivofficename="";
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
<td colspan=20 align=center class=label bgcolor=#A899FB>Work Flow Status SubDivision Report</b></center></td>
</tr>
<tr>
<td class=label rowspan=2>S.No</b></td>
<td class=label rowspan=2>SubDivision</b></td>

<td class=label colspan=3>Works Taken Up</b></td>
<td class=label colspan=3>Estimate Cost</b></td>
<td class=label colspan=5>Work Flow Status</b></td>
<td class=label colspan=2>Habs Proposed</b></td>
<td class=label colspan=2>Habs Covered</b></td>
</tr>
<tr>
<td class=label>Spill Over</b></td>
<td class=label>New</b></td>
<td class=label>Total</b></td>
<td class=label>Spill Over</b></td>
<td class=label>New</b></td>
<td class=label>Total</b></td>
<td class=label>Tech.Sanc</b></td>
<td class=label>Tendered</b></td>
<td class=label>Agreement</b></td>
<td class=label>Grounded</b></td>
<td class=label>Completed</b></td>
<td class=label>NSS</b></td>
<td class=label>PC</b></td>
<td class=label>NSS</b></td>
<td class=label>PC</b></td>
</tr>
<%
try
{
	if (!request.getParameter("circle").equals("00") && !request.getParameter("division").equals("0") && !request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && request.getParameter("cmbMonth").equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select subdivision_office_name,sum(COST_OF_SPOVER_WORKS_DUR_MON) as COST_OF_SPOVER_WORKS_DUR_MON  ,sum(COST_OF_SPOVER_WORKS_UPTO_MON) as COST_OF_SPOVER_WORKS_UPTO_MON  ,sum(NO_NEW_WORKS_SANC_UPTO_MON) as NO_NEW_WORKS_SANC_UPTO_MON  ,sum(NO_NEW_WORKS_SANC_DUR_MON) as NO_NEW_WORKS_SANC_DUR_MON ,sum(TOT_OF_WORKS_TECHSANC_DUR_MON) as TOT_OF_WORKS_TECHSANC_DUR_MON ,sum(TOT_OF_WORKS_TECHSANC_UPTO_MON) as TOT_OF_WORKS_TECHSANC_UPTO_MON,sum(WORK_TENDER_COST_DUR_MON) as WORK_TENDER_COST_DUR_MON ,sum(WORK_TENDER_COST_UPTO_MON) as WORK_TENDER_COST_UPTO_MON ,sum(TOT_NO_WORKS_GRD_DUR_MON) as TOT_NO_WORKS_GRD_DUR_MON ,sum(TOT_NO_WORKS_GRD_UPTO_MON) as TOT_NO_WORKS_GRD_UPTO_MON ,sum(TOT_NO_WORKS_COMP_DUR_MON) as TOT_NO_WORKS_COMP_DUR_MON,sum(TOT_NO_WORKS_COMP_UPTO_MON) as TOT_NO_WORKS_COMP_UPTO_MON,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,sum(NO_OF_PC_HABS_COV_DUR_MON) as NO_OF_PC_HABS_COV_DUR_MON,sum(NO_OF_PC_HABS_COV_UPTO_MON) as  NO_OF_PC_HABS_COV_UPTO_MON,sum(NO_OF_NSS_HABS_COV_DUR_MON) as NO_OF_NSS_HABS_COV_DUR_MON ,sum(NO_OF_NSS_HABS_COV_UPTO_MON) as NO_OF_NSS_HABS_COV_UPTO_MON from rws_subdivision_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and co.subdivision_office_code = substr(pp.office_code,5,2) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and substr(pp.office_code,5,2)=? group by subdivision_office_name, substr(pp.office_code,5,2)";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	    pstmt.setInt(2,divisioncode);
		pstmt.setString(3,subdivisioncode);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		    workstaken_new=rs.getInt(4)+rs.getInt(5);
		   workstaken_total=workstaken_new+works_spover;
		   estimate_spover=rs.getFloat(2)+rs.getFloat(3);
		   estimate_total=estimate_spover+estimate_new;
		   workflow_techsan=rs.getInt(6)+rs.getInt(7);
		   workflow_tender=rs.getFloat(8)+rs.getFloat(9);
		   workflow_grd=rs.getInt(10)+rs.getInt(11);
		   workflow_comp=rs.getInt(12)+rs.getInt(13);
		   tar_nss=rs.getInt(16)+rs.getInt(17);
		   tar_pc=rs.getInt(14)+rs.getInt(15);
		   cov_nss=rs.getInt(20)+rs.getInt(21);
		   cov_pc=rs.getInt(18)+rs.getInt(19);
		   %>
 		   <tr>     
			  <td class=label><%=sln%></td>
			  <td class=label><%=rs.getString(1)%></td>
			  <td class=label><%=works_spover%></td>
			  
			  <td class=label><%=workstaken_new%></td>
			  <td class=label><%=workstaken_total%></td>
			  <td class=label><%=estimate_spover%></td>
			  <td class=label><%=estimate_new%></td>
			  <td class=label><%=estimate_total%></td>
			  <td class=label><%=workflow_techsan%></td>
			  <td class=label><%=workflow_tender%></td>
			  <td class=label><%=workflow_agreement%></td>
			  <td class=label><%=workflow_grd%></td>
			  <td class=label><%=workflow_comp%></td>
			  <td class=label><%=tar_nss%></td>
			  <td class=label><%=tar_pc%></td>
			  <td class=label><%=cov_nss%></td>
			  <td class=label><%=cov_pc%></td>
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
