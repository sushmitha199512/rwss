<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<jsp:useBean id="rwsOffices" class="nic.watersoft.commons.RwsOffices" />
<%
try
{
	ResultSet rs3=null,rs4=null;
	String val = "";
	double val1=0.0;
		int count=0;
String[] checkedValues = request.getParameterValues("sendBank");

int totBills = request.getParameter("totBills")!=null?Integer.parseInt(request.getParameter("totBills")):1;

conn.setAutoCommit(false);
stmt = conn.createStatement();
Statement st1=conn.createStatement();
Statement st2=conn.createStatement();
Statement st3=conn.createStatement();
String qry = "delete from rws_bill_pao_bridge_temp_tbl where substr(work_id,5,2)='"+request.getParameter("per")+"'";
stmt.addBatch(qry);
for(int i=0;i<checkedValues.length;i++)
{
	
	//System.out.println("checked values:"+checkedValues[i]);
	//System.out.println(request.getParameter("officeCode"+checkedValues[i]));
	//System.out.println(request.getParameter("workId"+checkedValues[i]));
	//System.out.println(request.getParameter("billSno"+checkedValues[i]));
	//System.out.println(request.getParameter("statec"+checkedValues[i]));
	//System.out.println("pcode:"+request.getParameter("progCode"+checkedValues[i]));
	//System.out.println("dcode:"+request.getParameter("workId"+checkedValues[i]).substring(4,6));
    
	qry = "insert into rws_bill_pao_bridge_temp_tbl values ('"+request.getParameter("workId"+checkedValues[i])+"','"+request.getParameter("officeCode"+checkedValues[i])+"','"+request.getParameter("billSno"+checkedValues[i])+"','"+request.getParameter("statec"+checkedValues[i])+"','"+request.getParameter("goic"+checkedValues[i])+"',sysdate)";
	//System.out.println("Qry:"+qry);
	stmt.addBatch(qry);
}

for(int i=0;i<totBills;i++)
{
	
	qry = "insert into rws_bill_pao_bridge_temp1_tbl values ('"+request.getParameter("workId"+i)+"','"+request.getParameter("officeCode"+i)+"','"+request.getParameter("billSno"+i)+"','"+request.getParameter("statec"+i)+"','"+request.getParameter("goic"+i)+"',sysdate,'"+request.getParameter("progCode"+i)+"','"+request.getParameter("dcode"+i)+"','"+request.getParameter("divcode"+i)+"')";
	//System.out.println("Qry:"+qry);
	stmt.addBatch(qry);
}

	int[] size = stmt.executeBatch();
	//System.out.println("1:"+checkedValues.length);
	//System.out.println("1:"+size.length);
	if(totBills>0)
	{
		conn.setAutoCommit(true);
		conn.commit();
	%>
		<script>
			var per = '<%=request.getParameter("per")%>';
			alert("Saved Successfully");
			document.location.href="rws_bill_release_to_pao.jsp?per="+per;
		</script>
	<%
	}
	else
	{
		conn.rollback();
	%>
		<script>
			alert("Failed to Save - Try Again");
			document.location.href="rws_bill_release_to_pao.jsp";
		</script>
	<%
	}
}

catch(Exception e)
{
	e.printStackTrace();
}
%>