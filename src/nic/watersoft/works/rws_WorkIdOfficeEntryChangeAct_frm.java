package nic.watersoft.works;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.OfficeMasterForm;

import org.apache.struts.action.*;


public class rws_WorkIdOfficeEntryChangeAct_frm extends Action {
	public rws_WorkIdOfficeEntryChangeAct_frm(){}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message = null;
		String workid="";
		int[] rcount=null;
		ArrayList divisions=new ArrayList();
		ArrayList subdivisions=new ArrayList();
		String headoffice="1";
		OfficeMasterForm frm = (OfficeMasterForm) form;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
	    ArrayList works = new ArrayList();
		OfficeMasterData officeMasterData=new OfficeMasterData();
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("data")){
			if (request.getParameter("special") != null	&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try	{			
			    workid=frm.getWorkId();
			    if(workid != null && !workid.equals("")){	
					officeMasterData=new OfficeMasterData();
					works=officeMasterData.getWorksdetails(workid);
					session.setAttribute("works",works);
					frm.setWorks(works);				
					divisions=officeMasterData.getWorkdivisions(frm.getWorkId(),headoffice);
					session.setAttribute("divisions",divisions);
				}
				else {
				 	session.removeAttribute("works");
				}
			}
			catch(Exception p) {
				System.out.println("The Exception in rws_WorkIdOfficeEntryChangeAct_frm in mode data : " + p.getMessage());
			}			
		 mode = "data";
		}
		
		if (mode != null && mode.equalsIgnoreCase("view")){
			try	{
				subdivisions=officeMasterData.getWorkSubdivisions(frm.getWorkId(),frm.getDivisionOfficeCode(),headoffice);
				session.setAttribute("subdivisions",subdivisions);				
			}
			catch(Exception o) {
				System.out.println("The Exception in rws_WorkIdOfficeEntryChangeAct_frm in mode View : " + o.getMessage());
			}
			mode="view";
		}
		if(mode != null && mode.equalsIgnoreCase("update")) {
			if (storedToken.equals(token)) {	
				try	{
					officeMasterData=new OfficeMasterData();
					String d=frm.getDivisionOfficeCode();
					String s=frm.getSubdivisionofficeCode();				
					rcount=officeMasterData.updateOfficeCode(frm.getWorkId(),d,s);
					if(rcount.length >0 ) {
						message="Office updated with division: "+d+" " + " subdivision: "+s;
					}
					else {
						message="Office  Not updated";	
					}
					request.setAttribute("message",message);
					reset(frm);
					session.removeAttribute("works");
					session.removeAttribute("divisions");
					session.removeAttribute("subdivisions");
				}
				catch(Exception p) {
					System.out.println("The Exception in rws_WorkIdOfficeEntryChangeAct_frm in mode update : " + p.getMessage());
				}
				mode="update";				
			}	
			
		}
		return mapping.findForward(mode);
	}
	
	public void reset(OfficeMasterForm frm){
		frm.setWorkId("");
		frm.setDivisionOfficeCode("");
		frm.setSubdivisionofficeCode("");
	}
}

