package nic.watersoft.wquality;
import java.io.IOException;
import nic.watersoft.commons.Debug;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WQ_DrillingStatus_frm extends Action
{
	
	protected ActionForm buildWaterFinalForm(String workCode,HttpServletRequest request) throws Exception 
	{
		HttpSession session=request.getSession();
		WQDrillStatusForm drillStatusForm = null;
		RwsWQuality rwsWQuality=RwsWQualityData.getWQDrillStatus(workCode,getDataSource(request));
		
			if(rwsWQuality!=null)
			{
				drillStatusForm = new WQDrillStatusForm();
				
				drillStatusForm.setWorkCode(rwsWQuality.getWorkCode());
				drillStatusForm.setDrillStatus(rwsWQuality.getDrillStatus());
				drillStatusForm.setDrillDate(rwsWQuality.getDrillDate());
				drillStatusForm.setYield(rwsWQuality.getYield());
				drillStatusForm.setPreparedBy(rwsWQuality.getPreparedBy());   
				drillStatusForm.setPreparedOn(rwsWQuality.getPreparedOn());
			}
			return drillStatusForm;
	}
	
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList wqDrillStatus=null;
		ArrayList wqFinalStatus=null;
		ArrayList workIds = new ArrayList();
				
		HttpSession session=request.getSession();
		RwsWQuality rwsWQuality = new RwsWQuality();
		WQDrillStatusForm drillStatusForm=(WQDrillStatusForm) form;
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String mode=drillStatusForm.getMode();
					
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				if(!rwsUser.getCircleOfficeCode().equals("00") && !rwsUser.getDivisionOfficeCode().equals("0") && rwsUser.getSubdivisionOfficeCode().equals("00"))
				{
					//System.out.println("rwsUser.getCircleOfficeCode()="+rwsUser.getCircleOfficeCode()+"    rwsUser.getDivisionOfficeCode()="+rwsUser.getDivisionOfficeCode()+"      rwsUser.getsubDivisionOfficeCode()="+rwsUser.getSubdivisionOfficeCode());
					workIds=RwsWQualityData.getWorkIds(rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode(),"status",getDataSource(request));
				}
				session.setAttribute("workIds",workIds);
			}
			catch(Exception e)
			{
				System.out.println("The error in data in rws_WQ_DrillingStatus_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("show"))
		{
			try
			{
				wqFinalStatus=RwsWQualityData.getWQFinalStatus(request.getParameter("workCode"),getDataSource(request));
				session.setAttribute("wqFinalStatus",wqFinalStatus);
				//System.out.println("wqFinalStatus.size()="+wqFinalStatus.size());
			}
			catch(Exception e)
			{
				System.out.println("The error in show in rws_WQ_DrillingStatus_frm is  "+e);
			}
		}

		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				wqDrillStatus=RwsWQualityData.getWQDrillStatuss(rwsUser.getUserId(),getDataSource(request));
				session.setAttribute("wqDrillStatus",wqDrillStatus);
				//System.out.println("wqDrillStatus.size()="+wqDrillStatus.size());
			}
			catch(Exception e)
			{
				System.out.println("The error in view in rws_WQ_DrillingStatus_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				rwsWQuality.setWorkCode(drillStatusForm.getWorkCode());
				rwsWQuality.setDrillStatus(drillStatusForm.getDrillStatus());
				rwsWQuality.setDrillDate(drillStatusForm.getDrillDate());
				rwsWQuality.setYield(drillStatusForm.getYield());
				rwsWQuality.setPreparedBy(drillStatusForm.getPreparedBy());   
				rwsWQuality.setPreparedOn(drillStatusForm.getPreparedOn());	
				
				ans=RwsWQualityData.insertWQDrillStatus(rwsWQuality,getDataSource(request));
				
				drillStatusForm.reset(mapping,request);
			}
			catch(Exception e)
			{
				System.out.println("The error in insert in rws_WQ_DrillingStatus_frm is  "+e);	
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
				form = buildWaterFinalForm(request.getParameter("workCode"),request);
				if ("request".equals(mapping.getScope())) 
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
				System.out.println("The error in get in rws_WQ_DrillingStatus_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
							
				rwsWQuality.setWorkCode(drillStatusForm.getWorkCode());
				rwsWQuality.setDrillStatus(drillStatusForm.getDrillStatus());
				rwsWQuality.setDrillDate(drillStatusForm.getDrillDate());
				rwsWQuality.setYield(drillStatusForm.getYield());
				rwsWQuality.setPreparedBy(drillStatusForm.getPreparedBy());   
				rwsWQuality.setPreparedOn(drillStatusForm.getPreparedOn());		
		
						
				RwsWQualityData.updateWQDrillStatus(rwsWQuality,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				System.out.println("the error is"+e);
			}
			
		}

		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsWQualityData.removeWQDrillStatus(request.getParameter("workCode"),getDataSource(request));
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
				System.out.println("the error in rws_WQ_DrillingStatus_frm delete is "+e);	
			}
		}	
		return(mapping.findForward(mode));
	}
}
