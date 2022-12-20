package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowWorkComponents extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String workId = request.getParameter("workId");
		String type = request.getParameter("type");
		//System.out.println("In ShowWorkComponents.............");
		//System.out.println("Work Id:" + workId);
		//System.out.println("Estimate Type:" + type);
		if(type != null)
		{
			EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
			ArrayList workComponents = estimateDAO.getWorkComponents(workId, type);
						
			request.setAttribute("workComponents", workComponents);
		}
		return mapping.findForward("data-success");
	}
}
