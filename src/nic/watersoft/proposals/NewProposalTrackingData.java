package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;

import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewProposalTrackingData extends Action 
{
	private DataSource dataSource;

	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		dataSource = getDataSource(request);
		CommonLists commonLists = new CommonLists(dataSource);
		RwsLocations rwsLocations=new RwsLocations(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		String assetCode=null;
		String financialYear=null;
		String district=null;
		String mandal=null;
		String panchayat=null;
		String village=null;
		String habCode=null;
		String repCode=null;
		
		ArrayList financialYears = proposalDAO.getProposalYears();
		ArrayList districts=rwsLocations.getDistricts();
		ArrayList mandals=new ArrayList();
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList prhabs=new ArrayList();
		ArrayList representatives=new ArrayList();
		request.setAttribute("financialYears", financialYears);
		request.setAttribute("districts",districts);
		request.removeAttribute("mandals");
		request.removeAttribute("panchayats");
		request.removeAttribute("villages");
		request.removeAttribute("prhabs");
		request.removeAttribute("representatives");
		ArrayList assetTypes = commonLists.getAssetTypes();
		request.setAttribute("assetTypes", assetTypes);
		ProposalForm myForm = (ProposalForm)form;
		if(myForm != null)
		{
			assetCode = myForm.getAssetCode();
			financialYear = myForm.getFinancialYear();
			district=myForm.getDistrict();
			mandal=myForm.getMandal();
			panchayat=myForm.getPanchayat();
			village=myForm.getVillage();
			habCode=myForm.getHabCode();
			repCode=myForm.getRepCode();
			if(district!=null && district.length()!=0){
				mandals=rwsLocations.getMandals(district);
				representatives=commonLists.getRepresentatives(); 
			}		
			if(district!=null && district.length()!=0 && mandal!=null && mandal.length()!=0)
				panchayats=rwsLocations.getPanchayats(district,mandal);
			if(district!=null && mandal!=null && panchayat!=null && district.length()!=0 && mandal.length()!=0 && panchayat.length()!=0)
				villages=rwsLocations.getVillages(district,mandal,panchayat);
			if(district!=null && mandal!=null && panchayat!=null && village!=null && district.length()!=0 && mandal.length()!=0 && panchayat.length()!=0 && village.length()!=0){
				prhabs=rwsLocations.getHabs(district,mandal,panchayat,village);
			 	 
			}	
			
			if(assetCode != null && financialYear != null && district!=null && mandal!=null && panchayat!=null && village!=null && habCode!=null && district.length()!=0)
			{
				ArrayList proposalIds = commonLists.getProposalIds(assetCode, financialYear,district,mandal,panchayat,village,habCode,repCode);
				if(proposalIds.size() > 0)
				  request.setAttribute("proposalIds", proposalIds);
				else
					myForm.setProposalId("");
			}
		}
		request.setAttribute("mandals",mandals);
		request.setAttribute("panchayats",panchayats);
		request.setAttribute("villages",villages);
		request.setAttribute("prhabs",prhabs);
		request.setAttribute("representatives",representatives);
		return mapping.findForward("success");
	}
}
