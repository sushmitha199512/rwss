



package nic.watersoft.reports;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;






/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DistrictHabitationSearchAction extends Action {
	
	    
			public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{        
				
			String page_to_be_displayed="get2";	
			StateData StateData = new StateData();
			ArrayList mandaldisplay=new ArrayList();
			ArrayList panchayatdisplay=new ArrayList();
			ArrayList villagedisplay=new ArrayList();
			ArrayList habitationdisplay=new ArrayList();
			
			
			StateForm frm=(StateForm)form;
			
			String mode=request.getParameter("mode");
			HttpSession session=request.getSession();
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			//if(mode.equalsIgnoreCase("get2"))
			 //{
			if(mode!=null && mode.equalsIgnoreCase("get2"))
	 		{
	 			try{
	 				
	 				String mcode=frm.getMandalName();
	 				Debug.println("mcode"+mcode);
	 				
	 				
	 				
	 				
	 				
	 				
	 				
	 			   }
	 			catch(Exception e)
				{
	 				System.out.println("Exception"+e);
				}
	 			page_to_be_displayed="get2";
	 		}
	 		
		 	
			
		 			if(mode!=null && mode.equalsIgnoreCase("search"))
		 		{
		 			try{
		 				
		 				String districtradio=request.getParameter("districtradio");
		 				Debug.println("districtradio"+districtradio);
		 				String mcode=frm.getMandalName();
		 				Debug.println("mcode"+mcode);
		 				
		 				
		 				if(districtradio.equals("1"))
		 				{
		 					Debug.println("districtradioloop"+districtradio);
		 				
		 				mandaldisplay=StateData.getMandalSearch(mcode,getDataSource(request));
		 				System.out.println("MandalDisplay"+mandaldisplay);
		 				if(mandaldisplay.size() == 0)
						{
		 					request.setAttribute("message","No Records");
							}
		 				else
		 				{
		 				session.setAttribute("mandaldisplay",mandaldisplay);
		 				page_to_be_displayed="search";
		 				}
		 				
		 				}
		 				else if(districtradio.equals("2"))
		 				{
		 					Debug.println("districtradioloop2"+districtradio);
		 					panchayatdisplay=StateData.getPanchayatSearch(mcode,getDataSource(request));
		 					System.out.println("PanchayatDisplay"+panchayatdisplay);
			 				if(panchayatdisplay.size() == 0)
							{
			 					request.setAttribute("message","No Records");
								}
			 				else
			 				{
			 				session.setAttribute("panchayatdisplay",panchayatdisplay);
			 				page_to_be_displayed="searchpanchayat";
			 				}
			 				
		 				}
		 				else if(districtradio.equals("3"))
		 				{
		 					Debug.println("districtradioloop2"+districtradio);
		 					villagedisplay=StateData.getVillageSearch(mcode,getDataSource(request));
		 					System.out.println("VillageDisplay"+villagedisplay);
			 				if(villagedisplay.size() == 0)
							{
			 					request.setAttribute("message","No Records");
								}
			 				else
			 				{
			 				request.setAttribute("message","Records are being Displayed");
			 				session.setAttribute("villagedisplay",villagedisplay);
			 				page_to_be_displayed="searchvillage";
			 				}
		 				}
		 				else if(districtradio.equals("4"))
		 				{
		 					Debug.println("districtradioloop2"+districtradio);
		 					habitationdisplay=StateData.getHabitationSearch(mcode,getDataSource(request));
			 				Debug.println("HabitationDisplay"+habitationdisplay);
			 				System.out.println("HabitationDisplay"+habitationdisplay);
			 				if(habitationdisplay.size() == 0)
							{
			 					request.setAttribute("message","No Records");
								}
			 				else
			 				{
			 				
			 				session.setAttribute("habitationdisplay",habitationdisplay);
			 				page_to_be_displayed="searchhabitation";
			 				}
			 				
		 				}
		 			
		 				
		 			   }
		 			catch(Exception e)
					{
		 				System.out.println("Exception"+e);
					}
		 			
		 			
		 		}
		 		
			 		
			
		 	
			

		 	

					return mapping.findForward(page_to_be_displayed);
		}
	}



