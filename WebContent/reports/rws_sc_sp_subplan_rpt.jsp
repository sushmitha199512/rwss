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
    double OtherFundasSC=0,OtherFundaslikelySC=0,gtotlikely=0,gexpendituretot=0,gglikelytot=0,ggexpenditure=0,scPOP=0,ggggtotEST=0,	ggggstatescEST=0,ggggtotalotherscsp=0;
        
    double ggunderscexp=0,ggunderotherexp=0;
    
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
//System.out.println("StartyRr2:"+startyr2 );
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
				<td class="bwborder"><a href="./rws_sc_sp_subplan_frm.jsp">Back|</a><a href="./rws_sc_sp_subplan_excel.jsp">Excel</a></td></tr>
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
		<td align="center" class="gridhdbg" colspan=49>RWS&S Ongoing Works of different programmes and Budget Provision under  Sub Plan/SCSP Sub Plan for (<%=financialstartyr %>)--<%=pname %> .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" rowspan=4>Sl.No</td>
		<td  class="gridhdbg" rowspan=4>Programme</td>
		<td  class="gridhdbg" rowspan=4>Sub Programme</td>
		<td  class="gridhdbg" rowspan=4>Head&nbsp;Of Account</td>
		
		<td   class="gridhdbg" rowspan=4>District</td>
		<td   class="gridhdbg" rowspan=4>Constituency</td>
<td  class="gridhdbg" rowspan=4>Work Name</td>
<td  class="gridhdbg" rowspan=4>WorkID </td>
<td class="gridhdbg"  rowspan=4 >Nature Of The Work</td>
<td  class="gridhdbg" rowspan=4>Mandal</td>
<td class="gridhdbg"  rowspan=4>Panchayat</td>
<td  class="gridhdbg" rowspan=4>Hab&nbsp;Code</td>
<td  class="gridhdbg" rowspan=4>Existing&nbsp;Water Level</td>
<td  class="gridhdbg" rowspan=4>Coverage Status(55 LPCD)</td>

<td  class="gridhdbg" rowspan=4>Hab&nbsp;Name</td>
<td  class="gridhdbg" rowspan=4>Sanction Amount</td>

<td  class="gridhdbg" rowspan=4>Balance&nbsp;EST&nbsp;Cost</td>

</tr>
<tr>


<td  class="gridhdbg" align="center"  colspan=3>Balance Estmate Cost As On 01.04.2013</td>




		<td  class="gridhdbg" align="center"  colspan=4>Population</td>
		<td class="gridhdbg"  align="center" colspan=3>Population %</td>
		
<td  class="gridhdbg" align="center" rowspan="3" nowrap >Clause<br></br>(SC>40% / Plain Hab / SC<40%)</td>
<td  class="gridhdbg" align="center" rowspan="3" nowrap >Subplan Submitted <br></br>(SCSP/TSP/Others)</td>


<td  class="gridhdbg" rowspan=3>Physical Status<br></br>(Grounded/ Completed)</td>


<td  class="gridhdbg" align="center"   colspan="6" nowrap >Total EXP. <br></br> During <%=financialstartyr %></td>


<td  class="gridhdbg" align="center"   colspan="6" nowrap >Likely EXP. <br></br><%=financialstartyr %></td>








</tr>
<tr>

<td class="gridhdbg"  colspan=1 rowspan="2"  align="center">Total</td>	
		<td   class="gridhdbg" colspan=1 rowspan="2"  align="center">Under SCSP</td>	
		<td  class="gridhdbg" colspan=1  rowspan="2" align="left">Under Other Funds</td>



<td class="gridhdbg"  colspan=1 rowspan="2"  align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1 rowspan="2"  align="center">SC</td>	
		<td  class="gridhdbg" colspan=1  rowspan="2" align="left">ST</td>
<td  colspan=1  class="gridhdbg" rowspan="2"   align="center">Total</td>
<td  colspan=1  class="gridhdbg"  rowspan="2" align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  rowspan="2" align="center">SC</td>	
		<td class="gridhdbg" rowspan=2  colspan=1  align="left">ST</td>


<td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds<br></br>(35-33)</td>

<td class="gridhdbg"   colspan=1 rowspan="2"  align="center">Central Share</td>
<td class="gridhdbg"   colspan=3   align="center">State Share</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Total</td>
<td class="gridhdbg"   colspan=1 rowspan="2"   align="center">Under Other Funds<br></br>(41-39)</td>


</tr>
<tr><td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under<BR></BR>SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		<td class="gridhdbg"  colspan=1   align="center">PLAIN</td>	
		<td   class="gridhdbg" colspan=1  align="center">Under<BR></BR>SCSP</td>	
		<td  class="gridhdbg" colspan=1  align="left">ST</td>
		
		</tr>
		
		
		<tr>
		
		<td  class="gridhdbg" >1</td><td  class="gridhdbg" >2</td><td  class="gridhdbg" >3</td><td  class="gridhdbg" >4</td><td  class="gridhdbg" >5</td><td  class="gridhdbg" >6</td><td  class="gridhdbg" >7</td>	<td  class="gridhdbg" >8</td><td  class="gridhdbg" >9</td><td  class="gridhdbg" >10</td><td  class="gridhdbg" >11</td>	<td  class="gridhdbg" >12</td><td  class="gridhdbg" >13</td><td  class="gridhdbg" >14</td><td  class="gridhdbg" >15</td>
		<td  class="gridhdbg" >16</td><td  class="gridhdbg" >17</td><td  class="gridhdbg" >18</td><td  class="gridhdbg" >19</td><td  class="gridhdbg" >20</td><td  class="gridhdbg" >21</td><td  class="gridhdbg" >22</td><td  class="gridhdbg" >23</td>
		<td  class="gridhdbg" >24</td><td  class="gridhdbg" >25</td><td  class="gridhdbg" >26</td><td  class="gridhdbg" >27</td><td  class="gridhdbg" >28</td><td  class="gridhdbg" >29</td><td  class="gridhdbg" >30</td><td  class="gridhdbg" >31</td>
		<td  class="gridhdbg" >32</td><td  class="gridhdbg" >33</td><td  class="gridhdbg" >34</td><td  class="gridhdbg" >35</td><td  class="gridhdbg" >36</td><td  class="gridhdbg" >37</td><td  class="gridhdbg" >38</td><td  class="gridhdbg" >39</td>
		<td  class="gridhdbg" >40</td><td  class="gridhdbg" >41</td><td  class="gridhdbg" >42</td>
	
		
		
		
		
		</tr>
		
		
		

<%
Statement stmt2=null,stmt3=null,stmt22=null;
ResultSet rs1=null,rs3=null,rs22=null;
int count=1;
  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();

	  ////////////////////////////
	  
	  			stmt22 = conn.createStatement();
			String sanctionAmtQery = "select W.WORK_ID, sum(nvl(ch.census_plain_popu,0)),sum(nvl(ch.census_sc_popu,0)),sum(nvl(ch.census_st_popu,0)) FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl l ,rws_complete_hab_view ch where  w.work_id=l.work_id and l.HAB_CODE=ch.PANCH_CODE and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";

			if (dcode != null && !dcode.equals("00")) {
				sanctionAmtQery += "and substr(w.work_id,5,2)='" + dcode + "'";
			}

			if (scheme != null && !scheme.equals("")) {
				sanctionAmtQery += "and w.type_of_asset in(" + scheme + ")";
			}

			sanctionAmtQery += " and  w.programme_code in (" + programe + ")  group by W.WORK_ID";

			//System.out.println("sanctionAmtQery.." + sanctionAmtQery);
			rs22 = stmt22.executeQuery(sanctionAmtQery);
			Hashtable sanctionAmtQeryHash = new Hashtable();
			while (rs22.next()) {

				sanctionAmtQeryHash.put(rs22.getString(1), rs22.getString(2)
						+ "@" + rs22.getString(3) + "@" + rs22.getString(4));
			}

			if(sanctionAmtQeryHash!=null && sanctionAmtQeryHash.size()>0){
				
				session.setAttribute("sanctionAmtQeryHash",sanctionAmtQeryHash);
			}
			
			
			if (rs22 != null)
				rs22.close();
			if (stmt22 != null)
				stmt22.close();

	  
	 	  
	  
	  ////////////////////////////////////////
	  
	  
	  

	  /******   New  Works *****************************************************/

	  	String sanctionedHabs="select W.WORK_ID,h.hab_code,nvl(ch.CENSUS_PLAIN_POPU,0) ,nvl(ch.CENSUS_SC_POPU,0),nvl(ch.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl  H ,rws_complete_hab_view ch where  W.WORK_ID=h.work_id  and  ch.PANCH_CODE=h.HAB_CODE and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
	   
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
		
	 	String totalHabsPOP="select W.WORK_ID,sum(nvl(hd.CENSUS_PLAIN_POPU,0)),sum(nvl(hd.CENSUS_SC_POPU,0)),sum(nvl(hd.CENSUS_ST_POPU,0))  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl  H ,rws_habitation_directory_tbl hd, rws_complete_hab_view hc where hc.PANCH_CODE=hd.HAB_CODE and h.hab_code=hd.hab_code and  W.WORK_ID=h.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		totalHabsPOP+="and substr(w.work_id,5,2)='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  totalHabsPOP+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  totalHabsPOP+=" and   hd.coverage_status<>'UI' and w.programme_code in ("+programe+") group by w.WORK_ID ";

	  	  //System.out.println("totalHabsPOP"+totalHabsPOP);
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

		
			
			stmt2=conn.createStatement();
			
		String totalPOpSchoolHabs="select W.WORK_ID,sum(nvl(hd.CENSUS_PLAIN_POPU,0)),sum(nvl(hd.CENSUS_SC_POPU,0)),sum(nvl(hd.CENSUS_ST_POPU,0))   FROM RWS_WORK_ADMN_TBL W ,rws_work_school_lnk_tbl  H ,rws_habitation_directory_tbl hd,rws_complete_hab_view hc where hc.PANCH_CODE=hd.HAB_CODE and h.hab_code=hd.hab_code and  W.WORK_ID=h.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
			   
		  	 if(dcode!=null && !dcode.equals("00"))
		  	 {
		  		totalPOpSchoolHabs+="and substr(w.work_id,5,2)='"+dcode+"'";
		  	 }

			 if(scheme!=null && !scheme.equals(""))
			 {
				 totalPOpSchoolHabs+="and w.type_of_asset in("+scheme+")";
			 }
		   
		  totalPOpSchoolHabs+=" and hd.coverage_status<>'UI' and  w.programme_code in ("+programe+") group by w.WORK_ID  ";

		   //System.out.println("totalPOpSchoolHabs"+totalPOpSchoolHabs);
		 rs2=stmt2.executeQuery(totalPOpSchoolHabs);
		  
		  	Hashtable schoolTotPOPHash=new Hashtable();
		  	while(rs2.next())
		  	{
		  		  	
		  		schoolTotPOPHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
		  	}
		  
		  	if(schoolTotPOPHash!=null && schoolTotPOPHash.size()>0){
				
				session.setAttribute("schoolTotPOPHash",schoolTotPOPHash);
			}
		  	
		    if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		

	  /*  stmt2=conn.createStatement();
		
	 	String schoolHabs="select W.WORK_ID,h.hab_code,nvl(hd.CENSUS_PLAIN_POPU,0) ,nvl(hd.CENSUS_SC_POPU,0),nvl(hd.CENSUS_ST_POPU,0)  FROM RWS_WORK_ADMN_TBL W ,rws_work_school_lnk_tbl  H ,rws_habitation_directory_tbl hd,rws_complete_hab_view hc where hc.PANCH_CODE=hd.HAB_CODE and h.hab_code=hd.hab_code and W.WORK_ID=h.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
		   
	  	 if(dcode!=null && !dcode.equals("00")){
	  		schoolHabs+="and substr(w.work_id,5,2)='"+dcode+"'";
	  		}

	  if(scheme!=null && !scheme.equals("")){
		  schoolHabs+="and w.type_of_asset in("+scheme+")";
	  }
	   
	  schoolHabs+=" and hd.coverage_status<>'UI' and w.programme_code in ("+programe+") ";

	  	//  System.out.println("schoolHabs"+schoolHabs);
	 rs2=stmt2.executeQuery(schoolHabs);
	  
	  	Hashtable schoolHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		schoolHabsHash.put(rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
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
		String expQuery="select W.WORK_ID,sum(case when (to_date(voucher_dt)< '01-APR-"+endyr1+"') then voucher_Amt else 0 end)/100000,sum(case when (to_date(voucher_dt)>= '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl exp  where w.work_id=exp.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
	 
		 if(dcode!=null && !dcode.equals("00")){
			 expQuery+="and substr(w.work_id,5,2)='"+dcode+"'";
			}

	if(scheme!=null && !scheme.equals("")){
		expQuery+="and w.type_of_asset in("+scheme+")";
	}
	 
	expQuery+=" and  w.programme_code in ("+programe+")  group by W.WORK_ID";

		
       System.out.println("expQuery"+expQuery);
	 	rs2=stmt2.executeQuery(expQuery);
	 	Hashtable expHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		expHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	}
		

		
	  	if(expHash!=null && expHash.size()>0){
			
			session.setAttribute("expHash",expHash);
		}
	 	  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();

		
			stmt2=conn.createStatement();
			String expQuery1="select W.WORK_ID,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 FROM RWS_WORK_ADMN_TBL W ,rws_work_exp_voucher_tbl exp  where w.work_id=exp.work_id  and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) ";
		 
			 if(dcode!=null && !dcode.equals("00")){
				 expQuery1+="and substr(w.work_id,5,2)='"+dcode+"'";
				}

		if(scheme!=null && !scheme.equals("")){
			expQuery1+="and w.type_of_asset in("+scheme+")";
		}
		 
		expQuery1+=" and  w.programme_code in ("+programe+")  group by W.WORK_ID";

			
	       System.out.println("expQuery1"+expQuery1);
		 	rs2=stmt2.executeQuery(expQuery1);
		 	Hashtable expHash1=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		expHash1.put(rs2.getString(1),rs2.getString(2));
		  	}
			

			
		  	if(expHash1!=null && expHash1.size()>0){
				
				session.setAttribute("expHash1",expHash1);
			}
		 	  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();


/******   New  Works *****************************************************/


    stmt2=conn.createStatement();
	//String newWorksQuery="select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp   where sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null ";
 
	
	String newWorksQuery="select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name ,NO_OF_HABS FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp   where  sp.subprogramme_code=substr(w.WORK_ID,3,2) and substr(w.WORK_ID,5,2)=D.DCODE and substr(w.WORK_ID,1,2)=pr.programme_code and Special_cat<>'SCSP' and (w.PROB_EXP >0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >='01-Apr-"+startyr+"'))  and  sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and w.work_id  not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and SANCTION_AMOUNT is not null ";
	
	//select pr.programme_name,D.DNAME,W.WORK_ID,WORK_NAME,to_char(w.admin_date,'dd/mm/yyyy'),SANCTION_AMOUNT,CATEGORY_CODE,TYPE_OF_ASSET,pr.programme_code ,w.SPECIAL_CAT ,sp.subprogramme_name FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl D,rws_programme_tbl pr,rws_subprogramme_tbl sp , rws_sc_works_view sc  where sc.work_id=w.work_id and sp.subprogramme_code=substr(sc.WORK_ID,3,2) and substr(sc.WORK_ID,5,2)=D.DCODE and substr(sc.WORK_ID,1,2)=pr.programme_code and Special_cat<>'SCSP' and (w.PROB_EXP >0 or w.work_id in (select work_id from rws_work_exp_voucher_tbl where voucher_dt >'01-apr-2013'))  and  sp.programme_code=pr.programme_code and sp.subprogramme_code=substr(W.WORK_ID,3,2) and substr(W.WORK_ID,5,2)=D.DCODE and substr(W.WORK_ID,1,2)=pr.programme_code  and WORK_CANCEL_DT is null and  w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-2013')) and SANCTION_AMOUNT is not null and D.DCODE='02'and w.type_of_asset in(01,02) and  pr.programme_code in (01,02,18,23,32,48,49,51,58) order by CATEGORY_CODE ;

	
	 if(dcode!=null && !dcode.equals("00")){
         newWorksQuery+="and D.DCODE='"+dcode+"'";
		}

if(scheme!=null && !scheme.equals("")){
          newWorksQuery+="and w.type_of_asset in("+scheme+")";
}
 
 newWorksQuery+=" and  pr.programme_code in ("+programe+") order by CATEGORY_CODE,D.dcode ";

	
System.out.println("New Works"+newWorksQuery);
 	rs2=stmt2.executeQuery(newWorksQuery);
	
  int styleCount=0;
  String style="";
  int recCount=1;
  
  int totWorkPop=0;
  
  
  int ggplainpop=0,ggscPOP=0,ggstPop=0;
	int ggtotPOP=0;
	
	double ggplainEST=0,ggscEST=0,ggstEST=0; 	double ggstateplainEST=0,ggstatescEST=0,ggstatestEST=0;
	double ggplainExp=0,ggscEXp=0,ggstExp=0,ggtotalEXP=0,scspbCost=0,SCSPother=0,balanceest40=0,SCSPother11=0,totalotherscsp=0,gSCSPother11=0,gggSCSPother11=0;
	
	//new added
	
	double gglCenExp=0,gglNCenExp=0,ggexpDuringCen=0, gsanctionedAmount=0,ggtotsanamt=0;
	double ggexpSc=0,ggexpPlain=0,ggexpSt=0,ggexpTot=0,ggOtherFundExp=0;
	double gglPlainExp=0,gglScExp=0,gglStExp=0,gglTotExp=0,gglNPlainExp=0,gglNScExp=0,gglNStExp=0,gglNTotExp=0,ggOtherFundLikeExp=0;
	double ggtotEST=0,scstateshare=0;
	double ggstatetotEST=0;
	
	double ggbalanceEST=0;
  String workId="";
 
  
  //start printing
	while(rs2.next())
	{
		double gunderscexp=0,gunderotherexp=0,gtotsanamt=0;
		String subplanSubmitted="";
		String typeOfAsset="";
		String clauseType="",clauseType1="";
		String workType="";
		boolean flag=true;
		double expUpto=0,exptot=0;
		double expDuring=0;
		workId=rs2.getString(3);
		String nHabsStr=rs2.getString(12);
		if(nHabsStr==null || nHabsStr.equals("")){
			nHabsStr="0";
		}
		int noofHabs=Integer.parseInt(nHabsStr);
		
		
		double moreProgramSanctioned=0;
		String subProgramme="";
		
		double probExp=0,probExpNextYear=0;
		subProgramme=rs2.getString(11);
		
		String val=(String)contractorExpHash.get(workId);
		
		if(val!=null){
		
			String vals[]=val.split("@");
			if(vals[0]!=null && !vals[0].equals("null") ){
				probExp=Double.parseDouble(vals[0]);
			}
			if(vals[1]!=null && !vals[1].equals("null")){
				probExpNextYear=Double.parseDouble(vals[1]);
			}
			
			
		}
		
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
		//System.out.println("Subplan Submitted:"+subplanSubmitted);
		
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
		if(expHash.get(rs2.getString(3))!=null && !expHash.get(rs2.getString(3)).equals("")){
		 
			//expUpto
			String expValues=(String)expHash.get(rs2.getString(3));
			String exp[]=expValues.split("@");
			expUpto=Double.parseDouble(exp[0]);
			expDuring=Double.parseDouble(exp[1]);
			
		}
		
		
		if(expHash1.get(rs2.getString(3))!=null && !expHash1.get(rs2.getString(3)).equals("")){
			 
			//expUpto
			String expValues1=(String)expHash1.get(rs2.getString(3));
			exptot=Double.parseDouble(expValues1);
						
		}
		
		String categoryCode=rs2.getString(7);
		typeOfAsset=rs2.getString(8);
		double balanceEST=sanctionedAmount-exptot;
		
		ggbalanceEST+=balanceEST;
		double stateSharePer=0,lstateSharePer=0,lNstateSharePer=0,expDuringCentralShare=0,expDuringStateShare=0;
		String programeCode=rs2.getString(9);
		if(programeCode!=null && (programeCode.equals("01") || programeCode.equals("18") || programeCode.equals("49") || programeCode.equals("51") || programeCode.equals("23")|| programeCode.equals("02") )){
		
			stateSharePer=0.5*balanceEST;
			lstateSharePer=0.5*probExp;
			lNstateSharePer=0.5*probExpNextYear;
			expDuringCentralShare=0.5*expDuring;
			expDuringStateShare=0.5*expDuring;
			scstateshare=0.5*balanceEST;
			
		}
		else if(programeCode!=null && (programeCode.equals("65") || programeCode.equals("12") || programeCode.equals("46")|| programeCode.equals("57")|| programeCode.equals("04")|| programeCode.equals("09")|| programeCode.equals("39") || programeCode.equals("15") )){
			
			stateSharePer=balanceEST;
			
			lstateSharePer=probExp;
			lNstateSharePer=probExpNextYear;
					
			expDuringStateShare=expDuring;
			scstateshare=balanceEST;
			
			
		}
		
		if(workId.substring(4,6)!=null&& workId.substring(4,6).equals("12") && programeCode.equals("58")){
			stateSharePer=0.0;
			lstateSharePer=0.0;
			lNstateSharePer=0.0;
			expDuringStateShare=0;
			scstateshare=0;
			continue;
		}
		
		
		
		//System.out.println("stateSharePer:"+stateSharePer);
	
		
		
		String balanceEST1=(String.valueOf(ndf.format(sanctionedAmount-exptot)));
		//System.out.println("balanceEST1::"+balanceEST1);
		
		
		String sanctionedAmount1=(String.valueOf(ndf.format(sanctionedAmount)));	
		
		String strTemp="";
			if(!typeOfAsset.equals("11")){
				if(totalPOPHash.get(rs2.getString(3))!=null && !totalPOPHash.get(rs2.getString(3)).equals("")){
					 strTemp=(String)totalPOPHash.get(rs2.getString(3));
				}
			}else if(typeOfAsset.equals("11")){
				strTemp=(String)schoolTotPOPHash.get(rs2.getString(3));
				//totWorkPop =Integer.parseInt((String)schoolTotPOPHash.get(rs2.getString(3)));
			}
			

			
			 if(strTemp!=null && !strTemp.equals("")){
			
			
			//Add code here 
			
			
			String popValues[] = strTemp.split("@");

			int plainPop_Tot = Integer.parseInt(popValues[0]);
			int scPop_Tot = Integer.parseInt(popValues[1]);
			int st_Tot = Integer.parseInt(popValues[2]);
			
			totWorkPop =plainPop_Tot+scPop_Tot+st_Tot;
			if(scPop_Tot==0)
			{
				continue;
			}
			
			
			//percentage total work wise
			
				double plainPerT = ((double)plainPop_Tot * 100/(double) totWorkPop);
				double scPerT = ((double)scPop_Tot * 100/ (double) totWorkPop);
				double stPerT = ((double)st_Tot * 100/ (double) totWorkPop);
			
			if(stPerT>=40)
			{
				continue;
			}			 
				
			if(totWorkPop==0)
			{
				continue;
				
			}
		} 
		
			 //////////END....................
		
		double expPerPerson=0;
		if(expDuring>0 && totWorkPop>0)
		{
		   expPerPerson=(expDuring/totWorkPop);
		}
		//System.out.println("totalPOPHash.get(rs2.getString(3):"+totalPOPHash.get(rs2.getString(3)));
		
		//System.out.println("balanceEST"+balanceEST);
		String admnDate=rs2.getString(5);
		//System.out.println("admnDate:"+admnDate);//17/08/2012
		java.util.Date d1=new java.util.Date(Integer.parseInt(admnDate.substring(6,10)),Integer.parseInt(admnDate.substring(3,5)),Integer.parseInt(admnDate.substring(0,2)));
		java.util.Date d2=new java.util.Date(2013,2,31);
			
		if(d1.after(d2))
		{
			workType="New Work";
		}
		else
		{
			workType="Spill Over";
		}
		
		
		
		 if(styleCount%2==0)
		 {
			 style="gridbg1";
		 }
		else
		 {
			 style="gridbg2";
		 }
		 styleCount++;
		
		
		 
		 %>
		 
		 <tr><td class=<%=style %>><%=recCount++ %></td>
		 
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(1) %></td>
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Sub Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(11) %></td>
		  <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Head Of Account',TITLE,'Information')" onmouseout="UnTip()">-</td>
		 
		 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(2) %></td>
		  <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Constituency',TITLE,'Information')" onmouseout="UnTip()">-</td>
		 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Work Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(4) %></td>
		 
		 <%  
		 if(categoryCode.equals("1") || noofHabs>1){
		 
		 %>
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('WorkId',TITLE,'Information')" onmouseout="UnTip()">-</td>
		 
		 <% }  else {%>
		 
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('WorkId',TITLE,'Information')" onmouseout="UnTip()"><%=workId  %></td>
		 <%  } %>
		 
		 
		 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Nature Of the Work',TITLE,'Information')" onmouseout="UnTip()"><%=workType %></td>
		 
		 <% 
	
		
		 String habQuery="";
		 if(!typeOfAsset.equals("11"))
		 {		 
		  
			 habQuery="select a.hab_code,b.PANCH_NAME,b.MNAME,b.PNAME,b.vname,EXIST_WATER_LEVEL from rws_admn_hab_lnk_tbl a,rws_complete_hab_view b where a.work_id='"+rs2.getString(3)+"' and a.hab_code=b.panch_code";
			 
		 }
		 else if(typeOfAsset.equals("11"))
		 {
			 
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
		String pop_exp = "";
		
		
	 	
		
	 	while(rs3.next()){
	 		
	 		String coverageStatus="";
	 		
	 		double totsanamt=0,underscexp=0,underotherexp=0;
	 		
	 		double  existingWaterLevel=0;
	 		
	 		
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
	 		 if(!typeOfAsset.equals("11")){
	 		 pop=(String)sanctionedHabsHash.get(rs3.getString(1));
	 		 }else if(typeOfAsset.equals("11")){
	 			pop=(String)schoolTotPOPHash.get(rs3.getString(1));
	 		 }
	 	
	 		String popValues[]=pop.split("@");
	 		double plainPOP=Double.parseDouble(popValues[0]);
	 		  scPOP=Double.parseDouble(popValues[1]);
	 		double stPOP=Double.parseDouble(popValues[2]);
	 		
	 		gplainpop+=plainPOP;
	 		gscPOP+=scPOP;
	 		gstPop+=stPOP;
	 		
	 		
	 		double totPop=plainPOP+scPOP+stPOP;
	 		gtotPOP+=totPop;
	 		double totPP=Integer.parseInt(popValues[0])+Integer.parseInt(popValues[1])+Integer.parseInt(popValues[2]);
	 		
	 		ggplainpop+=plainPOP;
	 		ggscPOP+=scPOP;
	 		ggstPop+=stPOP;
	 		ggtotPOP+=totPP;
	 		
	 		double plainPer=0,scPer=0,stPer=0;
	 		
	 		plainPer = (plainPOP * 100/ totPop);
	 		scPer = (scPOP * 100/ totPop);
	 		stPer = (stPOP * 100/ totPop);
	 		
	 		
	 		//totPop_exp = Integer.parseInt(popValues_exp[0])+ Integer.parseInt(popValues_exp[1])+ Integer.parseInt(popValues_exp[2]);
	 		
	 		//////////scsp 261229
	 		
	 		//******************************

						int totPop_exp = 0;
						pop_exp = (String) sanctionAmtQeryHash.get(rs2
								.getString(3));
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

							totsanamt = (sanctionedAmount / totPop_exp) * totPP;
							//System.out.println("Sanction amount......."+sanctionedAmount);
							//System.out.println("grand pop amount......."+gtotPOP);
							//System.out.println("total pop amount......."+totPP);
						}

						gtotsanamt += totsanamt;

						ggtotsanamt += totsanamt;

						/////////////////////////////////

						underscexp = (scstateshare / totWorkPop) * scPOP;

						double totStateEst = (scstateshare / totPop_exp)
								* totPop;

						//underscexp=(totsanamt/totPP)*scPOP;

						underotherexp = totStateEst - underscexp;

						String uscexp = (String.valueOf(ndf.format(underscexp)));
						String uothscexp = (String.valueOf(ndf
								.format(underotherexp)));
						
						

						gunderscexp += underscexp;
						gunderotherexp += underotherexp;

						ggunderscexp += underscexp;
						ggunderotherexp += underotherexp;

	 		
	 		/////////////////////////////////////
	 		
	 		
	 		
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
	 		 
	 		if(categoryCode.equals("2")){
	 			double balance2=(stateSharePer/totWorkPop);
	 			double balance1=(balanceEST/totWorkPop);
	 			double balance3=(lCentralShare/totWorkPop);
	 			double balance4=(lstateSharePer/totWorkPop);
	 			double balance5=(lNCentralShare/totWorkPop);
	 			double balance6=(lNstateSharePer/totWorkPop);
	 			double balance7=(expDuringCentralShare/totWorkPop);
	 			double balance8=(expDuringStateShare/totWorkPop);
	 			
	 			
	 			double  habPop=plainPOP+stPOP+scPOP;
	 			if(scPer>=40){
	 				clauseType="SC > 40%";

	 				scPOP+=plainPOP+stPOP;
	 				scBalanceEST=(balance1*scPOP);
	 				
	 				
	 				
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
	 				
	 			}else {
	 				
	 				
	 				if(scPOP==0 && stPOP==0){
	 					clauseType="Plain Hab";
	 				}else{
	 				clauseType="< 40%";
	 				}
	 				
	 				
	 				//plainBalanceEST=balanceEST;
	 				//System.out.print("plainPOP"+plainPOP);
	 				//System.out.print("balance1"+balance1);
	 				
	 				plainBalanceEST=(balance1*plainPOP);
	 				scBalanceEST=(balance1*scPOP);
	 				stEST=(balance1*stPOP);
	 				
	 				
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
	 				
	 				  
	 				
					//******State Share 
	 				
	 				statescBalanceEST=(balance2*scPOP);
	 				stateplainBalanceEST=(balance2*plainPOP);
	 				statestEST=(balance2*stPOP);
	 				
	 				//added likely Expenditure Columns Data
	 				lScExp=(balance4*scPOP);
	 				lStExp=(balance4*stPOP);
	 				lPlainExp=(balance4*plainPOP);
	 				
	 				
	 				
	 				//added
	 				
	 				
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
	 		}else if(categoryCode.equals("1")){
	 			//System.out.println("totWorkPop:"+totWorkPop);
	 			
	 			double balance1=(balanceEST/totWorkPop);
	 			
	 			double balance2=(stateSharePer/totWorkPop);
	 			
	 			double balance3=(lCentralShare/totWorkPop);
	 			
	 			double balance4=(lstateSharePer/totWorkPop);
	 			
	 			double balance5=(lNCentralShare/totWorkPop);
	 			
	 			double balance6=(lNstateSharePer/totWorkPop);
	 			
	 			double balance7=(expDuringCentralShare/totWorkPop);
	 			double balance8=(expDuringStateShare/totWorkPop);
	 			double  habPop=plainPOP+stPOP+scPOP;
	 				 			
	 			if(scPer>=40){
	 				clauseType="SC >40%";
	 				scPOP+=plainPOP+stPOP;
	 				scBalanceEST=(balance1*scPOP);
	 				
	 				//scBalanceEST=balance1;
	 				plainBalanceEST=0;
	 				stEST=0;
	 				
	 				//Expenditure
	 				
	 				 scExp=expPerPerson*scPOP;
	 				plainExp=0;
	 				stExp=0;
	 				
	 				//******State Share
	 				
	 				statescBalanceEST=balance2*scPOP;
	 				stateplainBalanceEST=0;
	 				statestEST=0;
	 				
	 				lScExp=balance4*habPop;
	 				lNScExp=balance6*habPop;
	 				
	 				
	 				expSc=balance8*habPop;
	 				
	 				
	 				
	 				
	 				
	 			}else if(stPer>=40){
	 				clauseType="ST > 40%";
	 				
	 				stPOP+=plainPOP+scPOP;
	 				stEST=(balance1*stPOP);
	 				//stEST=balance1;
	 				plainBalanceEST=0;
	 				scBalanceEST=0;
	 				
	 				
	 				//Expenditure
	 				
	 				 stExp=expPerPerson*stPOP;
	 				plainExp=0;
	 				scExp=0;
	 				
	 				
	 				
					//******State Share
	 				
	 				statescBalanceEST=0;
	 				stateplainBalanceEST=0;
	 				statestEST=(balance2*stPOP);
	 				
	 				
	 				lStExp=balance4*habPop;
	 				lNStExp=balance6*habPop;
	 				
	 				
	 				expSt=balance8*habPop;
	 				
	 			}else{
	 			
	 				
	 				
	 				if(scPOP==0 && stPOP==0){
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
	 		
	 	
	 		
	 		
	 	
	 		glTotExp=lCenExp+lPlainExp+lScExp+lStExp;
	 		
//Likely  Expenditure Other Funds
	 		
	 		OtherFundaslikelySC=glTotExp-lScExp;

	 		ggOtherFundLikeExp+=OtherFundaslikelySC;
	//System.out.println("********************** "+OtherFundaslikelySC);
	 		
	 		
	 		
	 		
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
	 		
	 		gglNCenExp+=expDuringCen;
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
	 		
	 		
	 		plainBalanceEST=0;scBalanceEST=0;stEST=0;
	 		
	 		
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
	 		
	 		
	 		
	 		//balance Estamete Cost
	 		
	 		balanceest40= Double.parseDouble(balanceEST1);
	 		
			scspbCost=(balanceest40/totPP)*scPOP;
	 		
	 		
			//total Other Funds
	 		
		 	SCSPother=balanceest40-scspbCost;
	 		
	 		
	
      //ToTal Expenditure Other Funds
	 		
	 		OtherFundasSC=totExpDur-expSc;
      
	 		ggOtherFundExp+=OtherFundasSC;
	 		
	 		
	 		
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
	 			
	 			<tr><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %> >-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>></td>
	 			<% 
	 			
	 			}
	 		
	 		
	 		%>
	 		
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Mandal',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(3) %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Panchyath',TITLE,'Information')" onmouseout="UnTip()" ><%=rs3.getString(4) %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('HabCode',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(1) %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Existing Water Level',TITLE,'Information')" onmouseout="UnTip()"><%=existingWaterLevel %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Coverage Status',TITLE,'Information')" onmouseout="UnTip()"><%=coverageStatus %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Hab Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs3.getString(2) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=sanctionedAmount1 %> </td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%= balanceEST1 %></td> 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(totEST)%></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SCSP Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=uscexp%></td>
	 		
	 		<%	
	 		
	 		SCSPother11=totEST-Double.parseDouble(uscexp);
	 		gSCSPother11+=SCSPother11;
	 		gggSCSPother11+=SCSPother11;
	 		%>
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('OtherFunds Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(SCSPother11) %></td>
	 		
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Population',TITLE,'Information')" onmouseout="UnTip()"><%=popValues[0] %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Population',TITLE,'Information')" onmouseout="UnTip()" ><%=popValues[1] %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Population',TITLE,'Information')" onmouseout="UnTip()" ><%=popValues[2] %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Population',TITLE,'Information')" onmouseout="UnTip()"><%=totPP %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SC Population%',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer) %></td>
	 		<td class=<%=style %> style="text-align: left;" onmouseover="Tip('Clause Type',TITLE,'Information')" onmouseout="UnTip()"><%=clauseType %></td>
	 		
	 		<td class=<%=style %> style="text-align: center;"><%=subplanSubmitted %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Physical Status',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Central During Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expDuringCen) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain During  Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expPlain) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SCSP During Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(expSc) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST During Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(expSt) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total During Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(totExpDur)  %></td>
	 		
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Under Other Funds During Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(OtherFundasSC) %></td>
	 		
	 		
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Central Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lCenExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Plain LikelyExpenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lPlainExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('SCSP LikelyExpenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(lScExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('ST LikelyExpenditure',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(lStExp) %></td>
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Total Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotExp) %></td>
	 		
	 		
	 		<td class=<%=style %> style="text-align: right;" onmouseover="Tip('Under Other Funds Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(OtherFundaslikelySC)%></td>
	 		
	 		</tr>
	 		
	 		
	 		<% 
	 		
	 		balanceEST1="0";
	 		sanctionedAmount1="-";
	 		flag=false;
	 	
	 		
	 		
	 	}
	 	if(!flag2){
	 		
	 		
	 		
	 		%>
	 		<td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>>-</td><td class=<%=style %>></td>
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
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	
 		if(categoryCode.equals("1") || workId.equals("-"))
 		{
	 	%>
	 	
	 	<tr><td class=<%=style %> style="text-align: left;">-</td>
	 	<td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(1) %></td>
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Sub Programme',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(11) %></td>
		 
		 <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Head Of Account',TITLE,'Information')" onmouseout="UnTip()">-</td>
		 
		 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('District',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(2) %></td>
		  <td class=<%=style %> style="text-align: left;"  onmouseover="Tip('Constituency',TITLE,'Information')" onmouseout="UnTip()">-</td>
		 <td class=<%=style %> style="text-align: left;" onmouseover="Tip('Work Name',TITLE,'Information')" onmouseout="UnTip()"><%=rs2.getString(4) %></td>
		 <td class=<%=style %> style="text-align: right;"><%=rs2.getString(3) %></td><td class=gridhdbg colspan=7 style="text-align: right;">Total:</td>
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Sanctioned Amount',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(sanctionedAmount) %></td>
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(balanceEST) %></td>
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(gtotsanamt) %></td>
	 	
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: SCSP Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(gunderscexp) %></td>
	 	<%
	 	totalotherscsp=gtotEST-gstatescEST;
	 	
	 	ggggtotEST+=gtotEST;
	 	ggggstatescEST+=gstatescEST;
	 	
	 	%>
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Other Funds Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()" ><%=ndf.format(gSCSPother11) %></td>
	 	<%
	 	ggggtotalotherscsp+=totalotherscsp;
	 	%>
	 	
	 	
	 	
	 	
	 	
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Work Wise: Total Plain Population',TITLE,'Information')" onmouseout="UnTip()"><%=gplainpop %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total SC Population',TITLE,'Information')" onmouseout="UnTip()"><%=gscPOP %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total ST Population',TITLE,'Information')" onmouseout="UnTip()"><%=gstPop %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Population(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=gtotPOP %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer1) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: SC Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer1) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer1) %></td>
	 	<td class=gridhdbg><%=clauseType1 %></td>
	 	<td class=gridhdbg style="text-align: center;"><%=subplanSubmitted %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Physical Status',TITLE,'Information')" onmouseout="UnTip()"><%=grounded %>/<%=completed %></td>
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gexpDuringCen) %></td>
	 
	 	
	 	
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total During Plain Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpPlain) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total During SC Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSc) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total During ST Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpSt) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total During Tot Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gExpTot) %></td>
	 	<% 
	 	//total Exp 
	 	
	 	
	 	gexpendituretot=gExpTot-gExpSc;
	 	%>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Other Funds Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gexpendituretot)%></td>
	 
	 	
	 	
	 	
	 	
	 		<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Central Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glCenExp) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Plain Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glPlainTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: SC Likely Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glScTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: ST LikelyExpenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glStTot) %></td>
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total  Likely Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(glTotTot) %></td>
	 	<%
	 	
	 	//gtotal
	 	gtotlikely=glTotTot-glScTot;
	 	
	 	%>
	 	
	 	
	 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Work Wise: Total Other Funds Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gtotlikely)%></td>
	 
	 	
	 	</tr>
			
		
		<% 
 		}
	
	}   //End Main Loop
	
	
	double plainPer1 = ((double)ggplainpop * 100/ ggtotPOP);
		double scPer1 = ((double)ggscPOP * 100/ ggtotPOP);
		double stPer1 = ((double)ggstPop * 100/ ggtotPOP);
	
	
	%>
		
	<tr><td class=gridhdbg colspan=15 style="text-align: right;">Grand Total:</td>
	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Sanction Amount',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gsanctionedAmount) %></td>
	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggbalanceEST) %></td>
	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggtotsanamt) %></td>	
	<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total SCSP Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%= ndf.format(ggunderscexp) %></td>
		<td class=gridhdbg style="text-align: right;"  onmouseover="Tip('Total Under Others Balance Estimate Cost',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gggSCSPother11)%></td>
	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggplainpop %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggscPOP %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Population',TITLE,'Information')" onmouseout="UnTip()"><%=ggstPop %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Population(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ggtotPOP %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(plainPer1) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(scPer1) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST Population %',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(stPer1) %></td>
	
	<td class=gridhdbg>-</td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('-',TITLE,'Information')" onmouseout="UnTip()">-</td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('-',TITLE,'Information')" onmouseout="UnTip()">-</td>
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Central During Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglNCenExp) %></td>
 	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Plain During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpPlain) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total SC During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSc) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total ST During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpSt) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Tot During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggexpTot) %></td>
	<%
	//total Expenditure
	ggexpenditure=ggexpTot-ggexpSc;
	
	
	%>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total  Other Funds During Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggOtherFundExp) %></td>
	
	
	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Central Likely  Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglCenExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Likely Plain Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglPlainExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Likely SC Expenditure',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglScExp) %></td>
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Likely ST Expenditure.(Plain+SC+ST)',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglStExp) %></td>
	
	
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Likely Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(gglTotExp) %></td>
	<%
	//likely total 
	gglikelytot=gglTotExp-gglScExp;
	%>
	
	<td class=gridhdbg style="text-align: right;" onmouseover="Tip('Total Other Funds Likely Expenditure.',TITLE,'Information')" onmouseout="UnTip()"><%=ndf.format(ggOtherFundLikeExp) %></td>
	
 	</tr>
	<% 

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</body>
</html>