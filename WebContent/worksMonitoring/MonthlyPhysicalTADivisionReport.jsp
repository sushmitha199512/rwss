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
<p align=right>
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
	   int habs=0;
	   int sln=1;
	   int pctar=0;
	   int nsstar=0;
	   int pccov=0;
	   int nsscov=0;
	   int total=0;
	   int durtar=0;
	   int durach=0;
	   int uptotar=0;
	   int uptoach=0;
	   circlecode=request.getParameter("circle");
	   System.out.println("circlecode"+circlecode);
	   divisioncode=Integer.parseInt(request.getParameter("division"));

	   AssetType=request.getParameter("AssetType");
	month=request.getParameter("cmbMonth");	
	   year=request.getParameter("cmbYear");
		String officeCode= "1"+circlecode+divisioncode+subdivisioncode;
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
<td colspan=20 align=center class=label bgcolor=#A899FB>Monthly Physical Targets Achievements Report</b></center></td>
</tr>
<tr>
<td class=label rowspan=2>S.No</b></td>
<td class=label rowspan=2>Name of the Division</b></td>
<td class=label colspan=3>Total Targets for Year</b></td>
<td class=label colspan=2>During the Month</b></td>
<td class=label colspan=2>Cummulative upto the Month</b></td>
 <td class=label rowspan=2>Remarks</b></td>
 </tr>
 <tr>
<td class=label>PC</b></td>
<td class=label>NSS</b></td>
<td class=label>Total</b></td>
<td class=label>Target</b></td>
<td class=label>Achievement</b></td>
<td class=label>Target</b></td>
<td class=label>Achievement</b></td>
</tr>
<%
try
{

if (!request.getParameter("circle").equals("00"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON  ,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON,substr(pp.office_code,5,2) from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? group by division_office_name, substr(pp.office_code,5,2),NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,circlecode);
	    pstmt.setInt(2,divisioncode);
	    

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		    pctar=rs.getInt(2)+rs.getInt(3);
		   nsstar=rs.getInt(4)+rs.getInt(5);
		   total=pctar+nsstar;
		   durtar=rs.getInt(7)+rs.getInt(9);
			durach=rs.getInt(10)+rs.getInt(12);
			uptotar=rs.getInt(6)+rs.getInt(8);
			uptoach=rs.getInt(11)+rs.getInt(13);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><a href="MonthlyPhysicalTASubdivisionReport.jsp?circle=<%=circlecode%>&division=<%=divisioncode%>&subdivision=<%=rs.getString(14)%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td>
			 
			  <td class=label><%=pctar%></td>
			  <td class=label><%=nsstar%></td>
			  <td class=label><%=total%></td>
			  <td class=label><%=durtar%></td>
				  <td class=label><%=durach%></td>
				  <td class=label><%=uptotar%></td>
				  <td class=label><%=uptoach%></td>
				  <td class=label>&nbsp;</td>
			  
			  </tr>
			  
  <%
	  sln++;
		 }
	}		  
sln=1;

if (!request.getParameter("circle").equals("00") && !request.getParameter("division").equals("0") && !request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("cmbMonth").equals("0"))
	{
	System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,substr(pp.office_code,5,2),month from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and year= ? and asset_type = ? and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? group by division_office_name, substr(pp.office_code,5,2),month";
	pstmt=conn.prepareStatement(query);
	   pstmt.setString(1,year);
	    pstmt.setString(2,AssetType);
		pstmt.setString(3,circlecode);
	    pstmt.setInt(4,divisioncode);
		 //pstmt.setString(3,month); 
	    
		
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   if(request.getParameter("cmbMonth").equals(rs.getString(7)))
		{
			System.out.println(request.getParameter("cmbMonth"));
		   pctar=rs.getInt(2)+rs.getInt(3);
		   nsstar=rs.getInt(4)+rs.getInt(5);
		   total=pctar+nsstar;
		   String query1="select division_office_name,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ,substr(pp.office_code,5,2) from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and year= ? and asset_type = ? and month = ? and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=?";
		   pstmt1=conn1.prepareStatement(query1);
	   pstmt1.setString(1,year);
	    pstmt1.setString(2,AssetType);
		pstmt1.setString(3,month);
		pstmt1.setString(4,circlecode);
		pstmt1.setInt(5,divisioncode);
		 //pstmt1.setString(3,month);
		 rs1=pstmt1.executeQuery();
		 while(rs1.next())
	     {
			durtar=rs1.getInt(3)+rs1.getInt(5);
			durach=rs1.getInt(6)+rs1.getInt(8);
			uptotar=rs1.getInt(2)+rs1.getInt(4);
			uptoach=rs1.getInt(7)+rs1.getInt(9);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><a href="MonthlyPhysicalTASubdivisionReport.jsp?circle=<%=circlecode%>&division=<%=divisioncode%>&subdivision=<%=rs1.getString(10)%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs1.getString(1)%></a></td>
			 
			  <td class=label><%=pctar%></td>
			  <td class=label><%=nsstar%></td>
			  <td class=label><%=total%></td>
			  <td class=label><%=durtar%></td>
				  <td class=label><%=durach%></td>
				  <td class=label><%=uptotar%></td>
				  <td class=label><%=uptoach%></td>
				  <td class=label>&nbsp;</td>

			  
			  </tr>
			  
  <%
	  sln++;
		 }
	   }
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
		conn1.close();
	}
%>
</table>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>

</body>
</html>
