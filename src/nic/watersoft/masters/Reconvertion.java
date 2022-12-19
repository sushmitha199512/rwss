package nic.watersoft.masters;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class Reconvertion extends Action {	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode="";
		ArrayList districts=new ArrayList();		
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList constituencies=new ArrayList();
		ArrayList hcodes=new ArrayList();		
		ArrayList mandals1=new ArrayList();
		ArrayList panchayats1=new ArrayList();
		ArrayList villages1=new ArrayList();
		ArrayList habitations1=new ArrayList();
		ArrayList constituencies1=new ArrayList();
		ArrayList hcodes1=new ArrayList();		
		ArrayList districts1=new ArrayList();
		ArrayList mandals2=new ArrayList();
		ArrayList panchayats2=new ArrayList();
		ArrayList villages2=new ArrayList();
		ArrayList habitations2=new ArrayList();
		ArrayList constituencies2=new ArrayList();
		ArrayList hcodes2=new ArrayList();		
		ArrayList districtsnew=new ArrayList();
		ArrayList district1=new ArrayList();
		if(request.getParameter("mode")!=null){
			mode=request.getParameter("mode");			
		}
	
		ReconvertionForm myForm=(ReconvertionForm)form;
		boolean reset = true;		
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
		HabReConvertDAO hd = new HabReConvertDAO();
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsLocations rwsLocations=new RwsLocations(getDataSource(request));		
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");  System.out.println("Reconvertion user :"+user);
		if (user == null)
			return mapping.findForward("expire");	
		if(!(user.getUserId().equals("admin") || user.getUserId().equals("100000")))
			return mapping.findForward("unauthorize");
		final String userId=user.getOfficeCode();
		String district=myForm.getDistrict();
		try{
			if(request.getParameter("mode")==null){
				districts = hd.getDistricts();
				session.setAttribute("districts",districts);
				districts1= hd.getDistricts1();
				session.setAttribute("districts1",districts1);
				session.setAttribute("mandals1",mandals1);
				session.setAttribute("panchayats1",panchayats1);
				session.setAttribute("villages1",villages1);
				session.setAttribute("habitations1",habitations1);
				session.setAttribute("constituencies1",constituencies1);
				session.setAttribute("hcodes1",hcodes1);
				session.setAttribute("mandals2",mandals2);
				session.setAttribute("panchayats2",panchayats2);
				session.setAttribute("villages2",villages2);
				session.setAttribute("habitations2",habitations2);
				session.setAttribute("constituencies2",constituencies2);
				session.setAttribute("hcodes2",hcodes2);
				myForm.setHabName("");myForm.setHabName1("");				
			}
			
			if(mode!=null && mode.equals("exist")){
				String spmode = request.getParameter("mode1");
				districts = hd.getDistricts();
				session.setAttribute("districts",districts);					
				mandals1=hd.getDistrictMandals(myForm.getDistrict());
				session.setAttribute("mandals1",mandals1);				
				panchayats1=hd.getPanchayats(myForm.getDistrict(),myForm.getMandal());
				session.setAttribute("panchayats1",panchayats1);				
				villages1=hd.getVillages(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat());
				session.setAttribute("villages1",villages1);				
				habitations1=hd.getUIHabitations(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat(),myForm.getVillage());
				session.setAttribute("habitations1",habitations1);				
				myForm.setHabName(myForm.getHabitation());
			}
			
			if(mode!=null && mode.equals("new")){
				districts1= hd.getDistricts1();
				session.setAttribute("districts1",districts1);	
				mandals2=hd.getDistrictMandals1(myForm.getDistrict1());
				session.setAttribute("mandals2",mandals2);	
				panchayats2=hd.getPanchayats1(myForm.getDistrict1(),myForm.getMandal1());
				session.setAttribute("panchayats2",panchayats2);
				villages2=hd.getVillages1(myForm.getDistrict1(),myForm.getMandal1(),myForm.getPanchayat1());
				session.setAttribute("villages2",villages2);
				habitations2=hd.getNewHabitations(myForm.getDistrict1(),myForm.getMandal1(),myForm.getPanchayat1(),myForm.getVillage1());
				session.setAttribute("habitations2",habitations2);	
				myForm.setHabName1(myForm.getHabitation1());
			}
			
			if(mode!=null && mode.equals("convert")){
				if (storedToken.equals(token)){	
					String habCodeOld = myForm.getHabitation();
					String habCodeNew = myForm.getHabitation1();
					String coveredStatus = myForm.getCoveredStatus();
					String message = "";
					if(habCodeOld==null)
						habCodeOld = request.getParameter("oldCode");
					if(habCodeNew==null)
						habCodeNew = request.getParameter("newCode");
					if(coveredStatus==null)
						coveredStatus = request.getParameter("coveredStatus");
					String message1 = hd.covertOldHabToNewHab(habCodeOld,habCodeNew,coveredStatus,request);
					request.setAttribute("message",message1);	
					request.setAttribute("message",message1);
			   }
			}
		}
		catch(Exception e){
			System.out.println("The Exception in Reconvertion : " +e.getMessage());
		}
		return mapping.findForward("success");	
	}
}
