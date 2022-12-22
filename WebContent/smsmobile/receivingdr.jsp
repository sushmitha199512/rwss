
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
                String message = request.getParameter("Message");
                System.out.println("****MESSAGE****"+message);
                String time = request.getParameter("Time");
                String query="";
                String keyword="",drValue="",location="";
                int smsid=0;
                
                try
                {
               // R.MyConnection myConnection=new util.MyConnection();
                 
                   StringTokenizer st =new StringTokenizer(message," ");
                   while(st.hasMoreElements())
                   {
                	  keyword=st.nextToken();
                	  drValue=st.nextToken().trim();
                	  location=st.nextToken().trim();
                	   
                   }
                   
                   
                   System.out.println("MADHU DR VALUE************"+drValue+"KEYWORD@@@@@@@@@@@@@"+keyword);
                   
               
                   // String[] mes=message.split(" ");    
                
               // con= RwsOffices.getConn();
               
               DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
 //conn=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.137:1521:orcl","aprwssuser","aprwssuser");
 con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
                
                System.out.println("****SMSRESUKT****"+sender);
                
               // out.println("Connection"+con);
                
                //Verifying the Mobile AuthentiCation
               int resultAuth = nic.watersoft.smsmobile.MobileAutntication.MobileAuthentication(sender);
               String habCode = nic.watersoft.smsmobile.MobileAutntication.getHabitationCode(sender);

               
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
                
                String maxvalueQuery="select max(MESG_ID)from RWS_DROUGHT_TANKER_SMS_TBL";
				
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
                
                

				ps = con.prepareStatement("insert into  RWS_DROUGHT_TANKER_SMS_TBL  (SMS_MOBILE,TANKER_STATUS,SEND_DATE,MESG_ID,LOCATION) values (?,?,SYSDATE,?,?)");
                ps.setString(1, sender);
                ps.setString(2, drValue);
                ps.setInt(3, smsid);
                ps.setString(4, location);
               
	               
	                System.out.println("**TESTING***"+ps);
                int i=ps.executeUpdate();
                if(i>0) {System.out.println("Message Inserted Successfully");out.println("Message Inserted Successfully");	}	   
                		   
               // out.println("**TESTING***"+ps);
                
                    Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
                    List<String> alertNumbers = numbers.getPhoneNumbers(habCode);
                    
                    stmt1=con.createStatement();
                    System.out.println("Alert Numbers"+sender);
                    
                    query="select SMS_MOBILE,TANKER_STATUS,SEND_DATE,b.LOCATION,b.habitation_code from  RWS_DROUGHT_TANKER_SMS_TBL a,rws_mobile_sms_register_tbl b where SMS_MOBILE=b.MOBILE and  SMS_MOBILE='"+sender+"' ";
                 
                    rs1=stmt1.executeQuery(query);
                    
                    if(rs1.next())
                    {
                    	 String resultAlert="Tanker not reached  in  "+rs1.getString(4)+"  ";
                    
                    
                    for (String mobileNumbers : alertNumbers) {
                        
                        out.println("MOBILENUMBERS"+mobileNumbers);     
                        System.out.println("***Alert Numbers****"+mobileNumbers);
                        NicSmsGateway sms = new NicSmsGateway();
                      
                        
                   String Result=  sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);
                        
                        
                        if(Result.equals("Deliverd"))
   		                  {
   		            	   stmt2=con.createStatement();
   	                       String inoutqry="insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,HABITATION_CODE ) values(?,SYSDATE,'PUSH','DR',?,?)";
   	                       System.out.println("inoutqry"+inoutqry);
   	                    PreparedStatement pst=con.prepareStatement(inoutqry);
   	                       pst.setString(1, mobileNumbers);
						pst.setString(2,  resultAlert);
						 pst.setString(3,rs1.getString(5));
   	                       pst.executeUpdate();
   	                       
   	                       
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
       