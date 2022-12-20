package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;

public class RWS_HP_Yield_DAO {

	private String query = null;
	private PreparedStatement ps = null, ps1 = null, ps2 = null;
	private Connection conn=null;
	private Statement stmt = null;
	private ResultSet rset = null,rs=null;

	public void closeAll() throws SQLException {
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO " + e);
			}
			rset = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			ps = null;
		}
		if (ps1 != null) {
			try {
				ps1.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			ps1 = null;
		}
		if (ps2 != null) {
			try {
				ps2.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			ps2 = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			conn = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			stmt = null;
		}
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in RWS_HP_Yield_DAO" + e);
			}
			rs = null;
		}
	}

	public ArrayList getCircles() throws Exception {
		ArrayList circles = new ArrayList();
		HabitationNewEntry_Form habMandal = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode,dname  FROM rws_district_tbl ORDER BY dcode";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setCircleCode(rset.getString(1));
				habMandal.setCircleName(rset.getString(2));
				circles.add(habMandal);
			}
		} catch (Exception e) {
			System.out.println("Exception is at getCircles of RWS_HP_Yield_DAO is : " + e);
			// e.printStackTrace();
		} finally {
			closeAll();
		}
		return circles;
	}

	public String getCircle(String ccode) throws SQLException {
		String circle = null;
		HabitationNewEntry_Form habMandal = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT circle_office_code, circle_office_name  FROM rws_circle_office_tbl where circle_office_code =? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setCircleCode(rset.getString(1));
				habMandal.setCircleName(rset.getString(2));
			}
		} catch (Exception e) {
			System.out.println("Exception is at getCircle of RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return circle;
	}

	@SuppressWarnings("unchecked")
	public ArrayList getDivisions1(String ccode) throws Exception {
		ArrayList divisions = new ArrayList();
		HabitationNewEntry_Form habMandal = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT division_office_code, division_office_name" + " FROM rws_division_office_tbl "
					+ " where circle_office_code=? " + " ORDER BY division_office_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setDivisionCode(rset.getString(1));
				habMandal.setDivisionName(rset.getString(2));
				divisions.add(habMandal);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getDivisions1 of RWS_HP_Yield_DAO:  " + e);
		} finally {
			closeAll();
		}
		return divisions;
	}

	@SuppressWarnings("unchecked")
	public ArrayList getSubDivisions1(String ccode, String divcode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		HabitationNewEntry_Form habMandal = null;
		try {
			conn = RwsOffices.getConn();
			query = " select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl WHERE circle_office_code=? and division_office_code=? ORDER BY subdivision_office_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			ps.setString(2, divcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setSubDivisionCode(rset.getString(1));
				habMandal.setSubDivisionName(rset.getString(2));
				subdivisions.add(habMandal);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getSubDivisions1of RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return subdivisions;
	}

	@SuppressWarnings("unchecked")
	public ArrayList getMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		HabitationNewEntry_Form habMandal = null;
		String query = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setMandalCode(rset.getString(2));
				habMandal.setMandalName(rset.getString(3));
				mandals.add(habMandal);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getMandals RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return mandals;
	}

	public ArrayList getMandals1(String circleOfficeCode) throws Exception {
		ArrayList mandals1 = new ArrayList();
		String query = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" + " DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				LabelValueBean rwsLocation = new LabelValueBean();
				rwsLocation.setValue(rset.getString(1));
				rwsLocation.setLabel(rset.getString(2));
				rwsLocation.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				mandals1.add(rwsLocation);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getMandals1 of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return mandals1;
	}

	public ArrayList getSanctionedHabs(String sourceCode) throws Exception{
		ArrayList habitations = new ArrayList();
		try {
			String query = "";
			if (sourceCode.substring(19, 21).equals("SO")) {
				query = "select hab_code from rws_source_habitation_tbl where source_code=? ";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				ps.setString(1, sourceCode);
				rset = ps.executeQuery();
				RwsLocationBean rwsLocationBean = null;
				while (rset.next()) {
					habitations.add(rset.getString(1));
				}
			}
			if (sourceCode.substring(19, 21).equals("OS")) {
				query = "select HAB_CODE from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE=?";
				conn = RwsOffices.getConn();
				ps = conn.prepareStatement(query);
				ps.setString(1, sourceCode);
				rset = ps.executeQuery();
				RwsLocationBean rwsLocationBean = null;
				while (rset.next()) {
					habitations.add(rset.getString(1));
				}
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getSanctionedHabs of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return habitations;
	}

	public ArrayList getHabsInMandals(String sourceCode, ArrayList sanctionedHabs, String[] mcodes) throws Exception {
		ArrayList habs = new ArrayList();
		String sqlQuery = "";
		try {
			conn = RwsOffices.getConn();
			for (int j = 0; j < mcodes.length; j++) {
				if (mcodes[j] != null) {
					sqlQuery = "select distinct h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,"
							+ "hd.coverage_status,m.mname,CONSTITUENCY_NAME from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,"
							+ "rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,RWS_CONSTITUENCY_TBL c where  "
							+ "d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and "
							+ "p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and "
							+ "substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code "
							+ "and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? and c.dcode=d.dcode"
							+ " and c.mcode=m.mcode order by m.mname,h.panch_name asc";	
					ps = conn.prepareStatement(sqlQuery);
					ps.setString(1, sourceCode.substring(0, 2));
					ps.setString(2, mcodes[j]);
					rset = ps.executeQuery();
					nic.watersoft.masters.RwsHPRecord rwsHPRecord = null;
					while (rset.next()) {
						rwsHPRecord = new nic.watersoft.masters.RwsHPRecord();
						if (sanctionedHabs != null) {
							for (int i = 0; i < sanctionedHabs.size(); i++) {
									if (((String) sanctionedHabs.get(i)) != null
											&& ((String) sanctionedHabs.get(i)).equals(rset.getString(1))) {
										rwsHPRecord.setHabMatch("checked");
									}
							}
						}
						rwsHPRecord.setHabCode(rset.getString(1));
						rwsHPRecord.setHabName(rset.getString(2));
						rwsHPRecord.setPopulation(rset.getString(3));
						rwsHPRecord.setStatus(rset.getString(4));
						rwsHPRecord.setConstituencyName(rset.getString(6));
						rwsHPRecord.setMandalName(rset.getString(5));
						habs.add(rwsHPRecord);
					}
				}
			}
		}  catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at getHabsInMandals of  RWS_HP_Yield_DAO is : " + e);			
			return null;
		} finally {
			closeAll();
		}
		return habs;
	}

	@SuppressWarnings("unchecked")
	public ArrayList habitationsByMandals(String ccode, String mcode, String panchayatCode) throws Exception{
		ArrayList habitationsByMandals = new ArrayList();
		HabitationNewEntry_Form habMandal = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			query = "select a.hab_code,b.panch_name  from rws_habitation_directory_tbl a,rws_panchayat_raj_tbl b,rws_complete_hab_view c "
					+ " where substr(a.hab_code,1,2)=?' and substr(a.hab_code,6,2)=? and (a.coverage_status <> 'UI' or a.coverage_status is not null) "
					+ "and a.hab_code=b.panch_code and c.panch_code=a.hab_code and substr(a.hab_code,13,2)=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, ccode);
			ps.setString(2, mcode);
			ps.setString(3, panchayatCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setHabCode(rset.getString(1));
				habMandal.setHabName(rset.getString(2));
				habMandal.setHabitationCode(rset.getString(1) + " - " + rset.getString(2));
				habitationsByMandals.add(habMandal);
			}
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception is at habitationsByMandals of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return habitationsByMandals;
	}

	@SuppressWarnings("unchecked")
	public ArrayList getHabsDetailsByMandals(String habCode) throws Exception{
		ArrayList habs = new ArrayList();
		String query = "";		
		try {
			conn = RwsOffices.getConn();
			query = "	select b.hp_code,b.location,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code,b.UNSAFE_LPCD,b.SAFE_LPCD,"
					+ " P_YEILD,PYEILD_LOCAL,b.status,b.QUALITY_AFFECTED,FLOURIDE,BRAKISH,IRON ,nitrate from rws_habitation_directory_tbl a ,"
					+ " RWS_HP_SUBCOMP_PARAM_TBL b ,RWS_ASSET_MAST_TBL c where a.hab_code=substr(b.hp_code,1,16)  and "
					+ " b.asset_code=c.asset_code and a.hab_code=? order by hp_code";
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setUnSafeLpd(rset.getString(8));
				habMandal.setSafeLpd(rset.getString(9));
				habMandal.setYield(rset.getString(10));
				habMandal.setStatus(rset.getString(12));
				habMandal.setQualityAffected(rset.getString(13));
				habMandal.setFlouride(rset.getString(14));
				habMandal.setBrakish(rset.getString(15));
				habMandal.setIron(rset.getString(16));
				habMandal.setNitrate(rset.getString(17));
				habs.add(habMandal);
			}
		} catch (Exception e) {
			System.out.println("Exception is at getHabsDetailsByMandals of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return habs;
	}

	public int[] saveHPYields(String[] yields, HabitationNewEntry_Form frm, HttpServletRequest request)
			throws Exception {
		int count[] = {};
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			Statement pstmt = conn.createStatement();
			int i = 0;
			for (int k = 0; k < frm.getHabs().size(); k++) {
				RwsHPRecord rwsHPRecord = (RwsHPRecord) frm.getHabs().get(k);
				rwsHPRecord.setStatus(request.getParameter("habMandal[" + k + "].status"));
				rwsHPRecord.setSafeLpd(request.getParameter("habMandal[" + k + "].safeLpd"));
				rwsHPRecord.setUnSafeLpd(request.getParameter("habMandal[" + k + "].unSafeLpd"));
				rwsHPRecord.setYield(request.getParameter("habMandal[" + k + "].yield"));
				rwsHPRecord.setLatitude(request.getParameter("habMandal[" + k + "].latitude"));
				rwsHPRecord.setLongitude(request.getParameter("habMandal[" + k + "].longitude"));
				rwsHPRecord.setBrakish(request.getParameter("habMandal[" + k + "].brakish"));
				rwsHPRecord.setQualityAffected(request.getParameter("habMandal[" + k + "].qualityAffected"));
				rwsHPRecord.setIron(request.getParameter("habMandal[" + k + "].iron"));
				rwsHPRecord.setFlouride(request.getParameter("habMandal[" + k + "].flouride"));
				rwsHPRecord.setElevation(request.getParameter("habMandal[" + k + "].elevation"));
				rwsHPRecord.setNitrate(request.getParameter("habMandal[" + k + "].nitrate"));
				String saf = request.getParameter("habMandal[" + k + "].safeLpd");

				if (!saf.isEmpty()) {
					if (request.getParameter("habMandal[" + k + "].checks") != null
							&& request.getParameter("habMandal[" + k + "].checks").equals("on")) {

						String q1 = "update  RWS_HP_SUBCOMP_PARAM_TBL  set status ='" + rwsHPRecord.getStatus()
								+ "',P_YEILD='" + rwsHPRecord.getYield() + "',QUALITY_AFFECTED='"
								+ rwsHPRecord.getQualityAffected() + "',longitude='" + rwsHPRecord.getLongitude()
								+ "',elevation='" + rwsHPRecord.getElevation() + "',flouride='0',LATITUDE='"
								+ rwsHPRecord.getLatitude() + "',nitrate='0',SAFE_LPCD='" + rwsHPRecord.getSafeLpd()
								+ "',UNSAFE_LPCD='" + rwsHPRecord.getUnSafeLpd() + "',"
								+ " BRAKISH='0',IRON='0' where hp_code='" + yields[i] + "'";
						// System.out.println("Query:" + q1);

						pstmt.addBatch(q1);

					}
					count = pstmt.executeBatch();

				}
				String unsafe = request.getParameter("habMandal[" + k + "].unSafeLpd");
				if (!unsafe.isEmpty()) {
					if (request.getParameter("habMandal[" + k + "].checks") != null
							&& request.getParameter("habMandal[" + k + "].checks").equals("on")) {

						String q1 = "update  RWS_HP_SUBCOMP_PARAM_TBL  set status ='" + rwsHPRecord.getStatus()
								+ "',P_YEILD='" + rwsHPRecord.getYield() + "',QUALITY_AFFECTED='"
								+ rwsHPRecord.getQualityAffected() + "',longitude='" + rwsHPRecord.getLongitude()
								+ "',elevation='" + rwsHPRecord.getElevation() + "',flouride='"
								+ rwsHPRecord.getFlouride() + "',LATITUDE='" + rwsHPRecord.getLatitude() + "',nitrate='"
								+ rwsHPRecord.getNitrate() + "',SAFE_LPCD='" + rwsHPRecord.getSafeLpd()
								+ "',UNSAFE_LPCD='" + rwsHPRecord.getUnSafeLpd() + "'," + " BRAKISH='"
								+ rwsHPRecord.getBrakish() + "',IRON='" + rwsHPRecord.getIron() + "' where hp_code='"
								+ yields[i] + "'";
						// System.out.println("Query:" + q1);

						pstmt.addBatch(q1);

					}
					count = pstmt.executeBatch();

				}

			}

			// System.out.println("count - - -" + count);
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			System.out.println("Exception is at saveHPYields of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;

	}

	public void getWQMasterParameterValues(HabitationNewEntry_Form habForm) throws Exception{
			try {
			conn = RwsOffices.getConn();
			query = " select MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_value ,TESTING_PARAMETER_CODE  as code,TESTING_PARAMETER_NAME  as name "
					+ " from rws_wq_para_test_tbl where TESTING_PARAMETER_CODE in ('13','05','15','16')";
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			while (rset.next()) {
				// 05- Brakish , 16 - IRON , 13 - FLOURIDE , 15 - NITRATE
				if (rset.getString(3).equals("05")) {
					habForm.setBrakishMin(rset.getString(1));
					habForm.setBrakishMax(rset.getString(2));
				}
				if (rset.getString(3).equals("16")) {
					habForm.setIronMin(rset.getString(1));
					habForm.setIronMax(rset.getString(2));
				}
				if (rset.getString(3).equals("15")) {
					habForm.setNitrateMin(rset.getString(1));
					habForm.setNitrateMax(rset.getString(2));
				}
				if (rset.getString(3).equals("13")) {
					habForm.setFlourideMin(rset.getString(1));
					habForm.setFlourideMax(rset.getString(2));
				}

			}
		} catch (Exception e) {
			System.out.println("Exception is at getWQMasterParameterValues of  RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();			
		}
	}

		public ArrayList<RwsHPRecord> getSchemeSources(String habCode) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			query = "	select b.source_code,nvl(b.location,'-'),b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.YIELD,b.SOURCE_CONDITION ,nvl(d.SOURCE_TYPE_NAME,'-') ,nvl(b.FLOURIDE,0),nvl(b.BRAKISH,0),nvl(b.IRON,0),nvl(b.NITRATE,0),nvl(b.SAFE_LPD,0),nvl(b.UNSAFE_LPD,0), nvl(status,''),nvl(b.remarks,''),to_char(b.UPDATE_DATE,'dd/mm/yyyy'),NVL(b.SOURCE_DETAILS,'') from rws_source_tbl b ,RWS_ASSET_MAST_TBL c,rws_source_type_tbl d  where  substr(b.source_code,1,16)='"
					+ habCode + "'  and "
					+ " b.asset_code=c.asset_code  and d.SOURCE_TYPE_CODE=b.SOURCE_TYPE_CODE  order by b.source_code";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName(rset.getString(10));
				habMandal.setFlouride(rset.getString(11));
				habMandal.setBrakish(rset.getString(12));
				habMandal.setIron(rset.getString(13));
				habMandal.setNitrate(rset.getString(14));
				habMandal.setSafeLpd(rset.getString(15));
				habMandal.setUnSafeLpd(rset.getString(16));
				habMandal.setStatus(rset.getString(17));
				habMandal.setRemarks(rset.getString(18));
				habMandal.setDate(rset.getString(19));
				habMandal.setSourcedetails(rset.getString(20));
				updateTestDetails(habMandal, conn);
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habMandal
	 * @param conn
	 */
	private void updateTestDetails(RwsHPRecord habMandal, Connection conn) {
		try {

			stmt = conn.createStatement();
			String query = "select a.test_id,to_char(a.PREPARED_ON,'dd/mm/yyyy'),b.TESTING_PARAMETER_CODE,b.TESTING_PARAMETER_value from RWS_WQ_TEST_RESULTS_TBL a,RWS_WQ_TEST_RESULTS_LNK_TBL b  where SOURCE_CODE='"
					+ habMandal.getHpCode()
					+ "'  and  a.test_id=b.test_id  and a.PREPARED_ON=(select  MAX(c.prepared_on) from  RWS_WQ_TEST_RESULTS_TBL c where c.source_code=a.source_code)";

			// Iron 16 ,Flouride 13,Nitrate 15,Brakish 05

			Debug.println(query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {

				habMandal.setTestdate(rs.getString(2));

				double parameterValue = 0;
				String parameterCode = rs.getString(3);
				String parameterV = rs.getString(4);
				if (parameterV != null && !parameterV.equals("null") && !parameterV.equals("")) {

					parameterValue = Double.parseDouble(parameterV);
				}

				if (parameterCode != null && parameterCode.equals("05") && parameterValue >= 2000) { // BRAKISH

					habMandal.setBrakishContamination(String.valueOf(parameterValue));

				} else if (parameterCode != null && parameterCode.equals("13") && parameterValue >= 1.5) { // Flouride

					habMandal.setFlourideContamination(String.valueOf(parameterValue));
				} else if (parameterCode != null && parameterCode.equals("15") && parameterValue >= 45) { // Nitrate
					habMandal.setNitrateContamination(String.valueOf(parameterValue));
				} else if (parameterCode != null && parameterCode.equals("16") && parameterValue >= 0.3) { // Iron
					habMandal.setIronContamination(String.valueOf(parameterValue));

				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList<RwsHPRecord> getHandPumps(String habCode) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.hp_code,b.location,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.P_YEILD,b.STATUS,nvl(b.FLOURIDE,0),nvl(b.BRAKISH,0),nvl(b.IRON,0),nvl(b.NITRATE,0),nvl(b.SAFE_LPD,0),nvl(b.UNSAFE_LPD,0),nvl(b.remarks,''),to_char(b.UPDATE_DATE,'dd/mm/yyyy'),to_char(b.REPAIR_DATE,'dd/mm/yyyy'),nvl(b.REPAIR_DESC,''),PLATFORM_EXISTING,SOAK_PIT,STATIC_WL,SUMMER_WL   from RWS_HP_SUBCOMP_PARAM_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.hp_code,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.hp_code";
			// System.out.println("HAB query -hhpanuu 213 ->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));

				habMandal.setFlouride(rset.getString(10));
				habMandal.setBrakish(rset.getString(11));
				habMandal.setIron(rset.getString(12));
				habMandal.setNitrate(rset.getString(13));

				habMandal.setSafeLpd(rset.getString(14));
				habMandal.setUnSafeLpd(rset.getString(15));
				habMandal.setRemarks(rset.getString(16));
				habMandal.setDate(rset.getString(17));
				habMandal.setRepairdate(rset.getString(18));
				habMandal.setRepairdesc(rset.getString(19));
				habMandal.setPlatformexistng(rset.getString(20));
				habMandal.setSOAKPIT(rset.getString(21));
				habMandal.setStaticDpth(rset.getString(22));
				habMandal.setSummerDpth(rset.getString(23));

				habMandal.setSourceTypeName("HandPumps");

				updateTestDetails(habMandal, conn);
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public ArrayList getPonds(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.POND_CODE,b.POND_LOCATION,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code "
					+ "   from RWS_OPENWELL_POND_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.POND_CODE,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.pond_code";
			// System.out.println("HAB query - ->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName("Ponds");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList getOpenWels(String habCode) {

		// System.out.println("openwells get");
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.OPENWELL_CODE,nvl(b.location,'-'),b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.STATUS,nvl(b.FLOURIDE_PER,0),nvl(b.BRAKISH_PER,0),nvl(b.IRON_PER,0),nvl(b.NITRATE,0),nvl(b.SAFE_LPD,0),nvl(b.UNSAFE_LPD,0), nvl(status,''),nvl(b.remarks,''),to_char(b.UPDATE_DATE,'dd/mm/yyyy'),to_char(b.REPAIR_DATE,'dd/mm/yyyy'),nvl(b.REPAIR_DESC,''),PLATFORM_EXISTING,SOAK_PIT  from RWS_OPEN_WELL_MAST_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.OPENWELL_CODE,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.OPENWELL_CODE";
			// System.out.println("OpenWel anuuuuul" + query);

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setStatus(rset.getString(8));
				habMandal.setFlouride(rset.getString(9));
				habMandal.setBrakish(rset.getString(10));
				habMandal.setIron(rset.getString(11));
				habMandal.setNitrate(rset.getString(12));

				habMandal.setSafeLpd(rset.getString(13));
				habMandal.setUnSafeLpd(rset.getString(14));
				habMandal.setRemarks(rset.getString(16));
				habMandal.setDate(rset.getString(17));
				habMandal.setRepairdate(rset.getString(18));
				habMandal.setRepairdesc(rset.getString(19));
				habMandal.setPlatformexistng(rset.getString(20));
				habMandal.setSOAKPIT(rset.getString(21));
				habMandal.setSourceTypeName("Open Wells");

				/**
				 * 
				 */
				updateTestDetails(habMandal, conn);
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList getGLBRs(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.hp_code,b.location,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.P_YEILD,b.STATUS  from RWS_HP_SUBCOMP_PARAM_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.hp_code,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.hp_code";
			// System.out.println("HAB query - ->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName("HandPumps");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList getOHBRs(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.hp_code,b.location,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.P_YEILD,b.STATUS  from RWS_HP_SUBCOMP_PARAM_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.hp_code,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.hp_code";
			// System.out.println("HAB query -in ohbrs ->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName("HandPumps");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList getOHSRs(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.hp_code,b.location,b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.P_YEILD,b.STATUS  from RWS_HP_SUBCOMP_PARAM_TBL  b ,RWS_ASSET_MAST_TBL c where substr(b.hp_code,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.hp_code";
			// System.out.println("HAB query - ohsr->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName("HandPumps");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/*
	 * For Assets
	 */

	public ArrayList getAssets(String dcode) {
		ArrayList assets = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		int i = 0;
		try {
			RwsHPRecord habMandal = null;

			i = i + 1;
			conn = RwsOffices.getConn();

			query = "select distinct AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS, AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE,atype.type_of_asset_name,d.dcode,d.dname,m.mcode,m.mname, p.pcode,p.pname,v.vcode, v.vname,h.panch_code,h.panch_name,nvl(am.programme_code,'')as programme_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd, RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST,rws_asset_type_tbl atype where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and AST.asset_code=AM.asset_code and am.hab_code=hd.hab_code and am.type_of_asset_code=atype.type_of_asset_code";
			if (dcode != null && !dcode.equals(""))
				query += " and substr(AM.HAB_CODE,1,2)='" + dcode + "'";
			query += " and AM.TYPE_OF_ASSET_CODE='03' order by am.type_of_asset_code";

			// System.out.println("HAB query - assetQuery->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				habMandal = new RwsHPRecord();
				habMandal.setAssetcode(rset.getString(1));
				habMandal.setAssetName1(rset.getString(2));
				habMandal.setTypeofassetcode(rset.getString(3));
				habMandal.setTypeofassetname(rset.getString("TYPE_OF_ASSET_NAME"));
				habMandal.setHabcode1(rset.getString(4));
				habMandal.setLocation1(rset.getString(5));
				habMandal.setDatecreation(rset.getString(6));
				habMandal.setAssetStatus(rset.getString(7));

				if (rset.getInt(7) == 1) {
					habMandal.setAssetStatusName("Working");
				} else if (rset.getInt(7) == 2) {
					habMandal.setAssetStatusName("Not Working");
				} else if (rset.getInt(7) == 3) {
					habMandal.setAssetStatusName("Dried");
				} else if (rset.getInt(7) == 4) {
					habMandal.setAssetStatusName("Seasonal");
				} else if (rset.getInt(7) == 5) {
					habMandal.setAssetStatusName("Condemed");
				}
				habMandal.setAssetcost(rset.getString(8));
				habMandal.setStartyear(rset.getString(9));
				habMandal.setEndyear(rset.getString(10));
				habMandal.setSchemecode(rset.getString(11));
				habMandal.setPanchName(rset.getString(18));
				habMandal.setVillName(rset.getString(20));
				habMandal.setHabitation(rset.getString(21));

				if (rset.getString("TYPE_OF_ASSET_CODE").equals("03"))
					habMandal.setSourceTypeName("cpws");
				assets.add(habMandal);

			}
			// System.out.println("assets size"+assets.size());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return assets;
	}

	public ArrayList getDpAssets(String dcode) {
		ArrayList assets = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		int i = 0;
		try {
			RwsHPRecord habMandal = null;

			i = i + 1;
			conn = RwsOffices.getConn();

			query = "select distinct AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS, AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE,atype.type_of_asset_name,d.dcode,d.dname,m.mcode,m.mname, p.pcode,p.pname,v.vcode, v.vname,h.panch_code,h.panch_name,nvl(am.programme_code,'')as programme_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd, RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST,rws_asset_type_tbl atype where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and AST.asset_code=AM.asset_code and am.hab_code=hd.hab_code and am.type_of_asset_code=atype.type_of_asset_code";
			if (dcode != null && !dcode.equals(""))
				query += " and substr(AM.HAB_CODE,1,2)='" + dcode + "'";
			query += " and AM.TYPE_OF_ASSET_CODE='09' order by am.type_of_asset_code";

			// System.out.println("HAB query - assetQuery->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				habMandal = new RwsHPRecord();
				habMandal.setAssetcode(rset.getString(1));
				habMandal.setAssetName1(rset.getString(2));
				habMandal.setTypeofassetcode(rset.getString(3));
				habMandal.setTypeofassetname(rset.getString("TYPE_OF_ASSET_NAME"));
				habMandal.setHabcode1(rset.getString(4));
				habMandal.setLocation1(rset.getString(5));
				habMandal.setDatecreation(rset.getString(6));
				habMandal.setAssetStatus(rset.getString(7));

				if (rset.getInt(7) == 1) {
					habMandal.setAssetStatusName("Working");
				} else if (rset.getInt(7) == 2) {
					habMandal.setAssetStatusName("Not Working");
				} else if (rset.getInt(7) == 3) {
					habMandal.setAssetStatusName("Dried");
				} else if (rset.getInt(7) == 4) {
					habMandal.setAssetStatusName("Seasonal");
				} else if (rset.getInt(7) == 5) {
					habMandal.setAssetStatusName("Condemed");
				}
				habMandal.setAssetcost(rset.getString(8));
				habMandal.setStartyear(rset.getString(9));
				habMandal.setEndyear(rset.getString(10));
				habMandal.setSchemecode(rset.getString(11));
				habMandal.setPanchName(rset.getString(18));
				habMandal.setVillName(rset.getString(20));
				habMandal.setHabitation(rset.getString(21));

				if (rset.getString("TYPE_OF_ASSET_CODE").equals("03"))
					habMandal.setSourceTypeName("cpws");
				assets.add(habMandal);

			}
			// System.out.println("assets size"+assets.size());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return assets;
	}

	///////////////////////////// Asset Related Habitations

	public ArrayList getHabitations(String assetcode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		int i = 0;
		try {
			RwsHPRecord habMandal = null;

			i = i + 1;
			conn = RwsOffices.getConn();
			query = "select asset_code,hab_code,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),a.SAFE_LPCD  from RWS_ASSET_HAB_TBL a,rws_complete_hab_view b  where a.hab_code=b.panch_code and asset_code='"
					+ assetcode + "' group by asset_code,hab_code,panch_name,a.SAFE_LPCD ";

			// System.out.println("Asset Related HABs->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				habMandal = new RwsHPRecord();

				habMandal.setAssetcode(rset.getString(1));
				habMandal.setHabitation(rset.getString(2));
				habMandal.setHabName(rset.getString(3));
				habMandal.setPopulation(rset.getString(4));
				habMandal.setSafelpcd(rset.getString(5));

				habMandal.setSourceTypeName("cpws");
				habs.add(habMandal);

				// System.out.println("assethabs"+habs);

			}
			// System.out.println("assethabs size in habitations anupama"+habs.size());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public void saveHabitations(HabitationNewEntry_Form habForm, String habcode, HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String updateQuery = "";
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			updateQuery = "update rws_asset_hab_tbl set SAFE_LPCD=? where HAB_CODE=? AND ASSET_CODE=?";

			stmt = conn.prepareStatement(updateQuery);
			// System.out.println("handpump update after execution"+updateQuery);
			int recCount = 0;
			// System.out.println("habForm.getHabs()"+habForm.getHabs().size());
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				// System.out.println("habForm.getHabs().get(i)"+habForm.getHabs().get(i));

				// System.out.println("rwsRecord.getChecks()"+rwsRecord.getChecks());
				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {

					// System.out.println("anu in getchecks");
					stmt.setString(1, rwsRecord.getSafelpcd());
					stmt.setString(2, rwsRecord.getHabitation());
					stmt.setString(3, rwsRecord.getAssetcode());
					// System.out.println("rwsRecord.getHabitation()"+rwsRecord.getHabitation());
					// System.out.println("rwsRecord.getHabitation()"+rwsRecord.getSafelpcd());
					// System.out.println("rwsRecord.getAssetcode()"+rwsRecord.getAssetcode());
					stmt.addBatch();

					recCount++;

				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {

				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				Debug.println("exceptinon in save assethabs" + e1);
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	public ArrayList getassethabs(String sourcecode) {
		ArrayList assethabs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		int i = 0;
		try {
			RwsHPRecord habMandal = null;

			i = i + 1;
			conn = RwsOffices.getConn();
			// if(sourcecode.substring(19,21).equals("OS") ||
			// sourcecode.substring(19,21).equals("GL") ||
			// sourcecode.substring(19,21).equals("CT"))
			if (sourcecode.substring(19, 21).equals("OS")) {

				// query ="select
				// HAB_CODE,SUBCOMP_CODE,YIELD,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)
				// from RWS_OHGLCI_HAB_LINK_TBL a,rws_complete_hab_view b where
				// a.hab_code=b.panch_code and SUBCOMP_CODE='"+sourcecode+"' group by
				// HAB_CODE,SUBCOMP_CODE,YIELD,panch_name ";
				query = "select distinct hab,source,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),YIELD from (select distinct HAB_CODE  as hab,OHSR_CODE as source from  RWS_AST_OHSR_SC_PARAM_TBL where OHSR_CODE='"
						+ sourcecode
						+ "' union select  distinct hab_code as hab,SUBCOMP_CODE as source from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"
						+ sourcecode
						+ "'),rws_complete_hab_view a,RWS_OHGLCI_HAB_LINK_TBL b where hab=a.panch_code  group by hab,source,panch_name,YIELD ";
			} else if (sourcecode.substring(19, 21).equals("GL")) {
				query = "select distinct hab,source,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),YIELD from (select distinct HAB_CODE as hab,GLSR_CODE as source from RWS_AST_GLSR_SC_PARAM_TBL  where GLSR_CODE='"
						+ sourcecode
						+ "' union select  distinct hab_code as hab,SUBCOMP_CODE as source from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"
						+ sourcecode
						+ "'),rws_complete_hab_view a,RWS_OHGLCI_HAB_LINK_TBL b where hab=a.panch_code  group by hab,source,panch_name,YIELD ";
			} else if (sourcecode.substring(19, 21).equals("SO")) {
				query = "select distinct hab,source,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),lpd  from (select distinct HAB_CODE as hab,SOURCE_CODE as source,yield as lpd from RWS_SOURCE_TBL  where SOURCE_CODE='"
						+ sourcecode
						+ "' union select  distinct hab_code as hab,SOURCE_CODE as source,yield as lpd  from RWS_SOURCE_HABITATION_TBL where SOURCE_CODE='"
						+ sourcecode
						+ "'),rws_complete_hab_view a,RWS_SOURCE_HABITATION_TBL b where hab=a.panch_code  group by hab,source,panch_name,lpd";
			} else if (sourcecode.substring(19, 21).equals("GB")) {
				query = "select distinct hab,source,panch_name,sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),lpd  from (select distinct HAB_CODE as hab,GLBR_CODE as source,nvl(STAGING,0) as lpd from RWS_AST_GLBR_SC_PARAM_TBL  where GLBR_CODE='"
						+ sourcecode
						+ "'),rws_complete_hab_view a where hab=a.panch_code   group by hab,source,panch_name,lpd";
			}

			// System.out.println("HAB query - habquery anuuuI N OS->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				habMandal = new RwsHPRecord();

				habMandal.setHabitation(rset.getString(1));
				habMandal.setSourceCode(rset.getString(2));
				habMandal.setSafelpcd(rset.getString(5));
				habMandal.setHabName(rset.getString(3));
				habMandal.setPopulation(rset.getString(4));

				habMandal.setSourceTypeName("cpws");
				assethabs.add(habMandal);

			}
			// System.out.println("assethabs size"+assethabs.size());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return assethabs;
	}

	////////////// source details cpws////

	public ArrayList sourcedetails(String assetcode) {
		ArrayList assetsources = new ArrayList();
		String query = "";
		String query1 = "";
		String query2 = "";
		String query3 = "";
		String query4 = "";
		String query5 = "";
		String query6 = "";
		String query7 = "";

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

		ResultSet rset = null;
		ResultSet rset1 = null;
		ResultSet rset2 = null;
		ResultSet rset3 = null;
		ResultSet rset4 = null;
		ResultSet rset5 = null;
		ResultSet rset6 = null;
		ResultSet rset7 = null;
		ResultSet rset8 = null;
		int i = 0;
		try {
			RwsHPRecord habMandal = null;

			i = i + 1;
			conn = RwsOffices.getConn();

			query = "SELECT * FROM RWS_SOURCE_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query1 = "SELECT * FROM RWS_HP_SUBCOMP_PARAM_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query2 = "select * from RWS_SHALLOWHANDPUMPS_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query3 = "select * from RWS_OPEN_WELL_MAST_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query4 = "select * from RWS_AST_GLSR_SC_PARAM_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query5 = "select * from RWS_AST_OHSR_SC_PARAM_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query6 = "select * from RWS_AST_GLBR_SC_PARAM_TBL WHERE ASSET_CODE='" + assetcode + "'";
			query7 = "select * from  RWS_OPENWELL_POND_TBL  WHERE ASSET_CODE='" + assetcode + "'";

			// System.out.println("HAB query - habquery6->" + query6);

			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();
			stmt5 = conn.createStatement();
			stmt6 = conn.createStatement();
			stmt7 = conn.createStatement();

			rset = stmt.executeQuery(query);
			rset1 = stmt1.executeQuery(query1);
			rset2 = stmt2.executeQuery(query2);
			rset3 = stmt3.executeQuery(query3);
			rset4 = stmt4.executeQuery(query4);
			rset5 = stmt5.executeQuery(query5);
			rset6 = stmt6.executeQuery(query6);
			rset7 = stmt7.executeQuery(query7);
			if (rset != null) {
				while (rset.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset.getString("SOURCE_CODE"));

					habMandal.setHabitation(rset.getString("HAB_CODE"));
					habMandal.setCoveragestatus(rset.getString("STATUS"));
					habMandal.setSafelpcd(rset.getString("SAFE_LPD"));
					habMandal.setUnsafelpcd(rset.getString("UNSAFE_LPD"));
					habMandal.setLatitude(rset.getString("LATITUDE"));
					habMandal.setLongitude(rset.getString("LONGITUDE"));
					habMandal.setElevation(rset.getString("ELEVATION"));
					habMandal.setFlouride(rset.getString("FLOURIDE"));
					habMandal.setBrakish(rset.getString("BRAKISH"));
					habMandal.setIron(rset.getString("IRON"));
					habMandal.setNitrate(rset.getString("NITRATE"));
					habMandal.setAssetcode(rset.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size1"+assetsources.size());

				}
			}
			rset.close();

			if (rset1 != null) {
				while (rset1.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset1.getString("hp_CODE"));
					habMandal.setHabitation(rset1.getString("HAB_CODE"));
					habMandal.setCoveragestatus(rset1.getString("STATUS"));
					habMandal.setSafelpcd(rset1.getString("SAFE_LPD"));
					habMandal.setUnsafelpcd(rset1.getString("UNSAFE_LPD"));
					habMandal.setLatitude(rset1.getString("LATITUDE"));
					habMandal.setLongitude(rset1.getString("LONGITUDE"));
					habMandal.setElevation(rset1.getString("ELEVATION"));
					habMandal.setFlouride(rset1.getString("FLOURIDE"));
					habMandal.setBrakish(rset1.getString("BRAKISH"));
					habMandal.setIron(rset1.getString("IRON"));
					habMandal.setNitrate(rset1.getString("NITRATE"));
					habMandal.setAssetcode(rset1.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size2"+assetsources.size());

				}

			}
			rset1.close();
			if (rset2 != null) {
				while (rset2.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset2.getString("SHALLOWHP_CODE"));
					habMandal.setHabitation(rset2.getString("HAB_CODE"));
					habMandal.setCoveragestatus(rset2.getString("STATUS"));
					habMandal.setSafelpcd(rset2.getString("SAFE_LPD"));
					habMandal.setUnsafelpcd(rset2.getString("UNSAFE_LPD"));
					habMandal.setLatitude(rset2.getString("LATITUDE"));
					habMandal.setLongitude(rset2.getString("LONGITUDE"));
					habMandal.setElevation(rset2.getString("ELEVATION"));
					habMandal.setFlouride(rset2.getString("FLOURIDE"));
					habMandal.setBrakish(rset2.getString("BRAKISH"));
					habMandal.setIron(rset2.getString("IRON"));
					habMandal.setNitrate(rset2.getString("NITRATE"));
					habMandal.setSourceTypeName("cpws");
					habMandal.setAssetcode(rset2.getString("ASSET_CODE"));
					assetsources.add(habMandal);

					// System.out.println("assethabs size3"+assetsources.size());

				}
			}

			rset2.close();

			if (rset3 != null) {
				while (rset3.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset3.getString("OPENWELL_CODE"));
					habMandal.setHabitation(rset3.getString("HABITATION_CODE"));
					habMandal.setCoveragestatus(rset3.getString("STATUS"));
					habMandal.setSafelpcd(rset3.getString("SAFE_LPD"));
					habMandal.setUnsafelpcd(rset3.getString("UNSAFE_LPD"));
					habMandal.setLatitude(rset3.getString("LATITUDE"));
					habMandal.setLongitude(rset3.getString("LONGITUDE"));
					habMandal.setElevation(rset3.getString("ELEVATION"));
					habMandal.setFlouride(rset3.getString("FLOURIDE"));
					habMandal.setBrakish(rset3.getString("BRAKISH"));
					habMandal.setIron(rset3.getString("IRON"));
					habMandal.setNitrate(rset3.getString("NITRATE"));
					habMandal.setAssetcode(rset3.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size4"+assetsources.size());

				}

			}

			rset3.close();
			if (rset4 != null) {
				while (rset4.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset4.getString("GLSR_CODE"));
					habMandal.setHabitation(rset4.getString("HAB_CODE"));
					habMandal.setLatitude(rset4.getString("LATITUDE"));
					habMandal.setLongitude(rset4.getString("LONGITUDE"));
					habMandal.setElevation(rset4.getString("ELEVATION"));
					habMandal.setAssetcode(rset4.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size4"+assetsources.size());

				}
			}

			rset4.close();
			if (rset5 != null) {
				while (rset5.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset5.getString("OHSR_CODE"));
					habMandal.setHabitation(rset5.getString("HAB_CODE"));
					habMandal.setLatitude(rset5.getString("LATITUDE"));
					habMandal.setLongitude(rset5.getString("LONGITUDE"));
					habMandal.setElevation(rset5.getString("ELEVATION"));
					habMandal.setAssetcode(rset5.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size4"+assetsources.size());

				}
			}

			rset5.close();
			if (rset6 != null) {
				while (rset6.next()) {
					habMandal = new RwsHPRecord();
					habMandal.setSourceCode(rset6.getString("GLBR_CODE"));
					habMandal.setHabitation(rset6.getString("HAB_CODE"));
					habMandal.setLatitude(rset6.getString("LATITUDE"));
					habMandal.setLongitude(rset6.getString("LONGITUDE"));
					habMandal.setElevation(rset6.getString("ELEVATION"));
					habMandal.setAssetcode(rset6.getString("ASSET_CODE"));

					habMandal.setSourceTypeName("cpws");
					assetsources.add(habMandal);

					// System.out.println("assethabs size4"+assetsources.size());

				}
			}

			rset6.close();

			while (rset7.next()) {
				habMandal = new RwsHPRecord();
				habMandal.setSourceCode(rset7.getString("POND_CODE"));
				habMandal.setHabitation(rset7.getString("HAB_CODE"));
				habMandal.setLatitude(rset7.getString("FLOURIDE"));
				habMandal.setLongitude(rset7.getString("BRAKISH"));
				habMandal.setElevation(rset7.getString("IRON"));
				habMandal.setAssetcode(rset7.getString("ASSET_CODE"));

				habMandal.setSourceTypeName("cpws");
				assetsources.add(habMandal);

				// System.out.println("assethabs size7"+assetsources.size());

			}

			// System.out.println("assethabs totals"+assetsources.size());

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt1 != null) {
				try {
					stmt1.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt2 != null) {
				try {
					stmt2.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt3 != null) {
				try {
					stmt3.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt4 != null) {
				try {
					stmt4.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt5 != null) {
				try {
					stmt5.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (stmt6 != null) {
				try {
					stmt6.close();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}
		return assetsources;
	}

	public void saveSources(HabitationNewEntry_Form habForm, HttpServletRequest request) {
		// System.out.println("in ssavesources");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String updateQuery = "";
		try {

			String sourceCode = request.getParameter("source");
			// System.out.println("sourceCode"+sourceCode);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			if (sourceCode.substring(19, 21).equals("SO")) {
				updateQuery = "update rws_source_tbl set SAFE_LPD=?,UNSAFE_LPD=?,LATITUDE=?,LONGITUDE=?,ELEVATION=?,FLOURIDE=?,BRAKISH=?,IRON=?,NITRATE=? where source_code=?";
			} else if (sourceCode.substring(19, 21).equals("HP")) {
				updateQuery = "update RWS_HP_SUBCOMP_PARAM_TBL set SAFE_LPD=?,UNSAFE_LPD=?,LATITUDE=?,LONGITUDE=?,ELEVATION=?,FLOURIDE=?,BRAKISH=?,IRON=?,NITRATE=? where hp_code=?";
			}

			else if (sourceCode.substring(19, 21).equals("OW")) {
				updateQuery = "update  RWS_OPEN_WELL_MAST_TBL set SAFE_LPD=?,UNSAFE_LPD=?,LATITUDE=?,LONGITUDE=?,ELEVATION=?,FLOURIDE_PER =?,BRAKISH_PER=?,IRON_PER=?,NITRATE=? where OPENWELL_CODE=?";
			} else if (sourceCode.substring(19, 21).equals("SH")) {
				updateQuery = "update  RWS_SHALLOWHANDPUMPS_TBL set SAFE_LPD=?,UNSAFE_LPD=?,LATITUDE=?,LONGITUDE=?,ELEVATION=?,FLOURIDE_PER =?,BRAKISH_PER=?,IRON_PER=?,NITRATE_PER  where SHALLOWHP_CODE=?";

			}

			else if (sourceCode.substring(19, 21).equals("GL")) {
				updateQuery = "update  RWS_AST_GLSR_SC_PARAM_TBL set LATITUDE=?,LONGITUDE=?,ELEVATION=? where GLSR_CODE=?";

			}

			else if (sourceCode.substring(19, 21).equals("OS")) {
				updateQuery = "update  RWS_AST_OHSR_SC_PARAM_TBL  set LATITUDE=?,LONGITUDE=?,ELEVATION=? where OHSR_CODE=?";

			} else if (sourceCode.substring(19, 21).equals("GB")) {
				updateQuery = "update  RWS_AST_GLBR_SC_PARAM_TBL set LATITUDE=?,LONGITUDE=?,ELEVATION=? where GLBR_CODE =?";

			}

			// String updateQuery="update RWS_HP_SUBCOMP_PARAM_TBL set
			// SAFE_LPD='"+habForm.getSafeLpd()+"' ";

			stmt = conn.prepareStatement(updateQuery);
			// System.out.println("handpump update after execution anu
			// insource"+updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {
				// System.out.println("infor");

				// System.out.println("inifff anuu"+ habForm.getHabs().size());
				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				stmt.setString(1, rwsRecord.getSafelpcd());
				// System.out.println("unsafe"+rwsRecord.getSafelpcd());
				stmt.setString(2, rwsRecord.getUnsafelpcd());
				// System.out.println("unsafe"+rwsRecord.getUnsafelpcd());
				stmt.setString(3, rwsRecord.getLatitude());
				// System.out.println("unsafe"+rwsRecord.getLatitude());

				stmt.setString(4, rwsRecord.getLongitude());

				// System.out.println("unsafe"+rwsRecord.getLongitude());
				stmt.setString(5, rwsRecord.getElevation());
				stmt.setString(6, rwsRecord.getFlouride());
				stmt.setString(7, rwsRecord.getBrakish());
				stmt.setString(8, rwsRecord.getIron());
				stmt.setString(9, rwsRecord.getNitrate());
				stmt.setString(10, rwsRecord.getSourceCode());

				stmt.addBatch();

				recCount++;

			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {

				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				Debug.println("exceptinon in save assethabs" + e1);
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	//////////////////////////////

	/////////// habs saving/////

	public void saveassetHabs(HabitationNewEntry_Form habForm, String sourcecode, HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		String updateQuery = "";
		try {

			// System.out.println("sourcecode"+sourcecode);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			if (sourcecode.substring(19, 21).equals("OS") || sourcecode.substring(19, 21).equals("GL")) {
				// String updateQuery = "update rws_habitation_directory_tbl set
				// SAFE_LPCD=?,UNSAFE_LPCD=? where HAB_CODE=?";
				updateQuery = "update RWS_OHGLCI_HAB_LINK_TBL set HAB_CODE=?,SUBCOMP_CODE=?,YIELD=? where HAB_CODE=?";
				// String updateQuery="update RWS_HP_SUBCOMP_PARAM_TBL set
				// SAFE_LPD='"+habForm.getSafeLpd()+"' ";
			} else if (sourcecode.substring(19, 21).equals("SO")) {
				updateQuery = "update RWS_SOURCE_HABITATION_TBL set HAB_CODE=?,SOURCE_CODE=?,YIELD=? where HAB_CODE=?";
			}
			// System.out.println("habitation directory update"+updateQuery);
			stmt = conn.prepareStatement(updateQuery);
			// System.out.println("handpump update after execution"+updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);
				// System.out.println("rwsRecord.getChecks()"+rwsRecord.getChecks());
				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {

					stmt.setString(1, rwsRecord.getHabitation());
					stmt.setString(2, rwsRecord.getSourceCode());
					stmt.setString(3, rwsRecord.getSafelpcd());
					stmt.setString(4, rwsRecord.getHabitation());

					// System.out.println("rwsRecord.getHabitation()"+rwsRecord.getHabitation());
					// System.out.println("rwsRecord.getHabitation()"+rwsRecord.getSafelpcd());
					stmt.addBatch();

					recCount++;

				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {

				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				Debug.println("exceptinon in save assethabs" + e1);
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	//////////////////
	public void saveSchemeSourceDetails(HabitationNewEntry_Form habForm, HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// get current date time with Date()
			Date date = new Date();
			// System.out.println(dateFormat.format(date));
			String today = dateFormat.format(date);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			String updateQuery = "update rws_source_tbl set SAFE_LPD=?,UNSAFE_LPD=?,FLOURIDE=?,BRAKISH =?,IRON =?,NITRATE =? ,status=? ,remarks=?,YIELD=? ,LATITUDE =?,LONGITUDE =?,ELEVATION =?,UPDATE_DATE=to_date(?,'dd/mm/yyyy'),SOURCE_DETAILS=?,PLATFORM_EXISTING=?,SOAK_PIT=?  where source_code=?";
			stmt = conn.prepareStatement(updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {
					// System.out.println("wsRecord.getChecks()"+rwsRecord.getChecks());
					stmt.setString(1, rwsRecord.getSafeLpd());
					stmt.setString(2, rwsRecord.getUnSafeLpd());
					stmt.setString(3, rwsRecord.getFlouride());
					stmt.setString(4, rwsRecord.getBrakish());
					stmt.setString(5, rwsRecord.getIron());
					stmt.setString(6, rwsRecord.getNitrate());
					stmt.setString(7, rwsRecord.getStatus());
					stmt.setString(8, rwsRecord.getRemarks());
					stmt.setString(9, rwsRecord.getYield());
					stmt.setString(10, rwsRecord.getLatitude());
					stmt.setString(11, rwsRecord.getLongitude());
					stmt.setString(12, rwsRecord.getElevation());
					/* stmt.setString(13, today); */
					// java.sql.Date date1 = getCurrentJavaSqlDate();
					stmt.setString(13, today);
					stmt.setString(14, rwsRecord.getSourcedetails());
					stmt.setString(15, rwsRecord.getPlatformexistng());
					stmt.setString(16, rwsRecord.getSOAKPIT());

					stmt.setString(17, rwsRecord.getHpCode());

					stmt.addBatch();
					recCount++;
					// System.out.println("updateQuery"+updateQuery);
				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	/**
	 * 
	 * @param habForm
	 * @param request
	 */
	public void saveHandPumpDetails(HabitationNewEntry_Form habForm, HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// get current date time with Date()
			Date date = new Date();
			// System.out.println(dateFormat.format(date));
			String today = dateFormat.format(date);

			System.out.println("today" + today);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			String updateQuery = "update RWS_HP_SUBCOMP_PARAM_TBL set SAFE_LPD=?,UNSAFE_LPD=?,FLOURIDE=?,BRAKISH =?,IRON =?,NITRATE =?,status=? ,remarks=?,P_YEILD=?,LATITUDE =?,LONGITUDE =?,ELEVATION =?,UPDATE_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DESC=?,PLATFORM_EXISTING=?,SOAK_PIT=?,STATIC_WL=?,SUMMER_WL =?  where hp_code=?";

			// String updateQuery="update RWS_HP_SUBCOMP_PARAM_TBL set
			// SAFE_LPD='"+habForm.getSafeLpd()+"' ";
			System.out.println("handpump update" + updateQuery);
			stmt = conn.prepareStatement(updateQuery);
			System.out.println("handpump update after execution" + updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {
					// System.out.println("today in rwsRecord.getChecks()"+rwsRecord.getChecks());
					stmt.setString(1, rwsRecord.getSafeLpd());

					// System.out.println("rwsRecord.getSafeLpd()"+rwsRecord.getSafeLpd());
					stmt.setString(2, rwsRecord.getUnSafeLpd());
					stmt.setString(3, rwsRecord.getFlouride());
					stmt.setString(4, rwsRecord.getBrakish());
					stmt.setString(5, rwsRecord.getIron());
					stmt.setString(6, rwsRecord.getNitrate());
					stmt.setString(7, rwsRecord.getStatus());
					stmt.setString(8, rwsRecord.getRemarks());
					stmt.setString(9, rwsRecord.getYield());
					stmt.setString(10, rwsRecord.getLatitude());
					stmt.setString(11, rwsRecord.getLongitude());
					stmt.setString(12, rwsRecord.getElevation());
					stmt.setString(13, today);
					stmt.setString(14, rwsRecord.getRepairdate());
					/*
					 * java.sql.Date date1 = getCurrentJavaSqlDate(); stmt.setDate(13, date1);
					 */

					/*
					 * java.sql.Date date1 = getJavaSqlDate(today); stmt.setDate(13, date1);
					 * 
					 * java.sql.Date repairdate1 = getJavaSqlDate(rwsRecord.getRepairdate());
					 * stmt.setDate(14, repairdate1);
					 */

					stmt.setString(15, rwsRecord.getRepairdesc());
					stmt.setString(16, rwsRecord.getPlatformexistng());
					stmt.setString(17, rwsRecord.getSOAKPIT());
					stmt.setString(18, rwsRecord.getStaticDpth());
					stmt.setString(19, rwsRecord.getSummerDpth());
					stmt.setString(20, rwsRecord.getHpCode());

					stmt.addBatch();

					recCount++;

				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	/**
	 * 
	 * @param habForm
	 * @param request
	 */
	public void saveOpenWellDetails(HabitationNewEntry_Form habForm, HttpServletRequest request) {
		// System.out.println("update openwell");

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// get current date time with Date()
			Date date = new Date();
			// System.out.println(dateFormat.format(date));
			String today = dateFormat.format(date);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			String updateQuery = "update RWS_OPEN_WELL_MAST_TBL set SAFE_LPD=?,UNSAFE_LPD=?,FLOURIDE_PER=?,BRAKISH_PER =?,IRON_PER =?,NITRATE =?,status=? ,remarks=?,LATITUDE =?,LONGITUDE =?,ELEVATION =?,UPDATE_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DESC=?,PLATFORM_EXISTING=?,SOAK_PIT=?  where OPENWELL_CODE=?";
			stmt = conn.prepareStatement(updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {
					stmt.setString(1, rwsRecord.getSafeLpd());
					stmt.setString(2, rwsRecord.getUnSafeLpd());
					stmt.setString(3, rwsRecord.getFlouride());
					stmt.setString(4, rwsRecord.getBrakish());
					stmt.setString(5, rwsRecord.getIron());
					stmt.setString(6, rwsRecord.getNitrate());
					stmt.setString(7, rwsRecord.getStatus());
					stmt.setString(8, rwsRecord.getRemarks());
					stmt.setString(9, rwsRecord.getLatitude());
					stmt.setString(10, rwsRecord.getLongitude());
					stmt.setString(11, rwsRecord.getElevation());
					stmt.setString(12, today);
					stmt.setString(13, rwsRecord.getRepairdate());
					// java.sql.Date date1 = getCurrentJavaSqlDate();
					// stmt.setDate(12, date1);

					// java.sql.Date repairdate1 = getJavaSqlDate(rwsRecord.getRepairdate());
					// stmt.setDate(13, repairdate1);

					stmt.setString(14, rwsRecord.getRepairdesc());
					stmt.setString(15, rwsRecord.getPlatformexistng());
					stmt.setString(16, rwsRecord.getSOAKPIT());
					stmt.setString(17, rwsRecord.getHpCode());

					stmt.addBatch();
					recCount++;
				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	/**
	 */
	public ArrayList getPanchayats(String dcode, String mcode) {
		ArrayList panchyats = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE" + " DCODE='" + dcode
					+ "' and MCODE='" + mcode + "' ORDER BY PNAME";
			// System.out.println("query in getPanchayats is "+query);
			rset = stmt.executeQuery(query);
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));

				panchyats.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return panchyats;
	}

	/**
	 * 
	 * @param habCode
	 * @return
	 */
	public ArrayList getShallowHandpumps(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.SHALLOWHP_CODE ,nvl(b.location,'-'),b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.STATUS,nvl(b.FLORIDE_PER,0),nvl(b.BRAKISH_PER,0),nvl(b.IRON_PER,0),nvl(b.NITRATE_PER,0),nvl(b.SAFE_LPD,0),nvl(b.UNSAFE_LPD,0),nvl(b.remarks,''),b.YIELD,to_char(b.UPDATE_DATE,'dd/mm/yyyy'),to_char(b.REPAIR_DATE,'dd/mm/yyyy'),nvl(REPAIR_DESC,''),PLATFORM_EXISTING,SOAK_PIT  from RWS_SHALLOWHANDPUMPS_TBL   b ,RWS_ASSET_MAST_TBL c where substr(b.SHALLOWHP_CODE,1,16)='"
					+ habCode + "'  and " + " b.asset_code=c.asset_code order by b.SHALLOWHP_CODE";
			// System.out.println("shallowhandpump123" + query);

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));
				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setStatus(rset.getString(8));
				habMandal.setFlouride(rset.getString(9));
				habMandal.setBrakish(rset.getString(10));
				habMandal.setIron(rset.getString(11));
				habMandal.setNitrate(rset.getString(12));

				habMandal.setSafeLpd(rset.getString(13));
				habMandal.setUnSafeLpd(rset.getString(14));
				habMandal.setRemarks(rset.getString(15));
				habMandal.setYield(rset.getString(16));
				habMandal.setDate(rset.getString(17));
				habMandal.setRepairdate(rset.getString(18));
				habMandal.setRepairdesc(rset.getString(19));
				habMandal.setPlatformexistng(rset.getString(20));
				habMandal.setSOAKPIT(rset.getString(21));

				habMandal.setSourceTypeName("Open Wells");

				/**
				 * 
				 */
				updateTestDetails(habMandal, conn);
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	/**
	 * 
	 * @param habForm
	 * @param request
	 */
	public void saveShallowHandpumps(HabitationNewEntry_Form habForm, HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			// get current date time with Date()
			java.util.Date date = new java.util.Date();
			Debug.println(dateFormat.format(date));
			String today = dateFormat.format(date);
			Debug.println("today" + today);

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			String updateQuery = "update RWS_SHALLOWHANDPUMPS_TBL set SAFE_LPD=?,UNSAFE_LPD=?,FLORIDE_PER=?,BRAKISH_PER =?,IRON_PER =?,NITRATE_PER =?,status=? ,remarks=? ,LATITUDE =?,LONGITUDE =?,ELEVATION =?,UPDATE_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DATE=to_date(?,'dd/mm/yyyy'),REPAIR_DESC=?,PLATFORM_EXISTING=?,SOAK_PIT=?  where SHALLOWHP_CODE=?";
			// System.out.println("updateQuery---"+updateQuery);
			stmt = conn.prepareStatement(updateQuery);
			int recCount = 0;
			for (int i = 0; i < habForm.getHabs().size(); i++) {

				RwsHPRecord rwsRecord = habForm.getHabs().get(i);

				if (rwsRecord.getChecks() != null && rwsRecord.getChecks().equals("on")) {
					stmt.setString(1, rwsRecord.getSafeLpd());
					stmt.setString(2, rwsRecord.getUnSafeLpd());
					stmt.setString(3, rwsRecord.getFlouride());
					stmt.setString(4, rwsRecord.getBrakish());
					stmt.setString(5, rwsRecord.getIron());
					stmt.setString(6, rwsRecord.getNitrate());
					stmt.setString(7, rwsRecord.getStatus());
					stmt.setString(8, rwsRecord.getRemarks());

					stmt.setString(9, rwsRecord.getLatitude());
					stmt.setString(10, rwsRecord.getLongitude());
					stmt.setString(11, rwsRecord.getElevation());
					java.sql.Date date1 = getJavaSqlDate(today);
					stmt.setString(12, today);
					// Debug.println("date1"+date1);
					/* java.sql.Date repairdate1 = getJavaSqlDate(rwsRecord.getRepairdate()); */
					stmt.setString(13, rwsRecord.getRepairdate());
					/*
					 * stmt.setString(12, today); stmt.setString(13, rwsRecord.getRepairdate());
					 */
					stmt.setString(14, rwsRecord.getRepairdesc());
					stmt.setString(15, rwsRecord.getPlatformexistng());
					stmt.setString(16, rwsRecord.getSOAKPIT());
					stmt.setString(17, rwsRecord.getHpCode());

					stmt.addBatch();
					recCount++;
				}
			}

			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				request.setAttribute("message", "Records Updated Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				request.setAttribute("message", "Updation Failed");
			}

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			request.setAttribute("message", "Updation Failed");
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	private java.sql.Date getJavaSqlDate(String repairdate) {
		// TODO Auto-generated method stub
		return null;
	}

	private java.sql.Date getCurrentJavaSqlDate() {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList getDPs(String habCode) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "	select b.source_code,nvl(b.location,'-'),b.latitude,b.longitude ,b.elevation, c.asset_name,c.asset_code ,"
					+ " b.YIELD,b.SOURCE_CONDITION ,nvl(d.SOURCE_TYPE_NAME,'-') ,nvl(b.FLOURIDE,0),nvl(b.BRAKISH,0),nvl(b.IRON,0),nvl(b.NITRATE,0),nvl(b.SAFE_LPD,0),nvl(b.UNSAFE_LPD,0), nvl(status,''),nvl(b.remarks,''),to_char(b.UPDATE_DATE,'dd/mm/yyyy'),NVL(b.SOURCE_DETAILS,''),PLATFORM_EXISTING,SOAK_PIT from rws_source_tbl b ,RWS_ASSET_MAST_TBL c,rws_source_type_tbl d  where  substr(b.source_code,1,16)='"
					+ habCode + "'  and "
					+ " b.asset_code=c.asset_code and TYPE_OF_ASSET_CODE ='09'  and d.SOURCE_TYPE_CODE=b.SOURCE_TYPE_CODE  order by b.source_code";
			// System.out.println("HAB query - ->" + query);

			// System.out.println("HAB query - assetQuery->" + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				// System.out.println("Record");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setHpCode(rset.getString(1));

				habMandal.setLocation(rset.getString(2));
				habMandal.setLatitude(rset.getString(3));
				habMandal.setLongitude(rset.getString(4));
				habMandal.setElevation(rset.getString(5));
				habMandal.setAssetName(rset.getString(6));
				habMandal.setAssetCode(rset.getString(7));
				habMandal.setYield(rset.getString(8));
				habMandal.setStatus(rset.getString(9));
				habMandal.setSourceTypeName(rset.getString(10));
				habMandal.setFlouride(rset.getString(11));
				habMandal.setBrakish(rset.getString(12));
				habMandal.setIron(rset.getString(13));
				habMandal.setNitrate(rset.getString(14));

				habMandal.setSafeLpd(rset.getString(15));
				habMandal.setUnSafeLpd(rset.getString(16));
				habMandal.setStatus(rset.getString(17));
				habMandal.setRemarks(rset.getString(18));
				habMandal.setDate(rset.getString(19));
				habMandal.setSourcedetails(rset.getString(20));
				habMandal.setPlatformexistng(rset.getString(21));
				habMandal.setSOAKPIT(rset.getString(22));

				habMandal.setSourceTypeName("HandPumps");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public ArrayList getAllAssetTypes() throws Exception {
		ArrayList assets = new ArrayList();
		try {
			HabitationNewEntry_Form habMandal = null;
			conn = RwsOffices.getConn();
			String query = "select * from rws_asset_type_tbl order by type_of_asset_code";
			ps = conn.prepareStatement(query);
			ResultSet rset = ps.executeQuery();

			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setAssetTypeCode(rset.getString(1));
				habMandal.setAssetType(rset.getString(2));
				assets.add(habMandal);
			}
			rset.close();

		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in get all assets is " + e);
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return assets;
	}

	public ArrayList getPanchayats1(String dcode, String mcode) throws Exception{
		ArrayList panchyats = new ArrayList();
		HabitationNewEntry_Form habMandal = null;		
		try {
			conn = RwsOffices.getConn();			
			String query = "SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE=? and MCODE=? ORDER BY PNAME";
			ps=conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setPcode(rset.getString(1));
				habMandal.setPname(rset.getString(2));
				panchyats.add(habMandal);
			}			
		} catch (Exception e) {
			System.out.println("Exception is at getPanchayats1 of RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return panchyats;
	}

	public ArrayList getVillages(String dcode, String mcode, String pcode) throws Exception{
		ArrayList villages = new ArrayList();
		HabitationNewEntry_Form habMandal = null;	
		try {
			conn = RwsOffices.getConn();			
			String query = "SELECT DISTINCT VCODE,VNAME FROM RWS_VILLAGE_TBL WHERE DCODE=? and "
					+ "MCODE=? and PCODE=? ORDER BY VNAME";
			ps=conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setVillageCode(rset.getString(1));
				habMandal.setVillageName(rset.getString(2));
				villages.add(habMandal);
			}
			stmt.close();
		} catch (Exception e) {
			System.out.println("Exception is at getVillages of RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return villages;
	}

	public ArrayList<RwsHPRecord> getRepaires(String asttype) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "select REPAIR_CODE,REPAIR_NAME from rws_asset_repair_type_tbl where TYPE_OF_ASSET_CODE='" + asttype
					+ "'";
			// System.out.println("HAB query -hhpanuu 213 ->" + query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setRepairCode(rset.getString("REPAIR_CODE"));
				habMandal.setRepairName(rset.getString("REPAIR_NAME"));
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public ArrayList<RwsHPRecord> getHandPumpsRepair(String dcode, String mcode, String vcode) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			query = "select a.hp_code,a.location,a.STATUS,to_char(a.REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,a.REPAIR_CODE,nvl(a.REPAIR_COST,0) as REPAIR_COST,nvl(b.COMPO_LAT,0) as COMPO_LAT,nvl(b.COMPO_LON,0) as COMPO_LON,b.COMPO_IMAGE from RWS_ASSET_MAST_TBL c,RWS_HP_SUBCOMP_PARAM_TBL a left join RWS_ASSET_COMPONENT_IMAGE_TBL b on (b.ASSET_CODE=a.ASSET_CODE and a.hp_code=b.ASSET_COMPONENT)"
					+ " where substr(a.hp_code,1,2)='" + dcode + "' and " + " substr(a.hp_code,6,2)='" + mcode
					+ "' and " + " substr(a.hp_code,8,3)='" + vcode + "' and " + " a.ASSET_CODE=c.ASSET_CODE";
			// System.out.println("HAB query -hhpanuu 213 ->" + query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				java.sql.Blob a = rset.getBlob("COMPO_IMAGE");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setSourceCode(rset.getString("hp_code"));
				habMandal.setLocation(rset.getString("location"));
				habMandal.setStatus(rset.getString("STATUS"));
				habMandal.setRepairCost(rset.getString("REPAIR_COST"));
				habMandal.setRepairCode(rset.getString("REPAIR_CODE"));
				habMandal.setRepairdate(rset.getString("REPAIR_DATE"));
				habMandal.setSourceTypeName("HandPumps");
				habMandal.setLatitude(rset.getString("COMPO_LAT"));
				habMandal.setLongitude(rset.getString("COMPO_LON"));
				if (a == null)
					habMandal.setImgStatus("No");
				else
					habMandal.setImgStatus("Yes");

				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public ArrayList<RwsHPRecord> getSHPRepair(String dcode, String mcode, String vcode) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();

			query = "select a.SHALLOWHP_CODE,a.location,a.STATUS,to_char(a.REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,a.REPAIR_CODE,nvl(a.REPAIR_COST,0) as REPAIR_COST,nvl(b.COMPO_LAT,0) as COMPO_LAT,nvl(b.COMPO_LON,0) as COMPO_LON,b.COMPO_IMAGE from RWS_ASSET_MAST_TBL c,RWS_SHALLOWHANDPUMPS_TBL a left join RWS_ASSET_COMPONENT_IMAGE_TBL b on (b.ASSET_CODE=a.ASSET_CODE and a.SHALLOWHP_CODE=b.ASSET_COMPONENT)"
					+ " where substr(a.SHALLOWHP_CODE,1,2)='" + dcode + "' and " + " substr(a.SHALLOWHP_CODE,6,2)='"
					+ mcode + "' and " + " substr(a.SHALLOWHP_CODE,8,3)='" + vcode + "' and "
					+ " a.ASSET_CODE=c.ASSET_CODE";
			// System.out.println("HAB query -hhpanuu 213 ->" + query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				java.sql.Blob a = rset.getBlob("COMPO_IMAGE");
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setSourceCode(rset.getString("SHALLOWHP_CODE"));
				habMandal.setLocation(rset.getString("location"));
				habMandal.setStatus(rset.getString("STATUS"));
				habMandal.setRepairCost(rset.getString("REPAIR_COST"));
				habMandal.setRepairCode(rset.getString("REPAIR_CODE"));
				habMandal.setRepairdate(rset.getString("REPAIR_DATE"));
				habMandal.setSourceTypeName("SHALLOW HANDPUMP");
				habMandal.setLatitude(rset.getString("COMPO_LAT"));
				habMandal.setLongitude(rset.getString("COMPO_LON"));
				if (a == null)
					habMandal.setImgStatus("No");
				else
					habMandal.setImgStatus("Yes");
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

	public ArrayList getAllAssetComps(String astType) throws Exception {
		ArrayList assets = new ArrayList();
		try {
			HabitationNewEntry_Form habMandal = null;
			conn = RwsOffices.getConn();
			String query = "select asset_component_code, asset_component_name from RWS_ASSET_COMPONENT_TYPE_TBL where type_of_asset_code='"
					+ astType + "' order by asset_component_code";
			ps = conn.prepareStatement(query);
			ResultSet rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setAstCompCode(rset.getString(1));
				habMandal.setAstCompName(rset.getString(2));
				assets.add(habMandal);
			}
			rset.close();
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println("Exception in get all assets is " + e);
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return assets;
	}

	public ArrayList getSpecAssetType() throws Exception {
		ArrayList assets = new ArrayList();
		try {
			HabitationNewEntry_Form habMandal = null;
			conn = RwsOffices.getConn();
			String query = "select * from rws_asset_type_tbl where type_of_asset_code not in ('07','10','11','12') order by type_of_asset_code";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				habMandal = new HabitationNewEntry_Form();
				habMandal.setAssetTypeCode(rset.getString(1));
				habMandal.setAssetType(rset.getString(2));
				assets.add(habMandal);
			}
		} catch (Exception e) {
			System.out.println("Exception is at getSpecAssetType of RWS_HP_Yield_DAO is : " + e);
		} finally {
			closeAll();
		}
		return assets;
	}

	public ArrayList<RwsHPRecord> getSpecRepaires(String asttype) {
		ArrayList<RwsHPRecord> habs = new ArrayList<RwsHPRecord>();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			if (asttype.equals("09")) {
				query = "select REPAIR_CODE,REPAIR_NAME from rws_asset_repair_type_tbl where TYPE_OF_ASSET_CODE='"
						+ asttype + "' and REPAIR_CODE not in ('006','007')";
			} else {
				query = "select REPAIR_CODE,REPAIR_NAME from rws_asset_repair_type_tbl where TYPE_OF_ASSET_CODE='"
						+ asttype + "' and REPAIR_CODE not in ('007','008')";
			}
			// System.out.println("HAB query -hhpanuu 213 ->" + query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				RwsHPRecord habMandal = new RwsHPRecord();
				habMandal.setRepairCode(rset.getString("REPAIR_CODE"));
				habMandal.setRepairName(rset.getString("REPAIR_NAME"));
				habs.add(habMandal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return habs;
	}

}
