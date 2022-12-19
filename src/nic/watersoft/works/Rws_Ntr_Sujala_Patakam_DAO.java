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
import nic.watersoft.drought.DroughtBean;
import nic.watersoft.drought.DroughtHabitationRecords;
import nic.watersoft.drought.DroughtMasterData;
import nic.watersoft.masters.HabitationNewEntry_Form;
import nic.watersoft.masters.RwsHPRecord;

public class Rws_Ntr_Sujala_Patakam_DAO {

	Connection conn = null;
	Statement stmt = null;
	String query = "";
	PreparedStatement pstat = null;
	ResultSet rset = null;

	ResultSet rs = null;

	ResultSet rset1 = null;

	WorksData1 worksData = new WorksData1();

	public ArrayList getCircles() throws Exception {
		ArrayList circles;
		String query = "";

		LabelValueBean assetForm = null;
		circles = new ArrayList();
		PreparedStatement ps = null;

		try {

			conn = RwsOffices.getConn();

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
			Debug.println("Exception in getCircles in Rws_Ntr_Sujala_Patakam_DAO= =" + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (rs != null) {
				rs.close();
			}
		}
		return circles;
	}

	
	public ArrayList getSourceDetails(String habCode) {
		ArrayList sourceList;
		String query = "", query1 = "", query2 = "";
		String max_date = "";
		Rws_Ntr_Sujala_Patakam_Records ntrRecord = null;
		sourceList = new ArrayList();
		PreparedStatement st1 = null;
		ResultSet rs1 = null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Connection con1 = RwsOffices.getConn();
		try {

			Hashtable sourcetestdetails = getAllSources(habCode, con1);
			ArrayList sources = getAllSources1(habCode, con1);
			String habdetails = (String) getHabDet(habCode, con1);
			if (sources.size() > 0) {
				for (int i = 0; i < sources.size(); i++) {
					String testdate = "";
					String sourcedet1 = (String) sources.get(i);
					String[] sourcelist = sourcedet1.split("@");
					ntrRecord = new Rws_Ntr_Sujala_Patakam_Records();
					ntrRecord.setSourceCode(sourcelist[0]);
					ntrRecord.setSourceName(sourcelist[1]);
					ntrRecord.setSourcelocation(sourcelist[2]);
					ntrRecord.setSourceType(sourcelist[3]);

					ntrRecord.setShabCode(habCode);
					ntrRecord.setConstCode(getConstituency(habCode));
					ntrRecord.setSourcecondition(sourcelist[4]);
					String wqissue = "", planttype = "";
					double color = 0.0, turbidity = 0.0, ph = 0.0, tds = 0.0, floride = 0.0, chloride = 0.0,
							nitrate = 0.0, iron = 0.0, sulphate = 0.0, alkalinity = 0.0, hardness = 0.0, ecoli = 0.0;
					if (habdetails != null && habdetails.length() > 0 && !habdetails.equals("")) {
						String[] habdet = habdetails.split("@");
						if (habdet[0] != null) {
							ntrRecord.setHabPop(habdet[0]);
							ntrRecord.setHabstatus(habdet[1]);
						}
					}

					if (sourcetestdetails.get(habCode + sourcelist[0]) != null) {

						query1 = "select distinct a.source_code,a.source_code,a.source_code,a.source_code,to_char(a.prepared_on,'dd/mm/yyyy'),"
								+ "substr(a.source_code,1,16),a.test_id,a.test_code from RWS_WQ_TEST_RESULTS_TBL a , "
								+ "RWS_WQ_TEST_RESULTS_lnk_TBL b ,RWS_WQ_PARA_TEST_TBL c   where a.test_id=b.test_id and "
								+ "a.test_code=c.test_code and b.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE and "
								+ "substr(a.source_code,1,16)=? and b.TESTING_PARAMETER_CODE in ('01','02','04','05','13','12','15','16','14','07','06') and"
								+ " a.prepared_on=to_date('" + (Date) sourcetestdetails.get(habCode + sourcelist[0])
								+ "','yyyy-mm-dd') and a.source_code=? ";

						ntrRecord.setTestDate(formatter.format(sourcetestdetails.get(habCode + sourcelist[0])));

						st1 = con1.prepareStatement(query1);
						st1.setString(1, habCode);
						st1.setString(2, sourcelist[0]);
						rs1 = st1.executeQuery();
					} else {
						

						ntrRecord.setTestDate("-");

						String sourcedet = getSourceDet(ntrRecord.getSourceCode(), con1);
						if (sourcedet != null && sourcedet.length() != 0 && !sourcedet.equals("")) {
							String[] source = sourcedet.split("@");
							ntrRecord.setChecks("on");
							ntrRecord.setIssueIdent(source[0]);
							ntrRecord.setPlantType(source[1]);
							ntrRecord.setGenHealIssuesIdent(source[2]);
							if (source[3] != null && source[3].equals("Y")) {
								ntrRecord.setBuildingAvailability("true");
							}

							ntrRecord.setBuildingName(source[4]);
							ntrRecord.setBuildingLoc(source[5]);
							ntrRecord.setBuildingSize(source[6]);

							if (source[7] != null && source[7].equals("Y")) {
								ntrRecord.setWaterAvailabilty("true");
							}
							ntrRecord.setWaterAvalDist(source[8]);
							if (source[9] != null && source[9].equals("Y")) {
								ntrRecord.setPowerAvailability("true");
							}

							if (source[10] != null && source[10].equals("Y")) {
								ntrRecord.setAnyFirm("true");
							}
							ntrRecord.setAnyFirmName(source[11]);
							ntrRecord.setAnyFirmloc(source[12]);
							ntrRecord.setAnyFirmExtPlantType(source[13]);
							ntrRecord.setAnyFirmExtPlantCap(source[14]);
							if (source[15] != null && source[15].equals("Y")) {
								ntrRecord.setAnyCoporate("true");
							}

							ntrRecord.setAnyCoporateName(source[16]);
							ntrRecord.setAnyCoporateloc(source[17]);
							ntrRecord.setPhaseImpl(source[18]);

						}
						sourceList.add(ntrRecord);
						continue;

					}

					if (rs1.next()) {

						Hashtable testValues = getTestParaValues(rs1.getString(7), con1);
						if (testValues != null && testValues.get(rs1.getString(7) + "01") != null) {
							color = (Double) testValues.get(rs1.getString(7) + "01");
							ntrRecord.setCoptValue((Double) testValues.get(rs1.getString(7) + "01"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + 1 + "02") != null) {
							turbidity = (Double) testValues.get(rs1.getString(7) + 1 + "02");
							ntrRecord.setTurbValue((Double) testValues.get(rs1.getString(7) + 1 + "02"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "04") != null) {
							ph = (Double) testValues.get(rs1.getString(7) + "04");
							ntrRecord.setPhValue((Double) testValues.get(rs1.getString(7) + "04"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "05") != null) {
							tds = (Double) testValues.get(rs1.getString(7) + "05");
							ntrRecord.setTdsValue((Double) testValues.get(rs1.getString(7) + "05"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "13") != null) {
							floride = (Double) testValues.get(rs1.getString(7) + "13");
							ntrRecord.setFlourideValue((Double) testValues.get(rs1.getString(7) + "13"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "12") != null) {
							chloride = (Double) testValues.get(rs1.getString(7) + "12");
							ntrRecord.setChlorideValue((Double) testValues.get(rs1.getString(7) + "12"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "15") != null) {
							nitrate = (Double) testValues.get(rs1.getString(7) + "15");
							ntrRecord.setNitrateValue((Double) testValues.get(rs1.getString(7) + "15"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "16") != null) {
							iron = (Double) testValues.get(rs1.getString(7) + "16");
							ntrRecord.setIronValue((Double) testValues.get(rs1.getString(7) + "16"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "14") != null) {
							sulphate = (Double) testValues.get(rs1.getString(7) + "14");
							ntrRecord.setSulphateValue((Double) testValues.get(rs1.getString(7) + "14"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "07") != null) {
							alkalinity = (Double) testValues.get(rs1.getString(7) + "07");
							ntrRecord.setAlkalinitValue((Double) testValues.get(rs1.getString(7) + "07"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + "06") != null) {
							hardness = (Double) testValues.get(rs1.getString(7) + "06");
							ntrRecord.setHardnessValue((Double) testValues.get(rs1.getString(7) + "06"));
						}
						if (testValues != null && testValues.get(rs1.getString(7) + 2 + "02") != null) {
							ecoli = (Double) testValues.get(rs1.getString(7) + 2 + "02");
							ntrRecord.setEcoliValue((Double) testValues.get(rs1.getString(7) + 2 + "02"));
						}

						if (turbidity > 1) {
							wqissue += "TURBIDITY,";

						}
						if (tds > 500) {

							wqissue += "TDS,";

						}
						if (floride > 1) {

							wqissue += "FLUORIDE,";

						}
						if (nitrate > 45) {

							wqissue += "NITRATE,";

						}
						if (iron > 0.3) {

							wqissue += "IRON,";

						}
						if (ecoli > 0) {

							wqissue += "BACTERIOLOGICAL,";

						}
						String issue = "";
						if (wqissue.length() == 0) {
							issue += "NILL";
						} else {
							issue = wqissue.substring(0, wqissue.length() - 1);
						}
						ntrRecord.setIssueIdent(issue);

						if (tds > 500) {
							if (floride > 1 || iron > 0.3 || nitrate > 45) {
								planttype = "ROPLANT";
							} else {
								planttype = "ROPLANT";
							}
						} else {
							if (floride > 1) {
								if (nitrate < 45 && iron < 0.3) {
									planttype = "EDF";
								} else {
									planttype = "ROPLANT";
								}
							} else {
								if (iron > 0.3) {
									if (nitrate < 45 && floride < 1) {
										planttype = "TERAFIL";
									} else {
										planttype = "ROPLANT";
									}
								} else {
									if (nitrate > 45) {
										planttype = "ROPLANT";
									} else {
										if (turbidity > 1) {
											planttype = "Ultra Filteration / Gravity Filters";
										} else {
											planttype = "UV/ CHLORINATION";
										}
									}

								}
							}
						}

						ntrRecord.setTestid(rs1.getString(7));
						ntrRecord.setPlantType(planttype);

						String sourcedet = getSourceDet(ntrRecord.getSourceCode(), con1);
						if (sourcedet != null && sourcedet.length() != 0 && !sourcedet.equals("")) {
							String[] source = sourcedet.split("@");
							ntrRecord.setChecks("on");
							ntrRecord.setIssueIdent(source[0]);
							ntrRecord.setPlantType(source[1]);
							ntrRecord.setGenHealIssuesIdent(source[2]);
							if (source[3] != null && source[3].equals("Y")) {
								ntrRecord.setBuildingAvailability("true");
							}

							ntrRecord.setBuildingName(source[4]);
							ntrRecord.setBuildingLoc(source[5]);
							ntrRecord.setBuildingSize(source[6]);

							if (source[7] != null && source[7].equals("Y")) {
								ntrRecord.setWaterAvailabilty("true");
							}
							ntrRecord.setWaterAvalDist(source[8]);
							if (source[9] != null && source[9].equals("Y")) {
								ntrRecord.setPowerAvailability("true");
							}

							if (source[10] != null && source[10].equals("Y")) {
								ntrRecord.setAnyFirm("true");
							}
							ntrRecord.setAnyFirmName(source[11]);
							ntrRecord.setAnyFirmloc(source[12]);
							ntrRecord.setAnyFirmExtPlantType(source[13]);
							ntrRecord.setAnyFirmExtPlantCap(source[14]);
							if (source[15] != null && source[15].equals("Y")) {
								ntrRecord.setAnyCoporate("true");
							}

							ntrRecord.setAnyCoporateName(source[16]);
							ntrRecord.setAnyCoporateloc(source[17]);
							ntrRecord.setPhaseImpl(source[18]);

						}
						sourceList.add(ntrRecord);
					} else {

						wqissue = "Nill";
						ntrRecord.setIssueIdent(wqissue);
						planttype = "Nill";
						ntrRecord.setTestid("");
						ntrRecord.setPlantType(planttype);

						sourceList.add(ntrRecord);
					}

				}
			}

		} catch (Exception e) {
			Debug.println("exception  in getSourceDetails of Rws_Ntr_Sujala_Patakam_DAO = " + e);
		} finally {
			try {

				if (con1 != null) {
					con1.close();
				}
				if (st1 !=null) {
					st1.close();
				}
				if (rs1 !=null) {
					rs1.close();
				}
			} catch (Exception e) {
				Debug.println("exception in getSourceDetails of Rws_Ntr_Sujala_Patakam_DAO finally = " + e);
			}
		}
		return sourceList;
	}

	public ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode) throws Exception {
		ArrayList habs = new ArrayList();

		String query = "";
		try {
			Connection conn = RwsOffices.getConn();
			
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,RWS_HABITATION_DIRECTORY_TBL HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)='" + dcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,6,2)='" + mcode + "' AND " + "SUBSTR(RAJ.HAB_CODE,13,2)='" + pcode
					+ "' AND SUBSTR(RAJ.HAB_CODE,8,3)='" + vcode
					+ "' AND (HD.COVERAGE_STATUS IS NOT NULL OR HD.COVERAGE_STATUS <> 'UI')";
			PreparedStatement ps = conn.prepareStatement(query);

			rset = ps.executeQuery();

			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - " + rset.getString(2));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getHabitations Rws_Ntr_Sujala_Patakam_DAO="+e);
		} finally {
			try {

				if (rset !=null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("exception in getSourceDetails of Rws_Ntr_Sujala_Patakam_DAO finally = " + e);
			}
		}
		return habs;
	}

	private Hashtable getAllSources(String habCode, Connection conn) {
		String query = "";
		PreparedStatement st1 = null;
		ResultSet rs1 = null;
		Hashtable allSources = new Hashtable();
		try {

			query = "select distinct substr(a.source_code,1,16),a.source_code,max(prepared_on) from RWS_WQ_TEST_RESULTS_TBL a, "
					+ "RWS_WQ_TEST_RESULTS_lnk_TBL b where a.test_id=b.test_id and substr(a.source_code,1,16)=?"
					+ " group by a.source_code order by (case  substr(a.source_code,17,3) when '800' then 1 when '600' then 2 when  '400' then 3 "
					+ "when '001' then 4  when '451' then 5  ELSE 100 END) ASC";
			st1 = conn.prepareStatement(query);
			st1.setString(1, habCode);
			rs1 = st1.executeQuery();
			while (rs1.next()) {
				allSources.put(rs1.getString(1) + rs1.getString(2), rs1.getDate(3));
			}

		} catch (Exception e) {
			System.out.println("exception in getAllSources of Rws_Ntr_Sujala_Patakam_DAO -- " + e);
		} finally {

			try {
				if (st1 != null) {
					st1.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

			} catch (Exception e) {
				System.out.println("exception in getAllSources of Rws_Ntr_Sujala_Patakam_DAO finally-- " + e);
			}

		}
		return allSources;
	}

	public Hashtable getTestParaValues(String testId, Connection conn) {
		String query = "", paraValues = "";
		PreparedStatement st1 = null;
		ResultSet rs1 = null;
		Hashtable para_values = new Hashtable();
		try {

			query = "select distinct b.test_id, a.testing_parameter_code,nvl(a.testing_parameter_value,0),b.test_code  from  "
					+ "RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_TBL b    where a.test_id=b.test_id and b.test_id=? and"
					+ " b.test_code in (1,2)  and a.testing_parameter_code in ('01','02','04','05','13','12','15','16','14','07','06')  ORDER BY "
					+ "(CASE a.testing_parameter_code     WHEN '01'	 THEN 1    WHEN '02'	 THEN 2    WHEN '04'	 THEN 3 WHEN '05'	 "
					+ "THEN 4    WHEN '13'    THEN 5    WHEN '12'	THEN 6    WHEN '15'	THEN 7    WHEN '16'	THEN 8    WHEN '14'	THEN 9  "
					+ "WHEN '05'	 THEN 10   WHEN '06'	THEN 11   ELSE 100 END) ASC";
			st1 = conn.prepareStatement(query);
			st1.setString(1, testId);
			rs1 = st1.executeQuery();
			while (rs1.next()) {

				if (rs1.getString(2).equals("02")) {
					para_values.put(rs1.getString(1) + rs1.getString(2) + rs1.getInt(4), rs1.getDouble(3));
				} else {
					para_values.put(rs1.getString(1) + rs1.getString(2), rs1.getDouble(3));
				}
			}

		} catch (Exception e) {
			System.out.println("exception in getTestParaValues of Rws_Ntr_Sujala_Patakam_DAO -- "+e);
		} finally {

			try {
				if (st1 != null) {
					st1.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

			} catch (Exception e) {
				System.out.println("exception in getTestParaValues of Rws_Ntr_Sujala_Patakam_DAO finally-- "+e);
			}
		}
		return para_values;
	}

	public String getConstituency(String habcode) {
		String query = "", contituency = "";
		Rws_Ntr_Sujala_Patakam_Records ntrRecord = null;
		PreparedStatement  st1 = null;
		ResultSet rs1 = null;
		Hashtable para_values = new Hashtable();
		try {

			conn = RwsOffices.getConn();
			query = "select CONSTITUENCY_NAME from RWS_CONSTITUENCY_TBL where dcode=substr(?,1,2) and mcode=substr(?,6,2)  ";
			
			st1 = conn.prepareStatement(query);
			st1.setString(1, habcode);
			st1.setString(2, habcode);
			rs1 = st1.executeQuery();
			if (rs1.next()) {
				contituency = rs1.getString(1);

			}

		} catch (Exception e) {
			Debug.println("exception  in getConstituency of Rws_Ntr_Sujala_Patakam_DAO = " + e);
		
		} finally {
			try {
			if (conn !=null) {
			
					conn.close();
				} 
			if (st1!=null) {
				st1.close();
			}
			if (rs1!=null) {
				rs1.close();
			}
			}
			catch (Exception e) {
				Debug.println("exception  in getConstituency of Rws_Ntr_Sujala_Patakam_DAO finally = " + e);
			}
		}
		return contituency;
	}

	public int[] saveHabitations(ArrayList resultData) throws Exception {
		int count[] = {};

		try {
			conn = RwsOffices.getConn();
			Statement pstmt = conn.createStatement();
			ResultSet rs1 = null;

			Statement stmt = conn.createStatement();

			Date dt = new Date(System.currentTimeMillis());
			String currentDate = Integer.toString(dt.getYear() + 1900);

			String query = "";
			for (int i = 0; i < resultData.size(); i++) {

				Rws_Ntr_Sujala_Patakam_Records dr = (Rws_Ntr_Sujala_Patakam_Records) resultData.get(i);

				String delQuery = "delete from rws_ntr_sujala_master_tbl where hab_code='" + dr.getShabCode() + "'";

				pstmt.addBatch(delQuery);

				query = "insert into rws_ntr_sujala_master_tbl  values ('" + dr.getShabCode() + "','"
						+ dr.getSourceCode() + "','" + dr.getTestid() + "'," + "to_date('" + dr.getTestDate() + "',"
						+ "'dd/mm/yyyy'),'" + dr.getIssueIdent() + "','" + dr.getPlantType() + "','"
						+ dr.getGenHealIssuesIdent() + "','" + dr.getBuildingAvailability() + "','"
						+ dr.getBuildingName() + "','" + dr.getBuildingLoc() + "','" + dr.getBuildingSize() + "','"
						+ dr.getWaterAvailabilty() + "','" + dr.getWaterAvalDist() + "','" + dr.getPowerAvailability()
						+ "','" + dr.getAnyFirm() + "','" + dr.getAnyFirmName() + "','" + dr.getAnyFirmloc() + "','"
						+ dr.getAnyFirmExtPlantType() + "','" + dr.getAnyFirmExtPlantCap() + "','" + dr.getAnyCoporate()
						+ "','" + dr.getAnyCoporateName() + "','" + dr.getAnyCoporateloc() + "','" + dr.getPhaseImpl()
						+ "')";

				pstmt.addBatch(query);

			}
			count = pstmt.executeBatch();

			if (count.length > 0) {
				// conn.setAutoCommit(true);
				// conn.commit();
			} else {
				conn.rollback();
			}
		} catch (Exception e) {
			System.out.println("exception in saveHabitations of Rws_Ntr_Sujala_Patakam_DAO-- " + e);
		}
		return count;

	}

	public String getSourceDet(String sourcecode, Connection conn) {
		String query = "", srourcedetil = null;
		PreparedStatement st1 = null;
		ResultSet rs1 = null;
		Hashtable para_values = new Hashtable();
		try {

			query = "select nvl(quality_issue,''),nvl(type_of_plant,''),nvl(health_issues,''),bldg_available,nvl(bldg_name,''),nvl(bldg_location,''),nvl(bldg_size,'0'),"
					+ "water_available,nvl(water_distance,'0'),power_supply,water_plant_extist,nvl(water_plant_firm,'-'),nvl(water_plant_location,'-'),"
					+ "nvl(plant_exist_type,'-'),nvl(plant_capacity,'0'),nvl(take_programme_vol,'') ,nvl(take_programme_vol_name,''),"
					+ "nvl(take_programme_vol_loc,''),nvl(phase,'') from rws_ntr_sujala_master_tbl where source_code=? ";

			st1 = conn.prepareStatement(query);
			st1.setString(1, sourcecode);
			rs1 = st1.executeQuery();

			if (rs1.next()) {
				srourcedetil = rs1.getString(1) + "@" + rs1.getString(2) + "@" + rs1.getString(3) + "@"
						+ rs1.getString(4) + "@" + rs1.getString(5) + "@" + rs1.getString(6) + "@" + rs1.getString(7)
						+ "@" + rs1.getString(8) + "@" + rs1.getString(9) + "@" + rs1.getString(10) + "@"
						+ rs1.getString(11) + "@" + rs1.getString(12) + "@" + rs1.getString(13) + "@"
						+ rs1.getString(14) + "@" + rs1.getString(15) + "@" + rs1.getString(16) + "@"
						+ rs1.getString(17) + "@" + rs1.getString(18) + "@" + rs1.getString(19);

			}

		} catch (Exception e) {
			System.out.println("exception in getSourceDet of Rws_Ntr_Sujala_Patakam_DAO " + e);
		} finally {

			try {
				if (st1 != null) {
					st1.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

			} catch (Exception e) {
				System.out.println("exception in getSourceDet of Rws_Ntr_Sujala_Patakam_DAO finally " + e);
			}
		}
		return srourcedetil;
	}

	public String getHabDet(String habcode, Connection conn) {
		String query = "", habdetil = null;

		PreparedStatement st1 = null;
		ResultSet rs1 = null;
		try {

			query = "select nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(coverage_status,'-')"
					+ " from rws_complete_hab_view where panch_code=? ";
			st1 = conn.prepareStatement(query);
			st1.setString(1, habcode);
			rs1 = st1.executeQuery();
			if (rs1.next()) {
				habdetil = rs1.getInt(1) + "@" + rs1.getString(2);

			}

		} catch (Exception e) {
		System.out.println("exception in getHabDet of Rws_Ntr_Sujala_Patakam_DAO-- "+e);
		} finally {

			try {
				if (st1 != null) {
					st1.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

			} catch (Exception e) {
				System.out.println("exception in getHabDet of Rws_Ntr_Sujala_Patakam_DAO finally-- "+e);
			}
		}
		return habdetil;
	}

	private ArrayList getAllSources1(String habCode, Connection conn) {
		String query = "", sourcetype = "";
		PreparedStatement st1 = null, hpStmt = null, shpStmt = null, owStmt = null, pondStmt = null;
		ResultSet rs1 = null, hpRs = null, shpRs = null, owRs = null, pondRs = null;
		ArrayList allSources1 = new ArrayList();

		try {

			query = "select distinct substr(source_code,1,16),source_code,nvl(source_name,'-'),nvl(LOCATION,'-'),SUBSOURCE_TYPE_CODE,"
					+ "NVL(SOURCE_CONDITION,'-'),substr(source_code,20,2)  from rws_source_tbl where  substr(source_code,1,16)=?"
					+ " order by (case  substr(source_code,17,3) when '800' then 1 when '600' then 2 when  '400' then 3 when '001' then 4  when '451' then 5"
					+ "  ELSE 100 END) ASC";
			st1 = conn.prepareStatement(query);
			st1.setString(1, habCode);
			rs1 = st1.executeQuery();
			while (rs1.next()) {

				if (rs1.getString(5).equals("1")) {
					sourcetype = "Ground Water";
				} else if (rs1.getString(5).equals("2")) {
					sourcetype = "Surface";
				}
				if (rs1.getString(7).equals("HP")) {
					sourcetype = "Ground Water";
				}
				allSources1.add(rs1.getString(2) + "@" + rs1.getString(3) + "@" + rs1.getString(4) + "@" + sourcetype
						+ "@" + rs1.getString(6));

			}


			String hpQuery = "select distinct substr(hp_code,1,16),hp_code,nvl(LOCATION,'-'),NVL(status,'-'),substr(hp_code,20,2)  from "
					+ "rws_hp_subcomp_param_tbl where substr(hp_code,1,16)=? ";

			hpStmt = conn.prepareStatement(hpQuery);
			hpStmt.setString(1, habCode);

			hpRs = hpStmt.executeQuery();

			while (hpRs.next()) {

				sourcetype = "Ground Water";
				allSources1.add(hpRs.getString(2) + "@" + hpRs.getString(3) + "@" + hpRs.getString(4) + "@" + sourcetype
						+ "@" + hpRs.getString(5));

			}

		

			String shpQuery = "select distinct substr(SHALLOWHP_CODE,1,16),SHALLOWHP_CODE,nvl(LOCATION,'-'),NVL(status,'-'),"
					+ "substr(SHALLOWHP_CODE,20,2)  from RWS_SHALLOWHANDPUMPS_TBL where"
					+ " substr(SHALLOWHP_CODE,1,16)=? ";

			shpStmt = conn.prepareStatement(shpQuery);
			shpStmt.setString(1, habCode);

			shpRs = shpStmt.executeQuery();

			while (shpRs.next()) {

				sourcetype = "Ground Water";
				allSources1.add(shpRs.getString(2) + "@" + shpRs.getString(3) + "@" + shpRs.getString(4) + "@"
						+ sourcetype + "@" + shpRs.getString(5));

			}

		

			String oWQuery = "select distinct substr(OPENWELL_CODE,1,16),OPENWELL_CODE,nvl(LOCATION,'-'),NVL(status,'-'),"
					+ "substr(OPENWELL_CODE,20,2)  from RWS_OPEN_WELL_MAST_TBL where substr(OPENWELL_CODE,1,16)=? ";

			owStmt = conn.prepareStatement(oWQuery);
			owStmt.setString(1, habCode);
			owRs = owStmt.executeQuery();

			while (owRs.next()) {

				sourcetype = "Ground Water";
				allSources1.add(owRs.getString(2) + "@" + owRs.getString(3) + "@" + owRs.getString(4) + "@" + sourcetype
						+ "@" + owRs.getString(5));

			}

		

			String pondsQuery = "select distinct substr(POND_CODE,1,16),POND_CODE,nvl(POND_LOCATION,'-'),"
					+ "nvl(POND_LOCATION,'-'),substr(POND_CODE,20,2)  from RWS_OPENWELL_POND_TBL where"
					+ " substr(POND_CODE,1,16)=? ";

			pondStmt = conn.prepareStatement(pondsQuery);
			pondStmt.setString(1, habCode);
			pondRs = pondStmt.executeQuery();

			while (pondRs.next()) {

				sourcetype = "Surface Water";
				allSources1.add(pondRs.getString(2) + "@" + pondRs.getString(3) + "@" + pondRs.getString(4) + "@"
						+ sourcetype + "@" + pondRs.getString(5));

			}


		} catch (Exception e) {
			Debug.println(" exception in getAllSources1 of Rws_Ntr_Sujala_Patakam_DAO= " + e);
		} finally {
			try {
				if (hpStmt != null) {
					hpStmt.close();
				}
				if (shpStmt != null) {
					shpStmt.close();
				}
				if (owStmt != null) {
					owStmt.close();
				}
				if (pondStmt != null) {
					pondStmt.close();
				}
				if (hpRs != null) {
					hpRs.close();
				}
				if (shpRs != null) {
					shpRs.close();
				}
				if (pondRs != null) {
					pondRs.close();
				}

			} catch (Exception e) {
				Debug.println(" exception in getAllSources1 of Rws_Ntr_Sujala_Patakam_DAO finally= " + e);
			}
		}
		return allSources1;
	}


	public ArrayList getPlatTypes() {

		String query = "";

		LabelValueBean plant = null;
		ArrayList plantTypes = new ArrayList();
		PreparedStatement ps = null;

		try {

			conn = RwsOffices.getConn();

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
			Debug.println("Exception in getPlatTypes of Rws_Ntr_Sujala_Patakam_DAO=" + e);
		} finally {
			try {
				conn.close();
				if (ps!=null) {
					ps.close();
				}
				if (rs!=null) {
					rs.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception in getPlatTypes of Rws_Ntr_Sujala_Patakam_DAO finally=" + e);
			}

		}
		return plantTypes;
	}

}