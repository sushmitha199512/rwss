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

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

public class rws_WaterQualityTestMasterEntryAct_frm extends Action
{
	protected ActionForm buildWaterTestForm(String testCode,HttpServletRequest request) throws Exception 
	{
		WaterTestForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getWaterTest(testCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new WaterTestForm();

				form.setTestCode(rwsMaster.getTestCode());
				form.setTestName(rwsMaster.getTestName());
				form.setTestPeriod(rwsMaster.getTestPeriod());
				
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList watertests=null;
		HttpSession session=request.getSession();
		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");
		}
		
		WaterTestForm frm=(WaterTestForm) form;
		String mode=frm.getMode();
		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",RwsMasterData.getTestCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				System.out.println("exception in data  of water test-- "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				watertests=RwsMasterData.getWaterTests(getDataSource(request));
				session.setAttribute("watertests",watertests);
			}
			catch(Exception e)
			{
				System.out.println("exception in view  of water test-- "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
					
				rwsMaster.setTestCode(frm.getTestCode());
				rwsMaster.setTestName(frm.getTestName());
				rwsMaster.setTestPeriod(frm.getTestPeriod());
				
				
				ans=RwsMasterData.insertWaterTest(rwsMaster,getDataSource(request));
				request.setAttribute("code",RwsMasterData.getTestCode(getDataSource(request)));
				frm.reset(mapping,request);
				
			}
			
			catch(Exception e)
			{
				System.out.println("exception in save  of water test-- "+e);
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
		}
		
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildWaterTestForm(request.getParameter("testCode"),request);
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
				System.out.println("exception in get  of water test-- "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
				
				rwsMaster.setTestCode(frm.getTestCode());
				rwsMaster.setTestName(frm.getTestName());
				rwsMaster.setTestPeriod(frm.getTestPeriod());
		
				ans=RwsMasterData.updateWaterTest(rwsMaster,getDataSource(request));
			}
			catch (Exception e) 
			{
				System.out.println("exception in edit  of water test-- "+e);
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
		}
		
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				int del=RwsMasterData.removeWaterTest(request.getParameter("testCode"),getDataSource(request));
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
				System.out.println("exception in delete  of water test-- "+e);
			}
		}
		
		return(mapping.findForward(mode));
	}
}
