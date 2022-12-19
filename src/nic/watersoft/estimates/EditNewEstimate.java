
package nic.watersoft.estimates;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class EditNewEstimate extends Action
{
	ArrayList sourceTypes, subsourceTypes, sources;
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response) throws ServletException,Exception
	{
		String target = new String("data-success");
		String workId = request.getParameter("workId");
		//System.out.println("Work Id in EditNewEstimate : " + workId);
		HttpSession session = request.getSession(true);
		EstimateForm myForm = (EstimateForm)form;
		//System.out.println("Estimate Form is " + myForm);
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode  = user.getOfficeCode();
		EstimateDTO estimateDTO = null;
		
		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		CommonLists commonLists = new CommonLists(getDataSource(request));
		
		String mode = request.getParameter("mode");
		if(mode != null && mode.equals("data"))
		{
			estimateDTO = estimateDAO.getEstimateDetails(workId);
			myForm.setWorkId(estimateDTO.getWorkId());
			myForm.setWorkName(estimateDTO.getWorkName());
			String assetTypeCode = estimateDTO.getAssetTypeCode(); 
			myForm.setAssetType(estimateDTO.getAssetType());
			myForm.setSourceCode(estimateDTO.getSourceCode());
			String sourceType = estimateDTO.getSourceType();
			myForm.setSourceType(sourceType);
			String subSourceType = estimateDTO.getSubsourceType();
			myForm.setSubsourceType(subSourceType);
			myForm.setEstimateAmount(estimateDTO.getEstimateAmount());
			myForm.setSanctionedAmount(estimateDTO.getSanctionedAmount());
			myForm.setFinancialYear(estimateDTO.getFinancialYear());
			myForm.setRemarks(estimateDTO.getRemarks());
			myForm.setTotalComponents(estimateDTO.getTotalComponents());
			
			ArrayList financialYears = commonLists.getFinancialYears(2);
			session.setAttribute("financialYears", financialYears);
			
			sourceTypes = commonLists.getSourceTypes();
			session.setAttribute("sourceTypes", sourceTypes);
			
			subsourceTypes = new ArrayList();
			if(sourceType != null)
			{
				subsourceTypes = commonLists.getSubsourceTypes(sourceType);
				session.setAttribute("subsourceTypes", subsourceTypes);
			}
			sources = new ArrayList();
			if(sourceType != null && subSourceType != null)
			{
				sources = commonLists.getSources(sourceType, subSourceType);
				session.setAttribute("sources", sources);
			}
						
			ArrayList assetComponents = commonLists.getAssetComponents(assetTypeCode);
			session.setAttribute("assetComponents", assetComponents);
			
			ArrayList components = estimateDAO.getWorkComponents(workId, "new");
			myForm.setComponents(components);
			
		}
		else
		if(mode != null && mode.equalsIgnoreCase("Save"))
		{
			//System.out.println("In EditNewEstimate Save called");
			estimateDTO = new EstimateDTO();
			BeanUtils.copyProperties(estimateDTO, myForm);
			estimateDAO.updateNewEstimate(estimateDTO);
			String mode1 = request.getParameter("target"); 		
			if(mode1 != null && mode1.equals("view"))
			{
				ArrayList estimateList = estimateDAO.viewNewEstimates(officeCode);
				request.setAttribute("estimateList", estimateList);
				target = new String("update-view-success");
			}
			else
				target = new String("update-tech-success");
			
		}
		else
		if(mode != null && mode.equals("subsources"))
		{
			String sourceTypeCode = myForm.getSourceType();
			subsourceTypes = commonLists.getSubsourceTypes(sourceTypeCode);
			session.setAttribute("subsourceTypes", subsourceTypes);
			session.setAttribute("sources", new ArrayList());
			myForm.setSubsourceType("");
			myForm.setSourceCode("");
		}
		else
		if(mode != null && mode.equals("sources"))
		{
			String sourceTypeCode = myForm.getSourceType();
			String subsourceTypeCode = myForm.getSubsourceType();
			sources = commonLists.getSources(sourceTypeCode, subsourceTypeCode);
			session.setAttribute("sources", sources);
			myForm.setSourceCode("");
		}
		else
		if(mode != null && mode.equals("components"))
		{
			String totalComponents = myForm.getTotalComponents();
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
		}
			
		return mapping.findForward(target);
	}
}
