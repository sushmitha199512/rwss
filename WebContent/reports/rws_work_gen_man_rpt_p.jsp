<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%
	String programe="";
	double aas=0;
	//System.out.println("programe11::"+programe);
	String scheme="";
	DecimalFormat ndf = new DecimalFormat("####.00");
	String catCode=request.getParameter("catCode");
	String planNonplan=request.getParameter("planNonplan");
	//System.out..println(catCode+":"+planNonplan);
	String dist=request.getParameter("district");
	String fnyear=request.getParameter("finyear");
	String yr=fnyear.substring(0,4);
	String planName = "PLAN & NON PLAN";
	String planQry="",catQry="",catName="";
	String prgCode="",prQry="";
  if(planNonplan.equals("1"))
	{
    	planQry = "and plan_code = '1'";
		planName = " PLAN ";
	}
	else if(planNonplan.equals("2"))
	{
		planQry = "and plan_code = '2'";
		planName = " NON PLAN ";
	}
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
	programe=request.getParameter("programes");
	//System.out.println("programe22::"+programe);
	scheme=request.getParameter("scheme");
	//System.out.println("scheme22::"+scheme);
	prgCode=request.getParameter("prgCode");
	String prgName="";
if(prgCode!=null && !prgCode.equals(""))
{
  prQry=" and programme_code='"+prgCode+"' ";
  
}
 if(prgName!=null && !prgName.equals(""))
{prgName=request.getParameter("prgName");}
	String dname=request.getParameter("dname");
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
	<caption align="right" class="staticLabel"> <b>Amount in Rs. lakhs</b></caption>

	</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
    <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=22>General Abstract Report for the Financial Year(<%=session.getAttribute("financialyr")%>)</td>	
	</tr>
		<tr align="center" > <td class=btext colspan=17>District :All <font color="red" face="verdana" size="2"> <%=planName%></font> Works</td> </td>
		<tr align=center  align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td colspan=3 class=btext align="center">No.of Works</td>
		<td rowspan=2 colspan=1 class=btext align="center">Habs Sanctioned</td>
		<td colspan=3 class=btext align="center">Est.Cost</td>
		<td rowspan=2 colspan=1 class=btext align="center">Exp. Upto Last Fin. Year</td>
		<td   rowspan=2 class=btext align="center">Bal Est.Cost as on 1.4.11(9-10)</td>
		<td  colspan=2 class=btext align="center">Expenditure</td>	
		<td rowspan=2 colspan=1 class=btext align="center">% of Exp. against Bal Est.Cost(13/11)</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Total Exp.</td>	
		<td rowspan=2 colspan=1 class=btext align="center">Technically Sanctioned</td>	
		<td rowspan=2 colspan=1 class=btext align="center">No.of.Works Grounded</td>
		<td rowspan=2 colspan=1 class=btext align="center">No.of.Works Completed</td>
		<td rowspan=2 colspan=1 class=btext align="center">No. of Habs Covered upto previous year</td>
		<td rowspan=2 colspan=1 class=btext align="center">Balance as on 1.4.11(6-19)</td>
		<td rowspan=2 colspan=1 class=btext align="center">Covered during the year</td>
		<td rowspan=2 colspan=1 class=btext align="center">% of coverage against balance Habs(21/20)</td>
		</tr>
		<tr>
		<td rowspan=1 colspan=1 class=btext align="center">Spill</td>	
		<td rowspan=1 colspan=1 class=btext align="center">New</td>	
		<td rowspan=1 colspan=1 class=btext align="center">Total</td>	
		<td rowspan=1 colspan=1 class=btext align="center">Spill</td>
		<td rowspan=1 colspan=1 class=btext align="center">New</td>		
		<td rowspan=1 colspan=1 class=btext align="center">Total</td>
		<td rowspan=1 colspan=1 class=btext align="center">Exp.upto Previous month</td>
		<td rowspan=1 colspan=1 class=btext align="center">Exp. During The Year</td>
		</tr>
	<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext >4</td><td align="center" class=btext >5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center" class=btext>8</td><td align="center" class=btext>9</td><td align="center" class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext>14</td><td align="center" class=btext>15</td><td align="center" class=btext>16</td><td align="center" class=btext>17</td><td align="center" class=btext>18</td><td align="center" class=btext>19</td><td align="center" class=btext>20</td><td align="center" class=btext>21</td><td align="center" class=btext>22</td></tr>
<% int cnt=1;
	
	 int stot=0,ntot=0,alltot=0,hstot=0,tstot=0,gtot=0,cwtot=0,chtot=0,chctot=0,bhabs=0;
	double sptot=0.0,nptot=0.0,totall=0.0,exprev=0.0,expdur=0.0,totexp=0.0,epenmtot=0.0,balpcost=0.0,balecost=0.0,expenm=0.0,htot=0.0;
	 String nqry="select count(distinct w.work_id),substr(lead_habitation,6,2)  FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl l where w.work_id=l.work_id  and lead_habitation is not null  and w.ADMIN_DATE >= '01-Apr-"+yr+"' and work_cancel_dt is null "+planQry+" "+catQry+"  and w.programme_code in("+programe+")    and substr(w.work_id,5,2)='"+dist+"' group by substr(lead_habitation,6,2)  order by 2";
	//System.out.println("nqry-mandal:"+nqry);
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(nqry);
	Hashtable h=new Hashtable();
	while(rs1.next())
	{
		h.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();
	String sqry="SELECT count(distinct w.work_id),substr(lead_habitation,6,2)   FROM RWS_WORK_ADMN_TBL W ,rws_admn_hab_lnk_tbl l  where w.work_id=l.work_id  and  w.ADMIN_DATE <'01-Apr-"+yr+"'  and work_cancel_dt is null "+planQry+" "+catQry+"and substr(w.work_id,5,2)='"+dist+"' and w.programme_code in("+programe+") and lead_habitation is not null   and w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) group by substr(lead_habitation,6,2)  order by 2";
	Statement	stmt2=conn.createStatement();      
	//System.out.println("sqry-mandal:"+sqry);
	ResultSet rs2=stmt2.executeQuery(sqry);
		Hashtable h1=new Hashtable();
	while(rs2.next())
	{
		h1.put(rs2.getString(2),rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	String hqry="select count(distinct hab_code),substr(hab_code,6,2)  from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and work_cancel_dt is null "+planQry+" "+catQry+"  and b.programme_code in("+programe+")    and substr(a.work_id,5,2)='"+dist+"'  and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"') group by substr(hab_code,6,2)  order by 2 ";
	Statement	stmt3=conn.createStatement();
	//System.out.println("hqry-mandal:"+hqry);
	ResultSet rs3=stmt3.executeQuery(hqry);
	Hashtable h2=new Hashtable();
	while(rs3.next())
	{
		h2.put(rs3.getString(2),rs3.getString(1));
	}
	if(rs3!=null)rs3.close();
	if(stmt3!=null)stmt3.close();
	String nsqry="select sum(sanction_amount),substr(lead_habitation,6,2)   from rws_work_admn_tbl w  where   w.admin_date>='01-Apr-"+yr+"'  "+planQry+" "+catQry+" and w.programme_code in("+programe+") and lead_habitation is not null    and substr(w.work_id,5,2)='"+dist+"'   and work_cancel_dt is null  group by substr(lead_habitation,6,2)  order by 2  ";
	Statement	stmt4=conn.createStatement();
	//System.out.println("nsqry-mandal:"+nsqry);
	ResultSet rs4=stmt4.executeQuery(nsqry);
	Hashtable h3=new Hashtable();
	String curr1="",prev1="";
	double prevValue1=0.0;
	while(rs4.next())
	{
		curr1 = rs4.getString(2);
		if(!prev1.equals("") && !prev1.equals(curr1))
		{
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
	String ssqry="SELECT sum(sanction_amount),substr(lead_habitation,6,2)  FROM RWS_WORK_ADMN_TBL W where  w.ADMIN_DATE <'01-Apr-"+yr+" ' and work_cancel_dt is null  "+planQry+" "+catQry+"  and substr(W.work_id,5,2)='"+dist+"'  and w.programme_code in("+programe+")  and lead_habitation is not null  and  w.work_id not in (select work_id from rws_work_completion_tbl where  (DATE_OF_COMPLETION < '01-Apr-"+yr+"')) group by substr(lead_habitation,6,2)  order by 2 ";
	Statement	stmt5=conn.createStatement();
	//System.out.println("ssqry-mandal:"+ssqry);
	ResultSet rs5=stmt5.executeQuery(ssqry);
	Hashtable h4=new Hashtable();
	String curr="",prev="";
	double prevValue=0.0;
	while(rs5.next())
	{
		curr = rs5.getString(2);
		if(!prev.equals("") && !prev.equals(curr))
		{
			h4.put(prev,prevValue);
			prev = "";
			prevValue = 0.0;
		}
		prev = curr;
		prevValue += rs5.getDouble(1);
		
	}
	h4.put(prev,prevValue);
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
	 String expqry="select  sum(case when year<> '"+fnyear+"' then total else 0 end)||'@'||sum(case when year='"+fnyear+"' then total else 0 end),substr(lead_habitation,6,2)   from rws_exp_view a, rws_work_admn_tbl  b  where a.work_id=b.work_id  and work_cancel_dt is null  "+planQry+" "+catQry+"  and substr(b.work_id,5,2)='"+dist+"' and lead_habitation is not null  and b.programme_code in("+programe+")    and a.work_id not in (select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"')  group by substr(lead_habitation,6,2)   order by 2 ";
    Statement stmt6=conn.createStatement();
	//System.out.println("expqry-mandal:"+expqry);
	ResultSet rs6=stmt6.executeQuery(expqry);
	Hashtable h5=new Hashtable();
	while(rs6.next())
	{
		h5.put(rs6.getString(2),rs6.getString(1));
	}
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
   String tsqry="SELECT distinct SUM(CASE WHEN E.TS_NO IS NOT NULL THEN 1 ELSE 0 END),substr(lead_habitation,6,2)  FROM RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL w where   w.WORK_ID=E.WORK_ID and work_cancel_dt is null  "+planQry+" "+catQry+" "+prQry+" and w.programme_code in("+programe+") and lead_habitation is not null     and substr(w.work_id,5,2)='"+dist+"'  and w.work_id not in( select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"') group by substr(lead_habitation,6,2)  order by 2 ";
	Statement	stmt7=conn.createStatement();
	//System.out.println("tsqry-mandal:"+tsqry);
	ResultSet rs7=stmt7.executeQuery(tsqry);
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	String gqry="SELECT distinct SUM(CASE WHEN G.GROUNDING_DATE IS NOT NULL THEN 1 ELSE 0 END),substr(lead_habitation,6,2)   FROM RWS_WORK_COMMENCEMENT_TBL G,RWS_WORK_ADMN_TBL W  where   W.WORK_ID=G.WORK_ID and work_cancel_dt is null  "+planQry+" "+catQry+" "+prQry+" and w.programme_code in("+programe+") and lead_habitation is not null      and substr(w.work_id,5,2)='"+dist+"'   and  w.work_id not in( select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"') group by substr(lead_habitation,6,2)  order by 2  "; 
	Statement	stmt8=conn.createStatement();
//System.out.println("gqry111-mandal:"+gqry);
	ResultSet rs8=stmt8.executeQuery(gqry);
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	String wcqry="select sum(case when date_of_completion>='01-Apr-"+yr+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' then 1 else 0 end),substr(lead_habitation,6,2)  from rws_work_completion_tbl wc, rws_work_admn_tbl w  where   lead_habitation is not null and   w.work_id=wc.work_id  and work_cancel_dt is null  "+planQry+" "+catQry+" "+prQry+" and substr(w.work_id,5,2)='"+dist+"' and w.programme_code in("+programe+")    group by substr(lead_habitation,6,2)  order by 2 ";
 	Statement	stmt9=conn.createStatement();
	//System.out.println("wcqry-mandal:"+wcqry);
	ResultSet rs9=stmt9.executeQuery(wcqry);
	Hashtable h8=new Hashtable();
	while(rs9.next())
	{
		h8.put(rs9.getString(2),rs9.getString(1));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	String chqry="select sum(w.no_of_habs),substr(hab_code,6,2) from rws_work_completion_tbl wc, rws_work_admn_tbl w ,rws_admn_hab_lnk_tbl l where w.work_id=l.work_id  and  w.work_id=wc.work_id and work_cancel_dt is null  "+planQry+" "+catQry+" "+prQry+"  and date_of_completion>='01-Apr-"+yr+"' and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' and substr(w.work_id,5,2)='"+dist+"' and w.programme_code in("+programe+")    group by substr(hab_code,6,2) order by 2 ";
 chqry="Select count(hab_code),substr(lead_habitation,6,2)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b where a.work_id =b.work_id and work_cancel_dt is null  "+planQry+" and lead_habitation is not null  "+catQry+"  and b.programme_code in("+programe+")   and substr(b.work_id,5,2)='"+dist+"' and  a.work_id not in (select work_id from  rws_work_completion_tbl where date_of_completion<'01-Apr-"+yr+"' )  group by  substr(lead_habitation,6,2)  order by 2 ";
	Statement	stmt10=conn.createStatement();
	//System.out.println("chabqry-mandal:"+chqry);
	ResultSet rs10=stmt10.executeQuery(chqry);
	Hashtable h9=new Hashtable();
	while(rs10.next())
	{
		h9.put(rs10.getString(2),rs10.getString(1));
	}
	if(rs10!=null)rs10.close();
	if(stmt10!=null)stmt10.close();
	String covqry="Select count(hab_code),substr(lead_habitation,6,2)  from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b   where   a.work_id =b.work_id  and work_cancel_dt is null  "+planQry+" "+catQry+" "+prQry+" and b.programme_code in("+programe+")    and substr(a.work_id,5,2)='"+dist+"' and lead_habitation is not null  and  a.work_id in (select work_id from  rws_work_completion_tbl  where date_of_completion>='01-Apr-"+yr+"'  and date_of_completion<'01-Apr-"+(Integer.parseInt(yr)+1)+"' ) group by substr(lead_habitation,6,2) order by 2 ";
   Statement stmt11=conn.createStatement();
	//System.out.println("covqry-mandal:"+covqry);
	ResultSet rs11=stmt11.executeQuery(covqry);
	Hashtable h10=new Hashtable();
	while(rs11.next())
	{
		h10.put(rs11.getString(2),rs11.getString(1));
	}
	if(rs11!=null)rs11.close();
	if(stmt11!=null)stmt11.close();
     String expmonqry1="select  sum(case when year = '"+fnyear+"' then total else 0 end) ,substr(l.hab_code,6,2)  from rws_exp_view a, rws_work_admn_tbl  b ,rws_admn_hab_lnk_tbl l  where b.work_id=l.work_id  and  a.work_id=b.work_id and a.work_id=l.work_id and work_cancel_dt is null  "+planQry+" "+catQry+"  and substr(b.work_id,5,2)='"+dist+"' and to_char(admin_date,'MON') <TO_CHAR(SYSDATE,'MON') and b.programme_code in("+programe+")   and  a.work_id not in (select work_id from rws_work_completion_tbl where  date_of_completion <'01-Apr-"+yr+"')  group by substr(l.hab_code,6,2)  order by 2  ";
			Statement	stmt12=conn.createStatement();
			//System.out.println("expmonqry1-mandal:"+expmonqry1);
			ResultSet rs12=stmt12.executeQuery(expmonqry1);
			Hashtable h11=new Hashtable();
			while(rs12.next())
			{
		    	h11.put(rs12.getString(2),rs12.getString(1));
			}
			if(rs12!=null)rs12.close();
			if(stmt12!=null)stmt12.close();
String qry="Select  mcode,mname  from rws_mandal_tbl where dcode='"+dist+"' order by 2" ;
stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		String a1="0",a2="0";
		String nwork=""+h.get(rs.getString(1));
	    if(nwork!=null && !nwork.equals("") && !nwork.equals("null")){}else{nwork="0";}
		String swork=""+h1.get(rs.getString(1));
		if(swork!=null && !swork.equals("") && !swork.equals("null")){}else{swork="0";}
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
		if(a1==null || a1.equals("")) a1="0";
		if(a2==null || a2.equals("")) a2="0";
			String expmon1=""+h11.get(rs.getString(1));
		       if(expmon1!=null && !expmon1.equals("") && !expmon1.equals("null")){}else{expmon1="0";}
		%>
    <tr>
		<td class=rptvalue align=center><%=cnt++%></td>
		<td class=rptvalue title=Click nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue align="right"><%=swork%></td>
		<td class=rptvalue align="right"><%=nwork%></td>
		<td class=rptvalue align="right"><%=Integer.parseInt(swork)+Integer.parseInt(nwork)%></td>
		<td class=rptvalue align="right"><%=shabs%></td>
		<td class=rptvalue align="right"><%=ssamt%></td>
		<td class=rptvalue align="right"><%=nsamt%></td>
		<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(ssamt)+Double.parseDouble(nsamt))%></td>
		<td class=rptvalue align="right"><%=a1%></td>
		<td class=rptvalue align="right"><%=ndf.format((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1))%></td>
				<td class=rptvalue align="right"><%=expmon1%></td>
				<td class=rptvalue align="right"><%=a2%></td>
				<%if(((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1))<=0)
				{%><td class=rptvalue align="right">0</td><%}else{%><td class=rptvalue align="right"><%=ndf.format((Double.parseDouble(a2)/((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1)))*100)%></td>
				<%}%>
				<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(a1)+Double.parseDouble(a2))%></td>
				<td class=rptvalue align="right"><%=thabs%></td>
				<td class=rptvalue align="right"><%=gdate%></td>
				<td class=rptvalue align="right"><%=wcdate%></td>
				<td class=rptvalue align="right"><%=chabs%></td>
				<td class=rptvalue align="right"><%=Integer.parseInt(shabs)-Integer.parseInt(chabs)%></td>
				<td class=rptvalue align="right"><%=covhabs%></td>
				<%if(Integer.parseInt(chabs)==0)
			{aas=0;%><td class=rptvalue align="right">0</td><%}else{
			double aas1=Integer.parseInt(shabs)-Integer.parseInt(chabs);
			if(aas1==0)
			{
				aas=0;
			}
			else
			{

			aas=(Double.parseDouble(covhabs)/aas1)*100;
		       //System.out.println("aaa::"+aas);
			}
			%><td class=rptvalue align="right"><%=ndf.format(aas)%></td>
		<%}%>

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
		balecost+=Double.parseDouble(ssamt)+Double.parseDouble(nsamt)-Double.parseDouble(a1);
		tstot+=Integer.parseInt(thabs);
		gtot+=Integer.parseInt(gdate);
		cwtot+=Integer.parseInt(wcdate);
		chtot+=Integer.parseInt(chabs);
		chctot+=Integer.parseInt(covhabs);
		epenmtot+=Double.parseDouble(expmon1);
					if(((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1))<=0)
					{
					   balpcost+=0;
					}
					else   
					{
					   balpcost+=((Double.parseDouble(a2)/((Double.parseDouble(ssamt)+Double.parseDouble(nsamt))-Double.parseDouble(a1)))*100);
					}
					bhabs+=Integer.parseInt(shabs)-Integer.parseInt(chabs);

	     //htot+=aas;
		//System.out.println("mandal::"+htot);
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
		<td  align="right" ><%=ndf.format(balecost)%></td>
		<td  align="right" ><%=ndf.format(epenmtot)%></td>
		<td  align="right" ><%=ndf.format(expdur)%></td>
		<td  align="right" ><%=ndf.format(balpcost)%></td>
		<td  align="right" ><%=ndf.format(totexp)%></td>
		<td  align="right" ><%=tstot%></td>
		<td  align="right" ><%=gtot%></td>
		<td  align="right" ><%=cwtot%></td>
		<td  align="right" ><%=chtot%></td>
		<td  align="right" ><%=bhabs%></td>
		<td  align="right" ><%=chctot%></td>
		<%if(chctot==0 || bhabs==0){%>
		<td  align="right" >0</td>
		<%}else{%>
		<td  align="right" ><%=ndf.format((Double.parseDouble(""+chctot)/Double.parseDouble(""+bhabs))*100)%></td>
		<%}%>
		</tr>
		
</table>
<p> <font color=red size="4" align="left">NOTE:  Data is displayed based on Lead Habitation if Lead habitation is not selected for any work  data may be Incorrect</font></p>
</html>