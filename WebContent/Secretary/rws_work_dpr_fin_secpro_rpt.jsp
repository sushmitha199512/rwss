<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
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
	String financialyr="";
	//String dprsvs="";

     String completionDate=null;
     																
	
    double aas=0;
         
String dcode=request.getParameter("district");
//System.out.println("dcode**********" +dcode);

	if(request.getParameter("finyear")!=null)
	
	{
	financialyr=request.getParameter("finyear");
	System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
	String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
session.setAttribute("financialyr",financialyr);

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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="90%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=24>DPR Status Progress Report for the Financial Year(<%=session.getAttribute("financialyr")%>)<font color="red"></font></td>	
	</tr>
<tr >
		<td class=btext rowspan=4>Sl.No</td>
		<td class=btext rowspan=4>District</td>
        
</tr>

<tr>
<td class=btext align="center"  colspan=3>New Works </td>
<td class=btext align="center"  colspan=3>Total DPRs </td>
<td class=btext align="center"  colspan=3>Survey Stage</td>
<td class=btext align="center"  colspan=3>Estimate  Stage</td>
<td  class=btext align="center"  colspan=4>DPRs completed </td>	
<td  class=btext align="center"  colspan=4>PART A to be cleared</td>	
<td  class=btext align="center"  colspan=4>PART A Cleared</td>	
</tr>

<tr>
<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>
<td rowspan=2  colspan=1 class=btext align="left">Total </td>
<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>
<td rowspan=2  colspan=1 class=btext align="left">Total </td>







<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>	
<td rowspan=2  colspan=1 class=btext align="left">Total </td>

<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>	
<td rowspan=2  colspan=1 class=btext align="left">Total </td>

		
<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>
<td rowspan=2  colspan=1 class=btext align="left">Total </td>
<td rowspan=2  colspan=1 class=btext align="left">Exp<br>(Rs.Lakhs)</br></td>

<td rowspan=2 colspan=1 class=btext align="center">SVS</td>
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>
<td rowspan=2  colspan=1 class=btext align="left">Total </td>
<td rowspan=2  colspan=1 class=btext align="left">Cost<br>(Rs.Lakhs)</br></td>

<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
<td rowspan=2  colspan=1 class=btext align="center">MVS</td>	
<td rowspan=2  colspan=1 class=btext align="left">Total </td>
<td rowspan=2  colspan=1 class=btext align="left">Exp<br>(Rs.Lakhs)</br></td>



</tr>
<!-- </tr><tr><td class=btext align="center">1</td><td class=btext align="center">2</td><td class=btext align="center">3</td><td class=btext align="center">4</td><td class=btext align="center">5</td><td class=btext align="center">6</td><td class=btext align="center">7</td><td class=btext align="center">8</td><td class=btext align="center">9</td><td class=btext align="center">10</td><td class=btext align="center">11</td><td class=btext align="center">12</td><td class=btext align="center">13</td><td class=btext align="center">14</td></tr>-->
<%

Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null;
ResultSet rs1=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null;
int count=1;
  try{
	
	 
	//Date fixed by Department
	  String dt="01/APR/12";
	 // select SUM(DPRCHARGES+HMWSCHRGS+LANDAQUISITIONCHRG+WATERDRAWLPERMISSIONCHRG+RAILWAYCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONNHAICHRG+FORESTCLEARANCECHRG+POWERAPTRANSCOCHRGS) AS CHRG,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id   and a.dprstatus is not null and DPRCHARGES is not null and HMWSCHRGS is not null and LANDAQUISITIONCHRG is not null and WATERDRAWLPERMISSIONCHRG is not null and RAILWAYCROSSINGPERMISSIONCHRG is not null and ROADCROSSINGPERMISSIONCHRG is not null and  ROADCROSSINGPERMISSIONNHAICHRG is not null and FORESTCLEARANCECHRG is not null and POWERAPTRANSCOCHRGS is not null group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1;

	  
	//part svs A clered date
		
	   String partaallchrg="select SUM(DPRCHARGES+HMWSCHRGS+LANDAQUISITIONCHRG+WATERDRAWLPERMISSIONCHRG+RAILWAYCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONNHAICHRG+FORESTCLEARANCECHRG+POWERAPTRANSCOCHRGS) AS CHRG,substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"' and a.work_id=b.work_id   and a.dprstatus is not null and DPRCHARGES is not null and HMWSCHRGS is not null and LANDAQUISITIONCHRG is not null and WATERDRAWLPERMISSIONCHRG is not null and RAILWAYCROSSINGPERMISSIONCHRG is not null and ROADCROSSINGPERMISSIONCHRG is not null and  ROADCROSSINGPERMISSIONNHAICHRG is not null and FORESTCLEARANCECHRG is not null and POWERAPTRANSCOCHRGS is not null";
	   partaallchrg+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	 // System.out.println("partaallchrg******"+partaallchrg);
	  	 rs2=stmt3.executeQuery(partaallchrg);
	  	Hashtable partaclerallchrg=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partaclerallchrg.put(rs2.getString(2),rs2.getString(1));
	  	}

	  
	  
	  
	  
	  
	  
	  
	  
	//part svs A clered date
		
	   String partasvscle="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"' and a.work_id=b.work_id and b.CATEGORY_CODE='2' and  a.dprstatus is not null AND a.PARTACLEARNCEDATE  IS NOT NULL";
	  partasvscle+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	//  System.out.println("partasvscle******"+partasvscle);
	  	 rs2=stmt3.executeQuery(partasvscle);
	  	Hashtable partasvsclerance=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partasvsclerance.put(rs2.getString(2),rs2.getString(1));
	  	}

 //part mvs A total
		
		
		String partamvscle="select count(PARTACLEARANCE) ,substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.dprstatus is not null AND a.PARTACLEARNCEDATE  IS NOT NULL";
		partamvscle+=" group by  substr(b.office_code,2,2) order by 1";
		
		
		  		stmt3=conn.createStatement();
		//  System.out.println("partamvscle******"+partamvscle);
		  	 rs2=stmt3.executeQuery(partamvscle);
		  	Hashtable partamvsclerence=new Hashtable();
		  	while(rs2.next())
		  	{
		  		partamvsclerence.put(rs2.getString(2),rs2.getString(1));
		  	}

	  
	  
	  
	  
	  
	  
	  
	  
	  
	 
	  
		//part A TOTAL amount  nvl(sum(BILL_AMOUNT_CENTRAL),0)
		
	   String partaamt="select nvl(sum(PARTAAMOUNT),0) ,substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id ";
	   partaamt+=" group by  substr(b.office_code,2,2) order by 1 ";
	  		stmt3=conn.createStatement();
	//  System.out.println("partaamt******"+partaamt);
	  	 rs2=stmt3.executeQuery(partaamt);
	  	Hashtable partaamttot=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partaamttot.put(rs2.getString(2),rs2.getString(1));
	  	}
  
	  
	  
	  
	  
	  

	//part svs A total
	
	   String parta="select count(PARTACLEARANCE) ,substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='2' and  a.dprstatus is not null and PARTACLEARNCEDATE is  null";
	   parta+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	  //System.out.println("parta******"+parta);
	  	 rs2=stmt3.executeQuery(parta);
	  	Hashtable patratot=new Hashtable();
	  	while(rs2.next())
	  	{
	  		patratot.put(rs2.getString(2),rs2.getString(1));
	  	}
	  //part mvs A total
		
		
		String partmvsa="select count(PARTACLEARANCE) ,substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.dprstatus is not null and  PARTACLEARNCEDATE is  null";
		partmvsa+=" group by  substr(b.office_code,2,2) order by 1";
		
		
		  		stmt3=conn.createStatement();
		//  System.out.println("partmvsa******"+partmvsa);
		  	 rs2=stmt3.executeQuery(partmvsa);
		  	Hashtable partmvsatot=new Hashtable();
		  	while(rs2.next())
		  	{
		  		partmvsatot.put(rs2.getString(2),rs2.getString(1));
		  	}

	  //dpr expenduture
	   String dprchar="select sum(DPRCHARGES),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and  a.dprstatus is not null and partAAMount is not null and DPRCHARGES  is not null ";
	   dprchar+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	  //System.out.println("dprSVSSurvey******"+dprchar);
	  	 rs2=stmt3.executeQuery(dprchar);
	  	Hashtable dprcharexp=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprcharexp.put(rs2.getString(2),rs2.getString(1));
	  	}
	  
	  
	  
	//DPR Survey Stage
	 

	  String dprSVSSurvey="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS='Survey Stage' and a.DPRSTATUS is not null ";
	  dprSVSSurvey+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	 // System.out.println("dprSVSSurvey******"+dprSVSSurvey);
	  	 rs2=stmt3.executeQuery(dprSVSSurvey);
	  	Hashtable dprSVSSurv=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprSVSSurv.put(rs2.getString(2),rs2.getString(1));
	  	}
	  //DPR Survey Stage
		  String dprMVSSurvey="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.DPRSTATUS='Survey Stage' and a.DPRSTATUS is not null";
		  dprMVSSurvey+=" group by  substr(b.office_code,2,2) order by 1";
		  		stmt3=conn.createStatement();
		//  System.out.println("dprMVSSurvey******"+dprMVSSurvey);
		  	 rs2=stmt3.executeQuery(dprMVSSurvey);
		  	Hashtable dprMVSSurv=new Hashtable();
		  	while(rs2.next())
		  	{
		  		dprMVSSurv.put(rs2.getString(2),rs2.getString(1));
		  	}
	  
	  
	  
	  
	  
	//DPR start of the completed
	 //DPR completed MVR
	  String dprMVScomple="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.DPRSTATUS='Completed/Approved' and a.DPRSTATUS is not null and  a.DPRCOMPDATE  is not null";
	  dprMVScomple+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	 // System.out.println("dprMVStobepre******"+dprMVScomple);
	  	 rs2=stmt3.executeQuery(dprMVScomple);
	  	Hashtable dprMVScomp=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprMVScomp.put(rs2.getString(2),rs2.getString(1));
	  	}



	  
	//DPR completed SVR
	  
	  String dprSVScomple="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS='Completed/Approved' and a.DPRSTATUS is not null and  a.DPRCOMPDATE  is not null";
	  dprSVScomple+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	  //System.out.println("dprSVScomple******"+dprSVScomple);
	  	 rs2=stmt3.executeQuery(dprSVScomple);
	  	Hashtable dprSVScom=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprSVScom.put(rs2.getString(2),rs2.getString(1));
	  	}

	  //DPR end of the completed
	  
	  
	  
	  
	  
	//DPR to be prepared START
	  
	  
  //DPR to be prepared MVR
	  String dprMVStobepre="select count(a.DPRSTATUS),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1'  and a.DPRSTATUS ='Estimate Stage' and a.DPRSTATUS is not null";
	  dprMVStobepre+=" group by  substr(b.office_code,2,2) order by 1";
	  		stmt3=conn.createStatement();
	  //System.out.println("dprMVStobepre******"+dprMVStobepre);
	  	 rs2=stmt3.executeQuery(dprMVStobepre);
	  	Hashtable dprMVSTOBE=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprMVSTOBE.put(rs2.getString(2),rs2.getString(1));
	  	}

	  
	  
	  //DPR to be prepared SVR
	  

String dprSVStobepre="select count(a.DPRSTATUS),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS ='Estimate Stage' and a.DPRSTATUS is not null ";
dprSVStobepre+=" group by  substr(b.office_code,2,2) order by 1";
		stmt3=conn.createStatement();
//System.out.println("dprSVStobepre******"+dprSVStobepre);
	 rs2=stmt3.executeQuery(dprSVStobepre);
	Hashtable dprSVSTOBE=new Hashtable();
	while(rs2.next())
	{
		dprSVSTOBE.put(rs2.getString(2),rs2.getString(1));
	}


//END to be prepared 



//String dprsvs="SELECT  c.CIRCLE_OFFICE_CODE ,c.DIVISION_OFFICE_CODE,a.DPRSTATUS FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_division_office_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and  a.DPRSTATUS is not null  and substr(office_code,2,2)=c.CIRCLE_OFFICE_CODE  and substr(office_code,4,1)=DIVISION_OFFICE_CODE  and a.DPRCOMPDATE IS  NULL group by  c.circle_office_code,c.division_office_code,a.DPRSTATUS order by 1" ;
//String dprsvs="SELECT  count(*) FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_division_office_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and a.DPRCOMPDATE IS  NULL and a.DPRSTATUS is not null  and substr(office_code,2,2)='"+rs1.getString(3)+"' and substr(office_code,4,1)='"+rs1.getString(4)+"'  group by  c.circle_office_code,c.division_office_code order by 1";
 
//String dprsvs="SELECT  distinct substr(b.office_code,2,2),substr(b.office_code,4,1),a.DPRSTATUS FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and a.DPRCOMPDATE IS  NULL and a.DPRSTATUS is not null  and substr(office_code,2,2)='"+rs1.getString(3)+"' and substr(office_code,4,1)='"+rs1.getString(4)+"'  group by  substr(b.office_code,2,2),substr(b.office_code,2,2),a.DPRSTATUS order by 1;

  String  dprsvs="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.dprstatus is not null ";
	
   //if(dcode!=null && !dcode.equals("ALL")){
	  // dprsvs+= " and substr(b.office_code,2,2)='"+dcode+"'";
    //  }
   dprsvs+=" group by  substr(b.office_code,2,2) order by 1";
   
   
       stmt3=conn.createStatement();
     // System.out.println("dprsvs"+dprsvs);
	  rs2=stmt3.executeQuery(dprsvs);
	Hashtable dprSVS=new Hashtable();
	while(rs2.next())
	{
		dprSVS.put(rs2.getString(2),rs2.getString(1));
		//String str=rs2.getString(1);
	}
	//if(rs2!=null)rs2.close();
	//if(stmt3!=null)stmt3.close();


String dprmvs="select count(*),substr(b.office_code,2,2) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where to_date(ADMIN_DATE,'dd/mm/yy') >='"+dt+"'and a.work_id=b.work_id and b.CATEGORY_CODE='1' and a.dprstatus is not null ";
dprmvs+=" group by  substr(b.office_code,2,2) order by 1";
		stmt3=conn.createStatement();
//System.out.println("dprmvs"+dprmvs);
	 rs2=stmt3.executeQuery(dprmvs);
	Hashtable dprMVS=new Hashtable();
	while(rs2.next())
	{
		dprMVS.put(rs2.getString(2),rs2.getString(1)); 
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksMVSQ="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (to_date(ADMIN_DATE,'dd/mm/yy') >= '01/APR/12' and to_date(ADMIN_DATE,'dd/mm/yy') < '01/APR/"+endyr.substring(2,4)+"') and work_cancel_dt is null and type_of_asset in(01,02,03) and w.category_code='1'  group by  substr(office_code,2,2)  order by 1";
			stmt3=conn.createStatement();
	System.out.println("newWorksMVSQ"+newWorksMVSQ);
		 rs2=stmt3.executeQuery(newWorksMVSQ);
		Hashtable newWorksMVS=new Hashtable();
		while(rs2.next())
		{
			newWorksMVS.put(rs2.getString(1),rs2.getString(2));
		}
		if(rs2!=null)rs2.close();
		if(stmt3!=null)stmt3.close();
	String newWorksSVSQ="select substr(office_code,2,2),count(*) FROM RWS_WORK_ADMN_TBL W  where  (to_date(ADMIN_DATE,'dd/mm/yy') >= '01/APR/12' and to_date(ADMIN_DATE,'dd/mm/yy') < '01/APR/"+endyr.substring(2,4)+"')  and work_cancel_dt is null and w.category_code='2'  and type_of_asset in(01,02,03)  group by  substr(office_code,2,2)  order by 1";

			stmt3=conn.createStatement();
	System.out.println("newWorksSVSQ"+newWorksSVSQ);
		 rs2=stmt3.executeQuery(newWorksSVSQ);
		Hashtable newWorksSVS=new Hashtable();
		while(rs2.next())
		{
			newWorksSVS.put(rs2.getString(1),rs2.getString(2));
		}
		//if(rs2!=null)rs2.close();
		//if(stmt3!=null)stmt3.close();



/***********************************End  ************************************/



String query="select dname,dcode from rws_district_tbl   where dcode <>'16' ";
//String query="select b.dname,b.dcode from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code  and  a.status <> 'UI' order by dname ";
if(dcode!=null && !dcode.equals("00")){
	query+=" and dcode='"+dcode+"'";
}
query+=" order by 1";
stmt2=conn.createStatement();
 rs1=stmt2.executeQuery(query);

String dname="";
int svs=0,mvs=0,svspre=0,mvspre=0,svscom=0,mvscom=0,svspart=0,mvspart=0,svspartclerence=0,mvspartclerence=0,svs1=0,mvs1=0;
double dprex=0,gdprexpchar=0;
int gdsvs=0,gtot1=0,gdmvs=0,gtot=0,gsvspartcle=0,gcom=0,gsur=0,svssur=0,gsvspart=0,gpre=0,mvssur=0,gdprSVSTOBEPREPA=0,gdprMVSTOBEPREPA=0,gdprsvscomp=0,gdprmvscomp=0,gdprsvssurv=0;
int gdprmvssurv=0,gsvsmvs=0;
double rel1=0,grel1=0,relUpto=0,relCur=0,grelUpto=0,grelCur=0,relUptoSVS=0,relCurSVS=0,grelUptoSVS=0,grelCurSVS=0,partAMT=0,gpartaclerewncerallchrg=0;
double expUptoMVS=0,expCurSVS=0,expUptoSVS=0,expCurMVS=0,gexpUptoSVS=0,gexpCurSVS=0,gexpUptoMVS=0,gexpCurMVS=0,gpartaAMTtotal=0;
int totdprSVSTOBEPREPA=0,gnewWorksMVStot=0,gnewWorksSVStot=0,gpartatotal=0,gpartaMVStotal=0,gmvssvspart=0,gpartasvsclerancedate=0,gpartamvsclerancedate=0;
String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){
	//new works
	
	String newWorksSVStot=(String)newWorksSVS.get(rs1.getString(2));
	String newWorksMVStot=(String)newWorksMVS.get(rs1.getString(2));
	//total DPR
	String  dsvs=(String)dprSVS.get(rs1.getString(2));
//	System.out.println("dsvs****" +dsvs );
	//String dsvs=""+dprSVS.get(rs1.getString(3)+rs1.getString(4));
	String  dmvs=(String)dprMVS.get(rs1.getString(2));
	//TO BE SVS PREPARED 
	String  dprSVSTOBEPREPA=(String)dprSVSTOBE.get(rs1.getString(2));
	
	//TO BE MVS PREPARED 
	String  dprMVSTOBEPREPA=(String)dprMVSTOBE.get(rs1.getString(2));

	//SVS COMPLETED 
	String  dprsvscomp=(String)dprSVScom.get(rs1.getString(2));

	
	
	
	//MVS COMPLETED 
	String dprmvscomp=(String)dprMVScomp.get(rs1.getString(2));
	
	//dprSVSdprSurv
	String dprsvssurv=(String)dprSVSSurv.get(rs1.getString(2));
	
	//dprMVSdprSurv 
	String  dprmvssurv=(String)dprMVSSurv.get(rs1.getString(2));
	
	//dprchargesEXP 
	String  dprexpchar=(String)dprcharexp.get(rs1.getString(2));
	
	
	//patratotSSVS
	String  partatotal=(String)patratot.get(rs1.getString(2));
	//patratotSMVS   
	String  partaMVStotal=(String)partmvsatot.get(rs1.getString(2));
	//patratotSSVSandMVS amt
	String  partaAMTtotal=(String)partaamttot.get(rs1.getString(2));
	
	//PART A CLERENCE DATE 
	String  partasvsclerancedate=(String)partasvsclerance.get(rs1.getString(2));
	
	//patraclearence
	String  partamvsclerancedate=(String)partamvsclerence.get(rs1.getString(2));
	
	
	//patraclearence
	String partaclerewncerallchrg=(String)	partaclerallchrg.get(rs1.getString(2));

	
	  // stmt3=conn.createStatement();
	     // System.out.println("dprsvs"+dprsvs);
		 rs2=stmt3.executeQuery(dprsvs);
		
		while(rs2.next())
		{
			dprSVS.put(rs2.getString(2),rs2.getString(1));
			
		}

	
	%>
<tr></tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<%//System.out.println(dname); 
}
else{
%>
<td  class=rptLabel></td>


<%} 
if(dprcharexp.get(rs1.getString(2))!=null){
dprex=(((Double.parseDouble((String)dprcharexp.get(rs1.getString(2)))))/100000);
}else{
dprex=0;
} 

%>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_dpr_progress_rpt_drill.jsp?cat=2&type=2&ccode=<%=rs1.getString(2) %>')"><%= newWorksSVS.get(rs1.getString(2))==null?"0":(svs1=(Integer.parseInt((String)newWorksSVS.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_dpr_progress_rpt_drill.jsp?cat=1&type=2&ccode=<%=rs1.getString(2) %>')"><%= newWorksMVS.get(rs1.getString(2))==null?"0":(mvs1=(Integer.parseInt((String)newWorksMVS.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svs1+mvs1) %></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=2&subType=1&dcode=<%=rs1.getString(2) %>')"><%= dprSVS.get(rs1.getString(2))==null?"0":(svs=(Integer.parseInt((String)dprSVS.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=2&subType=2&dcode=<%=rs1.getString(2) %>')"><%= dprMVS.get(rs1.getString(2))==null?"0":(mvs=(Integer.parseInt((String)dprMVS.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svs+mvs) %></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=3&subType=1&dcode=<%=rs1.getString(2) %>')"><%=dprSVSSurv.get(rs1.getString(2))==null?"0":(svssur=(Integer.parseInt((String)dprSVSSurv.get(rs1.getString(2))))) %></td>
<td class=rptValue><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=3&subType=2&dcode=<%=rs1.getString(2) %>')"><%=dprMVSSurv.get(rs1.getString(2))==null?"0":(mvssur=(Integer.parseInt((String)dprMVSSurv.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svssur+mvssur)%></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=4&subType=1&dcode=<%=rs1.getString(2) %>')"><%= dprSVSTOBE.get(rs1.getString(2))==null?"0":(svspre=(Integer.parseInt((String)dprSVSTOBE.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=4&subType=2&dcode=<%=rs1.getString(2) %>')"><%= dprMVSTOBE.get(rs1.getString(2))==null?"0":(mvspre=(Integer.parseInt((String)dprMVSTOBE.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svspre+mvspre)%></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=5&subType=1&dcode=<%=rs1.getString(2) %>')"><%= dprSVScom.get(rs1.getString(2))==null?"0":(svscom=(Integer.parseInt((String)dprSVScom.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=5&subType=2&dcode=<%=rs1.getString(2) %>')"><%= dprMVScomp.get(rs1.getString(2))==null?"0":(mvscom=(Integer.parseInt((String)dprMVScomp.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svscom+mvscom)%></td>
<td class=rptValue ><%=ndf.format(dprex) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=6&subType=1&dcode=<%=rs1.getString(2) %>')"><%=patratot.get(rs1.getString(2))==null?"0":(svspart=(Integer.parseInt((String)patratot.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=6&subType=2&dcode=<%=rs1.getString(2) %>')"><%=partmvsatot.get(rs1.getString(2))==null?"0":(mvspart=(Integer.parseInt((String)partmvsatot.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(mvspart+svspart)%></td>
<td class=rptValue><%= partaAMTtotal==null || partaAMTtotal.equals("null")?"0":partaAMTtotal %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=7&subType=1&dcode=<%=rs1.getString(2) %>')"><%=partasvsclerance.get(rs1.getString(2))==null?"0":(svspartclerence=(Integer.parseInt((String)partasvsclerance.get(rs1.getString(2))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_secpro_drill_rpt.jsp?type=7&subType=2&dcode=<%=rs1.getString(2) %>')"><%=partamvsclerence.get(rs1.getString(2))==null?"0":(mvspartclerence=(Integer.parseInt((String)partamvsclerence.get(rs1.getString(2))))) %></td>
<td class=rptValue ><%=(svspartclerence+ mvspartclerence)%></td>
<td class=rptValue><%=(partaclerewncerallchrg==null || !partaclerewncerallchrg.equals("null")) ?0:ndf.format(partaclerewncerallchrg)%></td>







<% 
gdprexpchar+=dprex;
dprex=0;
gtot+=svs+mvs;
//svs1=0;mvs1=0;
gsur+=svssur+mvssur;
gpre+=svspre+mvspre;
gcom+=svscom+mvscom;
gsvspart+=mvspart+svspart;
gsvspartcle+=svspartclerence+ mvspartclerence;
gtot1+=svs1+mvs1;
gmvssvspart+=mvspart+svspart;
svssur=0;
mvssur=0;


//gdsvs+=gdsvs+Integer.parseInt(dsvs);


grel1+=rel1;
svs=0;
svs1=0;
mvs1=0;
svspart=0;
mvspart=0;
mvs=0;
svspartclerence=0;
mvspartclerence=0;
svscom=0;
mvscom=0;
svspre=0;
mvspre=0;




//total
if(newWorksSVStot!=null && !newWorksSVStot.equals("")){
	gnewWorksSVStot+=Integer.parseInt(newWorksSVStot);
	}


if(newWorksMVStot!=null && !newWorksMVStot.equals("")){
	gnewWorksMVStot+=Integer.parseInt(newWorksMVStot);
	}

//gtot1=svs1+mvs1;

if(dsvs!=null && !dsvs.equals("")){
gdsvs+=Integer.parseInt(dsvs);
}

if(dmvs!=null && !dmvs.equals("")){
	gdmvs+=Integer.parseInt(dmvs);
	}

if(dprSVSTOBEPREPA!=null && !dprSVSTOBEPREPA.equals("")){
	gdprSVSTOBEPREPA+=Integer.parseInt(dprSVSTOBEPREPA);
	}



if(dprMVSTOBEPREPA!=null && !dprMVSTOBEPREPA.equals("")){
	gdprMVSTOBEPREPA+=Integer.parseInt(dprMVSTOBEPREPA);
	}


if(dprMVSTOBEPREPA!=null && !dprMVSTOBEPREPA.equals("")){
	gdprMVSTOBEPREPA+=Integer.parseInt(dprMVSTOBEPREPA);
	}
//complete

if(dprsvscomp!=null && !dprsvscomp.equals("")){
	gdprsvscomp+=Integer.parseInt(dprsvscomp);
	}

if(dprmvscomp!=null && !dprmvscomp.equals("")){
	gdprmvscomp+=Integer.parseInt(dprmvscomp);
	}
//survy


if(dprmvssurv!=null && !dprmvssurv.equals("")){
	gdprmvssurv+=Integer.parseInt(dprmvssurv);
	}

if(dprsvssurv!=null && !dprsvssurv.equals("")){
	gdprsvssurv+=Integer.parseInt(dprsvssurv);
	}

/*
if(dprexpchar!=null && !dprexpchar.equals("")){
	gdprexpchar+=Double.parseInt(dprexpchar);
	}
*/


gsvsmvs=svs+mvs;

if(partatotal!=null && !partatotal.equals("")){
	gpartatotal+=Integer.parseInt(partatotal);
	}
if(partaMVStotal!=null && !partaMVStotal.equals("")){
	gpartaMVStotal+=Integer.parseInt(partaMVStotal);
	}
//partaAMTtotal
if(partaAMTtotal!=null && !partaAMTtotal.equals("")){
	gpartaAMTtotal+=Double.parseDouble(partaAMTtotal);
	}
//partaclearence

if(partasvsclerancedate!=null && !partasvsclerancedate.equals("")){
	gpartasvsclerancedate+=Double.parseDouble(partasvsclerancedate);
	}


if(partamvsclerancedate!=null && !partamvsclerancedate.equals("")){
	gpartamvsclerancedate+=Double.parseDouble(partamvsclerancedate);
	}
if(partaclerewncerallchrg!=null && !partaclerewncerallchrg.equals("")){
	gpartaclerewncerallchrg+=Double.parseDouble(partaclerewncerallchrg);
	}


	}







//total
//gdsvs+=Integer.parseInt(dsvs);

%>
</tr>
<tr><td colspan=2 class=btext align=right>Total:</td>
<td class=btext><%=gnewWorksSVStot%></td>
<td class=btext><%=gnewWorksMVStot%></td>
<td class=btext><%=gtot1%></td>

<td class=btext><%=gdsvs %></td>
<td class=btext><%=gdmvs %></td>
<td class=btext><%=gtot%></td>

<td class=btext><%=gdprsvssurv %></td>
<td class=btext><%=gdprmvssurv %></td>
<td class=btext><%=gsur %></td>
<td class=btext><%=gdprSVSTOBEPREPA %></td>
<td class=btext><%=gdprMVSTOBEPREPA %></td>
<td class=btext><%=gpre %></td>
<td class=btext><%=gdprsvscomp %></td>
<td class=btext><%=gdprmvscomp %></td>
<td class=btext><%=gcom %></td>
<td class=btext><%=ndf.format(gdprexpchar) %></td>
<td class=btext><%=gpartatotal %></td>
<td class=btext><%=gpartaMVStotal %></td>
<td class=btext><%=gmvssvspart %></td>
<td class=btext><%=ndf.format(gpartaAMTtotal) %></td>

<td class=btext><%=gpartasvsclerancedate %></td>
<td class=btext><%=gpartamvsclerancedate %></td>

<td class=btext><%=gsvspartcle %></td>
<td class=btext><%=gpartaclerewncerallchrg %></td>

</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>