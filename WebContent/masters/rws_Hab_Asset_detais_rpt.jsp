<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<html>
<%
	String scpop = request.getParameter("scpop");
	String stpop = request.getParameter("stpop");
	String plpop = request.getParameter("plpop");
%>
<script>

function fnAsset(index,type,hab)
{
   var pop;
   if(type=="SC")
    { pop='<%=scpop%>'; }
   else if(type=="ST")
	{
	    pop='<%=stpop%>';
	}
	 else if(type=="MT")
	{
	    pop='<%=plpop%>';
		}
		var zURL = "./rws_Hab_locality_pop.jsp?assetcode=" + index + "&type="
				+ type + "&hab=" + hab + "&pop=" + pop;
		var popFeatures = "width=800,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		newwin = window.open(zURL, 'Assets', popFeatures);
		if (window.focus) {
			newwin.focus()
		}
		return false;
	}

	function fnAssetSave(index) {
		var checkchoice = 0;
		for (var i = 1; i <= index; i++) {
			if (document.getElementById('check[' + i + ']').checked) {
				checkchoice++;
			}
		}
		if (checkchoice == 0) {
			alert("Please Select At least One Checkbox");
			return false;
		} else {
			document.forms[0].action = "switch.do?prefix=/masters&page=/HabSCST.do?mode=assetSave";
			document.forms[0].submit();

		}
	}
</script>

<form method="post">
	<table>
		<tr>
			<td class=btext>Habitation:<%=request.getParameter("habcode")%>-<%=request.getParameter("habname")%></td>
		</tr>
	</table>
	<table border=0 cellspacing=0 cellpadding=0 width=100%
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" align="center">
		<tr>
			<td bgcolor="#8A9FCD"><font face=verdana color="#000000"
				size="2"><B>Asset Details List</B></font></td>
		</tr>
		<table border=1 cellspacing=0 cellpadding=0 width=100%
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff">
			<tr>
				<td class=btext>Sl.No</td>
				<td class=btext>Asset Code</td>
				<td class=btext>Asset Name</td>
				<td class=btext>Asset Location</td>
				<td class=btext>Asset Created Date</td>
				<td class=btext>Asset Status</td>
				<td class=btext>Asset Cost</td>
				<td class=btext>SC <br>Localities
				</td>
				<td class=btext>ST <br>Localities
				</td>
				<td class=btext>Minority <br>Localities
				</td>

			</tr>
			<%
				Statement stmt1 = null, stmt2 = null, stmt3 = null;
				ResultSet rs1 = null, rs2 = null, rs3 = null;
				String hab = request.getParameter("habcode");
				String habname = request.getParameter("habname");
				int sno = 0;
				String qry = " select  b.scheme_code,asset_name,location,to_char(date_creation,'dd/mm/yyyy'),decode(Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),"+
									"asset_cost,a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b where a.asset_code=b.asset_code and hab_code=? ";
				ps = conn.prepareStatement(qry);
				ps.setString(1, hab);
				rs = ps.executeQuery();
				while (rs.next()) {
			%>
			<tr>
				<td class=rptvalue><%=++sno%></td>
				<td class=rptvalue><%=rs.getString(1)%></td>
				<td class=rptvalue><%=rs.getString(2)%></td>
				<td class=rptvalue><%=rs.getString(3)%></td>
				<td class=rptvalue><%=rs.getString(4)%></td>
				<td class=rptvalue><%=rs.getString(5)%></td>
				<td class=rptvalue align="right"><%=rs.getString(6)%></td>
				<%
					String qry1 = "select (select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=?  and substr(locality_code,1,2)='SC'),"
								+ "(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=?  and substr(locality_code,1,2)='ST'),"
								+ "(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=?  and substr(locality_code,1,2)='MT') from dual ";
						ps = conn.prepareStatement(qry1);
						ps.setString(1, hab);
						ps.setString(2, hab);
						ps.setString(3, hab);
						rs1 = ps.executeQuery();
						int val = 0, val1 = 0, val2 = 0;
						if (rs1.next()) {
							val = rs1.getInt(1);
							val1 = rs1.getInt(2);
							val2 = rs1.getInt(3);
						}
				%>
				<td class=rptvalue align="center"><%=val%>&nbsp;<input
					type=button name="button1" title="Click to Enter Asset Details"
					Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;"
					onclick="fnAsset('<%=rs.getString(7)%>','SC','<%=hab%>')" /></td>
				<td class=rptvalue align="center"><%=val1%>&nbsp;<input
					type=button name="button1" title="Click to Enter Asset Details"
					Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;"
					onclick="fnAsset('<%=rs.getString(7)%>','ST','<%=hab%>')" /></td>
				<td class=rptvalue align="center"><%=val2%>&nbsp;<input
					type=button name="button1" title="Click to Enter Asset Details"
					Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;"
					onclick="fnAsset('<%=rs.getString(7)%>','MT','<%=hab%>')" /></td>
			</tr>
			<%}
if(sno==0){%>
			<tr>
				<td class=rptvalue colspan=10 align="center">No Assets In This
					Habitation</td>
			</tr>
			<%}
%>
		</table>
		</form>
		</html>