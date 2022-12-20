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
<center>
<span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>


</center>
<p align=right>
<%
System.out.println("aaaaaaaaaaaaaa");
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
	    System.out.println(circlecode);
	   System.out.println("aaaaaaaaaaaaa");
	   circlecode=request.getParameter("circle");
	   System.out.println(circlecode);
	   divisioncode=Integer.parseInt(request.getParameter("division"));
	   System.out.println(divisioncode);
	   subdivisioncode=request.getParameter("subdivision");
	   System.out.println(subdivisioncode);
	   AssetType=request.getParameter("AssetType");
	   System.out.println(AssetType);
	   month=request.getParameter("cmbMonth");
	   System.out.println(month);
	   year=request.getParameter("cmbYear");
	   System.out.println(year);
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
	 <%
	str="select CIRCLE_OFFICE_CODE ,CIRCLE_OFFICE_NAME from rws_circle_office_tbl where circle_office_code=? order by circle_office_code";
	pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,circlecode);
	    rs=pstmt.executeQuery();
		if (rs.next())
		{
			circleofficename = rs.getString(2);
		}
		rs.close();
	 %>
<table>
<%
 if (request.getParameter("cmbYear")!=null && !request.getParameter("cmbMonth").equals("0"))
 {
%>
<td class=label>MONTH:<%=monthName%></td>      
<%
  }
%>
<td class=label>YEAR:<%=year%></td>       
<td class=label>CIRCLE:<%=circleofficename%></td>  
<td class=label>ASSET NAME:<%=assetName%></td>       
</table>
<table border=1 cellspacing=1 cellpadding=1 width="100%" >
<tr>
<td colspan=20 align=center class=label>Work Progress Report</b></center></td>
</tr>
 
<tr>
<%
 if (request.getParameter("cmbYear")!=null && !request.getParameter("cmbMonth").equals("0"))
 {
 %>
 <td class=label rowspan=2>Entered By</b></td>  
 <td class=label rowspan=2>Entered Date</b></td>    

<%}
 
 if (!request.getParameter("circle").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("AssetType").equals("0") && request.getParameter("subdivision").equals("0"))
	   {
%>
  <td class=label rowspan=2>Division</b></td> 
  <%
	   }
 if (!request.getParameter("circle").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("subdivision").equals("0"))
 {
%>
 <td class=label rowspan=2>SubDivision</b></td> 
  <%
	   }
%>
<td class=label colspan=2>No.of Proposals </b></td>  

<td class=label colspan=2>Proposal Cost </b></td>  
<td class=label colspan=2>No.of Proposal Cleared </b></td>  
<td class=label colspan=2>Proposal Cost Cleared</b></td>  

<td class=label colspan=2>No.of New Works Sanctioned </b></td>  

<td class=label colspan=2>No.of Augmented Works Sanctioned</b></td>  

<td class=label colspan=2>Work Tender Cost</b></td>  

<td class=label colspan=2>Total Expenditure(Lacs)</b></td>     

<td class=label colspan=2>No.of New Works in Progress</b></td>  

<td class=label colspan=2>No.of Augmented Works in Progress</b></td>   

<td class=label>Percentage of Physical Progress</b></td>       
<td class=label>Percentage of Overall Expenditure</b></td>     
<td class=label colspan=2>Total Work Value Cleared</b></td>  
<td class=label colspan=2>No.of PC Habitations Covered  </b></td>
<td class=label colspan=2>No.of NSS Habitations Covered</b></td>
<td class=label colspan=2>No.of PC Habitations Tar</b></td>
<td class=label colspan=2>No.of NSS Habitations Tar</b></td>
<td class=label colspan=2>Cost of Spover Works</b></td>
<td class=label colspan=2>Cost of Ongoing Works</b></td>
<td class=label colspan=2>Total No.of Works Completed</b></td>
<td class=label colspan=2>Total No.of Works GRD</b></td>
<td class=label colspan=2>Total No.of Works Administration Sanctioned</b></td>
<td class=label colspan=2>Total No.of Works Technical Sanctioned</b></td>
<td class=label colspan=2>Total No.of Works Completed</b></td>
</tr>
<tr>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td> 
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td> 
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td> 
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>Upto Month</b></td>  
<td class=label>During the Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>
<td class=label>During the Month</b></td>  
<td class=label>Upto Month</b></td>









</tr>
<%
       

	   try
		{
	   

	   if (request.getParameter("cmbYear")!=null && request.getParameter("cmbMonth")!=null)
	   {
	   str="select MONTH,YEAR,OFFICE_CODE,ENTERED_BY,to_char(ENTERED_DATE,'dd/mm/yyyy') as entered_date,NO_PROPOSAL_UPTO_MON,NO_PROPOSAL_DUR_MON   PROPOSAL_COST_UPTO_MON,PROPOSAL_COST_DUR_MON,NO_PROPOSAL_CLR_UPTO_MON,NO_PROPOSAL_CLR_DUR_MON,    PROPOSAL_COST_CLR_UPTO_MON,PROPOSAL_COST_CLR_DUR_MON,NO_NEW_WORKS_SANC_UPTO_MON,NO_NEW_WORKS_SANC_DUR_MON,PROPOSAL_COST_CLR_UPTO_MON,PROPOSAL_COST_CLR_DUR_MON,NO_NEW_WORKS_SANC_UPTO_MON,       NO_NEW_WORKS_SANC_DUR_MON,NO_AUG_WORKS_SANC_UPTO_MON,NO_AUG_WORKS_SANC_DUR_MON,WORK_TENDER_COST_DUR_MON, WORK_TENDER_COST_UPTO_MON,TOT_EXP_INLAKHS_DUR_MON,TOT_EXP_INLAKHS_UPTO_MON,NO_NEW_WORKS_INPROG_DUR_MON,NO_NEW_WORKS_INPROG_UPTO_MON,NO_AUG_WORKS_INPROG_DUR_MON,NO_AUG_WORKS_INPROG_UPTO_MON,PER_PHY_PROGRESS ,PER_OF_OVERALL_EXP,TOTAL_WORK_VAL_CLEAR_DUR_MON,TOTAL_WORK_VAL_CLEAR_UPTO_MON,NO_OF_PC_HABS_COV_DUR_MON,NO_OF_PC_HABS_COV_UPTO_MON,NO_OF_NSS_HABS_COV_DUR_MON,NO_OF_NSS_HABS_COV_UPTO_MON  ,NO_OF_PC_HABS_TAR_UPTO_MON   ,NO_OF_PC_HABS_TAR_DUR_MON,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON,COST_OF_SPOVER_WORKS_DUR_MON,COST_OF_SPOVER_WORKS_UPTO_MON  ,COST_OF_ONGO_WORKS_UPTO_MON,COST_OF_ONGO_WORKS_DUR_MON ,TOT_NO_WORKS_COMP_DUR_MON,TOT_NO_WORKS_COMP_UPTO_MON,TOT_NO_WORKS_GRD_DUR_MON,TOT_NO_WORKS_GRD_UPTO_MON,TOT_NO_WORKS_ADMSAN_DUR_MON,TOT_OF_WORKS_ADMSANC_UPTO_MON,TOT_OF_WORKS_TECHSANC_DUR_MON,TOT_OF_WORKS_TECHSANC_UPTO_MON,TOT_OF_WORKS_COMP_DUR_MON,TOT_OF_WORKS_COMPC_UPTO_MON,ASSET_TYPE  from rws_physical_progress_tbl where office_code=? and month=? and year= ? ";
	   		
	   pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,officeCode);
	   pstmt.setString(2,month);
	   pstmt.setString(3,year);
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=label><%=rs.getString(4)%></td>

			<td class=label><%=rs.getString(5)%></td>    
		    <td class=label><%=rs.getInt(6)%></td>
  	
            <td class=label><%=rs.getInt(7)%></td>       			
            <td class=label><%=rs.getFloat(8)%></td>	
			
			<td class=label><%=rs.getFloat(9)%></td>       
			<td class=label><%=rs.getInt(10)%></td> 
            			
			<td class=label><%=rs.getInt(11)%></td>            
			<td class=label><%=rs.getFloat(12)%></td> 
            		
			<td class=label><%=rs.getFloat(13)%></td>            
			<td class=label><%=rs.getInt(14)%></td>
             			
			<td class=label><%=rs.getInt(15)%></td>
			<td class=label><%=rs.getInt(16)%></td>

			<td class=label><%=rs.getInt(17)%></td>
			<td class=label><%=rs.getFloat(18)%></td>
            
			<td class=label><%=rs.getFloat(19)%></td>
			<td class=label><%=rs.getFloat(20)%></td>
               

			<td class=label><%=rs.getFloat(21)%></td>
			<td class=label><%=rs.getInt(22)%></td>
			
			<td class=label><%=rs.getInt(23)%></td>
			<td class=label><%=rs.getInt(24)%></td>

			<td class=label><%=rs.getInt(25)%></td>
			<td class=label><%=rs.getFloat(26)%></td>
			
			<td class=label><%=rs.getFloat(27)%></td>
			<td class=label><%=rs.getFloat(28)%></td>

			<td class=label><%=rs.getFloat(29)%></td>
			<td class=label><%=rs.getInt(30)%></td>
			

			<td class=label><%=rs.getInt(31)%></td>
			<td class=label><%=rs.getInt(32)%></td>
		
			<td class=label><%=rs.getInt(33)%></td>
			<td class=label><%=rs.getInt(34)%></td>

			<td class=label><%=rs.getInt(35)%></td>
			<td class=label><%=rs.getInt(36)%></td>
			<td class=label><%=rs.getInt(37)%></td>
			<td class=label><%=rs.getFloat(38)%></td>
			<td class=label><%=rs.getFloat(39)%></td>
			<td class=label><%=rs.getFloat(40)%></td>
	        <td class=label><%=rs.getFloat(41)%></td>
             <td class=label><%=rs.getInt(42)%></td>
              <td class=label><%=rs.getInt(43)%></td>
			  <td class=label><%=rs.getInt(44)%></td>
              <td class=label><%=rs.getInt(45)%></td>
			  <td class=label><%=rs.getInt(46)%></td>
			  <td class=label><%=rs.getInt(47)%></td>
			  <td class=label><%=rs.getInt(48)%></td>
			  <td class=label><%=rs.getInt(49)%></td>
			  <td class=label><%=rs.getInt(50)%></td>
			  <td class=label><%=rs.getInt(51)%></td>

               </tr>

		   <%
	   }
	   }

	   if (request.getParameter("cmbYear")!=null && request.getParameter("cmbMonth").equals("0")) 
	   {
		  
		str="select month_name, sum(NO_PROPOSAL_UPTO_MON) as NO_PROPOSAL_UPTO_MON,sum(NO_PROPOSAL_DUR_MON) as  NO_PROPOSAL_DUR_MON, sum(PROPOSAL_COST_UPTO_MON) as PROPOSAL_COST_UPTO_MON,sum(PROPOSAL_COST_DUR_MON) as PROPOSAL_COST_DUR_MON,sum(NO_PROPOSAL_CLR_UPTO_MON) as NO_PROPOSAL_CLR_UPTO_MON,sum(NO_PROPOSAL_CLR_DUR_MON) as NO_PROPOSAL_CLR_DUR_MON,    sum(PROPOSAL_COST_CLR_UPTO_MON) as PROPOSAL_COST_CLR_UPTO_MON,sum(PROPOSAL_COST_CLR_DUR_MON) as PROPOSAL_COST_CLR_DUR_MON,sum(NO_NEW_WORKS_SANC_UPTO_MON) as NO_NEW_WORKS_SANC_UPTO_MON,sum(NO_NEW_WORKS_SANC_DUR_MON) as NO_NEW_WORKS_SANC_DUR_MON,sum(NO_AUG_WORKS_SANC_UPTO_MON) as NO_AUG_WORKS_SANC_UPTO_MON,sum(NO_AUG_WORKS_SANC_DUR_MON) as NO_AUG_WORKS_SANC_DUR_MON,sum(WORK_TENDER_COST_DUR_MON) as WORK_TENDER_COST_DUR_MON, sum(WORK_TENDER_COST_UPTO_MON) as WORK_TENDER_COST_UPTO_MON,sum(TOT_EXP_INLAKHS_DUR_MON) as TOT_EXP_INLAKHS_DUR_MON,sum(TOT_EXP_INLAKHS_UPTO_MON) as TOT_EXP_INLAKHS_UPTO_MON,sum(NO_NEW_WORKS_INPROG_DUR_MON) as NO_NEW_WORKS_INPROG_DUR_MON,sum(NO_NEW_WORKS_INPROG_UPTO_MON) as NO_NEW_WORKS_INPROG_UPTO_MON,sum(NO_AUG_WORKS_INPROG_DUR_MON) as NO_AUG_WORKS_INPROG_DUR_MON,sum(NO_AUG_WORKS_INPROG_UPTO_MON) as NO_AUG_WORKS_INPROG_UPTO_MON,sum(PER_PHY_PROGRESS) as PER_PHY_PROGRESS ,sum(PER_OF_OVERALL_EXP) as PER_OF_OVERALL_EXP,sum(TOTAL_WORK_VAL_CLEAR_DUR_MON) as TOTAL_WORK_VAL_CLEAR_DUR_MON ,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON) as TOTAL_WORK_VAL_CLEAR_UPTO_MON,sum(NO_OF_PC_HABS_COV_DUR_MON) as NO_OF_PC_HABS_COV_DUR_MON,sum(NO_OF_PC_HABS_COV_UPTO_MON) as NO_OF_PC_HABS_COV_UPTO_MON,sum(NO_OF_NSS_HABS_COV_DUR_MON) as NO_OF_NSS_HABS_COV_DUR_MON,sum(NO_OF_NSS_HABS_COV_UPTO_MON) as NO_OF_NSS_HABS_COV_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as  NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON,sum(COST_OF_SPOVER_WORKS_DUR_MON) as COST_OF_SPOVER_WORKS_DUR_MON,sum(COST_OF_SPOVER_WORKS_UPTO_MON) as  COST_OF_SPOVER_WORKS_UPTO_MON ,sum(COST_OF_ONGO_WORKS_UPTO_MON) as COST_OF_ONGO_WORKS_UPTO_MON,sum(COST_OF_ONGO_WORKS_DUR_MON) as COST_OF_ONGO_WORKS_DUR_MON ,sum(TOT_NO_WORKS_COMP_DUR_MON) as TOT_NO_WORKS_COMP_DUR_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON) as TOT_NO_WORKS_COMP_UPTO_MON,sum(TOT_NO_WORKS_GRD_DUR_MON) as TOT_NO_WORKS_GRD_DUR_MON,sum(TOT_NO_WORKS_GRD_UPTO_MON) as TOT_NO_WORKS_GRD_UPTO_MON,sum(TOT_NO_WORKS_ADMSAN_DUR_MON) as TOT_NO_WORKS_ADMSAN_DUR_MON,sum(TOT_OF_WORKS_ADMSANC_UPTO_MON) as TOT_OF_WORKS_ADMSANC_UPTO_MON,sum(TOT_OF_WORKS_TECHSANC_DUR_MON) as TOT_OF_WORKS_TECHSANC_DUR_MON,sum(TOT_OF_WORKS_TECHSANC_UPTO_MON) as TOT_OF_WORKS_TECHSANC_UPTO_MON,sum(TOT_OF_WORKS_COMP_DUR_MON) as TOT_OF_WORKS_COMP_DUR_MON,sum(TOT_OF_WORKS_COMPC_UPTO_MON) as TOT_OF_WORKS_COMPC_UPTO_MON  from rws_physical_progress_tbl, rws_month_mast_tbl where rws_month_mast_tbl.month_code = rws_physical_progress_tbl.month and office_code=? and year= ? group by month_name";
		pstmt=conn.prepareStatement(str);
	   pstmt.setString(1,officeCode);
	   
	   pstmt.setString(2,year);
	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
		   <tr>     
			  <td class=label><a href=""><%=rs.getString(1)%></a></td> 

			 
		    <td class=label><%=rs.getInt(2)%></td>
  	
            <td class=label><%=rs.getInt(3)%></td>       			
            <td class=label><%=rs.getFloat(4)%></td>	
			
			<td class=label><%=rs.getFloat(5)%></td>       
			<td class=label><%=rs.getInt(6)%></td> 
            			
			<td class=label><%=rs.getInt(7)%></td>            
			<td class=label><%=rs.getFloat(8)%></td> 
            		
			<td class=label><%=rs.getFloat(9)%></td>            
			<td class=label><%=rs.getInt(10)%></td>
             			
			<td class=label><%=rs.getInt(11)%></td>
			<td class=label><%=rs.getInt(12)%></td>

			<td class=label><%=rs.getInt(13)%></td>
			<td class=label><%=rs.getFloat(14)%></td>
            
			<td class=label><%=rs.getFloat(15)%></td>
			<td class=label><%=rs.getFloat(16)%></td>
               

			<td class=label><%=rs.getFloat(17)%></td>
			<td class=label><%=rs.getInt(18)%></td>
			
			<td class=label><%=rs.getInt(19)%></td>
			<td class=label><%=rs.getInt(20)%></td>

			<td class=label><%=rs.getInt(21)%></td>
			<td class=label><%=rs.getFloat(22)%></td>
			
			<td class=label><%=rs.getFloat(23)%></td>
			<td class=label><%=rs.getFloat(24)%></td>

			<td class=label><%=rs.getFloat(25)%></td>
			<td class=label><%=rs.getInt(26)%></td>
			

			<td class=label><%=rs.getInt(27)%></td>
			<td class=label><%=rs.getInt(28)%></td>
		
			<td class=label><%=rs.getInt(29)%></td>
			<td class=label><%=rs.getInt(30)%></td>

			<td class=label><%=rs.getInt(31)%></td>
			<td class=label><%=rs.getInt(32)%></td>
			<td class=label><%=rs.getInt(33)%></td>
			<td class=label><%=rs.getFloat(34)%></td>
			<td class=label><%=rs.getFloat(35)%></td>
			<td class=label><%=rs.getFloat(36)%></td>
	        <td class=label><%=rs.getFloat(37)%></td>
             <td class=label><%=rs.getInt(38)%></td>
              <td class=label><%=rs.getInt(39)%></td>
			  <td class=label><%=rs.getInt(40)%></td>
              <td class=label><%=rs.getInt(41)%></td>
			  <td class=label><%=rs.getInt(42)%></td>
			  <td class=label><%=rs.getInt(43)%></td>
			  <td class=label><%=rs.getInt(44)%></td>
			  <td class=label><%=rs.getInt(45)%></td>
			  <td class=label><%=rs.getInt(46)%></td>
			  <td class=label><%=rs.getInt(47)%></td>

               </tr>

		   <%
	   }

	   }   

// For Circle, Asset Type and Year

	    if (!request.getParameter("circle").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("AssetType").equals("0") && request.getParameter("subdivision").equals("0"))
	   {

		str="select division_office_name, sum(NO_PROPOSAL_UPTO_MON) as NO_PROPOSAL_UPTO_MON,sum(NO_PROPOSAL_DUR_MON) as  NO_PROPOSAL_DUR_MON, sum(PROPOSAL_COST_UPTO_MON) as PROPOSAL_COST_UPTO_MON,sum(PROPOSAL_COST_DUR_MON) as PROPOSAL_COST_DUR_MON,sum(NO_PROPOSAL_CLR_UPTO_MON) as NO_PROPOSAL_CLR_UPTO_MON,sum(NO_PROPOSAL_CLR_DUR_MON) as NO_PROPOSAL_CLR_DUR_MON,    sum(PROPOSAL_COST_CLR_UPTO_MON) as PROPOSAL_COST_CLR_UPTO_MON,sum(PROPOSAL_COST_CLR_DUR_MON) as PROPOSAL_COST_CLR_DUR_MON,sum(NO_NEW_WORKS_SANC_UPTO_MON) as NO_NEW_WORKS_SANC_UPTO_MON,sum(NO_NEW_WORKS_SANC_DUR_MON) as NO_NEW_WORKS_SANC_DUR_MON,sum(NO_AUG_WORKS_SANC_UPTO_MON) as NO_AUG_WORKS_SANC_UPTO_MON,sum(NO_AUG_WORKS_SANC_DUR_MON) as NO_AUG_WORKS_SANC_DUR_MON,sum(WORK_TENDER_COST_DUR_MON) as WORK_TENDER_COST_DUR_MON, sum(WORK_TENDER_COST_UPTO_MON) as WORK_TENDER_COST_UPTO_MON,sum(TOT_EXP_INLAKHS_DUR_MON) as TOT_EXP_INLAKHS_DUR_MON,sum(TOT_EXP_INLAKHS_UPTO_MON) as TOT_EXP_INLAKHS_UPTO_MON,sum(NO_NEW_WORKS_INPROG_DUR_MON) as NO_NEW_WORKS_INPROG_DUR_MON,sum(NO_NEW_WORKS_INPROG_UPTO_MON) as NO_NEW_WORKS_INPROG_UPTO_MON,sum(NO_AUG_WORKS_INPROG_DUR_MON) as NO_AUG_WORKS_INPROG_DUR_MON,sum(NO_AUG_WORKS_INPROG_UPTO_MON) as NO_AUG_WORKS_INPROG_UPTO_MON,sum(PER_PHY_PROGRESS) as PER_PHY_PROGRESS ,sum(PER_OF_OVERALL_EXP) as PER_OF_OVERALL_EXP,sum(TOTAL_WORK_VAL_CLEAR_DUR_MON) as TOTAL_WORK_VAL_CLEAR_DUR_MON ,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON) as TOTAL_WORK_VAL_CLEAR_UPTO_MON,sum(NO_OF_PC_HABS_COV_DUR_MON) as NO_OF_PC_HABS_COV_DUR_MON,sum(NO_OF_PC_HABS_COV_UPTO_MON) as NO_OF_PC_HABS_COV_UPTO_MON,sum(NO_OF_NSS_HABS_COV_DUR_MON) as NO_OF_NSS_HABS_COV_DUR_MON,sum(NO_OF_NSS_HABS_COV_UPTO_MON) as NO_OF_NSS_HABS_COV_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as  NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON,sum(COST_OF_SPOVER_WORKS_DUR_MON) as COST_OF_SPOVER_WORKS_DUR_MON,sum(COST_OF_SPOVER_WORKS_UPTO_MON) as  COST_OF_SPOVER_WORKS_UPTO_MON ,sum(COST_OF_ONGO_WORKS_UPTO_MON) as COST_OF_ONGO_WORKS_UPTO_MON,sum(COST_OF_ONGO_WORKS_DUR_MON) as COST_OF_ONGO_WORKS_DUR_MON ,sum(TOT_NO_WORKS_COMP_DUR_MON) as TOT_NO_WORKS_COMP_DUR_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON) as TOT_NO_WORKS_COMP_UPTO_MON,sum(TOT_NO_WORKS_GRD_DUR_MON) as TOT_NO_WORKS_GRD_DUR_MON,sum(TOT_NO_WORKS_GRD_UPTO_MON) as TOT_NO_WORKS_GRD_UPTO_MON,sum(TOT_NO_WORKS_ADMSAN_DUR_MON) as TOT_NO_WORKS_ADMSAN_DUR_MON,sum(TOT_OF_WORKS_ADMSANC_UPTO_MON) as TOT_OF_WORKS_ADMSANC_UPTO_MON,sum(TOT_OF_WORKS_TECHSANC_DUR_MON) as TOT_OF_WORKS_TECHSANC_DUR_MON,sum(TOT_OF_WORKS_TECHSANC_UPTO_MON) as TOT_OF_WORKS_TECHSANC_UPTO_MON,sum(TOT_OF_WORKS_COMP_DUR_MON) as TOT_OF_WORKS_COMP_DUR_MON,sum(TOT_OF_WORKS_COMPC_UPTO_MON) as TOT_OF_WORKS_COMPC_UPTO_MON, substr(rws_physical_progress_tbl.office_code,4,1)   from rws_physical_progress_tbl, rws_division_office_tbl where rws_division_office_tbl.circle_office_code = substr(rws_physical_progress_tbl.office_code,2,2) and rws_division_office_tbl.division_office_code = substr(rws_physical_progress_tbl.office_code,4,1) and substr(office_code,2,2)=? and year= ? and asset_type = ? group by division_office_name, substr(rws_physical_progress_tbl.office_code,4,1)";

		pstmt=conn.prepareStatement(str);
	    pstmt.setString(1,circlecode);
	    pstmt.setString(2,year);
	    pstmt.setString(3,AssetType);

	   rs=pstmt.executeQuery();
	   while(rs.next())
	   {
		   %>
		   <tr>     
			  <td class=label><a href="PhysicalProgressSubdivisionReport.jsp?circle=<%=circlecode%>&division=<%=rs.getInt(48)%>&subdivision=<%=subdivisioncode%>&AssetType=<%=AssetType%>&cmbYear=<%=year%>" ><%=rs.getString(1)%></a></td> 

			 
		    <td class=label><%=rs.getInt(2)%></td>
  	
            <td class=label><%=rs.getInt(3)%></td>       			
            <td class=label><%=rs.getFloat(4)%></td>	
			
			<td class=label><%=rs.getFloat(5)%></td>       
			<td class=label><%=rs.getInt(6)%></td> 
            			
			<td class=label><%=rs.getInt(7)%></td>            
			<td class=label><%=rs.getFloat(8)%></td> 
            		
			<td class=label><%=rs.getFloat(9)%></td>            
			<td class=label><%=rs.getInt(10)%></td>
             			
			<td class=label><%=rs.getInt(11)%></td>
			<td class=label><%=rs.getInt(12)%></td>

			<td class=label><%=rs.getInt(13)%></td>
			<td class=label><%=rs.getFloat(14)%></td>
            
			<td class=label><%=rs.getFloat(15)%></td>
			<td class=label><%=rs.getFloat(16)%></td>
               

			<td class=label><%=rs.getFloat(17)%></td>
			<td class=label><%=rs.getInt(18)%></td>
			
			<td class=label><%=rs.getInt(19)%></td>
			<td class=label><%=rs.getInt(20)%></td>

			<td class=label><%=rs.getInt(21)%></td>
			<td class=label><%=rs.getFloat(22)%></td>
			
			<td class=label><%=rs.getFloat(23)%></td>
			<td class=label><%=rs.getFloat(24)%></td>

			<td class=label><%=rs.getFloat(25)%></td>
			<td class=label><%=rs.getInt(26)%></td>
			

			<td class=label><%=rs.getInt(27)%></td>
			<td class=label><%=rs.getInt(28)%></td>
		
			<td class=label><%=rs.getInt(29)%></td>
			<td class=label><%=rs.getInt(30)%></td>

			<td class=label><%=rs.getInt(31)%></td>
			<td class=label><%=rs.getInt(32)%></td>
			<td class=label><%=rs.getInt(33)%></td>
			<td class=label><%=rs.getFloat(34)%></td>
			<td class=label><%=rs.getFloat(35)%></td>
			<td class=label><%=rs.getFloat(36)%></td>
	        <td class=label><%=rs.getFloat(37)%></td>
             <td class=label><%=rs.getInt(38)%></td>
              <td class=label><%=rs.getInt(39)%></td>
			  <td class=label><%=rs.getInt(40)%></td>
              <td class=label><%=rs.getInt(41)%></td>
			  <td class=label><%=rs.getInt(42)%></td>
			  <td class=label><%=rs.getInt(43)%></td>
			  <td class=label><%=rs.getInt(44)%></td>
			  <td class=label><%=rs.getInt(45)%></td>
			  <td class=label><%=rs.getInt(46)%></td>
			  <td class=label><%=rs.getInt(47)%></td>

               </tr>

		   <%
	   }

	   }   

// End of Circle , Asset Type and Year
//for circle,subdivision,assettype and year
if (!request.getParameter("circle").equals("0") && !request.getParameter("subdivision").equals("0") && !request.getParameter("AssetType").equals("0") && !request.getParameter("year").equals("0"))
//if (!request.getParameter("circle").equals("0") && !request.getParameter("cmbYear").equals("0") && !request.getParameter("AssetType").equals("0") && request.getParameter("subdivision").equals("0"))
{

	str="select subdivision_office_name, sum(NO_PROPOSAL_UPTO_MON) as NO_PROPOSAL_UPTO_MON,sum(NO_PROPOSAL_DUR_MON) as  NO_PROPOSAL_DUR_MON, sum(PROPOSAL_COST_UPTO_MON) as PROPOSAL_COST_UPTO_MON,sum(PROPOSAL_COST_DUR_MON) as PROPOSAL_COST_DUR_MON,sum(NO_PROPOSAL_CLR_UPTO_MON) as NO_PROPOSAL_CLR_UPTO_MON,sum(NO_PROPOSAL_CLR_DUR_MON) as NO_PROPOSAL_CLR_DUR_MON,    sum(PROPOSAL_COST_CLR_UPTO_MON) as PROPOSAL_COST_CLR_UPTO_MON,sum(PROPOSAL_COST_CLR_DUR_MON) as PROPOSAL_COST_CLR_DUR_MON,sum(NO_NEW_WORKS_SANC_UPTO_MON) as NO_NEW_WORKS_SANC_UPTO_MON,sum(NO_NEW_WORKS_SANC_DUR_MON) as NO_NEW_WORKS_SANC_DUR_MON,sum(NO_AUG_WORKS_SANC_UPTO_MON) as NO_AUG_WORKS_SANC_UPTO_MON,sum(NO_AUG_WORKS_SANC_DUR_MON) as NO_AUG_WORKS_SANC_DUR_MON,sum(WORK_TENDER_COST_DUR_MON) as WORK_TENDER_COST_DUR_MON, sum(WORK_TENDER_COST_UPTO_MON) as WORK_TENDER_COST_UPTO_MON,sum(TOT_EXP_INLAKHS_DUR_MON) as TOT_EXP_INLAKHS_DUR_MON,sum(TOT_EXP_INLAKHS_UPTO_MON) as TOT_EXP_INLAKHS_UPTO_MON,sum(NO_NEW_WORKS_INPROG_DUR_MON) as NO_NEW_WORKS_INPROG_DUR_MON,sum(NO_NEW_WORKS_INPROG_UPTO_MON) as NO_NEW_WORKS_INPROG_UPTO_MON,sum(NO_AUG_WORKS_INPROG_DUR_MON) as NO_AUG_WORKS_INPROG_DUR_MON,sum(NO_AUG_WORKS_INPROG_UPTO_MON) as NO_AUG_WORKS_INPROG_UPTO_MON,sum(PER_PHY_PROGRESS) as PER_PHY_PROGRESS ,sum(PER_OF_OVERALL_EXP) as PER_OF_OVERALL_EXP,sum(TOTAL_WORK_VAL_CLEAR_DUR_MON) as TOTAL_WORK_VAL_CLEAR_DUR_MON ,sum(TOTAL_WORK_VAL_CLEAR_UPTO_MON) as TOTAL_WORK_VAL_CLEAR_UPTO_MON,sum(NO_OF_PC_HABS_COV_DUR_MON) as NO_OF_PC_HABS_COV_DUR_MON,sum(NO_OF_PC_HABS_COV_UPTO_MON) as NO_OF_PC_HABS_COV_UPTO_MON,sum(NO_OF_NSS_HABS_COV_DUR_MON) as NO_OF_NSS_HABS_COV_DUR_MON,sum(NO_OF_NSS_HABS_COV_UPTO_MON) as NO_OF_NSS_HABS_COV_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_UPTO_MON) as  NO_OF_PC_HABS_TAR_UPTO_MON  ,sum(NO_OF_PC_HABS_TAR_DUR_MON) as NO_OF_PC_HABS_TAR_DUR_MON ,sum(NO_OF_NSS_HABS_TAR_UPTO_MON) as NO_OF_NSS_HABS_TAR_UPTO_MON,sum(NO_OF_NSS_HABS_TAR_DUR_MON) as NO_OF_NSS_HABS_TAR_DUR_MON,sum(COST_OF_SPOVER_WORKS_DUR_MON) as COST_OF_SPOVER_WORKS_DUR_MON,sum(COST_OF_SPOVER_WORKS_UPTO_MON) as  COST_OF_SPOVER_WORKS_UPTO_MON ,sum(COST_OF_ONGO_WORKS_UPTO_MON) as COST_OF_ONGO_WORKS_UPTO_MON,sum(COST_OF_ONGO_WORKS_DUR_MON) as COST_OF_ONGO_WORKS_DUR_MON ,sum(TOT_NO_WORKS_COMP_DUR_MON) as TOT_NO_WORKS_COMP_DUR_MON ,sum(TOT_NO_WORKS_COMP_UPTO_MON) as TOT_NO_WORKS_COMP_UPTO_MON,sum(TOT_NO_WORKS_GRD_DUR_MON) as TOT_NO_WORKS_GRD_DUR_MON,sum(TOT_NO_WORKS_GRD_UPTO_MON) as TOT_NO_WORKS_GRD_UPTO_MON,sum(TOT_NO_WORKS_ADMSAN_DUR_MON) as TOT_NO_WORKS_ADMSAN_DUR_MON,sum(TOT_OF_WORKS_ADMSANC_UPTO_MON) as TOT_OF_WORKS_ADMSANC_UPTO_MON,sum(TOT_OF_WORKS_TECHSANC_DUR_MON) as TOT_OF_WORKS_TECHSANC_DUR_MON,sum(TOT_OF_WORKS_TECHSANC_UPTO_MON) as TOT_OF_WORKS_TECHSANC_UPTO_MON,sum(TOT_OF_WORKS_COMP_DUR_MON) as TOT_OF_WORKS_COMP_DUR_MON,sum(TOT_OF_WORKS_COMPC_UPTO_MON) as TOT_OF_WORKS_COMPC_UPTO_MON  from rws_physical_progress_tbl, rws_subdivision_office_tbl where rws_subdivision_office_tbl.circle_office_code = substr(rws_physical_progress_tbl.office_code,2,2) and rws_subdivision_office_tbl.division_office_code = substr(rws_physical_progress_tbl.office_code,4,1) and rws_subdivision_office_tbl.subdivision_office_code = substr(rws_physical_progress_tbl.office_code,5,2) and substr(office_code,2,2)=? and substr(office_code,4,1) = ? and year= ? and asset_type = ? group by subdivision_office_name";
	pstmt=conn.prepareStatement(str);
	    pstmt.setString(1,circlecode);
		pstmt.setInt(2,divisioncode);
	    pstmt.setString(3,year);
	    pstmt.setString(4,AssetType);

	   rs=pstmt.executeQuery();
	   while(rs.next())
	{
		    %>
		   <tr>     
			  <td class=label><a href=""><%=rs.getString(1)%></a></td> 

			 
		    <td class=label><%=rs.getInt(2)%></td>
  	
            <td class=label><%=rs.getInt(3)%></td>       			
            <td class=label><%=rs.getFloat(4)%></td>	
			
			<td class=label><%=rs.getFloat(5)%></td>       
			<td class=label><%=rs.getInt(6)%></td> 
            			
			<td class=label><%=rs.getInt(7)%></td>            
			<td class=label><%=rs.getFloat(8)%></td> 
            		
			<td class=label><%=rs.getFloat(9)%></td>            
			<td class=label><%=rs.getInt(10)%></td>
             			
			<td class=label><%=rs.getInt(11)%></td>
			<td class=label><%=rs.getInt(12)%></td>

			<td class=label><%=rs.getInt(13)%></td>
			<td class=label><%=rs.getFloat(14)%></td>
            
			<td class=label><%=rs.getFloat(15)%></td>
			<td class=label><%=rs.getFloat(16)%></td>
               

			<td class=label><%=rs.getFloat(17)%></td>
			<td class=label><%=rs.getInt(18)%></td>
			
			<td class=label><%=rs.getInt(19)%></td>
			<td class=label><%=rs.getInt(20)%></td>

			<td class=label><%=rs.getInt(21)%></td>
			<td class=label><%=rs.getFloat(22)%></td>
			
			<td class=label><%=rs.getFloat(23)%></td>
			<td class=label><%=rs.getFloat(24)%></td>

			<td class=label><%=rs.getFloat(25)%></td>
			<td class=label><%=rs.getInt(26)%></td>
			

			<td class=label><%=rs.getInt(27)%></td>
			<td class=label><%=rs.getInt(28)%></td>
		
			<td class=label><%=rs.getInt(29)%></td>
			<td class=label><%=rs.getInt(30)%></td>

			<td class=label><%=rs.getInt(31)%></td>
			<td class=label><%=rs.getInt(32)%></td>
			<td class=label><%=rs.getInt(33)%></td>
			<td class=label><%=rs.getFloat(34)%></td>
			<td class=label><%=rs.getFloat(35)%></td>
			<td class=label><%=rs.getFloat(36)%></td>
	        <td class=label><%=rs.getFloat(37)%></td>
             <td class=label><%=rs.getInt(38)%></td>
              <td class=label><%=rs.getInt(39)%></td>
			  <td class=label><%=rs.getInt(40)%></td>
              <td class=label><%=rs.getInt(41)%></td>
			  <td class=label><%=rs.getInt(42)%></td>
			  <td class=label><%=rs.getInt(43)%></td>
			  <td class=label><%=rs.getInt(44)%></td>
			  <td class=label><%=rs.getInt(45)%></td>
			  <td class=label><%=rs.getInt(46)%></td>
			  <td class=label><%=rs.getInt(47)%></td>

               </tr>

		   <%
	   }
  }
		
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
	</body>
	</table>
	</html>
  
  


 
  

		