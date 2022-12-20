package nic.watersoft.proposals;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class SaveAdminHabs extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
		//System.out.println("in save admin habs action class");
		javax.servlet.http.HttpSession session=request.getSession();	 
		RwsUser user=new RwsUser();
		user=(RwsUser)session.getAttribute("RWS_USER");
		String target = new String("save-success");
			
		String[] selectedHabCodes = request.getParameterValues("selectedHabCode");
		String proposalId = request.getParameter("proposalId");
		
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		//remove insertion code
		/*
		if(proposalDAO.insertProposalTempHabsForAdmin(proposalId, selectedHabCodes,"tab_"+user.getUserId()+"_temp"))
			request.setAttribute("insert-success", "inserted");
		else
			request.setAttribute("insert-success", "not-inserted");
		*/
			//code added
			//saving to session
			request.setAttribute("insert-success", "inserted");
			removeHabsFromSession(session,proposalId);
		    saveSelectedHabsToSession(session,proposalId,selectedHabCodes);
			//code to be deleted
		    /*
		    String query = " SELECT distinct m.mcode,m.mname,con.constituency_code,con.constituency_name,PR.panch_code, PR.panch_name, "
				  + " (HD.census_plain_popu + HD.census_sc_popu + HD.census_st_popu), "
				  + " HD.coverage_status FROM rws_panchayat_raj_tbl PR, "
				  + " rws_habitation_directory_tbl HD,rws_constituency_tbl con,rws_mandal_tbl  m"
				  + " WHERE PR.panch_code = HD.hab_code and m.dcode=substr(hd.hab_code,1,2) and m.mcode=substr(hd.hab_code,6,2)"
				  + " AND PR.panch_code = HD.hab_code and con.dcode=substr(hd.hab_code,1,2) and substr(hd.hab_code,3,3)=constituency_code and con.constituency_type='A' "
				  + " and hd.hab_code in('";

			for (int i = 0; i < selectedHabCodes.length; i++)
			{
			query=query+selectedHabCodes[i]+"'";
			if(i!=selectedHabCodes.length-1)
			query=query+",'";
			}
			query=query+"')";
			
			//System.out.println("query123 is "+query);
			*/
			//end of code to be deleted
			//end of code added
			
	    //session.removeAttribute("tempSelectedHabs");
		return mapping.findForward(target);
	}
	
	public void saveSelectedHabsToSession(HttpSession session,String workId,String selectedHabCodes[])
	{
		try{
			
		ArrayList tempSelectedAdmnHabs=(ArrayList)session.getAttribute("tempSelectedAdmnHabs");
		if(tempSelectedAdmnHabs==null)
			tempSelectedAdmnHabs=new ArrayList();
		for (int i = 0; i < selectedHabCodes.length; i++)
		{
			nic.watersoft.commons.RwsLocationBean rwsLocationBean=new nic.watersoft.commons.RwsLocationBean();
			rwsLocationBean.setProposalId(workId);
			rwsLocationBean.setHabCode(selectedHabCodes[i]);
			tempSelectedAdmnHabs.add(rwsLocationBean);
		}
		session.setAttribute("tempSelectedAdmnHabs",tempSelectedAdmnHabs);
		//System.out.println("tempSelectedAdmnHabs size after adding is "+tempSelectedAdmnHabs.size());
		}catch(Exception e){//System.out.println("Exception in saveSelectedHabs to session() is "+e);
		
		}
		
	}
	public void removeHabsFromSession(HttpSession session,String workId)
	{
		try{
			
		//System.out.println("in removeHabsFromSession()");
		ArrayList tempSelectedAdmnHabs=(ArrayList)session.getAttribute("tempSelectedAdmnHabs");
		if(tempSelectedAdmnHabs==null)
			tempSelectedAdmnHabs=new ArrayList();
		for (int i = 0; i < tempSelectedAdmnHabs.size(); i++)
		{
			nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)tempSelectedAdmnHabs.get(i);
			if(rwsLocationBean.getProposalId().equals(workId))
			{
				tempSelectedAdmnHabs.set(i,null);
			}
			
		}
		for (int i = 0; i < tempSelectedAdmnHabs.size(); i++)
		{
			nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)tempSelectedAdmnHabs.get(i);
			if(rwsLocationBean==null)
			{
				tempSelectedAdmnHabs.remove(i);
				i--;
			}
		}
		session.setAttribute("tempSelectedAdmnHabs",tempSelectedAdmnHabs);
		//System.out.println("tempSelectedAdmnHabs size after removing is "+tempSelectedAdmnHabs.size());
		}catch(Exception e){//System.out.println("Exception in removeHabsFromSession() is "+e);
		
		}
		
	}
	
	
}