package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.RwsUser;

public class rws_ProgrammeEntryAct_frm extends Action
{
	protected ActionForm buildProgrammeForm(String prgmCode,HttpServletRequest request) throws Exception 
	{
		ProgrammeForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getProgramme(prgmCode,getDataSource(request));		
			if(rwsMaster!=null)
			{
				form = new ProgrammeForm();
				form.setPrgmCode(rwsMaster.getPrgmCode());
				form.setPrgmName(rwsMaster.getPrgmName());
				form.setPrgmStartYr(rwsMaster.getPrgmStartYr());
				form.setCentralShare(rwsMaster.getCentralShare());
				form.setStateShare(rwsMaster.getStateShare());
				form.setPublicShare(rwsMaster.getPublicShare());
				form.setOtherShare(rwsMaster.getOtherShare());
				form.setStatus(rwsMaster.getStatus());
				form.setPrgmEndDate(rwsMaster.getPrgmEndDate());
				form.setNrdwprelated(rwsMaster.getNrdwprelated());
				form.setCmcoredb(rwsMaster.getCmcoredb());
				form.setProgBelongTo(rwsMaster.getProgBelongTo());
			}
			return form;
	}

public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");			
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList programmes=null;
		ProgrammeForm frm=(ProgrammeForm) form;
		RwsMaster rwsMaster = new RwsMaster();
		String mode=frm.getMode();
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",RwsMasterData.getProgrammeCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				programmes=RwsMasterData.getProgrammes(getDataSource(request));
				session.setAttribute("programmes",programmes);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			
			try
			{
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {				
					rwsMaster.setPrgmCode(frm.getPrgmCode());
					rwsMaster.setPrgmName(frm.getPrgmName());
					rwsMaster.setPrgmStartYr(frm.getPrgmStartYr());
					rwsMaster.setCentralShare(frm.getCentralShare());
					rwsMaster.setStateShare(frm.getStateShare());
					rwsMaster.setPublicShare(frm.getPublicShare());
					rwsMaster.setOtherShare(frm.getOtherShare());
					rwsMaster.setStatus(frm.getStatus());
					rwsMaster.setPrgmEndDate(frm.getPrgmEndDate());
					rwsMaster.setNrdwprelated(frm.getNrdwprelated());
					rwsMaster.setCmcoredb(frm.getCmcoredb());
					rwsMaster.setProgBelongTo(frm.getProgBelongTo());				
					ans=RwsMasterData.insertProgramme(rwsMaster,getDataSource(request));
					request.setAttribute("code",RwsMasterData.getProgrammeCode(getDataSource(request)));
					frm.reset(mapping,request);
			     }
			}
			catch(Exception e)
			{
				System.out.println("Error at save mode of rws_ProgrammeEntryAct_frm is  "+e);//e.printStackTrace();
			}
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The Record Cant be inserted   ";
			}
			else
			{	message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildProgrammeForm(request.getParameter("prgmCode"),request);
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
				System.err.println("The error in rws_ProgrammeEntryAct_frm in get is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
					rwsMaster.setPrgmCode(frm.getPrgmCode());
					rwsMaster.setPrgmName(frm.getPrgmName());
					rwsMaster.setPrgmStartYr(frm.getPrgmStartYr());
					rwsMaster.setCentralShare(frm.getCentralShare());
					rwsMaster.setStateShare(frm.getStateShare());
					rwsMaster.setPublicShare(frm.getPublicShare());
					rwsMaster.setOtherShare(frm.getOtherShare());
					rwsMaster.setStatus(frm.getStatus());
					rwsMaster.setPrgmEndDate(frm.getPrgmEndDate());
					rwsMaster.setNrdwprelated(frm.getNrdwprelated());
					rwsMaster.setCmcoredb(frm.getCmcoredb());
					rwsMaster.setProgBelongTo(frm.getProgBelongTo());
					ans = RwsMasterData.updateProgramme(rwsMaster,getDataSource(request));		
			     }
			}
			catch (Exception e) 
			{
				e.printStackTrace();
			}
			if(ans <1)
				{	
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message);
			}
			else
			{	message="Record Inserted Successfully";
			request.setAttribute("message",message);
			}
			
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsMasterData.removeProgramme(request.getParameter("prgmCode"),getDataSource(request));
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
				System.err.println("The error in rws_ProgrammeEntryAct_frm in delete is "+e);
			}			
		}
		return(mapping.findForward(mode));
	}
}
