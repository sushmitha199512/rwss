<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 



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
	String financialstartyr="";
	
    double aas=0;
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialstartyr=request.getParameter("finyear");
	}
   
	session.setAttribute("financialyr",financialstartyr);
System.out.println("Changing");
    //schemes
String scheme="";
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	//System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("scheme",scheme);
}

	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
       String[] programes=request.getParameterValues("program");
    	

    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	//System.out.println("programe::"+programe);
 

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(startyr);
   
   String nextfinancialstartyr="";
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr=""+nextFinYear+"-"+nn;
//System.out.println("startyr"+startyr);
   //System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
   session.setAttribute("nextfinancialstartyr",nextfinancialstartyr);
   
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

//System.out.println("Startyr:"+startyr);
//System.out.println("Startyr2:"+startyr2 );
//System.out.println("Endyr:"+endyr );

//System.out.println("Endyr2:"+endyr1);


     //System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=request.getParameter("district");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

//System.out.println("dcode"+dcode);
//System.out.println("DivCode"+divCode);


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
				<td class="bwborder"><a href="./Rws_Scsp_1415_ActionPlan_Detail_Frm.jsp">Back|</a><a href="./Rws_Scsp_1415_ActionPlan_Detail_Excel.jsp" target=_new>Excel</a></td></tr>
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
<%-- <td  class="gridhdbg" align="center"   colspan="6" nowrap >Likely EXP. <br></br><%=financialstartyr %></td> --%>
<td  class="gridhdbg" align="center"   colspan="6" nowrap >Cumulative EXP. till Date</td>
<td  class="gridhdbg" align="center"   colspan="6" nowrap >Balance requirement for 2014-2015<br> (Likely EXP. <br></br><%=nextfinancialstartyr %>)</td>
<td  class="gridhdbg" rowspan=3>Physical Status<br></br>(Grounded/ Completed)</td>

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
 --><!-- <td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>
 --><td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>
<td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds</td>

</tr>
<tr>

<!-- <td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">SC</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
 -->		
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		
		</tr>
<tr>

<%
for(int i=1;i<39;i++)
{

%>

<td class="gridhdbg"  align="center"><%=i %></td>	


<%} %>
</tr>
<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null;
int count=1;
  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();


	  /******   New  Works *****************************************************/

	  	String sanctionedHabs="select W.WORK_ID,h.hab_code,nvl(hd.CENSUS_PLAIN_POPU,0) ,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl  H ,rws_habitation_directory_tbl hd  where W.WORK_ID=h.work_id  and h.hab_code=hd.hab_code and   w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
	   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		sanctionedHabs+="and substr(w.work_id,5,2)='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  sanctionedHabs+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  sanctionedHabs+=" and  w.programme_code in ("+programe+")  ";

	  	//System.out.println("sanctionedHabs"+sanctionedHabs);
	  	ResultSet rs2=stmt2.executeQuery(sanctionedHabs);
	  
	  	Hashtable sanctionedHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		sanctionedHabsHash.put(rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	  	}
	  
        if(sanctionedHabsHash!=null && sanctionedHabsHash.size()>0){
			
			session.setAttribute("sanctionedHabsHash",sanctionedHabsHash);
		}
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();


	    stmt2=conn.createStatement();
		
	 	String totalHabsPOP="select W.WORK_ID,sum(nvl(hd.CENSUS_PLAIN_POPU,0)),sum(nvl(hd.CENSUS_SC_POPU,0)),sum(nvl(hd.CENSUS_ST_POPU,0))  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl  H ,rws_habitation_directory_tbl hd  where  W.WORK_ID=h.work_id and h.hab_code=hd.hab_code   and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		totalHabsPOP+="and substr(w.work_id,5,2)='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  totalHabsPOP+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  totalHabsPOP+=" and   hd.coverage_status<>'UI' and w.programme_code in ("+programe+")   group by w.WORK_ID ";

	  	 // System.out.println("totalHabsPOP"+totalHabsPOP);
	 rs2=stmt2.executeQuery(totalHabsPOP);
	  
	  	Hashtable totalPOPHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		totalPOPHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
	  	}
	  	
		if(totalPOPHash!=null && totalPOPHash.size()>0){
					
					session.setAttribute("totalPOPHash",totalPOPHash);
				}
	  	
	  	 if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();

		
			Hashtable schoolTotPOPHash=new Hashtable();
			if(scheme!=null && scheme.contains("07")){
			
			
			stmt2=conn.createStatement();
			
		 	String totalPOpSchoolHabs="select W.WORK_ID,sum(nvl(hd.CENSUS_PLAIN_POPU,0)),sum(nvl(hd.CENSUS_SC_POPU,0)),sum(nvl(hd.CENSUS_ST_POPU,0))   FROM RWS_WORK_ADMN_TBL W ,rws_work_school_lnk_tbl  H ,rws_habitation_directory_tbl hd  where h.hab_code=hd.hab_code and  W.WORK_ID=h.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
			   
		  	 if(dcode!=null && !dcode.equals("00")){
		  		totalPOpSchoolHabs+="and substr(w.work_id,5,2)='"+dcode+"'";
		  		}

		  if(scheme!=null && !scheme.equals("")){
			  totalPOpSchoolHabs+="and w.type_of_asset in("+scheme+")";
		  }
		   
		  totalPOpSchoolHabs+=" and hd.coverage_status<>'UI' and  w.programme_code in ("+programe+") group by w.WORK_ID  ";

		  // System.out.println("totalPOpSchoolHabs"+totalPOpSchoolHabs);
		 rs2=stmt2.executeQuery(totalPOpSchoolHabs);
		  
		  	
		  	while(rs2.next()){
		  		  	
		  		schoolTotPOPHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
		  	}
		  
		  	if(schoolTotPOPHash!=null && schoolTotPOPHash.size()>0){
				
				session.setAttribute("schoolTotPOPHash",schoolTotPOPHash);
			}
 
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		

			}
			/*
			
			stmt2=conn.createStatement();
		
	    
	    String schoolHabs="select W.WORK_ID,sum(nvl(hd.CENSUS_PLAIN_POPU,0)),sum(nvl(hd.CENSUS_SC_POPU,0)),sum(nvl(hd.CENSUS_ST_POPU,0))   FROM RWS_WORK_ADMN_TBL W ,rws_work_school_lnk_tbl  H ,rws_habitation_directory_tbl hd  where  W.WORK_ID=h.work_id  and h.hab_code=hd.hab_code and   w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		schoolHabs+="and substr(w.work_id,5,2)='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  schoolHabs+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  schoolHabs+=" and hd.coverage_status<>'UI' and  w.programme_code in ("+programe+") group by w.WORK_ID  ";
	  

	  	 System.out.println("schoolHabs"+schoolHabs);
	 rs2=stmt2.executeQuery(schoolHabs);
	  
	  	Hashtable schoolHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		schoolHabsHash.put(rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	  	}
	  
	  	if(schoolHabsHash!=null && schoolHabsHash.size()>0){
			
			session.setAttribute("schoolHabsHash",schoolHabsHash);
		}

	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();

	  */
		
		//programlink
		
	
	    stmt2=conn.createStatement();
		String programLinkQuery="select WORK_ID,sum(SANCTION_AMOUNT)  FROM rws_work_admn_prog_lnk_tbl group by WORK_ID";
	 


	 	rs2=stmt2.executeQuery(programLinkQuery);
	 	Hashtable programLinkHash=new Hashtable();
	  	while(rs2.next())
	  	{
	  		  	
	  		programLinkHash.put(rs2.getString(1),rs2.getString(2));
	  	}
		
         if(programLinkHash!=null && programLinkHash.size()>0){
			
			session.setAttribute("programLinkHash",programLinkHash);
		}
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
	
			//updated new columns data
			stmt2=conn.createStatement();
			
          String contractorSelection="select WORK_ID,sum(PROB_EXP),sum(PROB_EXP_NXT_YR) FROM rws_work_admn_tbl  group by WORK_ID";
	
			// System.out.println("contractorSelection..."+contractorSelection);
		 	rs2=stmt2.executeQuery(contractorSelection);
		 	
		 	Hashtable contractorExpHash=new Hashtable();
		  	while(rs2.next())
		  	{
		  		  	
		  		contractorExpHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  	}
			

			
		  	if(contractorExpHash!=null && contractorExpHash.size()>0){
				
				session.setAttribute("contractorExpHash",contractorExpHash);
			}
		 	  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
				
				
				//grounded 
				
				Hashtable groundHash=(Hashtable)session.getAttribute("groundHash");
				if(groundHash==null){
					groundHash=new Hashtable();
				}
				
				if(groundHash.size()==0){
				stmt2=conn.createStatement();
				String groundedQuery="select WORK_ID,GROUNDING_DATE FROM rws_work_commencement_tbl where GROUNDING_DATE is not null";
			 

				//System.out.println("groundedQuery..."+groundedQuery);
			 	rs2=stmt2.executeQuery(groundedQuery);
			 	
			  	while(rs2.next())
			  	{
			  		  	
			  		groundHash.put(rs2.getString(1),rs2.getString(2));
			  	}
				}else{
					groundHash=(Hashtable)session.getAttribute("groundHash");
				}
				

			  	if(groundHash!=null && groundHash.size()>0){
					
					session.setAttribute("groundHash",groundHash);
				}
			 	
			 	  
				  if(rs2!=null)rs2.close();
					if(stmt2!=null)stmt2.close();
					
					
					
					Hashtable completeHash=(Hashtable)session.getAttribute("completeHash");
					if(completeHash==null){
						completeHash=new Hashtable ();
					}
					if(completeHash.size()==0){
					stmt2=conn.createStatement();
					String completionQuery="select WORK_ID,DATE_OF_COMPLETION FROM rws_work_completion_tbl where DATE_OF_COMPLETION is not null";
				 
					//System.out.println("completionQuery..."+completionQuery);

				 	rs2=stmt2.executeQuery(completionQuery);
				 	
				  	while(rs2.next())
				  	{
				  		  	
				  		completeHash.put(rs2.getString(1),rs2.getString(2));
				  	}
					}else{
						completeHash=(Hashtable)session.getAttribute("completeHash");
					}

				  	if(completeHash!=null && completeHash.size()>0){
						
						session.setAttribute("completeHash",completeHash);
					}
				 	
				 	  
					  if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();

		/******   New  Works *****************************************************/


	    stmt2=conn.createStatement();
		String expQuery="select W.WORK_ID,sum(voucher_Amt)/100000 FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl exp  where w.work_id=exp.work_id and   w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";


	 
		 if(dcode!=null && !dcode.equals("00")){
			 expQuery+="and substr(w.work_id,5,2)='"+dcode+"'";
			}

	if(scheme!=null && !scheme.equals("")){
		expQuery+="and w.type_of_asset in("+scheme+")";
	}
	 
	expQuery+=" and  w.programme_code in ("+programe+")  group by W.WORK_ID";

		
//System.out.println("expQuery"+expQuery);
	 	rs2=stmt2.executeQuery(expQuery);
	 	Hashtable expHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		expHash.put(rs2.getString(1),rs2.getString(2));
	  	}
		
	  	if(expHash!=null && expHash.size()>0){
			
			session.setAttribute("expHash",expHash);
		}
		
	 	
	 	  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();

		

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////			
			
			
			stmt2=conn.createStatement();
			String sanctionAmtQery="select W.WORK_ID, sum(census_plain_popu),sum(census_sc_popu),sum(census_st_popu) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_admn_hab_lnk_tbl l ,rws_habitation_directory_tbl hd  where w.work_id=l.work_id and l.hab_code=hd.hab_code ";


		 
			 if(dcode!=null && !dcode.equals("00")){
				 sanctionAmtQery+="and D.DCODE='"+dcode+"'";
				}

		if(scheme!=null && !scheme.equals("")){
			sanctionAmtQery+="and w.type_of_asset in("+scheme+")";
		}
		 
		sanctionAmtQery+=" and  w.programme_code in ("+programe+")  group by W.WORK_ID";

			
	//System.out.println("sanctionAmtQery.."+sanctionAmtQery);
		 	rs2=stmt2.executeQuery(sanctionAmtQery);
		 	Hashtable sanctionAmtQeryHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		sanctionAmtQeryHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
		  	}
			

		  	if(sanctionAmtQeryHash!=null && sanctionAmtQeryHash.size()>0){
				
				session.setAttribute("sanctionAmtQeryHash",sanctionAmtQeryHash);
			}
			
		 	
		 	  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();	
				
			


/******   New  Works *****************************************************/


    stmt2=conn.createStatement();
	String newWorksQuery="select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name,NO_OF_HABS FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp   where sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null  and PROB_EXP_NXT_YR > 0    ";
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
	
	//new added
	
	double gglCenExp=0,gglNCenExp=0,ggexpDuringCen=0;
	double ggexpSc=0,ggexpPlain=0,ggexpSt=0,ggexpTot=0;
	double gglPlainExp=0,gglScExp=0,gglStExp=0,gglTotExp=0,gglNPlainExp=0,gglNScExp=0,gglNStExp=0,gglNTotExp=0;
	double ggtotEST=0;
	double ggstatetotEST=0;
	
	  double ggbalanceEST=0;
	  String workId="";
	  double gsanctionedAmount=0,ggtotsanamt=0;
	  
  
  double ggunderscexp=0,ggunderotherexp=0;
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
		double expDuring=0;
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
		
		String categoryCode=rs2.getString(7);
		typeOfAsset=rs2.getString(8);
		double balanceEST=sanctionedAmount-expUpto;
		
		ggbalanceEST+=balanceEST;
		double stateSharePer=0,lstateSharePer=0,lNstateSharePer=0,expDuringCentralShare=0,expDuringStateShare=0,scstateshare=0;
		String programeCode=rs2.getString(9);
		
		if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
		
			stateSharePer=0.5*balanceEST;
			lstateSharePer=0.5*probExp;
			lNstateSharePer=0.5*probExpNextYear;////200*0.5=100
			expDuringCentralShare=0.5*expDuring;
			expDuringStateShare=0.5*expDuring;
			scstateshare=0.5*sanctionedAmount;
			
			
		}
		else if(programeCode!=null && (programeCode.equals("65") || programeCode.equals("12") || programeCode.equals("46")|| programeCode.equals("57")|| programeCode.equals("04")|| programeCode.equals("09")|| programeCode.equals("39") || programeCode.equals("15") )){
			
			stateSharePer=balanceEST;
			lstateSharePer=probExp;////200;
			lNstateSharePer=probExpNextYear;
			expDuringStateShare=expDuring;
			scstateshare=sanctionedAmount;
			
		}
		
		if(workId.substring(4,6)!=null&& workId.substring(4,6).equals("12") && programeCode.equals("58")){
			stateSharePer=0.0;
			lstateSharePer=0.0;////0
			lNstateSharePer=0.0;
			expDuringStateShare=0;
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
		
		
		
		double expPerPerson=0;
		if(expDuring>0 && totWorkPop>0)
		{
		 expPerPerson=(expDuring/totWorkPop);
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
		 		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Head Of Account',TITLE,'Information')" onmouseout="UnTip()"><%=workId  %></td>
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
	 	
	 	//likely expenditure
	 	
	 	double glNCenExp=0,glCenExp=0,glTotExp=0,glPlainTot=0,glScTot=0,glStTot=0,glTotTot=0,glNTotExp=0,glNPlainTot=0,glNScTot=0,glNStTot=0,glNTotTot=0,gexpDuringCen=0;
	 	double gtotEST=0;
		double gstatetotEST=0;
		
		double gExpSc=0,gExpSt=0,gExpPlain=0,gExpTot=0;
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
	 		double expSc=0,expPlain=0,expSt=0,expCentral=0;
	 		double lNCentralShare=0,lNPlainExp=0,lNScExp=0,lNStExp=0,lNTotExp=0;
	 		
	 		double plainExp=0;
	 		 double scExp=0;
	 		 double stExp=0;
	 		 lCentralShare=probExp-lstateSharePer;
	 		 lNCentralShare=probExpNextYear-lNstateSharePer;
	 		 
	 		 double lCenExp=0,lNCenExp=0,expDuringCen=0;
	 		 
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
	 				
	 				//******State Share 
	 				
	 				statescBalanceEST=stateSharePer;
	 				stateplainBalanceEST=0;
	 				statestEST=0;
	 				
	 				lScExp=balance4*habPop;
	 				lNScExp=balance6*habPop;
	 				
	 				expSc=balance8*habPop;
	 				
	 				
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
	 				
					//******State Share 
	 				
	 				statescBalanceEST=0;
	 				stateplainBalanceEST=0;
	 				statestEST=stateSharePer;
	 				
	 				lStExp=balance4*habPop;
	 				lNStExp=balance6*habPop;
	 				
	 				expSt=balance8*habPop;
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
	 				
	 				
	 				//System.out.println("expSc......"+expSc);
	 				
	 				
	 				
	 			}
	 			lCenExp=balance3*(habPop);
	 			lNCenExp=balance5*(habPop);
	 			expDuringCen=balance7*(habPop);
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
	 				
	 				//******State Share
	 				
	 				statescBalanceEST=balance2*habPop;
	 				stateplainBalanceEST=0;
	 				statestEST=0;
	 				
	 				lScExp=balance4*scPOP;
	 				lNScExp=balance6*habPop;
	 				
	 				
	 				expSc=balance8*habPop;
	 				
	 				
	 				
	 				
	 				
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
	 				
	 				
	 				
					//******State Share
	 				
	 				statescBalanceEST=0;
	 				stateplainBalanceEST=0;
	 				statestEST=(balance2*habPop);
	 				
	 				
	 				lStExp=balance4*habPop;
	 				lNStExp=balance6*habPop;
	 				
	 				
	 				expSt=balance8*habPop;
	 				
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
		 				
		 				
		 				
	 			}
	 			
	 			
	 			
	 			lCenExp=balance3*(habPop);
	 			
	 			lNCenExp=balance5*(habPop);
	 			
	 			expDuringCen=balance7*(habPop);
	 			
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
	 		
	 		gExpSt+=expSt;
	 		gExpPlain+=expPlain;
	 		
	 		ggexpSc+=expSc;
	 		ggexpSt+=expSt;
	 		ggexpPlain+=expPlain;
	 		
	 		gexpDuringCen+=expDuringCen;
	 		
	 		ggexpDuringCen+=expDuringCen;
	 		
	 		double totExpDur=expSc+expSt+expPlain+expDuringCen;
	 		ggexpTot+=totExpDur;
	 		gExpTot+=totExpDur;
	 		
	 		
	 		
	 		
	 		 double totalEXP=plainExp+scExp+stExp;
	 		 
	 		gplainExp+=plainExp;
	 		gscEXp+=scExp;
	 		gstExp+=stExp;
	 		
	 		
	 		//Exp
	 		
	 		 ggplainExp+=plainExp;
	 		ggscEXp+=scExp;
	 		ggstExp+=stExp;
	 		
	 		
	 		//exp
	 		
	 		
	 		gtotalEXP+=totalEXP;
	 		
	 		
	 		ggtotalEXP+=totalEXP;
	 		
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
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('HabCode',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(1) %></td>
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
 --%>	 	<td class=<%=style %> style="text-align: center;" onmouseover="Tip('Clause Type',TITLE,'Information')" onmouseout="UnTip()"><%=clauseType %></td>
	 		
	 		<td class=<%=style %> style="text-align: center;"><%=subplanSubmitted %></td>
	 		<%-- <td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lCenExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lPlainExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lScExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lStExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotExp-lScExp) %></td>
	 	 --%>	
	 		
	 		
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Central Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expDuringCen) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expPlain) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Sc Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expSc) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expSt) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur)  %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Cumm. Under Other Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur-expSc)  %></td>
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lNCenExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lNPlainExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lNScExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - ST Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lNStExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Likely - Under Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotExp-lNScExp) %></td>
	 		
	 		
	 		<td class=<%=style %> style="text-align: center;" onmouseover="Tip('Total Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
	 		
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
			 <td class=<%=style %> style="text-align: right;"><%=rs2.getString(3) %></td>
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
	 	
	 	
	 	<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glCenExp) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glPlainTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glScTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glStTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotTot-glScTot) %></td>
	 --%> 	
	 		
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gexpDuringCen) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Plain Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpPlain) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.SC  Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSc) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. ST Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSt) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm. Total Expenditure ',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Cumm.Under Other Funds',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot-gExpSc) %></td>
	 	
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - Central Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNCenExp) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNPlainTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNScTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNStTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - Total Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Likely - Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glNTotTot-glNScTot) %></td>
	 
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Physical Status',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
	 		
	 	
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
	<%-- <td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglCenExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglPlainExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglScExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total  Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglStExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total  Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglTotExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Under Other SCSP',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglTotExp-gglScExp) %></td>
 --%>	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.  Central Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpDuringCen) %></td>
 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm.Plain  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpPlain) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Sc  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSc) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. St  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSt) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Total  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Cumm. Underother Funds  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot-ggexpSc) %></td>
	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely - Central   Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNCenExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely - Plain  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNPlainExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely - SC  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNScExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely -ST  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNStExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Likely - Total  Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNTotExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip(' Likely - Under Other SCSp',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNTotExp-gglNScExp) %></td>
	
	
	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Status.',TITLE,'Information')" onmouseout="UnTip()">-</td>
 	</tr>
	<% 

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>