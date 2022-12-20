<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<html>
<%
int col1=0,col2=0,col3=0,col4=0,col7=0,col8=0,col9=0,col10=0,col13=0,col14=0,col15=0,col16=0,col17=0,col18=0;
double col5=0.0,col6=0.0,col11=0.0,col12=0.0,col19=0.0,col20=0.0,col21=0.0,col22=0.0,col23=0.0,col24=0.0;
DecimalFormat ndf=new DecimalFormat("####.00");
%>
<head>
<title></title>
</head>
<body bgcolor="#edf2f8">
<form action="rws_work_habs_mandal_rpt.jsp">
<p align="right"><font face="verdana" size="2" color="red"><B>Amount Rs. In Lakhs
</p>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
			<td align="center" class="rptHeading" colspan=16><font style="text-transform: uppercase;">Habitations Covered under ongoing works - Mandal Wise</font></td>		
	</tr>
	<tr  align="center">
		<td align="center" class="btext" colspan="16" >District: All &nbsp; &nbsp;</td>
	</tr>	
	<tr align=center>
		<td class=btext rowspan=2>Sl.No</td>
		<td class=btext rowspan=2>District Code</td>
		<td class=btext rowspan=2>District Name</td>
		<td class=btext rowspan=2>Mandal Code</td>
		<td class=btext rowspan=2>Mandal Name</td>
		<td class=btext rowspan=2>Total Works</td>
		<td class=btext rowspan=2>Sanction Amount</td>
		<td class=btext rowspan=2>Exp. Incurred</td>
		<td class=btext colspan=8>Habitations Covered under ongoing works</td>
	</tr>
	<tr>
		<td class=btext rowspan=1 colspan=1>Total</td>
		<td class=btext rowspan=1 colspan=1>FC</td>
		<td class=btext rowspan=1 colspan=1>PC4</td>
		<td class=btext rowspan=1 colspan=1>PC3</td>
		<td class=btext rowspan=1 colspan=1>PC2</td>
		<td class=btext rowspan=1 colspan=1>PC1</td>
		<td class=btext rowspan=1 colspan=1>NC</td>
		<td class=btext rowspan=1 colspan=1>NSS</td>
	</tr>

	<%
		Statement col1st=null,col2st=null,col3st=null,col4st=null;  
		ResultSet col1rs = null,col2rs = null,col3rs = null,col4rs = null;
	try
	{
		col1st = conn.createStatement();
		col2st  = conn.createStatement();
		col3st  = conn.createStatement();
		col4st  = conn.createStatement();
		String getDnameQuery = "select distinct d.dcode,d.dname,m.mcode,m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' order by d.dcode,m.mcode";
		int sno=1;
		col1rs = col1st.executeQuery(getDnameQuery);
		while(col1rs.next())
		{
				double totExp = 0.0,workamount=0;
				int total=0,fc=0,pc4=0,pc3=0,pc2=0,pc1=0,nc=0,nss=0,workcount=0;
				%>
				<tr>
					<td class=rptValue><%=sno++%></td>
					<td class=rptValue align="center"><%=col1rs.getString(1)%></td>
					<td class=rptValue nowrap><%=col1rs.getString(2)%></td>
					<td class=rptValue align="center"><%=col1rs.getString(3)%></td>
					<td class=rptValue nowrap><%=col1rs.getString(4)%></td>
				<%
				String q3 = "select DISTINCT count(*),WORK_ID,SANCTION_AMOUNT from rws_work_hab_view where dcode='"+col1rs.getString(1)+"' and substr (hab_code,1,2)='"+col1rs.getString(1)+"' and substr(hab_code,6,2)='"+col1rs.getString(3)+"' group by WORK_ID,SANCTION_AMOUNT";
					col3rs = col3st.executeQuery(q3);
					workamount = 0.0;workcount=0;
					while(col3rs.next()){workcount++;workamount+=col3rs.getDouble(3);}
				%>
					<td class=rptValue><%=workcount%></td>
					<td class=rptValue><%=ndf.format(workamount)%></td>
				<%
					String q4 = "select sum(a.expenditure_upto_the_pre_year+b.total) from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL a,rws_exp_view b where b.work_id=a.work_id(+) and a.work_id IN(select DISTINCT WORK_ID from rws_work_hab_view where dcode='"+col1rs.getString(1)+"' and substr (hab_code,1,2)='"+col1rs.getString(1)+"' and substr(hab_code,6,2)='"+col1rs.getString(3)+"' group by WORK_ID,SANCTION_AMOUNT)";
					col4rs = col4st.executeQuery(q4);
					totExp = 0;
					while(col4rs.next()){totExp+=col4rs.getDouble(1);}
				%>
					<td class=rptValue><%=ndf.format(totExp)%></td>
				<%
				String q2 = "select distinct a.hab_code,b.coverage_status from rws_work_hab_view a,rws_habitation_directory_tbl b where a.dcode='"+col1rs.getString(1)+"' and a.hab_code=b.hab_code and substr (a.hab_code,1,2)='"+col1rs.getString(1)+"' and substr(a.hab_code,6,2)='"+col1rs.getString(3)+"'";
				col2rs = col2st.executeQuery(q2);
				while(col2rs.next())
				{
					total++;
					if(col2rs.getString(2).equals("FC"))fc++;
					else if(col2rs.getString(2).equals("PC4"))pc4++;
					else if(col2rs.getString(2).equals("PC3"))pc3++;
					else if(col2rs.getString(2).equals("PC2"))pc2++;
					else if(col2rs.getString(2).equals("PC1"))pc1++;
					else if(col2rs.getString(2).equals("NC"))nc++;
					else if(col2rs.getString(2).equals("NSS"))nss++;
				}
				%>
				
					<td class=rptValue><%=total%></td>
					<td class=rptValue><%=fc%></td>
					<td class=rptValue><%=pc4%></td>
					<td class=rptValue><%=pc3%></td>
					<td class=rptValue><%=pc2%></td>
					<td class=rptValue><%=pc1%></td>						
					<td class=rptValue><%=nc%></td>
					<td class=rptValue><%=nss%></td>
				<%
					col4rs.close();
					col3rs.close();
					col2rs.close();
				%></TR><%
		}
}
catch(Exception e)
{
	System.out.println("Error Occured:"+e.getMessage());
}
finally
{
	if(col4rs!=null)col4rs.close();
	if(col3rs!=null)col3rs.close();
	if(col2rs!=null)col2rs.close();
	if(col1rs!=null)col1rs.close();

	if(col4st!=null)col4st.close();
	if(col3st!=null)col3st.close();
	if(col2st!=null)col2st.close();
	if(col1st!=null)col1st.close();
}
%>
</table>
<p  align="center">
<%@ include file="footer.jsp" %>
</p>
</form>
</BODY>
</HTML>
<%@ include file="connClose.jsp" %>
<%}finally{}%>