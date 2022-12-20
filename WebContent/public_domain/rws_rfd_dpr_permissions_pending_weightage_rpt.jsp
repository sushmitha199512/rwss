<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


<%
//Percentage = (Obtained score x 100) / Total Score
//percentage = (score * 100/ total);

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();

String dcode="";
if(loggedUser.substring(0,3).equals("col")){
	dcode=(String)session.getAttribute("district");    
   }
//22/08/2013
//System.out.println("Server Date:"+w.getServerDate());

String cYear=w.getServerDate().substring(6,10);


String currentMonth=RwsUtils.getCurrentMont();

if(currentMonth!=null&& !(currentMonth.equals("APR") || currentMonth.equals("MAY") || currentMonth.equals("JUN")
		|| currentMonth.equals("JUL")
		|| currentMonth.equals("AUG")
		|| currentMonth.equals("SEP")
		|| currentMonth.equals("OCT")
		|| currentMonth.equals("NOV")
		|| currentMonth.equals("DEC")

)){
	int tempYear=Integer.parseInt(cYear);
	tempYear-=1;
	cYear=String.valueOf(tempYear);
	
}



String prevmonth=RwsUtils.getPreviousMonth();

int nYear=Integer.parseInt(cYear);
int pYear=nYear-1;
nYear+=1;
String finYear="";

String nextMonth=RwsUtils.getNextMonth();

//System.out.println("DDED");

    prevmonth=prevmonth.toUpperCase();
	DecimalFormat ndf = new DecimalFormat("####.##");
    DecimalFormat ndf1 = new DecimalFormat("##");



	%>
	<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
       <link href="<rws:context page='/resources/HabScoreCardDesign/Style.css' />" rel="stylesheet" type="text/css" />
    <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Header.js' />"></script>
</head>
	<html>
	<body>
	
    <table width="1004" border="0" cellspacing="0" cellpadding="0" style="border-left: 1px #b0ffeb solid;
        border-right: 1px #b0ffeb solid;" align="center">
    
        <tr>
            <td style="padding-left: 2px; padding-right: 2px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr>
                        <td align="center" valign="top" bgcolor="#f5f5f5" height="348" style="padding: 4px;">
                            <table border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="padding: 4px;" width="650">
                                        

			<table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td style="padding: 4px;" >




				    </td>
				</tr>
<tr>
<td height="20"></td>

<tr><td align="right" class="bwborder" colspan="2"><a href="/pred/home.jsp?loginMode=watersoft">Home</a>&nbsp;|&nbsp;
                    <a href="rws_rfd_dpr_permissions_pending_weightage_excel.jsp" target="_new">Excel</a></td></tr>       

				<tr>
                                    <td style="padding: 4px;" bgcolor="#02865c">

<!-- Grid Table Starts -->                                      

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            
                                         
<tr bgcolor="#8A9FCD">
		<td align="center" class="gridhdbg" colspan=13><font color="white"><b>DPR Permissions Report&nbsp;<%=cYear %>-<%=nYear %></b></font></td>	
	</tr>
		<tr >
		<td class="gridhdbg"  rowspan=2 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=2 align=center>District</td>
<td class="gridhdbg"  align=center colspan=2 nowrap >Works <br></br><font color="red"><b>.</b></font></td>
<td class="gridhdbg" colspan=6 align=center > <br><font color="red"><b></b></font></br></td>
 
</tr>
<tr>
<td class="gridhdbg"  align="center"  >Total Works</td>
 <td  class="gridhdbg" align="center"  >Est.Cost</td>	
 <td class="gridhdbg"  align="center"  >No. of works for which permissions pending</td>
 
 <td  class="gridhdbg"  align="center"  >Work Wise Obtained</td>
  <td class="gridhdbg"  align="center"  >permissions pending target</td>
 <td  class="gridhdbg"  align="center"  >Permissions cleared(Obtained achi)</td>
 <td  class="gridhdbg"  align="center"  >Percentage</td>
 <td  class="gridhdbg"  align="center"  >Weightage</td>
 
 	
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


	</tr>

<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt33=null,stmt44=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs23=null,rs44=null,rs5=null,rs6=null,rs7=null;
String programmeNames="";
int count=1;
double sanamount=0,allsumpercentage=0,acheper=0,pendingweight=0,gallsumpercentage=0,gpendingweight=0;
int dprpend=0,dprpendnot=0,ongoingw=0,dprpendtot=0,dprpendtot1=0;
  try{
	  ///Total dpr no
	  String dprlan="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id"; 
	 
	  dprlan+=" and((LANDAQUISITION ='Y')OR(FORESTCLEARANCE ='Y')OR(WATERDRAWLPERMISSION='Y')OR(RAILWAYCROSSINGPERMISSION ='Y')OR(ROADCROSSINGPERMISSIONNHAI='Y')OR(ROADCROSSINGPERMISSIONSTATE='Y')OR(POWERAPTRANSCOREQ ='Y')OR(HMWSSBREQ='Y')OR(OTHERS='Y'))";
	  dprlan+="and work_cancel_dt is null and  a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) ";
	  
	  dprlan+="  group by  substr(b.office_code,2,2) order by 1";
	stmt3=conn.createStatement();
	//System.out.println("dprlan****111**"+dprlan);
		 rs2=stmt3.executeQuery(dprlan);
		Hashtable dprlanper=new Hashtable();
		while(rs2.next())
		{
			dprlanper.put(rs2.getString(2),rs2.getString(1));
		}
	  //
	  
	  
	  //morethan one program is adding
	  	    
	     String dpr331="select sum(a.SANCTION_AMOUNT ),substr(b.office_code,2,2) from rws_work_admn_prog_lnk_tbl a,rws_work_admn_tbl b,RWS_NOTGROUNDWORKS_STATUS_TBL c where c.work_id=a.work_id and b.work_id=c.work_id and  a.work_id=b.work_id and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"'))   ";
	  
		  dpr331+="  group by  substr(b.office_code,2,2) order by 2";
	 Statement stmt333=conn.createStatement();
	//System.out.println("dpr331******KKKKKK"+dpr331);
		 ResultSet rs233=stmt333.executeQuery(dpr331);
		Hashtable dpr333=new Hashtable();
		while(rs233.next())
		{
			dpr333.put(rs233.getString(2),rs233.getString(1));
			
		}
	  
	  //
	  ///Sanction Amount
	  String dprlan1="select sum(b.SANCTION_AMOUNT),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) ";
	  
		  dprlan1+="  group by  substr(b.office_code,2,2) order by 2";
	 stmt33=conn.createStatement();
//	System.out.println("dprlan1******222"+dprlan1);
		 rs23=stmt33.executeQuery(dprlan1);
		Hashtable dprlanper1=new Hashtable();
		while(rs23.next())
		{
			dprlanper1.put(rs23.getString(2),rs23.getString(1));
			
		}
	  //
	  ///Voucher Amount
	  String dprlan11="select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+cYear+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,RWS_NOTGROUNDWORKS_STATUS_TBL c  where c.work_id=exp.work_id and substr(c.work_id,5,2)=d.dcode and c.work_id=w.work_id and  to_date(w.ADMIN_DATE) < '01-Apr-"+cYear+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) and WORK_CANCEL_DT  is null group by d.dcode";

	 stmt44=conn.createStatement();
	//System.out.println("dprlan11******33"+dprlan11);
		 rs44=stmt44.executeQuery(dprlan11);
		Hashtable dprlanper11=new Hashtable();
		while(rs44.next())
		{
			dprlanper11.put(rs44.getString(1),rs44.getString(2));
			
		}
	  //
	 
	  ///work pending bill  is null Amount
	  String pendingbill="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where ";
	  pendingbill+="((LANDAQUISITION ='Y'AND LANDAQUISITIONOBTAINDATE  is null)OR(FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is null)OR(WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is null)OR(RAILWAYCROSSINGPERMISSION ='Y' AND RAILWAYCROSSINGPEROBTAIN is null)OR(ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is null)OR(ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is null)OR(POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is null)OR(HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is null)OR(OTHERS='Y' AND OTHERSOBTAINDATE is null))";

	  pendingbill+="  AND work_cancel_dt is null and a.work_id=b.work_id and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) group by  substr(b.office_code,2,2) order by 2";

	 stmt5=conn.createStatement();
	//System.out.println("pendingbill******444"+pendingbill);
		 rs5=stmt5.executeQuery(pendingbill);
		Hashtable pending=new Hashtable();
		while(rs5.next())
		{
			pending.put(rs5.getString(2),rs5.getString(1));
			
		}
	  //

	  
	  
	  
	  ///pending bill  is not null Amount
	  String pendingbillnot="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b  ";

	  pendingbillnot+=" where ((LANDAQUISITION ='Y' AND LANDAQUISITIONOBTAINDATE  is not null)OR( FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is not  null)OR(WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is not null)OR(RAILWAYCROSSINGPERMISSION ='Y' AND RAILWAYCROSSINGPEROBTAIN is  not null)OR(ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is not null)OR(ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is not  null)OR(POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is not null)OR(HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is not null)OR(OTHERS='Y' AND OTHERSOBTAINDATE is not null)) and";
	  	  
	  pendingbillnot+=" a.work_id=b.work_id and work_cancel_dt is null and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) group by  substr(b.office_code,2,2) order by 2";
	 stmt5=conn.createStatement();
	//System.out.println("pendingbillnot******555"+pendingbillnot);
		 rs5=stmt5.executeQuery(pendingbillnot);
		Hashtable pendingnot=new Hashtable();
		while(rs5.next())
		{
			pendingnot.put(rs5.getString(2),rs5.getString(1));
			
		}
	  //

	  //pending report in all ssum case target
	  
	   String pendingbillsumcase="select sum((case when LANDAQUISITION='Y' and LANDAQUISITIONOBTAINDATE  is null  then 1 else 0 end)+(case when FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is null then 1 else 0 end)+(case when WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is null then 1 else 0 end) +(case when RAILWAYCROSSINGPERMISSION='Y' AND RAILWAYCROSSINGPEROBTAIN is null then 1 else 0 end)+(case when ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is null then 1 else 0 end)+( case when ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is null then 1 else 0 end)+(case when POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is null then 1 else 0 end)+(case when HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is null then 1 else 0 end)+(case when OTHERS='Y' AND OTHERSOBTAINDATE is null then 1 else 0 end)) ,substr(work_id,5,2)  FROM RWS_NOTGROUNDWORKS_STATUS_TBL where DPRCOMPDATE < '01-Apr-"+cYear+"' GROUP BY substr(work_id,5,2) order by 2";

	  	  	  
	  //pendingbillnot+=" a.work_id=b.work_id and work_cancel_dt is null and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+cYear+"')) group by  substr(b.office_code,2,2) order by 2";
	 stmt6=conn.createStatement();
	//System.out.println("pendingbillsumcase******555"+pendingbillsumcase);
		 rs6=stmt6.executeQuery(pendingbillsumcase);
		Hashtable pendingCASE=new Hashtable();
		while(rs6.next())
		{
			pendingCASE.put(rs6.getString(2),rs6.getString(1));
			
		}
	///	targetperallsum=Double.parseDouble(pendingCASE);
	  //
	  
	  
	  
	  
	  //pending report in all SUMCASE OBTINED acheiv
	  
	   String OBTINEDsumcase="select sum((case when LANDAQUISITION='Y' and LANDAQUISITIONOBTAINDATE  is not null  then 1 else 0 end)+(case when FORESTCLEARANCE ='Y' AND FORESTCLEARANCEOBTAINDATE  is not null then 1 else 0 end)+(case when WATERDRAWLPERMISSION='Y' AND WATERDRAWLPERMISSIONOBTAINDATE is not null then 1 else 0 end) +(case when RAILWAYCROSSINGPERMISSION='Y' AND RAILWAYCROSSINGPEROBTAIN is not null then 1 else 0 end)+(case when ROADCROSSINGPERMISSIONNHAI='Y' AND ROADCROSSINGNHAIOBTAINDATE is not null then 1 else 0 end)+( case when ROADCROSSINGPERMISSIONSTATE='Y' AND ROADCROSSINGPEROBTAINDATE  is not null then 1 else 0 end)+(case when POWERAPTRANSCOREQ ='Y' AND POWERAPTRANSCOOBTAINDATE   is not null then 1 else 0 end)+(case when HMWSSBREQ='Y' AND HMWSSBOBTAINDATE is not null then 1 else 0 end)+(case when OTHERS='Y' AND OTHERSOBTAINDATE is not null then 1 else 0 end)) ,substr(work_id,5,2)  FROM RWS_NOTGROUNDWORKS_STATUS_TBL  where  DPRCOMPDATE > '01-Apr-"+cYear+"' GROUP BY substr(work_id,5,2) order by 2";

	  stmt7=conn.createStatement();
	//System.out.println("OBTINEDsumcase******555"+OBTINEDsumcase);
		 rs7=stmt7.executeQuery(OBTINEDsumcase);
		Hashtable obtCASE=new Hashtable();
		while(rs7.next())
		{
			obtCASE.put(rs7.getString(2),rs7.getString(1));
			
		}
	  //

	//  acheper=Integer.parseInt(obtCASE);
	 // allsumpercentage=obtCASE;
	  
	  
	  
	  
	
	  
	  stmt3=conn.createStatement();
	 
	  //Printing Report....
	 
	  String distQuery="select d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16'";
	  if(dcode!=null && !dcode.equals("")){
		  distQuery+=" and d.dcode='"+dcode+"'";
		}
	  distQuery+=" order by d.dcode";
	  rs3=stmt3.executeQuery(distQuery);
	  double svsH=0,svsT=0;
	  
	  double expUpto=0,expT=0,expCurrent=0,expTot=0;
	  String style="";
	  double d1=0,d2=0,d3=0;
	  int styleCount=0;
	  double gexpper = 0;
		double ghabper = 0;
		double s1=0,s2=0,totexp1=0;
		double san=0;
		
		int pendingsumCASE1=0,gpendingsumCASE1=0,obtCASE1=0,gobtCASE1=0;
	
	  while(rs3.next()){
		  
		  
		  //Total No of Works
		 String svsTargetHabs=(String)dprlanper.get(rs3.getString(1));
		 if(svsTargetHabs==null || svsTargetHabs.equals("null")){
			 svsTargetHabs="0";
		 }
		 
		 ongoingw+=Integer.parseInt(svsTargetHabs);
		 
		 
		 //Total Sanction amount
		 String amount=(String)dprlanper1.get(rs3.getString(1));
		// System.out.println("amount"+amount);
		 if(amount==null || amount.equals("null")){
			 sanamount=0;
			 
		 }
		 else
		 {
			 sanamount=Double.parseDouble(amount);
		 }
		 
		 //morethan one program is adding
		 String morethan="";
		 if(dpr333.get(rs3.getString(1))!=null && !dpr333.get(rs3.getString(1)).equals("null")){
		  morethan=(String)dpr333.get(rs3.getString(1));
		 // System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 morethan="0";
		 }
		 san=Double.parseDouble(morethan);
		 sanamount=san+sanamount;
		// System.out.println("sanamountKKKKKKKKKKKKKKKKKKK"+san);
		 //System.out.println("sanamount"+sanamount);
		
		 
		 //voucher
		 String vamount1=(String)dprlanper11.get(rs3.getString(1));
		 //System.out.println("amountHHHHH"+vamount1);
		 if(vamount1==null || vamount1.equals("null")){
			 s1=0;
			 
		 }
		 else
		 {
			 s1=Double.parseDouble(vamount1);
		 }
		 s2=sanamount-s1;
		 
		 totexp1+=s2;
		// System.out.println(""+s1);
		// System.out.println(""+s2);
		 
		 ///pending bills is null
		 		 
		 String pendbill=(String)pending.get(rs3.getString(1));
		 //System.out.println("amountpendbill"+pendbill);
		 if(pendbill==null || pendbill.equals("null")){
			 dprpend=0;
			 
		 }
		 else
		 {
			 dprpend=Integer.parseInt(pendbill);
		 }
		
		 dprpendtot+=dprpend;
		 
		 //pending bill obtined date is not null
		 String pendbillnot=(String)pendingnot.get(rs3.getString(1));
		 //System.out.println("amountpendbill"+pendbill);
		 if(pendbillnot==null || pendbillnot.equals("null")){
			 dprpendnot=0;
			 
		 }
		 else
		 {
			 dprpendnot=Integer.parseInt(pendbillnot);
		 }
		
		 dprpendtot1+=dprpendnot;
		 
		 
		 //pendingCASE
		 
	/*	 String pendingsumCASE=(String)pendingCASE.get(rs3.getString(1));
		 System.out.println("amountpendbill"+pendbill);
		 if(pendingsumCASE==null || pendingsumCASE.equals("null")){
			 pendingsumCASE1=0;
			 
		 }
		 else
		 {
			 pendingsumCASE1=Integer.parseInt(pendingsumCASE);
		 }
		
		 gpendingsumCASE1+=pendingsumCASE1;
		
		 */
		 
		 
		 
		//PENDING NEW target
		 String pendingsumCASE="";
		 if(pendingCASE.get(rs3.getString(1))!=null && !pendingCASE.get(rs3.getString(1)).equals("null")){
			 pendingsumCASE=(String)pendingCASE.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 pendingsumCASE="0";
		 }
		 
		 gpendingsumCASE1+=Double.parseDouble(pendingsumCASE);	
			
		
		//END
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
 //pendingObtainedCASE achievement
		 
		/* String obtinedsumCASE=(String)obtCASE.get(rs3.getString(1));
		 System.out.println("amountpendbill"+pendbill);
		 if(obtinedsumCASE==null || obtinedsumCASE.equals("null")){
			 obtCASE1=0;
			 
		 }
		 else
		 {
			 obtCASE1=Integer.parseInt(obtinedsumCASE);
		 }
		
		 gobtCASE1+=obtCASE1;
		*/
		 
		 
		 
		//PENDING NEW
		 String obtinedsumCASE="";
		 if(obtCASE.get(rs3.getString(1))!=null && !obtCASE.get(rs3.getString(1)).equals("null")){
			 obtinedsumCASE=(String)obtCASE.get(rs3.getString(1));
		//  System.out.println("morethan"+morethan);
		 }
		 else
		 {
			 obtinedsumCASE="0";
		 }
		
		 gobtCASE1+=Double.parseDouble(obtinedsumCASE);	
		//END
		 
		 if((Double.parseDouble(svsTargetHabs))>0)
	     {
			 
			
			 allsumpercentage=(dprpendnot/(Double.parseDouble(svsTargetHabs)))*100;
	     }
	     else
	     {
	    	 allsumpercentage=0;	 
	     }
		 
		 
		 
		 
		 
		 
	 /*
		 if(Double.parseDouble(pendingsumCASE)>0)
	     {
			 
			
	     allsumpercentage=(Double.parseDouble(obtinedsumCASE))/(Double.parseDouble(pendingsumCASE))*100;
	     }
	     else
	     {
	    	 allsumpercentage=0;	 
	     }
		 
	*/
		 
		 
		 
		pendingweight=(allsumpercentage/100)*5;
		 
		 
		 
		 
		 
		 
		 
		 
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		  %>
		  
		  <tr><td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
		  <td class="<%=style %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
		  <td class="<%=style %>" style="text-align: right;"><%=svsTargetHabs %></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(s2) %></td>
		  <td class="<%=style %>" style="text-align: right;" ><%=dprpend %></td>
		 
		  
		    <td class="<%=style %>" style="text-align: right;" ><%=dprpendnot%></td>
		    
		    <td class="<%=style %>" style="text-align: right;" ><%=pendingsumCASE%></td>
		    <td class="<%=style %>" style="text-align: right;" ><%=obtinedsumCASE%></td>
		    
		      <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(allsumpercentage)%></td>
		        <td class="<%=style %>" style="text-align: right;" ><%=ndf.format(pendingweight)%></td>
		  <% 
		 
		  	  }
	  				  
	  %>
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total &nbsp; </td>
	  <td class="gridhdbg" style="text-align: right;"><%=ongoingw %></td>
	  <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totexp1)%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=dprpendtot %></td>
	   <td class="gridhdbg"  style="text-align: right;"><%=gpendingsumCASE1%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=dprpendtot1 %></td>
	  
	   <td class="gridhdbg"  style="text-align: right;"><%=gobtCASE1 %></td>
	   <%gallsumpercentage+=allsumpercentage;
	   gpendingweight+=pendingweight;
	   %>
	   <td class="gridhdbg"  style="text-align: right;"><%=gallsumpercentage %></td>
	   
	   <td class="gridhdbg"  style="text-align: right;"><%=gpendingweight%></td>
	  </tr>
	  
	  <% 
	  	 	  
  }catch(Exception e){
  e.printStackTrace();
}

 %>
 
 
 

</table>
                           








                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
     <script language="javascript" src="<rws:context page='/resources/HabScoreCardDesign/Main-Footer.js' />"></script>
</body>
</html>
