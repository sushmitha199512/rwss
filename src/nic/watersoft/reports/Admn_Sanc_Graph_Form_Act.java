

package nic.watersoft.reports;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.commons.Debug;

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
public class Admn_Sanc_Graph_Form_Act extends Action{
			public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
			  {
				 Admn_Sanc_Graph_Form frm= (Admn_Sanc_Graph_Form )form;
				 //System.out.println("printing mode");
				 //System.out.println("mode is "+request.getParameter("mode"));
				 // to populate the districts
				 String mode = request.getParameter("mode");
				 HttpSession session= request.getSession();
				try{
				 if (mode!=null && mode.equals("init"))
				 {	
				 	//System.out.println("Get Finyear");				 					 			 	
				 	Admn_Sanc_Graph_Data Admn_Sanc_Data= new Admn_Sanc_Graph_Data();
				 	ArrayList fin_yr=Admn_Sanc_Data.getfin_year();
					session.setAttribute("finyear",fin_yr);
					//System.out.println("status"+fin_yr);
				 }
				 if (mode!=null && mode.equals("graph"))
				 {	
				 	//System.out.println("Get graph");
				 }
				}catch(Exception e){
					//System.out.println("Exception in Admn sanc form "+e);}
				}
				 return mapping.findForward(mode);
			  }
			
						
}


