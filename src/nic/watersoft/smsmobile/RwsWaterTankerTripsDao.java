package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.drought.DroughtMasterData;

public class RwsWaterTankerTripsDao {
	Connection conn = null;
	Statement stmt = null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	Statement stmt4 = null;
	Statement stmt5 = null;
	ResultSet rs = null;
	ResultSet rset = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	ResultSet rs5 = null;
	int connCount = 0;
	PreparedStatement ps = null;
	
	public ArrayList getDroughtDistricts() throws Exception {
		ArrayList districts;
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		LabelValueBean tankerForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			tankerTripDao.stmt = tankerTripDao.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_drought_habitation_tbl c where "
					+ "d.dcode=substr(c.habcode,1,2) order by d.dname";
			tankerTripDao.rs = tankerTripDao.stmt.executeQuery(query);
			while (tankerTripDao.rs.next()) {
				tankerForm = new LabelValueBean();
				tankerForm.setValue(tankerTripDao.rs.getString(1));
				tankerForm.setLabel(tankerTripDao.rs.getString(2));
				tankerForm.setLabelValue(tankerTripDao.rs.getString(2) + " - " + tankerTripDao.rs.getString(1));
				districts.add(tankerForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in getDroughtDistricts of RwsWaterTankerTripsDao = " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return districts;
	}

	public ArrayList getDroughtMandals(String dcode) throws Exception {
		ArrayList mandals;
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		LabelValueBean tankerForm = null;
		mandals = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_drought_habitation_tbl c where "
					+ " d.dcode=? and d.mcode=substr(c.habcode,6,2) and d.dcode=substr(c.habcode,1,2) order by d.mname";
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, dcode);
			tankerTripDao.rs = pst.executeQuery();
			while (tankerTripDao.rs.next()) {
				tankerForm = new LabelValueBean();
				tankerForm.setValue(tankerTripDao.rs.getString(2));
				tankerForm.setLabel(tankerTripDao.rs.getString(3));
				tankerForm
						.setLabelValue(tankerTripDao.rs.getString(3) + " - " + tankerTripDao.rs.getString(2));
				mandals.add(tankerForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in getDroughtMandals of RwsWaterTankerTripsDao = " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return mandals;
	}

	public ArrayList getDroughtPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		LabelValueBean tankerForm = null;
		panchayats = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_drought_habitation_tbl c where (flushing>0 or deepening>0) "
					+ "and   d.dcode=? and d.mcode=? and substr(c.habcode,13,2)=d.pcode and substr(c.habcode,1,2)=d.dcode and "
					+ "substr(c.habcode,6,2)=d.mcode order by d.pname";
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			tankerTripDao.rs = pst.executeQuery();
			while (tankerTripDao.rs.next()) {
				tankerForm = new LabelValueBean();
				tankerForm.setValue(tankerTripDao.rs.getString(3));
				tankerForm.setLabel(tankerTripDao.rs.getString(4));
				tankerForm.setLabelValue(tankerTripDao.rs.getString(4) + " - " + tankerTripDao.rs.getString(3));
				panchayats.add(tankerForm);
			}

		} catch (Exception e) {
			System.out.println("The Exception in getDroughtVillages of RwsWaterTankerTripsDao =" + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return panchayats;
	}

	public ArrayList getDroughtVillages(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList villages;
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		LabelValueBean tankerForm = null;
		villages = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.vcode,d.vname from rws_village_tbl d,rws_drought_habitation_tbl c where "
					+ "  d.dcode=? and d.mcode=? and d.pcode=? and substr(c.habcode,8,3)=d.vcode and "
					+ "substr(c.habcode,1,2)=d.dcode and substr(c.habcode,6,2)=d.mcode and substr(c.habcode,13,2)=d.pcode"
					+ " order by d.vname";
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			pst.setString(3, pcode);
			tankerTripDao.rs = pst.executeQuery();
			while (tankerTripDao.rs.next()) {
				tankerForm = new LabelValueBean();
				tankerForm.setValue(tankerTripDao.rs.getString(4));
				tankerForm.setLabel(tankerTripDao.rs.getString(5));
				tankerForm
						.setLabelValue(tankerTripDao.rs.getString(5) + " - " + tankerTripDao.rs.getString(4));
				villages.add(tankerForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in getDroughtPanchayats of RwsWaterTankerTripsDao = " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return villages;
	}

	public ArrayList getDroughtHabitations(String dcode, String mcode, String pcode, String vcode) throws Exception {
		ArrayList habs = new ArrayList();
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		LabelValueBean tankerForm = null;
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, "
					+ "RWS_HABITATION_DIRECTORY_TBL H,rws_drought_habitation_tbl c WHERE "
					+ "SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=?  AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS not in ('UI','NW') and c.habcode=p.panch_code  "
					+ "and c.habcode=h.hab_code  ";
			if(!pcode.equals(""))
				query+= " AND SUBSTR(P.PANCH_CODE,13,2)=? " ;
			if(!vcode.equals(""))
				query+= " AND SUBSTR(P.PANCH_CODE,8,3)=? " ;
			
				query+= " ORDER BY P.PANCH_NAME";
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			if(!pcode.equals(""))
				pst.setString(3, pcode);
			if(!vcode.equals(""))
				pst.setString(4, vcode);
			tankerTripDao.rs = pst.executeQuery();
			while (tankerTripDao.rs.next()) {
				tankerForm = new LabelValueBean();
				tankerForm.setValue(tankerTripDao.rs.getString(1));
				tankerForm.setLabel(tankerTripDao.rs.getString(2));
				tankerForm.setLabelValue(tankerTripDao.rs.getString(2) + " - " + tankerTripDao.rs.getString(1));
				habs.add(tankerForm);
			}
		} catch (Exception e) {
			System.out.println("The Exception in getDroughtHabitations of RwsWaterTankerTripsDao  " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return habs;
	}
	public String saveWaterTankerTrips(RwsWaterTankerTripsForm frm) throws Exception {
		String message="";
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		String query = "";
		PreparedStatement pst = null;
		try {
		//	System.out.println("in save");
			tankerTripDao.conn = RwsOffices.getConn();
			query ="select * from RWS_TANKER_TARGET_TRIP_TBL where HAB_CODE=? " ;
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, frm.getHabCode());
			rs = pst.executeQuery();
			if(rs.next()) {
				message="Record already existed for this Habitation ";
			}	else {
			query = "INSERT INTO RWS_TANKER_TARGET_TRIP_TBL values (?,TO_DATE(?,'DD-MM-YYYY'),?,sysdate)" ;		
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, frm.getHabCode());
			pst.setString(2, frm.getDate());
			pst.setInt(3, frm.getNoOfTrips());			
			int i = pst.executeUpdate();
			if(i>0)
				message="Record inserted successfully";
			else
				message="Record not inserted";		
			}
		} catch (Exception e) {
			System.out.println("The Exception in saveWaterTankerTrips of RwsWaterTankerTripsDao  " + e);
		//	e.printStackTrace();
		} finally {
			tankerTripDao.closeAll();
		}
		return message;
	}
	
	public ArrayList<RwsWaterTankerTripsForm> getTankerTripDetails(RwsWaterTankerTripsForm frm) throws Exception {
		ArrayList<RwsWaterTankerTripsForm> tripList=new ArrayList<RwsWaterTankerTripsForm>();
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "select HAB_CODE,TO_CHAR(TRIP_DATE,'DD-MM-YYYY') as targetdate,NO_OF_TRIPS from RWS_TANKER_TARGET_TRIP_TBL where substr(HAB_CODE,1,2)=? and  substr(HAB_CODE,6,2)=?" ;		
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, frm.getDist());
			pst.setString(2, frm.getMand());			
			tankerTripDao.rs=pst.executeQuery();
			while(tankerTripDao.rs.next()) {
				RwsWaterTankerTripsForm list=new RwsWaterTankerTripsForm();
				list.setHabCode(tankerTripDao.rs.getString("HAB_CODE"));
				list.setHabName(DroughtMasterData.getHabName(tankerTripDao.rs.getString("HAB_CODE")));
				list.setNoOfTrips(tankerTripDao.rs.getInt("NO_OF_TRIPS"));
				list.setDate(tankerTripDao.rs.getString("targetdate"));
				tripList.add(list);
			}					
		} catch (Exception e) {
			System.out.println("The Exception in getTankerTripDetailsDetails of RwsWaterTankerTripsDao  " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return tripList;
	}
	public RwsWaterTankerTripsForm getTankerTripDetailsForEdit(String habCode) throws Exception {
		RwsWaterTankerTripsForm tripList=new RwsWaterTankerTripsForm();
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "select HAB_CODE,TO_CHAR(TRIP_DATE,'DD-MM-YYYY') as targetdate,NO_OF_TRIPS from RWS_TANKER_TARGET_TRIP_TBL where HAB_CODE=?" ;		
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setString(1, habCode);
			tankerTripDao.rs=pst.executeQuery();
			while(tankerTripDao.rs.next()) {		
				tripList.setDist(tankerTripDao.rs.getString("HAB_CODE").substring(0, 2));
				tripList.setMand(tankerTripDao.rs.getString("HAB_CODE").substring(5, 7));
				tripList.setHabCode(tankerTripDao.rs.getString("HAB_CODE"));
				tripList.setHabName(DroughtMasterData.getHabName(tankerTripDao.rs.getString("HAB_CODE")));
				tripList.setNoOfTrips(tankerTripDao.rs.getInt("NO_OF_TRIPS"));
				tripList.setDate(tankerTripDao.rs.getString("targetdate"));				
			}					
		} catch (Exception e) {
			System.out.println("The Exception in getTankerTripDetailsDetails of RwsWaterTankerTripsDao  " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return tripList;
	}
	public String modifyWaterTankerTrips(RwsWaterTankerTripsForm frm) throws Exception {
		String message="";
		RwsWaterTankerTripsDao tankerTripDao = new RwsWaterTankerTripsDao();
		String query = "";
		PreparedStatement pst = null;
		try {
			tankerTripDao.conn = RwsOffices.getConn();
			query = "update RWS_TANKER_TARGET_TRIP_TBL set NO_OF_TRIPS=?,TRIP_DATE=TO_DATE(?,'DD-MM-YYYY'),update_date=sysdate where HAB_CODE=?" ;		
			pst = tankerTripDao.conn.prepareStatement(query);
			pst.setInt(1, frm.getNoOfTrips());	
			pst.setString(2, frm.getDate());
			pst.setString(3, frm.getHabCode());			
			int i = pst.executeUpdate();
			if(i>0)
				message="Record updated successfully";
			else
				message="Record not updated";		
			
		} catch (Exception e) {
			System.out.println("The Exception in modifyWaterTankerTrips of RwsWaterTankerTripsDao  " + e);
		} finally {
			tankerTripDao.closeAll();
		}
		return message;
	}
	public void closeAll() throws Exception {	
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				System.out.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rs5 = null;
		}
	
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao :  " + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			stmt5 = null;
		}	
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The Exception in RwsWaterTankerTripsDao : " + e);
			}
			conn = null;
		}
	}

}
