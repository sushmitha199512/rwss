<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.util.*" %>
<%@ include file = "conn.jsp" %>

<html>
<%
Calendar cal=Calendar.getInstance();
int year=cal.get(Calendar.YEAR);
    
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
int sno=1;
String habType = request.getParameter("habType");
String rDistrict = request.getParameter("rDistrict");
%> 
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					
					
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="white" align="center">
			<td align="center" class="rptHeading" colspan=21>List of <font color=red><%=habType%></font> Habitations Covered in ongoing Works </td>		
	</tr>
	  <tr  align="center">
		<td align="center" class="btext" colspan="21" >District: <%=request.getParameter("rDistrictName") %></td>
	</tr>	
	
	<tr align=center  align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >District</td>
		<td class=btext >Mandal</td>
		<td class=btext >Panchayat</td>
		<td class=btext >Habitation</td>
		<td class=btext >Habitation Code</td>
		<td class=btext >Status</td>
		<td class=btext >SC Population</td>
		<td class=btext >ST Population</td>
		<td class=btext >PLAIN Population</td>
		<td class=btext >Work ID</td>
		<td class=btext >Work Name</td>
		<td class=btext >Scheme Type</td>
		<td class=btext >Programme</td>
		<td class=btext>Sub-Programme</td>
		<td class=btext >Est.Cost(Rs.in lakhs)</td>
		<td class=btext>Exp.Incurred(Rs.in lakhs)</td>
		<td class=btext >Remarks</td>
		<td class=btext >Programme(Linked)</td>
		<td class=btext >Sub Programme(Linked)</td>
		<td class=btext >Est.Cost(Linked)</td>
		
	</tr>	
	
	<%

try{
 String qry="";String pg="";
		stmt=conn.createStatement();
	   stmt1=conn.createStatement();
	   stmt2=conn.createStatement();
	   stmt3=conn.createStatement();
	   stmt4=conn.createStatement();
	   stmt5=conn.createStatement();
	ResultSet exprs = stmt2.executeQuery("select nvl(sum(total),0),b.work_id from rws_exp_view b group by b.work_id");
	Hashtable hashtable = new Hashtable();
	while(exprs.next())
	{
		hashtable.put(exprs.getString(2),exprs.getString(1)); 
	}
	 if(rDistrict.equals("00"))
	 {
	  qry = "select h.dname,h.mname,h.pname,h.panch_name,hd.coverage_status,w.CENSUS_SC_POPU,w.CENSUS_ST_POPU,w.CENSUS_PLAIN_POPU,w.work_id,ww.work_name,nvl (p.programme_name,'-') as progname,nvl (sp.subprogramme_name,'-') as subprogname,decode(substr (ww.work_id,7,2),'04','HANDPUMP','01','PWS','02','MPWS','03','CPWS','09','DP','08','OTHERS','-') AS SCHEMETYPE,WW.SANCTION_AMOUNT,hd.HAB_SUB_TYPE_40PC_CALC,h.panch_code,ww.work_id,nvl(ww.remarks,'-') as remarks  from rws_work_hab_view w,rws_complete_hab_view h,rws_habitation_directory_tbl hd,rws_work_admn_tbl ww,rws_programme_tbl p,rws_subprogramme_tbl sp where h.panch_code=hd.hab_code and w.hab_code=h.panch_code  and w.work_id=ww.work_id and ww.programme_code=p.programme_code (+) and p.programme_code=sp.programme_code and ww.subprogramme_code=sp.subprogramme_code(+)  and hd.HAB_SUB_TYPE_40PC_CALC='"+habType+"'  and ww.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION < '01-Apr-"+year+"'))  and work_cancel_dt is null order by ww.work_id";
	 }
	 else
	 {
	  ////////System.out.println(" in dist select");
	   qry = "select h.dname,h.mname,h.pname,h.panch_name,hd.coverage_status,w.CENSUS_SC_POPU,w.CENSUS_ST_POPU,w.CENSUS_PLAIN_POPU,w.work_id,ww.work_name,nvl (p.programme_name,'-') as progname,nvl (sp.subprogramme_name,'-') as subprogname,decode(substr (ww.work_id,7,2),'04','HANDPUMP','01','PWS','02','MPWS','03','CPWS','09','DP','08','OTHERS','-') AS SCHEMETYPE,WW.SANCTION_AMOUNT,hd.HAB_SUB_TYPE_40PC_CALC,h.panch_code,ww.work_id,nvl(ww.remarks,'-') as remarks  from rws_work_hab_view w,rws_complete_hab_view h,rws_habitation_directory_tbl hd,rws_work_admn_tbl ww,rws_programme_tbl p,rws_subprogramme_tbl sp where h.panch_code=hd.hab_code and w.hab_code=h.panch_code and w.work_id=ww.work_id and ww.programme_code=p.programme_code (+) and p.programme_code=sp.programme_code and ww.subprogramme_code=sp.subprogramme_code(+) and h.dcode='"+rDistrict+"' and hd.HAB_SUB_TYPE_40PC_CALC='"+habType+"'  and ww.work_id not in (select work_id from rws_work_completion_tbl where (DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION < '01-Apr-"+year+"'))  and work_cancel_dt is null order by ww.work_id";
	 } 
	 System.out.println(" Works Query:"+qry);
	   rs=stmt.executeQuery(qry);
  String workId="";
	   while(rs.next())
	   {
   

			String habType1 = rs.getString("HAB_SUB_TYPE_40PC_CALC");
			String exp = ""+hashtable.get(rs.getString("work_id"));
			if(exp==null || (exp!=null && exp.equals("null")))exp="0";
		%>
	    <tr>
				<td class=rptValue><%=sno++%></td>
				<td class="rptValue"><%=rs.getString("dname")%></td>
				<td class="rptValue"><%=rs.getString("mname")%></td>
				<td class="rptValue"><%=rs.getString("pname")%></td>
				<td class="rptValue"><%=rs.getString("panch_name")%></td>
				<td class="rptValue"><%=rs.getString("panch_code")%></td>
				<td class="rptValue"><%=rs.getString("coverage_status")%></td>
				<td class="rptValue" align="right"><%=rs.getString("census_sc_popu")%></td>
				<td class="rptValue" align="right"><%=rs.getString("census_st_popu")%></td>
				<td class="rptValue" align="right"><%=rs.getString("census_plain_popu")%></td>

<%  if(!workId.equals(rs.getString("work_id"))){ 

      workId=rs.getString("work_id");
pg="";
%>

				<td class="rptValue"><%=rs.getString("work_id")%></td>
				<td class="rptValue"><%=rs.getString("work_name")%></td>
				<td class="rptValue"><%=rs.getString("schemetype")%></td>
				<td class="rptValue"><%=rs.getString("progname")%></td>
				<td class="rptValue"><%=rs.getString("subprogname")%></td>
				<td class="rptValue"  align="right"><%=rs.getString("sanction_amount")%></td>
<td class="rptValue" align="right"><%=exp%></td>
				<td class="rptValue"><%=rs.getString("remarks")%></td>

<% } else { %>

	<td class="rptValue">-</td>
				<td class="rptValue">-</td>
				<td class="rptValue">-</td>
				<td class="rptValue">-</td>
				<td class="rptValue">-</td>
				<td class="rptValue"  align="right">-</td>
	<td class="rptValue">-</td>
				<td class="rptValue"  align="right">-</td>

<% } %>
				<%
				String ary="select programme_name,subprogramme_name,sanction_amount from rws_work_admn_prog_lnk_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp where a.programme_code=p.programme_code and p.programme_code=sp.programme_code and a.programme_code=sp.programme_code  and a.sub_programme_code=sp.subprogramme_code and work_id='"+rs.getString("work_id")+"'";	 
				rs5=stmt5.executeQuery(ary);
  
				if(rs5.next())
				{%>
<%  if(!pg.equals(rs.getString(1))){ 

      pg=rs.getString(1);
%>
                    <td class="rptValue"><%=rs5.getString(1)%></td>
					<td class="rptValue"><%=rs5.getString(2)%></td>
					<td class="rptValue"  align="right"><%=rs5.getString(3)%></td>
<% } else { %>
<td class="rptValue">-</td><td class="rptValue">-</td><td class="rptValue">-</td>
<% } %>
				<%}else{%>
					<td class="rptValue">-</td><td class="rptValue">-</td><td class="rptValue">-</td>
				<%}%>
				


	   </tr> 
	     
	   <%
	   if(rs1!=null){rs1.close();rs1=null;}
   	   if(rs2!=null){rs2.close();rs2=null;}
	   if(rs3!=null){rs3.close();rs3=null;}   	   
	   if(rs4!=null){rs4.close();rs4=null;}
	   if(rs5!=null){rs5.close();rs5=null;}
	   }
	   if(stmt1!=null){stmt1.close();stmt1=null;}
   	   if(stmt2!=null){stmt2.close();stmt2=null;}
	   if(stmt3!=null){stmt3.close();stmt3=null;}   	   
	   if(stmt4!=null){stmt4.close();stmt4=null;}
	   if(stmt5!=null){stmt5.close();stmt5=null;}
	}catch(Exception e){
e.printStackTrace();
}
	%>
	</table>
	</body>
	</html>
<%@ include file = "connClose.jsp" %>
<%} finally{
}%>