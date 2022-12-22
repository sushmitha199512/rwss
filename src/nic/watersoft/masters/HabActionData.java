package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.Debug;
//import nic.watersoft.wquality.WaterSampleTestResBean;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import java.text.DecimalFormat;

public class HabActionData extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null || session == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
						|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		System.gc();
		//System.out.println("Hab action data   ");
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivisions = null;

		String habstatus = "";
		String target = new String("success");

		ArrayList dists = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchyats = new ArrayList();
		ArrayList villages = new ArrayList();
		ArrayList habs = new ArrayList();
		ArrayList divcodes = new ArrayList();
		ArrayList institutes = new ArrayList();
		Collection habInsts = new ArrayList();
		Collection habWaterSupply = new ArrayList();
		Collection contaminations = new ArrayList();

		RwsHabStatusData rwsHabStatusData = new RwsHabStatusData();

		HabStatusForm habForm = (HabStatusForm) form;
		DataSource dataSource = getDataSource(request);

		String mode = habForm.getMode();
		boolean init = habForm.getInit();

		RwsMaster rwsMaster = new RwsMaster();
		String headOfficeCode = habForm.getHeadOfficeCode();
		String circleOfficeCode = habForm.getCircleOfficeCode();
		String divisionOfficeCode = habForm.getDivisionOfficeCode();
		String subdivisionOfficeCode = habForm.getSubdivisionOfficeCode();
// System.out.println("form circle   "+habForm.getCircleOfficeCode());
		if (headOfficeCode == null) {
			headOfficeCode = user.getHeadOfficeCode();
		}
		if (circleOfficeCode == null) {
			circleOfficeCode = user.getCircleOfficeCode();
		}
		if (divisionOfficeCode == null) {
			divisionOfficeCode = user.getDivisionOfficeCode();
		}
		if (subdivisionOfficeCode == null || subdivisionOfficeCode.equals("")) {
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();
		}
	//	System.out.println(" circle office codeeeeeee  "+circleOfficeCode);
		CommonLists commonLists = new CommonLists(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		RwsLocations rwsLocations = new RwsLocations(dataSource);
		Rws_Habitation_Dyna_DAO dynaDao = new Rws_Habitation_Dyna_DAO();

		try {
			if (init) {
				habstatus = dynaDao.getHabStatusDate();
				session.setAttribute("habstatus", habstatus);
				if (circleOfficeCode.equals("00"))
					circles = rwsOffices.getCircles(headOfficeCode);
				if (circles != null)
					session.setAttribute("circles", circles);
				if (divisions != null)
					session.setAttribute("divisions", divisions);
				if (subdivisions != null)
					session.setAttribute("subdivisions", subdivisions);
				if (circleOfficeCode != null) {
					mandals = rwsLocations.getMandals(circleOfficeCode);
					session.setAttribute("mandals", mandals);
				} else {
					session.setAttribute("mandals", new ArrayList());
				}
				habForm.setInit(false);
			}
			if (mode != null && mode.equals("circles")) {
				headOfficeCode = habForm.getHeadOfficeCode();
				circles = rwsOffices.getCircles(headOfficeCode);
				habForm.setCircleOfficeCode("00");
				habForm.setDivisionOfficeCode("0");
				habForm.setSubdivisionOfficeCode("00");
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
				session.setAttribute("circles", circles);
			}
			//if (mode != null && mode.equals("mandals")) {
			/*headOfficeCode = habForm.getHeadOfficeCode();
			circleOfficeCode = habForm.getCircleOfficeCode();
			divisionOfficeCode = habForm.getDivisionOfficeCode();
			subdivisionOfficeCode = habForm.getSubdivisionOfficeCode();
			mandals = rwsLocations.getMandals(circleOfficeCode);
			session.setAttribute("mandals", mandals);
		}*/
	//	System.out.println("  circleOfficeCode   "+circleOfficeCode  );
		if (circleOfficeCode != null && !circleOfficeCode.equals("00") && !circleOfficeCode.equals("")) {
			//divcodes = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			request.setAttribute("distName",rwsHabStatusData.getDistName(getDataSource(request), circleOfficeCode));
			habForm.setDcode(circleOfficeCode);
		//	System.out.println(" form  dcode    "+habForm.getDcode());
			mandals = rwsLocations.getMandals(circleOfficeCode);
			session.setAttribute("mandals", mandals);
		}
			try {
				if (habForm.getMandal() != null) {
					if ((habForm.getMandal()).length() != 0) {
						panchyats = rwsLocations.getPanchayats(circleOfficeCode, habForm.getMandal());
					}
				}

				if (habForm.getPcode() != null) {
					if ((habForm.getPcode()).length() != 0) {
						habs = dynaDao.getPanchayatHabitations1(
								user.getHeadOfficeCode() + user.getCircleOfficeCode() + user.getDivisionOfficeCode()
										+ user.getSubdivisionOfficeCode(),
								circleOfficeCode, habForm.getMandal(), habForm.getPcode());

					}
				}
			} catch (Exception e) {
				Debug.println("Error is " + e);
			}
			session.setAttribute("dists", dists);
			session.setAttribute("panchyats", panchyats);
			session.setAttribute("villages", villages);
			session.setAttribute("habs", habs);
		} catch (Exception e) {
			Debug.println("The habs in hab action data" + e);
		}

		try {
			if (request.getParameter("habCode") != null) {
				String habCode = request.getParameter("habCode");
				ArrayList coverageStatuses = new ArrayList();
				if (habCode.length() != 0) {
					ArrayList slippageReasons = rwsOffices.getSlippageReasons();
					session.setAttribute("slipReasons", slippageReasons);
					String userId = (String) session.getAttribute("userId");
					coverageStatuses = dynaDao.getCoverageStatuses(habCode, userId);
					session.setAttribute("coverageStatuses", coverageStatuses);

					RwsMaster rwsMaster1 = rwsHabStatusData.getHabSupplyStatus(habCode, getDataSource(request));

					if (rwsMaster1 != null) {
						habForm.setActHouseHold(rwsMaster1.getActHouseHold());
						habForm.setActHouseConn(rwsMaster1.getActHouseConn());
						habForm.setActPlainPop(rwsMaster1.getActPlainPop());
						habForm.setActScPop(rwsMaster1.getActScPop());
						habForm.setActStPop(rwsMaster1.getActStPop());
						habForm.setActTotPop(rwsMaster1.getActTotPop());
						
						habForm.setIron("" + rwsMaster1.getIron());
						habForm.setContTypes1(rwsMaster1.getContTypes1());
						habForm.setContTypes2(rwsMaster1.getContTypes2());
						habForm.setContTypes3(rwsMaster1.getContTypes3());
						habForm.setContTypes4(rwsMaster1.getContTypes4());
						habForm.setContTypes5(rwsMaster1.getContTypes5());
						habForm.setFlouride("" + rwsMaster1.getFlouride());
						habForm.setBrakish("" + rwsMaster1.getBrakish());
						habForm.setAresenic("" + rwsMaster1.getAresenic());
						habForm.setNitrate("" + rwsMaster1.getNitrate());
						habForm.setCensusPop(rwsMaster1.getCensusPop());
						habForm.setCensusYear(RwsHabStatusData.format(rwsMaster1.getCensusYear()));
						habForm.setCensusSc(rwsMaster1.getCensusSc());
						habForm.setFloatPop(rwsMaster1.getFloatPop());
						habForm.setCensusSt(rwsMaster1.getCensusSt());
						habForm.setFloatReason(RwsHabStatusData.format(rwsMaster1.getFloatReason()));
						habForm.setSlipReasonCode(rwsMaster1.getSlipReasonCode());
						habForm.setTotPop(rwsMaster1.getTotalPop());
						habForm.setNetPop(rwsMaster1.getNetPop());
						habForm.setHabYear(RwsHabStatusData.format(rwsMaster1.getHabYear()));
						habForm.setPopCovered(rwsMaster1.getPopCovered());
						habForm.setScCovered(rwsMaster1.getScCovered());
						habForm.setStCovered(rwsMaster1.getStCovered());
						habForm.setTotPopCvrd(rwsMaster1.getTotalCovered());
						habForm.setTotalWaterSupply(rwsMaster1.getTotalWaterSupply());
						habForm.setTotalWaterSupplySafe(rwsMaster1.getTotalWaterSupplySafe());
						habForm.setTotalWaterSupplyUnsafe(rwsMaster1.getTotalWaterSupplyUnsafe());
						habForm.setExistWaterLevel(rwsMaster1.getExistWaterLevel());
						habForm.setNearWaterSource(rwsMaster1.getNearWaterSource());
						habForm.setNearWaterGroundSource(rwsMaster1.getNearWaterGroundSource());
						habForm.setNcSourceType(RwsHabStatusData.format(rwsMaster1.getNcSourceType()));
						habForm.setSourceDistance(RwsHabStatusData.format(rwsMaster1.getSourceDistance()));
						habForm.setCoveredStatus(RwsHabStatusData.format(rwsMaster1.getCoveredStatus()));
						habForm.setStatusAsOn1405(RwsHabStatusData.format(rwsMaster1.getStatusAsOn1405()));

						habForm.setUpdateDate(RwsHabStatusData.format(rwsMaster1.getUpdateDate()));
						habForm.setProposedFcYr(RwsHabStatusData.format(rwsMaster1.getProposedFcYr()));
						habForm.setProposedFCAmt(rwsMaster1.getProposedFCAmt());

						habForm.setShpSupply(RwsHabStatusData.format(rwsMaster1.getShpSupply()));
						habForm.setShpNo(RwsHabStatusData.format(rwsMaster1.getShpNo()));
						habForm.setCisternsSupply(RwsHabStatusData.format(rwsMaster1.getCisternsSupply()));
						habForm.setCisternsNo(RwsHabStatusData.format(rwsMaster1.getCisternsNo()));
						habForm.setGlsrSupply(RwsHabStatusData.format(rwsMaster1.getGlsrSupply()));
						habForm.setGlsrNo(RwsHabStatusData.format(rwsMaster1.getGlsrNo()));
						habForm.setOhsrSupply(RwsHabStatusData.format(rwsMaster1.getOhsrSupply()));
						habForm.setOhsrNo(RwsHabStatusData.format(rwsMaster1.getOhsrNo()));

						habForm.setDrinkTotalSupply(RwsHabStatusData.format(rwsMaster1.getDrinkTotalSupply()));
						habForm.setDrinkTotalNo(RwsHabStatusData.format(rwsMaster1.getDrinkTotalNo()));

						habForm.setHpSupply(RwsHabStatusData.format(rwsMaster1.getHpSupply()));
						habForm.setHpNo(RwsHabStatusData.format(rwsMaster1.getHpNo()));
						habForm.setOwsSupply(RwsHabStatusData.format(rwsMaster1.getOwsSupply()));
						habForm.setOwsNo(RwsHabStatusData.format(rwsMaster1.getOwsNo()));
						habForm.setPondsSupply(RwsHabStatusData.format(rwsMaster1.getPondsSupply()));
						habForm.setPondsNo(RwsHabStatusData.format(rwsMaster1.getPondsNo()));
						habForm.setOthersSafeeNo(RwsHabStatusData.format(rwsMaster1.getOthersSafeeNo()));
						habForm.setOthersSafeSupply(RwsHabStatusData.format(rwsMaster1.getOthersSafeSupply()));
						habForm.setShwSupply(RwsHabStatusData.format(rwsMaster1.getShwSupply()));
						habForm.setShwNo(RwsHabStatusData.format(rwsMaster1.getShwNo()));
						habForm.setPwsNo(RwsHabStatusData.format(rwsMaster1.getPwsNo()));
						habForm.setPwsSupply(RwsHabStatusData.format(rwsMaster1.getPwsSupply()));
						habForm.setCpwsNo(RwsHabStatusData.format(rwsMaster1.getCpwsNo()));
						habForm.setCpwsSupply(RwsHabStatusData.format(rwsMaster1.getCpwsSupply()));
						habForm.setMpwsNo(RwsHabStatusData.format(rwsMaster1.getMpwsNo()));
						habForm.setMpwsSupply(RwsHabStatusData.format(rwsMaster1.getMpwsSupply()));
						habForm.setDpNo(RwsHabStatusData.format(rwsMaster1.getDpNo()));
						habForm.setDpSupply(RwsHabStatusData.format(rwsMaster1.getDpSupply()));
						habForm.setDwNo(RwsHabStatusData.format(rwsMaster1.getDwNo()));
						habForm.setMpwsUnsafeSupply(RwsHabStatusData.format(rwsMaster1.getMpwsUnsafeSupply()));
						habForm.setMpwsUnsafeNo(RwsHabStatusData.format(rwsMaster1.getMpwsUnsafeNo()));
						habForm.setPwsUnsafeSupply(RwsHabStatusData.format(rwsMaster1.getPwsUnsafeSupply()));
						habForm.setPwsUnsafeNo(RwsHabStatusData.format(rwsMaster1.getPwsUnsafeNo()));
						habForm.setSafeSHPNo(RwsHabStatusData.format(rwsMaster1.getSafeSHPNo()));
						habForm.setSafeSHPSupply(RwsHabStatusData.format(rwsMaster1.getSafeSHPSupply()));
						habForm.setLinkageHabSupply(RwsHabStatusData.format(rwsMaster1.getLinkageHabSupply()));
						habForm.setDwSupply(RwsHabStatusData.format(rwsMaster1.getDwSupply()));
						habForm.setCattleNo(RwsHabStatusData.format(rwsMaster1.getCattleNo()));
						habForm.setCattleSupply(RwsHabStatusData.format(rwsMaster1.getCattleSupply()));
						habForm.setOtherTotalSupply(RwsHabStatusData.format(rwsMaster1.getOtherTotalSupply()));
						habForm.setOtherTotalNo(RwsHabStatusData.format(rwsMaster1.getOtherTotalNo()));
						habForm.setPcpdDrink(RwsHabStatusData.format(rwsMaster1.getPcpdDrink()));
						habForm.setPcpdOthers(RwsHabStatusData.format(rwsMaster1.getPcpdOthers()));
						habForm.setPcpdTotal(RwsHabStatusData.format(rwsMaster1.getPcpdTotal()));
						habForm.setTotalWaterSupply(rwsMaster1.getTotalWaterSupply());
						habForm.setOthersSupply(rwsMaster1.getOthersSupply());
						habForm.setOthersNo(rwsMaster1.getOthersNo());
						habForm.setHabType(RwsHabStatusData.format(rwsMaster1.getHabType()));
						habForm.setHabSubType(RwsHabStatusData.format(rwsMaster1.getHabSubType()));
						habForm.setHouseHold(rwsMaster1.getHouseHold());
						habForm.setHouseConn(rwsMaster1.getHouseConn());
						habForm.setPlainHCon(rwsMaster1.getPlainHCon());
						habForm.setPlainHHold(rwsMaster1.getPlainHHold());
						habForm.setScHCon(rwsMaster1.getScHCon());
						habForm.setScHHold(rwsMaster1.getScHHold());
						habForm.setStHCon(rwsMaster1.getStHCon());
						habForm.setStHHold(rwsMaster1.getStHHold());

						habForm.setGlsrno(rwsMaster1.getGlsrno());
						habForm.setGlsrqty(rwsMaster1.getGlsrqty());
						habForm.setOhsrno(rwsMaster1.getOhsrno());
						habForm.setOhsrqty(rwsMaster1.getOhsrqty());
						habForm.setSchemesource(rwsMaster1.getSchemesource());

						habForm.setLatitude(rwsMaster1.getLatitude());
						habForm.setLongitude(rwsMaster1.getLongitude());
						habForm.setElevation(rwsMaster1.getElevation());
						habForm.setWaypoint(rwsMaster1.getWaypoint());
						habForm.setLandmark(rwsMaster1.getLandmark());
						habForm.setMinorityHCon(rwsMaster1.getMinorityHCon());
						habForm.setMinorityHHold(rwsMaster1.getMinorityHHold());
						habForm.setMinorityCovered(rwsMaster1.getMinorityCovered());
						habForm.setCensusMinority(rwsMaster1.getCensusMinority());
						habForm.setHabCat(rwsMaster1.getHabCat());

						habForm.setExistSource(rwsMaster1.getExistSource());
						habForm.setSafeSource(rwsMaster1.getSafeSource());

						habForm.setPublicTap(rwsMaster1.getPublicTap());
						habForm.setPublicStandpost(rwsMaster1.getPublicStandpost());
						habForm.setCattles(rwsMaster1.getCattles());
						habForm.setIsMinorityHab(rwsMaster1.getIsMinorityHab());
						habForm.setIsItda(rwsMaster1.getIsItda());
						habForm.setIsLwe(rwsMaster1.getIsLwe());
						habForm.setUnsafeLpcd(rwsMaster1.getUnsafeLpcd());

						DecimalFormat ndf = new DecimalFormat("####.00");
						if (!rwsMaster1.getLevelOfWaterSupply().equals(""))
							habForm.setLevelOfWaterSupply(RwsHabStatusData
									.format(ndf.format(Double.parseDouble(rwsMaster1.getLevelOfWaterSupply()))));
						habForm.setLpcdCooking(rwsMaster1.getLpcdCooking());
						request.setAttribute("status", RwsHabStatusData.format(rwsMaster1.getCoveredStatus()));
						habForm.setStatus(RwsHabStatusData.format(rwsMaster1.getCoveredStatus()));
						habForm.setRemarks(RwsHabStatusData.format(rwsMaster1.getRemarks()));
						habForm.setPrevYrStatus(RwsHabStatusData.format(rwsMaster1.getPrevYrStatus()));

						if (rwsMaster1.getHabInsts() != null && rwsMaster1.getHabInsts().size() > 0) {

							institutes = (ArrayList) rwsMaster1.getHabInsts();
							habForm.setHabInsts(institutes);

						} else {
							institutes = rwsHabStatusData.getInstitutes(getDataSource(request));
							if (institutes.size() != 0) {
								for (int i = 0; i < institutes.size(); i++) {
									rwsMaster = (RwsMaster) institutes.get(i);
									habInsts.add(new HabInstitute(rwsMaster.getInstituteCode(),
											rwsMaster.getInstituteName()));
								}
								habForm.setHabInsts(habInsts);
							}
						}
						Collection contaminations1 = (ArrayList) rwsHabStatusData
								.getContamNames(getDataSource(request));

						for (int i = 0; i < contaminations1.size(); i++) {
							rwsMaster = (RwsMaster) ((ArrayList) contaminations1).get(i);
							contaminations.add(new ContaminationTypes(rwsMaster.getContamName()));
						}
						habForm.setContaminations(contaminations);
						habForm.setContName(rwsMaster1.getContamName());
						session.setAttribute("contaminations", contaminations);
					} else {
						habForm.setActPlainPop(0);
						habForm.setActScPop(0);
						habForm.setActStPop(0);
						habForm.setActHouseHold(0);
						habForm.setActHouseConn(0);
						habForm.setActTotPop(0);
						habForm.setHabCat("");
						habForm.setExistSource(0);
						habForm.setSafeSource(0);
						habForm.setHabType("");
						habForm.setHouseHold(0);
						habForm.setHouseConn(0);
						habForm.setPlainHCon(0);
						habForm.setScHCon(0);
						habForm.setStHCon(0);
						habForm.setPlainHHold(0);
						habForm.setScHHold(0);
						habForm.setStHHold(0);
						habForm.setLatitude("");
						habForm.setLongitude("");
						habForm.setElevation("");
						habForm.setWaypoint("");
						habForm.setLandmark("");
						habForm.setMinorityHHold(0);
						habForm.setMinorityHCon(0);
						habForm.setCensusMinority(0);
						habForm.setMinorityCovered(0);
						habForm.setIron("");
						habForm.setFlouride("");
						habForm.setBrakish("");
						habForm.setCensusPop(0);
						habForm.setCensusYear("");
						habForm.setCensusSc(0);
						habForm.setFloatPop(0);
						habForm.setCensusSt(0);
						habForm.setFloatReason("");
						habForm.setTotPop(0);
						habForm.setNetPop(0);
						habForm.setHabYear("");
						habForm.setPopCovered(0);
						habForm.setScCovered(0);
						habForm.setStCovered(0);
						habForm.setTotPopCvrd(0);
						habForm.setTotalWaterSupply(0);
						habForm.setExistWaterLevel(0);
						habForm.setNearWaterSource(0);
						habForm.setNearWaterGroundSource(0);
						habForm.setNcSourceType("");
						habForm.setSourceDistance("");

						habForm.setCoveredStatus("");
						habForm.setRemarks("");
						habForm.setQualityAffected("");
						habForm.setButtonName("Save");
						habForm.setGlsrno(0);
						habForm.setGlsrqty(0);
						habForm.setOhsrno(0);
						habForm.setOhsrqty(0);
						habForm.setSchemesource("");

						habForm.setHabWaterSupply(habWaterSupply);

						institutes = rwsHabStatusData.getInstitutes(getDataSource(request));
						if (institutes.size() != 0) {
							for (int i = 0; i < institutes.size(); i++) {
								rwsMaster = (RwsMaster) institutes.get(i);
								habInsts.add(
										new HabInstitute(rwsMaster.getInstituteCode(), rwsMaster.getInstituteName()));
							}
							habForm.setHabInsts(habInsts);
						}

						contaminations.add(new ContaminationTypes("FLOURIDE"));
						contaminations.add(new ContaminationTypes("BRAKISH"));
						contaminations.add(new ContaminationTypes("IRON"));
						contaminations.add(new ContaminationTypes("ARESENIC"));
						contaminations.add(new ContaminationTypes("NITRATE"));
						habForm.setContaminations(contaminations);

					}

				} else {
					habForm.setActPlainPop(0);
					habForm.setActScPop(0);
					habForm.setActStPop(0);
					habForm.setActHouseHold(0);
					habForm.setActHouseConn(0);
					habForm.setActTotPop(0);
					habForm.setHabCat("");
					habForm.setExistSource(0);
					habForm.setSafeSource(0);
					habForm.setHabType("");
					habForm.setHouseHold(0);
					habForm.setHouseConn(0);
					habForm.setPlainHCon(0);
					habForm.setScHCon(0);
					habForm.setStHCon(0);
					habForm.setPlainHHold(0);
					habForm.setScHHold(0);
					habForm.setStHHold(0);

					habForm.setMinorityHHold(0);
					habForm.setMinorityHCon(0);
					habForm.setCensusMinority(0);
					habForm.setMinorityCovered(0);
					habForm.setIron("");
					habForm.setFlouride("");
					habForm.setBrakish("");
					habForm.setCensusPop(0);
					habForm.setCensusYear("");
					habForm.setCensusSc(0);
					habForm.setFloatPop(0);
					habForm.setCensusSt(0);
					habForm.setFloatReason("");
					habForm.setTotPop(0);
					habForm.setNetPop(0);
					habForm.setHabYear("");
					habForm.setPopCovered(0);
					habForm.setScCovered(0);
					habForm.setStCovered(0);
					habForm.setTotPopCvrd(0);
					habForm.setTotalWaterSupply(0);
					habForm.setExistWaterLevel(0);
					habForm.setNearWaterSource(0);
					habForm.setNearWaterGroundSource(0);
					habForm.setNcSourceType("");
					habForm.setSourceDistance("");

					habForm.setCoveredStatus("");
					habForm.setRemarks("");
					habForm.setQualityAffected("");
					habForm.setButtonName("Save");

					habForm.setShpSupply("");
					habForm.setShpNo("");
					habForm.setCisternsSupply("");
					habForm.setCisternsNo("");
					habForm.setGlsrSupply("");
					habForm.setGlsrNo("");
					habForm.setOhsrSupply("");
					habForm.setOhsrNo("");
					habForm.setDrinkTotalSupply("");
					habForm.setDrinkTotalNo("");
					habForm.setHpSupply("");
					habForm.setHpNo("");
					habForm.setOwsSupply("");
					habForm.setOwsNo("");
					habForm.setPondsSupply("");
					habForm.setPondsNo("");
					habForm.setOthersSafeeNo("");
					habForm.setOthersSafeSupply("");
					habForm.setShwSupply("");
					habForm.setShwNo("");
					habForm.setPwsNo("");
					habForm.setPwsSupply("");
					habForm.setCpwsNo("");
					habForm.setCpwsSupply("");
					habForm.setMpwsNo("");
					habForm.setMpwsSupply("");
					habForm.setDpNo("");
					habForm.setDpSupply("");
					habForm.setDwNo("");
					habForm.setMpwsUnsafeSupply("");
					habForm.setMpwsUnsafeNo("");
					habForm.setPwsUnsafeSupply("");
					habForm.setPwsUnsafeNo("");
					habForm.setDwSupply("");
					habForm.setCattleNo("");
					habForm.setCattleSupply("");
					habForm.setOtherTotalSupply("");
					habForm.setOtherTotalNo("");
					habForm.setPcpdDrink("");
					habForm.setPcpdOthers("");
					habForm.setPcpdTotal("");
					habForm.setTotalWaterSupply(0);
					habForm.setOthersSupply("");
					habForm.setOthersNo("");
					habForm.setTotalWaterSupplySafe(0);
					habForm.setTotalWaterSupplyUnsafe(0);
					habForm.setLpcdCooking("");
					habForm.setStatus("");
					habForm.setPrevYrStatus("");
					habForm.setHabWaterSupply(habWaterSupply);

					habForm.setHabInsts(new ArrayList());
					contaminations.add(new ContaminationTypes("FLOURIDE"));
					contaminations.add(new ContaminationTypes("BRAKISH"));
					contaminations.add(new ContaminationTypes("IRON"));
					contaminations.add(new ContaminationTypes("ARESENIC"));
					contaminations.add(new ContaminationTypes("NITRATE"));
					habForm.setContaminations(contaminations);

				}
			}
		} catch (Exception e) {
			Debug.println("Exception in getting hab status in HabActionData is " + e);
		}

		System.gc();
		return (mapping.findForward(target));
	}
}
