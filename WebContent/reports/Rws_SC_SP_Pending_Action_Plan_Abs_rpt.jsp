<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<%@ page import="java.util.*" %>


<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>


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
    DecimalFormat ndf1 = new DecimalFormat("##.##");
	String financialstartyr="";
	
    double aas=0,underscexp=0,underotherexp=0;
    double gunderscexp=0,gunderotherexp=0,ggunderscexp=0,ggunderotherexp=0,underscduringexp=0,underotherexpduring=0;
    String pop_exp = "";
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialstartyr=request.getParameter("finyear");
	}
   
	session.setAttribute("financialyr",financialstartyr);
//System.out.println("Changing");
    //schemes
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

	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
    
    
    int nextyr=Integer.parseInt(endyr1);
    
    String nxtfinancialstartyr=endyr1+"-"+nextyr;  
    
    //System.out.println("nxt finyear::"+nxtfinancialstartyr);
    
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
   ////System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
////System.out.println("startyr"+startyr);
   ////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;

String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();

if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}
String startyr2="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {
endyr1=endyr;
}

String dcode=request.getParameter("district");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

	%>
	
	<body>
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="./Rws_SC_SP_Pending_Action_Plan_Abs_frm.jsp">Back|</a><a href="./Rws_SC_SP_Pending_Action_Plan_Abs_excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
	
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr >
		<td align="center" class="gridhdbg" colspan=26>Abstract of SCSP Pending Action Plan for ( <%=pname %>) .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" rowspan="3">Sl.No</td>   	
    	<td  class="gridhdbg" rowspan="3">District</td>
    	<td  class="gridhdbg" rowspan="3">Program</td>
    	<!-- <td  class="gridhdbg" rowspan="3">Total Works</td>-->
    	<td  class="gridhdbg" rowspan="3">Head of A/C</td>
    	<td colspan="8"  class="gridhdbg">Works Programme</td>
    	<td  class="gridhdbg" colspan="2">Total Habs Benifited</td>
    	<td colspan="3" class="gridhdbg">Likely Expenditure of Works(<%=financialstartyr %>)</td>
    	<td colspan="3" class="gridhdbg">Expenditure During(<%=financialstartyr %>)</td>
    	<td colspan="6" class="gridhdbg">Physical & Financial Progress</td>
    	</tr>
		
<tr>
	<td  class="gridhdbg" rowspan="2">New</td>
    <td  class="gridhdbg" rowspan="2">Est. cost</td>
    <td  class="gridhdbg" rowspan="2">Spill over</td>
    <td  class="gridhdbg" rowspan="2">Spill Est Cost </td>
    <td  class="gridhdbg" rowspan="2">Total works(6+8)</td>
	<td  class="gridhdbg" rowspan="2">Total Est Cost(7+9)</td>
	<td  class="gridhdbg" rowspan="2">Est Cost Under SCSP</td>
	<td  class="gridhdbg" rowspan="2">Est Cost Under Other Funds</td>
	
	
	<td  class="gridhdbg" rowspan="2">Total</td>
    <td  class="gridhdbg" rowspan="2">SC > 40% habs</td>
    
    
    
    
    <td  class="gridhdbg" rowspan="2">Total</td>
    <td  class="gridhdbg" rowspan="2">Under SCSP</td>
    <td  class="gridhdbg" rowspan="2">Under Other Funds</td>
    <td  class="gridhdbg" rowspan="2">Total</td>
    <td  class="gridhdbg" rowspan="2">Under SCSP</td>
    <td  class="gridhdbg" rowspan="2">Under Other Funds</td>
    
    <td  class="gridhdbg" rowspan="1" colspan="2">Tender Finalized</td>
    <td  class="gridhdbg" rowspan="1" colspan="4">Works Completed</td>
    
</tr>
<tr>
<td  class="gridhdbg">No.of Works</td>
<td  class="gridhdbg">Est.Cost Under SCSP</td>
<td  class="gridhdbg">No.of Works</td>
<td  class="gridhdbg">Tot.Habs Completed</td>
<td  class="gridhdbg">SC>40% Habs</td>
<td  class="gridhdbg">Est.Cost Under SCSP</td>

</tr>

<tr>
<%
for(int k=1;k<27;k++)
{
 
%>
<td class="gridhdbg"><%out.print(k); %></td>
<%

} 
%>

</tr>

<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt12=null,stmt22=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs22=null;
int count=1;
List SCSPWorks = new ArrayList();
List SCSPWorks1 = new ArrayList();
List SCSPHabs = new ArrayList();
List GrdWorks = new ArrayList();
  try{
	  
	  stmt1=conn.createStatement();
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  stmt5=conn.createStatement();
	  stmt6=conn.createStatement();
	  stmt7=conn.createStatement();
	  stmt8=conn.createStatement();
	  stmt9=conn.createStatement();
	  stmt10=conn.createStatement();
	  stmt11=conn.createStatement();
	  stmt12=conn.createStatement();
	  stmt22=conn.createStatement();
	  
	  int styleCount=0;
	  String style="";
	  int recCount=0;
	 int gtotworkscnt=0,gncount=0,gscount=0,ghcount=0,gschcount=0,newtotpop=0,spilltotpop=0,scsptotpop=0,newscpop=0,spillscpop=0,totscpop=0,gsctencount=0,gcompcount=0,gcomphabcount=0,gcompschabcount=0;
	 double gspillsanAmt=0.0,gnewsanAmt=0.0,glikexp=0.0,gsclikexp=0.0,gdurexp=0.0,gdurlikeexp=0,gsclikeexp=0,gtenderestamt=0,gwrkscompestamt=0;
	 double plainPop=0,scPop=0,stPop=0;
	 double plainPop1=0,scPop1=0,stPop1=0,totestamt=0,scestamt=0,gscestamt=0,othestcost=0,gothestcost=0,plainPop2=0,scPop2=0,stPop2=0,plainPop3=0,scPop3=0,stPop3=0,plainPop4=0,scPop4=0,stPop4=0,plainPop5=0,scPop5=0,stPop5=0;
	 	
	 	double plainPer=0,scPer=0,stPer=0,gunderscexpdur=0,gunderotherexpdur=0,ggunderscexpdur=0,ggunderotherexpdur=0;
	 	double plainPer1=0,scPer1=0,stPer1=0;
	 	double plainPer2=0,scPer2=0,stPer2=0;
	 	double plainPer3=0,scPer3=0,stPer3=0;
	 	
		double totPop=0, totPop1=0,totPop2=0,totPop3=0,totPop4=0,totPop5=0;
		
		boolean flag=false;
				
	     
	     String dname="",prgname="";
         String myWorkList="",myWorkList1="";
         
         
         
         
   //////////////////////////////Spill over EXP query////////////////////////////////////////////
 		
 		String spillOverExpWorks="select c.dcode,substr(b.work_id,1,2),sum(case when (to_date(voucher_dt)< '01-APR-"+endyr1+"') then voucher_Amt else 0 end)/100000  FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c ,rws_work_exp_voucher_tbl exp  where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and  a.work_id=exp.work_id and substr(a.WORK_ID,5,2)=c.DCODE and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
 		   
 	  	 if(dcode!=null && !dcode.equals("00")){
 	  		spillOverExpWorks+="and c.DCODE='"+dcode+"'";
 	  		}

	 	  if(scheme!=null && !scheme.equals("")){
	 		  spillOverExpWorks+="and b.type_of_asset in("+scheme+")";
	 	  }
	 	   
 	  	spillOverExpWorks+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2)   order by c.dcode,substr(b.work_id,1,2)";

 	  	//System.out.println("spillOverExpWorks"+spillOverExpWorks);
 	  
 	  	rs10=stmt10.executeQuery(spillOverExpWorks);
 	  
 	  	Hashtable spillOverWorksExpHash=new Hashtable();
 	  	while(rs10.next())
 	  	{
 	  		  	
 	  		spillOverWorksExpHash.put(rs10.getString(1)+rs10.getString(2),rs10.getString(3));
 	  	}
 	  
 	  
 	  
 	    if(rs10!=null)rs10.close();
 		if(stmt10!=null)stmt10.close();  
         
 	 String programLinkQuery="select c.dcode,substr(b.work_id,1,2),sum(pl.SANCTION_AMOUNT)  FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c,rws_work_admn_prog_lnk_tbl pl  where  a.work_id=b.work_id and pl.work_id=b.work_id and substr(b.WORK_ID,5,2)=c.DCODE and b.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		programLinkQuery+="and c.DCODE='"+dcode+"'";
	  		}

		  if(scheme!=null && !scheme.equals("")){
			  programLinkQuery+="and b.type_of_asset in("+scheme+")";
		  }
		   
	  programLinkQuery+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2)   order by c.dcode,substr(b.work_id,1,2)";
		


	 	rs11=stmt11.executeQuery(programLinkQuery);
	 	Hashtable programLinkHash=new Hashtable();
	  	while(rs11.next())
	  	{
	  		  	
	  		programLinkHash.put(rs11.getString(1)+rs11.getString(2),rs11.getString(3));
	  	}
		

 	
	 	  
		  if(rs11!=null)rs11.close();
		  if(stmt11!=null)stmt11.close();
         
         
         
	///////////////////////////////////Completed Works estimate///////////////////////////////////////////////////
	         
	         
	         
	String compWorksEst="select d.dcode,substr(b.work_id,1,2),count(e.hab_code),count(a.hab_count) FROM RWS_SC_WORKS_VIEW a, RWS_WORK_ADMN_TBL b ,RWS_WORK_COmpletion_TBL c,rws_district_tbl d ,RWS_WORK_COMP_HAB_LNK_TBL e where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=e.work_id and substr(b.WORK_ID,5,2)=d.DCODE  and  DATE_OF_COMPLETION  is not null and (DATE_OF_COMPLETION >= '01-Apr-"+startyr+"' and DATE_OF_COMPLETION < '01-Apr-"+endyr+"')";
	
	if(dcode!=null && !dcode.equals("00"))
	{
		compWorksEst+="and d.DCODE='"+dcode+"'";
	}
	
	if(scheme!=null && !scheme.equals(""))
	{
		compWorksEst+="and b.type_of_asset in("+scheme+")";
	}
	
	compWorksEst+=" and  b.programme_code in ("+programe+") group by d.dcode,substr(b.work_id,1,2)  order by d.dcode,substr(b.work_id,1,2) ";
	
	System.out.println("compWorksEst ............"+compWorksEst);
	rs9=stmt9.executeQuery(compWorksEst);
	
	Hashtable compWorksEstHash=new Hashtable();
	
	while(rs9.next())
	{
	
		compWorksEstHash.put(rs9.getString(1)+rs9.getString(2),rs9.getString(3)+"@"+rs9.getString(4));
	
	}
	
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close(); 

      
         
        
     ///////////////////////////////////Completed Works ///////////////////////////////////////////////////
         
         
         
         String compWorks="select d.dcode,substr(b.work_id,1,2),count(c.work_id),sum(b.sanction_amount),sum(sc_pop),sum(plain_pop+sc_pop+st_pop)as totpop FROM RWS_SC_WORKS_VIEW a, RWS_WORK_ADMN_TBL b ,RWS_WORK_COmpletion_TBL c,rws_district_tbl d where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and b.work_id=c.work_id  and substr(b.WORK_ID,5,2)=d.DCODE and  DATE_OF_COMPLETION  is not null and (DATE_OF_COMPLETION >= '01-Apr-"+startyr+"' and DATE_OF_COMPLETION < '01-Apr-"+endyr+"') ";
         
         if(dcode!=null && !dcode.equals("00"))
	  	  {
        	 compWorks+="and d.DCODE='"+dcode+"'";
	  	  }

		  if(scheme!=null && !scheme.equals(""))
		  {
			  compWorks+="and b.type_of_asset in("+scheme+")";
		  }
		   
		  compWorks+=" and  b.programme_code in ("+programe+") group by d.dcode,substr(b.work_id,1,2) order by d.dcode,substr(b.work_id,1,2) ";
		  
	        System.out.println("compWorks ............"+compWorks);
			rs8=stmt8.executeQuery(compWorks);
			
			Hashtable compWorksHash=new Hashtable();
			
			while(rs8.next())
			{
	         
				compWorksHash.put(rs8.getString(1)+rs8.getString(2),rs8.getString(3)+"@"+rs8.getString(4)+"@"+rs8.getString(5)+"@"+rs8.getString(6));
         
			}
         
			 if(rs8!=null)rs8.close();
			 if(stmt8!=null)stmt8.close(); 
       
         
         
    
         
         
         
         
        ///////////////////////////////////Grounded Works ///////////////////////////////////////////////////
         
         
         
         String grdWorks="select d.dcode,substr(b.work_id,1,2),count(c.work_id),sum(b.sanction_amount),sum(a.sc_pop),sum(a.plain_pop+a.sc_pop+a.st_pop) as totpop  FROM RWS_SC_WORKS_VIEW a, RWS_WORK_ADMN_TBL b ,RWS_WORK_COMMENCEMENT_TBL c,rws_district_tbl d  where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and b.work_id=c.work_id and substr(b.WORK_ID,5,2)=d.DCODE  and  GROUNDING_DATE is not null and (GROUNDING_DATE >= '01-Apr-"+startyr+"' and GROUNDING_DATE< '01-Apr-"+endyr+"')  and WORK_CANCEL_DT  is null ";
         
         if(dcode!=null && !dcode.equals("00"))
	  	  {
        	 grdWorks+="and d.DCODE='"+dcode+"'";
	  	  }

		  if(scheme!=null && !scheme.equals(""))
		  {
			  grdWorks+="and b.type_of_asset in("+scheme+")";
		  }
		   
		  grdWorks+=" and  b.programme_code in ("+programe+") group by d.dcode,substr(b.work_id,1,2)  order by d.dcode,substr(b.work_id,1,2)";
		  
	        //System.out.println("grdWorks ............"+grdWorks);
			rs7=stmt7.executeQuery(grdWorks);
			
			Hashtable grdWorksHash=new Hashtable();
			
			while(rs7.next())
			{
	         
				grdWorksHash.put(rs7.getString(1)+rs7.getString(2),rs7.getString(3)+"@"+rs7.getString(4)+"@"+rs7.getString(5)+"@"+rs7.getString(6));
         
			}
         
			 if(rs7!=null)rs7.close();
			 if(stmt7!=null)stmt7.close(); 
       
         
         
         
         //////////////////////////Likely EXP//////////////////////////////////////////////////////////////
         
         
         
         String likelyExp="select d.dcode,substr(b.work_id,1,2),sum(PROB_EXP),sum(VOUCHER_AMT)/100000  FROM RWS_SC_WORKS_VIEW a, RWS_WORK_ADMN_TBL b ,rws_work_exp_voucher_tbl c,rws_district_tbl d  where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and b.work_id=c.work_id and substr(b.WORK_ID,5,2)=d.DCODE  and WORK_CANCEL_DT  is null ";
         
         if(dcode!=null && !dcode.equals("00"))
	  	  {
        	 likelyExp+=" and d.DCODE='"+dcode+"'";
	  	  }

		  if(scheme!=null && !scheme.equals(""))
		  {
			  likelyExp+=" and b.type_of_asset in("+scheme+")";
		  }
		   
		  likelyExp+=" and  b.programme_code in ("+programe+") group by d.dcode,substr(b.work_id,1,2) order by d.dcode,substr(b.work_id,1,2)";
		  
	        //System.out.println("likelyExp ............"+likelyExp);
			rs6=stmt6.executeQuery(likelyExp);
			
			Hashtable likelyExpHash=new Hashtable();
			
			while(rs6.next())
			{
	         
				likelyExpHash.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3)+"@"+rs6.getString(4));
         
			}
         
			 if(rs6!=null)rs6.close();
			 if(stmt6!=null)stmt6.close(); 
		       
          
  /////////////////////////////////SC Hab Count//////////////////////////////////////////////// 
         
         
         
         String schabCount="select c.dcode,substr(b.work_id,1,2),count(a.HAB_COUNT) FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c  where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"')) and a.work_id=b.work_id  and  substr(b.WORK_ID,5,2)=c.DCODE   and WORK_CANCEL_DT  is null ";
  	   
	  	 if(dcode!=null && !dcode.equals("00"))
	  	 {
	  		schabCount+="and c.DCODE='"+dcode+"'";
	  		}

		  if(scheme!=null && !scheme.equals("")){
			  schabCount+="and b.type_of_asset in("+scheme+")";
		  }
		   
		  schabCount+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2) order by c.dcode,substr(b.work_id,1,2)";
	
		  	//System.out.println("schabCount"+schabCount);
		  	
		  	rs5=stmt5.executeQuery(schabCount);
		  
		  	Hashtable schabCountHash=new Hashtable();
		  	while(rs5.next()){
		  		  	
		  		schabCountHash.put(rs5.getString(1)+rs5.getString(2),rs5.getString(3));
		  	}
	  
	  
	  
	    if(rs5!=null)rs5.close();
		if(stmt5!=null)stmt5.close(); 
         
         
             
        /////////////////////////////////Hab Count//////////////////////////////////////////////// 
         
         ///select d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name,count(*),sum(sc_pop) ,sum(plain_pop+sc_pop+st_pop) as totpop  from RWS_SC_WORKS_VIEW a, rws_work_admn_tbl b ,rws_programme_tbl c ,rws_district_tbl d where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-2013')) and a.work_id=b.work_id  and substr(b.work_id,5,2)=d.dcode and substr(b.work_id,1,2)=c.programme_code   and WORK_CANCEL_DT  is null   and d.DCODE='03' and b.type_of_asset in(03) and substr(b.work_id,1,2)=c.programme_code  and c.programme_code in (01,02,18,23,32,48,49,51,58) group by d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name order by d.dcode,c.programme_code
        
        
        
         
         String tothabCount="select c.dcode,substr(b.work_id,1,2),count(d.hab_code) FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c,rws_admn_hab_lnk_tbl d  where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id  and a.work_id=d.work_id and  substr(b.WORK_ID,5,2)=c.DCODE  and WORK_CANCEL_DT  is null  ";
  	   
	  	 if(dcode!=null && !dcode.equals("00"))
	  	 {
	  		tothabCount+="and c.DCODE='"+dcode+"'";
	  		}

		  if(scheme!=null && !scheme.equals("")){
			  tothabCount+="and b.type_of_asset in("+scheme+")";
		  }
		   
		  tothabCount+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2) order by c.dcode,substr(b.work_id,1,2)";
	
		  	//System.out.println("tothabCount"+tothabCount);
		  	
		  	rs4=stmt4.executeQuery(tothabCount);
		  
		  	Hashtable tothabCountHash=new Hashtable();
		  	while(rs4.next()){
		  		  	
		  		tothabCountHash.put(rs4.getString(1)+rs4.getString(2),rs4.getString(3));
		  	}
	  
	  
	  
	    if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close(); 
         
            
         
         
        /////////////////////////////////Spill works///////////////////////////////////////////////// 
         
         //select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp , rws_sc_works_view sc  where sc.work_id=w.work_id and sp.subprogramme_code=substr(sc.WORK_ID,3,2) and substr(sc.WORK_ID,5,2)=D.DCODE and substr(sc.WORK_ID,1,2)=pr.programme_code and Special_cat<>'SCSP' and (w.PROB_EXP >0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"'))  and  sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null ";
         
         String spillOverWorks="select c.dcode,substr(b.work_id,1,2),count(*),sum(SANCTION_AMOUNT) FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c  where   Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and  substr(b.WORK_ID,5,2)=c.DCODE and b.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and WORK_CANCEL_DT  is null ";
  	   
	  	 if(dcode!=null && !dcode.equals("00"))
	  	 {
	  		spillOverWorks+="and c.DCODE='"+dcode+"'";
	  		}

		  if(scheme!=null && !scheme.equals("")){
			  spillOverWorks+="and b.type_of_asset in("+scheme+")";
		  }
		   
		  spillOverWorks+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2) order by c.dcode,substr(b.work_id,1,2)";
	
		  	System.out.println("spillOverWorks"+spillOverWorks);
		  	rs3=stmt3.executeQuery(spillOverWorks);
		  
		  	Hashtable spillOverWorksHash=new Hashtable();
		  	while(rs3.next())
		  	{
		  		  	
		  		spillOverWorksHash.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3)+"@"+rs3.getString(4));
		  	}
	  
	  
	  
	    if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();
		
            
       /////////////////////////////New Works count////////////////////////////// 
       
      ///select d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name,count(*),sum(sc_pop) ,sum(plain_pop+sc_pop+st_pop) as totpop  from RWS_SC_WORKS_VIEW a, rws_work_admn_tbl b ,rws_programme_tbl c ,rws_district_tbl d where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-2013')) and a.work_id=b.work_id  and substr(b.work_id,5,2)=d.dcode and substr(b.work_id,1,2)=c.programme_code   and WORK_CANCEL_DT  is null   and d.DCODE='03' and b.type_of_asset in(03) and substr(b.work_id,1,2)=c.programme_code  and c.programme_code in (01,02,18,23,32,48,49,51,58) group by d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name order by d.dcode,c.programme_code
       
       
 	  	String newWorks="select c.dcode,substr(b.work_id,1,2),count(*),sum(SANCTION_AMOUNT)  FROM RWS_SC_WORKS_VIEW a,RWS_WORK_ADMN_TBL b ,rws_district_tbl c where   Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id and (to_date(b.ADMIN_DATE) >= '01-Apr-"+startyr+"' and to_date(b.ADMIN_DATE) < '01-Apr-"+endyr+"')  and  substr(b.WORK_ID,5,2)=c.DCODE   and WORK_CANCEL_DT  is null   ";
 	   
 	  	 if(dcode!=null && !dcode.equals("00")){
 	  		newWorks+="and c.DCODE='"+dcode+"'";
 	  		}

	 	  if(scheme!=null && !scheme.equals("")){
	 		  newWorks+="and b.type_of_asset in("+scheme+")";
	 	  }
 	   
 	     newWorks+=" and  b.programme_code in ("+programe+") group by c.dcode,substr(b.work_id,1,2) order by c.dcode,substr(b.work_id,1,2)";

 	  	 //System.out.println("newWorks"+newWorks);
 	  	 rs2=stmt2.executeQuery(newWorks);
 	  
 	  	Hashtable newWorksHash=new Hashtable();
 	  	while(rs2.next())
 	  	{
 	  		  	
 	  		newWorksHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
 	  	}
 	  
 	  
 	  
 	    if(rs2!=null)rs2.close();
 		if(stmt2!=null)stmt2.close();    
         
         
      /////////////////////////////////////////////////////////////   
         
      ////////////////////////////////totpopulation
      
      
     
			String sanctionAmtQery = "select W.WORK_ID, sum(census_plain_popu),sum(census_sc_popu),sum(census_st_popu) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_admn_hab_lnk_tbl l ,rws_habitation_directory_tbl hd  where w.work_id=l.work_id and l.hab_code=hd.hab_code ";

			if (dcode != null && !dcode.equals("00")) {
				sanctionAmtQery += "and D.DCODE='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				sanctionAmtQery += "and w.type_of_asset in(" + scheme + ")";
			}

			sanctionAmtQery += " and  w.programme_code in (" + programe
					+ ")  group by W.WORK_ID";

			System.out.println("sanctionAmtQery.." + sanctionAmtQery);
			rs22 = stmt22.executeQuery(sanctionAmtQery);
			Hashtable sanctionAmtQeryHash = new Hashtable();
			while (rs22.next()) {

				sanctionAmtQeryHash.put(rs22.getString(1), rs22.getString(2)+ "@" + rs22.getString(3) + "@" + rs22.getString(4));
			}

			if (rs22 != null)rs22.close();
			if (stmt22 != null)stmt22.close();

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    /******   Main  Query *****************************************************/
   
 	
 	String mainQuery="select d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name,count(*),sum(sc_pop) ,sum(plain_pop+sc_pop+st_pop) as totpop  from RWS_SC_WORKS_VIEW a, rws_work_admn_tbl b ,rws_programme_tbl c ,rws_district_tbl d where Special_cat<>'SCSP' and (b.PROB_EXP >0 or b.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and a.work_id=b.work_id  and substr(b.work_id,5,2)=d.dcode and substr(b.work_id,1,2)=c.programme_code   and WORK_CANCEL_DT  is null ";
	
 	if(dcode!=null && !dcode.equals("00"))
	   {
		   mainQuery+="  and d.DCODE='"+dcode+"'";
		}

		if(scheme!=null && !scheme.equals(""))
		{
			mainQuery+=" and b.type_of_asset in("+scheme+")";
		}
		
		mainQuery+=" and substr(b.work_id,1,2)=c.programme_code  and c.programme_code in ("+programe+") group by d.dcode,d.dname,substr(a.work_id,1,2),c.programme_code ,c.programme_name order by d.dcode,c.programme_code";
		

    System.out.println("mainQuery ............"+mainQuery);
	rs1=stmt1.executeQuery(mainQuery);
	
	while(rs1.next())
	{
		    double sclikexp=0.0,durexp=0.0,durlikeexp=0,sclikeexp=0,likexp=0,scstateshare=0,duringstateshare=0;
			
		   int nWorkCount=0,sWorkCount=0,habcount=0,schabcount=0,tencount=0,compcount=0,comphabcount=0,compschabcount=0,totworkscnt=0;
		   
		    double spillSanctionedAmt=0.0,newSanctionedAmt=0.0,groundestamt=0,tenderestamt=0,wrkscompestamt=0,compworkamt=0;
		
		    double exp=0;
			
			double moreProgSanc=0;
			
		   String key=rs1.getString(1)+rs1.getString(3);
		   
		   totworkscnt=rs1.getInt(6);
		   totscpop=rs1.getInt(7);
		   scsptotpop=rs1.getInt(8);
		 
		   
		    String ddCode=rs1.getString(1);
		    
			if(ddCode.equals("03"))
			{
				
				//System.out.println("Testing");
			} 
		   
		   
		   
			
			
			
			
			
			
			/*
			int totPop_exp = 0;
			pop_exp = (String) sanctionAmtQeryHash.get(rs1
					.getString(9));
			if (pop_exp != null) {
				String popValues_exp[] = pop_exp.split("@");

				double plainPOP_exp = Double
						.parseDouble(popValues_exp[0]);
				double scPOP_exp = Double
						.parseDouble(popValues_exp[1]);
				double stPOP_exp = Double
						.parseDouble(popValues_exp[2]);
				totPop_exp = Integer.parseInt(popValues_exp[0])
						+ Integer.parseInt(popValues_exp[1])
						+ Integer.parseInt(popValues_exp[2]);
			}*/
				//totsanamt = (sanctionedAmount / totPop_exp) * totPP;
				//System.out.println("Sanction amount......."+sanctionedAmount);
				//System.out.println("grand pop amount......."+gtotPOP);
				//System.out.println("total pop amount......."+totPP);
			

			//gtotsanamt += totsanamt;

		//	ggtotsanamt += totsanamt;

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			String programeCode = rs1.getString(4);
			//String workId=rs1.getString(9);

			
		   
		   if(newWorksHash.get(key)!=null )
		   {
			flag=true;
			String nWorks=(String)newWorksHash.get(key);
			String []aa=nWorks.split("@");
			String a1=aa[0];
			if(a1!=null)
			{
				nWorkCount=Integer.parseInt(a1);
			}
			String a2=aa[1];
			if(a2!=null)
			{
				newSanctionedAmt=Double.parseDouble(a2);
			}

		}
		   
		   
		 //grand total
		   gncount+=nWorkCount;
		   gnewsanAmt+=newSanctionedAmt; 
		   
		   
		 ///////////////////////////////////////  
		   
		 
		   if(spillOverWorksExpHash.get(key)!=null)
			  {
				  
				  String expStr=(String)spillOverWorksExpHash.get(key);
				  if(expStr!=null){
				  exp=Double.parseDouble(expStr);
				  }
				  
			  }
			
			//more program sanction
			
			
		  if(programLinkHash.get(key)!=null)
		  {
				  
				  String sanc=(String)programLinkHash.get(key);
				  if(sanc!=null){
				  moreProgSanc=Double.parseDouble(sanc);
				  }
				  
			  }
		 
		 
		 
		 	   
		   if(spillOverWorksHash.get(key)!=null )
		   {
				flag=true;
				String spillWorks=(String)spillOverWorksHash.get(key);
				String []aa=spillWorks.split("@");
				String a1=aa[0];
				if(a1!=null)
				{
					sWorkCount=Integer.parseInt(a1);
				}
				String a2=aa[1];
				if(a2!=null)
				{
					spillSanctionedAmt=Double.parseDouble(a2);
				}

			}   
		   
		   
		   ////////grand//////////
		   
		   gscount+=sWorkCount;
		   
		   if(sWorkCount==0 && nWorkCount==0){
			   continue;
		   }
		   
		   spillSanctionedAmt-=exp;
		   spillSanctionedAmt+=moreProgSanc;
		   
		   
		   
		   gspillsanAmt+=spillSanctionedAmt;
		   
		   
		   //////////////Under SCSP /////////////////////
		   
		    totestamt=newSanctionedAmt+spillSanctionedAmt;
		    scestamt=(totestamt/scsptotpop)*totscpop;
            othestcost=(totestamt-scestamt);
		   
            gscestamt+=scestamt;
            gothestcost+=othestcost;  
		   
		  ////////////////////////////////////// 
		  
            if(tothabCountHash.get(key)!=null )
 		   {
 				flag=true;
 				String hCount=(String)tothabCountHash.get(key); 	
 				habcount=Integer.parseInt(hCount);

 		   }     
            ghcount+=habcount;
            
            
            
            ////////////////////////////////////// 
  		  
            if(schabCountHash.get(key)!=null )
 		   {
 				flag=true;
 				String scCount=(String)schabCountHash.get(key); 	
 				schabcount=Integer.parseInt(scCount);

 		   }     
            gschcount+=schabcount;   
            
            
            
            ////////////////////////////////
            
            
            if(likelyExpHash.get(key)!=null )
		   {
				flag=true;
				String likelyexp=(String)likelyExpHash.get(key);
				String []aa=likelyexp.split("@");
				String a1=aa[0];
				if(a1!=null && !a1.equals("null"))
				{
					likexp=Double.parseDouble(a1);
				}
				
				String a2=aa[1];
				if(a2!=null && !a2.equals("null"))
				{
					durexp=Double.parseDouble(a2);
				}
				

			}   
		   
            
            sclikeexp=(likexp/scsptotpop)*totscpop;
 	        durlikeexp=(durexp/scsptotpop)*totscpop;
 			
 	        glikexp+=likexp;	
			gdurexp+=durexp;
 	        
 	        
 	        gsclikeexp+=sclikeexp;	
 	        gdurlikeexp+=durlikeexp;  
            ////////
            
            
            
            
            
            
            if (programeCode != null
					&& (programeCode.equals("01")
							|| programeCode.equals("18")
							|| programeCode.equals("49")
							|| programeCode.equals("51")
							|| programeCode.equals("23") || programeCode
							.equals("02"))) {

				
				scstateshare = 0.5 * likexp;
				duringstateshare= 0.5 * durexp;

			} else if (programeCode != null
					&& (programeCode.equals("65")
							|| programeCode.equals("12")
							|| programeCode.equals("46")
							|| programeCode.equals("57")
							|| programeCode.equals("04")
							|| programeCode.equals("09")
							|| programeCode.equals("39") || programeCode
							.equals("15"))) {

				
				scstateshare = likexp;
				duringstateshare=durexp;

			}

			
			
			
			underscexp = (scstateshare/scsptotpop) * totscpop;
			
			double totStateEst = (scstateshare / scsptotpop)* scsptotpop;
			
			underotherexp = totStateEst - underscexp;
			
			String uscexp = (String.valueOf(ndf.format(underscexp)));
			String uothscexp = (String.valueOf(ndf
					.format(underotherexp)));

            
			
			gunderscexp += underscexp;
			gunderotherexp += underotherexp;

			ggunderscexp += underscexp;
			ggunderotherexp += underotherexp;
            
            
            //during the expenditure
        
            
            underscduringexp = (duringstateshare/scsptotpop) * totscpop;
			
            double totStateEstduring = (duringstateshare / scsptotpop)* scsptotpop;
            
            
            underotherexpduring = totStateEstduring - underscduringexp;
            
            
            
            String uscexpduring = (String.valueOf(ndf.format(underscduringexp)));
			String uothscexpduring = (String.valueOf(ndf
					.format(underotherexpduring)));

			gunderscexpdur += underscduringexp;
			gunderotherexpdur += underotherexpduring;

			ggunderscexpdur += underscduringexp;
			ggunderotherexpdur +=underotherexpduring;
            
            
			
            
			
			
            
            
            
            
            
            
            
 	       ////////////////////////////////////// 
 	  		  
            if(grdWorksHash.get(key)!=null )
 		   {
 				flag=true;
 				String grdCount=(String)grdWorksHash.get(key); 	
 				
 				String []aa=grdCount.split("@");
				String a1=aa[0];
				if(a1!=null && !a1.equals("null"))
				{
					tencount=Integer.parseInt(a1);
				}
				
				String a2=aa[1];
				if(a2!=null && !a2.equals("null") && !a2.equals(" "))
				{
					groundestamt=Double.parseDouble(a2);
				}
				
				String a3=aa[2];
				if(a3!=null && !a3.equals("null")  && !a3.equals(" "))
				{
					scPop4=Double.parseDouble(a3);
				}
				
				String a4=aa[3];
				if(a4!=null && !a4.equals("null")  && !a4.equals(" "))
				{
					totPop4=Double.parseDouble(a4);
				}
				 tenderestamt=(groundestamt/totPop4)*scPop4;
 		   }     
           
            gsctencount+=tencount;       
            gtenderestamt+=tenderestamt;
            
             
            
        ////////////////////////////////
            
            
            if(compWorksHash.get(key)!=null )
		   {
				flag=true;
				
				String compwrks=(String)compWorksHash.get(key);
				String []aa=compwrks.split("@");
				
				String a1=aa[0];
				if(a1!=null && !a1.equals("null"))
				{
					compcount=Integer.parseInt(a1);
				}
				
				String a2=aa[1];
				if(a2!=null && !a2.equals("null"))
				{
					compworkamt=Double.parseDouble(a2);
				}
				
				String a3=aa[2];
				if(a3!=null && !a3.equals("null"))
				{
					scPop2=Double.parseDouble(a3);
				}
				
				String a4=aa[3];
				if(a4!=null && !a4.equals("null"))
				{
					totPop2=Double.parseDouble(a4);
				}
				
				wrkscompestamt=(compworkamt/totPop2)*scPop2;

			}       
            
            gcompcount+=compcount;	
            gwrkscompestamt+=wrkscompestamt;
            
           // 
            
            
		//////////////////////////////////////
			  		  
		if(compWorksEstHash.get(key)!=null )
		{
			flag=true;
			String cmpCount=(String)compWorksEstHash.get(key); 	
			
			String []aa=cmpCount.split("@");
			
			String a1=aa[0];
			if(a1!=null && !a1.equals("null"))
			{
				comphabcount=Integer.parseInt(a1);
			}
			
			String a2=aa[0];
			if(a2!=null && !a2.equals("null"))
			{
				compschabcount=Integer.parseInt(a2);
			}
		
			
			
		}    
		
		
		gcomphabcount+=comphabcount;
		gcompschabcount+=compschabcount;	
		
		
		
		if(!flag)
		{
			continue;
		}
				if(styleCount%2==0)
				{
	 				 style="gridbg1";
	 			 }else
	 			 {
	 				 style="gridbg2";
	 			 }
	 			 styleCount++;
	 			 
	 			 
	 			%>
	 			     
            
<tr>

<% 
if(!dname.equals(rs1.getString(2)) && !dname.equals("-"))
{
dname=rs1.getString(2);
recCount++;

%>
<td class=<%=style %>><%=recCount %></td>
<td  class=<%=style %> style="text-align: left;"><%=dname %></td>

<%}
else
{   %>
<td class=<%=style %>  style="text-align: center;"></td>
<td  class=<%=style %> style="text-align: center;">-</td>

<%} %>

<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5) %></td>
<!-- <td class=<%=style %> style="text-align: left;"></td>-->
<td class=<%=style %> style="text-align: left;">-</td>
<td class=<%=style %> style="text-align: left;"><%=nWorkCount %></td>
<td class=<%=style %> style="text-align: left;"><%=ndf.format(newSanctionedAmt)%></td>
<td class=<%=style %> style="text-align: left;"><%=sWorkCount %></td>
<td class=<%=style %> style="text-align: left;"><%=ndf.format(spillSanctionedAmt)%></td>
<td class=<%=style %> style="text-align: left;"><%=(nWorkCount+sWorkCount)%></td>
<td class=<%=style %> style="text-align: left;"><%=ndf.format(newSanctionedAmt+spillSanctionedAmt)%></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(scestamt)%></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(othestcost)%></td>
<td class=<%=style %> style="text-align: right;"><%=habcount%></td>
<td class=<%=style %> style="text-align: right;"><%=schabcount%></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(likexp)%></td>
<td class=<%=style %> style="text-align: right;"><%=uscexp%></td>
<td class=<%=style %> style="text-align: right;"><%=uothscexp%></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(durexp)%></td>
<td class=<%=style %> style="text-align: right;"><%=uscexpduring%></td>
<td class=<%=style %> style="text-align: right;"><%=uothscexpduring%></td>
<td class=<%=style %> style="text-align: right;"><%=tencount%></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(tenderestamt)%></td>
<td class=<%=style %> style="text-align: right;"><%=compcount%></td>
<td class=<%=style %> style="text-align: right;"><%=comphabcount%></td>
<td class=<%=style %> style="text-align: right;"><%=compschabcount %></td>
<td class=<%=style %> style="text-align: right;"><%=ndf.format(wrkscompestamt) %></td>

</tr>

<%
                
				if(!dname.equals(rs1.getString(2)) && !dname.equals("-"))
				{
					System.out.println("this is jyothi..............."+dname);
					
				%>
				<tr>
				        <td colspan="3"  class="gridhdbg" style="text-align: right;">Sub Total:</td>
	 				    <td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
	                </tr>
	
	 			<% 
	 				dname="-";
	 			    //System.out.println("this is jyothi..............."+dname+"..."+rs1.getString(2));				
	 			}
	 			//dname="-";
         gtotworkscnt+=totworkscnt;
         
       %> 
         
  
         
         
         
	<%
	   }   //End Main Loop
	
	%>
 			
	 				
	 				
	<tr>
	<td colspan="3"  class="gridhdbg" style="text-align: right;">Grand Total:</td>
   <!-- 	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total:Total Works',TITLE,'Information')" onmouseout="UnTip()"></td>-->
    <td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total:Total Works',TITLE,'Information')" onmouseout="UnTip()">-</td>
    <td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: New Sanctioned Works',TITLE,'Information')" onmouseout="UnTip()"><%=gncount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: New Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gnewsanAmt) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Spill Sanctioned Works',TITLE,'Information')" onmouseout="UnTip()"><%=gscount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Spill Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gspillsanAmt) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Works(Spill+New)',TITLE,'Information')" onmouseout="UnTip()"><%=gncount+gscount %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gnewsanAmt+gspillsanAmt) %></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal SC Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gscestamt)%></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: other Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gothestcost)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Habs.',TITLE,'Information')" onmouseout="UnTip()"><%=ghcount%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Habs.',TITLE,'Information')" onmouseout="UnTip()"><%=gschcount%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total likely exp',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glikexp)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total SC likely exp.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggunderscexp)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Other exp.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggunderotherexp)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total exp.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gdurexp)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total During exp.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggunderscexpdur)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Other exp.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggunderotherexpdur)%></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Tender Count.',TITLE,'Information')" onmouseout="UnTip()"><%=gsctencount%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Tender Amt.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gtenderestamt)%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Completed Works.',TITLE,'Information')" onmouseout="UnTip()"><%=gcompcount%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Total Comp.Habs',TITLE,'Information')" onmouseout="UnTip()"><%=gcomphabcount%></td>	
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Comp.SC.Habs.',TITLE,'Information')" onmouseout="UnTip()"><%=gcompschabcount%></td>
	<td class="gridhdbg" style="text-align: right;" onmouseover="Tip('Grand Total: Toal Comp.Works Est.Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gwrkscompestamt)%></td>	
	
	
	</tr>
	
	
	<% 
	
	
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>