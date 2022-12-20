package nic.watersoft.drought;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_drought_scarcity_frm extends Action
{
	protected ActionForm buildScarcityForm(String scarcityCode,HttpServletRequest request) throws Exception 
	{
		
		DroughtForm droughtForm=null;
		DroughtBean droughtBean=DroughtMasterData.getScarcity1(scarcityCode,getDataSource(request));
		
			if(droughtBean != null)
			{
				droughtForm = new DroughtForm();
				droughtForm.setScarcityCode(droughtBean.getScarcityCode());
				droughtForm.setScarcityName(droughtBean.getScarcityName());
				
				
			}
			return droughtForm;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList scarcity=null;
		DroughtForm frm=(DroughtForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		// Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) ||  user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) ))) {
			// System.out.println("USER IN ACTION"+user.getUserId());
			return mapping.findForward("unAuthorise");
		}

		String page_to_be_displayed="";
		

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("scode",DroughtMasterData.getScarcityCode(getDataSource(request)));
			}
			catch(Exception e)
			{
			System.out.println("the error in  mode data is "+e);
			}
			page_to_be_displayed="data";
		}
		//
		if(mode.equalsIgnoreCase("save"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			
			try
			{
				DroughtBean droughtbean = new DroughtBean();
						
				droughtbean.setScarcityCode(frm.getScarcityCode());
				droughtbean.setScarcityName(frm.getScarcityName());
				
				ans=DroughtMasterData.insertScarcity(droughtbean,getDataSource(request));
	
				request.setAttribute("scode",DroughtMasterData.getScarcityCode(getDataSource(request)));

				frm.reset(mapping,request);
				
			}
			
			catch(Exception e)
			{
				System.out.println("the error in save is"+e);
			}
			if(ans <1)
			{	
				message="The Record Cant be inserted";
			}
			else
			{	message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
			page_to_be_displayed="save";
		
		}
		}
		//
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=DroughtMasterData.removeScarcity(request.getParameter("scarcityCode"),getDataSource(request));
				
				if(ans>0)
				{
					message = "Data deleted Succesfully";
				}
				else
				{
					message = "Data cannot be deleted";
				}
				request.setAttribute("message",message);
			}
			catch (Exception e) 
			{
			System.out.println("exception in delete -- "+e);
			}
			page_to_be_displayed="closeWithMessage";
		}	

		//
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildScarcityForm(request.getParameter("scarcityCode"),request);
				
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
			//	e.printStackTrace();
				System.out.println("the error is Get Scarcity is "+e);
			}
			page_to_be_displayed="get";
		}
		//
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				scarcity=DroughtMasterData.getScarcity(getDataSource(request));
				session.setAttribute("scarcity",scarcity);
			}
			catch(Exception e)
			{
			System.out.println("exception in view of scarcity -- "+e);
			}
			page_to_be_displayed="view";
			
		}
		//
		if(mode.equalsIgnoreCase("edit"))
		{
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try
			{
				DroughtBean droughtBean = new DroughtBean();
					
				droughtBean.setScarcityCode(frm.getScarcityCode());
				droughtBean.setScarcityName(frm.getScarcityName());
					
				ans = DroughtMasterData.updateScarcity(droughtBean,getDataSource(request));
				
			}
			catch (Exception e) 
			{
			System.out.println("exception in edit -- "+e);
			}
			if(ans <1)
			{	
				
				message="The record cannot be updated.";
			}
			else
			{
				message="The record Updated Successfully";
			}
				
				request.setAttribute("message",message);
			
			page_to_be_displayed="closeWithMessage";
	}
		}
		

		//
				return(mapping.findForward(page_to_be_displayed));
	}
}
