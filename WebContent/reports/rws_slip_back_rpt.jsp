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
		covBy = "Covered by 31.03."+currentYear;
	}
	else if(per.equals(prevFinYear))
	{
		dir_tbl  = "rws_habitation_dir_his_tbl";
		covBy = "Covered by 31.03."+currentYear;
	}
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Slipped back Habitation Details</td>	
	</tr>
	<tr align = center>
		<td class=btext>Sl.No</td>
		<td class=btext>District</td>
		<td class=btext>Mandal</td>
		<td class=btext>Panchayat</td>
		<td class=btext>Village</td>
		<td class=btext>Hab Code</td>
		<td class=btext>Hab Name</td>
		<td class=btext>Prev Status</td>
		<td class=btext>Present Status</td>
		<td class=btext>Reasons for Slippage</td>
		<td class=btext>NSS Details(i.e. Fl,Br)</td>
	</tr>
	<%
	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

	//rs2=st2.executeQuery("select distinct d.dcode,d.dname from rws_district_tbl d  where dcode<> '16'  order by d.dcode,d.dname");

	stq1=conn.createStatement();
	Statement stq2=conn.createStatement();
	stq3=conn.createStatement();
	stq4=conn.createStatement();


	int count=0,count1=0,count2=0,plaintot=0,sctot=0,sttot=0;
	int j=1;
	
	String q1 = "select dname,mname,pname,vname,panch_code,panch_name,nvl(PREVIOUS_YR_STATUS,'-'),coverage_status, SLIPPAGE_DESC from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+dir_tbl+" hd,RWS_SLIPPAGE_REASON_TBL hs where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr (h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and hd.slippage_code is not null and hd.SLIPPAGE_CODE=hs.SLIPPAGE_CODE order by d.dcode";//and coverage_status='NSS' 
	System.out.println("Q1:"+q1);
	try
	{
	rsq1 = stq1.executeQuery(q1);
	while(rsq1.next())
	{
		int cuur_stat1=0;
		int prev_status1=0;
		String cuur_stat = rsq1.getString("COVERAGE_STATUS");
		String prev_status = rsq1.getString(7);
		if(cuur_stat==null)cuur_stat="-";
		if(prev_status==null)prev_status="-";
		if(cuur_stat.equals("FC"))
		  cuur_stat1=7;
		if(cuur_stat.equals("PC4"))
		  cuur_stat1=6;
		if(cuur_stat.equals("PC3"))
		  cuur_stat1=5;
		if(cuur_stat.equals("PC2"))
		  cuur_stat1=4;
		if(cuur_stat.equals("PC1"))
		  cuur_stat1=3;
		if(cuur_stat.equals("NC"))
		  cuur_stat1=2;
		if(cuur_stat.equals("NSS"))
		  cuur_stat1=1;
			  
		if(prev_status.equals("FC"))
		  prev_status1=7;
		if(prev_status.equals("PC4"))
		  prev_status1=6;
		if(prev_status.equals("PC3"))
		  prev_status1=5;
		if(prev_status.equals("PC2"))
		  prev_status1=4;
		if(prev_status.equals("PC1"))
		  prev_status1=3;
		if(prev_status.equals("NC"))
		  prev_status1=2;
		if(prev_status.equals("NSS"))
		  prev_status1=1;  
	if(prev_status1 > cuur_stat1){
	%>
	<tr>
		<td class="rptValue" nowrap><%=++count%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(1)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(2)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(3)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(4)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(5)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(6)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(7)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(8)%></td>
		<td class="rptValue" nowrap><%=rsq1.getString(9)%></td>
	<%
		//}
		if(rsq1.getString(8).equals("NSS"))
		{
			%>
			<td class="rptValue" nowrap>
			<%
			String q2 = "select contamination_name,nvl(cont_perc,'0') from RWS_HAB_CONTAMINATION_TBL a,RWS_CONTAMINATION_TBL b where a.cont_type=b.contamination_code and hab_code='"+rsq1.getString(5)+"'";
			//System.out.println("Q2:"+q2);
			rs2=st2.executeQuery(q2);
			if(rs2.isBeforeFirst()){
			while(rs2.next())
			{
				%>
						<%=rs2.getString(1)%>-<%=rs2.getString(2)%>;
				<%
			}
		}
				%>
				</td>
				<%
			//if(rs2!=null)rs2.close();
		}
		else
		{
	%>
		<td class="rptValue" nowrap align=center>-</td>
	<%}%>
	</tr>
<%
	}
		}}catch(Exception e)
		{e.printStackTrace();}
				%>
 				<%
	}
	catch(Exception e)
	{e.printStackTrace();}
	finally
	{
		if(rsq1!=null)rsq1.close();
		if(stq1!=null)stq1.close();
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
		<td align="center" class="rptHeading" colspan=25>Slipped back Habitation Details</td>	
	</tr>
	<tr align = center>
		<td class=btext>Sl.No</td>
		<td class=btext>District</td>
		<td class=btext>Mandal</td>
		<td class=btext>Panchayat</td>
		<td class=btext>Village</td>
		<td class=btext>Hab Code</td>
		<td class=btext>Hab Name</td>
		<td class=btext>Prev Status</td>
		<td class=btext>Present Status</td>
		<td class=btext>Reasons for Slippage</td>
		<td class=btext>NSS Details(i.e. Fl,Br)</td>
	</tr>
	</table>
<%}%>
</form>
</body>
</html>

