<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.00");
	String financialstartyr="";
	
	String dname=request.getParameter("dname");
	String dcode=request.getParameter("dcode");
	
	

	 String programe=request.getParameter("programme");
    String scheme="01,02,03,10";
    session.setAttribute("programes",programe);
   
	
	
	 java.util.Date sysdate1 = new java.util.Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy");
SimpleDateFormat format1 = new SimpleDateFormat("M");
String Year=format.format(sysdate1);
String month=format1.format(sysdate1);
int startyr=0,nextFinYear=0;
startyr=Integer.parseInt(Year);
if(Integer.parseInt(month)>=04)
{
	nextFinYear=startyr+1;
}else{
	startyr=startyr-1; 
	nextFinYear=startyr+1;
}
financialstartyr=startyr+"-"+nextFinYear;


//System.out.println("financialstartyr---"+financialstartyr);
	%>
	
	<body>
	
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td ><a href="javascript:onclick=history.go(-1)">Back</a></td></tr>

		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Rs. in lakhs</b></caption>
  
	</table>
	
	
<table  cellspacing=0 cellpadding=0 width="60%"
	 style="border-collapse: collapse" 
	align="center"><tr >
			<td align="center" class="gridhdbg" colspan=33><%=financialstartyr %>- Ongoing Works & Habitations Abstract for <%=dname %> District</td>	
	
	</tr>
		<tr >
		<td  class="gridhdbg" rowspan=2>Sl.No</td>
		<td   class="gridhdbg" rowspan=2>Constituency</td>
		<td  class="gridhdbg" rowspan=2>No.of Works</td>
		<td class="gridhdbg"  rowspan=2>Habitations Sanctioned</td>
		<td  class="gridhdbg" rowspan=2>Original Est Cost</td>
		<td  class="gridhdbg" rowspan=2>Expenditure Upto (31-MAR-<%=startyr %>)</td>
		<td  class="gridhdbg" rowspan="2">Exp During <br></br>(<%=startyr %>-<%=nextFinYear %>)</td>
		<td class="gridhdbg"  rowspan="2" >Works Grounded<br></br></td>
        <td class="gridhdbg"  rowspan="2" >Works Completed <br></br></td>
        <td class="gridhdbg"  rowspan=1 colspan="7">Habitations Covered</td>


</tr>
<tr>
      
		
		<td  class="gridhdbg">FC</td> 		
		<td  class="gridhdbg">PC4</td>
		<td  class="gridhdbg">PC3</td>
		<td  class="gridhdbg">PC2</td>
		<td  class="gridhdbg">PC1+NC</td>
		<td  class="gridhdbg">QA(NSS)</td>
		<td  class="gridhdbg">Total</td>
		

</tr>
<tr>
	<%for(int i=1;i<17;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%
		
	} %>
	</tr>
<%
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt26=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs26=null;

  try{
	  
	  
	  
	 		 
  
		 
  	
	  	String mainQuery="select constituency_name,constituency_code,count(distinct a.work_id),sum(a.SANCTION_AMOUNT) from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_mandal_tbl m,rws_constituency_tbl c where  i.dcode=c.dcode and i.dcode=m.dcode and m.mcode=c.mcode and substr(LEAD_HABITATION,1,2)=c.dcode and substr(LEAD_HABITATION,6,2)=c.mcode and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		
			mainQuery+=" and i.dcode='"+dcode+"' and type_of_asset in("+scheme+") ";
		
		mainQuery+=" and a.programme_code in ("+programe+")  group by   constituency_name,constituency_code order by constituency_name";
		//System.out.println(mainQuery);
		int count=1;
		
		String sno="",remarks="",tempdist="";
		
		int styleCount=0;
		String style="";
		
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(mainQuery);
		double totsnamnt=0;
		int totsanHabs=0;
		double totlfAmount=0,totdfAmount=0;
		int totwrk_cnt=0,totgroundedWorksCnt=0,totcompletedWorksCnt=0;
		int totfc=0,totpc4=0,totpc3=0,totpc2=0,totpc1nc=0,totnss=0,tottotalcs=0;
		while(rs2.next())
		{
			String ccode="",cname="";
			String sanHabs="",covStaus="";
			double snamnt=0;
			double lfAmount=0,dfAmount=0;
			int wrk_cnt=0,groundedWorksCnt=0,completedWorksCnt=0;
			int fc=0,pc4=0,pc3=0,pc2=0,pc1nc=0,nss=0,totalcs=0;
			
			ccode=rs2.getString(2);
			 cname=rs2.getString(1);			 
			 wrk_cnt=rs2.getInt(3);
			 snamnt=rs2.getDouble(4);
			 
			 String habsSanctioned="select count(distinct b.hab_code) from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , rws_district_tbl i,rws_constituency_tbl d where i.dcode=d.dcode and c.dcode=d.dcode and c.mcode=d.mcode and a.work_id=b.work_id and b.hab_code=c.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			 
			 		habsSanctioned+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
				
					habsSanctioned+=" and type_of_asset in("+scheme+") ";
				
					habsSanctioned+=" and a.programme_code in ("+programe+")  ";
				
				

				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery(habsSanctioned);
				
				if(rs5.next()){
					sanHabs=rs5.getString(1);
				}
				stmt5.close();
				rs5.close();
			
			  String  expLastFinBank="select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode  and a.work_id=b.work_id   and txid is not null  and BANK_SEND_DATE<='31-MAR" + startyr + "' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
					
					  expLastFinBank+=" and a.work_id  not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
							
					  expLastFinBank+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
							
					  expLastFinBank+=" and type_of_asset in("+scheme+") ";
							
					  expLastFinBank+=" and b.programme_code in ("+programe+") ";
					        		
					  stmt5=conn.createStatement();
						rs5=stmt5.executeQuery(expLastFinBank);
						
						if(rs5.next()){
							lfAmount=rs5.getDouble("BILL_AMOUNT_CENTRAL");
						}
						stmt5.close();
						rs5.close();
					
			  String  expLastFinPAO="select sum(BILL_AMOUT_STATE) as BILL_AMOUNT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode and a.work_id=b.work_id   and state_txid is not null  and STATE_SEND_DATE<='31-MAR" + startyr + "' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
				
					 expLastFinPAO+=" and a.work_id  not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
									
					 expLastFinPAO+="and d.constituency_code='"+ccode+"'  and substr(a.work_id,5,2)='"+dcode+"' ";
									
					 expLastFinPAO+=" and type_of_asset in("+scheme+") ";
									
					 expLastFinPAO+=" and b.programme_code in ("+programe+") ";
			        		
			    stmt5=conn.createStatement();
				rs5=stmt5.executeQuery(expLastFinPAO);
				
				if(rs5.next()){
					lfAmount+=rs5.getDouble("BILL_AMOUNT_STATE");
				}
				stmt5.close();
				rs5.close();
     	   	 
				String  expDuringFinBank="select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode and a.work_id=b.work_id   and txid is not null  and BANK_SEND_DATE>='01-APR" + startyr + "' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			
					expDuringFinBank+=" and a.work_id  not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
							
					expDuringFinBank+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
							
					expDuringFinBank+=" and type_of_asset in("+scheme+") ";
							
					expDuringFinBank+=" and b.programme_code in ("+programe+") ";
			        		
			  		stmt5=conn.createStatement();
					rs5=stmt5.executeQuery(expDuringFinBank);
				
				if(rs5.next()){
					dfAmount=rs5.getDouble("BILL_AMOUNT_CENTRAL");
				}
				stmt5.close();
				rs5.close();
					
			 String  expDuringFinPAO="select sum(BILL_AMOUT_STATE) as BILL_AMOUNT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode and a.work_id=b.work_id   and state_txid is not null  and STATE_SEND_DATE>='01-APR" + startyr + "' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
				
					 expDuringFinPAO+=" and a.work_id  not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))";
											
					 expDuringFinPAO+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
											
					 expDuringFinPAO+=" and type_of_asset in("+scheme+") ";
									
					 expDuringFinPAO+=" and b.programme_code in ("+programe+") ";
			        		
			    stmt5=conn.createStatement();
				rs5=stmt5.executeQuery(expDuringFinPAO);
				
				if(rs5.next()){
					dfAmount+=rs5.getDouble("BILL_AMOUNT_STATE");
				}
				stmt5.close();
				rs5.close();
					
				 String groundedWorks="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMMENCEMENT_TBL b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode and work_cancel_dt is null and a.work_id=b.work_id  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			 
			 		groundedWorks+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
			 
			 		groundedWorks+=" and type_of_asset in("+scheme+") ";
					
					groundedWorks+=" and a.programme_code in ("+programe+")  ";
					
					stmt5=conn.createStatement();
					rs5=stmt5.executeQuery(groundedWorks);
					
					if(rs5.next()){
						groundedWorksCnt=rs5.getInt(1);
					}
					stmt5.close();
					rs5.close();
				String compWorks="select count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,RWS_WORK_COMPLETION_TBL b,rws_constituency_tbl d where substr(a.work_id,5,2)=d.dcode and substr(lead_habitation,1,2)=d.dcode and  substr(lead_habitation,6,2)=d.mcode and  work_cancel_dt is null and a.work_id=b.work_id  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			 
					compWorks+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
				 
					compWorks+=" and type_of_asset in("+scheme+") ";
						
					compWorks+=" and a.programme_code in ("+programe+")  ";
				
				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery(compWorks);
				
				if(rs5.next()){
					completedWorksCnt=rs5.getInt(1);
				}
				stmt5.close();
				rs5.close();
				
			String  habsCovered="select distinct substr(a.work_id,5,2),h.coverage_status,count(distinct c.hab_code) as habcnt  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h,rws_constituency_tbl d where d.dcode=h.dcode and d.mcode=h.mcode and  a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
					habsCovered+=" and d.constituency_code='"+ccode+"' and substr(a.work_id,5,2)='"+dcode+"' ";
					habsCovered+="and a.type_of_asset in("+scheme+")";
					habsCovered+=" and a.programme_code in ("+programe+")  group by  substr(a.work_id,5,2) , h.COVERAGE_STATUS ";
			
			stmt5=conn.createStatement();
			rs5=stmt5.executeQuery(habsCovered);
			
			while(rs5.next()){
				covStaus=rs5.getString("coverage_status");
				if(covStaus.equals("FC")){
					fc=rs5.getInt("habcnt");
				}
				if(covStaus.equals("PC4")){
					pc4=rs5.getInt("habcnt");
				}
				if(covStaus.equals("PC3")){
					pc3=rs5.getInt("habcnt");
				}
				if(covStaus.equals("PC2")){
					pc2=rs5.getInt("habcnt");
				}
				if(covStaus.equals("PC1") || covStaus.equals("NC")){
					pc1nc+=rs5.getInt("habcnt");
				}
				if(covStaus.equals("NSS")){
					nss=rs5.getInt("habcnt");
				}
				
			}
			totalcs=fc+pc4+pc3+pc2+pc1nc+nss;
			stmt5.close();
			rs5.close(); 
					
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			%>
			<tr><td class=<%=style %> style="text-align: center;"><%=count++ %></td>
			
			
		<%--<td class=<%=style %> style="text-align: left;"><a href="rws_ongoing_works_abs_drill_abs.jsp?drill=next&rDistrict=<%=rs2.getString(5)%>&rDistrictName=<%=dname%>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>"><%=dname %></a></td>
		 <td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_progress_rpt.jsp?&rDistrict=<%=rs2.getString(5)%>&rDistrictName=<%=dname%>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%=wrk_cnt %></a></td> --%>
		<td class=<%=style %> style="text-align: left;"><%=cname %></td>
		<td class=<%=style %> style="text-align: right;"><a href="#" onclick="viewWorks('./rws_ongoing_works_progress_drill.jsp?&dcode=<%=dcode%>&dname=<%=dname%>&ccode=<%=ccode%>&cname=<%=cname%>&programme=<%=programe%>&mode=constituency')"><%=wrk_cnt %></a></td>
	    <td class=<%=style %> style="text-align: right;"><%=sanHabs %></td>
	    <td class=<%=style %> style="text-align: right;"><%=ndf.format(snamnt) %></td>  
	    <td class=<%=style %> style="text-align: right;"><%=ndf.format(lfAmount/100000) %></td>
	    <td class=<%=style %> style="text-align: right;"><%=ndf.format(dfAmount/100000) %></td>
	    <td class=<%=style %> style="text-align: right;"><%=groundedWorksCnt %></td>
	    <td class=<%=style %> style="text-align: right;"><%=completedWorksCnt %></td>  
	    <td class=<%=style %> style="text-align: right;"><%=fc %></td>
		<td class=<%=style %> style="text-align: right;"><%=pc4 %></td>
	    <td class=<%=style %> style="text-align: right;"><%=pc3 %></td>
	    <td class=<%=style %> style="text-align: right;"><%=pc2 %></td>
	    <td class=<%=style %> style="text-align: right;"><%=pc1nc %></td>
	    <td class=<%=style %> style="text-align: right;"><%=nss %></td>
	    <td class=<%=style %> style="text-align: right;"><%=totalcs %></td>
		
			</tr>
			
			
			<%
			
			totsnamnt+=snamnt;
			totsanHabs+=Integer.parseInt(sanHabs);
			totlfAmount+=lfAmount;
			totdfAmount+=dfAmount;
			totwrk_cnt+=wrk_cnt;
			totgroundedWorksCnt+=groundedWorksCnt;
			totcompletedWorksCnt+=completedWorksCnt;
			totfc+=fc;
			totpc4+=pc4;
			totpc3+=pc3;
			totpc2+=pc2;
			totpc1nc+=pc1nc;
			totnss+=nss;
			tottotalcs+=totalcs;
		}
		
		%>
		<%if(count==1){ %>
		<tr>
		<td class="gridbg1" colspan="16" ><font color="red" size="2">No data Found</font></td>
		</tr>
		<%} %>
		<tr>
		<td class="gridhdbg" style="text-align: right;" colspan=2>Total</td>
		<td class="gridhdbg" style="text-align: right;"><%=totwrk_cnt %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totsanHabs %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totsnamnt) %></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totlfAmount/100000) %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totdfAmount/100000) %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totgroundedWorksCnt %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=totcompletedWorksCnt %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totfc %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=totpc4 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totpc3 %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=totpc2 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totpc1nc %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totnss %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=tottotalcs %></td>  
				
		
		</tr> 
		
		
		<%
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