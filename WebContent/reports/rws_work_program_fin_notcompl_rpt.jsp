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
<style>
tr.even {
  background-color: #ddd;
  width:20px;
  height:15px;
}
tr.odd {
  background-color: #eee;
  width:20px;
  height:15px;
  }
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

    DecimalFormat ndf = new DecimalFormat("####.##");
	String financialyr="";

     String completionDate=null;String message=null;

   
message="Works which are completed in last Financial Year but releases are still in Progress";
																		
	
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
	////System.out.println("programe::"+programe);
	scheme = scheme.substring(0,scheme.length()-1);
session.setAttribute("scheme",scheme);
}

	String yr =financialyr.substring(0,4);
	////System.out.println("yr:"+yr);
	//String nextyr=""+Integer.parseInt(yr)+1;
    String prvyr=""+(Integer.parseInt(yr)-1);
	String nextyr=""+(Integer.parseInt(yr)+1);
	////System.out.println("nextyr:"+nextyr);
    String subnextyr=nextyr.substring(2,4);
    //System.out.println("subnextyr:"+subnextyr);
	
	String[] programes=request.getParameterValues("program");
	
    String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	////System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
session.setAttribute("programe",programe);
	////System.out.println("programe::"+programe);
   
 String sysdate=workData.getDate();
   String sysmon=sysdate.substring(3,5);
   int mon=Integer.parseInt(sysmon);
   //System.out.println("sysdate::"+sysdate);
   String sysyear=sysdate.substring(6,10);
   int yy=Integer.parseInt(sysyear);
   ////System.out.println("sysyear::"+sysyear);
   int prevyear=0,prevmon=0;String fyear,fyear1;
   //System.out.println("fin ear::"+yr+"sys year::"+sysyear);
   if(yr.equals(sysyear))
   {
     prevyear=yy;
     prevmon=mon-1;
     //System.out.println("else prevyear::"+prevyear+"prevmon::"+prevmon);
    
   }
  else
	{
    prevyear=yy; 
    prevmon=2;
    //System.out.println("if prevyear::"+prevyear+"prevmon::"+prevmon);     
	}
   
  
String mymon=RwsUtils.getPreviousMonth().toUpperCase();
String cmonth=RwsUtils.getCurrentMont().toUpperCase();
String nextmonth=RwsUtils.getNextMonth().toUpperCase();


String yr1="",yr2="";
//System.out.println("nextmonth"+nextmonth);
if(nextmonth.equals("JAN") || nextmonth.equals("FEB") ||  nextmonth.equals("MAR")){
//System.out.println("YYYYN"+yr1);
 yr2=""+(Integer.parseInt(yr)+1);
}else{
yr2=yr;
}

if(cmonth.equals("JAN") || cmonth.equals("FEB") || cmonth.equals("MAR")){
//System.out.println("YYYYC"+yr1);
 yr1=""+(Integer.parseInt(yr)+1);
}else{
 yr1=yr;
}

String statePrograms="00,03,04,05,06,09,10,12,13,14,15,16,20,21,25,26,29,34,35,38,39,41,42,43,44,45,46,54,56,57,65,66,67";

//System.out.println("Current Month"+cmonth);
String relTable="",amount="";
String relColumn="";String txid="";
if(statePrograms.contains(programe)){
relTable="RWS_bill_pao_bridge_det_TBL";
relColumn="STATE_SEND_DATE";
txid="STATE_TXID";
amount="BILL_AMOUT_STATE";
}else {
relTable="RWS_bill_BANK_bridge_det_TBL";
relColumn="BANK_SEND_DATE";
txid="TXID";
amount="BILL_AMOUNT_CENTRAL";
}
session.setAttribute("relTable",relTable);
session.setAttribute("relColumn",relColumn);
session.setAttribute("txid",txid);
session.setAttribute("amount",amount);

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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./rws_work_program_fin_notcompl_excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
   <tr><td class="bwborder" align="center"><font  color="red" ><b>Note:<%=message %></b></font></td></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=15>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)--<font color="red"><%=pname %> .</font></td>	
	</tr>
		<tr >
		<td class=btext rowspan=4>Sl.No</td>
		<td class=btext rowspan=4>District</td>
<td class=btext rowspan=4>Division</td>
</tr>
<tr>
		<td class=btext align="center"  colspan=3>No.of Works</td>
		<td class=btext align="center" rowspan=3 >Bal Est Cost<br>(1.4.<%=yr %>)<br>(Est.Cost-Expenditure)</td>



	
 <td  class=btext align="center"  colspan=4>Releases During <br><%=financialyr %></td>	

<td  class=btext align="center"  colspan=4>Expenditure During <br><%=financialyr %></td>	
	


</tr>
<tr>
<td rowspan=2 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=2  colspan=1 class=btext align="center">MVS</td>	
		<td rowspan=2  colspan=1 class=btext align="left">Total <br>(4+5)</td>
<td rowspan=1 colspan=2   class=btext align="center">Rel.upto (<%=mymon %>)</td>
		<td rowspan=1 colspan=2   class=btext align="center">Rel. During (<%=cmonth %>)</td>

<td rowspan=1 colspan=2   class=btext align="center">Exp.upto (<%=mymon %>)</td>
		<td rowspan=1 colspan=2   class=btext align="center">Exp. During (<%=cmonth %>)</td>
	

</tr><tr>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>
<td rowspan=1 colspan=1 class=btext align="center">SVS</td>	
		<td rowspan=1  colspan=1 class=btext align="center">MVS</td>


</tr>
<tr><td class=btext align="center">1</td><td class=btext align="center">2</td><td class=btext align="center">3</td><td class=btext align="center">4</td><td class=btext align="center">5</td><td class=btext align="center">6</td><td class=btext align="center">7</td><td class=btext align="center">8</td><td class=btext align="center">9</td><td class=btext align="center">10</td><td class=btext align="center">11</td><td class=btext align="center">12</td><td class=btext align="center">13</td><td class=btext align="center">14</td><td class=btext align="center">15</td></tr>
<%
Statement stmt2=null;
ResultSet rs1=null;
int count=1;
  try{
    stmt2=conn.createStatement();


/******   New  Works *****************************************************/

	String newWorksMVSQuery="select c.circle_office_code,c.division_office_code,count(*),sum(sanction_amount)  from rws_work_admn_tbl a ,rws_division_office_tbl c where   a.work_cancel_dt is null and a.category_code='1' and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksMVSQuery+="and a.type_of_asset in("+scheme+")";
}
 newWorksMVSQuery+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null)  group by  c.circle_office_code,c.division_office_code  order by 1";

	Statement	stmt3=conn.createStatement();
//System.out.println("newWorksMVSQuery"+newWorksMVSQuery);
	ResultSet rs2=stmt3.executeQuery(newWorksMVSQuery);
	Hashtable newMvsWorks=new Hashtable();
	while(rs2.next())
	{
		newMvsWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();






	String newWorksSVSQuery="select c.circle_office_code,c.division_office_code,count(*),sum(sanction_amount)  from rws_work_admn_tbl a ,rws_division_office_tbl c where   a.work_cancel_dt is null and a.category_code='2' and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code ";
 if(scheme!=null && !scheme.equals("")){
          newWorksSVSQuery+="and a.type_of_asset in("+scheme+")";
}
 newWorksSVSQuery+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null)  group by  c.circle_office_code,c.division_office_code  order by 1";

	stmt3=conn.createStatement();
//System.out.println("newWorksSVSQuery"+newWorksSVSQuery);
	 rs2=stmt3.executeQuery(newWorksSVSQuery);
	Hashtable newSvsWorks=new Hashtable();
	while(rs2.next())
	{
		newSvsWorks.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




	String newWorksReleaesQuery="select c.circle_office_code,c.division_office_code,sum(case when (to_date("+relColumn+")>= '01-APR-"+yr+"' and to_date("+relColumn+") < '01-"+cmonth+"-"+yr1+"') then "+amount+" else 0 end)||'@'||sum(case when (to_date("+relColumn+")>='01-"+cmonth+"-"+yr1+"' and to_date("+relColumn+")< '01-"+nextmonth+"-"+yr2+"') then "+amount+" else 0 end) from rws_work_admn_tbl a , "+relTable+" b ,rws_division_office_tbl c where a.work_id=b.work_id and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code  and "+txid+" is not null and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksReleaesQuery+="and a.type_of_asset in("+scheme+")";
}
newWorksReleaesQuery+=" and a.CATEGORY_CODE='1' and a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  c.circle_office_code,c.division_office_code  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksReleaesQuery"+newWorksReleaesQuery);
	 rs2=stmt3.executeQuery(newWorksReleaesQuery);
	Hashtable newWorksRel=new Hashtable();
	while(rs2.next())
	{
		newWorksRel.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String newWorksReleaesSVS="select c.circle_office_code,c.division_office_code,sum(case when (to_date("+relColumn+")>= '01-APR-"+yr+"' and to_date("+relColumn+") < '01-"+cmonth+"-"+yr1+"') then "+amount+" else 0 end)||'@'||sum(case when (to_date("+relColumn+")>='01-"+cmonth+"-"+yr1+"' and to_date("+relColumn+")< '01-"+nextmonth+"-"+yr2+"') then "+amount+" else 0 end) from rws_work_admn_tbl a , "+relTable+" b ,rws_division_office_tbl c where a.work_id=b.work_id and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and "+txid+" is not null and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksReleaesSVS+="and a.type_of_asset in("+scheme+")";
}
newWorksReleaesSVS+=" and a.CATEGORY_CODE='2' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  c.circle_office_code,c.division_office_code  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksReleaesSVS"+newWorksReleaesSVS);
	 rs2=stmt3.executeQuery(newWorksReleaesSVS);
	Hashtable newWorksRelSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksRelSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String newWorksExpenSVS="select c.circle_office_code,c.division_office_code,sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr+"' and to_date(voucher_dt) < '01-"+cmonth+"-"+yr1+"' )then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>='01-"+cmonth+"-"+yr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+yr2+"') then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b ,rws_division_office_tbl c where  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+yr+"' and "+txid+" is not null)  and a.work_id=b.work_id and substr(a.office_code,2,2)=c.circle_office_code  and substr(a.office_code,4,1)=c.division_office_code and a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenSVS+="and a.type_of_asset in("+scheme+")";
}
newWorksExpenSVS+=" and a.CATEGORY_CODE='2' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  c.circle_office_code,c.division_office_code  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksExpenSVS"+newWorksExpenSVS);
	 rs2=stmt3.executeQuery(newWorksExpenSVS);
	Hashtable newWorksExpSVS=new Hashtable();
	while(rs2.next())
	{
		newWorksExpSVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String newWorksExpenMVS="select c.circle_office_code,c.division_office_code,sum(case when (to_date(voucher_dt)>= '01-Apr-"+yr+"' and  to_date(voucher_dt) < '01-"+cmonth+"-"+yr1+"' ) then voucher_amt else 0 end)||'@'||sum(case when (to_date(voucher_dt)>='01-"+cmonth+"-"+yr1+"' and to_date(voucher_dt)< '01-"+nextmonth+"-"+yr2+"') then voucher_amt else 0 end) from rws_work_admn_tbl a , rws_work_exp_voucher_tbl b ,rws_division_office_tbl c where  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+yr+"' and "+txid+" is not null) and a.work_id=b.work_id and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code and   a.work_id  in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"'))";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenMVS+="and a.type_of_asset in("+scheme+")";
}
newWorksExpenMVS+=" and a.CATEGORY_CODE='1' and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is  not null and DT_FIN_COMPLETION is null) group by  c.circle_office_code,c.division_office_code  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksExpenMVS"+newWorksExpenMVS);
	 rs2=stmt3.executeQuery(newWorksExpenMVS);
	Hashtable newWorksExpMVS=new Hashtable();
	while(rs2.next())
	{
		newWorksExpMVS.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String newWorksExpenTot="select c.circle_office_code,c.division_office_code,(sum(case when (to_date(voucher_dt)< '01-Apr-"+yr+"' )then voucher_amt else 0 end)/100000)   from rws_work_admn_tbl a , rws_division_office_tbl c,rws_work_exp_voucher_tbl d  where  a.work_id in (select b.work_id from  "+relTable+" b  where to_date("+relColumn+")>= '01-APR-"+yr+"' and "+txid+" is not null) and a.work_id=d.work_id  and a.work_cancel_dt is null  and substr(a.office_code,2,2)=c.circle_office_code and substr(a.office_code,4,1)=c.division_office_code  ";
 if(scheme!=null && !scheme.equals("")){
          newWorksExpenTot+="and a.type_of_asset in("+scheme+")";
}
 newWorksExpenTot+=" and  a.programme_code in ("+programe+") and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '01-Apr-"+yr+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) group by  c.circle_office_code,c.division_office_code  order by 1";

		stmt3=conn.createStatement();
//System.out.println("newWorksExpenTot"+newWorksExpenTot);
	 rs2=stmt3.executeQuery(newWorksExpenTot);
	Hashtable newWorksExpTot=new Hashtable();
	while(rs2.next())
	{
		newWorksExpTot.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





/***********************************End  ************************************/



String query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code  and  a.status <> 'UI' order by circle_office_code";

rs1=stmt2.executeQuery(query);

String dname="";
int svs=0,mvs=0;
int gsvs=0,gmvs=0,gtot=0;
double rel1=0,grel1=0,relUpto=0,relCur=0,grelUpto=0,grelCur=0,relUptoSVS=0,relCurSVS=0,grelUptoSVS=0,grelCurSVS=0;
double expUptoMVS=0,expCurSVS=0,expUptoSVS=0,expCurMVS=0,gexpUptoSVS=0,gexpCurSVS=0,gexpUptoMVS=0,gexpCurMVS=0;


double svsSanction=0.0,mvsSanction=0.0,balEstimate=0.0,gbalEstimate=0.0;

String exp="",nexp="";
String relS="",relS1="";
while(rs1.next()){

exp=(String)newWorksRel.get(rs1.getString(3)+rs1.getString(4));
if(exp!=null){
String []aa=exp.split("@");
String a1=aa[0];
String a2=aa[1];
 relUpto=Double.parseDouble(a1)/100000;
 relCur=Double.parseDouble(a2)/100000;
grelUpto+=relUpto;
grelCur+=relCur;
}

//mvs

nexp=(String)newWorksRelSVS.get(rs1.getString(3)+rs1.getString(4));
if(nexp!=null){
String []aa=nexp.split("@");
String a1=aa[0];
String a2=aa[1];
 relUptoSVS=Double.parseDouble(a1)/100000;
 relCurSVS=Double.parseDouble(a2)/100000;
grelUptoSVS+=relUptoSVS;
grelCurSVS+=relCurSVS;


}



relS=(String)newWorksExpSVS.get(rs1.getString(3)+rs1.getString(4));
if(relS!=null){
String []aa=relS.split("@");
String a1=aa[0];
String a2=aa[1];
 expUptoSVS=Double.parseDouble(a1)/100000;
 expCurSVS=Double.parseDouble(a2)/100000;
gexpUptoSVS+=expUptoSVS;
gexpCurSVS+=expCurSVS;


}

relS1=(String)newWorksExpMVS.get(rs1.getString(3)+rs1.getString(4));
if(relS1!=null){
String []aa=relS1.split("@");
String a1=aa[0];
String a2=aa[1];
 expUptoMVS=Double.parseDouble(a1)/100000;
 expCurMVS=Double.parseDouble(a2)/100000;
gexpUptoMVS+=expUptoMVS;
gexpCurMVS+=expCurMVS;


}

if( newSvsWorks.get(rs1.getString(3)+rs1.getString(4))!=null){

 String svsStr=(String)newSvsWorks.get(rs1.getString(3)+rs1.getString(4));
  if(!svsStr.equals("")){
       String a[]=svsStr.split("@");
        svs=Integer.parseInt(a[0]);
        svsSanction=Double.parseDouble(a[1]);
 }

}

if( newMvsWorks.get(rs1.getString(3)+rs1.getString(4))!=null){

 String svsStr=(String)newMvsWorks.get(rs1.getString(3)+rs1.getString(4));
  if(!svsStr.equals("")){
       String a[]=svsStr.split("@");
        mvs=Integer.parseInt(a[0]);
        mvsSanction=Double.parseDouble(a[1]);
 }

}

if( newWorksExpTot.get(rs1.getString(3)+rs1.getString(4))!=null){

   String str=(String)newWorksExpTot.get(rs1.getString(3)+rs1.getString(4));
   balEstimate=((svsSanction+mvsSanction)-Double.parseDouble(str));
gbalEstimate+=balEstimate;
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


<td class=rptValue ><%= svs %></td>
<td class=rptValue ><%=mvs %></td>
<td class=rptValue ><%=(svs+mvs) %></td>
<td class=rptValue  align=right><%=ndf.format(balEstimate) %></td>
<td class=rptValue  align=right><%= ndf.format(relUptoSVS) %></td>
<td class=rptValue  align=right><%= ndf.format(relUpto) %></td>
<td class=rptValue  align=right><%= ndf.format(relCurSVS) %></td>
<td class=rptValue  align=right><%= ndf.format(relCur) %></td>
<td class=rptValue  align=right><%= ndf.format(expUptoSVS) %></td>
<td class=rptValue  align=right><%= ndf.format(expUptoMVS) %></td>
<td class=rptValue  align=right><%= ndf.format(expCurSVS) %></td>
<td class=rptValue  align=right><%= ndf.format(expCurMVS) %></td>





<% 
gtot+=svs+mvs;
gsvs+=svs;
gmvs+=mvs;
grel1+=rel1;
svs=0;
balEstimate=0;
svsSanction=0;
mvsSanction=0;
mvs=0;rel1=0;
relUpto=0;
relCur=0;
relUptoSVS=0;
relCurSVS=0;
expUptoSVS=0;
expCurSVS=0;
expUptoMVS=0;
expCurMVS=0;
}
%>
<tr><td colspan=3 class=btext align=right>Total:</td>

<td class=btext><%=gsvs %></td>
<td class=btext><%=gmvs %></td>
<td class=btext><%=gtot %></td>
<td class=btext><%=ndf.format(gbalEstimate) %></td>


<td class=btext><%=ndf.format(grelUptoSVS) %></td>
<td class=btext><%=ndf.format(grelUpto) %></td>
<td class=btext><%=ndf.format(grelCurSVS) %></td>
<td class=btext><%=ndf.format(grelCur) %></td>
<td class=btext><%=ndf.format(gexpUptoSVS) %></td>
<td class=btext><%=ndf.format(gexpUptoMVS) %></td>
<td class=btext><%=ndf.format(gexpCurSVS) %></td>
<td class=btext><%=ndf.format(gexpCurMVS) %></td>

</tr>
<% 


}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>