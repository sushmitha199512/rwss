<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<jsp:useBean id="rwsOffices" class="nic.watersoft.commons.RwsOffices" />
<%
try
{
String[] checkedValues = request.getParameterValues("sendBank");
conn.setAutoCommit(false);
stmt = conn.createStatement();
String qry = "delete from rws_bill_bank_bridge_temp_tbl  where substr(work_id,5,2)='"+request.getParameter("per")+"'";
stmt.addBatch(qry);
for(int i=0;i<checkedValues.length;i++)
{
	//System.out.println(checkedValues[i]);
	//System.out.println(request.getParameter("officeCode"+checkedValues[i]));
	//System.out.println(request.getParameter("workId"+checkedValues[i]));
	//System.out.println(request.getParameter("billSno"+checkedValues[i]));
	//System.out.println(request.getParameter("statec"+checkedValues[i]));
	//System.out.println(request.getParameter("goic"+checkedValues[i]));
	qry = "insert into rws_bill_bank_bridge_temp_tbl values ('"+request.getParameter("workId"+checkedValues[i])+"','"+request.getParameter("officeCode"+checkedValues[i])+"','"+request.getParameter("billSno"+checkedValues[i])+"','"+request.getParameter("statec"+checkedValues[i])+"','"+request.getParameter("goic"+checkedValues[i])+"',sysdate,'I')";
	//System.out.println("Qry:"+qry);
	stmt.addBatch(qry);
}
	int[] size = stmt.executeBatch();
	//System.out.println("1:"+checkedValues.length);
	//System.out.println("1:"+size.length);
	if(checkedValues.length+1==size.length)
	{
		conn.setAutoCommit(true);
		conn.commit();
	%>
		<script>
			var per = '<%=request.getParameter("per")%>';
			alert("Saved Successfully");
			document.location.href="rws_bill_release_to_bank.jsp?per="+per;
		</script>
	<%
	}
	else
	{
		conn.rollback();
	%>
		<script>
			alert("Cannot Save - Duplicate bill details selected (work_id+ Bill No.)");
			document.location.href="rws_bill_release_to_bank.jsp";
		</script>
	<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
%>