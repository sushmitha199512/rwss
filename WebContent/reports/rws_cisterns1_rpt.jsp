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
	<tr bgcolor="#edf2f8" align="center">
		
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> RESERVOIRS-CISTERNS-REPORT  </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Cistern No</td>
			   <td class=btext>Location</td>
			   <td class=btext>Capacity (Lts)</td>
			   <td class=btext>Condition</td>
			   <td class=btext>Fill</td>
			   <td class=btext>Mod Fill</td>
			   <td class=btext>Use</td>
			   <td class=btext>Pf</td>
			   <td class=btext>Pf Condition</td>
			   <td class=btext>Drain</td>
			   <td class=btext>Tap</td>
			   <td class=btext>Tap Condition</td>
			   <td class=btext>Hr</td>
			   <td class=btext>Hr One</td>
			   <td class=btext>Hr All</td>
			   <td class=btext>Cistern Code</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  cis_no,cis_loc,cis_cap_lts,cis_cond,nvl(cis_fill,'-'),nvl(cis_mod_fill,'-'),nvl(cis_use,'-'),cis_pf,cis_pf_con,cis_drain,cis_tap,cis_tap_cond,cis_hr,cis_hr_one,cis_hr_all,cissc_code,asset_code from rws_cpws_cis_sc_param_tbl  where asset_code='" + assetcode + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getInt(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				<td class=rptValue><%=rs1.getString(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
				<td class=rptValue><%=rs1.getString(17)%></td>
				</tr>
			



<%


			
			
			
		}
				


	}
	   else if(typeassetcode.equals("01"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  cis_no,cis_loc,cis_cap_lts,cis_cond,cis_fill,cis_mod_fill,cis_use,cis_pf,cis_pf_con,cis_drain,cis_tap,cis_tap_cond,cis_hr,cis_hr_one,cis_hr_all,cissc_code,asset_code from rws_cpws_cis_sc_param_tbl  where asset_code='"+assetcode+"' ");
		while(rs1.next())
    	{
			
				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getInt(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				<td class=rptValue><%=rs1.getString(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
				<td class=rptValue><%=rs1.getString(17)%></td>
				</tr>


				


<%


			
			
			
		}
	}
	
				
				else if(typeassetcode.equals("02"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  cis_no,cis_loc,cis_cap_lts,cis_cond,cis_fill,cis_mod_fill,cis_use,cis_pf,cis_pf_con,cis_drain,cis_tap,cis_tap_cond,cis_hr,cis_hr_one,cis_hr_all,cissc_code,asset_code from rws_mpws_cis_sc_param_tbl  where asset_code='"+assetcode+"' ");
		while(rs1.next())
    	{
			
				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getInt(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				<td class=rptValue><%=rs1.getString(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getInt(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
				<td class=rptValue><%=rs1.getString(17)%></td>
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
