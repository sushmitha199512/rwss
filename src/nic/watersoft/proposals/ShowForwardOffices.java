package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowForwardOffices extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
		
		String officeCode = request.getParameter("officeCode");
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));

		ArrayList forwardOffices = rwsOffices.getLowerOffices(officeCode);		
		
		request.setAttribute("forwardOffices", forwardOffices);
		
		
		return mapping.findForward("data-success");
	}
}
