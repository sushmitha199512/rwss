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

String assetcode="";
assetcode=request.getParameter("assetcode");

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
String habcode="";
habcode=request.getParameter("habcode");
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
		<td align="center" class="rptHeading" colspan="14"> SOURCE-PUMPSETS-REPORT  </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Pump Code</td>
			   <td class=btext>Pump Make</td>
			   <td class=btext>Pump Capacity</td>
			   <td class=btext>Pump Type</td>
			   <td class=btext>Year Of<br>Commissioning</td>
			   <td class=btext>Hours Running<BR>Per Day</td>
			   <td class=btext>Usage</td>
			   <td class=btext>Designed Lpm</td>
			   <td class=btext>Designed Head</td>
			   <td class=btext>Control Panel</td>
			   <td class=btext>Low <br>Volt Problem</td>
			   <td class=btext>Power Available Per Day</td>
			   <td class=btext>Feasability Of <br>Getting Urban Line</td>
			   <td class=btext>Cost</td>
			   <td class=btext>Urban Line Distance</td>
			   <td class=btext>Suggestions</td>
			   <td class=btext>Location</td>
			   <td class=btext>Feeder</td>
			   
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  pump_code,nvl(pump_make,'-'),pump_cpty,nvl(pump_type,'-'),nvl(year_comm,'-'),hr_run,nvl(usage,'-'),designed_lpm,designed_head,nvl(control_panel,'-'),nvl(low_volt_prob,'-'),power_avail_per_day,nvl(feas_urban_line,'-'),cost,urban_line_distance,nvl(suggestions,'-'),nvl(location,'-'),nvl(feeder,'-') from rws_cpws_subcomp_param_tbl  where asset_code='" + assetcode + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getString(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
				<td class=rptValue><%=rs1.getString(17)%></td>
				<td class=rptValue><%=rs1.getString(18)%></td>
							
				</tr>
			



<%


			
			
			
		}
				


	}
	   else if(typeassetcode.equals("01"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select pump_code,nvl(pump_make,'-'),pump_cpty,nvl(pump_type,'-'),nvl(year_comm,'-'),hr_run,nvl(usage,'-'),designed_lpm,designed_head,nvl(control_panel,'-'),nvl(low_volt_prob,'-'),power_avail_per_day,nvl(feas_urban_line,'-'),cost,urban_line_distance,nvl(suggestions,'-'),nvl(location,'-'),nvl(feeder,'-') from rws_pws_subcomp_param_tbl where asset_code='"+assetcode+"' ");
		while(rs1.next())
    	{
			
				%>
				
				<tr bgcolor="#ffffff">
			    <td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getString(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
				<td class=rptValue><%=rs1.getString(17)%></td>
				<td class=rptValue><%=rs1.getString(18)%></td>
								
				
			
				</tr>		




<%


			
			
			
		}
	}
	
				
				else if(typeassetcode.equals("02"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select pump_code,nvl(pump_make,'-'),pump_cpty,nvl(pump_type,'-'),nvl(year_comm,'-'),hr_run,nvl(usage,'-'),designed_lpm,designed_head,nvl(control_panel,'-'),nvl(low_volt_prob,'-'),power_avail_per_day,nvl(feas_urban_line,'-'),cost,urban_line_distance,nvl(suggestions,'-'),nvl(location,'-'),nvl(feeder,'-') from rws_mpws_subcomp_param_tbl where asset_code='"+assetcode+"'  ");
		while(rs1.next())
    	{
			
				%>
				
				<tr bgcolor="#ffffff">
			    <td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getString(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
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
</html>
