package nic.watersoft.proposals;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
//import nic.watersoft.commons.Debug;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;


public class EditNewProposal extends Action
{
	String message;
	String target;
	File file;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
				
		//System.out.println("in EditNewProposal.java");
		ProposalForm myForm = (ProposalForm)form; 
		
		String mode = myForm.getMode();
		//System.out.println("mode: " + mode);
		
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		ProposalDTO proposalDTO = new ProposalDTO();

		HttpSession session = request.getSession();
		
		String habCodes[] = request.getParameterValues("habcodes");
				
		String mProposalId = myForm.getProposalId();
		
		//code added by santosh on 181006
		ServletContext servletContext=session.getServletContext();
		//System.out.println("real path is"+servletContext.getRealPath("uploads/proposals"));
		String proposalsPath=servletContext.getRealPath("uploads/proposals");
		//end of code added by santosh on 181006

		try
		{
			FormFile lineEstimate = myForm.getLineEstimate();
			String fileName = lineEstimate.getFileName();
			file = new File(fileName);
			//File file1 = new File("/apd8/watersoftLatest/app/uploads/proposals/");
			File file1 = new File(proposalsPath);
			File[] uploadedFiles = file1.listFiles();
						
			if(fileName != null && fileName.length() > 0)
			{
				if(uploadedFiles == null)
					uploadedFiles = new File[0];
				String oldFileName = null;
				for(int i=0; i<uploadedFiles.length; i++)
				{
					oldFileName = uploadedFiles[i].getName();
					if(oldFileName.length()>16)
					//System.out.println("oldFileName.substring(0,17) " + oldFileName.substring(0,17));
					if(oldFileName.length()>14)
					if(oldFileName.substring(0,15).equals("LE_"+mProposalId))
						uploadedFiles[i].delete();
				}
				
				
				String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
				//String fileLocation = "/apd8/watersoftLatest/app/uploads/proposals/LE_"+mProposalId+fileExtension;
				String fileLocation = proposalsPath+"/LE_"+mProposalId+fileExtension;
				InputStream in = lineEstimate.getInputStream();
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
			message = "An error occurred while trying to upload the specified file.\\nPlease try again!";
			session.setAttribute("GlobalConstants.Message", message);
			//System.out.println(message);
			e.printStackTrace();
		}
		
		BeanUtils.copyProperties(proposalDTO, myForm);
		
		if(proposalDAO.updateNewProposal(proposalDTO, habCodes,"ord"))
		{
			session.removeAttribute("habs");
			target = new String("edit-success");
		}			
		//System.out.println("The target is " + target);	
		return mapping.findForward(target);
	}
}
