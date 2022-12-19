<%@ page contentType="application/vnd.ms-excel" %>

<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%
  Statement stmt1=null;
  ResultSet rs=null;
  HashMap results=(HashMap)session.getAttribute("results");
String dname=(String)session.getAttribute("dname");
 String fromdate=(String)session.getAttribute("fromdate");
String todate=(String)session.getAttribute("todate");		
 %>
<html:html>
<HEAD>
<TITLE></TITLE>
</HEAD>
<form>
<table border=1 cellspacing=0 cellpadding=0 width="50"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"><%=dname %>
		DISTRICT WATER QUALITY PROFILE FOR LAB TESTING ---- <%=fromdate %> To
		<%=todate %></td>
	</tr>

</table>

<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="50" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext rowspan=2 width="10">Sl.No</td>
		<td class=btext rowspan=2>Mandal</td>
		<td class=btext rowspan=2>Total No Of Sources</td>
		<td class=btext rowspan=2>No Of Sources Tested</td>
		<td class=btext colspan=6 nowrap>No.of Sources with Single Excess
		Chemical Contaminants</td>
		<td class=btext rowspan=2>No. of Souces with Bacteriological
		Contaminants (Faecal Coliform)</td>
<td class=btext rowspan=2>No. of Sources with Multiple Excess
		Contaminants</td>
<!-- 		<td class=btext rowspan=2>No.of Sources with other Contaminants</td>   -->


	</tr>
	<tr>
		<td class=btext>IRON</td>
		<td class=btext>FLUORIDE</td>
		<td class=btext>TDS</td>
		<td class=btext>NITRATE</td>
		<td class=btext>Salinity</td>
		<td class=btext>OTHER<br>(Alkalinity<br>Chlorides<br>Sulphates)</td>

	</tr>

<%
  try{
  int sno=1;
    int tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0;
       stmt1=conn.createStatement();
		String mainQuery=(String)session.getAttribute("mainQuery");
		rs = stmt1.executeQuery(mainQuery);
		while(rs.next())
		{
					String data=(String)results.get(rs.getString(1));
					String res[]=data.split("@");
					tot1+=Integer.parseInt(res[0]);
					tot2+=Integer.parseInt(res[1]);	
					tot3+=Integer.parseInt(res[2]);
					tot4+=Integer.parseInt(res[3]);
					tot5+=Integer.parseInt(res[4]);	
					tot6+=Integer.parseInt(res[5]);
					tot7+=Integer.parseInt(res[6]);
					tot8+=Integer.parseInt(res[7]);
				tot9+=Integer.parseInt(res[8]);
				tot10+=Integer.parseInt(res[9]);
				
				
			   %>
				
		<tr>
		<td width="10"><%= sno++ %></td>
		<td class="btext"><%= rs.getString(2)%></td>
		<td><%=res[0] %></td>
		<td><%= res[1] %></td>
		<td><%= res[2] %></td>
		<td><%= res[3] %></td>
		<td><%= res[4] %></td>
		<td><%=res[5] %></td>
		<td><%=res[6] %></td>
		<td><%=res[7] %></td>
		<td><%= res[8] %></td>
		<td><%= res[9] %></td>
		
</tr>

<%
		}
%>
		<tr>
		<td colspan=2 class=btext align=right>Total:</td>
		<td><%=tot1 %></td>
		<td><%= tot2 %></td>
		<td><%= tot3 %></td>
		<td><%= tot4 %></td>
		<td><%= tot5 %></td>
		<td><%=tot6 %></td>
		<td><%=tot7 %></td>
		<td><%=tot8 %></td>
		<td><%= tot9 %></td>
		<td><%= tot10 %></td>
		
</tr>


<% 

}catch(Exception e){
		e.printStackTrace();
}

 %>
</table>
</form>

</html:html>
