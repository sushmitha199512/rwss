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
//System.out.println("Changing");
    //schemes
StringBuffer scheme=new StringBuffer();
  if(request.getParameterValues("scheme")!=null){
    String[] schemes=request.getParameterValues("scheme");
	
    
	for(int i=0;i<schemes.length;i++)
	{
	scheme.append(schemes[i]+",");
	}
	////System.out.println("programe::"+programe);
	scheme.append(scheme.substring(0,scheme.length()-1));
session.setAttribute("scheme",scheme);
}
  

  StringBuffer startyr=new StringBuffer();
  StringBuffer endyr=new StringBuffer();
  StringBuffer endyr1=new StringBuffer();
  
 
	 startyr.append(financialstartyr.substring(0,4));
	
	 endyr.append(financialstartyr.substring(5,9));
	
   endyr1.append(financialstartyr.substring(5,9));

	//String startyr =financialstartyr.substring(0,4);
	//String endyr =financialstartyr.substring(5,9);
    //String endyr1 =financialstartyr.substring(5,9);
       String[] programes=request.getParameterValues("program");
    	

    StringBuffer programe=new StringBuffer();
	for(int i=0;i<programes.length;i++)
	{
	programe.append(programes[i]+",");
	}
	////System.out.println("programe::"+programe);
	programe.append(programe.substring(0,programe.length()-1));
session.setAttribute("programe",programe);
	////System.out.println("programe::"+programe);
 

 StringBuffer sysdate=new StringBuffer();
		 
 sysdate.append(workData.getDate());
 
 StringBuffer sysmon=new StringBuffer();
 
 sysmon.append(sysdate.substring(3,5));
 
   //String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon.toString());
   //System.out.println("sysdate::"+sysdate);
   
    StringBuffer sysyear=new StringBuffer();
 
    sysyear.append(sysdate.substring(6,10));
   
   
  // String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(startyr.toString());
   
   StringBuffer nextfinancialstartyr=new StringBuffer();
   
   int nextFinYear=yy+1;
   int nn=nextFinYear+1;
   
   nextfinancialstartyr.delete(0,nextfinancialstartyr.length());
   
   nextfinancialstartyr.append(""+nextFinYear+"-"+nn);
//System.out.println("nextfinancialstartyr"+nextfinancialstartyr);
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
//String startyr2="";
  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
	endyr1.delete(0,endyr1.length());
endyr1.append(startyr);

}else {
	endyr1.delete(0,endyr1.length());
endyr1.append(endyr);
}

////System.out.println("Startyr:"+startyr);
////System.out.println("Startyr2:"+startyr2 );
////System.out.println("Endyr:"+endyr );

//System.out.println("Endyr2:"+endyr1);


     ////System.out.println("Get Cuurent MOnth:"+d.getMonth());

StringBuffer dcode=new StringBuffer();
StringBuffer divCode=new StringBuffer();  
     

 dcode.append(request.getParameter("district"));
 divCode.append(request.getParameter("divCode"));
 
//String dcode=request.getParameter("district");
//String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}

//System.out.println("dcode"+dcode);
//System.out.println("DivCode"+divCode);


//String currentMonth=RwsUtils.getCurrentMont();
//String nextMonth=RwsUtils.getNextMonth();


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
				<td class="bwborder"><a href="./rws_coverage_habs_exp_frm.jsp">Back|</a><a href="./rws_coverage_habs_exp_xls.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="center" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"  style="border-collapse:collapse" >
<tr >
		<td align="center" class="gridhdbg" colspan=6>PROGRAMME WISE EXPENDITURE DURING THE CURRENT FINANCIAL YEAR -(<%=financialstartyr.toString() %>)--<%=pname.toString() %> .</td>	
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

StringBuffer svsWorksExp=new StringBuffer();
StringBuffer mvsWorksExp=new StringBuffer();
StringBuffer svsWorksDirectExp=new StringBuffer();
StringBuffer mvsWorksDirectExp=new StringBuffer();
StringBuffer districtQuery=new StringBuffer();
StringBuffer svsStr=new StringBuffer();
StringBuffer key=new StringBuffer();
StringBuffer mvsStr=new StringBuffer();

StringBuffer style=new StringBuffer();
StringBuffer svsDirectStr=new StringBuffer();
StringBuffer mvsDirectStr=new StringBuffer();


  try{
	  
	  
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();


	  /******   SVS- WORKS EXPENDITURE *****************************************************/
svsWorksExp.delete(0,svsWorksExp.length());
	  svsWorksExp.append("select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_exp_voucher_tbl  v  where   w.WORK_CANCEL_DT is null and w.category_code='2'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2)  and  to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+endyr1.toString()+"'");
	   
	  	 if(dcode!=null && !dcode.toString().equals("00") && !dcode.toString().equals("null")){
	  		svsWorksExp.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  svsWorksExp.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  svsWorksExp.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");
System.out.println("endyr1"+endyr1);
	  	System.out.println("svsWorksExp"+svsWorksExp);
	  	ResultSet rs2=stmt2.executeQuery(svsWorksExp.toString());
	  
	  	Hashtable svsWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		svsWorksExpHash.put(rs2.getString(1),rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();


	    stmt2=conn.createStatement();
		
	    mvsWorksExp.delete(0,mvsWorksExp.length());
	    //System.out.println("mvsWorksExp"+mvsWorksExp);
	  mvsWorksExp.append("select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_exp_voucher_tbl v  where   w.WORK_CANCEL_DT is null and w.category_code='1'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2)  and  to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+endyr1.toString()+"'");
		   
	  	 if(dcode!=null && !dcode.toString().equals("00") && !dcode.toString().equals("null")){
	  		mvsWorksExp.append("and d.DCODE='"+dcode.toString()+"'");
	  		}

	  if(scheme!=null && !scheme.toString().equals("")){
		  mvsWorksExp.append("and w.type_of_asset in("+scheme.toString()+")");
	  }
	   
	  mvsWorksExp.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

	  	System.out.println("mvsWorksExp"+mvsWorksExp);
	  	 rs2=stmt2.executeQuery(mvsWorksExp.toString());
	  
	  	Hashtable mvsWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		mvsWorksExpHash.put(rs2.getString(1),rs2.getString(3));
	  	}
	  
	  	
	  	 if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
			
			
			
			stmt2=conn.createStatement();
			
			svsWorksDirectExp.delete(0,svsWorksDirectExp.length());
			
		 svsWorksDirectExp.append("select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_direct_voucher_tbl v  where   w.WORK_CANCEL_DT is null and w.category_code='2'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2)  and  to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+endyr1.toString()+"'");
			   
		  	 if(dcode!=null && !dcode.toString().equals("00") && !dcode.toString().equals("null")){
		  		svsWorksDirectExp.append("and d.DCODE='"+dcode.toString()+"'");
		  		}

		  if(scheme!=null && !scheme.toString().equals("")){
			  svsWorksDirectExp.append("and w.type_of_asset in("+scheme.toString()+")");
		  }
		   
		  svsWorksDirectExp.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

		  	System.out.println("svsWorksDirectExp"+svsWorksDirectExp);
		  	 rs2=stmt2.executeQuery(svsWorksDirectExp.toString());
		  
		  	Hashtable svsWorksDirectExpHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		svsWorksDirectExpHash.put(rs2.getString(1),rs2.getString(3));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();


		    stmt2=conn.createStatement();
		    mvsWorksDirectExp.delete(0,mvsWorksDirectExp.length());
		    
		     mvsWorksDirectExp.append("select d.dcode,d.dname ,(sum(VOUCHER_AMT)/100000) FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, rws_work_direct_voucher_tbl  v  where   w.WORK_CANCEL_DT is null and w.category_code='1'    and v.work_id=w.work_id and d.dcode=substr(w.work_id,5,2)  and  to_date(v.VOUCHER_DT,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.VOUCHER_DT,'dd/mm/yy')<'01-"+currentMonth.toString()+"-"+endyr1.toString()+"'");
			   
		  	 if(dcode!=null && !dcode.toString().equals("00") && !dcode.toString().equals("null")){
		  		mvsWorksDirectExp.append("and d.DCODE='"+dcode.toString()+"'");
		  		}

		  if(scheme!=null && !scheme.toString().equals("")){
			  mvsWorksDirectExp.append("and w.type_of_asset in("+scheme.toString()+")");
		  }
		   
		  mvsWorksDirectExp.append(" and  w.programme_code in ("+programe.toString()+")  group by d.dcode,d.dname ");

		  System.out.println("mvsWorksDirectExp"+mvsWorksDirectExp);
		  	 rs2=stmt2.executeQuery(mvsWorksDirectExp.toString());
		  
		  	Hashtable mvsWorksDirectExpHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		mvsWorksDirectExpHash.put(rs2.getString(1),rs2.getString(3));
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
  double svsExp=0,mvsExp=0,svsDirectExp=0.0,mvsDirectExp=0,totExp=0;
 
  double gsvsExp=0,gmvsExp=0,gtotExp=0;
  //start printing
	while(rs2.next())
	{
		
		
		key.delete(0,key.length());
		 key.append(rs2.getString(1));
		 //System.out.println("key"+key);
		
		svsStr.delete(0,svsStr.length());
		 svsStr.append((String.valueOf(svsWorksExpHash.get(key.toString()))));
		 if(svsStr!=null && !svsStr.toString().equals("")&& !svsStr.toString().equals("null")){
			 
			 svsExp=Double.parseDouble(svsStr.toString());
			 
		 }else {
			 svsExp=0;
		 }
		 
		 //System.out.println("svsExp"+svsExp);
		 
		 mvsStr.delete(0,mvsStr.length());
		mvsStr.append((String.valueOf(mvsWorksExpHash.get(key.toString()))));
		 if(mvsStr!=null && !mvsStr.toString().equals("")&& !mvsStr.toString().equals("null")){
			 
			 mvsExp=Double.parseDouble(mvsStr.toString());
			 
		 }else {
			 
			 mvsExp=0;
		 }
		
		 //System.out.println("mvsExp"+mvsExp);
		 //direct  vouchers Expenditure
		 
		 
	
	svsDirectStr.delete(0,svsDirectStr.length());
		 
		svsDirectStr.append((String.valueOf(svsWorksDirectExpHash.get(key.toString()))));
		 //System.out.println("svsDirectExp"+svsDirectExp);
		 
		 
		 if(svsDirectStr!=null && !svsDirectStr.toString().equals(" ") &&  !svsDirectStr.toString().equals("null") ){
			 //System.out.println("svsDirectExp"+svsDirectExp);
			 svsDirectExp=Double.parseDouble(svsDirectStr.toString());
			 //System.out.println("svsDirectExp"+svsDirectExp);
			 
		 }else {
			 svsDirectExp=0;
		 }
		 //System.out.println("svsDirectExp"+svsDirectExp);
		 
		 mvsDirectStr.delete(0,mvsDirectStr.length());
	 mvsDirectStr.append((String.valueOf(mvsWorksDirectExpHash.get(key.toString()))));
		 if(mvsDirectStr!=null && !mvsDirectStr.toString().equals("")&&  !mvsDirectStr.toString().equals("null")){
			 
			 mvsDirectExp=Double.parseDouble(mvsDirectStr.toString());
			 
		 }else {
			 mvsDirectExp=0;
		 }
		 //System.out.println("mvsDirectExp"+mvsDirectExp);
		 
		 svsExp+=svsDirectExp;
		mvsExp+=mvsDirectExp;
		 
		 totExp=svsExp+mvsExp;
		 
		 //System.out.println("totExp"+totExp);
		 gsvsExp+=svsExp;
		 
		 gmvsExp+=mvsExp;
		 
		 gtotExp+=totExp;
		 
		 


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
		<td class="<%=style %>" style="text-align: right;"><%= ndf.format(svsExp) %></td>
		<td class="<%=style %>" style="text-align: right;"><%=ndf.format(mvsExp) %></td>
		<td class="<%=style %>" style="text-align: right;"><%=ndf.format(totExp) %></td>
		
		</tr>
		
		
		<% 
		
		
		
		
		
		
		
	}   //End Main Loop
	
	
	%>
	
	<tr>
	<td class="gridhdbg" style="text-align: left;" colspan="2">Total:</td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gsvsExp) %></td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gmvsExp) %></td>
	<td class="gridhdbg" style="text-align: right;" ><%=ndf.format(gtotExp) %></td>
	</tr>
		
	
	<% 

}catch(Exception e){
  e.printStackTrace();
}
  finally{
	   svsWorksExp=null;
	   mvsWorksExp=null;
	   svsWorksDirectExp=null;
	   mvsWorksDirectExp=null;
	   districtQuery=null;
	   svsStr=null;
	   key=null;
	  mvsStr=null;

	   style=null;
	   svsDirectStr=null;
	   mvsDirectStr=null;
 financialstartyr=null;
 pname=null;
 cmonth=null;
 currentMonth=null;
 nextmonth=null;
 prevmonth=null;
 divCode=null;
 startyr=null;
 sysyear=null;
 sysmon=null;
 sysdate=null;
	  
  }

 %>

</table>	
</body>
</html>