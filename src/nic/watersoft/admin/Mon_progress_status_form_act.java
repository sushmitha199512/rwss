/*
 * Created on Nov 23, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
/**
 * @author nic
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Mon_progress_status_form_act extends Action{
			public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
			  {
				 Mon_Progress_Status_form frm=(Mon_Progress_Status_form)form;
			     //System.out.println("printing mode");
				 //System.out.println("mode is "+request.getParameter("mode"));
				 // to populate the districts
				 String mode = request.getParameter("mode");
				 HttpSession session= request.getSession();
				 if (mode!=null && mode.equals("init"))
				 {	
				 Mon_Progress_data Mon_Progress_data= new Mon_Progress_data();
				 ArrayList districtlist=Mon_Progress_data.getdistrict();
				 session.setAttribute("districts",districtlist);
				 }
				 else  if (mode!=null && mode.equals("dist"))
				 {
				 	//System.out.println("we are in fin_year mode ");
				 	Mon_Progress_data Mon_Progress_data= new Mon_Progress_data();
				 	//System.out.println("print dist"+frm.getMdistrict());
					ArrayList fin_yr=Mon_Progress_data.getfin_year(frm.getMdistrict());
					session.setAttribute("finyear",fin_yr);
				 }
				 
				 else if (mode!=null && mode.equals("year"))
				 {
				 	//System.out.println("we are in month mode ");
				 	Mon_Progress_data Mon_Progress_data= new Mon_Progress_data();
					ArrayList month=Mon_Progress_data.getmonth(frm.getMfin_year(),frm.getMdistrict());
					//System.out.println("print dist"+frm.getMdistrict());
					//System.out.println("print fin year"+frm.getMfin_year());
					request.setAttribute("month",month);	
				 }
				 return mapping.findForward(mode);
 			  }
			
}

