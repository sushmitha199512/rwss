package nic.watersoft.works;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.*;
import org.apache.struts.action.*;
public class rws_LeadHabEntryAct_frm extends Action
{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		String message = null;
		int rcount=0;
		LeadHabForm frm = (LeadHabForm) form;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		
		if (user == null)
			return mapping.findForward("expire");	
				
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		
		
		ArrayList works = new ArrayList();
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList habs=new ArrayList();
		boolean exists1 = false;
		boolean exists = false;
		boolean completed = false;
		LeadHabData leadHabData=new LeadHabData();
		if (mode != null && mode.equalsIgnoreCase("data"))
		{
			try
			{
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
				session.removeAttribute("works");
				session.removeAttribute("habs");
				session.removeAttribute("districts");
				session.removeAttribute("mandals");
				session.removeAttribute("panchayats");
			}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		if (mode != null && mode.equalsIgnoreCase("view"))
		{
			try
			{					
				exists=leadHabData.isExists(frm.getWorkId());
				completed=leadHabData.isCompleted(frm.getWorkId());
				if(exists==false && completed==false)
				{
					leadHabData=new LeadHabData();
					works=leadHabData.getWorksdetails(frm.getWorkId());
					session.setAttribute("works",works);
					frm.setWorks(works);
					exists1=leadHabData.isExists1(frm.getWorkId());
					if(exists1==true)
					{
					districts=leadHabData.getDistrictslead(frm.getWorkId());
					session.setAttribute("districts",districts);
					}
					else
					{
						session.setAttribute("districts",new ArrayList());
					}
				}else if(exists==true)
				{
					session.removeAttribute("districts");
					message="Already work is converted into asset ";
					request.setAttribute("message",message);
				}else if(completed==true)
				{
					session.removeAttribute("districts");
					message="Already work is Completed ";
					request.setAttribute("message",message);
				}
				
				
			}
			catch(Exception p)
			{
				p.printStackTrace();
			}			
		}
		
		
		
		if(mode != null && mode.equalsIgnoreCase("get2"))
		{
			try
			{
				
					
				if(frm.getDist()!=null && !frm.getDist().equals("") && !frm.getDist().equals("null"))
				{
					mandals=leadHabData.getMandalslead(frm.getDist());
					session.setAttribute("mandals",mandals);
				}
				else
				{
					session.setAttribute("mandals",new ArrayList());
				}
				if(frm.getDist()!=null && !frm.getDist().equals("") && !frm.getDist().equals("null") && frm.getMcode() != null && !frm.getMcode().equals("") && !frm.getMcode().equals("null"))
				{
					panchayats=leadHabData.getPanchayatslead(frm.getDist(),frm.getMcode());
					session.setAttribute("panchayats",panchayats);
				}
				else
				{
					session.setAttribute("panchayats",new ArrayList());
				}
				
				
				
				
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
		}
		if(mode != null && mode.equalsIgnoreCase("lead"))
		{
			try{
				
				session.setAttribute("habs",new ArrayList());
		if(frm.getDist()!=null && !frm.getDist().equals("") && !frm.getDist().equals("null") && frm.getMcode() != null && !frm.getMcode().equals("") && !frm.getMcode().equals("null") && frm.getPcode()!=null && !frm.getPcode().equals("") && !frm.getPcode().equals("null"))
		{
			habs=leadHabData.gethabdetails(frm.getDist(),frm.getMcode(),frm.getPcode());
			session.setAttribute("habs",habs);
			frm.setHabs(habs);
		}
		else
		{
			session.setAttribute("habs",new ArrayList());
		}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			
		}
		
		if(mode != null && mode.equalsIgnoreCase("update"))
		{
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {	
			try
			{
				
				String name="";
				
						
				String habcode=frm.getAssetCd1();
				
				if(habcode !=null && !habcode.equals(""))
				{
				rcount=leadHabData.updateLeadHab(frm,habcode);
				}
				else
				{
					
				}
					
				if(rcount > 0 )
				{
					message="Lead Habitation Updated Successfully";
					
				}
				else
				{
				message="Lead Habitation is Not Updated";	
				}
				
				request.setAttribute("message",message);
				reset(frm);
				session.removeAttribute("works");
				session.removeAttribute("habs");
				
			}
			catch(Exception p)
			{
				p.printStackTrace();
			}
		    }
			
		}
		return mapping.findForward(mode);
	}
	public void reset(LeadHabForm frm)
	{
		frm.setWorkId("");
		frm.setDist("");
		frm.setMcode("");
		frm.setPcode("");
		
		
		
	}
}

