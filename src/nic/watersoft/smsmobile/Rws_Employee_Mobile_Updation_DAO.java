package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.complaints.Ur_Employee_Mobile_Updation_Form;

public class Rws_Employee_Mobile_Updation_DAO

{
	public ArrayList getEmployeeIds(Rws_Employee_Mobile_Updation_Form myForm, String mode) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		ArrayList eids = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
		
			if (mode.equals("headOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from "
						+ "RWS_EMPLOYEE_TBL a,RWS_DESIGNATION_TBL b where a.designation_code=b.designation_code"
						+ " and OFFICE_CODE='100000'";
				stmt = conn.prepareStatement(query);
			} else if (mode.equals("circleOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from "
						+ "RWS_EMPLOYEE_TBL a,RWS_DESIGNATION_TBL b where  a.designation_code=b.designation_code "
						+ "and substr(OFFICE_CODE,2,2)=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCircleOfficeCode());
				
			} else if (mode.equals("divisionOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from "
						+ "RWS_EMPLOYEE_TBL a,RWS_DESIGNATION_TBL b where a.designation_code=b.designation_code"
						+ " and substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=?";
				
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCircleOfficeCode());
				stmt.setString(2,  myForm.getDivisionOfficeCode() );
				
			} else if (mode.equals("subDivisionOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from"
						+ " RWS_EMPLOYEE_TBL a,RWS_DESIGNATION_TBL b where   a.designation_code=b.designation_code and "
						+ "substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and substr(OFFICE_CODE,5,2)=?";
				
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCircleOfficeCode());
				stmt.setString(2,  myForm.getDivisionOfficeCode() );
				stmt.setString(3,   myForm.getSubDivisionOfficeCode()  );
			}
			rset = stmt.executeQuery();


			while (rset.next()) {
				Rws_Employee_Mobile_Updation_Form labelValueBean = new Rws_Employee_Mobile_Updation_Form();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				eids.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getEmployeeIds of  Rws_Employee_Mobile_Updation_DAO --"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (stmt!=null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getEmployeeIds of  Rws_Employee_Mobile_Updation_DAO --"+e);
			}
		}
		return eids;

	}

	public ArrayList getdisignatons(Rws_Employee_Mobile_Updation_Form myForm) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList eids = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "select DESIGNATION_CODE,DESIGNATION_NAME   from RWS_DESIGNATION_TBL ";

			rset = stmt.executeQuery(query);
			while (rset.next()) {
				Rws_Employee_Mobile_Updation_Form labelValueBean = new Rws_Employee_Mobile_Updation_Form();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				eids.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getdisignatons of  Rws_Employee_Mobile_Updation_DAO --"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (stmt!=null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getdisignatons of  Rws_Employee_Mobile_Updation_DAO --"+e);
			}
		}
		return eids;

	}

	public String getEmployeeName(Rws_Employee_Mobile_Updation_Form myForm) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String ename = "";
		try {
			conn = RwsOffices.getConn();
		
			String query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,nvl(MOBILE,'-'),b.DESIGNATION_NAME,OFFICE_CODE   from "
					+ "RWS_EMPLOYEE_TBL a,RWS_DESIGNATION_TBL b where a.DESIGNATION_CODE =b.DESIGNATION_CODE and "
					+ "EMPLOYEE_CODE=?";
			
			stmt = conn.prepareStatement(query);
			stmt.setString(1, myForm.getEmployeeId() );
			rset = stmt.executeQuery();
			
			
			while (rset.next()) {
				ename = rset.getString(2);
				ename = ename + "/" + rset.getString(3);
				ename = ename + "/" + rset.getString(4);
				ename = ename + "/" + rset.getString(5);

			}
		} catch (Exception e) {
			System.out.println("Exception in getEmployeeName of  Rws_Employee_Mobile_Updation_DAO --"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (stmt!=null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getEmployeeName of  Rws_Employee_Mobile_Updation_DAO --"+e);
			}
		}
		return ename;

	}

	public String updateMobile(Rws_Employee_Mobile_Updation_Form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "";

		try {
			conn = RwsOffices.getConn();
			
			query = "update RWS_EMPLOYEE_TBL set  MOBILE=? where EMPLOYEE_CODE=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1,myForm.getEmployeeMobile());
			stmt.setString(2, myForm.getEmployeeId() );
			rcount = stmt.executeUpdate();
			if (rcount > 0) {
				message = "Mobile Number Updated Sucessfully";
			} else {
				message = "Mobile Number Updation Failed";
			}

		} catch (Exception e) {
			System.out.println("Exception in updateMobile of  Rws_Employee_Mobile_Updation_DAO --"+e);
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

	public String updateofficedetils(Rws_Employee_Mobile_Updation_Form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "", officecode = "";

		try {
			conn = RwsOffices.getConn();
			

			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + 0 + 0 + 0;
			}
			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")
					&& myForm.getDivisionOfficeCode1() != null && !myForm.getDivisionOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + myForm.getDivisionOfficeCode1() + 0 + 0;
			}
			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")
					&& myForm.getDivisionOfficeCode1() != null && !myForm.getDivisionOfficeCode1().equals("")
					&& myForm.getSubDivisionOfficeCode1() != null && !myForm.getSubDivisionOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + myForm.getDivisionOfficeCode1()
						+ myForm.getSubDivisionOfficeCode1();
			}

			
			
			query = "update RWS_EMPLOYEE_TBL set   OFFICE_CODE=? ,DESIGNATION_CODE=? where EMPLOYEE_CODE=? ";
			
			stmt = conn.prepareStatement(query);
			stmt.setString(1, officecode);
			stmt.setString(2, myForm.getDesignations());
			stmt.setString(3,  myForm.getEmployeeId());
			
			rcount = stmt.executeUpdate();

			if (rcount > 0) {
				message = "Office and Employee Details are Updated Successfully";
			} else {
				message = "Office and Employee Details are Updation Failed";
			}

		} catch (Exception e) {
			System.out.println("Exception in updateofficedetils of  Rws_Employee_Mobile_Updation_DAO --"+e);
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

	public ArrayList getUrbanEmployeeIds(Ur_Employee_Mobile_Updation_Form myForm, String mode) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		ArrayList eids = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
		
			if (mode.equals("headOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from UR_EMPLOYEE_TBL a,"
						+ "UR_DESIGNATION_TBL b where a.designation_code=b.designation_code and OFFICE_CODE='100000'";
				stmt = conn.prepareStatement(query);
				
			} else if (mode.equals("circleOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from UR_EMPLOYEE_TBL a,"
						+ "UR_DESIGNATION_TBL b where  a.designation_code=b.designation_code and substr(OFFICE_CODE,2,2)=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1,myForm.getCircleOfficeCode() );
				
			} else if (mode.equals("divisionOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from UR_EMPLOYEE_TBL a,"
						+ "UR_DESIGNATION_TBL b where a.designation_code=b.designation_code and substr(OFFICE_CODE,2,2)=?"
						+ " and substr(OFFICE_CODE,4,1)=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1,myForm.getCircleOfficeCode() );
				stmt.setString(2,myForm.getDivisionOfficeCode()  );
				
			} else if (mode.equals("subDivisionOffice")) {
				query = "select EMPLOYEE_CODE,EMPLOYEE_NAME,DESIGNATION_NAME  from UR_EMPLOYEE_TBL a,"
						+ "UR_DESIGNATION_TBL b where   a.designation_code=b.designation_code and substr(OFFICE_CODE,2,2)=?"
						+ " and substr(OFFICE_CODE,4,1)=? and substr(OFFICE_CODE,5,2)=?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1,myForm.getCircleOfficeCode() );
				stmt.setString(2, myForm.getDivisionOfficeCode() );
				stmt.setString(3,myForm.getSubDivisionOfficeCode()  );
				 }
				rset = stmt.executeQuery();
				while (rset.next()) {
					Ur_Employee_Mobile_Updation_Form labelValueBean = new Ur_Employee_Mobile_Updation_Form();
					labelValueBean.setValue(rset.getString(1));
					labelValueBean.setLabel(rset.getString(2));
					labelValueBean
							.setLabelValue(rset.getString(2) + " - " + rset.getString(1) + "-" + rset.getString(3));
					eids.add(labelValueBean);
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return eids;

	}

	public ArrayList getUrbandisignatons(Ur_Employee_Mobile_Updation_Form myForm) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList eids = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "select DESIGNATION_CODE,DESIGNATION_NAME   from UR_DESIGNATION_TBL ";

			rset = stmt.executeQuery(query);
			while (rset.next()) {
				Ur_Employee_Mobile_Updation_Form labelValueBean = new Ur_Employee_Mobile_Updation_Form();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				eids.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return eids;

	}

	public String getUrbanEmployeeName(Ur_Employee_Mobile_Updation_Form myForm) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String ename = "";
		try {
			conn = RwsOffices.getConn();
		
			String query = "select EMPLOYEE_ID,EMPLOYEE_NAME,nvl(MOBILE_NO,'-'),b.DESIGNATION_NAME,OFFICE_CODE  "
					+ " from UR_EMPLOYEE_TBL a,UR_DESIGNATION_TBL b where "
					+ "a.DESIGNATION_CODE =b.DESIGNATION_CODE and EMPLOYEE_CODE=?";
			
			stmt = conn.prepareStatement(query);
			stmt.setString(1,  myForm.getEmployeeId() );
			rset = stmt.executeQuery();
			
			while (rset.next()) {
				ename = rset.getString(2);
				ename = ename + "/" + rset.getString(3);
				ename = ename + "/" + rset.getString(4);
				ename = ename + "/" + rset.getString(5);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return ename;

	}

	public String updateUrbanMobile(Ur_Employee_Mobile_Updation_Form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "";

		try {
			conn = RwsOffices.getConn();
		
			// query="update UR_EMPLOYEE_TBL set MOBILE_NO='"+myForm.getEmployeeMobile()+"'
			// where EMPLOYEE_ID='"+myForm.getEmployeeId()+"' ";
			query = "insert into  UR_EMPLOYEE_TBL (HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,"
					+ "SUBDIVISION_OFFICE_CODE,EMPLOYEE_ID,EMPLOYEE_NAME,MOBILE_NO) VALUES "
					+ "(?,?,?,?,?,?,?)";
			
			stmt = conn.prepareStatement(query);
			stmt.setString(1, "2");
			stmt.setString(2,myForm.getCircleOfficeCode() );
			stmt.setString(3, myForm.getDivisionOfficeCode() );
			stmt.setString(4,myForm.getSubDivisionOfficeCode()  );
			stmt.setString(5, myForm.getEmployeeId()  );
			stmt.setString(6, myForm.getEmployeeName() );
			stmt.setString(7,myForm.getEmployeeMobile() );
			
			rcount = stmt.executeUpdate();
			
			if (rcount > 0) {
				message = "Mobile Number Inserted Sucessfully";
			} else {
				message = "Mobile Number Insertion Failed";
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

	public String updateUrbanofficedetils(Ur_Employee_Mobile_Updation_Form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "", officecode = "";

		try {
			conn = RwsOffices.getConn();
		

			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + 0 + 0 + 0;
			}
			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")
					&& myForm.getDivisionOfficeCode1() != null && !myForm.getDivisionOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + myForm.getDivisionOfficeCode1() + 0 + 0;
			}
			if (myForm.getCircleOfficeCode1() != null && !myForm.getCircleOfficeCode1().equals("")
					&& myForm.getDivisionOfficeCode1() != null && !myForm.getDivisionOfficeCode1().equals("")
					&& myForm.getSubDivisionOfficeCode1() != null && !myForm.getSubDivisionOfficeCode1().equals("")) {
				officecode = 1 + myForm.getCircleOfficeCode1() + myForm.getDivisionOfficeCode1()
						+ myForm.getSubDivisionOfficeCode1();
			}

			
			query = "update UR_EMPLOYEE_TBL set   OFFICE_CODE=? ,DESIGNATION_CODE=? where EMPLOYEE_ID=?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, officecode);
			stmt.setString(2, myForm.getDesignations());
			stmt.setString(3,  myForm.getEmployeeId());
			
			rcount = stmt.executeUpdate();

			if (rcount > 0) {
				message = "Office and Employee Details are Updated Successfully";
			} else {
				message = "Office and Employee Details are Updation Failed";
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

	public Collection viewUrbanMobile(Ur_Employee_Mobile_Updation_Form myForm) {
		String query = "";
		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		Ur_Employee_Mobile_Updation_Form compForm = null;
		ArrayList list = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "select * from Ur_EMPLOYEE_TBL";
			rs = stmt.executeQuery(query);
			while (rs.next()) {

				compForm = new Ur_Employee_Mobile_Updation_Form();

				compForm.setEmployeeId(rs.getString("EMPLOYEE_ID"));
				compForm.setEmployeeName(rs.getString("EMPLOYEE_NAME"));
				// compForm.set
				compForm.setEmployeeMobile(rs.getString("MOBILE_NO"));
				compForm.setHeadOfficeCode("2");
				compForm.setCircleOfficeCode(rs.getString("CIRCLE_OFFICE_CODE"));
				compForm.setDivisionOfficeCode(rs.getString("DIVISION_OFFICE_CODE"));
				compForm.setSubDivisionOfficeCode(rs.getString("SUBDIVISION_OFFICE_CODE"));
				list.add(compForm);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}