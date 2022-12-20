

package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import org.apache.struts.action.*;


public class rws_totalcomplaintsAct_frm extends Action
{

    public rws_totalcomplaintsAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = "get2";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        
        String message = null;
        ArrayList districts = new ArrayList();
        
        
        
        
        
        
        ArrayList fromdates = new ArrayList();
        ArrayList todates = new ArrayList();
        
        
        
        
        
        String dist = "";
        
        CompForm frm = (CompForm)form;
        int i = 0;
        String dmessage = "";
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(mode != null && mode.equalsIgnoreCase("get2"))
        {
            try
            {
                //if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
                  //  resetasset(frm);
            	 complaintMasterData = new ComplaintMasterData();
                 districts = complaintMasterData.getCompDistricts(getDataSource(request));
                 System.out.println("1");
                 session.setAttribute("districts", districts);
               
            	page_to_be_displayed = "get2";      
                
                }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
            
        }
        //
        if(mode != null && mode.equalsIgnoreCase("data"))
        {
        	
        try
		{
        System.out.println("1");
        complaintMasterData = new ComplaintMasterData();
       // String dis=request.getParameter("dist");  
       // System.out.println("2");
        
        //System.out.println("dis"+dis);
        districts = complaintMasterData.getCompDistricts(getDataSource(request));
        System.out.println("ghghgfhg1");
        session.setAttribute("districts", districts);
        fromdates = ComplaintMasterData.getFromDatesdistreporttot(frm.getDist(),getDataSource(request));
        session.setAttribute("fromdates", fromdates);
        String s = frm.getFromDate();
        
        
   
    if(frm.getFromDate() != null)
    {  
        todates = ComplaintMasterData.getToDatesdistreporttot(frm.getDist(),  getDataSource(request));
        session.setAttribute("todates", todates);
            
		}
    page_to_be_displayed="data";
		}
        catch(Exception p)
		{
        	p.printStackTrace();
		}
        
;        }
        //
        
        if(mode != null && mode.equalsIgnoreCase("view"))
        {
        	try
			{
        		page_to_be_displayed="view";
			}
        	catch(Exception o)
			{
        		o.printStackTrace();
			}
			}
        	
        
          
        return mapping.findForward(page_to_be_displayed);
    }

    public void resetasset(CompForm frm)
    {
        frm.setDist("");
            }
}
