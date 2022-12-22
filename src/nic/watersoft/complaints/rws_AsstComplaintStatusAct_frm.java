
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

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class rws_AsstComplaintStatusAct_frm extends Action
{

    public rws_AsstComplaintStatusAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = " ";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        int compCount = 0;
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        Collection reccomplaints = null;
        reccomplaints = new ArrayList();
        Collection complaints = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        Collection districtcomplaints = new ArrayList();
        Collection mandalcomplaints = new ArrayList();
        Collection panchayatcomplaints = new ArrayList();
        ArrayList villages = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList todates = new ArrayList();
        CompForm compForm = new CompForm();
        Collection attendedcomplaints = new ArrayList();
        CompForm frm = (CompForm)form;
        int i = 0;
        String dmessage = "";
        String tdate = "";
        String frdt = "";
        String frmdt = "";
        String mode = request.getParameter("mode");
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(mode != null && mode.equalsIgnoreCase("get2"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
                reset(frm);
                session.removeAttribute("fromdates");
                session.removeAttribute("todates");
            }
            try
            {
                complaintMasterData = new ComplaintMasterData();
                districts = complaintMasterData.getCompDistricts(getDataSource(request));
                session.setAttribute("districts", districts);
                if(frm.getDist() != null && !frm.getDist().equals(""))
                {
                    mandals = complaintMasterData.getCompMandals(frm.getDist(), getDataSource(request));
                    session.setAttribute("mandals", mandals);
                    session.removeAttribute("fromdates");
                    session.removeAttribute("todates");
                } else
                {
                    session.setAttribute("mandals", new ArrayList());
                }
                if(frm.getMand() != null && !frm.getMand().equals(""))
                {
                    panchayats = complaintMasterData.getCompPanchayats(frm.getDist(), frm.getMand(), getDataSource(request));
                    session.setAttribute("panchayats", panchayats);
                } else
                {
                    session.setAttribute("panchayats", new ArrayList());
                }
                if(frm.getPanch() != null && !frm.getPanch().equals(""))
                {
                    villages = complaintMasterData.getCompVillages(frm.getDist(), frm.getMand(), frm.getPanch(), getDataSource(request));
                    session.setAttribute("villages", villages);
                } else
                {
                    session.setAttribute("villages", new ArrayList());
                }
                if(frm.getVill() != null && !frm.getVill().equals(""))
                {
                    habitations = complaintMasterData.getCompHabitations(frm.getDist(), frm.getMand(), frm.getPanch(), frm.getVill(), getDataSource(request));
                    session.setAttribute("habitations", habitations);
                } else
                {
                    session.setAttribute("habitations", new ArrayList());
                }
                page_to_be_displayed = "get2";
            }
            catch(Exception e)
            {
                System.out.println("the error in Complaint get2 is " + e);
            }
        }
        if(mode != null && mode.equalsIgnoreCase("view"))
        {
            try
            {
                if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
                {
                    reccomplaints = ComplaintMasterData.getrecComplaints(frm.getHabCode(), getDataSource(request));
                    request.setAttribute("reccomplaints", reccomplaints);
                    frm.setReccomplaints(reccomplaints);
                }
                if(reccomplaints.size() == 0)
                {
                    String message1 = "No Records for  Selection Criteria";
                    session.setAttribute("message1", message1);
                }
                Debug.println("Assetssize" + reccomplaints.size());
                if(frm.getHabCode() != null && !frm.getHabCode().equals(""))
                {
                    fromdates = ComplaintMasterData.getFromDatesdist(frm.getDist(), frm.getHabCode(), getDataSource(request));
                    session.setAttribute("fromdates", fromdates);
                    String s = frm.getFromDate();
                }
                if(frm.getFromDate() != null)
                {
                    todates = ComplaintMasterData.getToDatesdist(frm.getDist(), frm.getHabCode(), frm.getFromDate(), getDataSource(request));
                    session.setAttribute("todates", todates);
                    frmdt = frm.getToDate();
                }
            }
            catch(Exception e) 
            {
                System.out.println("The error in Complaints  View is " + e);
            }
            page_to_be_displayed = "view";
        }
        Debug.println("mode" + mode);
        if(mode != null && mode.equalsIgnoreCase("dates"))
        {
            try
            {
                reccomplaints = ComplaintMasterData.getrecComplaints(frm.getHabCode(), getDataSource(request));
                request.setAttribute("reccomplaints", reccomplaints);
                frm.setReccomplaints(reccomplaints);
                if(reccomplaints.size() == 0)
                {
                    String message1 = "No Records";
                    session.setAttribute("message1", message1);
                }
                Debug.println("Assetssize" + reccomplaints.size());
                if(frm.getFromDate() != null)
                {
                    Debug.println("from date" + frm.getFromDate());
                    frdt = frm.getFromDate();
                    String habcode = frm.getHabCode();
                    String dis = frm.getDist();
                    request.setAttribute("fromdates", ComplaintMasterData.getFromDatesdist(frm.getDist(), frm.getHabCode(), getDataSource(request)));
                    frm.setFromDate(frdt);
                    Debug.println(" value of the fromDate:" + frdt);
                    todates = ComplaintMasterData.getToDatesdist(frm.getDist(), frm.getHabCode(), frdt, getDataSource(request));
                    session.setAttribute("todates", todates);
                    request.setAttribute("todates", ComplaintMasterData.getToDatesdist(frm.getDist(), frm.getHabCode(), frdt, getDataSource(request)));
                    Debug.println("todate1" + tdate);
                    page_to_be_displayed = "data1";
                } else
                {
                    Debug.println("Started the ----> fromDate in Action");
                    String dis = frm.getDist();
                    request.setAttribute("fromdates", ComplaintMasterData.getFromDatesdist(frm.getDist(), frm.getHabCode(), getDataSource(request)));
                    Debug.println("Ended the ----> fromDate Action ");
                }
            }
            catch(Exception e)
            {
                System.out.println("The error in Asst View is " + e);
            }
            page_to_be_displayed = "dates";
        }
        if(mode != null && mode.equalsIgnoreCase("display"))
        {
            try
            {
               System.out.println("disply mode");
            	reccomplaints = ComplaintMasterData.getrecComplaints(frm.getHabCode(), getDataSource(request));
                request.setAttribute("reccomplaints", reccomplaints);
                frm.setReccomplaints(reccomplaints);
                if(reccomplaints.size() == 0)
                {
                    String message1 = "No Records";
                    session.setAttribute("message1", message1);
                }
                Debug.println("Assetssiz;e" + reccomplaints.size());
                frdt = frm.getFromDate();
                Debug.println("fromdate1" + frdt);
                tdate = frm.getToDate();
                Debug.println("todate1" + tdate);
                attendedcomplaints = ComplaintMasterData.getComplaintsattendedlist(frm.getHabCode(), frdt, tdate, getDataSource(request));
                request.setAttribute("attendedcomplaints", attendedcomplaints);
                frm.setAttendedcomplaints(attendedcomplaints);
            }
            catch(Exception e)
            {
                System.out.println("Exception" + e);
            }
            page_to_be_displayed = "display";
        }
        return mapping.findForward(page_to_be_displayed);
    }

    public void reset(CompForm frm)
    {
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        frm.setVill("");
        frm.setHabCode("");
        frm.setFromDate("");
        frm.setToDate("");
    }
}
