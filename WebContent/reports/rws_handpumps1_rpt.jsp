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
String hpcode=request.getParameter("hpcode");
String panchname=request.getParameter("panchname");

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
<td align="center" class="rptHeading" colspan="14">HAND PUMPS-SOURCE-BORE WELL-REPORT </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Location</td>
			  
			   <td class=btext>Diameter</td>
			   <td class=btext>Casing(Type)</td>
			   <td class=btext>Status</td>
			   <td class=btext>General Condition</td>
			   <td class=btext>GI No</td>
			   <td class=btext>Painted</td>
			   <td class=btext>Static Water Level(Mts)</td>
			   <td class=btext>Summer Water Level(Mts)</td>
               <td class=btext>P Condition</td>
			   <td class=btext>Dry During</td>
			   <td class=btext>Service</td>
			   <td class=btext>Ser No</td>
			   <td class=btext>Ser Hrs</td>
			   <td class=btext>Repairs</td>
			   <td class=btext>Platform Condition</td>
			   <td class=btext>Drain</td>
			   <td class=btext>Drain Condition</td>
			   <td class=btext>Drain SD</td>
			   <td class=btext>Drain Lp</td>
			   <td class=btext>Hygiene</td>
			   <td class=btext>Average Time</td>
			   <td class=btext>P Yeild</td>
			   <td class=btext>PYeild Local</td>
			   <td class=btext>Period</td>
			   <td class=btext>Depth(Mts)</td>
			   <td class=btext>HandPump Code</td>
			   <td class=btext>Quality Affected</td>
			   <td class=btext>Flouride</td>
			   <td class=btext>Brakish</td>
			   <td class=btext>Iron</td>
			   <td class=btext>Others Specify Type</td>
			   <td class=btext>Cont Others Type</td>
			   <td class=btext>Cont Others Percentage</td>
			   <td class=btext>Drill Year</td>
			   </tr>



<%

try
{
	 

	   if(typeassetcode.equals("04"))
			
	{
		

   
		stmt1=conn.createStatement();
 


		rs1=stmt1.executeQuery("select  nvl(location,'-'),diameter,nvl(casing,'-'),status,nvl(gen_condition,'-'),gi_no,painted,static_wl,summer_wl,nvl(p_cond,'-'),dry_during,nvl(service,'-'),ser_no,ser_hrs,repairs,nvl(platform_condition,'-'),drain,drain_condition,nvl(drain_sd,'-'),nvl(drain_lp,'-'),nvl(hygiene,'-'),avg_time,p_yeild,nvl(pyeild_local,'-'),nvl(period,'-'),nvl(depth,'0'),hp_code,nvl(quality_affected,'-'),nvl(flouride,'0'),brakish,iron,others_specify_type,nvl(cont_others_type,'-'),nvl(cont_others_per,'0'),drill_year from rws_hp_subcomp_param_tbl  where  asset_code='"+assetcode+"'  ");

		


	 
 

		while(rs1.next())
    	{

		

		

			
				%>
 

				
				<tr bgcolor="#ffffff">
                <td class=rptValue><%=sno++%></td>
		
				<td class=rptValue><%=rs1.getString(1)%></td>
				
				<td class=rptValue><%=rs1.getInt(2)%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
                 <td class=rptValue><%=rs1.getString(7)%></td>
                <td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getInt(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
                


		        <td class=rptValue><%=rs1.getInt(11)%></td>
				<td class=rptValue><%=rs1.getString(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getInt(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				<td class=rptValue><%=rs1.getString(16)%></td>
                <td class=rptValue><%=rs1.getString(17)%></td>
				<td class=rptValue><%=rs1.getString(18)%></td>
				<td class=rptValue><%=rs1.getString(19)%></td>
				<td class=rptValue><%=rs1.getString(20)%></td>



				<td class=rptValue><%=rs1.getString(21)%></td>
				<td class=rptValue><%=rs1.getInt(22)%></td>
				<td class=rptValue><%=rs1.getInt(23)%></td>
				<td class=rptValue><%=rs1.getString(24)%></td>
				<td class=rptValue><%=rs1.getString(25)%></td>
				<td class=rptValue><%=rs1.getInt(26)%></td>
                <td class=rptValue><%=rs1.getString(27)%></td>
				<td class=rptValue><%=rs1.getString(28)%></td>
				<td class=rptValue><%=rs1.getInt(29)%></td>
				<td class=rptValue><%=rs1.getInt(30)%></td>
				
				<td class=rptValue><%=rs1.getInt(31)%></td>
				<td class=rptValue><%=rs1.getInt(32)%></td>
				<td class=rptValue><%=rs1.getString(33)%></td>
				<td class=rptValue><%=rs1.getInt(34)%></td>
				<td class=rptValue><%=rs1.getString(35)%></td>






  


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
