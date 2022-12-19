/*
 * Created on Apr 23, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.worksMonitoring;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.Action;
import java.util.ArrayList;
public class rws_work_status_frm extends Action {
	public ActionForward execute (ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String mode=request.getParameter("mode");
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		ArrayList circles=null;
		ArrayList divisions=null;
		ArrayList programs=null;
		ArrayList subPrograms=null;
		ArrayList works=null;
		ArrayList typeOfAssets=null;
		
		if(mode.equals("data"))
		{
			
		}
		return mapping.findForward(mode);
	}

}
