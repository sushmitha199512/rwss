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

//import nic.watersoft.commons.Debug;

public class rws_WaterQualityParameterTestMasterEntryAct_frm extends Action
{
	protected ActionForm buildWaterParameterTestForm(String testCode,String testPCode,HttpServletRequest request) throws Exception 
	{
		WaterParameterTestForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getWaterParameterTest(testCode,testPCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new WaterParameterTestForm();

				form.setTestCode(rwsMaster.getTestCode()+" "+rwsMaster.getTestName());
				form.setTestPCode(rwsMaster.getTestPCode());
				form.setTestPName(rwsMaster.getTestPName());
				form.setMinPerVal(rwsMaster.getMinPerVal());
				form.setMaxPerVal(rwsMaster.getMaxPerVal());
				form.setUndesirableEffect(rwsMaster.getUndesirableEffect());
				
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList waterptests=null;
		ArrayList watertests=null;
		WaterParameterTestForm frm=(WaterParameterTestForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");
		}
		
		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				watertests=RwsMasterData.getWaterTests(getDataSource(request));
				session.setAttribute("watertests",watertests);
				request.setAttribute("code",RwsMasterData.getWQPTestCode(request.getParameter("testCode"),getDataSource(request)));
			}
			catch(Exception e)
			{
				System.out.println("exception in data of waterptest"+e);
			}
		}
		if(mode.equalsIgnoreCase("view") )
		{
			try
			{
				waterptests=RwsMasterData.getWaterParameterTests(getDataSource(request),request.getParameter("testCode"));
				session.setAttribute("waterptests",waterptests);
			}
			catch(Exception e)
			{
				System.out.println("exception in view of waterptest"+e);
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
				rwsMaster.setTestPCode(frm.getTestPCode());
				rwsMaster.setTestPName(frm.getTestPName());
				rwsMaster.setMinPerVal(frm.getMinPerVal());
				rwsMaster.setMaxPerVal(frm.getMaxPerVal());
				rwsMaster.setUndesirableEffect(frm.getUndesirableEffect());
				
				ans=RwsMasterData.insertWaterParameterTest(rwsMaster,getDataSource(request));
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				System.out.println("exception in save of waterptest"+e);
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
				form = buildWaterParameterTestForm(request.getParameter("testCode"),request.getParameter("testPCode"),request);
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
				System.out.println("exception in get of waterptest"+e);
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
				

				//rwsMaster.setTestCode(frm.getTestCode().substring(0,frm.getTestCode().indexOf(" ")));
				//Debug.println("ssssss  code"+frm.getTestCode().substring(0,frm.getTestCode().indexOf(" ")));
				//Debug.println("frm.getTestCode()"+frm.getTestCode());
				rwsMaster.setTestCode(frm.getTestCode());
				rwsMaster.setTestPCode(frm.getTestPCode());
				rwsMaster.setTestPName(frm.getTestPName());
				rwsMaster.setMinPerVal(frm.getMinPerVal());
				rwsMaster.setMaxPerVal(frm.getMaxPerVal());
				rwsMaster.setUndesirableEffect(frm.getUndesirableEffect());
		
				ans=RwsMasterData.updateWaterParameterTest(rwsMaster,getDataSource(request));
			}
			catch (Exception e) 
			{
				System.out.println("exception in edit of waterptest"+e);
			} 
			if(ans <1)
			{	if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
				message="The record cannot be updated.";
				mode = "get";
				request.setAttribute("message",message); 
			}else{
				message="The record Sucessfully  updated.";
				mode = "close";
				request.setAttribute("message",message);
			}  
			return(mapping.findForward(mode));
			
		}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsMasterData.removeWaterParameterTest(request.getParameter("testCode"),request.getParameter("testPCode"),getDataSource(request));
				if(ans>0)
				{
					displaymess = "Data deleted Succesfully";
					mode="close";
				}
				else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("message",displaymess);
			}
			catch (Exception e) 
			{
				System.out.println("exception in delete of waterptest"+e);
			}
		}
		return(mapping.findForward(mode));
	}
}

