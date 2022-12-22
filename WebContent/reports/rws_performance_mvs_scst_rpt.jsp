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
	
String subProg=request.getParameter("subProg");
String sub="00";
if(subProg!=null && subProg.equals("PLAIN")){
sub="01";
}else if(subProg!=null && subProg.equals("SC")){
sub="02";
} else if(subProg!=null && subProg.equals("ST")){
sub="03";
}

session.setAttribute("subProg",subProg);

    double aas=0;
           String pname="";
if(request.getParameter("pname")!=null){
pname=request.getParameter("pname");
session.setAttribute("pname",pname);
}

	if(request.getParameter("finyear")!=null){
	financialyr=request.getParameter("finyear");
	session.setAttribute("financialyr",financialyr);
	} else{
	financialyr=(String)session.getAttribute("financialyr");
	}
  

session.setAttribute("financialyr",financialyr);
String startyr =financialyr.substring(0,4);
	String endyr =financialyr.substring(5,9);
    String endyr1 =financialyr.substring(5,9);



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
	
	
	String[] programes=request.getParameterValues("program");
	
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	//System.out.println("programe::"+programe);
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
 


String prevmonth=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();

  java.util.Date d=new java.util.Date();
if(d.getMonth()>=3 && d.getMonth()  <=11){
endyr1=startyr;

}else {
endyr1=endyr;
}
if(startyr.equals(sysyear) && cmonth.equals("APR")){
   prevmonth=cmonth;
}


String dcode=request.getParameter("dcode");
String divCode=request.getParameter("divCode");

  if(dcode!=null && !dcode.equals("")){
  session.setAttribute("dcode",dcode);
  session.setAttribute("divCode",divCode);
}


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
   <tr><td class="bwborder" align="center"><font  color="red" ><b>Note:Based On the Physical  Completion date.</b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=35>PLAIN,SC,ST  General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>District</td>
<td class=btext rowspan=3>Division</td>
<td class=btext  align=center colspan=15 style="background-color:lightyellow">Spill Over Works<font color="red"><b>---(<%=subProg %>)</b></font></td>
<td class=btext colspan=13 align=center style="background-color:#d2b48c">New Works <font color="red"><b>---(<%=subProg %>)</b></font></td>
</tr>
<tr>
		<td class=btext align="center" style="background-color:lightyellow" >No.of Works</td>

		<td  class=btext align="center" style="background-color:lightyellow" rowspan=2>Est.Cost</td>
		<td  class=btext align="center" style="background-color:lightyellow" rowspan=2>Exp.Upto 31.3.<%=startyr %></td>
		<td class=btext align="center" style="background-color:lightyellow" rowspan=2>Bal Est.Cost as on 31.3.<%=startyr %><br>(5-6)</td>
 <td  class=btext align="center"style="background-color:lightyellow"  colspan=2>Releases During <br><%=financialyr %></td>	
		<td  class=btext align="center"style="background-color:lightyellow"  colspan=2>Expenditure During <br><%=financialyr %></td>	
		<td  class=btext align="center" style="background-color:lightyellow" colspan=2>No.of.Works Completed<br><%=financialyr %></td>
		<td  class=btext align="center" style="background-color:lightyellow" rowspan=2>Habs Sanctioned</td>	
<td  class=btext align="center" style="background-color:lightyellow" rowspan=2>Habs Covered Up to 31.3.<%=startyr  %></td>	
<td  class=btext align="center" style="background-color:lightyellow" rowspan=2>Balance Habs as on 31.3.<%= startyr %></td>	
<td  class=btext align="center" style="background-color:lightyellow" colspan=2>Habs Covered during <br><%=financialyr %></td>	
<td class=btext align="center" style="background-color:#d2b48c" >No.of Works</td>
		<td  class=btext align="center" style="background-color:#d2b48c" rowspan=2>Est.Cost</td>
<td  class=btext align="center" style="background-color:#d2b48c" colspan=2>Releases During <br><%=financialyr %></td>
		<td  class=btext align="center" style="background-color:#d2b48c" colspan=2>Expenditure During <br><%=financialyr %></td>	
		<td class=btext align="center" style="background-color:#d2b48c" rowspan=2>Bal Est.Cost </td>

		<td  class=btext align="center" style="background-color:#d2b48c" colspan=2>No.of.Works Completed <br><%=financialyr %></td>
		<td  class=btext align="center" style="background-color:#d2b48c" rowspan=2>Habs Sanctioned</td>	
<td  class=btext align="center" style="background-color:#d2b48c" colspan=2>Habs Covered during <br><%=financialyr %></td>	


		
	


</tr>
<tr>
<td rowspan=1 colspan=1 style="background-color:lightyellow" class=btext align="center">MVS</td>	
<td rowspan=1 colspan=1  style="background-color:lightyellow" class=btext align="center">Rel.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:lightyellow"  class=btext align="center">Rel. During (<%=cmonth %>)</td>
	<td rowspan=1 colspan=1  style="background-color:lightyellow" class=btext align="center">Exp.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:lightyellow"  class=btext align="center">Exp. During (<%=cmonth %>)</td>
	<td rowspan=1 colspan=1  style="background-color:lightyellow" class=btext align="center">Completed.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:lightyellow"  class=btext align="center">Completed. During (<%=cmonth %>)</td>

	<td rowspan=1 colspan=1  style="background-color:lightyellow" class=btext align="center">Covered.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:lightyellow"  class=btext align="center">Covered. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1 style="background-color:#d2b48c" class=btext align="center">MVS</td>	
<td rowspan=1 colspan=1  style="background-color:#d2b48c"  class=btext align="center">Rel.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:#d2b48c"   class=btext align="center">Rel. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1  style="background-color:#d2b48c"  class=btext align="center">Exp.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:#d2b48c"   class=btext align="center">Exp. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Completed.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Completed. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=1  style="background-color:#d2b48c" class=btext align="center">Covered.upto (<%=prevmonth %>)</td>
		<td rowspan=1 colspan=1 style="background-color:#d2b48c"  class=btext align="center">Covered. During (<%=cmonth %>)</td>

</tr>

<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center"  class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext >14</td><td align="center"  class=btext>15</td><td align="center" class=btext >16</td><td align="center"  class=btext>17</td><td align="center" class=btext >18</td><td align="center" class=btext >19</td><td align="center" class=btext >20</td><td align="center" class=btext>21</td><td align="center" class=btext>22</td>
<td align="center" class=btext>23</td>
<td align="center" class=btext>24</td>
<td align="center" class=btext>25</td>
<td align="center" class=btext>26</td>
<td align="center" class=btext>27</td>
<td align="center" class=btext>28</td>
<td align="center" class=btext>29</td>
<td align="center" class=btext>30</td>

</tr>


<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/




String newWorksSVSQ="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and w.category_code='1' and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
if(scheme!=null && !scheme.equals("")){
          newWorksSVSQ+="and w.type_of_asset in("+scheme+")";
}

newWorksSVSQ+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		Statement stmt3=conn.createStatement();
//System.out.println("newWorksSVSQ"+newWorksSVSQ);
	 ResultSet rs2=stmt3.executeQuery(newWorksSVSQ);
	Hashtable newWorksSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



	Hashtable popHash=(Hashtable)session.getAttribute("popHash");
   if(popHash==null || popHash.isEmpty()){
popHash=new Hashtable();
String popQuery="select a.hab_code,nvl(a.CENSUS_PLAIN_POPU,0),nvl(a.CENSUS_SC_POPU,0),nvl(a.CENSUS_ST_POPU,0) from rws_habitation_directory_tbl a where a.COVERAGE_STATUS <>'UI' ";
		stmt3=conn.createStatement();
	 rs2=stmt3.executeQuery(popQuery);
	while(rs2.next())
	{
		popHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4));
	}
	session.setAttribute("popHash",popHash);
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

}




	String newWorksCompQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1' ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery+="and w.type_of_asset in("+scheme+")";
}



newWorksCompQuery+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
System.out.println("New Works"+newWorksCompQuery);
	 rs2=stmt3.executeQuery(newWorksCompQuery);
	Hashtable newWorksComp=new Hashtable();
	while(rs2.next())
	{
		newWorksComp.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksCompQuery1="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery1+="and w.type_of_asset in("+scheme+")";
}


newWorksCompQuery1+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
////System.out.println("newWorksCompQuery1"+newWorksCompQuery1);
	 rs2=stmt3.executeQuery(newWorksCompQuery1);
	Hashtable newWorksComp1=new Hashtable();
	while(rs2.next())
	{
		newWorksComp1.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();






String newWorksCurExpQuery="select b.circle_office_code,b.division_office_code,sum(case when (to_date(voucher_dt)>= '01-"+cmonth+"-"+endyr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+endyr1+"') then voucher_Amt else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and  w.category_code='1'";
 if(scheme!=null && !scheme.equals("")){
          newWorksCurExpQuery+="and w.type_of_asset in("+scheme+")";
}

newWorksCurExpQuery+=" and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  group by  b.circle_office_code,b.division_office_code  order by 1";
		stmt3=conn.createStatement();
//System.out.println("newWorksCurExpQuery"+newWorksCurExpQuery);
	 rs2=stmt3.executeQuery(newWorksCurExpQuery);
	Hashtable newWorksCurExp=new Hashtable();
	while(rs2.next())
	{
		newWorksCurExp.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();









/*************************END ************************************************/





/******   Spil over Works *****************************************************/
String spillOverWorks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+")  ";

if(scheme!=null && !scheme.equals("")){
          spillOverWorks+="and w.type_of_asset in("+scheme+")";
}
 spillOverWorks+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

//System.out.println("spillOverWorks:"+spillOverWorks);
	Statement	stmt4=conn.createStatement();
	ResultSet rs3=stmt4.executeQuery(spillOverWorks);
		Hashtable spillOver=new Hashtable();
	while(rs3.next())
	{
		spillOver.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();






String spillOverSVSQ="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and  w.category_code='1' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  ";
if(scheme!=null && !scheme.equals("")){
          spillOverSVSQ+="and w.type_of_asset in("+scheme+")";
}


spillOverSVSQ+=" and  w.programme_code in ("+programe+")  and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

//System.out.println("spillOverSVSQ"+spillOverSVSQ);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverSVSQ);
		Hashtable spillOverSVS=new Hashtable();
	while(rs3.next())
	{
		spillOverSVS.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String spillOverComp="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp+="and w.type_of_asset in("+scheme+")";
}


 spillOverComp+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

////System.out.println("SpillComplete"+spillOverComp);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp);
		Hashtable spillOverCom=new Hashtable();
	while(rs3.next())
	{
		spillOverCom.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverComp1="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp1+="and w.type_of_asset in("+scheme+")";
}

 spillOverComp1+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

////System.out.println("SpillComplete1"+spillOverComp1);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp1);
		Hashtable spillOverCom1=new Hashtable();
	while(rs3.next())
	{
		spillOverCom1.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOverHabsCovered="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  w.category_code='1' and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverHabsCovered+="and w.type_of_asset in("+scheme+")";
}

 spillOverHabsCovered+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

//System.out.println("spillOverHabsCovered"+spillOverHabsCovered);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverHabsCovered);
		Hashtable spillOverHabsCov=new Hashtable();
	while(rs3.next())
	{
		spillOverHabsCov.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String spillExpCurrentMon="SELECT b.circle_office_code,b.division_office_code,sum(case when (to_date(voucher_dt)>= '01-"+cmonth+"-"+endyr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+endyr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillExpCurrentMon+="and w.type_of_asset in("+scheme+")";
}

spillExpCurrentMon+=" and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1"; 

//System.out.println("spillExpCurrentMon"+spillExpCurrentMon);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillExpCurrentMon);
		Hashtable spillOverExpCurMon=new Hashtable();
	while(rs3.next())
	{
		spillOverExpCurMon.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


//SELECT b.circle_office_code,b.division_office_code,sum(case when (to_date(BANK_SEND_DATE)> '01-Apr-2012' and to_date(BANK_SEND_DATE)< '01-OCT-2012') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>= '01-OCT-2012' and to_date(BANK_SEND_DATE)< '01-APR-2013') then BILL_AMOUNT_CENTRAL else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-2012'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in (01,02,18,23,32,48,49,51,53,58,59,60) and w.type_of_asset in(01,02,03,04,05,06,07,08,09,10,11,12) and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-2012')) group by  b.circle_office_code,b.division_office_code  order by 1
















/***********************************End  ************************************/

RwsReportsDAO rwsReportsDAO=new RwsReportsDAO();

String query="";
if(!loggedUser.equals(Constants.SEC_USER)){
if(dcode!=null && divCode!=null && !dcode.equals("") && !loggedUser.equals(Constants.GUEST)){
  if(divCode!=null && !divCode.equals("0")){
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' and a.division_office_code='"+divCode+"' order by circle_office_code ";
}else{
query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' order by circle_office_code ";
}
}else{

 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
}else{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
rs1=stmt2.executeQuery(query);
int  tnworws=0,tsworks=0,tspComleted=0,tnewWorksComp=0,shabc=0,nhabc=0,smvs=0,ssvs=0,nsvs=0,nmvs=0,ncovhabs=0,shabscov=0,tspComleted1=0,tnewWorksComp1=0,shabscov1=0,ncovhabs1=0,gncovhabs1=0;
double tsancAmount=0,tspSamAmount=0,expUpto=0,expCur=0,nexpUpto=0,nexpCur=0,sbal=0,nbal=0,gsbal=0,gnbal=0,spcur=0,gspcur=0,sbankUpto=0,spaoUpto=0,sbankCur=0,spaoCur=0,gsbankUpto=0,gsbankCur=0;
double nbankUpto=0,npaoUpto=0,nbankCur=0,npaoCur=0,gnbankUpto=0,gnbankCur=0;
int  gtnworws=0,gtsworks=0,gtspComleted=0,gtnewWorksComp=0,gshabc=0,gnhabc=0,gsmvs=0,gssvs=0,gnsvs=0,gnmvs=0,gncovhabs=0,gshabscov=0,gtspComleted1=0,gtnewWorksComp1=0,gshabscov1=0;
double gtsancAmount=0,gtspSamAmount=0,dexpUpto=0,dexpCur=0,dnexpUpto=0,dnexpCur=0,ncurexp=0,gncurexp=0;
String dname="";
String exp="",nexp="";
while(rs1.next()){



String spillOverMVSWorks="SELECT b.circle_office_code,b.division_office_code,w.work_id,w.sanction_amount  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and  w.category_code='1' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  ";
if(scheme!=null && !scheme.equals("")){
          spillOverMVSWorks+="and w.type_of_asset in("+scheme+")";
}
spillOverMVSWorks+=" and  w.programme_code in ("+programe+")  and w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' order by 1 ";
////System.out.println("spillOverMVSWorks"+spillOverMVSWorks);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverMVSWorks);
		Hashtable spillOverMVS=new Hashtable();
String ccode="",diCode="";
Statement ss=conn.createStatement();
 ResultSet rrs=null;
	while(rs3.next())
	{
      
     double sanctionAmount=Double.parseDouble(rs3.getString(4));
       double plainSancation=0;

         plainSancation=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,sanctionAmount);
		tspSamAmount+=plainSancation;

	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillExpQuery="SELECT b.circle_office_code,b.division_office_code,w.work_id,sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+endyr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and  w.category_code='1'  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillExpQuery+="and w.type_of_asset in("+scheme+")";
}

spillExpQuery+=" and   a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))  and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id  order by 1"; 

////System.out.println("spillExpQuery"+spillExpQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillExpQuery);
		
	while(rs3.next())
	{
exp=rs3.getString(4);
		String []aa=exp.split("@");
String a1=aa[0];
String a2=aa[1];
 double expUpto1=Double.parseDouble(a1)/100000;
 double expCur1=Double.parseDouble(a2)/100000;
     
  double plainExp=0;

         expUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,expUpto1);
   expCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,expCur1);
		expUpto1=0;expCur1=0;

	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

dexpUpto+=expUpto;

dexpCur+=expCur;


String spillRelBankQuery="SELECT b.circle_office_code,b.division_office_code,w.work_id,sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(BANK_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and  w.category_code='1' and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelBankQuery+="and w.type_of_asset in("+scheme+")";
}


spillRelBankQuery+=" and  a.TXID is not null and  a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id  order by 1"; 

////System.out.println("spillRelBankQuery"+spillRelBankQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelBankQuery);
		
	while(rs3.next())
	{
		
		String srelban=rs3.getString(4);
       String []aa=srelban.split("@");
String a1=aa[0];
String a2=aa[1];
 double sbankUpto1=Double.parseDouble(a1)/100000;
 double sbankCur1=Double.parseDouble(a2)/100000;

  sbankUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,sbankUpto1);
sbankCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,sbankCur1);

		sbankUpto1=0;sbankCur1=0;

	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillRelPaoQuery="SELECT b.circle_office_code,b.division_office_code,w.work_id,sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and  to_date(STATE_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(STATE_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_pao_bridge_det_TBL a where to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'   and a.work_id=w.work_id  and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1' and w.programme_code in ("+programe+") ";

if(scheme!=null && !scheme.equals("")){
          spillRelPaoQuery+="and w.type_of_asset in("+scheme+")";
}

spillRelPaoQuery+=" and   a.STATE_TXID  is not null and a.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"'))and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id  order by 1"; 

////System.out.println("spillRelPaoQuery"+spillRelPaoQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillRelPaoQuery);
		while(rs3.next())
	{
    String srelpao=rs3.getString(4);
if(srelpao!=null){
      String []aa=srelpao.split("@");
String a1=aa[0];
String a2=aa[1];
 double spaoUpto1=Double.parseDouble(a1)/100000;
 double spaoCur1=Double.parseDouble(a2)/100000;
	spaoUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,spaoUpto1);
	spaoCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,spaoCur1);
		spaoUpto1=0;spaoCur1=0;
}
		
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();




String spillHabsCover="SELECT distinct w.work_id    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c where w.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1' and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillHabsCover+="and w.type_of_asset in("+scheme+")";
}

 spillHabsCover+=" and   w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+startyr+"')) and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' "; 
////System.out.println("spillHabsCover"+spillHabsCover);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillHabsCover);
	while(rs3.next())
	{
		String work_id=rs3.getString(1);
		shabc+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"rws_admn_hab_lnk_tbl");
      
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();




String spillOverHabsCovered1="SELECT distinct w.work_id    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverHabsCovered1+="and w.type_of_asset in("+scheme+")";
}

 spillOverHabsCovered1+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-APR-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' "; 


//System.out.println("spillOverHabsCovered1:"+spillOverHabsCovered1);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverHabsCovered1);
	while(rs3.next())
	{
			String work_id=rs3.getString(1);
		shabscov+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"RWS_WORK_COMP_HAB_LNK_TBL");
		//spillOverHabsCov1.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spHabsCurrent="SELECT distinct w.work_id    FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where W.work_id=c.work_id and to_date(w.ADMIN_DATE) <'01-Apr-"+startyr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spHabsCurrent+="and w.type_of_asset in("+scheme+")";
}

 spHabsCurrent+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' "; 


//System.out.println("spHabsCurrent:"+spHabsCurrent);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spHabsCurrent);
	while(rs3.next())
	{
			String work_id=rs3.getString(1);
		shabscov1+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"RWS_WORK_COMP_HAB_LNK_TBL");
		//spillOverHabsCov1.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();




//New Works


	String newWorksEstCostQuery="select b.circle_office_code,b.division_office_code,w.work_id,w.sanction_amount FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1' ";
 if(scheme!=null && !scheme.equals("")){
          newWorksEstCostQuery+="and w.type_of_asset in("+scheme+")";
}


newWorksEstCostQuery+=" and w.programme_code in ("+programe+")  and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' "; 

		stmt4=conn.createStatement();
////System.out.println("New Works"+newWorksEstCostQuery);
	 rs3=stmt4.executeQuery(newWorksEstCostQuery);
	
	while(rs3.next())
	{

		 double sanctionAmount=Double.parseDouble(rs3.getString(4));
       double plainSancation=0;

         plainSancation=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,sanctionAmount);
		tsancAmount+=plainSancation;
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();




	String newWorksExpQuery="select b.circle_office_code,b.division_office_code,w.work_id,sum(case when to_date(voucher_dt)< '01-Apr-"+startyr+"' then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+startyr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+endyr1+"') then voucher_Amt else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_exp_voucher_tbl a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and  w.category_code='1'";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpQuery+="and w.type_of_asset in("+scheme+")";
}

newWorksExpQuery+=" and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id "; 
		stmt4=conn.createStatement();
////System.out.println("newWorksExpQuery"+newWorksExpQuery);
	 rs3=stmt4.executeQuery(newWorksExpQuery);
	while(rs3.next())
	{
		nexp=rs3.getString(4);
		String []aa=nexp.split("@");
		String a1=aa[0];
		String a2=aa[1];
		double nexpUpto1=Double.parseDouble(a1)/100000;
		double nexpCur1=Double.parseDouble(a2)/100000;

     
  double plainExp=0;

         nexpUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,nexpUpto1);
   nexpCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,nexpCur1);
		nexpUpto1=0;nexpCur1=0;
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


dnexpUpto+=nexpUpto;
dnexpCur+=nexpCur;




String newCurRelBankQuery="select b.circle_office_code,b.division_office_code,w.work_id,sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(BANK_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end)||'@'||sum(case when (to_date(BANK_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(BANK_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUNT_CENTRAL else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_bank_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and  w.category_code='1'";
 if(scheme!=null && !scheme.equals("")){
          newCurRelBankQuery+="and w.type_of_asset in("+scheme+")";
}

newCurRelBankQuery+=" and a.TXID  is not null and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id  and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id  order by 1"; 
		stmt4=conn.createStatement();
//System.out.println("newCurRelBankQuery"+newCurRelBankQuery);
	 rs3=stmt4.executeQuery(newCurRelBankQuery);
	while(rs3.next())
	{
			String srelban=rs3.getString(4);
       String []aa=srelban.split("@");
String a1=aa[0];
String a2=aa[1];
 double nbankUpto1=Double.parseDouble(a1)/100000;
 double nbankCur1=Double.parseDouble(a2)/100000;

  nbankUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,nbankUpto1);
nbankCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,nbankCur1);

		nbankUpto1=0;nbankCur1=0;
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String newCurRelpaoQuery="select b.circle_office_code,b.division_office_code,w.work_id,sum(case when (to_date(STATE_SEND_DATE)>= '01-APR-"+startyr+"' and to_date(STATE_SEND_DATE) < '01-"+cmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end)||'@'||sum(case when (to_date(STATE_SEND_DATE)>='01-"+cmonth+"-"+endyr1+"' and to_date(STATE_SEND_DATE)< '01-"+nextmonth+"-"+endyr1+"') then BILL_AMOUT_STATE else 0 end) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_bill_pao_bridge_det_TBL a  where  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and  w.category_code='1'";
 if(scheme!=null && !scheme.equals("")){
          newCurRelpaoQuery+="and w.type_of_asset in("+scheme+")";
}

newCurRelpaoQuery+=" and a.STATE_TXID  is not null and  substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.programme_code in ("+programe+") and  a.work_id=w.work_id and b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"' group by  b.circle_office_code,b.division_office_code,w.work_id  order by 1"; 
		stmt4=conn.createStatement();
//System.out.println("newCurRelpaoQuery"+newCurRelpaoQuery);
	 rs3=stmt4.executeQuery(newCurRelpaoQuery);
		while(rs3.next())
	{
		String srelban=rs3.getString(4);
       String []aa=srelban.split("@");
String a1=aa[0];
String a2=aa[1];
 double npaoUpto1=Double.parseDouble(a1)/100000;
 double npaoCur1=Double.parseDouble(a2)/100000;

  npaoUpto+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,npaoUpto1);
npaoCur+=rwsReportsDAO.calculateAmount(conn,rs3.getString(3),popHash,subProg,npaoCur1);

		npaoUpto1=0;npaoCur1=0;
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();





String newWorksHabs="select distinct w.work_id FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'";
if(scheme!=null && !scheme.equals("")){
          newWorksHabs+="and w.type_of_asset in("+scheme+")";
}
newWorksHabs+=" and  w.programme_code in ("+programe+") and   b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"'  order by 1";
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(newWorksHabs);
	while(rs3.next())
	{
		String work_id=rs3.getString(1);
		nhabc+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"rws_admn_hab_lnk_tbl");
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String newWoksCoveredHabs="select distinct w.work_id FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1' ";
if(scheme!=null && !scheme.equals("")){
          newWoksCoveredHabs+="and w.type_of_asset in("+scheme+")";
}

newWoksCoveredHabs+=" and  w.programme_code in ("+programe+")  and w.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+startyr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+endyr1+"')) and   b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"'  order by 1";
		stmt4=conn.createStatement();
//System.out.println("newWoksCoveredHabs"+newWoksCoveredHabs);
	 rs3=stmt4.executeQuery(newWoksCoveredHabs);
	while(rs3.next())
	{
		String work_id=rs3.getString(1);
		ncovhabs+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"RWS_WORK_COMP_HAB_LNK_TBL");
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

String newWoksCoveredHabs1="select distinct w.work_id FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c  where w.work_id=c.work_id and  (w.ADMIN_DATE >= '01-Apr-"+startyr+"' and w.ADMIN_DATE < '01-Apr-"+endyr1+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code and  w.category_code='1'";
if(scheme!=null && !scheme.equals("")){
          newWoksCoveredHabs1+="and w.type_of_asset in("+scheme+")";
}
newWoksCoveredHabs1+=" and  w.programme_code in ("+programe+")  and w.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+endyr1+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextmonth+"-"+endyr1+"')) and   b.circle_office_code='"+rs1.getString(3)+"' and b.division_office_code='"+rs1.getString(4)+"'  order by 1";
stmt4=conn.createStatement();
////System.out.println("newWoksCoveredHabs"+newWoksCoveredHabs);
rs3=stmt4.executeQuery(newWoksCoveredHabs1);
	while(rs3.next())
	{
		String work_id=rs3.getString(1);
		ncovhabs1+=rwsReportsDAO.findSanctionedHabs(conn,popHash,work_id,subProg,"RWS_WORK_COMP_HAB_LNK_TBL");
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





tsworks=0;



String e=(String)spillOverExpCurMon.get(rs1.getString(3)+rs1.getString(4));
if(e!=null){
    spcur=(Double.parseDouble((String)spillOverExpCurMon.get(rs1.getString(3)+rs1.getString(4))));
    spcur=spcur/100000;
}
String e1=(String)newWorksCurExp.get(rs1.getString(3)+rs1.getString(4));
if(e1!=null){
    ncurexp=(Double.parseDouble((String)newWorksCurExp.get(rs1.getString(3)+rs1.getString(4))));
    ncurexp=ncurexp/100000;
}


//String srelpao=(String)spillOverRelPao.get(rs1.getString(3)+rs1.getString(4));


sbankUpto+=spaoUpto;
sbankCur+=spaoCur;

gsbankUpto+=sbankUpto;
gsbankCur+=sbankCur;



//NEW WORKS

nbankUpto+=npaoUpto;
nbankCur+=npaoCur;

gnbankUpto+=nbankUpto;
gnbankCur+=nbankCur;














%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>
<td class=rptValue ><%= spillOverSVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(ssvs=(Integer.parseInt((String)spillOverSVS.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue align=right><%= ndf.format(tspSamAmount) %></td>

<%
sbal=tspSamAmount-expUpto;
 %>


<td class=rptValue align=right><%=ndf.format(expUpto) %></td>
<td class=rptValue align=right><%=ndf.format(sbal) %></td>
<td class=rptValue align=right><%=ndf.format(sbankUpto) %></td>
<td class=rptValue align=right><%=ndf.format(sbankCur) %></td>
<td class=rptValue align=right><%=ndf.format(expCur) %></td>
<td class=rptValue align=right><%=ndf.format(spcur) %></td>

<td class=rptValue ><%= spillOverCom.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tspComleted=(Integer.parseInt((String)spillOverCom.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%= spillOverCom1.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tspComleted1=(Integer.parseInt((String)spillOverCom1.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue ><%= shabc %></td>
<td></td>
<td></td>
<td><%= shabscov %></td>
<td><%= shabscov1 %></td>
<td class=rptValue><%= newWorksSVS.get(rs1.getString(3)+rs1.getString(4))==null?"0":(nsvs=Integer.parseInt((String)newWorksSVS.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue align=right><%= ndf.format(tsancAmount)  %></td>

<%
nbal=tsancAmount-(nexpCur+nexpUpto);
 %>
<td class=rptValue align=right><%=ndf.format(nbankUpto) %></td>
<td class=rptValue align=right><%=ndf.format(nbankCur) %></td>
<td class=rptValue align=right><%=ndf.format(nexpCur) %></td>
<td class=rptValue align=right><%=ndf.format(ncurexp) %></td>
<td class=rptValue align=right><%=ndf.format(nbal) %></td>


<td class=rptValue><%= newWorksComp.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tnewWorksComp=Integer.parseInt((String)newWorksComp.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue><%= newWorksComp1.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tnewWorksComp1=Integer.parseInt((String)newWorksComp1.get(rs1.getString(3)+rs1.getString(4)))) %></td>
<td class=rptValue ><%= nhabc %></td>

<td class=rptValue ><%= ncovhabs %></td>
<td class=rptValue ><%= ncovhabs1 %></td>

</tr>
<% 
gshabscov1+=shabscov1;
gncovhabs1+=ncovhabs1;
gtnewWorksComp1+=tnewWorksComp1;
gsbal+=sbal;
gnbal+=nbal;
nbal=0;
gtnworws+=tnworws;
gtsworks+=tsworks;
gtsancAmount+=tsancAmount;
gtspSamAmount+=tspSamAmount;
gtspComleted+=tspComleted;
gtspComleted1+=tspComleted1;
gtnewWorksComp+=tnewWorksComp;
gshabc+=shabc;
gsmvs+=smvs;
gssvs+=ssvs;
gncurexp+=ncurexp;
gshabscov+=shabscov;
tnworws=0;tsworks=0;
shabscov=0;
tsancAmount=0;
gnhabc+=nhabc;
gspcur+=spcur;
gnsvs+=nsvs;
gnmvs+=nmvs;
gncovhabs+=ncovhabs;
tnewWorksComp=0;tspComleted=0;tspSamAmount=0;tsworks=0;tnworws=0;nexpUpto=0;
nexpCur=0;
sbal=0;
expUpto=0;
spcur=0;ncurexp=0;
nmvs=0;
expCur=0;
nhabc=0;
nexpUpto=0;
ncovhabs=0;
nexpCur=0;nsvs=0;
shabc=0;ssvs=0;smvs=0;
sbankUpto=0;sbankCur=0;
spaoCur=0;
spaoUpto=0;
nbankUpto=0;nbankCur=0;
npaoCur=0;
npaoUpto=0;
shabscov1=0;
tnewWorksComp1=0;
ncovhabs1=0;
}
%>
<tr><td colspan=3 class=btext align=right>Total:</td>

<td class=btext><%=gssvs %></td>
<td class=btext align=right><%=ndf.format(gtspSamAmount) %></td><td class=btext align=right><%=ndf.format(dexpUpto) %></td><td class=btext align=right><%=ndf.format(gsbal) %></td>
<td class=btext align=right><%=ndf.format(gsbankUpto) %></td><td class=btext align=right><%=ndf.format(gsbankCur) %></td>
<td class=btext align=right><%=ndf.format(dexpCur) %></td><td class=btext align=right><%=ndf.format(gspcur) %></td>
<td class=btext ><%=gtspComleted %></td>
<td class=btext ><%=gtspComleted1 %></td>
<td class=btext><%=gshabc %></td>
<td class=btext></td>
<td class=btext></td>
<td class=btext><%=gshabscov %></td>
<td class=btext><%=gshabscov1 %></td>

<td class=btext><%=gnsvs %></td>
<td class=btext align=right><%=ndf.format(gtsancAmount) %></td>



<td class=btext align=right><%=ndf.format(gnbankUpto) %></td>
<td class=btext align=right><%=ndf.format(gnbankCur) %></td>


<td class=btext align=right><%=ndf.format(dnexpCur) %></td>
<td class=btext align=right><%=ndf.format(gncurexp) %></td>

<td class=btext align=right><%=ndf.format(gtsancAmount) %></td>

<td class=btext > <%=gtnewWorksComp %></td>
<td class=btext > <%=gtnewWorksComp1 %></td>

<td class=btext><%=gnhabc %></td>
<td class=btext><%=gncovhabs %></td>
<td class=btext><%=gncovhabs1 %></td>
</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>