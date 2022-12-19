package nic.watersoft.smsmobile;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author NICMADHU
 */
public class MobileAutntication 
{
    

 public static int MobileAuthentication(String mobile) throws SQLException
 {
 
	 Connection con=null;
	// con= RwsOffices.getConn();
	 DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
	 //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.67:1521:orcl","aprwssuser","aprwssuser");
	 con=DriverManager.getConnection("jdbc:oracle:thin:@10.96.36.23:1521:wsoft","aprwssuser","aprwssuser");
     PreparedStatement ps=null;
     ResultSet rs=null;
     int returnResult=0;      
             
     try
     {
 //Driver
    System.out.println("MOBILE"+mobile); 	 
     ps=con.prepareStatement("select * from RWS_MOBILE_SMS_REGISTER_TBL where MOBILE='"+mobile+"' and AUTH_USER_REGISTRATION='Y' ");
     
     rs=ps.executeQuery();
     if(rs.next()) returnResult=1;
     
     
     }
     
     catch(Exception ex)
     {
    	 ex.printStackTrace();
     System.out.println("Exception"+ex);    
     }
     
     finally
     {
    // con.close();
   //  ps.close();
     
     }
 
 return returnResult;
 
 }





 public static String getHabitationCode(String mobile) throws SQLException
 {
 
	// System.out.println("mobile &&&&"+mobile);
	 Connection con=null;
	 DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
	 con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.67:1521:orcl","aprwssuser","aprwssuser");
	 //con=DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","aprwssuser","aprwssuser");
     PreparedStatement ps=null;
     ResultSet rs=null;
     String  returnResult="";      
             
     try
     {
    //Driver
     ps=con.prepareStatement("select HABITATION_CODE from RWS_MOBILE_SMS_REGISTER_TBL where MOBILE='"+mobile+"'  ");
     
     rs=ps.executeQuery();
    
     if(rs.next()) returnResult=rs.getString(1);
     
     }
     
     catch(Exception ex)
     {
     ex.printStackTrace();    
     }
     
     finally
     {
   //  con.close();
    // ps.close();
     
     }
 
 return returnResult;
 
 }



}






