package nic.watersoft.masters;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class rws_HabStatusEntryAct_frm extends Action {
	int[] rcount;
	Collection habInsts = new ArrayList();
	Collection habWaterSupply = new ArrayList();
	Collection contaminations = new ArrayList();

	protected ActionForm buildHabStatusForm(String habCode, HttpServletRequest request) throws Exception {
		nic.watersoft.commons.CommonLists commonLists = new nic.watersoft.commons.CommonLists(getDataSource(request));
		HabStatusForm form = null;
		form = new HabStatusForm();
		ArrayList coverageStatuses = new ArrayList();
		RwsHabStatusData rwsHabStatusData = new RwsHabStatusData();
		ArrayList institutes = new ArrayList();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		coverageStatuses = commonLists.getCoverageStatuses(habCode, userId);
		session.setAttribute("coverageStatuses", coverageStatuses);
		RwsMaster rwsMaster1 = rwsHabStatusData.getHabSupplyStatus(habCode, getDataSource(request));
		if (rwsMaster1 != null) {
			form = new HabStatusForm();
			form.setCircleOfficeCode(rwsMaster1.getCircleOfficeCode());
			form.setDivisionOfficeCode(rwsMaster1.getDivisionOfficeCode());
			form.setSubdivisionOfficeCode(rwsMaster1.getSubdivisionOfficeCode());
			form.setCon(rwsMaster1.getCon());
			form.setDon(rwsMaster1.getDon());
			form.setSdon(rwsMaster1.getSdon());
			form.setMandal(rwsMaster1.getMandal());
			form.setMandalName(rwsMaster1.getMandalName());
			form.setDcode(rwsMaster1.getDcode());
			form.setDistrict(rwsMaster1.getDistrict());
			form.setHabName(rwsMaster1.getHabName());
			form.setHabCode(rwsMaster1.getHabCode());
			form.setPcode(rwsMaster1.getPCode());
			form.setVcode(rwsMaster1.getVCode());
			form.setPname(rwsMaster1.getPName());
			form.setVname(rwsMaster1.getVName());
			form.setCensusPop(rwsMaster1.getCensusPop());
			form.setCensusYear(rwsMaster1.getCensusYear());
			form.setCensusSc(rwsMaster1.getCensusSc());
			form.setCensusMinority(rwsMaster1.getCensusMinority());
			form.setFloatPop(rwsMaster1.getFloatPop());
			form.setCensusSt(rwsMaster1.getCensusSt());
			form.setPlainHCon(rwsMaster1.getPlainHCon());
			form.setPlainHHold(rwsMaster1.getPlainHHold());
			form.setScHCon(rwsMaster1.getScHCon());
			form.setScHHold(rwsMaster1.getScHHold());
			form.setStHCon(rwsMaster1.getStHCon());
			form.setStHHold(rwsMaster1.getStHHold());
			form.setMinorityHCon(rwsMaster1.getMinorityHCon());
			form.setMinorityHHold(rwsMaster1.getMinorityHHold());
			form.setLatitude(rwsMaster1.getLatitude());
			form.setLongitude(rwsMaster1.getLongitude());
			form.setElevation(rwsMaster1.getElevation());
			form.setWaypoint(rwsMaster1.getWaypoint());
			form.setLandmark(rwsMaster1.getLandmark());
			form.setFloatReason(rwsMaster1.getFloatReason());
			form.setTotPop(rwsMaster1.getTotalPop());
			form.setNetPop(rwsMaster1.getNetPop());
			form.setHabYear(rwsMaster1.getHabYear());
			form.setPopCovered(rwsMaster1.getPopCovered());
			form.setScCovered(rwsMaster1.getScCovered());
			form.setStCovered(rwsMaster1.getStCovered());
			form.setMinorityCovered(rwsMaster1.getMinorityCovered());
			form.setTotPopCvrd(rwsMaster1.getTotalCovered());
			form.setTotalWaterSupply(rwsMaster1.getTotalWaterSupply());
			form.setExistWaterLevel(rwsMaster1.getExistWaterLevel());
			form.setNearWaterSource(rwsMaster1.getNearWaterSource());
			form.setNearWaterGroundSource(rwsMaster1.getNearWaterGroundSource());
			form.setNcSourceType(rwsMaster1.getNcSourceType());
			form.setSourceDistance(rwsMaster1.getSourceDistance());
			form.setCoveredStatus(rwsMaster1.getCoveredStatus());
			form.setRemarks(rwsMaster1.getRemarks());
			form.setQualityAffected(rwsMaster1.getQualityAffected());
			form.setButtonName("Update");

			form.setShpSupply(rwsMaster1.getShpSupply());
			form.setShpNo(rwsMaster1.getShpNo());
			form.setCisternsSupply(rwsMaster1.getCisternsSupply());
			form.setCisternsNo(rwsMaster1.getCisternsNo());
			form.setGlsrSupply(rwsMaster1.getGlsrSupply());
			form.setGlsrNo(rwsMaster1.getGlsrNo());
			form.setOhsrSupply(rwsMaster1.getOhsrSupply());
			form.setOhsrNo(rwsMaster1.getOhsrNo());

			form.setDrinkTotalSupply(rwsMaster1.getDrinkTotalSupply());
			form.setDrinkTotalNo(rwsMaster1.getDrinkTotalNo());

			form.setHpSupply(rwsMaster1.getHpSupply());
			form.setHpNo(rwsMaster1.getHpNo());
			form.setOwsSupply(rwsMaster1.getOwsSupply());
			form.setOwsNo(rwsMaster1.getOwsNo());
			form.setPondsSupply(rwsMaster1.getPondsSupply());
			form.setPwsUnsafeNo(rwsMaster1.getPwsUnsafeNo());
			form.setPwsUnsafeSupply(rwsMaster1.getPwsUnsafeSupply());
			form.setMpwsUnsafeNo(rwsMaster1.getMpwsUnsafeNo());
			form.setMpwsUnsafeSupply(rwsMaster1.getMpwsUnsafeSupply());

			form.setOthersSafeeNo(rwsMaster1.getOthersSafeeNo());
			form.setOthersSafeSupply(rwsMaster1.getOthersSafeSupply());
			form.setPondsNo(rwsMaster1.getPondsNo());
			form.setShwSupply(rwsMaster1.getShwSupply());
			form.setShwNo(rwsMaster1.getShwNo());
			form.setSafeSHPNo(rwsMaster1.getSafeSHPNo());
			form.setSafeSHPSupply(rwsMaster1.getSafeSHPSupply());

			form.setOtherTotalSupply(rwsMaster1.getOtherTotalSupply());
			form.setOtherTotalNo(rwsMaster1.getOtherTotalNo());

			form.setPcpdDrink(rwsMaster1.getPcpdDrink());
			form.setPcpdOthers(rwsMaster1.getPcpdOthers());
			form.setPcpdTotal(rwsMaster1.getPcpdTotal());

			form.setTotalWaterSupply(rwsMaster1.getTotalWaterSupply());
			form.setLevelOfWaterSupply(rwsMaster1.getLevelOfWaterSupply());
			form.setLpcdCooking(rwsMaster1.getLpcdCooking());

			form.setStatus(rwsMaster1.getStatus());
			form.setPrevYrStatus(rwsMaster1.getPrevYrStatus());
			form.setHabType(rwsMaster1.getHabType());
			form.setHabSubType(rwsMaster1.getHabSubType());
			form.setHouseHold(rwsMaster1.getHouseHold());
			form.setHouseConn(rwsMaster1.getHouseConn());
			form.setHabCat(rwsMaster1.getHabCat());

			form.setExistSource(rwsMaster1.getExistSource());
			form.setSafeSource(rwsMaster1.getSafeSource());

			form.setPublicTap(rwsMaster1.getPublicTap());
			form.setPublicStandpost(rwsMaster1.getPublicStandpost());

			form.setExistCheckDams(rwsMaster1.getExistCheckDams());
			form.setReqCheckDams(rwsMaster1.getReqCheckDams());

			form.setCattles(rwsMaster1.getCattles());
			form.setIsMinorityHab(rwsMaster1.getIsMinorityHab());
			form.setIsLwe(rwsMaster1.getIsLwe());
			form.setUnsafeLpcd(rwsMaster1.getUnsafeLpcd());

			form.setGlsrno(rwsMaster1.getGlsrno());
			form.setGlsrqty(rwsMaster1.getGlsrno());
			form.setOhsrno(rwsMaster1.getOhsrno());
			form.setOhsrqty(rwsMaster1.getOhsrqty());
			form.setSchemesource(rwsMaster1.getSchemesource());

			Collection institutes1 = rwsMaster1.getHabInsts();
			if (institutes1 != null && institutes1.size() > 0) {
				habInsts = new ArrayList(institutes1);
				form.setHabInsts(habInsts);
			} else {
				institutes = rwsHabStatusData.getInstitutes(getDataSource(request));
				if (habInsts.size() > 0)
					habInsts.clear();
				if (institutes.size() != 0) {
					for (int i = 0; i < institutes.size(); i++) {
						rwsMaster1 = (RwsMaster) institutes.get(i);
						habInsts.add(new HabInstitute(rwsMaster1.getInstituteCode(), rwsMaster1.getInstituteName()));
					}
					form.setHabInsts(habInsts);
				}
			}
			Collection contaminations1 = rwsMaster1.getContaminations();
			if (contaminations1 != null && contaminations1.size() > 0) {
				contaminations = new ArrayList(contaminations1);
				form.setContaminations(contaminations);
			} else {
				contaminations1 = (ArrayList) rwsHabStatusData.getContamNames(getDataSource(request));
				for (int i = 0; i < contaminations1.size(); i++) {
					rwsMaster1 = (RwsMaster) ((ArrayList) contaminations1).get(i);
					contaminations.add(new ContaminationTypes(rwsMaster1.getContamName()));
				}
				form.setContaminations(contaminations);
				session.setAttribute("contaminations", contaminations);
			}
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		System.gc();
		String message = null;
		String displaymess = null;
		ArrayList habstatus = null;
		RwsMaster rwsMaster = new RwsMaster();
		HabStatusForm frm = (HabStatusForm) form;
		String mode = frm.getMode();
		HttpSession session = request.getSession();
		RwsHabStatusData rwsHabStatusData = new RwsHabStatusData();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
						|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		if (session.getAttribute("coverageStatuses") == null)
			session.setAttribute("coverageStatuses", new ArrayList());
		if (mode.equalsIgnoreCase("View")) {
			try {
				frm.getSubdivisionOfficeCode();
				habstatus = rwsHabStatusData.getHabStatuss(frm.getCircleOfficeCode(), frm.getDivisionOfficeCode(),
						frm.getSubdivisionOfficeCode(), frm.getDcode(), frm.getMandal(), frm.getPcode(), frm.getVcode(),
						getDataSource(request), user.getUserId());
				session.setAttribute("habstatus", habstatus);
			} catch (Exception e) {
				Debug.println(e + "");
			}
		}

		if (mode.equalsIgnoreCase("Save")) {
			try {
				rwsMaster.setActPlainPop(frm.getActPlainPop());
				rwsMaster.setActScPop(frm.getActScPop());
				rwsMaster.setActStPop(frm.getActStPop());
				rwsMaster.setActHouseHold(frm.getActHouseHold());
				rwsMaster.setActHouseConn(frm.getActHouseConn());
				rwsMaster.setActTotPop(frm.getActTotPop());
				rwsMaster.setCircleOfficeCode(frm.getCircleOfficeCode());
				rwsMaster.setDivisionOfficeCode(frm.getDivisionOfficeCode());
				rwsMaster.setSubdivisionOfficeCode(frm.getSubdivisionOfficeCode());
				rwsMaster.setHabCode(frm.getHabCode());
				rwsMaster.setCensusYear(frm.getCensusYear());
				rwsMaster.setHabYear(frm.getHabYear());
				rwsMaster.setCensusPop(frm.getCensusPop());
				rwsMaster.setCensusSc(frm.getCensusSc());
				rwsMaster.setCensusMinority(frm.getCensusMinority());
				rwsMaster.setCensusSt(frm.getCensusSt());
				rwsMaster.setFloatPop(frm.getFloatPop());
				rwsMaster.setFloatReason(frm.getFloatReason());
				rwsMaster.setPopCovered(frm.getPopCovered());
				rwsMaster.setScCovered(frm.getScCovered());
				rwsMaster.setStCovered(frm.getStCovered());
				rwsMaster.setMinorityCovered(frm.getMinorityCovered());
				rwsMaster.setPlainHCon(frm.getPlainHCon());
				rwsMaster.setPlainHHold(frm.getPlainHHold());
				rwsMaster.setScHCon(frm.getScHCon());
				rwsMaster.setScHHold(frm.getScHHold());
				rwsMaster.setStHCon(frm.getStHCon());
				rwsMaster.setStHHold(frm.getStHHold());
				rwsMaster.setMinorityHCon(frm.getMinorityHCon());
				rwsMaster.setMinorityHHold(frm.getMinorityHHold());
				rwsMaster.setLatitude(frm.getLatitude());
				rwsMaster.setLongitude(frm.getLongitude());
				rwsMaster.setElevation(frm.getElevation());
				rwsMaster.setWaypoint(frm.getWaypoint());
				rwsMaster.setLandmark(frm.getLandmark());
				rwsMaster.setCoveredStatus(frm.getCoveredStatus());
				rwsMaster.setTotalWaterSupply(frm.getTotalWaterSupplySafe());
				rwsMaster.setLevelOfWaterSupply(frm.getLevelOfWaterSupply());
				rwsMaster.setLpcdCooking(frm.getLpcdCooking());
				rwsMaster.setNearWaterSource(frm.getNearWaterSource());
				rwsMaster.setNearWaterGroundSource(frm.getNearWaterGroundSource());
				rwsMaster.setNcSourceType(frm.getNcSourceType());
				rwsMaster.setSourceDistance(frm.getSourceDistance());
				rwsMaster.setRemarks(frm.getRemarks());
				rwsMaster.setQualityAffected(frm.getQualityAffected());
				rwsMaster.setContamName(frm.getContType());

				rwsMaster.setIron(Double.parseDouble(frm.getIron()));
				rwsMaster.setFlouride(Double.parseDouble(frm.getFlouride()));
				rwsMaster.setBrakish(Double.parseDouble(frm.getBrakish()));
				rwsMaster.setAresenic(Double.parseDouble(frm.getAresenic()));
				rwsMaster.setNitrate(Double.parseDouble(frm.getNitrate()));
				rwsMaster.setStatusAsOn1405(frm.getStatusAsOn1405());
				rwsMaster.setProposedFcYr(frm.getProposedFcYr());
				rwsMaster.setProposedFCAmt(frm.getProposedFCAmt());
				rwsMaster.setOthersNo(frm.getOthersNo());
				rwsMaster.setOthersSupply(frm.getOthersSupply());

				rwsMaster.setSafeSHPNo(frm.getSafeSHPNo());
				rwsMaster.setSafeSHPSupply(frm.getSafeSHPSupply());
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
				rwsMaster.setUpdateDate(sdf.format(new java.util.Date()));

				rwsMaster.setHpSupply(frm.getHpSupply());
				rwsMaster.setHpNo(frm.getHpNo());
				rwsMaster.setPwsNo(frm.getPwsNo());
				rwsMaster.setPwsSupply(frm.getPwsSupply());
				rwsMaster.setCpwsNo(frm.getCpwsNo());
				rwsMaster.setCpwsSupply(frm.getCpwsSupply());
				rwsMaster.setMpwsNo(frm.getMpwsNo());
				rwsMaster.setMpwsSupply(frm.getMpwsSupply());
				rwsMaster.setOthersSafeeNo(frm.getOthersSafeeNo());
				rwsMaster.setOthersSafeSupply(frm.getOthersSafeSupply());
				rwsMaster.setDpNo(frm.getDpNo());
				rwsMaster.setDpSupply(frm.getDpSupply());
				rwsMaster.setCpwsNo(frm.getCpwsNo());
				rwsMaster.setCpwsSupply(frm.getCpwsSupply());
				rwsMaster.setOwsSupply(frm.getOwsSupply());
				rwsMaster.setOwsNo(frm.getOwsNo());
				rwsMaster.setPondsSupply(frm.getPondsSupply());
				rwsMaster.setPondsNo(frm.getPondsNo());
				rwsMaster.setDwNo(frm.getDwNo());
				rwsMaster.setDwSupply(frm.getDwSupply());
				rwsMaster.setShpSupply(frm.getShpSupply());
				rwsMaster.setShpNo(frm.getShpNo());

				rwsMaster.setPwsUnsafeNo(frm.getPwsUnsafeNo());
				rwsMaster.setPwsUnsafeSupply(frm.getPwsUnsafeSupply());
				rwsMaster.setMpwsUnsafeNo(frm.getMpwsUnsafeNo());
				rwsMaster.setMpwsUnsafeSupply(frm.getMpwsUnsafeSupply());

				rwsMaster.setHabType(frm.getHabType());
				rwsMaster.setHabSubType(frm.getHabSubType());
				rwsMaster.setHouseHold(frm.getHouseHold());
				rwsMaster.setHouseConn(frm.getHouseConn());

				if (frm.getIsMinorityHab() != null && frm.getIsMinorityHab().equals("on"))
					rwsMaster.setIsMinorityHab("Y");
				else
					rwsMaster.setIsMinorityHab("N");
				if (frm.getIsLwe() != null && frm.getIsLwe().equals("on"))
					rwsMaster.setIsLwe("Y");
				else
					rwsMaster.setIsLwe("N");
				if (frm.getIsItda() != null && frm.getIsItda().equals("on"))
					rwsMaster.setIsItda("Y");
				else
					rwsMaster.setIsItda("N");
				rwsMaster.setUnsafeLpcd(frm.getUnsafeLpcd());
				rwsMaster.setLevelOfWaterSupplySafeOnly(frm.getLevelOfWaterSupplySafeOnly());
				rwsMaster.setHabCat(frm.getHabCat());

				rwsMaster.setExistSource(frm.getExistSource());
				rwsMaster.setSafeSource(frm.getSafeSource());


				rwsMaster.setPublicTap(frm.getPublicTap());
				rwsMaster.setPublicStandpost(frm.getPublicStandpost());

				rwsMaster.setExistCheckDams(frm.getExistCheckDams());
				rwsMaster.setReqCheckDams(frm.getReqCheckDams());
				rwsMaster.setGlsrno(frm.getGlsrno());
				rwsMaster.setGlsrqty(frm.getGlsrqty());
				rwsMaster.setOhsrno(frm.getOhsrno());
				rwsMaster.setOhsrqty(frm.getOhsrqty());
				rwsMaster.setSchemesource(frm.getSchemesource());
				rwsMaster.setCattles(frm.getCattles());
				rwsMaster.setSlipReasonCode(frm.getSlipReasonCode());
				rwsMaster.setContTypes1(frm.getContTypes1());
				rwsMaster.setContTypes2(frm.getContTypes2());
				rwsMaster.setContTypes3(frm.getContTypes3());
				rwsMaster.setContTypes4(frm.getContTypes4());
				rwsMaster.setContTypes5(frm.getContTypes5());
				rwsMaster.setStatus(frm.getStatus());
				ArrayList insts = (ArrayList) frm.getHabInsts();
				ArrayList waterSupply = (ArrayList) frm.getHabWaterSupply();
				  String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {	
				rcount = rwsHabStatusData.insertHabStatus(rwsMaster, insts, waterSupply, getDataSource(request),
						request.getParameter("SlipDivStatus"));
				    }
				frm.reset(mapping, request);

			} catch (Exception e) {
				Debug.println("the error is" + e);
			}
			if (rwsHabStatusData.errorMessage != null)
				request.setAttribute("message", rwsHabStatusData.errorMessage);
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildHabStatusForm(request.getParameter("habCode"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				Debug.println("the error is" + e);
			}
		}

		if (mode.equalsIgnoreCase("Update")) {
			try {
				rwsMaster.setCoc(frm.getCircleOfficeCode());
				rwsMaster.setDoc(frm.getDivisionOfficeCode());
				rwsMaster.setSdoc(frm.getSubdivisionOfficeCode());
				rwsMaster.setHabCode(frm.getHabCode());
				rwsMaster.setCensusYear(frm.getCensusYear());
				rwsMaster.setHabYear(frm.getHabYear());
				rwsMaster.setCensusPop(frm.getCensusPop());
				rwsMaster.setCensusSc(frm.getCensusSc());
				rwsMaster.setCensusMinority(frm.getCensusMinority());
				rwsMaster.setCensusSt(frm.getCensusSt());
				rwsMaster.setFloatPop(frm.getFloatPop());
				rwsMaster.setFloatReason(frm.getFloatReason());
				rwsMaster.setPopCovered(frm.getPopCovered());
				rwsMaster.setScCovered(frm.getScCovered());
				rwsMaster.setStCovered(frm.getStCovered());
				rwsMaster.setMinorityCovered(frm.getMinorityCovered());
				rwsMaster.setPlainHCon(frm.getPlainHCon());
				rwsMaster.setPlainHHold(frm.getPlainHHold());
				rwsMaster.setScHCon(frm.getScHCon());
				rwsMaster.setScHHold(frm.getScHHold());
				rwsMaster.setStHCon(frm.getStHCon());
				rwsMaster.setStHHold(frm.getStHHold());
				rwsMaster.setMinorityHCon(frm.getMinorityHCon());
				rwsMaster.setMinorityHHold(frm.getMinorityHHold());
				rwsMaster.setLatitude(frm.getLatitude());
				rwsMaster.setLongitude(frm.getLongitude());
				rwsMaster.setElevation(frm.getElevation());
				rwsMaster.setWaypoint(frm.getWaypoint());
				rwsMaster.setLandmark(frm.getLandmark());
				rwsMaster.setCoveredStatus(frm.getCoveredStatus());
				rwsMaster.setTotalWaterSupply(frm.getTotalWaterSupply());
				rwsMaster.setExistWaterLevel(frm.getExistWaterLevel());
				rwsMaster.setNearWaterSource(frm.getNearWaterSource());
				rwsMaster.setNearWaterGroundSource(frm.getNearWaterGroundSource());
				rwsMaster.setNcSourceType(frm.getNcSourceType());
				rwsMaster.setSourceDistance(frm.getSourceDistance());
				rwsMaster.setRemarks(frm.getRemarks());
				rwsMaster.setQualityAffected(frm.getQualityAffected());
				rwsMaster.setProposedFcYr(frm.getProposedFcYr());
				rwsMaster.setProposedFCAmt(frm.getProposedFCAmt());

				rwsMaster.setSafeSHPNo(frm.getSafeSHPNo());
				rwsMaster.setSafeSHPSupply(frm.getSafeSHPSupply());
				rwsMaster.setHpSupply(frm.getHpSupply());
				rwsMaster.setHpNo(frm.getHpNo());
				rwsMaster.setPwsNo(frm.getPwsNo());
				rwsMaster.setPwsSupply(frm.getPwsSupply());
				rwsMaster.setCpwsNo(frm.getCpwsNo());
				rwsMaster.setCpwsSupply(frm.getCpwsSupply());
				rwsMaster.setMpwsNo(frm.getMpwsNo());
				rwsMaster.setMpwsSupply(frm.getMpwsSupply());
				rwsMaster.setDpNo(frm.getDpNo());
				rwsMaster.setDpSupply(frm.getDpSupply());
				rwsMaster.setCpwsNo(frm.getCpwsNo());
				rwsMaster.setCpwsSupply(frm.getCpwsSupply());
				rwsMaster.setOwsSupply(frm.getOwsSupply());
				rwsMaster.setOwsNo(frm.getOwsNo());
				rwsMaster.setPondsSupply(frm.getPondsSupply());
				rwsMaster.setPondsNo(frm.getPondsNo());
				rwsMaster.setDwNo(frm.getDwNo());
				rwsMaster.setDwSupply(frm.getDwSupply());
				rwsMaster.setShpSupply(frm.getShpSupply());
				rwsMaster.setShpNo(frm.getShpNo());
				rwsMaster.setPwsUnsafeNo(frm.getPwsUnsafeNo());
				rwsMaster.setPwsUnsafeSupply(frm.getPwsUnsafeSupply());
				rwsMaster.setMpwsUnsafeNo(frm.getMpwsUnsafeNo());
				rwsMaster.setMpwsUnsafeSupply(frm.getMpwsUnsafeSupply());
				rwsMaster.setPcpdDrink(frm.getPcpdDrink());
				rwsMaster.setPcpdOthers(frm.getPcpdOthers());
				rwsMaster.setStatus(frm.getStatus());

				rwsMaster.setPublicTap(frm.getPublicTap());
				rwsMaster.setPublicStandpost(frm.getPublicStandpost());

				rwsMaster.setExistCheckDams(frm.getExistCheckDams());
				rwsMaster.setReqCheckDams(frm.getReqCheckDams());
				rwsMaster.setFlouride(Double.parseDouble(frm.getFlouride()));
				rwsMaster.setBrakish(Double.parseDouble(frm.getBrakish()));
				rwsMaster.setIron(Double.parseDouble(frm.getIron()));

				ArrayList insts = (ArrayList) frm.getHabInsts();
				ArrayList waterSupply = (ArrayList) frm.getHabWaterSupply();

				rcount = rwsHabStatusData.updateHabStatus(rwsMaster, insts, waterSupply, getDataSource(request));

			} catch (Exception e) {
				Debug.println("The error in edit rws_habitation_entry=  " + e);
			}
			if (rcount.length < 1) {
				message = "The Record Cant be updated";
			} else {
				message = "Habitation Status updated successfully.";
			}
			request.setAttribute("message", message);
		}

	
	
		if (mode.equalsIgnoreCase("resetForm")) {
			try {
				frm.reset(mapping, request);
				habInsts.clear();
				habWaterSupply.clear();
				contaminations.clear();
			} catch (Exception e) {
				Debug.println("the error in reset delete is " + e);
			}
		}
		System.gc();
		return (mapping.findForward(mode));
	}
}