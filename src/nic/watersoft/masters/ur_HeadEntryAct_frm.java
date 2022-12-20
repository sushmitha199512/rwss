package nic.watersoft.masters;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.UrMasterData;
import nic.watersoft.masters.HeadForm;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ur_HeadEntryAct_frm extends Action
{
	
	ArrayList headdetails=new ArrayList();
	protected ActionForm buildHeadForm(String hoc,HttpServletRequest request) throws Exception 
	{
		HeadForm form = null;
		RwsMaster rwsMaster=UrMasterData.getHead(hoc,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new HeadForm();

				form.setHoc(rwsMaster.getHoc());
				form.setHon(rwsMaster.getHon());
				
//				added by jyothi 
				form.setHoName(rwsMaster.getHoName());
				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{	
		System.out.println("xbvdfvbdfgbd");
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList heads=null;
		HeadForm frm=(HeadForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("hcode",UrMasterData.getHeadCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				System.out.println(e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
//				modified by jyothi 

                //heads=rwsOffices.getHeads();
			    //session.setAttribute("heads",heads);
				UrMasterData urMasterData=new UrMasterData();
				headdetails=UrMasterData.getHeaddetails(getDataSource(request));
				
				System.out.println("1**********"+headdetails.size());
				session.setAttribute("headdetails",headdetails);
				frm.setHeaddetails(headdetails);
			}
			catch(Exception e)
			{
				//System.out.println("The error in Head View is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
				String targetPath = getServlet().getServletContext().getRealPath("")
	 					+ File.separator + "temp.jpg";
						
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setHon(frm.getHon());
				
//				added by jyothi 
				rwsMaster.setHoName(frm.getHoName());
				//rwsMaster.setHoImageStatus(frm.getHoImageStatus());
				
				message=UrMasterData.insertHead(rwsMaster,getDataSource(request),targetPath,getServlet());
				
				request.setAttribute("hcode",UrMasterData.getHeadCode(getDataSource(request)));
				
				frm.reset(mapping,request);
			}
			catch(Exception e)
			{
				//System.out.println("the error in Head Insert is "+e);
			}
			
			
			request.setAttribute("message",message);
		
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildHeadForm(request.getParameter("hoc"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{	session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				
				//System.out.println("the error in Head get is "+e);
			}
		
	}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setHon(frm.getHon());
				
                //added by jyothi 
				rwsMaster.setHoName(frm.getHoName());
				//end
				//rwsMaster.setHoImageStatus(frm.getHoImageStatus());
				String targetPath = getServlet().getServletContext().getRealPath("")
	 					+ File.separator + "temp.jpg";
						
				ans = UrMasterData.updateHead(rwsMaster,getDataSource(request),targetPath,getServlet());
			}
			catch(Exception e) 
			{	//System.out.println("the error in Head edit is "+e);
			}
			if(ans <1)
			{	if(UrMasterData.errorMessage != null && UrMasterData.errorMessage.length() > 0)
					message = UrMasterData.errorMessage;
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
				int del=UrMasterData.removeHead(request.getParameter("hoc"),getDataSource(request));	
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
				//System.out.println("the error in Head delete is "+e);
			}
		}
		//bhagya
		if (mode != null && mode.equals("showOffImage")) {
			try{
		
			UrMasterData rms=new UrMasterData();
			String hoc=request.getParameter("hoc");
			
			
			byte a[] = rms.getOffScannedCopy(hoc);
			//System.out.println(a.length);
			session.setAttribute("copyData", a);
			} catch (Exception e) {
				Debug.println("showCompImage  " + e);
			}
			
			mode = "showFile";
			return mapping.findForward(mode);
			
		}
			return(mapping.findForward(mode));
	}
}
