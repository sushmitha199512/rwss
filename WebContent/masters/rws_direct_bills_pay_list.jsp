<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function wopen(url, name, w, h)
{
	var width = 990;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";

	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function openExpVoucher(workId,workName)
{
	var zURL = "./switch.do?prefix=/masters&page=/bills.do&mode=BillForVoucher&workId="+workId+"&workName="+workName;
	var popFeatures = "width=1019,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
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
Statement stmt3 = conn.createStatement();
String qry = "select distinct a.work_id,a.work_name,nvl(sanction_amount,'0'),admin_no,to_char(admin_date,'dd/mm/yyyy'),to_char(grounding_date,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc where a.work_id=wc.work_id and grounding_date is not null and BLOCK_PAYMENT='N' and a.programme_code=b.programme_code and substr(a.work_id,5,2)='"+request.getParameter("district")+"' and substr(a.office_code,4,1)='"+request.getParameter("division")+"'";
if(request.getParameter("program")!=null && !request.getParameter("program").equals(""))
	qry += " and a.programme_code='"+request.getParameter("program")+"'";
//qry += "and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion<'01/APR/2010')";
//System.out.println("qryssssssss:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
String dname = request.getParameter("dname");
String pname = request.getParameter("pname");
String divname = request.getParameter("divname");
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table><b>
<p align=center>
<font face=verdana size=2> District:</font><font face=verdana size=2 color=blue> <%=dname%></font>&nbsp;&nbsp;
<font face=verdana size=2> Division:</font><font face=verdana size=2 color=blue> <%=divname%></font>&nbsp;&nbsp;
<%if(request.getParameter("program")!=null && !request.getParameter("program").equals("")){
%>
<font face=verdana size=2> Programme:</font> <font face=verdana size=2 color=blue><%=pname%></font></p></b>
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
			<td class=btext>Cost(In Lakhs)</td>
			<td class=btext>Admin No</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Total Items</td>
			<td class=btext>Bill</td>
</tr>
<%

ResultSet milers = stmt2.executeQuery("select count(*),b.work_id from rws_milestone_target_ach_tbl b where substr(work_id,5,2) ='"+request.getParameter("district")+"' group by b.work_id");
Hashtable hashtablemile = new Hashtable();
while(milers.next())
{
	hashtablemile.put(milers.getString(2),milers.getString(1)); 
}
String qr = "select count(*),b.work_id from rws_milestone_target_ach_tbl b where substr(work_id,5,2) ='"+request.getParameter("district")+"' and (PERCENT_COMPLETED is not null or ACHIEVE_DATE is not null) group by b.work_id";
//System.out.println("qr:"+qr);
ResultSet milers1 = stmt2.executeQuery(qr);
Hashtable hashtablemile1 = new Hashtable();
while(milers1.next())
{
	//out.println(milers1.getString(2));
	hashtablemile1.put(milers1.getString(2),milers1.getString(1)); 
}
//System.out.println("size2:"+hashtable.size());

while(rs.next())
{
		//out.println("work id:"+rs.getString(5));

	String mile = ""+hashtablemile.get(rs.getString(1));
	if(mile!=null && !mile.equals("null")){}else{mile="0";}

	String mile1 = ""+hashtablemile1.get(rs.getString(1));
	if(mile1!=null && !mile1.equals("null")){}else{mile1="0";}

	//out.println("mile:"+mile);
	//System.out.println("mile1:"+mile1);
%>
	<tr onclick="toggleRowColor(this)">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<%if(!mile.equals("0") && !mile1.equals("0")) {%>
			<td class=rptValue><a href="#" onclick="wopen('../masters/rws_direct_bills_milestone_list.jsp?workid=<%=rs.getString(1)%>','popup', 995, 400)"><%=mile%></td>
			<td class=rptValue><input type=button name="button1" title="Click to Enter Bill Details"  Class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;" onclick="openExpVoucher('<%=rs.getString(1)%>','<%=rs.getString(2)%>')"/></td>
			<%}else{%>
			<td class=rptValue><%=mile%></td>
			<td class=rptValue style="width:40px">&nbsp;</td>
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
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Listed all the Works which are Grounded only
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>2. You can enter the Bills for the Works which are having Mile Stones Information along with Acheivement Details
</font>
</p>
<%@ include file = "/commons/rws_footer.jsp" %>
</form>
</body>
