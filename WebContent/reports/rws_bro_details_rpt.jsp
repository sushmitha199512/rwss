
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
Statement stmt1=null;
ResultSet rs1=null;
String broid=request.getParameter("bro_id");
stmt=conn.createStatement();
stmt1=conn.createStatement();
%>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=btext  align="center"> Bro Id:&nbsp;<%=broid%></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" align="center" >

<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Program</td>			
			<td class=btext>Sub Program</td>
			<td class=btext>Head Of Account </td>
			<td class=btext>Budget Estimate</td>
			<td class=btext>Amount Now Authorised</td>			
			
			</tr>

<%
int count=0;
String qry="SELECT BRO_ID,bro_det.PROGRAMME_CODE,HEAD_OF_ACCOUNT,BUDGET_ESTIMATE,B_E_YEAR,bro_det.quarter,AMT_ALREADY_AUTH,nvl(AMT_NOW_AUTH,'0')AMT_NOW_AUTH,PROCEDURE_OF_DRAWAL,DRAWING_OFFICER,REMARKS,sp.SUBPROGRAMME_CODE,CENTER_STATE,p.programme_name,sp.SUBPROGRAMME_NAME  from rws_bro_details_tbl bro_det,rws_programme_tbl p,rws_subprogramme_tbl sp  where bro_id='"+broid+"' and bro_det.programme_code=p.programme_code and bro_det.PROGRAMME_CODE=p.programme_code and  bro_det.programme_code=sp.programme_code and bro_det.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE  ";
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("programme_name")%></td>
<td class=rptValue><%=rs.getString("subprogramme_name")%></td>
<td class=rptValue><%=rs.getString("head_of_account")%></td>
<td class=rptValue><%=rs.getString("BUDGET_ESTIMATE")%></td>
<td class=rptValue align="right"><%=rs.getString("AMT_NOW_AUTH")%></td>
</tr>
<% } 
%>
</table>