package nic.watersoft.masters;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.sql.DataSource;

import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.sql.ResultSet;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class RwsQCAgencyData {
	String errorMessage;
	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	Connection conn = null;
	Statement stmt = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	Statement stmt4 = null;
	ResultSet rs = null;
	ResultSetMetaData rsm = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;

	PreparedStatement ps = null;

	public void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The Exception in rwsMasterData" + e);
			}
			rs4 = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			conn = null;
		}

	}

	
	
	//09082121
	public String insertQCAgencyDetails(DataSource dataSource, String agent_code, String agent_name,String FinacialYear, String uid)	throws Exception {
		String query = "";
		String msg = "", age_code="";
		boolean codeAlreadyExists = false;
		QCAgencyForm QCAMaster = null;
		int rcount = 0;
		try {
		  if(uid.equals("admin") || uid.equals("100000")) {
			conn = RwsOffices.getConn();
			query = "SELECT R.AGENCY_NAME FROM RWS_QC_AGENCY_TBL R WHERE R.AGENCY_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, agent_code);
			rs = ps.executeQuery(); 
			if(rs.next()) {
				msg = "Duplicate Code: Code Already  assigned to " + rs.getString("AGENCY_NAME") + ". Try Again";
				//System.out.println("msg :"+msg);
				codeAlreadyExists = true;
			}
			if (!codeAlreadyExists) {
				
				String FY = FinacialYear; //System.out.println("FY :"+FY);
				String FY1 = FY.substring(2, 4);// System.out.println("FY1 :"+FY1);
				String FY2 = FY.substring(7);// System.out.println("FY1 :"+FY2);
				
				//Agent Code Auto Generation
				query = "SELECT (CASE WHEN LENGTH(AUTO_AGE_CODE)=1 THEN '000'||AUTO_AGE_CODE WHEN LENGTH(AUTO_AGE_CODE)=2 THEN '00'||AUTO_AGE_CODE WHEN LENGTH(AUTO_AGE_CODE)=3 THEN '0'||AUTO_AGE_CODE ELSE AUTO_AGE_CODE END) AUTO_AGE_CODE FROM (SELECT TO_CHAR(NVL(MAX(TO_NUMBER(AGENCY_CODE)),0)+1) AUTO_AGE_CODE FROM RWS_QC_AGENCY_TBL Y)";
				ps = conn.prepareStatement(query);
				rs = ps.executeQuery(); 
				if(rs.next()){
					age_code=rs.getString("AUTO_AGE_CODE");//System.out.println("age_code :"+age_code);
				}
				query = "INSERT INTO RWS_QC_AGENCY_TBL(AGENCY_CODE,AGENCY_NAME,ENTRY_UID,STATUS,FINANCIAL_YEAR) VALUES(?,?,?,?,?)";
				//System.out.println("query :"+query);
				ps = conn.prepareStatement(query);
				//ps.setString(1, agent_code.toUpperCase());
				ps.setString(1, age_code);
				ps.setString(2, agent_name.toUpperCase());
				ps.setString(3, uid);//System.out.println("uid :"+uid);
				ps.setString(4, "I");
				ps.setString(5, FinacialYear);
				rcount = ps.executeUpdate();
				if (rcount > 0)
				{
					msg = "Record Inserted Successfully~"+age_code;
				}
				else
					msg = "Record Cannot be inserted~*";
			}
		  }
			 else
				{
				 msg = "Request cannot be processed at this level~*";
				}
		} catch (Exception e) {
			Debug.println("The Exception in insertNewQCAgentDetails = RwsQCAgencyData" + e);
			msg = "Record Cannot be inserted~*";
		} finally {
			closeAll();
		}
		return msg;
	}
	
	public ArrayList getQCAgeDetails() throws Exception {
		QCAgencyForm QCAMaster = null;
		ArrayList qcAgeDetails = new ArrayList();
		String query = "";
		try {
			conn = RwsOffices.getConn();
			query = "SELECT T.FINANCIAL_YEAR,T.AGENCY_CODE,T.AGENCY_NAME FROM RWS_QC_AGENCY_TBL T WHERE T.STATUS='I' ORDER BY FINANCIAL_YEAR,TO_NUMBER(T.AGENCY_CODE)";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while (rs.next()) {
				QCAMaster = new QCAgencyForm();
				QCAMaster.setFinyear(rs.getString("FINANCIAL_YEAR"));//System.out.println("rs.getString(FINANCIAL_YEAR) :"+rs.getString("FINANCIAL_YEAR"));
				QCAMaster.setAgencycode(rs.getString("AGENCY_CODE"));//System.out.println("rs.getString(AGENCY_CODE) :"+rs.getString("AGENCY_CODE"));
				QCAMaster.setAgencyname(rs.getString("AGENCY_NAME"));//System.out.println("rs.getString(AGENCY_NAME) :"+rs.getString("AGENCY_NAME"));
				qcAgeDetails.add(QCAMaster);
			}
		} catch (Exception e) {
			Debug.println("The Exception at getQCAgentDetails In RwsQCAgencyData" + e);
		} finally {
			closeAll();
		}
		return qcAgeDetails;
	}
	
	public String getQCAgencyName(String ageCode, String ageName)
	{
		String query = "",agename="",financeyear="";
		try
		{
		conn = RwsOffices.getConn();
		query = "SELECT T.AGENCY_NAME,T.FINANCIAL_YEAR FROM RWS_QC_AGENCY_TBL T WHERE T.AGENCY_CODE=?";
		ps = conn.prepareStatement(query);
		ps.setString(1, ageCode);
		rs = ps.executeQuery();
		while(rs.next())
		{
			agename = rs.getString("AGENCY_NAME");
			financeyear= rs.getString("FINANCIAL_YEAR");
		}
		}
		catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeCodeFromMandal()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDivisionOfficeCodeFromMandal");}
			}
		}
		return agename;
	}
	
	public String updateQCAgencyDetails(DataSource dataSource, String agent_code, String agent_name,String FinancialYear)	throws Exception {
		String query = "";
		String msg = "";
		//boolean codeAlreadyExists = false;
		int rcount = 0;
		try {
			    conn = RwsOffices.getConn();
				query = "UPDATE RWS_QC_AGENCY_TBL SET AGENCY_NAME=? WHERE AGENCY_CODE=?";			
				ps = conn.prepareStatement(query);
				ps.setString(1, agent_name.toUpperCase());
				ps.setString(2, agent_code);
				//ps.setString(3, FinancialYear);
				/*System.out.println(agent_name+"--"+agent_code+"query :"+query);*/
				rcount = ps.executeUpdate();
				if (rcount > 0)
					msg = "Record Updated Successfully";
				else
					msg = "Record Cannot be Updated";
		} catch (Exception e) {
			Debug.println("The Exception in UpdateQCAgentDetails = RwsQCAgencyData" + e);
			msg = "Record Cannot be Updated";
		} finally {
			closeAll();
		}
		return msg;
	}
	
	public static String deleteQCAgentDetails(String AgentCode) {
		int rowCount;
		String message = "";
		rowCount = 0;
		PreparedStatement stmt = null, stmt1 = null;
		ResultSet rs = null;
		Connection conn = null;
		try {
			    conn = RwsOffices.getConn();
				String qry1 = "UPDATE RWS_QC_AGENCY_TBL T SET T.STATUS='UI' WHERE T.AGENCY_CODE=? AND 0=(SELECT COUNT(*) FROM RWS_TP_QUALITY_CONTROL_TBL Q WHERE Q.AGENCY_CODE=T.AGENCY_CODE)";
				stmt = conn.prepareStatement(qry1);
				/*System.out.print(AgentCode);*/
				stmt.setString(1, AgentCode);
				rowCount = stmt.executeUpdate();

				if (rowCount > 0)
					message = "Record Deleted Successfully";
				else
					message = "Record Can't be deleted";

		} catch (Exception e) {
			System.out.println("exception in deleteQCDetails method of deleteQCAgentDetails" + e);
		}

		return message;
	}
	
	
	public String getAgency_Code()
	{
		String query = "",agecode="";
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT (CASE WHEN LENGTH(AUTO_AGE_CODE)=1 THEN '000'||AUTO_AGE_CODE WHEN LENGTH(AUTO_AGE_CODE)=2 THEN '00'||AUTO_AGE_CODE WHEN LENGTH(AUTO_AGE_CODE)=3 THEN '0'||AUTO_AGE_CODE ELSE AUTO_AGE_CODE END) AUTO_AGE_CODE FROM (SELECT TO_CHAR(NVL(MAX(TO_NUMBER(AGENCY_CODE)),0)+1) AUTO_AGE_CODE FROM RWS_QC_AGENCY_TBL Y)";		
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			while(rs.next())
			{
				agecode = rs.getString("AUTO_AGE_CODE");//System.out.println("DAO agecode :"+agecode);
			}
		}
		catch (Exception e) {
			// System.out.println("exception in getDivisionOfficeCodeFromMandal()"+e);}
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				// System.out.println("Exception in closing connections in getDivisionOfficeCodeFromMandal");}
			}
		}
		return agecode;
	}
}