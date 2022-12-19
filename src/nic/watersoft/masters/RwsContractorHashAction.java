package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 *
 */
public class RwsContractorHashAction extends Action {

	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		RwsContractorHashActionForm rActionForm=(RwsContractorHashActionForm)form;
		RwsContractorHashDAO rwsContractorHashDAO=new RwsContractorHashDAO();
		String mode=request.getParameter("mode");
		HttpSession session=request.getSession(true);
		nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		String userid = users.getUserId();
		String circleOfficeCode="";String divOfficeCode="";
		if(userid!=null){
			
			circleOfficeCode=userid.substring(1,3);
			divOfficeCode=userid.substring(3,4);
		}
		
		if(mode!=null && mode.equals("view")){
			
			rActionForm.getcList().clear();
				rActionForm.setcList(rwsContractorHashDAO.getContractorsList(circleOfficeCode,divOfficeCode));
		}
		if(mode!=null && mode.equals("save")){
			
			System.out.println("Size:"+rActionForm.getcList().size());
			
		rwsContractorHashDAO.approveContractor(rActionForm,request);
		return mapping.findForward("view");
			
		}
		
		
		
		return mapping.findForward(mode);
	}
}
