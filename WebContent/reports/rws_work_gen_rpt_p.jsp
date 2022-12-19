<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<% 
		
		double aas=0;
		DecimalFormat ndf = new DecimalFormat("####.00");
		
		StringBuffer catCode=new StringBuffer();
		catCode.delete(0,catCode.length());
		catCode.append(request.getParameter("catCode"));
		System.out.println("catCode:::::::::::::::"+catCode.toString());
		
		StringBuffer planNonplan=new StringBuffer();
		planNonplan.delete(0,planNonplan.length());
		planNonplan.append(request.getParameter("planNonplan"));
		////System.out.println("planNonplan"+planNonplan.toString());
		
		StringBuffer programe=new StringBuffer();
		programe.delete(0,programe.length());
		programe.append(request.getParameter("programes"));
		//System.out.println("programe"+programe.toString());
		
		
		StringBuffer scheme=new StringBuffer();
		scheme.delete(0,scheme.length());
		scheme.append(request.getParameter("schemes"));
		//System.out.println("scheme"+scheme.toString());
		
		
		StringBuffer dcode=new StringBuffer();
		dcode.delete(0,dcode.length());
		dcode.append(request.getParameter("district"));
		//System.out.println("dcode"+dcode.toString());
		
		
		
		
		
		
		
		//String planName = "PLAN & NON PLAN";
		
		StringBuffer planName=new StringBuffer();
		planName.delete(0,planName.length());
		planName.append("PLAN & NON PLAN");
		//String planQry="";
		StringBuffer planQry=new StringBuffer();
		StringBuffer catQry=new StringBuffer();
		StringBuffer catName=new StringBuffer();
		
		if(planNonplan.toString().equals("1"))
		{
			planQry.delete(0, planQry.length());
		    planQry.append("and plan_code = '1'");
		    
		    planName.delete(0, planName.length());
		    planName.append(" PLAN ");
		}
		else if(planNonplan.equals("2"))
		{
		planQry.delete(0, planQry.length());
		planQry.append("and plan_code = '2'");
		
		planName.delete(0, planName.length());
		planName .append(" NON PLAN ");
		}
		
		if(catCode.toString().equals("1"))
		{
		catQry.delete(0, catQry.length());
		catQry.append("and category_code = '1'");
		
		catName.delete(0, catName.length());
		catName .append(" PROJECTS");
		}
		else if(catCode.toString().equals("2"))
		{
			catQry.delete(0, catQry.length());
		    catQry .append("and category_code = '2'");
		
		    catName.delete(0, catName.length());
		    catName.append("NORMAL");
		}
		else if(catCode.toString().equals("3"))
		{
			catQry.delete(0, catQry.length());
		    catQry .append("and category_code = '3'");
		
		   catName.delete(0, catName.length());
		   catName .append("DISTRICT LEVEL");
		} 
		
		
		/* if(catCode.toString()==null && catCode.toString().equals(""))
		{
		catName.delete(0, catName.length());	
		catName.append(request.getParameter("catName"));
		} */
	
		  StringBuffer yr=new StringBuffer();
		  yr.append(session.getAttribute("yr"));
		   
		 
		  StringBuffer dist=new StringBuffer();
            dist.append(request.getParameter("district"));

if(dist.toString()!=null && !dist.toString().equals("") && dist.toString().equals("00"))
{
 
	
	//System.out.println("hai i am in first looppppppppppppppppppppp"+dist.toString()+catCode.toString());
	
	
	
	
	//String prgCode="",prgName="";
	StringBuffer prgCode=new StringBuffer();
	StringBuffer prgName=new StringBuffer();
 
 if(request.getParameter("prgCode")!=null && !request.getParameter("prgCode").equals(""))
{
	 prgCode.append(request.getParameter("prgCode"));
     prgName.append(request.getParameter("prgName"));
}else{}
 
 //String financialyr="";
 StringBuffer financialyr=new StringBuffer();

if(session.getAttribute("financialyr")!=null && !session.getAttribute("financialyr").equals(""))
{ 
	financialyr.append(session.getAttribute("financialyr"));
} 
else { 
	   financialyr.append(request.getParameter("finyear"));
	}

if(financialyr.toString()!=null && !financialyr.toString().equals(""))
	{
	  yr.delete(0,yr.length());
	  yr.append(financialyr.substring(0,4));
	}
	

    StringBuffer nextyr=new StringBuffer();
	nextyr.delete(0,nextyr.length());
	nextyr.append(""+(Integer.parseInt(yr.toString())+1));
	
    StringBuffer subnextyr=new StringBuffer();
    subnextyr.delete(0,subnextyr.length());
    subnextyr.append(nextyr.substring(2,4));
	
   

//uptoprevmonth 
   StringBuffer sysdate=new StringBuffer();
  sysdate.append(workData.getDate());
	
  //String sysmon=sysdate.substring(3,5);
  StringBuffer sysmon=new StringBuffer();
  sysmon.append(sysdate.substring(3,5));
  
  int mon=Integer.parseInt(sysmon.toString());
   ////System.out.println("sysdate::"+sysdate);
   StringBuffer sysyear=new StringBuffer();
   sysyear.append(sysdate.substring(6,10));
   
   int yy=Integer.parseInt(sysyear.toString());
   //////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
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
    StringBuffer mymon=new StringBuffer();
    mymon.append(months[prevmon-1]);
	

    StringBuffer statePrograms=new StringBuffer();
    statePrograms.delete(0, statePrograms.length());
    statePrograms.append("00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67");

////System.out.println("Current Month"+cmonth);
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
StringBuffer nextmonth=new StringBuffer(RwsUtils.getNextMonth().toUpperCase());


StringBuffer distname=new StringBuffer();

if(session.getAttribute("distname")!=null && !session.getAttribute("distname").equals(""))
{ 
	distname.append(session.getAttribute("distname"));
} 
else { 
	distname.append(request.getParameter("distname"));
	}








%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
			</tr>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="gridhdbg" colspan=27>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)</td>	
	</tr>
		<tr align="center" > <td class=gridhdbg colspan=27>District:<%=distname.toString() %> <font color="red" face="verdana" size="2"> <%=planName.toString()%></font> Works of <%=catName.toString() %></td> </td>
		<tr align=center  align=center>
		<td class=gridhdbg rowspan = 2>Sl.No</td>
		<td class=gridhdbg rowspan = 2>District</td>
		<td colspan=3 class=gridhdbg align="center">No.of Works</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
		<td colspan=3 class=gridhdbg align="center">Est.Cost</td>
		<td  colspan=3 class=gridhdbg align="center">Exp. Upto Last Fin. Year</td>
		<td   rowspan=2 class=gridhdbg align="center">Bal Est.Cost as on 1.4.<%=yr.toString()%>(9-12)</td>
		<td  colspan=3 class=gridhdbg align="center">Releases</td>
		<!--<td  colspan=2 class=gridhdbg align="center">Expenditure</td>	
        -->
        <td  colspan=2 class=gridhdbg align="center">Physically Completed But Financially Not Completed Works Expenditure</td>	
		
		 <!-- 	
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Total Exp.(18+20)</td>	
		-->
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Total Exp.(Releases)</td>	
		 <td rowspan=2 colspan=1 class=gridhdbg align="center">% of Exp. against Bal Est.Cost(21/13)</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Technically Sanctioned</td>	
		<td rowspan=2 colspan=1 class=gridhdbg align="center">No.of.Works Grounded</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">No.of.Works Completed</td>
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">No. of Habs Covered upto previous year</td>-->
       <td rowspan=2 colspan=1 class=gridhdbg align="center">Covered during the year</td>
<!--  
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Balance as on 1.4.<%= yr.toString()%>(6-19)</td>
		-->
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">% of coverage against balance Habs(21/20)</td>-->
		</tr>
		<tr>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. Upto Last Fin. Year through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. Upto Last Fin. Year through pao</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Through Bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Through Pao</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		
		
		<!--<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp.upto Previous month</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. During The Year</td>
		-->
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp.upto Previous month</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. During The Year</td>

		</tr>
	<tr><td align="center" class=gridhdbg>1</td><td align="center" class=gridhdbg>2</td><td align="center" class=gridhdbg>3</td><td align="center" class=gridhdbg >4</td><td align="center" class=gridhdbg >5</td><td align="center" class=gridhdbg>6</td><td align="center" class=gridhdbg>7</td><td align="center" class=gridhdbg>8</td><td align="center" class=gridhdbg>9</td><td align="center" class=gridhdbg>10</td><td align="center" class=gridhdbg>11</td><td align="center" class=gridhdbg>12</td><td align="center" class=gridhdbg>13</td><td align="center" class=gridhdbg>14</td><td align="center" class=gridhdbg>15</td><td align="center" class=gridhdbg>16</td><td align="center" class=gridhdbg>17</td><td align="center" class=gridhdbg>18</td><td align="center" class=gridhdbg>19</td><td align="center" class=gridhdbg>20</td><td align="center" class=gridhdbg>21</td>
	<td align="center" class=gridhdbg>22</td>
	<td align="center" class=gridhdbg>23</td>
	<td align="center" class=gridhdbg>24</td>
	<!--<td align="center" class=gridhdbg>25</td>
	<td align="center" class=gridhdbg>26</td>
	 <td align="center" class=gridhdbg>27</td>
	
--><%   int cnt=1;
	  int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0,bhabs=0;
	  double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0,epenmtot=0.0,balpcost=0.0,balecost=0.0,expenm=0.0,htot=0.0,totexpprevmonth=0.0,totexpyear=0.0;
	
	
	StringBuffer qry1=new StringBuffer();
	
	
	
////////////added by anu 11032015/////
	
	
qry1.append("select sum(case when (to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end),substr(b.work_id,5,2)  from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"' and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
if(scheme!=null && !scheme.equals(""))
{
 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
}
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
} 
qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by  substr(b.work_id,5,2)   order by substr(b.work_id,5,2)");

Statement	stmt90=conn.createStatement();

ResultSet rs90=stmt90.executeQuery(qry1.toString());
//System.out.println("expqry.finlast..anupama.:"+qry1.toString());
Hashtable lastfinbank=new Hashtable();
while(rs90.next())
{
//	System.out.println("anupama lasetyear"+rs90.getString(2));
	lastfinbank.put(rs90.getString(2),rs90.getString(1));
}
if(rs90!=null)rs90.close();
if(stmt90!=null)stmt90.close();
qry1.delete(0,qry1.length());




qry1.append("select sum(case when (to_date(STATE_SEND_DATE)<='31-Mar-"+yr.toString()+"')then BILL_AMOUT_STATE else 0 end),substr(b.work_id,5,2) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"' and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null )");
 if(scheme!=null && !scheme.equals(""))
 {
	 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
 }
 if(dcode.toString()!=null && !dcode.toString().equals("00"))
 {
	 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
 } 
qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(b.work_id,5,2) order by substr(b.work_id,5,2)");

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




	
	//////////////////////////////////////////////////////////
	
	   ///////Added by anu for Releases//////


   qry1.append("select substr(b.work_id,5,2),nvl(sum(BILL_AMOUNT_CENTRAL),0) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(bank_send_date)<='31-MAR-"+nextyr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"'  ");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(b.work_id,5,2) order by substr(b.work_id,5,2)");

		Statement stmt25=conn.createStatement();
   //  System.out.println("monthlllyreleases bank"+qry1.toString());
	 ResultSet rs25=stmt25.executeQuery(qry1.toString());
	Hashtable monreleasesbank=new Hashtable();
	while(rs25.next())
	{
		monreleasesbank.put(rs25.getString(1),rs25.getString(2));
	}
	if(rs25!=null)rs25.close();
	if(stmt25!=null)stmt25.close();
	qry1.delete(0,qry1.length());
	
	
	
	
	   qry1.append("select substr(b.work_id,5,2),nvl(sum(BILL_AMOUT_STATE),0) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)<='31-MAR-"+nextyr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"' ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(b.work_id,5,2) order by substr(b.work_id,5,2)");

			Statement stmt26=conn.createStatement();
	   //  System.out.println("monthlllyreleases pao"+qry1.toString());
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
	
	
	
	
	
	
	
	qry1.append("select count(*),substr(w.work_id,5,2) FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p where w.ADMIN_DATE >= '01-Apr-"+yr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+nextyr.toString()+"' and work_cancel_dt is null "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and w.programme_code=p.programme_code group by substr(w.work_id,5,2)  order by 2 ");
	
	
	//System.out.println("nqry:"+qry1.toString());
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(qry1.toString());
	Hashtable h=new Hashtable();
	while(rs1.next())
	{
		h.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	
	
	
	qry1.delete(0, qry1.length());
	qry1.append("SELECT count(*),substr(w.work_id,5,2)  FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p where w.ADMIN_DATE <'01-Apr-"+yr.toString()+"'  and work_cancel_dt is null "+planQry.toString()+"  "+catQry.toString()+"  and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr.toString()+"'))  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and w.programme_code=p.programme_code group by substr(w.work_id,5,2)  order by 2 ");
/*	if(prgCode!=null && !prgCode.equals("")) sqry+= " and programme_code='"+prgCode+"' ";*/ 
	Statement	stmt2=conn.createStatement();
	//System.out.println("sqry::::"+qry1.toString());
	ResultSet rs2=stmt2.executeQuery(qry1.toString());
		Hashtable h1=new Hashtable();
	while(rs2.next())
	{
		h1.put(rs2.getString(2),rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	
	
	qry1.delete(0, qry1.length());
	qry1.append("select count(hab_code),substr(a.work_id,5,2) from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b,rws_programme_tbl p  where a.work_id=b.work_id and work_cancel_dt is null "+planQry.toString()+"  "+catQry.toString()+"  and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and b.programme_code=p.programme_code  group by substr(a.work_id,5,2)  order by 2 ");
	/*if(prgCode!=null && !prgCode.equals("")) hqry+= " and programme_code='"+prgCode+"' ";*/
 
	Statement	stmt3=conn.createStatement();
	//////System.out.println("drill hqry:"+hqry);
   // ////System.out.println("sqry:"+sqry);
	ResultSet rs3=stmt3.executeQuery(qry1.toString());
	Hashtable h2=new Hashtable();
	while(rs3.next())
	{
		h2.put(rs3.getString(2),rs3.getString(1));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
	
	
	qry1.delete(0, qry1.length());
	qry1.append("select sum(sanction_amount),substr(work_id,5,2)  from rws_work_admn_tbl w,rws_programme_tbl p  where  admin_date>='01-Apr-"+yr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+nextyr.toString()+"'  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")    and w.programme_code=p.programme_code  and work_cancel_dt is null  group by substr(work_id,5,2)  order by 2 ");
	Statement	stmt4=conn.createStatement();
	//////System.out.println("nsqry:"+nsqry);
	ResultSet rs4=stmt4.executeQuery(qry1.toString());
	Hashtable h3=new Hashtable();
	while(rs4.next())
	{
		h3.put(rs4.getString(2),rs4.getString(1));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	
	
	qry1.delete(0, qry1.length());
	qry1.append("SELECT sum(sanction_amount),substr(W.work_id,5,2) FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p where w.ADMIN_DATE <'01-Apr-"+yr.toString()+" ' and w.ADMIN_DATE < '01-Apr-"+nextyr.toString()+"' and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr.toString()+"'))  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code group by substr(W.work_id,5,2)  order by 2 ");
	Statement	stmt5=conn.createStatement();
	//////System.out.println("ssqry:"+ssqry);
	ResultSet rs5=stmt5.executeQuery(qry1.toString());
	Hashtable h4=new Hashtable();
	while(rs5.next())
	{
		h4.put(rs5.getString(2),rs5.getString(1));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	
	
	qry1.delete(0, qry1.length());
	qry1.append("select  sum(case when to_date(voucher_dt)< '01-Apr-"+yr.toString()+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2)  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")    and b.programme_code=p.programme_code group by substr(b.work_id,5,2)  order by 2 ");
      Statement	stmt6=conn.createStatement();
    ////System.out.println("last expqry:"+expqry);
	ResultSet rs6=stmt6.executeQuery(qry1.toString());
	Hashtable h5=new Hashtable();
	while(rs6.next())
	{
		h5.put(rs6.getString(2),rs6.getString(1));
	}
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	
	
	//Direct Voucher Table  
	
	qry1.delete(0, qry1.length());
	qry1.append("select  sum(case when to_date(voucher_dt)< '01-Apr-"+yr.toString()+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2)  from rws_work_direct_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")    and b.programme_code=p.programme_code group by substr(b.work_id,5,2)  order by 2 ");
     Statement	stmt634=conn.createStatement();
    ////System.out.println("last expqry:"+expqry);
	ResultSet rs634=stmt634.executeQuery(qry1.toString());
	Hashtable directVoucherhash=new Hashtable();
	while(rs634.next())
	{
		directVoucherhash.put(rs634.getString(2),rs634.getString(1));
	}
    if(rs634!=null)rs634.close();
	if(stmt634!=null)stmt634.close();
	
	
	//End
	qry1.delete(0, qry1.length());
	qry1.append("SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END),substr(W.work_id,5,2) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W,rws_programme_tbl p WHERE W.WORK_ID=E.WORK_ID and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and w.programme_code=p.programme_code and w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') group by substr(W.work_id,5,2)  order by 2 ");
	Statement	stmt7=conn.createStatement();
//////System.out.println("tsqry:"+tsqry);
	ResultSet rs7=stmt7.executeQuery(qry1.toString());
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	
	qry1.delete(0, qry1.length());
	qry1.append("SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),substr(W.work_id,5,2)  FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W,rws_programme_tbl p WHERE W.WORK_ID=G.WORK_ID and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"   and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")    and w.programme_code=p.programme_code and  w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') group by substr(W.work_id,5,2)  order by 2 ");
	Statement	stmt8=conn.createStatement();
	//////System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(qry1.toString());
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	
	qry1.delete(0, qry1.length());
	qry1.append("select sum(case when date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' then 1 else 0 end),substr(w.work_id,5,2) from rws_work_completion_tbl wc, rws_work_admn_tbl w,rws_programme_tbl p where w.work_id=wc.work_id  and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and w.programme_code=p.programme_code group by substr(w.work_id,5,2)  order by 2 ");
 	Statement	stmt9=conn.createStatement();
	//////System.out.println("wcqry:"+wcqry);
	ResultSet rs9=stmt9.executeQuery(qry1.toString());
	Hashtable h8=new Hashtable();
	while(rs9.next())
	{
		h8.put(rs9.getString(2),rs9.getString(1));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	
	
	qry1.delete(0, qry1.length());
	//String chqry="Select count(hab_code),substr(b.work_id,5,2)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  "+planQry+"  "+catQry+"   and type_of_asset in("+scheme+")    and  a.work_id not in (select work_id from  rws_work_completion_tbl where date_of_completion<'01-Apr-"+yr+"' )  group by substr(b.work_id,5,2)  order by 2 ";
	qry1.append("select count(distinct hab_code),substr(a.work_id,5,2) from RWS_WORK_COMP_HAB_LNK_TBL a,rws_work_admn_tbl b,rws_programme_tbl p  where a.work_id=b.work_id and work_cancel_dt is null "+planQry.toString()+"  "+catQry.toString()+"  and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and b.programme_code=p.programme_code  group by substr(a.work_id,5,2)  order by 2 ");
    Statement	stmt10=conn.createStatement();
	//////System.out.println("chabqry:"+chqry);
	ResultSet rs10=stmt10.executeQuery(qry1.toString());
	Hashtable h9=new Hashtable();
	while(rs10.next())
	{
		h9.put(rs10.getString(2),rs10.getString(1));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();
		
	qry1.delete(0, qry1.length());
	qry1.append("Select count(hab_code),substr(b.work_id,5,2)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b,rws_programme_tbl p where a.work_id =b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and    a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr.toString()+"'  and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' )   and b.programme_code=p.programme_code  group by substr(b.work_id,5,2)  order by 2 ");
    Statement	stmt11=conn.createStatement();
	//////System.out.println("covqry:"+covqry);
	ResultSet rs11=stmt11.executeQuery(qry1.toString());
	Hashtable h10=new Hashtable();
	while(rs11.next())
	{
		h10.put(rs11.getString(2),rs11.getString(1));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
	
	
	qry1.delete(0, qry1.length());
	qry1.append("select  sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-"+mymon.toString()+"-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2)  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') and b.programme_code=p.programme_code group by substr(b.work_id,5,2)  order by 2 ");
    
    Statement	stmt12=conn.createStatement();
	//System.out.println("expmonqry11111111111111111:"+qry1.toString());
	ResultSet rs12=stmt12.executeQuery(qry1.toString());
	Hashtable h11=new Hashtable();
	while(rs12.next())
	{
		h11.put(rs12.getString(2),rs12.getString(1));
	}
	if(rs12!=null)rs12.close();
	if(stmt12!=null)stmt12.close();
	
	
	/* Direct Expenditure  */
	
	qry1.delete(0, qry1.length());
    qry1.append("select  sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-"+mymon.toString()+"-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2)  from rws_work_direct_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') and b.programme_code=p.programme_code group by substr(b.work_id,5,2)  order by 2 ");
    
    Statement	stmt1234=conn.createStatement();
	//System.out.println("directexpmonqry:"+qry1.toString());
	ResultSet rs1234=stmt1234.executeQuery(qry1.toString());
	Hashtable directExpMonhtHash=new Hashtable();
	while(rs1234.next())
	{
		directExpMonhtHash.put(rs1234.getString(2),rs1234.getString(1));
	}
	if(rs1234!=null)rs1234.close();
	if(stmt1234!=null)stmt1234.close();

/*	qry1.delete(0, qry1.length());
	qry1.append("select substr(a.work_id,5,2),sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>='01-APR-"+yr.toString()+"' and to_date(voucher_dt)< '01-APR-"+nextyr.toString()+"') then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id in (select b.work_id from  "+relTable.toString()+" b  where to_date("+relColumn.toString()+")>= '01-APR-"+yr.toString()+"' and "+txid.toString()+" is not null) and a.work_id=b.work_id  ");
 if(scheme!=null && !scheme.equals("")){
	 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
}
 qry1.append(" "+planQry.toString()+"  "+catQry.toString()+" and  a.programme_code in ("+programe.toString()+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr.toString()+"') and DATE_OF_COMPLETION is  not null ) group by  substr(a.work_id,5,2)   order by 1");

		Statement stmt13=conn.createStatement();
//System.out.println("newWorksExpenSVS"+qry1.toString());
	 ResultSet rs13=stmt13.executeQuery(qry1.toString());
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs13.next())
	{
		newWorksExpSVS.put(rs13.getString(1),rs13.getString(2));
	}
	if(rs13!=null)rs13.close();
	if(stmt13!=null)stmt13.close();*/

//////////////Physically Completed But Financially Not Completed Works Expenditure///
		qry1.delete(0, qry1.length());
	 qry1.append("select substr(b.work_id,5,2) ,sum(case when (to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"'  and  a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") ) group by substr(b.work_id,5,2)   order by 1");

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
	
	
	
	
	  qry1.append("select substr(b.work_id,5,2),sum(case when (to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUT_STATE else 0 end) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"' and    a.work_id in (select work_id from rws_work_completion_tbl where  DATE_OF_COMPLETION is not null ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")) group by  substr(b.work_id,5,2) order by 1");

			Statement stmt93=conn.createStatement();
	    // System.out.println("monthlllyreleases pao123"+qry1.toString());
		 ResultSet rs93=stmt93.executeQuery(qry1.toString());
		Hashtable monreleasespao123=new Hashtable();
		while(rs93.next())
		{
			monreleasespao123.put(rs93.getString(1),rs93.getString(2));
		}
		if(rs93!=null)rs93.close();
		if(stmt93!=null)stmt93.close();

		qry1.delete(0,qry1.length());
	
	
	
	
//////////////////////////
double gv1=0,gv2=0;
qry1.delete(0, qry1.length());
qry1.append("select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode");
	stmt=conn.createStatement();
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
	//StringBuffer expenm=new StringBuffer();
	StringBuffer fexpenm=new StringBuffer();
	
	StringBuffer value1=new StringBuffer();
	StringBuffer value2=new StringBuffer();

	StringBuffer expmon=new StringBuffer();
	StringBuffer dexpmon=new StringBuffer();
	StringBuffer lastyeatexp=new StringBuffer();
	StringBuffer lasetyearexppao=new StringBuffer();
	StringBuffer bankreleases=new StringBuffer();
	StringBuffer paoreleases=new StringBuffer();
	StringBuffer phycomreleases=new StringBuffer();
	

	int styleCount=0;
	StringBuffer style=new StringBuffer();
	double release1bank=0,releasebank2=0,releasepao=0,releasepao2=0,lastyearreleases=0,lastyearreleasepao=0,totreleases1=0;

	while(rs.next())
	{
		double aa1=0,daa1=0;
		double eexpmon=0,deexpmon=0, aa2=0,daa2=0,v1=0,v2=0,v3=0,v4=0,v5=0,v6=0,aas1=0,lastexpbank=0,lastexppao=0,totalreleaselastyear=0,release1=0,release2=0,paorelease1=0,paorelease2=0;

		
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
		
		/*  a1.delete(0,a1.length());	
		 a1.append(aa[0]);
		 
		 a2.delete(0,a2.length());
		 a2.append(aa[1]); */
		 
		 aa1=Double.parseDouble(aa[0].toString())/100000;
		 aa2=Double.parseDouble(aa[1].toString())/100000;
		
		}
       else
       {
    	   /* a1.delete(0,a1.length());
    	   a1.append("0");
    	   a2.delete(0,a2.length());
    	   a2.append("0"); */
    	   
    	   
    	   
       	//a1.delete(0, a1.length());a1.append("0");a2.delete(0, a2.length());a2.append("0");
		}
        
           
         
        
        directexp.delete(0,directexp.length());
        directexp.append(directVoucherhash.get(rs.getString(1)));
        
       if(directexp.toString()!=null && !directexp.toString().equals("") && !directexp.toString().equals("null"))
       {
		String []aa=directexp.toString().split("@");
		
		/* da1.delete(0,da1.length());
		da1.append(aa[0]);
		
		da2.delete(0,da2.length());
		da2.append(aa[1]);
		 */
		daa1=Double.parseDouble(aa[0].toString())/100000;
		daa2=Double.parseDouble(aa[1].toString())/100000;
		}
       else
       {   /* da1.delete(0,da1.length());
    	   da1.append("0");
    	   da2.delete(0,da2.length());
    	   da2.append("0"); */
    	   daa1=0;
    	   daa2=0;
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
	
		
		expmon.delete(0,expmon.length());
		expmon.append(h11.get(rs.getString(1)));
		if(expmon.toString()!=null && !expmon.toString().equals("") && !expmon.toString().equals("null"))
		{
			eexpmon=Double.parseDouble(expmon.toString())/100000;
			
		}else
		{
			expmon.delete(0, expmon.length());expmon.append("0");
			eexpmon=0;
		}
		

		
		
		
		dexpmon.delete(0,dexpmon.length());
		dexpmon.append(directExpMonhtHash.get(rs.getString(1)));
		if(dexpmon.toString()!=null && !dexpmon.toString().equals("") && !dexpmon.toString().equals("null"))
		{
			deexpmon=Double.parseDouble(dexpmon.toString())/100000;
		
		}else{
			dexpmon.delete(0, dexpmon.length());dexpmon.append("0");
		    deexpmon=0;
		}
	
		
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
			//	System.out.println("v1"+v1);
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
  		      
  		  // System.out.println("v4"+v4);
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
		
		
		///////////////Added by anu 11032015
		
		
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
	     
		
		 	////////////added by anu
				
				bankreleases.delete(0,bankreleases.length());
				bankreleases.append(monreleasesbank.get(rs.getString(1)));
				if(bankreleases.toString()!=null && !bankreleases.toString().equals("") && !bankreleases.toString().equals("null"))
				{
					String bankrel[]=bankreleases.toString().split("@");
					release1=Double.parseDouble(bankrel[0].toString())/100000;
					//release2=Double.parseDouble(bankrel[1].toString())/100000;
				}
				else
				{
					bankreleases.delete(0,bankreleases.length());
					bankreleases.append("0");
					release1=0;
					//release2=0;
					
				}
				
				paoreleases.delete(0,paoreleases.length());
				paoreleases.append(monreleasespao.get(rs.getString(1)));
				if(paoreleases.toString()!=null && !paoreleases.toString().equals("") && !paoreleases.toString().equals("null"))
				{
					String paorel[]=paoreleases.toString().split("@");
					paorelease1=Double.parseDouble(paorel[0].toString())/100000;
					//paorelease2=Double.parseDouble(paorel[1].toString())/100000;
				}
				else
				{
					paoreleases.delete(0,paoreleases.length());
					paoreleases.append("0");
					paorelease1=0;
					//paorelease2=0;
					
				}

				totexpprevmonth=release1+paorelease1;
				totexpyear=release2+paorelease2;
		
		double totreleases=paorelease2+release2+v6;
		
		double balest=(Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString())-(totalreleaselastyear));
		//System.out.println("balest"+balest);
		
		double totexp1=totreleases/balest;
		
		
		//System.out.println("aa2"+aa2);
		//System.out.println("anuuu"+ndf.format((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(totalreleaselastyear)));
		
		/////////////////////////lllllllllllllllllllllllll
		aa1+=daa1;
		aa2+=daa2;
		eexpmon+=deexpmon;
		
		
		
		if(styleCount%2==0){
			 style.delete(0,style.length());
			 style.append("gridbg1");
		}else{
			 style.delete(0,style.length());
			 style.append("gridbg2");
		}
		styleCount++;
		%>
    <tr>
		<td class=<%=style.toString() %> style="text-align: center;"><%=cnt++%></td>
		<!--<td class=<%=style.toString() %> style="text-align: left;;" title=Click nowrap><%=rs.getString(2)%></td>
		--> 
		<td class=<%=style.toString() %> style="text-align: left;;" title=Click nowrap><%=rs.getString(2)%><BR><a href="rws_work_gen_rpt_p.jsp?district=<%=rs.getString(1)%>&distname=<%=rs.getString(2)%>&planNonplan=<%=planNonplan%>&catCode=<%=catCode%>&finyear=<%=financialyr%>&dname=<%=rs.getString(2)%>&prgCode=<%=prgCode%>&prgName=<%=prgName%>&catName=<%=catName%>&programes=<%=programe%>&schemes=<%=scheme%>">Division</a> 
		<!-- |<a href="rws_work_gen_man_rpt_p.jsp?district=<%=rs.getString(1)%>&planNonplan=<%=planNonplan%>&catCode=<%=catCode%>&finyear=<%=financialyr%>&dname=<%=rs.getString(2)%>
		&programes=<%=programe%>&prgCode=<%=prgCode%>&prgName=<%=prgName%>&catName=<%=catName%>&programes=<%=programe%>&schemes=<%=scheme%>">Mandal</a>--></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=swork.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=nwork.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString())%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=shabs.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ssamt.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=nsamt.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(lastexpbank)%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(lastexppao)%></td>
	    <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totalreleaselastyear)%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(totalreleaselastyear))%></td>
		
		 <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(release1)%></td>
		 <!--
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(release2)%></td>
       -->
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(paorelease1)%></td>
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(paorelease1+release1)%></td>
       <!--
       <td class=<%=style.toString() %> style="text-align: left;"><%=ndf.format(paorelease2)%></td>
		
    	--><!--<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totexpprevmonth)%></td>
    	<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totexpyear)%></td>
	    -->
	    <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(v5) %></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(v6) %></td>
		
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totreleases)%></td>
		 <%if(balest<=0)
			{%>
			<td class=<%=style.toString() %> style="text-align: center;" align="right">0</td>
			<%}
		else{%><td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totexp1*100)%></td>
		   <%}%> 
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=thabs.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=gdate.toString()%></td>
		<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=wcdate.toString()%></td>
		<!-- <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=chabs.toString()%></td>-->
   <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=covhabs.toString()%></td>
<!--  <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=Integer.parseInt(shabs.toString())-Integer.parseInt(covhabs.toString())%></td>
		-->	
 <%if(Integer.parseInt(chabs.toString())==0)
			{aas=0;%><!-- <td class=<%=style.toString() %> style="text-align: center;" align="right">0</td>--><%}else{
			 aas1=Integer.parseInt(shabs.toString())-Integer.parseInt(chabs.toString());
			if(aas1==0)
			{
				aas=0;
			}else
			{
			aas=(Double.parseDouble(covhabs.toString())/aas1)*100;
		       //////System.out.println("aaa in projects:::::::::"+aas);
			}
			%><!-- <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(aas)%></td>-->
		<%}%>  
		</tr>
     <%
 gv1+=v5;
             gv2+=v6;
         v1=0;
   v2=0;
		stot+=Integer.parseInt(swork.toString());ntot+=Integer.parseInt(nwork.toString());
		alltot+=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString());
		hstot+=Integer.parseInt(shabs.toString());
		sptot+=Double.parseDouble(ssamt.toString());
		nptot+=Double.parseDouble(nsamt.toString());
		totall+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString());
		exprev+=totalreleaselastyear;
		expdur+=aa2;
		totexp+=aa2;
		balecost+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString())-(totalreleaselastyear);
		tstot+=Integer.parseInt(thabs.toString());
		gtot+=Integer.parseInt(gdate.toString());
		cwtot+=Integer.parseInt(wcdate.toString());
		chtot+=Integer.parseInt(chabs.toString());
		chctot+=Integer.parseInt(covhabs.toString());
		epenmtot+=eexpmon;
		totreleases1+=totreleases;
		  release1bank+=release1;
	        releasebank2+=release2;
	        releasepao+=paorelease1;
	        releasepao2+=paorelease2;
	        
	        lastyearreleases+=lastexpbank;
			lastyearreleasepao+=lastexppao;
	/*	if(((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1))<=0)
		{
		   balpcost+=0;
		}
		else   
		{
		  // balpcost+=((Double.parseDouble(a2)/((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1)))*100);

		}*/
		bhabs+=Integer.parseInt(shabs.toString())-Integer.parseInt(covhabs.toString());
		//htot+=aas;
		//////System.out.println("projects:aaaaaaaaaa:"+htot);
	}
	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
	if(conn!=null) conn.close();
	%>
		
	 <tr class=gridhdbg>
	  	<td  Colspan=2  align="center"  class=gridhdbg>Total</td>
		<td  align="right" ><%=stot%></td>
		<td  align="right" ><%=ntot%></td>
		<td  align="right" ><%=alltot%></td>
		<td  align="right" ><%=hstot%></td>
		<td  align="right" ><%=ndf.format(sptot)%></td>
		<td  align="right" ><%=ndf.format(nptot)%></td>
		<td  align="right" ><%=ndf.format(totall)%></td>
		
		<td  align="right" ><%=ndf.format(lastyearreleases)%></td>
		<td  align="right" ><%=ndf.format(lastyearreleasepao)%></td>
		<td  align="right" ><%=ndf.format(exprev)%></td>
		<td  align="right" ><%=ndf.format(balecost)%></td>
		<td  align="right" ><%=ndf.format(release1bank)%></td>
		<!--<td  align="right" ><%=ndf.format(releasebank2)%></td>
		--><td  align="right" ><%=ndf.format(releasepao)%></td>
		<td  align="right" ><%=ndf.format(release1bank+releasepao)%></td>
		<!--<td  align="right" ><%=ndf.format(epenmtot)%></td>
		<td  align="right" ><%=ndf.format(expdur)%></td>
--><td  align="right" ><%=ndf.format(gv1)%></td>
<td  align="right" ><%=ndf.format(gv2)%></td>
 
	<td  align="right" ><%=ndf.format(totreleases1)%></td>
	 <% if(expdur > balecost){ %>
		<td  align="right" ><%=ndf.format((expdur/balecost)*100)%></td> 
<%}else {%>
	<td  align="right" >0</td> 
<%} %>		
	
		<td  align="right" ><%=tstot%></td>
		<td  align="right" ><%=gtot%></td>
		<td  align="right" ><%=cwtot%></td>
		<!-- <td  align="right" ><%=chtot%></td>-->
<td  align="right" ><%=chctot%></td>
<!--		
<td  align="right" ><%=bhabs%></td>
	-->	
		<%//////System.out.println("chctot11111111"+chctot);
		//////System.out.println("bhabs111111111"+bhabs);
		if(chctot==0 || bhabs==0){%>
		<!-- <td  align="right" >0</td>-->
		<%}else{%>
 <!--   	<td  align="right" ><%=ndf.format((Double.parseDouble(""+chctot)/Double.parseDouble(""+bhabs))*100)%></td>-->
		<%}%>
		</tr>
</table>
<%}

else
{
	
	     //System.out.println("hai i am in second looooooooooooop");

		//String financialyr=request.getParameter("finyear");
		
		StringBuffer financialyr=new StringBuffer();

		if(session.getAttribute("financialyr")!=null && !session.getAttribute("financialyr").equals(""))
		{ 
			financialyr.delete(0,financialyr.length());
			financialyr.append(session.getAttribute("financialyr"));
		} 
		else
		{      financialyr.delete(0,financialyr.length());
			   financialyr.append(request.getParameter("finyear"));
		}
		
		if(financialyr.toString()!=null && !financialyr.toString().equals(""))
		{
			
			yr.delete(0,yr.length());
			yr.append(financialyr.toString().substring(0,4));
		}
		
	
		
	  // String prgCode=request.getParameter("prgCode");
	   StringBuffer prgCode=new StringBuffer();
	   prgCode.delete(0,prgCode.length());
	   prgCode.append(request.getParameter("prgCode"));
	 
   /*  String nextyr=""+(Integer.parseInt(yr.toString())+1);
    String subnextyr=nextyr.substring(2,4);
   */  ////System.out.println("subnextyr:"+subnextyr);
    
    
     StringBuffer nextyr=new StringBuffer();
	nextyr.delete(0,nextyr.length());
	nextyr.append(""+(Integer.parseInt(yr.toString())+1));
	
    StringBuffer subnextyr=new StringBuffer();
    subnextyr.delete(0,subnextyr.length());
    subnextyr.append(nextyr.substring(2,4));
    
	
       //String dname=request.getParameter("distname");
       StringBuffer dname=new StringBuffer();
       dname.delete(0,dname.length());
       dname.append(request.getParameter("distname"));
       
	    if(request.getParameter("catName")!=null && !request.getParameter("catName").equals(""))
	    {
	    	catName.delete(0,catName.length());
		    catName.append(request.getParameter("catName"));
	    }
		else
		{
			catName.delete(0,catName.length());
		    catName.append("-");
		}

  // String sysdate=workData.getDate();
  // String sysmon=sysdate.substring(3,5);
   
   StringBuffer sysdate=new StringBuffer();
   sysdate.delete(0,sysdate.length());
   sysdate.append(workData.getDate());
 	
   //String sysmon=sysdate.substring(3,5);
   StringBuffer sysmon=new StringBuffer();
   sysmon.delete(0,sysmon.length());
   sysmon.append(sysdate.substring(3,5));
 
   
   int mon=Integer.parseInt(sysmon.toString());
   ////System.out.println("sysdate::"+sysdate);
   
   
  // String sysyear=sysdate.substring(6,10);
   StringBuffer sysyear=new StringBuffer();
   sysyear.delete(0,sysyear.length());
   sysyear.append(sysdate.substring(6,10));
   
 
   int yy=Integer.parseInt(sysyear.toString());
   //////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;
   
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
 
 /*    String mymon=months[prevmon-1];
  

String statePrograms="00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67";

 */
 
StringBuffer mymon=new StringBuffer();
 mymon.delete(0,mymon.length());
mymon.append(months[prevmon-1]);


StringBuffer statePrograms=new StringBuffer();
statePrograms.delete(0, statePrograms.length());
statePrograms.append("00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67");





////System.out.println("Current Month"+cmonth);
/* String relTable="",amount="";
String relColumn="";String txid="";

 */

StringBuffer relTable=new StringBuffer();
StringBuffer amount=new StringBuffer();
StringBuffer relColumn=new StringBuffer();
StringBuffer txid=new StringBuffer();


if(statePrograms.toString().contains(programe))
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



StringBuffer distname=new StringBuffer();

if(session.getAttribute("distname")!=null && !session.getAttribute("distname").equals(""))
{ 
	distname.append(session.getAttribute("distname"));
} 
else { 
	distname.append(request.getParameter("distname"));
	}



catCode.delete(0,catCode.length());
catCode.append(request.getParameter("catCode"));
System.out.println("catCode:::::::::::::::"+catCode.toString());



//String nextmonth=RwsUtils.getNextMonth().toUpperCase();

StringBuffer nextmonth=new StringBuffer(RwsUtils.getNextMonth().toUpperCase());

		 %>
		<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
		<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
			</tr>
		</table>
		</caption>
		<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
		</table>

			<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
			<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="gridhdbg" colspan=25>General Abstract Report for the Financial   Year(<%=session.getAttribute("financialyr")%>)</td>	
			</tr>
			<tr align="center" > <td class=gridhdbg colspan=25>District &nbsp;&nbsp;&nbsp;<%=distname.toString()%>&nbsp;&nbsp;<font color="red" face="verdana" size="2"> <%=planName.toString()%></font> Works</td> </td>
		<tr align=center  align=center>
		<td class=gridhdbg rowspan = 2>Sl.No</td>
		<td class=gridhdbg rowspan = 2>District</td>
		<td colspan=3 class=gridhdbg align="center">No.of Works</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Habs Sanctioned</td>
		<td colspan=3 class=gridhdbg align="center">Est.Cost</td>
		<td colspan=3 class=gridhdbg align="center">Exp. Upto Last Fin. Year</td>
		<td   rowspan=2 class=gridhdbg align="center">Bal Est.Cost as on 1.4.<%=yr.toString() %>(9-10)</td>
			<td  colspan=3 class=gridhdbg align="center">Releases</td>
		<!--<td  colspan=2 class=gridhdbg align="center">Expenditure</td>	
--><td  colspan=2 class=gridhdbg align="center">Physically Completed But Financially Not Completed Works Expenditure</td>	
<td rowspan=2 colspan=1 class=gridhdbg align="center">Total Releases.<br>(15+17+19)</td>	
		<td rowspan=2 colspan=1 class=gridhdbg align="center">% of Exp. against Bal Est.Cost(20/13)</td>	
		
		<td rowspan=2 colspan=1 class=gridhdbg align="center">Technically Sanctioned</td>	
		<td rowspan=2 colspan=1 class=gridhdbg align="center">No.of.Works Grounded</td>
		<td rowspan=2 colspan=1 class=gridhdbg align="center">No.of.Works Completed</td>
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">No. of Habs Covered upto previous year</td>-->
        <td rowspan=2 colspan=1 class=gridhdbg align="center">Covered during the year</td>
		
<!--  
<td rowspan=2 colspan=1 class=gridhdbg align="center">Balance as on 1.4.<%=yr.toString()%>(6-19)</td>
	-->	
		<!-- <td rowspan=2 colspan=1 class=gridhdbg align="center">% of coverage against balance Habs(21/20)</td>-->
		</tr>
		<tr>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>	
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Spill</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">New</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. Upto Last Fin. Year through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. Upto Last Fin. Year through pao</td>		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Through bank</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Total</td>
		
		

		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp.upto Previous month</td>
		<td rowspan=1 colspan=1 class=gridhdbg align="center">Exp. During The Year</td>

		</tr>
		<tr><td align="center" class=gridhdbg>1</td><td align="center" class=gridhdbg>2</td><td align="center" class=gridhdbg>3</td><td align="center" class=gridhdbg >4</td><td align="center" class=gridhdbg >5</td><td align="center" class=gridhdbg>6</td><td align="center" class=gridhdbg>7</td><td align="center" class=gridhdbg>8</td><td align="center" class=gridhdbg>9</td><td align="center" class=gridhdbg>10</td><td align="center" class=gridhdbg>11</td><td align="center" class=gridhdbg>12</td><td align="center" class=gridhdbg>13</td><td align="center" class=gridhdbg>14</td><td align="center" class=gridhdbg>15</td><td align="center" class=gridhdbg>16</td><td align="center" class=gridhdbg>17</td><td align="center" class=gridhdbg>18</td><td align="center" class=gridhdbg>19</td><td align="center" class=gridhdbg>20</td><td align="center" class=gridhdbg>21</td>
		<td align="center" class=gridhdbg>22</td>
		<td align="center" class=gridhdbg>23</td>
		<td align="center" class=gridhdbg>24</td>
		<!--<td align="center" class=gridhdbg>25</td>
		<td align="center" class=gridhdbg>26</td>
		<td align="center" class=gridhdbg>27</td>
		
			--><%
			int cnt=1;
			int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0,bhabs=0,totreleases1=0;
			double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0,balecost=0.0,epenmtot=0.0,balpcost=0.0,htot=0.0,v1=0,v2=0,v3=0,v4=0,v5=0,v6=0;
			double lastexpbank=0,lastexppao=0,totalreleaselastyear=0,release1=0,release2=0,paorelease1=0,paorelease2=0,release1bank=0,releasebank2=0,releasepao=0,releasepao2=0,lastyearreleases=0,lastyearreleasepao=0;
			
			StringBuffer qry1=new StringBuffer();
			
			
			
////////////added by anu 11032015/////
			
			
qry1.append("select sum(case when (to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end),substr(a.OFFICE_CODE,4,1)  from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where substr(a.OFFICE_CODE,2,2)=substr(b.work_id,5,2) and to_date(BANK_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+" and CATEGORY_CODE='"+catCode.toString()+"' and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
if(scheme!=null && !scheme.equals(""))
{
 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
}
if(dcode.toString()!=null && !dcode.toString().equals("00"))
{
 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
} 
qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(a.OFFICE_CODE,4,1) order by substr(a.OFFICE_CODE,4,1)");

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




qry1.append("select sum(case when (to_date(STATE_SEND_DATE)<='31-Mar-"+yr.toString()+"')then BILL_AMOUT_STATE else 0 end),substr(a.OFFICE_CODE,4,1) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)<= '31-Mar-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"' and  substr(b.work_id,5,2)='"+dist.toString()+"' and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null ) ");
 if(scheme!=null && !scheme.equals(""))
 {
	 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
 }
 if(dcode.toString()!=null && !dcode.toString().equals("00"))
 {
	 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
 } 
qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(a.OFFICE_CODE,4,1) order by substr(a.OFFICE_CODE,4,1)");

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




	
	//////////////////////////////////////////////////////////
	
	   ///////Added by anu for Releases//////


   qry1.append("select substr(a.OFFICE_CODE,4,1),nvl(sum(BILL_AMOUNT_CENTRAL),0) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(bank_send_date)<='31-MAR-"+nextyr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+" and CATEGORY_CODE='"+catCode.toString()+"'  ");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")  group by substr(a.OFFICE_CODE,4,1) order by substr(a.OFFICE_CODE,4,1)");

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
	
	
	
	
	   qry1.append("select substr(a.OFFICE_CODE,4,1),nvl(sum(BILL_AMOUT_STATE),0) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and  to_date(STATE_SEND_DATE)>= '01-MAR-"+nextyr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and CATEGORY_CODE='"+catCode.toString()+"'  ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append("and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") group by substr(a.OFFICE_CODE,4,1) order by substr(a.OFFICE_CODE,4,1)");

			Statement stmt26=conn.createStatement();
	    // System.out.println("monthlllyreleases pao"+qry1.toString());
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
	
		
			
			
			
			
			qry1.append("select count(*),substr(w.work_id,5,2),substr(office_code,4,1) FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p,rws_division_office_tbl d  where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  w.ADMIN_DATE >= '01-Apr-"+yr.toString()+"' and work_cancel_dt is null   "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code and  substr(w.work_id,5,2) ='"+dist.toString()+"'   group by substr(w.work_id,5,2) ,substr(office_code,4,1) order by 2");
		
			//System.out.println("nqry-genrpt2:"+qry1.toString());
			Statement	stmt1=conn.createStatement();
			ResultSet rs1=stmt1.executeQuery(qry1.toString());
			Hashtable h=new Hashtable();
			while(rs1.next())
			{
			
				h.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
			}
			if(rs1!=null)rs1.close();
			if(stmt1!=null)stmt1.close();
			
					
			///////////////llllllllllllll
			qry1.delete(0, qry1.length());
			qry1.append("select count(*),substr(w.work_id,5,2),substr(office_code,4,1) FROM RWS_WORK_ADMN_TBL W,rws_programme_tbl p,rws_division_office_tbl d  where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  w.ADMIN_DATE < '01-Apr-"+yr.toString()+"' and work_cancel_dt is null   "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+")  and type_of_asset in("+scheme.toString()+") and w.programme_code=p.programme_code and  substr(w.work_id,5,2) ='"+dist.toString()+"' and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr.toString()+"')) group by substr(w.work_id,5,2) ,substr(office_code,4,1) order by 2");
			Statement	stmt2=conn.createStatement();
			//System.out.println("sqry-genrpt2:"+qry1.toString());
			ResultSet rs2=stmt2.executeQuery(qry1.toString());
			Hashtable h1=new Hashtable();
			while(rs2.next())
			{
				h1.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
			}
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
			//String hqry="select count(distinct hab_code),substr(a.work_id,5,2),substr(office_code,4,1) from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b  ,rws_programme_tbl p ,rws_division_office_tbl d where substr(a.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  a.work_id=b.work_id and work_cancel_dt is null "+planQry+"  "+catQry+" and p.programme_code in("+programe+") and type_of_asset in("+scheme+")  and b.programme_code=p.programme_code and  substr(a.work_id,5,2) ='"+dist+"' and  a.work_id not  in(select work_id from rws_work_completion_tbl ,rws_division_office_tbl d where substr(a.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  date_of_completion <'01-Apr-"+yr+"')  group by substr(a.work_id,5,2),substr(office_code,4,1) ";
			
			qry1.delete(0, qry1.length());
			qry1.append("select count(hab_code),substr(a.work_id,5,2),substr(office_code,4,1) from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b  ,rws_programme_tbl p ,rws_division_office_tbl d where substr(a.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  a.work_id=b.work_id and work_cancel_dt is null "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and b.programme_code=p.programme_code and  substr(a.work_id,5,2) ='"+dist.toString()+"' and  a.work_id not  in(select work_id from rws_work_completion_tbl where (date_of_completion <'01-Apr-"+yr.toString()+"'))  group by substr(a.work_id,5,2),substr(office_code,4,1) order by 2 ");

            Statement	stmt3=conn.createStatement();
			//System.out.println("hqry-genrpt2:"+qry1.toString());
			ResultSet rs3=stmt3.executeQuery(qry1.toString());
			Hashtable h2=new Hashtable();
			while(rs3.next())
			{
			h2.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
			}
			if(rs3!=null)rs3.close();
			if(stmt3!=null)stmt3.close();
			
			
			qry1.delete(0, qry1.length());
			qry1.append("select sum(sanction_amount),substr(work_id,5,2),substr(office_code,4,1)  from rws_work_admn_tbl w,rws_programme_tbl p ,rws_division_office_tbl d where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and   admin_date>='01-Apr-"+yr.toString()+"'  "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and w.programme_code=p.programme_code and  substr(w.work_id,5,2) ='"+dist.toString()+"' and work_cancel_dt is null   group by substr(w.work_id,5,2),substr(office_code,4,1) order by 2  ");
			Statement	stmt4=conn.createStatement();
			//System.out.println("nsqry-genrpt2:"+qry1.toString());
			ResultSet rs4=stmt4.executeQuery(qry1.toString());
			Hashtable h3=new Hashtable();
			while(rs4.next())
			{
				h3.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
			}
			if(rs4!=null)rs4.close();
			if(stmt4!=null)stmt4.close();
			
			
			qry1.delete(0, qry1.length());
			qry1.append("SELECT sum(sanction_amount),substr(W.work_id,5,2),substr(office_code,4,1) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl d,rws_programme_tbl p where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  w.ADMIN_DATE <'01-Apr-"+yr.toString()+" ' and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+")  and type_of_asset in("+scheme.toString()+") and w.programme_code=p.programme_code and  substr(W.work_id,5,2) ='"+dist.toString()+"'  and w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr.toString()+"'))  group by substr(W.work_id,5,2),substr(office_code,4,1) order by 2 ");
            Statement	stmt5=conn.createStatement();
		//	////System.out.println("ssqry-genrpt2:"+ssqry);
			ResultSet rs5=stmt5.executeQuery(qry1.toString());
			Hashtable h4=new Hashtable();
			while(rs5.next())
			{
				h4.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
			}
			if(rs5!=null)rs5.close();
			if(stmt5!=null)stmt5.close();
			
			
			
			qry1.delete(0, qry1.length());
			qry1.append("select  sum(case when to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-Apr-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2),substr(b.office_code,4,1)  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b ,rws_division_office_tbl d,rws_programme_tbl p where substr(b.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and b.programme_code=p.programme_code and  substr(a.work_id,5,2) ='"+dist.toString()+"'   group by substr(b.work_id,5,2),substr(b.office_code,4,1)  order by 2 ");
            Statement	stmt6=conn.createStatement();
			//////System.out.println("expqry-genrpt2:"+expqry);
			ResultSet rs6=stmt6.executeQuery(qry1.toString());
			Hashtable h5=new Hashtable();
			while(rs6.next())
			{
				h5.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
			}
			if(rs6!=null)rs6.close();
			if(stmt6!=null)stmt6.close();
			
			qry1.delete(0, qry1.length());
			qry1.append("SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END),substr(W.work_id,5,2),substr(W.office_code,4,1) FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W,rws_programme_tbl p ,rws_division_office_tbl d where substr(W.work_id,5,2)=d.circle_office_code and substr(W.office_code,4,1) =d.division_office_code and  W.WORK_ID=E.WORK_ID and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and p.programme_code in("+programe.toString()+")  and type_of_asset in("+scheme.toString()+") and w.programme_code=p.programme_code and W.work_id not in( select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr.toString()+"') group by substr(W.work_id,5,2),substr(W.office_code,4,1) order by 2 ");
				Statement	stmt7=conn.createStatement();
			//////System.out.println("tsqry-genrpt2:"+tsqry);
			ResultSet rs7=stmt7.executeQuery(qry1.toString());
			Hashtable h6=new Hashtable();
			while(rs7.next())
			{
				h6.put(rs7.getString(2)+rs7.getString(3),rs7.getString(1));
			}
			if(rs7!=null)rs7.close();
			if(stmt7!=null)stmt7.close();
			
			
			qry1.delete(0, qry1.length());
			qry1.append("SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),substr(W.work_id,5,2),substr(W.office_code,4,1)  FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W,rws_programme_tbl p ,rws_division_office_tbl d where substr(w.work_id,5,2)=d.circle_office_code and substr(W.office_code,4,1) =d.division_office_code and  W.WORK_ID=G.WORK_ID and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and  substr(w.work_id,5,2) ='"+dist.toString()+"'  and w.programme_code=p.programme_code and  w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"')  group by substr(W.work_id,5,2),substr(W.office_code,4,1) order by 2 ");
			Statement	stmt8=conn.createStatement();
			//////System.out.println("gqry-genrpt2:"+gqry);
			ResultSet rs8=stmt8.executeQuery(qry1.toString());
			Hashtable h7=new Hashtable();
			while(rs8.next())
			{
				h7.put(rs8.getString(2)+rs8.getString(3),rs8.getString(1));
			}
			if(rs8!=null)rs8.close();
			if(stmt8!=null)stmt8.close();
			
			qry1.delete(0, qry1.length());
			qry1.append("select sum(case when date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' then 1 else 0 end),substr(W.work_id,5,2),substr(office_code,4,1) from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_division_office_tbl d,rws_programme_tbl p where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  w.work_id=wc.work_id  and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+") and  substr(w.work_id,5,2) ='"+dist.toString()+"'   and w.programme_code=p.programme_code group by substr(W.work_id,5,2),substr(office_code,4,1) order by 2 ");
			//////System.out.println("wcqry-genrpt2:"+wcqry);
			Statement	stmt9=conn.createStatement();
			//////System.out.println("wcqry-genrpt2:"+wcqry);
			ResultSet rs9=stmt9.executeQuery(qry1.toString());
			Hashtable h8=new Hashtable();
			while(rs9.next())
			{
				h8.put(rs9.getString(2)+rs9.getString(3),rs9.getString(1));
			}
			if(rs9!=null)rs9.close();
			if(stmt9!=null)stmt9.close();
			
			qry1.delete(0, qry1.length());
			//String chqry="select sum(w.no_of_habs),substr(W.work_id,5,2),substr(office_code,4,1) from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_division_office_tbl d  where substr(w.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  w.work_id=wc.work_id and work_cancel_dt is null  "+planQry+"  "+catQry+" and w.programme_code in("+programe+")    and date_of_completion<'01-Apr-"+yr+"'  group by substr(W.work_id,5,2),substr(office_code,4,1) order by 2 ";
			qry1.append("Select count(hab_code),substr(b.work_id,5,2),substr(office_code,4,1)   from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and  substr(b.work_id,5,2) ='"+dist.toString()+"'  and b.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")   and  a.work_id not in (select work_id from  rws_work_completion_tbl where date_of_completion<'01-Apr-"+yr.toString()+"' )  group by substr(b.work_id,5,2) ,substr(office_code,4,1) order by 2 ");
			//////System.out.println("chqry-genrpt2:"+chqry);
			Statement	stmt10=conn.createStatement();
			ResultSet rs10=stmt10.executeQuery(qry1.toString());
			Hashtable h9=new Hashtable();
			while(rs10.next())
			{
				h9.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
			}
			if(rs10!=null)rs10.close();
			if(stmt10!=null)stmt10.close();
			
			qry1.delete(0, qry1.length());
			qry1.append("Select count(hab_code),substr(b.work_id,5,2),substr(office_code,4,1)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b ,rws_division_office_tbl d  where substr(b.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  a.work_id =b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+"  and b.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and  substr(b.work_id,5,2) ='"+dist.toString()+"'  and    a.work_id in (select work_id from  rws_work_completion_tbl where date_of_completion>='01-Apr-"+yr.toString()+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr.toString())+1)+"' )   group by substr(b.work_id,5,2),substr(office_code,4,1)  order by 2 ");
			// ////System.out.println("covqry:"+covqry);
		    Statement	stmt11=conn.createStatement();
			ResultSet rs11=stmt11.executeQuery(qry1.toString());
			Hashtable h10=new Hashtable();
			while(rs11.next())
			{
				h10.put(rs11.getString(2)+rs11.getString(3),rs11.getString(1));
			}
			if(rs11!=null)rs11.close();
			if(stmt11!=null)stmt11.close();

			
			qry1.delete(0, qry1.length());
			// String expmonqry1="select  sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr+"' and to_date(voucher_dt)< '01-Apr-"+nextyr+"') then voucher_Amt else 0 end),substr(b.work_id,5,2),substr(office_code,4,1)  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p where a.work_id=b.work_id and work_cancel_dt is null  "+planQry+"  "+catQry+" and to_char(voucher_dt,'yyyy')='"+prevyear+"' and  TO_char(voucher_dt,'MON')='"+mymon+"' and p.programme_code in("+programe+") and type_of_asset in("+scheme+") and  substr(b.work_id,5,2) ='"+dist+"' and a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+(Integer.parseInt(yr)+1)+"') and  substr(b.work_id,5,2) ='"+dist+"'  and p.programme_code in("+programe+") and type_of_asset in("+scheme+")  and b.programme_code=p.programme_code group by substr(b.work_id,5,2),substr(office_code,4,1)   order by 2 ";
		    qry1.append("select  sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt)< '01-"+mymon.toString()+"-"+nextyr.toString()+"') then voucher_Amt else 0 end),substr(b.work_id,5,2),substr(office_code,4,1)  from rws_work_exp_voucher_tbl a, rws_work_admn_tbl  b,rws_programme_tbl p ,rws_division_office_tbl d  where substr(b.work_id,5,2)=d.circle_office_code and substr(office_code,4,1) =d.division_office_code and  a.work_id=b.work_id and work_cancel_dt is null  "+planQry.toString()+"  "+catQry.toString()+" and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr.toString()+"') and  substr(b.work_id,5,2) ='"+dist.toString()+"'  and p.programme_code in("+programe.toString()+") and type_of_asset in("+scheme.toString()+")  and b.programme_code=p.programme_code group by substr(b.work_id,5,2),substr(office_code,4,1)   order by 2 ");
            Statement	stmt12=conn.createStatement();
			////System.out.println("expmonqry22222222-genrpt2:"+expmonqry1);
			ResultSet rs12=stmt12.executeQuery(qry1.toString());
			Hashtable h11=new Hashtable();
			while(rs12.next())
			{
		    	h11.put(rs12.getString(2)+rs12.getString(3),rs12.getString(1));
			}
			if(rs12!=null)rs12.close();
			if(stmt12!=null)stmt12.close();

			
			
	/*	qry1.delete(0, qry1.length());
		qry1.append("select substr(a.work_id,5,2),substr(a.office_code,4,1) ,sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr.toString()+"' and to_date(voucher_dt) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>='01-APR-"+yr.toString()+"' and to_date(voucher_dt)< '01-APR-"+nextyr.toString()+"') then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b  where  a.work_id in (select b.work_id from  "+relTable.toString()+" b  where to_date("+relColumn.toString()+")>= '01-APR-"+yr.toString()+"' and "+txid.toString()+" is not null) and a.work_id=b.work_id    "+planQry.toString()+" "+catQry.toString()+" and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr.toString()+"'))");
        if(scheme.toString()!=null && !scheme.toString().equals(""))
        {
	    qry1.append("and a.type_of_asset in("+scheme.toString()+")");
        }
        qry1.append(" and  a.programme_code in ("+programe.toString()+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr.toString()+"') and DATE_OF_COMPLETION is  not null ) group by  substr(a.work_id,5,2),substr(a.office_code,4,1)    order by 1");

		Statement stmt13=conn.createStatement();
        //System.out.println("newWorksExpenSVS111"+qry1.toString());
	 ResultSet rs13=stmt13.executeQuery(qry1.toString());
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs13.next())
	{
		newWorksExpSVS.put(rs13.getString(1)+rs13.getString(2),rs13.getString(3));
	}
	if(rs13!=null)rs13.close();
	if(stmt13!=null)stmt13.close();*/
	
	qry1.delete(0, qry1.length());
	 qry1.append("select  substr(a.OFFICE_CODE,4,1),sum(case when (to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(BANK_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUNT_CENTRAL else 0 end) from rws_work_admn_tbl a ,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  to_date(BANK_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and "+txid.toString()+" is not null and a.work_id=b.work_id  "+planQry.toString()+"  and CATEGORY_CODE='"+catCode.toString()+"'  and  a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null");
	 if(scheme!=null && !scheme.equals(""))
	 {
		 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
	 }
	 if(dcode.toString()!=null && !dcode.toString().equals("00"))
	 {
		 qry1.append(" and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
	 } 
	qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+") ) group by  substr(a.OFFICE_CODE,4,1)  order by 1");

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
	
	
	
	
	  qry1.append("select  substr(a.OFFICE_CODE,4,1),sum(case when (to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE) < '01-"+mymon.toString()+"-"+nextyr.toString()+"' )then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-Apr-"+yr.toString()+"' and to_date(STATE_SEND_DATE)< '01-Apr-"+nextyr.toString()+"') then BILL_AMOUT_STATE else 0 end) from rws_work_admn_tbl a ,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  to_date(STATE_SEND_DATE)>= '01-Apr-"+yr.toString()+"' and STATE_TXID is not null and a.work_id=b.work_id  "+planQry.toString()+" and CATEGORY_CODE='"+catCode.toString()+"' and    a.work_id in (select work_id from rws_work_completion_tbl where  DATE_OF_COMPLETION is not null ");
		 if(scheme!=null && !scheme.equals(""))
		 {
			 qry1.append(" and a.type_of_asset in("+scheme.toString()+")");
		 }
		 if(dcode.toString()!=null && !dcode.toString().equals("00"))
		 {
			 qry1.append("and substr(a.work_id,5,2)="+dcode.toString()+" ") ;
		 } 
		qry1.append(" "+planQry.toString()+"  and  a.programme_code in ("+programe.toString()+")) group by   substr(a.OFFICE_CODE,4,1) order by 1");

			Statement stmt93=conn.createStatement();
	    // System.out.println("monthlllyreleases pao123"+qry1.toString());
		 ResultSet rs93=stmt93.executeQuery(qry1.toString());
		Hashtable monreleasespao123=new Hashtable();
		while(rs93.next())
		{
			monreleasespao123.put(rs93.getString(1),rs93.getString(2));
		}
		if(rs93!=null)rs93.close();
		if(stmt93!=null)stmt93.close();

		qry1.delete(0,qry1.length());
	
	
	
	
	
	
  double gv1=0,gv2=0;
  qry1.delete(0, qry1.length());
  qry1.append("select division_office_code,division_office_name,circle_office_code from rws_division_office_tbl where circle_office_code ='"+dist.toString()+"'  and status <>'UI' order by 2");
			stmt=conn.createStatement();
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
			//StringBuffer expenm=new StringBuffer();
			StringBuffer fexpenm=new StringBuffer();
			
			StringBuffer value1=new StringBuffer();
			StringBuffer value2=new StringBuffer();

			StringBuffer expmon1=new StringBuffer();
			StringBuffer dexpmon=new StringBuffer();	
			StringBuffer lastyeatexp=new StringBuffer();
			StringBuffer lasetyearexppao= new StringBuffer();
			StringBuffer bankreleases=new StringBuffer();
			StringBuffer paoreleases=new StringBuffer();
			StringBuffer phycomreleases=new StringBuffer();
			int styleCount=0;
			StringBuffer style=new StringBuffer();
	
			
			while(rs.next())
			{
	  			
			     nwork.delete(0,nwork.length());
				 nwork.append(h.get(rs.getString(3)+rs.getString(1)));
			     if(nwork.toString()!=null && !nwork.toString().equals("") && !nwork.toString().equals("null"))
			     {
			    	 
			     }else
			     {
			    	 nwork.delete(0,nwork.length());
			    	 nwork.append("0");
			     }
			    
			     //System.out.println("nwork::::"+nwork.toString());  
			     
			     
			     
			    swork.delete(0,swork.length());
				swork.append(h1.get(rs.getString(3)+rs.getString(1)));
				if(swork.toString()!=null && !swork.toString().equals("") && !swork.toString().equals("null")){}else{
				swork.delete(0,swork.length());swork.append("0");}
				
				
				shabs.delete(0,shabs.length());
				shabs.append(h2.get(rs.getString(3)+rs.getString(1)));
				if(shabs.toString()!=null && !shabs.toString().equals("") && !shabs.toString().equals("null")){}else{shabs.delete(0,shabs.length());shabs.append("0");}
				
				nsamt.delete(0,nsamt.length());
				nsamt.append(h3.get(rs.getString(1)));
				if(nsamt.toString()!=null && !nsamt.toString().equals("") && !nsamt.toString().equals("null")){}else{nsamt.delete(0,nsamt.length());nsamt.append("0");}
				
				
				ssamt.delete(0,ssamt.length());
				ssamt.append(h4.get(rs.getString(3)+rs.getString(1)));
				if(ssamt.toString()!=null && !ssamt.toString().equals("") && !ssamt.toString().equals("null")){}else{ssamt.delete(0,ssamt.length());ssamt.append("0");}
				
				
			    
		        exp.delete(0,exp.length());
				exp.append(h5.get(rs.getString(3)+rs.getString(1)));
		       if(exp.toString()!=null && !exp.toString().equals("") && !exp.toString().equals("null"))
		       {
				String []aa=exp.toString().split("@");
				
				  a1.delete(0,a1.length());	
				  a1.append(aa[0]);
				 
				 a2.delete(0,a2.length());
				 a2.append(aa[1]); 
				 
				 
				
				}
		       else
		       {
		    	  a1.delete(0,a1.length());
		    	   a1.append("0");
		    	   a2.delete(0,a2.length());
		    	   a2.append("0");
		    	   		       	
				}
		         
		         thabs.delete(0,thabs.length());
				 thabs.append(h6.get(rs.getString(3)+rs.getString(1)));
				 if(thabs.toString()!=null && !thabs.toString().equals("") && !thabs.toString().equals("null")){}else{thabs.delete(0, thabs.length());thabs.append("0");}
				
				gdate.delete(0,gdate.length());
				 gdate.append(h7.get(rs.getString(3)+rs.getString(1)));
				if(gdate.toString()!=null && !gdate.toString().equals("") && !gdate.toString().equals("null")){}else{gdate.delete(0, gdate.length());gdate.append("0");}
				
				wcdate.delete(0,wcdate.length());
				 wcdate.append(h8.get(rs.getString(3)+rs.getString(1)));
				if(wcdate.toString()!=null && !wcdate.toString().equals("") && !wcdate.toString().equals("null")){}else{wcdate.delete(0, wcdate.length());wcdate.append("0");}
				
				
				chabs.delete(0,chabs.length());
				 chabs.append(h9.get(rs.getString(3)+rs.getString(1)));
				if(chabs.toString()!=null && !chabs.toString().equals("") && !chabs.toString().equals("null")){}else{chabs.delete(0, chabs.length());chabs.append("0");}
				
				
				covhabs.delete(0,covhabs.length());
				 covhabs.append(h10.get(rs.getString(3)+rs.getString(1)));
				if(covhabs.toString()!=null && !covhabs.toString().equals("") && !covhabs.toString().equals("null")){}else{covhabs.delete(0, covhabs.length());covhabs.append("0");}
			
				
				expmon1.delete(0,expmon1.length());
				expmon1.append(h11.get(rs.getString(3)+rs.getString(1)));
				if(expmon1.toString()!=null && !expmon1.toString().equals("") && !expmon1.toString().equals("null"))
				{
					
					
				}else
				{
					expmon1.delete(0, expmon1.length());expmon1.append("0");
				
				}
				
 
		       
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
					//	System.out.println("v1"+v1);
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
		   		      
		   		  // System.out.println("v4"+v4);
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
			//	System.out.println("v6"+v6);
				
				///////////////Added by anu 11032015
				
				
				lastyeatexp.delete(0,lastyeatexp.length());
				lastyeatexp.append(lastfinbank.get(rs.getString(1)));
				//System.out.println("lastyeatexp"+lastyeatexp);
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
			     
				

					 	////////////added by anu
							
							bankreleases.delete(0,bankreleases.length());
							bankreleases.append(monreleasesbank.get(rs.getString(1)));
							if(bankreleases.toString()!=null && !bankreleases.toString().equals("") && !bankreleases.toString().equals("null"))
							{
								String bankrel[]=bankreleases.toString().split("@");
								release1=Double.parseDouble(bankrel[0].toString())/100000;
								//release2=Double.parseDouble(bankrel[1].toString())/100000;
							}
							else
							{
								bankreleases.delete(0,bankreleases.length());
								bankreleases.append("0");
								release1=0;
							//	release2=0;
								
							}
							
							paoreleases.delete(0,paoreleases.length());
							paoreleases.append(monreleasespao.get(rs.getString(1)));
							if(paoreleases.toString()!=null && !paoreleases.toString().equals("") && !paoreleases.toString().equals("null"))
							{
								String paorel[]=paoreleases.toString().split("@");
								paorelease1=Double.parseDouble(paorel[0].toString())/100000;
								//paorelease2=Double.parseDouble(paorel[1].toString())/100000;
							}
							else
							{
								paoreleases.delete(0,paoreleases.length());
								paoreleases.append("0");
								paorelease1=0;
								//paorelease2=0;
								
							}
							
							double aa1=Double.parseDouble(a1.toString())/100000; 

					double totreleases=release2+paorelease2+v6;
					
				//	System.out.println("totreleases"+totreleases);
					double balest=(Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(aa1);
					
				//	System.out.println("balest"+balest);
					
					double totpercentage=totreleases/balest;
					//System.out.println("totpercentage"+totpercentage);
					
					double totp = (balest/totreleases);
				//	System.out.println("totp"+totp);
					
					
					
					/////////////////////////lllllllllllllllllllllllll
				     
				     
				     
		       
				if(styleCount%2==0){
					 style.delete(0,style.length());
					 style.append("gridbg1");
				}else{
					 style.delete(0,style.length());
					 style.append("gridbg2");
				}
				styleCount++;
		       


%>
				 <tr>
				<td class=<%=style.toString()%> style="text-align: center;" align=center><%=cnt++%></td>
				<td class=<%=style.toString()%> style="text-align: left;" title=Click nowrap><%=rs.getString(2)%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=swork.toString()%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=nwork.toString()%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString())%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=shabs.toString()%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=ssamt.toString()%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=nsamt.toString()%></td>
				<td class=<%=style.toString()%> style="text-align: center;" align="right"><%=ndf.format(Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))%></td>
               
                
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(lastexpbank)%></td>
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(lastexppao)%></td>
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totalreleaselastyear)%></td>
				
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format((Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString()))-(aa1))%></td>
               <% double eexpmon1=Double.parseDouble(expmon1.toString())/100000; %>
               
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(release1)%></td><!--
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(release2)%></td>
                 --><td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(paorelease1)%></td>
                 <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(release1+paorelease1)%></td>
                 <!--
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(paorelease2)%></td>
               
				--><!--<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(eexpmon1)%></td>
                --><% double aa2=Double.parseDouble(a2.toString())/100000; %><!--
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(aa2)%></td>
	
	         --><td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(v5) %></td>

		           <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(v6) %></td>
		           <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totreleases)%></td>
		           
				<%if(balest<=0)
				{%><td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totp)%></td><%}else{%><td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(totpercentage*100)%></td>
				<%}%>
				
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=thabs.toString()%></td>
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=gdate.toString()%></td>
				<td class=<%=style.toString() %> style="text-align: center;" align="right"><%=wcdate.toString()%></td>
				<!--  <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=chabs.toString()%></td>-->
                <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=covhabs.toString()%></td>
				
				
		<%if(Integer.parseInt(chabs.toString())==0)
				{aas=0;%><!-- <td class=<%=style.toString() %> style="text-align: center;" align="right">0</td>--><%}
		else{
			double aas1=Integer.parseInt(shabs.toString())-Integer.parseInt(chabs.toString());
			if(aas1==0)
			{
				aas=0;
			}
			else
			{
			aas=(Double.parseDouble(covhabs.toString())/aas1)*100;
		       ////System.out.println("aaa::"+aas);
			}
			%><!-- <td class=<%=style.toString() %> style="text-align: center;" align="right"><%=ndf.format(aas)%></td>-->
		<%}%>
		
		</tr>
										 
				  </tr>
				<%

 gv1+=v5;
             gv2+=v6;
         v1=0;
   v2=0;

					stot+=Integer.parseInt(swork.toString());ntot+=Integer.parseInt(nwork.toString());
					alltot+=Integer.parseInt(swork.toString())+Integer.parseInt(nwork.toString());
					hstot+=Integer.parseInt(shabs.toString());
					sptot+=Double.parseDouble(ssamt.toString());
					nptot+=Double.parseDouble(nsamt.toString());
					totall+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString());
					exprev+=totalreleaselastyear;
					expdur+=aa2;
					totexp+=aa2;
					balecost+=Double.parseDouble(ssamt.toString())+Double.parseDouble(nsamt.toString())-(totalreleaselastyear);
					tstot+=Integer.parseInt(thabs.toString());
					gtot+=Integer.parseInt(gdate.toString());
					cwtot+=Integer.parseInt(wcdate.toString());
					chtot+=Integer.parseInt(chabs.toString());
					chctot+=Integer.parseInt(covhabs.toString());
					epenmtot+=eexpmon1;
					
					release1bank+=release1;
			        releasebank2+=release2;
			        releasepao+=paorelease1;
			        releasepao2+=paorelease2;
			        totreleases1+=totreleases;
			        lastyearreleases+=lastexpbank;
					lastyearreleasepao+=lastexppao;
					
					
					/*if(((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-(aa1))<=0)
					{
					   balpcost+=0;
					}
					else   
					{
					   balpcost+=((Double.parseDouble(a2)/((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1)))*100);
					}*/
					bhabs+=Integer.parseInt(shabs.toString())-Integer.parseInt(covhabs.toString());

//	htot+=aas;
	//	////System.out.println("Division"+htot);
			 }
			 if(rs!=null)rs.close();
			 if(stmt!=null)stmt.close();
			 if(conn!=null) conn.close();
			%>
		
		<tr class=gridhdbg>
		<td  Colspan=2  align="center"  class=gridhdbg>Total</td>
		<td  align="right" ><%=stot%></td>
		<td  align="right" ><%=ntot%></td>
		<td  align="right" ><%=alltot%></td>
		<td  align="right" ><%=hstot%></td>
		<td  align="right" ><%=ndf.format(sptot)%></td>
		<td  align="right" ><%=ndf.format(nptot)%></td>
		<td  align="right" ><%=ndf.format(totall)%></td>
		
		<td  align="right" ><%=ndf.format(lastyearreleases)%></td>
		<td  align="right" ><%=ndf.format(lastyearreleasepao)%></td>
		
		<td  align="right" ><%=ndf.format(exprev)%></td>
		<td  align="right" ><%=ndf.format(balecost)%></td>
		
		<td  align="right" ><%=ndf.format(release1bank)%></td>
		<!--<td  align="right" ><%=ndf.format(releasebank2)%></td>
		-->
		<td  align="right" ><%=ndf.format(releasepao)%></td>
		<td  align="right" ><%=ndf.format(release1bank+releasepao)%></td>
		
		<!--<td  align="right" ><%=ndf.format(releasepao2)%></td>
		
		--><!--<td  align="right" ><%=ndf.format(epenmtot)%></td>
		<td  align="right" ><%=ndf.format(expdur)%></td>
		--><td  align="right" ><%=ndf.format(gv1)%></td>
		<td  align="right" ><%=ndf.format(gv2)%></td>
		
		<td  align="right" ><%=ndf.format(totreleases1)%></td>
		 <% if(expdur > balecost){ %>
		<td  align="right" ><%=ndf.format((expdur/balecost)*100)%></td> 
<%}else {%>
	<td  align="right" >0</td> 
<%} %>	
		
		<td  align="right" ><%=tstot%></td>
		<td  align="right" ><%=gtot%></td>
		<td  align="right" ><%=cwtot%></td>
		<!-- <td  align="right" ><%=chtot%></td>-->
        <td  align="right" ><%=chctot%></td>
<!--  
<td  align="right" ><%=bhabs%></td>
	-->	
<%//////System.out.println("chctot"+chctot);
		//////System.out.println("bhabs"+bhabs);
		if(chctot==0 || bhabs==0){%>
		<!-- <td  align="right" >0</td>-->
		<%}else{%>
		<!-- <td  align="right" ><%=ndf.format((Double.parseDouble(""+chctot)/Double.parseDouble(""+bhabs))*100)%></td> -->
		<%}%>
		</tr>
		</table>
		
		 
		<%}
		
		
		
		%>



		<input type="hidden" name="programes" value='<%=programe.toString()%>'>
		<input type="hidden" name="scheme" value='<%=scheme.toString()%>'>
</html>

