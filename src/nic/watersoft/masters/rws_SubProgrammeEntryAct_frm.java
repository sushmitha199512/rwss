package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_SubProgrammeEntryAct_frm extends Action
{
	protected ActionForm buildSubProgrammeForm(String prgmCode,String subprgmCode,HttpServletRequest request) throws Exception 
	{
		SubProgrammeForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getSubProgramme(prgmCode,subprgmCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new SubProgrammeForm();

				form.setPrgmCode(rwsMaster.getPrgmCode()+" "+rwsMaster.getPrgmName());
				form.setSubprgmCode(rwsMaster.getSubprgmCode());
				form.setSubprgmName(rwsMaster.getSubprgmName());
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList subprogrammes=null;
		ArrayList programmes=new ArrayList();
		HttpSession session=request.getSession();
		RwsMaster rwsMaster = new RwsMaster();
		SubProgrammeForm frm=(SubProgrammeForm) form;
		String mode=frm.getMode();
		//System.out.println("Mode is " + mode);
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				CommonLists commonLists = new CommonLists(getDataSource(request));				
				programmes = commonLists.getProgrammes();
				//System.out.print("programmes.size(): " + programmes.size());
				session.setAttribute("programmes",programmes);
				request.setAttribute("code",RwsMasterData.getSubProgrammeCode(request.getParameter("prgmCode"),getDataSource(request)));
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in inc is "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				String progCode=frm.getPrgmCode();
				if(progCode.indexOf(" ")!=-1)
					progCode=progCode.substring(0,2);
				//System.out.println("Program Code="+progCode);
				subprogrammes=RwsMasterData.getSubProgrammes(progCode,getDataSource(request));
				session.setAttribute("subprogrammes",subprogrammes);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in view is "+e);
			}
		}
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
								
				rwsMaster.setPrgmCode(frm.getPrgmCode());
				rwsMaster.setSubprgmCode(frm.getSubprgmCode());
				rwsMaster.setSubprgmName(frm.getSubprgmName());
							
				ans=RwsMasterData.insertSubProgramme(rwsMaster,getDataSource(request));
				frm.reset(mapping,request);
				
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in insert is "+e);
			}
			if(ans <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildSubProgrammeForm(request.getParameter("prgmCode"),request.getParameter("subprgmCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in get is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				rwsMaster.setPrgmCode(frm.getPrgmCode().substring(0,frm.getPrgmCode().indexOf(" ")));
				rwsMaster.setSubprgmCode(frm.getSubprgmCode());
				rwsMaster.setSubprgmName(frm.getSubprgmName());
		
				ans = RwsMasterData.updateSubProgramme(rwsMaster,getDataSource(request));
			}
			catch(Exception e) 
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in edit is "+e);
			}
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message);
			}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsMasterData.removeSubProgramme(request.getParameter("prgmCode"),request.getParameter("subprgmCode"),getDataSource(request));
				if(ans>0)
				{
					displaymess = "Data deleted Succesfully";
				}
				else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_SubProgrammeEntryAct_frm in delete is "+e);
			}
		}
		
		return(mapping.findForward(mode));
	}
}
