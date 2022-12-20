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
	   String str="";
	   int pctar=0;
	   int nsstar=0;
	   int pccov=0;
	   int nsscov=0;
	   int total=0;
	   int durtar=0;
	   int durach=0;
	   int uptotar=0;
	   int uptoach=0;
	    System.out.println(circlecode);
		int sln=1;
	   
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
<td colspan=20 align=center class=label bgcolor=#A899FB>Monthly Physical Targets Achievements Report</b></center></td>
</tr>
<tr>
<td class=label rowspan=2>S.No</b></td>
<%
 if(circlecode.equals("00"))
 {
%>

<td class=label rowspan=2>District </b></td> 
<%
 }
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label rowspan=2>District </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label rowspan=2>Division </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && month.equals("0"))
{
%>
<td class=label rowspan=2>SubDivision </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && !subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label rowspan=2>SubDivision </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode!=0 && subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label rowspan=2>Division </b></td> 
<%
}
if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && !month.equals("0"))
{
%>
<td class=label rowspan=2>District </b></td> 
<%
}
%>
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
System.out.println(request.getParameter("cmbMonth"));
try
{

	if(circlecode.equals("00"))
	{
	System.out.println("circle code"+circlecode);
	query="select circle_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON  ,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON,substr(pp.office_code,2,2),substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and year= '"+year+"' and asset_type = '"+AssetType+"' and month='"+month+"' group by circle_office_name, substr(pp.office_code,2,2),substr(pp.office_code,4,1),NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ";
	
	pstmt=conn.prepareStatement(query);
	  //pstmt.setString(1,year);
	   // pstmt.setString(2,AssetType); 
	    
		
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
			   <td class=label><a href="MonthlyPhysicalTADivisionReport.jsp?circle=<%=rs.getString(14)%>&division=<%=rs.getInt(15)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs.getString(1)%></a></td>
			 
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

	if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && month.equals("0"))
	{
	System.out.println("circle code1"+circlecode);
	query="select circle_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,substr(pp.office_code,2,2),substr(pp.office_code,4,1),month from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and year= '"+year+"' and asset_type = '"+AssetType+"' group by circle_office_name, substr(pp.office_code,2,2),substr(pp.office_code,4,1),month";
	pstmt=conn.prepareStatement(query);
	   //pstmt.setString(1,year);
	    //pstmt.setString(2,AssetType);
		 //pstmt.setString(3,month); 
	    
		
	   rs=pstmt.executeQuery();
	  
	   while(rs.next())
	   {
		   System.out.println("circle code1"+circlecode);
		   if(request.getParameter("cmbMonth").equals(rs.getString(8)))
		{
			System.out.println(request.getParameter("cmbMonth"));
		   pctar=rs.getInt(2)+rs.getInt(3);
		   nsstar=rs.getInt(4)+rs.getInt(5);
		   total=pctar+nsstar;
		   String query1="select circle_office_name,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ,substr(pp.office_code,2,2),substr(pp.office_code,4,1) from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code=substr(pp.office_code,2,2) and year= ? and asset_type = ? and month=?";
		   pstmt1=conn1.prepareStatement(query1);
	   pstmt1.setString(1,year);
	    pstmt1.setString(2,AssetType);
		pstmt1.setString(3,month);
		 //pstmt1.setString(3,month);
		 rs1=pstmt1.executeQuery();
		 while(rs1.next())
	     {
			 System.out.println(request.getParameter("cmbMonth"));
			durtar=rs1.getInt(3)+rs1.getInt(5);
			durach=rs1.getInt(6)+rs1.getInt(8);
			uptotar=rs1.getInt(2)+rs1.getInt(4);
			uptoach=rs1.getInt(7)+rs1.getInt(9);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><a href="MonthlyPhysicalTADivisionReport.jsp?circle=<%=rs1.getString(10)%>&division=<%=rs1.getInt(11)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>&cmbMonth=<%=month%>" ><%=rs1.getString(1)%></a></td>
			 
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


if (!request.getParameter("circle").equals("00") && request.getParameter("division").equals("0") && request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("cmbMonth").equals("0"))
	if (!circlecode.equals("00") && !AssetType.equals("") && !year.equals("") && divisioncode==0 && subdivisioncode.equals("0") && !month.equals("0"))
	{
		System.out.println("circle code"+circlecode);
	query="select circle_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,substr(pp.office_code,4,1),month from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? and month=? group by circle_office_name,substr(pp.office_code,4,1),month";
	pstmt=conn.prepareStatement(query);
		pstmt.setString(1,circlecode);
	   
	   
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);
		pstmt.setString(4,month);
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
		   String query1="select circle_office_name,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ,substr(pp.office_code,4,1),month from rws_circle_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and substr(pp.office_code,2,2)=? and year= ? and asset_type = ? and month=?";
		   pstmt1=conn1.prepareStatement(query1);
		    pstmt1.setString(1,circlecode);
	   pstmt1.setString(2,year);
	    pstmt1.setString(3,AssetType);
		pstmt1.setString(4,month);
		 //pstmt1.setString(3,month);
		 rs1=pstmt1.executeQuery();
		 while(rs1.next())
	     {
			 System.out.println(request.getParameter("cmbMonth"));
			durtar=rs1.getInt(3)+rs1.getInt(5);
			durach=rs1.getInt(6)+rs1.getInt(8);
			uptotar=rs1.getInt(2)+rs1.getInt(4);
			uptoach=rs1.getInt(7)+rs1.getInt(9);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><%=rs1.getString(1)%></a></td>
			 
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

if (!request.getParameter("circle").equals("0") && !request.getParameter("division").equals("0") && request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("cmbMonth").equals("0"))
	{
		System.out.println("circle code"+circlecode);
	query="select division_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,month from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and year= ? and asset_type = ? and month=? group by division_office_name,month";
	pstmt=conn.prepareStatement(query);
		pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   
	    pstmt.setString(3,year);
	    pstmt.setString(4,AssetType);
		pstmt.setString(5,month);
		 //pstmt.setString(3,month); 
	    
		
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   if(request.getParameter("cmbMonth").equals(rs.getString(6)))
		{
			System.out.println(request.getParameter("cmbMonth"));
		   pctar=rs.getInt(2)+rs.getInt(3);
		   nsstar=rs.getInt(4)+rs.getInt(5);
		   total=pctar+nsstar;
		   String query1="select division_office_name,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON from rws_division_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and year= ? and asset_type = ? and month=?";
		   pstmt1=conn1.prepareStatement(query1);
		    pstmt1.setString(1,circlecode);
			pstmt1.setInt(2,divisioncode);
	   pstmt1.setString(3,year);
	    pstmt1.setString(4,AssetType);
		pstmt1.setString(5,month);
		 //pstmt1.setString(3,month);
		 rs1=pstmt1.executeQuery();
		 while(rs1.next())
	     {
			 System.out.println(request.getParameter("cmbMonth"));
			durtar=rs1.getInt(3)+rs1.getInt(5);
			durach=rs1.getInt(6)+rs1.getInt(8);
			uptotar=rs1.getInt(2)+rs1.getInt(4);
			uptoach=rs1.getInt(7)+rs1.getInt(9);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><%=rs1.getString(1)%></a></td>
			 
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


if (!request.getParameter("circle").equals("0") && !request.getParameter("division").equals("0") && !request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("cmbMonth").equals("0"))
	{
		System.out.println("circle code"+circlecode);
	query="select subdivision_office_name,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON  ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON ,month from rws_subdivision_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and co.subdivision_office_code = substr(pp.office_code,5,2) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and substr(pp.office_code,5,2)=? and year= ? and asset_type = ? and month=? group by subdivision_office_name,month";
	pstmt=conn.prepareStatement(query);
		pstmt.setString(1,circlecode);
	   pstmt.setInt(2,divisioncode);
	   pstmt.setString(3,subdivisioncode);
	    pstmt.setString(4,year);
	    pstmt.setString(5,AssetType);
		 pstmt.setString(6,month);
		 //pstmt.setString(3,month); 
	    
		
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   if(request.getParameter("cmbMonth").equals(rs.getString(6)))
		{
			System.out.println(request.getParameter("cmbMonth"));
		   pctar=rs.getInt(2)+rs.getInt(3);
		   nsstar=rs.getInt(4)+rs.getInt(5);
		   total=pctar+nsstar;
		   String query1="select subdivision_office_name,NO_OF_PC_HABS_TAR_UPTO_MON  ,NO_OF_PC_HABS_TAR_DUR_MON  ,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON from rws_subdivision_office_tbl co,rws_physical_progress_tbl pp where co.circle_office_code = substr(pp.office_code,2,2) and co.division_office_code = substr(pp.office_code,4,1) and co.subdivision_office_code = substr(pp.office_code,5,2) and substr(pp.office_code,2,2)=? and substr(pp.office_code,4,1)=? and substr(pp.office_code,5,2)=? and year= ? and asset_type = ? and month=?";
		   pstmt1=conn1.prepareStatement(query1);
		    pstmt1.setString(1,circlecode);
			pstmt1.setInt(2,divisioncode);
			pstmt1.setString(3,subdivisioncode);
	   pstmt1.setString(4,year);
	    pstmt1.setString(5,AssetType);
		pstmt1.setString(6,month);
		 //pstmt1.setString(3,month);
		 rs1=pstmt1.executeQuery();
		 while(rs1.next())
	     {
			 System.out.println(request.getParameter("cmbMonth"));
			durtar=rs1.getInt(3)+rs1.getInt(5);
			durach=rs1.getInt(6)+rs1.getInt(8);
			uptotar=rs1.getInt(2)+rs1.getInt(4);
			uptoach=rs1.getInt(7)+rs1.getInt(9);
		   %>
			
 		   <tr>     
			  <td class=label><%=sln%></td>
			   <td class=label><%=rs1.getString(1)%></a></td>
			 
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
</center>
</body>
</html>

























