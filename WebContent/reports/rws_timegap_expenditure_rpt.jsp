<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String attend="";
int wno=0;
int gwno=0;
String a="";
int s=0;

String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
//System.out.println("From Date:"+fromdate);
Format formatter;


int day=Integer.parseInt(fromdate.substring(0,2));
int month=Integer.parseInt(fromdate.substring(3,5));
int year=Integer.parseInt(fromdate.substring(6,10));

int day1=Integer.parseInt(todate.substring(0,2));
int month1=Integer.parseInt(todate.substring(3,5));
int year1=Integer.parseInt(todate.substring(6,10));



System.out.println("Day:"+day);
System.out.println("Month:"+month);
System.out.println("year:"+year);


String months[]={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
 
 
 
String mnth=months[month-1];
String mnth1=months[month1-1];

 
 fromdate=day+"-"+mnth+"-"+year;
 todate=day1+"-"+mnth1+"-"+year1;


java.util.Date date = new java.util.Date(year-1900,month-1,day);
java.util.Date tdate1 = new java.util.Date(year-1900,month-1,10);
java.util.Date tdate2 = new java.util.Date(year-1900,month-1,20);
java.util.Date tdate3 = new java.util.Date(year-1900,month-1,30);
java.util.Date tdate4 = new java.util.Date(year-1900,month-1,day);
tdate1.setDate(10);
tdate2.setDate(20);
tdate3.setDate(30);
//tdate1.setMonth(tdate1.getMonth()+1);
//tdate2.setMonth(tdate2.getMonth()+1);
//tdate3.setMonth(tdate3.getMonth()+1);




//System.out.println("Dt1:"+tdate1.toString());
//System.out.println("Dt2:"+tdate2.toString());
//System.out.println("Dt3:"+tdate3.toString());




formatter = new SimpleDateFormat("dd-MMM-yyyy");

String todate1=formatter.format(tdate1);
//System.out.println("Todate1:"+todate1);
String todate2=formatter.format(tdate2);
//System.out.println("Todate2:"+todate1);
String todate3=formatter.format(tdate3);
//System.out.println("Todate3:"+todate1);
String todate4=formatter.format(tdate4);

int sno=1;
double ten=0;
double twe=0;
double thr=0;
double above=0;
double bten=0;
double btwe=0;
double bthr=0;
double babove=0;
double tcount=0;
double bank=0;
double pao=0;
double gtcount=0;
double gten=0;
double gtwe=0;
double gthr=0;
double gabove=0;
double gbten=0;
double gbtwe=0;
double gbthr=0;
double gbabove=0;
double gbank=0;
double gpao=0;
double exptcount=0;
double gtexptcount=0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>

				
			<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home | </a></td>
				
			
			</tr>  
		</table>
	</caption>
	

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> <font color="red"><b>Amount in Rs. lakhs</b></font></td>
</tr>




	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Between Releases and Expenditure Report</td>
</tr>

<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=2>Sl.No</td>
               <td class=btext rowspan=2>Division</td>
               <!-- <td class=btext colspan=2> Tot Expenditure</td>-->
               <td class=btext  colspan=2>Releases</td>
               <td class=btext colspan=2 >(1-10)days</td> 
			   <td class=btext colspan=2 >(11-20)days</td> 
			   <td class=btext  colspan=2 >(21-30)days</td>
			   <td class=btext  colspan=2 >(30-above)days</td>
	
	<tr>        <td class=btext rowspan=2>Bank</td> 
			    <td class=btext  rowspan=2 nowrap>Pao</td>
                
                <td class=btext rowspan=2>Bank</td> 
			    <td class=btext  rowspan=2 nowrap>Pao</td>
			    
			    <td class=btext rowspan=2>Bank</td> 
			    <td class=btext  rowspan=2 nowrap>Pao</td>
			   
			    <td class=btext rowspan=2>Bank</td> 
			    <td class=btext  rowspan=2 nowrap>Pao</td>
			    
			    <td class=btext rowspan=2>Bank</td> 
			    <td class=btext  rowspan=2 nowrap>Pao</td>
			    
			    
	<tr>
		</tr>
<% 
try
{
   
   String qry = "select distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl order by division_office_code";
  // System.out.println("district11........:"+qry);
    int count = 1; 
  	stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(qry);
    
  while (rs1.next())
	{ 
 	 //String qry2="select(select distinct COUNT(*) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W where substr(office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND UPDATE_date >='"+fromdate+"'and UPDATE_date <='"+todate+"') a1,(select DISTINCT  count(*)FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"'and  UPDATE_date <='"+todate+"')a2,(select DISTINCT  count(*)FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_PAO_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"'and UPDATE_date <='"+todate+"')a3,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"' and UPDATE_date <'"+todate1+"')a4,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate1+"'and UPDATE_date <'"+todate2+"')a5,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate2+"' and UPDATE_date <'"+todate3+"')a6,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate3+"' and UPDATE_date <='"+todate+"')a7,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"' and UPDATE_date <'"+todate1+"')a8,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate1+"'and UPDATE_date <'"+todate2+"')a9,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate2+"' and UPDATE_date <'"+todate3+"')a10,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate3+"' and UPDATE_date <='"+todate+"')a11 from dual";     	    
       
       //String qry2="select(select distinct count(*) FROM RWS_WORK_ADMN_TBL W ,rws_work_bill_tbl B,rws_bill_bank_bridge_tbl BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' AND W.WORK_ID=BR.WORK_ID and b.work_id=w.work_id AND BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"' and state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a0,(select distinct count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"')a1,(select distinct count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a2,(select distinct count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <'"+todate1+"')a3,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate1+"' and state_send_date <'"+todate2+"')a4,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate2+"' and state_send_date <'"+todate3+"')a5,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate3+"' and state_send_date <='"+todate+"')a6,(select distinct count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <'"+todate1+"')a7,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate1+"' and BANK_send_date <'"+todate2+"')a8,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate2+"' and BANK_send_date <'"+todate3+"')a9,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate3+"' and BANK_send_date <='"+todate+"')a10 from dual";
     //corr
      // String qry2="select(select sum(BILL_AMOUNT_CENTRAL+BILL_AMOUT_STATE )as exp from rws_bill_bank_bridge_det_tbl a,rws_bill_pao_bridge_det_tbl b where  substr(a.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and BANK_SEND_DATE >='"+fromdate+"' and BANK_SEND_DATE <='"+todate+"' and state_SEND_DATE >='"+fromdate+"' and state_SEND_DATE <='"+todate+"')a0,(select distinct sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"')a1,(select distinct sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a2,(select distinct sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <'"+todate1+"')a3,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate1+"' and state_send_date <'"+todate2+"')a4,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate2+"' and state_send_date <'"+todate3+"')a5,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate3+"' and state_send_date <='"+todate+"')a6,(select distinct sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <'"+todate1+"')a7,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate1+"' and BANK_send_date <'"+todate2+"')a8,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate2+"' and BANK_send_date <'"+todate3+"')a9,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate3+"' and BANK_send_date <='"+todate+"')a10 from dual";
       	
     // 28/04-2012 	correct
       	
       	//String qry2="select(SELECT DISTINCT SUM(BILL_AMOUNT_CENTRAL )FROM  RWS_BILL_BANK_BRIDGE_TBL B,RWS_WORK_ADMN_TBL BR WHERE substr(B.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' AND B.WORK_ID=BR.WORK_ID AND BANK_SEND_DATE >='"+fromdate+"' and  BANK_SEND_DATE <='"+todate+"' )a0,(SELECT  DISTINCT SUM(BILL_AMOUT_STATE)  FROM  RWS_BILL_BANK_BRIDGE_TBL B,RWS_WORK_ADMN_TBL BR WHERE substr(B.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and B.WORK_ID=BR.WORK_ID AND STATE_SEND_DATE >='"+fromdate+"' and  STATE_SEND_DATE <='"+todate+"')a1,(select distinct sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"')a2,(select distinct sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a3,(select distinct sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+fromdate+"' and state_send_date <'"+todate1+"')a4,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate1+"' and state_send_date <'"+todate2+"')a5,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate2+"' and state_send_date <'"+todate3+"')a6,(select sum(BILL_AMOUT_STATE) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND state_send_date >='"+todate3+"' and state_send_date <='"+todate+"')a7,(select distinct sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+fromdate+"' and BANK_send_date <'"+todate1+"')a8,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate1+"' and BANK_send_date <'"+todate2+"')a9,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate2+"' and BANK_send_date <'"+todate3+"')a10,(select sum(bill_amount_central ) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND BANK_send_date >='"+todate3+"' and BANK_send_date <='"+todate+"')a11 from dual";
       //	String qry2="select(SELECT DISTINCT SUM(BILL_AMOUNT_CENTRAL)FROM  RWS_BILL_BANK_BRIDGE_TBL BR,RWS_WORK_ADMN_TBL B WHERE substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'AND B.WORK_ID=BR.WORK_ID AND BANK_SEND_DATE >='"+fromdate+"' and  BANK_SEND_DATE <='"+todate+"')a0,(SELECT  DISTINCT SUM(BILL_AMOUT_STATE)  FROM  RWS_BILL_BANK_BRIDGE_TBL BR,RWS_WORK_ADMN_TBL B WHERE substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and B.WORK_ID=BR.WORK_ID AND STATE_SEND_DATE >='"+fromdate+"' and  STATE_SEND_DATE <='"+todate+"')a1,(select distinct sum(bill_amount_central ) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and  BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"')a2,(select sum(BILL_AMOUT_STATE) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and  state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a3,(select  sum(BILL_AMOUT_STATE) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+fromdate+"' and state_send_date <'"+todate1+"')a4,(select sum(BILL_AMOUT_STATE) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+todate1+"' and state_send_date <'"+todate2+"')a5,(select sum(BILL_AMOUT_STATE) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR  where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' AND state_send_date >='"+todate2+"' and state_send_date <'"+todate3+"')a6,(select sum(BILL_AMOUT_STATE) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+todate3+"' and state_send_date <='"+todate+"')a7,(select  sum(bill_amount_central) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+fromdate+"' and BANK_send_date <'"+todate1+"')a8,(select sum(bill_amount_central) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate1+"' and BANK_send_date <'"+todate2+"')a9,(select sum(bill_amount_central ) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR  where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate2+"' and BANK_send_date <'"+todate3+"')a10,(select sum(bill_amount_central ) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate3+"' and BANK_send_date <='"+todate+"')a11 from dual";
        String qry2="select(select distinct nvl(sum(bill_amount_central),0 )FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and  BANK_send_date >='"+fromdate+"' and BANK_send_date <='"+todate+"')a2,(select nvl(sum(BILL_AMOUT_STATE),0) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and  state_send_date >='"+fromdate+"' and state_send_date <='"+todate+"')a3,(select  nvl(sum(BILL_AMOUT_STATE),0) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+fromdate+"' and state_send_date <'"+todate1+"' and state_send_date <='"+todate+"')a4,(select nvl(sum(BILL_AMOUT_STATE),0) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+todate1+"' and state_send_date <'"+todate2+"' and state_send_date <='"+todate+"')a5,(select nvl(sum(BILL_AMOUT_STATE),0) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR  where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' AND state_send_date >='"+todate2+"' and state_send_date <'"+todate3+"' and state_send_date <='"+todate+"')a6,(select nvl(sum(BILL_AMOUT_STATE),0) FROM RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND state_send_date >='"+todate3+"' and state_send_date <='"+todate+"' and state_send_date <='"+todate+"')a7,(select  nvl(sum(bill_amount_central),0) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+fromdate+"' and BANK_send_date <'"+todate1+"' and bank_send_date <='"+todate+"')a8,(select nvl(sum(bill_amount_central),0) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate1+"' and BANK_send_date <'"+todate2+"' and bank_send_date <='"+todate+"')a9,(select nvl(sum(bill_amount_central ),0) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR  where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate2+"' and BANK_send_date <'"+todate3+"' and bank_send_date <='"+todate+"')a10,(select nvl(sum(bill_amount_central),0) FROM RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(BR.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'  AND BANK_send_date >='"+todate3+"' and BANK_send_date <='"+todate+"')a11 from dual";
        System.out.println("qry2-------"+qry2);
    	stmt2=conn.createStatement();
    	rs2=stmt2.executeQuery(qry2);
    	while(rs2.next())
    	{
            
            // tcount=rs2.getDouble(1);
            //exptcount=rs2.getDouble(2);
            bank=rs2.getDouble(1);
			pao=rs2.getDouble(2);
			ten=rs2.getDouble(3);
			
			twe=rs2.getDouble(4);
			thr=rs2.getDouble(5);
			above=rs2.getDouble(6);
			
			bten=rs2.getDouble(7);
			btwe=rs2.getDouble(8);
			bthr=rs2.getDouble(9);
			babove=rs2.getDouble(10);
			
	
			
	%>    

				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
				<td class=rptValue NOWRAP><%=ndf.format(bank)%></td>
				<td class=rptValue NOWRAP><%=ndf.format(pao)%></td>
				
				<td class=rptValue NOWRAP><%=ndf.format(bten)%></td>
				<td class=rptValue NOWRAP><%=ndf.format(ten) %></td>
					   
		 
				<td class=rptValue NOWRAP><%=ndf.format(btwe) %></td>
				<td class=rptValue NOWRAP><%=ndf.format(twe) %></td>
				
				<td class=rptValue NOWRAP><%=ndf.format(bthr) %></td>
				<td class=rptValue NOWRAP><%=ndf.format(thr) %></td>
						
       
				<td class=rptValue NOWRAP><%=ndf.format(babove) %></td>
				<td class=rptValue NOWRAP><%=ndf.format(above)%></td>
				
				
					
				
               </tr>	
               	
<%	

}

gtcount=tcount+gtcount;
gtexptcount=exptcount+gtexptcount;
gbank=bank+gbank;
gpao=pao+gpao;
gten=ten+gten;
gtwe=twe+gtwe;
gthr=thr+gthr;
gbten=bten+gbten;
gbtwe=btwe+gbtwe;
gbthr=bthr+gbthr;
gabove=above+gabove;
gbabove=babove+gbabove;

}
	%>
	
	<tr>
	  <td class="btext" colspan="2">Total:</td>
      <td class="btext" ><%=ndf.format(gbank) %></td>	  
	  <td class="btext" ><%=ndf.format(gpao) %></td>
	  <td class="btext" ><%=ndf.format(gbten) %></td>
	  <td class="btext" ><%=ndf.format(gten) %></td>
	  <td class="btext" ><%=ndf.format(gbtwe)%></td>
	  <td class="btext" ><%=ndf.format(gtwe) %></td>
	  <td class="btext" ><%=ndf.format(gbthr)%></td>
	  <td class="btext" ><%=ndf.format(gthr) %></td>
	  <td class="btext" ><%=ndf.format(gbabove)%></td>
	  <td class="btext" ><%=ndf.format(gabove) %></td>
	  
	  
    	</tr>
	<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		
		if( conn != null )
		{
			conn.close();
		}
		
		
		
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>


<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

