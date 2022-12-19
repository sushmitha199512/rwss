package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RWS_Habitation_Yield_Action extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception{

		HabitationNewEntry_Form habForm = (HabitationNewEntry_Form) form;
	
		ArrayList circles = new ArrayList();
		ArrayList mandalOfficeNames = new ArrayList();
		ArrayList habitationsByMandals = new ArrayList();
		ArrayList habs = new ArrayList();
		ArrayList habs1 = new ArrayList();
		ArrayList sourcescpws=new ArrayList();
		RWS_HP_Yield_DAO dao = new RWS_HP_Yield_DAO();
		String page_to_be_displayed = " ";

		String mode = request.getParameter("mode");
		System.out.println("mode"+mode);
		String modeType = request.getParameter("modeType");
		page_to_be_displayed = "habidata";
		System.out.println("page_to_be_displayed"+page_to_be_displayed);
		HttpSession session = request.getSession();
		
		
		if (mode != null && mode.equalsIgnoreCase("data")) {

			String circleCode = request.getParameter("circleCode");
			session.setAttribute("circleCode", circleCode);
			String mandalCode = request.getParameter("mandalCode");
			String habId = request.getParameter("habCode");
			if (modeType != null && modeType.equals("districts")) {

				reset(mapping, request, habForm);
				circles = dao.getCircles();
				session.setAttribute("districts", circles);
				dao.getWQMasterParameterValues(habForm);
			}

			if (modeType != null && modeType.equals("mandals")) {
				session.setAttribute("mandalOfficeNames", new ArrayList());
				session.setAttribute("habMandal", new ArrayList());
				session.setAttribute("panchayats", new ArrayList());

				if (circleCode != null) {
					mandalOfficeNames = dao.getMandals(circleCode);
					session.setAttribute("mandalOfficeNames", mandalOfficeNames);
				}
			}

			if (modeType != null && modeType.equals("panchayaths")) {
				if (circleCode != null) {
					ArrayList pList = dao.getPanchayats(circleCode, mandalCode);

					session.setAttribute("panchayats", pList);
				}
			}

			if (modeType != null && modeType.equals("habs")) {
            System.out.println("in habs mode");
				if (circleCode != null && mandalCode != null) {
					habitationsByMandals = dao.habitationsByMandals(circleCode,
							mandalCode, habForm.getPanchayat());
					session.setAttribute("habMandal", habitationsByMandals);
				}
			}

			if (modeType != null && modeType.equals("sources")) {

				if (habForm.getHabs() != null && habForm.getHabs().size() > 1) {
					habForm.getHabs().clear();
				}
				if (circleCode != null && mandalCode != null) {

					/**
					 * Scheme Sources
					 */
					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("05")) {
                   System.out.println("in source details");
						habs = dao.getSchemeSources(habId);
						habForm.setHabs(habs);
					}
					/**
					 * Handpumps
					 */

					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("02")) {
						habs = dao.getHandPumps(habId);
						habForm.setHabs(habs);
					}

					/**
					 * OPen Welss
					 */

					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("03")) {
						habs = dao.getOpenWels(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}

					/**
					 * Shallow Handpumps
					 */

					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("04")) {
						habs = dao.getShallowHandpumps(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}
					
					
					/**
					 * cpws
					 */

					/*if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("01")) {
						System.out.println("in source details");
						habs = dao.getSchemeSources(habId);
						habForm.setHabs(habs);
					}*/
					
					/**
					 * Ponds
					 */
					/*if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("07")) {
						habs = dao.getPonds(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}*/
					/**
					 * OHBR
					 */
					/*if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("08")) {
						habs = dao.getOHBRs(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}*/

					/**
					 * OHSR
					 */
/*
					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("06")) {
						habs = dao.getOHSRs(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}
*/
					/**
					 * GLBR
					 */
					/*if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("09")) {
						habs = dao.getGLBRs(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}*/

					/**
					 * Direct Pumping
					 */
					
				if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("06")) {
						habs = dao.getDPs(habId);
						// dao.getWQMasterParameterValues(habForm);
						habForm.setHabs(habs);
					}
					
					
					
				}
			}
			
			
		
			
			
			
		
			/**
			 * For Saving Source Details
			 */
			if (modeType != null && modeType.equalsIgnoreCase("save")) {
				

				if (habForm.getHabs() != null) {
					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("05")) {
						dao.saveSchemeSourceDetails(habForm, request);
						habs=dao.getSchemeSources(habId);
						habForm.setHabs(habs);

					} else if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("02")) {
						System.out.println("anu");
						dao.saveHandPumpDetails(habForm, request);
						habs = dao.getHandPumps(habId);
						habForm.setHabs(habs);
					} else if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("03")) {
						System.out.println("save openwells");
						dao.saveOpenWellDetails(habForm, request);
						habs = dao.getOpenWels(habId);
						habForm.setHabs(habs);
					} else if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("04")) {
						dao.saveShallowHandpumps(habForm, request);
						habs = dao.getShallowHandpumps(habId);
						habForm.setHabs(habs);
					}
				

					if (habForm.getSourceType() != null
							&& habForm.getSourceType().equals("06")) {
						dao.saveSchemeSourceDetails(habForm, request);
						habs = dao.getDPs(habId);
						habForm.setHabs(habs);

					} 
				}

			}

		}
		
		
		/**
		 * For Assets
		 */
			if(mode!=null && mode.equalsIgnoreCase("getAssets")) 
			{
				String circleCode = request.getParameter("circleCode");
				System.out.println("getAssets");
				if (habForm.getSourceType() != null
						&& habForm.getSourceType().equals("01")) {
					
					habs=dao.getAssets(circleCode);
					session.setAttribute("habs", habs);
					session.setAttribute("message", "CPWS");
					//mode="getAssets";
				}
				
			/*	if (habForm.getSourceType() != null
						&& habForm.getSourceType().equals("06")) {
					
					habs=dao.getDpAssets(circleCode);
					session.setAttribute("habs", habs);
					session.setAttribute("message", "Direct Pumping");
					//mode="getAssets";
				}
				
				if (habForm.getSourceType() != null
						&& habForm.getSourceType().equals("07")) {
					
			
					session.setAttribute("habs", habs);
					session.setAttribute("message", "Spring's");
					
				}*/
				
				
				
				System.out.println("mode is"+mode);
				page_to_be_displayed="getAssets";
			}
			if(mode!=null && mode.equalsIgnoreCase("assethabs"))
			{
				String sourcecode=request.getParameter("sourcecode");
				System.out.println("sourcecode in assethabs habs"+sourcecode);
				session.setAttribute("sourcecode", sourcecode);
				System.out.println("sourcecode"+sourcecode);
				System.out.println("mode"+mode);
				if (habForm.getSourceType() != null
						&& habForm.getSourceType().equals("01")) {
				habs=dao.getassethabs(sourcecode);
				habForm.setHabs(habs);
				session.setAttribute("habs",habs);
				System.out.println("habs size"+habs.size());
				}
				page_to_be_displayed="assethabs";
				
			}
			
			
			if(mode!=null && mode.equalsIgnoreCase("saveHabs"))
			{	
				System.out.println("habcode");
				System.out.println("sizeee"+habForm.getHabs().size());
				if(habForm.getHabs()!=null){
					String sourcecode=(String)session.getAttribute("sourcecode");
					System.out.println("sourcecode in save habs"+sourcecode);
				String habcode = request.getParameter("hab");
				System.out.println("mode in savehabs"+sourcecode);
			
				System.out.println("habcode"+habcode);
				
				dao.saveassetHabs(habForm,sourcecode, request);
				/*habs=dao.getassethabs(sourcecode);
				habForm.setHabs(habs);*/
				
				
			}
				page_to_be_displayed="assethabs";
			
			}
			
			
			if(mode!=null && mode.equalsIgnoreCase("sources1"))
			{
				System.out.println("mode"+mode);
				String assetcode=request.getParameter("assetcode");
				System.out.println("assetcode"+assetcode);
				habs=dao.sourcedetails(assetcode);
				habForm.setHabs(habs);
				session.setAttribute("habs", habs);
				System.out.println("habs"+habs.size());
				page_to_be_displayed="sources1";
				
				
			}
			
			if(mode!=null && mode.equalsIgnoreCase("savesources"))
			{
				
				System.out.println("sizeee"+habForm.getHabs().size());
				if(habForm.getHabs()!=null){
				String sourceCode = request.getParameter("source");
				
				System.out.println("sourceCode"+sourceCode);
				String assetcode=request.getParameter("assetcode");
				dao.saveSources(habForm,request);
				page_to_be_displayed="sources1";
				}
			}
			
			if(mode!=null && mode.equalsIgnoreCase("pickmandals"))
			{
				String sourcecode=(String)session.getAttribute("sourcecode");
				System.out.println("sourceCode in action"+sourcecode);
				Object circleCode = session.getAttribute("circleCode");
				System.out.println("circleCode"+circleCode);
				ArrayList mandals1 = dao.getMandals1((String) circleCode);
				//System.out.println("mandals1"+mandals1);
				session.setAttribute("mandals1", mandals1);
				page_to_be_displayed="pickmandals";
				
			}
			
			if(mode!=null && mode.equalsIgnoreCase("habsinassets"))
			{
			System.out.println("assetcode anupama");
			String assetcode=request.getParameter("assetcode");
			 habs=dao.getHabitations(assetcode);
			 habForm.setHabs(habs);
			session.setAttribute("habs", habs);
			
			page_to_be_displayed="habsinassets";
			}
			
			if(mode!=null && mode.equalsIgnoreCase("saveassethabs"))
			{
			System.out.println("habcode");
	
			
			System.out.println("sizeee"+habForm.getHabs().size());
			if(habForm.getHabs()!=null){
				
			String habcode=request.getParameter("habcode");
			String assetcode=request.getParameter("assetcode");
			System.out.println("assetcode in anu"+assetcode);
			dao.saveHabitations(habForm,habcode,request);
			
			}
			page_to_be_displayed="habsinassets";
			}
		
			
			
			
			if(mode!=null && mode.equalsIgnoreCase("pickhabs")){


				//	System.out.println("pickhabiataions");
					String sourcecode = (String)session.getAttribute("sourcecode");
					System.out.println("sourceCode in pickhabs"+sourcecode);

					System.out.println(" selectedMcodes :"
							+ request.getParameter("selectedMcodes")
							+ request.getParameter("All"));
					String temp = request.getParameter("selectedMcodes");
					String mcodes[] = temp.split("@@");
					for (int j = 0; j < mcodes.length; j++) {
						System.out.println("mcode[" + j + "]:" + mcodes[j]);

					}

					
					try
					{
						ArrayList sanctionedHabs = dao.getSanctionedHabs(sourcecode);
						System.out.println("sanctionedHabs"+sanctionedHabs.size());
						
					ArrayList habitations21 = dao.getHabsInMandals(sourcecode,sanctionedHabs,
							 mcodes);
					System.out.println("habitations21"+habitations21);
					if (habitations21 != null)
						request.setAttribute("habitations21", habitations21);
					
					return mapping.findForward("pickhabs");
					
					
					}
					
					catch(Exception e)
					{
						
					}
					
				
				
			}
			
				
			
			
		return mapping.findForward(page_to_be_displayed);

	}

	
	/**
	 * 
	 * @param mapping
	 * @param request
	 * @param habForm
	 */
	private void reset(ActionMapping mapping, HttpServletRequest request,
			HabitationNewEntry_Form habForm) {

		HttpSession session = request.getSession();

		if (habForm.getHabs() != null) {
			habForm.getHabs().clear();
		}
		habForm.setCircleCode("");
		habForm.setDivisionCode("");
		habForm.setMandalCode("");
		session.setAttribute("mandalOfficeNames", new ArrayList());
		session.setAttribute("habMandal", new ArrayList());

	}
}
