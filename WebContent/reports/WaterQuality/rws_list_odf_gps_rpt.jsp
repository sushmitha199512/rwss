<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file = "/reports/conn.jsp" %>

<html>

<%

		DecimalFormat ndf = new DecimalFormat("##.##");
		int sno = 1;
		int habTotal = 0;
		int contaminatedHabCount = 0;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
		PreparedStatement pstmt1 = null, pstmt2 = null, pstmt3 = null, pstmt4 = null, pstmt5 = null;

		String dcode = request.getParameter("rDistrict");

		String dname = request.getParameter("rDistrictName");

		String type = request.getParameter("type");

		Calendar cal = Calendar.getInstance();
		String year = "" + cal.get(Calendar.YEAR);
		%>
<form>
<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	<caption>
	<table border=0 rules=none style="border-collapse:collapse"
		align="right">
		<tr>
			<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home
			| </a></td>
		</tr>
	</table>
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"><%=dname%> GRAM PANCHAYAT-LPCD </td>
	</tr>


</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext>Sl.No</td>
		<td class=btext>District</td>
		<td class=btext>Mandal</td>
		<td class=btext>Panchayat</td>
		<td class=btext>Present level of Water Supply in LPCD</td>
		

	</tr>

	<%

		try {
			Calendar rightNow = Calendar.getInstance();
			int pyear = rightNow.get(Calendar.YEAR);
			HashMap popHash = new HashMap();
			HashMap suplyHash = new HashMap();
			String mainQuery = "";
			if (dname != null && dname.equals("ALL")) {
				mainQuery = "select  dcode,dname from rws_district_tbl";
			} else {
				mainQuery = "select d.dname,c.mname,e.pname,d.dcode,c.mcode,e.pcode from rws_mandal_tbl c,rws_district_tbl d ,RWS_PANCHAYAT_TBL e where d.dcode= c.dcode and d.dcode= e.dcode and e.mcode=c.mcode and e.dcode=d.dcode and d.dcode=?";
			}

			//String popQuery = "select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU++FLOAT_POP+CENSUS_MINORITY_POPU),hab_code from RWS_HABITATION_DIRECTORY_TBL group by hab_code";

			//stmt2 = conn.prepareStatement(popQuery);

			String habq = "select sum(nvl(CENSUS_PLAIN_POPU,'0')+nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0')+nvl(FLOAT_POP,'0')+nvl(CENSUS_MINORITY_POPU,'0')),hab_code,CENSUS_YEAR  from RWS_HABITATION_DIRECTORY_TBL where substr(hab_code,1,2)=? and substr(hab_code,6,2)=? and substr(hab_code,13,2)=? and coverage_status<>'UI'  group by hab_code,CENSUS_YEAR";

			pstmt4 = conn.prepareStatement(habq);

			//rs2=pstmt2.executeQuery();
			//while(rs2.next()){
			//popHash.put(rs2.getString(2),rs2.getString(1));
			//}

			String supplyQuery = "select sum(nvl(hps_oth_supply,'0')+nvl(pws_supply,'0')+nvl(mpws_supply,'0')+nvl(cpws_supply,'0')+nvl(ows_oth_supply,'0')+nvl(ponds_oth_supply,'0')+nvl(shp_dk_supply,'0')+nvl(others_supply,'0')+nvl(SHP_DK_SUPPLY_SAFE,'0')),hab_code from rws_hab_supply_status_tbl  group by hab_code";

			pstmt3 = conn.prepareStatement(supplyQuery);

			rs3 = pstmt3.executeQuery();
			while (rs3.next()) {
				suplyHash.put(rs3.getString(2), rs3.getString(1));
			}

			pstmt1 = conn.prepareStatement(mainQuery);
			pstmt1.setString(1, dcode);

			double pop = 0.0, wsupply = 0.0, popsum = 0.0;
			rs1 = pstmt1.executeQuery();

			while (rs1.next()) {
				pstmt4.setString(1, rs1.getString(4));
				pstmt4.setString(2, rs1.getString(5));
				pstmt4.setString(3, rs1.getString(6));

				rs4 = pstmt4.executeQuery();

				while (rs4.next()) {

					//     System.out.println("Year"+pyear);

					if (rs4.getString(1) != null
							&& !rs4.getString(1).equals("null")) {
						pop = Double.parseDouble(rs4.getString(1));
					}
         // System.out.print("Before Population:"+pop);

					if (rs4.getString(3) != null
							&& !rs4.getString(3).equals("null")) {
						pop = pop
								* Math.pow(1.02, Double.parseDouble(""
										+ (pyear - Integer.parseInt(rs4
												.getString(3)))));
					}
         // System.out.print("After Population:"+pop);

					popsum += pop;
					if (rs4.getString(2) != null
							&& !rs4.getString(2).equals("null")) {
						String data1 = (String) suplyHash.get(rs4.getString(2));
//System.out.print("habcode"+rs4.getString(2));
 //   System.out.print("Safe supply"+data1);
						if (data1 != null) {
							wsupply += Double.parseDouble(data1);
						}
					}
				}

 //System.out.print("Wsuplly:"+wsupply);
 //System.out.print("TotPop:"+popsum);


				double result = wsupply / popsum;

				%>

	<tr>
		<td class=rptvalue><%=sno++%></td>
		<td class=rptvalue><%=rs1.getString(1)%></td>
		<td class=rptvalue><%=rs1.getString(2)%></td>
		<td class=rptvalue><%=rs1.getString(3)%></td>
		<td class=rptvalue><%= ndf.format(result)%></td>
	
	</tr>

	<%
				wsupply = 0;
				popsum = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	%>

</table>
</html>
