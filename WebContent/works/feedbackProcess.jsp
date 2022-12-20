<%@ page import="javax.servlet.*"%>
<%@ include file="/reports/conn.jsp"%>
<%
			RequestDispatcher dispatcher = null;
			String msg = "";
			String jspUrl = "";
			String desc = request.getParameter("desc");
			nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
			String userid = users.getUserId(); 

			String mail = request.getParameter("mail");
			//System.out.println("useriddddddd:"+userid);
			try
			{
				stmt = conn.createStatement();
				int id = 0;
				rs = stmt.executeQuery("select max(ID) from rws_scheme_asset_feedback_tbl");
				if(rs.next())
				{
					if( rs.getString(1) != null )
					{
						id = Integer.parseInt(rs.getString(1));
					}
				}
				id++;
				rs.close();
				String qry = "insert into rws_scheme_asset_feedback_tbl values('"+id+"','"+desc+"','"+userid.toUpperCase()+"','"+mail+"','"+request.getParameter("name")+"','"+request.getParameter("desg")+"',sysdate)";
				System.out.println("Qry:"+qry);
				stmt.executeUpdate(qry);
				msg = "Thank You! Your Feed Back is Valuable to Us";
				if(userid!=null && userid.equals("psrwss"))
				{
					jspUrl = "feedbackSecy.jsp";
				}
				else
				{
					jspUrl = "feedback.jsp";
				}
				
				
				request.setAttribute("msg",msg);
				dispatcher = request.getRequestDispatcher(jspUrl);
				dispatcher.forward(request,response);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
%>