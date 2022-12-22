<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
function getHabs(workId)
{
	var zURL = "rws_works_mpr_hab_frm.jsp?workId="+workId;
	var popFeatures = "width=950,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
</SCRIPT>
<%@page import="java.util.*" %>
<%
	String year=request.getParameter("year");
	if(year!=null){
	session.setAttribute("year",year);
	}
	String dist = request.getParameter("district");
	if(dist!=null){
	session.setAttribute("dist",dist);
	}
	String dname= request.getParameter("dname");
	if(dname!=null){
	session.setAttribute("dname",dname);
	}
%> 

<body>
<form method="post">
<%
try
{
	int i = 0;
ResultSet habrs = null;
Statement stmt2 = conn.createStatement();
habrs = stmt2.executeQuery("select count(*),work_id from RWS_WORKS_ACTION_PLAN_HABS_TBL group by work_id");
Hashtable hashtable = new Hashtable();
while(habrs.next())
{
	hashtable.put(habrs.getString(2),habrs.getString(1)); 
}
Iterator iterator = hashtable.keySet().iterator();
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


String qry = "select a.work_id,to_char(b.date_of_completion) as doc,b.date_of_completion,w.work_name,to_char(w.admin_date,'dd/mm/yyyy'),w.sanction_amount,dname from rws_work_admn_tbl w,rws_ddws_scheme_data_port a,rws_work_completion_tbl b,rws_district_tbl c where a.work_id=b.work_id(+) and w.work_id=a.work_id and work_asset='W' and fin_year='"+year+"' and substr(w.work_id,5,2) =c.dcode and c.dcode='"+dist+"' order by dname,DATE_OF_COMPLETION ASC";

//System.out.println("aRy:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
%>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
				<a href="../home.jsp">Home</a>&nbsp;|&nbsp;
				<a href="./rws_project_shelf_xls.jsp" target="_new">Excel</a>

			</td>
		</tr>
	</table>
</table>
<p><font face=verdana size=3 color=blue>Project Shelf Report</font></p>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=black style="border-collapse:collapse" width="28%">
<tr><td width="30%" bgcolor="#cccc99"></td><td class=rptValue> - Completed</td></tr>
<tr><td bgcolor="#CCCCff"> </td><td class=rptValue>- Not Completed</td></tr>
</table>
<BR>
<font color="blue" face=verdana size=2>District:</font><font color="black" face=verdana size=2><%=dname%></font>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	     border=1 style="border-collapse:collapse;" >
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Works Details</B>
		</legend>
		<label>
		<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr  align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work ID</td>
			<td class=btext>Habs</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Cost</td>
			<td class=btext>Completion Date</td>
			</tr>
<%
while(rs.next())
{
	String cdate = rs.getString(2);
	if(cdate==null || (cdate!=null && cdate.length()<8))
	{%>
		<tr  bgcolor="#CCCCff">
	<%}else
	{%>
		<tr  bgcolor="#CCCC99">
	<%}%>
		<td class=rptValue><%=workCount++%></td>
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue align="center"><a href="#" onClick="getHabs('<%=rs.getString(1)%>')"><%=hashtable.get(rs.getString(1))%></a></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue align="right"><%=rs.getString(6)%></td>
		<td class=rptValue><%if(cdate!=null && !cdate.equals(""))
		out.println(cdate);
		else out.println("-");%></td>
	</tr>
<%}%>
</table></table>
<%

}
catch(Exception e)
{e.printStackTrace();}
%>
</table>		
</table>	
</body>
</form>
<%@ include file="/commons/rws_footer.jsp"%>
