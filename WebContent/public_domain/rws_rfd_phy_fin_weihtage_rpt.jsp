<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");

//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
loggedUser.append(user.getUserId());
//////System.out.println("loggedUser:::::::::::::::::::::"+loggedUser.toString());
//String dcode="";

  StringBuffer pname=new StringBuffer();
  
  StringBuffer financialstartyr=new StringBuffer();

	
	if(request.getParameter("pname")!=null)
	{
	pname.append(request.getParameter("pname"));
	session.setAttribute("pname",pname);
	}

	if(request.getParameter("finyear")!=null)
	{
	financialstartyr.append(request.getParameter("finyear"));
	session.setAttribute("financialstartyr",financialstartyr);
	}
  	//System.out.println("financialyr>>>>>>>>>>>>>......"+financialstartyr.toString());
    //schemes
//String scheme="";
  StringBuffer scheme=new StringBuffer();
  scheme.append("");
  
  if(request.getParameterValues("scheme")!=null)
  {
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
		
	 scheme.append(schemes[i]+",");
	}
	//scheme.delete(0,scheme.length());
	scheme.append(scheme.substring(0,scheme.length()-1));
	session.setAttribute("scheme",scheme);
}
    //System.out.println("scheme::"+scheme);
	//String startyr =financialstartyr.substring(0,4);
	
	StringBuffer startyr=new StringBuffer();
	startyr.append(financialstartyr.substring(0,4));
	 System.out.println("startyr::"+startyr.toString());
	
	 
	 //String endyr =financialstartyr.substring(5,9);
	StringBuffer endyr=new StringBuffer();
	endyr.append(financialstartyr.substring(5,9));
	 System.out.println("endyr::"+endyr.toString());
	 
	 
	 
	String[] programes=request.getParameterValues("program");
    StringBuffer programe=new StringBuffer();
    programe.append("");
	
	for(int i=0;i<programes.length;i++)
	{
	programe.append(programes[i]+",");
	}
	////System.out.println("programe::"+programe);
	//programe.delete(0,programe.length());
	programe.append(programe.substring(0,programe.length()-1));
	session.setAttribute("programe",programe);
	//System.out.println("programe::"+programe);



StringBuffer dcode=new StringBuffer();

if(loggedUser.toString().substring(0,3).equals("col"))
{
	dcode=(StringBuffer)session.getAttribute("district");    
}

StringBuffer cYear=new StringBuffer();
cYear.append(w.getServerDate().substring(6,10));


StringBuffer currentMonth=new StringBuffer();
currentMonth.append(RwsUtils.getCurrentMont());



//String nextYear=String.valueOf(Integer.parseInt(cYear)+1);
StringBuffer nextYear=new StringBuffer();
nextYear.append(String.valueOf(Integer.parseInt(cYear.toString())+1));


//String prevmonth=RwsUtils.getPreviousMonth();
StringBuffer prevmonth=new StringBuffer();
prevmonth.append(RwsUtils.getPreviousMonth());




int nYear=Integer.parseInt(cYear.toString());
nYear+=1;



//String nextMonth=RwsUtils.getNextMonth();
StringBuffer nextMonth=new StringBuffer();
nextMonth.append(RwsUtils.getNextMonth()).toString();

//String phyprogrammeNames="";
StringBuffer phyprogrammeNames=new StringBuffer();
StringBuffer schemesNames=new StringBuffer();
prevmonth.toString().toUpperCase();

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

    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	<head>
    
</head>
<body>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back | &nbsp; </td>
	  <td><a href="./rws_rfd_phy_fin_weihtage_excel.jsp">Excel</a></td>  
	</tr>  
	</table>
	</caption>
	  
	</table>
					<table  width="80%" border=0 style="border-collapse:collapse"  align=center>
                                            
                                         
<tr >
		<td align="center" class="gridhdbg" colspan=16 ><font color="white"><b>Schemes - (Physical & Financial)<%=startyr.toString() %>-<%=endyr %></b></font></td>	
	</tr>		
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
		<td class="gridhdbg"  colspan=2 align=center>Works</td>
		<td class="gridhdbg"  colspan=2 align=center>Grounded Works</td>
<td class="gridhdbg"  align=center colspan=4  >Financial(<%=startyr.toString() %>-<%=endyr %>) <br></br><font color="red"><b>Amount In Lakhs.</b></font></td>
<td class="gridhdbg" colspan="4" align=center >Physical (<%=startyr.toString() %>-<%=endyr %>) <br><font color="red"><b>Amount In Lakhs.</b></font></br></td>
<td class="gridhdbg"  rowspan="2" align=center >Total Weightage</td>
</tr>
<tr>
<td class="gridhdbg"  align="center"  >No (Spill+New)</td>
 <td  class="gridhdbg" align="center"  >Est Cost</td>	
<td class="gridhdbg"  align="center"  >No (Spill+New)</td>
 <td  class="gridhdbg" align="center"  >Est Cost</td>	

 <td class="gridhdbg"  align="center"  >Target</td><!--
 <td  class="gridhdbg"  align="center"  >Exp.Achievement</td>
  --><td  class="gridhdbg"  align="center"  >Releases Achievement</td>
  
<td class="gridhdbg"  align=center >Percentage Achieved<br>(7 vs 8)</td>
 <td  class="gridhdbg" align="center"  >Weightage(15)</td>
 <td class="gridhdbg"  align="center"  >Target</td>
 <td  class="gridhdbg"  align="center"  >Achievement</td>
 <td class="gridhdbg"  align=center >Percentage Achieved</td>
 <td  class="gridhdbg" align="center"  >Weightage(15)</td>
 	
</tr>

<tr><td class="gridhdbg"   align=center>1</td>
<td class="gridhdbg"   align=center>2</td>
<td class="gridhdbg"   align=center>3</td>
<td class="gridhdbg"   align=center>4</td>
<td class="gridhdbg"   align=center>5</td>
<td class="gridhdbg"   align=center>6</td>
<td class="gridhdbg"   align=center>7</td>
<td class="gridhdbg"   align=center>8</td>
<td class="gridhdbg"   align=center>9</td>
<td class="gridhdbg"   align=center>10</td>
<td class="gridhdbg"   align=center>11</td>
<td class="gridhdbg"   align=center>12</td>
<td class="gridhdbg"   align=center>13</td>
<td class="gridhdbg"   align=center>14</td>
<td class="gridhdbg"   align=center>15</td>
<!--<td class="gridhdbg"   align=center>16</td>

		--></tr>

<% 

 Statement stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null;
StringBuffer programmeNames=new StringBuffer();
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	  /* //String selectedProgramsFin="'01','02','18','23','32','48','49','51','58','59','60','04','57','65','46','12','50','70'";
	  StringBuffer selectedProgramsFin=new StringBuffer();
	  selectedProgramsFin.append("'01','02','18','23','32','48','49','51','58','59','60','04','57','65','46','12','50','70'");
	 
	  //String selectedProgramsPhy="'01','02','18','23','32','48','49','51','58','04','57','65','46','12','70'";
	  StringBuffer selectedProgramsPhy=new StringBuffer();
	  selectedProgramsPhy.append("'01','02','18','23','32','48','49','51','58','04','57','65','46','12','70'");
	  
	  //String scheme="'01','02','03'";
	  /* StringBuffer scheme=new StringBuffer();
	  scheme.append("'01','02','03'");
	 */ 
	  
	  StringBuffer qry1=new StringBuffer();
	  
	  
	  qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
	  qry1.append("and w.type_of_asset in("+scheme.toString()+")");
	  qry1.append(" and  w.programme_code in ("+programe.toString()+") group by d.dcode");
      System.out.println("spillOverWorks"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
		
		
				 
		/*
		        Grounded Works and their sanction amount
		*/
		
		
		stmt2=conn.createStatement();
		
		qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,RWS_WORK_COMMENCEMENT_TBL  com     where to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id  and com.GROUNDING_DATE is not null and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
		qry1.append("and w.type_of_asset in("+scheme.toString()+")");
		qry1.append("and  w.programme_code in ("+programe.toString()+") group by d.dcode");

	  	System.out.println("spillOverGroundWorks"+qry1.toString());
	  	 rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksGroundedHash=new Hashtable();
	  	while(rs2.next())
	  	{
	  		  	
	  		spillOverWorksGroundedHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  		////////System.out.println("spillOverGroundWorks"+rs2.getString(1)+"@"+rs2.getString(2)+"@"+rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0,qry1.length());
		/*
        Grounded Works and their sanction amount
*/


stmt2=conn.createStatement();

qry1.append("select d.dcode,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl   hb ,RWS_WORK_COMMENCEMENT_TBL com    where hb.work_id=w.work_id and to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
qry1.append(" and w.type_of_asset in("+scheme.toString()+")");
qry1.append(" and  w.programme_code in ("+programe.toString()+") group by d.dcode");

	System.out.println("spillOverGroundHabs"+qry1.toString());
	 rs2=stmt2.executeQuery(qry1.toString());

	Hashtable spillOverGroundedHabsHash=new Hashtable();
	while(rs2.next()){
		  	
		spillOverGroundedHabsHash.put(rs2.getString(1),rs2.getString(2));
	}



if(rs2!=null)rs2.close();
if(stmt2!=null)stmt2.close();
qry1.delete(0,qry1.length());		
		
		
	  
stmt2=conn.createStatement();
		
qry1.append("select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr.toString()+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp  where  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
qry1.append("and w.type_of_asset in("+scheme.toString()+")");
qry1.append(" and  w.programme_code in ("+programe.toString()+") group by d.dcode");

	  	System.out.println("spillOverExpWorks"+qry1.toString());
	  
	  	rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksExpHash.put(rs2.getString(1),rs2.getString(2));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		qry1.delete(0,qry1.length());
		
		
		/**
		   Grounded Exp
		*/
		

		  
		stmt2=conn.createStatement();
				
		qry1.append("select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr.toString()+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,RWS_WORK_COMMENCEMENT_TBL  comm  where  w.work_id=comm.work_id and comm.GROUNDING_DATE is not null and  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
		qry1.append("and w.type_of_asset in("+scheme.toString()+")");
		qry1.append(" and  w.programme_code in ("+programe.toString()+") group by d.dcode");

			  	System.out.println("spillOverExpWorks"+qry1.toString());
			  
			  	rs2=stmt2.executeQuery(qry1.toString());
			  
			  	Hashtable spillOverGroundedWorksExpHash=new Hashtable();
			  	while(rs2.next()){
			  		  	
			  		spillOverGroundedWorksExpHash.put(rs2.getString(1),rs2.getString(2));
			  	}
			  
			  
			  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		qry1.delete(0,qry1.length());
		//new works
			
		 stmt2=conn.createStatement();
		 	 
		 qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where  (w.ADMIN_DATE >= '01-Apr-"+startyr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+endyr.toString()+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null");
		 qry1.append(" and w.type_of_asset in("+scheme.toString()+")");
		 qry1.append(" and  w.programme_code in ("+programe.toString()+") group by d.dcode ");

		  	System.out.println("newWorks"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable newWorksHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		newWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		qry1.delete(0, qry1.length());	
			
			 stmt2=conn.createStatement();
		 	 
			 qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, RWS_WORK_COMMENCEMENT_TBL  com  where w.work_id =com.work_id and  com.GROUNDING_DATE is not null and   (w.ADMIN_DATE >= '01-Apr-"+startyr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+endyr.toString()+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null   ");
			 qry1.append("and w.type_of_asset in("+scheme.toString()+")");
			 qry1.append("and  w.programme_code in ("+programe.toString()+") group by d.dcode ");

			  	System.out.println("newWorks"+qry1.toString());
			  	 rs2=stmt2.executeQuery(qry1.toString());
			  
			  	Hashtable newGroundedWorksHash=new Hashtable();
			  	while(rs2.next())
			  	{
			  		  	
			  		newGroundedWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
			  	}
			  
			  
			  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		qry1.delete(0,qry1.length());
		
		
		
	  stmt2=conn.createStatement();
	  Hashtable svsCovhabsHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d,rws_complete_hab_view ch  where ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' ) and a.WORK_CANCEL_DT is null  and  a.type_of_asset in('01','02','03')   and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.toString()+") group by d.dcode,d.dname order by d.dcode");
	  System.out.println("Q1:"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
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
	  qry1.delete(0,qry1.length());
	 
	  
	  
	  
	  stmt4=conn.createStatement();
	  Hashtable svsTotExpHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,(sum(voucher_Amt)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_work_exp_voucher_tbl v  where  a.WORK_CANCEL_DT is null     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.toString()+") and to_date(v.voucher_dt,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.voucher_dt,'dd/mm/yy')<'01-APR-"+endyr.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	  
	   System.out.println("exp.achiv....:"+qry1.toString());
	  rs4=stmt4.executeQuery(qry1.toString());
	  while(rs4.next())
	  {
		  svsTotExpHash.put(rs4.getString(1),rs4.getString(3));
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  qry1.delete(0, qry1.length());
	   
	  
	  
	  
	  stmt4=conn.createStatement();
	  Hashtable svsTotRelExpHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,sum(case when to_date(BANK_SEND_DATE) >= '01-Apr-"+startyr.toString()+"' and to_date(BANK_SEND_DATE) < '01-Apr-"+endyr.toString()+"' and TXID  is not null  then (BILL_AMOUNT_CENTRAL)/100000  else 0 end),sum(case when to_date(STATE_SEND_DATE) >= '01-Apr-"+startyr.toString()+"'  and to_date(STATE_SEND_DATE) < '01-Apr-"+endyr.toString()+"' and STATE_TXID  is not null  then (BILL_AMOUT_STATE)/100000   else 0 end)  from rws_work_admn_tbl a,rws_district_tbl d, rws_bill_bank_bridge_tbl v  where  a.WORK_CANCEL_DT is null     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.toString()+")  group by d.dcode,d.dname order by d.dcode");
	  
	   System.out.println("exp.achiv....:"+qry1.toString());
	  rs4=stmt4.executeQuery(qry1.toString());
	  while(rs4.next())
	  {
		  svsTotRelExpHash.put(rs4.getString(1),rs4.getString(3)+"@"+rs4.getString(4));
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  qry1.delete(0, qry1.length());
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  //Printing Report....
	  
	  
	  qry1.append("select d.dcode,d.dname,t.MVS_HABS,(t.MVS_EXP*100),(t.SVS_EXP*100),t.SVS_HABS  from rws_district_tbl d , rws_work_sch_target_tbl t where t.dcode=d.dcode and FIN_YEAR='"+financialstartyr+"'");
	  if(dcode.toString()!=null && !dcode.toString().equals(""))
	  {
		  qry1.append(" and d.dcode='"+dcode.toString()+"'");
	  }
	  qry1.append("order by d.dcode");
	  System.out.println("main:"+qry1.toString());
	  rs3=stmt3.executeQuery(qry1.toString());
	  double svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0,expTot1=0;
	  
	  StringBuffer  style=new StringBuffer();
	  
	  int styleCount=0;
	  double d1=0,d2=0,d3=0;
	  double ghabper = 0;
	  double  svsHg=0.0,svsTg=0.0;
	  double gexpper = 0;
		 
		 Statement sst1=conn.createStatement();
		  //Statement sst=conn.createStatement();
//String deleteQuery="delete from rws_svs_graph_view_tbl WHERE TYPE='MVS'";
		  
	//	  sst.executeUpdate(deleteQuery);
		 
	int gtotWorks=0,gnWorkCount=0,gphyTarget=0,gPhyAch=0,gtargetWorks=0,gspillHabs=0;
	double gtotalBalEst=0,ggroundedBalEst=0;
	double gfinTarget=0,gfinAch=0,grelAch=0;
	double gtotWeightage=0;
	StringBuffer key=new StringBuffer();
	StringBuffer expStr=new StringBuffer();
	StringBuffer str=new StringBuffer();
	StringBuffer spillWorks=new StringBuffer();
	StringBuffer a1=new StringBuffer();
	StringBuffer a2=new StringBuffer();
	StringBuffer nWorks=new StringBuffer();
	StringBuffer svsTargetHabs=new StringBuffer();
	StringBuffer svsTotExp=new StringBuffer();
	StringBuffer qry2=new StringBuffer();
	StringBuffer svsTotRelExp=new StringBuffer();
	  while(rs3.next())
	  {
		  double exp=0,spillSanctionedAmt=0,newSanctionedAmt=0,finTarget=0,phyAchPer=0,finAchPer=0,spillGroundedAmount=0,newGroundedAmount=0,groundedexp=0;
		  int sWorkCount=0,nWorkCount=0,phyTarget=0;
		  int spilGrounded=0,newGrounded=0,spillHabs=0;
		  double bankamt=0,paoamt=0;
		  
		  finTarget=(Double.parseDouble(rs3.getString(4))+Double.parseDouble(rs3.getString(5)));
		  phyTarget=(Integer.parseInt(rs3.getString(3))+Integer.parseInt(rs3.getString(6)));
		  
		 //String key=rs3.getString(1);
		  key.delete(0, key.length());
		  key.append(rs3.getString(1));
		  
		  if(spillOverWorksExpHash.get(key.toString())!=null)
		  {
			  ////System.out.println("111111111111");
			  expStr.delete(0,expStr.length());
			  expStr.append(spillOverWorksExpHash.get(key.toString()));
			  if(expStr.toString()!=null && !expStr.toString().equals("null"))
			  {
			   exp=Double.parseDouble(expStr.toString());
			  }
			  
		  }
		  
		 if(spillOverGroundedWorksExpHash.get(key.toString())!=null)
		 {
			
			  expStr.delete(0,expStr.length());
			  expStr.append(spillOverGroundedWorksExpHash.get(key.toString()));
			  if(expStr.toString()!=null && !expStr.toString().equals("null"))
			  {
			  groundedexp=Double.parseDouble(expStr.toString());
			  }
			  
		  }
		  
		
         if(spillOverGroundedHabsHash.get(key.toString())!=null)
         {
        	 ////System.out.println("13333333333333333");
        	 str.delete(0,str.length());
        	 str.append(spillOverGroundedHabsHash.get(key.toString()));
        	 spillHabs=Integer.parseInt(str.toString());
         	 
         }
 
		
		
			if(spillOverWorksHash.get(key.toString())!=null )
			{
				////System.out.println("444444444444444444");
				spillWorks.delete(0,spillWorks.length());
				spillWorks.append(spillOverWorksHash.get(key.toString()));
				String []aa=spillWorks.toString().split("@");
				
				if(aa[0]!=null && !aa[0].toString().equals("null") ){
					sWorkCount=Integer.parseInt(aa[0].toString());
				}
				if(aa[1]!=null && !aa[1].toString().equals("null")){
					spillSanctionedAmt=Double.parseDouble(aa[1].toString());
				}

			}
			
			if(newWorksHash.get(key.toString())!=null )
			{
				////System.out.println("555555555555555555555");
				nWorks.delete(0,nWorks.length());
				nWorks.append(newWorksHash.get(key.toString()));
				String []aa=nWorks.toString().split("@");
				
				
				if(aa[0]!=null && !aa[0].toString().equals("null")){
					nWorkCount=Integer.parseInt(aa[0].toString());
				}
				if(aa[1]!=null && !aa[1].toString().equals("null")){
					newSanctionedAmt=Double.parseDouble(aa[1].toString());
				}

			}  
			
			
			if(spillOverWorksGroundedHash.get(key.toString())!=null )
			{
				////System.out.println("6666666666666666666");
				spillWorks.delete(0,spillWorks.length());
				spillWorks.append(spillOverWorksGroundedHash.get(key.toString()));
				String []aa=spillWorks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					spilGrounded=Integer.parseInt(a1.toString());
				}
				
				a2.delete(0,a2.length());
				a2.append(aa[1]);
				if(a2.toString()!=null && !a2.toString().equals("null"))
				{
					spillGroundedAmount=Double.parseDouble(a2.toString());
				}
				
				////System.out.println("spillGroundedAmount:"+spillGroundedAmount);
			}
			
			
			if(newGroundedWorksHash.get(key.toString())!=null )
			{
				////System.out.println("7777777777777777771");
				nWorks.delete(0,nWorks.length());
				nWorks.append(newGroundedWorksHash.get(key.toString()));
				String []aa=nWorks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					newGrounded=Integer.parseInt(a1.toString());
				}
				
				a2.delete(0,a2.length());
				a2.append(aa[1]);
				if(a2.toString()!=null && !a2.toString().equals("null"))
				{
					newGroundedAmount=Double.parseDouble(a2.toString());
				}
				////System.out.println("newGroundedAmount:"+newGroundedAmount);
			}  
			
			
			double totalBalEst=(spillSanctionedAmt+newSanctionedAmt)-exp;
			double groundedBalEst=(spillGroundedAmount+newGroundedAmount)-groundedexp;
			
			////System.out.println("groundedBalEst:"+groundedBalEst);
			ggroundedBalEst+=groundedBalEst;
			gspillHabs+=spillHabs;
			
			gtotalBalEst+=totalBalEst;
			int totWorks=sWorkCount+nWorkCount;
			gtotWorks+=totWorks;
			int targetWorks=spilGrounded+newGrounded;
		  
		  
			
		 svsTargetHabs.delete(0,svsTargetHabs.length());
		 svsTargetHabs.append(svsCovhabsHash.get(rs3.getString(1)));
		 if(svsTargetHabs.toString()==null || svsTargetHabs.toString().equals("null"))
		 { 
			 svsTargetHabs.delete(0,svsTargetHabs.length());
			 svsTargetHabs.append("0");
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs.toString());
		 svsHg+=svsH;
		 
		 
		/******************************/
		
		
		 
		if(rs3.getString(3)!=null)
		{
			svsT+=Integer.parseInt(rs3.getString(3));
			svsTg+=svsT;
		}
		if(rs3.getString(4)!=null)
		{
			expT+=Double.parseDouble(rs3.getString(4));
		}
		
		
		/******************************************************/
		
				
/******************************************************/
		svsTotExp.delete(0,svsTotExp.length());
		svsTotExp.append(svsTotExpHash.get(rs3.getString(1)));
		
		if(svsTotExp.toString()==null || svsTotExp.toString().equals("null"))
		{
			svsTotExp.delete(0,svsTotExp.length());
			svsTotExp.append("0.0");
		}
		////System.out.println("svsExpupto:"+svsTotExp.toString());
		if(svsTotExp.toString()!=null || !svsTotExp.toString().equals("null"))
		{
		 d3=Double.parseDouble(svsTotExp.toString());
		}
		else
		{
			d3=0;
		}
		
		////////////////////////Releases Achievement//////////////////////////
		
		
		svsTotRelExp.delete(0,svsTotRelExp.length());
		svsTotRelExp.append(svsTotRelExpHash.get(rs3.getString(1)));
		
		if(svsTotRelExp.toString()!=null && !svsTotRelExp.toString().equals("null"))
		{
			String []aa=svsTotRelExp.toString().split("@");
			
			if(aa[0].toString()!=null && !aa[0].toString().equals("null"))
			{
				bankamt=Double.parseDouble(aa[0].toString());
			}
			else
			{
				bankamt=0;
			}
			
			if(aa[1].toString()!=null && !aa[1].toString().equals("null"))
			{
				paoamt=Double.parseDouble(aa[1].toString());
			}
			else
			{
				paoamt=0;
			}
		}
		
		////System.out.println("svsRelsExpupto:"+bankamt+paoamt);
		
		
		
		
		
		
		//////////////////////////////////////////////////////////////////////
		
		expTot+=d3;
		
		expTot1+=bankamt+paoamt;
		double targetExp=0,targetHabs=0;
		double weightage=0,totWeightage=0,weightageFin=0;
		if(rs3.getString(4)!=null)
		{
		 targetExp=Double.parseDouble(rs3.getString(4));
		}
		
		if(rs3.getString(3)!=null)
		{
		 targetHabs= Double.parseDouble(rs3.getString(3));
		}
		
		int coveredhabs=Integer.parseInt(svsTargetHabs.toString());
		
		gfinTarget+=finTarget;
		gphyTarget+=phyTarget;
		
		gfinAch+=(bankamt+paoamt);
		grelAch+=bankamt+paoamt;
		gPhyAch+=coveredhabs;
		
		if((bankamt+paoamt)>0)
		{
		finAchPer = ((bankamt+paoamt) * 100/ groundedBalEst);
		}
		else
		{
			finAchPer=0;
		}
		
		
		//System.out.println("finAchPer:"+d3+"...."+groundedBalEst);
		if(coveredhabs>0)
		{
		 phyAchPer = ((double)coveredhabs * 100/ (double)spillHabs);
		}
		else
		{
			phyAchPer=0;
		}
		if(phyAchPer>0)
		{
	    weightage=(phyAchPer/ 100)*15;
		}
		else
		{
			weightage=0;
		}
	    if(finAchPer>0)
	    {
	    	weightageFin=(finAchPer/ 100)*15;
	    }
	    else
		{
	    	weightageFin=0;
		}
		
		//System.out.println("finAchPer:"+finAchPer);
		
		totWeightage=(weightage+weightageFin);
		gtotWeightage+=totWeightage;
		gtargetWorks+=targetWorks;
		
		
		 if(styleCount%2==0)
		 {   style.delete(0,style.length());
			 style.append("gridbg1");
		 }else
		 {   style.delete(0,style.length());
			 style.append("gridbg2");
		 }
		 styleCount++;
		   
		 
		  %>
		  
		  <tr><td class="<%=style.toString()  %>" style="text-align: left;"><%=count++ %></td><td class="<%=style.toString() %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=totWorks %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(totalBalEst) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=targetWorks %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(groundedBalEst) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(groundedBalEst) %></td><!--
		  
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(d3) %></td>
		  --><td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(bankamt+paoamt) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(finAchPer) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(weightageFin) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=spillHabs %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=svsTargetHabs.toString() %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(phyAchPer) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(weightage) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(totWeightage) %></td></tr>
		  
		  
		  <% 
		  
		  
	  }
	  double gFinPer=0,gPhyAcc=0,weightage=0,weightageFin=0;
	  
	  
	    if(gfinAch>0)
	    {
		  gFinPer = (gfinAch * 100/ ggroundedBalEst);
	    }
	    else
	    {
	    	 gFinPer=0;
	    }
	    
	    
	    if(gPhyAch>0)
	    { 
	      gPhyAcc = ( (double)gPhyAch * 100/ (double)gspillHabs);
	    }
	    else
	    {
	    	gPhyAch=0;
	    }
	    
	    
	    if(gPhyAcc>0)
	    {  
	    weightage=(gPhyAcc/ 100)*15;
	    }
	    else
	    {
	    	weightage=0;
	    }
	    
	    
	    if(gFinPer>0)
	    { 
	      weightageFin=(gFinPer/ 100)*15;
	    }
	    else
	    {
	    	weightageFin=0;
	    }
		
	  
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	  <td style="text-align: right;"  class="gridhdbg"  ><%=gtotWorks %></td>
	  <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gtotalBalEst) %></td>
	  
	  
	  <td class="gridhdbg"  style="text-align: right;"><%=gtargetWorks %></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ggroundedBalEst) %></td>
	  	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ggroundedBalEst) %></td><!--
	  <td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gfinAch) %></td>
	   --><td class="gridhdbg" style="text-align: right;" ><%=ndf.format(grelAch) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(gFinPer) %></td>
	    <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(weightageFin) %></td>
	    <td class="gridhdbg" style="text-align: right;" > <%=gspillHabs %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=gPhyAch %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(gPhyAcc) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(weightage) %></td>
	  <td class="gridhdbg" style="text-align: right;" > <%=ndf.format(gtotWeightage) %></td>
	  
	  
	
	  
	  </tr>
	  
	  <% 
	 
	  
	  qry2.delete(0,qry2.length());
	  qry2.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+programe.toString()+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  while(rs4.next())
	  {
		  //programmeNames.delete(0, programmeNames.length());
		  programmeNames.append(rs4.getString(1));		  
		  programmeNames.append(",  ");
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  qry2.delete(0, qry2.length());
	  
      qry2.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+programe.toString()+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  
	  while(rs4.next())
	  {   
		  //phyprogrammeNames.delete(0, phyprogrammeNames.length());
		  phyprogrammeNames.append(rs4.getString(1));
		  phyprogrammeNames.append(",  ");
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  qry2.delete(0, qry2.length());
     
	  qry2.append("select TYPE_OF_ASSET_NAME  ,TYPE_OF_ASSET_code  from rws_asset_type_tbl where TYPE_OF_ASSET_code in ("+scheme.toString()+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  
	  while(rs4.next())
	  {   
		  //phyprogrammeNames.delete(0, phyprogrammeNames.length());
		  schemesNames.append(rs4.getString(1));
		  schemesNames.append(",");
	  } 
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  
  }catch(Exception e)
  {
  e.printStackTrace();
}finally

{
	 
}
  
  

 %>


 </table>  
 <table>


 <tr><td  style="text-align: left;"><font color="red"><b>Note:Schemes:</font><font color="green"><%=schemesNames.toString() %></font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Financial Grants:</font><font color="green"><%=programmeNames.toString()%></b></font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Physical Grants:</font><font color="green"><%=phyprogrammeNames.toString() %></b></font></td></tr>
      </table>
</body>
</html>
