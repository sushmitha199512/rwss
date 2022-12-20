<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<script language="javascript">
function wopen(url,name,w,h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
</body>
<%
String dist=request.getParameter("district1");
if(dist!=null && !dist.equals(""))
{
	session.setAttribute(dist,"dist");
}
String mandal=request.getParameter("mandal");
//System.out.println("mandal"+mandal);
String ast=request.getParameter("astwrk");
int count=0;
Statement stmt1=null;
ResultSet rs1=null;
stmt1=conn.createStatement();
Statement st3= null;
Statement stt = null,stt1=null;
ResultSet rss = null,rs= null,rs2 = null,rs3 = null,rss1=null;
%>
<table border = 0 width=20% align=center>
<%if(request.getParameter("dName")!=null && !request.getParameter("dName").equals("")){ %>
<tr><td class=btext>District:</td><td><font face=verdana size=2><%=request.getParameter("dName")%></td>
<%}%>
<%if(request.getParameter("mandal")!=null && !request.getParameter("mandal").equals("")){ %>
<td class=btext>Mandal:</td><td><font face=verdana size=2><%=request.getParameter("mname")%></td></tr>
<%}%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr>
		<td align="right" class="bwborder">
		<a href="javascript:history.go(-1)">Back</a>|
		<a href="javascript:window.print()">print</a>|
			<a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
		</td>
	</tr>
</table>
</caption>
<tr>
<td class=btext>Sl.No</td>
<td class=btext>Mandal</td>
<td class=btext>Panchyat</td>
<td class=btext>Village</td>
<td class=btext>Habitation</td>
<td class=btext>NO.Of Schools </td>
<td class=btext>Having Assets</td>
<td class=btext>Having Works</td>
<td class=btext>NotHaving Assets and Works</td>
<%
try
{
	String q3 = "select count(*),hab_code from rws_school_master_tbl where substr(hab_code,1,2)='"+dist+"'";
	if(mandal!=null && !mandal.equals(""))
	{
	q3+=" and substr(hab_code,6,2)='"+mandal+"' ";
	}
	q3+=" group by hab_code";
	//System.out.println("noofschools"+q3);
	st3=conn.createStatement();
	rs3 = st3.executeQuery(q3);
	Hashtable ht1 = new Hashtable();
	while(rs3.next())
	{
		ht1.put(rs3.getString(2),rs3.getString(1)); 
	}
	String q = "select count(distinct a.school_code),a.hab_code from rws_school_master_tbl a,rws_asset_mast_tbl b,rws_school_asset_lnk_tbl c where substr(A.hab_code,1,2)='"+dist+"' and a.hab_code=b.hab_code and b.asset_code=c.asset_code and a.school_code=c.school_code ";
	if(mandal!=null && !mandal.equals(""))
	{
	q+=" and substr(a.hab_code,6,2)='"+mandal+"' ";
	}
	q+=" group by a.hab_code";
	//System.out.println("assets"+q);
	stt=conn.createStatement();
	rss = stt.executeQuery(q);
	Hashtable ht = new Hashtable();
	while(rss.next())
	{
		ht.put(rss.getString(2),rss.getString(1)); 
	}
	String q1="select count(distinct a.school_code),a.hab_code from rws_school_master_tbl a,rws_work_admn_tbl b,rws_school_asset_lnk_tbl c where substr(A.hab_code,1,2)='"+dist+"' and c.hab_code=a.hab_code and c.asset_code=b.work_id and a.school_code=c.school_code ";
	if(mandal!=null && !mandal.equals(""))
	{
	q1+=" and substr(a.hab_code,6,2)='"+mandal+"' ";
	}
	q1+=" group by a.hab_code";
	//System.out.println("works:"+q1);
	stt1=conn.createStatement();
	rss1 = stt1.executeQuery(q1);
	Hashtable ht2 = new Hashtable();
	while(rss1.next())
	{
		ht2.put(rss1.getString(2),rss1.getString(1)); 
	}
	String qry="select distinct v.mname,v.pname,v.vname,v.panch_name,v.panch_code from rws_complete_hab_view v,rws_school_master_tbl s where v.panch_code=s.hab_code and  substr(s.hab_code,1,2)='"+dist+"'";
	if(mandal!=null && !mandal.equals(""))
	{
	qry+= " and substr(s.hab_code,6,2)='"+mandal+"' ";
	}
stmt=conn.createStatement();
//System.out.println("qqqqq2:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{
		String nof = ""+ht1.get(rs.getString("panch_code"));
		String asset = ""+ht.get(rs.getString("panch_code"));
		String works = ""+ht2.get(rs.getString("panch_code"));
		if(nof==null || (nof!=null && nof.equals("null")))nof="0";
		if(asset==null || (asset!=null && asset.equals("null")))asset="0";
		if(works==null || (works!=null && works.equals("null")))works="0";
		int noa = Integer.parseInt(nof)-(Integer.parseInt(works)+Integer.parseInt(asset));
	%><tr>
    	<td class=rptValue><%=++count%></td>
	    <td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
	<%
	int nof1=Integer.parseInt(nof);
	if(nof1>0){
	%>
	<td class=rptvalue  align="right">
	<a href="#" onclick="wopen('rws_school_details_rpt.jsp?habcode=<%=rs.getString("panch_code")%>&mode=1','popup', 900, 300)"><%=nof1%></a></td>
	<%}else{%>
	<td class=rptvalue align="right">0</td>
	<%}%>
		<%
		int asset1=Integer.parseInt(asset);
		if(asset1>0){
		%>
		<td class=rptvalue  align="right">
		<a href="#" onclick="wopen('rws_school_details_rpt.jsp?habcode=<%=rs.getString("panch_code")%>&mode=2','popup', 900, 300)"><%=asset1%></a></td>
		<%}else{%>
		<td class=rptvalue align="right">0</td>
		<%}%>
	<%
	int works1=Integer.parseInt(works);
	if(works1>0){
	%>
	<td class=rptvalue  align="right">
	<a href="#" onclick="wopen('rws_school_details_rpt.jsp?habcode=<%=rs.getString("panch_code")%>&mode=3','popup', 900, 300)"><%=works1%></a></td>
	<%}else{%>
	<td class=rptvalue align="right">0</td>
	<%}%>
		<%

		if(noa>0){
		%>
		<td class=rptvalue  align="right">
		<a href="#" onclick="wopen('rws_school_details_rpt.jsp?habcode=<%=rs.getString("panch_code")%>&mode=4','popup', 900, 300)"><%=noa%></a></td>
		<%}else{%>
		<td class=rptvalue align="right">0</td>
		<%}%>
	</tr>
	<%}
	}
catch(Exception e)
{
	System.out.println(""+e);
}
%>
</table>
</body>
</html>