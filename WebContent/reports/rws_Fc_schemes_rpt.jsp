<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<script language="javascript">
$(document).ready(function(){
$("#btnLoad").click(function(event){
//alert("Get Data","Alert Dialog");
var usersss = '<%=userss.getUserId()%>';
if(usersss!=null && usersss!="admin") {
		alert("You are not authorized to Refresh this Report - Contact NIC");
}
else
{
var url = "AssetPriorityUpdated.jsp";
ajaxFunction(url);
}
});
});
function ajaxFunction(URL)
{ 
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {
		document.getElementById('content').style.display='none';
		window.location.reload();

	  }
	  else{
		  document.getElementById('content').style.display='block';
	  }
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}

function wopen(url,name,w,h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
<%

String dcode = request.getParameter("district");
	if(dcode!=null)
	{session.setAttribute("dcode",dcode);}
	String mcode=request.getParameter("mandal");
	if(mcode!=null)
	{session.setAttribute("mcode",mcode);}
	String pcode=request.getParameter("panch");
	if(pcode!=null)
	{session.setAttribute("pcode",pcode);}
	String vcode=request.getParameter("village");
	if(vcode!=null)
	{session.setAttribute("vcode",vcode);}
	String habcode=request.getParameter("habitation");
	if(habcode!=null)
	{session.setAttribute("habcode",habcode);}
	String dname=request.getParameter("dname");
	if(dname!=null)
	{session.setAttribute("dname",dname);}
	String mname=request.getParameter("mname");
	if(mname!=null)
	{session.setAttribute("mname",mname);}
	String pname=request.getParameter("pname");
	if(pname!=null)
	{session.setAttribute("pname",pname);}
	String vname=request.getParameter("vname");
	if(vname!=null)
	{session.setAttribute("vname",vname);}
	String habname=request.getParameter("habname");
	if(habname!=null)
	{session.setAttribute("habname",habname);}
	String status=request.getParameter("status");
	if(status!=null)
	{session.setAttribute("status",status);}
	String scheme=request.getParameter("scheme");
	if(scheme!=null)
	{session.setAttribute("scheme",scheme);}
	String sname=request.getParameter("sname");
	if(sname!=null)
	{session.setAttribute("sname",sname);}
	String scheme1=request.getParameter("scheme1");
if(scheme1!=null)
	{session.setAttribute("scheme1",scheme1);}
	String name2=request.getParameter("sname1");
	if(name2!=null)
	{
		session.setAttribute("name2",name2);
	}
	
	String qry="";
	%>
<form>
<table width="90%">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_Fc_schemes_xls.jsp" target="_new">Excel</a>
</tr>
</table>
<p align="center"><font class="rptvalue" size=3><b>Habitation and Assets Analysis Report</b></font><BR><br></p>

<table><tr>
<td class="btext">Under</td><td class="rptvalue"></td>
<td class="btext">District:</td><td class="rptvalue"><%=dname%></td>
<td class="btext">- Mandal:</td><td class="rptvalue"><%=mname%></td>
<%if(request.getParameter("pname")!=null && !request.getParameter("pname").equals("")){%>
<td class="btext">- Panchayat:</td><td class="rptvalue"><%=pname%></td>
<%}if(request.getParameter("vname")!=null && !request.getParameter("vname").equals("")){%>
<td class="btext">- Village:</td><td class="rptvalue"><%=vname%></td>
<%}%>
<td class="btext">- Coverage Status:</td><td class="rptvalue"><%=status%></td>
<%	if(scheme!=null && !scheme.equals("")){%>
<td class="btext">-Not Having Scheme:</td><td class="rptvalue"><%=sname%></td>
<%}else{%>
<td class="btext">- Having Scheme:</td><td class="rptvalue"><%=name2%></td>
<%}%>
</tr>
</table>

 <div id="content" style="display:none"><img src="../images/loading4.gif" alt="Loading Wait..." title="Loading Wait..."></div>   
 <table width="520" align="center">
<tr><td align="right">
<font face=verdana size=2 color=red>Click to get Latest Data-->
<img src="../images/refresh.JPG" width="35" height="35" alt="Click to get Updated Data" title="Click to get Updated Data" style="cursor:hand"  id="btnLoad"></td>
</tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext ><b>S.No</b></font></td>
<td class=btext ><b>District Name</b></font></td>
<td class=btext><b>Mandal Name</b></font></td>
<td class=btext><b>Panchayat Name</b></font></td>
<td class=btext><b>Village Name</b></font></td>
<td class=btext><b>Habitation Name</b></font></td>
<td class=btext><b>Coverage Status</b></font></td>
<td class=btext><b>Total Population</b></font></td>
<td class=btext><b>CPWS</b></font></td>
<td class=btext><b>PWS</b></font></td>
<td class=btext><b>MPWS</b></font></td>
<td class=btext><b>DP</b></font></td>
<td class=btext><b>HANDPUMPS</b></font></td>

<%
try{
	if(scheme!=null && !scheme.equals(""))
	{
//System.out.println("f"+scheme);
		qry="select c.DNAME ,c.MNAME,c.   PNAME ,c.  VNAME ,c. PANCH_NAME ,c.COVERAGE_STATUS,( CENSUS_PLAIN_POPU + CENSUS_SC_POPU + CENSUS_ST_POPU ),cpws,pws,mpws,dp,hp,c.panch_code from  RWS_ALL_ASSET_COUNT_TBL b,rws_complete_hab_view c where  c.COVERAGE_STATUS='"+status+"' and substr(b.hab_code,1,2)='"+dcode+"' and  b.hab_code=c.panch_code ";
		if(mcode!=null && !mcode.equals(""))
		{
		qry+=" and substr(b.hab_code,6,2)='"+mcode+"' ";
		}
		if(pcode!=null && !pcode.equals(""))
		{
		qry+=" and substr(c.panch_code,13,2)='"+pcode+"' ";
		}
		if(vcode!=null && !vcode.equals(""))
		{
		qry+=" and substr(c.panch_code,8,3)='"+vcode+"' ";
		}
		if(habcode!=null && !habcode.equals(""))
		{
		qry+=" and panch_code='"+habcode+"' ";
		}
		if(scheme!=null && scheme.equals("03"))
		{
			qry+="and (cpws=0)";
		}
		else if(scheme!=null && scheme.equals("01"))
		{
			qry+="and (cpws=0 and pws=0)";
		}
		else if(scheme!=null && scheme.equals("02"))
		{
			qry+="and (cpws=0 and pws=0 and mpws=0)";
		}
		else if(scheme!=null && scheme.equals("09"))
		{
			qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0)";
		}
		else if(scheme!=null && scheme.equals("04"))
		{
			qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0)";
		}
	}
	else
	{
		qry="select c.DNAME ,c.MNAME,c.   PNAME ,c.  VNAME ,c. PANCH_NAME ,c.COVERAGE_STATUS,( CENSUS_PLAIN_POPU + CENSUS_SC_POPU + CENSUS_ST_POPU ),cpws,pws,mpws,dp,hp,c.panch_code from  RWS_ALL_ASSET_COUNT_TBL b,rws_complete_hab_view c where  c.COVERAGE_STATUS='"+status+"' and substr(b.hab_code,1,2)='"+dcode+"' and  b.hab_code=c.panch_code ";
		if(mcode!=null && !mcode.equals(""))
		{
		qry+=" and substr(b.hab_code,6,2)='"+mcode+"' ";
		}
		if(pcode!=null && !pcode.equals(""))
		{
		qry+=" and substr(c.panch_code,13,2)='"+pcode+"' ";
		}
		if(vcode!=null && !vcode.equals(""))
		{
		qry+=" and substr(c.panch_code,8,3)='"+vcode+"' ";
		}
		if(habcode!=null && !habcode.equals(""))
		{
		qry+=" and panch_code='"+habcode+"' ";
		}
		if(scheme1!=null && scheme1.equals("03"))
		{
			qry+="and (cpws<>0)";
		}
		else if(scheme1!=null && scheme1.equals("01"))
		{
			qry+="and (cpws=0 and pws<>0)";
		}
		else if(scheme1!=null && scheme1.equals("02"))
		{
			qry+="and (cpws=0 and pws=0 and mpws<>0)";
		}
		else if(scheme1!=null && scheme1.equals("09"))
		{
			qry+="and (cpws=0 and pws=0 and mpws=0 and dp<>0)";
		}
		else if(scheme1!=null && scheme1.equals("04"))
		{
			qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0 and hp<>0)";
		}
	}
//System.out.println(qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
int count = 1;
if(rs.isBeforeFirst()){
while(rs.next())
	{
		%>
		<tr>
		<td class=rptvalue ><%=count++%></td>
		<td class=rptvalue nowrap><%=rs.getString(1)%></td>
		<td class=rptvalue nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue nowrap><%=rs.getString(3)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(4)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(5)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(6)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(7)%></td>
<%
	if(rs.getInt(8)>0)
	{
	%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Hp_Hab_rpt.jsp?habcode=<%=rs.getString(13)%>&toa=03','popup', 900, 300)"><%=rs.getString(8)%></a></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
if(rs.getInt(9)>0)
	{
	%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Hp_Hab_rpt.jsp?habcode=<%=rs.getString(13)%>&toa=01','popup', 900, 300)"><%=rs.getString(9)%></a></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(10)>0)
	{
	%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Hp_Hab_rpt.jsp?habcode=<%=rs.getString(13)%>&toa=02','popup', 900, 300)"><%=rs.getString(10)%></a></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(11)>0)
	{
	%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Hp_Hab_rpt.jsp?habcode=<%=rs.getString(13)%>&toa=09','popup', 900, 300)"><%=rs.getString(11)%></a></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(12)>0)
	{
	%>
	<td class=rptvalue  align="left"><a href="#" onclick="wopen('rws_Hp_Hab_rpt.jsp?habcode=<%=rs.getString(13)%>&toa=04','popup', 900, 300)"><%=rs.getString(12)%></a></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}%>
	</tr>
<%}
}

else{
 %>
 <tr>
<td class="rptValue" align=center colspan=8>No Records Match With This Selection Criteira</td></tr>
<%}
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

