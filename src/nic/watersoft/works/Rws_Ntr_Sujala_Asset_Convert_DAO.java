package nic.watersoft.works;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import com.ibm.icu.text.SimpleDateFormat;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.drought.DroughtBean;
import nic.watersoft.drought.DroughtHabitationRecords;
import nic.watersoft.drought.DroughtMasterData;
import nic.watersoft.masters.HabitationNewEntry_Form;
import nic.watersoft.masters.RwsHPRecord;

public class Rws_Ntr_Sujala_Asset_Convert_DAO {

	Connection conn = null;
	Statement stmt = null;
	String query = "";
	PreparedStatement pstat = null;
	ResultSet rset = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	ResultSet rset1 = null;

	public ArrayList getCircles(Connection conn) throws Exception {
		ArrayList circles;
		String query = "";

		LabelValueBean assetForm = null;
		circles = new ArrayList();

		try {

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
			Debug.println("exception in getCircles of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getCircles of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return circles;
	}

	public ArrayList getMandals(String dcode, Connection conn) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		LabelValueBean labelValueBean = null;
		try {
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
			System.out.println("The exception  in getMandals()=== Rws_Ntr_Sujala_Asset_Convert_DAO " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getMandals of Rws_Ntr_Sujala_Asset_Convert_DAO finally = " + e2);
			}
		}
		return mandals;
	}

	public ArrayList getYears(String dcode, String mcode, Connection conn) throws Exception {
		ArrayList years = new ArrayList();
		String query = null;
		LabelValueBean labelValueBean = null;
		try {
			query = "select  distinct to_char(IMPLEMENTATION_DT,'yyyy') from RWS_NTR_SUJALA_HAB_IMPL_TBL where "
					+ "substr(HABITATION_CODE,1,2)=? and substr(HABITATION_CODE,6,2)=?   order by to_char(IMPLEMENTATION_DT,'yyyy') "
					+ "desc";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(1));
				years.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The exception  in getYears()=== Rws_Ntr_Sujala_Asset_Convert_DAO " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getYears of Rws_Ntr_Sujala_Asset_Convert_DAO finally = " + e2);
			}
		}
		return years;
	}

	public ArrayList getHabitations(String dcode, String mcode, Connection conn, String year) throws Exception {
		ArrayList habs = new ArrayList();
		Rws_Ntr_Sujala_Asset_Convert_Form frm = null;
		String query = "", query1 = "";
		PreparedStatement ps = null, ps1 = null;
		try {

			Statement stmt1 = conn.createStatement();
			query = "select distinct hab_code,panch_name,coverage_status,(census_plain_popu+census_sc_popu+census_st_popu) as popu  from "
					+ "rws_ntr_sujala_master_tbl a ,rws_complete_hab_view b where a.hab_code=b.panch_code and b.dcode=? and "
					+ "b.mcode=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);

			rset = ps.executeQuery();

			while (rset.next()) {
				query1 = "select PLANT_TYPE_INSTALLED,  PLANT_CAPACITY , INSTALLATION_AGENCY_TYPE,  "
						+ "INSTALLATION_AGENCY_NAME,  MAINTENANCE_AGENCY_TYPE,  MAINTENANCE_AGENCY_NAME,"
						+ "to_char(IMPLEMENTATION_DT,'DD/MM/YYYY') as IMPLEMENTATION_DT,nvl(ASSET_CODE,'--') as ASSET_CODE,"
						+ "nvl(WTPSC_CODE,'--') as WTPSC_CODE,"
						+ "decode(PLANT_TYPE_INSTALLED,'RO','RO','EDF','ED','TERRAFIL','TF','NANOTECHNOLOGY ','NT','ULTRAFILTRATION','UF','UV','UV') as typeOfPlant"
						+ "  from rws_NTR_SUJala_HAB_IMPL_TBL  where habitation_code=?  and EXTRACT(YEAR FROM IMPLEMENTATION_DT)=? ";

				ps1 = conn.prepareStatement(query1);
				ps1.setString(1, rset.getString(1));
				ps1.setString(2, year);
				rset1 = ps1.executeQuery();

				while (rset1.next()) {
					frm = new Rws_Ntr_Sujala_Asset_Convert_Form();
					frm.setHabCode(rset.getString(1));
					frm.setHabName(rset.getString(2));
					frm.setHabstatus(rset.getString(3));
					frm.setHabPop(rset.getString(4));
					frm.setSplantType(rset1.getString("typeOfPlant"));
					frm.setPlantType(rset1.getString(1));
					frm.setPlantCapacity(rset1.getString(2));
					frm.setAgencyType(rset1.getString(3));
					frm.setInstAgencyName(rset1.getString(4));
					frm.setMaintenanceType(rset1.getString(5));
					frm.setMainAgencyName(rset1.getString(6));
					frm.setImplDate(rset1.getString("IMPLEMENTATION_DT"));
					if (rset1.getString("ASSET_CODE").equals("--") && rset1.getString("WTPSC_CODE").equals("--")) {
						frm.setConvStatus("Y");
					} else {
						frm.setConvStatus("N");
					}
					habs.add(frm);
				}

			}
		} catch (Exception e) {
			System.out.println("exception in  getHabitations of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getHabitations of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);

			}
		}
		return habs;
	}

	public static boolean isExistsAsset(Rws_Ntr_Sujala_Asset_Convert_Form frm, Connection conn) {
		boolean exists;
		exists = false;
		String query = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {

			query = "select * from RWS_ASSET_MAST_TBL where asset_code=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, frm.getAssetCode());

			rs = stmt.executeQuery();
			if (rs.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
			System.out.println("exception in  isExistsAsset of Rws_Ntr_Sujala_Asset_Convert_DAO=  " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in isExistsAsset of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}

		return exists;
	}

	public String getAssetCode(String assetCode, Connection conn) {
		String assetCode1 = "";
		String query = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			query = "select asset_code from rws_NTR_SUJala_HAB_IMPL_TBL where substr(asset_code,1,10)=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, assetCode);
			rs = stmt.executeQuery();
			if (rs.next()) {
				assetCode1 = rs.getString("asset_code");
			} else {
				assetCode1 = assetCode;
			}
		} catch (Exception e) {
			System.out.println("exception in  getAssetCode of Rws_Ntr_Sujala_Asset_Convert_DAO=  " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getAssetCode of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return assetCode1;
	}

	public static boolean isExistsSource(Rws_Ntr_Sujala_Asset_Convert_Form frm, Connection conn) {
		boolean exists;
		exists = false;
		String query = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {

			query = "select * from RWS_AST_WTP_SC_PARAM_TBL where asset_code='" + frm.getAssetCode()
					+ "' and WTPSC_CODE=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, frm.getSourceCode());
			rs = stmt.executeQuery();
			if (rs.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
			System.out.println("exception in  isExistsSource of Rws_Ntr_Sujala_Asset_Convert_DAO=  " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in isExistsSource of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}

		return exists;
	}

	public String getAssetCodeGen(String astCode, Connection conn) {
		String assetCode = "";
		try {
			query = "SELECT max(to_number(substr(ASSET_CODE,11,4)))+1  FROM RWS_ASSET_MAST_TBL where substr (asset_code,1,10)=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, astCode);
			rs = ps.executeQuery();
			rs.next();
			assetCode = rs.getString(1);
			if (assetCode == null) {
				assetCode = "0001";
			} else if (assetCode.length() == 1) {
				assetCode = "000" + assetCode;
			} else if (assetCode.length() == 2) {
				assetCode = "00" + assetCode;
			} else if (assetCode.length() == 3) {
				assetCode = "0" + assetCode;
			}
			assetCode = astCode + assetCode;

		} catch (Exception e) {
			System.out.println("exception in  getAssetCodeGen of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getAssetCodeGen of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return assetCode;
	}

	public String getShortSchemeCode(String habCode, Connection conn) {

		String shortSchemeCode = "";
		try {

			String query = "";

			query = "select max(substr(s.scheme_code,17,3)) from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where "
					+ " a.asset_code=s.asset_code and a.type_of_asset_code='08' and a.hab_code=? order by s.scheme_code";

			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			rset = ps.executeQuery();
			while (rset.next()) {
				if (rset.getString(1) != null)
					shortSchemeCode = "" + (Integer.parseInt(rset.getString(1)) + 1);
			}
			if (shortSchemeCode.equals("")) {

				query = "select code_series from rws_asset_type_tbl where type_of_asset_code='08'";
				pstat = conn.prepareStatement(query);
				rset1 = pstat.executeQuery();
				while (rset1.next()) {
					if (rset1.getString(1) != null)
						shortSchemeCode = "" + (rset1.getString("code_series"));
				}
			}
			if (shortSchemeCode.length() == 1)
				shortSchemeCode = "00" + shortSchemeCode;
			else if (shortSchemeCode.length() == 2)
				shortSchemeCode = "0" + shortSchemeCode;
		} catch (Exception e) {
			System.out.println("Exception in getShortSchemeCode of Rws_Ntr_Sujala_Asset_Convert_DAO --  " + e);
		}
		try {
			if (ps != null) {
				ps.close();
			}
			if (rset != null) {
				rset.close();
			}
			if (pstat != null) {
				pstat.close();
			}
			if (rset1 != null) {
				rset1.close();
			}
		} catch (Exception e2) {
			Debug.println("exception in getShortSchemeCode of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);

		}

		return shortSchemeCode;
	}

	public String getSourceCodeGen(String habCode, String shortSchemeCode, String typeOfPlant, Connection conn) {
		String SourceCode = "";
		String slNo = null;
		try {

			query = "SELECT MAX(to_number(substr(WTPSC_CODE,22,3)))+1 FROM RWS_AST_WTP_SC_PARAM_TBL where "
					+ "substr(WTPSC_CODE,1,16)=? and substr(WTPSC_CODE,17,3)=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, habCode);
			ps.setString(2, shortSchemeCode);
			rs = ps.executeQuery();

			if (rs.next()) {
				slNo = rs.getInt(1) + "";
				if (slNo == null || slNo.equals("0") || slNo.equals("")) {
					slNo = "001";
				} else if (slNo.length() == 1) {
					slNo = "00" + slNo;
				} else if (slNo.length() == 2) {
					slNo = "0" + slNo;
				}
			}
			SourceCode = habCode + shortSchemeCode + typeOfPlant + slNo;

		} catch (Exception e) {
			System.out.println("exception in  getSourceCodeGen of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getSourceCodeGen of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return SourceCode;
	}

	public String saveAssetSource(Rws_Ntr_Sujala_Asset_Convert_Form frm, Connection conn, String targetPath,
			ActionServlet actionServlet) throws Exception {
		int count[] = {};
		FileOutputStream outputStream = null;
		FormFile formFile = null;
		FileInputStream fis = null;
		File scannedFile = null;
		File targetFile = null;
		String message = "";
		PreparedStatement preparedStatement = null;
		String imageQuery = "";
		try {

			Statement pstmt = conn.createStatement();

			String doc = getDivisionOfficeCodeFromMandal(frm.getHabCode().substring(0, 2),
					frm.getHabCode().substring(5, 7), conn);
			String sdoc = getSubDivisionOfficeCodeFromMandal(frm.getHabCode().substring(0, 2),
					frm.getHabCode().substring(5, 7), conn);

			conn.setAutoCommit(false);

			if (isExistsAsset(frm, conn)) {

				query = "update rws_asset_mast_tbl  set ASSET_NAME ='" + frm.getAssetName() + "'" + " , LOCATION ='"
						+ frm.getLocation() + "' , ASSET_STATUS ='" + frm.getAssetStatus() + "'" + " , ASSET_COST ='"
						+ frm.getAssetCost() + "'" + " , UPDATE_DATE =sysdate where ASSET_CODE='" + frm.getAssetCode()
						+ "' ";
				pstmt.addBatch(query);

				query = "insert into RWS_ASSET_HAB_TBL (ASSET_CODE,HAB_CODE) values('" + frm.getAssetCode() + "','"
						+ frm.getHabCode() + "')";
				pstmt.addBatch(query);
			}

			else {
				query = "insert into rws_asset_mast_tbl (ASSET_CODE,ASSET_NAME,TYPE_OF_ASSET_CODE,HAB_CODE,LOCATION,DATE_CREATION,ASSET_STATUS,ASSET_COST,START_YEAR,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,UPDATE_DATE) "
						+ " values('" + frm.getAssetCode() + "','" + frm.getAssetName() + "','" + frm.getAssetType()
						+ "','" + frm.getHabCode() + "','" + frm.getLocation() + "',to_date('" + frm.getDateCreation()
						+ "','dd/mm/yyyy'),'" + frm.getAssetStatus() + "','" + frm.getAssetCost() + "','"
						+ frm.getStartYear() + "','" + frm.getHabCode().substring(0, 2) + "','" + doc + "','" + sdoc
						+ "',sysdate)";

				pstmt.addBatch(query);

				query = "insert into RWS_ASSET_SCHEME_TBL values('" + frm.getAssetCode() + "','"
						+ frm.getSourceCode().substring(0, 19) + "')";
				pstmt.addBatch(query);

				query = "insert into RWS_ASSET_HAB_TBL (ASSET_CODE,HAB_CODE) values('" + frm.getAssetCode() + "','"
						+ frm.getHabCode() + "')";
				pstmt.addBatch(query);

			}
			if (isExistsSource(frm, conn)) {

				query = "update RWS_AST_WTP_SC_PARAM_TBL  set  LOCATION ='" + frm.getSourceLocation() + "' , WTP_MLD ='"
						+ frm.getCapacity() + "'" + " , UNITS_NO ='" + frm.getNoofUnits() + "' ,USE_CAPACITYMLD='"
						+ frm.getNoOfHoursUsage() + "'" + " , UNITS_STANDBY ='" + frm.getNoofStandByUnits()
						+ "' ,RWS_TANK_EXISTING='" + frm.getRawWaterStorageTankExisting() + "'"
						+ " , PWS_TANK_EXISTING ='" + frm.getProductWaterStorageTankExisting() + "' ,SHELTER_EXISTING='"
						+ frm.getShelterExisting() + "'" + " , STATUS='" + frm.getCompStatus() + "' ,COMP_COST='"
						+ frm.getCompCost() + "',LATITUDE='" + frm.getLatitude() + "',LONGITUDE='" + frm.getLongitude()
						+ "',ELEVATION='" + frm.getElivation() + "',WAY_POINT='" + frm.getWayPoint()
						+ "',AVE_CANS_SUPPLIED='" + frm.getAveCanSupplied() + "' " + "  where WTPSC_CODE='"
						+ frm.getSourceCode() + "' and ASSET_CODE='" + frm.getAssetCode() + "' ";

				pstmt.addBatch(query);

				if (getImageStatus(frm.getSourceCode(), conn).equals("Yes")) {
					imageQuery = "update RWS_ASSET_COMPONENT_IMAGE_TBL set COMPO_IMAGE=?,COMPO_LAT=?,COMPO_LON=?,UPDATE_DATE=sysdate,MOBILE=?,TYPE=? where ASSET_CODE=? and ASSET_COMPONENT=?";
				} else {
					imageQuery = "insert into RWS_ASSET_COMPONENT_IMAGE_TBL(COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,ASSET_CODE,ASSET_COMPONENT) values(?,?,?,sysdate,?,?,?,?) ";
				}
			}

			else {
				query = "insert into RWS_AST_WTP_SC_PARAM_TBL (WTPSC_CODE,asset_code,WTP_TYPW,LOCATION,WTP_MLD,HAB_CODE,UNITS_NO,USE_CAPACITYMLD,UNITS_STANDBY,RWS_TANK_EXISTING,PWS_TANK_EXISTING,SHELTER_EXISTING,SCHEME_DONOR,STATUS,COMP_COST,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,AVE_CANS_SUPPLIED)"
						+ " values('" + frm.getSourceCode() + "','" + frm.getAssetCode() + "','" + frm.getSplantType()
						+ "P','" + frm.getSourceLocation() + "','" + frm.getCapacity() + "','" + frm.getHabCode()
						+ "','" + frm.getNoofUnits() + "','" + frm.getNoOfHoursUsage() + "','"
						+ frm.getNoofStandByUnits() + "','" + frm.getRawWaterStorageTankExisting() + "','"
						+ frm.getProductWaterStorageTankExisting() + "','" + frm.getShelterExisting() + "','DONOR-TP','"
						+ frm.getCompStatus() + "'" + ",'" + frm.getCompCost() + "','" + frm.getLatitude() + "','"
						+ frm.getLongitude() + "','" + frm.getElivation() + "','" + frm.getWayPoint() + "','"
						+ frm.getAveCanSupplied() + "')";
				pstmt.addBatch(query);

				query = "update RWS_NTR_SUJALA_HAB_IMPL_TBL  set ASSET_CODE ='" + frm.getAssetCode() + "'"
						+ " , WTPSC_CODE ='" + frm.getSourceCode()
						+ "' , SCHEME_CONVERT_DATE =sysdate where HABITATION_CODE='" + frm.getHabCode()
						+ "' and IMPLEMENTATION_DT=to_date('" + frm.getImplDate() + "','DD/MM/YYYY') ";

				pstmt.addBatch(query);

				imageQuery = "insert into RWS_ASSET_COMPONENT_IMAGE_TBL(COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,ASSET_CODE,ASSET_COMPONENT) values(?,?,?,sysdate,?,?,?,?) ";
			}
			formFile = frm.getCompImage();
			if (!formFile.getFileName().equals("") && formFile.getFileName() != null) {

				preparedStatement = conn.prepareStatement(imageQuery);
				ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
				if (formFile != null) {
					try {
						String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
						if(!mimeType.equalsIgnoreCase("image/jpeg"))
						{
							message="Allowed only jpg file extensions only.";
							return message;
						}
						String path = actionServlet.getServletContext().getRealPath("") + formFile.getFileName();

						scannedFile = new File(path);
						outputStream = new FileOutputStream(scannedFile);
						if (outputStream != null) {
							outputStream.write(formFile.getFileData());
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

					} catch (Exception e) {
						System.out.println(
								"exception in saveAssetSource -- image file -- Rws_Ntr_Sujala_Asset_Convert_DAO-- "
										+ e);
					}

					double fileSizeMB = ((frm.getCompImage().getFileSize() / 1024.0) / 1024.0);

					if (fileSizeMB > 0.2) {
						message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;

					}

					preparedStatement.setBinaryStream(1, fis, (int) targetFile.length());

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
				preparedStatement.setString(2, frm.getLatitude());
				preparedStatement.setString(3, frm.getLongitude());
				preparedStatement.setInt(4, 0);
				preparedStatement.setString(5, "Application");
				preparedStatement.setString(6, frm.getAssetCode());
				preparedStatement.setString(7, frm.getSourceCode());
			}
			count = pstmt.executeBatch();

			if (count.length > 0) {
				if (!formFile.getFileName().equals("") && formFile.getFileName() != null) {
					preparedStatement.executeUpdate();
				}
				conn.setAutoCommit(true);
				conn.commit();
			} else {
				conn.rollback();
			}
			if (count.length > 0)

			{
				message = "NTR Sujala Habitation Successfully Converted to Asset";
			} else {
				message = "Failed to Convert Asset";
			}
		} catch (Exception e) {
			System.out.println("exception in saveAssetSource of  Rws_Ntr_Sujala_Asset_Convert_DAO-- " + e);
		}

		return message;

	}

	public Rws_Ntr_Sujala_Asset_Convert_Form getAssetDetails(String assetCode, Connection conn) {

		ArrayList habs = new ArrayList();
		Rws_Ntr_Sujala_Asset_Convert_Form frm = null;
		String query = "";
		PreparedStatement ps = null;
		try {

			query = "select  ASSET_NAME,TYPE_OF_ASSET_CODE,LOCATION,to_char(DATE_CREATION,'dd/mm/yyyy') as DATE_CREATION,"
					+ "ASSET_STATUS,ASSET_COST,START_YEAR,SUBSTR(SCHEME_CODE,17,3) AS SCHEME_CODE from rws_asset_mast_tbl a,"
					+ "RWS_ASSET_SCHEME_TBL b  where a.asset_code=b.asset_code and a.asset_code=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, assetCode);
			rset1 = ps.executeQuery();

			if (rset1.next()) {
				frm = new Rws_Ntr_Sujala_Asset_Convert_Form();
				frm.setAssetName(rset1.getString("ASSET_NAME"));
				frm.setAssetType(rset1.getString("TYPE_OF_ASSET_CODE"));
				frm.setLocation(rset1.getString("LOCATION"));
				frm.setDateCreation(rset1.getString("DATE_CREATION"));
				frm.setAssetStatus(rset1.getString("ASSET_STATUS"));
				frm.setAssetCost(rset1.getString("ASSET_COST"));
				frm.setStartYear(rset1.getString("START_YEAR"));
				frm.setSchemeCode(rset1.getString("SCHEME_CODE"));
				frm.setSourceCount(getSourceCount(assetCode, conn));

			}

		} catch (Exception e) {
			System.out.println("exception in  getAssetDetails of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getAssetDetails of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return frm;

	}

	public String getDivisionOfficeCodeFromMandal(String dcode, String mcode, Connection con) {
		String divisionOfficeCode = "";
		try {
			query = " select DIVISION_OFFICE_CODE  from " + " rws_mandal_subdivision_tbl where dcode=? "
					+ " and mcode='" + mcode + "'";
			ps = con.prepareStatement(query);
			ps.setString(1, dcode);
			rset = ps.executeQuery();
			while (rset.next())
				divisionOfficeCode = rset.getString("division_office_code");

		} catch (Exception e) {
			System.out
					.println("exception in  getDivisionOfficeCodeFromMandal of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println(
						"exception in getDivisionOfficeCodeFromMandal of Rws_Ntr_Sujala_Asset_Convert_DAO finally ="
								+ e2);
			}
		}
		return divisionOfficeCode;
	}

	public String getSubDivisionOfficeCodeFromMandal(String dcode, String mcode, Connection con) {
		String subDivisionOfficeCode = "";
		try {

			Statement stat = con.createStatement();
			query = " select SUBDIVISION_OFFICE_CODE  from " + " rws_mandal_subdivision_tbl where dcode=? and mcode=? ";
			ps = con.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);
			rset = ps.executeQuery();
			while (rset.next())
				subDivisionOfficeCode = rset.getString("subdivision_office_code");

		} catch (Exception e) {
			System.out.println(
					"exception in  getSubDivisionOfficeCodeFromMandal of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println(
						"exception in getSubDivisionOfficeCodeFromMandal of Rws_Ntr_Sujala_Asset_Convert_DAO finally ="
								+ e2);
			}
		}
		return subDivisionOfficeCode;
	}

	public void compressImage(File srcFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(srcFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		BufferedImage image = ImageIO.read(is);

		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		writer.write(null, new IIOImage(image, null, null), param);

		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}

	public int getSourceCount(String assetCode, Connection con) {
		int count = 0;
		try {

			query = " select count(*)  from  RWS_AST_WTP_SC_PARAM_TBL where asset_code=? ";
			ps = con.prepareStatement(query);
			ps.setString(1, assetCode);
			rset = ps.executeQuery();
			while (rset.next())
				count = rset.getInt(1);

		} catch (Exception e) {
			System.out.println("exception in  getSourceCount of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getSourceCount of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return count;
	}

	public Rws_Ntr_Sujala_Asset_Convert_Form getSourceDetails(String assetCode, String habCode, Connection conn) {

		ArrayList habs = new ArrayList();
		Rws_Ntr_Sujala_Asset_Convert_Form frm = null;
		String query = "", query1 = "";
		PreparedStatement ps = null;
		try {

			query = "select  WTPSC_CODE,LOCATION,WTP_MLD,UNITS_NO,USE_CAPACITYMLD,UNITS_STANDBY,RWS_TANK_EXISTING,"
					+ "PWS_TANK_EXISTING,SHELTER_EXISTING,STATUS,COMP_COST,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,"
					+ "AVE_CANS_SUPPLIED from RWS_AST_WTP_SC_PARAM_TBL  where asset_code=? and HAB_CODE=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, assetCode);
			ps.setString(2, habCode);
			rset1 = ps.executeQuery();

			if (rset1.next()) {
				frm = new Rws_Ntr_Sujala_Asset_Convert_Form();
				frm.setSourceCode(rset1.getString("WTPSC_CODE"));
				frm.setSourceLocation(rset1.getString("LOCATION"));
				frm.setCapacity(rset1.getString("WTP_MLD"));
				frm.setNoofUnits(rset1.getString("UNITS_NO"));
				frm.setNoOfHoursUsage(rset1.getString("USE_CAPACITYMLD"));
				frm.setNoofStandByUnits(rset1.getString("UNITS_STANDBY"));
				frm.setRawWaterStorageTankExisting(rset1.getString("RWS_TANK_EXISTING"));
				frm.setProductWaterStorageTankExisting(rset1.getString("PWS_TANK_EXISTING"));
				frm.setShelterExisting(rset1.getString("SHELTER_EXISTING"));
				frm.setCompStatus(rset1.getString("STATUS"));
				frm.setCompCost(rset1.getString("COMP_COST"));
				frm.setLatitude(rset1.getString("LATITUDE"));
				frm.setLongitude(rset1.getString("LONGITUDE"));
				frm.setElivation(rset1.getString("ELEVATION"));
				frm.setWayPoint(rset1.getString("WAY_POINT"));
				frm.setAveCanSupplied(rset1.getString("AVE_CANS_SUPPLIED"));
			}

		} catch (Exception e) {
			System.out.println("exception in  getSourceDetails of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getSourceDetails of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return frm;

	}

	public String getImageStatus(String compCode, Connection con) {

		String flag = "No";
		PreparedStatement stat = null;
		try {

			query = " select COMPO_IMAGE  from  RWS_ASSET_COMPONENT_IMAGE_TBL where ASSET_COMPONENT=? ";
			stat = con.prepareStatement(query);
			stat.setString(1, compCode);
			rset = stat.executeQuery();
			if (rset.next())
				flag = "Yes";

		} catch (Exception e) {
			System.out.println("exception in getImageStatus() of Rws_Ntr_Sujala_Asset_Convert_DAO-- " + e);
		} finally {
			try {
				if (stat != null) {
					stat.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getImageStatus of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);
			}
		}
		return flag;
	}
	
	/*public ArrayList getConvertedHabitations(Connection conn) throws Exception {
		ArrayList habs = new ArrayList();
		Rws_Ntr_Sujala_Asset_Convert_Form frm = null;
		String query = "", query1 = "";
		PreparedStatement ps = null, ps1 = null;
		try {

			Statement stmt1 = conn.createStatement();
			query = "select distinct hab_code,panch_name,coverage_status,(census_plain_popu+census_sc_popu+census_st_popu) as popu  from "
					+ "rws_ntr_sujala_master_tbl a ,rws_complete_hab_view b where a.hab_code=b.panch_code and b.dcode=? and "
					+ "b.mcode=? ";

			ps = conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, mcode);

			rset = ps.executeQuery();

			while (rset.next()) {
				query1 = "select PLANT_TYPE_INSTALLED,  PLANT_CAPACITY , INSTALLATION_AGENCY_TYPE,  "
						+ "INSTALLATION_AGENCY_NAME,  MAINTENANCE_AGENCY_TYPE,  MAINTENANCE_AGENCY_NAME,"
						+ "to_char(IMPLEMENTATION_DT,'DD/MM/YYYY') as IMPLEMENTATION_DT,nvl(ASSET_CODE,'--') as ASSET_CODE,"
						+ "nvl(WTPSC_CODE,'--') as WTPSC_CODE,"
						+ "decode(PLANT_TYPE_INSTALLED,'RO','RO','EDF','ED','TERRAFIL','TF','NANOTECHNOLOGY ','NT','ULTRAFILTRATION','UF','UV','UV') as typeOfPlant"
						+ "  from rws_NTR_SUJala_HAB_IMPL_TBL  where habitation_code=?  and EXTRACT(YEAR FROM IMPLEMENTATION_DT)=? ";

				ps1 = conn.prepareStatement(query1);
				ps1.setString(1, rset.getString(1));
				ps1.setString(2, year);
				rset1 = ps1.executeQuery();

				while (rset1.next()) {
					frm = new Rws_Ntr_Sujala_Asset_Convert_Form();
					frm.setHabCode(rset.getString(1));
					frm.setHabName(rset.getString(2));
					frm.setHabstatus(rset.getString(3));
					frm.setHabPop(rset.getString(4));
					frm.setSplantType(rset1.getString("typeOfPlant"));
					frm.setPlantType(rset1.getString(1));
					frm.setPlantCapacity(rset1.getString(2));
					frm.setAgencyType(rset1.getString(3));
					frm.setInstAgencyName(rset1.getString(4));
					frm.setMaintenanceType(rset1.getString(5));
					frm.setMainAgencyName(rset1.getString(6));
					frm.setImplDate(rset1.getString("IMPLEMENTATION_DT"));
					if (rset1.getString("ASSET_CODE").equals("--") && rset1.getString("WTPSC_CODE").equals("--")) {
						frm.setConvStatus("Y");
					} else {
						frm.setConvStatus("N");
					}
					habs.add(frm);
				}

			}
		} catch (Exception e) {
			System.out.println("exception in  getHabitations of Rws_Ntr_Sujala_Asset_Convert_DAO= " + e);
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
				if (ps1 != null) {
					ps1.close();
				}
				if (rset1 != null) {
					rset1.close();
				}
			} catch (Exception e2) {
				Debug.println("exception in getHabitations of Rws_Ntr_Sujala_Asset_Convert_DAO finally =" + e2);

			}
		}
		return habs;
	}*/
}