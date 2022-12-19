package nic.watersoft.works;

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
import nic.watersoft.works.OfficeMasterForm;

import org.apache.struts.action.*;

import nic.watersoft.works.*;
import nic.watersoft.commons.Debug.*;

public class rws_WorkNameChangeAct_frm extends Action {
	public rws_WorkNameChangeAct_frm() {}
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String message = null;
		String workid="";		
		String headoffice="1";
		OfficeMasterForm frm = (OfficeMasterForm) form;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)|| user.getUserId().substring(4).equals("EE") ))) {
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
				}
				else{
				 	session.removeAttribute("works");
				}
			}
			catch(Exception p){
				System.out.println("The Exception in rws_WorkNameChangeAct_frm in data is  = "+p.getMessage());
			}			
			mode = "view";
		}
		
		if(mode != null && mode.equalsIgnoreCase("update")){
			if (storedToken.equals(token)) {	
				try	{				
					String workName=frm.getChangeWorkName();
					Rws_WorkChange_Dao change_Dao=new Rws_WorkChange_Dao();				
					int n=change_Dao.updateOfficeCode(frm.getWorkId(),workName);
					if(n>0 ){
						message="Work Name updated Successfully for Work Id"+frm.getWorkId();
					}
					else {
						message="Work Name Updation Failed";	
					}
					request.setAttribute("message",message);
					reset(frm);
					if(frm.getWorkId() != null && !frm.getWorkId().equals("")){	
						officeMasterData=new OfficeMasterData();
						works=officeMasterData.getWorksdetails(frm.getWorkId());
						session.setAttribute("works",works);
						frm.setWorks(works);				
					}
				}
				catch(Exception p){
					System.out.println("The Exception in rws_WorkNameChangeAct_frm in update is  = "+p.getMessage());
				}
				mode="update";
			}
		}			
		return mapping.findForward(mode);
	}
	
	public void reset(OfficeMasterForm frm)	{
		frm.setChangeWorkName("");
	}
}

