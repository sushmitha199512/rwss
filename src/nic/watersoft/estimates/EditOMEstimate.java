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

public class EditOMEstimate extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response) throws ServletException,Exception
	{
		String target = new String("data-success");
		String workId = request.getParameter("workId");
		//System.out.println("Work Id in EditOMEstimate : " + workId);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode = user.getOfficeCode();  
		EstimateForm myForm = (EstimateForm)form;
		//System.out.println("Estimate Form is " + myForm);
		
		EstimateDTO estimateDTO = null;
		
		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		CommonLists commonLists = new CommonLists(getDataSource(request));
		
		String mode = request.getParameter("mode");
		
		ArrayList subsourceTypes = null, sourceTypes = null, sources = null ;
		if(mode != null && mode.equals("data"))
		{
			estimateDTO = estimateDAO.getOMEstimateDetails(workId);
			myForm.setWorkId(estimateDTO.getWorkId());
			myForm.setWorkName(estimateDTO.getWorkName());
			String assetTypeCode = estimateDTO.getAssetTypeCode(); 
			myForm.setAssetType(estimateDTO.getAssetType());
			myForm.setSourceCode(estimateDTO.getSourceCode());
			String sourceType = estimateDTO.getSourceType();
			myForm.setSourceType(sourceType);
			String subSourceType = estimateDTO.getSubsourceType();
			myForm.setSubsourceType(subSourceType);
			myForm.setTotalComponents(estimateDTO.getTotalComponents());
			myForm.setEstimateAmount(estimateDTO.getEstimateAmount());
			myForm.setSanctionedAmount(estimateDTO.getSanctionedAmount());
			myForm.setFinancialYear(estimateDTO.getFinancialYear());
			myForm.setManpowerCharges(estimateDTO.getManpowerCharges());
			myForm.setPowerCharges(estimateDTO.getPowerCharges());
			myForm.setConsumables(estimateDTO.getConsumables());
			myForm.setRepairs(estimateDTO.getRepairs());
			myForm.setOthers(estimateDTO.getOthers());
			myForm.setRemarks(estimateDTO.getRemarks());
			
			ArrayList financialYears = commonLists.getFinancialYears(2);
			session.setAttribute("financialYears", financialYears);
			
			sourceTypes = commonLists.getSourceTypes();
			session.setAttribute("sourceTypes", sourceTypes);
			
			subsourceTypes = new ArrayList();
			if(sourceType != null)
				subsourceTypes = commonLists.getSubsourceTypes(sourceType);
			session.setAttribute("subsourceTypes", subsourceTypes);
			
			sources = new ArrayList();
			if(sourceType != null && subSourceType != null)
				sources = commonLists.getSources(sourceType, subSourceType);
			session.setAttribute("sources", sources);
					
			ArrayList assetComponents = commonLists.getAssetComponents("03");
			session.setAttribute("assetComponents", assetComponents);
			
			ArrayList components = estimateDAO.getWorkComponents(workId, "om");
			myForm.setComponents(components);

		}
		else
		if(mode != null && mode.equalsIgnoreCase("Save"))
		{
			//System.out.println("In EditOMEstimate Save called");
			String mode1 = request.getParameter("target");
			//System.out.println("Mode1 " + mode1);
			estimateDTO = new EstimateDTO();
			BeanUtils.copyProperties(estimateDTO, myForm);
			estimateDAO.updateOMEstimate(estimateDTO);
			if(mode1 != null && mode1.equals("view"))
			{
				ArrayList estimateList = estimateDAO.viewOMEstimates(officeCode);
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
			//System.out.println("KNK SHARMA");
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
