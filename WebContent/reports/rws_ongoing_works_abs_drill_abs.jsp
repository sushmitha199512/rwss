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
    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialstartyr="";	
    double aas=0;
    double OtherFundasSC=0,OtherFundaslikelySC=0,gtotlikely=0,gexpendituretot=0,gglikelytot=0,ggexpenditure=0,scPOP=0,ggggtotEST=0,	ggggstatescEST=0,ggggtotalotherscsp=0;
    double ggunderscexp=0,ggunderotherexp=0;   
	String mode=null;
	if(request.getParameter("mode")!=null){
	mode=request.getParameter("mode");
	}
	if(session.getAttribute("financialyr")!=null){
		financialstartyr=(String)session.getAttribute("financialyr");
	} 
 //   System.out.println("financialstartyr"+financialstartyr);
    String scheme="";
    if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");    
	for(int i=0;i<schemes.length;i++)
	{
	scheme += schemes[i]+",";
	}
	////////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
    session.setAttribute("schemes",schemes);
    }
   // System.out.println("scheme"+scheme);  
	String startyr =financialstartyr.substring(0,4);
	String endyr =financialstartyr.substring(5,9);
    String endyr1 =financialstartyr.substring(5,9);
    String[] programes=request.getParameterValues("program");
    session.setAttribute("programes",programes);
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	////////System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
	session.setAttribute("programe",programe);
	////////System.out.println("programe::"+programe);
    String sysdate=workData.getDate();
    String sysmon=sysdate.substring(3,5);
    int mon=Integer.parseInt(sysmon);
    ////////System.out.println("sysdate::"+sysdate);
    String sysyear=sysdate.substring(6,10);
    int yy=Integer.parseInt(startyr);
    String nextfinancialstartyr="";
    int nextFinYear=yy+1;
    int nn=nextFinYear+1;
    nextfinancialstartyr=""+nextFinYear+"-"+nn;
////////System.out.println("startyr"+startyr);
   ////////System.out.println("sysyear::"+sysyear);
    int prevyear=0,prevmon=0;String fyear,fyear1;
    prevyear=yy-1;
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
////////System.out.println("Startyr:"+startyr);
////////System.out.println("StartyRr2:"+startyr2 );
////////System.out.println("Endyr:"+endyr );
////////System.out.println("Endyr2:"+endyr1);
////////System.out.println("Get Cuurent MOnth:"+d.getMonth());
	String dcode=request.getParameter("district");
	String dname=request.getParameter("DistrictName");
	String divcode=request.getParameter("divcode");
	String divname=request.getParameter("divname");
    if(dcode!=null && !dcode.equals("")){
	  session.setAttribute("dcode",dcode);
	  session.setAttribute("divcode",divcode);
    }
////////System.out.println("dcode"+dcode);
////////System.out.println("DivCode"+divCode);
//////System.out.println("satrt year"+startyr);
//////System.out.println("end year"+endyr);
    String targetyr=financialstartyr;
	%>	
	<body>	 
      <table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	 <caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td ><a href="javascript:history.go(-1)">Back|</a><!-- <a href="./rws_ongoing_works_abs_xls.jsp">Excel</a> --></td></tr>
<%  } else {%>
	<tr><td align="right" ><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>  
	</table>	
<table  cellspacing=0 cellpadding=0 width="60%" style="border-collapse: collapse" align="center">
	 <tr >
			<td align="center" class="gridhdbg" colspan=33><%=financialstartyr %>- Ongoing Works & Habitations Abstract for District:<%=dname %><%if(mode.equals("subdiv")){ %>
		,Division : <%=divname%>
		<%}%></td>	
	</tr>
	<tr >
		<td  class="gridhdbg" rowspan=2>Sl.No</td>
		<%if(mode.equals("divisions")){ %>
		<td class=gridhdbg rowspan=2>Division</td>
		<%}else if(mode.equals("subdiv")){ %>
		<td class=gridhdbg rowspan=2>Sub Division</td>
		<%}%>	
		<td  class="gridhdbg" rowspan=2>No.of Works</td>
		<td  class="gridhdbg" rowspan=2>Est. Cost/Bal Est cost as on 1.4.<%=startyr %></td> 
		<td class="gridhdbg"  rowspan=2>Habitations Sanctioned Total</td>
		<td class="gridhdbg"  rowspan=1 colspan="7">Habitations Sanctioned </td>
 		<td class="gridhdbg"  rowspan=1 colspan="2">Exp for Phy Comp but financially not completed works</td>
 		<td  class="gridhdbg" rowspan="1" colspan="3">Exp During <br>(For Ongoing Works)</br>(<%=startyr %>-<%=nextFinYear %>)</td>
        <td class="gridhdbg"  rowspan="2" >No.of Works Completed <br></br></td>
        <td class="gridhdbg"  rowspan=2>Habitations Covered Total</td>
        <td class="gridhdbg"  rowspan=1 colspan="7">Habitations Covered</td>
    </tr>
	<tr>
        <td  class="gridhdbg">FC</td>
 		<td  class="gridhdbg">PC1</td>
		<td  class="gridhdbg">PC2</td>
		<td  class="gridhdbg">PC3</td>
		<td  class="gridhdbg">PC4</td>
		<td  class="gridhdbg">NC</td>
		<td  class="gridhdbg">NSS</td>
		<td  class="gridhdbg">No.</td>
		<td  class="gridhdbg">Exp</td>
		<td  class="gridhdbg">Through Bank</td>
		<td  class="gridhdbg">Through PAO</td>
		<td  class="gridhdbg">Total Exp</td>		
		<td  class="gridhdbg">FC</td> 		
		<td  class="gridhdbg">PC1</td>
		<td  class="gridhdbg">PC2</td>
		<td  class="gridhdbg">PC3</td>
		<td  class="gridhdbg">PC4</td>
		<td  class="gridhdbg">NC</td>
		<td  class="gridhdbg">NSS</td>
	</tr>
	<tr>
	<%for(int i=1;i<27;i++){
		%>
		<td class="gridhdbg"><%=i %></td>
		<%} %>
	</tr>
	<%
	Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt26=null;
	ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs26=null;
	int count=1;
    String sno="",snamnt="",remarks="",tempdist="";
    int wrk_cnt=0;
  try{	    
	 /*  String c_query="";
	  if(mode.equals("divisions")){
      	c_query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+dcode+"' and status <> 'UI' order by division_office_code";
      }
     /*  else if(mode.equals("subdivisions")){
      	 c_query="select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where  circle_office_code='"+ccode+"' and division_office_code='"+divCode+"' order by subdivision_office_code";
      }         PreparedStatement preparedStatement = conn.prepareStatement(c_query);
          ResultSet res = preparedStatement.executeQuery();
          while(res.next()){ */
        	  String habStatusCnt="";
      if(mode!=null &&mode.equals("divisions")) {
		  habStatusCnt="select distinct substr(a.office_code,4,1),h.coverage_status,count(distinct b.hab_code)  from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view h, rws_district_tbl i,rws_division_office_tbl d where  a.work_id=b.work_id  and b.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		  if(dcode!=null && !dcode.equals("00")){
			  habStatusCnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		  }if(scheme!=null && !scheme.equals("")){
			  habStatusCnt+="and a.type_of_asset in("+scheme+")";
		  }			 
		  habStatusCnt+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,4,1) , h.COVERAGE_STATUS ";
      }else if(mode!=null &&mode.equals("subdiv")){
    	  habStatusCnt="select distinct substr(a.office_code,5,2),h.coverage_status,count(distinct b.hab_code)  from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view h, rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s where  a.work_id=b.work_id  and b.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		  if(dcode!=null && !dcode.equals("00")){
			  habStatusCnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		  }
		  if(divcode!=null && !divcode.equals("")){
			  habStatusCnt+=" and substr(a.office_code,4,1)='"+divcode+"' ";
			}
		  if(scheme!=null && !scheme.equals("")){
			  habStatusCnt+="and a.type_of_asset in("+scheme+")";
		  }			 
		  habStatusCnt+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,5,2) , h.COVERAGE_STATUS ";
      }
	//  System.out.println("habStatusCnt:"+habStatusCnt);
	  stmt4=conn.createStatement();
	  rs3=stmt4.executeQuery(habStatusCnt);
	  Hashtable habStatus_Cnt=new Hashtable();
	  	while(rs3.next())
	  	{
	  		habStatus_Cnt.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	  		////////System.out.println(rs3.getString(1)+"+"+rs3.getString(2)+"="+rs3.getString(3));
	  	}
	  	if(rs3!=null)rs3.close();
	  	if(stmt4!=null)stmt4.close();
	  	String habCovStatusCnt="";
	  	if(mode!=null &&mode.equals("divisions")) {
	  		 habCovStatusCnt="select distinct substr(a.office_code,4,1),h.coverage_status,count(distinct c.hab_code)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i,rws_division_office_tbl d where  a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		  	 if(dcode!=null && !dcode.equals("00")){
		  		habCovStatusCnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			 }if(scheme!=null && !scheme.equals("")){
				 habCovStatusCnt+="and a.type_of_asset in("+scheme+")";
			 }
			 habCovStatusCnt+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,4,1) , h.COVERAGE_STATUS ";
	      }else if(mode!=null &&mode.equals("subdiv")){
	    	  habCovStatusCnt="select distinct substr(a.office_code,5,2),h.coverage_status,count(distinct c.hab_code)  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b ,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view h, rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s where  a.work_id=b.work_id and a.work_id=b.work_id and b.work_id=c.work_id  and c.hab_code=h.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	 	  	 if(dcode!=null && !dcode.equals("00")){
	 	  		habCovStatusCnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	 		 }
	 	  	if(divcode!=null && !divcode.equals("")){
	 	  		habCovStatusCnt+=" and substr(a.office_code,4,1)='"+divcode+"' ";
			}
	 	  	 if(scheme!=null && !scheme.equals("")){
	 			 habCovStatusCnt+="and a.type_of_asset in("+scheme+")";
	 		 }
	 		 habCovStatusCnt+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,5,2) , h.COVERAGE_STATUS ";
	      }		
		  //System.out.println("habCovStatusCnt:"+habCovStatusCnt);
		  stmt4=conn.createStatement();
		  rs3=stmt4.executeQuery(habCovStatusCnt);
		  Hashtable habCovStatus_Cnt=new Hashtable();
		  	while(rs3.next())
		  	{
		  		habCovStatus_Cnt.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
		  	}
		  	if(rs3!=null)rs3.close();
		  	if(stmt4!=null)stmt4.close();
		  	String compHabs="";
		  	if(mode!=null &&mode.equals("divisions")) {
		  		compHabs="select substr(a.office_code,4,1),count(distinct c.hab_code) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view d, rws_district_tbl i,rws_division_office_tbl e where  a.work_id=b.work_id and b.work_id=c.work_id and  c.hab_code=d.panch_code and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=e.circle_office_code and substr(a.office_code,4,1)=e.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		  	  if(dcode!=null && !dcode.equals("00")){
		  		  compHabs+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		  	  }if(scheme!=null && !scheme.equals("")){
		  		  compHabs+="and a.type_of_asset in("+scheme+")";
		  	  }
		  	  compHabs+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,4,1) ";
	       }else if(mode!=null &&mode.equals("subdiv")){
	    	   compHabs="select substr(a.office_code,5,2),count(distinct c.hab_code) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b,rws_work_comp_hab_lnk_tbl c ,rws_complete_hab_view d, rws_district_tbl i,rws_division_office_tbl e,rws_subdivision_office_tbl s where  a.work_id=b.work_id and b.work_id=c.work_id and  c.hab_code=d.panch_code and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=e.circle_office_code and substr(a.office_code,4,1)=e.division_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and e.circle_office_code=s.circle_office_code and e.division_office_code=s.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
    		  if(dcode!=null && !dcode.equals("00")){
    			  compHabs+=" and substr(a.work_id,5,2)='"+dcode+"' ";
    		  }
    		  if(divcode!=null && !divcode.equals("")){
    			  compHabs+=" and substr(a.office_code,4,1)='"+divcode+"' ";
    			}
    		  if(scheme!=null && !scheme.equals("")){
    			  compHabs+="and a.type_of_asset in("+scheme+")";
    		  }
    		  compHabs+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,5,2) ";
	       }
	  //System.out.println("comphabs:"+compHabs);
	  stmt4=conn.createStatement();
	  rs3=stmt4.executeQuery(compHabs);
	  Hashtable comp_Habs=new Hashtable();
	  	while(rs3.next())
	  	{
	  		comp_Habs.put(rs3.getString(1),rs3.getString(2));
	  	}
	  	if(rs3!=null)rs3.close();
	  	if(stmt4!=null)stmt4.close();
	  	String habsSanctioned="";
	  	if(mode!=null &&mode.equals("divisions")) {
	  		habsSanctioned="select substr(a.office_code,4,1),count(distinct b.hab_code) from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , rws_district_tbl i,rws_division_office_tbl d where a.work_id=b.work_id and b.hab_code=c.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code  and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	 		if(dcode!=null && !dcode.equals("00")){
	 			habsSanctioned+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	 		}
	 		if(scheme!=null && !scheme.equals(""))
	 		{
	 			habsSanctioned+=" and type_of_asset in("+scheme+") ";
	 		}
	 		habsSanctioned+=" and a.programme_code in ("+programe+")  group by substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	    habsSanctioned="select substr(a.office_code,5,2),count(distinct b.hab_code) from RWS_WORK_ADMN_TBL a,rws_admn_hab_lnk_tbl b ,rws_complete_hab_view c , rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s where a.work_id=b.work_id and b.hab_code=c.panch_code and  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code  and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			habsSanctioned+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			habsSanctioned+=" and substr(a.office_code,4,1)='"+divcode+"' ";
			}
	   		if(scheme!=null && !scheme.equals(""))
	   		{
	   			habsSanctioned+=" and type_of_asset in("+scheme+") ";
	   		}
	   		habsSanctioned+=" and a.programme_code in ("+programe+")  group by substr(a.office_code,5,2) ";
       } 		
		//System.out.println("habsSanctioned "+habsSanctioned);
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(habsSanctioned);
		Hashtable habsSan_cnt = new Hashtable();
		while(rs5.next()){
			habsSan_cnt.put(rs5.getString(1),rs5.getString(2));
		}		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		}	  
	  ////////////////Added by anu on 27072015 ////////////////////
	  String estcost="";
		if(mode!=null &&mode.equals("divisions")) {
			estcost="select substr(a.office_code,4,1),sum(case when to_date(bank_send_date)<'01-APR-"+startyr+"' then BILL_AMOUNT_CENTRAL else 0 end),sum(CASE WHEN to_date(bank_send_date)>='01-APR-"+startyr+"' AND to_date(bank_send_date)<='31-MAR-"+nextFinYear+"' THEN BILL_AMOUNT_CENTRAL ELSE 0 end) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i where a.work_id=b.work_id   and txid is not null and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(dcode!=null && !dcode.equals("00")){
				estcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				estcost+=" and type_of_asset in("+scheme+") ";
			}
			estcost+=" and b.programme_code in ("+programe+") group by substr(a.office_code,4,1) order by  substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	   estcost="select substr(b.office_code,5,2),sum(case when to_date(bank_send_date)<'01-APR-"+startyr+"' then BILL_AMOUNT_CENTRAL else 0 end),sum(CASE WHEN to_date(bank_send_date)>='01-APR-"+startyr+"' AND to_date(bank_send_date)<='31-MAR-"+nextFinYear+"' THEN BILL_AMOUNT_CENTRAL ELSE 0 end) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i,rws_subdivision_office_tbl s where a.work_id=b.work_id   and txid is not null and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(b.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			estcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			estcost+=" and substr(b.office_code,4,1)='"+divcode+"' ";
			}
	   		if(scheme!=null && !scheme.equals(""))
	   		{
	   			estcost+=" and type_of_asset in("+scheme+") ";
	   		}
	   		estcost+=" and b.programme_code in ("+programe+") group by substr(b.office_code,5,2) order by  substr(b.office_code,5,2) ";
       } 
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(estcost);
		//System.out.println("estcost "+estcost);
		Hashtable estcost_det = new Hashtable();
		while(rs5.next()){
			estcost_det.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
		}		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		}		
		/* String phyFinWorkBank="select substr(a.office_code,2,2),count(distinct a.work_id) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id   and txid is not null  and BANK_SEND_DATE>='01-APR" + startyr + "'";
		phyFinWorkBank+=" and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
		if(dcode!=null && !dcode.equals("00")){
			phyFinWorkBank+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			phyFinWorkBank+=" and type_of_asset in("+scheme+") ";
		}
		phyFinWorkBank+=" and b.programme_code in ("+programe+") group by substr(a.office_code,2,2) order by  substr(a.office_code,2,2) ";
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(phyFinWorkBank);
		System.out.println("phyFinWorkBank "+phyFinWorkBank);
		Hashtable Phy_fin_works = new Hashtable();

		while(rs5.next()){
			Phy_fin_works.put(rs5.getString(1),rs5.getString(2));
		}
		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		}	
		String phyFinWorkPAO="select substr(a.office_code,2,2),count(distinct a.work_id) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id   and state_txid is not null  and STATE_SEND_DATE>='01-APR" + startyr + "'";
		phyFinWorkPAO+=" and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
		if(dcode!=null && !dcode.equals("00")){
			phyFinWorkPAO+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			phyFinWorkPAO+=" and type_of_asset in("+scheme+") ";
		}
		phyFinWorkPAO+=" and b.programme_code in ("+programe+") group by substr(a.office_code,2,2) order by  substr(a.office_code,2,2) ";
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(phyFinWorkPAO);
		System.out.println("phyFinWorkPAO "+phyFinWorkPAO);
		Hashtable Phy_fin_works_pao = new Hashtable();

		while(rs5.next()){
			Phy_fin_works_pao.put(rs5.getString(1),rs5.getString(2));
		}
		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		} */
		String expPhyFinBank="";
		if(mode!=null &&mode.equals("divisions")) {
			expPhyFinBank="select substr(a.office_code,4,1),sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL,COUNT(DISTINCT A.WORK_ID) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i where"
				     +" a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and txid is not null  and BANK_SEND_DATE>='01-APR" + startyr + "' and substr(a.office_code,4,1)=d.division_office_code"
		             +" and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
			if(dcode!=null && !dcode.equals("00")){
				expPhyFinBank+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				expPhyFinBank+=" and type_of_asset in("+scheme+") ";
			}
			expPhyFinBank+=" and b.programme_code in ("+programe+") group by substr(a.office_code,4,1) order by  substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	   expPhyFinBank="select substr(b.office_code,5,2),sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL,COUNT(DISTINCT A.WORK_ID) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i,rws_subdivision_office_tbl s where"
				     +" a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and txid is not null  and BANK_SEND_DATE>='01-APR" + startyr + "' and substr(b.office_code,4,1)=d.division_office_code"
		             +" and i.dcode=s.circle_office_code and substr(b.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
			if(dcode!=null && !dcode.equals("00")){
				expPhyFinBank+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(divcode!=null && !divcode.equals("")){
				expPhyFinBank+=" and substr(b.office_code,4,1)='"+divcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				expPhyFinBank+=" and type_of_asset in("+scheme+") ";
			}
			expPhyFinBank+=" and b.programme_code in ("+programe+") group by substr(b.office_code,5,2) order by  substr(b.office_code,5,2) ";
       } 
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(expPhyFinBank);
	//	System.out.println("expPhyFinBank "+expPhyFinBank);
		Hashtable exp_Phy_fin = new Hashtable();
		while(rs5.next()){
			exp_Phy_fin.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
		}		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		}
		String expPhyFinPao="";
		if(mode!=null &&mode.equals("divisions")) {
			expPhyFinPao="select substr(a.office_code,4,1),sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE,COUNT(DISTINCT A.WORK_ID) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i "
					    +" where a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and state_txid is not null  and STATE_SEND_DATE>='01-APR" + startyr + "' and substr(a.office_code,4,1)=d.division_office_code"
						+" and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
			if(dcode!=null && !dcode.equals("00")){
				expPhyFinPao+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				expPhyFinPao+=" and type_of_asset in("+scheme+") ";
			}
			expPhyFinPao+=" and b.programme_code in ("+programe+") group by substr(a.office_code,4,1) order by  substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	    expPhyFinPao="select substr(b.office_code,5,2),sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE,COUNT(DISTINCT A.WORK_ID) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i,rws_subdivision_office_tbl s"
    	    		    +" where a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and state_txid is not null  and STATE_SEND_DATE>='01-APR" + startyr + "' and substr(b.office_code,4,1)=d.division_office_code"
	   					+" and i.dcode=s.circle_office_code and substr(b.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION <= '31-MAR-" + startyr + "')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			expPhyFinPao+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			expPhyFinPao+=" and substr(b.office_code,4,1)='"+divcode+"' ";
			}
	   		if(scheme!=null && !scheme.equals(""))
	   		{
	   			expPhyFinPao+=" and type_of_asset in("+scheme+") ";
	   		}
	   		expPhyFinPao+=" and b.programme_code in ("+programe+") group by substr(b.office_code,5,2) order by  substr(b.office_code,5,2) ";
       } 
		stmt5=conn.createStatement();
		rs5=stmt5.executeQuery(expPhyFinPao);
	//	System.out.println("expPhyFinPao "+expPhyFinPao);
		Hashtable exp_Phy_fin_pao = new Hashtable();
		while(rs5.next()){
			exp_Phy_fin_pao.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
		}		
		if(stmt5!=null){
			stmt5.close();
		}
		if(rs5!=null){
			rs5.close();
		}
		String direstcost="";
		if(mode!=null &&mode.equals("divisions")) {
			direstcost="select substr(a.office_code,4,1),sum(case when to_date(state_send_date)<'01-APR-"+startyr+"'  then BILL_AMOUT_STATE else 0 end),sum(case when to_date(state_send_date)>='01-APR-"+startyr+"' and to_date(state_send_date)<='31-MAR-"+nextFinYear+"'  then BILL_AMOUT_STATE else 0 end)  from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i where a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and state_txid is not null and substr(a.office_code,4,1)=d.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(dcode!=null && !dcode.equals("00")){
				direstcost+=" and substr(a.office_code,2,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				direstcost+=" and type_of_asset in("+scheme+") ";
			}
			direstcost+=" and b.programme_code in ("+programe+") group by substr(a.office_code,4,1)";
       }else if(mode!=null &&mode.equals("subdiv")){
    	   direstcost="select substr(b.office_code,5,2),sum(case when to_date(state_send_date)<'01-APR-"+startyr+"'  then BILL_AMOUT_STATE else 0 end),sum(case when to_date(state_send_date)>='01-APR-"+startyr+"' and to_date(state_send_date)<='31-MAR-"+nextFinYear+"'  then BILL_AMOUT_STATE else 0 end)  from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b,rws_division_office_tbl d,rws_district_tbl i,rws_subdivision_office_tbl s where a.work_id=b.work_id  and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and state_txid is not null and substr(b.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(b.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			direstcost+=" and substr(a.office_code,2,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			direstcost+=" and substr(b.office_code,4,1)='"+divcode+"' ";
			}
	   		if(scheme!=null && !scheme.equals(""))
	   		{
	   			direstcost+=" and type_of_asset in("+scheme+") ";
	   		}
	   		direstcost+=" and b.programme_code in ("+programe+") group by substr(b.office_code,5,2)";
       } 	
		//System.out.println("direstcost "+direstcost);
		stmt26=conn.createStatement();
		rs26=stmt26.executeQuery(direstcost);
	//	System.out.println("direstcost "+direstcost);
		Hashtable direstcost_det = new Hashtable();
		while(rs26.next()){
			direstcost_det.put(rs26.getString(1),rs26.getString(2)+"@"+rs26.getString(3));
		}		
		if(stmt26!=null){
			stmt26.close();
		}
		if(rs26!=null){
			rs26.close();
		}		
	///////////////////////////////////
	 // String estcost="select substr(a.work_id,5,2),nvl(sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000,'0'),nvl((sum(case when (to_date(voucher_dt)>= '01-APR-"+startyr+"') and (to_date(voucher_dt)< '01-APR-"+nextFinYear+"') then voucher_Amt else 0 end)/100000),'0') from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id";
	//	if(dcode!=null && !dcode.equals("00")){
		//	estcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		//}
		//if(scheme!=null && !scheme.equals(""))
		//{
	//		estcost+=" and type_of_asset in("+scheme+") ";
	//	}
		//estcost+=" and a.programme_code in ("+programe+") group by substr(a.work_id,5,2) order by  substr(a.work_id,5,2) ";
		//System.out.println("estcost "+estcost);

		//stmt5=conn.createStatement();
		//rs5=stmt5.executeQuery(estcost);
		//Hashtable estcost_det = new Hashtable();

		//while(rs5.next()){
		//	estcost_det.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
		//}
		
		//if(stmt5!=null){
		//	stmt5.close();
		//}
		//if(rs5!=null){
		//	rs5.close();
		//}
		
		///expend in dir
		//String direstcost="select substr(a.work_id,5,2),nvl((sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000),0),nvl((sum(case when (to_date(voucher_dt)>= '01-APR-"+startyr+"') and (to_date(voucher_dt)< '01-APR-"+nextFinYear+"') then voucher_Amt else 0 end)/100000),0) from  RWS_WORK_ADMN_TBL a,RWS_WORK_DIRECT_VOUCHER_TBL b where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id";
		//if(dcode!=null && !dcode.equals("00")){
		//	direstcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		//}
	//	if(scheme!=null && !scheme.equals(""))
	//	{
		//	direstcost+=" and type_of_asset in("+scheme+") ";
	///	}
	//	direstcost+=" and a.programme_code in ("+programe+") group by substr(a.work_id,5,2)";
	
		//System.out.println("direstcost "+estcost);

		//stmt5=conn.createStatement();
		//rs5=stmt5.executeQuery(direstcost);
		//Hashtable direstcost_det = new Hashtable();

		//while(rs5.next()){
		//	direstcost_det.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
	//	}
		
	//	if(stmt5!=null){
		//	stmt5.close();
	//	}
		//if(rs5!=null){
		//	rs5.close();
		//}
		String MPsanctionamnt="";
		if(mode!=null &&mode.equals("divisions")) {
			MPsanctionamnt="select substr(a.office_code,4,1),sum(b.sanction_amount)  from  RWS_WORK_ADMN_TBL a,RWS_WORK_ADMN_PROG_LNK_TBL b,rws_division_office_tbl d,rws_district_tbl i where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and substr(a.office_code,4,1)=d.division_office_code and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(dcode!=null && !dcode.equals("00")){
				MPsanctionamnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
			if(scheme!=null && !scheme.equals(""))
			{
				MPsanctionamnt+=" and type_of_asset in("+scheme+") ";
			}
			MPsanctionamnt+=" and a.programme_code in ("+programe+") group by substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	    MPsanctionamnt="select substr(a.office_code,5,2),sum(b.sanction_amount)  from  RWS_WORK_ADMN_TBL a,RWS_WORK_ADMN_PROG_LNK_TBL b,rws_division_office_tbl d,rws_district_tbl i,rws_subdivision_office_tbl s where work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and a.work_id=b.work_id and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and substr(a.office_code,4,1)=d.division_office_code and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			MPsanctionamnt+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			MPsanctionamnt+=" and substr(a.office_code,4,1)='"+divcode+"' ";
			}
	   		if(scheme!=null && !scheme.equals(""))
	   		{
	   			MPsanctionamnt+=" and type_of_asset in("+scheme+") ";
	   		}
	   		MPsanctionamnt+=" and a.programme_code in ("+programe+") group by substr(a.office_code,5,2) ";
       } 		
		//System.out.println("MPsanctionamnt "+MPsanctionamnt);
		stmt4=conn.createStatement();
		rs4=stmt4.executeQuery(MPsanctionamnt);
		Hashtable estcost1_det = new Hashtable();

		while(rs4.next()){
			estcost1_det.put(rs4.getString(1),rs4.getString(2));
		}
		
		if(stmt4!=null){
			stmt4.close();
		}
		if(rs4!=null){
			rs4.close();
		}
		String compWorks="";
		if(mode!=null &&mode.equals("divisions")) {
			compWorks="select substr(a.office_code,4,1),count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b, rws_district_tbl i,rws_division_office_tbl d where  a.work_id=b.work_id and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
			if(dcode!=null && !dcode.equals("00")){
				compWorks+=" and substr(a.work_id,5,2)='"+dcode+"' ";
			}
		    if(scheme!=null && !scheme.equals("")){
			  compWorks+="and a.type_of_asset in("+scheme+")";
		    }
		    compWorks+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,4,1) ";
       }else if(mode!=null &&mode.equals("subdiv")){
    	   compWorks="select substr(a.office_code,5,2),count(distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b, rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s  where  a.work_id=b.work_id and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	   		if(dcode!=null && !dcode.equals("00")){
	   			compWorks+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	   		}
	   		if(divcode!=null && !divcode.equals("")){
	   			compWorks+=" and substr(a.office_code,4,1)='"+divcode+"' ";
			}
		   	if(scheme!=null && !scheme.equals("")){
		   		compWorks+="and a.type_of_asset in("+scheme+")";
		   	}
		   	compWorks+=" and a.programme_code in ("+programe+")  group by  substr(a.office_code,5,2) ";
       } 	  
	//  System.out.println("compWorks:"+compWorks);
	  stmt4=conn.createStatement();
	  rs3=stmt4.executeQuery(compWorks);
	  Hashtable compWrks=new Hashtable();
	  	while(rs3.next())
	  	{
	  		compWrks.put(rs3.getString(1),rs3.getString(2));
	  	}
	  	if(rs3!=null)rs3.close();
	  	if(stmt4!=null)stmt4.close();
		 
  
	  	session.setAttribute("exp_Phy_fin",exp_Phy_fin);
	  	session.setAttribute("exp_Phy_fin_pao",exp_Phy_fin_pao);
	  	session.setAttribute("estcost_det",estcost_det);
        session.setAttribute("compWrks", compWrks);
        session.setAttribute("estcost_det",estcost_det);
	    session.setAttribute("direstcost_det",direstcost_det);
        session.setAttribute("estcost1_det",estcost1_det);
        session.setAttribute("habsSan_cnt", habsSan_cnt);
        session.setAttribute("habStatus_Cnt", habStatus_Cnt);
        session.setAttribute("habCovStatus_Cnt", habCovStatus_Cnt);
        session.setAttribute("comp_Habs", comp_Habs);
        String habqry="";
 	if(mode!=null &&mode.equals("divisions")) {
 		habqry="select d.division_office_name,substr(a.office_code,4,1),count(distinct a.work_id),sum(a.SANCTION_AMOUNT),d.division_office_code from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d where  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(dcode!=null && !dcode.equals("00")){
			habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			habqry+=" and type_of_asset in("+scheme+") ";
		}
		habqry+="  and a.programme_code in ("+programe+")  group by  d.division_office_name,substr(a.office_code,4,1),d.division_office_code order by d.division_office_name";
	}else if(mode!=null &&mode.equals("subdiv")){
		habqry="select s.subdivision_office_name,substr(a.office_code,5,2),count(distinct a.work_id),sum(a.SANCTION_AMOUNT),s.subdivision_office_code from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s"
				+" where  work_cancel_dt is null and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode and "
				+" i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
		if(divcode!=null && !divcode.equals("")){
			habqry+=" and substr(a.office_code,4,1)='"+divcode+"' ";
		}
		if(dcode!=null && !dcode.equals("00")){
			habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
		}
		if(scheme!=null && !scheme.equals(""))
		{
			habqry+=" and type_of_asset in("+scheme+") ";
		}
		habqry+="  and a.programme_code in ("+programe+")  group by  s.subdivision_office_name,substr(a.office_code,5,2),s.subdivision_office_code order by s.subdivision_office_name";
	}
	  		//System.out.println("habqry anu"+habqry);
		int styleCount=0;
		int tot1=0,tot2=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0,tot11=0,tot12=0,tot13=0,tot14=0,tot16=0,tot17=0,tot18=0,tot19=0,tot20=0,totphyfinWorks=0;
		double tot3=0,tot15=0,totexpbank=0,totexppao=0,totexpPhyFin=0;	
		String style="";
		stmt2=conn.createStatement();
		rs2=stmt2.executeQuery(habqry);
		String subdivname="";
		while(rs2.next())
		{
			int sfc_cnt=0,spc_cnt=0,spc1_cnt=0,spc2_cnt=0,spc3_cnt=0,spc4_cnt=0,snss_cnt=0,snc_cnt=0;
			int cfc_cnt=0,cpc_cnt=0,cpc1_cnt=0,cpc2_cnt=0,cpc3_cnt=0,cpc4_cnt=0,cnss_cnt=0,cnc_cnt=0;
			//////System.out.println("fc sanchabs"+Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"FC")));
			double voamnt=0.0,voamnt1=0.0,expDuring=0,expbank=0,exppao=0,expPhyFin=0;
			int habs_cnt=0,comphabs_cnt=0,comp_wrkcnt=0,phyfinWorks=0;	
			if(mode!=null &&mode.equals("divisions")) {
			divname=rs2.getString(1);	
			}else if(mode!=null &&mode.equals("subdiv")){
				subdivname=rs2.getString(1);
			}
			 wrk_cnt=rs2.getInt(3);			        		
        		 if(estcost_det.get(rs2.getString(2))!=null)
        		 {
        			 String val=(String)estcost_det.get(rs2.getString(2));
        			 String vals[]=val.split("@");
        			 voamnt=(Double.parseDouble(vals[0])/100000);
        			 expDuring=(Double.parseDouble(vals[1])/100000);
        			 expbank= (Double.parseDouble(vals[1])/100000);         			 
        		 }
        		 if(exp_Phy_fin.get(rs2.getString(2))!=null)
        		 {
        			 String val=(String)exp_Phy_fin.get(rs2.getString(2));
        			 String vals[]=val.split("@");
        			 expPhyFin=(Double.parseDouble(vals[0])/100000);
        			 phyfinWorks=(Integer.parseInt(vals[1]));        			 
        		 }
        		 if(exp_Phy_fin_pao.get(rs2.getString(2))!=null)
        		 {
        			 String val=(String)exp_Phy_fin_pao.get(rs2.getString(2));
        			 String vals[]=val.split("@");
        			 expPhyFin=expPhyFin+(Double.parseDouble(vals[0])/100000);
        			 phyfinWorks=phyfinWorks+(Integer.parseInt(vals[1]));
        		 }
        		 if(direstcost_det.get(rs2.getString(2))!=null)
        		 {        			 
        			 String val=(String)direstcost_det.get(rs2.getString(2));
        			 String vals[]=val.split("@");
        			 voamnt+=(Double.parseDouble(vals[0])/100000);
        			 expDuring+=(Double.parseDouble(vals[1])/100000);
        			 exppao=(Double.parseDouble(vals[1])/100000);        			
	        	 }
        		// System.out.println("voamnt anupama"+voamnt);
        		 if(estcost1_det.get(rs2.getString(2))!=null)
        		 {
        			 voamnt1=Double.parseDouble((String)estcost1_det.get(rs2.getString(2))); 
        			 //System.out.println("voamnt123aa"+voamnt1);              			 
	        	 }        			 
        		 double totsanction=(rs2.getDouble(4)+voamnt1);
        		 if(totsanction>voamnt)
        		 {
        			// System.out.println("inetotsanction");
        		 snamnt=ndf.format((rs2.getDouble(4)+voamnt1)-voamnt); 
        		// System.out.println("sanctionamount insssssss"+snamnt);
        		 }
        		 else
        		 {
        			 //System.out.println("inelsetotsanction");        			 
        			 snamnt=ndf.format(voamnt-(rs2.getDouble(4)+voamnt1)); 
        			 //System.out.println("sanctionamount"+snamnt);
        		 } 		 
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			%>
		<tr>
		<td class=<%=style %> style="text-align: center;"><%=count++ %></td>	
		<%if(mode!=null &&mode.equals("divisions")) {%>		
		<td class=<%=style %> style="text-align: left;"><a href="rws_ongoing_works_abs_drill_abs.jsp?drill=next&mode=subdiv&district=<%=dcode%>&DistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&program=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>"><%=divname %></a></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: left;"><%=subdivname %></td>
		<%} %>
		<%if(mode!=null &&mode.equals("divisions")) {%>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill4.jsp?mode=div&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%=wrk_cnt %></a></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill4.jsp?mode=subdiv&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=divcode %>&divname=<%=divname %>&subdivcode=<%=rs2.getString(5) %>&subdivname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%=wrk_cnt %></a></td>
		<%} %>
	    <td class=<%=style %> style="text-align: right;"><%=snamnt %></td> 
	    <%if(mode!=null &&mode.equals("divisions")) {%>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill5.jsp?mode=div&rDistrict=<%=dcode %>&rDistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%= habsSan_cnt.get(rs2.getString(2))==null?"0":(habs_cnt=(Integer.parseInt((String)habsSan_cnt.get(rs2.getString(2))))) %></a></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill5.jsp?mode=subdiv&rDistrict=<%=dcode %>&rDistrictName=<%=dname%>&divcode=<%=divcode %>&divname=<%=divname %>&subdivcode=<%=rs2.getString(5) %>&subdivname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%= habsSan_cnt.get(rs2.getString(2))==null?"0":(habs_cnt=(Integer.parseInt((String)habsSan_cnt.get(rs2.getString(2))))) %></a></td>
		<%} %>	
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"FC")==null?"0":(sfc_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"FC")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"PC1")==null?"0":(spc1_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"PC1")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"PC2")==null?"0":(spc2_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"PC2")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"PC3")==null?"0":(spc3_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"PC3")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"PC4")==null?"0":(spc4_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"PC4")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"NC")==null?"0":(snc_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"NC")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habStatus_Cnt.get(rs2.getString(2)+"NSS")==null?"0":(snss_cnt=(Integer.parseInt((String)habStatus_Cnt.get(rs2.getString(2)+"NSS")))) %></td>
		 <%if(mode!=null &&mode.equals("divisions")) {%>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill6.jsp?mode=div&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%=phyfinWorks %></a></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill6.jsp?mode=subdiv&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=divcode %>&divname=<%=divname %>&subdivcode=<%=rs2.getString(5) %>&subdivname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%=phyfinWorks %></a></td>
		<%} %>
		<td class=<%=style %> style="text-align: right;"><%=ndf.format(expPhyFin)%></td>
		<td class=<%=style %> style="text-align: right;"><%=ndf.format(expbank)%></td>
		<td class=<%=style %> style="text-align: right;"><%=ndf.format(exppao)%></td>
		<td class=<%=style %> style="text-align: right;"><%= ndf.format(expDuring) %></td>
		<%if(mode!=null &&mode.equals("divisions")) {%>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill2.jsp?mode=div&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%= compWrks.get(rs2.getString(2))==null?"0":(comp_wrkcnt=(Integer.parseInt((String)compWrks.get(rs2.getString(2))))) %></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill2.jsp?mode=subdiv&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=divcode %>&divname=<%=divname %>&subdivcode=<%=rs2.getString(5) %>&subdivname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>&prevyear=<%=prevyear%>"><%= compWrks.get(rs2.getString(2))==null?"0":(comp_wrkcnt=(Integer.parseInt((String)compWrks.get(rs2.getString(2))))) %></td>
		<%} %>
		<%if(mode!=null &&mode.equals("divisions")) {%>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill3.jsp?mode=div&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=rs2.getString(5) %>&divname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>"><%= comp_Habs.get(rs2.getString(2))==null?"0":(comphabs_cnt=(Integer.parseInt((String)comp_Habs.get(rs2.getString(2))))) %></td>
		<%}else if(mode!=null &&mode.equals("subdiv")){ %>
		<td class=<%=style %> style="text-align: right;"><a href="rws_ongoing_works_abs_drill3.jsp?mode=subdiv&rDistrict=<%=dcode%>&rDistrictName=<%=dname%>&divcode=<%=divcode %>&divname=<%=divname %>&subdivcode=<%=rs2.getString(5) %>&subdivname=<%=rs2.getString(1) %>&scheme=<%=scheme%>&programe=<%=programe%>&startyr=<%=startyr%>&nextFinYear=<%=nextFinYear%>&endyr=<%=endyr%>"><%= comp_Habs.get(rs2.getString(2))==null?"0":(comphabs_cnt=(Integer.parseInt((String)comp_Habs.get(rs2.getString(2))))) %></td>
		<%} %>		
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"FC")==null?"0":(cfc_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"FC")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"PC1")==null?"0":(cpc1_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"PC1")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"PC2")==null?"0":(cpc2_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"PC2")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"PC3")==null?"0":(cpc3_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"PC3")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"PC4")==null?"0":(cpc4_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"PC4")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"NC")==null?"0":(cnc_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"NC")))) %></td>
		<td class=<%=style %> style="text-align: right;"><%= habCovStatus_Cnt.get(rs2.getString(2)+"NSS")==null?"0":(cnss_cnt=(Integer.parseInt((String)habCovStatus_Cnt.get(rs2.getString(2)+"NSS")))) %></td>
		</tr>
		<%			
			tot1+=wrk_cnt;
			tot2+=comp_wrkcnt;
			tot3+=Double.parseDouble(snamnt);
			tot4+=habs_cnt;
			tot5+=sfc_cnt;
			tot6+=spc1_cnt;
			tot7+=spc2_cnt;
			tot8+=spc3_cnt;
			tot9+=spc4_cnt;
			tot10+=cfc_cnt;
			tot11+=cpc1_cnt;
			tot12+=cpc2_cnt;
			tot13+=cpc3_cnt;
			tot14+=cpc4_cnt;
			tot15+=expDuring;
			tot16+=comphabs_cnt;
			tot17+=snc_cnt;
			tot18+=snss_cnt;
			tot19+=cnc_cnt;
			tot20+=cnss_cnt;
			totexpbank+=expbank;
			totexppao+=exppao;
			totexpPhyFin+=expPhyFin;
			totphyfinWorks+=phyfinWorks;
		}		
		%>		
		<tr>
		<td class="gridhdbg" style="text-align: left;" colspan=2>Total</td>		
		<td class="gridhdbg" style="text-align: right;"><%=tot1 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(tot3) %></td> 
		<td class="gridhdbg" style="text-align: right;"><%=tot4 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot5 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot6 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot7 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot8 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot9 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot17 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot18 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=totphyfinWorks %></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totexpPhyFin)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totexpbank)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(totexppao)%></td>
		<td class="gridhdbg" style="text-align: right;"><%=ndf.format(tot15) %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot2 %></td>	
		<td class="gridhdbg" style="text-align: right;"><%=tot16 %></td>		
		<td class="gridhdbg" style="text-align: right;"><%=tot10 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot11 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot12 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot13 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot14 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot19 %></td>
		<td class="gridhdbg" style="text-align: right;"><%=tot20 %></td>		
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