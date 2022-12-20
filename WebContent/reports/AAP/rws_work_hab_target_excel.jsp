
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
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



    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";
	
   
    

	if((String)session.getAttribute("financialyr")!=null){
	financialstartyr=(String)session.getAttribute("financialyr");
	}
   
	
String scheme="";
  if((String[])session.getAttribute("schemes")!=null){
    String[] schemes=(String[])session.getAttribute("schemes");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);

}

	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
       String[] programes=(String[])session.getAttribute("programes");
    	

    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	////System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);

	////System.out.println("programe::"+programe);
 

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   ////System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(startyr);
   
   String nextfinancialstartyr="";
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr=""+nextFinYear+"-"+nn;
////System.out.println("startyr"+startyr);
   ////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;




String startyr2="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {
endyr1=endyr;
}
String probstrng="";
if(financialstartyr.equals("2013-2014")){
	probstrng="PROB_EXP";
}
if(financialstartyr.equals("2014-2015")){
	probstrng="PROB_EXP_NXT_YR";
}
if(financialstartyr.equals("2015-2016")){
	probstrng="PROB_EXP_NXT_YR1";
}
if(financialstartyr.equals("2016-2017")){
	probstrng="PROB_EXP_NXT_YR2";
}
////System.out.println("Startyr:"+startyr);
////System.out.println("StartyRr2:"+startyr2 );
////System.out.println("Endyr:"+endyr );

////System.out.println("Endyr2:"+endyr1);


     ////System.out.println("Get Cuurent MOnth:"+d.getMonth());


String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");

String targetyr=financialstartyr;

////System.out.println("dcode"+dcode);
////System.out.println("DivCode"+divCode);


	%>
	
	<body>
	 
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "SC/ST_SubPlan_details.xls");

%>
	
	
<table border=1 cellspacing=0 cellpadding=0 width="80%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center"><tr >
			<td align="center" class="gridhdbg" colspan=32>AAP <%=financialstartyr %>- List of SVS/MVS Works & Habitations targeted for completion during the year <%=financialstartyr %> under various programs</td>	
	
	</tr>
		<tr >
		<td  class="gridhdbg" rowspan=2>Sl.No</td>
		<td   class="gridhdbg" rowspan=2>District</td>
		<td  class="gridhdbg" rowspan=2>Division</td>
		<td class="gridhdbg"  rowspan=2 >New/Spill</td>
		<td  class="gridhdbg" rowspan=2>Work Name</td>
        <td  class="gridhdbg" rowspan=2>Work ID </td>
		<td  class="gridhdbg" rowspan=2>Programme</td>
		<td  class="gridhdbg" rowspan=2>Sub Programme</td>
		<td  class="gridhdbg" rowspan=2>Admin Sanction No</td>
        <td  class="gridhdbg" rowspan=2>Admin Sanction Date </td>
		<td   class="gridhdbg" rowspan=2>SLSC Meeting Date</td>
		<td  class="gridhdbg" rowspan=2>Est. Cost/Bal Est cost as on 1.4.<%=startyr %> for spill</td>
		<td class="gridhdbg"  rowspan=2 >Work type(Main/Aug)</td>
  		<td class="gridhdbg"  rowspan=1 colspan="6">Habitations Sanctioned Details</td>
 		<td  class="gridhdbg" rowspan=1></td>
  		<td class="gridhdbg"  rowspan=1 colspan="4">Source Details</td>
		<td class="gridhdbg"  rowspan=2 >Grounding Date</td>
        <td class="gridhdbg"  rowspan=2 >Probable Date of Completion</td>
        <td class="gridhdbg"   colspan="3" >Probable Expenditure(in Fin Years) <br></br></td>
        <td class="gridhdbg"  rowspan=2 >Remarks</td>


</tr>
<tr>
<td  class="gridhdbg">Target Year</td>
 		<td  class="gridhdbg">Mandal</td>
		<td  class="gridhdbg">Panchayath</td>
		<td  class="gridhdbg">Habitation</td>
		<td  class="gridhdbg">Hab Code</td>
		<td  class="gridhdbg">Status as on 01/04/<%=startyr%></td>
		<td  class="gridhdbg">Habitation Category(SC/ST/Others)</td>
		<td  class="gridhdbg">Source Code</td>
		<td  class="gridhdbg">Source Name</td>
		<td  class="gridhdbg">Source Type(Surface/Sub-Surface)</td>
		<td  class="gridhdbg">Location(Hab Name)</td>
		
		
		<td  class="gridhdbg">Current Year</td>
		<td  class="gridhdbg">Next Year</td>
		<td  class="gridhdbg">Next to Next Year</td>
		<!-- 	<td  class="gridhdbg">2013-2014</td>
		<td  class="gridhdbg">2014-2015</td>
		<td  class="gridhdbg">2015-2016</td>
		<td  class="gridhdbg">2016-2017</td> -->
		

</tr>
<tr>
	<%for(int i=1;i<31;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
int count=0;
String temp="",dname="",divname="",worknm="",workid="",wrktype="",program="",subprog="",admsandt="",admsanno="",slscmeetingdt="",wrknature="",sourcecd="",sourcenm="",srctype="",location="",grounddt="",probdate="";
String sno="",snamnt="",remarks="",tempdist="";

  try{
	  Hashtable sourct_det=(Hashtable)session.getAttribute("sourct_det");	  
	  Hashtable estcost_det=(Hashtable)session.getAttribute("estcost_det");
	  Hashtable direstcost_det=(Hashtable)session.getAttribute("direstcost_det");
	  Hashtable groumd_det=(Hashtable)session.getAttribute("groumd_det");
	  Hashtable estcost1_det=(Hashtable)session.getAttribute("estcost1_det");
	  String probexp="",probexp1="",probexp2="",probexp3="";
	  String habqry="SELECT i.dname,j.DIVISION_OFFICE_NAME,a.WORK_NAME,a.WORK_ID,g.PROGRAMME_NAME,h.SUBPROGRAMME_NAME,a.SANCTION_AMOUNT,(case when a.REMARKS is null then '-' else a.REMARKS end) as REMARKS ,ADMIN_NO,(case when ADMIN_DATE is null then '-' else TO_CHAR(ADMIN_DATE,'dd/mm/yy')  end) as ADMIN_DATE,(case when AUG_NEW_CODE='1' then 'MAIN' else 'AUG' end) as AUG_NEW_CODE,(case when TARGET_DATE_COMP is null then '-' else TO_CHAR(TARGET_DATE_COMP,'dd/mm/yy')  end) as TARGET_DATE_COMP,(case when to_date(a.ADMIN_DATE) <'01-Apr-"+startyr+"' then 'Spill' else 'New' end),d.mname,e.pname,f.PANCH_NAME,b.hab_code,c.COVERAGE_STATUS,c.CENSUS_SC_POPU,c.CENSUS_ST_POPU,c.CENSUS_PLAIN_POPU,AAP_TARGET_YEAR,(case when SLCCDATE is null then '-' else TO_CHAR(SLCCDATE,'dd/mm/yy')  end) as slccdate, nvl(PROB_EXP,0) as exp1,nvl(PROB_EXP_NXT_YR,0) as exp2 ,nvl(PROB_EXP_NXT_YR1,0) as exp3,nvl(PROB_EXP_NXT_YR2,0) as exp4   FROM RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c,RWS_MANDAL_TBL d,RWS_PANCHAYAT_TBL e,RWS_PANCHAYAT_RAJ_TBL f,RWS_PROGRAMME_TBL g,RWS_SUBPROGRAMME_TBL h,rws_district_tbl i,RWS_DIVISION_OFFICE_TBL j where AAP_TARGET_YEAR='"+targetyr+"' and work_cancel_dt is null  and   to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"' and a.work_id=b.work_id and b.hab_code=c.hab_code  and substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode and substr(b.hab_code,1,2)=e.dcode and substr(b.hab_code,6,2)=e.mcode and substr(b.hab_code,13,2)=e.pcode and b.hab_code=f.panch_code and a.PROGRAMME_CODE=g.PROGRAMME_CODE and a.PROGRAMME_CODE=h.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=h.SUBPROGRAMME_CODE and substr(a.work_id,5,2)=i.dcode and  substr(a.office_code,2,2)=j.CIRCLE_OFFICE_CODE and  substr(a.office_code,4,1)=j.DIVISION_OFFICE_CODE and c.COVERAGE_STATUS<>'UI' ";
		if(dcode!=null && !dcode.equals("00")){
			habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			habqry+=" and type_of_asset in("+scheme+") ";
		}
		habqry+=" and a.programme_code in ("+programe+") order by  substr(a.work_id,5,2),a.WORK_ID ";
		//System.out.println("habqry "+habqry);
		int styleCount=0;
		String style="";
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(habqry);
		while(rs2.next()){
			double voamnt=0.0,voamnt1=0.0;

			String habtype="SC";
			int temppop=rs2.getInt(19);
			if(rs2.getInt(20)>rs2.getInt(19)){
				habtype="ST";
				temppop=rs2.getInt(20);
			}
			
			if(rs2.getInt(20)==rs2.getInt(19)){
				habtype="SC";
				temppop=rs2.getInt(19);
			}
			if(rs2.getInt(21)>temppop){
				habtype="Plain";
				temppop=rs2.getInt(21);
			}
			 if(workid.equals(rs2.getString(4)) || temp.equals(rs2.getString(4))){
				 workid="-";
				 dname="-";
				 divname="-";worknm="-";wrktype="-";program="-";subprog="-";admsandt="-";admsanno="-";slscmeetingdt="-";wrknature="-";
				  sourcecd="-";
				   sourcenm="-";
				   srctype="-";
				   location="-";
				   probdate="-"; 
				   grounddt="-"; 
				   sno="";
				   snamnt="-";
				  remarks="-";
				  probexp="0";
				  probexp1="0";
				  probexp2="0";
				  probexp3="0";
					sourcecd = "-";
					sourcenm ="-";
					srctype = "-";
					location = "-";
				 ////System.out.println("in if"); 
	         }else{
	        	 count++;
	        	 workid=rs2.getString(4);
	        	 //System.out.println("work id="+rs2.getString(4)+"---"+workid); 
	        	 dname=rs2.getString(1);
	        	 divname=rs2.getString(2);
	        	 wrknature=rs2.getString(13);
	        	 worknm=rs2.getString(3);
	        	 program=rs2.getString(5);
	        	 subprog=rs2.getString(6);
	        	 admsanno=rs2.getString(9);
	        	 admsandt=rs2.getString(10);
	        	 slscmeetingdt=rs2.getString("slccdate");
	        	 wrktype=rs2.getString(11);
	        	 sno=Integer.toString(count);
	        	 remarks=rs2.getString(8);
	        	 probdate=rs2.getString(12);
	        	 probexp=rs2.getString("exp1");
	        	 probexp1=rs2.getString("exp2");
	        	 probexp2=rs2.getString("exp3");
	        	 probexp3=rs2.getString("exp4");
	        	 
	        	 if(wrknature.equals("New")){
	        		snamnt=rs2.getString(7); 
	        	 }else{
	        		
	        		 if(estcost_det.get(rs2.getString(4))!=null){
	        			 voamnt=Double.parseDouble((String)estcost_det.get(rs2.getString(4))); 
	        			 //System.out.println("workid="+rs2.getString(4)+"=="+voamnt); 
		        	 }
	        		 if(direstcost_det.get(rs2.getString(4))!=null){
	        			 voamnt+=Double.parseDouble((String)direstcost_det.get(rs2.getString(4))); 
	        			 //System.out.println("workid="+rs2.getString(4)+"=="+voamnt); 
		        	 }
	        		 if(estcost1_det.get(rs2.getString(4))!=null){
	        			 voamnt1=Double.parseDouble((String)estcost1_det.get(rs2.getString(4))); 
	        			// System.out.println("voamnt1="+rs2.getString(4)+"=="+voamnt1); 
		        	 }
	        		 //System.out.println(rs2.getString(4)+"--->"+rs2.getDouble(7)+"+"+voamnt1+"-"+voamnt+"="+(rs2.getDouble(7)+voamnt1-voamnt)); 
	        		 snamnt=ndf.format(rs2.getDouble(7)+voamnt1-voamnt); 
	        	 }
	        	 ////System.out.println("in else if");
	        	 if(sourct_det.get(rs2.getString(4))!=null){
					 String habsource = (String) sourct_det.get(rs2.getString(4));
						String srcvalues[] = habsource.split("@");
						sourcecd = srcvalues[0];
						sourcenm =srcvalues[1];
						srctype = srcvalues[2];
						location = srcvalues[3];
					
						  
				 }
	        	 if(groumd_det.get(rs2.getString(4))!=null){
	        		 grounddt=(String)groumd_det.get(rs2.getString(4)); 
	        		 
	        	 }
	        	
	        	
	         }
			 
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			%>
			<tr><td class=<%=style %> style="text-align: center;"><%=sno %></td>
			
			
		<td class=<%=style %> style="text-align: left;"><%=dname %></td>
		<td class=<%=style %> style="text-align: left;"><%=divname %></td>
		<td class=<%=style %> style="text-align: left;"><%=wrknature %></td>
		<td class=<%=style %> style="text-align: left;"><%=worknm %></td>
		<td class=<%=style %> style="text-align: left;"><%=workid %></td>
		<td class=<%=style %> style="text-align: left;"><%=program %></td>
		<td class=<%=style %> style="text-align: left;"><%=subprog %></td>
		<td class=<%=style %> style="text-align: left;"><%=admsanno %></td>
		<td class=<%=style %> style="text-align: left;"><%=admsandt %></td>
		<td class=<%=style %> style="text-align: left;"><%=slscmeetingdt %></td>
				<td class=<%=style %> style="text-align: right;"><%=snamnt %></td>

		<td class=<%=style %> style="text-align: left;"><%=wrktype %></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString("AAP_TARGET_YEAR") %></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(14) %></td>
		<td  class=<%=style %> style="text-align: left;"><%=rs2.getString(15) %></td>
		<td  class=<%=style %> style="text-align: left;"><%=rs2.getString(16) %></td>
		<td  class=<%=style %> style="text-align: left;"><%=rs2.getString(17) %></td>
		<td class=<%=style %> style="text-align: left;"><%=rs2.getString(18) %></td>
		<td class=<%=style %> style="text-align: left;"><%=habtype %></td>
		<td class=<%=style %> style="text-align: left;"><%=sourcecd %></td>
		<td class=<%=style %> style="text-align: left;"><%=sourcenm %></td>
		<td class=<%=style %> style="text-align: left;"><%=location %></td>
		<td class=<%=style %> style="text-align: left;"><%=srctype %></td>
		
	<td class=<%=style %> style="text-align: left;"><%=grounddt %></td>
		<td class=<%=style %> style="text-align: left;"><%=probdate %></td>
			<%-- <td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp)) %></td> --%>
			<td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp1)) %></td>
				 <td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp2)) %></td>
			<td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp3)) %></td>
		<td class=<%=style %> style="text-align: left;"><%=remarks %></td>
		</tr>
			
			
			<%
			sourcecd="-";
			sourcenm="-";
			location="-";
			srctype="-";
			grounddt="-";
			probdate="-";
			remarks="-";
			temp=rs2.getString(4);
			probexp="0";
			probexp1="0";
			probexp2="0";
			probexp3="0";
		}
	  if(stmt2!=null){
		  stmt2.close();
		  	  }
	  if(rs2!=null){
		  rs2.close();
		  	  }
	  String nohabqry="SELECT i.dname,j.DIVISION_OFFICE_NAME,a.WORK_NAME,a.WORK_ID,g.PROGRAMME_NAME,h.SUBPROGRAMME_NAME,a.SANCTION_AMOUNT,(case when a.REMARKS is null then '-' else a.REMARKS end) as REMARKS ,ADMIN_NO,(case when ADMIN_DATE is null then '-' else TO_CHAR(ADMIN_DATE,'dd/mm/yy')  end) as ADMIN_DATE,(case when AUG_NEW_CODE='1' then 'MAIN' else 'AUG' end) as AUG_NEW_CODE,(case when TARGET_DATE_COMP is null then '-' else TO_CHAR(TARGET_DATE_COMP,'dd/mm/yy')  end) as TARGET_DATE_COMP,(case when to_date(a.ADMIN_DATE) <'01-Apr-"+startyr+"' then 'Spill' else 'New' end),(case when SLCCDATE is null then '-' else TO_CHAR(SLCCDATE,'dd/mm/yy')  end) as slccdate, nvl(PROB_EXP,0) as exp1,nvl(PROB_EXP_NXT_YR,0) as exp2 ,nvl(PROB_EXP_NXT_YR1,0) as exp3,nvl(PROB_EXP_NXT_YR2,0) as exp4   FROM RWS_WORK_ADMN_TBL a,RWS_PROGRAMME_TBL g,RWS_SUBPROGRAMME_TBL h,rws_district_tbl i,RWS_DIVISION_OFFICE_TBL j where  work_cancel_dt is null  and   to_date(TARGET_DATE_COMP)>='01-Apr-"+startyr+"' and to_date(TARGET_DATE_COMP)<='31-Mar-"+endyr+"' and a.PROGRAMME_CODE=g.PROGRAMME_CODE and a.PROGRAMME_CODE=h.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=h.SUBPROGRAMME_CODE and substr(a.work_id,5,2)=i.dcode and  substr(a.office_code,2,2)=j.CIRCLE_OFFICE_CODE and  substr(a.office_code,4,1)=j.DIVISION_OFFICE_CODE and a.work_id not in (select distinct work_id from rws_admn_hab_lnk_tbl where AAP_TARGET_YEAR='"+targetyr+"')  ";
		if(dcode!=null && !dcode.equals("00")){
			nohabqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			nohabqry+=" and type_of_asset in("+scheme+") ";
		}
		nohabqry+=" and a.programme_code in ("+programe+") order by  substr(a.work_id,5,2),a.WORK_ID ";
		System.out.println("nohabqry "+nohabqry);
		
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(nohabqry);
		while(rs2.next()){
			double voamnt=0.0,voamnt1=0.0;

			
	        	 count++;
	        	 workid=rs2.getString(4);
	        	 //System.out.println("work id="+rs2.getString(4)+"---"+workid); 
	        	 dname=rs2.getString(1);
	        	 divname=rs2.getString(2);
	        	 wrknature=rs2.getString(13);
	        	 worknm=rs2.getString(3);
	        	 program=rs2.getString(5);
	        	 subprog=rs2.getString(6);
	        	 admsanno=rs2.getString(9);
	        	 admsandt=rs2.getString(10);
	        	 slscmeetingdt=rs2.getString("slccdate");
	        	 wrktype=rs2.getString(11);
	        	 sno=Integer.toString(count);
	        	 remarks=rs2.getString(8);
	        	 probdate=rs2.getString(12);
	        	 probexp=rs2.getString("exp1");
	        	 probexp1=rs2.getString("exp2");
	        	 probexp2=rs2.getString("exp3");
	        	 probexp3=rs2.getString("exp4");
	        	 if(wrknature.equals("New")){
	        		snamnt=rs2.getString(7); 
	        	 }else{
	        		
	        		 if(estcost_det.get(rs2.getString(4))!=null){
	        			 voamnt=Double.parseDouble((String)estcost_det.get(rs2.getString(4))); 
	        			 //System.out.println("workid="+rs2.getString(4)+"=="+voamnt); 
		        	 }
	        		 if(estcost1_det.get(rs2.getString(4))!=null){
	        			 voamnt1=Double.parseDouble((String)estcost1_det.get(rs2.getString(4))); 
	        			// System.out.println("voamnt1="+rs2.getString(4)+"=="+voamnt1); 
		        	 }
	        		 //System.out.println(rs2.getString(4)+"--->"+rs2.getDouble(7)+"+"+voamnt1+"-"+voamnt+"="+(rs2.getDouble(7)+voamnt1-voamnt)); 
	        		 snamnt=ndf.format(rs2.getDouble(7)+voamnt1-voamnt); 
	        	 }
	        	 ////System.out.println("in else if");
	        	 if(sourct_det.get(rs2.getString(4))!=null){
					 String habsource = (String) sourct_det.get(rs2.getString(4));
						String srcvalues[] = habsource.split("@");
						sourcecd = srcvalues[0];
						sourcenm =srcvalues[1];
						srctype = srcvalues[2];
						location = srcvalues[3];
					
						  
				 }
	        	 if(groumd_det.get(rs2.getString(4))!=null){
	        		 grounddt=(String)groumd_det.get(rs2.getString(4)); 
	        		 
	    
	        	
	        	
	         }
			 
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
						%>
			<tr><td class=<%=style %> style="text-align: center;"><%=count %></td>
		<td class=<%=style %> style="text-align: left;"><%=dname %></td>
		<td class=<%=style %> style="text-align: left;"><%=divname %></td>
		<td class=<%=style %> style="text-align: left;"><%=wrknature %></td>
		<td class=<%=style %> style="text-align: left;"><%=worknm %></td>
		<td class=<%=style %> style="text-align: left;"><%=workid %></td>
		<td class=<%=style %> style="text-align: left;"><%=program %></td>
		<td class=<%=style %> style="text-align: left;"><%=subprog %></td>
		<td class=<%=style %> style="text-align: left;"><%=admsanno %></td>
		<td class=<%=style %> style="text-align: left;"><%=admsandt %></td>
		<td class=<%=style %> style="text-align: left;"><%=slscmeetingdt %></td>
				<td class=<%=style %> style="text-align: right;"><%=snamnt %></td>

		<td class=<%=style %> style="text-align: left;"><%=wrktype %></td>
		<td class=<%=style %> style="text-align: left;">-</td>
		<td class=<%=style %> style="text-align: left;">-</td>
		<td  class=<%=style %> style="text-align: left;">-</td>
		<td  class=<%=style %> style="text-align: left;">-</td>
		<td  class=<%=style %> style="text-align: left;">-</td>
		<td class=<%=style %> style="text-align: left;">-</td>
		<td class=<%=style %> style="text-align: left;">-</td>
		<td class=<%=style %> style="text-align: left;"><%=sourcecd %></td>
		<td class=<%=style %> style="text-align: left;"><%=sourcenm %></td>
		<td class=<%=style %> style="text-align: left;"><%=location %></td>
		<td class=<%=style %> style="text-align: left;"><%=srctype %></td>
		
	<td class=<%=style %> style="text-align: left;"><%=grounddt %></td>
		<td class=<%=style %> style="text-align: left;"><%=probdate %></td>
			<%-- 	 <td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp)) %></td>  --%>
				<td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp1)) %></td>	
			<td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp2)) %></td>
		
			<td class=<%=style %> style="text-align: right;"><%= ndf.format(Double.parseDouble(probexp3)) %></td>
			
		<td class=<%=style %> style="text-align: left;"><%=remarks %></td>
		</tr>
			
		
			<%
			sourcecd="-";
			sourcenm="-";
			location="-";
			srctype="-";
			grounddt="-";
			probdate="-";
			remarks="-";
			probexp="0";
			probexp1="0";
			probexp2="0";
			probexp3="0";
			
			
			tempdist=rs2.getString(1);
			
		}
	  if(stmt2!=null){
		  stmt2.close();
		  	  }
	  if(rs2!=null){
		  rs2.close();
		  	  }

}catch(Exception e){
e.printStackTrace();
}

%>

</table>	
</body>
</html>