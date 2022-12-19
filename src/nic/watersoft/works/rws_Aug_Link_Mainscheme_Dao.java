package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import java.util.StringTokenizer;

public class rws_Aug_Link_Mainscheme_Dao {

	private LabelValueBean labelValueBean = null;
	
	public ArrayList getWorkDetails(String cir, String div, String subdiv, HttpServletRequest request) {
	
		ArrayList Workdetails = new ArrayList();
		Connection conn = null;
		PreparedStatement pstmt = null, pstmt1 = null;
		PreparedStatement pst =null;
		ResultSet rs = null, rs1 = null ,qqqrs=null;
		try {
			conn = RwsOffices.getConn();
			String qry = "select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy') as admin_date,sanction_amount,nvl(aug_workid,'') "
					+ "as aug_workid,lead_habitation from rws_work_admn_tbl where substr(work_id,7,2) not in ('11','12')";
			if (cir != null && !cir.equals("")) {
				qry += " and substr (office_code,2,2)='" + cir + "'";
			}
			if (div != null && !div.equals("")) {
				qry += " and substr (office_code,4,1)='" + div + "'";
			}
			if (subdiv != null && !subdiv.equals("")) {
				qry += " and substr (office_code,5,2)='" + subdiv + "'";
			}
			pstmt = conn.prepareStatement(qry);
			rs = pstmt.executeQuery();
			String aTypes[] = { "PWS", "MPWS", "CPWS", "HAND PUMPS", "SHALLOW HANDPUMPS", "OPEN WELLS", "PONDS",
					"OTHERS", "DIRECT PUMPING" };

			while (rs.next()) {
				String mname = "-", pname = "-", habname = "-";

				if (rs.getString("lead_habitation") != null && !rs.getString("lead_habitation").equals("")) {
					String query = "select * from rws_complete_hab_view where panch_code=? ";
				     pst = conn.prepareStatement(query);
					pst.setString(1, rs.getString("lead_habitation"));
				  qqqrs = pst.executeQuery();
					if (qqqrs.next()) {
						mname = qqqrs.getString("mname");
						pname = qqqrs.getString("pname");
						habname = qqqrs.getString("panch_name");
					}
				}
				rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
				fnd.setWorkId(rs.getString("work_id"));
				fnd.setWorkName(rs.getString("work_name"));
				fnd.setAdminDate(rs.getString("admin_date"));
				fnd.setAdminNo(rs.getString("admin_no"));
				fnd.setSamount(rs.getString("sanction_amount"));
				fnd.setMandalName(mname);
				fnd.setMandal(pname);
				fnd.setHabName(habname);
				String aug_workid = rs.getString("aug_workid");
				
				if (rs.getString("aug_workid") == null)
					aug_workid = "";
				
				String work = "", asset = "", workname = "", assetname = "";
				ArrayList assettype1 = new ArrayList();
				ArrayList astwrk = new ArrayList();
				ArrayList assets = new ArrayList();
				
				String qry1 = "select (select work_id from rws_work_admn_tbl where work_id=?) a, "
						+ "(select type_of_asset_code from rws_asset_mast_tbl where asset_code=?)b,"
						+ "(select work_name from rws_work_admn_tbl where work_id=?)c,"
						+ "(select asset_name from rws_asset_mast_tbl where asset_code=?)d from dual";
				
				pstmt1 = conn.prepareStatement(qry1);
				pstmt1.setString(1, aug_workid);
				pstmt1.setString(2, aug_workid);
				pstmt1.setString(3, aug_workid);
				pstmt1.setString(4, aug_workid);
				
				rs1 = pstmt1.executeQuery();
				if (rs1.next()) {
					work = rs1.getString(1);
					asset = rs1.getString(2);
					workname = rs1.getString(3);
					assetname = rs1.getString(4);
				}
				if (work != null && !work.equals("")) {
					assettype1.add(0, aTypes[(Integer.parseInt(work.substring(6, 8))) - 1]);
					astwrk.add(0, "WORK");
					assets.add(0, aug_workid + "-" + workname);

				}
				if (asset != null && !asset.equals("")) {
					assettype1.add(0, aTypes[(Integer.parseInt(asset)) - 1]);
					astwrk.add(0, "ASSET");
					assets.add(0, aug_workid + "-" + assetname);
				}
				if (assettype1 != null)
					fnd.setAssettype(assettype1);
				if (astwrk != null)
					fnd.setAstwork(astwrk);
				if (assets != null)
					fnd.setAssets(assets);
				Workdetails.add(fnd);
				if (rs1 != null)
					rs1.close();
				if (pstmt1 != null)
					pstmt1.close();
				if (pst != null)
					pst.close();
			}
			
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			
		} catch (Exception e) {
			Debug.println("Exception in getWorkDetails Method of rws_Aug_Link_Mainscheme_Dao:" + e);
			e.printStackTrace();
		}

		return Workdetails;
	}

	public static int insertData(String workid, String acode) throws Exception {
		int count = 0;
		String query = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		
		try {
			conn = RwsOffices.getConn();
		

			query = "update rws_work_admn_tbl set AUG_WORKID =?,AUG_NEW_CODE='2' where work_id=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, acode);
			stmt.setString(2, workid);
			
			count = stmt.executeUpdate();

		} catch (Exception e) {
		Debug.println("The error in insertData of rws_Aug_Link_Mainscheme_Dao: " + e);
		} finally {
			
			stmt.close();
			conn.close();
		}

		return count;
	}
	// code for work gap report

	public ArrayList getPrograms(String cir) {
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList list = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select distinct p.programme_code,p.programme_name from rws_programme_tbl p,rws_work_admn_tbl w where p.programme_code=w.programme_code and substr(work_id,5,2)='"
					+ cir + "' ";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				list.add(labelValueBean);

			}
		} catch (Exception e) {
			Debug.println("Exception in getting program name of rws_Aug_Link_Mainscheme_Dao: "+e);
		}

		return list;
	}

	public ArrayList getViewWorks(String key, String ccode, String progcode) {
		StringBuffer query = new StringBuffer("");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList worklist = new ArrayList();
	
		try {
			conn = RwsOffices.getConn();

			if (key.equals("01")) {
				stmt = conn.createStatement();
				query.append(
						"select work_id,work_name,admin_no,to_char(admin_date,'dd/MM/YYYY')as admin_date,sanction_amount from rws_work_admn_tbl where (admin_no is null or admin_date is null or sanction_amount is null) and substr(work_id,5,2)='"
								+ ccode + "'");
				if (progcode != null && !progcode.equals("")) {
					query.append(" and programme_code ='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					worklist.add(fnd);
				}
			}
			if (key.equals("02")) {
				stmt = conn.createStatement();
				query.append(
						"select a.work_id,c.work_name,to_char(admin_date,'dd/MM/YYYY')as admin_date,c.admin_no,c.sanction_amount,p.plan_name,cat.category_name,aug.aug_new_name,div.division_office_name from rws_work_commencement_tbl a,rws_contractor_selection_tbl b,rws_work_admn_tbl c,rws_plan_nonplan_tbl p,rws_work_category_tbl cat,RWS_AUGUMENTATION_NEW_TBL aug,rws_division_office_tbl div where a.work_id=b.work_id and a.work_id=c.work_id and grounding_date is not null and p.plan_code=c.plan_code and cat.category_code=c.category_code and c.aug_new_code=aug.aug_new_code and div.division_office_code=substr(c.office_code,4,1) and substr(c.work_id,5,2) =div.circle_office_code and a.work_id not in (select work_id from rws_new_est_tbl) and substr(a.work_id,5,2)='"
								+ ccode + "' ");
				if (progcode != null && !progcode.equals("")) {
					query.append(" and programme_code='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					fnd.setPlan(rs.getString("plan_name"));
					fnd.setWorkCat(rs.getString("category_name"));
					fnd.setAugType(rs.getString("aug_new_name"));
					fnd.setDivName(rs.getString("division_office_name"));

					worklist.add(fnd);
				}
			}
			if (key.equals("03")) {
				stmt = conn.createStatement();
				query.append(
						"select a.work_id,b.work_name,to_char(admin_date,'dd/MM/YYYY')as admin_date,b.admin_no,b.sanction_amount,p.plan_name,cat.category_name,aug.aug_new_name,div.division_office_name from rws_work_commencement_tbl a,rws_work_admn_tbl b,rws_plan_nonplan_tbl p,rws_work_category_tbl cat,RWS_AUGUMENTATION_NEW_TBL aug,rws_division_office_tbl div where grounding_date is not null and a.work_id=b.work_id and"
								+ "  p.plan_code=b.plan_code and cat.category_code=b.category_code and b.aug_new_code=aug.aug_new_code and div.division_office_code=substr(b.office_code,4,1) and substr(b.work_id,5,2) =div.circle_office_code and a.work_id not in(select work_id from rws_contractor_selection_tbl) and substr(a.work_id,5,2)='"
								+ ccode + "'");
				if (progcode != null && !progcode.equals("")) {
					query.append(" and programme_code='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					fnd.setPlan(rs.getString("plan_name"));
					fnd.setWorkCat(rs.getString("category_name"));
					fnd.setAugType(rs.getString("aug_new_name"));
					fnd.setDivName(rs.getString("division_office_name"));
					worklist.add(fnd);
				}

			}
			if (key.equals("04")) {
				stmt = conn.createStatement();
				query.append(
						"select a.work_id,b.work_name,to_char(admin_date,'dd/MM/YYYY')as admin_date,b.admin_no,b.sanction_amount,p.plan_name,cat.category_name,aug.aug_new_name,div.division_office_name from RWS_WORK_EXPENDITURE_TBL a,rws_work_admn_tbl b,rws_plan_nonplan_tbl p,rws_work_category_tbl cat,RWS_AUGUMENTATION_NEW_TBL aug,rws_division_office_tbl div  where a.work_id=b.work_id and EXPENDITURE_UPTO is not null and EXPENDITURE_DURING is not null and p.plan_code=b.plan_code and cat.category_code=b.category_code and b.aug_new_code=aug.aug_new_code and div.division_office_code=substr(b.office_code,4,1) and substr(b.work_id,5,2) =div.circle_office_code  and a.work_id not in (select work_id from rws_work_commencement_tbl) and substr(a.work_id,5,2)='"
								+ ccode + "'");

				if (progcode != null && !progcode.equals("")) {
					query.append(" and a.programme_code='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					fnd.setPlan(rs.getString("plan_name"));
					fnd.setWorkCat(rs.getString("category_name"));
					fnd.setAugType(rs.getString("aug_new_name"));
					fnd.setDivName(rs.getString("division_office_name"));
					worklist.add(fnd);
				}
			}

			if (key.equals("05")) {
				stmt = conn.createStatement();
				query.append(
						"select a.work_id,b.work_name,to_char(admin_date,'dd/MM/YYYY')as admin_date,b.admin_no,b.sanction_amount,p.plan_name,cat.category_name,aug.aug_new_name,div.division_office_name"
								+ " from rws_work_completion_tbl a,rws_work_admn_tbl b,rws_plan_nonplan_tbl p,rws_work_category_tbl cat,RWS_AUGUMENTATION_NEW_TBL aug,rws_division_office_tbl div  where a.work_id=b.work_id and date_of_completion is not null  and p.plan_code=b.plan_code and cat.category_code=b.category_code and b.aug_new_code=aug.aug_new_code and div.division_office_code=substr(b.office_code,4,1) and substr(b.work_id,5,2) =div.circle_office_code"
								+ " and a.work_id not in (select work_id from RWS_WORK_EXPENDITURE_TBL) and substr(a.work_id,5,2)='"
								+ ccode + "'");
				if (progcode != null && !progcode.equals("")) {
					query.append(" and programme_code ='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					fnd.setPlan(rs.getString("plan_name"));
					fnd.setWorkCat(rs.getString("category_name"));
					fnd.setAugType(rs.getString("aug_new_name"));
					fnd.setDivName(rs.getString("division_office_name"));
					worklist.add(fnd);
				}
			}
			if (key.equals("06")) {
				stmt = conn.createStatement();
				query.append(
						"select a.work_id,b.work_name,to_char(admin_date,'dd/MM/YYYY')as admin_date,b.admin_no,b.sanction_amount,"
								+ " p.plan_name,cat.category_name,aug.aug_new_name,div.division_office_name from rws_work_completion_tbl a,rws_work_admn_tbl b,rws_plan_nonplan_tbl p,rws_work_category_tbl cat,RWS_AUGUMENTATION_NEW_TBL aug,rws_division_office_tbl div where a.work_id=b.work_id  and date_of_completion is null and p.plan_code=b.plan_code and cat.category_code=b.category_code and b.aug_new_code=aug.aug_new_code and div.division_office_code=substr(b.office_code,4,1) and substr(b.work_id,5,2) =div.circle_office_code and substr(a.work_id,5,2)='"
								+ ccode + "'");
				if (progcode != null && !progcode.equals("")) {
					query.append(" and programme_code='" + progcode + "'");
				}
				rs = stmt.executeQuery(query.toString());
				while (rs.next()) {
					rws_works_WorkStatus_form fnd = new rws_works_WorkStatus_form();
					fnd.setWorkId(rs.getString("work_id"));
					fnd.setWorkName(rs.getString("work_name"));
					fnd.setAdminDate(rs.getString("admin_date"));
					fnd.setAdminNo(rs.getString("admin_no"));
					fnd.setSamount(rs.getString("sanction_amount"));
					fnd.setPlan(rs.getString("plan_name"));
					fnd.setWorkCat(rs.getString("category_name"));
					fnd.setAugType(rs.getString("aug_new_name"));
					fnd.setDivName(rs.getString("division_office_name"));
					worklist.add(fnd);
				}
			}
		} catch (Exception e) {
			Debug.println("Exception in getViewWorks Method rws_Aug_Link_Mainscheme_Dao:"+e);
		}
		// }
		return worklist;
	}

	public int UpdateWorks(String stage, String val) {
		ArrayList list = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int count = 0;
		PreparedStatement ps=null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			if (stage != null && stage.equals("01")) {

				StringTokenizer s1 = new StringTokenizer(val, "*");
				while (s1.hasMoreTokens()) {
					String key = s1.nextToken();
					StringTokenizer key1 = new StringTokenizer(key, "$");
					while (key1.hasMoreTokens()) {
						String value = key1.nextToken();
						String val1 = key1.nextElement().toString();
						String qry = "update rws_work_admn_tbl set admin_no=? where work_id=?";
						 ps = conn.prepareStatement(qry);
						ps.setString(1,value);
						ps.setString(2,val1);
						count += ps.executeUpdate();
					}

				}
			} else if (stage != null && stage.equals("02")) {

			
			} else if (stage != null && stage.equals("03")) {

				StringTokenizer s1 = new StringTokenizer(val, "*");
				while (s1.hasMoreTokens()) {
					String key = s1.nextToken();
					StringTokenizer key1 = new StringTokenizer(key, "$");
					while (key1.hasMoreTokens()) {
						String value = key1.nextToken();
						String val1 = key1.nextElement().toString();
						String qry = "insert into rws_contractor_selection_tbl  values(?"
								+ ",'','','','','','','','','','','','',?,'','','','','','')";
						 ps = conn.prepareStatement(qry);
						ps.setString(1,value);
						ps.setString(2,val1);
						count += ps.executeUpdate();
					}

				}
			} else if (stage != null && stage.equals("04")) {

				StringTokenizer s1 = new StringTokenizer(val, "*");
				while (s1.hasMoreTokens()) {
					String key = s1.nextToken();
					StringTokenizer key1 = new StringTokenizer(key, "$");
					while (key1.hasMoreTokens()) {
						String value = key1.nextToken();
						String val1 = key1.nextElement().toString();
						String qry = "insert into rws_work_commencement_tbl  values(?,TO_DATE(?"
								+ ",'dd/MM/yyyy'),'','','','','','','')";
						ps = conn.prepareStatement(qry);
						ps.setString(1,val1);
						ps.setString(2,value);
						count += ps.executeUpdate();
					}

				}
			} else if (stage != null && stage.equals("05")) {

				StringTokenizer s1 = new StringTokenizer(val, "*");
				while (s1.hasMoreTokens()) {
					String key = s1.nextToken();
					StringTokenizer key1 = new StringTokenizer(key, "$");
					while (key1.hasMoreTokens()) {
						String value = key1.nextToken();
						String val1 = key1.nextElement().toString();
						String val2 = key1.nextElement().toString();
						String val3 = key1.nextElement().toString();
						String val4 = key1.nextElement().toString();
						String qry = "insert into rws_work_expenditure_tbl  values(?,?,"
								+"?,?,?,'','','')";
						ps = conn.prepareStatement(qry);
						ps.setString(1,val4);
						ps.setString(2,value);
						ps.setString(3,val1);
						ps.setString(4,val2);
						ps.setString(5,val3);
						count += ps.executeUpdate();
					}

				}
			} else if (stage != null && stage.equals("06")) {

				StringTokenizer s1 = new StringTokenizer(val, "*");
				while (s1.hasMoreTokens()) {
					String key = s1.nextToken();
					StringTokenizer key1 = new StringTokenizer(key, "$");
					while (key1.hasMoreTokens()) {
						String value = key1.nextToken();
						String val1 = key1.nextElement().toString();
						String qry = "insert into rws_work_completion_tbl  values(?,?"
								+ ",'','','','','','','','','','','','','','','','','','','','','','')";
						ps = conn.prepareStatement(qry);
						ps.setString(1,val1);
						ps.setString(2,value);
						count += ps.executeUpdate();
					}

				}
			}

		} catch (Exception e) {
			 Debug.println("Exception in Update Works rws_Aug_Link_Mainscheme_Dao:"+e);
		}

		return count;
	}

	public ArrayList getHabsData(String workid) throws Exception {
		ArrayList habs = new ArrayList();
		StringBuffer query = new StringBuffer("");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query.append(
					"select v.PANCH_CODE,v.PANCH_NAME,v.CENSUS_PLAIN_POPU,v.CENSUS_SC_POPU,v.CENSUS_ST_POPU,v.COVERAGE_STATUS,HABITATION_TYPE,v.HABITATION_SUB_TYPE,TSP_NTSP from rws_admn_hab_lnk_tbl a,rws_complete_hab_view v,rws_habitation_directory_tbl h  where a.hab_code=v.panch_code  and a.hab_code=h.hab_code and h.hab_code=v.panch_code and  work_id='"
							+ workid + "'");
			rs = stmt.executeQuery(query.toString());
			while (rs.next()) {
				rws_works_WorkStatus_form frm = new rws_works_WorkStatus_form();
				frm.setHabCode(rs.getString("PANCH_CODE"));
				frm.setHabName(rs.getString("PANCH_NAME"));
				frm.setPlainPop(rs.getString("CENSUS_PLAIN_POPU"));
				frm.setScPop(rs.getString("CENSUS_SC_POPU"));
				frm.setStPop(rs.getString("CENSUS_ST_POPU"));
				frm.setCodeStatus(rs.getString("COVERAGE_STATUS"));
				frm.setAugType(rs.getString("HABITATION_TYPE"));
				frm.setHabsCode(rs.getString("HABITATION_SUB_TYPE"));
				frm.setStage(rs.getString("TSP_NTSP"));
				habs.add(frm);
			}
		} catch (Exception e) {
			 Debug.println("Exception in Getting HabsData of Work Locality rws_Aug_Link_Mainscheme_Dao: "+e);
		}
		return habs;
	}

	public static int insertScData(String habcode, String lccode, String lcname) throws Exception {
		int count = 0;
		String query = "", qry1 = "";
		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			PreparedStatement ps,ps1=null;
			qry1 = "select hab_code,locality_code,locality_name from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=?"
					+ " and locality_code=? ";
			 ps = conn.prepareStatement(qry1);
			ps.setString(1,habcode);
			ps.setString(2,lccode);
			rs1 = ps.executeQuery();
			if (!rs1.next()) {
				query = " insert into RWS_SC_ST_MIN_LOCALITY_TBL(hab_code,locality_code,locality_name)values(?,?,?)";
				ps1 = conn.prepareStatement(query);
				ps1.setString(1,habcode);
				ps1.setString(2,lccode);
				ps1.setString(3,lcname);
			} else {

				query = " update RWS_SC_ST_MIN_LOCALITY_TBL set locality_name=? where hab_code=?"
						+" and locality_code=?";
				ps1 = conn.prepareStatement(query);
				ps1.setString(1,lcname);
				ps1.setString(2,habcode);
				ps1.setString(3,lccode);
			}
			count = ps1.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception in  insertScData of rws_Aug_Link_Mainscheme_Dao"+e);
		}

		return count;
	}

	public static int insertAssetData(String habcode, String astcode, String lccode, String popserved)
			throws Exception {
		int count = 0;
		String query = "";
		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			PreparedStatement ps=null;
			String qry = "select hab_code,asset_code,locality_code,population_served from RWS_ASSET_LOCALITY_SERVE_TBL where hab_code='"
					+ habcode + "' and asset_code='" + astcode + "' and locality_code='" + lccode + "'";
			rs1 = stmt1.executeQuery(qry);
			if (!rs1.next()) {
				query = " insert into RWS_ASSET_LOCALITY_SERVE_TBL (hab_code,asset_code,locality_code,population_served)values('"
						+ habcode + "','" + astcode + "','" + lccode + "','" + popserved + "')";
				ps = conn.prepareStatement(query);
				ps.setString(1,habcode);
				ps.setString(2,astcode);
				ps.setString(3,lccode);
				ps.setString(4, popserved);
			} else {
				query = " update RWS_ASSET_LOCALITY_SERVE_TBL set population_served=?"
						+ " where hab_code=? and asset_code=? and locality_code=?";
				ps = conn.prepareStatement(query);
				ps.setString(1,popserved);
				ps.setString(2,habcode);
				ps.setString(3,astcode);
				ps.setString(4, lccode);
			}
			count = ps.executeUpdate();
		} catch (Exception e) {
			 Debug.println("Exception in  insertAssetData of rws_Aug_Link_Mainscheme_Dao--"+e);
		}

		return count;
	}
}