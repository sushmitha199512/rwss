<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>
<html>
<style>
#input_box {
	background-color: #C9DFF4;
	font-weight: bold;
}
</style>
<script language="javascript">
	function checkAll() {
		var count = document.getElementById("resultCount").value;
		for (i = 1; i < count; i++) {
			document.getElementById('check' + i).checked = true;
		}
	}
	function unCheckAll() {
		var count = document.getElementById("resultCount").value;
		for (i = 1; i < count; i++) {
			document.getElementById('check' + i).checked = false;
		}
	}
	function fnClose() {
		document.forms[0].action = "/pred/home.do";
		document.forms[0].submit();
	}
	function fnNext() {
		var count = document.getElementById("resultCount").value;
		var flag = false;
		var i = 0;
		for (i = 1; i < count; i++) {
			if (document.getElementById('check' + i).checked) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			alert("Please Select Atleast One Contractor For Payment");
			return;
		}
		if (confirm("Are you sure Confirm to Payment for Selected Contractor")) {
			string 
			//document.forms[0].action = "./masters/rws_bill_release_to_bank_division.jsp";
			document.forms[0].action = "./rws_bill_release_to_bank_division.jsp";

			document.forms[0].submit();
		}
	}
</script>
<link rel="stylesheet" type="text/css"
	href="<rws:context page='/resources/style/table.css'/>">
<body bgcolor="#edf2f8">
	<form method="post">
		<table border=0>
			<caption>
				<table border=0 width="960px" rules=none
					style="border-collapse: collapse" align="right">
					<tr>
						<td align="right" class="bwborder"><a href="/pred/home.jsp">My	Home</a></td>
					</tr>
				</table>
			</caption>
		</table>
		
		<%
			try {
				boolean flag = false;
				Hashtable contractHash = null;
				if (session.getAttribute("contractHash") != null) {
					contractHash = (Hashtable) session.getAttribute("contractHash");
					flag = true;
				} else {
					contractHash = new Hashtable();
				}
				if (!flag) {
					Statement stmtN = conn.createStatement();
					String contractorSel = "select a.work_id,a.contractor_code,nvl(CONTRACTOR_NAME_COMPANY,'') as c1,nvl(CONTRACTOR_COMPANY_NAME1,'') c2,nvl(PAN_NO,'-') as panNO,nvl(VOTER_ID,'-') as voterNo  from rws_contractor_selection_tbl a,rws_work_admn_tbl b,rws_contractor_tbl c  where a.work_id=b.work_id and a.contractor_code=c.contractor_code";
					ResultSet rsN = stmtN.executeQuery(contractorSel);
					while (rsN.next()) {
						contractHash.put(rsN.getString(1), rsN.getString(2) + "@" + rsN.getString(3) + "@"
								+ rsN.getString(4) + "@" + rsN.getString(5) + "@" + rsN.getString(6));
					}
					session.setAttribute("contractHash", contractHash);
					if (stmtN != null) {
						stmtN.close();
					}
					if (rsN != null) {
						rsN.close();
					}
				} 
				String qry = "select CIRCLE_OFFICE_NAME ,DIVISION_OFFICE_NAME ,w.WORK_ID,w.work_name,BILL_SL_NO ,BILL_AMOUNT_CENTRAL  from  rws_bill_bank_bridge_temp_tbl a, rws_work_admn_tbl w,rws_circle_office_tbl co,rws_division_office_tbl div  where  w.work_id=a.work_id  and substr(a.office_code,2,2)=co.circle_office_code and div.circle_office_code=co.circle_office_code and substr(a.office_code,4,1)=div.division_office_code";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(qry);
				int count = 1;
		%>
		<table border=1 width="80%" align=center bordercolor=black
			style="border-collapse: collapse">
			<tr>
				<td colspan="9" align="right"><a href="#" onclick="checkAll()">Check All</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="unCheckAll()">UnCheck All</a></td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>Sl. No.</td>
				<td class=gridhdbg>Circle</td>
				<td class=gridhdbg>Division</td>
				<td class=gridhdbg>Work_id/Work Name</td>
				<td class=gridhdbg>Contractor&nbsp;Code</td>
				<td class=gridhdbg>Contractor&nbsp;Name</td>
				<td class=gridhdbg>PAN NO/VOTER ID</td>
				<td class=gridhdbg>Amount</td>
				<td class=gridhdbg>Select</td>
			</tr>
			<%
				String val = "";
					int styleCount = 0;
					String style = "";
					while (rs.next()) {
						StringBuffer conName = new StringBuffer();
						String cRec = (String) contractHash.get(rs.getString("work_id"));
						String cCode = "", voterId = "", panNo = "";
						if (cRec != null && !cRec.equals("null")) {
							String vals[] = cRec.split("@");
							cCode = vals[0];
							panNo = vals[3];
							voterId = vals[4];
							conName.append(vals[1]);
							if (vals[2] != null && !vals[2].equals("null")) {
								conName.append(vals[2]);
							}
						}
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
			%>
			<tr>
				<td class=<%=style%> style="text-align: left;"><%=count++%></td>
				<td class=<%=style%> style="text-align: left;"><%=rs.getString(1)%></td>
				<td class=<%=style%> style="text-align: left;"><%=rs.getString(2)%></td>
				<td class=<%=style%> style="text-align: left;"><%=rs.getString(3)%><br></br><%=rs.getString(4)%></td>
				<td class=<%=style%> style="text-align: left;"><%=cCode%></td>
				<td class=<%=style%> style="text-align: left;"><%=conName%></td>
				<td class=<%=style%> style="text-align: left;"><%=panNo%> /<%=voterId%></td>
				<td class=<%=style%> style="text-align: right;"><%=rs.getString(6)%></td>
				<td class=<%=style%> style="text-align: left;">
				<input type=checkbox  name="check<%=count - 1%>" 	value='<%=rs.getString(3) + "@" + rs.getString(5)%>'></td>
			</tr>
			<%
			}
					if (count == 1) {
			%>
			<tr>
				<td colspan="9" class="rptValue" align="center">No Records</td>
				</td>
			</tr>
			<%
				}
			%>
			<input type="hidden" name="resultCount" value="<%=count%>">
		</table>
		<BR>
		<table align="center">
			<%
				if (count >= 1) {
			%>
			<tr>
				<td align="center"><input type=button name=getValues1
					value="Close" onclick="fnClose()">&nbsp;&nbsp; <input
					type=button name=getValues2 value="Next" onclick="fnNext()"
					id=fnSavve></td>
			</tr>
			<%
				}
			%>
		</table>
		<%
			} catch (Exception e) {
				System.out.println("Exception at rws_contractor_sel_payment file"+e);
			//	e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (stmt != null)
						stmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception eee) {
					System.out.println("Exception at rws_contractor_sel_payment file in finally block: "+eee);
					//eee.getMessage();
				}
			}
		%>
	</form>
</body>
<br></br>
<p align=center class="pageFooter">
	<%@ include file="/commons/rws_footer.jsp"%>
</p>
</html>