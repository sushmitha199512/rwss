package nic.watersoft.proposals;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.ProgrammeSubProgrammeBean;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class EditOMProposal extends Action 
{	

	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		DataSource dataSource = getDataSource(request);
		ServletContext servletContext=null;
		HttpSession session=request.getSession();
		//System.out.println("in EditOMProposal.java");
		
		////System.out.println("form : " + form);

		ProposalForm myForm = (ProposalForm)form; 
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDTO proposalDTO = null;
		String mode = myForm.getMode();
		servletContext=session.getServletContext();
		String path=servletContext.getRealPath("uploads/proposals");
		//System.out.println("path is "+path);
		////System.out.println("Mode is : " + mode);
				
///////////////////////////////////////////////////////////////////////////////////
		//code to show uploaded file
		String contextPath=servletContext.getServletContextName();
		String mProposalId = request.getParameter("omProposalId");
		String proposalsPath=servletContext.getRealPath("uploads/proposals");
		//System.out.println("proposals path is "+proposalsPath);
		//myForm.setLineEstimatePath(fileLocation);//code added by santosh
		File file1 = new File(proposalsPath);
		File[] uploadedFiles = file1.listFiles();
		if(uploadedFiles == null)
		uploadedFiles = new File[0];
		String oldFileName = null;
		
		for(int i=0; i<uploadedFiles.length; i++)
		{
			oldFileName = uploadedFiles[i].getName();
			if(oldFileName.length()>21 && oldFileName.substring(0,23).equals("LE_"+mProposalId))
			{
				//myForm.setLineEstimatePath("./app/uploads/proposals/"+oldFileName);
				myForm.setLineEstimatePath("http://"+request.getLocalAddr()+":"+request.getLocalPort()+request.getContextPath()+"/app/uploads/proposals/"+oldFileName);
			}
		}
		
//////////////////////////////////////////////////////////////////////////////////////
		
		if(mode != null && mode.equals("get")){
			ArrayList programmes = commonLists.getProgrammes();
			ArrayList subprogrammes = commonLists.getSubprogrammes(myForm.getProgrammeCode());
			ArrayList financialYears = commonLists.getFinancialYears(2);
			request.setAttribute("subprogrammes",subprogrammes);
			request.setAttribute("programmes",programmes);
			request.setAttribute("financialYears",financialYears);
		}
		else
		if(mode != null && mode.equals("Edit"))
		{
			String omProposalId = request.getParameter("omProposalId");
			ArrayList programmesSubprogrammes = null;
			if(omProposalId != null && omProposalId.length() > 0)
			{
				proposalDTO = proposalDAO.getOMProposal(omProposalId);
				programmesSubprogrammes = 
						proposalDAO.getOMProposalProgrammes(omProposalId);
			}
			
			if(proposalDTO != null && proposalDTO.getProposalId().equals(omProposalId))
			{
				ArrayList programmeSubProgrammes = commonLists.getAllProgrammesSubProgrammes();
			    ArrayList financialYears = commonLists.getFinancialYears(2);
				request.setAttribute("programmeSubProgrammes",programmeSubProgrammes);
				request.setAttribute("financialYears",financialYears);

				myForm.setProposalId(proposalDTO.getProposalId());
				myForm.setAssetCode(proposalDTO.getAssetCode());
				myForm.setFinancialYear(proposalDTO.getFinancialYear());
				myForm.setEstimateCost(proposalDTO.getEstimateCost());
				myForm.setRemarks(proposalDTO.getRemarks());
				ProgrammeSubProgrammeBean programmeSubprogrammeBean = null;
				
				int len = programmesSubprogrammes.size();
				String[] programmeCodes = new String[len];
				String[] subprogrammeCodes = new String[len];
				for(int i=0; i<len; i++)
				{
					programmeSubprogrammeBean = (ProgrammeSubProgrammeBean)programmesSubprogrammes.get(i);
					programmeCodes[i] = programmeSubprogrammeBean.getProgrammeCode(); 
					subprogrammeCodes[i] = programmeSubprogrammeBean.getProgrammeCode()+"_"+programmeSubprogrammeBean.getSubprogrammeCode();
				}
				myForm.setProgrammeCodes(programmeCodes);
				request.setAttribute("subprogrammeCodes",subprogrammeCodes);
							
			}
			else
				target = new String("failure");
		}
		else
		if(mode != null && mode.equals("Save"))
		{
			proposalDTO = new ProposalDTO(); 
			proposalDTO.setProposalId(myForm.getProposalId());
			proposalDTO.setFinancialYear(myForm.getFinancialYear());
			proposalDTO.setEstimateCost(myForm.getEstimateCost());
			proposalDTO.setRemarks(myForm.getRemarks());
			String[] programmeCodes = request.getParameterValues("programmeCodes");
			//System.out.println("value of program codes is"+programmeCodes);
			String subprogrammeCode = null;
			String others = myForm.getOthers();
			String otherCode = "";
			if(programmeCodes!=null && programmeCodes.length > 0)
			{
				for(int i=0; i<programmeCodes.length; i++)
				{
					if(programmeCodes[i].equals("00"))
						otherCode = proposalDAO.insertProgramme(others);
				}
				
				for(int i=0; i<programmeCodes.length; i++)
				{
					subprogrammeCode = request.getParameter("subprogrammeCode_"+programmeCodes[i]);
					if(programmeCodes[i].equals("00"))
						programmeCodes[i] = otherCode;
					
					if(subprogrammeCode!=null && subprogrammeCode.length()>0 && subprogrammeCode!="")
						programmeCodes[i] = programmeCodes[i]+"_"+subprogrammeCode;
				}
			}
			boolean flag = proposalDAO.editOMProposal(proposalDTO, programmeCodes);
			if(flag)
			{ //apd8/watersoftLatest/app/uploads/proposals/
				try
				{
					FormFile lineEstimate = myForm.getLineEstimate();
					String fileName = lineEstimate.getFileName();
					if(fileName != null && fileName.length() > 0)
					{
						String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
						//String fileLocation = "/apd8/watersoftLatest/app/uploads/proposals/LE_"+myForm.getProposalId()+fileExtension;
						String fileLocation = path+"/LE_"+myForm.getProposalId()+fileExtension;
						
						InputStream in = lineEstimate.getInputStream();
						OutputStream out = new BufferedOutputStream(new FileOutputStream(fileLocation));
						
						byte[] buffer = new byte[512];
						while (in.read(buffer) != -1)
						{
							out.write(buffer);
						}
					}
					FormFile budjetEstimate = myForm.getBudjetEstimate();
					fileName = budjetEstimate.getFileName();
					if(fileName != null && fileName.length() > 0)
					{
						String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
						//String fileLocation = "/apd8/watersoftLatest/app/uploads/proposals/BE_"+myForm.getProposalId()+fileExtension;
						String fileLocation = path+"/BE_"+myForm.getProposalId()+fileExtension;
						
						InputStream in = budjetEstimate.getInputStream();
						OutputStream out = new BufferedOutputStream (new FileOutputStream(fileLocation));
						
						byte[] buffer = new byte[512];
						while (in.read(buffer) != -1)
						{
							out.write(buffer);
						}
					}
				}
				catch(Exception e)
				{
					//System.out.println("Error uploading files in EditOMProposal " + e);
				}
				finally
				{
					
				}
				
				target = new String("edit-success");
				myForm.setInit(false);
			}
			else
				target = new String("failure");
		}
		return mapping.findForward(target);
	}
}
