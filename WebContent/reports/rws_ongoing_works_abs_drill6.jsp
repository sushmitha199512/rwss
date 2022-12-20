<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
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
<form>
<%


nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
String dcode=request.getParameter("rDistrict");
String dname=request.getParameter("rDistrictName");
//System.out.println("dcode"+dcode);
//System.out.println("dname"+dname);
String startyr =request.getParameter("startyr");

String mode="";
if(request.getParameter("mode")!=null){
	mode=request.getParameter("mode");
}
String divcode="";
String divname="";
if(request.getParameter("divcode")!=null){
	divcode=request.getParameter("divcode");
}
if(request.getParameter("divname")!=null){
	divname=request.getParameter("divname");
}
String subdivcode="";
String subdivname="";
if(request.getParameter("subdivcode")!=null){
	subdivcode=request.getParameter("subdivcode");
}
if(request.getParameter("subdivname")!=null){
	subdivname=request.getParameter("subdivname");
}
//System.out.println("divname "+request.getParameter("divname"));
String prevyear=request.getParameter("prevyear");

String endyr =request.getParameter("endyr");
//System.out.println("startyr"+startyr);
//System.out.println("endyr"+endyr);




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
//System.out.println("scheme"+scheme);


String[] programes=request.getParameterValues("programe");

session.setAttribute("programes",programes);
String programe="";
for(int i=0;i<programes.length;i++)
{
programe += programes[i]+",";
}
////////System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
//System.out.println("programe"+programe);
session.setAttribute("programe",programe);
    String qry="";
    int styleCount=0;
    String style="";

   
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="70%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr aligh=center>District:<font color=blue><b><%=dname%></b></font></tr>
	<%if(divcode!=null  && !divcode.equals("")){ %>
	<tr aligh=center>Division:<font color=blue><b><%=divname%></b></font></tr>
	<%} %>
	<%if(subdivcode!=null && !subdivcode.equals("")){ %>
	<tr aligh=center>Sub Division:<font color=blue><b><%=subdivname%></b></font></tr>
	<%} %>
	<tr>
	<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
					</tr>
	<tr >
	<tr >
	<td align="center" class="rptHeading" >Ongoing Works & Habitations Abstract 
	
	
	
	</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg rowspan="2">Sl.No</td>
       <td class=gridhdbg rowspan="2">District</td>
	    <td class=gridhdbg rowspan="2">Constituency</td>
     
       <td class=gridhdbg rowspan="2">Work_Id</td>
       <td class=gridhdbg rowspan="2">Work_Name</td>
       <td class=gridhdbg rowspan="2">Sanction Amount</td>
      
      <td class=gridhdbg rowspan="2">Expenditure Up to 31-MAR-<%=startyr%>(Amount in Rs.)</td>
       <td class=gridhdbg rowspan="2">Expenditure during (1-Apr-<%=startyr%>) to (31-Mar-<%=endyr%>)<br>(Amount in Rs.)</br></td>
      <td class=gridhdbg rowspan="2">Admin Date</td>
       <td class=gridhdbg rowspan="2">Sanctioned Habs</td>
       <td class=gridhdbg colspan="7">Habitation Details</td>
       
     

   </tr>
   <tr>
    <td class=gridhdbg >Mandal</td>
     <td class=gridhdbg>Panchayat</td>
     <td class=gridhdbg >Village</td>
     <td class=gridhdbg>Habitation Code</td>
     <td class=gridhdbg >Habitation Name</td>
     <td class=gridhdbg>Coverage Status</td>
     <td class=gridhdbg>Safe Lpcd</td>
   </tr>
       
<%
try
{
	   Statement stmt8=null,hst=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null;
	   ResultSet rs8=null,hrs=null,rs1=null,rs2=null,rs3=null,rs4=null;
	   String mname="",pname="",vname="",hcode="",hname="",covstatus="",lpcd="";
	   int sno=1;
	   stmt8=conn.createStatement();
	   String WORK_ID="",workname="",worknamenew="";
	   String workidnew="";
	   String habqry="";
	   
	   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
	//String habqry="select  a.work_id,a.work_name,a.SANCTION_AMOUNT,a.ADMIN_DATE from RWS_WORK_ADMN_TBL a,rws_district_tbl i where  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode ";
	if(mode==null || mode.equals("")){
 		habqry="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,RWS_BILL_BANK_BRIDGE_DET_TBL b  where a.work_id=b.work_id and BANK_SEND_DATE>='01-APR" + startyr + "'and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION)  <= '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode ";
	}else if(mode!=null && mode.equals("div")){
		habqry="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d,RWS_BILL_BANK_BRIDGE_DET_TBL b  where  a.work_id=b.work_id and BANK_SEND_DATE>='01-APR" + startyr + "' and work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) <= '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode  and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and substr(a.office_code,4,1)='"+divcode+"' ";
	}else if(mode!=null && mode.equals("subdiv")){
		habqry="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s,RWS_BILL_BANK_BRIDGE_DET_TBL b  where a.work_id=b.work_id and BANK_SEND_DATE>='01-APR" + startyr + "' and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode  and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and substr(a.office_code,4,1)='"+divcode+"' and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and substr(a.office_code,5,2)='"+subdivcode+"' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	} 
	if(dcode!=null && !dcode.equals("00")){
		habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	}
	if(scheme!=null && !scheme.equals(""))
	{
		habqry+=" and type_of_asset in("+scheme+") ";
	}
	habqry+=" and a.programme_code in ("+programe+")  group by  a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname ,nvl(lead_habitation,'--')";
	habqry+=" UNION ";
	if(mode==null || mode.equals("")){
 		habqry+="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,RWS_BILL_PAO_BRIDGE_DET_TBL b  where a.work_id=b.work_id and STATE_SEND_DATE>='01-APR" + startyr + "' and  work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION)  <= '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode ";
	}else if(mode!=null && mode.equals("div")){
		habqry+="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d,RWS_BILL_PAO_BRIDGE_DET_TBL b  where  a.work_id=b.work_id and STATE_SEND_DATE>='01-APR" + startyr + "' and work_cancel_dt is null  and   a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) <= '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode  and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and substr(a.office_code,4,1)='"+divcode+"' ";
	}else if(mode!=null && mode.equals("subdiv")){
		habqry+="select distinct a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname as dname,nvl(lead_habitation,'--') as lead_habitation  from RWS_WORK_ADMN_TBL a,rws_district_tbl i,rws_division_office_tbl d,rws_subdivision_office_tbl s,RWS_BILL_PAO_BRIDGE_DET_TBL b  where a.work_id=b.work_id and STATE_SEND_DATE>='01-APR" + startyr + "' and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '31-MAR-" + startyr + "')) and  substr(a.work_id,5,2)=i.dcode  and i.dcode=d.circle_office_code and substr(a.office_code,4,1)=d.division_office_code and substr(a.office_code,4,1)='"+divcode+"' and i.dcode=s.circle_office_code and substr(a.office_code,5,2)=s.subdivision_office_code and d.circle_office_code=s.circle_office_code and d.division_office_code=s.division_office_code and substr(a.office_code,5,2)='"+subdivcode+"' and TARGET_DATE_COMP>='01-APR-"+startyr+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
	} 
	if(dcode!=null && !dcode.equals("00")){
		habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	}
	if(scheme!=null && !scheme.equals(""))
	{
		habqry+=" and type_of_asset in("+scheme+") ";
	}
	habqry+=" and a.programme_code in ("+programe+")  group by  a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),NO_OF_HABS,i.dname,nvl(lead_habitation,'--')";
      
 //System.out.println("habqry"+habqry);   

  rs8=stmt8.executeQuery(habqry);
  
   while(rs8.next())
   {
String leadHabitation=rs8.getString("lead_habitation");
       
       String constituency="--";
       if(!leadHabitation.equals("--")){
       String constituencyQuery = "select constituency_name from rws_constituency_tbl where dcode='" + leadHabitation.substring(0,2) + "' and mcode='"+ leadHabitation.substring(5,7) +"'";
           
       Statement statement = conn.createStatement();
       ResultSet resultSet = statement.executeQuery(constituencyQuery);
       if (resultSet.next()) {
     	  constituency = resultSet.getString("constituency_name");
       } 
       statement.close();
       resultSet.close();
       }
       else{
     	  constituency=leadHabitation;
       }
	   
	   if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	   //System.out.println("loop in");
   	
	   hst=conn.createStatement();
	   stmt1=conn.createStatement();
	   stmt2=conn.createStatement();
	   stmt3=conn.createStatement();
	   stmt4=conn.createStatement();
	   int cenamount=0;
	   int staamount=0;
	   int cencurrntamount=0;
	   int statecurrntamount=0;
	   
	  
	 //System.out.println("WORK_ID "+WORK_ID);
	 
	
	   WORK_ID=rs8.getString(1);
	   
	   
	   
	   
	   String expprevyear="SELECT SUM(NVL(BILL_AMOUNT_CENTRAL,0))  FROM  RWS_BILL_BANK_BRIDGE_DET_TBL  WHERE WORK_ID='"+rs8.getString(1)+"' AND TXID  IS NOT NULL AND  BANK_SEND_DATE<=to_date('31-Mar-"+startyr+"','dd-Mon-yyyy')";
	   String expprevyears="SELECT SUM(NVL(BILL_AMOUT_STATE,'0'))  FROM  RWS_BILL_PAO_BRIDGE_DET_TBL   WHERE WORK_ID='"+rs8.getString(1)+"' AND STATE_TXID  IS NOT NULL AND  STATE_SEND_DATE<=to_date('31-Mar-"+startyr+"','dd-Mon-yyyy')";
	   
	   String expcurrntyear="SELECT SUM(NVL(BILL_AMOUNT_CENTRAL,0))  FROM  RWS_BILL_BANK_BRIDGE_DET_TBL  WHERE WORK_ID='"+rs8.getString(1)+"' AND TXID  IS NOT NULL AND  BANK_SEND_DATE>=to_date('01-APR-"+startyr+"','dd-Mon-yyyy') AND BANK_SEND_DATE<=to_date('31-MAR-"+endyr+"','dd-Mon-yyyy')";
	   String expcurrntyears="SELECT SUM(NVL(BILL_AMOUT_STATE,'0'))  FROM  RWS_BILL_PAO_BRIDGE_DET_TBL   WHERE WORK_ID='"+rs8.getString(1)+"' AND STATE_TXID  IS NOT NULL AND  STATE_SEND_DATE>=to_date('01-APR-"+startyr+"','dd-Mon-yyyy') AND STATE_SEND_DATE <=to_date('31-MAR-"+endyr+"','dd-Mon-yyyy')";
	
	  
	   
	   String habdetails="select c.mname,c.pname,c.vname,d.hab_code,c.panch_name,c.coverage_Status,c.SAFE_LPCD from rws_complete_hab_view c,rws_admn_hab_lnk_tbl d,rws_work_admn_tbl a where c.panch_code=d.hab_code and  a.work_id='"+WORK_ID+"' and d.work_id='"+WORK_ID+"'";
	  // System.out.println("habdetails "+habdetails);
	  

	   
	 rs4=stmt4.executeQuery(habdetails);
	 hrs=hst.executeQuery(expprevyear);
	 rs1=stmt1.executeQuery(expprevyears);
	 rs2=stmt2.executeQuery(expcurrntyear);
	 rs3=stmt3.executeQuery(expcurrntyears);
	
	 
	 
	
	   if(hrs.next())
	   {
		   
		   cenamount=hrs.getInt(1);
		
	   }
	   
	   if(hrs!=null){hrs.close();}
	   if(hst!=null){hst.close();}
	   
	   
		if(rs1.next())
		{
			 
			 staamount=rs1.getInt(1);
			
			
		}
		
		if(stmt1!=null){stmt1.close();}
		if(rs1!=null){rs1.close();}
		
		if(rs2.next())
		{
			cencurrntamount=rs2.getInt(1);
			//System.out.println("cencurrntamount"+cencurrntamount);
			
		}
		if(rs2!=null){rs2.close();}
		if(stmt2!=null){stmt2.close();}
		
		if(rs3.next())
		{
			statecurrntamount=rs3.getInt(1);
			
			
		}
		if(rs3!=null){rs3.close();}
		if(stmt3!=null){stmt3.close();}	
		
		
		int totexpprev=cenamount+staamount;
		int totexpcurrntyear=cencurrntamount+statecurrntamount;
		%>
		<tr>
	
	<%if(!WORK_ID.equals(workidnew)) {%>
	<td class="<%=style%> "style="text-align: left;"> <%=sno++%></td>
    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs8.getString("dname")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=constituency%></td>
     <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(1)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
    
    
    <td class="<%=style%> "style="text-align: left;"> <%=rs8.getDouble(3)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpprev%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpcurrntyear%></td>
    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(4)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(5)%></td>
    
    <%}else if(WORK_ID.equals(workidnew))
	{
	//System.out.println("workidnewelse");%>
	<td class="<%=style%> "style="text-align: left;"></td>
	 <td class="<%=style%> "style="text-align: right;"></td>
	  <td class="<%=style%> "style="text-align: left;"></td>
     <td class="<%=style%> "style="text-align: right;"></td>
	  <td class="<%=style%> "style="text-align: left;"></td>
    
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: right;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    
	<%} else{%>
	<td class="<%=style%> "style="text-align: left;"> <%=sno++%></td>
    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs8.getString("dname")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=constituency%></td>
	<td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(1)%></td>
	 <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getDouble(3)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpprev%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpcurrntyear%></td>
    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(4)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(5)%></td>
    
	<% }%>
	<% workidnew=WORK_ID; %>
	
		
		<%		
		if(rs4.next())
		{
			
			 mname=rs4.getString(1);
			 pname=rs4.getString(2);
			 vname=rs4.getString(3);
			
			 hcode=rs4.getString(4);
			 hname=rs4.getString(5);
			 covstatus=rs4.getString(6);
			 lpcd=rs4.getString(7);
			
		
		
			
	
	
	
	
	// System.out.println("workidnew"+workidnew);

		
		
%>
	
	
   <%if(!mname.equals("") && !mname.equals(null)){ %>
    <td class="<%=style%> "style="text-align: left;"><%=mname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=pname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=vname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=hcode%></td>
    <td class="<%=style%> "style="text-align: left;"><%=hname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=covstatus%></td>
    <td class="<%=style%> "style="text-align: right;"><%=lpcd%></td>
    <%}else{ %>
    <td class="<%=style%> "style="text-align: left;">--</td>
    <td class="<%=style%> "style="text-align: left;">--</td>
    <td class="<%=style%> "style="text-align: left;">--</td>
    <td class="<%=style%> "style="text-align: left;">-</td>
    <td class="<%=style%> "style="text-align: left;">--</td>
    <td class="<%=style%> "style="text-align: left;">--</td>
    <td class="<%=style%> "style="text-align: right;">--</td>
    <%} %>
   </tr>
  	
<%



}
		 if(rs4!=null){rs4.close();}
		   if(stmt4!=null){stmt4.close();}
   }
  
%>
<tr>

 
   	</tr>

<%
if(stmt8!=null){
	stmt8.close();
}
if(rs8!=null){
	rs8.close();
}



	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>




<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>