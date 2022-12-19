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
String type="";
type=request.getParameter("rs");

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
		<td align="center" class="rptHeading" colspan="14"> Assets - FILTERS </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Wtp Code</td>
			   <td class=btext>Wtp Type</td>
			   <td class=btext>Capacity in MLD</td>
			   <td class=btext>Wtp Size</td>
			   <td class=btext>No.Of <br>StandBy Units</td>
			   <td class=btext>Back Wash Frequency</td>
			   <td class=btext>Performance</td>
			   <td class=btext>Capacity<BR>In Use(MLD)</td>
			   <td class=btext>Extension Scope</td>
			   <td class=btext>Frequency Sand Scrap</td>
			   <td class=btext>Asset Code</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
       if(type.equals("RS"))
		{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_CPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
 


	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
			   
			   
			   
			  



<%


			
			
			
		}
		}
		 else if(type.equals("SS"))
		{
stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_CPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "' and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
		
	



<%


			
			
			
		}
		}
		}



	
	  else if(typeassetcode.equals("01"))
			
	{
       if(type.equals("RS"))
		{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_PWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
			   
			   
			   
			  



<%


			
			
			
		}
		}
		else  if(type.equals("SS"))
		{
stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_PWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
		
	



<%


			
			
			
		}
		}
		
		
	}
				

	else if(typeassetcode.equals("02"))
			
	{
       if(type.equals("RS"))
		{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_MPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "' and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
			   
			   
			   
			  



<%


			
			
			
		}
		}
		else if(type.equals("SS"))
		{
stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_MPWS_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'  and substr(wtpsc_code,20,2)='" + type + "' ");
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
		
	



<%


			
			
			
		}
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
