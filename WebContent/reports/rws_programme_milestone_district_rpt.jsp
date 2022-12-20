<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

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
	String financialstartyr="",dddcode="";
	if(request.getParameter("dcode")!=null){
		dddcode=request.getParameter("dcode");
		session.setAttribute("dddcode",dddcode);
		}
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
	System.out.println("programe::kkkk"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	System.out.println("programe::::::::::::"+programe);
 

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
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



String dcode=request.getParameter("dcode12");
//System.out.println("dcode***"+dcode);
String divCode=request.getParameter("divCode");
//System.out.println("divcode***"+divCode);
String subdivCode=request.getParameter("subdivCode");
//tem.out.println("subdivCode***"+subdivCode);

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
  session.setAttribute("subdivCode",subdivCode);
}

//System.out.println("dcode"+dcode);
//System.out.println("DivCode"+divCode);


	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		

			<% 
//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1);">Back|</a><a href="./rws_programme_milestone_district_rpt_xls.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
  
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=30>Milestone Report for the Financial Year--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>District</td>
<td  class=btext  rowspan=3>Ongoing Works(As On 01.04.<%=startyr %></td>

</tr>
<tr>
		

<td  class=btext align="center" style="background-color:lightyellow" colspan=6>Physical <br></td>	
<td  class=btext align="center" style="background-color:lightyellow" colspan=3>Financial <br></td>

</tr>
<tr>
<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Total&nbsp;Milestones</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Achieved&nbsp;Milestones</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Total Percentage((5/4)*100)</td>
<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Total&nbsp;Components</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Achieved&nbsp;Components</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Total Percentage((8/7)*100)</td>
<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Tot Agreement Value</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Ach Value</td>
<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Total Percentage((13/12)*100)</td>

</tr>

<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center"  class=btext>9</td><td align="center"  class=btext>10</td><td align="center"  class=btext>11</td><td align="center"  class=btext>12</td></tr>


<%
Statement stmt2=null,stmt22=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
  try{
    stmt2=conn.createStatement();
    stmt22=conn.createStatement();
    stmt3=conn.createStatement();
    stmt4=conn.createStatement();
    stmt5=conn.createStatement();
    stmt6=conn.createStatement();
    stmt7=conn.createStatement();
    
    // ******   Agreement count*****************************************************/
 String agree="";
  if(dcode!=null)
  {
	  agree="SELECT substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2),sum(PERCENT_COMPLETED_VAL/100000) FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl  m   where substr(office_code,5,2)is not null and w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+") and PERCENT_COMPLETED_VAL is not null and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
   if(scheme!=null && !scheme.equals("")){
	   agree+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2),substr(office_code,4,1),substr(office_code,5,2)  order by 1";
}
   
  }
  else 
  
  {
	  agree="SELECT substr(office_code,2,2),sum(PERCENT_COMPLETED_VAL/100000)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where substr(office_code,5,2)is not null and w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and PERCENT_COMPLETED_VAL is not null and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
		   agree+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2)  order by 1";
	}
  }
   
  
   System.out.println("ach:"+agree);
   		stmt5=conn.createStatement();
   	 rs5=stmt5.executeQuery(agree);
   		Hashtable agre=new Hashtable();
   	while(rs5.next())
   	{
   		agre.put(rs5.getString(1),rs5.getString(2));
   	}

          
    
///for component
   // ******   Agreement count*****************************************************/
  String com="";
  if(dcode!=null)
  {
	  com="SELECT substr(office_code,2,2),sum(PERCENT_COMPLETED_WORK_VAL/100000)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where substr(office_code,5,2)is not null and w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
   if(scheme!=null && !scheme.equals("")){
	   com+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2) order by 1";
}
   
  }
  else 
  
  {
	  com="SELECT substr(office_code,2,2),sum(PERCENT_COMPLETED_WORK_VAL/100000) FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where substr(office_code,5,2)is not null and  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))   ";
	   if(scheme!=null && !scheme.equals("")){
		   com+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null group by substr(office_code,2,2)  order by 1";
	}
  }
   
  
  System.out.println("agree8888888888:"+com);
   		stmt6=conn.createStatement();
   	 rs6=stmt6.executeQuery(com);
   		Hashtable com1=new Hashtable();
   	while(rs6.next())
   	{
   		com1.put(rs6.getString(1),rs6.getString(2));
   	}

    
    
    


/////
    
    
    
    
    ///
    
    // ******   Milestone ARCh count*****************************************************/
  String milestonearch="";
  if(dcode!=null)
  {
	  milestonearch="SELECT substr(office_code,2,2),sum(COMPONENT_NO_ACH)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where  w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and ACHIEVE_DATE is not null and PERCENT_COMPLETED_VAL is not null  ";
   if(scheme!=null && !scheme.equals("")){
	   milestonearch+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null  and COMPONENT_NO_ACH is not null group by substr(office_code,2,2)  order by 1";
}
   
  }
  else 
  
  {
	  milestonearch="SELECT substr(office_code,2,2),sum(COMPONENT_NO_ACH)  FROM RWS_WORK_ADMN_TBL W,rws_milestone_target_ach_tbl m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and ACHIEVE_DATE is not null and PERCENT_COMPLETED_VAL is not null  ";
	   if(scheme!=null && !scheme.equals("")){
		   milestonearch+=" and w.type_of_asset in("+scheme+") and substr(office_code,5,2) is not null and COMPONENT_NO_ACH is not null  group by substr(office_code,2,2)   order by 1";
	}
  }
   
  
  System.out.println("Milestone:"+milestonearch);
   		
   	 rs4=stmt4.executeQuery(milestonearch);
   		Hashtable mstonearc=new Hashtable();
   	while(rs4.next())
   	{
   		mstonearc.put(rs4.getString(1),rs4.getString(2));
   	}

   
   //////end
   
    
    
    
    ///
      
     // ******   Milestone count*****************************************************/
   String milestone="";
   if(dcode!=null)
   {
	   milestone="SELECT substr(office_code,2,2),sum(m.COMPONENT_NO)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m where    w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
    if(scheme!=null && !scheme.equals("")){
    	milestone+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2)  order by 1";
}
    
   }
   else 
   
   {
	   milestone="SELECT substr(office_code,2,2),sum(m.COMPONENT_NO)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
		   milestone+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2)  order by 1";
	}
   }
    
   
   System.out.println("Milestone:"+milestone);
    		stmt3=conn.createStatement();
    	 rs3=stmt3.executeQuery(milestone);
    		Hashtable mstone=new Hashtable();
    	while(rs3.next())
    	{
    		mstone.put(rs3.getString(1),rs3.getString(2));
    	}

    	
    
    //////end
    
    
    
    
    //**************************************************Miilestones************************************** 
    
    
    if(rs3!=null)rs3.close();
    	if(stmt3!=null)stmt3.close();
    
       String milestone1="";
   if(dcode!=null)
   {
	   milestone1="SELECT substr(office_code,2,2),count(m.milestone_code)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m where  w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
    if(scheme!=null && !scheme.equals("")){
    	milestone1+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2)  order by 1";
}
    
   }
   else 
   
   {
	   milestone1="SELECT substr(office_code,2,2),count(m.milestone_code)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where   w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
		   milestone1+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2)   order by 1";
	}
   }
    
   
   System.out.println("mileStoneHash:"+milestone1);
    		stmt3=conn.createStatement();
    	 rs3=stmt3.executeQuery(milestone1);
    		Hashtable mileStoneTargetHash=new Hashtable();
    	while(rs3.next())
    	{
    		mileStoneTargetHash.put(rs3.getString(1),rs3.getString(2));
    	}

    
    	if(rs3!=null)rs3.close();
    	if(stmt3!=null)stmt3.close();
    
      milestone1="";
   if(dcode!=null)
   {
	   milestone1="SELECT substr(office_code,2,2),count(m.milestone_code)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m where   w.work_id=m.work_id and work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and ACHIEVE_DATE is not null ";
    if(scheme!=null && !scheme.equals("")){
    	milestone1+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2)  order by 1";
}
    
   }
   else 
   
   {
	   milestone1="SELECT substr(office_code,2,2),count(m.milestone_code)  FROM RWS_WORK_ADMN_TBL W,rws_MILESTONE_TARGET_ACH_TBL m   where  w.work_id=m.work_id and  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and ACHIEVE_DATE is not null ";
	   if(scheme!=null && !scheme.equals("")){
		   milestone1+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2)  order by 1";
	}
   }
    
   
   System.out.println("mileStoneHash:"+milestone1);
    		stmt3=conn.createStatement();
    	 rs3=stmt3.executeQuery(milestone1);
    		Hashtable mileStoneAchievedHash=new Hashtable();
    	while(rs3.next())
    	{
    		mileStoneAchievedHash.put(rs3.getString(1),rs3.getString(2));
    	}

  
    
    
    
    /******************************************************************************************************
   

   // ******   Ongoing works*****************************************************/
   String ongoing="";
   if(dcode!=null)
   {
    ongoing="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W    where   work_cancel_dt is null and substr(w.work_id,5,2)='"+dddcode+"' and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
    if(scheme!=null && !scheme.equals("")){
    	ongoing+=" and w.type_of_asset in("+scheme+") group by substr(office_code,2,2)  order by 1";
}
    
   }
   else 
   
   {
	   ongoing="SELECT substr(office_code,2,2),count(*)  FROM RWS_WORK_ADMN_TBL W   where  work_cancel_dt is null  and w.programme_code in ("+programe+")  and  w.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  ";
	   if(scheme!=null && !scheme.equals("")){
	    	ongoing+=" and w.type_of_asset in("+scheme+")group by substr(office_code,2,2)   order by 1";
	}
   }
    
   
  System.out.println("OngoingWorks:"+ongoing);
    		stmt2=conn.createStatement();
    	ResultSet rs2=stmt2.executeQuery(ongoing);
    		Hashtable Ongoingworks=new Hashtable();
    	while(rs2.next())
    	{
    		Ongoingworks.put(rs2.getString(1),rs2.getString(2));
    	}

    	
    
    	//



/***********************************End  ************************************/

String query="";
String cricle="",division="",sub="",circlename="",divname="",subdivname="";

	//query="select a.circle_office_code,a.circle_office_name from rws_subdivision_office_tbl c,rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code and c.circle_office_code=a.circle_office_code order by circle_office_code,division_office_code,subdivision_office_code"; 
query ="select dcode,dname from rws_district_tbl";
if(dcode!=null && !dcode.equals("")){
	query+=" where dcode='"+dddcode+"'";
}
//System.out.println("query::::::::::::::::::::"+query);
rs1=stmt7.executeQuery(query);
int ongoingacount=0;


String dname="";
String exp="",nexp="";
ResultSet rs10=null,rs11=null;
Statement st10=null,st11=null;
st10=conn.createStatement();
st11=conn.createStatement();
double sss=0.0;
double gachtot=0;
double gpertot=0.0,gfinctotper=0.0,gagtot=0.0,gfinctot=0.0;
double gmileStoneTargetValue=0,gmileStoneAchValue=0,ssstot=0.0,sstot=0.0;
int gmileStoneTargetValue1=0,gmileStoneAchValue1=0,gongoingtot=0,gongoingachtot=0;
double gmileStonePercentage=0;
int count=1;
while(rs1.next())
{
	
	
	int ongoingtot=0,ongoingachtot=0,achtot=0,agtot=0,finctot=0;
	double mile=0.0,pertot=0.0;
	double ach=0.0,gn=0;
	double totalach=0.0;
	double l=0.0,milefin=0.0,achfin=0.0,totfin=0.0,fi=0.0;

	double s=0.0,s1=0.0,tots=0.0,totall=0.0,gs=0.0,gs1=0.0,gall=0.0;
	cricle=rs1.getString(1);
	if(cricle.equals("00")){
		continue;
	}
		
	circlename=rs1.getString(2);
	
	//*********************************************************************************************************************
	double mileStoneTargetValue=0,mileStoneAchValue=0;;
	double mileStonePercentage=0;
	
	String mileStoneT=(String)mileStoneTargetHash.get(rs1.getString(1));
	if(mileStoneT!=null && !mileStoneT.equals("") && !mileStoneT.equals("null")){
		
		mileStoneTargetValue=Double.parseDouble(mileStoneT);
		gmileStoneTargetValue+=mileStoneTargetValue;
		gmileStoneTargetValue1+=mileStoneTargetValue;
		
	}else{
		mileStoneTargetValue=0;
		mileStoneT="0";
	}
	String mileStoneA=(String)mileStoneAchievedHash.get(rs1.getString(1));
	
	if(mileStoneA!=null && !mileStoneA.equals("") && !mileStoneA.equals("null")){
		
	mileStoneAchValue=Double.parseDouble(mileStoneA);
	gmileStoneAchValue+=mileStoneAchValue;
	gmileStoneAchValue1+=mileStoneAchValue;
		
	}else{
		
		mileStoneAchValue=0;
		mileStoneA="0";
	}
	
	if(mileStoneTargetValue>0){
	mileStonePercentage=(mileStoneAchValue*100)/mileStoneTargetValue;
	}else{
		mileStonePercentage=0;
	}
	
	//***********************************************************************************Sai Prasad N
	
	

String e=(String)Ongoingworks.get(rs1.getString(1));
	System.out.println("e@@@@@@@@"+e);
if(e!=null && !e.equals("") && !e.equals("null")){
}
else
{
	e="0";
}
	
    
//milestone
String m=(String)mstone.get(rs1.getString(1));
if(m!=null && !m.equals("") && !m.equals("null")){
}
else
{
	m="0";
}

//milestoneArc

String a=(String)mstonearc.get(rs1.getString(1));
if(a!=null && !a.equals("") && !a.equals("null")){
}
else
{
	a="0";
}


//
//Agree

String ag=(String)agre.get(rs1.getString(1));
if(ag!=null && !ag.equals("") && !ag.equals("null")){
}
else
{
	ag="0";
}
//
//Agree

String finc=(String)com1.get(rs1.getString(1));
if(finc!=null && !finc.equals("") && !finc.equals("null")){
}
else
{
	finc="0";
}
//finance
milefin=Double.parseDouble(ag);
//System.out.println("milefin--------------"+milefin);
//milefin=milefin/100000;


//System.out.println("milefin*******"+milefin);
achfin=Double.parseDouble(finc);
//achfin=achfin/100000;
//System.out.println("achfin*******"+achfin);

if( achfin > 0)
{	
totfin=(milefin/achfin);
//System.out.println("totlefin*************"+fi);
 fi=totfin*100;
//System.out.println("milefin*************"+fi);
}
else
{
	fi=0.0;
}


//physical
mile=Double.parseDouble(m);
//System.out.println("mile*****"+mile);
ach=Double.parseDouble(a);
//System.out.println("ach*****"+ach);
if(mile > 0 )
{	
totalach=(ach/mile);
 l=totalach*100;
//System.out.println("totalach*************"+l);
}
else
{
	l=0;
}


ongoingtot=Integer.parseInt(e);
gongoingtot=ongoingtot+gongoingtot;


ongoingachtot=Integer.parseInt(m);
gongoingachtot+=ongoingachtot;

//System.out.println("gongoingachtot*************"+gongoingachtot);

achtot=Integer.parseInt(a);
gachtot=achtot+gachtot;


//percentage
if( gongoingachtot > 0)
{	

pertot=gachtot/gongoingachtot;
sss=pertot*100;
//System.out.println("sssssss"+sss);
gpertot+=sss;
}
else
{
	sss=0;
}



////agree value

//agtot=Integer.parseInt(ag);
gagtot=milefin+gagtot;

//// ach value
//finctot=Integer.parseInt(finc);
gfinctot=achfin+gfinctot;
/////



//// percentage value
//finctot=Integer.parseInt(finc);
if(gagtot > 0)
{	
gfinctotper=gfinctot/gagtot;
gfinctotper=gfinctotper*100;
}
else
{
	gfinctotper=0;	
}
/////


%>
<tr>
<td class=rptLabel><%=count++ %></td>
<td class=rptLabel><a href="#" onclick="viewWorks('rws_programme_milestone_drill_district_rpt.jsp?circleofficecode=<%=rs1.getString(1)%>&dname=<%=rs1.getString(2)%>')"><%=rs1.getString(2) %></td>

<td  class=rptValue><%=e %></a></td>
<td  class=rptValue><%=mileStoneT %></td>
<td  class=rptValue><%=mileStoneA %></td>
<td  class=rptValue><%=ndf.format(mileStonePercentage) %></td>
<td  class=rptValue><%=m%></td>
<td  class=rptValue><%=a%></td>
<td  class=rptValue><%=ndf.format(l)%></td>
<td  class=rptValue><%=ndf.format(achfin)%></td>
<td  class=rptValue><%=ndf.format(milefin)%></td>
<td class=rptValue><%=ndf.format(fi)%></td>
</tr>
<% 
//gncovhabs+=ncovhabs;
//tnewWorksComp=0;tspComleted=0;tspSamAmount=0;tsworks=0;tnworws=0;nexpUpto=0;
//gn+=e;
}

if(gmileStoneTargetValue>0){
	gmileStonePercentage=(gmileStoneAchValue*100)/gmileStoneTargetValue;
	
	}else{
		gmileStonePercentage=0;
	}

if(gongoingachtot>0){
	ssstot=(gachtot*100)/gongoingachtot;
	System.out.println("ssstot***********"+ssstot);
	
	}else{
		ssstot=0;
	}





if(gongoingachtot>0){
	sstot=(gagtot*100)/gfinctot;
	System.out.println("sstot***********"+ssstot);
	
	}else{
		sstot=0;
	}






%>
<tr><td colspan=2 class=btext align=right>Total:</td>
<td  class=rptLabel><%=gongoingtot %></td>
<td  class=rptLabel><%=gmileStoneTargetValue1 %></td>
<td  class=rptLabel><%=gmileStoneAchValue1 %></td>
<td  class=rptLabel><%=ndf.format(gmileStonePercentage) %></td>
<td  class=rptLabel><%=gongoingachtot %></td>
<td  class=rptLabel><%=gachtot %></td>
<td  class=rptLabel><%=ndf.format(ssstot) %></td>
<td  class=rptLabel><%=ndf.format(gfinctot)%></td>
<td  class=rptLabel><%=ndf.format(gagtot) %></td>
<td  class=rptLabel><%=ndf.format(sstot) %></td>
</tr>
<% 

//System.out.println("last:");
}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>