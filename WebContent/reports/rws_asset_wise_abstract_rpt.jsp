<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	int sno=1;
	String per = request.getParameter("per");
	String per1 = request.getParameter("per1");
	String per2 = request.getParameter("per2");
	String mode = request.getParameter("mode");
	String assetname = request.getParameter("assetname");
	int col1=0,col2=0,col3=0;double col4=0;
	String print = "";
	if(mode!=null && mode.equals("1"))
		print = "CRITERIA - 1 Under "+assetname;
	else if(mode!=null && mode.equals("2"))
		print = "CRITERIA - 2 Under "+per2+" and "+per1;
try
{
%>
<html>
<title> WaterSoft </title>
<head>
<script>
function fnGet(val)
{
	if(val=="1")
	{
		if(document.f1.per.value=="")
			alert("Please Select Asset Type");
		else
		{
			document.forms[0].mode.value = val;
			document.forms[0].assetname.value = document.f1.per.options[document.f1.per.options.selectedIndex].text;
			document.forms[0].submit();
		}
	}
	else if(val=="2")
	{
		if(document.f1.per2.value=="")
			alert("Please Select Criteria");
		else if(document.f1.per1.value=="")
			alert("Please Select Year");
		else
		{
			document.forms[0].mode.value = val;
			document.forms[0].submit();
		}
	}
}
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table width="520" align="center">
<tr>
<td align="right"><a href="../home.jsp">Home</a></td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr>
		<td class="textborder" align="left">Select Asset Type<span class="mandatory">*</span></td>
		<td><select name="per" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_code<> 10 order by (case type_of_asset_name when 'CPWS' THEN 1 when 'PWS' THEN 2 when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6 when 'OPEN WELLS' THEN 7 when 'PONDS' THEN 8 when 'OTHERS' THEN 9 END) ASC");
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
	<input type="button" value="Get Report" onclick="fnGet('1')" class="btext">
	</td>
	</tr>
</table>
<font face=verdana size=2 color=red><b>(OR)</b></font>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr>
		<td class="textborder" align="left">Select Criteria<span class="mandatory">*</span></td>
		<td><select name="per2" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%if(per2!=null && per2.equals("MVS")){%>
				<option value="MVS" selected>MVS(CPWS)</option>
		<%}else{%>
			<option value="MVS">MVS(CPWS)</option>
		<%}%>

		<%if(per2!=null && per2.equals("SVS")){%>
				<option value="SVS" selected>SVS(PWS+MPWS+DP)</option>
		<%}else{%>
			<option value="SVS">SVS(PWS+MPWS+DP)</option>
		<%}%>

		<%if(per2!=null && per2.equals("HP")){%>
				<option value="HP" selected>HAND PUMPS</option>
		<%}else{%>
			<option value="HP">HAND PUMPS</option>
		<%}%>

		</select>
		</td>
	</tr>
	<tr>
		<td class="textborder" align="left">Select Year(Asset Created)<span class="mandatory">*</span></td>
		<td><select name="per1" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%
		for(int i=2010;i>=1980;i--)
		{
				if(per1!=null && per1.equals(""+i)){
			%>
				<option value="<%=i%>" selected><%=i%></option>
			<%}else{
			%>
				<option value="<%=i%>"><%=i%></option>
			<%}
		}
		if(per1!=null && per1.equals("<1980")){
			%>
			<option value="<1980" selected>&lt;1980</option>
		<%}else{
		%>
			<option value="<1980">&lt;1980</option>
		<%}%>
		</select>
		</td>
	</tr>
	<tr>
	<td colspan="2" align=center>
	<input type="button" value="Get Report" onclick="fnGet('2')" class="btext">
	</td>
	</tr>
</table>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">Asset Statement Report based on </font><font color="black"><%=print%></font></td>
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
<!-- 		<td class="btext" >Population</td> -->
		<td class="btext" >Cost(In Lakhs)</td>
	</tr>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");
try
{
	if(mode!=null && mode.equals("1")){
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	String q1 = "",qrere = "";
	q1 = "select count(distinct a.asset_code)assets,count(distinct c.hab_code)habs,substr(a.hab_code,1,2),type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_asset_hab_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl hd where a.asset_code=b.asset_code and a.asset_code=c.asset_code and b.asset_code=b.asset_code and c.hab_code=d.panch_code and d.panch_code=hd.hab_code and c.hab_code=hd.hab_code AND type_of_asset_code='"+per+"' group by substr(a.hab_code,1,2),type_of_asset_code order by substr(a.hab_code,1,2),type_of_asset_code";

	//System.out.println(q1);
	rs1=st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(3)+rs1.getString(4),rs1.getString(1)+"@"+rs1.getString(2)); 
	}	
	//System.out.println(qrere);
	Hashtable ht2 = new Hashtable();
	qrere = "select sum(asset_cost)cost,substr(a.hab_code,1,2),type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code AND type_of_asset_code='"+per+"' group by substr(a.hab_code,1,2),type_of_asset_code order by substr(a.hab_code,1,2),type_of_asset_code";
	rs2=st2.executeQuery(qrere);
	while(rs2.next())
	{
		ht2.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1)); 
	}
	//if(per!=null && !per.equals(""))
	//{
	st3=conn.createStatement();
	String qrys = "SELECT dcode,dname FROM rws_district_tbl where dcode!='16' order by dname";
	//System.out.println("sssssssssssssss:"+qrys);
	rs3=st3.executeQuery(qrys);
	int count =1;
	%>
	<%
	while(rs3.next())
	{
		String val1 = ""+ht1.get(rs3.getString(1)+per);
		if(val1!=null && !val1.equals("null")){}else{val1="0@0";}
		String val2 = ""+ht2.get(rs3.getString(1)+per);
		if(val2!=null && !val2.equals("null")){}else{val2="0";}
		String[] values1 = val1.split("@");
		col1 += Integer.parseInt(values1[0]);col2 += Integer.parseInt(values1[1]);
		col4 += Double.parseDouble(val2);
%>
			<tr>
				<td class="rptValue" align="center"><%=count++%></td>
				<td class="rptValue" align="left"><%=rs3.getString(2)%></td>
				<td class="rptValue" align="right"><%=values1[0]%></td>
				<td class="rptValue" align="right"><%=values1[1]%></td>
				<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(val2))%></td>
			</tr>
		<%
	}
%>
	<tr>
		<td class="btext" align="center" colspan="2">Total</td>
		<td class="btext" align="right"><%=col1%></td>
		<td class="btext" align="right"><%=col2%></td>
		<td class="btext" align="right"><%=ndf.format(col4)%></td>
	</tr>
<%
}
if(mode!=null && mode.equals("2")){
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	String q1 = "",qrere = "",qryReplace = "";
	if(per1!=null && !per1.equals("<1980"))
		qryReplace = " and to_char(DATE_CREATION,'YYYY')='"+per1+"'";
	else
		qryReplace = " and to_char(DATE_CREATION,'YYYY')<'1980'";
	if(per2!=null && per2.equals("MVS"))
	{
		qryReplace += " AND type_of_asset_code ='03'";
	}
	else 	if(per2!=null && per2.equals("SVS"))
		qryReplace += " AND type_of_asset_code in ('01','02','09')";
	else 	if(per2!=null && per2.equals("HP"))
		qryReplace += " AND type_of_asset_code ='04' ";
	q1 = "select count(distinct a.asset_code)assets,count(distinct c.hab_code)habs,substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_asset_hab_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl hd where a.asset_code=b.asset_code and a.asset_code=c.asset_code and b.asset_code=b.asset_code and c.hab_code=d.panch_code and d.panch_code=hd.hab_code and c.hab_code=hd.hab_code "+qryReplace+" group by substr(a.hab_code,1,2)";

	System.out.println(q1);
	rs1=st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(3),rs1.getString(1)+"@"+rs1.getString(2)); 
	}	
	Hashtable ht2 = new Hashtable();
	qrere = "select sum(asset_cost)cost,substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code "+qryReplace+" group by substr(a.hab_code,1,2)";
	//System.out.println(qrere);
	rs2=st2.executeQuery(qrere);
	while(rs2.next())
	{
		ht2.put(rs2.getString(2),rs2.getString(1)); 
	}
	//if(per!=null && !per.equals(""))
	//{
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
		if(val1!=null && !val1.equals("null")){}else{val1="0@0";}
		String val2 = ""+ht2.get(rs3.getString(1));
		if(val2!=null && !val2.equals("null")){}else{val2="0";}
		String[] values1 = val1.split("@");
		col1 += Integer.parseInt(values1[0]);col2 += Integer.parseInt(values1[1]);
		col4 += Double.parseDouble(val2);
%>
			<tr>
				<td class="rptValue" align="center"><%=count++%></td>
				<td class="rptValue" align="left"><%=rs3.getString(2)%></td>
				<td class="rptValue" align="right"><%=values1[0]%></td>
				<td class="rptValue" align="right"><%=values1[1]%></td>
				<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(val2))%></td>
			</tr>
		<%
	}
%>
	<tr>
		<td class="btext" align="center" colspan="2">Total</td>
		<td class="btext" align="right"><%=col1%></td>
		<td class="btext" align="right"><%=col2%></td>
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
</table></table>
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="assetname">
<INPUT type="hidden" name="mode">
</form>
</body>
</html>