<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
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

	<% 

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dcode="";
	if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");    
	   }
    DecimalFormat ndf = new DecimalFormat("##.##");

    DecimalFormat ndf1 = new DecimalFormat("##");



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
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a><a href="./rws_asset_habs_status_svs_excel.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" ">
		<td align="center" class="rptHeading" colspan=14>Status Of SVS(PWS/MPWS/DP) Schemes</td>	
	</tr>
		<tr >
		<td class=btext rowspan=2 align=center>Sl.No</td>
		<td class=btext rowspan=2 align=center>District</td>
<td class=btext rowspan=2 align=center>No Of Schemes</td>
<td class=btext rowspan=2 align=center>Habs Covered</td>
<td class=btext  align=center colspan=8 nowrap >Functioning(Working)</td>
<td class=btext colspan=2 align=center >Not Functioning(Not Working/DRIED/SEASONAL/CONDEMED)</td>
</tr>
<tr>
<td class=btext align="center"  >No Of Schemes</td>
 <td  class=btext align="center"  >Habs Covered</td>	
		<td  class=btext align="center"  >FC</td>	
		<td  class=btext align="center"  >PC4</td>
	<td  class=btext align="center"  >PC3</td>
	<td  class=btext align="center"  >PC2</td>
	<td  class=btext align="center"  >PC1</td>
	<td  class=btext align="center"  >NSS</td>
	<td class=btext align="center"  >No Of Schemes</td>
 <td  class=btext align="center"  >Habs Covered</td>	
	



</tr>


<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext  >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center"  class=btext>8</td><td align="center" class=btext >9</td><td align="center" class=btext >10</td><td align="center" class=btext >11</td><td align="center" class=btext >12</td><td align="center" class=btext >13</td><td align="center" class=btext >14</td>
</tr>


<%
Statement stmt2=null,stmt3=null;
ResultSet rs1=null,rs3=null,rs2=null;

int count=1;
  try{
    stmt2=conn.createStatement();
    stmt3=conn.createStatement();

//Financial Queries

String totalMVSSchemesQuery="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl where TYPE_OF_ASSET_CODE in(01,02,09) and ASSET_STATUS is not null group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("totalMVSSchemesQuery"+totalMVSSchemesQuery);
	 rs2=stmt3.executeQuery(totalMVSSchemesQuery);
	Hashtable totlaMVSHash=new Hashtable();
	while(rs2.next())
	{
		totlaMVSHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String schemeHabs="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl  a,rws_asset_hab_tbl b where a.TYPE_OF_ASSET_CODE in(01,02,09) and a.ASSET_CODE =b.ASSET_CODE and ASSET_STATUS is not null  group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(schemeHabs);
	Hashtable schHabsHash=new Hashtable();
	while(rs2.next())
	{
		schHabsHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();


String workingSchemes="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl where TYPE_OF_ASSET_CODE in(01,02,09) and ASSET_STATUS ='01' group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("New Works"+newWorksEstCostQuery);
	 rs2=stmt3.executeQuery(workingSchemes);
	Hashtable workSchemeHash=new Hashtable();
	while(rs2.next())
	{
		workSchemeHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String wschemeHabs="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl  a,rws_asset_hab_tbl b ,rws_complete_hab_view c where a.TYPE_OF_ASSET_CODE in(01,02,09)  and ASSET_STATUS ='01'  and a.ASSET_CODE =b.ASSET_CODE  and c.panch_code=b.hab_code and c.coverage_status<>'UI' group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("wschemeHabs"+wschemeHabs);
	 rs2=stmt3.executeQuery(wschemeHabs);
	Hashtable wschHabsHash=new Hashtable();
	while(rs2.next())
	{
		wschHabsHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();




String coveredHabsALL="select c.CIRCLE_OFFICE_CODE,sum(case when a.coverage_status='FC' then 1 else 0 end)fc,sum(case when a.coverage_status='PC4' then 1 else 0 end) PC4,sum(case when a.coverage_status='PC3' then 1 else 0 end)PC3,sum(case when a.coverage_status='PC2' then 1 else 0 end) PC2,sum(case when a.coverage_status='PC1' then 1 else 0 end)PC1,sum(case when a.coverage_status='NSS' then 1 else 0 end) NSS,sum(case when a.coverage_status='NC' then 1 else 0 end) NC,sum(case when a.coverage_status='UI' then 1 else 0 end) UI  from rws_asset_mast_tbl  c,rws_asset_hab_tbl b,rws_complete_hab_view a where c.TYPE_OF_ASSET_CODE in(01,02,09) and ASSET_STATUS ='01'  and c.ASSET_CODE =b.ASSET_CODE  and b.hab_code=a.PANCH_CODE group by c.CIRCLE_OFFICE_CODE order by c.CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("coveredHabsALL"+coveredHabsALL);
	 rs2=stmt3.executeQuery(coveredHabsALL);
	Hashtable coveredHabsALLHash=new Hashtable();
	while(rs2.next())
	{
		coveredHabsALLHash.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6)+"@"+rs2.getString(7));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





String NotMVSSchemesQuery="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl where TYPE_OF_ASSET_CODE in(01,02,09) and ASSET_STATUS <>'01' group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("NotMVSSchemesQuery"+NotMVSSchemesQuery);
	 rs2=stmt3.executeQuery(NotMVSSchemesQuery);
	Hashtable totlaNotMVSHash=new Hashtable();
	while(rs2.next())
	{
		totlaNotMVSHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();



String schemeNotHabs="select CIRCLE_OFFICE_CODE,count(*) from rws_asset_mast_tbl  a,rws_asset_hab_tbl b where a.TYPE_OF_ASSET_CODE in(01,02,09)  and ASSET_STATUS <>'01'  and a.ASSET_CODE =b.ASSET_CODE  group by CIRCLE_OFFICE_CODE order by CIRCLE_OFFICE_CODE";

		stmt3=conn.createStatement();
//System.out.println("ExpQuery"+expQuery);
	 rs2=stmt3.executeQuery(schemeNotHabs);
	Hashtable schNotHabsHash=new Hashtable();
	while(rs2.next())
	{
		schNotHabsHash.put(rs2.getString(1),rs2.getString(2));
	}
	if(rs2!=null)rs2.close();
	if(stmt3!=null)stmt3.close();





stmt3=conn.createStatement();



String query="";



query="select dname,dcode from rws_district_tbl where dcode <>'16' ";
if(dcode!=null && !dcode.equals("")){
		query+=" and dcode='"+dcode+"'";
	}
	query+=" order by dcode";



//112000
//112100

System.out.println("Main Query"+query);
rs1=stmt2.executeQuery(query);
String dname="";



double per1=0,per2=0;
int mvsSchems=0,gmvsSchems=0,mvsSchemHabs=0,gmvsSchemHabs=0,wmvsSchems=0,gwmvsSchems=0,wmvsSchemHabs=0,gwmvsSchemHabs=0;
int nmvsSchems=0,gnmvsSchems=0,nmvsSchemHabs=0,gnmvsSchemHabs=0;
int pc4=0,pc3=0,pc2=0,pc1=0,fc=0,nss=0;
int gpc4=0,gpc3=0,gpc2=0,gpc1=0,gfc=0,gnss=0;
while(rs1.next()){

if(totlaMVSHash.get(rs1.getString(2))!=null){
mvsSchems=Integer.parseInt((String)totlaMVSHash.get(rs1.getString(2)));
}

if(schHabsHash.get(rs1.getString(2))!=null){
mvsSchemHabs=Integer.parseInt((String)schHabsHash.get(rs1.getString(2)));
}
if(workSchemeHash.get(rs1.getString(2))!=null){
wmvsSchems=Integer.parseInt((String)workSchemeHash.get(rs1.getString(2)));

}

if(wschHabsHash.get(rs1.getString(2))!=null){
wmvsSchemHabs=Integer.parseInt((String)wschHabsHash.get(rs1.getString(2)));
}


if(coveredHabsALLHash.get(rs1.getString(2))!=null){
String value=(String)coveredHabsALLHash.get(rs1.getString(2));

String values[]=value.split("@");
 if(values[0]!=null && !values[0].equals("")){
      fc=Integer.parseInt(values[0]);
}
if(values[1]!=null && !values[1].equals("")){
      pc4=Integer.parseInt(values[1]);
}
if(values[2]!=null && !values[2].equals("")){
      pc3=Integer.parseInt(values[2]);
}
if(values[3]!=null && !values[3].equals("")){
      pc2=Integer.parseInt(values[3]);
}
if(values[4]!=null && !values[4].equals("")){
      pc1=Integer.parseInt(values[4]);
}
if(values[5]!=null && !values[5].equals("")){
      nss =Integer.parseInt(values[5]);
}
}


if(totlaNotMVSHash.get(rs1.getString(2))!=null){
nmvsSchems=Integer.parseInt((String)totlaNotMVSHash.get(rs1.getString(2)));

}

if(schNotHabsHash.get(rs1.getString(2))!=null){
nmvsSchemHabs=Integer.parseInt((String)schNotHabsHash.get(rs1.getString(2)));
}

gfc+=fc;
gpc4+=pc4;
gpc3+=pc3;
gpc2+=pc2;
gpc1+=pc1;
gnss+=nss;

gmvsSchems+=mvsSchems;
gmvsSchemHabs+=mvsSchemHabs;
gwmvsSchems+=wmvsSchems;
gwmvsSchemHabs+=wmvsSchemHabs;
gnmvsSchemHabs+=nmvsSchemHabs;
gnmvsSchems+=nmvsSchems;


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
<%} 

%>
<td  class=rptValue><a href="#" onclick="viewWorks('rws_asset_habs_status_drill.jsp?type=3&subType=1&dcode=<%=rs1.getString(2) %> ')"><%=mvsSchems %></a></td>
<td  class=rptValue><a href="#" onclick="viewWorks('rws_asset_habs_status_drill.jsp?type=4&subType=1&dcode=<%=rs1.getString(2) %> ')"><%=mvsSchemHabs %></a></td>
<td  class=rptValue><%=wmvsSchems %></td>
<td  class=rptValue><%=wmvsSchemHabs %></td>
<td  class=rptValue><%=fc %></td>
<td  class=rptValue><%=pc4 %></td>
<td  class=rptValue><%=pc3 %></td>
<td  class=rptValue><%=pc2 %></td>
<td  class=rptValue><%=pc1 %></td>
<td  class=rptValue><%=nss %></td>
<td  class=rptValue><a href="#" onclick="viewWorks('rws_asset_habs_status_drill.jsp?type=1&subType=1&dcode=<%=rs1.getString(2) %> ')"><%=nmvsSchems %></a></td>
<td  class=rptValue><a href="#" onclick="viewWorks('rws_asset_habs_status_drill.jsp?type=2&subType=1&dcode=<%=rs1.getString(2) %> ')"><%=nmvsSchemHabs %></a></td>



<% 
wmvsSchemHabs=0;mvsSchems=0;wmvsSchems=0;
fc=0;nss=0;pc4=0;pc3=0;pc2=0;pc1=0;
nmvsSchems=0;nmvsSchemHabs=0;
}

%>
<tr><td class=btext colspan=2 align=center>Total:</td><td class=btext><%=gmvsSchems %></td><td class=btext><%=gmvsSchemHabs %></td><td class=btext><%=gwmvsSchems %></td><td class=btext><%=gwmvsSchemHabs %></td><td class=btext><%=gfc %></td><td class=btext><%=gpc4 %></td><td class=btext><%=gpc3 %></td><td class=btext><%=gpc2 %></td><td class=btext><%=gpc1 %></td><td class=btext><%=gnss %></td><td class=btext><%=gnmvsSchems %></td><td class=btext><%=gnmvsSchemHabs %></td></tr>
<% 

}catch(Exception e){
  e.printStackTrace();
}

 %>

</table>	
</html>