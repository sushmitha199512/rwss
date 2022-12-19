<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<form name="f1">
<%
java.text.DecimalFormat ndf = new java.text.DecimalFormat("####.00");
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;

String attend="";
String a="";
double bank=0;
double pao=0;
double ssr=0,ssr1=0,ssr2=0,ssr3=0,ssr4=0,ssr5=0,ssr6=0,ssr7=0,ssr8=0,ssr9=0,ssr10=0,ssr11=0,ssr12=0;
double gtcount=0,gtcountssr1=0,gtcountssr2=0,gtcountssr3=0,gtcountssr4=0,gtcountssr5=0,gtcountssr6=0,gtcountssr7=0,gtcountssr8=0,gtcountssr9=0;
double gtcountssr10=0,gtcountssr11=0,gtcountssr12=0;

int sno=1;
int gcount=0;
int gcomplaintcount=0;
int dcount=0;
int gncomplaintcount=0;
String cDate=null;
int f1,gf1=0;
int d1,gd1=0;


int year=Integer.parseInt(RwsUtils.getCurrentYear());
SimpleDateFormat format1 = new SimpleDateFormat("M");
Date date = new Date();
String months=format1.format(date);
int month=Integer.parseInt(months);
if(month<=3){
year=year-1;
}
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
	
				 <td class="bwborder"><a href="#" onclick="window.close()">Close</a> &nbsp;<a href="#" onclick="window.print()"><img src="../images/print_icon.jpg"></a>
				</td>
			
			</tr>  
		</table>
	</caption>


	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="17"> <font color="red"><b>Amount in Rupees.</b></font></td>
</tr>

	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="17">Bank Financial MPR:<%= finYear %></td>
</tr>
               <td class=btext >S.No</td>
               <td class=btext>District</td>
			<td class=btext>Constituency</td>
   	  <td class=btext colspan=1 align=center>Works<font color="blue"></font></td>
			   <td class=btext align=center>Apr</td>
			    <td class=btext align=center>May</td>
				 <td class=btext align=center>Jun</td>
                 <td class=btext align=center>Jul</td>
			     <td class=btext align=center>Aug</td>
                 <td class=btext align=center>Sep</td>
				 <td class=btext align=center>Oct</td>
				  <td class=btext align=center>Nov</td>
				  <td class=btext align=center>Dec</td>
				  <td class=btext align=center>Jan</td> 
			     <td class=btext align=center>Feb</td>
			     <td class=btext align=center>Mar</td>
				 <td class=btext align=center>Total</td>
</tr>
		  
			   <%
try
{
  

 
 int TotdistWorksRel=0,TotConBillRepWorks=0;
    String query1="select dname,dcode from rws_district_tbl where dcode<>'16'" ;
  // System.out.println("district11........:"+qry);
    int count = 1; 
  	stmt1=conn.createStatement();
   rs1=stmt1.executeQuery(query1);
    
  while (rs1.next())
	{ 
 		int distWorksRel=0;
	  String distWorksRelqry="select count(distinct work_id) from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-APR-"+year+"' and to_date(bank_send_date) <='31-MAR-"+year1+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"'";
	  stmt2=conn.createStatement();
	  rs2=stmt2.executeQuery(distWorksRelqry);
	    if (rs2.next()){
	  	  distWorksRel=rs2.getInt(1);
	    }
	    TotdistWorksRel+=distWorksRel;
	    rs2.close();
	    stmt2.close();
//String query="select nvl(sum(bill_amount_central),'0'),substr(office_code,2,2),dname from rws_bill_bank_bridge_det_tbl a,rws_district_tbl b where b.dcode=substr(office_code,2,2) and to_date( bank_send_date) >='01-JAN-12' and to_date(bank_send_date) <='31-JAN-12'  and txid is not null  and bill_activation_flag='P'  group by substr(office_code,2,2),dname order by 2";
  
 //String query="SELECT(select nvl(sum(bill_amount_central),'0'),substr(office_code,2,2),dname from rws_bill_bank_bridge_det_tbl a,rws_district_tbl b where b.dcode=substr(office_code,2,2) and to_date( bank_send_date) >='01-JAN-12' and to_date(bank_send_date) <='31-JAN-12'  and txid is not null  and bill_activation_flag='P'  group by substr(office_code,2,2),dname order by 2 )a1,((select nvl(sum(bill_amout_state),'0'),substr(office_code,2,2),dname from rws_bill_pao_bridge_det_tbl a,rws_district_tbl b where b.dcode=substr(office_code,2,2) and to_date( state_send_date) >='01-JAN-12' and to_date(state_send_date) <='31-JAN-12'  and txid is not null  and bill_activation_flag='P'  group by substr(office_code,2,2),dname order by 2 )a2 from dual";

//String query="select(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-"+mnth+"-11' and to_date(bank_send_date) <='31-"+mnth+"-12' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a,(select nvl(sum(bill_amout_state),'0') from RWS_BILL_PAO_BRIDGE_DET_TBL  where  to_date(state_send_date) >='01-"+mnth+"-11' and to_date(state_send_date)  <='31-"+mnth+"-12' and state_txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')b from dual" ;


String query="select(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-APR-"+year+"' and to_date(bank_send_date) <='30-APR-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a1,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-MAY-"+year+"' and to_date(bank_send_date) <='31-MAY-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a2,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-JUN-"+year+"' and to_date(bank_send_date) <='30-JUN-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a3,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-JULY-"+year+"' and to_date(bank_send_date) <='31-JULY-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a4,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-AUG-"+year+"' and to_date(bank_send_date) <='31-AUG-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a5,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-SEP-"+year+"' and to_date(bank_send_date) <='30-SEP-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a6,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-OCT-"+year+"' and to_date(bank_send_date) <='31-OCT-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a7,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-NOV-"+year+"' and to_date(bank_send_date) <='30-NOV-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a8,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-DEC-"+year+"' and to_date(bank_send_date) <='31-DEC-"+year+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a9,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-JAN-"+year1+"' and to_date(bank_send_date) <='31-JAN-"+year1+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a10,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-FEB-"+year1+"' and to_date(bank_send_date) <=LAST_DAY(TO_DATE('28-FEB-"+year1+"', 'DD-MON-YYYY')) and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a11,(select nvl(sum(bill_amount_central),'0') from rws_bill_bank_bridge_det_tbl  where to_date(bank_send_date) >='01-MAR-"+year1+"' and to_date(bank_send_date) <='31-MAR-"+year1+"' and txid is not null AND substr(office_code,2,2)='"+rs1.getString(2)+"')a12 from dual";


  //System.out.println("query*********"+query);
  stmt2=conn.createStatement();

 // System.out.println("stmt2*********"+stmt2);
   rs2=stmt2.executeQuery(query);
   if (rs2.next())
	{
    ssr=rs2.getDouble(1);
	ssr1=rs2.getDouble(2);
	ssr2=rs2.getDouble(3);
	ssr3=rs2.getDouble(4);
	ssr4=rs2.getDouble(5);
	ssr5=rs2.getDouble(6);
    ssr6=rs2.getDouble(7);
	ssr7=rs2.getDouble(8);
	ssr8=rs2.getDouble(9);
    ssr9=rs2.getDouble(10);
	ssr10=rs2.getDouble(11);
	ssr11=rs2.getDouble(12);
    ssr12=ssr+ssr1+ssr2+ssr3+ssr4+ssr5+ssr6+ssr7+ssr8+ssr9+ssr10+ssr11;
 	}rs2.close();
 	stmt2.close();
  %>
  
   <tr  style="background-color: skyblue">
	  <td class=rptValue NOWRAP><%=sno++ %></td>
	  <td class=rptValue NOWRAP ><%=rs1.getString(1)%></td>
	  <td class=rptValue NOWRAP >--</td>
	  <td class=rptValue NOWRAP align=center colspan=1><%=distWorksRel%></td> 
   <td class=rptValue NOWRAP align=right><%=ssr!=0?(ndf.format(ssr)):"-" %></td>
    <td class=rptValue NOWRAP align=right><%=ssr1!=0?(ndf.format(ssr1)):"-" %></td>
	 <td class=rptValue NOWRAP align=right><%=ssr2!=0?(ndf.format(ssr2)):"-" %></td>
	  <td class=rptValue NOWRAP align=right><%=ssr3!=0?(ndf.format(ssr3)):"-" %></td>
	  <td class=rptValue NOWRAP align=right><%=ssr4!=0?(ndf.format(ssr4)):"-" %></td>
    <td class=rptValue NOWRAP align=right><%=ssr5!=0?(ndf.format(ssr5)):"-" %></td>
	 <td class=rptValue NOWRAP align=right><%=ssr6!=0?(ndf.format(ssr6)):"-" %></td>
	  <td class=rptValue NOWRAP align=right><%=ssr7!=0?(ndf.format(ssr7)):"-" %></td>
	  <td class=rptValue NOWRAP align=right><%=ssr8!=0?(ndf.format(ssr8)):"-" %></td>
    <td class=rptValue NOWRAP align=right><%=ssr9!=0?(ndf.format(ssr9)):"-" %></td>
	 <td class=rptValue NOWRAP align=right><%=ssr10!=0?(ndf.format(ssr10)):"-" %></td>
	  <td class=rptValue NOWRAP align=right><%=ssr11!=0?(ndf.format(ssr11)):"-" %></td>
 <td class=rptValue NOWRAP align=right><%=ssr12!=0?(ndf.format(ssr12)):"-" %></td>

  </tr>
  
  <%
  double congtcount=0,congtcountssr1=0,congtcountssr2=0,congtcountssr3=0,congtcountssr4=0,congtcountssr5=0,congtcountssr6=0,congtcountssr7=0,congtcountssr8=0,congtcountssr9=0;
  double congtcountssr10=0,congtcountssr11=0,congtcountssr12=0;
 
   String qry="select distinct CONSTITUENCY_CODE,CONSTITUENCY_NAME from RWS_CONSTITUENCY_TBL where dcode='"+rs1.getString(2)+"' order by CONSTITUENCY_CODE";
  stmt2=conn.createStatement();
  rs2=stmt2.executeQuery(qry);
  while (rs2.next())
  {	
	  double cssr=0,cssr1=0,cssr2=0,cssr3=0,cssr4=0,cssr5=0,cssr6=0,cssr7=0,cssr8=0,cssr9=0,cssr10=0,cssr11=0,cssr12=0;
	  int ConBillRepWorks=0;	
	  String ConBillWorksRepQry="select count(distinct a.work_id) from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-APR-"+year+"' and to_date(bank_send_date) <='31-MAR-"+year1+"' and  substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"' ";
		 //System.out.println("ConBillWorksRepQry"+ConBillWorksRepQry);
		 stmt3=conn.createStatement();	
		 rs3=stmt3.executeQuery(ConBillWorksRepQry);
		 if(rs3.next()){
			 ConBillRepWorks=rs3.getInt(1);
		 }
		// TotConBillRepWorks+=ConBillRepWorks;
		 rs3.close();
		 stmt3.close();
		/*  String qry1="select(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-APR-"+year+"' and to_date(bank_send_date) <='30-APR-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and  substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a1,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-MAY-"+year+"' and to_date(bank_send_date) <='31-MAY-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a2,"
					   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-JUN-"+year+"' and to_date(bank_send_date) <='30-JUN-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a3,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-JULY-"+year+"' and to_date(bank_send_date) <='31-JULY-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a4,"
					   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-AUG-"+year+"' and to_date(bank_send_date) <='31-AUG-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a5,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-SEP-"+year+"' and to_date(bank_send_date) <='30-SEP-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a6,"
					   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-OCT-"+year+"' and to_date(bank_send_date) <='31-OCT-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a7,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-NOV-"+year+"' and to_date(bank_send_date) <='30-NOV-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a8,"
					   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-DEC-"+year+"' and to_date(bank_send_date) <='31-DEC-"+year+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a9,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-JAN-"+year1+"' and to_date(bank_send_date) <='31-JAN-"+year1+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a10,"
					   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-FEB-"+year1+"' and to_date(bank_send_date) <='28-FEB-"+year1+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a11,"
			  	 	   +"(select nvl(sum(AMOUNTCAL),'0') from RWS_WORK_BANK_CONS_HAB_FY_VIEW a,RWS_CONSTITUENCY_TBL c where to_date(bank_send_date) >='01-MAR-"+year1+"' and to_date(bank_send_date) <='31-MAR-"+year1+"' and substr(a.hab_code,1,2)='"+rs1.getString(2)+"' and substr(a.hab_code,1,2)=c.dcode and substr(a.hab_code,6,2)=c.mcode and c.CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"')a12 from dual"; */
			 String qry1="select nvl(APRC,0),nvl(MAYC,0),nvl(JUNC,0),nvl(JULYC,0),nvl(AUGC,0),nvl(SEPC,0),nvl(OCTC,0),nvl(NOVC,0),nvl(DECC,0),nvl(JANC,0),nvl(FEBV,0),nvl(MARC,0) from rws_work_cons_bank_amount_tbl where dcode='"+rs1.getString(2)+"' and CONSTITUENCY_CODE='"+rs2.getString("CONSTITUENCY_CODE")+"'" ;	 	   
			  	 	   
			  	 	   
			//	System.out.println("query*********222222"+qry1);
				stmt3=conn.createStatement();
				rs3=stmt3.executeQuery(qry1);
				if(rs3.next())
				{
					cssr=rs3.getDouble(1);
					cssr1=rs3.getDouble(2);
					cssr2=rs3.getDouble(3);
					cssr3=rs3.getDouble(4);
					cssr4=rs3.getDouble(5);
					cssr5=rs3.getDouble(6);
					cssr6=rs3.getDouble(7);
					cssr7=rs3.getDouble(8);
					cssr8=rs3.getDouble(9);
				 	cssr9=rs3.getDouble(10);
					cssr10=rs3.getDouble(11);
					cssr11=rs3.getDouble(12);
					cssr12=cssr+cssr1+cssr2+cssr3+cssr4+cssr5+cssr6+cssr7+cssr8+cssr9+cssr10+cssr11;
				}	
				rs3.close();
				stmt3.close(); 
				%>
				  <tr >
					  <td class=rptValue NOWRAP><%=sno++ %></td>
					  <td class=rptValue NOWRAP >--</td>
					  <td class=rptValue NOWRAP ><%=rs2.getString(2)%></td>
					  <%-- <td class=rptValue NOWRAP align=right><a href="./rws_financial_bank_mpr_drill.jsp?dcode=<%=rs1.getString(2)%>&constituencyCode=<%=rs2.getString(1)%>"><%=ConBillWorks %></a><font color="red">*</font></td> --%>
					  <td class=rptValue NOWRAP align=right><a href="./rws_financial_bank_mpr_drill.jsp?dcode=<%=rs1.getString(2)%>&constituencyCode=<%=rs2.getString(1)%>&dname=<%=rs1.getString(1)%>&constituencyName=<%=rs2.getString(2)%>"><%=ConBillRepWorks %></a></td>
					  <td class=rptValue NOWRAP align=right><%=cssr!=0?(ndf.format(cssr)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr1!=0?(ndf.format(cssr1)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr2!=0?(ndf.format(cssr2)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr3!=0?(ndf.format(cssr3)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr4!=0?(ndf.format(cssr4)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr5!=0?(ndf.format(cssr5)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr6!=0?(ndf.format(cssr6)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr7!=0?(ndf.format(cssr7)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr8!=0?(ndf.format(cssr8)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr9!=0?(ndf.format(cssr9)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr10!=0?(ndf.format(cssr10)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr11!=0?(ndf.format(cssr11)):"-" %></td>
					  <td class=rptValue NOWRAP align=right><%=cssr12!=0?(ndf.format(cssr12)):"-" %></td>
				  </tr>  
				  <%
					  congtcount=cssr+congtcount;
					  congtcountssr1=cssr1+congtcountssr1;
					  congtcountssr2=cssr2+congtcountssr2;
					  congtcountssr3=cssr3+congtcountssr3;
					  congtcountssr4=cssr4+congtcountssr4;
					  congtcountssr5=cssr5+congtcountssr5;
					  congtcountssr6=cssr6+congtcountssr6;
					  congtcountssr7=cssr7+congtcountssr7;
					  congtcountssr8=cssr8+congtcountssr8;
					  congtcountssr9=cssr9+congtcountssr9;
					  congtcountssr10=cssr10+congtcountssr10;
					  congtcountssr11=cssr11+congtcountssr11;
					  congtcountssr12=cssr12+congtcountssr12;
	 }
	  //TotConBillRepWorks+=ConBillRepWorks;
	 rs2.close();
	 stmt2.close();	 
	  %>
	  <tr>
		   <td class=btext align=right colspan=4><strong>Total</strong></td>
		  <td class=btext NOWRAP align=right><%=congtcount!=0?(ndf.format(congtcount)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr1!=0?(ndf.format(congtcountssr1)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr2!=0?(ndf.format(congtcountssr2)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr3!=0?(ndf.format(congtcountssr3)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr4!=0?(ndf.format(congtcountssr4)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr5!=0?(ndf.format(congtcountssr5)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr6!=0?(ndf.format(congtcountssr6)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr7!=0?(ndf.format(congtcountssr7)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr8!=0?(ndf.format(congtcountssr8)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr9!=0?(ndf.format(congtcountssr9)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr10!=0?(ndf.format(congtcountssr10)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr11!=0?(ndf.format(congtcountssr11)):"-" %></td>
		  <td class=btext NOWRAP align=right><%=congtcountssr12!=0?(ndf.format(congtcountssr12)):"-" %></td>
	  </tr>
	  <% 			
 gtcount=ssr+gtcount;
 gtcountssr1=ssr1+gtcountssr1;
 gtcountssr2=ssr2+gtcountssr2;
 gtcountssr3=ssr3+gtcountssr3;
 gtcountssr4=ssr4+gtcountssr4;
 gtcountssr5=ssr5+gtcountssr5;
 gtcountssr6=ssr6+gtcountssr6;
 gtcountssr7=ssr7+gtcountssr7;
 gtcountssr8=ssr8+gtcountssr8;
 gtcountssr9=ssr9+gtcountssr9;
 gtcountssr10=ssr10+gtcountssr10;
 gtcountssr11=ssr11+gtcountssr11;
 gtcountssr12=ssr12+gtcountssr12;
}
 rs1.close();
 stmt1.close();
%>
<tr>
<td class=btext align=right colspan=4><strong>Total</strong></td>
 <td class=btext NOWRAP align=right><%=gtcount!=0?(ndf.format(gtcount)):"-" %></td>
 <td class=btext NOWRAP align=right><%=gtcountssr1!=0?(ndf.format(gtcountssr1)):"-" %></td>
  <td class=btext NOWRAP align=right><%=gtcountssr2!=0?(ndf.format(gtcountssr2)):"-" %></td>
   <td class=btext NOWRAP align=right><%=gtcountssr3!=0?(ndf.format(gtcountssr3)):"-" %></td>
<td class=btext NOWRAP align=right><%=gtcountssr4!=0?(ndf.format(gtcountssr4)):"-" %></td>
  <td class=btext NOWRAP align=right><%=gtcountssr5!=0?(ndf.format(gtcountssr5)):"-" %></td>
   <td class=btext NOWRAP align=right><%=gtcountssr6!=0?(ndf.format(gtcountssr6)):"-" %></td>
<td class=btext NOWRAP align=right><%=gtcountssr7!=0?(ndf.format(gtcountssr7)):"-" %></td>
  <td class=btext NOWRAP align=right><%=gtcountssr8!=0?(ndf.format(gtcountssr8)):"-" %></td>
   <td class=btext NOWRAP align=right><%=gtcountssr9!=0?(ndf.format(gtcountssr9)):"-" %></td>
   <td class=btext NOWRAP align=right><%=gtcountssr10!=0?(ndf.format(gtcountssr10)):"-" %></td>
  <td class=btext NOWRAP align=right><%=gtcountssr11!=0?(ndf.format(gtcountssr11)):"-" %></td>
  <td class=btext NOWRAP align=right><%=gtcountssr12!=0?(ndf.format(gtcountssr12)):"-" %></td>
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



