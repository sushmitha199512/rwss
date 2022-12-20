<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
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
<%
String dcode = request.getParameter("district");
String mcode = request.getParameter("mandal");
String dname = request.getParameter("dname");
String mname = request.getParameter("mname");
%>
<table border = 0 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse">
<tr><td  align="center" class=btext>Water Quality Data Format</td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=70%  bordercolor=#000000 style="border-collapse:collapse" class="striped">
<tr><td colspan=18 align="center" class=rptvalue><font color="red">District:&nbsp;&nbsp;<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Mandal:&nbsp;&nbsp;<%=mname%></font></td></tr>
<tr>
<td class=btext rowspan=2 align="center">Sl.No</td>
<td class=btext rowspan=2 align="center" >Panchayat</td>
<td class=btext rowspan=2 align="center" >Village</td>
<td class=btext rowspan=2 align="center" >HabCode</td>
<td class=btext rowspan=2 align="center" >Habitation</td>
<td class=btext rowspan=2 align="center" >Source Type</td>
<td class=btext rowspan=2 align="center" >Source Code</td>
<td class=btext rowspan=2 align="center" >Source Location</td>
<td class=btext rowspan=2 align="center" >Test Conducted Date</td>
<td class=btext colspan=9  align="center">Physico-Chemical Data</td>
</tr>
<tr>
  <td class=btext  align="center">PH</td>
  <td class=btext  align="center">Total Dissolved Solids<br>(in mg/lit.)</td>
  <td class=btext  align="center">Total Hardness as <br>CaCO3(in mg/lit.)</td>
  <td class=btext  align="center">Total Alkanity as <br>CaCO3(in mg/lit.)</td>
  <td class=btext  align="center">Fluoride as F(in mg/lit.)</td>
  <td class=btext  align="center">Chlorides as Cl(in mg/lit.)</td>
  <td class=btext  align="center">Nitrate (As NO3)</td>
  <td class=btext  align="center">Sulphate</td>
  <td class=btext  align="center">Iron </td>
</tr>
<%int cnt=0;
nic.watersoft.wquality.RwsWQualityData rwsdata=new  nic.watersoft.wquality.RwsWQualityData(); 
java.util.ArrayList sourcelist =new  java.util.ArrayList();
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null;
Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
Statement stmt4=conn.createStatement();
Statement stmt5=conn.createStatement();
Statement stmt6=conn.createStatement();
Statement stmt7=conn.createStatement();
Statement stmt8=conn.createStatement();
Statement stmt9=conn.createStatement();
Hashtable ht1=new Hashtable();
Hashtable ht2=new Hashtable();
Hashtable ht3=new Hashtable();
Hashtable ht4=new Hashtable();
Hashtable ht5=new Hashtable();
Hashtable ht6=new Hashtable();
Hashtable ht7=new Hashtable();
Hashtable ht8=new Hashtable();
Hashtable ht9=new Hashtable();

String qry1="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=04 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
	ht1.put(rs1.getString(1),rs1.getString(2));
}
String qry2="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=05 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs2=stmt2.executeQuery(qry2);
while(rs2.next())
{
	ht2.put(rs2.getString(1),rs2.getString(2));
}
String qry3="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=06 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs3=stmt3.executeQuery(qry3);
while(rs3.next())
{
	ht3.put(rs3.getString(1),rs3.getString(2));
}
String qry4="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=07 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs4=stmt4.executeQuery(qry4);
while(rs4.next())
{
	ht4.put(rs4.getString(1),rs4.getString(2));
}
String qry5="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=13 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs5=stmt5.executeQuery(qry5);
while(rs5.next())
{
	ht5.put(rs5.getString(1),rs5.getString(2));
}
String qry6="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=12 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs6=stmt6.executeQuery(qry6);
while(rs6.next())
{
	ht6.put(rs6.getString(1),rs6.getString(2));
}

String qry7="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=15 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs7=stmt7.executeQuery(qry7);
while(rs7.next())
{
	ht7.put(rs7.getString(1),rs7.getString(2));
}
String qry8="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=14 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs8=stmt8.executeQuery(qry8);
while(rs8.next())
{
	ht8.put(rs8.getString(1),rs8.getString(2));
}
String qry9="select  a.test_id,nvl(testing_parameter_value,0) from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id and b.test_code=1 and  a.testing_parameter_code=16 and substr(b.source_code,1,2)='"+dcode+"' and substr(b.source_code,6,2)='"+mcode+"'  ";
rs9=stmt9.executeQuery(qry9);
while(rs9.next())
{
	ht9.put(rs9.getString(1),rs9.getString(2));
}


Hashtable sl=rwsdata.getSourceNamess(dcode,mcode);
String qry="select distinct pname,vname,panch_code,panch_name,decode (source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701001','PONDS','0801001','OTHERS'),a.source_code,b.test_id,source_type,to_char(a.prepared_on,'dd/MM/yyyy'),a.prepared_on from rws_complete_hab_view v,rws_wq_test_results_tbl a,rws_water_sample_collect_tbl b where substr(a.source_code,1,16)=v.panch_code and a.test_id=b.test_id and b.source_code=a.source_code and a.test_code=b.test_code and a.test_code='1'  and substr(a.source_code,1,2)='"+dcode+"' and substr(a.source_code,6,2)='"+mcode+"'   order by pname,vname,panch_name,a.source_code,a.prepared_on";
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
String prvScode="";
while(rs.next())
{
	String ph=""+ht1.get(rs.getString(7));
	if(ph!=null && !ph.equals("") && !ph.equals("null")){} else{ ph="-";}
String nitrate=""+ht7.get(rs.getString(7));
	if(nitrate!=null && !nitrate.equals("") && !nitrate.equals("null")){} else{ nitrate="-";}
String sulphate=""+ht8.get(rs.getString(7));
	if(sulphate!=null && !sulphate.equals("") && !sulphate.equals("null")){} else{ sulphate="-";}
String iron=""+ht9.get(rs.getString(7));
	if(iron!=null && !iron.equals("") && !iron.equals("null")){} else{ iron="-";}
    String td=""+ht2.get(rs.getString(7));
	if(td!=null && !td.equals("") && !td.equals("null")){} else{ td="-";}
    String th=""+ht3.get(rs.getString(7));
	if(th!=null && !th.equals("") && !th.equals("null")){} else{ th="-";}
	String ta=""+ht4.get(rs.getString(7));
	if(ta!=null && !ta.equals("") && !ta.equals("null")){} else{ ta="-";}
	String fl=""+ht5.get(rs.getString(7));
	if(fl!=null && !fl.equals("") && !fl.equals("null")){} else{ fl="-";}
	String ch=""+ht6.get(rs.getString(7));
	if(ch!=null && !ch.equals("") && !ch.equals("null")){} else{ ch="-";}
	String loc=""+sl.get(rs.getString("source_code"));
	%>
  <tr>
    <%if(prvScode!=null && prvScode.equals("")){
		%>
	<td class=rptvalue><%=++cnt%></td>
    <td class=rptvalue><%=rs.getString(1)%></td>
    <td class=rptvalue><%=rs.getString(2)%></td>
    <td class=rptvalue><%=rs.getString(3)%></td>
    <td class=rptvalue><%=rs.getString(4)%></td>
    <td class=rptvalue><%=rs.getString(5)%></td>
    <td class=rptvalue><%=rs.getString(6)%></td>	
	<td class=rptvalue><%=loc%></td>
	<%}else{
             if(!prvScode.equals(rs.getString(6))) {
				 %>
				 <td class=rptvalue><%=++cnt%></td>
				<td class=rptvalue><%=rs.getString(1)%></td>
				<td class=rptvalue><%=rs.getString(2)%></td>
				<td class=rptvalue><%=rs.getString(3)%></td>
				<td class=rptvalue><%=rs.getString(4)%></td>
				<td class=rptvalue><%=rs.getString(5)%></td>
				<td class=rptvalue><%=rs.getString(6)%></td>
				<td class=rptvalue><%=loc%></td>
			 <%}else{
			   %>
			 <td class=rptvalue colspan=8></td>
			 <%}
	}%>
	<td class=rptvalue><%=rs.getString(9)%></td>
	 <td class=rptvalue align="right"><%=ph%></td>
	<td class=rptvalue align="right"><%=td%></td>
	<td class=rptvalue align="right"><%=th%></td>
    <td class=rptvalue align="right"><%=ta%></td>
	<td class=rptvalue align="right"><%=fl%></td>
	<td class=rptvalue align="right"><%=ch%></td>
	<td class=rptvalue align="right"><%=nitrate%></td>
	<td class=rptvalue align="right"><%=sulphate%></td>
	<td class=rptvalue align="right"><%=iron%></td>

	
     </tr>
<%
	prvScode=rs.getString(6);	 
	 
	 }

%>
</table>
<%@ include file = "/reports/connClose1.jsp" %>
<%@ include file="/commons/rws_footer.jsp"%>
