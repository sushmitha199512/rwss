package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WaterQualityLabMasterEntryAct_frm extends Action
{
	ArrayList heads=new ArrayList();
	ArrayList circlecodes=new ArrayList();
	ArrayList divcodes=new ArrayList();
	ArrayList subdivcodes=new ArrayList();
	ArrayList mandalcodes=new ArrayList();
	ArrayList subDivisions=new ArrayList();
	
	protected ActionForm buildWQLabForm(String labCode,HttpServletRequest request) throws Exception 
	{
		WQLabForm form = new WQLabForm();
		HttpSession session=request.getSession();
		
		
		
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RwsMaster rwsMaster=RwsMasterData.getWQLab(labCode,getDataSource(request),session);
		
			if(rwsMaster!=null)
			{
				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				form.setHoc(rwsMaster.getHoc());
				if(rwsMaster.getHoc() != null)
				{
					circlecodes=rwsOffices.getCircles(rwsMaster.getHoc());
				}
				session.setAttribute("circlecodes",circlecodes);
				form.setCoc(rwsMaster.getCoc());
				
				if(rwsMaster.getCoc() != null)
				{
					divcodes = rwsOffices.getDivisions(rwsMaster.getHoc(),rwsMaster.getCoc());
				}
				session.setAttribute("divcodes",divcodes);
				if(rwsMaster.getCoc() != null)
				{
					mandalcodes = rwsOffices.getDistrictMandals(rwsMaster.getCoc());
				}
				
				if(rwsMaster.getCoc() != null)
				{
					if(!(rwsMaster.getCoc()).equalsIgnoreCase("00"))
					{
						subDivisions=rwsOffices.getSubdivisions(rwsMaster.getHoc(),rwsMaster.getCoc(),rwsMaster.getDoc());
					}
				}
				session.setAttribute("subdivisions",subDivisions);
				session.setAttribute("mandalcodes",mandalcodes);
				
				
				form.setDoc(rwsMaster.getDoc());
				form.setMancode(rwsMaster.getMancode());
				form.setLabCode(rwsMaster.getLabCode());
				form.setLabName(rwsMaster.getLabName());
				form.setLocation(rwsMaster.getLocation());
				form.setDesgnCode(rwsMaster.getDesgnCode());
				form.setlabEstablishedYear(rwsMaster.getlabEstablishedYear());
				form.setcontactNum(rwsMaster.getcontactNum());
				form.setlevelCode(rwsMaster.getlevelCode());
				form.setSubdivcode(rwsMaster.getSubdivision());
				form.setStatus(rwsMaster.getDivStatus());
				
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList wqlabs=null;
		ArrayList desgns=null;
		WQLabForm frm=(WQLabForm) form;
		HttpSession session=request.getSession();
		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");
		}
		
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		String mode=frm.getMode();

		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				System.out.println("lab code");
				desgns = RwsMasterData.getDesgns(getDataSource(request));
				session.setAttribute("desgns",desgns);

				heads = rwsOffices.getHeads();
				session.setAttribute("heads",heads);
				if(request.getParameter("hoc")!=null)
				{
					if(!(request.getParameter("hoc")).equalsIgnoreCase("0"))
					{
						circlecodes=rwsOffices.getCircles(request.getParameter("hoc"));
					}
				}
				session.setAttribute("circlecodes",circlecodes);
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
					{
						divcodes = rwsOffices.getDivisions(request.getParameter("hoc"),request.getParameter("coc"));
					}
				}
				
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
					{
						subDivisions=rwsOffices.getSubdivisions(request.getParameter("hoc"),request.getParameter("coc"),request.getParameter("doc"));
					}
				}
				
				session.setAttribute("divcodes",divcodes);
				if(request.getParameter("coc")!=null)
				{
					if(!(request.getParameter("coc")).equalsIgnoreCase("00"))
					{
						mandalcodes = rwsOffices.getDistrictMandals(request.getParameter("coc"));
					}
				}
				session.setAttribute("mandalcodes",mandalcodes);
				session.setAttribute("subdivisions",subDivisions);
				request.setAttribute("code",RwsMasterData.getLabCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				System.out.println("exception in data lab master -- "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				wqlabs=RwsMasterData.getWQLabs(getDataSource(request));
				session.setAttribute("wqlabs",wqlabs);
			}
			catch(Exception e)
			{
				System.out.println("exception in view lab master -- "+e);
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
				
				rwsMaster.setHoc(frm.getHoc());
				rwsMaster.setCoc(frm.getCoc());
				rwsMaster.setDoc(frm.getDoc());
				rwsMaster.setSubdivision(frm.getSubdivcode());
				rwsMaster.setSdoc("00");
				rwsMaster.setDesgnCode(frm.getDesgnCode());
				rwsMaster.setLabCode(frm.getLabCode());
				rwsMaster.setLabName(frm.getLabName().toUpperCase());
				rwsMaster.setLocation(frm.getLocation().toUpperCase());
				rwsMaster.setlabEstablishedYear(frm.getlabEstablishedYear());
				rwsMaster.setcontactNum(frm.getcontactNum());
				rwsMaster.setlevelCode(frm.getlevelCode());
				rwsMaster.setMancode(frm.getMancode());
				rwsMaster.setDivStatus(frm.getStatus());
				ans=RwsMasterData.insertWQLab(rwsMaster,getDataSource(request));
				request.setAttribute("code",RwsMasterData.getLabCode(getDataSource(request)));
				frm.reset(mapping,request);
								
			}
			
			catch(Exception e)
			{
				System.out.println("exception in save lab master -- "+e);
			}
			if(ans <1)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		}
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{   //System.out.println("scope="+mapping.getScope()+"attribute="+mapping.getAttribute());
				form = buildWQLabForm(request.getParameter("labCode"),request);
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
				System.out.println("exception in get lab master -- "+e);
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
				
				rwsMaster.setHoc(request.getParameter("hoc"));
				rwsMaster.setCoc(request.getParameter("coc"));
				rwsMaster.setDoc(request.getParameter("doc"));
				rwsMaster.setSdoc("00");
				rwsMaster.setDesgnCode(frm.getDesgnCode());
				rwsMaster.setLabCode(frm.getLabCode().toString());
				rwsMaster.setLabName(frm.getLabName());
				rwsMaster.setLocation(frm.getLocation());
				rwsMaster.setlabEstablishedYear(frm.getlabEstablishedYear());
				rwsMaster.setcontactNum(frm.getcontactNum());
				rwsMaster.setlevelCode(frm.getlevelCode());
				rwsMaster.setMancode(frm.getMancode());
				rwsMaster.setSubdivision(frm.getSubdivcode());
				rwsMaster.setDivStatus(frm.getStatus());
				RwsMasterData.updateWQLab(rwsMaster,getDataSource(request),session,request);
			}
			catch (Exception e) 
			{
				System.out.println("exception in edit lab master -- "+e);
			}
			
		}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				int del=RwsMasterData.removeWQLab(request.getParameter("labCode"),getDataSource(request));
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
				System.out.println("exception in delete lab master -- "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
