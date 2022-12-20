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
		<td align="center" class="rptHeading" colspan="14"> HEADWORKS-SS TANK-REPORT </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>SS Tank Code</td>
			   <td class=btext>SS Tank Size(LBD)</td>
			   <td class=btext>Capacity Days</td>
			   <td class=btext>Capacity Mcum</td>
			   <td class=btext>Tank Adequacy</td>
			   <td class=btext>Location</td>
			   <td class=btext>Power Consumption</td>
               <td class=btext>Power Hours</td>
			   <td class=btext>Depth(MTS)</td>
			   <td class=btext>Others</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  sssc_code,ss_size,capacity_days,capacity_mcum,nvl(tank_adeqacy,'-'),nvl(location,'-'),nvl(power_con,'-'),power_hrs,depth,nvl(others,'-') from rws_cpws_ss_sc_param_tbl  where asset_code='" + assetcode + "'");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				</tr>
			



<%


			
			
			
		}
				


	}
	   else if(typeassetcode.equals("01"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  sssc_code,ss_size,capacity_days,capacity_mcum,nvl(tank_adeqacy,'-'),nvl(location,'-'),nvl(power_con,'-'),power_hrs,depth,nvl(others,'-') from rws_pws_ss_sc_param_tbl where asset_code='"+assetcode+"'   ");
		while(rs1.next())
    	{
			
				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				

				</tr>		




<%


			
			
			
		}
	}
				


else if(typeassetcode.equals("02"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  sssc_code,ss_size,capacity_days,capacity_mcum,nvl(tank_adeqacy,'-'),nvl(location,'-'),nvl(power_con,'-'),power_hrs,depth,nvl(others,'-') from rws_mpws_ss_sc_param_tbl where asset_code='"+assetcode+"'  ");
		while(rs1.next())
    	{
			

				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getFloat(2)%></td>
				<td class=rptValue><%=rs1.getFloat(3)%></td>
				<td class=rptValue><%=rs1.getFloat(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				


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
