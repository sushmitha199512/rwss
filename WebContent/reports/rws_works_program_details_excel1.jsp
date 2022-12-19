<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
</script>

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";
		financialstartyr=(String)session.getAttribute("financialyr");
String pname=(String)session.getAttribute("pname");
String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");
String programe=(String)session.getAttribute("programe");
String scheme=(String)session.getAttribute("scheme");
   
	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
    session.setAttribute("startyr",startyr);
     

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
   System.out.println("startyr"+startyr);
   System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;

String prevmonth=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}
	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b>Note:Based On the Physical  Completion date.</b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=35>General Abstract Report for the Financial Year(<%=session.getAttribute("financialstartyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>District</td>
<td class=btext rowspan=3>Division</td>
<td class=btext  align=center colspan=13 style="background-color:lightyellow">Spill Over Works</td>
<td class=btext colspan=10 align=center style="background-color:#d2b48c">New Works</td>
</tr>
<tr>
		<td class=btext align="center" style="background-color:lightyellow" colspan=3>No.of Works</td>

		<td  class=btext align="center" style="background-color:lightyellow" >Est.Cost</td>
		<td  class=btext align="center" style="background-color:lightyellow" >Exp.Upto 31.3.<%=startyr%></td>
		<td class=btext align="center" style="background-color:lightyellow" >Bal Est.Cost as on 31.3.<%=startyr%><br>(7-8)</td>
 <td  class=btext align="center"style="background-color:lightyellow"  >Releases During <br><%=financialstartyr %></td>	
		<td  class=btext align="center"style="background-color:lightyellow"  >Expenditure During <br><%=financialstartyr %></td>	
		<td  class=btext align="center" style="background-color:lightyellow" >No.of.Works Completed<br><%=financialstartyr %></td>
		<td  class=btext align="center" style="background-color:lightyellow" >Habs Sanctioned</td>	
<td  class=btext align="center" style="background-color:lightyellow" >Habs Covered Up to 31.3.<%=startyr %></td>	
<td  class=btext align="center" style="background-color:lightyellow" >Balance Habs as on 31.3.<%=startyr %></td>	
<td  class=btext align="center" style="background-color:lightyellow" >Habs Covered during <br><%=financialstartyr %></td>	
<td class=btext align="center" style="background-color:#d2b48c" colspan=3>No.of Works</td>
		<td  class=btext align="center" style="background-color:#d2b48c" >Est.Cost</td>
<td  class=btext align="center" style="background-color:#d2b48c" >Releases During <br><%=financialstartyr %></td>
		<td  class=btext align="center" style="background-color:#d2b48c" >Expenditure During <br><%=financialstartyr %></td>	
		<td class=btext align="center" style="background-color:#d2b48c" >Bal Est.Cost </td>

		<td  class=btext align="center" style="background-color:#d2b48c" >No.of.Works Completed <br><%=financialstartyr %></td>
		<td  class=btext align="center" style="background-color:#d2b48c" >Habs Sanctioned</td>	
<td  class=btext align="center" style="background-color:#d2b48c" >Habs Covered during <br><%=financialstartyr %></td>	


		
	


</tr>
<tr>
<td rowspan=1 colspan=1 style="background-color:lightyellow" class=btext align="center">SVS</td>	
		<td rowspan=1 style="background-color:lightyellow" colspan=1 class=btext align="center">MVS</td>	
		<td rowspan=1  style="background-color:lightyellow"colspan=1 class=btext align="left">Total</td>
<TD style="background-color:lightyellow"></TD><TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"> </TD><TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"></TD>
<TD style="background-color:lightyellow"></TD><TD style="background-color:lightyellow"></TD>
<td rowspan=1 colspan=1 style="background-color:#d2b48c" class=btext align="center">SVS</td>	
		<td rowspan=1 style="background-color:#d2b48c" colspan=1 class=btext align="center">MVS</td>	
		<td rowspan=1  style="background-color:#d2b48c"colspan=1 class=btext align="left">Total</td>
<TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD>
<TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD>
<TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD><TD style="background-color:#d2b48c"></TD>
</tr>

<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center"  class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext >14</td><td align="center"  class=btext>15</td><td align="center" class=btext >16</td><td align="center"  class=btext>17</td><td align="center" class=btext >18</td><td align="center" class=btext >19</td><td align="center" class=btext >20</td><td align="center" class=btext>21</td><td align="center" class=btext>22</td><td align="center" class=btext>23</td><td align="center" class=btext>24</td><td align="center" class=btext>25</td><td align="center" class=btext>26</td></tr>


<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/

	String newWorksQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

	Statement	stmt3=conn.createStatement();
System.out.println("New Works"+newWorksQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksQuery);
	Hashtable newWorks=new Hashtable();
	while(rs2.next())
	{
		newWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



	String newWorksEstCostQuery="select b.circle_office_code,b.division_office_code,sum(w.sanction_amount) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksEstCostQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksEstCostQuery+=" and w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();

System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(newWorksEstCostQuery);
	Hashtable newWorksEst=new Hashtable();
	while(rs2.next())
	{
		newWorksEst.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksCompQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery+="and w.type_of_asset in("+scheme+")";
}


newWorksCompQuery+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-APR-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("New Works"+newWorksCompQuery);
	 rs2=stmt3.executeQuery(newWorksCompQuery);
	Hashtable newWorksComp=new Hashtable();
	while(rs2.next())
	{
		newWorksComp.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	


	String newWorksExpQuery="select b.circle_office_code,b.division_office_code,sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-APR-"+endyr1+"') then voucher_Amt else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksExpQuery+=" and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("newWorksExpQuery"+newWorksExpQuery);
	 rs2=stmt3.executeQuery(newWorksExpQuery);
	Hashtable newWorksExp=new Hashtable();
	while(rs2.next())
	{
		newWorksExp.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String newCurRelBankQuery="select b.circle_office_code,b.division_office_code,sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-APR-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newCurRelBankQuery+="and w.type_of_asset in("+scheme+")";
}
newCurRelBankQuery+=" and a.TXID  is not null and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();

System.out.println("newCurRelBankQuery"+newCurRelBankQuery);
	 rs2=stmt3.executeQuery(newCurRelBankQuery);
	Hashtable newRelBank=new Hashtable();
	while(rs2.next())
	{
		newRelBank.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newCurRelpaoQuery="select b.circle_office_code,b.division_office_code,sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(STATE_SEND_DATE) < '01-APR-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_pao_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newCurRelpaoQuery+="and w.type_of_asset in("+scheme+")";
}
newCurRelpaoQuery+=" and a.STATE_TXID  is not null and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("newCurRelpaoQuery"+newCurRelpaoQuery);
	 rs2=stmt3.executeQuery(newCurRelpaoQuery);
	Hashtable newRelpao=new Hashtable();
	while(rs2.next())
	{
		newRelpao.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();











String newWorksHabs="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
if(scheme!=null && !scheme.equals("")){
          newWorksHabs+="and w.type_of_asset in("+scheme+")";
}
newWorksHabs+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("newWorksHabs"+newWorksHabs);
	 rs2=stmt3.executeQuery(newWorksHabs);
	Hashtable newWorkshabs=new Hashtable();
	while(rs2.next())
	{
		newWorkshabs.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

String newWorksMVSQ="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and w.category_code='1' and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
if(scheme!=null && !scheme.equals("")){
          newWorksMVSQ+="and w.type_of_asset in("+scheme+")";
}
newWorksMVSQ+=" and   w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("newWorksMVSQ"+newWorksMVSQ);
	 rs2=stmt3.executeQuery(newWorksMVSQ);
	Hashtable newWorksMVS=new Hashtable();
	while(rs2.next())
	{
		newWorksMVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();
String newWorksSVSQ="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and w.category_code='2' and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
if(scheme!=null && !scheme.equals("")){
          newWorksSVSQ+="and w.type_of_asset in("+scheme+")";
}
newWorksSVSQ+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksSVSQ"+newWorksSVSQ);
	 rs2=stmt3.executeQuery(newWorksSVSQ);
	Hashtable newWorksSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWoksCoveredHabs="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
if(scheme!=null && !scheme.equals("")){
          newWoksCoveredHabs+="and w.type_of_asset in("+scheme+")";
}
newWoksCoveredHabs+=" and  w.programme_code in ("+programe+")  and w.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-APR-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("newWoksCoveredHabs"+newWoksCoveredHabs);
	 rs2=stmt3.executeQuery(newWoksCoveredHabs);
	Hashtable newWorksCoveredhabs=new Hashtable();
	while(rs2.next())
	{
		newWorksCoveredhabs.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





/*************************END ************************************************/





/******   Spil over Works *****************************************************/
String spillOverWorks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+")  ";

if(scheme!=null && !scheme.equals("")){
          spillOverWorks+="and w.type_of_asset in("+scheme+")";
}
 spillOverWorks+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverWorks:"+spillOverWorks);
	Statement	stmt4=conn.createStatement();
	ResultSet rs3=stmt4.executeQuery(spillOverWorks);
		Hashtable spillOver=new Hashtable();
	while(rs3.next())
	{
		spillOver.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverMVSQ="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"' and  w.category_code='1' and  work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+")  ";
if(scheme!=null && !scheme.equals("")){
          spillOverMVSQ+="and w.type_of_asset in("+scheme+")";
}
spillOverMVSQ+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverMVS"+spillOverMVSQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverMVSQ);
		Hashtable spillOverMVS=new Hashtable();
	while(rs3.next())
	{
		spillOverMVS.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverSVSQ="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and  w.category_code='2' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  ";
if(scheme!=null && !scheme.equals("")){
          spillOverSVSQ+="and w.type_of_asset in("+scheme+")";
}
spillOverSVSQ+=" and  w.programme_code in ("+programe+")  and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverSVSQ"+spillOverSVSQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverSVSQ);
		Hashtable spillOverSVS=new Hashtable();
	while(rs3.next())
	{
		spillOverSVS.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverEstQ="SELECT b.circle_office_code,b.division_office_code,sum(w.sanction_amount)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+")  ";
if(scheme!=null && !scheme.equals("")){
          spillOverEstQ+="and w.type_of_asset in("+scheme+")";
}
spillOverEstQ+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("Spill Over"+spillOverEstQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverEstQ);
		Hashtable spillOverEst=new Hashtable();
	while(rs3.next())
	{
		spillOverEst.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverComp="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp+="and w.type_of_asset in("+scheme+")";
}
 spillOverComp+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-APR-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("SpillComplete"+spillOverComp);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp);
		Hashtable spillOverCom=new Hashtable();
	while(rs3.next())
	{
		spillOverCom.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverHabsCovered="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverHabsCovered+="and w.type_of_asset in("+scheme+")";
}
 spillOverHabsCovered+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-APR-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverHabsCovered"+spillOverHabsCovered);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverHabsCovered);
		Hashtable spillOverHabsCov=new Hashtable();
	while(rs3.next())
	{
		spillOverHabsCov.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String spillExpQuery="SELECT b.circle_office_code,b.division_office_code,sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-APR-"+endyr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillExpQuery+="and w.type_of_asset in("+scheme+")";
}
spillExpQuery+=" and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1"; 
System.out.println("spillExpQuery"+spillExpQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillExpQuery);
		Hashtable spillOverExp=new Hashtable();
	while(rs3.next())
	{
		spillOverExp.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillRelBankQuery="SELECT b.circle_office_code,b.division_office_code,sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-APR-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)   FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelBankQuery+="and w.type_of_asset in("+scheme+")";
}
spillRelBankQuery+=" and  a.TXID is not null and  a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1"; 
System.out.println("spillRelBankQuery"+spillRelBankQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelBankQuery);
		Hashtable spillOverRelBank=new Hashtable();
	while(rs3.next())
	{
		spillOverRelBank.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillRelPaoQuery="SELECT b.circle_office_code,b.division_office_code,sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and  to_date(STATE_SEND_DATE) < '01-APR-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)   FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_pao_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelPaoQuery+="and w.type_of_asset in("+scheme+")";
}
spillRelPaoQuery+=" and   a.STATE_TXID  is not null and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1"; 
System.out.println("spillRelPaoQuery"+spillRelPaoQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelPaoQuery);
		Hashtable spillOverRelPao=new Hashtable();
	while(rs3.next())
	{
		spillOverRelPao.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();





//SELECT b.circle_office_code,b.division_office_code,sum(case when (to_date(BANK_SEND_DATE)> '01-Apr-2012' and to_date(BANK_SEND_DATE)< '01-OCT-2012') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>= '01-OCT-2012' and to_date(BANK_SEND_DATE)< '01-APR-2013') then BILL_AMOUNT_CENTRAL else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-2012'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in (01,02,18,23,32,48,49,51,53,58,59,60) and w.type_of_asset in(01,02,03,04,05,06,07,08,09,10,11,12) and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by  b.circle_office_code,b.division_office_code  order by 1





String spillHabsCover="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c where w.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillHabsCover+="and w.type_of_asset in("+scheme+")";
}
 spillHabsCover+=" and   w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillHabsCover"+spillHabsCover);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillHabsCover);
		Hashtable spillhabsCov=new Hashtable();

	while(rs3.next())
	{
		spillhabsCov.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();











/***********************************End  ************************************/

String query="";
if(!loggedUser.equals(nic.watersoft.commons.Constants.SEC_USER)){
if(dcode!=null && divCode!=null && !dcode.equals("") && !loggedUser.equals(nic.watersoft.commons.Constants.GUEST)){
  if(divCode!=null && !divCode.equals("0")){
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' and a.division_office_code='"+divCode+"' order by circle_office_code ";
}else{
query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' order by circle_office_code ";
}
}else{

 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
}else{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
rs1=stmt2.executeQuery(query);
int  tnworws=0,tsworks=0,tspComleted=0,tnewWorksComp=0,shabc=0,nhabc=0,smvs=0,ssvs=0,nsvs=0,nmvs=0,ncovhabs=0,shabscov=0,tspComleted1=0,tnewWorksComp1=0,shabscov1=0,ncovhabs1=0,gncovhabs1=0;
double tsancAmount=0,tspSamAmount=0,expUpto=0,expCur=0,nexpUpto=0,nexpCur=0,sbal=0,nbal=0,gsbal=0,gnbal=0,spcur=0,gspcur=0,sbankUpto=0,spaoUpto=0,sbankCur=0,spaoCur=0,gsbankUpto=0,gsbankCur=0;
double nbankUpto=0,npaoUpto=0,nbankCur=0,npaoCur=0,gnbankUpto=0,gnbankCur=0;
int  gtnworws=0,gtsworks=0,gtspComleted=0,gtnewWorksComp=0,gshabc=0,gnhabc=0,gsmvs=0,gssvs=0,gnsvs=0,gnmvs=0,gncovhabs=0,gshabscov=0,gtspComleted1=0,gtnewWorksComp1=0,gshabscov1=0;
double gtsancAmount=0,gtspSamAmount=0,dexpUpto=0,dexpCur=0,dnexpUpto=0,dnexpCur=0,ncurexp=0,gncurexp=0;
String dname="";
String exp="",nexp="";
while(rs1.next()){
tsworks=0;
exp=(String)spillOverExp.get(rs1.getString(3)+rs1.getString(4));
if(exp!=null){
String []aa=exp.split("@");
String a1=aa[0];
String a2=aa[1];
 expUpto=Double.parseDouble(a1)/100000;
 expCur=Double.parseDouble(a2)/100000;
dexpUpto+=expUpto;
dexpCur+=expCur;
}else{
expUpto=0;
expCur=0;
}
nexp=(String)newWorksExp.get(rs1.getString(3)+rs1.getString(4));
if(nexp!=null){
String []aa=nexp.split("@");
String a1=aa[0];
String a2=aa[1];
 nexpUpto=Double.parseDouble(a1)/100000;
 nexpCur=Double.parseDouble(a2)/100000;
dnexpUpto+=nexpUpto;
dnexpCur+=nexpCur;
}else{
nexpUpto=0;
nexpCur=0;
}

System.out.print("exp:"+exp);

String srelban=(String)spillOverRelBank.get(rs1.getString(3)+rs1.getString(4));
String srelpao=(String)spillOverRelPao.get(rs1.getString(3)+rs1.getString(4));

if(srelpao!=null && !srelpao.equals("")){
sbankUpto=Double.parseDouble(srelpao);
}


if(srelban!=null && !srelban.equals(""))
{
sbankUpto+=Double.parseDouble(srelban);
}


sbankUpto/=100000;
gsbankUpto+=sbankUpto;


//NEW WORKS


String nrelban=(String)newRelBank.get(rs1.getString(3)+rs1.getString(4));

String nrelpao=(String)newRelpao.get(rs1.getString(3)+rs1.getString(4));


if(nrelban!=null && !nrelban.equals("")){
nbankUpto=Double.parseDouble(nrelban);
}


if(nrelpao!=null && !nrelpao.equals(""))
{
nbankUpto+=Double.parseDouble(nrelpao);
}

nbankUpto/=100000;
gnbankUpto+=nbankUpto;

%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>
<td class=rptValue ><%= spillOverSVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(ssvs=(Integer.parseInt((String)spillOverSVS.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%= spillOverMVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(smvs=(Integer.parseInt((String)spillOverMVS.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue > <a href=##" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?type=1&ccode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%= spillOver.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tsworks=(Integer.parseInt((String)spillOver.get(rs1.getString(3)+rs1.getString(4))))) %></a></td>
<td class=rptValue align=right><%= spillOverEst.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tspSamAmount=(Double.parseDouble((String)spillOverEst.get(rs1.getString(3)+rs1.getString(4))))) %></td>

<%
sbal=tspSamAmount-expUpto;
 %>


<td class=rptValue align=right><%=ndf.format(expUpto) %></td>
<td class=rptValue align=right><%=ndf.format(sbal) %></td>
<td class=rptValue align=right><%=ndf.format(sbankUpto) %></td>
<td class=rptValue align=right><%=ndf.format(expCur) %></td>

<td class=rptValue ><%= spillOverCom.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tspComleted=(Integer.parseInt((String)spillOverCom.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%= spillhabsCov.get(rs1.getString(3)+rs1.getString(4))==null?"0":(shabc=(Integer.parseInt((String)spillhabsCov.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td></td>
<td></td>
<td><%= spillOverHabsCov.get(rs1.getString(3)+rs1.getString(4))==null?"0":(shabscov=(Integer.parseInt((String)spillOverHabsCov.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue><%= newWorksSVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(nsvs=Integer.parseInt((String)newWorksSVS.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue><%= newWorksMVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(nmvs=Integer.parseInt((String)newWorksMVS.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue> <a href=##" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?type=2&ccode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%= newWorks.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tnworws=Integer.parseInt((String)newWorks.get(rs1.getString(3)+rs1.getString(4)))) %></a></td>
<td class=rptValue align=right><%= newWorksEst.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tsancAmount=Double.parseDouble((String)newWorksEst.get(rs1.getString(3)+rs1.getString(4)))) %></td>

<%
nbal=tsancAmount-nexpCur;
 %>
<td class=rptValue align=right><%=ndf.format(nbankUpto) %></td>
<td class=rptValue align=right><%=ndf.format(nexpCur) %></td>
<td class=rptValue align=right><%=ndf.format(tsancAmount) %></td>
<td class=rptValue><%= newWorksComp.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tnewWorksComp=Integer.parseInt((String)newWorksComp.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue ><%= newWorkshabs.get(rs1.getString(3)+rs1.getString(4))==null?"0":(nhabc=(Integer.parseInt((String)newWorkshabs.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%= newWorksCoveredhabs.get(rs1.getString(3)+rs1.getString(4))==null?"0":(ncovhabs=(Integer.parseInt((String)newWorksCoveredhabs.get(rs1.getString(3)+rs1.getString(4))))) %></td>
</tr>
<% 
gshabscov1+=shabscov1;
gncovhabs1+=ncovhabs1;
gtnewWorksComp1+=tnewWorksComp1;
gsbal+=sbal;
gnbal+=nbal;
nbal=0;
gtnworws+=tnworws;
gtsworks+=tsworks;
gtsancAmount+=tsancAmount;
gtspSamAmount+=tspSamAmount;
gtspComleted+=tspComleted;
gtspComleted1+=tspComleted1;
gtnewWorksComp+=tnewWorksComp;
gshabc+=shabc;
gsmvs+=smvs;
gssvs+=ssvs;
gncurexp+=ncurexp;
gshabscov+=shabscov;
tnworws=0;tsworks=0;
shabscov=0;
tsancAmount=0;
gnhabc+=nhabc;
gspcur+=spcur;
gnsvs+=nsvs;
gnmvs+=nmvs;
gncovhabs+=ncovhabs;
tnewWorksComp=0;tspComleted=0;tspSamAmount=0;tsworks=0;tnworws=0;nexpUpto=0;
nexpCur=0;
sbal=0;
expUpto=0;
spcur=0;ncurexp=0;
nmvs=0;
expCur=0;
nhabc=0;
nexpUpto=0;
ncovhabs=0;
nexpCur=0;nsvs=0;
shabc=0;ssvs=0;smvs=0;
sbankUpto=0;sbankCur=0;
spaoCur=0;
spaoUpto=0;
nbankUpto=0;nbankCur=0;
npaoCur=0;
npaoUpto=0;
shabscov1=0;
tnewWorksComp1=0;
ncovhabs1=0;
}
%>
<tr><td colspan=3 class=btext align=right>Total:</td>

<td class=btext><%=gssvs %></td>
<td class=btext><%=gsmvs %></td><td class=btext><%=gtsworks %></td>
<td class=btext align=right><%=ndf.format(gtspSamAmount) %></td><td class=btext align=right><%=ndf.format(dexpUpto) %></td><td class=btext align=right><%=ndf.format(gsbal) %></td>
<td class=btext align=right><%=ndf.format(gsbankUpto) %></td>
<td class=btext align=right><%=ndf.format(dexpCur) %></td>
<td class=btext ><%=gtspComleted %></td>
<td class=btext><%=gshabc %></td>
<td class=btext></td>
<td class=btext></td>
<td class=btext><%=gshabscov %></td>
<td class=btext><%=gnsvs %></td>
<td class=btext><%=gnmvs %></td>
<td class=btext><%=gtnworws %></td>
<td class=btext align=right><%=ndf.format(gtsancAmount) %></td>



<td class=btext align=right><%=ndf.format(gnbankUpto) %></td>

<td class=btext align=right><%=ndf.format(dnexpCur) %></td>


<td class=btext align=right><%=ndf.format(gtsancAmount) %></td>

<td class=btext > <%=gtnewWorksComp %></td>
<td class=btext><%=gnhabc %></td>
<td class=btext><%=gncovhabs %></td>
</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>