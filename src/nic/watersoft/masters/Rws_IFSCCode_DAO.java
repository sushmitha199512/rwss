package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class Rws_IFSCCode_DAO {	
	
	public String saveIFSCCode(Rws_IFSCCode_Form ifscCode_Form) {
		String message="";
		int n=0;
		PreparedStatement statement=null;
		Connection connection=null;
		try{			
			connection=RwsOffices.getConn();
			if(isExist(ifscCode_Form.getIfscCode())){
				String query="insert into RWS_BANK_IFSC_CODE_TBL values(?,?,?,?,?,?,?,?)";
				statement=connection.prepareStatement(query);
				statement.setString(1, ifscCode_Form.getBankName());
				statement.setString(2, ifscCode_Form.getIfscCode());
				statement.setString(3, ifscCode_Form.getMicrCode());
				statement.setString(4, ifscCode_Form.getBranchName());
				statement.setString(5, ifscCode_Form.getAddress());
				statement.setString(6, ifscCode_Form.getContactNumber());
				statement.setString(7, ifscCode_Form.getCity());
				statement.setString(8, ifscCode_Form.getDistrict());
				n=statement.executeUpdate();
				if(n>0){
					message="Saved successfully";
				} else{
					message="Failed to Save";
				}
			} else{
				message="IFSC Code Already Exist";
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCode_DAO saveIFSCCode is  = "+e.getMessage());
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO saveIFSCCode is  = "+e.getMessage());
			}
		}
		return message;
	}
	
	private boolean isExist(String ifscCode) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset=null;
		String query1="";
		try{
			conn = RwsOffices.getConn();
			query1 = "select * from RWS_BANK_IFSC_CODE_TBL where IFSC_CODE= ? ";
			stmt = conn.prepareStatement(query1);
			stmt.setString(1, ifscCode);
			rset=stmt.executeQuery();
			if(rset.next()){				
				return false;
			} else{
				return true;
			}
		}
		catch (Exception e) {
			System.out.println("The Exception in Rws_IFSCCode_DAO isExist is  = "+e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO isExist is  = "+e.getMessage());
			}
		}
		return false;
	}
	
	public ArrayList getIfscDetails() {
		ArrayList ifscDetails=new ArrayList();		
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		Connection connection=null;
		try{		
			connection=RwsOffices.getConn();
			String query="select BANK,IFSC_CODE,MICR_CODE,BRANCH_NAME,ADDRESS,CONTACT,CITY,DISTRICT from RWS_BANK_IFSC_CODE_TBL";
			statement=connection.prepareStatement(query);
			resultSet=statement.executeQuery();
			while(resultSet.next()){
				Rws_IFSCCode_Form form=new Rws_IFSCCode_Form();
				form.setBankName(resultSet.getString("BANK"));
				form.setIfscCode(resultSet.getString("IFSC_CODE"));
				form.setMicrCode(resultSet.getString("MICR_CODE"));
				form.setBranchName(resultSet.getString("BRANCH_NAME"));
				form.setAddress(resultSet.getString("ADDRESS"));
				form.setContactNumber(resultSet.getString("CONTACT"));
				form.setCity(resultSet.getString("CITY"));
				form.setDistrict(resultSet.getString("DISTRICT"));
				ifscDetails.add(form);
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCode_DAO getIfscDetails is  = "+e.getMessage());
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO getIfscDetails is  = "+e.getMessage());
			}
		}	
		return ifscDetails;
	}
	
	public Rws_IFSCCode_Form getIfsc(String ifscCode) {		
		Rws_IFSCCode_Form ifscCode_Form=new  Rws_IFSCCode_Form();
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		Connection connection=null;
		try{			
			connection=RwsOffices.getConn();
			String query="select BANK,IFSC_CODE,MICR_CODE,BRANCH_NAME,ADDRESS,CONTACT,CITY,DISTRICT from RWS_BANK_IFSC_CODE_TBL where IFSC_CODE= ?";
			statement=connection.prepareStatement(query);
			statement.setString(1, ifscCode);
			resultSet=statement.executeQuery();
			if(resultSet.next()){				
				ifscCode_Form.setBankName(resultSet.getString("BANK"));
				ifscCode_Form.setIfscCode(resultSet.getString("IFSC_CODE"));
				ifscCode_Form.setMicrCode(resultSet.getString("MICR_CODE"));
				ifscCode_Form.setBranchName(resultSet.getString("BRANCH_NAME"));
				ifscCode_Form.setAddress(resultSet.getString("ADDRESS"));
				ifscCode_Form.setContactNumber(resultSet.getString("CONTACT"));
				ifscCode_Form.setCity(resultSet.getString("CITY"));
				ifscCode_Form.setDistrict(resultSet.getString("DISTRICT"));				
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCode_DAO getIfsc is  = "+e.getMessage());
		}
		finally{
			try {
			if(connection!=null){
				connection.close();
			} 
			}catch (SQLException e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO getIfsc is  = "+e.getMessage());
			}
		}		
		return ifscCode_Form;
	}
	
	public String updateIfscDetails(Rws_IFSCCode_Form form) {
		String message="";
		PreparedStatement statement=null;
		Connection connection=null;
		try{			
			connection=RwsOffices.getConn();
			String query="update RWS_BANK_IFSC_CODE_TBL set BANK=? ,MICR_CODE=? ,BRANCH_NAME=? ,ADDRESS=? ,CONTACT=? ,CITY=? ,DISTRICT= ?  where IFSC_CODE= ? ";
			statement=connection.prepareStatement(query);
			statement.setString(1, form.getBankName());
			statement.setString(2, form.getMicrCode());
			statement.setString(3, form.getBranchName());
			statement.setString(4, form.getAddress());
			statement.setString(5, form.getContactNumber());
			statement.setString(6, form.getCity());
			statement.setString(7, form.getDistrict());
			statement.setString(8, form.getIfscCode());
			int n=statement.executeUpdate();
			if(n>0){
				message="Updated successfully";
			} else{
				message="Failed to Update";
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCode_DAO updateIfscDetails is  = "+e.getMessage());
		}
		finally{
			try {
				if(connection!=null){
					connection.close();
				} 
			}catch (SQLException e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO updateIfscDetails is  = "+e.getMessage());
			}
		}
		return message;
	}
	
	public String removeIfscDetails(String ifscCode) {		
		String message="";
		PreparedStatement statement=null;
		Connection connection=null;
		try{			
			connection=RwsOffices.getConn();
			String query="delete from RWS_BANK_IFSC_CODE_TBL where IFSC_CODE= ?";
			statement=connection.prepareStatement(query);
			statement.setString(1, ifscCode);
			int n=statement.executeUpdate();
			if(n>0){
				message="Deleted successfully";
			}
			else{
				message="Failed to Delete";
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCode_DAO removeIfscDetails is  = "+e.getMessage());
		}
		finally{
			try {
				if(connection!=null){
					connection.close();
				} 
			}catch (SQLException e) {
				System.out.println("The Exception in Rws_IFSCCode_DAO removeIfscDetails is  = "+e.getMessage());
			}
		}
		return message;
	}
}
