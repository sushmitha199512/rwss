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

public class rws_MajorHeadAccEntryAct_frm extends Action
{
	protected ActionForm buildMajorHeadForm(String majorHeadCode,HttpServletRequest request) throws Exception 
	{
		MajorHeadForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getMajorHead(majorHeadCode,getDataSource(request));		
			if(rwsMaster!=null)
			{
				form = new MajorHeadForm();
				form.setMajorHeadCode(rwsMaster.getMajorHeadCode());
				System.out.println("xxx "+rwsMaster.getMajorHeadName());
				form.setMajorHeadName(rwsMaster.getMajorHeadName());				
			}
			return form;
	}

public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList majorHeads=null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		MajorHeadForm frm=(MajorHeadForm) form;
		String mode=frm.getMode();
		//System.out.println("mode="+mode);
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				//System.out.println("mode="+mode);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_MajorHeadEntryAct_frm in inc is "+e);
			}
			
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				majorHeads=RwsMasterData.getMajorHeads(getDataSource(request));
				session.setAttribute("majorHeads",majorHeads);
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}			
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setMajorHeadCode(frm.getMajorHeadCode());
					rwsMaster.setMajorHeadName(frm.getMajorHeadName());
					ans = RwsMasterData.insertMajorHead(rwsMaster, getDataSource(request));
					frm.reset(mapping, request);
				}
				catch (Exception e) {
					// System.out.println("the outor is"+e);
				}
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
			try {
					form = buildMajorHeadForm(request.getParameter("majorHeadCode"), request);
					if ("request".equalsIgnoreCase(mapping.getScope())) {
						request.setAttribute(mapping.getAttribute(), form);
					} else {
						session.setAttribute(mapping.getAttribute(), form);
					}
				} catch (Exception e) {
					// System.out.println("the outor is"+e);
				}			
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
				RwsMaster rwsMaster = new RwsMaster();
				
				rwsMaster.setMajorHeadCode(frm.getMajorHeadCode());
				rwsMaster.setMajorHeadName(frm.getMajorHeadName());
		
				ans=RwsMasterData.updateMajorHead(rwsMaster,getDataSource(request));
							
			}
			catch(Exception e) 
			{	//System.out.println("the error in Major Head edit is "+e);
			}
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
				int del=RwsMasterData.removeMajorHead(request.getParameter("majorHeadCode"),getDataSource(request));
				if(del>0)
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
				//System.out.println("the outor is"+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
