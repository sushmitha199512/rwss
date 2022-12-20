package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsActionData extends Action
{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		String target=new String("success");

		ArrayList dists=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList panchyats=new ArrayList();
		ArrayList villages=new ArrayList();
		ArrayList circles=new ArrayList();
		ArrayList habs=new ArrayList();
		ArrayList prhabs=new ArrayList();
		ArrayList assetTypes=new ArrayList();
		ArrayList srcAssets=new ArrayList();
		ArrayList srcAssets1=new ArrayList();
		ArrayList sourceTypeCodes=new ArrayList();
		ArrayList subSourceTypeCodes=new ArrayList();
		ArrayList assethabs=new ArrayList();
		
		HttpSession session=request.getSession();
		
		RwsOffices rwsOffices = new RwsOffices (getDataSource(request));
		RwsLocations rwsLocations = new RwsLocations (getDataSource(request));
		
		try
		{
			dists=rwsLocations.getDistricts();
			session.setAttribute("dists",dists);
		}
		catch(Exception e)
		{
			//System.out.println("The dists in Rws action data"+e);
		}
		try
		{
			if(request.getParameter("district")!=null)
			{
				mandals=rwsLocations.getMandals(request.getParameter("district"));
			}
			session.setAttribute("mandals",mandals);
		}
		catch(Exception e)
		{
			//System.out.println("The mandals in Rws action data"+e);
		}		
		try
		{
			if(request.getParameter("mandal")!=null)
			{
				panchyats=rwsLocations.getPanchayats(request.getParameter("district"),request.getParameter("mandal"));
			}
			session.setAttribute("panchyats",panchyats);
		}
		catch(Exception e)
		{
			//System.out.println("The panchyats in Rws action data"+e);
		}
		try
		{
			if(request.getParameter("pcode")!=null)
			{
				villages = rwsLocations.getVillages(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"));
			}
			session.setAttribute("villages",villages);
		}
		catch(Exception e)
		{
			//System.out.println("The villages in Rws action data"+e);
		}
		try
		{
			if(request.getParameter("vcode")!=null)
			{
				habs = rwsLocations.getHabitations(request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"),request.getParameter("vcode"));
			}
			session.setAttribute("habs",habs);
		}
		catch(Exception e)
		{
			//System.out.println("The habs in Rws action data"+e);
		}
		/*try
		{
			if(request.getParameter("vcode")!=null)
			{
				prhabs = RwsMasterData.getPRHabitations(getDataSource(request),request.getParameter("district"),request.getParameter("mandal"),request.getParameter("pcode"),request.getParameter("vcode"));
			}
			session.setAttribute("prhabs",prhabs);
		}
		catch(Exception e)
		{
			//System.out.println("The habs in Rws action data"+e);
		}*/
		try
		{
			sourceTypeCodes=RwsMasterData.getSourceTypes(getDataSource(request));
			session.setAttribute("sourceTypeCodes",sourceTypeCodes);
		}
		catch(Exception e)
		{
			//System.out.println("The sourceTypeCodes in Rws action data"+e);
		}
		try
		{
			if(request.getParameter("sourceTypeCode")!=null)
			{
				//System.out.println("sourceTypeCode= "+request.getParameter("sourceTypeCode")+"**");
				subSourceTypeCodes=RwsMasterData.getSubSourceTypeCodes(request.getParameter("sourceTypeCode"),getDataSource(request));
				if(request.getParameter("sourceTypeCode").equals("1"))
				{
					target="fetch";
				}
			}
		session.setAttribute("subSourceTypeCodes",subSourceTypeCodes);
		}
		catch(Exception e)
		{
			//System.out.println("The subSourceTypeCodes in Rws action data"+e);
		}
		
		try
		{
			request.setAttribute("scode",RwsMasterData.getSourceCode(getDataSource(request)));
		}
		catch(Exception e)
		{
			//System.out.println("The scode in Rws action data"+e);
		}
		try
		{
			if(request.getParameter("sourceName")!=null)
			{
				request.setAttribute("sourceName",request.getParameter("sourceName"));
			}
		}
		catch(Exception e)
		{
			//System.out.println("The sourceName in Rws action data"+e);
		}
		try
		{
			assetTypes=RwsMasterData.getAssetTypes(getDataSource(request));
			session.setAttribute("assetTypes",assetTypes);
		}
		catch(Exception e)
		{
			//System.out.println("The assetTypes in asset action data"+e);
		}
		try
		{
			request.setAttribute("acode",RwsMasterData.getAssetCode(request.getParameter("coc"),request.getParameter("doc"),request.getParameter("sdoc"),request.getParameter("habCode"),request.getParameter("assetTypeCode"),getDataSource(request)));
		}
		catch(Exception e)
		{
			//System.out.println("The acode in asset action data"+e);
		}
		
		try
		{
			if(request.getParameter("assetName")!=null)
			{
				request.setAttribute("assetName",request.getParameter("assetName"));
			}
			if(request.getParameter("dateofCreation")!=null)
			{
				request.setAttribute("dateofCreation",request.getParameter("dateofCreation"));
			}
			if(request.getParameter("yield")!=null)
			{
				request.setAttribute("yield",request.getParameter("yield"));
			}
			if(request.getParameter("pumpingHours")!=null)
			{
				request.setAttribute("pumpingHours",request.getParameter("pumpingHours"));
			}
			if(request.getParameter("assetCost")!=null)
			{
				request.setAttribute("assetCost",request.getParameter("assetCost"));
			}
			if(request.getParameter("startYear")!=null)
			{
				request.setAttribute("startYear",request.getParameter("startYear"));
			}
			if(request.getParameter("endYear")!=null)
			{
				request.setAttribute("endYear",request.getParameter("endYear"));
			}
		}
		catch(Exception e)
		{
			//System.out.println("the error in empname"+e);
		}
		
		try
		{
			if(request.getParameter("district")!=null && request.getParameter("mandal")!=null)
			{
				assethabs = RwsMasterData.getAssetHabs(getDataSource(request),request.getParameter("district"),request.getParameter("mandal"));
				
			}
			request.setAttribute("assethabs",assethabs);
		}
		catch(Exception e)
		{
			//System.out.println("The habs in Rws action data"+e);
		}
		//System.out.println("target in rwsAction is"+target);
	return (mapping.findForward(target));
	}
}
