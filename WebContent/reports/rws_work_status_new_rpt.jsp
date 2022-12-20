<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<script language="javascript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
</SCRIPT>
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";
	
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

	String yr =financialyr.substring(0,4);
	//System.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
    String prvyr=""+(Integer.parseInt(yr)-1);
	String nextyr=""+(Integer.parseInt(yr)+1);
	//System.out.println("nextyr:"+nextyr);
    String subnextyr=nextyr.substring(2,4);
    System.out.println("subnextyr:"+subnextyr);
	
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
   
  session.setAttribute("scheme",scheme);
session.setAttribute("yr",yr);

 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
   //System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
   System.out.println("fin ear::"+yr+"sys year::"+sysyear);
   if(yr.equals(sysyear))
   {
     prevyear=yy;
     prevmon=mon-1;
     System.out.println("else prevyear::"+prevyear+"prevmon::"+prevmon);
    
   }
  else
	{
    prevyear=yy; 
    prevmon=2;
    System.out.println("if prevyear::"+prevyear+"prevmon::"+prevmon);     
	}
    String months[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
    String mymon=months[prevmon-1];
       

String cmonth=months[prevmon];
String nextMonth="";
if(prevmon==11){
nextMonth=months[0];
}else{
nextMonth=months[prevmon+1];
}

System.out.println("Current Month"+cmonth);

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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./rws_work_status_new_excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=30>General Works Status Report for the Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=3>Sl.No</td>
		<td class=btext rowspan=3>District</td>
<td class=btext rowspan=3>Division</td>
</tr>
<tr>
		<td class=btext align="center"  colspan=3>No.of Works</td>

		<td  class=btext align="center"  colspan=6>Physical Stage(Spill + New) </td>	
		
		<td  class=btext align="center"  colspan=2>Completed but not Commissioned During <br><%=financialyr %></td>	
			


</tr>
<tr>
<td rowspan=1 colspan=1  class=btext align="center">Spill</td>	
		<td rowspan=1  colspan=1 class=btext align="center">New</td>	
		<td rowspan=1  colspan=1 class=btext align="left">Total</td>
<td rowspan=1 colspan=1   width=30 class=btext align="center">Techal Sanctioned</td>
		<td rowspan=1 colspan=1   class=btext align="center">Agreement</td>
	<td rowspan=1 colspan=1   class=btext align="center">Grounded</td>
		<td rowspan=1 colspan=1   class=btext align="center">Completed</td>
<td rowspan=1 colspan=1  class=btext align="center">Commissioned</td>	
		<td rowspan=1  colspan=1 class=btext  nowrap width=45>Completed but not Commissioned as on 1.4.<%=yr %></td>	
		<td rowspan=1  colspan=1 class=btext align="left"> UpTo <%=mymon %></td>
<td rowspan=1 colspan=1    class=btext align="center">During (<%=cmonth %>)Month</td>



</tr>

<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/

	String newWorksQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

	Statement	stmt3=conn.createStatement();
System.out.println("New Works"+newWorksQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksQuery);
	Hashtable newWorks=new Hashtable();
	while(rs2.next())
	{
		newWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksGroundQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMMENCEMENT_TBL G where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and G.GROUNDING_DATE is not null and G.work_id=W.work_id and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksGroundQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksGroundQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksGroundQuery"+newWorksGroundQuery);
	 rs2=stmt3.executeQuery(newWorksGroundQuery);
	Hashtable newGroundWorks=new Hashtable();
	while(rs2.next())
	{
		newGroundWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWorksContracQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_contractor_selection_tbl G where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null  and G.work_id=W.work_id and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksContracQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksContracQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksContracQuery"+newWorksContracQuery);
	 rs2=stmt3.executeQuery(newWorksContracQuery);
	Hashtable newAgreeWorks=new Hashtable();
	while(rs2.next())
	{
		newAgreeWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksTechQuery="select b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_NEW_EST_TBL E where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and E.work_id=W.work_id and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksTechQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksTechQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksTechQuery"+newWorksTechQuery);
	 rs2=stmt3.executeQuery(newWorksTechQuery);
	Hashtable newTechWorks=new Hashtable();
	while(rs2.next())
	{
		newTechWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


	String newWorksCommiQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_commencement_tbl c where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and c.work_id=W.work_id and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCommiQuery+="and w.type_of_asset in("+scheme+")";
}
 newWorksCommiQuery+=" and  w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newWorksCommiQuery"+newWorksCommiQuery);
	 rs2=stmt3.executeQuery(newWorksCommiQuery);
	Hashtable newCommWorks=new Hashtable();
	while(rs2.next())
	{
		newCommWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



	String newComplBNotCommQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_completion_tbl c where   work_cancel_dt is null and c.work_id=W.work_id and c.DATE_OF_COMPLETION is  not null  and c.DATE_OF_COMM is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newComplBNotCommQuery+="and w.type_of_asset in("+scheme+")";
}
 newComplBNotCommQuery+=" and  w.programme_code in ("+programe+") and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+yr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+cmonth+"-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newComplBNotCommQuery"+newComplBNotCommQuery);
	 rs2=stmt3.executeQuery(newComplBNotCommQuery);
	Hashtable newCompCommWorks=new Hashtable();
	while(rs2.next())
	{
		newCompCommWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




	String newComplBNotCommQuery1="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_completion_tbl c where   work_cancel_dt is null and c.work_id=W.work_id and c.DATE_OF_COMPLETION is  not null  and c.DATE_OF_COMM is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newComplBNotCommQuery1+="and w.type_of_asset in("+scheme+")";
}
 newComplBNotCommQuery1+=" and  w.programme_code in ("+programe+") and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-"+cmonth+"-"+yr+"') and (to_date(DATE_OF_COMPLETION) < '01-"+nextMonth+"-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";

		stmt3=conn.createStatement();
System.out.println("newComplBNotCommQuery1"+newComplBNotCommQuery1);
	 rs2=stmt3.executeQuery(newComplBNotCommQuery1);
	Hashtable newCompCommWorks1=new Hashtable();
	while(rs2.next())
	{
		newCompCommWorks1.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();














String newWorksCompQuery="select b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  (w.ADMIN_DATE >= '01-Apr-"+yr+"' and w.ADMIN_DATE < '01-Apr-"+nextyr+"') and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksCompQuery+="and w.type_of_asset in("+scheme+")";
}
newWorksCompQuery+="and  w.programme_code in ("+programe+")  and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+yr+"') and (to_date(DATE_OF_COMPLETION) < '01-Apr-"+nextyr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
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








/******   Spil over Works *****************************************************/
String spillOverWorks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+")  ";

if(scheme!=null && !scheme.equals("")){
          spillOverWorks+="and w.type_of_asset in("+scheme+")";
}
 spillOverWorks+=" and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";

System.out.println("Spill Over"+spillOverWorks);
	Statement	stmt4=conn.createStatement();
	ResultSet rs3=stmt4.executeQuery(spillOverWorks);
		Hashtable spillOver=new Hashtable();
	while(rs3.next())
	{
		spillOver.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverComp="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverComp+="and w.type_of_asset in("+scheme+")";
}
 spillOverComp+="and  w.work_id  not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) and w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) > '01-Apr-"+yr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("SpillComplete"+spillOverComp);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverComp);
		Hashtable spillOverCom=new Hashtable();
	while(rs3.next())
	{
		spillOverCom.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();


String spillOveragreement="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b ,rws_contractor_selection_tbl c where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.work_id=c.work_id and w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOveragreement+="and w.type_of_asset in("+scheme+")";
}
 spillOveragreement+="and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"')) group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOveragreement"+spillOveragreement);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOveragreement);
		Hashtable spillOverAgree=new Hashtable();
	while(rs3.next())
	{
		spillOverAgree.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String spillOverGround="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMMENCEMENT_TBL G where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  G.GROUNDING_DATE is not null and G.work_id=W.work_id and  w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverGround+="and w.type_of_asset in("+scheme+")";
}
 spillOverGround+="and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverGround"+spillOverGround);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverGround);
		Hashtable spillOverGro=new Hashtable();
	while(rs3.next())
	{
		spillOverGro.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();

String spillOverTech="SELECT b.circle_office_code,b.division_office_code,count(*)   FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_NEW_EST_TBL E where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  E.work_id=W.work_id and  w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverTech+="and w.type_of_asset in("+scheme+")";
}
 spillOverTech+="and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverTech"+spillOverTech);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverTech);
		Hashtable spillOverTec=new Hashtable();
	while(rs3.next())
	{
		spillOverTec.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();



String spillOverCommQuery="SELECT b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_completion_tbl c where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and c.DATE_OF_COMM is not null and   c.work_id=W.work_id and  w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverCommQuery+="and w.type_of_asset in("+scheme+")";
}
 spillOverCommQuery+="and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverCommQuery"+spillOverCommQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverCommQuery);
		Hashtable spillOverComm=new Hashtable();
	while(rs3.next())
	{
		spillOverComm.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();




String spillOverCommNotCompQuery="SELECT b.circle_office_code,b.division_office_code,count(*) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_work_completion_tbl c where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"'  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and  c.work_id=W.work_id and c.DATE_OF_COMPLETION is  not null  and c.DATE_OF_COMM is null and  w.programme_code in ("+programe+") ";
if(scheme!=null && !scheme.equals("")){
          spillOverCommNotCompQuery+="and w.type_of_asset in("+scheme+")";
}
 spillOverCommNotCompQuery+="and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code  order by 1";
System.out.println("spillOverCommNotCompQuery"+spillOverCommNotCompQuery);
		stmt4=conn.createStatement();
	 rs3=stmt4.executeQuery(spillOverCommNotCompQuery);
		Hashtable spillOverComplnotComm=new Hashtable();
	while(rs3.next())
	{
		spillOverComplnotComm.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt4!=null)stmt4.close();





/***********************************End  ************************************/



String query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<> 'UI'  order by circle_office_code";

rs1=stmt2.executeQuery(query);
int  tnworws=0,tsworks=0,scomp=0,ncomp=0,sground=0,nground=0,stech=0,ntech=0,scomm=0,ncomm=0,cc=0,sag=0,nag=0,prevComp=0,currentCompl=0;
int  gtnworws=0,gtsworks=0,allworks=0,gcomp=0,gground=0,gtech=0,gcomm=0,gcc=0,gag=0,gprevComp=0,gcurrentCompl=0;
String dname="";
String exp="",nexp="";
while(rs1.next()){
if(spillOverCom.get(rs1.getString(3)+rs1.getString(4))!=null){
scomp=Integer.parseInt((String)(spillOverCom.get(rs1.getString(3)+rs1.getString(4))));
}
if(newWorksComp.get(rs1.getString(3)+rs1.getString(4))!=null){
ncomp=Integer.parseInt((String)(newWorksComp.get(rs1.getString(3)+rs1.getString(4))));
}

if(spillOverGro.get(rs1.getString(3)+rs1.getString(4))!=null){
sground=Integer.parseInt((String)(spillOverGro.get(rs1.getString(3)+rs1.getString(4))));
}
if(newGroundWorks.get(rs1.getString(3)+rs1.getString(4))!=null){
nground=Integer.parseInt((String)(newGroundWorks.get(rs1.getString(3)+rs1.getString(4))));
}

if(spillOverTec.get(rs1.getString(3)+rs1.getString(4))!=null){
stech=Integer.parseInt((String)(spillOverTec.get(rs1.getString(3)+rs1.getString(4))));
}
if(newTechWorks.get(rs1.getString(3)+rs1.getString(4))!=null){
ntech=Integer.parseInt((String)(newTechWorks.get(rs1.getString(3)+rs1.getString(4))));
}

if(spillOverComm.get(rs1.getString(3)+rs1.getString(4))!=null){
scomm=Integer.parseInt((String)(spillOverComm.get(rs1.getString(3)+rs1.getString(4))));
}
if(newCommWorks.get(rs1.getString(3)+rs1.getString(4))!=null){
ncomm=Integer.parseInt((String)(newCommWorks.get(rs1.getString(3)+rs1.getString(4))));
}
if(spillOverComplnotComm.get(rs1.getString(3)+rs1.getString(4))!=null){
cc=Integer.parseInt((String)(spillOverComplnotComm.get(rs1.getString(3)+rs1.getString(4))));
}

if(newAgreeWorks.get(rs1.getString(3)+rs1.getString(4))!=null){
nag=Integer.parseInt((String)(newAgreeWorks.get(rs1.getString(3)+rs1.getString(4))));
}
if(spillOverAgree.get(rs1.getString(3)+rs1.getString(4))!=null){
sag=Integer.parseInt((String)(spillOverAgree.get(rs1.getString(3)+rs1.getString(4))));
}

if(newCompCommWorks.get(rs1.getString(3)+rs1.getString(4))!=null){
prevComp=Integer.parseInt((String)(newCompCommWorks.get(rs1.getString(3)+rs1.getString(4))));
}



if(newCompCommWorks1.get(rs1.getString(3)+rs1.getString(4))!=null){
currentCompl=Integer.parseInt((String)(newCompCommWorks1.get(rs1.getString(3)+rs1.getString(4))));
}





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
<td class=rptValue ><%= spillOver.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tsworks=(Integer.parseInt((String)spillOver.get(rs1.getString(3)+rs1.getString(4))))) %></td>
<td class=rptValue><%= newWorks.get(rs1.getString(3)+rs1.getString(4))==null?"0":(tnworws=Integer.parseInt((String)newWorks.get(rs1.getString(3)+rs1.getString(4)))) %></td>

<%
gtsworks+=tsworks;
gtnworws+=tnworws;
allworks+=tnworws+tsworks;
gground+=sground+nground;
gcomp+=scomp+ncomp;
gtech+=stech+ntech;
gcomm+=scomm+ncomm;
gag+=sag+nag;
gprevComp+=prevComp;
gcurrentCompl+=currentCompl;

gcc+=cc;
 %>
<td class=rptValue><%=tnworws+tsworks %></td>

<td class=rptValue><%=stech+ntech %></td>
<td class=rptValue><%=sag+nag %></td>
<td class=rptValue><%=sground+nground %></td>
<td class=rptValue><%=scomp+ncomp %></td>
<td class=rptValue><%=scomm+ncomm %></td>
<td class=rptValue><a onclick="viewWorks('rws_work_status_new_dril_rpt.jsp?ccode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')" href="#" ><%=cc %></a></td>
<td class=rptValue><%=prevComp %></td>
<td class=rptValue><%=currentCompl %></td>

</tr>
<% 

tnworws=0;
tsworks=0;scomp=0;ncomp=0;sground=0;nground=0;stech=0;ntech=0;scomm=0;ncomm=0;cc=0;sag=0;nag=0;
prevComp=0;
currentCompl=0;


}
%>
<tr><td colspan=3 class=btext align=right>Total:</td>
<td  class=btext ><%=gtsworks %></td>
<td  class=btext ><%=gtnworws %></td>
<td  class=btext ><%=allworks %></td>
<td  class=btext ><%=gtech %></td>
<td  class=btext ><%=gag %></td>
<td  class=btext ><%=gground %></td>
<td  class=btext ><%=gcomp %></td>
<td  class=btext ><%=gcomm %></td>
<td  class=btext ><%=gcc %></td>
<td  class=btext ><%=gprevComp %></td>
<td  class=btext ><%=gcurrentCompl %></td>


</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>