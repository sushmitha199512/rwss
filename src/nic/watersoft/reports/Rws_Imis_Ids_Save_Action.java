
package nic.watersoft.reports;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Imis_Ids_Save_Action extends Action {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		Rws_Imis_Ids_Dao mydao = new Rws_Imis_Ids_Dao();
		Rws_Imis_Ids_Form imisIdsForm = (Rws_Imis_Ids_Form) form;
		String ids_type = "";
		if (mode != null && mode.equals("data")) {
			ids_type = request.getParameter("imis");
			InputStream inputStream = imisIdsForm.getInputFile().getInputStream();
			org.apache.poi.poifs.filesystem.POIFSFileSystem fs = new org.apache.poi.poifs.filesystem.POIFSFileSystem(inputStream);
			HSSFWorkbook wb = new HSSFWorkbook(fs);
			HSSFSheet sheet =null;
			HSSFRow excelRecord; 		
			if (!ids_type.equals("") && ids_type.equals("sources")) {
				sheet = wb.getSheetAt(5);
				excelRecord = sheet.getRow(0);
				int sheetrecnt = sheet.getLastRowNum();
				if (sheetrecnt > 0) {
					if (mydao.isValidSchemeSourceExcel(excelRecord, sheet, request)){
						mydao.readSchemeSourcesExcelFile(sheet, request);
					} else {
						request.setAttribute("message",	"Sorry, Excel Format is not valid");
					}
				} else {
					request.setAttribute("message",	"Sorry, Excel File has no Data");
				}
			} else if (!ids_type.equals("") && ids_type.equals("schemes")) {
				sheet = wb.getSheetAt(4);
				excelRecord = sheet.getRow(0);				
				int sheetrecnt = sheet.getLastRowNum();
				if (sheetrecnt > 0) {
					if (mydao.isValidSchemeExcel(excelRecord, sheet, request)) {
						mydao.readSchemesExcelFile(sheet, request);
					} else {
						request.setAttribute("message", "Sorry, Excel Format is not valid");
					}
				} else {
					request.setAttribute("message", "Sorry, Excel File has no Data");
				}
			} 
		}
		return mapping.findForward(mode);
	}
}
