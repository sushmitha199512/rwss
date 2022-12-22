/*
 * Created on Mar 17, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsLocations;

import nic.watersoft.commons.Debug;


import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author vikas
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_SchoolReport_Act extends Action 
{
	
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	ArrayList panchayats=new ArrayList();
	ArrayList villages=new ArrayList();
	ArrayList habitations=new ArrayList();

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
	{
		SchoolMasterData schoolMasterData=new SchoolMasterData();
		SchoolForm frm=(SchoolForm)form;
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		
		String mode=frm.getMode();
		//Debug.println("mode"+mode);
		HttpSession session=request.getSession();
		
		String dist=request.getParameter("district"); 
		String mand=request.getParameter("mandal");
		String panch=request.getParameter("panchayat");
		String vill=request.getParameter("village");
		String hab=request.getParameter("habitation");
		
		if(mode.equalsIgnoreCase("data"))
		{
			//Debug.println("inside data");
			try
			{
				
			districts=rwsOffices.getDistricts();
			session.setAttribute("districts",districts);
			
			if(dist!=null)
			{
				mandals=rwsOffices.getDistrictMandals(dist);
			}
			session.setAttribute("mandals",mandals);
			
			if(dist!=null && mand!=null)
			{		
				panchayats=rwsOffices.getPanchayats(dist,mand);
			}
			session.setAttribute("panchayats",panchayats);
		
			if(dist!=null && mand!=null && panch!=null)
			{		
				villages=rwsOffices.getVillages(dist,mand,panch);
			}
			session.setAttribute("villages",villages);
			
			if(dist!=null && mand!=null && panch!=null && vill!=null)
			{
				habitations=rwsLocations.getHabs(dist,mand,panch,vill);
			}
			session.setAttribute("habitations",habitations);
			
			}catch(Exception e)
			{
				Debug.println("Exception in data mode"+e.getMessage());
			}
			
		}
		
		if(mode.equalsIgnoreCase("view"))
		{
			Debug.println("ddddddddd");
			mode="viewDetails";
			ArrayList collection1=new ArrayList();
			try{
			SchoolForm frm1=(SchoolForm)form;
			SchoolMasterData sch1=new SchoolMasterData();
			//Debug.println("11111111111");
			collection1=sch1.getSchoolViewDetails(frm1,getDataSource(request),request);
			//Debug.println("222222222");
			session.setAttribute("collection1",collection1);
			session.getAttribute("message");
		
			}catch(Exception e)
			{
				Debug.println("Exception in view"+e.getMessage());
			}
		}
		
		//Debug.println("mode returned "+mode);
		return (mapping.findForward(mode));
	}
}
