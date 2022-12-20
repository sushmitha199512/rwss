<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%



System.out.println("WORKKKID"+request.getParameter("workId"));
String workId=request.getParameter("workId");
try{
	stmt=conn.createStatement();
	String qry="select work_id,core_dashboard_status,entered_by,to_char(grounding_date,'dd/mm/yyyy') as grounding_date,office_code,officer_assigned_to,officer_assigned_to1,officer_assigned_to2,officer_assigned_to3,remark,status from rws_work_commencement_tbl where work_id='"+workId+"'";
	rs=stmt.executeQuery(qry);
	int n=0, m=0;
	if(rs.next())
	{
		String insert_qry="insert into rws_work_ground_deleted_tbl(work_id,core_dashboard_status,entered_by,grounding_date,office_code,officer_assigned_to,officer_assigned_to1,officer_assigned_to2,officer_assigned_to3,remark,status,UPDATE_DATE ) "
				+"values('"+rs.getString("work_id")+"','"+rs.getString("core_dashboard_status")+"','"+rs.getString("entered_by")+"',to_date('"+rs.getString("grounding_date")+"','dd/mm/yyyy'),'"+rs.getString("office_code")+"','"+rs.getString("officer_assigned_to")+"','"+rs.getString("officer_assigned_to1")+"','"+rs.getString("officer_assigned_to2")+"','"+rs.getString("officer_assigned_to3")+"','"+rs.getString("remark")+"','"+rs.getString("status")+"',sysdate)";
		System.out.println(insert_qry);
		Statement statement1=conn.createStatement();
		 m=statement1.executeUpdate(insert_qry);
	
	
	if(m!=0){
	Statement statement=conn.createStatement();
	
	
	String deleteQuery="delete from RWS_WORK_COMMENCEMENT_TBL where work_id='"+workId+"'";
	n=statement.executeUpdate(deleteQuery);
	}
	}
	if(n!=0 && m!=0){
		request.setAttribute("message", "Work Deleted Sucesfully in Program Schedule");
	}
	else{
		request.setAttribute("message", "Failed to Delete Work");
	}
	
	%>
	<jsp:forward page="rws_works_wrongly_grounded_rpt.jsp"/> 
	<%
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	if(conn!=null){
		conn.close();
	}
}
%>