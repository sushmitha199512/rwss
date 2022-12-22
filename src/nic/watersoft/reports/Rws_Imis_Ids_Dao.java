package nic.watersoft.reports;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;

public class Rws_Imis_Ids_Dao {
	public static final String schemeType = "scheme";
	public static final String schemeSourceType = "source";	

	public int readSchemesExcelFile(HSSFSheet sheet, HttpServletRequest request) {
		Connection conn = null;
		Statement stmt = null;
		int j = 0;
		int inscnt = 0, notinscnt = 0;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();			
			String schemeIdIMIS = "";
			String schemeIdState = "";
			HSSFRow excelRecord;
			excelRecord = sheet.getRow(0);
			for (int i = 1; i <= sheet.getLastRowNum(); i++) {
				excelRecord = sheet.getRow(i);			
				schemeIdState = excelRecord.getCell((short) 0).getStringCellValue();
				schemeIdIMIS = excelRecord.getCell((short) 1).getStringCellValue();				
				String sql = "INSERT INTO rws_imis_schemes_tbl (SCHEMEID_IMIS ,SCHEMEID_STATE) values ('"+schemeIdIMIS+"','" +schemeIdState+"' )";
				if (!isAlreadyExists(schemeIdState, schemeType)) {
					stmt.addBatch(sql);
					inscnt++;
				} else {
					notinscnt++;
				}
			}
			int recCount[] = stmt.executeBatch();
			if (recCount.length > 0) {
				request.setAttribute("message", recCount.length+ " Scheme Ids Updated Successfully ");
				request.setAttribute("message", notinscnt+"Ids Updated, IMIS Scheme(s) Ids Already Exists");
			} else {
				request.setAttribute("message", "Failed.");
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Imis_Ids_Dao readSchemesExcelFile "+ e.getMessage());
		}
		finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Imis_Ids_Dao readSchemesExcelFile "+ e.getMessage());
			}
		}
		return j;
	}

	public boolean isValidSchemeExcel(HSSFRow excelRecord, HSSFSheet sheet,	HttpServletRequest request) {
		boolean flag = false;
		excelRecord = sheet.getRow(0);
		int colcnt = excelRecord.getLastCellNum();		
		String sheetHeading1 = excelRecord.getCell((short) 0).getStringCellValue();
		String sheetHeading2 = excelRecord.getCell((short) 1).getStringCellValue();
		if (colcnt == 2) {
			if (!sheetHeading1.equalsIgnoreCase("SchemeIdOfState") && !sheetHeading2.equalsIgnoreCase("RWSSchemeId")) {
				flag = false;
				request.setAttribute("message", "Column Names Does not Match");
			} else {
				flag = true;
			}
		} else {
			flag = false;
			request.setAttribute("message", "Column Count Does not Match");
		}
		return flag;
	}

	public boolean isValidSchemeSourceExcel(HSSFRow excelRecord, HSSFSheet sheet, HttpServletRequest request) {
		boolean flag = false;
		excelRecord = sheet.getRow(0);
		String sheetHeading1 = excelRecord.getCell((short) 0).getStringCellValue();
		String sheetHeading2 = excelRecord.getCell((short) 1).getStringCellValue();
		if (!sheetHeading1.equalsIgnoreCase("SourcesIdOfState") && !sheetHeading2.equalsIgnoreCase("IMISSchemeSourceId")) {
			flag = false;
			request.setAttribute("message", "Excel Format Does not Match");
		} else {
			flag = true;
		}
		return flag;
	}

	public boolean isAlreadyExists(String stateId, String type) {
		boolean flag = false, flag1 = false, flag3 = false;
		String chechQry = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = RwsOffices.getConn();
			String tblname = "", codeType = "";
		 	String sourceType = "";		
			if (type.equals(schemeType)) {
				chechQry = "select count(schemeid_state) from rws_imis_schemes_tbl  a ,rws_work_admn_tbl b where a.schemeid_state=b.work_id and schemeid_state= ? ";
				stmt = conn.prepareStatement(chechQry);		
				stmt.setString(1, stateId);
				ResultSet rs = stmt.executeQuery();
				if (!rs.next()) {
					flag = true;
				}
				if (stmt != null) {
					stmt.close();
				}
			} 
			else if (type.equals(schemeSourceType))	{	  
				sourceType=stateId.substring(19,21);	
				if (sourceType.equals("HP")) {
					tblname = "RWS_HP_SUBCOMP_PARAM_TBL ";
					codeType = "HP_Code";
				} 
				else if (sourceType.equals("SO")){
					tblname = "rws_source_tbl";
					codeType = "Source_Code";
				}
				else if (sourceType.equals("OW")){
					tblname = "RWS_OPENWELL_POND_TBL";
					codeType = "POND_CODE";
				}
				chechQry = "select count(schemesourceid_state) from rws_imis_schemesources_tbl  a, "+tblname+" b where a.schemesourceid_state=b."+codeType+" and schemesourceid_state= ? ";
				stmt = conn.prepareStatement(chechQry);						
				stmt.setString(1, stateId);
				ResultSet rs = stmt.executeQuery();
				if (!rs.next()) {
					flag = true;
				}
				if (stmt != null){
					stmt.close();
				}		
			}
		}
		catch(Exception e){
			System.out.println("The Exception is in Rws_Imis_Ids_Dao isAlreadyExists "+ e.getMessage());
		}
		finally {
			try {
				if (stmt != null){
					stmt.close();
				}
		    } catch (Exception e) {
		    	System.out.println("The Exception is in Rws_Imis_Ids_Dao isAlreadyExists "+ e.getMessage());
			}
		}
		return flag;
	}

	public int readSchemeSourcesExcelFile(HSSFSheet sheet,  HttpServletRequest request) {
		int j = 0;
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String schemesourceIdIMIS = "";
			String schemesourceIdState = "";
			HSSFRow excelRecord;
			for (int i = 1; i <= sheet.getLastRowNum(); i++) {
				excelRecord = sheet.getRow(i);
            	schemesourceIdState = excelRecord.getCell((short) 0).getStringCellValue();
				schemesourceIdIMIS = excelRecord.getCell((short) 1).getStringCellValue();
				if (!isAlreadyExists(schemesourceIdState, schemeSourceType)) {
					String sql = "INSERT INTO rws_imis_schemesources_tbl (SCHEMESSOURCESID_IMIS ,SCHEMESOURCEID_STATE) values ('"+ schemesourceIdIMIS+ "','"+ schemesourceIdState+ "' )";
					stmt.addBatch(sql);
				}
				else {
					request.setAttribute("message",	"IMIS SchemeSource Ids Already Exists");
				}
			}
			int recCount[] = stmt.executeBatch();
			if (recCount.length > 0) {
				request.setAttribute("message", recCount.length + " SchemeSource Ids Updated Successfully");
			}
			else {
				request.setAttribute("message", "Failed.");
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Imis_Ids_Dao readSchemeSourcesExcelFile "+ e.getMessage());
		}
		finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Imis_Ids_Dao readSchemeSourcesExcelFile "+ e.getMessage());
			}
		}
		return j;
	}
}
