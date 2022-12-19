<%@ include file="conn3.jsp" %>
<html>
<head>
<script language="JavaScript">
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:10pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:10pt;
	background-color:#ffffff
}
</style>

<title>Graphs</title>
</script>
</head>
<body>
<p align="center">
<table border="1" cellspacing="1" cellpadding="1" width="50%">
<tr>
<td align="center" class=mystyle>Total  Assets </td>
</tr>
</table>
<table border="1" cellspacing="1" cellpadding="1" width="50%">
<tr>
<td class=btext align="center">Sno</td>
<td class=btext align="center">Type of Asset</td>
<td class=btext align="center">Asset Name</td>
<td class=btext align="center">Total</td>
</tr>
<%	
	try
	{
	int sno=1;
	int total=0;
	String assetname="";
	String assetcode="";
	stmt=conn.createStatement();
	rs=stmt.executeQuery("select count(*),type_of_asset_name,b.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_type_tbl b where a.type_of_asset_code=b.type_of_asset_code group by b.type_of_asset_code,type_of_asset_name ");
	while(rs.next())
		{
		total=rs.getInt(1);
		assetname=rs.getString(2);
		assetcode=rs.getString(3);
		%>
		<tr>
		<td class=btext align="center"><%= sno++ %></td>
		<td class=btext align="center"><%= assetcode %></td>
		<td class=btext align="center"><%= assetname %></td>
		<td class=btext align="center"><%= total %></td>
		</tr>
		<%
		}
	}
		catch(Exception e)
		{
			out.println("Exception"+e);
		}




    %>
</table>
</body>
</p>
</html>