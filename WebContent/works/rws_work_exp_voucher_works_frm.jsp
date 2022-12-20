<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
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
stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
String qry = "select work_id,work_name,nvl(sanction_amount,'0'),admin_no,to_char(admin_date,'dd/mm/yyyy') from rws_work_admn_tbl where programme_code='"+request.getParameter("program")+"' and substr(work_id,5,2) ='"+request.getParameter("district")+"' and admin_date<'01/APR/2010'";
//System.out.println("qry:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
String dname = request.getParameter("dname");
String pname = request.getParameter("pname");
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table><b>
<p align=center><font face=verdana size=2>District:</font><font face=verdana size=2 color=blue> <%=dname%></font> <font face=verdana size=2> Programme:</font>  <font face=verdana size=2 color=blue><%=pname%></font></p></b>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Cost(In Lakhs)</td>
			<td class=btext>Admin No</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Total Expenditure</td>
			<td class=btext>Issue <BR> Voucher</td>
</tr>
<%
//"select nvl(sum(b.expenditure_upto_the_pre_year)+sum(total),0),b.work_id from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) group by b.work_id"
ResultSet exprs = stmt2.executeQuery("select nvl(sum(total),0),b.work_id from rws_exp_view b where substr(work_id,5,2) ='"+request.getParameter("district")+"'  group by b.work_id");
//and a.programme_code='"+request.getParameter("program")+"' 
Hashtable hashtable = new Hashtable();
while(exprs.next())
{
	hashtable.put(exprs.getString(2),exprs.getString(1)); 
}
ResultSet contrs = stmt2.executeQuery("select count(*),b.work_id from rws_contractor_selection_tbl b where substr(work_id,5,2) ='"+request.getParameter("district")+"' and contractor_code is not null group by b.work_id");
Hashtable hashtablecont = new Hashtable();
while(contrs.next())
{
	hashtablecont.put(contrs.getString(2),contrs.getString(1)); 
}
ResultSet milers = stmt2.executeQuery("select count(*),b.work_id from rws_milestone_target_ach_tbl b where substr(work_id,5,2) ='"+request.getParameter("district")+"' group by b.work_id");
Hashtable hashtablemile = new Hashtable();
while(milers.next())
{
	hashtablemile.put(milers.getString(2),milers.getString(1)); 
}
boolean flag = false;
//System.out.println("size2:"+hashtable.size());

while(rs.next())
{
		System.out.println("work id:"+rs.getString(1));

	String exp = ""+hashtable.get(rs.getString(1));
	if(exp!=null && !exp.equals("null")){}else{exp="0";}

	String cont = ""+hashtablecont.get(rs.getString(1));
	System.out.println("cont1:"+cont);
	if(cont!=null && !cont.equals("null")){}else{cont="0";}

	String mile = ""+hashtablemile.get(rs.getString(1));
	if(mile!=null && !mile.equals("null")){}else{mile="0";}
	
	System.out.println("cont2:"+cont);
	System.out.println("mile:"+mile);
%>
	<tr onclick="toggleRowColor(this)">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=exp%></td>
			<%if((cont!=null && !cont.equals("0")) && (mile.equals("0"))){%>
			<td class=rptValue><input type=button name="button1" title="Click to Enter Voucher Details"  Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;" onclick="openExpVoucher('<%=rs.getString(1)%>','<%=rs.getString(2)%>','<%=exp%>')"/></td>
			<%}else{%>
			<td class=rptValue><input type=button name="button1" title="Cannot Enter Voucher Details"  Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;" disabled=true/></td>
			<%}
%>
	</tr>
<%
}
%>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****: <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. You can enter the Vouchers for the Works which are sanctioned before </font><font face=verdana size=2 color=blue>01/04/2010</font>
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>2. You can enter the Vouchers for the Works which are having Contractor Details.
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>3. You cannot enter the Vouchers for the Works which are having Mile Stones Information
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. Remaining Works  should enter through 'WORK PROGRESS' form.
</font>
</p>
<%@ include file = "/commons/rws_footer.jsp" %>
</form>
</body>
