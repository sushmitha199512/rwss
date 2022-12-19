package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_AssetWork_LeadHabData {

	
	Connection conn = null;

	

	ResultSet rs1 = null;
	ResultSet rs = null;
	
	PreparedStatement ps = null;

	public Rws_AssetWork_LeadHabData() {
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

	
	public boolean isExistsAsset(String workid) {
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
	
	public boolean isExistsWork(String workid) {
		boolean completed = false;
		try {
			conn = RwsOffices.getConn();
			String qq = "select work_id from rws_work_admn_tbl where WORK_ID=?";
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
	public int updateLeadHab(Rws_AssetWork_LeadHabForm dr, String habcode,boolean existWork) throws Exception {
		int count = 0;
		try {
			
			
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			CommonLists commonLists=new CommonLists();
			String pumpcode=commonLists.getPumpCode(dr.getTypeOfAsset(), "", habcode);
			
			String query = "update rws_asset_mast_tbl set HAB_CODE=?  where asset_code=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2,  dr.getAssetCode());
			count += ps.executeUpdate();
			
			query = "update rws_asset_hab_tbl set HAB_CODE=?  where asset_code=? and HAB_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2,  dr.getAssetCode());
			ps.setString(3,  dr.getLeadHab());
			count += ps.executeUpdate();
			
						
			query = "update rws_asset_scheme_tbl set scheme_code=?  where asset_code=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode+pumpcode);
			ps.setString(2,  dr.getAssetCode());
			count+= ps.executeUpdate();
			//System.out.println(query);
			if(existWork == true){
				
			query = "update rws_work_admn_tbl set lead_habitation=?  where work_id=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2,  dr.getAssetCode());
			count+= ps.executeUpdate();
			
			query = "update RWS_ADMN_HAB_LNK_TBL set HAB_CODE=?  where work_id=? and HAB_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2,  dr.getAssetCode());
			ps.setString(3,  dr.getWorkHabCode());
			count+= ps.executeUpdate();
			//System.out.println(query);
			}
			if (count > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else {
				conn.rollback();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();

		}
		return count;

	}
	public Rws_AssetWork_LeadHabForm getAssetWorkdetails(String assetCode) throws Exception {
		ArrayList works = new ArrayList();

		Rws_AssetWork_LeadHabForm leadHabForm = null;

		String query = "";
		String name = "";
		try {
			conn = RwsOffices.getConn();
			query = "select ASSET_CODE,ASSET_NAME,nvl(HAB_CODE,'-') as HAB_CODE,work_id,work_name,nvl(lead_habitation,'-') as lead_habitation,type_of_asset from rws_asset_mast_tbl a, rws_work_admn_tbl b  where  a.ASSET_CODE=b.Work_id and ASSET_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, assetCode);
			rs = ps.executeQuery();
			while (rs.next()) {
				leadHabForm = new Rws_AssetWork_LeadHabForm();

				leadHabForm.setAssetCode1(rs.getString("ASSET_CODE"));
				leadHabForm.setAssetName(rs.getString("ASSET_NAME"));
				leadHabForm.setLeadHab(rs.getString("HAB_CODE"));
				leadHabForm.setTypeOfAsset(rs.getString("type_of_asset"));
				//System.out.println(rs.getString("type_of_asset"));
				if (rs.getString("HAB_CODE") != null
						&& !rs.getString("HAB_CODE").equals("")
						&& !rs.getString("HAB_CODE").equals("-")) {
					name = getLeadName(rs.getString("HAB_CODE"));
					leadHabForm.setLeadName(name);

				} else {
					name = "-";
					leadHabForm.setLeadName(name);

				}
				leadHabForm.setWorkId(rs.getString("work_id"));
				leadHabForm.setWorkName(rs.getString("work_name"));
				leadHabForm.setWorkHabCode(rs.getString("lead_habitation"));
				if (rs.getString("lead_habitation") != null
						&& !rs.getString("lead_habitation").equals("")
						&& !rs.getString("lead_habitation").equals("-")) {
					name = getLeadName(rs.getString("lead_habitation"));
					leadHabForm.setWorkHabName(name);

				} else {
					name = "-";
					leadHabForm.setWorkHabName(name);

				}
				works.add(leadHabForm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return leadHabForm;
	}
	public boolean isExists1(String workid) {
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

		Rws_AssetWork_LeadHabForm leadHabForm = null;

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
				leadHabForm = new Rws_AssetWork_LeadHabForm();
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
	public Rws_AssetWork_LeadHabForm getAssetdetails(String assetCode) throws Exception {
		ArrayList assets = new ArrayList();

		Rws_AssetWork_LeadHabForm leadHabForm = null;

		String query = "";
		String name = "";
		try {
			conn = RwsOffices.getConn();
			query = "select ASSET_CODE,ASSET_NAME,nvl(HAB_CODE,'-') as HAB_CODE,type_of_asset_code from rws_asset_mast_tbl where ASSET_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, assetCode);
			rs = ps.executeQuery();
			//System.out.println(query);
			//System.out.println(assetCode);
			while (rs.next()) {
				leadHabForm = new Rws_AssetWork_LeadHabForm();
				leadHabForm.setAssetCode1(rs.getString("ASSET_CODE"));
				leadHabForm.setAssetName(rs.getString("ASSET_NAME"));
				leadHabForm.setLeadHab(rs.getString("HAB_CODE"));
				leadHabForm.setTypeOfAsset(rs.getString("type_of_asset_code"));
				if (rs.getString("HAB_CODE") != null
						&& !rs.getString("HAB_CODE").equals("")
						&& !rs.getString("HAB_CODE").equals("-")) {
					name = getLeadName(rs.getString("HAB_CODE"));
					leadHabForm.setLeadName(name);
				} else {
					name = "-";
					leadHabForm.setLeadName(name);
				}
				assets.add(leadHabForm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return leadHabForm;
	}
}
