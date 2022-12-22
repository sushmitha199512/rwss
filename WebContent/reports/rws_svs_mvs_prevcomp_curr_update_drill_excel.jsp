<jsp:useBean id="rwsOffices" class="nic.watersoft.commons.RwsOffices"/>
<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@	page import="java.sql.*,nic.watersoft.commons.RwsOffices" %>
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

	String loggedUser = (String)session.getAttribute("loggedUser");

String sysdate=workData.getDate();
String sysyear=sysdate.substring(6,10);
int yy=Integer.parseInt(sysyear);
session.setAttribute("yy",sysyear);
 %>
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		 <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		 <tr>
		 </tr>
		 </table>
	</caption>
	
</table>

  


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=10><font color="white">SVS - MVS (Works Completed in the Previous Year(s) but Work Completion Date Updated in Current Financial Year)</font> </td>	
	</tr>
		<tr>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Division</td>
		<td class=btext align=center colspan=2 style="background-color:lightyellow" >SVS</td>
		<td class=btext colspan=2 align=center style="background-color:#F9F2FA">MVS</td>
		<td  colspan=2 align=center >TOTAL</td>
		</tr>
<tr>
        
		<td class=btext align="center" style="background-color:lightyellow">No. of works Completed</td>
        <td  class=btext align="center" style="background-color:lightyellow">No. of habs covered</td>
		
		<td class=btext align="center"  style="background-color:#F9F2FA">No. of works Completed</td>
		<td  class=btext align="center"  style="background-color:#F9F2FA">No. of habs covered</td>

       <td  align="center" >No. of works Completed</td>
	   <td   align="center">No. of habs covered</td>
	  
</tr>



<%


Statement stmt1=null;
ResultSet rs1=null;
int count=1,svscnt=0,mvscnt=0,svscompcnt=0,mvscompcnt=0,svshabcnt=0,mvshabcnt=0;
int tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0;
try
{

stmt1=conn.createStatement();

String query="",dname="";



String SVS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='2' and work_cancel_dt is null and w.work_id in (select work_id from rws_work_completion_tbl  where date_of_completion is not null and to_date(date_of_completion)<= '01-Apr-"+yy+"' and to_date(update_date)>= '01-Apr-"+yy+"') and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt2=conn.createStatement();
    System.out.println("SVS:"+SVS);
	ResultSet rs2=stmt2.executeQuery(SVS);
	Hashtable SVSList=new Hashtable();
	while(rs2.next())
	{
		SVSList.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();


String MVS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='1' and work_cancel_dt is null and w.work_id in (select work_id from rws_work_completion_tbl  where date_of_completion is not null and to_date(date_of_completion)<= '01-Apr-"+yy+"' and to_date(update_date)>= '01-Apr-"+yy+"' ) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt3=conn.createStatement();
    System.out.println("MVS:"+MVS);
	ResultSet rs3=stmt3.executeQuery(MVS);
	Hashtable MVSList=new Hashtable();
	while(rs3.next())
	{
		MVSList.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();

String SVSHABS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c where w.category_code='2' and w.work_id=c.work_id  and work_cancel_dt is null and w.work_id in (select work_id from rws_work_completion_tbl  where date_of_completion is not null and to_date(date_of_completion)<= '01-Apr-"+yy+"' and to_date(update_date)>= '01-Apr-"+yy+"' ) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt6=conn.createStatement();
    System.out.println("SVSHABS:"+SVSHABS);
	ResultSet rs6=stmt6.executeQuery(SVSHABS);
	Hashtable SVSHABSList=new Hashtable();
	while(rs6.next())
	{
		SVSHABSList.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();



String MVSHABS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,RWS_WORK_COMP_HAB_LNK_TBL c where w.category_code='1' and w.work_id=c.work_id  and work_cancel_dt is null and w.work_id in (select work_id from rws_work_completion_tbl  where date_of_completion is not null and to_date(date_of_completion)<= '01-Apr-"+yy+"' and to_date(update_date)>= '01-Apr-"+yy+"' ) and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt7=conn.createStatement();
   System.out.println("MVSHABS:"+MVSHABS);
	ResultSet rs7=stmt7.executeQuery(MVSHABS);
	Hashtable MVSHABSList=new Hashtable();
	while(rs7.next())
	{
		MVSHABSList.put(rs7.getString(1)+rs7.getString(2),rs7.getString(3));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();

if(loggedUser!=null && loggedUser.equals("admin") || loggedUser.equals("100000"))
{
query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";
}
else if(!loggedUser.substring(3,4).equals("0"))
{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+loggedUser.substring(1,3)+"' and a.division_office_code='"+loggedUser.substring(3,4)+"' order by circle_office_code ";
}
else
{
 query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' and b.dcode='"+loggedUser.substring(1,3)+"'  order by circle_office_code ";
}

rs1=stmt1.executeQuery(query);

while(rs1.next())
{
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

<td class=rptValue align="right" style="background-color:lightyellow"><%=SVSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscnt=(Integer.parseInt((String)SVSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptValue align="right" style="background-color:lightyellow"><%=SVSHABSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svshabcnt=(Integer.parseInt((String)SVSHABSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptValue align="right"  style="background-color:#F9F2FA"><%=MVSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvscnt=(Integer.parseInt((String)MVSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptValue align="right"  style="background-color:#F9F2FA"><%=MVSHABSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvshabcnt=(Integer.parseInt((String)MVSHABSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td  align="right"><%=svscnt+mvscnt%></td>
<td  align="right"><%=svshabcnt+mvshabcnt %></td>


</tr>

<% 
tot1+=svscnt;
tot2+=mvscnt;
tot5+=svshabcnt;
tot6+=mvshabcnt;
tot3=tot1+tot2;
tot4=tot5+tot6;
svscnt=0;
mvscnt=0;
svshabcnt=0;
mvshabcnt=0;
}


%>
<tr><td class=rptLabel colspan="3" align="center"> Total:</td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=tot1 %></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=tot5 %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=tot2 %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=tot6 %></td>
<td  align="right"  ><%=tot3 %></td>
<td  align="right"  ><%=tot4 %></td>

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