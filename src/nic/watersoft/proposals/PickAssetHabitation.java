package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocationBean;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickAssetHabitation extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		ProposalForm myForm = (ProposalForm)form;
		String assetCode = request.getParameter("assetCode");
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
					
		ArrayList assetHabs = proposalDAO.getAssetHabitations(assetCode);
		int totalSize = assetHabs.size();
				
		ArrayList functionalHabs = proposalDAO.showFunctionalHabs(assetCode);
		int selectedSize = functionalHabs.size();
		int size = 0;
		
		//System.out.println("Asset Habs Size is " + totalSize);
		//System.out.println("Functional Habs Size is " + selectedSize);

		if(selectedSize <= 0)
			size = totalSize;
		else
			size = selectedSize;
		
		String[] habCodes = new String[size];
		
		//System.out.println("Size is " + size);
		RwsLocationBean rwsLocationBean = null;
		if(selectedSize >0)
		{	//System.out.println("In Functional Habs");
			for(int i=0; i<size; i++)
			{
				rwsLocationBean = (RwsLocationBean)functionalHabs.get(i);
				habCodes[i] = rwsLocationBean.getHabCode(); 
			}
		}
		else
		{	//System.out.println("In Asset Habs");
			for(int i=0; i<size; i++)
			{
				rwsLocationBean = (RwsLocationBean)assetHabs.get(i);
				habCodes[i] = rwsLocationBean.getHabCode(); 
			}
		}
		
		myForm.setSelectedHabCode(habCodes);
		
		request.setAttribute("assetHabs", assetHabs);
		request.setAttribute("assetCode", assetCode);
		
		return mapping.findForward(target);
	}
}
