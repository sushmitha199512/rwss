package nic.watersoft.drought;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

import nic.watersoft.commons.Debug.*;
import nic.watersoft.complaints.CompForm;
import nic.watersoft.complaints.ComplaintMasterData;
public class Drought_DailyAbstract_Action extends Action
{
    public Drought_DailyAbstract_Action()
    {
    }
 

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = " ";
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
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
        
       // 
        Rws_Drought_Daily_Abstract_Frm droughtForm = new Rws_Drought_Daily_Abstract_Frm();
               
        Rws_Drought_Daily_Abstract_Frm frm = (Rws_Drought_Daily_Abstract_Frm)form;
        int i = 0;
        
         java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
	   	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	   	 String transdate=null;
	   	 transdate=dateFormat.format(systemdate);
        
        
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();
        
    	RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		// Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) ||  user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			// System.out.println("USER IN ACTION"+user.getUserId());
			return mapping.findForward("unAuthorise");
		}
		
		String loggedUser= user.getUserId();
		
	
    	
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(mode != null && mode.equalsIgnoreCase("data"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {  
            	//Debug.println("i am refreshing............");
            	reset(frm);
            }
            try
            {
            	//rwsLocations=new RwsLocations(getDataSource(request));
            	frm.setAbsDate(transdate);
            	DroughtMasterData droughtMasterData=new DroughtMasterData();
            	districts=droughtMasterData.getDistricts(getDataSource(request));
            	session.setAttribute("districts",districts);
            	
            		ArrayList habs=new ArrayList();
            		habs.add(new DroughtBean());
            		session.setAttribute("hps",habs);
            	               		
        		
            }
            
            catch(Exception e)
            {
                System.out.println("the error in Drought ddaily data is " + e);
              //  e.printStackTrace();
            }
            page_to_be_displayed = "data";
        }
        if(mode != null && mode.equalsIgnoreCase("view"))
        {
   //     	System.out.println("mode in view");
            
            try
			{
            	DroughtMasterData droughtMasterData=new DroughtMasterData();
            	DroughtBean droughtBean = new DroughtBean();
            	hps=droughtMasterData.getDroughtDailyAbstractDetails(frm.getDist(),frm.getAbsDate(),getDataSource(request));
            	frm.setAbs(hps);
            	int p=hps.size();
              	session.setAttribute("hps",hps);
              	if(p==0)
              	{
              		ArrayList habs=new ArrayList();
            		habs.add(new DroughtBean());
            		session.setAttribute("hps",habs);
              	}
            	
            	
			}
                        
            catch(Exception e)
            {
                System.out.println("the error in Drought  is " + e);
            }
            page_to_be_displayed = "view";
        }
        
        if (mode != null && mode.equalsIgnoreCase("save")) {
			
			ArrayList resultData = new ArrayList();
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				
			try {

				String dd = request.getParameter("dist");
				String finyear= request.getParameter("finyear");//date	
				String h1 = request.getParameter("hab1");
			
				String[] records = h1.split(",");
                
				
				hps=(ArrayList)session.getAttribute("hps");
				

				int k=0;
				for (i = 0; i < records.length-1; i++) {
					//System.out.println("I am loop");

					DroughtBean droughtBean = (DroughtBean)hps.get(k);
					
					   
						droughtBean.setTrhabs(records[i]);
					
						i++;
						droughtBean.setTrpopserv(records[i]);
					
						i++;
						
					   droughtBean.setTrnooftrips(records[i]);
					
					   i++;
						droughtBean.setTrqty(records[i]);
					
						i++;
						
						 droughtBean.setCathabs(records[i]);
						
						    i++;
						    
						    droughtBean.setCatpopserv(records[i]);
						
						    i++;
						    
						   
						    droughtBean.setCatnooftrips(records[i]);
						    i++;
						    droughtBean.setCatqty(records[i]);
						    i++;
						droughtBean.setHshabs(records[i]);
					    i++; 
					    droughtBean.setHssour(records[i]); 
					    i++; 
					    droughtBean.setHspopserv(records[i]);
					    i++; 
					    droughtBean.setPowhabs(records[i]); 
					    i++; 
						resultData.add(droughtBean);
					k++;

				}

				   DroughtMasterData droughtMasterData = new DroughtMasterData();
				   Rws_Drought_Daily_Abstract_Frm drfrm=new Rws_Drought_Daily_Abstract_Frm();
				   drfrm.setAbsDate(frm.getAbsDate());		
				
				//int[] count = droughtMasterData.saveHabitations(h3,d1,m1);
				String msg = droughtMasterData.saveDroughtDailyAbstractEntry(resultData,dd,frm.getAbsDate(),loggedUser);
				//Debug.println("count"+count);
				request.setAttribute("message",msg);					
				//hps=droughtMasterData.getDroughtSSTanks(frm.getHabCode(),getDataSource(request));
				hps=droughtMasterData.getDroughtDailyAbstractDetails(frm.getDist(),frm.getAbsDate(),getDataSource(request));
            	frm.setAbs(hps);
				

			} catch (Exception z) {
				System.out.println("exception in drought dailyabstarct save mode --"+z);
			}

		//	Debug.println("1" + page_to_be_displayed);
			page_to_be_displayed = "save";
			}
		} 
        //
      return mapping.findForward(page_to_be_displayed);
}

    public void reset(Rws_Drought_Daily_Abstract_Frm frm)
    {
        frm.setDist("");
        frm.setHshabs("");
        frm.setHshabs("");
        frm.setHssour("");
        frm.setPowhabs("");
        frm.setTrhabs("");
        frm.setTrpopserv("");
        frm.setTrqty("");
       
    }
}

