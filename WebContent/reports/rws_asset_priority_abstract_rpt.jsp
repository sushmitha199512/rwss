<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.util.*" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%	
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	int sno=1;
	String per = request.getParameter("per");
	String assetname = request.getParameter("assetname");
	int col1=0,col2=0,col3=0;double col4=0;
try
{
%>
<html>
<title> WaterSoft </title>
<head>
<style>
tr.even {
  background-color: #ddd;
}
tr.odd {
  background-color: #eee;
}
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
function fnGet()
{
		if(document.f1.per.value=="")
			alert("Please Select Asset Type");
		else
		{
			document.forms[0].assetname.value = document.f1.per.options[document.f1.per.options.selectedIndex].text;
			document.forms[0].submit();
		}
}

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
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}
</script>
<style>
#content {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
	left: 373px;
	top: 220px;
}
-->
</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<div id="content" style="display:none"><img src="../images/loading4.gif" alt="Loading Wait..." title="Loading Wait..."></div>   
<table width="720" align="center">
<tr>
<td align="right"><a href="../home.jsp">Home</a>
</tr>
</table>
<!--  deleted the table click info -->
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr>
		<td class="textborder" align="left">Select Asset Type<span class="mandatory">*</span></td>
		<td><select name="per" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_code<> 10 and type_of_asset_code<> '08' order by (case type_of_asset_name when 'CPWS' THEN 1 when 'PWS' THEN 2 when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6 when 'PONDS' THEN 7 when 'OPEN WELLS' THEN 8 END) ASC");
		while(rs.next())
		{
				if(per!=null && per.equals(rs.getString(1))){
			%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
			<%}else{
			%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%}
		}%>
		</select>
		</td>
	</tr>
	<tr>
	<td colspan="2" align=center>
	<input type="button" value="Get Report" onclick="fnGet()" class="btext">
	</td>
	</tr>
</table>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" class="striped">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="blue">Asset Consolidated Statement Report</font><font color="black"></font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="btext" colspan=38>District: All</td>		
	</tr>	
	<tr align="center">
		<td class="btext" >S. No.</td>
		<td class="btext" >District</td>
		<td class="btext" >Assets</td>
		<td class="btext" >Habs</td>
 		<td class="btext" >Population</td>
		<td class="btext" >Cost(In Lakhs)</td>
	</tr>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");
try
{
	if(per!=null && !per.equals("")){
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	String q1 = "",qrere = "";
	//q1 = "select COUNT(B.ASSET_CODE),nvl(SUM(ASSET_COST),0),substr(a.hab_code,1,2) from RWS_ALL_ASSET_COUNT_TBL A,RWS_ASSET_MAST_TBL B,RWS_ASSET_SCHEME_TBL C WHERE B.ASSET_CODE=C.ASSET_CODE AND A.HAB_CODE=b.HAB_CODE AND ";
   // q11 = "select COUNT(distinct B.ASSET_CODE),nvl(SUM(ASSET_COST),0),substr(a.hab_code,1,2) from RWS_asset_hab_tbl A,RWS_ASSET_MAST_TBL B,RWS_ASSET_SCHEME_TBL C WHERE B.ASSET_CODE=C.ASSET_CODE AND A.HAB_CODE=b.HAB_CODE AND ";
	 q1="select COUNT(distinct A.ASSET_CODE),nvl(SUM(A.ASSET_COST),0),substr(C.hab_code,1,2) from RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL B, RWS_ASSET_MAST_TBL C where  A.ASSET_CODE=B.ASSET_CODE AND A.ASSET_CODE=C.ASSET_CODE AND  ";

    if(per!=null && per.equals("03"))
	{
		//q1 += "cpws<>0 and type_of_asset_code='03' ";
        q1 += "a.type_of_asset_code='03' ";
      
	}
	else if(per!=null && per.equals("01"))
	{
		//q1 += "(cpws=0 and pws<>0) and type_of_asset_code='01' ";
        q1 +="a.type_of_asset_code='01' ";
	}
	else if(per!=null && per.equals("02"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws<>0) and type_of_asset_code='02' ";
	   q1 += "a.type_of_asset_code='02' ";
     }
	else if(per!=null && per.equals("09"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws=0 and dp<>0) and type_of_asset_code='09' ";
        q1 += "a.type_of_asset_code='09' ";
	}
	else if(per!=null && per.equals("04"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp<>0) and type_of_asset_code='04' ";
        q1 += "a.type_of_asset_code='04' ";
        
	}	
	else if(per!=null && per.equals("05"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp<>0) and type_of_asset_code='05' ";
	q1 += "a.type_of_asset_code='05' ";
    }	
	else if(per!=null && per.equals("07"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp=0 and ponds<>0) and type_of_asset_code='07' ";
        q1 += "a.type_of_asset_code='07' "; 
	}
	else if(per!=null && per.equals("06"))
	{
		//q1 += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp=0 and ponds=0 and ow<>0) and type_of_asset_code='06' ";
        q1 += "a.type_of_asset_code='06' ";
	}
	q1 +=" group by substr(c.hab_code,1,2)";

	
	rs1=st1.executeQuery(q1);
System.out.println("q1eee:"+q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(3),rs1.getString(1)+"@"+rs1.getString(2)); 
	}
	Hashtable ht2 = new Hashtable();
	Statement sttt = conn.createStatement();
	ResultSet rsss = sttt.executeQuery("SELECT dcode,dname FROM rws_district_tbl where dcode!='16' order by dname");
	while(rsss.next())
	{
		//qrere = "select distinct d.hab_code,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU from RWS_ALL_ASSET_COUNT_TBL A,RWS_ASSET_MAST_TBL B,RWS_ASSET_SCHEME_TBL C,RWS_ASSET_HAB_TBL D,rws_complete_hab_view e WHERE B.ASSET_CODE=C.ASSET_CODE AND C.ASSET_CODE=D.ASSET_CODE AND B.ASSET_CODE=D.ASSET_CODE AND A.HAB_CODE=d.HAB_CODE AND d.HAB_CODE=e.panch_CODE AND A.HAB_CODE=e.panch_CODE  AND substr(d.hab_code,1,2)='"+rsss.getString(1)+"' and ";
		qrere="select distinct d.hab_code,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU from RWS_ASSET_MAST_TBL B,RWS_ASSET_SCHEME_TBL C,RWS_ASSET_HAB_TBL D,rws_complete_hab_view e WHERE B.ASSET_CODE=C.ASSET_CODE AND C.ASSET_CODE=D.ASSET_CODE AND B.ASSET_CODE=D.ASSET_CODE AND d.HAB_CODE=e.panch_CODE  AND substr(d.hab_code,1,2)='"+rsss.getString(1)+"' and ";
        if(per!=null && per.equals("03"))
		{
			//qrere += "(cpws<>0) and type_of_asset_code='03' ";
            qrere += "type_of_asset_code='03' ";
		}
		else if(per!=null && per.equals("01"))
		{
			//qrere += "(cpws=0 and pws<>0) and type_of_asset_code='01' ";
            qrere += "type_of_asset_code='01' "; 
		}
		else if(per!=null && per.equals("02"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws<>0) and type_of_asset_code='02' ";
            qrere += "type_of_asset_code='02' ";
		}
		else if(per!=null && per.equals("09"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws=0 and dp<>0) and type_of_asset_code='09' ";
            qrere += "type_of_asset_code='09' ";
		}
		else if(per!=null && per.equals("04"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp<>0) and type_of_asset_code='04' ";
            qrere += "type_of_asset_code='04' "; 
		}	
		else if(per!=null && per.equals("05"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp<>0) and type_of_asset_code='05' ";
            qrere += "type_of_asset_code='05' ";
		}	
		else if(per!=null && per.equals("07"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp=0 and ponds<>0) and type_of_asset_code='07' ";
            qrere += "type_of_asset_code='07' ";
		}
		else if(per!=null && per.equals("06"))
		{
			//qrere += "(cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0 and shp=0 and ponds=0 and ow<>0) and type_of_asset_code='06' ";
            qrere += "type_of_asset_code='06' ";
		}
//	qrere +=" group by rollup (substr (d.hab_code,1,2)) order by 2 asc";

		//System.out.println("qrere:"+qrere);
		rs2=st2.executeQuery(qrere);
		int pop = 0,habCount = 0;;
		while(rs2.next())
		{
		//	System.out.println(rs2.getString(2));
			habCount++;
			if(rs2.getString(2)!=null && !rs2.getString(2).equals(""))
				pop += rs2.getInt(2);
		}	
//		System.out.println("pop:"+pop+"rsss.getString:"+rsss.getString(1));
		ht2.put(rsss.getString(1),""+pop+"@"+habCount); 
	}
	 //System.out.println("Hashtable contains " + ht2.size() + " key value pairs.");

	//System.out.println(qrere);
	
	st3=conn.createStatement();
	String qrys = "SELECT dcode,dname FROM rws_district_tbl where dcode!='16' order by dname";
	//System.out.println("sssssssssssssss:"+qrys);
	rs3=st3.executeQuery(qrys);
	int count =1;
	%>
	<%
	while(rs3.next())
	{
		String val1 = ""+ht1.get(rs3.getString(1));
		if(val1!=null && !val1.equals("null")){}else{val1="0@0@0";}
		String[] values1 = val1.split("@");
		col2 += Integer.parseInt(values1[0]);
		col4 += Double.parseDouble(values1[1]);
		String val2 = ""+ht2.get(rs3.getString(1));
		if(val2!=null && !val2.equals("null")){}else{val2="0@0";}
		String[] values2 = val2.split("@");
		col3 += Integer.parseInt(values2[0]);
		col1 += Integer.parseInt(values2[1]);
		%>
		<tr>
				<td class="rptValue" align="center"><%=count++%></td>
				<td class="rptValue" align="left"><%=rs3.getString(2)%></td>
				<td class="rptValue" align="right"><%=values1[0]%></td>
				<td class="rptValue" align="right"><%=values2[1]%></td>
				<td class="rptValue" align="right"><%=values2[0]%></td>
				<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(values1[1]))%></td>
		</tr>
		<%
	}

%>
	<tr>
		<td class="btext" align="center" colspan="2">Total</td>
		<td class="btext" align="right"><%=col2%></td>
		<td class="btext" align="right"><%=col1%></td>
		<td class="btext" align="right"><%=col3%></td>
		<td class="btext" align="right"><%=ndf.format(col4)%></td>
	</tr>
<%
}
}
catch(Exception e)
{e.printStackTrace();}
finally
{
	if(rs3!=null)rs3.close();
	if(st3!=null)st3.close();
	if(rs2!=null)rs2.close();
	if(st2!=null)st2.close();
	if(rs1!=null)rs1.close();
	if(st1!=null)st1.close();
	if(conn!=null)conn.close();
}
%>
<%
}
catch(Exception e)
{e.printStackTrace();}
%>
<table><tr><td> Note : 1. Only distinct habitations have been taken into consideration </td></tr></table>
</table></table>
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="assetname">
</form>
</body>
</html>