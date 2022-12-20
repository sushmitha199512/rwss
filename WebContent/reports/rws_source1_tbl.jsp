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
String sourcetypecode="";
sourcetypecode=request.getParameter("sourcetypecode");

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
				<td class="bwborder"><a href="rws_graph_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Assets - SOURCES </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
		
               <td class=btext>Sl.No</td>
			   <td class=btext>Source code</td>
			   <td class=btext>Source Name</td>
			   <td class=btext>No. of Habitations Covered</td>
			   <td class=btext>Population Benifited</td>
			   <td class=btext>Seasonal</td>
			   <td class=btext>Water Quality</td>
			   <td class=btext>Static Water Level</td>
			   <td class=btext>Summer Water Level</td>
			   <td class=btext>Yield</td>
			   <td class=btext>Distance Near Private Source</td>
			   <td class=btext>Location</td>
			   <td class=btext>Diameter</td>
			   <td class=btext>Depth</td>
			   <td class=btext>Source Condition</td>
			   <td class=btext>Type</td>
			   </tr>


<%

try
{
	 

	    if(typeassetcode.equals("03"))
	{
        if(sourcetypecode.equals("1"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '8%' and source_type_code='1'");
		while(rs1.next())
    	{


	     				%>
					<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
				</tr>
			



<%


			
			
			
		}
		}
				
 else if(sourcetypecode.equals("2"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "'   and substr(source_code,17,3) like '8%' and source_type_code='2' ");
		while(rs1.next())
    	{


	     				%>
<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
				</tr>

					

<%


			
			
			
		}
		}
				

				



	}
	   else if(typeassetcode.equals("01"))
			
	{
		if(sourcetypecode.equals("1"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(" select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '6%' and source_type_code='1' ");
		while(rs1.next())
    	{


 

			
				%>
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
				</tr>






<%


			
			
			
		}
		}

		else if(sourcetypecode.equals("2"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '6%' and source_type_code='2'");
		while(rs1.next())
    	{


	     				%>
<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
				</tr>

					

<%


			
			
			
		}
		}


	}
				

			
			
	 else if(typeassetcode.equals("02"))
	{
        if(sourcetypecode.equals("1"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "'  and substr(source_code,17,3) like '4%' and source_type_code='1");
		while(rs1.next())
    	{


	     				%>
					<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
				</tr>
			



<%


			
			
			
		}
		}
				
 else if(sourcetypecode.equals("2"))
		{
   
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select source_code,source_name,NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "' and substr(source_code,17,3) like '4%' and source_type_code='2'");
		while(rs1.next())
    	{


	     				%>
<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getInt(4)%></td>
				<td class=rptValue><%=rs1.getString(5)%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getInt(7)%></td>
				<td class=rptValue><%=rs1.getInt(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getString(11)%></td>
				<td class=rptValue><%=rs1.getInt(12)%></td>
				<td class=rptValue><%=rs1.getInt(13)%></td>
				<td class=rptValue><%=rs1.getString(14)%></td>
				<td class=rptValue><%=rs1.getString(15)%></td>
				
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
