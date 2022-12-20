<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp"%>


<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");

//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
loggedUser.append(user.getUserId());
////////System.out.println("loggedUser:::::::::::::::::::::"+loggedUser.toString());
//String dcode="";

  StringBuffer pname=new StringBuffer();
  
  StringBuffer financialstartyr=new StringBuffer();

	
	if(request.getParameter("pname")!=null)
	{
	pname.append(request.getParameter("pname"));
	session.setAttribute("pname",pname);
	}
	else{
		pname.append(session.getAttribute("pname"));
	}

	if(request.getParameter("finyear")!=null)
	{
	financialstartyr.append(request.getParameter("finyear"));
	session.setAttribute("financialstartyr",financialstartyr);
	}
	else{
		financialstartyr.append(session.getAttribute("financialstartyr"));
	}
  	////System.out.println("financialyr>>>>>>>>>>>>>......"+financialstartyr.toString());
    //schemes
//String scheme="";
  StringBuffer scheme=new StringBuffer();
  scheme.append("");
  
  if(request.getParameterValues("scheme")!=null)
  {
    String[] schemes=request.getParameterValues("scheme");
    
   
	for(int i=0;i<schemes.length;i++)
	{
		
	 scheme.append(schemes[i]+",");
	}
	// System.out.println("scheme::12333"+scheme.substring(0,scheme.length()-1));
	//scheme.delete(0,scheme.length());
	

	//scheme.append(scheme.substring(0,scheme.length()-1));
	session.setAttribute("scheme",scheme);
	
}
  else{
	  scheme.append(session.getAttribute("scheme"));
	  
  }
   // System.out.println("scheme::"+scheme);
	//String startyr =financialstartyr.substring(0,4);
	
	StringBuffer startyr=new StringBuffer();
	startyr.append(financialstartyr.substring(0,4));
	 //System.out.println("startyr::"+startyr.toString());
	
	 
	 //String endyr =financialstartyr.substring(5,9);
	StringBuffer endyr=new StringBuffer();
	endyr.append(financialstartyr.substring(5,9));
	 //System.out.println("endyr::"+endyr.toString());
	 
	  StringBuffer programe=new StringBuffer();
    programe.append("");
	 if(request.getParameterValues("program")!=null)
  {
	String[] programes=request.getParameterValues("program");
   
	
	for(int i=0;i<programes.length;i++)
	{
	programe.append(programes[i]+",");
	}
	System.out.println("programe::"+programe);
	//programe.delete(0,programe.length());
	//programe.append(programe.substring(0,programe.length()-1));
	session.setAttribute("programe",programe);
	////System.out.println("programe::"+programe);
  }
	 else{
		 programe.append(session.getAttribute("programe"));
		  
	  }

StringBuffer dcode=new StringBuffer();

if(loggedUser.toString().substring(0,3).equals("col"))
{
	dcode=(StringBuffer)session.getAttribute("district");    
}

StringBuffer cYear=new StringBuffer();
cYear.append(w.getServerDate().substring(6,10));


StringBuffer currentMonth=new StringBuffer();
currentMonth.append(RwsUtils.getCurrentMont());



//String nextYear=String.valueOf(Integer.parseInt(cYear)+1);
StringBuffer nextYear=new StringBuffer();
nextYear.append(String.valueOf(Integer.parseInt(cYear.toString())+1));


//String prevmonth=RwsUtils.getPreviousMonth();
StringBuffer prevmonth=new StringBuffer();
prevmonth.append(RwsUtils.getPreviousMonth());




int nYear=Integer.parseInt(cYear.toString());
nYear+=1;



//String nextMonth=RwsUtils.getNextMonth();
StringBuffer nextMonth=new StringBuffer();
nextMonth.append(RwsUtils.getNextMonth()).toString();

//String phyprogrammeNames="";
StringBuffer phyprogrammeNames=new StringBuffer();
StringBuffer schemesNames=new StringBuffer();
prevmonth.toString().toUpperCase();
StringBuffer poptype=new StringBuffer();
if(request.getParameter("poptype")!=null && !request.getParameter("poptype").equals("") && !request.getParameter("poptype").equals("ALL"))
{
	//System.out.println("anupama");
	poptype.append(request.getParameter("poptype"));
}
else
{
	poptype.append("ALL");
	}

//System.out.println("poptype--"+poptype);
%>
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
function fnValidate(){
	//alert("Fsdfd");

	
	document.getElementById('poptype').value='<%=poptype.toString() %>';
}

</script>
	<% 

    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##.#####");



	%>
	<head>
    
</head>
<body onload="fnValidate();">
	<form>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back &nbsp; </td>
	 
	</tr>  
	</table>
	</caption>
	  <tr  align="center" >
		
		<td class=rptLabel>Select Type:<font color="red">*</font>
		<select name="poptype" id="poptype" style="width:140px" onchange="this.form.submit()" >

			<option value="ALL">ALL</option>
			<option value="SC">SC</option>
			<option value="ST">ST</option>
			<option value="PLAIN">PLAIN</option>

				 </select></td>
								 </tr>
								
				
	</table>
					<table  width="80%" border=0 style="border-collapse:collapse"  align=center>
                                            
                                         
<tr >
		<td align="center" class="gridhdbg" colspan=22><font color="white"><b>Schemes - (Physical & Financial)<%=startyr.toString() %>-<%=endyr %></b></font></td>	
	</tr>		
		<tr >
		<td class="gridhdbg"  rowspan=4 align=center>Sl.No</td>
		<td class="gridhdbg"  rowspan=4 align=center>District</td>
		
		<td class="gridhdbg"  rowspan=1 colspan=6 align=center>Grounded Works</td>
<td class="gridhdbg"  align=center colspan=3  >Financial(<%=startyr.toString() %>-<%=endyr %>) <br></br><font color="red"><b>Amount In Lakhs.</b></font></td>
<td class="gridhdbg"  align=center colspan=11  >Physical (<%=startyr.toString() %>-<%=endyr %>) <br><font color="red"><b>Amount In Lakhs.</b></font></br></td>

</tr>

<tr>
<td class="gridhdbg"  align="center" rowspan=3 >No (Spill+New)</td>
<td class="gridhdbg"  rowspan=1 colspan=4 align=center>No.Of Habs</td>
<td class="gridhdbg"  rowspan=3 align=center>Bal Est Cost</td>

<td class="gridhdbg"  rowspan=3 align=center>Target</td>
<td class="gridhdbg"  rowspan=3 align=center>Releases Achievement</td>
<td class="gridhdbg"  rowspan=3 align=center>Percentage Achieved<br></br>(9/8)*100</td>

<td class="gridhdbg"  rowspan=1  colspan=5 align=center>Target</td>
<td class="gridhdbg"  rowspan=1 align=center colspan=5>Achievement</td>
<td class="gridhdbg"  rowspan=3 align=center>Percentage Achieved</td>


</tr>
<tr>

<td class="gridhdbg"  align="center" rowspan=2>FC</td>
<td class="gridhdbg"  align="center" rowspan=2>PC</td>
<td class="gridhdbg"  align="center" rowspan=2>QA</td>
<td class="gridhdbg"  align="center" rowspan=2>Total</td>
<td class="gridhdbg"  align="center" rowspan=2>Works</td>
<td class="gridhdbg"  align="center" rowspan=1 colspan=4>Habs</td>
<td class="gridhdbg"  align="center" rowspan=2>Works</td>
<td class="gridhdbg"  align="center" rowspan=1 colspan=4>Habs</td>




</tr>

<tr>
<td class="gridhdbg"  align="center" rowspan=1>FC</td>
<td class="gridhdbg"  align="center" rowspan=1>PC</td>
<td class="gridhdbg"  align="center" rowspan=1>QA</td>
<td class="gridhdbg"  align="center" rowspan=1>Total</td>

<td class="gridhdbg"  align="center" rowspan=1>FC</td>
<td class="gridhdbg"  align="center" rowspan=1>PC</td>
<td class="gridhdbg"  align="center" rowspan=1>QA</td>
<td class="gridhdbg"  align="center" rowspan=1>Total</td>

</tr>


<tr><td class="gridhdbg"   align=center>1</td>
<td class="gridhdbg"   align=center>2</td>
<td class="gridhdbg"   align=center>3</td>
<td class="gridhdbg"   align=center>4</td>
<td class="gridhdbg"   align=center>5</td>
<td class="gridhdbg"   align=center>6</td>
<td class="gridhdbg"   align=center>7</td>
<td class="gridhdbg"   align=center>8</td>
<td class="gridhdbg"   align=center>9</td>
<td class="gridhdbg"   align=center>10</td>
<td class="gridhdbg"   align=center>11</td>
<td class="gridhdbg"   align=center>12</td>
<td class="gridhdbg"   align=center>13</td>
<td class="gridhdbg"   align=center>14</td>
<td class="gridhdbg"   align=center>15</td>
<td class="gridhdbg"   align=center>16</td>
<td class="gridhdbg"   align=center>17</td>
<td class="gridhdbg"   align=center>18</td>
<td class="gridhdbg"   align=center>19</td>
<td class="gridhdbg"   align=center>20</td>
<td class="gridhdbg"   align=center>21</td>
<td class="gridhdbg"   align=center>22</td>

		</tr>




<%

 Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt12=null;
ResultSet rs1=null,rs3=null,rs2=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null;
StringBuffer programmeNames=new StringBuffer();
int count=1;
  try{
	 
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
	  
	 
	  StringBuffer qry1=new StringBuffer();
	  	
	  
	  qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id  in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) >='01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and w.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code ");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and w.WORK_ID NOT IN(SELECT distinct  hb.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE  HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and w.WORK_ID NOT IN(SELECT distinct  hb.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd  WHERE   HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  w.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE  HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	  
	  qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
	  qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");
     // System.out.println("spillOverWorks"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
	  
	  
	  stmt2=conn.createStatement();
	  qry1.append("select sum(BILL_AMOUNT_CENTRAL ),substr(a.work_id,5,2) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and bank_send_date>='01-APR-"+startyr.toString()+"' and bank_send_date<'31-MAR-"+endyr.toString()+"' and txid is not null ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and a.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code ");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and a.WORK_ID NOT IN(SELECT distinct  hb.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE  HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and a.WORK_ID NOT IN(SELECT distinct  hb.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd  WHERE   HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  a.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE  HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	  
	  qry1.append("and b.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
	  qry1.append(" and  b.programme_code in ("+programe.substring(0,programe.length()-1)+") 	");
	  qry1.append("  group by substr(a.work_id,5,2)");
	  System.out.println("central amount"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	 
	  	Hashtable centralbills=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		centralbills.put(rs2.getString(2),rs2.getString(1));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
	  
	  
	  stmt2=conn.createStatement();
	  qry1.append("select sum(BILL_AMOUT_STATE ),substr(a.work_id,5,2) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and state_send_date>'17-APR-"+startyr.toString()+"' and state_send_date<'31-MAR-"+endyr.toString()+"' and state_txid is not null");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and a.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code ");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and a.WORK_ID NOT IN(SELECT distinct hb.work_id FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE   HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and a.WORK_ID NOT IN(SELECT distinct hb.work_id FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE   HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  a.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE   HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	  qry1.append(" and b.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
	  qry1.append(" and  b.programme_code in ("+programe.substring(0,programe.length()-1)+") ");
	  qry1.append("  group by substr(a.work_id,5,2)");
	System.out.println("state amount"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
     
	  	Hashtable statebills=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		statebills.put(rs2.getString(2),rs2.getString(1));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
	  
	  
	  
	  
	  stmt2=conn.createStatement();
	  qry1.append("select nvl(sum(t.BAL_EST_COST),0),substr(t.work_id,5,2) from  rws_target_works_tbl t  where work_id is not null   ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and work_id  in (select distinct t.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd,rws_target_works_tbl t where ah.hab_code=hd.hab_code and ah.work_id=t.work_id");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  t.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	  
	  qry1.append("and  substr(work_id,1,2) in ("+programe.substring(0,programe.length()-1)+") ");
	  qry1.append("and  substr(work_id,7,2) in ("+scheme.substring(0,scheme.length()-1)+") ");
	  qry1.append("  group by substr(work_id,5,2)");
	// System.out.println("financila Target amount"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	 
	  	Hashtable fintagetestcost=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		fintagetestcost.put(rs2.getString(2),rs2.getString(1));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
	  
	  
	  
	  stmt2=conn.createStatement();
	  qry1.append("select count(t.work_id),substr(t.work_id,5,2) from  rws_target_works_tbl t  where work_id is not null  ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and work_id  in (select distinct t.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd,rws_target_works_tbl t where ah.hab_code=hd.hab_code and ah.work_id=t.work_id");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and t.WORK_ID NOT IN(SELECT distinct  t.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  t.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,rws_target_works_tbl t WHERE  hb.work_id=t.work_id and HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	  qry1.append("and  substr(work_id,1,2) in ("+programe.substring(0,programe.length()-1)+") ");
	  qry1.append("and  substr(work_id,7,2) in ("+scheme.substring(0,scheme.length()-1)+") ");
	  qry1.append("  group by substr(work_id,5,2)");
	// System.out.println("target works"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	 
	  	Hashtable phyworkss=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		phyworkss.put(rs2.getString(2),rs2.getString(1));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0, qry1.length());
	  
	  
	  
		/*
		        Grounded Works and their sanction amount
		*/
		
		
		stmt2=conn.createStatement();
		
		qry1.append("select d.dcode,count(distinct w.work_id),sum(w.SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,RWS_WORK_COMMENCEMENT_TBL  com  where  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id  and com.GROUNDING_DATE is not null and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and w.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and W.WORK_ID NOT IN(SELECT   HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and W.WORK_ID NOT IN(SELECT   HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
		qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		qry1.append("and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");
		

	  	//System.out.println("spillOverGroundWorks"+qry1.toString());
	  	 rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksGroundedHash=new Hashtable();
	  	while(rs2.next())
	  	{
	  		  	
	  		spillOverWorksGroundedHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0,qry1.length());
	  
	  
	  
	  stmt2=conn.createStatement();
	 	 
		qry1.append("select d.dcode,count(distinct w.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, RWS_WORK_COMMENCEMENT_TBL  com  where w.work_id =com.work_id  and com.GROUNDING_DATE is not null and   (w.ADMIN_DATE >= '01-Apr-"+startyr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+endyr.toString()+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null   ");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	  		qry1.append(" and w.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
	  		if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
			}
			else 
			{
				qry1.append(" and W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  W.WORK_ID NOT IN(SELECT HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			qry1.append(")");
		}
	 qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		 qry1.append("and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");
		 


		  //	System.out.println("newWorks"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable newGroundedWorksHash=new Hashtable();
		  	while(rs2.next())
		  	{
		  		  	
		  		newGroundedWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
	qry1.delete(0,qry1.length());
	
	///////////////////Grounded works Sanction Amount////////////////////////////////////
	
	
	stmt2=conn.createStatement();
	
	qry1.append("select d.dcode,count(distinct ah.work_id),sum(w.SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,RWS_WORK_COMMENCEMENT_TBL  com,rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd  where ah.hab_code=hd.hab_code and ah.work_id=w.work_id and   to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id  and com.GROUNDING_DATE is not null and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
	if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
  		qry1.append(" and w.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
  		if(poptype.toString().equals("SC"))
		{
			qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
		}
		else if(poptype.toString().equals("ST"))
		{
			qry1.append(" and ah.WORK_ID NOT IN(SELECT   HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
		}
		else 
		{
			qry1.append(" and ah.WORK_ID NOT IN(SELECT   HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
			
	}
		qry1.append(")");
	}
	qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
	qry1.append("and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");
	

  //	System.out.println("GroundedWorks"+qry1.toString());
  	 rs2=stmt2.executeQuery(qry1.toString());
  
  	Hashtable GroundedWorks=new Hashtable();
  	while(rs2.next())
  	{
  		  	
  		GroundedWorks.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
  	
  	}
  
  
  
  if(rs2!=null)rs2.close();
  if(stmt2!=null)stmt2.close();
  qry1.delete(0,qry1.length());
  
  
  
  stmt2=conn.createStatement();
 	 
	qry1.append("select d.dcode,count(distinct w.work_id),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d, RWS_WORK_COMMENCEMENT_TBL  com,rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd  where ah.hab_code=hd.hab_code and ah.work_id=w.work_id and  w.work_id =com.work_id  and com.GROUNDING_DATE is not null and   (w.ADMIN_DATE >= '01-Apr-"+startyr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+endyr.toString()+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null   ");
	if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
  		qry1.append(" and w.work_id  in (select distinct ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
  		if(poptype.toString().equals("SC"))
		{
			qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
		}
		else if(poptype.toString().equals("ST"))
		{
			qry1.append(" and W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU  ");
		}
		else 
		{
			qry1.append(" and W.WORK_ID NOT IN(SELECT  HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  W.WORK_ID NOT IN(SELECT HB.WORK_ID FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
			
	}
		qry1.append(")");
	}
 qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
	 qry1.append("and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");
	 


	  	//System.out.println("newWorks"+qry1.toString());
	  	 rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable newgroundedworks=new Hashtable();
	  	while(rs2.next())
	  	{
	  		  	
	  		newgroundedworks.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
qry1.delete(0,qry1.length());	  
	  
//////////////////////////////////////////////
		stmt2=conn.createStatement();
		
		qry1.append("select d.dcode,count(w.work_id)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl hb ,RWS_WORK_COMMENCEMENT_TBL com   where  hb.work_id=w.work_id and to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
		qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		qry1.append("and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");

	 // 	System.out.println("spill all works"+qry1.toString());
	  	 rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillallworks=new Hashtable();
	  	while(rs2.next())
	  	{
	  		  	
	  		spillallworks.put(rs2.getString(1),rs2.getString(2));
	  	
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
	  if(stmt2!=null)stmt2.close();
	  qry1.delete(0,qry1.length());
	  
	  
	  
	
	  
	  
	  
		/*
        Grounded Works and their sanction amount
*/


stmt2=conn.createStatement();

qry1.append("select d.dcode,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl hb ,RWS_WORK_COMMENCEMENT_TBL com,rws_habitation_directory_tbl hd   where hb.hab_code=hd.hab_code and hb.work_id=w.work_id and  com.GROUNDING_DATE is not null and   hd.coverage_status IN('PC1','PC2','PC3','PC4') and to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
if(poptype.toString().equals("SC"))
{
	qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
}
else if(poptype.toString().equals("ST"))
{
	qry1.append(" and hb.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU   ");
}
else 
{
	qry1.append(" and hb.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  hb.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
	
}

}

qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");

	//System.out.println("spillOverGroundHabs"+qry1.toString());
	 rs2=stmt2.executeQuery(qry1.toString());

	Hashtable spillOverGroundedHabsHash=new Hashtable();
	while(rs2.next()){
		  		
		spillOverGroundedHabsHash.put(rs2.getString(1),rs2.getString(2));
	}



if(rs2!=null)rs2.close();
if(stmt2!=null)stmt2.close();
qry1.delete(0,qry1.length());




stmt2=conn.createStatement();

qry1.append("select d.dcode,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl hb ,RWS_WORK_COMMENCEMENT_TBL com,rws_habitation_directory_tbl hd   where hb.hab_code=hd.hab_code and hb.work_id=w.work_id and  hd.coverage_status ='NSS' and to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
	//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
if(poptype.toString().equals("SC"))
{
	qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
}
else if(poptype.toString().equals("ST"))
{
	qry1.append(" and hb.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU   ");
}
else 
{
	qry1.append(" and hb.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  hb.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
	
}

}
qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");

	//System.out.println("totQA"+qry1.toString());
	 rs2=stmt2.executeQuery(qry1.toString());

	Hashtable totQA=new Hashtable();
	while(rs2.next()){
		  		
		totQA.put(rs2.getString(1),rs2.getString(2));
	}



if(rs2!=null)rs2.close();
if(stmt2!=null)stmt2.close();
qry1.delete(0,qry1.length());

stmt2=conn.createStatement();
qry1.append("select d.dcode,count(hd.hab_code)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl hb ,RWS_WORK_COMMENCEMENT_TBL com,rws_habitation_directory_tbl hd   where hb.hab_code=hd.hab_code and hb.work_id=w.work_id and  hd.coverage_status ='FC' and to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"'    and  w.work_id=com.work_id   and   substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
		//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
	if(poptype.toString().equals("SC"))
	{
		qry1.append("  and (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU  ");
	}
	else if(poptype.toString().equals("ST"))
	{
		qry1.append(" and hb.hab_code  NOT IN(SELECT distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,RWS_WORK_ADMN_TBL W,RWS_WORK_COMMENCEMENT_TBL com WHERE HB.HAB_CODE =HD.HAB_CODE and hb.work_id =w.work_id  and w.work_id=com.work_id  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU   ");
	}
	else 
	{
		qry1.append(" and hb.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,RWS_WORK_ADMN_TBL W,RWS_WORK_COMMENCEMENT_TBL com  WHERE HB.HAB_CODE =HD.HAB_CODE  and hb.work_id =w.work_id  and w.work_id=com.work_id   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  hb.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd,RWS_WORK_ADMN_TBL W,RWS_WORK_COMMENCEMENT_TBL com WHERE HB.HAB_CODE =HD.HAB_CODE and w.work_id=hb.work_id  and w.work_id=com.work_id  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
		
}
	
}

qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");



	//System.out.println("totFC"+qry1.toString());
	 rs2=stmt2.executeQuery(qry1.toString());

	Hashtable totFC=new Hashtable();
	while(rs2.next()){
		  		
		totFC.put(rs2.getString(1),rs2.getString(2));
	}



if(rs2!=null)rs2.close();
if(stmt2!=null)stmt2.close();
qry1.delete(0,qry1.length());
		
		
	  
stmt2=conn.createStatement();
		
qry1.append("select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr.toString()+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp  where  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");

	  	//System.out.println("spillOverExpWor%%%%%ks"+qry1.toString());
	  
	  	rs2=stmt2.executeQuery(qry1.toString());
	  
	  	Hashtable spillOverWorksExpHash=new Hashtable();
	  	while(rs2.next()){
	  		  	
	  		spillOverWorksExpHash.put(rs2.getString(1),rs2.getString(2));
	  	}
	  
	  
	  
	  if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		qry1.delete(0,qry1.length());
		
		
		/**
		   Grounded Exp
		*/
		

		  
		stmt2=conn.createStatement();
				
		qry1.append("select d.dcode,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr.toString()+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d ,rws_work_exp_voucher_tbl exp,RWS_WORK_COMMENCEMENT_TBL  comm  where  w.work_id=comm.work_id and comm.GROUNDING_DATE is not null and  to_date(w.ADMIN_DATE) < '01-Apr-"+startyr.toString()+"' and  w.work_id=exp.work_id and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null ");
		qry1.append("and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode");

			 // 	System.out.println("spillOverExpWork@@@@@s"+qry1.toString());
			  
			  	rs2=stmt2.executeQuery(qry1.toString());
			  
			  	Hashtable spillOverGroundedWorksExpHash=new Hashtable();
			  	while(rs2.next()){
			  		  	
			  		spillOverGroundedWorksExpHash.put(rs2.getString(1),rs2.getString(2));
			  	}
			  
			  
			  
			  if(rs2!=null)rs2.close();
				if(stmt2!=null)stmt2.close();
		qry1.delete(0,qry1.length());
		//new works
			
		 stmt2=conn.createStatement();
		 	 
		 qry1.append("select d.dcode,count(*),sum(SANCTION_AMOUNT)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d  where  (w.ADMIN_DATE >= '01-Apr-"+startyr.toString()+"' and w.ADMIN_DATE < '01-Apr-"+endyr.toString()+"')  and  substr(W.WORK_ID,5,2)=D.DCODE   and WORK_CANCEL_DT  is null");
		 qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		 qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");

		  	//System.out.println("newWorks@@@@@@@@@@"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable newWorksHash=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		newWorksHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		qry1.delete(0, qry1.length());	
		
		
		
		
		
		
		 stmt2=conn.createStatement();
	 	 
		 qry1.append("select d.dcode,count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c   where w.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status='FC' and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id  in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) >='01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null");
		 if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
			if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and b.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
			}
			else 
			{
				qry1.append(" and b.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			
		}
		 
		 qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		 qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");

		// System.out.println("newWorks&&&&&&&FCCCC&&&&&&&"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable AllWorksHabs=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		AllWorksHabs.put(rs2.getString(1),rs2.getString(2));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		qry1.delete(0, qry1.length());	
		
		
		
		
		
		
		
		
 stmt2=conn.createStatement();
	 	 
		 qry1.append("select d.dcode,count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c   where w.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status IN('PC1','PC2','PC3','PC4') and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id  in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) >='01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null");
		 if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
			if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and b.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
			}
			else 
			{
				qry1.append(" and b.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			
		}
		 
		 qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		 qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");

			//System.out.println("newWorks!!!!!pccccc!!!!!!!"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable AllPCHabs=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		AllPCHabs.put(rs2.getString(1),rs2.getString(2));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		qry1.delete(0, qry1.length());	
			
		
		
 stmt2=conn.createStatement();
	 	 
		 qry1.append("select d.dcode,count(distinct b.hab_code)  FROM RWS_WORK_ADMN_TBL W ,rws_district_tbl d,rws_admn_hab_lnk_tbl b,rws_habitation_directory_tbl c   where w.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status='NSS' and substr(W.WORK_ID,5,2)=D.DCODE and w.work_id  in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and (to_date(DATE_OF_COMPLETION) >='01-Apr-"+startyr.toString()+"')) and WORK_CANCEL_DT  is null");
		 if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				//qry1.append(" and w.work_id  in (select ah.work_id from rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl hd where ah.hab_code=hd.hab_code");
			if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and b.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
			}
			else 
			{
				qry1.append(" and b.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			
		}
		 
		 qry1.append(" and w.type_of_asset in("+scheme.substring(0,scheme.length()-1)+")");
		 qry1.append(" and  w.programme_code in ("+programe.substring(0,programe.length()-1)+") group by d.dcode ");

		  	//System.out.println("newWorks########Qaaaa####3"+qry1.toString());
		  	 rs2=stmt2.executeQuery(qry1.toString());
		  
		  	Hashtable AllQAHabs=new Hashtable();
		  	while(rs2.next()){
		  		  	
		  		AllQAHabs.put(rs2.getString(1),rs2.getString(2));
		  	}
		  
		  
		  
		  if(rs2!=null)rs2.close();
			if(stmt2!=null)stmt2.close();
		qry1.delete(0, qry1.length());	
			
		
		
		
		
		
		
		
		
		
			
		
		
	  stmt2=conn.createStatement();
	  Hashtable svsCovhabsHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,count(*) from rws_work_admn_tbl a,rws_work_comp_hab_lnk_tbl b,rws_district_tbl d,rws_complete_hab_view ch  where ch.panch_code=b.hab_code and a.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null and to_date(date_of_completion,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' ) and a.WORK_CANCEL_DT is null  and  a.type_of_asset in('01','02','03')   and a.work_id=b.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.substring(0,programe.length()-1)+") group by d.dcode,d.dname order by d.dcode");
	 // System.out.println("Q1:"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  while(rs2.next()){
		  
		  svsCovhabsHash.put(rs2.getString(1),rs2.getString(3));
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  qry1.delete(0,qry1.length());
	 
	  
	  
	  
	  stmt4=conn.createStatement();
	  Hashtable svsTotExpHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,(sum(voucher_Amt)/100000)  from rws_work_admn_tbl a,rws_district_tbl d, rws_work_exp_voucher_tbl v  where  a.WORK_CANCEL_DT is null     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.substring(0,programe.length()-1)+") and to_date(v.voucher_dt,'dd/mm/yy')>='01-APR-"+startyr.toString()+"' and  to_date(v.voucher_dt,'dd/mm/yy')<'01-APR-"+endyr.toString()+"'  group by d.dcode,d.dname order by d.dcode");
	  
	  // System.out.println("exp.achiv....:"+qry1.toString());
	  rs4=stmt4.executeQuery(qry1.toString());
	  while(rs4.next())
	  {
		  svsTotExpHash.put(rs4.getString(1),rs4.getString(3));
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  qry1.delete(0, qry1.length());
	   
	  
	  
	  
	  stmt4=conn.createStatement();
	  Hashtable svsTotRelExpHash=new Hashtable();
	  qry1.append("select d.dcode,d.dname ,sum(case when to_date(BANK_SEND_DATE) >= '01-Apr-"+startyr.toString()+"' and to_date(BANK_SEND_DATE) < '01-Apr-"+endyr.toString()+"' and TXID  is not null  then (BILL_AMOUNT_CENTRAL)/100000  else 0 end),sum(case when to_date(STATE_SEND_DATE) >= '01-Apr-"+startyr.toString()+"'  and to_date(STATE_SEND_DATE) < '01-Apr-"+endyr.toString()+"' and STATE_TXID  is not null  then (BILL_AMOUT_STATE)/100000   else 0 end)  from rws_work_admn_tbl a,rws_district_tbl d, rws_bill_bank_bridge_tbl v  where  a.WORK_CANCEL_DT is null     and v.work_id=a.work_id and d.dcode=substr(a.work_id,5,2)  and substr(a.work_id,1,2) in ("+programe.substring(0,programe.length()-1)+")  group by d.dcode,d.dname order by d.dcode");
	  
	 //  System.out.println("exp.achiv....:"+qry1.toString());
	  rs4=stmt4.executeQuery(qry1.toString());
	  while(rs4.next())
	  {
		  svsTotRelExpHash.put(rs4.getString(1),rs4.getString(3)+"@"+rs4.getString(4));
		  
	  }
	  
	  
	  if(rs4!=null)
	  {
		  rs4.close();
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  qry1.delete(0, qry1.length());
	  
	  
	  
	  stmt2=conn.createStatement();
	  Hashtable targetahabsfcpcqa=new Hashtable();
	  qry1.append("select substr(a.work_id,5,2),count(distinct b.hab_code) from rws_target_works_tbl a,rws_admn_hab_lnk_tbl b,RWS_HABITATION_DIRECTORY_TBL C where a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status='FC' and  a.work_id is not null   ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
		
		if(poptype.toString().equals("SC"))
		{
			qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
		}
		else if(poptype.toString().equals("ST"))
		{
			qry1.append(" and b.hab_code  NOT IN(SELECT  distinct HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
		}
		else 
		{
			qry1.append(" and b.hab_code NOT IN(SELECT distinct  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT distinct hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
			
	}
		
		
	}
	  
	  qry1.append(" group by substr(a.work_id,5,2) ");
	  
	  
	// System.out.println("Q1:fc"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  while(rs2.next()){
		  
		  targetahabsfcpcqa.put(rs2.getString(1),rs2.getString(2));
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  qry1.delete(0,qry1.length());
	  
	  
	  stmt2=conn.createStatement();
	  Hashtable targetpc=new Hashtable();
	  qry1.append("select substr(a.work_id,5,2),count(distinct b.hab_code) from rws_target_works_tbl a,rws_admn_hab_lnk_tbl b,RWS_HABITATION_DIRECTORY_TBL C where a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status in('PC1','PC2','PC3','PC4') and  a.work_id is not null   ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			
			if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and b.hab_code  NOT IN(SELECT   HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
			}
			else 
			{
				qry1.append(" and b.hab_code NOT IN(SELECT   hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			
			
		}
		  
		  qry1.append(" group by substr(a.work_id,5,2) ");
		  
	 // System.out.println("Q1:pc"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  while(rs2.next()){
		  
		  targetpc.put(rs2.getString(1),rs2.getString(2));
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  qry1.delete(0,qry1.length());
	  
	  
	  stmt2=conn.createStatement();
	  Hashtable targetQA=new Hashtable();
	  qry1.append("select substr(a.work_id,5,2),count(distinct b.hab_code) from rws_target_works_tbl a,rws_admn_hab_lnk_tbl b,RWS_HABITATION_DIRECTORY_TBL C where a.work_id=b.work_id and b.hab_code=c.hab_code and c.coverage_status='NSS' and  a.work_id is not null ");
	  if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			
			if(poptype.toString().equals("SC"))
			{
				qry1.append("  and (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_SC_POPU  ");
			}
			else if(poptype.toString().equals("ST"))
			{
				qry1.append(" and b.hab_code  NOT IN(SELECT   HB.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND (0.4)*(nvl(c.CENSUS_PLAIN_POPU,'0')+nvl(c.CENSUS_SC_POPU,'0')+nvl(c.CENSUS_ST_POPU,'0')+nvl(c.CENSUS_MINORITY_POPU,'0'))<= c.CENSUS_ST_POPU   ");
			}
			else 
			{
				qry1.append(" and b.hab_code NOT IN(SELECT   hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE   AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_SC_POPU ) AND  b.hab_code NOT IN(SELECT  hb.hab_code FROM rws_admn_hab_lnk_tbl hb ,rws_habitation_directory_tbl hd WHERE HB.HAB_CODE =HD.HAB_CODE  AND (0.4)*(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')+nvl(hd.CENSUS_MINORITY_POPU,'0'))<= hd.CENSUS_ST_POPU)  ");
				
		}
			
			
		}
		  
		  qry1.append(" group by substr(a.work_id,5,2) ");
	  
	 //System.out.println("Q1:nss"+qry1.toString());
	  rs2=stmt2.executeQuery(qry1.toString());
	  while(rs2.next()){
		  
		  targetQA.put(rs2.getString(1),rs2.getString(2));
		  
	  }
	  
	  if(rs2!=null)
	  {
		  rs2.close();
	  }
	  if(stmt2!=null){
		  stmt2.close();
	  }
	  qry1.delete(0,qry1.length());
	 
	 
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  qry1.append("select dcode,dname from rws_district_tbl   ");
	  if(dcode.toString()!=null && !dcode.toString().equals(""))
	  {
		  qry1.append(" where  dcode='"+dcode.toString()+"'");
	  }
	  qry1.append("order by dcode");
	 
	  rs3=stmt3.executeQuery(qry1.toString());
	 // System.out.println("main:"+qry1.toString());
	  double svsH=0,svsT=0;
	  double expUpto=0,expT=0,expCurrent=0,expTot=0,expTot1=0;
	  
	  StringBuffer  style=new StringBuffer();
	  
	  int styleCount=0,gnss=0,gpc=0,gfc=0,gtothabsphy=0,gtotspill=0,totspillpc=0,totspillfc=0,totspillnss=0,totspillhabs=0,totspillallhabs=0;
	  double d1=0,d2=0,d3=0;
	  double ghabper = 0;
	  double  svsHg=0.0,svsTg=0.0;
	  double gexpper = 0;
		 
		 Statement sst1=conn.createStatement();
		  //Statement sst=conn.createStatement();
//String deleteQuery="delete from rws_svs_graph_view_tbl WHERE TYPE='MVS'";
		  
	//	  sst.executeUpdate(deleteQuery);
		 
	int gtotgrndworks=0,gtotWorks=0,gnWorkCount=0,gphyTarget=0,gPhyAch=0,gtargetWorks=0,gspillHabs=0,totworks=0,tottartfc=0,tottartNSs=0,gphytarw=0,tottartpcs=0,totalqa=0,tothabs=0,totspill=0,totalfc=0,gtothabs=0,gtotalfc=0,gtotalqa=0;
	double gtotalBalEst=0,ggroundedBalEst=0,gtotpreachifin=0,totper=0,gbalestcostfin=0;
	double gfinTarget=0,gfinAch=0,grelAch=0,totrel=0;
	double gtotWeightage=0,totfinAchPer=0;
	StringBuffer key=new StringBuffer();
	StringBuffer expStr=new StringBuffer();
	StringBuffer str=new StringBuffer();
	StringBuffer spillWorks=new StringBuffer();
	StringBuffer a1=new StringBuffer();
	StringBuffer a2=new StringBuffer();
	StringBuffer nWorks=new StringBuffer();
	StringBuffer finWorksHabs=new StringBuffer();
	StringBuffer svsTargetHabs=new StringBuffer();
	StringBuffer svsTotExp=new StringBuffer();
	StringBuffer qry2=new StringBuffer();
	StringBuffer svsTotRelExp=new StringBuffer();
	StringBuffer cenrel=new StringBuffer();
	StringBuffer staterel=new StringBuffer();
	StringBuffer targetpcs=new StringBuffer();
	StringBuffer targetfc=new StringBuffer();
	StringBuffer targetnss=new StringBuffer();
	StringBuffer totqa=new StringBuffer();
	StringBuffer totfc=new StringBuffer();
	StringBuffer finestcost=new StringBuffer();
	StringBuffer phyworkstarget=new StringBuffer();
	StringBuffer targethabsphy=new StringBuffer();
	StringBuffer spillworksall=new StringBuffer();
	StringBuffer spillhab=new StringBuffer();
	StringBuffer spillpchab=new StringBuffer();
	StringBuffer spillqahab=new StringBuffer();
	StringBuffer newhabs=new StringBuffer();
	StringBuffer tagetpchabs=new StringBuffer();
	StringBuffer tagetnsshabs=new StringBuffer();
	
	StringBuffer grndworks=new StringBuffer();
	StringBuffer newgrndworks=new StringBuffer();
	
	
	
	  while(rs3.next())
	  {
		  double exp=0,spillSanctionedAmt=0,newSanctionedAmt=0,finTarget=0,phyAchPer=0,finAchPer=0,spillGroundedAmount=0,newGroundedAmount=0,groundedexp=0	;
		  int sWorkCount=0,nWorkCount=0,phyTarget=0,works=0,phytarw=0,spillpc=0,spillfc=0,spillnss=0;
		  int spilGrounded=0,newGrounded=0,spillHabs=0,tartpcs=0,tartNSs=0,tartfc=0,nss=0,pc=0,fc=0,tothabsphy=0,grounded=0,ngrounded=0;
		  double bankamt=0,paoamt=0;
		  double cenamt=0,staamt=0,tot=0,balestcostfin=0,totpreachifin=0;
		  
		//  finTarget=(Double.parseDouble(rs3.getString(4))+Double.parseDouble(rs3.getString(5)));
		//  phyTarget=(Integer.parseInt(rs3.getString(3))+Integer.parseInt(rs3.getString(6)));
		  
		 //String key=rs3.getString(1);
		  key.delete(0, key.length());
		  key.append(rs3.getString(1));
		  
		  if(spillOverWorksExpHash.get(key.toString())!=null)
		  {
			  //////System.out.println("111111111111");
			  expStr.delete(0,expStr.length());
			  expStr.append(spillOverWorksExpHash.get(key.toString()));
			  if(expStr.toString()!=null && !expStr.toString().equals("null"))
			  {
			   exp=Double.parseDouble(expStr.toString());
			  }
			  
		  }
		  
		 if(spillOverGroundedWorksExpHash.get(key.toString())!=null)
		 {
			
			  expStr.delete(0,expStr.length());
			  expStr.append(spillOverGroundedWorksExpHash.get(key.toString()));
			  if(expStr.toString()!=null && !expStr.toString().equals("null"))
			  {
			  groundedexp=Double.parseDouble(expStr.toString());
			  }
			  
		  }
		  
		
         if(spillOverGroundedHabsHash.get(key.toString())!=null)
         {
        	 //////System.out.println("13333333333333333");
        	 str.delete(0,str.length());
        	 str.append(spillOverGroundedHabsHash.get(key.toString()));
        	 spillHabs=Integer.parseInt(str.toString());
         	 
         }
         

         if(totQA.get(key.toString())!=null)
         {
        	 //////System.out.println("13333333333333333");
        	 totqa.delete(0,totqa.length());
        	 totqa.append(totQA.get(key.toString()));
        	 totalqa=Integer.parseInt(totqa.toString());
         	 
         }
         
          gtotalqa+=totalqa;
         
         if(totFC.get(key.toString())!=null)
         {
        	 //////System.out.println("13333333333333333");
        	 totfc.delete(0,totfc.length());
        	 totfc.append(totFC.get(key.toString()));
        	 totalfc=Integer.parseInt(totfc.toString());
         	 
         }
         
         tothabs=totalfc+spillHabs+totalqa;
         gtothabs+=tothabs;
         
         gtotalfc+=totalfc;
 
         if(spillallworks.get(key.toString())!=null)
         {
        	
        	 spillworksall.delete(0,spillworksall.length());
        	 spillworksall.append(spillallworks.get(key.toString()));
        	 totspill=Integer.parseInt(spillworksall.toString());
         	 
         }
         gtotspill+=totspill;
         
		
		
			if(spillOverWorksHash.get(key.toString())!=null )
			{
				//////System.out.println("444444444444444444");
				spillWorks.delete(0,spillWorks.length());
				spillWorks.append(spillOverWorksHash.get(key.toString()));
				String []aa=spillWorks.toString().split("@");
				
				if(aa[0]!=null && !aa[0].toString().equals("null") ){
					sWorkCount=Integer.parseInt(aa[0].toString());
				}
				if(aa[1]!=null && !aa[1].toString().equals("null")){
					spillSanctionedAmt=Double.parseDouble(aa[1].toString());
				}

			}
			
			if(newWorksHash.get(key.toString())!=null )
			{
				//////System.out.println("555555555555555555555");
				nWorks.delete(0,nWorks.length());
				nWorks.append(newWorksHash.get(key.toString()));
				String []aa=nWorks.toString().split("@");
				
				
				if(aa[0]!=null && !aa[0].toString().equals("null")){
					nWorkCount=Integer.parseInt(aa[0].toString());
				}
				if(aa[1]!=null && !aa[1].toString().equals("null")){
					newSanctionedAmt=Double.parseDouble(aa[1].toString());
				}

			}  
			
			
			
			
			
			spillhab.delete(0,spillhab.length());
			spillhab.append(AllWorksHabs.get(rs3.getString(1)));
			
			if(spillhab.toString()==null || spillhab.toString().equals("null"))
			{
				spillhab.delete(0,spillhab.length());
				spillhab.append("0");
			}
			//////System.out.println("svsExpupto:"+svsTotExp.toString());
			if(spillhab.toString()!=null || !spillhab.toString().equals("null"))
			{
				spillfc=Integer.parseInt(spillhab.toString());
			}
			else
			{
				spillfc=0;
			}
			
			totspillfc+=spillfc;
			
			
			spillpchab.delete(0,spillpchab.length());
			spillpchab.append(AllPCHabs.get(rs3.getString(1)));
			
			if(spillpchab.toString()==null || spillpchab.toString().equals("null"))
			{
				spillpchab.delete(0,spillpchab.length());
				spillpchab.append("0");
			}
			//////System.out.println("svsExpupto:"+svsTotExp.toString());
			if(spillpchab.toString()!=null || !spillpchab.toString().equals("null"))
			{
				spillpc=Integer.parseInt(spillpchab.toString());
			}
			else
			{
				spillpc=0;
			}
			
			totspillpc+=spillpc;
			
			spillqahab.delete(0,spillqahab.length());
			spillqahab.append(AllQAHabs.get(rs3.getString(1)));
			
			if(spillqahab.toString()==null || spillqahab.toString().equals("null"))
			{
				spillqahab.delete(0,spillqahab.length());
				spillqahab.append("0");
			}
			//////System.out.println("svsExpupto:"+svsTotExp.toString());
			if(spillqahab.toString()!=null || !spillqahab.toString().equals("null"))
			{
				spillnss=Integer.parseInt(spillqahab.toString());
			}
			else
			{
				spillnss=0;
			}
			
			
			
			
			totspillnss+=spillnss;
			
			
		
			totspillhabs=spillpc+spillnss+spillfc;
			
			
			totspillallhabs=totspillpc+totspillfc+totspillnss;
			
			
			
			
			


			
			
			if(spillOverWorksGroundedHash.get(key.toString())!=null )
			{
				//////System.out.println("6666666666666666666");
				spillWorks.delete(0,spillWorks.length());
				spillWorks.append(spillOverWorksGroundedHash.get(key.toString()));
				String []aa=spillWorks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					spilGrounded=Integer.parseInt(a1.toString());
				}
				
				a2.delete(0,a2.length());
				a2.append(aa[1]);
				if(a2.toString()!=null && !a2.toString().equals("null"))
				{
					spillGroundedAmount=Double.parseDouble(a2.toString());
				}
				
				//////System.out.println("spillGroundedAmount:"+spillGroundedAmount);
			}
			
			
			if(newGroundedWorksHash.get(key.toString())!=null )
			{
				//////System.out.println("7777777777777777771");
				nWorks.delete(0,nWorks.length());
				nWorks.append(newGroundedWorksHash.get(key.toString()));
				String []aa=nWorks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					newGrounded=Integer.parseInt(a1.toString());
				//	System.out.println("newGrounded"+newGrounded);
				}
				
				
				a2.delete(0,a2.length());
				a2.append(aa[1]);
				if(a2.toString()!=null && !a2.toString().equals("null"))
				{
					newGroundedAmount=Double.parseDouble(a2.toString());
				}
				//////System.out.println("newGroundedAmount:"+newGroundedAmount);
			}  
			////////////////Grounded Works/////////////////////////////////////
			
			if(GroundedWorks.get(key.toString())!=null )
			{
				
				grndworks.delete(0,grndworks.length());
				grndworks.append(GroundedWorks.get(key.toString()));
				String []aa=grndworks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					grounded=Integer.parseInt(a1.toString());
					
				}
				} 
			
			
			if(newgroundedworks.get(key.toString())!=null )
			{
				
				newgrndworks.delete(0,newgrndworks.length());
				newgrndworks.append(newgroundedworks.get(key.toString()));
				String []aa=newgrndworks.toString().split("@");
				
				a1.delete(0,a1.length());
				a1.append(aa[0]);
				if(a1.toString()!=null && !a1.toString().equals("null"))
				{
					ngrounded=Integer.parseInt(a1.toString());
					
				}
				} 
			
			int totgrndworks=ngrounded+grounded;
			
			 gtotgrndworks+=totgrndworks;
			
			///////////////////////////////////////////////////////////////////////
			double totalBalEst=(spillSanctionedAmt+newSanctionedAmt)-exp;
			double groundedBalEst=0;
			//if(spillGroundedAmount+newGroundedAmount>groundedexp)
		//	{
			// groundedBalEst=(spillGroundedAmount+newGroundedAmount)-groundedexp;
		//	}
			groundedBalEst=(spillGroundedAmount+newGroundedAmount);
			
			//////System.out.println("groundedBalEst:"+groundedBalEst);
			ggroundedBalEst+=groundedBalEst;
			gspillHabs+=spillHabs;
			
			gtotalBalEst+=totalBalEst;
			int totWorks=sWorkCount;
			gtotWorks+=totWorks;
			int targetWorks=spilGrounded+newGrounded;
		  
		  
			
		 svsTargetHabs.delete(0,svsTargetHabs.length());
		 svsTargetHabs.append(svsCovhabsHash.get(rs3.getString(1)));
		 if(svsTargetHabs.toString()==null || svsTargetHabs.toString().equals("null"))
		 { 
			 svsTargetHabs.delete(0,svsTargetHabs.length());
			 svsTargetHabs.append("0");
		 }
		 
		 svsH+=Integer.parseInt(svsTargetHabs.toString());
		 svsHg+=svsH;
		 
		 
		/******************************/
		
		
		 
		//if(rs3.getString(3)!=null)
		//{
		//	svsT+=Integer.parseInt(rs3.getString(3));
		//	svsTg+=svsT;
		//}
		//if(rs3.getString(4)!=null)
		//{
		//	expT+=Double.parseDouble(rs3.getString(4));
		//}
		
		
		/******************************************************/
		
				
/******************************************************/
		svsTotExp.delete(0,svsTotExp.length());
		svsTotExp.append(svsTotExpHash.get(rs3.getString(1)));
		
		if(svsTotExp.toString()==null || svsTotExp.toString().equals("null"))
		{
			svsTotExp.delete(0,svsTotExp.length());
			svsTotExp.append("0.0");
		}
		//////System.out.println("svsExpupto:"+svsTotExp.toString());
		if(svsTotExp.toString()!=null || !svsTotExp.toString().equals("null"))
		{
		 d3=Double.parseDouble(svsTotExp.toString());
		}
		else
		{
			d3=0;
		}
		
		////////////////////////Releases Achievement//////////////////////////
		
		
		svsTotRelExp.delete(0,svsTotRelExp.length());
		svsTotRelExp.append(svsTotRelExpHash.get(rs3.getString(1)));
		
		if(svsTotRelExp.toString()!=null && !svsTotRelExp.toString().equals("null"))
		{
			String []aa=svsTotRelExp.toString().split("@");
			
			if(aa[0].toString()!=null && !aa[0].toString().equals("null"))
			{
				bankamt=Double.parseDouble(aa[0].toString());
			}
			else
			{
				bankamt=0;
			}
			
			if(aa[1].toString()!=null && !aa[1].toString().equals("null"))
			{
				paoamt=Double.parseDouble(aa[1].toString());
			}
			else
			{
				paoamt=0;
			}
		}
		
		
		
		
		
		
		
		
		targethabsphy.delete(0,targethabsphy.length());
		targethabsphy.append(targetahabsfcpcqa.get(rs3.getString(1)));
		if(targethabsphy.toString()!=null && !targethabsphy.toString().equals("null"))
		{
				fc=Integer.parseInt(targethabsphy.toString());
			
		}
		else
		{
			fc=0;
		}
		
		gfc+=fc;
		
		
		
		tagetpchabs.delete(0,tagetpchabs.length());
		tagetpchabs.append(targetpc.get(rs3.getString(1)));
		if(tagetpchabs.toString()!=null && !tagetpchabs.toString().equals("null"))
		{
				pc=Integer.parseInt(tagetpchabs.toString());
			
		}
		else
		{
			pc=0;
		}
		
		gpc+=pc;
		
		
		
		
		tagetnsshabs.delete(0,tagetnsshabs.length());
		tagetnsshabs.append(targetQA.get(rs3.getString(1)));
		if(tagetnsshabs.toString()!=null && !tagetnsshabs.toString().equals("null"))
		{
			nss=Integer.parseInt(tagetnsshabs.toString());
			
		}
		else
		{
			nss=0;
		}
		
		gnss+=nss;
		
		
		
    tothabsphy=fc+pc+nss;
		
		gtothabsphy+=tothabsphy;
		
		
		
		//////System.out.println("svsRelsExpupto:"+bankamt+paoamt);
		
		cenrel.delete(0,cenrel.length());
		cenrel.append(centralbills.get(rs3.getString(1)));
		if(cenrel.toString()!=null && !cenrel.toString().equals("null"))
		{
				cenamt=Double.parseDouble(cenrel.toString());
				//System.out.println("cenamt@@@@@@@@@"+cenamt);
			
		}
		
		
		
		staterel.delete(0,staterel.length());
		staterel.append(statebills.get(rs3.getString(1)));
		if(staterel.toString()!=null && !staterel.toString().equals("null"))
		{
			staamt=Double.parseDouble(staterel.toString());
			//System.out.println("staamt@@@@@@@@@"+staamt);
			
		}
		
		
		finestcost.delete(0,finestcost.length());
		finestcost.append(fintagetestcost.get(rs3.getString(1)));
		if(finestcost.toString()!=null && !finestcost.toString().equals("null"))
		{
			balestcostfin=Double.parseDouble(finestcost.toString());
			
		}
		
		gbalestcostfin+=balestcostfin;
		
		
		//System.out.println("gbalestcostfin"+gbalestcostfin);
		totpreachifin=((balestcostfin/groundedBalEst)*100);
		
		phyworkstarget.delete(0,phyworkstarget.length());
		phyworkstarget.append(phyworkss.get(rs3.getString(1)));
		if(phyworkstarget.toString()!=null && !phyworkstarget.toString().equals("null"))
		{
			phytarw=Integer.parseInt(phyworkstarget.toString());
			
		}
		
		gphytarw+=phytarw;
		
		
		
		
		
		
		
		    
		    //String staamt=""+statebills.get(rs.getString(1));
		    //if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		
		   // System.out.println("cenamt"+cenamt);
		   // System.out.println("staamt"+staamt);
		     tot=(cenamt+staamt)/100000;
		   //  System.out.println("tot"+tot);
		     totrel+=tot;
		    
		//////////////////////////////////////////////////////////////////////
		
		expTot+=d3;
		
		expTot1+=bankamt+paoamt;
		double targetExp=0,targetHabs=0;
		double weightage=0,totWeightage=0,weightageFin=0;
		double totpertarget=0;
		
	//	if(rs3.getString(4)!=null)
		//{
		// targetExp=Double.parseDouble(rs3.getString(4));
		//}
		
		//if(rs3.getString(3)!=null)
		//{
		// targetHabs= Double.parseDouble(rs3.getString(3));
		//}
		
		int coveredhabs=Integer.parseInt(svsTargetHabs.toString());
		
		gfinTarget+=finTarget;
		gphyTarget+=phyTarget;
		
		gfinAch+=(bankamt+paoamt);
		grelAch+=bankamt+paoamt;
		gPhyAch+=coveredhabs;
		
		if((cenamt+staamt)>0)
		{
		finAchPer = ((cenamt+staamt) * 100/ groundedBalEst);
		}
		else
		{
			finAchPer=0;
		}
		
		
		////System.out.println("finAchPer:"+d3+"...."+groundedBalEst);
		if(coveredhabs>0)
		{
		 phyAchPer = ((double)coveredhabs * 100/ (double)spillHabs);
		}
		else
		{
			phyAchPer=0;
		}
		if(phyAchPer>0)
		{
	    weightage=(phyAchPer/ 100)*15;
		}
		else
		{
			weightage=0;
		}
	    if(finAchPer>0)
	    {
	    	weightageFin=(finAchPer/ 100)*15;
	    }
	    else
		{
	    	weightageFin=0;
		}
	    
	    
	    //System.out.println("totspillhabs"+totspillhabs);
	    //System.out.println("tothabsphy"+tothabsphy);
	    
	    totpertarget=((double)totspillhabs/(double)tothabsphy)*100;
	    
	  
	   
		
		//System.out.println("totpertarget:"+totpertarget);
		
		totWeightage=(weightage+weightageFin);
		gtotWeightage+=totWeightage;
		gtargetWorks+=targetWorks;
		
		
		 if(styleCount%2==0)
		 {   style.delete(0,style.length());
			 style.append("gridbg1");
		 }else
		 {   style.delete(0,style.length());
			 style.append("gridbg2");
		 }
		 styleCount++;
		   
		 
		  %>
		  
		   <tr>
		  <td class="<%=style.toString()  %>" style="text-align: left;"><%=count++ %></td>
		  <td class="<%=style.toString() %>"  style="text-align: left;"><%=rs3.getString(2) %></td>
		 
		<!-- <td class="<%=style.toString()  %>" style="text-align: right;" ><%=targetWorks %></td>-->
		 <td class="<%=style.toString()  %>" style="text-align: right;" ><%=totgrndworks %></td>
		
		<td class="<%=style.toString()  %>" style="text-align: right;" ><%=totalfc%></td>
		 <td class="<%=style.toString()  %>" style="text-align: right;" ><%=spillHabs%></td>
		<td class="<%=style.toString()  %>" style="text-align: right;" ><%=totalqa%></td>
		<td class="<%=style.toString()  %>" style="text-align: right;" ><%=tothabs%></td>
		<td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(groundedBalEst) %></td>
		  <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(balestcostfin) %></td>
		   <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(tot) %></td>
		   
		   <td class="<%=style.toString()  %>" style="text-align: right;" ><%=ndf.format(totpreachifin)%></td>
		   
		   
		  
		    <td class="<%=style.toString()  %>" style="text-align: right;" ><a href="#" onclick="viewWorks('rws_rfd_phy_fin_target_drill.jsp?mode=works&poptype=<%=poptype.toString()%>&dcode=<%=rs3.getString(1)%>&dname=<%=rs3.getString(2)%>&programe=<%=programe.substring(0,programe.length()-1)%>&scheme=<%=scheme.substring(0,scheme.length()-1)%>')"><%=phytarw%></a></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;" ><%=fc%></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;" ><%=pc%></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;" ><%=nss%></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;" ><%=tothabsphy%></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=totWorks %></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=spillfc %></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=spillpc %></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=spillnss %></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=totspillhabs%></td>
		    <td class="<%=style.toString()  %>" style="text-align: right;"><%=ndf.format(totpertarget)%></td>
		        
		        
		     
		  
		
		  
		  </tr>
		  <% 
		  
		  
	  }
	  double gFinPer=0,gPhyAcc=0,weightage=0,weightageFin=0;
	  
		
	  
	  
	    if(gfinAch>0)
	    {
		  gFinPer = (gfinAch * 100/ ggroundedBalEst);
	    }
	    else
	    {
	    	 gFinPer=0;
	    }
	    
	    
	    if(gPhyAch>0)
	    { 
	      gPhyAcc = ( (double)gPhyAch * 100/ (double)gspillHabs);
	    }
	    else
	    {
	    	gPhyAch=0;
	    }
	    
	    
	    if(gPhyAcc>0)
	    {  
	    weightage=(gPhyAcc/ 100)*15;
	    }
	    else
	    {
	    	weightage=0;
	    }
	    
	    
	    if(gFinPer>0)
	    { 
	      weightageFin=(gFinPer/ 100)*15;
	    }
	    else
	    {
	    	weightageFin=0;
	    }
		
	    
	    if((totrel)>0)
		{
	    	
		totfinAchPer = ((totrel) * 100/ ggroundedBalEst);
		
		}
		else
		{
			
			totfinAchPer=0;
		}
	    
	    gtotpreachifin=((gbalestcostfin/ggroundedBalEst)*100);
	    
	    totper=((double)totspillallhabs/(double)gtothabsphy)*100;
	  %>
	 
	  <tr><td  style="text-align: right;"  class="gridhdbg" colspan="2">Total </td>
	<!--  <td style="text-align: right;"  class="gridhdbg"  ><%=gtotWorks %></td>
	  <td class="gridhdbg" style="text-align: right;"><%=ndf.format(gtotalBalEst) %></td> -->
	  
	  
	  <td class="gridhdbg"  style="text-align: right;"><%=gtotgrndworks%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gtotalfc%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gspillHabs%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gtotalqa%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gtothabs%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(ggroundedBalEst) %></td>
	  
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gbalestcostfin)%></td>
	 	
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(totrel) %></td>
	  
	  <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(gtotpreachifin) %></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gphytarw%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gfc%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gpc%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gnss%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gtothabsphy%></td>
	  <td class="gridhdbg"  style="text-align: right;"><%=gtotWorks%></td> 
	  <td class="gridhdbg"  style="text-align: right;"><%=totspillfc%></td> 
	      <td class="gridhdbg"  style="text-align: right;"><%=totspillpc%></td> 
	     <td class="gridhdbg"  style="text-align: right;"><%=totspillnss%></td>
	     <td class="gridhdbg"  style="text-align: right;"><%=totspillallhabs%></td>
	       <td class="gridhdbg"  style="text-align: right;"><%=ndf.format(totper)%></td>
	     
	     
	     
	  
	
	    
	  
	  
	
	  
	  </tr>
	  
	 
	  
	  <% 
	 
	  
	  qry2.delete(0,qry2.length());
	  qry2.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+programe.substring(0,programe.length()-1)+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  while(rs4.next())
	  {
		  //programmeNames.delete(0, programmeNames.length());
		  programmeNames.append(rs4.getString(1));		  
		  programmeNames.append(",  ");
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  qry2.delete(0, qry2.length());
	  
      qry2.append("select programme_name ,programme_code from rws_programme_tbl where programme_code in ("+programe.substring(0,programe.length()-1)+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  
	  while(rs4.next())
	  {   
		  //phyprogrammeNames.delete(0, phyprogrammeNames.length());
		  phyprogrammeNames.append(rs4.getString(1));
		  phyprogrammeNames.append(",  ");
	  }
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  qry2.delete(0, qry2.length());
     
	  qry2.append("select TYPE_OF_ASSET_NAME  ,TYPE_OF_ASSET_code  from rws_asset_type_tbl where TYPE_OF_ASSET_code in ("+scheme.substring(0,scheme.length()-1)+") order by 2 ");
	  
	  stmt4=conn.createStatement();
	  rs4=stmt4.executeQuery(qry2.toString());
	  
	  while(rs4.next())
	  {   
		  //phyprogrammeNames.delete(0, phyprogrammeNames.length());
		  schemesNames.append(rs4.getString(1));
		  schemesNames.append(",");
	  } 
	  if(stmt4!=null){
		  stmt4.close();
	  }
	  if(rs4!=null){
		  rs4.close();
	  }
	  
  }catch(Exception e)
  {
  e.printStackTrace();
}finally

{
	 
}
  
  

 %>


 </table>  
 <table>


 <tr><td  style="text-align: left;"><font color="red"><b>Note:Schemes:</font><font color="green"><%=schemesNames.toString() %></font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Financial Grants:</font><font color="green"><%=programmeNames.toString()%></b></font></td></tr>
                                     <tr><td  style="text-align: left;"><font color="red"><b>Note:Physical Grants:</font><font color="green"><%=phyprogrammeNames.toString() %></b></font></td></tr>
                                     
                                     <tr><td style="text-align: left;"><font color="red"><b>Note:</b></font><font color="green"><b>Only Selected Works which are Identified by the Department Have been considered for Generating the report</b></font></td></tr>
      </table>
</body>
</html>


