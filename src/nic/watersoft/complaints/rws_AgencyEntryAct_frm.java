package nic.watersoft.complaints;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.complaints.AgencyForm;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_AgencyEntryAct_frm extends Action
{
	protected ActionForm buildAgencyForm(String agencyCode,HttpServletRequest request) throws Exception 
	{
		
		//System.out.println("build agency");
		AgencyForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getAgency(agencyCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new AgencyForm();

				form.setAgencyCode(rwsMaster.getAgencyCode());
				form.setAgencyName(rwsMaster.getAgencyName());
				
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		//System.out.println("Agency enctry");
	
	int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList Agencys=null;
		HttpSession session=request.getSession();
		AgencyForm frm=(AgencyForm) form;
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
				System.err.println("The error in rws_AgencyEntryAct_frm in inc is "+e);
			}
			
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				Agencys=RwsMasterData.getAgencys(getDataSource(request));
				session.setAttribute("Agencys",Agencys);
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}
			
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
										
				rwsMaster.setAgencyCode(frm.getAgencyCode());
				rwsMaster.setAgencyName(frm.getAgencyName());
				
				
				ans=RwsMasterData.insertAgency(rwsMaster,getDataSource(request));
				frm.reset(mapping,request);
				
			}
			
			catch(Exception e)
			{
				//System.out.println("the outor is"+e);
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
				//System.out.println("Agency code"+request.getParameter("agencyCode"));
				form = buildAgencyForm(request.getParameter("agencyCode"),request);
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
				//System.out.println("the outor is"+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
				
				rwsMaster.setAgencyCode(frm.getAgencyCode());
				rwsMaster.setAgencyName(frm.getAgencyName());
		
				ans=RwsMasterData.updateAgency(rwsMaster,getDataSource(request));
							
			}
			catch(Exception e) 
			{	//System.out.println("the error in Major Head edit is "+e);
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
				int del=RwsMasterData.removeAgency(request.getParameter("agencyCode"),getDataSource(request));
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
