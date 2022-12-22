<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%
 String dcode=request.getParameter("district");
 String year=request.getParameter("year");
 String dname=request.getParameter("dname");
%>
<style>
tr.even {
  background-color: #ddd;
}
tr.odd {
  background-color: #eee;
}
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
				<a href="../home.jsp">Home</a>&nbsp;|&nbsp;
				<a href="./rws_work_probdate_xls.jsp?dcode=<%=dcode%>&year=<%=year%>&dname=<%=dname%>" target="_new">Excel</a>

			</td>
		</tr>
	</table>
</table>
<p><font face=verdana size=3 color=blue></font></p>
<font color="blue" face=verdana size=2>District:&nbsp;</font><font color="black" face=verdana size=2><%=dname%></font>&nbsp;<font color="blue" face=verdana size=2>Financial Year::&nbsp;</font><font color="black" face=verdana size=2><%=year%></font>

<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse"  class="striped">
 <tr><td class=btext colspan="10" align="center">Works Probable Date Details Report </td></tr>
			<tr  align=center>
			<td class=btext nowrap>Sl.No</td>
			<td class=btext>Program</td>
			<td class=btext>Subprogram</td>
			<td class=btext>Work ID</td>
			<td class=btext>Work Name</td>
			<td class=btext>No Of Habs</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Estimated Cost</td>
			<td class=btext>Probable Date of Completion</td>
			<td class=btext>Actual Date of Completion </td>
	</tr>

<%int sno=0;
ResultSet habrs=null,htrs=null,ht1rs=null;
Statement stmt2 = conn.createStatement();
Statement stmt3 = conn.createStatement();
Statement stmt4 = conn.createStatement();
habrs = stmt2.executeQuery("select count(*),work_id from RWS_ADMN_HAB_LNK_TBL  where substr(work_id,5,2)='"+dcode+"' group by work_id");
Hashtable hashtable = new Hashtable();
while(habrs.next())
{
	hashtable.put(habrs.getString(2),habrs.getString(1)); 
}
String qq="select  to_char(date_of_completion,'dd/mm/yyyy'),a.work_id from rws_work_completion_tbl  a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(office_code,2,2)='"+dcode+"'  and date_of_completion is not null ";
////System.out.println("qq:"+qq);
Hashtable ht = new Hashtable();
htrs = stmt3.executeQuery(qq);
while(htrs.next())
{
	ht.put(htrs.getString(2),htrs.getString(1)); 
}
String qq1="select  to_char(PROBABLE_DATE ,'dd/mm/yyyy'),a.work_id from rws_contractor_selection_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and substr(office_code,2,2)='"+dcode+"' and PROBABLE_DATE is not null ";
////System.out.println("qq:"+qq1);
Hashtable ht1 = new Hashtable();
ht1rs = stmt4.executeQuery(qq1);
while(ht1rs.next())
{
	ht1.put(ht1rs.getString(2),ht1rs.getString(1)); 
}
 String qry="select work_id,work_name,to_char(admin_date,'dd/mm/yyyy'),nvl(sanction_amount,'0'),programme_name,subprogramme_name  from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s  where p.programme_code=s.programme_code and a.programme_code=p.programme_code and a.subprogramme_code=s.subprogramme_code and substr(office_code,2,2)='"+dcode+"'  and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'  and  work_cancel_dt is null order by programme_name,subprogramme_name";
System.out.println("qry:"+qry);
 stmt=conn.createStatement();
 rs=stmt.executeQuery(qry);
  while(rs.next())
  {
	String doc=""+ht.get(rs.getString(1));
	if(doc!=null  && !doc.equals("")  && !doc.equals("null")){}else{ doc="-";}
	String pdoc=""+ht1.get(rs.getString(1));
	if(pdoc!=null  && !pdoc.equals("")  && !pdoc.equals("null")){}else{ pdoc="-";}
	String nhab=""+hashtable.get(rs.getString(1));
	if(nhab!=null  && !nhab.equals("")  && !nhab.equals("null")){}else{ nhab="0";}
	%>
   <tr>
    <td class=rptvalue><%=++sno%></td>
	<td class=rptvalue align="center" nowrap><%=rs.getString(5)%></td>
	<td class=rptvalue align="center" nowrap><%=rs.getString(6)%></td>
	<td class=rptvalue align="center"><%=rs.getString(1)%></td>
	<td class=rptvalue nowrap><%=rs.getString(2)%></td>
	<td class=rptvalue align="center"><%=nhab%></td>
	<td class=rptvalue align="center"><%=rs.getString(3)%></td>
	<td class=rptvalue align="right"><%=rs.getString(4)%></td>
	<td class=rptvalue align="center"><%=pdoc%></td>
	<td class=rptvalue align="center"><%=doc%></td>
	</tr>
 <%}%>
</table>