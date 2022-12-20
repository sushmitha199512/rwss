package nic.watersoft.drought;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;
import nic.watersoft.drought.DroughtDAOMessage;
import nic.watersoft.drought.DroughtDAO;
import nic.watersoft.drought.DroughtHolder;
import nic.watersoft.drought.Rws_Drought_Admin_Sanction_Frm;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.lang.StringBuffer;

import org.apache.struts.action.Action;

public class Rws_Drought_AdminSanctionAction extends Action {
	String new_wid;

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();
		if (session == null)
			return mapping.findForward("expire");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(
				Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER)
				|| user.getUserId().equals(Constants.DROUGHT_USER)
				|| Constants.IsUser(user.getUserId()) || Constants
					.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		String target = new String("insert-success");
		Rws_Drought_Admin_Sanction_Frm myForm = (Rws_Drought_Admin_Sanction_Frm) form;
		Rws_Drought_Admin_Sanction_Act adact = new Rws_Drought_Admin_Sanction_Act();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rst = null;
		DataSource dataSource = getDataSource(request);
		String mode = myForm.getMode();
		String leadhab = request.getParameter("leadhab");

		if (leadhab != null && !leadhab.equals("undefined")) {
			session.setAttribute("leadvalue", request.getParameter("leadhab"));
		}
		String revisedUpdatedViewId = "";
		String query = null;
		String officeCode = myForm.getHeadOfficeCode()
				+ myForm.getCircleOfficeCode() + myForm.getDivisionOfficeCode()
				+ myForm.getSubdivisionOfficeCode();
		boolean work_id_available = false;
		String message = "";
		String month[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL",
				"AUG", "SEP", "OCT", "NOV", "DEC" };
		
		if (mode != null && mode.equals("duplicateCheck")) {
			int no_of_duplicate_records = 0;
			conn = RwsOffices.getConn();
			
			Iterator iterator1 = myForm.getProposals().iterator();
			DroughtHolder proposalHolder1 = null;
			while (iterator1.hasNext()) {
				proposalHolder1 = (DroughtHolder) iterator1.next();
			}
			StringBuffer s = new StringBuffer(
					proposalHolder1.getAdminiStrativeDate());
			String date = s.replace(3, 5,
					month[Integer.parseInt(s.substring(3, 5)) - 1])
					+ "";
			String qry = "SELECT * FROM RWS_WORK_ADMN_TBL WHERE SUBSTR(OFFICE_CODE,2,2)=? AND NO_OF_HABS=? AND PROGRAMME_CODE=? AND SUBPROGRAMME_CODE=? AND TYPE_OF_ASSET=? AND SANCTION_AMOUNT=? AND PLAN_CODE=? AND AUG_NEW_CODE=? AND CATEGORY_CODE=? AND ADMIN_DATE=?";
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, myForm.getCircleOfficeCode());
			pstmt.setString(2, proposalHolder1.getNoOfHabs());
			pstmt.setString(3, myForm.getPrograms());
			pstmt.setString(4, myForm.getSubPrograms());
			pstmt.setString(5, myForm.getTypeOfAsset());
			pstmt.setString(6, proposalHolder1.getSanctionAmout());
			pstmt.setString(7, myForm.getPlan());
			pstmt.setString(8, myForm.getWrktype());
			pstmt.setString(9, myForm.getWorkCat());
			pstmt.setString(10, date);
			rst = pstmt.executeQuery();
			while (rst.next()) {
				no_of_duplicate_records++;
			}
			if (no_of_duplicate_records > 0) {
				request.setAttribute("duplicateExist", "Y");
			} else {
				request.setAttribute("duplicateExist", "N");
			}
			target = "failure1";
			Iterator iterator = myForm.getProposals().iterator();
			DroughtHolder proposalHolder = null;
			while (iterator.hasNext()) {
				proposalHolder = (DroughtHolder) iterator.next();
				String[] habCodes = request.getParameterValues("H_"
						+ proposalHolder.getProposalId());
				if (leadhab != null && leadhab.equals("undefined")) {
					session.setAttribute("leadvalue", habCodes[0]);
				}
			}

		}

		if (mode != null && mode.equals("Save")) {
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			DroughtDAO proposalDAO = new DroughtDAO();
			int stype = 0, substype = 0;
			int wcount = (Integer.parseInt(request.getParameter("wcount")));
			String leadvalue[] = request.getParameterValues("leadlab");
			String sourcecode = request.getParameter("sourcecode");
			String subsourcecode = request.getParameter("subsourcecode");
			String asttype = (String) request.getParameter("asttype");
			Statement stat=null;
			try {

				conn = RwsOffices.getConn();
				conn.setAutoCommit(false);
				stat=conn.createStatement();
				Iterator iterator = myForm.getProposals().iterator();
				DroughtHolder proposalHolder = null;
				int total = 0;
				String augmentedWorkId = null;
				Date today = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
				String datenewformat = formatter.format(today);
				while (iterator.hasNext()) {
					total++;
					augmentedWorkId = "";
					proposalHolder = (DroughtHolder) iterator.next();
					String isAugmentedWork = proposalHolder.getAugmentation();
					if (isAugmentedWork != null && isAugmentedWork.equals("Y"))
						augmentedWorkId = proposalHolder.getWorkId();

					String subdiv = myForm.getSubdivisionOfficeCode();

					String lab = proposalHolder.getNoOfLabs();
					String scheme = myForm.getTypeOfAsset();
					try {
						String availablity="select * from RWS_drought_works_TBL where WORK_ID=?";
						pstmt = conn.prepareStatement(availablity);
						pstmt.setString(1, myForm.getCircleOfficeCode());						
						rst = pstmt.executeQuery();
						
						work_id_available = rst.next();

					} catch (Exception e) {
						Debug.println("Exception in checking of work id "
								+ e.getMessage());
					} finally {
						rst.close();
					}
					String[] habCodes = (String[]) session
							.getAttribute("proposalsHabs");

					if (!work_id_available) {
						new_wid = proposalHolder.getProposalId();
						{

							if (subdiv != null && !(subdiv.equals(""))) {
								query = " INSERT INTO RWS_drought_works_TBL (OFFICE_CODE,";
								query += "PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,HABITATION_CODE,";
								query += "WORK_NAME,WORK_ID,Work_type,SUS_CODE,AUG_WORKID,TYPE_OF_ASSET,WORK_CATEGORY,PLAN_CODE,AUG_NEW_CODE,";
								query += "CATEGORY_CODE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TS_NO,TS_DATE,TS_AMOUNT,SSR_YEAR,SOURCE_HAB_CODE";
								if (sourcecode != null
										&& !sourcecode.equals("")
										&& subsourcecode != null
										&& !subsourcecode.equals("")) {
									query += ",SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";
								}
								query += ",SOURCE_CODE,SOURCE_NAME,SOURCE_LOCATION,ASSET_CODE,NEW_EXISTING,SITE_HAND_OVER_DATE,GROUNDING_DATE,EXPENDITURE_UPTO,EXPENDITURE_UPTO_DT,";
								query += "VALUE_OF_WORK_NOT_PAID,DATE_OF_COMPLETION,DT_FIN_COMPLETION,DATE_OF_COMM,approved_under,REMARKS) "
										+ "VALUES( '"
										+ myForm.getHeadOfficeCode()
										+ myForm.getCircleOfficeCode()
										+ myForm.getDivisionOfficeCode()
										+ subdiv
										+ "',"
										+ "'"
										+ myForm.getPrograms()
										+ "',"
										+ "'"
										+ myForm.getSubPrograms()
										+ "',"
										+ "'"
										+ myForm.getUserId()
										+ "',"
										+ "to_date('"
										+ datenewformat
										+ "','dd/mm/yyyy'),"
										+ "to_date('"
										+ datenewformat
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getNoOfHabs()
										+ "'"
										+ ",'"
										+ proposalHolder.getProposalName()
										+ "',"
										+ "'"
										+ proposalHolder.getProposalId()
										+ "',"
										+ "'"
										+ proposalHolder.getWorkType()
										+ "',"
										+ "'"
										+ proposalHolder.getSusType()
										+ "',"
										+ "'"
										+ myForm.getAugsch()
										+ "',"
										+ "'"
										+ myForm.getTypeOfAsset()
										+ "',"
										+ "'"
										+ myForm.getWorkCat()
										+ "',"
										+ "'"
										+ myForm.getPlan()
										+ "',"
										+ "'"
										+ myForm.getWrktype()
										+ "',"
										+ "'"
										+ myForm.getWorkCat()
										+ "',"
										+ "'"
										+ proposalHolder.getAdminiStrativeNum()
										+ "',"
										+ "to_date('"
										+ proposalHolder
												.getAdminiStrativeDate()
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getSanctionAmout()
										+ "',"
										+ "'"
										+ proposalHolder.getTsno()
										+ "',"
										+ "to_date('"
										+ proposalHolder.getTsdate()
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getTsamt()
										+ "',"
										+ "'"
										+ proposalHolder.getSsryr()
										+ "',"
										+ "'"
										+ proposalHolder.getSrhabcode() + "'";
								if (sourcecode != null
										&& !sourcecode.equals("")) {
									stype = Integer.parseInt(proposalDAO
											.getSourceValue(sourcecode));
									Debug.println("finded code " + stype);
									query += ",'" + stype + "'";
								}
								if (subsourcecode != null
										&& !subsourcecode.equals("")) {
									substype = Integer.parseInt(proposalDAO
											.getSubSourceValue(stype,
													subsourcecode));
									query += ",'" + substype + "'";
									Debug.println("finded code " + substype);
								}
								query += ",'" + proposalHolder.getScrcode()
										+ "'," + "'"
										+ proposalHolder.getSrname() + "',"
										+ "'" + proposalHolder.getSrloc()
										+ "'," + "'"
										+ proposalHolder.getAstcode() + "',"
										+ "'" + asttype + "'," + "to_date('"
										+ proposalHolder.getSitedate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getGrounddate()
										+ "','dd/mm/yyyy')," + "'"
										+ proposalHolder.getExpupto() + "',"
										+ "to_date('"
										+ proposalHolder.getExpuptodate()
										+ "','dd/mm/yyyy')," + "'"
										+ proposalHolder.getNotpaidvalue()
										+ "'," + "to_date('"
										+ proposalHolder.getCompdate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getFincompdate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getCommdate()
										+ "','dd/mm/yyyy')," + "'"
										+ myForm.getProoved() + "'," + "'"
										+ proposalHolder.getRemarks() + "')";

							} else {
								query = " INSERT INTO RWS_drought_works_TBL (OFFICE_CODE,";
								query += "PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,HABITATION_CODE,";
								query += "WORK_NAME,WORK_ID,work_type,sus_code,AUG_WORKID,TYPE_OF_ASSET,WORK_CATEGORY,PLAN_CODE,AUG_NEW_CODE,";
								query += "CATEGORY_CODE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TS_NO,TS_DATE,TS_AMOUNT,SSR_YEAR,SOURCE_HAB_CODE";
								if (sourcecode != null
										&& !sourcecode.equals("")
										&& subsourcecode != null
										&& !subsourcecode.equals("")) {
									query += ",SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";
								}
								query += ",SOURCE_CODE,SOURCE_NAME,SOURCE_LOCATION,ASSET_CODE,NEW_EXISTING,SITE_HAND_OVER_DATE,GROUNDING_DATE,EXPENDITURE_UPTO,EXPENDITURE_UPTO_DT,";
								query += "VALUE_OF_WORK_NOT_PAID,DATE_OF_COMPLETION,DT_FIN_COMPLETION,DATE_OF_COMM,approved_under,REMARKS) "
										+ "VALUES( '"
										+ myForm.getHeadOfficeCode()
										+ myForm.getCircleOfficeCode()
										+ myForm.getDivisionOfficeCode()
										+ "00"
										+ "',"
										+ "'"
										+ myForm.getPrograms()
										+ "',"
										+ "'"
										+ myForm.getSubPrograms()
										+ "',"
										+ "'"
										+ myForm.getUserId()
										+ "',"
										+ "to_date('"
										+ datenewformat
										+ "','dd/mm/yyyy'),"
										+ "to_date('"
										+ datenewformat
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getNoOfHabs()
										+ "'"
										+ ",'"
										+ proposalHolder.getProposalName()
										+ "',"
										+ "'"
										+ proposalHolder.getProposalId()
										+ "',"
										+ "'"
										+ proposalHolder.getWorkType()
										+ "',"
										+ "'"
										+ proposalHolder.getSusType()
										+ "',"
										+ "'"
										+ myForm.getAugsch()
										+ "',"
										+ "'"
										+ myForm.getTypeOfAsset()
										+ "',"
										+ "'"
										+ myForm.getWorkCat()
										+ "',"
										+ "'"
										+ myForm.getPlan()
										+ "',"
										+ "'"
										+ myForm.getWrktype()
										+ "',"
										+ "'"
										+ myForm.getWorkCat()
										+ "',"
										+ "'"
										+ proposalHolder.getAdminiStrativeNum()
										+ "',"
										+ "to_date('"
										+ proposalHolder
												.getAdminiStrativeDate()
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getSanctionAmout()
										+ "',"
										+ "'"
										+ proposalHolder.getTsno()
										+ "',"
										+ "to_date('"
										+ proposalHolder.getTsdate()
										+ "','dd/mm/yyyy'),"
										+ "'"
										+ proposalHolder.getTsamt()
										+ "',"
										+ "'"
										+ proposalHolder.getSsryr()
										+ "',"
										+ "'"
										+ proposalHolder.getSrhabcode() + "'";
								if (sourcecode != null
										&& !sourcecode.equals("")) {
									stype = Integer.parseInt(proposalDAO
											.getSourceValue(sourcecode));
									query += ",'" + stype + "'";
								}
								if (subsourcecode != null
										&& !subsourcecode.equals("")) {
									substype = Integer.parseInt(proposalDAO
											.getSubSourceValue(stype,
													subsourcecode));
									query += ",'" + substype + "'";
								}
								query += ",'" + proposalHolder.getScrcode()
										+ "'," + "'"
										+ proposalHolder.getSrname() + "',"
										+ "'" + proposalHolder.getSrloc()
										+ "'," + "'"
										+ proposalHolder.getAstcode() + "',"
										+ "'" + asttype + "'," + "to_date('"
										+ proposalHolder.getSitedate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getGrounddate()
										+ "','dd/mm/yyyy')," + "'"
										+ proposalHolder.getExpupto() + "',"
										+ "to_date('"
										+ proposalHolder.getExpuptodate()
										+ "','dd/mm/yyyy')," + "'"
										+ proposalHolder.getNotpaidvalue()
										+ "'," + "to_date('"
										+ proposalHolder.getCompdate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getFincompdate()
										+ "','dd/mm/yyyy')," + "to_date('"
										+ proposalHolder.getCommdate()
										+ "','dd/mm/yyyy')," + "'"
										+ myForm.getProoved() + "'," + "'"
										+ proposalHolder.getRemarks() + "')";

							}

							stat.addBatch(query);

						}
					}

					else if (work_id_available) {
						String circleOfficeCode = myForm.getCircleOfficeCode();
						String typeOfAssetCode = myForm.getTypeOfAsset();
						String ProgrammeCode = myForm.getPrograms();
						String subProgrammeCode = myForm.getSubPrograms();
						String nextProposalId = "";
						String headOfficeCode = myForm.getHeadOfficeCode();
						ArrayList proposals = null;


						if (circleOfficeCode != null
								&& !circleOfficeCode.equals("")
								&& typeOfAssetCode != null
								&& !typeOfAssetCode.equals("")
								&& ProgrammeCode != null
								&& !ProgrammeCode.equals("")
								&& subProgrammeCode != null
								&& !subProgrammeCode.equals("")) {
							nextProposalId = proposalDAO
									.getNextProposalIdForAdminiStrative(
											headOfficeCode, circleOfficeCode,
											typeOfAssetCode, ProgrammeCode,
											subProgrammeCode);
						}

						StringBuffer wid = new StringBuffer("" + new_wid);
						String secondPart = ("" + new_wid).substring(11, 14);
						int sno = Integer.parseInt(secondPart);
						sno = sno + 1;
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;
						else
							secondPart = String.valueOf(sno);
						wid = wid.replace(11, 14, secondPart);
						proposalHolder.setProposalId("" + wid);
						new_wid = "" + wid;
						proposalHolder.setProposalId(nextProposalId);

						if (subdiv != null && !(subdiv.equals(""))) {
							query = " INSERT INTO RWS_drought_works_TBL (OFFICE_CODE,";
							query += "PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,HABITATION_CODE,";
							query += "WORK_NAME,WORK_ID,Work_type,SUS_CODE,AUG_WORKID,TYPE_OF_ASSET,WORK_CATEGORY,PLAN_CODE,AUG_NEW_CODE,";
							query += "CATEGORY_CODE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TS_NO,TS_DATE,TS_AMOUNT,SSR_YEAR,SOURCE_HAB_CODE";
							if (sourcecode != null && !sourcecode.equals("")
									&& subsourcecode != null
									&& !subsourcecode.equals("")) {
								query += ",SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";
							}
							query += ",SOURCE_CODE,SOURCE_NAME,SOURCE_LOCATION,ASSET_CODE,NEW_EXISTING,SITE_HAND_OVER_DATE,GROUNDING_DATE,EXPENDITURE_UPTO,EXPENDITURE_UPTO_DT,";
							query += "VALUE_OF_WORK_NOT_PAID,DATE_OF_COMPLETION,DT_FIN_COMPLETION,DATE_OF_COMM,approved_under,REMARKS) "
									+ "VALUES( '"
									+ myForm.getHeadOfficeCode()
									+ myForm.getCircleOfficeCode()
									+ myForm.getDivisionOfficeCode()
									+ subdiv
									+ "',"
									+ "'"
									+ myForm.getPrograms()
									+ "',"
									+ "'"
									+ myForm.getSubPrograms()
									+ "',"
									+ "'"
									+ myForm.getUserId()
									+ "',"
									+ "to_date('"
									+ datenewformat
									+ "','dd/mm/yyyy'),"
									+ "to_date('"
									+ datenewformat
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getNoOfHabs()
									+ "'"
									+ ",'"
									+ proposalHolder.getProposalName()
									+ "',"
									+ "'"
									+ proposalHolder.getProposalId()
									+ "',"
									+ "'"
									+ proposalHolder.getWorkType()
									+ "',"
									+ "'"
									+ proposalHolder.getSusType()
									+ "',"
									+ "'"
									+ myForm.getAugsch()
									+ "',"
									+ "'"
									+ myForm.getTypeOfAsset()
									+ "',"
									+ "'"
									+ myForm.getWorkCat()
									+ "',"
									+ "'"
									+ myForm.getPlan()
									+ "',"
									+ "'"
									+ myForm.getWrktype()
									+ "',"
									+ "'"
									+ myForm.getWorkCat()
									+ "',"
									+ "'"
									+ proposalHolder.getAdminiStrativeNum()
									+ "',"
									+ "to_date('"
									+ proposalHolder.getAdminiStrativeDate()
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getSanctionAmout()
									+ "',"
									+ "'"
									+ proposalHolder.getTsno()
									+ "',"
									+ "to_date('"
									+ proposalHolder.getTsdate()
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getTsamt()
									+ "',"
									+ "'"
									+ proposalHolder.getSsryr()
									+ "',"
									+ "'"
									+ proposalHolder.getSrhabcode() + "'";
							if (sourcecode != null && !sourcecode.equals("")) {
								stype = Integer.parseInt(proposalDAO
										.getSourceValue(sourcecode));
								query += ",'" + stype + "'";
							}
							if (subsourcecode != null
									&& !subsourcecode.equals("")) {
								substype = Integer
										.parseInt(proposalDAO
												.getSubSourceValue(stype,
														subsourcecode));
								query += ",'" + substype + "'";
							}
							query += ",'" + proposalHolder.getScrcode() + "',"
									+ "'" + proposalHolder.getSrname() + "',"
									+ "'" + proposalHolder.getSrloc() + "',"
									+ "'" + proposalHolder.getAstcode() + "',"
									+ "'" + asttype + "'," + "to_date('"
									+ proposalHolder.getSitedate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getGrounddate()
									+ "','dd/mm/yyyy')," + "'"
									+ proposalHolder.getExpupto() + "',"
									+ "to_date('"
									+ proposalHolder.getExpuptodate()
									+ "','dd/mm/yyyy')," + "'"
									+ proposalHolder.getNotpaidvalue() + "',"
									+ "to_date('"
									+ proposalHolder.getCompdate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getFincompdate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getCommdate()
									+ "','dd/mm/yyyy')," + "'"
									+ myForm.getProoved() + "'," + "'"
									+ proposalHolder.getRemarks() + "')";

						} else {
							query = " INSERT INTO RWS_drought_works_TBL (OFFICE_CODE,";
							query += "PROGRAMME_CODE,SUBPROGRAMME_CODE,PREPARED_BY,PREPARED_ON,UPDATE_DATE,HABITATION_CODE,";
							query += "WORK_NAME,WORK_ID,work_type,sus_code,AUG_WORKID,TYPE_OF_ASSET,WORK_CATEGORY,PLAN_CODE,AUG_NEW_CODE,";
							query += "CATEGORY_CODE,ADMIN_NO,ADMIN_DATE,ADMIN_AMOUNT,TS_NO,TS_DATE,TS_AMOUNT,SSR_YEAR,SOURCE_HAB_CODE";
							if (sourcecode != null && !sourcecode.equals("")
									&& subsourcecode != null
									&& !subsourcecode.equals("")) {
								query += ",SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE";
							}
							query += ",SOURCE_CODE,SOURCE_NAME,SOURCE_LOCATION,ASSET_CODE,NEW_EXISTING,SITE_HAND_OVER_DATE,GROUNDING_DATE,EXPENDITURE_UPTO,EXPENDITURE_UPTO_DT,";
							query += "VALUE_OF_WORK_NOT_PAID,DATE_OF_COMPLETION,DT_FIN_COMPLETION,DATE_OF_COMM,approved_under,REMARKS) "
									+ "VALUES( '"
									+ myForm.getHeadOfficeCode()
									+ myForm.getCircleOfficeCode()
									+ myForm.getDivisionOfficeCode()
									+ "00"
									+ "',"
									+ "'"
									+ myForm.getPrograms()
									+ "',"
									+ "'"
									+ myForm.getSubPrograms()
									+ "',"
									+ "'"
									+ myForm.getUserId()
									+ "',"
									+ "to_date('"
									+ datenewformat
									+ "','dd/mm/yyyy'),"
									+ "to_date('"
									+ datenewformat
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getNoOfHabs()
									+ "'"
									+ ",'"
									+ proposalHolder.getProposalName()
									+ "',"
									+ "'"
									+ proposalHolder.getProposalId()
									+ "',"
									+ "'"
									+ proposalHolder.getWorkType()
									+ "',"
									+ "'"
									+ proposalHolder.getSusType()
									+ "',"
									+ "'"
									+ myForm.getAugsch()
									+ "',"
									+ "'"
									+ myForm.getTypeOfAsset()
									+ "',"
									+ "'"
									+ myForm.getWorkCat()
									+ "',"
									+ "'"
									+ myForm.getPlan()
									+ "',"
									+ "'"
									+ myForm.getWrktype()
									+ "',"
									+ "'"
									+ myForm.getWorkCat()
									+ "',"
									+ "'"
									+ proposalHolder.getAdminiStrativeNum()
									+ "',"
									+ "to_date('"
									+ proposalHolder.getAdminiStrativeDate()
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getSanctionAmout()
									+ "',"
									+ "'"
									+ proposalHolder.getTsno()
									+ "',"
									+ "to_date('"
									+ proposalHolder.getTsdate()
									+ "','dd/mm/yyyy'),"
									+ "'"
									+ proposalHolder.getTsamt()
									+ "',"
									+ "'"
									+ proposalHolder.getSsryr()
									+ "',"
									+ "'"
									+ proposalHolder.getSrhabcode() + "'";
							if (sourcecode != null && !sourcecode.equals("")) {
								stype = Integer.parseInt(proposalDAO
										.getSourceValue(sourcecode));
								query += ",'" + stype + "'";
							}
							if (subsourcecode != null
									&& !subsourcecode.equals("")) {
								substype = Integer
										.parseInt(proposalDAO
												.getSubSourceValue(stype,
														subsourcecode));
								query += ",'" + substype + "'";
							}
							query += ",'" + proposalHolder.getScrcode() + "',"
									+ "'" + proposalHolder.getSrname() + "',"
									+ "'" + proposalHolder.getSrloc() + "',"
									+ "'" + proposalHolder.getAstcode() + "',"
									+ "'" + asttype + "'," + "to_date('"
									+ proposalHolder.getSitedate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getGrounddate()
									+ "','dd/mm/yyyy')," + "'"
									+ proposalHolder.getExpupto() + "',"
									+ "to_date('"
									+ proposalHolder.getExpuptodate()
									+ "','dd/mm/yyyy')," + "'"
									+ proposalHolder.getNotpaidvalue() + "',"
									+ "to_date('"
									+ proposalHolder.getCompdate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getFincompdate()
									+ "','dd/mm/yyyy')," + "to_date('"
									+ proposalHolder.getCommdate()
									+ "','dd/mm/yyyy')," + "'"
									+ myForm.getProoved() + "'," + "'"
									+ proposalHolder.getRemarks() + "')";

						}

						stat.addBatch(query);

					}

				}
				int[] updateCounts = stat.executeBatch();

				boolean flag = true;
				for (int i = 0; i < total; i++) {
					if (updateCounts[i] != 1)
						flag = false;
				}
				if (flag) {

					DroughtDAO d = new DroughtDAO(dataSource);
					conn.commit();
					conn.setAutoCommit(true);
					session.removeAttribute("selectedHabs");
					session.removeAttribute("constituencies");
					session.removeAttribute("RepresentativeProposalForm");
					session.removeAttribute("tempSelectedAdmnHabs");
					session.removeAttribute("rwsWorkAdmnProgLnkTmp");
					session.removeAttribute("proposalsHabs");
					session.removeAttribute("habsarray");
					session.removeAttribute("sourceType");
					session.removeAttribute("subsourceType");
					session.removeAttribute("UpdateAddedProgragsForRevise");
					session.removeAttribute("AddNewForRev");

					if (work_id_available) {
						message = "Record(s) inserted successfully ,With a new Work Id:"
								+ proposalHolder.getProposalId() + "";
					} else {
						message = "Record(s) inserted successfully!";
					}
					session.setAttribute("GlobalConstants.Message", message);

				}

			}

			catch (Exception e) {
				Debug.writeln("Exception in Administrative Action : "
						+ e.getClass() + "-" + e.getMessage());

				message = "Cannot insert record!";

				session.setAttribute("GlobalConstants.Message", message);
				target = "failure1";
			} finally {
				if (stat != null) {
					try {
						stat.close();
					} catch (SQLException sqle) {
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException sqle) {
					}
				}
			}
		    }
		}
		if (mode != null && mode.equals("view-success")) {

			String circleoffice = myForm.getCircleOfficeCode();
			session.removeAttribute("selectedHabs");
			officeCode = user.getOfficeCode();

			String category = myForm.getWorkCat();

			String scheme = myForm.getTypeOfAsset();

			String subprogram = myForm.getSubPrograms();

			String program = myForm.getPrograms();
			DroughtDAO proposalDAO = new DroughtDAO(dataSource);
			session.removeAttribute("AdministrativeSanctionList1");
			ArrayList adminiStrativeSanctionList1 = proposalDAO
					.getAdminstrativeSanctionView(officeCode,
							myForm.getCircleOfficeCode(),
							myForm.getDivisionOfficeCode(),
							myForm.getSubdivisionOfficeCode(), category,
							scheme, program, subprogram, myForm.getPlan());
			session.setAttribute("AdministrativeSanctionList1",
					adminiStrativeSanctionList1);
			myForm.setAdministrativeSanctionList1(adminiStrativeSanctionList1);
			target = new String("view-success");
		}

		if (mode != null && mode.equals("Update")) {
			
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			WorksData1 worksData = new WorksData1(dataSource);
			String serversysdate = worksData.getServerDate();
			int stype = 0, substype = 0;

			DroughtDAO proposalDAO = new DroughtDAO();
			String sourcecode = request.getParameter("sourcecode");
			String subsourcecode = request.getParameter("subsourcecode");
			String asttype = (String) request.getParameter("asttype");
			String newextvalue = "";
			Statement stat=null;
			try {
				conn = RwsOffices.getConn();
				stat = conn.createStatement();
				ArrayList works = myForm.getProposals();

				Iterator iter = works.iterator();
				String[] habCodes = request.getParameterValues("habcount");
				while (iter.hasNext()) {
					DroughtHolder element = (DroughtHolder) iter.next();
					{

						if (element.getNewext() != null
								&& !element.getNewext().equals("")
								&& element.getNewext().equals("on")) {
							newextvalue = "Y";
						} else
							newextvalue = "";

						query = " UPDATE rws_drought_works_tbl SET "
								+ "   UPDATE_DATE  = to_date('" + serversysdate
								+ "','dd/mm/yyyy')," + "   HABITATION_CODE='"
								+ element.getNoOfHabs() + "', "
								+ "   WORK_NAME = '"
								+ element.getProposalName() + "', "
								+ "   ADMIN_NO  = '"
								+ element.getAdminiStrativeNum() + "', "
								+ "   ADMIN_DATE= to_date('"
								+ element.getAdminiStrativeDate()
								+ "','dd/mm/yyyy'), " + "   ADMIN_AMOUNT  = '"
								+ element.getSanctionAmout() + "' ";
						if (element.getTsno() != null) {
							query += " ,TS_NO = '" + element.getTsno() + "'";
						}

						if (element.getTsdate() != null) {
							query += " ,TS_DATE     = to_date('"
									+ element.getTsdate() + "','dd/mm/yyyy') ";
						}
						if (element.getTsamt() != null) {
							query += " , TS_AMOUNT   = '" + element.getTsamt()
									+ "' ";
						}
						if (element.getSsryr() != null) {
							query += ",  SSR_YEAR    = '" + element.getSsryr()
									+ "' ";
						}
						if (element.getSrhabcode() != null) {
							query += " ,  SOURCE_HAB_CODE = '"
									+ element.getSrhabcode() + "' ";
						}
						if (sourcecode != null && !sourcecode.equals("")) {
							stype = Integer.parseInt(proposalDAO
									.getSourceValue(sourcecode));
							query += " ,  SOURCE_TYPE_CODE  = '" + stype + "' ";
						}
						if (subsourcecode != null && !subsourcecode.equals("")) {
							substype = Integer.parseInt(proposalDAO
									.getSubSourceValue(stype, subsourcecode));
							query += " ,  SUBSOURCE_TYPE_CODE = '" + substype
									+ "' ";
						}
						if (element.getScrcode() != null) {
							query += ",   SOURCE_CODE    = '"
									+ element.getScrcode() + "' ";
						}
						if (element.getSrname() != null) {
							query += ",   SOURCE_NAME     = '"
									+ element.getSrname() + "' ";
						}
						if (element.getSrloc() != null) {
							query += " ,  SOURCE_LOCATION  = '"
									+ element.getSrloc() + "' ";
						}
						if (element.getAstcode() != null) {
							query += " ,  ASSET_CODE  = '"
									+ element.getAstcode() + "' ";
						}
						if (element.getAstcode() != null
								&& element.getAstcode() != "") {
							query += " ,  NEW_EXISTING     = 'Y' ";
						}
						if (element.getSitedate() != null) {
							query += " ,  SITE_HAND_OVER_DATE  = to_date('"
									+ element.getSitedate()
									+ "','dd/mm/yyyy') ";
						}
						if (element.getGrounddate() != null) {
							query += ",   GROUNDING_DATE   = to_date('"
									+ element.getGrounddate()
									+ "','dd/mm/yyyy')";
						}
						if (element.getExpupto() != null) {
							query += " ,  EXPENDITURE_UPTO     = '"
									+ element.getExpupto() + "' ";
						}
						if (element.getExpuptodate() != null) {
							query += ",   EXPENDITURE_UPTO_DT = to_date('"
									+ element.getExpuptodate()
									+ "','dd/mm/yyyy')";
						}
						if (element.getNotpaidvalue() != null) {
							query += ",   VALUE_OF_WORK_NOT_PAID = '"
									+ element.getNotpaidvalue() + "' ";
						}
						if (element.getCompdate() != null) {
							query += ",   DATE_OF_COMPLETION  =to_date( '"
									+ element.getCompdate() + "','dd/mm/yyyy')";
						}
						if (element.getFincompdate() != null) {
							query += " ,  DT_FIN_COMPLETION  = to_date('"
									+ element.getFincompdate()
									+ "','dd/mm/yyyy')";
						}
						if (element.getCommdate() != null) {
							query += " ,  DATE_OF_COMM   = to_date('"
									+ element.getCommdate() + "','dd/mm/yyyy')";
						}
						if (element.getRemarks() != null) {
							query += " ,  REMARKS    = '"
									+ element.getRemarks() + "' ";
						}

						query += "   WHERE work_id = '"
								+ element.getProposalId() + "'";
						stat.addBatch(query);

						int[] updateCounts = stat.executeBatch();
						boolean flag = true;
						for (int i = 0; i < updateCounts.length; i++) {
							if (updateCounts[i] != 0)
								flag = true;
						}

						if (flag) {
							message = "Record(s) Updated successfully!";
							session.setAttribute("GlobalConstants.Message",
									message);
							conn.commit();
							conn.setAutoCommit(true);
							session.removeAttribute("habs");
						}

					}
				}
				target = "update-success";
			} catch (Exception e) {
				e.printStackTrace();
				message = "Cannot insert record!";
				session.setAttribute("GlobalConstants.Message", message);
				target = "update-success";
			}
		    }
		}

		if (mode != null && mode.equals("Delete")) {
			ArrayList viewlist = myForm.getAdministrativeSanctionList1();
			String workId = request.getParameter("proposalId");
			DroughtDAO proposalDAO = new DroughtDAO(getDataSource(request));
			DroughtDAOMessage daoMessage = proposalDAO
					.deleteAdminiStrativeDetails(workId, viewlist);
			request.setAttribute("message", daoMessage.getMessage());
			target = new String("view-success");
		}

		return mapping.findForward(target);
	}

	public void reset(Rws_Drought_Admin_Sanction_Frm myForm) {
		myForm.setRepCode("");
		myForm.setConstituencyCode("");
		myForm.setRepName("");
		myForm.setRepAddress("");
		myForm.setRepDate("");
		myForm.setDescription("");
		myForm.setEndorsementNo("");
		myForm.setEndorsementDate("");
		myForm.setEndorsedBy("");
		myForm.setRecommendations("");
		myForm.setInit(true);
		myForm.setSelectedHabCode("");
		myForm.setCircleOfficeCode("");
		myForm.setDivisionOfficeCode("");
		myForm.setTypeOfAsset("");
		myForm.setWorkCat("");
		myForm.setPrograms("");
		myForm.setSubPrograms("");
		myForm.setSubdivisionOfficeCode("");
		myForm.setPlan("");
		myForm.setWrktype("");
		myForm.setAugsch("");
		myForm.setProoved("");
		myForm.setSustainDetails("");
		myForm.setTsno("");
		myForm.setTsdate("");
		myForm.setTsamt("");
		myForm.setSsryr("");
		myForm.setSrhabcode("");
		myForm.setSrtypecode("");
		myForm.setAstcode("");
		myForm.setCommdate("");
		myForm.setCompdate("");
		myForm.setSubsrtypecode("");
		myForm.setSrname("");
		myForm.setSrloc("");
		myForm.setSitedate("");
		myForm.setGrounddate("");
		myForm.setExpupto("");
		myForm.setExpuptodate("");
		myForm.setFincompdate("");
		myForm.setNewext("");
		myForm.setNotpaidvalue("");
		if (myForm.getProposals() != null) {
			Iterator iterator = myForm.getProposals().iterator();

			DroughtHolder proposalHolder = null;
			while (iterator.hasNext()) {
				proposalHolder = (DroughtHolder) iterator.next();
				proposalHolder.setEstimateCost("");
				proposalHolder.setAdminiStrativeDate("");
				proposalHolder.setAdminiStrativeNum("");
				proposalHolder.setSpillOver("");
				proposalHolder.setNoOfHabs("");
				proposalHolder.setProposalName("");
				proposalHolder.setSanctionAmout("");
				proposalHolder.setProposalId("");
				proposalHolder.setProposalName("");
				proposalHolder.setWorkType("");
				proposalHolder.setRemarks("");
				proposalHolder.setNoOfSources("");
				proposalHolder.setTsno("");
				proposalHolder.setTsamt("");
				proposalHolder.setTsdate("");
				proposalHolder.setSsryr("");
				proposalHolder.setSrhabcode("");
				proposalHolder.setSrtypecode("");
				proposalHolder.setAstcode("");
				proposalHolder.setCommdate("");
				proposalHolder.setCompdate("");
				proposalHolder.setSubsrtypecode("");
				proposalHolder.setSrname("");
				proposalHolder.setSrloc("");
				proposalHolder.setSitedate("");
				proposalHolder.setGrounddate("");
				proposalHolder.setExpupto("");
				proposalHolder.setExpuptodate("");
				proposalHolder.setFincompdate("");
				proposalHolder.setNewext("");
				proposalHolder.setNotpaidvalue("");
			}

		}

	}
}
