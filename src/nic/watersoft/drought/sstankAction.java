package nic.watersoft.drought;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
public class sstankAction extends Action
{
    public sstankAction()
    {
    }
  
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = " ";
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        ArrayList dryears=new ArrayList();
        ArrayList assetsources=new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        
        
        int j=0;
        int deleteCount=0;
        String hab="";
        boolean exits=false;
        ans=0;
        String habcode="";
        String habname="";
        String dasset="";
        String assetu="";
        String assetdel="";
        
        
        
        
        ArrayList villages = new ArrayList();
        ArrayList hps=new ArrayList();
        
        
        DroughtForm droughtForm = new DroughtForm();
               
        DroughtForm frm = (DroughtForm)form;
        int i = 0;
        
        
        
        
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		// Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) ||  user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			// System.out.println("USER IN ACTION"+user.getUserId());
			return mapping.findForward("unAuthorise");
		}

        
        if(mode != null && mode.equalsIgnoreCase("data"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
              reset(frm);
            }
	            try
	            {
	            	//rwsLocations=new RwsLocations(getDataSource(request));
	            	
	            	DroughtMasterData droughtMasterData=new DroughtMasterData();
	            	districts=droughtMasterData.getSSTankDroughtDistricts(getDataSource(request));
	            	session.setAttribute("districts",districts);
	            	ArrayList weekdates=droughtMasterData.getWeekDates();
	            	session.setAttribute("weekdates",weekdates);
	            	if(frm.getDist().equals("") || frm.getDist()== null)
	            	{
	            		session.setAttribute("hps",new ArrayList());
	            	}
	            }
            	catch(Exception e)
	            {
	                System.out.println("the error in Drought data is " + e);
	          
	            }
	            page_to_be_displayed = "data";
            }
        
        if(mode != null && mode.equalsIgnoreCase("mandal"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
              reset(frm);
            }
	            try
	            {	
	            	DroughtMasterData droughtMasterData=new DroughtMasterData();
            	
	            	if(frm.getDist() !=null && !frm.getDist().equals(""))
	            	{
	            		mandals=droughtMasterData.getSSTankDroughtMandals(frm.getDist(),getDataSource(request));
	            		session.setAttribute("mandals",mandals);
	            		session.setAttribute("habitations",new ArrayList());
	                	session.setAttribute("hps",new ArrayList());
	
	            	}
	            	else
	            	{
	            		session.setAttribute("mandals",new ArrayList());
	            	}
	            }
            	catch(Exception e)
	            {
	                System.out.println("the error in Drought data is " + e);
	             
	            }
            	page_to_be_displayed = "data";
        }
        
        if(mode != null && mode.equalsIgnoreCase("panch"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
              reset(frm);
            }
	            try
	            {	
	            	DroughtMasterData droughtMasterData=new DroughtMasterData();
            		
	            	if(frm.getDist() != null && frm.getMand() != null && !frm.getMand().equals(""))
	            	{
	            		panchayats=droughtMasterData.getSSTankDroughtPanchayats(frm.getDist(),frm.getMand(),getDataSource(request));
	            		session.setAttribute("panchayats",panchayats);
	            	}
	            	else
	            	{
	            		session.setAttribute("panchayats", new ArrayList());
	            	}
	            }
            	catch(Exception e)
	            {
	                System.out.println("the error in Drought data is " + e);
	             
	            }
            	page_to_be_displayed = "data";
            }
        
	        if(mode != null && mode.equalsIgnoreCase("village"))
	        {
	            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
	            {
	              reset(frm);
	            }
		            try
		            {	
		            	DroughtMasterData droughtMasterData=new DroughtMasterData();
	            	
		            	if(frm.getDist() != null && frm.getMand() != null && frm.getPanch() != null && !frm.getPanch().equals(""))
		            	{
		            		villages=droughtMasterData.getSSTankDroughtVillages(frm.getDist(),frm.getMand(),frm.getPanch(),getDataSource(request));
		            		session.setAttribute("villages",villages);
		            	}
		            	else
		            	{
		            		session.setAttribute("villages", new ArrayList());
		            		
		            	}
		            }
	            	catch(Exception e)
		            {
		                System.out.println("the error in Drought data is " + e);
		            
		            }
	            	page_to_be_displayed = "data";
	            }
	        if(mode != null && mode.equalsIgnoreCase("habs"))
	        {
	            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
	            {
	              reset(frm);
	            }
		            try
		            {	
		            	DroughtMasterData droughtMasterData=new DroughtMasterData();
	            	
		            	if(frm.getDist() != null && frm.getMand() != null && frm.getPanch() != null && !frm.getVill().equals("") && frm.getVill() != null)
		            	{
		            		habitations=droughtMasterData.getSSTankDroughtHabitations(frm.getDist(),frm.getMand(),frm.getPanch(),frm.getVill(),getDataSource(request));
		            		int z=habitations.size();
		            	
		            		session.setAttribute("habitations",habitations);
		            	}
		            	else
		            	{
		            		session.setAttribute("habitations", new ArrayList());
		            	}
                   }
            
            catch(Exception e)
            {
                System.out.println("the error in Drought data is " + e);
            
            }
            page_to_be_displayed = "data";
        }
	        
	        
        if(mode != null && mode.equalsIgnoreCase("view"))
        {
            
            try
			{
            	if(frm.getHabCode() !=null)
            	{
            		
            	DroughtMasterData droughtMasterData=new DroughtMasterData();
            	DroughtBean droughtBean = new DroughtBean();
            	hps=droughtMasterData.getDroughtSSTanks(frm.getHabCode(),getDataSource(request));
            	frm.setHps(hps);
    
            	
            	session.setAttribute("hps",hps);
            	String y2=frm.getFinYear();
            	session.setAttribute("y2",y2);
            	
            	assetsources=droughtMasterData.getDroughtAssetSources(frm.getHabCode(),getDataSource(request));
        		session.setAttribute("assetsources",assetsources);
        	
        	
            	}

			}
                        
            catch(Exception e)
            {
                System.out.println("the error in Drought  is " + e);
            }
            page_to_be_displayed = "view";
        }

        
        
        if (mode != null && mode.equalsIgnoreCase("save")) {
        	
        	session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			ArrayList resultData = new ArrayList();
				try {
					DroughtMasterData droughtMasterData = new DroughtMasterData();
					DroughtForm drfrm = new DroughtForm();
					drfrm.setSdrDate(frm.getSdrDate());
					habcode = request.getParameter("habCode");
					String y2 = drfrm.getSdrDate();
					int count = droughtMasterData.saveDroughtSSTankHabitations(	resultData, habcode, drfrm.getSdrDate(), frm);
					Debug.println("count" + count);
					if (count == 1)
						request.setAttribute("message",	"Selected Drought SSTanks  Saved Successfully ");
					else if (count == 2)
						request.setAttribute("message",	"Selected Drought SSTanks Updated Successfully ");
					else
						request.setAttribute("message", "Failed to Save");
					hps = droughtMasterData.getDroughtSSTanks(frm.getHabCode(),	getDataSource(request));
					frm.setHps(hps);

				} catch (Exception z) {
			System.out.println("exception in sstankaction of save mode -- "+z);
			}
			page_to_be_displayed = "save";
		} 
        }
      return mapping.findForward(page_to_be_displayed);
}

    public void reset(DroughtForm frm)
    {
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        frm.setVill("");
        frm.setHabCode("");
           }
    
}

