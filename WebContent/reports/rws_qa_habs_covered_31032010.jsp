<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@	page import="java.sql.*, java.util.*, java.util.Date, java.text.* " %>
<%
	Statement stq1=null,st2=null,stq3=null,stq4=null,st3=null,st44=null;
	ResultSet  rsq1=null,rs2=null,rsq3=null,rsq4=null,rs3=null;
	int sno=1;
	int total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,total12=0,total13=0,total14=0,total15=0,total16=0,total17=0,total18=0,total19=0,total20=0,total21=0,total22=0,total23=0;
	int totalInserted = 0;
	Statement stqq =null,popst=null; 
	ResultSet rsqq = null,poprs=null;
	String per = request.getParameter("per");
	String dir_tbl  = "",per_tbl="";
	Date d = new Date();
	SimpleDateFormat sd = new SimpleDateFormat("yyyy");
	int currentYear = Integer.parseInt(sd.format(d));
	String currentFinYear = currentYear+"-"+(currentYear+1);
	String prevFinYear = (currentYear-1)+"-"+(currentYear);
	String covBy = "";
%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 0 cellspacing = 0 cellpadding = 0 width=50% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
	<tr>
		<td class="textborder" align="center" colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<td class="textborder" align="center" colspan="8">Habitation Directory Financial Year&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="per" onchange="this.form.submit()">
			<option value="">Select..</option>
			<%if(per!=null && per.equals(prevFinYear)){%>
				<option value="<%=prevFinYear%>" selected><%=prevFinYear%></option>
			<%}
			else
			{
			%>
				<option value="<%=prevFinYear%>"><%=prevFinYear%></option>
			<%
			}%>

			<%if(per!=null && per.equals(currentFinYear)){%>
				<option value="<%=currentFinYear%>" selected><%=currentFinYear%></option>
			<%}
			else
			{
			%>
				<option value="<%=currentFinYear%>"><%=currentFinYear%></option>
			<%
			}%>
		</select>
		</font></td>
	</tr>
</table>
<%if(per!=null && !per.equals("")){
	if(per.equals(currentFinYear))
	{
		dir_tbl  = "rws_habitation_directory_tbl";
		per_tbl  = "rws_hab_dir_40percent_tbl";
		covBy = "Covered by 31.03."+currentYear;
	}
	else if(per.equals(prevFinYear))
	{
		dir_tbl  = "rws_habitation_dir_his_tbl";
		per_tbl  = "rws_hab_dir_40percent_tbl_prev";
		covBy = "Covered by 31.03."+currentYear;
	}
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>QA(NSS/Slipped back) Habs Covered By 31.03.2010</td>	
	</tr>
	<tr align = center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 2 rowspan=2>NSS</td>
		<td class=btext colspan = 21>Slipped Back</td>
	</tr>
	<tr align = center>
		<td class=btext colspan = 7>Total Habs</td>
		<td class=btext colspan = 7>Targeted</td>
		<td class=btext colspan = 7><%=covBy%></td>
	</tr>
	<tr align = center>
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center"><%=covBy%></td>

		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>
		
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>
		
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>

	</tr>
	<%
	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2=st2.executeQuery("select distinct d.dcode,d.dname from rws_district_tbl d  where dcode<> '16'  order by d.dcode,d.dname");
	stq1=conn.createStatement();


		while(rs2.next())
		{
			int count=0,count1=0,count2=0,plaintot=0,sctot=0,sttot=0;
			int j=1;
			String q1 = "select(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.coverage_status='NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"')a,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.coverage_status='NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"'))b,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"')c,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"'))d,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='FC')aa,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='PC4')bb,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='PC3')cc,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='PC2')dd,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='PC1')ee,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.coverage_status='NC')ff,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"'))c1,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='FC')c2,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='PC4')c3,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='PC3')c4,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='PC2')c5,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='PC1')C6,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT) and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') and a.coverage_status='NC')c7,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"'))D1,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='FC')D2,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='PC4')D3,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='PC3')D4,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='PC2')D5,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='PC1')D6,(Select count(a.hab_code) from "+dir_tbl+" a,"+per_tbl+" b where a.hab_code=b.hab_code and a.slippage_code='0036' and a.coverage_status<>'NSS' and substr(a.hab_code,1,2)='"+rs2.getString(1)+"' and a.hab_code in(select hab_code from "+per_tbl+" where hab_code in(select distinct a.hab_code from rws_admn_hab_lnk_tbl a,"+per_tbl+" b where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT minus select work_id from rws_contractor_selection_tbl where work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT ) and update_prob_date > '31-MAR-2010') and a.hab_code=b.hab_code) and substr(hab_code,1,2) ='"+rs2.getString(1)+"') AND A.COVERAGE_STATUS='NC')D7 from dual";
			try
			{
				rsq1 = stq1.executeQuery(q1);
				rsq1.next();
				total1 += rsq1.getInt(1);
				total2 += rsq1.getInt(2);
				total3 += rsq1.getInt(3);
				total4 += rsq1.getInt(5);
				total5 += rsq1.getInt(6);
				total6 += rsq1.getInt(7);
				total7 += rsq1.getInt(8);
				total8 += rsq1.getInt(9);
				total9 += rsq1.getInt(10);
				total10 += rsq1.getInt(11);
				total11 += rsq1.getInt(12);
				total12 += rsq1.getInt(13);
				total13 += rsq1.getInt(14);
				total14 += rsq1.getInt(15);
				total15 += rsq1.getInt(16);
				total16 += rsq1.getInt(17);
				total17 += rsq1.getInt(18);
				total18 += rsq1.getInt(19);
				total19 += rsq1.getInt(20);
				total20 += rsq1.getInt(21);
				total21 += rsq1.getInt(22);
				total22 += rsq1.getInt(23);
				total23 += rsq1.getInt(24);

			%>
			<tr>	
				<td class="rptValue" align="center"><%=sno++%></td>
				<td class="rptValue"><%=rs2.getString(2)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(1)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(2)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(3)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(5)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(6)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(7)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(8)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(9)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(10)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(11)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(12)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(13)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(14)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(15)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(16)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(17)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(18)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(19)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(20)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(21)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(22)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(23)%></td>
				<td class="rptValue" align="right"><%=rsq1.getString(24)%></td>
			</tr>
		<%
				}catch(Exception e)
				{e.printStackTrace();}
		}
%>
<tr>	
		<td class="btext" colspan="2">Total</td>
		<td class="btext" align="right"><%=total1%></td>
		<td class="btext" align="right"><%=total2%></td>
		<td class="btext" align="right"><%=total3%></td>
		<td class="btext" align="right"><%=total4%></td>
		<td class="btext" align="right"><%=total5%></td>
		<td class="btext" align="right"><%=total6%></td>
		<td class="btext" align="right"><%=total7%></td>
		<td class="btext" align="right"><%=total8%></td>
		<td class="btext" align="right"><%=total9%></td>
		<td class="btext" align="right"><%=total10%></td>
		<td class="btext" align="right"><%=total11%></td>
		<td class="btext" align="right"><%=total12%></td>
		<td class="btext" align="right"><%=total13%></td>
		<td class="btext" align="right"><%=total14%></td>
		<td class="btext" align="right"><%=total15%></td>
		<td class="btext" align="right"><%=total16%></td>
		<td class="btext" align="right"><%=total17%></td>
		<td class="btext" align="right"><%=total18%></td>
		<td class="btext" align="right"><%=total19%></td>
		<td class="btext" align="right"><%=total20%></td>
		<td class="btext" align="right"><%=total21%></td>
		<td class="btext" align="right"><%=total22%></td>
		<td class="btext" align="right"><%=total23%></td>
	</tr>
<%
	}
	catch(Exception e)
	{e.printStackTrace();}
	finally
	{
		if(rs2!=null)rs2.close();
		if(st2!=null)st2.close();
		if(conn!=null)conn.close();
	}
	
 	%>
</table>
<%}
	else
	{
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>QA(NSS/Slipped back) Habs Covered By 31.03.2010</td>	
	</tr>
	<tr align = center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 2 rowspan=2>NSS</td>
		<td class=btext colspan = 21>Slipped Back</td>
	</tr>
	<tr align = center>
		<td class=btext colspan = 7>Total Habs</td>
		<td class=btext colspan = 7>Targeted</td>
		<td class=btext colspan = 7>Covered BY 31.03.2010</td>
	</tr>
	<tr align = center>
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">Covered BY 31.03.2010</td>

		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>
		
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>
		
		<td class=btext align="Center">Total</td>
		<td class=btext align="Center">FC</td>
		<td class=btext align="Center">PC4</td>
		<td class=btext align="Center">PC3</td>
		<td class=btext align="Center">PC2</td>
		<td class=btext align="Center">PC1</td>
		<td class=btext align="Center">NC</td>

	</tr>
	</table>
<%}%>
<p>
<font face="verdana" size="2" color="red">Note:**** 1. Current financial Year Habitation Directory Calulated by 40%</font>
</p>
</form>
</body>
</html>

