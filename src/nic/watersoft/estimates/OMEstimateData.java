package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.BaseAction;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OMEstimateData extends BaseAction
{
	CommonLists commonLists;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String designation = user.getDesignationName();
		String officeCode = user.getOfficeCode();
		String tsOffice = user.getOfficeName();
		String officeName = user.getOfficeName();
		String assetType = "03";
		String sourceType = "0";
		String subsourceType = "0";
		String assetComponentCode = "0";
		String totalComponents = "0";
		String workId = null;

		EstimateForm myForm = (EstimateForm)form;

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
				for(int i = (size-1); i>= noOfComponents; i--)
				{
					components.remove(i);
				}
			}
			
			if( myForm.getSourceType() != null )
				sourceType = myForm.getSourceType();
			if( myForm.getSubsourceType() != null )
				subsourceType = myForm.getSubsourceType();
			if( myForm.getWorkId() != null )
				workId = myForm.getWorkId();

			myForm.setTsGivenBy(designation);
			myForm.setTsOffice(tsOffice);
		}
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		String tempOfficeCode = user.getOfficeCode();
		//System.out.println("tempOfficeCode: " + tempOfficeCode);
		String higherOfficeCode = RwsOffices.getHigherOfficeCode(tempOfficeCode);
		String higherOfficeName = rwsOffices.getOfficeName(higherOfficeCode, true);
		if(officeName.equalsIgnoreCase("HEAD OFFICE"))
		{				
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Circles");
		}
		else
		if(officeName.equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Sub Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("SUB DIVISION OFFICE"))
		{	
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));

		if(workId != null && workId.length()>0)
		{
			EstimateDTO estimateDTO = estimateDAO.getOMWorkAmount(workId, tsOffice, designation);
			myForm.setEstimateAmount(estimateDTO.getEstimateAmount());
			myForm.setSanctionedAmount(estimateDTO.getSanctionedAmount());
			
		}
		
		ArrayList financialYears = commonLists.getFinancialYears(2);
		ArrayList assetTypes = commonLists.getAssetTypes();
		ArrayList workIds = commonLists.getOMWorkIds(officeCode, assetType);
		ArrayList sourceTypes = commonLists.getSourceTypes();
		ArrayList subsourceTypes = commonLists.getSubsourceTypes(sourceType);
		ArrayList sources = commonLists.getSources(sourceType, subsourceType);
		ArrayList assetComponents = commonLists.getAssetComponents("03");
		ArrayList assetSubComponents = commonLists.getAssetSubComponents("03", assetComponentCode);
		
		request.setAttribute("assetTypes", assetTypes);
		request.setAttribute("workIds", workIds);
		request.setAttribute("sourceTypes", sourceTypes);
		request.setAttribute("subsourceTypes", subsourceTypes);
		request.setAttribute("sources", sources);
		request.setAttribute("financialYears", financialYears);
		request.setAttribute("assetComponents", assetComponents);
		request.setAttribute("assetSubComponents", assetSubComponents);
		myForm.setAssetType("03");
		
		return mapping.findForward(target);
	}
}