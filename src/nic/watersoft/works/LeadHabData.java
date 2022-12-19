package nic.watersoft.works;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class LeadHabData {

	
	Connection conn = null;

	

	ResultSet rs1 = null;
	ResultSet rs = null;
	
	PreparedStatement ps = null;

	public LeadHabData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		
		ResultSet rs = null;
		ResultSet rs1 = null;
		
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in leadHabData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in leadHabData" + e);
			}
			rs1 = null;
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
				
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}

	}

	
	public boolean isExists(String workid) {
		boolean exists = false;

		try {
			conn = RwsOffices.getConn();

			

			String qq = "select asset_code from RWS_asset_mast_tbl  where asset_code=?";
			ps = conn.prepareStatement(qq);
			ps.setString(1, workid);
			rs1 = ps.executeQuery();

			if (rs1.next()) {
				exists = true;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists"+e);

		} finally {
			try {
				closeAll();
			} catch (Exception se) {
				System.out.println("Exception in finnally block of isExists"
						+ se);
			}
		}
		return exists;

	}
	
	public boolean isCompleted(String workid) {
		boolean completed = false;
		try {
			conn = RwsOffices.getConn();
			String qq = "select work_id from RWS_WORK_COMPLETION_TBL where DATE_OF_COMPLETION is not null and WORK_ID=?";
			ps = conn.prepareStatement(qq);
			ps.setString(1, workid);
			rs1 = ps.executeQuery();
			if (rs1.next()) {
				completed = true;
			}
		} catch (Exception e) {
			System.out.println("Exception in isCompleted" + e);
		} finally {
			try {
				closeAll();
			} catch (Exception se) {
				System.out.println("Exception in finnally block of isCompleted"
						+ se);
			}
		}
		return completed;
	}
	public int updateLeadHab(LeadHabForm dr, String habcode) throws Exception {
		int count = 0;
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String query = "update rws_work_admn_tbl set lead_habitation=?  where work_id=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2,  dr.getWorkId());
			count = ps.executeUpdate();
			if (count > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else {
				conn.rollback();
			}
			Debug.println("count" + count);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();

		}
		return count;

	}
	public ArrayList getWorksdetails(String workid) throws Exception {
		ArrayList works = works = new ArrayList();

		LeadHabForm leadHabForm = null;

		String query = "";
		String name = "";
		try {
			conn = RwsOffices.getConn();
			
			query = "select work_id,work_name,nvl(lead_habitation,'-') from rws_work_admn_tbl  where  work_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs = ps.executeQuery();
			while (rs.next()) {
				leadHabForm = new LeadHabForm();

				leadHabForm.setWorkId(rs.getString(1));
				leadHabForm.setWorkName(rs.getString(2));
				leadHabForm.setLeadHab(rs.getString(3));
				if (rs.getString(3) != null
						&& !rs.getString(3).equals("")
						&& !rs.getString(3).equals("-")) {
					name = getLeadName(rs.getString(3));
					leadHabForm.setLeadName(name);

				} else {
					name = "-";
					leadHabForm.setLeadName(name);

				}
				works.add(leadHabForm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return works;
	}
	public boolean isExists1(String workid) {
		boolean exists = false;

		try {
			conn = RwsOffices.getConn();

			

			String qq = "select work_id from RWS_work_admn_tbl  where work_id=?";
			ps = conn.prepareStatement(qq);
			ps.setString(1, workid);
			rs1 = ps.executeQuery();

			if (rs1.next()) {
				exists = true;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists1" + e);

		} finally {
			try {
				closeAll();
			} catch (Exception se) {
				System.out.println("Exception in finnally block of isExists1"
						+ se);
			}
		}
		return exists;

	}
	public ArrayList getDistrictslead(String workid) throws Exception {
		ArrayList districts;
		String query = "";
		LabelValueBean leadHabForm = null;
		districts = new ArrayList();
		String w1 = workid.substring(4, 6);
		try {

			conn = RwsOffices.getConn();

			query = "select  dcode,dname from rws_district_tbl  where dcode=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, w1);
			rs = ps.executeQuery();

			while (rs.next()) {
				leadHabForm = new LabelValueBean();
				leadHabForm.setValue(rs.getString(1));
				leadHabForm.setLabel(rs.getString(2));
				leadHabForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				districts.add(leadHabForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getDistrictslead=" + e);
		} finally {
			closeAll();

		}
		return districts;
	}
	
	public ArrayList getMandalslead(String dcode) throws Exception {
		ArrayList mandals;
		String query = "";
		LabelValueBean leadHabForm = null;
		mandals = new ArrayList();
		PreparedStatement ps = null;

		try {

			conn = RwsOffices.getConn();

			query = "select  mcode,mname from rws_mandal_tbl  where dcode=? order by mname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rs = ps.executeQuery();

			while (rs.next()) {
				leadHabForm = new LabelValueBean();
				leadHabForm.setValue(rs.getString(1));
				leadHabForm.setLabel(rs.getString(2));
				leadHabForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				mandals.add(leadHabForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getMandalslead=" + e);
		} finally {
			closeAll();

		}
		return mandals;
	}
	
	
	public ArrayList getPanchayatslead(String dcode, String mcode)
			throws Exception {
		ArrayList panchayats;
		String query = "";
		LabelValueBean leadHabForm = null;
		panchayats = new ArrayList();
		PreparedStatement ps = null;

		try {

			conn = RwsOffices.getConn();

			query = "select  pcode,pname from rws_panchayat_tbl  where dcode=? and mcode=?  order by pname";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rs = ps.executeQuery();

			while (rs.next()) {
				leadHabForm = new LabelValueBean();
				leadHabForm.setValue(rs.getString(1));
				leadHabForm.setLabel(rs.getString(2));
				leadHabForm.setLabelValue(rs.getString(2) + " - "
						+ rs.getString(1));
				panchayats.add(leadHabForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getPanchayatslead=" + e);
		} finally {
			closeAll();

		}
		return panchayats;
	}
	
	public ArrayList gethabdetails(String dcode, String mcode, String pcode)
			throws Exception {

		ArrayList habs = new ArrayList();

		LeadHabForm leadHabForm = null;

		String query = "";

		try {
			conn = RwsOffices.getConn();
			query = "select panch_code,panch_name from rws_complete_hab_view where dcode=? and mcode=? and pcode=? order by panch_name";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rs = ps.executeQuery();
			while (rs.next()) {
				leadHabForm = new LeadHabForm();
				leadHabForm.setHabCode(rs.getString(1));
				leadHabForm.setHabName(rs.getString(2));
				habs.add(leadHabForm);
			}
		} catch (Exception e) {
			Debug.println("The Exception in gethabsdetails=" + e);
		} finally {
			closeAll();
		}
		return habs;
	}
	
	public String getLeadName(String hab) throws Exception {


		String query = "";
		String name = "";

		try {
			conn = RwsOffices.getConn();
			query = "select panch_name from rws_complete_hab_view where panch_code=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, hab);
			rs1 = ps.executeQuery();
			if (rs1.next()) {
				name = rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return name;
	}

	

	

}
