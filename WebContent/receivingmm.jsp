<%@page import="java.util.StringTokenizer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="nic.watersoft.smsmobile.NicSmsGateway"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

            <%
               
            System.out.println("****TOPMOST****");
                Connection con = null;
                PreparedStatement ps = null;
                Statement stmt1=null,stmt2=null;
                String result = "";
                ResultSet rs1=null;
                String sender = request.getParameter("Sender");
                String dest = request.getParameter("Destination");
                String message = request.getParameter("Message");
                System.out.println("****MESSAGE****"+message);
                System.out.println("****Destination****"+dest);
                System.out.println("****sender****"+sender);
                
                String time = request.getParameter("Time");
                String query="";
                String keyword="",resultMessage="";
                int smsid=0;
                String schollCode="",classType="",attendance="",mealstaken="";
                try
                {
               // R.MyConnection myConnection=new util.MyConnection();
                 
                  /* StringTokenizer st =new StringTokenizer(message," ");
                   while(st.hasMoreElements())
                   {
                	  keyword=st.nextToken();
                	  resultMessage=st.nextToken().trim();
                	   
                   } */
                   
                   
                 //  System.out.println("MADHU RC VALUE"+resultMessage+"KEYWORD"+keyword);
                   
                   
                   
                   StringTokenizer st1 =new StringTokenizer(message,",");
                   while(st1.hasMoreElements())
                   {
                	      schollCode=st1.nextToken();
                          classType=st1.nextToken();
                          attendance=st1.nextToken();
                          mealstaken=st1.nextToken();                                
                       
                	   
                   }
                   
                   
                   
                   
               
                   // String[] mes=message.split(" ");    
                
               // con= RwsOffices.getConn();
               
               DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
 //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.140:1521:wsoft","aprwssuser","aprwssuser");
 //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
 con=DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft","aprwssuser","aprwssuser");
                
                System.out.println("****SMSRESUKT****"+sender);
                
               // out.println("Connection"+con);
                
                //Verifying the Mobile AuthentiCation
             //  int resultAuth = nic.watersoft.smsmobile.MobileAutntication.MobileAuthentication(sender);
             //  String habCode = nic.watersoft.smsmobile.MobileAutntication.getHabitationCode(sender);

               
                //out.println("habCode"+habCode);
            // int resultAuth=1;
                
             
                   NicSmsGateway sms = new NicSmsGateway();
                  // sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", sender, result);
                
                
               
                    ps = con.prepareStatement("insert into  middaymeal (schoolcode,classtype, attendance,mealstaken) values (?,?,?,?)");
	                ps.setString(1, schollCode);
	                ps.setString(2, classType);
	                ps.setString(3, attendance);
                    ps.setString(4, mealstaken);
	               
	                System.out.println("**TESTING***"+ps);
                int i=ps.executeUpdate();
                if(i>0) {System.out.println("Message Inserted Successfully");out.println("Message Inserted Successfully");	}	   
                		   
               // out.println("**TESTING***"+ps);
                   //NicSmsGateway sms = new NicSmsGateway();
                   sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", sender, "MID-DAY MEAL DETAILS RECORDED SUCCESSFULLY.Attandance were:"+attendance);
                   
                    }
                   
                    
                    
                    
               
                
                catch(Exception ex)
                {
                System.out.println(ex);
                }
                finally
                {
                    con.close();
                }
              
            %>
       