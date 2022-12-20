package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Asset_Change_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
			//Debug.println("mode is " + mode);
		} else {
			mode = "init";
		}
 
		rws_asset_change_division_subdivision_form myForm = (rws_asset_change_division_subdivision_form) form;
		ArrayList circles = new ArrayList();
		ArrayList divisions = new ArrayList();
		ArrayList subdivisions = new ArrayList();
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		final String userId = user.getUserId();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		rws_asset_change_division_subdivision_dao asset_change_division_subdivision_dao=new rws_asset_change_division_subdivision_dao();

		String circleOfficeCode = myForm.getCircle();
		String divisionOfficeCode = myForm.getDivision();
		String subDivisionOfficeCode = myForm.getSubDivisionOfficeCode();
		int rcount=0;
		ArrayList assetChangeDetails = new ArrayList();
		ArrayList assetChangeDetails1 = new ArrayList();
		String headOfficeCode="1";
		try {			
			
			if(mode != null && mode.equals("getData")){						
				assetChangeDetails=asset_change_division_subdivision_dao.getDetails(myForm,request);				
				session.setAttribute("assetChangeDetails", assetChangeDetails);				
				String circleName=request.getAttribute("circleName").toString();
				session.setAttribute("circleName", circleName);
				String circleCode=request.getAttribute("circleCode").toString();
				session.setAttribute("circleCode", circleCode);
				
				mode="getData";
			}
			if(mode != null && mode.equals("edit")){
				
				String assetcode=request.getParameter("assetcode");
				String habCode=request.getParameter("habCode");
				String prasentDivision=request.getParameter("prasentDivision");
				String prasentSubDivision=request.getParameter("prasentSubDivision");
				String circleCode=request.getParameter("circleCode");
				myForm.setAssetCode(assetcode);
				myForm.setHabCode(habCode);
				myForm.setPrasentDivision(prasentDivision);
				myForm.setPrasentSubDivision(prasentSubDivision);
				myForm.setCircle(circleCode);
				assetChangeDetails1=assetChangeDetails=asset_change_division_subdivision_dao.getAssetDetails(myForm, request);
				session.setAttribute("assetChangeDetails1", assetChangeDetails1);
				mode="edit";
			}
			if(mode!=null && mode.equalsIgnoreCase("saveassethabs"))
			{
				String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
					String message=asset_change_division_subdivision_dao.saveAssetDetails(myForm, session);
					request.setAttribute("message", message);
			    }
			assetChangeDetails=asset_change_division_subdivision_dao.getDetails(myForm,request);
			session.setAttribute("assetChangeDetails", assetChangeDetails);
			String circleName=request.getAttribute("circleName").toString();
			session.setAttribute("circleName", circleName);
			String circleCode=request.getAttribute("circleCode").toString();
			session.setAttribute("circleCode", circleCode);
			  
			mode="getData";
			}
		} catch (Exception e) {
			System.out.println("Exception at asset Change Action form "+ e);
		}
		return mapping.findForward(mode);

	}

	private void reset1(rws_asset_change_division_subdivision_form myForm) {
		myForm.setCircleOfficeCode("");
		myForm.setCircle("");
		myForm.setDivision("");
		myForm.setSubDivision("");
	}

	private void reset(rws_asset_change_division_subdivision_form myForm) {
		myForm.setCircleOfficeCode("");
		myForm.setCircle("");
		myForm.setDivision("");
		myForm.setSubDivision("");

}
}