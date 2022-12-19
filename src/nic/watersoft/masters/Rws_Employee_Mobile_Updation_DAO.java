package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_Employee_Mobile_Updation_DAO

{
	public ArrayList getEmployeeIds(Rws_Employee_Mobile_Updation_Form myForm){
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset=null;
		ArrayList eids=new  ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="select EMPLOYEE_CODE,EMPLOYEE_NAME  from RWS_EMPLOYEE_TBL where substr(OFFICE_CODE,2,2)='"+myForm.getCircleOfficeCode()+"' and substr(OFFICE_CODE,4,1)='"+myForm.getDivisionOfficeCode()+"' and substr(OFFICE_CODE,5,2)='"+myForm.getSubDivisionOfficeCode()+"'";
			
			rset = stmt.executeQuery(query);
			// System.out.println("circle offices in rwsmasterdata"+query);
			while (rset.next()) {
				Rws_Employee_Mobile_Updation_Form labelValueBean = new Rws_Employee_Mobile_Updation_Form();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				eids.add(labelValueBean);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return eids;
		
	}
public String getEmployeeName(Rws_Employee_Mobile_Updation_Form myForm){
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset=null;
		String ename="";
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="select EMPLOYEE_CODE,EMPLOYEE_NAME  from RWS_EMPLOYEE_TBL where substr(OFFICE_CODE,2,2)='"+myForm.getCircleOfficeCode()+"' and substr(OFFICE_CODE,4,1)='"+myForm.getDivisionOfficeCode()+"' and substr(OFFICE_CODE,5,2)='"+myForm.getSubDivisionOfficeCode()+"' and EMPLOYEE_CODE='"+myForm.getEmployeeId()+"'";
			
			rset = stmt.executeQuery(query);
			 System.out.println("Employeename"+query);
			while (rset.next()) {
				ename=rset.getString(2);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		return ename;
		
	}
public String updateMobile(Rws_Employee_Mobile_Updation_Form myForm)
			throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		Statement stmt = null;
		String message="";

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query="update RWS_EMPLOYEE_TBL set  MOBILE=? where substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and substr(OFFICE_CODE,5,2)=? and EMPLOYEE_CODE=?";
			PreparedStatement ps= conn.prepareStatement(query);
			ps.setString(1,myForm.getEmployeeMobile());
			ps.setString(2, myForm.getCircleOfficeCode());
			ps.setString(3, myForm.getDivisionOfficeCode());
			ps.setString(4, myForm.getSubDivisionOfficeCode());
			ps.setString(5,myForm.getEmployeeId());
			rcount = ps.executeUpdate();
			if(rcount>0){
				message="Mobile Number Updated Sucessfully";
			}
			else{
				message="Mobile Number Updation Failed";
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return message;
	}

	

	
}