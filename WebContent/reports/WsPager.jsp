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
function fnAssetComp(assetCode,typeofasset)
{
	var zURL="showSubComp.jsp?assetCode="+assetCode+"&typeOfAssetCode="+typeofasset;
	if(typeofasset=="01" || typeofasset=="02" || typeofasset=="03" || typeofasset=="09")
		var popFeatures = "width=950,height=200,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
	else
		var popFeatures = "width=450,height=200,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=100,top=100";
	myWin = window.open(zURL,'expenditure',popFeatures);
	myWin.focus();
}

function goSearch(last,dist,rmandal,panchayat,village,hab,distname,rmandalname,panchayatname,villagename,habname,typeOfAssetName,assetName,assetLoc,assetcode)
{
	assetName=assetName.replace(/\s/g,"%20");
	assetLoc=assetLoc.replace(/\s/g,"%20");
	//alert(document.forms[0].go.value);
	if(parseInt(document.forms[0].go.value)>parseInt(last))
	{
		alert("Maximum Pages:"+last);
		document.forms[0].go.value='';
	}
	else
	{
		var url = "WsPager.jsp?pager.offset="+document.forms[0].go.value+"&district="+dist+"&mandal="+rmandal+"&panchayat="+panchayat+"&village="+village+"&hab="+hab+"&asset="+assetcode+"&districtName="+distname+"&mandalName="+rmandalname+"&panchayatName="+panchayatname+"&villageName="+villagename+"&habName="+habname+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
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

	 String rDistName = request.getParameter("districtName");
	 ////System.out.println("dist name:"+rDistName);
	 String rMandalName = request.getParameter("mandalName");
 	 String rPanchayatName = request.getParameter("panchayatName");
 	 String rVillageName = request.getParameter("villageName");
 	 String rHabName = request.getParameter("habName");
  	 String typeOfAssetName = request.getParameter("typeOfAssetName");

	 if(rDistName!=null && rDistName.equals("SELECT..."))rDistName="";
 	 if(rMandalName!=null && rMandalName.equals("SELECT..."))rMandalName="";
	 if(rPanchayatName!=null && rPanchayatName.equals("SELECT..."))rPanchayatName="";
	 if(rVillageName!=null && rVillageName.equals("SELECT..."))rVillageName="";
	 if(rHabName!=null && rHabName.equals("SELECT..."))rHabName="";
	if(typeOfAssetName!=null && typeOfAssetName.equals("-1"))typeOfAssetName="";
	 if(assetName!=null && assetName.equals("-1"))assetName="";
	if(assetLoc!=null && assetLoc.equals("-1"))assetLoc="";



	 String schemeTbl = "";
	 int rowsPerPage = 0;
	 if(assetcode!=null && (assetcode.equals("01") || assetcode.equals("02") || assetcode.equals("03") || assetcode.equals("09"))) 
	 {
		 schemeTbl = " rws_asset_scheme_tbl ";
		 rowsPerPage = 20;
	 }
	else if(assetcode!=null && assetcode.equals("04"))
	{
		schemeTbl = " RWS_HANDPUMP_ASSET_VIEW ";
		rowsPerPage = 100;
	}
	else if(assetcode!=null && (assetcode.equals("05") || assetcode.equals("06") || assetcode.equals("07")))
	{
		 schemeTbl = " rws_asset_scheme_tbl ";
		rowsPerPage = 100;
	}
/*	 String typeOfAssetName = "";
 	 if(session.getAttribute("typeOfAssetName") && ((String)session.getAttribute("typeOfAssetName")).equals(""))
		 typeOfAssetName = request.getParameter("typeOfAssetName");
	 else 
		typeOfAssetName = (String)session.getAttribute("typeOfAssetName");
	session.setAttribute("typeOfAssetName",typeOfAssetName);
   */ String style = "simple";//getParam(request, "style", "simple");
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
	else offsettqry = ((offsett-1)*rowsPerPage)+1;
	int offsetqry1 = offsettqry+(rowsPerPage-1);
	int totCount = 0;
	String totQuery = "select distinct count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,"+schemeTbl+" s where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'  and hd.hab_code=a.hab_code";
	if(rMandal!=null && !rMandal.equals("-1"))totQuery +=" and m.mcode='"+rMandal+"'";
	if(rPanchayat!=null && !rPanchayat.equals("-1"))totQuery +=" and p.pcode='"+rPanchayat+"'";
	if(rVillage!=null && !rVillage.equals("-1"))totQuery +=" and v.vcode='"+rVillage+"'";
	if(rHab!=null && !rHab.equals("-1"))totQuery +=" and hd.hab_code='"+rHab+"'";	
	if(assetName!=null && (!assetName.equals("-1") && !assetName.equals("")))totQuery +=" and a.asset_name like '"+assetName+"'";
	if(assetLoc!=null && (!assetLoc.equals("-1") && !assetLoc.equals("")))totQuery +=" and a.location like '"+assetLoc+"'";
	////System.out.println("tot qry:"+totQuery);

	Statement stt = conn.createStatement();
	ResultSet totrs = stt.executeQuery(totQuery);
	if(totrs.next())
	{
		totCount = totrs.getInt(1);
	}
	if(totrs!=null)totrs.close();
	if(stt!=null)stt.close();
	 int div = totCount/rowsPerPage;
int d = totCount%rowsPerPage;
if(d>0)div++;
int totalpgno=div;
//////////System.out.println("totalPg:"+totalpgno);
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
<tr><td colspan="2"><font face="verdana" size="2" color="red">Selection Criteria:</font></td></tr>
<tr>
<td colspan="2" align="left"><font face="verdana" size="2" color="blue">
<%if(rDistName!=null && !rDistName.equals("")){%>District : <%=rDistName%><%}%>
<%if(rMandalName!=null && !rMandalName.equals("")){%>&nbsp;&nbsp;Mandal : <%=rMandalName%><%}%>
<%if(rPanchayatName!=null && !rPanchayatName.equals("")){%>&nbsp;&nbsp;Panchayat : <%=rPanchayatName%><%}%>
<%if(rVillageName!=null && !rVillageName.equals("")){%>&nbsp;&nbsp;Village : <%=rVillageName%><%}%>
<%if(rHabName!=null && !rHabName.equals("")){%>&nbsp;&nbsp;Hab : <%=rHabName%><%}%>
<%if(typeOfAssetName!=null && !typeOfAssetName.equals("")){%>&nbsp;&nbsp;Type of Asset : <%=typeOfAssetName%><%}%>
<%if(assetName!=null && !assetName.equals("")){%>&nbsp;&nbsp;Asset Name : <%=assetName%><%}%>
<%if(assetLoc!=null && !assetLoc.equals("")){%>&nbsp;&nbsp;Asset Location : <%=assetLoc%><%}%>
</font>
</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
	<%--

    <% while (enumeration.hasMoreElements()) { %>
	<pg:item><%= enumeration.nextElement() %><br></pg:item>
    <% } %>

   --%>
    <table border = 1 bordercolor="black" style="border-collapse:collapse" bgcolor="#ffffff" >
 <tr bgcolor="#8A9FCD" align="center">
		 <td align="center" class="rptHeading" colspan=15><font color="white">Assets - Details Report</font></td>	
   </tr>
    <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading">Sl.No</td>
		<td align="center" class="rptHeading">District</td>
		<td align="center" class="rptHeading">Mandal</td>
		<td align="center" class="rptHeading">Habitation Code</td>
		<td align="center" class="rptHeading">Habitation Name</td>
		<td align="center" class="rptHeading">Asset Type</td>
		<td align="center" class="rptHeading">Scheme Code</td>
		<td align="center" class="rptHeading">Asset Name</td>
		<td align="center" class="rptHeading">Location</td>
		<td align="center" class="rptHeading">Date of Creation</td>
		<td align="center" class="rptHeading">Cost of Asset	</td>
		<td align="center" class="rptHeading">Asset	 Status</td>
		<td align="center" class="rptHeading">Habitations Benefitted</td>
		<td align="center" class="rptHeading">Population Benefitted</td>
<%
	if(assetcode!=null && (assetcode.equals("01") || assetcode.equals("02") || assetcode.equals("03") || assetcode.equals("09"))) 
	 {
%>
		<td align="center" class="rptHeading">Components</td>
<%	 
	}
	else if(assetcode!=null && assetcode.equals("04"))
	{
%>
		<td align="center" class="rptHeading">BORE WELL(S)</td>
<%	 
	}
	else if(assetcode!=null && assetcode.equals("05"))
	{
%>
		<td align="center" class="rptHeading">SHALLOW HAND PUMP(S)</td>
<%	 
	}
else if(assetcode!=null && assetcode.equals("06"))
	{
%>
		<td align="center" class="rptHeading">OPEN WELL(S)</td>
<%	 
	}
else if(assetcode!=null && assetcode.equals("07"))
	{
%>
		<td align="center" class="rptHeading">POND(S)</td>
<%	 
	}
%>

	</tr>
	<%
//	String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"' and hd.hab_code=a.hab_code order by asset_code) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";
	String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,a.TYPE_OF_ASSET_CODE,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,a. division_office_code dc,a.subdivision_office_code sdc,nvl(do.division_office_name,'-')dn,nvl (sdo.subdivision_office_name,'-') sdn,s.scheme_code,nvl(a.LOCATION,'-')LOCATION,nvl(a.ASSET_COST,'0')ASSET_COST,nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-') as DATE_CREATION,hd.census_plain_popu,hd.census_st_popu, hd.census_sc_popu,decode(type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMPS','05','SHALLOW HAND PUMPS','06','OPEN WELLS', '07','PONDS','08','OTHERS','09','DIRECT PUMPING') AS ANAME,POPU_BENEFITED,decode (asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED',NULL,'-')AS ASSET_STATUS from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,"+schemeTbl+" s,rws_division_office_tbl do,rws_subdivision_office_tbl sdo where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'";
	if(rMandal!=null && !rMandal.equals("-1"))query +=" and m.mcode='"+rMandal+"'";
	if(rPanchayat!=null && !rPanchayat.equals("-1"))query +=" and p.pcode='"+rPanchayat+"'";
	if(rVillage!=null && !rVillage.equals("-1"))query +=" and v.vcode='"+rVillage+"'";
	if(rHab!=null && !rHab.equals("-1"))query +=" and hd.hab_code='"+rHab+"'";
	if(assetName!=null && (!assetName.equals("-1") && !assetName.equals("")))query +=" and a.asset_name like '"+assetName+"'";
	if(assetLoc!=null && (!assetLoc.equals("-1") && !assetLoc.equals("")))query +=" and a.location like '"+assetLoc+"'";
	query += " and d.dcode=do.circle_office_code and d.dcode=sdo.circle_office_code and do.circle_office_code=sdo.circle_office_code and a.division_office_code=do.division_office_code and a.division_office_code=sdo.division_office_code and do.division_office_code=sdo.division_office_code and a.subdivision_office_code=sdo.subdivision_office_code and hd.hab_code=a.hab_code order by d.dname,nvl (do.division_office_name,'-'),nvl (sdo.subdivision_office_name,'-'),m.mname,p.pname,v.vname,h.panch_name) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";	
	 int slno = 0;
	stmt=conn.createStatement();
	 //System.out.println("qry:"+query);

   rs=stmt.executeQuery(query);
    Statement stmt2=null;
	slno = offsettqry;
   while(rs.next())
   { 
     //////////System.out.println(" in wuhile loop  00");
	%>
   <tr>
   <td class=rptValue><%=slno++%></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(6)%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(8)%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(13)%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(14)%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString("aname")%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(19)%></font></td>
   <td class=rptvalue><font size=2><%=rs.getString(1)%></font></td>
   <td class=rptvalue ><font size=2><%=rs.getString(20)%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString(22)%></font></td>
   <td class=rptvalue align="right" nowrap><font size=2><%=rs.getString(21)%></font></td>
   <td class=rptvalue><font size=2><%=rs.getString("ASSET_STATUS")%></font></td>    <%
				   int habcount=0,totPop=0;
	   		double totPop1=0.0;
if(assetcode!=null && (assetcode.equals("01") || assetcode.equals("02") || assetcode.equals("03") || assetcode.equals("09"))) 
	 {
		query="select p.hab_code,(census_plain_popu + census_sc_popu + census_st_popu+FLOAT_POP)as totpop  from rws_habitation_directory_tbl p,rws_asset_hab_tbl a where p.hab_code=a.hab_code and asset_code='"+rs.getString(3)+"'";  
	 stmt2=conn.createStatement();
       ResultSet rs2=stmt2.executeQuery(query);
       %>
       <%

	   while(rs2.next())
       {
		   habcount++;
		   totPop += rs2.getInt(2);
	   }
	  
	   	if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	 }
		if(!assetcode.equals("04"))
	   {
		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		   totPop1 = (totPop * Math.pow(1.02,Integer.parseInt(sdf.format(new java.util.Date())) - 2001));
	   }
	   else
	   {
		   habcount = 1;
		   totPop1 = rs.getDouble("POPU_BENEFITED");
	   }
	   /*else if(assetcode!=null && (assetcode.equals("04")))
	   {
		   totPop1 = rs.getDouble("POPU_BENEFITED");
		   habcount = 1;
	   }
	   else
	   {
		 habcount = 1;
		 		   SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		   totPop1 = (totPop * Math.pow(1.02,Integer.parseInt(sdf.format(new java.util.Date())) - 2001));
	   }*/
	   //System.out.println("hab count2:"+habcount);
	   %>
	   <td class=rptValue align="right">
	   <%if(habcount > 1){
	   String hrefstring="javascript:popWinOpen("+slno+ ")";
		   %>
	   <input type=hidden name=<%=slno%> value=<%=rs.getString("asset_code")%>><a href=<%=hrefstring%>><%=habcount%></a>
	   <%}else{%><%=habcount%><%}%>
		 </td>
	    <td class=rptvalue align="right"><font size=2><%=(int)Math.round(Math.ceil(totPop1))%></font></td>
<%if(assetcode!=null && (assetcode.equals("01") || assetcode.equals("02") || assetcode.equals("03") || assetcode.equals("09"))) 
	 {%>
		<td class=rptvalue><input type="button" name="addHab" style="width:100px" value="..." class="btext" title="Click to View Subcomponents" onclick="fnAssetComp('<%=rs.getString("asset_code")%>','<%=assetcode%>')"/></td>
 <%}
	   else
	   {
		    nic.watersoft.reports.rws_asset_CheckList_Data dd= new nic.watersoft.reports.rws_asset_CheckList_Data();
			String aa = dd.getCheckListAssetData(rs.getString("asset_code"),assetcode,conn);
		     String[] aaa = aa.split("/");
			 if(!aaa[0].equals("--"))
			{
			%>
				<td class=rptvalue><a href="javascript:fnAssetComp('<%=rs.getString("asset_code")%>','<%=assetcode%>')"><font size=1><%=aaa[0]%></font></a></td></tr>
			<%
			}
			else
		   {
			%>
				<td class=rptvalue><font size=2>0</font></td></tr>
			<%
		   }
	   }
	}
 	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
//	if(conn!=null)conn.close();
if(totCount==0){%><tr><td colspan="14" align="center" valign="top" class=rptValue>No Assets</td></tr>
<%}%>
 </table>
 <table>
 <tr><td>
 <%
if(totCount!=0){
String firstpgurl = "WsPager.jsp?pager.offset=0&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
String prevpgurl = "WsPager.jsp?pager.offset="+prevpgno+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
String nextpgurl = "WsPager.jsp?pager.offset="+nextpgno+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
String lastpgurl = "WsPager.jsp?pager.offset="+totalpgno+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
if(currentpageno!=firstpgno){
%>

  <a href="<%= firstpgurl %>"><nobr>[ First ]</nobr></a>
  <a href="<%= prevpgurl %>"><nobr>[ Prev ]</nobr></a>
<%}
  if(totalpgno>rowsPerPage)
  {
	  for(int i=currentpageno,j=currentpageno-9;i<currentpageno+10;i++,j++){
if(i<=totalpgno)
	{
	String currenturl = "WsPager.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
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
		<%String currenturl = "WsPager.jsp?pager.offset="+j+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
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
	  for(int i=currentpageno;i<=totalpgno;i++){
		  String currenturl = "WsPager.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&panchayat="+rPanchayat+"&village="+rVillage+"&hab="+rHab+"&asset="+assetcode+"&districtName="+rDistName+"&mandalName="+rMandalName+"&panchayatName="+rPanchayatName +"&villageName="+rVillageName+"&habName="+rHabName+"&typeOfAssetName="+typeOfAssetName+"&assetName="+assetName+"&assetLoc="+assetLoc+"";
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
<font face="verdana" color="red" size="2">Go to Page:<input type="text" name="go" maxlength="4" size="2" onkeyup="goSearch('<%=lastpgno%>','<%=rDist%>','<%=rMandal%>','<%=rPanchayat%>','<%=rVillage%>','<%=rHab%>','<%=rDistName%>','<%=rMandalName%>','<%=rPanchayatName%>','<%=rVillageName%>','<%=rHabName%>','<%=typeOfAssetName%>','<%=assetName%>','<%=assetLoc%>','<%=assetcode%>')">
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
