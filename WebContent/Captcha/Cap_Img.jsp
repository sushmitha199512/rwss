<%@ page import="java.io.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Random"%>
<%@ page import="nic.watersoft.admin.AdminDAO"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
int width=100;
int height=35;
String capstr = "Error";
try{
if(request.getParameter("refresh")!=null && request.getParameter("refresh").equals("Y"))
{	
	AdminDAO adminDAO = new AdminDAO();
	capstr = adminDAO.getCaptchaCode();
	session.setAttribute("forgotkey",capstr);
}
capstr = (String)session.getAttribute("forgotkey"); //System.out.println("capstr :"+capstr);



//new code
Color bgColor1   = new Color(33, 189, 254); // gradient top-bottom color
Color bgColor2   = new Color(255, 255, 255); // gradient middle color
GradientPaint gp = new GradientPaint(0, 0, bgColor1, 0, height/2, bgColor2, true);


Random r = new Random();
//Color c = new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));
Color background = new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));

Color fbl = new Color(0,100,0);

//Font fnt=new Font("Roman Caps",2,20);
Font fnt = new Font("Georgia", Font.BOLD, 18);

//new code for font
String[] fontNames={" Song typeface "," Chinese regular script "," blackbody "," Microsoft jas black "," Regular script _GB2312","Georgia","Roman Caps"};
int index=r.nextInt(fontNames.length);
    String fontName=fontNames[index];
    int style=r.nextInt(4);//0  There is no  1  The bold  2  italics  3  coarse + oblique 
    int size=r.nextInt(5)+24; // Generate random size  24~28
    fnt = new Font(fontName, style, 18);
    


BufferedImage cpimg =new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);

//Graphics g = cpimg.createGraphics();
Graphics2D g=(Graphics2D) cpimg.getGraphics();

g.setColor(background);
g.fillRect(0,0,width,height);

g.setColor(fbl);

g.setFont(fnt);

g.drawString(capstr,10,25);

//g.setPaintMode();
g.setPaint(gp);
//g.setColor(background);


for (int i = 0; i < 4; i++) 
{
    int x = r.nextInt(width);
    int y = r.nextInt(height);
    int xl = r.nextInt(250);
    int yl = r.nextInt(25);
    g.drawLine(x+ xl, y , x, y+ xl);
}
for (int i = 0; i < 4; i++) 
{
    int x = r.nextInt(width);
    int y = r.nextInt(height);
    int xl = r.nextInt(250);
    int yl = r.nextInt(25);
    g.drawLine(x, y+ xl , x, y);
}

//g.drawLine(10,17,80,17);

//g.drawLine(10,22,80,22);
 response.setHeader("Cache-Control", "no-store");  
 response.setHeader("Pragma", "no-cache");  
 response.setDateHeader("Expires", 0);  

response.setContentType("image/jpeg");

OutputStream strm = response.getOutputStream();

ImageIO.write(cpimg,"jpeg",strm);
strm.flush();
strm.close();
}
catch(Exception e)
{
	System.out.println("Exception in Cap_Img.jsp--  "+e);
}
%>