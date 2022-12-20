package nic.watersoft.works;

import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.DAOMessage;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.commons.beanutils.PropertyUtils;

public class Rws_EOAT_Frm_Act extends Action {
	String months[] = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
	Calendar calendar = Calendar.getInstance();
	String date = calendar.get(Calendar.DATE) + "-" + months[calendar.get(Calendar.MONTH)] + "-"
			+ calendar.get(Calendar.YEAR);
	String workcategory = "";

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		Rws_EOAT_form frm = (Rws_EOAT_form) form;
		HttpSession session = request.getSession();
		RwsUser rwsUser = (RwsUser) session.getAttribute("RWS_USER");
		if (rwsUser == null)
			return mapping.findForward("expire");

		if (!(rwsUser.getUserId() != null && (rwsUser.getUserId().equals(Constants.ADMIN)
				|| rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsEEUser(rwsUser.getUserId())
				|| Constants.IsAOUser(rwsUser.getUserId()) || Constants.IsUser(rwsUser.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		CommonLists commonLists = new CommonLists(getDataSource(request));
		String mode = request.getParameter("mode");

		Rws_EOAT_Data eoatData = new Rws_EOAT_Data();
		try {
			if (mode != null && mode.equals("init")) {
				frm.setCircleOfficeCode(rwsUser.getCircleOfficeCode());
				frm.setDivisionOfficeCode(rwsUser.getDivisionOfficeCode());
				frm.setSubDivisionOfficeCode(rwsUser.getSubdivisionOfficeCode());
				initialiseLists(request, frm, rwsUser);
			}

			if (mode != null && mode.equals("eoatFrm")) {
				initialiseLists(request, frm, rwsUser);
			}

			if (mode != null && mode.equals("workIdChanged")) {

				ArrayList programmesList = eoatData.getProgrammes(frm.getWorkId());
				session.setAttribute("programmesList", programmesList);
				String costList = eoatData.getCostList(frm.getWorkId());
				frm.setCostOfWork(costList);
				ArrayList officers = eoatData.getOfficers(frm.getCircleOfficeCode(), frm.getDivisionOfficeCode(),
						frm.getSubDivisionOfficeCode());
				session.setAttribute("officers", officers);
				String preparedby = rwsUser.getUserId();
				frm.setPreparedBy(preparedby);
				String doc = eoatData.getDoc(frm.getWorkId());
				frm.setDateOfCompletion(doc);
			}

			if (mode != null && mode.equals("save")) {

				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					Rws_EOAT_bean bean = new Rws_EOAT_bean();
					PropertyUtils.copyProperties(bean, frm);
					DAOMessage daoMessage = null;
					daoMessage = eoatData.insertEoat(bean);
					request.setAttribute("message", daoMessage.getMessage());
					reset(frm);
				}
			}

			if (mode != null && mode.equals("view")) {
				ArrayList eoatList = eoatData.getEoatView(frm.getCircleOfficeCode(), frm.getDivisionOfficeCode(),
						frm.getSubDivisionOfficeCode(), frm.getWorkId());
				session.setAttribute("eoatList", eoatList);
			}

			if (mode != null && mode.equals("eoatEdit")) {
				Rws_EOAT_bean bean = new Rws_EOAT_bean();
				PropertyUtils.copyProperties(bean, frm);
				bean = eoatData.getEoat(request.getParameter("orderno"));
				PropertyUtils.copyProperties(frm, bean);
				ArrayList officers = eoatData.getOfficers(bean.getCircleOfficeCode(), bean.getDivisionOfficeCode(),
						bean.getSubDivisionOfficeCode());
				session.setAttribute("officers", officers);

			}

			if (mode != null && mode.equals("update")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					Rws_EOAT_bean bean = new Rws_EOAT_bean();
					PropertyUtils.copyProperties(bean, frm);
					DAOMessage daoMessage = null;
					daoMessage = eoatData.updateEoat(bean);
					request.setAttribute("message", daoMessage.getMessage());
					mode = "close";
				}
			}

			if (mode != null && mode.equals("delete")) {
				int rcount = 0;
				String msg = null;
				rcount = eoatData.deleteEoat(frm.getWorkId(), request.getParameter("orderno"));
				if (rcount > 0) {
					msg = "Record Deleted Successfully";
					mode = "close";
				} else {
					msg = "Record can not be deleted";
				}
				request.setAttribute("message", msg);
			}

		} catch (Exception e) {
			Debug.println(" Exception in EOAT Act:" + e);
		}
		return mapping.findForward(mode);
	}

	public void initialiseLists(HttpServletRequest request, Rws_EOAT_form frm, RwsUser rwsUser) {
		try {

			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			CommonLists commonLists = new CommonLists(getDataSource(request));
			Rws_EOAT_Data eoatData = new Rws_EOAT_Data();
			HttpSession session = request.getSession();

			ArrayList circles = rwsOffices.getCircles4EOAT();
			session.setAttribute("circles", circles);

			ArrayList divisions = rwsOffices.getDivisions4EOAT(frm.getCircleOfficeCode());
			session.setAttribute("divisions", divisions);

			ArrayList subdivisions = rwsOffices.getSubdivisions4EOAT(frm.getCircleOfficeCode(),
					frm.getDivisionOfficeCode());
			session.setAttribute("subdivisions", subdivisions);

			session.setAttribute("circleOfficeName", rwsOffices.getCircleOfficeName(getDataSource(request),
					rwsUser.getHeadOfficeCode(), frm.getCircleOfficeCode()));
			session.setAttribute("divisionOfficeName", rwsOffices.getDivisionOfficeName(getDataSource(request),
					rwsUser.getHeadOfficeCode(), frm.getCircleOfficeCode(), frm.getDivisionOfficeCode()));
			session.setAttribute("subDivisionOfficeName",
					rwsOffices.getSubDivisionOfficeName(getDataSource(request), rwsUser.getHeadOfficeCode(),
							frm.getCircleOfficeCode(), frm.getDivisionOfficeCode(), frm.getSubDivisionOfficeCode()));

			workcategory = frm.getWorkCategory();

			ArrayList workIdList = eoatData.getWorkIdsEligibleForEoat(frm.getCircleOfficeCode(),
					frm.getDivisionOfficeCode(), frm.getSubDivisionOfficeCode(), date, workcategory);
			session.setAttribute("workIdList", workIdList);
		} catch (Exception e) {
			Debug.println("Exception occured initial lists of Rws_EOAT_form_Act :" + e);
		}
	}

	public void reset(Rws_EOAT_form frm) {
		frm.setWorkId("");
		frm.setProgrammeCode("");
		frm.setCostEsclationSought("");
		frm.setCostOfWork("");
		frm.setDateOfCompletion("");
		frm.setEoatOrderNo("");
		frm.setEoatDate("");
		frm.setEoatGrantAuthority("");
		frm.setEoatOldRefDate1("");
		frm.setEoatOldRefDate2("");
		frm.setEoatOldRefNo1("");
		frm.setEoatOldRefNo2("");
		frm.setEoatPeriod("");
		frm.setExemptRecommendedBySE("");
		frm.setEeRecommend("");
		frm.setValueOfWorkBeyondAgreement("");
		frm.setValueOfWorkDone("");
		frm.setValueOfWorkToBeDone("");
		frm.setFineImposed("");
		frm.setFineRecovered("");
		frm.setOfficerResponsible1("");
		frm.setOfficerResponsible2("");
		frm.setOfficerResponsible3("");
		frm.setAeeRecommend("");
		frm.setAgreementCopyPenaltyUpd("");
		frm.setDeeRecommend("");
		frm.setSeRecommend("");
		frm.setCeRecommend("");
		frm.setTotalDaysExemptBySe("");
		frm.setRateOfPenalty("");
		frm.setTotalPenalty("");
		frm.setReasonsByContractor("");
		frm.setReasonsForNotRecoveringFine("");
		frm.setCeRecommend("");
		frm.setSuppDocumentForExempUpd("");
		frm.setSuppAgreeDt("");
		frm.setSuppAgreeNo("");
		frm.setPreparedBy("");
		frm.setPreparedDate("");
	}
}