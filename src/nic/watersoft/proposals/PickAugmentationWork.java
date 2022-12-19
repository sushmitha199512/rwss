/*
 * Created on Jan 16, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickAugmentationWork extends Action {
	private ArrayList assetTypes = null;
	private ArrayList endYears = null;
	private ArrayList assetIds = null;
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		AugmentationForm myForm = (AugmentationForm)form;
		CommonLists commonLists = new CommonLists(getDataSource(request));
				
		String mode = myForm.getMode();
		String assetType = myForm.getAssetType();
		String endYear = myForm.getYear();
		
		if(mode == null)
			mode = "data";
				
		if(mode.equals("data"))
		{	
			assetTypes = commonLists.getAssetTypes();
		}
		if(mode.equals("endYears"))
		{	
			endYears = commonLists.getAssetEndYears(assetType);
		}
		if(mode.equals("assetIds"))
		{	
			assetIds = commonLists.getAssetIds(assetType, endYear);
		}
				
		HttpSession session = request.getSession();
		
		session.setAttribute("assetTypes", assetTypes);
		
		if(endYears != null)
			session.setAttribute("endYears", endYears);
		if(assetIds != null)
			session.setAttribute("assetIds", assetIds);
		
		return mapping.findForward("data-success");
	}
}
