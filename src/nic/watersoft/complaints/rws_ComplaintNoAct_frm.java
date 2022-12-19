
package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;


public class rws_ComplaintNoAct_frm extends Action
{

    public rws_ComplaintNoAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = "get2";
        ComplaintMasterData ComplaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        int compCount = 0;
        ArrayList mandals = new ArrayList();
        ArrayList comno = new ArrayList();
        String compnos = "";
        
        ArrayList panchayats = new ArrayList();
        
        
        
        
        Collection complaintsalist = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        CompForm frm = (CompForm)form;
        String dt = "";
        ArrayList cno = new ArrayList();
        String d1 = "";
        String complaintnumber = "";
        
        String dmessage = "";
        String mode = request.getParameter("mode");
        System.out.println("mode:" + mode);
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        int compno = 0;
        
        
         if(mode != null && mode.equalsIgnoreCase("get2"))
        	 {
        	 	try
				{
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
                resetasset(frm);
            page_to_be_displayed="get2";
            
        	 }
        
        catch(Exception e)
        {
            System.out.println("the error in  get2 is " + e);
        }
      }
        if(mode != null && mode.equalsIgnoreCase("cview"))
        {
            Debug.println("Mode" + mode);
            try
            {
                String complaintno = frm.getComplntno();
                Debug.println("complaintno" + complaintno);
                String com = nic.watersoft.complaints.ComplaintMasterData.getComplaintsNo1(frm.getComplntno(), getDataSource(request));
                complaintsalist = nic.watersoft.complaints.ComplaintMasterData.getComplaintsNo(frm.getComplntno(), getDataSource(request));
                Debug.println("Complaints" + complaintsalist);
                Debug.println("size" + complaintsalist.size());
                if(complaintsalist.size() > 0)
                {
                    request.setAttribute("complaintsalist", complaintsalist);
                    frm.setComplaintsalist(complaintsalist);
                    request.setAttribute("com", com);
                    page_to_be_displayed = "cview";
                    resetasset(frm);
                }
            }
            catch(Exception e)
            {
                System.out.println("The error is Asset Complaints CView" + e);
            }
        }
        if(mode != null && mode.equals("get3"))
        {
            
            try
            {
            	//
            	ComplaintMasterData complaintMasterData = new ComplaintMasterData(); 
            	 districts = complaintMasterData.getCompDistricts(getDataSource(request));
                 session.setAttribute("districts", districts);
                 Debug.println("districts" + districts.size());
                 if(frm.getDist() != null && !frm.getDist().equals(""))
                 {
                     mandals = complaintMasterData.getCompMandals(frm.getDist(), getDataSource(request));
                     session.setAttribute("mandals", mandals);
                 } else
                 {
                     session.setAttribute("mandals", new ArrayList());
                 }
                 session.setAttribute("mandals", mandals);
                 if(frm.getMand() != null && !frm.getMand().equals(""))
                 {
                     panchayats = complaintMasterData.getCompPanchayats(frm.getDist(), frm.getMand(), getDataSource(request));
                     session.setAttribute("panchayats", panchayats);
                 } else
                 {
                     session.setAttribute("panchayats", new ArrayList());
                 }
                 cno = ComplaintMasterData.getComplaintnodates(frm.getDist(), frm.getMand(), frm.getPanch(), getDataSource(request));
                 Debug.println("s*******"+cno.size());
                 frm.setCno(cno);

                 session.setAttribute("cno",cno);
                            	
            	 page_to_be_displayed = "get3";
               
            }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
           
        }
        if(mode != null && mode.equals("get4"))
        {
            try
            {
            	
                complaintnumber = request.getParameter("complntno");
                Debug.println("get4******" + complaintnumber);
                session.setAttribute("complaintnumber", complaintnumber);
            }
            catch(Exception o)
            {
                o.printStackTrace();
            }
            page_to_be_displayed = "get2";
        }
        return mapping.findForward(page_to_be_displayed);
    }

    public void resetasset(CompForm frm)
    {
        frm.setComplntno("");
    }
}
