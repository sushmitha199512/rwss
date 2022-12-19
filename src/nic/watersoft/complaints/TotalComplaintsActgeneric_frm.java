

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


public class TotalComplaintsActgeneric_frm extends Action
{

    public TotalComplaintsActgeneric_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = "get2";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        int compCount = 0;
        String assetreport="";
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        ArrayList assets = new ArrayList();
        Collection districtcomplaints = new ArrayList();
        Collection mandalcomplaints = new ArrayList();
        Collection panchayatcomplaints = new ArrayList();
        ArrayList villages = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList todates = new ArrayList();
        ArrayList habitationdisplay = new ArrayList();
        ArrayList complaintp = new ArrayList();
        ArrayList comp = new ArrayList();
        String source = null;
        Collection complaints = new ArrayList();
        String distName = "";
        String mandName = "";
        String panchName = "";
        String typeName = "";
        String dist = "";
        String man = "";
        String pan = "";
        String a="";
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
                if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
                    resetasset(frm);
                frm.setDistrictCode("");
                frm.setDistrictName("");
                complaintMasterData = new ComplaintMasterData();
                districts = complaintMasterData.getCompDistrictsgeneric(getDataSource(request));
                session.setAttribute("districts", districts);
                if(frm.getDist() != null && !frm.getDist().equals(""))
                {
                    mandals = complaintMasterData.getCompMandalsgenerics(frm.getDist(), getDataSource(request));
                    session.setAttribute("mandals", mandals);
                } else
                {
                    session.setAttribute("mandals", new ArrayList());
                }
                if(frm.getMand() != null && !frm.getMand().equals(""))
                {
                    panchayats = complaintMasterData.getCompPanchayatsgenerics(frm.getDist(), frm.getMand(), getDataSource(request));
                    session.setAttribute("panchayats", panchayats);
                } else
                {
                    session.setAttribute("panchayats", new ArrayList());
                }
                
                
                fromdates = ComplaintMasterData.getFromDatesdistreportgeneric(frm.getDist(),frm.getMand(),frm.getPanch(),getDataSource(request));
                session.setAttribute("fromdates", fromdates);
                String s = frm.getFromDate();
                
                
           
            if(frm.getFromDate() != null)
            {  Debug.println("frm:::"+a);
                todates = ComplaintMasterData.getToDatesdistreportgeneric(frm.getDist(), frm.getMand(),frm.getPanch(),getDataSource(request));
                session.setAttribute("todates", todates);
                    
				}
            
              
                
                }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
            page_to_be_displayed = "get2";
        }
        Debug.println("mode" + mode);
        
        
        if(mode != null && mode.equalsIgnoreCase("view"))
            try
            {
                distName = ComplaintMasterData.getDistrictname(frm.getDist(), getDataSource(request));
                mandName = ComplaintMasterData.getMandalname(frm.getDist(), frm.getMand(), getDataSource(request));
                panchName = ComplaintMasterData.getPanchayatname(frm.getDist(), frm.getMand(), frm.getPanch(), getDataSource(request));
                //typeName = ComplaintMasterData.getTypename(frm.getAsset(), getDataSource(request));
                request.setAttribute("mandName", mandName);
                request.setAttribute("distName", distName);
                request.setAttribute("panchName", panchName);
                //request.setAttribute("typeName", typeName);
                complaints = ComplaintMasterData.getComplaintsAllgeneric(frm.getDist(), frm.getMand(), frm.getPanch(),frm.getFromDate(),frm.getToDate(), getDataSource(request));
                Debug.println("complaints in each district" + complaints);
                frm.setComplaints(complaints);
                request.setAttribute("complaints", complaints);
                page_to_be_displayed = "view";
            }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
           return mapping.findForward(page_to_be_displayed);
    }

    public void resetasset(CompForm frm)
    {
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        
    }
}
