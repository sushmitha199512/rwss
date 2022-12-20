/*
 * Created on Nov 30, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
public class Mon_Phy_Fin_form_act extends Action{
			public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
			  {
				 Mon_Phy_Fin_form frm=(Mon_Phy_Fin_form)form;
			     //System.out.println("printing mode");
				 //System.out.println("mode is "+request.getParameter("mode"));
				 // to populate the districts
				 String mode = request.getParameter("mode");
				 HttpSession session= request.getSession();
				try{
				 if (mode!=null && mode.equals("init"))
				 {	
				 					 					 			 	
				 	Mon_Phy_Fin_data Mon_Phy_Fin_data= new Mon_Phy_Fin_data();
				 	ArrayList fin_yr=Mon_Phy_Fin_data.getfin_year();
					session.setAttribute("finyear",fin_yr);
				 }
				 if (mode!=null && mode.equals("list"))
				 {	
				 	Mon_Phy_Fin_data Mon_Phy_Fin_data= new Mon_Phy_Fin_data();
				 	ArrayList district=Mon_Phy_Fin_data.getdistrict();
					session.setAttribute("district",district);
					session.setAttribute("dcode",district);
				 					 			 	
				 	Mon_Phy_Fin_data Mon_Phy_Fin_data1= new Mon_Phy_Fin_data();
				 	String status[][]=Mon_Phy_Fin_data1.getstatus(frm.getMfin_year());
				 	printStatus(status);
				 	session.setAttribute("status",status);
					//System.out.println("status"+status);
				 }	 
				}catch(Exception e){
					//System.out.println("Exception in Mon_Phy_Fin_form_act is "+e);}
				}
				 return mapping.findForward(mode);
 			  }
			
			public void printStatus(String[][] status)
			{
				for(int i=0;i<status.length;i++)
				{
					for(int j=0;j<status[i].length;j++)
					{
						//System.out.println("status["+i+"]["+j+"] is "+status[i][j]);
					}
				}
			}
			
}


