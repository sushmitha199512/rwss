package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_contamination_details_entry_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}		
		
		String mode="";
		CommonLists commonLists=new CommonLists(getDataSource(request));
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
			//System.out.println("mode is "+mode);
		}
		else
			mode="contaminationDetailsEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean init=myForm.isContaminationDetailsEntryFrmInit();
		ArrayList districts=new ArrayList();	
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));		
		String district=myForm.getDistrict();
		try{
		
		
			if(init)
			{
				//System.out.println("Inside if(init)");
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("nssHabs",new ArrayList());
				myForm.setContaminationDetailsEntryFrmInit(false);				
			}
			if(session.getAttribute("districts")==null)
				session.setAttribute("districts",new ArrayList());
			
			if(district == null || district.equals(""))
			{
				district = user.getCircleOfficeCode();//System.out.println("circleOfficeCode1  "+district);
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				if(!user.equals(Constants.ADMIN) && !user.equals(Constants.LAKH_USER) )
				{
					ArrayList nssHabs=new ArrayList();
					nssHabs=commonLists.getNssHabs(user.getCircleOfficeCode());
					session.setAttribute("nssHabs",nssHabs);					
				}			
			}
					
			if(mode!=null && mode.equals("data"))
			{
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				RwsMaster rwsMaster=null;
				/*
				if(!user.equals("admin") && !user.equals("100000") )
				{
					ArrayList nssHabs=new ArrayList();
					nssHabs=commonLists.getNssHabs(user.getCircleOfficeCode());
					session.setAttribute("nssHabs",nssHabs);					
				}
				else
				{
					ArrayList nssHabs=new ArrayList();
					//System.out.println("district is "+myForm.getDistrict());
					nssHabs=commonLists.getNssHabs(myForm.getDistrict());
					session.setAttribute("nssHabs",nssHabs);					
				}
				*/
				rwsMaster=rwsHabStatusData.getHabContaminationDetails(getDataSource(request),myForm.getHabitation());
				myForm.setBrakish(rwsMaster.getBrakishContamination());
				myForm.setFlouride(rwsMaster.getFlourideContamination());
				myForm.setIron(rwsMaster.getIronContamination());
				myForm.setAresenic(rwsMaster.getAresenicContamination());
				myForm.setNitrate(rwsMaster.getNitrateContamination());
				myForm.setStatusDate(rwsMaster.getStatusDate());
				myForm.setContTypes1(rwsMaster.getContTypes1());				
				myForm.setContTypes2(rwsMaster.getContTypes2());
				myForm.setContTypes3(rwsMaster.getContTypes3());
				myForm.setContTypes4(rwsMaster.getContTypes4());
				myForm.setContTypes5(rwsMaster.getContTypes5());				
				session.setAttribute("sysDate",rwsMaster.getSysDate());		
				session.setAttribute("EditForm", "false");
			}
			if(mode!=null && mode.equals("edit"))
			{
					RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
					RwsMaster rwsMaster=null;
					String habCode=request.getParameter("habCode");
					myForm.setDistrict(habCode.substring(0,2));
					ArrayList nssHabs=new ArrayList();
					nssHabs=commonLists.getNssHabs(habCode.substring(0,2));
					myForm.setHabitation(habCode);
					session.setAttribute("nssHabs",nssHabs);
					rwsMaster=rwsHabStatusData.getHabContaminationDetails(getDataSource(request),habCode);
					myForm.setBrakish(rwsMaster.getBrakishContamination());
					myForm.setFlouride(rwsMaster.getFlourideContamination());
					myForm.setIron(rwsMaster.getIronContamination());
					myForm.setAresenic(rwsMaster.getAresenicContamination());
					myForm.setNitrate(rwsMaster.getNitrateContamination());
					myForm.setStatusDate(rwsMaster.getStatusDate());
					myForm.setStatusDate(rwsMaster.getStatusDate());
					myForm.setContTypes1(rwsMaster.getContTypes1());				
					myForm.setContTypes2(rwsMaster.getContTypes2());
					myForm.setContTypes3(rwsMaster.getContTypes3());
					myForm.setContTypes4(rwsMaster.getContTypes4());
					myForm.setContTypes5(rwsMaster.getContTypes5());						
					session.setAttribute("EditForm", "true");
			}
			if(mode!=null && mode.equals("nssHabs"))
			{					
				ArrayList nssHabs=new ArrayList();
				nssHabs=commonLists.getNssHabs(district);
				session.setAttribute("nssHabs",nssHabs);
				session.setAttribute("selectedDistrictInContaminationDetails",district);
				return mapping.findForward(mode);					
			}
		
			if(mode!=null && mode.equals("view"))
			{
				ArrayList contaminationDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());				
				request.setAttribute("selectedDistrict",districtName);				
				contaminationDetails=rwsHabStatusData.getContaminationDetails(myForm.getDistrict(),getDataSource(request));
				//System.out.println("contaminationDetails sizes is "+contaminationDetails.size());
				session.setAttribute("contaminationDetails",contaminationDetails);
			}
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList contaminationDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String selectedDistrict=(String)session.getAttribute("selectedDistrictInContaminationDetails");
				String districtName=rwsOffices.getDistrictName(selectedDistrict);
				request.setAttribute("districtName",districtName);
				contaminationDetails=rwsHabStatusData.getContaminationDetails(selectedDistrict,getDataSource(request));
				//System.out.println("contaminationDetails sizes is "+contaminationDetails.size());
				session.setAttribute("contaminationDetails",contaminationDetails);
			}
			if(mode!=null && mode.equals("delete"))
			{
				ArrayList contaminationDetails=new ArrayList();
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();				
				String msg=rwsHabStatusData.deleteContaminationDetails(getDataSource(request),request.getParameter("habCode"));
				contaminationDetails=rwsHabStatusData.getContaminationDetails(request.getParameter("habCode").substring(0,2),getDataSource(request));
				//System.out.println("contaminationDetails sizes is "+contaminationDetails.size());
				session.setAttribute("contaminationDetails",contaminationDetails);
				request.setAttribute("message",msg);
			}	
			
			
			if(mode!=null && mode.equals("save"))
			{
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {	
					RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
					RwsMaster rwsMaster=new RwsMaster();
					rwsMaster.setHabCode(myForm.getHabitation());
					rwsMaster.setFlourideContamination(myForm.getFlouride());
					rwsMaster.setBrakishContamination(myForm.getBrakish());
					rwsMaster.setIronContamination(myForm.getIron());
					rwsMaster.setAresenicContamination(myForm.getAresenic());
					rwsMaster.setNitrateContamination(myForm.getNitrate());
					rwsMaster.setStatusDate(RwsMasterData.format(myForm.getStatusDate()));
					/*Debug.println("1:"+myForm.getContTypes1());
					Debug.println("2:"+myForm.getContTypes2());
					Debug.println("3:"+myForm.getContTypes3());
					Debug.println("4:"+myForm.getContTypes4());
					Debug.println("5:"+myForm.getContTypes5());*/
					rwsMaster.setContTypes1(myForm.getContTypes1());
					rwsMaster.setContTypes2(myForm.getContTypes2());
					rwsMaster.setContTypes3(myForm.getContTypes3());
					rwsMaster.setContTypes4(myForm.getContTypes4());
					rwsMaster.setContTypes5(myForm.getContTypes5());
					myForm.setContTypes1(myForm.getContTypes1());
					myForm.setContTypes2(myForm.getContTypes2());
					myForm.setContTypes3(myForm.getContTypes3());
					myForm.setContTypes4(myForm.getContTypes4());
					myForm.setContTypes5(myForm.getContTypes5());
					boolean insertedAll=rwsHabStatusData.insertHabContamination(getDataSource(request),rwsMaster);
					if(insertedAll)
					{
						System.out.println("In Saveeeee");
						request.setAttribute("message","Record Updated Successfully");	
						String EditForm=(String)session.getAttribute("EditForm") ;
						System.out.println("EditForm  "+ EditForm);
						if(EditForm.equals("true"))
							mode="close";
					}else{
						request.setAttribute("message","Record Cannot be Updated");
					    request.setAttribute("mode","contaminationDetailsEdit");
					}
			     }
			}		
		}
		catch(Exception e){
			//System.out.println("Exception in rws_contamination_details_entry_frm is "+e);			
		}
		return mapping.findForward(mode);
		
	}
}
