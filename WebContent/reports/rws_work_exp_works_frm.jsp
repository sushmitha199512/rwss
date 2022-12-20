<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<script language="javascript">
function openExpVoucher(workId,workName,exp)
{
	var zURL = "./switch.do?prefix=/works&page=/WorkStatus.do&mode=ExpVoucher&workId="+workId+"&workName="+workName+"&exp="+exp+"";
	var popFeatures = "width=995,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
</script>
<body>
<form>
<%
String qry="",qry1="";
stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
Statement prstmt = conn.createStatement();
ResultSet prs=null;
NumberFormat formatter = new DecimalFormat("#0.00");
//String work=request.getParameter("works");

if(request.getParameter("works") !=null && request.getParameter("works").equals("1")) {
 qry = "select a.work_id,work_name,nvl(sanction_amount,'0'),admin_no,to_char(admin_date,'dd/mm/yyyy'),to_char(date_of_completion,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and date_of_completion is not null and work_cancel_dt is null and  category_code='"+request.getParameter("catcode")+"' and substr(a.work_id,5,2) ='"+request.getParameter("district")+"'";
}
else if(request.getParameter("works") !=null && request.getParameter("works").equals("2")) {
 
qry="select a.work_id,work_name,nvl(sanction_amount,'0'),admin_no,to_char(admin_date,'dd/mm/yyyy'),to_char (c.grounding_date,'dd/mm/yyyy'),to_char(d.date_of_completion,'dd/mm/yyyy')from rws_work_admn_tbl a,rws_work_completion_tbl b,rws_work_commencement_tbl c,rws_contractor_selection_tbl d where a.work_id=b.work_id and a.work_id=c.work_id and a.work_id=d.work_id and b.date_of_completion is null and grounding_date is not null and  category_code='"+request.getParameter("catcode")+"' and substr (a.work_id,5,2) ='"+request.getParameter("district")+"'";
}
////System.out.println("qry:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
String dname = request.getParameter("dname");
String wcname = request.getParameter("wcname");
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<b>
<table width="60%" align=center>
<tr><td width="20%" bgcolor="pink" bordercolor="black"></td><td class=rptValue>&nbsp;- Zero Expenditure</td></tr>
<tr><td width="20%" bgcolor="white"></td><td class=rptValue>&nbsp;- Sanction Amount is Greater than Expenditure</td></tr>
<tr><td width="20%" bgcolor="green"></td><td class=rptValue>&nbsp;- Sanction Amount is Equals to Expenditure</td></tr>
<tr><td width="20%" bgcolor="red"></td><td class=rptValue>&nbsp;- Sanction Amount is Less than Expenditure</td></tr>
</table>
<BR>
<%if(request.getParameter("works") !=null && request.getParameter("works").equals("1")) {%>
<p align=center><font face=verdana size=2>Completed Works and their Payments in District:</font><font face=verdana size=2 color=blue> <%=dname%></font> <font face=verdana size=2> Work Category:</font>  <font face=verdana size=2 color=blue><%=wcname%></font></p></b>
<%}else if(request.getParameter("works") !=null && request.getParameter("works").equals("2")) {%>
<p align=center><font face=verdana size=2>Ongoing Completed Works and their Payments in District:</font><font face=verdana size=2 color=blue> <%=dname%></font> <font face=verdana size=2> Work Category:</font>  <font face=verdana size=2 color=blue><%=wcname%></font></p></b>

<%}%>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin No</td>
			<td class=btext>Admin Date</td>
			<% if(request.getParameter("works").equals("1")) {%>
			<td class=btext>Date of Completion</td>
			<%}else if(request.getParameter("works").equals("2")) {%>
			<td class=btext>Date of Grounding</td>
			<td class=btext>Sitipulated Date of Completion</td>
			<%}%>
			<td class=btext>Cost(In Lakhs)</td>
			<td class=btext>Cost(In Rs.)</td>
			<td class=btext>Total Expenditure</td>
</tr>
<%
//"select nvl(sum(b.expenditure_upto_the_pre_year)+sum(total),0),b.work_id from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) group by b.work_id"
ResultSet exprs = stmt2.executeQuery("select nvl(sum(total),0),b.work_id from rws_exp_view b group by b.work_id");
//and a.programme_code='"+request.getParameter("program")+"' 
Hashtable hashtable = new Hashtable();
while(exprs.next())
{
	hashtable.put(exprs.getString(2),exprs.getString(1)); 
}
////System.out.println("size2:"+hashtable.size());

while(rs.next())
{
	String color = "white";
	String exp = ""+hashtable.get(rs.getString(1));
	if(exp!=null && !exp.equals("null")){}else{exp="0";}
	double adamt=0.0;
	qry1="select nvl(sanction_amount,'0') from rws_work_admn_prog_lnk_tbl where  work_id='"+rs.getString(1)+"' ";
//	System.out.println("qry:"+qry1);
    prs=prstmt.executeQuery(qry1);
	if(prs.next())
	{adamt=prs.getDouble(1);}else { adamt=0.0;}
	double sanctionAmount1 = rs.getDouble(3) ;
//	System.out.println("sanctionAmount1:"+sanctionAmount1);
    double sanctionAmount = sanctionAmount1 + adamt;
	//	System.out.println("adamt:"+adamt);
	double estCost = Double.parseDouble(exp);
	//System.out.println("sanctionAmount:"+sanctionAmount);
	////System.out.println("2:"+estCost);
String css = "<font color=black face=verdana size=2>";
	if(estCost==0)
		color = "pink";
	else if(sanctionAmount>estCost)
		color = "white";
	else if(sanctionAmount<estCost) {
		color="red";
		css = "<font color=white face=verdana size=2>";
	}
	else if(sanctionAmount==estCost) 
	{
		color="green";
		css = "<font color=white face=verdana size=2>";
	}

%>
	<tr  bgcolor="<%=color%>">
			<td ><%=css%><%=workCount++%></td>
			<td><a href="rws_wrk_progress_resource_rpt.jsp?work_id=<%=rs.getString(1)%>&dcode=<%=rs.getString(1).substring(4,6)%>&scheme=<%=rs.getString(1).substring(6,8)%>" target="_new"><font color="black"><B><u><%=css%><%=rs.getString(1)%></font></B></a></td>
			<td ><%=css%><%=rs.getString(2)%></font></td>
			<td ><%=css%><%=rs.getString(4)%></font></td>
			<td ><%=css%><%=rs.getString(5)%></font></td>
			<td ><%=css%><%=rs.getString(6)%></font></td>
			<% if(request.getParameter("works").equals("2")) {%>
			<td ><%=css%><%=rs.getString(7)%></font></td>
			<%}%>
			<td align="right"><%=css%><%=sanctionAmount%></font></td>
			<td align="right"><%=css%><%=formatter.format(sanctionAmount*100000)%></font></td>
			<td align="right"><%=css%><%=formatter.format(Double.parseDouble(exp)*100000)%></font></td>
		</tr>
<%
}
%>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</form>
</body>
