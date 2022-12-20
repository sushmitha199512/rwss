/*
 * Created on 22-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;

public class RwsHabLinkDAO {

	/**
	 * @param bean
	 * @param request
	 * @return
	 */
	private LabelValueBean labelValueBean = null;
	public ArrayList getSubdivisions(String headOfficeCode, String circleOfficeCode, String divisionOfficeCode) throws Exception {
		ArrayList subdivisions = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		String message = "";
		String query = "";
		message = "Work ID Does Not Exists";
		//boolean flag = false;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT SUBDIVISION_OFFICE_CODE, SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE = ? AND CIRCLE_OFFICE_CODE = ? AND DIVISION_OFFICE_CODE = ? ORDER BY SUBDIVISION_OFFICE_NAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, headOfficeCode);
			ps.setString(2, circleOfficeCode);
			ps.setString(3, divisionOfficeCode);
			rset = ps.executeQuery();
			labelValueBean = new LabelValueBean();
			labelValueBean.setValue("00");
			labelValueBean.setLabel("Select");
			labelValueBean.setLabelValue("Select"+ " - " + "00");
			subdivisions.add(labelValueBean);
			
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				subdivisions.add(labelValueBean);
			}
		}catch (Exception e) {
        	System.out.println("The Exception is in RwsOffices getSubdivisions : "+e.getMessage());
        } finally {
        	try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());
			}
			
		}
		return subdivisions;
	}
	public int updateSubDivision( String officecode, String workid)	throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			
			conn = RwsOffices.getConn();			
			query = "update RWS_WORK_ADMN_TBL set OFFICE_CODE=? where work_id=? ";	
			ps = conn.prepareStatement(query);
			
			ps.setString(1, officecode);
			ps.setString(2, workid);
		
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("The Exception at insertPanchayat In RwsHabStatusData=" + e);
		} finally {
			
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());

			}
			
		}
		return rcount;
	}
	
	
	public String getOfficeCode(RwsHabsEntryActionBean bean,
			HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String office_code = "";
		try {
			conn = RwsOffices.getConn();		
			String subDivisionQuery = "select office_code from RWS_WORK_ADMN_TBL WHERE work_id=?";
			ps = conn.prepareStatement(subDivisionQuery);
			ps.setString(1, bean.getWorkId());
			rs = ps.executeQuery();
			if (rs.next()) {
				office_code=rs.getString(1);
				
				/*if(office_code.substring(4).equalsIgnoreCase("00"))
				{
					bean.setIshavesubdivcode(true);
				}
				else
				{
					bean.setIshavesubdivcode(false);
				}*/				
			}
			ps.close();
			rs.close();
		
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getWorkDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());

			}
		}
		
		return office_code;

	}
	public String getWorkDetails(RwsHabsEntryActionBean bean,
			HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String message = "";
		String query = "";
		message = "Work ID Does Not Exists";

		boolean flag = false;

		try {
			conn = RwsOffices.getConn();

			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and work_id=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
				bean.setWorkName(rs.getString(1));
				bean.setSanctionedAmount(rs.getString(2));
				bean.setSanctionedDate(rs.getString(3));
				bean.setProgramName(rs.getString(4));
				bean.setSubProgName(rs.getString(5));
				bean.setIsAdmnSanction("true");

			}
			ps.close();
			rs.close();

			String tsQuery = "select TS_NO,to_char(TS_DATE,'dd/mm/yyyy'),TS_AMOUNT from rws_new_est_tbl where work_id=?";

			ps = conn.prepareStatement(tsQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {

				bean.setTsNo(rs.getString(1));
				bean.setTsDate(rs.getString(2));
				bean.setTsAmount(rs.getString(3));
				bean.setIsTechSancationed("true");
			}
			ps.close();
			rs.close();

			String habCount = "select count(*) from rws_admn_hab_lnk_tbl where work_id=?";
			ps = conn.prepareStatement(habCount);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setSanctionedHabs(rs.getString(1));
			}
			ps.close();
			rs.close();

			String thabCount = "select (select count(*) from rws_est_new_hab_lnk_tbl where work_id=?) a1,(select count(*) from rws_work_comp_hab_lnk_tbl where work_id=?) a2 from dual";
			ps = conn.prepareStatement(thabCount);
			ps.setString(1, bean.getWorkId());
			ps.setString(2, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setTechHabs(rs.getString(1));
				bean.setCoveredHabs(rs.getString(2));
			}
			ps.close();
			rs.close();

			String completionQuery = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
			ps = conn.prepareStatement(completionQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();
			if (rs.next()) {

				bean.setPhisicalDate(rs.getString(1));
				bean.setFinancialDate(rs.getString(2));
				bean.setPartialDate(rs.getString(3));
				bean.setIsCompletion("true");
			}
			ps.close();
			rs.close();
			
			String subDivisionQuery = " select substr(office_code,1,4),substr(office_code,2,2),substr(office_code,4,1),co.circle_office_name,do.division_office_name from RWS_WORK_ADMN_TBL r,RWS_CIRCLE_OFFICE_TBL co,RWS_DIVISION_OFFICE_TBL do where  co.circle_office_code=substr(office_code,2,2) and do.circle_office_code=substr(office_code,2,2) and do.division_office_code=substr(office_code,4,1) and  work_id=?";
			ps = conn.prepareStatement(subDivisionQuery);
			ps.setString(1, bean.getWorkId());
			rs = ps.executeQuery();
			if (rs.next()) {
				bean.setCname(rs.getString(4));
				bean.setDivname(rs.getString(5));
			}
			ps.close();
			rs.close();
			
			

		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getWorkDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getWorkDetails : "
								+ e.getMessage());

			}
		}
		if (!flag) {
			return message;
		}
		return "";

	}

	public ArrayList getHabs(String workId, String table) {

		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			String query = " SELECT PR.panch_code, PR.panch_name, "
					+ " m.mname ,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status FROM rws_panchayat_raj_tbl PR, "
					+ " rws_habitation_directory_tbl HD, "
					+ table
					+ "  HL,rws_mandal_tbl m "
					+ " WHERE PR.panch_code = HL.hab_code "
					+ " AND PR.panch_code = HD.hab_code AND m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2)"
					+ " AND HL.work_id =?";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabName(rset.getString(2));
				rwsLocationBean.setMandalName(rset.getString(3));
				rwsLocationBean.setPopulation(rset.getString(4));
				rwsLocationBean.setStatus(rset.getString(5));

				habitations.add(rwsLocationBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getHabs : "
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;

	}

	/**
	 * @param circleOfficeCode
	 * @return
	 */
	public ArrayList getMandals(String circleOfficeCode) {

		ArrayList mandals = new ArrayList();
		String query = null;
		PreparedStatement ps = null;
		Connection conn=null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE"
					+ " DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				RwsLocationBean rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setMandalCode(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3) + " - "
						+ rs.getString(2));
				mandals.add(rwsLocation);
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getMandals : "
					+ e.getMessage());
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in RwsHabLinkDAO getMandals : "
						+ e.getMessage());
			}

		}
		return mandals;

	}

	/**
	 * @param workId
	 * @param habsList
	 * @param mcodes
	 * @return
	 */
	public ArrayList getHabsInMandals(String workId, ArrayList selHabCodes,
			String[] mcodes) throws Exception {

		ArrayList habs = new ArrayList();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		Connection conn = null;
		String sqlQuery = "";
		try {
			conn = RwsOffices.getConn();

			for (int j = 0; j < mcodes.length; j++) {
				if (mcodes[j] != null) {
					sqlQuery = "";
					if (workId.substring(6, 8).equals("11")) {
						sqlQuery = "select distinct h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status,m.mname,CONSTITUENCY_NAME ,sc.school_code,sc.school_name,sc.school_location from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,RWS_CONSTITUENCY_TBL c,RWS_SCHOOL_MASTER_TBL sc where sc.hab_code=hd.hab_code and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? and c.dcode=d.dcode and c.mcode=m.mcode order by m.mname,h.panch_name asc";
					} else {
						sqlQuery = "select distinct h.panch_code,h.panch_name,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU)tot,hd.coverage_status,m.mname,CONSTITUENCY_NAME from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd,RWS_CONSTITUENCY_TBL c where  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=? and m.mcode=? and c.dcode=d.dcode and c.mcode=m.mcode order by m.mname,h.panch_name asc";
					}

					prpStmt = conn.prepareStatement(sqlQuery);
					prpStmt.setString(1, workId.substring(4, 6));
					prpStmt.setString(2, mcodes[j]);
					
					rs = prpStmt.executeQuery();

					nic.watersoft.commons.RwsLocationBean rwsLocation = null;
					while (rs.next()) {
						rwsLocation = new nic.watersoft.commons.RwsLocationBean();

						if (selHabCodes != null) {
							for (int i = 0; i < selHabCodes.size(); i++) {
								try {

									if (((String) selHabCodes.get(i)) != null
											&& ((String) selHabCodes.get(i))
													.equals(rs.getString(1))) {
										rwsLocation.setHabMatch("checked");

									}

								} catch (Exception e) {
								}
							}
						}
						rwsLocation.setHabCode(rs.getString(1));
						rwsLocation.setHabName(rs.getString(2));
						rwsLocation.setPopulation(rs.getString(3));
						rwsLocation.setStatus(rs.getString(4));
						rwsLocation.setConstituencyName(rs.getString(6));
						rwsLocation.setMandalName(rs.getString(5));
						if (workId.substring(6, 8).equals("11")) {
							rwsLocation.setSchoolCode(rs.getString(1)
									+ rs.getString(7));
							rwsLocation.setSchoolName(rs.getString(8));
							rwsLocation.setSchoolLocation(rs.getString(9));
						}
						habs.add(rwsLocation);
					}
				}
			}
			if (rs != null)
				rs.close();

		} catch (SQLException e) {
			System.out.println("Exception in RwsHabLinkDAO getHabsInMandals : "
					+ e.getMessage());
			return null;
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getHabsInMandals : "
					+ e.getMessage());
			return null;
		} finally {
			if (prpStmt != null)
				prpStmt.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		return habs;

	}

	/**
	 * @param workId
	 * @param string
	 * @return
	 */
	public ArrayList getSanctionedHabs(String workId, String table) {
		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			String query = "";
			if (workId.substring(6, 8).equals("11")) { 
				query = " SELECT PR.panch_code, PR.panch_name, "
						+ " m.mname ,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status,sm.school_code,sm.school_name FROM rws_panchayat_raj_tbl PR, "
						+ " rws_habitation_directory_tbl HD, "
						+ table
						+ "  HL,rws_school_master_tbl sm, rws_mandal_tbl m "
						+ " WHERE sm.hab_code=HD.hab_code and PR.panch_code = HL.hab_code "
						+ " AND PR.panch_code = HD.hab_code AND m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2)"
						+ " AND HL.work_id =?";

			} else { 
				query = " SELECT PR.panch_code, PR.panch_name, "
						+ " m.mname ,nvl(HD.census_plain_popu,0)+ nvl(HD.census_sc_popu,0)+nvl(HD.census_st_popu,0),hd.coverage_status FROM rws_panchayat_raj_tbl PR, "
						+ " rws_habitation_directory_tbl HD, "
						+ table
						+ "  HL,rws_mandal_tbl m "
						+ " WHERE PR.panch_code = HL.hab_code "
						+ " AND PR.panch_code = HD.hab_code AND m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2)"
						+ " AND HL.work_id =?";

			}
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			
			while (rset.next()) {
				habitations.add(rset.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getSanctionedHabs : "
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;
	}

	/**
	 * @param bean
	 * @param request
	 * @return
	 */
	public String getSchoolDetails(RwsHabsEntryActionBean bean,
			HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String message = "";
		String query = "";

		message = "Work ID Does Not Exists";

		boolean flag = false;

		try {
			conn = RwsOffices.getConn();

			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and work_id=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
				bean.setWorkName(rs.getString(1));
				bean.setSanctionedAmount(rs.getString(2));
				bean.setSanctionedDate(rs.getString(3));
				bean.setProgramName(rs.getString(4));
				bean.setSubProgName(rs.getString(5));
				bean.setIsAdmnSanction("true");

			}
			ps.close();
			rs.close();

			String tsQuery = "select TS_NO,to_char(TS_DATE,'dd/mm/yyyy'),TS_AMOUNT from rws_new_est_tbl where work_id=?";

			ps = conn.prepareStatement(tsQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();
			while (rs.next()) {

				bean.setTsNo(rs.getString(1));
				bean.setTsDate(rs.getString(2));
				bean.setTsAmount(rs.getString(3));
				bean.setIsTechSancationed("true");
			}
			ps.close();
			rs.close();

			String habCount = "select count(*) from rws_work_school_lnk_tbl where work_id=?";

			ps = conn.prepareStatement(habCount);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setSanctionedHabs(rs.getString(1));
			}
			ps.close();
			rs.close();

			String thabCount = "select (select count(*) from rws_est_new_hab_lnk_tbl where work_id=?) a1,(select count(*) from rws_work_comp_hab_lnk_tbl where work_id=?) a2 from dual";

			ps = conn.prepareStatement(thabCount);
			ps.setString(1, bean.getWorkId());
			ps.setString(2, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setTechHabs(rs.getString(1));
				bean.setCoveredHabs(rs.getString(2));
			}
			ps.close();
			rs.close();

			String completionQuery = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
			ps = conn.prepareStatement(completionQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();
			if (rs.next()) {

				bean.setPhisicalDate(rs.getString(1));
				bean.setFinancialDate(rs.getString(2));
				bean.setPartialDate(rs.getString(3));
				bean.setIsCompletion("true");
			}
			ps.close();
			rs.close();

		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getSchoolDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getSchoolDetails : "
								+ e.getMessage());

			}
		}
		if (!flag) {
			return message;
		}
		return "";

	}

	/**
	 * @param bean
	 * @param request
	 * @return
	 */
	public String getLabDetails(RwsHabsEntryActionBean bean,
			HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String message = "";
		String query = "";
		message = "Work ID Does Not Exists";

		boolean flag = false;

		try {
			conn = RwsOffices.getConn();
			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and work_id=?";

			ps = conn.prepareStatement(query);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {
				flag = true;
				bean.setWorkName(rs.getString(1));
				bean.setSanctionedAmount(rs.getString(2));
				bean.setSanctionedDate(rs.getString(3));
				bean.setProgramName(rs.getString(4));
				bean.setSubProgName(rs.getString(5));
				bean.setIsAdmnSanction("true");

			}
			ps.close();
			rs.close();

			String tsQuery = "select TS_NO,to_char(TS_DATE,'dd/mm/yyyy'),TS_AMOUNT from rws_new_est_tbl where work_id=?";

			ps = conn.prepareStatement(tsQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			while (rs.next()) {

				bean.setTsNo(rs.getString(1));
				bean.setTsDate(rs.getString(2));
				bean.setTsAmount(rs.getString(3));
				bean.setIsTechSancationed("true");
			}
			ps.close();
			rs.close();

			String habCount = "select count(*) from RWS_WORK_LAB_LNK_TBL where work_id=?";

			ps = conn.prepareStatement(habCount);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setSanctionedHabs(rs.getString(1));
			}
			ps.close();
			rs.close();

			String thabCount = "select (select count(*) from rws_est_new_hab_lnk_tbl where work_id=?) a1,(select count(*) from rws_work_comp_hab_lnk_tbl where work_id=?) a2 from dual";

			ps = conn.prepareStatement(thabCount);
			ps.setString(1, bean.getWorkId());
			ps.setString(2, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setTechHabs(rs.getString(1));
				bean.setCoveredHabs(rs.getString(2));
			}
			ps.close();
			rs.close();

			String completionQuery = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'-'),nvl(to_char(PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
			ps = conn.prepareStatement(completionQuery);
			ps.setString(1, bean.getWorkId());

			rs = ps.executeQuery();

			if (rs.next()) {

				bean.setPhisicalDate(rs.getString(1));
				bean.setFinancialDate(rs.getString(2));
				bean.setPartialDate(rs.getString(3));
				bean.setIsCompletion("true");
			}
			ps.close();
			rs.close();

		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getLabDetails : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out
						.println("Exception in RwsHabLinkDAO getLabDetails : "
								+ e.getMessage());

			}
		}
		if (!flag) {
			return message;
		}
		return "";

	}

	/**
	 * @param workId
	 * @param string
	 * @return
	 */
	public ArrayList getSchools(String workId, String table) {

		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			String query = " select s.hab_code,s.SCHOOL_CODE,SCHOOL_NAME,SCHOOL_LOCATION ,SCHOOL_CLASSIFICATION ,NO_OF_STUDENTS,FACILITIES_AVAILABLE,panch_name  from "
					+ " rws_school_master_tbl s, rws_work_school_lnk_tbl HL,rws_panchayat_raj_tbl b "
					+ " WHERE s.school_code = HL.school_code "
					+ " and s.hab_code=hl.hab_code and s.hab_code=b.panch_code   "
					+ " and work_id=?";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setHabMatch(rset.getString(1));
				rwsLocationBean.setHabitationCode(rset.getString(1)
						+ rset.getString(2));
				rwsLocationBean.setSchoolCode(rset.getString(2));
				rwsLocationBean.setSchoolName(rset.getString(3));
				rwsLocationBean.setSchoolLocation(rset.getString(4));
				rwsLocationBean.setSchoolClasification(rset.getString(5));
				rwsLocationBean.setNoofStudents(rset.getString(6));
				rwsLocationBean.setFacilities(rset.getString(7));
				rwsLocationBean.setPanchayatName(rset.getString(8));

				habitations.add(rwsLocationBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getSchools : "
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;

	}

	/**
	 * @param workId
	 * @param table
	 * @return
	 */
	public ArrayList getSanctionedSchools(String workId, String table) {

		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			String query = "";

			query = " SELECT PR.panch_code,sm.school_code,sm.school_name FROM rws_panchayat_raj_tbl PR, "
					+ " rws_habitation_directory_tbl HD, "
					+ table
					+ "  HL,rws_school_master_tbl sm, rws_mandal_tbl m "
					+ " WHERE sm.hab_code=HD.hab_code and PR.panch_code = HL.hab_code "
					+ " AND PR.panch_code = HD.hab_code AND m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2)"
					+ " AND HL.work_id =? and HL.school_code=sm.school_code";

			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setHabCode(rset.getString(1));
				rwsLocationBean.setSchoolCode(rset.getString(1)
						+ rset.getString(2));
				rwsLocationBean.setSchoolName(rset.getString(3));
				habitations.add(rwsLocationBean);

			}

		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getSanctionedSchools : "
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;

	}

	/**
	 * @param workId
	 * @param string
	 * @return
	 */
	public ArrayList getLabs(String workId, String table) {

		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			String query = " SELECT sm.lab_code,sm.lab_name,sm.location FROM "
					+ table + "  HL, rws_water_quality_lab_tbl sm "
					+ " WHERE  HL.work_id =? and HL.lab_code=sm.lab_code";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setLabCode(rset.getString(1));
				rwsLocationBean.setLabName(rset.getString(2));
				rwsLocationBean.setLocation(rset.getString(3));

				habitations.add(rwsLocationBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getLabs : "
					+ e.getMessage());
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException sqle) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (SQLException sqle) {
				}
			}
		}

		return habitations;

	}

	public ArrayList getWorkDists(String workid, String table) throws Exception {

		String query = null;
		ArrayList works = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();

			query = "select distinct substr(hab_code,1,2) from " + table
					+ " where work_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs = ps.executeQuery();
			int count = 0;
			while (rs.next()) {
				works.add(count, "" + rs.getString(1));
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO getWorkDists : "
					+ e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in RwsHabLinkDAO getWorkDists : "
						+ e.getMessage());

			}
		}
		return works;

	}

	public String saveHabs(String workId, String[] habs, String type)
			throws Exception {

		Connection conn = null;
		Statement stmt = null;
		String message = "", table = "";
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			if (type != null && type.equals("admin")) {
				table = "rws_admn_hab_lnk_tbl";
			} else if (type != null && type.equals("tech")) {
				table = "RWS_EST_NEW_HAB_LNK_TBL";
			} else if (type != null && type.equals("comp")) {
				table = "RWS_WORK_COMP_HAB_LNK_TBL";
			}
			if (habs != null) {
				stmt.addBatch("delete from " + table + " where work_id='"
						+ workId + "'");
				for (int i = 0; i < habs.length; i++) {
					String q1 = "insert into " + table
							+ " (WORK_ID,HAB_CODE) values('" + workId + "','"
							+ habs[i] + "')";
					count++;
					stmt.addBatch(q1);
				}

				if (type != null && type.equals("admin")) {
					String updateQ = "update rws_work_admn_tbl set no_of_habs='"
							+ count + "' where work_id='" + workId + "'";
					stmt.addBatch(updateQ);
				}
			}

			boolean flag = true;
			int res[] = stmt.executeBatch();
			int i = 0;
			while (i < res.length) {
				if (res[i] < 0) {
					flag = false;
				}
				i++;
			}
			if (!flag) {
				conn.rollback();
				conn.setAutoCommit(true);
				message = "Failed to Add Habitations";
			} else {
				conn.setAutoCommit(true);
				conn.commit();
				message = "Habitations Added Sucessfully";
			}
		} catch (Exception e) {
			System.out.println("Exception in RwsHabLinkDAO saveHabs : "
					+ e.getMessage());
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
		return message;

	}

}