package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class RwsWorkUpdationActionDAO {

	private static final String SCSP_11_B = "SCSP - 11(B)";
	private static final String TSP_11_B = "TSP - 11(B)";
	private static final String PLAIN_HAB = "Plain Hab";
	private static final String eleven_c = "11C";

	public void getWorkDetails(RwsWorkUpdationActionForm workForm,
			HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement ps = null,ps1 = null;
		ResultSet rs1 = null, rs4 = null;
		try {
			conn = RwsOffices.getConn();
			String compQuery = "select to_char(DATE_OF_COMPLETION,'dd/MM/yyyy') from rws_work_completion_tbl where work_id=? and DATE_OF_COMPLETION is not null";
			ps1=conn.prepareStatement(compQuery);
			ps1.setString(1, workForm.getWorkIdList());
			rs4 = ps1.executeQuery();
			if (rs4.next()) {
				request.setAttribute("message", "This Work is already Completed");
				reset(workForm);
			} else {
				
				workForm.setCompletionDate("-");
				String query = "select a.work_id,a.work_name,c.programme_name,d.subprogramme_name,to_char(a.ADMIN_DATE,'dd/MM/yyyy'),a.SANCTION_AMOUNT,co.circle_office_name,do.division_office_name ,special_cat,nvl(PROB_EXP ,0),nvl(PROB_EXP_NXT_YR,0) ,to_char(a.TARGET_DATE_COMP,'dd/MM/yyyy'),to_char(a.slccDate,'dd/MM/yyyy'),nvl(PROB_EXP_NXT_YR1,0),nvl(PROB_EXP_NXT_YR2,0),to_char(TARGET_UPDATE_DATE,'dd/mm/yyyy') as update_date  "
						+ "from rws_work_admn_tbl a ,rws_programme_tbl c,rws_subprogramme_tbl d,rws_circle_office_tbl co,rws_division_office_tbl do "
						+ "where a.work_id=? and a.PROGRAMME_CODE=c.PROGRAMME_CODE and a.PROGRAMME_CODE=d.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=d.SUBPROGRAMME_CODE  and co.circle_office_code=substr(a.office_code,2,2) and do.circle_office_code=co.circle_office_code and do.division_office_code=substr(a.office_code,4,1)";
				ps=conn.prepareStatement(query);
				ps.setString(1, workForm.getWorkIdList());
				rs1 = ps.executeQuery();
				while (rs1.next()) {
					workForm.setWorkid(rs1.getString(1));
					workForm.setWorkName(rs1.getString(2));
					workForm.setProgram(rs1.getString(3));
					workForm.setSubProgName(rs1.getString(4));
					workForm.setSanctionedDate(rs1.getString(5));
					workForm.setSanctionedAmount(rs1.getString(6));
					workForm.setCircle(rs1.getString(7));
					workForm.setDivision(rs1.getString(8));
					workForm.setSubplanSubmitted(rs1.getString(9));
					workForm.setProbExp(rs1.getString(10));
					workForm.setProbExpNextYear(rs1.getString(11));
					workForm.setProbDateOfComp(rs1.getString(12));
					workForm.setSlsccDate(rs1.getString(13));
					workForm.setpExp(rs1.getString(14));
					workForm.setpExp1(rs1.getString(15));

				}			
				ps.close();
				rs1.close();
				
				String groundQuery = "select to_char(GROUNDING_DATE,'dd/MM/yyyy') from rws_work_commencement_tbl where work_id=?";
				ps=conn.prepareStatement(groundQuery);
				ps.setString(1, workForm.getWorkIdList());
				rs1 = ps.executeQuery();
				if (rs1.next()) {
					workForm.setGroundingDate(rs1.getString(1));
				} else {
					workForm.setGroundingDate("-");
				}
				ps.close();
				rs1.close();
				
				DateFormat dateFormat = new SimpleDateFormat("yyyy");
				   java.util.Date date = new java.util.Date();
				   String today=dateFormat.format(date);
				   
				  int nextyear=Integer.parseInt(today)+1;
				   
				String expQuery = "select sum(case when (to_date(voucher_dt)< '01-APR-"+today+"') then voucher_Amt else 0 end)/100000,sum(case when (to_date(voucher_dt)>= '01-APR-"+today+"' and to_date(voucher_dt)< '01-APR-"+nextyear+"') then voucher_Amt else 0 end)/100000  FROM RWS_WORK_ADMN_TBL a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.work_id=? group by a.work_id";
				ps=conn.prepareStatement(expQuery);
				ps.setString(1, workForm.getWorkIdList());
				rs1 = ps.executeQuery();
				
				double expLast = 0, expCurrent = 0;
				if (rs1.next()) {
					expLast = Double.parseDouble(rs1.getString(1));
					expCurrent = Double.parseDouble(rs1.getString(2));
				}
				ps.close();
				rs1.close();
				
				DecimalFormat ndf1 = new DecimalFormat("##.##");
				workForm.setExpDuring(String.valueOf(ndf1.format(expCurrent)));
				double sancAmt = Double.parseDouble(String.valueOf(workForm.getSanctionedAmount()));
				double balEst = sancAmt - expLast;
				workForm.setBalanceEst(String.valueOf(ndf1.format(balEst)));
				String workId = workForm.getWorkIdList();
				String tabname = "";
				if (workId != null && workId.substring(6, 8).equals("11")) {
					tabname = "RWS_WORK_SCHOOL_LNK_TBL";
				} else {
					tabname = "rws_admn_hab_lnk_tbl";
				}
				String populationQuery = "select  sum(nvl(CENSUS_PLAIN_POPU,0)),sum(nvl(CENSUS_SC_POPU,0)),sum(nvl(CENSUS_ST_POPU,0)),a.work_id,count(*) from rws_work_admn_tbl a, "
						+ tabname
						+ "   b,rws_complete_hab_view c where a.work_id=b.work_id and b.hab_code=c.panch_code and a.work_id=? group by a.work_id";
				
				ps=conn.prepareStatement(populationQuery);
				ps.setString(1, workForm.getWorkIdList());
				rs1 = ps.executeQuery();
				
				int plainPop = 0, scPop = 0, stPop = 0;
				workForm.setSanctionHabs("0");
				if (rs1.next()) {
					plainPop += Integer.parseInt(rs1.getString(1));
					scPop += Integer.parseInt(rs1.getString(2));
					stPop += Integer.parseInt(rs1.getString(3));
					workForm.setSanctionHabs(rs1.getString(5));
				}
				workForm.setPlain(String.valueOf(plainPop));
				workForm.setSc(String.valueOf(scPop));
				workForm.setSt(String.valueOf(stPop));
				int totPop = plainPop + scPop + stPop;
				double plainPer = ((double) plainPop * 100 / (double) totPop);
				double scPer = ((double) scPop * 100 / (double) totPop);
				double stPer = ((double) stPop * 100 / (double) totPop);
				if (scPer >= 40) {
					workForm.setSpecialCatCode(SCSP_11_B);
				} else if (stPer >= 40) {
					workForm.setSpecialCatCode(TSP_11_B);

				} else if (scPop == 0 && stPop == 0) {

					workForm.setSpecialCatCode(PLAIN_HAB);
				} else if (plainPer >= 40) {

					workForm.setSpecialCatCode(eleven_c);
				}
			}
			ps.close();
			rs1.close();
			
		} catch (Exception e) {
			System.out.println("Exception in getWorkDetails:"+e);
		} finally {

			try {
				
				if (rs1 != null) {
					rs1.close();
				}
				
				if (rs4 != null) {
					rs4.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getWorkDetails:"+e);
			}

		}

	}


	public ArrayList getSanctionedHabs(String workId) {

		ArrayList habs = new ArrayList();
		ResultSet rs = null;
		PreparedStatement prpStmt = null;
		Connection conn = null;
		String sqlQuery = "";
		try {
			conn = RwsOffices.getConn();

			sqlQuery = "";
			if (workId != null && workId.substring(6, 8).equals("11")) {
				sqlQuery = "select b.dname,b.mname,b.pname,b.vname,b.panch_name,b.panch_code,b.coverage_status ,(nvl(c.CENSUS_PLAIN_POPU,0)+nvl(c.CENSUS_SC_POPU,0)+nvl(c.CENSUS_ST_POPU ,0)),nvl(AAP_TARGET_YEAR,'-') from RWS_WORK_SCHOOL_LNK_TBL  a,rws_complete_hab_view b,rws_habitation_directory_tbl c  where a.hab_code=b.panch_code and c.hab_code=b.panch_code and a.work_id=?";
			} else {
				sqlQuery = "select b.dname,b.mname,b.pname,b.vname,b.panch_name,b.panch_code,b.coverage_status ,(nvl(c.CENSUS_PLAIN_POPU,0)+nvl(c.CENSUS_SC_POPU,0)+nvl(c.CENSUS_ST_POPU ,0)),nvl(AAP_TARGET_YEAR,'-') from rws_admn_hab_lnk_tbl a,rws_complete_hab_view b,rws_habitation_directory_tbl c  where a.hab_code=b.panch_code and c.hab_code=b.panch_code and a.work_id=?";

			}

			prpStmt = conn.prepareStatement(sqlQuery);
			prpStmt.setString(1, workId);
			rs = prpStmt.executeQuery();

			nic.watersoft.commons.RwsLocationBean rwsLocation = null;
			while (rs.next()) {
				rwsLocation = new nic.watersoft.commons.RwsLocationBean();


				rwsLocation.setHabCode(rs.getString(6));
				rwsLocation.setHabName(rs.getString(5));
				rwsLocation.setPopulation(rs.getString(8));
				rwsLocation.setStatus(rs.getString(7));
				rwsLocation.setConstituencyName("-");
				rwsLocation.setMandalName(rs.getString(2));
				rwsLocation.setDistrictName(rs.getString(1));

				rwsLocation.setFacilities(rs.getString(9));
				if (rwsLocation.getFacilities() != null
						&& !rwsLocation.getFacilities().equals("-")) {
					rwsLocation.setHabMatch("checked");
				}
				if (workId.substring(6, 8).equals("11")) {
					rwsLocation
							.setSchoolCode(rs.getString(1) + rs.getString(7));
					rwsLocation.setSchoolName(rs.getString(8));
					rwsLocation.setSchoolLocation(rs.getString(9));
				}
				habs.add(rwsLocation);
			}

		} catch (SQLException e) {
			System.out.println("Exception in getSanctionedHabs:"+e);
			return null;
		} catch (Exception e) {
			System.out.println("Exception in getSanctionedHabs:"+e);
			return null;
		} finally {
			if (prpStmt != null)
				try {
					prpStmt.close();
				} catch (SQLException e) {
				}
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
				}
		}
		return habs;

	}


	public void updateWork(RwsWorkUpdationActionForm actionForm,
			HttpServletRequest request,String userId) {

		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = RwsOffices.getConn();
				String query = "update rws_work_admn_tbl set special_cat=? ,prob_exp=?,PROB_EXP_NXT_YR=?,TARGET_DATE_COMP=to_date(?,'dd/mm/yy'),SLCCDATE=to_date(?,'dd/mm/yy'),PROB_EXP_NXT_YR1=?,PROB_EXP_NXT_YR2=? where work_id=?";
					stmt = conn.prepareStatement(query);
					stmt.setString(1, actionForm.getSubplanSubmitted());
					stmt.setString(2, actionForm.getProbExp());
					stmt.setString(3, actionForm.getProbExpNextYear());
					stmt.setString(4, actionForm.getProbDateOfComp());
					stmt.setString(5, actionForm.getSlsccDate());
					stmt.setString(6, actionForm.getpExp());
					stmt.setString(7, actionForm.getpExp1());
					stmt.setString(8, actionForm.getWorkid());	
			int recCount = stmt.executeUpdate();
			if (recCount > 0) {
				request.setAttribute("message", "Updated Sucessfully");
			} else {
				request.setAttribute("message", "Updation Failed.");
			}

		} catch (Exception e) {
			System.out.println("Exception inupdateWork:"+e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception inupdateWork:"+e);
			}
		}

	}

	public ArrayList getProgramms(String circleCode, int divCode,
			String category) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement ps = null;
		ArrayList programs = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			String query = "";

			if (divCode != 0) {
				query = "select distinct a.programme_code,a.PROGRAMME_NAME from rws_programme_tbl a,rws_work_admn_tbl b,rws_contractor_selection_tbl c  where a.programme_code=b.programme_code and b.work_id=c.work_id and substr(office_code,2,2)=? and substr(office_code,4,1)=?  order by a.programme_code";
			} else {
				query = "select distinct a.programme_code,a.PROGRAMME_NAME from rws_programme_tbl a,rws_work_admn_tbl b,rws_contractor_selection_tbl c  where a.programme_code=b.programme_code and b.work_id=c.work_id and substr(office_code,2,2)=? order by a.programme_code";
			}
			
			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			if (divCode != 0) {				
				ps.setString(2, divCode+"");
			}
			
			rs = ps.executeQuery();

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				programs.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getProgramms:"+e);
		}
		finally {
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
		return programs;
	}

	public ArrayList getWorks(String circleCode, int divCode, String cat,
			String programCode) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs2 = null;
		ArrayList worksList = new ArrayList();

		DecimalFormat ndf = new DecimalFormat("##.##");
		try {
			String query = "";
			conn = RwsOffices.getConn();
			

			if (divCode != 0) {

				query = "select a.work_id,a.work_name from rws_work_admn_tbl a  where substr(a.office_code,2,2)=? and substr(a.office_code,4,1)=? and a.CATEGORY_CODE=? and a.WORK_CANCEL_DT is null and programme_code=? and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) ";
			} else {
				query = "select a.work_id,a.work_name from rws_work_admn_tbl a  where substr(a.office_code,2,2)=? and a.CATEGORY_CODE=? and a.WORK_CANCEL_DT is null and programme_code=? and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)   ";
			}

			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			if (divCode != 0) {				
				ps.setString(2, divCode+"");
				ps.setString(3, cat);
				ps.setString(4, programCode);
			}
			else{
				ps.setString(2, cat);
				ps.setString(3, programCode);
			}
			rs2 = ps.executeQuery();
			
			while (rs2.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs2.getString(1));
				labelValueBean.setLabel(rs2.getString(1) + "--"
						+ rs2.getString(2));
				worksList.add(labelValueBean);

			}

		} catch (Exception e) {
			System.out.println("Exception in getWorks:"+e);
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

	public void saveAAPTargetHabitations(RwsWorkUpdationActionForm actionForm,
			String[] habsList, HttpServletRequest request) {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String updateQuery = "";
			String targetFinYear = actionForm.getAapFinYear();

			String tabName = "";
			String workId = actionForm.getWorkid();

			if (workId != null && workId.substring(6, 8).equals("11")) {

				tabName = "RWS_WORK_SCHOOL_LNK_TBL ";
			} else {

				tabName = "rws_admn_hab_lnk_tbl";
			}

			updateQuery = "update " + tabName
					+ "  set AAP_TARGET_YEAR='' where work_id='"
					+ actionForm.getWorkid() + "'";
			stmt.addBatch(updateQuery);

			for (int i = 0; i < habsList.length; i++) {

				updateQuery = "update " + tabName + "  set AAP_TARGET_YEAR='"
						+ targetFinYear + "' where work_id='"
						+ actionForm.getWorkid() + "' and hab_code='"
						+ habsList[i] + "'";

				stmt.addBatch(updateQuery);
			}

			
			
			stmt.addBatch(updateQuery);
			int resCount[] = stmt.executeBatch();
			if (resCount.length > habsList.length) {
				conn.commit();
				conn.setAutoCommit(true);
				request.setAttribute("message", "Habs Added Successfully");
			} else {

				conn.setAutoCommit(true);
				request.setAttribute("message", "Operation Failed");
			}

		} catch (Exception e) {
			System.out.println("Exception in saveAAPTargetHabitations:"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in saveAAPTargetHabitations:"+e);
			}
		}

	}

	public ArrayList getFinYears() {

		ArrayList finYears = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {

			String finYear = "";
			conn = RwsOffices.getConn();
			
			String finYearQuery = "select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
			ps = conn.prepareStatement(finYearQuery);
			rs = ps.executeQuery();
			while (rs.next()) {

				String fy = rs.getString(1);
				int fy1 = Integer.parseInt(fy) + 1;
				LabelValueBean labelValueBean2 = new LabelValueBean();
				finYear = fy + "-" + String.valueOf(fy1);
				labelValueBean2.setLabel(finYear);
				labelValueBean2.setValue(finYear);
				finYears.add(labelValueBean2);

			}

		} catch (Exception e) {
			System.out.println("Exception in getFinYears:"+e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
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
		return finYears;
	}


	public void deleteAAPTargetHabitations(
			RwsWorkUpdationActionForm actionForm, String[] habsList,
			HttpServletRequest request) {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String updateQuery = "";
			String targetFinYear = "";

			String tabName = "";
			String workId = actionForm.getWorkid();

			if (workId != null && workId.substring(6, 8).equals("11")) {

				tabName = "RWS_WORK_SCHOOL_LNK_TBL ";
			} else {

				tabName = "rws_admn_hab_lnk_tbl";
			}

			for (int i = 0; i < habsList.length; i++) {

				updateQuery = "update " + tabName + "  set AAP_TARGET_YEAR='"
						+ targetFinYear + "' where work_id='"
						+ actionForm.getWorkid() + "' and hab_code='"
						+ habsList[i] + "'";

				stmt.addBatch(updateQuery);
			}
			int resCount[] = stmt.executeBatch();
			if (resCount.length == habsList.length) {
				conn.commit();
				conn.setAutoCommit(true);
				request.setAttribute("message",
						"Habitations Deleted Successfully");
			} else {

				conn.setAutoCommit(true);
				request.setAttribute("message", "Operation Failed");
			}

		} catch (Exception e) {
			System.out.println("Exception in deleteAAPTargetHabitations:"+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in deleteAAPTargetHabitations:"+e);
			}
		}

	}
	public void reset(RwsWorkUpdationActionForm actionForm) {

		actionForm.setWorkid("");
		actionForm.setCcode("");
		actionForm.setCircle("");
		actionForm.setMileStoneAmount("");
		actionForm.setWorkIdList("");
		actionForm.setWorkIdList1("");
		actionForm.setWorkid("");
		actionForm.setWorkName("");
		actionForm.setCircle("");
		actionForm.setDivision("");
		actionForm.setSanctionedAmount("");
		actionForm.setSanctionedDate("");
		actionForm.setProgram("");
		actionForm.setSubProgName("");
		actionForm.setMileStoneAmount("");
		actionForm.setCompletionDate("");
		actionForm.setBalanceEst("");
		actionForm.setCategory("");
		actionForm.setGroundingDate("");
		actionForm.setExpDuring("");
		actionForm.setPlain("");
		actionForm.setSc("");
		actionForm.setSt("");
		actionForm.setProbDateOfComp("");
		actionForm.setProbExp("");
		actionForm.setSpecialCatCode("");
		actionForm.setSubplanSubmitted("");
		actionForm.setProbExpNextYear("");
		actionForm.setSlsccDate("");
		actionForm.setpExp("");
		actionForm.setpExp1("");
		actionForm.setSanctionHabs("");
	}
}
