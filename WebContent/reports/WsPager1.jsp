<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ page session="false" %>
<%@ taglib uri="http://jsptags.com/tags/navigation/pager" prefix="pg" %>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>W A T E R S O F T</title>
<style type="text/css">
A.nodec { text-decoration: none; }
</style>
<script language="JavaScript">
function goSearch(last,dist,rmandal,panchayat,village,hab,assetcode)
{
	//alert(last);
	//alert(document.forms[0].go.value);
	if(parseInt(document.forms[0].go.value)>parseInt(last))
	{
		alert("Maximum Pages:"+last);
		document.forms[0].go.value='';
	}
	else
	{
		var url = "WsPager1.jsp?pager.offset="+document.forms[0].go.value+"&district="+dist+"&mandal="+rmandal+"&panchayat="+panchayat+"&village="+village+"&hab="+hab+"&asset="+assetcode;
		var url1 = "<a href="+url+">GO</a>";
		document.getElementById("a").innerHTML  = url1;
	}
}
function popWinOpen(code) {
var assetCode=document.getElementById(""+code+"").value;
var zURL="showHabitations.jsp?assetCode="+assetCode;
var zWidth=600,zHeight=400;
var popFeatures = "width=" + zWidth + ",height=" + zHeight + ",toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1";
myWin = window.open(zURL,'expenditure',popFeatures);
myWin.focus();
}
</script>
</head>
<body bgcolor="#ffffff">
<jsp:declaration>

public String getAssetScheme(String result)
{

return result;
}
</jsp:declaration>
<%
	 String rDist = request.getParameter("district");
	 String rMandal = request.getParameter("mandal");
 	 String rPanchayat = request.getParameter("panchayat");
 	 String rVillage = request.getParameter("village");
 	 String rHab = request.getParameter("hab");
	 String assetcode= request.getParameter("asset");
 	 String assetName= request.getParameter("assetName");
 	 String assetLoc= request.getParameter("assetLoc");
    String style = "simple";//getParam(request, "style", "simple");
    String position = "top";//getParam(request, "position", "top");
    String index = "center";//getParam(request, "index", "center");
    int maxPageItems = 10;//getParam(request, "maxPageItems", 10);
    int maxIndexPages = 10;//getParam(request, "maxIndexPages", 10);
%>
<form action="<%= request.getRequestURI() %>" method="get">
<center>

</td>
</tr>

</table>
 
<pg:pager
    items="10"
    index="<%= index %>"
    maxPageItems="<%= maxPageItems %>"
    maxIndexPages="<%= maxIndexPages %>"
    isOffset="<%= true %>"
    export="offset,currentPageNumber=pageNumber"
    scope="request">
<%-- keep track of preference --%>
  <pg:param name="style"/>
  <pg:param name="position"/>
  <pg:param name="index"/>
  <pg:param name="maxPageItems"/>
  <pg:param name="maxIndexPages"/>

 <input type="hidden" name="pager.offset" value="<%= offset %>">

<%
	int offsett = offset.intValue();
	if(offsett==0 || offsett==1)offsett=1;
	int offset1 = offsett+9;
	int offsettqry = 0;
	if(offset.intValue()==0 || offset.intValue()==1)offsettqry = 1;
	else offsettqry = ((offsett-1)*20)+1;
	int offsetqry1 = offsettqry+19;
	int totCount = 0;
	String totQuery = "select distinct count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'  and hd.hab_code=a.hab_code";
	if(rMandal!=null && !rMandal.equals("-1"))totQuery +=" and m.mcode='"+rMandal+"'";
	if(rPanchayat!=null && !rPanchayat.equals("-1"))totQuery +=" and p.pcode='"+rPanchayat+"'";
	if(rVillage!=null && !rVillage.equals("-1"))totQuery +=" and v.vcode='"+rVillage+"'";
	if(rHab!=null && !rHab.equals("-1"))totQuery +=" and hd.hab_code='"+rHab+"'";	
	if(assetName!=null && !assetName.equals("-1"))totQuery +=" and a.asset_name like '"+assetName+"'";
	if(assetLoc!=null && !assetLoc.equals("-1"))totQuery +=" and a.location like '"+assetLoc+"'";
	////System.out.println("tot qry:"+totQuery);

	Statement stt = conn.createStatement();
	ResultSet totrs = stt.executeQuery(totQuery);
	if(totrs.next())
	{
		totCount = totrs.getInt(1);
	}
	if(totrs!=null)totrs.close();
	if(stt!=null)stt.close();
	 int div = totCount/20;
int d = totCount%20;
if(d>0)div++;
int totalpgno=div;
////////System.out.println("totalPg:"+totalpgno);
int currentpageno = 0;
if(offsett==0)
	currentpageno =offsett+1;
else 
	currentpageno =offsett;
int firstpgno=1;
int prevpgno = currentpageno - 1;
int nextpgno = offsett + 1;
int lastpgno=totalpgno;
	%>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=white style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:history.go(-1)">Back|</a></td>
				 
			</tr>
		</table>
	</caption>
	<tr>
	<td colspan="2" align="center" class="rptHeading">
	Current Page :: <%=offsett%>&nbsp;&nbsp;&nbsp;&nbsp;Total Pages: <%=totalpgno%>&nbsp;&nbsp;&nbsp;Total Assets :: <%=totCount%>
	</td>
</tr>
	<%--

    <% while (enumeration.hasMoreElements()) { %>
	<pg:item><%= enumeration.nextElement() %><br></pg:item>
    <% } %>

   --%>
    <table border = 1 bordercolor="black" style="border-collapse:collapse" bgcolor="#ffffff" >
 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=11><font color="white">Asset - Check List Report</font></td>	
   </tr>
    <tr bgcolor="#8A9FCD" align="center">
    <td align="center" class="rptHeading">SlNo</td>
    <td align="center" class="rptHeading">AssetName/SchemeCode</td>
    <td align="center" class="rptHeading">District/<br> Division/<br> Sub Division/<br>Mandal/<br>Panchyat/<br>village/<br> Habitation</td>
   <td align="center" class="rptHeading">Linkage Habitation(s)</td> 
   <td align="center" class="rptHeading">Location/<br>Date of Creation/<br>Cost of Asset/<br>Habs Benifited/<br>Population Benifited</td> 
   <td align="center" class="rptHeading"><b>SOURCE</b></td>
   <td align="center" class="rptHeading"><b>HEAD WORKS</b></td>
    <td align="center" class="rptHeading"><b>PIPELINE</b></td>
    <td align="center" class="rptHeading"><b>SR.RESERVOIRS</b></td>
    <td align="center" class="rptHeading"><b>OTHERS</b></td>
    <td align="center" class="rptHeading"><b>PUMPING</b></td>
	</tr>
	<%
//	String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"' and hd.hab_code=a.hab_code order by asset_code) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";
String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,a.TYPE_OF_ASSET_CODE,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,a. division_office_code dc,a.subdivision_office_code sdc,nvl(do.division_office_name,'-')dn,nvl (sdo.subdivision_office_name,'-') sdn,s.scheme_code,nvl(a.LOCATION,'-')LOCATION,nvl(a.ASSET_COST,'0')ASSET_COST,nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-') as DATE_CREATION,POPU_BENEFITED from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,rws_division_office_tbl do,rws_subdivision_office_tbl sdo where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'";
	if(rMandal!=null && !rMandal.equals("-1"))query +=" and m.mcode='"+rMandal+"'";
	if(rPanchayat!=null && !rPanchayat.equals("-1"))query +=" and p.pcode='"+rPanchayat+"'";
	if(rVillage!=null && !rVillage.equals("-1"))query +=" and v.vcode='"+rVillage+"'";
	if(rHab!=null && !rHab.equals("-1"))query +=" and hd.hab_code='"+rHab+"'";
	if(assetName!=null && !assetName.equals("-1"))query +=" and a.asset_name like '"+assetName+"'";
	if(assetLoc!=null && !assetLoc.equals("-1"))query +=" and a.location like '"+assetLoc+"'";
	query += " and d.dcode=do.circle_office_code and d.dcode=sdo.circle_office_code and do.circle_office_code=sdo.circle_office_code and a.division_office_code=do.division_office_code and a.division_office_code=sdo.division_office_code and do.division_office_code=sdo.division_office_code and a.subdivision_office_code=sdo.subdivision_office_code and hd.hab_code=a.hab_code order by d.dname,nvl (do.division_office_name,'-'),nvl (sdo.subdivision_office_name,'-'),m.mname,p.pname,v.vname,h.panch_name) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";
	
	 int slno = 0;
	stmt=conn.createStatement();
	 //////System.out.println("qry:"+query);

   rs=stmt.executeQuery(query);
    Statement stmt2=null;
	slno = offsettqry;
   while(rs.next())
   { 
     ////////System.out.println(" in wuhile loop  00");
	%>
   <tr>
   <td class=rptValue><%=slno++%></td>
   <td class=rptvalue><font size=2><%=rs.getString(1).toUpperCase()%>/<BR><%=rs.getString("scheme_code")%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString("dname")%>/<br><%=rs.getString("DN")%>/<br><%=rs.getString("SDN")%>/<br><%=rs.getString("mname")%>/<br><%=rs.getString("pname")%>/<br><%=rs.getString("vname")%>/<br><%=rs.getString("panch_name")%></font> </td>  
     <% query="select p.hab_code,(census_plain_popu + census_sc_popu + census_st_popu+FLOAT_POP)as totpop  from rws_habitation_directory_tbl p,rws_asset_hab_tbl a where p.hab_code=a.hab_code and asset_code='"+rs.getString(3)+"'";  
	 stmt2=conn.createStatement();
       ResultSet rs2=stmt2.executeQuery(query);
       %><td class=rptValue>
       <%
		   int habcount=0,totPop=0;
	   		double totPop1=0.0;
	   while(rs2.next())
       {
		   habcount++;
		   totPop += rs2.getInt(2);
	   }
	   if(!assetcode.equals("04"))
	   {
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		   totPop1 = (totPop * Math.pow(1.02,Integer.parseInt(sdf.format(new java.util.Date())) - 2001));
	   }
	   else
	   {
		   totPop1 = rs.getDouble("POPU_BENEFITED");
	   }
	   	if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	   %>
	   <%if(habcount > 1){
	   String hrefstring="javascript:popWinOpen("+slno+ ")";
		   %>
	   <input type=hidden name=<%=slno%> value=<%=rs.getString("asset_code")%>><a href=<%=hrefstring%>><%=habcount%></a>
	   <%}else{%><%=habcount%><%}%>
		 </td>
       <%
       	// nic.watersoft.reports.rws_asset_CheckList_Data d= new nic.watersoft.reports.rws_asset_CheckList_Data();
		 nic.watersoft.reports.rws_asset_CheckList_Data dd= new nic.watersoft.reports.rws_asset_CheckList_Data();
		String aa = dd.getCheckListAssetData(rs.getString(3),assetcode,conn);
		//String chkddata=dd.getCheckListDataOne(rs.getString(3),rs.getString("TYPE_OF_ASSET_CODE"),rs.getString("hab_code"),rs.getString("scheme_code"));
	     String[] aaa = aa.split("/");%>
	     <td class=rptValue><%=rs.getString("LOCATION")%>/<br><%=rs.getString("DATE_CREATION")%>/<br><%=rs.getString("ASSET_COST")%>/<br><%=habcount%>/<br><%=(int)Math.round(Math.ceil(totPop1))%>/<br></td>
	     <%
		if(!aaa[0].equals("--") || !aaa[1].equals("--")){%>
		
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
        
       <%if(!aaa[0].equals("--")){%>

		<td><font size=1>SUBSURFACE SOURCE</font></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
		<%}
		if(!aaa[1].equals("--")){%><tr class="mystyle1">
		<td><font size=1>SURFACE SOURCE</font></td>
		<td><font size=1><%=aaa[1]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top" class=rptValue>
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }%>
		</table></td>
		 <%if(!aaa[2].equals("--") || !aaa[3].equals("--") ||  !aaa[4].equals("--") ||  !aaa[5].equals("--") ||  !aaa[6].equals("--") ||   !aaa[7].equals("--") ||  !aaa[8].equals("--") ||  !aaa[9].equals("--") ||  !aaa[10].equals("--") ||   !aaa[11].equals("--") ||  !aaa[12].equals("--") ){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
	
		<%if(!aaa[2].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>RAW WATER COLLECTION WELL</font></td>
		<td><font size=1><%=aaa[2]%></font></td></tr>
		<%}
		if(!aaa[3].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>SS TANK</font></td>
		<td><font size=1><%=aaa[3]%></font></td></tr>
		<%}
		if(!aaa[4].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>SS FILTER</font></td>
		<td><font size=1><%=aaa[4]%></font></td></tr>
		<%}
		if(!aaa[5].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>RS FILTER</font></td>
		<td><font size=1><%=aaa[5]%></font></td></tr>
		<%}
		if(!aaa[6].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>SUMP</font></td>
		<td><font size=1><%=aaa[6]%></font></td></tr>
		<%}
		if(!aaa[7].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>FOOT PATH BRIDGE</font></td>
		<td><font size=1><%=aaa[7]%></font></td></tr>
		<%}
		if(!aaa[8].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>PUMP HOUSE</font></td>
		<td><font size=1><%=aaa[8]%></font></td></tr>
		<%}
		if(!aaa[9].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>WATCHMAN QUARTER</font></td>
		<td><font size=1><%=aaa[9]%></font></td></tr>
		<%}
		if(!aaa[10].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>CLEAR WATER COLLECTION WELL</font></td>
		<td><font size=1><%=aaa[10]%></font></td></tr>
		<%}
		if(!aaa[11].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>MICRO FILTER</font></td>
		<td><font size=1><%=aaa[11]%></font></td></tr>
		<%}
		if(!aaa[12].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>RO PLANTS</font></td>
		<td><font size=1><%=aaa[12]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
		<%}%></table></td>
		 <%if(!aaa[13].equals("--") ||  !aaa[14].equals("--") ||  !aaa[15].equals("--")){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[13].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>PUMPING MAIN</font></td>
		<td><font size=1><%=aaa[13]%></font></td></tr>
		<%}
		if(!aaa[14].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>GRAVITY MAIN</font></td>
		<td><font size=1><%=aaa[14]%></font></td></tr>
		<%}
		if(!aaa[15].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>DISTRIBUTION</font></td>
		<td><font size=1><%=aaa[15]%></font></td></tr>
		<%}
	   }
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }%>
		</table></td>
		<%if(!aaa[16].equals("--")  || !aaa[17].equals("--") ||  !aaa[18].equals("--") ||  !aaa[19].equals("--") || !aaa[20].equals("--") || !aaa[21].equals("--") ){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[16].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>OHSR</font></td>
		<td><font size=1><%=aaa[16]%></font></td></tr>
		<%}
		if(!aaa[17].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>OHBR</font></td>
		<td><font size=1><%=aaa[17]%></font></td></tr>
		<%}
		if(!aaa[18].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>GLSR</font></td>
		<td><font size=1><%=aaa[18]%></font></td></tr>
		<%}
		if(!aaa[19].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>GLBR</font></td>
		<td><font size=1><%=aaa[19]%></font></td></tr>
		<%}
		if(!aaa[20].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>BPT</font></td>
		<td><font size=1><%=aaa[20]%></font></td></tr>
		<%}
		if(!aaa[21].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>CISTERNS</font></td>
		<td><font size=1><%=aaa[21]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }%>
		</table></td>
		 <%if(!aaa[22].equals("--")  || !aaa[23].equals("--") ||  !aaa[24].equals("--")){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<%
		if(!aaa[22].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>MISCELLANEOUS</font></td>
		<td><font size=1><%=aaa[22]%></font></td></tr>
		<%}
		if(!aaa[23].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>CHLORINATION</font></td>
		<td><font size=1><%=aaa[23]%></font></td></tr>
		<%}
		if(!aaa[24].equals("--")){%> <tr class="mystyle1">
		<td><font size=1>O AND M</font></td>
		<td><font size=1><%=aaa[24]%></font></td></tr>
		<%}
		}
		else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
				 <tr><td colspan=2 class=rptValue></td>
			<%
	   }%>
		</table></td>
		<%
		if(!aaa[25].equals("--")){%>
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
		<td><font size=1>PUMPSETS</font></td>
		<td><font size=1><%=aaa[25]%></font></td></tr>
		<%}
				else
	   {
			%>
			<td align="center" valign="top">
			<table width="130" border="0" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1"><tr><td colspan=2 class=rptValue></td>
			<%
	   }%>
		</table></td>


 <%}
 	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
//	if(conn!=null)conn.close();
if(totCount==0){%><tr><td colspan="11" align="center" valign="top" class=rptValue>No Assets</td></tr>
<%}%>
 </table>
 <table>
 <tr><td>
 <%
if(totCount!=0){
String firstpgurl = "WsPager1.jsp?pager.offset=0&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode+"";
String prevpgurl = "WsPager1.jsp?pager.offset="+prevpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
String nextpgurl = "WsPager1.jsp?pager.offset="+nextpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
String lastpgurl = "WsPager1.jsp?pager.offset="+totalpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
if(currentpageno!=firstpgno){
%>

  <a href="<%= firstpgurl %>"><nobr>[ First ]</nobr></a>
  <a href="<%= prevpgurl %>"><nobr>[ Prev ]</nobr></a>
<%}
  if(totalpgno>10)
  {
	  for(int i=currentpageno,j=currentpageno-9;i<currentpageno+10;i++,j++){
if(i<=totalpgno)
	{
	String currenturl = "WsPager1.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
	if(currentpageno==i){%>
<font color="red" face="verdana" size="2"><%= i %>
<!--   <a href="<%= currenturl %>"> <font color="red"><%= i %></a> -->
   <%}
	else
		{
%>
   <a href="<%= currenturl %>"><%= i %></a>
<%
		}%>
<%}
	else
	{
		%>
		<%String currenturl = "WsPager1.jsp?pager.offset="+j+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
		if(currentpageno==j){%>
<!--   <a href="<%= currenturl %>"> <font color="red"><%= j%></a>
 -->	<%}
	else
		{
%>
<!--    <a href="<%= currenturl %>"><%= j %></a>
 --><%
		}
	}
	}
  }
  else
  {
	  for(int i=1;i<=totalpgno;i++){
		  String currenturl = "WsPager1.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
		if(currentpageno==i){%>
<font color="red" face="verdana" size="2"><%= i %>
<!--   <a href="<%= currenturl %>"> <font color="red"><%= i %></a> -->
   <%}
	else
		{
%>
   <a href="<%= currenturl %>"><%= i %></a>
<%
		}
	  }
  }
	if(currentpageno!=totalpgno){%>
<a href="<%= nextpgurl %>"><nobr>[ Next ]</nobr></a>
<a href="<%= lastpgurl %>"><nobr>[ Last ]</nobr></a>
<%}%></td>
<td>
<font face="verdana" color="red" size="2">Go to Page:<input type="text" name="go" maxlength="4" size="2" onkeyup="goSearch('<%=lastpgno%>','<%=rDist%>','<%=rMandal%>','<%=rPanchayat%>','<%=rVillage%>','<%=rHab%>','<%=assetcode%>')">
</td>
<td>
<div id="a" style="display:block"><a href="#">GO</a>
</div>
</td></tr>
 </table>
  <%}%>

  <hr>


</pg:pager>
<tr><td>
<font style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;"><%@ include file = "footer.jsp" %></font>
</td></tr>
</center>
</body>
</html>
<%@ include file="connClose.jsp" %>
<%}finally{}%>