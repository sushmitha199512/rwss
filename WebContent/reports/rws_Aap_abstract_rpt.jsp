<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%String catCode="",catName="";
nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	if(request.getParameter("catCode")!=null )
{
 catCode = request.getParameter("catCode");
}
	if(request.getParameter("catName")!=null )
{
 catName=request.getParameter("catName");
}
String finYear=null;
if(request.getParameter("finyear")!=null )
{
 finYear=request.getParameter("finyear");
}




// System.out.println("catName::");
%>
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
<script language="javascript">
function wopen(url,name,w,h)
{
	//alert(url);
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
					  // alert(url);
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}

function fnHab(status,dcode)
{
	var catCode='<%=catCode%>';
	var width = 600; 
	var height = 400;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_habcov_details.jsp?status="+status+"&dcode="+dcode+"&catCode="+catCode+"&finyear=<%=finYear %>";
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}


$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});   
</script>
<table border = 0 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" >
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a> |<a href="./rws_Aap_abstract_xls.jsp?catCode=<%=catCode%>&catName=<%=catName%>" target=_new>Excel</a></td>
				</tr>
			</table>
			</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" class="striped">
<tr bgcolor="#8A9FCD" align="center" >
<td >
<B><font color="#660099"><font color="blue"></font>&nbsp;&nbsp; AAP Abstract  &nbsp;<font color="blue"><%=catName%></font> &nbsp;Works (<%=finYear %>) </font></B></td></tr>
</tr>
<table border = 1 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" class="striped">
<tr>
<td class=btext align="center"  colspan="13"> Target</td>
  </tr>
<tr>
    <td class=btext align="center"> Sl.No</td>
    <td class=btext align="center">District</td>
    <td class=btext align="center">No.of Works</td>
    <td class=btext align="center">Est.Cost (in Lakhs)</td>
    <td class=btext align="center">Habs Sanctioned<br>(with out duplicates)</td>
	<td class=btext align="center">Habs Sanctioned</td>
	<td class=btext align="center">FC</td>
	<td class=btext align="center">PC4</td>
	<td class=btext align="center">PC3</td>
	<td class=btext align="center">PC2</td>
	<td class=btext align="center">PC1</td>
	<td class=btext align="center">NC</td>
	<td class=btext align="center">NSS</td>
	</tr>
		<% int cnt=0;
		int wtot=0,htot=0,fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nss=0,nc=0,dhtot=0;
		double samt=0.0;
		Statement  stmt1=conn.createStatement();
		ResultSet rs1=null;
		Statement  stmt2=conn.createStatement();
		ResultSet rs2=null;
		DecimalFormat ndf = new DecimalFormat("####.00");
		int year = Calendar.getInstance().get(Calendar.YEAR); 
		String yr=Integer.toString(year);
		String qry="",qry2="";
 ///System.out.println("catName111111::"+loggedUser.substring(1,3));
	
			if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
			 qry2="SELECT distinct substr(w.work_id,5,2) ,dname FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  ,rws_district_tbl d where w.work_id=b.work_id  and substr(w.work_id,5,2)=d.dcode and b.fin_year='"+finYear+"'   order by 1";
		}else
		{
			 qry2="SELECT distinct substr(w.work_id,5,2) ,dname FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  ,rws_district_tbl d where w.work_id=b.work_id  and substr(w.work_id,5,2)='"+loggedUser.substring(1,3)+"'  and  d.dcode=substr(w.work_id,5,2) and b.fin_year='"+finYear+"'  order by 1";
		}
 stmt2=conn.createStatement();
 rs2=stmt2.executeQuery(qry2);
 // System.out.println("works11:::"+qry2);
  String cat="";
   if(catCode!=null && !catCode.equals("") && catCode.equals("1"))
 {
	cat= "and category_code='"+catCode+"' ";
 }

  if(catCode!=null && !catCode.equals("") && catCode.equals("2"))
 {
	 cat=" and category_code='"+catCode+"' ";
 }
  if(catCode!=null && !catCode.equals("") && catCode.equals("3"))
 {
	 cat="  and category_code='"+catCode+"' ";
 }
// System.out.println("cat::"+cat);
while(rs2.next())
{
		

			if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
			qry="select  (SELECT count(w.work_id)  FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id  and b.fin_year='"+finYear+"'and substr(b.work_id,5,2)='"+rs2.getString(1)+"' "+cat+")as b ,( SELECT sum(w.sanction_amount)  FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id and b.fin_year='"+finYear+"' and substr(b.work_id,5,2)='"+rs2.getString(1)+"'   "+cat+")as c ,( SELECT count(distinct w.hab_code)  FROM RWS_ADMN_hab_lnk_TBL W,rws_aap_selected_tbl b ,rws_work_admn_tbl c where w.work_id=b.work_id and b.fin_year='"+finYear+"'  and substr(b.work_id,5,2)='"+rs2.getString(1)+"'  "+cat+" and c.work_id=b.work_id)as d from dual ";

		}else
		{
			qry="select  (SELECT count(w.work_id)  FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id  and b.fin_year='"+finYear+"'and substr(b.work_id,5,2)='"+loggedUser.substring(1,3)+"'  "+cat+" )as b ,( SELECT sum(w.sanction_amount)  FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id and  b.fin_year='"+finYear+"' and substr(b.work_id,5,2)='"+loggedUser.substring(1,3)+"'  "+cat+")as c ,( SELECT count(distinct w.hab_code)  FROM RWS_ADMN_hab_lnk_TBL W,rws_aap_selected_tbl b ,rws_work_admn_tbl c where w.work_id=b.work_id  and b.fin_year='"+finYear+"' and substr(b.work_id,5,2)='"+loggedUser.substring(1,3)+"'  "+cat+" and c.work_id=b.work_id)as d from dual   ";
		}
		//and work_cancel_dt is null  and a.work_id  in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) 
		

/* qry+= " group by substr(a.work_id,5,2),dname order by 1 ";*/
// System.out.println("works:::"+qry);
 stmt=conn.createStatement();
 rs=stmt.executeQuery(qry);
while(rs.next())
{%>
<tr>
<td class=rptvalue align="center"><%=++cnt%></td>
<td class=rptvalue ><%=rs2.getString(2)%></td>
<%if(rs.getInt(1)>0)
	       {%>
		   <td class=rptValue align="right"><a href="#" onclick="wopen('rws_aap_work_details.jsp?dname=<%=rs2.getString(2)%>&dcode=<%=rs2.getString(1)%>&cat=<%=catCode%>&finyear=<%=finYear%>','popup', 900, 300)"><%=rs.getInt(1)%></a></td>
     	<%}
	else{%>
	<td class=rptvalue align="right">0</td>
	<%}%>
<!-- <td class=rptvalue align="right"><%=rs.getString(3)%></td> -->
<%if(rs.getString(2)==null){%>
<td class=rptvalue align="right">0</td>
<%}else{%>
<td class=rptvalue align="right"><%=rs.getString(2)%></td>
<%}%>

<%if(rs.getInt(3)>0)
	       {%>
		   <td class=rptValue align="right"><a href="#" onclick="wopen('rws_aap_habs_rpt.jsp?dname=<%=rs2.getString(2)%>&dcode=<%=rs2.getString(1)%>&cat=<%=catCode%>&finyear=<%=finYear%>','popup', 900, 300)"><%=rs.getInt(3)%></a></td>
     	<%}
	else{%>
	<td class=rptvalue align="right">0</td>
	<%}%>



<%String qry1="select  sum(case when coverage_status='FC' then 1 else 0 end)a,sum(case when coverage_status='PC4' then 1 else 0 end) b,sum(case when coverage_status='PC3' then 1 else 0 end) c,sum(case when coverage_status='PC2' then 1 else 0 end) d,sum(case when coverage_status='PC1' then 1 else 0 end) e,sum(case when coverage_status='NC' then 1 else 0 end) f,sum(case when coverage_status='NSS' then 1 else 0 end)g,sum(case when coverage_status is not null  then 1 else 0 end)  h from rws_AAP_selected_tbl a ,rws_complete_hab_view v,rws_admn_hab_lnk_tbl b,rws_work_admn_tbl c  where a.fin_year='"+finYear+"' and a.work_id=b.work_id and v.panch_code=b.hab_code  and a.work_id=c.work_id and b.work_id=c.work_id  ";
//and work_cancel_dt is null  and a.work_id  in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) 

if(catCode!=null && !catCode.equals("") && catCode.equals("1"))
 {
	 qry1+= " and  category_code='"+catCode+"' ";
 }
  if(catCode!=null && !catCode.equals("") && catCode.equals("2"))
 {
	 qry1+= " and  category_code='"+catCode+"' ";
 }
  if(catCode!=null && !catCode.equals("") && catCode.equals("3"))
 {
	 qry1+= " and  category_code='"+catCode+"' ";
 }

qry1+=" and substr(a.work_id,5,2)='"+rs2.getString(1)+"' ";
//System.out.println("q::"+qry1);
 rs1=stmt1.executeQuery(qry1);
if(rs1.next()){
%>
<%if(rs1.getString(8)==null){%>
<td class=rptvalue align="right">0</td>
<%}else{%>
<td class=rptvalue align="right"><%=rs1.getString(8)%></td>
<%}%>
<% if (rs1.getInt(1) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('FC','<%=rs2.getString(1)%>')"><%=rs1.getString(1)%></a></td>
<%} else{
	if(rs1.getString(1)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(1)%></td>
<%}} if (rs1.getInt(2) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('PC4','<%=rs2.getString(1)%>')"><%=rs1.getString(2)%></td>
<%}else{if(rs1.getString(2)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(2)%></td>
<%}}
if (rs1.getInt(3) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('PC3','<%=rs2.getString(1)%>')"><%=rs1.getString(3)%></td>
<%}else{if(rs1.getString(3)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(3)%></td>
<%}}
if (rs1.getInt(4) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('PC2','<%=rs2.getString(1)%>')"><%=rs1.getString(4)%></td>
<%}else{if(rs1.getString(4)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
<%}} 
if (rs1.getInt(5) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('PC1','<%=rs2.getString(1)%>')"><%=rs1.getString(5)%></td>
<%}else{if(rs1.getString(5)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(5)%></td>
<%}}
if (rs1.getInt(6) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('NC','<%=rs2.getString(1)%>')"><%=rs1.getString(6)%></td>
<%}else{if(rs1.getString(6)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(6)%></td>
<%}} 
if (rs1.getInt(7) > 0){%>
<td class=rptvalue align="right"><a href="#" onclick="fnHab('NSS','<%=rs2.getString(1)%>')"><%=rs1.getString(7)%></td>
<%}else{if(rs1.getString(7)==null){%>
	<td class=rptvalue align="right">0</td>
	<%}else{%>
	<td class=rptvalue align="right"><%=rs1.getString(7)%></td>
<%}}
}	%>

</tr>
<%
wtot+=rs.getInt(1);samt+=rs.getDouble(2);htot+=rs1.getInt(8);fc+=rs1.getInt(1);
pc4+=rs1.getInt(2); pc3+=rs1.getInt(3); pc2+=rs1.getInt(4); dhtot+=rs.getInt(3);
pc1+=rs1.getInt(5);  nc+=rs1.getInt(6); nss+=rs1.getInt(7);
}}%>
<tr>
<td class=btext colspan=2 align="center">Total</td>
<td class=btext align="right"><%=wtot%></td>
<td class=btext align="right"><%=ndf.format(samt)%></td>
<td class=btext align="right"><%=dhtot%></td>
<td class=btext align="right"><%=htot%></td>
<td class=btext align="right"><a href="#" onclick="fnHab('FC','dist')"><%=fc%></td>
<td class=btext align="right"><a href="#" onclick="fnHab('PC4','dist')"><%=pc4%></td>
<td class=btext align="right"><a href="#" onclick="fnHab('PC3','dist')"><%=pc3%></td>
<td class=btext align="right"><a href="#" onclick="fnHab('PC2','dist')"><%=pc2%></td>
<td class=btext align="right"><a href="#" onclick="fnHab('PC1','dist')"><%=pc1%></td>
<%if(nc>0){%>
<td class=btext align="right"><a href="#" onclick="fnHab('NC','dist')"><%=nc%></td>
<%} else{%><td class=btext align="right"><%=nc%></td> <%}
if(nss>0){%>
<td class=btext align="right"><a href="#" onclick="fnHab('NSS','dist')"><%=nss%></td>
<%} else {%>
<td class=btext align="right"><%=nss%></td>
<%}%>
</tr>
</form>
<%@ include file = "/reports/connClose1.jsp" %>