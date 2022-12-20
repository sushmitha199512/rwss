package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class Rws_NotGrounded_Works_Act extends Action {

	DataSource dataSource = null;

	String circleCode = "";

	int divisionCode = 0;

	String subdivisionCode = "";

	String subdivisionName = "";

	String programmeCode = "";

	String subprogrammeCode = "";

	String mandal = "";

	String workCode = "";

	String assetCode = "";

	ArrayList divisions = null;

	ArrayList programs = null;

	ArrayList circles = null;

	ArrayList subdivisions = null;

	String circleName = "";

	String divisionName = "";

	String checking[] = null;

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession(true);
		dataSource = getDataSource(request);
  
		RwsWorksDAO rwsWorksDAO = new RwsWorksDAO();
		String mode1 = request.getParameter("mode1");
		String userId = "";
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null)
			return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		
		userId = user.getUserId();
		session.setAttribute("isUpdate", "false");

		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("data")) {

			Rws_NotGrounded_Works_form workForm = (Rws_NotGrounded_Works_form) form;
			try {
				dataSource = getDataSource(request);
				

				RwsOffices offices = new RwsOffices(dataSource);

				String usercode = user.getCircleOfficeCode();
				
				if(workForm.getCircleCode()!=null && workForm.getCircleCode().equals("")){
					workForm.setCircleCode(usercode);
				}

				if (mode1 != null && mode1.equalsIgnoreCase("clear")) {
					workForm.setWorkidS("");
				}

				if (!(user.getUserId().equals("admin") || user.getUserId()
						.equals("100000"))) {
					session.setAttribute("fixcircle", "yes");

					circleCode = userId.substring(1, 3);
					divisionCode = workForm.getCmbDivision();
					offices = new RwsOffices(dataSource);
					session.setAttribute("divisions", offices.getDivisions("1",circleCode));
					if (mode1 == null)
						mode1 = "Divisions";
				} else {
					session.setAttribute("fixcircle", null);
					circleCode = workForm.getCircleCode();
					divisionCode = workForm.getCmbDivision();
				}
				offices = new RwsOffices(dataSource);
				circles = offices.CircleCombo("1");
				session.setAttribute("circles", circles);

				if ((circleCode != null && mode1 != null && mode1
						.equalsIgnoreCase("Divisions"))) {

					reset(workForm, session);

					dataSource = getDataSource(request);
					workForm.setCircleCode(circleCode);
					

					divisions = offices.getDivisions1(workForm.getCircleCode());
					session.setAttribute("divisions", divisions);

				}
				if (mode1 != null && mode1.equals("getPrograms")) {
					session.setAttribute("programs",new ArrayList());
					session.setAttribute("programs",rwsWorksDAO.getPrograms(workForm
							.getCircleCode(), workForm.getCmbDivision(),
							workForm.getCategory()));
				}
				
				if (mode1 != null && mode1.equals("getYears")) {
					session.setAttribute("sanYears",rwsWorksDAO.getSanctionYears(workForm
							.getCircleCode(), workForm.getCmbDivision(),
							workForm.getCategory(),workForm.getProgramCode()));
				}
				if (mode1 != null && mode1.equals("getworks")) {
					reset1(workForm, session);
					session.setAttribute("works", rwsWorksDAO.getWorks(workForm
							.getCircleCode(), workForm.getCmbDivision(),
							workForm.getCategory(),workForm.getSanctionYear(),workForm.getProgramCode()));
					
					
					
				}
				if (mode1 != null && mode1.equals("getworkDetails")) {
					reset1(workForm, session);
					rwsWorksDAO.getWorkDetails(workForm);
					if (workForm.isUpdate()) {
						session.setAttribute("isUpdate", "tru" + "e");
					} else {
						session.setAttribute("isUpdate", "false");
					}
				}
				if (mode1 != null && mode1.equals("search")) {
					reset1(workForm, session);
					session.removeAttribute("sanYears");
					session.removeAttribute("works");
					session.removeAttribute("programs");
					
					workForm.setCircleCode(workForm.getWorkidS().substring(4,6));
					divisions = offices.getDivisions1(workForm.getCircleCode());
					session.setAttribute("divisions", divisions);
					

					workForm.setWorkIdList(workForm.getWorkidS());
						rwsWorksDAO.getWorkDetails(workForm);
					if (workForm.isUpdate()) {
						session.setAttribute("isUpdate", "tru" + "e");
					} else {
						session.setAttribute("isUpdate", "false");
					}
				}

				if (mode1 != null && mode1.equals("save")) {
					session = request.getSession();
				    String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {	
				    	String message="";
				    	int count =0;
				    	double partaBillAmount=rwsWorksDAO.getPartABillAMount(workForm.getWorkIdList())/100000;
					
					 	if(partaBillAmount==0){
					    	count = rwsWorksDAO.save(workForm, userId);
					    }else if(partaBillAmount>Double.parseDouble(workForm.getPartAAmount()) && partaBillAmount>0){
							message="Part A Bill Released Amount is greater than Part A Amount";
					    }
					    else{
					    	count = rwsWorksDAO.save(workForm, userId);
					    }
					 
					 	if (count > 0) {
							if(!workForm.isUpdate()){
								message="Saved Successfully";
								}
							else{
								message="Updated Successfully";
							}
							reset(workForm, session);
							reset1(workForm, session);

						} else {
							//message="Failed ";
							reset(workForm, session);
							reset1(workForm, session);

						}
						session.setAttribute("message", message);
				    }
				}
				if (mode1 != null && mode1.equals("view")) {

					ArrayList reqWorks = rwsWorksDAO.getList(workForm
							.getCircleCode(), workForm.getCmbDivision());
					session.setAttribute("reqWorks", reqWorks);
					return mapping.findForward(mode1);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return mapping.findForward(mode);
	}

	private void reset1(Rws_NotGrounded_Works_form workForm, HttpSession session) {
		workForm.setLandAquisition("");
		workForm.setRailwayCrossingPermission("");
		workForm.setRoadCrossingPermission("");
		workForm.setRoadCrossingPermissionNHAI("");
		workForm.setForestClearance("");
		workForm.setWaterDrawlPermission("");
		workForm.setOthers("");
		workForm.setOthersReason("");
		workForm.setDprCompDate("");
		workForm.setDprStatus("");
		workForm.setRemarks("");
		workForm.setLandAquisitionNumber("");
		workForm.setLandAquisitionObtainDate("");
		workForm.setWaterDrawlPermissionNumber("");
		workForm.setWaterDrawlPermissionObtainDate("");
		workForm.setRailwayCrossingPermissionNumber("");
		workForm.setRailwayCrossingPermissionObtainDate("");
		workForm.setRoadCrossingPermissionNumber("");
		workForm.setRoadCrossingPermissionObtainDate("");
		workForm.setForestClearanceNumber("");
		workForm.setForestClearanceObtainDate("");
		workForm.setRemarks("");
		workForm.setOthersNumber("");
		workForm.setOthersObtainDate("");
		workForm.setPartAClearnce("");
		workForm.setPartAClearnceDate("");
		workForm.setLandAquisitionReqDate("");
		workForm.setLandAquisitionReqNumber("");
		workForm.setWaterDrawlPermissionReqDate("");
		workForm.setWaterDrawlPermissionReqNumber("");
		workForm.setRailwayCrossingPermissionReqNumber("");
		workForm.setRailwayCrossingPermissionReqDate("");
		workForm.setRoadCrossingPermissionReqDate("");
		workForm.setRoadCrossingPermissionReqNumber("");
		workForm.setRoadCrossingPermissionReqNumberNHAI("");
		workForm.setRoadCrossingPermissionReqDateNHAI("");
		workForm.setForestClearanceReqDate("");
		workForm.setForestClearanceReqNumber("");
		workForm.setOthersReqDate("");
		workForm.setOthersReqNumber("");
		workForm.setSourceCreated("");
		workForm.setSourceCreatedDate("");
		workForm.allReset();
		
		
		
		

	}

	private void reset(Rws_NotGrounded_Works_form workForm, HttpSession session) {
		workForm.setWorkid("");
		workForm.setWorkName("");
		workForm.setSanctionedAmount("");
		workForm.setSanctionedDate("");
		workForm.setProgram("");
		workForm.setSubProgName("");
		workForm.setCmbDivision(0);
		workForm.setCategory("0");
		session.setAttribute("works", new ArrayList());

	}
}