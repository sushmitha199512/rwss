<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String dcode=request.getParameter("district");
if(dcode!=null){
session.setAttribute("dcode",dcode);
}
String stype=request.getParameter("stype");
if(stype!=null){
session.setAttribute("stype",stype);
}
String mcode=request.getParameter("mandal");
if(mcode!=null){
session.setAttribute("mcode",mcode);
}
String dname=request.getParameter("dname");
if(dname!=null){
session.setAttribute("dname",dname);
}
String mname=request.getParameter("mname");
if(mname!=null){
session.setAttribute("mname",mname);
}
String sname=request.getParameter("sname");
if(sname!=null){
session.setAttribute("sname",sname);
}

%>
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
<form>
<table width="80%">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_Source_hab_xls.jsp" target="_new">Excel</a>
</tr>
</table>
<table><tr><td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
<td class="btext">
- Mandal:</td><td class="rptvalue"><%=mname%></td>
</td>
<td class="btext">
- Source Type:</td><td class="rptvalue"><%=sname%></td>
</td>
</tr></table>
<table width="80%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Habitations </font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr >
<td class=btext ><b>S.No</b></font></td>
 	<td class=btext><b>Habitation Code</b></font></td>
	<td class=btext><b>Habitation Name</b></font></td>
	<td class=btext><b>Total No.of Sources</b></font></td>
	<td class=btext><b>No.of Tested Sources</b></font></td>
	<td class=btext><b>No.of Contaminated Sources</b></font></td>
    
</tr>

<%
try
{
stmt=conn.createStatement();
 Statement stmt1=conn.createStatement();
 Statement stmt2=conn.createStatement();
  Statement stmt3=conn.createStatement();
String tabName = "",colName="";
int count = 1;
if(stype!=null && stype.equals("04"))
	{tabName = "RWS_HP_SUBCOMP_PARAM_TBL";colName = "HP_CODE";}
else if(stype!=null && (stype.equals("01") || stype.equals("02") || stype.equals("03") || stype.equals("09")))
	{tabName = "RWS_SOURCE_TBL";colName = "SOURCE_CODE";}
String qry=" select a.hab_code,b.panch_name  from rws_habitation_directory_tbl a,rws_complete_hab_view b where b.panch_code=a.hab_code and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"'";
//if(mcode!=null && !mcode.equals(""))qry+=" and substr(a.hab_code,6,2)='"+mcode+"' "; 
//System.out.println(qry);
rs=stmt.executeQuery(qry);
 while(rs.next())
{
String qry1="select (select count(*) from rws_asset_mast_tbl am,"+tabName+" hb where am.asset_code=hb.asset_code and TYPE_OF_ASSET_CODE ='"+stype+"' and AM.hab_code='"+rs.getString(1)+"')d, (select count(distinct  s.source_code)  from rws_water_sample_collect_tbl s,RWS_WQ_TEST_RESULTS_TBL WQ ,"+tabName+" h,RWS_ASSET_MAST_TBL A where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h."+colName+" and A.hab_code='"+rs.getString(1)+"' and TYPE_OF_ASSET_CODE ='"+stype+"' AND S.TEST_ID=WQ.TEST_ID)a from dual";
//System.out.println("QRY111:"+qry1);
 ResultSet rs1=stmt1.executeQuery(qry1);
if(rs1.next())
	{%>
	<tr>
		<td class=rptvalue ><%=count++%></td>
		<td class=rptvalue nowrap><%=rs.getString(1)%></td>
		<td class=rptvalue nowrap><%=rs.getString(2)%></td>
	<%
	if(Integer.parseInt(rs1.getString(1))>0){%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Source_hab_details.jsp?habcode=<%=rs.getString(1)%>&stype=<%=stype%>&mode=1','popup', 900, 300)"><%=rs1.getString(1)%></a></td>
	<%}else{%>
	<td class=rptvalue align="left"><%=rs1.getString(1)%></td>
	<%}%>
	<%
	if(Integer.parseInt(rs1.getString(2))>0){%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Source_hab_details.jsp?habcode=<%=rs.getString(1)%>&stype=<%=stype%>&mode=2','popup', 900, 300)"><%=rs1.getString(2)%></a></td>
	<%}else{%>
	<td class=rptvalue align="left"><%=rs1.getString(2)%></td>
	<%}%>
	<%
}
	String qry2="SELECT NVL(sum(count(distinct h."+colName+")),0) from rws_water_sample_collect_tbl s ,"+tabName+" h,RWS_ASSET_MAST_TBL A,RWS_WQ_TEST_RESULTS_LNK_TBL av, RWS_WQ_PARA_TEST_TBL mv,RWS_WQ_TEST_RESULTS_TBL WQ where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h."+colName+" and A.hab_code='"+rs.getString(1)+"' AND AV.TEST_ID=S.TEST_ID AND AV.TEST_ID=wq.TEST_ID AND wq.TEST_ID=S.TEST_ID AND av.TESTING_PARAMETER_CODE=mv.TESTING_PARAMETER_code and TYPE_OF_ASSET_CODE ='"+stype+"'  and av.TESTING_PARAMETER_code in('01','02','04','13','15','16','11','18') and case when s.test_code=1 and av.TESTING_PARAMETER_code=01 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=02 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=04 and av.TESTING_PARAMETER_VALUE>=6 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=13 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=1.5 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=15 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=999 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=16 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=10 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=11 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=99 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=18 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=01 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=1609 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=02 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=24 then  1 else 0 end in (0) group by h."+colName+"";
	//System.out.println("QRY11133333333:"+qry2);
 ResultSet rs2=stmt2.executeQuery(qry2);
 int contCount = 0;
if(rs2.next() && rs2.getInt(1)>0){
%>
<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Source_hab_details.jsp?habcode=<%=rs.getString(1)%>&stype=<%=stype%>&mode=3','popup', 900, 300)"><%=rs2.getString(1)%></a></td>
	<%}else{%>
	<td class=rptvalue align="left">0</td>
	<%}%>
		<%
}
}
catch(Exception e)
{
e.printStackTrace();
}

%>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

