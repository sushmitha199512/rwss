<%@ page import="java.io.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.util.*"%>
<%@ page import="nic.watersoft.admin.AdminDAO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	int width=100;
	int height=35;
	String capstr = "Error";
	try{
		if(request.getParameter("refresh")!=null && request.getParameter("refresh").equals("Y")){	
			AdminDAO adminDAO = new AdminDAO();
			capstr = adminDAO.getCaptchaCode();
			
			System.out.println("refresh Y capstr :"+capstr);	
			session.setAttribute("key",capstr);	
		}
		capstr = (String)session.getAttribute("key");	System.out.println("capstr :"+capstr);	
		Color background = new Color(204,204,204);		
		Color fbl = new Color(0,100,0);		
		Font fnt=new Font("Roman Caps",2,20);		
		BufferedImage cpimg =new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);		
		Graphics g = cpimg.createGraphics();		
		g.setColor(background);		
		g.fillRect(0,0,width,height);		
		g.setColor(fbl);		
		g.setFont(fnt);		
		g.drawString(capstr,10,25);		
		g.setPaintMode();		
		g.setColor(background);
		response.setContentType("image/jpeg");		
		OutputStream strm = response.getOutputStream();		
		ImageIO.write(cpimg,"jpeg",strm);
		strm.flush();
		strm.close();
		return;
}
catch(Exception e){
	System.out.println("The exception in Cap_Img.jsp = "+e.getMessage());
}
%>
