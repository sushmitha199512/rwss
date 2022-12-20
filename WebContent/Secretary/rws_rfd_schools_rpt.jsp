<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>


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

    DecimalFormat ndf1 = new DecimalFormat("##");
String dcode="";
if(loggedUser.substring(0,3).equals("col")){
	dcode=(String)session.getAttribute("district");  
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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./rws_rfd_schools_excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=11>Coverage of Schools with Drinking Water Facilities</td>	
	</tr>
		<tr >
		<td class=btext rowspan=2 align=center>Sl.No</td>
		<td class=btext rowspan=2 align=center>District</td>
<td class=btext  align=center colspan=3 nowrap >Coverage of Schools with Drinking Water Facilities.</td>
<td class=btext colspan=3 align=center >Coverage of Anganwadis with Drinking Water Facilities.</td>
</tr>
<tr>
<td class=btext align="center"  >Total No. of Schools sanctioned</td>
 <td  class=btext align="center"  >No. of schools provided with Drinking Water</td>	
		<td  class=btext align="center"  >%</td>	
		<td  class=btext align="center"  >Total No. of Anganwadies</td>
		<td  class=btext align="center"  >No. of Anganwadies provided with Drinking Water</td>	
<td  class=btext align="center"  >%</td>	



</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td>
</tr>


<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
  try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();

//Financial Queries

String schoolsQuery="select substr(W.office_code,2,2),COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and work_cancel_dt is null  and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE <>'01' and c.school_code=d.school_code  group by substr(W.office_code,2,2) order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(schoolsQuery);
	Hashtable schoolsHash=new Hashtable();
	while(rs2.next())
	{
		schoolsHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String anganiVadiQuery="select substr(W.office_code,2,2),COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and work_cancel_dt is null  and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code group by substr(W.office_code,2,2) order by 1";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(anganiVadiQuery);
	Hashtable anganHash=new Hashtable();
	while(rs2.next())
	{
		anganHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String schoolsCompQuery="select substr(W.office_code,2,2),COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and W.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null) and work_cancel_dt is null  and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE <>'01' and c.school_code=d.school_code  group by substr(W.office_code,2,2) order by 1";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(schoolsCompQuery);
	Hashtable schoolsCompHash=new Hashtable();
	while(rs2.next())
	{
		schoolsCompHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String anganiVadiCompQuery="select substr(W.office_code,2,2),COUNT(*)  FROM RWS_WORK_ADMN_TBL W ,RWS_WORK_SCHOOL_LNK_TBL c,RWS_SCHOOL_MASTER_TBL d where substr(w.work_id,7,2)='11' and w.work_id in(select work_id from rws_work_completion_tbl where date_of_completion is not null) and work_cancel_dt is null  and c.work_id=w.work_id and c.hab_code=d.hab_code and d.SCHOOL_CATEGORY_CODE ='01' and c.school_code=d.school_code group by substr(W.office_code,2,2) order by 1";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(anganiVadiCompQuery);
	Hashtable anganCompHash=new Hashtable();
	while(rs2.next())
	{
		anganCompHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




stmt3=conn.createStatement();



String query="select dcode,dname from rws_district_tbl  where dcode <>'16'";
if(dcode!=null && !dcode.equals("")){
	query+=" and dcode='"+dcode+"'";
}
query+=" order by 1";

//112000
//112100

//System.out.println("Main Query"+query);
rs1=stmt2.executeQuery(query);
String dname="";
double gschoolCount=0,ganganiCount=0;double  sCount=0,aCount=0,gschoolCount1=0,ganganiCount1=0;double  sCount1=0,aCount1=0;


double per1=0,per2=0;
while(rs1.next()){



%>
<tr>
<td class=rptLabel><%=count++ %></td>
<% 
if(!dname.equals(rs1.getString(2))){
dname=rs1.getString(2);
%>
<td  class=rptLabel><%=dname %></td>
<% }
else{
%>
<td  class=rptLabel></td>
<%} %>

 


<% 
  String sch=(String)schoolsHash.get(rs1.getString(1));
  String ang=(String)anganHash.get(rs1.getString(1));
  String sch1=(String)schoolsCompHash.get(rs1.getString(1));
  String ang1=(String)anganCompHash.get(rs1.getString(1));
  

   if(sch!=null && !sch.equals("null")){
    sCount=Integer.parseInt(sch);

    gschoolCount+=sCount;
}
 if(ang!=null && !ang.equals("null")){
    aCount=Integer.parseInt(ang);
    ganganiCount+=aCount;
}
   if(sch1!=null && !sch1.equals("null")){
    sCount1=Integer.parseInt(sch1);
    gschoolCount1+=sCount1;
}
 if(ang1!=null && !ang1.equals("null")){
    aCount1=Integer.parseInt(ang1);
    ganganiCount1+=aCount1;
}

if(sCount!=0 && sCount1!=0 && sCount>=sCount1){
//float percent = (100 * downloaded) / total;
per1=(100*sCount1)/sCount;
}else{
per1=0;
}
if(aCount!=0 && aCount1!=0 && aCount>=aCount1 ){
per2=(100*aCount1)/aCount;
}else{
per2=0;
}



%>
<td class=rptValue align=center><a href="#" onclick="viewWorks('rws_rfd_schools_drill.jsp?type=1&dcode=<%=rs1.getString(1) %> ')"><%=ndf1.format(sCount) %></a></td><td class=rptValue align=center><a href="#" onclick="viewWorks('rws_rfd_schools_drill.jsp?type=2&dcode=<%=rs1.getString(1) %> ')"><%=ndf1.format(sCount1) %></a></td><td class=rptValue><%=ndf.format(per1) %></td><td class=rptValue align=center><a href="#" onclick="viewWorks('rws_rfd_schools_drill.jsp?type=3&dcode=<%=rs1.getString(1) %> ')"><%=ndf1.format(aCount) %></a></td><td class=rptValue align=center><a href="#" onclick="viewWorks('rws_rfd_schools_drill.jsp?type=4&dcode=<%=rs1.getString(1) %> ')"><%=ndf1.format(aCount1) %></a></td><td class=rptValue><%=ndf.format(per2) %></td></tr>


<% 
sCount=0;aCount=0;
sCount1=0;aCount1=0;
//per1=0;per2=0;
}



%>
<tr><td class=rptlabel colspan=2>Total:</td><td class=rptlabel align=center><%=ndf1.format(gschoolCount) %></td><td class=rptLabel align=center><%=ndf1.format(gschoolCount1) %></td><td class=rptlabel align=center><%=ndf.format((gschoolCount1*100)/gschoolCount) %></td><td class=rptLabel align=center><%=ndf1.format(ganganiCount) %></td><td class=rptLabel align=center><%=ndf1.format(ganganiCount1) %></td><td class=rptLabel align=center><%=ndf.format((ganganiCount1*100)/ganganiCount) %></td></tr>
<% 

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>