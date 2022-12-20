// Decompiled by DJ v3.11.11.95 Copyright 2009 Atanas Neshkov  Date: 15/02/2011 11:27:36
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   TotalComplaintRAct_frm.java

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

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class TotalComplaintRAct_frm extends Action
{

    public TotalComplaintRAct_frm()
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
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        Collection districtcomplaints = new ArrayList();
        Collection mandalcomplaints = new ArrayList();
        Collection panchayatcomplaints = new ArrayList();
        ArrayList villages = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList districtcomplaint = new ArrayList();
        ArrayList todates = new ArrayList();
        ArrayList habitationdisplay = new ArrayList();
        ArrayList complaintp = new ArrayList();
        Collection complaints = new ArrayList();
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
                String distname = ComplaintMasterData.getDistrictname(frm.getDist(), getDataSource(request));
                String mandname = ComplaintMasterData.getMandalname(frm.getDist(), frm.getMand(), getDataSource(request));
                session.setAttribute("mandname", mandname);
                session.setAttribute("distname", distname);
                complaints = ComplaintMasterData.getComplaintstotalAll(frm.getDist(), frm.getMand(), frm.getPanch(), getDataSource(request));
                Debug.println("complaints in each district" + complaints);
                String asst = frm.getAsset();
                request.setAttribute("asst", asst);
                String dist = frm.getDist();
                String man = frm.getMand();
                String pan = frm.getPanch();
                session.setAttribute("dist", dist);
                session.setAttribute("man", man);
                session.setAttribute("pan", pan);
                int s = complaints.size();
                Debug.println("The Size" + s);
                if(complaints.size() == 0)
                {
                    request.setAttribute("message", "No Records");
                    page_to_be_displayed = "get2";
                }
                frm.setComplaints(complaints);
                session.setAttribute("complaints", complaints);
                page_to_be_displayed = "view";
            }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
        if(mode.equals("hdisplay"))
        {
            try
            {
                complaintMasterData = new ComplaintMasterData();
                String dist1 = request.getParameter("dis");
                String man1 = request.getParameter("man");
                String pan1 = request.getParameter("pan");
                String asst = request.getParameter("type");
                String assetcode = request.getParameter("assetcode");
                String source = request.getParameter("source");
                request.setAttribute("asst", asst);
                String sourcecode = request.getParameter("complntno");
                if(asst.equals("01") || asst.equals("02") || asst.equals("03") || asst.equals("09"))
                {
                    Debug.println("indisde if");
                    complaints = ComplaintMasterData.getPwsdetails(sourcecode, asst, dist1, man1, pan1, assetcode, getDataSource(request));
                } else
                if(asst.equals("04"))
                    complaints = ComplaintMasterData.getHpdetails(source, asst, assetcode, getDataSource(request));
                Debug.println("outside if");
                session.setAttribute("complaints", complaints);
                frm.setComplaints(complaints);
            }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
            page_to_be_displayed = "hdisplay";
        }
        return mapping.findForward(page_to_be_displayed);
    }

    public void resetasset(CompForm frm)
    {
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        frm.setAsset("");
    }
}
