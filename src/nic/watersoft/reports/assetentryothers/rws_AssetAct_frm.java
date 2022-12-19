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

	public AssetForm addNewSubComponent(String mode,
			HttpServletRequest request, AssetForm assetForm) {
		ArrayList headOffices;
		ArrayList circles;
		ArrayList divisions;
		ArrayList subdivisions;
		int[] rcount;
		ArrayList pipeClass;
		ArrayList pipeDiameter;
		int countTmp = 0;

		HttpSession session = request.getSession();
		ArrayList assetCompTypes = new ArrayList();
		String index = "";

		String coc = null;
		String doc = null;
		String sdoc = null;
		String habCode = null;
		String assetTypeName = "";

		ArrayList assetsubCompTypes = new ArrayList();
		ArrayList sources = new ArrayList();
		ArrayList headWorks = new ArrayList();
		ArrayList pipeLine = new ArrayList();
		ArrayList resorvior = new ArrayList();
		ArrayList pumpsets = new ArrayList();

		String pumpCode = "";
		CommonLists commonLists;

		String opType = "";
		ArrayList tempSelectedHabs = new ArrayList();
		String typeOfAssetCode = "";
		String assetCompTypeCode = "";
		String assetSubCompTypeCode = "";

		//////////////////////end of variables copied from class//////////////

		Debug.println("in addNewSubComponent");
		Object subComponent;
		ArrayList assetsubCompParams = new ArrayList();
		Asset_Reservior asset_reservior = null;
		Asset_Pumpset asset_pumpset = null;
		Asset_PipeLine asset_pipeline = null;
		Asset_HeadWorks asset_headworks = null;
		Asset_SubComponent asset_subcomponent = null;

		try {
			Debug.println("in addNew mode in rws_assetAct_frm.java");
			typeOfAssetCode = request.getParameter("assetTypeCode");
			assetCompTypeCode = request.getParameter("assetCompTypeCode");
			assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
			assetsubCompParams.clear();
			String Code = "";
			int No;
			Debug
					.println("typeOfAssetCode in addNew() is:::"
							+ typeOfAssetCode);
			Debug.println("assetCompTypeCode in addNew() is:::"
					+ assetCompTypeCode);
			Debug.println("assetSubCompTypeCode in addNew() is:::"
					+ assetSubCompTypeCode);

			if (typeOfAssetCode.equals("05") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				Asset_SHP asset_SHP = new Asset_SHP();
				Debug.println("in addNewSubComponent Shallow hand pumps");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");

				asset_SHP.setShallowHandPumpCode(nextSubCompCode);

				asset_SHP.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_SHP);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetSHP(assetsubCompParams);
				assetForm.setMode("ponds");
				session.setAttribute("assetsubCompParams", "SHP");

			}
			if (typeOfAssetCode.equals("06") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				Asset_OpenWells asset_openWells = new Asset_OpenWells();
				Debug.println("in addNewSubComponent Open well");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");

				asset_openWells.setOpenWellCode(nextSubCompCode);

				asset_openWells.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_openWells);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetOpenWells(assetsubCompParams);

				session.setAttribute("assetsubCompParams", "OpenWells");
				assetForm.setMode("ponds");

			}
			if (typeOfAssetCode.equals("07") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				Asset_Ponds asset_ponds = new Asset_Ponds();
				Debug.println("in addNewSubComponent Ponds");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");

				asset_ponds.setPondCode(nextSubCompCode);

				asset_ponds
						.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_ponds);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetPonds(assetsubCompParams);
				session.setAttribute("assetsubCompParams", "Ponds");
				assetForm.setMode("ponds");

			}
			if (typeOfAssetCode.equals("08") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
			{
				Debug.println("testinggggggggggggggggggg");
				Asset_Others asset_others = new Asset_Others();
				Debug.println("in addNewSubComponent Others");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode =(String) session.getAttribute("nextSubCompCode");
				asset_others.setGeneralCode(nextSubCompCode);
				asset_others.setHabCode((String) request.getParameter("habCode"));
				assetsubCompParams.add(asset_others);
				Debug.println("size after addint is "+ assetsubCompParams.size());
				assetForm.setAssetOthers(assetsubCompParams);
				session.setAttribute("assetsubCompParams", "Others");
				assetForm.setMode("ponds");
			}

			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("003")) {
				assetForm.setMode("pumpset");

				assetsubCompParams = (ArrayList) session
						.getAttribute("assetsubCompPWSParams");
				session.removeAttribute("assetsubCompPWSParams");
				assetsubCompParams.clear();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setPumpCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);

				assetForm.setMode("pumpset");
			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("06")
					&& assetSubCompTypeCode.equals("001")) {
				assetForm.setMode("pumpset");

				assetsubCompParams = (ArrayList) session
						.getAttribute("assetsubCompPWSParams");
				session.removeAttribute("assetsubCompPWSParams");
				assetsubCompParams.clear();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();
				asset_pumpset.setPumpCode(nextSubCompCode);
				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				assetForm.setAssetPumpSets(assetsubCompParams);

				assetForm.setMode("pumpset");
			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("001")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setCollectionWellCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("002")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setSsTankCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);

				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& (assetSubCompTypeCode.equals("003") || assetSubCompTypeCode
							.equals("004"))
					|| assetSubCompTypeCode.equals("010")
					|| assetSubCompTypeCode.equals("011")) {

				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setWtpCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
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

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("005")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setSumpCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("006")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setBridgeCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("007")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setPumpHouseCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("008")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setWatchManCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("009")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				assetsubCompParams = (ArrayList) session
						.getAttribute("assetHeadWorks");
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_headworks = new Asset_HeadWorks();

				asset_headworks.setCollectionWellCode(nextSubCompCode);

				asset_headworks.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_headworks);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetHeadWorks(assetsubCompParams);
				assetForm.setMode("addNew");

			}

			else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("001")) {
				Debug
						.println("in addNewSubComponent raw water collection well");

				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();

				asset_pipeline.setPmCode(nextSubCompCode);

				asset_pipeline.setHabCode((String) request
						.getParameter("habCode"));
				Debug.println("habCode added to assetForm is "
						+ asset_pipeline.getHabCode());
				assetsubCompParams.add(asset_pipeline);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());

				assetForm.setAssetPipeLine(assetsubCompParams);
				session.setAttribute("assetsubCompPWSParams",
						assetsubCompParams);
				session.setAttribute("assetsubCompParams", "PwsPumpingMain");
				assetForm.setMode("pumpset");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("002")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetHeadWorks");
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetPipeLine");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();

				asset_pipeline.setGravitymain_code(nextSubCompCode);

				asset_pipeline.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pipeline);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetPipeLine(assetsubCompParams);
				assetForm.setMode("pumpset");
				session.setAttribute("assetsubCompParams", "GravityMain");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("03")
					&& assetSubCompTypeCode.equals("003")) {
				Debug
						.println("in addNewSubComponent raw water collection well");
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetHeadWorks");
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetPipeLine");
				assetsubCompParams = new ArrayList();
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pipeline = new Asset_PipeLine();

				asset_pipeline.setDisCode(nextSubCompCode);

				asset_pipeline.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pipeline);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetPipeLine(assetsubCompParams);
				assetForm.setMode("pumpset");
				session.setAttribute("assetsubCompParams", "Distribution");

			}

			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("001")) {

				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setOhsrCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				//session.setAttribute("assetsubCompParams",assetsubCompParams);
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");

			}

			else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("002")) {
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setOhbrCode(nextSubCompCode);

				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("003")) {
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setGlsrCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("004")) {
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setGlbrCode(nextSubCompCode);

				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("005")) {
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setBptCode(nextSubCompCode);

				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");
			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("006")) {
				//assetsubCompParams =
				// (ArrayList)session.getAttribute("assetReservior");
				assetsubCompParams = assetForm.getAssetReservior();
				Debug.println("assetsubCompParams size is"
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_reservior = new Asset_Reservior();

				asset_reservior.setCisCode(nextSubCompCode);
				asset_reservior.setNoOfHab("0");
				asset_reservior.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_reservior);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetReservior(assetsubCompParams);
				assetForm.setMode("addNew");

			}

			else if (typeOfAssetCode.equals("01")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				asset_subcomponent = new Asset_SubComponent();
				Debug.println("(((((((((((  "
						+ (String) session.getAttribute("phCode"));
				Code = (String) session.getAttribute("phCode");
				asset_subcomponent.setPmpCode((String) session
						.getAttribute("phCode"));
				assetsubCompParams.add(asset_subcomponent);
				assetForm.setAssetSubComponents(assetsubCompParams);
				No = Integer.parseInt(Code.substring(21, 24)) + 1;
				Code = Code.substring(0, 21) + "00" + No;

				session.setAttribute("phCode", Code);

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("001")) {

				assetsubCompParams = assetForm.getAssetPumpSets();
				Debug.println("subCompParams size is "
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();

				asset_pumpset.setOtherCompCode(nextSubCompCode);

				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");

			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("002")) {
				assetsubCompParams = assetForm.getAssetPumpSets();
				Debug.println("subCompParams size is "
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				asset_pumpset = new Asset_Pumpset();

				asset_pumpset.setOtherCompCode(nextSubCompCode);

				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_pumpset);
				Debug.println("size after addint is "
						+ assetsubCompParams.size());
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");
			} else if ((typeOfAssetCode.equals("01")
					|| typeOfAssetCode.equals("02")
					|| typeOfAssetCode.equals("03") || typeOfAssetCode
					.equals("09"))
					&& assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("003")) {
				assetsubCompParams = assetForm.getAssetPumpSets();
				Debug.println("o and m subCompParams size is "
						+ assetsubCompParams.size());
				String nextSubCompCode = (String) session
						.getAttribute("nextSubCompCode");
				Asset_Others asset_others = new Asset_Others();

				//asset_others.setOtherCompCode(nextSubCompCode);

				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				assetsubCompParams.add(asset_others);
				Debug.println("size after addint o and m is "
						+ assetsubCompParams.size());
				assetForm.setAssetPumpSets(assetsubCompParams);
				assetForm.setMode("params");
			} else if (typeOfAssetCode.equals("04")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				asset_subcomponent = new Asset_SubComponent();
				Debug.println("(((((((((((  "
						+ (String) session.getAttribute("phCode"));
				Code = (String) session.getAttribute("phCode");
				asset_subcomponent.setHpCode((String) session
						.getAttribute("phCode"));
				assetsubCompParams.add(asset_subcomponent);
				assetForm.setAssetSubComponents(assetsubCompParams);
				No = Integer.parseInt(Code.substring(21, 24)) + 1;
				Code = Code.substring(0, 21) + "00" + No;
				assetForm.setMode("pumpset");

			}

		} catch (Exception e) {
			Debug.println("Exception in addnew is " + e);
		}

		return assetForm;
	}

	protected String getNextSubComponentCode(String code) {
		int tslno = 0;
		tslno = Integer.parseInt(code.substring(21, 24));
		Debug.println("tslno=" + tslno);
		Debug.println("*******code is " + code);
		String tempPCode = null;
		//@author satosh code added on 271106
		if (tslno == 0) {
			tempPCode = code.substring(0, 21) + "001";

		} else if (tslno <= 8) {
			tempPCode = code.substring(0, 21) + "00" + (tslno + 1);
		} else if (tslno <= 98) {
			tempPCode = code.substring(0, 21) + "0" + (tslno + 1);
		} else {
			tempPCode = tempPCode.substring(0, 21) + (tslno + 1);
		}
		return tempPCode;
	}

	/*
	 * protected ActionForm buildAssetForm(String assetCode, String
	 * assetTypeCode, HttpServletRequest request, CommonLists commonLists)
	 * throws Exception {
	 * 
	 * //vars copied from class HttpSession session=request.getSession();
	 * ArrayList headOffices; ArrayList circles; ArrayList divisions; ArrayList
	 * subdivisions; int[] rcount; ArrayList pipeClass; ArrayList pipeDiameter;
	 * int countTmp=0;
	 * 
	 * ArrayList assetCompTypes = new ArrayList(); String index="";
	 * 
	 * 
	 * ArrayList assetsubCompTypes = new ArrayList();
	 * 
	 * String coc = null;
	 * 
	 * String doc = null;
	 * 
	 * String sdoc = null;
	 * 
	 * String habCode = null;
	 * 
	 * String assetTypeName = "";
	 * 
	 * ArrayList sources = new ArrayList();
	 * 
	 * 
	 * ArrayList headWorks = new ArrayList(); ArrayList pipeLine = new
	 * ArrayList(); ArrayList resorvior = new ArrayList(); ArrayList pumpsets =
	 * new ArrayList();
	 * 
	 * 
	 * String pumpCode = "";
	 * 
	 * 
	 * String opType = "";
	 * 
	 * ArrayList tempSelectedHabs = new ArrayList();
	 * 
	 * String typeOfAssetCode = "";
	 * 
	 * String assetCompTypeCode = "";
	 * 
	 * String assetSubCompTypeCode = "";
	 * 
	 * 
	 * //end of vars copied from class
	 * 
	 * Debug.println("in buildAssetForm()"); AssetForm form = null;
	 * 
	 * 
	 * RwsMaster rwsMaster = RwsMasterData.getAsset(assetCode,
	 * getDataSource(request)); if (rwsMaster != null) { form = new AssetForm();
	 * 
	 * form.setDcode(rwsMaster.getDcode());
	 * form.setDistrict(rwsMaster.getDistrict());
	 * form.setMandal(rwsMaster.getMandal());
	 * form.setMandalName(rwsMaster.getMandalName());
	 * form.setPcode(rwsMaster.getPCode()); form.setVcode(rwsMaster.getVCode());
	 * form.setAssetCode(rwsMaster.getAssetCode());
	 * form.setAssetName(rwsMaster.getAssetName());
	 * form.setAssetTypeCode(rwsMaster.getAssetTypeCode());
	 * form.setAssetTypeName(rwsMaster.getAssetTypeName());
	 * form.setLocation(rwsMaster.getLocation());
	 * form.setDateofCreation(rwsMaster.getDateofCreation());
	 * form.setAssetCost(rwsMaster.getAssetCost());
	 * form.setStartYear(rwsMaster.getStartYear());
	 * form.setEndYear(rwsMaster.getEndYear());
	 * form.setAssetStatus(rwsMaster.getAssetStatus()); coc =
	 * rwsMaster.getCoc(); form.setCon(coc.substring(coc.indexOf(" ") + 1,
	 * coc.length())); coc = coc.substring(0, coc.indexOf(" "));
	 * form.setCoc(coc); doc = rwsMaster.getDoc();
	 * form.setDon(doc.substring(doc.indexOf(" ") + 1, doc.length())); doc =
	 * doc.substring(0, doc.indexOf(" ")); form.setDoc(doc); sdoc =
	 * rwsMaster.getSdoc(); form.setSdon(sdoc.substring(sdoc.indexOf(" ") + 1,
	 * sdoc.length())); sdoc = sdoc.substring(0, sdoc.indexOf(" "));
	 * form.setSdoc(sdoc); habCode = rwsMaster.getHabCode();
	 * form.setHabName(habCode.substring(habCode.indexOf(" ") + 1, habCode
	 * .length())); habCode = habCode.substring(0, habCode.indexOf(" "));
	 * form.setHabCode(habCode);
	 * 
	 * form.setAssetHabs(rwsMaster.getAssetHabs());
	 * form.setPumpCode(rwsMaster.getSchemeCode());
	 * 
	 * commonLists = new CommonLists(getDataSource(request)); assetCompTypes =
	 * commonLists.getAssetComponents(assetTypeCode);
	 * 
	 * Debug.println("it is in getAssetHabs");
	 * session.setAttribute("tempSelectedHabs", rwsMaster.getAssetHabs());
	 * Debug.println("tempSelectedHabs size in buildAssetForm() is
	 * "+rwsMaster.getAssetHabs().size());
	 * session.setAttribute("assetCompTypes", assetCompTypes); if
	 * (assetsubCompTypes.size() > 0) { assetsubCompTypes.clear();
	 * session.setAttribute("assetSubCompTypes", assetsubCompTypes); } else
	 * session.setAttribute("assetSubCompTypes", assetsubCompTypes);
	 * 
	 * if (rwsMaster.getAssetSubComponents().size() > 0) {
	 * form.setAssetSubComponents((ArrayList) rwsMaster
	 * .getAssetSubComponents()); request.setAttribute("sourceParam",
	 * "sourceParam"); }
	 * 
	 * if (rwsMaster.getAssetHeadWorks().size() > 0) {
	 * form.setAssetHeadWorks((ArrayList) rwsMaster .getAssetHeadWorks());
	 * request.setAttribute("headWorksParam", "headWorksParam"); }
	 * 
	 * if (rwsMaster.getAssetPipeLine().size() > 0) {
	 * form.setAssetPipeLine((ArrayList) rwsMaster.getAssetPipeLine());
	 * request.setAttribute("pipeLineParam", "pipeLineParam"); }
	 * 
	 * if (rwsMaster.getAssetReservior().size() > 0) {
	 * form.setAssetReservior((ArrayList) rwsMaster .getAssetReservior());
	 * request.setAttribute("resorviorsParam", "resorviorsParam"); } } return
	 * form; }
	 */
	protected void getAssetSubComponents(AssetForm assetForm,
			HttpServletRequest request, String pumpCode) throws Exception {
		try {
			//vars copied from class
			HttpSession session = null;

			ArrayList headOffices;
			ArrayList circles;
			ArrayList divisions;
			ArrayList subdivisions;
			int[] rcount;
			ArrayList pipeClass;
			ArrayList pipeDiameter;
			int countTmp = 0;

			ArrayList assetCompTypes = new ArrayList();
			String index = "";

			ArrayList assetsubCompTypes = new ArrayList();

			String coc = null;

			String doc = null;

			String sdoc = null;

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

			String typeOfAssetCode = "";

			String assetCompTypeCode = "";

			String assetSubCompTypeCode = "";

			//end of vars copied from class
			Debug.println("in getAssetSubComponents in rws_AssetAct_frm.java");
			Debug.println("printing Values");

			Debug.println("assetTypeName is " + assetTypeName);
			Debug.println("assetType Code is "
					+ request.getParameter("assetTypeCode"));

			session = request.getSession();
			//Debug.println("1");
			commonLists = new CommonLists(getDataSource(request));
			assetCompTypes = commonLists.getAssetComponents(request
					.getParameter("assetTypeCode"));
			//Debug.println("2");
			session.removeAttribute("headWorks");
			session.removeAttribute("pipeLine");
			session.removeAttribute("resorvior");
			session.removeAttribute("pumpsets");
			Debug.println("1:: AssetComponents.size " + assetCompTypes.size());
			//Debug.println("3");
			for (int i = 0; i < assetCompTypes.size(); i++) {
				Debug.println(" ASSET SUB COMPONENENENE "
						+ assetCompTypes.size());
				LabelValueBean labelValueBean = (LabelValueBean) assetCompTypes
						.get(i);
				Debug.println("assetTypeCode is "
						+ request.getParameter("assetTypeCode"));
				assetTypeName = RwsMasterData.getAssetTypeName(request
						.getParameter("assetTypeCode"), getDataSource(request));
				String assetCompName = RwsMasterData.getAssetCompTypeName(
						labelValueBean.getValue(), request
								.getParameter("assetTypeCode"),
						getDataSource(request));
				//@author santosh
				Debug.println("labelValueBean.getLabel is "
						+ labelValueBean.getLabel());
				Debug.println("assetCompName is " + labelValueBean.getLabel());
				Debug.println("assetTypeName is " + assetTypeName);
				Debug.println("labelValueBean.getLabel="
						+ labelValueBean.getLabel());
				String assetTypeCode = assetForm.getAssetTypeCode();
				habCode = assetForm.getHabCode();
				opType = assetForm.getOpType();

				if ((assetTypeName.trim().equalsIgnoreCase("PONDS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					Debug.println(" 1:: in if of ponds");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim()
						.equalsIgnoreCase("SHALLOW HAND PUMPS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					/*
					 * session.removeAttribute("headWorks");
					 * session.removeAttribute("pipeLine");
					 * session.removeAttribute("resorvior");
					 * session.removeAttribute("pumpsets");
					 */
					Debug.println("2:: in if of SHALLOW HAND PUMPS");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("OTHERS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					/*
					 * session.removeAttribute("headWorks");
					 * session.removeAttribute("pipeLine");
					 * session.removeAttribute("resorvior");
					 * session.removeAttribute("pumpsets");
					 */

					Debug.println("3::  in if of OTHERS");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("OPEN WELLS"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					session.removeAttribute("headWorks");
					session.removeAttribute("pipeLine");
					session.removeAttribute("resorvior");
					session.removeAttribute("pumpsets");

					Debug.println("4::  in if of OPEN WELLS");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				//@end

				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					Debug.println("5:: in getting source subcomponents");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				if (assetTypeName.trim().equalsIgnoreCase("HANDPUMPS")
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SOURCE")) {
					/*
					 * session.removeAttribute("headWorks");
					 * session.removeAttribute("pipeLine");
					 * session.removeAttribute("resorvior");
					 * session.removeAttribute("pumpsets");
					 */
					Debug.println("6:: in getting handpumps source");
					sources = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"HEADWORKS")) {
					Debug.println("7:: in getting headworks");
					headWorks = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"PIPELINE")) {
					Debug.println("8:: in getting pipeline");
					pipeLine = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& (labelValueBean.getLabel().trim().equalsIgnoreCase(
								"SR. RESERVOIRS") || labelValueBean.getLabel()
								.trim().equalsIgnoreCase("RESERVOIRS"))) {
					Debug.println("9:: in getting reservoirs");
					resorvior = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}

				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"OTHERS")) {
					Debug.println("10:: in getting others");
					pumpsets = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}
				if ((assetTypeName.trim().equalsIgnoreCase("PWS")
						|| assetTypeName.trim().equalsIgnoreCase("CPWS")
						|| assetTypeName.trim().equalsIgnoreCase("MPWS") || assetTypeName
						.trim().equalsIgnoreCase("DIRECT PUMPING"))
						&& labelValueBean.getLabel().trim().equalsIgnoreCase(
								"PUMPING")) {
					Debug.println("5.1:: in getting PUMPING subcomponents");
					pumping = RwsMasterData.getAssetSubComps(
							getDataSource(request), assetTypeCode,
							assetTypeName, labelValueBean.getValue(),
							assetCompName, habCode, pumpCode, opType);
				}

			}
			Debug.println("source size=" + sources.size() + "headworks size="
					+ headWorks.size() + "reservoirs size=" + resorvior.size()
					+ "pipeline size=" + pipeLine.size() + "pump sets size="
					+ pumpsets.size() + "pumping size=" + pumping.size());
			/*
			 * session.setAttribute("sources",sources);
			 * session.setAttribute("headWorks", headWorks);
			 * session.setAttribute("pipeLine", pipeLine);
			 * session.setAttribute("resorvior", resorvior);
			 * session.setAttribute("pumpsets", pumpsets);
			 */
			Debug.println("tempSelectedHabs size in getAssetSubComponents is "
					+ tempSelectedHabs.size());

			if (tempSelectedHabs.size() > 0) {
				assetForm.setAssetHabs((ArrayList) session
						.getAttribute("tempSelectedHabs"));
			} else {
				tempSelectedHabs = RwsMasterData.getAssetHabCodes(
						getDataSource(request), assetForm.getHabCode(),
						pumpCode, assetForm.getAssetTypeCode());
				assetForm.setAssetHabs(tempSelectedHabs);
				Debug
						.println("11:: tempSelectedHabs size in getAssetSubComponents in else is "
								+ tempSelectedHabs.size());
				session.setAttribute("tempSelectedHabs", new ArrayList(
						tempSelectedHabs));
			}

			if (assetTypeName.trim().equals("HANDPUMPS")) {
				Debug.println("2:: Sources size=" + sources.size());
				if (sources.size() > 0)
					session.setAttribute("sources", sources);

				/*
				 * session.removeAttribute("headWorks");
				 * session.removeAttribute("pipeLine");
				 * session.removeAttribute("resorvior");
				 * session.removeAttribute("pumpsets");
				 */
			} else {
				Debug.println("3:: else part Sources size=" + sources.size());
				session.setAttribute("sources", sources);
				//if (assetTypeName.trim().equals("MPWS") ||
				// assetTypeName.trim().equals("PWS"))
				//session.removeAttribute("headWorks");
				if (!(assetTypeName.trim()
						.equalsIgnoreCase("SHALLOW HAND PUMPS"))
						&& !(assetTypeName.trim().equalsIgnoreCase("OTHERS"))
						&& !(assetTypeName.trim()
								.equalsIgnoreCase("OPEN WELLS"))
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
			Debug
					.println("the error in rws_asstact_frm getsubcomponentsDetails=   "
							+ e);
		}
	}

	protected void subcomponentDetails(AssetForm assetForm,
			String assetTypeCode, HttpServletRequest request) throws Exception {
		RwsComplaintsMaster rwsMaster = new RwsComplaintsMaster();
		ArrayList assetSubComps = new ArrayList();
		ArrayList assetPipeLine = new ArrayList();
		ArrayList assetHeadWorks = new ArrayList();
		ArrayList assetReservior = new ArrayList();

		try {

			request.setAttribute("sourceParam", "sourceParam");
			ArrayList pwsSources = RwsMasterData.getAssetSubCompNames(
					assetTypeCode, "01", getDataSource(request));

			for (int i = 0; i < pwsSources.size(); i++) {
				rwsMaster = (RwsComplaintsMaster) pwsSources.get(i);
				assetSubComps.add(new Asset_SubComponent(rwsMaster
						.getAssetSubCompTypeName()));
			}
			assetForm.setAssetSubComponents(assetSubComps);

			request.setAttribute("headWorksParam", "headWorksParam");
			ArrayList pwsHeadWorks = RwsMasterData.getAssetSubCompNames(
					assetTypeCode, "02", getDataSource(request));

			for (int i = 0; i < pwsHeadWorks.size(); i++) {
				rwsMaster = (RwsComplaintsMaster) pwsHeadWorks.get(i);
				assetHeadWorks.add(new Asset_HeadWorks(rwsMaster
						.getAssetSubCompTypeName()));
			}
			assetForm.setAssetHeadWorks(assetHeadWorks);

			request.setAttribute("pipeLineParam", "pipeLineParam");
			ArrayList pwsPipeLine = RwsMasterData.getAssetSubCompNames(
					assetTypeCode, "03", getDataSource(request));

			for (int i = 0; i < pwsPipeLine.size(); i++) {
				rwsMaster = (RwsComplaintsMaster) pwsPipeLine.get(i);
				assetPipeLine.add(new Asset_PipeLine(rwsMaster
						.getAssetSubCompTypeName()));
			}
			assetForm.setAssetPipeLine(assetPipeLine);

			request.setAttribute("resorviorsParam", "resorviorsParam");
			ArrayList pwsReservior = RwsMasterData.getAssetSubCompNames(
					assetTypeCode, "04", getDataSource(request));

			for (int i = 0; i < pwsReservior.size(); i++) {
				rwsMaster = (RwsComplaintsMaster) pwsReservior.get(i);
				assetReservior.add(new Asset_Reservior(rwsMaster
						.getAssetSubCompTypeName()));
			}
			assetForm.setAssetReservior(assetReservior);

		} catch (Exception e) {
			Debug
					.println("the error in rws_asstact_frm getsubcomponentsDetails=   "
							+ e);
		}
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.gc();
		String mode = null;
		try {

			//vars copied from class
			//common code0
			Debug.println("in execute method()");
			ArrayList circles = null;
			ArrayList divisions = null;
			ArrayList subdivisions = null;
			ArrayList mandals = null;
			ArrayList panchyats = new ArrayList();
			ArrayList villages = new ArrayList();
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

			RwsComplaintsMaster rwsMaster = new RwsComplaintsMaster();
			RwsMasterData rwsMatserData = new RwsMasterData();
			RwsMasterData.connCount--;
			AssetForm assetForm = (AssetForm) form;
			String headOfficeCode = assetForm.getHeadOfficeCode();
			String circleOfficeCode = assetForm.getCircleOfficeCode();
			String divisionOfficeCode = assetForm.getDivisionOfficeCode();
			String subdivisionOfficeCode = assetForm.getSubdivisionOfficeCode();
			String assetCode = null;

			String assetSubCompCode = "";
			Debug.println("CircleOffice Code" + circleOfficeCode);

			HttpSession session = request.getSession();
			RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			Debug.println("user:" + user);
			session = request.getSession();
			if (user == null || session == null)
				return mapping.findForward("expire");

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
			Debug.println("Mode at execute Start:" + mode);
			typeOfAssetCode = request.getParameter("assetTypeCode");
			assetCompTypeCode = request.getParameter("assetCompTypeCode");
			assetSubCompTypeCode = request.getParameter("assetSubCompTypeCode");
			returnVal = request.getParameter("returnVal");
			if (returnVal != null) {
				session.setAttribute("returnVal", returnVal);//this code is for
															 // adding
															 // conditions in
															 // the Water Sample
															 // Collection Form
			}
			Debug.println("return Value %%%%%%%%  " + returnVal);
			Debug.println("user value:" + user);
			Debug.println("user.getCircleOfficeCode:"
					+ user.getCircleOfficeCode());
			if (request.getParameter("assetSubCompTypeCode") != null)
				assetSubCompCode = (String) request
						.getParameter("assetSubCompTypeCode");
			if (headOfficeCode == null) {
				headOfficeCode = user.getHeadOfficeCode();
			}
			if (circleOfficeCode == null
					|| (circleOfficeCode != null && circleOfficeCode.equals(""))) {
				circleOfficeCode = user.getCircleOfficeCode();
				Debug.println("saduq------  " + circleOfficeCode);
			}
			Debug.println("CircleOfficeCode:" + circleOfficeCode);
			if (divisionOfficeCode == null) {
				divisionOfficeCode = user.getDivisionOfficeCode();
			}
			if (subdivisionOfficeCode == null
					|| subdivisionOfficeCode.equals("")) {
				subdivisionOfficeCode = user.getSubdivisionOfficeCode();
			}

			//@code1 this code sets drop downs depending on login id
			if (mode != null && mode.equals("mode")) {
				Debug.println("in test mode_______________________");
			}
			if (mode != null && mode.equals("init")) {

				try {
					//Debug.println("%%%%%%%%%@@@@@@@@@ returnVal
					// "+(returnVal==null));
					request
							.setAttribute("message",
									"You cannot Enter the Assets which are Created on (or) after 01.04.2009");
					if (incval == 1) {
						if (returnVal == null) {
							assetForm.setCircleOfficeCode("");
							assetForm.setDivisionOfficeCode("");
							assetForm.setSubdivisionOfficeCode("");
							assetForm.setDistrict("");
							//session.setAttribute("distName","");
							assetForm.setMandal("");
							assetForm.setHabCode("");
							assetForm.setHabName("");
							assetForm.setRemarks("");
							assetForm.setDpYield("");
							incval++;
						}
					}
					Debug.println("in init mode Hab_code");
					Debug.println("CircleOfficeCode:" + circleOfficeCode);
					if (circleOfficeCode.equals("00")) {
						Debug.println("it in this");
						circles = rwsOffices.getCircles(headOfficeCode);
						divisions = null;
						subdivisions = null;
						session.removeAttribute("divisions");
						session.removeAttribute("subdivisions");
					}
					Debug.println("CircleOfficeCode:" + circleOfficeCode);
					if (circleOfficeCode != null
							&& !circleOfficeCode.equals("00")
							&& !circleOfficeCode.equals("")
							&& divisionOfficeCode.equals("0")
							&& !mode.equals("divisions")) {
						divisions = rwsOffices.getDivisions(headOfficeCode,
								circleOfficeCode);
					}
					if (!circleOfficeCode.equals("00")
							&& !divisionOfficeCode.equals("0")
							&& subdivisionOfficeCode.equals("00"))
						subdivisions = rwsOffices.getSubdivisions(
								headOfficeCode, circleOfficeCode,
								divisionOfficeCode);

					if (divisionOfficeCode != null
							&& !divisionOfficeCode.equals("0")
							&& !divisionOfficeCode.equals("")) {
						subdivs = rwsOffices.getSubdivisions(headOfficeCode,
								circleOfficeCode, divisionOfficeCode);
					}
					if (subdivisionOfficeCode != null
							&& !subdivisionOfficeCode.equals("00")
							&& !subdivisionOfficeCode.equals("")) {
						mandals = RwsMasterData.getsubdivisionmandals(
								circleOfficeCode, divisionOfficeCode,
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

					//session.setAttribute("dists",dists);
					//end of @code1
					Debug.println("circleOfficeCode:" + circleOfficeCode);
					Debug.println("returnVal:" + returnVal);
					Debug
							.println("sssssssssss:"
									+ (circleOfficeCode != null
											&& !circleOfficeCode.equals("00")
											&& !circleOfficeCode.equals("") && returnVal != null));
					if (circleOfficeCode != null
							&& !circleOfficeCode.equals("00")
							&& !circleOfficeCode.equals(""))// &&
															// returnVal!=null)
					{
						Debug.println("calling distName");
						session.setAttribute("distName", RwsMasterData
								.getDistName(getDataSource(request),
										circleOfficeCode));

						//request.setAttribute("distName",rwsLocation.getDname(circleOfficeCode));
						assetForm.setDcode(circleOfficeCode);
					} else {
						session.setAttribute("distName", "");

					}
					if (circleOfficeCode != null && divisionOfficeCode != null
							&& subdivisionOfficeCode != null) {
						assetTypes = commonLists.getAssetTypes();
						session.setAttribute("assetTypes", assetTypes);
					} else {
						session.removeAttribute("assetTypes");
					}
					//Debug.println("after:"+((ArrayList)session.getAttribute("assetTypes")).size());

					/*
					 * if(session.getAttribute("subdivisions")==null)
					 * session.setAttribute("subdivisions",new ArrayList());
					 * if(session.getAttribute("mandals")==null)
					 * session.setAttribute("mandals",new ArrayList());
					 * if(session.getAttribute("prhabs")==null)
					 * session.setAttribute("prhabs",new ArrayList());
					 * if(session.getAttribute("assetTypes")==null){
					 * Debug.println("in null asset types");
					 * session.setAttribute("assetTypes",new ArrayList()); }
					 * 
					 * if(session.getAttribute("schemeCodes")==null)
					 * session.setAttribute("schemeCodes",new ArrayList());
					 */

					Debug.println("return mode " + mode);
					Debug.println("subdivisions is "
							+ session.getAttribute("subdivisions"));
				} catch (Exception e) {
					Debug.println("Exception in init mode is " + e);
				}

				return mapping.findForward(mode);
			}

			//code added by vikas for Add Sources Button in Water Sample
			// Collection Form 150109
			if (mode != null && mode.equals("water")) {
				try {
					Debug.println("in init mode Hab_code"
							+ request.getParameter("habCode"));
					if (circleOfficeCode.equals("00")) {
						Debug.println("it in thsi");
						circles = rwsOffices.getCircles(headOfficeCode);
						divisions = null;
						subdivisions = null;
						session.removeAttribute("divisions");
						session.removeAttribute("subdivisions");
					}
					if (circleOfficeCode != null
							&& !circleOfficeCode.equals("00")
							&& !circleOfficeCode.equals("")
							&& divisionOfficeCode.equals("0")
							&& !mode.equals("divisions")) {
						divisions = rwsOffices.getDivisions(headOfficeCode,
								circleOfficeCode);
					}
					if (!circleOfficeCode.equals("00")
							&& !divisionOfficeCode.equals("0")
							&& subdivisionOfficeCode.equals("00")) {
						subdivisions = rwsOffices.getSubdivisions(
								headOfficeCode, circleOfficeCode,
								divisionOfficeCode);
					}
					if (divisionOfficeCode != null
							&& !divisionOfficeCode.equals("0")
							&& !divisionOfficeCode.equals("")) {
						subdivs = rwsOffices.getSubdivisions(headOfficeCode,
								circleOfficeCode, divisionOfficeCode);
					}
					if (subdivisionOfficeCode != null
							&& !subdivisionOfficeCode.equals("00")
							&& !subdivisionOfficeCode.equals("")) {
						mandals = RwsMasterData.getsubdivisionmandals(
								circleOfficeCode, divisionOfficeCode,
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

					if (circleOfficeCode != null
							&& !circleOfficeCode.equals("00")
							&& !circleOfficeCode.equals("")) {
						Debug.println("calling distName");
						session.setAttribute("distName", RwsMasterData
								.getDistName(getDataSource(request),
										circleOfficeCode));

						//request.setAttribute("distName",rwsLocation.getDname(circleOfficeCode));
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

					Debug.println("return mode " + mode);
					Debug.println("mandals is "
							+ session.getAttribute("mandals"));
				} catch (Exception e) {
					Debug.println("Exception in init mode is " + e);
				}
				return mapping.findForward(mode);
			}
			//end of code added

			//end of common code 1
			if (mode != null && mode.equals("circles")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circles = rwsOffices.getCircles(headOfficeCode);
				assetForm.setCircleOfficeCode("00");
				assetForm.setDivisionOfficeCode("0");
				assetForm.setSubdivisionOfficeCode("00");
				//clearing arrayLists
				session.setAttribute("divisions", new ArrayList());
				session.setAttribute("subdivisions", new ArrayList());
				session.setAttribute("mandals", new ArrayList());
				session.setAttribute("prhabs", new ArrayList());
				//end
				session.setAttribute("circles", circles);
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);

			}

			if (mode != null && mode.equals("divisions")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circleOfficeCode = assetForm.getCircleOfficeCode();
				divisions = rwsOffices.getDivisions(headOfficeCode,
						circleOfficeCode);

				assetForm.setDivisionOfficeCode("0");
				assetForm.setSubdivisionOfficeCode("00");

				session.setAttribute("subdivisions", new ArrayList());
				session.setAttribute("mandals", new ArrayList());
				session.setAttribute("prhabs", new ArrayList());

				session.setAttribute("divisions", divisions);
				session.setAttribute("distName", RwsMasterData.getDistName(
						getDataSource(request), circleOfficeCode));
				assetForm.setDistrict(RwsMasterData.getDistName(
						getDataSource(request), circleOfficeCode));
				assetForm.setDcode(circleOfficeCode);
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);

			}
			if (mode != null && mode.equals("subdivisions")) {
				headOfficeCode = assetForm.getHeadOfficeCode();
				circleOfficeCode = assetForm.getCircleOfficeCode();
				divisionOfficeCode = assetForm.getDivisionOfficeCode();
				assetForm.setSubdivisionOfficeCode("00");
				subdivisions = rwsOffices.getSubdivisions(headOfficeCode,
						circleOfficeCode, divisionOfficeCode);
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
				mandals = RwsMasterData.getsubdivisionmandals(circleOfficeCode,
						divisionOfficeCode, subdivisionOfficeCode,
						getDataSource(request));
				session.setAttribute("mandals", mandals);
				Debug
						.println("mandals Size "
								+ session.getAttribute("mandals"));

				session.setAttribute("prhabs", new ArrayList());
				assetForm.reset(mapping, request);
				return mapping.findForward(mode);

			}
			if (mode != null && mode.equals("prhabs")) {
				if (assetForm.getMandal() != null
						&& !assetForm.getMandal().equals("")) {
					prhabs = rwsLocation.getMandalHabitations(assetForm
							.getCircleOfficeCode(), assetForm.getMandal());
					session.setAttribute("prhabs", prhabs);
					assetForm.reset(mapping, request);
					return mapping.findForward(mode);
				}
			}

			//common code2
			Debug.println("circles and others set to session");
			//	end of common code2

			Debug.println("assetTypeCode=" + typeOfAssetCode);
			Debug.println("assetCompTypeCode=" + assetCompTypeCode);
			Debug.println("assetSubCompTypeCode=" + assetSubCompTypeCode);
			Debug.println("&&&&&&&&&&&&& countTmp is" + countTmp++);
			Debug.println("in execute method of rwsAssetAct_from 361");
			Debug.println("asset type code is "
					+ request.getParameter("assetTypeCode"));
			Debug.println("mode in rws_asset_frm is   " + mode);

			//temp code

			if (assetForm.getSourceHabs() != null) {
				ArrayList checkHabsTmp = (ArrayList) assetForm.getSourceHabs();
				Debug.println("checkHabsTmp.size() is " + checkHabsTmp.size());
			}
			//end of temp code
			//below line is newly commented
			//String mode = assetForm.getMode();
			Debug.println("assetForm mode is " + assetForm.getMode());
			Debug.println("mode in request is "
					+ (String) request.getParameter("mode"));
			mode = (String) request.getParameter("mode");

			//end of common code0

			if (mode != null && mode.equalsIgnoreCase("pickpipemat")) {
				Debug.println(" mode in pickpipemat" + mode);
				String code = request.getParameter("code");
				String NoOfPipes = request.getParameter("disNoOfPipes");
				Debug.println("no of pipes is  " + NoOfPipes);
				Debug.println("code in pickpipemat mode is " + code);
				if (request.getParameter("code") != null)
					session.setAttribute("code", request.getParameter("code"));

				int ndx = 0;

				try {

					if (request.getParameter("disNoOfPipes") != null)
						session.setAttribute("NoOfPipes", request
								.getParameter("disNoOfPipes"));
					Debug.println("setting assetsubCompParams");
					session.setAttribute("assetsubCompParams", "pickpipemat");
					ArrayList params = RwsMasterData.getPipeMaterialList(
							getDataSource(request), (String) session
									.getAttribute("code"));
					Debug.println("size of params returned from rws master is "
							+ params.size());
					params = fillPipeLine(params, getDataSource(request));
					Debug.println("size of params is " + params.size());
					assetForm.setAssetPipeLine(params);

					return mapping.findForward("pickpipemat");
				} catch (Exception e) {
					Debug.println("error in pipeclass mode is " + e);
				}
				return mapping.findForward("pickpipemat");
			}

			if (mode != null && mode.equalsIgnoreCase("addNewPipeType")) {
				try {

					Debug.println("in addNewPipeType");
					pipeMaterial = commonLists.getPipeMatirals();
					assetForm.setPipeMaterial(pipeMaterial);
					Debug.println("code is " + session.getAttribute("code"));
					String code = (String) request.getParameter("code");
					assetsubCompParams.clear();
					//int
					// index=Integer.parseInt((String)request.getParameter("index"));
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPipeLine();
					Debug.println("calling fillPipeLine");
					assetsubCompParams = fillPipeLine(assetsubCompParams,
							getDataSource(request));
					Debug.println("returned from fillPipeLine");
					assetForm.setAssetPipeLine(assetsubCompParams);

					if (request.getParameter("materialChanged") == null) {
						Debug.println("materialChanged==null");
						Debug
								.println("size of assetsusbCompParams is before adding"
										+ assetsubCompParams.size());
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
					Debug.println("size of assetsusbCompParams is after adding"
							+ assetsubCompParams.size());
					Debug.println("returning to pickpipemat");
					return mapping.findForward("pickpipemat");

				} catch (Exception e) {
					Debug.println("error in addNewPipeType" + e);
				}
				return mapping.findForward("pickpipemat");
			}

			if (mode != null && mode.equalsIgnoreCase("removePipeTypes")) {
				Debug.println("endter record deleted");
				try {
					assetsubCompTempParams = new ArrayList();
					Debug.println("code is " + session.getAttribute("code"));
					int rowCount = 0;
					assetsubCompTempParams.clear();
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPipeLine();

					String[] removeIds = request.getParameterValues("remove");
					Debug.println("size of assetsubCompParams is  "
							+ assetsubCompParams.size());
					Debug.println("remove ids length is  " + removeIds.length);
					if (removeIds != null && removeIds.length != 0) {
						int x = 0;
						for (int p = removeIds.length; p > 0; p--) {
							x = Integer.parseInt(removeIds[p - 1]);
							Debug.println("XXXXXXX   is " + x);
							Debug.println("removeIds[" + p + "] : "
									+ removeIds[p - 1]);
							assetsubCompTempParams.add(assetsubCompParams
									.get(x));
							assetsubCompParams.remove(x);
						}
					}
					assetsubCompParams = fillPipeLine(assetsubCompParams,
							getDataSource(request));
					assetForm.setAssetPipeLine(assetsubCompParams);
					Debug.println("remove ids length is  " + removeIds.length);
					int size = assetsubCompParams.size();
					Debug.println("size=" + size);

					rowCount = RwsMasterData.removeAssetSubCompPipeTypes(
							getDataSource(request), assetsubCompTempParams,
							(String) session.getAttribute("code"));
					Debug.println("rowCount  value " + rowCount);

					if (rowCount > 0) {
						message = "Record(s) Deleted";
						Debug.println("record Deleted");
					} else {

						//message = "The Record(s) Cant be Deleted";
						Debug.println("  not Deleted");
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug
							.println("error in remove subcomp (in act.java)  "
									+ e);

				}
				return mapping.findForward("pickpipemat");
			}

			if (mode.equalsIgnoreCase("pickhab")) {
				Debug.println("in pickhab mode");
				try {

					String schemeCode = (String) request
							.getParameter("schemeCode");
					SubCompMetaData subCompMetaData = new SubCompMetaData(
							schemeCode);
					Debug.println("asset code:"
							+ request.getParameter("assetCode"));
					request
							.setAttribute("baseHab", schemeCode
									.substring(0, 16));

					//session.removeAttribute("tempSelectedHabs");
					ArrayList sourceHabs = new ArrayList();
					ArrayList HabSources = new ArrayList();
					rwsMaster = new RwsComplaintsMaster();
					//Debug.println("dcode="+request.getParameter("district")+"mcode="+request.getParameter("mandal"));
					//HabSources=RwsMasterData.getHabAsSources(schemeCode.substring(0,2),schemeCode.substring(5,7),getDataSource(request));
					HabSources = RwsMasterData.getHabAsSourcesForReservoirs(
							getDataSource(request), schemeCode, request
									.getParameter("assetCode"));

					for (int i = 0; i < HabSources.size(); i++) {
						rwsMaster = (RwsComplaintsMaster) HabSources.get(i);
						sourceHabs.add(new HabSourceBean(
								rwsMaster.getHabCode(), rwsMaster
										.getPanchRajCode(), rwsMaster
										.getPanchRajName(), rwsMaster
										.getTotalPop(), rwsMaster
										.getCoveredStatus(), rwsMaster
										.isSaved()));
					}
					Debug.println("sourcehabs length is " + sourceHabs.size());
					for (int i = 0; i < sourceHabs.size(); i++) {
						Debug.println("HabCode for "
								+ i
								+ "is "
								+ ((HabSourceBean) sourceHabs.get(i))
										.getHabCode());
					}
					assetForm.setSourceHabs(new ArrayList(sourceHabs));

					for (int i = 0; i < sourceHabs.size(); i++) {
						HabSourceBean habSourceBeanTmp = new HabSourceBean();
						habSourceBeanTmp = (HabSourceBean) sourceHabs.get(i);
						Debug.println("checkHabs checkBox[" + i + "] is "
								+ habSourceBeanTmp.getHabCode()
								+ " and isSaved is "
								+ habSourceBeanTmp.isSaved()
								+ " and isChecked is "
								+ habSourceBeanTmp.getIsChecked());
					}
					request.setAttribute("sourceHabs", sourceHabs);

				} catch (Exception e) {
					Debug.println("" + e);
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("AddHab")) {
				Debug.println("in AddHad mode");
				ArrayList checkHabs = new ArrayList();

				String assetTypeCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request
						.getParameter("assetSubCompTypeCode");
				String schemeCode = request.getParameter("schemeCode");
				/*
				 * String noOfHab = request.getParameter("noOfHab");
				 * Debug.println("noOfHab:"+noOfHab); String index =
				 * request.getParameter("index"); Debug.println("index:"+index);
				 * ArrayList bb =
				 * (ArrayList)session.getAttribute("assetReserviorOhsr");
				 * Asset_Reservior
				 * assetHw=(Asset_Reservior)bb.get(Integer.parseInt(index));
				 * Debug.println("capacity:"+assetHw.getOhsrCapacityLts());
				 * assetHw.setNoOfHab(noOfHab); ArrayList aa = new ArrayList();
				 * aa.add(assetHw); Debug.println("No fo
				 * Habs:"+assetHw.getNoOfHab()); //
				 * session.setAttribute("assetReserviorOhsr",new
				 * ArrayList(assetsubCompParams));
				 * assetForm.setAssetReservior(aa);
				 */

				Debug.println("in addHab mode");
				try {
					HabSourceBean habSourceBean = new HabSourceBean();

					checkHabs = (ArrayList) assetForm.getSourceHabs();
					Debug.println("checkHabs size is " + checkHabs.size());
					request.setAttribute("ohsrHabCount", "" + checkHabs.size());
					//				
					//@temp code delete this.
					int checkHabsCount = 0;
					for (int i = 0; i < checkHabs.size(); i++) {
						HabSourceBean habSourceBeanTmp = new HabSourceBean();
						habSourceBeanTmp = (HabSourceBean) checkHabs.get(i);
						if (habSourceBeanTmp.getIsChecked().equals("true")) {
							checkHabsCount++;
							Debug.println("checkHabs checkBox[" + i + "] is "
									+ habSourceBeanTmp.getHabCode()
									+ " and isSaved is "
									+ habSourceBeanTmp.isSaved()
									+ " and isChecked is "
									+ habSourceBeanTmp.getIsChecked());
						}

					}
					request.setAttribute("checkHabsCount", "" + checkHabsCount);

					//code added on 090207
					ArrayList asset_reservoirList = (ArrayList) session
							.getAttribute("assetReserviorOhsr");
					Debug.println("calling insertHabLink");
					Debug.println("schemeCode in addHab is " + schemeCode);
					RwsMasterData.insertHabLink2(getDataSource(request),
							"RWS_OHGLCI_HAB_LINK_TBL", checkHabs, schemeCode);
					//end of code

				} catch (Exception e) {
					Debug.println("the error in rws_source_frm checks= " + e);
				}

				return mapping.findForward("close");
			}

			//added by ramesh on 270110 to modify the add/remove habs

			if (mode.equals("getDists")) {
				RwsLocations rwsLocations = new RwsLocations(
						getDataSource(request));
				ArrayList distss = rwsLocations.getDistricts();
				Debug.println("distss size:" + distss.size());
				session.setAttribute("dists", distss);
				mode = "habLink";
				ArrayList assetdists = RwsMasterData.getAssetDists(request
						.getParameter("assetCode"));
				if (assetdists == null
						|| (assetdists != null && assetdists.size() == 0)) {
					Debug.println("in this");
					assetdists.add(0, assetForm.getCircleOfficeCode());
				}
				request.setAttribute("assetdists", assetdists);
				return mapping.findForward(mode);
			}
			if (mode.equals("carryHabs")) {
				try {
					/*
					 * String habitationss = request.getParameter("habs");
					 * String[] habsarray={}; int lengthHab = 0;
					 * if(habitationss!=null) {
					 * habsarray=habitationss.split(","); }
					 */
					String[] habsarray = request.getParameterValues("habs");
					RwsComplaintsMaster rm = null;
					tempSelectedHabs = new ArrayList();
					tempSelectedHabs = (ArrayList) session
							.getAttribute("tempSelectedHabs");
					Debug.println("mandal:" + assetForm.getMandal());
					Debug.println("mandal name:" + assetForm.getMandalName());

					Debug.println("Before1:" + tempSelectedHabs.size());
					/*
					 * for (int i = 0; i < tempSelectedHabs.size(); i++) { rm =
					 * (RwsMaster)tempSelectedHabs.get(i);
					 * Debug.println("I:"+i+":"+rm.getHabCode()); }
					 */
					Debug.println("tempSelectedHabs.get(0):"
							+ tempSelectedHabs.get(0));
					//ArrayList removeTempSelectedHabs =
					// removeTempSelectedHabs(tempSelectedHabs,assetForm.getMandal());
					ArrayList removeTempSelectedHabs = new ArrayList();
					//tempSelectedHabs.clear();
					//tempSelectedHabs = removeTempSelectedHabs;
					Debug.println("Before2:" + removeTempSelectedHabs.size());
					for (int i = 0; i < habsarray.length; i++) {
						//panchRaj = (PanchRaj) checkedHabs.get(i);
						//if (panchRaj.getHabitation() != null) {
						//	if (panchRaj.getHabitation().equalsIgnoreCase("on"))
						// {
						//if(!removeTempSelectedHabs.contains(panchRaj.getHabCode()))
						//{
						rm = new RwsComplaintsMaster();
						rm.setHabCode(habsarray[i]);
						removeTempSelectedHabs.add(rm);
						//	}
						//}
						//}
					}
					Debug.println("After:" + removeTempSelectedHabs.size());
					for (int i = 0; i < removeTempSelectedHabs.size(); i++) {
						rm = (RwsComplaintsMaster) removeTempSelectedHabs.get(i);
						Debug.println("I:" + i + ":" + rm.getHabCode());
					}
					Debug.println("tempSelectedHabs.size()="
							+ removeTempSelectedHabs.size());
					//session.setAttribute("habs", checkedHabs);
					session.setAttribute("tempSelectedHabs",
							removeTempSelectedHabs);
					session.setAttribute("assetHabs", removeTempSelectedHabs);
					request
							.setAttribute(
									"message",
									"Selected Habitations temporarily Added Successfully and Click on SAVE Button to add permanently");
					return mapping.findForward("close4");
				} catch (Exception ee) {
					ee.printStackTrace();
				}

			}

			//common code 1

			/*
			 * this part of the code is executed when add & view habitations
			 * button is pressed in asset entry from this block creates
			 * arraylist prhabs which contains mandals in the session and
			 * assigns to the asset form. It also creates arraylist selectedHabs
			 * and adds to session in the name of
			 * tempSelectedHabs.tempSelectedHabs contains habitations linked
			 * with the asset feteched from database. This block also sets base
			 * habitation (fetched from request parameter) to request in the
			 * name of baseHabitation .
			 */
			if (mode.equals("hab")) {
				try {

					Debug.println("in hab mode" + assetForm.getHabName()
							+ assetForm.getHabCode());
					dists = rwsLocation.getDistricts();

					String assetTypeCode = request
							.getParameter("assetTypeCode");
					if (assetTypeCode == null)
						assetTypeCode = "";

					//handpumps does not contain habitation linkage hence the
					// code from habitation linkage is excluded for assetType 04
					if (assetTypeCode.equals("04")) {
						prhabs = RwsMasterData.getAssetHabitations(request
								.getParameter("habCode"),
								getDataSource(request));
						Debug.println("prhabs.size()=" + prhabs.size());
						assetForm.setAssetHabs(prhabs);

						assetForm.setMandal(RwsMasterData
								.getMandalName(request.getParameter("dcode"),
										request.getParameter("mandal"),
										getDataSource(request),RwsOffices.getConn()));

						session.removeAttribute("mandals");
						session.setAttribute("mandal", request
								.getParameter("mandal"));
					} else {
						session.removeAttribute("mandal");

						if (request.getParameter("dcode") != null
								&& request.getParameter("dcode").length() != 0) {

							Debug.println("in dcode "
									+ request.getParameter("dcode").length());
							mandals = rwsLocation.getMandals(request
									.getParameter("dcode"));

						}
						if (request.getParameter("mandal") != null
								&& request.getParameter("mandal").length() != 0) {

							Debug.println("in mandal "
									+ request.getParameter("mandal").length());
							prhabs = RwsMasterData.getAssetHabs(
									getDataSource(request), request
											.getParameter("dcode"), request
											.getParameter("mandal"));
							Debug.println("prhabs.size()=" + prhabs.size());
							assetForm.setAssetHabs(prhabs);
							assetForm.setMandal(request.getParameter("mandal"));

						}
						session.setAttribute("district", request
								.getParameter("dcode"));
						session.setAttribute("dists", dists);
						session.setAttribute("mandals", mandals);
						ArrayList selectedHabs = RwsMasterData
								.getSelectedHabitationLinkageForAsset(
										getDataSource(request),
										(String) session
												.getAttribute("assetCode"));

						//code to set base habitaiton in request
						Debug.println("baseHabitation is"
								+ request.getParameter("habCode"));
						if (request.getParameter("habCode") != null)
							request.setAttribute("baseHabitation", request
									.getParameter("habCode"));
						//end of code
						session.setAttribute("tempSelectedHabs", selectedHabs);
						Debug.println("selected habs size is "
								+ selectedHabs.size());
					}

				} catch (Exception e) {
					Debug.println("error in hab mode is " + e.getMessage());
				}
				return mapping.findForward(mode);//to be seen whether this line
												 // be commented or not
			}

			if (mode.equals("disp")) {
				Debug.println("in disp mode");
				try {
					Debug.println("hab len="
							+ ((ArrayList) session
									.getAttribute("tempSelectedHabs")).size());
					if (((ArrayList) session.getAttribute("tempSelectedHabs"))
							.size() > 0)
						assetForm.setAssetHabs((ArrayList) session
								.getAttribute("tempSelectedHabs"));
					if (request.getParameter("assetCompTypeCode") != null) {
						if ((request.getParameter("assetCompTypeCode"))
								.length() != 0) {

							assetsubCompTypes = commonLists
									.getAssetSubComponents(
											request
													.getParameter("typeOfAssetCode"),
											request
													.getParameter("assetCompTypeCode"));
						}
					}
					session
							.setAttribute("assetSubCompTypes",
									assetsubCompTypes);

					if (request.getParameter("typeOfAssetCode") != null) {
						if (request.getParameter("typeOfAssetCode")
								.equalsIgnoreCase("01")) {

							subcomponentDetails(assetForm, request
									.getParameter("typeOfAssetCode"), request);
						} else if (request.getParameter("typeOfAssetCode")
								.equalsIgnoreCase("02")) {
							subcomponentDetails(assetForm, request
									.getParameter("typeOfAssetCode"), request);
						} else if (request.getParameter("typeOfAssetCode")
								.equalsIgnoreCase("03")) {
							subcomponentDetails(assetForm, request
									.getParameter("typeOfAssetCode"), request);

						} else if (request.getParameter("typeOfAssetCode")
								.equalsIgnoreCase("04")) {
							request.setAttribute("sourceParam", "sourceParam");
							ArrayList pwsSources = RwsMasterData
									.getAssetSubCompNames(request
											.getParameter("typeOfAssetCode"),
											"01", getDataSource(request));
							for (int i = 0; i < pwsSources.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) pwsSources.get(i);
								assetSubComps.add(new Asset_SubComponent(
										rwsMaster.getAssetSubCompTypeName()));
							}
							assetForm.setAssetSubComponents(assetSubComps);
						}
					}

				} catch (Exception e) {
					Debug.println(e.getMessage());
				}
			}

			//????????????????
			if (mode.equalsIgnoreCase("ShowHabsBenfit")) {
				Debug.println("in showHabsBenfit mode");

				message = saveAsset(assetForm, request);
				request.setAttribute("message", message);
				/*
				 * try {
				 * 
				 * 
				 * rwsMaster.setAssetCode(assetForm.getAssetCode()); ArrayList
				 * tothab = new ArrayList(); tothab =
				 * (ArrayList)session.getAttribute("assetHabs");
				 * if(tothab.size()>0) {
				 * 
				 * RwsMasterData.insertAssetHab(rwsMaster,
				 * tothab,getDataSource(request)); } Debug.println("in
				 * ShowHabsBenfit");
				 * 
				 * }catch(Exception e){}
				 */
				mode = "data";
			}

			/*
			 * if(mode!=null && mode.equalsIgnoreCase("data")&&
			 * request.getParameter("component")!=null &&
			 * request.getParameter("component").equals("assetTypeCodeChanged")) {
			 * Debug.println("opType set to modify");
			 * assetForm.setOpType("notSelected");
			 * session.setAttribute("schemeCodes", new ArrayList());
			 * 
			 * assetForm.setAssetName(""); assetForm.setLocation("");
			 * assetForm.setAssetStatus(""); assetForm.setStartYear("");
			 * assetForm.setDateofCreation(""); assetForm.setAssetCost("");
			 * assetForm.setTotHabs(0); assetForm.setTotPopBenfit(0);
			 * session.setAttribute("opType", "notSelected"); return
			 * mapping.findForward(mode);
			 *  }
			 */
			if (mode != null && mode.equalsIgnoreCase("assetTypeCodeChanged")) {
				Debug.println("opType set to modify");
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

			//

			if (mode != null && mode.equalsIgnoreCase("opMissingCodes")) {

				Debug.println("in opMissingCodes mode");
				ArrayList missingCodes = RwsMasterData.getMissingCodes(
						getDataSource(request), request
								.getParameter("assetTypeCode"), request
								.getParameter("habCode"));
				request.setAttribute("missingCodes", missingCodes);
				Debug.println("missingCodes are");
				for (int i = 0; i < missingCodes.size(); i++) {
					Debug.println(missingCodes.get(i) + "");
				}
				return mapping.findForward(mode);
			}
			if (mode != null && mode.equalsIgnoreCase("opAddNew")) {

				Debug.println("in opAddNew mode");
				Debug.println("AssetType Name "
						+ request.getParameter("assetTypeCode"));
				assetTypeName = RwsMasterData.getAssetTypeName(request
						.getParameter("assetTypeCode"), getDataSource(request));
				pumpCode = commonLists.getPumpCode(request
						.getParameter("assetTypeCode"), assetTypeName, request
						.getParameter("habCode"));
				Debug.println("pumpCode is " + pumpCode);
				session.setAttribute("opType", "Add New");
				assetForm.setPumpCode(pumpCode);
				assetForm.setDpYield("");
				getAssetSubComponents(assetForm, request, pumpCode);
				assetCode = getNewAssetCode(request, circleOfficeCode,
						divisionOfficeCode, subdivisionOfficeCode, request
								.getParameter("habCode"), request
								.getParameter("assetTypeCode"));
				
				
				//added by sai prasad N
				
				if (assetCode.length() > 14) {
					int len = assetCode.length() - 14;
					assetCode = assetCode.substring(len, assetCode.length());
				
				}
				/////////////////////////////

				Debug.println("assetCode afterReturning from function is"
						+ assetCode);

				Debug.println("asset Code=" + assetCode);
				Debug.println("next new assetCode in session is " + assetCode);
				Debug.println("dcode is " + request.getParameter("dcode"));
				Debug.println("assetTypeCode is RAMESH:"
						+ request.getParameter("assetTypeCode"));
				if (request.getParameter("assetTypeCode").equals("02")) {
					if (Integer.parseInt(pumpCode) > 450) {
						request.setAttribute("message",
								"MPWS Asset Range Not exceed 450");
						assetForm.setPumpCode("");
						pumpCode = "";
					}
				}
				if (request.getParameter("assetTypeCode").equals("09")) {
					if (Integer.parseInt(pumpCode) > 499) {
						request.setAttribute("message",
								"DIRECT PUMPING Asset Range Not exceed 450");
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
				if (assetForm.getPumpCode() == null
						|| assetForm.getPumpCode().equals("")) {
					assetForm.setPumpCode((String) request
							.getAttribute("pumpCode"));
					Debug.println("pumpCode taken from request");

				}
				if (assetForm.getPumpCode() != null) {
					Debug
							.println("shortSchemeCode in data mode is set to session "
									+ assetForm.getPumpCode());
					session.setAttribute("shortSchemeCode", assetForm
							.getPumpCode());
				}
				try {

					schemeCodes = commonLists.getSchemeCodes(request
							.getParameter("assetTypeCode"), request
							.getParameter("habCode"));
					session.setAttribute("schemeCodes", schemeCodes);

					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);

					//selected district,mandal,panchayat,village,habitationCode
					// in asset entry form are set to session
					String dcode = RwsMasterData.getDcode(
							getDataSource(request), assetForm.getDistrict());
					session.setAttribute("districtNameInAssetEntryForm",
							assetForm.getDistrict());
					session.setAttribute("districtInAssetEntryForm", assetForm
							.getCircleOfficeCode());
					session.setAttribute("mandalInAssetEntryForm", assetForm
							.getMandal());
					session.setAttribute("panchayatInAssetEntryForm",
							(String) request.getParameter("pcode"));
					session.setAttribute("villageInAssetEntryForm",
							(String) request.getParameter("vcode"));
					session.setAttribute("habCodeInAssetEntryForm", assetForm
							.getHabCode());
					session.setAttribute("shortSchemeCodeInAssetEntryForm",
							assetForm.getPumpCode());
					//if (request.getParameter("coc") != null &&
					// request.getParameter("doc") != null &&
					// request.getParameter("sdoc") != null &&
					// request.getParameter("habCode") != null &&
					// request.getParameter("assetTypeCode") != null &&
					// request.getParameter("opType") == null)
					/*
					 * if (circleOfficeCode != null && divisionOfficeCode !=
					 * null && subdivisionOfficeCode != null &&
					 * request.getParameter("habCode") != null &&
					 * request.getParameter("assetTypeCode") != null &&
					 * request.getParameter("opType") == null) { if
					 * (request.getParameter("assetTypeCode").length() != 0 &&
					 * circleOfficeCode.length() != 0 &&
					 * divisionOfficeCode.length() != 0 &&
					 * subdivisionOfficeCode.length() != 0 &&
					 * request.getParameter("habCode").length() != 0) {
					 * session.removeAttribute("tempSelectedHabs");
					 * session.removeAttribute("habs"); Debug.println("opType
					 * changed to Modify"); opType = "Add New"; } else{
					 * request.setAttribute("assetCode", ""); } }
					 * 
					 * 
					 * if(circleOfficeCode != null && divisionOfficeCode != null &&
					 * subdivisionOfficeCode != null &&
					 * request.getParameter("habCode") != null &&
					 * request.getParameter("assetTypeCode") != null &&
					 * request.getParameter("opType")!= null) if
					 * (request.getParameter("assetTypeCode").length() != 0 &&
					 * circleOfficeCode.length() != 0 &&
					 * divisionOfficeCode.length() != 0 &&
					 * subdivisionOfficeCode.length() != 0 &&
					 * request.getParameter("habCode").length() != 0 &&
					 * request.getParameter("opType").length() != 0) {
					 * session.removeAttribute("sources");
					 * session.removeAttribute("headWorks");
					 * session.removeAttribute("pipeLine");
					 * session.removeAttribute("resorvior");
					 * session.removeAttribute("pumpsets");
					 * 
					 * opType = request.getParameter("opType");
					 * Debug.println("^^^^opType is &&&&&& "+opType); }
					 */
					//	Debug.println("pumpCode is "+assetForm.getPumpCode());
					//	rwsMaster =
					// RwsMasterData.getAssetDetails(assetForm.getHabCode(),
					// assetForm.getAssetTypeCode(),
					// assetForm.getPumpCode(),getDataSource(request));
					//getAssetSubComponents(assetForm, request,
					// assetForm.getPumpCode());
					//if(request.getParameter("assetTypeCode")!=null)
					//assetCompTypes =
					// commonLists.getAssetComponents(request.getParameter("assetTypeCode"));
					//	session.setAttribute("assetCompTypes", assetCompTypes);
				} catch (Exception e) {
					Debug.println("The data in rws_AssetAct_frm data" + e);
				}

				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("getNew")) {
				Debug.println("in get modeNew mode edit data display");
				try {
					RwsComplaintsMaster rwsMasters = RwsMasterData
							.getAssetDetails(request.getParameter("assetCode"));
					assetForm.setCircleOfficeCode(request
							.getParameter("circleOfficeCode"));
					Debug.println("pumpcode in schemecode is::"
							+ request.getParameter("circleOfficeCode"));
					assetForm.setDivisionOfficeCode(rwsMasters
							.getDivisionOfficeCode());
					assetForm.setSubdivisionOfficeCode(rwsMasters
							.getSubdivisionOfficeCode());
					assetForm.setAssetTypeCode(rwsMasters.getAssetTypeCode());
					session.setAttribute("opType", "Modify");
					session.setAttribute("assetCode", request
							.getParameter("assetCode"));
					Debug.println("pumpcode in schemecode is::::::::: "+ request.getParameter("schemeCode").substring(16,
									19));
					assetForm.setPumpCode(request.getParameter("schemeCode")
							.substring(16, 19));
					request.setAttribute("pumpCode", assetForm.getPumpCode());
					Debug.println("Hab Codeeeeeeeeee:"
							+ rwsMasters.getHabCode());
					assetForm.setHabCode(rwsMasters.getHabCode());
					assetForm
							.setMandal(rwsMasters.getHabCode().substring(5, 7));
					Debug.println("getting scheme codes");
					Debug.println("schemeCode issss "
							+ request.getParameter("schemeCode"));
					Debug.println("schemeCode issssrwsmaster "
							+ rwsMasters.getSchemeCode());
					Debug.println("assetCode isssss "
							+ request.getParameter("assetCode"));
					Debug.println("assetTypeCode issss "
							+ request.getParameter("assetTypeCode"));
					schemeCodes = commonLists.getSchemeCodes(request
							.getParameter("assetTypeCode"), request
							.getParameter("schemeCode").substring(0, 16));
					session.setAttribute("schemeCodes", schemeCodes);
					Debug
							.println("getNew mode is done"
									+ ((ArrayList) session
											.getAttribute("subdivisions"))
											.size());
					subdivisions = rwsOffices.getSubdivisions("1", request
							.getParameter("schemeCode").substring(0, 2),
							rwsMasters.getDivisionOfficeCode());
					session.setAttribute("subdivisions", subdivisions);
					mandals = RwsMasterData.getsubdivisionmandals(request
							.getParameter("schemeCode").substring(0, 2),
							rwsMasters.getDivisionOfficeCode(), rwsMasters
									.getSubdivisionOfficeCode(),
							getDataSource(request));
					session.setAttribute("mandals", mandals);
					prhabs = rwsLocation.getMandalHabitations(request
							.getParameter("schemeCode").substring(0, 2),
							request.getParameter("schemeCode").substring(5, 7));
					session.setAttribute("prhabs", prhabs);
				} catch (Exception e) {
					Debug.println("the error is" + e);
				}
				return mapping.findForward(mode);
			}

			////
			if (mode != null && mode.equalsIgnoreCase("data")) {

				Debug.println("in data modeeeeeee");
				Debug.println("assetType Code is "
						+ request.getParameter("assetTypeCode"));
				Debug.println("opType is " + request.getParameter("opType"));
				String spMode = request.getParameter("spMode");
				if (spMode != null && spMode.equals("modeScheme")) {
					Debug
							.println("************************IN SPECIAL MODE*****************");
					circleOfficeCode = request.getParameter("circleOfficeCode");
					assetForm.setCircleOfficeCode(circleOfficeCode);
					divisionOfficeCode = request
							.getParameter("divisionOfficeCode");
					assetForm.setDivisionOfficeCode(divisionOfficeCode);
					subdivisionOfficeCode = request
							.getParameter("subdivisionOfficeCode");
					assetForm.setSubdivisionOfficeCode(subdivisionOfficeCode);
					String mandal = request.getParameter("mandal");
					String dname = RwsMasterData.getDistName(
							getDataSource(request), circleOfficeCode);
					assetForm.setDistrict(dname);
					assetForm.setDcode(circleOfficeCode);
					session.setAttribute("distName", dname);
					divisions = rwsOffices.getDivisions(headOfficeCode,
							circleOfficeCode);
					session.setAttribute("divisions", divisions);
					subdivisions = rwsOffices.getSubdivisions("1",
							circleOfficeCode, divisionOfficeCode);
					session.setAttribute("subdivisions", subdivisions);
					mandals = RwsMasterData.getsubdivisionmandals(
							circleOfficeCode, divisionOfficeCode,
							subdivisionOfficeCode, getDataSource(request));
					session.setAttribute("mandals", mandals);
					prhabs = rwsLocation.getMandalHabitations(assetForm
							.getCircleOfficeCode(), mandal);
					session.setAttribute("prhabs", prhabs);
					schemeCodes = commonLists.getSchemeCodes(request
							.getParameter("assetTypeCode"), request
							.getParameter("habCode"));
					session.setAttribute("schemeCodes", schemeCodes);
					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);
				}
				if (assetForm.getPumpCode() == null
						|| assetForm.getPumpCode().equals("")) {
					assetForm.setPumpCode((String) request
							.getAttribute("pumpCode"));
					Debug.println("pumpCode taken from request");

				}
				if (assetForm.getPumpCode() != null) {
					Debug
							.println("shortSchemeCode in data mode is set to session "
									+ assetForm.getPumpCode());
					session.setAttribute("shortSchemeCode", assetForm
							.getPumpCode());
				}
				try {

					assetTypes = commonLists.getAssetTypes();
					session.setAttribute("assetTypes", assetTypes);

					//selected district,mandal,panchayat,village,habitationCode
					// in asset entry form are set to session
					String dcode = RwsMasterData.getDcode(
							getDataSource(request), assetForm.getDistrict());
					session.setAttribute("districtNameInAssetEntryForm",
							assetForm.getDistrict());
					session.setAttribute("districtInAssetEntryForm", assetForm
							.getCircleOfficeCode());
					session.setAttribute("mandalInAssetEntryForm", assetForm
							.getMandal());
					session.setAttribute("panchayatInAssetEntryForm",
							(String) request.getParameter("pcode"));
					session.setAttribute("villageInAssetEntryForm",
							(String) request.getParameter("vcode"));
					session.setAttribute("habCodeInAssetEntryForm", assetForm
							.getHabCode());
					session.setAttribute("shortSchemeCodeInAssetEntryForm",
							assetForm.getPumpCode());
					//if (request.getParameter("coc") != null &&
					// request.getParameter("doc") != null &&
					// request.getParameter("sdoc") != null &&
					// request.getParameter("habCode") != null &&
					// request.getParameter("assetTypeCode") != null &&
					// request.getParameter("opType") == null)
					if (circleOfficeCode != null && divisionOfficeCode != null
							&& subdivisionOfficeCode != null
							&& request.getParameter("habCode") != null
							&& request.getParameter("assetTypeCode") != null
							&& request.getParameter("opType") == null) {
						if (request.getParameter("assetTypeCode").length() != 0
								&& circleOfficeCode.length() != 0
								&& divisionOfficeCode.length() != 0
								&& subdivisionOfficeCode.length() != 0
								&& request.getParameter("habCode").length() != 0) {
							session.removeAttribute("tempSelectedHabs");
							session.removeAttribute("habs");
							Debug.println("opType changed to Modify");
							opType = "Modify";
						} else {
							request.setAttribute("assetCode", "");
						}
					}

					if (circleOfficeCode != null && divisionOfficeCode != null
							&& subdivisionOfficeCode != null
							&& request.getParameter("habCode") != null
							&& request.getParameter("assetTypeCode") != null
							&& request.getParameter("opType") != null)
						if (request.getParameter("assetTypeCode").length() != 0
								&& circleOfficeCode.length() != 0
								&& divisionOfficeCode.length() != 0
								&& subdivisionOfficeCode.length() != 0
								&& request.getParameter("habCode").length() != 0
								&& request.getParameter("opType").length() != 0) {
							session.removeAttribute("sources");
							session.removeAttribute("headWorks");
							session.removeAttribute("pipeLine");
							session.removeAttribute("resorvior");
							session.removeAttribute("pumpsets");

							opType = request.getParameter("opType");
							Debug.println("^^^^opType is &&&&&& " + opType);
						}

					Debug.println("pumpCode is******************* "+ assetForm.getPumpCode());
					rwsMaster = RwsMasterData.getAssetDetails(assetForm
							.getHabCode(), assetForm.getAssetTypeCode(),
							assetForm.getPumpCode(), getDataSource(request));
					Debug.println("aa:" + rwsMaster);
					double TotPB = 0.0;
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
					try {
						if (request.getParameter("assetTypeCode").equals("01")
								|| request.getParameter("assetTypeCode")
										.equals("02")
								|| request.getParameter("assetTypeCode")
										.equals("03")) {
							TotPB = rwsMaster.getTotPopBenfit()
									* Math.pow(1.02, Integer.parseInt(sdf
											.format(new Date())) - 2001);
						} else 
						{
							TotPB = rwsMaster.getTotPopBenfit();
						}
					} catch (Exception e) {
						Debug.println("error in population:" + e.getMessage());
					}

					Debug.println("^^opType is " + assetForm.getOpType());
					opType = assetForm.getOpType();
					Debug.println("entering opType Modify");
					if (opType.equals("Modify")) {
						Debug.println("in opType Modify in data mode");
						//assetForm.setPumpCode(request
						//.getParameter("pumpCode"));
						Debug.println("asset code in asset act:"
								+ rwsMaster.getAssetCost());
						assetForm.setAssetCode(rwsMaster.getAssetCode());
						//session.setAttribute("assetCode",
						// rwsMaster.getAssetCode());
						assetForm.setAssetName(rwsMaster.getAssetName());
						assetForm.setLocation(rwsMaster.getLocation());
						assetForm.setAssetCost(rwsMaster.getAssetCost());
						assetForm.setStartYear(rwsMaster.getStartYear());
						assetForm.setEndYear(rwsMaster.getEndYear());
						assetForm.setDefunctReasons(rwsMaster
								.getDefunctReasons());
						assetForm.setDateofCreation(rwsMaster
								.getDateofCreation());
						assetForm.setAssetStatus(rwsMaster.getAssetStatus());
						assetForm.setTotHabs(rwsMaster.getTotHabs());
						assetForm.setRemarks(rwsMaster.getRemarks());
						//assetForm.setTotPopBenfit(rwsMaster.getTotPopBenfit());
						Debug.println("1:" + TotPB);
						Debug.println("2:" + Math.ceil(TotPB));
						Debug.println("3:" + Math.round(Math.ceil(TotPB)));
						Debug
								.println("4:"
										+ (int) Math.round(Math.ceil(TotPB)));
						assetForm.setTotPopBenfit((int) Math.round(Math
								.ceil(TotPB)));
						Debug.println("assetForm.setTotPopBenfit():"
								+ assetForm.getTotPopBenfit());
						Debug.println("Asset code in modify = "
								+ assetForm.getAssetCode());
						session.setAttribute("assetCode", assetForm
								.getAssetCode());
						assetForm.setDpYield(rwsMaster.getDpYield());
						assetForm.setDivisionOfficeCode(rwsMaster
								.getDivisionOfficeCode());
						assetForm.setSubdivisionOfficeCode(rwsMaster
								.getSubdivisionOfficeCode());
						assetForm.setMandal(rwsMaster.getMandalCode());
						assetForm.setHabCode(rwsMaster.getHabCode());
						//added by swapna on 18-01-2012 for gis dat entry
						assetForm.setLatitude(rwsMaster.getLatitude());
						assetForm.setLongitude(rwsMaster.getLongitude());
						assetForm.setElevation(rwsMaster.getElevation());
						assetForm.setWaypoint(rwsMaster.getWaypoint());
						//
					}

					getAssetSubComponents(assetForm, request, assetForm
							.getPumpCode());

					if (request.getParameter("assetTypeCode") != null)
						assetCompTypes = commonLists.getAssetComponents(request
								.getParameter("assetTypeCode"));
					session.setAttribute("assetCompTypes", assetCompTypes);
					session.setAttribute("opType", "Modify");

				} catch (Exception e) {
					Debug.println("The data in rws_AssetAct_frm data" + e);
				}
				Debug.println("component changed is "
						+ request.getParameter("component"));

				/*
				 * if(request.getParameter("component")!=null &&
				 * (request.getParameter("component").equals("modify")||request.getParameter("component").equals("addNew"))) {
				 * assetForm.setAssetName(""); assetForm.setLocation("");
				 * assetForm.setAssetStatus(""); assetForm.setStartYear("");
				 * assetForm.setDateofCreation(""); assetForm.setAssetCost("");
				 * assetForm.setTotHabs(0); assetForm.setTotPopBenfit(0); }
				 */
				//@end of code
				return mapping.findForward("data");

			}

			if (assetForm.getMode().equals("goToAddNewAction")) {
				Debug.println("in goToAddNewAction");

				assetForm = addNewSubComponent(mode, request, assetForm);
				Debug.println("size after getting out of function "
						+ (assetForm.getAssetHeadWorks()).size());
				Debug.println("returning mode 1513 is " + assetForm.getMode());
				Debug.println("returning mode 1513 is " + assetForm.getMode());
				return mapping.findForward(assetForm.getMode());
			}

			if (mode != null && mode.equalsIgnoreCase("remove")) {

				Debug.println(" in remove mode");
				Debug.println(" assetCompTypeCode is " + assetCompTypeCode);
				String[] removeIds = request.getParameterValues("remove");
				if (removeIds != null && removeIds.length != 0) {
					for (int p = 0; p < removeIds.length; p++)
						Debug.println("removeIds[" + p + "] : " + removeIds[p]);
				}
				if (assetCompTypeCode.equals("05"))
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPumpSets();
				else if (assetCompTypeCode.equals("04"))
					assetsubCompParams = (ArrayList) assetForm
							.getAssetReservior();
				else if (assetCompTypeCode.equals("02"))
					assetsubCompParams = (ArrayList) assetForm
							.getAssetHeadWorks();
				else if (assetCompTypeCode.equals("03"))
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPipeLine();

				int size = assetsubCompParams.size();
				Debug.println("size=" + size);
				for (int i = removeIds.length; i > 0; i--)
					assetsubCompParams.remove(Integer
							.parseInt(removeIds[(i - 1)]));

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

			//@author santosh code added on 211106

			// end @author
			/*
			 * DELETE ASSET SUBCOMP PARAMETER ADD BY SADIQ
			 */
			if (mode != null && mode.equalsIgnoreCase("removeSubComps")) {
				Debug.println("in removeSubComps mode");
				Debug.println("endter record deleted");
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					Debug.println("endter record deleted " + typeOfAssetCode
							+ "bbb   " + assetCompTypeCode + "uuu ");
					int rowCount = 0;
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					Debug.println("Type opf asset code is  " + typeOfAssetCode);
					Debug.println("asset code(14 digit) is  " + assetCd);
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request
							.getParameter("assetTypeCode");
					Debug.println("assetCode=" + assetTypeCode
							+ "assetCompTypeCode=" + assetCompTypeCode
							+ "assetSubCompTypeCode=" + assetSubCompTypeCode
							+ "assetTypeCode=" + assetTypeCode);

					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPumpSets();

					String[] removeIds = request.getParameterValues("remove");
					try {
						Debug.println("size of assetsubCompParams is  "
								+ assetsubCompParams.size());
						Debug.println("remove ids length is  "
								+ removeIds.length);
						if (removeIds != null && removeIds.length != 0) {
							int x = 0;
							for (int p = removeIds.length; p > 0; p--) {
								x = Integer.parseInt(removeIds[p - 1]);
								Debug.println("XXXXXXX   is " + x);
								Debug.println("removeIds[" + p + "] : "
										+ removeIds[p - 1]);
								assetsubCompTempParams.add(assetsubCompParams
										.get(x));
								assetsubCompParams.remove(x);
							}
						}
						//assetForm.setAssetReservior(assetsubCompParams);
						Debug.println("remove ids length is  "
								+ removeIds.length);
						int size = assetsubCompParams.size();
						Debug.println("size=" + size);
					} catch (Exception e) {
						Debug
								.println("exception in getting remove values "
										+ e);
					}
					Debug.println("after catch");

					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")
							|| typeOfAssetCode.equals("04") || typeOfAssetCode
							.equals("05"))
							&& assetCompTypeCode.equals("02")) {
						assetForm.setAssetHeadWorks(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetsubCompTempParams,
								"Headworks");
						Debug.println("rowCount  value " + rowCount);
						assetForm.setAssetHeadWorks(assetsubCompParams);

						if (rowCount > 0) {
							message = "Record(s) Deleted";
							Debug.println("record Deleted");
						} else {

							message = "The Record(s) Cant be Deleted";
							Debug.println("  not Deleted");
						}
						request.setAttribute("message", message);
						return mapping.findForward("removeSubComps");
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")
							|| typeOfAssetCode.equals("04") || typeOfAssetCode
							.equals("05"))
							&& assetCompTypeCode.equals("03")) {
						Debug.println("in delete of subcomp 03");
						assetForm.setAssetPipeLine(assetsubCompTempParams);

						///?????? might be repeated code

						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetPipeLine(), "Pipeline");
						if (rowCount > 0) {
							message = "Record(s) Deleted";
							Debug.println("record Deleted");
						} else {

							message = "The Record(s) Cant be Deleted";
							Debug.println("  not Deleted");
						}
						request.setAttribute("message", message);
						mode = "pumpset";

						//assetForm.setAssetPipeLine(assetsubCompParams);
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")
							|| typeOfAssetCode.equals("04") || typeOfAssetCode
							.equals("05"))
							&& assetCompTypeCode.equals("04")) {
						//assetForm.setAssetReservior(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetsubCompTempParams,
								"Reservoirs");
						if (rowCount > 0) {
							message = "Record(s) Deleted";
							Debug.println("record Deleted");
						} else {

							message = "The Record(s) Cant be Deleted";
							Debug.println("  not Deleted");
						}
						request.setAttribute("message", message);
						assetForm.setAssetReservior(assetsubCompParams);
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")
							|| typeOfAssetCode.equals("04") || typeOfAssetCode
							.equals("05"))
							&& assetCompTypeCode.equals("05")) {
						Debug
								.println("removesubComps() && assetCompTypeCode=05");
						//assetForm.setAssetPumpSets(assetsubCompTempParams);
						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetsubCompTempParams,
								"PumpSets");
						assetForm.setAssetPumpSets(assetsubCompParams);
						Debug.println("final assetsubCompParams size is "
								+ assetsubCompParams.size());
						Debug.println("returning from pumpsets");
						if (rowCount > 0) {
							message = "Record(s) Deleted";
							Debug.println("record Deleted");
						} else {

							message = "The Record(s) Cant be Deleted";
							Debug.println("  not Deleted");
						}
						request.setAttribute("message", message);
						return mapping.findForward("addNew");
					}

					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03")
							|| typeOfAssetCode.equals("09")
							|| typeOfAssetCode.equals("04") || typeOfAssetCode
							.equals("05"))
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("003")) {
						Debug
								.println("removesubComps() && assetSubCompTypeCode=003");
						//assetForm.setAssetPumpSets(assetsubCompTempParams);
						assetsubCompTempParams.clear();
						asset_pumpset.setPumpCode((String) request
								.getParameter("pumpCode"));
						asset_pumpset.setAssetCode((String) request
								.getParameter("assetCode"));
						asset_pumpset.setPumpType((String) request
								.getParameter("pumpType"));
						asset_pumpset.setPumpControlPanel((String) request
								.getParameter("pumpControlPanel"));
						Debug.println("pumpCode is "
								+ asset_pumpset.getPumpcode());
						assetsubCompTempParams.add(asset_pumpset);
						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetsubCompTempParams,
								"PumpSets");
						if (rowCount > 0)
							assetsubCompTempParams.clear();
						assetForm.setAssetPumpSets(assetsubCompTempParams);
						Debug.println("final assetsubCompParams size is "
								+ assetsubCompTempParams.size());
						Debug.println("returning from pumpsets");

					}

					if (rowCount > 0) {
						message = "Record(s) Deleted";
						Debug.println("record Deleted");
					} else {

						message = "The Record(s) Cant be Deleted";
						Debug.println("  not Deleted");
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug
							.println("error in remove subcomp (in act.java)  "
									+ e);

				}

			}

			if (mode.equalsIgnoreCase("removePumpset")) {
				if (assetCompTypeCode.equals("06"))
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPumpSets();
				Debug.println("assetsubCompParams size1:"
						+ assetsubCompParams.size());
				Asset_Pumpset as = new Asset_Pumpset();
				for (int i = 0; i < assetsubCompParams.size(); i++) {
					as = (Asset_Pumpset) assetsubCompParams.get(i);
					if (as.getAssetCode().equals(
							request.getParameter("assetCode"))) {
						Debug.println("assetsubCompParams size2:"
								+ as.getAssetCode());
						assetsubCompParams.remove(i);
						assetsubCompTempParams
								.add(i, assetsubCompParams.get(i));
					}
				}
				Debug.println("assetsubCompParams size3:"
						+ assetsubCompParams.size());
				int rowCount = 0;
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request
						.getParameter("assetSubCompTypeCode");
				String assetCd = (String) session.getAttribute("assetCode");
				String assetTypeCode = request.getParameter("assetTypeCode");
				if ((typeOfAssetCode.equals("01")
						|| typeOfAssetCode.equals("02")
						|| typeOfAssetCode.equals("03") || typeOfAssetCode
						.equals("09"))
						&& assetCompTypeCode.equals("06")
						&& assetSubCompTypeCode.equals("001")) {
					Debug
							.println("removesubComps() && assetSubCompTypeCode=003");
					//assetForm.setAssetPumpSets(assetsubCompTempParams);
					assetsubCompTempParams.clear();
					asset_pumpset.setPumpCode((String) request
							.getParameter("pumpCode"));
					asset_pumpset.setAssetCode((String) request
							.getParameter("assetCode"));
					asset_pumpset.setPumpType((String) request
							.getParameter("pumpType"));
					asset_pumpset.setPumpControlPanel((String) request
							.getParameter("pumpControlPanel"));
					Debug.println("pumpCode is " + asset_pumpset.getPumpcode());
					Debug.println("pumpCode1 is "
							+ request.getParameter("pumpCode"));
					assetsubCompTempParams.add(asset_pumpset);
					rowCount = RwsMasterData.removeAssetSubComp(
							getDataSource(request), assetCd, assetCompTypeCode,
							assetSubCompTypeCode, assetTypeCode, opType,
							assetsubCompTempParams, "PumpSets");
					if (rowCount > 0) {
						assetsubCompTempParams.clear();
						request.setAttribute("message", "Record Deleted");
					} else {
						request.setAttribute("message",
								"Record Can't be Deleted");
					}
					assetForm.setAssetPumpSets(assetsubCompParams);
					Debug.println("final assetsubCompParams size is "
							+ assetsubCompParams.size());
					Debug.println("returning from pumpsets");
					mode = "pumpset";

				}
			}

			if (mode.equalsIgnoreCase("previous")) {
				Debug.println("in previous mode");
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String bwCount;
					int size;
					int bwCnt;
					if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("valud of bwCont is  " + bwCnt);
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt - 1));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							System.err.println("parms  borweel size is "
									+ assetsubCompTempParams.size());

						}
					} else if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("valud of bwCont is  " + bwCnt);
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt - 1));
							assetForm.setAssetPumpSets(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borwell size is "
									+ assetsubCompTempParams.size());
						}
					} else if (typeOfAssetCode.equals("03")
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("valud of bwCont is  " + bwCnt);
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt - 1));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borwell size is "
									+ assetsubCompTempParams.size());
						}
					}
				} catch (Exception e) {
					Debug.println("size of assetsubComPWSPARAM in privous  ");
					Debug.println("prevoius  " + e);
				}
			}

			if (mode.equalsIgnoreCase("previouspump")) {
				Debug.println("in previouspump mode");
				try {
					session.removeAttribute("first");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String bwCount;
					int size = -1;
					int bwCnt = 0;
					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("valud of bwCont is  " + bwCnt);
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						Debug.println("Size:" + size);
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt - 1));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						}
						Debug.println("Size1:" + assetsubCompTempParams.size());
						Debug.println("bwCount:" + bwCount);
						if (assetsubCompParams.get(0) != null) {
							Debug.println("^^%%%%%%%%%%%%%^^^^^^^:"
									+ assetsubCompParams.get(0));
							request.setAttribute("currentRow", ""
									+ assetsubCompTempParams.size());
							request.setAttribute("totalRecords", "" + size);
							Debug
									.println("currentRow in action is "
											+ ((size - assetsubCompTempParams
													.size()) + 1));
							Debug.println("totalRecords in action is " + size);
						}

					} else if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						bwCount = (String) session.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("valud of bwCont is  " + bwCnt);
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						if (size >= bwCnt && bwCnt >= 1) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt - 1));
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							bwCnt = bwCnt - 1;
							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());

						}
					}
					if (size == bwCnt + 1) {
						Debug.println("if last loop");
						session.setAttribute("last", "last");
					} else {
						Debug.println("else last loop");
						session.removeAttribute("last");
					}
					if (size == 0) {
						Debug.println("if last loop");
						session.setAttribute("prev", "prev");
					} else {
						Debug.println("else last loop");
						session.removeAttribute("prev");
					}
				} catch (Exception e) {
					Debug.println("size of assetsubComPWSPARAM in privous  ");
					Debug.println("prevoius  " + e);
				}
			}

			//added by ramesh

			if (mode.equalsIgnoreCase("getNextBw")) {
				Debug.println("in getNextBw mode");
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request
						.getParameter("assetSubCompTypeCode");
				opType = request.getParameter("opType");
				Debug.println("opType is " + opType);
				pumpCode = "";
				pumpCode = request.getParameter("hpCode");
				mode = "pumpset";
				session.setAttribute("assetsubCompParams", "HandPumps");
				assetsubCompParams = RwsMasterData.getAssetNextSubCompBwParams(
						getDataSource(request), request
								.getParameter("assetCode"), request
								.getParameter("assetTypeCode"), request
								.getParameter("assetCompTypeCode"), request
								.getParameter("assetSubCompTypeCode"), request
								.getParameter("habCode"), pumpCode, request
								.getParameter("opType"));
				Debug.println("assetsubCompParams size is "
						+ assetsubCompParams.size());
				assetForm.setAssetSubComponents(assetsubCompParams);
				mode = "pumpset";
				if (assetsubCompParams.get(0) != null) {
					if (opType.equals("next"))
						request.setAttribute("nextNotExists",
								((RwsComplaintsMaster) assetsubCompParams.get(0))
										.getIsLast());
					if (opType.equals("previous"))
						request.setAttribute("previousNotExists",
								((RwsComplaintsMaster) assetsubCompParams.get(0))
										.getIsLast());
					if (opType.equals("first"))
						request.setAttribute("previousNotExists", "true");
					if (opType.equals("last"))
						request.setAttribute("nextNotExists", "true");
					//code added

					request.setAttribute("currentRow",
							((RwsComplaintsMaster) assetsubCompParams.get(0))
									.getCurrentRow()
									+ "");
					request.setAttribute("totalRecords",
							((RwsComplaintsMaster) assetsubCompParams.get(0))
									.getRowCount()
									+ "");
					Debug.println("currentRow in action is "
							+ request.getAttribute("currentRow"));
					Debug.println("totalRecords in action is "
							+ request.getAttribute("totalRecords"));
				}
				return mapping.findForward(mode);
			}

			//this block in envocked when next or previous button is pressed
			if (mode.equalsIgnoreCase("getNextSubComponent")) {
				Debug.println("in getNextSubComponent mode");
				typeOfAssetCode = request.getParameter("assetTypeCode");
				assetCompTypeCode = request.getParameter("assetCompTypeCode");
				assetSubCompTypeCode = request
						.getParameter("assetSubCompTypeCode");
				opType = request.getParameter("opType");
				Debug.println("opType is " + opType);
				pumpCode = "";

				if (assetCompTypeCode.equals("01")
						&& assetSubCompTypeCode.equals("003")) {
					pumpCode = request.getParameter("pumpCode");

				}
				if (assetCompTypeCode.equals("03")
						&& assetSubCompTypeCode.equals("001")) {
					pumpCode = request.getParameter("pmCode");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams",
							"CpwsPumpingMain");
				}
				if (assetCompTypeCode.equals("06")
						&& assetSubCompTypeCode.equals("001")) {
					pumpCode = request.getParameter("pumpCode");

				}
				if (assetCompTypeCode.equals("03")
						&& assetSubCompTypeCode.equals("002")) {
					pumpCode = request.getParameter("gravitymain_code");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams", "GravityMain");
				}
				if (assetCompTypeCode.equals("03")
						&& assetSubCompTypeCode.equals("003")) {
					pumpCode = request.getParameter("disCode");
					mode = "pumpset";
					session.setAttribute("assetsubCompParams", "Distribution");
				}

				assetsubCompParams = RwsMasterData.getAssetNextSubCompParams(
						getDataSource(request), request
								.getParameter("assetCode"), request
								.getParameter("assetTypeCode"), request
								.getParameter("assetCompTypeCode"), request
								.getParameter("assetSubCompTypeCode"), request
								.getParameter("habCode"), pumpCode, request
								.getParameter("opType"));
				Debug.println("assetsubCompParams size is "
						+ assetsubCompParams.size());

				if ((typeOfAssetCode.equals("01")
						|| typeOfAssetCode.equals("02")
						|| typeOfAssetCode.equals("03") || typeOfAssetCode
						.equals("09"))
						&& assetCompTypeCode.equals("06")
						&& assetSubCompTypeCode.equals("001")) {
					assetForm.setAssetPumpSets(assetsubCompParams);
					mode = "navigatePumpset";
				}
				if ((typeOfAssetCode.equals("01")
						|| typeOfAssetCode.equals("02")
						|| typeOfAssetCode.equals("03") || typeOfAssetCode
						.equals("09"))
						&& assetCompTypeCode.equals("03")
						&& (assetSubCompTypeCode.equals("001")
								|| assetSubCompTypeCode.equals("002") || assetSubCompTypeCode
								.equals("003"))) {
					assetForm.setAssetPipeLine(assetsubCompParams);
					Debug.println("assetsubCompParams size is "
							+ assetsubCompParams.size());
					mode = "navigatePumpset";
				}
				if ((typeOfAssetCode.equals("01")
						|| typeOfAssetCode.equals("02")
						|| typeOfAssetCode.equals("03") || typeOfAssetCode
						.equals("09"))
						&& assetCompTypeCode.equals("6")
						&& assetSubCompTypeCode.equals("001")) {
					assetForm.setAssetPipeLine(assetsubCompParams);
					Debug.println("assetsubCompParams size is "
							+ assetsubCompParams.size());
					mode = "navigatePumpset";
				}

				if (assetsubCompParams.get(0) != null) {
					if (assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("003")) {

						if (opType.equals("next"))
							request.setAttribute("nextNotExists",
									((Asset_Pumpset) assetsubCompParams.get(0))
											.getIsLast());
						if (opType.equals("previous"))
							request.setAttribute("previousNotExists",
									((Asset_Pumpset) assetsubCompParams.get(0))
											.getIsLast());
						if (opType.equals("first"))
							request.setAttribute("previousNotExists", "true");
						if (opType.equals("last"))
							request.setAttribute("nextNotExists", "true");
						//code added

						request.setAttribute("currentRow",
								((Asset_Pumpset) assetsubCompParams.get(0))
										.getCurrentRow()
										+ "");
						request.setAttribute("totalRecords",
								((Asset_Pumpset) assetsubCompParams.get(0))
										.getRowCount()
										+ "");
						Debug.println("currentRow in action is "
								+ request.getAttribute("currentRow"));
						Debug.println("totalRecords in action is "
								+ request.getAttribute("totalRecords"));

					}
					if (assetCompTypeCode.equals("03")
							&& (assetSubCompTypeCode.equals("001")
									|| assetSubCompTypeCode.equals("002") || assetSubCompTypeCode
									.equals("003"))) {
						if (opType.equals("next"))
							request
									.setAttribute(
											"nextNotExists",
											((Asset_PipeLine) assetsubCompParams
													.get(0)).getIsLast());
						Debug.println("in optype next");
						if (opType.equals("previous"))
							request
									.setAttribute(
											"previousNotExists",
											((Asset_PipeLine) assetsubCompParams
													.get(0)).getIsLast());
						if (opType.equals("first"))
							request.setAttribute("previousNotExists", "true");
						if (opType.equals("last"))
							request.setAttribute("nextNotExists", "true");
						Debug.println("^^^^^^^^^^^^^^^^^^^^^^^^^:"
								+ assetsubCompParams.get(0));
						request.setAttribute("currentRow",
								((Asset_PipeLine) assetsubCompParams.get(0))
										.getCurrentRow()
										+ "");
						request.setAttribute("totalRecords",
								((Asset_PipeLine) assetsubCompParams.get(0))
										.getRowCount()
										+ "");
						Debug.println("currentRow in action is "
								+ request.getAttribute("currentRow"));
						Debug.println("totalRecords in action is "
								+ request.getAttribute("totalRecords"));

					}

				}

				return mapping.findForward(mode);
			}

			//dcode#
			if (mode.equalsIgnoreCase("next")) {
				Debug.println("in next mode");
				try {
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");

					if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						System.err.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
						}
					} else if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm.setAssetPumpSets(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							System.err.println("parms  borwell size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_pumpset = new Asset_Pumpset();
							rwsMaster.setPmpCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						}
					}

					else if (typeOfAssetCode.equals("03")
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm.setAssetPipeLine(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borwell size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							rwsMaster.setGravitymain_code((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pipeline);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
						}
					} else if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
						}
					}
				} catch (Exception e) {
					Debug.println("Next   " + e);
				}
			}

			if (mode.equalsIgnoreCase("firstHP")) {
				Debug.println("in firstHp mode");
				try {
					int size = -1, bwCnt = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");

					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();

						assetsubCompTempParams.clear();
						assetsubCompTempParams.add(assetsubCompParams.get(0));
						assetForm.setAssetSubComponents(assetsubCompTempParams);

						bwCount = String.valueOf(bwCnt);
						session.setAttribute("bwCount", bwCount);
						Debug.println("parms  borweel size is "
								+ assetsubCompTempParams.size());

					}

				} catch (Exception e) {
					Debug.println("Next pumpset  " + e);
				}
			}

			if (mode.equalsIgnoreCase("lastHP")) {
				Debug.println("in lastHp mode");
				try {
					int size = -1, bwCnt = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");

					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(size - 1));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						}
					}

				} catch (Exception e) {
					Debug.println("Next pumpset  " + e);
				}
			}
			if (mode.equalsIgnoreCase("nextpump")) {
				Debug.println("in nextpump mode");
				try {
					int size = -1, bwCnt = 0;
					session.removeAttribute("first");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");

					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();
						Debug.println("pump size:" + size);
						Debug.println("bwCnt:" + bwCnt);
						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
						}
						if (assetsubCompParams.get(0) != null) {
							Debug.println("^^%%%%%%%%%%%%%^^^^^^^:"
									+ assetsubCompParams.get(0));
							request
									.setAttribute("currentRow", ""
											+ (bwCnt + 1));
							request.setAttribute("totalRecords", "" + size);
							Debug
									.println("currentRow in action is "
											+ ((size - assetsubCompTempParams
													.size()) + 1));
							Debug.println("totalRecords in action is " + size);
						}
					} else if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						String bwCount = (String) session
								.getAttribute("bwCount");
						bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						assetsubCompParams = (ArrayList) session
								.getAttribute("assetsubCompPWSParams");
						size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm.setAssetPipeLine(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							rwsMaster.setPmCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_pipeline);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
						}

					}
					if (size == bwCnt + 1) {
						Debug.println("if last loop");
						session.setAttribute("last", "last");
					} else {
						Debug.println("else last loop");
						session.setAttribute("last", null);
					}
					if (size == 0) {
						Debug.println("if last loop");
						session.setAttribute("prev", "prev");
					} else {
						Debug.println("else last loop");
						session.removeAttribute("prev");
					}
				} catch (Exception e) {
					Debug.println("Next pumpset  " + e);
				}
			}
			if (mode.equalsIgnoreCase("setHabCount")) {
				Debug.println("in set hab count method for OHSR");
				try {
					assetsubCompParams = assetForm.getAssetReservior();
					Debug.println("assetsubCompParams size is"
							+ assetsubCompParams.size());
					ArrayList a = (ArrayList) session
							.getAttribute("assetsubCompParams");
					Debug.println("session size:" + a.size());
					assetsubCompTempParams.clear();
					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					Debug.println("Type opf asset code is  " + typeOfAssetCode);
					Debug.println("asset code(14 digit) is  " + assetCd);
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request
							.getParameter("assetTypeCode");
					String index = request.getParameter("index");
					Debug.println("Index in set hab count mode is:"
							+ request.getParameter("index"));
					Debug.println("assetCode=" + assetTypeCode
							+ "assetCompTypeCode=" + assetCompTypeCode
							+ "assetSubCompTypeCode=" + assetSubCompTypeCode
							+ "assetTypeCode=" + assetTypeCode);
					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPumpSets();
					Debug.println("after");
					Debug.println("assetsubCompTempParams size:"
							+ assetsubCompTempParams.size());
					//String[] addIds = request.getParameterValues("remove");
					//Debug.println("addIds.length()"+addIds.length);

					//if (addIds != null && addIds.length != 0)
					//{
					//for (int p = 0; p < addIds.length; p++)
					//{
					//Debug.println("addIds[" + p + "] : " + addIds[p]);
					assetsubCompTempParams.add(assetsubCompParams.get((Integer
							.parseInt(index))));
					//Asset_HeadWorks assetHw =
					// (Asset_HeadWorks)assetsubCompParams.get((Integer.parseInt(addIds[p])));
					//Debug.println("aaaaaaaaaaaaaabbbbbbbbbbb:"+assetHw.getWtpCode());
					//}

					//}

					assetsubCompParams = assetForm.getAssetReservior();
					Debug.println("assetsubCompParams size is"
							+ assetsubCompParams.size());

					assetForm.setMode("addNew");
					mode = "AddHab";
				} catch (Exception e) {
					Debug.println("Next pumpset  " + e);
				}
			}
			if (mode.equalsIgnoreCase("addNewOandM")) {
				Debug.println("in addNewOandM");
				session.setAttribute("costOfAsset", request
						.getParameter("costOfAsset"));
				Asset_Others asset_others = new Asset_Others();
				asset_others.setAssetCode((String) request
						.getParameter("assetCode"));
				asset_pumpset.setHabCode((String) request
						.getParameter("habCode"));
				asset_others.setHabCode((String) request
						.getParameter("habCode"));
				Debug
						.println("asset cost:"
								+ request.getParameter("assetCost"));
				asset_others.setAssetCost((String) request
						.getParameter("assetCost"));
				assetsubCompParams.add(asset_others);
				Debug.println("size after addint o and m is "
						+ assetsubCompParams.size());
				assetForm.setAssetPumpSets(assetsubCompParams);
			}
			if (mode.equalsIgnoreCase("params")) {
				Debug.println("in params mode");
				try {
					Debug.println("in params mode");
					session.removeAttribute("going to getNextSubComponentCode");
					session.removeAttribute("last");
					session.removeAttribute("prev");
					session.setAttribute("first", "first");
					/*
					 * pipeMaterial = commonLists.getPipeMatirals();
					 * session.setAttribute("pipeMaterial", pipeMaterial);
					 */
					int bwCnt = 0;
					String bwCount = String.valueOf(bwCnt);
					session.setAttribute("bwCount", bwCount);

					String tempPCode = "", PCode = null, phCode = null;
					int tslno = 0, slno = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");

					//@author santosh code added on 071206
					if (typeOfAssetCode.equals("05")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println("in shallow hand pumps params");
						Asset_SHP assetSHP;

						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SHP");
						Debug.println("size of assetsubCompParams is "
								+ assetsubCompParams.size());
						assetForm.setAssetSHP(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Debug.println("in if");
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetSHP = (Asset_SHP) assetsubCompParams
										.get(i);
								//to remove
								assetsubCompParams.clear();
								assetsubCompParams.add(assetSHP);
								//end
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
							//Debug.println("returning mode is ponds");
							//return mapping.findForward("ponds");
						} else {
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "SP001";
							tempPCode = phCode;
							Debug.println("tempPCode or phCode is "+ tempPCode);
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_SHP());
							assetForm.setAssetSHP(assetsubCompParams);
							//return mapping.findForward("ponds");
						}
						session.setAttribute("assetsubCompParams", "SHP");
						Debug.println("setting assetsubCompParams to Ponds");
						return mapping.findForward("ponds");
					}

					if (typeOfAssetCode.equals("06")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_OpenWells assetOpenWells;
						Debug.println("in open wells params");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "OpenWells");
						Debug.println("size of assetsubCompParams is "
								+ assetsubCompParams.size());
						assetForm.setAssetOpenWells(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Debug.println("in if");
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetOpenWells = (Asset_OpenWells) assetsubCompParams
										.get(i);
								//to remove
								assetsubCompParams.clear();
								assetsubCompParams.add(assetOpenWells);
								//end
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
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OW001";
							tempPCode = phCode;
							Debug
									.println("tempPCode or phCode is "
											+ tempPCode);
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_OpenWells());
							assetForm.setAssetOpenWells(assetsubCompParams);

						}

						session.setAttribute("assetsubCompParams", "OpenWells");
						Debug
								.println("setting assetsubCompParams to OpenWells");
						return mapping.findForward("ponds");
					}

					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println("in others");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));

						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details 3425 is " + size);

						if (size > 0) {
							Debug.println("size > 0");
							session.setAttribute("assetsubCompParams",
									assetsubCompParams);

							assetsubCompTempParams.clear();

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams
										.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();

							}
						} else {

						}
						session.setAttribute("assetsubCompParams",
								"Miscellaneous");
						Debug.println("session set to mis");
						return mapping.findForward("params");

					}
					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("002")) {
						Debug.println("in others chlorination");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));

						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details 3425 is " + size);

						if (size > 0) {
							Debug.println("size > 0");
							session.setAttribute("assetsubCompParams",
									assetsubCompParams);

							assetsubCompTempParams.clear();

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams
										.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();

							}
						} else {

						}
						session.setAttribute("assetsubCompParams",
								"Chlorination");
						Debug.println("session set to mis");
						return mapping.findForward("params");

					}
					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("003")) {
						Debug.println("in o and m");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));

						assetForm.setAssetPumpSets(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size o and m details 3425 is " + size);

						if (size > 0) {
							Debug.println("size > 0");
							session.setAttribute("assetsubCompParams",
									assetsubCompParams);

							assetsubCompTempParams.clear();

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								Asset_Pumpset assetPumpsetsTemp = (Asset_Pumpset) assetsubCompParams
										.get(i);
								PCode = assetPumpsetsTemp.getOtherCompCode();

							}
						}
						session.setAttribute("assetsubCompParams", "OandM");
						Debug.println("session set to mis");
						return mapping.findForward("params");

					}
					if (typeOfAssetCode.equals("07")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_Ponds assetPonds;
						Debug.println("in ponds params");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ponds");
						Debug.println("size of assetsubCompParams is "
								+ assetsubCompParams.size());
						assetForm.setAssetPonds(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							Debug.println("in if");
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								assetPonds = (Asset_Ponds) assetsubCompParams
										.get(i);
								//to remove
								assetsubCompParams.clear();
								assetsubCompParams.add(assetPonds);
								//end
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
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "PD001";
							tempPCode = phCode;
							Debug
									.println("tempPCode or phCode is "
											+ tempPCode);
							session.setAttribute("phCode", tempPCode);
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_Ponds());
							assetForm.setAssetPonds(assetsubCompParams);
							return mapping.findForward("ponds");
						}
					}

					if (typeOfAssetCode.equals("08")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) 
					{
						Asset_Others assetOthers;
						
						Debug.println("in others paramsJJJJJJJJJJJJJJJJJJJJJJJJJ"+request.getParameter("pumpCode"));
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Others");
						Debug.println("size of assetsubCompParams is "+ assetsubCompParams.size());
						assetForm.setAssetOthers(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) 
						{
							Debug.println("in if"+size);
							
							for (int i = 0; i < assetsubCompParams.size(); i++)
							{
								
								assetOthers = (Asset_Others) assetsubCompParams.get(i);
								//assetsubCompParams.clear();
								//assetsubCompParams.add(assetOthers);
								//PCode = assetOthers.getGeneralCode();
								Debug.println("in if tslno"+tslno);
								PCode = assetOthers.getGeneralCode();
								
								phCode = PCode;

								PCode = PCode.substring(21, 24);
								
								slno = Integer.parseInt(PCode);
								Debug.println("in if slno"+slno);
								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
								session.setAttribute("phCode", tempPCode);
								Debug.println("in if"+tempPCode);
							}
							assetForm.setAssetOthers(assetsubCompParams);
							return mapping.findForward("ponds");
						} else 
						{
							Debug.println("in else");
							Asset_Others asset_others = new Asset_Others();
							
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "OT001";
							tempPCode = phCode;
							Debug.println("tempPCode or phCode is "	+ tempPCode);
							session.setAttribute("phCode", tempPCode);
							session.setAttribute("assetCode", request.getParameter("assetCode"));
							assetsubCompParams.clear();
							assetsubCompParams.add(new Asset_Others());
							assetForm.setAssetOthers(assetsubCompParams);
							asset_others.setGeneralCode(phCode);
							return mapping.findForward("ponds");
						}
					}

					//@author end
					Debug.println("checking 01 02 001");
					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println("it rawWater");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams",
								"RawWaterCollectionWell");
						assetForm.setAssetHeadWorks(assetsubCompParams);
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("002")) {
						Debug.println("size pump details is sadiq");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SSTank");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details at line 3089 is "
								+ size);

						if (size > 0) {

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("003")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "SSFilters");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is at line 3127 "
								+ size);

						if (size > 0) {

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("004")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "RSFilters");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details 3166 is " + size);

						if (size > 0) {
							Debug.println("in if");

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
								PCode = rwsMaster.getWtpCode();
								Debug.println("pcode=" + PCode);
								phCode = PCode;
								Debug.println("phcode=" + phCode);

								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									Debug.println("in tslno<slno");
									tslno = slno;
									tempPCode = phCode;
								}

							}
							Debug.println("end of if");
						} else {
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							Debug.println("PCode=" + PCode);
							String Scode = request.getParameter("pumpCode");
							Debug.println("Scode=" + Scode);
							phCode = PCode + Scode + "RS";
							tempPCode = phCode;
							Debug.println("end of else");

						}

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("010")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams",
								"MicroFilters");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is at line 3127 "
								+ size);

						if (size > 0) {
							Debug.println("in if");
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "MS";
							tempPCode = phCode;

						}
						Debug.println("tamp Pcode:" + tempPCode);
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("011")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "RoPlants");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is at line 3127 "
								+ size);

						if (size > 0) {
							Debug.println("in if");
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "RO";
							tempPCode = phCode;

						}
						Debug.println("tamp Pcode:" + tempPCode);
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("005")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Sump");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details 3205 is " + size);

						if (size > 0) {

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("006")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));

						session.setAttribute("assetsubCompParams",
								"FootpathBridge");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("007")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "PumpHouse");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("008")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams",
								"WatchManQuarter");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("009")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams",
								"ClearWaterCollectionWell");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")
							&& assetSubCompTypeCode.equals("010")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "MSFilters");
						session.setAttribute("assetHeadWorks",
								assetsubCompParams);
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details 3166 is " + size);

						if (size > 0) {
							Debug.println("in if");

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
								PCode = rwsMaster.getWtpCode();
								Debug.println("pcode=" + PCode);
								phCode = PCode;
								Debug.println("phcode=" + phCode);

								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);
								if (tslno < slno) {
									Debug.println("in tslno<slno");
									tslno = slno;
									tempPCode = phCode;
								}

							}
							Debug.println("end of if");
						} else {
							Debug.println("in else");
							PCode = request.getParameter("habCode");
							Debug.println("PCode=" + PCode);
							String Scode = request.getParameter("pumpCode");
							Debug.println("Scode=" + Scode);
							phCode = PCode + Scode + "MS";
							tempPCode = phCode;
							Debug.println("end of else");

						}
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("001")) {

						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ohsr");
						Debug.println("assetsubCompParams size is"
								+ assetsubCompParams.size());
						Debug.println("setting assetReservior in session");
						session.setAttribute("assetReserviorOhsr",
								new ArrayList(assetsubCompParams));
						Debug.println("assetReservior size is "
								+ ((ArrayList) session
										.getAttribute("assetReserviorOhsr"))
										.size());
						session.setAttribute("a", "aaaaaaa");
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);

						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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
					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Ohbr");
						session.setAttribute("assetReservior",
								assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);

						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("003")) {

						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Glsr");
						session.setAttribute("assetReservior",
								assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						session.setAttribute("assetReserviorGlsr",
								new ArrayList(assetsubCompParams));
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);

						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("004")) {

						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "Glbr");
						session.setAttribute("assetReservior",
								assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);

						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("005")) {
						Debug.println("size pump details is ");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "BPT");
						session.setAttribute("assetReservior",
								assetsubCompParams);
						assetForm.setAssetReservior(assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);

						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							&& assetCompTypeCode.equals("04")
							&& assetSubCompTypeCode.equals("006")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						assetForm.setAssetReservior(assetsubCompParams);
						session.setAttribute("assetsubCompParams", "Cisterns");
						session.setAttribute("assetReservior",
								assetsubCompParams);
						session.setAttribute("assetReserviorCis",
								new ArrayList(assetsubCompParams));
						int size = assetsubCompParams.size();
						Debug.println("size pump details is " + size);
						if (size > 0) {
							Asset_Reservior asset_reservoir;
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								asset_reservoir = (Asset_Reservior) assetsubCompParams
										.get(i);
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
					}

					else {
						session.removeAttribute("assetsubCompParams");

					}
					Debug.println("assetsubCompParams.size()= "
							+ assetsubCompParams.size());
					/*
					 * if (tslno == 0) { tempPCode = tempPCode.substring(0, 21) +
					 * "001";
					 *  } else if (tslno <= 8) { tempPCode =
					 * tempPCode.substring(0, 21) + "00" + (tslno + 1); } else
					 * if (tslno <= 98) { tempPCode = tempPCode.substring(0, 21) +
					 * "0" + (tslno + 1); } else { tempPCode =
					 * tempPCode.substring(0, 21) + (tslno + 1); }
					 */
					Debug.println("going to getNextSubComponentCode:"
							+ tempPCode);
					if (!typeOfAssetCode.equals("07")
							&& tempPCode.length() == 24)
						tempPCode = getNextSubComponentCode(tempPCode);

					session.setAttribute("phCode", tempPCode);
					Debug.println("temp code is" + tempPCode + "sadiq");

				} catch (Exception e) {
					Debug.writeln("error is " + e);
				}
			}
			if (mode.equalsIgnoreCase("Submit"))
			{
				Debug.println("in Submit mode");
				try {
					int rowCount = 0;
					assetsubCompTempParams.clear();

					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					Debug.println("Type opf asset code is  " + typeOfAssetCode);
					Debug.println("asset code(14 digit) is  " + assetCd);
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request
							.getParameter("assetTypeCode");
					Debug.println("assetCode=" + assetTypeCode
							+ "assetCompTypeCode=" + assetCompTypeCode
							+ "assetSubCompTypeCode=" + assetSubCompTypeCode
							+ "assetTypeCode=" + assetTypeCode);
					Debug.println("Enter to submit block");
					if (assetSubComps.size() > 0)
						assetSubComps.clear();
					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						Asset_SubComponent asset_subComponent = new Asset_SubComponent(
								request.getParameter("location"),
								request.getParameter("yearOfDrilling"),
								(request.getParameter("diameter")),
								request.getParameter("casing"),
								request.getParameter("status"),
								request.getParameter("genCondition"),
								request.getParameter("gino"),
								request.getParameter("painted"),
								request.getParameter("staticWaterLevel"),
								request.getParameter("summerWaterLevel"),
								request.getParameter("pcond"),
								request.getParameter("dryduring"),
								request.getParameter("service"),
								request.getParameter("serno"),
								request.getParameter("serhrs"),
								request.getParameter("repairs"),
								request.getParameter("platformCondition"),
								request.getParameter("drain"),
								request.getParameter("drainCondition"),
								request.getParameter("drainsd"),
								request.getParameter("drainlp"),
								request.getParameter("hygiene"),
								request.getParameter("avgtime"),
								request.getParameter("pyield"),
								request.getParameter("pyieldLocal"),
								request.getParameter("period"),
								request.getParameter("qualityAffected"),
								Double.parseDouble(request
										.getParameter("flouride")),
								Double.parseDouble(request
										.getParameter("brakish")),
								Double
										.parseDouble(request
												.getParameter("iron")),
								Integer.parseInt(request.getParameter("depth")),
								request.getParameter("hpCode"), request
										.getParameter("assetCode"), request
										.getParameter("otherspecify"), request
										.getParameter("pipeLength"));
						Debug.println("quality effected is "
								+ request.getParameter("qualityAffected"));
						assetSubComps.add(asset_subComponent);
						assetForm.setAssetSubComponents(assetSubComps);
						Debug.println("size of getAssetSubComponents  "
								+ assetSubComps.size());
						rowCount = RwsMasterData.removeAssetSubComp(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetSubComponents(), "Source");
						mode = "pumpset";
					}
					/*
					 * else if (typeOfAssetCode.equals("01") &&
					 * assetCompTypeCode.equals("03") &&
					 * assetSubCompTypeCode.equals("003")) { asset_pipeline =
					 * new Asset_PipeLine(); Asset_PipeLine asset_Pipeline = new
					 * Asset_PipeLine( request.getParameter("pmCode"),
					 * request.getParameter("assetCode"),
					 * request.getParameter("noOfPipes"),
					 * request.getParameter("pmCond"),
					 * request.getParameter("pmRep"),
					 * request.getParameter("pmNat"),
					 * request.getParameter("pmAvNo"),
					 * request.getParameter("pmScrvNo"),
					 * request.getParameter("pmSvNo"),
					 * request.getParameter("pmRvNo"));
					 * assetSubComps.add(asset_Pipeline);
					 * assetForm.setAssetPipeLine(assetSubComps);
					 * Debug.println("this in insert"); //String
					 * assetCd=(String)session.getAttribute("assetCd"); rowCount =
					 * RwsMasterData.removeAssetSubComp( getDataSource(request),
					 * assetCd, assetCompTypeCode, assetSubCompTypeCode,
					 * assetTypeCode, opType, assetForm.getAssetPipeLine(),
					 * "Pipeline");
					 *  }
					 */
					//this code for deleting pumping main
					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println("in pumping main in submit mode");
						opType = (String) request.getParameter("opType");
						//if(opType!=null && opType.equals("delete"))
						//{
						request.getParameter("pmCode");
						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in pumpingmain delete");

						rowCount = RwsMasterData.deletePipeLineSubComp(
								getDataSource(request), (String) request
										.getParameter("pmCode"),
								typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);
						//@code to get next subcomponent in place of deleted
						// one

						ArrayList nextSubCompDetails = new ArrayList();
						Debug.println("calling nextRecord from rwsmasterdata");
						Debug.println("habCode is "
								+ request.getParameter("habCode"));
						int totRecords = Integer.parseInt((String) session
								.getAttribute("totRecords"));
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData
									.getAssetNextSubCompParams(
											getDataSource(request), assetForm
													.getAssetCode(),
											assetTypeCode, assetCompTypeCode,
											assetSubCompTypeCode,
											(String) request
													.getParameter("habCode"),
											(String) request
													.getParameter("pmCode"),
											"previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData
										.getAssetNextSubCompParams(
												getDataSource(request),
												assetForm.getAssetCode(),
												assetTypeCode,
												assetCompTypeCode,
												assetSubCompTypeCode,
												(String) request
														.getParameter("habCode"),
												(String) request
														.getParameter("pmCode"),
												"next");
							Debug.println("nextRecord size is "
									+ nextRecord.size());
							assetForm.setAssetPipeLine(nextRecord);

							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0))
											.getCurrentRow()
											+ "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0))
											.getRowCount()
											+ "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord
									.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == 1)
								request.setAttribute("previousNotExists",
										"true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists",
										"true");
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

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						Debug.println("in gravity main");
						opType = (String) request.getParameter("opType");
						//if(opType!=null && opType.equals("delete"))
						//{
						request.getParameter("gravitymain_code");
						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in gravitymain delete");

						rowCount = RwsMasterData.deletePipeLineSubComp(
								getDataSource(request), (String) request
										.getParameter("gravitymain_code"),
								typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);
						Debug.println("session.setAttribute:"
								+ (String) session.getAttribute("totRecords"));

						//	@code to get next subcomponent in place of deleted
						// one

						ArrayList nextSubCompDetails = new ArrayList();
						Debug.println("calling nextRecord from rwsmasterdata");
						Debug.println("habCode is "
								+ request.getParameter("habCode"));
						int totRecords = Integer.parseInt((String) session
								.getAttribute("totRecords"));
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData
									.getAssetNextSubCompParams(
											getDataSource(request),
											assetForm.getAssetCode(),
											assetTypeCode,
											assetCompTypeCode,
											assetSubCompTypeCode,
											(String) request
													.getParameter("habCode"),
											(String) request
													.getParameter("gravitymain_code"),
											"previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData
										.getAssetNextSubCompParams(
												getDataSource(request),
												assetForm.getAssetCode(),
												assetTypeCode,
												assetCompTypeCode,
												assetSubCompTypeCode,
												(String) request
														.getParameter("habCode"),
												(String) request
														.getParameter("gravitymain_code"),
												"next");
							Debug.println("nextRecord size is "
									+ nextRecord.size());
							assetForm.setAssetPipeLine(nextRecord);

							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0))
											.getCurrentRow()
											+ "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0))
											.getRowCount()
											+ "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord
									.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == 1)
								request.setAttribute("previousNotExists",
										"true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists",
										"true");
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

						//end of @code

						//String
						// assetCd=(String)session.getAttribute("assetCd");

						//}

					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						Debug.println("in distribution delete");
						opType = (String) request.getParameter("opType");
						Debug.println("opType is " + opType);
						//if(opType!=null && opType.equals("delete"))
						//{

						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in distribution delete");
						Debug.println("session.setAttribute:"
								+ (String) session.getAttribute("totRecords"));
						int totRecords = Integer.parseInt((String) session
								.getAttribute("totRecords"));
						rowCount = RwsMasterData.deletePipeLineSubComp(
								getDataSource(request), (String) request
										.getParameter("disCode"),
								typeOfAssetCode, assetCompTypeCode,
								assetSubCompTypeCode);

						//@code to get next subcomponent in place of deleted
						// one

						ArrayList nextSubCompDetails = new ArrayList();
						Debug.println("calling nextRecord from rwsmasterdata");
						Debug.println("habCode is "
								+ request.getParameter("habCode"));
						if (totRecords > 1) {
							ArrayList nextRecord = RwsMasterData
									.getAssetNextSubCompParams(
											getDataSource(request), assetForm
													.getAssetCode(),
											assetTypeCode, assetCompTypeCode,
											assetSubCompTypeCode,
											(String) request
													.getParameter("habCode"),
											(String) request
													.getParameter("disCode"),
											"previous");
							if (nextRecord.size() == 0)
								nextRecord = RwsMasterData
										.getAssetNextSubCompParams(
												getDataSource(request),
												assetForm.getAssetCode(),
												assetTypeCode,
												assetCompTypeCode,
												assetSubCompTypeCode,
												(String) request
														.getParameter("habCode"),
												(String) request
														.getParameter("disCode"),
												"next");
							Debug.println("nextRecord size is "
									+ nextRecord.size());
							assetForm.setAssetPipeLine(nextRecord);

							request.setAttribute("currentRow",
									((Asset_PipeLine) nextRecord.get(0))
											.getCurrentRow()
											+ "");
							request.setAttribute("totalRecords",
									((Asset_PipeLine) nextRecord.get(0))
											.getRowCount()
											+ "");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == ((Asset_PipeLine) nextRecord
									.get(0)).getRowCount())
								request.setAttribute("nextNotExists", "true");

							if (((Asset_PipeLine) nextRecord.get(0))
									.getCurrentRow() == 1)
								request.setAttribute("previousNotExists",
										"true");

							if (nextRecord.size() == 0) {
								request.setAttribute("previousNotExists",
										"true");
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

						//end of @code

						//String
						// assetCd=(String)session.getAttribute("assetCd");

						//}

					}
					Debug.println("Row Count:" + rowCount);
					if (rowCount > 0) {
						message = "Record Deleted ";
						Debug.println("record Deleted");
						String bwCount = (String) session
								.getAttribute("bwCount");
						int bwCnt = Integer.parseInt(bwCount);
						Debug.println("value of bwCont is  " + bwCnt);
						bwCnt = bwCnt + 1;
						//assetsubCompParams = (ArrayList)
						// session.getAttribute("assetsubCompPWSParams");
						int size = assetsubCompParams.size();

						if (size > bwCnt) {
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(bwCnt));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);

							bwCount = String.valueOf(bwCnt);
							session.setAttribute("bwCount", bwCount);
							Debug.println("parms  borweel size is "
									+ assetsubCompTempParams.size());
						} else {

							assetsubCompTempParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							rwsMaster.setPmpCode((String) session
									.getAttribute("phCode"));
							assetsubCompTempParams.add(asset_subcomponent);
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
						}
					} else {

						message = "The Record Cant be Deleted";
						Debug.println("  not Deleted");
					}
					request.setAttribute("message", message);
					if (!typeOfAssetCode.equals("04"))
						return (mapping.findForward("pumpset"));
				} catch (Exception e) {
					Debug.println("Error in Submit:" + e.getMessage());
				}
			}

			if (mode.equalsIgnoreCase("addSubCompPump")) {
				Debug.println("in addSubCompPump mode");
				try {
					int rowCount = 0;
					////

					////
					assetsubCompTempParams.clear();
					Debug.println("in addSubCompPump");
					//String assetCd = (String)
					// session.getAttribute("assetCode");
					String assetCd = request.getParameter("assetCode");
					//if(assetCd==null || (assetCd!=null &&
					// assetCd.equals("")))assetCd = (String)
					// session.getAttribute("assetCode");
					Debug.println("in addSubCompPump with asset code:"
							+ assetCd);
					request.setAttribute("assetCode", assetCd);
					typeOfAssetCode = request.getParameter("assetTypeCode");
					Debug.println("Type opf asset code is  " + typeOfAssetCode);
					Debug.println("asset code(14 digit) is  " + assetCd);
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request
							.getParameter("assetTypeCode");
					Debug.println("assetCode=" + assetTypeCode
							+ "assetCompTypeCode=" + assetCompTypeCode
							+ "assetSubCompTypeCode=" + assetSubCompTypeCode
							+ "assetTypeCode=" + assetTypeCode);

					assetsubCompTempParams.clear();
					assetsubCompParams.clear();
					assetsubCompParams = assetForm.getAssetPumpSets();
					//@author santosh code added on 271106

					String[] addIds = request.getParameterValues("remove");
					if (addIds != null)
						Debug.println("addIds.length()" + addIds.length);
					if (addIds != null && addIds.length != 0) {
						Debug.println("in if addIds");
						for (int p = 0; p < addIds.length; p++) {
							Debug.println("in for");
							Debug.println("addIds[" + p + "] : " + addIds[p]);
							assetsubCompTempParams.add(assetsubCompParams
									.get(Integer.parseInt(addIds[p])));
							Debug.println(" end of for");
						}
						Debug.println("in others123");

						/////*****************************
						if (!assetCompTypeCode.equals("06")
								&& !assetSubCompTypeCode.equals("001"))
							assetForm.setAssetPumpSets(assetsubCompTempParams);
						////********************************

						Debug.println("entering rwsmasterdata");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetPumpSets(), "Others");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPumpSets(assetsubCompParams);

					}

					Debug.println("end others");

					/////
					if (typeOfAssetCode.equals("07")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {

						Asset_Ponds asset_ponds = new Asset_Ponds();
						asset_ponds.setAssetCode(request
								.getParameter("assetCode"));
						Debug.println("asset code in form is "
								+ request.getParameter("assetCode"));
						asset_ponds.setHabCode(request.getParameter("habCode"));
						//	code added by pranavi
						asset_ponds.setHabitation(request
								.getParameter("habitation"));
						asset_ponds.setPondCode(request
								.getParameter("pondCode"));
						asset_ponds.setName(request.getParameter("name"));
						asset_ponds.setLocation(request
								.getParameter("location"));
						asset_ponds.setAreaSize(request
								.getParameter("areaSize"));
						asset_ponds.setVolumeOfStorage(request
								.getParameter("volumeOfStorage"));
						Debug.println("hygeinity is "
								+ request.getParameter("hygeinity"));
						asset_ponds.setHygeinity(request
								.getParameter("hygeinity"));
						Debug.println("hygeinity in asset_ponds is "
								+ asset_ponds.getHygeinity());
						asset_ponds.setPurpose(request.getParameter("purpose"));
						asset_ponds.setFedBy(request.getParameter("fedBy"));
						asset_ponds.setFedName(request.getParameter("fedName"));
						asset_ponds.setFedOthersName(request
								.getParameter("fedOthersName"));
						asset_ponds.setWaterQuality(request
								.getParameter("waterQuality"));
						asset_ponds.setFloride(request.getParameter("floride"));
						asset_ponds.setBrakish(request.getParameter("brakish"));
						asset_ponds.setIron(request.getParameter("iron"));
						asset_ponds.setOthersType(request
								.getParameter("othersType"));
						asset_ponds.setOthers(request.getParameter("others"));

						assetSubComps.add(asset_ponds);

						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps, "Ponds");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_ponds.setAssetCode(assetCd);
							assetSubComps.add(asset_ponds);
							assetForm.setAssetPonds(assetSubComps);
						}
						mode = "ponds";
					}

					if (typeOfAssetCode.equals("05")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {

						Asset_SHP asset_SHP = new Asset_SHP();
						asset_SHP.setAssetCode(request
								.getParameter("assetCode"));
						asset_SHP.setHabCode(request.getParameter("habCode"));
						//					code added by pranavi
						asset_SHP.setHabitation(request
								.getParameter("habitation"));
						asset_SHP.setShallowHandPumpCode(request
								.getParameter("shallowHandPumpCode"));
						asset_SHP.setLocation(request.getParameter("location"));
						asset_SHP.setDiameter(request.getParameter("diameter"));
						asset_SHP.setDepth(request.getParameter("depth"));
						asset_SHP.setHygiene(request.getParameter("hygiene"));
						asset_SHP.setAvgNoOfHoursWorkingPerDay(request
								.getParameter("avgNoOfHoursWorkingPerDay"));
						asset_SHP.setAvgTimeToFill(request
								.getParameter("avgTimeToFill"));
						asset_SHP.setYeild(request.getParameter("yeild"));
						asset_SHP.setWaterQuality(request
								.getParameter("waterQuality"));
						asset_SHP.setFloride(request.getParameter("floride"));
						asset_SHP.setBrakish(request.getParameter("brakish"));
						asset_SHP.setIron(request.getParameter("iron"));
						asset_SHP.setOthersType(request
								.getParameter("othersType"));
						asset_SHP.setOthers(request.getParameter("others"));
						//					added by swapna on 20-01-2012 for gis data entry
						asset_SHP.setLatitude(request.getParameter("latitude"));
						asset_SHP.setLongitude(request
								.getParameter("longitude"));
						asset_SHP.setElevation(request
								.getParameter("elevation"));
						asset_SHP.setWaypoint(request.getParameter("waypoint"));
						//
						assetSubComps.add(asset_SHP);

						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps, "Ponds");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_SHP.setAssetCode(assetCd);
							assetSubComps.add(asset_SHP);
							assetForm.setAssetSHP(assetSubComps);
						}
						mode = "ponds";
						Debug.println("mode is " + mode);
						//return mapping.findForward(mode);
					}

					if (typeOfAssetCode.equals("06")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {

						Asset_OpenWells asset_openWells = new Asset_OpenWells();
						asset_openWells.setAssetCode(request
								.getParameter("assetCode"));
						Debug.println("asset code in form is "
								+ request.getParameter("assetCode"));
						asset_openWells.setHabCode(request
								.getParameter("habCode"));
						//					code added by pranavi
						asset_openWells.setHabitation(request
								.getParameter("habitation"));
						asset_openWells.setOpenWellCode(request
								.getParameter("openWellCode"));
						asset_openWells.setLocation(request
								.getParameter("location"));
						asset_openWells.setDiameter(request
								.getParameter("diameter"));
						asset_openWells.setDepth(request.getParameter("depth"));

						asset_openWells.setNormalWaterLevel(request
								.getParameter("normalWaterLevel"));

						asset_openWells.setMinimumWaterLevel(request
								.getParameter("minimumWaterLevel"));
						asset_openWells.setMaximumWaterLevel(request
								.getParameter("maximumWaterLevel"));
						asset_openWells.setPlatformExists(request
								.getParameter("platformExists"));
						asset_openWells.setPlatformCondition(request
								.getParameter("platformCondition"));
						asset_openWells.setPurpose(request
								.getParameter("purpose"));
						asset_openWells.setWaterQuality(request
								.getParameter("waterQuality"));
						asset_openWells.setFloride(request
								.getParameter("floride"));
						asset_openWells.setBrakish(request
								.getParameter("brakish"));
						asset_openWells.setIron(request.getParameter("iron"));
						asset_openWells.setOthers(request
								.getParameter("others"));
						asset_openWells.setOthersType(request
								.getParameter("othersType"));
						//added by swapna on 20-01-2012 for gis data entry
						asset_openWells.setLatitude(request
								.getParameter("latitude"));
						asset_openWells.setLongitude(request
								.getParameter("longitude"));
						asset_openWells.setElevation(request
								.getParameter("elevation"));
						asset_openWells.setWaypoint(request
								.getParameter("waypoint"));
						//
						assetSubComps.add(asset_openWells);

						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps, "SHP");
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

					if (typeOfAssetCode.equals("08")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) 
					{

						Asset_Others asset_others = new Asset_Others();
						asset_others.setAssetCode(request.getParameter("assetCode"));
						Debug.println("asset code in form is "+ request.getParameter("assetCode"));
						asset_others
								.setHabCode(request.getParameter("habCode"));
						asset_others.setGeneralCode(request
								.getParameter("generalCode"));
						asset_others.setLocation(request
								.getParameter("location"));
						asset_others.setComponentName(request
								.getParameter("componentName"));
						asset_others
								.setRemarks(request.getParameter("remarks"));
						assetSubComps.add(asset_others);

						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps, "Others");
						rowCount = daoMessage.getRowCount();
						if (rowCount > 0) {
							assetSubComps.clear();
							asset_others.setAssetCode(assetCd);
							assetSubComps.add(asset_others);
							assetForm.setAssetOthers(assetSubComps);
						}
						mode = "ponds";
					}

					////

					if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {

						asset_subcomponent = new Asset_SubComponent();
						Debug.println("drain  is  "
								+ request.getParameter("drain"));
						asset_subcomponent.setLocation(request
								.getParameter("location"));
						//code modified by pranavi
						asset_subcomponent.setHabitation(request
								.getParameter("habitation"));
						//asset_subcomponent.setYearOfDrilling(request.getParameter("yearOfDrilling");
						asset_subcomponent.setDiameter(request
								.getParameter("diameter"));
						asset_subcomponent.setCasing(request
								.getParameter("casing"));
						//asset_subcomponent.setstatus(request.getParameter("status"));
						asset_subcomponent.setGenCondition(request
								.getParameter("genCondition"));
						asset_subcomponent.setPipeLength(request
								.getParameter("pipeLength"));
						asset_subcomponent
								.setGino(request.getParameter("gino"));
						asset_subcomponent.setPainted(request
								.getParameter("painted"));
						asset_subcomponent.setStaticWaterLevel(request
								.getParameter("staticWaterLevel"));
						asset_subcomponent.setSummerWaterLevel(request
								.getParameter("summerWaterLevel"));
						asset_subcomponent.setPcond(request
								.getParameter("pcond"));
						//asset_subcomponent.setDryduring(request.getParameter("dryduring"));
						//asset_subcomponent.setService(request.getParameter("service"));
						asset_subcomponent.setSerno(request
								.getParameter("serno"));
						asset_subcomponent.setSerhrs(request
								.getParameter("serhrs"));
						asset_subcomponent.setRepairs(request
								.getParameter("repairs"));
						asset_subcomponent.setPlatformCondition(request
								.getParameter("platformCondition"));
						asset_subcomponent.setDrain(request
								.getParameter("drain"));
						asset_subcomponent.setDrainCondition(request
								.getParameter("drainCondition"));
						asset_subcomponent.setDrainsd(request
								.getParameter("drainsd"));
						asset_subcomponent.setDrainlp(request
								.getParameter("drainlp"));
						asset_subcomponent.setHygiene(request
								.getParameter("hygiene"));
						asset_subcomponent.setAvgtime(request
								.getParameter("avgtime"));
						asset_subcomponent.setPyield(request
								.getParameter("pyield"));
						asset_subcomponent.setPyieldLocal(request
								.getParameter("pyieldLocal"));
						asset_subcomponent.setPeriod(request
								.getParameter("period"));
						//asset_subcomponent.setPeriod(request.getParameter("qualityAffected"));
						asset_subcomponent.setQualityAffected(request
								.getParameter("qualityAffected"));

						if (request.getParameter("flouride") != null
								&& !request.getParameter("flouride").equals(""))
							asset_subcomponent.setFlouride(Double
									.parseDouble(request
											.getParameter("flouride")));
						if (request.getParameter("brakish") != null
								&& !request.getParameter("brakish").equals(""))
							asset_subcomponent.setBrakish(Double
									.parseDouble(request
											.getParameter("brakish")));
						if (request.getParameter("iron") != null
								&& !request.getParameter("iron").equals(""))
							asset_subcomponent.setIron(Double
									.parseDouble(request.getParameter("iron")));
						if (request.getParameter("depth") != null
								&& !request.getParameter("depth").equals(""))
							asset_subcomponent.setDepth(Integer
									.parseInt(request.getParameter("depth")));

						asset_subcomponent.setHpCode(request
								.getParameter("hpCode"));
						asset_subcomponent.setAssetCode(request
								.getParameter("assetCode"));
						asset_subcomponent.setOtherspecify(request
								.getParameter("otherspecify"));
						asset_subcomponent.setOthers(request
								.getParameter("others"));
						Debug.println("value of others is "
								+ request.getParameter("others"));
						asset_subcomponent.setOthersType(request
								.getParameter("othersType"));
						Debug.println("value of othersType is "
								+ request.getParameter("othersType"));
						//							added by swapna on 20-01-2012 for gis data entry
						asset_subcomponent.setLatitude(request
								.getParameter("latitude"));
						asset_subcomponent.setLongitude(request
								.getParameter("longitude"));
						asset_subcomponent.setElevation(request
								.getParameter("elevation"));
						asset_subcomponent.setWaypoint(request
								.getParameter("waypoint"));
						//
						assetSubComps.add(asset_subcomponent);
						assetForm.setAssetSubComponents(assetSubComps);
						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetSubComponents(), "Source");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("001")) {
						opType = "Modify";
						assetSubComps.clear();
						asset_pipeline = new Asset_PipeLine();
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine(
								request.getParameter("pmCode"), request
										.getParameter("assetCode"), request
										.getParameter("noOfPipes"), request
										.getParameter("pmCond"), request
										.getParameter("pmRep"), request
										.getParameter("pmNat"), request
										.getParameter("pmAvNo"), request
										.getParameter("pmScrvNo"), request
										.getParameter("pmSvNo"), request
										.getParameter("pmRvNo"));
						asset_Pipeline.setHabCode(request
								.getParameter("habCode"));
						asset_Pipeline.setPmZeroVelocityValve(request
								.getParameter("pmZeroVelocityValve"));
						asset_Pipeline.setPmAirCusionValve(request
								.getParameter("pmAirCusionValve"));
						asset_Pipeline.setPmNonReturnValve(request
								.getParameter("pmNonReturnValve"));
						asset_Pipeline.setPmLocation(request
								.getParameter("pmLocation"));

						Debug.println("habCode is "
								+ asset_pipeline.getHabCode());
						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps,
								"Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams",
								"PwsPumpingMain");
					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						opType = "Modify";
						Debug.println("in addSubCompPump 03 002");
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine();
						asset_Pipeline.setGravitymain_code((String) request
								.getParameter("gravitymain_code"));
						asset_Pipeline.setHabCode(request
								.getParameter("habCode"));
						Debug
								.println("gravity main code is before going to rws master "
										+ request
												.getParameter("gravitymain_code"));
						//asset_Pipeline.setAssetCode((String)request.getParameter("assetCode"));
						asset_Pipeline.setLengths((String) request
								.getParameter("lengths"));
						asset_Pipeline.setAirvalve_no((String) request
								.getParameter("airvalve_no"));
						asset_Pipeline.setScourevalve((String) request
								.getParameter("scourevalve"));
						asset_Pipeline.setReflexvalve((String) request
								.getParameter("reflexvalve"));
						asset_Pipeline.setSluicevalve((String) request
								.getParameter("sluicevalve"));
						asset_Pipeline.setZeroVelocityValve((String) request
								.getParameter("zeroVelocityValve"));
						asset_Pipeline.setAirCushionValve((String) request
								.getParameter("airCushionValve"));
						asset_Pipeline.setNonReturnValve((String) request
								.getParameter("nonReturnValve"));
						asset_Pipeline.setGravitymain_location((String) request
								.getParameter("gravitymain_location"));
						asset_Pipeline.setMet_type((String) request
								.getParameter("met_type"));
						Debug
								.println("gravity main code is before going to rws master "
										+ asset_Pipeline.getGravitymain_code());
						Debug
								.println("asset  code is before going to rws master "
										+ asset_Pipeline.getAssetCode());

						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetSubComps,
								"Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams",
								"GravityMain");

					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						opType = "Modify";
						Debug.println("in add distribution 03 003");
						asset_pipeline = new Asset_PipeLine();
						Asset_PipeLine asset_Pipeline = new Asset_PipeLine();
						asset_Pipeline.setHabCode(request
								.getParameter("habCode"));
						asset_Pipeline.setDisCode(request
								.getParameter("disCode"));
						asset_Pipeline.setDisHabCode(request
								.getParameter("disHabCode"));
						asset_Pipeline.setDisLocation(request
								.getParameter("disLocation"));
						asset_Pipeline.setDisTotalLengthNeeded(request
								.getParameter("disTotalLengthNeeded"));
						asset_Pipeline.setDisTotalLengthProvided(request
								.getParameter("disTotalLengthProvided"));
						asset_Pipeline.setDisFullVillagesCovered(request
								.getParameter("disFullVillagesCovered"));
						asset_Pipeline.setDisBalanceNeeded(request
								.getParameter("disBalanceNeeded"));
						asset_Pipeline.setDisNoOfAirValves(request
								.getParameter("disNoOfAirValves"));
						asset_Pipeline.setDisNoOfSluiceValves(request
								.getParameter("disNoOfSluiceValves"));
						asset_Pipeline.setDisNoOfStandPosts(request
								.getParameter("disNoOfStandPosts"));
						asset_Pipeline.setDisNoOfScourValves(request
								.getParameter("disNoOfScourValves"));
						asset_Pipeline
								.setDisNoOfPrivateHouseConnections(request
										.getParameter("disNoOfPrivateHouseConnections"));

						assetSubComps.add(asset_Pipeline);
						assetForm.setAssetPipeLine(assetSubComps);
						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetPipeLine(), "Pipeline");
						rowCount = daoMessage.getRowCount();
						mode = "pumpset";
						session.setAttribute("assetsubCompParams",
								"Distribution");

					}

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("06")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println("in addSubCompPump pumpset");
						assetSubComps.clear();

						//asset_pumpsetList = assetForm.getAssetPumpSets();
						asset_pumpset.setAssetCode(RwsMasterData
								.format((String) request
										.getParameter("assetCode")));
						Debug.println("asset code in form bean is "
								+ (String) request.getParameter("assetCode"));
						asset_pumpset.setPumpCode(RwsMasterData
								.format((String) request
										.getParameter("pumpCode")));
						asset_pumpset.setPumpLocation(RwsMasterData
								.format((String) request
										.getParameter("pumpLocation")));
						asset_pumpset.setPumpMake(RwsMasterData
								.format((String) request
										.getParameter("pumpMake")));
						asset_pumpset.setPumpType(RwsMasterData
								.format((String) request
										.getParameter("pumpType")));
						asset_pumpset.setPumpCapacity(RwsMasterData
								.format((String) request
										.getParameter("pumpCapacity")));
						asset_pumpset
								.setPumpYearOfCommissioning(RwsMasterData
										.format((String) request
												.getParameter("pumpYearOfCommissioning")));
						asset_pumpset
								.setPumpHoursRunningPerDay(RwsMasterData
										.format((String) request
												.getParameter("pumpHoursRunningPerDay")));
						asset_pumpset.setPumpDesignedHead(RwsMasterData
								.format((String) request
										.getParameter("pumpDesignedHead")));
						asset_pumpset.setPumpDesignedLpm(RwsMasterData
								.format((String) request
										.getParameter("pumpDesignedLpm")));
						asset_pumpset.setPumpControlPanel(RwsMasterData
								.format((String) request
										.getParameter("pumpControlPanel")));
						asset_pumpset
								.setPumpHoursOfPowerAvailability(RwsMasterData
										.format((String) request
												.getParameter("pumpHoursOfPowerAvailability")));
						asset_pumpset
								.setPumpLowVoltageProblems(RwsMasterData
										.format((String) request
												.getParameter("pumpLowVoltageProblems")));
						asset_pumpset
								.setPumpFeasiblityOfGettingUrbanLine(RwsMasterData
										.format((String) request
												.getParameter("pumpFeasiblityOfGettingUrbanLine")));
						asset_pumpset
								.setPumpAppCostOfUrbanFeeder(RwsMasterData
										.format((String) request
												.getParameter("pumpAppCostOfUrbanFeeder")));
						asset_pumpset
								.setPumpDistanceFromWhereUrbanLineCanBeHad(RwsMasterData
										.format((String) request
												.getParameter("pumpDistanceFromWhereUrbanLineCanBeHad")));
						asset_pumpset
								.setPumpLowVoltabeProblems(RwsMasterData
										.format((String) request
												.getParameter("pumpLowVoltabeProblems")));
						asset_pumpset.setPumpRemarks(RwsMasterData
								.format((String) request
										.getParameter("pumpRemarks")));
						asset_pumpset.setPumpSuggestions(RwsMasterData
								.format((String) request
										.getParameter("pumpSuggestions")));
						asset_pumpset.setGeneratorExisting(RwsMasterData
								.format((String) request
										.getParameter("generatorExisting")));
						asset_pumpset.setGeneratorCapacity(RwsMasterData
								.format((String) request
										.getParameter("generatorCapacity")));
						asset_pumpset.setGeneratorWorking(RwsMasterData
								.format((String) request
										.getParameter("generatorWorking")));
						asset_pumpset.setHabCode(RwsMasterData
								.format((String) request
										.getParameter("habCode")));
						asset_pumpset.setPumpFeeder(RwsMasterData
								.format((String) request
										.getParameter("pumpFeeder")));
						asset_pumpset.setPumpUsage(RwsMasterData
								.format((String) request
										.getParameter("pumpUsage")));
						//added by swapna on 20-01-2012 for gis data entry
						asset_pumpset.setLatitude(RwsMasterData
								.format((String) request
										.getParameter("latitude")));
						asset_pumpset.setLongitude(RwsMasterData
								.format((String) request
										.getParameter("longitude")));
						asset_pumpset.setElevation(RwsMasterData
								.format((String) request
										.getParameter("elevation")));
						asset_pumpset.setWaypoint(RwsMasterData
								.format((String) request
										.getParameter("waypoint")));
						//
						Debug.println("pumpUsage"
								+ (String) request
										.getParameter("pumpSuggestions"));
						//Debug.println("pumpHabCode"+(String)request.getParameter("pumpHabCode"));
						Debug.println("pumpFeeder"
								+ (String) request.getParameter("pumpFeeder"));
						assetSubComps.add(asset_pumpset);
						Debug.println("this in insert");
						Debug.println("pump type is "
								+ asset_pumpset.getPumpType());

						//String
						// assetCd=(String)session.getAttribute("assetCd");
						daoMessage = RwsMasterData
								.insertAssetSubCompParams(
										getDataSource(request), assetCd,
										assetCompTypeCode,
										assetSubCompTypeCode, assetTypeCode,
										opType, assetSubComps, "pumpset");
						rowCount = daoMessage.getRowCount();

						assetForm.setAssetPumpSets(assetSubComps);
						mode = "pumpset";

					}

					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& (assetCompTypeCode.equals("02")
									|| assetCompTypeCode.equals("03") || assetCompTypeCode
									.equals("04"))) {
						message = daoMessage.getMessage();
					} else if (rowCount > 0) {
						message = "Record Saved Successfully";
						Debug.println("record insterted");
					} else {

						message = "The Record Cant be inserted ";
						Debug.println("  not inserted");
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("Error in addResOHSR :" + e);
				}
				//return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("pumpset")) {
				Debug.println("in pumpset mode");
				try {

					session.removeAttribute("phCode");
					Debug.println("in pumpset");
					int bwCnt = 0;
					String bwCount = String.valueOf(bwCnt);
					session.setAttribute("bwCount", bwCount);

					String tempPCode = "", PCode = null, phCode = null;
					int tslno = 0, slno = 0;
					typeOfAssetCode = request.getParameter("assetTypeCode");
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					Debug.println("assetTypeCode  " + typeOfAssetCode
							+ "   assetCompTypeCode " + assetCompTypeCode
							+ "   assetSubCompTypeCode" + assetSubCompTypeCode);

					//@author santosh codded added on 281106

					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("003")) {
						Debug.println(" in pumpset 003");
						assetForm.setAssetPumpSets(new ArrayList());
						assetsubCompParams.clear();
						assetForm.setAssetPumpSets(assetsubCompParams);
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompPWSParams",
								assetsubCompParams);

						int size = assetsubCompParams.size();
						Debug.println("size pump main 3333 is " + size);
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						//to be deleted

						//end
						if (size > 0) {
							//assetsubCompTempParams.add(assetsubCompParams.get(0));
							//assetForm.setAssetSubComponents(assetsubCompTempParams);
							Debug.println("in if");

							assetForm.setAssetPumpSets(assetsubCompParams);

							//@author santosh code added on 281106
							{
								asset_pumpset = (Asset_Pumpset) assetsubCompParams
										.get(0);
								PCode = asset_pumpset.getPumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);

								Debug.println("tslno in 009 is " + tslno);
								slno = Integer.parseInt(PCode);
								Debug.println("slno in 009 is " + slno);
								Debug.println("phCode in 009 is" + phCode);
								if (tslno < slno) {
									Debug.println("in if of tslno");
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);

							//request.setAttribute("previousNotExists","true");

							//@end
						} else {
							Debug.println("in else");
							Debug.println("no records");
							PCode = request.getParameter("habCode");
							Debug.println("hab code is " + habCode);
							String Scode = request.getParameter("pumpCode");
							Debug.println("scode is " + Scode);
							Debug.println("5");
							phCode = PCode + Scode + "PS";
							tempPCode = phCode;
							assetsubCompParams.clear();
							//assetsubCompParams.add(new)
							assetForm.setAssetPumpSets(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (assetSubCompTypeCode.equals("003"))
							session.setAttribute("assetsubCompParams",
									"Pumpsets");

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("06")
							&& assetSubCompTypeCode.equals("001")) {
						Debug.println(" in pumpset 06 001");
						assetForm.setAssetPumpSets(new ArrayList());
						assetsubCompParams.clear();
						assetForm.setAssetPumpSets(assetsubCompParams);
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompPWSParams",
								assetsubCompParams);

						int size = assetsubCompParams.size();
						Debug.println("size pump main 3333 is " + size);

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						//to be deleted

						//end
						if (size > 0) {
							//assetsubCompTempParams.add(assetsubCompParams.get(0));
							//assetForm.setAssetSubComponents(assetsubCompTempParams);
							Debug.println("in if");

							assetForm.setAssetPumpSets(assetsubCompParams);

							//@author santosh code added on 281106
							{
								asset_pumpset = (Asset_Pumpset) assetsubCompParams
										.get(0);
								PCode = asset_pumpset.getPumpCode();
								phCode = PCode;
								PCode = PCode.substring(21, 24);

								Debug.println("tslno in 009 is " + tslno);
								slno = Integer.parseInt(PCode);
								Debug.println("slno in 009 is " + slno);
								Debug.println("phCode in 009 is" + phCode);
								if (tslno < slno) {
									Debug.println("in if of tslno");
									tslno = slno;
									tempPCode = phCode;
								}
							}
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(asset_pumpset);
							assetForm.setAssetPumpSets(assetsubCompTempParams);

							//request.setAttribute("previousNotExists","true");

							//@end
						} else {
							Debug.println("in else");
							Debug.println("no records");
							PCode = request.getParameter("habCode");
							Debug.println("hab code is " + habCode);
							String Scode = request.getParameter("pumpCode");
							Debug.println("scode is " + Scode);
							Debug.println("5");
							phCode = PCode + Scode + "PS";
							tempPCode = phCode;
							assetsubCompParams.clear();
							//assetsubCompParams.add(new)
							assetForm.setAssetPumpSets(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (assetSubCompTypeCode.equals("001"))
							session.setAttribute("assetsubCompParams",
									"Pumpsets");

					}
					//@end

					else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("001")) {

						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetPipeLine",
								assetsubCompParams);
						session.setAttribute("assetsubCompPWSParams",
								assetsubCompParams);
						Debug.println("got Data");
						int size = assetsubCompParams.size();
						Debug.println("size pump main 3333 is " + size);
						assetsubCompTempParams.clear();

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							//assetForm.setAssetSubComponents(assetsubCompTempParams);
							assetForm.setAssetPipeLine(assetsubCompTempParams);

							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
							session.setAttribute("assetsubCompParams",
									"CpwsPumpingMain");
						else if (assetSubCompTypeCode.equals("003"))
							session.setAttribute("assetsubCompParams",
									"PwsPumpingMain");

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("002")) {
						Debug.println("in pumpset mode 03 002");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetPipeLine",
								assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size of assetsubCompParams is " + size);
						assetsubCompTempParams.clear();

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							//assetForm.setAssetSubComponents(assetsubCompTempParams);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							session.setAttribute("assetsubCompPWSParams",
									assetsubCompParams);
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
								PCode = rwsMaster.getGravitymain_code();

								phCode = PCode;

								PCode = PCode.substring(21, 24);
								slno = Integer.parseInt(PCode);

								if (tslno < slno) {
									tslno = slno;
									tempPCode = phCode;
								}
							}
							Debug.println("value of tempPCode is " + tempPCode);
							request.setAttribute("previousNotExists", "true");
						}

						//code added

						//end
						else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "GM";
							tempPCode = phCode;
							Debug.println("in else 77777777777");

							//assetsubCompParams.clear();
							asset_pipeline = new Asset_PipeLine();
							assetsubCompParams.add(asset_pipeline);
							//assetForm.setAssetPipeLine(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						session.setAttribute("assetsubCompParams",
								"GravityMain");
						assetForm.setAssetPipeLine(assetsubCompTempParams);

					} else if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || typeOfAssetCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")
							&& assetSubCompTypeCode.equals("003")) {
						Debug.println("in pumpset mode 03 003");
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("disHabCode"),
										request.getParameter("disCode"));
						session.setAttribute("assetPipeLine",
								assetsubCompParams);
						int size = assetsubCompParams.size();
						Debug.println("size of assetsubCompParams is " + size);
						assetsubCompTempParams.clear();

						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							//assetForm.setAssetSubComponents(assetsubCompTempParams);
							assetForm.setAssetPipeLine(assetsubCompTempParams);
							session.setAttribute("assetsubCompPWSParams",
									assetsubCompParams);
							assetsubCompTempParams.clear();
							asset_pipeline = new Asset_PipeLine();
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							//((Asset_PipeLine)assetsubCompParams.get(0)).displayDistribution();
							Debug.println("assetsubCompParams size is "
									+ assetsubCompParams.size());
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								Debug.println("in for");
								asset_pipeline = (Asset_PipeLine) assetsubCompParams
										.get(i);
								PCode = asset_pipeline.getDisCode();

								phCode = PCode;
								Debug.println("phCode is " + phCode);
								//PCode = PCode.substring(21, 24);
								//slno = Integer.parseInt(PCode);

								//if (tslno < slno) {
								//tslno = slno;
								//tempPCode = phCode;
								//}
							}
							Debug.println("out of for");
							Debug.println("value of tempPCode is " + tempPCode);
							request.setAttribute("previousNotExists", "true");
						}

						//code added

						//end
						else {
							PCode = request.getParameter("habCode");
							String Scode = request.getParameter("pumpCode");
							phCode = PCode + Scode + "DT";
							tempPCode = phCode;
							Debug.println("in else 77777777777");

							//assetsubCompParams.clear();
							asset_pipeline = new Asset_PipeLine();
							assetsubCompParams.add(asset_pipeline);
							//assetForm.setAssetPipeLine(assetsubCompParams);
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}
						session.setAttribute("assetsubCompParams",
								"Distribution");
						assetForm.setAssetPipeLine(assetsubCompTempParams);

					} else if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("05")
							&& assetSubCompTypeCode.equals("002")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams",
								"PwsPumpHouse");
						assetForm.setAssetHeadWorks(assetsubCompParams);
						int size = assetsubCompParams.size();
						if (size > 0) {
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
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
					} else if (typeOfAssetCode.equals("04")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompParams = RwsMasterData
								.getAssetSubCompParams(
										getDataSource(request),
										request.getParameter("assetCode"),
										request.getParameter("assetTypeCode"),
										request
												.getParameter("assetCompTypeCode"),
										request
												.getParameter("assetSubCompTypeCode"),
										request.getParameter("habCode"),
										request.getParameter("pumpCode"));
						session.setAttribute("assetsubCompParams", "HandPumps");

						int size = assetsubCompParams.size();
						if (size == 0)
							request.setAttribute("currentRow", "0");
						else if (size > 0)
							request.setAttribute("currentRow", "1");
						request.setAttribute("totalRecords", size + "");

						if (size > 0) {
							session.setAttribute("assetsubCompPWSParams",
									assetsubCompParams);
							assetsubCompTempParams.clear();
							assetsubCompTempParams.add(assetsubCompParams
									.get(0));
							assetForm
									.setAssetSubComponents(assetsubCompTempParams);
							for (int i = 0; i < assetsubCompParams.size(); i++) {
								rwsMaster = (RwsComplaintsMaster) assetsubCompParams
										.get(i);
								PCode = rwsMaster.getHpCode();
								Debug.println("pcode vsu is " + PCode);
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
							//code added by pranavi
							String location = request.getParameter("location");
							phCode = PCode + Scode + "HP";

							tempPCode = phCode;
							Debug.println("in else 77777777777");

							//assetsubCompParams.clear();
							asset_subcomponent = new Asset_SubComponent();
							SubCompMetaData subCompMetaData = new SubCompMetaData();
							String nextCode = subCompMetaData
									.getNextSchemeCode(
											getDataSource(request),
											request
													.getParameter("assetTypeCode"),
											request
													.getParameter("assetCompTypeCode"),
											request
													.getParameter("assetSubCompTypeCode"),
											(String) session
													.getAttribute("shortSchemeCodeInAssetEntryForm"),
											(String) session
													.getAttribute("habCodeInAssetEntryForm"),
											request.getParameter(assetCode));
							asset_subcomponent.setHpCode(nextCode);
							//code added by pranavi
							asset_subcomponent.setLocation(location);
							assetsubCompParams.add(asset_subcomponent);
							assetForm.setAssetSubComponents(assetsubCompParams);

							//assetForm.setAssetPipeLine(assetsubCompParams);

						}

						Debug.println("hp code is " + tempPCode);
						if (size == 1) {
							request.setAttribute("nextNotExists", "true");
							request.setAttribute("previousNotExists", "true");
						}

					}
					///////////////**********************%%%%%%%%%%%%%
					/*
					 * else if(
					 * (typeOfAssetCode.equals("01")||typeOfAssetCode.equals("02")||typeOfAssetCode.equals("03")) &&
					 * assetCompTypeCode.equals("05") &&
					 * assetSubCompTypeCode.equals("001")) { Debug.println("in
					 * mesceleneous getting assetsubcompparams");
					 * assetsubCompParams = RwsMasterData.getAssetSubCompParams(
					 * getDataSource(request), request
					 * .getParameter("assetCode"), request
					 * .getParameter("assetTypeCode"), request
					 * .getParameter("assetCompTypeCode"), request
					 * .getParameter("assetSubCompTypeCode"),
					 * request.getParameter("habCode"), request
					 * .getParameter("pumpCode"));
					 * session.setAttribute("assetsubCompParams", "HandPumps");
					 * 
					 * int size = assetsubCompParams.size(); if (size > 0) {
					 * session.setAttribute("assetsubCompPWSParams",
					 * assetsubCompParams); assetsubCompTempParams.clear();
					 * assetsubCompTempParams.add(assetsubCompParams.get(0));
					 * //assetForm.setAssetSubComponents(assetsubCompTempParams);
					 * assetForm.setAssetPipeLine(assetsubCompTempParams); for
					 * (int i = 0; i < assetsubCompParams.size(); i++) {
					 * asset_pumpset = (Asset_Pumpset)
					 * assetsubCompParams.get(i); Debug.println("habcode in
					 * getParams is "+asset_pumpset.getHabCode()); PCode =
					 * asset_pumpset.getOtherCompCode(); Debug.println("pcode
					 * vsu is "+PCode); phCode = PCode;
					 * 
					 *  } } else { PCode = request.getParameter("habCode");
					 * String Scode = request.getParameter("pumpCode");
					 * 
					 * //assetsubCompParams.clear(); asset_subcomponent = new
					 * Asset_SubComponent();
					 * assetsubCompParams.add(asset_subcomponent);
					 * //assetForm.setAssetPipeLine(assetsubCompParams);
					 *  }
					 * 
					 * Debug.println("hp code is "+tempPCode);
					 * 
					 *  }
					 */

					else {
						Debug.println("in else removing assetsubCompParams");
						session.removeAttribute("assetsubCompParams");

					}
					Debug.println("assetsubCompParams.size()= "
							+ assetsubCompParams.size());
					Debug.println("entering tslno block");
					Debug.println("tslno is " + tslno);
					Debug.println("tempPCode is " + tempPCode);
					/*
					 * if (tslno == 0) { tempPCode = tempPCode.substring(0, 21) +
					 * "001";
					 *  } else if (tslno <= 8) { tempPCode =
					 * tempPCode.substring(0, 21) + "00" + (tslno + 1); } else
					 * if (tslno <= 98) { tempPCode = tempPCode.substring(0, 21) +
					 * "0" + (tslno + 1); } else { tempPCode =
					 * tempPCode.substring(0, 21) + (tslno + 1); }
					 */
					Debug.println("tempPCode length is" + tempPCode.length());
					if (tempPCode.length() == 21)
						tempPCode = tempPCode + "001";
					else
						tempPCode = getNextSubComponentCode(tempPCode);
					Debug.println("next pumpcode value set in session is "
							+ tempPCode);
					session.setAttribute("phCode", tempPCode);

					Debug.println("temp code is" + tempPCode + "sadiq");

				} catch (Exception e) {
					Debug.println("error is pumpset mode is  " + e);
				}

				Debug.println("changing mode to pumpset");
				mode = "pumpset";
			}

			if (mode.equalsIgnoreCase("view")) {
				Debug.println("in view mode" + assetForm.getHabCode()
						+ assetForm.getHabName());
				try {

					assets = RwsMasterData.getAssets(circleOfficeCode,
							divisionOfficeCode, subdivisionOfficeCode, request
									.getParameter("mandal"), request
									.getParameter("pcode"), request
									.getParameter("vcode"), request
									.getParameter("habCode"), request
									.getParameter("assetTypeCode"),
							getDataSource(request));

					request.setAttribute("circleOfficeCode", circleOfficeCode);
					request.setAttribute("divisionOfficeCode",
							divisionOfficeCode);
					request.setAttribute("subdivisionOfficeCode",
							subdivisionOfficeCode);
					request.setAttribute("habCode", request
							.getParameter("habCode"));
					//				commented by swapn aon 17-01-2012 for gis data display
					/*
					 * session.setAttribute("circleOfficeCode",request.getParameter("circleOfficeCode"));
					 * Debug.println("coc-0" +
					 * request.getParameter("circleOfficeCode"));
					 * session.setAttribute("divisionOfficeCode",request.getParameter("divisionOfficeCode"));
					 * Debug.println("doc-0" +
					 * request.getParameter("divisionOfficeCode"));
					 * session.setAttribute("subdivisionOfficeCode",request.getParameter("subdivisionOfficeCode"));
					 * Debug.println("sdoc-0" +
					 * request.getParameter("subdivisionOfficeCode"));
					 * session.setAttribute("habCode",request.getParameter("habCode"));
					 * Debug.println("habCode-0" +
					 * request.getParameter("habCode"));
					 */
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
					Debug.println("error in view" + e.getMessage());
				}
				Debug.println("return mode:" + mode);
				if (request.getParameter("assetTypeCode").equals("01")
						|| request.getParameter("assetTypeCode").equals("02")
						|| request.getParameter("assetTypeCode").equals("03")
						|| request.getParameter("assetTypeCode").equals("09")) {
					return mapping.findForward("View1");
				} else
					return mapping.findForward("View");
			}

			/*
			 * added by ramesh on 060110 for updating the program for asset
			 */

			if (mode.equalsIgnoreCase("ViewUpdate")) {
				Debug.println("in view mode" + assetForm.getHabCode()
						+ assetForm.getHabName());
				try {

					assets = RwsMasterData.getAssets(circleOfficeCode,
							divisionOfficeCode, subdivisionOfficeCode, request
									.getParameter("mandal"), request
									.getParameter("pcode"), request
									.getParameter("vcode"), request
									.getParameter("habCode"), request
									.getParameter("assetTypeCode"),
							getDataSource(request));

					request.setAttribute("circleOfficeCode", circleOfficeCode);
					request.setAttribute("divisionOfficeCode",
							divisionOfficeCode);
					request.setAttribute("subdivisionOfficeCode",
							subdivisionOfficeCode);
					request.setAttribute("habCode", request
							.getParameter("habCode"));
					//				commented by swapn aon 17-01-2012 for gis data display
					/*
					 * session.setAttribute("circleOfficeCode",request.getParameter("circleOfficeCode"));
					 * Debug.println("coc1" +
					 * request.getParameter("circleOfficeCode"));
					 * session.setAttribute("divisionOfficeCode",request.getParameter("divisionOfficeCode"));
					 * Debug.println("doc1" +
					 * request.getParameter("divisionOfficeCode"));
					 * session.setAttribute("subdivisionOfficeCode",request.getParameter("subdivisionOfficeCode"));
					 * Debug.println("sdoc1" +
					 * request.getParameter("subdivisionOfficeCode"));
					 * session.setAttribute("habCode",request.getParameter("habCode"));
					 * Debug.println("habCode1" +
					 * request.getParameter("habCode"));
					 */
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
					ArrayList programs = RwsMasterData
							.getProgrammes(getDataSource(request));
					session.setAttribute("programs", programs);

				} catch (Exception e) {
					Debug.println("error in view" + e.getMessage());
				}
				Debug.println("return mode:" + mode);
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("viewUpdateProgram")) {
				Debug.println("in viewUpdateProgram mode");
				String checking[] = null;
				int count = 0;
				try {
					int recno = 0;
					int delcnt = 0;
					Debug.println("1:" + request.getParameter("resultCount"));
					recno = Integer.parseInt(request
							.getParameter("resultCount"));
					Debug.println("2:" + recno);
					checking = new String[recno + 1];
					checking[0] = " ";

					recno = Integer.parseInt(request
							.getParameter("resultCount"));
					for (int i = 1; i < recno + 1; i++) {
						if (request.getParameter("program" + i) != null) {
							checking[i] = "1";
							Debug.println("checked asset code is "
									+ request.getParameter("check[" + i + "]")
									+ " and program is:"
									+ request.getParameter("program" + i));
							if ((request.getParameter("check[" + i + "]") != null && !request
									.getParameter("check[" + i + "]")
									.equals(""))) {
								count += RwsMasterData.updateAssetProgram(
										request
												.getParameter("check[" + i
														+ "]"), request
												.getParameter("program" + i));
							}
						}
					}
				} catch (Exception e) {
					Debug.println("error in view" + e.getMessage());
				}
				String msgg = "";
				if (count > 0)
					msgg = count + " Asset(s) Updated Successfully";
				else
					msgg = "Failed to Update";
				Debug.println("" + msgg.endsWith("Successfully"));
				request.setAttribute("message", msgg);
				assets = RwsMasterData.getAssets(request
						.getParameter("circleOfficeCode"), request
						.getParameter("divisionOfficeCode"), request
						.getParameter("subdivisionOfficeCode"), request
						.getParameter("mandal"), request.getParameter("pcode"),
						request.getParameter("vcode"), request
								.getParameter("habCode"), request
								.getParameter("assetTypeCode"),
						getDataSource(request));
				//commented by swapn aon 17-01-2012 for gis data display
				/*
				 * request.setAttribute("circleOfficeCode",circleOfficeCode);
				 * request.setAttribute("divisionOfficeCode",divisionOfficeCode);
				 * request.setAttribute("subdivisionOfficeCode",subdivisionOfficeCode);
				 * request.setAttribute("habCode",request.getParameter("habCode"));
				 */
				session.setAttribute("circleOfficeCode", request
						.getParameter("circleOfficeCode"));
				Debug.println("coc" + request.getParameter("circleOfficeCode"));
				session.setAttribute("divisionOfficeCode", request
						.getParameter("divisionOfficeCode"));
				Debug.println("doc"
						+ request.getParameter("divisionOfficeCode"));
				session.setAttribute("subdivisionOfficeCode", request
						.getParameter("subdivisionOfficeCode"));
				Debug.println("sdoc"
						+ request.getParameter("subdivisionOfficeCode"));
				session
						.setAttribute("habCode", request
								.getParameter("habCode"));
				Debug.println("habCode" + request.getParameter("habCode"));

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
				ArrayList programs = RwsMasterData
						.getProgrammes(getDataSource(request));
				session.setAttribute("programs", programs);

				return mapping.findForward(mode);
			}

			//this block is executed when save button is pressed
			//in rws_assethabentry_frm.jsp
			//it creates three ArrayLists
			//checkedHabs contains all the habitations in the form
			//tempSelectedHabs and assetHabs contains selected habitations in
			// the form
			if (mode.equalsIgnoreCase("checks")) {
				Debug.println("in checks mode");
				RwsComplaintsMaster rm = null;
				try {
					checkedHabs = (ArrayList) assetForm.getAssetHabs();
					tempSelectedHabs = new ArrayList();
					Debug.println("checkedHabs.size()=" + checkedHabs.size());
					tempSelectedHabs = (ArrayList) session
							.getAttribute("tempSelectedHabs");
					Debug.println("mandal:" + assetForm.getMandal());
					Debug.println("mandal name:" + assetForm.getMandalName());

					Debug.println("Before1:" + tempSelectedHabs.size());
					for (int i = 0; i < tempSelectedHabs.size(); i++) {
						rm = (RwsComplaintsMaster) tempSelectedHabs.get(i);
						Debug.println("I:" + i + ":" + rm.getHabCode());
					}

					ArrayList removeTempSelectedHabs = removeTempSelectedHabs(
							tempSelectedHabs, assetForm.getMandal());
					//tempSelectedHabs.clear();
					//tempSelectedHabs = removeTempSelectedHabs;
					Debug.println("Before2:" + removeTempSelectedHabs.size());
					/*
					 * for (int i = 0; i < tempSelectedHabs.size(); i++) { rm =
					 * (RwsMaster)tempSelectedHabs.get(i);
					 * Debug.println("I:"+i+":"+rm.getHabCode()); }
					 */
					/*
					 * ArrayList tempSelectedHabCodes = new ArrayList(); for
					 * (int i = 0; i < removeTempSelectedHabs.size(); i++) {
					 * rwsMaster = (RwsMaster)removeTempSelectedHabs.get(i);
					 * tempSelectedHabCodes.add(i,rwsMaster.getHabcode()); }
					 */
					/*
					 * for (int i = 0; i < checkedHabs.size(); i++) { panchRaj =
					 * (PanchRaj) checkedHabs.get(i); if
					 * (panchRaj.getHabitation() != null) { //if
					 * (panchRaj.getHabitation().equalsIgnoreCase("on")) {
					 * if(!tempSelectedHabCodes.contains(panchRaj.getHabCode())) {
					 * rm = new RwsMaster(); for(int j=0;j
					 * <tempSelectedHabs.size();j++) { rm =
					 * (RwsMaster)tempSelectedHabs.get(j);
					 * if(rm.getHabCode().equals(panchRaj.getHabCode())) {
					 * tempSelectedHabs.remove(rm); } } } //} } }
					 * Debug.println("Middle:"+tempSelectedHabs.size()); for
					 * (int i = 0; i < tempSelectedHabs.size(); i++) { rm =
					 * (RwsMaster)tempSelectedHabs.get(i);
					 * Debug.println("I:"+i+":"+rm.getHabCode()); }
					 */
					for (int i = 0; i < checkedHabs.size(); i++) {
						panchRaj = (PanchRaj) checkedHabs.get(i);
						if (panchRaj.getHabitation() != null) {
							if (panchRaj.getHabitation().equalsIgnoreCase("on")) {
								//if(!removeTempSelectedHabs.contains(panchRaj.getHabCode()))
								//{
								rm = new RwsComplaintsMaster();
								rm.setHabCode(panchRaj.getHabCode());
								removeTempSelectedHabs.add(rm);
								//	}
							}
						}
					}
					Debug.println("After:" + removeTempSelectedHabs.size());
					for (int i = 0; i < removeTempSelectedHabs.size(); i++) {
						rm = (RwsComplaintsMaster) removeTempSelectedHabs.get(i);
						Debug.println("I:" + i + ":" + rm.getHabCode());
					}
					Debug.println("tempSelectedHabs.size()="
							+ removeTempSelectedHabs.size());
					session.setAttribute("habs", checkedHabs);
					session.setAttribute("tempSelectedHabs",
							removeTempSelectedHabs);
					session.setAttribute("assetHabs", removeTempSelectedHabs);
				} catch (Exception e) {
					Debug.println("the error in checks" + e);
				}
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("addSubCompPipeType")) {
				Debug.println("in addSubCompPipeType mode");
				try {
					int rowCount = 0;
					String code = request.getParameter("code");
					Debug.println("in addSubComp() in rws_assetAct_frm.java");
					assetsubCompTempParams.clear();
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPipeLine();
					String[] addIds = request.getParameterValues("remove");
					Debug.println("addIds.length()" + addIds.length);

					if (addIds != null && addIds.length != 0) {
						for (int p = 0; p < addIds.length; p++) {
							Debug.println("addIds[" + p + "] : " + addIds[p]);
							assetsubCompTempParams.add(assetsubCompParams
									.get((Integer.parseInt(addIds[p]))));
						}

					}
					assetForm.setAssetPipeLine(assetsubCompTempParams);

					rwsMaster = RwsMasterData.insertAssetSubCompPipeTypeParams(
							getDataSource(request), (String) session
									.getAttribute("code"), assetForm
									.getAssetPipeLine());
					assetForm.setAssetPipeLine(assetsubCompParams);
					if (rwsMaster.getMessage() != null
							&& !rwsMaster.getMessage().equals("")) {
						if (Integer.parseInt(rwsMaster.getNoOfRecords()) > 0
								&& rwsMaster.getMessage().equals("inserted"))
							message = "records Inserted Successfully";
						else if (Integer.parseInt(rwsMaster.getNoOfRecords()) > 0
								&& rwsMaster.getMessage().equals("updated"))
							message = "records Updated Successfully";
					}

					request.setAttribute("message", message);
					//code to fill combo's
					assetsubCompParams = (ArrayList) assetForm
							.getAssetPipeLine();
					assetsubCompParams = fillPipeLine(assetsubCompParams,
							getDataSource(request));
					assetForm.setAssetPipeLine(assetsubCompParams);
					//end of code to fill combo's
				} catch (Exception e) {
					Debug.println("Exception :" + e);
				}
				return mapping.findForward("gotoPickpipematMode");

			}

			if (mode.equalsIgnoreCase("addSubComp")) {
				Debug.println("in addSubComp mode");

				try {
					int rowCount = 0;
					Debug.println("in addSubComp() in rws_assetAct_frm.java");
					assetsubCompTempParams.clear();

					String assetCd = (String) session.getAttribute("assetCode");
					typeOfAssetCode = request.getParameter("assetTypeCode");
					Debug.println("Type opf asset code is  " + typeOfAssetCode);
					Debug.println("asset code(14 digit) is  " + assetCd);
					assetCompTypeCode = request
							.getParameter("assetCompTypeCode");
					assetSubCompTypeCode = request
							.getParameter("assetSubCompTypeCode");
					String assetTypeCode = request
							.getParameter("assetTypeCode");
					Debug.println("assetCode=" + assetTypeCode
							+ "assetCompTypeCode=" + assetCompTypeCode
							+ "assetSubCompTypeCode=" + assetSubCompTypeCode
							+ "assetTypeCode=" + assetTypeCode);
					if (assetCompTypeCode.equals("04"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetReservior();
					else if (assetCompTypeCode.equals("02"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetHeadWorks();
					else if (assetCompTypeCode.equals("03"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPipeLine();
					else if (assetCompTypeCode.equals("05"))
						assetsubCompParams = (ArrayList) assetForm
								.getAssetPumpSets();

					String[] addIds = request.getParameterValues("remove");
					Debug.println("addIds.length()" + addIds.length);

					if (addIds != null && addIds.length != 0) {
						for (int p = 0; p < addIds.length; p++) {
							Debug.println("addIds[" + p + "] : " + addIds[p]);
							assetsubCompTempParams.add(assetsubCompParams
									.get((Integer.parseInt(addIds[p]))));
							//Asset_HeadWorks assetHw =
							// (Asset_HeadWorks)assetsubCompParams.get((Integer.parseInt(addIds[p])));
							//Debug.println("aaaaaaaaaaaaaabbbbbbbbbbb:"+assetHw.getWtpCode());
						}

					}

					/////code
					if ((assetTypeCode.equals("01")
							|| assetTypeCode.equals("02")
							|| assetTypeCode.equals("03") || assetTypeCode
							.equals("09"))
							&& assetCompTypeCode.equals("02")) {

						opType = "Modify";
						Debug.println("calling insertAssetSubCompParms");
						Debug.println("assetCd=" + assetCd
								+ " assetCompTypeCode=" + assetCompTypeCode
								+ " assetSubCompTypeCode="
								+ assetSubCompTypeCode + " assetTypeCode="
								+ assetTypeCode + " opType=" + opType);
						Debug.println("assetForm.getAssetHeadWorks.size()="
								+ assetForm.getAssetHeadWorks().size());

						assetForm.setAssetHeadWorks(assetsubCompTempParams);
						Asset_HeadWorks assetHw = (Asset_HeadWorks) assetsubCompTempParams
								.get(0);
						Debug.println("getAssetCode()="
								+ assetHw.getAssetCode());
						Debug.println("getssTankCode()="
								+ assetHw.getSsTankCode());

						Debug.println("getssPowerHours()="
								+ assetHw.getPowerHours());
						Debug.println(assetHw.getSsSize() + ", "
								+ assetHw.getSsCapacityDays() + ","
								+ assetHw.getSsCapacityMcum() + ","
								+ assetHw.getSsTankAdeq() + ",'"
								+ assetHw.getSsTankLocation() + "', "
								+ assetHw.getSsTankYield() + ",'"
								+ assetHw.getSsTankYieldDate() + "', '"
								+ assetHw.getPowerConn() + "',"
								+ assetHw.getPowerHours());
						////

						///
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetHeadWorks(), "Headworks");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetHeadWorks(assetsubCompParams);
						Debug.println("message1 is " + daoMessage.getMessage());
					}
					if ((assetTypeCode.equals("01")
							|| assetTypeCode.equals("02")
							|| assetTypeCode.equals("03") || assetTypeCode
							.equals("09"))
							&& assetCompTypeCode.equals("03")) {
						opType = "Modify";
						assetForm.setAssetPipeLine(assetsubCompTempParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetPipeLine(), "Pipeline");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPipeLine(assetsubCompParams);
						return mapping.findForward("addSubCompPump");

					}
					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02")
							|| typeOfAssetCode.equals("03") || assetTypeCode
							.equals("09"))
							&& assetCompTypeCode.equals("04")) { //(assetSubCompTypeCode.equals("001")
																 // ||
																 // assetSubCompTypeCode.equals("002")
																 // ||
																 // assetSubCompTypeCode.equals("003")))
																 // {
						opType = "Modify";
						assetForm.setAssetReservior(assetsubCompParams);
						Debug
								.println("assetsubcompTempParams in addsubcomp mode is size is "
										+ assetsubCompTempParams.size());
						/*
						 * rowCount = RwsMasterData.insertAssetSubCompParams(
						 * getDataSource(request), assetCd, assetCompTypeCode,
						 * assetSubCompTypeCode, assetTypeCode, opType,
						 * assetForm.getAssetReservior(), "Reservoirs");
						 *  
						 */
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetsubCompTempParams,
								"Reservoirs");
						rowCount = daoMessage.getRowCount();

						Debug.println("rowCount is** " + rowCount);

						if ((typeOfAssetCode.equals("01")
								|| typeOfAssetCode.equals("02")
								|| typeOfAssetCode.equals("03") || assetTypeCode
								.equals("09"))
								&& assetCompTypeCode.equals("04")
								&& (assetSubCompTypeCode.equals("001")
										|| assetSubCompTypeCode.equals("003") || assetSubCompTypeCode
										.equals("006"))) {
							assetsubCompParams = RwsMasterData
									.getAssetSubCompParams(
											getDataSource(request), assetCd,
											assetTypeCode, assetCompTypeCode,
											assetSubCompTypeCode, request
													.getParameter("habCode"),
											request.getParameter("pumpCode"));
						}
						assetForm.setAssetReservior(assetsubCompParams);
					}
					if ((assetTypeCode.equals("01")
							|| assetTypeCode.equals("02")
							|| assetTypeCode.equals("03")
							|| assetTypeCode.equals("09") || assetTypeCode
							.equals("05"))
							&& assetCompTypeCode.equals("05")) {
						opType = "Modify";
						Debug.println("in misceleneous insert");
						assetForm.setAssetPumpSets(assetsubCompTempParams);
						daoMessage = RwsMasterData.insertAssetSubCompParams(
								getDataSource(request), assetCd,
								assetCompTypeCode, assetSubCompTypeCode,
								assetTypeCode, opType, assetForm
										.getAssetPumpSets(), "Pumpsets");
						rowCount = daoMessage.getRowCount();
						assetForm.setAssetPumpSets(assetsubCompParams);

					}

					if (typeOfAssetCode.equals("01")
							&& assetCompTypeCode.equals("01")
							&& assetSubCompTypeCode.equals("001")) {
						assetsubCompTempParams.clear();
						asset_subcomponent = new Asset_SubComponent();
						Debug.println("source quality is  "
								+ request.getParameter("sourceQuality"));
						Asset_SubComponent asset_subComponent = new Asset_SubComponent(
								request.getParameter("popDes"), request
										.getParameter("source"), request
										.getParameter("sourceQuality"), request
										.getParameter("sourceYield"), request
										.getParameter("sourceDepend"), request
										.getParameter("sourceDepth"), request
										.getParameter("sourceDiameter"),
								request.getParameter("sourceCondition"),
								request.getParameter("sourceSwl"), request
										.getParameter("sourceNwl"), request
										.getParameter("phSize"), request
										.getParameter("phCondition"), request
										.getParameter("phType"), request
										.getParameter("pumpName"), request
										.getParameter("pumpCapacity"), request
										.getParameter("pumpType"), request
										.getParameter("purYear"), request
										.getParameter("hrRun"), request
										.getParameter("hrSin"), request
										.getParameter("hrMs"), request
										.getParameter("staExe"), request
										.getParameter("pumpDutyLpm"), request
										.getParameter("pumpDutyHead"), request
										.getParameter("ifNss"), request
										.getParameter("pumpNo"), request
										.getParameter("standByPumpCapacity"),
								request.getParameter("standByPumpNo"), request
										.getParameter("pmpCode"));
						assetSubComps.add(asset_subComponent);
						assetForm.setAssetSubComponents(assetSubComps);
						Debug.println("this in insert");
						//String
						// assetCd=(String)session.getAttribute("assetCd");
						DAOMessage daoMessege = RwsMasterData
								.insertAssetSubCompParams(
										getDataSource(request), assetCd,
										assetCompTypeCode,
										assetSubCompTypeCode, assetTypeCode,
										opType, assetForm
												.getAssetSubComponents(),
										"Source");
						rowCount = daoMessage.getRowCount();
					}
					/*
					 * should be checked before delete(dont delete) if
					 * (typeOfAssetCode.equals("03") &&
					 * assetCompTypeCode.equals("05") &&
					 * assetSubCompTypeCode.equals("001")) {
					 * assetsubCompTempParams.clear(); asset_pumpset = new
					 * Asset_Pumpset(); Debug.println("this in 03 05 001 of
					 * insert " + request.getParameter("pumpdet_code"));
					 * asset_pumpset = new Asset_Pumpset(request
					 * .getParameter("pumpdet_code"), request
					 * .getParameter("pumpcode"), request .getParameter("hp"),
					 * request.getParameter("type"),
					 * request.getParameter("duty_con"), request
					 * .getParameter("head_mts"), request
					 * .getParameter("discharge_lpm"), request
					 * .getParameter("standby_hp"), request
					 * .getParameter("years_used"), request
					 * .getParameter("failure_freq"), request
					 * .getParameter("avg_hr_pumping_day"),
					 * request.getParameter("repair_cost_year"), request
					 * .getParameter("capasitor"), request
					 * .getParameter("control_panel"), request
					 * .getParameter("power_hours"), request
					 * .getParameter("work_hrs"), request
					 * .getParameter("qty_water_cum"));
					 * assetsubCompTempParams.add(asset_pumpset);
					 * assetForm.setAssetPumpSets(assetsubCompTempParams);
					 * Debug.println("this in insert"); //String
					 * assetCd=(String)session.getAttribute("assetCd"); rowCount =
					 * RwsMasterData.insertAssetSubCompParams(
					 * getDataSource(request), assetCd, assetCompTypeCode,
					 * assetSubCompTypeCode, assetTypeCode, opType,
					 * assetForm.getAssetPumpSets(), "Source"); }
					 */
					Debug.println("row count:" + rowCount);
					if ((typeOfAssetCode.equals("01")
							|| typeOfAssetCode.equals("02") || typeOfAssetCode
							.equals("03"))
							|| assetTypeCode.equals("09")
							&& (assetCompTypeCode.equals("02")
									|| assetCompTypeCode.equals("03") || assetCompTypeCode
									.equals("04"))) {
						message = daoMessage.getMessage();
						Debug.println("message in action is " + message);
					} else if (rowCount > 0) {
						message = "Record Inserted Successfully";
						Debug.println("record insterted");
					} else {

						message = "The Record Cant be inserted";
						Debug.println("  not inserted");
					}
					if (message == null) {
						if (rowCount > 0) {
							message = "Record Inserted Successfully";
							Debug.println("record insterted");
						} else {

							message = "The Record Cant be inserted";
							Debug.println("  not inserted");
						}
					}
					request.setAttribute("message", message);

				} catch (Exception e) {
					Debug.println("Error in add GLSR :" + e.getMessage());
				}
			}

			//this block is executed where save button is pressed in
			// assetEntryForm
			//for saving an asset
			if (mode.equals("Save Source")) {
				mode = "Add Source";
			}
			if (mode.equalsIgnoreCase("save")
					|| mode.equalsIgnoreCase("Add Source"))//Add Source is
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
					Debug.println("water in aACT ####" + water);
					session.setAttribute("water1", water);
				}
				Debug.println("in save mode");
				message = saveAsset(assetForm, request);
				request.setAttribute("message", message);
				assetForm.setAssetHabs((ArrayList) session
						.getAttribute("tempSelectedHabs"));
				if (message
						.equals("Record inserted Successfully-Please Select Asset Code to Add SubComponents")) {
					Debug.println("in redirect message");
					assetForm.setOpType("Modify");
					mode = "opModify";
				} else {
					Debug.println("in else redirect message");
					return mapping.findForward("getNew");
				}
				/*
				 * try {
				 * 
				 * rwsMaster.setCoc(assetForm.getCoc());
				 * rwsMaster.setDoc(assetForm.getDoc());
				 * rwsMaster.setSdoc(assetForm.getSdoc());
				 * rwsMaster.setHabCode(assetForm.getHabCode());
				 * rwsMaster.setAssetTypeCode(assetForm.getAssetTypeCode());
				 * rwsMaster.setAssetCode(assetForm.getAssetCode());
				 * rwsMaster.setAssetName(assetForm.getAssetName());
				 * rwsMaster.setDateofCreation(assetForm.getDateofCreation());
				 * rwsMaster.setLocation(assetForm.getLocation());
				 * rwsMaster.setAssetCost(assetForm.getAssetCost());
				 * rwsMaster.setStartYear(assetForm.getStartYear());
				 * rwsMaster.setEndYear(assetForm.getEndYear());
				 * 
				 * rwsMaster
				 * .setAssetCompTypeCode(assetForm.getAssetCompTypeCode());
				 * rwsMaster.setAssetSubCompTypeCode(assetForm
				 * .getAssetSubCompTypeCode());
				 * rwsMaster.setAssetStatus(assetForm.getAssetStatus());
				 * rwsMaster.setPumpCode(assetForm.getPumpCode());
				 * 
				 * sources.clear(); resorvior.clear(); pipeLine.clear();
				 * headWorks.clear();
				 * 
				 * 
				 * 
				 * if (!assetForm.getAssetTypeCode().equals("04")) habs =
				 * (ArrayList) session.getAttribute("tempSelectedHabs");
				 * Debug.println("habCode=" + rwsMaster.getHabCode() +
				 * "assetCode=" + assetForm.getAssetCode() + "assetTypeCode=" +
				 * request.getParameter("assetTypeCode") + "assetCompTypeCode=" +
				 * request.getParameter("assetCompTypeCode") +
				 * "assetSubCompTypeCode=" +
				 * request.getParameter("assetSubCompTypeCode"));
				 * Debug.println("habs size=" + habs.size());
				 * 
				 * Debug.println("coc="+assetForm.getCoc());
				 * Debug.println("doc="+assetForm.getDoc());
				 * Debug.println("sdoc="+assetForm.getSdoc());
				 * Debug.println("circleOfficeCode="+assetForm.getCircleOfficeCode());
				 * Debug.println("divisionOfficeCode="+assetForm.getDivisionOfficeCode());
				 * Debug.println("subdivisionOfficeCode="+assetForm.getSubdivisionOfficeCode());
				 * rwsMaster.setCoc(assetForm.getCircleOfficeCode());
				 * rwsMaster.setDoc(assetForm.getDivisionOfficeCode());
				 * rwsMaster.setSdoc(assetForm.getSubdivisionOfficeCode());
				 * Debug.println("calling insertAsset"); rcount =
				 * RwsMasterData.insertAsset(rwsMaster, habs, sources,
				 * headWorks, pipeLine, resorvior,
				 * request.getParameter("opType"), getDataSource(request));
				 * assetForm.reset(mapping, request); if (rcount.length < 1) {
				 * message = "The Record Cant be inserted"; } else { message =
				 * "Record Inserted Successfully";
				 * if(request.getParameter("opType")!=null &&
				 * request.getParameter("opType").equals("Add New")) {
				 * if(rcount[0] <1 || rcount[1] <1) message="Record Cant be
				 * inserted"; } }
				 *  } catch (Exception e) { Debug.println("the error in insert= " +
				 * e); }
				 */

				//return mapping.findForward(mode);
			}
			if (mode != null && mode.equalsIgnoreCase("opModify")) {

				Debug.println("in opModify mode");
				schemeCodes = commonLists.getSchemeCodes(request
						.getParameter("assetTypeCode"), request
						.getParameter("habCode"));
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
			/*
			 * if (mode!=null && mode.equalsIgnoreCase("opModify1") ) {
			 * 
			 * Debug.println("in opModify1***************** mode"); schemeCodes =
			 * commonLists.getSchemeCodes(request
			 * .getParameter("assetTypeCode"), request
			 * .getParameter("habCode")); pumpCode = "";
			 * 
			 * 
			 * session.setAttribute("schemeCodes",schemeCodes);
			 * session.removeAttribute("assetCompTypes");
			 * session.removeAttribute("assetSubCompTypes");
			 * session.removeAttribute("headWorks");
			 * session.removeAttribute("pipeLine");
			 * session.removeAttribute("resorvior");
			 * session.removeAttribute("pumpsets"); assetForm.setAssetName("");
			 * assetForm.setLocation(""); assetForm.setAssetStatus("");
			 * assetForm.setStartYear(""); assetForm.setDateofCreation("");
			 * assetForm.setAssetCost(""); assetForm.setTotHabs(0);
			 * assetForm.setTotPopBenfit(0);
			 * assetForm.setPumpCode(assetForm.getPumpCode());
			 * assetForm.setOpType("Modify"); return mapping.findForward(mode); }
			 */
			//the following block is commented so that when edit is clicked it
			// should open in the same form as that of addNew
			/*
			 * if (mode.equalsIgnoreCase("get")) { Debug.println("in get mode");
			 * try { form = buildAssetForm(request.getParameter("assetCode"),
			 * request.getParameter("typeOfAssetCode"), request, commonLists);
			 * if ("request".equalsIgnoreCase(mapping.getScope())) {
			 * request.setAttribute(mapping.getAttribute(), form); } else {
			 * session.setAttribute(mapping.getAttribute(), form); } } catch
			 * (Exception e) { Debug.println("the error is" + e); } }
			 */

			if (mode.equalsIgnoreCase("edit")) {
				Debug.println("in edit mode");
				try {
					Debug.println("asset Type code="
							+ assetForm.getAssetTypeCode()
							+ "asset comptype code="
							+ request.getParameter("assetCompTypeCode")
							+ "asset subcomptype="
							+ request.getParameter("assetSubCompTypeCode"));
					rwsMaster.setAssetTypeCode(assetForm.getAssetTypeCode());
					rwsMaster.setAssetCode(assetForm.getAssetCode());
					rwsMaster.setAssetName(assetForm.getAssetName());
					rwsMaster.setDateofCreation(assetForm.getDateofCreation());
					rwsMaster.setLocation(assetForm.getLocation());
					rwsMaster.setAssetStatus(assetForm.getAssetStatus());
					rwsMaster.setAssetCost(assetForm.getAssetCost());
					rwsMaster.setStartYear(assetForm.getStartYear());
					rwsMaster.setEndYear(assetForm.getEndYear());
					//added by swapna on 17-01-2012 fri gis data entry
					rwsMaster.setLatitude(assetForm.getLatitude());
					rwsMaster.setLongitude(assetForm.getLongitude());
					rwsMaster.setElevation(assetForm.getElevation());
					rwsMaster.setWaypoint(assetForm.getWaypoint());
					//

					habs = (ArrayList) session.getAttribute("tempSelectedHabs");

					if (assetForm.getAssetTypeCode().equals("04")
							&& request.getParameter("assetCompTypeCode")
									.equals("01")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("001"))
						sources = (ArrayList) session
								.getAttribute("HPSubComps");
					else if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("003"))
						sources = (ArrayList) session
								.getAttribute("GLSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode")
									.equals("01")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("001"))
						sources = (ArrayList) session
								.getAttribute("PWSBoreWellSubComps");

					pipeLine = (ArrayList) assetForm.getAssetPipeLine();

					if (assetForm.getAssetTypeCode().equals("01")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("001"))
						resorvior = (ArrayList) session
								.getAttribute("ResOHSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("001"))
						resorvior = (ArrayList) session
								.getAttribute("ResCPWSOHSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("002"))
						resorvior = (ArrayList) session
								.getAttribute("ResCPWSOHBRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("003"))
						resorvior = (ArrayList) session
								.getAttribute("ResCPWSGLSRSubComps");
					else if (assetForm.getAssetTypeCode().equals("03")
							&& request.getParameter("assetCompTypeCode")
									.equals("04")
							&& request.getParameter("assetSubCompTypeCode")
									.equals("004"))
						resorvior = (ArrayList) session
								.getAttribute("ResCPWSGLBRSubComps");

					rcount = RwsMasterData.updateAsset(rwsMaster, habs,
							sources, headWorks, pipeLine, resorvior, request
									.getParameter("assetCompTypeCode"), request
									.getParameter("assetSubCompTypeCode"),
							getDataSource(request));
					session.removeAttribute("tempSelectedHabs");

					Debug.println("rcount len=" + rcount.length);
				} catch (Exception e) {
					Debug.println("The error in edit rws_asset_entry=  " + e);
				}
				if (rcount.length < 1) {
					if (RwsMasterData.errorMessage != null
							&& RwsMasterData.errorMessage.length() > 0)
						message = RwsMasterData.errorMessage;
					else
						displaymess = "The record cannot be updated.";
					mode = "get";
					request.setAttribute("displaymess", displaymess);
				}

			}
			if (mode.equalsIgnoreCase("delete")) {
				Debug.println("in delete mode");
				try {
					message = RwsMasterData.removeAsset(request
							.getParameter("assetCode"), getDataSource(request));
					/*
					 * Debug.println("del=" + del.length); if (del.length > 0) {
					 * displaymess = "Data deleted Succesfully"; } else {
					 * displaymess = "Data cannot be deleted"; }
					 * request.setAttribute("displaymess", displaymess);
					 */
					request.setAttribute("message", message);
				} catch (Exception e) {
					Debug.println("the error in Circle delete is " + e);
				}
				return mapping.findForward("deleteasset");
			}

			if (mode.equalsIgnoreCase("AddHabs"))
			{
				Debug.println("in Addhabs mode:::::::::::::::::");
				session.setAttribute("isNewHab", "false");
				RwsLocations rwsLocations = new RwsLocations(
						getDataSource(request));
				Debug.println("circle in addHabs is "
						+ assetForm.getCircleOfficeCode());
				Debug.println("district in addHabs is "
						+ assetForm.getAddHabsDistrict());
				try {
					Debug.println("headworks size is "
							+ (assetForm.getAssetHeadWorks()).size());
					assetForm.setToDo(request.getParameter("toDo"));
					if (request.getParameter("toDo") != null) {

						Debug
								.println("toDo is "
										+ request.getParameter("toDo"));
						assetForm.setAssetTypeCode(request
								.getParameter("assetTypeCode"));

						assetForm.setAssetCompTypeCode(request
								.getParameter("assetCompTypeCode"));
						assetForm.setAssetSubCompTypeCode(request
								.getParameter("assetSubCompTypeCode"));
						Debug.println("toDo is " + assetForm.getToDo());
						if (request.getParameter("toDo").equals("newHab")) {
							if ((assetForm.getAssetTypeCode().equals("01")
									|| assetForm.getAssetTypeCode()
											.equals("02") || assetForm
									.getAssetTypeCode().equals("03"))
									&& assetForm.getAssetCompTypeCode().equals(
											"01")
									&& assetForm.getAssetSubCompTypeCode()
											.equals("003")) {
								Debug.println("in pumpsets");
								assetsubCompTempParams.clear();
								Asset_Pumpset asset_pumpsetTmp = new Asset_Pumpset();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								//String
								// nextCode=subCompMetaData.getNextSchemeCode(getDataSource(request),request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),request.getParameter("assetSubCompTypeCode"),(String)session.getAttribute("shortSchemeCodeInAssetEntryForm"),(String)session.getAttribute("habCodeInAssetEntryForm"),request.getParameter("assetCode"));
								String nextCode = subCompMetaData
										.getNextSchemeCode(
												getDataSource(request),
												request
														.getParameter("assetTypeCode"),
												request
														.getParameter("assetCompTypeCode"),
												request
														.getParameter("assetSubCompTypeCode"),
												(String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm"),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"),
												request
														.getParameter("assetCode"));
								Debug
										.println("next schemecode from subCompMetaData is "
												+ nextCode);
								//rwsMaster.setHpCode((String)session.getAttribute("habCodeInAssetEntryForm")+(String)session.getAttribute("shortSchemeCodeInAssetEntryForm")+"HP"+"001");
								asset_pumpsetTmp.setPumpCode(nextCode);
								asset_pumpsetTmp
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								Debug.println("schemecode for new handpump is "
										+ rwsMaster.getHpCode());
								assetsubCompTempParams.add(asset_pumpsetTmp);

								assetForm
										.setAssetPumpSets(assetsubCompTempParams);
								//getNextSchemeCode(javax.sql.DataSource
								// dataSource,String assetTypeCode,String
								// assetCompTypeCode,String
								// assetSubCompTypeCode,String
								// shortSchemeCode,String habCode,String
								// assetCode)
								session.setAttribute("assetsubCompParams",
										"Pumpsets");
								return mapping.findForward("pumpset");
							} else if ((assetForm.getAssetTypeCode().equals(
									"01")
									|| assetForm.getAssetTypeCode()
											.equals("09")
									|| assetForm.getAssetTypeCode()
											.equals("02") || assetForm
									.getAssetTypeCode().equals("03"))
									&& assetForm.getAssetCompTypeCode().equals(
											"06")
									&& assetForm.getAssetSubCompTypeCode()
											.equals("001")) {
								Debug.println("in pumpsets");
								assetsubCompTempParams.clear();
								Asset_Pumpset asset_pumpsetTmp = new Asset_Pumpset();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								//String
								// nextCode=subCompMetaData.getNextSchemeCode(getDataSource(request),request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),request.getParameter("assetSubCompTypeCode"),(String)session.getAttribute("shortSchemeCodeInAssetEntryForm"),(String)session.getAttribute("habCodeInAssetEntryForm"),request.getParameter("assetCode"));
								String nextCode = subCompMetaData
										.getNextSchemeCode(
												getDataSource(request),
												request
														.getParameter("assetTypeCode"),
												request
														.getParameter("assetCompTypeCode"),
												request
														.getParameter("assetSubCompTypeCode"),
												(String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm"),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"),
												request
														.getParameter("assetCode"));
								Debug
										.println("next schemecode from subCompMetaData is "
												+ nextCode);
								//rwsMaster.setHpCode((String)session.getAttribute("habCodeInAssetEntryForm")+(String)session.getAttribute("shortSchemeCodeInAssetEntryForm")+"HP"+"001");
								asset_pumpsetTmp.setPumpCode(nextCode);
								asset_pumpsetTmp
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								Debug.println("schemecode for new handpump is "
										+ rwsMaster.getHpCode());
								assetsubCompTempParams.add(asset_pumpsetTmp);

								assetForm
										.setAssetPumpSets(assetsubCompTempParams);
								//getNextSchemeCode(javax.sql.DataSource
								// dataSource,String assetTypeCode,String
								// assetCompTypeCode,String
								// assetSubCompTypeCode,String
								// shortSchemeCode,String habCode,String
								// assetCode)
								session.setAttribute("assetsubCompParams",
										"Pumpsets");
								return mapping.findForward("pumpset");
							}
							if (assetForm.getAssetTypeCode().equals("04")) {
								Debug.println("in handpumps");
								assetsubCompTempParams.clear();
								RwsComplaintsMaster rwsMasterTmp = new RwsComplaintsMaster();
								SubCompMetaData subCompMetaData = new SubCompMetaData();
								String nextCode = subCompMetaData
										.getNextSchemeCode(
												getDataSource(request),
												request
														.getParameter("assetTypeCode"),
												request
														.getParameter("assetCompTypeCode"),
												request
														.getParameter("assetSubCompTypeCode"),
												(String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm"),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"),
												request.getParameter(assetCode));
								Debug
										.println("next schemecode from subCompMetaData is "
												+ nextCode);
								//rwsMaster.setHpCode((String)session.getAttribute("habCodeInAssetEntryForm")+(String)session.getAttribute("shortSchemeCodeInAssetEntryForm")+"HP"+"001");
								rwsMaster.setHpCode(nextCode);
								rwsMaster
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								Debug.println("schemecode for new handpump is "
										+ rwsMaster.getHpCode());
								assetsubCompTempParams.add(rwsMaster);
								assetForm
										.setAssetSubComponents(assetsubCompTempParams);
								//getNextSchemeCode(javax.sql.DataSource
								// dataSource,String assetTypeCode,String
								// assetCompTypeCode,String
								// assetSubCompTypeCode,String
								// shortSchemeCode,String habCode,String
								// assetCode)
								session.setAttribute("assetsubCompParams",
										"HandPumps");
								return mapping.findForward("pumpset");
							}
							if (assetForm.getAssetTypeCode().equals("05")) {
								Debug.println("in SHALLOW HAND PUMPS");
								assetsubCompTempParams.clear();
								Asset_SHP asset_SHP = new Asset_SHP();
								asset_SHP
										.setShallowHandPumpCode((String) session
												.getAttribute("habCodeInAssetEntryForm")
												+ (String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm")
												+ "SH" + "001");
								asset_SHP
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								//code modified by pranavi
								asset_SHP.setLocation(request
										.getParameter("location"));
								String hname = RwsMasterData
										.getHabName(
												getDataSource(request),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"));
								asset_SHP.setHabitation(hname);

								Debug.println("shallow hand pump code is "
										+ asset_SHP.getShallowHandPumpCode());
								assetsubCompTempParams.add(asset_SHP);

								assetForm.setAssetSHP(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams",
										"SHP");
								return mapping.findForward("ponds");
							}
							if (assetForm.getAssetTypeCode().equals("06")) {
								Debug.println("in OPENWELLS");
								assetsubCompTempParams.clear();
								Asset_OpenWells asset_openWells = new Asset_OpenWells();
								asset_openWells
										.setOpenWellCode((String) session
												.getAttribute("habCodeInAssetEntryForm")
												+ (String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm")
												+ "OW" + "001");
								asset_openWells
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								assetsubCompTempParams.add(asset_openWells);
								assetForm
										.setAssetOpenWells(assetsubCompTempParams);
								//code modified by pranavi
								asset_openWells.setLocation(request
										.getParameter("location"));
								String hname1 = RwsMasterData
										.getHabName(
												getDataSource(request),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"));
								asset_openWells.setHabitation(hname1);

								Debug.println("open well code is "
										+ asset_openWells.getOpenWellCode());
								session.setAttribute("assetsubCompParams",
										"OpenWells");
								return mapping.findForward("ponds");
							}
							if (assetForm.getAssetTypeCode().equals("07")) {
								Debug.println("in PONDS");
								assetsubCompTempParams.clear();
								Asset_Ponds asset_ponds = new Asset_Ponds();
								asset_ponds
										.setPondCode((String) session
												.getAttribute("habCodeInAssetEntryForm")
												+ (String) session
														.getAttribute("shortSchemeCodeInAssetEntryForm")
												+ "PD" + "001");
								asset_ponds
										.setHabCode((String) session
												.getAttribute("habCodeInAssetEntryForm"));
								//code modified by pranavi
								asset_ponds.setLocation(request
										.getParameter("location"));
								String habitationname = RwsMasterData
										.getHabName(
												getDataSource(request),
												(String) session
														.getAttribute("habCodeInAssetEntryForm"));
								asset_ponds.setHabitation(habitationname);
								Debug.println("pondCode is "
										+ asset_ponds.getPondCode());
								assetsubCompTempParams.add(asset_ponds);

								assetForm.setAssetPonds(assetsubCompTempParams);
								session.setAttribute("assetsubCompParams",
										"Ponds");
								return mapping.findForward("ponds");
							}
							Debug.println("in if of ToDo");
							request.setAttribute("isNewSubComp", "true");
							Debug.println("mandal is " + assetForm.getMandal());
							assetForm.setAddHabsDistrict(assetForm
									.getCircleOfficeCode());
							assetForm.setAddHabsMandal(assetForm.getHabCode()
									.substring(5, 7));
							assetForm.setAddHabsHabitation(assetForm
									.getHabCode());
							Debug.println("habcode in assetForm is  "
									+ assetForm.getHabCode());
							Debug.println("habcode in request is  "
									+ request.getParameter("habCode"));

							dists = rwsLocations.getDistricts();
							session.setAttribute("dists", dists);
							mandals = rwsLocations.getMandals(assetForm
									.getAddHabsDistrict());
							session.setAttribute("mandals", mandals);
							Debug.println("addHabsMandal is "
									+ assetForm.getAddHabsMandal());
							prhabs = rwsLocation.getHabs(assetForm
									.getAddHabsDistrict(), assetForm
									.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);
							session.setAttribute("isNewHab", "true");
							return mapping.findForward(mode);
						}

						session.setAttribute("isNewHab", "true");
					} else {
						session.setAttribute("isNewHab", "false");

					}
					Debug.println("in addHabs");

					Debug.println("dcode in myform"
							+ assetForm.getAddHabsDistrict());
					Debug.println("mcode in assetForm"
							+ assetForm.getAddHabsMandal());
					Debug.println("habcode in assetForm"
							+ assetForm.getAddHabsHabitation());

					dists = rwsLocations.getDistricts();
					session.setAttribute("dists", dists);
					Debug.println("parameter changed="
							+ request.getParameter("changed"));
					if (request.getParameter("changed") != null
							&& request.getParameter("changed")
									.equalsIgnoreCase("district")) {

						assetForm.setAddHabsMandal("");
						assetForm.setAddHabsHabitation("");
						if (!assetForm.getAddHabsDistrict().equals("")) {
							mandals = rwsLocations.getMandals(assetForm
									.getAddHabsDistrict());
							session.setAttribute("mandals", mandals);
							prhabs = rwsLocation.getHabs(assetForm
									.getAddHabsDistrict(), assetForm
									.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);

						}

						return mapping.findForward(mode);
					}
					if (request.getParameter("changed") != null
							&& request.getParameter("changed")
									.equalsIgnoreCase("mandal")) {
						assetForm.setAddHabsHabitation("");
						if (!assetForm.getAddHabsMandal().equals("")) {
							prhabs = rwsLocation.getHabs(assetForm
									.getAddHabsDistrict(), assetForm
									.getAddHabsMandal());
							session.setAttribute("prhabs", prhabs);
						}

					}

					String tempSumpCoce = "";
					String subCompCode = (String) request
							.getParameter("subCompCode1");
					Debug.println("subCompCode is" + subCompCode);
					/*
					 * SubCompMetaData subCompMetaData=new
					 * SubCompMetaData(subCompCode); String
					 * tableName=subCompMetaData.getTableName(); String
					 * tempSubCode="";
					 * tempSubCode=subCompMetaData.getSchemeCodeField();
					 */
					try {
						/*
						 * //code commented on 081007
						 * habCode=assetForm.getHabCode(); String
						 * district=rwsLocations.getDname(habCode.substring(0,2));
						 * String
						 * mandal=rwsLocations.getMname(habCode.substring(0,2),habCode.substring(5,7));
						 * String habName=RwsMasterData.getHabName(
						 * getDataSource(request),habCode.substring(0,16));
						 * 
						 * assetForm.setAddHabsDistrictName(district);
						 * assetForm.setAddHabsMandalName(mandal);
						 * assetForm.setAddHabsHabitation(habName+"-"+habCode.substring(0,16));
						 * 
						 * Debug.println("habcode in assetForm is
						 * "+assetForm.getHabCode()); Debug.println("habcode in
						 * request is "+request.getParameter("habCode"));
						 * Debug.println("tabPrifix is "+tableName);
						 * Debug.println("tempSubCode is "+tempSubCode);
						 * Debug.println("district is *** "+district);
						 * Debug.println("mandal is ***"+mandal);
						 * Debug.println("habName 5844 is "+habName);
						 */
						if (request.getParameter("habCode") != null
								|| (request.getParameter("toDo") == null || !request
										.getParameter("toDo").equals("newHab"))) {
							habCode = request.getParameter("habCode");
						} else if (request.getParameter("toDo") == null
								|| !request.getParameter("toDo").equals(
										"newHab")) {
							SubCompMetaData subCompMetaData = new SubCompMetaData(
									subCompCode);
							String tableName = subCompMetaData.getTableName();
							String tempSubCode = subCompMetaData
									.getSchemeCodeField();
							habCode = RwsMasterData.getHabCode(
									getDataSource(request), tableName,
									tempSubCode, subCompCode);
						} else {
							habCode = assetForm.getAddHabsHabitation();
						}
						if (habCode == null || habCode.equals("")) {
							assetForm.setAddHabsDistrictName("");
							assetForm.setAddHabsMandalName("");
							assetForm.setAddHabsHabitation("");
							return mapping.findForward(mode);

						}
						Debug.println("habcode assigned");

						Debug.println("rwsLocations assigned");
						Debug.println("habcode 5865 is " + habCode);

						//	for setting codes
						assetForm.setAddHabsDistrict(habCode.substring(0, 2));
						assetForm.setAddHabsMandal(habCode.substring(5, 7));

						//	for setting names
						String district = rwsLocations.getDname(habCode
								.substring(0, 2));
						String mandal = rwsLocations.getMname(habCode
								.substring(0, 2), habCode.substring(5, 7));
						String habName = RwsMasterData.getHabName(
								getDataSource(request), subCompCode.substring(
										0, 16));

						assetForm.setAddHabsDistrictName(district);
						assetForm.setAddHabsMandalName(mandal);
						assetForm.setAddHabsHabitation(habName + "-"
								+ habCode.substring(0, 16));

						Debug.println("district assigned and is " + district);
						Debug.println("mandal assigned and is " + mandal);
						Debug.println("selected district code is"
								+ habCode.substring(0, 2));
						Debug.println("selected mandal code is"
								+ habCode.substring(5, 7));
						Debug.println("selected district is" + district);
						Debug.println("selected mandal is" + mandal);
						Debug.println("habName 5894 is " + habName);

					} catch (Exception e) {
						Debug.println("exception in initialisation" + e);
					}

					//dists=rwsLocations.getDistricts();
					if (!assetForm.getAddHabsDistrict().equals("")) {
						Debug.println("in mandals");
						mandals = rwsLocations.getMandals(assetForm
								.getAddHabsDistrict());
						session.setAttribute("mandals", mandals);
					}

					if (!assetForm.getAddHabsDistrict().equals("")
							&& !assetForm.getAddHabsMandal().equals("")) {
						Debug.println("in habs");
						prhabs = rwsLocation.getHabs(assetForm
								.getAddHabsDistrict(), assetForm
								.getAddHabsMandal());
						session.setAttribute("prhabs", prhabs);
					}

					String phCode1 = request.getParameter("subCompCode1");

					Debug.print("subCompCode 1111111  " + phCode1);
					if (phCode1 == null || phCode1.equals("null")) {
						Debug.println("in else- phcode1 is nul");
					} else
						session.setAttribute("phCode1", phCode1);

					if (session.getAttribute("dists") != null)
						Debug.println("dist length in addHab: "
								+ ((ArrayList) session.getAttribute("dists"))
										.size());

				} catch (Exception e) {
					Debug.println("The error in1234   is " + e);
				}
				Debug.println("returning mode from addHabs is " + mode);
				return mapping.findForward(mode);
			}

			if (mode.equalsIgnoreCase("SaveHab")) {
				Debug.println("in SaveHab mode");
				Debug.println("shortSchemeCode is "
						+ session.getAttribute("shortSchemeCode"));
				Debug.println("in saveHab");
				Debug.println("***hab code is "
						+ (String) request.getParameter("habCode"));
				Debug.println("dist length in save: "
						+ ((ArrayList) session.getAttribute("dists")).size());
				String shortSchemeCode = (String) session
						.getAttribute("shortSchemeCode");
				SubCompMetaData subCompMetaData = new SubCompMetaData();

				try {
					//&&&&&&&&&& getting next scheme code
					//String
					// nextSchemeCode=subCompMetaData.getNextSchemeCode(getDataSource(request),(String)request.getParameter("assetTypeCode"),(String)request.getParameter("assetCompTypeCode"),(String)request.getParameter("assetSubCompTypeCode"),shortSchemeCode,(String)request.getParameter("habCode"),(String)session.getAttribute("assetCode"));

					String nextSchemeCode = "";

					if ((request.getParameter("assetTypeCode").equals("01")
							|| request.getParameter("assetTypeCode").equals(
									"02") || request.getParameter(
							"assetTypeCode").equals("03"))) {
						if (request.getParameter("assetCompTypeCode").equals(
								"02"))
							assetsubCompParams = (ArrayList) assetForm
									.getAssetHeadWorks();
						else if (request.getParameter("assetCompTypeCode")
								.equals("03"))
							assetsubCompParams = (ArrayList) assetForm
									.getAssetPipeLine();
						else if (request.getParameter("assetCompTypeCode")
								.equals("04"))
							assetsubCompParams = (ArrayList) assetForm
									.getAssetReservior();
						else if (request.getParameter("assetCompTypeCode")
								.equals("05"))
							assetsubCompParams = (ArrayList) assetForm
									.getAssetPumpSets();

						nextSchemeCode = getFormNextSchemeCode((String) request
								.getParameter("assetCompTypeCode"),
								(String) request
										.getParameter("assetSubCompTypeCode"),
								(String) request.getParameter("assetTypeCode"),
								assetsubCompParams, shortSchemeCode,
								(String) request.getParameter("habCode"));
					}

					Debug.println("*******nextSchemeCode is " + nextSchemeCode);

					if (nextSchemeCode == null || nextSchemeCode.length() != 24)
					{
						Debug.println("getting next schemeCode from datebase");
						Debug.println(request
								.getParameter("assetTypeCode")+".."+request
								.getParameter("assetCompTypeCode")+".."+request
								.getParameter("assetSubCompTypeCode")+".."+request
								.getParameter("habCode")+".."+(String) session.getAttribute("assetCode"));
						
						nextSchemeCode = subCompMetaData.getNextSchemeCode(
								getDataSource(request), (String) request
										.getParameter("assetTypeCode"),
								(String) request
										.getParameter("assetCompTypeCode"),
								(String) request
										.getParameter("assetSubCompTypeCode"),
								shortSchemeCode, (String) request
										.getParameter("habCode"),
								(String) session.getAttribute("assetCode"));
					}
					session.setAttribute("nextSubCompCode", nextSchemeCode);
					//code added
					Debug.println(getFormNextSchemeCode((String) request
							.getParameter("assetCompTypeCode"),
							(String) request
									.getParameter("assetSubCompTypeCode"),
							(String) request.getParameter("assetTypeCode"),
							assetsubCompParams, shortSchemeCode,
							(String) request.getParameter("habCode")));
					//end of code added
					Debug.println("checking todo");
					if (((String) request.getParameter("toDo"))
							.equalsIgnoreCase("newHab")) {
						//code to get new pumpcode
						//parameters are assetcode,compcode,subcompcode
						request.setAttribute("isNewSubComp", "true");
						Debug.println("in toDo=newHab");
						Debug.println("assetCode is"
								+ request.getParameter("assetTypeCode"));
						Debug.println("comp Code is"
								+ request.getParameter("assetCompTypeCode"));
						Debug.println("subcomp code is "
								+ request.getParameter("assetSubCompTypeCode"));
						Debug.println("hab code is "
								+ request.getParameter("habCode"));
						assetForm.setMode("goToAddNewAction");
						return mapping.findForward("goToAddNewAction");
					}
					RwsLocations rwsLocations = new RwsLocations(
							getDataSource(request));
					dists = rwsLocations.getDistricts();

					session.setAttribute("dists", dists);
					Debug.println("district is  name "
							+ request.getParameter("district"));
					Debug.println("mandals is   "
							+ request.getParameter("mandal"));
					Debug.println("habCode is  name "
							+ request.getParameter("habCode"));
					String subCompCode = (String) session
							.getAttribute("phCode1");

				} catch (Exception e) {
					Debug.println("The error in1234   is " + e);
				}
				Debug.println("message is" + message);
				request.setAttribute("message", message);
				Debug.println("dist length in save: "
						+ ((ArrayList) session.getAttribute("dists")).size());
			}

			if (assetSubCompCode != null && assetSubCompCode.equals("003")
					&& mode.equals("addNew"))
				mode = "pumpset";
			if (assetSubCompCode != null && assetSubCompCode.equals("003")
					&& mode.equals("removeSubComps"))
				mode = "pumpset";
			Debug.println("typeOfAssetCode:" + typeOfAssetCode);
			//common code z
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode
					.equals("03"))
					&& assetCompTypeCode.equals("03")
					&& (assetSubCompTypeCode.equals("001")
							|| assetSubCompTypeCode.equals("002") || assetSubCompTypeCode
							.equals("003"))
					&& !mode.equalsIgnoreCase("AddHabs")
					&& !mode.equalsIgnoreCase("saveHab")) {
				mode = "pumpset";
				Debug.println("changed mode to pumpset");
			}
			if ((typeOfAssetCode.equals("05") || typeOfAssetCode.equals("06")
					|| typeOfAssetCode.equals("07") || typeOfAssetCode
					.equals("08"))
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
			{
				Debug.println("test with others>>>>>>>>>>>>>>>");
				mode = "ponds";
				
			}
			if ((typeOfAssetCode.equals("01") || typeOfAssetCode.equals("02") || typeOfAssetCode
					.equals("03"))
					&& assetCompTypeCode.equals("04")
					&& assetSubCompTypeCode.equals("003")
					&& mode.equalsIgnoreCase("pumpset"))
				mode = "addNew";

			Debug.println("returning mode  5294 is" + mode);
			Debug.println("assetsubCompParams is "
					+ session.getAttribute("assetsubCompParams"));
			//Debug.println("assetForm.assetForm.getAssetPumpSets.size
			// is"+assetForm.getAssetPumpSets().size());
			//end of common code z
			//This catch block is for the try block which includes whole of the
			// execute method
		} catch (Exception e) {
			Debug
					.println("An Exception has occured at the end of assetActFrm.java execute method "
							+ e);
		}
		System.gc();
		return (mapping.findForward(mode));

	}

	/*
	 * public void reset(ActionMapping mapping,HttpServletRequest request) {
	 * //this.coc=""; //this.doc=""; //this.sdoc=""; //this.district="";
	 * //this.mandal=""; // this.pcode=""; // this.vcode="";
	 * form.getCircleOfficeCode()=""; form.getDivisionOfficeCode="";
	 * form.subdivisionOfficeCode=""; form.district=""; form.mandal="";
	 * form.habCode=""; form.habname=""; form.assetTypeCode="";
	 * form.dateofCreation=""; form.location=""; form.assetCost="";
	 * form.startYear=""; form.endYear=""; form.assetName=""; form.pumpCode="";
	 * form.opType=""; form.yield=""; form.assetStatus="";
	 * form.assetStatusName=""; form.assetCompTypeCode="";
	 * form.assetSubCompTypeCode=""; form.assetCode=""; form.assetHabs.clear();
	 * form.assetSubComponents.clear(); //form.assetPipeLine.clear();
	 * form.assetHeadWorks.clear(); form.assetReservior.clear();
	 * form.assetPumpSets.clear(); form.assetPonds.clear();
	 * form.assetSHP.clear(); form.assetOpenWells.clear();
	 * form.assetOthers.clear();
	 *  }
	 */

	protected ArrayList fillPipeLine(ArrayList list, DataSource dataSource)
			throws Exception {
		Debug.println("in fillPipeLine()");
		CommonLists commonLists = new CommonLists(dataSource);
		Debug.println("in fillPipeLine in rws_assetActFrm.java");

		Asset_PipeLine subcompParams = new Asset_PipeLine();
		Debug.println("list size is " + list.size());
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
		Debug.println("returning list of size " + list.size());
		return list;
	}

	public String getNewAssetCode(HttpServletRequest request,
			String circleOfficeCode, String divisionOfficeCode,
			String subdivisionOfficeCode, String habCode, String assetTypeCode) {
		String assetCode = "";
		try {
			Debug.println("in getnew asset code method");
			assetCode = RwsMasterData.getAssetCode(circleOfficeCode,
					divisionOfficeCode, subdivisionOfficeCode, habCode,
					assetTypeCode, getDataSource(request));
			Debug.println("assetCode afterReturning from function is"
					+ assetCode);
			if (assetCode.length() == 4) {
				Debug.println("in if of assetCode.length()==4");
				assetCode = "0000" + request.getParameter("dcode")
						+ request.getParameter("assetTypeCode")
						+ request.getParameter("mandal") + assetCode;
			} else if (assetCode.length() == 9) {
				Debug.println("in else of assetCode.length()==4");
				Debug.println("assetcode is " + assetCode);
				assetCode = "00000" + assetCode;
			} else {
				Debug.println("in else of assetCode.length()==4");
				Debug.println("assetcode is " + assetCode);
				assetCode = "0000" + assetCode;
			}
			Debug.println("Before:" + assetCode);
			assetCode = RwsMasterData.checkAssetCode(assetCode);
			if (assetCode.length() == 4) {
				Debug.println("in if of assetCode.length()==4");
				assetCode = "0000" + request.getParameter("dcode")
						+ request.getParameter("assetTypeCode")
						+ request.getParameter("mandal") + assetCode;
			} else if (assetCode.length() == 9) {
				Debug.println("in else of assetCode.length()==4");
				Debug.println("assetcode is " + assetCode);
				assetCode = "00000" + assetCode;
			} else {
				Debug.println("in else of assetCode.length()==4");
				Debug.println("assetcode is " + assetCode);
				assetCode = "0000" + assetCode;
			}
			Debug.println("after:" + assetCode);
		} catch (Exception e) {
			Debug.println("Exception in getNewAssetCode is ");
		}
		Debug.println("sssssssssssss:" + assetCode);
		return assetCode;
	}

	String saveAsset(AssetForm assetForm, HttpServletRequest request) {

		String message = "";
		try {
			RwsComplaintsMaster rwsMaster = new RwsComplaintsMaster();
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
			rwsMaster.setAssetSubCompTypeCode(assetForm
					.getAssetSubCompTypeCode());
			rwsMaster.setAssetStatus(assetForm.getAssetStatus());
			rwsMaster.setPumpCode(assetForm.getPumpCode());
			rwsMaster.setTotPopBenfit(assetForm.getTotPopBenfit());
			//			added by swapna on 17-01-2012 fri gis data entry
			rwsMaster.setLatitude(assetForm.getLatitude());
			Debug.println("assetForm.getLatitude():" + assetForm.getLatitude());
			rwsMaster.setLongitude(assetForm.getLongitude());
			Debug.println("assetForm.getLongitude():"
					+ assetForm.getLongitude());
			rwsMaster.setElevation(assetForm.getElevation());
			Debug.println("assetForm.getElevation():"
					+ assetForm.getElevation());
			rwsMaster.setWaypoint(assetForm.getWaypoint());
			Debug.println("assetForm.getWaypoint():" + assetForm.getWaypoint());
			//
			rwsMaster.setRemarks(assetForm.getRemarks());
			rwsMaster.setDpYield(assetForm.getDpYield());
			//following line is commented as handpumps contains base habitaiton
			// and it should be saved into hablink table
			//if (!assetForm.getAssetTypeCode().equals("04"))
			habs = (ArrayList) session.getAttribute("tempSelectedHabs");
			PanchRaj panchRaj = new PanchRaj();
			Debug.println("habs size:" + habs.size());
			/*
			 * for(int i = 0;i <habs.size();i++) {
			 * Debug.println("panchRaj.habCode("+i+") is :"+habs.get(i));
			 * rwsMaster = (RwsMaster) habs.get(i);
			 * Debug.println("panchRaj.habCode("+i+") is
			 * :"+rwsMaster.getHabCode()); }
			 */
			Debug.println("habCode=" + rwsMaster.getHabCode() + "assetCode="
					+ assetForm.getAssetCode() + "assetTypeCode="
					+ request.getParameter("assetTypeCode")
					+ "assetCompTypeCode="
					+ request.getParameter("assetCompTypeCode")
					+ "assetSubCompTypeCode="
					+ request.getParameter("assetSubCompTypeCode"));
			Debug.println("habs size=" + habs.size());
			Debug.println("coc=" + assetForm.getCoc());
			Debug.println("doc=" + assetForm.getDoc());
			Debug.println("sdoc=" + assetForm.getSdoc());
			Debug
					.println("circleOfficeCode="
							+ assetForm.getCircleOfficeCode());
			Debug.println("divisionOfficeCode="
					+ assetForm.getDivisionOfficeCode());
			Debug.println("subdivisionOfficeCode="
					+ assetForm.getSubdivisionOfficeCode());
			rwsMaster.setCoc(assetForm.getCircleOfficeCode());
			rwsMaster.setDoc(assetForm.getDivisionOfficeCode());
			rwsMaster.setSdoc(assetForm.getSubdivisionOfficeCode());
			Debug.println("calling insertAsset");
			message = RwsMasterData.insertAsset(rwsMaster, habs, request
					.getParameter("opType"), getDataSource(request));
			//added by swapna on 27-01-2012 for clearing the gis data after
			// save
			assetForm.setLatitude("");
			assetForm.setLongitude("");
			assetForm.setElevation("");
			assetForm.setWaypoint("");

		} catch (Exception e) {

			Debug.println("Exception in saveAsset is " + e);
		}

		return message;

	}

	public String getFormNextSchemeCode(String assetCompTypeCode,
			String assetSubCompTypeCode, String assetTypeCode,
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

				if (assetTypeCode.equals("01") || assetTypeCode.equals("02")
						|| assetTypeCode.equals("03")) {
					if (assetCompTypeCode.equals("02")) {
						assetHeadworks = (Asset_HeadWorks) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetHeadworks.getCollectionWellCode();
						}
						if (assetSubCompTypeCode.equals("002")) {
							schemeCode = assetHeadworks.getSsTankCode();
						} else if (assetSubCompTypeCode.equals("003")
								|| assetSubCompTypeCode.equals("004")) {
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
					/*
					 * else if(assetCompTypeCode.equals("03")) { assetPipeline =
					 * (Asset_PipeLine) subComps.get(i);
					 * if(assetSubCompTypeCode.equals("001")) {
					 * schemeCode=assetPipeline.getPmCode(); }
					 * if(assetSubCompTypeCode.equals("002")) {
					 * schemeCode=assetPipeline.getGravitymain_code(); } else
					 * if(assetSubCompTypeCode.equals("003")) {
					 * schemeCode=assetPipeline.getDisCode(); } }
					 */
					else if (assetCompTypeCode.equals("04")) {
						assetReservior = (Asset_Reservior) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetReservior.getOhsrCode();
						}
						if (assetSubCompTypeCode.equals("002")) {
							schemeCode = assetReservior.getOhbrCode();
						} else if (assetSubCompTypeCode.equals("003")) {
							schemeCode = assetReservior.getGlsrCode();
						} else if (assetSubCompTypeCode.equals("004")) {
							schemeCode = assetReservior.getGlbrCode();
						} else if (assetSubCompTypeCode.equals("005")) {
							schemeCode = assetReservior.getBptCode();
						} else if (assetSubCompTypeCode.equals("006")) {
							schemeCode = assetReservior.getCisCode();
						}
					} else if (assetCompTypeCode.equals("05"))

					{
						assetPumpset = (Asset_Pumpset) subComps.get(i);
						if (assetSubCompTypeCode.equals("001")) {
							schemeCode = assetPumpset.getOtherCompCode();
						}
					}
				}
				if (schemeCode.length() == 24
						&& schemeCode.substring(0, 16).equals(habCode)) {
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
		Debug.println("schemeCode calculated from form=" + schemeCode21 + slNo);

		SubCompMetaData subCompMetaData = new SubCompMetaData(assetTypeCode,
				assetCompTypeCode, assetSubCompTypeCode);
		String subCompRep = subCompMetaData.getSubCompRep();

		String schemeCode24 = "";
		if (habCode != null && !habCode.equals("") && shortSchemeCode != null
				&& !shortSchemeCode.equals("") && schemeCode21.length() == 21)
			schemeCode24 = habCode + schemeCode21.substring(16, 19)
					+ subCompRep + slNo;
		else
			schemeCode24 = schemeCode21 + slNo;

		return schemeCode24;
	}

	public ArrayList removeTempSelectedHabs(ArrayList tempSelectedHabs,
			String mcode) {
		ArrayList returnList = new ArrayList();
		RwsComplaintsMaster rm = null;
		Debug.println("Before1:" + tempSelectedHabs.size());
		for (int i = 0; i < tempSelectedHabs.size(); i++) {
			rm = (RwsComplaintsMaster) tempSelectedHabs.get(i);
			Debug.println("I:" + i + ":" + rm.getHabCode());
		}

		for (int i = 0; i < tempSelectedHabs.size(); i++) {
			rm = (RwsComplaintsMaster) tempSelectedHabs.get(i);
			Debug.println("II:" + i + ":" + rm.getHabCode());
			if (!rm.getHabCode().substring(5, 7).equals(mcode)) {
				//tempSelectedHabs.remove(rm);
				returnList.add(rm);
			}
		}
		Debug.println("t size:" + returnList.size());
		return returnList;
	}

	public static double round(double d, int decimalPlace) {
		// see the Javadoc about why we use a String in the constructor
		// http://java.sun.com/j2se/1.5.0/docs/api/java/math/BigDecimal.html#BigDecimal(double)
		BigDecimal bd = new BigDecimal(Double.toString(d));
		bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
		return bd.doubleValue();
	}

}