package nic.watersoft.masters;

import java.io.IOException;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_ConversionOfScheme_EntryAct_frm extends Action
{		
	int[] rcount;
	rws_ConversionOfScheme_EntryAct_DAO conversionOfSchemes=null;
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws Exception
	{
		Connection conn = null;
		Statement stmt = null;
		int ans = 0;
		String message=null;
		ArrayList dists=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchyats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList habitations=new ArrayList();
		ArrayList SchemesFrom=new ArrayList();
		ArrayList prhabs=new ArrayList();
		Collection panchRajs = new ArrayList();
		ArrayList SchemesTo=new ArrayList();
		HttpSession session=request.getSession();
		RwsMaster rwsMaster = new RwsMaster();
		RwsLocationBean rwsLocationBean = new RwsLocationBean();
		PanchRaj panchRaj = new PanchRaj();
		ConverstionOfSchemeForm panchRajForm = (ConverstionOfSchemeForm) form;
		String mode=panchRajForm.getMode();
		conversionOfSchemes= new rws_ConversionOfScheme_EntryAct_DAO(getDataSource(request));
		if(mode.equalsIgnoreCase("data"))
		{
				dists=conversionOfSchemes.getDistricts();
				session.setAttribute("dists",dists);
				if(request.getParameter("district")!=null)
				{
					if(!(request.getParameter("district")).equalsIgnoreCase("0"))
					{
						mandals=conversionOfSchemes.getMandals(request.getParameter("district"));
					}
				}
				session.setAttribute("mandals",mandals);
				if(request.getParameter("mandal")!=null)
				{
					if(!(request.getParameter("mandal")).equalsIgnoreCase("0"))
					{
						panchyats=conversionOfSchemes.getPanchayats(request.getParameter("district"),request.getParameter("mandal"));
					}
				}
				session.setAttribute("panchyats",panchyats);
				if(request.getParameter("pcode")!=null)
				{
					if(!(request.getParameter("pcode")).equalsIgnoreCase("0"))
					{
						villages = conversionOfSchemes.getVillages(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"));
					}
				}
				session.setAttribute("villages",villages);
				if(request.getParameter("pcode")!=null)
				{
					if(request.getParameter("vcode").length()!=0)
					{
						habitations = conversionOfSchemes.getHabitations(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"),request.getParameter("vcode"),getDataSource(request));
					}
				}
				session.setAttribute("habitations",habitations);
				String assetCode=request.getParameter("assetCode");
				String assetName=request.getParameter("assetName");
				if(assetCode!=null  && assetName!=null)
				{
					panchRajForm.setAssetCode(assetCode);
					panchRajForm.setAssetName(assetName);
					SchemesTo=conversionOfSchemes.getConvertFromSchemeDetails(assetCode.substring(6,8));
				}
				session.setAttribute("SchemesTo", SchemesTo);
			}
		if(mode!=null && mode.equalsIgnoreCase("update"))
		{
			RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
			String assetcode=request.getParameter("assetcode");
			String Schemetypechanged2=request.getParameter("asch2");
			System.out.println("Old Asset Code is Egr @@@@ "+assetcode);
		    String newassetCode = conversionOfSchemes.getNewAssetCode(assetcode,Schemetypechanged2,getDataSource(request));
		    System.out.println("Final Asset Code is EGR @@@@@@@"+newassetCode);
			RwsMaster rwsMasters=null;
			conversionOfSchemes.updateAssetCode(panchRajForm,assetcode,newassetCode,request);
		  	mode="data";
		}
		
		return(mapping.findForward(mode));
	}
}
		