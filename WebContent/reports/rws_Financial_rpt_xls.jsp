<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<html>
	<% DecimalFormat ndf = new DecimalFormat("####.00");
	double obtot=0.0,ttot=0.0,ttot1=0.0,vtot=0.0,ttot2=0.0;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dname =(String)session.getAttribute("dname");
	//System.out.println("dname::::::::>>>>>>>>>>>"+dname);
	String dcode = (String)session.getAttribute("dcode");
	String programe =  (String)session.getAttribute("programe");
	String finyear =  (String)session.getAttribute("finyear");
	String yr = (String)session.getAttribute("yr");
	String nextyr = (String)session.getAttribute("nextyr");
	//System.out.println("dcode value::"+dcode);
	//	System.out.println("finyear value::"+finyear);
	String mode = request.getParameter("mode");	
	String query = null;
	int sno=1;
	String program="";
	%>


<body bgcolor="#edf2f8">
 <form> 
 <table>
	<tr bgcolor="#8D9EAF" align="center">

			<td align="center" class="rptHeading" colspan=7><font style="text-transform: uppercase;"> District : <%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Achievement Report </font></td>		
		</tr>
		</table>
		<table border = 1 cellspacing = 0 cellpadding = 0 height="5%" width="70%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center" colspan=7>	

		<tr align=center>
		<td class=btext>Sl.No</td>
		<td class=btext>Division</td>
		<td class=btext  >OB Balance<br>(1/4/2011)</td>
		<td class=btext  >Realease<br> During <br> the Year</td>
		<td class=btext  >Fund<br> Available<BR>(3+4)</td>
		<td class=btext  >Expenditure</td>
		<td class=btext  >% Of <br>Achievement<BR>(6/5)</td>
		</tr>
		<tr><td align="center" class=btext>1</td><td align="center" class=btext>2</td><td align="center" class=btext>3</td><td align="center" class=btext>4</td><td align="center" class=btext>5</td><td align="center" class=btext>6</td><td align="center" class=btext>7</td></tr>
	<%

		String obqry="select sum(op_cl_bal),substr(office_code,2,3) from RWS_GRANT_OP_CL_BAL_TBL where fin_year='"+finyear+"'";
		if(dcode!=null && !dcode.equals("All")) obqry += " and substr(office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) obqry += " and programme_code in("+programe+") ";
		obqry += " group by substr(office_code,2,3) ";
		Statement	stmt1=conn.createStatement();
		//System.out.println("obqry1:"+obqry);
		ResultSet rs1=stmt1.executeQuery(obqry);
		Hashtable h1=new Hashtable();
		while(rs1.next())
		{
		h1.put(rs1.getString(2),rs1.getString(1));
		}
		if(rs1!=null)rs1.close();
		if(stmt1!=null)stmt1.close();
		String billcqry="select sum(BILL_AMOUNT_CENTRAL ),substr(B.office_code,2,3) from RWS_bill_bank_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and bank_send_date>='01-APR-"+yr+"' and bank_send_date<'31-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) billcqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billcqry += " and programme_code in( "+programe+") ";
		billcqry += " group by substr(B.office_code,2,3) ";
		Statement	stmt2=conn.createStatement();
		//System.out.println("billcqry1:"+billcqry);
		ResultSet rs2=stmt2.executeQuery(billcqry);
		Hashtable h2=new Hashtable();
		while(rs2.next())
		{
		h2.put(rs2.getString(2),rs2.getString(1));
		}
		if(rs2!=null)rs2.close();
		if(stmt2!=null)stmt2.close();
		String billsqry="select sum(BILL_AMOUT_STATE ),substr(B.office_code,2,3) from RWS_bill_pao_bridge_det_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  and state_send_date>='01-APR-"+yr+"' and state_send_date<'31-MAR-"+nextyr+"'";
		if(dcode!=null && !dcode.equals("All")) billsqry += " and substr(a.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billsqry += " and programme_code in("+programe+")";
		billsqry += " group by substr(B.office_code,2,3) ";
		Statement	stmt3=conn.createStatement();
		//System.out.println("billsqry1:"+billsqry);
		ResultSet rs3=stmt3.executeQuery(billsqry);
		Hashtable h3=new Hashtable();
		while(rs3.next())
		{
		h3.put(rs3.getString(2),rs3.getString(1));
		}
		if(rs3!=null)rs3.close();
		if(stmt3!=null)stmt3.close();

		String billvqry="select sum(voucher_AMT ),substr(w.office_code,2,3) from RWS_work_exp_voucher_TBL a,rws_work_admn_tbl w where a.work_id=w.work_id and voucher_dt>='01-APR-"+yr+"' and voucher_dt<'31-Mar-"+nextyr+"' ";
		if(dcode!=null && !dcode.equals("All")) billvqry += " and substr(w.office_code,2,2)='"+dcode+"'";
		if(program!=null && !program.equals("All")) billvqry += " and w.programme_code in ("+programe+")";
		billvqry += " group by substr(w.office_code,2,3) ";
		Statement	stmt4=conn.createStatement();
		//System.out.println("billvqry:"+billvqry);
		ResultSet rs4=stmt4.executeQuery(billvqry);
		Hashtable h4=new Hashtable();
		while(rs4.next())
		{
		h4.put(rs4.getString(2),rs4.getString(1));
		}
		if(rs4!=null)rs4.close();
		if(stmt4!=null)stmt4.close();

     String qry="select *	 from rws_division_office_tbl ";
	 if(dcode!=null && !dcode.equals("All")) qry += " where circle_office_code='"+dcode+"'";
	 qry += " order by 1";
	//System.out.println("qry111:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
	{
		
         String obamt=""+h1.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(obamt!=null && !obamt.equals("") && !obamt.equals("null")){}else{obamt="0";}
		 String cenamt=""+h2.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(cenamt!=null && !cenamt.equals("") && !cenamt.equals("null")){}else{cenamt="0";}
		 String staamt=""+h3.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(staamt!=null && !staamt.equals("") && !staamt.equals("null")){}else{staamt="0";}
		 String vamt=""+h4.get(rs.getString("circle_office_code") + rs.getString("division_office_code"));
	    if(vamt!=null && !vamt.equals("") && !vamt.equals("null")){}else{vamt="0";}
		Double tot=Double.parseDouble(cenamt)+Double.parseDouble(staamt);
		Double tot1=Double.parseDouble(obamt)+(Double.parseDouble(cenamt)+Double.parseDouble(staamt));
		Double tot2=0.0;
		if(tot1>0) tot2 = (Double.parseDouble(vamt)/tot1)*100;
%>
		<tr>	<td class=rptValue><%=sno++%></td>
		<td  class=rptValue ><%=rs.getString("division_office_name")%></td>
		<td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(obamt))%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot)%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot1)%></td>
		<td  class=rptValue align="right"><%=ndf.format(Double.parseDouble(vamt))%></td>
		<td  class=rptValue align="right"><%=ndf.format(tot2)%></td>
		</tr>
	<%
	obtot+=Double.parseDouble(obamt);
	ttot+=tot;
	ttot1+=tot1;
	vtot+=Double.parseDouble(vamt);
	ttot2+=tot2;
	}%>
<tr>
						<td class="btext" colspan="2" align="right" >Total : </td>
						<td class="btext"  align="right"><%=ndf.format(obtot)%></td>
						<td class="btext"  align="right"><%=ndf.format(ttot)%></td>
						<td class="btext" align="right"><%=ndf.format(ttot1)%></td>
						<td class="btext" align="right"><%=ndf.format(vtot)%></td>
						<td class="btext" align="right"><%=ndf.format(ttot2)%></td>
						</tr>

	</table>
	<input type="hidden" name="mode">
	</form>
	</body>
	<br>
	</html>