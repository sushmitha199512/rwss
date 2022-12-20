<%@	page import="java.sql.*,nic.watersoft.commons.RwsOffices" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
<form name=f1  action="<%= request.getRequestURI()%>">

<%

String type=request.getParameter("type");
System.out.println("my rep type:"+type);

DecimalFormat ndf = new DecimalFormat("####.##");

String sysdate=workData.getDate();
String sysyear=sysdate.substring(6,10);
int yy=Integer.parseInt(sysyear);
int ny=yy+1;

 %>
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		 <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		 <tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td>
		 </tr>
		 </table>
	</caption>
	
</table>


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=35><font color="white"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sustanability Works(Spill+New) During the Financial Year</b></font> </td>	
	</tr>
		<tr>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Division</td>
       <!--  <td class=btext rowspan=2>Total no.of Works</td>-->
		<td class=btext colspan=3 align=center style="background-color:#F9F2FA">Physical</td>
        <td class=btext align=center colspan=3 style="background-color:lightyellow" >Financial</td>
		</tr>
<tr>
        <td class=btext align="center" style="background-color:#F9F2FA">Target</td>
        <td  class=btext align="center" style="background-color:#F9F2FA">Achievement</td>
		<td  class=btext align="center" style="background-color:#F9F2FA">%</td>
				
		<td  class=btext align="center"  style="background-color:lightyellow">Target(in Lakhs)</td>
	    <td  class=btext align="center"  style="background-color:lightyellow">Achievement<br>(in Lakhs)</td>
        <td  class=btext align="center" style="background-color:lightyellow">%</td>
</tr>



<%


Statement stmt1=null;
ResultSet rs1=null;
int count=1,suswrkcnt=0,tot4=0,tot5=0,trgcnt=0,achcnt=0,tot6=0;
double tot1=0,tot2=0,tot3=0,trgcnt1=0,achcnt1=0;
double suscnt=0,vouamt=0,tot7=0,peramt=0;
double per1=0,per2=0,tot51=0,tot61=0;
try
{

stmt1=conn.createStatement();

String query="",dname="";


//ongoing works est cost
String susestqry="SELECT b.circle_office_code,b.division_office_code,nvl(sum(SANCTION_AMOUNT),0)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  substr(work_id,7,2)='10' and work_cancel_dt is null and  work_id not in (select work_id from rws_work_completion_tbl) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt2=conn.createStatement();
    System.out.println("suscnt:"+susestqry);
	ResultSet rs2=stmt2.executeQuery(susestqry);
	Hashtable susList=new Hashtable();
	while(rs2.next())
	{
		susList.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();


String susvouqry="SELECT b.circle_office_code,b.division_office_code,nvl(sum(VOUCHER_AMT),0)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b, rws_work_exp_voucher_tbl c where  w.work_id=c.work_id  and substr(w.work_id,7,2)='10' and w.work_cancel_dt is null and  w.work_id not in (select work_id from rws_work_completion_tbl) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt3=conn.createStatement();
    System.out.println("susvouqry:"+susvouqry);
	ResultSet rs3=stmt3.executeQuery(susvouqry);
	Hashtable vouList=new Hashtable();
	while(rs3.next())
	{
		vouList.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();


String suswrksqry="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  substr(work_id,7,2)='10' and work_cancel_dt is null and  work_id not in (select work_id from rws_work_completion_tbl) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt4=conn.createStatement();
    System.out.println("suswrksqry:"+suswrksqry);
	ResultSet rs4=stmt4.executeQuery(suswrksqry);
	Hashtable suswrksList=new Hashtable();
	while(rs4.next())
	{
		suswrksList.put(rs4.getString(1)+rs4.getString(2),rs4.getString(3));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();


//String sustrgwrks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_contractor_selection_tbl c where  w.work_id=c.work_id and substr(w.work_id,7,2)='10' and w.work_cancel_dt is null and c.PROBABLE_DATE is not null and to_date(c.PROBABLE_DATE)<='31-MAR-"+ny+"' and  w.work_id not in (select work_id from rws_work_completion_tbl) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
String sustrgwrks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  substr(work_id,7,2)='10' and work_cancel_dt is null and  work_id not in (select work_id from rws_work_completion_tbl) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt5=conn.createStatement();
    System.out.println("sustrgwrks:"+sustrgwrks);
	ResultSet rs5=stmt5.executeQuery(sustrgwrks);
	Hashtable trgList=new Hashtable();
	while(rs5.next())
	{
		trgList.put(rs5.getString(1)+rs5.getString(2),rs5.getString(3));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();


String phyachwrks="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_contractor_selection_tbl c where  w.work_id=c.work_id and substr(w.work_id,7,2)='10' and w.work_cancel_dt is null and c.PROBABLE_DATE is not null and to_date(c.PROBABLE_DATE)<='31-MAR-"+ny+"' and  w.work_id  in (select work_id from rws_work_completion_tbl  where date_of_completion is not null) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt6=conn.createStatement();
    System.out.println("phyachwrks:"+phyachwrks);
	ResultSet rs6=stmt6.executeQuery(phyachwrks);
	Hashtable achList=new Hashtable();
	while(rs6.next())
	{
		achList.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();





query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";

rs1=stmt1.executeQuery(query);

while(rs1.next())
{


  String totwrks=(String)suswrksList.get(rs1.getString(3)+rs1.getString(4));
  String phytrg=(String)trgList.get(rs1.getString(3)+rs1.getString(4));
  String phyach=(String)achList.get(rs1.getString(3)+rs1.getString(4));
  String fintrg=(String)susList.get(rs1.getString(3)+rs1.getString(4));
  String finach=(String)vouList.get(rs1.getString(3)+rs1.getString(4));


  if(totwrks!=null && !totwrks.equals("null"))
   {
    suswrkcnt=Integer.parseInt(totwrks);
    tot4+=suswrkcnt;
   }
   
 if(phytrg!=null && !phytrg.equals("null"))
  {
    trgcnt=Integer.parseInt(phytrg);
    tot5+=trgcnt;

    trgcnt1=trgcnt;
    tot51+=trgcnt1;
  }
  if(phyach!=null && !phyach.equals("null"))
   {
    achcnt=Integer.parseInt(phyach);
    tot6+=achcnt;

    achcnt1=achcnt;
    tot61+=achcnt1;
    }
 if(fintrg!=null && !fintrg.equals("null"))
{
    suscnt=Double.parseDouble(fintrg);
    tot1+=suscnt;
}
if(finach!=null && !finach.equals("null"))
{
    vouamt=Double.parseDouble(finach)/100000;  
    tot2+=vouamt;
}


if(trgcnt1!=0 && achcnt1!=0 && trgcnt1>=achcnt1)
{
  per1=(100*achcnt1)/trgcnt1;
}else
{
  per1=0;
}


if(suscnt!=0 && vouamt!=0 && suscnt>=vouamt)
{
  per2=(100*vouamt)/suscnt;
}else
{
  per2=0;
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
else
{
%>
<td  class=rptLabel></td>
<%} %>
<td  class=rptLabel><%=rs1.getString(2) %></td>

<!-- <td class=rptValue align="right"></td> -->


<td class=rptValue align="right"  style="background-color:#F9F2FA"><%=trgcnt %></td>
<td class=rptValue align="right"  style="background-color:#F9F2FA"><%=achcnt %></td>
<td class=rptValue align="right"  style="background-color:#F9F2FA"><%=ndf.format(per1) %></td>

<td class=rptValue align="right" style="background-color:lightyellow"><%=ndf.format(suscnt)%></td>
<td class=rptValue align="right" style="background-color:lightyellow"><%=ndf.format(vouamt)%></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=ndf.format(per2) %></td>

</tr>

<% 

trgcnt=0;
achcnt=0;
suscnt=0;
vouamt=0;
trgcnt1=0;
achcnt1=0;


}


%>
<tr><td class=rptLabel colspan="3" align="center"> Total:</td>
<!-- <td class=rptLabel align="right" ></td>-->

<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=ndf.format(tot5) %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=ndf.format(tot6) %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=ndf.format((tot61*100)/tot51) %></td>

<td class=rptLabel align="right" style="background-color:lightyellow"><%=ndf.format(tot1) %></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=ndf.format(tot2) %></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=ndf.format((tot2*100)/tot1) %></td>

</tr>
<%

}
catch(Exception e)
{
  e.printStackTrace();
}

 %>

</table>	

</form>