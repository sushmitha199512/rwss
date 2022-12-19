<%@page import="nic.watersoft.masters.RwsMasterData"%>
<%@page import="java.io.OutputStream"%>

<%@ include file="/reports/conn.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
			String id=request.getParameter("imgID");
					try
				    {  
				       
				  
				       RwsMasterData  masterData=new  RwsMasterData();
				       
				       
				       byte[] imgData = masterData.getPhoto( conn, id  ) ;   
				       
				       response.setContentType("image/gif");
				       OutputStream o = response.getOutputStream();
				     
				       o.write(imgData);
				       out.flush(); 
				       o.close();
				    }
				    catch (Exception e)
				    {
				      e.printStackTrace();
				      
				    }
					
				    finally
				    {
				     conn.close();
				    }  
					%>