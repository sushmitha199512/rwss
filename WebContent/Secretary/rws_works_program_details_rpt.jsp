<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
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
	String financialyr="";
	
    double aas=0;
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialyr=request.getParameter("finyear");
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
   
session.setAttribute("financialyr",financialyr);
String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
    String endyr1 =financialyr.substring(5,9);



String scheme="";
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("scheme",scheme);
}
	
	
	String[] programes=request.getParameterValues("program");
	
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	////System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	////System.out.println("programe::"+programe);
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
 


String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();


if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}


String dcode=request.getParameter("dcode");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

////System.out.println("dcode"+dcode);
////System.out.println("DivCode"+divCode);


	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a><a href="./rws_works_program_details_excel.jsp" target=_new >Excel|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b>Note:Based On the Physical  Completion date.</b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr >
		<td align="center" class=gridhdbg colspan=35>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=gridhdbg  rowspan=3>Sl.No</td>
		<td class=gridhdbg  rowspan=3>District</td>
<td class=gridhdbg   align=center colspan=17 >Spill Over Works</td>
<td class=gridhdbg  colspan=15 align=center >New Works</td>
</tr>
<tr>
		<td class=gridhdbg  align="center"  colspan=3>No.of Works</td>

		<td  class=gridhdbg  align="center"  rowspan=2>Est.Cost</td>
		<td  class=gridhdbg  align="center"  rowspan=2>Exp.Upto 31.3.<%=startyr%></td>
		<td class=gridhdbg  align="center"  rowspan=2>Bal Est.Cost as on 31.3.<%=startyr%><br>(5-6)</td>
 <td  class=gridhdbg  align="center"  colspan=2>Releases During <br><%=financialyr %></td>	
		<td  class=gridhdbg  align="center"  colspan=2>Expenditure During <br><%=financialyr %></td>	
		<td  class=gridhdbg  align="center"  colspan=2>No.of.Works Completed<br><%=financialyr %></td>
		<td  class=gridhdbg  align="center"  rowspan=2>Habs Sanctioned</td>	
<td  class=gridhdbg  align="center"  rowspan=2>Habs Covered Up to 31.3.<%=startyr %></td>	
<td  class=gridhdbg  align="center"  rowspan=2>Balance Habs as on 31.3.<%=startyr %></td>	
<td  class=gridhdbg  align="center"  colspan=2>Habs Covered during <br><%=financialyr %></td>	
<td class=gridhdbg  align="center"  colspan=3>No.of Works</td>
		<td  class=gridhdbg  align="center"  rowspan=2>Est.Cost</td>
<td  class=gridhdbg  align="center"  colspan=2>Releases During <br><%=financialyr %></td>
		<td  class=gridhdbg  align="center"  colspan=2>Expenditure During <br><%=financialyr %></td>	
		<td class=gridhdbg  align="center"  rowspan=2>Bal Est.Cost </td>

		<td  class=gridhdbg  align="center"  colspan=2>No.of.Works Completed <br><%=financialyr %></td>
		<td  class=gridhdbg  align="center"  rowspan=2>Habs Sanctioned</td>	
<td  class=gridhdbg  align="center"  colspan=2>Habs Covered during <br><%=financialyr %></td>	


		
	


</tr>
<tr>
<td rowspan=1 colspan=1  class=gridhdbg  align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=gridhdbg  align="center">MVS</td>	
		<td rowspan=1  colspan=1 class=gridhdbg  align="left">Total</td>
<td rowspan=1 colspan=1   class=gridhdbg  align="center">Rel.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Rel. During (<%=cmonth %>)</td>
	<td rowspan=1 colspan=1   class=gridhdbg  align="center">Exp.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Exp. During (<%=cmonth %>)</td>
	<td rowspan=1 colspan=1   class=gridhdbg  align="center">Completed.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Completed. During (<%=cmonth %>)</td>

	<td rowspan=1 colspan=1   class=gridhdbg  align="center">Covered.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Covered. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1  class=gridhdbg  align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=gridhdbg  align="center">MVS</td>	
		<td rowspan=1  colspan=1 class=gridhdbg  align="left">Total</td>
<td rowspan=1 colspan=1    class=gridhdbg  align="center">Rel.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1    class=gridhdbg  align="center">Rel. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1    class=gridhdbg  align="center">Exp.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1    class=gridhdbg  align="center">Exp. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1   class=gridhdbg  align="center">Completed.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Completed. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1   class=gridhdbg  align="center">Covered.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1   class=gridhdbg  align="center">Covered. During (<%=cmonth %>)</td>

</tr>

<tr><td align="center" class=gridhdbg >1</td><td align="center" class=gridhdbg >2</td><td align="center" class=gridhdbg >3</td><td align="center" class=gridhdbg  colspan=3 >4</td><td align="center" class=gridhdbg  >5</td><td align="center" class=gridhdbg >6</td><td align="center" class=gridhdbg >7</td><td align="center" colspan=2 class=gridhdbg >8</td><td align="center" class=gridhdbg  colspan=2>9</td><td align="center" colspan=2 class=gridhdbg >10</td><td align="center" class=gridhdbg >11</td><td align="center" class=gridhdbg >12</td><td align="center" class=gridhdbg >13</td><td align="center" class=gridhdbg  colspan=2>14</td><td align="center"  class=gridhdbg >15</td><td align="center" class=gridhdbg  >16</td><td align="center"  class=gridhdbg >17</td><td align="center" class=gridhdbg  >18</td><td align="center" class=gridhdbg  colspan=2>19</td><td align="center" class=gridhdbg  colspan=2>20</td><td align="center" class=gridhdbg >21</td><td align="center" class=gridhdbg >22</td><td align="center" class=gridhdbg >23</td><td align="center" class=gridhdbg >24</td><td align="center" class=gridhdbg >25</td></tr>


<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/

	String newWorksQuery="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
 if(scheme!=null && !scheme.equals("")){
          newWorksQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksQuery+=" and  w.programme_code in ("+programe+")  group by  substr(office_code,2,2) order by 1";

	Statement	stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksQuery);
	Hashtable newWorks=new Hashtable();
	while(rs2.next())
	{
		newWorks.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



	String newWorksEstCostQuery="select substr(office_code,2,2),sum(w.sanction_amount) FROM RWS_WORK_ADMN_TBL W where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newWorksEstCostQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksEstCostQuery+=" and w.programme_code in ("+programe+")  group by  substr(office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(newWorksEstCostQuery);
	Hashtable newWorksEst=new Hashtable();
	while(rs2.next())
	{
		newWorksEst.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksCompQuery="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery+="and w.type_of_asset in("+scheme+")";
}


newWorksCompQuery+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksCompQuery);
	 rs2=stmt3.executeQuery(newWorksCompQuery);
	Hashtable newWorksComp=new Hashtable();
	while(rs2.next())
	{
		newWorksComp.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksCompQuery1="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery1+="and w.type_of_asset in("+scheme+")";
}


newWorksCompQuery1+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-"+cmonth+"-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) group by substr(office_code,2,2) order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksCompQuery1"+newWorksCompQuery1);
	 rs2=stmt3.executeQuery(newWorksCompQuery1);
	Hashtable newWorksComp1=new Hashtable();
	while(rs2.next())
	{
		newWorksComp1.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




	String newWorksExpQuery="select substr(office_code,2,2),sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+endyr1+"') then voucher_Amt else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksExpQuery+="and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksExpQuery"+newWorksExpQuery);
	 rs2=stmt3.executeQuery(newWorksExpQuery);
	Hashtable newWorksExp=new Hashtable();
	while(rs2.next())
	{
		newWorksExp.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWorksCurExpQuery="select substr(office_code,2,2),sum(case when (to_date(voucher_dt)>= '01-"+cmonth+"-"+startyr+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+endyr1+"') then voucher_Amt else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCurExpQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksCurExpQuery+=" and   w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksCurExpQuery"+newWorksCurExpQuery);
	 rs2=stmt3.executeQuery(newWorksCurExpQuery);
	Hashtable newWorksCurExp=new Hashtable();
	while(rs2.next())
	{
		newWorksCurExp.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String newCurRelBankQuery="select substr(W.office_code,2,2),sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-"+cmonth+"-"+startyr+"' and to_date(BANK_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end) FROM RWS_WORK_ADMN_TBL W ,RWS_bill_bank_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newCurRelBankQuery+="and w.type_of_asset in("+scheme+")";
}
newCurRelBankQuery+=" and a.TXID  is not null and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  substr(W.office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newCurRelBankQuery"+newCurRelBankQuery);
	 rs2=stmt3.executeQuery(newCurRelBankQuery);
	Hashtable newRelBank=new Hashtable();
	while(rs2.next())
	{
		newRelBank.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newCurRelpaoQuery="select substr(W.office_code,2,2),sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(STATE_SEND_DATE) < '01-"+cmonth+"-"+startyr+"') then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-"+cmonth+"-"+startyr+"' and to_date(STATE_SEND_DATE)< '01-"+nextmonth+"-"+startyr+"') then BILL_AMOUT_STATE else 0 end) FROM RWS_WORK_ADMN_TBL W ,RWS_bill_pao_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null ";
 if(scheme!=null && !scheme.equals("")){
          newCurRelpaoQuery+="and w.type_of_asset in("+scheme+")";
}
newCurRelpaoQuery+=" and a.STATE_TXID  is not null and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  substr(W.office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newCurRelpaoQuery"+newCurRelpaoQuery);
	 rs2=stmt3.executeQuery(newCurRelpaoQuery);
	Hashtable newRelpao=new Hashtable();
	while(rs2.next())
	{
		newRelpao.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();











String newWorksHabs="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
if(scheme!=null && !scheme.equals("")){
          newWorksHabs+="and w.type_of_asset in("+scheme+")";
}
newWorksHabs+=" and  w.programme_code in ("+programe+")  group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksHabs"+newWorksHabs);
	 rs2=stmt3.executeQuery(newWorksHabs);
	Hashtable newWorkshabs=new Hashtable();
	while(rs2.next())
	{
		newWorkshabs.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

String newWorksMVSQ="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and w.category_code='1'  ";
if(scheme!=null && !scheme.equals("")){
          newWorksMVSQ+="and w.type_of_asset in("+scheme+")";
}
newWorksMVSQ+=" and   w.programme_code in ("+programe+")  group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksMVSQ"+newWorksMVSQ);
	 rs2=stmt3.executeQuery(newWorksMVSQ);
	Hashtable newWorksMVS=new Hashtable();
	while(rs2.next())
	{
		newWorksMVS.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();
String newWorksSVSQ="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and w.category_code='2'  ";
if(scheme!=null && !scheme.equals("")){
          newWorksSVSQ+="and w.type_of_asset in("+scheme+")";
}
newWorksSVSQ+=" and  w.programme_code in ("+programe+")  group by  substr(office_code,2,2)  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksSVSQ"+newWorksSVSQ);
	 rs2=stmt3.executeQuery(newWorksSVSQ);
	Hashtable newWorksSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksSVS.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWoksCoveredHabs="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_COMP_HAB_LNK_TBL c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
if(scheme!=null && !scheme.equals("")){
          newWoksCoveredHabs+="and w.type_of_asset in("+scheme+")";
}
newWoksCoveredHabs+=" and  w.programme_code in ("+programe+")  and w.work_id in(select work_id from rws_work_completion_tbl where (((to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) or ((to_date(PARTIAL_DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(PARTIAL_DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) )) group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWoksCoveredHabs"+newWoksCoveredHabs);
	 rs2=stmt3.executeQuery(newWoksCoveredHabs);
	Hashtable newWorksCoveredhabs=new Hashtable();
	while(rs2.next())
	{
		newWorksCoveredhabs.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWoksCoveredHabs1="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_COMP_HAB_LNK_TBL c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null  ";
if(scheme!=null && !scheme.equals("")){
          newWoksCoveredHabs1+="and w.type_of_asset in("+scheme+")";
}
newWoksCoveredHabs1+=" and  w.programme_code in ("+programe+")  and w.work_id in(select work_id from rws_work_completion_tbl where ((to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"') or (to_date(PARTIAL_DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(PARTIAL_DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) ) group by  substr(office_code,2,2)  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWoksCoveredHabs1"+newWoksCoveredHabs1);
	 rs2=stmt3.executeQuery(newWoksCoveredHabs1);
	Hashtable newWorksCoveredhabs1=new Hashtable();
	while(rs2.next())
	{
		newWorksCoveredhabs1.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();






/*************************END ************************************************/





/******   Spil over Works *****************************************************/
String spillOverWorks="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+")  ";

if(scheme!=null && !scheme.equals("")){
          spillOverWorks+="and w.type_of_asset in("+scheme+")";
}
 spillOverWorks+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1";

//System.out.println("Spill Over"+spillOverWorks);
	Statement	stmt4=conn.createStatement();
	ResultSet rs3=stmt4.executeQuery(spillOverWorks);
		Hashtable spillOver=new Hashtable();
	while(rs3.next())
	{
		spillOver.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverMVSQ="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W  where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"' and  w.category_code='1' and  work_cancel_dt is null   and w.programme_code in ("+programe+")  ";
if(scheme!=null && !scheme.equals("")){
          spillOverMVSQ+="and w.type_of_asset in("+scheme+")";
}
spillOverMVSQ+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1";

//System.out.println("spillOverMVS"+spillOverMVSQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverMVSQ);
		Hashtable spillOverMVS=new Hashtable();
	while(rs3.next())
	{
		spillOverMVS.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverSVSQ="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and  w.category_code='2' and work_cancel_dt is null   ";
if(scheme!=null && !scheme.equals("")){
          spillOverSVSQ+="and w.type_of_asset in("+scheme+")";
}
spillOverSVSQ+=" and  w.programme_code in ("+programe+")  and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1";

//System.out.println("spillOverSVSQ"+spillOverSVSQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverSVSQ);
		Hashtable spillOverSVS=new Hashtable();
	while(rs3.next())
	{
		spillOverSVS.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverEstQ="SELECT substr(office_code,2,2),sum(w.sanction_amount)  FROM RWS_WORK_ADMN_TBL W  where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+")  ";
if(scheme!=null && !scheme.equals("")){
          spillOverEstQ+="and w.type_of_asset in("+scheme+")";
}
spillOverEstQ+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1";

////System.out.println("Spill Over"+spillOverEstQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverEstQ);
		Hashtable spillOverEst=new Hashtable();
	while(rs3.next())
	{
		spillOverEst.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverComp="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W  where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp+="and w.type_of_asset in("+scheme+")";
}
 spillOverComp+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) group by  substr(office_code,2,2)  order by 1";

////System.out.println("SpillComplete"+spillOverComp);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp);
		Hashtable spillOverCom=new Hashtable();
	while(rs3.next())
	{
		spillOverCom.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverComp1="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W  where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp1+="and w.type_of_asset in("+scheme+")";
}
 spillOverComp1+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) group by  substr(office_code,2,2)  order by 1";

////System.out.println("SpillComplete1"+spillOverComp1);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp1);
		Hashtable spillOverCom1=new Hashtable();
	while(rs3.next())
	{
		spillOverCom1.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverHabsCovered="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverHabsCovered+="and w.type_of_asset in("+scheme+")";
}
 spillOverHabsCovered+="and  w.work_id  in (select work_id from rws_work_completion_tbl where ((to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) or ((to_date(PARTIAL_DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(PARTIAL_DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"') )) group by  substr(office_code,2,2)  order by 1";

//System.out.println("spillOverHabsCovered"+spillOverHabsCovered);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverHabsCovered);
		Hashtable spillOverHabsCov=new Hashtable();
	while(rs3.next())
	{
		spillOverHabsCov.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverHabsCovered1="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverHabsCovered1+="and w.type_of_asset in("+scheme+")";
}
 spillOverHabsCovered1+="and  w.work_id  in (select work_id from rws_work_completion_tbl where ((to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) or ((to_date(PARTIAL_DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(PARTIAL_DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"'))  ) group by  substr(office_code,2,2)  order by 1";

////System.out.println("spillOverHabsCovered"+spillOverHabsCovered);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverHabsCovered1);
		Hashtable spillOverHabsCov1=new Hashtable();
	while(rs3.next())
	{
		spillOverHabsCov1.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();







String spillExpQuery="SELECT substr(office_code,2,2),sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+endyr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id    and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillExpQuery+="and w.type_of_asset in("+scheme+")";
}
spillExpQuery+=" and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1"; 

//System.out.println("spillExpQuery"+spillExpQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillExpQuery);
		Hashtable spillOverExp=new Hashtable();
	while(rs3.next())
	{
		spillOverExp.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillExpCurrentMon="SELECT substr(office_code,2,2),sum(case when (to_date(voucher_dt)>= '01-"+cmonth+"-"+endyr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+endyr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id    and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillExpCurrentMon+="and w.type_of_asset in("+scheme+")";
}
spillExpCurrentMon+=" and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1"; 

//System.out.println("spillExpCurrentMon"+spillExpCurrentMon);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillExpCurrentMon);
		Hashtable spillOverExpCurMon=new Hashtable();
	while(rs3.next())
	{
		spillOverExpCurMon.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillRelBankQuery="SELECT substr(W.office_code,2,2),sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(BANK_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)  FROM RWS_WORK_ADMN_TBL W ,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id    and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelBankQuery+="and w.type_of_asset in("+scheme+")";
}
spillRelBankQuery+=" and  a.TXID is not null and  a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(W.office_code,2,2)  order by 1"; 

//System.out.println("spillRelBankQuery"+spillRelBankQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelBankQuery);
		Hashtable spillOverRelBank=new Hashtable();
	while(rs3.next())
	{
		spillOverRelBank.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillRelPaoQuery="SELECT substr(W.office_code,2,2),sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and  to_date(STATE_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(STATE_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)  FROM RWS_WORK_ADMN_TBL W ,RWS_bill_pao_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id    and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelPaoQuery+="and w.type_of_asset in("+scheme+")";
}
spillRelPaoQuery+=" and   a.STATE_TXID  is not null and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(W.office_code,2,2)  order by 1"; 

//System.out.println("spillRelPaoQuery"+spillRelPaoQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelPaoQuery);
		Hashtable spillOverRelPao=new Hashtable();
	while(rs3.next())
	{
		spillOverRelPao.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();





//SELECT substr(office_code,2,2),sum(case when (to_date(BANK_SEND_DATE)> '01-Apr-2012' and to_date(BANK_SEND_DATE)< '01-OCT-2012') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>= '01-OCT-2012' and to_date(BANK_SEND_DATE)< '01-APR-2013') then BILL_AMOUNT_CENTRAL else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-2012'   and a.work_id=w.work_id    and w.programme_code in (01,02,18,23,32,48,49,51,53,58,59,60) and w.type_of_asset in(01,02,03,04,05,06,07,08,09,10,11,12) and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by  substr(office_code,2,2)  order by 1





String spillHabsCover="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl c where w.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null   and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillHabsCover+="and w.type_of_asset in("+scheme+")";
}
 spillHabsCover+=" and   w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  substr(office_code,2,2)  order by 1";
//System.out.println("spillHabsCover"+spillHabsCover);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillHabsCover);
		Hashtable spillhabsCov=new Hashtable();

	while(rs3.next())
	{
		spillhabsCov.put(rs3.getString(1),rs3.getString(2));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();







	int styleCount=0;
	String style="";



/***********************************End  ************************************/

String query="";
if(!loggedUser.equals(Constants.SEC_USER)){
if(dcode!=null && divCode!=null && !dcode.equals("") && !loggedUser.equals(Constants.GUEST)){
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

query=" select *from rws_district_tbl";
if(dcode!=null && !dcode.equals("")){
	query+=" where dcode='"+dcode+"'";
}
//System.out.println("query 1111111"+query);
//System.out.println("Data:"+query);
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
exp=(String)spillOverExp.get(rs1.getString(1));
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
nexp=(String)newWorksExp.get(rs1.getString(1));
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

String e=(String)spillOverExpCurMon.get(rs1.getString(1));
if(e!=null){
    spcur=(Double.parseDouble((String)spillOverExpCurMon.get(rs1.getString(1))));
    spcur=spcur/100000;
}
String e1=(String)newWorksCurExp.get(rs1.getString(1));
if(e1!=null){
    ncurexp=(Double.parseDouble((String)newWorksCurExp.get(rs1.getString(1))));
    ncurexp=ncurexp/100000;
}

String srelban=(String)spillOverRelBank.get(rs1.getString(1));
if(srelban!=null){
   String []aa=srelban.split("@");
String a1=aa[0];
String a2=aa[1];
 sbankUpto=Double.parseDouble(a1)/100000;
 sbankCur=Double.parseDouble(a2)/100000;
    
}
String srelpao=(String)spillOverRelPao.get(rs1.getString(1));
if(srelpao!=null){
      String []aa=srelpao.split("@");
String a1=aa[0];
String a2=aa[1];
 spaoUpto=Double.parseDouble(a1)/100000;
 spaoCur=Double.parseDouble(a2)/100000;
   
}

sbankUpto+=spaoUpto;
sbankCur+=spaoCur;

gsbankUpto+=sbankUpto;
gsbankCur+=sbankCur;



//NEW WORKS


String nrelban=(String)newRelBank.get(rs1.getString(1));
if(nrelban!=null){
   String []aa=nrelban.split("@");
String a1=aa[0];
String a2=aa[1];
 nbankUpto=Double.parseDouble(a1)/100000;
 nbankCur=Double.parseDouble(a2)/100000;
    
}
String nrelpao=(String)newRelpao.get(rs1.getString(1));
if(nrelpao!=null){
      String []aa=nrelpao.split("@");
String a1=aa[0];
String a2=aa[1];
 npaoUpto=Double.parseDouble(a1)/100000;
 npaoCur=Double.parseDouble(a2)/100000;
   
}

nbankUpto+=npaoUpto;
nbankCur+=npaoCur;

gnbankUpto+=nbankUpto;
gnbankCur+=nbankCur;


if(styleCount%2==0){
	 style="gridbg1";
}else{
	 style="gridbg2";
}
styleCount++;

%>
<tr>
<td class="<%=style %>" style="text-align: left;" ><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(2))){
dname=rs1.getString(2);
%>
<td  class="<%=style %>" style="text-align: left;" ><%=dname %></td>
<% }
else{
%>
<td  class="<%=style %>" style="text-align: left;" ></td>
<%} %>

<td class="<%=style %>" style="text-align: right;"  ><a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?cat=2&type=1&ccode=<%=rs1.getString(1) %> ')"><%= spillOverSVS.get(rs1.getString(1))==null?"0":(ssvs=(Integer.parseInt((String)spillOverSVS.get(rs1.getString(1))))) %></a></td>
<td class="<%=style %>" style="text-align: right;"  ><a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?cat=1&type=1&ccode=<%=rs1.getString(1) %> ')"><%= spillOverMVS.get(rs1.getString(1))==null?"0":(smvs=(Integer.parseInt((String)spillOverMVS.get(rs1.getString(1))))) %></a></td>
<td class="<%=style %>" style="text-align: right;"  > <a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?type=1&ccode=<%=rs1.getString(1) %> ')"><%= spillOver.get(rs1.getString(1))==null?"0":(tsworks=(Integer.parseInt((String)spillOver.get(rs1.getString(1))))) %></a></td>
<td class="<%=style %>" style="text-align: right;"  ><%= spillOverEst.get(rs1.getString(1))==null?"0":(tspSamAmount=(Double.parseDouble((String)spillOverEst.get(rs1.getString(1))))) %></td>

<%
sbal=tspSamAmount-expUpto;
 %>


<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(expUpto) %></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(sbal) %></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(sbankUpto) %></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(sbankCur) %></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(expCur) %></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%=ndf.format(spcur) %></td>

<td class="<%=style %>" style="text-align: right;"  ><%= spillOverCom.get(rs1.getString(1))==null?"0":(tspComleted=(Integer.parseInt((String)spillOverCom.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%= spillOverCom1.get(rs1.getString(1))==null?"0":(tspComleted1=(Integer.parseInt((String)spillOverCom1.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%= spillhabsCov.get(rs1.getString(1))==null?"0":(shabc=(Integer.parseInt((String)spillhabsCov.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;" ></td>
<td class="<%=style %>" style="text-align: right;"  ></td>
<td class="<%=style %>" style="text-align: right;" ><%= spillOverHabsCov.get(rs1.getString(1))==null?"0":(shabscov=(Integer.parseInt((String)spillOverHabsCov.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;" ><%= spillOverHabsCov1.get(rs1.getString(1))==null?"0":(shabscov1=(Integer.parseInt((String)spillOverHabsCov1.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;" ><a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?cat=2&type=2&ccode=<%=rs1.getString(1) %>')"><%= newWorksSVS.get(rs1.getString(1))==null?"0":(nsvs=Integer.parseInt((String)newWorksSVS.get(rs1.getString(1)))) %></a></td>
<td class="<%=style %>" style="text-align: right;" ><a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?cat=1&type=2&ccode=<%=rs1.getString(1) %>')"><%= newWorksMVS.get(rs1.getString(1))==null?"0":(nmvs=Integer.parseInt((String)newWorksMVS.get(rs1.getString(1)))) %></a></td>
<td class="<%=style %>" style="text-align: right;" > <a href="#" onclick="viewWorks('rws_perfomance_dril_spill_rpt.jsp?type=2&ccode=<%=rs1.getString(1) %>')"><%= newWorks.get(rs1.getString(1))==null?"0":(tnworws=Integer.parseInt((String)newWorks.get(rs1.getString(1)))) %></a></td>
<td class="<%=style %>" style="text-align: right;"  align=right><%= newWorksEst.get(rs1.getString(1))==null?"0":(tsancAmount=Double.parseDouble((String)newWorksEst.get(rs1.getString(1)))) %></td>

<%
nbal=tsancAmount-nexpCur;
 %>
<td class="<%=style %>" style="text-align: right;"  ><%=ndf.format(nbankUpto) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%=ndf.format(nbankCur) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%=ndf.format(nexpCur) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%=ndf.format(ncurexp) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%=ndf.format(tsancAmount) %></td>


<td class="<%=style %>" style="text-align: right;" ><%= newWorksComp.get(rs1.getString(1))==null?"0":(tnewWorksComp=Integer.parseInt((String)newWorksComp.get(rs1.getString(1)))) %></td>
<td class="<%=style %>" style="text-align: right;" ><%= newWorksComp1.get(rs1.getString(1))==null?"0":(tnewWorksComp1=Integer.parseInt((String)newWorksComp1.get(rs1.getString(1)))) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%= newWorkshabs.get(rs1.getString(1))==null?"0":(nhabc=(Integer.parseInt((String)newWorkshabs.get(rs1.getString(1))))) %></td>

<td class="<%=style %>" style="text-align: right;"  ><%= newWorksCoveredhabs.get(rs1.getString(1))==null?"0":(ncovhabs=(Integer.parseInt((String)newWorksCoveredhabs.get(rs1.getString(1))))) %></td>
<td class="<%=style %>" style="text-align: right;"  ><%= newWorksCoveredhabs1.get(rs1.getString(1))==null?"0":(ncovhabs1=(Integer.parseInt((String)newWorksCoveredhabs1.get(rs1.getString(1))))) %></td>

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
<tr><td colspan=2 class=gridhdbg  style="text-align: right;"  >Total:</td>

<td class=gridhdbg style="text-align: right;"  ><%=gssvs %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gsmvs %></td><td class=gridhdbg ><%=gtsworks %></td>
<td class=gridhdbg  style="text-align: right;"   ><%=ndf.format(gtspSamAmount) %></td><td class=gridhdbg  ><%=ndf.format(dexpUpto) %></td><td class=gridhdbg  ><%=ndf.format(gsbal) %></td>
<td class=gridhdbg style="text-align: right;"   ><%=ndf.format(gsbankUpto) %></td><td class=gridhdbg  ><%=ndf.format(gsbankCur) %></td>
<td class=gridhdbg style="text-align: right;"   ><%=ndf.format(dexpCur) %></td><td class=gridhdbg  ><%=ndf.format(gspcur) %></td>
<td class=gridhdbg style="text-align: right;"   ><%=gtspComleted %></td>
<td class=gridhdbg style="text-align: right;"   ><%=gtspComleted1 %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gshabc %></td>
<td class=gridhdbg style="text-align: right;"  ></td>
<td class=gridhdbg style="text-align: right;"  ></td>
<td class=gridhdbg style="text-align: right;" ><%=gshabscov %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gshabscov1 %></td>

<td class=gridhdbg style="text-align: right;"  ><%=gnsvs %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gnmvs %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gtnworws %></td>
<td class=gridhdbg  style="text-align: right;"  ><%=ndf.format(gtsancAmount) %></td>



<td class=gridhdbg  style="text-align: right;"  ><%=ndf.format(gnbankUpto) %></td>
<td class=gridhdbg  style="text-align: right;"  ><%=ndf.format(gnbankCur) %></td>


<td class=gridhdbg style="text-align: right;"  ><%=ndf.format(dnexpCur) %></td>
<td class=gridhdbg  style="text-align: right;"  ><%=ndf.format(gncurexp) %></td>

<td class=gridhdbg style="text-align: right;"  ><%=ndf.format(gtsancAmount) %></td>

<td class=gridhdbg  style="text-align: right;" > <%=gtnewWorksComp %></td>
<td class=gridhdbg  style="text-align: right;"  > <%=gtnewWorksComp1 %></td>

<td class=gridhdbg style="text-align: right;"  ><%=gnhabc %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gncovhabs %></td>
<td class=gridhdbg style="text-align: right;"  ><%=gncovhabs1 %></td>
</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>