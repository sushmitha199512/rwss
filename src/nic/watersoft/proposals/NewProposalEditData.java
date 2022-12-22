package nic.watersoft.proposals;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewProposalEditData extends Action 
{
	private String target;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
		ProposalForm myForm = (ProposalForm)form; 
		HttpSession session=request.getSession();
		ProposalDAO proposalDAO = null;
		ProposalDTO proposalDTO = null;
		CommonLists commonLists = null;

		//System.out.println("in NewProposalEditData.do");
		String mode = myForm.getMode();
		//System.out.println("Mode in NewProposalEditData.do " + mode);
		File file = null;

		String proposalId = request.getParameter("proposalId");
		String programmeCode = request.getParameter("programmeCode");
		String type = request.getParameter("type");
		
		if(mode == null)
			mode = "data";
		if(type == null)
			type = "ord";
		
		if(programmeCode == null)
			programmeCode = "0";
		
		////////////////////////////////////////
		ServletContext servletContext=session.getServletContext();
		String proposalsPath=servletContext.getRealPath("uploads/proposals");
		//System.out.println("porposalsPath is "+proposalsPath);
		file = new File(proposalsPath);
		//System.out.println("proposals Path is:"+proposalsPath);
		File[] uploadedFiles = file.listFiles();

		String lineEstimatePath = null;
		if(uploadedFiles == null)
			uploadedFiles = new File[0];

		
		
		///////////////////////////////////////
		
		
		
		

		if(type != null && mode != null)
		{
			proposalDAO = new ProposalDAO(getDataSource(request));
			commonLists = new CommonLists(getDataSource(request));
			if(mode.equals("subprogrammes"))
			{
				ArrayList subprogrammes = commonLists.getSubprogrammes(myForm.getProgrammeCode());
				session.removeAttribute("subprogrammes");
				session.setAttribute("subprogrammes", subprogrammes);
				//System.out.println("In subprogrammes");
			}
			else
			if(mode.equals("showHabs"))
			{
				session.setAttribute("habs",proposalDAO.getTempSelectedHabs(proposalId));
			}
			else
			if(type.equals("ord") && mode.equals("data"))
			{
				proposalDTO = proposalDAO.getProposalDetails(proposalId);
		
				myForm.setProposalId(proposalDTO.getProposalId());
				myForm.setProposalName(proposalDTO.getProposalName());
				
				if(programmeCode.equals("0"))
					programmeCode = proposalDTO.getProgrammeCode();
				
				if(programmeCode == null)
					programmeCode = "0";

				myForm.setProgrammeCode(programmeCode);
				myForm.setSubprogrammeCode(proposalDTO.getSubprogrammeCode());
				myForm.setNoOfHabs(proposalDTO.getNoOfHabs());
				myForm.setEstimateCost(proposalDTO.getEstimateCost());
				myForm.setPriorityCode(proposalDTO.getPriorityCode());
				myForm.setTypeOfAsset(proposalDTO.getTypeOfAsset());
				//modified by santosh
				myForm.setSanctionLevel(proposalDTO.getSanctionLevel());
				//end of modification
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
				
				proposalDAO.deleteTempSelectedHabs();
				proposalsPath=servletContext.getRealPath("uploads/proposals/");
			    //System.out.println("proposalsPath is "+proposalsPath);
				file = new File(proposalsPath);
				//file = new File("/apd8/watersoftLatest/app/uploads/proposals/");
				//File[] uploadedFiles = file.listFiles();

				//String lineEstimatePath = null;
				if(uploadedFiles == null)
					uploadedFiles = new File[0];

				/*for(int i=0; i<uploadedFiles.length; i++)
				{
					String url = request.getRequestURL().toString();
					//System.out.println("url is :"+request.getRequestURL().toString());
					url = url.substring(0,url.lastIndexOf("/"));
					//System.out.println("URL is " + url);
					String fileName = uploadedFiles[i].getName();
					String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					String actualFileName = fileName.substring(0,fileName.lastIndexOf("."));
					String uploadType = actualFileName.substring(0,3);
					String fileProposalId = actualFileName.substring(3,actualFileName.length()); 
					
					if(uploadType.equals("LE_") && fileProposalId.equals(proposalId))
					{
						lineEstimatePath = url + "/apd8/watersoftLatest/app/uploads/proposals/" + fileName; 
						//myForm.setLineEstimatePath(lineEstimatePath);
						//System.out.println("lineEstimatePath is"+lineEstimatePath);
						//System.out.println("setLineEstimate:"+myForm.getLineEstimatePath());
					}
				}*/
				//@modified by santosh
				for(int i=0; i<uploadedFiles.length; i++)
				{
					//String url = request.getRequestURL().toString();
					String url="http://"+request.getLocalAddr()+":"+request.getLocalPort()+request.getContextPath();
					//System.out.println("url is :"+url);
					//url = url.substring(0,url.lastIndexOf("/"));
					//System.out.println("in for");
					String fileName = uploadedFiles[i].getName();
					String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					String actualFileName = fileName.substring(0,fileName.lastIndexOf("."));
					String uploadType = actualFileName.substring(0,3);
					String fileProposalId = actualFileName.substring(3,actualFileName.length()); 
					
					if(uploadType.equals("LE_") && fileProposalId.equals(proposalId))
					{
						//System.out.println("in if");
						lineEstimatePath = url + "/uploads/proposals/" + fileName; 
						myForm.setLineEstimatePath(lineEstimatePath);
						//System.out.println("lineEstimatePath is"+lineEstimatePath);
						//System.out.println("setLineEstimate:"+myForm.getLineEstimatePath());
					}
				}
				//@modification ends
			}
			
			target = new String("ord-data-success");

		}

		return mapping.findForward(target);
	}
}
