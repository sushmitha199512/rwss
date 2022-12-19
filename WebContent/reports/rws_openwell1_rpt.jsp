<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<body>
<form>

<%


int psno=0;
int tot=0;
int total=0;
Statement stmt1=null;
ResultSet rs1=null;

String pname="";
String vname="";

String typeassetname="";
typeassetname=request.getParameter("typeassetname");
out.println(typeassetname);
String assetcode="";
assetcode=request.getParameter("assetcode");
out.println(assetcode);
int sno=1;
String districtcode="";
String mandalcode="";
String panchayatcode="";
String villagecode="";
String mandalname="";
String districtname="";
String panchayatname="";
String villagename="";

districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");

districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String panchcode="";
panchcode=request.getParameter("panchcode");
String typeassetcode="";
typeassetcode=request.getParameter("typeassetcode");

%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_coverage_status_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Assets - OPENWELL </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Openwell Code</td>
			   <td class=btext>Location</td>
			   <td class=btext>Diameter</td>
			   <td class=btext>Depth</td>
			   <td class=btext>Normal Water Level</td>
			   <td class=btext>Minimum Water Level</td>
			   <td class=btext>Maximum Water Level</td>
			   <td class=btext>Platform Exists</td>
			   <td class=btext>PlatForm Condition</td>
			   <td class=btext>Purpose</td>
			   <td class=btext>Quality</td>
			   <td class=btext>Flouride Percentage</td>
			   <td class=btext>Brakish Percentage</td>
			   <td class=btext>Iron Percentage</td>
			   <td class=btext>Other Type</td>
			   <td class=btext>Other Percentage</td>
			   <td class=btext>Flouride</td>
			   <td class=btext>Brakish</td>
			   <td class=btext>Iron</td>
			   <td class=btext>Others</td>
			   </tr>

<%

try
{
	 

	   if(typeassetcode.equals("06"))
			
	{
		

   
		stmt1=conn.createStatement();
	

		rs1=stmt1.executeQuery("select  openwell_code,location,diameter,depth,normal_water_level,min_water_level,max_water_level,platform_exists,platform_condition,purpose,quality,flouride_per,brakish_per,iron_per,other_type,other_per,rad_flouride,rad_brakish,rad_iron,rad_others from rws_open_well_mast_tbl where  asset_code='"+assetcode+'");
		while(rs1.next())
    	{
		

			
				%>
 

				
				<tr bgcolor="#ffffff">
                <td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
                 <td class=rptValue><%=rs1.getInt(7)%></td>
                <td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
		        <td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				<td class=rptValue><%=rs1.getInt(16)%></td>
                <td class=rptValue><%=rs1.getString(17)%></td> 
                <td class=rptValue><%=rs1.getString(18)%></td> 
				<td class=rptValue><%=rs1.getString(19)%></td>
				<td class=rptValue><%=rs1.getString(20)%></td>
				</tr>


<%


			
			
			
		}
	}
				

 	
}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
	conn.close();
}
%>
</table>
</form>
</body>
</html>
