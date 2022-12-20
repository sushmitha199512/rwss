package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import nic.watersoft.commons.RwsOffices;

public class Rws_Encrypt_Random_Generation {
	
	 public long  createRandomInteger(){
		 Random aRandom = new Random();
		int  aStart=1000000000;
		 long aEnd=9999999999L;
		 long randomNumber = 0 ;
		 try{
		 if ( aStart > aEnd ) {
		      throw new IllegalArgumentException("Starting value cannot exceed End Value.");
		    }
		    long range = aEnd - (long)aStart + 1;
		    long fraction = (long)(range * aRandom.nextDouble());
		     randomNumber =  fraction + (long)aStart;    
		 
		 }
		 catch(Exception e){
				System.out.println("Exception in createRandomInteger of Rws_Encrypt_Random_Generation-- "+e);
		 }
		return randomNumber;
	 }
	 public int generateEncryptRandomNumber() {
		 
			String mobile="",imei="";
			Statement statement=null,statement1=null;
			ResultSet resultSet=null;
			Connection connection=null;
			int n=0;
			try{
				connection=RwsOffices.getConn();
				statement=connection.createStatement();
				String query="select IMEI_NO,MOBILE from RWS_MOBILE_SMS_REGISTER_TBL where IMEI_NO is not null";
				resultSet=statement.executeQuery(query);
				while(resultSet.next()){
					imei=resultSet.getString("IMEI_NO");
					mobile=resultSet.getString("MOBILE");
					String firstHash = MakeHashUtils.sha256(imei);
					
					String secondHash = MakeHashUtils.sha256(firstHash);
					String smsRegUpdate="";
					String phoneNumberEncRand="";
					long rNo=createRandomInteger();
					
					smsRegUpdate="update RWS_MOBILE_SMS_REGISTER_TBL set MAPPING_CODE='"+rNo+"' where IMEI_NO='"+imei+"' and mobile='"+mobile+"'";
						statement1=connection.createStatement();
						n+=statement1.executeUpdate(smsRegUpdate);
						statement1.close();
						
						phoneNumberEncRand="insert into RWS_PHONE_ENCRP_TBL values('"+secondHash+"','"+rNo+"') ";
						statement1=connection.createStatement();
						statement1.executeUpdate(phoneNumberEncRand);
						statement1.close();
				}
				resultSet.close();
				statement.close();
			}
			catch(Exception e){
				System.out.println("Exception in generateEncryptRandomNumber of Rws_Encrypt_Random_Generation-- "+e);
			}
			finally{
				try {
				if(connection!=null){
					connection.close();
				} 
				}catch (SQLException e) {
					System.out.println("Exception in generateEncryptRandomNumber of Rws_Encrypt_Random_Generation-- "+e);
				}
			}
			return n;
		}
	 public int generateEncryptRandomNumber(String imei,long rNo) {
		
			
			Statement statement1=null;
			
			Connection connection=null;
			int n=0;
			try{
					connection=RwsOffices.getConn();
					String firstHash = MakeHashUtils.sha256(imei);
					String secondHash = MakeHashUtils.sha256(firstHash);
					String phoneNumberEncRand="";
					phoneNumberEncRand="insert into RWS_PHONE_ENCRP_TBL values('"+secondHash+"','"+rNo+"') ";
					
					statement1=connection.createStatement();
					statement1.executeUpdate(phoneNumberEncRand);
					statement1.close();
				
			}
			catch(Exception e){
				System.out.println("Exception in generateEncryptRandomNumber of Rws_Encrypt_Random_Generation-- "+e);
			}
			finally{
				try {
				if(connection!=null){
					connection.close();
				} 
				}catch (SQLException e) {
					System.out.println("Exception in generateEncryptRandomNumber of Rws_Encrypt_Random_Generation-- "+e);
				}
			}
			return n;
		}
	 public int generateEncryptRandomNumberUpdate(String imei,long rNo,String mobile) {
			
			
			Statement statement1=null;
			
			Connection connection=null;
			int n=0;
			try{
					connection=RwsOffices.getConn();
					String firstHash = MakeHashUtils.sha256(imei);
					String secondHash = MakeHashUtils.sha256(firstHash);
					String phoneNumberEncRand="";
					String updateQuery="";
					if(!isRandomExist(imei,mobile)){
						updateQuery="update RWS_MOBILE_SMS_REGISTER_TBL set MAPPING_CODE='"+rNo+"' where IMEI_NO='"+imei+"' and mobile='"+mobile+"'";
						statement1=connection.createStatement();
						statement1.executeUpdate(updateQuery);
						statement1.close();
						phoneNumberEncRand="insert into RWS_PHONE_ENCRP_TBL values('"+secondHash+"','"+rNo+"') ";
					}
					else{
						phoneNumberEncRand="update RWS_PHONE_ENCRP_TBL set PHONE_NO='"+secondHash+"' where mapping_code='"+getMappingCode(imei,mobile)+"' ";
					}
					statement1=connection.createStatement();
					statement1.executeUpdate(phoneNumberEncRand);
					statement1.close();
				
			}
			catch(Exception e){
				System.out.println("Exception in generateEncryptRandomNumberUpdate of Rws_Encrypt_Random_Generation-- "+e);
			}
			finally{
				try {
				if(connection!=null){
					connection.close();
				} 
				}catch (SQLException e) {
					System.out.println("Exception in generateEncryptRandomNumberUpdate of Rws_Encrypt_Random_Generation-- "+e);
				}
			}
			return n;
		}
	 public boolean isRandomExist(String imei,String mobile) {

			String sql = "select MAPPING_CODE from RWS_MOBILE_SMS_REGISTER_TBL where IMEI_NO='"+imei+"' and MOBILE='"+mobile+"' and MAPPING_CODE is not null  or MAPPING_CODE<>''";
			boolean flag = false;
			Statement statement=null;
			ResultSet resultSet=null;
			Connection connection=null;
			try{
				connection=RwsOffices.getConn();
				statement=connection.createStatement();
				resultSet=statement.executeQuery(sql);
				if (resultSet.next()) {
					flag = true;
				}
			} catch (Exception e) {
				System.out.println("Exception in isRandomExist of Rws_Encrypt_Random_Generation-- "+e);
			} finally {
				try {
					if (resultSet != null)
						resultSet.close();
					if (statement != null)
						statement.close();
					if (connection != null)
						connection.close();
				} catch (Exception e) {
					System.out.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}

			return flag;
		}
	 public String getMappingCode(String imei,String mobile) {

		 	String mappingCode="";
			String sql = "select MAPPING_CODE from RWS_MOBILE_SMS_REGISTER_TBL where IMEI_NO='"+imei+"' and mobile='"+mobile+"'";
			Statement statement=null;
			ResultSet resultSet=null;
			Connection connection=null;
			try{
				connection=RwsOffices.getConn();
				statement=connection.createStatement();
				resultSet=statement.executeQuery(sql);
				if (resultSet.next()) {
					mappingCode=resultSet.getString("MAPPING_CODE");
				}
			} catch (Exception e) {
				System.out.println("Exception in getMappingCode of Rws_Encrypt_Random_Generation-- "+e);
			} finally {
				try {
					if (resultSet != null)
						resultSet.close();
					if (statement != null)
						statement.close();
					if (connection != null)
						connection.close();
				} catch (Exception e) {
					System.out.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}

			return mappingCode;
		}
}
