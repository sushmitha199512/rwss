package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.Debug;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_SourceEntryAct_frm extends Action {
	int rcount[];

	protected ActionForm getSourceDetails(HttpServletRequest request, SourceForm sourceForm, String sourceCode)
			throws Exception {
		ArrayList sourceTypeCodes = new ArrayList();
		ArrayList subSourceTypeCodes = new ArrayList();
		CommonLists commonLists = new CommonLists(getDataSource(request));
		RwsMaster rwsMaster = new RwsMaster();
		HttpSession session = request.getSession();
		rwsMaster = RwsMasterData.getSource(sourceCode, "viewSources", getDataSource(request));
		sourceForm.setFlouride(rwsMaster.getFlouride() + "");
		sourceForm.setBrakish(rwsMaster.getBrakish() + "");
		sourceForm.setIron(rwsMaster.getIron() + "");
		sourceForm.setOthersType(rwsMaster.getOthersType() + "");
		sourceForm.setOthers(rwsMaster.getOthers() + "");
		LabelValueBean labelValueBean = null;
		labelValueBean = new LabelValueBean();
		labelValueBean.setValue("1");
		labelValueBean.setLabel("SUBSURFACE SOURCE");
		sourceTypeCodes.add(labelValueBean);
		labelValueBean = new LabelValueBean();
		labelValueBean.setValue("2");
		labelValueBean.setLabel("SURFACE SOURCE");
		sourceTypeCodes.add(labelValueBean);
		session.setAttribute("sourceTypeCodes", sourceTypeCodes);
		{
			{
				subSourceTypeCodes = commonLists.getSubsourceTypes(rwsMaster.getSourceTypeCode());
				session.setAttribute("subSourceTypeCodes", subSourceTypeCodes);
			}
		}
		sourceForm.setSourceTypeCode(rwsMaster.getSourceTypeCode());
		sourceForm.setSubSourceTypeCode(rwsMaster.getSubSourceTypeCode());
		sourceForm.setSourceCode(sourceCode);
		sourceForm.setSourceName(rwsMaster.getSourceName());
		sourceForm.setLocation(rwsMaster.getLocation());
		sourceForm.setTappingPoint(rwsMaster.getLocation()); 
		sourceForm.setNoOfHab(rwsMaster.getNoOfHab());
		sourceForm.setPopbenefited(rwsMaster.getPopbenefited());
		sourceForm.setSeasonal(rwsMaster.getSeasonal());
		sourceForm.setPresentCondition(rwsMaster.getPresentCondition());
		sourceForm.setWaterQuality(rwsMaster.getWaterQuality());
		sourceForm.setStaticWaterLevel(rwsMaster.getStaticWaterLevel());
		sourceForm.setSummerWaterLevel(rwsMaster.getSummerWaterLevel());
		sourceForm.setYield(rwsMaster.getYield());
		sourceForm.setDistFromSource(rwsMaster.getDistFromSource());
		sourceForm.setType(rwsMaster.getType());
		sourceForm.setSourceDiameter(rwsMaster.getSourceDiameter());
		sourceForm.setSourceDepth(rwsMaster.getSourceDepth() + "");
		sourceForm.setLatitude(rwsMaster.getLatitude());
		sourceForm.setLongitude(rwsMaster.getLongitude());
		sourceForm.setElevation(rwsMaster.getElevation());
		sourceForm.setWaypoint(rwsMaster.getWaypoint());
		sourceForm.setTypeofTreatment(rwsMaster.getTypeofTreatment());
		sourceForm.setPlantCapacity(rwsMaster.getPlantCapacity());
		return sourceForm;
	}

	protected ActionForm buildSourceForm(String sourceCode, String mode, HttpServletRequest request) throws Exception {
		SourceForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getSource(sourceCode, mode, getDataSource(request));
		if (rwsMaster != null) {
			form = new SourceForm();
			form.setSourceCode(rwsMaster.getSourceCode());
			form.setSourceName(rwsMaster.getSourceName());
			form.setSourceTypeCode(rwsMaster.getSourceTypeCode());
			form.setSubSourceTypeCode(rwsMaster.getSubSourceTypeCode());
			form.setHabCode(rwsMaster.getHabCode());
			form.setNoOfHab(rwsMaster.getNoOfHab());
			form.setPopbenefited(rwsMaster.getPopbenefited());
			form.setSeasonal(rwsMaster.getSeasonal());
			form.setPresentCondition(rwsMaster.getPresentCondition());
			form.setWaterQuality(rwsMaster.getWaterQuality());
			form.setStaticWaterLevel(rwsMaster.getStaticWaterLevel());
			form.setSummerWaterLevel(rwsMaster.getSummerWaterLevel());
			form.setYield(rwsMaster.getYield());
			form.setDistFromSource(rwsMaster.getDistFromSource());
			form.setLocation(rwsMaster.getLocation());
			form.setLatitude(rwsMaster.getLatitude());
			form.setLongitude(rwsMaster.getLongitude());
			form.setElevation(rwsMaster.getElevation());
			form.setWaypoint(rwsMaster.getWaypoint());
			form.setSourceHabs(RwsMasterData.getHabsOnSource(sourceCode, getDataSource(request)));
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		int ans = 0;
		String message = null;
		ArrayList sources = null;
		ArrayList dists = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchyats = new ArrayList();
		ArrayList villages = new ArrayList();
		ArrayList prhabs = new ArrayList();
		ArrayList assetSources = new ArrayList();
		ArrayList assetHabs = new ArrayList();
		ArrayList sourceTypeCodes = new ArrayList();
		ArrayList subSourceTypeCodes = new ArrayList();
		RwsMaster rwsMaster = new RwsMaster();
		HttpSession session = request.getSession();
		ArrayList checkAssets = new ArrayList();
		ArrayList checkHabs = new ArrayList();
		ArrayList emptyList = new ArrayList();
		String sourceCode = null;
		String circleOfficeCode = null;
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		session = request.getSession();
		if (user == null || session == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
						|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (circleOfficeCode == null) {
			circleOfficeCode = user.getCircleOfficeCode();
		}
		try {
			if (circleOfficeCode.equals("00")) {
				dists = rwsLocations.getDistricts();
				session.setAttribute("dists", dists);
			} else {
				String districtOfficeName = rwsLocations.getDname(user.getCircleOfficeCode());
				request.setAttribute("districtOfficeName", districtOfficeName);
			}
		} catch (Exception e) {
			Debug.println("Exception is " + e);
		}
		SourceForm sourceForm = (SourceForm) form;
		if (sourceForm.getSourceCode() == null || ((String) sourceForm.getSourceCode()).equals(""))
			session.removeAttribute("tempSelectedSourceHabs");
		CommonLists commonLists = new CommonLists(getDataSource(request));
		String mode = sourceForm.getMode();
		request.removeAttribute("scode");
		if (mode.equalsIgnoreCase("setSourceCode")) {
			String habCode = sourceForm.getHabCode();
			String shortSchemeCode = (String) session.getAttribute("shortSchemeCode");
			SubCompMetaData subCompMetaData = new SubCompMetaData();
			String nextSchemeCode = subCompMetaData.getNextSchemeCode(getDataSource(request), "01", "01", "001",
					shortSchemeCode, habCode, (String) session.getAttribute("assetCode"));
			sourceForm.setSourceCode(nextSchemeCode);
			return mapping.findForward("sourceForm");
		}
		if (request.getParameter("pcode") != null)
			session.setAttribute("pcode", request.getParameter("pcode"));
		if (mode.equalsIgnoreCase("getsource")) {
			try {
				LabelValueBean labelValueBean;
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue("1");
				labelValueBean.setLabel("SUBSURFACE SOURCE");
				labelValueBean.setValue("2");
				labelValueBean.setLabel("SURFACE SOURCE");
				sourceTypeCodes.add(labelValueBean);
				session.setAttribute("sourceTypeCodes", sourceTypeCodes);
				if (request.getParameter("sourceTypeCode") != null) {
					if (!request.getParameter("sourceTypeCode").equalsIgnoreCase("")) {
						subSourceTypeCodes = commonLists.getSubsourceTypes(request.getParameter("sourceTypeCode"));
					}
				}
				session.setAttribute("subSourceTypeCodes", subSourceTypeCodes);
			} catch (Exception e) {
				Debug.println("The error in getsource is " + e);
			}
		}
		if (mode.equalsIgnoreCase("contidata")) {
			try {
				String contiType = request.getParameter("opType");
				if (contiType != null)
					session.setAttribute("contiType", contiType);
				ArrayList contaminations = new ArrayList();
				ArrayList contaminations1 = (ArrayList) RwsMasterData.getContamNames(getDataSource(request), contiType);
				for (int i = 0; i < contaminations1.size(); i++) {
					rwsMaster = (RwsMaster) ((ArrayList) contaminations1).get(i);
					ContaminationTypes contaminationTypes = new ContaminationTypes(rwsMaster.getContamName(), 0.0);
					contaminations.add(contaminationTypes);
				}
				sourceForm.setContaminations(contaminations);
				session.setAttribute("contaminations", contaminations);
			} catch (Exception e) {
				Debug.println("The error in rws_SourceAct_frm vcode is " + e);
			}
		}

		if (mode.equalsIgnoreCase("panchayats")) {
			try {
				panchyats = rwsLocations.getPanchayats(sourceForm.getDistrict(), sourceForm.getMandal());
				session.setAttribute("panchyats", panchyats);
				session.setAttribute("villages", emptyList);
				session.setAttribute("prhabs", emptyList);
			} catch (Exception e) {
				Debug.println("Exception in habitations mode is " + e);
			}
		}
		if (mode.equalsIgnoreCase("villages")) {
			try {
				villages = rwsLocations.getVillages(sourceForm.getDistrict(), sourceForm.getMandal(),
						sourceForm.getPcode());
				session.setAttribute("villages", villages);
				session.setAttribute("prhabs", emptyList);
			} catch (Exception e) {
				Debug.println("Exception in habitations mode is " + e);
			}
		}
		if (mode.equalsIgnoreCase("habitations")) {
			try {
				prhabs = rwsLocations.getHabitations(sourceForm.getDistrict(), sourceForm.getMandal(),
						sourceForm.getPcode(), sourceForm.getVcode());
				session.setAttribute("prhabs", prhabs);
			} catch (Exception e) {
				Debug.println("Exception in habitations mode is " + e);
			}
		}

		if (mode.equalsIgnoreCase("data")) {
			try {
				if (sourceForm.getHabCode() != null && !sourceForm.getHabCode().equals("")) {
					String habCode = sourceForm.getHabCode();
					String shortSchemeCode = (String) session.getAttribute("shortSchemeCode");
					SubCompMetaData subCompMetaData = new SubCompMetaData();
					String nextSchemeCode = subCompMetaData.getNextSchemeCode(getDataSource(request), "01", "01", "001",
							shortSchemeCode, habCode, (String) session.getAttribute("assetCode"));
					sourceForm.setSourceCode(nextSchemeCode);
				}
				String tempPCode = "", PCode = null, phCode = null;
				int tslno = 0, slno = 0;
				ArrayList sourCode = new ArrayList();
				ArrayList contaminations = new ArrayList();
				RwsMasterData rwsMasterData = new RwsMasterData();
				ArrayList contaminations1 = (ArrayList) rwsMasterData.getContamNames(getDataSource(request));
				for (int i = 0; i < contaminations1.size(); i++) {
					rwsMaster = (RwsMaster) ((ArrayList) contaminations1).get(i);
					ContaminationTypes contaminationTypes = new ContaminationTypes(rwsMaster.getContamName(), 0.0);
					contaminations.add(contaminationTypes);
				}
				sourceForm.setContaminations(contaminations);
				session.setAttribute("contaminations", contaminations);
				session.setAttribute("contiType", null);

				if (request.getParameter("habCode") != null) {
					session.setAttribute("habCode", (String) request.getParameter("habCode"));
				}
				/*
				 * ContaminationTypes contaminationTypes = new
				 * ContaminationTypes("FLOURIDE",0.0); contaminations.add(contaminationTypes);
				 * contaminationTypes = new ContaminationTypes("BRAKISH",0.0);
				 * contaminations.add(contaminationTypes); contaminationTypes = new
				 * ContaminationTypes("IRON",0.0); contaminations.add(contaminations);
				 */
				try {
					if (sourceForm.getDistrict() == null || sourceForm.getDistrict().equals("null")) {
						dists = rwsLocations.getDistricts();
						mandals = rwsLocations.getMandals((String) session.getAttribute("districtInAssetEntryForm"));
						panchyats = rwsLocations.getPanchayats(
								(String) session.getAttribute("districtInAssetEntryForm"),
								(String) session.getAttribute("mandalInAssetEntryForm"));
						villages = rwsLocations.getVillages((String) session.getAttribute("districtInAssetEntryForm"),
								(String) session.getAttribute("mandalInAssetEntryForm"),
								((String) session.getAttribute("habCodeInAssetEntryForm")).substring(12, 14));
						prhabs = rwsLocations.getHabitations((String) session.getAttribute("districtInAssetEntryForm"),
								(String) session.getAttribute("mandalInAssetEntryForm"),
								((String) session.getAttribute("habCodeInAssetEntryForm")).substring(12, 14),
								((String) session.getAttribute("habCodeInAssetEntryForm")).substring(7, 10));
						session.setAttribute("dists", dists);
						session.setAttribute("mandals", mandals);
						session.setAttribute("panchyats", panchyats);
						session.setAttribute("villages", villages);
						session.setAttribute("prhabs", prhabs);
						sourceForm.setDistrict((String) session.getAttribute("districtInAssetEntryForm"));
						sourceForm.setMandal((String) session.getAttribute("mandalInAssetEntryForm"));
						sourceForm
								.setPcode(((String) session.getAttribute("habCodeInAssetEntryForm")).substring(12, 14));
						sourceForm
								.setVcode(((String) session.getAttribute("habCodeInAssetEntryForm")).substring(7, 10));
						sourceForm.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
						sourceTypeCodes = commonLists.getSourceTypes();
					} else {
						dists = rwsLocations.getDistricts();
						session.setAttribute("dists", dists);
						if (request.getParameter("district") != null) {
							if (!(request.getParameter("district")).equalsIgnoreCase("0")) {
								mandals = rwsLocations.getMandals(request.getParameter("district"));
							}
						}
						session.setAttribute("mandals", mandals);
						if (request.getParameter("mandal") != null) {
							if (!(request.getParameter("district")).equalsIgnoreCase("0")
									&& !(request.getParameter("mandal")).equalsIgnoreCase("0")) {
								panchyats = rwsLocations.getPanchayats(request.getParameter("district"),
										request.getParameter("mandal"));
							}
						}
						session.setAttribute("panchyats", panchyats);
						if (request.getParameter("pcode") != null) {
							if (!(request.getParameter("district")).equalsIgnoreCase("0")) {
								villages = rwsLocations.getVillages(request.getParameter("district"),
										request.getParameter("mandal"), request.getParameter("pcode"));
							}
						}
						session.setAttribute("villages", villages);
						if (request.getParameter("vcode") != null) {
							if (!(request.getParameter("vcode")).equalsIgnoreCase("0")) {
								prhabs = rwsLocations.getHabitations(request.getParameter("district"),
										request.getParameter("mandal"), request.getParameter("pcode"),
										request.getParameter("vcode"));
								sourceTypeCodes = commonLists.getSourceTypes();
							}
						}
						session.setAttribute("prhabs", prhabs);
					}
					session.setAttribute("sourceTypeCodes", sourceTypeCodes);
					if (request.getParameter("sourceTypeCode") != null) {
						if (!request.getParameter("sourceTypeCode").equalsIgnoreCase("")) {
							subSourceTypeCodes = commonLists.getSubsourceTypes(request.getParameter("sourceTypeCode"));
						}
					}
				} catch (Exception e) {
					Debug.println("The error in1234   is " + e);
				}
				session.setAttribute("subSourceTypeCodes", subSourceTypeCodes);
				if (request.getParameter("subSourceTypeCode") != null
						&& !request.getParameter("subSourceTypeCode").equalsIgnoreCase("")
						&& !request.getParameter("sourceTypeCode").equalsIgnoreCase("")
						&& !(request.getParameter("district")).equalsIgnoreCase("0")
						&& !(request.getParameter("mandal")).equalsIgnoreCase("0")) {
					sourceCode = "";
					sourceCode = request.getParameter("habCode");
					String pcode = request.getParameter("pcode");
					String sourTypeCode = request.getParameter("sourceTypeCode");
					session.setAttribute("subSourceTypeCode", request.getParameter("subSourceTypeCode"));
					sourCode = RwsMasterData.getSourceCode(getDataSource(request), request.getParameter("habCode"),
							request.getParameter("pumpCode"), request.getParameter("sourceTypeCode"));
					int size = sourCode.size();
					try {
						if (size > 0) {
							for (int i = 0; i < sourCode.size(); i++) {
								sourceCode = (String) sourCode.get(i);
								phCode = sourceCode;
								sourceCode = sourceCode.substring(22, 24);
								slno = Integer.parseInt(sourceCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							phCode = sourceCode + pcode + "SO" + sourTypeCode;
							tempPCode = phCode;
						}
					} catch (Exception e) {
						Debug.println("The error in   is " + e);
					}
					try {
						if (tslno == 0) {
							tempPCode = tempPCode.substring(0, 22) + "01";
						} else if (tslno <= 9) {
							tempPCode = tempPCode.substring(0, 22) + "0" + (tslno + 1);
						} else {
							tempPCode = tempPCode.substring(0, 22) + (tslno + 1);
						}
					} catch (Exception e) {
						Debug.println("The Exception in StringIndexOutOfBoundsException  is " + e);
					}
				}
			} catch (Exception e) {
				Debug.println("The Exception in rws_SourceAct_frm vcode is " + e);
			}
		}
		if (mode.equalsIgnoreCase("asset")) {
			try {
				ArrayList assetHabSources = new ArrayList();
				ArrayList assetHab = new ArrayList();
				assetHabSources = RwsMasterData.getAssetsOnSameHabAsSources(request.getParameter("habCode"),
						request.getParameter("status"), getDataSource(request));
				for (int i = 0; i < assetHabSources.size(); i++) {
					rwsMaster = (RwsMaster) assetHabSources.get(i);
					assetHab.add(new AssetSourceBean("false", rwsMaster.getAssetTypeName(), rwsMaster.getAssetCode(),
							rwsMaster.getAssetName()));
				}
				sourceForm.setSourceAssets(assetHab);
			} catch (Exception e) {
				Debug.println("Excpetion at asset mode" + e);
			}
		}
		if (mode.equalsIgnoreCase("pickhab")) {
			try {
				ArrayList sourceHabs = new ArrayList();
				ArrayList HabSources = new ArrayList();
				HabSources = RwsMasterData.getHabAsSources(request.getParameter("district"),
						request.getParameter("mandal"), getDataSource(request));
				for (int i = 0; i < HabSources.size(); i++) {
					rwsMaster = (RwsMaster) HabSources.get(i);
					sourceHabs.add(new HabSourceBean(rwsMaster.getHabCode(), rwsMaster.getPanchRajCode(),
							rwsMaster.getPanchRajName(), rwsMaster.getTotalPop(), rwsMaster.getCoveredStatus()));
				}
				sourceForm.setSourceHabs(sourceHabs);
				request.setAttribute("assetCompTypeCode", "01");
				request.setAttribute("sourceHabs", sourceHabs);
			} catch (Exception e) {
				Debug.println("Excpetion at pickhab mode" + e);
			}
		}
		if (mode.equalsIgnoreCase("disphab")) {
			try {
				ArrayList sourceHabs = new ArrayList();
				ArrayList HabSources = new ArrayList();
				HabSources = RwsMasterData.getHabsOnSource(request.getParameter("sourceCode"), getDataSource(request));
				for (int i = 0; i < HabSources.size(); i++) {
					rwsMaster = (RwsMaster) HabSources.get(i);
					sourceHabs.add(new HabSourceBean(rwsMaster.getHabCode(), rwsMaster.getPanchRajCode(),
							rwsMaster.getPanchRajName(), rwsMaster.getTotalPop(), rwsMaster.getCoveredStatus()));
				}
				sourceForm.setSourceHabs(sourceHabs);
				session.setAttribute("noOfHab", request.getParameter("noOfHab"));
			} catch (Exception e) {
				Debug.println("Exception at disphab mode: " + e);
			}
		}

		if (mode.equalsIgnoreCase("Add")) {
			try {
				AssetSourceBean assetSourceBean = new AssetSourceBean();
				checkAssets = (ArrayList) sourceForm.getSourceAssets();
				ArrayList checkAssets1 = (ArrayList) session.getAttribute("checkAssets");
				ArrayList tempSelectedAssets = new ArrayList();
				for (int i = 0; i < checkAssets.size(); i++) {
					assetSourceBean = (AssetSourceBean) checkAssets.get(i);
					if (assetSourceBean.getHabCode().equalsIgnoreCase("on")) {
						tempSelectedAssets.add(assetSourceBean);
					}
				}
				if (checkAssets1 != null && checkAssets1.size() > 0) {
					checkAssets.addAll(checkAssets1);
				}
				for (int i = 0; i < checkAssets.size(); i++) {
					assetSourceBean = (AssetSourceBean) checkAssets.get(i);
				}
				session.setAttribute("checkAssets", tempSelectedAssets);
				session.setAttribute("tempSelectedAssets", tempSelectedAssets);
			} catch (Exception e) {
				Debug.println("Exception at Add mode " + e);
			}
		}
		if (mode.equalsIgnoreCase("AddHab")) {
			try {
				HabSourceBean habSourceBean = new HabSourceBean();
				checkHabs = (ArrayList) sourceForm.getSourceHabs();
				ArrayList tempSelectedSourceHabs = new ArrayList();
				tempSelectedSourceHabs.clear();
				ArrayList checkHabs1 = (ArrayList) session.getAttribute("checkHabs");
				int noOfHabs = 0;
				for (int i = 0; i < checkHabs.size(); i++) {
					habSourceBean = (HabSourceBean) checkHabs.get(i);
					if (habSourceBean.getHabCode() != null && habSourceBean.getHabCode().equalsIgnoreCase("on")) {
						tempSelectedSourceHabs.add(habSourceBean);
						noOfHabs = noOfHabs + 1;
					}
				}
				sourceForm.setNoOfHab(("" + noOfHabs));
				if (checkHabs1 != null && checkHabs1.size() > 0) {
					checkHabs.clear();
					checkHabs.addAll(checkHabs1);
				}
				for (int i = 0; i < checkHabs.size(); i++) {
					habSourceBean = (HabSourceBean) checkHabs.get(i);

				}
				session.setAttribute("checkHabs", checkHabs);
				session.setAttribute("tempSelectedSourceHabs", tempSelectedSourceHabs);
			} catch (Exception e) {
				Debug.println("Exception at AddHab mode " + e);
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			int[] rowCount = new int[10];
			try {
				rowCount = RwsMasterData.removeSource(request.getParameter("sourceCode"),
						(ArrayList) session.getAttribute("tempSelectedSourceHabs"), getDataSource(request));
				
			} catch (Exception e) {
				Debug.println("Exception at delete mode: " + e);
			}
			boolean recordDeleted = true;
			for (int i = 0; i < rowCount.length; i++) {
				if (rowCount[i] == 0 && i != rowCount.length - 1)
					recordDeleted = false;
			}
			if (rowCount.length == 0)
				message = "Record can't deleted";
			else {
				message = "Record deleted successfully";
			}
			request.setAttribute("message", message);
			sourceForm.setHabCode(request.getParameter("sourceCode").substring(0, 16));
			mode = "closeWithMessage";
			
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				String sourceTypeCode = (String) request.getParameter("sourceTypeCode");
				sourceForm.setAssetTypeCode(request.getParameter("assetTypeCode"));
				session.setAttribute("assetTypeCodeInSource", request.getParameter("assetTypeCode"));
				sources = RwsMasterData.getSources(getDataSource(request), sourceForm.getDistrict(),
						sourceForm.getMandal(), sourceForm.getPcode(), sourceForm.getVcode(), sourceForm.getHabCode(),
						request.getParameter("assetTypeCode"), sourceTypeCode, request.getParameter("assetCode"),
						request.getParameter("pumpCode"));
				session.setAttribute("sources", sources);
			} catch (Exception e) {
				Debug.println("Exception at view mode :  " + e);
			}
		}
		if (mode.equalsIgnoreCase("Save")) {
			boolean flag = false;
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					rwsMaster.setAssetTypeCode((String) session.getAttribute("assetTypeCodeInSource"));
					rwsMaster.setAssetCode((String) session.getAttribute("assetCode"));
					rwsMaster.setSourceCode(sourceForm.getSourceCode());
					rwsMaster.setSourceName(sourceForm.getSourceName());
					rwsMaster.setSourceTypeCode(sourceForm.getSourceTypeCode());
					rwsMaster.setSubSourceTypeCode(sourceForm.getSubSourceTypeCode());
					rwsMaster.setHabCode(sourceForm.getHabCode());
					if (sourceForm.getSourceTypeCode().equals("1")) {
						rwsMaster.setLocation(sourceForm.getLocation());
						rwsMaster.setType(sourceForm.getType());
						rwsMaster.setSourceDiameter(sourceForm.getSourceDiameter());
						rwsMaster.setSourceDepth(sourceForm.getSourceDepth());
					} else if (sourceForm.getSourceTypeCode().equals("2")) {
						rwsMaster.setTappingPoint(sourceForm.getTappingPoint());
					}
					rwsMaster.setNoOfHab(sourceForm.getNoOfHab());
					rwsMaster.setPopbenefited(sourceForm.getPopbenefited());
					rwsMaster.setSeasonal(sourceForm.getSeasonal());
					rwsMaster.setPresentCondition(sourceForm.getPresentCondition());
					rwsMaster.setWaterQuality(sourceForm.getWaterQuality());
					rwsMaster.setStaticWaterLevel(sourceForm.getStaticWaterLevel());
					rwsMaster.setSummerWaterLevel(sourceForm.getSummerWaterLevel());
					rwsMaster.setYield(sourceForm.getYield());
					rwsMaster.setDistFromSource(sourceForm.getDistFromSource());
					rwsMaster.setLevelOfCont(sourceForm.getLevelOfCont());
					rwsMaster.setContType(sourceForm.getContType());
					rwsMaster.setSourceDepth(sourceForm.getSourceDepth());
					rwsMaster.setLatitude(sourceForm.getLatitude());
					rwsMaster.setLongitude(sourceForm.getLongitude());
					rwsMaster.setElevation(sourceForm.getElevation());
					rwsMaster.setWaypoint(sourceForm.getWaypoint());
					rwsMaster.setTypeofTreatment(sourceForm.getTypeofTreatment());
					rwsMaster.setPlantCapacity(sourceForm.getPlantCapacity());
					if (sourceForm.getFlouride().equals(""))
						sourceForm.setFlouride("0");
					if (sourceForm.getBrakish().equals(""))
						sourceForm.setBrakish("0");
					if (sourceForm.getIron().equals(""))
						sourceForm.setIron("0");
					rwsMaster.setFlouride(Double.parseDouble(sourceForm.getFlouride()));
					rwsMaster.setBrakish(Double.parseDouble(sourceForm.getBrakish()));
					rwsMaster.setIron(Double.parseDouble(sourceForm.getIron()));
					rwsMaster.setOthers(sourceForm.getOthers());
					rwsMaster.setOthersType(sourceForm.getOthersType());
					String alt = "";
					if (request.getParameter("AltWaterSourceType") == null)
						alt = "";
					rwsMaster.setArea(alt);
					checkAssets = (ArrayList) session.getAttribute("tempSelectedAssets");
					checkHabs = (ArrayList) session.getAttribute("tempSelectedSourceHabs");
					flag = RwsMasterData.insertSource(rwsMaster, checkAssets, checkHabs, getDataSource(request));
				} catch (Exception e) {
					Debug.println("Exception at save mode  " + e);
				}
			}
			if (flag) {
				message = "Record Inserted Successfully.";
				sourceForm.reset(mapping, request);
				String habCode = sourceForm.getHabCode();
				String shortSchemeCode = (String) session.getAttribute("shortSchemeCode");
				SubCompMetaData subCompMetaData = new SubCompMetaData();
				String nextSchemeCode = subCompMetaData.getNextSchemeCode(getDataSource(request), "01", "01", "001",
						shortSchemeCode, habCode, (String) session.getAttribute("assetCode"));
				sourceForm.setSourceCode(nextSchemeCode);
				request.removeAttribute("scode");
				session.removeAttribute("checkAssets");
			} else {
				message = "Record cannot be inserted.";
			}
			request.setAttribute("message", message);
		}
		if (mode.equalsIgnoreCase("get") || mode.equalsIgnoreCase("viewSources")) {
			try {
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
				assetHabs = (ArrayList) ((SourceForm) form).getSourceHabs();
				session.setAttribute("tempSelectedSourceHabs", assetHabs);
				assetSources = RwsMasterData.getAssetsOnSource(request.getParameter("sourceCode"),
						getDataSource(request));
				session.setAttribute("assetSrcs", assetSources);
				if (!mode.equalsIgnoreCase("viewSources")) {
					sourceTypeCodes = commonLists.getSourceTypes();
					session.setAttribute("sourceTypeCodes", sourceTypeCodes);
					subSourceTypeCodes = commonLists.getSubsourceTypes(((SourceForm) form).getSourceTypeCode());
					session.setAttribute("subSourceTypeCodes", subSourceTypeCodes);
				}
				sourceForm.setAssetTypeCode((String) session.getAttribute("assetTypeCodeInSource"));

			} catch (Exception e) {
				Debug.println("the Exception in get or view sources modes is" + e.getMessage());
			}
			try {
				form = getSourceDetails(request, sourceForm, request.getParameter("sourceCode"));
			} catch (Exception e) {
				Debug.println("Exception in calling or in getSourceDetails is" + e);
			}
		}

		if (mode.equalsIgnoreCase("edit")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					rwsMaster.setAssetTypeCode((String) session.getAttribute("assetTypeCodeInSource"));
					rwsMaster.setAssetCode((String) session.getAttribute("assetCode"));
					rwsMaster.setSourceCode(sourceForm.getSourceCode());
					rwsMaster.setSourceName(sourceForm.getSourceName());
					rwsMaster.setSourceTypeCode(sourceForm.getSourceTypeCode());
					rwsMaster.setSubSourceTypeCode(sourceForm.getSubSourceTypeCode());
					rwsMaster.setHabCode(sourceForm.getHabCode());
					if (sourceForm.getSourceTypeCode().equals("1")) {
						rwsMaster.setLocation(sourceForm.getLocation());
						rwsMaster.setType(sourceForm.getType());
						rwsMaster.setSourceDiameter(sourceForm.getSourceDiameter());
						rwsMaster.setSourceDepth(sourceForm.getSourceDepth());
					} else if (sourceForm.getSourceTypeCode().equals("2")) {
						rwsMaster.setTappingPoint(sourceForm.getTappingPoint());
					}
					rwsMaster.setLevelOfCont(sourceForm.getLevelOfCont());
					rwsMaster.setContType(sourceForm.getContType());
					rwsMaster.setNoOfHab(sourceForm.getNoOfHab());
					rwsMaster.setPopbenefited(sourceForm.getPopbenefited());
					rwsMaster.setSeasonal(sourceForm.getSeasonal());
					rwsMaster.setPresentCondition(sourceForm.getPresentCondition());
					rwsMaster.setWaterQuality(sourceForm.getWaterQuality());
					rwsMaster.setStaticWaterLevel(sourceForm.getStaticWaterLevel());
					rwsMaster.setSummerWaterLevel(sourceForm.getSummerWaterLevel());
					rwsMaster.setYield(sourceForm.getYield());
					rwsMaster.setDistFromSource(sourceForm.getDistFromSource());
					rwsMaster.setLocation(sourceForm.getLocation());
					rwsMaster.setSourceHabs(sourceForm.getSourceHabs());
					if (sourceForm.getFlouride().equals(""))
						sourceForm.setFlouride("0");
					if (sourceForm.getBrakish().equals(""))
						sourceForm.setBrakish("0");
					if (sourceForm.getIron().equals(""))
						sourceForm.setIron("0");
					rwsMaster.setFlouride(Double.parseDouble(sourceForm.getFlouride()));
					rwsMaster.setBrakish(Double.parseDouble(sourceForm.getBrakish()));
					rwsMaster.setIron(Double.parseDouble(sourceForm.getIron()));
					rwsMaster.setOthers(sourceForm.getOthers());
					rwsMaster.setOthersType(sourceForm.getOthersType());
					rwsMaster.setType(sourceForm.getType());
					rwsMaster.setSourceDiameter(sourceForm.getSourceDiameter());
					rwsMaster.setSourceDepth(sourceForm.getSourceDepth());
					rwsMaster.setStaticWaterLevel(sourceForm.getStaticWaterLevel());
					rwsMaster.setSummerWaterLevel(sourceForm.getSummerWaterLevel());
					rwsMaster.setLatitude(sourceForm.getLatitude());
					rwsMaster.setLongitude(sourceForm.getLongitude());
					rwsMaster.setElevation(sourceForm.getElevation());
					rwsMaster.setWaypoint(sourceForm.getWaypoint());
					
					if(sourceForm.getTypeofTreatment()==null)
						rwsMaster.setTypeofTreatment("");
					else
						rwsMaster.setTypeofTreatment(sourceForm.getTypeofTreatment());
					if(sourceForm.getPlantCapacity()==null)
						rwsMaster.setPlantCapacity("0");
					else
					rwsMaster.setPlantCapacity(sourceForm.getPlantCapacity());
					String alt = "";
					if (request.getParameter("AltWaterSourceType") == null)
						alt = "";
					rwsMaster.setArea(alt);
					ans = RwsMasterData.updateSource(rwsMaster, getDataSource(request));
					if (ans > 0) {
						message = "Data Updated Succesfully";
						mode = "closeWithMessage";
					} else {
						message = "Data cannot be Updated";
					}
					request.setAttribute("message", message);
				} catch (Exception e) {
					Debug.println("the Exception at edit  mode : " + e);
				}
			}
		}
		return (mapping.findForward(mode));
	}
}
