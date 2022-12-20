<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
String dist=request.getParameter("dist");
String dname=request.getParameter("dname");
String yr=request.getParameter("year");
int nextYear=Integer.parseInt(yr)+1;
String catCode=request.getParameter("catCode");
//System.out.println("catCode:"+catCode);
String catQry="",catName="";
  if(catCode.equals("1"))
	{
    	catQry = "and category_code = '1'";
		catName = " PROJECTS ";
	}
	else if(catCode.equals("2"))
	{
		catQry = "and category_code = '2'";
		catName = "NORMAL";
	}
	else if(catCode.equals("3"))
	{
		catQry = "and category_code = '3'";
		catName = "DISTRICT LEVEL";
	}
	 DecimalFormat ndf = new DecimalFormat("####.00");
%>
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
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="btext" colspan=17>District:&nbsp;&nbsp;<font color="red"><%=dname%>&nbsp;&nbsp;-&nbsp;<%=catName%> Works</font></td>	
	</tr>

	<tr align=center  align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext rowspan = 2>Mandal</td>
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
<% int cnt=1;
	 int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0;
	 double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0;
	 String sqry="SELECT count(distinct w.work_id),substr(lead_habitation,6,2)   FROM RWS_WORK_ADMN_TBL W,rws_aap_selected_tbl s  where  w.work_id=s.work_id  and  w.ADMIN_DATE <'01-Apr-"+yr+"'   "+catQry+"  and lead_habitation is not null  and substr(w.work_id,5,2)='"+dist+"'   group by substr(lead_habitation,6,2)  order by 2";
	 // and work_cancel_dt is null and w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))
	Statement	stmt2=conn.createStatement();      
	//System.out.println("sqry:"+sqry);
	ResultSet rs2=stmt2.executeQuery(sqry);
		Hashtable h=new Hashtable();
	while(rs2.next())
	{
		h.put(rs2.getString(2),rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	 String nqry="select count(distinct w.work_id),substr(lead_habitation,6,2)  FROM RWS_WORK_ADMN_TBL W ,rws_aap_selected_tbl s  where w.work_id=s.work_id   and  w.ADMIN_DATE >= '01-Apr-"+yr+"' and work_cancel_dt is null  "+catQry+"  and lead_habitation is not null  and substr(w.work_id,5,2)='"+dist+"' group by substr(lead_habitation,6,2)  order by 2";
	//System.out.println("nqry:"+nqry);
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(nqry);
	Hashtable h1=new Hashtable();
	while(rs1.next())
	{
		h1.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	
	String hqry="select count(distinct hab_code),substr(a.hab_code,6,2) from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b ,rws_aap_selected_tbl s  where a.work_id=b.work_id and b.work_id=s.work_id    "+catQry+"  and lead_habitation is not null  and substr(a.work_id,5,2)='"+dist+"'   group by substr(a.hab_code,6,2) order by 2 ";
	//and work_cancel_dt is null  and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')
	Statement	stmt3=conn.createStatement();
	//System.out.println("hqry:"+hqry);
	ResultSet rs3=stmt3.executeQuery(hqry);
	Hashtable h2=new Hashtable();
	while(rs3.next())
	{
		h2.put(rs3.getString(2),rs3.getString(1));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
/*String nsqry="select sum(sanction_amount),substr(hab_code,6,2)  from rws_work_admn_tbl w ,rws_admn_hab_lnk_tbl l,rws_aap_selected_tbl s  where s.work_id=w.work_id and w.work_id=l.work_id  and   admin_date>='01-Apr-"+yr+"'   "+catQry+"  and substr(w.work_id,5,2)='"+dist+"'   and work_cancel_dt is null  group by substr(hab_code,6,2) order by 2  ";*/
	String nsqry="SELECT distinct sanction_amount,substr(lead_habitation,6,2) ,w.work_id FROM RWS_WORK_ADMN_TBL W ,rws_aap_selected_tbl s  where w.work_id=s.work_id  and  w.ADMIN_DATE >='01-Apr-"+yr+"'   "+catQry+"  and lead_habitation is not null  and work_cancel_dt is null  and substr(w.work_id,5,2)='"+dist+"'  and work_cancel_dt is null order by 2 ";
	Statement	stmt4=conn.createStatement();
	//System.out.println("nsqry:"+nsqry);
	ResultSet rs4=stmt4.executeQuery(nsqry);
	Hashtable h3=new Hashtable();
	String curr1="",prev1="";
	double prevValue1=0.0;
	while(rs4.next())
	{
		curr1 = rs4.getString(2);
		if(!prev1.equals("") && !prev1.equals(curr1))
		{
			System.out.println("value1:"+prevValue1);
			System.out.println("code1:"+prev1);
			h3.put(prev1,prevValue1);
			prev1 = "";
			prevValue1 = 0.0;
		}
		prev1 = curr1;
		prevValue1 += rs4.getDouble(1);
	}
	h3.put(prev1,prevValue1);
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	String ssqry="SELECT sum(sanction_amount),substr(hab_code,6,2) FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl l,rws_aap_selected_tbl s  where w.work_id=s.work_id and w.work_id=l.work_id  and  w.ADMIN_DATE <'01-Apr-"+yr+" ' and work_cancel_dt is null   "+catQry+"  and substr(W.work_id,5,2)='"+dist+"'  and w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) group by substr(hab_code,6,2) order by 2 ";
	ssqry = "SELECT distinct sanction_amount,substr(lead_habitation,6,2) ,w.work_id FROM RWS_WORK_ADMN_TBL W ,rws_aap_selected_tbl s  where w.work_id=s.work_id  and  w.ADMIN_DATE <'01-Apr-"+yr+" '  "+catQry+"  and lead_habitation is not null  and substr(W.work_id,5,2)='"+dist+"' order by 2";
	//and work_cancel_dt is null   and w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr+"'))
	Statement	stmt5=conn.createStatement();
//System.out.println("ssqry:"+ssqry);
	ResultSet rs5=stmt5.executeQuery(ssqry);
	Hashtable h4=new Hashtable();
	String curr="",prev="";
	double prevValue=0.0;
	while(rs5.next())
	{
		curr = rs5.getString(2);
			//System.out.println("curr:"+curr);
			//	System.out.println("prev:"+prev);
		if(!prev.equals("") && !prev.equals(curr))
		{
		
			//System.out.println("in prevValue:"+prevValue);
			//System.out.println(" in prev:"+prev);
			h4.put(prev,prevValue);
			prev = "";
			prevValue = 0.0;
		}
		prev = curr;
		prevValue += rs5.getDouble(1);
		//System.out.println("out prevValue:"+prevValue);
			//System.out.println(" out prev:"+prev);
		
	}
	h4.put(prev,prevValue);
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	 String expqry="select  sum(case when year<> '"+yr+"-"+(""+(nextYear)).substring(2,4)+"' then total else 0 end),substr(lead_habitation,6,2)   from rws_exp_view a, rws_work_admn_tbl  b ,rws_aap_selected_tbl s  where b.work_id=s.work_id  and  a.work_id=b.work_id      "+catQry+"  and lead_habitation is not null  and substr(b.work_id,5,2)='"+dist+"'  group by substr(lead_habitation,6,2)  order by 2 ";
    Statement stmt6=conn.createStatement();
	//and  work_cancel_dt is null  and a.work_id not in (select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"')
	//System.out.println("expqry:"+expqry);
	ResultSet rs6=stmt6.executeQuery(expqry);
	Hashtable h5=new Hashtable();
	String pcurr="",pprev="";
	double pprevValue=0.0;
	
	while(rs6.next())
	{
		
			pcurr = rs6.getString(2);
			//System.out.println("curr:"+pcurr);
			//System.out.println("prev:"+pprev);
		if(!pprev.equals("") && !pprev.equals(pcurr))
		{
		
			//System.out.println("in prevValue:"+pprevValue);
			//System.out.println(" in prev:"+pprev);
			h5.put(pprev,pprevValue);
			pprev = "";
			pprevValue = 0.0;
		}
		pprev = pcurr;
		pprevValue += rs6.getDouble(1);
		//System.out.println("out prevValuehhhhhhhhhhhhh:"+pprevValue);
			//System.out.println(" out prevhhhhhhhhhhhhhhhh:"+pprev);
		
	}
	h5.put(pprev,pprevValue);
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
	 String expqry11="select  sum(case when year= '"+yr+"-"+(""+(nextYear)).substring(2,4)+"' then total else 0 end),substr(lead_habitation,6,2)   from rws_exp_view a, rws_work_admn_tbl  b ,rws_aap_selected_tbl s  where b.work_id=s.work_id  and  a.work_id=b.work_id    "+catQry+"  and lead_habitation is not null  and substr(b.work_id,5,2)='"+dist+"'   group by substr(lead_habitation,6,2)   order by 2 ";
	 //and a.work_id not in (select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"')  and work_cancel_dt is null
    Statement stmt12=conn.createStatement();
	//System.out.println("expqry:"+expqry11);
	ResultSet rs12=stmt12.executeQuery(expqry11);
	Hashtable h11=new Hashtable();
	String pcurr11="",pprev11="";
	double pprevValue11=0.0;
	
	while(rs12.next())
	{
		
			pcurr11 = rs12.getString(2);
			//System.out.println("curr:11"+pcurr11);
			//System.out.println("prev11:"+pprev11);
		if(!pprev11.equals("") && !pprev11.equals(pcurr11))
		{
			h11.put(pprev11,pprevValue11);
			pprev11 = "";
			pprevValue11 = 0.0;
		}
		pprev11 = pcurr11;
		pprevValue11 += rs12.getDouble(1);
		
		
	}
	h11.put(pprev11,pprevValue11);
    if(rs12!=null)rs12.close();
	if(stmt12!=null)stmt12.close();
   String tsqry="SELECT COUNT(DISTINCT W.WORK_ID),substr(lead_habitation,6,2)  FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL w,rws_aap_selected_tbl s where w.work_id=s.work_id and E.work_id=s.work_id and   w.WORK_ID=E.WORK_ID  "+catQry+"  and substr(w.work_id,5,2)='"+dist+"'  and lead_habitation is not null   AND E.TS_NO IS NOT NULL group by substr(lead_habitation,6,2)  order by 2 ";
	Statement	stmt7=conn.createStatement();
	//and work_cancel_dt is null   and w.work_id not in( select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"')
	//System.out.println("tsqry:"+tsqry);
	ResultSet rs7=stmt7.executeQuery(tsqry);
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	String gqry="SELECT COUNT(DISTINCT W.WORK_ID),substr(lead_habitation,6,2)   FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W ,rws_aap_selected_tbl s where  w.work_id=s.work_id   and  W.WORK_ID=G.WORK_ID   "+catQry+"  and substr(w.work_id,5,2)='"+dist+"'  and lead_habitation is not null    AND GROUNDING_DATE IS NOT NULL group by substr(lead_habitation,6,2)  order by 2  "; 
	//and  w.work_id not in( select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"') and work_cancel_dt is null 
	Statement	stmt8=conn.createStatement();
	//System.out.println("gqry111:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	String wcqry="select count(distinct w.work_id),substr(lead_habitation,6,2) from rws_work_completion_tbl wc, rws_work_admn_tbl w , rws_aap_selected_tbl s where w.work_id=s.work_id  and  w.work_id=wc.work_id    "+catQry+"  and substr(w.work_id,5,2)='"+dist+"' and lead_habitation is not null  and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' group by substr(lead_habitation,6,2) order by 2 ";
	//and work_cancel_dt is null  date_of_completion>='01-Apr-"+yr+"' and 
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
	String chqry="select count(w.no_of_habs),substr(hab_code,6,2) from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_admn_hab_lnk_tbl l,rws_aap_selected_tbl s where w.work_id=l.work_id and w.work_id=s.work_id  and  w.work_id=wc.work_id    "+catQry+"   and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' and substr(w.work_id,5,2)='"+dist+"' group by substr(hab_code,6,2) order by 2 ";
	Statement	stmt10=conn.createStatement();
	//and date_of_completion>='01-Apr-"+yr+"'  and work_cancel_dt is null
	//System.out.println("chabqry:"+chqry);
	ResultSet rs10=stmt10.executeQuery(chqry);
	Hashtable h9=new Hashtable();
	while(rs10.next())
	{
		h9.put(rs10.getString(2),rs10.getString(1));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();
	String covqry="Select count(distinct a.hab_code),substr(a.hab_code,6,2)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b ,rws_admn_hab_lnk_tbl l,rws_aap_selected_tbl s  where a.work_id=l.work_id and a.work_id=s.work_id  and  a.work_id =b.work_id  and b.work_id=l.work_id    "+catQry+"   and substr(a.work_id,5,2)='"+dist+"' and  a.work_id in (select work_id from  rws_work_completion_tbl  where date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' ) group by substr(a.hab_code,6,2) order by 2 ";
   //date_of_completion>='01-Apr-"+yr+"'  and  and work_cancel_dt is null
   Statement stmt11=conn.createStatement();
	//System.out.println("covqry:"+covqry);
	ResultSet rs11=stmt11.executeQuery(covqry);
	Hashtable h10=new Hashtable();
	while(rs11.next())
	{
		h10.put(rs11.getString(2),rs11.getString(1));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();

String qry="Select  mcode,mname  from rws_mandal_tbl where dcode='"+dist+"' order by 2" ;
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
        if(exp!=null && !exp.equals("") && !exp.equals("null")){}else{exp="0";}
		String exp11=""+h11.get(rs.getString(1));
        if(exp11!=null && !exp11.equals("") && !exp11.equals("null")){}else{exp11="0";}
		//String []aa=exp.split("@");a1=aa[0];a2=aa[1];}else{a1="0";a2="0";}
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
		if(exp==null || exp.equals("")) exp="0";
		if(exp11==null || exp11.equals("")) exp11="0";
		%>
    <tr>
		<td class=rptvalue align=center><%=cnt++%></td>
		<td class=rptvalue title=Click nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue align="right"><%=swork%></td>
		<td class=rptvalue align="right"><%=nwork%></td>
		<td class=rptvalue align="right"><%=Integer.parseInt(swork)+Integer.parseInt(nwork)%></td>
		<td class=rptvalue align="right"><%=shabs%></td>
		<td class=rptvalue align="right"><%=Math.round(Double.parseDouble(""+ssamt))%></td>
		<td class=rptvalue align="right"><%=nsamt%></td>
		<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(ssamt)+Double.parseDouble(nsamt))%></td>
		<td class=rptvalue align="right"><%=exp%></td>
		<td class=rptvalue align="right"><%=exp11%></td>
		<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(exp)+Double.parseDouble(exp11))%></td>
		<td class=rptvalue align="right"><%=thabs%></td>
		<td class=rptvalue align="right"><%=gdate%></td>
		<td class=rptvalue align="right"><%=wcdate%></td>
		<td class=rptvalue align="right"><%=chabs%></td>
		<td class=rptvalue align="right"><%=covhabs%></td>
		</tr>
    </tr>
    <%
		stot+=Integer.parseInt(swork);ntot+=Integer.parseInt(nwork);
		alltot+=Integer.parseInt(swork)+Integer.parseInt(nwork);
		hstot+=Integer.parseInt(shabs);
		sptot+=Double.parseDouble(ssamt);
		nptot+=Double.parseDouble(nsamt);
		totall+=Double.parseDouble(ssamt)+Double.parseDouble(nsamt);
        exprev+=Double.parseDouble(exp);
		expdur+=Double.parseDouble(exp11);
		totexp+=Double.parseDouble(exp)+Double.parseDouble(exp11);
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