
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

public class rws_AssetComplaintAttendedActgeneric_frm extends Action
{

    public rws_AssetComplaintAttendedActgeneric_frm()
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
        String circlecode = "";
        CompForm frm = (CompForm)form;
        javax.sql.DataSource dataSource = getDataSource(request);
        RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
        Debug.println("user" + user);
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
                complaintsnotattended = ComplaintMasterData.getNotAttendedComplaintsgeneric(frm.getHabCode(), getDataSource(request));
                request.setAttribute("complaintsnotattended", complaintsnotattended);
                frm.setComplaintsnotattended(complaintsnotattended);
                complaintsalist = nic.watersoft.complaints.ComplaintMasterData.getComplaintsattendedgeneric(frm.getHabCode(), getDataSource(request));
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
        if(mode != null && mode.equals("attend"))
        {
            try
            {
                String componentname = request.getParameter("componentName");
                String complaintno = request.getParameter("complntno");
                session.setAttribute("componentname", componentname);
                session.setAttribute("complaintno", complaintno);
                
                String complaintdate = request.getParameter("complntdt");
                
                session.setAttribute("complaintdate", complaintdate);
                String repname = request.getParameter("repName");
                Debug.println("***repname" + repname);
                session.setAttribute("repname", repname);
                
                
                
                String name = request.getParameter("name");
                session.setAttribute("name", name);
                String address = request.getParameter("address");
                session.setAttribute("address", address);
            }
            catch(Exception e)
            {
                System.out.println("Exception cc" + e);
            }
            page_to_be_displayed = "attend";
        }
        if(mode != null && mode.equalsIgnoreCase("save"))
        {
            try
            {
                ComplaintMasterData = new ComplaintMasterData();
                compForm = new CompForm();
                compForm.setComplntno(frm.getComplntno());
                compForm.setComponentName(frm.getComponentName());
                compForm.setComplntdt(frm.getComplntdt());
                compForm.setComplntdesc(frm.getComplntdesc());
                compForm.setAttenby(frm.getAttenby());
                compForm.setAttendt(frm.getAttendt());
                compForm.setComplntstatus(frm.getComplntstatus());
                compForm.setRemarksby(frm.getRemarksby());
                compForm.setCostIncurred(frm.getCostIncurred());
                String componentname = (String)session.getAttribute("componentname");
                String complaint = (String)session.getAttribute("complaintno");
                compCount = nic.watersoft.complaints.ComplaintMasterData.insertComplaintAttendedgeneric(compForm, complaint, getDataSource(request));
               Debug.println("compCount:"+compCount);
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
        Debug.println("mode" + mode);
        if(mode != null && mode.equals("get2"))
        {
            ComplaintMasterData complaintMasterData = new ComplaintMasterData();
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
                reseta(frm);
            try
            {
                headOfficeCode = user.getHeadOfficeCode();
                circleOfficeCode = user.getCircleOfficeCode();
                Debug.println("circleOfficeCodeget2" + circleOfficeCode);
                if(circleOfficeCode != null && !circleOfficeCode.equals("00"))
                {
                    Debug.println("userlogin");
                    session.setAttribute("circles", circles);
                    Debug.println("circleOfficeCodeget2" + circleOfficeCode);
                    if(circleOfficeCode != null)
                    {	
                    district1 = rwsOffices.getDistrictName(circleOfficeCode);
                    Debug.println("!district00" + district1);
                    request.setAttribute("district1", district1);
                    frm.setDistrictName(district1);
                    frm.setDistrictCode(circleOfficeCode);
                    mandals = rwsLocations.getMandals(circleOfficeCode);
                    session.setAttribute("mandals", mandals);
                    }
                    if(frm.getMandal() != null && !frm.getMandal().equals(""))
                    {
                        panchayats = rwsLocations.getPanchayats(frm.getCircleOfficeCode(), frm.getMandal());
                        session.setAttribute("panchayats", panchayats);
                    } else
                    {
                        session.setAttribute("panchayats", new ArrayList());
                    }
                    if(frm.getPcode() != null && !frm.getPcode().equals(""))
                    {
                        habs = rwsLocations.getPanchayatHabitations(frm.getCircleOfficeCode(), frm.getMandal(), frm.getPcode());
                        session.setAttribute("habs", habs);
                        //Debug.println(habs.size());
                    } else
                    {
                        session.setAttribute("habs", new ArrayList());
                    }
                } 
                if(circleOfficeCode != null && circleOfficeCode.equals("00") && !circleOfficeCode.equals(" "))
                {
                    Debug.println("admin84login");
                    circles = complaintMasterData.getCompCirclesgeneric(headOfficeCode, getDataSource(request));
                    session.setAttribute("circles", circles);
                    if(frm.getCircleOfficeCode() != null && !frm.getCircleOfficeCode().equals(" ") )
                    {
                        district1 = rwsOffices.getDistrictName(frm.getCircleOfficeCode());
                        Debug.println("district00" + district1);
                        request.setAttribute("district1", district1);
                        frm.setDistrictName(district1);
                        if(frm.getCircleOfficeCode() != null && !frm.getCircleOfficeCode().equals(""))
                        {
                            mandals = complaintMasterData.getCompMandalsgeneric(frm.getCircleOfficeCode(), getDataSource(request));
                            session.setAttribute("mandals", mandals);
                        } else
                        {
                            session.setAttribute("mandals", new ArrayList());
                        }
                        if(frm.getMandal() != null && !frm.getMandal().equals(""))
                        {
                            panchayats = complaintMasterData.getCompPanchayatsgeneric(frm.getCircleOfficeCode(), frm.getMandal(), getDataSource(request));
                            session.setAttribute("panchayats", panchayats);
                        } else
                        {
                            session.setAttribute("panchayats", new ArrayList());
                        }
                        if(frm.getPcode() != null && !frm.getPcode().equals(""))
                        {
                            habs = complaintMasterData.getCompHabsgeneric(frm.getCircleOfficeCode(), frm.getMandal(), frm.getPcode(), getDataSource(request));
                            session.setAttribute("habs", habs);
                            //Debug.println(habs.size());
                        } else
                        {
                            session.setAttribute("habs", new ArrayList());
                        }
                    }
                }
            }
            catch(Exception o)
            {
                System.out.println("Exceptiion in get2" + o);
            }
            page_to_be_displayed = "get2";
        }
        return mapping.findForward(page_to_be_displayed);
    }

    public void reseta(CompForm frm)
    {
        frm.setCircleOfficeCode("");
        frm.setDist("");
        frm.setMandal("");
        frm.setPcode("");
        frm.setHabCode("");
        frm.setAssetCd1("");
    }
}
