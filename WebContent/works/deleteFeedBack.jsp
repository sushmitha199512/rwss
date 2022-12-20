<%@ include file="/reports/conn.jsp"%>
<%
			RequestDispatcher dispatcher = null;
			String msg = "Deletion Failed";
			String jspUrl = "";
			String id = request.getParameter("id");
			try
			{
				Statement stmt = conn.createStatement();
				String qry = "delete from rws_scheme_asset_feedback_tbl where id='"+id+"'";
				System.out.println("Qry:"+qry);
				stmt.executeUpdate(qry);
				msg = "Feed Back Deleted";
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
%>
<%=msg%>