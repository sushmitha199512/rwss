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
public class Contractor_Work_Report_Form_Act extends Action{
			public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
			  {
				 Contractor_Work_Report_Form frm= (Contractor_Work_Report_Form)form;
				 String mode = request.getParameter("mode");
				 HttpSession session= request.getSession();
				try{
				  Contractor_Work_Report_Data Contractor_Work_Report= new Contractor_Work_Report_Data();	
				  // to populate the districts
				  ArrayList year=null;
				  ArrayList contractor=null;
				  String [][] condata= new String[30][2];
				  String  count=null;
				  if (mode!=null && mode.equals("init"))
				 {	
				 	//System.out.println("Get District");				 					 			 	
				 	
				 	ArrayList district=Contractor_Work_Report.getdistrict();
					session.setAttribute("district",district);
					session.setAttribute("dcode",district);
					//System.out.println("status"+ district);
					year=Contractor_Work_Report.getyear("ALL");	
					session.setAttribute("year",year);
					//System.out.println("Year"+ year);
    				contractor=Contractor_Work_Report.getcontractor("ALL","ALL");
					session.setAttribute("contractor",contractor);
					//System.out.println("Contractor"+ contractor);
				 }
				 else if (mode!=null && mode.equals("year"))
				 {	
					//System.out.println("Get Year");	
			        year=Contractor_Work_Report.getyear(frm.getMdistrict());
				 	session.setAttribute("year",year);
					//System.out.println("Year"+ year);
				 }
				 else  if (mode!=null && mode.equals("contractor"))
				 {	
					//System.out.println("Get Contractor");
					if (frm.mdistrict.equals("ALL") && !frm.myear.equals("ALL"))
					{
						contractor=Contractor_Work_Report.getcontractor("ALL",frm.getMyear());
					}	
					else  if (!frm.mdistrict.equals("ALL") && frm.myear.equals("ALL"))
					{
						contractor=Contractor_Work_Report.getcontractor(frm.getMdistrict(),"ALL");
					}	
					else
					{					
					    contractor=Contractor_Work_Report.getcontractor(frm.getMdistrict(),frm.getMyear());
					}
					session.setAttribute("contractor",contractor);
					//System.out.println("Contractor"+ contractor);
							
				 }
				 if (mode!=null && mode.equals("view"))
				 {	
				 	
				 	//System.out.println("print report");
				 	count=Contractor_Work_Report.getcountrec(frm.getMdistrict(),frm.getMyear(),frm.getMcontractor());
				 	session.setAttribute("count",count);
					//System.out.println("count"+count);
				 	condata=Contractor_Work_Report.getcondata(frm.getMdistrict(),frm.getMyear(),frm.getMcontractor());
				    session.setAttribute("condata",condata);
					//System.out.println("status"+condata);
				    // session.setAttribute("count",count);
					//System.out.println("Result from action class");
				 }
				}catch(Exception e){
					//System.out.println("Exception in contractor Report form "+e);}
					
				}
				 return mapping.findForward(mode);
			  }
							
}


