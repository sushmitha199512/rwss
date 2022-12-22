package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.ibm.icu.text.SimpleDateFormat;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.drought.DroughtBean;
import nic.watersoft.drought.DroughtHabitationRecords;
import nic.watersoft.drought.DroughtMasterData;
import nic.watersoft.masters.HabitationNewEntry_Form;
import nic.watersoft.masters.RwsHPRecord;

public class Rws_Ntr_Sujala_HabSponsor_Details_DAO {

	Connection conn = null;
	Statement stmt = null;
	String query = "";
	PreparedStatement pstat = null;
	ResultSet rset = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	ResultSet rset1 = null;

	public ArrayList getCircles(Connection conn) throws Exception {
		ArrayList circles;
		String query = "";

		LabelValueBean assetForm = null;
		circles = new ArrayList();

		try {
			query = "select  d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d  order by d.circle_office_name";
			ps = conn.prepareStatement(query);

			rs = ps.executeQuery();

			while (rs.next()) {
				assetForm = new LabelValueBean();
				assetForm.setValue(rs.getString(1));
				assetForm.setLabel(rs.getString(2));
				assetForm.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				circles.add(assetForm);
			}

		} catch (Exception e) {
			Debug.println("exception in getCircles of Rws_Ntr_Sujala_HabSponsor_Details_DAO =" + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getCircles of Rws_Ntr_Sujala_HabSponsor_Details_DAO finally =" + e2);
			}
		}
		return circles;
	}

	public ArrayList getMandals(String dcode, Connection conn) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		LabelValueBean labelValueBean = null;
		try {
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" + " DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception  in getMandals()=== ntr_sujala_habsponsor_dao " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getMandals of Rws_Ntr_Sujala_HabSponsor_Details_DAO finally =" + e2);
			}
		}
		return mandals;
	}

	public ArrayList getConstituencies(String dcode, String mcode, Connection conn) throws Exception {
		ArrayList constituencies = new ArrayList();
		LabelValueBean labelValueBean = null;
		try {
			query = " SELECT distinct constituency_code, constituency_name " + " FROM rws_constituency_tbl "
					+ " where dcode=? and mcode=?" + " ORDER BY constituency_name";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				constituencies.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getConstituencies  of ntr_sujala_habsponsor_dao is " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getConstituencies of Rws_Ntr_Sujala_HabSponsor_Details_DAO finally =" + e2);
			}
		}

		return constituencies;
	}

	public ArrayList getHabitations(String dcode, String mcode, String constcode, Connection conn, String implDate)
			throws Exception {
		ArrayList habs = new ArrayList();
		Rws_Ntr_Sujala_HabSponsor_Details_Form frm = null;
		String query = "", query1 = "";
		PreparedStatement ps = null, ps1 = null;
		try {

			query = "select distinct hab_code,panch_name,coverage_status,(census_plain_popu+census_sc_popu+census_st_popu) as popu  from "
					+ "rws_ntr_sujala_master_tbl a ,rws_constituency_tbl b ,rws_complete_hab_view c where substr(hab_code,1,2)=b.dcode and"
					+ " substr(hab_code,6,2)=b.mcode and a.hab_code=c.panch_code and b.dcode=? and b.mcode=? and "
					+ "b.CONSTITUENCY_CODE=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, constcode);
			rset = ps.executeQuery();

			while (rset.next()) {
				frm = new Rws_Ntr_Sujala_HabSponsor_Details_Form();
				frm.setHabCode(rset.getString(1));
				frm.setHabName(rset.getString(2));
				frm.setHabstatus(rset.getString(3));
				frm.setHabPop(rset.getString(4));

				if (isExistsRecord(frm, implDate, conn)) {
					query1 = "select PLANT_TYPE_INSTALLED,  PLANT_CAPACITY , INSTALLATION_AGENCY_TYPE,"
							+ "  INSTALLATION_AGENCY_NAME,  MAINTENANCE_AGENCY_TYPE,  MAINTENANCE_AGENCY_NAME  "
							+ " from rws_NTR_SUJala_HAB_IMPL_TBL  where habitation_code=? and "
							+ "IMPLEMENTATION_DT=to_date(?,'dd/mm/yyyy') ";
					ps1 = conn.prepareStatement(query1);
					ps1.setString(1, frm.getHabCode());
					ps1.setString(2, implDate);
					rset1 = ps1.executeQuery();

					while (rset1.next()) {
						frm.setChecks("on");
						frm.setPlantType(rset1.getString(1));
						frm.setPlantCapacity(rset1.getString(2));
						frm.setAgencyType(rset1.getString(3));
						frm.setInstAgencyName(rset1.getString(4));
						frm.setMaintenanceType(rset1.getString(5));
						frm.setMainAgencyName(rset1.getString(6));
					}

				} else {
					frm.setPlantType("");
					frm.setPlantCapacity("");
					frm.setAgencyType("");
					frm.setInstAgencyName("");
					frm.setMaintenanceType("");
					frm.setMainAgencyName("");

				}

				habs.add(frm);
			}
		} catch (Exception e) {
			System.out.println("exception in  getHabitations of Rws_Ntr_Sujala_HabSponsor_Details_Dao= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getHabitations of Rws_Ntr_Sujala_HabSponsor_Details_DAO finally =" + e2);

			}
		}
		return habs;
	}

	public static boolean isExistsRecord(Rws_Ntr_Sujala_HabSponsor_Details_Form frm, String implDate, Connection conn) {
		boolean exists;
		exists = false;
		String query = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			query = "select * from rws_NTR_SUJala_HAB_IMPL_TBL where habitation_code=? and"
					+ " IMPLEMENTATION_DT =to_date(?,'dd/mm/yyyy') ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, frm.getHabCode());
			stmt.setString(2, implDate);

			rs = stmt.executeQuery();
			if (rs.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
			System.out.println("exception in  isExistsRecord of Rws_Ntr_Sujala_HabSponsor_Details_Dao= " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in isExistsRecord of Rws_Ntr_Sujala_HabSponsor_Details_DAO finally =" + e2);
			}
		}

		return exists;
	}

	public ArrayList getPlatTypes(Connection conn) {

		String query = "";

		LabelValueBean plant = null;
		ArrayList plantTypes = new ArrayList();
		PreparedStatement ps = null;

		try {

			query = "select plant_code,plant_name from rws_plant_types_tbl order by 1";
			ps = conn.prepareStatement(query);

			rs = ps.executeQuery();

			while (rs.next()) {
				plant = new LabelValueBean();
				plant.setValue(rs.getString(1));
				plant.setLabel(rs.getString(2));
				plant.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				plantTypes.add(plant);
			}

		} catch (Exception e) {
			Debug.println("exception in getPlatTypes of sujala habsposnsor dao-- " + e);
		}
		return plantTypes;
	}

	public int[] saveHabitations(ArrayList resultData, Rws_Ntr_Sujala_HabSponsor_Details_Form frm, Connection conn,
			RwsUser user, String implDate, HttpServletRequest request) throws Exception {
		int count[] = {};

		try {

			Statement pstmt = conn.createStatement();
			ResultSet rs1 = null;
			Statement stmt = conn.createStatement();

			WorksData1 worksData = new WorksData1();
			String mydate = worksData.getServerDate();

			String query = "", message = "";
			Rws_Ntr_Sujala_HabSponsor_Details_Form sfrm = null;

			if (frm.getHabList() != null) {

				ArrayList habList = frm.getHabList();

				for (int k = 0; k < habList.size(); k++) {

					sfrm = (Rws_Ntr_Sujala_HabSponsor_Details_Form) habList.get(k);

					if (sfrm.getChecks() != null && sfrm.getChecks().equals("on")) {

						if (isExistsRecord(sfrm, implDate, conn)) {
							query = "update rws_NTR_SUJala_HAB_IMPL_TBL  set PLANT_TYPE_INSTALLED ='"
									+ sfrm.getPlantType() + "'" + " , PLANT_CAPACITY ='" + sfrm.getPlantCapacity()
									+ "' , INSTALLATION_AGENCY_TYPE ='" + sfrm.getAgencyType() + "'"
									+ " , INSTALLATION_AGENCY_NAME ='" + sfrm.getInstAgencyName() + "'"
									+ " , MAINTENANCE_AGENCY_TYPE ='" + sfrm.getMaintenanceType() + "'"
									+ " , MAINTENANCE_AGENCY_NAME ='" + sfrm.getMainAgencyName()
									+ "' where habitation_code='" + sfrm.getHabCode() + "' "
									+ "and IMPLEMENTATION_DT=to_date('" + implDate + "','dd/mm/yyyy') ";

							pstmt.addBatch(query);
							request.setAttribute("message1", "Updated");
						}

						else {
							query = "insert into rws_NTR_SUJala_HAB_IMPL_TBL(HABITATION_CODE,IMPLEMENTATION_DT,"
									+ "PLANT_TYPE_INSTALLED,PLANT_CAPACITY,INSTALLATION_AGENCY_TYPE,"
									+ "INSTALLATION_AGENCY_NAME,MAINTENANCE_AGENCY_TYPE,MAINTENANCE_AGENCY_NAME,"
									+ "PREPARED_BY,UPDATE_DATE) values ('" + sfrm.getHabCode() + "'," + "to_date('"
									+ implDate + "'," + "'dd/mm/yyyy'),'" + sfrm.getPlantType() + "','"
									+ sfrm.getPlantCapacity() + "','" + sfrm.getAgencyType() + "','"
									+ sfrm.getInstAgencyName() + "','" + sfrm.getMaintenanceType() + "','"
									+ sfrm.getMainAgencyName() + "','" + user.getOfficeCode() + "'," + "to_date('"
									+ mydate + "','dd/mm/yyyy'))";
							pstmt.addBatch(query);
							request.setAttribute("message1", "Saved");

						}
					}
				}
			}
			count = pstmt.executeBatch();
			if (count.length > 0) {
			} else {
				conn.rollback();
			}
		} catch (Exception e) {
			System.out.println("exception in saveHabitations of Rws_Ntr_Sujala_HabSponsor_Details_DAO-- " + e);
		}
		return count;
	}
	
	public String deleteNtrHabDetails(String habCode, String date) {

		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement stmt4 = null;
		Connection conn = null;
		try {
		
		
		String qry = null;

			conn = RwsOffices.getConn();
		
			if (!isExistsNTRHab(conn, habCode, date)) {
				System.out.println("delete query");
				qry = "delete from RWS_NTR_SUJALA_HAB_IMPL_TBL where HABITATION_CODE=? and IMPLEMENTATION_DT=to_date(?,'DD-MM-YYYY')";
				stmt4 = conn.prepareStatement(qry);
				stmt4.setString(1, habCode);
				stmt4.setString(2, date);
				rowCount = stmt4.executeUpdate();
			}
			if (rowCount > 0) {
				message = "Record Deleted Successfully";
			} else {
				message = "Record Cannot be Deleted";
			}
		}
		catch (Exception e) {
			System.out.println("exception in deleteNtrHabDetails of Rws_Ntr_Sujala_HabSponsor_Details_DAO-- "+e);
		}finally{
			try {
				if(stmt4 != null)
				stmt4.close();
				if(conn != null)
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		return message;

	}
	private boolean isExistsNTRHab(Connection conn, String habCode, String date) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
			//System.out.println("is exist    rec");
			query = "select  HABITATION_CODE,nvl(ASSET_CODE,'-') as ASSET_CODE from RWS_NTR_SUJALA_HAB_IMPL_TBL where HABITATION_CODE=? and IMPLEMENTATION_DT=to_date(?,'DD-MM-YYYY')";
			
			//System.out.println("Query  "+ query);
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, habCode);
			stmt1.setString(2, date);
			rs = stmt1.executeQuery();


			if (rs.next()) {
				if(rs.getString("ASSET_CODE").equals("-"))				
					return false;
				else
					return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExistsNTRHab of Rws_Ntr_Sujala_HabSponsor_Details_DAO--"+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExistsNTRHab of Rws_Ntr_Sujala_HabSponsor_Details_DAO--"+e);
			}
		}

		return false;
	}
	
}