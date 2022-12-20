<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String attend="";
int wno=0;
int gwno=0;
String a="";
int s=0;

String fromdate=request.getParameter("fromDate");
String todate=request.getParameter("toDate");
System.out.println("From Date:"+fromdate);
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


 String months[]={"Jan","feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
 
 
 
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




System.out.println("Dt1:"+tdate1.toString());
System.out.println("Dt2:"+tdate2.toString());
System.out.println("Dt3:"+tdate3.toString());




formatter = new SimpleDateFormat("dd-MMM-yyyy");

String todate1=formatter.format(tdate1);
//System.out.println("Todate1:"+todate1);
String todate2=formatter.format(tdate2);
//System.out.println("Todate2:"+todate1);
String todate3=formatter.format(tdate3);
//System.out.println("Todate3:"+todate1);
String todate4=formatter.format(tdate4);

int sno=1;

int ten=0;
int twe=0;
int thr=0;
int above=0;
int bten=0;
int btwe=0;
int bthr=0;
int babove=0;
int tcount=0;
int bank=0;
int pao=0;
int gtcount=0;
int gten=0;
int gtwe=0;
int gthr=0;
int gabove=0;
int gbten=0;
int gbtwe=0;
int gbthr=0;
int gbabove=0;
int gbank=0;
int gpao=0;
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
		<td align="center" class="rptHeading" colspan="14"> Time Gap Report</td>
</tr>

<tr bgcolor="" align="center">
		<td align="center" class="rptHeading" colspan="14">FromDate:<font color="red"><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;ToDate:<font color="red"><%=todate%></font></td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=2>Sl.No</td>
               <td class=btext rowspan=2>Division</td>
               <td class=btext rowspan=2> Bill count</td>
               <td class=btext  colspan=2>Releases</td>
               <td class=btext colspan=2 >(1-10)days</td> 
			   <td class=btext colspan=2 >(11-20)days</td> 
			   <td class=btext  colspan=2 >(21-30)days</td>
			   <td class=btext  colspan=2 >(30-above)days</td>
	
	<tr>
                <td class=btext rowspan=2>Bank</td> 
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
    //String query = "";
	// if(dcode!=null && !dcode.equals("") && dcode.equals("51"))
	//	{
	 // query="select  d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'  order by d.dname";
	 //   }
	//else if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	//{
	 // query="select  dcode,dname from rws_district_tbl where dcode='"+dcode+"'";
	//  }
//attend="";*/
  //System.out.println("query*********"+query);
  
  
  
  //String qry = "select distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl order by division_office_code";
  String qry = "select distinct division_office_code,division_office_name,circle_office_code from rws_division_office_tbl order by division_office_code";
   System.out.println("district11........:"+qry);
	  int count = 1; 
  	stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(qry);
    
  while (rs1.next())
	{ 
	//System.out.println("division office***********"+rs1.getString(1));
	//System.out.println("division office***********"+rs1.getString(3));
	//String qry2="select count(bill_no) from rws_work_bill_tbl where bill_date>=to_date('"+fromdate+"','dd-mm-yyyy') and  bill_date<=to_date('"+todate+"','dd-mm-yyyy')";
    
    //String qry2="select (select count(bill_no) from rws_work_bill_tbl where bill_date>=to_date('"+fromdate+"','dd-mm-yyyy')  and  bill_date<=to_date('"+todate1+"','dd-mm-yyyy')) a1,(select count(bill_no) from rws_work_bill_tbl where  bill_date>to_date('"+todate1+"','dd-mm-yyyy')  and  bill_date<=to_date('"+todate2+"','dd-mm-yyyy'))a2,(select count(bill_no) from rws_work_bill_tbl where bill_date>to_date('"+todate2+"','dd-mm-yyyy')  and  bill_date<=to_date('"+todate3+"','dd-mm-yyyy')) a3,(select count(bill_no) from rws_work_bill_tbl where bill_date>=to_date('"+todate3+"','dd-mm-yyyy')  and  bill_date<=to_date('"+todate+"','dd-mm-yyyy')) a4 from dual";
   
       // String qry2="select(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and  a.bill_date<=to_date('"+fromdate+"','dd-mm-yyyy')and a.bill_date<=to_date('"+todate+"','dd-mm-yyyy'))a0,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and  a.bill_date>=to_date('"+fromdate+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate1+"','dd-mm-yyyy'))a1,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"' and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and a.bill_date>to_date('"+todate1+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate2+"','dd-mm-yyyy'))a2,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"' and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and a.bill_date>to_date('"+todate2+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate3+"','dd-mm-yyyy'))a3,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"' and a. bill_date>=to_date('"+todate3+"','dd-mm-yyyy')and  a.bill_date<=to_date('"+todate1+"','dd-mm-yyyy')) a4,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and  substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"' and a.bill_sl_no=b.bill_sl_no and b.BANK_SEND_DATE >=to_date('"+fromdate+"','dd-mm-yyyy')  and  b.BANK_SEND_DATE<=to_date('"+todate+"','dd-mm-yyyy'))a5,(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_pao_bridge_det_tbl b where a.bill_sl_no=b.bill_sl_no  and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and a.bill_sl_no=b.bill_sl_no and a.work_id=b.work_id  and  b.STATE_SEND_DATE>=to_date('"+fromdate+"','dd-mm-yyyy')  and  b.STATE_SEND_DATE <=to_date('"+todate+"','dd-mm-yyyy'))a6 from dual";
    	     	   
    	  // String qry2="select(select count(*) from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)=''"+rs1.getString(3)+"''and  a.bill_date<=to_date('"+fromdate+"','dd-mm-yyyy')and a.bill_date<=to_date('"+todate+"','dd-mm-yyyy')),(select count(*) from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"''and  a.bill_date>=to_date('todate','dd-mm-yyyy')  and  a.bill_date<=to_date('todate1','dd-mm-yyyy')),(select count(*) from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and  a.bill_date>=to_date('"+todate1+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate2+"','dd-mm-yyyy')),(select count(*) from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and  a.bill_date>=to_date('"+todate2+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate3+"','dd-mm-yyyy')),(select count(*) from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and  a.bill_date>=to_date('"+todate3+"','dd-mm-yyyy')  and  a.bill_date<=to_date('"+todate+"','dd-mm-yyyy')),(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"' and a.bill_sl_no=b.bill_sl_no and a.work_id=b.work_id  and b.BANK_SEND_DATE >=to_date('"+fromdate+"','dd-mm-yyyy')  and  b.BANK_SEND_DATE<=to_date('"+todate+"','dd-mm-yyyy')),(select count(a.bill_no)from rws_work_bill_tbl a, rws_bill_bank_bridge_det_tbl b,rws_bill_pao_bridge_det_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.bill_sl_no=b.bill_sl_no and b.bill_sl_no=c.bill_sl_no and substr(b.office_code,4,1)='"+rs1.getString(1)+"'and substr(b.office_code,2,2)='"+rs1.getString(3)+"'and a.bill_sl_no=b.bill_sl_no and a.work_id=b.work_id  and  c.STATE_SEND_DATE>=to_date('"+fromdate+"','dd-mm-yyyy')  and  c.STATE_SEND_DATE <=to_date('"+todate+"','dd-mm-yyyy'))"; 
    	    
    	    
    	    
       //String qry2="select(select count(*) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W where substr(office_code,2,3)='"+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND (UPDATE_date >='"+todate+"' and UPDATE_date <='"+fromdate+"'),(select COUNT(*) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W where substr(office_code,2,3)='191' and W.WORK_ID=B.WORK_ID AND (UPDATE_date >='"+todate+"' and UPDATE_date <='"+fromdate+"')),(select DISTINCT B.WORK_ID,B.BILL_SL_NO FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='191' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND (UPDATE_date >='"+fromdate+"' and UPDATE_date <='"+fromdate+"')),(select DISTINCT B.WORK_ID,B.BILL_SL_NO FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_PAO_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND (UPDATE_date >='"+fromdate+"'and UPDATE_date <='"+fromdate+"')))";
    	 String qry2="select(select distinct COUNT(*) FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W where substr(office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND UPDATE_date >='"+fromdate+"'and UPDATE_date <='"+todate+"') a1,(select DISTINCT count(*)FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_BANK_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"'and  UPDATE_date <='"+todate+"')a2,(select DISTINCT count(*)FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_PAO_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"'and UPDATE_date <='"+todate+"')a3,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"' and UPDATE_date <'"+todate1+"' and UPDATE_date <='"+todate+"' and UPDATE_date <='"+todate+"')a4,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate1+"'and UPDATE_date <'"+todate2+"' and UPDATE_date <='"+todate+"')a5,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate2+"' and UPDATE_date <'"+todate3+"' and UPDATE_date <='"+todate+"')a6,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_pao_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate3+"' and UPDATE_date <='"+todate+"' and UPDATE_date <='"+todate+"')a7,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+fromdate+"' and UPDATE_date <'"+todate1+"' and UPDATE_date <='"+todate+"')a8,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"'and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate1+"'and UPDATE_date <'"+todate2+"' and UPDATE_date <='"+todate+"' and UPDATE_date <='"+todate+"')a9,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate2+"' and UPDATE_date <'"+todate3+"' and UPDATE_date <='"+todate+"')a10,(select count(* )FROM rws_work_bill_tbl B , RWS_WORK_ADMN_TBL W ,RWS_BILL_bank_BRIDGE_DET_TBL BR where substr(W.office_code,2,3)='"+rs1.getString(3)+rs1.getString(1)+"' and W.WORK_ID=B.WORK_ID AND W.WORK_ID=BR.WORK_ID AND UPDATE_date >='"+todate3+"' and UPDATE_date <='"+todate+"')a11 from dual";     	    
       	System.out.println("qry2-------"+qry2);
    	stmt2=conn.createStatement();
    	rs2=stmt2.executeQuery(qry2);
    	while(rs2.next())
    	{
    	   
            tcount=rs2.getInt(1);
            bank=rs2.getInt(2);
			pao=rs2.getInt(3);
			
			ten=rs2.getInt(4);
			twe=rs2.getInt(5);
			thr=rs2.getInt(6);
			above=rs2.getInt(7);
			
			bten=rs2.getInt(8);
			btwe=rs2.getInt(9);
			bthr=rs2.getInt(10);
			babove=rs2.getInt(11);
			
	
			
	%>    

				<td class=rptValue><%=sno++%></td>
				<td class=rptValue NOWRAP><%=rs1.getString(2)%></td>
				<td class=rptValue NOWRAP><%=tcount%></td>
				<td class=rptValue NOWRAP><%=bank%></td>
				<td class=rptValue NOWRAP><%=pao%></td>
				<td class=rptValue NOWRAP><%=bten%></td>
				<td class=rptValue NOWRAP><%=ten %></td>
				<td class=rptValue NOWRAP><%=btwe %></td>
				<td class=rptValue NOWRAP><%=twe %></td>
				<td class=rptValue NOWRAP><%=bthr %></td>
				<td class=rptValue NOWRAP><%=thr %></td>
				<td class=rptValue NOWRAP><%=babove %></td>
				<td class=rptValue NOWRAP><%=above %></td>
				
				
							
				
               </tr>	
               	
<%	

}

gtcount=tcount+gtcount;
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
      <td class="btext" ><%=gtcount%></td> 
  	  <td class="btext" ><%=gbank %></td>	  
	  <td class="btext" ><%=gpao %></td>
	  <td class="btext" ><%=gbten %></td>
	  <td class="btext" ><%=gten %></td>
	  <td class="btext" ><%=gbtwe%></td>
	  <td class="btext" ><%=gtwe %></td>
	  <td class="btext" ><%=gbthr%></td>
	  <td class="btext" ><%=gthr %></td>
	  <td class="btext" ><%=gbabove%></td>
	  <td class="btext" ><%=gabove %></td>
	  
	  
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

