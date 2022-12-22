package nic.watersoft.works;import java.io.IOException;import java.io.PrintStream;import java.util.ArrayList;import java.util.Collection;import javax.servlet.ServletException;import javax.servlet.http.*;import nic.watersoft.commons.*;import org.apache.struts.action.*;public class rws_WorkIdBlockEntryAct_frm extends Action {	public rws_WorkIdBlockEntryAct_frm() {}		public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		String message = null;		String workid="";		int rcount=0;		String headoffice="1";		OfficeMasterForm frm = (OfficeMasterForm) form;		String mode = request.getParameter("mode");		HttpSession session = request.getSession();		String storedToken = (String)session.getAttribute("csrfToken");	    String token = request.getParameter("token");	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");		if (user == null)			return mapping.findForward("expire");				if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {			return mapping.findForward("unAuthorise");			}		ArrayList works = new ArrayList();		String block="";		String mess="";		OfficeMasterData officeMasterData=new OfficeMasterData();		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));		if (mode != null && mode.equalsIgnoreCase("data")){			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {				reset(frm);				request.removeAttribute("works");			}			try	{							request.removeAttribute("works");				workid=frm.getWorkId();			    if(frm.getWorkId() != null && !frm.getWorkId().equals("")){						officeMasterData=new OfficeMasterData();					works=officeMasterData.getBlockWorksdetails(frm.getWorkId());					request.setAttribute("works",works);					frm.setWorks(works);									}			}			catch(Exception p){				System.out.println("The Exception in rws_WorkIdBlockEntryAct_frm in data is  = "+p.getMessage());			}						mode = "view";		}				if(mode != null && mode.equalsIgnoreCase("update"))	{			if (storedToken.equals(token)) {					try	{					officeMasterData=new OfficeMasterData();									OfficeMasterBean officeMasterBean=new OfficeMasterBean();            		            	officeMasterBean.setBlockPayment(frm.getBlockPayment());	            	officeMasterBean.setBlockDate(frm.getBlockDate());	            	rcount=officeMasterData.updateBlockPayment(officeMasterBean,frm.getWorkId());					if(rcount > 0 )	{						message="WorkId is Blocked / UnBlocked";					}					else {						message="WorkId is Not Blocked / UnBlocked";						}					request.setAttribute("message",message);					frm.setBlockPayment("");					frm.setBlockDate("");					reset(frm);					request.removeAttribute("works");								}				catch(Exception p){					System.out.println("The Exception in rws_WorkIdBlockEntryAct_frm in Update is  = "+p.getMessage());				}				mode="update";			}		}					return mapping.findForward(mode);	}		public void reset(OfficeMasterForm frm){		frm.setWorkId("");		frm.setBlockPayment("");		frm.setBlockDate("");		frm.setChecks("");			}}