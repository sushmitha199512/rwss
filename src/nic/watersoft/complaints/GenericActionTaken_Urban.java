package nic.watersoft.complaints;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
/*import nic.watersoft.sms.SMS;*/

public class GenericActionTaken_Urban extends Action {	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		String page_to_be_displayed="get2";	
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = rwsUser.getUserId();		
		String circle=loggedUser.substring(1,3);		
		String message = null;
		ArrayList<GenericActionBean> generic=new ArrayList<GenericActionBean>();
		ArrayList<LabelValueBean> districts=null;
		String mode = request.getParameter("mode");		
		
		GenericActionForm frm=null;
		GenericActionDAO genericActionDAO=null;
		System.out.println("loggedUser : " + loggedUser +", circle : "+circle );
		frm = (GenericActionForm) form;
		if(mode!=null && mode.equalsIgnoreCase("get2")){			
 			try{
 				
 				 districts=new ArrayList<LabelValueBean>();
 				genericActionDAO=new GenericActionDAO(); 				
 				if(loggedUser.equals("admin") || loggedUser.equals("200000") || loggedUser.equals("1000DR") ){
 					districts = genericActionDAO.getUrbDistricts(null);
 					session.setAttribute("districts",districts); 				
 				}
 				else{
 					districts = genericActionDAO.getUrbDistricts(circle);
 					session.setAttribute("districts",districts);
 				}			 				
 			   }
 			catch(Exception e){
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get2";
 		}		
		if(mode!=null && mode.equalsIgnoreCase("imageView")){
			//System.out.println("Complaint Number is"+request.getParameter("conplaintNo"));
			page_to_be_displayed="imageView";
 		}
		if(mode!=null && mode.equalsIgnoreCase("cmplaintData")){		
              try{ 			
	 				genericActionDAO=new GenericActionDAO();
	 				if (frm.getGeneric() != null && frm.getGeneric().size() > 1) {
						frm.getGeneric().clear();
					}
	 				String dcode=request.getParameter("district");
					String date=request.getParameter("date");					
	 				if(loggedUser.equals("admin") || loggedUser.equals("200000") || loggedUser.equals("1000DR") ){ 					 				
	 					generic=genericActionDAO.getUrbGenericDetails(circle,dcode,date,loggedUser); 					
	 				}
	 				else{
	 					generic=genericActionDAO.getUrbGenericDetails(circle,dcode,date,loggedUser);
	 				}
	 				frm.setGeneric(generic);
	 				session.setAttribute("generic", generic);
 			   }
 			catch(Exception e){
 				System.out.println("Exception : "+e);
			}
 			page_to_be_displayed="get2";	
		}
		if(mode!=null && mode.equalsIgnoreCase("Save"))	{				
 			try{ 			
 				genericActionDAO=new GenericActionDAO(); 					
 				int genericcomp=genericActionDAO.updateUrbActiontaken(frm,getDataSource(request),request);
 				if(genericcomp < 1){
                	message = "Record Can't be inserted";
 				}  
                else{
                	message = "Record Inserted Successfully";                               	               
                	request.setAttribute("message", message);
                } 				
 			   }
 			catch(Exception e){
 				System.out.println("Exception : "+e);
			}
 			page_to_be_displayed="Save";
 		}
		
		 return mapping.findForward(page_to_be_displayed);
	}
	
//	private void reset(GenericActionForm frm,
//			HttpSession session) {
//		frm.setGeneric(new ArrayList());
//
//	}

}
