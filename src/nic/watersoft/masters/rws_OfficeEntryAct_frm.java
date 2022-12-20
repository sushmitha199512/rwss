package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
public class rws_OfficeEntryAct_frm extends Action
{
	ArrayList circlecodes=new ArrayList();
	ArrayList divcodes=new ArrayList();
	ArrayList subdivcodes=new ArrayList();
	RwsOffices rwsOffices;
	HttpSession session;
	protected ActionForm buildOfficeForm(String roc,HttpServletRequest request) throws Exception 
	{
		OfficeForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getOffice(roc,getDataSource(request));	
			if(rwsMaster!=null)
			{
				form = new OfficeForm();
         		form.setHoc(rwsMaster.getHoc());
				form.setCoc(rwsMaster.getCoc());
				form.setDoc(rwsMaster.getDoc()); 
				form.setSdoc(rwsMaster.getSdoc());
				form.setRoc(rwsMaster.getRoc());
				form.setAddress(rwsMaster.getAddress());
				form.setArea(rwsMaster.getArea());
				form.setLocation(rwsMaster.getLocation());
				form.setCity(rwsMaster.getCity());
				form.setPin(rwsMaster.getPin());
				form.setPhone(rwsMaster.getPhone());
				form.setFax(rwsMaster.getFax());
				form.setEmail(rwsMaster.getEmail());
				form.setBuilding(rwsMaster.getBuilding());
				form.setHof(rwsMaster.getHof());
				form.setProject(rwsMaster.getProject());
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		ArrayList offices=new ArrayList();
		ArrayList heads=null;		
		ArrayList desgns=new ArrayList();
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		rwsOffices = new RwsOffices(getDataSource(request));		
		OfficeForm frm=(OfficeForm) form;
		String mode=frm.getMode();		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				desgns = RwsMasterData.getDesgns(getDataSource(request));
				session.setAttribute("desgns",desgns);
			}
			catch(Exception e)
			{
				//System.out.println("The heads in Office list"+e);
			}
			try
			{
				if(request.getParameter("hoc")!=null)	{
						circlecodes=rwsOffices.getCircles("1");
				}
				session.setAttribute("circlecodes",circlecodes);
			}
			catch(Exception e)
			{
				//System.out.println("The divcodes in Office list"+e);
			}
			try
			{	
				if((request.getParameter("hoc")!=null) && (request.getParameter("coc")!=null))	{
					divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
				}
				session.setAttribute("divcodes",divcodes);
			}
			catch(Exception e)
			{
				//System.out.println("The divcodes in Office list"+e);
			}
			try
			{	
				if((request.getParameter("hoc")!=null) && (request.getParameter("coc")!=null) && (request.getParameter("doc")!=null))	{
					subdivcodes = rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
				}
				session.setAttribute("subdivcodes",subdivcodes);
			}
			catch(Exception e)
			{
				//System.out.println("The subdivcodes in Office list"+e);
			}
		}

		if(mode.equalsIgnoreCase("View"))
		{
			try
			{
				offices = RwsMasterData.getOffices(frm.getHoc(),frm.getCoc());
				session.setAttribute("offices",offices);
			}
			catch(Exception e)
			{
				System.out.println("The heads in Office list"+e);
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
						RwsMaster rwsMaster = new RwsMaster();						
						rwsMaster.setRoc(frm.getRoc());
						rwsMaster.setAddress(frm.getAddress());
						rwsMaster.setArea(frm.getArea());
						rwsMaster.setLocation(frm.getLocation());
						rwsMaster.setCity(frm.getCity());
						rwsMaster.setPin(frm.getPin());
						rwsMaster.setPhone(frm.getPhone());
						rwsMaster.setFax(frm.getFax());
						rwsMaster.setEmail(frm.getEmail());
						rwsMaster.setBuilding(frm.getBuilding());
						rwsMaster.setHof(frm.getHof());
						rwsMaster.setProject(frm.getProject());						
						ans=RwsMasterData.insertOffice(rwsMaster,getDataSource(request));						
						frm.reset(mapping,request);
			     }
			}
			catch(Exception e)
			{
				//System.out.println("the error in Office Insert is "+e);
			}
			if(ans <1)
			{
				if(RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() >0)
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
				form = buildOfficeForm(request.getParameter("roc"),request);
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
				//System.out.println("the error in Office get is "+e);
			}
		}

		//		updated by swapna on 14-07-2011 
		if(mode.equalsIgnoreCase("edit"))
		{
			//System.out.println("in edit mode");
			try
			{
				int value =0;
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
						RwsMaster rwsMaster = new RwsMaster();
							
						rwsMaster.setRoc(frm.getRoc());
						rwsMaster.setAddress(frm.getAddress());
						rwsMaster.setArea(frm.getArea());
						rwsMaster.setLocation(frm.getLocation());
						rwsMaster.setCity(frm.getCity());
						rwsMaster.setPin(frm.getPin());
						rwsMaster.setPhone(frm.getPhone());
						rwsMaster.setFax(frm.getFax());
						rwsMaster.setEmail(frm.getEmail());
						rwsMaster.setBuilding(frm.getBuilding());
						rwsMaster.setHof(frm.getHof());
						rwsMaster.setProject(frm.getProject());
						
						value = RwsMasterData.updateOffice(rwsMaster,getDataSource(request));
			     }
				//Debug.println("count:"+value);
				//System.out.println("mode:in edit:"+mode);
				if(value>0)
				{
					request.setAttribute("message","Updated Successfully");
					mode = "close";
				}
				else
				{
					request.setAttribute("message","Updation Failed");
					mode = "get";
				}
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Office edit is "+e);
			}
		}
//updated by swapna on 14-07-2011 for message display
		if(mode.equalsIgnoreCase("delete"))
		{
			int del=0;
			try 
			{	
				int value = RwsMasterData.removeOffice(request.getParameter("roc"),getDataSource(request));	
				if(value>0)
				{
					request.setAttribute("message","Deleted Successfully");
					mode = "data";
				}
				else
				{
					request.setAttribute("message","Deletion Failed");
					mode = "data";
				}
				//request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				//System.out.println("the error in Office delete is "+e);
			}
		}
			return(mapping.findForward(mode));
	}

}
