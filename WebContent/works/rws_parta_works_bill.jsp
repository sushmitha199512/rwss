<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
if(user!=null){
       if(loggedUser!=null && (!loggedUser.equals("admin") && !loggedUser.equals("100000") && !loggedUser.substring(4, 6).equals("EE")  && !loggedUser.substring(4, 6).equals("AO"))){
      response.sendRedirect("../commons/UnAuthorize.jsp");
       }
} 
%>
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
var zURL = "./switch.do?prefix=/works&page=/PartABill.do&mode=BillsForPartA&workId="+workId+"&workName="+workName;
	var popFeatures = "width=1019,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	myWin = window.open(zURL,'habs',popFeatures);
myWin.focus();	
}
function openExpVoucher1(workId,workName)
{
var zURL = "./switch.do?prefix=/works&page=/PartABill.do&mode=VouchersForPartA&workId="+workId+"&workName="+workName;
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

try{
stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
Statement stmt3 = conn.createStatement();
String qry = "select distinct a.work_id,a.work_name,nvl(sanction_amount,'0'),nvl(b.PARTAAMOUNT,'0'),to_char(admin_date,'dd/mm/yyyy'),to_char(b.updatedate,'dd/mm/yyyy'),nvl(lead_habitation,'--') as lead_habitation from rws_work_admn_tbl a,rws_notgroundworks_status_tbl b where a.work_id=b.work_id and  substr(a.work_id,5,2)='"+request.getParameter("district")+"' and substr(a.office_code,4,1)='"+request.getParameter("division")+"' order by to_char(b.updatedate,'dd/mm/yyyy') desc ";
System.out.println("qryssssssss:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
String dname = request.getParameter("dname");
String divname = request.getParameter("divname");

String qr1 = "select count(*),b.work_id from rws_work_bill_tbl b where BILL_TYPE ='A' and substr(work_id,5,2) ='"+request.getParameter("district")+"' group by b.work_id";
//System.out.println("qr:"+qr1);
ResultSet billrs1 = stmt3.executeQuery(qr1);
Hashtable hashtablebill1 = new Hashtable();
while(billrs1.next())
{
	//System.out.println("*********************");
	hashtablebill1.put(billrs1.getString(2),billrs1.getString(1)); 
}

%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table><b>
<p align=center>
<font face=verdana size=2> District:</font><font face=verdana size=2 color=blue> <%=dname%></font>&nbsp;&nbsp;
<font face=verdana size=2> Division:</font><font face=verdana size=2 color=blue> <%=divname%></font>&nbsp;&nbsp;

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Part A Works List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Sanction Cost(In Lakhs)</td>
			<td class=btext>Part A Amount(In Lakhs)</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Lead Habitation/<BR/>Habitation Name</td>
			<td class=btext>Total Items(Charges)</td>
	<td class=btext>Total Bills</td>
			<td class=btext>Bill</td>
			<td class=btext>Vouchers</td>
</tr>
<%


while(rs.next())
{

  String q="select LANDAQUISITIONCHRG,waterDrawlPermissionChrg,railwayCrossingPermissionChrg,roadCrossingPermissionChrg,roadCrossingPermissionNHAIChrg,forestClearanceChrg,POWERAPTRANSCOCHRGS ,hmwsChrgs,othersChrg,groundWaterInvestigationChg,yieldTestingChg,sourceCreationChg,dprCharges from rws_notgroundworks_status_tbl where work_id='"+rs.getString(1)+"'";


  ResultSet rss= stmt2.executeQuery(q);
int count=0;
  while(rss.next()){
  if(rss.getString(1)!=null && !rss.getString(1).equals("") && !rss.getString(1).equals("0")){
    count+=1;
		}
if(rss.getString(2)!=null && !rss.getString(2).equals("")&& !rss.getString(2).equals("0")){
    count+=1;
		}
if(rss.getString(3)!=null && !rss.getString(3).equals("")&& !rss.getString(3).equals("0")){
    count+=1;
		}
if(rss.getString(4)!=null && !rss.getString(4).equals("")&& !rss.getString(4).equals("0")){
    count+=1;
		}
if(rss.getString(5)!=null && !rss.getString(5).equals("")&& !rss.getString(5).equals("0")){
    count+=1;
		}
if(rss.getString(6)!=null && !rss.getString(6).equals("")&& !rss.getString(6).equals("0")){
    count+=1;
		}
if(rss.getString(7)!=null && !rss.getString(7).equals("")&& !rss.getString(7).equals("0")){
    count+=1;
		}
if(rss.getString(8)!=null && !rss.getString(8).equals("")&& !rss.getString(8).equals("0")){
    count+=1;
		}
if(rss.getString(9)!=null && !rss.getString(9).equals("")&& !rss.getString(9).equals("0")){
    count+=1;
		}
if(rss.getString(10)!=null && !rss.getString(10).equals("")&& !rss.getString(10).equals("0")){
    count+=1;
		}
if(rss.getString(11)!=null && !rss.getString(11).equals("")&& !rss.getString(11).equals("0")){
    count+=1;
		}
if(rss.getString(12)!=null && !rss.getString(12).equals("")&& !rss.getString(12).equals("0")){
    count+=1;
		}
if(rss.getString(13)!=null && !rss.getString(13).equals("")&& !rss.getString(13).equals("0")){
    count+=1;
		}
}
String lead_hab_name="--";
  String hab_name="select panch_name from rws_complete_hab_view where panch_code='"+rs.getString("lead_habitation")+"'";
	Statement statement=conn.createStatement();
	ResultSet resultSet=statement.executeQuery(hab_name);
	if(resultSet.next()){
		lead_hab_name=resultSet.getString("panch_name");
	}
String bill1 = ""+hashtablebill1.get(rs.getString(1));
	if(bill1!=null && !bill1.equals("null")){}else{bill1="0";}
%>
	<tr onclick="toggleRowColor(this)">
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(1)%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString("lead_habitation")%>/<BR/><%=lead_hab_name%></td>
			<% if(count>0){ %>
			<td class=rptValue><a href="#" onclick="wopen('../reports/rws_parta_milestone_rpt.jsp?workid=<%=rs.getString(1)%>&workName=<%=rs.getString(2) %>','popup', 995, 400)"><%=count %></a></td>
<td class=rptValue><a href="#" onclick="wopen('../reports/rws_work_bill_rpt.jsp?type=A&workid=<%=rs.getString(1)%>','popup', 450, 300)"><%=bill1%></td>
			<% if(rs.getString("lead_habitation").equals("--")){ %>
			<td class=rptValue><input type=button name="button1" title="Please Update Lead Habitation for this Work"  Class="btext" value="Add/Remove" onclick="openExpVoucher('<%=rs.getString(1)%>','<%=rs.getString(2)%>')" disabled/></td>
      <td class=rptValue><input type=button name="button1" title="Please Update Lead Habitation for this Work"  Class="btext" value="Add/Remove" onclick="openExpVoucher1('<%=rs.getString(1)%>','<%=rs.getString(2)%>')" disabled/></td>
      <%}else{ %>
      <td class=rptValue><input type=button name="button1" title="Click to Enter Bill Details"  Class="btext" value="Add/Remove" onclick="openExpVoucher('<%=rs.getString(1)%>','<%=rs.getString(2)%>')"/></td>
      <td class=rptValue><input type=button name="button1" title="Click to Enter Voucher Details"  Class="btext" value="Add/Remove" onclick="openExpVoucher1('<%=rs.getString(1)%>','<%=rs.getString(2)%>')"/></td>
<%}} else {%>
<td class=rptValue>0</td>
<td class=rptValue></td>
<td class=rptValue></td>
<td class=rptValue></td>
<%} %>			
	
	</tr>
<%
}

}catch(Exception e){
e.printStackTrace();
}
%>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>

<%@ include file = "/commons/rws_footer.jsp" %>
</form>
</body>
