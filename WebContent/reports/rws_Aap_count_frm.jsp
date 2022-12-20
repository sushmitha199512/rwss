<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
			</tr>
		</table>
	</caption>
	<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b></caption>
	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>AAP Abstract List</td>	
	</tr>
	<tr align=center  align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext rowspan = 2>District</td>
	<td colspan=3 class=btext align="center">No.of Works</td>
	<td rowspan=2 colspan=1 class=btext align="center">Habs Sanctioned</td>
	<td colspan=3 class=btext align="center">Est.Cost</td>
	<td rowspan=2 colspan=1 class=btext align="center">Exp. Upto Last Fin. Year</td>
	<td rowspan=2 colspan=1 class=btext align="center">Exp. During The Year</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Total Exp.</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Technically Sanctioned</td>	
	<td rowspan=2 colspan=1 class=btext align="center">Grounded</td>
	<td colspan=3 class=btext align="center">Completed</td>	
	</tr>
	<tr>
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
	<td rowspan=1 colspan=1 class=btext align="center">New</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
	<td rowspan=1 colspan=1 class=btext align="center">New</td>		
	<td rowspan=1 colspan=1 class=btext align="center">Total</td>
	<td rowspan=1 colspan=1 class=btext align="center">No.of Works</td>	
    <td rowspan=1 colspan=1 class=btext align="center">Habs Sanctioned</td>	
	<td rowspan=1 colspan=1 class=btext align="center">Habs Covered</td>	
	</tr>
	<%
	String dQuery="";

	if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{}else{
			dQuery=" and substr(w.work_id,5,2)='"+loggedUser.substring(1,3)+"' ";
		}
	DecimalFormat ndf = new DecimalFormat("####.00");
	//int year = Calendar.getInstance().get(Calendar.YEAR); 
//	System.out.println("year year::"+year);
//	String yr=Integer.toString(year);
	//	System.out.println("yr yr::"+yr);
	//updated by swapna on 5-1-2012 
int year=2011;
	String yr=""+2011;
	int sno=1;
	String sqry="SELECT count(*),category_code  FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id  and w.ADMIN_DATE <'01-Apr-"+yr+"'  "+dQuery+"  group by category_code order by 2";
	//System.out.println("sqry:"+sqry);
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(sqry);
	Hashtable h=new Hashtable();
	while(rs1.next())
	{
		h.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	String nqry="select count(*),category_code FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b  where w.work_id=b.work_id  and w.ADMIN_DATE >= '01-Apr-"+yr+"' "+dQuery+" and work_cancel_dt is null  group by category_code order by 2";
	//System.out.println("nqry:"+nqry);
	Statement	stmt2=conn.createStatement();
	////System.out..println("sqry:"+sqry);
	ResultSet rs2=stmt2.executeQuery(nqry);
		Hashtable h1=new Hashtable();
	while(rs2.next())
	{
		h1.put(rs2.getString(2),rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	//String hqry="select count(distinct hab_code),category_code from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b ,rws_aap_selected_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and b.work_id=c.work_id  and work_cancel_dt is null   and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"') group by category_code ";
	String hqry="select count(distinct  hab_code),category_code from rws_AAP_selected_tbl  a,rws_work_admn_tbl w,rws_complete_hab_view d,rws_admn_hab_lnk_tbl c   where a.work_id=w.work_id and d.dcode=substr(a.work_id,5,2) and d.panch_code=c.hab_code and  a.work_id=c.work_id   "+dQuery+" group by category_code";
	//and work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-2011'))
	//System.out.println("hqry:"+hqry);
	Statement	stmt3=conn.createStatement();
	ResultSet rs3=stmt3.executeQuery(hqry);
	Hashtable h2=new Hashtable();
	while(rs3.next())
	{
		h2.put(rs3.getString(2),rs3.getString(1));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
	String nsqry="select sum(sanction_amount),category_code  from rws_work_admn_tbl w,rws_aap_selected_tbl b  where  w.work_id=b.work_id and admin_date>='01-Apr-"+yr+"'  "+dQuery+"  and work_cancel_dt is null  group by category_code order by 2  ";
	Statement	stmt4=conn.createStatement();
//System.out.println("nsqry:"+nsqry);
	ResultSet rs4=stmt4.executeQuery(nsqry);
	Hashtable h3=new Hashtable();
	while(rs4.next())
	{
		h3.put(rs4.getString(2),rs4.getString(1));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	String ssqry="SELECT sum(sanction_amount),category_code FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl b where w.work_id=b.work_id and w.ADMIN_DATE <'01-Apr-"+yr+" '  "+dQuery+"   group by category_code order by 2 ";
	//and work_cancel_dt is null  and w.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))
	Statement	stmt5=conn.createStatement();
	//System.out.println("ssqry:"+ssqry);
	ResultSet rs5=stmt5.executeQuery(ssqry);
	Hashtable h4=new Hashtable();
	while(rs5.next())
	{
		h4.put(rs5.getString(2),rs5.getString(1));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	 String expqry="select  sum(case when year<> '"+year+"-"+(""+(year+1)).substring(2,4)+"' then total else 0 end)||'@'||sum(case when year='"+year+"-"+(""+(year+1)).substring(2,4)+"' then total else 0 end),category_code  from rws_exp_view a, rws_work_admn_tbl  w,rws_aap_selected_tbl c where a.work_id=w.work_id and w.work_id=c.work_id and a.work_id=c.work_id   "+dQuery+"  group by category_code  order by 2 ";
	//and work_cancel_dt is null  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')
    Statement	stmt6=conn.createStatement();
	//System.out.println("expqry11:"+expqry);
	ResultSet rs6=stmt6.executeQuery(expqry);
	Hashtable h5=new Hashtable();
	while(rs6.next())
	{
		h5.put(rs6.getString(2),rs6.getString(1));
	}
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	String tsqry="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END),category_code FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl c WHERE W.WORK_ID=E.WORK_ID and W.WORK_ID=c.WORK_ID and c.WORK_ID=E.WORK_ID  "+dQuery+"  group by category_code order by 2 ";
	//and work_cancel_dt is null  and w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"') 
	Statement	stmt7=conn.createStatement();
	//System.out.println("tsqry:"+tsqry);
	ResultSet rs7=stmt7.executeQuery(tsqry);
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	
	String gqry="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),category_code  FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl c WHERE W.WORK_ID=G.WORK_ID and  W.WORK_ID=c.WORK_ID  and  c.WORK_ID=G.WORK_ID  "+dQuery+"   group by category_code order by 2  ";
	//and  work_cancel_dt is null   and  w.work_id not in( select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')
	Statement	stmt8=conn.createStatement();
	//System.out.println("gqry:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	 String wcqry="select sum(case when  date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' then 1 else 0 end),category_code from rws_work_completion_tbl wc, rws_work_admn_tbl w,rws_aap_selected_tbl c  where w.work_id=wc.work_id  and w.work_id=c.work_id and c.work_id=wc.work_id   "+dQuery+" group by category_code order by 2 ";
 	Statement	stmt9=conn.createStatement();
	//System.out.println("wcqry:"+wcqry);
	ResultSet rs9=stmt9.executeQuery(wcqry);
	Hashtable h8=new Hashtable();
	while(rs9.next())
	{
		h8.put(rs9.getString(2),rs9.getString(1));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();

	String chqry="select count(hab_code),category_code from rws_work_completion_tbl wc, rws_admn_hab_lnk_tbl dd,rws_aap_selected_tbl c,rws_work_admn_tbl w where dd.work_id=wc.work_id and dd.work_id=c.work_id and c.work_id=wc.work_id   "+dQuery+"  and dd.work_id=w.work_id and work_cancel_dt is null and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"'  group by category_code order by 2 ";
	
	Statement	stmt10=conn.createStatement();
	//System.out.println("chabqry:"+chqry);
	ResultSet rs10=stmt10.executeQuery(chqry);
	Hashtable h9=new Hashtable();
	while(rs10.next())
	{
		h9.put(rs10.getString(2),rs10.getString(1));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();
   String covqry="Select count(hab_code),category_code  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl w,rws_aap_selected_tbl c,rws_work_completion_tbl wc    where a.work_id =w.work_id and a.work_id =c.work_id and w.work_id =c.work_id     "+dQuery+" and work_cancel_dt is null and wc.work_id=a.work_id  and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"'   group by category_code order by 2 ";
  
   Statement	stmt11=conn.createStatement();
	//System.out.println("covqry:"+covqry);
	ResultSet rs11=stmt11.executeQuery(covqry);
	Hashtable h10=new Hashtable();
	while(rs11.next())
	{
		h10.put(rs11.getString(2),rs11.getString(1));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
    int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0;
    double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0;

	String qry="select category_code,category_name	 from rws_work_category_tbl order by 1";
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		String a1="0",a2="0";
		String swork=""+h.get(rs.getString(1));
		if(swork!=null && !swork.equals("") && !swork.equals("null")){}else{swork="0";}
		String nwork=""+h1.get(rs.getString(1));
	    if(nwork!=null && !nwork.equals("") && !nwork.equals("null")){}else{nwork="0";}
		String shabs=""+h2.get(rs.getString(1));
		if(shabs!=null && !shabs.equals("") && !shabs.equals("null")){}else{shabs="0";}
		String nsamt=""+h3.get(rs.getString(1));
		if(nsamt!=null && !nsamt.equals("") && !nsamt.equals("null")){}else{nsamt="0";}
		String ssamt=""+h4.get(rs.getString(1));
		if(ssamt!=null && !ssamt.equals("") && !ssamt.equals("null")){}else{ssamt="0";}
		String exp=""+h5.get(rs.getString(1));
        if(exp!=null && !exp.equals("") && !exp.equals("null")){
		String []aa=exp.split("@");a1=aa[0];a2=aa[1];}else{a1="0";a2="0";}
		String thabs=""+h6.get(rs.getString(1));
		if(thabs!=null && !thabs.equals("") && !thabs.equals("null")){}else{thabs="0";}
		String gdate=""+h7.get(rs.getString(1));
		if(gdate!=null && !gdate.equals("") && !gdate.equals("null")){}else{gdate="0";}
		String wcdate=""+h8.get(rs.getString(1));
		if(wcdate!=null && !wcdate.equals("") && !wcdate.equals("null")){}else{wcdate="0";}
		String chabs=""+h9.get(rs.getString(1));
		if(chabs!=null && !chabs.equals("") && !chabs.equals("null")){}else{chabs="0";}
		String covhabs=""+h10.get(rs.getString(1));
		if(covhabs!=null && !covhabs.equals("") && !covhabs.equals("null")){}else{covhabs="0";}
		
		%>
		<tr>
		<td class=rptvalue align=center><%=sno++%></td>
		<td class=btext><a href="rws_Aap_count_rpt.jsp?catCode=<%=rs.getString(1)%>&year=<%=yr%>"><%=rs.getString(2)%></td>
		<td class=rptvalue align="right"><%=swork%></td>
		<td class=rptvalue align="right"><%=nwork%></td>
		<td class=rptvalue align="right"><%=Integer.parseInt(swork)+Integer.parseInt(nwork)%></td>
		<td class=rptvalue align="right"><%=shabs%></td>
		<td class=rptvalue align="right"><%=ssamt%></td>
		<td class=rptvalue align="right"><%=nsamt%></td>
		<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(ssamt)+Double.parseDouble(nsamt))%></td>
		<td class=rptvalue align="right"><%=a1%></td>
		<td class=rptvalue align="right"><%=a2%></td>
		<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(a1)+Double.parseDouble(a2))%></td>
		<td class=rptvalue align="right"><%=thabs%></td>
		<td class=rptvalue align="right"><%=gdate%></td>
		<td class=rptvalue align="right"><%=wcdate%></td>
		<td class=rptvalue align="right"><%=chabs%></td>
		<td class=rptvalue align="right"><%=covhabs%></td>
		</tr>
		
	<%
		stot+=Integer.parseInt(swork);ntot+=Integer.parseInt(nwork);
		alltot+=Integer.parseInt(swork)+Integer.parseInt(nwork);
		hstot+=Integer.parseInt(shabs);
		sptot+=Double.parseDouble(ssamt);
		nptot+=Double.parseDouble(nsamt);
		totall+=Double.parseDouble(ssamt)+Double.parseDouble(nsamt);
        exprev+=Double.parseDouble(a1);
		expdur+=Double.parseDouble(a2);
		totexp+=Double.parseDouble(a1)+Double.parseDouble(a2);
		tstot+=Integer.parseInt(thabs);
		gtot+=Integer.parseInt(gdate);
		cwtot+=Integer.parseInt(wcdate);
		chtot+=Integer.parseInt(chabs);
		chctot+=Integer.parseInt(covhabs);		
		
	}
	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
	if(conn!=null) conn.close();
	%>
	 <tr class=btext>
	  	<td  Colspan=2  align="center"  class=btext>Total</td>
		<td  align="right" ><%=stot%></td>
		<td  align="right" ><%=ntot%></td>
		<td  align="right" ><%=alltot%></td>
		<td  align="right" ><%=hstot%></td>
		<td  align="right" ><%=ndf.format(sptot)%></td>
		<td  align="right" ><%=ndf.format(nptot)%></td>
		<td  align="right" ><%=ndf.format(totall)%></td>
		<td  align="right" ><%=ndf.format(exprev)%></td>
		<td  align="right" ><%=ndf.format(expdur)%></td>
		<td  align="right" ><%=ndf.format(totexp)%></td>
		<td  align="right" ><%=tstot%></td>
		<td  align="right" ><%=gtot%></td>
		<td  align="right" ><%=cwtot%></td>
		<td  align="right" ><%=chtot%></td>
		<td  align="right" ><%=chctot%></td>
		</tr>
</table>	
</html>