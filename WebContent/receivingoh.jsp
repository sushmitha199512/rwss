<%@page import="com.ibm.icu.util.StringTokenizer"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="nic.watersoft.smsmobile.Rws_PhoneNumbersArray"%>
<%@page import="nic.watersoft.smsmobile.NicSmsGateway"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <body>
        <form name="f1">
            <%
               
                Connection con = null;
                PreparedStatement ps = null;
                Statement stmt1=null,stmt2=null;
                String result = "";
                ResultSet rs1=null;
                String sender = request.getParameter("Sender");
                String dest = request.getParameter("Destination");
                String message = request.getParameter("Message");
                System.out.println("message@@@@@@@@@@@@@@@@@"+message);
                String time = request.getParameter("Time");
                String Location=request.getParameter("Location");
                String query="";
                int smsid=0;
                String keyword="",OHGLValue="",LocationOG="";
                String type="O";
                
                try
                {
                	
                	  StringTokenizer st =new StringTokenizer(message," ");
                	  System.out.println("st@@@@@@@@@@@ststststst@@@@@@"+st);
                      while(st.hasMoreElements())
                      {
                    	  System.out.println("#######");
                   	  keyword=st.nextToken();
                   	OHGLValue=st.nextToken();
                   	LocationOG=st.nextToken();
                   	   
                      }
                      
              
                DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
              
              //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
              con=DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft","aprwssuser","aprwssuser");
                
              
                int resultAuth = nic.watersoft.smsmobile.MobileAutntication.MobileAuthentication(sender);
                String habCode = nic.watersoft.smsmobile.MobileAutntication.getHabitationCode(sender);

                out.println("RESUKT"+resultAuth);
                
                if (resultAuth == 1) {
                    result = "Mobile Authentication is Succeeded";
                } else {
                   result = "Authentication Failed Please try From Another Mobile";
                   NicSmsGateway sms = new NicSmsGateway();
                   sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", sender, result);
                    return;
                }

          String maxvalueQuery="select max(MESG_ID) from RWS_OHSR_GLSR_SMS_TBL  ";
				
				Statement statement=con.createStatement();
				ResultSet resultSet=statement.executeQuery(maxvalueQuery);
				if(resultSet.next()){
					
						smsid=resultSet.getInt(1);
						smsid++;
					
				
				}
				else
				{
					smsid=1;
				}
                
                
                
                ps = con.prepareStatement("insert into  RWS_OHSR_GLSR_SMS_TBL(SMS_MOBILE,GLSR_OHSR_CLEAN_STATUS,TEST_DATE,GLSR_OHSR,MESG_ID,LOCATION) values (?,?,SYSDATE,?,?,?)");
                ps.setString(1, sender);
                ps.setString(2, OHGLValue);
                ps.setString(3, type);
                ps.setInt(4, smsid);
                ps.setString(5, LocationOG);
                
                ps.executeUpdate();
                out.println("**TESTING***"+ps);
               
                    Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
                    List<String> alertNumbers = numbers.getPhoneNumbers(habCode);
                    
                    stmt1=con.createStatement();
                    
                     query="select SMS_MOBILE,GLSR_OHSR_CLEAN_STATUS,TEST_DATE,a.LOCATION,b.habitation_code from  RWS_OHSR_GLSR_SMS_TBL a,rws_mobile_sms_register_tbl b where SMS_MOBILE=b.MOBILE and  SMS_MOBILE='"+sender+"' ";
                    
                     rs1=stmt1.executeQuery(query);
                    
                    while(rs1.next())
                    {
                     String resultAlert="OHSR(OverHead Tank) Not Cleaned in "+rs1.getString(4)+"    ";
                    for (String mobileNumbers : alertNumbers) {
                        
                        out.println("MOBILENUMBERS"+mobileNumbers);                   
                        NicSmsGateway sms = new NicSmsGateway();
                        String Result=sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);
                        
                        if(Result.equals("Deliverd"))
 		               {
 		            	   stmt2=con.createStatement();
 	                       String inoutqry="insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,habitation_code) values('"+mobileNumbers+"',SYSDATE,'PUSH','OH','"+resultAlert+"','"+rs1.getString(5)+"')";
 	                       System.out.println("inoutqry"+inoutqry);
 	                       stmt2.executeUpdate(inoutqry);
 	                       
 	                       
 		               }

                    }
                    }
                
                }
                catch(Exception ex)
                {
                ex.printStackTrace();
                }
                finally
                {
                    con.close();
                }
              
            %>
        </form>
    </body>
</html>