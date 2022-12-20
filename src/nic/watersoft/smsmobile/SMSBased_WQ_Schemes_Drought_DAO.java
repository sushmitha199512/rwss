package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class SMSBased_WQ_Schemes_Drought_DAO {

	private String query = null;
	private PreparedStatement ps;

	private Connection conn;

	private LabelValueBean labelValueBean = null;
	public static String errorMessage;
	private ResultSet rset = null;

	public ArrayList getDistricts() throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname " + " FROM rws_district_tbl " + "  " + " ORDER BY dcode,dname";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
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
		return dists;
	}

	public ArrayList getDistricts1(String circle) throws Exception {
		ArrayList dists = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT dcode, dname " + " FROM rws_district_tbl  where dcode='" + circle + "'" + "  "
					+ " ORDER BY dcode,dname";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				dists.add(labelValueBean);
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

		return dists;
	}

	public ArrayList getMandals(String dcode) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		try {
			conn = RwsOffices.getConn();
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
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode) throws Exception {
		ArrayList panchayats = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT pcode, pname " + " FROM rws_panchayat_tbl " + " where dcode=? and mcode=?"
					+ " ORDER BY pname";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				panchayats.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getPanchayats is "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getPanchayats is "+e);
				}
			}
		}

		return panchayats;
	}

	public ArrayList getVillages(String dcode, String mcode, String pcode) throws Exception {
		ArrayList villages = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = " SELECT vcode, vname " + " FROM rws_village_tbl " + " where dcode=? and mcode=? and pcode=? "
					+ " ORDER BY vname";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			ps.setString(3, pcode);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				villages.add(labelValueBean);
			}
		} catch (Exception e) {
		System.out.println("Exception in getVillages is "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
				
					System.out.println("Exception in getVillages is "+e);
				}
			}
		}
		return villages;
	}

	public ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode) throws Exception {
		ArrayList habs = new ArrayList();

		String query = "";
		try {
			conn = RwsOffices.getConn();
			Statement stmt1 = conn.createStatement();
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)='" + dcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,6,2)='" + mcode + "' AND " + "SUBSTR(RAJ.HAB_CODE,13,2)='" + pcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,8,3)='" + vcode
					+ "' AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return habs;
	}


	public ArrayList getChlorideDetails(SMSBased_WQ_Schemes_Drought_Form form) {
		ArrayList chlorides = new ArrayList();
		ArrayList sources = new ArrayList();

		String query = "", query1 = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null, rs2 = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);
			query = "select nvl(SOURCE_CODE,'--') as SOURCE_CODE,nvl(ASSET_CODE,'--') as ASSET_CODE,"
					+ "to_char(TEST_DATE,'dd/mm/yyyy') as TEST_DATE,PPM_VALUE,SMS_MOBILE,"
					+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH') as SERVICE_REQUEST,HABITATION_CODE,"
					+ "nvl(a.LOCATION,'--') as LOCATION,nvl(b.LOCATION,'--') as MSG_LOCATION,Panch_name,MESG_ID,"
					+ "DATA_COLLECTOR_NAME,decode(MODE_OF_CAPTURE,'M','MobileApp','S','SMS') as MODE_OF_CAPTURE,"
					+ "nvl(LOC_LON,'0') as LOC_LON,nvl(LOC_LAT,'0') as LOC_LAT from rws_mobile_sms_register_tbl a,"
					+ "RWS_RESIDUAL_CHLORINE_SMS_TBL b,rws_panchayat_raj_tbl c  where SMS_MOBILE=MOBILE and "
					+ "a.habitation_code=c.panch_code and substr(HABITATION_CODE,1,2)=? AND "
					+ " substr(HABITATION_CODE,6,2)=?  and PPM_VALUE<0.2 and "
					+ "(ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') ";

			if (form.getPanchayat() != null && !form.getPanchayat().equals("")) {

				query += " and substr(HABITATION_CODE,13,2)=? ";

			}
			query += " order by to_date(TEST_DATE,'dd/mm/yyyy')";
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, form.getDistrict());
			preparedStatement.setString(2, form.getMandal());
			if (form.getPanchayat() != null && !form.getPanchayat().equals("")) {
				preparedStatement.setString(3, form.getPanchayat());
			}
			rset = preparedStatement.executeQuery();
			while (rset.next()) {

				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setAssetCode(rset.getString("ASSET_CODE"));
				residualChlorineForm.setSourceCode(rset.getString("SOURCE_CODE"));
				residualChlorineForm.setTestDate(rset.getString("TEST_DATE"));
				residualChlorineForm.setPpmValue(rset.getString("PPM_VALUE"));
				residualChlorineForm.setSmsMobile(rset.getString("SMS_MOBILE"));
				residualChlorineForm.setServiceRequest(rset.getString("SERVICE_REQUEST"));
				residualChlorineForm.setDateEntered(cDate);
				residualChlorineForm.setLocation(rset.getString("LOCATION"));
				if (!rset.getString("SOURCE_CODE").equals("--")) {
					residualChlorineForm.setHabitation(rset.getString("SOURCE_CODE").substring(0, 16));
					residualChlorineForm
							.setHabitationName(getHabitationName(rset.getString("SOURCE_CODE").substring(0, 16)));
				} else {
					residualChlorineForm.setHabitation(rset.getString("HABITATION_CODE"));
					residualChlorineForm
							.setHabitationName(rset.getString("Panch_name") + "/" + rset.getString("HABITATION_CODE"));
				}
				residualChlorineForm.setMesid(rset.getString("MESG_ID"));
				residualChlorineForm.setLocalpersonname(rset.getString("DATA_COLLECTOR_NAME"));
				if (!rset.getString("ASSET_CODE").equals("--"))
					residualChlorineForm.setAssetName(getAssetName(rset.getString("ASSET_CODE")));
				else
					residualChlorineForm.setAssetName("--");
				if (!rset.getString("ASSET_CODE").equals("--") && !rset.getString("SOURCE_CODE").equals("--"))
					residualChlorineForm
							.setSourceName(getSourceName(rset.getString("ASSET_CODE"), rset.getString("SOURCE_CODE")));
				else
					residualChlorineForm.setSourceName("--");
				residualChlorineForm.setModeOfCapture(rset.getString("MODE_OF_CAPTURE"));
				residualChlorineForm.setLocLat(rset.getString("LOC_LAT"));
				residualChlorineForm.setLocLong(rset.getString("LOC_LON"));
				if (rset.getString("MODE_OF_CAPTURE").equals("MobileApp")) {
					residualChlorineForm.setSelectSource(true);
				} else {
					residualChlorineForm.setMsgLocation(rset.getString("MSG_LOCATION"));
				}

				chlorides.add(residualChlorineForm);

			}
			preparedStatement.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getChlorideDetails-- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("exception in getChlorideDetails-- " + e);
				}
			}
		}
		return chlorides;
	}

	public ArrayList getSourcesDetails(SMSBased_WQ_Schemes_Drought_Form form) throws Exception {
		ArrayList sources = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select SOURCE_CODE,nvl(SOURCE_NAME,' '),ASSET_CODE from rws_source_tbl where substr(hab_code,1,2)='"
					+ form.getDistrict() + "' and substr(hab_code,6,2)='" + form.getMandal() + "' ";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return sources;
	}

	public ArrayList getassetDetails(SMSBased_WQ_Schemes_Drought_Form form) throws Exception {
		ArrayList sources = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select SOURCE_CODE,nvl(SOURCE_NAME,' '),ASSET_CODE from rws_source_tbl where substr(hab_code,1,2)='"
					+ form.getDistrict() + "' and substr(hab_code,6,2)='" + form.getMandal() + "' ";

			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return sources;
	}

	public String updateUserDetails(SMSBased_WQ_Schemes_Drought_Form form, String loggedUser) throws Exception {

		int recCount = 0;

		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		Statement stmt1 = null;
		ResultSet rs1 = null;
		String habCode = "";
		int smsid = 0;
		ArrayList sendsmsRC = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);
			conn.setAutoCommit(false);
			String query = "update RWS_RESIDUAL_CHLORINE_SMS_TBL set ASSET_CODE=?,SOURCE_CODE=?,"
					+ "ACTION_DATE=to_date(?,'dd/MM/yyyy'),POTABLE=?,REMARKS=?,ACTION_ENTERED_DATE=to_date(?,'dd/MM/yyyy'),"
					+ "ENTERED_BY=? where  SMS_MOBILE=? and MESG_ID=?";
			stmt = conn.prepareStatement(query);
			for (int i = 0; i < form.getChlorides().size(); i++) {
				SMSBased_WQ_Schemes_Drought_Bean frm = form.getChlorides().get(i);
				if (frm.getChecks() != null && frm.getChecks().equals("on")) {

					stmt.setString(1, frm.getAssetCode());
					stmt.setString(2, frm.getSourceCode());
					stmt.setString(3, frm.getDateOfAction());
					stmt.setString(4, frm.getActionTaken());
					stmt.setString(5, frm.getRemarks());
					stmt.setString(6, cDate);
					stmt.setString(7, loggedUser);
					stmt.setString(8, frm.getSmsMobile());
					stmt.setString(9, frm.getMesid());
					stmt.addBatch();
					recCount++;
					if (frm.getActionTaken().equals("Y")) {
						sendsmsRC.add(frm.getMesid() + "," + frm.getSmsMobile() + "," + frm.getDateOfAction() + ","
								+ frm.getHabitation());
					}
				}
			}
			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				message = "Records Updated Successfully";
				conn.commit();
				conn.setAutoCommit(true);

				if (sendsmsRC.size() > 0) {
					sendsmsresidualChlorine(sendsmsRC, conn);
				}
			} else {
				conn.rollback();
				message = "Updation Failed";
			}
		} catch (Exception e) {
			System.out.println("exception in updateUserDetails-- " + e);

		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in updateUserDetails-- " + e);
				}
			}
		}
		return message;
	}

	public void sendsmsresidualChlorine(ArrayList sendsmsRC, Connection conn) {
		Statement stmt1 = null, stmt2 = null;
		ResultSet rs1 = null;

		try {
			Iterator smsRC = sendsmsRC.iterator();
			String smsrcdetails = "";
			while (smsRC.hasNext()) {
				smsrcdetails = smsRC.next().toString();
				String[] ar = smsrcdetails.split(",");
				String mesid = ar[0];
				String mobileno = ar[1];
				String actionDate = ar[2];
				String habcode = ar[3];
				String sourceName = "", assetName = "";
				stmt1 = conn.createStatement();
				query = "select habitation_code,panch_name,a.Location,ASSET_CODE,SOURCE_CODE from RWS_MOBILE_SMS_REGISTER_TBL a,"
						+ "rws_panchayat_raj_tbl b,RWS_RESIDUAL_CHLORINE_SMS_TBL c where a.habitation_code=b.panch_code and "
						+ "mobile=sms_mobile and a.mobile='" + mobileno + "' and MESG_ID='" + mesid + "' ";
				rs1 = stmt1.executeQuery(query);
				if (rs1.next()) {
					sourceName = getSourceName(rs1.getString("ASSET_CODE"), rs1.getString("SOURCE_CODE"));
					assetName = getAssetName(rs1.getString("ASSET_CODE"));
					Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
					List<String> alertNumbers = numbers.getPhoneNumbers1(rs1.getString(1));
					String resultAlert = "Scheme  rectified in " + rs1.getString(2) + "  at " + rs1.getString(3)
							+ "  on " + actionDate + "   ";

					for (String mobileNumbers : alertNumbers) {

						NicSmsGateway sms = new NicSmsGateway();
						String result = sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);

						if (result.equals("Deliverd")) {
							stmt2 = conn.createStatement();
							String inoutqry = "insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,habitation_code) values('"
									+ mobileNumbers + "',SYSDATE,'PUSH','RC','" + resultAlert + "','" + habcode + "')";
							stmt2.executeUpdate(inoutqry);

						}

					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	
	}

	public ArrayList getChlorideDetailsAll(SMSBased_WQ_Schemes_Drought_Form form) {
		ArrayList chlorides = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();

			query = "select nvl(SOURCE_CODE,'--') as SOURCE_CODE,nvl(ASSET_CODE,'--') as ASSET_CODE,"
					+ "to_char(TEST_DATE,'dd/mm/yyyy') as TEST_DATE,PPM_VALUE,SMS_MOBILE,"
					+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH') as SERVICE_REQUEST,"
					+ "to_char(ACTION_DATE,'dd/mm/yyyy') as ACTION_DATE,decode(POTABLE,'Y','Yes','N','No') as POTABLE,"
					+ "REMARKS,to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy') as ACTION_ENTERED_DATE,ENTERED_BY,"
					+ "nvl(a.LOCATION,'--') as LOCATION,nvl(b.LOCATION,'--') as MSG_LOCATION,MESG_ID,nvl(LOC_LON,'0') as LOC_LON,"
					+ "nvl(LOC_LAT,'0') as LOC_LAT,decode(MODE_OF_CAPTURE,'M','MobileApp','S','SMS') as MODE_OF_CAPTURE,"
					+ "Panch_name,HABITATION_CODE  from rws_mobile_sms_register_tbl a,RWS_RESIDUAL_CHLORINE_SMS_TBL b,"
					+ "rws_panchayat_raj_tbl c where SMS_MOBILE=MOBILE and a.habitation_code=c.panch_code and "
					+ "substr(HABITATION_CODE,1,2)=?  and substr(habitation_code,6,2)=? and PPM_VALUE<0.2  and "
					+ " (ACTION_ENTERED_DATE is not  null or ACTION_ENTERED_DATE<>'') ";

			if (form.getPanchayat() != null && !form.getPanchayat().equals("")) {

				query += " and substr(HABITATION_CODE,13,2)=? ";

			}

			query += " order by to_date(TEST_DATE,'dd/mm/yyyy')";

			preparedStatement = conn.prepareStatement(query);

			preparedStatement.setString(1, form.getDistrict());
			preparedStatement.setString(2, form.getMandal());

			if (form.getPanchayat() != null && !form.getPanchayat().equals("")) {

				preparedStatement.setString(3, form.getPanchayat());
			}

			rset = preparedStatement.executeQuery();

			while (rset.next()) {

				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setAssetCode(rset.getString("ASSET_CODE"));
				residualChlorineForm.setSourceCode(rset.getString("SOURCE_CODE"));
				residualChlorineForm.setTestDate(rset.getString("TEST_DATE"));
				residualChlorineForm.setPpmValue(rset.getString("PPM_VALUE"));
				residualChlorineForm.setSmsMobile(rset.getString("SMS_MOBILE"));
				residualChlorineForm.setServiceRequest(rset.getString("SERVICE_REQUEST"));
				residualChlorineForm.setLocation(rset.getString("LOCATION"));
				if (!rset.getString("SOURCE_CODE").equals("--")) {
					residualChlorineForm.setHabitation(rset.getString("SOURCE_CODE").substring(0, 16));
					residualChlorineForm
							.setHabitationName(getHabitationName(rset.getString("SOURCE_CODE").substring(0, 16)));
				} else {
					residualChlorineForm.setHabitation(rset.getString("HABITATION_CODE"));
					residualChlorineForm
							.setHabitationName(rset.getString("Panch_name") + "/" + rset.getString("HABITATION_CODE"));
				}
				residualChlorineForm.setMesid(rset.getString("MESG_ID"));
				if (!rset.getString("ASSET_CODE").equals("--"))
					residualChlorineForm.setAssetName(getAssetName(rset.getString("ASSET_CODE")));
				else
					residualChlorineForm.setAssetName("--");
				if (!rset.getString("ASSET_CODE").equals("--") && !rset.getString("SOURCE_CODE").equals("--"))
					residualChlorineForm
							.setSourceName(getSourceName(rset.getString("ASSET_CODE"), rset.getString("SOURCE_CODE")));
				else
					residualChlorineForm.setSourceName("--");
				residualChlorineForm.setModeOfCapture(rset.getString("MODE_OF_CAPTURE"));
				residualChlorineForm.setLocLat(rset.getString("LOC_LAT"));
				residualChlorineForm.setLocLong(rset.getString("LOC_LON"));
				if (rset.getString("MODE_OF_CAPTURE").equals("MobileApp")) {
					residualChlorineForm.setSelectSource(true);
				} else {
					residualChlorineForm.setMsgLocation(rset.getString("MSG_LOCATION"));
				}
				residualChlorineForm.setDateOfAction(rset.getString("ACTION_DATE"));
				residualChlorineForm.setActionTaken(rset.getString("POTABLE"));
				residualChlorineForm.setRemarks(rset.getString("REMARKS"));
				residualChlorineForm.setDateEntered(rset.getString("ACTION_ENTERED_DATE"));
				residualChlorineForm.setEnteredBy(rset.getString("ENTERED_BY"));
				chlorides.add(residualChlorineForm);
			}
			preparedStatement.close();
			rset.close();
		} catch (Exception e) {
		System.out.println("Exception in getChlorideDetailsAll of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getChlorideDetailsAll of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
				}
			}
		}
		return chlorides;
	}

	public ArrayList getAllSourcesDetails(SMSBased_WQ_Schemes_Drought_Form form) throws Exception {
		ArrayList sources = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select a.SOURCE_CODE,b.ASSET_CODE,b.ASSET_NAME from rws_source_tbl a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();

			query = "select a.HP_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_HP_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and substr(a.hp_code,1,16)=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.SHALLOWHP_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_SHALLOWHANDPUMPS_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.OPENWELL_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_OPEN_WELL_MAST_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.HABITATION_CODE=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.POND_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_OPENWELL_POND_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.PUMP_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.OHSR_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.OHBR_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_OHBR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.GLSR_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.GLBR_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_GLBR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.CISSC_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_CIS_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.RW_COLLWELL_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_RW_COLLWELL_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.CW_COLLWELL_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_CW_COLLWELL_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.SSSC_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_SS_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.WTPSC_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_WTP_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.SUMPCODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_SUMP_M_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.DISTRISC_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_DISTRI_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.BPT_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_BPT_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.BRIDGE_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_FP_BRIDGE_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.PUMPHOUSE_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_PUMPHOUSE_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.WATCHMAN_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_WATCHMAN_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.OTHER_COMP_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_OTHERS_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.OANDMCODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_oandm_param_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and substr(a.OANDMCODE,1,16)=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.PUMPINGMAIN_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_PUMPINGMAIN_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.GRAVITYMAIN_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_GRAVITYMAIN_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();
			query = "select a.CL_CODE,b.ASSET_CODE,b.ASSET_NAME from RWS_AST_CHLORINATION_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1) + " - " + rset.getString(2) + " - " + rset.getString(3));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				sources.add(labelValueBean);
			}
			ps.close();
			rset.close();

		} catch (Exception e) {
			System.out.println("Exception in getAllSourcesDetails of SMSBased_WQ_Schemes_Drought_DAO--"+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getAllSourcesDetails of SMSBased_WQ_Schemes_Drought_DAO--"+e);
				}
			}
		}

		return sources;
	}

	public ArrayList getSchemeDetails(SMSBased_WQ_Schemes_Drought_Form form) {
		ArrayList schemes = new ArrayList();
		ArrayList sources = new ArrayList();
		String query = "", query1 = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null, rs2 = null;
		PreparedStatement preparedStatement = null, ps2 = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "select to_char(SMS_DATE,'dd/mm/yyyy'),STATUS,SMS_MOBILE,decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),"
					+ "HABITATION_CODE,LOCATION,panch_name,MESG_ID,DATA_COLLECTOR_NAME   from rws_mobile_sms_register_tbl a,"
					+ "RWS_SCHEME_STATUS_SMS_TBL b,rws_panchayat_raj_tbl c where a.habitation_code=c.panch_code and  "
					+ "MOBILE=SMS_MOBILE and substr(HABITATION_CODE,1,2)=? and substr(HABITATION_CODE,6,2)=?"
					+ " and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE ='')   order by to_char(SMS_DATE,'dd/mm/yyyy') ";

			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());

			rset = ps.executeQuery();
			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setSmsDate(rset.getString(1));
				residualChlorineForm.setSchemeStatus(rset.getString(2));
				residualChlorineForm.setSmsMobile(rset.getString(3));
				residualChlorineForm.setServiceRequest(rset.getString(4));
				residualChlorineForm.setDateEntered(cDate);
				residualChlorineForm.setHabitationName(rset.getString(7));
				residualChlorineForm.setLocation(rset.getString(6));
				residualChlorineForm.setMesid(rset.getString(8));
				residualChlorineForm.setLocalpersonname(rset.getString(9));
				residualChlorineForm.setHabitation(rset.getString(5));
				schemes.add(residualChlorineForm);

			}

			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getSchemeDetails-- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("exception in getSchemeDetails-- " + e);
				}
			}
		}
		return schemes;
	}

	public String updateSchemesDetails(SMSBased_WQ_Schemes_Drought_Form form, String loggedUser) throws Exception {
		String Query = "", insertQry = "";
		int recCount = 0, rs1 = 0, rs2 = 0;
		int flag1 = 0, flag2 = 0, flag3 = 0;
		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null, ps = null, ps1 = null;
		ArrayList sendsmsDF = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);
			conn.setAutoCommit(false);
			String query = "update RWS_SCHEME_STATUS_SMS_TBL set COMPONENT_CODE=?,ACTION_DATE=to_date(?,'dd/MM/yyyy'),"
					+ "UPDATED_STATUS=?,REMARKS=?,ACTION_ENTERED_DATE=to_date(?,'dd/MM/yyyy'),ASSET_CODE=? where "
					+ "MESG_ID=? ";
			stmt = conn.prepareStatement(query);
			for (int i = 0; i < form.getSchemes().size(); i++) {
				SMSBased_WQ_Schemes_Drought_Bean frm = form.getSchemes().get(i);
				if (frm.getChecks() != null && frm.getChecks().equals("on")) {
					stmt.setString(1, frm.getSourceCode());
					stmt.setString(2, frm.getDateOfAction());
					stmt.setString(3, frm.getActionTaken());
					stmt.setString(4, frm.getRemarks());
					stmt.setString(5, cDate);
					stmt.setString(7, frm.getMesid());
					stmt.setString(6, frm.getAssetCode());
					stmt.addBatch();
					if (frm.getSourceCode().substring(19, 21).equals("HP")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select HP_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from "
								+ "RWS_HP_SUBCOMP_PARAM_TBL where HP_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_HP_SUBCOMP_PARAM_TBL  set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where HP_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("SO")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select SOURCE_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from"
								+ " rws_source_tbl where SOURCE_CODE=? and REPAIR_COST is not null)";
						Query = "update rws_source_tbl  set REPAIR_CODE=?,REPAIR_COST=?,REPAIR_DATE =to_date(?,'dd/mm/yyyy') where "
								+ "SOURCE_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("PS")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select PUMP_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from "
								+ "RWS_AST_SUBCOMP_PARAM_TBL where PUMP_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_SUBCOMP_PARAM_TBL  set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where PUMP_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("OS")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select OHSR_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from "
								+ "RWS_AST_OHSR_SC_PARAM_TBL where OHSR_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_OHSR_SC_PARAM_TBL  set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where OHSR_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("OB")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select OHBR_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from"
								+ " RWS_AST_OHBR_SC_PARAM_TBL where OHBR_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_OHBR_SC_PARAM_TBL  set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where OHBR_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("GL")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select GLSR_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from"
								+ " RWS_AST_GLSR_SC_PARAM_TBL where GLSR_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_GLSR_SC_PARAM_TBL  set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where GLSR_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("GB")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select GLBR_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from "
								+ "RWS_AST_GLBR_SC_PARAM_TBL where GLBR_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_GLBR_SC_PARAM_TBL set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where GLBR_CODE=?";
					} else if (frm.getSourceCode().substring(19, 21).equals("CT")) {
						insertQry = "insert into rws_asset_repair_type_his_tbl(SOURCE_CODE,REPAIR_CODE,REPAIR_DATE,REPAIR_COST)"
								+ "(select CISSC_CODE,REPAIR_CODE,to_date(REPAIR_DATE,'dd/mm/yyyy') as REPAIR_DATE,REPAIR_COST from "
								+ "RWS_AST_CIS_SC_PARAM_TBL where CISSC_CODE=? and REPAIR_COST is not null)";
						Query = "update RWS_AST_CIS_SC_PARAM_TBL set REPAIR_CODE=?,REPAIR_COST=?,"
								+ "REPAIR_DATE =to_date(?,'dd/mm/yyyy') where CISSC_CODE=?";
					} 
					ps1 = conn.prepareStatement(insertQry);
					ps1.setString(1, frm.getSourceCode());
					rs1 = ps1.executeUpdate();
					if (rs1 == 1)
						flag1++;
					ps = conn.prepareStatement(Query);
					ps.setString(1, frm.getRepCode());
					ps.setString(2, frm.getRepCost());
					ps.setString(3, frm.getDateOfAction());
					ps.setString(4, frm.getSourceCode());
					rs2 = ps.executeUpdate();
					if (rs2 == 1)
						flag2++;
					if (frm.getActionTaken().equals("Y")) {
						sendsmsDF.add(frm.getSmsMobile() + "," + frm.getMesid() + "," + frm.getDateOfAction() + ","
								+ frm.getHabitation());
					}
					recCount++;
				}
			}
			int res[] = stmt.executeBatch();
			if (res.length == recCount && flag2 == recCount) {
				message = "Records Updated Successfully";
				conn.commit();
				conn.setAutoCommit(true);
				if (sendsmsDF.size() > 0) {
					sendsmsdefunctScheme(sendsmsDF, conn);
				}

			} else {
				conn.rollback();
				message = "Updation Failed";
			}
		} catch (Exception e) {
			System.out.println("Exception in update schemes of dao" + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in update schemes of dao" + e);
				}
			}
		}
		return message;
	}

	public void sendsmsdefunctScheme(ArrayList sendsmsDF, Connection conn) {
		Statement stmt1 = null, stmt2 = null;
		ResultSet rs1 = null;

		try {
			Iterator smsDF = sendsmsDF.iterator();
			String smsdfdetails = "";
			while (smsDF.hasNext()) {
				smsdfdetails = smsDF.next().toString();
				String[] ar = smsdfdetails.split(",");

				String mobileno = ar[0];
				String mesid = ar[1];
				String actionDate = ar[2];
				String habcode = ar[3];

				stmt1 = conn.createStatement();
				query = "select habitation_code,panch_name,a.Location from RWS_MOBILE_SMS_REGISTER_TBL a,rws_panchayat_raj_tbl b,"
						+ "RWS_SCHEME_STATUS_SMS_TBL  c where a.habitation_code=b.panch_code and a.mobile=c.sms_mobile and a.mobile='"
						+ mobileno + "' and MESG_ID='" + mesid + "' ";
				rs1 = stmt1.executeQuery(query);
				if (rs1.next()) {

					Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
					List<String> alertNumbers = numbers.getPhoneNumbers1(rs1.getString(1));
					String resultAlert = "Scheme  rectified in " + rs1.getString(2) + "  at " + rs1.getString(3)
							+ "  on " + actionDate + "   ";
					for (String mobileNumbers : alertNumbers) {

						NicSmsGateway sms = new NicSmsGateway();
						sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);

						String result = sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);

						if (result.equals("Deliverd")) {
							stmt2 = conn.createStatement();
							String inoutqry = "insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,habitation_code) values('"
									+ mobileNumbers + "',SYSDATE,'PUSH','DF','" + resultAlert + "','" + habcode + "')";
							stmt2.executeUpdate(inoutqry);

						}

					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public ArrayList getSchemeDetailsAll(SMSBased_WQ_Schemes_Drought_Form form) {
		ArrayList schemes = new ArrayList();
		ArrayList sources = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();

			query = "select b.ASSET_CODE,to_char(SMS_DATE,'dd/mm/yyyy'),STATUS,SMS_MOBILE,"
					+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),to_char(ACTION_DATE,'dd/mm/yyyy'),"
					+ "UPDATED_STATUS,b.REMARKS,to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),Habitation_code,panch_name,"
					+ "DATA_COLLECTOR_NAME,MESG_ID,b.COMPONENT_CODE   from rws_mobile_sms_register_tbl a,"
					+ "RWS_SCHEME_STATUS_SMS_TBL b,rws_panchayat_raj_tbl c where a.habitation_code=c.panch_code and  "
					+ "MOBILE=SMS_MOBILE  and substr(HABITATION_CODE,1,2)=?  and substr(HABITATION_CODE,6,2)=?"
					+ " and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'') ";

			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());
			rset = ps.executeQuery();
			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setAssetCode(rset.getString(1));
				residualChlorineForm.setSmsDate(rset.getString(2));
				residualChlorineForm.setSchemeStatus(rset.getString(3));
				residualChlorineForm.setSmsMobile(rset.getString(4));
				residualChlorineForm.setServiceRequest(rset.getString(5));
				residualChlorineForm.setDateOfAction(rset.getString(6));
				residualChlorineForm.setActionTaken(rset.getString(7));
				residualChlorineForm.setRemarks(rset.getString(8));
				residualChlorineForm.setDateEntered(rset.getString(9));
				residualChlorineForm.setHabitation(rset.getString(10));
				residualChlorineForm.setHabitationName(rset.getString(11));
				residualChlorineForm.setLocalpersonname(rset.getString(12));
				residualChlorineForm.setMesid(rset.getString(13));
				residualChlorineForm.setSourceCode(rset.getString("COMPONENT_CODE"));
				schemes.add(residualChlorineForm);
			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("Exception in getSchemeDetailsAll schemes " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getSchemeDetailsAll schemes " + e);
				}
			}
		}
		return schemes;
	}

	public ArrayList getSchemeDetailsEdit(SMSBased_WQ_Schemes_Drought_Form form, String mobile, String mesid) {
		ArrayList schemes = new ArrayList();
		ArrayList sources = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "select panch_name,DATA_COLLECTOR_NAME,b.ASSET_CODE,asset_name,a.location,STATUS ,UPDATED_STATUS,to_char(ACTION_DATE,'dd/mm/yyyy'),to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),b.REMARKS  from rws_mobile_sms_register_tbl a,RWS_SCHEME_STATUS_SMS_TBL b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where a.mobile=b.sms_mobile and a.habitation_code=c.panch_code and b.asset_code=d.asset_code and sms_mobile='"
					+ mobile + "' and MESG_ID='" + mesid + "' ";


			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();

				residualChlorineForm.setHabitationName(rset.getString(1));
				residualChlorineForm.setLocalpersonname(rset.getString(2));
				residualChlorineForm.setAssetCode(rset.getString(3));
				residualChlorineForm.setAssetName(rset.getString(4));
				residualChlorineForm.setLocation(rset.getString(5));
				residualChlorineForm.setSchemeStatus(rset.getString(6));
				residualChlorineForm.setActionTaken(rset.getString(7));
				residualChlorineForm.setDateOfAction(rset.getString(8));
				residualChlorineForm.setDateEntered(rset.getString(9));
				residualChlorineForm.setServiceRequest(rset.getString(10));
				residualChlorineForm.setRemarks(rset.getString(11));
				schemes.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("Exception in getSchemeDetailsEdit of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getSchemeDetailsEdit of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
				}
			}
		}
		return schemes;
	}

	public ArrayList getDroughtDetails(SMSBased_WQ_Schemes_Drought_Form form) {

		ArrayList drought = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "select b.HABITATION_CODE,to_char(SEND_DATE,'dd/mm/yyyy'),b.LOCATION,decode(TANKER_STATUS,'Y','Yes','N','No'),"
					+ "SMS_MOBILE,decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),a.habitation_code,panch_name,MESG_ID,"
					+ "DATA_COLLECTOR_NAME   from rws_mobile_sms_register_tbl a,RWS_DROUGHT_TANKER_SMS_TBL b,"
					+ "rws_panchayat_raj_tbl c where a.habitation_code=c.panch_code and  MOBILE=SMS_MOBILE and "
					+ "substr(a.HABITATION_CODE,1,2)=? and  substr(a.HABITATION_CODE,6,2)=?"
					+ " and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE ='' ) order by to_char(SEND_DATE,'dd/mm/yyyy') ";

			 
			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());

			rset = ps.executeQuery();

			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setDroughtHabCode(rset.getString(1));
				residualChlorineForm.setSmsDate(rset.getString(2));
				residualChlorineForm.setLocation(rset.getString(3));
				residualChlorineForm.setTankerStatus(rset.getString(4));
				residualChlorineForm.setSmsMobile(rset.getString(5));
				residualChlorineForm.setServiceRequest(rset.getString(6));
				residualChlorineForm.setDateEntered(cDate);
				residualChlorineForm.setHabitation(rset.getString(7));
				residualChlorineForm.setHabitationName(rset.getString(8));
				residualChlorineForm.setLocalpersonname(rset.getString(10));
				residualChlorineForm.setMesid(rset.getString(9));
				drought.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getDroughtDetails-- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in getDroughtDetails-- " + e);
				}
			}
		}
		return drought;
	}

	public String updateDroughtDetails(SMSBased_WQ_Schemes_Drought_Form form, String loggedUser) throws Exception {

		int recCount = 0;

		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		ArrayList sendsmsDR = new ArrayList();

		try {

			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			conn.setAutoCommit(false);
			String query = "update RWS_DROUGHT_TANKER_SMS_TBL set TANKER_SUPPLY_DATE=to_date(?,'dd/MM/yyyy'),"
					+ "REMARKS=?,TANKER_UPDATE_STATUS=?,ACTION_ENTERED_DATE=to_date(?,'dd/MM/yyyy'),ENTERED_BY=? where  "
					+ "SMS_MOBILE=?  and MESG_ID=?";
			stmt = conn.prepareStatement(query);

			for (int i = 0; i < form.getDrought().size(); i++) {

				SMSBased_WQ_Schemes_Drought_Bean frm = form.getDrought().get(i);

				if (frm.getChecks() != null && frm.getChecks().equals("on")) {

					stmt.setString(1, frm.getTankerSupplyDate());
					stmt.setString(2, frm.getRemarks());
					stmt.setString(3, frm.getTankerUpdateStatus());
					stmt.setString(4, cDate);
					stmt.setString(5, loggedUser);
					stmt.setString(6, frm.getSmsMobile());
					stmt.setString(7, frm.getMesid());

					stmt.addBatch();
					recCount++;
					if (frm.getTankerUpdateStatus().equals("Y")) {
						sendsmsDR.add(frm.getSmsMobile() + "," + frm.getMesid() + "," + frm.getDateEntered() + ","
								+ frm.getHabitation());
					}

				}

			}
			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				message = "Records Updated Successfully";
				conn.commit();
				conn.setAutoCommit(true);

				if (sendsmsDR.size() > 0) {
					sendsmstankerStatus(sendsmsDR, conn);
				}

			} else {
				conn.rollback();
				message = "Updation Failed";
			}
		}

		catch (Exception e) {
			System.out.println("Exception in updateDroughtDetails of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in updateDroughtDetails of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
				}
			}
		}
		return message;
	}

	public void sendsmstankerStatus(ArrayList sendsmsDR, Connection conn) {
		Statement stmt1 = null, stmt2 = null;
		ResultSet rs1 = null;

		try {
			Iterator smsDF = sendsmsDR.iterator();
			String smsdfdetails = "";
			while (smsDF.hasNext()) {
				smsdfdetails = smsDF.next().toString();
				String[] ar = smsdfdetails.split(",");

				String mobileno = ar[0];
				String mesid = ar[1];
				String actionDate = ar[2];
				String habcode = ar[3];

				stmt1 = conn.createStatement();
				query = "select a.habitation_code,panch_name,c.Location from RWS_MOBILE_SMS_REGISTER_TBL a,rws_panchayat_raj_tbl b,RWS_DROUGHT_TANKER_SMS_TBL  c where a.habitation_code=b.panch_code and a.mobile=c.sms_mobile and a.mobile='"
						+ mobileno + "' and MESG_ID='" + mesid + "' ";
				rs1 = stmt1.executeQuery(query);
				if (rs1.next()) {

					Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
					List<String> alertNumbers = numbers.getPhoneNumbers1(rs1.getString(1));
					String resultAlert = "Tanker sent to  " + rs1.getString(2) + "  at " + rs1.getString(3) + "  on "
							+ actionDate + "   ";
					for (String mobileNumbers : alertNumbers) {

						NicSmsGateway sms = new NicSmsGateway();

						String result = sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);

						if (result.equals("Deliverd")) {
							stmt2 = conn.createStatement();
							String inoutqry = "insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,habitation_code) values('"
									+ mobileNumbers + "',SYSDATE,'PUSH','DR','" + resultAlert + "','" + habcode + "')";
							stmt2.executeUpdate(inoutqry);

						}

					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public ArrayList getDroughtDetailsView(SMSBased_WQ_Schemes_Drought_Form form) {

		ArrayList drought = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "select a.HABITATION_CODE,to_char(SEND_DATE,'dd/mm/yyyy'),b.LOCATION,decode(TANKER_STATUS,'Y','Yes','N','No'),"
					+ "SMS_MOBILE,decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),to_char(TANKER_SUPPLY_DATE,'dd/mm/yyyy'),"
					+ "nvl(REMARKS,'-'),decode(TANKER_UPDATE_STATUS,'Y','Yes','N','No'),to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),"
					+ "ENTERED_BY,c.panch_name,DATA_COLLECTOR_NAME,MESG_ID  from rws_mobile_sms_register_tbl a,"
					+ "RWS_DROUGHT_TANKER_SMS_TBL b,rws_panchayat_raj_tbl c where  a.habitation_code=c.panch_code and "
					+ "MOBILE=SMS_MOBILE and substr(a.HABITATION_CODE,1,2)=? and  substr(a.HABITATION_CODE,6,2)=? "
					+ "and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <>'') ";


			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());

			rset = ps.executeQuery();

			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setDroughtHabCode(rset.getString(1));
				residualChlorineForm.setSmsDate(rset.getString(2));
				residualChlorineForm.setLocation(rset.getString(3));
				residualChlorineForm.setTankerStatus(rset.getString(4));
				residualChlorineForm.setSmsMobile(rset.getString(5));
				residualChlorineForm.setServiceRequest(rset.getString(6));
				residualChlorineForm.setTankerSupplyDate(rset.getString(7));
				residualChlorineForm.setRemarks(rset.getString(8));
				residualChlorineForm.setTankerUpdateStatus(rset.getString(9));
				residualChlorineForm.setDateEntered(rset.getString(10));
				residualChlorineForm.setEnteredBy(rset.getString(11));
				residualChlorineForm.setPanchayat(rset.getString(12));
				residualChlorineForm.setLocalpersonname(rset.getString(13));
				residualChlorineForm.setMesid(rset.getString(14));

				drought.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("Exception in getDroughtDetailsView of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getDroughtDetailsView of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
				}
			}
		}
		return drought;
	}

	public ArrayList getDroughtDetailsEdit(SMSBased_WQ_Schemes_Drought_Form form) {

		ArrayList drought = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();

			query = "select b.HABITATION_CODE,to_char(SEND_DATE,'dd/mm/yyyy'),b.LOCATION,decode(TANKER_STATUS,'Y','Yes','N','No'),"
					+ "SMS_MOBILE,decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),to_char(TANKER_SUPPLY_DATE,'dd/mm/yyyy'),"
					+ "nvl(REMARKS,'-'),TANKER_UPDATE_STATUS,to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),ENTERED_BY from"
					+ " rws_mobile_sms_register_tbl a,RWS_DROUGHT_TANKER_SMS_TBL b where MOBILE=SMS_MOBILE and"
					+ " b.HABITATION_CODE=?  and (ENTERED_BY is not null or ENTERED_BY <> '') ";


			ps = conn.prepareStatement(query);
			ps.setString(1, form.getHabitation());

			rset = ps.executeQuery();

			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setDroughtHabCode(rset.getString(1));
				residualChlorineForm.setSmsDate(rset.getString(2));
				residualChlorineForm.setLocation(rset.getString(3));
				residualChlorineForm.setTankerStatus(rset.getString(4));
				residualChlorineForm.setSmsMobile(rset.getString(5));
				residualChlorineForm.setServiceRequest(rset.getString(6));
				residualChlorineForm.setTankerSupplyDate(rset.getString(7));
				residualChlorineForm.setRemarks(rset.getString(8));
				residualChlorineForm.setTankerUpdateStatus(rset.getString(9));
				residualChlorineForm.setDateEntered(rset.getString(10));
				residualChlorineForm.setEnteredBy(rset.getString(11));

				drought.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("excepion in getDroughtDetailsEdit- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("excepion in getDroughtDetailsEdit- " + e);
				}
			}
		}
		return drought;
	}


	public ArrayList getohsrDetails(SMSBased_WQ_Schemes_Drought_Form form) {
		ArrayList ohsr = new ArrayList();
		String query = "", query1 = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null, rs2 = null;
		PreparedStatement preparedStatement = null, ps2 = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "select to_char(Test_DATE,'dd/mm/yyyy'),b.LOCATION,decode(GLSR_OHSR_CLEAN_STATUS,'Y','Yes','N','No'),"
					+ "SMS_MOBILE,a.habitation_code,panch_name,MESG_ID,DATA_COLLECTOR_NAME,"
					+ "decode(GLSR_OHSR,'O','OHSR','G','GLSR'),to_char(ACTION_DATE,'dd/mm/yyyy')    from rws_mobile_sms_register_tbl a,"
					+ "RWS_OHSR_GLSR_SMS_TBL b,rws_panchayat_raj_tbl c where a.habitation_code=c.panch_code and  MOBILE=SMS_MOBILE "
					+ "and substr(a.HABITATION_CODE,1,2)=? and  substr(a.HABITATION_CODE,6,2)=?"
					+ " and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE ='' ) order by to_char(Test_DATE,'dd/mm/yyyy')";

			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());
			rset = ps.executeQuery();

			while (rset.next()) {

				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();

				query1 = "select asset_code,asset_name from rws_asset_mast_tbl where  hab_code='" + rset.getString(5)
						+ "' and substr(asset_code,7,2) in('01','02','03')";
				ps2 = conn.prepareStatement(query1);
				rs2 = ps2.executeQuery();
				if (rs2.next()) {
					residualChlorineForm.setAssetCode(rs2.getString(1));
					residualChlorineForm.setAssetName(rs2.getString(2));
				}

				residualChlorineForm.setSmsDate(rset.getString(1));
				residualChlorineForm.setLocation(rset.getString(2));
				residualChlorineForm.setStatus(rset.getString(3));
				residualChlorineForm.setSmsMobile(rset.getString(4));
				residualChlorineForm.setHabitation(rset.getString(5));
				residualChlorineForm.setHabitationName(rset.getString(6));
				residualChlorineForm.setMesid(rset.getString(7));
				residualChlorineForm.setLocalpersonname(rset.getString(8));
				residualChlorineForm.setType(rset.getString(9));
				residualChlorineForm.setActionTaken(rset.getString(10));

				ohsr.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getohsrDetails-- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("exception in getohsrDetails-- " + e);
				}
			}
		}
		return ohsr;
	}

	public String updateohsrDetails(SMSBased_WQ_Schemes_Drought_Form form, String loggedUser) throws Exception {
		int recCount = 0;

		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		ArrayList sendsmsOH = new ArrayList();

		try {
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String query = "update RWS_OHSR_GLSR_SMS_TBL  set ACTION_DATE=to_date(?,'dd/MM/yyyy'),REMARKS=?,"
					+ "ACTION_ENTERED_DATE=to_date(?,'dd/MM/yyyy'),ENTERED_BY=?,Asset_code=? where  SMS_MOBILE=?  and"
					+ " MESG_ID=?";
			stmt = conn.prepareStatement(query);
			for (int i = 0; i < form.getOhsr().size(); i++) {

				SMSBased_WQ_Schemes_Drought_Bean frm = form.getOhsr().get(i);

				if (frm.getChecks() != null && frm.getChecks().equals("on")) {

					stmt.setString(1, frm.getActionTaken());
					stmt.setString(2, frm.getRemarks());
					stmt.setString(3, cDate);
					stmt.setString(4, loggedUser);
					stmt.setString(5, frm.getAssetCode());
					stmt.setString(6, frm.getSmsMobile());
					stmt.setString(7, frm.getMesid());

					stmt.addBatch();
					recCount++;

					sendsmsOH.add(frm.getSmsMobile() + "," + frm.getMesid() + "," + frm.getActionTaken() + ","
							+ frm.getType() + "," + frm.getHabitation());


				}

			}
			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				message = "Records Updated Successfully";
				conn.commit();
				conn.setAutoCommit(true);

				sendsmsOHGLstatus(sendsmsOH, conn);

			} else {
				conn.rollback();
				message = "Updation Failed";
			}
		}

		catch (Exception e) {
			System.out.println("exception in updateohsrDetails-- " + e);

		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("exception in updateohsrDetails-- " + e);
				}
			}
		}
		return message;
	}

	public void sendsmsOHGLstatus(ArrayList sendsmsOH, Connection conn) {
		Statement stmt1 = null, stmt2 = null;
		ResultSet rs1 = null;
		String resultAlert = "";
		try {
			Iterator smsDF = sendsmsOH.iterator();
			String smsdfdetails = "";
			while (smsDF.hasNext()) {
				smsdfdetails = smsDF.next().toString();
				String[] ar = smsdfdetails.split(",");

				String mobileno = ar[0];
				String mesid = ar[1];
				String actionDate = ar[2];
				String type = ar[3];
				String habcode = ar[4];
				if (type.equals("OHSR")) {
					type = "OH";

				} else if (type.equals("GLSR")) {
					type = "GL";
				}

				stmt1 = conn.createStatement();
				query = "select a.habitation_code,panch_name,c.Location from RWS_MOBILE_SMS_REGISTER_TBL a,rws_panchayat_raj_tbl b,RWS_OHSR_GLSR_SMS_TBL  c where a.habitation_code=b.panch_code and a.mobile=c.sms_mobile and a.mobile='"
						+ mobileno + "' and MESG_ID='" + mesid + "' ";
				rs1 = stmt1.executeQuery(query);
				if (rs1.next()) {

					Rws_PhoneNumbersArray numbers = new Rws_PhoneNumbersArray();
					List<String> alertNumbers = numbers.getPhoneNumbers1(rs1.getString(1));
					if (type.equals("OH")) {
						resultAlert = "OHSR Attended at  " + rs1.getString(2) + "  in " + rs1.getString(3) + "  on "
								+ actionDate + "   ";
					} else if (type.equals("GL")) {
						resultAlert = "GLSR Attended at  " + rs1.getString(2) + " in " + rs1.getString(3) + "  on "
								+ actionDate + "   ";
					}
					for (String mobileNumbers : alertNumbers) {

						NicSmsGateway sms = new NicSmsGateway();
						String result = sms.SMSSend("rwss.sms", "Wr$7vF4$bA", "NICSMS", mobileNumbers, resultAlert);

						if (result.equals("Deliverd")) {
							stmt2 = conn.createStatement();
							String inoutqry = "insert into RWS_SMS_IN_OUT_STATUS_TBL (MOBILE,SMS_DATE,SMS_TYPE,SMS_MODULE_AREA,SMS_DESC,habitation_code) values('"
									+ mobileNumbers + "',SYSDATE,'PUSH','" + type + "','" + resultAlert + "','"
									+ habcode + "')";
							stmt2.executeUpdate(inoutqry);

						}

					}
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public ArrayList getohsrView(SMSBased_WQ_Schemes_Drought_Form form) {

		ArrayList ohsr = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);

			query = "SELECT a.habitation_code,panch_name,to_char(TEST_DATE,'dd/mm/yyyy'),SMS_MOBILE ,c.location,"
					+ "decode(GLSR_OHSR_CLEAN_STATUS,'Y','YES','N','NO'),TO_CHAR(ACTION_DATE,'dd/mm/yyyy'),"
					+ "ENTERED_BY,ASSET_CODE,MESG_ID,DATA_COLLECTOR_NAME,REMARKS,decode(GLSR_OHSR,'O','OHSR','G','GLSR')  from "
					+ "rws_mobile_sms_register_tbl a,rws_panchayat_raj_tbl b,RWS_OHSR_GLSR_SMS_TBL c where a.habitation_code=b.panch_code  and"
					+ " a.Mobile=c.SMS_MOBILE  and substr(a.HABITATION_CODE,1,2)=?"
					+ " and  substr(a.HABITATION_CODE,6,2)=? and (ACTION_ENTERED_DATE <>'' or ACTION_ENTERED_DATE is not null) ";


			ps = conn.prepareStatement(query);
			ps.setString(1, form.getDistrict());
			ps.setString(2, form.getMandal());

			rset = ps.executeQuery();

			while (rset.next()) {
				SMSBased_WQ_Schemes_Drought_Bean residualChlorineForm = new SMSBased_WQ_Schemes_Drought_Bean();
				residualChlorineForm.setHabitation(rset.getString(1));
				residualChlorineForm.setHabitationName(rset.getString(2));
				residualChlorineForm.setTestDate(rset.getString(3));
				residualChlorineForm.setSmsMobile(rset.getString(4));
				residualChlorineForm.setLocation(rset.getString(5));
				residualChlorineForm.setStatus(rset.getString(6));
				residualChlorineForm.setActionTaken(rset.getString(7));
				residualChlorineForm.setEnteredBy(rset.getString(8));
				residualChlorineForm.setAssetCode(rset.getString(9));

				residualChlorineForm.setMesid(rset.getString(10));
				residualChlorineForm.setLocalpersonname(rset.getString(11));
				residualChlorineForm.setRemarks(rset.getString(12));
				residualChlorineForm.setType(rset.getString(13));

				ohsr.add(residualChlorineForm);

			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("Exception in getohsrView of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getohsrView of SMSBased_WQ_Schemes_Drought_DAO-- "+e);
				}
			}
		}
		return ohsr;
	}

	public ArrayList getAllComponents(String astcode) throws Exception {
		ArrayList sources = new ArrayList();
		try {

			SMSBased_WQ_Schemes_Drought_Form frm = null;
			conn = RwsOffices.getConn();
			if (astcode.substring(6, 8).equals("01") || astcode.substring(6, 8).equals("02")
					|| astcode.substring(6, 8).equals("03") || astcode.substring(6, 8).equals("09")) {
				query = "select a.SOURCE_CODE,nvl(a.location,'-') as location,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from rws_source_tbl a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);
				rset = ps.executeQuery();
				while (rset.next()) {

					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("SOURCE_CODE"));
					frm.setSourceName("SOURCES");
					frm.setLocation(rset.getString("location"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}

				ps.close();
				rset.close();

				query = "select a.PUMP_CODE,nvl(a.location,'-') as location,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("PUMP_CODE"));
					frm.setSourceName("PUMPING-PUMPSETS");
					frm.setLocation(rset.getString("location"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);

				}
				ps.close();
				rset.close();

				query = "select a.OHSR_CODE,nvl(a.OHSR_LOC,'-') as OHSR_LOC,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("OHSR_CODE"));
					frm.setSourceName("OHSR");
					frm.setLocation(rset.getString("OHSR_LOC"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();

				query = "select a.OHBR_CODE,nvl(a.OHBR_LOC,'-') as OHBR_LOC,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_OHBR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("OHBR_CODE"));
					frm.setSourceName("OHBR");
					frm.setLocation(rset.getString("OHBR_LOC"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();

				query = "select a.GLSR_CODE,nvl(a.GLSR_LOC,'-') as GLSR_LOC,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("GLSR_CODE"));
					frm.setSourceName("GLSR");
					frm.setLocation(rset.getString("GLSR_LOC"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();

				query = "select a.GLBR_CODE,nvl(a.GLBR_LOC,'-') as GLBR_LOC,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_GLBR_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("GLBR_CODE"));
					frm.setSourceName("GLBR");
					frm.setLocation(rset.getString("GLBR_LOC"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();

				query = "select a.CISSC_CODE,nvl(a.CIS_LOC,'-') as CIS_LOC,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_CIS_SC_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("CISSC_CODE"));
					frm.setSourceName("CISTERNS");
					frm.setLocation(rset.getString("CIS_LOC"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();

			

				query = "select a.OTHER_COMP_CODE,nvl(a.COMP_LOCATION,'-') as COMP_LOCATION,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_AST_OTHERS_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and a.hab_code=b.hab_code and b.hab_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);

				rset = ps.executeQuery();

				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("OTHER_COMP_CODE"));
					frm.setSourceName("OTHERS");
					frm.setLocation(rset.getString("COMP_LOCATION"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();
			
			} else if (astcode.substring(6, 8).equals("04")) {
				query = "select a.HP_CODE,nvl(a.location,'-') as location,nvl(decode(a.status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),'-') as status,decode(b.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING') as type_of_asset_code,nvl(a.LATITUDE,'0') as LATITUDE,nvl(a.LONGITUDE,'0') as LONGITUDE,nvl(b.ASSET_NAME,'-') as ASSET_NAME,b.ASSET_CODE from RWS_HP_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b where a.asset_code=b.asset_code and substr(a.hp_code,1,16)=b.hab_code and b.asset_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1, astcode);
				rset = ps.executeQuery();
				while (rset.next()) {
					frm = new SMSBased_WQ_Schemes_Drought_Form();
					frm.setAssetCode(rset.getString("ASSET_CODE"));
					frm.setAssetName(rset.getString("ASSET_NAME"));
					frm.setSourceCode(rset.getString("HP_CODE"));
					frm.setSourceName("HAND PUMP");
					frm.setLocation(rset.getString("location"));
					frm.setAstType(rset.getString("type_of_asset_code"));
					frm.setStatus(rset.getString("status"));
					frm.setLatitude(rset.getString("LATITUDE"));
					frm.setLongitude(rset.getString("LONGITUDE"));
					sources.add(frm);
				}
				ps.close();
				rset.close();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return sources;
	}

	public String getHabitationName(String hab_code) throws Exception {
		String hab_name = "";
		try {
			conn = RwsOffices.getConn();
			query = "select Panch_Name from Rws_Complete_Hab_View where Panch_Code='" + hab_code + "' ";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				hab_name = rset.getString("Panch_Name") + "/" + hab_code;
			}
		} catch (Exception e) {
			System.out.println("Exceptin in getHabitationName() in SMS BASED ACTION " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exceptin in getHabitationName() in SMS BASED ACTION " + e.getMessage());
				}
			}
		}
		return hab_name;
	}

	public String getAssetName(String asset_code) throws Exception {
		String asset_name = "";
		try {
			conn = RwsOffices.getConn();
			query = "select nvl(Asset_name,'--') as Asset_name from Rws_Asset_Mast_Tbl where asset_code='" + asset_code
					+ "' ";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				asset_name = rset.getString("Asset_name");
			}
		} catch (Exception e) {
			System.out.println("Exception in getAssetName() in SMS BASED ACTION " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getAssetName() in SMS BASED ACTION " + e.getMessage());
				}
			}
		}
		return asset_name;
	}

	public String getSourceName(String asset_code, String source_code) throws Exception {
		String source_name = "";
		try {
			conn = RwsOffices.getConn();
			if (source_code.substring(19, 21).equals("SO"))
				query = "select nvl(SOURCE_NAME,'Source') AS SOURCE_NAME,nvl(b.LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_SOURCE_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.SOURCE_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("OS"))
				query = "select 'OHSR' AS SOURCE_NAME,nvl(OHSR_LOC,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_OHSR_SC_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.OHSR_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("OB"))
				query = "select 'OHBR' AS SOURCE_NAME,nvl(OHBR_LOC,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_OHBR_SC_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.OHBR_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("GL"))
				query = "select 'GLSR' AS SOURCE_NAME,nvl(GLSR_LOC,'-')  as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_GLSR_SC_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.GLSR_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("GB"))
				query = "select 'GLBR' AS SOURCE_NAME,nvl(GLBR_LOC,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_GLBR_SC_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.GLBR_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("HP"))
				query = "select 'HANDPUMP' AS SOURCE_NAME,nvl(b.LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_HP_SUBCOMP_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.HP_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("SH"))
				query = "select 'SHP' AS SOURCE_NAME,nvl(b.LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_SHALLOWHANDPUMPS_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.SHALLOWHP_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("OW"))
				query = "select 'OPENWELL' AS SOURCE_NAME,nvl(b.LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_OPEN_WELL_MAST_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.OPENWELL_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("CT"))
				query = "select 'CISTERNS' AS SOURCE_NAME,nvl(CIS_LOC,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_CIS_SC_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.CISSC_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("OT"))
				query = "select 'OTHERS' AS SOURCE_NAME,nvl(COMP_LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_OTHERS_PARAM_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.OTHER_COMP_CODE='" + source_code + "'";
			else if (source_code.substring(19, 21).equals("SP"))
				query = "select 'STANDPOSTS' AS SOURCE_NAME,nvl(b.LOCATION,'-') as LOCATION from RWS_ASSET_MAST_TBL a,RWS_AST_STANDPOST_TBL b WHERE a.ASSET_CODE=b.ASSET_CODE and a.ASSET_CODE='"
						+ asset_code + "' and b.STANDPOST_CODE='" + source_code + "'";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				source_name = rset.getString("SOURCE_NAME") + " / " + rset.getString("LOCATION");
			}
		} catch (Exception e) {
			System.out.println("Exception in getSourceName() in SMS BASED ACTION " + e.getMessage());
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("Exception in getSourceName() in SMS BASED ACTION " + e.getMessage());
				}
			}
		}
		return source_name;
	}

}
