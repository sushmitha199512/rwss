<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SCSP 14-15_details.xls");

%>

	<% 

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="",nextfinancialstartyr="";
           String pname="";

	pname=(String)session.getAttribute("pname");

	financialstartyr=(String)session.getAttribute("financialyr");
	nextfinancialstartyr=(String)session.getAttribute("nextfinancialstartyr");
	
	String scheme=(String)session.getAttribute("scheme");

	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
      	

    String programe=(String)session.getAttribute("programe");
	String sysdate=workData.getDate();
    String sysmon=sysdate.substring(3,5);
    int mon=Integer.parseInt(sysmon);
     String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);

   int prevyear=0,prevmon=0;String fyear,fyear1;

String prevmonth=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

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

////System.out.println("Startyr:"+startyr);
////System.out.println("Startyr2:"+startyr2 );
////System.out.println("Endyr:"+endyr );

////System.out.println("Endyr2:"+endyr1);


     ////System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");

 

	%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr >
		<td align="center" class="gridhdbg" colspan=53>Spillover Infrastructure Works Proposed Under SCSP 2014-15 for the Benefit of the SC Habitations  (<%=pname %>) .</td>	
	</tr>
		<tr>
		<td  class="gridhdbg" rowspan=4>Sl.No</td>
		<td  class="gridhdbg" rowspan=4>Programme</td>
		<td  class="gridhdbg" rowspan=4>Sub Programme</td>
		<td   class="gridhdbg" rowspan=4>District</td>
<td  class="gridhdbg" rowspan=4>Work Name</td>
<td  class="gridhdbg" rowspan=4>WorkID </td>
<td class="gridhdbg"  rowspan=4 >Nature Of The Work</td>
<td  class="gridhdbg" rowspan=4>Mandal</td>
<td class="gridhdbg"  rowspan=4>Panchayat</td>
<td  class="gridhdbg" rowspan=4>Hab&nbsp;Code</td>
<td  class="gridhdbg" rowspan=4>Existing&nbsp;Water Level</td>
<td  class="gridhdbg" rowspan=4>Coverage Status(55 LPCD)</td>

<td  class="gridhdbg" rowspan=4>Hab&nbsp;Name</td>
<td  class="gridhdbg" rowspan=2 colspan=3>Total Sanction Estimate Cost</td>

<!-- <td  class="gridhdbg" rowspan=4>Balance&nbsp;EST&nbsp;Cost</td> -->

</tr>
<tr>
		<td  class="gridhdbg" align="center"  colspan=4>Population</td>
		<td class="gridhdbg"  align="center" colspan=3>Population %</td>
		<%-- <td  class="gridhdbg" align="center"   colspan=4>Balance EST Cost As On.01.04.<%=startyr %></td> --%>
		<%-- <td  class="gridhdbg" align="center"   colspan=4>State Share Of Balance EST Cost As On.01.04.<%=startyr %></td> --%>
<td  class="gridhdbg" align="center" rowspan="3" nowrap >Clause<br></br>(SC > 40% /ST > 40% /<40%)</td>
<td  class="gridhdbg" align="center" rowspan="3" nowrap >Subplan Submitted <br></br>(SCSP/TSP/Others)</td>
<%-- <td  class="gridhdbg" align="center"   colspan="6" nowrap >Likely EXP. <br></br><%=financialstartyr %></td>
 --%><td  class="gridhdbg" align="center"   colspan="6" nowrap >Balance requirement for 2014-2015<br> (Likely EXP. <br></br><%=nextfinancialstartyr %>)</td>
 <td  class="gridhdbg" align="center"   colspan="6" nowrap >Balance requirement for <%=financialstartyr %></td>
<td  class="gridhdbg" align="center"   colspan="6" nowrap >Cumulative EXP. till Date</td>
<td  class="gridhdbg" align="center"   colspan="6" nowrap >EXP. during <%=financialstartyr %></td>
<td  class="gridhdbg" rowspan=3>Physical Status<br></br>(Grounded/ Completed)</td>
<td  class="gridhdbg" rowspan=3>Probale Date of Completion</td>

</tr>
<tr>
<td class="gridhdbg"  colspan=1 "  rowspan="2" align="center">Total</td>	
		<td   class="gridhdbg" colspan=1   rowspan="2" align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1    rowspan="2" align="left">Under Other SCSP</td>


<td class="gridhdbg"  colspan=1 rowspan="2"  align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1 rowspan="2"  align="center">SC</td>	
		<td  class="gridhdbg" colspan=1  rowspan="2" align="left">ST</td>
<td  colspan=1  class="gridhdbg" rowspan="2"   align="center">Total</td>
<td  colspan=1  class="gridhdbg"  rowspan="2" align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  rowspan="2" align="center">SC</td>	
		<td class="gridhdbg" rowspan=2  colspan=1  align="left">ST</td>
<!-- <td rowspan=2 class="gridhdbg" colspan=1   align="center">PLAIN</td>	
		<td class="gridhdbg" rowspan=2  colspan=1  align="center">SC</td>	
		<td class="gridhdbg" rowspan=2  colspan=1  align="left">ST</td>
<td rowspan=2 class="gridhdbg"  colspan=1    align="center">Total</td>
 -->
<!-- <td rowspan=2 colspan=1 class="gridhdbg"   align="center">PLAIN</td>	
		<td rowspan=2 class="gridhdbg"  colspan=1  align="center">SC</td>	
		<td rowspan=2  class="gridhdbg" colspan=1  align="left">ST</td>
<td rowspan=2 colspan=1 class="gridhdbg"    align="center">Total</td>
 --><td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>
 <td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>
<td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>
<td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>

</tr>
<tr>

 <td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">SC</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		
		</tr>
<tr>

<%
for(int i=1;i<52;i++)
{

%>

<td class="gridhdbg"  align="center"><%=i %></td>	


<%} %>
</tr>
<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
int count=1;
  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
/////////////////////////////////////////////////////////////////////////////////////////////////


        Hashtable sanctionedHabsHash=(Hashtable)session.getAttribute("sanctionedHabsHash");
	    Hashtable totalPOPHash=(Hashtable)session.getAttribute("totalPOPHash");
		Hashtable schoolTotPOPHash=(Hashtable)session.getAttribute("schoolTotPOPHash");
	  	Hashtable schoolHabsHash=(Hashtable)session.getAttribute("schoolHabsHash");
        Hashtable programLinkHash=(Hashtable)session.getAttribute("programLinkHash");
	 	Hashtable contractorExpHash=(Hashtable)session.getAttribute("contractorExpHash");
		Hashtable groundHash=(Hashtable)session.getAttribute("groundHash");
		Hashtable completeHash=(Hashtable)session.getAttribute("completeHash");
		Hashtable expHash=(Hashtable)session.getAttribute("expHash");
	 	Hashtable sanctionAmtQeryHash=(Hashtable)session.getAttribute("sanctionAmtQeryHash");
	 	Hashtable expHash1=(Hashtable)session.getAttribute("expHash1");
			
		 	
		 
	

	  
/******   New  Works *****************************************************/
	 	stmt2=conn.createStatement();
		String newWorksQuery="select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name,NO_OF_HABS,nvl(to_char(w.TARGET_DATE_COMP,'dd/mm/yyyy'),'-') FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp   where sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0  or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"'))     ";
	 	if(dcode!=null && !dcode.equals("00")){
	         newWorksQuery+="and D.DCODE='"+dcode+"'";
			}

			if(scheme!=null && !scheme.equals("")){
			          newWorksQuery+="and w.type_of_asset in("+scheme+")";
			}
	 
	 newWorksQuery+=" and  pr.programme_code in ("+programe+") order by CATEGORY_CODE    ";

	 /*String newWorksQuery="select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp   where sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and PROB_EXP_NXT_YR > 0  and w.work_id not in (select work_id from rws_st_works_view )";
		if(dcode!=null && !dcode.equals("00")){
	      newWorksQuery+="and D.DCODE='"+dcode+"'";
			}

			if(scheme!=null && !scheme.equals("")){
			          newWorksQuery+="and w.type_of_asset in("+scheme+")";
			}

	newWorksQuery+=" and  pr.programme_code in ("+programe+") order by CATEGORY_CODE    ";*/


	//System.out.println("New Works"+newWorksQuery);
	 	rs2=stmt2.executeQuery(newWorksQuery);
		
	  int styleCount=0;
	  String style="";
	  int recCount=1;
	  String clauseType1="";
	  int totWorkPop=0;
	  
	  
	    int ggplainpop=0,ggscPOP=0,ggstPop=0;
		int ggtotPOP=0;
		
		double ggplainEST=0,ggscEST=0,ggstEST=0; 	double ggstateplainEST=0,ggstatescEST=0,ggstatestEST=0;
		double ggplainExp=0,ggscEXp=0,ggstExp=0,ggtotalEXP=0;
		double ggplainExp1=0,ggscEXp1=0,ggstExp1=0,ggtotalEXP1=0;
		//new added
		
		double gglCenExp=0,gglNCenExp=0,ggexpDuringCen=0,ggexpDuringCen1=0;
		double ggexpSc=0,ggexpPlain=0,ggexpSt=0,ggexpTot=0;
		double ggexpSc1=0,ggexpPlain1=0,ggexpSt1=0,ggexpTot1=0;
		double gglPlainExp=0,gglScExp=0,gglStExp=0,gglTotExp=0,gglNPlainExp=0,gglNScExp=0,gglNStExp=0,gglNTotExp=0;
		double ggtotEST=0;
		double ggstatetotEST=0;
		
		  double ggbalanceEST=0;
		  String workId="";
		  double gsanctionedAmount=0,ggtotsanamt=0;
		  
	  
	  double ggunderscexp=0,ggunderotherexp=0;
	  
	  String myprob_date="";
	  //start printing
		while(rs2.next())
		{
			double gunderscexp=0,gunderotherexp=0,gtotsanamt=0;
			String subplanSubmitted="";
			String typeOfAsset="";
			String clauseType="";
			String workType="";
			boolean flag=true;
			double expUpto=0;
			double expDuring=0,expDuring1=0;
			workId=rs2.getString(3);
			double moreProgramSanctioned=0;
			String subProgramme="";
			totWorkPop=0;
			String nHabsStr=rs2.getString(12);
			if(nHabsStr==null || nHabsStr.equals("")){
				nHabsStr="0";
			}
			int noofHabs=Integer.parseInt(nHabsStr);
			
			
			double probExp=0,probExpNextYear=0;
			subProgramme=rs2.getString(11);
			String pop_exp="";
			
			
			myprob_date=rs2.getString(13);
			
			String val=(String)contractorExpHash.get(workId);
			
			if(val!=null)
			{
			
				String vals[]=val.split("@");
				if(vals[0]!=null && !vals[0].equals("null") ){
					probExp=Double.parseDouble(vals[0]);
				}
				if(vals[1]!=null && !vals[1].equals("null")){
					probExpNextYear=Double.parseDouble(vals[1]);
				}
				
				
			}
			//System.out.println("probExpNextYear...."+probExpNextYear);
			String completed="-",grounded="-";
			
			if(completeHash.get(workId)!=null){
				completed="Completed";
				
			}
			
			if(groundHash.get(workId)!=null){
				grounded="Grounded";
				
			}
			
			
			
			if(rs2.getString(10)!=null){
			subplanSubmitted=rs2.getString(10);
			}else{
				subplanSubmitted="-";
				
			}
			////System.out.println("Subplan Submitted:"+subplanSubmitted);
			
		    if(programLinkHash.get(rs2.getString(3))!=null){
		    	
		    	moreProgramSanctioned=Double.parseDouble((String)programLinkHash.get(rs2.getString(3)));
		    }else{
		    	moreProgramSanctioned=0;
		    }
		    String sn=rs2.getString(6);
		    double sanctionedAmount=0;
		    if(sn!=null){
			 sanctionedAmount=Double.parseDouble(sn);
		    }
			sanctionedAmount+=moreProgramSanctioned;
			gsanctionedAmount+=sanctionedAmount;
			if(expHash.get(rs2.getString(3))!=null && !expHash.get(rs2.getString(3)).equals(""))
			{
			 
				//expUpto
				String expValues=(String)expHash.get(rs2.getString(3));
				
				if(expValues!=null && !expValues.equals(" ")){
				expDuring=Double.parseDouble(expValues);
				}else{
					expDuring=0;
				}
				
				
			}
			
			////////////////
			
			if(expHash1.get(rs2.getString(3))!=null && !expHash1.get(rs2.getString(3)).equals(""))
			{
			 
				//expUpto
				String expValues1=(String)expHash1.get(rs2.getString(3));
				
				if(expValues1!=null && !expValues1.equals(" "))
				{
				expDuring1=Double.parseDouble(expValues1);
				}
				else
				{
					expDuring1=0;
				}
				
				
			}
			
			
			////////////////
			
			String categoryCode=rs2.getString(7);
			typeOfAsset=rs2.getString(8);
			double balanceEST=sanctionedAmount-expUpto;
			
			ggbalanceEST+=balanceEST;
			double stateSharePer=0,lstateSharePer=0,lNstateSharePer=0,expDuringCentralShare=0,expDuringStateShare=0,expDuringCentralShare1=0,expDuringStateShare1=0,scstateshare=0;
			String programeCode=rs2.getString(9);
			
			if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
			
				stateSharePer=0.5*balanceEST;
				lstateSharePer=0.5*probExp;
				lNstateSharePer=0.5*probExpNextYear;////200*0.5=100
				expDuringCentralShare=0.5*expDuring;
				expDuringStateShare=0.5*expDuring;
				
				expDuringCentralShare1=0.5*expDuring1;
				expDuringStateShare1=0.5*expDuring1;
				
				scstateshare=0.5*sanctionedAmount;
				
				
			}
			else if(programeCode!=null && (programeCode.equals("65") || programeCode.equals("12") || programeCode.equals("46")|| programeCode.equals("57")|| programeCode.equals("04")|| programeCode.equals("09")|| programeCode.equals("39") || programeCode.equals("15") )){
				
				stateSharePer=balanceEST;
				lstateSharePer=probExp;////200;
				lNstateSharePer=probExpNextYear;
				expDuringStateShare=expDuring;
				expDuringStateShare1=expDuring1;
				scstateshare=sanctionedAmount;
				
			}
			
			if(workId.substring(4,6)!=null&& workId.substring(4,6).equals("12") && programeCode.equals("58")){
				stateSharePer=0.0;
				lstateSharePer=0.0;////0
				lNstateSharePer=0.0;
				expDuringStateShare=0;
				expDuringStateShare1=0;
				scstateshare=0;
				
				//Not Showing Under SCSP BalEst==0 works for Ananthpur DDP Works
				continue;
			}
			
			
			
			//System.out.println("lstateSharePer::"+lstateSharePer);
		
			
			
			String balanceEST1=(String.valueOf(ndf.format(sanctionedAmount-expUpto)));
			String sanctionedAmount1=(String.valueOf(ndf.format(sanctionedAmount)));	
		
			 /////////////////Exp Calculation///////////////////
			
			/*	double plainPOP_exp=0,scPOP_exp=0,stPOP_exp=0;
			     int totPop_exp=0;
				 pop_exp=(String)sanctionAmtQeryHash.get(rs2.getString(3));
			    if(pop_exp!=null)
			    {
				 String popValues_exp[]=pop_exp.split("@");
				 
		 		  plainPOP_exp=Double.parseDouble(popValues_exp[0]);
		 		  scPOP_exp=Double.parseDouble(popValues_exp[1]);
		 		  stPOP_exp=Double.parseDouble(popValues_exp[2]);
		 		  totPop_exp=Integer.parseInt(popValues_exp[0])+Integer.parseInt(popValues_exp[1])+Integer.parseInt(popValues_exp[2]);
			    }
		 	
			underscexp=(sanctionedAmount/totPop_exp)*scPOP_exp;
	        underotherexp=sanctionedAmount-underscexp;
	    	
			String uscexp=(String.valueOf(ndf.format(underscexp)));
			String uothscexp=(String.valueOf(ndf.format(underotherexp)));
			

	      	ggunderscexp+=underscexp;
			ggunderotherexp+=underotherexp;*/
			
		  
			
			
			
			/////////////////////////////////////////


			String strTemp="";
				
				if(!typeOfAsset.equals("11")){
					if(totalPOPHash.get(rs2.getString(3))!=null && !totalPOPHash.get(rs2.getString(3)).equals(""))
					{
				       
				       strTemp=(String)totalPOPHash.get(rs2.getString(3));
					}
				}else if(typeOfAsset.equals("11"))
				{
					
					strTemp=(String)schoolTotPOPHash.get(rs2.getString(3));
				}
				
				if(strTemp!=null && !strTemp.equals("")){
					
					
					//Add code here 
					
					
					String popValues[] = strTemp.split("@");

					int plainPop_Tot = Integer.parseInt(popValues[0]);
					int scPop_Tot = Integer.parseInt(popValues[1]);
					int st_Tot = Integer.parseInt(popValues[2]);
					
					totWorkPop =plainPop_Tot+scPop_Tot+st_Tot;
					
					//Not Showing SC Population==0 Works
					if(scPop_Tot==0){
						continue;
					}
					
					
					//percentage total work wise
					
						double plainPerT = ((double)plainPop_Tot * 100/(double) totWorkPop);
							double scPerT = ((double)scPop_Tot * 100/ (double)totWorkPop);
							double stPerT = ((double)st_Tot * 100/ (double)totWorkPop);
					
							
						//Not Showing ST>40 Works
					if(stPerT>=40){
						continue;
					}
					 
					
					
					if(totWorkPop==0){
						continue;
						
					}
				} 
				
					 //////////END....................
			
			
			
			double expPerPerson=0,expPerPerson1=0;
			if(expDuring>0 && totWorkPop>0)
			{
			 expPerPerson=(expDuring/totWorkPop);
			}
			if(expDuring1>0 && totWorkPop>0)
			{
			 expPerPerson1=(expDuring1/totWorkPop);
			}
			////System.out.println("totalPOPHash.get(rs2.getString(3):"+totalPOPHash.get(rs2.getString(3)));
			
			////System.out.println("balanceEST"+balanceEST);
			String admnDate=rs2.getString(5);
			////System.out.println("admnDate:"+admnDate);//17/08/2012
			java.util.Date d1=new java.util.Date(Integer.parseInt(admnDate.substring(6,10)),Integer.parseInt(admnDate.substring(3,5)),Integer.parseInt(admnDate.substring(0,2)));
			java.util.Date d2=new java.util.Date(2013,2,31);
				
			if(d1.after(d2)){
				workType="New Work";
			}else{
				workType="Spill Over";
			}
			
			
			
			if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			
			
			 %>
			 
			 <tr><td class=<%=style %>><%=recCount++ %></td>
			 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(1) %></td>
			 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Sub Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(11) %></td>
			 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(2) %></td>
			 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Work Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(4) %></td>
			  <%  
			 if(categoryCode.equals("1") || noofHabs>1)
			 {
			 
			 %>
			 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Head Of Account',TITLE,'Information')" onmouseout="UnTip()">-</td>
			 
			 <% } 
			 else 
			 {%>
			 		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Head Of Account',TITLE,'Information')" onmouseout="UnTip()">&nbsp;<%=workId  %></td>
			 <%  } %>
			 
		 
			 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Nature Of the Work',TITLE,'Information')" onmouseout="UnTip()"><%=workType %></td>
			 
			 <% 
		
			
			 String habQuery="";
			 if(!typeOfAsset.equals("11")){
			 
			  habQuery="select a.hab_code,b.PANCH_NAME,b.MNAME,b.PNAME,b.vname,EXIST_WATER_LEVEL from rws_admn_hab_lnk_tbl a,rws_complete_hab_view b where a.work_id='"+rs2.getString(3)+"' and a.hab_code=b.panch_code";
			 }else if(typeOfAsset.equals("11")){
				 
				 habQuery="select a.hab_code,b.PANCH_NAME,b.MNAME,b.PNAME,b.vname,EXIST_WATER_LEVEL from rws_work_school_lnk_tbl a,rws_complete_hab_view b where a.work_id='"+rs2.getString(3)+"' and a.hab_code=b.panch_code";
			 }
			
		 	rs3=stmt3.executeQuery(habQuery);
			
		 	
		 	boolean flag2=false;
		 	
		 	int gplainpop=0,gscPOP=0,gstPop=0;
		 	int gtotPOP=0;
		 	
		 	double gplainEST=0,gscEST=0,gstEST=0; 	double gstateplainEST=0,gstatescEST=0,gstatestEST=0;
		 	double gplainExp=0,gscEXp=0,gstExp=0,gtotalEXP=0;
		 	double gplainExp1=0,gscEXp1=0,gstExp1=0,gtotalEXP1=0;
		 	//likely expenditure
		 	
		 	double glNCenExp=0,glCenExp=0,glTotExp=0,glPlainTot=0,glScTot=0,glStTot=0,glTotTot=0,glNTotExp=0,glNPlainTot=0,glNScTot=0,glNStTot=0,glNTotTot=0,gexpDuringCen=0,gexpDuringCen1=0;
		 	double gtotEST=0;
			double gstatetotEST=0;
			
			double gExpSc=0,gExpSt=0,gExpPlain=0,gExpTot=0;
			double gExpSc1=0,gExpSt1=0,gExpPlain1=0,gExpTot1=0;
			
			double totsanamt=0,underscexp=0,underotherexp=0;
			 	
			
		 	while(rs3.next())
		 	{
		 		
		 		String coverageStatus="";
		 	double  existingWaterLevel=0,myamt=0;
		 		//double scstateshare=0;
		 		
		 		if(rs3.getString(6)!=null && !rs3.getString(6).equals(" ")){
		 			
		 			existingWaterLevel=Double.parseDouble(rs3.getString(6));
		 		}
		 		
		 		if(existingWaterLevel>0 && existingWaterLevel<13.75)
				{
						coverageStatus = "PC1";
				}
				else if(existingWaterLevel>=13.25 && existingWaterLevel<27.50)
				{
						coverageStatus = "PC2";
				}
				else if(existingWaterLevel>=27.50 && existingWaterLevel<41.25)
				{
						coverageStatus = "PC3";
				}
				else if(existingWaterLevel>=41.25 && existingWaterLevel<55)
				{
						coverageStatus = "PC4";
				}
				else if(existingWaterLevel>=55)
				{
						coverageStatus = "FC";
				}else{
					coverageStatus = "NC";
				}
		 		
		 		
		 		
		 		String pop="";
		 		 if(!typeOfAsset.equals("11"))
		 		 {
		 		 pop=(String)sanctionedHabsHash.get(rs3.getString(1));
		 		 }else if(typeOfAsset.equals("11"))
		 		 {
		 			pop=(String)schoolTotPOPHash.get(rs3.getString(1));
		 		 }
		 	
		 		String popValues[]=pop.split("@");
		 		double plainPOP=Double.parseDouble(popValues[0]);
		 		double  scPOP=Double.parseDouble(popValues[1]);
		 		double stPOP=Double.parseDouble(popValues[2]);
		 		
		 		gplainpop+=plainPOP;
		 		gscPOP+=scPOP;
		 		gstPop+=stPOP;
		 		
		 		
		 		double totPop=plainPOP+scPOP+stPOP;
		 		gtotPOP+=totPop;
		 		int totPP=Integer.parseInt(popValues[0])+Integer.parseInt(popValues[1])+Integer.parseInt(popValues[2]);
		 		
		 		ggplainpop+=plainPOP;
		 		ggscPOP+=scPOP;
		 		ggstPop+=stPOP;
		 		ggtotPOP+=totPP;
		 		
		 		 
		 		////////////////////////////////////////////////////
		 		
		 		
				
				
				//******************************
				
				int  totPop_exp=0;
				 pop_exp=(String)sanctionAmtQeryHash.get(rs2.getString(3));
			    if(pop_exp!=null)
			    {
				 String popValues_exp[]=pop_exp.split("@");
				 
		 		  double plainPOP_exp=Double.parseDouble(popValues_exp[0]);
		 		  double scPOP_exp=Double.parseDouble(popValues_exp[1]);
		 		  double stPOP_exp=Double.parseDouble(popValues_exp[2]);
		 		  totPop_exp=Integer.parseInt(popValues_exp[0])+Integer.parseInt(popValues_exp[1])+Integer.parseInt(popValues_exp[2]);
			    
			    
			     totsanamt=(sanctionedAmount/totPop_exp)*totPP;
			     
				//System.out.println("Sanction amount......."+sanctionedAmount);
				//System.out.println("grand pop amount......."+gtotPOP);
				//System.out.println("total pop amount......."+totPP);
			    }
			    
				gtotsanamt+=totsanamt;
				
				ggtotsanamt+=totsanamt;
				
				 /////////////////////////////////
				 
				
	            
				underscexp=(scstateshare/totPop_exp)*scPOP;
			             
			    double totStateEst=(scstateshare/totPop_exp)*totPop;
				 
			    
				//underscexp=(totsanamt/totPP)*scPOP;
				
		        underotherexp=totStateEst-underscexp;
		        	
				
				String uscexp=(String.valueOf(ndf.format(underscexp)));
				String uothscexp=(String.valueOf(ndf.format(underotherexp)));
				
				gunderscexp+=underscexp;
				gunderotherexp+=underotherexp;
		
		      
				ggunderscexp+=underscexp;
				ggunderotherexp+=underotherexp;
		 		
				
				
				
				
		 		
		 		////////////////////////////////////////////////
	        
		 		
		 		double plainPer=0,scPer=0,stPer=0;
		 		
		 		plainPer = (plainPOP * 100/ totPop);
		 		scPer = (scPOP * 100/ totPop);
		 		stPer = (stPOP * 100/ totPop);
		 		
		 		
		 		//double plainBalanceEST=(balanceEST*plainPOP)/totPop;
		 		//double scBalanceEST=(balanceEST*scPOP)/totPop;
		 		//double stEST=(balanceEST*stPOP)/totPop;
		 		double totEST=0,statetotEST=0,totstateEST=0;
		 		double plainBalanceEST=0,scBalanceEST=0,stEST=0;
		 		double stateplainBalanceEST=0,statescBalanceEST=0,statestEST=0;
		 		
		 		//addded new columns
		 		
		 		double lCentralShare=0,lPlainExp=0,lScExp=0,lStExp=0,lTotExp=0;
		 		double expSc=0,expPlain=0,expSt=0,expCentral=0,expSc1=0,expPlain1=0,expSt1=0,expCentral1=0;
		 		double lNCentralShare=0,lNPlainExp=0,lNScExp=0,lNStExp=0,lNTotExp=0;
		 		
		 		 double plainExp=0;
		 		 double scExp=0;
		 		 double stExp=0;
		 		 double plainExp1=0;
		 		 double scExp1=0;
		 		 double stExp1=0;
		 		 lCentralShare=probExp-lstateSharePer;
		 		 lNCentralShare=probExpNextYear-lNstateSharePer;
		 		 
		 		 double lCenExp=0,lNCenExp=0,expDuringCen=0,expDuringCen1=0;
		 		 
		 		if(categoryCode.equals("2"))
		 		{
		 			double balance2=(stateSharePer/totWorkPop);
		 			double balance1=(balanceEST/totWorkPop);
		 			double balance3=(lCentralShare/totWorkPop);
		 			double balance4=(lstateSharePer/totWorkPop);
		 			double balance5=(lNCentralShare/totWorkPop);
		 			double balance6=(lNstateSharePer/totWorkPop);
		 			double balance7=(expDuringCentralShare/totWorkPop);
		 			double balance8=(expDuringStateShare/totWorkPop);
		 			
		 			double balance9=(expDuringCentralShare1/totWorkPop);
		 			double balance10=(expDuringStateShare1/totWorkPop);
		 			
		 			//System.out.println("balance4......"+balance4);
		 			
		 			double  habPop=plainPOP+stPOP+scPOP;
		 			if(scPer>=40)
		 			{
		 				clauseType="SC > 40%";
		 				scBalanceEST=balanceEST;
		 				plainBalanceEST=0;
		 				stEST=0;
		 				
		 				
		 				//Expenditure
		 				scExp=expDuring;
		 				plainExp=0;
		 				stExp=0;
		 				
		 				//Expenditure1
		 				scExp1=expDuring1;
		 				plainExp1=0;
		 				stExp1=0;
		 				
		 				//******State Share 
		 				
		 				statescBalanceEST=stateSharePer;
		 				stateplainBalanceEST=0;
		 				statestEST=0;
		 				
		 				lScExp=balance4*habPop;
		 				lNScExp=balance6*habPop;
		 				
		 				expSc=balance8*habPop;
		 				expSc1=balance10*habPop;
		 				
		 				//System.out.println("lScExp......"+lScExp);
		 				
		 			}else 
		 			if(stPer>=40){
		 				
		 				
		 				clauseType="ST > 40%";
		 				
		 				stEST=balanceEST;
		 				plainBalanceEST=0;
		 				scBalanceEST=0;
		 				
		 				
		 				//Expenditure
		 				
		 				
		 				stExp=expDuring;
		 				plainExp=0;
		 				scExp=0;
		 				
		 				stExp1=expDuring1;
		 				plainExp1=0;
		 				scExp1=0;
		 				
						//******State Share 
		 				
		 				statescBalanceEST=0;
		 				stateplainBalanceEST=0;
		 				statestEST=stateSharePer;
		 				
		 				lStExp=balance4*habPop;
		 				lNStExp=balance6*habPop;
		 				
		 				expSt=balance8*habPop;
		 				expSt1=balance10*habPop;
		 				//System.out.println("lStExp......"+lStExp);
		 			}else {
		 				
		 				
		 				if(scPOP==0 && stPOP==0)
		 				{
		 					clauseType="Plain Hab";
		 				}else
		 				{
		 				clauseType="< 40%";
		 				}
		 				
		 				
		 				//plainBalanceEST=balanceEST;
		 				////System.out.print("plainPOP"+plainPOP);
		 				////System.out.print("balance1"+balance1);
		 				
		 				plainBalanceEST=(balance1*plainPOP);
		 				if(scPOP>0){
		 				scBalanceEST=(balance1*scPOP);
		 				}else{
		 					scBalanceEST=0;
		 				}
		 				if(stPOP>0){
		 				stEST=(balance1*stPOP);
		 				}else{
		 					stEST=0;
		 				}
		 				
		 				
		 				//Expenditure
		 				stExp=expPerPerson*stPOP;
		 				plainExp=expPerPerson*plainPOP;
		 				scExp=expPerPerson*scPOP;
		 				
		 				stExp1=expPerPerson1*stPOP;
		 				plainExp1=expPerPerson1*plainPOP;
		 				scExp1=expPerPerson1*scPOP; 
		 				//System.out.println("scExp......"+scExp);
						//******State Share 
		 				
		 				statescBalanceEST=(balance2*scPOP);
		 				stateplainBalanceEST=(balance2*plainPOP);
		 				statestEST=(balance2*stPOP);
		 				
		 				//added likely Expenditure Columns Data
		 				lScExp=(balance4*scPOP);
		 				lStExp=(balance4*stPOP);
		 				lPlainExp=(balance4*plainPOP);
		 				
		 				//System.out.println("lScExp......"+lScExp);
		 				
		 				//added
		 				
		 				
		 				lNScExp=(balance6*scPOP);
		 				lNStExp=(balance6*stPOP);
		 				lNPlainExp=(balance6*plainPOP);
		 				
		 				//System.out.println("lNScExp......"+lNScExp);
		 				//exp during
		 				
		 				expSc=(balance8*scPOP);
		 				expSt=(balance8*stPOP);
		 				expPlain=(balance8*plainPOP);
		 				
	                      //exp1 during
		 				
		 				expSc1=(balance10*scPOP);
		 				expSt1=(balance10*stPOP);
		 				expPlain1=(balance10*plainPOP);
		 				//System.out.println("expSc......"+expSc);
		 				
		 				
		 				
		 			}
		 			lCenExp=balance3*(habPop);
		 			lNCenExp=balance5*(habPop);
		 			expDuringCen=balance7*(habPop);
		 			expDuringCen1=balance9*(habPop);
		 		}else if(categoryCode.equals("1"))
		 		{
		 			////System.out.println("totWorkPop:"+totWorkPop);
		 			
		 			double balance1=(balanceEST/totWorkPop);
		 			
		 			double balance2=(stateSharePer/totWorkPop);
		 			
		 			double balance3=(lCentralShare/totWorkPop);
		 			
		 			double balance4=(lstateSharePer/totWorkPop);
		 			
		 			double balance5=(lNCentralShare/totWorkPop);
		 			
		 			double balance6=(lNstateSharePer/totWorkPop);
		 			
		 			double balance7=(expDuringCentralShare/totWorkPop);
		 			double balance8=(expDuringStateShare/totWorkPop);
		 			
		 			double balance9=(expDuringCentralShare1/totWorkPop);
		 			double balance10=(expDuringStateShare1/totWorkPop);
		 			
		 			double  habPop=plainPOP+stPOP+scPOP;
		 			
		 			//System.out.println("balance4......"+balance4);
		 			//System.out.println("balance5......"+balance5);
		 			
		 			if(scPer>=40){
		 				clauseType="SC > 40%";
		 				//scPOP+=plainPOP+stPOP;
		 				scBalanceEST=(balance1*habPop);
		 				
		 				//scBalanceEST=balance1;
		 				plainBalanceEST=0;
		 				stEST=0;
		 				
		 				//Expenditure
		 				
		 				 scExp=expPerPerson*habPop;
		 				plainExp=0;
		 				stExp=0;
		 				
		 				//Expenditure
		 				
		 				 scExp1=expPerPerson1*habPop;
		 				plainExp1=0;
		 				stExp1=0;
		 				//******State Share
		 				
		 				statescBalanceEST=balance2*habPop;
		 				stateplainBalanceEST=0;
		 				statestEST=0;
		 				
		 				lScExp=balance4*habPop;
		 				lNScExp=balance6*habPop;
		 				
		 				
		 				expSc=balance8*habPop;
		 				expSc1=balance10*habPop;
		 				
		 				
		 				
		 				
		 			}else if(stPer>=40){
		 				clauseType="ST > 40%";
		 				
		 				///stPOP+=plainPOP+scPOP;
		 				stEST=(balance1*habPop);
		 				//stEST=balance1;
		 				plainBalanceEST=0;
		 				scBalanceEST=0;
		 				
		 				
		 				//Expenditure
		 				
		 				 stExp=expPerPerson*habPop;
		 				plainExp=0;
		 				scExp=0;
		 				
		 				//Expenditure1
		 				
		 				 stExp1=expPerPerson1*habPop;
		 				plainExp1=0;
		 				scExp1=0;
		 				
						//******State Share
		 				
		 				statescBalanceEST=0;
		 				stateplainBalanceEST=0;
		 				statestEST=(balance2*habPop);
		 				
		 				
		 				lStExp=balance4*habPop;
		 				lNStExp=balance6*habPop;
		 				
		 				
		 				expSt=balance8*habPop;
		 				expSt1=balance10*habPop;
		 				
		 			}else{
		 			
		 				
		 				
		 				if(scPOP==0 && stPOP==0)
		 				{
		 					clauseType="Plain Hab";
		 				}else{
		 				clauseType="< 40%";
		 				}
		 				plainBalanceEST=(balance1*plainPOP);
		 				scBalanceEST=(balance1*scPOP);
		 				stEST=(balance1*stPOP);
		 				
		 				
		 				
		 				
		 				
		 				
		 				//Expenditure
		 				
		 				 stExp=expPerPerson*stPOP;
		 				plainExp=expPerPerson*plainPOP;
		 				scExp=expPerPerson*scPOP;
		 				
		 				//Expenditure
		 				
		 				 stExp1=expPerPerson1*stPOP;
		 				plainExp1=expPerPerson1*plainPOP;
		 				scExp1=expPerPerson1*scPOP;
						//******State Share
		 				
						statescBalanceEST=(balance2*scPOP);
						stateplainBalanceEST=(balance2*plainPOP);
		 				statestEST=(balance2*stPOP);
		 					
		 					//added likely Expenditure Columns Data
			 				lScExp=(balance4*scPOP);
			 				lStExp=(balance4*stPOP);
			 				lPlainExp=(balance4*plainPOP);
			 				
			 				
			 				///exp
			 				lNScExp=(balance6*scPOP);
			 				lNStExp=(balance6*stPOP);
			 				lNPlainExp=(balance6*plainPOP);
			 				
			 				
			 	         //exp during 
			 	         
			 				expSc=(balance8*scPOP);
			 				expSt=(balance8*stPOP);
			 				expPlain=(balance8*plainPOP);
			 				
			 				//exp during 1
				 	         
			 				expSc1=(balance10*scPOP);
			 				expSt1=(balance10*stPOP);
			 				expPlain1=(balance10*plainPOP);
			 				
		 			}
		 			
		 			
		 			
		 			lCenExp=balance3*(habPop);
		 			
		 			lNCenExp=balance5*(habPop);
		 			
		 			expDuringCen=balance7*(habPop);
		 			expDuringCen1=balance9*(habPop);
		 			
		 		}
		 		
		 		
		 		//expenditure
		 		
		 		glCenExp+=lCenExp;
		 		
		 		glNCenExp+=lNCenExp;
		 		
		 		
		 		gglCenExp+=lCenExp;
		 		
		 		gglNCenExp+=lNCenExp;
		 		
		 		
		 	
		 		glTotExp=lCenExp+lPlainExp+lScExp+lStExp;
		 		
		 		gglPlainExp+=lPlainExp;
		 		gglScExp+=lScExp;
		 		gglStExp+=lStExp;
		 		
		 		gglTotExp+=glTotExp;
		 		
		 		
		 		glNTotExp=lNCenExp+lNPlainExp+lNScExp+lNStExp;
		 		
		 		gglNTotExp+=glNTotExp;
		 		
		 		
		 		gglNPlainExp+=lNPlainExp;
		 		gglNScExp+=lNScExp;
		 		gglNStExp+=lNStExp;
		 		
		 		
		 		
		 		
		 		
		 		glPlainTot+=lPlainExp;
		 		glScTot+=lScExp;
		 		glStTot+=lStExp;
		 		glTotTot+=glTotExp;
		 		
		 		
		 		
		 		glNPlainTot+=lNPlainExp;
		 		glNScTot+=lNScExp;
		 		glNStTot+=lNStExp;
		 		glNTotTot+=glNTotExp;
		 		
		 		
		 		gExpSc+=expSc;
		 		gExpSc1+=expSc1;
		 		
		 		gExpSt+=expSt;
		 		gExpPlain+=expPlain;
		 		
		 		gExpSt1+=expSt1;
		 		gExpPlain1+=expPlain1;
		 		
		 		ggexpSc+=expSc;
		 		ggexpSt+=expSt;
		 		ggexpPlain+=expPlain;
		 		
		 		ggexpSc1+=expSc1;
		 		ggexpSt1+=expSt1;
		 		ggexpPlain1+=expPlain1;
		 		
		 		gexpDuringCen+=expDuringCen;
		 		
		 		ggexpDuringCen+=expDuringCen;
		 		
	            gexpDuringCen1+=expDuringCen1;
		 		
		 		ggexpDuringCen1+=expDuringCen1;
		 		
		 		double totExpDur=expSc+expSt+expPlain+expDuringCen;
		 		ggexpTot+=totExpDur;
		 		gExpTot+=totExpDur;
		 		
		 		double totExpDur1=expSc1+expSt1+expPlain1+expDuringCen1;
		 		ggexpTot1+=totExpDur1;
		 		gExpTot1+=totExpDur1;
		 		
		 		
		 		
		 		 double totalEXP=plainExp+scExp+stExp;
		 		 
		 		gplainExp+=plainExp;
		 		gscEXp+=scExp;
		 		gstExp+=stExp;
		 		
		 		double totalEXP1=plainExp1+scExp1+stExp1;
		 		 
		 		gplainExp1+=plainExp1;
		 		gscEXp1+=scExp1;
		 		gstExp1+=stExp1;
		 		//Exp
		 		
		 		 ggplainExp+=plainExp;
		 		ggscEXp+=scExp;
		 		ggstExp+=stExp;
		 		
		 		//Exp
		 		
		 		 ggplainExp1+=plainExp1;
		 		ggscEXp1+=scExp1;
		 		ggstExp1+=stExp1;
		 		//exp
		 		
		 		
		 		gtotalEXP+=totalEXP;
		 		
		 		
		 		ggtotalEXP+=totalEXP;
		 		
	//exp1
		 		
		 		
		 		gtotalEXP1+=totalEXP1;
		 		
		 		
		 		ggtotalEXP1+=totalEXP1;
		 		
		 		///////////////////////////**************************
		 		
		 		
		 		
		 		gplainEST+=plainBalanceEST;
		 		gscEST+=scBalanceEST;
		 		gstEST+=stEST;
		 		
		 		
		 		//****
		 		ggplainEST+=plainBalanceEST;
		 		ggscEST+=scBalanceEST;
		 		ggstEST+=stEST;
		 		
		 		//**************
		 		
		 		totEST=plainBalanceEST+scBalanceEST+stEST;
		 		
		 		
		 		gstateplainEST+=stateplainBalanceEST;
		 		gstatescEST+=statescBalanceEST;
		 		gstatestEST+=statestEST;
		 		
		 		//******************
		 		
		 		ggstateplainEST+=stateplainBalanceEST;
		 		ggstatescEST+=statescBalanceEST;
		 		ggstatestEST+=statestEST;
		 		
		 		//*******************
		 		
		 		totstateEST=stateplainBalanceEST+statescBalanceEST+statestEST;
		 		
		 		
		 		gtotEST+=totEST;
		 		
		 		ggtotEST+=totEST;
		 		
		 		gstatetotEST+=totstateEST;
		 		ggstatetotEST+=totstateEST;
		 		
		 		
		 		
				//sta+=(balanceEST*stpop)/totalp;
				//plaina+=(balanceEST*gen)/totalp;
				
		 		
					 		
		 	
		 		flag2=true;
		 		
		 		if(!flag){
		 			workId="-";
		 			if(styleCount%2==0){
		 				 style="gridbg1";
		 			 }else{
		 				 style="gridbg2";
		 			 }
		 			 styleCount++;
		 			%>
		 			
		 			<tr><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %> >-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td>
		 			<% 
		 			
		 			}
		 		
		 		
		 		%>
		 		
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Mandal',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(3) %></td>
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Panchyath',TITLE,'Information')" onmouseout="UnTip()" ><%=rs3.getString(4) %></td>
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('HabCode',TITLE,'Information')" onmouseout="UnTip()">&nbsp;<%=rs3.getString(1) %></td>
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Existing Water Level',TITLE,'Information')" onmouseout="UnTip()"><%=existingWaterLevel %></td>
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Coverage Status',TITLE,'Information')" onmouseout="UnTip()"><%=coverageStatus %></td>
		 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Hab Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(2) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(totsanamt) %> </td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Under SCSP Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=uscexp %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Under Other SCSP Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(totsanamt-underscexp) %></td>
		 		<%-- <td class=<%=style %> style="text-align: right;" onmouseover="Tip('Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=balanceEST1 %></td> --%>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Population',TITLE,'Information')" onmouseout="UnTip()"><%=popValues[0] %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Population',TITLE,'Information')" onmouseout="UnTip()" ><%=popValues[1] %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Population',TITLE,'Information')" onmouseout="UnTip()" ><%=popValues[2] %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Population',TITLE,'Information')" onmouseout="UnTip()"><%=totPP %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Population%',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer) %></td>
		 		<%-- <td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainBalanceEST) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scBalanceEST)  %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(stEST) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totEST) %></td>
		 		 --%><%-- <td class=<%=style %> style="text-align: right;" onmouseover="Tip('State Share- Plain Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"> <%=ndf.format(stateplainBalanceEST) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('State Share- SC Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()" ><%= ndf.format(statescBalanceEST) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('State Share- ST Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()"><%= ndf.format(statestEST) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('State Share- Total Balance Estimate Cost.',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(totstateEST) %></td>
	 --%>	 		<td class=<%=style %> style="text-align: center;" onmouseover="Tip('Clause Type',TITLE,'Information')" onmouseout="UnTip()"><%=clauseType %></td>
		 		
		 		<td class=<%=style %> style="text-align: center;"><%=subplanSubmitted %></td>
		 		<%--  --%>	
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lNCenExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lNPlainExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lNScExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- ST Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lNStExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely NxtYr- Under Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotExp-lNScExp) %></td>
		 		
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lCenExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lPlainExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lScExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely ST Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lStExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotExp) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotExp-lScExp) %></td>
		 		
		 		
		 		
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Central Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expDuringCen) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expPlain) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Sc Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expSc) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expSt) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur)  %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Under Other Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur-expSc)  %></td>
		 		
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expDuringCen1) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expPlain1) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expSc1) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During ST Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expSt1) %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur1)  %></td>
		 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm.During Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur1-expSc1)  %></td>
		 	
		 		<td class=<%=style %> style="text-align: center;" onmouseover="Tip('Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
		 		
		 		<td class=<%=style %> style="text-align: center;" onmouseover="Tip('Probable Date of Completion',TITLE,'Information')" onmouseout="UnTip()"><%=myprob_date %></td>
		 		</tr>
		 		
		 		<% 
		 		
		 		balanceEST1="-";
		 		sanctionedAmount1="-";
		 		//uscexp="-";
		        //uothscexp="-";
			 	
		 		flag=false;
		 	
		 		
		 		
		 	}
		 	if(!flag2){
		 		
		 		
		 		
		 		%>
		 		<td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td>
		 		<% 
		 	
		 		
		 	}
		 	
		 	double scPer1=0,plainPer1=0,stPer1=0;
		 	if(gplainpop>0){
		 	 plainPer1 = ((double)gplainpop * 100/ gtotPOP);
		 	}
		 	if(gscPOP>0){
	 		 scPer1 = ((double)gscPOP * 100/ gtotPOP);
		 	}
		 	if(gstPop>0){
	 		 stPer1 = ((double)gstPop * 100/ gtotPOP);
		 	}
		 	
		 	
		 	if(scPer1>=40)
			{
				clauseType1="SC > 40%";
			}
			else if(stPer1 >= 40)
			{
				clauseType1="ST > 40%";
			}
			else
			{
				if(gscPOP==0 && gstPop==0)
				{
					clauseType1="Plain Hab";
				}else
				{
				clauseType1="< 40%";
				}
			}
		 	
		 	
	 		
		 	if(categoryCode.equals("1") || workId.equals("-")){
			 	%>
			 	
			 	<tr><td class=<%=style %> style="text-align: left;">-</td>
			 	<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(1) %></td>
				 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Sub Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(11) %></td>
				 
				 			 
				 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(2) %></td>
				  
				 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Work Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(4) %></td>
				 <td class=<%=style %> style="text-align: right;">&nbsp;<%=rs2.getString(3) %></td>
				 <td class=gridhdbg colspan=7 style="text-align: right;">Total:</td>
		 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(gtotsanamt) %></td>
		 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: SCSP Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(gunderscexp) %></td>
		 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Other SCSP Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gtotsanamt-gunderscexp) %></td>
		 	
		 	<%-- <td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(balanceEST) %></td> --%>
		 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Plain Population',TITLE,'Information')" onmouseout="UnTip()"><%=gplainpop %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total SC Population',TITLE,'Information')" onmouseout="UnTip()"><%=gscPOP %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total ST Population',TITLE,'Information')" onmouseout="UnTip()"><%=gstPop %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Population(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=gtotPOP %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: SC Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer1) %></td>
		 	<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Plain Estimate Cost ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gplainEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total SC Estimate Cost ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gscEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total ST Estimate Cost ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gstEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Estimate Cost (Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gtotEST) %></td>
		 --%> 	<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: State Share Of Plain Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gstateplainEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: State Share Of SC Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"> <%= ndf.format(gstatescEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: State Share Of ST Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%= ndf.format(gstatestEST) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: State Share Of Total Estimate Cost(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gstatetotEST) %></td>
		  --%>	<td class=gridhdbg><%=clauseType1 %></td><td class=gridhdbg style="text-align: center;"><%=subplanSubmitted %></td>
		 	
		 	
		 	<%-- < --%> 	
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- Central Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNCenExp) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNPlainTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNScTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNStTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- Total Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely NxtYr- Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotTot-glNScTot) %></td>
		 	
		 	
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glCenExp) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glPlainTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glScTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glStTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely Total Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotTot-glScTot) %></td>
		 
		 	
		 	
		 	
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gexpDuringCen) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Plain Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpPlain) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.SC  Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSc) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. ST Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSt) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Total Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.Under Other Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot-gExpSc) %></td>
		 	
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gexpDuringCen1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During Plain Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpPlain1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During SC  Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSc1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During ST Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSt1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During Total Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot1) %></td>
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.During Under Other Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot1-gExpSc1) %></td>
		 	
		 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Physical Status',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
		 	<td class=gridhdbg>-</td>
		 	
		 	</tr>
				
			
			<% 
	 		}
		
		}   //End Main Loop
		
		
		    double plainPer1 = ((double)ggplainpop * 100/ ggtotPOP);
			double scPer1 = ((double)ggscPOP * 100/ ggtotPOP);
			double stPer1 = ((double)ggstPop * 100/ ggtotPOP);
			
			
		%>
			
		<tr><td class=gridhdbg colspan=13 style="text-align: right;">Grand Total:</td>
		<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggtotsanamt) %></td>
		<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('SCSP Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggunderscexp) %></td>
		<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Other SCSP Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggtotsanamt - ggunderscexp) %></td>	
		<%-- <td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggbalanceEST) %></td> --%>
		<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Plain Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggplainpop %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggscPOP %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggstPop %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Population(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ggtotPOP %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer1) %></td>
		<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggplainEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggscEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggstEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Estimate Cost.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggtotEST) %></td>
	 --%>	<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('State Share Of Total Plain Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggstateplainEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('State Share Of Total SC Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"> <%= ndf.format(ggstatescEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('State Share Of Total ST Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%= ndf.format(ggstatestEST) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('State Share Of Total Estimate Cost.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggstatetotEST) %></td>
	 --%>	<td class=gridhdbg>-</td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()">-</td>
		<%-- --%>	
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely NxtYr- Central   Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNCenExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely NxtYr - Plain  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNPlainExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely NxtYr - SC  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNScExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely NxtYr -ST  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNStExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely NxtYr - Total  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNTotExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip(' Likely NxtYr  - Under Other SCSp',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNTotExp-gglNScExp) %></td>
		
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Total Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglCenExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Total SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglPlainExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Total ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglScExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Total  Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglStExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Total  Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglTotExp) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglTotExp-gglScExp) %></td>
		
		
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.  Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpDuringCen) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.Plain  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpPlain) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Sc  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSc) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. St  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSt) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Total  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Underother Funds  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot-ggexpSc) %></td>
		
		
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During  Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpDuringCen1) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During Plain  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpPlain1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During Sc  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSc1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During St  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSt1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During Total  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot1) %></td>
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.During Underother Funds  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot1-ggexpSc1) %></td>
		
		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Status.',TITLE,'Information')" onmouseout="UnTip()">-</td>
		<td class=gridhdbg>-</td>
	 	</tr>
		<% 

	}catch(Exception e){
	  e.printStackTrace();
	}

	 %>

	</table>	
	</body>
	</html>
