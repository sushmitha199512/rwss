<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

	<%
	DecimalFormat ndf = new DecimalFormat("####.##");
    
	String year=request.getParameter("finyear");
	String scheme="";
	  if(request.getParameterValues("scheme")!=null){
	    String[] schemes=request.getParameterValues("scheme");
	    
		for(int i=0;i<schemes.length;i++)
		{
		scheme += schemes[i]+",";
		}
		////System.out.println("programe::"+programe);
		scheme = scheme.substring(0,scheme.length()-1);
	session.setAttribute("scheme",scheme);
	} 
	if(year!=null)
	{
		session.setAttribute("year",year);
	}
	//System.out.println("year::"+year);
	
	String startyr =year.substring(0,4);
	String endyr =year.substring(5,9);
    String endyr1 =year.substring(5,9);
	String fyear=year.substring(0,4);
	session.setAttribute("startyr",startyr);
	session.setAttribute("endyr",endyr);
	
	if(fyear!=null)
	{
		session.setAttribute("fyear",fyear);
	}
	//System.out.println("fyear::"+fyear);
	String tyear=year.substring(5,9);
	if(tyear!=null)
	{
		session.setAttribute("tyear",tyear);
	}
	//System.out.println("tyear::"+tyear);
	
	String[] programes=request.getParameterValues("program");
	String programe="";
	for(int i=0;i<programes.length;i++)
	{
	programe += programes[i]+",";
	}
	programe = programe.substring(0,programe.length()-1);
	//System.out.println("programe::"+programe);
if(programe!=null)
	{
		session.setAttribute("programe",programe);
	}
	String dcode=request.getParameter("district");
	if(dcode!=null)
	{
		session.setAttribute("dcode",dcode);
	}
		String dname=request.getParameter("distname");
if(dname!=null)
	{
		session.setAttribute("dname",dname);
	}
	//System.out.println("dcode::"+dcode);

	%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back|</a></td>
				<td class="bwborder"><a href="./rws_PhyCom_FinNotCom_xls.jsp" target="_new">Excel</a></td>
			</tr>
		</table>
	</caption>
	
	</table>
	
<table cellspacing = 0 cellpadding = 0 height=5% width="100%"  style="border-collapse:collapse"  align = "center">
		<tr >
		<td   class="gridhdbg" colspan=22>Financially not Completed Work Details for the  Year(<font color="red" face="verdana" size="2"><%=year%></font>)</td>	
		</tr>
		<tr  > <td class="gridhdbg" colspan=17>District :<font color="red" face="verdana" size="2"> <%=dname%> </font> </td> </td></tr>
		<tr align=center  align=center>
		<td class="gridhdbg" >Sl.No</td>
		<td class="gridhdbg" >District</td>
		<td  class="gridhdbg" >Division</td>
		<td class="gridhdbg" >Work Id</td>
		<td  class="gridhdbg" >Work Name</td>
		<td  class="gridhdbg" >Sanction Amount</td>
		<td  class="gridhdbg" >Exp Upto<br></br>01.04.<%=startyr %></td>
		<td  class="gridhdbg" >Rel During<br></br><%=year%></td>
		<td  class="gridhdbg" >Exp During<br></br><%=year%></td>
		<td  class="gridhdbg" >No.of Habs</td>	
		<td class="gridhdbg" >Programe</td>	
		<td  class="gridhdbg" >SubProgramme</td>	
		<td  class="gridhdbg" >Date of Completion</td>
		<td class="gridhdbg" >Handover to PRI</td>		
		<td  class="gridhdbg" >Approved Under</td>
		<td  class="gridhdbg" >Remarks</td>
		</tr>
	
	<%
	
	int no=1;
	
	
	
	String estcost="select a.work_id,sum(case when (to_date(voucher_dt)< '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000,sum(case when (to_date(voucher_dt)>= '01-APR-"+startyr+"') then voucher_Amt else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b,rws_work_completion_tbl c  where work_cancel_dt is null  and a.work_id=b.work_id and DT_FIN_COMPLETION  is  null  and DATE_OF_COMPLETION is not null and c.work_id=a.work_id";
	if(dcode!=null && !dcode.equals("All") && !dcode.equals("")){
		estcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	}
	if(scheme!=null && !scheme.equals(""))
	{
		estcost+=" and type_of_asset in("+scheme+") ";
	}
	estcost+=" and a.programme_code in ("+programe+") group by a.work_id order by  substr(a.work_id,5,2) ";
	System.out.println("estcost "+estcost);

	Statement stmt5=conn.createStatement();
    ResultSet rs5=stmt5.executeQuery(estcost);
	Hashtable estcost_det = new Hashtable();

	while(rs5.next()){
		estcost_det.put(rs5.getString(1),rs5.getString(2)+"@"+rs5.getString(3));
	}
	
	if(stmt5!=null){
		stmt5.close();
	}
	
	
	/* Releases Query */
	
	String relcost="select a.work_id,sum(case when (to_date(BANK_SEND_DATE)< '01-APR-"+startyr+"') then BILL_AMOUNT_CENTRAL else 0 end)/100000,sum(case when (to_date(BANK_SEND_DATE)>= '01-APR-"+startyr+"') then BILL_AMOUNT_CENTRAL else 0 end)/100000 from  RWS_WORK_ADMN_TBL a,RWS_bill_bank_bridge_det_TBL b,rws_work_completion_tbl c  where work_cancel_dt is null  and a.work_id=b.work_id and DT_FIN_COMPLETION  is  null  and DATE_OF_COMPLETION is not null and c.work_id=a.work_id";
	if(dcode!=null && !dcode.equals("All") && !dcode.equals("")){
		relcost+=" and substr(a.work_id,5,2)='"+dcode+"' ";
	}
	if(scheme!=null && !scheme.equals(""))
	{
		relcost+=" and type_of_asset in("+scheme+") ";
	}
	relcost+=" and a.programme_code in ("+programe+") group by a.work_id order by  substr(a.work_id,5,2) ";
	System.out.println("relcost "+relcost);

	Statement stmt6=conn.createStatement();
    ResultSet rs6=stmt6.executeQuery(relcost);
	Hashtable relHash = new Hashtable();

	while(rs6.next()){
		relHash.put(rs6.getString(1),rs6.getString(2)+"@"+rs6.getString(3));
	}
	
	if(stmt5!=null){
		stmt5.close();
	}
	
	
	String qry1="select dname,division_office_name,wa.WORK_ID,work_name,NO_OF_HABS,PROGRAMME_name ,SUBPROGRAMME_name ,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),DATE_OF_COMM,HANDOVER_PRI, APPROVED_UNDER,wc.remarks,SANCTION_AMOUNT   from rws_work_completion_tbl wc,rws_work_admn_tbl wa ,rws_programme_tbl p ,rws_subprogramme_tbl sp,rws_district_tbl d,rws_division_office_tbl div  where DT_FIN_COMPLETION  is  null  and DATE_OF_COMPLETION is not null and wc.work_id=wa.work_id ";
	
	if(dcode!=null && !dcode.equals("All") && !dcode.equals("")){
		qry1+= " and substr(wa.work_id,5,2)='"+dcode+"' ";
	}
	
	if(scheme!=null && !scheme.equals(""))
	{
		qry1+=" and type_of_asset in("+scheme+") ";
	}
	
	qry1+="   and work_cancel_dt is null  and wa.programme_code in("+programe+") and wa.programme_code=p.programme_code and wa.subprogramme_code=sp.subprogramme_code and p.programme_code=sp.programme_code and substr(wa.work_id,5,2)=d.dcode and d.dcode=div.circle_office_code and substr(office_code,4,1)=div.division_office_code order by DATE_OF_COMPLETION desc ";
System.out.println("works:"+qry1);
Statement stmt1=conn.createStatement();
ResultSet rs1=stmt1.executeQuery(qry1);
int styleCount=0;String style="";
if(rs1.isBeforeFirst())
{
while(rs1.next())
{
double expUpto=0,expDuring=0,relUpto=0,relDuring=0;
	if(estcost_det.get(rs1.getString(3))!=null){
		 String val=(String)estcost_det.get(rs1.getString(3));
		 String vals[]=val.split("@");
		 expUpto=Double.parseDouble(vals[0]);
		 expDuring=Double.parseDouble(vals[1]);
		 //System.out.println("workid="+rs2.getString(4)+"=="+voamnt); 
	 }
	
	if(relHash.get(rs1.getString(3))!=null){
		 String val=(String)relHash.get(rs1.getString(3));
		 String vals[]=val.split("@");
		 relUpto=Double.parseDouble(vals[0]);
		 relDuring=Double.parseDouble(vals[1]);
		 //System.out.println("workid="+rs2.getString(4)+"=="+voamnt); 
	 }
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;

%>
 <tr>
	   <td class=<%=style %> style="text-align: left;"><%=no++%></td>
	    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(1)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(3)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(4)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(13)%></td>
		<td class=<%=style %> style="text-align: left;"><%= ndf.format(expUpto) %></td>
		<td class=<%=style %> style="text-align: left;"><%= ndf.format(relDuring) %></td>
		<td class=<%=style %> style="text-align: left;"><%= ndf.format(expDuring) %></td>
		
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(5)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(6)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(7)%></td>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(8)%></td>
		<%if(rs1.getString(10)!=null && !rs1.getString(10).equals("")){%>
		<td class=<%=style %> style="text-align: left;" ><%=rs1.getString(10)%></td>
		<%}else{%>
		<td class=<%=style %> style="text-align: left;">-</td>
		<%}%>
		<%if(rs1.getString(11)!=null && !rs1.getString(11).equals("")){%>
		<td class=<%=style %> style="text-align: left;" ><%=rs1.getString(11)%></td>
		<%}else{%>
		<td class=<%=style %> style="text-align: left;">-</td>
		<%}%>
		<%if(rs1.getString(12)!=null && !rs1.getString(12).equals("")){%>
		<td class=<%=style %> style="text-align: left;"><%=rs1.getString(12)%></td>
		<%}else{%>
		<td class=<%=style %> style="text-align: left;">-</td>
		<%}%>
		

<%}}
else
{
%>
	<script>
		alert("No Works under this selection criteria-You are rediredted to previous page");
		document.location.href="rws_PhyCom_FinNotCom_frm.jsp";
	</script>
<%
}
%>
	
	
	
	
</table>	
</html>
<%@ include file = "footer.jsp" %>