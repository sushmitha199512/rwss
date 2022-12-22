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
	//String loggedUser = user.getUserId();
	
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());
	

    DecimalFormat ndf = new DecimalFormat("####.##");
	StringBuffer financialstartyr=new StringBuffer();
           StringBuffer pname=(StringBuffer)session.getAttribute("pname");
	financialstartyr.append((StringBuffer)session.getAttribute("financialyr"));

    //schemes
StringBuffer scheme=(StringBuffer)session.getAttribute("scheme");


//String startyr =financialstartyr.substring(0,4);
	//String endyr =financialstartyr.substring(5,9);
  //  String endyr1 =financialstartyr.substring(5,9);
  
  
  StringBuffer startyr=new StringBuffer();
  StringBuffer endyr=new StringBuffer();
  StringBuffer endyr1=new StringBuffer();
  
  
	 startyr.append(financialstartyr.substring(0,4));
	 endyr.append(financialstartyr.substring(5,9));
   endyr1.append(financialstartyr.substring(5,9));
  
  
  
       String[] programes=request.getParameterValues("program");
    	

    StringBuffer programe=(StringBuffer)session.getAttribute("programe");
	//System.out.println("programe::"+programe);
	
	//////////system date 
StringBuffer sysdate=new StringBuffer();

 sysdate.append(workData.getDate());
 
 StringBuffer sysmon=new StringBuffer();

 sysmon.append(sysdate.substring(3,5));
 
   //String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon.toString());
   //System.out.println("sysdate::"+sysdate);
   StringBuffer sysyear=new StringBuffer();
		   
		   
   sysyear.append(sysdate.substring(6,10));
   int yy=Integer.parseInt(startyr.toString());
   
   StringBuffer nextfinancialstartyr=new StringBuffer();
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr.append(""+nextFinYear+"-"+nn);
//System.out.println("startyr"+startyr);
   //System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;

   StringBuffer prevmonth=new StringBuffer();
   StringBuffer cmonth=new StringBuffer();
   StringBuffer nextmonth=new StringBuffer();

prevmonth.append(RwsUtils.getPreviousMonth().toUpperCase());
cmonth.append(RwsUtils.getCurrentMont().toUpperCase());
 nextmonth.append(RwsUtils.getNextMonth().toUpperCase());
   
   
//String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
//String cmonth=RwsUtils.getCurrentMont().toUpperCase();
//String nextmonth=RwsUtils.getNextMonth().toUpperCase();

if(startyr.toString().equals(sysyear) && cmonth.toString().equals("APR")){
   prevmonth=cmonth;
}
StringBuffer startyr2=new StringBuffer();
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1.append(startyr);

}else {
endyr1.append(endyr);
}
StringBuffer dcode=new StringBuffer();
StringBuffer type=new StringBuffer();  
     

 dcode.append(request.getParameter("dcode"));
 type.append(request.getParameter("type"));

//String dcode=request.getParameter("dcode");
//String type=request.getParameter("type");

StringBuffer currentMonth=new StringBuffer();

 currentMonth.append(RwsUtils.getCurrentMont());
 
 
 StringBuffer nextMonth=new StringBuffer();

 nextMonth.append(RwsUtils.getNextMonth());
//String nextMonth=RwsUtils.getNextMonth();



	%>
	
	<body>
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" style="border-collapse:collapse" >
	
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  style="border-collapse:collapse" >
<tr >
		<td align="center" class="gridhdbg" colspan=7>PROGRAMME WISE COVERAGE OF HABITATIONS DURING THE CURRENT FINANCIAL YEAR -(<%=financialstartyr.toString() %>)--<%=pname.toString() %> .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" >Sl.No</td>
		<td   class="gridhdbg" >District</td>
<td  class="gridhdbg" >WorkId</td>
<td  class="gridhdbg" >Work Name</td>
<td class="gridhdbg"   >Hab Code</td>
<td class="gridhdbg"   >Hab Name</td>
<td class="gridhdbg"   >Coverage Status</td>

<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null;
int count=1;

StringBuffer svsWorksHabs=new StringBuffer();
StringBuffer mvsWorksHabs=new StringBuffer();

StringBuffer districtQuery=new StringBuffer();
StringBuffer svsStr=new StringBuffer();

StringBuffer mvsStr=new StringBuffer();

StringBuffer style=new StringBuffer();

  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();


	  /******   SVS- WORKS EXPENDITURE *****************************************************/

	  	svsWorksHabs.append("select d.dcode,d.dname ,w.work_id,w.work_name,v.hab_code,ch.panch_name,ch.coverage_status  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_comp_hab_lnk_tbl v,rws_complete_hab_view ch  where v.hab_code=ch.panch_code and   w.WORK_CANCEL_DT is null and w.category_code='"+type.toString()+"'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2) and w.work_id in(select work_id from rws_work_completion_tbl where  (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') )  ");
	   
	  	 if(dcode!=null && !dcode.toString().equals("00")){
	  		svsWorksHabs.append("and d.DCODE='"+dcode.toString()+"'  ");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  svsWorksHabs.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  svsWorksHabs.append(" and  w.programme_code in ("+programe.toString()+")  ");

	  	//System.out.println("svsWorksHabs"+svsWorksHabs);
	  	ResultSet rs2=stmt2.executeQuery(svsWorksHabs.toString());
	  
	    
	
  int styleCount=0;
  //String style="";
  //start printing
	while(rs2.next())
	{
		
	
		
		style.delete(0,style.length());
		 if(styleCount%2==0){
			 style.append("gridbg1");
		 }else{
			 style.append("gridbg2");
		 }
		 styleCount++;
		
		%>
		
		<tr>
		<td class="<%=style %>" style="text-align: left;"><%=count++ %></td>
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(2) %></td>
		
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(3) %></td>
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(4) %></td>
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(5) %></td>
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(6) %></td>
		<td class="<%=style %>" style="text-align: left;"><%=rs2.getString(7) %></td>
		
		
		</tr>
		
		
		<% 
		
		
		
		
		
		
		
	}   //End Main Loop
	
	
	%>
		
	<% 

}catch(Exception e){
  e.printStackTrace();
}
  
  finally{
	  
	  style=null;
	  cmonth=null;
	  currentMonth=null;
	  dcode=null;
	  endyr=null;
	  endyr1=null;
	  financialstartyr=null;
	 
	  mvsStr=null;
	  nextmonth=null;
	  pname=null;
	  startyr=null;
	  startyr2=null;
	  sysdate=null;
	  financialstartyr=null;
	  nextfinancialstartyr=null;
	  type=null;
	  prevmonth=null;
  }
  

 %>

</table>	
</body>
</html>