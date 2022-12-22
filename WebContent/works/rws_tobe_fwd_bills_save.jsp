<%@ include file="/reports/conn.jsp"%>
<%
	String[] workIds = request.getParameterValues("checks");
	String userIdd = request.getParameter("userId");
	String message = "";
	try {
		conn.setAutoCommit(false);
		PreparedStatement pstmt = null;
		String qqq = "update rws_work_bill_tbl set ee_fwd_date=sysdate where work_id=? and bill_sl_no=? ";
		pstmt = conn.prepareStatement(qqq);
		for (int i = 0; i < workIds.length; i++) {
			pstmt.setString(1, workIds[i].substring(0, 14));
			pstmt.setString(2, workIds[i].substring(14, workIds[i].length()));
			pstmt.addBatch();
		}
		int res[] = pstmt.executeBatch();
		message = res.length + "(s) bills approved and forwarded to ENC Office";
		conn.setAutoCommit(true);
		conn.commit();
	} catch (Exception e) {
		try {
			conn.rollback();
			System.out.println("Exception while updating rws_work_bill_tbl in rws_tobe_fwd_bills_save.jsp --  "+e);
		} catch (Exception ee) {
		}
	}
%>

<html>
<head>
<script>
var userId = "<%=userIdd%>";
alert("<%=message%>");
	document.location.href = "rws_tobe_fwd_bills_frm.jsp?userIdd=" + userId;
</script>
</head>
<body>
</body>
</html>