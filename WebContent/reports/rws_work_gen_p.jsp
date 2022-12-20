<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
	//String loggedUser = user.getUserId();
	
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());

    DecimalFormat ndf = new DecimalFormat("####.##");
    
    
	//String financialyr="";
	StringBuffer financialyr=new StringBuffer();
	
	
    double aas=0;
    
    //String dcode=request.getParameter("dcode");
    StringBuffer dcode=new StringBuffer(request.getParameter("district"));
    //System.out.println("dcode::::::::::::"+dcode.toString());
    
    StringBuffer distname=new StringBuffer(request.getParameter("distname"));
    //System.out.println("distname::::::::::::"+distname.toString());
    session.setAttribute("distname",distname);
    
	if(request.getParameter("finyear")!=null)
	{
		financialyr.delete(0,financialyr.length());
	financialyr.append(request.getParameter("finyear"));
	session.setAttribute("financialyr",financialyr.toString());
	} else
	{
		financialyr.delete(0,financialyr.length());
	financialyr.append(session.getAttribute("financialyr"));
	}
   
	//String yr =financialyr.substring(0,4);
	StringBuffer yr=new StringBuffer();
	yr.delete(0,yr.length());
	yr.append(financialyr.substring(0,4));
	
	
	int lyr1=Integer.parseInt(yr.toString())-1;
	
	
	
	//System.out.println("lyr1:"+lyr1);
	//////System.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
	
   // String prvyr=""+(Integer.parseInt(yr.toString())-1);
	//String nextyr=""+(Integer.parseInt(yr.toString())+1);
	
	StringBuffer prvyr=new StringBuffer();
	prvyr.delete(0,prvyr.length());
	prvyr.append(""+(Integer.parseInt(yr.toString())-1));
	
	StringBuffer nextyr=new StringBuffer();
	nextyr.delete(0,nextyr.length());
	nextyr.append(""+(Integer.parseInt(yr.toString())+1));
	
	//System.out.println("nextyr:"+nextyr);
	
	
	
    // String subnextyr=nextyr.substring(2,4);
    ////System.out.println("subnextyr:"+subnextyr);
    StringBuffer subnextyr=new StringBuffer();
    subnextyr.delete(0,subnextyr.length());
    subnextyr.append(nextyr.substring(2,4));
	
    
    
	//String planNonplan=request.getParameter("planNonplan");
	 StringBuffer planNonplan=new StringBuffer();
	 planNonplan.delete(0,planNonplan.length());
	 planNonplan.append(request.getParameter("planNonplan"));
	 session.setAttribute("planNonplan",planNonplan);
	 ////System.out.println("planNonplan::"+planNonplan);
	 
	 
	//String planName = "PLAN & NON PLAN";
	 StringBuffer planName=new StringBuffer();
	 planName.delete(0,planName.length());
	 planName.append("PLAN & NON PLAN");
	
	
	 //String planQry="";
	 StringBuffer planQry=new StringBuffer();
	 planQry.delete(0,planQry.length());
	
	if(planNonplan.toString().equals("1"))
	{
	 planQry.delete(0,planQry.length());
	 planQry.append("and plan_code = '1'");
     session.setAttribute("plan","1");
     planName.delete(0,planName.length());
	 planName.append(" PLAN ");
	}
	else if(planNonplan.equals("2"))
	{
		planQry.delete(0,planQry.length());
		planQry.append( "and plan_code = '2'");
		 planName.delete(0,planName.length());
		planName.append(" NON PLAN ");
	    session.setAttribute("plan","2");
	}
	
	  String[] programes=request.getParameterValues("program");
  	    StringBuffer programe=new StringBuffer();
	    programe.append("");
		
		for(int i=0;i<programes.length;i++)
		{
			//programe.delete(0,programe.length());
		programe.append(programes[i]+",");
		}
		////System.out.println("programe::"+programe);
		programe.append(programe.substring(0,programe.length()-1));
	    session.setAttribute("programe",programe);
		////System.out.println("programe::"+programe);

    StringBuffer scheme=new StringBuffer();
 
  
  if(request.getParameterValues("scheme")!=null)
  {
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
		//scheme.delete(0,scheme.length());
	 scheme.append(schemes[i]+",");
	}
	////System.out.println("programe::"+programe);
	scheme.append(scheme.substring(0,scheme.length()-1));
    session.setAttribute("scheme",scheme);
}
  
  // String sysdate=workData.getDate();
  StringBuffer sysdate=new StringBuffer();
  sysdate.append(workData.getDate());
	
  //String sysmon=sysdate.substring(3,5);
  StringBuffer sysmon=new StringBuffer();
  sysmon.append(sysdate.substring(3,5));
	
  
  int mon=Integer.parseInt(sysmon.toString());
   ////System.out.println("sysdate::"+sysdate);
   
 //  String sysyear=sysdate.substring(6,10);
   StringBuffer sysyear=new StringBuffer();
   sysyear.append(sysdate.substring(6,10));

   int yy=Integer.parseInt(sysyear.toString());
   //////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;
  // String fyear,fyear1;
   ////System.out.println("fin ear::"+yr+"sys year::"+sysyear);
   if(yr.toString().equals(sysyear.toString()))
   {
     prevyear=yy;
     prevmon=mon-1;
     ////System.out.println("else prevyear::"+prevyear+"prevmon::"+prevmon);
    
   }
  else
	{
    prevyear=yy; 
    prevmon=3;
    ////System.out.println("if prevyear::"+prevyear+"prevmon::"+prevmon);     
	}
    String months[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
   
    //String mymon=months[prevmon-1];
    StringBuffer mymon=new StringBuffer();
    mymon.append(months[prevmon-1]);

//String statePrograms="00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67";
StringBuffer statePrograms=new StringBuffer();
statePrograms.delete(0, statePrograms.length());
statePrograms.append("00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67");


StringBuffer relTable=new StringBuffer();
StringBuffer amount=new StringBuffer();
StringBuffer relColumn=new StringBuffer();
StringBuffer txid=new StringBuffer();

if(statePrograms.toString().contains(programe.toString()))
{
relTable.delete(0,relTable.length());	
relTable.append("RWS_bill_pao_bridge_det_TBL");

relColumn.delete(0,relColumn.length());
relColumn.append("STATE_SEND_DATE");

txid.delete(0,txid.length());
txid.append("STATE_TXID");

amount.delete(0,amount.length());
amount.append("BILL_AMOUT_STATE");
}else
{
relTable.delete(0,relTable.length());		
relTable.append("RWS_bill_BANK_bridge_det_TBL");

relColumn.delete(0,relColumn.length());
relColumn.append("BANK_SEND_DATE");

txid.delete(0,txid.length());
txid.append("TXID");

amount.delete(0,amount.length());
amount.append("BILL_AMOUNT_CENTRAL");

}



session.setAttribute("relTable",relTable);
session.setAttribute("relColumn",relColumn);
session.setAttribute("txid",txid);
session.setAttribute("amount",amount);
session.setAttribute("yr",yr);
//String nextmonth=RwsUtils.getNextMonth().toUpperCase();
StringBuffer nextmonth=new StringBuffer(RwsUtils.getNextMonth().toUpperCase());

	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td><a href="javascript:onclick=history.go(-1)">Back|</a></td></tr>
<%  } else {%>
	<tr><td align="right"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	</table>
<table border = 0 cellspacing = 0 cellpadding = 0 height=5% width="100%" style="border-collapse:collapse"  align = "center">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan=27>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)</td>	
	</tr>
		<tr align="center" > <td class=gridhdbg colspan=27>District :<%=distname.toString() %> <font color="yellow" face="verdana" size="2"> <%=planName.toString()%></font> Works</td> </td>
		<tr align=center  align=center>
		<td class=gridhdbg rowspan = 2>Sl.No</td>
		<td class=gridhdbg rowspan = 2>District</td>
		<td colspan=3 class=gridhdbg align="center">No.of Works</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
		<td colspan=3 class=gridhdbg align="center">Est.Cost</td>
		<td  colspan=3 class=gridhdbg align="center">Exp. Upto Last Fin. Year</td>
		<td  rowspan=2 class=gridhdbg align="center">Bal Est.Cost as on 1.4.<%=yr.toString()%>(9-12)</td>
		<td  colspan=3 class=gridhdbg align="center">Releases</td>
		<!--
		<td  colspan=2 class=gridhdbg align="center">Expenditure</td>	
		-->
		<td  colspan=2 class=gridhdbg align="center">Physically Completed But Financially Not Completed Works Expenditure<br>Works Completed Any Time</br></td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Total Exp.(Releases)</td>	
		<td rowspan=2 colspan=1 class=gridhdbg align="center">% of Exp. against Bal Est.Cost(20/13)</td>	
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">Total Exp.(18+20)</td>	 -->
		
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Technically Sanctioned</td>
		<td rowspan=1 colspan=2 class=gridhdbg align="center">Grounded Works</td>
		<td rowspan=1 colspan=2 class=gridhdbg align="center">Completed Works</td>
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">No. of Habs Covered upto previous year</td>-->
	    <td rowspan=2 colspan=1 class=gridhdbg align="center">Covered during the year</td> 

		<!-- td rowspan=2 colspan=1 class=gridhdbg align="center">% of coverage against balance Habs(21/20)</td>-->

		</tr>
		<tr>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Rel. Upto Last Fin. Year through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Rel. Upto Last Fin. Year through pao</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Releases through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Releases through PAO</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total Releases</td>
		
		<!--<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp.upto Previous month</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. During The Year</td>
        -->
        <td rowspan=1 colspan=1 class=gridhdbg align="center">Rel.upto Previous month</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Rel. During The Year</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">No.of.Works</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Bal Est.Cost as on 1.4.<%=yr.toString()%></td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">No.of.Works</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Bal Est.Cost as on 1.4.<%=yr.toString()%></td>
		
		
		</tr>
	<tr><td align="center" class=gridhdbg>1</td><td align="center" class=gridhdbg>2</td><td align="center" class=gridhdbg>3</td><td align="center" class=gridhdbg >4</td><td align="center" class=gridhdbg >5</td><td align="center" class=gridhdbg>6</td><td align="center" class=gridhdbg>7</td><td align="center" class=gridhdbg>8</td><td align="center" class=gridhdbg>9</td><td align="center" class=gridhdbg>10</td><td align="center" class=gridhdbg>11</td><td align="center" class=gridhdbg>12</td><td align="center" class=gridhdbg>13</td><td align="center" class=gridhdbg>14</td><td align="center" class=gridhdbg>15</td><td align="center" class=gridhdbg>16</td><td align="center" class=gridhdbg>17</td><td align="center" class=gridhdbg>18</td><td align="center" class=gridhdbg>19</td><td align="center" class=gridhdbg>20</td><td align="center" class=gridhdbg>21</td><td align="center" class=gridhdbg>22</td><td align="center" class=gridhdbg>23</td><td align="center" class=gridhdbg>24</td>
	<td align="center" class=gridhdbg>25</td>
	<td align="center" class=gridhdbg>26</td>
	<!--<td align="center" class=gridhdbg>27</td>
	<td align="center" class=gridhdbg>28</td>
	<td align="center" class=gridhdbg>29</td>
	<td align="center" class=gridhdbg>30</td>
	-->
	<%
	
	try{
	int cnt=1;
	
	StringBuffer qry1=new StringBuffer();
	
	
	qry1.append("select  sum(case when to_date(BANK_SEND_DATE) >= '01-Apr-"+yr.toString()+"'  and to_date(BANK_SEND_DATE) < '01-Apr-"+nextyr.toString()+"'  and TXID is not null  then (BILL_AMOUNT_CENTRAL)/100000  else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then (BILL_AMOUT_STATE)/100000  else 0 end),category_code  from rws_bill_bank_bridge_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"') )");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
 
	Statement	stmt14=conn.createStatement();
	//System.out.println("Releases expqry:"+qry1.toString());
	ResultSet rs14=stmt14.executeQuery(qry1.toString());
	Hashtable relhash=new Hashtable();
	while(rs14.next())
	{
		relhash.put(rs14.getString(2),rs14.getString(1));
	}
    if(rs14!=null)rs14.close();
	if(stmt14!=null)stmt14.close();

		
	
	
	qry1.delete(0,qry1.length());
	
	qry1.append("select count(*),category_code FROM RWS_WORK_ADMN_TBL W where (w.ADMIN_DATE >= '01-Apr-"+yr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+nextyr.toString()+"') and work_cancel_dt is null "+planQry.toString()+" and w.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")");
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	 qry1.append(" group by category_code order by 2");
	//System.out.println("1nqry:"+qry1.toString());
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(qry1.toString());
	Hashtable h=new Hashtable();
	while(rs1.next())
	{
		h.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	qry1.delete(0,qry1.length());
	
	
	qry1.append("SELECT count(*),category_code  FROM RWS_WORK_ADMN_TBL W where to_date(w.ADMIN_DATE) <'01-Apr-"+yr.toString()+"'  and work_cancel_dt is null "+planQry.toString()+" and w.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and w.work_id not in (select work_id from rws_work_completion_tbl where ((to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr.toString()+"')))");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" group by category_code order by 2");
	Statement	stmt2=conn.createStatement();
	//System.out.println("1sqry*************8sri:"+qry1.toString());
	ResultSet rs2=stmt2.executeQuery(qry1.toString());
	Hashtable h1=new Hashtable();
	while(rs2.next())
	{
		h1.put(rs2.getString(2),rs2.getString(1));
		////System.out.println(rs2.getString(2)+"...."+rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	qry1.delete(0,qry1.length());
	
	qry1.append("select count(*),category_code from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b,rws_programme_tbl p   where a.work_id=b.work_id and work_cancel_dt is null "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and b.programme_code=p.programme_code   and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by  2");
	Statement	stmt3=conn.createStatement();
	//System.out.println("main hqry:"+qry1.toString());
	ResultSet rs3=stmt3.executeQuery(qry1.toString());
	Hashtable h2=new Hashtable();
	while(rs3.next())
	{
		h2.put(rs3.getString(2),rs3.getString(1));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
	qry1.delete(0,qry1.length());
	
	qry1.append("select sum(sanction_amount),category_code  from rws_work_admn_tbl w,rws_programme_tbl p  where  (admin_date>='01-Apr-"+yr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+nextyr.toString()+"') "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and w.programme_code=p.programme_code   and work_cancel_dt is null  ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt4=conn.createStatement();
	//////System.out.println("nsqry:"+qry1.toString());
	ResultSet rs4=stmt4.executeQuery(qry1.toString());
	Hashtable h3=new Hashtable();
	while(rs4.next())
	{
		h3.put(rs4.getString(2),rs4.getString(1));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	qry1.delete(0,qry1.length());
	
	qry1.append("SELECT sum(sanction_amount),category_code FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p where w.ADMIN_DATE <'01-Apr-"+yr.toString()+"' and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code   and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt5=conn.createStatement();
	////System.out.println("nsqryooooooooooo:"+qry1.toString());
	ResultSet rs5=stmt5.executeQuery(qry1.toString());
	Hashtable h4=new Hashtable();
	while(rs5.next())
	{
		h4.put(rs5.getString(2),rs5.getString(1));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	qry1.delete(0,qry1.length());
	
	
	 qry1.append("select  sum(case when to_date(voucher_dt) < '01-Apr-"+yr.toString()+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),category_code  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"') )");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
   //String expqry="select  sum(case when (substr(year,1,4)< '"+yr+"' and substr(year,6,2)< '"+subnextyr+"') then total else 0 end)||'@'||sum(case when (year='"+financialyr+"') then total else 0 end),category_code  from rws_exp_view a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+")   and b.programme_code=p.programme_code    group by category_code  order by 2 ";
   // String expqry="select  sum(case when year<> '"+financialyr+"' then total else 0 end)||'@'||sum(case when year='"+financialyr+"' then total else 0 end),category_code  from rws_exp_view a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+")   and b.programme_code=p.programme_code  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  group by category_code  order by 2 ";
    Statement	stmt6=conn.createStatement();
	//System.out.println("expqry....:"+qry1.toString());//query on 24 dec
	ResultSet rs6=stmt6.executeQuery(qry1.toString());
	Hashtable h5=new Hashtable();
	while(rs6.next())
	{
		h5.put(rs6.getString(2),rs6.getString(1));
	}
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	qry1.delete(0,qry1.length());
	//Direct Voucher Table  Amount 
	
	
	////////////added by anu 11032015/////
	
	
	qry1.append("select sum(case when (to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end),category_code  from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+" and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by  category_code   order by 1");

	 Statement	stmt90=conn.createStatement();
		
		ResultSet rs90=stmt90.executeQuery(qry1.toString());
		//System.out.println("expqry.finlast..anupama.:"+qry1.toString());
		Hashtable lastfinbank=new Hashtable();
		while(rs90.next())
		{
			//System.out.println("anupama lasetyear"+rs90.getString(2));
			lastfinbank.put(rs90.getString(2),rs90.getString(1));
		}
	    if(rs90!=null)rs90.close();
		if(stmt90!=null)stmt90.close();
		qry1.delete(0,qry1.length());
	
	
		
		
		qry1.append("select sum(case when (to_date(STATE_SEND_DATE)<='31-Mar-"+yr.toString()+"')then BILL_AMOUT_STATE else 0 end),category_code from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by  category_code   order by 1");

			Statement stmt91=conn.createStatement();
	    // System.out.println("last year releases anupama pao"+qry1.toString());
		 ResultSet rs91=stmt91.executeQuery(qry1.toString());
		Hashtable lastyearpaoreleases=new Hashtable();
		while(rs91.next())
		{
			lastyearpaoreleases.put(rs91.getString(2),rs91.getString(1));
		}
		if(rs91!=null)rs91.close();
		if(stmt91!=null)stmt91.close();

		qry1.delete(0,qry1.length());
		
		
		
		
		
		
		
		
	
	
	
	 qry1.append("select  sum(case when to_date(voucher_dt)< '01-Apr-"+yr.toString()+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),category_code  from rws_work_direct_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))");
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
   //String expqry="select  sum(case when (substr(year,1,4)< '"+yr+"' and substr(year,6,2)< '"+subnextyr+"') then total else 0 end)||'@'||sum(case when (year='"+financialyr+"') then total else 0 end),category_code  from rws_exp_view a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+")   and b.programme_code=p.programme_code    group by category_code  order by 2 ";
   // String expqry="select  sum(case when year<> '"+financialyr+"' then total else 0 end)||'@'||sum(case when year='"+financialyr+"' then total else 0 end),category_code  from rws_exp_view a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+")   and b.programme_code=p.programme_code  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  group by category_code  order by 2 ";
    Statement	stmt634=conn.createStatement();
	////System.out.println("expqry:"+qry1.toString());
	ResultSet rs634=stmt634.executeQuery(qry1.toString());
	Hashtable directVoucherHash=new Hashtable();
	while(rs634.next())
	{
		directVoucherHash.put(rs634.getString(2),rs634.getString(1));
	}
    if(rs634!=null)rs634.close();
	if(stmt634!=null)stmt634.close();
	qry1.delete(0,qry1.length());
	
	//////End 
	
	
	
	
	
	qry1.append("SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END),category_code FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W,rws_programme_tbl p WHERE W.WORK_ID=E.WORK_ID and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code  and w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt7=conn.createStatement();
    //System.out.println("tsqry:"+qry1.toString());
	ResultSet rs7=stmt7.executeQuery(qry1.toString());
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	qry1.delete(0,qry1.length());
	
	qry1.append("SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),category_code  FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W,rws_programme_tbl p WHERE W.WORK_ID=G.WORK_ID and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code  and  w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt8=conn.createStatement();
	//System.out.println("gqry:"+qry1.toString());
	ResultSet rs8=stmt8.executeQuery(qry1.toString());
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	qry1.delete(0,qry1.length());
	
	
	/////////////////////////grounded works estimate cost//////////////////////////
	
	
	
	
	
	////////voucher amt)
	/* qry1.append("select  sum(case when to_date(voucher_dt) < '01-Apr-"+yr.toString()+"' then voucher_amt else 0 end),category_code  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p ,RWS_WORK_COMMENCEMENT_TBL c where a.work_id=b.work_id and b.work_id=c.work_id and c.GROUNDING_DATE IS NOT NULL  and work_cancel_dt is null "+planQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr.toString()+"') ) ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	stmt8=conn.createStatement();
	System.out.println("gqryvoucher:"+qry1.toString());
	rs8=stmt8.executeQuery(qry1.toString());
	Hashtable h12=new Hashtable();
	while(rs8.next())
	{
		h12.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close(); */
	
	
	qry1.append("select category_code,sum(BILL_AMOUNT_CENTRAL) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where   "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+" and    a.work_id not in (select work_id from rws_work_completion_tbl ) ") ;
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by  category_code ");

	stmt8=conn.createStatement();
	//System.out.println("gqryvoucher:"+qry1.toString());
	rs8=stmt8.executeQuery(qry1.toString());
	Hashtable h12=new Hashtable();
	while(rs8.next())
	{
		h12.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close(); 
	qry1.delete(0,qry1.length());
	
	
	
	
	qry1.append("select category_code ,sum(BILL_AMOUT_STATE) from rws_work_admn_tbl a ,RWS_BILL_pao_BRIDGE_DET_TBL b  where  STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and  a.work_id not in (select work_id from rws_work_completion_tbl) ") ;
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by  category_code ");

	Statement stmt95=conn.createStatement();
	//System.out.println("gqryvoucher:"+qry1.toString());
	ResultSet rs95=stmt95.executeQuery(qry1.toString());
	Hashtable h16=new Hashtable();
	while(rs95.next())
	{
		h16.put(rs95.getString(2),rs95.getString(1));
	}
	if(rs95!=null)rs95.close();
	if(stmt95!=null)stmt95.close(); 
	qry1.delete(0,qry1.length());
	
	
	
	
	
	
	
	
	
	
	//////////sanction amt)//////////////
    qry1.delete(0,qry1.length());
	qry1.append("SELECT distinct sum(sanction_amount),SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),category_code  FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W,rws_programme_tbl p WHERE W.WORK_ID=G.WORK_ID and work_cancel_dt is null  "+planQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code  and  w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	stmt8=conn.createStatement();
	//System.out.println("gqrysantion:"+qry1.toString());
	rs8=stmt8.executeQuery(qry1.toString());
	Hashtable h13=new Hashtable();
	while(rs8.next())
	{
		h13.put(rs8.getString(3),rs8.getString(1)+"@"+rs8.getString(2));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	qry1.delete(0,qry1.length());
	
	
	
	///////////////////////////////////////////////////////////////////
	qry1.append("select sum(case when date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' then 1 else 0 end),category_code from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_programme_tbl p where w.work_id=wc.work_id  and work_cancel_dt is null  "+planQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code  ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt9=conn.createStatement();
	//System.out.println("wcqry:"+qry1.toString());
	ResultSet rs9=stmt9.executeQuery(qry1.toString());
	Hashtable h8=new Hashtable();
	while(rs9.next())
	{
		h8.put(rs9.getString(2),rs9.getString(1));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	qry1.delete(0,qry1.length());
	
	
	
	/////////////////////////////////wc qrys amts////////////////
	
	
	
	qry1.append("select sum(case when date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' then 1 else 0 end),sum(sanction_amount),category_code from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_programme_tbl p where w.work_id=wc.work_id  and work_cancel_dt is null   "+planQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	stmt9=conn.createStatement();
	//System.out.println("wcqrysanctionamt:"+qry1.toString());
	rs9=stmt9.executeQuery(qry1.toString());
	Hashtable h14=new Hashtable();
	while(rs9.next())
	{
		h14.put(rs9.getString(3),rs9.getString(1)+"@"+rs9.getString(2));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	qry1.delete(0,qry1.length());
	
	
	
	
	
	
	
	qry1.append("select sum(case when date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' then 1 else 0 end),sum(voucher_amt),category_code from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_programme_tbl p,rws_work_exp_voucher_tbl v where w.work_id=wc.work_id  and w.work_id=v.work_id and work_cancel_dt is null   "+planQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code ");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(w.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	stmt9=conn.createStatement();
	//System.out.println("wcqry:"+qry1.toString());
	rs9=stmt9.executeQuery(qry1.toString());
	Hashtable h15=new Hashtable();
	while(rs9.next())
	{
		h15.put(rs9.getString(3),rs9.getString(1)+"@"+rs9.getString(2));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	qry1.delete(0,qry1.length());
	
	
	
	
	
	
	////////////////////////////////////////////////////
	
	qry1.append("Select count(hab_code),category_code  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b  where a.work_id =b.work_id and work_cancel_dt is null  "+planQry.toString()+"  and b.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and   a.work_id not in (select work_id from  rws_work_completion_tbl where date_of_completion<'01-Apr-"+yr.toString()+"' )");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	Statement	stmt10=conn.createStatement();
	////System.out.println("chqry:"+qry1.toString());
	ResultSet rs10=stmt10.executeQuery(qry1.toString());
	Hashtable h9=new Hashtable();
	while(rs10.next())
	{
		h9.put(rs10.getString(2),rs10.getString(1));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();
	qry1.delete(0,qry1.length());
	
	qry1.append("Select count(hab_code),category_code  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b  where a.work_id =b.work_id and work_cancel_dt is null  "+planQry.toString()+"  and b.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and    a.work_id in (select work_id from  rws_work_completion_tbl where (date_of_completion>='01-Apr-"+yr.toString()+"'  and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' ) or (partial_date_of_completion>='01-Apr-"+yr.toString()+"'  and partial_date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' ))");
	if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");
	
	Statement	stmt11=conn.createStatement();
	//System.out.println("covqry 26 thhhs:"+qry1.toString());
	ResultSet rs11=stmt11.executeQuery(qry1.toString());
	Hashtable h10=new Hashtable();
	while(rs11.next())
	{
		h10.put(rs11.getString(2),rs11.getString(1));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
	qry1.delete(0,qry1.length());
    //String expmonqry="select sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),category_code from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  and to_char(voucher_dt,'yyyy')='"+prevyear+"' and  TO_char(voucher_dt,'MON')='"+mymon+"' and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-FEB-"+(Integer.parseInt(yr)+1)+"') group by category_code  order by 2";
    qry1.append("select sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-"+mymon.toString()+"-"+nextyr.toString()+"') then voucher_Amt else 0 end),category_code from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"   and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and b.programme_code=p.programme_code  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')");
    if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(b.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append("  group by category_code order by 2");

    //System.out.println("expmonqry>>>>>>>>"+qry1.toString());// query find on 24 dec   
    Statement stmt12=conn.createStatement();
	ResultSet rs12=stmt12.executeQuery(qry1.toString());
	Hashtable h11=new Hashtable();
  	while(rs12.next())
	{
		h11.put(rs12.getString(2),rs12.getString(1));
	}
	if(rs12!=null)rs12.close();
	if(stmt12!=null)stmt12.close();
	qry1.delete(0,qry1.length());

                             ///////Added by anu for Releases 28072015//////
    
                             
	
                             
                             


  // qry1.append("select category_code ,sum(case when (to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"  and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null )");
  qry1.append("select category_code,nvl(sum(BILL_AMOUNT_CENTRAL),0)||'@'||nvl(sum(BILL_AMOUNT_CENTRAL),0) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(bank_send_date)>='01-APR-"+yr.toString()+"' and to_date(bank_send_date)<='31-MAR-"+nextyr.toString()+"' and txid is not null ");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and b.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  b.programme_code in ("+programe.toString()+")  group by  category_code   order by 1");

		Statement stmt25=conn.createStatement();
     //System.out.println("monthlllyreleases bank"+qry1.toString());
	 ResultSet rs25=stmt25.executeQuery(qry1.toString());
	Hashtable monreleasesbank=new Hashtable();
	while(rs25.next())
	{
		monreleasesbank.put(rs25.getString(1),rs25.getString(2));
	}
	if(rs25!=null)rs25.close();
	if(stmt25!=null)stmt25.close();
	qry1.delete(0,qry1.length());
	
	
	
	
	   //qry1.append("select category_code ,sum(case when (to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUT_STATE else 0 end) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
	   qry1.append("select category_code,nvl(sum(BILL_AMOUT_STATE),0)||'@'||nvl(sum(BILL_AMOUT_STATE),0) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and to_date(state_send_date)>='01-APR-"+yr.toString()+"' and to_date(state_send_date)<='31-MAR-"+nextyr.toString()+"' and state_txid is not null ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append("and b.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  b.programme_code in ("+programe.toString()+") group by  category_code   order by 1");

			Statement stmt26=conn.createStatement();
	     //System.out.println("monthlllyreleases pao"+qry1.toString());
		 ResultSet rs26=stmt26.executeQuery(qry1.toString());
		Hashtable monreleasespao=new Hashtable();
		while(rs26.next())
		{
			monreleasespao.put(rs26.getString(1),rs26.getString(2));
		}
		if(rs26!=null)rs26.close();
		if(stmt26!=null)stmt26.close();

		qry1.delete(0,qry1.length());




//////////////////////////////////////////////////////////////////////////////////
/* 	 qry1.append("select category_code ,sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>='01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id in (select b.work_id from  "+relTable.toString()+" b  where to_date("+relColumn.toString()+")>= '01-Apr-"+yr.toString()+"' and "+txid.toString()+" is not null) and a.work_id=b.work_id  "+planQry.toString()+" and    a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) and DATE_OF_COMPLETION is  not null ) group by  category_code   order by 1");

		Statement stmt13=conn.createStatement();
     //System.out.println("newWorksExpenSVS"+qry1.toString());
	 ResultSet rs13=stmt13.executeQuery(qry1.toString());
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs13.next())
	{
		newWorksExpSVS.put(rs13.getString(1),rs13.getString(2));
	}
	if(rs13!=null)rs13.close();
	if(stmt13!=null)stmt13.close();
	qry1.delete(0,qry1.length()); 
	 */
	 
	
	 
	///////////modified by anu for releases 11032015////////////////
	
	 qry1.append("select category_code ,sum(case when (to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"   and  a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") ) group by  category_code   order by 1");

	Statement stmt13=conn.createStatement();
    //System.out.println("newWorksExpenSVS123"+qry1.toString());
	 ResultSet rs13=stmt13.executeQuery(qry1.toString());
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs13.next())
	{
		newWorksExpSVS.put(rs13.getString(1),rs13.getString(2));
	}
	if(rs13!=null)rs13.close();
	if(stmt13!=null)stmt13.close();
	qry1.delete(0,qry1.length()); 
	
	
	
	
	  qry1.append("select category_code ,sum(case when (to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUT_STATE else 0 end) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and    a.work_id in (select work_id from rws_work_completion_tbl where  DATE_OF_COMPLETION is not null ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")) group by  category_code   order by 1");

			Statement stmt93=conn.createStatement();
	     //System.out.println("monthlllyreleases pao123"+qry1.toString());
		 ResultSet rs93=stmt93.executeQuery(qry1.toString());
		Hashtable monreleasespao123=new Hashtable();
		while(rs93.next())
		{
			monreleasespao123.put(rs93.getString(1),rs93.getString(2));
		}
		if(rs93!=null)rs93.close();
		if(stmt93!=null)stmt93.close();

		qry1.delete(0,qry1.length());
	
	
	
	

	
   int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0,bhabs=0;
   double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0,balecost=0.0,totreleases1=0.0,epenmtot=0.0,balpcost=0.0,htot=0.0,release1bank=0.0,releasebank2=0.0,releasepao=0.0,releasepao2=0.0,lastyearreleases=0.0,lastyearreleasepao=0.0;
   double totgrdestatm=0,totwcestatm=0;
   
	qry1.append("select category_code,category_name	 from rws_work_category_tbl order by 1");
	stmt=conn.createStatement();
    double gv1=0,gv2=0;
	rs=stmt.executeQuery(qry1.toString());
	
	StringBuffer a1=new StringBuffer();
	StringBuffer a2=new StringBuffer();
	StringBuffer da1=new StringBuffer();
	StringBuffer da2=new StringBuffer();

	StringBuffer nwork=new StringBuffer();
	StringBuffer swork=new StringBuffer();
	StringBuffer shabs=new StringBuffer();
	StringBuffer nsamt=new StringBuffer();
	StringBuffer ssamt=new StringBuffer();
	StringBuffer exp=new StringBuffer();
	StringBuffer directexp=new StringBuffer();
	StringBuffer thabs=new StringBuffer();
	StringBuffer gdate=new StringBuffer();
	StringBuffer wcdate=new StringBuffer();
	StringBuffer chabs=new StringBuffer();
	StringBuffer covhabs=new StringBuffer();
	StringBuffer expenm=new StringBuffer();
	StringBuffer fexpenm=new StringBuffer();
	StringBuffer value1=new StringBuffer();
	StringBuffer value2=new StringBuffer();
	StringBuffer grdwrksamt=new StringBuffer();
	StringBuffer grdwrksamt1=new StringBuffer();
	
	
	StringBuffer grdwrkexpamt=new StringBuffer();
	StringBuffer bankreleases=new StringBuffer();
	StringBuffer paoreleases=new StringBuffer();
	StringBuffer lastyeatexp=new StringBuffer();
	StringBuffer lasetyearexppao=new StringBuffer();
	StringBuffer phycomreleases=new StringBuffer();
	
	
	StringBuffer comwrksamt=new StringBuffer();
	StringBuffer comwrkexpamt=new StringBuffer();
	
	StringBuffer Relexp=new StringBuffer();
	
	
	int styleCount=0;

	//String style="";
	StringBuffer style=new StringBuffer();
	while(rs.next())
	{
		
		double raa1=0;
		 double raa2=0;
		double totalreleaselastyear=0;
		
		 double aa1=0;
		 double daa1=0;
		
		  double eexpenm=0; 
		  double aa2=0; 	
		  double v1=0,v3=0,v4=0,v5=0,v6=0; 
		  double v2=0;
		  double release1=0;
		  double release2=0;
		  double paorelease1=0;
		  double paorelease2=0;
		  double totexpprevmonth=0,totexpyear=0;
		  double grdsanamt=0,grdvoamt=0,grdestamt=0,comestamt=0,comsanamt=0,comexpamt=0,lastexpbank=0,lastexppao=0,grdvoamt1=0,a11=0,a10=0,a12,a13;
    
		
		 nwork.delete(0,nwork.length());
		 nwork.append(h.get(rs.getString(1)));
	     if(nwork.toString()!=null && !nwork.toString().equals("") && !nwork.toString().equals("null"))
	     {
	    	 
	     }else
	     {
	    	 nwork.delete(0,nwork.length());
	    	 nwork.append("0");
	     }
	    
	    swork.delete(0,swork.length());
		swork.append(h1.get(rs.getString(1)));
		if(swork.toString()!=null && !swork.toString().equals("") && !swork.toString().equals("null")){}else{
		swork.delete(0,swork.length());swork.append("0");}
		
		
		shabs.delete(0,shabs.length());
		shabs.append(h2.get(rs.getString(1)));
		if(shabs.toString()!=null && !shabs.toString().equals("") && !shabs.toString().equals("null")){}else{shabs.delete(0,shabs.length());shabs.append("0");}
		
		nsamt.delete(0,nsamt.length());
		nsamt.append(h3.get(rs.getString(1)));
		if(nsamt.toString()!=null && !nsamt.toString().equals("") && !nsamt.toString().equals("null")){}else{nsamt.delete(0,nsamt.length());nsamt.append("0");}
		
		
		ssamt.delete(0,ssamt.length());
		ssamt.append(h4.get(rs.getString(1)));
		if(ssamt.toString()!=null && !ssamt.toString().equals("") && !ssamt.toString().equals("null")){}else{ssamt.delete(0,ssamt.length());ssamt.append("0");}
		
		
		  exp.delete(0,exp.length());
		 exp.append(h5.get(rs.getString(1)));
        if(exp.toString()!=null && !exp.toString().equals("") && !exp.toString().equals("null"))
        {
		String []aa=exp.toString().split("@");
		/* a1.delete(0, a1.length());a1.append(aa[0]);a2.delete(0, a2.length());a2.append(aa[1]); */
		
		 aa1=Double.parseDouble(aa[0].toString())/100000;
		 aa2=Double.parseDouble(aa[1].toString())/100000; 	
		//System.out.println("#1..."+aa);
		}
        else{
        	aa1=0;
        	aa2=0;
        	//a1.delete(0, a1.length());a1.append("0");a2.delete(0, a2.length());a2.append("0");
		}
        
         directexp.delete(0,directexp.length());
         directexp.append(directVoucherHash.get(rs.getString(1)));
         
        if(directexp.toString()!=null && !directexp.toString().equals("") && !directexp.toString().equals("null"))
        {
		String []aa=directexp.toString().split("@");
		
		// da1.delete(0, da1.length());da1.append(aa[0]);
		da2.delete(0, da2.length());da2.append(aa[1]);
	 	
		 daa1=Double.parseDouble(aa[0].toString())/100000;
		
		}
        else
        {
        	//da1.delete(0, da1.length());da1.append("0");
        	daa1=0;
        	da2.delete(0, da2.length());da2.append("0");
		}
                
         thabs.delete(0,thabs.length());
		 thabs.append(h6.get(rs.getString(1)));
		 if(thabs.toString()!=null && !thabs.toString().equals("") && !thabs.toString().equals("null")){}else{thabs.delete(0, thabs.length());thabs.append("0");}
		
		gdate.delete(0,gdate.length());
		 gdate.append(h7.get(rs.getString(1)));
		if(gdate.toString()!=null && !gdate.toString().equals("") && !gdate.toString().equals("null")){}else{gdate.delete(0, gdate.length());gdate.append("0");}
		
		wcdate.delete(0,wcdate.length());
		 wcdate.append(h8.get(rs.getString(1)));
		if(wcdate.toString()!=null && !wcdate.toString().equals("") && !wcdate.toString().equals("null")){}else{wcdate.delete(0, wcdate.length());wcdate.append("0");}
		
		
		chabs.delete(0,chabs.length());
		 chabs.append(h9.get(rs.getString(1)));
		if(chabs.toString()!=null && !chabs.toString().equals("") && !chabs.toString().equals("null")){}else{chabs.delete(0, chabs.length());chabs.append("0");}
		
		
		covhabs.delete(0,covhabs.length());
		 covhabs.append(h10.get(rs.getString(1)));
		if(covhabs.toString()!=null && !covhabs.toString().equals("") && !covhabs.toString().equals("null")){}else{covhabs.delete(0, covhabs.length());covhabs.append("0");}
		
		
		 expenm.delete(0,expenm.length());
		 expenm.append(h11.get(rs.getString(1)));
		if(expenm.toString()!=null && !expenm.toString().equals("") && !expenm.toString().equals("null")){}
		else{expenm.delete(0, expenm.length());expenm.append("0");}
		
		////////////added by anu
		
		bankreleases.delete(0,bankreleases.length());
		bankreleases.append(monreleasesbank.get(rs.getString(1)));
		if(bankreleases.toString()!=null && !bankreleases.toString().equals("") && !bankreleases.toString().equals("null"))
		{
			String bankrel[]=bankreleases.toString().split("@");
			release1=Double.parseDouble(bankrel[0].toString())/100000;
			release2=Double.parseDouble(bankrel[1].toString())/100000;
		}
		else
		{
			bankreleases.delete(0,bankreleases.length());
			bankreleases.append("0");
			release1=0;
			release2=0;
			
		}
		
		//System.out.println("release1 bank anupama"+release1);
		paoreleases.delete(0,paoreleases.length());
		paoreleases.append(monreleasespao.get(rs.getString(1)));
		if(paoreleases.toString()!=null && !paoreleases.toString().equals("") && !paoreleases.toString().equals("null"))
		{
			String paorel[]=paoreleases.toString().split("@");
			paorelease1=Double.parseDouble(paorel[0].toString())/100000;
			paorelease2=Double.parseDouble(paorel[1].toString())/100000;
		}
		else
		{
			paoreleases.delete(0,paoreleases.length());
			paoreleases.append("0");
			paorelease1=0;
			paorelease2=0;
			
		}
		
		totexpprevmonth=release1+paorelease1;
		totexpyear=release2+paorelease2;
		//System.out.println("release1 pao anupama"+paorelease1);
		//System.out.println("totexpprevmonth"+totexpprevmonth);
		

		
		lastyeatexp.delete(0,lastyeatexp.length());
		lastyeatexp.append(lastfinbank.get(rs.getString(1)));
	     if(lastyeatexp.toString()!=null && !lastyeatexp.toString().equals("") && !lastyeatexp.toString().equals("null"))
	     {
	    	 lastexpbank=Double.parseDouble(lastyeatexp.toString())/100000; 
	     }else
	     {
	    	 lastyeatexp.delete(0,lastyeatexp.length());
	    	 lastyeatexp.append("0");
	    	 
	    	 lastexpbank=0;
	     }
		
		
		
	     
	     
	     
	     lasetyearexppao.delete(0,lasetyearexppao.length());
	     lasetyearexppao.append(lastyearpaoreleases.get(rs.getString(1)));
		     if(lasetyearexppao.toString()!=null && !lasetyearexppao.toString().equals("") && !lasetyearexppao.toString().equals("null"))
		     {
		    	 lastexppao=Double.parseDouble(lasetyearexppao.toString())/100000; 
		     }else
		     {
		    	 lasetyearexppao.delete(0,lasetyearexppao.length());
		    	 lasetyearexppao.append("0");
		    	 
		    	 lastexppao=0;
		     }
			
		
		     
		     totalreleaselastyear=lastexpbank+lastexppao;
	     
		
		     
		     
		///////////////////////////////////
		 fexpenm.delete(0,fexpenm.length());
		 fexpenm.append(newWorksExpSVS.get(rs.getString(1)));

		if(fexpenm.toString()!=null && !fexpenm.toString().equals("") && !fexpenm.toString().equals("null"))
		{
               String val[]=fexpenm.toString().split("@");
               
              /*  value1.delete(0,value1.length());
				value1.append(val[0]);
				
				value2.delete(0,value2.length());
				value2.append(val[1]); */
				
               v1=Double.parseDouble(val[0].toString())/100000; 
				//System.out.println("v1"+v1);
    		   v2=Double.parseDouble(val[1].toString())/100000; 	
				
				
		}
		else
		{
					fexpenm.delete(0,fexpenm.length());
					fexpenm.append("0");
					v1=0;
					v2=0;
		}
		
		  
		
		
		phycomreleases.delete(0,phycomreleases.length());
		phycomreleases.append(monreleasespao123.get(rs.getString(1)));

		if(phycomreleases.toString()!=null && !phycomreleases.toString().equals("") && !phycomreleases.toString().equals("null"))
		{
              String val[]=phycomreleases.toString().split("@");
              
             /*  value1.delete(0,value1.length());
				value1.append(val[0]);
				
				value2.delete(0,value2.length());
				value2.append(val[1]); */
				
              v3=Double.parseDouble(val[0].toString())/100000; 
				//System.out.println("v3"+v3);
   		      v4=Double.parseDouble(val[1].toString())/100000; 	
   		      
   		  // //System.out.println("v4"+v4);
   		//  System.out.println("v3"+v3);
				
				
		}
		else
		{
					fexpenm.delete(0,fexpenm.length());
					fexpenm.append("0");
					v3=0;
					v4=0;
		}
		
		
		
		v5=v1+v3;
		v6=v2+v4;
		
		
		
		
		
		
		
		 
		   aa1+=daa1;
		
		   eexpenm=Double.parseDouble(expenm.toString())/100000; 
		     
		     grdwrksamt.delete(0,grdwrksamt.length());
		     grdwrksamt.append(h12.get(rs.getString(1)));
	        if(grdwrksamt.toString()!=null && !grdwrksamt.toString().equals("") && !grdwrksamt.toString().equals("null"))
	        {
			  String []aa=grdwrksamt.toString().split("@");
			 
			  grdvoamt=(Double.parseDouble(aa[0].toString()))/100000;
			  //System.out.println("grdvoamt"+grdvoamt);
			 
			 // grdsanamt=Double.parseDouble(aa[1].toString());
			  
			  //grdestamt=grdsanamt-grdvoamt;
			}
	        else
	        {
	        	//grdsanamt=0;
	        	grdvoamt=0;
	        	
	        	//grdestamt=0;
	        	
			}	   
		   
	        
	        
	        grdwrksamt1.delete(0,grdwrksamt1.length());
		     grdwrksamt1.append(h16.get(rs.getString(1)));
	        if(grdwrksamt1.toString()!=null && !grdwrksamt1.toString().equals("") && !grdwrksamt1.toString().equals("null"))
	        {
			  String []aa=grdwrksamt1.toString().split("@");
			 
			  grdvoamt1=(Double.parseDouble(aa[0].toString()))/100000;
			  
			 // System.out.println("grdvoamt1"+grdvoamt1);
			 // grdsanamt=Double.parseDouble(aa[1].toString());
			  
			  //grdestamt=grdsanamt-grdvoamt;
			}
	        else
	        {
	        	//grdsanamt=0;
	        	grdvoamt1=0;
	        	
	        	//grdestamt=0;
	        	
			}	   
		   
	        a11=grdvoamt1+grdvoamt;
	       // System.out.println("a11"+a11);
		   
		   
	        
		   
	        grdwrkexpamt.delete(0,grdwrkexpamt.length());
	        grdwrkexpamt.append(h13.get(rs.getString(1)));
	        if(grdwrkexpamt.toString()!=null && !grdwrkexpamt.toString().equals("") && !grdwrkexpamt.toString().equals("null"))
	        {
			  String []aa=grdwrkexpamt.toString().split("@");
			 		  
			  grdsanamt=Double.parseDouble(aa[0].toString());
			  
			  //grdestamt=grdsanamt-grdvoamt;
			}
	        else
	        {
	        	grdsanamt=0;
	        	
	        	
			}
		   
	        grdestamt=grdsanamt - a11;
		   
		  // System.out.println("grdsanamt"+grdsanamt);
		   ////System.out.println("grdvoamt"+grdvoamt);
		   
		    comwrksamt.delete(0,comwrksamt.length());
		    comwrksamt.append(h14.get(rs.getString(1)));
			if(comwrksamt.toString()!=null && !comwrksamt.toString().equals("") && !comwrksamt.toString().equals("null"))
			{
				String []aa=comwrksamt.toString().split("@");		 		  
				comsanamt=Double.parseDouble(aa[1].toString());
							
			}
			else
			{				
				comsanamt=0;
			}			
		 
	        comwrkexpamt.delete(0,comwrkexpamt.length());
	        comwrkexpamt.append(h15.get(rs.getString(1)));
			if(comwrkexpamt.toString()!=null && !comwrkexpamt.toString().equals("") && !comwrkexpamt.toString().equals("null"))
			{
			  
			  String []aa=comwrkexpamt.toString().split("@");
			  comexpamt=(Double.parseDouble(aa[1].toString()))/100000;
				
			}
			else
			{
				comexpamt=0;
			}
			  
		    if(Integer.parseInt(wcdate.toString())>0)
		    {
			comestamt=comsanamt-comexpamt;
		    }
		    else
		    {
		    	comestamt=0;
		    }
			
			////System.out.println("comestamt"+comestamt);
			////System.out.println("comexpamt"+comexpamt);
			
			
			
		 Relexp.delete(0,Relexp.length());
		 Relexp.append(relhash.get(rs.getString(1)));
		 
	        if(Relexp.toString()!=null && !Relexp.toString().equals("") && !Relexp.toString().equals("null"))
	        {
			  String []aa=Relexp.toString().split("@");
			  raa1=Double.parseDouble(aa[0].toString());
			  raa2=Double.parseDouble(aa[1].toString());	
			
			}
	        else
	        {
	        	raa1=0;
	        	raa2=0;
	        	//a1.delete(0, a1.length());a1.append("0");a2.delete(0, a2.length());a2.append("0");
			}	
			  
	        
	        
	        
	        
	        double totreleases=release2+paorelease2+v6;
	        //System.out.println("totreleases"+totreleases);
	        double totbalest=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString())-(totalreleaselastyear);
	        //System.out.println("totbalest"+totbalest);
	        
	        double totexpagbalest=totreleases/totbalest;
	        
	        //System.out.println("totexpagbalest"+totexpagbalest);
	        
	        
	        
		   if(styleCount%2==0)
		   {
				 style.delete(0,style.length());
				 style.append("gridbg1");
			 }else
			 {
				 style.delete(0,style.length());
				 style.append("gridbg2");
			 }
			 styleCount++;
   //System.out.println("...."+ndf.format(aa2));
		%>
	 <tr>
	  	<td class=<%=style.toString() %> style="text-align: left;"><%=cnt++%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><a href="rws_work_gen_rpt_p.jsp?catCode=<%=rs.getString(1)%>&planNonplan=<%=planNonplan%>
		&programes=<%=programe%>&schemes=<%=scheme%>&district=<%=dcode%>"><%=rs.getString(2)%></a></td>
		<td class=<%=style.toString() %> style="text-align: left;"> <a href="#" onclick="viewWorks('rws_work_gen_p_drillreport.jsp?cat=<%=rs.getString(1) %>')" ><%=swork.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><a href="#" onclick="viewWorks('rws_work_gen_p_newspill_drillreport.jsp?cat=<%=rs.getString(1) %>')"><%=nwork.toString()%></a></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString())%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=shabs.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ssamt.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=nsamt.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(lastexpbank)%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(lastexppao)%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(totalreleaselastyear)%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(totalreleaselastyear))%></td>
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(release1)%></td>
      
      <!--  <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(release2)%></td> 
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(paorelease1)%></td>-->
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(paorelease2)%></td>
        <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(release1+paorelease2)%></td>
       <!--
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(totexpprevmonth)%></td>
	
		
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(totexpyear)%></td>

	-->
       
	<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(v5) %></td>

		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(v6) %></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(totreleases)%></td>

		<%if(totbalest<=0)
			{%><td class=<%=style.toString() %> style="text-align: left;">0</td><%}
		else{%><td class=<%=style.toString() %> style="text-align: left;">
          <%=ndf.format(totexpagbalest*100)%></td>
		<%}%>


		<!--<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(aa2+v2)%></td>-->
		
		<td class=<%=style.toString() %> style="text-align: left;"><%=thabs.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=gdate.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(grdestamt) %></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=wcdate.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(comestamt) %></td>
		<!-- <td class=<%=style.toString() %> style="text-align: left;">><%=chabs.toString()%></td> --> 
         <td class=<%=style.toString() %> style="text-align: left;"><%=covhabs.toString()%></td>

		
		<%//if(Integer.parseInt(chabs)==0)
			//{aas=0;%><!-- <td class=<%=style.toString() %> style="text-align: left;">>0</td>--><%//}
		//else{
			//double aas1=Integer.parseInt(shabs)-Integer.parseInt(chabs);
			//aas=(Double.parseDouble(covhabs)/aas1)*100;
		       //////System.out.println("aaain 1::"+aas);
			%><!-- <td class=<%=style.toString() %> style="text-align: left;">><%//ndf.format(aas)%></td>-->
		<%//}%>
		
		</tr>
		
	<%
            gv1+=v5;
             gv2+=v6;
         v1=0;
   v2=0;

        // //System.out.println("gv2:"+gv2);
		stot+=Integer.parseInt(swork.toString());ntot+=Integer.parseInt(nwork.toString());
		alltot+=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString());
		hstot+=Integer.parseInt(shabs.toString());
		sptot+=Double.parseDouble(ssamt.toString());
		nptot+=Double.parseDouble(nsamt.toString());
		totall+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString());
        exprev+=totalreleaselastyear;
		expdur+=aa2;
		totexp+=aa2;
        balecost+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString())-totalreleaselastyear;
        release1bank+=release1;
       // releasebank2+=release2;
       // releasepao+=paorelease1;
        releasepao2+=paorelease2;
		tstot+=Integer.parseInt(thabs.toString());
		gtot+=Integer.parseInt(gdate.toString());
		cwtot+=Integer.parseInt(wcdate.toString());
		chtot+=Integer.parseInt(chabs.toString());
		chctot+=Integer.parseInt(covhabs.toString());
		epenmtot+=eexpenm;
		totreleases1+=totreleases;
		
		lastyearreleases+=lastexpbank;
		lastyearreleasepao+=lastexppao;
		bhabs+=Integer.parseInt(shabs.toString())-Integer.parseInt(covhabs.toString());
	    if(((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-aa1)<=0)
		{
		balpcost+=0;
			}
		else
		{
				balpcost+=(((aa2)/((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(aa1)))*100);
		}
		//////System.out.println("t::1::::::::"+aas);
		htot+=aas;
		//////System.out.println("t::2:::::"+htot);
		
		
		totgrdestatm+=grdestamt;
	    totwcestatm+=comestamt;
		
	}
	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
	if(conn!=null) conn.close();
	%>
		
		<tr class=gridhdbg>
		<td  Colspan=2  align="center"  class=gridhdbg>Total</td>
		<td  class=gridhdbg align="left" ><%=stot%></td>
		<td  class=gridhdbg align="left" ><%=ntot%></td>
		<td   class=gridhdbg align="left" ><%=alltot%></td>
		<td  class=gridhdbg align="left" ><%=hstot%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(sptot)%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(nptot)%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(totall)%></td>
		
		<td  class=gridhdbg align="left"><%=ndf.format(lastyearreleases)%></td>
		<td  class=gridhdbg align="left"><%=ndf.format(lastyearreleasepao)%></td>
		
		<td  class=gridhdbg align="left"><%=ndf.format(exprev)%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(balecost)%></td>
		<td class=gridhdbg align="left" ><%=ndf.format(release1bank)%></td>
		
		<!-- <td class=gridhdbg align="left" ><%=ndf.format(releasebank2)%></td>
        <td class=gridhdbg align="left" ><%=ndf.format(releasepao)%></td> -->
        <td class=gridhdbg align="left" ><%=ndf.format(releasepao2)%></td>
        <td class=gridhdbg align="left" ><%=ndf.format(release1bank+releasepao2)%></td>
        <!--
      
		<td  class=gridhdbg align="left" ><%=ndf.format(epenmtot)%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(expdur)%></td>
		-->
		
		<td  class=gridhdbg align="left" ><%=ndf.format(gv1)%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(gv2)%></td>
		
<td  class=gridhdbg align="left" ><%=ndf.format(totreleases1)%></td>
		<td  class=gridhdbg align="left" >--</td>  <%//ndf.format(balpcost)%>
       
		<!-- <td  class=gridhdbg align="left" ><%=ndf.format(totexp+gv2)%></td> -->
		
		 <td  class=gridhdbg align="left" ><%=tstot%></td>
		<td  class=gridhdbg align="left" ><%=gtot%></td>
		<td  class=gridhdbg align="left" ><%=ndf.format(totgrdestatm) %></td>
		<td  class=gridhdbg align="left" ><%=cwtot%></td>
		<!-- <td  align="right" ><%=chtot%></td> -->
		<td  class=gridhdbg align="left" ><%=ndf.format(totwcestatm) %></td>
        <td  class=gridhdbg align="left" ><%=chctot%></td>
		
		
		<!-- <td  align="right" ><%=ndf.format(htot)%></td>-->
		</tr>
		
		
		<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		StringBuffer qry1=null;
		StringBuffer a1=null;
		StringBuffer a2=null;
		StringBuffer da1=null;
		StringBuffer da2=null;

		StringBuffer nwork=null;
		StringBuffer swork=null;
		StringBuffer shabs=null;
		StringBuffer nsamt=null;
		StringBuffer ssamt=null;
		StringBuffer exp=null;
		StringBuffer directexp=null;
		StringBuffer thabs=null;
		StringBuffer gdate=null;
		StringBuffer wcdate=null;
		StringBuffer chabs=null;
		StringBuffer covhabs=null;
		StringBuffer expenm=null;
		StringBuffer fexpenm=null;
		StringBuffer value1=null;
		StringBuffer value2=null;

	}
		%>
</table>	
</html>