package nic.watersoft.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import nic.watersoft.commons.RwsOffices;

public class OTPGeneration {
	public int generatePin() throws Exception {
		Random generator = new Random();
		generator.setSeed(System.currentTimeMillis());
		  
		int num = generator.nextInt(899999) + 100000;
		if (num < 100000 || num > 999999) {
		num = generator.nextInt(899999) + 100000;
		if (num < 100000 || num > 999999) {
		throw new Exception("Unable to generate PIN at this time..");
		}
		}
		return num;
	}
	

	public String getMobile(String userid) {
		String mobile="";
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		Connection connection=null;
		try{
			connection=RwsOffices.getConn();
	
			String query="select nvl(MOBILE_NO,0) AS MOBILE_NO from rws_password_tbl where USER_ID=? ";
			statement=connection.prepareStatement(query);
			statement.setString(1, userid);
			resultSet=statement.executeQuery();
			if(resultSet.next()){
				mobile=resultSet.getString("MOBILE_NO");
			}
			resultSet.close();
			statement.close();
		}
		catch(Exception e){
			System.out.println("Exception in getMobile of OTPGeneration- "+e);
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				System.out.println("Exception in getMobile of OTPGeneration- "+e);
			}
		}
		return mobile;
	}
	public int sveOtp(String userid,String mobile,int otp) {
		int n=0;
		PreparedStatement pstmt=null;
		Connection connection=null;
		try{
			
			connection=RwsOffices.getConn();
			System.out.println(otp);
			String query="insert into RWS_OTP_TBL values(?,?,?,sysdate)";
			pstmt=connection.prepareStatement(query);
			pstmt.setString(1, userid);
			pstmt.setString(2, mobile);
			pstmt.setInt(3, otp);
			n=pstmt.executeUpdate();
			
		}
		catch(Exception e){
			System.out.println("Exception in sveOtp of OTPGeneration- "+e);
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				System.out.println("Exception in sveOtp of OTPGeneration- "+e);
			}
		}
		return n;
	}
	public String getOtp(String userId) {
		String otp="";
		PreparedStatement statement=null,statement1=null;
		ResultSet resultSet=null,resultSet1=null;
		Connection connection=null;
		try{
			
			connection=RwsOffices.getConn();
			
			String query="select TO_CHAR(max(timeofotp), 'MM-DD-YYYY HH24:MI:SS PM') as timeofotp from rws_otp_tbl where user_id=? ";
			statement=connection.prepareStatement(query);
			statement.setString(1, userId);
			resultSet=statement.executeQuery();
			if(resultSet.next()){
				String otpQuery="select otp from rws_otp_tbl where to_char(timeofotp,'MM-DD-YYYY HH24:MI:SS PM')=? ";
				statement1=connection.prepareStatement(otpQuery);
				statement1.setString(1, resultSet.getString("timeofotp"));
				resultSet1=statement1.executeQuery();
				if(resultSet1.next()){
					otp=resultSet1.getString("otp");
				}
			}
		}
		catch(Exception e){
			System.out.println("Exception in getOtp of OTPGeneration- "+e);
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				
				System.out.println("Exception in getOtp of OTPGeneration- "+e);
			}
		}
		return otp;
	}
}
