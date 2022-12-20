
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp" %>
<%
 //System.out.println("in rws ftk test rpt.jsp");
//String ftkid=(String)session.getAttribute("ftktestid");
String ftktestid=request.getParameter("ftktestid");
// System.out.println("FTKTESTID:"+ ftktestid);

java.util.ArrayList wqlist = new java.util.ArrayList();
wqlist = (java.util.ArrayList)request.getAttribute("testResults");


if(wqlist==null || wqlist.size()<1)
{ //System.out.println("haiiiiiii"+wqlist.size());
	wqlist = new java.util.ArrayList(18);
	for(int i=0;i<18;i++)
	{
		wqlist.add(i,"N");
	}
	
  } else {

System.out.println("hai"+wqlist.size());
}
 %>
<html>
<HEAD>
<script>
function update()
{
alert(document.forms[0].tpv0.value);
}
</script>
</HEAD>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			<tr bgcolor="#8A9FCD">
				<td colspan="15" class="bwborder">
					<font color='000000'>FTK Test Results for FtkTestid :<%=ftktestid%></font>
				</td>
			</tr>

<BODY><br><br>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
			<tr>
				<td class="textborder" style="width:175px">&nbsp;</td>
				<td class="textborder" style="width:125px" >Chemical</td>
				<td class="textborder"  style="width:255px">Bacteriological</td>
				<td class="textborder"  style="width:175px">Physical</td>
				<td class="textborder"  style="width:175px">Other Chemical</td>
			</tr>
			<tr>

	<tr>
				<td class="textborder" style="width:175px">Contamination&nbsp;Found&nbsp;with&nbsp;FTK&nbsp;:</td>
				<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
						
						<%if(wqlist!=null && wqlist.get(2).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic" checked >Arsenic</td>
						<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Arsenic">Arsenic</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(3).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate" checked>Nitrate</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Nitrate">Nitrate</td>
							<%} %>
						 </tr>
						<tr> 
							<%if(wqlist!=null && wqlist.get(4).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride" checked>Fluoride</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Fluoride">Fluoride</td>
							<%}%>
							<%if(wqlist!=null && wqlist.get(5).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity" checked>Salinity</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Salinity">Salinity</td>
							<%} %>
						</tr>
						<tr><td></td>
							<%if(wqlist!=null && wqlist.get(6).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="che" value="Iron" checked>Iron</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="che" value="Iron">Iron</td>
							<%} %>
							
				
			</tr>
			</table> <%if(wqlist!=null && wqlist.get(7).equals("Y")){ %>
				<td class="textborder" ><input type="checkbox" name="bat" value="ColiForm" checked>Microbiological &nbsp;&nbsp;&nbsp;&nbsp; contamination</td>
				<%} else{%>
				<td class="textborder" ><input type="checkbox" name="bat" value="ColiForm">Microbiological &nbsp;&nbsp;&nbsp;&nbsp; contamination</td>
				<%} %>
				<%if(wqlist!=null && wqlist.get(8).equals("Y")){ %>
				<td class="textborder" ><input type="checkbox" name="phy" value="Turbidity" checked>Turbidity</td>
				<%} else{%>
				<td class="textborder" ><input type="checkbox" name="phy" value="Turbidity">Turbidity</td>
				<%} %>
				<td><table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;" >
				<%if(wqlist!=null && wqlist.get(9).equals("Y")){ %>
					<td class="textborder"><input type="checkbox" name="oth" value="Chlorides" checked>Chlorides</td>
					<%} else{%>
					<td class="textborder"><input type="checkbox" name="oth" value="Chlorides">Chlorides</td>
					<%} %>
			   <%if(wqlist!=null && wqlist.get(10).equals("Y")){ %>
					<td class="textborder"><input type="checkbox" name="oth" value="Manganese" checked>Manganese</td>
					<%} else{%>
					<td class="textborder"><input type="checkbox" name="oth" value="Manganese">Manganese</td>
					<%} %>
					</tr>
					<tr>
					<%if(wqlist!=null && wqlist.get(11).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Sulphates" checked>Sulphates</td>
						<%} else{%>
						<td class="textborder"><input type="checkbox" name="oth" value="Sulphates">Sulphates</td>
						<%}%>
					<%if(wqlist!=null && wqlist.get(12).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Copper" checked>Copper</td>
						<%} else{%>
					    <td class="textborder"><input type="checkbox" name="oth" value="Copper">Copper</td>
						<%} %>
						</tr>
						<tr>
					<%if(wqlist!=null && wqlist.get(13).equals("Y")){ %>
						<td class="textborder"><input type="checkbox" name="oth" value="Calcium" checked>Calcium</td>
						<%} else{%>
						<td class="textborder"><input type="checkbox" name="oth" value="Calcium">Calcium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(14).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="TDS" checked>TDS</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="TDS">TDS</td>
							<%} %>
							
					</tr>
			<tr>
							<%if(wqlist!=null && wqlist.get(15).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="Magnesium" checked>Magnesium</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="Magnesium">Magnesium</td>
							<%} %>
							<%if(wqlist!=null && wqlist.get(16).equals("Y")){ %>
							<td class="textborder"><input type="checkbox" name="oth" value="Hardness" checked>Hardness</td>
							<%} else{%>
							<td class="textborder"><input type="checkbox" name="oth" value="Hardness">Hardness</td>
							<%} %>
							
				
			</tr>
				</table>
				
				</td>
				</tr>
				</table>
				</BODY>
				</table>
				</html>
				
