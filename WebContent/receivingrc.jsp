
<%@page import="com.ibm.icu.util.StringTokenizer"%>
<%@page import="nic.watersoft.commons.RwsOffices"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="nic.watersoft.smsmobile.Rws_PhoneNumbersArray"%>
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
                String message = request.getParameter("message");
                System.out.println("****MESSAGE****"+message);
                String time = request.getParameter("Time");
                String query="";
                String keyword="",rcValue="",location="";
                int smsid=0;
                
                try
                {
               // R.MyConnection myConnection=new util.MyConnection();
                 
                   StringTokenizer st =new StringTokenizer(message," ");
                   while(st.hasMoreElements())
                   {
                	  keyword=st.nextToken();
                	  rcValue=st.nextToken().trim();
                	  location=st.nextToken().trim();
                   }
                   
                   
                   System.out.println("RC VALUE"+rcValue+"KEYWORD"+keyword+"location:"+location);
                   
               
                   // String[] mes=message.split(" ");    
                
               // con= RwsOffices.getConn();
               
               DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
               con=DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft","aprwssuser","aprwssuser");
               //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.67:1521:orcl","aprwssuser","aprwssuser");
 		//	con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
                
                System.out.println("****SMSRESUKT****"+sender);
                
               // out.println("Connection"+con);
                
                //Verifying the Mobile AuthentiCation
               int resultAuth = nic.watersoft.smsmobile.MobileAutntication.MobileAuthentication(sender);
               String habCode = nic.watersoft.smsmobile.MobileAutntication.getHabitationCode(sender);

               System.out.println("****SMSRESUKT****"+resultAuth);
                //out.println("habCode"+habCode);
            // int resultAuth=1;
                
                if (resultAuth==1) {
                    
                	System.out.println("Authentication Succeded");
                	result = "Mobile Authentication is Succeeded";
                } else {
                   result = "Authentication Failed Please try From Another Mobile";
                   NicSmsGateway sms = new NicSmsGateway();
                   sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", sender, result);
                    return;
                }
                
                String maxvalueQuery="select max(MESG_ID)from RWS_RESIDUAL_CHLORINE_SMS_TBL";
				System.out.println(maxvalueQuery);
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
                
                

                ps = con.prepareStatement("insert into  RWS_RESIDUAL_CHLORINE_SMS_TBL (SMS_MOBILE,PPM_VALUE,TEST_DATE,MESG_ID,location) values (?,?,SYSDATE,?,?)");
                ps.setString(1, sender);
                ps.setDouble(2, Double.parseDouble(rcValue));
                ps.setInt(3, smsid);
                ps.setString(4, location);
                int i=ps.executeUpdate();
                if(i>0) {System.out.println("Message Inserted Successfully");out.println("Message Inserted Successfully");	}	   
                		   
               // out.println("**TESTING***"+ps);
                if (Double.parseDouble(rcValue) >=0.2) {
                    //System.out.println("****************");
                } else {
                    Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
                    List<String> alertNumbers = numbers.getPhoneNumbers(habCode);
                    
                    stmt1=con.createStatement();
                    System.out.println("Alert Numbers"+sender);
                    
                     query="select LOCATION,panch_name,a.habitation_code from  rws_mobile_sms_register_tbl a,rws_panchayat_raj_tbl b  where a.habitation_code=b.panch_code and  MOBILE='"+sender+"'  ";
                 
                    rs1=stmt1.executeQuery(query);
                    
                    if(rs1.next())
                    {
                     String resultAlert="Residual Chlorine Test Failed(Noted Value "+Double.parseDouble(rcValue)+") in "+rs1.getString(2)+"  at "+rs1.getString(1)+" ";
                    
                    
                    for (String mobileNumbers : alertNumbers) {
                        
                        out.println("MOBILENUMBERS"+mobileNumbers);     
                        System.out.println("***Alert Numbers****"+mobileNumbers);
                        NicSmsGateway sms = new NicSmsGateway();
                       String Result= sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);
                        
                        
                        if(Result.equals("Deliverd"))
 		               {
 		            	   stmt2=con.createStatement();
 	                       String inoutqry="insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,HABITATION_CODE) values(?,SYSDATE,'PUSH','RC',?,?)";
 	                       System.out.println("inoutqry"+inoutqry);
 	                      PreparedStatement pss=con.prepareStatement(inoutqry);
 	                      pss.setString(1, mobileNumbers);
 	                      pss.setString(2, resultAlert);
 	                      pss.setString(3, rs1.getString(3));
 	                       pss.executeUpdate();
 	                       
 	                       
 		               }

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
       