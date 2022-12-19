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
function goSearch(last,dist,rmandal,assetcode)
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
		var url = "WsPagerShp.jsp?pager.offset="+document.forms[0].go.value+"&district="+dist+"&mandal="+rmandal+"&asset="+assetcode;
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
function popWinOpen1(a,b)
{
	var zURL="rws_view_bw.jsp?assetCode="+a+"&schemeCode="+b;
	var zWidth=800,zHeight=400;
	var popFeatures = "width=" + zWidth + ",height=" + zHeight + ",toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1";
	myWin = window.open(zURL,'expenditure1',popFeatures);
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
	// request.setAttribute("rDist",rDist);
	 String assetcode= request.getParameter("asset");
	// request.setAttribute("assetcode",assetcode);
	/* if(rDist==null)
		rDist = 	 (String)request.getAttribute("rDist");
	 if(assetcode==null)
		assetcode = 	 (String)request.getAttribute("assetcode");*/
    String style = getParam(request, "style", "simple");
    String position = getParam(request, "position", "top");
    String index = getParam(request, "index", "center");
    int maxPageItems = getParam(request, "maxPageItems", 10);
    int maxIndexPages = getParam(request, "maxIndexPages", 10);
%>
<form>
<center>
  <%
 // ////System.out.println("aaaaaaaaaaaaaaaaaaaaaaaa:"+style);
  if ("jsptags".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> JSPTags.com Emulation Settings<br>
	<table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index:</td><td>Center</td></tr>
	<tr><td>Max. Page Items:</td><td>10</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>10</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else if ("google".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> <font color="#0000cc">G</font><font color="#cccc00">oo</font><font color="#0000cc">g</font><font color="#00cc00">l</font><font color="#cc0000">e</font> Emulation Settings<br>
	<table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index:</td><td>Half-Full</td></tr>
	<tr><td>Max. Page Items:</td><td>10</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>20</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else if ("altavista".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> AltaVista Emulation Settings<br>
        <table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index:</td><td>Center</td></tr>
	<tr><td>Max. Page Items:</td><td>10</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>10</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else if ("lycos".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> Lycos Emulation Settings<br>
        <table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index: </td><td>Forward</td></tr>
	<tr><td>Max. Page Items: </td><td>10</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>4</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else if ("yahoo".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> Yahoo! Emulation Settings<br>
        <table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index: </td><td>N/A</td></tr>
	<tr><td>Max. Page Items: </td><td>20</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>N/A</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else if ("alltheweb".equals(style)) { %>
    <table border="0" cellspacing="0" cellpadding="0">
    <tr valign="top">
    <td><input type="submit" value="Update"></td>
    <td>&nbsp;&nbsp;</td>
    <td> AllTheWeb Emulation Settings<br>
        <table border="0" cellspacing="0" cellpadding="0">
	<tr><td>Index: </td><td>Center</td></tr>
	<tr><td>Max. Page Items: </td><td>10</td></tr>
	<tr><td>Max. Index Pages:&nbsp;</td><td>7</td></tr>
	</table>
	</td>
    </tr>
    </table>
  <% } else { %>
  <% } %>
</td>
</tr>

</table>
 
<pg:pager
    items="<%= webPalette.length %>"
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
	String totQuery = "select distinct COUNT(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,rws_division_office_tbl do,rws_subdivision_office_tbl sdo where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'";
		if(rMandal!=null && !rMandal.equals("-1"))totQuery +=" and m.mcode='"+rMandal+"'";

	totQuery += " and d.dcode=do.circle_office_code and d.dcode=sdo.circle_office_code and do.circle_office_code=sdo.circle_office_code(+) and a.division_office_code=do.division_office_code and a.division_office_code=sdo.division_office_code and do.division_office_code=sdo.division_office_code and a.subdivision_office_code=sdo.subdivision_office_code and hd.hab_code=a.hab_code order by d.dname,nvl (do.division_office_name,'-'),nvl (sdo.subdivision_office_name,'-'),m.mname,p.pname,v.vname,h.panch_name";
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
//////System.out.println("totalPg:"+totalpgno);
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
		 <td align="center" class="rptHeading" colspan=7><font color="white">Asset Check List Report - Shallow Hand Pumps</font></td>	
   </tr>
    <tr bgcolor="#8A9FCD" align="center">
    <td align="center" class="rptHeading">SlNo</td>
    <td align="center" class="rptHeading">AssetName/SchemeCode</td>
    <td align="center" class="rptHeading">District/<br> Division/<br> Sub Division/<br>Mandal/<br>Panchyat/<br>village/<br> Habitation</td>
   <td align="center" class="rptHeading">Location/<br>Date of Creation/<br>Cost of Asset/<br>Habs Benifited/<br>Population Benifited</td> 
   <td align="center" class="rptHeading"><b>SHALLOW HAND PUMP</b></td>
	</tr>
	<%
//	String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"' and hd.hab_code=a.hab_code order by asset_code) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";
String query="select * from (select a.*, rownum rnum from (select distinct nvl(a.asset_name,'- '),a.hab_code,a.asset_code,a.TYPE_OF_ASSET_CODE,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,h.panch_code,h.panch_name,a. division_office_code dc,a.subdivision_office_code sdc,nvl(do.division_office_name,'-')dn,nvl (sdo.subdivision_office_name,'-') sdn,s.scheme_code,nvl(a.LOCATION,'-')LOCATION,nvl(a.ASSET_COST,'0')ASSET_COST,nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-') as DATE_CREATION from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,rws_division_office_tbl do,rws_subdivision_office_tbl sdo where a.asset_code=s.asset_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and type_of_asset_code='"+assetcode+"' and d.dcode='"+rDist+"'";
	if(rMandal!=null && !rMandal.equals("-1"))query +=" and m.mcode='"+rMandal+"'";
	query +="	 and d.dcode=do.circle_office_code and d.dcode=sdo.circle_office_code and do.circle_office_code=sdo.circle_office_code(+) and a.division_office_code=do.division_office_code and a.division_office_code=sdo.division_office_code and do.division_office_code=sdo.division_office_code and a.subdivision_office_code=sdo.subdivision_office_code and hd.hab_code=a.hab_code order by d.dname,nvl (do.division_office_name,'-'),nvl (sdo.subdivision_office_name,'-'),m.mname,p.pname,v.vname,h.panch_name) a where rownum <= "+offsetqry1+")where rnum >= "+offsettqry+"";
	
	 int slno = 0;
	stmt=conn.createStatement();
	//////System.out.println("qry:"+query);
   rs=stmt.executeQuery(query);
    Statement stmt2=null;
	slno = offsettqry;
   while(rs.next())
   { 
     //////System.out.println(" in wuhile loop  00");
	%>
   <tr>
   <td class=rptValue><%=slno++%></td>
   <td class=rptvalue><font size=2><%=rs.getString(1).toUpperCase()%>/<BR><%=rs.getString("scheme_code")%></font></td>
   <td class=rptvalue nowrap><font size=2><%=rs.getString("dname")%>/<br><%=rs.getString("DN")%>/<br><%=rs.getString("SDN")%>/<br><%=rs.getString("mname")%>/<br><%=rs.getString("pname")%>/<br><%=rs.getString("vname")%>/<br><%=rs.getString("panch_name")%></font> </td>  
     <% query="select p.hab_code,(census_plain_popu + census_st_popu + census_st_popu+FLOAT_POP)as totpop  from rws_habitation_directory_tbl p,rws_asset_scheme_tbl a where p.hab_code=SUBSTR(a.SCHEME_code,1,16) and asset_code='"+rs.getString(3)+"'";  
	 stmt2=conn.createStatement();
       ResultSet rs2=stmt2.executeQuery(query);
       %>
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
		   totPop1 = totPop;
	   }
	   	if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
	   	// nic.watersoft.reports.rws_asset_CheckList_Data d= new nic.watersoft.reports.rws_asset_CheckList_Data();
		 nic.watersoft.reports.rws_asset_CheckList_Data dd= new nic.watersoft.reports.rws_asset_CheckList_Data();
		String aa = dd.getCheckListAssetData(rs.getString(3),assetcode,conn);
		//String chkddata=dd.getCheckListDataOne(rs.getString(3),rs.getString("TYPE_OF_ASSET_CODE"),rs.getString("hab_code"),rs.getString("scheme_code"));
//		////System.out.println("aa:"+aa);
	     String[] aaa = aa.split("/");%>
	     <td class=rptValue><%=rs.getString("LOCATION")%>/<br><%=rs.getString("DATE_CREATION")%>/<br><%=rs.getString("ASSET_COST")%>/<br><%=habcount%>/<br><%=(int)Math.round(Math.ceil(totPop1))%>/<br></td>
	     <%
		if(!aaa[0].equals("--")){%>
		
		<td align="center" valign="top">
			<table width="130" border="1" bordercolor="black"
				style="border-collapse:collapse;">  
        <tr class="mystyle1">
        
       <%if(!aaa[0].equals("--")){%>

		<td><font size=1 face="verdana">SHALLOW HAND PUMP</font></td>
		<td><font size=1><%=aaa[0]%></font></td></tr>
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
 <%}
 	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
//	if(conn!=null)conn.close();
if(totCount==0){%><tr><td colspan="5" align="center" valign="top" class=rptValue>No Assets</td></tr>
<%}%>
 </table>
 <table>
 <tr><td>
 <%
if(totCount!=0){
String firstpgurl = "WsPagerShp.jsp?pager.offset=0&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode+"";
String prevpgurl = "WsPagerShp.jsp?pager.offset="+prevpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
String nextpgurl = "WsPagerShp.jsp?pager.offset="+nextpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
String lastpgurl = "WsPagerShp.jsp?pager.offset="+totalpgno+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
if(currentpageno!=firstpgno){
%>

  <a href="<%= firstpgurl %>"><nobr>[ First ]</nobr></a>
  <a href="<%= prevpgurl %>"><nobr>[ Prev ]</nobr></a>
<%}
  if(totalpgno>20)
  {
	  for(int i=currentpageno,j=currentpageno-9;i<currentpageno+10;i++,j++){
if(i<=totalpgno)
	{
	String currenturl = "WsPagerShp.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
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
		<%String currenturl = "WsPagerShp.jsp?pager.offset="+j+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
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
		  String currenturl = "WsPagerShp.jsp?pager.offset="+i+"&district="+rDist+"&mandal="+rMandal+"&asset="+assetcode;
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
<%}%>
<font face="verdana" color="red" size="2">Go to Page:<input type="text" name="go" maxlength="4" size="2" onkeyup="goSearch('<%=lastpgno%>','<%=rDist%>','<%=rMandal%>','<%=assetcode%>')">
</td>
<td>
<div id="a" style="display:block"><a href="#">GO</a>
</div>
<!-- &nbsp;&nbsp;&nbsp;<font face="verdana" color="red" size="2">Go to Page:<input type="text" name="go" maxlength="4" size="2"><input type="submit" name="search" value="GO" onclick="goSearch('<%=lastpgno%>','<%=rDist%>','<%=assetcode%>')"> -->
</td></tr>
 </table>
  <%} if ("totp".equals(position) || "botsh".equals(position)) { %>
    <br>
    <pg:index>
      <% if ("texticon".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/texticon.jsp" flush="true"/>
      <% } else if ("jsptags".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/jsptags.jsp" flush="true"/>
      <% } else if ("google".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/google.jsp" flush="true"/>
      <% } else if ("altavista".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/altavista.jsp" flush="true"/>
      <% } else if ("lycos".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/lycos.jsp" flush="true"/>
      <% } else if ("yahoo".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/yahoo.jsp" flush="true"/>
      <% } else if ("alltheweb".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/alltheweb.jsp" flush="true"/>
      <% } else { %>
  	<jsp:include page="/WEB-INF/jsp/simple.jsp" flush="true"/>
      <% } %>
    </pg:index>
  <% } %>

  <hr>

<% if ("boettom".equals(position) || "bogth".equals(position)) { %>
  <pg:index>
    <% if ("texticon".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/texticon.jsp" flush="true"/>
    <% } else if ("jsptags".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/jsptags.jsp" flush="true"/>
    <% } else if ("google".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/google.jsp" flush="true"/>
    <% } else if ("altavista".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/altavista.jsp" flush="true"/>
    <% } else if ("lycos".equals(style)) { %>
  	<jsp:include page="/WEB-INF/jsp/lycos.jsp" flush="true"/>
    <% } else if ("yahoo".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/yahoo.jsp" flush="true"/>
    <% } else if ("alltheweb".equals(style)) { %>
	<jsp:include page="/WEB-INF/jsp/alltheweb.jsp" flush="true"/>
    <% } else { %>
	<jsp:include page="/WEB-INF/jsp/simple.jsp" flush="true"/>
    <% } %>
  </pg:index>
<% } %>
</pg:pager>
<tr><td>
<font style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;"><%@ include file = "footer.jsp" %></font>
</td></tr>
</center>
</form>
</body>
</html>
<%!
private static final String BLACK = "#000000", WHITE = "#ffffff";
private static final String[][] webPalette = {
    { WHITE,   BLACK},
    {"#cccccc",BLACK},
    {"#999999",BLACK},
    {"#666666",WHITE},
    {"#333333",WHITE},
    { BLACK,   WHITE},
    {"#ffcc00",BLACK},
    {"#ff9900",BLACK},
    {"#ff6600",BLACK},
    {"#ff3300",WHITE},
    {"#99cc00",BLACK},
    {"#cc9900",BLACK},
    {"#ffcc33",BLACK},
    {"#ffcc66",BLACK},
    {"#ff9966",BLACK},
    {"#ff6633",BLACK},
    {"#cc3300",WHITE},
    {"#cc0033",WHITE},
    {"#ccff00",BLACK},
    {"#ccff33",BLACK},
    {"#333300",WHITE},
    {"#666600",WHITE},
    {"#999900",BLACK},
    {"#cccc00",BLACK},
    {"#ffff00",BLACK},
    {"#cc9933",BLACK},
    {"#cc6633",WHITE},
    {"#330000",WHITE},
    {"#660000",WHITE},
    {"#990000",WHITE},
    {"#cc0000",WHITE},
    {"#ff0000",WHITE},
    {"#ff3366",WHITE},
    {"#ff0033",WHITE},
    {"#99ff00",BLACK},
    {"#ccff66",BLACK},
    {"#99cc33",BLACK},
    {"#666633",WHITE},
    {"#999933",BLACK},
    {"#cccc33",BLACK},
    {"#ffff33",BLACK},
    {"#996600",WHITE},
    {"#993300",WHITE},
    {"#663333",WHITE},
    {"#993333",WHITE},
    {"#cc3333",WHITE},
    {"#ff3333",WHITE},
    {"#cc3366",WHITE},
    {"#ff6699",BLACK},
    {"#ff0066",WHITE},
    {"#66ff00",BLACK},
    {"#99ff66",BLACK},
    {"#66cc33",BLACK},
    {"#669900",WHITE},
    {"#999966",BLACK},
    {"#cccc66",BLACK},
    {"#ffff66",BLACK},
    {"#996633",WHITE},
    {"#663300",WHITE},
    {"#996666",WHITE},
    {"#cc6666",BLACK},
    {"#ff6666",BLACK},
    {"#990033",WHITE},
    {"#cc3399",WHITE},
    {"#ff66cc",BLACK},
    {"#ff0099",WHITE},
    {"#33ff00",BLACK},
    {"#66ff33",BLACK},
    {"#339900",WHITE},
    {"#66cc00",BLACK},
    {"#99ff33",BLACK},
    {"#cccc99",BLACK},
    {"#ffff99",BLACK},
    {"#cc9966",BLACK},
    {"#cc6600",WHITE},
    {"#cc9999",BLACK},
    {"#ff9999",BLACK},
    {"#ff3399",WHITE},
    {"#cc0066",WHITE},
    {"#990066",WHITE},
    {"#ff33cc",BLACK},
    {"#ff00cc",WHITE},
    {"#00cc00",WHITE},
    {"#33cc00",BLACK},
    {"#336600",WHITE},
    {"#669933",WHITE},
    {"#99cc66",BLACK},
    {"#ccff99",BLACK},
    {"#ffffcc",BLACK},
    {"#ffcc99",BLACK},
    {"#ff9933",BLACK},
    {"#ffcccc",BLACK},
    {"#ff99cc",BLACK},
    {"#cc6699",BLACK},
    {"#993366",WHITE},
    {"#660033",WHITE},
    {"#cc0099",WHITE},
    {"#330033",WHITE},
    {"#33cc33",BLACK},
    {"#66cc66",BLACK},
    {"#00ff00",BLACK},
    {"#33ff33",BLACK},
    {"#66ff66",BLACK},
    {"#99ff99",BLACK},
    {"#ccffcc",BLACK},
    {"#cc99cc",BLACK},
    {"#996699",WHITE},
    {"#993399",WHITE},
    {"#990099",WHITE},
    {"#663366",WHITE},
    {"#660066",WHITE},
    {"#006600",WHITE},
    {"#336633",WHITE},
    {"#009900",WHITE},
    {"#339933",WHITE},
    {"#669966",BLACK},
    {"#99cc99",BLACK},
    {"#ffccff",BLACK},
    {"#ff99ff",BLACK},
    {"#ff66ff",BLACK},
    {"#ff33ff",BLACK},
    {"#ff00ff",WHITE},
    {"#cc66cc",BLACK},
    {"#cc33cc",WHITE},
    {"#003300",WHITE},
    {"#00cc33",WHITE},
    {"#006633",WHITE},
    {"#339966",WHITE},
    {"#66cc99",BLACK},
    {"#99ffcc",BLACK},
    {"#ccffff",BLACK},
    {"#3399ff",BLACK},
    {"#99ccff",BLACK},
    {"#ccccff",BLACK},
    {"#cc99ff",BLACK},
    {"#9966cc",BLACK},
    {"#663399",WHITE},
    {"#330066",WHITE},
    {"#9900cc",WHITE},
    {"#cc00cc",WHITE},
    {"#00ff33",BLACK},
    {"#33ff66",BLACK},
    {"#009933",WHITE},
    {"#00cc66",BLACK},
    {"#33ff99",BLACK},
    {"#99ffff",BLACK},
    {"#99cccc",BLACK},
    {"#0066cc",WHITE},
    {"#6699cc",BLACK},
    {"#9999ff",BLACK},
    {"#9999cc",BLACK},
    {"#9933ff",WHITE},
    {"#6600cc",WHITE},
    {"#660099",WHITE},
    {"#cc33ff",WHITE},
    {"#cc00ff",WHITE},
    {"#00ff66",BLACK},
    {"#66ff99",BLACK},
    {"#33cc66",BLACK},
    {"#009966",WHITE},
    {"#66ffff",BLACK},
    {"#66cccc",BLACK},
    {"#669999",BLACK},
    {"#003366",WHITE},
    {"#336699",WHITE},
    {"#6666ff",WHITE},
    {"#6666cc",WHITE},
    {"#666699",WHITE},
    {"#330099",WHITE},
    {"#9933cc",WHITE},
    {"#cc66ff",BLACK},
    {"#9900ff",WHITE},
    {"#00ff99",BLACK},
    {"#66ffcc",BLACK},
    {"#33cc99",BLACK},
    {"#33ffff",BLACK},
    {"#33cccc",BLACK},
    {"#339999",WHITE},
    {"#336666",WHITE},
    {"#006699",WHITE},
    {"#003399",WHITE},
    {"#3333ff",WHITE},
    {"#3333cc",WHITE},
    {"#333399",WHITE},
    {"#333366",WHITE},
    {"#6633cc",WHITE},
    {"#9966ff",BLACK},
    {"#6600ff",WHITE},
    {"#00ffcc",BLACK},
    {"#33ffcc",BLACK},
    {"#00ffff",BLACK},
    {"#00cccc",BLACK},
    {"#009999",WHITE},
    {"#006666",WHITE},
    {"#003333",WHITE},
    {"#3399cc",BLACK},
    {"#3366cc",WHITE},
    {"#0000ff",WHITE},
    {"#0000cc",WHITE},
    {"#000099",WHITE},
    {"#000066",WHITE},
    {"#000033",WHITE},
    {"#6633ff",WHITE},
    {"#3300ff",WHITE},
    {"#00cc99",BLACK},
    {"#0099cc",WHITE},
    {"#33ccff",BLACK},
    {"#66ccff",BLACK},
    {"#6699ff",BLACK},
    {"#3366ff",WHITE},
    {"#0033cc",WHITE},
    {"#3300cc",WHITE},
    {"#00ccff",BLACK},
    {"#0099ff",WHITE},
    {"#0066ff",WHITE},
    {"#0033ff",WHITE}
};


private static final String getParam(ServletRequest request, String name,
    String defval)
{
    String param = request.getParameter(name);
    return (param != null ? param : defval);
}

private static final int getParam(ServletRequest request, String name,
    int defval)
{
    String param = request.getParameter(name);
    int value = defval;
    if (param != null) {
	try { value = Integer.parseInt(param); }
	catch (NumberFormatException ignore) { }
    }
    return value;
}

private static void radio(PageContext pc, String name, String value,
    boolean isDefault) throws java.io.IOException
{
    JspWriter out = pc.getOut();
    String param = pc.getRequest().getParameter(name);
    out.write("<input type=\"radio\" name=\"");
    out.write(name);
    out.write("\" value=\"");
    out.write(value);
    out.write("\" onChange=\"this.form.submit();\"");
    if (value.equals(param) || (isDefault && param == null))
	out.write(" checked");
    out.write('>');
}
%>
<%@ include file="connClose.jsp" %>
<%}finally{}%>