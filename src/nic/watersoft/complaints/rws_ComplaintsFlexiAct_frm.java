// Decompiled by DJ v3.11.11.95 Copyright 2009 Atanas Neshkov  Date: 15/02/2011 11:26:19
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   rws_ComplaintsFlexiAct_frm.java

package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class rws_ComplaintsFlexiAct_frm extends Action
{

    public rws_ComplaintsFlexiAct_frm()
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
        ArrayList mandals = new ArrayList();
        ArrayList collection1 = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList villages = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList habitations = new ArrayList();
        ArrayList todates = new ArrayList();
        ArrayList columns = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        CompForm frm = (CompForm)form;
        String mode = request.getParameter("mode");
        System.out.println("mode:" + mode);
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        String message1 = "";
        if(mode.equalsIgnoreCase("get2"))
            try
            {
                districts = rwsLocations.getDistricts();
                session.setAttribute("districts", districts);
                if(request.getParameter("dist") != null && !request.getParameter("dist").equalsIgnoreCase(""))
                    mandals = rwsLocations.getMandals(frm.getDist());
                session.setAttribute("mandals", mandals);
                if(request.getParameter("mand") != null && !request.getParameter("mand").equalsIgnoreCase(""))
                    panchayats = rwsLocations.getPanchayats(frm.getDist(), frm.getMand());
                session.setAttribute("panchayats", panchayats);
                if(request.getParameter("panch") != null && !request.getParameter("panch").equalsIgnoreCase(""))
                    villages = rwsLocations.getVillages(frm.getDist(), frm.getMand(), frm.getPanch());
                session.setAttribute("villages", villages);
                if(request.getParameter("village") != null && !request.getParameter("village").equalsIgnoreCase(""))
                    habitations = rwsLocations.getPanchayatHabitations(frm.getDist(), frm.getMand(), frm.getPanch());
                session.setAttribute("habitations", habitations);
                Debug.println("DIST   " + (frm.getDist() != "") + "compdate" + frm.getComplntdt());
                if(!frm.getDist().equals("-1"))
                    fromdates = nic.watersoft.complaints.ComplaintMasterData.getFromDates1(frm.getDist(), getDataSource(request));
                session.setAttribute("fromdates", fromdates);
                if(!frm.getComplntdt().equals("-1"))
                    todates = nic.watersoft.complaints.ComplaintMasterData.getToDates1(frm.getDist(), frm.getComplntdt(), getDataSource(request));
                session.setAttribute("todates", todates);
                page_to_be_displayed = "get2";
            }
            catch(Exception e)
            {
                System.out.println("the error in Emp get2 is " + e);
            }
        if(mode.equalsIgnoreCase("view"))
        {
            try
            {
                CompForm frm1 = (CompForm)form;
                ComplaintMasterData sch1 = new ComplaintMasterData();
                columns = new ArrayList();
                String fields1[] = frm1.getFields();
                Debug.println("fields" + fields1);
                int s = fields1.length;
                Debug.println("s" + s);
                for(int i = 0; i < fields1.length; i++)
                {
                    columns.add(fields1[i]);
                    System.out.println(columns.get(i));
                    columns.get(i);
                }

                collection1 = sch1.getComplaintViewDetails1(frm1, columns, getDataSource(request), request);
                if(collection1.size() == 0)
                {
                    message1 = "No Records";
                    page_to_be_displayed = "get2";
                } else
                {
                    request.setAttribute("collection1", collection1);
                    page_to_be_displayed = "view";
                }
                request.setAttribute("message1", message1);
                request.getAttribute("message");
            }
            catch(Exception e)
            {
                System.out.println("Exception in checkbox" + e);
            }
            frm.reset3(mapping, request);
        }
        return mapping.findForward(page_to_be_displayed);
    }
}
