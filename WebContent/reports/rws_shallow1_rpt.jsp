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
//out.println(typeassetname);
String assetcode="";
assetcode=request.getParameter("assetcode");
//out.println(assetcode);
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
<td align="center" class="rptHeading" colspan="14"> Assets - PONDS </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Shallow HandPump Code</td>
			   <td class=btext>Location</td>
			   <td class=btext>Diameter</td>
			   <td class=btext>Depth</td>
			   <td class=btext>Hygiene</td>
			   <td class=btext>Average Hours</td>
			   <td class=btext>Average Time</td>
			   <td class=btext>Yield</td>
			   <td class=btext>Water Quality</td>
			   <td class=btext>Flouride Percentage</td>
               <td class=btext>Brakish Percentage</td>
			   <td class=btext>Iron Percentage</td>
			   <td class=btext>Others Percentage</td>
			   <td class=btext>Flouride</td>
			   <td class=btext>Brakish</td>
			   <td class=btext>Iron</td>
			   <td class=btext>Others</td>
			   </tr> 
			     





<%

try
{
	 

	   if(typeassetcode.equals("07"))
			
	{
		

   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  shallowhp_code,location,diameter,depth,hygiene,average_hours,average_time,yield,water_quality,flouride_per,brakish_per,iron_per,others_per,flouride,brakish,iron,others from RWS_SHALLOWHANDPUMPS_TBL  where asset_code='"+assetcode+"' ");
		while(rs1.next())
    	{%>
 

				
				<tr bgcolor="#ffffff">
                <td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
                 <td class=rptValue><%=rs1.getInt(7)%></td>
                <td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getInt(10)%></td>
		        <td class=rptValue><%=rs1.getInt(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
                <td class=rptValue><%=rs1.getString(17)%></td>
				<td class=rptValue><%=rs1.getString(18)%></td>
		
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

<%@ include file="footer.jsp" %>
</p>
</html>
