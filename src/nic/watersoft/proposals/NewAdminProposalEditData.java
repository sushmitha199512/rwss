package nic.watersoft.proposals;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.commons.beanutils.BeanUtils;

public class NewAdminProposalEditData extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");

		ProposalForm myForm = (ProposalForm)form; 
		ProposalDAO proposalDAO = null;
		ProposalDTO proposalDTO = null;
		CommonLists commonLists = null;

		String mode = myForm.getMode();
		File file = null;

		String proposalId = request.getParameter("proposalId");
		String programmeCode = request.getParameter("programmeCode");
		
		//System.out.println("Mode in NewAdminProposalEditData : " + mode);
		
		if(mode == null)
			mode = "data";

		if(programmeCode == null)
			programmeCode = "0";

		HttpSession session = request.getSession();
		
		proposalDAO = new ProposalDAO(getDataSource(request));
		commonLists = new CommonLists(getDataSource(request));
		
		if(mode.equals("subprogrammes"))
		{
			ArrayList subprogrammes = commonLists.getSubprogrammes(myForm.getProgrammeCode());
			session.setAttribute("subprogrammes", subprogrammes);
			//System.out.println("In subprogrammes");
		}
		else
		if(mode.equals("showHabs"))
		{
			session.setAttribute("habs",proposalDAO.getTempSelectedHabs(proposalId));
		}
		else
		if(mode.equals("data"))
		{
			proposalDTO = proposalDAO.getProposalDetails(proposalId);
	
			myForm.setProposalId(proposalDTO.getProposalId());
			myForm.setProposalName(proposalDTO.getProposalName());
			
			if(programmeCode.equals("0"))
				programmeCode = proposalDTO.getProgrammeCode();
			
			if(programmeCode == null)
				programmeCode = "0";

			myForm.setProgrammeCode(programmeCode);
			//System.out.println("asdddddddd " + programmeCode);
			myForm.setSubprogrammeCode(proposalDTO.getSubprogrammeCode());
			myForm.setNoOfHabs(proposalDTO.getNoOfHabs());
			myForm.setEstimateCost(proposalDTO.getEstimateCost());
			myForm.setSanctionedAmount(proposalDTO.getSanctionedAmount());
			myForm.setPriorityCode(proposalDTO.getPriorityCode());
			myForm.setTypeOfAsset(proposalDTO.getTypeOfAsset());
			myForm.setPhased(proposalDTO.getPhased());
			myForm.setPhaseNo(proposalDTO.getPhaseNo());
						
			ArrayList programmes = commonLists.getProgrammes();
			session.setAttribute("programmes", programmes);

			ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);
			session.setAttribute("subprogrammes", subprogrammes);

			ArrayList priorities = commonLists.getPriorities();
			session.setAttribute("priorities", priorities);

			ArrayList habs = proposalDAO.getSelectedHabitations(proposalId);
			if(session.getAttribute("habs") == null)
			session.setAttribute("habs", habs);
			
			ArrayList assetTypes = commonLists.getAssetTypes();
			session.setAttribute("assetTypes", assetTypes);

			file = new File("/apd8/watersoftLatest/app/uploads/proposals/");
			File[] uploadedFiles = file.listFiles();

			String lineEstimatePath = null;
			if(uploadedFiles == null)
				uploadedFiles = new File[0];

			for(int i=0; i<uploadedFiles.length; i++)
			{
				//System.out.println("File " + (i+1) +" : " + uploadedFiles[i]);
				String fileName = uploadedFiles[i].getName();
				String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
				String actualFileName = fileName.substring(0,fileName.lastIndexOf("."));
				//System.out.println("File Name " + fileName);
				//System.out.println("File extension " + fileExtension);
				//System.out.println("actualFileName " + actualFileName);
				if(actualFileName.equals(proposalId))
				{
					lineEstimatePath = uploadedFiles[i].getAbsolutePath();
					myForm.setLineEstimatePath(lineEstimatePath);
				}
			}
		}
		else
		if(mode.equals("Save"))
		{
			String[] habCodes = request.getParameterValues("habcodes");
			for (int i = 0; i < habCodes.length; i++)
			{
				//System.out.println("habCodes["+i+"] = " + habCodes[i]);
			}
			proposalDTO = new ProposalDTO();
			BeanUtils.copyProperties(proposalDTO, myForm);
			if(proposalDAO.updateNewProposal(proposalDTO, habCodes, "adm"))
			{
				session.removeAttribute("habs");
				target = new String("update-success");
			}
		}
		
		return mapping.findForward(target);
	}
}
