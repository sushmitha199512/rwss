/*
 * Created on 26-04-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.SubCompMetaData;

public class Rws_MultipleSource_Entry_DAO {
	
	Connection conn = null;

	public ArrayList getWorkDetails(String Workid, HttpServletRequest request) {
		ArrayList data = new ArrayList();

		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			String qry = " SELECT distinct a.work_id,e.work_name,mname,pname,HAB_CODE, c.SOURCE_TYPE_NAME,d.SUBSOURCE_TYPE_NAME,SOURCE_CODE ,a.SOURCE_NAME from rws_source_iden_fin_tbl a,rws_mandal_tbl b , RWS_SOURCE_type_TBL c, RWS_subSOURCE_type_TBL d ,rws_work_admn_tbl e,rws_panchayat_tbl f  where a.work_id=e.work_id and a.WORK_ID ='"
					+ Workid
					+ "' and b.dcode=substr(a.hab_Code,1,2) and b.mcode=substr(a.hab_Code,6,2) and f.dcode=substr(a.hab_Code,1,2) and f.mcode=substr(a.hab_Code,6,2) and f.pcode=substr(a.hab_Code,13,2) and c. SOURCE_TYPE_CODE= a. SOURCE_TYPE_CODE and c.SOURCE_TYPE_CODE=d.SOURCE_TYPE_CODE  and  d.SUBSOURCE_TYPE_CODE=a.SUBSOURCE_TYPE_CODE";
			ps = conn.prepareStatement(qry);
			rs = ps.executeQuery();
			while (rs.next()) {

				Rws_MultipleSource_Entry_form frm = new Rws_MultipleSource_Entry_form();
				frm.setWorkid(rs.getString(1));
				frm.setWorkname(rs.getString(2));
				frm.setMandal(rs.getString(3));
				frm.setPanchayat(rs.getString(4));
				frm.setSourcehab(rs.getString(5));
				frm.setSourcetype(rs.getString(6));
				frm.setSubsourcetype(rs.getString(7));
				frm.setSource(rs.getString(8));
				frm.setSourcename(rs.getString(9));
				data.add(frm);
			}

		}

		catch (Exception e) {
			Debug.println("Exception in getWorkDetails Method:" + e);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e) {

			}
		}
		return data;
	}

	public ArrayList getMandals(String workid) throws Exception {
		ArrayList mtenderMemo = null;
		String query = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT distinct mcode,mname from rws_mandal_tbl b,rws_work_admn_tbl e where e.WORK_ID =? and b.dcode=substr(e.work_id,5,2) order by mname";
			ps = conn.prepareStatement(query);
			ps.setString(1, workid);
			rs = ps.executeQuery();
			tenderMemo tendermemo = null;
			mtenderMemo = new ArrayList();
			while (rs.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setMandalCode(rs.getString(1));
				tendermemo.setMandalName(rs.getString(2));
				mtenderMemo.add(tendermemo);
			}
		} catch (Exception e) {
			Debug.println("The Exception in getMandals " + e);
			e.printStackTrace();
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return mtenderMemo;
	}

	public ArrayList getMandalHabs(String workid, String mcode)
			throws Exception {
		ArrayList mtenderMemo = null;
		String query = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String dist = workid.substring(4, 6);
		try {
			conn = RwsOffices.getConn();
			query = "SELECT  distinct P.panch_code, P.panch_name FROM rws_panchayat_raj_tbl P,  rws_habitation_directory_tbl H,rws_habitation_directory_tbl hd,rws_mandal_tbl m WHERE hd.hab_code=p.panch_code and hd.hab_code=h.hab_code"
					+ " and P.panch_code = H.hab_code AND  H.circle_office_code = ? and substr(p.panch_code,6,2)=?  and h.circle_office_code=m.dcode and m.mcode=? and hd.coverage_status <> 'UI' and hd.coverage_status is not null order by P.panch_name";
			ps = conn.prepareStatement(query);
			ps.setString(1, dist);
			ps.setString(2, mcode);
			ps.setString(3, mcode);
			rs = ps.executeQuery();
			tenderMemo tendermemo = null;
			mtenderMemo = new ArrayList();
			while (rs.next()) {
				tendermemo = new tenderMemo();
				tendermemo.setPanchCode(rs.getString(1));
				tendermemo.setPanchName(rs.getString(2) + " - "
						+ rs.getString(1));
				mtenderMemo.add(tendermemo);
			}
		} catch (Exception e) {
			Debug.println("The Exception in getMandalHabs " + e);
		} finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		Debug.println("3.5:" + mtenderMemo.size());
		return mtenderMemo;
	}

	public ArrayList getSubCompType(String assetCode) {
		String query = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		ArrayList mtenderMemo = null;

		try {
			conn = RwsOffices.getConn();
			query = "SELECT * FROM RWS_SOURCE_TYPE_TBL order by SOURCE_TYPE_CODE";
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			tenderMemo tendermemo = null;
			mtenderMemo = new ArrayList();
			if (!assetCode.equals("04")) {
				while (rset.next()) {
					tendermemo = new tenderMemo();
					tendermemo.setSubCompCode(rset.getString(1));
					tendermemo.setSubCompName(rset.getString(2));

					mtenderMemo.add(tendermemo);
				}
			} else {
				tendermemo = new tenderMemo();

				tendermemo.setSubCompCode("1");
				tendermemo.setSubCompName("SUBSURFACE SOURCE");

				mtenderMemo.add(tendermemo);
			}
		} catch (Exception e) {
			Debug.println("Exception in SubCompType:" + e);
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
				e.printStackTrace();
			}
		}
		return mtenderMemo;
	}


	public ArrayList getSubSourceTypes(String subSourceCode, String assetCode) {
		String query = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
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
			e.printStackTrace();
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

	public ArrayList getSourceCodes(String sourceType, String habCode)
			throws Exception {
		RwsMaster rwsMaster = null;
		ArrayList sourceCodes = new ArrayList();
		PreparedStatement ps = null;
		ResultSet rset = null;

		SubCompMetaData subCompMetaData = new SubCompMetaData(
				sourceType.substring(0, 2), sourceType.substring(4, 5),
				sourceType.substring(5, 6), habCode);
		try {
			conn = RwsOffices.getConn();
			
			String query = "";
			query = "SELECT DISTINCT SOURCE_CODE,SOURCE_NAME FROM RWS_SOURCE_TBL WHERE HAB_CODE=?  and SOURCE_TYPE_CODE = ? and SUBSOURCE_TYPE_CODE =? and source_code not like '%HP%'";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			ps.setString(2, sourceType.substring(4, 5));
			ps.setString(3, sourceType.substring(5, 6));
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
			Debug.println("Exception in getSourceCodes:" + e.getMessage());
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
				e.printStackTrace();
			}
		}
		return sourceCodes;
	}

	public String getNewSourceCodes(String sourceType, String habCode,
			String workId) throws Exception {
		RwsMaster rwsMaster = null;
		String formed_source_code = "";
		PreparedStatement ps = null;
		ResultSet rset = null;
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

			if (ps != null)
				ps.close();

			query = "select " + schemeCodeField + " from " + insertTable
					+ " where hab_code like ? order by substr(" + schemeCodeField + ",22,3)";
			
			ps = conn.prepareStatement(query);
			ps.setString(1, habCode+"%");
			rs = ps.executeQuery();
			String maxCode = "";
			while (rs.next()) {
				maxCode = rs.getString(1);
			}
			int slno = 001;
			if (maxCode != null && maxCode.length() != 0
					&& maxCode.length() == 24) {
				slno = Integer.parseInt(maxCode.substring(21, 24));
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
		} catch (Exception e) {
			Debug.println("Exception is getNewSourceCodes:" + e.getMessage());
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

	public int SourceIdenInsert(Rws_MultipleSource_Entry_form worksBean,
			String officeCode) {

		String workCode = worksBean.getNwork();
		int count = 0;
		int d1 = 0, d2 = 0;
		String comp = worksBean.getSpradgroup();
		String  query = "";
		String insQuery = "";

		String assetCode = "";
		PreparedStatement pstat = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			assetCode = workCode.substring(6, 8);
			String sourceCode = "", sourceName = "";
			if (comp.equals("existSource")) {
				sourceCode = worksBean.getExtSourceCode().substring(0, 24);
				sourceName = worksBean.getExtSourceName();
			} else if (comp.equals("newSource")) {
				sourceCode = worksBean.getNewSourceCode();
				sourceName = worksBean.getNewSourceName();
			}
			if (comp.equals("newSource")) {
				insQuery = "insert into rws_source_tbl (source_code,source_name,source_type_code,subsource_type_code,hab_code,asset_code) values(?,?,?,?,?,?)";
				PreparedStatement ps = conn.prepareStatement(insQuery);
				ps.setString(1, sourceCode);
				ps.setString(2, sourceName);
				ps.setString(3, worksBean.getSubcompType());
				ps.setString(4, worksBean.getSubSourceType());
				ps.setString(5, worksBean.getSitehab());
				ps.setString(6, workCode);
				
				ps.executeUpdate();
			}
			query = "insert into rws_source_iden_fin_tbl(HAB_CODE,SOURCE_CODE,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,SITE_HAND_OVER_DATE,REMARKS,"
					+ " EMPLOYEE_CODE,office_code,work_id,TYPE_OF_ASSET_CODE,SOURCE_NAME,UPDATE_DATE) values(?,?,?,?,?,?,?,?,?,?,?,SYSDATE)";
			
			assetCode = worksBean.getSchemeCode();
			pstat = conn.prepareStatement(query);
			
			
			pstat.setString(1, worksBean.getSitehab());
			pstat.setString(2, sourceCode);
			pstat.setString(3, worksBean.getSubcompType());
			pstat.setString(4, worksBean.getSubSourceType());
			pstat.setString(5, worksBean.getSiteHODate());
			pstat.setString(6, worksBean.getRecommend());
			pstat.setString(7, worksBean.getSourceIdentby());
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
			Debug.println("Exception SrcIdenInsert:" + e);
		} finally {
			try {
				if (pstat != null)
					if (pstat != null)
						pstat.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				 Debug.println("EXCEPTION IN CLOSING CONNECTION"+e.getMessage());
			}
		}
		return count;

	}

}
