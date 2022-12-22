<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SC/ST1415_ActionPlan_Abstract.xls");

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

<table border = 1 cellspacing = 0 cellpadding = 0 width="60%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr >
		<td align="center" class="gridhdbg" colspan=18>Abstract of SCSP 14-15 for (<%=pname %>) .</td>	
	</tr>
		<tr>
		<td  class="gridhdbg" rowspan="2" >Sl.No</td>   	
    	<td  class="gridhdbg" rowspan="2" >District</td>
    	<td  class="gridhdbg" rowspan="2" >Program</td>
    	<!-- <td  class="gridhdbg" rowspan="2" >Plain Pop</td>
    	<td  class="gridhdbg" rowspan="2" >SC Pop</td>
    	<td  class="gridhdbg" rowspan="2" >ST Pop</td>
    	<td  class="gridhdbg" rowspan="2" >Total Pop</td> -->
    	<td  class="gridhdbg" rowspan="1" colspan="4">Total No.of Works</td>
    <!-- 	<td  class="gridhdbg" rowspan="2" >Plain Pop</td>
    	<td  class="gridhdbg" rowspan="2" >SC Pop</td>
    	<td  class="gridhdbg" rowspan="2" >ST Pop</td>
    	<td  class="gridhdbg" rowspan="2" >Total Pop</td>
    	 -->
    	<td  class="gridhdbg" rowspan="1" colspan="4">Total No.of Works(SC>40)</td>
    	</tr>
    	<tr>
    	<td  class="gridhdbg">No.of Works</td>
    	<td  class="gridhdbg">Total Likely Exp.<br></br>(2014-15)</td>
    	<!-- <td  class="gridhdbg">Plain Pop</td>
    	<td  class="gridhdbg">SC Pop</td>
    	<td  class="gridhdbg">ST Pop</td>
    	<td  class="gridhdbg">Total Pop</td>
    	 --><td  class="gridhdbg">Budget required under SCSP</td>
    	<td  class="gridhdbg">Budget required under Other funds</td>
    	<td  class="gridhdbg">No.of Works</td>
    	<td  class="gridhdbg">Total Likely Exp.<br></br>(2014-15)</td>
    	<!-- <td  class="gridhdbg">Plain Pop</td>
    	<td  class="gridhdbg">SC Pop</td>
    	<td  class="gridhdbg">ST Pop</td>
    	<td  class="gridhdbg">Total Pop</td>
    	 --><td  class="gridhdbg">Budget required under SCSP</td>
    	<td  class="gridhdbg">Budget required under Other funds</td>
    	</tr>
		


<%
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
  try{
	  
	  stmt1=conn.createStatement();
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	   
	  int styleCount=0;
	  String style="",dname="",prg_code="";
	  int recCount=0,wrk_cnt=0,gwrk_cnt=0;
	  double exp_nxtyr=0,gexp_nxtyr=0;
	  stmt2=conn.createStatement();
	  
		String popQery1="select d.dcode,pr.programme_code,sum(nvl(ch.census_plain_popu,0)),sum(nvl(ch.census_sc_popu,0)),sum(nvl(ch.census_st_popu,0)) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd ,rws_complete_hab_view ch ,rws_sc_works_view sc where w.work_id=sc.work_id and w.work_id=l.work_id and l.hab_code=hd.hab_code and hd.hab_code=ch.panch_code and  substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-Apr-"+startyr+"')) and w.work_id not in (select work_id from rws_st_works_view )";
			
		if(dcode!=null && !dcode.equals("00"))
		{
			popQery1+="and D.DCODE='"+dcode+"'";
		}
		
		if(scheme!=null && !scheme.equals(""))
		{
			popQery1+="and w.type_of_asset in("+scheme+")";
		}
		popQery1+=" and  w.programme_code in ("+programe+")  group by  d.dcode,pr.programme_code order by 1,2   ";
		
		//System.out.println("popQery.1."+popQery1);
		
		rs2=stmt2.executeQuery(popQery1);
		Hashtable popQeryHash1=new Hashtable();
		while(rs2.next())
		{
		
			popQeryHash1.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
		}
		
		if(popQeryHash1!=null && popQeryHash1.size()>0){
			
			session.setAttribute("popQeryHash1",popQeryHash1);
		}
				
		
		
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();	
	  
	  ///////////////////////////////////////////////////////////////////////////////////
	    stmt2=conn.createStatement();
		String scwrksQery="select d.dcode,pr.programme_code,sum(nvl(PROB_EXP_NXT_YR,0)),count(*) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr ,rws_sc_works_view sc  where sc.PER_CENT>=40  and w.work_id=sc.work_id and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"')) and w.work_id not in (select work_id from rws_st_works_view )";
			
		if(dcode!=null && !dcode.equals("00"))
		{
			scwrksQery+="and D.DCODE='"+dcode+"'";
		}
		
		if(scheme!=null && !scheme.equals(""))
		{
			scwrksQery+="and w.type_of_asset in("+scheme+")";
		}
		scwrksQery+=" and  w.programme_code in ("+programe+")  group by  d.dcode,pr.programme_code order by 1,2   ";
		
		System.out.println("scwrksQery.."+scwrksQery);
		
		rs2=stmt2.executeQuery(scwrksQery);
		Hashtable scwrksQeryHash=new Hashtable();
		while(rs2.next())
		{
		
			scwrksQeryHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
		}
		
		if(scwrksQeryHash!=null && scwrksQeryHash.size()>0){
			
			session.setAttribute("scwrksQeryHash",scwrksQeryHash);
		}
				
		
		
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	  
////////////////////////////////////////////pop Query//////////////////////////////////////////////////////////////////////////////
		
		
			stmt2=conn.createStatement();
			String popQery="select d.dcode,pr.programme_code,sum(nvl(ch.census_plain_popu,0)),sum(nvl(ch.census_sc_popu,0)),sum(nvl(ch.census_st_popu,0)) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_admn_hab_lnk_tbl l,rws_habitation_directory_tbl hd ,rws_complete_hab_view ch  where w.work_id=l.work_id and l.hab_code=hd.hab_code and hd.hab_code=ch.panch_code and  substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"')) and w.work_id not in (select work_id from rws_st_works_view )";
				
			if(dcode!=null && !dcode.equals("00"))
			{
				popQery+="and D.DCODE='"+dcode+"'";
			}
			
			if(scheme!=null && !scheme.equals(""))
			{
				popQery+="and w.type_of_asset in("+scheme+")";
			}
			popQery+=" and  w.programme_code in ("+programe+")  group by  d.dcode,pr.programme_code order by 1,2   ";
			
			//System.out.println("popQery.."+popQery);
			
			rs2=stmt2.executeQuery(popQery);
			Hashtable popQeryHash=new Hashtable();
			while(rs2.next())
			{
			
				popQeryHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
			}
			
			if(popQeryHash!=null && popQeryHash.size()>0){
				
				session.setAttribute("popQeryHash",popQeryHash);
			}
					
			
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();	


////////////////////////////////////////////////////////



		    stmt2=conn.createStatement();
			String totwrksQery="select d.dcode,pr.programme_code,sum(nvl(PROB_EXP_NXT_YR,0)),count(*) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr  where  substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"')) and w.work_id not in (select work_id from rws_st_works_view )";
				
			if(dcode!=null && !dcode.equals("00"))
			{
				totwrksQery+="and D.DCODE='"+dcode+"'";
			}
			
			if(scheme!=null && !scheme.equals(""))
			{
				totwrksQery+="and w.type_of_asset in("+scheme+")";
			}
			totwrksQery+=" and  w.programme_code in ("+programe+")  group by  d.dcode,pr.programme_code order by 1,2   ";
			
			System.out.println("totwrksQery.."+totwrksQery);
			
			rs2=stmt2.executeQuery(totwrksQery);
			Hashtable totwrksQeryHash=new Hashtable();
			while(rs2.next())
			{
			
				totwrksQeryHash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
			}
			
			if(totwrksQeryHash!=null && totwrksQeryHash.size()>0){
				
				session.setAttribute("totwrksQeryHash",totwrksQeryHash);
			}
					
			
			
			if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();

	 
	String mainQuery="select d.dcode,d.dname,pr.programme_code,pr.programme_name FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr  where substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and (PROB_EXP_NXT_YR > 0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"')) and w.work_id not in (select work_id from rws_st_works_view  )";
		if(dcode!=null && !dcode.equals("00"))
		{
			mainQuery+="and D.DCODE='"+dcode+"'";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			mainQuery+="and w.type_of_asset in("+scheme+")";
		}
		 
		mainQuery+=" and  pr.programme_code in ("+programe+") group by  d.dcode,d.dname,pr.programme_code,pr.programme_name order by 1,3   ";

					
	    System.out.println("mainQuery ............"+mainQuery);
		rs1=stmt1.executeQuery(mainQuery);
		double plainPop=0,scPop=0,stPop=0;
		double plainPop1=0,scPop1=0,stPop1=0;
		
		int gplainPop=0,gscPop=0,gstPop=0,gtotPop=0,totPop=0;
		int gplainPop1=0,gscPop1=0,gstPop1=0,gtotPop1=0,totPop1=0;
		double gunderScsp=0,gunderOther=0,gunderScsp1=0,gunderOther1=0;
		
		 String a[]=null,SC[]=null,a1[]=null,tot[]=null;
		 
		 int scwrk_cnt=0 ,gscwrk_cnt=0;
		 int totwrk_cnt=0 ,gtotwrk_cnt=0;
		 double scexp=0,gscexp=0;
		 double totexp=0,gtotexp=0;
		 
		while(rs1.next())
		{
			boolean flag=true;			
			double underScsp=0,underOther=0,stateSharePer=0,underPlain=0,underSt=0,scstateSharePer=0,underScsp1=0,underOther1=0;
			
			
			String distcode=rs1.getString(1);
			prg_code=rs1.getString(3);
			
			//wrk_cnt=rs1.getInt(6);
			//gwrk_cnt+=wrk_cnt;
			
			
			//exp_nxtyr=rs1.getDouble(5);
			//gexp_nxtyr+=exp_nxtyr;
			
			 	////////////////////////
			String  totwrks=(String)totwrksQeryHash.get(rs1.getString(1)+rs1.getString(3));
			   
			if(totwrks!=null)
			    {
				 
				   tot=totwrks.split("@");
				   
				   totexp=Double.parseDouble(tot[0]);
		 		   totwrk_cnt=Integer.parseInt(tot[1]);
		 		  
		 		   				
			    }
			else
			{
				   totexp=0;
				   totwrk_cnt=0;
			}
			
			
			   gtotexp+=totexp;
	 		   gtotwrk_cnt+=totwrk_cnt;
			
				
		
			
			//////////////////////////////////////////////////
			
			
			String  scwrks=(String)scwrksQeryHash.get(rs1.getString(1)+rs1.getString(3));
			   
			if(scwrks!=null)
			    {
				 
				   SC=scwrks.split("@");				   
				   scexp=Double.parseDouble(SC[0]);
		 		   scwrk_cnt=Integer.parseInt(SC[1]);
		 		  
		 		   				
			    }
			else
			{
				   scexp=0;
		 		   scwrk_cnt=0;
			}
			
			
			   gscexp+=scexp;
	 		   gscwrk_cnt+=scwrk_cnt;
			
			
			
	 		//System.out.println("my gpop="+gtotPop);
			 	
			 	if(prg_code!=null && (prg_code.equals("01") || prg_code.equals("18") || prg_code.equals("49") || prg_code.equals("51") || prg_code.equals("23")|| prg_code.equals("02") )){
					
			 		stateSharePer=0.5*totexp;
			 		scstateSharePer=0.5*scexp;
					
				}
				else if(prg_code!=null && (prg_code.equals("65") || prg_code.equals("12") || prg_code.equals("46")|| prg_code.equals("57")|| prg_code.equals("04")|| prg_code.equals("09")|| prg_code.equals("39") || prg_code.equals("15") ))
				{
					
					stateSharePer=totexp;
					scstateSharePer=scexp;
				}
				
			 	if(distcode!=null&& distcode.equals("11") && prg_code.equals("58"))
			 	{
			 		stateSharePer=0;
			 		scstateSharePer=0;
				}
				
				
				//System.out.println("my stateSharePer="+stateSharePer);
				String  pop=(String)popQeryHash.get(rs1.getString(1)+rs1.getString(3));
			   
			if(pop!=null)
			    {
				 
				   a=pop.split("@");
				 
		 		   plainPop=Double.parseDouble(a[0]);
		 		   scPop=Double.parseDouble(a[1]);
		 		   stPop=Double.parseDouble(a[2]);
		 		   totPop=Integer.parseInt(a[0])+Integer.parseInt(a[1])+Integer.parseInt(a[2]);
		 		  //System.out.println("my pop="+totPop);	
		 		  
		 		    underScsp=(stateSharePer/totPop)*scPop;
					
					underPlain=(stateSharePer/totPop)*plainPop;
					
					underSt=(stateSharePer/totPop)*stPop;					
		            
					double totStateEst=(stateSharePer/totPop)*totPop;		 
						
					underOther=totStateEst-underScsp;
			    }
		 			
			
			else
			{
				plainPop=0;
				scPop=0;
				stPop=0;
				totPop=0;
				
			}
			
			gtotPop+=totPop;
			gplainPop+=plainPop;
			gscPop+=scPop;
			gstPop+=stPop;
				
				
		      		 
				gunderScsp+=underScsp;
				gunderOther+=underOther;
				
				String  pop1=(String)popQeryHash1.get(rs1.getString(1)+rs1.getString(3));
				   
				if(pop1!=null)
				    {
					 
					   a1=pop1.split("@");
					 
			 		   plainPop1=Double.parseDouble(a1[0]);
			 		   scPop1=Double.parseDouble(a1[1]);
			 		   stPop1=Double.parseDouble(a1[2]);
			 		   totPop1=Integer.parseInt(a1[0])+Integer.parseInt(a1[1])+Integer.parseInt(a1[2]);
			 		  //System.out.println("my pop="+totPop);
			 		  
			 		  
			 		    underScsp1=(scstateSharePer/totPop1)*scPop1;
						
						underPlain=(scstateSharePer/totPop1)*plainPop1;
						
						underSt=(scstateSharePer/totPop1)*stPop1;
						
						double totStateEst1=(scstateSharePer/totPop1)*totPop1;		 
						
						underOther1=totStateEst1-underScsp1;
				     
					
				    }
				
				else
				{
					plainPop1=0;
					scPop1=0;
					stPop1=0;
					totPop1=0;
					
				}
			 			 
				gtotPop1+=totPop1;
				gplainPop1+=plainPop1;
				gscPop1+=scPop1;
				gstPop1+=stPop1;
				 		 
				gunderScsp1+=underScsp1;
				gunderOther1+=underOther1;
				
			
			
			
			
			
		 			 
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
		
		<% } %>
		
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4) %></td>
		<%-- <td class=<%=style %>  style="text-align: right;"><%=(int) plainPop  %></td>
		<td class=<%=style %>  style="text-align: right;"><%=(int)scPop %></td>
		
		<td class=<%=style %>  style="text-align: right;"><%=(int)stPop %></td>
		<td class=<%=style %>  style="text-align: right;"><%=totPop %></td>
		 --%>
		<td class=<%=style %>  style="text-align: right;"><%=totwrk_cnt %></td>
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(totexp) %></td>	
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(underScsp) %></td>		
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(totexp-underScsp) %></td>
		
	<%-- 	<td class=<%=style %>  style="text-align: right;"><%=(int) plainPop1  %></td>
		<td class=<%=style %>  style="text-align: right;"><%=(int)scPop1 %></td>
		
		<td class=<%=style %>  style="text-align: right;"><%=(int)stPop1 %></td>
		<td class=<%=style %>  style="text-align: right;"><%=totPop1 %></td> --%>
		
		<td class=<%=style %>  style="text-align: right;"><%=scwrk_cnt %></td>
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(scexp) %></td>
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(underScsp1) %></td>
		<td class=<%=style %>  style="text-align: right;"><%=ndf.format(scexp-underScsp1) %></td>
		
		</tr>

  <%

		if(!dname.equals(rs1.getString(2)) && !dname.equals("-"))
		{
			//System.out.println("this is jyothi..............."+dname);
			
		%>
<tr>

				        <td colspan="3"  class="gridhdbg" style="text-align: right;">Sub Total:</td>
	 				    <td class="gridhdbg" style="text-align: right;">-</td>
						<td class="gridhdbg" style="text-align: right;">-</td>
				
 <%

	
		dname="-";
		} 
	}
		
%>
		
   		
		<tr>
		<td colspan="3"  class="gridhdbg" style="text-align: right;">Grand Total:</td>
		
		<%-- <td class="gridhdbg" style="text-align: right;"><%=gplainPop %></td>
	  	<td class="gridhdbg" style="text-align: right;"><%=gscPop %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=gstPop %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=gtotPop %></td>
		 --%>
	  	<td class="gridhdbg"  style="text-align: right;"><%=gtotwrk_cnt %></td>
		<td class="gridhdbg"   style="text-align: right;"><%=ndf.format(gtotexp) %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gunderScsp) %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gtotexp-gunderScsp) %>
		<%-- <td class="gridhdbg" style="text-align: right;"><%=gplainPop1 %></td>
	  	<td class="gridhdbg" style="text-align: right;"><%=gscPop1 %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=gstPop1 %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=gtotPop1 %></td>
		 --%>
	  
		<td class="gridhdbg"  style="text-align: right;"><%=gscwrk_cnt %></td>
		<td class="gridhdbg"   style="text-align: right;"><%=ndf.format(gscexp) %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gunderScsp1) %></td>
		<td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gscexp-gunderScsp1) %></td>
		</tr>
	
	
	<% 
	
	
}catch(Exception e)
{
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>