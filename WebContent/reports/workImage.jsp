<%@page import="nic.watersoft.masters.RwsMasterData"%>
<%@page import="java.io.OutputStream"%>

<%@ include file="/reports/conn.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
			String id=request.getParameter("workid");
String mode=request.getParameter("mode");
					try
				    {  				       
				  		System.out.println("id");
				       RwsMasterData  masterData=new  RwsMasterData();
				       byte[] imgData = masterData.getWorkPhoto( conn, id  ,mode) ;   				       
				       response.setContentType("image/gif");
				       OutputStream o = response.getOutputStream();
				       o.write(imgData);
				       out.flush(); 
				       o.close();
				    }
				    catch (Exception e)
				    {
				      e.printStackTrace();
				      Thread.sleep(200);
				    }					
				    finally
				    {
				     conn.close();
				    }  
					%>