<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
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
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
	 <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	 <tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td>
	</tr>
	</table>
	</caption>
	
   <tr></tr>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="left" class="rptHeading" colspan=35><font color="white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SVS - MVS Abstract Report</font> </td>	
	</tr>
		<tr>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Division</td>
		<td class=btext align=center colspan=3 style="background-color:lightyellow" >SVS</td>
		<td class=btext colspan=3 align=center style="background-color:#F9F2FA">MVS</td>
		</tr>
<tr>
        
		<td class=btext align="center" style="background-color:lightyellow">Total no.of Works</td>
        <td  class=btext align="center" style="background-color:lightyellow">Total Sanctioned Habs</td>
		<td  class=btext align="center" style="background-color:lightyellow">Completed Works No.</td>
		
		<td class=btext align="center"  style="background-color:#F9F2FA">Total no.of Works</td>
		<td  class=btext align="center"  style="background-color:#F9F2FA">Total Sanctioned Habs</td>
	    <td  class=btext align="center"  style="background-color:#F9F2FA">Completed Works No.</td>
 
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



String SVS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='2' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
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


String MVS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='1' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt3=conn.createStatement();
   // System.out.println("MVS:"+MVS);
	ResultSet rs3=stmt3.executeQuery(MVS);
	Hashtable MVSList=new Hashtable();
	while(rs3.next())
	{
		MVSList.put(rs3.getString(1)+rs3.getString(2),rs3.getString(3));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();



String SVSCOM="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='2' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt4=conn.createStatement();
   // System.out.println("SVSCOMP:"+SVSCOM);
	ResultSet rs4=stmt4.executeQuery(SVSCOM);
	Hashtable SVSCOMList=new Hashtable();
	while(rs4.next())
	{
		SVSCOMList.put(rs4.getString(1)+rs4.getString(2),rs4.getString(3));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();



String MVSCOM="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b where  w.category_code='1' and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  and w.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt5=conn.createStatement();
   // System.out.println("MVSCOM:"+MVSCOM);
	ResultSet rs5=stmt5.executeQuery(MVSCOM);
	Hashtable MVSCOMList=new Hashtable();
	while(rs5.next())
	{
		MVSCOMList.put(rs5.getString(1)+rs5.getString(2),rs5.getString(3));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();



String SVSHABS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c where w.category_code='2' and w.work_id=c.work_id  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code  group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt6=conn.createStatement();
   // System.out.println("SVSHABS:"+SVSHABS);
	ResultSet rs6=stmt6.executeQuery(SVSHABS);
	Hashtable SVSHABSList=new Hashtable();
	while(rs6.next())
	{
		SVSHABSList.put(rs6.getString(1)+rs6.getString(2),rs6.getString(3));
	}
	if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();



String MVSHABS="SELECT b.circle_office_code,b.division_office_code,count(*)  FROM RWS_WORK_ADMN_TBL W ,rws_division_office_tbl b,rws_admn_hab_lnk_tbl c where w.category_code='1' and w.work_id=c.work_id  and work_cancel_dt is null and substr(w.office_code,2,2)=b.circle_office_code and substr(w.office_code,4,1)=b.division_office_code group by  b.circle_office_code,b.division_office_code  order by 1";
	Statement stmt7=conn.createStatement();
   // System.out.println("MVSHABS:"+MVSHABS);
	ResultSet rs7=stmt7.executeQuery(MVSHABS);
	Hashtable MVSHABSList=new Hashtable();
	while(rs7.next())
	{
		MVSHABSList.put(rs7.getString(1)+rs7.getString(2),rs7.getString(3));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();


query="select b.dname,a.division_office_name,a.circle_office_code,a.division_office_code from rws_division_office_tbl a,rws_district_tbl b where b.dcode=a.circle_office_code and a.status<>'UI' order by circle_office_code ";

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
<td class=rptValue align="right" style="background-color:lightyellow"><a href="#" onclick="viewWorks('rws_svs_mvs_totnoofworks_drill_rpt.jsp?type=1&subType=1&dcode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=SVSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscnt=(Integer.parseInt((String)SVSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptValue align="right" style="background-color:lightyellow"><a href="#" onclick="viewWorks('rws_svs_mvs_totsanhabs_drill_rpt.jsp?type=1&subType=1&dcode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=SVSHABSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svshabcnt=(Integer.parseInt((String)SVSHABSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><a href="#" onclick="viewWorks('rws_svs_mvs_drill_rpt.jsp?type=2&ccode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=SVSCOMList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(svscompcnt=(Integer.parseInt((String)SVSCOMList.get(rs1.getString(3)+rs1.getString(4)))))%></td>

<td class=rptValue align="right"  style="background-color:#F9F2FA"><a href="#" onclick="viewWorks('rws_svs_mvs_totnoofworks_drill_rpt.jsp?type=1&subType=2&dcode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=MVSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvscnt=(Integer.parseInt((String)MVSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptValue align="right"  style="background-color:#F9F2FA"><a href="#" onclick="viewWorks('rws_svs_mvs_totsanhabs_drill_rpt.jsp?type=1&subType=2&dcode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=MVSHABSList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvshabcnt=(Integer.parseInt((String)MVSHABSList.get(rs1.getString(3)+rs1.getString(4)))))%></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><a href="#" onclick="viewWorks('rws_svs_mvs_drill_rpt.jsp?type=1&ccode=<%=rs1.getString(3) %>&divCode=<%=rs1.getString(4) %>')"><%=MVSCOMList.get(rs1.getString(3)+rs1.getString(4))==null?"0":(mvscompcnt=(Integer.parseInt((String)MVSCOMList.get(rs1.getString(3)+rs1.getString(4)))))%></td>


</tr>

<% 
tot1+=svscnt;
tot2+=mvscnt;
tot3+=svscompcnt;
tot4+=mvscompcnt;
tot5+=svshabcnt;
tot6+=mvshabcnt;
}


%>
<tr><td class=rptLabel colspan="3" align="center"> Total:</td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=tot1 %></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=tot5 %></td>
<td class=rptLabel align="right" style="background-color:lightyellow"><%=tot3 %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=tot2 %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=tot6 %></td>
<td class=rptLabel align="right"  style="background-color:#F9F2FA"><%=tot4 %></td>
</tr>
<%
svscnt=0;
mvscnt=0;
}
catch(Exception e)
{
  e.printStackTrace();
}

 %>



</table>	