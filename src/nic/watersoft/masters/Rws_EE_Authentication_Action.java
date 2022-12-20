/*
 * Created on 27-08-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author Sai Praad N
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_EE_Authentication_Action extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DataSource dataSource = null;
		DataSource ds = null;
		ArrayList eeList=null;
		String SUCCESS = "success";
		HttpSession session = request.getSession();
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		Rws_EE_Authentication_Form frm = (Rws_EE_Authentication_Form)form;
		Rws_EE_Authentication_DAO wd = null;
		String mode = frm.getMode();
		RwsOffices offices=new RwsOffices(dataSource);
		try
		{
							
			if(mode!=null && mode.equals("data"))
			{   
				
				wd = new Rws_EE_Authentication_DAO();
				eeList = wd.getEEList();
				session.setAttribute("eeList",eeList);
				frm.setEeList(eeList);
			}
			
			if(mode!=null && mode.equals("saveEES"))
			{
				wd = new Rws_EE_Authentication_DAO();
				
				eeList=(ArrayList)session.getAttribute("eeList");
				
				
				String eeids1=request.getParameter("eeids");
				String eeids2 = eeids1.substring(1,eeids1.length());
				String[] eeids3 = eeids2.split(",");
				for(int i=0;i<eeids3.length;i++)
				{
					Debug.println(">>>>>>>>>>>>>>"+eeids3[i]);
				}
				
				int[] count = wd.saveAutheticatedEEs(eeids3,frm);
				if(count.length>0)
					request.setAttribute("message","Authendication Success.");
				else 
					request.setAttribute("message","Failed to Authenticate");
				eeList = wd.getEEList();
				session.setAttribute("worksList",eeList);
				frm.setEeList(eeList);
				
			
			}
	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		Debug.println("Returning Mode:"+mode);
		return mapping.findForward(mode);
	}
}


