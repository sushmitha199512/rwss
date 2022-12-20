<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%		
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	int sno=1;
	String per = request.getParameter("per");
	if(per==null)per="";
	int col3=0,col4=0,col5=0,col7=0,col8=0,col9=0,col10=0,col11=0,col12=0,col13=0,col15=0,col16=0,col17=0,col18=0,col19=0,col20=0;
	double col6=0.0,col14=0;
try
{
%>
<html>
<title> WaterSoft </title>
<head>
<script>
function fnGet()
{
	if(document.f1.per.value=="")
		alert("Please Select Date");
	else
		document.forms[0].submit();
}
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center">
			<font color="ffffff">Asset Statement Report</font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="btext" colspan=21>District: All&nbsp;&nbsp;&nbsp;Assets As on Date:<font color=red><%=per%></font></td>		
	</tr>	
	<tr align="center">
		<td class="btext" rowspan="3">S. No.</td>
		<td class="btext" rowspan="3">Type of Asset </td>
		<td class="btext" colspan="8">Total Assets </td>
		<td class="btext" colspan="8">Functional Assets </td>
		<td class="btext" rowspan="3">Non Functional Assets </td>
		<td class="btext" rowspan="3"><span class="mandatory">%</span> Of Functional Assets w.r.to Total Assets</td>
		<td class="btext" rowspan="3">Remarks</td>
	</tr>
	<tr align="center">
		<td class="btext" rowspan="2">Assets</td>
		<td class="btext" rowspan="2">Habs</td>
		<td class="btext" rowspan="2">Population</td>
		<td class="btext" rowspan="2">Cost(In Lakhs)</td>
		<td class="btext" colspan="4">Population Served with Current LPCD </td>
		<td class="btext" rowspan="2">Assets</td>
		<td class="btext" rowspan="2">Habs</td>
		<td class="btext" rowspan="2">Population</td>
		<td class="btext" rowspan="2">Cost(In Lakhs)</td>
		<td class="btext" colspan="4">Population Served with Current LPCD </td>
	</tr>
	<tr align="center" >
		<td class="btext">&lt;=40</td>
		<td class="btext">&gt;40&amp;&lt;=55</td>
		<td class="btext">&gt;55&amp;&lt;=70</td>
		<td class="btext">&gt;70</td>
		<td class="btext">&lt;=40</td>
		<td class="btext">&gt;40&amp;&lt;=55</td>
		<td class="btext">&gt;55&amp;&lt;=70</td>
		<td class="btext">&gt;70</td>
	</tr>
	<tr align="center">
		<td class="btext">1</td>
		<td class="btext">2</td>
		<td class="btext">3</td>
		<td class="btext">4</td>
		<td class="btext">5</td>
		<td class="btext">6</td>
		<td class="btext">7</td>
		<td class="btext">8</td>
		<td class="btext">9</td>
		<td class="btext">10</td>
		<td class="btext">11</td>
		<td class="btext">12</td>
		<td class="btext">13</td>
		<td class="btext">14</td>
		<td class="btext">15</td>
		<td class="btext">16</td>
		<td class="btext">17</td>
		<td class="btext">18</td>
		<td class="btext">19</td>
		<td class="btext">20</td>
		<td class="btext">21</td>
	</tr>
<%
		System.out.println("per1"+per);
	DecimalFormat ndf = new DecimalFormat("####.00");
	if(per!=null && !per.equals("")){
		st1 = conn.createStatement();
	st2 = conn.createStatement();
	String q1 = "select count(distinct a.asset_code)assets,sum(asset_cost)cost,count(distinct c.hab_code)habs,sum(POPU_BENEFITED)ben,sum (hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU)totpop,sum(case when hd.exist_water_level<=40 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop1,sum (case when hd.exist_water_level>40 and hd.exist_water_level<=55 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop2,sum(case when hd.exist_water_level>55 and hd.exist_water_level<=70 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop3,sum(case when hd.exist_water_level>70 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop4,a.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_asset_hab_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl hd where a.asset_code=b.asset_code and a.asset_code=c.asset_code and b.asset_code=b.asset_code and c.hab_code=d.panch_code and d.panch_code=hd.hab_code and c.hab_code=hd.hab_code and date_creation<=to_date('"+per+"','dd/mm/yyyy') group by a.type_of_asset_code order by (case type_of_asset_code when '03' THEN 1 when '01' THEN 2 when '02' THEN 3 when '09' THEN 4 when '04' THEN 5 when '05' THEN 6 when '06' THEN 7 when '07' THEN 8 when '08' THEN 9 END) ASC";
	//System.out.println("q1:"+q1);
	rs1=st1.executeQuery(q1);
	String q2 = "select count(distinct a.asset_code)assets,sum(asset_cost)cost,count(distinct c.hab_code)habs,sum(POPU_BENEFITED)ben,sum (hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU)totpop,sum(case when hd.exist_water_level<=40 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop1,sum (case when hd.exist_water_level>40 and hd.exist_water_level<=55 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop2,sum(case when hd.exist_water_level>55 and hd.exist_water_level<=70 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop3,sum(case when hd.exist_water_level>70 then hd.CENSUS_PLAIN_POPU+hd.CENSUS_sc_POPU+hd.CENSUS_st_POPU else 0 end)as pop4,a.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_asset_hab_tbl c,rws_complete_hab_view d,rws_habitation_directory_tbl hd where a.asset_code=b.asset_code and a.asset_code=c.asset_code and b.asset_code=b.asset_code and c.hab_code=d.panch_code and d.panch_code=hd.hab_code and c.hab_code=hd.hab_code and date_creation<=to_date('"+per+"','dd/mm/yyyy') and asset_status='1' group by a.type_of_asset_code order by (case type_of_asset_code when '03' THEN 1 when '01' THEN 2 when '02' THEN 3 when '09' THEN 4 when '04' THEN 5 when '05' THEN 6 when '06' THEN 7 when '07' THEN 8 when '08' THEN 9 END) ASC";
	//System.out.println("q2:"+q2);
	rs2=st2.executeQuery(q2);
	st4 = conn.createStatement();
	rs4 = st4.executeQuery("select sum(asset_cost)cost,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and date_creation<=to_date('"+per+"','dd/mm/yyyy') group by a.type_of_asset_code order by (case type_of_asset_code when '03' THEN 1 when '01' THEN 2 when '02' THEN 3 when '09' THEN 4 when '04' THEN 5 when '05' THEN 6 when '06' THEN 7 when '07' THEN 8 when '08' THEN 9 END) ASC");
	st5 = conn.createStatement();
	rs5 = st5.executeQuery("select sum(asset_cost)cost,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and date_creation<=to_date('"+per+"','dd/mm/yyyy') and asset_status='1' group by a.type_of_asset_code order by (case type_of_asset_code when '03' THEN 1 when '01' THEN 2 when '02' THEN 3 when '09' THEN 4 when '04' THEN 5 when '05' THEN 6 when '06' THEN 7 when '07' THEN 8 when '08' THEN 9 END) ASC");
	System.out.println("q2:"+q2);
	rs2=st2.executeQuery(q2);
try
{
	if(per!=null && !per.equals(""))
	{
	st3=conn.createStatement();
	String qrys = "SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_code<> 10 order by (case type_of_asset_name when 'CPWS' THEN 1 when 'PWS' THEN 2 when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6 when 'OPEN WELLS' THEN 7 when 'PONDS' THEN 8 when 'OTHERS' THEN 9 END) ASC";
	System.out.println("sssssssssssssss:"+qrys);
	rs3=st3.executeQuery(qrys);
	while(rs3.next())
	{
		int totAssets = 0,funAssets = 0;
		%>
			<tr>
			<td class="rptValue" align="center"><%=sno++%></td>
			<td class="rptValue" align="left" nowrap><%=rs3.getString(2)%></td>
		<%
		String pop = "",pop1 = "";
		if(rs1.next())
		{
			totAssets = rs1.getInt(1);
			if(rs3.getString(1).equals("01") || rs3.getString(1).equals("02") || rs3.getString(1).equals("03") || rs3.getString(1).equals("09"))
			{
				pop=rs1.getString(5);
			}
			else 
			{
				pop=rs1.getString(4);
			}
			%>
				<td class="rptValue" align="right"><%=rs1.getString(1)%></td>
				<td class="rptValue" align="right"><%=rs1.getString(3)%></td>
				<td class="rptValue" align="right"><%=pop%></td>
				<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(rs1.getString(2)))%></td>
				<td class="rptValue" align="right"><%=rs1.getString(6)%></td>
				<td class="rptValue" align="right"><%=rs1.getString(7)%></td>
				<td class="rptValue" align="right"><%=rs1.getString(8)%></td>
				<td class="rptValue" align="right"><%=rs1.getString(9)%></td>
			<%
			col3 += rs1.getInt(1);col4+= rs1.getInt(3);col5 += Integer.parseInt(pop);col6 += rs1.getDouble(2);
			col7 += rs1.getInt(6);col8+= rs1.getInt(7);col9 += rs1.getInt(8);col10 += rs1.getDouble(9);
		}
		else
		{
			%>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
			<%
		}
		if(rs2.next())
		{
			funAssets = rs2.getInt(1);
			if(rs3.getString(1).equals("01") || rs3.getString(1).equals("02") || rs3.getString(1).equals("03") || rs3.getString(1).equals("09"))
			{
				pop1=rs2.getString(5);
			}
			else 
			{
				pop1=rs2.getString(4);
			}
			%>
				<td class="rptValue" align="right"><%=rs2.getString(1)%></td>
				<td class="rptValue" align="right"><%=rs2.getString(3)%></td>
				<td class="rptValue" align="right"><%=pop1%></td>
				<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(rs2.getString(2)))%></td>
				<td class="rptValue" align="right"><%=rs2.getString(6)%></td>
				<td class="rptValue" align="right"><%=rs2.getString(7)%></td>
				<td class="rptValue" align="right"><%=rs2.getString(8)%></td>
				<td class="rptValue" align="right"><%=rs2.getString(9)%></td>
			<%
			col11 += rs2.getInt(1);col12+= rs2.getInt(3);col13 += Integer.parseInt(pop1);col14 += rs2.getDouble(2);
			col15 += rs2.getInt(6);col16+= rs2.getInt(7);col17 += rs2.getInt(8);col18 += rs2.getDouble(9);
		}
		else
		{
			%>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
				<td class="rptValue" align="right">0</td><td class="rptValue" align="right">0</td>
			<%
		}
		col19 = col3-col11;col20 = (col11*100)/col3;
		int percentage = 0;
		if(funAssets>0)percentage = (funAssets*100)/totAssets;
%>
		<td class="rptValue" align="right"><%=totAssets-funAssets%></td>
		<td class="rptValue" align="right"><%=percentage%></td>
		<td>&nbsp;</td>
	</tr>
<%
	}
%>
	<tr>
		<td class="btext" colspan="2" align="center">Total</td>
		<td class="btext" align="right"><%=col3%></td>
		<td class="btext" align="right"><%=col4%></td>
		<td class="btext" align="right"><%=col5%></td>
		<td class="btext" align="right"><%=ndf.format(col6)%></td>
		<td class="btext" align="right"><%=col7%></td>
		<td class="btext" align="right"><%=col8%></td>
		<td class="btext" align="right"><%=col9%></td>
		<td class="btext" align="right"><%=col10%></td>
		<td class="btext" align="right"><%=col11%></td>
		<td class="btext" align="right"><%=col12%></td>
		<td class="btext" align="right"><%=col13%></td>
		<td class="btext" align="right"><%=ndf.format(col14)%></td>
		<td class="btext" align="right"><%=col15%></td>
		<td class="btext" align="right"><%=col16%></td>
		<td class="btext" align="right"><%=col17%></td>
		<td class="btext" align="right"><%=col18%></td>
		<td class="btext" align="right"><%=col19%></td>
		<td class="btext" align="right"><%=col20%></td>
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
<%}
}
catch(Exception e)
{e.printStackTrace();}
%>
</table></table>
</form>
</body>
</html>