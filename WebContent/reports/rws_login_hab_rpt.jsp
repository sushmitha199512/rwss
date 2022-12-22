<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file = "conn.jsp" %>
<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<table border=0 width="100%" height="80%" valign=middle>
<tr>
<td width="50%">
<table border=1 style="border-collapse:collapse">
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="2">
			<font color="ffffff">Habitation  Status </font></td>
	</tr>

	<tr>
	<td class="mystyle1">Coverage Status</td>
	<td class="mystyle1">No. of Habitations</td>	
	</tr>
<%
try
{
	int totalHab = 0, totalAssets = 0, repNo = 0, propNo = 0, newEstNo =0, omEstNo = 0;
	PreparedStatement ps1 = null, ps2 = null, ps3=null, ps4 = null, ps5 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
	

	String headOfficeCode = user.getHeadOfficeCode();
	String circleOfficeCode = user.getCircleOfficeCode();
	String divisionOfficeCode = user.getDivisionOfficeCode();
	String subdivisionOfficeCode = user.getSubdivisionOfficeCode();
	String query = null, query1 = null, query2=null, query3=null, query4 = null, query5=null;
	String[] cstatus = {"FC","PC1", "PC2", "PC3", "PC4", "NC","NSS","UI"};
	String[] assetType = {"01","02","03","04","05"};

	if (!headOfficeCode.equals("0") && circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
	{
		query="SELECT count(*) as cnt from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code AND coverage_status=?" ;
		query1 = " SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps', '05', 'Shallow HandPumps', '06', 'Open Wells', '07', 'Ponds', '08', 'Others') as TYPE_OF_ASSET_CODE FROM asset_mast1 WHERE TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		
		query2 = "select count(*) from RWS_REP_PROPOSAL_TBL";

		query3 = "select count(*) from RWS_WORK_PROPOSAL_TBL ";
		query4 = "SELECT count(*) FROM RWS_NEW_EST_TBL";
		query5 = "SELECT count(*) FROM RWS_OM_EST_TBL  ";

		ps = conn.prepareStatement(query);
		ps1 = conn.prepareStatement(query1);
		ps2 = conn.prepareStatement(query2);
		ps3 = conn.prepareStatement(query3);
		ps4 = conn.prepareStatement(query4);
		ps5 = conn.prepareStatement(query5);
										
	}
	else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
	{
		query="SELECT count(*) as cnt from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  circle_office_code=? AND coverage_status=?" ;
		query1 = " SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps', '05', 'Shallow HandPumps', '06', 'Open Wells', '07', 'Ponds', '08', 'Others') as TYPE_OF_ASSET_CODE FROM asset_mast1 WHERE circle_office_code = ? AND TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		query2 = "select count(*) from RWS_REP_PROPOSAL_TBL where substr(office_code,2,2)=?";

		query3 = "select count(*) from RWS_WORK_PROPOSAL_TBL where substr(office_code,2,2)=?";
		query4 = "SELECT count(*) FROM RWS_NEW_EST_TBL where substr(office_code,2,2)=?";
		query5 = "SELECT count(*) FROM RWS_OM_EST_TBL  where substr(office_code,2,2)=?";

		ps = conn.prepareStatement(query);
		ps1 = conn.prepareStatement(query1);
		ps2 = conn.prepareStatement(query2);
		ps3 = conn.prepareStatement(query3);
		ps4 = conn.prepareStatement(query4);
		ps5 = conn.prepareStatement(query5);

		ps.setString(1,circleOfficeCode);
		ps1.setString(1,circleOfficeCode);
		ps2.setString(1,circleOfficeCode);
		ps3.setString(1,circleOfficeCode);
		ps4.setString(1,circleOfficeCode);
		ps5.setString(1,circleOfficeCode);

			
	}
	else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && !divisionOfficeCode .equals("0") && subdivisionOfficeCode.equals("00"))
	{
		query="SELECT count(*) as cnt from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  circle_office_code=? AND division_office_code = ? AND coverage_status=?" ;
		query1 = " SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps', '05', 'Shallow HandPumps', '06', 'Open Wells', '07', 'Ponds', '08', 'Others') as TYPE_OF_ASSET_CODE FROM asset_mast1 WHERE circle_office_code = ? AND division_office_code = ? AND TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		query2 = "select count(*) from RWS_REP_PROPOSAL_TBL where substr(office_code,2,2)=? AND substr(office_code,4,1)=?";

		query3 = "select count(*) from RWS_WORK_PROPOSAL_TBL where substr(office_code,2,2)=? AND substr(office_code,4,1)=?";
		query4 = "SELECT count(*) FROM RWS_NEW_EST_TBL where substr(office_code,2,2)=? AND substr(office_code,4,1)=?";
		query5 = "SELECT count(*) FROM RWS_OM_EST_TBL  where substr(office_code,2,2)=? AND substr(office_code,4,1)=?";

		ps = conn.prepareStatement(query);
		ps.setString(1,circleOfficeCode);
		ps.setString(2,divisionOfficeCode);

		ps1 = conn.prepareStatement(query1);
		ps1.setString(1,circleOfficeCode);
		ps1.setString(2,divisionOfficeCode);
	
		ps2 = conn.prepareStatement(query2);
		ps2.setString(1,circleOfficeCode);
		ps2.setString(2,divisionOfficeCode);

		ps3 = conn.prepareStatement(query3);
		ps3.setString(1,circleOfficeCode);
		ps3.setString(2,divisionOfficeCode);

		ps4 = conn.prepareStatement(query4);
		ps4.setString(1,circleOfficeCode);
		ps4.setString(2,divisionOfficeCode);

		ps5 = conn.prepareStatement(query5);
		ps5.setString(1,circleOfficeCode);
		ps5.setString(2,divisionOfficeCode);

	}
	else
	{
		query="SELECT count(*) as cnt from rws_habitation_directory_tbl h, rws_panchayat_raj_tbl p where p.panch_code=h.hab_code and  circle_office_code=? AND division_office_code = ? AND subdivision_office_code = ? AND coverage_status=?" ;
		query1 = " SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS','03', 'MPWS', '02','CPWS', '04', 'Hand Pumps', '05', 'Shallow HandPumps', '06', 'Open Wells', '07', 'Ponds', '08', 'Others') as TYPE_OF_ASSET_CODE FROM asset_mast1 WHERE circle_office_code = ? AND division_office_code = ? AND subdivision_office_code = ? AND TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		query2 = "select count(*) from RWS_REP_PROPOSAL_TBL where  substr(office_code,2,2)=? AND substr(office_code,4,1)=? AND substr(office_code,5,2)=?";

		query3 = "select count(*) from RWS_WORK_PROPOSAL_TBL where substr(office_code,2,2)=? AND substr(office_code,4,1)=? AND substr(office_code,5,2)=?";
		query4 = "SELECT count(*) FROM RWS_NEW_EST_TBL where substr(office_code,2,2)=? AND substr(office_code,4,1)=? AND substr(office_code,5,2)=?";
		query5 = "SELECT count(*) FROM RWS_OM_EST_TBL  where substr(office_code,2,2)=? AND substr(office_code,4,1)=? AND substr(office_code,5,2)=?";


		ps = conn.prepareStatement(query);
		ps.setString(1,circleOfficeCode);
		ps.setString(2,divisionOfficeCode);
		ps.setString(3,subdivisionOfficeCode);

		ps1 = conn.prepareStatement(query1);
		ps1.setString(1,circleOfficeCode);
		ps1.setString(2,divisionOfficeCode);
		ps1.setString(3,subdivisionOfficeCode);

		ps2 = conn.prepareStatement(query2);
		ps2.setString(1,circleOfficeCode);
		ps2.setString(2,divisionOfficeCode);
		ps2.setString(3,subdivisionOfficeCode);

		ps3 = conn.prepareStatement(query3);
		ps3.setString(1,circleOfficeCode);
		ps3.setString(2,divisionOfficeCode);
		ps3.setString(3,subdivisionOfficeCode);

		ps4 = conn.prepareStatement(query4);
		ps4.setString(1,circleOfficeCode);
		ps4.setString(2,divisionOfficeCode);
		ps4.setString(3,subdivisionOfficeCode);

		ps5 = conn.prepareStatement(query5);
		ps5.setString(1,circleOfficeCode);
		ps5.setString(2,divisionOfficeCode);
		ps5.setString(3,subdivisionOfficeCode);


	}

	for (int i =0; i <cstatus.length; i++)
	{
		if (!headOfficeCode.equals("0") && circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps.setString(1,cstatus[i]);	

		}
		else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps.setString(2,cstatus[i]);	
		}
		else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && !divisionOfficeCode .equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps.setString(3,cstatus[i]);	
		}
		else
		{
			ps.setString(4,cstatus[i]);	
		}

		rs = ps.executeQuery();

		//System.out.println(query);

		if (rs.next())
		{
%>
		<tr>
		<td class="mystyle1"><%=cstatus[i]%></td>
		<td class="mystyle1" align=right><%=rs.getInt(1)%></td>
		<%
			totalHab = totalHab + rs.getInt(1);
		%>
		</tr>
<%
		}
	}
	
%>
		<tr><td class="mystyle1">Total Habitations</td>
		<td class="mystyle1" align=right><%=totalHab%></td>
		</tr>
		</table>
</td>

<%
		rs2 = ps2.executeQuery();
		if (rs2.next())
		{
			repNo = rs2.getInt(1);
		}
		rs2.close();

		rs3 = ps3.executeQuery();
		if (rs3.next())
		{
			propNo = rs3.getInt(1);
		}
		rs3.close();
		rs4 = ps4.executeQuery();
		if (rs4.next())
		{
			newEstNo = rs4.getInt(1);
		}
		rs4.close();
		rs5 = ps5.executeQuery();
		if (rs5.next())
		{
			omEstNo = rs5.getInt(1);
		}
		rs5.close();


%>

<td align="bottom">
<center><IMG SRC="<rws:context page='/images/rws.gif'/>" WIDTH="40" HEIGHT="50" BORDER="0" ALT="">
</center>
</td>

<td>
		<table border=1 style="border-collapse:collapse" align=right>
			<tr bgcolor=lavander>
		<td class="mystyle1">Slno</td>
		<td class="mystyle1" colspan=2 >Work Stage</td>
		<td class="mystyle1">No Of Works</td>
	</tr>
	
	<tr>
		<td class="mystyle1">1</td>
		<td class="mystyle1" colspan=2>Representations</td>
		<td class="mystyle1" colspan=2><%=repNo%></td>
	</tr>
	<tr>
		<td rowspan=2 class="mystyle1">2</td>
		<td rowspan=2 class="mystyle1">Proposals</td>
		<td class="mystyle1">New</td>
		<td class="mystyle1"><%=propNo%></td>
	</tr>
	<tr>
		<td class="mystyle1">O&M</td>
		<td class="mystyle1">--</td>
	</tr>
		
	<tr>
		<td rowspan=2 class="mystyle1">3</td>
		<td rowspan=2 class="mystyle1">Estimate Preparation</td>
		<td class="mystyle1">New</td>
		<td class="mystyle1"><%=newEstNo%></td>
	</tr>
	<tr>
		<td class="mystyle1">O&M</td>
		<td class="mystyle1"><%=omEstNo%></td>
	</tr>
	<tr>
		<td class="mystyle1">4</td>
		<td class="mystyle1" colspan=2>Contractor Management</td>
		<td class="mystyle1" colspan=2>--</td>
	</tr>
	<tr>
		<td class="mystyle1">5</td>
		<td class="mystyle1" colspan=2>Works Monitoring</td>
		<td class="mystyle1" colspan=2>--</td>
	</tr>
	<tr>
		<td class="mystyle1">6</td>
		<td class="mystyle1" colspan=2>Works Completed</td>
		<td class="mystyle1" colspan=2>--</td>
	</tr>
</table>
</td>
</tr>

<tr>
<td>

	<table border=1 style="border-collapse:collapse">
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="2">
			<font color="ffffff">Asset  Status </font></td>
	</tr>

	<tr>
	<td class="mystyle1">Asset Type</td>
	<td class="mystyle1">No. of Assets</td>	
	</tr>		<%
	for (int i =0; i <assetType.length; i++)
	{
		if (!headOfficeCode.equals("0") && circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps1.setString(1,assetType[i]);	

		}
		else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && divisionOfficeCode.equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps1.setString(2,assetType[i]);		
		}
		else if (!headOfficeCode.equals("0") && !circleOfficeCode.equals("00") && !divisionOfficeCode .equals("0") && subdivisionOfficeCode.equals("00"))
		{
			ps1.setString(3,assetType[i]);		
		}
		else
		{
			ps1.setString(4,assetType[i]);		
		}

		rs1 = ps1.executeQuery();

		//System.out.println(query1);

		if (rs1.next())
		{
%>			
		 <tr>
		
		<td class="mystyle1"><%=rs1.getString("TYPE_OF_ASSET_CODE")%></td>
		<td class="mystyle1" align=right><%=rs1.getInt(1)%></td>
		</tr>
<%
		totalAssets = totalAssets + rs1.getInt(1);
		}
		rs1.close();

	}

%>
	<tr><td class="mystyle1">Total Assets</td>
	<td class="mystyle1" align=right><%=totalAssets%></td>
	</tr>
</tr> 
</table>
</td>
</tr>
</table>
<%

}
catch(Exception e)
{
	//System.out.println(e);
}
	
	conn.close();


%>