
package nic.watersoft.reports;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.HabStatusForm;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class TableListAction extends Action{
	
public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String mode="";
	if(request.getParameter("mode")!=null){
		mode=request.getParameter("mode");
	}
	else
		mode="districts";
	TablesForm myForm=(TablesForm)form;
	boolean init = true;
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	ArrayList tables=new ArrayList();
	HttpSession session=request.getSession();
	RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
	if (user == null)
		return mapping.findForward("expire");		
	if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
		return mapping.findForward("unAuthorise");	
	}
	final String userId=user.getOfficeCode();
	RwsOffices rwsOffices=new RwsOffices(getDataSource(request));	
	String district=myForm.getDistrict();
	try{
		   if(init)	{
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);							
			}
		   if(district == null || district.equals("")){
				district = user.getCircleOfficeCode();
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);			
			}
		   if(mode!=null && mode.equals("mandals"))	{
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}   
	}
	catch(Exception e){
		Debug.println("The Exception is in TableListAction : "+e.getMessage());		
	}
	return mapping.findForward(mode);	
}
}
