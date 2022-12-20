package nic.watersoft.works;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.zip.DataFormatException;
import java.util.zip.Inflater;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.proposals.workProposals;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;



//import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;

public class WorksData1 {
	Connection conn = null;
	Connection conn2 = null;
	Statement stmt = null;
	Statement stmt2 = null;
	PreparedStatement pstat = null;
	PreparedStatement pstat1 = null;
	PreparedStatement pstat2 = null;
	PreparedStatement ps = null;
	ResultSet rset = null;
	ResultSet rs = null;
	ResultSet rset1 = null;
	ResultSet rset2 = null;
	String query = null;
	String query1 = null;
	String query2 = null;
	int mworkstagecode = 0;
	int ans = 0;
	int noprop = 0;
	float prop = 0;
	int nopropclr = 0;
	float propcostclr = 0;
	int nonewworkssan = 0;
	int noaugworkssan = 0;
	float worktndrcost = 0;
	float totexplacs = 0;
	int nonewwksprog = 0;
	int noaugwksprog = 0;
	float totworkvalclr = 0;
	int nopchabscov = 0;
	int nonsshabscov = 0;
	int nopchabstar = 0;
	int nonsshabstar = 0;
	float costspwks = 0;
	float costongowks = 0;
	int totnowkscomp = 0;
	int totnowksgrd = 0;
	int totwksadmsanc = 0;
	int totwkstechsanc = 0;
	int totwkscompc = 0;
	float rel = 0;
	float exp = 0;
	private boolean flag;

	public WorksData1() {

		try {
			// DriverManager.registerDriver(new oracle.jdbc.OracleDriver());
			// conn =
			// DriverManager.getConnection("jdbc:oracle:thin:@10.160.:1521:oracle10","preduser","preduser");
		} catch (Exception e) {
			Debug.println("Exception in WorksData():" + e);
		}
	}

	public WorksData1(DataSource dataSource) {
		try {
			// conn = dataSource.getConnection();
		} catch (Exception e) {
			Debug.println("Exception in WorksData(datasource):" + e);
		}
	}

	public int getWorkStageCode(DataSource dataSource) throws Exception {
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT max(work_stage_code) as workstagecode FROM rws_work_stage_tbl ";
			rset = stmt.executeQuery(query);
			if (rset.next()) {
				mworkstagecode = rset.getInt("workstagecode") + 1;
			} else {
				mworkstagecode = 1;
			}
		} catch (Exception e) {
			Debug.println("Exception in getWorkStageCode():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return mworkstagecode;
	}

	public ArrayList viewSchoolList(String district, String mandal,
			String panchayat, String village, String hab) throws Exception {

		ArrayList list = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null,rs1 = null;
		try {
		conn = RwsOffices.getConn();
		String qq = "select * from RWS_SCHOOL_ASSET_LNK_TBL where hab_code in (?) and asset_code=?";
		ps=conn.prepareStatement(qq);
		ps.setString(1, hab.substring(0, hab.length() - 1));
		ps.setString(2, district);
		rs1 = ps.executeQuery();
		Collection c = new ArrayList();
		while (rs1.next()) {
			c.add(rs1.getString(1) + rs1.getString(2) + rs1.getString(3));
		}
		rs1.close();
		String query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,RAJ.Panch_CODE,raj.panch_name,sm.SCHOOL_CODE,sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME, nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0)  from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code  and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and  substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status<>'UI' and hd.coverage_status is not null";
		
			if (district != null && !district.equals("")) {
				query += " and substr(raj.panch_code,1,2)='"
						+ district.substring(4, 6) + "' ";
			}
			if (mandal != null && !mandal.equals("")) {
				query += " and substr(raj.panch_code,6,2)='" + mandal + "' ";
			}
			if (panchayat != null && !panchayat.equals("")) {
				query += " and substr(raj.panch_code,13,2)='" + panchayat
						+ "' ";
			}
			if (village != null && !village.equals("")) {
				query += " and substr(raj.panch_code,8,3)='" + village + "' ";
			}
			if (hab != null && !hab.equals("")) {
				query += " and raj.panch_code in ("
						+ hab.substring(0, hab.length() - 1) + ")";
			}
			query += " order by raj.panch_name,sm.school_code ";
			ps=conn.prepareStatement(query);
			rs = ps.executeQuery();

			while (rs.next()) {
				rws_works_WorkStatus_bean bean = new rws_works_WorkStatus_bean();
				if (c.contains(rs.getString(9) + rs.getString(11) + district)) {
					bean.setAlreadyExists("Y");
				} else {
					bean.setAlreadyExists("N");
				}
				bean.setSchoolHabCode(rs.getString(9) + rs.getString(11));
				bean.setPanchayat(rs.getString(6));
				bean.setVillage(rs.getString(8));
				bean.setHabitation(rs.getString(9));
				bean.setHabName(rs.getString(10));
				bean.setSchoolCode(rs.getString(11));
				bean.setSchoolName(rs.getString(12));
				bean.setCategory(rs.getString(13));
				bean.setClassification(rs.getString(14));
				bean.setTotStudents(rs.getString(15));
				list.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in viewSchoolList"+e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return list;
	}

	public String getSchemeName(DataSource ds, String scheme) throws Exception {

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select TYPE_OF_ASSET_NAME from "
					+ "rws_asset_type_tbl where TYPE_OF_ASSET_CODE ='" + scheme
					+ "'");
			if (rs.next()) {
				scheme = rs.getString(1);
			} else {
				scheme = "";
			}

		} catch (Exception e) {
			if (conn != null)
				conn.close();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return scheme;
	}

	public float getAdminAmount(DataSource ds, String workId) {
		float revAmnt;
		revAmnt = 0.0F;
		try {
			conn = RwsOffices.getConn();
			String query="select (select nvl(SANCTION_AMOUNT,0) from  rws_work_admn_tbl where work_id=?)a,"
					+ "(select nvl(SANCTION_AMOUNT,'0' ) from RWS_WORK_ADMN_PROG_LNK_TBL where work_id=?)b from dual";
			ps=conn.prepareStatement(query);
			ps.setString(1, workId);
			ps.setString(2, workId);
			rs = ps.executeQuery();
			if (rs.next())
				revAmnt = rs.getFloat(1) + rs.getFloat(2);

		} catch (Exception e) {
			Debug.println("Exception in getAdminAmount:" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return revAmnt;
	}

	public int InsertWorkStage(DataSource dataSource, int workstagecode,
			String workstagename) throws Exception {
		try {
			ans = 0;
			conn = RwsOffices.getConn();
			query = " INSERT INTO rws_work_stage_tbl VALUES (?,?)";
			pstat = conn.prepareStatement(query);
			pstat.setInt(1, workstagecode);
			pstat.setString(2, workstagename);

			ans = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception in InsertWorkStage():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ans;
	}

	public ArrayList WorkStageList(DataSource dataSource) {
		ArrayList workstages = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT work_stage_code, work_stage FROM rws_work_stage_tbl ORDER BY work_stage";
			rset = stmt.executeQuery(query);
			WorkStageBean wStageBean = null;
			while (rset.next()) {
				wStageBean = new WorkStageBean();
				wStageBean.setWorkStageCode(rset.getInt("work_stage_code"));
				wStageBean.setWorkStageName(rset.getString("work_stage"));
				workstages.add(wStageBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in WorkStageList():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return workstages;
	}

	public ArrayList PopCircles(DataSource dataSource, String circlecode)
			throws Exception {
		ArrayList circles = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT circle_office_code,circle_office_name FROM rws_circle_office_tbl where circle_office_code = '"
					+ circlecode + "' order by circle_office_code";
			rset = stmt.executeQuery(query);
			Circle circle = null;
			circles = new ArrayList();
			while (rset.next()) {
				circle = new Circle();
				circle.setCode(rset.getString("circle_office_code"));
				circle.setName(rset.getString("circle_office_name"));

				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception in PopCircles():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return circles;
	}

	public ArrayList PopCircles(DataSource dataSource) throws Exception {
		ArrayList circles = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT circle_office_code,circle_office_name FROM rws_circle_office_tbl order by circle_office_code";
			rset = stmt.executeQuery(query);
			Circle circle = null;
			circles = new ArrayList();
			while (rset.next()) {
				circle = new Circle();
				circle.setCode(rset.getString("circle_office_code"));
				circle.setName(rset.getString("circle_office_name"));

				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception in PopCircles(datasource):" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return circles;
	}

	public ArrayList DivisionCombo(DataSource dataSource) {
		ArrayList circles = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select distinct substr(ne.office_code,2,2) as circleoffcode,circle_office_name  from rws_new_est_tbl ne,"
					+ " rws_circle_office_tbl co where substr(ne.office_code,2,2)=co.circle_office_code order by substr(ne.office_code,2,2)";
			rset = stmt.executeQuery(query);
			Circle circle = null;
			circles = new ArrayList();
			while (rset.next()) {
				circle = new Circle();
				circle.setCode(rset.getString(1));
				circle.setName(rset.getString(2));

				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception in DivisionCombo(datasource):" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return circles;
	}

	// --------------------------------------------------------------------------------------------------
	// tender memo
	public ArrayList tenderMemoList(DataSource dataSource) {
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT OFFICE_ISSUED_FROM ,OFFICE_ISSUED_TO ,WORK_ID ,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') as DATE_OF_COMPLETION  FROM rws_tender_memo_tbl order by WORK_ID";
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setOffissuedfrom(rset
						.getString("OFFICE_ISSUED_FROM"));
				tendermemo.setOffissuedto(rset.getString("OFFICE_ISSUED_TO"));
				tendermemo.setWorkid(rset.getString("WORK_ID"));
				tendermemo.setDateofcomp(rset.getString("DATE_OF_COMPLETION"));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in tenderMemoList():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	// --------------------------------------------------------------------------------------------------

	public ArrayList PopDivisions(DataSource dataSource, String circlecode,
			int divisioncode) {
		ArrayList divisions = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT division_office_code,division_office_name FROM rws_division_office_tbl where circle_office_code = ? and division_office_code = ? order by circle_office_code";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);
			pstat.setInt(2, divisioncode);
			rset = pstat.executeQuery();
			Division division = null;
			divisions = new ArrayList();
			while (rset.next()) {
				division = new Division();
				division.setCode(rset.getInt("division_office_code"));
				division.setName(rset.getString("division_office_name"));
				divisions.add(division);
			}
		} catch (Exception e) {
			Debug.println("Exception in PopDivisions():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return divisions;
	}

	public ArrayList PopDivisions(DataSource dataSource, String circlecode) {
		ArrayList divisions = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT division_office_code,division_office_name FROM rws_division_office_tbl where circle_office_code = ? order by circle_office_code";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);

			rset = pstat.executeQuery();
			Division division = null;
			divisions = new ArrayList();
			while (rset.next()) {
				division = new Division();
				division.setCode(rset.getInt("division_office_code"));
				division.setName(rset.getString("division_office_name"));
				divisions.add(division);
			}
		} catch (Exception e) {
			Debug.println("Exception in PopDivisions(): " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return divisions;
	}

	public ArrayList PopSubDivisions(DataSource dataSource, String circlecode,
			int divisioncode, String subdivisioncode) {
		ArrayList subdivisions = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT subdivision_office_code,subdivision_office_name FROM rws_subdivision_office_tbl where circle_office_code = ? AND division_office_code = ? and subdivision_office_code = ? order by circle_office_code";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);
			pstat.setInt(2, divisioncode);
			pstat.setString(3, subdivisioncode);
			rset = pstat.executeQuery();
			SubDivision subdivision = null;
			subdivisions = new ArrayList();
			while (rset.next()) {
				subdivision = new SubDivision();
				subdivision.setCode(rset.getString("subdivision_office_code"));
				subdivision.setName(rset.getString("subdivision_office_name"));
				subdivisions.add(subdivision);
			}
		} catch (Exception e) {
			Debug.println("Exception in PopSubDivisions():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return subdivisions;
	}

	// -----------------------
	public ArrayList PopSubDivisions(DataSource dataSource, String circlecode,
			int divisioncode) {
		ArrayList subdivisions = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT subdivision_office_code,subdivision_office_name FROM rws_subdivision_office_tbl where circle_office_code = ? AND division_office_code = ? order by circle_office_code";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);
			pstat.setInt(2, divisioncode);

			rset = pstat.executeQuery();
			SubDivision subdivision = null;
			subdivisions = new ArrayList();
			while (rset.next()) {
				subdivision = new SubDivision();
				subdivision.setCode(rset.getString("subdivision_office_code"));
				subdivision.setName(rset.getString("subdivision_office_name"));
				subdivisions.add(subdivision);
			}
		} catch (Exception e) {
			Debug.println("Exception in PopSubDivisions():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return subdivisions;
	}

	// -----------------------
	public ArrayList PopProgramme(DataSource dataSource) {
		ArrayList programmes = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT programme_code,programme_name FROM rws_programme_tbl order by programme_code";
			rset = stmt.executeQuery(query);
			Programme programme = null;
			programmes = new ArrayList();
			while (rset.next()) {
				programme = new Programme();
				programme.setCode(rset.getString("programme_code"));
				programme.setName(rset.getString("programme_name"));

				programmes.add(programme);
			}

		} catch (Exception e) {
			Debug.println("Exception in PopProgramme():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return programmes;
	}

	// public ArrayList PopSubProgramme(DataSource dataSource, String
	// programmecode)
	public ArrayList PopSubProgramme(DataSource dataSource, String circleCode,
			String Pcode, int div) {
		ArrayList subprogrammes = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT distinct wa.subprogramme_code,sp.subprogramme_name FROM rws_work_admn_tbl wa,"
					+ " rws_subprogramme_tbl sp where wa.programme_code = sp.programme_code "
					+ "and wa.subprogramme_code = sp.subprogramme_code and substr(wa.office_code,2,2)"
					+ " = '"
					+ circleCode
					+ "'  and substr(wa.work_id,1,2)='"
					+ Pcode + "'";
			if (div != 0) {
				query = query + " and substr(wa.office_code,4,1)=" + div + "";
			}
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			// pstat.setString(1,programmecode);
			rset = pstat.executeQuery();
			Subprogramme subprogramme = null;
			subprogrammes = new ArrayList();
			while (rset.next()) {
				subprogramme = new Subprogramme();
				subprogramme.setCode(rset.getString("subprogramme_code"));
				subprogramme.setName(rset.getString("subprogramme_name"));
				subprogrammes.add(subprogramme);
			}
		} catch (Exception e) {
			Debug.println("Exception in PopSubProgramme():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return subprogrammes;
	}

	public ArrayList getHabitations(DataSource dataSource, String dcode)
			throws Exception {
		ArrayList habitations = null;
		workProposals workProp = null;
		String query = " select  c.CONSTITUENCY_NAME,m.mname,h.hab_code,pr.panch_name , "
				+ "H.census_plain_popu + H.census_sc_popu + H.census_st_popu as Population,"
				+ "h.coverage_status ,c.CONSTITUENCY_CODE ,m.mcode from rws_habitation_directory_tbl h,RWS_CONSTITUENCY_TBL "
				+ "c,rws_mandal_tbl m,rws_panchayat_raj_tbl pr where m.mcode=substr(h.hab_code,6,2)"
				+ " and m.dcode=substr(h.hab_code,1,2) and c.CONSTITUENCY_CODE=substr(h.hab_code,3,3)and"
				+ "  pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"
				+ dcode + "'";
		Debug.println("Query is" + query);
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			habitations = new ArrayList();
			while (rset.next()) {
				Debug.println("in while");
				workProp = new workProposals();
				workProp.setAssemblyName(rset.getString(1));
				workProp.setMandalName(rset.getString(2));
				workProp.setHabCode(rset.getString(3));
				workProp.setHabName(rset.getString(4));
				workProp.setPopulation(rset.getString(5));
				workProp.setCovStatus(rset.getString(6));
				workProp.setAssemblyCode(rset.getString(7));
				workProp.setMandalCode(rset.getString(8));
				habitations.add(workProp);
			}
			Debug.println("habitations" + habitations.size());
		}

		catch (Exception e) {
			Debug.println("Exception e" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return habitations;
	}

	public ArrayList getHabitations(DataSource dataSource, String dcode,
			String[] habs, String proposalId) throws Exception {
		ArrayList habitations = null;
		workProposals workProp = null;
		try {
			habitations = new ArrayList();
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			for (int i = 1; i < habs.length; i++) {
				String query = " select  c.CONSTITUENCY_NAME,m.mname,h.hab_code,pr.panch_name , "
						+ "H.census_plain_popu + H.census_sc_popu + H.census_st_popu as Population,"
						+ "h.coverage_status ,c.CONSTITUENCY_CODE ,m.mcode from rws_habitation_directory_tbl h,RWS_CONSTITUENCY_TBL "
						+ "c,rws_mandal_tbl m,rws_panchayat_raj_tbl pr where m.mcode=substr(h.hab_code,6,2)"
						+ " and m.dcode=substr(h.hab_code,1,2) and c.CONSTITUENCY_CODE=substr(h.hab_code,3,3)and"
						+ "  pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"
						+ dcode + "' and h.hab_code='" + habs[i] + "'";
				Debug.println("Query is" + query);

				rset = stmt.executeQuery(query);

				while (rset.next()) {

					workProp = new workProposals();
					workProp.setProposalId(proposalId);
					workProp.setAssemblyName(rset.getString(1));
					workProp.setMandalName(rset.getString(2));
					workProp.setHabCode(rset.getString(3));
					workProp.setHabName(rset.getString(4));
					workProp.setPopulation(rset.getString(5));
					workProp.setCovStatus(rset.getString(6));
					workProp.setAssemblyCode(rset.getString(7));
					workProp.setMandalCode(rset.getString(8));
					habitations.add(workProp);
				}
				Debug.println("habitations" + habitations.size());
			}
		}

		catch (Exception e) {
			Debug.println("Exception e" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return habitations;
	}

	// -----------------------

	public ArrayList getFinancialYears() {
		ArrayList financialYears = new ArrayList();
		java.util.Calendar cal = new java.util.GregorianCalendar();
		int currentYear = cal.get(Calendar.YEAR);
		for (int count = 0; count < 5; count++) {
			String years = String.valueOf(currentYear + count - 4);
			financialYears.add(years);
		}
		return financialYears;
	}

	public ArrayList getMonth(DataSource dataSource) {
		ArrayList months = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select month_code,month_name from rws_month_mast_tbl order by month_code";
			rset = stmt.executeQuery(query);
			Month month = null;
			months = new ArrayList();
			while (rset.next()) {
				month = new Month();
				month.setCode(rset.getString("month_code"));
				month.setName(rset.getString("month_name"));
				months.add(month);
			}

		} catch (Exception e) {
			Debug.println("Exception in getMonth():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return months;
	}

	public String getDate() {
		// String date=DateFormat.getInstance().format(new Date());
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String datenewformat = formatter.format(date);
		// DateFormat.getDateInstance(DateFormat.SHORT).format(date);

		return datenewformat;
	}

	public String getMonthName(DataSource dataSource, String monthcode) {
		String monthName = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT month_name FROM rws_month_mast_tbl WHERE month_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, monthcode);
			rset = pstat.executeQuery();
			if (rset.next()) {
				monthName = rset.getString("month_name");
			}
			if (rset != null)
				rset.close();
		} catch (Exception e) {
			Debug.println("Exception in getMonthName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return monthName;
	}

	public String getcircleName(DataSource dataSource, String circleCode) {

		String circleName = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT circle_office_name FROM RWS_CIRCLE_OFFICE_TBL  WHERE CIRCLE_OFFICE_CODE = ? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circleCode);

			rset = pstat.executeQuery();
			if (rset.next()) {

				circleName = rset.getString("circle_office_name");
			}
			if (rset != null)
				rset.close();
		} catch (Exception e) {
			Debug.println("Exception getcircleName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return circleName;
	}

	public ArrayList getCancelWorks(DataSource dataSource, String circle,
			String div, String programmeCode, String subprogrammeCode,
			String plan, String wrkType, String workCat) throws Exception {

		ArrayList worksfordeletion = null;
		try {
			conn = RwsOffices.getConn();
			
			query = " select  work_id,b.work_name,programme_name,subprogramme_name,admin_no,to_char(admin_date,'dd/MM/yyyy')as admin_date,sanction_amount,no_of_habs,to_char(WORK_CANCEL_DT,'dd/MM/yyyy')as WORK_CANCEL_DT from rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl s where  b.programme_code=p.programme_code and p.programme_code=s.programme_code  and b.subprogramme_code=s.subprogramme_code and WORK_CANCEL_DT  is not null"
					+ " and substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and  CATEGORY_CODE=? ";

			if (plan != null && !plan.equals("")) {
				query += " and PLAN_CODE =?";
			}
			if (wrkType != null && !wrkType.equals("")) {
				query += " and AUG_NEW_CODE =?";
			}
			if (programmeCode != null && !programmeCode.equals("")) {
				query += " and b.PROGRAMME_CODE =?";
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				query += " and b.SUBPROGRAMME_CODE =?";
			}

			ps = conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, div);
			ps.setString(3, workCat);
			
			
			if (plan != null && !plan.equals("")) {
				ps.setString(4, plan);
			}
			if (wrkType != null && !wrkType.equals("")) {
				ps.setString(5, wrkType);
			}
			if (programmeCode != null && !programmeCode.equals("")) {
				ps.setString(6, programmeCode);
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				ps.setString(7, subprogrammeCode);
			}
			rset = ps.executeQuery();
			
			tenderMemo tendermemo = null;
			worksfordeletion = new ArrayList();

			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setWorkname(rset.getString("WORK_NAME"));
				tendermemo.setWorkid(rset.getString("WORK_ID"));
				tendermemo.setSanctionno(rset.getString("ADMIN_NO"));
				tendermemo.setSanctiondt(rset.getString("ADMIN_DATE"));
				tendermemo.setSanctionamount(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setNoofhabs(rset.getString("NO_OF_HABS"));
				tendermemo.setWrkCanDate(rset.getString("WORK_CANCEL_DT"));
				worksfordeletion.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in getCancelWorks:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksfordeletion;

	}

	public ArrayList getWorksforDeletion(DataSource dataSource, String circle,
			String div, String programmeCode, String subprogrammeCode,
			String plan, String wrkType, String workCat) throws Exception {
		ArrayList worksfordeletion = null;
		try {
			conn = RwsOffices.getConn();
			
			query = " SELECT WORK_NAME,WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s "
					+ "where substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and PLAN_CODE =? and AUG_NEW_CODE =? and CATEGORY_CODE=? and a.PROGRAMME_CODE=p.PROGRAMME_CODE and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE ";
			if (programmeCode != null && !programmeCode.equals("")) {
				query = query + " and a.PROGRAMME_CODE=?";
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				query = query + " and a.SUBPROGRAMME_CODE=?";
			}
			query = query + " order by plan_code";
			ps = conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, div);
			ps.setString(3, plan);
			ps.setString(4, wrkType);
			ps.setString(5, workCat);
			if (programmeCode != null && !programmeCode.equals("")) {
				ps.setString(6, programmeCode);
			}
			if (subprogrammeCode != null && !subprogrammeCode.equals("")) {
				ps.setString(7, subprogrammeCode);
			}
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			worksfordeletion = new ArrayList();

			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setWorkname(rset.getString("WORK_NAME"));
				tendermemo.setWorkid(rset.getString("WORK_ID"));
				tendermemo.setSanctionno(rset.getString("ADMIN_NO"));
				tendermemo.setSanctiondt(rset.getString("ADMIN_DATE"));
				tendermemo.setSanctionamount(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setNoofhabs(rset.getString("NO_OF_HABS"));
				worksfordeletion.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in getWorksforDeletion(datasource):" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksfordeletion;
	}

	public ArrayList getHabs(DataSource dataSource, String workId) {
		ArrayList habitations = new ArrayList();
		Connection conn = null;
		
		ResultSet rset = null;
		try {
			query = " SELECT PR.panch_code, PR.panch_name, "
					+ " m.mname FROM rws_panchayat_raj_tbl PR, "
					+ " rws_habitation_directory_tbl HD, RWS_ADMN_HAB_LNK_TBL  HL,rws_mandal_tbl m "
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
				habitations.add(rwsLocationBean);
			}
		} catch (Exception e) {
			Debug.writeln("Exception in getSelectedHabitations :" + e);
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

	public static boolean checkWorkInProjectShelf(String workid,
			Connection connn) {
		boolean flag = false;
		try {

			String qry = "select * from   RWS_DDWS_SCHEME_DATA_PORT where WORK_ID=? and WORK_ASSET='W'";
			PreparedStatement ps=connn.prepareStatement(qry);
			ps.setString(1, workid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			Debug.println("Exception in checkWorkInProjectShelf:"+e);
		}
		return flag;
	}

	public static boolean checkWorkInAAP(String workid, Connection connn) {
		boolean flag = false;
		try {

			String qry = "select * from   rws_aap_selected_tbl where WORK_ID=?";
			PreparedStatement ps=connn.prepareStatement(qry);
			ps.setString(1, workid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			 Debug.println("Exception in checkWorkInAAP:"+e);
		}
		return flag;
	}

	public static boolean checkWorkCommissioned(String workid, Connection connn) {
		boolean flag = false;
		try {

			String qry = "select * from rws_work_completion_tbl where WORK_ID=? and (DATE_OF_COMPLETION is not null or DATE_OF_COMM is not null)";
			PreparedStatement ps=connn.prepareStatement(qry);
			ps.setString(1, workid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			 Debug.println("Exception in this function:"+e);
		}
		return flag;
	}

	public static boolean checkBills(String workid, Connection connn) {
		boolean flag = false;
		try {

			String qry = "select * from rws_work_bill_tbl where WORK_ID=?";
			PreparedStatement ps=connn.prepareStatement(qry);
			ps.setString(1, workid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			 Debug.println("Exception in checkBills:"+e);
		}
		return flag;
	}

	public static boolean checkMileStone(String workid, Connection connn) {
		boolean flag = false;
		try {

			String qry = "select * from RWS_MILESTONE_TARGET_ACH_TBL where WORK_ID=?";
			PreparedStatement ps=connn.prepareStatement(qry);
			ps.setString(1, workid);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				flag = true;
		} catch (Exception e) {
			 Debug.println("Exception in checkMileStone:"+e);
		}
		return flag;
	}

	public int workDelete(DataSource dataSource, String workid, String date) {
		int count = 0, delete = 0;
		Statement st1 = null, newst = null;
		ResultSet rs = null;
		String workname = "", officecode = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			if (!checkWorkInProjectShelf(workid, conn)) {
				if (!checkWorkInAAP(workid, conn)) {
					if (!checkWorkCommissioned(workid, conn)) {
						if (!checkMileStone(workid, conn)) {
							if (!checkBills(workid, conn)) {

								st1 = conn.createStatement();
								newst = conn.createStatement();

								query = "Select work_name,OFFICE_CODE from rws_work_admn_tbl where WORK_ID ='"
										+ workid + "'";
								rs = newst.executeQuery(query);
								while (rs.next()) {
									workname = rs.getString("work_name");
									officecode = rs.getString("OFFICE_CODE");
								}
								String qry1 = "delete from RWS_DDWS_WORK_FIELDS_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry1);
								
								String qry2 = "delete from  RWS_DDWS_SUBMISSION_WQ_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry2);
								
								String qry3 = "delete from RWS_work_comp_hab_lnk_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry3);
								
								String qry4 = "delete from rws_work_completion_tbl where WORK_ID='"
										+ workid + "'";								
								st1.addBatch(qry4);
								
								String qry5 = "delete from RWS_WORK_COMMENCEMENT_TBL where WORK_ID='"
										+ workid + "'";							
								st1.addBatch(qry5);
								
								
								String qry6 = "delete from RWS_EOAT_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry6);
								
								String qry7 = "delete from rws_work_exp_upto_pre_year_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry7);

								String qry8 = "delete from RWS_WORK_EXPENDITURE_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry8);

								String qry9 = "delete from RWS_MILESTONE_TARGET_ACH_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry9);

								String qry10 = "delete from RWS_CONTRACTOR_SELECTION_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry10);

								String qry11a = "delete from  rws_WQ_test_results_lnk_tbl where test_id =(select test_id from rws_wq_test_results_tbl where source_code =(select source_code from rws_source_iden_fin_tbl where  work_id='"
										+ workid + "'))";
								st1.addBatch(qry11a);

								String qry11b = "delete from rws_wq_test_results_tbl  where source_code =(select source_code from rws_source_iden_fin_tbl where  work_id='"
										+ workid + "')";
								st1.addBatch(qry11b);

								String qry11c = "delete from  rws_ftk_testing_tbl where source_code =(select source_code from rws_source_iden_fin_tbl where  work_id='"
										+ workid + "')";
								st1.addBatch(qry11c);

								String qry11d = "delete from  rws_water_sample_collect_tbl where source_code =(select source_code from rws_source_iden_fin_tbl where  work_id='"
										+ workid + "')";
								st1.addBatch(qry11d);

								String qry11 = "delete from rws_source_iden_fin_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry11);

								String qry12 = "delete from rws_source_tbl where asset_code='"
										+ workid + "'";
								st1.addBatch(qry12);

								String qry13 = "delete from rws_tender_notification_tbl where tender_idno = (select tender_idno from rws_tender_appl_tbl where WORK_ID='"
										+ workid + "')";
								st1.addBatch(qry13);

								String qry14 = "delete from rws_tender_appl_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry14);

								String qry15 = "delete from RWS_NEW_REVISED_EST_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry15);

								String qry16 = "delete from RWS_REV_EST_NEW_HAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry16);

								String qry17 = "delete from RWS_REVISED_ADM_PROG_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry17);

								String qry18 = "delete from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry18);

								String qry19 = "delete from RWS_REVISED_ADM_SANC_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry19);

								String qry20 = "delete from RWS_WORK_ADMN_PROG_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry20);

								String qry21 = "delete from RWS_ADMN_HAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry21);

								String qry22 = "delete from RWS_NEW_EST_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry22);
								
								String qry23 = "delete from RWS_EST_NEW_HAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry23);
								
								String qry24 = "delete from RWS_REV_SCHOOL_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry24);
								
								String qry25 = "delete from RWS_WORK_SCHOOL_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry25);
								
								String qry26 = "delete from RWS_REV_LAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry26);
								
								String qry27 = "delete from RWS_WORK_LAB_LNK_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry27);
								
								String qry28 = "delete from  RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry28);
								
								String qry29 = "delete from  RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry29);
								
								String qry30 = "delete from RWS_BILL_BANK_BRIDGE_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry30);
								
								String qry31 = "delete from RWS_WORK_EXP_VOUCHER_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry31);
								
								String qry32 = "delete from rws_work_image_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry32);
								
								String qry33 = "delete from RWS_WORK_OFFICE_CHANGE_TBL where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qry33);
								
								String qrylast = "delete from rws_work_admn_tbl where WORK_ID='"
										+ workid + "'";
								st1.addBatch(qrylast);

								String qryins = "insert into rws_works_deleted_tbl(WORK_ID,WORK_NAME,DELETED_DATE,OFFICE_CODE) values('"
										+ workid
										+ "','"
										+ workname
										+ "',to_date('"
										+ date
										+ "','dd/mm/yyyy'),'"
										+ officecode
										+ "')";
								st1.addBatch(qryins);

								int[] countt = st1.executeBatch();
								count = countt.length;
								if (count > 0) {
									conn.setAutoCommit(true);
									conn.commit();
								}
							} else {
								count = -5;
							}
						} else {
							count = -4;
						}
					} else {
						count = -3;
					}
				} else {
					count = -2;
				}
			} else {
				count = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
				 Debug.println("Exception in workDelete:"+e);
			} catch (SQLException e1) {
			}
		} finally {
			try {

				if (st1 != null)
					st1.close();
				if (rs != null)
					rs.close();
				if (newst != null)
					newst.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				 Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());
			}
		}
		return count;
	}

	public String getdivisionName(DataSource dataSource, String circleCode,
			int divisionCode) {

		String divisionName = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT division_office_name FROM RWS_division_OFFICE_TBL  WHERE CIRCLE_OFFICE_CODE = ? and division_office_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circleCode);
			pstat.setInt(2, divisionCode);
			rset = pstat.executeQuery();
			if (rset.next()) {

				divisionName = rset.getString("division_office_name");
			}
			if (rset != null)
				rset.close();
		} catch (Exception e) {
			Debug.println("Exception getdivisionName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		{
			releaseConnection();

		}
		return divisionName;
	}

	public String getsubDivisionName(DataSource dataSource, String circleCode,
			int divisionCode, String subdivisionCode) {

		String subdivisionName = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT subdivision_office_name FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = ? and DIVISION_OFFICE_CODE = ? and subdivision_office_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circleCode);
			pstat.setInt(2, divisionCode);
			pstat.setString(3, subdivisionCode);
			rset = pstat.executeQuery();
			if (rset.next()) {

				subdivisionName = rset.getString("subdivision_office_name");
			}
			if (rset != null)
				rset.close();
		} catch (Exception e) {
			Debug.println("Exception getsubDivisionName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return subdivisionName;
	}

	public String getprogrammeName(DataSource dataSource, String programmeCode) {

		String programmeName = "";
		try {
			conn = RwsOffices.getConn();
			query = " SELECT programme_name FROM rws_programme_tbl  WHERE programme_code = ? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, programmeCode);
			rset = pstat.executeQuery();
			if (rset.next()) {

				programmeName = rset.getString("programme_name");
			}
		} catch (Exception e) {
			Debug.println("Exception getprogrammeName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}

		}

		return programmeName;
	}

	public String getsubprogrammeName(DataSource dataSource,
			String programmeCode, String subprogrammeCode) {
		String query = "";
		String subprogrammeName = "";
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT subprogramme_name FROM rws_subprogramme_tbl  WHERE programme_code = ? and subprogramme_code = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, programmeCode);
			pstat.setString(2, subprogrammeCode);
			rset = pstat.executeQuery();
			if (rset.next()) {
				subprogrammeName = rset.getString("subprogramme_name");
			}
		} catch (Exception e) {
			Debug.println("Exception getsubprogrammeName():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return subprogrammeName;
	}

	public int CheckPhysicalProgress(DataSource dataSource, String officecode,
			String assettype, String month, String year) {
		int no_pp = 0;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT count(*) as cnt from rws_physical_progress_tbl where office_code=? and asset_type=? and month=? and year=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);
			pstat.setString(2, assettype);
			pstat.setString(3, month);
			pstat.setString(4, year);
			rset = pstat.executeQuery();
			if (rset.next()) {
				if (rset.getInt("cnt") > 0) {
					no_pp = rset.getInt("cnt");
				}
			}
		} catch (Exception e) {
			Debug.println("Exception CheckPhysicalProgress(): " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public PhysicalProgressActionBean RetrievedurmonPhysicalProgress(
			DataSource dataSource, String officecode, String assettype,
			String month, String year) {
		PhysicalProgressActionBean progressActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT entered_by, to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE, NO_PROPOSAL_UPTO_MON, NO_PROPOSAL_DUR_MON, PROPOSAL_COST_UPTO_MON, PROPOSAL_COST_DUR_MON, NO_PROPOSAL_CLR_UPTO_MON, NO_PROPOSAL_CLR_DUR_MON, PROPOSAL_COST_CLR_UPTO_MON, PROPOSAL_COST_CLR_DUR_MON, NO_NEW_WORKS_SANC_UPTO_MON, NO_NEW_WORKS_SANC_DUR_MON, NO_AUG_WORKS_SANC_UPTO_MON,NO_AUG_WORKS_SANC_DUR_MON,WORK_TENDER_COST_DUR_MON,WORK_TENDER_COST_UPTO_MON ,TOT_EXP_INLAKHS_DUR_MON ,TOT_EXP_INLAKHS_UPTO_MON ,NO_NEW_WORKS_INPROG_DUR_MON ,NO_NEW_WORKS_INPROG_UPTO_MON ,NO_AUG_WORKS_INPROG_DUR_MON ,NO_AUG_WORKS_INPROG_UPTO_MON ,PER_PHY_PROGRESS ,PER_OF_OVERALL_EXP ,TOTAL_WORK_VAL_CLEAR_DUR_MON ,TOTAL_WORK_VAL_CLEAR_UPTO_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ,NO_OF_PC_HABS_TAR_UPTO_MON ,NO_OF_PC_HABS_TAR_DUR_MON ,NO_OF_NSS_HABS_TAR_UPTO_MON ,NO_OF_NSS_HABS_TAR_DUR_MON ,COST_OF_SPOVER_WORKS_DUR_MON ,COST_OF_SPOVER_WORKS_UPTO_MON ,COST_OF_ONGO_WORKS_UPTO_MON ,COST_OF_ONGO_WORKS_DUR_MON ,TOT_NO_WORKS_COMP_DUR_MON ,TOT_NO_WORKS_COMP_UPTO_MON ,TOT_NO_WORKS_GRD_DUR_MON ,TOT_NO_WORKS_GRD_UPTO_MON ,TOT_NO_WORKS_ADMSAN_DUR_MON ,TOT_OF_WORKS_ADMSANC_UPTO_MON ,TOT_OF_WORKS_TECHSANC_DUR_MON ,TOT_OF_WORKS_TECHSANC_UPTO_MON ,TOT_OF_WORKS_COMP_DUR_MON ,TOT_OF_WORKS_COMPC_UPTO_MON  from rws_physical_progress_tbl where office_code=? and asset_type=? and month=? and year=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);
			pstat.setString(2, assettype);
			pstat.setString(3, month);
			pstat.setString(4, year);
			progressActionBean = new PhysicalProgressActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				progressActionBean.setEnteredBy(rset.getString("entered_by"));
				progressActionBean.setEnteredDate(rset
						.getString("ENTERED_DATE"));
				// progressActionBean.setNoPrpUptoMon(rset.getInt("NO_PROPOSAL_UPTO_MON"));
				progressActionBean.setNoPrpDurMon(rset
						.getInt("NO_PROPOSAL_DUR_MON"));
				// progressActionBean.setPrpCostUptoMon(rset.getFloat("PROPOSAL_COST_UPTO_MON"));
				progressActionBean.setPrpCostDurMon(rset
						.getFloat("PROPOSAL_COST_DUR_MON"));
				// progressActionBean.setNoPrpClrUptoMon(rset.getInt("NO_PROPOSAL_CLR_UPTO_MON"));
				progressActionBean.setNoPrpClrDurMon(rset
						.getInt("NO_PROPOSAL_CLR_DUR_MON"));
				// progressActionBean.setPrpCostClrUptoMon(rset.getFloat("PROPOSAL_COST_CLR_UPTO_MON"));
				progressActionBean.setPrpCostClrDurMon(rset
						.getFloat("PROPOSAL_COST_CLR_DUR_MON"));
				// progressActionBean.setNoNewWorkSanUptoMon(rset.getInt("NO_NEW_WORKS_SANC_UPTO_MON"));
				progressActionBean.setNoNewWorkSandurMon(rset
						.getInt("NO_NEW_WORKS_SANC_DUR_MON"));
				// progressActionBean.setNoAugWorkSanUptoMon(rset.getInt("NO_AUG_WORKS_SANC_UPTO_MON"));
				progressActionBean.setNoAugWorkSandurMon(rset
						.getInt("NO_AUG_WORKS_SANC_DUR_MON"));
				progressActionBean.setWorkTenderCostDurMon(rset
						.getFloat("WORK_TENDER_COST_DUR_MON"));
				// progressActionBean.setWorkTenderCostUptoMon(rset.getFloat("WORK_TENDER_COST_UPTO_MON"));
				progressActionBean.setTotExpinLakhsDurMon(rset
						.getFloat("TOT_EXP_INLAKHS_DUR_MON"));
				// progressActionBean.setTotExpinLakhsUptoMon(rset.getFloat("TOT_EXP_INLAKHS_UPTO_MON"));
				progressActionBean.setNoNewWorksProgDurMon(rset
						.getInt("NO_NEW_WORKS_INPROG_DUR_MON"));
				// progressActionBean.setNoNewWorksProgUptoMon(rset.getInt("NO_NEW_WORKS_INPROG_UPTO_MON"));
				progressActionBean.setNoAugWorksProgDurMon(rset
						.getInt("NO_AUG_WORKS_INPROG_DUR_MON"));
				// progressActionBean.setNoAugWorksProgUptoMon(rset.getInt("NO_AUG_WORKS_INPROG_UPTO_MON"));
				progressActionBean.setPerPhyProgress(rset
						.getFloat("PER_PHY_PROGRESS"));
				progressActionBean.setPerOfOverallExp(rset
						.getFloat("PER_OF_OVERALL_EXP"));
				progressActionBean.setTotWorkValClrDurMon(rset
						.getFloat("TOTAL_WORK_VAL_CLEAR_DUR_MON"));
				// progressActionBean.setTotWorkValClrUptoMon(rset.getFloat("TOTAL_WORK_VAL_CLEAR_UPTO_MON"));
				progressActionBean.setNoPCHabsCovDurMon(rset
						.getInt("NO_OF_PC_HABS_COV_DUR_MON"));
				// progressActionBean.setNoPCHabsCovUptoMon(rset.getInt("NO_OF_PC_HABS_COV_UPTO_MON"));
				progressActionBean.setNoNSSHabsCovDurMon(rset
						.getInt("NO_OF_NSS_HABS_COV_DUR_MON"));
				// progressActionBean.setNoNSSHabsCovUptoMon(rset.getInt("NO_OF_NSS_HABS_COV_UPTO_MON"));
				// progressActionBean.setNoPCHabsTarUptoMon(rset.getInt("NO_OF_PC_HABS_TAR_UPTO_MON"));
				progressActionBean.setNoPCHabsTarDurMon(rset
						.getInt("NO_OF_PC_HABS_TAR_DUR_MON"));
				// progressActionBean.setNoNSSHabsTarUptoMon(rset.getInt("NO_OF_NSS_HABS_TAR_UPTO_MON"));
				progressActionBean.setNoNSSHabsTarDurMon(rset
						.getInt("NO_OF_NSS_HABS_TAR_DUR_MON"));
				progressActionBean.setCostSpoverWorksDurMon(rset
						.getFloat("COST_OF_SPOVER_WORKS_DUR_MON"));
				// progressActionBean.setCostSpoverWorksUptoMon(rset.getFloat("COST_OF_SPOVER_WORKS_UPTO_MON"));
				// progressActionBean.setCostOngoWorksUptoMon(rset.getFloat("COST_OF_ONGO_WORKS_UPTO_MON"));
				progressActionBean.setCostOngoWorksDurMon(rset
						.getFloat("COST_OF_ONGO_WORKS_DUR_MON"));
				progressActionBean.setTotWorksCompDurMon(rset
						.getInt("TOT_NO_WORKS_COMP_DUR_MON"));
				// progressActionBean.setTotWorksCompUptoMon(rset.getInt("TOT_NO_WORKS_COMP_UPTO_MON"));
				progressActionBean.setTotWorksGrdDurMon(rset
						.getInt("TOT_NO_WORKS_GRD_DUR_MON"));
				// progressActionBean.setTotWorksGrdUptoMon(rset.getInt("TOT_NO_WORKS_GRD_UPTO_MON"));
				progressActionBean.setTotWorksAdmsanDurMon(rset
						.getInt("TOT_NO_WORKS_ADMSAN_DUR_MON"));
				// progressActionBean.setTotWorksAdmsanUptoMon(rset.getInt("TOT_OF_WORKS_ADMSANC_UPTO_MON"));
				progressActionBean.setTotWorksTechsanDurMon(rset
						.getInt("TOT_OF_WORKS_TECHSANC_DUR_MON"));
				// progressActionBean.setTotWorksTechsanUptoMon(rset.getInt("TOT_OF_WORKS_TECHSANC_UPTO_MON"));
				progressActionBean.setTotofWorksCompDurMon(rset
						.getInt("TOT_OF_WORKS_COMP_DUR_MON"));
				// progressActionBean.setTotofWorksCompUptoMon(rset.getInt("TOT_OF_WORKS_COMPC_UPTO_MON"));

				Debug.println(rset.getString("entered_by"));

			}
		} catch (Exception e) {
			Debug.println("Exception in RetrievedurmonPhysicalProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return progressActionBean;
	}

	// Update Upto Month Physical Progress

	public PhysicalProgressActionBean RetrieveuptomonPhysicalProgress(
			DataSource dataSource,
			PhysicalProgressActionBean progressActionBean, String officeCode,
			String assettype, String month, String year) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			String query1 = " SELECT entered_by, to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE, NO_PROPOSAL_UPTO_MON, NO_PROPOSAL_DUR_MON, PROPOSAL_COST_UPTO_MON, PROPOSAL_COST_DUR_MON, NO_PROPOSAL_CLR_UPTO_MON, NO_PROPOSAL_CLR_DUR_MON, PROPOSAL_COST_CLR_UPTO_MON, PROPOSAL_COST_CLR_DUR_MON, NO_NEW_WORKS_SANC_UPTO_MON, NO_NEW_WORKS_SANC_DUR_MON, NO_AUG_WORKS_SANC_UPTO_MON,NO_AUG_WORKS_SANC_DUR_MON,WORK_TENDER_COST_DUR_MON,WORK_TENDER_COST_UPTO_MON ,TOT_EXP_INLAKHS_DUR_MON ,TOT_EXP_INLAKHS_UPTO_MON ,NO_NEW_WORKS_INPROG_DUR_MON ,NO_NEW_WORKS_INPROG_UPTO_MON ,NO_AUG_WORKS_INPROG_DUR_MON ,NO_AUG_WORKS_INPROG_UPTO_MON ,PER_PHY_PROGRESS ,PER_OF_OVERALL_EXP ,TOTAL_WORK_VAL_CLEAR_DUR_MON ,TOTAL_WORK_VAL_CLEAR_UPTO_MON ,NO_OF_PC_HABS_COV_DUR_MON ,NO_OF_PC_HABS_COV_UPTO_MON ,NO_OF_NSS_HABS_COV_DUR_MON ,NO_OF_NSS_HABS_COV_UPTO_MON ,NO_OF_PC_HABS_TAR_UPTO_MON ,NO_OF_PC_HABS_TAR_DUR_MON ,NO_OF_NSS_HABS_TAR_UPTO_MON ,NO_OF_NSS_HABS_TAR_DUR_MON ,COST_OF_SPOVER_WORKS_DUR_MON ,COST_OF_SPOVER_WORKS_UPTO_MON ,COST_OF_ONGO_WORKS_UPTO_MON ,COST_OF_ONGO_WORKS_DUR_MON ,TOT_NO_WORKS_COMP_DUR_MON ,TOT_NO_WORKS_COMP_UPTO_MON ,TOT_NO_WORKS_GRD_DUR_MON ,TOT_NO_WORKS_GRD_UPTO_MON ,TOT_NO_WORKS_ADMSAN_DUR_MON ,TOT_OF_WORKS_ADMSANC_UPTO_MON ,TOT_OF_WORKS_TECHSANC_DUR_MON ,TOT_OF_WORKS_TECHSANC_UPTO_MON ,TOT_OF_WORKS_COMP_DUR_MON ,TOT_OF_WORKS_COMPC_UPTO_MON  from rws_physical_progress_tbl where office_code=? and asset_type=? and month=? and year=?";
			pstat = conn.prepareStatement(query1);
			pstat.setString(1, officeCode);
			pstat.setString(2, assettype);
			pstat.setString(3, month);
			pstat.setString(4, year);
			// progressActionBean = new PhysicalProgressActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {

				noprop = noprop + rset.getInt("NO_PROPOSAL_UPTO_MON");
				prop = prop + rset.getFloat("PROPOSAL_COST_UPTO_MON");
				nopropclr = nopropclr + rset.getInt("NO_PROPOSAL_CLR_UPTO_MON");
				propcostclr = propcostclr
						+ rset.getFloat("PROPOSAL_COST_CLR_UPTO_MON");
				nonewworkssan = nonewworkssan
						+ rset.getInt("NO_NEW_WORKS_SANC_UPTO_MON");
				noaugworkssan = noaugworkssan
						+ rset.getInt("NO_AUG_WORKS_SANC_UPTO_MON");
				worktndrcost = worktndrcost
						+ rset.getFloat("WORK_TENDER_COST_UPTO_MON");
				totexplacs = totexplacs
						+ rset.getFloat("TOT_EXP_INLAKHS_UPTO_MON");
				nonewwksprog = nonewwksprog
						+ rset.getInt("NO_NEW_WORKS_INPROG_UPTO_MON");
				noaugwksprog = noaugwksprog
						+ rset.getInt("NO_AUG_WORKS_INPROG_UPTO_MON");
				totworkvalclr = totworkvalclr
						+ rset.getFloat("TOTAL_WORK_VAL_CLEAR_UPTO_MON");
				nopchabscov = nopchabscov
						+ rset.getInt("NO_OF_PC_HABS_COV_UPTO_MON");
				nonsshabscov = nonsshabscov
						+ rset.getInt("NO_OF_NSS_HABS_COV_UPTO_MON");
				nopchabstar = nopchabstar
						+ rset.getInt("NO_OF_PC_HABS_TAR_UPTO_MON");
				nonsshabstar = nonsshabstar
						+ rset.getInt("NO_OF_NSS_HABS_TAR_UPTO_MON");
				costspwks = costspwks
						+ rset.getFloat("COST_OF_SPOVER_WORKS_UPTO_MON");
				costongowks = costongowks
						+ rset.getFloat("COST_OF_ONGO_WORKS_UPTO_MON");
				totnowkscomp = totnowkscomp
						+ rset.getInt("TOT_NO_WORKS_COMP_UPTO_MON");
				totnowksgrd = totnowksgrd
						+ rset.getInt("TOT_NO_WORKS_GRD_UPTO_MON");
				totwksadmsanc = totwksadmsanc
						+ rset.getInt("TOT_OF_WORKS_ADMSANC_UPTO_MON");
				totwkstechsanc = totwkstechsanc
						+ rset.getInt("TOT_OF_WORKS_TECHSANC_UPTO_MON");
				totwkscompc = totwkscompc
						+ rset.getInt("TOT_OF_WORKS_COMPC_UPTO_MON");
			}
			progressActionBean.setNoPrpUptoMon(noprop);
			progressActionBean.setPrpCostUptoMon(prop);
			progressActionBean.setNoPrpClrUptoMon(nopropclr);

			progressActionBean.setPrpCostClrUptoMon(propcostclr);

			progressActionBean.setNoNewWorkSanUptoMon(nonewworkssan);

			progressActionBean.setNoAugWorkSanUptoMon(noaugworkssan);

			progressActionBean.setWorkTenderCostUptoMon(worktndrcost);

			progressActionBean.setTotExpinLakhsUptoMon(totexplacs);

			progressActionBean.setNoNewWorksProgUptoMon(nonewwksprog);

			progressActionBean.setNoAugWorksProgUptoMon(noaugwksprog);

			progressActionBean.setTotWorkValClrUptoMon(totworkvalclr);

			progressActionBean.setNoPCHabsCovUptoMon(nopchabscov);

			progressActionBean.setNoNSSHabsCovUptoMon(nonsshabscov);
			progressActionBean.setNoPCHabsTarUptoMon(nopchabstar);

			progressActionBean.setNoNSSHabsTarUptoMon(nonsshabstar);

			progressActionBean.setCostSpoverWorksUptoMon(costspwks);
			progressActionBean.setCostOngoWorksUptoMon(costongowks);

			progressActionBean.setTotWorksCompUptoMon(totnowkscomp);

			progressActionBean.setTotWorksGrdUptoMon(totnowksgrd);

			progressActionBean.setTotWorksAdmsanUptoMon(totwksadmsanc);

			progressActionBean.setTotWorksTechsanUptoMon(totwkstechsanc);

			progressActionBean.setTotofWorksCompUptoMon(totwkscompc);
			Debug.println("nopropppppppppp" + noprop);
			Debug.println("propppppppppp" + prop);

			// query =
			// " update rws_physical_progress_tbl set NO_PROPOSAL_UPTO_MON = ?, PROPOSAL_COST_UPTO_MON = ?, NO_PROPOSAL_CLR_UPTO_MON = ?, PROPOSAL_COST_CLR_UPTO_MON = ?, NO_NEW_WORKS_SANC_UPTO_MON = ?, NO_AUG_WORKS_SANC_UPTO_MON = ?, WORK_TENDER_COST_UPTO_MON = ?, TOT_EXP_INLAKHS_UPTO_MON = ?, NO_NEW_WORKS_INPROG_UPTO_MON = ?, NO_AUG_WORKS_INPROG_UPTO_MON = ?, TOTAL_WORK_VAL_CLEAR_UPTO_MON = ?, NO_OF_PC_HABS_COV_UPTO_MON = ?, NO_OF_NSS_HABS_COV_UPTO_MON = ?, NO_OF_PC_HABS_TAR_UPTO_MON = ?, NO_OF_NSS_HABS_TAR_UPTO_MON = ?, COST_OF_SPOVER_WORKS_UPTO_MON = ?, COST_OF_ONGO_WORKS_UPTO_MON = ?, TOT_NO_WORKS_COMP_UPTO_MON = ?, TOT_NO_WORKS_GRD_UPTO_MON = ?, TOT_OF_WORKS_ADMSANC_UPTO_MON = ?, TOT_OF_WORKS_TECHSANC_UPTO_MON = ?, TOT_OF_WORKS_COMPC_UPTO_MON = ? where office_code=? and asset_type=? and month=? and year=?";

			// pstat = conn.prepareStatement(query);
			//
			//
			// pstat.setInt(1,noprop);
			// pstat.setFloat(2,prop);
			// pstat.setInt(3,nopropclr);
			// pstat.setFloat(4,propcostclr);
			// pstat.setInt(5,nonewworkssan);
			// pstat.setInt(6,noaugworkssan);
			// pstat.setFloat(7,worktndrcost);
			//
			// pstat.setFloat(8,totexplacs);
			//
			// pstat.setInt(9,nonewwksprog);
			//
			// pstat.setInt(10,noaugwksprog);
			//
			// pstat.setFloat(11,totworkvalclr);
			//
			// pstat.setInt(12,nopchabscov);
			//
			// pstat.setInt(13,nonsshabscov);
			// pstat.setInt(14,nopchabstar);
			//
			// pstat.setInt(15,nonsshabstar);
			//
			// pstat.setFloat(16,costspwks);
			// pstat.setFloat(17,costongowks);
			//
			// pstat.setInt(18,totnowkscomp);
			//
			// pstat.setInt(19,totnowksgrd);
			//
			// pstat.setInt(20,totwksadmsanc);
			//
			// pstat.setInt(21,totwkstechsanc);
			//
			// pstat.setInt(22,totwkscompc);
			//
			//
			// pstat.setString(23,officeCode);
			// pstat.setString(24,assettype);
			// pstat.setString(25,month);
			// pstat.setString(26,year);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in RetrieveuptomonPhysicalProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return progressActionBean;
	}

	// Update During Month Physical Progress

	// public int UpdatedurmonPhysicalProgress(DataSource
	// dataSource,PhysicalProgressActionBean progressActionBean, String
	// officeCode,String assettype,String month,String year,String date,String
	// enteredby)
	// {
	//
	// int count = 0;
	// try
	// {
	// if (conn==null)
	// {
	// conn = RwsOffices.getConn();
	// }
	// query =
	// " update rws_physical_progress_tbl set entered_by = ?, NO_PROPOSAL_DUR_MON = ?, PROPOSAL_COST_DUR_MON = ?, NO_PROPOSAL_CLR_DUR_MON = ?, PROPOSAL_COST_CLR_DUR_MON = ?, NO_NEW_WORKS_SANC_DUR_MON = ?, NO_AUG_WORKS_SANC_DUR_MON = ?,WORK_TENDER_COST_DUR_MON = ?, TOT_EXP_INLAKHS_DUR_MON = ?, NO_NEW_WORKS_INPROG_DUR_MON = ?, NO_AUG_WORKS_INPROG_DUR_MON = ?, PER_PHY_PROGRESS = ?, PER_OF_OVERALL_EXP = ?, TOTAL_WORK_VAL_CLEAR_DUR_MON = ?, NO_OF_PC_HABS_COV_DUR_MON = ?, NO_OF_NSS_HABS_COV_DUR_MON = ?, NO_OF_PC_HABS_TAR_DUR_MON = ?, NO_OF_NSS_HABS_TAR_DUR_MON = ?, COST_OF_SPOVER_WORKS_DUR_MON = ?, COST_OF_ONGO_WORKS_DUR_MON = ?, TOT_NO_WORKS_COMP_DUR_MON = ?, TOT_NO_WORKS_GRD_DUR_MON = ?, TOT_NO_WORKS_ADMSAN_DUR_MON = ?, TOT_OF_WORKS_TECHSANC_DUR_MON = ?, TOT_OF_WORKS_COMP_DUR_MON = ?, entered_date = to_date('"+date+
	// "','dd/mm/yyyy') where office_code=? and asset_type=? and month=? and year=?";
	//
	//
	// pstat = conn.prepareStatement(query);
	//
	// pstat.setString(1,enteredby);
	// pstat.setInt(3,progressActionBean.getNoPrpDurMon());
	// pstat.setFloat(5,progressActionBean.getPrpCostDurMon());
	// pstat.setInt(7,progressActionBean.getNoPrpClrDurMon());
	// pstat.setFloat(9,progressActionBean.getPrpCostClrDurMon());
	// pstat.setInt(11,progressActionBean.getNoNewWorkSandurMon());
	// pstat.setInt(13,progressActionBean.getNoAugWorkSandurMon());
	// pstat.setFloat(14,progressActionBean.getWorkTenderCostDurMon());
	// pstat.setFloat(16,progressActionBean.getTotExpinLakhsDurMon());
	// pstat.setInt(18,progressActionBean.getNoNewWorksProgDurMon());
	// pstat.setInt(20,progressActionBean.getNoAugWorksProgDurMon());
	// pstat.setFloat(22,progressActionBean.getPerPhyProgress());
	// pstat.setFloat(23,progressActionBean.getPerOfOverallExp());
	// pstat.setFloat(24,progressActionBean.getTotWorkValClrDurMon());
	// pstat.setInt(26,progressActionBean.getNoPCHabsCovDurMon());
	// pstat.setInt(28,progressActionBean.getNoNSSHabsCovDurMon());
	// pstat.setInt(31,progressActionBean.getNoPCHabsTarDurMon());
	// pstat.setInt(33,progressActionBean.getNoNSSHabsTarDurMon());
	// pstat.setFloat(34,progressActionBean.getCostSpoverWorksDurMon());
	// pstat.setFloat(37,progressActionBean.getCostOngoWorksDurMon());
	// pstat.setInt(38,progressActionBean.getTotWorksCompDurMon());
	// pstat.setInt(40,progressActionBean.getTotWorksGrdDurMon());
	// pstat.setInt(42,progressActionBean.getTotWorksAdmsanDurMon());
	// pstat.setInt(44,progressActionBean.getTotWorksTechsanDurMon());
	// pstat.setInt(46,progressActionBean.getTotofWorksCompDurMon());
	// pstat.setString(48,officeCode);
	// pstat.setString(49,assettype);
	// pstat.setString(50,month);
	// pstat.setString(51,year);
	// count =pstat.executeUpdate();
	//
	// }
	// catch (Exception e)
	// {
	// Debug.println("Exception:"+e);
	// }
	// finally
	// {
	// releaseConnection();
	//
	// }
	// return count;
	// }

	public int UpdatePhysicalProgress(DataSource dataSource,
			PhysicalProgressActionBean progressActionBean, String officeCode,
			String assettype, String month, String year, String date,
			String enteredby) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();

			query = " update rws_physical_progress_tbl set NO_PROPOSAL_UPTO_MON = ?, NO_PROPOSAL_DUR_MON = ?, PROPOSAL_COST_UPTO_MON = ?, PROPOSAL_COST_DUR_MON = ?, NO_PROPOSAL_CLR_UPTO_MON = ?, NO_PROPOSAL_CLR_DUR_MON = ?, PROPOSAL_COST_CLR_UPTO_MON = ?, PROPOSAL_COST_CLR_DUR_MON = ?, NO_NEW_WORKS_SANC_UPTO_MON = ?, NO_NEW_WORKS_SANC_DUR_MON = ?, NO_AUG_WORKS_SANC_UPTO_MON = ?, NO_AUG_WORKS_SANC_DUR_MON = ?,WORK_TENDER_COST_DUR_MON = ?, WORK_TENDER_COST_UPTO_MON = ?, TOT_EXP_INLAKHS_DUR_MON = ?, TOT_EXP_INLAKHS_UPTO_MON = ?, NO_NEW_WORKS_INPROG_DUR_MON = ?, NO_NEW_WORKS_INPROG_UPTO_MON = ?, NO_AUG_WORKS_INPROG_DUR_MON = ?, NO_AUG_WORKS_INPROG_UPTO_MON = ?, PER_PHY_PROGRESS = ?, PER_OF_OVERALL_EXP = ?, TOTAL_WORK_VAL_CLEAR_DUR_MON = ?, TOTAL_WORK_VAL_CLEAR_UPTO_MON = ?, NO_OF_PC_HABS_COV_DUR_MON = ?, NO_OF_PC_HABS_COV_UPTO_MON = ?, NO_OF_NSS_HABS_COV_DUR_MON = ?, NO_OF_NSS_HABS_COV_UPTO_MON = ?, NO_OF_PC_HABS_TAR_UPTO_MON = ?, NO_OF_PC_HABS_TAR_DUR_MON = ?, NO_OF_NSS_HABS_TAR_UPTO_MON = ?, NO_OF_NSS_HABS_TAR_DUR_MON = ?, COST_OF_SPOVER_WORKS_DUR_MON = ?, COST_OF_SPOVER_WORKS_UPTO_MON = ?, COST_OF_ONGO_WORKS_UPTO_MON = ?, COST_OF_ONGO_WORKS_DUR_MON = ?, TOT_NO_WORKS_COMP_DUR_MON = ?, TOT_NO_WORKS_COMP_UPTO_MON = ?, TOT_NO_WORKS_GRD_DUR_MON = ?, TOT_NO_WORKS_GRD_UPTO_MON = ?, TOT_NO_WORKS_ADMSAN_DUR_MON = ?, TOT_OF_WORKS_ADMSANC_UPTO_MON = ?, TOT_OF_WORKS_TECHSANC_DUR_MON = ?, TOT_OF_WORKS_TECHSANC_UPTO_MON = ?, TOT_OF_WORKS_COMP_DUR_MON = ?, TOT_OF_WORKS_COMPC_UPTO_MON = ?, entered_date = to_date('"
					+ date
					+ "','dd/mm/yyyy') where office_code=? and asset_type=? and month=? and year=?";

			// progressActionBean.getEnteredDate()
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,enteredby);
			pstat.setInt(1, progressActionBean.getNoPrpUptoMon());
			pstat.setInt(2, progressActionBean.getNoPrpDurMon());

			pstat.setFloat(3, progressActionBean.getPrpCostUptoMon());
			pstat.setFloat(4, progressActionBean.getPrpCostDurMon());
			pstat.setInt(5, progressActionBean.getNoPrpClrUptoMon());
			pstat.setInt(6, progressActionBean.getNoPrpClrDurMon());
			pstat.setFloat(7, progressActionBean.getPrpCostClrUptoMon());
			pstat.setFloat(8, progressActionBean.getPrpCostClrDurMon());
			pstat.setInt(9, progressActionBean.getNoNewWorkSanUptoMon());
			pstat.setInt(10, progressActionBean.getNoNewWorkSandurMon());
			pstat.setInt(11, progressActionBean.getNoAugWorkSanUptoMon());
			pstat.setInt(12, progressActionBean.getNoAugWorkSandurMon());
			pstat.setFloat(13, progressActionBean.getWorkTenderCostDurMon());
			pstat.setFloat(14, progressActionBean.getWorkTenderCostUptoMon());
			pstat.setFloat(15, progressActionBean.getTotExpinLakhsDurMon());
			pstat.setFloat(16, progressActionBean.getTotExpinLakhsUptoMon());
			pstat.setInt(17, progressActionBean.getNoNewWorksProgDurMon());
			pstat.setInt(18, progressActionBean.getNoNewWorksProgUptoMon());
			pstat.setInt(19, progressActionBean.getNoAugWorksProgDurMon());
			pstat.setInt(20, progressActionBean.getNoAugWorksProgUptoMon());
			pstat.setFloat(21, progressActionBean.getPerPhyProgress());
			pstat.setFloat(22, progressActionBean.getPerOfOverallExp());
			pstat.setFloat(23, progressActionBean.getTotWorkValClrDurMon());
			pstat.setFloat(24, progressActionBean.getTotWorkValClrUptoMon());
			pstat.setInt(25, progressActionBean.getNoPCHabsCovDurMon());
			pstat.setInt(26, progressActionBean.getNoPCHabsCovUptoMon());
			pstat.setInt(27, progressActionBean.getNoNSSHabsCovDurMon());
			pstat.setInt(28, progressActionBean.getNoNSSHabsCovUptoMon());
			pstat.setInt(29, progressActionBean.getNoPCHabsTarUptoMon());
			pstat.setInt(30, progressActionBean.getNoPCHabsTarDurMon());
			pstat.setInt(31, progressActionBean.getNoNSSHabsTarUptoMon());
			pstat.setInt(32, progressActionBean.getNoNSSHabsTarDurMon());
			pstat.setFloat(33, progressActionBean.getCostSpoverWorksDurMon());
			pstat.setFloat(34, progressActionBean.getCostSpoverWorksUptoMon());
			pstat.setFloat(35, progressActionBean.getCostOngoWorksUptoMon());
			pstat.setFloat(36, progressActionBean.getCostOngoWorksDurMon());
			pstat.setInt(37, progressActionBean.getTotWorksCompDurMon());
			pstat.setInt(38, progressActionBean.getTotWorksCompUptoMon());
			pstat.setInt(39, progressActionBean.getTotWorksGrdDurMon());
			pstat.setInt(40, progressActionBean.getTotWorksGrdUptoMon());
			pstat.setInt(41, progressActionBean.getTotWorksAdmsanDurMon());
			pstat.setInt(42, progressActionBean.getTotWorksAdmsanUptoMon());
			pstat.setInt(43, progressActionBean.getTotWorksTechsanDurMon());
			pstat.setInt(44, progressActionBean.getTotWorksTechsanUptoMon());
			pstat.setInt(45, progressActionBean.getTotofWorksCompDurMon());
			pstat.setInt(46, progressActionBean.getTotofWorksCompUptoMon());

			pstat.setString(47, officeCode);
			pstat.setString(48, assettype);
			pstat.setString(49, month);
			pstat.setString(50, year);

			Debug.println("jjjjjjjj" + progressActionBean.getEnteredBy());

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in UpdatePhysicalProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int insertPhysicalProgress(DataSource dataSource,
			PhysicalProgressActionBean progressActionBean, String officeCode,
			String assettype, String month, String year, String date,
			String enteredby) {
		int count = 0;
		try {

			Debug.println("Ready to get connection");
			conn = RwsOffices.getConn();

			Debug.println("got connection");

			query = "insert into rws_physical_progress_tbl(ENTERED_BY , NO_PROPOSAL_UPTO_MON ,NO_PROPOSAL_DUR_MON ,PROPOSAL_COST_UPTO_MON ,PROPOSAL_COST_DUR_MON ,NO_PROPOSAL_CLR_UPTO_MON ,NO_PROPOSAL_CLR_DUR_MON ,PROPOSAL_COST_CLR_UPTO_MON ,PROPOSAL_COST_CLR_DUR_MON ,NO_NEW_WORKS_SANC_UPTO_MON ,NO_NEW_WORKS_SANC_DUR_MON ,NO_AUG_WORKS_SANC_UPTO_MON,NO_AUG_WORKS_SANC_DUR_MON,WORK_TENDER_COST_DUR_MON,WORK_TENDER_COST_UPTO_MON,TOT_EXP_INLAKHS_DUR_MON,TOT_EXP_INLAKHS_UPTO_MON,NO_NEW_WORKS_INPROG_DUR_MON,NO_NEW_WORKS_INPROG_UPTO_MON,NO_AUG_WORKS_INPROG_DUR_MON,NO_AUG_WORKS_INPROG_UPTO_MON,PER_PHY_PROGRESS,PER_OF_OVERALL_EXP,TOTAL_WORK_VAL_CLEAR_DUR_MON,TOTAL_WORK_VAL_CLEAR_UPTO_MON,NO_OF_PC_HABS_COV_DUR_MON,NO_OF_PC_HABS_COV_UPTO_MON,NO_OF_NSS_HABS_COV_DUR_MON,NO_OF_NSS_HABS_COV_UPTO_MON,NO_OF_PC_HABS_TAR_UPTO_MON,NO_OF_PC_HABS_TAR_DUR_MON,NO_OF_NSS_HABS_TAR_UPTO_MON,NO_OF_NSS_HABS_TAR_DUR_MON,COST_OF_SPOVER_WORKS_DUR_MON,COST_OF_SPOVER_WORKS_UPTO_MON,COST_OF_ONGO_WORKS_UPTO_MON,COST_OF_ONGO_WORKS_DUR_MON,TOT_NO_WORKS_COMP_DUR_MON,TOT_NO_WORKS_COMP_UPTO_MON,TOT_NO_WORKS_GRD_DUR_MON,TOT_NO_WORKS_GRD_UPTO_MON,TOT_NO_WORKS_ADMSAN_DUR_MON,TOT_OF_WORKS_ADMSANC_UPTO_MON,TOT_OF_WORKS_TECHSANC_DUR_MON,TOT_OF_WORKS_TECHSANC_UPTO_MON,TOT_OF_WORKS_COMP_DUR_MON,TOT_OF_WORKS_COMPC_UPTO_MON,MONTH,YEAR,OFFICE_CODE,asset_type,entered_date ) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date('"
					+ date + "','dd/mm/yyyy'))  ";

			// to_date('"+progressActionBean.getEnteredDate()+ "','dd/mm/yyyy')
			pstat = conn.prepareStatement(query);

			pstat.setString(1, enteredby);
			// Debug.println("aaaaaaaaa"+progressActionBean.getEnteredBy());
			pstat.setInt(2, progressActionBean.getNoPrpUptoMon());
			pstat.setInt(3, progressActionBean.getNoPrpDurMon());

			pstat.setFloat(4, progressActionBean.getPrpCostUptoMon());
			pstat.setFloat(5, progressActionBean.getPrpCostDurMon());
			pstat.setInt(6, progressActionBean.getNoPrpClrUptoMon());
			pstat.setInt(7, progressActionBean.getNoPrpClrDurMon());
			pstat.setFloat(8, progressActionBean.getPrpCostClrUptoMon());
			pstat.setFloat(9, progressActionBean.getPrpCostClrDurMon());
			pstat.setInt(10, progressActionBean.getNoNewWorkSanUptoMon());
			pstat.setInt(11, progressActionBean.getNoNewWorkSandurMon());
			pstat.setInt(12, progressActionBean.getNoAugWorkSanUptoMon());
			pstat.setInt(13, progressActionBean.getNoAugWorkSandurMon());
			pstat.setFloat(14, progressActionBean.getWorkTenderCostDurMon());
			pstat.setFloat(15, progressActionBean.getWorkTenderCostUptoMon());
			pstat.setFloat(16, progressActionBean.getTotExpinLakhsDurMon());
			pstat.setFloat(17, progressActionBean.getTotExpinLakhsUptoMon());
			pstat.setInt(18, progressActionBean.getNoNewWorksProgDurMon());
			pstat.setInt(19, progressActionBean.getNoNewWorksProgUptoMon());
			pstat.setInt(20, progressActionBean.getNoAugWorksProgDurMon());
			pstat.setInt(21, progressActionBean.getNoAugWorksProgUptoMon());
			pstat.setFloat(22, progressActionBean.getPerPhyProgress());
			pstat.setFloat(23, progressActionBean.getPerOfOverallExp());
			pstat.setFloat(24, progressActionBean.getTotWorkValClrDurMon());
			pstat.setFloat(25, progressActionBean.getTotWorkValClrUptoMon());
			pstat.setInt(26, progressActionBean.getNoPCHabsCovDurMon());
			pstat.setInt(27, progressActionBean.getNoPCHabsCovUptoMon());
			pstat.setInt(28, progressActionBean.getNoNSSHabsCovDurMon());
			pstat.setInt(29, progressActionBean.getNoNSSHabsCovUptoMon());
			pstat.setInt(30, progressActionBean.getNoPCHabsTarUptoMon());
			pstat.setInt(31, progressActionBean.getNoPCHabsTarDurMon());
			pstat.setInt(32, progressActionBean.getNoNSSHabsTarUptoMon());
			pstat.setInt(33, progressActionBean.getNoNSSHabsTarDurMon());
			pstat.setFloat(34, progressActionBean.getCostSpoverWorksDurMon());
			pstat.setFloat(35, progressActionBean.getCostSpoverWorksUptoMon());
			pstat.setFloat(36, progressActionBean.getCostOngoWorksUptoMon());
			pstat.setFloat(37, progressActionBean.getCostOngoWorksDurMon());
			pstat.setInt(38, progressActionBean.getTotWorksCompDurMon());
			pstat.setInt(39, progressActionBean.getTotWorksCompUptoMon());
			pstat.setInt(40, progressActionBean.getTotWorksGrdDurMon());
			pstat.setInt(41, progressActionBean.getTotWorksGrdUptoMon());
			pstat.setInt(42, progressActionBean.getTotWorksAdmsanDurMon());
			pstat.setInt(43, progressActionBean.getTotWorksAdmsanUptoMon());
			pstat.setInt(44, progressActionBean.getTotWorksTechsanDurMon());
			pstat.setInt(45, progressActionBean.getTotWorksTechsanUptoMon());
			pstat.setInt(46, progressActionBean.getTotofWorksCompDurMon());
			pstat.setInt(47, progressActionBean.getTotofWorksCompUptoMon());
			// pstat.setDate(48,progressActionBean.getEnteredDate());

			pstat.setString(48, month);
			pstat.setString(49, year);
			pstat.setString(50, officeCode);
			pstat.setString(51, assettype);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in insertPhysicalProgress():" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int DeletePhysicalProgress(DataSource dataSource,
			PhysicalProgressActionBean progressActionBean, String officeCode,
			String assettype, String month, String year) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();

			query = "delete from rws_physical_progress_tbl where  office_code=? and asset_type=? and month=? and year=? ";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, officeCode);
			pstat.setString(2, assettype);
			pstat.setString(3, month);
			pstat.setString(4, year);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in DeletePhysicalProgress():" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		{
			releaseConnection();

		}
		return count;
	}

	public int CheckFinancialProgress(DataSource dataSource, String officecode,
			String month, String year, String programmeCode,
			String subprogrammeCode) {
		int no_pp = 0;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from rws_financial_progress_tbl where office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);

			pstat.setString(2, month);
			pstat.setString(3, year);
			pstat.setString(4, programmeCode);
			pstat.setString(5, subprogrammeCode);
			rset = pstat.executeQuery();
			if (rset.next()) {
				if (rset.getInt("cnt") > 0) {
					no_pp = rset.getInt("cnt");
				}
			}
		} catch (Exception e) {
			Debug.println("Exception in CheckFinancialProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public FinancialProgressActionBean RetrievedurmonFinancialProgress(
			DataSource dataSource, String officecode, String month,
			String year, String programmeCode, String subprogrammeCode) {
		FinancialProgressActionBean progressActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT entered_by, to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE, BUDGET_PROVISION_AMT,RELEASES_UPTO_THE_MONTH,RELEASES_DUR_THE_MONTH,WORK_LOAD_UNITS,EXPENDITURE_UPTO_THE_MONTH,EXPENDITURE_DUR_THE_MONTH from rws_financial_progress_tbl where office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);

			pstat.setString(2, month);
			pstat.setString(3, year);
			pstat.setString(4, programmeCode);
			pstat.setString(5, subprogrammeCode);
			progressActionBean = new FinancialProgressActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				// rel=rel+rset.getFloat("RELEASES_UPTO_THE_MONTH");
				// exp=exp+rset.rset.getFloat("EXPENDITURE_UPTO_THE_MONTH");

				progressActionBean.setEnteredBy(rset.getString("entered_by"));
				progressActionBean.setEnteredDate(rset
						.getString("ENTERED_DATE"));
				progressActionBean.setBgtProvisionAmt(rset
						.getFloat("BUDGET_PROVISION_AMT"));
				// progressActionBean.setRelUptoMon(rset.getFloat("RELEASES_UPTO_THE_MONTH"));
				progressActionBean.setRelDurMon(rset
						.getFloat("RELEASES_DUR_THE_MONTH"));
				progressActionBean.setWorkLoadUnits(rset
						.getInt("WORK_LOAD_UNITS"));
				// progressActionBean.setExpUptoMon(rset.getFloat("EXPENDITURE_UPTO_THE_MONTH"));
				progressActionBean.setExpDurMon(rset
						.getFloat("EXPENDITURE_DUR_THE_MONTH"));

				Debug.println(rset.getString("entered_by"));

			}
			// progressActionBean.setNoPrpUptoMon(rel);
			// progressActionBean.setPrpCostUptoMon(exp);

		} catch (Exception e) {
			Debug.println("Exception in RetrievedurmonFinancialProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return progressActionBean;
	}

	public FinancialProgressActionBean RetrieveuptomonFinancialProgress(
			DataSource dataSource, String officecode, String month,
			String year, String programmeCode, String subprogrammeCode) {
		int count = 0;
		FinancialProgressActionBean progressActionBean = null;
		try {
			conn = RwsOffices.getConn();

			query = " SELECT entered_by, to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE, BUDGET_PROVISION_AMT,RELEASES_UPTO_THE_MONTH,RELEASES_DUR_THE_MONTH,WORK_LOAD_UNITS,EXPENDITURE_UPTO_THE_MONTH,EXPENDITURE_DUR_THE_MONTH from rws_financial_progress_tbl where office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);

			pstat.setString(2, month);
			pstat.setString(3, year);
			pstat.setString(4, programmeCode);
			pstat.setString(5, subprogrammeCode);
			progressActionBean = new FinancialProgressActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				rel = rel + rset.getFloat("RELEASES_UPTO_THE_MONTH");
				exp = exp + rset.getFloat("EXPENDITURE_UPTO_THE_MONTH");

				// progressActionBean.setEnteredBy(rset.getString("entered_by"));
				// progressActionBean.setEnteredDate(rset.getString("ENTERED_DATE"));
				// progressActionBean.setBgtProvisionAmt(rset.getFloat("BUDGET_PROVISION_AMT"));
				// progressActionBean.setRelUptoMon(rset.getFloat("RELEASES_UPTO_THE_MONTH"));
				// progressActionBean.setRelDurMon(rset.getFloat("RELEASES_DUR_THE_MONTH"));
				// progressActionBean.setWorkLoadUnits(rset.getInt("WORK_LOAD_UNITS"));
				// progressActionBean.setExpUptoMon(rset.getFloat("EXPENDITURE_UPTO_THE_MONTH"));
				// progressActionBean.setExpDurMon(rset.getFloat("EXPENDITURE_DUR_THE_MONTH"));

			}

			Debug.println("rel" + rel);
			// Debug.println(rset.getString("exp"+exp));

			progressActionBean.setRelUptoMon(rel);
			progressActionBean.setExpUptoMon(exp);
			// count =pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception in RetrieveuptomonFinancialProgress():"
					+ e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return progressActionBean;
	}

	public int UpdateFinancialProgress(DataSource dataSource,
			FinancialProgressActionBean progressActionBean, String officeCode,
			String month, String year, String date, String enteredby,
			String programmeCode, String subprogrammeCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			// String query1 =
			// " SELECT entered_by, to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE, BUDGET_PROVISION_AMT,RELEASES_UPTO_THE_MONTH,RELEASES_DUR_THE_MONTH,WORK_LOAD_UNITS,EXPENDITURE_UPTO_THE_MONTH,EXPENDITURE_DUR_THE_MONTH from rws_financial_progress_tbl where office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=?";
			// pstat = conn.prepareStatement(query1);
			// pstat.setString(1,officeCode);
			//
			// pstat.setString(2,month);
			// pstat.setString(3,year);
			// pstat.setString(4,programmeCode);
			// pstat.setString(5,subprogrammeCode);
			// //progressActionBean = new PhysicalProgressActionBean();
			// rset = pstat.executeQuery();
			// if (rset.next())
			// {
			// rset.getFloat("BUDGET_PROVISION_AMT");
			// rset.getFloat("RELEASES_UPTO_THE_MONTH");
			// rset.getFloat("RELEASES_DUR_THE_MONTH");
			// rset.getInt("WORK_LOAD_UNITS");
			// rset.getFloat("EXPENDITURE_UPTO_THE_MONTH");
			// rset.getFloat("EXPENDITURE_DUR_THE_MONTH");
			//
			// }
			query = " update rws_financial_progress_tbl set BUDGET_PROVISION_AMT = ?, RELEASES_UPTO_THE_MONTH = ?, RELEASES_DUR_THE_MONTH = ?, WORK_LOAD_UNITS = ?, EXPENDITURE_UPTO_THE_MONTH = ?, EXPENDITURE_DUR_THE_MONTH = ?, entered_date = to_date('"
					+ date
					+ "','dd/mm/yyyy') where office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=?";

			pstat = conn.prepareStatement(query);

			// pstat.setString(1,enteredby);
			pstat.setFloat(1, progressActionBean.getBgtProvisionAmt());
			pstat.setFloat(2, progressActionBean.getRelUptoMon());

			pstat.setFloat(3, progressActionBean.getRelDurMon());
			pstat.setInt(4, progressActionBean.getWorkLoadUnits());
			pstat.setFloat(5, progressActionBean.getExpUptoMon());
			pstat.setFloat(6, progressActionBean.getExpDurMon());

			pstat.setString(7, officeCode);

			pstat.setString(8, month);
			pstat.setString(9, year);
			pstat.setString(10, programmeCode);
			pstat.setString(11, subprogrammeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception in UpdateFinancialProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int insertFinancialProgress(DataSource dataSource,
			FinancialProgressActionBean progressActionBean, String officeCode,
			String month, String year, String date, String enteredby,
			String programmeCode, String subprogrammeCode) {
		int count = 0;
		try {

			Debug.println("Ready to get connection");
			conn = RwsOffices.getConn();

			Debug.println("got connection");

			query = "insert into rws_financial_progress_tbl(ENTERED_BY ,BUDGET_PROVISION_AMT ,RELEASES_UPTO_THE_MONTH ,RELEASES_DUR_THE_MONTH ,WORK_LOAD_UNITS ,EXPENDITURE_UPTO_THE_MONTH ,EXPENDITURE_DUR_THE_MONTH,MONTH,YEAR,OFFICE_CODE,entered_date,PROGRAMME_CODE,SUB_PROGRAMMER_CODE  ) values(?,?,?,?,?,?,?,?,?,?,to_date('"
					+ date + "','dd/mm/yyyy'),?,?)  ";

			// to_date('"+progressActionBean.getEnteredDate()+ "','dd/mm/yyyy')
			pstat = conn.prepareStatement(query);

			pstat.setString(1, enteredby);
			// Debug.println("aaaaaaaaa"+progressActionBean.getEnteredBy());
			pstat.setFloat(2, progressActionBean.getBgtProvisionAmt());
			pstat.setFloat(3, progressActionBean.getRelUptoMon());

			pstat.setFloat(4, progressActionBean.getRelDurMon());
			pstat.setInt(5, progressActionBean.getWorkLoadUnits());
			pstat.setFloat(6, progressActionBean.getExpUptoMon());
			pstat.setFloat(7, progressActionBean.getExpDurMon());

			// pstat.setDate(48,progressActionBean.getEnteredDate());

			pstat.setString(8, month);
			pstat.setString(9, year);
			pstat.setString(10, officeCode);
			pstat.setString(11, programmeCode);
			pstat.setString(12, subprogrammeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception insertFinancialProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int DeleteFinancialProgress(DataSource dataSource,
			FinancialProgressActionBean progressActionBean, String officeCode,
			String month, String year, String programmeCode,
			String subprogrammeCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_financial_progress_tbl where  office_code=? and month=? and year=? and programme_code=? and sub_programmer_code=? ";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, officeCode);

			pstat.setString(2, month);
			pstat.setString(3, year);
			pstat.setString(4, programmeCode);
			pstat.setString(5, subprogrammeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception DeleteFinancialProgress():" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	// ---------------------------------------------------------------------------------------------------------------------------
	// For EOAT
	public int CheckEOATProgress(DataSource dataSource, String circlecode,
			int divisioncode, String subdivisioncode, String programmecode) {
		int no_pp = 0;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from rws_eoat_tbl where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=? and SUBDIVISION_OFFICE_CODE=? and programme_code=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);

			pstat.setInt(2, divisioncode);
			pstat.setString(3, subdivisioncode);
			pstat.setString(4, programmecode);

			rset = pstat.executeQuery();
			if (rset.next()) {
				if (rset.getInt("cnt") > 0) {
					no_pp = rset.getInt("cnt");
				}
			}
		} catch (Exception e) {
			Debug.println("Exception CheckEOATProgress():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public FinancialProgressActionBeant RetrieveEOATProgress(
			DataSource dataSource, String circlecode, int divisioncode,
			String subdivisioncode, String programmecode) {
		FinancialProgressActionBeant progressActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT VALUE_OF_WORK_DONE , COST_OF_WORK , VALUE_OF_WORK_BEYOND_AGREE ,VALUE_OF_WORK_TO_BE_DONE ,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') as DATE_OF_COMPLETION ,EOAT_ORDER_NO ,to_char(EOAT_DATE,'dd/mm/yyyy') as EOAT_DATE  ,COST_ESCALATION_SOUGHT ,EOAT_PERIOD ,EOAT_OLD_REF_NO1 ,to_char(EOAT_OLD_REF_DT1,'dd/mm/yyyy') as EOAT_OLD_REF_DT1  ,EOAT_OLD_REF_NO2 ,to_char(EOAT_OLD_RED_DT2,'dd/mm/yyyy') as EOAT_OLD_RED_DT2  ,FINE_IMPOSED ,FINE_RECOVERED ,REASONS_FOR_NOT_RECOV_FINE ,OFFICER_RESP1 ,OFFICER_RESP2 ,OFFICER_RESP3 ,EXEMPT_RECOMM_BY_SE ,TOTAL_DAYS_EXEMPT_BY_SE ,RATE_OF_PENALTY ,TOTAL_PENALITY ,REASONS_BY_CONTRACTOR ,CONTRACTOR_REP_MADE_UPD ,AGREEMENT_COPY_PENALITY_UPD ,SUPP_DOCUMENT_FOR_EXEMP_UPD ,AEE_RECOMMEND ,DEE_RECOMMEND ,EE_RECOMMEND ,SE_RECOMMEND ,CE_RECOMMEND ,EOAT_GRANT_AUTHORITY ,SUPP_AGREE_NO ,to_char(SUPP_AGREE_DT,'dd/mm/yyyy') as SUPP_AGREE_DT  ,PREPARED_BY,to_char(PREPARED_DATE,'dd/mm/yyyy') as PREPARED_DATE  from rws_eoat_tbl where CIRCLE_OFFICE_CODE ='"
					+ circlecode
					+ "' and DIVISION_OFFICE_CODE ='"
					+ divisioncode
					+ "' and SUBDIVISION_OFFICE_CODE ='"
					+ subdivisioncode
					+ "' and programme_code='"
					+ programmecode + "' ";
			stmt = conn.createStatement(rset.TYPE_SCROLL_INSENSITIVE,
					rset.CONCUR_UPDATABLE);
			rset = stmt.executeQuery(query);
			// to_char(ENTERED_DATE,'dd/mm/yyyy') as ENTERED_DATE
			// pstat = conn.prepareStatement(query);
			// pstat.setString(1,officecode);
			//
			// pstat.setString(2,month);
			// pstat.setString(3,year);
			// pstat.setString(4,programmeCode);
			// pstat.setString(5,subprogrammeCode);
			progressActionBean = new FinancialProgressActionBeant();
			// rset = pstat.executeQuery();
			if (rset.next()) {
				// rel=rel+rset.getFloat("RELEASES_UPTO_THE_MONTH");
				// exp=exp+rset.rset.getFloat("EXPENDITURE_UPTO_THE_MONTH");
				progressActionBean.setValWorkDone(rset
						.getFloat("VALUE_OF_WORK_DONE"));
				progressActionBean.setCostOfWork(rset.getFloat("COST_OF_WORK"));

				progressActionBean.setValWrkBAgr(rset
						.getFloat("VALUE_OF_WORK_BEYOND_AGREE"));

				progressActionBean.setValWrkToDone(rset
						.getFloat("VALUE_OF_WORK_TO_BE_DONE"));
				progressActionBean.setEoatOrderNo(rset
						.getString("EOAT_ORDER_NO"));

				progressActionBean.setCstEscSought(rset
						.getFloat("COST_ESCALATION_SOUGHT"));

				progressActionBean.setEoatPeriod(rset.getInt("EOAT_PERIOD"));

				progressActionBean.setEoatORNo1(rset
						.getString("EOAT_OLD_REF_NO1"));

				progressActionBean.setEoatORNo2(rset
						.getString("EOAT_OLD_REF_NO2"));

				progressActionBean
						.setFineImposed(rset.getFloat("FINE_IMPOSED"));

				progressActionBean.setFineRecovered(rset
						.getFloat("FINE_RECOVERED"));

				progressActionBean.setRsnsForNotRecFine(rset
						.getString("REASONS_FOR_NOT_RECOV_FINE"));

				progressActionBean.setOfficerResp1(rset
						.getString("OFFICER_RESP1"));

				progressActionBean.setOfficerResp2(rset
						.getString("OFFICER_RESP2"));

				progressActionBean.setOfficerResp3(rset
						.getString("OFFICER_RESP3"));

				progressActionBean.setExemptRecSE(rset
						.getString("EXEMPT_RECOMM_BY_SE"));

				progressActionBean.setTotDaysExemptSE(rset
						.getString("TOTAL_DAYS_EXEMPT_BY_SE"));

				progressActionBean.setRatePenalty(rset
						.getFloat("RATE_OF_PENALTY"));

				progressActionBean.setTotalPenalty(rset
						.getFloat("TOTAL_PENALITY"));

				progressActionBean.setReasonsContractor(rset
						.getString("REASONS_BY_CONTRACTOR"));

				progressActionBean.setContRepUpd(rset
						.getString("CONTRACTOR_REP_MADE_UPD"));

				progressActionBean.setAgreeCopyPenalUpd(rset
						.getString("AGREEMENT_COPY_PENALITY_UPD"));

				progressActionBean.setSuppDocExmpUpd(rset
						.getString("SUPP_DOCUMENT_FOR_EXEMP_UPD"));

				progressActionBean.setAeeRecommend(rset
						.getString("AEE_RECOMMEND"));

				progressActionBean.setDeeRecommend(rset
						.getString("DEE_RECOMMEND"));

				progressActionBean.setEeRecommend(rset
						.getString("EE_RECOMMEND"));

				progressActionBean.setSeRecommend(rset
						.getString("SE_RECOMMEND"));

				progressActionBean.setCeRecommend(rset
						.getString("CE_RECOMMEND"));

				progressActionBean.setEoatGrantAuth(rset
						.getString("EOAT_GRANT_AUTHORITY"));

				progressActionBean.setSuppAgreeNo(rset
						.getString("SUPP_AGREE_NO"));

				progressActionBean.setPreparedBy(rset.getString("PREPARED_BY"));
				progressActionBean.setDateComp(rset
						.getString("DATE_OF_COMPLETION"));
				progressActionBean.setEoatDate(rset.getString("EOAT_DATE"));
				progressActionBean.setEoatORDt1(rset
						.getString("EOAT_OLD_REF_DT1"));
				progressActionBean.setEoatORDt2(rset
						.getString("EOAT_OLD_RED_DT2"));
				progressActionBean.setSuppAgreeDt(rset
						.getString("SUPP_AGREE_DT"));
				progressActionBean.setPreparedDt(rset
						.getString("PREPARED_DATE"));

			}

		} catch (Exception e) {
			Debug.println("Exception RetrieveEOATProgress:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return progressActionBean;
	}

	public int insertEOATProgress(DataSource dataSource,
			FinancialProgressActionBeant progressActionBeant,
			String circleCode, int divisionCode, String subdivisionCode,
			String programmeCode) {
		int count = 0;
		try {

			Debug.println("Ready to get connection");
			conn = RwsOffices.getConn();
			Debug.println("got connection");
			query = "insert into rws_eoat_tbl(VALUE_OF_WORK_DONE , COST_OF_WORK , VALUE_OF_WORK_BEYOND_AGREE ,VALUE_OF_WORK_TO_BE_DONE , EOAT_ORDER_NO ,COST_ESCALATION_SOUGHT ,EOAT_PERIOD ,EOAT_OLD_REF_NO1 ,EOAT_OLD_REF_NO2 ,FINE_IMPOSED ,FINE_RECOVERED ,REASONS_FOR_NOT_RECOV_FINE ,OFFICER_RESP1 ,OFFICER_RESP2 ,OFFICER_RESP3 ,EXEMPT_RECOMM_BY_SE ,TOTAL_DAYS_EXEMPT_BY_SE ,RATE_OF_PENALTY ,TOTAL_PENALITY ,REASONS_BY_CONTRACTOR ,CONTRACTOR_REP_MADE_UPD ,AGREEMENT_COPY_PENALITY_UPD ,SUPP_DOCUMENT_FOR_EXEMP_UPD ,AEE_RECOMMEND ,DEE_RECOMMEND ,EE_RECOMMEND ,SE_RECOMMEND ,CE_RECOMMEND ,EOAT_GRANT_AUTHORITY ,SUPP_AGREE_NO ,PREPARED_BY,DISTRICT_CODE ,CIRCLE_OFFICE_CODE ,DIVISION_OFFICE_CODE ,SUBDIVISION_OFFICE_CODE ,WORK_ID ,WORK_NAME ,PROGRAMME_CODE,DATE_OF_COMPLETION ,EOAT_DATE ,EOAT_OLD_REF_DT1 ,EOAT_OLD_RED_DT2 ,SUPP_AGREE_DT ,PREPARED_DATE) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date('"
					+ progressActionBeant.getDateComp()
					+ "','dd/mm/yyyy'),to_date('"
					+ progressActionBeant.getEoatDate()
					+ "','dd/mm/yyyy'),to_date('"
					+ progressActionBeant.getEoatORDt1()
					+ "','dd/mm/yyyy'),to_date('"
					+ progressActionBeant.getEoatORDt2()
					+ "','dd/mm/yyyy'),to_date('"
					+ progressActionBeant.getSuppAgreeDt()
					+ "','dd/mm/yyyy'),to_date('"
					+ progressActionBeant.getPreparedDt()
					+ "','dd/mm/yyyy'))  ";
			// to_date('"+progressActionBean.getEnteredDate()+ "','dd/mm/yyyy')
			pstat = conn.prepareStatement(query);

			// //Debug.println("aaaaaaaaa"+progressActionBean.getEnteredBy());

			pstat.setFloat(1, progressActionBeant.getValWorkDone());
			Debug.println("aaaaaaaaa" + progressActionBeant.getValWorkDone());
			pstat.setFloat(2, progressActionBeant.getCostOfWork());
			pstat.setFloat(3, progressActionBeant.getValWrkBAgr());
			pstat.setFloat(4, progressActionBeant.getValWrkToDone());
			pstat.setString(5, progressActionBeant.getEoatOrderNo());
			pstat.setFloat(6, progressActionBeant.getCstEscSought());
			pstat.setInt(7, progressActionBeant.getEoatPeriod());
			pstat.setString(8, progressActionBeant.getEoatORNo1());
			pstat.setString(9, progressActionBeant.getEoatORNo2());
			pstat.setFloat(10, progressActionBeant.getFineImposed());
			pstat.setFloat(11, progressActionBeant.getFineRecovered());
			pstat.setString(12, progressActionBeant.getRsnsForNotRecFine());
			pstat.setString(13, progressActionBeant.getOfficerResp1());
			pstat.setString(14, progressActionBeant.getOfficerResp2());
			pstat.setString(15, progressActionBeant.getOfficerResp3());
			pstat.setString(16, progressActionBeant.getExemptRecSE());
			pstat.setString(17, progressActionBeant.getTotDaysExemptSE());
			pstat.setFloat(18, progressActionBeant.getRatePenalty());
			pstat.setFloat(19, progressActionBeant.getTotalPenalty());
			pstat.setString(20, progressActionBeant.getReasonsContractor());
			pstat.setString(21, progressActionBeant.getContRepUpd());
			pstat.setString(22, progressActionBeant.getAgreeCopyPenalUpd());
			pstat.setString(23, progressActionBeant.getSuppDocExmpUpd());
			pstat.setString(24, progressActionBeant.getAeeRecommend());
			pstat.setString(25, progressActionBeant.getDeeRecommend());
			pstat.setString(26, progressActionBeant.getEeRecommend());
			pstat.setString(27, progressActionBeant.getSeRecommend());
			pstat.setString(28, progressActionBeant.getCeRecommend());
			pstat.setString(29, progressActionBeant.getEoatGrantAuth());
			pstat.setString(30, progressActionBeant.getSuppAgreeNo());
			pstat.setString(31, progressActionBeant.getPreparedBy());
			pstat.setString(32, circleCode);
			pstat.setString(33, circleCode);
			pstat.setInt(34, divisionCode);
			pstat.setString(35, subdivisionCode);
			pstat.setString(36, "dummy");
			pstat.setString(37, "dummy");
			pstat.setString(38, programmeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception insertEOATProgress:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int UpdateEOATProgress(DataSource dataSource,
			FinancialProgressActionBeant progressActionBeant,
			String circleCode, int divisionCode, String subdivisionCode,
			String programmeCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update rws_eoat_tbl set VALUE_OF_WORK_DONE = ?,COST_OF_WORK = ?,VALUE_OF_WORK_BEYOND_AGREE = ?,VALUE_OF_WORK_TO_BE_DONE = ?,DATE_OF_COMPLETION = to_date('"
					+ progressActionBeant.getDateComp()
					+ "','dd/mm/yyyy'),EOAT_ORDER_NO = ?,EOAT_DATE = to_date('"
					+ progressActionBeant.getEoatDate()
					+ "','dd/mm/yyyy'),COST_ESCALATION_SOUGHT = ?,EOAT_PERIOD = ?,EOAT_OLD_REF_NO1 = ?,EOAT_OLD_REF_DT1 = to_date('"
					+ progressActionBeant.getEoatORDt1()
					+ "','dd/mm/yyyy'),EOAT_OLD_REF_NO2 = ?,EOAT_OLD_RED_DT2  = to_date('"
					+ progressActionBeant.getEoatORDt2()
					+ "','dd/mm/yyyy'),FINE_IMPOSED = ?,FINE_RECOVERED = ?,REASONS_FOR_NOT_RECOV_FINE = ?,OFFICER_RESP1 = ?,OFFICER_RESP2 = ?,OFFICER_RESP3 = ?,EXEMPT_RECOMM_BY_SE = ?,TOTAL_DAYS_EXEMPT_BY_SE = ?,RATE_OF_PENALTY = ?,TOTAL_PENALITY = ?,REASONS_BY_CONTRACTOR = ?,CONTRACTOR_REP_MADE_UPD = ?,AGREEMENT_COPY_PENALITY_UPD = ?,SUPP_DOCUMENT_FOR_EXEMP_UPD = ?,AEE_RECOMMEND = ?,DEE_RECOMMEND = ?,EE_RECOMMEND = ?,SE_RECOMMEND = ?,CE_RECOMMEND = ?,EOAT_GRANT_AUTHORITY = ?,SUPP_AGREE_NO = ?,SUPP_AGREE_DT = to_date('"
					+ progressActionBeant.getSuppAgreeDt()
					+ "','dd/mm/yyyy'),PREPARED_BY = ?,PREPARED_DATE = to_date('"
					+ progressActionBeant.getPreparedDt()
					+ "','dd/mm/yyyy'),WORK_ID=?,WORK_NAME =? where CIRCLE_OFFICE_CODE = ? and DIVISION_OFFICE_CODE  = ? and SUBDIVISION_OFFICE_CODE  = ? and PROGRAMME_CODE  = ?";
			// entered_date = to_date('"+date+ "','dd/mm/yyyy')
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,enteredby);
			pstat.setFloat(1, progressActionBeant.getValWorkDone());
			Debug.println("aaaaaaaaa" + progressActionBeant.getValWorkDone());
			pstat.setFloat(2, progressActionBeant.getCostOfWork());
			pstat.setFloat(3, progressActionBeant.getValWrkBAgr());
			pstat.setFloat(4, progressActionBeant.getValWrkToDone());
			pstat.setString(5, progressActionBeant.getEoatOrderNo());
			pstat.setFloat(6, progressActionBeant.getCstEscSought());
			pstat.setInt(7, progressActionBeant.getEoatPeriod());
			pstat.setString(8, progressActionBeant.getEoatORNo1());
			pstat.setString(9, progressActionBeant.getEoatORNo2());
			pstat.setFloat(10, progressActionBeant.getFineImposed());
			pstat.setFloat(11, progressActionBeant.getFineRecovered());
			pstat.setString(12, progressActionBeant.getRsnsForNotRecFine());
			pstat.setString(13, progressActionBeant.getOfficerResp1());
			pstat.setString(14, progressActionBeant.getOfficerResp2());
			pstat.setString(15, progressActionBeant.getOfficerResp3());
			pstat.setString(16, progressActionBeant.getExemptRecSE());
			pstat.setString(17, progressActionBeant.getTotDaysExemptSE());
			pstat.setFloat(18, progressActionBeant.getRatePenalty());
			pstat.setFloat(19, progressActionBeant.getTotalPenalty());
			pstat.setString(20, progressActionBeant.getReasonsContractor());
			pstat.setString(21, progressActionBeant.getContRepUpd());
			pstat.setString(22, progressActionBeant.getAgreeCopyPenalUpd());
			pstat.setString(23, progressActionBeant.getSuppDocExmpUpd());
			pstat.setString(24, progressActionBeant.getAeeRecommend());
			pstat.setString(25, progressActionBeant.getDeeRecommend());
			pstat.setString(26, progressActionBeant.getEeRecommend());
			pstat.setString(27, progressActionBeant.getSeRecommend());
			pstat.setString(28, progressActionBeant.getCeRecommend());
			pstat.setString(29, progressActionBeant.getEoatGrantAuth());
			pstat.setString(30, progressActionBeant.getSuppAgreeNo());
			pstat.setString(31, progressActionBeant.getPreparedBy());
			pstat.setString(32, "dummy");
			pstat.setString(33, "dummy");
			pstat.setString(34, circleCode);

			pstat.setInt(35, divisionCode);
			pstat.setString(36, subdivisionCode);

			pstat.setString(37, programmeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception UpdateEOATProgress:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int DeleteEOATProgress(DataSource dataSource,
			FinancialProgressActionBeant progressActionBean, String circleCode,
			int divisionCode, String subdivisionCode, String programmeCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_eoat_tbl where  CIRCLE_OFFICE_CODE  = ? and DIVISION_OFFICE_CODE  = ? and SUBDIVISION_OFFICE_CODE  = ? and PROGRAMME_CODE  = ? ";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, circleCode);

			pstat.setInt(2, divisionCode);
			pstat.setString(3, subdivisionCode);
			pstat.setString(4, programmeCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception DeleteEOATProgress:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	// -----------------------------------------------------------------------------------------------------
	// Login Form
	public String chkUserName(DataSource dataSource, String username,
			String password) {
		String test = "";
		try {
			conn = RwsOffices.getConn();
			query = "select user_id,password from rws_password_tbl where user_id = ? and password = ?";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, username);

			pstat.setString(2, password);

			rset = pstat.executeQuery();
			if (rset.next()) {
				test = "true";
			} else {
				test = "false";
			}

		} catch (Exception e) {
			Debug.println("Exception chkUserName:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return test;
	}

	// ---------------------------------------------------------------------------------------------------------------------------
	// Works Monitoring
	// ----------------
	// To check whether data exists or not in rws_work_commencement_tbl
	public int CheckWorkCommence(DataSource dataSource, String officecode) {
		int no_pp = 0;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT count(*) as cnt from rws_work_commencement_tbl where office_code=? ";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officecode);
			// pstat.setString(2,assettype);
			// pstat.setString(3,month);
			// pstat.setString(4,year);
			rset = pstat.executeQuery();
			if (rset.next()) {
				if (rset.getInt("cnt") > 0) {
					no_pp = rset.getInt("cnt");
				}
			}
		} catch (Exception e) {
			Debug.println("Exception CheckWorkCommence:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public ArrayList workProposals(DataSource dataSource) {
		ArrayList wProposals = null;
		try {
			conn = RwsOffices.getConn();
			Debug.println("aaaaaaaaaaaaaa");
			query = " SELECT WP.proposal_id, WP.proposal_name, "

					+ " WP.no_of_habs, nvl(co.circle_office_code, ''),nvl(do.division_office_code,''),"
					+ "nvl(so.subdivision_office_code, ''), WP.estimate_cost, "
					+ "wp.SANCTION_AMOUNT,NVL(WP.remarks, ''), "
					+ "TO_CHAR(WP.ADMIN_DATE ,'dd/mm/yyyy'),wp.ADMIN_NO "
					+ " FROM "
					+ " rws_work_proposal_tbl WP, rws_circle_office_tbl co, rws_division_office_tbl do, rws_subdivision_office_tbl so "
					+ " WHERE "
					+ "substr(wp.office_code,2,2)=co.circle_office_code and substr(wp.office_code,2,2)=do.circle_office_code and substr(wp.office_code,4,1) = do.division_office_code and substr(wp.office_code,2,2)=so.circle_office_code and substr(wp.office_code,4,1) = so.division_office_code and substr(wp.office_code,5,2)=so.subdivision_office_code and "
					+ " WP.flag = 'C' AND  "
					+ " WP.proposal_id NOT IN (SELECT proposal_id FROM rws_proposal_workflow_tbl) "
					// + " AND WP.sanc_office='HO'"
					+ " ORDER BY WP.prepared_on ";
			Debug.println(query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			workProposals workProp = null;
			wProposals = new ArrayList();

			while (rset.next()) {
				Debug.println(query);
				workProp = new workProposals();
				workProp.setProposalId(rset.getString(1));
				workProp.setProposalName(rset.getString(2));
				workProp.setNoOfHabs(rset.getInt(3));
				workProp.setCircleCode(rset.getString(4));
				workProp.setDivisionCode(rset.getString(5));
				workProp.setSubdivisionCode(rset.getString(6));
				workProp.setEstimateCost(rset.getFloat(7));
				workProp.setSancAmount(rset.getFloat(8));
				workProp.setRemarks(rset.getString(9));

				workProp.setGodate(rset.getString(10));
				workProp.setGomsno(rset.getString(11));

				wProposals.add(workProp);
			}

		} catch (Exception e) {
			Debug.println("Exception workProposals:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return wProposals;
	}

	/*---------------------------------------------------------------------------------------------*/
	// work status
	/*
	 * public ArrayList Works(DataSource dataSource,String circleCode,String
	 * assetCode, String programmeCode,String subprogrammeCode,int div) {
	 * ArrayList ntenderMemo = null; try { if (conn==null) { conn =
	 * RwsOffices.getConn(); } query =
	 * " SELECT distinct WORK_ID  ,WORK_NAME FROM RWS_WORK_ADMN_TBL  where " +
	 * " substr(WORK_ID,5,2) = '"+ circleCode+"'"; if(div!=0) {
	 * query=query+" and substr(office_code,4,1)="+div+""; if(assetCode!=null
	 * &&!assetCode.equals("")) {
	 * query=query+" and substr(office_code,5,2)='"+assetCode+"'";
	 * if(programmeCode!=null&&!programmeCode.equals("")) {
	 * query=query+" and substr(WORK_ID,1,2)='"+programmeCode+"'";
	 * if(subprogrammeCode!=null &&!subprogrammeCode.equals("")) {
	 * query=query+" and substr(WORK_ID,3,2)='"+subprogrammeCode+"'";
	 * 
	 * }
	 * 
	 * } } } Debug.println("query"+query); stmt = conn.createStatement(); rset =
	 * stmt.executeQuery(query); tenderMemo tendermemo = null; ntenderMemo = new
	 * ArrayList(); while (rset.next()) { tendermemo = new tenderMemo();
	 * 
	 * tendermemo.setWorkid(rset.getString("WORK_ID"));
	 * tendermemo.setWorkname(rset.getString("WORK_NAME"));
	 * 
	 * ntenderMemo.add(tendermemo); }
	 * 
	 * } catch (Exception e) { Debug.println("Exception Works:"+e); }
	 * 
	 * return ntenderMemo; }
	 */

	public ArrayList Works(DataSource dataSource, String circleCode,
			String subdiv, String programmeCode, String subprogrammeCode,
			int div, String plan, String wrkType, String workCat) // added by
	// sita
	{
		Debug.println("In getting the work details");
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where "
					+ " substr(OFFICE_CODE,2,2)='"
					+ circleCode
					+ "'"
					+ " and substr(OFFICE_CODE,4,1)='"
					+ div
					+ "'"
					+ " and PLAN_CODE ='"
					+ plan
					+ "'"
					+ " and AUG_NEW_CODE ='"
					+ wrkType + "'" + " and CATEGORY_CODE='" + workCat + "'";
			if (programmeCode != null && !programmeCode.equals(""))
				query = query.concat("and PROGRAMME_CODE='" + programmeCode
						+ "'");
			if (subprogrammeCode != null && !subprogrammeCode.equals(""))
				query = query.concat("and SUBPROGRAMME_CODE='"
						+ subprogrammeCode + "'");
			if (subdiv != null && !subdiv.equals(""))
				query = query.concat("and substr(OFFICE_CODE,5,2)='" + subdiv
						+ "'");
			Debug.println("QUERY TO GET WORKS :" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setWorkid(rset.getString("WORK_ID"));
				tendermemo.setWorkname(rset.getString("WORK_NAME"));
				ntenderMemo.add(tendermemo);
			}
		} catch (SQLException e) {
			System.err
					.println("SQL Exception occured while accessing the table");
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (Exception e) {
				}
			}
			if (stmt != null) {
				try {
					if (stmt != null)
						stmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}

		}
		return ntenderMemo;
	}

	//

	// added by ramesh on 17/12/08

	public ArrayList Works1(DataSource dataSource, String circleCode,
			String subdiv, int div, String plan, String wrkType, String workCat) // added
	// by
	// sita
	{
		Debug.println("In getting the work details");
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT WORK_ID,WORK_NAME FROM rws_work_admn_tbl where "
					+ " substr(OFFICE_CODE,2,2)='"
					+ circleCode
					+ "'"
					+ " and substr(OFFICE_CODE,4,1)='"
					+ div
					+ "'"
					+ " and PLAN_CODE ='"
					+ plan
					+ "'"
					+ " and AUG_NEW_CODE ='"
					+ wrkType + "'" + " and CATEGORY_CODE='" + workCat + "'";
			if (subdiv != null && !subdiv.equals(""))
				query = query.concat("and substr(OFFICE_CODE,5,2)='" + subdiv
						+ "'");
			Debug.println("QUERY TO GET WORKS :" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setWorkid(rset.getString("WORK_ID"));
				tendermemo.setWorkname(rset.getString("WORK_NAME"));
				ntenderMemo.add(tendermemo);
			}
		} catch (SQLException e) {
			System.err
					.println("SQL Exception occured while accessing the table");
			//e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (Exception e) {
				}
			}
			if (stmt != null) {
				try {
					if (stmt != null)
						stmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					if (conn != null)
						conn.close();
				} catch (Exception e) {
				}
			}

		}
		return ntenderMemo;
	}

	public WorksMonitoringActionBean WorksRetrieve(DataSource dataSource,
			String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			Debug.println("query");
			query = "select distinct at.NO_OF_HABS, at.WORK_NAME, at.PROGRAMME_CODE, "
					+ " at.SUBPROGRAMME_CODE, at.PREPARED_BY,at.PREPARED_ON, at.STATE_CENTRAL,"
					+ " at.WORK_ID, at.REMARKS, at.FLAG, at.PRIORITY_CODE,at.TYPE_OF_ASSET,"
					+ " at.ADMIN_NO, to_char(at.ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE , at.GOMS_NO, "
					+ " at.ADMIN_SANC_AUTH, at.SANCTION_AMOUNT,at.PHASED, at.PHASE_NO ,at.SANC_OFFICE, "
					+ "at.SPILL_OVER,  sum(h.CENSUS_PLAIN_POPU)plain ,sum(CENSUS_SC_POPU )sc,sum(CENSUS_ST_POPU )st"
					+ " from rws_work_admn_tbl at,rws_admn_hab_lnk_tbl ah,rws_habitation_directory_tbl h "
					+ "where at.work_id='"
					+ workCode
					+ "' and ah.work_id=at.work_id and ah.hab_code=h.hab_code "
					+ " group by at.NO_OF_HABS, at.WORK_NAME, at.PROGRAMME_CODE,  at.SUBPROGRAMME_CODE,"
					+ " at.PREPARED_BY,at.PREPARED_ON, at.STATE_CENTRAL, at.WORK_ID, at.REMARKS, at.FLAG, "
					+ "at.PRIORITY_CODE,at.TYPE_OF_ASSET, at.ADMIN_NO,  at.ADMIN_DATE , at.GOMS_NO, "
					+ " at.ADMIN_SANC_AUTH, at.SANCTION_AMOUNT,at.PHASED, at.PHASE_NO ,at.SANC_OFFICE,"
					+ " at.SPILL_OVER";

			Debug.println("query is ::::" + query);
			pstat = conn.prepareStatement(query);
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setHabsBen(rset.getInt("NO_OF_HABS"));
				Debug.println("rel" + rset.getInt("NO_OF_HABS"));
				worksActionBean.setSanAmt(rset.getFloat("SANCTION_AMOUNT"));
				worksActionBean.setAdmSanDate(rset.getString("ADMIN_DATE"));
				worksActionBean.setAdmSanNo(rset.getString("ADMIN_NO"));
				worksActionBean.setPlainPop(rset.getString("PLAIN"));
				worksActionBean.setScPop(rset.getString("SC"));
				worksActionBean.setStPop(rset.getString("ST"));
			}

		} catch (Exception e) {
			Debug.println("Exception WorksRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public ArrayList HabNames(DataSource dataSource, String officeCode,
			String assetCode, String programmeCode, String subprogrammeCode,
			String workCode, int nohabs) {
		int count = 0;
		ArrayList ntenderMemo = new ArrayList();
		if (nohabs > 0) {
			try {
				conn = RwsOffices.getConn();
				query = " SELECT distinct panch_name from rws_admn_hab_lnk_tbl wa,rws_panchayat_raj_tbl pr,rws_work_admn_tbl at "
						+ "   where wa.HAB_CODE = pr.PANCH_CODE and "
						+ " wa.work_id = at.work_id  "
						+ " and at.WORK_ID = '"
						+ workCode + "'";

				Debug.println("query is ::::" + query);
				pstat = conn.prepareStatement(query);
				rset = pstat.executeQuery();
				tenderMemo tendermemo = null;
				ntenderMemo = new ArrayList();
				while (rset.next()) {
					tendermemo = new tenderMemo();
					tendermemo.setHabName(rset.getString("panch_name"));
					ntenderMemo.add(tendermemo);
				}
			} catch (Exception e) {
				Debug.println("Exception HabNames:" + e);
			} finally {
				try {
					if (rset != null)
						rset.close();
					if (pstat != null)
						pstat.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}
		}
		return ntenderMemo;
	}

	public WorksMonitoringActionBean RevWorksRetrieve(DataSource dataSource,
			String officeCode, String assetCode, String programmeCode,
			String subprogrammeCode, String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT distinct at.NO_OF_HABS, at.WORK_NAME, at.PROGRAMME_CODE,  at.SUBPROGRAMME_CODE, at.ESTIMATE_COST, "
					+ "at.PREPARED_BY,at.PREPARED_ON, at.WORK_ID, at.REMARKS, at.FLAG, at.PRIORITY_CODE,at.TYPE_OF_ASSET,"
					+ " at.REV_ADMIN_NO , to_char(at.REV_ADMIN_DATE,'dd/mm/yyyy') as REV_ADMIN_DATE  ,     "
					+ "at.REV_SANCTION_AMOUNT ,at.PHASED, at.PHASE_NO from rws_revised_adm_sanc_tbl at "
					+ "where  at.WORK_ID = '" + workCode + "'";

			Debug.println("query is ::::" + query);
			pstat = conn.prepareStatement(query);
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setRevHabsBen(rset.getInt("NO_OF_HABS"));
				worksActionBean.setRevSanAmt(rset
						.getFloat("REV_SANCTION_AMOUNT"));
				worksActionBean.setRevAdmSancDate(rset
						.getString("REV_ADMIN_DATE"));
				worksActionBean.setRevAdmSanc(rset.getString("REV_ADMIN_NO"));
			}
			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS SC_POP_TOT,"
					+ "SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE IN"
					+ "(select HAB_CODE from RWS_REVISED_ADM_SANC_TBL RA,RWS_REV_ADM_SANC_HAB_LNK_TBL  RAL "
					+ "WHERE RA.WORK_ID=RAL.WORK_ID AND RA.WORK_ID='"
					+ workCode + "')";
			Debug.println("----query is :---" + query);
			PreparedStatement pstat1 = conn.prepareStatement(query);
			ResultSet rset1 = pstat1.executeQuery();
			if (rset1.next()) {
				Debug.println("setting the population values to bean");
				Debug.println("--->" + rset1.getInt("PLAIN_POP_TOT") + "");
				Debug.println("--->" + rset1.getInt("SC_POP_TOT") + "");
				Debug.println("--->" + rset1.getInt("ST_POP_TOT") + "");
				worksActionBean.setPlainPop(RwsMasterData.format(rset1
						.getInt("PLAIN_POP_TOT") + ""));
				worksActionBean.setScPop(RwsMasterData.format(rset1
						.getInt("SC_POP_TOT") + ""));
				worksActionBean.setStPop(RwsMasterData.format(rset1
						.getInt("ST_POP_TOT") + ""));
			}
		} catch (Exception e) {
			Debug.println("Exception RevWorksRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public ArrayList RevHabNames(DataSource dataSource, String officeCode,
			String assetCode, String programmeCode, String subprogrammeCode,
			String workCode, int nohabs) {
		int count = 0;
		ArrayList ntenderMemo = new ArrayList();
		if (nohabs > 0) {
			try {
				conn = RwsOffices.getConn();
				query = " SELECT  distinct panch_name from RWS_REV_ADM_SANC_HAB_LNK_TBL"
						+ " wa,rws_panchayat_raj_tbl pr,rws_revised_adm_sanc_tbl at where "
						+ " wa.HAB_CODE = pr.PANCH_CODE and  wa.work_id = at.work_id and    "
						+ " at.WORK_ID = '" + workCode + "'";

				Debug.println("query is ::::" + query);
				pstat = conn.prepareStatement(query);
				stmt.setstring(1,workCode);
				rset = pstat.executeQuery();
				tenderMemo tendermemo = null;
				ntenderMemo = new ArrayList();
				while (rset.next()) {
					tendermemo = new tenderMemo();
					tendermemo.setRevHabName(rset.getString("panch_name"));
					ntenderMemo.add(tendermemo);
				}
			} catch (Exception e) {
				Debug.println("Exception RevHabNames:" + e);
			} finally {
				try {
					if (rset != null)
						rset.close();
					if (pstat != null)
						pstat.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}
		}
		return ntenderMemo;
	}

	public int TechWorksInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode, String programmeCode,
			String SubprogrammeCode) {
		Debug.println("Trying to inser the technical sanction details.....");
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "insert into RWS_NEW_EST_TBL(office_code ,TYPE_OF_ASSET_CODE ,"
					+ " WORK_ID ,TS_GIVEN_BY      ,TS_NO     ,TS_DATE     ,TS_AMOUNT,SSR_YEAR,"
					+ " PREPARED_BY,PREPARED_ON,FINANCIAL_YEAR,SOURCE_CODE   ) "
					+ " values('"
					+ officeCode
					+ "','"
					+ assetCode
					+ "','"
					+ workCode
					+ "','"
					+ worksBean.getTechSangiven()
					+ "',"
					+ " '"
					+ worksBean.getTechSanNo()
					+ "',to_date('"
					+ worksBean.getTechSanDate()
					+ "','dd/mm/yyyy'),"
					+ " '"
					+ worksBean.getTechSanAmt()
					+ "','"
					+ worksBean.getSsrYear()
					+ "','DUMMY',"
					+ " to_date('"
					+ worksBean.getTechSanDate()
					+ "','dd/mm/yyyy'),'',"
					+ " '')  ";
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			count = pstat.executeUpdate();
			Debug.println("ssryear" + worksBean.getSsrYear());
		} catch (Exception e) {
			Debug.println("Exceptionin query TechWorksInsert" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int TechWorksUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			// conn.setAutoCommit(false);

			query = " update RWS_NEW_EST_TBL set TS_GIVEN_BY = '"
					+ worksBean.getTechSangiven() + "'," + " TS_NO = '"
					+ worksBean.getTechSanNo() + "'," + " TS_DATE = to_date('"
					+ worksBean.getTechSanDate() + "','dd/mm/yyyy'),"
					+ " TS_AMOUNT = '" + worksBean.getTechSanAmt()
					+ "',SSR_YEAR = '" + worksBean.getSsrYear() + "'"
					+ " where office_code = '" + officeCode
					+ "' and TYPE_OF_ASSET_CODE = '" + assetCode + "' and "
					+ " work_id = '" + workCode + "'";

			Debug.println("query" + query);
			// entered_date = to_date('"+date+ "','dd/mm/yyyy')

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			//Debug.println("sssssssssssssssssssssssssssssssssssss");
			// pstat.setString(1,enteredby);

			// pstat.setString(1,worksBean.getTechSangiven());
			// pstat.setString(2,worksBean.getTechSanNo());
			// pstat.setFloat(3,worksBean.getTechSanAmt());
			// pstat.setString(4,worksBean.getSsrYear());
			// pstat.setString(5,officeCode);
			// pstat.setString(6,assetCode);
			// pstat.setString(7,workCode);
			Debug.println("ssryear" + worksBean.getSsrYear());
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			count = pstat.executeUpdate();

			/*
			 * query1 =
			 * "update RWS_WORK_ADMN_TBL set ESTIMATE_COST = ? where office_code = '"
			 * + officeCode + "' and TYPE_OF_ASSET = '" + assetCode + "' and " +
			 * " work_id = '" + workCode + "'" ;
			 * 
			 * pstat1 = conn.prepareStatement(query1);
			 * 
			 * Debug.println("sssssssssssssssssssssssssssssssssssss");
			 * pstat1.setFloat(1,worksBean.getAdmCost()); rset1 =
			 * pstat1.executeQuery(); count =pstat1.executeUpdate();
			 * 
			 * 
			 * 
			 * conn.commit();
			 * 
			 * conn.setAutoCommit(true);
			 */

		} catch (Exception e) {
			Debug.println("Exceptionin query TechWorksUpdate" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int TechWorkidUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update RWS_NEW_EST_TBL set TS_GIVEN_BY = '"
					+ worksBean.getTechSangiven() + "'," + " TS_NO = '"
					+ worksBean.getTechSanNo() + "'," + " TS_DATE = to_date('"
					+ worksBean.getTechSanDate() + "','dd/mm/yyyy'),"
					+ " TS_AMOUNT = '" + worksBean.getTechSanAmt()
					+ "',SSR_YEAR = '" + worksBean.getSsrYear() + "',"
					+ " office_code = '" + officeCode
					+ "',TYPE_OF_ASSET_CODE = '" + assetCode + "' where "
					+ " work_id = '" + workCode + "'";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exceptionin query TechWorkidUpdate" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int TechWorksDelete(DataSource dataSource, String officeCode,
			String assetCode, String workCode) {
		Debug.println("trying to delete the details of technical sanction");
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String query1 = " delete from  RWS_EST_NEW_HAB_LNK_TBL where  WORK_ID = '"
					+ workCode + "'";
			query = "delete from RWS_NEW_EST_TBL where  WORK_ID = '" + workCode
					+ "'";
			Debug.println("trying to delete the details of technical sanction"
					+ query);
			PreparedStatement pstat1 = conn.prepareStatement(query1);
			pstat = conn.prepareStatement(query);
			count = pstat1.executeUpdate();
			count = pstat.executeUpdate();
			conn.commit();
		} catch (Exception e) {
			Debug.println("Exception while trying to delete the tech sanction data -TechWorksDelete(): "
					+ e);

		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int TechWorksAdmCostDelete(DataSource dataSource, String officeCode,
			String ProgrammeCode, String SubProgrammeCode, String assetCode,
			String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "update RWS_WORK_ADMN_TBL set ESTIMATE_COST = '0.0' where  office_code = ? and TYPE_OF_ASSET = ? "
					+ " and WORK_ID = ? and PROGRAMME_CODE = ? and SUBPROGRAMME_CODE = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officeCode);
			pstat.setString(2, assetCode);
			pstat.setString(3, workCode);
			pstat.setString(4, ProgrammeCode);
			pstat.setString(5, SubProgrammeCode);
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception TechWorksAdmCostDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int RevTechWorksDelete(DataSource dataSource, String officeCode,
			String assetCode, String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_new_revised_est_tbl where  office_code = ? "
					+ " and WORK_ID = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officeCode);
			pstat.setString(2, workCode);
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception RevTechWorksDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int RevTechWorksAdmCostDelete(DataSource dataSource,
			String officeCode, String ProgrammeCode, String SubProgrammeCode,
			String assetCode, String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "update RWS_REVISED_ADM_SANC_TBL  set ESTIMATE_COST = '0.0' where  office_code = ? and TYPE_OF_ASSET = ? "
					+ " and WORK_ID = ? and PROGRAMME_CODE = ? and SUBPROGRAMME_CODE = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, officeCode);
			pstat.setString(2, assetCode);
			pstat.setString(3, workCode);
			pstat.setString(4, ProgrammeCode);
			pstat.setString(5, SubProgrammeCode);
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception RevTechWorksAdmCostDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public String getAdminWorkDate(DataSource ds, String workId)
			throws Exception {
		java.util.Date d = new java.util.Date();
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
				"dd/MM/yyyy");
		String AdminWorkDate = format.format(d);
		try {
			Connection conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			Debug.println("select to_char(ADMIN_DATE,'dd/mm/yyyy')  from rws_work_admn_tbl "
					+ "where work_id='" + workId + "'");
			rset = stmt
					.executeQuery("select to_char(ADMIN_DATE,'dd/mm/yyyy')  from rws_work_admn_tbl "
							+ "where work_id='" + workId + "'");

			if (rset.next()) {
				AdminWorkDate = rset.getString(1);
			}

		} catch (Exception e) {
			Debug.println("Exception getAdminWorkDate:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return AdminWorkDate;
	}

	public int TechWorksHabsDelete(DataSource dataSource, String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_est_new_hab_lnk_tbl where  WORK_ID = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, workCode);
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception TechWorksHabsDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int RevTechWorksHabsDelete(DataSource dataSource, String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_rev_est_new_hab_lnk_tbl where  WORK_ID = ?";
			pstat = conn.prepareStatement(query);

			pstat.setString(1, workCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception RevTechWorksHabsDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public WorksMonitoringActionBean adminDataRetrive(DataSource dataSource,
			String officeCode, String assetCode, String workCode) {
		int count = 0;
		Debug.println("Trying to get admin details if technical details are not present");
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT   SANCTION_AMOUNT from "
					+ "  RWS_WORK_ADMN_TBL   where " + "   WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setSanAmt(rset.getFloat(1));
			}
			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS SC_POP_TOT,"
					+ "SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE IN"
					+ "(select HAB_CODE from rws_work_admn_tbl e,RWS_ADMN_HAB_LNK_TBL  EL "
					+ "WHERE E.WORK_ID=EL.WORK_ID AND E.WORK_ID='"
					+ workCode
					+ "')";
			Debug.println("query is " + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setPlainPop(RwsMasterData.format(rset
						.getInt("PLAIN_POP_TOT") + ""));
				worksActionBean.setScPop(RwsMasterData.format(rset
						.getInt("SC_POP_TOT") + ""));
				worksActionBean.setStPop(RwsMasterData.format(rset
						.getInt("ST_POP_TOT") + ""));
			}
			Debug.println("plain pop is " + worksActionBean.getPlainPop());
			Debug.println("sc pop is " + worksActionBean.getScPop());
			Debug.println("st pop is " + worksActionBean.getStPop());

		} catch (Exception e) {
			Debug.println("Exception adminDataRetrive:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public WorksMonitoringActionBean TechWorksRetrieve(DataSource dataSource,
			String officeCode, String assetCode, String workCode) {
		int count = 0;
		Debug.println("in TechWorksRetrieve");
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT distinct TS_GIVEN_BY,TS_NO,TS_AMOUNT,to_char(TS_DATE,'dd/mm/yyyy') as TS_DATE,"
					+ " ssr_year,wa.SANCTION_AMOUNT from rws_new_est_tbl ne,RWS_WORK_ADMN_TBL wa"
					+ " where ne.WORK_ID = wa.WORK_ID and ne.OFFICE_CODE = wa.OFFICE_CODE and "
					+ " wa.TYPE_OF_ASSET = ne.TYPE_OF_ASSET_CODE and"
					+ " ne.OFFICE_CODE = '"
					+ officeCode
					+ "'and ne.TYPE_OF_ASSET_CODE  = '"
					+ assetCode
					+ "' "
					+ " and ne.WORK_ID = '" + workCode + "'";
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean = new WorksMonitoringActionBean();
				worksActionBean.setTechSangiven(rset.getString(1));
				worksActionBean.setTechSanNo(rset.getString(2));
				worksActionBean.setTechSanDate(rset.getString(4));
				worksActionBean.setTechSanAmt(rset.getFloat(3));
				worksActionBean.setSsrYear(rset.getString(5));
				worksActionBean.setSanAmt(rset.getFloat(6));
			}
			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS SC_POP_TOT,"
					+ "SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE IN"
					+ "(select HAB_CODE from rws_new_est_tbl e,RWS_EST_NEW_HAB_LNK_TBL EL "
					+ "WHERE E.WORK_ID=EL.WORK_ID AND E.WORK_ID='"
					+ workCode
					+ "')";
			Debug.println("query is " + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setPlainPop(RwsMasterData.format(rset
						.getInt("PLAIN_POP_TOT") + ""));
				worksActionBean.setScPop(RwsMasterData.format(rset
						.getInt("SC_POP_TOT") + ""));
				worksActionBean.setStPop(RwsMasterData.format(rset
						.getInt("ST_POP_TOT") + ""));
			}
			Debug.println("plain pop is " + worksActionBean.getPlainPop());
			Debug.println("sc pop is " + worksActionBean.getScPop());
			Debug.println("st pop is " + worksActionBean.getStPop());

		} catch (Exception e) {
			Debug.println("Exception TechWorksRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public WorksMonitoringActionBean TechWorksSanAmtRetrieve(
			DataSource dataSource, String officeCode, String assetCode,
			String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT SANCTION_AMOUNT from RWS_WORK_ADMN_TBL "
					+ " where " + " OFFICE_CODE = '" + officeCode
					+ "'and TYPE_OF_ASSET  = '" + assetCode + "' "
					+ " and WORK_ID = '" + workCode + "'";
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setSanAmt(rset.getFloat(1));
			}
		} catch (Exception e) {
			Debug.println("Exception TechWorksSanAmtRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public String[] getMandalCodesFormTechnicalSanction(DataSource ds,
			String workId) throws Exception {
		Connection conn = null;
		String[] mcodes = new String[50];

		try {
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			Statement stmtNew = conn.createStatement();
			Statement stmtNew2 = conn.createStatement();
			ResultSet rsNew = stmtNew
					.executeQuery("SELECT * from rws_est_new_hab_lnk_tbl where WORK_ID = '"
							+ workId + "'");
			if (rsNew.next()) {
				query = "select distinct substr(hab_code,6,2) from rws_est_new_hab_lnk_tbl  where WORK_ID ='"
						+ workId + "'";
			} else {
				ResultSet rsNew2 = stmtNew2
						.executeQuery("SELECT * from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID = '"
								+ workId + "'");
				if (rsNew2.next()) {
					query = "select distinct substr(hab_code,6,2) from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID ='"
							+ workId + "'";
				} else {
					query = "select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL where WORK_ID ='"
							+ workId + "'";
				}
			}
			Debug.println("Query in getMandalCodesFormTechnicalSanction is:"
					+ query);
			rset = stmt.executeQuery(query);
			int i = 0;
			while (rset.next()) {

				if (rset.getString(1) != null) {
					mcodes[i] = rset.getString(1);
					i++;
				}
			}

		} catch (Exception e) {
			Debug.println("Exception is getMandalCodesFormTechnicalSanction:##"
					+ e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return mcodes;
	}

	public String[] getMandalCodesFormWorkCompletion(DataSource ds,
			String workId) throws Exception {
		Connection conn = null;
		String[] mcodes = new String[50];

		try {
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			Statement stmtNew = conn.createStatement();
			Statement stmtNew2 = conn.createStatement();

			ResultSet rsNew = stmtNew
					.executeQuery("SELECT * from RWS_WORK_COMPLETION_TBL where WORK_ID = '"
							+ workId + "'");
			if (rsNew.next()) {
				query = "select distinct substr(hab_code,6,2) from RWS_WORK_COMP_HAB_LNK_TBL  where WORK_ID ='"
						+ workId + "'";
			} else {

				rsNew = stmtNew
						.executeQuery("SELECT * from rws_est_new_hab_lnk_tbl where WORK_ID = '"
								+ workId + "'");
				if (rsNew.next()) {
					query = "select distinct substr(hab_code,6,2) from rws_est_new_hab_lnk_tbl  where WORK_ID ='"
							+ workId + "'";
				} else {
					ResultSet rsNew2 = stmtNew2
							.executeQuery("SELECT * from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID = '"
									+ workId + "'");
					if (rsNew2.next()) {
						query = "select distinct substr(hab_code,6,2) from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID ='"
								+ workId + "'";
					} else {
						query = "select distinct substr(hab_code,6,2) from RWS_ADMN_HAB_LNK_TBL where WORK_ID ='"
								+ workId + "'";
					}
				}
			}
			Debug.println("Query in getMandalCodesFormTechnicalSanction is:"
					+ query);
			ResultSet rs = stmt.executeQuery(query);
			int i = 0;
			while (rs.next()) {

				if (rs.getString(1) != null) {
					mcodes[i] = rs.getString(1);
					i++;
				}
			}

		} catch (Exception e) {
			Debug.println("Exception is getMandalCodesFormTechnicalSanction:##"
					+ e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return mcodes;
	}

	public ArrayList getHabitations(DataSource dataSource, String officeCode,
			String search, String[] selHabCodes, String All, String[] mcodes)
			throws Exception {
		ArrayList habitations = new ArrayList();
		String[] temp = new String[200];
		if (All.equals("yes")) {
			try {
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				if (officeCode == null)
					officeCode = "000000";
				String circleOfficeCode = officeCode.substring(1, 3);
				String divisionOfficeCode = officeCode.substring(3, 4);
				String subdivisionOfficeCode = officeCode.substring(4, 6);
				Debug.println("coc" + circleOfficeCode);

				query = " SELECT  distinct P.panch_code, P.panch_name, "
						+ " (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
						+ " H.coverage_status,con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,m.mname  FROM rws_panchayat_raj_tbl P,rws_constituency_tbl con,rws_mandal_tbl m, "
						+ " rws_habitation_directory_tbl H "
						+ " WHERE P.panch_code = H.hab_code AND    substr(h.hab_code,3,3)=con.CONSTITUENCY_CODE "
						+ "and con.CONSTITUENCY_TYPE ='A' and"
						+ " m.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and"
						+ " H.circle_office_code = '"
						+ circleOfficeCode
						+ "' order by con.CONSTITUENCY_NAME,m.mname,p.panch_name asc";

				Debug.println("Select Habitations Query is : ");
				Debug.println(query);
				rset = stmt.executeQuery(query);
				RwsLocationBean rwsLocation = null;

				while (rset.next()) {
					Debug.println("selHabcodes" + selHabCodes.length);
					rwsLocation = new RwsLocationBean();

					for (int i = 0; i < selHabCodes.length; i++) {
						try {

							if (selHabCodes[i] != null
									&& selHabCodes[i].equals(rset.getString(1))) {
								rwsLocation.setHabMatch("checked");

							}

						} catch (Exception e) {
							Debug.println("Exception is " + e);
						}
					}
					rwsLocation.setHabCode(rset.getString(1));
					rwsLocation.setHabName(rset.getString(2));
					rwsLocation.setPopulation(rset.getString(3));
					rwsLocation.setStatus(rset.getString(4));
					rwsLocation.setConstituencyCode(rset.getString(5));
					rwsLocation.setConstituencyName(rset.getString(6));
					rwsLocation.setMandalName(rset.getString(7));
					habitations.add(rwsLocation);
				}

				releaseConnection();
			} catch (Exception e) {
				Debug.println("exception getHabitations:" + e);
			}
		} else {
			try {
				conn = RwsOffices.getConn();
				stmt = conn.createStatement();
				if (officeCode == null)
					officeCode = "000000";
				String circleOfficeCode = officeCode.substring(1, 3);
				String divisionOfficeCode = officeCode.substring(3, 4);
				String subdivisionOfficeCode = officeCode.substring(4, 6);
				Debug.println("coc" + circleOfficeCode);

				for (int j = 0; j < mcodes.length; j++) {
					if (mcodes[j] != null) {
						query = " SELECT distinct P.panch_code, P.panch_name, "
								+ " (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
								+ " H.coverage_status,con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,m.mname  FROM rws_panchayat_raj_tbl P,rws_constituency_tbl con,rws_mandal_tbl m, "
								+ " rws_habitation_directory_tbl H "
								+ " WHERE P.panch_code = H.hab_code AND    substr(h.hab_code,3,3)=con.CONSTITUENCY_CODE "
								+ "and con.CONSTITUENCY_TYPE ='A' and"
								+ " m.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and"
								+ " H.circle_office_code = '"
								+ circleOfficeCode
								+ "' and m.mcode='"
								+ mcodes[j]
								+ "'"
								+ " order by con.CONSTITUENCY_NAME,m.mname,p.panch_name asc";

						Debug.println("Select Habitations Query is : ");
						Debug.println(query);
						rset = stmt.executeQuery(query);
						RwsLocationBean rwsLocation = null;

						while (rset.next()) {
							Debug.println("selHabcodes" + selHabCodes.length);
							rwsLocation = new RwsLocationBean();

							for (int i = 0; i < selHabCodes.length; i++) {
								try {

									if (selHabCodes[i] != null
											&& selHabCodes[i].equals(rset
													.getString(1))) {
										rwsLocation.setHabMatch("checked");

									}

								} catch (Exception e) {
									Debug.println("Exception is " + e);
								}
							}
							rwsLocation.setHabCode(rset.getString(1));
							rwsLocation.setHabName(rset.getString(2));
							rwsLocation.setPopulation(rset.getString(3));
							rwsLocation.setStatus(rset.getString(4));
							rwsLocation.setConstituencyCode(rset.getString(5));
							rwsLocation.setConstituencyName(rset.getString(6));
							rwsLocation.setMandalName(rset.getString(7));
							habitations.add(rwsLocation);
						}
					}
				}
				releaseConnection();
			} catch (Exception e) {
				Debug.println("exception getHabitations:" + e);
			} finally {
				try {
					if (rset != null)
						rset.close();
					if (stmt != null)
						stmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}
		}
		return habitations;
	}

	public ArrayList getTempSelectedHabs(DataSource dataSource)
			throws Exception {
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		ArrayList tempSelectedHabs = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stat = conn.createStatement();
			String query = " SELECT T.proposal_id, P.panch_code, P.panch_name, D.coverage_status, "
					+ " (D.census_plain_popu+D.census_sc_popu+D.census_st_popu) "
					+ " FROM rws_temp_proposal_hab_tbl T, rws_panchayat_raj_tbl P, "
					+ " rws_habitation_directory_tbl D "
					+ " WHERE D.hab_code = T.hab_code AND P.panch_code = D.hab_code ";
			// + " AND T.proposal_id = '" + proposalId + "'";
			Debug.println("query" + query);
			rset = stat.executeQuery(query);
			RwsLocationBean rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new RwsLocationBean();
				rwsLocationBean.setProposalId(rset.getString(1));
				rwsLocationBean.setHabCode(rset.getString(2));
				rwsLocationBean.setHabName(rset.getString(3));
				rwsLocationBean.setStatus(rset.getString(4));
				rwsLocationBean.setPopulation(rset.getString(5));
				tempSelectedHabs.add(rwsLocationBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getTempSelectedHabs() : " + e);

		} finally {
			if (rset != null)
				rset.close();
			stat.close();
			if (conn != null)
				conn.close();

		}
		return tempSelectedHabs;
	}

	public ArrayList insertProposalTempHabs(DataSource dataSource,
			String[] habCodes, String workid) throws Exception {
		String code = workid.substring(6, 8);
		Connection conn = null;
		Statement stat = null;
		String[] updateCounts = new String[200];
		ArrayList ntenderMemo = null;
		PreparedStatement psmt = null;
		try {
			conn = RwsOffices.getConn();
			if (!(code.equals("11") || code.equals("12")|| code.equals("13")|| code.equals("14"))) {
				psmt = conn
						.prepareStatement("select panch_name from rws_panchayat_raj_tbl where panch_code = ?");
			} else if (code.equals("11")) {
				psmt = conn
						.prepareStatement("select panch_name from rws_panchayat_raj_tbl where panch_code = ?");
			} else if (code.equals("12")) {
				psmt = conn
						.prepareStatement("select lab_name from RWS_WATER_QUALITY_LAB_TBL  where lab_code = ?");
			} else if (code.equals("13")) {
				psmt = conn
						.prepareStatement("select SCH_NAME from IMIS_ANGANWADIES_TBL WHERE  HABCODE= ?");
			} else if (code.equals("14")) {
				psmt = conn
						.prepareStatement("select LOCATION from IMIS_PUBLIC_INSTITUTIONS_TBL  where HABCODE = ?");
			}
 			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			for (int i = 0; i < habCodes.length; i++) {
				psmt.setString(1, habCodes[i]);
				rset = psmt.executeQuery();
				if (habCodes[i] != null)
					if (rset.next()) {
						tendermemo = new tenderMemo();

						tendermemo.setSelHabNames(rset.getString(1));

						ntenderMemo.add(tendermemo);
					}
			}

		} catch (Exception e) {
			Debug.println("Exception in insertProposalTempHabs : " + e);

		} finally {
			psmt.close();
			if (rset != null)
				rset.close();
			if (conn != null)
				conn.close();

		}

		return ntenderMemo;
	}

	public int CheckTechSanc(DataSource dataSource, String officecode,
			String assetCode, String workCode) {
		int no_pp = 0;
		try {

			conn = RwsOffices.getConn();

			query = "SELECT count(*) as cnt from RWS_NEW_EST_TBL where office_code='"
					+ officecode
					+ "'"
					+ " and TYPE_OF_ASSET_CODE  = '"
					+ assetCode + "'" + " and WORK_ID = '" + workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}
				Debug.println("no_pp" + rset.getInt(1));
			}
		} catch (Exception e) {
			Debug.println("Exception CheckTechSanc:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public int TechWorkidCheck(DataSource dataSource, String workCode) {
		int no_pp = 0;

		try {

			conn = RwsOffices.getConn();

			query = "SELECT count(*) as cnt from RWS_NEW_EST_TBL where  WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}
				Debug.println("no_pp" + rset.getInt(1));
			}
		} catch (Exception e) {
			Debug.println("Exception TechWorkidCheck:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public float getRevisedAmount(DataSource ds, String workId) {
		float revAmnt = 0.0f;
		try {
			Connection conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			Debug.println("select REV_SANCTION_AMOUNT  from RWS_REVISED_ADM_SANC_TBL"
					+ " where WORK_ID ='" + workId + "'");
			ResultSet rs = stmt
					.executeQuery("select REV_SANCTION_AMOUNT  from RWS_REVISED_ADM_SANC_TBL"
							+ " where WORK_ID ='" + workId + "'");
			while (rs.next()) {
				revAmnt = rs.getFloat(1);
			}
		} catch (Exception e) {
			Debug.println("Exception getRevisedAmount:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return revAmnt;
	}

	public int TechWorksHabsCheck(DataSource dataSource, String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();

			query = "SELECT count(*) as cnt from rws_est_new_hab_lnk_tbl where WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception TechWorksHabsCheck::" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public String[] adminWorksHabsRetrieve(DataSource dataSource,
			String workCode, int count) {
		int i = 0;
		Debug.println("in adminWorksHabsRetrieve()");
		String[] habCodes = new String[200];
		try {
			conn = RwsOffices.getConn();
			String qry = "select * from RWS_REV_ADM_SANC_HAB_LNK_TBL where WORK_ID = '"
					+ workCode + "'";
			Debug.println(qry);
			Statement stmtNew = conn.createStatement();
			ResultSet rs = stmtNew.executeQuery(qry);
			if (rs.next()) {
				query = "SELECT hab_code from RWS_REV_ADM_SANC_HAB_LNK_TBL  where WORK_ID = '"
						+ workCode + "'";
			} else {
				query = "SELECT hab_code from RWS_ADMN_HAB_LNK_TBL  where WORK_ID = '"
						+ workCode + "'";
			}
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			while (rset.next()) {
				habCodes[i] = rset.getString(1);

				i++;
			}

		} catch (Exception e) {
			Debug.println("Exception adminWorksHabsRetrieve::" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return habCodes;
	}

	public int getWorksCompletionHabs(DataSource ds, String workId)
			throws Exception {
		Debug.println("in getWorksCompletionHabs()");
		int count = 0;
		Connection conn = RwsOffices.getConn();
		try {

			Statement stmt = conn.createStatement();

			String query = "select count(*) from rws_work_comp_hab_lnk_tbl where work_id='"
					+ workId + "'";
			Debug.println(query);

			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				count = rs.getInt(1);
				Debug.println("No of.habs are:" + count);

			}

		} catch (Exception e) {
			Debug.println("Exception in getWorksCompletionHabs is :" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}


	public String[] getWorkCompHabs(DataSource dataSource, String workCode,
			int count, String table, HttpServletRequest request) {
		int i = 0;
		String code = workCode.substring(6, 8);
		String[] habCodes = null;
		try {

			conn = RwsOffices.getConn();
			if (!(code.equals("11") || code.equals("12")|| code.equals("13")|| code.equals("14"))) {
				query = "SELECT hab_code from " + table + " where WORK_ID = '"
						+ workCode + "'";
			} else if (code.equals("11")) {
				query = "SELECT hab_code from RWS_WORK_SCHOOL_LNK_TBL where WORK_ID = '"
						+ workCode + "'";
			} else if (code.equals("14")) {
				query = "SELECT hab_code from RWS_WORK_pi_LNK_TBL where WORK_ID = '"
						+ workCode + "'";
			} else if (code.equals("13")) {
				query = "SELECT hab_code from RWS_WORK_ANGANWADI_LNK_TBL where WORK_ID = '"
						+ workCode + "'";
			} else {
				query = "SELECT lab_code from RWS_WORK_LAB_LNK_TBL where WORK_ID = '"
						+ workCode + "'";
			}
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			rset = stmt.executeQuery(query);
			rset.last();
			int Count = rset.getRow();
			habCodes = new String[Count];
			rset.beforeFirst();
			while (rset.next()) {
				habCodes[i] = rset.getString(1);
				i++;
			}
			request.setAttribute("tothabsben", "" + i);
		} catch (Exception e) {
			Debug.println("Exception getWorkCompHabs:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return habCodes;
	}

	public ArrayList getHabsDetails(String workId) throws Exception {

		ArrayList list = null;
		ResultSet rs = null,rs1 = null;
		PreparedStatement prpStmt = null,prpStmt1 = null;

		try {
			final Calendar cal = Calendar.getInstance();
		    DateFormat dateFormat = new SimpleDateFormat("MM-yyyy");
	        String currMonth = dateFormat.format(cal.getTime());
	        
			conn = RwsOffices.getConn();
			String sqlQuery = " SELECT mname,panch_code, panch_name, (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu),HD.coverage_status,nvl(pr.stand_posts,0),nvl(pr.house_conn,0),nvl(HOUSEHOLD_NO,0),nvl(pr.distribution_length,0) FROM RWS_WORK_COMP_HAB_LNK_TBL PR, rws_complete_hab_view HD,rws_habitation_directory_tbl h WHERE hd.panch_code = pr.hab_code  and pr.hab_code = h.hab_code  and hd.panch_code = h.hab_code and pr.work_id=?";
			prpStmt = conn.prepareStatement(sqlQuery);
			prpStmt.setString(1, workId);
			nic.watersoft.commons.RwsLocationBean rwsLocationBean = null;
			list = new ArrayList();
			rs = prpStmt.executeQuery();
			while (rs.next()) {
				rwsLocationBean = new nic.watersoft.commons.RwsLocationBean();
				rwsLocationBean.setMandalName(rs.getString(1));
				rwsLocationBean.setHabCode(rs.getString(2));
				rwsLocationBean.setHabName(rs.getString(3));
				rwsLocationBean.setPopulation(rs.getString(4));
				rwsLocationBean.setStatus(rs.getString(5));
				rwsLocationBean.setStandPosts(rs.getString(6));
				rwsLocationBean.setHouseCons(rs.getString(7));
				rwsLocationBean.setHouseHolds(rs.getString(8));
				rwsLocationBean.setDistributionLength(rs.getString(9));
				
				String hHQuery = "select ( select count(1) from RWS_HOUSEHOLD_TAPSURVEY_TBL where HAB_CODE='"+rs.getString(2)+"') as totalHC, "+
						"(select count(1) from RWS_HOUSEHOLD_TAPSURVEY_TBL where HAB_CODE='"+rs.getString(2)+"' and to_char(INSERTED_DATE,'mm-yyyy')='"+currMonth+"') as tillNowHC,"+
						"(select count(1) from rws_individual_tap_conn where HAB_CODE='"+rs.getString(2)+"' )  as invTotal,"+
						"(select count(1) from rws_individual_tap_conn where HAB_CODE='"+rs.getString(2)+"' and to_char(INSERTED_DATE,'mm-yyyy')='"+currMonth+"') as tillNowINV,"+
						"(select count(1) from RWS_SCHOOL_MASTER_TBL where SCHOOL_CATEGORY_CODE<>'01' and HAB_CODE='"+rs.getString(2)+"' )  as schoolTotal, "+
						"(select count(1) from RWS_SCHOOL_MASTER_TBL where SCHOOL_CATEGORY_CODE<>'01' and HAB_CODE='"+rs.getString(2)+"' and to_char(UPDATE_DATE,'mm-yyyy')='"+currMonth+"') as schoolINV, "+
						"(select count(1) from RWS_SCHOOL_MASTER_TBL where SCHOOL_CATEGORY_CODE='01' and HAB_CODE='"+rs.getString(2)+"' )  as aganwadiTotal, "+
						"(select count(1) from RWS_SCHOOL_MASTER_TBL where SCHOOL_CATEGORY_CODE='01' and HAB_CODE='"+rs.getString(2)+"' and to_char(UPDATE_DATE,'mm-yyyy')='"+currMonth+"') as aganwadiINV, "+
						"(select TOTALHOUSEHOLDS from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(2)+"') as TOTALHOUSEHOLDS, "+
						"(select TOTALHOUSECONNECTIONGIVEN from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(2)+"') as TOTALHOUSECONNECTIONGIVEN, "+
						"(select BALANCEFHTCTOBEGIVEN from IMISMASTERDATA_TBL where HABCODE='"+rs.getString(2)+"') as BALANCEFHTCTOBEGIVEN "+
						"from dual";
		prpStmt1 = conn.prepareStatement(hHQuery);
		///prpStmt1.setString(1, rs.getString(2));
		rs1 = prpStmt1.executeQuery();
		while(rs1.next()){
			rwsLocationBean.setHouseCons(String.valueOf(rs1.getInt(1)));
			rwsLocationBean.setCurrMonthHC(String.valueOf(rs1.getInt(2)));
			rwsLocationBean.setInvTapTot(String.valueOf(rs1.getInt(3)));
			rwsLocationBean.setInvTapCurr(String.valueOf(rs1.getInt(4)));
			rwsLocationBean.setSchoolTapTot(String.valueOf(rs1.getInt(5)));
			rwsLocationBean.setSchoolTapCurr(String.valueOf(rs1.getInt(6)));
			rwsLocationBean.setAganwadiTaptot(String.valueOf(rs1.getInt(7)));
			rwsLocationBean.setAganwadiTapCurr(String.valueOf(rs1.getInt(8)));
			rwsLocationBean.setTothouseholdsIMIS(String.valueOf(rs1.getInt(9)));
			rwsLocationBean.setTothouseconnIMIS(String.valueOf(rs1.getInt(10)));
			rwsLocationBean.setBalHouseConn(String.valueOf(rs1.getInt(11)));

		}
		
				list.add(rwsLocationBean);
			}

			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			System.err
					.println("SQL Exception occured while accessing the table");
			return null;
		} catch (Exception e) {
			Debug.println("Exception in getHabsDetails"+e);
			return null;
		} finally {
			if (prpStmt != null)
				prpStmt.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		return list;
	}

	public int getRevisecCount(DataSource ds, String workid) throws Exception {
		int count = 0;
		try {
			Connection conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			Debug.println("select Count(*) from RWS_REV_EST_NEW_HAB_LNK_TBL where work_id='"
					+ workid + "'");
			ResultSet rs = stmt
					.executeQuery("select Count(*) from RWS_REV_EST_NEW_HAB_LNK_TBL where work_id='"
							+ workid + "'");
			if (rs.next()) {
				count = rs.getInt(1);
				Debug.println("Count is ********" + count);
			}
		} catch (Exception e) {
			Debug.println("Exception in getRevisecCount is :" + e);

		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public String[] revTechWorksHabsRetrieve(DataSource dataSource,
			String workCode, int count) throws Exception {
		int i = 0;
		String[] habCodes = new String[200];
		try {
			conn = RwsOffices.getConn();

			query = "SELECT hab_code from RWS_REV_EST_NEW_HAB_LNK_TBL where WORK_ID = ?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				habCodes[i] = rset.getString(1);

				i++;
			}

		} catch (Exception e) {
			Debug.println("Exception in revTechWorksHabsRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return habCodes;
	}

	public String[] TechWorksHabsRetrieve(DataSource dataSource,
			String workCode, int count) {
		Debug.println("+++++++++++Trying to get the technical sanctione dhabs+++++++++++++");
		int i = 0;
		String[] habCodes = new String[200];
		try {
			conn = RwsOffices.getConn();
			query = "SELECT hab_code from rws_est_new_hab_lnk_tbl where WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			while (rset.next()) {
				habCodes[i] = rset.getString(1);

				i++;
			}

		} catch (Exception e) {
			Debug.println("Exception TechWorksHabsRetrieve: " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return habCodes;
	}

	public int TechWorksHabsInsert(DataSource dataSource, String workCode,
			String[] habCodes) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			query = "insert into rws_est_new_hab_lnk_tbl(WORK_ID ,hab_code) "
					+ " values(?,?)  ";
			for (int i = 0; i < habCodes.length; i++) {

				Debug.println("insert into RWS_EST_NEW_HAB_LNK_TBL(work_id,hab_code)"
						+ "values('" + workCode + "','" + habCodes[i] + "')");
				pstat = conn.prepareStatement(query);
				if (habCodes[i] != null) {
					pstat.setString(1, workCode);

					pstat.setString(2, habCodes[i]);
					count = pstat.executeUpdate();
				}

			}

		} catch (Exception e) {
			Debug.println("Exception TechWorksHabsInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int TechWorksHabsUpdate(DataSource dataSource, String workCode,
			String[] habCodes) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			for (int i = 0; i < habCodes.length; i++) {
				query = "update rws_est_new_hab_lnk_tbl set hab_code = ? where work_id = ? ";

				pstat = conn.prepareStatement(query);

				pstat.setString(1, habCodes[i]);

				pstat.setString(2, workCode);

				count = pstat.executeUpdate();

			}

		} catch (Exception e) {
			Debug.println("Exception TechWorksHabsUpdate:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int RevAdmSanCheck(DataSource dataSource, String officeCode,
			String ProgrammeCode, String SubProgrammeCode, String assetCode,
			String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();

			query = " SELECT count(*) as cnt from RWS_REVISED_ADM_SANC_TBL  where office_code = '"
					+ officeCode
					+ "' and "
					+ " TYPE_OF_ASSET = '"
					+ assetCode
					+ "' and WORK_ID = '"
					+ workCode
					+ "' and "
					+ " PROGRAMME_CODE = '" + ProgrammeCode + "'";
			query2 = " and " + " SUBPROGRAMME_CODE = '" + SubProgrammeCode
					+ "'";
			if (SubProgrammeCode != null) {
				query = query + query2;
			}

			Debug.println("query" + query);
			stmt = conn.createStatement();

			rset = stmt.executeQuery(query);

			if (rset.next()) {

				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception RevAdmSanCheck:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public int CheckRevTechSanc(DataSource dataSource, String officecode,
			String assetCode, String workCode) {
		int no_pp = 0;
		Debug.println("in checkTechSanc");
		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from rws_new_revised_est_tbl where office_code='"
					+ officecode + "' and WORK_ID = '" + workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			// pstat.setString(1,officecode);

			// pstat.setString(2,assetCode);
			// pstat.setString(3,workCode);

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}
				Debug.println("no_pp" + rset.getInt(1));
			}
		} catch (Exception e) {
			Debug.println("Exception CheckRevTechSanc:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public int RevTechWorksUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update rws_new_revised_est_tbl set REV_TS_GIVEN_BY  = '"
					+ worksBean.getRevtechSangiven() + "'," + " REV_TS_NO  = '"
					+ worksBean.getRevtechSanNo() + "',"
					+ " REV_TS_DATE  = to_date('"
					+ worksBean.getRevtechSanDate() + "','dd/mm/yyyy'),"
					+ " TS_AMOUNT = '" + worksBean.getRevtechSanAmt()
					+ "',SSR_YEAR = '" + worksBean.getRevssrYear() + "'"
					+ " where office_code = '" + officeCode + "' and "
					+ " work_id = '" + workCode + "'";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exceptionin query RevTechWorksUpdate:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public WorksMonitoringActionBean RevTechWorksRetrieve(
			DataSource dataSource, String officeCode, String assetCode,
			String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT distinct REV_TS_GIVEN_BY ,REV_TS_NO ,TS_AMOUNT,to_char(REV_TS_DATE,'dd/mm/yyyy')"
					+ " as REV_TS_DATE, ssr_year, REV_SANCTIONED_AMOUNT   from rws_new_revised_est_tbl ne "
					+ " where  ne.WORK_ID = '" + workCode + "'";
			Debug.println("*****query*****" + query);
			pstat = conn.prepareStatement(query);
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setRevtechSangiven(rset.getString(1));
				worksActionBean.setRevtechSanNo(rset.getString(2));
				worksActionBean.setRevtechSanDate(rset.getString(4));
				worksActionBean.setRevtechSanAmt(rset.getFloat(3));
				worksActionBean.setRevssrYear(rset.getString(5));
				worksActionBean.setRevSanAmt(rset.getFloat(6));
			}

			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS SC_POP_TOT,"
					+ "SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE IN"
					+ "(select HAB_CODE from rws_new_revised_est_tbl re,RWS_REV_EST_NEW_HAB_LNK_TBL  REL "
					+ "WHERE RE.WORK_ID=REL.WORK_ID AND RE.WORK_ID='"
					+ workCode + "')";
			Debug.println("query is " + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			if (rset.next()) {
				worksActionBean.setPlainPop(RwsMasterData.format(rset
						.getInt("PLAIN_POP_TOT") + ""));
				worksActionBean.setScPop(RwsMasterData.format(rset
						.getInt("SC_POP_TOT") + ""));
				worksActionBean.setStPop(RwsMasterData.format(rset
						.getInt("ST_POP_TOT") + ""));
			}

		} catch (Exception e) {
			Debug.println("Exception RevTechWorksRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		{
			releaseConnection();

		}
		return worksActionBean;
	}

	public int RevTechWorksHabsCheck(DataSource dataSource, String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from rws_rev_est_new_hab_lnk_tbl where WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception RevTechWorksHabsCheck:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public int RevTechWorksHabsInsert(DataSource dataSource, String workCode,
			String[] habCodes) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			for (int i = 0; i < habCodes.length; i++) {
				query = "insert into rws_rev_est_new_hab_lnk_tbl(WORK_ID ,hab_code) "
						+ " values(?,?)  ";

				pstat = conn.prepareStatement(query);

				pstat.setString(1, workCode);

				pstat.setString(2, habCodes[i]);

				count = pstat.executeUpdate();

			}

		} catch (Exception e) {
			Debug.println("Exception RevTechWorksHabsInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int RevTechWorksHabsUpdate(DataSource dataSource, String workCode,
			String[] habCodes) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			for (int i = 0; i < habCodes.length; i++) {
				query = "update rws_rev_est_new_hab_lnk_tbl set hab_code = '"
						+ habCodes[i] + "' where work_id = '" + workCode + "' ";
				Debug.println("query" + query);
				pstat = conn.prepareStatement(query);

				count = pstat.executeUpdate();
			}
		} catch (Exception e) {
			Debug.println("Exception RevTechWorksHabsUpdate:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public String[] RevTechWorksHabsRetrieve(DataSource dataSource,
			String workCode, int count) {
		String[] habCodes = new String[200];
		if (count > 0) {
			int i = 0;

			try {
				conn = RwsOffices.getConn();

				query = "SELECT distinct hab_code from rws_rev_est_new_hab_lnk_tbl where WORK_ID = '"
						+ workCode + "'";
				Debug.println("query" + query);
				stmt = conn.createStatement();
				rset = stmt.executeQuery(query);
				while (rset.next()) {
					habCodes[i] = rset.getString(1);
					i++;
				}
			} catch (Exception e) {
				Debug.println("Exception RevTechWorksHabsRetrieve:" + e);
			} finally {
				try {
					if (rset != null)
						rset.close();
					if (stmt != null)
						stmt.close();
					if (conn != null)
						conn.close();
				} catch (Exception e) {
					Debug.println("EXCEPTION IN CLOSING CONNECTION"
							+ e.getMessage());
				}
			}
		} else {
			habCodes = null;
		}
		return habCodes;
	}

	public int RevTechWorksInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode, String programmeCode,
			String SubprogrammeCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "insert into rws_new_revised_est_tbl(office_code ,"
					+ " WORK_ID ,REV_TS_GIVEN_BY      ,REV_TS_NO     ,REV_TS_DATE     ,SSR_YEAR,"
					+ " PREPARED_BY,PREPARED_ON,FINANCIAL_YEAR,SOURCE_CODE,REV_SANCTIONED_AMOUNT   ) "
					+ " values('" + officeCode + "','" + workCode + "','"
					+ worksBean.getRevtechSangiven() + "'," + " '"
					+ worksBean.getRevtechSanNo() + "',to_date('"
					+ worksBean.getRevtechSanDate() + "','dd/mm/yyyy')," + " '"
					+ worksBean.getRevssrYear() + "','DUMMY'," + " to_date('"
					+ worksBean.getRevtechSanDate() + "','dd/mm/yyyy'),'',"
					+ " '','" + worksBean.getRevtechSanAmt() + "')  ";
			Debug.println("query" + query);

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exceptionin query RevTechWorksInsert:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public ArrayList CircleCombo(DataSource dataSource) {
		ArrayList circles = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct substr(ne.office_code,2,2) as circleoffcode,circle_office_name  from rws_work_admn_tbl ne,"
					+ " rws_circle_office_tbl co where substr(ne.office_code,2,2)=co.circle_office_code order by substr(ne.office_code,2,2)";
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			Circle circle = null;
			circles = new ArrayList();
			while (rset.next()) {
				circle = new Circle();
				circle.setCode(rset.getString(1));
				circle.setName(rset.getString(2));

				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception CircleCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return circles;
	}

	public ArrayList DivisionCombo(DataSource dataSource, String circlecode)
			throws SQLException {
		ArrayList divisions = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct substr(pp.office_code,4,1) as divisionoffcode,division_office_name  "
					+ " from rws_work_admn_tbl pp ,rws_division_office_tbl co where "
					+ " substr(pp.office_code,2,2)=co.circle_office_code and "
					+ " substr(pp.office_code,4,1)=co.division_office_code AND substr(pp.office_code,2,2) = '"
					+ circlecode + "'";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			Division division = null;
			divisions = new ArrayList();
			while (rset.next()) {
				division = new Division();
				division.setCode(rset.getInt(1));
				division.setName(rset.getString(2));
				divisions.add(division);
			}
		} catch (Exception e) {
			Debug.println("Exception DivisionCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return divisions;
	}

	public ArrayList SubDivisionCombo(DataSource dataSource, String circlecode,
			int divisioncode) {
		ArrayList subdivisions = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct substr(pp.office_code,5,2) as subdivisionoffcode,subdivision_office_name  from rws_work_admn_tbl pp,rws_subdivision_office_tbl co where substr(pp.office_code,2,2)=co.circle_office_code  and substr(pp.office_code,4,1)=co.division_office_code  AND substr(pp.office_code,5,2)=co.subdivision_office_code  and substr(pp.office_code,2,2) = ? and substr(pp.office_code,4,1) = ?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, circlecode);
			pstat.setInt(2, divisioncode);
			rset = pstat.executeQuery();
			SubDivision subdivision = null;
			subdivisions = new ArrayList();
			while (rset.next()) {
				subdivision = new SubDivision();
				subdivision.setCode(rset.getString(1));
				subdivision.setName(rset.getString(2));
				subdivisions.add(subdivision);
			}
		} catch (Exception e) {
			Debug.println("Exception  SubDivisionCombo: " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return subdivisions;
	}

	public ArrayList AssetTypeCombo(DataSource dataSource, String circlecode,
			int divisioncode, String subdivisioncode, String pcode,
			String subProg) {
		ArrayList subdivisions = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct pp.TYPE_OF_ASSET,type_of_asset_name from rws_work_admn_tbl "
					+ "pp,rws_asset_type_tbl at where pp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE and "
					+ "substr(pp.office_code,2,2) = '"
					+ circlecode
					+ "' and substr(pp.office_code,4,1)="
					+ divisioncode
					+ ""
					+ "  and substr(pp.work_id,1,2)='" + pcode + "'";
			if (subProg != null && !subProg.equals("")) {
				query = query + " and   substr(pp.work_id,3,2)='" + subProg
						+ "'";
			}
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);

			rset = pstat.executeQuery();
			SubDivision subdivision = null;
			subdivisions = new ArrayList();
			while (rset.next()) {
				subdivision = new SubDivision();
				subdivision.setAssetcode(rset.getString(1));
				subdivision.setAssetname(rset.getString(2));
				subdivisions.add(subdivision);
			}
		} catch (Exception e) {
			Debug.println("Exception AssetTypeCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return subdivisions;
	}

	public ArrayList ProgrammeCombo(DataSource dataSource, String circlecode,
			int divisioncode, String subdivisioncode) {
		ArrayList programmes = null;
		try {
			conn = RwsOffices.getConn();
			query = "select distinct ff.programme_code,pp.programme_name from rws_work_admn_tbl "
					+ "ff,rws_programme_tbl pp where ff.programme_code=pp.programme_code and substr"
					+ "(ff.office_code,2,2)='" + circlecode + "'";
			if (divisioncode != 0) {
				query = query + " and substr(ff.office_code,4,1)="
						+ divisioncode + "";
			}
			if (!subdivisioncode.equals("") && subdivisioncode != null) {
				query = query + " and substr(ff.office_code,5,2)="
						+ divisioncode + "";
			}
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			Programme programme = null;
			programmes = new ArrayList();
			while (rset.next()) {
				programme = new Programme();
				programme.setCode(rset.getString("programme_code"));
				programme.setName(rset.getString("programme_name"));

				programmes.add(programme);
			}

		} catch (Exception e) {
			Debug.println("Exception ProgrammeCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return programmes;
	}

	public ArrayList SubProgrammeCombo(DataSource dataSource,
			String circlecode, int divisioncode, String subdivisioncode,
			String programmecode) {
		ArrayList subprogrammes = null;
		try {
			conn = RwsOffices.getConn();
			// query =
			// " SELECT subprogramme_code,subprogramme_name FROM rws_subprogramme_tbl where programme_code = ? order by programme_code";
			/*
			 * query =
			 * "select distinct ff.SUBPROGRAMME_CODE ,ss.subprogramme_name from rws_work_admn_tbl ff,"
			 * +
			 * " rws_subprogramme_tbl ss where ff.PROGRAMME_CODE = ss.PROGRAMME_CODE and "
			 * + " ff.sub_programmer_code=ss.subprogramme_code and " +
			 * " substr(ff.office_code,2,2)='" + circlecode + "' and " +
			 * " substr(ff.office_code,4,1) = '" + divisioncode + "' and " +
			 * " substr(ff.office_code,5,2) = '" + subdivisioncode + "'" +
			 * " ff.programme_code='"+programmecode+"' ";
			 */
			query = "select distinct ff.SUBPROGRAMME_CODE ,ss.subprogramme_name from rws_work_admn_tbl ff,"
					+ " rws_subprogramme_tbl ss where ff.PROGRAMME_CODE = ss.PROGRAMME_CODE and "
					+ " ff.sub_programmer_code=ss.subprogramme_code and "
					+ " substr(ff.office_code,2,2)='" + circlecode + "'";
			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			// pstat.setString(1,programmecode);
			rset = pstat.executeQuery();
			Subprogramme subprogramme = null;
			subprogrammes = new ArrayList();
			while (rset.next()) {
				subprogramme = new Subprogramme();
				subprogramme.setCode(rset.getString("subprogramme_code"));
				subprogramme.setName(rset.getString("subprogramme_name"));
				subprogrammes.add(subprogramme);
			}
		} catch (Exception e) {
			Debug.println("Exception SubProgrammeCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return subprogrammes;
	}

	/**************************************************************************************************************/
	// Source Identification//
	/*****************************************************************/

	public ArrayList SiteHabs(DataSource dataSource, String circlecode,
			int divisioncode, String subdivisioncode) {
		Debug.println("trying to get the site habitations........");
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = " SELECT  distinct P.panch_code, P.panch_name, "
					+ " (H.census_plain_popu + H.census_sc_popu + H.census_st_popu), "
					+ " H.coverage_status FROM rws_panchayat_raj_tbl P, "
					+ " rws_habitation_directory_tbl H,rws_habitation_directory_tbl hd"
					+ " WHERE hd.hab_code=p.panch_code and hd.hab_code=h.hab_code and P.panch_code = H.hab_code AND "
					+ " H.circle_office_code = '"
					+ circlecode
					+ "' and hd.coverage_status <> 'UI' and hd.coverage_status is not null"
					+ " order by P.panch_name";
			Debug.println("query" + query);
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setPanchCode(rset.getString(1));
				tendermemo.setPanchName(rset.getString(2));
				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception SiteHabs:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return ntenderMemo;
	}

	public ArrayList SiteHab1(DataSource dataSource, String circlecode,
			String divisioncode, String subdivisioncode, String mandalCode) {
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			
			query = " SELECT  distinct P.panch_code, P.panch_name FROM rws_panchayat_raj_tbl P, "
					+ " rws_habitation_directory_tbl H,rws_habitation_directory_tbl hd,rws_mandal_tbl m"
					+ " WHERE hd.hab_code=p.panch_code and hd.hab_code=h.hab_code and P.panch_code = H.hab_code AND "
					+ " H.circle_office_code = ? and substr(p.panch_code,6,2)=?  and h.circle_office_code=m.dcode and m.mcode=? and hd.coverage_status <> 'UI' and hd.coverage_status is not null"
					+ " order by P.panch_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, circlecode);
			ps.setString(2, mandalCode);
			ps.setString(3, mandalCode);
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setPanchCode(rset.getString(1));
				tendermemo.setPanchName(rset.getString(2));
				tendermemo.setHabName(rset.getString(2) + " - "
						+ rset.getString(1));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in SiteHabs:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return ntenderMemo;
	}

	public ArrayList getMandals(DataSource dataSource, String circlecode)
			throws Exception {
		ArrayList mtenderMemo = null;
		String query = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE"
					+ " DCODE=? ORDER BY MNAME";
			ps = conn.prepareStatement(query);
			ps.setString(1, circlecode);
			rs = ps.executeQuery();
			tenderMemo tendermemo = null;
			mtenderMemo = new ArrayList();
			while (rs.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMandalCode(rs.getString(2));
				tendermemo.setMandalName(rs.getString(3));
				mtenderMemo.add(tendermemo);
			}
		} catch (Exception e) {
			Debug.println("The Exception in getMandals()=== Works Data " + e);
		} finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		return mtenderMemo;
	}

	public ArrayList getSchoolMandals(String workId) throws Exception {

		String query = null;
		ArrayList schoolMandals = new ArrayList();
		conn = RwsOffices.getConn();
		RwsMasterData rwsMasterData = new RwsMasterData();
		try {
			query = "select distinct substr(hab_code,6,2) from RWS_SCHOOL_ASSET_LNK_TBL where asset_code=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			int count = 0;
			while (rs.next()) {
				schoolMandals.add(count, "" + rs.getString(1));
			}
		} catch (Exception e) {
			Debug.println("Exception in getSchoolMandals"+e);
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return schoolMandals;

	}

	public static ArrayList getSources(DataSource dataSource) {
		ArrayList sources = new ArrayList();

		RwsMaster rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0101001");
		rwsMaster.setCodeName("PWS SUBSURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0101002");
		rwsMaster.setCodeName("PWS SURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0101003");
		rwsMaster.setCodeName("PWS PUMPSETS");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0201001");
		rwsMaster.setCodeName("MPWS SUBSURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0201002");
		rwsMaster.setCodeName("MPWS SURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0201003");
		rwsMaster.setCodeName("MPWS PUMPSETS");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0301001");
		rwsMaster.setCodeName("CPWS SUBSURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0301002");
		rwsMaster.setCodeName("CPWS SURFACE SOURCE");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		// rwsMaster.setSourceCode("0301003");
		rwsMaster.setSourceCode("0301003");
		rwsMaster.setCodeName("CPWS PUMPSETS");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0401001");
		rwsMaster.setCodeName("HANDPUMPS BOREWELL");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0501001");
		rwsMaster.setCodeName("SHALLOW HANDPUMPS");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0601001");
		rwsMaster.setCodeName("OPEN WELLS");
		sources.add(rwsMaster);

		rwsMaster = new RwsMaster();
		rwsMaster.setSourceCode("0701001");
		rwsMaster.setCodeName("PONDS");
		sources.add(rwsMaster);

		return sources;
	}

	public ArrayList getSourceCodes(DataSource dataSource, String sourceType,
			String habCode) throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList sourceCodes = new ArrayList();
		SubCompMetaData subCompMetaData = new SubCompMetaData(
				sourceType.substring(0, 2), sourceType.substring(4, 5),
				sourceType.substring(5, 6), habCode);
		try {
			conn = RwsOffices.getConn();
			
			String query = "";
			query = "SELECT DISTINCT SOURCE_CODE,SOURCE_NAME FROM RWS_SOURCE_TBL WHERE HAB_CODE=? and SOURCE_TYPE_CODE = ? and SUBSOURCE_TYPE_CODE =? " ;

			if (sourceType.substring(4, 5).equals("1")
					&& sourceType.substring(5, 6).equals("1")) {
				 query +=
				 " UNION SELECT DISTINCT HP_CODE,LOCATION FROM RWS_HP_SUBCOMP_PARAM_TBL WHERE SUBSTR(HP_CODE,1,16)=? and SUBSTR(HP_CODE,17,3) like '0%'";
			}
			
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			ps.setString(2, sourceType.substring(4, 5));
			ps.setString(3, sourceType.substring(5, 6));
			if (sourceType.substring(4, 5).equals("1")
					&& sourceType.substring(5, 6).equals("1")) {
			ps.setString(4, habCode);
			}
			rset = ps.executeQuery();
			while (rset.next()) {
				rwsMaster = new RwsMaster();
				String sName = rset.getString(2);
				if (sName == null) {
					sName = "";
				}
				rwsMaster.setSourceCode(rset.getString(1) + "-" + sName);
				rwsMaster.setSourceName(rset.getString(2));
				sourceCodes.add(rwsMaster);
			}

		} catch (Exception e) {
			Debug.println("Exception is getSourceCodes:" + e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return sourceCodes;
	}


	public String getSourceCode(DataSource dataSource, String sourceType,
			String habCode, String workId) throws Exception {
		//System.out.println("in WORKKKKKKKKKKKKKKKKKKKKKKKKK Progress");
		RwsMaster rwsMaster = null;
		String formed_source_code = "";
		SubCompMetaData subCompMetaData = new SubCompMetaData(
				sourceType.substring(0, 2), sourceType.substring(4, 5),
				sourceType.substring(5, 6), habCode);
		try {
			String compCode = subCompMetaData.getSubCompRep();
			String insertTable = subCompMetaData.getTableName();
			String schemeCodeField = subCompMetaData.getSchemeCodeField();
			conn = RwsOffices.getConn();
			
			String query = "select CODE_SERIES from RWS_ASSET_TYPE_TBL where TYPE_OF_ASSET_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, sourceType.substring(0, 2));
			ResultSet rs = ps.executeQuery();
			String schemeCode = "";
			if (rs.next()) {
				schemeCode = rs.getString(1);
			}
			
			//query = "select " + schemeCodeField + " from " + insertTable + " where hab_code like ? order by to_number(substr(?,22,3))";
			query = "select max(to_number(substr(" + schemeCodeField + ",22,3))) from " + insertTable+ " where hab_code like ? ";
			//System.out.println(query);
			//System.out.println(habCode +"     "+schemeCodeField);
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode+"%");
			//ps.setString(2, schemeCodeField);
			rs = ps.executeQuery();
			/*String maxCode = "";
			while (rs.next()) {
				System.out.println(rs.getString(1));
				maxCode = rs.getString(1);
			}
			System.out.println("Source code   "+maxCode);*/
			int slno = 001;
			/*if (maxCode != null && maxCode.length() != 0
					&& maxCode.length() == 24) {
				slno = Integer.parseInt(maxCode.substring(21, 24));
				slno++;
			}*/
			if(rs.next()) {
				slno=rs.getInt(1);
				slno++;
			}
			String temp = "" + slno;
			String finalSlNo = "";
			if (temp.length() == 1) {
				finalSlNo = "00" + temp;
			} else if (temp.length() == 2) {
				finalSlNo = "0" + temp;
			} else if (temp.length() == 3) {
				finalSlNo = temp;
			}
			formed_source_code = habCode + schemeCode + compCode + finalSlNo;
			
			
		//	System.out.println("New Source Code   "+formed_source_code);
		} catch (Exception e) {
			Debug.println("Exception in getSourceCode:" + e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return formed_source_code;
	}

	public int SrcIdenDelete(DataSource dataSource, String officeCode,
			rws_works_WorkStatus_form form) {
		int delete1 = -1;
		try {
			conn = RwsOffices.getConn();
			try {
				String srcCode = "";
				if (form.getSpradgroup().equals("newSrc")) {
					srcCode = form.getNewsrcCode();
				} else {
					srcCode = form.getSrcCode().substring(0, 24);
				}

				boolean delete = true;

				String q1 = "select * from RWS_CONTRACTOR_SELECTION_TBL where work_id=?";
				String q2 = "select * from RWS_WORK_COMMENCEMENT_TBL where work_id=?";
				String q3 = "select * from RWS_WORK_EXPENDITURE_TBL where work_id=?";
				String q4 = "select * from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id=?";
				String q5 = "select * from RWS_WORK_COMPLETION_TBL where work_id=?";

				ps = conn.prepareStatement(q1);
				ps.setString(1, form.getWorkId());
				ResultSet rset1 = ps.executeQuery();
				
				ps = conn.prepareStatement(q2);
				ps.setString(1, form.getWorkId());
				ResultSet rset2 = ps.executeQuery();
				
				ps = conn.prepareStatement(q3);
				ps.setString(1, form.getWorkId());
				ResultSet rset3 = ps.executeQuery();
				
				ps = conn.prepareStatement(q4);
				ps.setString(1, form.getWorkId());
				ResultSet rset4 = ps.executeQuery();
				
				ps = conn.prepareStatement(q5);
				ps.setString(1, form.getWorkId());
				ResultSet rset5 = ps.executeQuery();

				if (rset1.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset2.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset3.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset4.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset5.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}

				if (delete) {
					query = "delete from rws_source_iden_fin_tbl where WORK_ID = ? and source_code= ?";
					pstat = conn.prepareStatement(query);
					pstat.setString(1, form.getWorkId());
					pstat.setString(2, srcCode);
					delete1 = pstat.executeUpdate();
					String qry1 = "delete from rws_source_tbl where asset_code='"
							+ form.getWorkId() + "'";
					Statement newst = conn.createStatement();
					delete1 += newst.executeUpdate(qry1);
				}
			} catch (SQLException e) {
				Debug.writeln("Exception in SrcIdenDelete :\n" + e);
				delete1 = -2;
				if (e.getErrorCode() == 17081) {
					delete1 = -2;
				} else {
					delete1 = -2;
				}
			} catch (Exception e) {
				Debug.writeln("Exception in SrcIdenDelete :\n" + e);
				delete1 = -2;
			}
		} catch (Exception e) {
			Debug.writeln("Exception in SrcIdenDelete :\n" + e);
			delete1 = -2;
		} finally {
			try {
				if (pstat != null)
					if (pstat != null)
						pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return delete1;

	}

	public int CheckSrcIden(DataSource dataSource, String officeCode,
			String workCode) {
		int no_pp = 0;
		try {
			query = "SELECT count(*) as cnt from rws_source_iden_fin_tbl where office_code = '"
					+ officeCode + "' and WORK_ID = '" + workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			// pstat.setString(1,officecode);

			// pstat.setString(2,assetCode);
			// pstat.setString(3,workCode);

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception CheckSrcIden:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public int SrcIdenUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode, String comp) {
		Debug.println("in SrcIdenUpdate 1");
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			if (comp.equals("existSrc")) {
				query = " update rws_source_iden_fin_tbl set HAB_CODE    = '"
						+ worksBean.getSitehab() + "'," + " SOURCE_CODE   = '"
						+ worksBean.getSrcCode() + "',"
						+ " SITE_HAND_OVER_DATE  = to_date('"
						+ worksBean.getSiteHODate() + "','dd/mm/yyyy'),"
						+ " REMARKS  = '" + worksBean.getRecommend()
						+ "',EMPLOYEE_CODE  = '" + worksBean.getSrcIdby()
						+ "'," + " SOURCE_NAME = '" + worksBean.getSrcName()
						+ "' where office_code = '" + officeCode + "' and "
						+ " work_id = '" + workCode + "'";
			} else {
				query = " update rws_source_iden_fin_tbl set HAB_CODE    = '"
						+ worksBean.getSitehab() + "'," + " SOURCE_CODE   = '"
						+ worksBean.getNewsrcCode() + "',"
						+ " SITE_HAND_OVER_DATE  = to_date('"
						+ worksBean.getSiteHODate() + "','dd/mm/yyyy'),"
						+ " REMARKS  = '" + worksBean.getRecommend()
						+ "',EMPLOYEE_CODE  = '" + worksBean.getSrcIdby()
						+ "'," + " SOURCE_NAME = '" + worksBean.getNewsrcName()
						+ "' where office_code = '" + officeCode + "' and "
						+ " work_id = '" + workCode + "'";
			}

			Debug.println("query" + query);
			// entered_date = to_date('"+date+ "','dd/mm/yyyy')

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			// pstat.setString(1,enteredby);

			// pstat.setString(1,worksBean.getTechSangiven());
			// pstat.setString(2,worksBean.getTechSanNo());
			// pstat.setFloat(3,worksBean.getTechSanAmt());
			// pstat.setString(4,worksBean.getSsrYear());
			// pstat.setString(5,officeCode);
			// pstat.setString(6,assetCode);
			// pstat.setString(7,workCode);
			// Debug.println("ssryear"+worksBean.getSsrYear());
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exceptionin query SrcIdenUpdate:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}


	public int SrcIdenInsert(DataSource dataSource,
			rws_works_WorkStatus_form worksBean, String officeCode) {
		int count = 0;
		int d1 = 0, d2 = 0;
		String comp = worksBean.getSpradgroup();
		String srccode = worksBean.getSrcCode();
		String qqry1 = "", qry1 = "";
		String insQuery = "";
		String workCode = worksBean.getWorkId();
		String assetCode = "";

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			assetCode = workCode.substring(6, 8);
			String sourceCode = "", sourceName = "";
			if (comp.equals("existSrc")) {
				sourceCode = worksBean.getSrcCode().substring(0, 24);
				sourceName = worksBean.getSrcName();
			} else if (comp.equals("newSrc")) {
				sourceCode = worksBean.getNewsrcCode();
				sourceName = worksBean.getNewsrcName();
			}
			String qqry = "delete from rws_source_iden_fin_tbl where work_id=?";
			ps = conn.prepareStatement(qqry);
			ps.setString(1, workCode);
			d1 = ps.executeUpdate();
			qry1 = "delete from rws_source_tbl where asset_code=?";
			ps = conn.prepareStatement(qry1);
			ps.setString(1, workCode);
			d2 = ps.executeUpdate();
			if (comp.equals("newSrc")) {
				insQuery = "insert into rws_source_tbl (source_code,source_name,source_type_code,subsource_type_code,hab_code,asset_code) "
						+ "values(?,?,?,?,?,?)";
				ps = conn.prepareStatement(insQuery);
				ps.setString(1, sourceCode);
				ps.setString(2, sourceName);
				ps.setString(3, worksBean.getSubcompType());
				ps.setString(4, worksBean.getSubSourceType());
				ps.setString(5, worksBean.getSitehab());
				ps.setString(6, workCode);
				
				ps.executeUpdate();
			}
			query = "insert into rws_source_iden_fin_tbl(HAB_CODE,SOURCE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,SITE_HAND_OVER_DATE,REMARKS,"
					+ " EMPLOYEE_CODE,office_code,work_id,TYPE_OF_ASSET_CODE,SOURCE_NAME,UPDATE_DATE)"
					+ " values(?,?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,SYSDATE)";
			assetCode = worksBean.getSchemeCode();
			pstat = conn.prepareStatement(query);
			pstat.setString(1, worksBean.getSitehab());
			pstat.setString(2, sourceCode);
			pstat.setString(3, worksBean.getSubcompType());
			pstat.setString(4, worksBean.getSubSourceType());
			pstat.setString(5, worksBean.getSiteHODate());
			pstat.setString(6, worksBean.getRecommend());
			pstat.setString(7, worksBean.getSrcIdby());
			pstat.setString(8, officeCode);
			pstat.setString(9, workCode);
			pstat.setString(10, worksBean.getSchemeCode());
			pstat.setString(11, sourceName);
			count = pstat.executeUpdate();
			if (d1 > 0 && d2 > 0) {
				count = 2;
			}
			conn.setAutoCommit(true);
		} catch (Exception e) {
			Debug.println("Exception in SrcIdenInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					if (pstat != null)
						pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;

	}

	public WorksMonitoringActionBean SrcIdenRetrieve(DataSource dataSource,
			String officeCode, String assetCode, String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			
			query = " SELECT distinct  HAB_CODE, SOURCE_CODE ,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy') as SITE_HAND_OVER_DATE,"
					+ " REMARKS,EMPLOYEE_CODE,SOURCE_NAME from rws_source_iden_fin_tbl where "
					+ " WORK_ID = ? and TYPE_OF_ASSET_CODE = ?";

			pstat = conn.prepareStatement(query);
			pstat.setString(1, workCode);
			pstat.setString(2, workCode.substring(6, 8));
			worksActionBean = new WorksMonitoringActionBean();
			rset = pstat.executeQuery();
			if (rset.next()) {
				String mcode = rset.getString("HAB_CODE");
				String dcode = rset.getString("HAB_CODE");

				worksActionBean.setSitehab(rset.getString(1));
				if (rset.getString(1) != null) {

					query = "select dcode,mcode,mname from RWS_MANDAL_TBL where dcode=? and mcode=?";
					ps = conn.prepareStatement(query);
					ps.setString(1, rset.getString("HAB_CODE").substring(0, 2));
					ps.setString(2, rset.getString("HAB_CODE").substring(5, 7));
					
					rs = ps.executeQuery();
					while (rs.next()) {
						worksActionBean.setMandalCode(rs.getString(2));
					}
					worksActionBean.setSrcCode(rset.getString(2));

					worksActionBean.setSiteHODate(rset
							.getString("SITE_HAND_OVER_DATE"));
					worksActionBean.setRecommend(rset.getString("remarks"));
					worksActionBean.setSrcIdby(rset.getString("EMPLOYEE_CODE"));
					worksActionBean.setSrcName(rset.getString("SOURCE_NAME"));
					worksActionBean.setSubcompType(rset
							.getString("SOURCE_TYPE_CODE"));
					worksActionBean.setSubSourceType(rset
							.getString("SUBSOURCE_TYPE_CODE"));
					worksActionBean.setSrcCode(rset.getString("SOURCE_CODE"));
					worksActionBean.setCodeStatus("existCode");
					if (rset.getString("SOURCE_CODE") != null
							&& rset.getString("SOURCE_CODE").length() == 24) {
						worksActionBean.setSchemeCode(rset.getString(
								"SOURCE_CODE").substring(16, 19));
						worksActionBean.setSlNo(rset.getString("SOURCE_CODE")
								.substring(21, 24));
					} else {
						worksActionBean.setSchemeCode("");
						worksActionBean.setSlNo("");
						worksActionBean.setCodeStatus("");
					}

				}


			} else {
				worksActionBean.setCodeStatus("");
				worksActionBean.setMandalCode("");
				worksActionBean.setSitehab("");
				worksActionBean.setSrcCode("");
				worksActionBean.setNewsrcCode("");
				worksActionBean.setSiteHODate("");
				worksActionBean.setRecommend("");
				worksActionBean.setSrcIdby("");
				worksActionBean.setSrcName("");
				worksActionBean.setSubSourceType("");
				worksActionBean.setSchemeCode("");
				worksActionBean.setSlNo("");

			}

		} catch (Exception e) {
			Debug.println("Exception in SrcIdenRetrieve :" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public int SrcIdenCheck(DataSource dataSource, String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from rws_source_iden_fin_tbl where  WORK_ID = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			// pstat.setString(1,officecode);

			// pstat.setString(2,assetCode);
			// pstat.setString(3,workCode);

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}
				Debug.println("no_pp" + rset.getInt(1));
			}
		} catch (Exception e) {
			Debug.println("Exception SrcIdenCheck:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return no_pp;
	}

	public int SrcIdenworkidUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode, String comp) {
		Debug.println("in SrcIdenworkidUpdate");
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			if (comp.equals("existSrc")) {

				query = " update rws_source_iden_fin_tbl set HAB_CODE    = '"
						+ worksBean.getSitehab() + "'," + " SOURCE_CODE   = '"
						+ worksBean.getSrcCode() + "',"
						+ " SITE_HAND_OVER_DATE  = to_date('"
						+ worksBean.getSiteHODate() + "','dd/mm/yyyy'),"
						+ " REMARKS  = '" + worksBean.getRecommend() + "',"
						+ "EMPLOYEE_CODE  = '" + worksBean.getSrcIdby()
						+ "',office_code = '" + officeCode + "',"
						+ " SOURCE_NAME = '" + worksBean.getSrcName() + "'"
						+ " where work_id = '" + workCode + "'";
			} else {
				query = " update rws_source_iden_fin_tbl set HAB_CODE    = '"
						+ worksBean.getSitehab() + "'," + " SOURCE_CODE   = '"
						+ worksBean.getNewsrcCode() + "',"
						+ " SITE_HAND_OVER_DATE  = to_date('"
						+ worksBean.getSiteHODate() + "','dd/mm/yyyy'),"
						+ " REMARKS  = '" + worksBean.getRecommend() + "',"
						+ "EMPLOYEE_CODE  = '" + worksBean.getSrcIdby()
						+ "',office_code = '" + officeCode + "',"
						+ " SOURCE_NAME = '" + worksBean.getNewsrcName() + "'"
						+ " where work_id = '" + workCode + "'";

			}

			Debug.println("query" + query);
			// entered_date = to_date('"+date+ "','dd/mm/yyyy')

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			// pstat.setString(1,enteredby);

			// pstat.setString(1,worksBean.getTechSangiven());
			// pstat.setString(2,worksBean.getTechSanNo());
			// pstat.setFloat(3,worksBean.getTechSanAmt());
			// pstat.setString(4,worksBean.getSsrYear());
			// pstat.setString(5,officeCode);
			// pstat.setString(6,assetCode);
			// pstat.setString(7,workCode);
			// Debug.println("ssryear"+worksBean.getSsrYear());
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exceptionin query SrcIdenworkidUpdate:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public ArrayList SubCompType(DataSource dataSource, String assetCode) {
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT * FROM RWS_SOURCE_TYPE_TBL order by SOURCE_TYPE_CODE";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			if (!assetCode.equals("04")) {
				while (rset.next()) {
					tendermemo = new tenderMemo();

					tendermemo.setSubCompCode(rset.getString(1));
					tendermemo.setSubCompName(rset.getString(2));

					ntenderMemo.add(tendermemo);
				}
			} else {
				tendermemo = new tenderMemo();

				tendermemo.setSubCompCode("1");
				tendermemo.setSubCompName("SUBSURFACE SOURCE");

				ntenderMemo.add(tendermemo);
			}
		} catch (Exception e) {
			Debug.println("Exception SubCompType:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}


	public ArrayList getSubSourceTypes(DataSource dataSource,
			String subSourceCode, String assetCode) {
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT * FROM RWS_SUBSOURCE_TYPE_TBL where source_type_code=? order by SUBSOURCE_TYPE_CODE";
			ps = conn.prepareStatement(query);
			ps.setString(1, subSourceCode);
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			if (!assetCode.equals("04")) {
				while (rset.next()) {
					tendermemo = new tenderMemo();

					tendermemo.setSubCompCode(rset.getString(2));
					tendermemo.setSubCompName(rset.getString(3));

					ntenderMemo.add(tendermemo);
				}
			} else if (assetCode.equals("04")) {
				tendermemo = new tenderMemo();

				tendermemo.setSubCompCode("1");
				tendermemo.setSubCompName("BOREWELL");

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in getSubSourceTypes:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	public String SubComponentType(DataSource dataSource, String tmpsrccode) {
		String code = "";
		try {
			conn = RwsOffices.getConn();
			query = " select SOURCE_TYPE_CODE from rws_source_tbl where SOURCE_CODE = ? ";

			Debug.println("query" + query);

			pstat = conn.prepareStatement(query);
			pstat.setString(1, tmpsrccode);
			rset = pstat.executeQuery();

			if (rset.next()) {
				code = rset.getString(1);
			}
			if (code.equals("1"))
				code = "001";
			else
				code = "002";
		} catch (Exception e) {
			Debug.println("Exceptionin query SubComponentType:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return code;
	}

	/********************************************************************************************************************************/
	/* CONTRACTOR MANAGEMENT */

	public int CheckContMgnt(DataSource dataSource, String officeCode,
			String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();
			query = "SELECT count(*) as cnt from RWS_CONTRACTOR_SELECTION_TBL cs,rws_tender_appl_tbl ta where  "
					+ " cs.work_id = ta.work_id and cs.work_id = '"
					+ workCode
					+ "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			// pstat.setString(1,officecode);

			// pstat.setString(2,assetCode);
			// pstat.setString(3,workCode);

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception CheckContMgnt:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public int ContMgntUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update RWS_CONTRACTOR_SELECTION_TBL set TENDER_IDNO = '"
					+ worksBean.getTenderNoteId()
					+ "',LOA_ISSUED_ON   = to_date('" + worksBean.getLoa()
					+ "','dd/mm/yyyy'),TENDER_COMMITTEE  = '"
					+ worksBean.getTenderCommittee() + "',"
					+ " COMPETENT_AUTHORITY  = '"
					+ worksBean.getCompAuthority() + "',TENDER_APPROVED_ON = "
					+ "to_date('" + worksBean.getTenderAppDate()
					+ "','dd/mm/yyyy'), SITE_HAND_OVER_DATE = to_date" + "('"
					+ worksBean.getSiteHandDate()
					+ "','dd/mm/yyyy'),AGREEMENT_DATE = to_date('"
					+ worksBean.getAgreeDate() + "',"
					+ "'dd/mm/yyyy'),AGREEMENT_REFERENCE_NO = '"
					+ worksBean.getAgreeRefNo() + "',AGREEMENT_DURATION = "
					+ "" + worksBean.getAgreeDur() + ",AGREEMENT_VALUE = "
					+ worksBean.getAgreeVal() + ",DATE_OF_COMPLETION "
					+ "= to_date('" + worksBean.getWorkCompDate()
					+ "','dd/mm/yyyy'),TENDER_PERCENT='"
					+ worksBean.getTenderPer() + "'" + " where  work_id = '"
					+ workCode + "'";

			Debug.println("query" + query);

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exceptionin query ContMgntUpdate:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			query = "insert into RWS_CONTRACTOR_SELECTION_TBL(WORK_ID,TENDER_IDNO,LOA_ISSUED_ON,TENDER_COMMITTEE,"
					+ " COMPETENT_AUTHORITY,TENDER_APPROVED_ON,SITE_HAND_OVER_DATE,AGREEMENT_DATE,AGREEMENT_REFERENCE_NO,"
					+ "AGREEMENT_DURATION,AGREEMENT_VALUE,DATE_OF_COMPLETION,TENDER_PERCENT) values('"
					+ workCode
					+ "','"
					+ worksBean.getTenderNoteId()
					+ "',"
					+ " to_date('"
					+ worksBean.getLoa()
					+ "','dd/mm/yyyy'),"
					+ " decode('"
					+ worksBean.getTenderCommittee()
					+ "','on','Y'),decode('"
					+ worksBean.getCompAuthority()
					+ "','on','Y')"
					+ ",to_date('"
					+ worksBean.getTenderAppDate()
					+ "','dd/mm/yyyy'),"
					+ "to_date('"
					+ worksBean.getSiteHandDate()
					+ "','dd/mm/yyyy'),"
					+ "to_date('"
					+ worksBean.getAgreeDate()
					+ "','dd/mm/yyyy'),'"
					+ worksBean.getAgreeRefNo()
					+ "',"
					+ worksBean.getAgreeDur()
					+ ","
					+ worksBean.getAgreeVal()
					+ ",to_date('"
					+ worksBean.getWorkCompDate()
					+ "','dd/mm/yyyy'),'" + worksBean.getTenderPer() + "')";

			Debug.println("Query to insert contmanagement details::\n" + query);
			pstat = conn.prepareStatement(query);
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception ContMgntInsert:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public WorksMonitoringActionBean ContMgntRetrieve(DataSource dataSource,
			String officeCode, String assetCode, String workCode) {
		int count = 0;
		Debug.println("in ContMgntRetrieve");
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();

			/*
			 * query =
			 * " SELECT distinct  cs.TENDER_IDNO,to_char(LOA_ISSUED_ON,'dd/mm/yyyy') as LOA_ISSUED_ON,TENDER_COMMITTEE,"
			 * +
			 * " COMPETENT_AUTHORITY,to_char(TENDER_APPROVED_ON,'dd/mm/yyyy') as TENDER_APPROVED_ON,"
			 * +
			 * " to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy') as SITE_HAND_OVER_DATE,"
			 * +
			 * " to_char(AGREEMENT_DATE,'dd/mm/yyyy') as AGREEMENT_DATE,AGREEMENT_REFERENCE_NO,AGREEMENT_DURATION,"
			 * +
			 * " AGREEMENT_VALUE,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') as DATE_OF_COMPLETION,CONTRACTOR_NAME,"
			 * +
			 * " TENDER_AMOUNT,to_char(RECIEVED_ON,'dd/mm/yyyy') as RECIEVED_ON from "
			 * +
			 * " RWS_CONTRACTOR_SELECTION_TBL cs,rws_tender_appl_tbl ta where cs.work_id = ta.work_id and"
			 * + " cs.work_id = '" +workCode+ "' ";
			 */

			query = " SELECT distinct  cs.TENDER_IDNO,to_char(LOA_ISSUED_ON,'dd/mm/yyyy') as LOA_ISSUED_ON,TENDER_COMMITTEE,"
					+ " COMPETENT_AUTHORITY,to_char(TENDER_APPROVED_ON,'dd/mm/yyyy') as TENDER_APPROVED_ON,"
					+ " to_char(SITE_HAND_OVER_DATE,'dd/mm/yyyy') as SITE_HAND_OVER_DATE,"
					+ " to_char(AGREEMENT_DATE,'dd/mm/yyyy') as AGREEMENT_DATE,AGREEMENT_REFERENCE_NO,AGREEMENT_DURATION,"
					+ " AGREEMENT_VALUE,to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') as DATE_OF_COMPLETION,TENDER_PERCENT"
					+ "  from "
					+ " RWS_CONTRACTOR_SELECTION_TBL cs where "
					+ " cs.work_id = '" + workCode + "' ";

			Debug.println("query" + query);

			stmt = conn.createStatement();

			worksActionBean = new WorksMonitoringActionBean();

			rset = stmt.executeQuery(query);

			if (rset.next()) {

				worksActionBean.setTenderNoteId(rset.getString("TENDER_IDNO"));

				worksActionBean.setLoa(rset.getString("LOA_ISSUED_ON"));
				Debug.println("loa" + rset.getString("LOA_ISSUED_ON"));
				worksActionBean.setTenderCommittee(rset
						.getString("TENDER_COMMITTEE"));
				worksActionBean.setCompAuthority(rset
						.getString("COMPETENT_AUTHORITY"));
				worksActionBean.setTenderAppDate(rset
						.getString("TENDER_APPROVED_ON"));
				worksActionBean.setSiteHandDate(rset
						.getString("SITE_HAND_OVER_DATE"));
				worksActionBean.setAgreeDate(rset.getString("AGREEMENT_DATE"));
				worksActionBean.setAgreeRefNo(rset
						.getString("AGREEMENT_REFERENCE_NO"));
				worksActionBean.setAgreeDur(rset.getInt("AGREEMENT_DURATION"));
				worksActionBean.setAgreeVal(rset.getFloat("AGREEMENT_VALUE"));
				worksActionBean.setWorkCompDate(rset
						.getString("DATE_OF_COMPLETION"));
				worksActionBean.setTenderPer(rset.getString("TENDER_PERCENT"));

			}

			query = "select TENDER_IDNO ,CONTRACTOR_NAME ,TENDER_AMOUNT ,to_char(RECIEVED_ON,'dd/mm/yyyy')as RECIEVED_ON  from rws_tender_appl_tbl where work_id='"
					+ workCode + "'";
			Debug.println("quer:" + query);
			rset = stmt.executeQuery(query);

			if (rset.next()) {
				worksActionBean.setCfName(rset.getString("CONTRACTOR_NAME"));
				worksActionBean.setTenderCost(rset.getFloat("TENDER_AMOUNT"));
				worksActionBean.setTenderAccDate(rset.getString("RECIEVED_ON"));
			}
		} catch (Exception e) {
			Debug.println("Exception WorksMonitoringActionBean:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public int ContMgntDelete(DataSource dataSource, String officeCode,
			String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from RWS_CONTRACTOR_SELECTION_TBL where  work_id = ?";
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,officeCode);
			pstat.setString(1, workCode);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception ContMgntDelete:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntMisInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			query = "insert into rws_tender_appl_tbl(WORK_ID,TENDER_IDNO,TENDER_APPL_NO,CONTRACTOR_NAME,TENDER_AMOUNT,RECIEVED_ON "
					+ " ) values('"
					+ workCode
					+ "','"
					+ worksBean.getTenderNoteId()
					+ "','dumm','"
					+ worksBean.getCfName()
					+ "',"
					+ " '"
					+ worksBean.getTenderCost()
					+ "',"
					+ " to_date('"
					+ worksBean.getTenderAccDate() + "','dd/mm/yyyy')" + " )";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,workCode);

			// pstat.setString(2,habCodes[i]);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception ContMgntMisInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntMisUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update rws_tender_appl_tbl set CONTRACTOR_NAME = '"
					+ worksBean.getCfName() + "'," + "TENDER_AMOUNT   = '"
					+ worksBean.getTenderCost() + "'," +

					"RECIEVED_ON = to_date('" + worksBean.getTenderAccDate()
					+ "','dd/mm/yyyy') " + "  where " + " work_id = '"
					+ workCode + "'";

			Debug.println("query" + query);
			// entered_date = to_date('"+date+ "','dd/mm/yyyy')

			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			// pstat.setString(1,enteredby);

			// pstat.setString(1,worksBean.getTechSangiven());
			// pstat.setString(2,worksBean.getTechSanNo());
			// pstat.setFloat(3,worksBean.getTechSanAmt());
			// pstat.setString(4,worksBean.getSsrYear());
			// pstat.setString(5,officeCode);
			// pstat.setString(6,assetCode);
			// pstat.setString(7,workCode);
			// Debug.println("ssryear"+worksBean.getSsrYear());
			Debug.println("sssssssssssssssssssssssssssssssssssss");
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exceptionin query ContMgntMisUpdate:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntMisDelete(DataSource dataSource, String officeCode,
			String workCode) {
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = "delete from rws_tender_appl_tbl where  work_id = ?";
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,officeCode);
			pstat.setString(1, workCode);
			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception ContMgntMisDelete:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntNoteInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String officeCode,
			String assetCode, String workCode) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			query = "insert into rws_tender_notification_tbl(TENDER_IDNO "
					+ " ) values('" + worksBean.getTenderNoteId() + "')";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception ContMgntNoteInsert:" + e);
		} finally {
			releaseConnection();

		}
		return count;
	}

	public ArrayList ContMgntMileStones(DataSource dataSource, String workCode) {
		ArrayList ntenderMemo = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT distinct mt.MILESTONE_CODE  ,MILESTONE_NAME  ,ms.MILESTONE_STAGE_CODE  ,MILESTONE_STAGE_NAME ,"
					+ " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
					+ " rws_milestone_tbl mt,rws_milestone_stage_tbl ms,rws_milestone_target_ach_tbl ta where "
					+ " mt.milestone_code = ms.milestone_code and ms.milestone_code = ta.milestone_code and "
					+ " ta.milestone_code = mt.milestone_code and ta.work_id = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMstoneCode(rset.getString(1));
				tendermemo.setMstoneName(rset.getString(2));
				tendermemo.setMstoneStageCode(rset.getString(3));
				tendermemo.setMstoneStageName(rset.getString(4));
				tendermemo.setTargetDate(rset.getString(5));
				tendermemo.setPercentComp(rset.getString(6));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception ContMgntMileStones: " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return ntenderMemo;
	}

	public ArrayList MileStones(DataSource dataSource) {
		ArrayList ntenderMemo = null;
		try {

			conn2 = RwsOffices.getConn();
			query = " SELECT MILESTONE_CODE  ,MILESTONE_NAME  FROM "
					+ " rws_milestone_tbl ";

			stmt2 = conn2.createStatement();
			rset1 = stmt2.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset1.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMstoneCode(rset1.getString(1));
				tendermemo.setMstoneName(rset1.getString(2));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in MileStones()" + e);
		} finally {
			try {
				if (rset1 != null)
					rset1.close();
				if (stmt2 != null)
					stmt2.close();
				conn2.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	public ArrayList Stages(DataSource dataSource, String mileStoneCode) {
		ArrayList ntenderMemo = null;
		try {

			conn2 = RwsOffices.getConn();
			query = " SELECT MILESTONE_STAGE_code   ,MILESTONE_STAGE_NAME   FROM "
					+ " rws_milestone_stage_tbl where MILESTONE_CODE = '"
					+ mileStoneCode + "' ";
			Debug.println("query" + query);
			stmt2 = conn2.createStatement();
			rset1 = stmt2.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset1.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMstoneStageCode(rset1.getString(1));
				tendermemo.setMstoneStageName(rset1.getString(2));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in Stages() " + e);
		} finally {
			try {
				if (rset1 != null)
					rset1.close();
				if (stmt2 != null)
					stmt2.close();
				conn2.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	public int ContMgntMileStonesChk(DataSource dataSource, String officeCode,
			String workCode) {
		int no_pp = 0;

		try {
			conn = RwsOffices.getConn();
			query = " SELECT count(*) as cnt   FROM "
					+ " rws_milestone_tbl mt,rws_milestone_stage_tbl ms,rws_milestone_target_ach_tbl ta where "
					+ " mt.milestone_code = ms.milestone_code and ms.milestone_code = ta.milestone_code and "
					+ " ta.milestone_code = mt.milestone_code and ta.work_id = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			// pstat.setString(1,officecode);

			// pstat.setString(2,assetCode);
			// pstat.setString(3,workCode);

			rset = stmt.executeQuery(query);
			if (rset.next()) {
				Debug.println(rset.getString("cnt"));
				if (rset.getInt(1) > 0) {
					no_pp = rset.getInt(1);
				}

			}
		} catch (Exception e) {
			Debug.println("Exception ContMgntMileStonesChk:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return no_pp;
	}

	public int ContMgntMileStonesInsert(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String workCode) {
		int count = 0;

		try {
			conn = RwsOffices.getConn();
			query = "insert into rws_milestone_target_ach_tbl(WORK_ID,MILESTONE_CODE,MILESTONE_STAGE_CODE,TARGET_DATE,PERCENT_COMPLETED "
					+ " ) values('"
					+ workCode
					+ "','"
					+ worksBean.getMstone()
					+ "','"
					+ worksBean.getStages()
					+ "',to_date('"
					+ worksBean.getTargetDate()
					+ "','dd/mm/yyyy'),"
					+ " '"
					+ worksBean.getPercentComp() + "')";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);

			// pstat.setString(1,workCode);

			// pstat.setString(2,habCodes[i]);

			count = pstat.executeUpdate();

		} catch (Exception e) {
			Debug.println("Exception ContMgntMileStonesInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public int ContMgntMileStonesUpdate(DataSource dataSource,
			WorksMonitoringActionBean worksBean, String workCode) {

		int count = 0;
		try {
			conn = RwsOffices.getConn();
			query = " update rws_milestone_target_ach_tbl set MILESTONE_CODE = '"
					+ worksBean.getMstone()
					+ "',"
					+ "MILESTONE_STAGE_CODE   = '"
					+ worksBean.getStages()
					+ "',"
					+

					"TARGET_DATE = to_date('"
					+ worksBean.getTargetDate()
					+ "','dd/mm/yyyy'), "
					+ " PERCENT_COMPLETED = '"
					+ worksBean.getPercentComp()
					+ "' where "
					+ " work_id = '"
					+ workCode + "'";

			Debug.println("query" + query);
			pstat = conn.prepareStatement(query);
			rset = pstat.executeQuery();
			count = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exceptionin query ContMgntMileStonesUpdate" + e);
		} finally {
			try {
				if (pstat != null)
					pstat.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}

	public WorksMonitoringActionBean ContMgntMileStonesRetrieve(
			DataSource dataSource, String officeCode, String assetCode,
			String workCode) {
		int count = 0;
		WorksMonitoringActionBean worksActionBean = null;
		try {
			conn = RwsOffices.getConn();
			query = " SELECT distinct MILESTONE_CODE  ,MILESTONE_STAGE_CODE  ,"
					+ " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
					+ " rws_milestone_target_ach_tbl where " + " work_id = '"
					+ workCode + "'";

			Debug.println("query" + query);

			stmt = conn.createStatement();

			Debug.println("office  " + officeCode);
			worksActionBean = new WorksMonitoringActionBean();

			rset = stmt.executeQuery(query);

			if (rset.next()) {

				worksActionBean.setMstone(rset.getString(1));

				worksActionBean.setStages(rset.getString(2));

				worksActionBean.setTargetDate(rset.getString(3));

				worksActionBean.setPercentComp(rset.getString(4));

			}

		} catch (Exception e) {
			Debug.println("Exception ContMgntMileStonesRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksActionBean;
	}

	public ArrayList ContMgntMileStonesRetrieve(DataSource dataSource,
			String workCode) throws Exception {
		ArrayList ntenderMemo = null;
		ArrayList stageComboList;
		try {
			conn = RwsOffices.getConn();
			/*
			 * query =
			 * " SELECT distinct mt.MILESTONE_CODE  ,MILESTONE_NAME  ,ms.MILESTONE_STAGE_CODE  ,MILESTONE_STAGE_NAME ,"
			 * +
			 * " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
			 * +
			 * " rws_milestone_tbl mt,rws_milestone_stage_tbl ms,rws_milestone_target_ach_tbl ta where "
			 * +
			 * " mt.milestone_code = ms.milestone_code and ms.milestone_code = ta.milestone_code and "
			 * + " ta.milestone_code = mt.milestone_code and ta.work_id = '" +
			 * workCode + "'";
			 */
			query = " SELECT distinct MILESTONE_CODE  ,MILESTONE_STAGE_CODE  ,"
					+ " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
					+ " rws_milestone_target_ach_tbl where " + " work_id = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMstoneCode(rset.getString(1));
				// tendermemo.setMstoneName(rset.getString(2));
				tendermemo.setMstoneStageCode(rset.getString(2));
				// tendermemo.setMstoneStageName(rset.getString(4));
				tendermemo.setTargetDate(rset.getString(3));
				tendermemo.setPercentComp(rset.getString(4));

				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception ContMgntMileStonesRetrieve:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	public ArrayList ContMgntMileStonesRetrieve2(DataSource dataSource,
			String workCode) {
		Debug.println("in ContMgntMileStonesRetrieve2");
		ArrayList ntenderMemo = null;
		ArrayList stageComboList;
		try {
			conn = RwsOffices.getConn();
			/*
			 * query =
			 * " SELECT distinct mt.MILESTONE_CODE  ,MILESTONE_NAME  ,ms.MILESTONE_STAGE_CODE  ,MILESTONE_STAGE_NAME ,"
			 * +
			 * " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
			 * +
			 * " rws_milestone_tbl mt,rws_milestone_stage_tbl ms,rws_milestone_target_ach_tbl ta where "
			 * +
			 * " mt.milestone_code = ms.milestone_code and ms.milestone_code = ta.milestone_code and "
			 * + " ta.milestone_code = mt.milestone_code and ta.work_id = '" +
			 * workCode + "'";
			 */
			query = " SELECT distinct MILESTONE_CODE  ,MILESTONE_STAGE_CODE  ,"
					+ " to_char(TARGET_DATE,'dd/mm/yyyy') as TARGET_DATE ,PERCENT_COMPLETED   FROM "
					+ " rws_milestone_target_ach_tbl where " + " work_id = '"
					+ workCode + "'";
			Debug.println("query" + query);
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();
			rset = stmt.executeQuery(query);
			tenderMemo tendermemo = null;
			ntenderMemo = new ArrayList();
			ArrayList mileStoneStagesList = null;
			LabelValueBean labelValueBean = null;

			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMstoneCode(rset.getString(1));
				tendermemo.setMstone(rset.getString(1));
				Debug.println("mstone code from db is " + rset.getString(1));
				// tendermemo.setMstoneName(rset.getString(2));
				tendermemo.setMstoneStageCode(rset.getString(2));
				tendermemo.setStages(rset.getString(2));
				Debug.println("mstonestage code from db is "
						+ rset.getString(2));
				// tendermemo.setMstoneStageName(rset.getString(4));
				tendermemo.setTargetDate(rset.getString(3));
				tendermemo.setPercentComp(rset.getString(4));
				Debug.println("milestone code"
						+ rset.getString("MILESTONE_CODE"));

				// code added
				ArrayList mileStone = null;
				ArrayList stage = null;
				mileStone = MileStones(dataSource);
				tendermemo.setMileStone(mileStone);
				stage = Stages(dataSource, rset.getString("MILESTONE_CODE"));
				tendermemo.setStage(stage);
				// end of code added

				query = "select * from RWS_MILESTONE_STAGE_TBL where MILESTONE_CODE='"
						+ rset.getString("MILESTONE_CODE") + "'";
				rset2 = stmt2.executeQuery(query);
				mileStoneStagesList = new ArrayList();
				while (rset2.next()) {
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(rset2
							.getString("MILESTONE_STAGE_CODE"));
					labelValueBean.setLabel(rset2
							.getString("MILESTONE_STAGE_NAME"));
					mileStoneStagesList.add(labelValueBean);
				}
				tendermemo.setMileStoneStagesList(mileStoneStagesList);
				ntenderMemo.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in  ContMgntMileStonesRetrieve2 " + e);
		} finally {
			try {
				rset2.close();
				if (stmt != null)
					stmt.close();
				if (stmt2 != null)
					stmt2.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return ntenderMemo;
	}

	public void releaseConnection() {
		try {
			if (rset != null) {
				if (rset != null)
					rset.close();
				rset = null;
			}
			if (pstat != null) {
				if (pstat != null)
					pstat.close();
				pstat = null;
			}
			if (ps != null) {
				if (ps != null)
					ps.close();
				ps = null;
			}
			if (conn != null) {
				if (conn != null)
					conn.close();
				conn = null;
			}
			if (conn2 != null) {
				conn2.close();
				conn2 = null;
			}
			
		} catch (Exception e) {
			Debug.println("Exception:" + e);
		}
	}

	public WorksMonitoringActionBean getProgramScheduleDetails(
			DataSource datasource, String workId) throws Exception {
		WorksMonitoringActionBean bean = null;
		Connection conn = null;
		
		try {
			conn = RwsOffices.getConn();
			String query =  "select  to_char(a.GROUNDING_DATE,'dd/mm/yyyy'),substr(a.OFFICE_CODE,5,2),a.OFFICER_ASSIGNED_TO,a.OFFICER_ASSIGNED_TO1,a.OFFICER_ASSIGNED_TO2,a.OFFICER_ASSIGNED_TO3,to_char(b.AGREEMENT_DATE,'dd/mm/yyyy') "
					+ "from RWS_WORK_COMMENCEMENT_TBL a,rws_contractor_selection_tbl b where a.work_id=? and a.work_id=b.work_id(+)";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			if (rs.next()) {
				bean = new WorksMonitoringActionBean();
				bean.setWorkGndDate(rs.getString(1));
				bean.setSubDivAssign(rs.getString(2));
				bean.setEngineerAssign(rs.getString(3));
				bean.setEngineerAssign1(rs.getString(4));
				bean.setEngineerAssign2(rs.getString(5));
				bean.setEngineerAssign3(rs.getString(6));
				bean.setAgreeDate(rs.getString(7));
			}

		} catch (Exception e) {
			Debug.println("Exception getProgramScheduleDetails:" + e);
		} finally {
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
			if (conn != null)
				conn.close();
		}
		return bean;
	}

	public WorksMonitoringActionBean getContrctorAgrmentDate(
			DataSource datasource, String workId) throws Exception {
		WorksMonitoringActionBean bean = null;
		Connection conn = null;
		String query = "select   to_char(AGREEMENT_DATE,'dd/mm/yyyy') from rws_contractor_selection_tbl"
				+ " where work_id='" + workId + "'";
		Debug.println("Queryt is " + query);
		try {
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				bean = new WorksMonitoringActionBean();
				bean.setWorkGndDate(rs.getString(1));

			}

		} catch (Exception e) {
			Debug.println("Exception getContrctorAgrmentDate:" + e);
		} finally {
			if (conn != null)
				conn.close();
		}

		return bean;
	}

	public int saveProgramScheduleDetails(DataSource dataSource,
			rws_works_WorkStatus_form bean, nic.watersoft.commons.RwsUser user,
			ArrayList programMileStones) throws Exception {
		int status = 0;
		int count = 0;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String officeCode = "1" + bean.getCircleCode() + bean.getDivCode()
					+ bean.getSubDivAssign();
			String query="select * from RWS_WORK_COMMENCEMENT_TBL where work_id=?";
			ps=conn.prepareStatement(query);
			ps.setString(1,  bean.getWorkId());
			rs = ps.executeQuery();
			boolean update_insert = false;
			if (rs.next()) {
				query = "UPDATE  RWS_WORK_COMMENCEMENT_TBL set "
						+ "GROUNDING_DATE=to_date(?,'dd/mm/yyyy'),OFFICER_ASSIGNED_TO=?,OFFICER_ASSIGNED_TO1=?,OFFICER_ASSIGNED_TO2=?,OFFICER_ASSIGNED_TO3=?,OFFICE_CODE= ?,ENTERED_BY=?,UPDATE_DATE=SYSDATE where work_id=?";
				ps=conn.prepareStatement(query);
				ps.setString(1, bean.getWorkGndDate());
				ps.setString(2, bean.getEngineerAssign());
				ps.setString(3, bean.getEngineerAssign1());
				ps.setString(4, bean.getEngineerAssign2());
				ps.setString(5, bean.getEngineerAssign3());
				ps.setString(6, officeCode);
				ps.setString(7, user.getUserId());
				ps.setString(8, bean.getWorkId());
				count = ps.executeUpdate();
				update_insert = true;
			} else {
				query = "INSERT INTO RWS_WORK_COMMENCEMENT_TBL(WORK_ID ,"
						+ "GROUNDING_DATE ,OFFICER_ASSIGNED_TO ,OFFICER_ASSIGNED_TO1 ,OFFICER_ASSIGNED_TO2 ,OFFICER_ASSIGNED_TO3 ,OFFICE_CODE ,ENTERED_BY,update_date)"
						+ "VALUES(?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,SYSDATE) ";
				ps=conn.prepareStatement(query);
				ps.setString(1, bean.getWorkId());
				ps.setString(2, bean.getWorkGndDate());
				ps.setString(3, bean.getEngineerAssign());
				ps.setString(4, bean.getEngineerAssign1());
				ps.setString(5, bean.getEngineerAssign2());
				ps.setString(6, bean.getEngineerAssign3());
				ps.setString(7, officeCode);
				ps.setString(8, user.getUserId());
				count = ps.executeUpdate();
				update_insert = false;
			}
			for (int i = 0; i < programMileStones.size(); i++) {
				tenderMemo tm = new tenderMemo();

			}
			if (count > 0) {
				if (update_insert)
					status = 2;
				else
					status = 1;
				conn.commit();
			}

		} catch (Exception e) {
			Debug.println("Exception while saving program schedule details in saveProgramScheduleDetails():"
					+ e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return status;
	}

	public boolean deleteProgramScheduleDetails(DataSource dataSource,
			String workId) throws Exception {
		boolean deleted = true;
		int count = 0;
		String q = "", q1 = "", q2 = "", q3 = "", q4 = "", q5 = "", q6 = "";
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			try {
				conn.setAutoCommit(false);

				boolean delete = true;
				q1 = "select * from rws_work_bill_tbl where work_id=?";
				q2 = "select * from RWS_work_exp_voucher_TBL where work_id=?";
				q4 = "select * from RWS_WORK_EXPENDITURE_TBL where work_id=?";
				q5 = "select * from RWS_WORK_EXP_UPTO_PRE_YEAR_TBL where work_id=?";
				q6 = "select * from RWS_WORK_COMPLETION_TBL where work_id=?";

				
				ps = conn.prepareStatement(q1);
				ps.setString(1, workId);
				ResultSet rset = ps.executeQuery();
				
				ps = conn.prepareStatement(q2);
				ps.setString(1, workId);
				ResultSet rset1 = ps.executeQuery();
				
				
				ps = conn.prepareStatement(q4);
				ps.setString(1, workId);
				ResultSet rset3 = ps.executeQuery();
				
				ps = conn.prepareStatement(q5);
				ps.setString(1, workId);
				ResultSet rset4 = ps.executeQuery();
				
				ps = conn.prepareStatement(q6);
				ps.setString(1, workId);
				ResultSet rset5 = ps.executeQuery();
				

				if (rset.next()) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset1.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset3.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset4.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (rset5.next() && delete) {
					delete = false;
					throw new SQLException("RECORD EXIST IN CHILD TABLE");
				}
				if (delete) {
					String query = "delete from  RWS_WORK_COMMENCEMENT_TBL where work_id='"
							+ workId + "'";
					stmt.addBatch(query);
					query = "update RWS_MILESTONE_TARGET_ACH_TBL SET ACHIEVE_DATE ='' WHERE WORK_ID ='"
							+ workId + "'";
					stmt.addBatch(query);
					int rcounts[] = stmt.executeBatch();
					if (rcounts[0] < 1)
						deleted = false;
					if (deleted)
						conn.commit();
				} else {
					deleted = false;
				}
			} catch (SQLException e) {
				//e.printStackTrace();
				Debug.writeln("Exception Occured in deleteProgramScheduleDetails:\n" + e);
				deleted = false;
				try {
					conn.rollback();
				} catch (Exception ex) {
				}

			} catch (Exception e) {
				Debug.writeln("Exception in deleteProgramScheduleDetails :\n" + e);
				deleted = false;
				try {
					conn.rollback();
				} catch (Exception ex) {
				}
			}
		} catch (Exception e) {
			Debug.println("Exception while deleting program schedule details in deleteProgramScheduleDetails():"
					+ e);
			deleted = false;
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}

		return deleted;
	}

	public String getGroundDate(DataSource dataSource, String workId)
			throws Exception {

		String groundDate = null;
		try {
			conn = RwsOffices.getConn();
			String query="select to_char(GROUNDING_DATE ,'dd/mm/yyyy') as gnd_date "
					+ " from  rws_work_commencement_tbl where work_Id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();

			if (rs.next()) {
				groundDate = rs.getString("gnd_date");
			}
		} catch (Exception e) {
			Debug.println("Exceptione in getting ground date in getGroundDate:"+ e);
		} finally {
			releaseConnection();
		}
		return groundDate;
	}

	public ArrayList getExpenditureDetails(DataSource dataSource,
			String workId, HttpServletRequest request, String finYear) {
		ArrayList expendetures = new ArrayList();
		tenderMemo tenderMemoObj = new tenderMemo();
		double exps = 0.0;
		try {
			conn = RwsOffices.getConn();
			
			query = "select e.WORK_ID,e.YEAR,e.MONTH,nvl(e.EXPENDITURE_UPTO,0) as EXPENDITURE_UPTO,nvl(e.EXPENDITURE_DURING,0) as EXPENDITURE_DURING, nvl (e.VALUE_OF_WORK_NOT_PAID,0) as VALUE_OF_WORK_NOT_PAID,e.PROGRAMME_CODE,p.programme_name as prog  from  RWS_WORK_EXPENDITURE_TBL e,"
					+ " rws_programme_tbl p where e.programme_code=p.programme_code "
					+ "and  work_id=? and year=? order by e.programme_code,to_number(substr(e.year,1,4)),to_number(e.month)";
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			ps.setString(2, finYear);
			rs = ps.executeQuery();
			int expMonth = 0;
			String varExpMonth = "";
			while (rs.next()) {
				tenderMemoObj = new tenderMemo();
				tenderMemoObj.setValueOFWorkDone(RwsMasterData.format(rs
						.getString("VALUE_OF_WORK_NOT_PAID")));
				tenderMemoObj.setExpYear(RwsMasterData.format(rs
						.getString("YEAR")));
				expMonth = Integer.parseInt(RwsMasterData.format(rs
						.getString("MONTH")));
				if (expMonth > 3)
					expMonth = expMonth - 3;
				else
					expMonth = expMonth + 9;
				varExpMonth = expMonth + "";

				exps += rs.getDouble("EXPENDITURE_DURING");

				tenderMemoObj.setExpMonth(varExpMonth);
				tenderMemoObj.setExpMonthUp(rs.getString("EXPENDITURE_UPTO"));
				tenderMemoObj.setExpMonthDuring(RwsMasterData.format(rs
						.getString("EXPENDITURE_DURING")));
				tenderMemoObj.setProgCode(rs.getString("PROGRAMME_CODE"));
				tenderMemoObj.setProgName(rs.getString("prog"));
				tenderMemoObj
						.setExpUptoPrevYear("EXPENDITURE_UPTO_THE_PRE_YEAR");
				expendetures.add(tenderMemoObj);
			}

		} catch (Exception e) {
			Debug.println("Exception in getting expenditure Details in getExpenditureDetails()"
					+ e);
		} finally {
			releaseConnection();
		}
		request.setAttribute("exps", "" + round(exps, 2));
		return expendetures;
	}

	public ArrayList getExpenditureUptoPrevYear(DataSource dataSource,
			String workId, HttpServletRequest request, String finYear,
			ArrayList progs) {
		ArrayList programmsList = new ArrayList();
		tenderMemo tenderMemoObj = new tenderMemo();
		tenderMemo tenderMemoObj1;
		double exps = 0.0;
		try {
			conn = RwsOffices.getConn();
			
			for (int i = 0; i < progs.size(); i++) {
				tenderMemoObj1 = (tenderMemo) progs.get(i);
				String query = "select distinct e.WORK_ID,e.PRogramme_code, e.EXPENDITURE_UPTO_THE_PRE_YEAR,e.YEAR,e.UPDATE_DAte,nvl(e.VALUE_OF_WORK_NOT_PAID,0) as VALUE_OF_WORK_NOT_PAID,p.programme_name as prog from  rws_work_exp_upto_pre_year_tbl e,"
						+ " rws_programme_tbl p where e.programme_code=p.programme_code "
						+ "and  work_id=? and e.programme_code=? order by p.programme_name";
				ps = conn.prepareStatement(query);
				ps.setString(1, workId);
				ps.setString(2, tenderMemoObj1.getProgCode());
				rs = ps.executeQuery();

				ArrayList expYears = new ArrayList();
				int actYear = Integer.parseInt(finYear.substring(0, 4));
				actYear--;
				for (int j = 0; actYear >= 2005; j++) {
					expYears.add("" + actYear + "-"
							+ ("" + (actYear + 1)).substring(2, 4));
					actYear--;
				}
				tenderMemoObj = new tenderMemo();
				tenderMemoObj.setWorkid(workId);
				tenderMemoObj.setProgCode(RwsMasterData.format(tenderMemoObj1
						.getProgCode()));
				tenderMemoObj.setProgName(RwsMasterData.format(tenderMemoObj1
						.getProgName()));
				if (rs.next()) {
					tenderMemoObj.setValueOFWorkDoneButnotPaid(""
							+ rs.getString("VALUE_OF_WORK_NOT_PAID"));
					double exp1 = 0.0;
					exp1 = rs.getDouble("EXPENDITURE_UPTO_THE_PRE_YEAR");
					double exp2 = 0.0;
					double exp3 = 0.0;
					for (int u = 0; u < expYears.size(); u++) {
						String qry = "select expenditure_upto,expenditure_during from rws_work_expenditure_tbl where work_id=? and programme_code=? and year=?";
						ps = conn.prepareStatement(qry);
						ps.setString(1, workId);
						ps.setString(2, tenderMemoObj1.getProgCode());
						ps.setString(3, expYears.get(u)+"" );
						ResultSet rrs = ps.executeQuery();

						if (rrs.isBeforeFirst()) {
							while (rrs.next()) {
								exp3 = rrs.getDouble(1) + rrs.getDouble(2);
							}
							exp2 += exp3;
						}
					}

					double exp = exp2;
					tenderMemoObj.setExpUptoPrevYear(RwsMasterData.format(""
							+ round(exp, 2)));

					programmsList.add(tenderMemoObj);
					exps += rs.getDouble("EXPENDITURE_UPTO_THE_PRE_YEAR");
				} else {
					double exp1 = 0.0;
					double exp2 = 0.0;
					double exp3 = 0.0;
					for (int u = 0; u < expYears.size(); u++) {
						String qry = "select expenditure_upto,expenditure_during from rws_work_expenditure_tbl where work_id=? and programme_code=? and year=?";
						ps = conn.prepareStatement(qry);
						ps.setString(1, workId);
						ps.setString(2, tenderMemoObj1.getProgCode());
						ps.setString(3, expYears.get(u)+"" );
						ResultSet rrs = ps.executeQuery();

						if (rrs.isBeforeFirst()) {
							while (rrs.next()) {
								exp3 = rrs.getDouble(1) + rrs.getDouble(2);
							}
							exp2 += exp3;
						}
					}

					double exp = exp2;
					tenderMemoObj.setExpUptoPrevYear(RwsMasterData.format(""
							+ round(exp, 2)));

					programmsList.add(tenderMemoObj);

				}
			}

		} catch (Exception e) {
			//e.printStackTrace();
			Debug.println("Exception in getExpenditureUptoPrevYear()" + e);
		} finally {
			releaseConnection();
		}
		request.setAttribute("exps", "" + exps);
		return programmsList;
	}


	public ArrayList getExpenditureUptoPrevYearByYear(DataSource dataSource,
			String workId, HttpServletRequest request, String finYear,
			ArrayList progs) {
		ArrayList programmsList = new ArrayList();
		tenderMemo tenderMemoObj = new tenderMemo();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			for (int i = 0; i < progs.size(); i++) {
				tenderMemo tenderMemoObj1 = (tenderMemo) progs.get(i);
				String query = "select sum(expenditure_during) from  RWS_WORK_EXPENDITURE_TBL where work_id='"
						+ workId
						+ "' and year<'"
						+ finYear
						+ "' and programme_code='"
						+ tenderMemoObj1.getProgCode() + "'";
				ResultSet rs = stmt.executeQuery(query);
				String expValue = "";
				if (rs.next()) {
					tenderMemoObj = new tenderMemo();
					tenderMemoObj.setProgName(tenderMemoObj1.getProgName());
					if (RwsMasterData.format(rs.getString(1)) == null
							|| RwsMasterData.format(rs.getString(1)).equals(""))
						expValue = "0";
					else
						expValue = RwsMasterData.format(rs.getString(1));
					tenderMemoObj.setExpMonthDuring(expValue);
					programmsList.add(tenderMemoObj);
				} else {
					tenderMemoObj = new tenderMemo();
					tenderMemoObj.setProgName(tenderMemoObj1.getProgName());
					tenderMemoObj.setExpMonthDuring("0");
					programmsList.add(tenderMemoObj);
				}
			}
		} catch (Exception e) {
			Debug.println("Exception in getExpenditureUptoPrevYear()" + e);
		} finally {
			releaseConnection();
		}
		return programmsList;
	}

	public ArrayList getDisableStatus(DataSource dataSource, String workId,
			HttpServletRequest request, String finYear) {
		ArrayList programmsList = new ArrayList();
		tenderMemo tenderMemoObj = new tenderMemo();
		double exps = 0.0;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement qqst = conn.createStatement();
			// String
			// query="select distinct e.*,p.programme_name as prog  from  rws_work_exp_upto_pre_year_tbl e,"
			// +
			// " rws_programme_tbl p where e.programme_code=p.programme_code " +
			// "and  work_id='"+workId+"'";
			String query = "select a.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b where a.programme_code=b.programme_code and a.work_id='"
					+ workId
					+ "' union select a.programme_code,b.programme_name from rws_work_admn_prog_lnk_tbl a,rws_programme_tbl b where a.programme_code=b.programme_code and a.work_id='"
					+ workId + "'";
			// String query =
			// "select programme_code from rws_work_admn_tbl where work_id='"+workId+"' union select programme_code from rws_work_admn_prog_lnk_tbl where work_id='"+workId+"';";
			Debug.println("query::::::::::" + query);
			int i = 0;
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				/*
				 * String qq1 = "select to_char(sysdate,'yyyy') from dual";
				 * Debug.println("query::::::::::1111111"+qq1); Statement qqst1
				 * = conn.createStatement(); ResultSet rss1 =
				 * qqst1.executeQuery(qq1); String year = ""; if(rss1.next()) {
				 * y }
				 */
				String qq = "select nvl(sum(expenditure_during),0)  from  rws_work_expenditure_tbl where work_id='"
						+ workId
						+ "' and programme_code='"
						+ rs.getString(1)
						+ "'  and year<'" + finYear + "'";
				Debug.println("query:::::::::eeeeeeee:" + qq);
				ResultSet qqrs = qqst.executeQuery(qq);
				if (qqrs.next()) {

					if (qqrs.getInt(1) > 0)
						programmsList.add(i++, "true");
					else
						programmsList.add(i++, "false");
				}
			}
			Debug.println("######################:" + programmsList.size());
		} catch (Exception e) {
			Debug.println("Exception in getExpenditureUptoPrevYear()" + e);
		} finally {
			releaseConnection();
		}
		// request.setAttribute("exps",""+exps);
		return programmsList;
	}

	public ArrayList getAggExpenditure(DataSource dataSource, String workId,
			HttpServletRequest request) {
		ArrayList aggExpList = new ArrayList();
		tenderMemo tenderMemoObj = new tenderMemo();
		double exps = 0.0;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement qqst = conn.createStatement();
			String query = "select distinct e.*,p.programme_name as prog  from  rws_work_exp_upto_pre_year_tbl e,"
					+ " rws_programme_tbl p where e.programme_code=p.programme_code "
					+ " and  work_id=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			String a = "", b = "";
			double d1 = 0.0, d2 = 0.0, d3 = 0.0, d4 = 0.0;
			while (rs.next()) {
				tenderMemoObj = new tenderMemo();
				a = "select nvl(EXPENDITURE_UPTO_THE_PRE_YEAR,0) from  rws_work_exp_upto_pre_year_tbl where work_id=? and programme_code=?";
				b = "select * from  rws_work_expenditure_tbl where work_id=? and programme_code=? order by month";
				ps=conn.prepareStatement(a);
				ps.setString(1, workId);
				ps.setString(2, rs.getString("PROGRAMME_CODE"));
				ResultSet rs1 = ps.executeQuery();
				
				ps=conn.prepareStatement(b);
				ps.setString(1, workId);
				ps.setString(2, rs.getString("PROGRAMME_CODE"));
				ResultSet rs2 = ps.executeQuery();
				if (rs1.next()) {
					d1 = rs1.getDouble(1);
				}
				while (rs2.next()) {
					d2 = rs2.getDouble(4);
					d4 = rs2.getDouble(5);
				}
				d3 = d1 + d2 + d4;
				exps += d3;
				tenderMemoObj.setProgName(RwsMasterData.format(rs
						.getString("prog")));
				tenderMemoObj.setAggrigateExpenditureForProg("" + round(d3, 2));
				aggExpList.add(tenderMemoObj);
			}

			request.setAttribute("exps", "" + round(d1, 2));
		} catch (Exception e) {
			Debug.println("Exception in getAggExpenditure()" + e);
		} finally {
			releaseConnection();
		}
		return aggExpList;
	}

	public int saveExpenditure(DataSource dataSource, ArrayList selectedList,
			String workCode, String valuOfWOrkNotPaid, ArrayList programmsList,
			String finYear, String cYear, ArrayList status) throws Exception {
		boolean insertedSuccessfully = true;
		int count = 0;
		int returnVal = -1;
		try {
			tenderMemo tenderMemoObj = new tenderMemo();
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String q = "";
			boolean delflag = true;
			tenderMemo bean = null;
			for (int i = 0; i < programmsList.size(); i++) {
				bean = (tenderMemo) programmsList.get(i);

				q = "select * from rws_work_exp_upto_pre_year_tbl where work_id=? and programme_code=?";
				ps = conn.prepareStatement(q);
				ps.setString(1, workCode);
				ps.setString(2, bean.getProgCode());
				ResultSet qrs = ps.executeQuery();
				if (!qrs.next()) {
					query = "insert into rws_work_exp_upto_pre_year_tbl (WORK_ID ,PROGRAMME_CODE,EXPENDITURE_UPTO_THE_PRE_YEAR,VALUE_OF_WORK_NOT_PAID,UPDATE_DATE) values('"
							+ workCode
							+ "','"
							+ bean.getProgCode()
							+ "','0',nvl('"
							+ bean.getValueOFWorkDoneButnotPaid()
							+ "',0),SYSDATE)";
				} else {
					query = "update rws_work_exp_upto_pre_year_tbl set PROGRAMME_CODE='"
							+ bean.getProgCode()
							+ "',EXPENDITURE_UPTO_THE_PRE_YEAR='0',VALUE_OF_WORK_NOT_PAID=nvl('"
							+ bean.getValueOFWorkDoneButnotPaid()
							+ "',0),UPDATE_DATE=SYSDATE where work_id='"
							+ workCode + "'";
				}
				stmt.addBatch(query);
				if (returnVal != 2)
					returnVal = 1;
			}

			int expMonth = 0;
			String varExpMonth = "";
			ResultSet checkRs = null;
			for (int i = 0; i < selectedList.size(); i++) {
				tenderMemoObj = (tenderMemo) selectedList.get(i);
				if (tenderMemoObj.getExpMonth() != null
						&& !tenderMemoObj.getExpMonth().equals("")) {
					expMonth = Integer.parseInt(tenderMemoObj.getExpMonth());
					if (expMonth < 10)
						expMonth = expMonth + 3;
					else
						expMonth = expMonth - 9;
					varExpMonth = expMonth + "";
					if (varExpMonth.length() == 1)
						varExpMonth = "0" + varExpMonth;
					String checkQuery = "select * from RWS_WORK_EXPENDITURE_TBL where  work_id=? and year=? and month=? and programme_code=?";
					ps = conn.prepareStatement(checkQuery);
					ps.setString(1, workCode);
					ps.setString(2, finYear);
					ps.setString(3, varExpMonth);
					ps.setString(4, tenderMemoObj.getProgCode() );
					checkRs = ps.executeQuery();
					boolean checkFlag = checkRs.isBeforeFirst();

					if (!checkFlag) {
						query = "insert into RWS_WORK_EXPENDITURE_TBL"
								+ "(WORK_ID,YEAR ,MONTH ,EXPENDITURE_UPTO,EXPENDITURE_DURING ,"
								+ "programme_code,UPDATE_DATE) values ('"
								+ workCode + "','" + finYear + "','"
								+ varExpMonth + "',nvl('"
								+ tenderMemoObj.getExpMonthUp() + "',0),nvl('"
								+ tenderMemoObj.getExpMonthDuring() + "',0),'"
								+ tenderMemoObj.getProgCode() + "',SYSDATE)";
						stmt.addBatch(query);
						returnVal = 1;
					} else {
						query = "update rws_work_expenditure_tbl set EXPENDITURE_UPTO=nvl('"
								+ tenderMemoObj.getExpMonthUp()
								+ "',0),EXPENDITURE_DURING=nvl('"
								+ tenderMemoObj.getExpMonthDuring()
								+ "',0),UPDATE_DATE=SYSDATE where  work_id='"
								+ workCode
								+ "' and year='"
								+ finYear
								+ "' and month='"
								+ varExpMonth
								+ "' and programme_code='"
								+ tenderMemoObj.getProgCode() + "'";
						stmt.addBatch(query);
						returnVal = 2;
					}
				}
			}
			int rcounts[] = stmt.executeBatch();
			for (int i = 2; i < rcounts.length; i++)
				if (rcounts[i] < 1)
					insertedSuccessfully = false;

		} catch (Exception e) {
			Debug.println("Exception in saveExpenditure " + e);
			insertedSuccessfully = false;
		} finally {
			if (insertedSuccessfully)
				conn.commit();
			releaseConnection();

		}
		if (insertedSuccessfully) {

			return returnVal;
		} else
			return returnVal;

	}

	public int deleteExpenditure(DataSource dataSource, String workId)
			throws Exception {
		int returnValue = -1;
		boolean deletedSussfully = true;
		int count = 0;
		String  q6 = "";
		ResultSet  rset5 = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			try {

				boolean delete = true;
				q6 = "select * from RWS_WORK_COMPLETION_TBL where work_id=?";
				ps=conn.prepareStatement(q6);
				ps.setString(1, workId);
				rset5 = ps.executeQuery();

				if (rset5.next() && delete) {
					/*
					 * delete=false;
					 * Debug.println("RECORD EXIST IN RWS_WORK_COMPLETION_TBL");
					 * throw new SQLException("RECORD EXIST IN CHILD TABLE");
					 */
				}
				if (delete) {
					query = "delete from rws_work_exp_upto_pre_year_tbl where WORK_ID='"
							+ workId + "'";
					stmt.addBatch(query);

					query = "delete from RWS_WORK_EXPENDITURE_TBL where WORK_ID='"
							+ workId + "'";
					stmt.addBatch(query);

					int rcounts[] = stmt.executeBatch();

					for (int i = 0; i < rcounts.length; i++) {
						if (rcounts[i] < 1) {
							deletedSussfully = false;
						} else {
							returnValue++;
						}
					}
				} else {
					deletedSussfully = false;
				}
			} catch (SQLException e) {
				Debug.writeln("Exception Occured in deleteExpenditure:\n" + e);
				deletedSussfully = false;
				returnValue = -2;
				try {
					conn.rollback();
				} catch (Exception ex) {
				}

			} catch (Exception e) {
				Debug.writeln("Exception in deleteExpenditure :\n" + e);
				deletedSussfully = false;
				returnValue = -2;
				try {
					conn.rollback();
				} catch (Exception ex) {
				}
			}

		} catch (Exception e) {
			Debug.println("Exception in deleteExpenditure " + e);
			deletedSussfully = false;
		} finally {
			if (returnValue >= 0) {
				conn.commit();
				conn.setAutoCommit(true);
			}
			releaseConnection();

		}
		if (deletedSussfully) {
			returnValue = 1;
		}
		return returnValue;
	}

	public String formtNull(String val) {
		if (val == null || val.equals("null"))
			val = "";
		return val;
	}

	public int saveContMgtMileStones(DataSource dataSource,
			ArrayList selectedList, String workCode,
			WorksMonitoringActionBean worksBean) throws Exception {
		boolean insertedSuccessfully = true;
		Debug.println("in saveExpenditure");
		int count = 0;
		int contSel = 0;
		try {
			tenderMemo tenderMemoObj = new tenderMemo();
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();

			Debug.println("site hand over date is "
					+ worksBean.getSiteHandDate());

			query = "select count(*) from rws_tender_appl_tbl where  work_id='"
					+ workCode + "'";
			rset = stmt2.executeQuery(query);
			if (rset.next())
				contSel = rset.getInt(1);
			if (contSel == 0) {
				query = "insert into rws_tender_appl_tbl(WORK_ID,TENDER_IDNO,CONTRACTOR_NAME,TENDER_AMOUNT,RECIEVED_ON "
						+ " ) values('"
						+ workCode
						+ "','"
						+ worksBean.getTenderNoteId()
						+ "','"
						+ worksBean.getCfName()
						+ "',"
						+ " "
						+ worksBean.getTenderCost()
						+ ","
						+ " to_date('"
						+ worksBean.getTenderAccDate()
						+ "','dd/mm/yyyy')"
						+ " )";
				Debug.println("query is " + query);
				stmt.addBatch(query);

			} else {
				query = "update rws_tender_appl_tbl set " + "TENDER_IDNO='"
						+ worksBean.getTenderNoteId() + "',CONTRACTOR_NAME='"
						+ worksBean.getCfName() + "',TENDER_AMOUNT="
						+ worksBean.getTenderCost()
						+ " ,RECIEVED_ON= to_date('"
						+ worksBean.getTenderAccDate() + "','dd/mm/yyyy')"
						+ "  where work_id='" + workCode + "'";
				Debug.println("query is " + query);
				stmt.addBatch(query);
			}

			query = "select count(*) from RWS_CONTRACTOR_SELECTION_TBL where work_id='"
					+ workCode + "'";
			rset = stmt2.executeQuery(query);
			if (rset.next())
				contSel = rset.getInt(1);
			if (contSel == 0) {
				query = " insert into RWS_CONTRACTOR_SELECTION_TBL(WORK_ID,"
						+ " TENDER_IDNO,AGREEMENT_REFERENCE_NO,"
						+ " AGREEMENT_DURATION,AGREEMENT_VALUE,SITE_HAND_OVER_DATE,"
						+ " AGREEMENT_DATE,TENDER_APPROVED_ON,LOA_ISSUED_ON,"
						+ " TENDER_COMMITTEE,COMPETENT_AUTHORITY,DATE_OF_COMPLETION,TENDER_PERCENT) "
						+ " values('"
						+ workCode
						+ "','"
						+ worksBean.getTenderNoteId()
						+ "','"
						+ worksBean.getAgreeRefNo()
						+ "','"
						+ worksBean.getAgreeDur()
						+ "','"
						+ worksBean.getAgreeVal()
						+ "',to_date('"
						+ RwsMasterData.format(worksBean.getSiteHandDate())
						+ "','dd-mm-yyyy'),to_date('"
						+ RwsMasterData.format(worksBean.getAgreeDate())
						+ "','dd-mm-yyyy'),to_date('"
						+ RwsMasterData.format(worksBean.getTenderAppDate())
						+ "','dd-mm-yyyy'),to_date('"
						+ RwsMasterData.format(worksBean.getLoa())
						+ "','dd-mm-yyyy'),'"
						+ worksBean.getTenderCommittee()
						+ "','"
						+ worksBean.getCompAuthority()
						+ "',to_date('"
						+ RwsMasterData.format(worksBean.getWorkCompDate())
						+ "','dd-mm-yyyy'),"
						+ "'"
						+ worksBean.getTenderPer()
						+ "')";
				Debug.println("query is " + query);
				stmt.addBatch(query);

			} else {
				query = "update RWS_CONTRACTOR_SELECTION_TBL set "
						+ "TENDER_IDNO  ='"
						+ worksBean.getTenderNoteId()
						+ "',"
						+ "AGREEMENT_REFERENCE_NO ='"
						+ worksBean.getAgreeRefNo()
						+ "',"
						+ "AGREEMENT_DURATION  = '"
						+ worksBean.getAgreeDur()
						+ "',"
						+ "AGREEMENT_VALUE  = '"
						+ worksBean.getAgreeVal()
						+ "',"
						+ "SITE_HAND_OVER_DATE = to_date('"
						+ RwsMasterData.format(worksBean.getSiteHandDate())
						+ "','dd-mm-yyyy'),"
						+ "AGREEMENT_DATE  = to_date('"
						+ RwsMasterData.format(worksBean.getAgreeDate())
						+ "','dd-mm-yyyy'),"
						+ "TENDER_APPROVED_ON = to_date('"
						+ RwsMasterData.format(worksBean.getTenderAppDate())
						+ "','dd-mm-yyyy'),"
						+ "LOA_ISSUED_ON   = to_date('"
						+ RwsMasterData.format(worksBean.getLoa())
						+ "','dd-mm-yyyy'),"
						+ "TENDER_COMMITTEE = '"
						+ worksBean.getTenderCommittee()
						+ "',"
						+ "COMPETENT_AUTHORITY = '"
						+ worksBean.getCompAuthority()
						+ "',"
						+ "DATE_OF_COMPLETION = to_date('"
						+ RwsMasterData.format(worksBean.getWorkCompDate())
						+ "','dd-mm-yyyy') "
						+ ",TENDER_PERCENT ='"
						+ worksBean.getTenderPer()
						+ "'"
						+ "where work_id='"
						+ workCode + "'";
				Debug.println("query is " + query);
				stmt.addBatch(query);
			}
			for (int i = 0; i < selectedList.size(); i++) {
				tenderMemoObj = (tenderMemo) selectedList.get(i);
				query = "delete from RWS_MILESTONE_TARGET_ACH_TBL where "
						+ "work_id='" + workCode + "'";
				Debug.println("query is " + query);
				stmt.addBatch(query);
			}

			for (int i = 0; i < selectedList.size(); i++) {
				tenderMemoObj = (tenderMemo) selectedList.get(i);

				query = "insert into RWS_MILESTONE_TARGET_ACH_TBL "
						+ "(WORK_ID,MILESTONE_CODE  ,MILESTONE_STAGE_CODE ,TARGET_DATE ,PERCENT_COMPLETED "
						+ " ) values ('" + workCode + "','"
						+ tenderMemoObj.getMstone() + "','"
						+ tenderMemoObj.getStages() + "',to_date('"
						+ tenderMemoObj.getTargetDate() + "','dd/mm/yyyy'),"
						+ tenderMemoObj.getPercentComp() + ")";
				Debug.println("query is " + query);
				stmt.addBatch(query);
			}
			int rcounts[] = stmt.executeBatch();
			for (int i = selectedList.size() + 2; i < rcounts.length; i++)
				if (rcounts[i] < 1)
					insertedSuccessfully = false;
			for (int i = 0; i < rcounts.length; i++) {
				Debug.println("rcounts[" + i + "]=" + rcounts[i]);
			}

		} catch (Exception e) {
			Debug.println("Exception in saveContMgtMileStones " + e);
			insertedSuccessfully = false;
		} finally {
			if (insertedSuccessfully)
				conn.commit();
			releaseConnection();

		}
		if (insertedSuccessfully) {

			return 1;
		} else
			return -1;

	}

	public int removeExpenditure(DataSource dataSource, ArrayList selectedList,
			String workCode, String finYear) throws Exception {
		tenderMemo tenderMemoObj = null;
		boolean removedSuccessfully = true;
		int count = 0;
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			int expMonth = 0;
			String varExpMonth = "";
			for (int i = 0; i < selectedList.size(); i++) {
				tenderMemoObj = (tenderMemo) selectedList.get(i);
				expMonth = Integer.parseInt(tenderMemoObj.getExpMonth());
				if (expMonth < 10)
					expMonth = expMonth + 3;
				else
					expMonth = expMonth - 9;
				varExpMonth = expMonth + "";
				if (varExpMonth.length() == 1)
					varExpMonth = "0" + varExpMonth;
				query = "delete from RWS_WORK_EXPENDITURE_TBL where "
						+ "work_id='" + workCode + "' and  " + "YEAR='"
						+ finYear + "' and MONTH='" + varExpMonth
						+ "' and PROGRAMME_CODE ='"
						+ tenderMemoObj.getProgCode() + "'";
				stmt.addBatch(query);
			}
			int rcounts[] = stmt.executeBatch();
			for (int i = 0; i < rcounts.length; i++)
				if (rcounts[i] < 1)
					removedSuccessfully = false;
			for (int i = 0; i < rcounts.length; i++) {
				Debug.println("rcounts[" + i + "]=" + rcounts[i]);
			}
		} catch (Exception e) {
			Debug.println("Exception in removeExpenditure " + e);
			removedSuccessfully = false;
		} finally {
			if (removedSuccessfully)
				conn.commit();
			releaseConnection();

		}
		if (removedSuccessfully) {

			return 1;
		} else
			return -1;
	}

	public int removeContMgtMileStones(DataSource dataSource,
			ArrayList selectedList, String workCode) throws Exception {
		tenderMemo tenderMemoObj = null;
		boolean removedSuccessfully = true;
		Debug.println("in removeExpenditure");
		int count = 0;
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			for (int i = 0; i < selectedList.size(); i++) {
				tenderMemoObj = (tenderMemo) selectedList.get(i);
				query = "delete from RWS_MILESTONE_TARGET_ACH_TBL where "
						+ "work_id='" + workCode + "' and  "
						+ "MILESTONE_CODE ='" + tenderMemoObj.getMstone()
						+ "' and MILESTONE_STAGE_CODE='"
						+ tenderMemoObj.getStages() + "'";
				Debug.println("query is " + query);
				stmt.addBatch(query);
			}
			int rcounts[] = stmt.executeBatch();
			for (int i = 0; i < rcounts.length; i++)
				if (rcounts[i] < 1)
					removedSuccessfully = false;
			for (int i = 0; i < rcounts.length; i++) {
				Debug.println("rcounts[" + i + "]=" + rcounts[i]);
			}
		} catch (Exception e) {
			Debug.println("Exception in removeContMgtMileStones " + e);
			removedSuccessfully = false;
		} finally {
			if (removedSuccessfully)
				conn.commit();
			releaseConnection();

		}
		if (removedSuccessfully) {

			return 1;
		} else
			return -1;
	}

	public ArrayList getMonthsInFincialYearBefore(String month) {
		int mon = Integer.parseInt(month);
		ArrayList monthsList = new ArrayList();
		if (mon > 3) {
			for (int i = 4; i <= mon; i++)
				monthsList.add(i + "");

		}
		if (mon <= 3) {
			for (int i = 4; i <= 12; i++)
				monthsList.add(i + "");
			for (int i = 1; i <= mon; i++)
				monthsList.add(i + "");

		}
		return monthsList;
	}

	public float getExpUptoPrevMonth(DataSource dataSource, String workId,
			String year, String month) {
		ArrayList monthList = getMonthsInFincialYearBefore(month);
		String query = "";
		float expUptoPrevMonth = 0;
		try {
			query = "select sum(case when expenditure_during is not null then expenditure_during else 0 end)as expUptoPrevMonth from RWS_WORK_EXPENDITURE_TBL"
					+ " where work_id=? and year=? and month in(";
			for (int i = 0; i < monthList.size(); i++) {
				query = query + "'" + monthList.get(i) + "'";
				if (i != (monthList.size() - 1))
					query = query + ",";
			}
			query = query + ")";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			ps.setString(2, year);
			rset = ps.executeQuery();
			if (rset.next()) {
				expUptoPrevMonth = rset.getFloat("expUptoPrevMonth");
			}
		} catch (Exception e) {
			Debug.println("Exception in getExpUptoPrevMonth is " + e);
		} finally {
			releaseConnection();
		}
		return expUptoPrevMonth;
	}

	public ArrayList getMileStoneStages(DataSource dataSource,
			String mileStoneCode) {
		ArrayList mileStoneStagesList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select * from RWS_MILESTONE_STAGE_TBL where MILESTONE_CODE='"
					+ mileStoneCode + "'";
			Debug.println("query is " + query);
			rset = stmt.executeQuery(query);

			LabelValueBean labelValueBean = null;
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString("MILESTONE_STAGE_CODE"));
				labelValueBean.setLabel(rset.getString("MILESTONE_STAGE_NAME"));
				mileStoneStagesList.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getMileStoneStages is " + e);
		} finally {
			releaseConnection();
		}
		return mileStoneStagesList;
	}

	public int[] deleteContMgt(DataSource dataSource, String workCode)
			throws Exception {

		boolean removedSuccessfully = true;
		int[] rvalue = null;
		Debug.println("in removeExpenditure");
		int count = 0;
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			query = "delete from rws_tender_appl_tbl where work_id='"
					+ workCode + "'";
			Debug.println("query is " + query);
			stmt.addBatch(query);

			query = "delete from RWS_MILESTONE_TARGET_ACH_TBL where work_id='"
					+ workCode + "'";
			Debug.println("query is " + query);
			stmt.addBatch(query);

			query = "delete from RWS_CONTRACTOR_SELECTION_TBL where work_id='"
					+ workCode + "'";
			Debug.println("query is " + query);
			stmt.addBatch(query);

			int rcounts[] = stmt.executeBatch();
			for (int i = 0; i < rcounts.length; i++)
				if (rcounts[i] < 1)
					removedSuccessfully = false;
			for (int i = 0; i < rcounts.length; i++) {
				Debug.println("rcounts[" + i + "]=" + rcounts[i]);
			}
			rvalue = rcounts;
		} catch (Exception e) {
			Debug.println("Exception in deleteContMgt is " + e);
		} finally {
			conn.commit();
			releaseConnection();
		}
		return rvalue;
	}

	public rws_works_WorkStatus_form getPopBenfitedOnWorkComPletion(
			DataSource dataSource, String workCode) {

		rws_works_WorkStatus_form worksBean = new rws_works_WorkStatus_form();

		try {

			conn = RwsOffices.getConn();

			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS "
					+ "SC_POP_TOT,SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL "
					+ "WHERE HAB_CODE IN(select HAB_CODE from RWS_WORK_COMPLETION_TBL  e,RWS_WORK_COMP_HAB_LNK_TBL   EL "
					+ "WHERE E.WORK_ID=EL.WORK_ID AND E.WORK_ID=?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, workCode);
			ResultSet rset1 = ps.executeQuery();
			if (rset1.next()) {
				worksBean.setPlainPop(RwsMasterData.format(rset1
						.getInt("PLAIN_POP_TOT") + ""));
				worksBean.setScPop(RwsMasterData.format(rset1
						.getInt("SC_POP_TOT") + ""));
				worksBean.setStPop(RwsMasterData.format(rset1
						.getInt("ST_POP_TOT") + ""));
			}
		} catch (Exception e) {
			Debug.println("Exception in getPopBenfitedOnWorkComPletion is " + e);
		} finally {
			releaseConnection();
		}
		return worksBean;
	}

	public rws_works_WorkStatus_form getWorksCompletionData(
			DataSource dataSource, String workCode) {
		rws_works_WorkStatus_form worksBean = new rws_works_WorkStatus_form();
		
		try {

			conn = RwsOffices.getConn();
			String startqry = "select to_char(GROUNDING_DATE,'dd/mm/yyyy')  from RWS_WORK_COMMENCEMENT_TBL where work_id=?";
			ps=conn.prepareStatement(startqry);
			ps.setString(1, workCode);
			ResultSet startrs = ps.executeQuery();
			if (startrs.next()) {
				worksBean.setWorkCompStartDate(startrs.getString(1));
			} else {
				worksBean.setWorkCompStartDate("");
			}
			String startqry1 = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),to_char(PROBABLE_DATE,'dd/mm/yyyy')  from RWS_CONTRACTOR_SELECTION_TBL where work_id=?";
			ps=conn.prepareStatement(startqry1);
			ps.setString(1, workCode);
			ResultSet startrs1 = ps.executeQuery();
			if (startrs1.next()) {
				worksBean.setWorkCompStipulatedDateOfCompletion(startrs1
						.getString(1));
				worksBean.setProbCompDate(startrs1.getString(2));

			} else {
				worksBean.setWorkCompStipulatedDateOfCompletion("");
			}
			query = "select to_char(wc.DATE_OF_COMPLETION,'dd/mm/yyyy')as "
					+ "actual_date_of_completion,to_char(wc.DATE_OF_COMM ,'dd/mm/yyyy')"
					+ "as  date_of_commission,to_char(wc.DT_FIN_COMPLETION,'dd/mm/yyyy') as fincomp,REMARKS,handover_pri,to_char(wc.PARTIAL_DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl wc"
					+ " where wc.work_id=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, workCode);
			rset = ps.executeQuery();
			if (rset.next()) {
				worksBean.setWorkCompDateCompleted(rset
						.getString("actual_date_of_completion"));
				worksBean.setDateOfComm(rset.getString("date_of_commission"));
				worksBean.setWorkCompFinDtOfComp(rset.getString("fincomp"));
				worksBean.setPriYesOrNo(rset.getString("handover_pri"));
				worksBean.setPartialDateOfCompletion(rset.getString(6));
			}
			ResultSet rseet = null;
			try {
				query = "select REMARKS from rws_work_admn_tbl where work_id=?";
				ps=conn.prepareStatement(query);
				ps.setString(1, workCode);
				rseet = ps.executeQuery();
				if (rseet.next()) {
					worksBean.setRemarks(rseet.getString("REMARKS"));
				}
			} catch (Exception e) {
			} finally {
				if (rseet != null) {
					rseet.close();
					rseet = null;
				}
				if (ps != null) {
					ps.close();
					ps = null;
				}
			}
			query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS SC_POP_TOT,"
					+ "SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE IN"
					+ "(select HAB_CODE from rws_work_completion_tbl e,RWS_work_comp_hab_lnk_tbl  EL "
					+ "WHERE E.WORK_ID=EL.WORK_ID AND E.WORK_ID=?)";
			ps = conn.prepareStatement(query);
			ps.setString(1, workCode);
			ResultSet rset = ps.executeQuery();
			if (rset.next()) {
				worksBean.setPlainPop(RwsMasterData.format(rset
						.getInt("PLAIN_POP_TOT") + ""));
				worksBean.setScPop(RwsMasterData.format(rset
						.getInt("SC_POP_TOT") + ""));
				worksBean.setStPop(RwsMasterData.format(rset
						.getInt("ST_POP_TOT") + ""));
			}

			String s="select count(*)  from  rws_work_comp_hab_lnk_tbl where work_id=?";
			ps = conn.prepareStatement(s);
			ps.setString(1, workCode);
			ResultSet rsNew = ps.executeQuery();
			int count = 0;
			if (rsNew.next()) {
				count = rsNew.getInt(1);
				worksBean.setTechHabsBen("" + rsNew.getInt(1));
			}
			if (count == 0) {
				query = "SELECT SUM(CENSUS_PLAIN_POPU )AS PLAIN_POP_TOT,SUM(CENSUS_SC_POPU)AS "
						+ "SC_POP_TOT,SUM(CENSUS_ST_POPU)AS ST_POP_TOT FROM RWS_HABITATION_DIRECTORY_TBL "
						+ "WHERE HAB_CODE IN(select HAB_CODE from rws_new_est_tbl e,RWS_EST_NEW_HAB_LNK_TBL EL "
						+ "WHERE E.WORK_ID=EL.WORK_ID AND E.WORK_ID=?)";
				ps = conn.prepareStatement(query);
				ps.setString(1, workCode);
				ResultSet rset1 = ps.executeQuery();
				if (rset1.next()) {
					worksBean.setPlainPop(RwsMasterData.format(rset1
							.getInt("PLAIN_POP_TOT") + ""));
					worksBean.setScPop(RwsMasterData.format(rset1
							.getInt("SC_POP_TOT") + ""));
					worksBean.setStPop(RwsMasterData.format(rset1
							.getInt("ST_POP_TOT") + ""));
				}

			}
		} catch (Exception e) {
			Debug.println("Exception in getWorksCompletionData is " + e);
		} finally {
			releaseConnection();
		}
		return worksBean;
	}

	public int insertWorksRemarks(String workId, String remarks) {
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();


			query = "update rws_work_admn_tbl set remarks=? where work_id=?";
			pstat = conn.prepareStatement(query);
			pstat.setString(1, remarks);
			pstat.setString(2, workId);
			rcount = pstat.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception in insertWorkCompData is " + e);
		} finally {
			releaseConnection();
		}
		return rcount;
	}

	public int insertWorkCompData(DataSource dataSource, String workCode,
			rws_works_WorkStatus_form worksBean, String work_id,
			String[] habcodes, String remarks) throws Exception {

		int addedSuccessfully = -1;
		int[] rvalue = null;
		int count = 0;
		int rcount = 0;
		PreparedStatement prpStmt = null;
		ResultSet rSet = null;
		boolean fhtc_Status = true;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			query = "select count(*) from rws_work_completion_tbl where work_id=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, work_id);
			rset = ps.executeQuery();
			if (rset.next()) {
				count = rset.getInt(1);
			}
			if(work_id.substring(0, 2).equals("89")){
				String sqlQuery = " SELECT HD.pending_fhtc FROM rws_panchayat_raj_tbl PR, "
						  + " rws_habitation_directory_tbl HD, RWS_WORK_COMP_HAB_LNK_TBL HL "
						  + " WHERE PR.panch_code = HL.hab_code "
						  + " AND PR.panch_code = HD.hab_code "
						  + " AND HL.work_id =?";
				  prpStmt = conn.prepareStatement(sqlQuery);
		           prpStmt.setString(1, work_id);
		           rSet = prpStmt.executeQuery();
		       
		           	while(rSet.next())
		 			{
		           		if(rSet.getString(1) == null || rSet.getString(1).isEmpty()){
		           			fhtc_Status = false;
		           			break;
		           		}	
		 			}
		        	if(rSet != null)
		           		rSet.close();
		           	if(prpStmt != null )
		           		prpStmt.close();
			//	String qry = "select pending_fhtc from rws_habitation_directory_tbl where 
			}
			if(fhtc_Status){
			if (count == 0) {
				query = "insert into rws_work_completion_tbl(WORK_ID,DATE_OF_COMPLETION ,DATE_OF_COMM,REMARKS,UPDATE_DATE,DT_FIN_COMPLETION,HANDOVER_PRI,PARTIAL_DATE_OF_COMPLETION ) "
						+ "VALUES('"
						+ workCode
						+ "',to_date('"
						+ worksBean.getWorkCompActualDtOfComp()
						+ "','dd/mm/yyyy')"
						+ ",to_date('"
						+ worksBean.getDateOfComm()
						+ "','dd/mm/yyyy'),'"
						+ remarks
						+ "',SYSDATE,to_date('"
						+ worksBean.getWorkCompFinDtOfComp()
						+ "','dd/mm/yyyy'),'"
						+ worksBean.getPriYesOrNo()
						+ "',to_date('"
						+ worksBean.getPartialDateOfCompletion()
						+ "','dd/mm/yyyy'))";
				stmt.addBatch(query);
				for (int i = 0; i < habcodes.length; i++) {
					String HAB_CODE = habcodes[i];
					if (HAB_CODE != null) {
						String query1 = "Insert into RWS_WORK_COMP_HAB_LNK_TBL (WORK_ID,HAB_CODE)values"
								+ "('" + work_id + "','" + HAB_CODE + "')";
						stmt.addBatch(query1);
					}
				}
				stmt.executeBatch();
				addedSuccessfully = 1;
				conn.commit();
			} else {
				query = "update rws_work_completion_tbl set "
						+ "DATE_OF_COMPLETION=to_date('"
						+ worksBean.getWorkCompActualDtOfComp()
						+ "','dd/mm/yyyy')" + ",DATE_OF_COMM=to_date('"
						+ worksBean.getDateOfComm()
						+ "','dd/mm/yyyy'),REMARKS='" + remarks
						+ "',UPDATE_DATE=SYSDATE,DT_FIN_COMPLETION=to_date('"
						+ worksBean.getWorkCompFinDtOfComp()
						+ "','dd/mm/yyyy'),HANDOVER_PRI = '"
						+ worksBean.getPriYesOrNo()
						+ "',PARTIAL_DATE_OF_COMPLETION=to_date('"
						+ worksBean.getPartialDateOfCompletion()
						+ "','dd/mm/yyyy')  where WORK_ID='" + workCode + "'";
				stmt.addBatch(query);
				String query1 = "delete from rws_work_comp_hab_lnk_tbl where work_id='"
						+ work_id + "'";
				stmt.addBatch(query1);
				for (int i = 0; i < habcodes.length; i++) {
					String HAB_CODE = habcodes[i];
					if (HAB_CODE != null) {
						String query2 = "insert into RWS_WORK_COMP_HAB_LNK_TBL (WORK_ID,HAB_CODE)values"
								+ "('" + work_id + "','" + HAB_CODE + "')";
						stmt.addBatch(query2);
					}
				}
				stmt.executeBatch();
				addedSuccessfully = 2;
				conn.commit();

			}
			}else addedSuccessfully = 3;
		} catch (Exception e) {
			Debug.println("Exception in insertWorkCompData is " + e);
			addedSuccessfully = -1;
		} finally {
			releaseConnection();
		}
		worksBean.setPartialDateOfCompletion("");
		return addedSuccessfully;
	}

	public int deleteWorkCompData(DataSource dataSource, String workCode,
			String dateOfComm, String dateOfComp) throws Exception {
		int deletedSuccessfully = -1;
		int[] rvalue = null;
		int count = 0;
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			boolean delete = true;
			if (dateOfComp == null)
				dateOfComp = "";
			if (delete) {
				stmt = conn.createStatement();
				query = "delete from rws_work_completion_tbl where work_id='"
						+ workCode + "'";
				stmt.addBatch(query);
				String query1 = "delete from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"
						+ workCode + "'";
				stmt.addBatch(query1);

				rvalue = stmt.executeBatch();

				for (int i = 0; i < rvalue.length; i++) {
					deletedSuccessfully = 1;
				}

				if (rvalue[0] < 1)
					deletedSuccessfully = -1;
			} else {
				deletedSuccessfully = -2;
			}
		} catch (SQLException e) {
			Debug.writeln("Exception Occured:\n" + e);
			deletedSuccessfully = -1;
			try {
				conn.rollback();
			} catch (Exception ex) {
			}

		} catch (Exception e) {
			Debug.writeln("Exception in getSelectedHabitations :\n" + e);
			deletedSuccessfully = -1;
			try {
				conn.rollback();
			} catch (Exception ex) {
			}
		} finally {
			if (deletedSuccessfully == 1)
				conn.commit();
			releaseConnection();

		}
		return deletedSuccessfully;
	}

	public ArrayList getProgramMileStones(DataSource dataSource, String workId) {
		ArrayList mileStrone = new ArrayList();
		Connection conn = null;
		ResultSet rs =null;
		try {
			conn = RwsOffices.getConn();
			
			String qry = "select MILESTONE_NAME ,MILESTONE_STAGE_NAME ,"
					+ "to_char(TARGET_DATE,'dd/mm/yyyy'),PERCENT_COMPLETED ,WORK_ID,ah.MILESTONE_CODE,ah.MILESTONE_STAGE_CODE "
					+ " ,to_char(ah.ACHIEVE_DATE ,'dd/mm/yyyy'),COMPONENT_NO,PERCENT_COMPLETED_WORK,MAJOR_MILESTONE_CODE,MILESTONE_SLNO,PERCENT_COMPLETED_WORK*100000 as amnt,nvl(PERCENT_COMPLETED*100000,0) as amntt1,ms_stage,decode(TYPE_OF_CONTRACTOR,'1','Civil','2','Electrical','3','Mechanical','4','Borewell','5','Spill Over') as TYPE_OF_CONTRACTOR,to_char(EOAT_DT,'dd/mm/yyyy') as EOAT_DT,COMPONENT_NO_ACH,decode(ms_stage,'1','Not Started','2','In Progress','3','Complted') as stagge,PERCENT_COMPLETED_WORK_VAL,PERCENT_COMPLETED_VAL"
					+ " from  RWS_MILESTONE_TARGET_ACH_TBL "
					+ "ah,rws_milestone_tbl mi,"
					+ " rws_milestone_stage_tbl smi where  "
					+ "ah.MILESTONE_CODE =mi.MILESTONE_CODE and ah.MILESTONE_CODE "
					+ "=smi.MILESTONE_CODE and ah.MILESTONE_STAGE_CODE=smi.MILESTONE_STAGE_CODE "
					+ "and ah.work_id=?  order by MAJOR_MILESTONE_CODE,MILESTONE_SLNO";
			ps = conn.prepareStatement(qry);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			while (rs.next()) {
				tenderMemo tm = new tenderMemo();
				tm.setWorkid(rs.getString("WORK_ID"));
				tm.setMileStoneSno(rs.getString("MILESTONE_SLNO"));
				tm.setMstoneName(rs.getString(1));
				tm.setMstoneStageName(rs.getString(2));
				tm.setTargetDate(rs.getString(3));
				tm.setPercentComp(rs.getString(4));
				tm.setWorkid(rs.getString(5));
				tm.setMstoneCode(rs.getString(6));
				tm.setMstoneStageCode(rs.getString(7));
				tm.setAchievementDate(rs.getString(8));
				tm.setPerCompInWorkValue(rs
						.getString("PERCENT_COMPLETED_WORK_VAL"));
				tm.setMajorMileStone(rs.getString("MAJOR_MILESTONE_CODE"));
				tm.setCompInNo(rs.getString("COMPONENT_NO"));
				tm.setPerCompInWork(rs.getString("PERCENT_COMPLETED_WORK"));
				tm.setPerCompValue(rs.getString("PERCENT_COMPLETED_VAL"));
				tm.setMileStoneProgress(rs.getString("ms_stage"));
				tm.setTypeOfContractor(rs.getString("TYPE_OF_CONTRACTOR"));
				tm.setEoatTargetDate(rs.getString("EOAT_DT"));
				tm.setCompInNoAch(rs.getString("COMPONENT_NO_ACH"));
				tm.setBudgetInfo(rs.getString("stagge"));
				if ((rs.getString(8) != null && !rs.getString(8).equals(""))
						|| (rs.getString(4) != null && !rs.getString(4).equals(
								"")))
					tm.setLabel("Y");
				else
					tm.setLabel("N");
				mileStrone.add(tm);
			}
		} catch (Exception e) {
			Debug.println("Exception in getProgramMileStones:" + e);
		}
		finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return mileStrone;
	}

	public boolean saveMileStonesForProg(DataSource ds, String mstone,
			String stage, String achDate, String workID, String perComp,
			String majorMileStone, String mileStoneSno, String pStage,
			String compNoAch, String perCompValue) throws Exception {
		boolean status = true;
		try {
			conn = RwsOffices.getConn();
			
			String qry = "Update RWS_MILESTONE_TARGET_ACH_TBL set ACHIEVE_DATE =to_date(?,'dd/mm/yyyy'),PERCENT_COMPLETED=?,ms_stage=?,COMPONENT_NO_ACH=?,PERCENT_COMPLETED_VAL=? where work_id=? and MILESTONE_CODE = ? and MAJOR_MILESTONE_CODE = ? and MILESTONE_STAGE_CODE =? and MILESTONE_SLNO = ?";
			
			ps = conn.prepareStatement(qry);
			ps.setString(1, achDate);
			ps.setString(2, perComp);
			ps.setString(3, pStage);
			ps.setString(4, compNoAch);
			ps.setString(5, perCompValue);
			ps.setString(6, workID);
			ps.setString(7, mstone);
			ps.setString(8, majorMileStone);
			ps.setString(9, stage);
			ps.setString(10, mileStoneSno);
			
			ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception saveMileStonesForProg:" + e);
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return status;
	}

	public boolean saveMileStonesForProg(DataSource ds,
			ArrayList programMileStones) throws Exception {
		boolean status = true;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			tenderMemo mileStoneBean = new tenderMemo();
			for (int i = 0; i < programMileStones.size(); i++) {
				mileStoneBean = (tenderMemo) programMileStones.get(i);
				Debug.println("1:" + mileStoneBean.getMajorMileStone());
				Debug.println("2:" + mileStoneBean.getAchievementDate());
				Debug.println("3:" + mileStoneBean.getPercentComp());
				/*
				 * String milestone = request.getParameter("WORK[" + i +
				 * "].mstoneCode"); String perComp =
				 * request.getParameter("WORK[" + i + "].percentComp"); String
				 * majorMileStone = request.getParameter("WORK[" + i +
				 * "].majorMileStone"); String mileStagestone =
				 * request.getParameter("WORK[" + i+ "].mstoneStageCode");
				 * String achDate = request.getParameter("WORK[" + i+
				 * "].achievementDate"); if(achDate!=null && !achDate.equals("")
				 * && perComp!=null && !perComp.equals("")) { String qry =
				 * "Update RWS_MILESTONE_TARGET_ACH_TBL set ACHIEVE_DATE =to_date('"
				 * +
				 * achDate+"','dd/mm/yyyy'),PERCENT_COMPLETED_WORK='"+perComp+"'"
				 * +" where work_id='"+workID+"' and MILESTONE_CODE = '"+
				 * majorMileStone+"'" +
				 * " and MILESTONE_STAGE_CODE ='"+stage+"'";
				 * Debug.println("Qry:"+qry); stmt.addBatch(qry); }
				 */
			}

			stmt.executeBatch();
			conn.commit();
		} catch (Exception e) {
			Debug.println("Exception saveMileStonesForProg:" + e);
		} finally {
			if (conn != null)
				conn.close();
		}
		return status;
	}

	public ArrayList getAdminProgramsExp(DataSource ds, String workId)
			throws Exception {
		ArrayList programms = null;
		try {
			String qry = "select distinct e.Programme_code pcode,p.programme_name as pname from "
					+ "RWS_WORK_EXPENDITURE_TBL e,rws_programme_tbl p where e.programme_code=p.programme_code"
					+ " and e.work_id='"
					+ workId
					+ "' "
					+ "and e.EXPENDITURE_UPTO_THE_PRE_YEAR is not null";
			Debug.println(qry);
			conn = RwsOffices.getConn();
			PreparedStatement psmt = conn.prepareStatement(qry);
			ResultSet rs = psmt.executeQuery();
			programms = new ArrayList();
			tenderMemo bean = null;
			while (rs.next()) {
				bean = new tenderMemo();
				bean.setProgCode(rs.getString(1));
				bean.setProgName(rs.getString(2));
				// bean.setExpUptoPrevYear(rs.getString(3));
				programms.add(bean);
			}

			Debug.println("Size of programs is " + programms.size());
		} catch (Exception e) {
			Debug.println("Exception in getAdminProgramsExp():" + e);
		} finally {
			releaseConnection();
		}

		return programms;
	}

	public ArrayList getAdminPrograms(DataSource ds, String workId)
			throws Exception {
		ArrayList programms = null;
		try {
			String qry = "select a.programme_code,programme_name from rws_work_admn_tbl a,rws_programme_tbl p"
					+ " where a.programme_code=p.programme_code and a.work_id=?";
			conn = RwsOffices.getConn();
			ps = conn.prepareStatement(qry);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			programms = new ArrayList();
			tenderMemo bean = null;
			while (rs.next()) {
				bean = new tenderMemo();
				bean.setWorkid(workId);
				bean.setProgCode(rs.getString(1));
				bean.setProgName(rs.getString(2));
				bean.setExpUptoPrevYear("");
				programms.add(bean);
			}
			qry = "select distinct a.programme_code,programme_name from RWS_WORK_ADMN_PROG_LNK_TBL a,rws_programme_tbl p"
					+ " where a.programme_code=p.programme_code and a.work_id=? and a.programme_code not in(select programme_code from rws_work_admn_tbl where work_id=?)";
			pstat = conn.prepareStatement(qry);
			pstat.setString(1, workId);
			pstat.setString(2, workId);
			ResultSet rs1 = pstat.executeQuery();
			while (rs1.next()) {
				bean = new tenderMemo();
				bean.setWorkid(workId);
				bean.setProgCode(rs1.getString(1));
				bean.setProgName(rs1.getString(2));
				bean.setExpUptoPrevYear("");
				programms.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}

		return programms;
	}

	public static double round(double d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = null;
		try {
			bd = new BigDecimal(Double.toString(d));
			bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		} catch (Exception e) {
			//e.printStackTrace();
		}
		return bd.doubleValue();
	}

	public static long round1(long d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = new BigDecimal(Long.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_EVEN);
		return bd.longValue();
	}

	public static double round(float d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = new BigDecimal(Double.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}

	public String getApprovedDetails(String workId, DataSource ds) {
		String approved = "";
		try {
			String qry = "select APPROVED_UNDER from rws_work_admn_tbl where work_id='"
					+ workId + "'";
			Debug.println(qry);
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(qry);
			if (rset.next()) {
				approved = rset.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return approved;
	}

	public String getEstAmount(String workId, DataSource ds) {
		String estCost = "";
		try {
			String qry = "select REV_SANCTION_AMOUNT  from RWS_REVISED_ADM_SANC_TBL where work_id='"
					+ workId + "'";
			Debug.println("rev:" + qry);
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(qry);
			if (rset.next()) {
				estCost = rset.getString(1);
			} else {
				String qry1 = "select SANCTION_AMOUNT  from rws_work_admn_tbl where work_id='"
						+ workId + "'";
				Debug.println("admin:" + qry1);
				Statement stmt1 = conn.createStatement();
				ResultSet rset1 = stmt1.executeQuery(qry1);
				if (rset1.next()) {
					estCost = rset1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return estCost;
	}

	public rws_ddws_form getDdwsDetails(String workId, DataSource ds) {

		rws_ddws_form bean = new rws_ddws_form();
		try {
			String qry = "select * from rws_ddws_work_fields_tbl where work_id='"
					+ workId + "'";
			Debug.println(qry);
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(qry);
			if (rset.next()) {
				bean.setGoi(rset.getString(2));
				bean.setState(rset.getString(3));
				bean.setComm(rset.getString(4));
			} else {
				bean.setGoi("0");
				bean.setState("0");
				bean.setComm("0");
			}
		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return bean;
	}

	public ArrayList getwqListDetails(String workId, DataSource ds) {

		ArrayList wqlist = new ArrayList();
		try {
			String qry = "select * from RWS_DDWS_SUBMISSION_WQ_TBL where work_id='"
					+ workId + "'";
			Debug.println(qry);
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(qry);
			if (rset.next()) {
				for (int i = 2, j = 0; i <= 19; i++, j++) {
					wqlist.add(j, rset.getString(i));
				}
			}

		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return wqlist;
	}

	public int insertDdwsSubWqDetails(rws_ddws_form fb, DataSource ds,
			String[] phy, String[] che, String[] bac, String[] oth) {
		int rvalue = -1;
		int rValue = -1;
		try {
			Debug.println("in insert ddws details");
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String checkQuery = "select * from RWS_DDWS_SUBMISSION_WQ_TBL where work_id='"
					+ fb.getWorkId() + "'";
			Statement checkStmt = conn.createStatement();
			ResultSet checkRs = checkStmt.executeQuery(checkQuery);
			if (!checkRs.next()) {
				String query = "insert into RWS_DDWS_SUBMISSION_WQ_TBL values('"
						+ fb.getWorkId() + "'";
				String checkBox = "";
				if (phy != null && phy.length != 0 && !phy[0].equals("")) {
					checkBox += ",'Y'";
				} else {
					checkBox += ",'N'";
				}
				Debug.println("Physical Completed:" + checkBox);
				Collection c = new ArrayList();
				if (che == null) {
					Debug.println("in che null");
					for (int h = 0; h < 15; h++) {
						Debug.println("" + h);
						checkBox += ",'N'";
					}
				} else {
					for (int h = 0; h < che.length; h++) {
						c.add(che[h]);
					}
					if (c.contains("Arsenic")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Fluoride")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Iron")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Chloride")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Nitrate")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Sulphates")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Calcium")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Magnesium")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Manganese")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Copper")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Salinity")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("TDS")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Hardness")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Residual Chlorine")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
					if (c.contains("Alkalinity")) {
						checkBox += ",'Y'";
					} else {
						checkBox += ",'N'";
					}
				}
				Debug.println("Chemical Completed:" + checkBox);
				if (bac != null && bac.length != 0 && !bac[0].equals("")) {
					checkBox += ",'Y'";
				} else {
					checkBox += ",'N'";
				}
				Debug.println("bac Completed:" + checkBox);
				if (oth != null && oth.length != 0 && !oth[0].equals("")) {
					checkBox += ",'Y'";
				} else {
					checkBox += ",'N'";
				}
				Debug.println("Check Box Query:" + checkBox);
				query += checkBox + ",'" + fb.getMethod() + "')";
				Debug.println("Final Insert Query:" + query);
				/*
				 * Stringqry=
				 * "select APPROVED_UNDER from rws_work_admn_tbl where work_id='"
				 * +fb.getWorkId()+"'"; Debug.println(qry);
				 */
				conn = RwsOffices.getConn();
				Statement stmt = conn.createStatement();
				rvalue = stmt.executeUpdate(query);
			} else {
				String query = "update RWS_DDWS_SUBMISSION_WQ_TBL set Methodology='"
						+ fb.getMethod() + "'";
				String checkBox = "";
				if (phy != null && phy.length != 0 && !phy[0].equals("")) {
					checkBox += ",Turbidity='Y'";
				} else {
					checkBox += ",Turbidity='N'";
				}
				Debug.println("Physical Completed:" + checkBox);
				Collection c = new ArrayList();
				if (che == null) {
					Debug.println("in che null");
					checkBox += ",Arsenic='N'";
					checkBox += ",Fluoride='N'";
					checkBox += ",Iron='N'";
					checkBox += ",Chloride='N'";
					checkBox += ",Nitrate='N'";
					checkBox += ",Sulphates='N'";
					checkBox += ",Calcium='N'";
					checkBox += ",Magnesium='N'";
					checkBox += ",Manganese='N'";
					checkBox += ",Copper='N'";
					checkBox += ",Salinity='N'";
					checkBox += ",TDS='N'";
					checkBox += ",Hardness='N'";
					checkBox += ",RESI_CHLORINE='N'";
					checkBox += ",Alkalinity='N'";
				} else {
					for (int h = 0; h < che.length; h++) {
						c.add(che[h]);
					}
					if (c.contains("Arsenic")) {
						checkBox += ",Arsenic='Y'";
					} else {
						checkBox += ",Arsenic='N'";
					}
					if (c.contains("Fluoride")) {
						checkBox += ",Fluoride='Y'";
					} else {
						checkBox += ",Fluoride='N'";
					}
					if (c.contains("Iron")) {
						checkBox += ",Iron='Y'";
					} else {
						checkBox += ",Iron='N'";
					}
					if (c.contains("Chloride")) {
						checkBox += ",Chloride='Y'";
					} else {
						checkBox += ",Chloride='N'";
					}
					if (c.contains("Nitrate")) {
						checkBox += ",Nitrate='Y'";
					} else {
						checkBox += ",Nitrate='N'";
					}
					if (c.contains("Sulphates")) {
						checkBox += ",Sulphates='Y'";
					} else {
						checkBox += ",Sulphates='N'";
					}
					if (c.contains("Calcium")) {
						checkBox += ",Calcium='Y'";
					} else {
						checkBox += ",Calcium='N'";
					}
					if (c.contains("Magnesium")) {
						checkBox += ",Magnesium='Y'";
					} else {
						checkBox += ",Magnesium='N'";
					}
					if (c.contains("Manganese")) {
						checkBox += ",Manganese='Y'";
					} else {
						checkBox += ",Manganese='N'";
					}
					if (c.contains("Copper")) {
						checkBox += ",Copper='Y'";
					} else {
						checkBox += ",Copper='N'";
					}
					if (c.contains("Salinity")) {
						checkBox += ",Salinity='Y'";
					} else {
						checkBox += ",Salinity='N'";
					}
					if (c.contains("TDS")) {
						checkBox += ",TDS='Y'";
					} else {
						checkBox += ",TDS='N'";
					}
					if (c.contains("Hardness")) {
						checkBox += ",Hardness='Y'";
					} else {
						checkBox += ",Hardness='N'";
					}
					if (c.contains("Residual Chlorine")) {
						checkBox += ",RESI_CHLORINE='Y'";
					} else {
						checkBox += ",RESI_CHLORINE='N'";
					}
					if (c.contains("Alkalinity")) {
						checkBox += ",Alkalinity='Y'";
					} else {
						checkBox += ",Alkalinity='N'";
					}
				}
				Debug.println("Chemical Completed:" + checkBox);
				if (bac != null && bac.length != 0 && !bac[0].equals("")) {
					checkBox += ",FAECAL_COLIFORM='Y'";
				} else {
					checkBox += ",FAECAL_COLIFORM='N'";
				}
				Debug.println("bac Completed:" + checkBox);
				if (oth != null && oth.length != 0 && !oth[0].equals("")) {
					checkBox += ",ph='Y'";
				} else {
					checkBox += ",ph='N'";
				}
				Debug.println("Check Box Query:" + checkBox);
				query += checkBox + " where work_id='" + fb.getWorkId() + "'";
				Debug.println("Final Update Query:" + query);
				/*
				 * Stringqry=
				 * "select APPROVED_UNDER from rws_work_admn_tbl where work_id='"
				 * +fb.getWorkId()+"'"; Debug.println(qry);
				 */
				conn = RwsOffices.getConn();
				Statement stmt = conn.createStatement();
				rvalue = stmt.executeUpdate(query);

			}
			Debug.println("Inserted:" + rvalue);

			int dValue = -1;
			String checkDdws = "select * from rws_ddws_work_fields_tbl where work_id='"
					+ fb.getWorkId() + "'";
			Statement ss = conn.createStatement();
			ResultSet rr = ss.executeQuery(checkDdws);
			if (!rr.next()) {
				String qrry = "insert into rws_ddws_work_fields_tbl(WORK_ID,GOICOST,STATECOST,COMMCONT,AGENCY_CODE,PRIVATE_SOURCE,SOURCE_TYPE,SUBSOURCE_TYPE,SOURCE_LOCATION,SCHEME_APPROVED_UNDER,DATE_OF_COMP_ACTION_PLAN,DDWS_SCHEME) values('"
						+ fb.getWorkId()
						+ "','"
						+ fb.getGoi()
						+ "','"
						+ fb.getState()
						+ "','"
						+ fb.getComm()
						+ "','001','','','','','','','')";
				Debug.println("DDWS table entry:" + qrry);
				Statement ddwsSt = conn.createStatement();
				dValue = ddwsSt.executeUpdate(qrry);
			} else {
				String qrry = "update rws_ddws_work_fields_tbl set "
						+ "GOICOST='"
						+ fb.getGoi()
						+ "',STATECOST='"
						+ fb.getState()
						+ "',COMMCONT='"
						+ fb.getComm()
						+ "',AGENCY_CODE='001',PRIVATE_SOURCE='',SOURCE_TYPE='',SUBSOURCE_TYPE='',SOURCE_LOCATION='',SCHEME_APPROVED_UNDER='',DATE_OF_COMP_ACTION_PLAN='',DDWS_SCHEME='' where WORK_ID='"
						+ fb.getWorkId() + "'";
				Debug.println("DDWS table update:" + qrry);
				Statement ddwsSt = conn.createStatement();
				dValue = ddwsSt.executeUpdate(qrry);
			}
			String proove = "update rws_work_admn_tbl set approved_under='"
					+ fb.getProoved() + "' where work_id='" + fb.getWorkId()
					+ "'";
			Debug.println("update aprooved query:" + proove);
			Statement prst = conn.createStatement();
			int insert = prst.executeUpdate(proove);
			if (rvalue > 0 && dValue > 0) {
				rValue = 1;
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				rValue = -1;
				conn.rollback();
			}

		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return rValue;
	}

	public int insertDdwsNormalWqDetails(rws_ddws_form fb, DataSource ds) {
		int rvalue = -1;
		int rValue = -1;
		try {
			Debug.println("in insert ddws details");
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			int dValue = -1;
			String checkDdws = "select * from rws_ddws_work_fields_tbl where work_id='"
					+ fb.getWorkId() + "'";
			Statement ss = conn.createStatement();
			ResultSet rr = ss.executeQuery(checkDdws);
			int insert = -1;
			if (!rr.next()) {
				String qrry = "insert into rws_ddws_work_fields_tbl(WORK_ID,GOICOST,STATECOST,COMMCONT,AGENCY_CODE,PRIVATE_SOURCE,SOURCE_TYPE,SUBSOURCE_TYPE,SOURCE_LOCATION,SCHEME_APPROVED_UNDER,DATE_OF_COMP_ACTION_PLAN,DDWS_SCHEME,UPDATE_DATE) values('"
						+ fb.getWorkId()
						+ "','"
						+ fb.getGoi()
						+ "','"
						+ fb.getState()
						+ "','"
						+ fb.getComm()
						+ "','001','','','','','','','',SYSDATE)";
				Debug.println("DDWS table entry:" + qrry);
				Statement ddwsSt = conn.createStatement();
				dValue = ddwsSt.executeUpdate(qrry);
				String proove = "update rws_work_admn_tbl set approved_under='"
						+ fb.getProoved() + "' where work_id='"
						+ fb.getWorkId() + "'";
				Statement prst = conn.createStatement();
				insert = prst.executeUpdate(proove);
			} else {
				String qrry = "update rws_ddws_work_fields_tbl set GOICOST='"
						+ fb.getGoi()
						+ "',STATECOST='"
						+ fb.getState()
						+ "',COMMCONT='"
						+ fb.getComm()
						+ "',AGENCY_CODE='001',PRIVATE_SOURCE='',SOURCE_TYPE='',SUBSOURCE_TYPE='',SOURCE_LOCATION='',SCHEME_APPROVED_UNDER='',DATE_OF_COMP_ACTION_PLAN='',DDWS_SCHEME='',UPDATE_DATE=SYSDATE where WORK_ID='"
						+ fb.getWorkId() + "'";
				Debug.println("DDWS table update:" + qrry);
				Statement ddwsSt = conn.createStatement();
				dValue = ddwsSt.executeUpdate(qrry);
				String proove = "update rws_work_admn_tbl set approved_under='"
						+ fb.getProoved() + "' where work_id='"
						+ fb.getWorkId() + "'";
				Statement prst = conn.createStatement();
				insert = prst.executeUpdate(proove);
				String qy = "delete from RWS_DDWS_SUBMISSION_WQ_TBL where work_id='"
						+ fb.getWorkId() + "'";
				Statement delst = conn.createStatement();
				delst.executeUpdate(qy);
			}

			if (insert > 0 && dValue > 0) {
				rValue = 1;
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				rValue = -1;
				conn.rollback();
			}

		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
		} finally {
			releaseConnection();
		}
		return rValue;
	}

	public ArrayList getEmployees(String dcode, int start, int end) {

		ArrayList employees = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT EMPLOYEE_CODE,EMPLOYEE_SURNAME||'.'||EMPLOYEE_NAME,designation_acr FROM rws_employee_tbl a,rws_designation_tbl b where a.designation_code=b.designation_code "
					+ " and (a.DESIGNATION_CODE>=? and a.DESIGNATION_CODE<=?) ";
			if (dcode != null && !dcode.equals("all")) {
				query += " and substr(a.office_code,2,2)=? ";
			}
				query += "ORDER BY a.DESIGNATION_CODE";

			ps = conn.prepareStatement(query);
			ps.setInt(1, start);
			ps.setInt(2, end);
			if (dcode != null && !dcode.equals("all")) {
				ps.setString(3, dcode);
			}
			rset = ps.executeQuery();
			LabelValueBean bean = null;
			while (rset.next()) {
				bean = new LabelValueBean();
				bean.setValue(rset.getString(1));
				bean.setLabel(rset.getString(3) + " - " + rset.getString(1)
						+ " - " + rset.getString(2));
				employees.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getEmployees():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return employees;

	}

	public ArrayList getContractors(String workId) {

		ArrayList conts = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT a.contractor_code,contractor_name_company FROM rws_contractor_tbl a,rws_contractor_selection_tbl b "
					+ " where a.contractor_code=b.contractor_code and b.work_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			LabelValueBean bean = null;
			while (rset.next()) {
				bean = new LabelValueBean();
				bean.setValue(rset.getString(1));
				bean.setLabel(rset.getString(2));
				conts.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getContractors():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return conts;

	}

	public ArrayList getAllBills(String workId) {

		ArrayList conts = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT BILL_SL_NO,BILL_NO  FROM rws_work_bill_tbl where work_id=? order by 1";
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			LabelValueBean bean = null;
			while (rset.next()) {
				bean = new LabelValueBean();
				bean.setValue(rset.getString(1));
				bean.setLabel(rset.getString(2));
				conts.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getAllBills():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return conts;

	}

	public ArrayList getVouchers(String workId) {
		ArrayList vouchers = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT recorded_by,to_char(recorded_date,'dd/mm/yyyy'),check_measured_by,to_char(check_measure_dt,'dd/mm/yyyy'),voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt,cheque_no,to_char(cheque_dt,'dd/mm/yyyy'),SUPER_CHECK_MEASURED_BY,to_char(SUPER_CHECK_MEASURE_DT,'dd/mm/yyyy'),REMARKS,PROGRAMME_CODE,nvl(MBOOK_NO,'') as MBOOK_NO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO,payment_mode,nvl(PAO_ADMISSABLE,0) as paoAmount,to_char(ee_approved_date ,'dd/mm/yyyy') as eeDate from RWS_WORK_EXP_VOUCHER_TBL "
					+ "where work_id=? ORDER BY RECORDED_DATE";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			tenderMemo tenderMemoBean = null;
			while (rset.next()) {
				tenderMemoBean = new tenderMemo();
				tenderMemoBean.setProgCode(rset.getString("PROGRAMME_CODE"));
				tenderMemoBean.setSno(rset.getString("MBOOK_NO"));
				tenderMemoBean.setEmpCodeRecorded(rset.getString(1));
				tenderMemoBean.setRecordedDate(rset.getString(2));
				tenderMemoBean.setEmpCode(rset.getString(3));
				tenderMemoBean.setCheckMesuaredDate(rset.getString(4));
				tenderMemoBean.setVoucherNo(rset.getString(5));
				tenderMemoBean.setVoucherDate(rset.getString(6));
				tenderMemoBean.setVoucherAmount(rset.getString(7));
				tenderMemoBean.setChequeNo(rset.getString(8));
				tenderMemoBean.setChequeDate(rset.getString(9));
				tenderMemoBean.setEmpCodeSuper(rset.getString(10));
				tenderMemoBean.setSuperCheckMesuaredDate(rset.getString(11));
				tenderMemoBean.setCheckMesuaredRemarks(rset.getString(12));
				tenderMemoBean.setContCode(rset.getString("CONTRACTOR_CODE"));
				tenderMemoBean.setBudgetInfo(rset.getString("GRANT_DISTRIB"));
				tenderMemoBean.setBillSlNo(rset.getString("BILL_SL_NO"));

				tenderMemoBean.setPaoAdmissable(rset.getString("paoAmount"));
				tenderMemoBean
						.setIsApproved(rset.getString("eeDate") != null ? "A"
								: "NA");

				tenderMemoBean.setApprovedOn(rset.getString("eeDate"));

				String amt = getBillVoucherAmount(workId,
						rset.getString("BILL_SL_NO"));

				String[] amts = amt.split("/");

				tenderMemoBean.setPaymentAdmissable(amts[0]);
				tenderMemoBean.setBillVoucherAmount(amts[1]);
				tenderMemoBean.setPaymentMode(rset.getString("payment_mode"));
				vouchers.add(tenderMemoBean);
			}
		} catch (Exception e) {//e.printStackTrace();
			Debug.println("Exception in getVouchers():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return vouchers;

	}

	public ArrayList getBills(String workId, ActionServlet actionServlet) {
		ArrayList vouchers = new ArrayList();
		PreparedStatement pstmt=null;
		ResultSet  resultSet=null;
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT BILL_SL_NO,BILL_NO,to_char(bill_date,'dd/mm/yyyy'),BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,to_char(EE_FWD_DATE,'dd/mm/yyyy') as eeDate, CM_BY_DEE,CM_MBOOK_PG_NO,to_char(CM_DT,'dd/mm/yyyy'),SCM_BY_EE ,SCM_MBOOK_PG_NO,to_char(SCM_DT,'dd/mm/yyyy'),SCM_BY_SE,SCM_SE_MBOOK_PG_NO,to_char(SCM_SE_DT,'dd/mm/yyyy'),length(PASS_ORDER_SCAN_COPY) as pCopy,nvl(bms_tr_no,'0') as bmstrno,nvl(to_char(bms_tr_date,'dd/mm/yyyy'),'') as bmstrdate  "
					+ "from RWS_WORK_BILL_TBL where work_id=? ORDER BY 1";
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, workId);
			rset = pstmt.executeQuery();
			tenderMemo tenderMemoBean = null;
			String total = "0";
			while (rset.next()) {
				tenderMemoBean = new tenderMemo();

				tenderMemoBean.setBillSlNo(rset.getString(1));
				tenderMemoBean.setBillNo(rset.getString(2));
				tenderMemoBean.setBillDate(rset.getString(3));
				tenderMemoBean.setBillDateEE(rset.getString("eeDate"));
				tenderMemoBean.setGrossValueContractor(rset.getString(4));
				tenderMemoBean.setGrossValueAdmissable(rset.getString(5));
				tenderMemoBean.setEmpCode(rset.getString(7));
				tenderMemoBean.setCmMBookNo(rset.getString(8));
				tenderMemoBean.setCheckMesuaredDate(rset.getString(9));
				tenderMemoBean.setEmpCodeSuper(rset.getString(10));
				tenderMemoBean.setScmMBookNo(rset.getString(11));
				tenderMemoBean.setSuperCheckMesuaredDate(rset.getString(12));
				tenderMemoBean.setSuperCheckBySE(rset.getString(13));
				tenderMemoBean.setSuperCheckPgNo(rset.getString(14));
				tenderMemoBean.setSuperCheckSEDate(rset.getString(15));

				tenderMemoBean.setBmsTranSanctionNo(rset.getString("bmstrno"));
				tenderMemoBean.setBmsTransactionDate(rset
						.getString("bmstrdate"));

				tenderMemoBean.setBillSaved("yes");

				/*if (rset.getString("pCopy") != null
						&& !rset.getString("pCopy").equals("null")) {
					tenderMemoBean.setPassOrderScanCopyAvailable("A");
				} else {
					tenderMemoBean.setPassOrderScanCopyAvailable("NA");
				}*/
				//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
				String imagePath=actionServlet.getServletContext().getRealPath("/") ;
				 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
					 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
					 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }else{
					 String sample[]  = imagePath.split( "webapps");
					// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }
				 imagePath = imagePath+ File.separator+"PassorderScanCopys";
				File myFilesDir = new File(imagePath);
				if (!myFilesDir.exists())
					myFilesDir.mkdirs();
				imagePath = imagePath + File.separator ;
				File filepath = new File(imagePath);
				//pstmt.setString(15, workId);
				//pstmt.setString(16,tenderMemoBean.getBillSlNo());
				String billdates=tenderMemoBean.getBillDate().replace("/", "-");
				File filepathisExits = new File(filepath+File.separator+workId+"_"+billdates+"_"+tenderMemoBean.getBillSlNo()+".jpg");
				if(filepathisExits.getAbsoluteFile().exists()){
					tenderMemoBean.setPassOrderScanCopyAvailable("A");
				}
				else
				{
					tenderMemoBean.setPassOrderScanCopyAvailable("NA");
				}

				tenderMemoBean.setGrossValueOfBill(""
						+ (rset.getDouble(5) - (Double.parseDouble(total))));
				String stat123 = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id=? and BILL_SL_NO =?";
				pstmt = conn.prepareStatement(stat123);
				pstmt.setString(1, workId);
				pstmt.setString(2, rset.getString(1));
				resultSet = pstmt.executeQuery();
				if (resultSet.next())
					tenderMemoBean.setBillVoucherAmount(resultSet.getString(1));// ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
				else
					tenderMemoBean.setBillVoucherAmount("0");
				String stat1234 = "select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')a,"
								+ "(select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')b from dual";
				resultSet.close();
				
				pstmt = conn.prepareStatement(stat1234);
				pstmt.setString(1, workId);
				pstmt.setString(2, rset.getString(1));
				pstmt.setString(3, workId);
				pstmt.setString(4, rset.getString(1));
				resultSet = pstmt.executeQuery();
				if (resultSet.next()) {

					tenderMemoBean.setBillReleaseAmount(""
							+ (resultSet.getLong(1) + resultSet.getLong(2)));// ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
					if (tenderMemoBean.getBillReleaseAmount() != null
							&& !tenderMemoBean.getBillReleaseAmount().equals(
									"0")) {
						tenderMemoBean.setBillSaved("rel");
					}
				} else
					tenderMemoBean.setBillReleaseAmount("0");
				resultSet.close();
				vouchers.add(tenderMemoBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getBills():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return vouchers;

	}

	public String getNewBillAmount(String workId, String billslno) {
		String billAmount = "";
		try {
			conn = RwsOffices.getConn();
			
			if (billslno != null && billslno.equals("0"))
				query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id=? and TYPE_OF_CONTRACTOR = '5')a,"
						+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no='0')b from dual";
			else if (billslno != null && Integer.parseInt(billslno) < 0)
				query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id=? and TYPE_OF_CONTRACTOR <> '5')a,"
						+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no<>'0')b,"
						+ "(select nvl(sum(BILL_AMT_CONTRACTOR),0)-nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no>0)c,"
						+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no<0)d  from dual";
			else {
				query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id=? and TYPE_OF_CONTRACTOR <> '5')a,"
						+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no>0)b,"
						+ "(select nvl(sum(BILL_AMT_contractor),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and work_id=? and bill_sl_no>0)c,"
						+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0)-nvl(sum(BILL_AMT_CONTRACTOR),0) from rws_work_bill_TBL where (bill_type='B' or bill_type is null) and  work_id=? and bill_sl_no>0)d from dual";

			}
			ps = conn.prepareStatement(query);
			if (billslno != null && billslno.equals("0")){
				ps.setString(1, workId);
				ps.setString(2, workId);
			}else{
				ps.setString(1, workId);
				ps.setString(2, workId);
				ps.setString(3, workId);
				ps.setString(4, workId);
			}
			
			rset = ps.executeQuery();
			tenderMemo tenderMemoBean = null;
			String total = "0";
			if (rset.next()) {
				long achAmount = rset.getLong(1);
				long billAmt = rset.getLong(2);
				if (billslno != null && Integer.parseInt(billslno) < 0)
					billAmount = "" + (rset.getLong(3) - rset.getLong(4));
				else if (billslno != null && billslno.equals("0"))
					billAmount = "" + (achAmount - billAmt);
				else {
					if (rset.getInt(4) > 0)
						billAmount = "" + (achAmount - billAmt);
					else
						billAmount = "" + (achAmount - rset.getLong(3));
				}

			}
		} catch (Exception e) {
			Debug.println("Exception in getNewBillAmount():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return billAmount;

	}

	public String getSpillOverAmount(String workId, String billslno) {
		String billAmount = "";
		
		try {
			conn = RwsOffices.getConn();
			
			query = "select (select nvl(sum(PERCENT_COMPLETED_VAL),0) from rws_MILESTONE_TARGET_ACH_TBL where work_id=? and TYPE_OF_CONTRACTOR = '5')a,"
					+ "(select nvl(sum(BILL_AMT_ADMISSIBLE),0) from rws_work_bill_TBL where work_id=? and bill_sl_no='0')b from dual";

			ps = conn.prepareStatement(query);
			ps.setString(1, workId);
			ps.setString(2, workId);
			rset = ps.executeQuery();
			tenderMemo tenderMemoBean = null;
			String total = "0";
			if (rset.next()) {
				long achAmount = rset.getLong(1);
				long billAmt = rset.getLong(2);
				billAmount = "" + (achAmount - billAmt);
			}
		} catch (Exception e) {
			Debug.println("Exception in getSpillOverAmount():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return billAmount;

	}

	public int getNewVoucherAmount(String workId) {
		int flag = 0;
		try {
			conn = RwsOffices.getConn();
			
			String q1 = "select * from rws_work_bill_tbl where work_id=? and bill_sl_no='0'";

			ps = conn.prepareStatement(q1);
			ps.setString(1, workId);
			ResultSet rs1 = ps.executeQuery();
			if (rs1.next()) {
				query = "select * from rws_work_exp_voucher_tbl where work_id=? and bill_sl_no='0'";
				pstat = conn.prepareStatement(query);
				pstat.setString(1, workId);
				rset = pstat.executeQuery();
				tenderMemo tenderMemoBean = null;
				String total = "0";
				if (rset.next()) {
					flag = 2;
				} else
					flag = 1;
			}
		} catch (Exception e) {
			Debug.println("Exception in getNewVoucherAmount():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (pstat != null)
					pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		Debug.println(":" + flag);
		return flag;

	}

	public int getNewVoucherAmount1(String workId) {
		int flag = 0;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String q1 = "select * from rws_work_bill_tbl where work_id='"
					+ workId + "' and bill_sl_no='0'";
			Debug.println("qry in get getNewBillAmount:" + q1);
			Statement stmt1 = conn.createStatement();
			ResultSet rs1 = stmt1.executeQuery(q1);
			if (rs1.next()) {
				flag = 1;
			}
		} catch (Exception e) {
			Debug.println("Exception in getNewBillAmount():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return flag;

	}

	public String getBillVoucherAmount(String workId, String bill) {
		DecimalFormat ndf = new DecimalFormat("####.00");
		String returnValue = "";
		ResultSet rsqq = null;

		try {
			conn = RwsOffices.getConn();
			String getAmount = "";

			if (bill.equals("0")) {
				getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_bill_tbl where work_id=? and BILL_SL_NO =? ";
				ps=conn.prepareStatement(getAmount);
				ps.setString(1, workId);
				ps.setString(2, bill);
				ResultSet gmrs1 = ps.executeQuery();
				if (gmrs1.next()) {
					returnValue = gmrs1.getString(1);
				} else {
					returnValue = "0";
				}
			} else {
				getAmount = "select (select nvl(sum(BILL_AMOUNT_CENTRAL),0)  from rws_bill_bank_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')a,"
						+ "(select nvl(sum(BILL_AMOUT_state),0)  from rws_bill_pao_bridge_det_tbl where work_id=? and BILL_SL_NO =? and BILL_ACTIVATION_FLAG='P')b from dual";

				ps=conn.prepareStatement(getAmount);
				ps.setString(1, workId);
				ps.setString(2, bill);
				ps.setString(3, workId);
				ps.setString(4, bill);
				ResultSet gmrs1 = ps.executeQuery();
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

			String stat123 = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id=? and BILL_SL_NO =? ";
			ps=conn.prepareStatement(stat123);
			ps.setString(1, workId);
			ps.setString(2, bill);
			
			rsqq = ps.executeQuery();
			if (rsqq.next()) {
				returnValue += "" + rsqq.getString(1);
			} else {
				returnValue += "0";
			}
		} catch (Exception e) {//e.printStackTrace();
			System.out.println("EXCEPTION IN getting Connection"
					+ e.getMessage());
		} finally {
			try {
				
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;
	}

	public String getBillAmount(String workId) {
		ResultSet rs = null;
		String returnValue = "0";
		try {
			conn = RwsOffices.getConn();
			String getAmount = "";

			getAmount = "select nvl(sum(BILL_AMT_ADMISSIBLE),0)  from rws_WORK_bill_tbl where (bill_type='B' or bill_type is null) and work_id=?";
			ps=conn.prepareStatement(getAmount);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			long val1 = 0;
			if (rs.next()) {
				if (rs.getString(1) != null
						&& !rs.getString(1).equals(""))
					returnValue = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("EXCEPTION IN getBillAmount"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;
	}

	public String getBillAmountCon(String workId) {
		ResultSet rs123 = null;
		String returnValue = "0";
		try {
			conn = RwsOffices.getConn();
			String getAmount = "";

			getAmount = "select nvl(sum(BILL_AMT_Contractor),0)  from rws_WORK_bill_tbl where (bill_type='B' or bill_type is null) and  work_id=? and bill_sl_no>='0'";
			ps=conn.prepareStatement(getAmount);
			ps.setString(1, workId);
			rs = ps.executeQuery();
			long val1 = 0;
			if (rs.next()) {
				if (rs.getString(1) != null
						&& !rs.getString(1).equals(""))
					returnValue = rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("EXCEPTION IN getBillAmountCon"
					+ e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;
	}

	public String getServerDate() {
		String serverDate = "";
		try {
			conn = RwsOffices.getConn();
			query = "select to_char(sysdate,'dd/mm/yyyy') from dual ";
			PreparedStatement stmt = conn.prepareStatement(query);
			rset = stmt.executeQuery();
			tenderMemo tenderMemoBean = null;
			String total = "0";
			if (rset.next()) {
				serverDate = rset.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in WorksData1 getServerDate() : " + e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				System.out.println("The Exception is in WorksData1 getServerDate Closing Connection : "+ e.getMessage());
			}
		}
		return serverDate;
	}

	
	
	public String saveBills(ArrayList vouchers, String workId,
			Collection removes, ActionServlet actionServlet) {
		String returnValue = "Failed to Save/Update Voucher(s)";
		boolean ff = false;
		PreparedStatement pstmt = null,pstmt2=null;
		Statement stmt3 =null;
		try {
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;
			String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
			if(!mimeType.equalsIgnoreCase("image/jpeg"))
			{
				returnValue="Allowed only jpg file extensions only.";
				return returnValue;
			}
			String targetPath = actionServlet.getServletContext().getRealPath(
					"")
					+ File.separator + "temp.jpg";

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt3 = conn.createStatement();

			
			if (!checkSourceIsExists(workId)) {

				returnValue = "Source is Not Linked with this Scheme.Please Add/Remove Source in WorksMonitoring->Work Progress Form->Source Identification";
				return returnValue;
			}
			if (!checkHabitaionIsExixts(workId)) {
				returnValue = "Habitation Is Not Linked With this Scheme.Please Add/Remove Habitaions in WorksMonitoring->Work Hab Link Form.";
				return returnValue;
			}
			Statement stmt22 = conn.createStatement();
			String qqq = "select BILL_SL_NO  from rws_bill_bank_bridge_tbl where work_id=?";
			pstmt2=conn.prepareStatement(qqq);
			pstmt2.setString(1, workId);
			ResultSet rs2 = pstmt2.executeQuery();
			Collection c = new ArrayList();
			while (rs2.next()) {
				c.add(rs2.getString(1));
			}
			for (int j = 0; j < vouchers.size(); j++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(j);
				String sno = tenderMemoBean.getMileStoneSno();
				if (removes.contains(tenderMemoBean.getBillSlNo())
						&& !c.contains(tenderMemoBean.getBillSlNo())) {
					String qq = "select * from rws_work_bill_tbl where work_id=? and bill_sl_no=?";
					pstmt2=conn.prepareStatement(qq);
					pstmt2.setString(1, workId);
					pstmt2.setString(2, tenderMemoBean.getBillSlNo());
					ResultSet rrt = pstmt2.executeQuery();
					if (rrt.next()) {
						if (Integer.parseInt(tenderMemoBean
								.getGrossValueContractor()) >= Integer
								.parseInt(tenderMemoBean
										.getGrossValueAdmissable())) {

							
                     
							

							formFile = tenderMemoBean.getPassOrderScanCopy();

							//if (formFile != null) {
								query = "update rws_work_bill_tbl set BILL_AMT_ADMISSIBLE=?,BILL_AMT_CONTRACTOR=?,ee_fwd_date=to_date(?,'dd/mm/yy'),CM_BY_DEE=?,CM_MBOOK_PG_NO=?,CM_DT=to_date(?,'dd/mm/yy'),SCM_BY_EE=?,SCM_MBOOK_PG_NO=?,SCM_DT=to_date(?,'dd/mm/yy'),SCM_BY_SE=?,SCM_SE_MBOOK_PG_NO=?,SCM_SE_DT=to_date(?,'dd/mm/yy'),BMS_TR_NO=?,BMS_TR_DATE=to_date(?,'dd/mm/yy') where work_id=? and bill_sl_no=?";
							//	query = "update rws_work_bill_tbl set BILL_AMT_ADMISSIBLE=?,BILL_AMT_CONTRACTOR=?,ee_fwd_date=to_date(?,'dd/mm/yy'),CM_BY_DEE=?,CM_MBOOK_PG_NO=?,CM_DT=to_date(?,'dd/mm/yy'),SCM_BY_EE=?,SCM_MBOOK_PG_NO=?,SCM_DT=to_date(?,'dd/mm/yy'),SCM_BY_SE=?,SCM_SE_MBOOK_PG_NO=?,SCM_SE_DT=to_date(?,'dd/mm/yy'),BMS_TR_NO=?,BMS_TR_DATE=to_date(?,'dd/mm/yy'),PASS_ORDER_SCAN_COPY=? where work_id=? and bill_sl_no=?";

							//} 
						/*else {
								if (lenValue == null) {
									returnValue = "Pass Order Scan Copy File Size Shoud Be Mandatory.";
									conn.setAutoCommit(true);
									return returnValue;
								} else {
									query = "update rws_work_bill_tbl set BILL_AMT_ADMISSIBLE=?,BILL_AMT_CONTRACTOR=?,ee_fwd_date=to_date(?,'dd/mm/yy'),CM_BY_DEE=?,CM_MBOOK_PG_NO=?,CM_DT=to_date(?,'dd/mm/yy'),SCM_BY_EE=?,SCM_MBOOK_PG_NO=?,SCM_DT=to_date(?,'dd/mm/yy'),SCM_BY_SE=?,SCM_SE_MBOOK_PG_NO=?,SCM_SE_DT=to_date(?,'dd/mm/yy'),BMS_TR_NO=?,BMS_TR_DATE=to_date(?,'dd/mm/yy') where work_id=? and bill_sl_no=?";
								}
							}*/

							
							pstmt = conn.prepareStatement(query);
							pstmt.setString(1,
									tenderMemoBean.getGrossValueAdmissable());
							pstmt.setString(2,
									tenderMemoBean.getGrossValueContractor());
							pstmt.setString(3, tenderMemoBean.getBillDateEE());
							pstmt.setString(4, tenderMemoBean.getEmpCode());
							pstmt.setString(5, tenderMemoBean.getCmMBookNo());
							pstmt.setString(6,
									tenderMemoBean.getCheckMesuaredDate());
							pstmt.setString(7, tenderMemoBean.getEmpCodeSuper());
							pstmt.setString(8, tenderMemoBean.getScmMBookNo());
							pstmt.setString(9,
									tenderMemoBean.getSuperCheckMesuaredDate());
							pstmt.setString(10,
									tenderMemoBean.getSuperCheckBySE());
							pstmt.setString(11,
									tenderMemoBean.getSuperCheckPgNo());
							pstmt.setString(12,
									tenderMemoBean.getSuperCheckSEDate());

							pstmt.setString(13,
									tenderMemoBean.getBmsTranSanctionNo());

							pstmt.setString(14,
									tenderMemoBean.getBmsTransactionDate());
							
							pstmt.setString(15, workId);
							pstmt.setString(16,
									tenderMemoBean.getBillSlNo());
							
							
							if (formFile != null) {
							
							try {
								//String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
								if(!mimeType.equalsIgnoreCase("image/jpeg"))
								{
									returnValue="Allowed only jpg file extensions only.";
									return returnValue;
								}
								String path = actionServlet.getServletContext().getRealPath("") + formFile.getFileName();
								scannedFile = new File(path);
								outputStream = new FileOutputStream(scannedFile);
								if (outputStream != null) {

									outputStream.write(formFile.getFileData());
								}
								targetFile = new File(targetPath);

								/*if (!documentSanitizerImpl.madeSafe(scannedFile)) {
									message = "Image File is Corrupted";
									conn.setAutoCommit(true);
									scannedFile.delete();
									outputStream.close();
									targetFile.delete();
									return message;
								}*/
								compressImage(scannedFile, targetFile);

								fis = new FileInputStream(targetFile);
							} catch (Exception e) {
								System.out.println("exception in insertSourceDetails " + e);
							} finally {
								if (fis != null) {
								}
							}
							double fileSizeMB = ((tenderMemoBean
									.getPassOrderScanCopy().getFileSize() / 1024.0) / 1024.0);

							if (fileSizeMB > 0.2) {
								returnValue = "Image File Size Shoud Not Be Allowed More Than 200 KB";
								conn.setAutoCommit(true);
								scannedFile.delete();
								outputStream.close();
								targetFile.delete();
								return returnValue;
							}
							//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
							//String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
							if(!mimeType.equalsIgnoreCase("image/jpeg"))
							{
								returnValue="Allowed only jpg file extensions only.";
								return returnValue;
							}
							String imagePath=actionServlet.getServletContext().getRealPath("/") ;
							 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
								 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
								 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }else{
								 String sample[]  = imagePath.split( "webapps");
								// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
								 imagePath = sample[0];
								//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
							 }
							 imagePath = imagePath+ File.separator+"PassorderScanCopys";
							File myFilesDir = new File(imagePath);
							if (!myFilesDir.exists())
								myFilesDir.mkdirs();
							imagePath = imagePath + File.separator ;
							File filepath = new File(imagePath);
							//pstmt.setString(15, workId);
							//pstmt.setString(16,tenderMemoBean.getBillSlNo());
							String billdates=tenderMemoBean.getBillDate().replace("/", "-");
							File filepathisExits = new File(filepath+File.separator+workId+"_"+billdates+"_"+tenderMemoBean.getBillSlNo()+".jpg");
							if(filepathisExits.getAbsoluteFile().exists()){
								filepathisExits.delete();
							}
							 byte[] readData = new byte[1024];
								FileOutputStream fout=new FileOutputStream(filepath+File.separator+workId+"_"+billdates+"_"+tenderMemoBean.getBillSlNo()+".jpg"); 	
								int k = fis.read(readData);
							      while (k != -1) {
							    	  fout.write(readData, 0, k);
							        k = fis.read(readData);
							      }   			            
							    fout.close();
							    
							    
							    
							}
							    
							    
							    
							    
							    
							/*if (scannedFile != null) {
								scannedFile.delete();

							}
							if (targetFile != null) {
								targetFile.delete();
							}
							if (outputStream != null) {
								outputStream.close();
							}
							if (fis != null) {
							//	fis.close();
							}*/
							
							
							
							
							
							
							
							
							
							
							

						

						pstmt.addBatch();

						if (scannedFile != null) {
							scannedFile.delete();

						}
						if (targetFile != null) {
							targetFile.delete();
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

					} else {
						if (Integer.parseInt(tenderMemoBean
								.getGrossValueContractor()) >= Integer
								.parseInt(tenderMemoBean
										.getGrossValueAdmissable())) {

							String billInsertQuery = "insert into rws_work_bill_tbl(WORK_ID,BILL_SL_NO,BILL_NO,BILL_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,UPDATE_DATE,BILL_TYPE,CM_BY_DEE,CM_MBOOK_PG_NO,CM_DT,SCM_BY_EE ,SCM_MBOOK_PG_NO,SCM_DT,SCM_BY_SE,SCM_SE_MBOOK_PG_NO,SCM_SE_DT,BMS_TR_NO,BMS_TR_DATE) values(?,?,?,to_date(?,'dd/mm/yy'),?,?,sysdate,?,?,?,to_date(?,'dd/mm/yy'),?,?,to_date(?,'dd/mm/yy'),?,?,to_date(?,'dd/mm/yy'),?,to_date(?,'dd/mm/yy'))";

							pstmt = conn.prepareStatement(billInsertQuery);
							pstmt.setFetchSize(40000);

							pstmt.setString(1, workId);
							pstmt.setString(2, tenderMemoBean.getBillSlNo());
							pstmt.setString(3, tenderMemoBean.getBillNo());
							pstmt.setString(4, tenderMemoBean.getBillDate());
							pstmt.setString(5,
									tenderMemoBean.getGrossValueContractor());
							pstmt.setString(6,
									tenderMemoBean.getGrossValueAdmissable());
							pstmt.setString(7, "B");
							pstmt.setString(8, tenderMemoBean.getEmpCode());
							pstmt.setString(9, tenderMemoBean.getCmMBookNo());
							pstmt.setString(10,
									tenderMemoBean.getCheckMesuaredDate());
							pstmt.setString(11,
									tenderMemoBean.getEmpCodeSuper());
							pstmt.setString(12, tenderMemoBean.getScmMBookNo());
							pstmt.setString(13,
									tenderMemoBean.getSuperCheckMesuaredDate());
							pstmt.setString(14,
									tenderMemoBean.getSuperCheckBySE());
							pstmt.setString(15,
									tenderMemoBean.getSuperCheckPgNo());
							pstmt.setString(16,
									tenderMemoBean.getSuperCheckSEDate());

							pstmt.setString(17,
									tenderMemoBean.getBmsTranSanctionNo());

							pstmt.setString(18,
									tenderMemoBean.getBmsTransactionDate());

							formFile = tenderMemoBean.getPassOrderScanCopy();
							if (formFile != null && !formFile.equals("")) {
								/*try {

									String path = actionServlet
											.getServletContext()
											.getRealPath("")
											+ File.separator
											+ formFile.getFileName();

									scannedFile = new File(path);
									outputStream = new FileOutputStream(
											scannedFile);
									if (outputStream != null) {
										outputStream.write(formFile
												.getFileData());
									}

									

									targetFile = new File(targetPath);

									compressImage(scannedFile, targetFile);

									fis = new FileInputStream(targetFile);
									if (fis != null) {
									}
								} catch (Exception e) {
									e.printStackTrace();
								} finally {
									if (fis != null) {
										// fis.close();
									}
								}

								double fileSizeMB = ((formFile.getFileData().length / 1024.0) / 1024.0);

								if (fileSizeMB > 0.2) {
									returnValue = "Pass Order Scan Copy File Size Shoud Not Be Allowed More Than 200 KB";
									conn.setAutoCommit(true);
									scannedFile.delete();
									targetFile.delete();
									outputStream.close();
									return returnValue;

								}
								pstmt.setBinaryStream(19, fis,
										(int) targetFile.length());*/
								try {
									//String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
									if(!mimeType.equalsIgnoreCase("image/jpeg"))
									{
										returnValue="Allowed only jpg file extensions only.";
										return returnValue;
									}
									String path = actionServlet.getServletContext().getRealPath("") + formFile.getFileName();
									scannedFile = new File(path);
									outputStream = new FileOutputStream(scannedFile);
									if (outputStream != null) {

										outputStream.write(formFile.getFileData());
									}
									targetFile = new File(targetPath);

									/*if (!documentSanitizerImpl.madeSafe(scannedFile)) {
										message = "Image File is Corrupted";
										conn.setAutoCommit(true);
										scannedFile.delete();
										outputStream.close();
										targetFile.delete();
										return message;
									}*/
									compressImage(scannedFile, targetFile);

									fis = new FileInputStream(targetFile);
								} catch (Exception e) {
									System.out.println("exception in worksdata1 " + e);
								} finally {
									if (fis != null) {
									}
								}
								double fileSizeMB = ((tenderMemoBean
										.getPassOrderScanCopy().getFileSize() / 1024.0) / 1024.0);

								if (fileSizeMB > 0.2) {
									returnValue = "Image File Size Shoud Not Be Allowed More Than 200 KB";
									conn.setAutoCommit(true);
									scannedFile.delete();
									outputStream.close();
									targetFile.delete();
									return returnValue;
								}
								//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
								//String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
								if(!mimeType.equalsIgnoreCase("image/jpeg"))
								{
									returnValue="Allowed only jpg file extensions only.";
									return returnValue;
								}
								String imagePath=actionServlet.getServletContext().getRealPath("/") ;
								 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
									 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
									 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
									 imagePath = sample[0];
									 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
								 }else{
									 String sample[]  = imagePath.split( "webapps");
									// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
									 imagePath = sample[0];
									//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
								 }
								 imagePath = imagePath+ File.separator+"PassorderScanCopys";
								File myFilesDir = new File(imagePath);
								if (!myFilesDir.exists())
									myFilesDir.mkdirs();
								imagePath = imagePath + File.separator ;
								File filepath = new File(imagePath);
								//pstmt.setString(15, workId);
								//pstmt.setString(16,tenderMemoBean.getBillSlNo());
								String billdates=tenderMemoBean.getBillDate().replace("/", "-");
								File filepathisExits = new File(filepath+File.separator+workId+"_"+billdates+"_"+tenderMemoBean.getBillSlNo()+".jpg");
								if(filepathisExits.getAbsoluteFile().exists()){
									filepathisExits.delete();
								}
								 byte[] readData = new byte[1024];
									FileOutputStream fout=new FileOutputStream(filepath+File.separator+workId+"_"+billdates+"_"+tenderMemoBean.getBillSlNo()+".jpg"); 	
									int k = fis.read(readData);
								      while (k != -1) {
								    	  fout.write(readData, 0, k);
								        k = fis.read(readData);
								      }   			            
								    fout.close();
							} else {
								returnValue = "Pass Order Scan Copy File Size Shoud Be Mandatory.";
								conn.setAutoCommit(true);
								return returnValue;
							}

							pstmt.addBatch();

							if (scannedFile != null) {
								scannedFile.delete();
							}
							if (targetFile != null) {
								targetFile.delete();
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
			}
			for (int j = 0; j < vouchers.size(); j++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(j);
				String billno = tenderMemoBean.getBillSlNo();
				String check = "select * from RWS_WORK_MILESTONE_BILL_TBL where work_id=? and BILL_SL_NO = ?";
				pstmt2=conn.prepareStatement(check);
				pstmt2.setString(1, workId);
				pstmt2.setString(2, billno);
				ResultSet rs1 = pstmt2.executeQuery();
				if (rs1.next()) {
					String qq = "update RWS_WORK_MILESTONE_BILL_TBL SET BILL_NO='"
							+ tenderMemoBean.getBillNo()
							+ "' where work_id='"
							+ workId + "' and BILL_SL_NO = '" + billno + "'";
					stmt3.addBatch(qq);
				} else {
					String q1 = "insert into RWS_WORK_MILESTONE_BILL_TBL(MILESTONE_SLNO,WORK_ID,MAJOR_MILESTONE_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,COMPONENT_NO,TARGET_DATE,ACHIEVE_DATE,PERCENT_COMPLETED_WORK,PERCENT_COMPLETED,UPDATE_DATE,MS_STAGE,TYPE_OF_CONTRACTOR,COMPONENT_NO_ACH,EOAT_DT,BILL_SL_NO,BILL_NO,BILL_DAT,PERCENT_COMPLETED_WORK_VAL,PERCENT_COMPLETED_VAL) select MILESTONE_SLNO,WORK_ID,MAJOR_MILESTONE_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,COMPONENT_NO,TARGET_DATE,ACHIEVE_DATE,PERCENT_COMPLETED_WORK,PERCENT_COMPLETED,UPDATE_DATE,MS_STAGE,TYPE_OF_CONTRACTOR,COMPONENT_NO_ACH,EOAT_DT,'"
							+ tenderMemoBean.getBillSlNo()
							+ "','"
							+ tenderMemoBean.getBillNo()
							+ "',to_date('"
							+ tenderMemoBean.getBillDate()
							+ "','dd/mm/yyyy'),PERCENT_COMPLETED_WORK_VAL,PERCENT_COMPLETED_VAL from rws_MILESTONE_TARGET_ACH_TBL where work_id='"
							+ workId + "'";
					stmt3.addBatch(q1);
				}
			}

			int[] val = pstmt.executeBatch();
			int[] vall = {};
			if (val.length > 0)
				vall = stmt3.executeBatch();
			if (val.length > 0 && vall.length > 0) {
				returnValue = "Saved Successfully";
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
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();

			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		if (ff)
			returnValue = "Failed to Save/Update Voucher(s) - Admissible Amount of the Bill Should Not be Greater than Contractor Amount";
		return returnValue;
	}
	public boolean checkHabitaionIsExixts(String workId) {

		Connection conn = null;
		PreparedStatement psmt = null;
		boolean flag = false;

		try {
			conn = RwsOffices.getConn();
			String getQuery = "";

			if (workId != null && workId.substring(6, 8).equals("11")) {
				getQuery = "select * from rws_work_school_lnk_tbl a,rws_school_asset_lnk_tbl b where a.work_id=? or b.asset_code=?";
			} else if (workId != null && workId.substring(6, 8).equals("12")) {
				getQuery = "select * from rws_work_lab_lnk_tbl where work_id=?";
			} else {
				getQuery = "select * from rws_admn_hab_lnk_tbl where work_id=?";
			}
			psmt = conn.prepareStatement(getQuery);
			if (workId != null && workId.substring(6, 8).equals("11")) {
				psmt.setString(1, workId);
				psmt.setString(2, workId);
			} else if (workId != null && workId.substring(6, 8).equals("12")) {
				psmt.setString(1, workId);	
			}
			else{
				psmt.setString(1, workId);
			}
			ResultSet rs = psmt.executeQuery();

			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			Debug.println("Exception in checkHabitaionIsExixts:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (psmt != null) {
					psmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return flag;

	}

	
	
	
	
	
	
	
	public boolean checkSourceIsExists(String workId) {

		Connection conn = null;
		PreparedStatement psmt = null;
		boolean flag = false;

		try {
			conn = RwsOffices.getConn();
			String getQuery = "select *from rws_source_iden_fin_tbl where work_id=?";
			psmt = conn.prepareStatement(getQuery);
			psmt.setString(1, workId);
			ResultSet rs = psmt.executeQuery();

			if (rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			Debug.println("Exception in checkSourceIsExists:" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (psmt != null) {
					psmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return flag;

	}

	private InputStream getFileInputStream(String passOrderScanCopy) {
		// TODO Auto-generated method stub
		return null;
	}

	public String removeBills(ArrayList vouchers, String workId,
			String[] removeList, String remarks, String userId) {
		String returnValue = "";
		int alreadyThere = 0;
		PreparedStatement pstmt=null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			

			boolean flag = false;
			tenderMemo tenderMemoBeann = (tenderMemo) vouchers.get(0);
			if (tenderMemoBeann.getBillSlNo().equals("0"))
				flag = true;

			String index = "";
			for (int i = 0; i < vouchers.size(); i++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(i);

				if (tenderMemoBean.getBillSlNo().equals(removeList[0])) {
					index = "" + i;
				}
			}
			for (int i = 0; i < removeList.length; i++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(Integer
						.parseInt(index));
				query = "select * from RWS_WORK_EXP_VOUCHER_TBL where work_id=? and BILL_SL_NO=?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, tenderMemoBean.getBillSlNo());
				ResultSet rss = pstmt.executeQuery();

				query = "select * from RWS_BILL_BANK_BRIDGE_TBL where work_id=? and BILL_SL_NO=?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, tenderMemoBean.getBillSlNo());
				ResultSet rsss = pstmt.executeQuery();

				query = "select * from RWS_BILL_BANK_BRIDGE_TEMP_TBL where work_id=? and BILL_SL_NO=?";
				pstmt=conn.prepareStatement(query);
				pstmt.setString(1, workId);
				pstmt.setString(2, tenderMemoBean.getBillSlNo());
				ResultSet rssss = pstmt.executeQuery();

				if (rsss.next()) {
					alreadyThere = -1;
				} else if (rssss.next()) {
					alreadyThere = -2;
				} else if (!rss.next() && alreadyThere >= 0) {
					String query1 = "insert into RWS_WORK_BILL_DEL_TBL select WORK_ID,BILL_SL_NO,BILL_NO,BILL_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,UPDATE_DATE,sysdate,'"
							+ remarks
							+ "','"
							+ userId
							+ "' from RWS_work_BILL_TBL where work_id='"
							+ workId
							+ "' and BILL_SL_NO='"
							+ tenderMemoBean.getBillSlNo() + "'";
					stmt.addBatch(query1);
					
					query1 = "delete from rws_work_bill_tbl where work_id='"
							+ workId + "' and BILL_SL_NO='"
							+ tenderMemoBean.getBillSlNo() + "'";
					stmt.addBatch(query1);

					query1 = "delete from RWS_WORK_MILESTONE_BILL_TBL where work_id='"
							+ workId
							+ "' and BILL_SL_NO='"
							+ tenderMemoBean.getBillSlNo() + "'";
					stmt.addBatch(query1);
					
				} else {
					alreadyThere++;
				}
			}
			int[] val = stmt.executeBatch();
			if (val.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
				Debug.println("alreadyThere:" + alreadyThere);
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
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;
	}

	public ArrayList getVouchers(String workId, String slNo) {

		ArrayList vouchers = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			
			query = "SELECT recorded_by,to_char(recorded_date,'dd/mm/yyyy'),check_measured_by,to_char(check_measure_dt,'dd/mm/yyyy'),voucher_no,to_char(voucher_dt,'dd/mm/yyyy'),voucher_amt,cheque_no,to_char(cheque_dt,'dd/mm/yyyy'),SUPER_CHECK_MEASURED_BY,to_char(SUPER_CHECK_MEASURE_DT,'dd/mm/yyyy'),REMARKS,PROGRAMME_CODE,nvl(MBOOK_NO,'') as MBOOK_NO,MILESTONE_SLNO,CONTRACTOR_CODE,GRANT_DISTRIB,BILL_SL_NO,BILL_SL_NO "
					+ "from RWS_WORK_EXP_VOUCHER_TBL where work_id=? ORDER BY RECORDED_DATE";
			ps=conn.prepareStatement(query);
			ps.setString(1, workId);
			rset = ps.executeQuery();
			tenderMemo tenderMemoBean = null;
			while (rset.next()) {
				tenderMemoBean = new tenderMemo();
				tenderMemoBean
						.setMileStoneSno(rset.getString("MILESTONE_SLNO"));
				tenderMemoBean.setProgCode(rset.getString("PROGRAMME_CODE"));
				tenderMemoBean.setSno(rset.getString("MBOOK_NO"));
				tenderMemoBean.setEmpCodeRecorded(rset.getString(1));
				tenderMemoBean.setRecordedDate(rset.getString(2));
				tenderMemoBean.setEmpCode(rset.getString(3));
				tenderMemoBean.setCheckMesuaredDate(rset.getString(4));
				tenderMemoBean.setVoucherNo(rset.getString(5));
				tenderMemoBean.setVoucherDate(rset.getString(6));
				tenderMemoBean.setVoucherAmount(rset.getString(7));
				tenderMemoBean.setChequeNo(rset.getString(8));
				tenderMemoBean.setChequeDate(rset.getString(9));
				tenderMemoBean.setEmpCodeSuper(rset.getString(10));
				tenderMemoBean.setSuperCheckMesuaredDate(rset.getString(11));
				tenderMemoBean.setCheckMesuaredRemarks(rset.getString(12));
				if (rset.getString("CONTRACTOR_CODE") != null
						&& !rset.getString("CONTRACTOR_CODE").equals(""))
					tenderMemoBean.setContCode(rset
							.getString("CONTRACTOR_CODE"));
				else
					tenderMemoBean.setContCode("");
				tenderMemoBean.setBudgetInfo(rset.getString("GRANT_DISTRIB"));
				tenderMemoBean.setBillSlNo(rset.getString("BILL_SL_NO"));

				ResultSet rsqq = null;
				String getAmount = "select BILL_AMT_ADMISSIBLE from rws_work_bill_tbl where work_id=? and BILL_SL_NO =? ";
				pstat = conn.prepareStatement(getAmount);
				pstat.setString(1, workId);
				pstat.setString(2, rset.getString("BILL_SL_NO"));
				ResultSet gmrs1 = pstat.executeQuery();
				if (gmrs1.next()) {
					tenderMemoBean.setPaymentAdmissable(gmrs1.getString(1));
				} else {
					tenderMemoBean.setPaymentAdmissable("0");
				}

				String stat123 = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl  where work_id=? and BILL_SL_NO =?";
				pstat = conn.prepareStatement(stat123);
				pstat.setString(1, workId);
				pstat.setString(2, rset.getString("BILL_SL_NO"));
				rsqq = pstat.executeQuery();
				if (rsqq.next()) {
					tenderMemoBean.setBillVoucherAmount(rsqq.getString(1));// ""+round(((Double.parseDouble(rsqq.getString(1)))*100000),2));
				} else {
					tenderMemoBean.setBillVoucherAmount(rsqq.getString(1));
				}
				vouchers.add(tenderMemoBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getVouchers():" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return vouchers;

	}

	/**
	 * Working
	 * 
	 * @param vouchers
	 * @param workId
	 * @param progs
	 * @return
	 */
	public String saveVouchers(ArrayList vouchers, String workId,
			ArrayList progs) {
		String returnValue = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			query = "delete from RWS_WORK_EXP_VOUCHER_TBL where work_id='"
					+ workId + "'";
			stmt.addBatch(query);
			for (int j = 0; j < vouchers.size(); j++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(j);
				String sno = tenderMemoBean.getMileStoneSno();
				if (sno == null)
					sno = "";
				double vAmount = (Double.parseDouble(tenderMemoBean
						.getVoucherAmount())) / 100000;
				vAmount = round(vAmount, 2);
				query = "insert into RWS_WORK_EXP_VOUCHER_TBL values('"
						+ workId + "'," + "'"
						+ tenderMemoBean.getEmpCodeRecorded() + "',"
						+ "to_date('" + tenderMemoBean.getRecordedDate()
						+ "','dd/mm/yyyy')," + "to_date('"
						+ tenderMemoBean.getCheckMesuaredDate()
						+ "','dd/mm/yyyy')," + "'"
						+ tenderMemoBean.getEmpCode() + "'," + "'"
						+ tenderMemoBean.getVoucherNo() + "'," + "to_date('"
						+ tenderMemoBean.getVoucherDate() + "','dd/mm/yyyy'),"
						+ "'" + tenderMemoBean.getVoucherAmount() + "'," + "'"
						+ tenderMemoBean.getChequeNo() + "'," + "to_date('"
						+ tenderMemoBean.getChequeDate() + "','dd/mm/yyyy'),"
						+ "to_date('"
						+ tenderMemoBean.getSuperCheckMesuaredDate()
						+ "','dd/mm/yyyy')," + "'"
						+ tenderMemoBean.getEmpCodeSuper() + "'," + "'"
						+ tenderMemoBean.getCheckMesuaredRemarks() + "'," + "'"
						+ tenderMemoBean.getProgCode() + "'," + "'"
						+ tenderMemoBean.getSno() + "'," + "'" + sno + "','"
						+ tenderMemoBean.getContCode() + "','"
						+ tenderMemoBean.getBudgetInfo() + "','','','','')";
				stmt.addBatch(query);
			}
			int[] val = stmt.executeBatch();

			if (val[0] > 0) {
				returnValue = "Voucher(s) Successfully Updated for the Work ID:"
						+ workId;
			} else {
				returnValue = "Voucher(s) Successfully Inserted for the Work ID:"
						+ workId;
			}
			conn.setAutoCommit(true);
			conn.commit();


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

	/**
	 * Working for Saving Vouchers code
	 * 
	 * @param vouchers
	 * @param workId
	 * @param progs
	 * @param slNo
	 * @return
	 */
	public String saveVouchers(ArrayList vouchers, String workId,
			ArrayList progs, String slNo) {
		String returnValue = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();

			for (int j = 0; j < vouchers.size(); j++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(j);


				if (tenderMemoBean.getIsApproved() != null
						&& tenderMemoBean.getIsApproved().equals("A")) {
					continue;
				}

				query = "delete from RWS_WORK_EXP_VOUCHER_TBL where work_id='"
						+ workId + "' and BILL_SL_NO='"
						+ tenderMemoBean.getBillSlNo() + "'";
				stmt.addBatch(query);

				query = "insert into RWS_WORK_EXP_VOUCHER_TBL (WORK_ID,RECORDED_BY ,RECORDED_DATE,CHECK_MEASURE_DT,CHECK_MEASURED_BY,VOUCHER_NO,VOUCHER_DT,VOUCHER_AMT,CHEQUE_NO ,CHEQUE_DT ,SUPER_CHECK_MEASURE_DT,SUPER_CHECK_MEASURED_BY,REMARKS,PROGRAMME_CODE ,MBOOK_NO,MILESTONE_SLNO ,CONTRACTOR_CODE,GRANT_DISTRIB ,BILL_SL_NO ,PAYMENT_MODE ,UPDATE_DATE)  values('"
						+ workId
						+ "',"
						+ "'"
						+ tenderMemoBean.getEmpCodeRecorded()
						+ "',"
						+ "to_date('"
						+ tenderMemoBean.getRecordedDate()
						+ "','dd/mm/yyyy'),"
						+ "to_date('"
						+ tenderMemoBean.getCheckMesuaredDate()
						+ "','dd/mm/yyyy'),"
						+ "'"
						+ tenderMemoBean.getEmpCode()
						+ "',"
						+ "'"
						+ tenderMemoBean.getVoucherNo()
						+ "',"
						+ "to_date('"
						+ tenderMemoBean.getVoucherDate()
						+ "','dd/mm/yyyy'),"
						+ "'"
						+ tenderMemoBean.getVoucherAmount()
						+ "',"
						+ "'"
						+ tenderMemoBean.getChequeNo()
						+ "',"
						+ "to_date('"
						+ tenderMemoBean.getChequeDate()
						+ "','dd/mm/yyyy'),"
						+ "to_date('"
						+ tenderMemoBean.getSuperCheckMesuaredDate()
						+ "','dd/mm/yyyy'),"
						+ "'"
						+ tenderMemoBean.getEmpCodeSuper()
						+ "',"
						+ "'"
						+ tenderMemoBean.getCheckMesuaredRemarks()
						+ "',"
						+ "'"
						+ tenderMemoBean.getProgCode()
						+ "',"
						+ "'"
						+ tenderMemoBean.getSno()
						+ "',"
						+ "'','"
						+ tenderMemoBean.getContCode()
						+ "','"
						+ tenderMemoBean.getBudgetInfo()
						+ "','"
						+ tenderMemoBean.getBillSlNo()
						+ "','"
						+ tenderMemoBean.getPaymentMode()
						+ "',sysdate)";
				stmt.addBatch(query);
			}

			int[] val = stmt.executeBatch();

			if (val[0] > 0) {
				returnValue = "Voucher(s) Successfully Updated for the Work ID:"
						+ workId;
			} else {
				returnValue = "Voucher(s) Successfully Inserted for the Work ID:"
						+ workId;
			}
			conn.setAutoCommit(true);
			conn.commit();

		} catch (Exception e) {
			try {
				conn.rollback();
				returnValue = "Failed to Save/Update Voucher(s)";
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
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

	public String removeVouchers(ArrayList vouchers, String workId,
			String[] removeList) {
		String returnValue = "";
		Statement stmt3 =null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt3 = conn.createStatement();
			for (int i = 0; i < removeList.length; i++) {
				tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(Integer
						.parseInt(removeList[i]));
				double vAmount = (Double.parseDouble(tenderMemoBean
						.getVoucherAmount())) / 100000;
				vAmount = round(vAmount, 2);
				query = "delete from RWS_WORK_EXP_VOUCHER_TBL where work_id='"
						+ workId + "' and VOUCHER_NO=" + "'"
						+ tenderMemoBean.getVoucherNo() + "'";
				if (tenderMemoBean.getMileStoneSno() != null
						&& !tenderMemoBean.getMileStoneSno().equals(""))
					query += " and MILESTONE_SLNO='"
							+ tenderMemoBean.getMileStoneSno() + "'";
				stmt.addBatch(query);
				String date = tenderMemoBean.getVoucherDate();
				String mm = date.substring(3, 5);
				String yyyy = date.substring(6, 10);
				query = "delete from rws_work_exp_tmp_tbl where work_id='"
						+ workId + "' and year='" + yyyy + "' and month='" + mm
						+ "' and programme_code ='"
						+ tenderMemoBean.getProgCode()
						+ "' and expenditure_during='" + vAmount + "'";
				if (tenderMemoBean.getMileStoneSno() != null
						&& !tenderMemoBean.getMileStoneSno().equals(""))
					query += " and MILESTONE_SLNO='"
							+ tenderMemoBean.getMileStoneSno() + "'";
				stmt.addBatch(query);
			}
			int[] val = stmt.executeBatch();
			String qqqry = "select sum(EXPENDITURE_DURING),year,month,programme_code from rws_work_exp_tmp_tbl where work_id='"
					+ workId
					+ "' group by year,month,programme_code order by 2,3";
			ResultSet rs = stmt2.executeQuery(qqqry);
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
			Debug.println("Exception in removeVouchers:" + e);
		} finally {
			try {
				if (stmt != null)
					stmt.close();
				if (stmt3 != null)
					stmt3.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return returnValue;

	}

	public ArrayList getAdminPrograms(String workId) throws Exception {
		ArrayList programms = null;
		PreparedStatement psmt =null; 
		try {
			String qry = "select a.programme_code,programme_name from rws_work_admn_tbl a,rws_programme_tbl p "
					+ "where a.programme_code=p.programme_code and work_id=?"
					+ " union "
					+ "select a.programme_code,programme_name from RWS_WORK_ADMN_PROG_LNK_TBL a,rws_programme_tbl p "
					+ "where a.programme_code=p.programme_code and work_id=?";

			conn = RwsOffices.getConn();
			psmt = conn.prepareStatement(qry);
			psmt.setString(1, workId);
			psmt.setString(2, workId);
			
			ResultSet rs = psmt.executeQuery();
			programms = new ArrayList();
			LabelValueBean bean = null;
			while (rs.next()) {
				bean = new LabelValueBean();
				bean.setValue(rs.getString(1));
				bean.setLabel(rs.getString(2));
				programms.add(bean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getAdminPrograms():" + e);
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

		return programms;
	}

	public int updateContractor(String contCode, String panNo, String voterId) {
		int count = 0;
		ResultSet rs = null;
		Statement stmt=null;
		try {
			conn = RwsOffices.getConn();
			boolean orFlag = false;
			String checkqry = "select * from rws_contractor_tbl where contractor_code=contractor_code  and (";
			if (voterId != null && !voterId.equals("")) {
				if (!orFlag)
					checkqry += " VOTER_ID='" + voterId + "'";
				else
					checkqry += " OR VOTER_ID='" + voterId + "'";
				orFlag = true;
			}
			if (panNo != null && !panNo.equals("")) {
				if (!orFlag)
					checkqry += "PAN_NO='" + panNo + "'";
				else
					checkqry += " OR PAN_NO='" + panNo + "'";

				orFlag = true;
			}
			checkqry += ")";
			boolean flagg = false;
			stmt = conn.createStatement();
			 rs = stmt.executeQuery(checkqry);
			if (rs.next()) {
				flagg = true;
			}
			if (!flagg) {
				String qry = "update rws_contractor_tbl set pan_no=?,voter_id=? where contractor_code=?";
				ps=conn.prepareStatement(qry);
				ps.setString(1, panNo);
				ps.setString(2, voterId);
				ps.setString(3, contCode);
				count = ps.executeUpdate();
			}
		} catch (Exception e) {
			Debug.println("Exception in updateContractor:" + e);
		}
		finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return count;
	}


	
	public ArrayList getWorks(String contractorCode, String cCode,
			String divCode) {
		ArrayList habitations = new ArrayList();
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		try {
			query = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,"
					+ "SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME from rws_work_admn_tbl a,"
					+ "rws_programme_tbl p,rws_subprogramme_tbl s,rws_contractor_selection_tbl c where a.PROGRAMME_CODE="
					+ "p.PROGRAMME_CODE and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE="
					+ "s.SUBPROGRAMME_CODE and a.work_id=c.work_id and c.contractor_code=? and substr(OFFICE_CODE,2,2)=?"
					+ " and substr(OFFICE_CODE,4,1)=? ";
			
	
			conn = RwsOffices.getConn();
			stat = conn.prepareStatement(query);
			stat.setString(1, contractorCode);
			stat.setString(2, cCode);
			stat.setString(3, divCode);
			
			rset = stat.executeQuery();
			tenderMemo rwsLocationBean = null;
			while (rset.next()) {
				rwsLocationBean = new tenderMemo();
				rwsLocationBean.setWorkid(rset.getString(2));
				rwsLocationBean.setWorkname(rset.getString(1));
				rwsLocationBean.setBillNo(rset.getString(3));
				rwsLocationBean.setSanctiondt(rset.getString(4));
				rwsLocationBean.setSanctionamount(rset.getString(5));
				rwsLocationBean.setNoofhabs(rset.getString(6));
				rwsLocationBean.setProgName(rset.getString(7));
				rwsLocationBean.setSubprogName(rset.getString(8));
				habitations.add(rwsLocationBean);
			}
		} catch (Exception e) {
			Debug.writeln("Exception in getSelectedHabitations :" + e);
		} finally {
			if (rset != null) {
				try {
					if (rset != null)
						rset.close();
				} catch (SQLException sqle) {
				}
			}
			if (stat != null) {
				try {
					stat.close();
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
	

	public ArrayList getContractorsForUpdation(String circle, String div,
			String check) throws Exception {
		ArrayList worksfordeletion = null;
		try {
			conn = RwsOffices.getConn();
			if (check.equals("1"))
				query = "select b.contractor_code,b.contractor_name_company,PAN_NO,VOTER_ID,count(*) from rws_contractor_selection_tbl a,"
						+ "rws_contractor_tbl b,rws_work_admn_tbl c where a.contractor_code=b.contractor_code and a.work_id=c.work_id and "
						+ "substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? group by b.contractor_code,b.contractor_name_company,PAN_NO,VOTER_ID order by upper(contractor_name_company) ";
			else if (check.equals("2"))
				query = "select contractor_code,contractor_name_company,PAN_NO,VOTER_ID,'0' from rws_contractor_tbl where contractor_code "
						+ "in(select contractor_code from rws_contractor_tbl minus select contractor_code from rws_contractor_selection_tbl)  "
						+ "order by upper(contractor_name_company) ";
			ps=conn.prepareStatement(query);
			if (check.equals("1")){
				ps.setString(1, circle);
				ps.setString(2, div);
			}
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			worksfordeletion = new ArrayList();

			while (rset.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setWorkname(rset.getString(2));
				tendermemo.setWorkid(rset.getString(1));
				tendermemo.setNoofhabs(rset.getString(5));
				tendermemo.setProgName(rset.getString(3));
				tendermemo.setSubprogName(rset.getString(4));
				worksfordeletion.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in getContractorsForUpdation:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksfordeletion;
	}

	public ArrayList getWorksforAap(String circle, String div, String type,
			String cat, String prog, String scheme) throws Exception {
		ArrayList worksfordeletion = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt2 = conn.createStatement();

			int yr = Integer.parseInt(RwsUtils.getCurrentYear());
			yr -= 1;

			ResultSet rs2 = stmt2
					.executeQuery("select work_id,fin_year from rws_aap_selected_tbl where fin_year is not null and substr(WORK_ID,5,2)='"
							+ circle + "'");
			Hashtable ht3 = new Hashtable();
			while (rs2.next()) {
				ht3.put(rs2.getString(1), rs2.getString(2));
			}
			query = " SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as type,nvl(SOURCE_CODE,'-') as SOURCE_CODE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-') as GROUNDING_DATE from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c where substr(a.OFFICE_CODE,2,2)='"
					+ circle
					+ "' and substr(a.OFFICE_CODE,4,1)='"
					+ div
					+ "'  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion is not null and date_of_completion <='31/MAR/"
					+ yr
					+ "') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and plan_code='"
					+ type + "'";

			if (prog != null && !prog.equals("0")) {
				query += "  and a.programme_code='" + prog + "'";
			}

			if (scheme != null && !scheme.equals("0")) {
				query += "  and substr(a.work_id,7,2)='" + scheme + "'";
			}
			if (cat != null && !cat.equals("0")) {
				query += "  and a.category_code='" + cat + "'";
			}
			Debug.println("query in AAP:" + query);
			query = query + " order by plan_code";
			// Debug.println("query"+query);
			rset = stmt.executeQuery(query);
			rws_projectshelf_works_bean tendermemo = null;
			worksfordeletion = new ArrayList();

			while (rset.next()) {
				String val2 = "" + ht3.get(rset.getString("work_id"));
				if (val2 != null && !val2.equals("null")) {
				} else {
					val2 = "-";
				}

				tendermemo = new rws_projectshelf_works_bean();
				tendermemo.setWorkName(rset.getString("WORK_NAME"));
				tendermemo.setWorkId(rset.getString("WORK_ID"));
				tendermemo.setAdmnNo(rset.getString("ADMIN_NO"));
				tendermemo.setAdmnDate(rset.getString("ADMIN_DATE"));
				tendermemo.setAdmnAmnt(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setNoofhabs(rset.getString("NO_OF_HABS"));
				tendermemo.setMain(rset.getString("CAT"));
				tendermemo.setLabel(rset.getString("TYPE"));
				tendermemo.setSourceCode(rset.getString("source_code"));
				tendermemo.setGroundDate(rset.getString("GROUNDING_DATE"));
				if (!val2.equals("-"))
					tendermemo.setChecks("on");
				else
					tendermemo.setChecks("off");
				worksfordeletion.add(tendermemo);
			}

		} catch (Exception e) {
			Debug.println("Exception in getWorksforDeletion(datasource):" + e);
			//e.printStackTrace();
			//Debug.println("msg:" + e.getMessage());
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return worksfordeletion;
	}

	public int[] saveWorksforAap(String[] works, String ccode, String divcode,
			String aType) throws Exception {
		int count[] = {};

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			Statement pstmt = conn.createStatement();
			String aa = "delete from rws_aap_selected_tbl a where work_id in (select a.work_id from rws_aap_selected_tbl a, rws_worK_admn_tbl b where a.work_id=b.work_id and substr(b.OFFICE_CODE,2,2)='"
					+ ccode
					+ "' and substr(b.OFFICE_CODE,4,1)='"
					+ divcode
					+ "' and plan_code='" + aType + "')";
			Debug.println("aa:" + aa);
			pstmt.addBatch(aa);
			for (int i = 0; i < works.length; i++) {
				// Debug.println(works[i]);
				pstmt.addBatch("insert into rws_aap_selected_tbl values('"
						+ works[i] + "','2011-2012',sysdate)");
			}
			count = pstmt.executeBatch();
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
		}
		return count;

	}

	public ArrayList getWorksforAap1(String circle, String div, String type,
			String cat, String prog, String scheme,String subDiv) throws Exception {
		ArrayList works = new ArrayList();
		int year = Integer.parseInt(RwsUtils.getCurrentYear());
		year -= 1;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		DecimalFormat ndf = new DecimalFormat("####.00");
		try {
			conn = RwsOffices.getConn();
			
			Statement stmt2 = conn.createStatement();
			
			
					 int ye = Calendar.getInstance().get(Calendar.YEAR);
					 int pfye;
					    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
					    
					    if (mon <= 3) {
					        pfye=ye - 1;
					    } else {
					        pfye=ye ;
					    }
					    

			query = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as type,nvl(SOURCE_CODE,'-') as SOURCE_CODE,nvl(to_char(a.TARGET_DATE_COMP,'dd/mm/yyyy'),'-') ,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'-') as agreementDate,nvl(AGREEMENT_DURATION,0),c.remark,dname,division_office_name,dist.dcode,mname,nvl(a.core_dashboard_status,'') as coreStatus,nvl(to_char(a.SLCCDATE,'dd/mm/yyyy'),'-') as slssc,DELAY_REASON_CODE,PERCENT_COMPLETED,to_char(TARGET_UPDATE_DATE,'dd/mm/yyyy') as update_date from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dist,rws_division_office_tbl div,rws_mandal_tbl man "
					+ " where WORK_CANCEL_DT is null and substr(a.OFFICE_CODE,2,2)=? and substr(a.OFFICE_CODE,4,1)=? and dist.dcode=? and div.CIRCLE_OFFICE_CODE=? and div.DIVISION_OFFICE_CODE=? and substr(a.LEAD_HABITATION,6,2)=man.mcode and dist.dcode=man.dcode and a.PROGRAMME_CODE=p.PROGRAMME_CODE  ";
			if (subDiv != null && !subDiv.equals("0") && !subDiv.equals("")) {
				query += "  and substr(a.OFFICE_CODE,5,2)='" + subDiv + "'";
			}
			if (prog != null && !prog.equals("0") && !prog.equals("")) {
				query += "  and a.programme_code='" + prog + "'";
			}

			if (scheme != null && !scheme.equals("0") && !scheme.equals("")) {
				query += "  and substr(a.work_id,7,2)='" + scheme + "'";
			}
			if (cat != null && !cat.equals("0") && !cat.equals("")) {
				query += "  and a.category_code='" + cat + "'";
			}
			query += "  and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE  and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and plan_code=?";
			query += " order by dist.dcode,plan_code";
			
			ps=conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, div);
			ps.setString(3, circle);
			ps.setString(4, circle);
			ps.setString(5, div);
			ps.setString(6, type);
			
			rset = ps.executeQuery();
			
			java.util.Date currentDate = new java.util.Date();

			while (rset.next()) {
				rws_projectshelf_works_probabledt_bean	tendermemo = new rws_projectshelf_works_probabledt_bean();
				
				query = "select to_char(DATE_OF_COMM,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next() && resultSet.getString(1)!=null){
					if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
					tendermemo.setWorkStatusDate(resultSet.getString(1));
					tendermemo.setWorkStatus("commissioned");
					}
				}
				else{
					tendermemo.setCommisionedDate("-");
					resultSet.close();
					preparedStatement.close();
					
					query = "select to_char(DT_FIN_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
					preparedStatement=conn.prepareStatement(query);
					preparedStatement.setString(1, rset.getString("WORK_ID"));
					resultSet=preparedStatement.executeQuery();
					if(resultSet.next() && resultSet.getString(1)!=null){
						if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
						tendermemo.setWorkStatusDate(resultSet.getString(1));
						tendermemo.setWorkStatus("financiallyCompleted");
						}
					}
					else{
						tendermemo.setFinancialDate("-");
						resultSet.close();
						preparedStatement.close();
						query = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
						preparedStatement=conn.prepareStatement(query);
						preparedStatement.setString(1, rset.getString("WORK_ID"));
						resultSet=preparedStatement.executeQuery();
						if(resultSet.next() && resultSet.getString(1)!=null){
							if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
							tendermemo.setWorkStatusDate(resultSet.getString(1));
							tendermemo.setWorkStatus("physicallyCompleted");
							}
						}
						else{
							tendermemo.setPhysicalDate("-");
							resultSet.close();
							preparedStatement.close();
							query = "select to_char(GROUNDING_DATE,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id=?";
							preparedStatement=conn.prepareStatement(query);
							preparedStatement.setString(1, rset.getString("WORK_ID"));
							resultSet=preparedStatement.executeQuery();
							if(resultSet.next() && resultSet.getString(1)!=null){
								if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
								tendermemo.setWorkStatusDate(resultSet.getString(1));
								tendermemo.setWorkStatus("grounded");
								}
								
							}
							resultSet.close();
							preparedStatement.close();
							
							
							
						}
						resultSet.close();
						preparedStatement.close();
						
					}
					resultSet.close();
					preparedStatement.close();
					
					
					
				}resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-') from rws_work_commencement_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setGroundedDate(resultSet.getString(1));
				}
				else{
					tendermemo.setGroundedDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setCommisionedDate(resultSet.getString(1));
				}
				else{
					tendermemo.setCommisionedDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setFinancialDate(resultSet.getString(1));
				}
				else{
					tendermemo.setFinancialDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				
				query = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setPhysicalDate(resultSet.getString(1));
				}
				else{
					tendermemo.setPhysicalDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				/*End of Work Status Date Queries*/
				/*Start of Exp Date Queries*/
				double bankLastYear=0,bankLastMonth=0,bankCurrentMonth=0,paoLastYear=0,paoLastMonth=0,paoCurrentMonth=0;
				int cyear = Calendar.getInstance().get(Calendar.YEAR);

			    int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			    int day = Calendar.getInstance().get(Calendar.DATE);
			   
			    String currentMonth=getCurrentMonth(month);
			    String cDate=day+"-"+currentMonth+"-"+cyear;
			    
			    int yearStart=0;
			    int yearEnd=0;
			    if (month <= 3) {
			    	yearStart=cyear - 1;
				    yearEnd=cyear;
			    } else {
			    	yearStart=cyear;
				    yearEnd=cyear + 1;
			    }
			    //setExpUptoLastMonth
			    String finalLastMonth="";
			    if(month==4){
			    	finalLastMonth="0.0";
			    	
			    }
			    else{
				query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=? and BANK_SEND_DATE>=? and BANK_SEND_DATE<?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-APR-"+yearStart);
				preparedStatement.setString(3, "01-"+currentMonth+"-"+cyear);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankLastMonth=bankLastMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID=? and STATE_SEND_DATE>=? and STATE_SEND_DATE<?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-APR-"+yearStart);
				preparedStatement.setString(3, "01-"+currentMonth+"-"+cyear);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					paoLastMonth=paoLastMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				finalLastMonth=ndf.format((bankLastMonth+paoLastMonth)/100000);
				
			    }
			    tendermemo.setExpUptoLastMonth(finalLastMonth);
			    //setExpCurrentMonth
			    query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=?  and BANK_SEND_DATE>=? and BANK_SEND_DATE<=?";
			    preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-"+currentMonth+"-"+cyear);
				preparedStatement.setString(3, cDate);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankCurrentMonth=bankCurrentMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
			    
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID=? and STATE_SEND_DATE>=? and STATE_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-"+currentMonth+"-"+cyear);
				preparedStatement.setString(3, cDate);
				resultSet=preparedStatement.executeQuery();
				
				while(resultSet.next()){
					paoCurrentMonth=paoCurrentMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				String finalCurrentMonth=ndf.format((bankCurrentMonth+paoCurrentMonth)/100000);
				tendermemo.setExpCurrentMonth(finalCurrentMonth);
				String finalTotalMonth=ndf.format((bankLastMonth+paoLastMonth+bankCurrentMonth+paoCurrentMonth)/100000);
				tendermemo.setExpTotal(finalTotalMonth);
				//setExpLastFinancialYear
				query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=? and BANK_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "31-MAR-"+(yearEnd-1));
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankLastYear=bankLastYear+resultSet.getDouble(1);
				}
				
				resultSet.close();
				preparedStatement.close();
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID=?  and STATE_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "31-MAR-"+(yearEnd-1));
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					paoLastYear=paoLastYear+resultSet.getDouble(1);
				}
				
				resultSet.close();
				preparedStatement.close();
				String finalamount=ndf.format((bankLastYear+paoLastYear)/100000);
				tendermemo.setExpLastFinancialYear(finalamount);
				
				/*End of Exp Date Queries*/
				
						
				tendermemo.setWorkName(rset.getString("WORK_NAME"));
				tendermemo.setWorkId(rset.getString("WORK_ID"));
				tendermemo.setAdmnNo(rset.getString("ADMIN_NO"));
				tendermemo.setAdmnDate(rset.getString("ADMIN_DATE"));
				tendermemo.setAdmnAmnt(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setNoofhabs(rset.getString("NO_OF_HABS"));
				tendermemo.setMain(rset.getString("CAT"));
				tendermemo.setLabel(rset.getString("TYPE"));
				tendermemo.setSourceCode(rset.getString("source_code"));
				tendermemo.setProbableDate(rset.getString(12));

				SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				if(!rset.getString(13).equals("-")){
				Date myDate = format.parse(rset.getString(13));
				tendermemo.setStipulatedDate(format.format(RwsUtils.addMonths(
						myDate, rset.getInt(14))));
				}
				else{
					tendermemo.setStipulatedDate("-");
				}
				tendermemo.setDescription(rset.getString("remark"));
				tendermemo.setDname(rset.getString("dname"));
				tendermemo.setDivname(rset.getString("division_office_name"));
				tendermemo.setMname(rset.getString("mname"));
				tendermemo.setCoreDashboardStatus(rset.getString("coreStatus"));
				tendermemo.setSlsscDate(rset.getString("slssc"));
				tendermemo.setAgreementDate(rset.getString("agreementDate"));
				tendermemo.setReasonCode(rset.getString("DELAY_REASON_CODE"));
				tendermemo.setPerPhyCompl(rset.getString("PERCENT_COMPLETED"));
				
				query = "select work_id,WORK_IMAGE,WORK_IMAGE1 from rws_work_image_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					java.sql.Blob a = resultSet.getBlob(2);
					if(a==null){
						tendermemo.setImageStatus1("No");
					}
					else{
						tendermemo.setImageStatus1("Yes");
					}
					java.sql.Blob b = resultSet.getBlob(3);
					if(b==null){
						tendermemo.setImageStatus2("No");
					}
					else{
						tendermemo.setImageStatus2("Yes");
					}
					
				}
								
				resultSet.close();
				preparedStatement.close();
			
				
				works.add(tendermemo);
			}
			rset.close();
			ps.close();

		} catch (Exception e) {
			Debug.println("Exception in getWorksforAap1:" + e);
			//e.printStackTrace();
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return works;

	}

	public String saveWorksforAap1(rws_projectshelf_works_probabledt_frm frm,String targetPath,ActionServlet actionServlet) throws Exception {
		int count[] = {};
		int count1[] = {};
		int count2[] = {};
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message="";
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null,statement=null;
		ResultSet rs1 = null,resultSet=null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			 stmt = conn.createStatement();
			 stmt1 = conn.createStatement();
			 stmt2 = conn.createStatement();
			  statement=conn.createStatement();
			

			 for (int i = 0; i < frm.getPsWorks().size(); i++) {
					
				 rws_projectshelf_works_probabledt_bean bean =frm.getPsWorks().get(i);
				
					   if (bean.getChecks() != null
								&& bean.getChecks().equals("on")) {
						   
						   String checkQuery="select * from RWS_WORK_PHY_PERCENT_TBL where work_id='"+bean.getWorkId()+"'"; 	
						   resultSet=statement.executeQuery(checkQuery);
						   if(resultSet.next()){
						    String workStatus=bean.getWorkStatus();
						   	
						  	query1 = "update rws_contractor_selection_tbl set PROBABLE_DATE=to_date('"+ bean.getProbableDate()+ "','dd/mm/yyyy'),DELAY_REASON_CODE='"+bean.getReasonCode()+"',PERCENT_COMPLETED='"+bean.getPerPhyCompl()+"',UPDATE_DATE=sysdate where work_id='"+ bean.getWorkId()+ "'";
						   	
						  	stmt.addBatch(query1);
						   	query2 = "update rws_work_commencement_tbl set REMARK='"+bean.getDescription()+"' where work_id='"+bean.getWorkId()+"'";
						   	stmt2.addBatch(query2);
						   	
						 	String tar_date="";String querycm="";
							String queryslssc = "update rws_work_admn_tbl set SLCCDATE=to_date('"+bean.getSlsscDate()+"','dd/mm/yyyy'),core_dashboard_status='"+bean.getCoreDashboardStatus()+"',TARGET_DATE_COMP=to_date('"+bean.getProbableDate()+"','dd/mm/yyyy'),TARGET_UPDATE_DATE=sysdate where work_id='"+bean.getWorkId()+"'";
						   	stmt2.addBatch(queryslssc);
					   }
						   else{
							   return "Please select the category for the work: "+bean.getWorkId();
						   }
					   }
					   }
			 count2 = stmt2.executeBatch();
			 
			count = stmt.executeBatch();
			
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
				message="Selected work(s) Updated Successfully";
				
			} else{
				conn.rollback();
			
			message="Failed to Save";
			}
		} catch (Exception e) {
			Debug.println("Exception in saveWorksforAap1:" + e);
		}
		finally{
			if(conn!=null){
				conn.close();
			}
			if(stmt!=null){
				stmt.close();
			}
			if(stmt1!=null){
				stmt1.close();
			}
			if(stmt2!=null){
				stmt2.close();
			}
			if(statement!=null){
				statement.close();
			}
			if(rs1!=null){
				rs1.close();
			}
			if(resultSet!=null){
				resultSet.close();
			}
		}
		return message;

	}
	public String saveWorksforCMDB(rws_projectshelf_works_probabledt_frm frm,String targetPath,ActionServlet actionServlet) throws Exception {
		int count[] = {};
		int count1[] = {};
		int count2[] = {};
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message="";
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null,statement=null;
		ResultSet rs1 = null,resultSet=null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			 stmt = conn.createStatement();
			 stmt1 = conn.createStatement();
			 stmt2 = conn.createStatement();
			  statement=conn.createStatement();
			  int rscount=0;

			 for (int i = 0; i < frm.getPsWorks().size(); i++) {
					
				 rws_projectshelf_works_probabledt_bean bean =frm.getPsWorks().get(i);
				
					   if (bean.getChecks() != null
								&& bean.getChecks().equals("on")) {
						   						   							   
						   String querycm="";
						   querycm = "update rws_work_admn_tbl set TARGET_DATE_COMP=to_date('"+bean.getProbableDate()+"','dd/mm/yyyy'),core_dashboard_status='"+bean.getCoreDashboardStatus()+"',TARGET_UPDATE_DATE=sysdate,KPI_STATUS ='"+bean.getKpiStatus()+"' where work_id='"+bean.getWorkId()+"'";
						   rscount++;
						   stmt.addBatch(querycm);	
						   if(bean.getKpiStatus().equals("Y")) {
							   if(isExistKpiWork(bean.getWorkId(),conn)) {
								   String kpidelQry="delete from RWS_KPI_HABS_LNK_TBL where work_id='"+bean.getWorkId()+"'";
								   rscount++;
								   stmt.addBatch(kpidelQry);		
							   }						   
							   String kpihabQuery="";
							   String[] kpiHabs=bean.getKpiHabList().split("/");
							   for(int j=0;j<kpiHabs.length;j++) {						   
									   
								   rscount++;
									   kpihabQuery="insert into RWS_KPI_HABS_LNK_TBL values('"+bean.getWorkId()+"','"+kpiHabs[j]+"',sysdate)";
									   stmt.addBatch(kpihabQuery);							  
							   }
						   }
						   	
					   }
				 }			 
			count = stmt.executeBatch();			
			if (count.length == rscount) {
				conn.setAutoCommit(true);
				conn.commit();
				message="Selected work(s) Updated Successfully";				
			} else{
				conn.rollback();			
				message="Failed to Save";
			}
		} catch (Exception e) {
			Debug.println("Exception in saveWorksforCMDB:" + e);
		}
		finally{
			if(conn!=null){
				conn.close();
			}
			if(stmt!=null){
				stmt.close();
			}
			if(stmt1!=null){
				stmt1.close();
			}
			if(stmt2!=null){
				stmt2.close();
			}
			if(statement!=null){
				statement.close();
			}
			if(rs1!=null){
				rs1.close();
			}
			if(resultSet!=null){
				resultSet.close();
			}
		}
		return message;

	}

	public byte[] getScannedCopy(String workId, String billSlno) {

		Connection conn = null;
		PreparedStatement psmt = null;
		InputStream iStream = null;
		byte data[] = null;
		;

		try {

			conn = RwsOffices.getConn();
			String getQuery = "select PASS_ORDER_SCAN_COPY  from rws_work_bill_tbl where work_id=? and BILL_SL_NO=?";
			psmt = conn.prepareStatement(getQuery);
			psmt.setString(1, workId);
			psmt.setString(2, billSlno);
			ResultSet rs = psmt.executeQuery();

			if (rs.next()) {
				java.sql.Blob b = rs.getBlob(1);
				iStream = b.getBinaryStream();
				data = new byte[(int) b.length()];
				long i;
				long index = 0;
				while ((i = iStream.read()) != -1) {
					data[(int) index++] = (byte) i;

				}

			}
		} catch (Exception e) {
			System.out.println("Exception at getScannedCopy in WorksData1 "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (psmt != null) {
					psmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return data;
	}

	
	
	public byte[] decompress(byte[] input) throws UnsupportedEncodingException,
			IOException, DataFormatException {

		Inflater decompressor = new Inflater();
		decompressor.setInput(input);

		// Create an expandable byte array to hold the decompressed data
		ByteArrayOutputStream bos = new ByteArrayOutputStream(input.length);

		// Decompress the data
		byte[] buf = new byte[1024];
		while (!decompressor.finished()) {
			try {
				int count = decompressor.inflate(buf);
				bos.write(buf, 0, count);
			} catch (DataFormatException e) {
			}
		}
		try {
			bos.close();
		} catch (IOException e) {
		}

		// Get the decompressed data
		byte[] decompressedData = bos.toByteArray();

		return decompressedData;

	}

	/**
	 * 
	 * @param srcFile
	 * @param targetFile
	 * @throws IOException
	 */
	public void compressImage(File srcFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(srcFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		BufferedImage image = ImageIO.read(is);

		// get all image writers for JPG format
		Iterator<ImageWriter> writers = ImageIO
				.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();
		// compress to a given quality
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		// appends a complete image stream containing a single image and
		// associated stream and image metadata and thumbnails to the output
		writer.write(null, new IIOImage(image, null, null), param);

		// close all streams
		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}

	public void compressImage(InputStream is, OutputStream os)
			throws IOException {

		float quality = 0.5f;

		// create a BufferedImage as the result of decoding the supplied
		// InputStream
		BufferedImage image = ImageIO.read(is);

		// get all image writers for JPG format
		Iterator<ImageWriter> writers = ImageIO
				.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();
		// compress to a given quality
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		// appends a complete image stream containing a single image and
		// associated stream and image metadata and thumbnails to the output
		writer.write(null, new IIOImage(image, null, null), param);

		// close all streams
		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}

	/**
	 * 
	 * @param workId
	 * @return
	 */

	public long getPaoAdmissilbeAmount(String workId) {
		Connection conn = null;
		ResultSet rs = null;
		Statement stmt1 = null;
		long totalRefundAmount = 0;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			String query = "select sum(nvl(PAO_ADMISSABLE,0)) from rws_work_exp_voucher_tbl where work_id='"
					+ workId + "' and ee_approved_date is not null";
			rs = stmt1.executeQuery(query);
			while (rs.next()) {
				totalRefundAmount += Long.parseLong(rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception at getPaoAdmissilbeAmount in WorksData1 : "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
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
		return totalRefundAmount;

	}
	public String getCurrentMonth(int month) {
		String cMonth="";
		try{
			 if(month==1){
				 cMonth="JAN";
			}
			else if(month==2){
				cMonth="FEB";
			}
			else if(month==3){
				cMonth="MAR";	
			}
			else if(month==4){
				cMonth="APR";
			}
			else if(month==5){
				cMonth="MAY";
			}
			else if(month==6){
				cMonth="JUN";
			}
			else if(month==7){
				cMonth="JUL";
			}
			else if(month==8){
				cMonth="AUG";
			}
			else if(month==9){
				cMonth="SEP";
			}
			else if(month==10){
				cMonth="OCT";
			}
			else if(month==11){
				cMonth="NOV";
			}
			else if(month==12){
				cMonth="DEC";
			}
			
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return cMonth;
	}
	public String saveWorkImage(rws_projectshelf_works_probabledt_frm frm,String targetPath,ActionServlet actionServlet) throws Exception {
		
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message="";
		int count=0;
		try {
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			conn = RwsOffices.getConn();
			String imageQuery="";
			if(!isExists(frm.getWorkId(), conn)){
				if(frm.getImageStatus().equals("Image1")){
					imageQuery="insert into  rws_work_image_tbl(WORK_IMAGE,WORK_ID,UPDATE_DATE) values(?,?,sysdate)";
				}
				else if(frm.getImageStatus().equals("Image2")){
					imageQuery="insert into  rws_work_image_tbl(WORK_IMAGE1,WORK_ID,UPDATE_DATE) values(?,?,sysdate)";
					}
			}
			else
			{
				if(frm.getImageStatus().equals("Image1")){
					imageQuery="update rws_work_image_tbl set WORK_IMAGE=?,UPDATE_DATE=sysdate where WORK_ID=?";
				}
				else if(frm.getImageStatus().equals("Image2")){
					imageQuery="update rws_work_image_tbl set WORK_IMAGE1=?,UPDATE_DATE=sysdate where WORK_ID=?";
				}
			}
					   
						   	PreparedStatement pstmt=conn.prepareStatement(imageQuery);
						    formFile=frm.getScannedCopy();
						    if (frm.getScannedCopy() == null
									|| frm.getScannedCopy().toString().trim().equals("")) {
							
							} else {
							  
									try {
										String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
										if(!mimeType.equalsIgnoreCase("image/jpeg"))
										{
											message="Allowed only jpg file extensions only.";
											return message;
										}
										String path = actionServlet
												.getServletContext()
												.getRealPath("")
												+ File.separator
												+ formFile.getFileName();
										
										scannedFile = new File(path);
										outputStream = new FileOutputStream(
												scannedFile);
										if (outputStream != null) {
											outputStream.write(formFile
													.getFileData());
										}

										

										targetFile = new File(targetPath);

										if (!documentSanitizerImpl.madeSafe(scannedFile)) {
											message = "Image File is Corrupted";
											conn.setAutoCommit(true);
											scannedFile.delete();
											outputStream.close();
											targetFile.delete();
											return message;
										}
										
										compressImage(scannedFile, targetFile);

										fis = new FileInputStream(targetFile);
										if (fis != null) {
										}
									} catch (Exception e) {
										e.printStackTrace();
									} finally {
										if (fis != null) {
											// fis.close();
										}
									}

									
									double fileSizeMB = ((frm.getScannedCopy().getFileSize() / 1024.0) / 1024.0);

									if (fileSizeMB > 0.2) {
										message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
										conn.setAutoCommit(true);
										scannedFile.delete();
										outputStream.close();
										targetFile.delete();
										return message;

									}
									String status=getImage2Status(frm.getWorkId());
									if(status.equals("Yes") && frm.getImageStatus().equals("Image2")){
										String imageMoving="update  rws_work_image_tbl  set WORK_IMAGE=(select WORK_IMAGE1  from rws_work_image_tbl where work_id='"+frm.getWorkId()+"') where work_id='"+frm.getWorkId()+"'";
										stmt=conn.createStatement();
										int n=stmt.executeUpdate(imageMoving);
										
									}
									pstmt.setBinaryStream(1, fis,
											(int) targetFile.length());
									
									if (scannedFile != null) {
										scannedFile.delete();

									}
									if (targetFile != null) {
										targetFile.delete();
									}
									if (outputStream != null) {
										// outputStream.close();
									}
									if (fis != null) {
										// fis.close();
									}
					  
					   }
							   pstmt.setString(2, frm.getWorkId());
								int n=pstmt.executeUpdate();
								if(n>0){
									message="Image updated Successfully";
								}
								else{
									message="Failed to Update Image";
								} 
			
		
		} catch (Exception e) {
			System.out.println("Excepttion at saveWorkImage in WorksData1  "+e);
		}
		return message;

	}
	private boolean isExists(String workid, Connection conn) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select work_id from  rws_work_image_tbl where work_id='"
					+ workid + "'";
			rs = stmt1.executeQuery(query);
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Excepttion at isExists in WorksData1  "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}
	public byte[] getWorkIdScannedCopy(String workid,String status) {

		Connection conn = null;
		PreparedStatement psmt = null;
		InputStream iStream = null;
		byte data[] = null;
		String getQuery = "";
		try {

			conn = RwsOffices.getConn();
			if(status.equals("Image1")){
			 getQuery = "select WORK_IMAGE from rws_work_image_tbl where work_id=?";
			}
			else if(status.equals("Image2")){
				getQuery = "select WORK_IMAGE1 from rws_work_image_tbl where work_id=?";
			}
			
			psmt = conn.prepareStatement(getQuery);
			psmt.setString(1, workid);
			
			ResultSet rs = psmt.executeQuery();

			if (rs.next()) {
				java.sql.Blob b = rs.getBlob(1);
				iStream = b.getBinaryStream();
				data = new byte[(int) b.length()];
				long i;
				long index = 0;
				while ((i = iStream.read()) != -1) {
					data[(int) index++] = (byte) i;

				}

			}
		} catch (Exception e) {
			System.out.println("Excepttion at getWorkIdScannedCopy in WorksData1  "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (psmt != null) {
					psmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return data;
	}
	
	public String getImage2Status(String work_id){
		Statement statement=null;
		ResultSet resultSet=null;
		String status="";
		try{
			query = "select work_id,WORK_IMAGE,WORK_IMAGE1 from rws_work_image_tbl where work_id='"+work_id+"'";
			statement=conn.createStatement();
			resultSet=statement.executeQuery(query);
			if(resultSet.next()){
				java.sql.Blob a = resultSet.getBlob(2);
				java.sql.Blob b = resultSet.getBlob(3);
				//InputStream iStream = b.getBinaryStream();
				if(a!=null && b!=null){
					status="Yes";
				}
				else{
					status="No";
				}
				
				
			}
			
			
			resultSet.close();
			statement.close();
		}
		catch(Exception e){
			System.out.println("Excepttion at getImage2Status in WorksData1  "+e);
		}
		return status;
	}
	public ArrayList getWorksforMVS() {
		ArrayList works = new ArrayList();
		int year = Integer.parseInt(RwsUtils.getCurrentYear());
		year -= 1;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		DecimalFormat ndf = new DecimalFormat("####.00");
		try {
			conn = RwsOffices.getConn();
			
			Statement stmt2 = conn.createStatement();
			 int ye = Calendar.getInstance().get(Calendar.YEAR);
			 int pfye;
			    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
			    
			    if (mon <= 3) {
			        pfye=ye - 1;
			    } else {
			        pfye=ye;
			    }
			query = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as type,nvl(SOURCE_CODE,'-') as SOURCE_CODE,nvl(to_char(a.TARGET_DATE_COMP,'dd/mm/yyyy'),'-') ,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'-') as agreementDate,nvl(AGREEMENT_DURATION,0),c.remark,dname,division_office_name,dist.dcode,mname,nvl(a.core_dashboard_status,'') as coreStatus,nvl(to_char(a.SLCCDATE,'dd/mm/yyyy'),'-') as slssc,DELAY_REASON_CODE,PERCENT_COMPLETED,to_char(TARGET_UPDATE_DATE,'dd/mm/yyyy') as update_date from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dist,rws_division_office_tbl div,rws_mandal_tbl man "
					+ " where WORK_CANCEL_DT is null"
					+ " and a.PROGRAMME_CODE=p.PROGRAMME_CODE"
			        + " and  p.PROGRAMME_CODE=s.PROGRAMME_CODE"
					+ " and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE"
					+ " and substr(a.work_id,5,2)=dist.dcode and div.CIRCLE_OFFICE_CODE=substr(a.OFFICE_CODE,2,2) and div.DIVISION_OFFICE_CODE=substr(a.OFFICE_CODE,4,1) and substr(a.LEAD_HABITATION,6,2)=man.mcode and dist.dcode=man.dcode";
				
			query +=	 " and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
					+ " and (substr(a.work_id,7,2)='03' or NO_OF_HABS>1)";

			query = query + " order by dist.dcode,plan_code";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery(query);
			
			java.util.Date currentDate = new java.util.Date();

			while (rset.next()) {
				rws_projectshelf_works_probabledt_bean	tendermemo = new rws_projectshelf_works_probabledt_bean();
				
				query = "select to_char(DATE_OF_COMM,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
					tendermemo.setWorkStatusDate(resultSet.getString(1));
					tendermemo.setWorkStatus("commissioned");
					}
				}
				else{
					tendermemo.setCommisionedDate("-");
					resultSet.close();
					preparedStatement.close();
					
					query = "select to_char(DT_FIN_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
					preparedStatement=conn.prepareStatement(query);
					preparedStatement.setString(1, rset.getString("WORK_ID"));
					resultSet=preparedStatement.executeQuery();
					if(resultSet.next()){
						if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
						tendermemo.setWorkStatusDate(resultSet.getString(1));
						tendermemo.setWorkStatus("financiallyCompleted");
						}
					}
					else{
						tendermemo.setFinancialDate("-");
						resultSet.close();
						preparedStatement.close();
						query = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id=?";
						preparedStatement=conn.prepareStatement(query);
						preparedStatement.setString(1, rset.getString("WORK_ID"));
						resultSet=preparedStatement.executeQuery();
						if(resultSet.next()){
							if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
							tendermemo.setWorkStatusDate(resultSet.getString(1));
							tendermemo.setWorkStatus("physicallyCompleted");
							}
						}
						else{
							tendermemo.setPhysicalDate("-");
							resultSet.close();
							preparedStatement.close();
							query = "select to_char(GROUNDING_DATE,'dd/mm/yyyy') from rws_work_commencement_tbl where work_id=?";
							preparedStatement=conn.prepareStatement(query);
							preparedStatement.setString(1, rset.getString("WORK_ID"));
							resultSet=preparedStatement.executeQuery();
							if(resultSet.next()){
								if(resultSet.getString(1)!=null && resultSet.getString(1)!=""){
								tendermemo.setWorkStatusDate(resultSet.getString(1));
								tendermemo.setWorkStatus("grounded");
								}
								
							}
							resultSet.close();
							preparedStatement.close();
							
							
							
						}
						resultSet.close();
						preparedStatement.close();
						
					}
					resultSet.close();
					preparedStatement.close();
					
					
					
				}resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'-') from rws_work_commencement_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setGroundedDate(resultSet.getString(1));
				}
				else{
					tendermemo.setGroundedDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(DATE_OF_COMM,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setCommisionedDate(resultSet.getString(1));
				}
				else{
					tendermemo.setCommisionedDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				query = "select nvl(to_char(DT_FIN_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setFinancialDate(resultSet.getString(1));
				}
				else{
					tendermemo.setFinancialDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				
				query = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'-') from rws_work_completion_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					tendermemo.setPhysicalDate(resultSet.getString(1));
				}
				else{
					tendermemo.setPhysicalDate("-");
				}
				resultSet.close();
				preparedStatement.close();
				/*End of Work Status Date Queries*/
				/*Start of Exp Date Queries*/
				double bankLastYear=0,bankLastMonth=0,bankCurrentMonth=0,paoLastYear=0,paoLastMonth=0,paoCurrentMonth=0;
				int cyear = Calendar.getInstance().get(Calendar.YEAR);

			    int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
			    int day = Calendar.getInstance().get(Calendar.DATE);
			   
			    String currentMonth=getCurrentMonth(month);
			    String cDate=day+"-"+currentMonth+"-"+cyear;
			    
			    int yearStart=0;
			    int yearEnd=0;
			    if (month <= 3) {
			    	yearStart=cyear - 1;
				    yearEnd=cyear;
			    } else {
			    	yearStart=cyear;
				    yearEnd=cyear + 1;
			    }
			    //setExpUptoLastMonth
			    String finalLastMonth="";
			    if(month==4){
			    	finalLastMonth="0.0";
			    	
			    }
			    else{
				query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=? and BANK_SEND_DATE>=? and BANK_SEND_DATE<?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-APR-"+yearStart);
				preparedStatement.setString(3, "01-"+currentMonth+"-"+cyear);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankLastMonth=bankLastMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID=? and STATE_SEND_DATE>=? and STATE_SEND_DATE<?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-APR-"+yearStart);
				preparedStatement.setString(3, "01-"+currentMonth+"-"+cyear);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					paoLastMonth=paoLastMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				finalLastMonth=ndf.format((bankLastMonth+paoLastMonth)/100000);
				
			    }
			    tendermemo.setExpUptoLastMonth(finalLastMonth);
			    //setExpCurrentMonth
			    query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=?  and BANK_SEND_DATE>=? and BANK_SEND_DATE<=?";
			    preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-"+currentMonth+"-"+cyear);
				preparedStatement.setString(3, cDate);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankCurrentMonth=bankCurrentMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
			    
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL where WORK_ID=? and STATE_SEND_DATE>=? and STATE_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "01-"+currentMonth+"-"+cyear);
				preparedStatement.setString(3, cDate);
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					paoCurrentMonth=paoCurrentMonth+resultSet.getDouble(1);
				}
				resultSet.close();
				preparedStatement.close();
				String finalCurrentMonth=ndf.format((bankCurrentMonth+paoCurrentMonth)/100000);
				tendermemo.setExpCurrentMonth(finalCurrentMonth);
				String finalTotalMonth=ndf.format((bankLastMonth+paoLastMonth+bankCurrentMonth+paoCurrentMonth)/100000);
				tendermemo.setExpTotal(finalTotalMonth);
				//setExpLastFinancialYear
				query = "select BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL where WORK_ID=? and BANK_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "31-MAR-"+(yearEnd-1));
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					bankLastYear=bankLastYear+resultSet.getDouble(1);
				}
				
				resultSet.close();
				preparedStatement.close();
				query = "select BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL  where WORK_ID=?  and STATE_SEND_DATE<=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				preparedStatement.setString(2, "31-MAR-"+(yearEnd-1));
				resultSet=preparedStatement.executeQuery();
				while(resultSet.next()){
					paoLastYear=paoLastYear+resultSet.getDouble(1);
				}
				
				resultSet.close();
				preparedStatement.close();
				String finalamount=ndf.format((bankLastYear+paoLastYear)/100000);
				tendermemo.setExpLastFinancialYear(finalamount);
				
				/*End of Exp Date Queries*/
				
				
				
				tendermemo.setWorkName(rset.getString("WORK_NAME"));
				tendermemo.setWorkId(rset.getString("WORK_ID"));
				tendermemo.setAdmnNo(rset.getString("ADMIN_NO"));
				tendermemo.setAdmnDate(rset.getString("ADMIN_DATE"));
				tendermemo.setAdmnAmnt(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setNoofhabs(rset.getString("NO_OF_HABS"));
				tendermemo.setMain(rset.getString("CAT"));
				tendermemo.setLabel(rset.getString("TYPE"));
				tendermemo.setSourceCode(rset.getString("source_code"));
				tendermemo.setProbableDate(rset.getString(12));

				SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				if(!rset.getString(13).equals("-")){
				Date myDate = format.parse(rset.getString(13));
				tendermemo.setStipulatedDate(format.format(RwsUtils.addMonths(
						myDate, rset.getInt(14))));
				}
				else{
					tendermemo.setStipulatedDate("-");
				}
				tendermemo.setDescription(rset.getString("remark"));
				tendermemo.setDname(rset.getString("dname"));
				tendermemo.setDivname(rset.getString("division_office_name"));
				tendermemo.setMname(rset.getString("mname"));
				tendermemo.setCoreDashboardStatus(rset.getString("coreStatus"));
				tendermemo.setSlsscDate(rset.getString("slssc"));
				tendermemo.setAgreementDate(rset.getString("agreementDate"));
				tendermemo.setReasonCode(rset.getString("DELAY_REASON_CODE"));
				tendermemo.setPerPhyCompl(rset.getString("PERCENT_COMPLETED"));
				
				query = "select work_id,WORK_IMAGE,WORK_IMAGE1 from rws_work_image_tbl where work_id=?";
				preparedStatement=conn.prepareStatement(query);
				preparedStatement.setString(1, rset.getString("WORK_ID"));
				resultSet=preparedStatement.executeQuery();
				if(resultSet.next()){
					java.sql.Blob a = resultSet.getBlob(2);
					if(a==null){
						tendermemo.setImageStatus1("No");
					}
					else{
						tendermemo.setImageStatus1("Yes");
					}
					java.sql.Blob b = resultSet.getBlob(3);
					if(b==null){
						tendermemo.setImageStatus2("No");
					}
					else{
						tendermemo.setImageStatus2("Yes");
					}
					
				}
				
				
				resultSet.close();
				preparedStatement.close();
			
				
				works.add(tendermemo);
			}
			rset.close();
			ps.close();

		} catch (Exception e) {
			Debug.println("Exception in getWorksforMVS:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return works;

	}
	public ArrayList reasonsCombo() throws Exception {
		ArrayList reasons = new ArrayList();
		LabelValueBean labelValueBean=null;
		try {
			conn = RwsOffices.getConn();
			query = "select DELAY_REASON_CODE,DELAY_REASON_NAME from RWS_WORK_DELAY_REASONS";
			
			ps = conn.prepareStatement(query);
			
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				reasons.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in reasonsCombo:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("Get Reasons Exception in Closing ");
			}
		}

		return reasons;
	}

	public ArrayList getMileStoneCodesAndStages(rws_projectshelf_works_probabledt_frm frm) {

		ArrayList milestones = new ArrayList();
		PreparedStatement statement = null, statement1 = null, statement2 = null, stmt = null;
		ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, rs = null;

		try {
			String sourceType = "";
			String subSourceType = "";
			conn = RwsOffices.getConn();
			query = "select SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE from rws_source_iden_fin_tbl where work_id=? ";
			statement2 = conn.prepareStatement(query);
			statement2.setString(1, frm.getWorkId());
			resultSet2 = statement2.executeQuery();
			if (resultSet2.next()) {
				sourceType = resultSet2.getString("SOURCE_TYPE_CODE");
				subSourceType = resultSet2.getString("SUBSOURCE_TYPE_CODE");
				query = "select  distinct a.component_name,a.component_code from rws_ddws_phy_component_tbl a,rws_ddws_comp_mile_stg_lnk_tbl b "
						+ "where a.component_code=b.component_code and b.DISPLAYSTATUS='Y' and SOURCE_TYPE_CODE=? and "
						+ "SUBSOURCE_TYPE_CODE=? order by a.component_code";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, sourceType);
				stmt.setString(2, subSourceType);
				rs = stmt.executeQuery();
				while (rs.next()) {
					rws_projectshelf_works_probabledt_bean tendermemo2 = new rws_projectshelf_works_probabledt_bean();
					tendermemo2.setCompCode(rs.getString("component_code"));
					tendermemo2.setCompName(rs.getString("component_name"));
					tendermemo2.setStatus("major1");
					milestones.add(tendermemo2);

					query = "select  distinct a.MILESTONE_CODE,a.MILESTONE_NAME,a.MILESTONE_PERCENT from DDWS_PHY_MILESTONE_TBL a,"
							+ "DDWS_PHY_MILESTONE_STAGE_TBL b,rws_ddws_comp_mile_stg_lnk_tbl c where "
							+ "a.MILESTONE_CODE=b.MILESTONE_CODE and b.MILESTONE_CODE=c.MILESTONE_CODE and c.DISPLAYSTATUS='Y' and "
							+ "c.component_code=? and SOURCE_TYPE_CODE=? and SUBSOURCE_TYPE_CODE=? order by a.MILESTONE_CODE";

					ps = conn.prepareStatement(query);
					ps.setString(1, rs.getString("component_code"));
					ps.setString(2, sourceType);
					ps.setString(3, subSourceType);
					rset = ps.executeQuery();
					while (rset.next()) {
						rws_projectshelf_works_probabledt_bean tendermemo = new rws_projectshelf_works_probabledt_bean();

						tendermemo.setCompCode(rs.getString("component_code"));
						tendermemo.setMileStoneCode(rset.getString("MILESTONE_CODE"));
						tendermemo.setMileStoneName(rset.getString("MILESTONE_NAME"));
						tendermemo.setMilestonePercentage(rset.getDouble("MILESTONE_PERCENT"));
						tendermemo.setStatus("major");
						
						String majorcheck="select STAGE_PERCENT from RWS_WORK_PHY_PERCENT_TBL where WORK_ID='"+frm.getWorkId()+"'  and MILESTONE_CODE='"+rset.getString("MILESTONE_CODE")+"' and COMPONENT_CODE='"+rs.getString("component_code")+"' and SOURCE_TYPE_CODE='"+sourceType+"' and SUBSOURCE_TYPE_CODE='"+subSourceType+"'";
						PreparedStatement preparedStatement=conn.prepareStatement(majorcheck);
						ResultSet resultSet3=preparedStatement.executeQuery();
						if(resultSet3.next()){
							tendermemo.setChecks("on");
						}resultSet3.close();
						milestones.add(tendermemo);

						query = "select a.MILESTONE_CODE,a.MILESTONE_STAGE_CODE,a.MILESTONE_STAGE_NAME,a.MILESTONE_STAGE_PERCENT from "
								+ "DDWS_PHY_MILESTONE_STAGE_TBL a,rws_ddws_comp_mile_stg_lnk_tbl c where "
								+ "a.MILESTONE_CODE=c.MILESTONE_CODE and a.MILESTONE_STAGE_CODE=c.MILESTONE_STAGE_CODE and c.DISPLAYSTATUS='Y'"
								+ " and a.MILESTONE_CODE=? and c.component_code=? and SOURCE_TYPE_CODE=?"
								+ " and SUBSOURCE_TYPE_CODE=? ";
						statement = conn.prepareStatement(query);
						statement.setString(1, rset.getString("MILESTONE_CODE"));
						statement.setString(2, rs.getString("component_code"));
						statement.setString(3, sourceType);
						statement.setString(4, subSourceType);
						resultSet = statement.executeQuery();
						while (resultSet.next()) {
							rws_projectshelf_works_probabledt_bean tendermemo1 = new rws_projectshelf_works_probabledt_bean();
							tendermemo1.setCompCode(rs.getString("component_code"));
							tendermemo1.setMileStoneCode(resultSet.getString("MILESTONE_CODE"));
							tendermemo1.setMileStoneStageCode(resultSet.getString("MILESTONE_STAGE_CODE"));
							tendermemo1.setMileStoneStageName(resultSet.getString("MILESTONE_STAGE_NAME"));
							tendermemo1.setMilestoneStagePercentage(resultSet.getDouble("MILESTONE_STAGE_PERCENT"));
							tendermemo1.setSourceType(sourceType);
							tendermemo1.setSubSourceType(subSourceType);
							tendermemo1.setStatus("minor");
							String workQuery = "select STAGE_PERCENT,APPLICABLE from RWS_WORK_PHY_PERCENT_TBL where WORK_ID=?"
									+ " and MILESTONE_CODE=? and MILESTONE_STAGE_CODE=? and COMPONENT_CODE=?"
									+ " and SOURCE_TYPE_CODE=? and SUBSOURCE_TYPE_CODE=? ";
							statement1 = conn.prepareStatement(workQuery);
							statement1.setString(1, frm.getWorkId());
							statement1.setString(2, rset.getString("MILESTONE_CODE"));
							statement1.setString(3, resultSet.getString("MILESTONE_STAGE_CODE"));
							statement1.setString(4, rs.getString("component_code"));
							statement1.setString(5, sourceType);
							statement1.setString(6, subSourceType);
							resultSet1 = statement1.executeQuery();
							if (resultSet1.next()) {
								tendermemo1.setStagePer(resultSet1.getString("STAGE_PERCENT"));
								tendermemo1.setChecks("on");
								tendermemo1.setType(resultSet1.getString("APPLICABLE"));
							} else {
								tendermemo1.setChecks("off");
								tendermemo1.setType("N");
							}
							milestones.add(tendermemo1);
							resultSet1.close();
							statement1.close();
						}
						resultSet.close();
						statement.close();
					}
				}
				rs.close();
				stmt.close();
			}
			resultSet2.close();
			statement2.close();
		} catch (Exception e) {
			e.printStackTrace();
			Debug.println(" Exception in getMileStoneCodesAndStages of WorksData1--  " + e);

		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {

			}
		}

		return milestones;
	}
	public int[] saveMileStonesforWork(rws_projectshelf_works_probabledt_frm frm) throws Exception {
		int count[] = {};
		try {
			conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			
			ResultSet rs1 = null;

			 for (int i = 0; i < frm.getMilestones().size(); i++) {
					
				 rws_projectshelf_works_probabledt_bean bean =frm.getMilestones().get(i);
				
					   if (bean.getChecks() != null
								&& bean.getChecks().equals("on") && bean.getStatus().equals("minor")) {
						    String workStatus=bean.getWorkStatus();
						   	if(isExist(frm.getWorkId(),bean.getMileStoneCode(),bean.getMileStoneStageCode(),bean.getCompCode())){
						   	query1 = "insert into RWS_WORK_PHY_PERCENT_TBL(WORK_ID,COMPONENT_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,STAGE_PERCENT,UPDATE_DATE,APPLICABLE) values('"+frm.getWorkId()+"','"+bean.getCompCode()+"','"+bean.getMileStoneCode()+"','"+bean.getMileStoneStageCode()+"','"+bean.getSourceType()+"','"+bean.getSubSourceType()+"','"+bean.getMilestoneStagePercentage()+"',sysdate,'"+bean.getType()+"')";
						   	stmt.addBatch(query1);
						  
						   	}
						   	else{
						   		if(isExistMonth(frm.getWorkId(),bean.getMileStoneCode(),bean.getMileStoneStageCode(),bean.getCompCode())){
						   		query1 = "insert into RWS_WORK_PHY_PERCENT_HIS_TBL(WORK_ID,COMPONENT_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,STAGE_PERCENT,UPDATE_DATE,APPLICABLE) (select WORK_ID,COMPONENT_CODE,MILESTONE_CODE,MILESTONE_STAGE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,STAGE_PERCENT,UPDATE_DATE,APPLICABLE from RWS_WORK_PHY_PERCENT_TBL where WORK_ID='"+frm.getWorkId()+"' and MILESTONE_CODE='"+bean.getMileStoneCode()+"' and MILESTONE_STAGE_CODE='"+bean.getMileStoneStageCode()+"' and COMPONENT_CODE='"+bean.getCompCode()+"' and SOURCE_TYPE_CODE='"+bean.getSourceType()+"' and SUBSOURCE_TYPE_CODE='"+bean.getSubSourceType()+"')";
						   		stmt.addBatch(query1);
						   		}
						   		/*if(bean.getMilestoneStagePercentage()==0.0 || bean.getMilestoneStagePercentage()==0){
						   			query1 = "delete from RWS_WORK_PHY_PERCENT_TBL where WORK_ID='"+frm.getWorkId()+"' and MILESTONE_CODE='"+bean.getMileStoneCode()+"' and MILESTONE_STAGE_CODE='"+bean.getMileStoneStageCode()+"' and COMPONENT_CODE='"+bean.getCompCode()+"' and SOURCE_TYPE_CODE='"+bean.getSourceType()+"' and SUBSOURCE_TYPE_CODE='"+bean.getSubSourceType()+"'";
						   		}
						   		else{*/
						   		query1 = "update RWS_WORK_PHY_PERCENT_TBL set STAGE_PERCENT='"+bean.getMilestoneStagePercentage()+"',UPDATE_DATE=sysdate,APPLICABLE='"+bean.getType()+"' where WORK_ID='"+frm.getWorkId()+"' and MILESTONE_CODE='"+bean.getMileStoneCode()+"' and MILESTONE_STAGE_CODE='"+bean.getMileStoneStageCode()+"' and COMPONENT_CODE='"+bean.getCompCode()+"' and SOURCE_TYPE_CODE='"+bean.getSourceType()+"' and SUBSOURCE_TYPE_CODE='"+bean.getSubSourceType()+"'";
						   		//}
						   		stmt.addBatch(query1);
							   	
						   	}
					   }
					   }
			count = stmt.executeBatch();
			
			
		} catch (Exception e) {
			Debug.println("Exception in saveMileStonesforWork:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("Save Physical percentage Exception in Closing ");
			}
		}
		return count;

	}

	private boolean isExist(String workId, String mileStoneCode,
			String mileStoneStageCode,String compCode) {
		try{
			conn = RwsOffices.getConn();
			query1 = "select * from RWS_WORK_PHY_PERCENT_TBL where WORK_ID=? and MILESTONE_CODE=? and MILESTONE_STAGE_CODE=? and COMPONENT_CODE=?";
			PreparedStatement stmt = conn.prepareStatement(query1);
			stmt.setString(1, workId);
			stmt.setString(2, mileStoneCode);
			stmt.setString(3, mileStoneStageCode);
			stmt.setString(4,compCode);
			rset=stmt.executeQuery();
			if(rset.next()){
				return false;
			}
			else{
				return true;
			}
		}
		catch (Exception e) {
			System.out.println("Exception at isExist in WorksData1 is : "+e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				
			} catch (Exception e) {
				Debug.println("Get physical Exception in Closing ");
			}
		}
		return false;
	}
	private boolean isExistMonth(String workId, String mileStoneCode,
			String mileStoneStageCode,String compCode) {
		conn = RwsOffices.getConn();
		try{
			Date date; // your date
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			String val="";
			if(String.valueOf(month).length()==1)
				val="0"+month+"-"+year;
			else 
				val=month+"-"+year;
			
			query1 = "select * from RWS_WORK_PHY_PERCENT_TBL where WORK_ID=? and MILESTONE_CODE=? and MILESTONE_STAGE_CODE=? and COMPONENT_CODE=? and TO_CHAR(UPDATE_DATE,'mm-yyyy')=?";
			PreparedStatement stmt = conn.prepareStatement(query1);
			stmt.setString(1, workId);
			stmt.setString(2, mileStoneCode);
			stmt.setString(3, mileStoneStageCode);
			stmt.setString(4,compCode);
			stmt.setString(5, val);
			rset=stmt.executeQuery();
			if(rset.next()){
				return false;
			}
			else{
				return true;
			}
		}
		catch (Exception e) {
			System.out.println("Exception at isExistMonth in WorksData1 is : "+e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (stmt != null)
					stmt.close();
				
			} catch (Exception e) {
				Debug.println("Get physical Exception in Closing ");
			}
		}
		return false;
	}
	public ArrayList workStatusCombo() throws Exception {
		ArrayList workStauses = new ArrayList();
		LabelValueBean labelValueBean=null;
		
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("grounded");
				labelValueBean.setLabel("Grounded");
				labelValueBean.setLabelValue("grounded - Grounded");
				workStauses.add(labelValueBean);
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("financiallyCompleted");
				labelValueBean.setLabel("Financially Completed");
				labelValueBean.setLabelValue("financiallyCompleted - Financially Completed");
				workStauses.add(labelValueBean);
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("physicallyCompleted");
				labelValueBean.setLabel("Physically Completed");
				labelValueBean.setLabelValue("physicallyCompleted - Physically Completed");
				workStauses.add(labelValueBean);
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("commissioned");
				labelValueBean.setLabel("Commissioned");
				labelValueBean.setLabelValue("commissioned - Commissioned");
				workStauses.add(labelValueBean);
		

		return workStauses;
	}
	public ArrayList getWorksforCMCOREAap1(String circle, String div, String type,
			String cat, String prog, String scheme,String subDiv,String CMcore) throws Exception {
		ArrayList works = new ArrayList();
		int year = Integer.parseInt(RwsUtils.getCurrentYear());
		year -= 1;
		try {
			conn = RwsOffices.getConn();
			
					 int ye = Calendar.getInstance().get(Calendar.YEAR);
					 int pfye;
					    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
					    
					    if (mon <= 3) {
					            pfye=ye - 1;					       
					    } else {					       
					        pfye=ye ;					       
					    }
				
			query = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as type,nvl(SOURCE_CODE,'-') as SOURCE_CODE,nvl(to_char(a.TARGET_DATE_COMP,'dd/mm/yyyy'),'-') ,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'-') as agreementDate,nvl(AGREEMENT_DURATION,0),c.remark,dname,division_office_name,dist.dcode,mname,nvl(a.core_dashboard_status,'') as coreStatus,nvl(to_char(a.SLCCDATE,'dd/mm/yyyy'),'-') as slssc,DELAY_REASON_CODE,PERCENT_COMPLETED,to_char(TARGET_UPDATE_DATE,'dd/mm/yyyy') as update_date,nvl(a.KPI_STATUS,'') as KPISTATUS from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dist,rws_division_office_tbl div,rws_mandal_tbl man"
					+ " where WORK_CANCEL_DT is null and substr(a.OFFICE_CODE,2,2)=? and substr(a.OFFICE_CODE,4,1)=? and dist.dcode=? and div.CIRCLE_OFFICE_CODE=? and div.DIVISION_OFFICE_CODE=? and substr(a.LEAD_HABITATION,6,2)=man.mcode and dist.dcode=man.dcode and a.PROGRAMME_CODE=p.PROGRAMME_CODE  ";
			if (subDiv != null && !subDiv.equals("0") && !subDiv.equals("")) {
				query += "  and substr(a.OFFICE_CODE,5,2)='" + subDiv + "'";
			}
			if (prog != null && !prog.equals("0") && !prog.equals("")) {
				query += "  and a.programme_code='" + prog + "'";
			}

			if (scheme != null && !scheme.equals("0") && !scheme.equals("")) {
				query += "  and substr(a.work_id,7,2)='" + scheme + "'";
			}
			if (cat != null && !cat.equals("0") && !cat.equals("")) {
				query += "  and a.category_code='" + cat + "'";
			}
			if (CMcore != null && !CMcore.equals("0") && !CMcore.equals("")) {
				query += "  and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion<to_date('01/04/"+pfye+"','dd/mm/yyyy') ) ";
			}
		
			query += "  and  p.PROGRAMME_CODE=s.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE  and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and plan_code=?";
			
			query +=  " order by dist.dcode,plan_code";
			
			ps=conn.prepareStatement(query);
			ps.setString(1, circle);
			ps.setString(2, div);
			ps.setString(3, circle);
			ps.setString(4, circle);
			ps.setString(5, div);
			ps.setString(6, type);
			
			rset = ps.executeQuery();
			
			java.util.Date currentDate = new java.util.Date();

			while (rset.next()) {
				rws_projectshelf_works_probabledt_bean	tendermemo = new rws_projectshelf_works_probabledt_bean();
				
				
						
				tendermemo.setWorkName(rset.getString("WORK_NAME"));
				tendermemo.setWorkId(rset.getString("WORK_ID"));
				tendermemo.setAdmnNo(rset.getString("ADMIN_NO"));
				tendermemo.setAdmnDate(rset.getString("ADMIN_DATE"));
				tendermemo.setAdmnAmnt(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setProbableDate(rset.getString(12));
				tendermemo.setDname(rset.getString("dname"));
				tendermemo.setDivname(rset.getString("division_office_name"));
				tendermemo.setMname(rset.getString("mname"));
				tendermemo.setCoreDashboardStatus(rset.getString("coreStatus"));
				tendermemo.setKpiStatus(rset.getString("KPISTATUS"));				
								
				works.add(tendermemo);
			}
			rset.close();
			ps.close();

		} catch (Exception e) {
			Debug.println("Exception in getWorksforCMCOREAap1:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		return works;

	}
	public ArrayList getWorksforCMCOREMVS(String CMcore) {
		ArrayList works = new ArrayList();
		int year = Integer.parseInt(RwsUtils.getCurrentYear());
		year -= 1;
		try {
			conn = RwsOffices.getConn();
			 int ye = Calendar.getInstance().get(Calendar.YEAR);
			 int pfye;
			    int mon = Calendar.getInstance().get(Calendar.MONTH) + 1;
			    
			    if (mon <= 3) {
			        pfye=ye - 1;
			    } else {
			        pfye=ye;
			    }
			    
			query = "SELECT WORK_NAME,a.WORK_ID,ADMIN_NO,to_char(ADMIN_DATE,'dd/mm/yyyy') as ADMIN_DATE,SANCTION_AMOUNT,NO_OF_HABS, p.PROGRAMME_NAME,s.SUBPROGRAMME_NAME,decode(category_code,'1','Projects','2','Normal','3','District Level') as cat,decode (aug_new_code,'1','Main Scheme','2','Augmentation','3','Maintanance') as type,nvl(SOURCE_CODE,'-') as SOURCE_CODE,nvl(to_char(a.TARGET_DATE_COMP,'dd/mm/yyyy'),'-') ,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'-') as agreementDate,nvl(AGREEMENT_DURATION,0),c.remark,dname,division_office_name,dist.dcode,mname,nvl(a.core_dashboard_status,'') as coreStatus,nvl(to_char(a.SLCCDATE,'dd/mm/yyyy'),'-') as slssc,DELAY_REASON_CODE,PERCENT_COMPLETED,to_char(TARGET_UPDATE_DATE,'dd/mm/yyyy') as update_date,nvl(a.KPI_STATUS,'') as KPISTATUS from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dist,rws_division_office_tbl div,rws_mandal_tbl man "
					+ " where WORK_CANCEL_DT is null"
					+ " and a.PROGRAMME_CODE=p.PROGRAMME_CODE"
			        + " and  p.PROGRAMME_CODE=s.PROGRAMME_CODE"
					+ " and a.SUBPROGRAMME_CODE=s.SUBPROGRAMME_CODE"
					+ " and substr(a.work_id,5,2)=dist.dcode and div.CIRCLE_OFFICE_CODE=substr(a.OFFICE_CODE,2,2) and div.DIVISION_OFFICE_CODE=substr(a.OFFICE_CODE,4,1) and substr(a.LEAD_HABITATION,6,2)=man.mcode and dist.dcode=man.dcode";
			if (CMcore != null && !CMcore.equals("0") && !CMcore.equals("")) {
				query += "  and a.work_id not in(select work_id from rws_work_completion_tbl where date_of_completion<to_date('01/04/"+pfye+"','dd/mm/yyyy') ) ";
			}	
					
			query +=	 " and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
					+ " and (substr(a.work_id,7,2)='03' or NO_OF_HABS>1)";

			query +=  " order by dist.dcode,plan_code";
			ps=conn.prepareStatement(query);
			rset = ps.executeQuery();
			
			java.util.Date currentDate = new java.util.Date();

			while (rset.next()) {
				rws_projectshelf_works_probabledt_bean	tendermemo = new rws_projectshelf_works_probabledt_bean();
				
				
				
				
				tendermemo.setWorkName(rset.getString("WORK_NAME"));
				tendermemo.setWorkId(rset.getString("WORK_ID"));
				tendermemo.setAdmnNo(rset.getString("ADMIN_NO"));
				tendermemo.setAdmnDate(rset.getString("ADMIN_DATE"));
				tendermemo.setAdmnAmnt(rset.getString("SANCTION_AMOUNT"));
				tendermemo.setProgName(rset.getString("PROGRAMME_NAME"));
				tendermemo.setSubprogName(rset.getString("SUBPROGRAMME_NAME"));
				tendermemo.setProbableDate(rset.getString(12));

				tendermemo.setCoreDashboardStatus(rset.getString("coreStatus"));
				tendermemo.setKpiStatus(rset.getString("KPISTATUS"));
				
			
				
				works.add(tendermemo);
			}
			rset.close();
			ps.close();

		} catch (Exception e) {
			Debug.println("Exception in getWorksforCMCOREMVS:" + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"	+ e.getMessage());
			}
		}
		return works;
	}
	public ArrayList getKpiHabs(String workId) {
		ArrayList habs=new ArrayList();
		ResultSet resultSet=null;		
		try {
			conn = RwsOffices.getConn();
			
			String qry="select c.PANCH_name,b.HAB_CODE from RWS_WORK_ADMN_TBL a,RWS_ADMN_HAB_LNK_TBL b,RWS_COMPLETE_HAB_VIEW c where a.WORK_ID=b.WORK_ID and b.HAB_CODE=c.PANCH_CODE and a.work_id=?";
			ps = conn.prepareStatement(qry);
			ps.setString(1, workId);
			resultSet =ps.executeQuery();
			while(resultSet.next()) {
				rws_projectshelf_works_probabledt_bean	kpihabs = new rws_projectshelf_works_probabledt_bean();
				if(isExistKpiHab(workId,resultSet.getString("HAB_CODE"),conn)) {
					kpihabs.setCheck("on");
				}
				kpihabs.setHabCode(resultSet.getString("HAB_CODE"));
				kpihabs.setHabName(resultSet.getString("PANCH_name"));
				habs.add(kpihabs);
			}
		}catch (Exception e) {
			Debug.println("Exception in getKpiHabs:" + e);
		}
		finally {
			try {
				if (resultSet != null)
					resultSet.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"	+ e.getMessage());
			}
		}
		return habs;
	}
	
	private boolean isExistKpiHab(String workid, String habCode,Connection conn) {
		ResultSet rs = null;
		String query = "";
		try {
			
			query = "select WORK_ID,HABITATION_CODE from RWS_KPI_HABS_LNK_TBL where work_id=? and HABITATION_CODE=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			ps.setString(2, habCode);
			rs = ps.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			Debug.println("Exception in isExistKpiHab:" + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	private boolean isExistKpiWork(String workid, Connection conn) {
		ResultSet rs = null;
		String query = "";
		try {
			
			query = "select distinct WORK_ID from RWS_KPI_HABS_LNK_TBL where work_id=? ";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs = ps.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			Debug.println("Exception in isExistKpiWork:" + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}
	public int insertNotGroundWorksReason(String workId, String reason) {
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();
			query = "update rws_work_admn_tbl set REASON_FOR_NOT_GROUNDING =? where work_id=?";
			ps = conn.prepareStatement(query);
			ps.setString(1, reason);
			ps.setString(2, workId);
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("Exception in insertNotGroundWorksReason is " + e);
		} finally {
			releaseConnection();
		}
		return rcount;
	}
	public double getMileStoneCumulativePer(rws_projectshelf_works_probabledt_frm frm, String monthType) {
		ArrayList milestones = new ArrayList();
		PreparedStatement statement=null;
		ResultSet resultSet=null;
		double per=0;
		try {
			String sourceType="";
			String subSourceType="";
			conn = RwsOffices.getConn();
			if(monthType.equals("current")){
				query1 = "select sum(STAGE_PERCENT) from RWS_WORK_PHY_PERCENT_TBL a,RWS_DDWS_COMP_MILE_STG_LNK_TBL b where WORK_ID=? and a.COMPONENT_CODE=b.COMPONENT_CODE and a.MILESTONE_CODE=b.MILESTONE_CODE and a.MILESTONE_STAGE_CODE=b.MILESTONE_STAGE_CODE and a.SOURCE_TYPE_CODE=b.SOURCE_TYPE_CODE and a.SUBSOURCE_TYPE_CODE=b.SUBSOURCE_TYPE_CODE and b.DISPLAYSTATUS='Y'";
			}
			else if(monthType.equals("previous")){
				query1 = "select sum(STAGE_PERCENT) from RWS_WORK_PHY_PERCENT_HIS_TBL where WORK_ID=? and UPDATE_DATE=(select max(UPDATE_DATE) from RWS_WORK_PHY_PERCENT_HIS_TBL where WORK_ID=?)";
			} 
			statement=conn.prepareStatement(query1);
			statement.setString(1, frm.getWorkId());
			if(monthType.equals("previous")){
				statement.setString(2, frm.getWorkId());
			}
			resultSet=statement.executeQuery();
				if(resultSet.next()){
					per=resultSet.getDouble(1);
				}
			
		} catch (Exception e) {
			System.out.println("Exception in getMileStoneCumulativePer is " + e);
		} finally {
			try {
				if (rset != null)
					rset.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing ");
			}
		}

		return per;
	}
	public String saveFHTCHab(ArrayList vouchers,Collection removes){
		String returnValue = "Failed to Save/Update Data(s)";
		boolean ff = false;
		PreparedStatement pstmt = null,pstmt2=null;
		Statement stmt3 =null;
		try{
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt3 = conn.createStatement();
			for(int i=0;i<vouchers.size();i++){
				RwsLocationBean bean = (RwsLocationBean)vouchers.get(i);
				if(removes.contains(bean.getHabCode())){
					String sql = "update rws_habitation_directory_tbl set pending_fhtc=? where hab_code=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,bean.getPendingFHTC());
					pstmt.setString(2,bean.getHabCode());
					pstmt.addBatch();
				}
			}
			int[] val = pstmt.executeBatch();
			
			if (val.length > 0)
				returnValue = "Saved Successfully";
			
		}catch(Exception e){
			e.printStackTrace();
			try {
				conn.rollback();
				returnValue = "Failed to Save/Update Voucher(s)";
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			Debug.println("Exception in saveVouchers:" + e);
		}finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();

			} catch (Exception e) {
				Debug.println("EXCEPTION IN CLOSING CONNECTION"
						+ e.getMessage());
			}
		}
		
		return returnValue;
	}
	public ArrayList getSchoolsInHab(String habCode) throws Exception {

		String query = null;
		ArrayList schoolMandals = new ArrayList();
		conn = RwsOffices.getConn();
		
		try {
			query = "select HAB_CODE,SCHOOL_CODE,SCHOOL_NAME,SCHOOL_CLASSIFICATION,nvl(IS_HAVING_TAP,'No'),b.SCHOOL_CATEGORY_NAME,a.SCHOOL_CATEGORY_CODE from RWS_SCHOOL_MASTER_TBL a,RWS_SCHOOL_CATEGORY_TBL b where a.SCHOOL_CATEGORY_CODE=b.SCHOOL_CATEGORY_CODE and HAB_CODE=?";
			ps=conn.prepareStatement(query);
			ps.setString(1, habCode);
			rs = ps.executeQuery();
			//int count = 0;
			while (rs.next()) {
				RWS_SCHOOL_BEAN schoolData = new RWS_SCHOOL_BEAN();
				schoolData.setHabCode(rs.getString(1));
				schoolData.setSchoolCode(rs.getString(2));
				schoolData.setSchoolDetails(rs.getString(3));
				schoolData.setSchoolClassification(rs.getString(4));
				schoolData.setIsSchoolHavingTap(rs.getString(5));
				/*if(rs.getString(5).equals("Yes"))
				schoolData.setSchoolHavingTap(true);
				else schoolData.setSchoolHavingTap(false);*/
				schoolData.setSchoolCategory(rs.getString(6));
				schoolData.setSchoolCategoryCode(rs.getString(7));
				schoolMandals.add(schoolData);
			}
		} catch (Exception e) {
			Debug.println("Exception in getSchoolMandals"+e);
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return schoolMandals;

	}
}