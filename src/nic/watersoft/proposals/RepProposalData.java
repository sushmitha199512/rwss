package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RepProposalData extends Action
{
	private ArrayList circles, divisions, subdivisions;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		CommonLists commonLists = new CommonLists(getDataSource(request));

		String headOfficeCode = user.getHeadOfficeCode();
		String circleOfficeCode = user.getCircleOfficeCode();
		String divisionOfficeCode = user.getDivisionOfficeCode();
		String subdivisionOfficeCode = user.getSubdivisionOfficeCode();
		
		if(circleOfficeCode != null && circleOfficeCode.equals("00"))
		{
			circles = rwsOffices.getCircles(headOfficeCode);
			request.setAttribute("circles", circles);
		}
		else
		if(divisionOfficeCode != null && divisionOfficeCode.equals("0"))
		{
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			request.setAttribute("divisions", divisions);
		}
		else
		if(subdivisionOfficeCode != null && subdivisionOfficeCode.equals("0"))
		{
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
			request.setAttribute("subdivisions", subdivisions);
		}
		
		ArrayList representatives = commonLists.getRepresentatives();
		ArrayList assetTypes = commonLists.getAssetTypes();
		ArrayList programmes = commonLists.getProgrammes();

		request.setAttribute("representatives", representatives);
		request.setAttribute("assetTypes", assetTypes);
		request.setAttribute("programmes", programmes);

		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setRepDate(currentDate);
		myForm.setEndorsementDate(currentDate);
		
		return mapping.findForward("data-success");
	}
}

