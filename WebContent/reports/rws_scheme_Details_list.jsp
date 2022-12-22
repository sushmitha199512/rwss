<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%
int shabss=0,chabss=0,ecost=0,rcost=0;
    double  eupy=0.0,bal=0.0,epm=0.0,edye=0.0,be=0.0,value=0.0;
String dcode=request.getParameter("district");
if(dcode!=null){
session.setAttribute("dcode",dcode);
}
String atype=request.getParameter("scheme");
if(atype!=null){
session.setAttribute("atype",atype);
}
String dname=request.getParameter("dname");
if(dname!=null){
session.setAttribute("dname",dname);
}
String pname=request.getParameter("pname");
if(pname!=null){
session.setAttribute("pname",pname);
}

String sname=request.getParameter("sname");
if(sname!=null){
session.setAttribute("sname",sname);
}
String category=request.getParameter("category");
if(category!=null){
session.setAttribute("category",category);
}
//System.out.println("d:::"+dcode);
//System.out.println("aSSET::"+atype);
//System.out.println("ddname::"+dname);
//System.out.println("category::"+category);
//System.out.println("pnamesssssssssss::"+pname);

String aname1="";
if(atype.equals("01"))
{
	aname1="PWS";
}
else if(atype.equals("03"))
{
	aname1="CPWS";
}
else
{
	aname1="MPWS";
}
//System.out.println("nnn::"+aname1);
int sno=1;
String date=""+session.getAttribute("serversysdate");
String yr=date.substring(6,10);
String nextyr=""+(Integer.parseInt(yr)+1);
String nyr=nextyr.substring(2,4);
//System.out.println("year::"+yr);
//System.out.println("year::"+nyr);
//System.out.println("year::"+nextyr);
//System.out.println("date::"+date);

	DecimalFormat ndf = new DecimalFormat("####.00");
	String[] programes=request.getParameterValues("program");
	String programe="";
	for(int i=0;i<programes.length;i++)
	{
	   programe += programes[i]+",";
	}
	//System.out.println("programe::"+programe);
	programe = programe.substring(0,programe.length()-1);
	//System.out.println("programe::"+programe);
	if(programe!=null)
	{
	 session.setAttribute("programe",programe);
	}

//System.out.println("pppppppp::>>>>>>>>"+pnames);
%>
<body>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<form>
<table width="80%">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_scheme_Details_list_xls.jsp" target="_new">Excel </a>
</tr>
</table>
<table width=100% border=0>
<tr>
<td><B><font class="btext">Progress Report of<font color="rptValue"> <%=sname%></font> Schemes  </B></td></tr>
<tr><td class="btext" align="left" >District: <font color="rptValue"><%=dname%></font></td></tr>
<tr><td style="width:960px"><B><font class="btext">Programmes:<font color="rptValue"><%=pname%></font>  </B></td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right"  class=btext>
					(Rs. In Lakhs)	</td>
				</tr>
			</table>
		</caption>
	<tr align=center>
	<td class=btext >Sl.No</td>
	<td class=btext>Division</td>
	<td class=btext>Work Id</td>
	<td class=btext  > Work Name </td>
	<td class=btext  >Program</td>
	<td class=btext >Admn. San. No.</td>
	<td class=btext  >Admn. San. Date</td>
	<td class=btext  >Tech. San. No.</td>
	<td class=btext  >Tech. San. Date</td>
	<td class=btext >Est.Cost/ Rev. Cost</td>
<td class=btext  >Exp. upto previous year</td>
<td class=btext >Bal Est.Cost as on 1.4.11</td>
<td class=btext >Exp. during the month</td>
<td class=btext  >Exp. during the year</td>
<td class=btext  >% of Exp. against Bal Est.Cost(14/12)</td>
<td class=btext  >Date of Grounding</td>
<!-- <td class=btext  >Physical Stage
(Major Component wise % of Achmt.)</td> -->
<td class=btext  >Date of Completion</td>
<td class=btext  >No. of Habs Sanctioned</td>
<td class=btext  >No. of Habs covered</td>
	</tr>
	
	<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td><td align="center" class=btext>8</td><td align="center" class=btext>9</td><td align="center" class=btext>10</td><td align="center" class=btext>11</td><td align="center" class=btext>12</td><td align="center" class=btext>13</td><td align="center" class=btext>14</td><td align="center" class=btext>15</td><td align="center" class=btext>16</td><td align="center" class=btext>17</td><td align="center" class=btext>18</td><td align="center" class=btext>19</td></tr>

	<%int cnt=1;
		
	String epyr="select  sum(nvl((case when year<> '"+yr+"-"+nyr+"' then total else 0 end),0)) ,b.work_id  from rws_exp_view a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and plan_code='1' and category_code='"+category+"' and  substr(b.work_id,5,2)='"+dcode+"' and b.programme_code in ("+programe+")  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by b.work_id ";
	//System.out.println("epyr:"+epyr);
	Statement	stmt1=conn.createStatement();
	ResultSet rs1=stmt1.executeQuery(epyr);
	Hashtable h=new Hashtable();
	while(rs1.next())
	{
			h.put(rs1.getString(2),rs1.getString(1));
	}
	if(rs1!=null)rs1.close();
	if(stmt1!=null)stmt1.close();

	String expm="select  sum(case when year='"+yr+"-"+nyr+"' then total else 0 end) ,b.work_id  from rws_exp_view a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"' and plan_code='1' and b.programme_code in ("+programe+") and to_char(admin_date,'MON') = TO_CHAR(SYSDATE,'MON')and  substr(b.work_id,5,2)='"+dcode+"'  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by b.work_id ";
		//System.out.println("qqqqqqqq"+expm);
	Statement	stmt2=conn.createStatement();
	//System.out.println("expm:"+expm);
	ResultSet rs2=stmt2.executeQuery(expm);
		Hashtable h1=new Hashtable();
	while(rs2.next())
	{
		h1.put(rs2.getString(2),rs2.getString(1));
	}
	if(rs2!=null)rs2.close();
	if(stmt2!=null)stmt2.close();
	
	String expy="select  sum(case when year='"+yr+"-"+nyr+"' then total else 0 end) ,b.work_id  from rws_exp_view a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"' and plan_code='1' and  substr(b.work_id,5,2)='"+dcode+"' and b.programme_code in ("+programe+")  and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by b.work_id  ";
	Statement	stmt4=conn.createStatement();
//	System.out.println("expy:"+expy);
	ResultSet rs4=stmt4.executeQuery(expy);
	Hashtable h3=new Hashtable();
	while(rs4.next())
	{
		h3.put(rs4.getString(2),rs4.getString(1));
	}
	if(rs4!=null)rs4.close();
	if(stmt4!=null)stmt4.close();
	String gdateq="select  to_char(grounding_date,'dd/mm/yyyy') ,b.work_id  from rws_work_commencement_tbl a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"' and plan_code='1' and  substr(b.work_id,5,2)='"+dcode+"'  and b.programme_code in ("+programe+") and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by grounding_date  ,b.work_id ";
	Statement	stmt5=conn.createStatement();
	//System.out.println("gdateq:"+gdateq);
	ResultSet rs5=stmt5.executeQuery(gdateq);
	Hashtable h4=new Hashtable();
	while(rs5.next())
	{
		h4.put(rs5.getString(2),rs5.getString(1));
	}
	if(rs5!=null)rs5.close();
	if(stmt5!=null)stmt5.close();
  
	
	String dcom="select  to_char(date_of_completion,'dd/mm/yyyy') ,b.work_id  from rws_work_completion_tbl a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"' and plan_code='1' and  substr(b.work_id,5,2)='"+dcode+"' and b.programme_code in ("+programe+")  and  a.work_id  in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by date_of_completion ,b.work_id  ";
	Statement	stmt7=conn.createStatement();
	//System.out.println("dcom:"+dcom);
	ResultSet rs7=stmt7.executeQuery(dcom);
	Hashtable h6=new Hashtable();
	while(rs7.next())
	{
		h6.put(rs7.getString(2),rs7.getString(1));
	}
	if(rs7!=null)rs7.close();
	if(stmt7!=null)stmt7.close();
	
	String nhabsq="select count(distinct hab_code),b.work_id from rws_admn_hab_lnk_tbl a,rws_work_admn_tbl b   where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"' and substr(a.work_id,5,2)='"+dcode+"' and plan_code='1'  and b.programme_code in ("+programe+") and  a.work_id not  in(select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"') group by b.work_id ";
	Statement	stmt8=conn.createStatement();
	//System.out.println("nhabsq:"+nhabsq);
	ResultSet rs8=stmt8.executeQuery(nhabsq);
	Hashtable h7=new Hashtable();
	while(rs8.next())
	{
		h7.put(rs8.getString(2),rs8.getString(1));
	}
	if(rs8!=null)rs8.close();
	if(stmt8!=null)stmt8.close();
	String chabsq="Select count(hab_code),b.work_id from RWS_WORK_COMP_HAB_LNK_TBL  a,rws_work_admn_tbl b  where a.work_id =b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"' and category_code='"+category+"'  and plan_code='1' and substr(a.work_id,5,2)='"+dcode+"' and b.programme_code in ("+programe+")  group by b.work_id order by 2  ";
	Statement	stmt9=conn.createStatement();
	//System.out.println("chabsq:"+chabsq);
	ResultSet rs9=stmt9.executeQuery(chabsq);
	Hashtable h8=new Hashtable();
	while(rs9.next())
	{
		h8.put(rs9.getString(2),rs9.getString(1));
	}
	if(rs9!=null)rs9.close();
	if(stmt9!=null)stmt9.close();
	 String tsd="select  ts_no||'@'||to_char(ts_date,'dd/mm/yyyy') ,b.work_id  from rws_new_est_tbl a, rws_work_admn_tbl  b where a.work_id=b.work_id and work_cancel_dt is null  and TYPE_OF_ASSET ='"+atype+"'  and category_code='"+category+"' and plan_code='1' and  substr(b.work_id,5,2)='"+dcode+"'  and b.programme_code in ("+programe+") and  a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion <'01-Apr-"+yr+"')  group by ts_no,ts_date , b.work_id  ";
    Statement	stmt6=conn.createStatement();
	//System.out.println("tsd:"+tsd);
	ResultSet rs6=stmt6.executeQuery(tsd);
	Hashtable h5=new Hashtable();
	while(rs6.next())
	{
		h5.put(rs6.getString(2),rs6.getString(1));
	}
    if(rs6!=null)rs6.close();
	if(stmt6!=null)stmt6.close();
		
		String a1="",a2="";
	String qry="select distinct division_office_name ,a.work_id,a.WORK_NAME ,PROGRAMME_name ,a.programme_code , ADMIN_NO , to_char(ADMIN_DATE,'dd/mm/yyyy') ,sanction_amount,nvl(rev_sanction_amount,0)  from rws_work_admn_tbl a,rws_programme_tbl p,rws_division_office_tbl d,RWS_REVISED_ADM_SANC_TBL  r  where work_cancel_dt is null and a.type_of_asset='"+atype+"' and plan_code='1'  and substr(a.work_id,5,2)='"+dcode+"'  and a.programme_code=p.programme_code  and substr(a.work_id,5,2)=d.circle_office_code and a.programme_code in ("+programe+") and category_code='"+category+"'  and  substr(a.office_code,4,1)=d.division_office_code  and a.work_id not in (select work_id from rws_work_completion_tbl where date_of_completion<'1-Apr-"+yr+"') and a.work_id=r.work_id (+) order by 1";
	//System.out.println("mailqqqqq"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	if(rs.isBeforeFirst())
{
	while(rs.next())
	{

		String epy=""+h.get(rs.getString(2));
	    if(epy!=null && !epy.equals("") && !epy.equals("null")){}else{epy="0";}
		String edm=""+h1.get(rs.getString(2));
		if(edm!=null && !edm.equals("") && !edm.equals("null")){}else{edm="0";}
		String edy=""+h3.get(rs.getString(2));
		if(edy!=null && !edy.equals("") && !edy.equals("null")){}else{edy="0";}
		String gdate=""+h4.get(rs.getString(2));
		if(gdate!=null && !gdate.equals("") && !gdate.equals("null")){}else{gdate="-";}
		String cdate=""+h6.get(rs.getString(2));
		if(cdate!=null && !cdate.equals("") && !cdate.equals("null")){}else{cdate="-";}
		String nhabs=""+h7.get(rs.getString(2));
		if(nhabs!=null && !nhabs.equals("") && !nhabs.equals("null")){}else{nhabs="0";}
		String chabs=""+h8.get(rs.getString(2));
		if(chabs!=null && !chabs.equals("") && !chabs.equals("null")){}else{chabs="0";}
		String ts=""+h5.get(rs.getString(2));
		 if(ts!=null && !ts.equals("") && !ts.equals("null")){
		String []tsd1=ts.split("@");a1=tsd1[0];a2=tsd1[1];}else{a1="-";a2="-";}
		
		
		%>
	 <tr>
			<td class=rptvalue align=center><%=cnt++%></td>
			<td class=rptvalue nowrap><%=rs.getString(1)%></td>
			<td class=rptvalue  ><%=rs.getString(2)%></td>
			<td class=rptvalue  ><input type="text" name="aa" class="mytext" style="width:80px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')" value="<%=rs.getString(3)%>" onmouseout="UnTip()"/></td>
			<td class=rptvalue nowrap><%=rs.getString(4)%></td>
			<td class=rptvalue nowrap><%=rs.getString(6)%></td>
			<td class=rptvalue ><%=rs.getString(7)%></td>
			<td class=rptvalue align="left" ><%=a1%></td>
			<td class=rptvalue align="left"><%=a2%></td>
			<td class=rptvalue align="right"><%=rs.getString(8)%>/<%=rs.getString(9)%></td>
			<td class=rptvalue align="right"><%=epy%></td>
			<%
			//System.out.println("ddd:::"+rs.getString(8));
		//System.out.println("epy:::"+epy);
		double d=rs.getDouble(8)+rs.getDouble(9);
				//System.out.println("d:::"+d);
		double d1=d-Double.parseDouble(epy);%>
			<td class=rptvalue align="right"><%=ndf.format(d1)%></td>
			<td class=rptvalue align="right"><%=edm%></td>
			<td class=rptvalue align="right"><%=edy%></td>
			<%if(d==0)
		{ value=0;
		}
		else
		{
		  value=Double.parseDouble(edy)/d;}%>
			<td class=rptvalue align="right"><%=ndf.format(value)%></td> 
			<td class=rptvalue align="center"><%=gdate%></td>
     		<td class=rptvalue align="center"><%=cdate%></td>
			<td class=rptvalue align="right"><%=nhabs%></td>
			<td class=rptvalue align="right"><%=chabs%></td>
		
	
		</tr>
		
	<% 
	 
		ecost+=Double.parseDouble(rs.getString(8));
		rcost+=Double.parseDouble(rs.getString(9));
		eupy+=Double.parseDouble(epy);
		bal+=d;
		epm+=Double.parseDouble(edm);
		edye+=Double.parseDouble(edy);
		be+=value;
		shabss+=Integer.parseInt(nhabs);
		chabss+=Integer.parseInt(chabs);
	}
	if(rs!=null)rs.close();
	if(stmt!=null)stmt.close();
	if(conn!=null) conn.close();
	%>
		<tr class=btext>
		<td  Colspan=9  align="right"  class=btext>Total : </td>
		<td  align="right" ><%=ndf.format(ecost)%>/<%=ndf.format(rcost)%></td>
		<td  align="right" ><%=ndf.format(eupy)%></td>
		<td  align="right" ><%=ndf.format(bal)%></td>
		<td  align="right" ><%=ndf.format(epm)%></td>
		<td  align="right" ><%=ndf.format(edye)%></td>
		<td  align="right" ><%=ndf.format(be)%></td>
		<td  align="right" >-</td>
		<td  align="right" >-</td>
		<td  align="right" ><%=shabss%></td>
		<td  align="right" ><%=chabss%></td>
		</tr>
		<%}
else
{%>
	 <tr>
<td class="rptValue" align=center colspan=19><b>No Records Match With This Selection Criteira</b></td></tr>
<%}%>
</table>	
</form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>