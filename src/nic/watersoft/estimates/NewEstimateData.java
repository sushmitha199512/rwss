package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.BaseAction;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewEstimateData extends BaseAction
{
	CommonLists commonLists;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		//System.out.println("in executeAction");
		commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode = user.getOfficeCode();
		String designation = user.getDesignationCode();
		String tsOffice = user.getOfficeName();
		String assetType = "00";
		String sourceType = "0";
		String subsourceType = "0";
		String assetComponentCode = "0";
		String totalComponents = "0";
		String workId = null;

		EstimateForm myForm = (EstimateForm)form;
		//System.out.println("myForm.getInit(): " + myForm.getInit());
		//System.out.println("value of isExistingSource is "+myForm.getIsExistingSource());
		request.setAttribute("isExistingSource",myForm.getIsExistingSource());
		if(myForm != null)
		{
			if( myForm.getTotalComponents() != null )
				totalComponents = myForm.getTotalComponents();
			ArrayList components = myForm.getComponents();
			int size = components.size();
			int noOfComponents = 0;
			if(totalComponents != null && totalComponents.length() >= 1 && !totalComponents.equals(""))
			{
				noOfComponents = Integer.parseInt(totalComponents);
				//System.out.println("Size is " + size);
				//System.out.println("No. of Components is " + noOfComponents);
			}
			
			if(noOfComponents >= size)
			{
				size = noOfComponents - size;
				for(int i=0; i<size; i++)
				{
					components.add(new EstimateHolder());
				}
			}
			else
			{	
				//size = size - noOfComponents;
				for(int i = (size-1); i>= noOfComponents; i--)
				{
					components.remove(i);
				}
			}

			if( myForm.getAssetType() != null )
				assetType = myForm.getAssetType();
			if( myForm.getSourceType() != null )
				sourceType = myForm.getSourceType();
			if( myForm.getSubsourceType() != null )
				subsourceType = myForm.getSubsourceType();
			if( myForm.getWorkId() != null )
				workId = myForm.getWorkId();
			
			//ArrayList components = myForm.getComponents();

		}
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));

		if(workId != null && workId.length()>0)
		{
			EstimateDTO estimateDTO = estimateDAO.getWorkAmount(workId, tsOffice, designation);
			String estimateAmount = estimateDTO.getEstimateAmount();
			String sanctionedAmount = estimateDTO.getSanctionedAmount();
			boolean allowed = estimateDTO.isAllowed();
			myForm.setEstimateAmount(estimateAmount);
			myForm.setSanctionedAmount(sanctionedAmount);
			myForm.setAllowed(allowed);
		}
		 
		ArrayList financialYears = commonLists.getFinancialYears(2);
		ArrayList assetTypes = commonLists.getAssetTypes();
		ArrayList workIds = commonLists.getWorkIds(officeCode, assetType);
		ArrayList sourceTypes = commonLists.getSourceTypes();
		ArrayList subsourceTypes = commonLists.getSubsourceTypes(sourceType);
		ArrayList sources = commonLists.getSources(sourceType, subsourceType);
		ArrayList assetComponents = commonLists.getAssetComponents(assetType);
		ArrayList assetSubComponents = commonLists.getAssetSubComponents(assetType, assetComponentCode);
		
		for(int i=0;i<assetTypes.size();i++)
		{
			//System.out.println("element is"+((nic.watersoft.commons.LabelValueBean)assetTypes.get(i)).getLabel());
			if(((nic.watersoft.commons.LabelValueBean)assetTypes.get(i)).getLabel().equals("HANDPUMPS"))
			{
				assetTypes.remove(i);
			}
		}
		request.setAttribute("assetTypes", assetTypes);
		request.setAttribute("workIds", workIds);
		request.setAttribute("sourceTypes", sourceTypes);
		request.setAttribute("subsourceTypes", subsourceTypes);
		request.setAttribute("sources", sources);
		request.setAttribute("financialYears", financialYears);
		request.setAttribute("assetComponents", assetComponents);
		request.setAttribute("assetSubComponents", assetSubComponents);
		
		return mapping.findForward(target);
	}
}