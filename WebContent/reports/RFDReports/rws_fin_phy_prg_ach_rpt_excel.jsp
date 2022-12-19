<%@ page contentType="application/vnd.ms-excel" %>
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

    DecimalFormat ndf = new DecimalFormat("##.##");
	String financialyr="";
	
    double aas=0;
  financialyr=(String)session.getAttribute("financialyr");
String pname=(String)session.getAttribute("pname");
String dcode=(String)session.getAttribute("dcode");
String divCode=(String)session.getAttribute("divCode");
   


    //schemes
String scheme=(String)session.getAttribute("scheme");

 

	String yr =financialyr.substring(0,4);
	//System.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
    String prvyr=""+(Integer.parseInt(yr)-1);
	String nextyr=""+(Integer.parseInt(yr)+1);
	//System.out.println("nextyr:"+nextyr);
    String subnextyr=nextyr.substring(2,4);
   // System.out.println("subnextyr:"+subnextyr);
	
	String[] programes=request.getParameterValues("program");
	
    String programe=(String)session.getAttribute("programe");
	
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
  // System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
System.out.println("Yr"+yr);
   System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;

        

   if(yr.equals(sysyear))
   {
     prevyear=yy;
     
    // prevmon=mon-1;
     //System.out.println("else prevyear::"+prevyear+"prevmon::"+prevmon);
    
   }
  else
	{
    prevyear=yy; 
   // prevmon=2;
  //  System.out.println("if prevyear::"+prevyear+"prevmon::"+prevmon);     
	}

String mymon=nic.watersoft.commons.RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=nic.watersoft.commons.RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=nic.watersoft.commons.RwsUtils.getNextMonth().toUpperCase();

String yr1="",yr2="";
if(nextmonth.equals("JAN") || nextmonth.equals("FEB") || nextmonth.equals("MAR")){
 yr2=""+(Integer.parseInt(yr)+1);
}else{
yr2=yr;
}

if(cmonth.equals("JAN")|| cmonth.equals("FEB") || cmonth.equals("MAR")){

 yr1=""+(Integer.parseInt(yr)+1);
}else{
 yr1=yr;
}


	%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=11>Financial and Physical Achievements - Works Program Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=2 align=center>Sl.No</td>
		<td class=btext rowspan=2 align=center>District</td>
<td class=btext rowspan=2 align=center>Division</td>
<td class=btext rowspan=2 align=center>Program</td>
<td class=btext  align=center colspan=2  ><b>Financial(Spill+New)</b></td>
<td class=btext colspan=5 align=center ><b>Physical(Spill + New)</b></td>
</tr>
<tr>
<td class=btext align="center"  >Bal Est.Cost as on 1.4.<%=yr%></td>
 <td  class=btext align="center"  >Achievement up to Prev Month<br>(<%=mymon %>)<br></td>	
		<td  class=btext align="center"  >No. of works</td>	
		<td  class=btext align="center"  >Habs Sanctioned</td>
		<td  class=btext align="center"  >No. of Works Grounded</td>	
<td  class=btext align="center"  >No. of Works Completed</td>	
<td class=btext align="center"  >Achievement Up To <br> <%=mymon %>-<%=yr %> Month</td>


</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center"  class=btext>10</td><td align="center" class=btext>11</td>
</tr>


<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
  try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();


String divCountQuery="select a.circle_office_code,count(*)  from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' group by circle_office_code ";

stmt3=conn.createStatement();
	 rs2=stmt3.executeQuery(divCountQuery);
	Hashtable divCountHash=new Hashtable();
	while(rs2.next())
	{
		divCountHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();

//Financial Queries

String estCostQuery="select b.circle_office_code,b.division_office_code,p.programme_code,sum(w.sanction_amount) FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p where w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          estCostQuery+="and w.type_of_asset in("+scheme+")";
}
estCostQuery+=" and w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(estCostQuery);
	Hashtable estCostHash=new Hashtable();
	while(rs2.next())
	{
		estCostHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();






String expQuery="select b.circle_office_code,b.division_office_code,p.programme_code,sum(case when to_date(voucher_dt)< '01-Apr-"+yr+"' then voucher_amt else 0 end) ||'@'||sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr+"' and to_date(voucher_dt)< '01-"+cmonth+"-"+yr1+"') then voucher_Amt else 0 end)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_work_exp_voucher_tbl v where v.work_id=w.work_id and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          expQuery+="and w.type_of_asset in("+scheme+")";
}
expQuery+=" and w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(expQuery);
	Hashtable expHash=new Hashtable();
	while(rs2.next())
	{
		expHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


//////////////////////////////*********************************************************************////////////////////////////////////

												//Physical Queries

////////////////////////////*******************************************************************///////////////////////////////////////





String ongoingWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          ongoingWorks+="and w.type_of_asset in("+scheme+")";
}
ongoingWorks+=" and w.programme_code in ("+programe+") and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("ongoingWorks"+ongoingWorks);
	 rs2=stmt3.executeQuery(ongoingWorks);
	Hashtable ongoingHash=new Hashtable();
	while(rs2.next())
	{
		ongoingHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String newWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p where to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorks+="and w.type_of_asset in("+scheme+")";
}
newWorks+=" and w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("ongoingWorks"+ongoingWorks);
	 rs2=stmt3.executeQuery(newWorks);
	Hashtable newWorksHash=new Hashtable();
	while(rs2.next())
	{
		newWorksHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String sanctionedHabs="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_admn_hab_lnk_tbl c where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          sanctionedHabs+="and w.type_of_asset in("+scheme+")";
}
sanctionedHabs+=" and w.programme_code in ("+programe+") and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("sanctionedHabs"+sanctionedHabs);
	 rs2=stmt3.executeQuery(sanctionedHabs);
	Hashtable sanctionedHabsHash=new Hashtable();
	while(rs2.next())
	{
		sanctionedHabsHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String sanctionedNewHabs="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_admn_hab_lnk_tbl c where to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          sanctionedNewHabs+="and w.type_of_asset in("+scheme+")";
}
sanctionedNewHabs+=" and w.programme_code in ("+programe+")   group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("sanctionedHabs"+sanctionedHabs);
	 rs2=stmt3.executeQuery(sanctionedNewHabs);
	Hashtable sanctionedNewHabsHash=new Hashtable();
	while(rs2.next())
	{
		sanctionedNewHabsHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();







String commencemntWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_work_commencement_tbl g   where g.work_id=W.work_id and  to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          commencemntWorks+="and w.type_of_asset in("+scheme+")";
}
commencemntWorks+=" and w.programme_code in ("+programe+") and  w.work_id not in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
System.out.println("commencemntWorks"+commencemntWorks);
	 rs2=stmt3.executeQuery(commencemntWorks);
	Hashtable commenceMentHash=new Hashtable();
	while(rs2.next())
	{
		commenceMentHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String commencemntNewWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_work_commencement_tbl g   where g.work_id=W.work_id and  to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          commencemntNewWorks+="and w.type_of_asset in("+scheme+")";
}
commencemntNewWorks+=" and w.programme_code in ("+programe+")  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
System.out.println("commencemntNewWorks"+commencemntNewWorks);
	 rs2=stmt3.executeQuery(commencemntNewWorks);
	Hashtable commenceMentNewHash=new Hashtable();
	while(rs2.next())
	{
		commenceMentNewHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();







String completedWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          completedWorks+="and w.type_of_asset in("+scheme+")";
}
completedWorks+=" and w.programme_code in ("+programe+") and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("completedWorks"+completedWorks);
	 rs2=stmt3.executeQuery(completedWorks);
	Hashtable completedHash=new Hashtable();
	while(rs2.next())
	{
		completedHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String completedNewWorks="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p where to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and w.programme_code=p.programme_code  and p.programme_code  in("+programe+") and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          completedNewWorks+="and w.type_of_asset in("+scheme+")";
}
completedNewWorks+=" and w.programme_code in ("+programe+") and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
//System.out.println("completedWorks"+completedWorks);
	 rs2=stmt3.executeQuery(completedNewWorks);
	Hashtable completedNewHash=new Hashtable();
	while(rs2.next())
	{
		completedNewHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String coveredHabs="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_work_comp_hab_lnk_tbl c where to_date(w.ADMIN_DATE) <'01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          coveredHabs+="and w.type_of_asset in("+scheme+")";
}
coveredHabs+=" and w.programme_code in ("+programe+") and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+yr+"'))   group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
System.out.println("coveredHabs"+coveredHabs);
	 rs2=stmt3.executeQuery(coveredHabs);
	Hashtable coveredHabsHash=new Hashtable();
	while(rs2.next())
	{
		coveredHabsHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String coveredNewHabs="select b.circle_office_code,b.division_office_code,p.programme_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_programme_tbl p,rws_work_comp_hab_lnk_tbl c where to_date(w.ADMIN_DATE) >='01-Apr-"+yr+"' and c.work_id=w.work_id and w.programme_code=p.programme_code   and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          coveredNewHabs+="and w.type_of_asset in("+scheme+")";
}
coveredNewHabs+=" and w.programme_code in ("+programe+") and  w.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) >= '01-Apr-"+yr+"'))  group by  b.circle_office_code,b.division_office_code,p.programme_code   order by 1";

		stmt3=conn.createStatement();
System.out.println("vcoveredNewHabs"+coveredNewHabs);
	 rs2=stmt3.executeQuery(coveredNewHabs);
	Hashtable coveredHabsNewHash=new Hashtable();
	while(rs2.next())
	{
		coveredHabsNewHash.put(rs2.getString(1)+rs2.getString(2)+rs2.getString(3),rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




stmt3=conn.createStatement();



String query="";
if(!loggedUser.equals(nic.watersoft.commons.Constants.SEC_USER) && !loggedUser.equals(nic.watersoft.commons.Constants.GUEST)){

if(dcode!=null && divCode!=null && !dcode.equals("") && !dcode.equals("00") && !loggedUser.equals(nic.watersoft.commons.Constants.GUEST)){
  if(divCode!=null && !divCode.equals("0") && !divCode.equals("")){
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' and a.division_office_code='"+divCode+"' order by circle_office_code ";
}else{
query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+dcode+"' order by circle_office_code ";
}
}else if(dcode!=null && dcode.equals("00")){

 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
}else{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
System.out.println("Main Query"+query);
rs1=stmt2.executeQuery(query);
String dname="";
int newWorksCount=0;
int divCount=0,ggongoingCount=0,ggsanhabsCount=0,ggcommencementCount=0,ggcompletedCount=0,ggcoveredHabsCount=0;
double gdivEstTot=0.0,ggexpAmount1=0.0;

double  ggdivEstTot=0.0,gggexpAmount1=0.0;

int gggongoingCount=0,gggsanhabsCount=0,gggcommencementCount=0,gggcompletedCount=0,gggcoveredHabsCount=0;
while(rs1.next()){

   String programQuery="select programme_code,programme_name from rws_programme_tbl where programme_code in ("+programe+")";
//System.out.println("Programe Query"+programQuery);
 


%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(1))){
dname=rs1.getString(1);
divCount=(Integer.parseInt((String)divCountHash.get(rs1.getString(3))));


%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>

<% 
boolean flag=false;
rs3=stmt3.executeQuery(programQuery);
divCount--;
double divEstTot=0,gexpAmount1=0;
int gongoingCount=0,gsanhabsCount=0,gcommencementCount=0,gcompletedCount=0,gcoveredHabsCount=0;
               while(rs3.next()){


             double estAmount=0,expAmount=0,expAmount1=0;
 int ongoingCount=0,completedCount=0,completedNewCount=0,coveredHabsCount=0;
int sanhabsNewCount=0;
int commencementCount=0,sanhabsCount=0;int commencementNewCount=0;int coveredHabsNewCount=0;

if(ongoingHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){

ongoingCount=(Integer.parseInt((String)ongoingHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}
if(newWorksHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){

newWorksCount=(Integer.parseInt((String)newWorksHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}

//habs

if(sanctionedHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){

sanhabsCount=(Integer.parseInt((String)sanctionedHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}

if(sanctionedNewHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){

sanhabsNewCount=(Integer.parseInt((String)sanctionedNewHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}


//commencement


if(commenceMentHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
commencementCount=(Integer.parseInt((String)commenceMentHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}

if(commenceMentNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
commencementNewCount=(Integer.parseInt((String)commenceMentNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}


if(completedHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
completedCount=(Integer.parseInt((String)completedHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}

if(completedNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
completedNewCount=(Integer.parseInt((String)completedNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}


if(coveredHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
coveredHabsCount=(Integer.parseInt((String)coveredHabsHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}

if(coveredHabsNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))!=null){
coveredHabsNewCount=(Integer.parseInt((String)coveredHabsNewHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1))));
}



                    String estCost=(String)estCostHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1));

                  if(estCost!=null && !estCost.equals("")){
				estAmount=Double.parseDouble(estCost);
						}
    String expCost=(String)expHash.get(rs1.getString(3)+rs1.getString(4)+rs3.getString(1));
//System.out.print("expCost"+expCost);
if(expCost!=null && !expCost.equals("")){
String []aa=expCost.split("@");
String a1=aa[0];
String a2=aa[1];
 			expAmount=Double.parseDouble(a1);
                expAmount=expAmount/100000;
				expAmount1=Double.parseDouble(a2);
                expAmount1=expAmount1/100000;

						}
				double col1=0;
                  		col1=estAmount-expAmount;
                  
                          
divEstTot+=(col1);



gexpAmount1+=expAmount1;






                  if(flag){
            
%>
<tr><td ></td><td ></td><td ></td>
<%} %>
 <td class=rptLabel><%=rs3.getString(2) %></td>
 <td class=rptValue align="right"><%=ndf.format(col1) %></td> 
<td  class=rptValue align="right"><%=ndf.format(expAmount1) %></td>
<td class=rptValue align=center><a href="#" onclick="viewWorks('rws_fin_phy_prg_ach_drill_rpt.jsp?type=3&subType=1&divCode=<%=rs1.getString(4) %>&prg=<%=rs3.getString(1) %>&dcode=<%=rs1.getString(3) %> ')"><%=(newWorksCount+ongoingCount)  %></a></td>
<td class=rptValue align=center><a href="#" onclick="viewWorks('rws_fin_phy_prg_ach_habs_drill_rpt.jsp?type=3&subType=1&divCode=<%=rs1.getString(4) %>&prg=<%=rs3.getString(1) %>&dcode=<%=rs1.getString(3) %> ')"><%=(sanhabsNewCount+sanhabsCount)  %></a></td>
<td  class=rptValue align=center><a href="#" onclick="viewWorks('rws_fin_phy_prg_ach_noofworksgrounded_drill_rpt.jsp?type=3&subType=1&divCode=<%=rs1.getString(4) %>&prg=<%=rs3.getString(1) %>&dcode=<%=rs1.getString(3) %> ')"><%=(commencementNewCount+commencementCount)  %></a></td>
<td  class=rptValue align=center><a href="#" onclick="viewWorks('rws_fin_phy_prg_ach_noofworkscomple_drill_rpt.jsp?type=3&subType=1&divCode=<%=rs1.getString(4) %>&prg=<%=rs3.getString(1) %>&dcode=<%=rs1.getString(3) %> ')"><%= (completedNewCount+completedCount) %></a></td>
<td class=rptValue align=center><a href="#" onclick="viewWorks('rws_fin_phy_prg_ach_upto_drill_rpt.jsp?type=3&subType=1&divCode=<%=rs1.getString(4) %>&prg=<%=rs3.getString(1) %>&dcode=<%=rs1.getString(3) %> ')"><%=(coveredHabsNewCount+coveredHabsCount)  %></a></td>
</tr>
<% 
flag=true;
gongoingCount+=(ongoingCount+newWorksCount);

gsanhabsCount+=(sanhabsCount+sanhabsNewCount);
gcommencementCount+=(commencementCount+commencementNewCount);
gcompletedCount+=(completedCount+completedNewCount);
gcoveredHabsCount+=(coveredHabsNewCount+coveredHabsCount);
newWorksCount=0;
sanhabsNewCount=0;

				}


%>

<tr><td class=rptLabel  style="background-color:lightgreen" colspan=4 align="right">Total:</td><td class=rptValue style="background-color:lightgreen" class=rptValue align="right"><b><%=ndf.format(divEstTot) %></b></td><td class=rptValue style="background-color:lightgreen" class=rptValue align="right" ><b><%=ndf.format(gexpAmount1) %></b></td><td style="background-color:lightgreen"  align="center"><b><%=gongoingCount %></b></td><td style="background-color:lightgreen" class=rptValue align=center><b><%=gsanhabsCount %></b></td><td  style="background-color:lightgreen" class=rptValue align=center><b><%=gcommencementCount %></b></td><td style="background-color:lightgreen" align=center> <b><%=gcompletedCount %></b></td><td style="background-color:lightgreen" align=center><b><%=gcoveredHabsCount %></b></td>
</tr>
<% 

gdivEstTot+=divEstTot;
divEstTot=0;
ggexpAmount1+=gexpAmount1;
gexpAmount1=0;
ggongoingCount+=gongoingCount;
ggsanhabsCount+=gsanhabsCount;
ggcommencementCount+=gcommencementCount;
ggcompletedCount+=gcompletedCount;
ggcoveredHabsCount+=gcoveredHabsCount;
gcoveredHabsCount=0;
gcompletedCount=0;
gcommencementCount=0;
gsanhabsCount=0;
gexpAmount1=0;
gongoingCount=0;
if(divCount==0){

%>
<tr ><td class=rptLabel  style="background-color:orange" colspan=4 align="right"><b>District Total:</b></td><td class=rptValue style="background-color:orange" class=rptValue align="right"><b><%=ndf.format(gdivEstTot) %></b></td><td class=rptValue style="background-color:orange" class=rptValue align="right" ><b><%=ndf.format(ggexpAmount1) %></b></td><td style="background-color:orange"  align="center"><b><%=ggongoingCount %></b></td><td style="background-color:orange" class=rptValue align=center><b><%=ggsanhabsCount %></b></td><td  style="background-color:orange" class=rptValue align=center><b><%=ggcommencementCount %></b></td><td style="background-color:orange" align=center> <b><%=ggcompletedCount %></b></td><td style="background-color:orange" align=center><b><%=ggcoveredHabsCount %></b></td>
</tr>



<%
ggdivEstTot+=gdivEstTot;
gggexpAmount1+=ggexpAmount1;

gggongoingCount+=ggongoingCount;
gggsanhabsCount+=ggsanhabsCount;
gggcommencementCount+=ggcommencementCount;
gggcompletedCount+=ggcompletedCount;
gggcoveredHabsCount+=ggcoveredHabsCount;
gdivEstTot=0;ggexpAmount1=0;ggongoingCount=0;ggsanhabsCount=0;ggcommencementCount=0;ggcompletedCount=0;
ggcoveredHabsCount=0;
}





}
%>

<tr ><td class=rptLabel  style="background-color:orange" colspan=4 align="right"><b>State Total:</b></td><td class=rptValue style="background-color:orange" class=rptValue align="right"><b><%=ndf.format(ggdivEstTot) %></b></td><td class=rptValue style="background-color:orange" class=rptValue align="right" ><b><%=ndf.format(gggexpAmount1) %></b></td><td style="background-color:orange"  align="center"><b><%=gggongoingCount %></b></td><td style="background-color:orange" class=rptValue align=center><b><%=gggsanhabsCount %></b></td><td  style="background-color:orange" class=rptValue align=center><b><%=gggcommencementCount %></b></td><td style="background-color:orange" align=center> <b><%=gggcompletedCount %></b></td><td style="background-color:orange" align=center><b><%=gggcoveredHabsCount %></b></td>
</tr>
<% 



}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>