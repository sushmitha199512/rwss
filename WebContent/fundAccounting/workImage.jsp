<%@page import="nic.watersoft.masters.RwsMasterData"%>
<%@page import="java.io.OutputStream"%>
<%@ include file="/reports/conn.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
			
System.out.println("hello");
String id=request.getParameter("workid");
String mode=request.getParameter("mode");
					try
				    {  				       
				  		System.out.println("id"+id);
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
				    }					
				    finally
				    {
				     conn.close();
				    }  
					%>