package nic.watersoft.wquality;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;

import nic.watersoft.BaseLineSurvey.BaseLineBean;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.drought.DroughtFlushRecords;
import nic.watersoft.drought.DroughtMasterData;
import nic.watersoft.works.tenderMemo;

/**
 * 
 * @author
 * 
 */
public class WQAssetData {
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

	Statement stmt9 = null;

	Statement stmt10 = null;

	Statement stmt11 = null;

	Statement stmt12 = null;

	Statement stmt13 = null;

	Statement stmt14 = null;

	Statement stmt15 = null;

	Statement stmt16 = null;

	Statement stmt17 = null;

	Statement stmt18 = null;

	Statement stmt19 = null;

	Statement stmt20 = null;

	Statement stmt21 = null;

	Statement stmt22 = null;

	Statement stmt23 = null;

	Statement stmt24 = null;

	ResultSet rs = null;

	ResultSet rset = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	ResultSet rs5 = null;

	ResultSet rs6 = null;

	ResultSet rs7 = null;

	ResultSet rs8 = null;

	ResultSet rs9 = null;

	ResultSet rs10 = null;

	ResultSet rs11 = null;

	ResultSet rs12 = null;

	ResultSet rs13 = null;

	ResultSet rs14 = null;

	ResultSet rs15 = null;

	ResultSet rs16 = null;

	ResultSet rs17 = null;

	ResultSet rs18 = null;

	ResultSet rs19 = null;

	ResultSet rs20 = null;

	ResultSet rs21 = null;

	ResultSet rs22 = null;

	ResultSet rs23 = null;

	ResultSet rs24 = null;

	int connCount = 0;

	PreparedStatement ps = null;

	public WQAssetData() {
	}

	public void closeAll() throws Exception {
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
		Statement stmt9 = null;
		Statement stmt10 = null;
		Statement stmt11 = null;
		Statement stmt12 = null;
		Statement stmt13 = null;
		Statement stmt14 = null;
		Statement stmt15 = null;
		Statement stmt16 = null;
		Statement stmt17 = null;
		Statement stmt18 = null;
		Statement stmt19 = null;
		Statement stmt20 = null;
		Statement stmt21 = null;
		Statement stmt22 = null;
		Statement stmt23 = null;
		Statement stmt24 = null;
		ResultSet rs = null;
		ResultSet rset = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs8 = null;
		ResultSet rs9 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		ResultSet rs14 = null;
		ResultSet rs15 = null;
		ResultSet rs16 = null;
		ResultSet rs17 = null;
		ResultSet rs18 = null;
		ResultSet rs19 = null;
		ResultSet rs20 = null;
		ResultSet rs21 = null;
		ResultSet rs22 = null;
		ResultSet rs23 = null;
		ResultSet rs24 = null;
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in WQAsset" + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}

	//
	public ArrayList getListSourcedetails(WQAssetForm frm, String year,
			int year1) throws Exception {
		ArrayList sources = new ArrayList();
		String codeSeries = "";
		WQAssetData wqasstdata = new WQAssetData();
		String query = "";
		Debug.println("year1inside method<<<<<<<<<<<<<<");
		try {
			//

			if (frm.getAssetType().equals("01"))
				codeSeries = codeSeries = "substr(source_code,17,3) like '6%'";
			else if (frm.getAssetType().equals("02"))
				codeSeries = "(substr(source_code,17,3) like '40%' or substr (source_code,17,3) like '41%' or substr(source_code,17,3) like '42%' or  substr(source_code,17,3) like '43%' or substr (source_code,17,3) like '44%')";
			else if (frm.getAssetType().equals("03"))
				codeSeries = "substr(source_code,17,3) like '8%'";
			else if (frm.getAssetType().equals("09"))
				codeSeries = "(substr(source_code,17,3) like '45%' or substr (source_code,17,3) like '46%' or substr(source_code,17,3) like '47%' or substr(source_code,17,3) like '48%' or substr (source_code,17,3) like '49%')";
			else if (frm.getAssetType().equals("04")) {
				codeSeries = "(substr(source_code,17,3) like '0%' or substr (source_code,17,3) like '1%' or substr(source_code,17,3) like '2%')";
			} else if (frm.getAssetType().equals("05"))
				codeSeries = "substr(source_code,17,3) like '3%'";
			else if (frm.getAssetType().equals("06"))
				codeSeries = "substr(source_code,17,3) like '5%'";
			else if (frm.getAssetType().equals("07"))
				codeSeries = "substr(source_code,17,3) like '7%'";
			else if (frm.getAssetType().equals("08"))
				codeSeries = "substr(source_code,17,3) like '9%'";
			//
			Debug.println("codeSeries<<<<<<<<<<<<<<" + codeSeries);
			Debug.println("ConnCount is<<<<< " + connCount);
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			// work
			// query =
			// "select source_code,nvl(asset_name,'-'),to_char(prepared_on,'dd/mm/yyyy'),TESTING_PARAMETER_CODE, TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_VALUE from rws_asset_mast_tbl a,RWS_WQ_TEST_RESULTS_TBL b,RWS_WQ_PARA_TEST_TBL C where C.TEST_CODE=B.TEST_CODE AND asset_status='1' and testing_parameter_code  in (04,12,13,15,06,05,07,13,16) and type_of_asset_code='"+frm.getAssetType()+"' and  "+codeSeries+" and a.circle_office_code='"+frm.getCircleCode()+"' and division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"'  and to_date(prepared_on)>='1-APR-"+year+"' and  to_date(prepared_on)<'31-MAR-"+year1+"'";

			// resul lnk
			// query="select b.source_code,nvl(a.asset_name,'-'),to_char(b.prepared_on,'dd/mm/yyyy'),c.TESTING_PARAMETER_CODE, c.TESTING_PARAMETER_NAME,c.MIN_PERMISSIBLE_VALUE,c.MAX_PERMISSIBLE_VALUE from rws_asset_mast_tbl a,RWS_WQ_TEST_RESULTS_TBL b,RWS_WQ_PARA_TEST_TBL C,rws_wq_test_results_lnk_tbl l where  b.test_id=l.test_id and  C.TEST_CODE=B.TEST_CODE AND asset_status='1' and c.testing_parameter_code  in (04,12,13,15,06,05,07,13,16) and type_of_asset_code='"+frm.getAssetType()+"' and  "+codeSeries+" and b.prepared_on=(select max(h.prepared_on) from rws_wq_test_results_tbl h  where b.source_code=h.source_code)and a.circle_office_code='"+frm.getCircleCode()+"' and division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"'  and to_date(b.prepared_on)>='1-APR-"+year+"' and  to_date(b.prepared_on)<'31-MAR-"+year1+"'";

			Debug.println("Connectionyear1<<<<<<<<<<<<<<");

			// query="select distinct b.source_code,to_char(b.prepared_on,'dd/mm/yyyy') from RWS_WQ_TEST_RESULTS_TBL b ,rws_asset_mast_tbl a where a.hab_code=substr(b.source_code,1,16) and      "+codeSeries+" and b.prepared_on=(select max(h.prepared_on) from rws_wq_test_results_tbl h  where b.source_code=h.source_code) and a.circle_office_code='"+frm.getCircleCode()+"' and division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"'  and to_date(b.prepared_on)>='1-APR-"+year+"' and  to_date(b.prepared_on)<'31-MAR-"+year1+"'";

			// MAX VALUES:::::::: and b.prepared_on=(select max(h.prepared_on)
			// from rws_wq_test_results_tbl h where b.source_code=h.source_code)

			// query="select distinct b.source_code,to_char(b.prepared_on,'dd/mm/yyyy') from RWS_WQ_TEST_RESULTS_TBL b,rws_asset_mast_tbl a where substr(b.source_code,1,2)=a.circle_office_code and type_of_asset_code='"+frm.getAssetType()+"' and asset_status='1' and   "+codeSeries+" and  substr(b.source_code,1,2)='"+frm.getCircleCode()+"' and  division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"' and  to_date(b.prepared_on)>='1-APR-"+year+"' and  to_date(b.prepared_on)<'31-MAR-"+year1+"' ";

			// working query modified for view
			// query="select distinct b.source_code,nvl(a.asset_name,'-'),to_char(b.prepared_on,'dd/mm/yyyy'),c.TESTING_PARAMETER_CODE, c.TESTING_PARAMETER_NAME,c.MIN_PERMISSIBLE_VALUE,c.MAX_PERMISSIBLE_VALUE,l.TESTING_PARAMETER_VALUE from rws_asset_mast_tbl a,RWS_WQ_TEST_RESULTS_TBL b,RWS_WQ_PARA_TEST_TBL C,rws_wq_test_results_lnk_tbl l where l.TESTING_PARAMETER_VALUE<c.MAX_PERMISSIBLE_VALUE and a.hab_code=substr(source_code,1,16) and c.TESTING_PARAMETER_CODE =l.TESTING_PARAMETER_CODE and  b.test_id=l.test_id and  C.TEST_CODE=B.TEST_CODE AND asset_status='1' and c.testing_parameter_code  in (04,12,13,15,06,05,07,13,16) and type_of_asset_code='"+frm.getAssetType()+"' and  "+codeSeries+" and a.circle_office_code='"+frm.getCircleCode()+"' and division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"'  and to_date(b.prepared_on)>='1-APR-"+year+"' and  to_date(b.prepared_on)<'31-MAR-"+year1+"'";

			query = "select distinct source_code,nvl(asset_name,'-'),to_char(prepared_on,'dd/mm/yyyy'),TESTING_PARAMETER_CODE, TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_VALUE,TESTING_PARAMETER_VALUE from wqassetview where  type_of_asset_code='"
					+ frm.getAssetType()
					+ "' and  "
					+ codeSeries
					+ " and circle_office_code='"
					+ frm.getCircleCode()
					+ "' and division_office_code='"
					+ frm.getDivisionCode()
					+ "' and subdivision_office_code='"
					+ frm.getSubdivisionCode()
					+ "'  and to_date(prepared_on)>='1-APR-"
					+ year
					+ "' and  to_date(prepared_on)<'31-MAR-" + year1 + "'";

			Debug.println("year<<<<<<<<<<<<<<" + query);
			rs = stmt.executeQuery(query);
			Debug.println("Query***********for cviewto display details***"
					+ query);

			while (rs.next()) {
				WQAssetForm frm1 = new WQAssetForm();

				frm1.setSourceCode(rs.getString(1));
				frm1.setPreparedDate(rs.getString(3));
				frm1.setParameter4(rs.getString(5));
				frm1.setParameter1(rs.getString(6));
				frm1.setParameter2(rs.getString(7));
				frm1.setParameter3(rs.getString(8));

				sources.add(frm1);

			}

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in getBaseLine=" + e);
		} finally {
			// wqasstdata.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return sources;
	}

	//
	public ArrayList getContaminatedSourcedetails(WQAssetForm frm, String year,
			int year1) throws Exception {
		ArrayList sources = new ArrayList();
		String codeSeries = "";
		WQAssetData wqasstdata = new WQAssetData();
		String query = "";
		Debug.println("year1inside method<<<<<<<<<<<<<<");
		try {
			//

			if (frm.getAssetType().equals("01"))
				codeSeries = codeSeries = "substr(source_code,17,3) like '6%'";
			else if (frm.getAssetType().equals("02"))
				codeSeries = "(substr(source_code,17,3) like '40%' or substr (source_code,17,3) like '41%' or substr(source_code,17,3) like '42%' or  substr(source_code,17,3) like '43%' or substr (source_code,17,3) like '44%')";
			else if (frm.getAssetType().equals("03"))
				codeSeries = "substr(source_code,17,3) like '8%'";
			else if (frm.getAssetType().equals("09"))
				codeSeries = "(substr(source_code,17,3) like '45%' or substr (source_code,17,3) like '46%' or substr(source_code,17,3) like '47%' or substr(source_code,17,3) like '48%' or substr (source_code,17,3) like '49%')";
			else if (frm.getAssetType().equals("04")) {
				codeSeries = "(substr(source_code,17,3) like '0%' or substr (source_code,17,3) like '1%' or substr(source_code,17,3) like '2%')";
			} else if (frm.getAssetType().equals("05"))
				codeSeries = "substr(source_code,17,3) like '3%'";
			else if (frm.getAssetType().equals("06"))
				codeSeries = "substr(source_code,17,3) like '5%'";
			else if (frm.getAssetType().equals("07"))
				codeSeries = "substr(source_code,17,3) like '7%'";
			else if (frm.getAssetType().equals("08"))
				codeSeries = "substr(source_code,17,3) like '9%'";

			Debug.println("codeSeries<<<<<<<<<<<<<<" + codeSeries);
			Debug.println("ConnCount is<<<<< " + connCount);
			String testingtype = "";
			double maxvalue = 0.0;
			double entervalue = 0.0;
			String mess = "";
			int res = 0;
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "select distinct source_code,nvl(asset_name,'-'),to_char(prepared_on,'dd/mm/yyyy'),TESTING_PARAMETER_CODE, TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_VALUE,TESTING_PARAMETER_VALUE from wqassetview where  type_of_asset_code='"
					+ frm.getAssetType()
					+ "' and  "
					+ codeSeries
					+ " and circle_office_code='"
					+ frm.getCircleCode()
					+ "' and division_office_code='"
					+ frm.getDivisionCode()
					+ "' and subdivision_office_code='"
					+ frm.getSubdivisionCode()
					+ "'  and to_date(prepared_on)>='1-APR-"
					+ year
					+ "' and  to_date(prepared_on)<'31-MAR-" + year1 + "' ";

			Debug.println("year<<<<<<<<<<<<<<" + query);
			rs = stmt.executeQuery(query);
			Debug.println("Query***********for cviewto display details***"
					+ query);

			while (rs.next()) {

				WQAssetForm frm1 = new WQAssetForm();
				if (rs.getString(4).equals("04")) {
					testingtype = rs.getString(4);
					Debug.println("testingtype<<<<<<<<<<<<<<<" + testingtype);
					maxvalue = rs.getDouble(7);
					Debug.println("maxvalue<<<<<<<<<<<<<<<" + maxvalue);
					entervalue = rs.getDouble(8);
					Debug.println("entervalue<<<<<<<<<<<<<<<" + entervalue);

					if (entervalue > maxvalue) {
						frm1.setSourceCode(rs.getString(1));
						frm1.setPreparedDate(rs.getString(3));
						frm1.setParameter4(rs.getString(5));
						frm1.setParameter1(rs.getString(6));
						frm1.setParameter2(rs.getString(7));
						frm1.setParameter3(rs.getString(8));
						mess = "Contaminated";
						Debug.println("message<<<<<<<<<<<<<<<" + mess);
						res = res + 1;
						Debug.println("result<<<<<<<<<<<<<<<" + res);
						sources.add(frm1);

					}
				}
				if (rs.getString(4).equals("12")) {
					testingtype = rs.getString(4);
					Debug.println("testingtype<<<<<<<<<<<<<<<" + testingtype);
					maxvalue = rs.getDouble(7);
					Debug.println("maxvalue<<<<<<<<<<<<<<<" + maxvalue);
					entervalue = rs.getDouble(8);
					Debug.println("entervalue<<<<<<<<<<<<<<<" + entervalue);

					if (entervalue > maxvalue) {
						frm1.setSourceCode(rs.getString(1));
						frm1.setPreparedDate(rs.getString(3));
						frm1.setParameter4(rs.getString(5));
						frm1.setParameter1(rs.getString(6));
						frm1.setParameter2(rs.getString(7));
						frm1.setParameter3(rs.getString(8));
						mess = "Contaminated";
						Debug.println("message<<<<<<<<<<<<<<<" + mess);
						res = res + 1;
						Debug.println("result<<<<<<<<<<<<<<<" + res);
						sources.add(frm1);

					}
				}
				if (rs.getString(4).equals("12")) {
					testingtype = rs.getString(4);
					Debug.println("testingtype<<<<<<<<<<<<<<<" + testingtype);
					maxvalue = rs.getDouble(7);
					Debug.println("maxvalue<<<<<<<<<<<<<<<" + maxvalue);
					entervalue = rs.getDouble(8);
					Debug.println("entervalue<<<<<<<<<<<<<<<" + entervalue);

					if (entervalue > maxvalue) {
						frm1.setSourceCode(rs.getString(1));
						frm1.setPreparedDate(rs.getString(3));
						frm1.setParameter4(rs.getString(5));
						frm1.setParameter1(rs.getString(6));
						frm1.setParameter2(rs.getString(7));
						frm1.setParameter3(rs.getString(8));
						mess = "Contaminated";
						Debug.println("message<<<<<<<<<<<<<<<" + mess);
						res = res + 1;
						Debug.println("result<<<<<<<<<<<<<<<" + res);
						sources.add(frm1);

					}
				}
				if (rs.getString(4).equals("13")) {

					maxvalue = rs.getDouble(7);
					Debug.println("maxvalue<<<<<<<<<<<<<<<" + maxvalue);
					entervalue = rs.getDouble(8);
					Debug.println("entervalue<<<<<<<<<<<<<<<" + entervalue);

					if (entervalue > maxvalue) {
						frm1.setSourceCode(rs.getString(1));
						frm1.setPreparedDate(rs.getString(3));
						frm1.setParameter4(rs.getString(5));
						frm1.setParameter1(rs.getString(6));
						frm1.setParameter2(rs.getString(7));
						frm1.setParameter3(rs.getString(8));
						mess = "Contaminated";
						Debug.println("message<<<<<<<<<<<<<<<" + mess);
						res = res + 1;
						Debug.println("result<<<<<<<<<<<<<<<" + res);
						sources.add(frm1);

					}
				}

				// (04,12,13,15,06,05,07,13,16)
				continue;
			}

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in getBaseLine=" + e);
		} finally {
			// wqasstdata.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return sources;
	}

	//
	private boolean isExists1(ArrayList sources, String source, String testid) {

		ResultSet rs1 = null;
		Statement pstmt = null;
		try {
			conn = RwsOffices.getConn();
			pstmt = conn.createStatement();
			rs1 = null;
			WQAssetForm f1 = null;

			String query = "";
			for (int i = 0; i < sources.size(); i++) {
				f1 = new WQAssetForm();

			}
			Debug.println("QueryinisExists************************:" + query);
			rs1 = pstmt.executeQuery(query);

			if (rs1.next())
				return true;
			else
				return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs1 != null) {
					rs1.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception p) {
				p.printStackTrace();
			}
		}

		return false;
	}

	//
	public ArrayList getTestedContaminatedSourcedetails(WQAssetForm frm,
			String year, int year1, String asset,String testcode) throws Exception {
		ArrayList sources = new ArrayList();
		String codeSeries = "";
		WQAssetData wqasstdata = new WQAssetData();
		String query = "";
		String query1 = "";
		Statement stmt1 = null;
		Statement st1=null;
		ResultSet rs10=null;
		ResultSet rs1 = null;
		WQAssetData wqassetData = new WQAssetData();

		Debug.println("year1inside method<<<<<<<<<<<<<<");
		try {
			//

			if (frm.getAssetType().equals("HP")) {
				codeSeries = "substr(source_code,20,2)='HP'";
			} else if (frm.getAssetType().equals("SO")) {
				codeSeries = "substr(source_code,20,2)='SO'";
			} else if (frm.getAssetType().equals("OW")) {
				codeSeries = "substr(source_code,20,2)='OW'";
			} else if (frm.getAssetType().equals("SH")) {
				codeSeries = "substr(source_code,20,2)='SH'";
			} else if (frm.getAssetType().equals("PD")) {
				codeSeries = "substr(source_code,20,2)='PD'";
			}

			Debug.println("codeSeries<<<<<<<<<<<<<<" + codeSeries);
			Debug.println("ConnCount is<<<<< " + connCount);
			String testingtype = "";
			double maxvalue = 0.0;
			double entervalue = 0.0;
			double m1 = 0.0;
			double e1 = 0.0;
			String mess = "";
			String query2="";
			String query3="";

			int res = 0;
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			

			// existing
			// query="select distinct source_code,test_id,MAX_PERMISSIBLE_VALUE,testing_parameter_name,to_char(prepared_on,'dd/mm/yyyy'),testing_parameter_code,nvl(potable,'-'),MIN_PERMISSIBLE_VALUE from wqassetview where  type_of_asset_code='"+frm.getAssetType()+"' and  "+codeSeries+" and circle_office_code='"+frm.getCircleCode()+"' and division_office_code='"+frm.getDivisionCode()+"' and subdivision_office_code='"+frm.getSubdivisionCode()+"'  and to_date(prepared_on)>='1-APR-"+year+"' and  to_date(prepared_on)<'31-MAR-"+year1+"' "
			// ;
			if(testcode!= null && testcode.equals("1"))
			{
			query = "select  source_code,test_id,testing_parameter_name,to_char(prepared_on,'dd/mm/yyyy'),testing_parameter_code,MAX_PERMISSIBLE_VALUE from wqassetview where   circle_office_code='"
					+ frm.getCircleCode()
					+ "' and division_office_code='"
					+ frm.getDivisionCode()
					+ "' and subdivision_office_code='"
					+ frm.getSubdivisionCode()
					+ "' and "
					+ codeSeries
					+ " and to_date(prepared_on)>='1-APR-"
					+ year
					+ "' and  to_date(prepared_on)<'31-MAR-"
					+ year1
					+ "' and test_code='"+testcode+"' order by test_id ";

			Debug.println("year<<<<<<<<<<<<<<" + query);
			rs = stmt.executeQuery(query);
			Debug.println("Query***********for cviewto display details***"
					+ query);

			while (rs.next()) {

				maxvalue = Double.parseDouble(rs.getString(6));
				// maxvalue=rs.getDouble(4);
				Debug.println("<<<<<<<<<<<<<<<<<<<inquerywhilefirst" + maxvalue);
				query1 = "select testing_parameter_code,testing_parameter_value from rws_wq_test_results_lnk_tbl  where test_id='"
						+ rs.getString(2)
						+ "' and testing_parameter_code='"
						+ rs.getString(5)
						+ "' and testing_parameter_code  in (04,12,13,15,06,05,07,13,16)";
				Debug.println("" + query1);
				rs1 = stmt1.executeQuery(query1);
				while (rs1.next()) {
					// entervalue=Double.parseDouble(rs1.getString(2));
					Debug.println("entervalue<<<<<<<<<<<<<<<<<<<inquerywhilefirst"
							+ entervalue);
					WQAssetForm frm1 = new WQAssetForm();

					if (rs1.getString(1).equals("04")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));

							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code

							sources.add(frm1);

							// break;
						}
					}

					//
					else if (rs1.getString(1).equals("15")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
								//	rs.getString(2))) {
								frm1.setSourceCode(rs.getString(1));
								frm1.setTestId(rs.getString(2));
							//}else{
								//frm1.setSourceCode("");
								//frm1.setTestId("");
						//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code
							sources.add(frm1);

							// break;
						}
					} else if (rs1.getString(1).equals("06")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code
							sources.add(frm1);

							// break;
						}
					} else if (rs1.getString(1).equals("05")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code
							sources.add(frm1);

							// break;
						}
					} else if (rs1.getString(1).equals("07")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code
							sources.add(frm1);

							// break;
						}
					} else if (rs1.getString(1).equals("13")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code

							sources.add(frm1);

							// break;
						}
					} else if (rs1.getString(1).equals("13")) {
						if (rs1.getDouble(2) > maxvalue) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							//if (!isExists(sources, rs.getString(1),
							//	rs.getString(2))) {
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
						//}else{
							//frm1.setSourceCode("");
							//frm1.setTestId("");
					//}
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
																// code
							sources.add(frm1);

							// break;
						}
					}
				}

			}

			//
			}			//if close
			else if(testcode != null && testcode.equals("2"))
			{
			//for else
				query = "select  source_code,test_id,testing_parameter_name,to_char(prepared_on,'dd/mm/yyyy'),testing_parameter_code,MAX_PERMISSIBLE_VALUE from wqassetview1 where   circle_office_code='"
					+ frm.getCircleCode()
					+ "' and division_office_code='"
					+ frm.getDivisionCode()
					+ "' and subdivision_office_code='"
					+ frm.getSubdivisionCode()
					+ "' and "
					+ codeSeries
					+ " and to_date(prepared_on)>='1-APR-"
					+ year
					+ "' and  to_date(prepared_on)<'31-MAR-"
					+ year1
					+ "' and test_code='2' order by test_id ";

			Debug.println("year<<<<<<<<<<<<<<" + query);
			rs = stmt.executeQuery(query);
			Debug.println("inelse query<<<<<<<<<<<<<"
					+ query);

			while (rs.next()) {

				
				query1 = "select a.testing_parameter_code,a.testing_parameter_value from rws_wq_test_results_lnk_tbl a where  a.test_id='"
						+ rs.getString(2)
						+ "' and a.testing_parameter_code='"
						+ rs.getString(5)
						+ "' ";
				Debug.println("" + query1);
				rs1 = stmt1.executeQuery(query1);
				while (rs1.next()) {
					
					WQAssetForm frm1 = new WQAssetForm();

					if (rs1.getString(1).equals("02")) {
						if (rs1.getDouble(2) > 0) {
							 wqassetData.getExistingData(frm1,rs.getString(2),rs.getString(1),rs.getString(5));
							frm1.setSourceCode(rs.getString(1));
							frm1.setTestId(rs.getString(2));
							frm1.setPreparedDate(rs.getString(4));
							frm1.setParameter4(rs.getString(3));
							frm1.setParameter1(rs.getString(5));// Parameter
							sources.add(frm1);

							
						}
					}
				}
			}
				
			}
		

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in getBaseLine=" + e);
		} finally {

			if (rs1 != null) {
				rs1.close();
			}
			if (stmt1 != null) {
				stmt1.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			Debug.println("ConnCount after closing is " + connCount);
		}
		return sources;
	}

	/**
	 * 
	 * @param sources
	 * @param string
	 * @param string2
	 * @return
	 */
	private boolean isExists(ArrayList sources, String sourceCode, String testId) {

		boolean flag = false;

		for (int i = 0; i < sources.size(); i++) {

			WQAssetForm bean = (WQAssetForm) sources.get(i);

			if (bean.getSourceCode().equals(sourceCode)) {
				return true;
			}

		}

		return flag;

	}

	//
	public String getServerDate() {
		Debug.println("in getServerDate methodddddddddddddddddddddd");
		String serverDate = "";
		try {
			String query = "";
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			query = "select to_char(sysdate,'dd/mm/yyyy') from dual";
			Debug.println("qry in get getServerDate:" + query);
			rset = stmt.executeQuery(query);
			tenderMemo tenderMemoBean = null;
			String total = "0";
			if (rset.next()) {
				serverDate = rset.getString(1);
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
		return serverDate;

	}

	//
	private void getExistingData(WQAssetForm dr, String testid,
			String sourcecode, String parametercode) {

		WQAssetData wqassetData = new WQAssetData();

		try {
			wqassetData.conn = RwsOffices.getConn();

			wqassetData.stmt1 = wqassetData.conn.createStatement();

			String qq = "select test_id,source_code,action_taken,remarks,parameter_code from rws_sources_con_rem_tbl where test_id='"
					+ testid
					+ "' and source_code='"
					+ sourcecode
					+ "' and parameter_code='" + parametercode + "'";
			Debug.println("3333:" + qq);
			wqassetData.rs1 = wqassetData.stmt1.executeQuery(qq);

			while (wqassetData.rs1.next()) {

				dr.setTestId(wqassetData.rs1.getString(1));
				dr.setSourceCode(wqassetData.rs1.getString(2));
				dr.setActionTaken(wqassetData.rs1.getString(3));
				dr.setRemarks(wqassetData.rs1.getString(4));
				dr.setParameter1(wqassetData.rs1.getString(5));

				dr.setChecks("on");

			}
		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	//

	// ******
	public int saveRemarks(ArrayList resultData) throws Exception {
		int count = 0;

		WQAssetData wqAssetdata = new WQAssetData();

		try {
			Connection conn = null;
			conn = RwsOffices.getConn();
			String query = "";
			String serdate = wqAssetdata.getServerDate();
			Debug.println("Server Date***********" + serdate);
			Statement pstmt = conn.createStatement();
			ResultSet rs1 = null;

			int i = 0;
			for (i = 0; i < resultData.size(); i++) {

				WQAssetForm dr = (WQAssetForm) resultData.get(i);

				if (!isExists(dr)) {

					query = "insert into rws_sources_con_rem_tbl(TEST_ID,SOURCE_CODE,action_taken,REMARKS,PARAMETER_CODE,UPDATE_DATE  ) "
							+ " values ('"
							+ dr.getTestId()
							+ "','"
							+ dr.getSourceCode()
							+ "','"
							+ dr.getActionTaken()
							+ "','"
							+ dr.getRemarks()
							+ "','"
							+ dr.getParameter1()
							+ "',to_date('"
							+ serdate
							+ "','dd/mm/yyyy'))";

					Debug.println("*****<<<<<<<<<<<<<<<<<<<<<<<<<******in insert in rws_sources_con_rem_tbl"
							+ query);

					count = pstmt.executeUpdate(query);
				} else {
					query = "update rws_sources_con_rem_tbl set action_taken='"
							+ dr.getActionTaken() + "' , remarks='"
							+ dr.getRemarks() + "',update_date=to_date('"
							+ serdate + "','dd/mm/yyyy') where test_id='"
							+ dr.getTestId() + "' and source_code='"
							+ dr.getSourceCode() + "' and parameter_code='"
							+ dr.getParameter1() + "'";

					Debug.println("*****<<<<<<<<<<<<<<<<<<<<<<<<<******in update in rws_sources_con_rem_tbl"
							+ query);

					count = pstmt.executeUpdate(query);

				}
				Debug.println("count************inupdate" + count);
				if (count > 0) {

					conn.commit();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;

	}

	//
	public String getAssetdetails(WQAssetForm frm, String asset, String year,
			int year1) throws Exception {
		ArrayList habs = new ArrayList();
		WQAssetData wqassetData = new WQAssetData();
		String query = "";
		String count = "";
		try {
			Debug.println("ConnCount is " + connCount);
			wqassetData.conn = RwsOffices.getConn();
			wqassetData.stmt = wqassetData.conn.createStatement();
			query = "select count(*)  from rws_asset_mast_tbl where asset_status='1'  and type_of_asset_code='"
					+ asset
					+ "' and to_date(DATE_CREATION)>='1-APR-"
					+ year
					+ "' and  to_date(DATE_CREATION)<'31-MAR-" + year1 + "'";
			query += "order by 1";

			wqassetData.rs = wqassetData.stmt.executeQuery(query);
			Debug.println("Query***********for cviewto display details***"
					+ query);

			while (wqassetData.rs.next()) {

				count = wqassetData.rs.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in assetcount" + e);
		} finally {
			wqassetData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return count;
	}

	//
	public String getAssetNames(WQAssetForm frm, String asset) throws Exception {
		ArrayList habs = new ArrayList();
		WQAssetData wqassetData = new WQAssetData();
		String query = "";
		String name = "";
		try {
			Debug.println("ConnCount is " + connCount);
			wqassetData.conn = RwsOffices.getConn();
			wqassetData.stmt = wqassetData.conn.createStatement();
			query = "select type_of_asset_name  from rws_asset_type_tbl where type_of_asset_code='"
					+ asset + "'";
			query += "order by 1";

			wqassetData.rs = wqassetData.stmt.executeQuery(query);
			Debug.println("Query***********for cviewto display details***"
					+ query);

			while (wqassetData.rs.next()) {

				name = wqassetData.rs.getString(1);

			}

		} catch (Exception e) {
			e.printStackTrace();
			Debug.println("The error in asset" + e);
		} finally {
			wqassetData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return name;
	}

	//
	private boolean isExists(WQAssetForm dr) {

		try {
			conn = RwsOffices.getConn();
			Statement pstmt = conn.createStatement();
			ResultSet rs1 = null;

			String query = "select * from  rws_sources_con_rem_tbl where test_id='"
					+ dr.getTestId()
					+ "' and source_code='"
					+ dr.getSourceCode()
					+ "'and parameter_code='"
					+ dr.getParameter1() + "'";
			System.out.println("Query************************:" + query);
			rs1 = pstmt.executeQuery(query);

			if (rs1.next())
				return true;
			else
				return false;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	// Added
	public ArrayList getCircles(DataSource dataSource) throws Exception {
		ArrayList circles;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		circles = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d  order by d.circle_office_name";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Query*********" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				circles.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return circles;
	}

	//
	public ArrayList getAssettypes(DataSource dataSource) throws Exception {
		ArrayList assettypes;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		assettypes = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  type_of_asset_code,type_of_asset_name from rws_asset_type_tbl where type_of_asset_code not in(12,11,10,08) order by type_of_asset_name";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Query*********" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				assettypes.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return assettypes;
	}

	//
	public ArrayList getTesttypes(DataSource dataSource) throws Exception {
		ArrayList assettypes;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		assettypes = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  test_code,test_name from RWS_WATER_QUALITY_TEST_TBL where test_code<>'3' order by test_code";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Queryin testtypes<<<<<<<<<<<<<<<<<<*********" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				assettypes.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return assettypes;
	}

	//
	public ArrayList getReasontypes(DataSource dataSource,String testcode) throws Exception {
		ArrayList assettypes;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		assettypes = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  test_code,test_reason from rws_wq_reasons_tbl where test_code='"+testcode+"' order by test_code";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Queryin testreasons<<<<<<<<<<<<<<<<<<*********" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				assettypes.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return assettypes;
	}


	//
	public ArrayList getDivisions(DataSource dataSource, String cir)
			throws Exception {
		ArrayList divisions;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		divisions = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  d.division_office_code,d.division_office_name from rws_division_office_tbl d  where status <> 'UI' and d.circle_office_code='"
					+ cir + "' order by d.division_office_name";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Query*********" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				divisions.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return divisions;
	}

	//

	//
	public ArrayList getExpYears() throws Exception {
		ArrayList years = new ArrayList();
		java.text.DateFormat dateFormat = new java.text.SimpleDateFormat(
				"yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String currentYear = dateFormat.format(currentDate).substring(0, 4);
		int currentYears = Integer.parseInt(currentYear);
		Debug.println("currentyears<<<<<<<<<<<<<<<<<<*****8" + currentYears);
		try {
			for (int i = currentYears; i >= 2009; i--) {
				int j = i;
				j++;
				// nic.watersoft.commons.Debug.println(i+" - "+j);

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue("" + i);
				labelValueBean.setLabel(i + " - " + j);
				labelValueBean.setLabelValue(i + " - " + j + " - " + i);
				years.add(labelValueBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}

		return years;
	}

	//

	public ArrayList getSubDivisions(DataSource dataSource, String cir,
			String div) throws Exception {
		ArrayList subdivisions;
		String query = "";
		WQAssetData wqassetData = new WQAssetData();
		LabelValueBean wqassetForm = null;
		subdivisions = new ArrayList();
		PreparedStatement ps = null;

		try {

			wqassetData.conn = RwsOffices.getConn();

			query = "select  d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d  where d.circle_office_code='"
					+ cir
					+ "' and d.division_office_code='"
					+ div
					+ "'  order by d.subdivision_office_name";
			ps = wqassetData.conn.prepareStatement(query);

			wqassetData.rs = ps.executeQuery();

			Debug.println("Query<<<<<<<<<<<<<<" + query);
			while (wqassetData.rs.next()) {
				wqassetForm = new LabelValueBean();
				wqassetForm.setValue(wqassetData.rs.getString(1));
				wqassetForm.setLabel(wqassetData.rs.getString(2));
				wqassetForm.setLabelValue(wqassetData.rs.getString(2) + " - "
						+ wqassetData.rs.getString(1));
				subdivisions.add(wqassetForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getWQAssetMasters=" + e);
			e.printStackTrace();
		} finally {
			wqassetData.closeAll();

		}
		return subdivisions;
	}

}// end of main class

//

