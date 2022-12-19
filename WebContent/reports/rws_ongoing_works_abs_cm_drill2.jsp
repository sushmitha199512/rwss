<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<table bgcolor="#F8FCEE" width="100%" height="40px" cellspacing="0" cellpadding="0" border="0" >
<!-- Page header starts here-->
<tr height="1%">
	<td class="pageHeading" align="center">
		<bean:message key="app.title1" />
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading2" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
</table>

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
System.out.println("dcode"+dcode);
System.out.println("dname"+dname);
String startyr =request.getParameter("startyr");

String prevyear=request.getParameter("prevyear");

String endyr =request.getParameter("endyr");
System.out.println("startyr"+startyr);
System.out.println("endyr"+endyr);




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
System.out.println("scheme"+scheme);


String[] programes=request.getParameterValues("programe");

session.setAttribute("programes",programes);
String programe="";
for(int i=0;i<programes.length;i++)
{
programe += programes[i]+",";
}
////////System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
System.out.println("programe"+programe);
session.setAttribute("programe",programe);
    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr aligh=center>District:<font color=blue><b><%=dname%></b></font></tr>
	<tr>
	<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>&nbsp;&nbsp;
					</td>
					</tr>
	<tr >
	<td align="center" class="rptHeading" >Ongoing Works & Habitations Abstract</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	
	    <td class=gridhdbg rowspan="2">Sl.No</td>
       <td class=gridhdbg rowspan="2">Work_Id</td>
       <td class=gridhdbg rowspan="2">Work_Name</td>
       <td class=gridhdbg rowspan="2">Sanction Amount</td>
      
       <td class=gridhdbg rowspan="2">Grounding Date</td>
       <td class=gridhdbg rowspan="2">Completion Date</td>
       <td class=gridhdbg rowspan="2">Expenditure Up to 31-MAR-<%=startyr%>(Amount in Rs.)</td>
       <td class=gridhdbg rowspan="2">Expenditure during 1-Apr-<%=startyr%>-31-Mar-<%=endyr%><br>(Amount in Rs.)</br></td>
       <td class=gridhdbg rowspan="2">Admin Date</td>
       <td class=gridhdbg rowspan="2">Sanctioned  Habs</td>
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
	   String mname=null,pname=null,vname=null,hcode=null,hname=null,covstatus=null,lpcd=null;
	  
	   int sno=1;
	   stmt8=conn.createStatement();
	   String WORK_ID="",workname="";
	   String workidnew="";
	   
	   String adate="";
	   
   int cenamount=0;
   int staamount=0;
   int cencurrntamount=0;
   int statecurrntamount=0;
  
   
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
   
   
  
   
   
   
	//String habqry="select  a.work_id,a.work_name,a.SANCTION_AMOUNT,a.ADMIN_DATE from RWS_WORK_ADMN_TBL a,rws_district_tbl i where  work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and  substr(a.work_id,5,2)=i.dcode ";
String habqry="select a.work_id,a.work_name,a.SANCTION_AMOUNT,to_char(a.ADMIN_DATE,'dd/mm/yyyy'),to_char(GROUNDING_DATE,'dd/mm/yyyy'),NO_OF_HABS,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy')  from RWS_WORK_ADMN_TBL a,rws_work_completion_tbl b, rws_district_tbl i,rws_work_commencement_tbl c where a.work_id=c.work_id and b.work_id=c.work_id and a.work_id=b.work_id and work_cancel_dt is null  and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"') ) and  substr(a.work_id,5,2)=i.dcode"; 
	 
	if(dcode!=null && !dcode.equals("00")){
		habqry+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	}
	if(scheme!=null && !scheme.equals(""))
	{
		habqry+=" and type_of_asset in("+scheme+") ";
	}
	habqry+=" and a.programme_code in ("+programe+")  group by a.work_id,a.work_name,a.SANCTION_AMOUNT,a.ADMIN_DATE,to_char(GROUNDING_DATE,'dd/mm/yyyy'),NO_OF_HABS,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') ";
	  
 //  System.out.println("habqry"+habqry);   
        
   
	 
  rs8=stmt8.executeQuery(habqry);
   while(rs8.next())
   {
   	
	   WORK_ID=rs8.getString(1);
	   adate=rs8.getString(7);
	   
	   hst=conn.createStatement();
	   stmt1=conn.createStatement();
	   stmt2=conn.createStatement();
	   stmt3=conn.createStatement();
	   stmt4=conn.createStatement();
	  
	   String expprevyear="SELECT SUM(NVL(BILL_AMOUNT_CENTRAL,0))  FROM  RWS_BILL_BANK_BRIDGE_DET_TBL  WHERE WORK_ID='"+rs8.getString(1)+"' AND TXID  IS NOT NULL AND  BANK_SEND_DATE<=to_date('31-Mar-"+startyr+"','dd-Mon-yyyy')";
	   String expprevyears="SELECT SUM(NVL(BILL_AMOUT_STATE,'0'))  FROM  RWS_BILL_PAO_BRIDGE_DET_TBL   WHERE WORK_ID='"+rs8.getString(1)+"' AND STATE_TXID  IS NOT NULL AND  STATE_SEND_DATE<=to_date('31-Mar-"+startyr+"','dd-Mon-yyyy')";
	   
	   String expcurrntyear="SELECT SUM(NVL(BILL_AMOUNT_CENTRAL,0))  FROM  RWS_BILL_BANK_BRIDGE_DET_TBL  WHERE WORK_ID='"+rs8.getString(1)+"' AND TXID  IS NOT NULL AND  BANK_SEND_DATE>=to_date('01-APR-"+startyr+"','dd-Mon-yyyy') AND BANK_SEND_DATE<=to_date('31-MAR-"+endyr+"','dd-Mon-yyyy')";
	   String expcurrntyears="SELECT SUM(NVL(BILL_AMOUT_STATE,'0'))  FROM  RWS_BILL_PAO_BRIDGE_DET_TBL   WHERE WORK_ID='"+rs8.getString(1)+"' AND STATE_TXID  IS NOT NULL AND  STATE_SEND_DATE>=to_date('01-APR-"+startyr+"','dd-Mon-yyyy') AND STATE_SEND_DATE <=to_date('31-MAR-"+endyr+"','dd-Mon-yyyy')";
	   
	   
	   String habdetails="select c.mname,c.pname,c.vname,d.hab_code,c.panch_name,c.coverage_Status,c.SAFE_LPCD from rws_complete_hab_view c,rws_admn_hab_lnk_tbl d,rws_work_admn_tbl a where c.panch_code=d.hab_code and  a.work_id='"+WORK_ID+"' and d.work_id='"+WORK_ID+"'";
	  // System.out.println("habdetails "+habdetails);
	   
	   
	  hrs=hst.executeQuery(expprevyear);
	  rs1=stmt1.executeQuery(expprevyears);
	  rs2=stmt2.executeQuery(expcurrntyear);
	  rs3=stmt3.executeQuery(expcurrntyears);
	  rs4=stmt4.executeQuery(habdetails);
	  
	 
	  if(adate!=null && !adate.equals("adate"))
	  {
		adate=adate;  
	  }
	  
	  else
		  {
		  adate="-";
		  }
	  
	  
	  
	
	   if(hrs.next())
	   {
		   cenamount=hrs.getInt(1);
		
	   
	   }
	   if(hrs!=null){hrs.close();}
	   if(hst!=null){hst.close();}
		if(rs1.next())
		{
			 staamount=rs1.getInt(1);
		//	System.out.println("staamount"+staamount);
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
			//System.out.println("statecurrntamount"+statecurrntamount);
			
		}
		if(rs3!=null){rs3.close();}
		if(stmt3!=null){stmt3.close();}
			
	   
		int totexpprev=cenamount+staamount;
		int totexpcurrntyear=cencurrntamount+statecurrntamount;
		
		while(rs4.next())
		{
			
			
			 
			 
			 mname=rs4.getString(1);
			 pname=rs4.getString(2);
			 vname=rs4.getString(3);
			
			 hcode=rs4.getString(4);
			 hname=rs4.getString(5);
			 covstatus=rs4.getString(6);
			 lpcd=rs4.getString(7);
			
		
		
	   

	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
	<%if(!WORK_ID.equals(workidnew)) {%>
    <td class="<%=style%> "style="text-align: right;"><%=sno++%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(1)%></td>
      
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(2)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getDouble(3)%></td>
   
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(5)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=adate%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpprev%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpcurrntyear%></td>
    <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(4)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getInt(6)%></td>
    
     <%}else if(WORK_ID.equals(workidnew))
	{
	System.out.println("workidnewelse");%>
    <td class="<%=style%> "style="text-align: right;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
      
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
   
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    <td class="<%=style%> "style="text-align: right;"></td>
    <td class="<%=style%> "style="text-align: left;"></td>
    
      
    <%} else{%>
    
     <td class="<%=style%> "style="text-align: right;"><%=sno++%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(1)%></td>
      
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(2)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getDouble(3)%></td>
   
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(5)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getString(7)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpprev%></td>
    <td class="<%=style%> "style="text-align: left;"><%=totexpcurrntyear%></td>
    <td class="<%=style%> "style="text-align: right;"><%=rs8.getString(4)%></td>
    <td class="<%=style%> "style="text-align: left;"><%=rs8.getInt(6)%></td>
    
    	<% }%>
	<% workidnew=WORK_ID; %>
    
     <td class="<%=style%> "style="text-align: left;"><%=mname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=pname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=vname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=hcode%></td>
    <td class="<%=style%> "style="text-align: left;"><%=hname%></td>
    <td class="<%=style%> "style="text-align: left;"><%=covstatus%></td>
    <td class="<%=style%> "style="text-align: right;"><%=lpcd%></td>
  
  	</tr>
  	
<%


		}	}
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
if(rs4!=null){rs4.close();}
if(stmt4!=null){stmt4.close();}

	}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>