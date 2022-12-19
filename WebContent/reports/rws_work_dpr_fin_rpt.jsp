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
	String financialyr="";
	//String dprsvs="";

     String completionDate=null;
     																
	
    double aas=0;
         
String dcode=request.getParameter("district");
////System.out.println("dcode**********" +dcode);
//String pname=request.getParameter("program");
////System.out.println("pname**********" +pname);

String[] programes=request.getParameterValues("program");
	
    String pname="";
	for(int i=0;i<programes.length;i++)
	{
		pname += programes[i]+",";
	}
	//stem.out.println("programe::"+pname);
	pname = pname.substring(0,pname.length()-1);
   session.setAttribute("pname",pname);

  
   String sname="";
   if(request.getParameterValues("scheme")!=null){
   String[] schemes=request.getParameterValues("scheme");
 	
     
 	for(int i=0;i<schemes.length;i++)
 	{
 		sname += schemes[i]+",";
 	}
 	//System.out.println("sname::"+sname);
 	sname = sname.substring(0,sname.length()-1);
 session.setAttribute("scheme",sname);
 }




//String sname=request.getParameter("scheme");
////System.out.println("scheme**********" +sname);

 /* String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}*/



/*
	if(request.getParameter("finyear")!=null)
	
	{
	financialyr=request.getParameter("finyear");
	//System.out.println("financialyr"+financialyr);
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
   
session.setAttribute("financialyr",financialyr);

*/

if(request.getParameter("finyear")!=null)
	
{
financialyr=request.getParameter("finyear");
//stem.out.println("financialyr"+financialyr);
session.setAttribute("financialyr",financialyr);
} else{
financialyr=(String)session.getAttribute("financialyr");
}
String yr =financialyr.substring(0,4);
  session.setAttribute("yr",yr);
	//stem.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
 //   String prvyr=""+(Integer.parseInt(yr)-1);
	String yr1=""+(Integer.parseInt(yr)+1);
  session.setAttribute("yr1",yr1);
  //stem.out.println("yr*******************:"+yr);
	//stem.out.println("yr1*******************:"+yr1);










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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./rws_work_dpr_fin_excel.jsp" target=_new >Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=26>DPR Status Progress Report for the Financial Year(<%=session.getAttribute("financialyr")%>)<font color="red"></font></td>	
	</tr>
<tr >
		<td class=btext rowspan=4>Sl.No</td>
		<td class=btext rowspan=4>District</td>
        <td class=btext rowspan=4>Division</td>
</tr>

<tr>
<td class=btext align="center"  colspan=3>Works<br>(Spill + New) </td>
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
	
	 
	
	 // select SUM(DPRCHARGES+HMWSCHRGS+LANDAQUISITIONCHRG+WATERDRAWLPERMISSIONCHRG+RAILWAYCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONNHAICHRG+FORESTCLEARANCECHRG+POWERAPTRANSCOCHRGS) AS CHRG,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id   and a.dprstatus is not null and DPRCHARGES is not null and HMWSCHRGS is not null and LANDAQUISITIONCHRG is not null and WATERDRAWLPERMISSIONCHRG is not null and RAILWAYCROSSINGPERMISSIONCHRG is not null and ROADCROSSINGPERMISSIONCHRG is not null and  ROADCROSSINGPERMISSIONNHAICHRG is not null and FORESTCLEARANCECHRG is not null and POWERAPTRANSCOCHRGS is not null group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1;

	  
	//part svs A clered date
		
	   String partaallchrg="select SUM(DPRCHARGES+HMWSCHRGS+LANDAQUISITIONCHRG+WATERDRAWLPERMISSIONCHRG+RAILWAYCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONCHRG+ROADCROSSINGPERMISSIONNHAICHRG+FORESTCLEARANCECHRG+POWERAPTRANSCOCHRGS) AS CHRG,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id   and a.dprstatus is not null and DPRCHARGES is not null and HMWSCHRGS is not null and LANDAQUISITIONCHRG is not null and WATERDRAWLPERMISSIONCHRG is not null and RAILWAYCROSSINGPERMISSIONCHRG is not null and ROADCROSSINGPERMISSIONCHRG is not null and  ROADCROSSINGPERMISSIONNHAICHRG is not null and FORESTCLEARANCECHRG is not null and POWERAPTRANSCOCHRGS is not null";
	   if(sname!=null && !sname.equals("")){
		   partaallchrg+=" and b.type_of_asset in("+sname+")";
	}

	
	   partaallchrg+= " and b.PROGRAMME_CODE =c.PROGRAMME_CODE and c.programme_code in ("+pname+") ";
	   
	   

	
	partaallchrg+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	 //stem.out.println("partaallchrg******"+partaallchrg);
	  	 rs2=stmt3.executeQuery(partaallchrg);
	  	Hashtable partaclerallchrg=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partaclerallchrg.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}

	  
	  
	  
	  
	  
	  
	  
	  
	//part svs A clered date
		
	   String partasvscle="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and  a.dprstatus is not null AND a.PARTACLEARNCEDATE  IS NOT NULL";
	
	   if(sname!=null && !sname.equals("")){
		   partasvscle+=" and b.type_of_asset in("+sname+")";
	}
	   partasvscle+= " and b.PROGRAMME_CODE =c.PROGRAMME_CODE and c.programme_code in ("+pname+") ";
	partasvscle+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	 //stem.out.println("partasvscle******"+partasvscle);
	  	 rs2=stmt3.executeQuery(partasvscle);
	  	Hashtable partasvsclerance=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partasvsclerance.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}

 //part mvs A total
		
		
		String partamvscle="select count(PARTACLEARANCE) ,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.dprstatus is not null AND a.PARTACLEARNCEDATE  IS NOT NULL and b.PROGRAMME_CODE =c.PROGRAMME_CODE ";
		 if(sname!=null && !sname.equals("")){
			 partamvscle+=" and b.type_of_asset in("+sname+")";
		}
		partamvscle+= "  and c.programme_code in ("+pname+") ";
 
 partamvscle+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
		
		
		  		stmt3=conn.createStatement();
		  //stem.out.println("partamvscle******"+partamvscle);
		  	 rs2=stmt3.executeQuery(partamvscle);
		  	Hashtable partamvsclerence=new Hashtable();
		  	while(rs2.next())
		  	{
		  		partamvsclerence.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
		  	}

	  
	  
	  
	  
	  
	  
	  
	  
	  
	 
	  
		//part A TOTAL amount  nvl(sum(BILL_AMOUNT_CENTRAL),0)
		
	   String partaamt="select nvl(sum(PARTAAMOUNT),0) ,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id  and b.PROGRAMME_CODE =c.PROGRAMME_CODE ";
	  
	   if(sname!=null && !sname.equals("")){
		   partaamt+=" and b.type_of_asset in("+sname+")";
		}
		
		
	   partaamt+= "  and c.programme_code in ("+pname+")";
	   
		partaamt+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1 ";
	  		stmt3=conn.createStatement();
	  //stem.out.println("partaamt******"+partaamt);
	  	 rs2=stmt3.executeQuery(partaamt);
	  	Hashtable partaamttot=new Hashtable();
	  	while(rs2.next())
	  	{
	  		partaamttot.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}
  
	  
	  
	  
	  
	  

	//part svs A total
	
	   String parta="select count(PARTACLEARANCE) ,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and  a.dprstatus is not null and a.PARTACLEARNCEDATE  IS null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	  
	   if(sname!=null && !sname.equals("")){
		   parta+=" and b.type_of_asset in("+sname+")";
		}
	   parta+= "  and c.programme_code in ("+pname+")";
	
	parta+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	  //stem.out.println("parta******"+parta);
	  	 rs2=stmt3.executeQuery(parta);
	  	Hashtable patratot=new Hashtable();
	  	while(rs2.next())
	  	{
	  		patratot.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}
	  //part mvs A total
		
		
		String partmvsa="select count(PARTACLEARANCE) ,substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.dprstatus is not null and  a.PARTACLEARNCEDATE  IS  null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
		  if(sname!=null && !sname.equals("")){
			  partmvsa+=" and b.type_of_asset in("+sname+")";
			}
		
		partmvsa+= "  and c.programme_code in ("+pname+") ";
	  partmvsa+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
		
		
		  		stmt3=conn.createStatement();
		 //stem.out.println("partmvsa******"+partmvsa);
		  	 rs2=stmt3.executeQuery(partmvsa);
		  	Hashtable partmvsatot=new Hashtable();
		  	while(rs2.next())
		  	{
		  		partmvsatot.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
		  	}

	  //dpr expenduture
	   String dprchar="select sum(DPRCHARGES),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and  a.dprstatus is not null and partAAMount is not null and DPRCHARGES  is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	   if(sname!=null && !sname.equals("")){
			  partmvsa+=" and b.type_of_asset in("+sname+")";
			}
	   dprchar+= "  and c.programme_code in ("+pname+") ";
	  dprchar+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	  //stem.out.println("dprSVSSurvey******"+dprchar);
	  	 rs2=stmt3.executeQuery(dprchar);
	  	Hashtable dprcharexp=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprcharexp.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}
	  
	  
	  
	//DPR Survey Stage
	 

	  String dprSVSSurvey="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS='Survey Stage' and a.DPRSTATUS is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	 
	  if(sname!=null && !sname.equals("")){
		  dprSVSSurvey+=" and b.type_of_asset in("+sname+")";
		}
	
	
	
	  dprSVSSurvey+= "  and c.programme_code in ("+pname+") ";
	
	dprSVSSurvey+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	 //stem.out.println("dprSVSSurvey******"+dprSVSSurvey);
	  	 rs2=stmt3.executeQuery(dprSVSSurvey);
	  	Hashtable dprSVSSurv=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprSVSSurv.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}
	  //DPR Survey Stage
		  String dprMVSSurvey="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.DPRSTATUS='Survey Stage' and a.DPRSTATUS is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
		  if(sname!=null && !sname.equals("")){
			  dprSVSSurvey+=" and b.type_of_asset in("+sname+")";
			}
		
	  
	  dprMVSSurvey+= "  and c.programme_code in ("+pname+") ";
	  
	  dprMVSSurvey+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
		  		stmt3=conn.createStatement();
		  //stem.out.println("dprMVSSurvey******"+dprMVSSurvey);
		  	 rs2=stmt3.executeQuery(dprMVSSurvey);
		  	Hashtable dprMVSSurv=new Hashtable();
		  	while(rs2.next())
		  	{
		  		dprMVSSurv.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
		  	}
	  
	  
	  
	  
	  
	//DPR start of the completed
	 //DPR completed MVR
	  String dprMVScomple="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='1' and  a.DPRSTATUS='Completed/Approved' and a.DPRSTATUS is not null and  a.DPRCOMPDATE  is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	 
	  if(sname!=null && !sname.equals("")){
		  dprMVScomple+=" and b.type_of_asset in("+sname+")";
		}
	
	
	
	dprMVScomple+= "  and c.programme_code in ("+pname+") ";
	
	dprMVScomple+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	  //stem.out.println("dprMVStobepre******"+dprMVScomple);
	  	 rs2=stmt3.executeQuery(dprMVScomple);
	  	Hashtable dprMVScomp=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprMVScomp.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}



	  
	//DPR completed SVR
	  
	  String dprSVScomple="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS='Completed/Approved' and a.DPRSTATUS is not null and  a.DPRCOMPDATE  is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	 
	  if(sname!=null && !sname.equals("")){
		  dprSVScomple+=" and b.type_of_asset in("+sname+")";
		}

	
	dprSVScomple+= "  and c.programme_code in ("+pname+") ";
	
	
	
	dprSVScomple+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	  //stem.out.println("dprSVScomple******"+dprSVScomple);
	  	 rs2=stmt3.executeQuery(dprSVScomple);
	  	Hashtable dprSVScom=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprSVScom.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}

	  //DPR end of the completed
	  
	  
	  
	  
	  
	//DPR to be prepared START
	  
	  
  //DPR to be prepared MVR
	  String dprMVStobepre="select count(a.DPRSTATUS),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c  where a.work_id=b.work_id and b.CATEGORY_CODE='1'  and a.DPRSTATUS ='Estimate Stage' and a.DPRSTATUS is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";
	
	  if(sname!=null && !sname.equals("")){
		  dprMVStobepre+=" and b.type_of_asset in("+sname+")";
		}

	  
	  dprMVStobepre+= "  and c.programme_code in ("+pname+") ";
	  dprMVStobepre+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
	  		stmt3=conn.createStatement();
	  //stem.out.println("dprMVStobepre******"+dprMVStobepre);
	  	 rs2=stmt3.executeQuery(dprMVStobepre);
	  	Hashtable dprMVSTOBE=new Hashtable();
	  	while(rs2.next())
	  	{
	  		dprMVSTOBE.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	  	}

	  
	  
	  //DPR to be prepared SVR
	  

String dprSVStobepre="select count(a.DPRSTATUS),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.DPRSTATUS ='Estimate Stage' and a.DPRSTATUS is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE";

if(sname!=null && !sname.equals("")){
	dprSVStobepre+=" and b.type_of_asset in("+sname+")";
	}  
	  
	  dprSVStobepre+= "  and c.programme_code in ("+pname+") ";
	  dprSVStobepre+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
		stmt3=conn.createStatement();
//stem.out.println("dprSVStobepre******"+dprSVStobepre);
	 rs2=stmt3.executeQuery(dprSVStobepre);
	Hashtable dprSVSTOBE=new Hashtable();
	while(rs2.next())
	{
		dprSVSTOBE.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
	}


//END to be prepared 



//String dprsvs="SELECT  c.CIRCLE_OFFICE_CODE ,c.DIVISION_OFFICE_CODE,a.DPRSTATUS FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_division_office_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and  a.DPRSTATUS is not null  and substr(office_code,2,2)=c.CIRCLE_OFFICE_CODE  and substr(office_code,4,1)=DIVISION_OFFICE_CODE  and a.DPRCOMPDATE IS  NULL group by  c.circle_office_code,c.division_office_code,a.DPRSTATUS order by 1" ;
//String dprsvs="SELECT  count(*) FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_division_office_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and a.DPRCOMPDATE IS  NULL and a.DPRSTATUS is not null  and substr(office_code,2,2)='"+rs1.getString(3)+"' and substr(office_code,4,1)='"+rs1.getString(4)+"'  group by  c.circle_office_code,c.division_office_code order by 1";
 
//String dprsvs="SELECT  distinct substr(b.office_code,2,2),substr(b.office_code,4,1),a.DPRSTATUS FROM RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and b.CATEGORY_CODE='2'  and a.DPRCOMPDATE IS  NULL and a.DPRSTATUS is not null  and substr(office_code,2,2)='"+rs1.getString(3)+"' and substr(office_code,4,1)='"+rs1.getString(4)+"'  group by  substr(b.office_code,2,2),substr(b.office_code,2,2),a.DPRSTATUS order by 1;

  String  dprsvs="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='2' and a.dprstatus is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE ";
	
  
  if(sname!=null && !sname.equals("")){
	  dprsvs+=" and b.type_of_asset in("+sname+")";
		}  

  
  dprsvs+= "  and c.programme_code in ("+pname+") ";
   dprsvs+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1) order by 1";
   
   
       stmt3=conn.createStatement();
      //stem.out.println("dprsvs"+dprsvs);
	  rs2=stmt3.executeQuery(dprsvs);
	Hashtable dprSVS=new Hashtable();
	while(rs2.next())
	{
		dprSVS.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
		//String str=rs2.getString(1);
	}
	//if(rs2!=null)rs2.close();
	//if(stmt3!=null)stmt3.close();


String dprmvs="select count(*),substr(b.office_code,2,2),substr(b.office_code,4,1) from RWS_NOTGROUNDWORKS_STATUS_TBL a,rws_work_admn_tbl b,rws_programme_tbl c where a.work_id=b.work_id and b.CATEGORY_CODE='1' and a.dprstatus is not null and b.PROGRAMME_CODE =c.PROGRAMME_CODE ";


if(sname!=null && !sname.equals("")){
	dprmvs+=" and b.type_of_asset in("+sname+")";
		}  



dprmvs+= "  and c.programme_code in ("+pname+") ";
	
dprmvs+=" group by  substr(b.office_code,2,2),substr(b.office_code,4,1)order by 1";
	stmt3=conn.createStatement();
    //stem.out.println("dprmvs***********************"+dprmvs);
	rs2=stmt3.executeQuery(dprmvs);
	Hashtable dprMVS=new Hashtable();
	while(rs2.next())
	{
		dprMVS.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1)); 
	}
	//if(rs2!=null)rs2.close();
//	if(stmt3!=null)stmt3.close();
//new works 
	String newWorksMVSQ="select substr(office_code,2,2),substr(office_code,4,1),count(*) FROM RWS_WORK_ADMN_TBL w,rws_programme_tbl c  where  (w.ADMIN_DATE >= '01-Apr-2012' and w.ADMIN_DATE < '01-Apr-2013') and work_cancel_dt is null and w.PROGRAMME_CODE=c.PROGRAMME_CODE and w.category_code='1' ";
		if(sname!=null && !sname.equals("")){
			newWorksMVSQ+=" and w.type_of_asset in("+sname+")";
				}  
	newWorksMVSQ+= "  and c.programme_code in ("+pname+") ";
	newWorksMVSQ+=" group by  substr(office_code,2,2),substr(office_code,4,1)  order by 1";
			stmt3=conn.createStatement();
	//stem.out.println("newWorksMVSQ"+newWorksMVSQ);
		 rs2=stmt3.executeQuery(newWorksMVSQ);
		Hashtable newWorksMVS=new Hashtable();
		while(rs2.next())
		{
			newWorksMVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
		}
	//	if(rs2!=null)rs2.close();
	//	if(stmt3!=null)stmt3.close();
	
	String newWorksSVSQ="select substr(office_code,2,2),substr(office_code,4,1),count(*) FROM RWS_WORK_ADMN_TBL w,rws_programme_tbl c  where  (w.ADMIN_DATE >= '01-Apr-2012' and w.ADMIN_DATE < '01-Apr-2013') and work_cancel_dt is null and w.PROGRAMME_CODE=c.PROGRAMME_CODE  and w.category_code='2'"; 
	
		if(sname!=null && !sname.equals("")){
			newWorksSVSQ+=" and w.type_of_asset in("+sname+")";
				}  
	newWorksSVSQ+= "  and c.programme_code in ("+pname+") ";
		
	newWorksSVSQ+="group by  substr(office_code,2,2),substr(office_code,4,1)  order by 1";
	
	//stem.out.println("newWorksSVSQ***********"+newWorksSVSQ);
			stmt3=conn.createStatement();
	////System.out.println("newWorksSVSQ"+newWorksSVSQ);
		 rs2=stmt3.executeQuery(newWorksSVSQ);
		Hashtable newWorksSVS=new Hashtable();
		while(rs2.next())
		{
			newWorksSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
		}
		//if(rs2!=null)rs2.close();
		//if(stmt3!=null)stmt3.close();

		
		

		//spill over works
		String spillOverMVSQ="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-2012' and  w.category_code='1' and  work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+pname+")  ";
		if(sname!=null && !sname.equals("")){
		          spillOverMVSQ+="and w.type_of_asset in("+sname+")";
		}
		spillOverMVSQ+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by  b.circle_office_code,b.division_office_code  order by 1";

		////System.out.println("spillOverMVS"+spillOverMVSQ);
				stmt3=conn.createStatement();
			 rs2=stmt3.executeQuery(spillOverMVSQ);
				Hashtable spillOverMVS=new Hashtable();
			while(rs2.next())
			{
				spillOverMVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
			}
			//if(rs2!=null)rs2.close();
		//	if(stmt3!=null)stmt3.close();


		String spillOverSVSQ="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-2012'  and  w.category_code='2' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  ";
		if(sname!=null && !sname.equals("")){
		          spillOverSVSQ+="and w.type_of_asset in("+sname+")";
		}
		spillOverSVSQ+=" and  w.programme_code in ("+pname+")  and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by  b.circle_office_code,b.division_office_code  order by 1";

		//System.out.println("spillOverSVSQ"+spillOverSVSQ);
				stmt3=conn.createStatement();
			 rs2=stmt3.executeQuery(spillOverSVSQ);
				Hashtable spillOverSVS=new Hashtable();
			while(rs2.next())
			{
				spillOverSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
			}
			//if(rs2!=null)rs2.close();
		//	if(stmt3!=null)stmt3.close();
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		




/***********************************End  ************************************/



String query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code  and  a.status <> 'UI' order by circle_office_code";
stmt2=conn.createStatement();
 rs1=stmt2.executeQuery(query);

String dname="";
int svs=0,mvs=0,svspre=0,mvspre=0,svscom=0,mvscom=0,svspart=0,mvspart=0,svspartclerence=0,mvspartclerence=0;
double dprex=0,gdprexpchar=0;
int gdsvs=0,gdmvs=0,gtot=0,gsvspartcle=0,gcom=0,gsur=0,svssur=0,gsvspart=0,gpre=0,mvssur=0,gdprSVSTOBEPREPA=0,gdprMVSTOBEPREPA=0,gdprsvscomp=0,gdprmvscomp=0,gdprsvssurv=0;
int gdprmvssurv=0,gsvsmvs=0,gnewWorksSVStot=0,gnewWorksMVStot=0,gnewsmvs=0,ss=0;
double rel1=0,grel1=0,relUpto=0,relCur=0,grelUpto=0,grelCur=0,relUptoSVS=0,relCurSVS=0,grelUptoSVS=0,grelCurSVS=0,partAMT=0,gpartaclerewncerallchrg=0;
double expUptoMVS=0,expCurSVS=0,expUptoSVS=0,expCurMVS=0,gexpUptoSVS=0,gexpCurSVS=0,gexpUptoMVS=0,gexpCurMVS=0,gpartaAMTtotal=0;
int totdprSVSTOBEPREPA=0,gpartatotal=0,svs1=0,mvs1=0,gpartaMVStotal=0,gmvssvspart=0,gpartasvsclerancedate=0,gpartamvsclerancedate=0;
int ggtot=0,gnewspillOverSVS=0,newspillOverSVS=0,newspillOverMVS=0,gnewspillOverMVS=0,gnewspill=0;

String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){
	//new works
	String newWorksSVStot="0";

    if((String)newWorksSVS.get(rs1.getString(3)+rs1.getString(4))!=null){
newWorksSVStot=(String)newWorksSVS.get(rs1.getString(3)+rs1.getString(4));
 }
	String newWorksMVStot="0";
  if((String)newWorksMVS.get(rs1.getString(3)+rs1.getString(4))!=null){
newWorksMVStot=(String)newWorksMVS.get(rs1.getString(3)+rs1.getString(4));
 }
//spill works 
	String spillworkssvs="0";
  if((String)spillOverSVS.get(rs1.getString(3)+rs1.getString(4))!=null){
spillworkssvs=(String)spillOverSVS.get(rs1.getString(3)+rs1.getString(4));

  }
	String spillworksmvs="0";
  if((String)spillOverMVS.get(rs1.getString(3)+rs1.getString(4))!=null){
spillworksmvs=(String)spillOverMVS.get(rs1.getString(3)+rs1.getString(4));
}




	//total DPR
	String  dsvs=(String)dprSVS.get(rs1.getString(3)+rs1.getString(4));
//	//System.out.println("dsvs****" +dsvs );
	//String dsvs=""+dprSVS.get(rs1.getString(3)+rs1.getString(4));
	String  dmvs=(String)dprMVS.get(rs1.getString(3)+rs1.getString(4));
	//TO BE SVS PREPARED 
	String  dprSVSTOBEPREPA=(String)dprSVSTOBE.get(rs1.getString(3)+rs1.getString(4));
	
	//TO BE MVS PREPARED 
	String  dprMVSTOBEPREPA=(String)dprMVSTOBE.get(rs1.getString(3)+rs1.getString(4));

	//SVS COMPLETED 
	String  dprsvscomp=(String)dprSVScom.get(rs1.getString(3)+rs1.getString(4));

	

	
	
	//MVS COMPLETED 
	String dprmvscomp=(String)dprMVScomp.get(rs1.getString(3)+rs1.getString(4));
	
	//dprSVSdprSurv
	String dprsvssurv=(String)dprSVSSurv.get(rs1.getString(3)+rs1.getString(4));
	
	//dprMVSdprSurv 
	String  dprmvssurv=(String)dprMVSSurv.get(rs1.getString(3)+rs1.getString(4));
	
	//dprchargesEXP 
	String  dprexpchar=(String)dprcharexp.get(rs1.getString(3)+rs1.getString(4));
	
	
	//patratotSSVS
	String  partatotal=(String)patratot.get(rs1.getString(3)+rs1.getString(4));
	//patratotSMVS   
	String  partaMVStotal=(String)partmvsatot.get(rs1.getString(3)+rs1.getString(4));
	//patratotSSVSandMVS amt
	String  partaAMTtotal=(String)partaamttot.get(rs1.getString(3)+rs1.getString(4));
	
	//PART A CLERENCE DATE 
	String  partasvsclerancedate=(String)partasvsclerance.get(rs1.getString(3)+rs1.getString(4));
	
	//patraclearence
	String  partamvsclerancedate=(String)partamvsclerence.get(rs1.getString(3)+rs1.getString(4));
	
	
	//patraclearence
	String partaclerewncerallchrg=(String)	partaclerallchrg.get(rs1.getString(3)+rs1.getString(4));

	
	  // stmt3=conn.createStatement();
	     // //System.out.println("dprsvs"+dprsvs);
		 rs2=stmt3.executeQuery(dprsvs);
		
		while(rs2.next())
		{
			dprSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
			
		}

	
	%>
<tr></tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<%////System.out.println(dname); 
}
else{
%>
<td  class=rptLabel></td>


<%} 
if(dprcharexp.get(rs1.getString(3)+rs1.getString(4))!=null){
dprex=(((Double.parseDouble((String)dprcharexp.get(rs1.getString(3)+rs1.getString(4)))))/100000);
}else{
dprex=0;
} 

%>

<td  class=rptLabel><%=rs1.getString(2) %></td>

<%
 newspillOverSVS=Integer.parseInt(spillworkssvs)+Integer.parseInt(newWorksSVStot);
////System.out.println("****newspillOverSVS*****"+newspillOverSVS);

 newspillOverMVS=Integer.parseInt(spillworksmvs)+Integer.parseInt(newWorksMVStot);
////System.out.println("****newspillOverMVS***"+newspillOverMVS);


	%>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_reportsdrill_rpt.jsp?cat=2&type=1&subType=1&dcode=<%=rs1.getString(3) %>&divcode=<%=rs1.getString(4) %>')"><%= newspillOverSVS %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_reportsdrill_rpt.jsp?cat=1&type=1&subType=2&dcode=<%=rs1.getString(3) %>&divcode=<%=rs1.getString(4) %>')"><%= newspillOverMVS %></td>
<td class=rptValue ><%=(newspillOverSVS+newspillOverMVS) %></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=2&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprSVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svs=(Integer.parseInt((String)dprSVS.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=2&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprMVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvs=(Integer.parseInt((String)dprMVS.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(svs+mvs) %></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=3&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=dprSVSSurv.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svssur=(Integer.parseInt((String)dprSVSSurv.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=3&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=dprMVSSurv.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvssur=(Integer.parseInt((String)dprMVSSurv.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(svssur+mvssur)%></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=4&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprSVSTOBE.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svspre=(Integer.parseInt((String)dprSVSTOBE.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=4&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprMVSTOBE.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvspre=(Integer.parseInt((String)dprMVSTOBE.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(svspre+mvspre)%></td>

<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=5&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprSVScom.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscom=(Integer.parseInt((String)dprSVScom.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=5&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%= dprMVScomp.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvscom=(Integer.parseInt((String)dprMVScomp.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(svscom+mvscom)%></td>
<td class=rptValue ><%=ndf.format(dprex) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=6&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=patratot.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svspart=(Integer.parseInt((String)patratot.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=6&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=partmvsatot.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvspart=(Integer.parseInt((String)partmvsatot.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(mvspart+svspart)%></td>
<td class=rptValue><%= partaAMTtotal==null || partaAMTtotal.equals("null")?"0":partaAMTtotal %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=7&subType=1&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=partasvsclerance.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svspartclerence=(Integer.parseInt((String)partasvsclerance.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><a href="#" onclick="viewWorks('rws_work_dpr_fin_report_drill_rpt.jsp?type=7&subType=2&dcode=<%=rs1.getString(3)%>&divcode=<%=rs1.getString(4) %>')"><%=partamvsclerence.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvspartclerence=(Integer.parseInt((String)partamvsclerence.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%=(svspartclerence+ mvspartclerence)%></td>
<td class=rptValue><%=(partaclerewncerallchrg==null || !partaclerewncerallchrg.equals("null")) ?0:ndf.format(partaclerewncerallchrg)%></td>







<% 
gdprexpchar+=dprex;
dprex=0;
gtot+=svs+mvs;
ggtot+=svs1+mvs1;

gsur+=svssur+mvssur;
gpre+=svspre+mvspre;
gcom+=svscom+mvscom;
gsvspart+=mvspart+svspart;
gsvspartcle+=svspartclerence+mvspartclerence;

gmvssvspart+=mvspart+svspart;

gnewsmvs+=(svs1+mvs1);
////System.out.println("gnewsmvstot******"+gnewsmvs);

svs1=0;
mvs1=0;
svssur=0;
mvssur=0;

//gnewWorksSVStot=0;
//gnewWorksMVStot=0;
gnewsmvs=0;
//gdsvs+=gdsvs+Integer.parseInt(dsvs);

grel1+=rel1;
svs=0;
svspart=0;
mvspart=0;
mvs=0;
//gnewWorksSVStot=0;
///gnewWorksMVStot=0;
svs1=0;
mvs1=0;
svspartclerence=0;
mvspartclerence=0;
svscom=0;
mvscom=0;
svspre=0;
mvspre=0;

//gnewsmvs=0;

//total 





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


gsvsmvs+=svs+mvs;

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

if(newWorksSVStot!=null && !newWorksSVStot.equals("")){
//	//System.out.println("gnewWorksSVStot"+gnewWorksSVStot);
	gnewWorksSVStot+=Integer.parseInt(newWorksSVStot);
	}


if(newWorksMVStot!=null && !newWorksMVStot.equals("")){
	gnewWorksMVStot+=Integer.parseInt(newWorksMVStot);
	}
ss+=gnewWorksMVStot+gnewWorksSVStot;

 gnewspillOverSVS+=newspillOverSVS;
 //System.out.println("gnewspillOverSVS*****"+gnewspillOverSVS);
 gnewspillOverMVS+=newspillOverMVS;
 gnewspill+=(newspillOverSVS+newspillOverMVS);
newspillOverMVS=0;
newspillOverSVS=0;
	}






//total
//gdsvs+=Integer.parseInt(dsvs);

%>
</tr>
<tr><td colspan=3 class=btext align=right>Total:</td>
<td class=btext><%=gnewspillOverSVS%></td>
<td class=btext><%=gnewspillOverMVS%></td>
<td class=btext><%=gnewspill%></td>
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