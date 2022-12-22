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
	
    double aas=0;
           StringBuffer pname=new StringBuffer();
if(request.getParameter("pname")!=null){
pname.append(request.getParameter("pname"));
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialstartyr.append(request.getParameter("finyear"));
	}
   
	session.setAttribute("financialyr",financialstartyr);
///System.out.println("Changing");
    //schemes
StringBuffer scheme=new StringBuffer();
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme.append(schemes[i]+",");
	}
	//System.out.println("programe::"+programe);
	scheme.append(scheme.substring(0,scheme.length()-1));
session.setAttribute("scheme",scheme);
}

  StringBuffer startyr=new StringBuffer();
  StringBuffer endyr=new StringBuffer();
  StringBuffer endyr1=new StringBuffer();
  
  
	 startyr.append(financialstartyr.substring(0,4));
	 endyr.append(financialstartyr.substring(5,9));
   endyr1.append(financialstartyr.substring(5,9));
       String[] programes=request.getParameterValues("program");
    	

    StringBuffer programe=new StringBuffer();
	for(int i=0;i<programes.length;i++)
	{
	programe.append(programes[i]+",");
	}
	//System.out.println("programe::"+programe);
	programe.append(programe.substring(0,programe.length()-1));
session.setAttribute("programe",programe);
	//System.out.println("programe::"+programe);
 
	StringBuffer sysdate=new StringBuffer();

sysdate.append(workData.getDate());

StringBuffer sysmon=new StringBuffer();

    sysmon.append(sysdate.substring(3,5));
    
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
 //  System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
   
   
   StringBuffer prevmonth=new StringBuffer();
   StringBuffer cmonth=new StringBuffer();
   StringBuffer nextmonth=new StringBuffer();

prevmonth.append(RwsUtils.getPreviousMonth().toUpperCase());
cmonth.append(RwsUtils.getCurrentMont().toUpperCase());
 nextmonth.append(RwsUtils.getNextMonth().toUpperCase());

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

//System.out.println("Startyr:"+startyr);
//System.out.println("Startyr2:"+startyr2 );
//System.out.println("Endyr:"+endyr );

//System.out.println("Endyr2:"+endyr1);


     //System.out.println("Get Cuurent MOnth:"+d.getMonth());
StringBuffer dcode=new StringBuffer();
StringBuffer divCode=new StringBuffer();  
     

 dcode.append(request.getParameter("district"));
 divCode.append(request.getParameter("divCode"));

  if(dcode!=null && !dcode.toString().equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

//System.out.println("dcode"+dcode);
//System.out.println("DivCode"+divCode);

StringBuffer currentMonth=new StringBuffer();
StringBuffer nextMonth=new StringBuffer();

currentMonth.append(RwsUtils.getCurrentMont());
 nextMonth.append(RwsUtils.getNextMonth());



	%>
	
	<body>
	 
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="./rws_coverage_habs_frm.jsp">Back|</a><a href="./rws_coverage_habs_xls.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="center" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  style="border-collapse:collapse" >
<tr >
		<td align="center" class="gridhdbg" colspan=7>PROGRAMME WISE COVERAGE OF HABITATIONS DURING THE CURRENT FINANCIAL YEAR -(<%=financialstartyr.toString() %>)--<%=pname.toString() %> .</td>	
	</tr>
		<tr >
		<td  class="gridhdbg" >Sl.No</td>
		<td   class="gridhdbg" >District</td>
<td  class="gridhdbg" >SVS</td>
<td  class="gridhdbg" >MVS </td>
<td class="gridhdbg"   >Total</td>

<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null;
int count=1;
StringBuffer svsWorksHabs=new StringBuffer();
StringBuffer mvsWorksHabs=new StringBuffer();

StringBuffer districtQuery=new StringBuffer();
StringBuffer svsStr=new StringBuffer();
StringBuffer key=new StringBuffer();
StringBuffer mvsStr=new StringBuffer();

StringBuffer style=new StringBuffer();

  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();


	  /******   SVS- WORKS EXPENDITURE *****************************************************/
svsWorksHabs.delete(0,svsWorksHabs.length());
	  	 svsWorksHabs.append("select d.dcode,d.dname ,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_comp_hab_lnk_tbl v,rws_complete_hab_view ch   where ch.panch_code=v.hab_code and  w.WORK_CANCEL_DT is null and w.category_code='2'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2) and w.work_id in(select work_id from rws_work_completion_tbl where  (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') )  ");
	   
	  	 if(dcode!=null && !dcode.toString().equals("00")){
	  		svsWorksHabs.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  svsWorksHabs.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  svsWorksHabs.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

	  //	System.out.println("svsWorksHabs"+svsWorksHabs);
	  	ResultSet rs2=stmt2.executeQuery(svsWorksHabs.toString());
	  
	  	Hashtable svsWorksHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		svsWorksHabsHash.put(rs2.getString(1),rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();


	    stmt2=conn.createStatement();
	    
	    mvsWorksHabs.delete(0,mvsWorksHabs.length());
		
	     mvsWorksHabs.append("select d.dcode,d.dname ,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_comp_hab_lnk_tbl v ,rws_complete_hab_view ch  where ch.panch_code=v.hab_code and   w.WORK_CANCEL_DT is null and w.category_code='1'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2) and w.work_id in(select work_id from rws_work_completion_tbl where  (to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' ) or  (to_date(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yy')>='01-APR-"+startyr.toString()+"') )  ");
		   
	  	 if(dcode!=null && !dcode.toString().equals("00")){
	  		mvsWorksHabs.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  mvsWorksHabs.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  mvsWorksHabs.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

	  //	System.out.println("mvsWorksExp"+mvsWorksHabs);
	  	 rs2=stmt2.executeQuery(mvsWorksHabs.toString());
	  
	  	Hashtable mvsWorksHabsHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		mvsWorksHabsHash.put(rs2.getString(1),rs2.getString(3));
	  	}
	  
	  	
	  	 if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
			
			
			
					
			



/******   Report Printing *****************************************************/


    stmt2=conn.createStatement();
    districtQuery.delete(0,districtQuery.length());

	 districtQuery.append("select dcode,dname from rws_district_tbl where dcode<>'16'");
 

	
//System.out.println("districtQuery"+districtQuery);
 	rs2=stmt2.executeQuery(districtQuery.toString());
	
  int styleCount=0;
 
 
  double gsvsHabs=0,gmvsHabs=0,gtotHabs=0;
  //start printing
	while(rs2.next())
	{
		//System.out.println("hello");
		
		key.delete(0, key.length());
				key.append(rs2.getString(1));
		
		// System.out.println("key"+key);
		double svsHabs=0,mvsHabs=0,totHabs=0;
		
		svsStr.delete(0, svsStr.length());
		svsStr.append((String)svsWorksHabsHash.get(key.toString()));
		 if(svsStr!=null && !svsStr.toString().equals("")){
			 
			 svsHabs=Double.parseDouble(svsStr.toString());
			// System.out.println("svsHabs"+svsHabs);
			 
		 }else {
			 
			 svsHabs=0;
		 }
		 
		 
		 mvsStr.delete(0, mvsStr.length());
		 
		  mvsStr.append((String)mvsWorksHabsHash.get(key.toString()));
			// System.out.println("mvsHabs"+mvsHabs);
		 if(mvsStr!=null && !mvsStr.toString().equals("") && !mvsStr.toString().equals("null") ){
			 
			 mvsHabs=Double.parseDouble(mvsStr.toString());
			 
			// System.out.println("mvsHabs"+mvsHabs);
		 }else {
			 
			// System.out.println("mvsHabs"+mvsHabs);
			 mvsHabs=0;
		 }
		// System.out.println("mvsHabs"+mvsHabs);
		
		 totHabs=svsHabs+mvsHabs;
		 
		// System.out.println("totHabs"+totHabs);
		 gsvsHabs+=svsHabs;
		 
		 gmvsHabs+=mvsHabs;
		 
		 gtotHabs+=totHabs;
		 
		 
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
		<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_coverage_habs_drill_rpt.jsp?dcode=<%=key.toString() %>&type=2')" ><%= ndf.format(svsHabs) %></a></td>
		<td class="<%=style %>" style="text-align: right;"><a href="#" onclick="viewWorks('rws_coverage_habs_drill_rpt.jsp?dcode=<%=key.toString() %>&type=1')" ><%=ndf.format(mvsHabs) %></a></td>
		<td class="<%=style %>" style="text-align: right;"><%=ndf.format(totHabs) %></td>
		
		</tr>
		
		
		<% 
		
		
		
		
		
		
		
	}   //End Main Loop
	
	
	%>
	
	<tr>
	<td class="gridhdbg" style="text-align: left;" colspan="2">Total:</td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gsvsHabs) %></td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gmvsHabs) %></td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gtotHabs) %></td>
	</tr>
		
	
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
	  key=null;
	  mvsStr=null;
	  nextmonth=null;
	  pname=null;
	  startyr=null;
	  startyr2=null;
	  sysdate=null;
	  financialstartyr=null;
	  nextfinancialstartyr=null;
	  
	  prevmonth=null;
  }

 %>

</table>	
</body>
</html>