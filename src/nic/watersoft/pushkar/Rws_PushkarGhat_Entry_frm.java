package nic.watersoft.pushkar;



import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.*;

public class Rws_PushkarGhat_Entry_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String mode="";
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
			
		}
		else
			mode="pushkarEntryFrm";
		PushkarGhatForm myForm=(PushkarGhatForm)form;
		boolean init = true;
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList pushkartype1=new ArrayList();
		HttpSession session=request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		final String userId=user.getOfficeCode();
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		
		String district=myForm.getDistrict();
		
		
		try{
			
			
			
			if(init)
			{
				
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				
				districts = rwsPushkarDAO.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				session.setAttribute("panchayats",panchayats);
				
				
				session.setAttribute("pushkartype1",pushkartype1);
				
			}
			
			if(district == null || district.equals("")){
				district = user.getCircleOfficeCode();
				String dname=rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
			}
			
			
			
			if(mode!=null && mode.equals("mandals"))
			{
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				
			}
			if(mode!=null && mode.equals("panchayats"))
			{
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				
			}
			
				
				
				
			
			
			
			if(mode!=null && mode.equals("view"))
			{
				ArrayList villageDetails;
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
				String panchayatName=rwsOffices.getPanchayatName(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat());
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				villageDetails=rwsPushkarDAO.getpushkarDetails(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat(),myForm.getPushkartype(),getDataSource(request));
				
				session.setAttribute("villageDetails",villageDetails);
			}
			
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList villageDetails;
				
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				String panchayatName=rwsOffices.getPanchayatName(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				villageDetails=rwsPushkarDAO.getpushkarDetails(myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat(),myForm.getPushkartype(),getDataSource(request));
				
				session.setAttribute("villageDetails",villageDetails);
			}
			
			if(mode!=null && mode.equals("pushkarEdit"))
			{
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals",mandals);
				myForm.setPanchayat(request.getParameter("pcode"));
				panchayats=rwsOffices.getPanchayats(request.getParameter("dcode"),request.getParameter("mcode"));
				session.setAttribute("panchayats",panchayats);
				
				
				request.setAttribute("pcode",request.getParameter("pcode"));
				request.setAttribute("vcode",request.getParameter("vcode"));
				request.setAttribute("vname",request.getParameter("vname"));
				String typ=request.getParameter("pushkartype");
				
				request.setAttribute("pushkartype",request.getParameter("pushkartype"));
				String vname=rwsPushkarDAO.getpushkarName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"),request.getParameter("vname"),request.getParameter("pushkartype"));
				
				myForm.setVname(vname);
				
				request.setAttribute("mode","pushkarEdit");
				
			}
			
			if(mode!=null && mode.equals("save"))
			{
				
				
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
			    	System.out.println("inside save");
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				
				panchayats=rwsOffices.getPanchayats(district,myForm.getMandal());
				session.setAttribute("panchayats",panchayats);
				int rcount=rwsPushkarDAO.insertPushkar(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPcode(),myForm.getVcode(),myForm.getVname(),myForm.getPushkartype());
					if(rcount>0)
					{
						
						request.setAttribute("message","Record Updated Successfully");
						
						mode="close";
						
					}
					else
					{
						request.setAttribute("message","Record Cannot be Updated");
					request.setAttribute("mode","villageEdit");
					}
				
			    }
			}
			if(mode!=null && mode.equals("saveNew"))
			{
				
				
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				myForm.setDistrict(request.getParameter("district"));
				myForm.setPanchayat(request.getParameter("pcode"));
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				
				panchayats=rwsOffices.getPanchayats(request.getParameter("district"),request.getParameter("mandal"));
				session.setAttribute("panchayats",panchayats);
				myForm.setPanchayat(myForm.getPanchayat());
				
					String msg=rwsPushkarDAO.insertNewPushkar(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPcode(),myForm.getVcode(),myForm.getVname(),myForm.getPushkartype());
					
					request.setAttribute("message",msg);
					
					request.setAttribute("mode","villageNew");
			    }
				
			}
			if(mode!=null && mode.equals("delete"))
			{
				
				ArrayList villageDetails;
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				String panchayatName=rwsOffices.getPanchayatName(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				request.setAttribute("selectedPanchayat",panchayatName);
				String pushkartype=request.getParameter("pushkartype");
				if(request.getParameter("pushkartype").equals("A ")){
					pushkartype="A+";
				}
				
					String msg=rwsPushkarDAO.deletePushkar(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),request.getParameter("vcode"),pushkartype);
					villageDetails=rwsPushkarDAO.getpushkarDetails(request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"),pushkartype,getDataSource(request));
					
					session.setAttribute("villageDetails",villageDetails);
					request.setAttribute("message",msg);
				}
				
			if(mode!=null && mode.equals("addNew"))
			{
				
				RwsPushkarDAO rwsPushkarDAO=new RwsPushkarDAO();
				
				myForm.setDistrict(request.getParameter("district"));
				
				myForm.setMandal(request.getParameter("mandal"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals",mandals);
				
				myForm.setPanchayat(request.getParameter("panchayat"));
				panchayats=rwsOffices.getPanchayats(district,request.getParameter("mandal"));
				session.setAttribute("panchayats",panchayats);
				
				request.setAttribute("acode",rwsPushkarDAO.getContamCode(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPanchayat()));
				
				request.setAttribute("mode","pushkarGhatNew");
					
				
			}
			
			
		}
		catch(Exception e){
			e.printStackTrace();
			Debug.println("Exception in Rws_PushkarGhat_Entry_frm is "+e);
			
		}
		return mapping.findForward(mode);
		
	}
	
	
}
