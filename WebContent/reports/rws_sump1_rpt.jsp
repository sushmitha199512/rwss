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
<td align="center" class="rptHeading" colspan="14"> HEADWORKS-SUMP-REPORT</td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Sump Code</td>
			   <td class=btext>Sump Type</td>
			   <td class=btext>Sump Capacity(Ltrs)</td>
			   <td class=btext>Filling Hr</td>
			   <td class=btext>Empty Time Hr</td>
			   <td class=btext>Sump Condition</td>
			   <td class=btext>Sump Made Of</td>
			   <td class=btext>Sump Diameter</td>
			   <td class=btext>Sump Depth</td>
			   <td class=btext>Location</td>
			   <td class=btext>Asset Code</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  sumpcode,nvl(sump_type,'-'),sump_capacity,filling_hr,empty_time_hr,nvl(sump_condition,'-'),nvl(sump_made_of,'-'),sump_diameter,sump_depth,nvl(location,'-'),asset_code from rws_cpws_sump_m_sc_param_tbl   where asset_code='"+assetcode+"' ");
  
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
                 <td class=rptValue><%=rs1.getString(6)%></td>
                <td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				
				
				
				
				
				</tr>		
			



<%


			
			
			
		}
				


	}
	  else  if(typeassetcode.equals("01"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select   sumpcode,nvl(sump_type,'-'),sump_capacity,filling_hr,empty_time_hr,nvl(sump_condition,'-'),nvl(sump_made_of,'-'),sump_diameter,sump_depth,nvl(location,'-'),asset_code from rws_pws_sump_m_sc_param_tbl    where asset_code='"+assetcode+"'");
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
                 <td class=rptValue><%=rs1.getString(6)%></td>
                <td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				

				
				

                

                

				
				</tr>		




<%


			
			
			
		}
	}
	
				
				else if(typeassetcode.equals("02"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select   sumpcode,nvl(sump_type,'-'),sump_capacity,filling_hr,empty_time_hr,nvl(sump_condition,'-'),nvl(sump_made_of,'-'),sump_diameter,sump_depth,nvl(location,'-'),asset_code from rws_mpws_sump_m_sc_param_tbl    where asset_code='"+assetcode+"'");
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
                 <td class=rptValue><%=rs1.getString(6)%></td>
                <td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				

				
				

                

                

				
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


</p>
</html>
