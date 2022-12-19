package nic.watersoft.masters;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.DAOMessage;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_AssetAct_frm extends Action {
	AssetForm form = new AssetForm();

	public AssetForm addNewSubComponent(String mode, HttpServletRequest request, AssetForm assetForm) {
		
		HttpSession session = request.getSession();
		String typeOfAssetCode = "";
		String assetCompTypeCode = "";
		String assetSubCompTypeCode = "";
		ArrayList assetsubCompParams = new ArrayList();
		Asset_Reservior asset_reservior = null;
		Asset_Pumpset asset_pumpset = null;
		Asset_PipeLine asset_pipeline = null;
		Asset_HeadWorks asset_headworks = null;
		Asset_SubComponent asset_subcomponent = null;
		try {
			typeOfAssetCode = request.getParameter("assetTypeCode");
			assetCompTypeCode = request.getParameter("assetCompTypeCode");
			assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
			assetsubCompParams.clear();
			String Code = "";
			int No;
			if (typeOfAssetCode.equals("05") && assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("001")) {
				Asset_SHP asset_SHP = new Asset_SHP();
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_SHP.setShallowHandPumpCode(nextSubCompCode);
				asset_SHP.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_SHP);
				assetForm.setAssetSHP(assetsubCompParams);
				assetForm.setMode("ponds");
				session.setAttribute("assetsubCompParams", "SHP");
			}
			if (typeOfAssetCode.equals("06") && assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("001")) {
				Asset_OpenWells asset_openWells = new Asset_OpenWells();
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_openWells.setOpenWellCode(nextSubCompCode);
				asset_openWells.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_openWells);
				assetForm.setAssetOpenWells(assetsubCompParams);
				session.setAttribute("assetsubCompParams", "OpenWells");
				assetForm.setMode("ponds");
			}
			if (typeOfAssetCode.equals("07") && assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("001")) {
				Asset_Ponds asset_ponds = new Asset_Ponds();
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_ponds.setPondCode(nextSubCompCode);
				asset_ponds.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_ponds);
				assetForm.setAssetPonds(assetsubCompParams);
				session.setAttribute("assetsubCompParams", "Ponds");
				assetForm.setMode("ponds");
			}
			if (typeOfAssetCode.equals("08") && assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("001")) {
				Asset_Others asset_others = new Asset_Others();
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_others.setGeneralCode(nextSubCompCode);
				asset_others.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_others);
				assetForm.setAssetOthers(assetsubCompParams);
				session.setAttribute("assetsubCompParams", "Others");
				assetForm.setMode("ponds");
			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("003")) {
				assetForm.setMode("pumpset");
				assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
				session.removeAttribute("assetsubCompPWSParams");
				assetsubCompParams.clear();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setPumpCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("pumpset");
			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("06")
					&& assetSubCompTypeCode.equals("001")) {
				assetForm.setMode("pumpset");
				assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
				session.removeAttribute("assetsubCompPWSParams");
				assetsubCompParams.clear();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setPumpCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);

				assetForm.setMode("pumpset");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("001")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setCollectionWellCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("002")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setSsTankCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& (assetSubCompTypeCode.equals("003") || assetSubCompTypeCode.equals("004"))
					|| assetSubCompTypeCode.equals("010") || assetSubCompTypeCode.equals("011")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setWtpCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				if (assetSubCompTypeCode.equals("003"))
					asset_headworks.setWtpType("SSF");
				if (assetSubCompTypeCode.equals("004"))
					asset_headworks.setWtpType("RSF");
				if (assetSubCompTypeCode.equals("010"))
					asset_headworks.setWtpType("MSF");
				if (assetSubCompTypeCode.equals("011"))
					asset_headworks.setWtpType("ROP");
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("005")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setSumpCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("006")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setBridgeCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("007")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setPumpHouseCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("008")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setWatchManCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("009")) {
				assetsubCompParams = (ArrayList) session.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();
				asset_headworks.setCollectionWellCode(nextSubCompCode);
				asset_headworks.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");
			}
			else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("001")) {
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();
				asset_pipeline.setPmCode(nextSubCompCode);
				asset_pipeline.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pipeline);
				assetForm.setAssetPipeLine(assetsubCompParams);
				session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
				session.setAttribute("assetsubCompParams", "PwsPumpingMain");
				assetForm.setMode("pumpset");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("002")) {
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();
				asset_pipeline.setGravitymain_code(nextSubCompCode);
				asset_pipeline.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pipeline);
				assetForm.setAssetPipeLine(assetsubCompParams);
				assetForm.setMode("pumpset");
				session.setAttribute("assetsubCompParams", "GravityMain");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("003")) {
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();
				asset_pipeline.setDisCode(nextSubCompCode);
				asset_pipeline.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pipeline);
				assetForm.setAssetPipeLine(assetsubCompParams);
				assetForm.setMode("pumpset");
				session.setAttribute("assetsubCompParams", "Distribution");
			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("001")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setOhsrCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			}
			else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("002")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setOhbrCode(nextSubCompCode);
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("003")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setGlsrCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("004")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setGlbrCode(nextSubCompCode);
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("005")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setBptCode(nextSubCompCode);
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("006")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setCisCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("007")) {
				assetsubCompParams = assetForm.getAssetReservior();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();
				asset_reservior.setStandPostCode(nextSubCompCode);
				assetsubCompParams.add(asset_reservior);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			}
			else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				asset_subcomponent = new Asset_SubComponent();
				Code = (String) session.getAttribute("phCode");
				asset_subcomponent.setPmpCode((String) session.getAttribute("phCode"));
				assetsubCompParams.add(asset_subcomponent);
				assetForm.setAssetSubComponents(assetsubCompParams);
				No = Integer.parseInt(Code.substring(21, 24)) + 1;
				Code = Code.substring(0, 21) + "00" + No;
				session.setAttribute("phCode", Code);
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("001")) {
				assetsubCompParams = assetForm.getAssetPumpSets();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setOtherCompCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");

			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("002")) {
				assetsubCompParams = assetForm.getAssetPumpSets();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setOtherCompCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");
			} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
					|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("003")) {
				assetsubCompParams = assetForm.getAssetPumpSets();
				String nextSubCompCode = (String) session.getAttribute("nextSubCompCode");
				Asset_Others asset_others = new Asset_Others();
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_others);
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");
			} else if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				asset_subcomponent = new Asset_SubComponent();
				Code = (String) session.getAttribute("phCode");
				asset_subcomponent.setHpCode((String) session.getAttribute("phCode"));
				assetsubCompParams.add(asset_subcomponent);
				assetForm.setAssetSubComponents(assetsubCompParams);
				No = Integer.parseInt(Code.substring(21, 24)) + 1;
				Code = Code.substring(0, 21) + "00" + No;
				assetForm.setMode("pumpset");
			}
		} catch (Exception e) {
			Debug.println("Exception in addNewSubComponent  is " + e);
		}
		return assetForm;
	}

	protected String getNextSubComponentCode(String code) {
		int tslno = 0;
		//System.out.println(code.length());
		tslno = Integer.parseInt(code.substring(21, 24));
		String tempPCode = null;
		if (tslno == 0) {
			tempPCode = code.substring(0, 21) + "001";
		} else if (tslno <= 8) {
			tempPCode = code.substring(0, 21) + "00" + (tslno + 1);
		} else if (tslno <= 98) {
			tempPCode = code.substring(0, 21) + "0" + (tslno + 1);
		} else {
			tempPCode = code.substring(0, 21) + (tslno + 1);
		}
		return tempPCode;
	}

	protected void getAssetSubComponents(AssetForm assetForm, HttpServletRequest request, String pumpCode)
			throws Exception {
		try {
			HttpSession session = null;
			ArrayList assetCompTypes = new ArrayList();
			String habCode = null;
			String assetTypeName = "";
			ArrayList sources = new ArrayList();
			ArrayList headWorks = new ArrayList();
			ArrayList pipeLine = new ArrayList();
			ArrayList resorvior = new ArrayList();
			ArrayList pumpsets = new ArrayList();
			ArrayList pumping = new ArrayList();
			CommonLists commonLists;
			String opType = "";
			ArrayList tempSelectedHabs = new ArrayList();
			session = request.getSession();
			commonLists = new CommonLists(getDataSource(request));
			assetCompTypes = commonLists.getAssetComponents(request.getParameter("assetTypeCode"));
			session.removeAttribute("headWorks");
			session.removeAttribute("pipeLine");
			session.removeAttribute("resorvior");
			session.removeAttribute("pumpsets");
			//System.out.println("assetCompTypes"+assetCompTypes.size());
			for (int i = 0; i < assetCompTypes.size(); i++) {
				LabelValueBean labelValueBean = (LabelValueBean) assetCompTypes.get(i);
				assetTypeName = RwsMasterData.getAssetTypeName(request.getParameter("assetTypeCode"),
						getDataSource(request));
				String assetCompName = RwsMasterData.getAssetCompTypeName(labelValueBean.getValue(),
						request.getParameter("assetTypeCode"), getDataSource(request));
				String assetTypeCode = assetForm.getAssetTypeCode();
				habCode = assetForm.getHabCode();
				opType = assetForm.getOpType();
//System.out.println("assetTypeName "+assetTypeName);
				if ((assetTypeName.trim().equalsIgnoreCase("PONDS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("SHALLOW HAND PUMPS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
					//System.out.println("sorcessssssssss"+sources.size());
				}
				if ((assetTypeName.trim().equalsIgnoreCase("OTHERS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("OPEN WELLS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					session.removeAttribute("headWorks");
					session.removeAttribute("pipeLine");
					session.removeAttribute("resorvior");
					session.removeAttribute("pumpsets");

					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
				if (assetTypeName.trim().equalsIgnoreCase("HANDPUMPS")
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("SOURCE")) {
					sources = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("HEADWORKS")) {
					headWorks = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("PIPELINE")) {
					pipeLine = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& (labelValueBean.getLabel().trim().equalsIgnoreCase("SR. RESERVOIRS")
								|| labelValueBean.getLabel().trim().equalsIgnoreCase("RESERVOIRS"))) {
					resorvior = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("OTHERS")) {
					pumpsets = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("PWS") || assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase("PUMPING")) {
					pumping = RwsMasterData.getAssetSubComps(getDataSource(request), assetTypeCode, assetTypeName,
							labelValueBean.getValue(), assetCompName, habCode, pumpCode, opType);
				}
			}
			if (tempSelectedHabs.size() > 0) {
				assetForm.setAssetHabs((ArrayList) session.getAttribute("tempSelectedHabs"));
			} else {
				tempSelectedHabs = RwsMasterData.getAssetHabCodes(getDataSource(request), assetForm.getHabCode(),
						pumpCode, assetForm.getAssetTypeCode());
				assetForm.setAssetHabs(tempSelectedHabs);

				session.setAttribute("tempSelectedHabs", new ArrayList(tempSelectedHabs));
			}

			if (assetTypeName.trim().equals("HANDPUMPS")) {
				// Debug.println("2:: Sources size=" + sources.size());
				if (sources.size() > 0)
					session.setAttribute("sources", sources);

			} else {
				// Debug.println("3:: else part Sources size=" + sources.size());
				session.setAttribute("sources", sources);

				if (!(assetTypeName.trim().equalsIgnoreCase("SHALLOW HAND PUMPS"))
						&& !(assetTypeName.trim().equalsIgnoreCase("OTHERS"))
						&& !(assetTypeName.trim().equalsIgnoreCase("OPEN WELLS"))
						&& !(assetTypeName.trim().equalsIgnoreCase("HANDPUMPS"))
						&& !(assetTypeName.trim().equalsIgnoreCase("PONDS"))) {
					if (headWorks.size() > 0)
						session.setAttribute("headWorks", headWorks);

					if (pipeLine.size() > 0)
						session.setAttribute("pipeLine", pipeLine);

					if (resorvior.size() > 0)
						session.setAttribute("resorvior", resorvior);

					if (pumpsets.size() > 0)
						session.setAttribute("pumpsets", pumpsets);

					if (pumping.size() > 0)
						session.setAttribute("pumping", pumping);
				}
			}
		} catch (Exception e) {
			Debug.println("Exception in rws_asstact_frm getsubcomponentsDetails:    " + e);
		//	e.printStackTrace();
		}
	}

	protected void subcomponentDetails(AssetForm assetForm, String assetTypeCode, HttpServletRequest request)
			throws Exception {
		RwsMaster rwsMaster = new RwsMaster();
		ArrayList assetSubComps = new ArrayList();
		ArrayList assetPipeLine = new ArrayList();
		ArrayList assetHeadWorks = new ArrayList();
		ArrayList assetReservior = new ArrayList();
		try {
			request.setAttribute("sourceParam", "sourceParam");
			ArrayList pwsSources = RwsMasterData.getAssetSubCompNames(assetTypeCode, "01", getDataSource(request));

			for (int i = 0; i < pwsSources.size(); i++) {
				rwsMaster = (RwsMaster) pwsSources.get(i);
				assetSubComps.add(new Asset_SubComponent(rwsMaster.getAssetSubCompTypeName()));
			}
			assetForm.setAssetSubComponents(assetSubComps);
			request.setAttribute("headWorksParam", "headWorksParam");
			ArrayList pwsHeadWorks = RwsMasterData.getAssetSubCompNames(assetTypeCode, "02", getDataSource(request));

			for (int i = 0; i < pwsHeadWorks.size(); i++) {
				rwsMaster = (RwsMaster) pwsHeadWorks.get(i);
				assetHeadWorks.add(new Asset_HeadWorks(rwsMaster.getAssetSubCompTypeName()));
			}
			assetForm.setAssetHeadWorks(assetHeadWorks);

			request.setAttribute("pipeLineParam", "pipeLineParam");
			ArrayList pwsPipeLine = RwsMasterData.getAssetSubCompNames(assetTypeCode, "03", getDataSource(request));

			for (int i = 0; i < pwsPipeLine.size(); i++) {
				rwsMaster = (RwsMaster) pwsPipeLine.get(i);
				assetPipeLine.add(new Asset_PipeLine(rwsMaster.getAssetSubCompTypeName()));
			}
			assetForm.setAssetPipeLine(assetPipeLine);

			request.setAttribute("resorviorsParam", "resorviorsParam");
			ArrayList pwsReservior = RwsMasterData.getAssetSubCompNames(assetTypeCode, "04", getDataSource(request));

			for (int i = 0; i < pwsReservior.size(); i++) {
				rwsMaster = (RwsMaster) pwsReservior.get(i);
				assetReservior.add(new Asset_Reservior(rwsMaster.getAssetSubCompTypeName()));
			}
			assetForm.setAssetReservior(assetReservior);

		} catch (Exception e) {
			Debug.println("Exception at subcomponentDetails rws_asstact_frm:   " + e);
		}
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.gc();
		String mode = null;
		try {
			ArrayList circles = null;
			ArrayList divisions = null;
			ArrayList subdivisions = null;
			ArrayList mandals = null;
			ArrayList prhabs = new ArrayList();
			ArrayList dists = new ArrayList();

			ArrayList assets = null;
			ArrayList assetTypes = new ArrayList();
			ArrayList assetsubCompParams = new ArrayList();

			ArrayList headWorks = new ArrayList();
			ArrayList pipeLine = new ArrayList();
			ArrayList resorvior = new ArrayList();

			ArrayList assetCompTypes = new ArrayList();
			ArrayList assetsubCompTypes = new ArrayList();
			ArrayList sources = new ArrayList();
			ArrayList tempSelectedHabs = new ArrayList();
			ArrayList subdivs = new ArrayList();

			Asset_SubComponent asset_subcomponent = new Asset_SubComponent();
			Asset_HeadWorks asset_headworks = new Asset_HeadWorks();
			Asset_PipeLine asset_pipeline = new Asset_PipeLine();
			Asset_Pumpset asset_pumpset = new Asset_Pumpset();
			Asset_Reservior asset_reservior = new Asset_Reservior();

			ArrayList checkedHabs = new ArrayList();
			ArrayList habs = new ArrayList();
			ArrayList schemeCodes = new ArrayList();
			PanchRaj panchRaj = new PanchRaj();
			ArrayList pipeMaterial = new ArrayList();
			ArrayList pipeClasses = new ArrayList();
			ArrayList assetSubComps = new ArrayList();

			ArrayList assetsubCompTempParams = new ArrayList();
			CommonLists commonLists = new CommonLists(getDataSource(request));
			RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));

			RwsMaster rwsMaster = new RwsMaster();
			RwsMasterData rwsMatserData = new RwsMasterData();
			RwsMasterData.connCount--;
			AssetForm assetForm = (AssetForm) form;
			String headOfficeCode = assetForm.getHeadOfficeCode();
			String circleOfficeCode = assetForm.getCircleOfficeCode();
			String divisionOfficeCode = assetForm.getDivisionOfficeCode();
			String subdivisionOfficeCode = assetForm.getSubdivisionOfficeCode();
			String assetCode = null;

			String assetSubCompCode = "";

			HttpSession session = request.getSession();
			RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			session = request.getSession();
			if (user == null || session == null)
				return mapping.findForward("expire");

			if (!(user.getUserId() != null
					&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
							|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
				return mapping.findForward("unAuthorise");
			}

			String message = null;
			String displaymess = null;
			String habCode = null;
			String assetTypeName = "";
			String pumpCode = "";
			String opType = "";
			String typeOfAssetCode = "";
			String assetCompTypeCode = "";
			String assetSubCompTypeCode = "";
			String returnVal = "";
			int incval = 1;

			DAOMessage daoMessage = new DAOMessage();

			int[] rcount = null;
			int countTmp = 0;

			mode = (String) request.getParameter("mode");
			typeOfAssetCode = request.getParameter("assetTypeCode");
			assetCompTypeCode = request.getParameter("assetCompTypeCode");
			assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
			returnVal = request.getParameter("returnVal");
			if (returnVal != null) {
				session.setAttribute("returnVal", returnVal);
			}

			if (request.getParameter("assetSubCompTypeCode") != null)
				assetSubCompCode = (String) request.getParameter("assetSubCompTypeCode");
			if (headOfficeCode == null) {
				headOfficeCode = user.getHeadOfficeCode();
			}
			if (circleOfficeCode == null || (circleOfficeCode != null && circleOfficeCode.equals(""))) {
				circleOfficeCode = user.getCircleOfficeCode();
			}
			if (divisionOfficeCode == null) {
				divisionOfficeCode = user.getDivisionOfficeCode();
			}
			if (subdivisionOfficeCode == null || subdivisionOfficeCode.equals("")) {
				subdivisionOfficeCode = user.getSubdivisionOfficeCode();
			}

			if (mode != null && mode.equals("mode")) {
			}
			if (mode != null && mode.equals("init")) {
				try {
					request.setAttribute("message",
							"You cannot Enter the Assets which are Created on (or) after 01.04.2009 Except for HandPumps/Direct Pumping");
					if (incval == 1) {
						if (returnVal == null) {
							assetForm.setCircleOfficeCode("");
							assetForm.setDivisionOfficeCode("");
							assetForm.setSubdivisionOfficeCode("");
							assetForm.setDistrict("");
							assetForm.setMandal("");
							assetForm.setHabCode("");
							assetForm.setHabName("");
							assetForm.setRemarks("");
							assetForm.setDpYield("");
							incval++;
						}
					}
					if (circleOfficeCode.equals("00")) {
						circles = rwsOffices.getCircles(headOfficeCode);
						divisions = null;
						subdivisions = null;
						session.removeAttribute("divisions");
						session.removeAttribute("subdivisions");
					}
					if (circleOfficeCode != null && !circleOfficeCode.equals("00") && !circleOfficeCode.equals("")
							&& divisionOfficeCode.equals("0") && !mode.equals("divisions")) {
						divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
					}
					if (!circleOfficeCode.equals("00") && !divisionOfficeCode.equals("0")
							&& subdivisionOfficeCode.equals("00"))
						subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);

					if (divisionOfficeCode != null && !divisionOfficeCode.equals("0")
							&& !divisionOfficeCode.equals("")) {
						subdivs = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
					}
					if (subdivisionOfficeCode != null && !subdivisionOfficeCode.equals("00")
							&& !subdivisionOfficeCode.equals("")) {
						mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode, divisionOfficeCode,
								subdivisionOfficeCode, getDataSource(request));
					}
					if (circles != null)
						session.setAttribute("circles", circles);
					if (divisions != null)
						session.setAttribute("divisions", divisions);
					if (subdivisions != null)
						session.setAttribute("subdivisions", subdivisions);
					if (mandals != null)
						session.setAttribute("mandals", mandals);
					if (circleOfficeCode != null && !circleOfficeCode.equals("00") && !circleOfficeCode.equals("")) {
						session.setAttribute("distName",
								RwsMasterData.getDistName(getDataSource(request), circleOfficeCode));
						assetForm.setDcode(circleOfficeCode);
					} else {
						session.setAttribute("distName", "");
					}
					if (circleOfficeCode != null && divisionOfficeCode != null && subdivisionOfficeCode != null) {
						assetTypes = commonLists.getAssetTypes();
						session.setAttribute("assetTypes", assetTypes);
					} else {
						session.removeAttribute("assetTypes");
					}
				} catch (Exception e) {
					Debug.println("Exception in init mode is " + e);
				}
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equalsIgnoreCase("data")) {
				String spMode = request.getParameter("spMode");
				if (spMode != null && spMode.equals("modeScheme")) {
					circleOfficeCode = request.getParameter("circleOfficeCode");
					assetForm.setCircleOfficeCode(circleOfficeCode);
					divisionOfficeCode = request.getParameter("divisionOfficeCode");
					assetForm.setDivisionOfficeCode(divisionOfficeCode);
					subdivisionOfficeCode = request.getParameter("subdivisionOfficeCode");
					assetForm.setSubdivisionOfficeCode(subdivisionOfficeCode);
					String mandal = request.getParameter("mandal");
					String dname = RwsMasterData.getDistName(getDataSource(request), circleOfficeCode);
					assetForm.setDistrict(dname);
					assetForm.setDcode(circleOfficeCode);
					session.setAttribute("distName", dname);
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
					session.setAttribute("divisions", divisions);
					subdivisions = rwsOffices.getSubdivisions("1", circleOfficeCode, divisionOfficeCode);
					session.setAttribute("subdivisions", subdivisions);
					mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode, divisionOfficeCode,
							subdivisionOfficeCode, getDataSource(request));
					session.setAttribute("mandals", mandals);
					prhabs = rwsLocation.getMandalHabitations(assetForm.getCircleOfficeCode(), mandal);
					session.setAttribute("prhabs", prhabs);
					schemeCodes = commonLists.getSchemeCodes(request.getParameter("assetTypeCode"),
							request.getParameter("habCode"));
					session.setAttribute("schemeCodes", schemeCodes);
					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);
				}
				if (assetForm.getPumpCode() == null || assetForm.getPumpCode().equals("")) {
					assetForm.setPumpCode((String) request.getAttribute("pumpCode"));
				}
				if (assetForm.getPumpCode() != null) {
					session.setAttribute("shortSchemeCode", assetForm.getPumpCode());
				}
				try {

					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);

					String dcode = RwsMasterData.getDcode(getDataSource(request), assetForm.getDistrict());
					session.setAttribute("districtNameInAssetEntryForm", assetForm.getDistrict());
					session.setAttribute("districtInAssetEntryForm", assetForm.getCircleOfficeCode());
					session.setAttribute("mandalInAssetEntryForm", assetForm.getMandal());
					session.setAttribute("panchayatInAssetEntryForm", (String) request.getParameter("pcode"));
					session.setAttribute("villageInAssetEntryForm", (String) request.getParameter("vcode"));
					session.setAttribute("habCodeInAssetEntryForm", assetForm.getHabCode());
					session.setAttribute("shortSchemeCodeInAssetEntryForm", assetForm.getPumpCode());
					if (circleOfficeCode != null && divisionOfficeCode != null && subdivisionOfficeCode != null
							&& request.getParameter("habCode") != null && request.getParameter("assetTypeCode") != null
							&& request.getParameter("opType") == null) {
						if (request.getParameter("assetTypeCode").length() != 0 && circleOfficeCode.length() != 0
								&& divisionOfficeCode.length() != 0 && subdivisionOfficeCode.length() != 0
								&& request.getParameter("habCode").length() != 0) {
							session.removeAttribute("tempSelectedHabs");
							session.removeAttribute("habs");
							opType = "Modify";
						} else {
							request.setAttribute("assetCode", "");
						}
					}
					if (circleOfficeCode != null && divisionOfficeCode != null && subdivisionOfficeCode != null
							&& request.getParameter("habCode") != null && request.getParameter("assetTypeCode") != null
							&& request.getParameter("opType") != null)
						if (request.getParameter("assetTypeCode").length() != 0 && circleOfficeCode.length() != 0
								&& divisionOfficeCode.length() != 0 && subdivisionOfficeCode.length() != 0
								&& request.getParameter("habCode").length() != 0
								&& request.getParameter("opType").length() != 0) {
							session.removeAttribute("sources");
							session.removeAttribute("headWorks");
							session.removeAttribute("pipeLine");
							session.removeAttribute("resorvior");
							session.removeAttribute("pumpsets");
							opType = request.getParameter("opType");
						}
					rwsMaster = RwsMasterData.getAssetDetails(assetForm.getHabCode(), assetForm.getAssetTypeCode(),
							assetForm.getPumpCode(), getDataSource(request));
					double TotPB = 0.0;
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
					try {
						if (request.getParameter("assetTypeCode").equals("01")
								|| request.getParameter("assetTypeCode").equals("02")
								|| request.getParameter("assetTypeCode").equals("03")) {
							TotPB = rwsMaster.getTotPopBenfit()
									* Math.pow(1.02, Integer.parseInt(sdf.format(new Date())) - 2001);
						} else {
							TotPB = rwsMaster.getTotPopBenfit();
						}
					} catch (Exception e) {
						//e.printStackTrace();
						Debug.println("Exception in data mode:" + e.getMessage());
					}
//					Debug.println("^^opType is " + assetForm.getOpType());
					opType = assetForm.getOpType();
					if (opType.equals("Modify")) {
						assetForm.setAssetCode(rwsMaster.getAssetCode());
						assetForm.setAssetName(rwsMaster.getAssetName());
						assetForm.setLocation(rwsMaster.getLocation());
						assetForm.setAssetCost(rwsMaster.getAssetCost());
						assetForm.setStartYear(rwsMaster.getStartYear());
						assetForm.setEndYear(rwsMaster.getEndYear());
						assetForm.setDefunctReasons(rwsMaster.getDefunctReasons());
						assetForm.setDateofCreation(rwsMaster.getDateofCreation());
						assetForm.setAssetStatus(rwsMaster.getAssetStatus());
						assetForm.setTotHabs(rwsMaster.getTotHabs());
						assetForm.setRemarks(rwsMaster.getRemarks());
						assetForm.setLastRepairedDate(rwsMaster.getLastRepairedDate());
						assetForm.setTotPopBenfit((int) Math.round(Math.ceil(TotPB)));
						session.setAttribute("assetCode", assetForm.getAssetCode());
						assetForm.setDpYield(rwsMaster.getDpYield());
						assetForm.setDivisionOfficeCode(rwsMaster.getDivisionOfficeCode());
						assetForm.setSubdivisionOfficeCode(rwsMaster.getSubdivisionOfficeCode());
						assetForm.setMandal(rwsMaster.getMandalCode());
						assetForm.setHabCode(rwsMaster.getHabCode());
						assetForm.setLatitude(rwsMaster.getLatitude());
						assetForm.setLongitude(rwsMaster.getLongitude());
						assetForm.setElevation(rwsMaster.getElevation());
						assetForm.setWaypoint(rwsMaster.getWaypoint());
						assetForm.setLastRepairedDate(rwsMaster.getLastRepairedDate());
					}
					getAssetSubComponents(assetForm, request, assetForm.getPumpCode());
					
					if (request.getParameter("assetTypeCode") != null)
						assetCompTypes = commonLists.getAssetComponents(request.getParameter("assetTypeCode"));
					session.setAttribute("assetCompTypes", assetCompTypes);
					session.setAttribute("opType", "Modify");
				} catch (Exception e) {
					Debug.println("The data in rws_AssetAct_frm data" + e);
				}
				return mapping.findForward("data");

			}
			if (mode != null && mode.equals("water")) {
				try {
					if (circleOfficeCode.equals("00")) {
						circles = rwsOffices.getCircles(headOfficeCode);
						divisions = null;
						subdivisions = null;
						session.removeAttribute("divisions");
						session.removeAttribute("subdivisions");
					}
					if (circleOfficeCode != null && !circleOfficeCode.equals("00") && !circleOfficeCode.equals("")
							&& divisionOfficeCode.equals("0") && !mode.equals("divisions")) {
						divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
					}
					if (!circleOfficeCode.equals("00") && !divisionOfficeCode.equals("0")
							&& subdivisionOfficeCode.equals("00")) {
						subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
					}
					if (divisionOfficeCode != null && !divisionOfficeCode.equals("0")
							&& !divisionOfficeCode.equals("")) {
						subdivs = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
					}
					if (subdivisionOfficeCode != null && !subdivisionOfficeCode.equals("00")
							&& !subdivisionOfficeCode.equals("")) {
						mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode, divisionOfficeCode,
								subdivisionOfficeCode, getDataSource(request));
					}
					if (circles != null)
						session.setAttribute("circles", circles);
					if (divisions != null)
						session.setAttribute("divisions", divisions);
					if (subdivisions != null)
						session.setAttribute("subdivisions", subdivisions);
					if (mandals != null)
						session.setAttribute("mandals", mandals);
					if (circleOfficeCode != null && !circleOfficeCode.equals("00") && !circleOfficeCode.equals("")) {
						session.setAttribute("distName",
								RwsMasterData.getDistName(getDataSource(request), circleOfficeCode));
						assetForm.setDcode(circleOfficeCode);
					} else {
						session.setAttribute("distName", "");
					}
					if (session.getAttribute("subdivisions") == null)
						session.setAttribute("subdivisions", new ArrayList());
					if (session.getAttribute("mandals") == null)
						session.setAttribute("mandals", new ArrayList());
					if (session.getAttribute("prhabs") == null)
						session.setAttribute("prhabs", new ArrayList());
					if (session.getAttribute("assetTypes") == null)
						session.setAttribute("assetTypes", new ArrayList());
					if (session.getAttribute("schemeCodes") == null)
						session.setAttribute("schemeCodes", new ArrayList());
				} catch (Exception e) {
					Debug.println("Exception in init mode is " + e);
				}
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equals("circles")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circles = rwsOffices.getCircles(headOfficeCode);
				assetForm.setCircleOfficeCode("00");
				assetForm.setDivisionOfficeCode("0");
				assetForm.setSubdivisionOfficeCode("00");
				session.setAttribute("divisions", new ArrayList());
				session.setAttribute("subdivisions", new ArrayList());
				session.setAttribute("mandals", new ArrayList());
				session.setAttribute("prhabs", new ArrayList());
				session.setAttribute("circles", circles);
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equals("divisions")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circleOfficeCode = assetForm.getCircleOfficeCode();
				divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
				assetForm.setDivisionOfficeCode("0");
				assetForm.setSubdivisionOfficeCode("00");
				session.setAttribute("subdivisions", new ArrayList());
				session.setAttribute("mandals", new ArrayList());
				session.setAttribute("prhabs", new ArrayList());

				session.setAttribute("divisions", divisions);
				session.setAttribute("distName", RwsMasterData.getDistName(getDataSource(request), circleOfficeCode));
				assetForm.setDistrict(RwsMasterData.getDistName(getDataSource(request), circleOfficeCode));
				assetForm.setDcode(circleOfficeCode);
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);

			}
			if (mode != null && mode.equals("subdivisions")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circleOfficeCode = assetForm.getCircleOfficeCode();
				divisionOfficeCode = assetForm.getDivisionOfficeCode();
				assetForm.setSubdivisionOfficeCode("00");
				subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
				session.setAttribute("subdivisions", subdivisions);

				session.setAttribute("mandals", new ArrayList());
				session.setAttribute("prhabs", new ArrayList());
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equals("mandals")) {
				circleOfficeCode = assetForm.getCircleOfficeCode();
				divisionOfficeCode = assetForm.getDivisionOfficeCode();
				subdivisionOfficeCode = assetForm.getSubdivisionOfficeCode();
				mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode, divisionOfficeCode,
						subdivisionOfficeCode, getDataSource(request));
				session.setAttribute("mandals", mandals);
				session.setAttribute("prhabs", new ArrayList());
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);

			}
			if (mode != null && mode.equals("prhabs")) {
				if (assetForm.getMandal() != null && !assetForm.getMandal().equals("")) {
					prhabs = rwsLocation.getMandalHabitations(assetForm.getCircleOfficeCode(), assetForm.getMandal());
					session.setAttribute("prhabs", prhabs);
					assetForm.reset(mapping, request);
					return mapping.findForward(mode);
				}
			}

			if (mode.equalsIgnoreCase("updateImage")) {
//				System.out.println("imageUpload--");
				mode = "imageUpload";
			}

			if (assetForm.getSourceHabs() != null) {
				ArrayList checkHabsTmp = (ArrayList) assetForm.getSourceHabs();
			}
			mode = (String) request.getParameter("mode");

			if (mode != null && mode.equalsIgnoreCase("pickpipemat")) {
				String code = request.getParameter("code");
				String NoOfPipes = request.getParameter("disNoOfPipes");

				if (request.getParameter("code") != null)
					session.setAttribute("code", request.getParameter("code"));

				int ndx = 0;

				try {

					if (request.getParameter("disNoOfPipes") != null)
						session.setAttribute("NoOfPipes", request.getParameter("disNoOfPipes"));
					session.setAttribute("assetsubCompParams", "pickpipemat");
					ArrayList params = RwsMasterData.getPipeMaterialList(getDataSource(request),
							(String) session.getAttribute("code"));
					params = fillPipeLine(params, getDataSource(request));
					assetForm.setAssetPipeLine(params);

					return mapping.findForward("pickpipemat");
				} catch (Exception e) {
					Debug.println("error in pipeclass mode is " + e);
				}
				return mapping.findForward("pickpipemat");
			}

			if (mode != null && mode.equalsIgnoreCase("addNewPipeType")) {
				try {
					pipeMaterial = commonLists.getPipeMatirals();
					assetForm.setPipeMaterial(pipeMaterial);
					String code = (String) request.getParameter("code");
					assetsubCompParams.clear();
					
					assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
//					Debug.println("calling fillPipeLine");
					assetsubCompParams = fillPipeLine(assetsubCompParams, getDataSource(request));
					assetForm.setAssetPipeLine(assetsubCompParams);

					if (request.getParameter("materialChanged") == null) {
//						Debug.println("size of assetsusbCompParams is before adding" + assetsubCompParams.size());
						Asset_PipeLine assetPipeLineTemp = new Asset_PipeLine();
						assetPipeLineTemp.setMaterial("");
						assetPipeLineTemp.setDiameter("");
						assetPipeLineTemp.setLength("");
						assetPipeLineTemp.setPclass("");
						ArrayList comboList = new ArrayList();
						assetPipeLineTemp.setPipeMaterialList(pipeMaterial);
						assetPipeLineTemp.setPipeClassList(comboList);
						assetPipeLineTemp.setPipeDiameterList(comboList);
						assetsubCompParams.add(assetPipeLineTemp);
						assetForm.setAssetPipeLine(assetsubCompParams);
					}
				} catch (Exception e) {
					Debug.println("error in addNewPipeType" + e);
				}
				return mapping.findForward("pickpipemat");
			}

			if (mode != null && mode.equalsIgnoreCase("removePipeTypes")) {
//				Debug.println("endter record deleted");
				try {
					assetsubCompTempParams = new ArrayList();
					int rowCount = 0;
					assetsubCompTempParams.clear();
					assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					String[] removeIds = request.getParameterValues("remove");
					if (removeIds != null && removeIds.length != 0) {
						int x = 0;
						for (int p = removeIds.length; p > 0; p--) {
							x = Integer.parseInt(removeIds[p - 1]);
							assetsubCompTempParams.add(assetsubCompParams.get(x));
							assetsubCompParams.remove(x);
						}
					}
					assetsubCompParams = fillPipeLine(assetsubCompParams, getDataSource(request));
					assetForm.setAssetPipeLine(assetsubCompParams);
					int size = assetsubCompParams.size();
					rowCount = RwsMasterData.removeAssetSubCompPipeTypes(getDataSource(request), assetsubCompTempParams,
							(String) session.getAttribute("code"));
//					Debug.println("rowCount  value " + rowCount);
					if (rowCount > 0) {
						message = "Record(s) Deleted";
					} else {
						 message = "The Record(s) Cant be Deleted";
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("error in remove subcomp (in act.java)  " + e);
				}
				return mapping.findForward("pickpipemat");
			}

			if (mode.equalsIgnoreCase("pickhab")) {
				try {
					String schemeCode = (String) request.getParameter("schemeCode");
					SubCompMetaData subCompMetaData = new SubCompMetaData(schemeCode);
					request.setAttribute("baseHab", schemeCode.substring(0, 16));
					ArrayList sourceHabs = new ArrayList();
					ArrayList HabSources = new ArrayList();
					rwsMaster = new RwsMaster();
					HabSources = RwsMasterData.getHabAsSourcesForReservoirs(getDataSource(request), schemeCode,
							request.getParameter("assetCode"));

					for (int i = 0; i < HabSources.size(); i++) {
						rwsMaster = (RwsMaster) HabSources.get(i);
						sourceHabs.add(new HabSourceBean(rwsMaster.getHabCode(), rwsMaster.getPanchRajCode(),
								rwsMaster.getPanchRajName(), rwsMaster.getTotalPop(), rwsMaster.getCoveredStatus(),
								rwsMaster.isSaved()));
					}
			/*		for (int i = 0; i < sourceHabs.size(); i++) {
						Debug.println("HabCode for " + i + "is " + ((HabSourceBean) sourceHabs.get(i)).getHabCode());
					}*/
					assetForm.setSourceHabs(new ArrayList(sourceHabs));

					for (int i = 0; i < sourceHabs.size(); i++) {
						HabSourceBean habSourceBeanTmp = new HabSourceBean();
						habSourceBeanTmp = (HabSourceBean) sourceHabs.get(i);
					/*	Debug.println("checkHabs checkBox[" + i + "] is " + habSourceBeanTmp.getHabCode()
								+ " and isSaved is " + habSourceBeanTmp.isSaved() + " and isChecked is "
								+ habSourceBeanTmp.getIsChecked());*/
					}
					request.setAttribute("sourceHabs", sourceHabs);

				} catch (Exception e) {
					Debug.println("Exception at pickhab: " + e);
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("AddHab")) {
				ArrayList checkHabs = new ArrayList();
				String assetTypeCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
				String schemeCode = request.getParameter("schemeCode");
				try {
					HabSourceBean habSourceBean = new HabSourceBean();
					checkHabs = (ArrayList) assetForm.getSourceHabs();
					request.setAttribute("ohsrHabCount", "" + checkHabs.size());
					int checkHabsCount = 0;
					for (int i = 0; i < checkHabs.size(); i++) {
						HabSourceBean habSourceBeanTmp = new HabSourceBean();
						habSourceBeanTmp = (HabSourceBean) checkHabs.get(i);
						if (habSourceBeanTmp.getIsChecked().equals("true")) {
							checkHabsCount++;
						/*	Debug.println("checkHabs checkBox[" + i + "] is " + habSourceBeanTmp.getHabCode()
									+ " and isSaved is " + habSourceBeanTmp.isSaved() + " and isChecked is "
									+ habSourceBeanTmp.getIsChecked());*/
						}

					}
					request.setAttribute("checkHabsCount", "" + checkHabsCount);
					ArrayList asset_reservoirList = (ArrayList) session.getAttribute("assetReserviorOhsr");
					RwsMasterData.insertHabLink2(getDataSource(request), "RWS_OHGLCI_HAB_LINK_TBL", checkHabs,
							schemeCode);
				} catch (Exception e) {
					Debug.println("the error in rws_source_frm checks= " + e);
				}
				return mapping.findForward("close");
			}
			if (mode.equals("getDists")) {
				RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
				ArrayList distss = rwsLocations.getDistricts();
				session.setAttribute("dists", distss);
				mode = "habLink";
				ArrayList assetdists = RwsMasterData.getAssetDists(request.getParameter("assetCode"));
				if (assetdists == null || (assetdists != null && assetdists.size() == 0)) {
					assetdists.add(0, assetForm.getCircleOfficeCode());
				}
				request.setAttribute("assetdists", assetdists);
				return mapping.findForward(mode);
			}
			if (mode.equals("carryHabs")) {
				try {
					String[] habsarray = request.getParameterValues("habs");
					RwsMaster rm = null;
					tempSelectedHabs = new ArrayList();
					tempSelectedHabs = (ArrayList) session.getAttribute("tempSelectedHabs");
					ArrayList removeTempSelectedHabs = new ArrayList();
					for (int i = 0; i < habsarray.length; i++) {
						rm = new RwsMaster();
						rm.setHabCode(habsarray[i]);
						removeTempSelectedHabs.add(rm);
					}
					for (int i = 0; i < removeTempSelectedHabs.size(); i++) {
						rm = (RwsMaster) removeTempSelectedHabs.get(i);
					}
					session.setAttribute("tempSelectedHabs", removeTempSelectedHabs);
					session.setAttribute("assetHabs", removeTempSelectedHabs);
					request.setAttribute("message",
							"Selected Habitations temporarily Added Successfully and Click on SAVE Button to add permanently");
					return mapping.findForward("close4");
				} catch (Exception ee) {
					System.out.println("Exception in carryHabs mode : "+ee);
					//ee.printStackTrace();
				}

			}
			/*
			 * this part of the code is executed when add & view habitations button is
			 * pressed in asset entry from this block creates arraylist prhabs which
			 * contains mandals in the session and assigns to the asset form. It also
			 * creates arraylist selectedHabs and adds to session in the name of
			 * tempSelectedHabs.tempSelectedHabs contains habitations linked with the asset
			 * feteched from database. This block also sets base habitation (fetched from
			 * request parameter) to request in the name of baseHabitation .
			 */
			if (mode.equals("hab")) {
				try {
					dists = rwsLocation.getDistricts();
					String assetTypeCode = request.getParameter("assetTypeCode");
					if (assetTypeCode == null)
						assetTypeCode = "";
					// handpumps does not contain habitation linkage hence the
					// code from habitation linkage is excluded for assetType 04
					if (assetTypeCode.equals("04")) {
						prhabs = RwsMasterData.getAssetHabitations(request.getParameter("habCode"),
								getDataSource(request));
						assetForm.setAssetHabs(prhabs);
						assetForm.setMandal(RwsMasterData.getMandalName(request.getParameter("dcode"),
								request.getParameter("mandal"), getDataSource(request), RwsOffices.getConn()));
						session.removeAttribute("mandals");
						session.setAttribute("mandal", request.getParameter("mandal"));
					} else {
						session.removeAttribute("mandal");
						if (request.getParameter("dcode") != null && request.getParameter("dcode").length() != 0) {
							mandals = rwsLocation.getMandals(request.getParameter("dcode"));
						}
						if (request.getParameter("mandal") != null && request.getParameter("mandal").length() != 0) {
							prhabs = RwsMasterData.getAssetHabs(getDataSource(request), request.getParameter("dcode"),
									request.getParameter("mandal"));
							assetForm.setAssetHabs(prhabs);
							assetForm.setMandal(request.getParameter("mandal"));
						}
						session.setAttribute("district", request.getParameter("dcode"));
						session.setAttribute("dists", dists);
						session.setAttribute("mandals", mandals);
						ArrayList selectedHabs = RwsMasterData.getSelectedHabitationLinkageForAsset(
								getDataSource(request), (String) session.getAttribute("assetCode"));

						if (request.getParameter("habCode") != null)
							request.setAttribute("baseHabitation", request.getParameter("habCode"));
						session.setAttribute("tempSelectedHabs", selectedHabs);
					}

				} catch (Exception e) {
					Debug.println("Exception in hab mode is:  " + e.getMessage());
				}
				return mapping.findForward(mode);// to be seen whether this line
													// be commented or not
			}

			if (mode.equals("disp")) {
				try {
//					Debug.println("hab len=" + ((ArrayList) session.getAttribute("tempSelectedHabs")).size());
					if (((ArrayList) session.getAttribute("tempSelectedHabs")).size() > 0)
						assetForm.setAssetHabs((ArrayList) session.getAttribute("tempSelectedHabs"));
					if (request.getParameter("assetCompTypeCode") != null) {
						if ((request.getParameter("assetCompTypeCode")).length() != 0) {

							assetsubCompTypes = commonLists.getAssetSubComponents(
									request.getParameter("typeOfAssetCode"), request.getParameter("assetCompTypeCode"));
						}
					}
					session.setAttribute("assetSubCompTypes", assetsubCompTypes);

					if (request.getParameter("typeOfAssetCode") != null) {
						if (request.getParameter("typeOfAssetCode").equalsIgnoreCase("01")) {

							subcomponentDetails(assetForm, request.getParameter("typeOfAssetCode"), request);
						} else if (request.getParameter("typeOfAssetCode").equalsIgnoreCase("02")) {
							subcomponentDetails(assetForm, request.getParameter("typeOfAssetCode"), request);
						} else if (request.getParameter("typeOfAssetCode").equalsIgnoreCase("03")) {
							subcomponentDetails(assetForm, request.getParameter("typeOfAssetCode"), request);

						} else if (request.getParameter("typeOfAssetCode").equalsIgnoreCase("04")) {
							request.setAttribute("sourceParam", "sourceParam");
							ArrayList pwsSources = RwsMasterData.getAssetSubCompNames(
									request.getParameter("typeOfAssetCode"), "01", getDataSource(request));
							for (int i = 0; i < pwsSources.size(); i++) {
								rwsMaster = (RwsMaster) pwsSources.get(i);
								assetSubComps.add(new Asset_SubComponent(rwsMaster.getAssetSubCompTypeName()));
							}
							assetForm.setAssetSubComponents(assetSubComps);
						}
					}

				} catch (Exception e) {
					Debug.println("Exception in mode disp : "+e.getMessage());
				}
			}

			if (mode.equalsIgnoreCase("ShowHabsBenfit")) {
				message = saveAsset(assetForm, request);
				request.setAttribute("message", message);
				mode = "data";
			}

			if (mode != null && mode.equalsIgnoreCase("assetTypeCodeChanged")) {
				assetForm.setOpType("notSelected");
				session.setAttribute("schemeCodes", new ArrayList());
				assetForm.setAssetName("");
				assetForm.setLocation("");
				assetForm.setAssetStatus("");
				assetForm.setStartYear("");
				assetForm.setDateofCreation("");
				assetForm.setAssetCost("");
				assetForm.setTotHabs(0);
				assetForm.setTotPopBenfit(0);
				assetForm.setRemarks("");
				assetForm.setDpYield("");
				session.setAttribute("opType", "notSelected");
				return mapping.findForward(mode);
			}

			if (mode != null && mode.equalsIgnoreCase("opMissingCodes")) {
				ArrayList missingCodes = RwsMasterData.getMissingCodes(getDataSource(request),
						request.getParameter("assetTypeCode"), request.getParameter("habCode"));
				request.setAttribute("missingCodes", missingCodes);
//				for (int i = 0; i < missingCodes.size(); i++) {
//					Debug.println(missingCodes.get(i) + "");
//				}
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equalsIgnoreCase("opAddNew")) {
				assetTypeName = RwsMasterData.getAssetTypeName(request.getParameter("assetTypeCode"),
						getDataSource(request));
				pumpCode = commonLists.getPumpCode(request.getParameter("assetTypeCode"), assetTypeName,
						request.getParameter("habCode"));
				// Debug.println("pumpCode is " + pumpCode);
				session.setAttribute("opType", "Add New");
				assetForm.setPumpCode(pumpCode);
				assetForm.setDpYield("");
				getAssetSubComponents(assetForm, request, pumpCode);
				assetCode = getNewAssetCode(request, circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode,
						request.getParameter("habCode"), request.getParameter("assetTypeCode"));
				if (assetCode.length() > 14) {
					int len = assetCode.length() - 14;
					assetCode = assetCode.substring(len, assetCode.length());
				}

				if (request.getParameter("assetTypeCode").equals("02")) {
					if (Integer.parseInt(pumpCode) > 450) {
						request.setAttribute("message", "MPWS Asset Range Not exceed 450");
						assetForm.setPumpCode("");
						pumpCode = "";
					}
				}
				if (request.getParameter("assetTypeCode").equals("09")) {
					if (Integer.parseInt(pumpCode) > 499) {
						request.setAttribute("message", "DIRECT PUMPING Asset Range Not exceed 450");
						assetForm.setPumpCode("");
						pumpCode = "";
					}
				}
				session.setAttribute("assetCode", assetCode);
				session.removeAttribute("assetCompTypes");
				session.removeAttribute("assetSubCompTypes");
				session.removeAttribute("headWorks");
				session.removeAttribute("pipeLine");
				session.removeAttribute("resorvior");
				session.removeAttribute("pumpsets");
				assetForm.setAssetName("");
				assetForm.setLocation("");
				assetForm.setAssetStatus("");
				assetForm.setStartYear("");
				assetForm.setDateofCreation("");
				assetForm.setAssetCost("");
				assetForm.setTotHabs(0);
				assetForm.setTotPopBenfit(0);
				assetForm.setRemarks("");
				if (assetForm.getPumpCode() == null || assetForm.getPumpCode().equals("")) {
					assetForm.setPumpCode((String) request.getAttribute("pumpCode"));
				}
				if (assetForm.getPumpCode() != null) {
					session.setAttribute("shortSchemeCode", assetForm.getPumpCode());
				}
				try {
					schemeCodes = commonLists.getSchemeCodes(request.getParameter("assetTypeCode"),
							request.getParameter("habCode"));
					session.setAttribute("schemeCodes", schemeCodes);
					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);
					String dcode = RwsMasterData.getDcode(getDataSource(request), assetForm.getDistrict());
					session.setAttribute("districtNameInAssetEntryForm", assetForm.getDistrict());
					session.setAttribute("districtInAssetEntryForm", assetForm.getCircleOfficeCode());
					session.setAttribute("mandalInAssetEntryForm", assetForm.getMandal());
					session.setAttribute("panchayatInAssetEntryForm", (String) request.getParameter("pcode"));
					session.setAttribute("villageInAssetEntryForm", (String) request.getParameter("vcode"));
					session.setAttribute("habCodeInAssetEntryForm", assetForm.getHabCode());
					session.setAttribute("shortSchemeCodeInAssetEntryForm", assetForm.getPumpCode());
				} catch (Exception e) {
					Debug.println("Exception in opAddNew in  rws_AssetAct_frm data" + e);
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("getNew")) {
				try {
					RwsMaster rwsMasters = RwsMasterData.getAssetDetails(request.getParameter("assetCode"));
					assetForm.setCircleOfficeCode(request.getParameter("circleOfficeCode"));
					assetForm.setDivisionOfficeCode(rwsMasters.getDivisionOfficeCode());
					assetForm.setSubdivisionOfficeCode(rwsMasters.getSubdivisionOfficeCode());
					assetForm.setAssetTypeCode(rwsMasters.getAssetTypeCode());
					session.setAttribute("opType", "Modify");
					session.setAttribute("assetCode", request.getParameter("assetCode"));
					assetForm.setPumpCode(request.getParameter("schemeCode").substring(16, 19));
					request.setAttribute("pumpCode", assetForm.getPumpCode());
					assetForm.setHabCode(rwsMasters.getHabCode());
					assetForm.setMandal(rwsMasters.getHabCode().substring(5, 7));
					schemeCodes = commonLists.getSchemeCodes(request.getParameter("assetTypeCode"),
							request.getParameter("schemeCode").substring(0, 16));
					session.setAttribute("schemeCodes", schemeCodes);
					subdivisions = rwsOffices.getSubdivisions("1", request.getParameter("schemeCode").substring(0, 2),
							rwsMasters.getDivisionOfficeCode());
					session.setAttribute("subdivisions", subdivisions);
					mandals = RwsMasterData.getsubdivisionmandals(request.getParameter("schemeCode").substring(0, 2),
							rwsMasters.getDivisionOfficeCode(), rwsMasters.getSubdivisionOfficeCode(),
							getDataSource(request));
					session.setAttribute("mandals", mandals);
					prhabs = rwsLocation.getMandalHabitations(request.getParameter("schemeCode").substring(0, 2),
							request.getParameter("schemeCode").substring(5, 7));
					session.setAttribute("prhabs", prhabs);
				} catch (Exception e) {
					Debug.println("Exception in getNew : " + e);
				}
				return mapping.findForward(mode);
			}
			if (assetForm.getMode().equals("goToAddNewAction")) {
				assetForm = addNewSubComponent(mode, request, assetForm);
				return mapping.findForward(assetForm.getMode());
			}

			if (mode != null && mode.equalsIgnoreCase("remove")) {
				String[] removeIds = request.getParameterValues("remove");
				if (removeIds != null && removeIds.length != 0) {
//					for (int p = 0; p < removeIds.length; p++)
//						Debug.println("removeIds[" + p + "] : " + removeIds[p]);
				}
				if (assetCompTypeCode.equals("05"))
					assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();
				else if (assetCompTypeCode.equals("04"))
					assetsubCompParams = (ArrayList) assetForm.getAssetReservior();
				else if (assetCompTypeCode.equals("02"))
					assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
				else if (assetCompTypeCode.equals("03"))
					assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();

				int size = assetsubCompParams.size();
				for (int i = removeIds.length; i > 0; i--)
					assetsubCompParams.remove(Integer.parseInt(removeIds[(i - 1)]));
				if (assetCompTypeCode.equals("05")) {
					assetForm.setAssetPumpSets(assetsubCompParams);
					return mapping.findForward("pumpsets");
				} else if (assetCompTypeCode.equals("04"))
					assetForm.setAssetReservior(assetsubCompParams);
				else if (assetCompTypeCode.equals("02"))
					assetForm.setAssetHeadWorks(assetsubCompParams);
				else if (assetCompTypeCode.equals("03"))
					assetForm.setAssetPipeLine(assetsubCompParams);
			}
			if (mode != null && mode.equalsIgnoreCase("removeSubComps")) {
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
//					Debug.println("endter record deleted " + typeOfAssetCode + "bbb   " + assetCompTypeCode + "uuu ");
					int rowCount = 0;
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request.getParameter("assetTypeCode");
					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();

					String[] removeIds = request.getParameterValues("remove");
					try {
						if (removeIds != null && removeIds.length != 0) {
							int x = 0;
							for (int p = removeIds.length; p > 0; p--) {
								x = Integer.parseInt(removeIds[p - 1]);
								assetsubCompTempParams.add(assetsubCompParams.get(x));
								assetsubCompParams.remove(x);
							}
						}
						int size = assetsubCompParams.size();
					} catch (Exception e) {
						Debug.println("exception in getting remove values " + e);
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09") || typeOfAssetCode.equals("04")
							|| typeOfAssetCode.equals("05")) && assetCompTypeCode.equals("02")) {
						assetForm.setAssetHeadWorks(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams, "Headworks");
						assetForm.setAssetHeadWorks(assetsubCompParams);
						if (rowCount > 0) {
							message = "Record(s) Deleted";
						} else {
							message = "The Record(s) Cant be Deleted";
						}
						request.setAttribute("message", message);
						return mapping.findForward("removeSubComps");
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")|| typeOfAssetCode.equals("03") 
							|| typeOfAssetCode.equals("09")	|| typeOfAssetCode.equals("04") 
							|| typeOfAssetCode.equals("05"))&& assetCompTypeCode.equals("03")) {
						assetForm.setAssetPipeLine(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetForm.getAssetPipeLine(), "Pipeline");
						if (rowCount > 0) {
							message = "Record(s) Deleted";
						} else {
							message = "The Record(s) Cant be Deleted";
						}
						request.setAttribute("message", message);
						mode = "pumpset";
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")|| typeOfAssetCode.equals("03") 
							|| typeOfAssetCode.equals("09")	|| typeOfAssetCode.equals("04")
							|| typeOfAssetCode.equals("05"))&& assetCompTypeCode.equals("04")) {
						// assetForm.setAssetReservior(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams, "Reservoirs");
						if (rowCount > 0) {
							message = "Record(s) Deleted";
						} else {
							message = "The Record(s) Cant be Deleted";
						}
						request.setAttribute("message", message);
						assetForm.setAssetReservior(assetsubCompParams);
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")|| typeOfAssetCode.equals("03") 
							|| typeOfAssetCode.equals("09")|| typeOfAssetCode.equals("04")
							|| typeOfAssetCode.equals("05"))&& assetCompTypeCode.equals("05")) {
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams, "PumpSets");
						assetForm.setAssetPumpSets(assetsubCompParams);
						if (rowCount > 0) {
							message = "Record(s) Deleted";
						} else {
							message = "The Record(s) Cant be Deleted";
						}
						request.setAttribute("message", message);
						return mapping.findForward("addNew");
					}

					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09") || typeOfAssetCode.equals("04")
							|| typeOfAssetCode.equals("05")) && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("003")) {
						assetsubCompTempParams.clear();
						asset_pumpset.setPumpCode((String) request.getParameter("pumpCode"));
						asset_pumpset.setAssetCode((String) request.getParameter("assetCode"));
						asset_pumpset.setPumpType((String) request.getParameter("pumpType"));
						asset_pumpset.setPumpControlPanel((String) request.getParameter("pumpControlPanel"));
						assetsubCompTempParams.add(asset_pumpset);
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams, "PumpSets");
						if (rowCount > 0)
							assetsubCompTempParams.clear();
						assetForm.setAssetPumpSets(assetsubCompTempParams);
					}
					if (rowCount > 0) {
						message = "Record(s) Deleted";
					} else {
						message = "The Record(s) Cant be Deleted";
						Debug.println("  not Deleted");
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("Exception at removeSubComps :  " + e);
				}
			}
			if (mode.equalsIgnoreCase("removePumpset")) {
				if (assetCompTypeCode.equals("06"))
					assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();
				Asset_Pumpset as = new Asset_Pumpset();
				for (int i = 0; i < assetsubCompParams.size(); i++) {
					as = (Asset_Pumpset) assetsubCompParams.get(i);
					if (as.getAssetCode().equals(request.getParameter("assetCode"))) {
						assetsubCompParams.remove(i);
						assetsubCompTempParams.add(i, assetsubCompParams.get(i));
					}
				}
				int rowCount = 0;
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
				String assetCd = (String) session.getAttribute("assetCode");
				String assetTypeCode = request.getParameter("assetTypeCode");
				if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
						|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("06")
						&& assetSubCompTypeCode.equals("001")) {
					assetsubCompTempParams.clear();
					asset_pumpset.setPumpCode((String) request.getParameter("pumpCode"));
					asset_pumpset.setAssetCode((String) request.getParameter("assetCode"));
					asset_pumpset.setPumpType((String) request.getParameter("pumpType"));
					asset_pumpset.setPumpControlPanel((String) request.getParameter("pumpControlPanel"));
					assetsubCompTempParams.add(asset_pumpset);
					rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
							assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams, "PumpSets");
					if (rowCount > 0) {
						assetsubCompTempParams.clear();
						request.setAttribute("message", "Record Deleted");
					} else {
						request.setAttribute("message", "Record Can't be Deleted");
					}
					assetForm.setAssetPumpSets(assetsubCompParams);
					mode = "pumpset";
				}
			}
			if (mode != null && mode.equals("showCompImage")) {
				try {
					RwsMasterData rms = new RwsMasterData();
					String sourceid = request.getParameter("sourceid");
					String astCode = request.getParameter("assetCode");
					byte a[] = rms.getSourceIdScannedCopy(sourceid, astCode);
					session.setAttribute("copyData", a);
				} catch (Exception e) {
					Debug.println("Exception at showCompImage :  " + e);
				}
				mode = "showFile";
				return mapping.findForward(mode);
			}
			if (mode.equalsIgnoreCase("previous")) {
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String bwCount;
					int size;
					int bwCnt;
					if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt - 1));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
					} else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt - 1));
							assetForm.setAssetPumpSets(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
					} else if (typeOfAssetCode.equals("03") && assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt - 1));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
					}
				} catch (Exception e) {
					Debug.println("Exception at previous:   "+e);
				}
			}
			if (mode.equalsIgnoreCase("previouspump")) {
				try {
					session.removeAttribute("first");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String bwCount;
					int size = -1;
					int bwCnt = 0;
					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt - 1));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
						if (assetsubCompParams.get(0) != null) {
							request.setAttribute("currentRow", "" + assetsubCompTempParams.size());
							request.setAttribute("totalRecords", "" + size);
						}

					} else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt - 1));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
					}
					if (size == bwCnt + 1) {
						session.setAttribute("last", "last");
					} else {
						session.removeAttribute("last");
					}
					if (size == 0) {
						session.setAttribute("prev", "prev");
					} else {
						session.removeAttribute("prev");
					}
				} catch (Exception e) {
					Debug.println("Exception at previouspump  "+e);
				}
			}
			if (mode.equalsIgnoreCase("getNextBw")) {
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
				opType = request.getParameter("opType");
				pumpCode = "";
				pumpCode = request.getParameter("hpCode");
				mode = "pumpset";
				session.setAttribute("assetsubCompParams", "HandPumps");
				assetsubCompParams = RwsMasterData.getAssetNextSubCompBwParams(getDataSource(request),
						request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
						request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
						request.getParameter("habCode"), pumpCode, request.getParameter("opType"));
				Debug.println("assetsubCompParams size is " + assetsubCompParams.size());
				assetForm.setAssetSubComponents(assetsubCompParams);
				mode = "pumpset";
				if (assetsubCompParams.get(0) != null) {
					if (opType.equals("next"))
						request.setAttribute("nextNotExists", ((RwsMaster) assetsubCompParams.get(0)).getIsLast());
					if (opType.equals("previous"))
						request.setAttribute("previousNotExists", ((RwsMaster) assetsubCompParams.get(0)).getIsLast());
					if (opType.equals("first"))
						request.setAttribute("previousNotExists", "true");
					if (opType.equals("last"))
						request.setAttribute("nextNotExists", "true");
					request.setAttribute("currentRow", ((RwsMaster) assetsubCompParams.get(0)).getCurrentRow() + "");
					request.setAttribute("totalRecords", ((RwsMaster) assetsubCompParams.get(0)).getRowCount() + "");
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("getNextSubComponent")) {
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
				opType = request.getParameter("opType");
				pumpCode = "";
				if (assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("003")) {
					pumpCode = request.getParameter("pumpCode");
				}
				if (assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("001")) {
					pumpCode = request.getParameter("pmCode");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams", "CpwsPumpingMain");
				}
				if (assetCompTypeCode.equals("06") && assetSubCompTypeCode.equals("001")) {
					pumpCode = request.getParameter("pumpCode");
				}
				if (assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("002")) {
					pumpCode = request.getParameter("gravitymain_code");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams", "GravityMain");
				}
				if (assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("003")) {
					pumpCode = request.getParameter("disCode");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams", "Distribution");
				}
				assetsubCompParams = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
						request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
						request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
						request.getParameter("habCode"), pumpCode, request.getParameter("opType"));

				if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
						|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("06")
						&& assetSubCompTypeCode.equals("001")) {
					assetForm.setAssetPumpSets(assetsubCompParams);
					mode = "navigatePumpset";
				}
				if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
						|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("03")
						&& (assetSubCompTypeCode.equals("001") || assetSubCompTypeCode.equals("002")
								|| assetSubCompTypeCode.equals("003"))) {
					assetForm.setAssetPipeLine(assetsubCompParams);
					mode = "navigatePumpset";
				}
				if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
						|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("6")
						&& assetSubCompTypeCode.equals("001")) {
					assetForm.setAssetPipeLine(assetsubCompParams);
					mode = "navigatePumpset";
				}
				if (assetsubCompParams.get(0) != null) {
					if (assetCompTypeCode.equals("01") && assetSubCompTypeCode.equals("003")) {
						if (opType.equals("next"))
							request.setAttribute("nextNotExists",
									((Asset_Pumpset) assetsubCompParams.get(0)).getIsLast());
						if (opType.equals("previous"))
							request.setAttribute("previousNotExists",
									((Asset_Pumpset) assetsubCompParams.get(0)).getIsLast());
						if (opType.equals("first"))
							request.setAttribute("previousNotExists", "true");
						if (opType.equals("last"))
							request.setAttribute("nextNotExists", "true");
						request.setAttribute("currentRow",
								((Asset_Pumpset) assetsubCompParams.get(0)).getCurrentRow() + "");
						request.setAttribute("totalRecords",
								((Asset_Pumpset) assetsubCompParams.get(0)).getRowCount() + "");
					}
					if (assetCompTypeCode.equals("03") && (assetSubCompTypeCode.equals("001")
							|| assetSubCompTypeCode.equals("002") || assetSubCompTypeCode.equals("003"))) {
						if (opType.equals("next"))
							request.setAttribute("nextNotExists",
									((Asset_PipeLine) assetsubCompParams.get(0)).getIsLast());
						if (opType.equals("previous"))
							request.setAttribute("previousNotExists",
									((Asset_PipeLine) assetsubCompParams.get(0)).getIsLast());
						if (opType.equals("first"))
							request.setAttribute("previousNotExists", "true");
						if (opType.equals("last"))
							request.setAttribute("nextNotExists", "true");
						request.setAttribute("currentRow",
								((Asset_PipeLine) assetsubCompParams.get(0)).getCurrentRow() + "");
						request.setAttribute("totalRecords",
								((Asset_PipeLine) assetsubCompParams.get(0)).getRowCount() + "");
					}
				}
				return mapping.findForward(mode);
			}
			if (mode.equalsIgnoreCase("next")) {
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm.setAssetSubComponents(assetsubCompTempParams);
						}
					} else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						String bwCount = (String) session.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetPumpSets(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_pumpset = new Asset_Pumpset();
							rwsMaster.setPmpCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						}
					}
					else if (typeOfAssetCode.equals("03") && assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						String bwCount = (String) session.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							rwsMaster.setGravitymain_code((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pipeline);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
						}
					} else if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm.setAssetSubComponents(assetsubCompTempParams);
						}
					}
				} catch (Exception e) {
					Debug.println("Exception at Next mode:   " + e);
				}
			}

			if (mode.equalsIgnoreCase("firstHP")) {
				try {
					int size = -1, bwCnt = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						assetsubCompTempParams.clear();
						assetsubCompTempParams.add(assetsubCompParams.get(0));
						assetForm.setAssetSubComponents(assetsubCompTempParams);
						bwCount = String.valueOf(bwCnt);
						session.setAttribute("bwCount", bwCount);
					}
				} catch (Exception e) {
					Debug.println("Exception at firstHP mode : " + e);
				}
			}

			if (mode.equalsIgnoreCase("lastHP")) {
				try {
					int size = -1, bwCnt = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(size - 1));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						}
					}
				} catch (Exception e) {
					Debug.println("Exception at lastHP mode : " + e);
				}
			}
			if (mode.equalsIgnoreCase("nextpump")) {
				try {
					int size = -1, bwCnt = 0;
					session.removeAttribute("first");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm.setAssetSubComponents(assetsubCompTempParams);
						}
						if (assetsubCompParams.get(0) != null) {
							request.setAttribute("currentRow", "" + (bwCnt + 1));
							request.setAttribute("totalRecords", "" + size);
						}
					} else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						String bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							rwsMaster.setPmCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pipeline);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
						}
					}
					if (size == bwCnt + 1) {
						session.setAttribute("last", "last");
					} else {
						session.setAttribute("last", null);
					}
					if (size == 0) {
						session.setAttribute("prev", "prev");
					} else {
						session.removeAttribute("prev");
					}
				} catch (Exception e) {
					Debug.println("Exception at nextpump mode:   " + e);
				}
			}
			if (mode.equalsIgnoreCase("setHabCount")) {
				try {
					assetsubCompParams = assetForm.getAssetReservior();
					ArrayList a = (ArrayList) session.getAttribute("assetsubCompParams");
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request.getParameter("assetTypeCode");
					String index = request.getParameter("index");
					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();
					assetsubCompTempParams.add(assetsubCompParams.get((Integer.parseInt(index))));
					assetsubCompParams = assetForm.getAssetReservior();
					assetForm.setMode("addNew");
					mode = "AddHab";
				} catch (Exception e) {
					Debug.println("Exception at setHabCount:   " + e);
				}
			}
			if (mode.equalsIgnoreCase("addNewOandM")) {
				session.setAttribute("costOfAsset", request.getParameter("costOfAsset"));
				Asset_Others asset_others = new Asset_Others();
				asset_others.setAssetCode((String) request.getParameter("assetCode"));
				asset_pumpset.setHabCode((String) request.getParameter("habCode"));
				asset_others.setHabCode((String) request.getParameter("habCode"));
				asset_others.setAssetCost((String) request.getParameter("assetCost"));
				assetsubCompParams.add(asset_others);
				assetForm.setAssetPumpSets(assetsubCompParams);
			}
			if (mode.equalsIgnoreCase("params")) {
				try {
					session.removeAttribute("going to getNextSubComponentCode");
					session.removeAttribute("last");
					session.removeAttribute("prev");
					session.setAttribute("first", "first");
					int bwCnt = 0;
					String bwCount = String.valueOf(bwCnt);
					session.setAttribute("bwCount", bwCount);
					String tempPCode = "", PCode = null, phCode = null;
					int tslno = 0, slno = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if (typeOfAssetCode.equals("05") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_SHP assetSHP;
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SHP");
						assetForm.setAssetSHP(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetSHP = (Asset_SHP) assetsubCompParams.get(i);
								assetsubCompParams.clear();
								assetsubCompParams.add(assetSHP);
								PCode = assetSHP.getShallowHandPumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetForm.setAssetSHP(assetsubCompParams);
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "SH001";
							tempPCode = phCode;
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_SHP());
							assetForm.setAssetSHP(assetsubCompParams);
						}
						session.setAttribute("assetsubCompParams", "SHP");
						return mapping.findForward("ponds");
					}
					if (typeOfAssetCode.equals("06") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_OpenWells assetOpenWells;
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "OpenWells");
						assetForm.setAssetOpenWells(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetOpenWells = (Asset_OpenWells) assetsubCompParams.get(i);
								assetsubCompParams.clear();
								assetsubCompParams.add(assetOpenWells);
								PCode = assetOpenWells.getOpenWellCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetForm.setAssetOpenWells(assetsubCompParams);
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OW001";
							tempPCode = phCode;
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_OpenWells());
							assetForm.setAssetOpenWells(assetsubCompParams);
						}
						session.setAttribute("assetsubCompParams", "OpenWells");
						return mapping.findForward("ponds");
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							session.setAttribute("assetsubCompParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();
							}
						}
						session.setAttribute("assetsubCompParams", "Miscellaneous");
						return mapping.findForward("params");
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							session.setAttribute("assetsubCompParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();
							}
						}
						session.setAttribute("assetsubCompParams", "Chlorination");
						return mapping.findForward("params");
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							session.setAttribute("assetsubCompParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();
							}
						}
						session.setAttribute("assetsubCompParams", "OandM");
						return mapping.findForward("params");
					}
					if (typeOfAssetCode.equals("07") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_Ponds assetPonds;
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ponds");
						assetForm.setAssetPonds(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetPonds = (Asset_Ponds) assetsubCompParams.get(i);
								assetsubCompParams.clear();
								assetsubCompParams.add(assetPonds);
								PCode = assetPonds.getPondCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetForm.setAssetPonds(assetsubCompParams);
							return mapping.findForward("ponds");
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PD001";
							tempPCode = phCode;
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_Ponds());
							assetForm.setAssetPonds(assetsubCompParams);
							return mapping.findForward("ponds");
						}
					}
					if (typeOfAssetCode.equals("08") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_Others assetOthers;
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Others");
						assetForm.setAssetOthers(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetOthers = (Asset_Others) assetsubCompParams.get(i);
								PCode = assetOthers.getGeneralCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
								session.setAttribute("phCode", tempPCode);
							}
							assetForm.setAssetOthers(assetsubCompParams);
							return mapping.findForward("ponds");
						} else {
							Asset_Others asset_others = new Asset_Others();
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OT001";
							tempPCode = phCode;
							session.setAttribute("phCode", tempPCode);
							session.setAttribute("assetCode", request.getParameter("assetCode"));
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_Others());
							assetForm.setAssetOthers(assetsubCompParams);
							asset_others.setGeneralCode(phCode);
							return mapping.findForward("ponds");
						}
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "RawWaterCollectionWell");
						assetForm.setAssetHeadWorks(assetsubCompParams);
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getCollectionWellCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "RW";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SSTank");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getSsTankCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "ST";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("003")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SSFilters");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "SS";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("004")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "RSFilters");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "RS";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("010")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "MicroFilters");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "MS";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("011")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "RoPlants");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "RO";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("005")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Sump");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getSumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "SM";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("006")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "FootpathBridge");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getBridgeCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "FP";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("007")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "PumpHouse");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getPumpHouseCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PH";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("008")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "WatchManQuarter");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWatchManCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "WQ";
							tempPCode = phCode.trim();
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("009")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "ClearWaterCollectionWell");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getCollectionWellCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "CW";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("02") && assetSubCompTypeCode.equals("010")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "MSFilters");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "MS";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ohsr");
						session.setAttribute("assetReserviorOhsr", new ArrayList(assetsubCompParams));
						session.setAttribute("a", "aaaaaaa");
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getOhsrCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OS";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ohbr");
						session.setAttribute("assetReservior", assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getOhbrCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OB";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("003")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Glsr");
						session.setAttribute("assetReservior", assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						session.setAttribute("assetReserviorGlsr", new ArrayList(assetsubCompParams));
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getGlsrCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "GL";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("004")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Glbr");
						session.setAttribute("assetReservior", assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getGlbrCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "GB";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("005")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "BPT");
						session.setAttribute("assetReservior", assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getBptCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "BT";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("006")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						assetForm.setAssetReservior(assetsubCompParams);
						session.setAttribute("assetsubCompParams", "Cisterns");
						session.setAttribute("assetReservior", assetsubCompParams);
						session.setAttribute("assetReserviorCis", new ArrayList(assetsubCompParams));
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getCisCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "CT";
							tempPCode = phCode;
						}
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")) && assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("007")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						assetForm.setAssetReservior(assetsubCompParams);
						session.setAttribute("assetsubCompParams", "SPosts");
						session.setAttribute("assetReservior", assetsubCompParams);
						session.setAttribute("assetReserviorSP", new ArrayList(assetsubCompParams));
						int size = assetsubCompParams.size();
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams.get(i);
								PCode = asset_reservoir.getStandPostCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "SP";
							tempPCode = phCode;
						}
					} else if (typeOfAssetCode.equals("08") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "DONOR-TP");
						session.setAttribute("assetHeadWorks", assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getWtpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						}
					} else {
						session.removeAttribute("assetsubCompParams");
					}
					if (!typeOfAssetCode.equals("07") && tempPCode.length() == 24)
					//	System.out.println("in last");
						tempPCode = getNextSubComponentCode(tempPCode);
					session.setAttribute("phCode", tempPCode);
				} catch (Exception e) {
					Debug.writeln("Exception at params mode " + e);
				}
			}
			if (mode.equalsIgnoreCase("Submit")) {
				try {
					int rowCount = 0;
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request.getParameter("assetTypeCode");
//					Debug.println("assetCode=" + assetTypeCode + "assetCompTypeCode=" + assetCompTypeCode
//							+ "assetSubCompTypeCode=" + assetSubCompTypeCode + "assetTypeCode=" + assetTypeCode);
					if (assetSubComps.size() > 0)
						assetSubComps.clear();
					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_SubComponent asset_subComponent = new Asset_SubComponent(request.getParameter("location"),
								request.getParameter("yearOfDrilling"), (request.getParameter("diameter")),
								request.getParameter("casing"), request.getParameter("status"),
								request.getParameter("genCondition"), request.getParameter("gino"),
								request.getParameter("painted"), request.getParameter("staticWaterLevel"),
								request.getParameter("summerWaterLevel"), request.getParameter("pcond"),
								request.getParameter("dryduring"), request.getParameter("service"),
								request.getParameter("serno"), request.getParameter("serhrs"),
								request.getParameter("repairs"), request.getParameter("platformCondition"),
								request.getParameter("drain"), request.getParameter("drainCondition"),
								request.getParameter("drainsd"), request.getParameter("drainlp"),
								request.getParameter("hygiene"), request.getParameter("avgtime"),
								request.getParameter("pyield"), request.getParameter("pyieldLocal"),
								request.getParameter("period"), request.getParameter("qualityAffected"),
								Double.parseDouble(request.getParameter("flouride")),
								Double.parseDouble(request.getParameter("brakish")),
								Double.parseDouble(request.getParameter("iron")),
								Integer.parseInt(request.getParameter("depth")), request.getParameter("hpCode"),
								request.getParameter("assetCode"), request.getParameter("otherspecify"),
								request.getParameter("pipeLength"));
						assetSubComps.add(asset_subComponent);
						assetForm.setAssetSubComponents(assetSubComps);
						rowCount = RwsMasterData.removeAssetSubComp(getDataSource(request), assetCd, assetCompTypeCode,
								assetSubCompTypeCode, assetTypeCode, opType, assetForm.getAssetSubComponents(),
								"Source");
						mode = "pumpset";
					}
					/*
					 * else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("03") &&
					 * assetSubCompTypeCode.equals("003")) { asset_pipeline = new Asset_PipeLine();
					 * Asset_PipeLine asset_Pipeline = new Asset_PipeLine(
					 * request.getParameter("pmCode"), request.getParameter("assetCode"),
					 * request.getParameter("noOfPipes"), request.getParameter("pmCond"),
					 * request.getParameter("pmRep"), request.getParameter("pmNat"),
					 * request.getParameter("pmAvNo"), request.getParameter("pmScrvNo"),
					 * request.getParameter("pmSvNo"), request.getParameter("pmRvNo"));
					 * assetSubComps.add(asset_Pipeline); assetForm.setAssetPipeLine(assetSubComps);
					 * Debug.println("this in insert"); //String
					 * assetCd=(String)session.getAttribute("assetCd"); rowCount =
					 * RwsMasterData.removeAssetSubComp( getDataSource(request), assetCd,
					 * assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
					 * assetForm.getAssetPipeLine(), "Pipeline"); }
					 */
					// this code for deleting pumping main
					else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("001")) {
						opType = (String) request.getParameter("opType");
						request.getParameter("pmCode");
						assetForm.setAssetPipeLine(assetSubComps);
						rowCount = RwsMasterData.deletePipeLineSubComp(getDataSource(request),
								(String) request.getParameter("pmCode"), typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);
						ArrayList nextSubCompDetails = new ArrayList();
						int totRecords = Integer.parseInt((String) session.getAttribute("totRecords"));
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
									assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode, assetSubCompTypeCode,
									(String) request.getParameter("habCode"), (String) request.getParameter("pmCode"),
									"previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
										assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode,
										assetSubCompTypeCode, (String) request.getParameter("habCode"),
										(String) request.getParameter("pmCode"), "next");
							Debug.println("nextRecord size is " + nextRecord.size());
							assetForm.setAssetPipeLine(nextRecord);

							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() + "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0)).getRowCount() + "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() == 1)
								request.setAttribute("previousNotExists", "true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists", "true");
								request.setAttribute("nextNotExists", "true");

							}
						} else if (totRecords == 1) {
							request.setAttribute("currentRow", "0");
							request.setAttribute("totalRecords", "0");
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("nextNotExists", "true");
							message = "Record Deleted ";
						}

					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("002")) {
						opType = (String) request.getParameter("opType");
						request.getParameter("gravitymain_code");
						assetForm.setAssetPipeLine(assetSubComps);

						rowCount = RwsMasterData.deletePipeLineSubComp(getDataSource(request),
								(String) request.getParameter("gravitymain_code"), typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);
						ArrayList nextSubCompDetails = new ArrayList();
						int totRecords = Integer.parseInt((String) session.getAttribute("totRecords"));
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
									assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode, assetSubCompTypeCode,
									(String) request.getParameter("habCode"),
									(String) request.getParameter("gravitymain_code"), "previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
										assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode,
										assetSubCompTypeCode, (String) request.getParameter("habCode"),
										(String) request.getParameter("gravitymain_code"), "next");
							assetForm.setAssetPipeLine(nextRecord);

							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() + "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0)).getRowCount() + "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() == 1)
								request.setAttribute("previousNotExists", "true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists", "true");
								request.setAttribute("nextNotExists", "true");

							}
						} else if (totRecords == 1) {
							request.setAttribute("currentRow", "0");
							request.setAttribute("totalRecords", "0");
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("nextNotExists", "true");
							message = "Record Deleted ";
						}
					}
					else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("003")) {
						opType = (String) request.getParameter("opType");
						assetForm.setAssetPipeLine(assetSubComps);
						int totRecords = Integer.parseInt((String) session.getAttribute("totRecords"));
						rowCount = RwsMasterData.deletePipeLineSubComp(getDataSource(request),
								(String) request.getParameter("disCode"), typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);
						ArrayList nextSubCompDetails = new ArrayList();
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
									assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode, assetSubCompTypeCode,
									(String) request.getParameter("habCode"), (String) request.getParameter("disCode"),
									"previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData.getAssetNextSubCompParams(getDataSource(request),
										assetForm.getAssetCode(), assetTypeCode, assetCompTypeCode,
										assetSubCompTypeCode, (String) request.getParameter("habCode"),
										(String) request.getParameter("disCode"), "next");
							assetForm.setAssetPipeLine(nextRecord);
							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() + "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0)).getRowCount() + "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0)).getCurrentRow() == 1)
								request.setAttribute("previousNotExists", "true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists", "true");
								request.setAttribute("nextNotExists", "true");
							}
						} else if (totRecords == 1) {
							request.setAttribute("currentRow", "0");
							request.setAttribute("totalRecords", "0");
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("previousNotExists", "true");
							request.setAttribute("nextNotExists", "true");
							message = "Record Deleted ";
						}
					}
					if (rowCount > 0) {
						message = "Record Deleted ";
						String bwCount = (String) session.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						bwCnt = bwCnt + 1;
						int size = assetsubCompParams.size();
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(bwCnt));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
						} else {
							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm.setAssetSubComponents(assetsubCompTempParams);
						}
					} else {
						message = "The Record Cant be Deleted";
					}
					request.setAttribute("message", message);
					if (!typeOfAssetCode.equals("04"))
						return (mapping.findForward("pumpset"));
				} catch (Exception e) {
					Debug.println("Exception in Submit:" + e.getMessage());
				}
			}

			if (mode.equalsIgnoreCase("addSubCompPump")) {
				String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				try {
					int rowCount = 0;
					assetsubCompTempParams.clear();
					String assetCd = request.getParameter("assetCode");
					request.setAttribute("assetCode", assetCd);
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request.getParameter("assetTypeCode");
					assetsubCompTempParams.clear();
					assetsubCompParams.clear();
					assetsubCompParams = assetForm.getAssetPumpSets();
					String[] addIds = request.getParameterValues("remove");
					if (addIds != null && addIds.length != 0) {
						for (int p = 0; p < addIds.length; p++) {
							assetsubCompTempParams.add(assetsubCompParams.get(Integer.parseInt(addIds[p])));
						}
						if (!assetCompTypeCode.equals("06") && !assetSubCompTypeCode.equals("001"))
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetPumpSets(), "Others");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPumpSets(assetsubCompParams);
					}
					if (typeOfAssetCode.equals("07") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_Ponds asset_ponds = new Asset_Ponds();
						asset_ponds.setAssetCode(request.getParameter("assetCode"));
						asset_ponds.setHabCode(request.getParameter("habCode"));
						asset_ponds.setHabitation(request.getParameter("habitation"));
						asset_ponds.setPondCode(request.getParameter("pondCode"));
						asset_ponds.setName(request.getParameter("name"));
						asset_ponds.setLocation(request.getParameter("location"));
						asset_ponds.setAreaSize(request.getParameter("areaSize"));
						asset_ponds.setVolumeOfStorage(request.getParameter("volumeOfStorage"));
						asset_ponds.setHygeinity(request.getParameter("hygeinity"));
						asset_ponds.setPurpose(request.getParameter("purpose"));
						asset_ponds.setFedBy(request.getParameter("fedBy"));
						asset_ponds.setFedName(request.getParameter("fedName"));
						asset_ponds.setFedOthersName(request.getParameter("fedOthersName"));
						asset_ponds.setWaterQuality(request.getParameter("waterQuality"));
						asset_ponds.setFloride(request.getParameter("floride"));
						asset_ponds.setBrakish(request.getParameter("brakish"));
						asset_ponds.setIron(request.getParameter("iron"));
						asset_ponds.setOthersType(request.getParameter("othersType"));
						asset_ponds.setOthers(request.getParameter("others"));
						assetSubComps.add(asset_ponds);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps, "Ponds");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_ponds.setAssetCode(assetCd);
							assetSubComps.add(asset_ponds);
							assetForm.setAssetPonds(assetSubComps);
						}
						mode = "ponds";
					}
					if (typeOfAssetCode.equals("05") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_SHP asset_SHP = new Asset_SHP();
						asset_SHP.setAssetCode(request.getParameter("assetCode"));
						asset_SHP.setHabCode(request.getParameter("habCode"));
						asset_SHP.setHabitation(request.getParameter("habitation"));
						asset_SHP.setShallowHandPumpCode(request.getParameter("shallowHandPumpCode"));
						asset_SHP.setLocation(request.getParameter("location"));
						asset_SHP.setDiameter(request.getParameter("diameter"));
						asset_SHP.setDepth(request.getParameter("depth"));
						asset_SHP.setHygiene(request.getParameter("hygiene"));
						asset_SHP.setAvgNoOfHoursWorkingPerDay(request.getParameter("avgNoOfHoursWorkingPerDay"));
						asset_SHP.setAvgTimeToFill(request.getParameter("avgTimeToFill"));
						asset_SHP.setYeild(request.getParameter("yeild"));
						asset_SHP.setWaterQuality(request.getParameter("waterQuality"));
						asset_SHP.setFloride(request.getParameter("floride"));
						asset_SHP.setBrakish(request.getParameter("brakish"));
						asset_SHP.setIron(request.getParameter("iron"));
						asset_SHP.setOthersType(request.getParameter("othersType"));
						asset_SHP.setOthers(request.getParameter("others"));
						asset_SHP.setLatitude(request.getParameter("latitude"));
						asset_SHP.setLongitude(request.getParameter("longitude"));
						asset_SHP.setElevation(request.getParameter("elevation"));
						asset_SHP.setWaypoint(request.getParameter("waypoint"));
						assetSubComps.add(asset_SHP);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps, "Ponds");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_SHP.setAssetCode(assetCd);
							assetSubComps.add(asset_SHP);
							assetForm.setAssetSHP(assetSubComps);
						}
						mode = "ponds";
					}
					if (typeOfAssetCode.equals("06") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_OpenWells asset_openWells = new Asset_OpenWells();
						asset_openWells.setAssetCode(request.getParameter("assetCode"));
						asset_openWells.setHabCode(request.getParameter("habCode"));
						asset_openWells.setHabitation(request.getParameter("habitation"));
						asset_openWells.setOpenWellCode(request.getParameter("openWellCode"));
						asset_openWells.setLocation(request.getParameter("location"));
						asset_openWells.setDiameter(request.getParameter("diameter"));
						asset_openWells.setDepth(request.getParameter("depth"));
						asset_openWells.setNormalWaterLevel(request.getParameter("normalWaterLevel"));
						asset_openWells.setMinimumWaterLevel(request.getParameter("minimumWaterLevel"));
						asset_openWells.setMaximumWaterLevel(request.getParameter("maximumWaterLevel"));
						asset_openWells.setPlatformExists(request.getParameter("platformExists"));
						asset_openWells.setPlatformCondition(request.getParameter("platformCondition"));
						asset_openWells.setPurpose(request.getParameter("purpose"));
						asset_openWells.setWaterQuality(request.getParameter("waterQuality"));
						asset_openWells.setFloride(request.getParameter("floride"));
						asset_openWells.setBrakish(request.getParameter("brakish"));
						asset_openWells.setIron(request.getParameter("iron"));
						asset_openWells.setOthers(request.getParameter("others"));
						asset_openWells.setOthersType(request.getParameter("othersType"));
						asset_openWells.setLatitude(request.getParameter("latitude"));
						asset_openWells.setLongitude(request.getParameter("longitude"));
						asset_openWells.setElevation(request.getParameter("elevation"));
						asset_openWells.setWaypoint(request.getParameter("waypoint"));
						assetSubComps.add(asset_openWells);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps, "SHP");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_openWells.setAssetCode(assetCd);
							assetSubComps.add(asset_openWells);
							assetForm.setAssetOpenWells(assetSubComps);
						} else {
							assetSubComps.clear();
							assetSubComps.add(asset_openWells);
							assetForm.setAssetOpenWells(assetSubComps);
						}
						mode = "ponds";
					}
					if (typeOfAssetCode.equals("08") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_Others asset_others = new Asset_Others();
						asset_others.setAssetCode(request.getParameter("assetCode"));
						asset_others.setHabCode(request.getParameter("habCode"));
						asset_others.setGeneralCode(request.getParameter("generalCode"));
						asset_others.setLocation(request.getParameter("location"));
						asset_others.setComponentName(request.getParameter("componentName"));
						asset_others.setRemarks(request.getParameter("remarks"));
						asset_others.setSpecialAssetType(request.getParameter("specialAssetType"));
						asset_others.setYield(request.getParameter("yield"));
						asset_others.setCollectionTank(request.getParameter("collectionTank"));
						asset_others.setCollectionTankCapacity(request.getParameter("collectionTankCapacity"));
						asset_others.setLatitude(request.getParameter("latitude"));
						asset_others.setLongitude(request.getParameter("longitude"));
						asset_others.setElevation(request.getParameter("elevation"));
						asset_others.setWayPoint(request.getParameter("wayPoint"));
						asset_others.setStatus(request.getParameter("status"));
						assetSubComps.add(asset_others);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps,
								"Others");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_others.setAssetCode(assetCd);
							assetSubComps.add(asset_others);
							assetForm.setAssetOthers(assetSubComps);
						}
						mode = "ponds";
					}

					if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						asset_subcomponent = new Asset_SubComponent();
						asset_subcomponent.setLocation(request.getParameter("location"));
						asset_subcomponent.setHabitation(request.getParameter("habitation"));
						asset_subcomponent.setDiameter(request.getParameter("diameter"));
						asset_subcomponent.setCasing(request.getParameter("casing"));
						asset_subcomponent.setGenCondition(request.getParameter("genCondition"));
						asset_subcomponent.setPipeLength(request.getParameter("pipeLength"));
						asset_subcomponent.setGino(request.getParameter("gino"));
						asset_subcomponent.setPainted(request.getParameter("painted"));
						asset_subcomponent.setStaticWaterLevel(request.getParameter("staticWaterLevel"));
						asset_subcomponent.setSummerWaterLevel(request.getParameter("summerWaterLevel"));
						asset_subcomponent.setPcond(request.getParameter("pcond"));
						asset_subcomponent.setSerno(request.getParameter("serno"));
						asset_subcomponent.setSerhrs(request.getParameter("serhrs"));
						asset_subcomponent.setRepairs(request.getParameter("repairs"));
						asset_subcomponent.setPlatformCondition(request.getParameter("platformCondition"));
						asset_subcomponent.setDrain(request.getParameter("drain"));
						asset_subcomponent.setDrainCondition(request.getParameter("drainCondition"));
						asset_subcomponent.setDrainsd(request.getParameter("drainsd"));
						asset_subcomponent.setDrainlp(request.getParameter("drainlp"));
						asset_subcomponent.setHygiene(request.getParameter("hygiene"));
						asset_subcomponent.setAvgtime(request.getParameter("avgtime"));
						asset_subcomponent.setPyield(request.getParameter("pyield"));
						asset_subcomponent.setPyieldLocal(request.getParameter("pyieldLocal"));
						asset_subcomponent.setPeriod(request.getParameter("period"));
						asset_subcomponent.setQualityAffected(request.getParameter("qualityAffected"));
						if (request.getParameter("flouride") != null && !request.getParameter("flouride").equals(""))
							asset_subcomponent.setFlouride(Double.parseDouble(request.getParameter("flouride")));
						if (request.getParameter("brakish") != null && !request.getParameter("brakish").equals(""))
							asset_subcomponent.setBrakish(Double.parseDouble(request.getParameter("brakish")));
						if (request.getParameter("iron") != null && !request.getParameter("iron").equals(""))
							asset_subcomponent.setIron(Double.parseDouble(request.getParameter("iron")));
						if (request.getParameter("depth") != null && !request.getParameter("depth").equals(""))
							asset_subcomponent.setDepth(Integer.parseInt(request.getParameter("depth")));
						asset_subcomponent.setHpCode(request.getParameter("hpCode"));
						asset_subcomponent.setAssetCode(request.getParameter("assetCode"));
						asset_subcomponent.setOtherspecify(request.getParameter("otherspecify"));
						asset_subcomponent.setOthers(request.getParameter("others"));
						asset_subcomponent.setOthersType(request.getParameter("othersType"));
						asset_subcomponent.setLatitude(request.getParameter("latitude"));
						asset_subcomponent.setLongitude(request.getParameter("longitude"));
						asset_subcomponent.setElevation(request.getParameter("elevation"));
						asset_subcomponent.setWaypoint(request.getParameter("waypoint"));
						assetSubComps.add(asset_subcomponent);
						assetForm.setAssetSubComponents(assetSubComps);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetSubComponents(), "Source");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("001")) {
						opType = "Modify";
						assetSubComps.clear();
						asset_pipeline = new Asset_PipeLine();
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine(request.getParameter("pmCode"),
								request.getParameter("assetCode"), request.getParameter("noOfPipes"),
								request.getParameter("pmCond"), request.getParameter("pmRep"),
								request.getParameter("pmNat"), request.getParameter("pmAvNo"),
								request.getParameter("pmScrvNo"), request.getParameter("pmSvNo"),
								request.getParameter("pmRvNo"));
						asset_Pipeline.setHabCode(request.getParameter("habCode"));
						asset_Pipeline.setPmZeroVelocityValve(request.getParameter("pmZeroVelocityValve"));
						asset_Pipeline.setPmAirCusionValve(request.getParameter("pmAirCusionValve"));
						asset_Pipeline.setPmNonReturnValve(request.getParameter("pmNonReturnValve"));
						asset_Pipeline.setPmLocation(request.getParameter("pmLocation"));
						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps,
								"Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams", "PwsPumpingMain");
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("002")) {
						opType = "Modify";
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine();
						asset_Pipeline.setGravitymain_code((String) request.getParameter("gravitymain_code"));
						asset_Pipeline.setHabCode(request.getParameter("habCode"));
						asset_Pipeline.setLengths((String) request.getParameter("lengths"));
						asset_Pipeline.setAirvalve_no((String) request.getParameter("airvalve_no"));
						asset_Pipeline.setScourevalve((String) request.getParameter("scourevalve"));
						asset_Pipeline.setReflexvalve((String) request.getParameter("reflexvalve"));
						asset_Pipeline.setSluicevalve((String) request.getParameter("sluicevalve"));
						asset_Pipeline.setZeroVelocityValve((String) request.getParameter("zeroVelocityValve"));
						asset_Pipeline.setAirCushionValve((String) request.getParameter("airCushionValve"));
						asset_Pipeline.setNonReturnValve((String) request.getParameter("nonReturnValve"));
						asset_Pipeline.setGravitymain_location((String) request.getParameter("gravitymain_location"));
						asset_Pipeline.setMet_type((String) request.getParameter("met_type"));
						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps,
								"Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams", "GravityMain");
					}
					else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("003")) {
						opType = "Modify";
						asset_pipeline = new Asset_PipeLine();
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine();
						asset_Pipeline.setHabCode(request.getParameter("habCode"));
						asset_Pipeline.setDisCode(request.getParameter("disCode"));
						asset_Pipeline.setDisHabCode(request.getParameter("disHabCode"));
						asset_Pipeline.setDisLocation(request.getParameter("disLocation"));
						asset_Pipeline.setDisTotalLengthNeeded(request.getParameter("disTotalLengthNeeded"));
						asset_Pipeline.setDisTotalLengthProvided(request.getParameter("disTotalLengthProvided"));
						asset_Pipeline.setDisFullVillagesCovered(request.getParameter("disFullVillagesCovered"));
						asset_Pipeline.setDisBalanceNeeded(request.getParameter("disBalanceNeeded"));
						asset_Pipeline.setDisNoOfAirValves(request.getParameter("disNoOfAirValves"));
						asset_Pipeline.setDisNoOfSluiceValves(request.getParameter("disNoOfSluiceValves"));
						asset_Pipeline.setDisNoOfStandPosts(request.getParameter("disNoOfStandPosts"));
						asset_Pipeline.setDisNoOfScourValves(request.getParameter("disNoOfScourValves"));
						asset_Pipeline.setDisNoOfPrivateHouseConnections(
								request.getParameter("disNoOfPrivateHouseConnections"));
						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetPipeLine(), "Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams", "Distribution");
					}
					else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("06") && assetSubCompTypeCode.equals("001")) {
						assetSubComps.clear();
						asset_pumpset.setAssetCode(RwsMasterData.format((String) request.getParameter("assetCode")));
						asset_pumpset.setPumpCode(RwsMasterData.format((String) request.getParameter("pumpCode")));
						asset_pumpset
								.setPumpLocation(RwsMasterData.format((String) request.getParameter("pumpLocation")));
						asset_pumpset.setPumpMake(RwsMasterData.format((String) request.getParameter("pumpMake")));
						asset_pumpset.setPumpType(RwsMasterData.format((String) request.getParameter("pumpType")));
						asset_pumpset
								.setPumpCapacity(RwsMasterData.format((String) request.getParameter("pumpCapacity")));
						asset_pumpset.setPumpYearOfCommissioning(
								RwsMasterData.format((String) request.getParameter("pumpYearOfCommissioning")));
						asset_pumpset.setPumpHoursRunningPerDay(
								RwsMasterData.format((String) request.getParameter("pumpHoursRunningPerDay")));
						asset_pumpset.setPumpDesignedHead(
								RwsMasterData.format((String) request.getParameter("pumpDesignedHead")));
						asset_pumpset.setPumpDesignedLpm(
								RwsMasterData.format((String) request.getParameter("pumpDesignedLpm")));
						asset_pumpset.setPumpControlPanel(
								RwsMasterData.format((String) request.getParameter("pumpControlPanel")));
						asset_pumpset.setPumpHoursOfPowerAvailability(
								RwsMasterData.format((String) request.getParameter("pumpHoursOfPowerAvailability")));
						asset_pumpset.setPumpLowVoltageProblems(
								RwsMasterData.format((String) request.getParameter("pumpLowVoltageProblems")));
						asset_pumpset.setPumpFeasiblityOfGettingUrbanLine(RwsMasterData
								.format((String) request.getParameter("pumpFeasiblityOfGettingUrbanLine")));
						asset_pumpset.setPumpAppCostOfUrbanFeeder(
								RwsMasterData.format((String) request.getParameter("pumpAppCostOfUrbanFeeder")));
						asset_pumpset.setPumpDistanceFromWhereUrbanLineCanBeHad(RwsMasterData
								.format((String) request.getParameter("pumpDistanceFromWhereUrbanLineCanBeHad")));
						asset_pumpset.setPumpLowVoltabeProblems(
								RwsMasterData.format((String) request.getParameter("pumpLowVoltabeProblems")));
						asset_pumpset
								.setPumpRemarks(RwsMasterData.format((String) request.getParameter("pumpRemarks")));
						asset_pumpset.setPumpSuggestions(
								RwsMasterData.format((String) request.getParameter("pumpSuggestions")));
						asset_pumpset.setGeneratorExisting(
								RwsMasterData.format((String) request.getParameter("generatorExisting")));
						asset_pumpset.setGeneratorCapacity(
								RwsMasterData.format((String) request.getParameter("generatorCapacity")));
						asset_pumpset.setGeneratorWorking(
								RwsMasterData.format((String) request.getParameter("generatorWorking")));
						asset_pumpset.setHabCode(RwsMasterData.format((String) request.getParameter("habCode")));
						asset_pumpset.setPumpFeeder(RwsMasterData.format((String) request.getParameter("pumpFeeder")));
						asset_pumpset.setPumpUsage(RwsMasterData.format((String) request.getParameter("pumpUsage")));
						asset_pumpset.setLatitude(RwsMasterData.format((String) request.getParameter("latitude")));
						asset_pumpset.setLongitude(RwsMasterData.format((String) request.getParameter("longitude")));
						asset_pumpset.setElevation(RwsMasterData.format((String) request.getParameter("elevation")));
						asset_pumpset.setWaypoint(RwsMasterData.format((String) request.getParameter("waypoint")));
						assetSubComps.add(asset_pumpset);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetSubComps,
								"pumpset");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPumpSets(assetSubComps);
						mode = "pumpset";
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09"))
							&& (assetCompTypeCode.equals("02") || assetCompTypeCode.equals("03")
									|| assetCompTypeCode.equals("04"))) {
						message = daoMessage.getMessage();
					} else if (rowCount > 0) {
						message = "Record Saved Successfully";
					} else {
						message = "The Record Cant be inserted ";
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("Error in addResOHSR :" + e);
				}
			    }
			}
			if (mode.equalsIgnoreCase("pumpset")) {
				try {
					session.removeAttribute("phCode");
					int bwCnt = 0;
					String bwCount = String.valueOf(bwCnt);
					session.setAttribute("bwCount", bwCount);
					String tempPCode = "", PCode = null, phCode = null;
					int tslno = 0, slno = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")) && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("003")) {
						assetForm.setAssetPumpSets(new ArrayList());
						assetsubCompParams.clear();
						assetForm.setAssetPumpSets(assetsubCompParams);
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");
						if (size > 0) {
							assetForm.setAssetPumpSets(assetsubCompParams);
							{
								asset_pumpset = (Asset_Pumpset) assetsubCompParams.get(0);
								PCode = asset_pumpset.getPumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PS";
							tempPCode = phCode;
							assetsubCompParams.clear();
							assetForm.setAssetPumpSets(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (assetSubCompTypeCode.equals("003"))
							session.setAttribute("assetsubCompParams", "Pumpsets");
					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("06") && assetSubCompTypeCode.equals("001")) {
						assetForm.setAssetPumpSets(new ArrayList());
						assetsubCompParams.clear();
						assetForm.setAssetPumpSets(assetsubCompParams);
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetForm.setAssetPumpSets(assetsubCompParams);
							{
								asset_pumpset = (Asset_Pumpset) assetsubCompParams.get(0);
								PCode = asset_pumpset.getPumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PS";
							tempPCode = phCode;
							assetsubCompParams.clear();
							assetForm.setAssetPumpSets(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (assetSubCompTypeCode.equals("001"))
							session.setAttribute("assetsubCompParams", "Pumpsets");

					}

					else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetPipeLine", assetsubCompParams);
						session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
						int size = assetsubCompParams.size();
						assetsubCompTempParams.clear();

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							assetForm.setAssetPipeLine(assetsubCompTempParams);

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getPmCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							request.setAttribute("previousNotExists", "true");
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PM";
							tempPCode = phCode;
							assetForm.setAssetPipeLine(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (assetSubCompTypeCode.equals("001"))
							session.setAttribute("assetsubCompParams", "CpwsPumpingMain");
						else if (assetSubCompTypeCode.equals("003"))
							session.setAttribute("assetsubCompParams", "PwsPumpingMain");

					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetPipeLine", assetsubCompParams);
						int size = assetsubCompParams.size();
						assetsubCompTempParams.clear();
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");
						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getGravitymain_code();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							request.setAttribute("previousNotExists", "true");
						}
						else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "GM";
							tempPCode = phCode;
							asset_pipeline = new Asset_PipeLine();
							assetsubCompParams.add(asset_pipeline);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						session.setAttribute("assetsubCompParams", "GravityMain");
						assetForm.setAssetPipeLine(assetsubCompTempParams);

					} else if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode.equals("09"))
							&& assetCompTypeCode.equals("03") && assetSubCompTypeCode.equals("003")) {
						
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("disHabCode"), request.getParameter("disCode"));
						session.setAttribute("assetPipeLine", assetsubCompParams);
						int size = assetsubCompParams.size();
						assetsubCompTempParams.clear();

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_pipeline = (Asset_PipeLine) assetsubCompParams.get(i);
								PCode = asset_pipeline.getDisCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							request.setAttribute("previousNotExists", "true");
						}
						else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "DT";
							tempPCode = phCode;
							asset_pipeline = new Asset_PipeLine();
							assetsubCompParams.add(asset_pipeline);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						session.setAttribute("assetsubCompParams", "Distribution");
						assetForm.setAssetPipeLine(assetsubCompTempParams);

					} else if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "PwsPumpHouse");
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getPumpHouseCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PH";
							tempPCode = phCode;
						}
					} else if (typeOfAssetCode.equals("04") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request),
								request.getParameter("assetCode"), request.getParameter("assetTypeCode"),
								request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
								request.getParameter("habCode"), request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "HandPumps");

						int size = assetsubCompParams.size();
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							session.setAttribute("assetsubCompPWSParams", assetsubCompParams);
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams.get(0));
							assetForm.setAssetSubComponents(assetsubCompTempParams);
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsMaster) assetsubCompParams.get(i);
								PCode = rwsMaster.getHpCode();
								phCode = PCode;

								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
						} else {
							rwsMaster = new RwsMaster();
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							String location = request.getParameter("location");
							phCode = PCode + Scode + "HP";
							tempPCode = phCode;
							asset_subcomponent = new Asset_SubComponent();
							SubCompMetaData subCompMetaData = new SubCompMetaData();
							String nextCode = subCompMetaData.getNextSchemeCode(getDataSource(request),
									request.getParameter("assetTypeCode"), request.getParameter("assetCompTypeCode"),
									request.getParameter("assetSubCompTypeCode"),
									(String) session.getAttribute("shortSchemeCodeInAssetEntryForm"),
									(String) session.getAttribute("habCodeInAssetEntryForm"),
									request.getParameter(assetCode));
							rwsMaster.setHpCode(nextCode);
							rwsMaster.setLocation(location);
							assetsubCompParams.add(rwsMaster);
							assetForm.setAssetSubComponents(assetsubCompParams);
						}
						if (size == 1) {
									request.setAttribute("nextNotExists", "true");
									request.setAttribute("previousNotExists", "true");
								}
							}
					else {
						session.removeAttribute("assetsubCompParams");
					}
					if (tempPCode.length() == 21)
						tempPCode = tempPCode + "001";
					else
						tempPCode = getNextSubComponentCode(tempPCode);
					session.setAttribute("phCode", tempPCode);
				} catch (Exception e) {
					Debug.println("Exception at pumpset mode is  " + e);
				}
				mode = "pumpset";
			}

			if (mode.equalsIgnoreCase("view")) {
				try {
					assets = RwsMasterData.getAssets(circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode,
							request.getParameter("mandal"), request.getParameter("pcode"),
							request.getParameter("vcode"), request.getParameter("habCode"),
							request.getParameter("assetTypeCode"), getDataSource(request));

					request.setAttribute("circleOfficeCode", circleOfficeCode);
					request.setAttribute("divisionOfficeCode", divisionOfficeCode);
					request.setAttribute("subdivisionOfficeCode", subdivisionOfficeCode);
					request.setAttribute("habCode", request.getParameter("habCode"));
					session.setAttribute("assets", (ArrayList) assets.get(0));
					session.setAttribute("assets1", (ArrayList) assets.get(0));
					session.setAttribute("assets2", (ArrayList) assets.get(1));
					session.setAttribute("assets3", (ArrayList) assets.get(2));
					session.setAttribute("assets4", (ArrayList) assets.get(3));
					session.setAttribute("assets5", (ArrayList) assets.get(4));
					session.setAttribute("assets6", (ArrayList) assets.get(5));
					session.setAttribute("assets7", (ArrayList) assets.get(6));
					session.setAttribute("assets8", (ArrayList) assets.get(7));
					session.setAttribute("assets9", (ArrayList) assets.get(8));
				} catch (Exception e) {
					Debug.println("Exception  in view mode : " + e.getMessage());
				}
				if (request.getParameter("assetTypeCode").equals("01")
						|| request.getParameter("assetTypeCode").equals("02")
						|| request.getParameter("assetTypeCode").equals("03")
						|| request.getParameter("assetTypeCode").equals("09")) {
					return mapping.findForward("View1");
				} else
					return mapping.findForward("View");
			}

			if (mode.equalsIgnoreCase("ViewUpdate")) {
				try {

					assets = RwsMasterData.getAssets(circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode,
							request.getParameter("mandal"), request.getParameter("pcode"),
							request.getParameter("vcode"), request.getParameter("habCode"),
							request.getParameter("assetTypeCode"), getDataSource(request));
					request.setAttribute("circleOfficeCode", circleOfficeCode);
					request.setAttribute("divisionOfficeCode", divisionOfficeCode);
					request.setAttribute("subdivisionOfficeCode", subdivisionOfficeCode);
					request.setAttribute("habCode", request.getParameter("habCode"));
					session.setAttribute("assets", (ArrayList) assets.get(0));
					session.setAttribute("assets1", (ArrayList) assets.get(0));
					session.setAttribute("assets2", (ArrayList) assets.get(1));
					session.setAttribute("assets3", (ArrayList) assets.get(2));
					session.setAttribute("assets4", (ArrayList) assets.get(3));
					session.setAttribute("assets5", (ArrayList) assets.get(4));
					session.setAttribute("assets6", (ArrayList) assets.get(5));
					session.setAttribute("assets7", (ArrayList) assets.get(6));
					session.setAttribute("assets8", (ArrayList) assets.get(7));
					session.setAttribute("assets9", (ArrayList) assets.get(8));
					ArrayList programs = RwsMasterData.getProgrammes(getDataSource(request));
					session.setAttribute("programs", programs);
				} catch (Exception e) {
					Debug.println("error in view" + e.getMessage());
				}
				return mapping.findForward(mode);
			}
			if (mode.equalsIgnoreCase("viewUpdateProgram")) {
				String checking[] = null;
				int count = 0;
				try {
					int recno = 0;
					int delcnt = 0;
					recno = Integer.parseInt(request.getParameter("resultCount"));
					checking = new String[recno + 1];
					checking[0] = " ";
					recno = Integer.parseInt(request.getParameter("resultCount"));
					for (int i = 1; i < recno + 1; i++) {
						if (request.getParameter("program" + i) != null) {
							checking[i] = "1";
							if ((request.getParameter("check[" + i + "]") != null
									&& !request.getParameter("check[" + i + "]").equals(""))) {
								String storedToken = (String) session.getAttribute("csrfToken");
								String token = request.getParameter("token");
								if (storedToken.equals(token)) {
									count += RwsMasterData.updateAssetProgram(request.getParameter("check[" + i + "]"),
											request.getParameter("program" + i));
								}
							}
						}
					}
				} catch (Exception e) {
					Debug.println("Exception in view" + e);
				}
				String msgg = "";
				if (count > 0)
					msgg = count + " Asset(s) Updated Successfully";
				else
					msgg = "Failed to Update";
				request.setAttribute("message", msgg);
				assets = RwsMasterData.getAssets(request.getParameter("circleOfficeCode"),
						request.getParameter("divisionOfficeCode"), request.getParameter("subdivisionOfficeCode"),
						request.getParameter("mandal"), request.getParameter("pcode"), request.getParameter("vcode"),
						request.getParameter("habCode"), request.getParameter("assetTypeCode"), getDataSource(request));
				session.setAttribute("circleOfficeCode", request.getParameter("circleOfficeCode"));
				session.setAttribute("assets", (ArrayList) assets.get(0));
				session.setAttribute("assets1", (ArrayList) assets.get(0));
				session.setAttribute("assets2", (ArrayList) assets.get(1));
				session.setAttribute("assets3", (ArrayList) assets.get(2));
				session.setAttribute("assets4", (ArrayList) assets.get(3));
				session.setAttribute("assets5", (ArrayList) assets.get(4));
				session.setAttribute("assets6", (ArrayList) assets.get(5));
				session.setAttribute("assets7", (ArrayList) assets.get(6));
				session.setAttribute("assets8", (ArrayList) assets.get(7));
				session.setAttribute("assets9", (ArrayList) assets.get(8));
				ArrayList programs = RwsMasterData.getProgrammes(getDataSource(request));
				session.setAttribute("programs", programs);
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("checks")) {
				RwsMaster rm = null;
				try {
					checkedHabs = (ArrayList) assetForm.getAssetHabs();
					tempSelectedHabs = new ArrayList();
					tempSelectedHabs = (ArrayList) session.getAttribute("tempSelectedHabs");
					for (int i = 0; i < tempSelectedHabs.size(); i++) {
						rm = (RwsMaster) tempSelectedHabs.get(i);
					}

					ArrayList removeTempSelectedHabs = removeTempSelectedHabs(tempSelectedHabs, assetForm.getMandal());

					for (int i = 0; i < checkedHabs.size(); i++) {
						panchRaj = (PanchRaj) checkedHabs.get(i);
						if (panchRaj.getHabitation() != null) {
							if (panchRaj.getHabitation().equalsIgnoreCase("on")) {
								rm = new RwsMaster();
								rm.setHabCode(panchRaj.getHabCode());
								removeTempSelectedHabs.add(rm);
							}
						}
					}
					for (int i = 0; i < removeTempSelectedHabs.size(); i++) {
						rm = (RwsMaster) removeTempSelectedHabs.get(i);
					}
					session.setAttribute("habs", checkedHabs);
					session.setAttribute("tempSelectedHabs", removeTempSelectedHabs);
					session.setAttribute("assetHabs", removeTempSelectedHabs);
				} catch (Exception e) {
					Debug.println("the error in checks" + e);
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("addSubCompPipeType")) {
				try {
					int rowCount = 0;
					String code = request.getParameter("code");
					assetsubCompTempParams.clear();
					assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					String[] addIds = request.getParameterValues("remove");
					if (addIds != null && addIds.length != 0) {
						for (int p = 0; p < addIds.length; p++) {
							assetsubCompTempParams.add(assetsubCompParams.get((Integer.parseInt(addIds[p]))));
						}
					}
					assetForm.setAssetPipeLine(assetsubCompTempParams);
					rwsMaster = RwsMasterData.insertAssetSubCompPipeTypeParams(getDataSource(request),
							(String) session.getAttribute("code"), assetForm.getAssetPipeLine());
					assetForm.setAssetPipeLine(assetsubCompParams);
					if (rwsMaster.getMessage() != null && !rwsMaster.getMessage().equals("")) {
						if (Integer.parseInt(rwsMaster.getNoOfRecords()) > 0
								&& rwsMaster.getMessage().equals("inserted"))
							message = "records Inserted Successfully";
						else if (Integer.parseInt(rwsMaster.getNoOfRecords()) > 0
								&& rwsMaster.getMessage().equals("updated"))
							message = "records Updated Successfully";
					}

					request.setAttribute("message", message);
					assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					assetsubCompParams = fillPipeLine(assetsubCompParams, getDataSource(request));
					assetForm.setAssetPipeLine(assetsubCompParams);
				} catch (Exception e) {
					Debug.println("Exception :" + e);
				}
				return mapping.findForward("gotoPickpipematMode");

			}

			if (mode.equalsIgnoreCase("addSubComp")) {

				try {
					int rowCount = 0;
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request.getParameter("assetTypeCode");
					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();
					else if (assetTypeCode.equals("08") && assetCompTypeCode.equals("01"))
						assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
					String[] addIds = request.getParameterValues("remove");

					if (addIds != null && addIds.length != 0) {
						for (int p = 0; p < addIds.length; p++) {
							assetsubCompTempParams.add(assetsubCompParams.get((Integer.parseInt(addIds[p]))));
						}
					}
					if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")
							|| assetTypeCode.equals("09")) && assetCompTypeCode.equals("02")) {
						opType = "Modify";
						assetForm.setAssetHeadWorks(assetsubCompTempParams);
						Asset_HeadWorks assetHw = (Asset_HeadWorks) assetsubCompTempParams.get(0);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetHeadWorks(), "Headworks");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetHeadWorks(assetsubCompParams);
					}
					if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")
							|| assetTypeCode.equals("09")) && assetCompTypeCode.equals("03")) {
						opType = "Modify";
						assetForm.setAssetPipeLine(assetsubCompTempParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetPipeLine(), "Pipeline");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPipeLine(assetsubCompParams);
						return mapping.findForward("addSubCompPump");

					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03")
							|| assetTypeCode.equals("09")) && assetCompTypeCode.equals("04")) { // (assetSubCompTypeCode.equals("001")
																								// ||
																								// assetSubCompTypeCode.equals("002")
																								// ||
																								// assetSubCompTypeCode.equals("003")))
																								// {
						opType = "Modify";
						assetForm.setAssetReservior(assetsubCompParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType, assetsubCompTempParams,
								"Reservoirs");
						rowCount = daoMessage.getRowCount();


						if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
								|| typeOfAssetCode.equals("03") || assetTypeCode.equals("09"))
								&& assetCompTypeCode.equals("04") && (assetSubCompTypeCode.equals("001")
										|| assetSubCompTypeCode.equals("003") || assetSubCompTypeCode.equals("006"))) {
							assetsubCompParams = RwsMasterData.getAssetSubCompParams(getDataSource(request), assetCd,
									assetTypeCode, assetCompTypeCode, assetSubCompTypeCode,
									request.getParameter("habCode"), request.getParameter("pumpCode"));
						}
						assetForm.setAssetReservior(assetsubCompParams);
					}
					if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")
							|| assetTypeCode.equals("09") || assetTypeCode.equals("05"))
							&& assetCompTypeCode.equals("05")) {
						opType = "Modify";
						assetForm.setAssetPumpSets(assetsubCompTempParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetPumpSets(), "Pumpsets");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPumpSets(assetsubCompParams);

					}

					if (typeOfAssetCode.equals("01") && assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompTempParams.clear();
						asset_subcomponent = new Asset_SubComponent();
						Asset_SubComponent asset_subComponent = new Asset_SubComponent(request.getParameter("popDes"),
								request.getParameter("source"), request.getParameter("sourceQuality"),
								request.getParameter("sourceYield"), request.getParameter("sourceDepend"),
								request.getParameter("sourceDepth"), request.getParameter("sourceDiameter"),
								request.getParameter("sourceCondition"), request.getParameter("sourceSwl"),
								request.getParameter("sourceNwl"), request.getParameter("phSize"),
								request.getParameter("phCondition"), request.getParameter("phType"),
								request.getParameter("pumpName"), request.getParameter("pumpCapacity"),
								request.getParameter("pumpType"), request.getParameter("purYear"),
								request.getParameter("hrRun"), request.getParameter("hrSin"),
								request.getParameter("hrMs"), request.getParameter("staExe"),
								request.getParameter("pumpDutyLpm"), request.getParameter("pumpDutyHead"),
								request.getParameter("ifNss"), request.getParameter("pumpNo"),
								request.getParameter("standByPumpCapacity"), request.getParameter("standByPumpNo"),
								request.getParameter("pmpCode"));
						assetSubComps.add(asset_subComponent);
						assetForm.setAssetSubComponents(assetSubComps);
						DAOMessage daoMessege = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetSubComponents(), "Source");
						rowCount = daoMessage.getRowCount();
					}
					if (assetTypeCode.equals("08") && assetCompTypeCode.equals("01")) {
						opType = "Modify";
						assetForm.setAssetHeadWorks(assetsubCompTempParams);
						Asset_HeadWorks assetHw = (Asset_HeadWorks) assetsubCompTempParams.get(0);
						daoMessage = RwsMasterData.insertAssetSubCompParams(getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode, assetTypeCode, opType,
								assetForm.getAssetHeadWorks(), "Headworks");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetHeadWorks(assetsubCompParams);
					}
					if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03"))
							|| assetTypeCode.equals("09") && (assetCompTypeCode.equals("02")
									|| assetCompTypeCode.equals("03") || assetCompTypeCode.equals("04"))) {
						message = daoMessage.getMessage();
					} else if (rowCount > 0) {
						message = "Record Inserted Successfully";
					} else {
						message = "The Record Cant be inserted";
					}
					if (message == null) {
						if (rowCount > 0) {
							message = "Record Inserted Successfully";
						} else {
							message = "The Record Cant be inserted";
						}
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("Error in add GLSR :" + e.getMessage());
				}
			}

			// this block is executed where save button is pressed in
			// assetEntryForm
			// for saving an asset
			if (mode.equals("Save Source")) {
				mode = "Add Source";
			}
			if (mode.equalsIgnoreCase("save") || mode.equalsIgnoreCase("Add Source"))// Add Source is
																						// meant for adding
																						// an Asset from
																						// Water Sample
																						// collection Form
			{

				if (mode.equalsIgnoreCase("Add Source")) {
					mode = "AddSource";
				}
				String water = (String) session.getAttribute("water");
				if (water != null) {
					session.setAttribute("water1", water);
				}
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					message = saveAsset(assetForm, request);
				} else {
					message = "Asset not inserted please try again";
				}
				request.setAttribute("message", message);
				assetForm.setAssetHabs((ArrayList) session.getAttribute("tempSelectedHabs"));
				if (message.equals("Record inserted Successfully-Please Select Asset Code to Add SubComponents")) {
					assetForm.setOpType("Modify");
					mode = "opModify";
				} else {
					return mapping.findForward("getNew");
				}
			}
			if (mode != null && mode.equalsIgnoreCase("opModify")) {
				schemeCodes = commonLists.getSchemeCodes(request.getParameter("assetTypeCode"),
						request.getParameter("habCode"));
				pumpCode = "";

				session.setAttribute("schemeCodes", schemeCodes);
				session.removeAttribute("assetCompTypes");
				session.removeAttribute("assetSubCompTypes");
				session.removeAttribute("headWorks");
				session.removeAttribute("pipeLine");
				session.removeAttribute("resorvior");
				session.removeAttribute("pumpsets");
				assetForm.setAssetName("");
				assetForm.setLocation("");
				assetForm.setAssetStatus("");
				assetForm.setStartYear("");
				assetForm.setDateofCreation("");
				assetForm.setAssetCost("");
				assetForm.setTotHabs(0);
				assetForm.setTotPopBenfit(0);
				assetForm.setRemarks("");
				assetForm.setPumpCode("");
				assetForm.setDpYield("");
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("edit")) {
				try {
					rwsMaster.setAssetTypeCode(assetForm.getAssetTypeCode());
					rwsMaster.setAssetCode(assetForm.getAssetCode());
					rwsMaster.setAssetName(assetForm.getAssetName());
					rwsMaster.setDateofCreation(assetForm.getDateofCreation());
					rwsMaster.setLocation(assetForm.getLocation());
					rwsMaster.setAssetStatus(assetForm.getAssetStatus());
					rwsMaster.setAssetCost(assetForm.getAssetCost());
					rwsMaster.setStartYear(assetForm.getStartYear());
					rwsMaster.setEndYear(assetForm.getEndYear());
					rwsMaster.setLatitude(assetForm.getLatitude());
					rwsMaster.setLongitude(assetForm.getLongitude());
					rwsMaster.setElevation(assetForm.getElevation());
					rwsMaster.setWaypoint(assetForm.getWaypoint());

					habs = (ArrayList) session.getAttribute("tempSelectedHabs");

					if (assetForm.getAssetTypeCode().equals("04")
							&& request.getParameter("assetCompTypeCode").equals("01")
							&& request.getParameter("assetSubCompTypeCode").equals("001"))
						sources = (ArrayList) session.getAttribute("HPSubComps");
					else if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("003"))
						sources = (ArrayList) session.getAttribute("GLSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode").equals("01")
							&& request.getParameter("assetSubCompTypeCode").equals("001"))
						sources = (ArrayList) session.getAttribute("PWSBoreWellSubComps");

					pipeLine = (ArrayList) assetForm.getAssetPipeLine();

					if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("001"))
						resorvior = (ArrayList) session.getAttribute("ResOHSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("001"))
						resorvior = (ArrayList) session.getAttribute("ResCPWSOHSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("002"))
						resorvior = (ArrayList) session.getAttribute("ResCPWSOHBRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("003"))
						resorvior = (ArrayList) session.getAttribute("ResCPWSGLSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode").equals("04")
							&& request.getParameter("assetSubCompTypeCode").equals("004"))
						resorvior = (ArrayList) session.getAttribute("ResCPWSGLBRSubComps");

					rcount = RwsMasterData.updateAsset(rwsMaster, habs, sources, headWorks, pipeLine, resorvior,
							request.getParameter("assetCompTypeCode"), request.getParameter("assetSubCompTypeCode"),
							getDataSource(request));
					session.removeAttribute("tempSelectedHabs");
				} catch (Exception e) {
					Debug.println("The error in edit rws_asset_entry=  " + e);
				}
				if (rcount.length < 1) {
					if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
						message = RwsMasterData.errorMessage;
					else
						displaymess = "The record cannot be updated.";
					mode = "get";
					request.setAttribute("displaymess", displaymess);
				}

			}
			if (mode.equalsIgnoreCase("delete")) {
				try {
					message = RwsMasterData.removeAsset(request.getParameter("assetCode"), getDataSource(request),
							user.getUserId());
					request.setAttribute("message", message);
				} catch (Exception e) {
					e.printStackTrace();
					Debug.println("the error in Circle delete is " + e);
				}
				return mapping.findForward("deleteasset");
			}

			if (mode.equalsIgnoreCase("AddHabs")) {
				session.setAttribute("isNewHab", "false");
				RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
				try {
					assetForm.setToDo(request.getParameter("toDo"));
					if (request.getParameter("toDo") != null) {
						assetForm.setAssetCompTypeCode(request.getParameter("assetCompTypeCode"));
						assetForm.setAssetSubCompTypeCode(request.getParameter("assetSubCompTypeCode"));
						if (request.getParameter("toDo").equals("newHab")) {
							if ((assetForm.getAssetTypeCode().equals("01") || assetForm.getAssetTypeCode().equals("02")
									|| assetForm.getAssetTypeCode().equals("03"))
									&& assetForm.getAssetCompTypeCode().equals("01")
									&& assetForm.getAssetSubCompTypeCode().equals("003")) {
								assetsubCompTempParams.clear();
								Asset_Pumpset asset_pumpsetTmp = new Asset_Pumpset();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								String nextCode = subCompMetaData.getNextSchemeCode(getDataSource(request),
										request.getParameter("assetTypeCode"),
										request.getParameter("assetCompTypeCode"),
										request.getParameter("assetSubCompTypeCode"),
										(String) session.getAttribute("shortSchemeCodeInAssetEntryForm"),
										(String) session.getAttribute("habCodeInAssetEntryForm"),
										request.getParameter("assetCode"));
								asset_pumpsetTmp.setPumpCode(nextCode);
								asset_pumpsetTmp.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								assetsubCompTempParams.add(asset_pumpsetTmp);
								assetForm.setAssetPumpSets(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams", "Pumpsets");
								return mapping.findForward("pumpset");
							} else if ((assetForm.getAssetTypeCode().equals("01")
									|| assetForm.getAssetTypeCode().equals("09")
									|| assetForm.getAssetTypeCode().equals("02")
									|| assetForm.getAssetTypeCode().equals("03"))
									&& assetForm.getAssetCompTypeCode().equals("06")
									&& assetForm.getAssetSubCompTypeCode().equals("001")) {
								assetsubCompTempParams.clear();
								Asset_Pumpset asset_pumpsetTmp = new Asset_Pumpset();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								String nextCode = subCompMetaData.getNextSchemeCode(getDataSource(request),
										request.getParameter("assetTypeCode"),
										request.getParameter("assetCompTypeCode"),
										request.getParameter("assetSubCompTypeCode"),
										(String) session.getAttribute("shortSchemeCodeInAssetEntryForm"),
										(String) session.getAttribute("habCodeInAssetEntryForm"),
										request.getParameter("assetCode"));
								asset_pumpsetTmp.setPumpCode(nextCode);
								asset_pumpsetTmp.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								assetsubCompTempParams.add(asset_pumpsetTmp);

								assetForm.setAssetPumpSets(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams", "Pumpsets");
								return mapping.findForward("pumpset");
							}
							if (assetForm.getAssetTypeCode().equals("04")) {
								assetsubCompTempParams.clear();
								RwsMaster rwsMasterTmp = new RwsMaster();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								String nextCode = subCompMetaData.getNextSchemeCode(getDataSource(request),
										request.getParameter("assetTypeCode"),
										request.getParameter("assetCompTypeCode"),
										request.getParameter("assetSubCompTypeCode"),
										(String) session.getAttribute("shortSchemeCodeInAssetEntryForm"),
										(String) session.getAttribute("habCodeInAssetEntryForm"),
										request.getParameter(assetCode));
								rwsMaster.setHpCode(nextCode);
								rwsMaster.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								assetsubCompTempParams.add(rwsMaster);
								assetForm.setAssetSubComponents(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams", "HandPumps");
								return mapping.findForward("pumpset");
							}
							if (assetForm.getAssetTypeCode().equals("05")) {
								assetsubCompTempParams.clear();
								Asset_SHP asset_SHP = new Asset_SHP();
								asset_SHP	.setShallowHandPumpCode((String) session.getAttribute("habCodeInAssetEntryForm")
												+ (String) session.getAttribute("shortSchemeCodeInAssetEntryForm")
												+ "SH" + "001");
								asset_SHP.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								asset_SHP.setLocation(request.getParameter("location"));
								String hname = RwsMasterData.getHabName(getDataSource(request),	(String) session.getAttribute("habCodeInAssetEntryForm"));
								asset_SHP.setHabitation(hname);
								assetsubCompTempParams.add(asset_SHP);
								assetForm.setAssetSHP(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams", "SHP");
								return mapping.findForward("ponds");
							}
							if (assetForm.getAssetTypeCode().equals("06")) {
								assetsubCompTempParams.clear();
								Asset_OpenWells asset_openWells = new Asset_OpenWells();
								asset_openWells.setOpenWellCode((String) session.getAttribute("habCodeInAssetEntryForm")
										+ (String) session.getAttribute("shortSchemeCodeInAssetEntryForm") + "OW"
										+ "001");
								asset_openWells.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								assetsubCompTempParams.add(asset_openWells);
								assetForm.setAssetOpenWells(assetsubCompTempParams);
								asset_openWells.setLocation(request.getParameter("location"));
								String hname1 = RwsMasterData.getHabName(getDataSource(request),
										(String) session.getAttribute("habCodeInAssetEntryForm"));
								asset_openWells.setHabitation(hname1);
								session.setAttribute("assetsubCompParams", "OpenWells");
								return mapping.findForward("ponds");
							}
							if (assetForm.getAssetTypeCode().equals("07")) {
								assetsubCompTempParams.clear();
								Asset_Ponds asset_ponds = new Asset_Ponds();
								asset_ponds.setPondCode((String) session.getAttribute("habCodeInAssetEntryForm")
										+ (String) session.getAttribute("shortSchemeCodeInAssetEntryForm") + "PD"
										+ "001");
								asset_ponds.setHabCode((String) session.getAttribute("habCodeInAssetEntryForm"));
								asset_ponds.setLocation(request.getParameter("location"));
								String habitationname = RwsMasterData.getHabName(getDataSource(request),
										(String) session.getAttribute("habCodeInAssetEntryForm"));
								asset_ponds.setHabitation(habitationname);
								assetsubCompTempParams.add(asset_ponds);
								assetForm.setAssetPonds(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams", "Ponds");
								return mapping.findForward("ponds");
							}
							request.setAttribute("isNewSubComp", "true");
							assetForm.setAddHabsDistrict(assetForm.getCircleOfficeCode());
							assetForm.setAddHabsMandal(assetForm.getHabCode().substring(5, 7));
							assetForm.setAddHabsHabitation(assetForm.getHabCode());
							dists = rwsLocations.getDistricts();
							session.setAttribute("dists", dists);
							mandals = rwsLocations.getMandals(assetForm.getAddHabsDistrict());
							session.setAttribute("mandals", mandals);
							prhabs = rwsLocation.getHabs(assetForm.getAddHabsDistrict(), assetForm.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);
							session.setAttribute("isNewHab", "true");
							return mapping.findForward(mode);
						}

						session.setAttribute("isNewHab", "true");
					} else {
						session.setAttribute("isNewHab", "false");

					}
					dists = rwsLocations.getDistricts();
					session.setAttribute("dists", dists);
					if (request.getParameter("changed") != null
							&& request.getParameter("changed").equalsIgnoreCase("district")) {
						assetForm.setAddHabsMandal("");
						assetForm.setAddHabsHabitation("");
						if (!assetForm.getAddHabsDistrict().equals("")) {
							mandals = rwsLocations.getMandals(assetForm.getAddHabsDistrict());
							session.setAttribute("mandals", mandals);
							prhabs = rwsLocation.getHabs(assetForm.getAddHabsDistrict(), assetForm.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);
						}
						return mapping.findForward(mode);
					}
					if (request.getParameter("changed") != null
							&& request.getParameter("changed").equalsIgnoreCase("mandal")) {
						assetForm.setAddHabsHabitation("");
						if (!assetForm.getAddHabsMandal().equals("")) {
							prhabs = rwsLocation.getHabs(assetForm.getAddHabsDistrict(), assetForm.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);
						}
					}
					String tempSumpCoce = "";
					String subCompCode = (String) request.getParameter("subCompCode1");
					try {
						if (request.getParameter("habCode") != null || (request.getParameter("toDo") == null
								|| !request.getParameter("toDo").equals("newHab"))) {
							habCode = request.getParameter("habCode");
						} else if (request.getParameter("toDo") == null
								|| !request.getParameter("toDo").equals("newHab")) {
							SubCompMetaData subCompMetaData = new SubCompMetaData(subCompCode);
							String tableName = subCompMetaData.getTableName();
							String tempSubCode = subCompMetaData.getSchemeCodeField();
							habCode = RwsMasterData.getHabCode(getDataSource(request), tableName, tempSubCode,
									subCompCode);
						} else {
							habCode = assetForm.getAddHabsHabitation();
						}
						if (habCode == null || habCode.equals("")) {
							assetForm.setAddHabsDistrictName("");
							assetForm.setAddHabsMandalName("");
							assetForm.setAddHabsHabitation("");
							return mapping.findForward(mode);
						}
						assetForm.setAddHabsDistrict(habCode.substring(0, 2));
						assetForm.setAddHabsMandal(habCode.substring(5, 7));
						String district = rwsLocations.getDname(habCode.substring(0, 2));
						String mandal = rwsLocations.getMname(habCode.substring(0, 2), habCode.substring(5, 7));
						String habName = RwsMasterData.getHabName(getDataSource(request), subCompCode.substring(0, 16));
						assetForm.setAddHabsDistrictName(district);
						assetForm.setAddHabsMandalName(mandal);
						assetForm.setAddHabsHabitation(habName + "-" + habCode.substring(0, 16));
					} catch (Exception e) {
						Debug.println("exception in initialisation" + e);
					}
					if (!assetForm.getAddHabsDistrict().equals("")) {
						mandals = rwsLocations.getMandals(assetForm.getAddHabsDistrict());
						session.setAttribute("mandals", mandals);
					}
					if (!assetForm.getAddHabsDistrict().equals("") && !assetForm.getAddHabsMandal().equals("")) {
						prhabs = rwsLocation.getHabs(assetForm.getAddHabsDistrict(), assetForm.getAddHabsMandal());
						session.setAttribute("prhabs", prhabs);
					}
					String phCode1 = request.getParameter("subCompCode1");
					if (phCode1 == null || phCode1.equals("null")) {
					} else
						session.setAttribute("phCode1", phCode1);

				} catch (Exception e) {
					Debug.println("The error in1234   is " + e);
				}
				return mapping.findForward(mode);
			}
			if (mode.equalsIgnoreCase("SaveHab")) {
				String shortSchemeCode = (String) session.getAttribute("shortSchemeCode");
				SubCompMetaData subCompMetaData = new SubCompMetaData();
				try {
					String nextSchemeCode = "";
					if ((request.getParameter("assetTypeCode").equals("01")
							|| request.getParameter("assetTypeCode").equals("02")
							|| request.getParameter("assetTypeCode").equals("03"))) {
						if (request.getParameter("assetCompTypeCode").equals("02"))
							assetsubCompParams = (ArrayList) assetForm.getAssetHeadWorks();
						else if (request.getParameter("assetCompTypeCode").equals("03"))
							assetsubCompParams = (ArrayList) assetForm.getAssetPipeLine();
						else if (request.getParameter("assetCompTypeCode").equals("04"))
							assetsubCompParams = (ArrayList) assetForm.getAssetReservior();
						else if (request.getParameter("assetCompTypeCode").equals("05"))
							assetsubCompParams = (ArrayList) assetForm.getAssetPumpSets();

						nextSchemeCode = getFormNextSchemeCode((String) request.getParameter("assetCompTypeCode"),
								(String) request.getParameter("assetSubCompTypeCode"),
								(String) request.getParameter("assetTypeCode"), assetsubCompParams, shortSchemeCode,
								(String) request.getParameter("habCode"));
					}
					if (nextSchemeCode == null || nextSchemeCode.length() != 24) {
						nextSchemeCode = subCompMetaData.getNextSchemeCode(getDataSource(request),
								(String) request.getParameter("assetTypeCode"),
								(String) request.getParameter("assetCompTypeCode"),
								(String) request.getParameter("assetSubCompTypeCode"), shortSchemeCode,
								(String) request.getParameter("habCode"), (String) session.getAttribute("assetCode"));
					}
					session.setAttribute("nextSubCompCode", nextSchemeCode);
					if (((String) request.getParameter("toDo")).equalsIgnoreCase("newHab")) {
						request.setAttribute("isNewSubComp", "true");
						assetForm.setMode("goToAddNewAction");
						return mapping.findForward("goToAddNewAction");
					}
					RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
					dists = rwsLocations.getDistricts();

					session.setAttribute("dists", dists);
					String subCompCode = (String) session.getAttribute("phCode1");

				} catch (Exception e) {
					Debug.println("The Exception in SaveHab mode is " + e);
				}
				request.setAttribute("message", message);
			}

			if (assetSubCompCode != null && assetSubCompCode.equals("003") && mode.equals("addNew"))
				mode = "pumpset";
			if (assetSubCompCode != null && assetSubCompCode.equals("003") && mode.equals("removeSubComps"))
				mode = "pumpset";
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03"))
					&& assetCompTypeCode.equals("03")
					&& (assetSubCompTypeCode.equals("001") || assetSubCompTypeCode.equals("002")
							|| assetSubCompTypeCode.equals("003"))
					&& !mode.equalsIgnoreCase("AddHabs") && !mode.equalsIgnoreCase("saveHab")) {
				mode = "pumpset";
			}
			if ((typeOfAssetCode.equals("05") || typeOfAssetCode.equals("06") || typeOfAssetCode.equals("07")
					|| typeOfAssetCode.equals("08")) && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				mode = "ponds";

			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode.equals("03"))
					&& assetCompTypeCode.equals("04") && assetSubCompTypeCode.equals("003")
					&& mode.equalsIgnoreCase("pumpset"))
				mode = "addNew";

		} catch (Exception e) {
			Debug.println("An Exception has occured at the end of assetActFrm.java execute method " + e);
		}
		System.gc();
		return (mapping.findForward(mode));

	}

	protected ArrayList fillPipeLine(ArrayList list, DataSource dataSource) throws Exception {
		CommonLists commonLists = new CommonLists(dataSource);
		Asset_PipeLine subcompParams = new Asset_PipeLine();
		for (int i = 0; i < list.size(); i++) {
			ArrayList comboList = new ArrayList();
			subcompParams = (Asset_PipeLine) list.get(i);
			String material = subcompParams.getMaterial();
			String materialCode = commonLists.getMaterialCode(material);
			ArrayList pipeMaterialTemp = commonLists.getPipeMatirals();
			ArrayList pipeClassTemp = commonLists.getPipeClass(materialCode);
			ArrayList pipeDiameterTemp = commonLists.getPipDia(materialCode);
			subcompParams.setPipeMaterialList(pipeMaterialTemp);
			subcompParams.setPipeClassList(pipeClassTemp);
			subcompParams.setPipeDiameterList(pipeDiameterTemp);
			list.set(i, subcompParams);
		}
		return list;
	}

	public String getNewAssetCode(HttpServletRequest request, String circleOfficeCode, String divisionOfficeCode,
			String subdivisionOfficeCode, String habCode, String assetTypeCode) {
		String assetCode = "";
		try {
			assetCode = RwsMasterData.getAssetCode(circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode, habCode,
					assetTypeCode, getDataSource(request));
			if (assetCode.length() == 4) {
				assetCode = "0000" + request.getParameter("dcode") + request.getParameter("assetTypeCode")
						+ request.getParameter("mandal") + assetCode;
			} else if (assetCode.length() == 9) {
				assetCode = "00000" + assetCode;
			} else {
				assetCode = "0000" + assetCode;
			}
			assetCode = RwsMasterData.checkAssetCode(assetCode);
			if (assetCode.length() == 4) {
				assetCode = "0000" + request.getParameter("dcode") + request.getParameter("assetTypeCode")
						+ request.getParameter("mandal") + assetCode;
			} else if (assetCode.length() == 9) {
				assetCode = "00000" + assetCode;
			} else {
				assetCode = "0000" + assetCode;
			}
		} catch (Exception e) {
			Debug.println("Exception in getNewAssetCode is ");
		}
		return assetCode;
	}

	public String saveAsset(AssetForm assetForm, HttpServletRequest request) {
		String message = "";
		try {
			RwsMaster rwsMaster = new RwsMaster();
			ArrayList habs = new ArrayList();
			HttpSession session = request.getSession();
			rwsMaster.setCoc(assetForm.getCoc());
			rwsMaster.setDoc(assetForm.getDoc());
			rwsMaster.setSdoc(assetForm.getSdoc());
			rwsMaster.setHabCode(assetForm.getHabCode());
			rwsMaster.setAssetTypeCode(assetForm.getAssetTypeCode());
			rwsMaster.setAssetCode(assetForm.getAssetCode());
			rwsMaster.setDateofCreation(assetForm.getDateofCreation());
			rwsMaster.setAssetName(assetForm.getAssetName());
			rwsMaster.setLocation(assetForm.getLocation());
			rwsMaster.setAssetCost(assetForm.getAssetCost());
			rwsMaster.setStartYear(assetForm.getStartYear());
			rwsMaster.setEndYear(assetForm.getEndYear());
			rwsMaster.setDefunctReasons(assetForm.getDefunctReasons());
			rwsMaster.setAssetCompTypeCode(assetForm.getAssetCompTypeCode());
			rwsMaster.setAssetSubCompTypeCode(assetForm.getAssetSubCompTypeCode());
			rwsMaster.setAssetStatus(assetForm.getAssetStatus());
			rwsMaster.setPumpCode(assetForm.getPumpCode());
			rwsMaster.setTotPopBenfit(assetForm.getTotPopBenfit());
			rwsMaster.setLatitude(assetForm.getLatitude());
			rwsMaster.setLongitude(assetForm.getLongitude());
			rwsMaster.setElevation(assetForm.getElevation());
			rwsMaster.setWaypoint(assetForm.getWaypoint());
			rwsMaster.setRemarks(assetForm.getRemarks());
			rwsMaster.setDpYield(assetForm.getDpYield());
			habs = (ArrayList) session.getAttribute("tempSelectedHabs");
			rwsMaster.setCoc(assetForm.getCircleOfficeCode());
			rwsMaster.setDoc(assetForm.getDivisionOfficeCode());
			rwsMaster.setSdoc(assetForm.getSubdivisionOfficeCode());
			rwsMaster.setLastRepairedDate(assetForm.getLastRepairedDate());
			message = RwsMasterData.insertAsset(rwsMaster, habs, request.getParameter("opType"),
					getDataSource(request));
			assetForm.setLatitude("");
			assetForm.setLongitude("");
			assetForm.setElevation("");
			assetForm.setWaypoint("");
		} catch (Exception e) {
			Debug.println("Exception in saveAsset is " + e);
		}
		return message;
	}

	public String getFormNextSchemeCode(String assetCompTypeCode, String assetSubCompTypeCode, String assetTypeCode,
			ArrayList subComps, String shortSchemeCode, String habCode) {
		Asset_HeadWorks assetHeadworks = null;
		Asset_PipeLine assetPipeline = null;
		Asset_Reservior assetReservior = null;
		Asset_Pumpset assetPumpset = null;
		boolean similarSchemeCodeExistsInForm = false;
		String schemeCode = "";
		int sno = 0;
		int maxSno = 0;
		String schemeCode21 = "";
		if (subComps != null) {
			for (int i = 0; i < subComps.size(); i++) {
				if (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) {
					if (assetCompTypeCode.equals("02")) {
						assetHeadworks = (Asset_HeadWorks) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetHeadworks.getCollectionWellCode();
						} else if (assetSubCompTypeCode.equals("002")) {
							schemeCode = assetHeadworks.getSsTankCode();
						} else if (assetSubCompTypeCode.equals("003") || assetSubCompTypeCode.equals("004")) {
							schemeCode = assetHeadworks.getWtpCode();
						} else if (assetSubCompTypeCode.equals("005")) {
							schemeCode = assetHeadworks.getSumpCode();
						} else if (assetSubCompTypeCode.equals("006")) {
							schemeCode = assetHeadworks.getBridgeCode();
						} else if (assetSubCompTypeCode.equals("007")) {
							schemeCode = assetHeadworks.getPumpHouseCode();
						} else if (assetSubCompTypeCode.equals("008")) {
							schemeCode = assetHeadworks.getWatchManCode();
						} else if (assetSubCompTypeCode.equals("009")) {
							schemeCode = assetHeadworks.getCollectionWellCode();
						}
					} else if (assetCompTypeCode.equals("03")) {
						return null;
					}
					else if (assetCompTypeCode.equals("04")) {
						assetReservior = (Asset_Reservior) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetReservior.getOhsrCode();
						} else if (assetSubCompTypeCode.equals("002")) {
							schemeCode = assetReservior.getOhbrCode();
						} else if (assetSubCompTypeCode.equals("003")) {
							schemeCode = assetReservior.getGlsrCode();
						} else if (assetSubCompTypeCode.equals("004")) {
							schemeCode = assetReservior.getGlbrCode();
						} else if (assetSubCompTypeCode.equals("005")) {
							schemeCode = assetReservior.getBptCode();
						} else if (assetSubCompTypeCode.equals("006")) {
							schemeCode = assetReservior.getCisCode();
						} else if (assetSubCompTypeCode.equals("007")) {
							schemeCode = assetReservior.getStandPostCode();
						}
					} else if (assetCompTypeCode.equals("05"))	{
						assetPumpset = (Asset_Pumpset) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetPumpset.getOtherCompCode();
						}
					}
				}
				if (schemeCode.length() == 24 && schemeCode.substring(0, 16).equals(habCode)) {
					sno = Integer.parseInt(schemeCode.substring(21, 24));
					if (sno > maxSno)
						maxSno = sno;
					if (schemeCode != null && schemeCode.length() == 24)
						schemeCode21 = schemeCode.substring(0, 21);
					similarSchemeCodeExistsInForm = true;
				}
			}
		}
		String slNo = (maxSno + 1) + "";
		if (slNo == null || slNo.equals("0") || slNo.equals("")) {
			slNo = "001";
		} else if (slNo.length() == 1) {
			slNo = "00" + slNo;
		} else if (slNo.length() == 2) {
			slNo = "0" + slNo;
		}
		if (!similarSchemeCodeExistsInForm) {
			return null;
		}
		SubCompMetaData subCompMetaData = new SubCompMetaData(assetTypeCode, assetCompTypeCode, assetSubCompTypeCode);
		String subCompRep = subCompMetaData.getSubCompRep();
		String schemeCode24 = "";
		if (habCode != null && !habCode.equals("") && shortSchemeCode != null && !shortSchemeCode.equals("")
				&& schemeCode21.length() == 21)
			schemeCode24 = habCode + schemeCode21.substring(16, 19) + subCompRep + slNo;
		else
			schemeCode24 = schemeCode21 + slNo;
		return schemeCode24;
	}

	public ArrayList removeTempSelectedHabs(ArrayList tempSelectedHabs, String mcode) {
		ArrayList returnList = new ArrayList();
		RwsMaster rm = null;
		for (int i = 0; i < tempSelectedHabs.size(); i++) {
			rm = (RwsMaster) tempSelectedHabs.get(i);
		}
		for (int i = 0; i < tempSelectedHabs.size(); i++) {
			rm = (RwsMaster) tempSelectedHabs.get(i);
			if (!rm.getHabCode().substring(5, 7).equals(mcode)) {
				returnList.add(rm);
			}
		}
		return returnList;
	}

	public static double round(double d,int decimalPlace) {
		BigDecimal bd = new BigDecimal(Double.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}

}