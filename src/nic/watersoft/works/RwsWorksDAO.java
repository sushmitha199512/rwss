/*
 * Created on 5-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

public class RwsWorksDAO {

	public ArrayList getWorks(String circleCode, int divCode, String cat,
			String sanctionYear, String programCode) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs2 = null;
		ArrayList worksList = new ArrayList();

		try {
			String query = "";
			conn = RwsOffices.getConn();


			query = "select a.work_id,a.work_name from rws_work_admn_tbl a "
					+ " where substr(a.office_code,2,2)=? and substr(a.office_code,4,1)=? and a.CATEGORY_CODE=? "
					+ " and a.WORK_CANCEL_DT is null and to_char(admin_date,'yyyy')=? and programme_code=? "
					+ " and a.work_id not in(select work_id from rws_work_commencement_tbl)";
			
			ps = conn.prepareStatement(query);
			
			ps.setString(1, circleCode);
			ps.setString(2, divCode+"");
			ps.setString(3, cat);
			ps.setString(4, sanctionYear);
			ps.setString(5, programCode);
			rs2 = ps.executeQuery();
			while (rs2.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs2.getString(1));
				labelValueBean.setLabel(rs2.getString(1) + "--"
						+ rs2.getString(2));
				worksList.add(labelValueBean);

			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO getWorks:"+e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return worksList;
	}

	/**
	 * @param workForm
	 */
	public void getWorkDetails(Rws_NotGrounded_Works_form workForm) {
		Connection conn = null;
		PreparedStatement ps = null, ps1 = null, ps2 = null;
		ResultSet rs2 = null, rs3 = null, rs4 = null;
		try {
			String query = "";
			conn = RwsOffices.getConn();
			

			query = "select a.work_id,a.work_name,c.programme_name,d.subprogramme_name,to_char(a.ADMIN_DATE,'dd/MM/yyyy'),a.SANCTION_AMOUNT,a.office_code,a.CATEGORY_CODE   from rws_work_admn_tbl a ,rws_programme_tbl c,rws_subprogramme_tbl d"
					+ " where a.work_id=? and a.PROGRAMME_CODE=c.PROGRAMME_CODE and a.PROGRAMME_CODE=d.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=d.SUBPROGRAMME_CODE ";
			ps=conn.prepareStatement(query);
			ps.setString(1,  workForm.getWorkIdList());
			rs2 = ps.executeQuery();
			while (rs2.next()) {

				String officeCode = rs2.getString(7);

				workForm.setCmbDivision(Integer.parseInt(officeCode.substring(
						3, 4)));
				workForm.setCategory(rs2.getString(8));

				String q = "select landAquisition,waterDrawlPermission,railwayCrossingPermission,ROADCROSSINGPERMISSIONSTATE,ROADCROSSINGPERMISSIONNHAI,forestClearance,others,othersReason,dprStatus,to_char(dprCompDate,'dd/MM/yyyy'),LANDAQUISITIONNUMBER,to_char(LANDAQUISITIONOBTAINDATE,'dd/MM/yyyy'),WATERDRAWLPERMISSIONNUMBER ,to_char(WATERDRAWLPERMISSIONOBTAINDATE,'dd/MM/yyyy'),RAILWAYCROSSINGPERNUMBER,to_char(RAILWAYCROSSINGPEROBTAIN,'dd/MM/yyyy'),ROADCROSSINGPERMNUMBER,to_char(ROADCROSSINGPEROBTAINDATE,'dd/MM/yyyy') ,ROADCROSSINGPERMNHAINUM,to_char(ROADCROSSINGNHAIOBTAINDATE,'dd/MM/yyyy'),FORESTCLEARANCENUMBER ,to_char(FORESTCLEARANCEOBTAINDATE,'dd/MM/yyyy'),OTHERSNUMBER,to_char(OTHERSOBTAINDATE,'dd/MM/yyyy'),LANDAQUISITIONREQNUMBER,to_char(LANDAQUISITIONREQDATE,'dd/MM/yyyy'),WATERDRAWLPERMISSIONREQNUMBER,to_char(WATERDRAWLPERMISSIONREQDATE,'dd/MM/yyyy'),RAILWAYCROSSINGPERREQNUMBER,to_char(RAILWAYCROSSINGPERREQDATE,'dd/MM/yyyy'),ROADCROSSINGSTATEREQNUMBER,to_char(ROADCROSSINGSTATEREQDATE,'dd/MM/yyyy'),ROADCROSSINGNHAIREQNUMBER,to_char(ROADCROSSINGNHAIREQDATE,'dd/MM/yyyy'),FORESTCLEARANCEREQNUMBER ,to_char(FORESTCLEARANCEREQDATE,'dd/MM/yyyy') ,OTHERSREQNUMBER,to_char(OTHERSREQDATE,'dd/MM/yyyy'),SOURCECREATED ,to_char(SOURCECREATEDDATE,'dd/MM/yyyy'),PARTACLEARANCE,to_char(PARTACLEARNCEDATE,'dd/MM/yyyy'),remarks,powerAPTranscoReq ,powerAPTranscoReqNumber, to_char(powerAPTranscoReqDate,'dd/MM/yyyy'),powerAPTranscoObtainNumber, to_char(powerAPTranscoObtainDate,'dd/MM/yyyy'),hMWSSBReq,hMWSSBReqNum,to_char(hMWSSBReqDate,'dd/MM/yyyy'),hMWSSBobtainNumber,to_char(hMWSSBObtainDate,'dd/MM/yyyy'),partAAmount,DPRPREPARATION,AGENCYNAME, DPRCHARGES,HMWSCHRGS,LANDAQUISITIONCHRG,WATERDRAWLPERMISSIONCHRG ,RAILWAYCROSSINGPERMISSIONCHRG ,ROADCROSSINGPERMISSIONCHRG ,ROADCROSSINGPERMISSIONNHAICHRG ,FORESTCLEARANCECHRG ,OTHERSCHRG ,GROUNDWATERINVESTIGATIONCHG,YIELDTESTINGCHG,SOURCECREATIONCHG,POWERAPTRANSCOCHRGS  from rws_notgroundworks_status_tbl  "
						+ " where work_id=?";
				ps1=conn.prepareStatement(q);
				ps1.setString(1,  rs2.getString(1));
				rs3 = ps1.executeQuery();
				while (rs3.next()) {

					workForm
							.setLandAquisition(rs3.getString(1).equals("Y") ? "on"
									: "N");

					workForm.setWaterDrawlPermission(rs3.getString(2).equals(
							"Y") ? "on" : "N");
					workForm.setRailwayCrossingPermission(rs3.getString(3)
							.equals("Y") ? "on" : "N");
					workForm.setRoadCrossingPermission(rs3.getString(4).equals(
							"Y") ? "on" : "N");
					workForm.setRoadCrossingPermissionNHAI(rs3.getString(5)
							.equals("Y") ? "on" : "N");
					workForm
							.setForestClearance(rs3.getString(6).equals("Y") ? "on"
									: "N");
					workForm.setOthers(rs3.getString(7).equals("Y") ? "on"
							: "N");
					workForm
							.setPowerAPTranscoReq(rs3.getString(44).equals("Y") ? "on"
									: "N");
					workForm.setHmwsReq(rs3.getString(49).equals("Y") ? "on"
							: "N");

					workForm.setOthersReason(rs3.getString(8));
					workForm.setDprStatus(rs3.getString(9));
					workForm.setDprCompDate(rs3.getString(10));
					workForm.setLandAquisitionNumber(rs3.getString(11));
					workForm.setLandAquisitionObtainDate(rs3.getString(12));
					workForm.setWaterDrawlPermissionNumber(rs3.getString(13));
					workForm.setWaterDrawlPermissionObtainDate(rs3
							.getString(14));
					workForm.setRailwayCrossingPermissionNumber(rs3
							.getString(15));
					workForm.setRailwayCrossingPermissionObtainDate(rs3
							.getString(16));
					workForm.setRoadCrossingPermissionNumber(rs3.getString(17));
					workForm.setRoadCrossingPermissionObtainDate(rs3
							.getString(18));
					workForm.setRoadCrossingObtainNHAINumber(rs3.getString(19));
					workForm.setRoadCrossingNHAIObtainDate(rs3.getString(20));

					workForm.setForestClearanceNumber(rs3.getString(21));
					workForm.setForestClearanceObtainDate(rs3.getString(22));
					workForm.setOthersNumber(rs3.getString(23));
					workForm.setOthersObtainDate(rs3.getString(24));

					workForm.setLandAquisitionReqNumber(rs3.getString(25));
					workForm.setLandAquisitionReqDate(rs3.getString(26));
					workForm
							.setWaterDrawlPermissionReqNumber(rs3.getString(27));
					workForm.setWaterDrawlPermissionReqDate(rs3.getString(28));
					workForm.setRailwayCrossingPermissionReqNumber(rs3
							.getString(29));
					workForm.setRailwayCrossingPermissionReqDate(rs3
							.getString(30));
					workForm.setRoadCrossingPermissionReqNumber(rs3
							.getString(31));
					workForm
							.setRoadCrossingPermissionReqDate(rs3.getString(32));
					workForm.setRoadCrossingPermissionReqNumberNHAI(rs3
							.getString(33));
					workForm.setRoadCrossingPermissionReqDateNHAI(rs3
							.getString(34));
					workForm.setForestClearanceReqNumber(rs3.getString(35));
					workForm.setForestClearanceReqDate(rs3.getString(36));
					workForm.setOthersReqNumber(rs3.getString(37));
					workForm.setOthersReqDate(rs3.getString(38));

					workForm.setSourceCreated(rs3.getString(39));
					workForm.setSourceCreatedDate(rs3.getString(40));

					workForm
							.setPartAClearnce(rs3.getString(41).equals("Y") ? "on"
									: "N");

					workForm.setPartAClearnceDate(rs3.getString(42));
					workForm.setRemarks(rs3.getString(43));

					workForm.setPowerAPTranscoReqNumber(rs3.getString(45));
					workForm.setPowerAPTranscoReqDate(rs3.getString(46));
					workForm.setPowerAPTranscoObtainNumber(rs3.getString(47));
					workForm.setPowerAPTranscoObtainDate(rs3.getString(48));

					workForm.setHmwsReqNum(rs3.getString(50));
					workForm.setHmwsReqDate(rs3.getString(51));
					workForm.setHmwsReqobtainNum(rs3.getString(52));
					workForm.setHmwsReqobtainDate(rs3.getString(53));

					workForm.setPartAAmount(rs3.getString(54));
					workForm.setDprPrepartion(rs3.getString(55));

					workForm.setAgencyName(rs3.getString(56));
					workForm.setDprCharges(rs3.getString(57));
					workForm.setHmwsChrgs(rs3.getString(58));

					workForm.setLandAquisitionChrg(rs3.getString(59));
					workForm.setWaterDrawlPermissionChrg(rs3.getString(60));
					workForm
							.setRailwayCrossingPermissionChrg(rs3.getString(61));
					workForm.setRoadCrossingPermissionChrg(rs3.getString(62));
					workForm.setRoadCrossingPermissionNHAIChrg(rs3
							.getString(63));

					workForm.setForestClearanceChrg(rs3.getString(64));
					workForm.setOthersChrg(rs3.getString(65));

					workForm.setGroundWaterInvestigationChg(rs3.getString(66));
					workForm.setYieldTestingChg(rs3.getString(67));
					workForm.setSourceCreationChg(rs3.getString(68));
					workForm.setPowerAPTranscoChrgs(rs3.getString(69));

					workForm.setUpdate(true);

				}

				workForm.setWorkid(rs2.getString(1));
				workForm.setWorkName(rs2.getString(2));
				workForm.setProgram(rs2.getString(3));
				workForm.setSubProgName(rs2.getString(4));
				workForm.setSanctionedDate(rs2.getString(5));
				workForm.setSanctionedAmount(rs2.getString(6));

			}

			String mileStoneQuery = "select nvl((sum(PERCENT_COMPLETED_WORK_VAL)/100000),0) from rws_milestone_target_ach_tbl where work_id=?";
			ps2=conn.prepareStatement(mileStoneQuery);
			ps2.setString(1, workForm.getWorkIdList());
			rs4 = ps2.executeQuery();
			if (rs4.next()) {
				workForm.setMileStoneAmount(rs4.getString(1));
			} else {
				workForm.setMileStoneAmount("0");
			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO getWorkDetails:"+e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (ps2 != null) {
					ps2.close();
				}
				if (rs4 != null) {
					rs4.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * @param workForm
	 */
	public int save(Rws_NotGrounded_Works_form workForm, String userId) {

		Connection conn = null;
		PreparedStatement ps = null;

		String landAquisition = workForm.getLandAquisition().equals("on") ? "Y"
				: "N";
		String waterDrawlPermission = workForm.getWaterDrawlPermission()
				.equals("on") ? "Y" : "N";

		String railwayCrossingPermission = workForm
				.getRailwayCrossingPermission().equals("on") ? "Y" : "N";

		String roadCrossingPermissionState = workForm
				.getRoadCrossingPermission().equals("on") ? "Y" : "N";

		String roadCrossingPermissionNHAI = workForm
				.getRoadCrossingPermissionNHAI().equals("on") ? "Y" : "N";

		String forestClearance = workForm.getForestClearance().equals("on") ? "Y"
				: "N";

		String others = workForm.getOthers().equals("on") ? "Y" : "N";

		String partAClearnce = workForm.getPartAClearnce().equals("on") ? "Y"
				: "N";

		String powerAPTranscoReq = workForm.getPowerAPTranscoReq().equals("on") ? "Y"
				: "N";
		String hMWSSBReq = workForm.getHmwsReq().equals("on") ? "Y" : "N";

		if (!partAClearnce.equals("Y")) {
			workForm.setPartAClearnceDate("");
		}

		int count = 0;
		try {

			conn = RwsOffices.getConn();
			
			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");

			if (checkIsExists(workForm)) {
				count = update(workForm, userId);
			} else {
				String query = "insert into rws_notgroundworks_status_tbl"
						+ " (work_id,enteredby,updatedate,landAquisition,waterDrawlPermission,railwayCrossingPermission,ROADCROSSINGPERMISSIONSTATE,ROADCROSSINGPERMISSIONNHAI,forestClearance,others,othersReason,dprStatus,dprCompDate,LANDAQUISITIONNUMBER,LANDAQUISITIONOBTAINDATE,WATERDRAWLPERMISSIONNUMBER ,WATERDRAWLPERMISSIONOBTAINDATE,RAILWAYCROSSINGPERNUMBER,RAILWAYCROSSINGPEROBTAIN,ROADCROSSINGPERMNUMBER,ROADCROSSINGPEROBTAINDATE ,ROADCROSSINGPERMNHAINUM,ROADCROSSINGNHAIOBTAINDATE,FORESTCLEARANCENUMBER ,FORESTCLEARANCEOBTAINDATE,OTHERSNUMBER,OTHERSOBTAINDATE,LANDAQUISITIONREQNUMBER,LANDAQUISITIONREQDATE,WATERDRAWLPERMISSIONREQNUMBER,WATERDRAWLPERMISSIONREQDATE,RAILWAYCROSSINGPERREQNUMBER,RAILWAYCROSSINGPERREQDATE,ROADCROSSINGSTATEREQNUMBER,ROADCROSSINGSTATEREQDATE,ROADCROSSINGNHAIREQNUMBER,ROADCROSSINGNHAIREQDATE,FORESTCLEARANCEREQNUMBER ,FORESTCLEARANCEREQDATE ,OTHERSREQNUMBER,OTHERSREQDATE,SOURCECREATED ,SOURCECREATEDDATE,PARTACLEARANCE,PARTACLEARNCEDATE,remarks,powerAPTranscoReq ,powerAPTranscoReqNumber, powerAPTranscoReqDate,powerAPTranscoObtainNumber, powerAPTranscoObtainDate,hMWSSBReq,hMWSSBReqNum,hMWSSBReqDate,hMWSSBobtainNumber,hMWSSBObtainDate,partAAmount,DPRPREPARATION,AGENCYNAME,DPRCHARGES,HMWSCHRGS,LANDAQUISITIONCHRG,WATERDRAWLPERMISSIONCHRG ,RAILWAYCROSSINGPERMISSIONCHRG ,ROADCROSSINGPERMISSIONCHRG ,ROADCROSSINGPERMISSIONNHAICHRG ,FORESTCLEARANCECHRG ,OTHERSCHRG,GROUNDWATERINVESTIGATIONCHG,YIELDTESTINGCHG,SOURCECREATIONCHG ,POWERAPTRANSCOCHRGS  )"
						+ " values (?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,?,to_date(?,'dd/mm/yyyy'),?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						
						ps = conn.prepareStatement(query);	
						ps.setString(1, workForm.getWorkIdList());
						ps.setString(2, userId);
						ps.setString(3, currentDate);
						ps.setString(4, landAquisition);
						ps.setString(5, waterDrawlPermission);
						ps.setString(6, railwayCrossingPermission);
						ps.setString(7, roadCrossingPermissionState);
						ps.setString(8, roadCrossingPermissionNHAI);
						ps.setString(9, forestClearance);
						ps.setString(10, others);
						ps.setString(11, workForm.getOthersReason());
						ps.setString(12, workForm.getDprStatus());
						ps.setString(13, workForm.getDprCompDate());
						ps.setString(14, workForm.getLandAquisitionNumber());
						ps.setString(15, workForm.getLandAquisitionObtainDate());
						ps.setString(16, workForm.getWaterDrawlPermissionNumber());
						ps.setString(17, workForm.getWaterDrawlPermissionObtainDate());
						ps.setString(18, workForm.getRailwayCrossingPermissionNumber());
						ps.setString(19, workForm.getRailwayCrossingPermissionObtainDate());
						ps.setString(20, workForm.getRoadCrossingPermissionNumber());
						ps.setString(21, workForm.getRoadCrossingPermissionObtainDate());
						ps.setString(22, workForm.getRoadCrossingObtainNHAINumber());
						ps.setString(23, workForm.getRoadCrossingNHAIObtainDate());
						ps.setString(24, workForm.getForestClearanceNumber());
						ps.setString(25, workForm.getForestClearanceObtainDate());
						ps.setString(26, workForm.getOthersNumber());
						ps.setString(27, workForm.getOthersObtainDate());
						ps.setString(28, workForm.getLandAquisitionReqNumber());
						ps.setString(29, workForm.getLandAquisitionReqDate());
						ps.setString(30, workForm.getWaterDrawlPermissionReqNumber());
						ps.setString(31, workForm.getWaterDrawlPermissionReqDate());
						ps.setString(32, workForm.getRailwayCrossingPermissionReqNumber());
						ps.setString(33, workForm.getRailwayCrossingPermissionReqDate());
						ps.setString(34, workForm.getRoadCrossingPermissionNumber());
						ps.setString(35, workForm.getRoadCrossingPermissionReqDate());
						ps.setString(36, workForm.getRoadCrossingPermissionReqNumberNHAI());
						ps.setString(37, workForm.getRoadCrossingPermissionReqDateNHAI());
						ps.setString(38, workForm.getForestClearanceReqNumber());
						ps.setString(39, workForm.getForestClearanceReqDate());
						ps.setString(40, workForm.getOthersReqNumber());
						ps.setString(41, workForm.getOthersReqDate());						
						ps.setString(42, workForm.getSourceCreated());
						ps.setString(43, workForm.getSourceCreatedDate());
						ps.setString(44, partAClearnce);
						ps.setString(45, workForm.getPartAClearnceDate());
						ps.setString(46, workForm.getRemarks());
						ps.setString(47, powerAPTranscoReq);
						ps.setString(48, workForm.getPowerAPTranscoReqNumber());
						ps.setString(49, workForm.getPowerAPTranscoReqDate());
						ps.setString(50, workForm.getPowerAPTranscoObtainNumber());
						ps.setString(51, workForm.getPowerAPTranscoObtainDate());
						ps.setString(52, hMWSSBReq);
						ps.setString(53, workForm.getHmwsReqNum());
						ps.setString(54, workForm.getHmwsReqDate());
						ps.setString(55, workForm.getHmwsReqobtainNum());
						ps.setString(56, workForm.getHmwsReqobtainDate());						
						ps.setString(57, workForm.getPartAAmount());
						ps.setString(58, workForm.getDprPrepartion());
						ps.setString(59, workForm.getAgencyName());
						ps.setString(60, workForm.getDprCharges());
						ps.setString(61, workForm.getHmwsChrgs());
						ps.setString(62, workForm.getLandAquisitionChrg());
						ps.setString(63, workForm.getWaterDrawlPermissionChrg());
						ps.setString(64, workForm.getRailwayCrossingPermissionChrg());
						ps.setString(65, workForm.getRoadCrossingPermissionChrg());
						ps.setString(66, workForm.getRoadCrossingPermissionNHAIChrg());
						ps.setString(67, workForm.getForestClearanceChrg());
						ps.setString(68, workForm.getOthersChrg());
						ps.setString(69, workForm.getGroundWaterInvestigationChg());
						ps.setString(70, workForm.getYieldTestingChg());
						ps.setString(71, workForm.getSourceCreationChg());
						ps.setString(72, workForm.getPowerAPTranscoChrgs());
				
				count = ps.executeUpdate();
			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO save"+e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;

	}

	/**
	 * @param workForm
	 * @return
	 */
	private boolean checkIsExists(Rws_NotGrounded_Works_form workForm) {
		Connection conn = null;
		Statement stmt = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			ResultSet rrs = stmt
					.executeQuery("select *from rws_notgroundworks_status_tbl  where work_id='"
							+ workForm.getWorkIdList() + "'");
			if (rrs.next()) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	public int update(Rws_NotGrounded_Works_form workForm, String userId) {

		Connection conn = null;
		Statement stmt = null;
		int count = 0;

		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
			String landAquisition = workForm.getLandAquisition().equals("on") ? "Y"
					: "N";
			String waterDrawlPermission = workForm.getWaterDrawlPermission()
					.equals("on") ? "Y" : "N";

			String railwayCrossingPermission = workForm
					.getRailwayCrossingPermission().equals("on") ? "Y" : "N";

			String roadCrossingPermissionState = workForm
					.getRoadCrossingPermission().equals("on") ? "Y" : "N";

			String roadCrossingPermissionNHAI = workForm
					.getRoadCrossingPermissionNHAI().equals("on") ? "Y" : "N";

			String forestClearance = workForm.getForestClearance().equals("on") ? "Y"
					: "N";

			String others = workForm.getOthers().equals("on") ? "Y" : "N";

			String partAClearnce = workForm.getPartAClearnce().equals("on") ? "Y"
					: "N";

			String powerAPTranscoReq = workForm.getPowerAPTranscoReq().equals(
					"on") ? "Y" : "N";
			String hMWSSBReq = workForm.getHmwsReq().equals("on") ? "Y" : "N";

			if (!partAClearnce.equals("Y")) {
				workForm.setPartAClearnceDate("");
			}

			String updateQuery = "update rws_notgroundworks_status_tbl set UPDATEDATE =to_date("
					+ "?,'dd/mm/yyyy'),LANDAQUISITION=?"
					+ ",WATERDRAWLPERMISSION=?"
					+ ",RAILWAYCROSSINGPERMISSION=?"
					+ ",ROADCROSSINGPERMISSIONSTATE  =?"
					+ ",ROADCROSSINGPERMISSIONNHAI=?"
					+ ",FORESTCLEARANCE=?"
					+ ",OTHERS=?"
					+ ",OTHERSREASON=?"
					+ ",DPRSTATUS=?"
					+ ",DPRCOMPDATE =to_date(?,"
					+ "dd/mm/yyyy'),LANDAQUISITIONNUMBER=?"
					+ ",LANDAQUISITIONOBTAINDATE =to_date(?,"
					+ "'dd/mm/yyyy'),WATERDRAWLPERMISSIONNUMBER=?"
					+ ",WATERDRAWLPERMISSIONOBTAINDATE=to_date(?,"
					+ "'dd/mm/yyyy'),RAILWAYCROSSINGPERNUMBER =?"
					+ ",RAILWAYCROSSINGPEROBTAIN=to_date(?,"
					+ "'dd/mm/yyyy'),ROADCROSSINGPERMNUMBER =?"
					+ ",ROADCROSSINGPEROBTAINDATE =to_date(?,"
					+ "'dd/mm/yyyy'),ROADCROSSINGPERMNHAINUM=?"
					+ ",ROADCROSSINGNHAIOBTAINDATE =to_date(?,"
					+ "'dd/mm/yyyy'),FORESTCLEARANCENUMBER=?"
					+ ",FORESTCLEARANCEOBTAINDATE=to_date(?,"
					+ "'dd/mm/yyyy'),OTHERSNUMBER=?"
					+ ",OTHERSOBTAINDATE =to_date(?,"
					+ "'dd/mm/yyyy'),LANDAQUISITIONREQNUMBER=?"
					+ ",LANDAQUISITIONREQDATE =to_date(?,"
					+ "'dd/mm/yyyy'),WATERDRAWLPERMISSIONREQNUMBER =?"
					+ ",WATERDRAWLPERMISSIONREQDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),RAILWAYCROSSINGPERREQNUMBER =?"
					+ ",RAILWAYCROSSINGPERREQDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),ROADCROSSINGSTATEREQNUMBER =?"
					+ ",ROADCROSSINGSTATEREQDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),ROADCROSSINGNHAIREQNUMBER =?"
					+ ",ROADCROSSINGNHAIREQDATE  =to_date(?,"
					+ "dd/mm/yyyy'),FORESTCLEARANCEREQNUMBER =?"
					+ ",FORESTCLEARANCEREQDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),OTHERSREQNUMBER =?"
					+ ",OTHERSREQDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),PARTACLEARANCE=?"
					+ ",PARTACLEARNCEDATE=to_date(?,"
					+ "'dd/mm/yyyy'),SOURCECREATED =?"
					+ ",SOURCECREATEDDATE =to_date(?,"
					+ "'dd/mm/yyyy'),remarks=?"
					+ ",POWERAPTRANSCOREQ =?"
					+ ",POWERAPTRANSCOREQNUMBER=?"
					+ "?,POWERAPTRANSCOREQDATE=to_date(?,"
					+ "'dd/mm/yyyy'),POWERAPTRANSCOOBTAINNUMBER =?"
					+ ",POWERAPTRANSCOOBTAINDATE =to_date(?,"
					+ "'dd/mm/yyyy'),HMWSSBREQ =?"
					+ ",HMWSSBREQNUM =?"
					+ ",HMWSSBREQDATE =to_date(?,"
					+ "'dd/mm/yyyy'),HMWSSBOBTAINNUMBER  =?"
					+ ",HMWSSBOBTAINDATE  =to_date(?,"
					+ "'dd/mm/yyyy'),PARTAAMOUNT=?"
					+ ",DPRPREPARATION=?"
					+ ",AGENCYNAME=?"
					+ ", DPRCHARGES=?"
					+ ", HMWSCHRGS=?"
					+ ",LANDAQUISITIONCHRG=?"
					+ ",WATERDRAWLPERMISSIONCHRG=?"
					+ ", RAILWAYCROSSINGPERMISSIONCHRG=?"
					+ ", ROADCROSSINGPERMISSIONCHRG=?"
					+ ", ROADCROSSINGPERMISSIONNHAICHRG=?"
					+ ", FORESTCLEARANCECHRG=?"
					+ " ,OTHERSCHRG=?"
					+ ", GROUNDWATERINVESTIGATIONCHG=?"
					+ ", YIELDTESTINGCHG=?"
					+ ", SOURCECREATIONCHG=?"
					+ " , POWERAPTRANSCOCHRGS =?"
					+ "  where work_id=?";

			workForm.setUpdate(true);
			PreparedStatement ps = conn.prepareStatement(updateQuery);	
			ps.setString(1, currentDate);
			ps.setString(2, landAquisition);
			ps.setString(3,  waterDrawlPermission);
			ps.setString(4, railwayCrossingPermission);
			ps.setString(5,roadCrossingPermissionState);
			ps.setString(6,roadCrossingPermissionNHAI);
			ps.setString(7, forestClearance);
			ps.setString(8, others);
			ps.setString(9, workForm.getOthersReason());
			ps.setString(10, workForm.getDprStatus()));
			ps.setString(11, workForm.getDprCompDate());
			ps.setString(12, workForm.getLandAquisitionNumber());
			ps.setString(13, workForm.getLandAquisitionObtainDate());
			ps.setString(14, workForm.getWaterDrawlPermissionNumber());
			ps.setString(15,workForm.getWaterDrawlPermissionObtainDate());
			ps.setString(16, workForm.getRailwayCrossingPermissionNumber());
			ps.setString(17, workForm.getRailwayCrossingPermissionObtainDate());
			ps.setString(18, workForm.getRoadCrossingPermissionNumber());
			ps.setString(19,  workForm.getRoadCrossingPermissionObtainDate());
			ps.setString(20, workForm.getRoadCrossingObtainNHAINumber());
			ps.setString(21, workForm.getRoadCrossingNHAIObtainDate());
			ps.setString(22,workForm.getForestClearanceNumber());
			ps.setString(23,workForm.getForestClearanceObtainDate());
			ps.setString(24, workForm.getOthersNumber());
			ps.setString(25, workForm.getOthersObtainDate());
			ps.setString(26,workForm.getLandAquisitionReqNumber());
			ps.setString(27,  workForm.getLandAquisitionReqDate());
			ps.setString(28, workForm.getWaterDrawlPermissionReqNumber());
			ps.setString(29, workForm.getWaterDrawlPermissionReqDate());
			ps.setString(30, workForm.getRailwayCrossingPermissionNumber());
			ps.setString(31,  workForm.getRailwayCrossingPermissionReqDate());
			ps.setString(32, workForm.getRoadCrossingPermissionReqNumber());
			ps.setString(33, workForm.getRoadCrossingPermissionReqNumberNHAI());
			ps.setString(34, workForm.getRoadCrossingPermissionReqDateNHAI());
			ps.setString(35, workForm.getForestClearanceReqNumber());
			ps.setString(36, workForm.getForestClearanceReqDate());
			ps.setString(37, workForm.getOthersReqNumber());
			ps.setString(38, workForm.getOthersReqDate());
			ps.setString(39, partAClearnce);
			ps.setString(40,workForm.getPartAClearnceDate());						
			ps.setString(41,workForm.getSourceCreated());
			ps.setString(42,workForm.getSourceCreatedDate());
			ps.setString(43, workForm.getRemarks());
			ps.setString(44, powerAPTranscoReq);
			ps.setString(45, workForm.getPowerAPTranscoReqNumber());
			ps.setString(46, workForm.getPowerAPTranscoReqDate());
			ps.setString(47, workForm.getPowerAPTranscoObtainNumber());
			ps.setString(48,workForm.getPowerAPTranscoObtainDate());
			ps.setString(49, hMWSSBReq);
			ps.setString(50, workForm.getHmwsReqNum());
			ps.setString(51, workForm.getHmwsReqDate());
			ps.setString(52,  workForm.getHmwsReqobtainNum());
			ps.setString(53, workForm.getHmwsReqobtainDate());
			ps.setString(54,  workForm.getPartAAmount());
			ps.setString(55, workForm.getDprPrepartion());						
			ps.setString(56,workForm.getAgencyName());
			ps.setString(57, workForm.getDprCharges());
			ps.setString(58, workForm.getHmwsChrgs());
			ps.setString(59, workForm.getLandAquisitionChrg());
			ps.setString(60, workForm.getWaterDrawlPermissionChrg());
			ps.setString(61, workForm.getRailwayCrossingPermissionChrg());
			ps.setString(62, workForm.getRoadCrossingPermissionChrg());
			ps.setString(63, workForm.getRoadCrossingPermissionNHAIChrg());
			ps.setString(64, workForm.getForestClearanceChrg());
			ps.setString(65, workForm.getOthersChrg());
			ps.setString(66, workForm.getGroundWaterInvestigationChg());
			ps.setString(67, workForm.getYieldTestingChg());
			ps.setString(68, workForm.getSourceCreationChg());
			ps.setString(69,  workForm.getPowerAPTranscoChrgs());
			ps.setString(70, workForm.getWorkIdList() );
			ps.setString(71, workForm.getPowerAPTranscoChrgs());

			return ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return 0;
	}
	public ArrayList getList(String circleCode, int cmbDivision) {

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs =null;
		ArrayList worksList = new ArrayList();
		try {

			conn = RwsOffices.getConn();
			
			RwsWorkDetails rwsWorkDetails = null;
			String query = "";
			if (circleCode != null && cmbDivision != 0) {

				query = "select a.work_id,a.work_name,a.SANCTION_AMOUNT,c.programme_name,d.subprogramme_name,b.DPRSTATUS,to_char(b.DPRCOMPDATE,'dd/MM/yyyy'),b.PARTACLEARANCE,to_char(b.PARTACLEARNCEDATE,'dd/MM/yyyy'),nvl(PARTAAMOUNT,'0'),b.remarks from rws_work_admn_tbl a,rws_notgroundworks_status_tbl b,rws_programme_tbl c,rws_subprogramme_tbl d "
						+ " where a.work_id=b.work_id and d.programme_code=c.programme_code and a.programme_code=c.programme_code and a.subprogramme_code=d.subprogramme_code and substr(a.office_code,2,2)=? and substr(a.office_code,4,1)=?";
			} else if (circleCode != null) {
				query = "select a.work_id,a.work_name,a.SANCTION_AMOUNT,c.programme_name,d.subprogramme_name,b.DPRSTATUS,to_char(b.DPRCOMPDATE,'dd/MM/yyyy'),b.PARTACLEARANCE,to_char(b.PARTACLEARNCEDATE,'dd/MM/yyyy'),nvl(PARTAAMOUNT,'0'),b.remarks from rws_work_admn_tbl a,rws_notgroundworks_status_tbl b ,rws_programme_tbl c,rws_subprogramme_tbl d "
						+ " where a.work_id=b.work_id and d.programme_code=c.programme_code and a.programme_code=c.programme_code and a.subprogramme_code=d.subprogramme_code and substr(a.office_code,2,2)=? ";
			}
				ps = conn.prepareStatement(query);
			if (circleCode != null && cmbDivision != 0) {
				ps.setString(1, circleCode);
				ps.setString(2, cmbDivision+"");
			}else if (circleCode != null) {
				ps.setString(1, circleCode);
			}
			rs = ps.executeQuery();

			while (rs.next()) {
				rwsWorkDetails = new RwsWorkDetails();
				rwsWorkDetails.setWorkId(rs.getString(1));
				rwsWorkDetails.setWorkName(rs.getString(2));
				rwsWorkDetails.setSanctionAmount(rs.getString(3));
				rwsWorkDetails.setProgrammeName(rs.getString(4));
				rwsWorkDetails.setSubProgrammeName(rs.getString(5));
				rwsWorkDetails.setDprStatus(rs.getString(6));
				rwsWorkDetails.setDprCompDate(rs.getString(7));
				rwsWorkDetails.setPartAClearnce(rs.getString(8));
				rwsWorkDetails.setPartAClearnceDate(rs.getString(9));
				rwsWorkDetails.setPartAAmount(rs.getString(10));
				rwsWorkDetails.setRemarks(rs.getString(11));

				worksList.add(rwsWorkDetails);
			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO getList:"+e);
		}finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return worksList;
	}

	public ArrayList getSanctionYears(String circleCode, int divCode,
			String cat, String programCode) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs2 = null;
		ArrayList sanYearsList = new ArrayList();

		try {
			String query = "";
			conn = RwsOffices.getConn();
			

			query = "select distinct to_char(admin_date,'yyyy')   from rws_work_admn_tbl a "
					+ " where substr(a.office_code,2,2)=? and substr(a.office_code,4,1)=? and a.CATEGORY_CODE=? "
					+ " and a.WORK_CANCEL_DT is null  and a.programme_code=? and a.work_id not in(select work_id from rws_work_commencement_tbl) order by to_char(admin_date,'yyyy') desc  ";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			ps.setString(2, divCode+"");
			ps.setString(3, cat);
			ps.setString(4, programCode);
			rs2 = ps.executeQuery();
			while (rs2.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs2.getString(1));
				labelValueBean.setLabel(rs2.getString(1));
				sanYearsList.add(labelValueBean);

			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO getSanctionYears:"+e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return sanYearsList;
	}

	public ArrayList getPrograms(String circleCode, int divCode, String cat) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		ArrayList programs = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			String query = "select distinct a.programme_code,a.PROGRAMME_NAME from rws_programme_tbl a,rws_work_admn_tbl b "
					+ " where a.programme_code=b.programme_code and substr(office_code,2,2)=? and substr(office_code,4,1)=? "
					+ " and b.work_id not in(select work_id from rws_work_commencement_tbl) order by a.programme_code";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			ps.setString(2, divCode+"");
			
			rs = ps.executeQuery();

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				programs.add(labelValueBean);
			}

		} catch (Exception e) {
			Debug.println("Exception in RwsWorksDAO getPrograms:"+e);
		}
		finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return programs;
	}

	public ArrayList getProgramsForNotCompletedWotks(String circleCode,
			int divCode, String cat) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement  ps=null;
		ArrayList programs = new ArrayList();
		 int ye = Calendar.getInstance().get(Calendar.YEAR);
		 int pfye;
		    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
		    
		    if (mon <= 3) {
		          pfye=ye - 1;		       
		    } else {
		          pfye=ye ;		       
		    }
		try {
			conn = RwsOffices.getConn();
			
			String query = "select distinct a.programme_code,a.PROGRAMME_NAME from rws_programme_tbl a,rws_work_admn_tbl b  where a.programme_code=b.programme_code "
					+ "and substr(office_code,2,2)=? and substr(office_code,4,1)=? "
					+ "and b.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion <=?) order by a.programme_code";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			ps.setInt(2, divCode);
			ps.setString(3, "31/MAR/"+pfye);
			
			rs = ps.executeQuery();

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				programs.add(labelValueBean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return programs;
	}

	/**
	 * @param parameter
	 * @param type_a_bill
	 * @return
	 */
	public ArrayList getBills(String workId, String type_a_bill) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "";
		ArrayList vouchers = new ArrayList();
		RwsPartABillRecord rwsPartABillRecord = null;
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT BILL_SL_NO,BILL_NO,to_char(bill_date,'dd/mm/yyyy'),BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,to_char(EE_FWD_DATE,'dd/mm/yyyy') as eeDate,PARTA_ITEM_CODE,CM_BY_DEE,CM_MBOOK_PG_NO,to_char(CM_DT,'dd/mm/yyyy'),SCM_BY_EE ,SCM_MBOOK_PG_NO,to_char(SCM_DT,'dd/mm/yyyy'),SCM_BY_SE,SCM_SE_MBOOK_PG_NO,to_char(SCM_SE_DT,'dd/mm/yyyy'),length(PASS_ORDER_SCAN_COPY) as pCopy  from RWS_WORK_BILL_TBL "
					+ " where work_id=? and BILL_TYPE=? ORDER BY 1";
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, workId);
			pstmt.setString(2, type_a_bill);
			rset = pstmt.executeQuery();

		String total = "0";
		while (rset.next()) {
			rwsPartABillRecord = new RwsPartABillRecord();
			rwsPartABillRecord.setBillSlNo(rset.getString(1));
			rwsPartABillRecord.setBillNo(rset.getString(2));
			rwsPartABillRecord.setBillDate(rset.getString(3));
			rwsPartABillRecord.setBillEEForwardDate(rset
					.getString("eeDate"));
			rwsPartABillRecord.setBillAmount(rset.getString(4));
			rwsPartABillRecord
					.setBillAmountAsPerPayOrder(rset.getString(5));
			rwsPartABillRecord.setItemCode(rset.getString(7));


			rwsPartABillRecord.setEmpCode(rset.getString(8));
			rwsPartABillRecord.setCmMBookNo(rset.getString(9));
			rwsPartABillRecord.setCheckMesuaredDate(rset.getString(10));
			rwsPartABillRecord.setEmpCodeSuper(rset.getString(11));
			rwsPartABillRecord.setScmMBookNo(rset.getString(12));
			rwsPartABillRecord
					.setSuperCheckMesuaredDate(rset.getString(13));
			rwsPartABillRecord.setSuperCheckBySE(rset.getString(14));
			rwsPartABillRecord.setSuperCheckPgNo(rset.getString(15));
			rwsPartABillRecord.setSuperCheckSEDate(rset.getString(16));
			rwsPartABillRecord.setBillSaved("yes");

			if (rset.getString("pCopy") != null
					&& !rset.getString("pCopy").equals("null")) {
				rwsPartABillRecord.setPassOrderScanCopyAvailable("A");
			} else {
				rwsPartABillRecord.setPassOrderScanCopyAvailable("NA");
			}
				rwsPartABillRecord.setGrossValueUpToThisBill(""
						+ (rset.getDouble(5) - (Double.parseDouble(total))));
				String stat123 = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id=? and BILL_SL_NO =?";
				pstmt = conn.prepareStatement(stat123);
				pstmt.setString(1, workId);
				pstmt.setString(2, rset.getString(1));
				ResultSet rsqq = pstmt.executeQuery();
				if (rsqq.next())
					rwsPartABillRecord.setAmountPaid(rsqq.getString(1));
				else
					rwsPartABillRecord.setAmountPaid("0");
				String stat1234 = "select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')a,"
						+ " (select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')b from dual";
				pstmt = conn.prepareStatement(stat1234);
				pstmt.setString(1, workId);
				pstmt.setString(2, rset.getString(1));
				pstmt.setString(3, workId);
				pstmt.setString(4, rset.getString(1));
				ResultSet rsqqq = pstmt.executeQuery();
				if (rsqqq.next()) {
					rwsPartABillRecord.setAmountReleased(""
							+ (rsqqq.getLong(1) + rsqqq.getLong(2)));
				} else
					rwsPartABillRecord.setAmountReleased("0");
				vouchers.add(rwsPartABillRecord);
			}
		} catch (Exception e) {
			Debug.println("Exception in getBills:"+e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return vouchers;
	}

	/**
	 * @param workId
	 * @return
	 */
	public ArrayList getItemsList(String workId) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList itemsLIst = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			String itemCodes = getItemCodes(workId);
			String query = "select * from rws_partA_items_tbl  where itemcode in ("+itemCodes+")order by itemcode ";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				itemsLIst.add(labelValueBean);
			}

		} catch (Exception e) {
			Debug.println("Exception in getItemsList:"+e);
		}
		finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return itemsLIst;
	}

	private String getItemCodes(String workId) {
		Connection conn = null;
		ResultSet rs = null, rs1 = null;
		Statement stmt1 = null, stmt2 = null;
		StringBuffer itemCodes = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = "select * from rws_notgroundworks_status_tbl where work_id=?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, workId);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if (rs.getString("LANDAQUISITIONCHRG") != null
						&& !rs.getString("LANDAQUISITIONCHRG").equals("0")
						&& !rs.getString("LANDAQUISITIONCHRG").equals("")) {
					itemCodes.append(Constants.LANDAQUISITION_CHRG);
					itemCodes.append(",");
				}
				if (rs.getString("WATERDRAWLPERMISSIONCHRG") != null
						&& !rs.getString("WATERDRAWLPERMISSIONCHRG")
								.equals("0")
						&& !rs.getString("WATERDRAWLPERMISSIONCHRG").equals("")) {
					itemCodes.append(Constants.WATERDRAWLPERMISSION_CHRG);
					itemCodes.append(",");
				}
				if (rs.getString("RAILWAYCROSSINGPERMISSIONCHRG") != null
						&& !rs.getString("RAILWAYCROSSINGPERMISSIONCHRG")
								.equals("0")
						&& !rs.getString("RAILWAYCROSSINGPERMISSIONCHRG")
								.equals("")) {
					itemCodes.append(Constants.RAILWAYCROSSINGPERMISSION_CHR);
					itemCodes.append(",");
				}
				if (rs.getString("ROADCROSSINGPERMISSIONCHRG") != null
						&& !rs.getString("ROADCROSSINGPERMISSIONCHRG").equals(
								"0")
						&& !rs.getString("ROADCROSSINGPERMISSIONCHRG").equals(
								"")) {
					itemCodes.append(Constants.ROADCROSSINGPERMISSION_CHRG);
					itemCodes.append(",");
				}
				if (rs.getString("ROADCROSSINGPERMISSIONNHAICHRG") != null
						&& !rs.getString("ROADCROSSINGPERMISSIONNHAICHRG")
								.equals("0")
						&& !rs.getString("ROADCROSSINGPERMISSIONNHAICHRG")
								.equals("")) {

					itemCodes.append(Constants.ROADCROSSINGPERMISSIONNHAI_CHRG);
					itemCodes.append(",");

				}
				if (rs.getString("FORESTCLEARANCECHRG") != null
						&& !rs.getString("FORESTCLEARANCECHRG").equals("0")
						&& !rs.getString("FORESTCLEARANCECHRG").equals("")) {

					itemCodes.append(Constants.FORESTCLEARANCE_CHRG);
					itemCodes.append(",");

				}
				if (rs.getString("OTHERSCHRG") != null
						&& !rs.getString("OTHERSCHRG").equals("0")
						&& !rs.getString("OTHERSCHRG").equals("")) {

					itemCodes.append(Constants.OTHERSCHRG);
					itemCodes.append(",");

				}
				if (rs.getString("POWERAPTRANSCOCHRGS") != null
						&& !rs.getString("POWERAPTRANSCOCHRGS").equals("0")
						&& !rs.getString("POWERAPTRANSCOCHRGS").equals("")) {

					itemCodes.append(Constants.POWERAPTRANSCO_CHRGS);
					itemCodes.append(",");

				}
				if (rs.getString("GROUNDWATERINVESTIGATIONCHG") != null
						&& !rs.getString("GROUNDWATERINVESTIGATIONCHG").equals(
								"0")
						&& !rs.getString("GROUNDWATERINVESTIGATIONCHG").equals(
								"")) {

					itemCodes.append(Constants.GROUNDWATERINVESTIGATION_CHG);
					itemCodes.append(",");

				}
				if (rs.getString("YIELDTESTINGCHG") != null
						&& !rs.getString("YIELDTESTINGCHG").equals("0")
						&& !rs.getString("YIELDTESTINGCHG").equals("")) {

					itemCodes.append(Constants.YIELDTESTING_CHG);
					itemCodes.append(",");

				}
				if (rs.getString("SOURCECREATIONCHG") != null
						&& !rs.getString("SOURCECREATIONCHG").equals("0")
						&& !rs.getString("SOURCECREATIONCHG").equals("")) {

					itemCodes.append(Constants.SOURCECREATION_CHG);
					itemCodes.append(",");

				}
				if (rs.getString("DPRCHARGES") != null
						&& !rs.getString("DPRCHARGES").equals("0")
						&& !rs.getString("DPRCHARGES").equals("")) {

					itemCodes.append(Constants.DPR_CHARGES);
					itemCodes.append(",");

				}
				if (rs.getString("HMWSCHRGS") != null
						&& !rs.getString("HMWSCHRGS").equals("0")
						&& !rs.getString("HMWSCHRGS").equals("")) {

					itemCodes.append(Constants.HMWS_CHRGS);
					itemCodes.append(",");
				}
			}
		} catch (Exception e) {
			System.out.println("Execption at getItemCodes in RwsWorksDAO: "+e);
		}
		return itemCodes.toString().substring(0,
				itemCodes.toString().length() - 1);
	}

	public void setBillAmount(RwsPartABillRecord rwsPartABillRecord,
			String workId) {
		Connection conn = null;
		ResultSet rs = null, rs3 = null;
		PreparedStatement pstmt = null;
		long billAmount = 0;
		try {
			conn = RwsOffices.getConn();

			String columnName = getItemNameByCode(Integer
					.parseInt(rwsPartABillRecord.getItemCode()));

			String billQuery = "select BILL_AMT_CONTRACTOR ,BILL_AMT_ADMISSIBLE from rws_work_bill_tbl where work_id=? and PARTA_ITEM_CODE=? and bill_type=?";
			pstmt=conn.prepareStatement(billQuery);
			pstmt.setString(1, workId);
			pstmt.setString(2, rwsPartABillRecord.getItemCode());
			pstmt.setString(3, Constants.TYPE_A_BILL );
			rs3 = pstmt.executeQuery();
			while (rs3.next()) {
				billAmount += Long.parseLong(rs3.getString(2));

			}

			String query = "select " + columnName
					+ " from rws_notgroundworks_status_tbl where work_id=?";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, workId);
			rs = pstmt.executeQuery();


			if (rs.next()) {
				if (billAmount >= Long.parseLong(rs.getString(1))) {
					rwsPartABillRecord.setBillAmount(String.valueOf(billAmount
							- Long.parseLong(rs.getString(1)) - billAmount));
				} else {
					rwsPartABillRecord.setBillAmount(String.valueOf(Long
							.parseLong(rs.getString(1))
							- billAmount));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * @param
	 * @return
	 */
	private String getItemNameByCode(int itemCode) {

		switch (itemCode) {

		case Constants.LANDAQUISITION_CHRG:
			return "LANDAQUISITIONCHRG";
		case Constants.WATERDRAWLPERMISSION_CHRG:
			return "WATERDRAWLPERMISSIONCHRG";
		case Constants.RAILWAYCROSSINGPERMISSION_CHR:
			return "RAILWAYCROSSINGPERMISSIONCHRG";
		case Constants.ROADCROSSINGPERMISSION_CHRG:
			return "ROADCROSSINGPERMISSIONCHRG";
		case Constants.ROADCROSSINGPERMISSIONNHAI_CHRG:
			return "ROADCROSSINGPERMISSIONNHAICHRG";
		case Constants.FORESTCLEARANCE_CHRG:
			return "FORESTCLEARANCECHRG";
		case Constants.POWERAPTRANSCO_CHRGS:
			return "POWERAPTRANSCOCHRGS";
		case Constants.HMWS_CHRGS:
			return "HMWSCHRGS";
		case Constants.OTHERSCHRG:
			return "OTHERSCHRG";
		case Constants.GROUNDWATERINVESTIGATION_CHG:
			return "GROUNDWATERINVESTIGATIONCHG";
		case Constants.YIELDTESTING_CHG:
			return "YIELDTESTINGCHG";
		case Constants.SOURCECREATION_CHG:
			return "SOURCECREATIONCHG";

		case Constants.DPR_CHARGES:
			return "dprCharges";
		default:
			return "";

		}

	}

	/**
	 * @param workId
	 * @param parABillform
	 * @param actionServlet 
	 */
	public String saveBills(String workId, RwspartABillForm parABillform, ActionServlet actionServlet) {
		Connection conn = null;
		String returnValue = "";
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		PreparedStatement pstmt = null,pstmt1 = null;
		boolean ff = false;

		try {
			conn = RwsOffices.getConn();
			
			String query = "";
			for (int i = 0; i < parABillform.getBillsList().size(); i++) {

				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) parABillform
						.getBillsList().get(i);

				String qq = "select * from rws_work_bill_tbl where work_id=? and bill_sl_no=?";
				pstmt1 = conn.prepareStatement(qq);
				pstmt1.setString(1, workId);
				pstmt1.setString(2, rwsPartABillRecord.getBillSlNo());
				ResultSet rs1 = pstmt1.executeQuery();

				if (rs1.next()) {
					if (Integer.parseInt(rwsPartABillRecord.getBillAmount()) >= Integer
							.parseInt(rwsPartABillRecord
									.getBillAmountAsPerPayOrder())) {
						
						String eeForwardDate=rs1.getString("EE_FWD_DATE");
						java.sql.Blob lenValue=rs1.getBlob("PASS_ORDER_SCAN_COPY");
						formFile = rwsPartABillRecord.getPassOrderScanCopy();
				
				if(formFile!=null){
						query = "update rws_work_bill_tbl set BILL_AMT_ADMISSIBLE=?,BILL_AMT_CONTRACTOR=?,ee_fwd_date=to_date(?,'dd/mm/yy'),CM_BY_DEE=?,CM_MBOOK_PG_NO=?,CM_DT=to_date(?,'dd/mm/yy'),SCM_BY_EE=?,SCM_MBOOK_PG_NO=?,SCM_DT=to_date(?,'dd/mm/yy'),SCM_BY_SE=?,SCM_SE_MBOOK_PG_NO=?,SCM_SE_DT=to_date(?,'dd/mm/yy'),PASS_ORDER_SCAN_COPY=?,PARTA_ITEM_CODE=? where work_id=? and bill_sl_no=? and BILL_TYPE=?";
				}else{
					if(lenValue==null && eeForwardDate==null){
					returnValue="Pass Order Scan Copy File Size Shoud Be Mandatory.";
					conn.setAutoCommit(true);
					return returnValue;}else{
					query = "update rws_work_bill_tbl set BILL_AMT_ADMISSIBLE=?,BILL_AMT_CONTRACTOR=?,ee_fwd_date=to_date(?,'dd/mm/yy'),CM_BY_DEE=?,CM_MBOOK_PG_NO=?,CM_DT=to_date(?,'dd/mm/yy'),SCM_BY_EE=?,SCM_MBOOK_PG_NO=?,SCM_DT=to_date(?,'dd/mm/yy'),SCM_BY_SE=?,SCM_SE_MBOOK_PG_NO=?,SCM_SE_DT=to_date(?,'dd/mm/yy'),PARTA_ITEM_CODE=? where work_id=? and bill_sl_no=? and BILL_TYPE=?";
					}
				}

						pstmt = conn.prepareStatement(query);
						pstmt.setString(1, rwsPartABillRecord
								.getBillAmountAsPerPayOrder());
						pstmt.setString(2, rwsPartABillRecord.getBillAmount());
						pstmt.setString(3, rwsPartABillRecord.getBillEEForwardDate());
						pstmt.setString(4, rwsPartABillRecord
								.getEmpCode());
						pstmt.setString(5,rwsPartABillRecord.getCmMBookNo());
						pstmt.setString(6,rwsPartABillRecord.getCheckMesuaredDate());
						pstmt.setString(7, rwsPartABillRecord.getEmpCodeSuper());
						pstmt.setString(8, rwsPartABillRecord.getScmMBookNo());
						pstmt.setString(9, rwsPartABillRecord.getSuperCheckMesuaredDate());
						pstmt.setString(10, rwsPartABillRecord.getSuperCheckBySE());
						pstmt.setString(11, rwsPartABillRecord.getSuperCheckPgNo());
						pstmt.setString(12, rwsPartABillRecord.getSuperCheckSEDate());
						
										
				if(formFile!=null){
						try {
							String path = actionServlet.getServletContext()
									.getRealPath("")
									+ File.separator
									+ formFile.getFileName();
							scannedFile = new File(path);
							outputStream = new FileOutputStream(scannedFile);
							if (outputStream != null) {
								outputStream.write(formFile.getFileData());
							}
							fis = new FileInputStream(scannedFile);
							if (fis != null) {
								
							}
						} catch (Exception e) {
							Debug.println("Exception in saveBills:"+e);
						} finally {
							if (fis != null) {
							}
						}

						double fileSizeMB = ((rwsPartABillRecord.getPassOrderScanCopy().getFileSize()/1024.0)/1024.0);
						
						if(fileSizeMB>1)	{
							returnValue="Pass Order Scan Copy File Size Shoud Not Be Allowed More Than 1 MB";
							conn.setAutoCommit(true);
							scannedFile.delete();
							outputStream.close();
							return returnValue;
							
						}
						pstmt.setBinaryStream(13, fis, rwsPartABillRecord
								.getPassOrderScanCopy().getFileSize());
						pstmt.setString(14, rwsPartABillRecord.getItemCode());
						pstmt.setString(15, workId);
						pstmt.setString(16,rwsPartABillRecord.getBillSlNo() );
						pstmt.setString(17,"A" );
						

						}else{
							pstmt.setString(13, rwsPartABillRecord.getItemCode());
							pstmt.setString(14, workId);
							pstmt.setString(15,rwsPartABillRecord.getBillSlNo() );
							pstmt.setString(16,"A" );
						}
						
						
						pstmt.addBatch();
						

						if (scannedFile != null) {
							scannedFile.delete();
						}
						if (outputStream != null) {
						}
						if (fis != null) {
						}
					} else {
						ff = true;
					}
				} else {
					if (Integer.parseInt(rwsPartABillRecord.getBillAmount()) >= Integer
							.parseInt(rwsPartABillRecord
									.getBillAmountAsPerPayOrder())) {
						
						
						
						
						String billInsertQuery = "insert into rws_work_bill_tbl(WORK_ID,BILL_SL_NO,BILL_NO,BILL_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,UPDATE_DATE,BILL_TYPE,PARTA_ITEM_CODE,CM_BY_DEE,CM_MBOOK_PG_NO,CM_DT,SCM_BY_EE ,SCM_MBOOK_PG_NO,SCM_DT,SCM_BY_SE,SCM_SE_MBOOK_PG_NO,SCM_SE_DT,PASS_ORDER_SCAN_COPY) values(?,?,?,to_date(?,'dd/mm/yy'),?,?,sysdate,?,?,?,?,to_date(?,'dd/mm/yy'),?,?,to_date(?,'dd/mm/yy'),?,?,to_date(?,'dd/mm/yy'),?)";

						pstmt = conn.prepareStatement(billInsertQuery);

						pstmt.setString(1, workId);
						pstmt.setString(2, rwsPartABillRecord.getBillSlNo());
						pstmt.setString(3, rwsPartABillRecord.getBillNo());
						pstmt.setString(4, rwsPartABillRecord.getBillDate());
						pstmt.setString(5, rwsPartABillRecord.getBillAmount());
						pstmt.setString(6, rwsPartABillRecord
								.getBillAmountAsPerPayOrder());
						pstmt.setString(7, Constants.TYPE_A_BILL);
						pstmt.setString(8, rwsPartABillRecord.getItemCode());

						pstmt.setString(9, rwsPartABillRecord.getEmpCode());
						pstmt.setString(10, rwsPartABillRecord.getCmMBookNo());
						pstmt.setString(11, rwsPartABillRecord
								.getCheckMesuaredDate());
						pstmt.setString(12, rwsPartABillRecord
								.getEmpCodeSuper());
						pstmt.setString(13, rwsPartABillRecord.getScmMBookNo());
						pstmt.setString(14, rwsPartABillRecord
								.getSuperCheckMesuaredDate());
						pstmt.setString(15, rwsPartABillRecord
								.getSuperCheckBySE());
						pstmt.setString(16, rwsPartABillRecord
								.getSuperCheckPgNo());
						pstmt.setString(17, rwsPartABillRecord
								.getSuperCheckSEDate());
						formFile = rwsPartABillRecord.getPassOrderScanCopy();
						if (formFile != null) {
							try {

								String path = actionServlet.getServletContext()
										.getRealPath("")
										+ File.separator
										+ formFile.getFileName();
								scannedFile = new File(path);
								outputStream = new FileOutputStream(scannedFile);
								if (outputStream != null) {
									outputStream.write(formFile.getFileData());
								}
								fis = new FileInputStream(scannedFile);
								if (fis != null) {
								}
							} catch (Exception e) {
								e.printStackTrace();
							} finally {
								if (fis != null) {
									// fis.close();
								}
							}


							double fileSizeMB = ((rwsPartABillRecord
									.getPassOrderScanCopy().getFileSize() / 1024.0) / 1024.0);

							if (fileSizeMB > 1) {
								returnValue = "Pass Order Scan Copy File Size Shoud Not Be Allowed More Than 1 MB";
								conn.setAutoCommit(true);
								scannedFile.delete();
								outputStream.close();
								return returnValue;

							}
							pstmt.setBinaryStream(18, fis, rwsPartABillRecord
									.getPassOrderScanCopy().getFileSize());
						} else {
							returnValue = "Pass Order Scan Copy File Size Shoud Be Mandatory.";
							conn.setAutoCommit(true);
							return returnValue;
						}

						pstmt.addBatch();

						if (scannedFile != null) {
							scannedFile.delete();
						}
						if (outputStream != null) {
							// outputStream.close();
						}
						if (fis != null) {
							// fis.close();
						}


					} else {
						ff = true;
					}

				}

			}

			int[] val = pstmt.executeBatch();
			if (val.length > 0) {
				returnValue = "Saved Successfully";
			}

			if (ff)
				returnValue = "Failed to Save/Update Voucher(s) - Admissible Amount of the Bill Should Not be Greater than Contractor Amount";
			return returnValue;

		} catch (Exception e) {
			Debug.println("Exception in saveBills:"+e);
		}
		return returnValue;

	}

	/**
	 * @param parABillform
	 * @param removeList
	 * @return
	 */
	public String removeBill(RwspartABillForm parABillform,
			String[] removeList, String remarks, String userId) {
		String returnValue = "";
		int alreadyThere = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt=null;
		String workId = parABillform.getWorkId();
		String query = "";
		ArrayList billsList = parABillform.getBillsList();
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt=conn.createStatement();

			boolean flag = false;
			RwsPartABillRecord rwsPartABillRecord1 = (RwsPartABillRecord) billsList
					.get(0);
			if (rwsPartABillRecord1.getBillSlNo().equals("0"))
				flag = true;

			String index = "";
			for (int i = 0; i < billsList.size(); i++) {
				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) billsList
						.get(i);

				if (rwsPartABillRecord.getBillSlNo().equals(removeList[0])) {
					index = "" + i;
				}
			}
			for (int i = 0; i < removeList.length; i++) {
				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) billsList
						.get(Integer.parseInt(index));
				query = "select * from RWS_WORK_EXP_VOUCHER_TBL where work_id=? and BILL_SL_NO=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, rwsPartABillRecord.getBillSlNo());
				ResultSet rss = pstmt.executeQuery();
				pstmt.close();
				
				query = "select * from RWS_BILL_BANK_BRIDGE_TBL where work_id=? and BILL_SL_NO=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, rwsPartABillRecord.getBillSlNo());
				ResultSet rsss = pstmt.executeQuery();
				pstmt.close();
				
				query = "select * from RWS_BILL_BANK_BRIDGE_TEMP_TBL where work_id=? and BILL_SL_NO=?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, rwsPartABillRecord.getBillSlNo());
				ResultSet rssss = pstmt.executeQuery();
				pstmt.close();
				
				if (rsss.next()) {
					alreadyThere = -1;
				} else if (rssss.next()) {
			
					 	} else if (!rss.next() && alreadyThere >= 0) {
					String query1 = "insert into RWS_WORK_BILL_DEL_TBL select WORK_ID,BILL_SL_NO,BILL_NO,BILL_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,UPDATE_DATE,sysdate,'"
							+ remarks
							+ "','"
							+ userId
							+ "' from RWS_work_BILL_TBL where work_id='"
							+ workId
							+ "' and BILL_SL_NO='"
							+ rwsPartABillRecord.getBillSlNo() + "'";
					stmt.addBatch(query1);
					query1 = "delete from rws_work_bill_tbl where work_id='"
							+ workId + "' and BILL_SL_NO='"
							+ rwsPartABillRecord.getBillSlNo() + "'";
					stmt.addBatch(query1);
					query1 = "delete from RWS_WORK_MILESTONE_BILL_TBL where work_id='"
							+ workId
							+ "' and BILL_SL_NO='"
							+ rwsPartABillRecord.getBillSlNo() + "'";
					stmt.addBatch(query1);
				} else {
					alreadyThere++;
				}
			}
			int[] val = stmt.executeBatch();
			if (val.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
				if (alreadyThere == 0)
					returnValue = (removeList.length)
							+ "Bill(s) Deleted Successfully for the Work ID:"
							+ workId;
				if (alreadyThere > 0)
					returnValue = (removeList.length - alreadyThere)
							+ "Bill(s) Deleted Successfully and "
							+ alreadyThere
							+ " Bill(s) Not Deleted Because Voucher(s) Exists for the Work ID:"
							+ workId;
			} else {
				if (alreadyThere == -1)
					returnValue = "Bill cannot be Deleted because Head Office released the amount (GOI/State) for this Bill of the Work ID:"
							+ workId;
				else if (alreadyThere == -2)
					returnValue = "Bill cannot be Deleted because Head Office to be released the amount (GOI/State) for this Bill of the Work ID:"
							+ workId;
				else
					returnValue = "No Bill(s) Removed Because Voucher(s) Exists for the Bill(s)";
			}

		} catch (Exception e) {
			try {
				conn.rollback();
				returnValue = "Failed to Remove Bill(s)";
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			Debug.println("Exception in remove bills:" + e);
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					if (pstmt != null)
						pstmt.close();
					conn.close();
			} catch (Exception e) {
				System.out.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;

	}

	public String getBillSlNo(String work_id) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			
			String q1 = "select  max(BILL_SL_NO) from rws_work_bill_tbl where work_id=?";
			pstmt = conn.prepareStatement(q1);
			pstmt.setString(1, work_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int value = rs.getInt(1) + 1;
				return String.valueOf(value);
			} else {
				return "1";
			}

		} catch (Exception e) {
			Debug.println("Exception in getBillSlNo:"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return null;
	}

	public String saveVouchers(ArrayList vouchers, String workId,
			ArrayList progs) {
		String returnValue = "";
		Connection conn = null;
		Statement stmt1 = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt1 = conn.createStatement();
			query = "delete from RWS_WORK_EXP_VOUCHER_TBL where work_id='"
					+ workId + "'";
			stmt1.addBatch(query);
			for (int j = 0; j < vouchers.size(); j++) {
				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) vouchers
						.get(j);
				Debug
						.println("voucher no:"
								+ rwsPartABillRecord.getVoucherNo());
				double vAmount = (Double.parseDouble(rwsPartABillRecord
						.getVoucherAmount())) / 100000;
				vAmount = round(vAmount, 2);
				
				query = "insert into RWS_WORK_EXP_VOUCHER_TBL(WORK_ID,RECORDED_BY,RECORDED_DATE,CHECK_MEASURE_DT,CHECK_MEASURED_BY,VOUCHER_NO,VOUCHER_DT,VOUCHER_AMT,CHEQUE_NO,CHEQUE_DT,SUPER_CHECK_MEASURE_DT,SUPER_CHECK_MEASURED_BY,REMARKS,PROGRAMME_CODE,MBOOK_NO,MILESTONE_SLNO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO,PAYMENT_MODE,UPDATE_DATE,EE_APPROVED_DATE) values('"
						+ workId + "'," + "'"
						+ rwsPartABillRecord.getEmpCodeRecorded() + "',"
						+ "to_date('" + rwsPartABillRecord.getRecordedDate()
						+ "','dd/mm/yyyy')," + "to_date('"
						+ rwsPartABillRecord.getCheckMesuaredDate()
						+ "','dd/mm/yyyy')," + "'"
						+ rwsPartABillRecord.getEmpCode() + "'," + "'"
						+ rwsPartABillRecord.getVoucherNo() + "',"
						+ "to_date('" + rwsPartABillRecord.getVoucherDate()
						+ "','dd/mm/yyyy')," + "'"
						+ rwsPartABillRecord.getVoucherAmount() + "'," + "'"
						+ rwsPartABillRecord.getChequeNo() + "'," + "to_date('"
						+ rwsPartABillRecord.getChequeDate()
						+ "','dd/mm/yyyy')," + "to_date('"
						+ rwsPartABillRecord.getSuperCheckMesuaredDate()
						+ "','dd/mm/yyyy')," + "'"
						+ rwsPartABillRecord.getEmpCodeSuper() + "'," + "'"
						+ rwsPartABillRecord.getCheckMesuaredRemarks() + "',"
						+ "'" + rwsPartABillRecord.getProgCode() + "'," + "'"
						+ rwsPartABillRecord.getSno() + "'," + "'','"
						+ rwsPartABillRecord.getContCode() + "','"
						+ rwsPartABillRecord.getBudgetInfo() + "','"
						+ rwsPartABillRecord.getBillSlNo() + "','"
						+ rwsPartABillRecord.getPaymentMode() + "',sysdate,'')";
				
				
				
				stmt1.addBatch(query);
			}

			int[] val = stmt1.executeBatch();
			if (val.length > 0) {
				try {
					String qqry = "delete from rws_work_exp_tmp_tbl where work_id='"
							+ workId + "'";
					/*
					 * if(slNo!=null && !slNo.equals("")) qqry += " and
					 * MILESTONE_SLNO ='"+slNo+"'";
					 */
					//stmt2.addBatch(qqry);
					for (int k = 0; k < vouchers.size(); k++) {
						RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) vouchers
								.get(k);
						double vAmount = (Double.parseDouble(rwsPartABillRecord
								.getVoucherAmount())) / 100000;
						vAmount = round(vAmount, 2);
						String date = rwsPartABillRecord.getVoucherDate();
						String mm = date.substring(3, 5);
						String yyyy = date.substring(6, 10);
						String qq = "insert into rws_work_exp_tmp_tbl values "
								+ "('" + workId + "','" + yyyy + "','" + mm
								+ "'," + "" + vAmount + ",'"
								+ rwsPartABillRecord.getProgCode() + "','')";
					}
				} catch (Exception e) {
					try {
						conn.rollback();
						returnValue = "Failed to Save/Update Voucher(s)";
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					Debug.println("Exception in saveVouchers:" + e);
				}
				if (val[0] > 0)
					returnValue = "Voucher(s) Successfully Updated for the Work ID:"
							+ workId;
				else
					returnValue = "Voucher(s) Successfully Inserted for the Work ID:"
							+ workId;
				conn.setAutoCommit(true);
				conn.commit();
			}

		} catch (Exception e) {

			try {
				conn.rollback();
				returnValue = "Failed to Save/Update Voucher(s)";

			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			Debug.println("Exception in saveVouchers:" + e);
		} finally {
			try {
				if (stmt1 != null)
					stmt1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;

	}

	public ArrayList getVouchers(String workId) {
		ArrayList vouchers = new ArrayList();
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rset = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT recorded_by,to_char(recorded_date,'dd/mm/yyyy'),check_measured_by,to_char(check_measure_dt,'dd/mm/yyyy'),voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt,cheque_no,to_char(cheque_dt,'dd/mm/yyyy'),SUPER_CHECK_MEASURED_BY,to_char(SUPER_CHECK_MEASURE_DT,'dd/mm/yyyy'),REMARKS,PROGRAMME_CODE,nvl(MBOOK_NO,'') as MBOOK_NO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO,payment_mode"
					+ " from RWS_WORK_EXP_VOUCHER_TBL where work_id=? ORDER BY RECORDED_DATE";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, workId);
			rset = pstmt.executeQuery();
			RwsPartABillRecord rwsPartABillRecord = null;
			while (rset.next()) {
				rwsPartABillRecord = new RwsPartABillRecord();
				rwsPartABillRecord
						.setProgCode(rset.getString("PROGRAMME_CODE"));
				rwsPartABillRecord.setSno(rset.getString("MBOOK_NO"));
				rwsPartABillRecord.setEmpCodeRecorded(rset.getString(1));
				rwsPartABillRecord.setRecordedDate(rset.getString(2));
				rwsPartABillRecord.setEmpCode(rset.getString(3));
				rwsPartABillRecord.setCheckMesuaredDate(rset.getString(4));
				rwsPartABillRecord.setVoucherNo(rset.getString(5));
				rwsPartABillRecord.setVoucherDate(rset.getString(6));
				rwsPartABillRecord.setVoucherAmount(rset.getString(7));
				rwsPartABillRecord.setChequeNo(rset.getString(8));
				rwsPartABillRecord.setChequeDate(rset.getString(9));
				rwsPartABillRecord.setEmpCodeSuper(rset.getString(10));
				rwsPartABillRecord
						.setSuperCheckMesuaredDate(rset.getString(11));
				rwsPartABillRecord.setCheckMesuaredRemarks(rset.getString(12));
				rwsPartABillRecord.setContCode(rset
						.getString("CONTRACTOR_CODE"));
				rwsPartABillRecord.setBudgetInfo(rset
						.getString("GRANT_DISTRIB"));
				rwsPartABillRecord.setBillSlNo(rset.getString("BILL_SL_NO"));
				String amt = getBillVoucherAmount(workId, rset
						.getString("BILL_SL_NO"));
				String[] amts = amt.split("/");
				rwsPartABillRecord.setPaymentAdmissable(amts[0]);
				rwsPartABillRecord.setBillVoucherAmount(amts[1]);
				rwsPartABillRecord.setPaymentMode(rset
						.getString("payment_mode"));
				vouchers.add(rwsPartABillRecord);
			}
		} catch (Exception e) {
			Debug.println("Exception in getVouchers"+e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return vouchers;

	}

	public String getBillVoucherAmount(String workId, String bill) {
		DecimalFormat ndf = new DecimalFormat("####.00");
		ResultSet rs123 = null;
		String returnValue = "";
		try {
			Connection conn = RwsOffices.getConn();
			Statement stqq = null;
			ResultSet rsqq = null;
			String getAmount = "";
			Statement gmst1 = conn.createStatement();
			if (bill.equals("0")) {
				getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_bill_tbl where work_id='"
						+ workId + "' and BILL_SL_NO ='" + bill + "' ";
				ResultSet gmrs1 = gmst1.executeQuery(getAmount);
				if (gmrs1.next()) {
					returnValue = gmrs1.getString(1);
				} else {
					returnValue = "0";
				}
			} else {
				// getAmount = "select (select nvl(BILL_AMOUNT_CENTRAL,0) from
				// rws_bill_bank_bridge_det_tbl where work_id='"+workId+"' and
				// BILL_SL_NO ='"+bill+"' and BILL_ACTIVATION_FLAG='P')a,(select
				// nvl(BILL_AMOUT_state,0) from rws_bill_pao_bridge_det_tbl
				// where work_id='"+workId+"' and BILL_SL_NO ='"+bill+"' and
				// BILL_ACTIVATION_FLAG='P')b from dual";
				getAmount = "select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id='"
						+ workId
						+ "' and BILL_SL_NO ='"
						+ bill
						+ "' and BILL_ACTIVATION_FLAG='P')a,(select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id='"
						+ workId
						+ "' and BILL_SL_NO ='"
						+ bill
						+ "' and BILL_ACTIVATION_FLAG='P')b from dual";

				ResultSet gmrs1 = gmst1.executeQuery(getAmount);
				long val1 = 0, val2 = 0;
				if (gmrs1.next()) {
					if (gmrs1.getString(1) != null
							&& !gmrs1.getString(1).equals(""))
						val1 = gmrs1.getLong(1);
					if (gmrs1.getString(2) != null
							&& !gmrs1.getString(2).equals(""))
						val2 = gmrs1.getLong(2);
				}
				returnValue = "" + (val1 + val2);
			}
			returnValue += "/";

			String stat123 = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id='"
					+ workId + "' and BILL_SL_NO ='" + bill + "' ";
			stqq = conn.createStatement();
			rsqq = stqq.executeQuery(stat123);
			if (rsqq.next()) {
				// returnValue +=
				// ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2)
				returnValue += "" + rsqq.getString(1);// Math.round(Float.parseFloat(rsqq.getString(1))*100000*100)/100f);
			} else {
				returnValue += "0";
			}
		} catch (Exception e) {
			System.out.println("EXCEPTION IN getting Connection"
					+ e.getMessage());
		} finally {
			try {
			} catch (Exception d) {

			}
		}
		return returnValue;
	}

	public static double round(double d, int decimalPlace) {
		BigDecimal bd = null;
		try {
			bd = new BigDecimal(Double.toString(d));
			bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bd.doubleValue();
	}

	public String removeVouchers(ArrayList vouchers, String workId,
			String[] removeList) {
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt=null;
		String returnValue = "", query = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			for (int i = 0; i < removeList.length; i++) {
				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) vouchers
						.get(Integer.parseInt(removeList[i]));
				double vAmount = (Double.parseDouble(rwsPartABillRecord
						.getVoucherAmount())) / 100000;
				vAmount = round(vAmount, 2);
				query = "delete from RWS_WORK_EXP_VOUCHER_TBL where work_id='"
						+ workId + "' and VOUCHER_NO=" + "'"
						+ rwsPartABillRecord.getVoucherNo() + "'";

				stmt.addBatch(query);
				String date = rwsPartABillRecord.getVoucherDate();
				String mm = date.substring(3, 5);
				String yyyy = date.substring(6, 10);
				query = "delete from rws_work_exp_tmp_tbl where work_id='"
						+ workId + "' and year='" + yyyy + "' and month='" + mm
						+ "' and programme_code ='"
						+ rwsPartABillRecord.getProgCode()
						+ "' and expenditure_during='" + vAmount + "'";

				stmt.addBatch(query);
			}
			int[] val = stmt.executeBatch();
			String qqqry = "select sum(EXPENDITURE_DURING),year,month,programme_code from rws_work_exp_tmp_tbl where work_id=? group by year,month,programme_code order by 2,3";
			pstmt=conn.prepareStatement(qqqry);
			pstmt.setString(1, workId);
			ResultSet rs = pstmt.executeQuery();
			stmt3.addBatch("delete from rws_work_expenditure_tbl where work_id='"
							+ workId + "'");
			String prevYear = "0";
			String upto = "0";
			String prevExp = "0";
			String prevProg = "";
			while (rs.next()) {
				int year = rs.getInt("YEAR");
				String yr = "";
				int month = rs.getInt("MONTH");
				if (month >= 4 && month <= 12) {
					int yr1 = year + 1;
					yr = (year) + "-" + (("" + yr1).substring(2, 4));
				} else {
					int yr1 = year - 1;
					yr = yr1 + "-" + (("" + year)).substring(2, 4);
				}
				if ((!prevYear.equals("0") && prevYear.equals(yr))
						&& (!prevProg.equals("") && prevProg.equals(rs
								.getString("programme_code")))) {
					upto = prevExp;
				} else {
					upto = "0";
				}
				String qqq = "insert into rws_work_expenditure_tbl(WORK_ID,YEAR,MONTH,EXPENDITURE_UPTO,EXPENDITURE_DURING,PROGRAMME_CODE,UPDATE_DATE) values "
						+ "('"
						+ workId
						+ "','"
						+ yr
						+ "','"
						+ rs.getString("MONTH")
						+ "','"
						+ upto
						+ "',"
						+ rs.getString(1)
						+ ",'"
						+ rs.getString("programme_code") + "',SYSDATE)";
				stmt3.addBatch(qqq);
				prevYear = yr;
				prevExp = rs.getString(1);
				prevProg = rs.getString("programme_code");
			}
			stmt3.executeBatch();
			if (val.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
				returnValue = "Voucher(s) Deleted Successfully for the Work ID:"
						+ workId;
			}

		} catch (Exception e) {
			try {
				conn.rollback();
				returnValue = "Failed to Remove Voucher(s)";
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			Debug.println("Exception in saveVouchers:" + e);
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;

	}

	public String getPartAAMount(String work_id) {
	Connection conn = null;
	PreparedStatement pstmt = null,pstmt1=null;
	ResultSet rs = null,rs1=null;
	try {
		conn = RwsOffices.getConn();
		
		String q1 = "select  (nvl(PARTAAMOUNT,'0')*100000)  from rws_notgroundworks_status_tbl where work_id=?";
		pstmt = conn.prepareStatement(q1);
		pstmt.setString(1, work_id);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			if(rs.getString(1).equals("0")) {
				String bankPartA="",paoPartA="",q="";
				q = "select nvl(sum(nvl(b.BILL_AMOUNT_CENTRAL,0)),0) from RWS_WORK_BILL_TBL a,RWS_BILL_BANK_BRIDGE_DET_TBL b where BILL_TYPE='A' and a.WORK_ID=b.WORK_ID and a.BILL_SL_NO=b.BILL_SL_NO  and a.work_id=?";
				pstmt1 = conn.prepareStatement(q);
				pstmt1.setString(1, work_id);
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					bankPartA= rs1.getString(1);
				}
				rs1.close();
				pstmt1.close();
				q = "select nvl(sum(nvl(b.BILL_AMOUT_STATE,0)),0) from RWS_WORK_BILL_TBL a,RWS_BILL_PAO_BRIDGE_DET_TBL b where BILL_TYPE='A' and a.WORK_ID=b.WORK_ID and a.BILL_SL_NO=b.BILL_SL_NO  and a.work_id=?";
				pstmt1 = conn.prepareStatement(q);
				pstmt1.setString(1, work_id);
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					//System.out.println("fdhgh   "+ rs1.getString(1));
					paoPartA= rs1.getString(1);
				}
				rs1.close();
				pstmt1.close();
				long parta=Long.parseLong(bankPartA)+Long.parseLong(paoPartA);
				
				return parta+"";
				
			
			}
				else {
					return rs.getString(1);
				}
			
		} else {
			return "0";
		}

	} catch (Exception e) {
		Debug.println("Exception in getPartAAMount:" + e);
	} finally {
		try {
			if (conn != null) {
				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		return "";
	}

	public Object getSchemes(String circleCode, int divCode, String category) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		ArrayList schemes = new ArrayList();
		 int ye = Calendar.getInstance().get(Calendar.YEAR);
		 int pfye;
		    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
		    
		    if (mon <= 3) {
		          pfye=ye - 1;		       
		    } else {
		          pfye=ye ;		       
		    }

		try {
			conn = RwsOffices.getConn();
			
			String query = "select distinct  type_of_asset_code,type_of_asset_name    from rws_asset_type_tbl b,rws_work_admn_tbl a "
					+ "where substr(a.work_id,7,2)=b.type_of_asset_code and  substr(office_code,2,2)=? and substr(office_code,4,1)=? "
					+ "and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion <=?) order by b.type_of_asset_code";
			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			ps.setInt(2, divCode);
			ps.setString(3, "31/MAR/"+pfye);
			
			rs = ps.executeQuery();

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				schemes.add(labelValueBean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return schemes;
	}

	/**
	 * @param fb
	 */
	public String updateWorkDetails(rws_works_WorkStatus_form fb) {

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		try {
			conn = RwsOffices.getConn();
			String query="select *from rws_work_admn_tbl where work_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, fb.getNwork());
			rs = ps.executeQuery();
			if (rs.next()) {
				fb.setDivCode(rs.getString("OFFICE_CODE").substring(3,4));
				fb.setSubdivisioncode(rs.getString("OFFICE_CODE").substring(4,6));
				
				fb.setWorkCat(rs.getString("CATEGORY_CODE"));
				fb.setPlan(rs.getString("PLAN_CODE"));
				fb.setProgCode(rs.getString("PROGRAMME_CODE"));
				fb.setSubProgCode(rs.getString("SUBPROGRAMME_CODE"));
				fb.setWrktype(rs.getString("AUG_NEW_CODE"));
				fb.setProgram(rs.getString("PROGRAMME_CODE"));
				fb.setSubprogram(rs.getString("SUBPROGRAMME_CODE"));

				return "1";
			} else {
				return "WorkID doesn't Exists";
			}

		} catch (Exception e) {
			Debug.println("Exception in updateWorkDetails"+e);
		}
		return "1";
	}

	/**
	 * @param fb
	 * @param userId
	 * @return
	 */
	public ArrayList getWorksForWorkProgress(rws_works_WorkStatus_form bean,
			String userId) {
		Connection conn = null;
		ArrayList customerList = new ArrayList();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where "
					+ " substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and PLAN_CODE =? and AUG_NEW_CODE =? and CATEGORY_CODE=?";
			
			if (bean.getProgram() != null && !bean.getProgram().equals(""))
				query = query.concat(" and PROGRAMME_CODE ='"
						+ bean.getProgram() + "'");
			if (bean.getSubprogram() != null
					&& !bean.getSubprogram().equals(""))
				query = query.concat(" and SUBPROGRAMME_CODE ='"
						+ bean.getSubprogram() + "'");
			if (bean.getSubdivisioncode() != null
					&& !bean.getSubdivisioncode().equals(""))
				query = query.concat(" and substr(OFFICE_CODE,5,2)='"
						+ bean.getSubdivisioncode() + "'");
			if (bean.getSchemelist() != null
					&& !bean.getSchemelist().equals(""))
				query = query.concat(" and TYPE_OF_ASSET  ='"
						+ bean.getSchemelist() + "'");
			if (bean.getFinancialyear() != null
					&& !bean.getFinancialyear().equals(""))
				query = query.concat(" and (admin_date>='01/APR/"
						+ bean.getFinancialyear()
						+ "' and admin_date<='31/MAR/"
						+ (Integer.parseInt(bean.getFinancialyear()) + 1)
						+ "')");
			query += " order by work_id";
			prpStmt = conn.prepareStatement(query);
			prpStmt.setString(1, bean.getCircleCode());
			prpStmt.setString(2, bean.getDivCode());
			prpStmt.setString(3, bean.getPlan());
			prpStmt.setString(4, bean.getWrktype());
			prpStmt.setString(5, bean.getWorkCat());
			rs = prpStmt.executeQuery();
			while (rs.next()) {
				bean = new rws_works_WorkStatus_form();
				bean.setWorkId(rs.getString("work_id"));
				bean.setWorkName(rs.getString("work_id") + " - "
						+ rs.getString("work_Name"));
				customerList.add(bean);
			}

		} catch (SQLException e) {
			System.err	.println("SQL Exception occured while accessing the table"+e);
			return null;
		} catch (Exception e) {
			Debug.println("Exception in getWorksForWorkProgress:"+e);
			return null;
		} finally {
			try {
				if (prpStmt != null)
					prpStmt.close();
				if (rs != null)
					rs.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return customerList;
	}
	public Double getPartABillAMount(String work_id) {
		Connection conn = null;
		PreparedStatement pstmt = null,pstmt1=null;
		ResultSet rs = null,rs1=null;
		double parta=0;
		try {
			conn = RwsOffices.getConn();
			
			
				
					double bankPartA=0,paoPartA=0;
					String q="";
					q = "select nvl(sum(nvl(b.BILL_AMOUNT_CENTRAL,0)),0) from RWS_WORK_BILL_TBL a,RWS_BILL_BANK_BRIDGE_DET_TBL b where BILL_TYPE='A' and a.WORK_ID=b.WORK_ID and a.BILL_SL_NO=b.BILL_SL_NO  and a.work_id=?";
					pstmt1 = conn.prepareStatement(q);
					pstmt1.setString(1, work_id);
					rs1 = pstmt1.executeQuery();
					if (rs1.next()) {
						bankPartA= rs1.getDouble(1);
					}
					rs1.close();
					pstmt1.close();
					q = "select nvl(sum(nvl(b.BILL_AMOUT_STATE,0)),0) from RWS_WORK_BILL_TBL a,RWS_BILL_PAO_BRIDGE_DET_TBL b where BILL_TYPE='A' and a.WORK_ID=b.WORK_ID and a.BILL_SL_NO=b.BILL_SL_NO  and a.work_id=?";
					pstmt1 = conn.prepareStatement(q);
					pstmt1.setString(1, work_id);
					rs1 = pstmt1.executeQuery();
					if (rs1.next()) {
						paoPartA= rs1.getDouble(1);
					}
					rs1.close();
					pstmt1.close();
					parta=bankPartA+paoPartA;
					return parta;
	
		} catch (Exception e) {
			Debug.println("Exception in getPartAAMount:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			return parta;
	}

}