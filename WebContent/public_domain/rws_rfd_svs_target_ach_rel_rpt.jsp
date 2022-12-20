<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

//22/08/2013
////System.out.println("Server Date:"+w.getServerDate());

StringBuffer cYear=new StringBuffer();
cYear.append(w.getServerDate().substring(6,10));
StringBuffer currentMonth=new StringBuffer();
currentMonth.append(RwsUtils.getCurrentMont());

if(currentMonth.toString()!=null&& !(currentMonth.toString().equals("APR") || currentMonth.toString().equals("MAY") || currentMonth.toString().equals("JUN")
		|| currentMonth.toString().equals("JUL")
		|| currentMonth.toString().equals("AUG")
		|| currentMonth.toString().equals("SEP")
		|| currentMonth.toString().equals("OCT")
		|| currentMonth.toString().equals("NOV")
		|| currentMonth.toString().equals("DEC")
)){
	int tempYear=Integer.parseInt(cYear.toString());
	tempYear-=1;
	cYear.delete(0,cYear.length());
	cYear.append(String.valueOf(tempYear));
	
}





if(currentMonth.toString()!=null&& !(currentMonth.toString().equals("APR") || currentMonth.toString().equals("MAY") || currentMonth.toString().equals("JUN")
		|| currentMonth.toString().equals("JUL")
		|| currentMonth.toString().equals("AUG")
		|| currentMonth.toString().equals("SEP")
		|| currentMonth.toString().equals("OCT")
		|| currentMonth.toString().equals("NOV")
		|| currentMonth.toString().equals("DEC")

)){
	int tempYear=Integer.parseInt(cYear.toString());
	tempYear+=1;
	cYear.delete(0,cYear.length());
	cYear.append(String.valueOf(tempYear));
	
	
    
}


StringBuffer prevmonth=new StringBuffer();
StringBuffer finYear=new StringBuffer();
StringBuffer nextMonth=new StringBuffer();

prevmonth.append(RwsUtils.getPreviousMonth().toUpperCase());

int nYear=Integer.parseInt(cYear.toString());
int pYear=nYear-1;
nYear+=1;



nextMonth.append(RwsUtils.getNextMonth());

////System.out.println("DDED");


%>
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

	DecimalFormat ndf = new DecimalFormat("####.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	
    
	<body>
   <table>

<tr><td align="right" class="bwborder" colspan="2">
                    <a href="./rws_rfd_svs_target_ach_rel_rpt_excel.jsp" target="_new">Excel</a>|<a href="javascript:onclick=history.go(-1)" >Back</a></td></tr>  
				
				</table>
				
					<table width="80%" border=0 style="border-collapse:collapse"  align=center>
                                            
                                         
<tr >
		<td align="center" class="gridhdbg" colspan=11><font color="white"><b>Works Program under SVS <%=cYear %>-<%=nYear %></b></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
<td class="gridhdbg"  align=center colspan=2 nowrap >Target(<%=cYear %>-<%=nYear %>) <br></br><font color="red"><b>Amount In Lakhs.</b></font></td>
<td class="gridhdbg" colspan=4 align=center >Achievement (<%=cYear %>-<%=nYear %>) <br><font color="red"><b>Amount In Lakhs.</b></font></br></td>
</tr>
<tr>
<td class="gridhdbg"  align="center"  >Habitations Coverage</td>
 <td  class="gridhdbg" align="center"  >Anticipated<br>Expenditure</td>	
 <td class="gridhdbg"  align="center"  >Habitations Coverage</td>
 <td  class="gridhdbg"  align="center"  >Expenditure<br>Upto<%=prevmonth %></td>
 <td  class="gridhdbg" align="center"  >Expenditure <br>During&nbsp;<%=currentMonth %></td>
 <td  class="gridhdbg"  align="center"  >Expenditure <br></br>During(<%=cYear %>-<%=nYear %>)</td>
 	
</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
StringBuffer programmeNames=new StringBuffer();
StringBuffer programmeNames1=new StringBuffer();
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  StringBuffer selectedProgramsFin=new StringBuffer();
	  StringBuffer selectedProgramsPhy=new StringBuffer();
	  StringBuffer scheme=new StringBuffer();
	  StringBuffer Query=new StringBuffer();
	  selectedProgramsFin.append("'01','02','18','23','32','48','49','51','58','59','60','04','57','65','46','12','50','70'");
	  selectedProgramsPhy.append("'01','02','18','23','32','48','49','51','58','04','57','65','46','12','70'");
	  scheme.append("'01','02','03'");
	  
	  
	  Hashtable svsCovhabsHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d,rws_complete_hab_view ch  where ch.panch_code=b.hab_code  and a.work_id in(select work_id from rws_work_completion_tbl where  to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' )   and a.WORK_CANCEL_DT is null and a.category_code='2'  and a.type_of_asset in('01','02','03') and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsPhy.toString()+") group by d.dcode,d.dname order by d.dcode");
	  ////System.out.println("Q1:"+svsHabsQuery);
	  rs2=stmt2.executeQuery(Query.toString());
	  while(rs2.next()){
		  
		  svsCovhabsHash.put(rs2.getString(1),rs2.getString(3));
		  
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  /**********************************************/

	  Hashtable svsExpLastMonHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where   a.WORK_CANCEL_DT is null and a.category_code='2'    and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+cYear.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	 ////System.out.println("Q2:"+svsExpLastMonthQuery);
	  rs4=stmt4.executeQuery(Query.toString());
	  while(rs4.next()){
		  
		  svsExpLastMonHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
	  
	  
	  
/**********************************************/
	  stmt4=conn.createStatement();
	  Hashtable svsPaoExpLastMonHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUT_STATE)/100000)  from rws_work_admn_tbl a,rws_district_tbl d,  rws_bill_pao_bridge_det_tbl v  where   a.WORK_CANCEL_DT is null and a.category_code='2'    and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.STATE_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' and  to_date(v.STATE_SEND_DATE,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+cYear.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	////System.out.println("Q3:"+svsPaoExpLastMonthQuery);
	  rs4=stmt4.executeQuery(Query.toString());
	  while(rs4.next()){
		  
		  svsPaoExpLastMonHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  

/**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsExpCurrenMonHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where    a.WORK_CANCEL_DT is null and a.category_code='2'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-"+currentMonth.toString()+"-"+cYear.toString()+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-"+nextMonth.toString()+"-"+cYear.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	  ////System.out.println("Q4:"+svsExpCurrentMonthQuery);
	  rs4=stmt4.executeQuery(Query.toString());
	  while(rs4.next()){
		  
		  svsExpCurrenMonHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
	  

	  /**********************************************/
	  stmt2=conn.createStatement();

	     Query.delete(0,Query.length());
	     Query.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,RWS_WORK_COMMENCEMENT_TBL com  where com.work_id=w.work_id and to_date(w.ADMIN_DATE) < '01-Apr-"+cYear.toString()+"'    and  substr(W.WORK_ID,5,2)=D.DCODE and w.category_code='2' and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear.toString()+"')) and WORK_CANCEL_DT  is null ");
	     Query.append("and w.type_of_asset in("+scheme.toString()+")");
	     Query.append(" and  w.programme_code in ("+selectedProgramsPhy.toString()+") group by d.dcode");

	  	//System.out.println("spillOverWorks"+Query.toString());
	  	 rs2=stmt2.executeQuery(Query.toString());
	  
	  	Hashtable spillOverWorksHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	  
	  

	  stmt2=conn.createStatement();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl   hb , RWS_WORK_COMMENCEMENT_TBL com   where hb.work_id=w.work_id and to_date(w.ADMIN_DATE) < '01-Apr-"+cYear.toString()+"'  and w.category_code='2'   and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear.toString()+"')) and WORK_CANCEL_DT  is null ");
	  Query.append("and w.type_of_asset in("+scheme.toString()+")");
	  Query.append(" and  w.programme_code in ("+selectedProgramsPhy.toString()+") group by d.dcode");

	  	//System.out.println("spillOverGroundHabs"+Query.toString());
	  	 rs2=stmt2.executeQuery(Query.toString());

	  	Hashtable spillOverGroundedHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverGroundedHabsHash.put(rs2.getString(1),rs2.getString(2));
	  	}



	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  
	  
	  stmt2=conn.createStatement();
	    Query.delete(0,Query.length());
	    Query.append("select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+cYear.toString()+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,RWS_WORK_COMMENCEMENT_TBL  comm  where  w.category_code='2' and  w.work_id=comm.work_id and comm.GROUNDING_DATE is not null and  to_date(w.ADMIN_DATE) < '01-Apr-"+cYear.toString()+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear.toString()+"')) and WORK_CANCEL_DT  is null ");
	    Query.append("and w.type_of_asset in("+scheme.toString()+")");
	    Query.append(" and  w.programme_code in ("+selectedProgramsPhy.toString()+") group by d.dcode");

	  //	System.out.println("spillOverGroundedExpWorks"+spillOverGroundedExpWorks);
	  
	  	rs2=stmt2.executeQuery(Query.toString());
	  
	  	Hashtable spillOverGroundedWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverGroundedWorksExpHash.put(rs2.getString(1),rs2.getString(2));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();

	  
	  
	  /********************************************************/
	  
	  
	  	  stmt4=conn.createStatement();
	  	  Hashtable svsPaoExpCurrenMonHash=new Hashtable();
	  	  Query.delete(0,Query.length());
	   	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUT_STATE)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_bill_pao_bridge_det_tbl v  where    a.WORK_CANCEL_DT is null and a.category_code='2'     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.STATE_SEND_DATE,'dd/mm/yy')>='01-"+currentMonth.toString()+"-"+cYear.toString()+"' and  to_date(v.STATE_SEND_DATE,'dd/mm/yy')<'01-"+nextMonth.toString()+"-"+cYear.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	  	  ////System.out.println("Q5:"+svsPaoExpCurrentMonthQuery);
	  	  rs4=stmt4.executeQuery(Query.toString());
	  	  while(rs4.next()){
	  		  
	  		svsPaoExpCurrenMonHash.put(rs4.getString(1),rs4.getString(3));
	  		  
	  		  
	  	  }
	  	  
	  	  if(rs4!=null)
	  	  {
	  		  rs4.close();
	  	  }
	  	  if(stmt4!=null){
	  		  stmt4.close();
	  	  }
/**********************************************/
	   stmt4=conn.createStatement();
	  Hashtable svsTotExpHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUNT_CENTRAL)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, RWS_bill_bank_bridge_det_TBL v  where   a.WORK_CANCEL_DT is null and a.category_code='2'   and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.BANK_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' and  to_date(v.BANK_SEND_DATE,'dd/mm/yy')<'01-APR-"+nYear+"'  group by d.dcode,d.dname order by d.dcode");
	  ////System.out.println("Q6:"+svsTotExpQuery);
	  rs4=stmt4.executeQuery(Query.toString());
	  while(rs4.next()){
		  
		  svsTotExpHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  /**********************************************/
	  stmt4=conn.createStatement();
	  Hashtable svsPaoTotExpHash=new Hashtable();
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname ,(sum(BILL_AMOUT_STATE)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_bill_pao_bridge_det_tbl v  where   a.WORK_CANCEL_DT is null and a.category_code='2'   and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+selectedProgramsFin.toString()+") and to_date(v.STATE_SEND_DATE,'dd/mm/yy')>='01-APR-"+cYear.toString()+"' and  to_date(v.STATE_SEND_DATE,'dd/mm/yy')<'01-APR-"+nYear+"'  group by d.dcode,d.dname order by d.dcode");
	  ////System.out.println("Q7:"+svsPaoTotExpQuery);
	  rs4=stmt4.executeQuery(Query.toString());
	  while(rs4.next()){
		  
		  svsPaoTotExpHash.put(rs4.getString(1),rs4.getString(3));
		  
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  
	  
	  //Printing Report....
	  
	  Query.delete(0,Query.length());
	  Query.append("select d.dcode,d.dname,t.SVS_HABS,(t.SVS_EXP*100)  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='2013-2014'");
	  
	  
	  rs3=stmt3.executeQuery(Query.toString());
	  int svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  StringBuffer style=new StringBuffer();
	  StringBuffer expStr=new StringBuffer(); 
	  StringBuffer str=new StringBuffer(); 
	  StringBuffer spillWorks=new StringBuffer(); 
	  StringBuffer svsTargetHabs=new StringBuffer();
	  StringBuffer svsExpupto=new StringBuffer();
	  StringBuffer svsPaoExpupto=new StringBuffer();
	  StringBuffer svsCurrentExp=new StringBuffer();
	  StringBuffer svsPaoCurrentExp=new StringBuffer(); 
	  StringBuffer svsTotExp=new StringBuffer();
	  StringBuffer svsPaoTotExp=new StringBuffer();
	  double d1=0,d2=0,d3=0,p1=0,p2=0,p3=0;
	   int gspillHabs=0;
	   double gtargetEst=0;
	  int styleCount=0;
	  while(rs3.next()){
		  
		  double groundedexp=0,spillSanctionedAmt=0;int spillHabs=0;
		  StringBuffer key=new StringBuffer(rs3.getString(1));
		  expStr.delete(0,expStr.length());
 			if(spillOverGroundedWorksExpHash.get(key.toString())!=null){
			  
			  expStr.append((String)spillOverGroundedWorksExpHash.get(key.toString()));
			  if(expStr.toString()!=null){
			  groundedexp=Double.parseDouble(expStr.toString());
			  }
			  
		  }
		  
		
         if(spillOverGroundedHabsHash.get(key.toString())!=null){
        	 str.delete(0,str.length());
        	 str.append((String)spillOverGroundedHabsHash.get(key.toString()));
        	 spillHabs=Integer.parseInt(str.toString());
        	     	  
        	 
         }
         gspillHabs+=spillHabs;
 
			if(spillOverWorksHash.get(key.toString())!=null ){
				spillWorks.delete(0,spillWorks.length());
				spillWorks.append((String)spillOverWorksHash.get(key.toString()));
				String []aa=spillWorks.toString().split("@");
				String a1=aa[0];
				if(a1!=null){
					int sWorkCount=Integer.parseInt(a1);
				}
				String a2=aa[1];
				if(a2!=null){
					spillSanctionedAmt=Double.parseDouble(a2);
				}

			}
		  
	  
		  double targetEst=(spillSanctionedAmt-groundedexp);
		  gtargetEst+=targetEst;
		  
		 svsTargetHabs.delete(0,svsTargetHabs.length());
		 svsTargetHabs.append((String)svsCovhabsHash.get(rs3.getString(1)));
		 if(svsTargetHabs.toString()==null || svsTargetHabs.toString().equals("null")){
			 svsTargetHabs.delete(0,svsTargetHabs.length());
			 svsTargetHabs.append("0");
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs.toString());
		 
		 
		/******************************/
		svsExpupto.delete(0,svsExpupto.length());
		svsExpupto.append((String)svsExpLastMonHash.get(rs3.getString(1)));
		if(svsExpupto.toString()==null || svsExpupto.toString().equals("null")){
			svsExpupto.delete(0,svsExpupto.length());
			svsExpupto.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsExpupto);
		
		d1=Double.parseDouble(svsExpupto.toString());
		
		 
		if(rs3.getString(3)!=null){
			svsT+=Integer.parseInt(rs3.getString(3));
		}
		if(rs3.getString(4)!=null){
			expT+=Double.parseDouble(rs3.getString(4));
		}
		
		/******************************************************/
		svsPaoExpupto.delete(0,svsPaoExpupto.length());
		svsPaoExpupto.append((String)svsPaoExpLastMonHash.get(rs3.getString(1)));
		if(svsPaoExpupto.toString()==null || svsPaoExpupto.toString().equals("null")){
			svsPaoExpupto.delete(0,svsPaoExpupto.length());
			svsPaoExpupto.append("0.0");
		}
		//////System.out.println("svsPaoExpupto:"+svsPaoExpupto);
		
		p1=Double.parseDouble(svsPaoExpupto.toString());
		Double bankpaoupto=d1+p1;
		expUpto+=bankpaoupto;
		
		
		/******************************************************/
		svsCurrentExp.delete(0,svsCurrentExp.length());
	    svsCurrentExp.append((String)svsExpCurrenMonHash.get(rs3.getString(1)));
		if(svsCurrentExp.toString()==null || svsCurrentExp.toString().equals("null")){
			svsCurrentExp.delete(0,svsCurrentExp.length());
			svsCurrentExp.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsExpupto);
		d2=Double.parseDouble(svsCurrentExp.toString());
		
		
		
/******************************************************/
		svsPaoCurrentExp.delete(0,svsPaoCurrentExp.length());
		svsPaoCurrentExp.append((String)svsPaoExpCurrenMonHash.get(rs3.getString(1)));
		if(svsPaoCurrentExp.toString()==null || svsPaoCurrentExp.toString().equals("null")){
			svsPaoCurrentExp.delete(0,svsPaoCurrentExp.length());
			svsPaoCurrentExp.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsExpupto);
		p2=Double.parseDouble(svsPaoCurrentExp.toString());
		Double bankpaocurrent=d2+p2;
		
		expCurrent+=bankpaocurrent;
		
		
/******************************************************/
		svsTotExp.delete(0,svsTotExp.length());
		svsTotExp.append((String)svsTotExpHash.get(rs3.getString(1)));
		if(svsTotExp.toString()==null || svsTotExp.toString().equals("null")){
			svsTotExp.delete(0,svsTotExp.length());
			svsTotExp.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsExpupto);
		d3=Double.parseDouble(svsTotExp.toString());
		
		
		
/******************************************************/
		svsPaoTotExp.delete(0,svsPaoTotExp.length());
		svsPaoTotExp.append((String)svsPaoTotExpHash.get(rs3.getString(1)));
		if(svsPaoTotExp.toString()==null || svsPaoTotExp.toString().equals("null")){
			svsPaoTotExp.delete(0,svsPaoTotExp.length());
			svsPaoTotExp.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsExpupto);
		p3=Double.parseDouble(svsPaoTotExp.toString());
		
		Double bankpaotot=d3+p3;
		expTot+=bankpaotot;
		
		 style.delete(0,style.length());
		 if(styleCount%2==0){
			 style.append("gridbg1");
		 }else{
			
			 style.append("gridbg2");
		 }
		 styleCount++;
		  %>
		  
		  <tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
		  <td class="<%=style %>" style="text-align: left;" ><%=rs3.getString(2) %></td>
		  <td class="<%=style %>"  style="text-align: right;"><%=spillHabs %></td>
		  <td class="<%=style %>" style="text-align: right;"><%=ndf.format(targetEst)%></td>
		  
		  <td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_rfd_svs_target_ach_rpt_drill.jsp?dcode=<%=rs3.getString(1) %>&type=2')"><%=svsTargetHabs %></a></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(bankpaoupto) %></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(bankpaocurrent) %></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(bankpaotot) %></td></tr>
		  
		  
		  <% 
		  
		  
	  }
	  
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	  <td style="text-align: right;"  class="gridhdbg"  ><%=gspillHabs %></td>
	  <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gtargetEst) %></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=svsH %></td>
	  <td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expUpto) %></td>
	  <td class="gridhdbg" style="text-align: right;" ><%=ndf.format(expCurrent) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(expTot) %></td></tr>
	  
	  <% 
	  Query.delete(0,Query.length());
	  Query.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+selectedProgramsFin.toString()+") order by 2 ");
	  ////System.out.println("fin"+programmeQuery);
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(Query.toString());
	  programmeNames.delete(0,programmeNames.length());
	  while(rs4.next()){
		  programmeNames.append(rs4.getString(1));
		  
		  programmeNames.append(",  ");
	  }
	  
	  
	  Query.delete(0,Query.length());
	  Query.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+selectedProgramsPhy.toString()+") order by 2 ");
	  ////System.out.println("phy"+programmeQuery1);
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(Query.toString());
	  programmeNames1.delete(0,programmeNames1.length());
	  while(rs4.next()){
		  programmeNames1.append(rs4.getString(1));
		  
		  programmeNames1.append(",  ");
	  }
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 
 

</table>
                                 <table>
                            <tr><td  style="text-align: left;"><font color="red"><b>Note:Schemes:</font><font color="green">PWS,CPWS,MPWS</font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Financial Grants:</font><font color="green"><%=programmeNames %></b></font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Physical Grants:</font><font color="green"><%=programmeNames1 %></b></font></td></tr>
                            </table>
                            
</body>
</html>
