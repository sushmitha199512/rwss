<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<html><body><form>
<%
	String program = request.getParameter("program");
    String subprogram = request.getParameter("subprg");
	String hoa = request.getParameter("HOACode");
	String ob[] = request.getParameterValues("ob");	

	try{
		Statement stmtt1 = conn.createStatement();
		String query="select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code order by 1,2";
		ResultSet rsss1 = stmtt1.executeQuery(query);
		conn.setAutoCommit(false);
		Statement stt = conn.createStatement();
		String delqry = "delete from RWS_GRANT_OP_CL_BAL_TBL where PROGRAMME_CODE = '"+program+"' and SUBPROGRAMME_CODE= '"+subprogram+"' and HEAD_OF_ACCOUNT='"+hoa+"'";
		stt.addBatch(delqry);
		Statement stt1 = conn.createStatement();
		int j =0,count=0;
		String val = ob[j++];
		if(!val.equals("0")){
		String qrrry = "insert into RWS_GRANT_OP_CL_BAL_TBL values('100000','"+program+"','"+hoa+"',"+val+",sysdate,'2011-2012','"+subprogram+"')";
		stt.addBatch(qrrry);
		}
		while(rsss1.next())
		{
			val = ob[j++];
			if(!val.equals("0")){
			String qrrry = "insert into RWS_GRANT_OP_CL_BAL_TBL values('1"+rsss1.getString(1)+rsss1.getString(2)+"00','"+program+"','"+hoa+"',"+val+",sysdate,'2011-2012','"+subprogram+"')";
			stt.addBatch(qrrry);
			}
		}
		int countt[] = stt.executeBatch();
		if(countt.length>0)
		{	
			conn.setAutoCommit(true);
			conn.commit();
		%>
		<script>
			var program='<%=program%>';
			alert("OB Saved/Updates Successfully under Selected Program and Head Of Account");
			document.location.href = "rws_op_cl_bal_frm.jsp?program="+program;
		</script>
		<%}
		else
		{
		%>
			<script>
				var program='<%=program%>';
				alert("Failed to Save");
				document.location.href = "rws_op_cl_bal_frm.jsp?program="+program;
			</script>
		<%
		}
	}
	catch(Exception e){
		e.getMessage();
	try
	{
	conn.rollback();
	}
	catch(Exception ee){}
}
%>
</form>
</body>
</html>