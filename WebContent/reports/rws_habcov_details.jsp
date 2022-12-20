<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<style>
tr.even {
  background-color: #ddd;
  width:20px;
  height:15px;   
}
tr.odd {
  background-color: #eee;
  width:20px;
  height:15px;
  }
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
<table width="120%"  align="center"><tr><td align=right><a href="javascript:onClick=window.close()">Close</a></td></tr></table>
<table border = 1 cellspacing = 0 cellpadding = 0  width="70%"  bordercolor=#000000 style="border-collapse:collapse" class="striped" >
<tr><td colspan=7 class=btext align="center">Coverage Status:<%=request.getParameter("status")%></td>
</tr>
<tr>
 <td class=btext>Sl.No</td>
 <td class=btext>District</td>
 <td class=btext>Mandal</td>
 <td class=btext>Panchayat</td>
 <td class=btext>Village</td>
 <td class=btext>Hab Code</td>
 <td class=btext>Habitation</td>
</tr>
<%int cnt=1;
String catCode = request.getParameter("catCode");
String finYear = request.getParameter("finyear");
DecimalFormat ndf = new DecimalFormat("####.00");
	int year = Calendar.getInstance().get(Calendar.YEAR); 
	String yr=Integer.toString(year);
String qry=" select dname,mname,pname,vname,panch_code,panch_name from rws_complete_hab_view a,rws_admn_hab_lnk_tbl b,rws_work_admn_tbl c,rws_aap_selected_tbl d where a.panch_code=b.hab_code and c.work_id=b.work_id and d.work_id=b.work_id  and d.fin_year='"+finYear+"' and coverage_status='"+request.getParameter("status")+"' ";
//and work_cancel_dt is null  and c.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))
if(request.getParameter("dcode")!=null && !request.getParameter("dcode").equals("dist"))
{
qry+=" and a.dcode='"+request.getParameter("dcode")+"'  ";
}	
if(catCode!=null && !catCode.equals("") && catCode.equals("1"))
 {
	 qry+= " and  category_code='"+catCode+"' ";
 }
  if(catCode!=null && !catCode.equals("") && catCode.equals("2"))
 {
	 qry+= " and  category_code='"+catCode+"' ";
 }
  if(catCode!=null && !catCode.equals("") && catCode.equals("3"))
 {
	 qry+= " and  category_code='"+catCode+"' ";
 }
qry+= "order by dname,mname,pname,vname,panch_name";

try{

stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{%>
<tr>
<td class=rptvalue><%=cnt++%></td>
<td class=rptvalue nowrap><%=rs.getString(1)%></td>
<td class=rptvalue nowrap><%=rs.getString(2)%></td>
<td class=rptvalue nowrap><%=rs.getString(3)%></td>
<td class=rptvalue nowrap><%=rs.getString(4)%></td>
<td class=rptvalue nowrap><%=rs.getString(5)%></td>
<td class=rptvalue nowrap><%=rs.getString(6)%></td>
</tr>
<%}

}catch(Exception e){e.printStackTrace();}
%>
</table>
<%@ include file = "/reports/connClose1.jsp" %>