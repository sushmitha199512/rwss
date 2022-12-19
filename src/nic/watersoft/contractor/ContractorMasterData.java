package nic.watersoft.contractor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class ContractorMasterData {
	Connection conn = null;

	Statement stmt = null;

	Statement stmt1 = null;

	Statement stmt2 = null;

	Statement stmt3 = null;

	Statement stmt4 = null;

	Statement stmt5 = null;

	Statement stmt6 = null;

	Statement stmt7 = null;

	Statement stmt8 = null;

	Statement stmt9 = null;

	Statement stmt10 = null;

	Statement stmt11 = null;

	Statement stmt12 = null;

	Statement stmt13 = null;

	Statement stmt14 = null;

	Statement stmt15 = null;

	Statement stmt16 = null;

	Statement stmt17 = null;

	Statement stmt18 = null;

	Statement stmt19 = null;

	Statement stmt20 = null;

	Statement stmt21 = null;

	Statement stmt22 = null;

	Statement stmt23 = null;

	Statement stmt24 = null;

	ResultSet rs = null;

	ResultSet rset = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	ResultSet rs5 = null;

	ResultSet rs6 = null;

	ResultSet rs7 = null;

	ResultSet rs8 = null;

	ResultSet rs9 = null;

	ResultSet rs10 = null;

	ResultSet rs11 = null;

	ResultSet rs12 = null;

	ResultSet rs13 = null;

	ResultSet rs14 = null;

	ResultSet rs15 = null;

	ResultSet rs16 = null;

	ResultSet rs17 = null;

	ResultSet rs18 = null;

	ResultSet rs19 = null;

	ResultSet rs20 = null;

	ResultSet rs21 = null;

	ResultSet rs22 = null;

	ResultSet rs23 = null;

	ResultSet rs24 = null;

	int connCount = 0;

	PreparedStatement ps = null;

	public ContractorMasterData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		Statement stmt6 = null;
		Statement stmt7 = null;
		Statement stmt8 = null;
		Statement stmt9 = null;
		Statement stmt10 = null;
		Statement stmt11 = null;
		Statement stmt12 = null;
		Statement stmt13 = null;
		Statement stmt14 = null;
		Statement stmt15 = null;
		Statement stmt16 = null;
		Statement stmt17 = null;
		Statement stmt18 = null;
		Statement stmt19 = null;
		Statement stmt20 = null;
		Statement stmt21 = null;
		Statement stmt22 = null;
		Statement stmt23 = null;
		Statement stmt24 = null;
		ResultSet rs = null;
		ResultSet rset = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs8 = null;
		ResultSet rs9 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		ResultSet rs14 = null;
		ResultSet rs15 = null;
		ResultSet rs16 = null;
		ResultSet rs17 = null;
		ResultSet rs18 = null;
		ResultSet rs19 = null;
		ResultSet rs20 = null;
		ResultSet rs21 = null;
		ResultSet rs22 = null;
		ResultSet rs23 = null;
		ResultSet rs24 = null;
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in contractorMasterData" + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}

	public boolean workidExists(String workid) {
		boolean exists = false;
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		ContractorForm contractorForm = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			query = "select work_id from rws_work_exp_voucher_tbl where work_id=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs1 = ps.executeQuery();

			if (rs1.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
			Debug.println("Exception workidExists of ContractorMasterData" + e);
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (ps != null)
					ps.close();
				
			} catch (Exception e) {
				Debug.println("Exception in workidExists Closing of ContractorMasterData"
						+ e);
			}
		}
		return exists;
	}

	public int updateContractorworks(String workid, String contractor)
			throws Exception {
		int count = 0;
		boolean exists = false;
		PreparedStatement pst = null, pst1 = null;
		ContractorMasterData contractorMasterData = new ContractorMasterData();

		try {
			conn = RwsOffices.getConn();

			String query = "update rws_contractor_selection_tbl set contractor_code=? where work_id=? ";

			pst = conn.prepareStatement(query);
			pst.setString(1, contractor);
			pst.setString(2, workid);

			count = pst.executeUpdate();

			if (workidExists(workid)) {

				conn = RwsOffices.getConn();

				String query1 = "update rws_work_exp_voucher_tbl set contractor_code=? where work_id=?";
				pst1 = conn.prepareStatement(query1);
				pst1.setString(1, contractor);
				pst1.setString(2, workid);
				count = pst1.executeUpdate();
			}

			if (count > 0) {
				conn.commit();
			} else {
				conn.rollback();
			}
		} catch (Exception e) {
			
			System.out.println("Exception in updateContractorworks of ContractorMasterData is "+ e);
	
		} finally {
			if (pst != null)
				pst.close();
			if (pst1 != null)	
				pst1.close();
			if (conn != null) 
				conn.close();
		}

		return count;
	}

	public ArrayList getCircles(String headOfficeCode) throws Exception {
		ArrayList circles = new ArrayList();
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		LabelValueBean contractorForm = null;
		String query = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct substr(ne.office_code,2,2) as circleoffcode,circle_office_name  "
					+ "from rws_work_admn_tbl ne, rws_circle_office_tbl co "
					+ "where substr(ne.office_code,2,2)=co.circle_office_code and substr(ne.office_code,1,1)=? order by circle_office_name";

			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);

			rs = ps.executeQuery();

			while (rs.next()) {
				contractorForm = new LabelValueBean();
				contractorForm.setValue(rs.getString(1));
				contractorForm.setLabel(rs.getString(2));
				contractorForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				circles.add(contractorForm);
			}
		} catch (Exception e) {
			System.out
					.println("Exception in getCircles of ContractorMasterData is "
							+ e);
		} finally {
			try {
				contractorMasterData.closeAll();
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing of ContractorMasterData"
						+ e);
			}
		}
		return circles;
	}

	public String getCircleName(String headOfficeCode, String circle)
			throws Exception {
		ArrayList circles = new ArrayList();
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		ContractorForm contractorForm = null;
		String query = null;
		String name = "";
		try {
			conn = RwsOffices.getConn();
			query = "select distinct circle_office_name  from rws_circle_office_tbl where head_office_code=? and  circle_office_code=? order by circle_office_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circle);

			rs = ps.executeQuery();
			while (rs.next()) {

				name = rs.getString(1);
			}

		} catch (Exception e) {
			System.out
					.println("Exception in getCircleName of ContractorMasterData is "
							+ e);
		} finally {
			try {
				contractorMasterData.closeAll();
			} catch (Exception e) {
				Debug.println("Get Circles Exception ContractorMasterData in Closing ");
			}
		}
		return name;
	}

	public ArrayList getDivisions(String headofficecode, String circle)
			throws Exception {
		ArrayList circles = new ArrayList();
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		LabelValueBean contractorForm = null;
		String query = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct division_office_code,division_office_name  from rws_division_office_tbl "
					+ "where head_office_code=? and circle_office_code=? order by division_office_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, headofficecode);
			ps.setString(2, circle);

			rs = ps.executeQuery();
			while (rs.next()) {
				contractorForm = new LabelValueBean();
				contractorForm.setValue(rs.getString(1));
				contractorForm.setLabel(rs.getString(2));
				contractorForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				circles.add(contractorForm);
			}
		} catch (Exception e) {
			System.out
					.println("Exception in getDivisions ContractorMasterData is "
							+ e);
		} finally {
			try {
				contractorMasterData.closeAll();
			} catch (Exception e) {
				Debug.println(" getDivisions Exception ContractorMasterData in Closing ");
			}
		}
		return circles;
	}

	public ArrayList getWorkcontractordetails(String workid) throws Exception {
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		ArrayList works = new ArrayList();
		ContractorForm contractorForm = null;

		String query = "";

		try {

			conn = RwsOffices.getConn();

			query = "select c.work_id,c.work_name,c.admin_no,to_char(c.admin_date,'dd/mm/yyyy'),"
					+ "c.sanction_amount,a.contractor_code,a.contractor_name_company,c.office_code from  "
					+ "rws_contractor_tbl  a,rws_contractor_selection_tbl b,rws_work_admn_tbl c where c.work_id=b.work_id "
					+ "and b.contractor_code=a.contractor_code and c.work_id=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs = ps.executeQuery();

			while (rs.next()) {

				contractorForm = new ContractorForm();

				contractorForm.setWorkId(rs.getString(1));
				contractorForm.setWorkName(rs.getString(2));
				contractorForm.setAdminNo(rs.getString(3));
				contractorForm.setAdminDate(rs.getString(4));
				contractorForm.setSanctionAmount(rs.getString(5));
				contractorForm.setContractorCode(rs.getString(6));
				contractorForm.setContractorName(rs.getString(7));
				contractorForm.setOfficeEntered(rs.getString(8));

				works.add(contractorForm);
			}
		} catch (Exception e) {
			Debug.println("The error in getWorkcontractordetails of ContractorMasterData="
					+ e);
		} finally {
			contractorMasterData.closeAll();
		}
		return works;
	}

	public ArrayList getWorkdetailscircledivisionwise(String circle,
			String division) throws Exception {
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		ArrayList works = new ArrayList();
		ContractorForm contractorForm = null;

		String query = "";

		try {

			conn = RwsOffices.getConn();

			query = "select c.work_id,c.work_name,c.office_code,a.contractor_code,a.contractor_name_company from "
					+ " rws_contractor_tbl  a,rws_contractor_selection_tbl b,rws_work_admn_tbl c where c.work_id=b.work_id"
					+ " and b.contractor_code=a.contractor_code and substr(c.office_code,2,2)=? and"
					+ " substr(c.office_code,4,1)=? and c.work_cancel_dt is null ";

			ps = conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, division);
			rs = ps.executeQuery();

			while (rs.next()) {

				contractorForm = new ContractorForm();

				contractorForm.setWorkId(rs.getString(1));
				contractorForm.setWorkName(rs.getString(2));

				contractorForm.setOfficeEntered(rs.getString(3));
				contractorForm.setContractorCode(rs.getString(4));
				contractorForm.setContractorName(rs.getString(5));

				works.add(contractorForm);
			}
		} catch (Exception e) {
			Debug.println("Exception in getWorkdetailscircledivisionwise of ContractorMasterData ="
					+ e);
		} finally {
			contractorMasterData.closeAll();
		}
		return works;
	}

	public ArrayList getContractordetails(String name) throws Exception {
		ArrayList contractors = new ArrayList();
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		LabelValueBean contractorForm = null;
		String query = "";
		String sname = name + "%";
		try {
			conn = RwsOffices.getConn();

			query = "SELECT distinct  contractor_code,CONTRACTOR_NAME_COMPANY  FROM rws_contractor_tbl "
					+ "where contractor_name_company like '" + sname + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				contractorForm = new LabelValueBean();
				contractorForm.setValue(rs.getString(1));
				contractorForm.setLabel(rs.getString(2));
				contractorForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				contractors.add(contractorForm);
			}
		} catch (Exception e) {
			Debug.println("The error in contractors=" + e);
		} finally {
			contractorMasterData.closeAll();
		}

		return contractors;
	}
}
