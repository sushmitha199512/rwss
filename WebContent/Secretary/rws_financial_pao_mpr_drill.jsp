<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<form name="f1">
<%
java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;

String dcode="",constituencyCode="",constituencyName="",dname="";
if(dcode.equals("") || dcode==null)
	dcode=(String)request.getParameter("dcode");
if(constituencyCode.equals("") || constituencyCode==null)
	constituencyCode=(String)request.getParameter("constituencyCode");
if(dname.equals("") || dname==null)
	dname=(String)request.getParameter("dname");
if(constituencyName.equals("") || constituencyName==null)
	constituencyName=(String)request.getParameter("constituencyName");


//System.out.println("dcode"+dcode);
//System.out.println("constituencyCode"+constituencyCode);

int sno=1;
String cDate=null;
int year=Integer.parseInt(RwsUtils.getCurrentYear());
int year1=year+1;
String finYear=year+"-"+(year+1);
//System.out.println("Year:"+finYear);
String stankCode=null;
boolean flag=false;
%>
<style type="text/css" media="print">
@page
{
	size: landscape;
	margin: 2cm;
}
</style>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js">
<script type="text/javascript">
function fnSubmit()
{
  var d=document.getElementById('demo1').value;//date value
  document.f1.action="./rws_physical_bank_mpr_rpt.jsp";
  document.f1.mydate.value=d; 
  document.f1.submit();

}
</script>
<input type="hidden" name="mydate" >
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
	
				 <td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;&nbsp; <a href="#" onclick="window.close()">Close</a> &nbsp;<a href="#" onclick="window.print()"><img src="../images/print_icon.jpg"></a>
				</td>
			
			</tr>  
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="17"> <font color="red"><b>Amount in Rupees.</b></font></td>
</tr>	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="17">PAO Financial MPR:<%= finYear %> For <%=dname %> District And <%=constituencyName %></td>
</tr>
<tr>
      <td class=btext>S.No</td>
      <td class=btext align=center>WorkId</td>
      <td class=btext align=center>WorkName</td>
      <td class=btext align=center>Mandal</td>
      <td class=btext align=center>Panchayat</td>
      <td class=btext align=center>Village</td>
      <td class=btext align=center>Habitation Code/Habitation Name</td>
      <td class=btext align=center>Population</td>
      <td class=btext align=center>Bill Amount for Work</td>
      <td class=btext align=center>Amount for Habitation</td>
</tr>	
   <%
 try
{ double AmountForWork=0,TotAmountForHab=0,TotAmountForWork=0;
int TotPopForWork=0;
	String ConBillWorksRepQry="select nvl(sum(bill_amout_state),'0') as AmountforWork,a.work_id,b.WORK_NAME,com.MNAME,com.VNAME,com.PNAME,com.PANCH_CODE,com.PANCH_NAME,sum(nvl(com.CENSUS_PLAIN_POPU,0)+nvl(com.CENSUS_SC_POPU,0)+nvl(com.CENSUS_ST_POPU,0)) as population from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b,RWS_CONSTITUENCY_TBL c,RWS_ADMN_HAB_LNK_TBL d,rws_complete_hab_view com where to_date(state_send_date) >='01-APR-"+year+"' and to_date(state_send_date) <='31-MAR-"+year1+"' and STATE_TXID is not null AND substr(a.office_code,2,2)='"+dcode+"' and a.work_id=b.work_id and d.hab_code=com.panch_code and substr(d.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+constituencyCode+"' and a.work_id=d.work_id group by a.work_id,b.WORK_NAME,com.MNAME,com.VNAME,com.PNAME,com.PANCH_CODE,com.PANCH_NAME order by a.work_id"; 
	/* String ConBillWorksRepQry="select a.work_id,b.WORK_NAME,com.MNAME,com.VNAME,com.PNAME,com.PANCH_CODE,com.PANCH_NAME,sum(nvl(com.CENSUS_PLAIN_POPU,0)+nvl(com.CENSUS_SC_POPU,0)+nvl(com.CENSUS_ST_POPU,0)) as population from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b,RWS_CONSTITUENCY_TBL c,rws_complete_hab_view com where to_date(state_send_date) >='01-APR-"+year+"' and to_date(state_send_date) <='31-MAR-"+year1+"' and txid is not null AND substr(a.office_code,2,2)='"+dcode+"' and a.work_id=b.work_id and lead_habitation=com.panch_code and substr(lead_habitation,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+constituencyCode+"'  group by a.work_id,b.WORK_NAME,com.MNAME,com.VNAME,com.PNAME,com.PANCH_CODE,com.PANCH_NAME order by a.work_id"; */
	
 	 System.out.println(ConBillWorksRepQry);
 	 stmt3=conn.createStatement();	
	 rs3=stmt3.executeQuery(ConBillWorksRepQry);	
	while (rs3.next())
	{
		double AmountForHab=0;
		/*  String PopQry="select nvl(nvl('"+rs3.getString("AmountforWork")+"'/sum(nvl(COM.CENSUS_PLAIN_POPU,0)+nvl(COM.CENSUS_SC_POPU,0)+nvl(COM.CENSUS_ST_POPU,0)),0)*('"+rs3.getString("population")+"'),0)  from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b,RWS_ADMN_HAB_LNK_TBL d,rws_complete_hab_view com where to_date(state_send_date) >='01-APR-"+year+"' and to_date(state_send_date) <='31-MAR-"+year1+"' and txid is not null AND substr(a.office_code,2,2)='"+dcode+"' and a.work_id=b.work_id and d.hab_code=com.panch_code and a.work_id=d.work_id and a.work_id='"+rs3.getString("work_id") +"'"; */ 
	    String PopQry="select nvl(nvl('"+rs3.getString("AmountforWork")+"'/sum(nvl(COM.CENSUS_PLAIN_POPU,0)+nvl(COM.CENSUS_SC_POPU,0)+nvl(COM.CENSUS_ST_POPU,0)),0)*('"+rs3.getString("population")+"'),0)  from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b,RWS_ADMN_HAB_LNK_TBL d,rws_complete_hab_view com where to_date(state_send_date) >='01-APR-"+year+"' and to_date(state_send_date) <='31-MAR-"+year1+"' and STATE_TXID is not null AND substr(a.office_code,2,2)='"+dcode+"' and a.work_id=b.work_id and d.hab_code=com.panch_code and a.work_id=d.work_id and a.work_id='"+rs3.getString("work_id") +"'"; 
		//System.out.println("PopQry   "+PopQry);
		stmt2=conn.createStatement();	
		rs2=stmt2.executeQuery(PopQry);
		if(rs2.next()){
			AmountForHab=rs2.getDouble(1);
		}
		TotAmountForHab+=AmountForHab;
		rs2.close();
		stmt2.close();
		TotAmountForWork+=rs3.getDouble("AmountforWork");
 %>
   <tr >
	  <td class=rptValue NOWRAP><%=sno++ %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("work_id") %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("WORK_NAME") %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("MNAME") %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("PNAME") %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("VNAME") %></td>
	  <td class=rptValue NOWRAP ><%=rs3.getString("PANCH_CODE")%> &nbsp;/&nbsp; <%=rs3.getString("PANCH_NAME")%></td>
	  <td class=rptValue NOWRAP align=right><%=rs3.getString("population") %></td>
	  <td class=rptValue NOWRAP align=right><%=ndf.format(rs3.getDouble("AmountforWork")) %></td>
	  <td class=rptValue NOWRAP align=right><%=ndf.format(AmountForHab) %></td>
  </tr>  
  <%

	} 
    rs3.close();
    stmt3.close();  

%>
<tr>
<td class=rptValue NOWRAP></td>
<td class=btext align=right colspan=7><strong>Total</strong></td>
<td class=btext NOWRAP align=right><%-- <%=TotAmountForWork!=0?(ndf.format(TotAmountForWork)):"-" %> --%></td>
<td class=btext NOWRAP align=right><%=TotAmountForHab!=0?(ndf.format(TotAmountForHab)):"-" %></td> 
</tr>
</table>
<table>
<tr>
<td>
<font color="green" size="2">Note:</font>

</td>
</tr>
<!-- <tr>
<td>
<font color="red" size="2"> '*'</font><font size=1 color="red">Indicate Constituency wise Works Based On Lead habitation.</font>
</td>
</tr> -->
<tr>
<td>
<font color="blue" size="2"> '*'</font><font size=1 color="red">Indicate Constituency wise Works Based On Sanctioned habitations.</font>
</td>
</tr>
<%

}
catch(Exception e)
{
	e.printStackTrace();
	
}finally{
	if(conn!=null)
		conn.close();
}
%>
</table>
</form>



<center>
<%@ include file="/commons/rws_footer.jsp" %>
</center>



