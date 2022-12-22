// Decompiled by DJ v3.11.11.95 Copyright 2009 Atanas Neshkov  Date: 15/02/2011 11:28:47
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   rws_AttendedAct_frm.java

package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.*;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class rws_AttendedAct_frm extends Action
{

    public rws_AttendedAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = null;
        ComplaintMasterData ComplaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        ArrayList notattendedcomplaints = new ArrayList();
        int compCount = 0;
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        java.util.Collection reccomplaints = new ArrayList();
        java.util.Collection complaints = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        java.util.Collection districtcomplaints = new ArrayList();
        java.util.Collection mandalcomplaints = new ArrayList();
        java.util.Collection panchayatcomplaints = new ArrayList();
        ArrayList villages = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList todates = new ArrayList();
        ArrayList circles = new ArrayList();
        ArrayList habs = new ArrayList();
        HttpSession session = request.getSession();
        java.util.Collection complaintsnotattended = new ArrayList();
        java.util.Collection complaintsalist = new ArrayList();
        CompForm frm = (CompForm)form;
        javax.sql.DataSource dataSource = getDataSource(request);
        String mode = frm.getMode();
        page_to_be_displayed = mode;
        boolean init = frm.getInit();
        CompForm compForm = new CompForm();
        ComplaintMasterData = new ComplaintMasterData();
        String headOfficeCode = frm.getHeadOfficeCode();
        CommonLists commonLists = new CommonLists(dataSource);
        RwsOffices rwsOffices = new RwsOffices(dataSource);
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        String district1 = null;
        String circleOfficeCode = null;
        if(mode != null && mode.equals("compnotattended"))
        {
            try
            {
                ComplaintMasterData = new ComplaintMasterData();
                complaintsnotattended = nic.watersoft.complaints.ComplaintMasterData.getNotAttendedComplaints(frm.getHabCode(), getDataSource(request));
                request.setAttribute("complaintsnotattended", complaintsnotattended);
                frm.setComplaintsnotattended(complaintsnotattended);
                complaintsalist = nic.watersoft.complaints.ComplaintMasterData.getComplaintsattended(frm.getHabCode(), getDataSource(request));
                request.setAttribute("complaintsalist", complaintsalist);
                Debug.println("Complaintsattendedlist" + complaintsalist);
                frm.setComplaintsalist(complaintsalist);
            }
            catch(Exception e)
            {
                System.out.println("Exception jj" + e);
            }
            page_to_be_displayed = "compnotattended";
        }
        if(mode.equals("attend"))
        {
            try
            {
                String sourcecode = request.getParameter("sourceCode");
                String complaintno = request.getParameter("complntno");
                session.setAttribute("sourcecode", sourcecode);
                session.setAttribute("complaintno", complaintno);
                String categoryname = request.getParameter("categoryName");
                String complaintdate = request.getParameter("complntdt");
                session.setAttribute("categoryname", categoryname);
                session.setAttribute("complaintdate", complaintdate);
            }
            catch(Exception e)
            {
                System.out.println("Exception cc" + e);
            }
            page_to_be_displayed = "attend";
        }
        try
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
                resetstatus(frm);
            if(mode != null && mode.equalsIgnoreCase("get2"))
            {
                districts = rwsLocations.getDistricts();
                session.removeAttribute("districts");
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
                if(request.getParameter("vill") != null && !request.getParameter("vill").equalsIgnoreCase(""))
                    habitations = rwsLocations.getPanchayatHabitations(frm.getDist(), frm.getMand(), frm.getPanch());
                session.setAttribute("habitations", habitations);
                page_to_be_displayed = "get2";
            }
        }
        catch(Exception e)
        {
            System.out.println("the error in Complaint get2 is " + e);
        }
        if(mode.equals("save"))
        {
            try
            {
                ComplaintMasterData = new ComplaintMasterData();
                compForm = new CompForm();
                compForm.setComplntno(frm.getComplntno());
                compForm.setSourceCode(frm.getSourceCode());
                compForm.setAssetCode(frm.getAssetCode());
                compForm.setComplntdt(frm.getComplntdt());
                compForm.setComplntdesc(frm.getComplntdesc());
                compForm.setAttenby(frm.getAttenby());
                compForm.setAttendt(frm.getAttendt());
                compForm.setComplntstatus(frm.getComplntstatus());
                compForm.setRemarksby(frm.getRemarksby());
                String source = (String)session.getAttribute("sourcecode");
                String complaint = (String)session.getAttribute("complaintno");
                compCount = nic.watersoft.complaints.ComplaintMasterData.insertComplaintAttended(compForm, complaint, getDataSource(request));
                if(compCount == 1)
                    message = "Record Inserted Succesfully";
                else
                    message = "Record Cannot be inserted";
                request.setAttribute("message", message);
            }
            catch(Exception e)
            {
                System.out.println("Exception gg" + e);
            }
            frm.reset(mapping, request);
            return mapping.findForward("closeWithMessage");
        }
        if(mode.equals("view"))
        {
            try
            {
                ComplaintMasterData = new ComplaintMasterData();
                complaintsalist = nic.watersoft.complaints.ComplaintMasterData.getComplaintsattended(frm.getCircleOfficeCode(), getDataSource(request));
                request.setAttribute("complaintsalist", complaintsalist);
                Debug.println("Complaintsattendedlist" + complaintsalist);
                frm.setComplaintsalist(complaintsalist);
            }
            catch(Exception e)
            {
                System.out.println("Exception yy" + e);
            }
            page_to_be_displayed = "view";
        }
        return mapping.findForward(page_to_be_displayed);
    }

    public void resetstatus(CompForm frm)
    {
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        frm.setVill("");
        frm.setHabCode("");
        frm.setAssetCd1("");
    }
}
