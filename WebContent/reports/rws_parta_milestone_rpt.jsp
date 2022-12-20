
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
try{
String workid=request.getParameter("workid");
String workName=request.getParameter("workName");

stmt=conn.createStatement();
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptValue> </td></tr></table>

<table bgcolor="#FFFFFF" width="100%" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" >
<caption>
<%=workid %>-<%=workName %>
</caption>
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Name</td>
			<td class=btext>Amount(In Rupees)</td>
			</tr>

<%
int count=0;
String q="select LANDAQUISITIONCHRG,waterDrawlPermissionChrg,railwayCrossingPermissionChrg,roadCrossingPermissionChrg,roadCrossingPermissionNHAIChrg,forestClearanceChrg,POWERAPTRANSCOCHRGS ,hmwsChrgs,othersChrg,groundWaterInvestigationChg,yieldTestingChg,sourceCreationChg,dprCharges from rws_notgroundworks_status_tbl where work_id='"+workid+"'";
ResultSet rss=stmt.executeQuery(q);
int totCharges=0;
while(rss.next())
{ 
  if(rss.getString(1)!=null && !rss.getString(1).equals("")){
totCharges+=Integer.parseInt(rss.getString(1));
    count+=1;
%>
  <tr><td><%=count %></td><td>Land acquisition 
</td><td class=rptValue align=right ><%=rss.getString(1) %></td></tr>
<% 

		}
if(rss.getString(2)!=null && !rss.getString(2).equals("")){
    count+=1;
totCharges+=Integer.parseInt(rss.getString(2));
%>
  <tr><td class=rptValue ><%=count %></td><td>Water drawal Permission</td><td align=right><%=rss.getString(2) %></td></tr>
<% 

		}
if(rss.getString(3)!=null && !rss.getString(3).equals("") && !rss.getString(3).equals("0")){
totCharges+=Integer.parseInt(rss.getString(3));
    count+=1;
%>
  <tr><td><%=count %></td><td>Railway crossing
</td><td class=rptValue align=right><%=rss.getString(3) %></td></tr>
<% 

		}
if(rss.getString(4)!=null && !rss.getString(4).equals("") && !rss.getString(4).equals("0")){
totCharges+=Integer.parseInt(rss.getString(4));
    count+=1;
%>
  <tr><td><%=count %></td><td>Road crossing (State Highway)
</td><td class=rptValue align=right><%=rss.getString(4) %></td></tr>
<% 

		}
if(rss.getString(5)!=null && !rss.getString(5).equals("") && !rss.getString(5).equals("0")){
totCharges+=Integer.parseInt(rss.getString(5));
    count+=1;
%>
  <tr><td><%=count %></td><td>Road crossing (NHAI)
</td><td class=rptValue align=right><%=rss.getString(5) %></td></tr>
<% 

		}
if(rss.getString(6)!=null && !rss.getString(6).equals("") && !rss.getString(6).equals("0")){
totCharges+=Integer.parseInt(rss.getString(6));
    count+=1;
%>
  <tr><td><%=count %></td><td>Forest Clearance 
</td><td class=rptValue align=right><%=rss.getString(6) %></td></tr>
<% 

		}
if(rss.getString(7)!=null && !rss.getString(7).equals("") && !rss.getString(7).equals("0")){
totCharges+=Integer.parseInt(rss.getString(7));
    count+=1;
%>
  <tr><td><%=count %></td><td>Power (AP Transco)
</td><td class=rptValue align=right><%=rss.getString(7) %></td></tr>
<% 

		}
if(rss.getString(8)!=null && !rss.getString(8).equals("") && !rss.getString(8).equals("0")){
totCharges+=Integer.parseInt(rss.getString(8));
    count+=1;
%>
  <tr><td><%=count %></td><td>HMWSSB
</td><td class=rptValue align=right><%=rss.getString(8) %></td></tr>
<% 

		}
if(rss.getString(9)!=null && !rss.getString(9).equals("") && !rss.getString(9).equals("0")){
totCharges+=Integer.parseInt(rss.getString(9));
    count+=1;
%>
  <tr><td><%=count %></td><td>Others
</td><td class=rptValue align=right><%=rss.getString(9) %></td></tr>
<% 

		}
if(rss.getString(10)!=null && !rss.getString(10).equals("") && !rss.getString(10).equals("0")){
totCharges+=Integer.parseInt(rss.getString(10));
    count+=1;
%>
  <tr><td><%=count %></td><td>Ground Water Investigation
</td><td class=rptValue align=right><%=rss.getString(10) %></td></tr>
<% 

		}
if(rss.getString(11)!=null && !rss.getString(11).equals("") && !rss.getString(11).equals("0")){
totCharges+=Integer.parseInt(rss.getString(11));
    count+=1;
%>
  <tr><td><%=count %></td><td>Yield Testing 
</td><td class=rptValue align=right><%=rss.getString(11) %></td></tr>
<% 

		}
if(rss.getString(12)!=null && !rss.getString(12).equals("") && !rss.getString(12).equals("0")){
totCharges+=Integer.parseInt(rss.getString(12));
    count+=1;
%>
  <tr><td><%=count %></td><td>Source Creation
</td><td class=rptValue align=right><%=rss.getString(12) %></td></tr>
<% 

		}
if(rss.getString(13)!=null && !rss.getString(13).equals("") && !rss.getString(13).equals("0")){
totCharges+=Integer.parseInt(rss.getString(13));
    count+=1;
%>
  <tr><td><%=count %></td><td>DPR Charges
</td><td class=rptValue align=right><%=rss.getString(13) %></td></tr>
<% 

		}
%>
<tr><td colspan=2 class=btext>Total:</td><td class=btext align=right><%=totCharges %></td></tr>
<%
 } 
}catch(Exception e){
e.printStackTrace();
}
%>
</table>