package nic.watersoft.wquality;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RWS_WQ_ContaminatedHabs_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RWS_WQ_ContaminatedHabs_FormBeam myForm=(RWS_WQ_ContaminatedHabs_FormBeam)form;
		//System.out.println("inside action ........");
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
			Debug.println("mode is " + mode);
		} else {
			mode = "contaminatedEntryFrm";
		}
		
		ArrayList districts = new ArrayList();
		/*ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();*/
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		final String userId = user.getUserId();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		RWS_WQ_ContaminatedHabs_DAO contaminatedHabs_DAO=new RWS_WQ_ContaminatedHabs_DAO();
		try {

			if (mode != null && mode.equals("init")) {
				
				reset(myForm);
				mode="contaminatedEntryFrm";
			
			}
			
			if (mode != null && mode.equals("contaminatedHabsView")) {
				ArrayList contaminatedHabsView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedHabsView=contaminatedHabs_DAO.getContaminatedHabDetails(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedHabsView.size());
				session.setAttribute("contaminatedHabsView", contaminatedHabsView);
				
			}
			if (mode != null && mode.equals("contaminatedSources")) {
				ArrayList ContaminatedDetails = new ArrayList();
				String dcode = request.getParameter("district");
				String financialYear1=request.getParameter("financialYear");
				String[] ar=financialYear1.split("/");
				String yearStart=ar[0];
				String yearEnd=ar[1];
				String financialYear=ar[2];
				session.setAttribute("financialYear",financialYear);
				session.setAttribute("financialYear1", financialYear1);
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				ContaminatedDetails=contaminatedHabs_DAO.getContaminatedDetailsCount(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ ContaminatedDetails.size());
				session.setAttribute("ContaminatedDetails", ContaminatedDetails);
				
			}
			if (mode != null && mode.equals("contaminatedSourcesView")) {
				ArrayList contaminatedSourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedSourcesView=contaminatedHabs_DAO.getContaminatedHabsList(dcode, yearStart, yearEnd,financialYear);
				System.out.println("contaminatedHabView---"+contaminatedSourcesView.size());
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedSourcesView.size());
				session.setAttribute("contaminatedSourcesView", contaminatedSourcesView);
				
			}
			if (mode != null && mode.equals("contaminatedTdsSourcesView")) {
				ArrayList contaminatedTdsSourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				session.setAttribute("parameters", "TDS");
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedTdsSourcesView=contaminatedHabs_DAO.getContaminatedTdsHabsList(dcode, yearStart, yearEnd,financialYear);
				System.out.println(contaminatedTdsSourcesView.size());
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedTdsSourcesView.size());
				session.setAttribute("contaminatedTdsSourcesView", contaminatedTdsSourcesView);
				
			}
			if (mode != null && mode.equals("contaminatedFlourideSourcesView")) {
				ArrayList contaminatedFlourideSourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				session.setAttribute("parameters", "FLOURIDE");
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedFlourideSourcesView=contaminatedHabs_DAO.getContaminatedFlourideHabsList(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedFlourideSourcesView.size());
				session.setAttribute("contaminatedFlourideSourcesView", contaminatedFlourideSourcesView);
				
			}
			if (mode != null && mode.equals("contaminatedIronSourcesView")) {
				ArrayList contaminatedIronSourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				session.setAttribute("parameters", "IRON");
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedIronSourcesView=contaminatedHabs_DAO.getContaminatedIronHabsList(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedIronSourcesView.size());
				session.setAttribute("contaminatedIronSourcesView", contaminatedIronSourcesView);
				
			}
			if (mode != null && mode.equals("contaminatedSelinitySourcesView")) {
				ArrayList contaminatedSelinitySourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				session.setAttribute("parameters", "SALINITY");
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedSelinitySourcesView=contaminatedHabs_DAO.getContaminatedSelinityHabsList(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedSelinitySourcesView.size());
				session.setAttribute("contaminatedSelinitySourcesView", contaminatedSelinitySourcesView);
				
			}
			if (mode != null && mode.equals("contaminatedNitrateSourcesView")) {
				ArrayList contaminatedNitrateSourcesView = new ArrayList();
				String dcode = request.getParameter("dcode");
				String dname = request.getParameter("dname");
				session.setAttribute("dname", dname);
				session.setAttribute("parameters", "NITRATE");
				String fy=(String)session.getAttribute("financialYear1");
				String tdsfy[]=fy.split("/");
				String yearStart = tdsfy[0];
				String yearEnd = tdsfy[1];
				String financialYear = tdsfy[2];
				String districtName = rwsOffices.getDistrictName(myForm
						.getDistrict());
				request.setAttribute("selectedDistrict", districtName);
				contaminatedNitrateSourcesView=contaminatedHabs_DAO.getContaminatedNitrateHabsList(dcode, yearStart, yearEnd,financialYear);
				Debug.println("ContaminatedDetails sizes is "
						+ contaminatedNitrateSourcesView.size());
				session.setAttribute("contaminatedNitrateSourcesView", contaminatedNitrateSourcesView);
				
			}
			
		} catch (Exception e) {
			Debug.println("Exception in RWS_WQ_ContaminatedHabs_Action " + e);

		}
		return mapping.findForward(mode);
	
	}



	private void reset(RWS_WQ_ContaminatedHabs_FormBeam myForm) {
		// TODO Auto-generated method stub
		
	}
}
