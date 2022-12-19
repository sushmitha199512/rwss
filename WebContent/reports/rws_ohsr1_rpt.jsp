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
		<td align="center" class="rptHeading" colspan="14"> RESERVOIRS-OHSR-REPORT  </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Ohsr Code</td>
			   <td class=btext>Capacity in Lts</td>
			   <td class=btext>Location</td>
			   <td class=btext>Stages</td>
			   <td class=btext>Lowest WaterLevel</td>
			   <td class=btext>Max.WaterLevel</td>
			   <td class=btext>Fill Hour</td>
			   <td class=btext>Empty Hour</td>
			   <td class=btext>No of Filling</td>
			   <td class=btext>Asset Code</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select ohsr_code,ohsr_cap_lts,nvl(ohsr_loc,'-'),ohsr_satges,ohsr_lwl,ohsr_mwl,ohsr_fill_hr,ohsr_empty_hr,ohsr_no_of_filling,asset_code from RWS_CPWS_OHSR_SC_PARAM_TBL   where asset_code='"+assetcode+"'  ");
  
		while(rs1.next())
    	{
	     				%>
				
                <tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
                 <td class=rptValue><%=rs1.getInt(6)%></td>
                <td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				
				</tr>		
			



<%


			
			
			
		}
				


	}
	   if(typeassetcode.equals("01"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  ohsr_code,ohsr_cap_lts,nvl(ohsr_loc,'-'),ohsr_satges,ohsr_lwl,ohsr_mwl,ohsr_fill_hr,ohsr_empty_hr,ohsr_no_of_filling,asset_code from RWS_PWS_OHSR_SC_PARAM_TBL  where asset_code='"+assetcode+"'   ");
		while(rs1.next())
    	{
			
				%>
 

				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
                <td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				
				</tr>		




<%


			
			
			
		}
	}
	
				 if(typeassetcode.equals("02"))
			
	{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  ohsr_code,ohsr_cap_lts,nvl(ohsr_loc,'-'),ohsr_satges,ohsr_lwl,ohsr_mwl,ohsr_fill_hr,ohsr_empty_hr,ohsr_no_of_filling,asset_code from RWS_MPWS_OHSR_SC_PARAM_TBL  where asset_code='"+assetcode+"'   ");
		while(rs1.next())
    	{
			
				%>
 

				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
                <td class=rptValue><%=rs1.getInt(7)%></td>
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
