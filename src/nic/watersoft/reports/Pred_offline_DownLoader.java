package nic.watersoft.reports;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nic.watersoft.commons.RwsUser;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class Pred_offline_DownLoader extends Action {
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
		{
		try{
		//System.out.println("in download class");
			
		HttpSession session=request.getSession();
		RwsUser user=(RwsUser)session.getAttribute("RWS_USER");	
		
		//System.out.println("circle ode is "+user.getCircleOfficeCode());
		request.setAttribute("DistrictCode",user.getCircleOfficeCode());
		}
		catch(Exception e)
		{
			//System.out.println("Exception in Pred_offline Downloader calss"+e);
		}
		    return(mapping.findForward("DownLoadPred_offline"));
		   }
	      }



