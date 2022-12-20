package nic.watersoft.masters;
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

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class rws_panchayat_entry_frm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String mode="";
		if(request.getParameter("mode")!=null)
		{
			mode=request.getParameter("mode");
			//Debug.println("mode is "+mode);
		}
		else
			mode="panchayatEntryFrm";
		HabStatusForm myForm=(HabStatusForm)form;
		boolean init = true;
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		HttpSession session=request.getSession();
		
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		final String userId=user.getOfficeCode();
		String district=myForm.getDistrict();
		try{
			
			
			if(init)
			{
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts",districts);
				session.setAttribute("mandals",mandals);
				
			}
			
			if(district == null || district.equals(""))
			{
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
			if(mode!=null && mode.equals("view"))
			{
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName=rwsOffices.getMandalName(myForm.getDistrict(),myForm.getMandal());
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				panchayatDetails=rwsHabStatusData.getPanchayatDetails(myForm.getDistrict(),myForm.getMandal(),getDataSource(request));
				//Debug.println("panchayatDetails sizes is "+panchayatDetails.size());
				session.setAttribute("panchayatDetails",panchayatDetails);
			}
			if(mode!=null && mode.equals("excelView"))
			{
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				panchayatDetails=rwsHabStatusData.getPanchayatDetails(request.getParameter("dcode"),request.getParameter("mcode"),getDataSource(request));
				session.setAttribute("panchayatDetails",panchayatDetails);
			}
			/*
			 if(mode!=null && mode.equals("excelView"))
			 {
			 ArrayList panchayatDetails;
			 RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
			 String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
			 String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
			 request.setAttribute("selectedDistrict",districtName);
			 request.setAttribute("selectedMandal",mandalName);
			 panchayatDetails=rwsHabStatusData.getPanchayatDetails(myForm.getDistrict(),myForm.getMandal(),getDataSource(request));
			 Debug.println("panchayatDetails sizes is "+panchayatDetails.size());
			 session.setAttribute("panchayatDetails",panchayatDetails);
			 }
			 */
			if(mode!=null && mode.equals("panchayatEdit"))
			{
				
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals",mandals);
				
				request.setAttribute("pcode",request.getParameter("pcode"));
				String pname=rwsOffices.getPanchayatName(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
				myForm.setPname(pname);
				request.setAttribute("mode","panchayatEdit");
				
			}
			
			if(mode!=null && mode.equals("save"))
			{
				
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				{
					int rcount=rwsHabStatusData.insertPanchayat(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPcode(),myForm.getPname());
					if(rcount>0)
					{
						request.setAttribute("message","Record Updated Successfully");
					mode="view";
					}
					else
					{
						request.setAttribute("message","Record Cannot be Updated");
					request.setAttribute("mode","panchayatEdit");
					}
				}
				else
				{
					request.setAttribute("message","Request cannot be processed as records have been freezed");
				}
			}
			if(mode!=null && mode.equals("saveNew"))
			{
				
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				myForm.setDistrict(request.getParameter("district"));
				mandals=rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals",mandals);
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				{
					String msg=rwsHabStatusData.insertNewPanchayat(getDataSource(request),myForm.getDistrict(),myForm.getMandal(),myForm.getPcode(),myForm.getPname());
					
					request.setAttribute("message",msg);
					
					request.setAttribute("mode","panchayatNew");
				}
				else
				{
					request.setAttribute("message","Request cannot be processed as records have been freezed");
				}
			}
			if(mode!=null && mode.equals("delete"))
			{
				
				ArrayList panchayatDetails;
				RwsHabStatusData rwsHabStatusData=new RwsHabStatusData();
				
				String districtName=rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName=rwsOffices.getMandalName(request.getParameter("dcode"),request.getParameter("mcode"));
				request.setAttribute("selectedDistrict",districtName);
				request.setAttribute("selectedMandal",mandalName);
				
				if(RwsMasterData.validateUserForPanVilHabEntry(rwsOffices,userId))
				{
					String msg=rwsHabStatusData.deletePanchayat(getDataSource(request),request.getParameter("dcode"),request.getParameter("mcode"),request.getParameter("pcode"));
					panchayatDetails=rwsHabStatusData.getPanchayatDetails(request.getParameter("dcode"),request.getParameter("mcode"),getDataSource(request));
					session.setAttribute("panchayatDetails",panchayatDetails);
					request.setAttribute("message",msg);
				}
				else
				{
					request.setAttribute("message","Request cannot be processed as records have been freezed");
					
				}
			}
			if(mode!=null && mode.equals("addNew"))
			{
				myForm.setDistrict(request.getParameter("district"));
				myForm.setMandal(request.getParameter("mandal"));
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals",mandals);
				
					request.setAttribute("mode","panchayatNew");
			}
			
		}
		catch(Exception e){
			Debug.println("Exception in rws_panchayat_entry_frm is "+e);
			
		}
		return mapping.findForward(mode);
		
	}
}
