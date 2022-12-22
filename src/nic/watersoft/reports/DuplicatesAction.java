/*
 * Created on Sep 18, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;

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
public class DuplicatesAction extends Action
{

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
	{
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		ReportsForm reportsForm=new ReportsForm();
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));
		String mode=request.getParameter("mode");
		//String mode=reportsForm.getMode();
		HttpSession session=request.getSession();
		
		//Debug.println("Mode in Duplicates Action "+mode);
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		
		String district=(String)request.getParameter("district");
		String mandal=(String)request.getParameter("mandal");
		String panchayat=(String)request.getParameter("panchayat");
		String village=(String)request.getParameter("village");
		String habitation=(String)request.getParameter("habitation");
		
		if(mode.equalsIgnoreCase("data"))
		{
		 try
		 {
			districts=rwsOffices.getDistricts();
			session.setAttribute("districts",districts);
						
			mandals=rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals",mandals);
			
			panchayats=rwsOffices.getPanchayats(district,mandal);
			session.setAttribute("panchayats",panchayats);
			
			villages=rwsOffices.getVillages(district,mandal,panchayat);
			session.setAttribute("villages",villages);
			
			habitations=rwsLocations.getHabitations1(district,mandal,panchayat,village);
			session.setAttribute("habitations",habitations);
		
			}catch(Exception e)
			{
				Debug.println("Exception in mode data "+e);
			}
			
		}	

		if(mode.equalsIgnoreCase("duplicates"))
		{
			try{
			
				request.setAttribute("data","true");
				
				ArrayList results=new ArrayList();
				//results=ReportsMasterData.getDuplicatesData(getDataSource(request),district,mandal,panchayat,village);
				}catch(Exception e)
				{
					Debug.println("Exception e"+e);
				}
			
		}
	return (mapping.findForward(mode));
	}
}
