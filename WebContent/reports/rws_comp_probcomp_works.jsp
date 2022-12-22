<%@ page contentType = "application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query3=null,query4=null,query5=null;
	Statement st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
%>
<html>
<title> WaterSoft </title>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=20><b>Project Shelf Analysis Report</b></td>		
	</tr>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=20><font color=red>Note : Works Under Following Criteria: Proable Date Of Completion and Actual Date Of Completion dates between 01/04/2010-31/03/2011, PLAN Works and Not related to NRDWP(SUS)</font></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>District</td>
		<td class=btext>Work ID</td>
		<td class=btext>Work Name</td>
		<td class=btext>Admn Sanc No.</td>
		<td class=btext>Admn Sanc Date</td>
		<td class=btext>Cost</td>
		<td class=btext>Program</td>
		<td class=btext>Sub Program</td>
		<td class=btext>Category</td>
		<td class=btext>Type</td>
		<td class=btext>If Aug(MainScheme)</td>
		<td class=btext>Habitation Code</td>
		<td class=btext>Habitation Name</td>
		<td class=btext>Status</td>
		<td class=btext>Source Code</td>
		<td class=btext>Grounding Date</td>
		<td class=btext>Prob Date of Comp</td>
		<td class=btext>Actual Date of Comp</td>
		<td class=btext>Sent to DDWS (or) Not</td>

	</tr>
	<%
	try
	{
	String q = "select work_id,nvl(source_code,'-') from rws_source_iden_fin_tbl where work_id in(select a.work_id from rws_work_admn_tbl a,rws_contractor_selection_tbl b where a.work_id=b.work_id and PROBABLE_DATE >='01/APR/2010' and PROBABLE_DATE <'01/APR/2011' and plan_code='1' union select a.work_id from rws_work_admn_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and DATE_OF_COMPLETION>='01/APR/2010' and DATE_OF_COMPLETION<'01/APR/2011' and plan_code='1')";
	Statement stt = conn.createStatement();
	ResultSet rss = stt.executeQuery(q);
	Hashtable ht = new Hashtable();
	while(rss.next())
	{
		ht.put(rss.getString(1),rss.getString(2)); 
	}
	if(rss!=null)rss.close();if(stt!=null)stt.close();
	//System.out.println("1");
	String q1 = "select work_id,nvl(to_char(grounding_date,'dd/mm/yyyy'),'-') from rws_work_commencement_tbl where work_id in(select a.work_id from rws_work_admn_tbl a,rws_contractor_selection_tbl b where a.work_id=b.work_id and PROBABLE_DATE >='01/APR/2010' and PROBABLE_DATE <'01/APR/2011' and plan_code='1' union select a.work_id from rws_work_admn_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and DATE_OF_COMPLETION>='01/APR/2010' and DATE_OF_COMPLETION<'01/APR/2011' and plan_code='1')";
	Statement stt1 = conn.createStatement();
	ResultSet rss1 = stt1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rss1.next())
	{
		ht1.put(rss1.getString(1),rss1.getString(2)); 
	}
	if(rss1!=null)rss1.close();if(stt1!=null)stt1.close();
	String q2 = "select work_id,nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'-') from rws_contractor_selection_tbl where work_id in(select a.work_id from rws_work_admn_tbl a,rws_contractor_selection_tbl b where a.work_id=b.work_id and PROBABLE_DATE >='01/APR/2010' and PROBABLE_DATE <'01/APR/2011' and plan_code='1' union select a.work_id from rws_work_admn_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and DATE_OF_COMPLETION>='01/APR/2010' and DATE_OF_COMPLETION<'01/APR/2011' and plan_code='1')";
	Statement stt2 = conn.createStatement();
	ResultSet rss2 = stt2.executeQuery(q2);
	Hashtable ht2 = new Hashtable();
	while(rss2.next())
	{
		ht2.put(rss2.getString(1),rss2.getString(2)); 
	}
	if(rss2!=null)rss2.close();if(stt2!=null)stt2.close();
	String q3 = "select work_id,nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id in(select a.work_id from rws_work_admn_tbl a,rws_contractor_selection_tbl b where a.work_id=b.work_id and PROBABLE_DATE >='01/APR/2010' and PROBABLE_DATE <'01/APR/2011' and plan_code='1' union select a.work_id from rws_work_admn_tbl a,rws_work_completion_tbl b where a.work_id=b.work_id and DATE_OF_COMPLETION>='01/APR/2010' and DATE_OF_COMPLETION<'01/APR/2011' and plan_code='1')";
	Statement stt3 = conn.createStatement();
	ResultSet rss3 = stt3.executeQuery(q3);
	Hashtable ht3 = new Hashtable();
	while(rss3.next())
	{
		ht3.put(rss3.getString(1),rss3.getString(2)); 
	}
	if(rss3!=null)rss3.close();if(stt3!=null)stt3.close();
	String q4 = "select WORK_ID,HAB_CODE FROM RWS_WORKS_ACTION_PLAN_HABS_TBL";
	Statement stt4 = conn.createStatement();
	ResultSet rss4 = stt4.executeQuery(q4);
	Hashtable ht4 = new Hashtable();
	while(rss4.next())
	{
		ht4.put(rss4.getString(1),rss4.getString(2)); 
	}
	if(rss4!=null)rss4.close();if(stt4!=null)stt4.close();
	//System.out.println("4");
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2=st2.executeQuery("select dname,a.work_id,a.work_name,admin_no,to_char(admin_date,'dd/mm/yyyy') as adate,sanction_amount,programme_name,subprogramme_name,decode (a.category_code,'1','Projects','2','Normal','3','DistrictLevel') as category,decode(aug_new_code,'1','Main Scheme','2','Augmentation') as type,nvl(AUG_WORKID,'-'),panch_code,panch_name,coverage_status from rws_work_admn_tbl a,rws_contractor_selection_tbl b,rws_admn_hab_lnk_tbl h,rws_complete_hab_view c,rws_programme_tbl p,rws_subprogramme_tbl sp where a.work_id=b.work_id and b.work_id=h.work_id and a.work_id=h.work_id and h.hab_code=c.panch_code and a.programme_code=p.programme_code and p.programme_code=sp.programme_code and a.subprogramme_code=sp.subprogramme_code and PROBABLE_DATE >='01/APR/2010' and PROBABLE_DATE <'01/APR/2011' and plan_code='1' and a.programme_code<>'50' union select dname,a.work_id,a.work_name,admin_no,to_char(admin_date,'dd/mm/yyyy') as adate,sanction_amount,programme_name,subprogramme_name,decode (a.category_code,'1','Projects','2','Normal','3','DistrictLevel') as category,decode(aug_new_code,'1','Main Scheme','2','Augmentation') as type,nvl(AUG_WORKID,'-'),panch_code,panch_name,coverage_status from rws_work_admn_tbl a,rws_work_completion_tbl b,rws_admn_hab_lnk_tbl h,rws_complete_hab_view c,rws_programme_tbl p,rws_subprogramme_tbl sp where a.work_id=b.work_id and b.work_id=h.work_id and a.work_id=h.work_id and h.hab_code=c.panch_code and a.programme_code=p.programme_code and p.programme_code=sp.programme_code and a.subprogramme_code=sp.subprogramme_code and DATE_OF_COMPLETION >='01/APR/2010' and DATE_OF_COMPLETION <'01/APR/2011' and plan_code='1' and a.programme_code<>'50' order by dname,work_id");
	int sno = 1;
	while(rs2.next())
	{
		String sCode = ""+ht.get(rs2.getString(2));
		if(sCode!=null && !sCode.equals("null")){}else{sCode="-";}
		String gdate = ""+ht1.get(rs2.getString(2));
		if(gdate!=null && !gdate.equals("null")){}else{gdate="-";}
		String pdate = ""+ht2.get(rs2.getString(2));
		if(pdate!=null && !pdate.equals("null")){}else{pdate="-";}
		String cdate = ""+ht3.get(rs2.getString(2));
		if(cdate!=null && !cdate.equals("null")){}else{cdate="-";}
		String sentNotsent = ""+ht4.get(rs2.getString(2));
		if(sentNotsent!=null && !sentNotsent.equals("null")){sentNotsent="Sent";}else{sentNotsent="Not Sent";}
		%>
		<tr>
			<td class="rptValue" align="left"><%=sno++%></td>
			<td class="rptValue" align="left"><%=rs2.getString(1)%></td>
			<td class="rptValue" align="left">'<%=rs2.getString(2)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(3)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(4)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(5)%></td>
			<td class="rptValue" align="right"><%=rs2.getString(6)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(7)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(8)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(9)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(10)%></td>
			<td class="rptValue" align="left">'<%=rs2.getString(11)%></td>
			<td class="rptValue" align="left">'<%=rs2.getString(12)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(13)%></td>
			<td class="rptValue" align="left"><%=rs2.getString(14)%></td>
			<td class="rptValue" align="left"><%=sCode%></td>
			<td class="rptValue" align="left"><%=gdate%></td>
			<td class="rptValue" align="left"><%=pdate%></td>
			<td class="rptValue" align="left"><%=cdate%></td>
			<td class="rptValue" align="left"><%=sentNotsent%></td>
</tr>
		<%
	}
	%>
	
<%
			}
				catch(Exception e)
			{System.out.println(e.getMessage());}
				finally
			{
					if(rs3!=null)rs3.close();if(st3!=null)st3.close();
			}
	%>
<%@ include file="connClose.jsp" %>
<%}%>
</table>
</form>
</body>
</html>