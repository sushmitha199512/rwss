package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_AssetSubCompParamEntryAct_frm extends Action
{
	protected ActionForm buildAssetSubCompTypeForm(String assetTypeCode,String assetCompTypeCode,String assetSubCompTypeCode,HttpServletRequest request) throws Exception 
	{
		AssetSubCompParamForm assetSubCompParamForm = null;
		RwsMaster rwsMaster=RwsMasterData.getAssetSubCompParam(assetTypeCode,assetCompTypeCode,assetSubCompTypeCode,request.getParameter("dimension"),getDataSource(request));
		//System.out.println("Measurement="+request.getParameter("dimension"));
			if(rwsMaster!=null)
			{
				assetSubCompParamForm = new AssetSubCompParamForm();

				assetSubCompParamForm.setAssetTypeCode(rwsMaster.getAssetTypeCode()+" "+rwsMaster.getAssetTypeName());
				assetSubCompParamForm.setAssetCompTypeCode(rwsMaster.getAssetCompTypeCode()+" "+rwsMaster.getAssetCompTypeName());
				assetSubCompParamForm.setAssetSubCompTypeCode(rwsMaster.getAssetSubCompTypeCode()+" "+rwsMaster.getAssetSubCompTypeName());
				assetSubCompParamForm.setMeasurementType(request.getParameter("dimension"));
				assetSubCompParamForm.setUnitOfMeasure(rwsMaster.getUom());
				
			}
			return assetSubCompParamForm;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList assetSubCompParams=new ArrayList();
		ArrayList assetSubCompTypes=new ArrayList();
		ArrayList assetTypes=new ArrayList();
		ArrayList assetCompTypes=new ArrayList();
		
		AssetSubCompParamForm assetSubCompParamForm=(AssetSubCompParamForm) form;
		String mode=assetSubCompParamForm.getMode();
		HttpSession session=request.getSession();
		RwsMaster rwsMaster = new RwsMaster();
		CommonLists commonLists = new CommonLists(getDataSource(request));
		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				assetTypes=commonLists.getAssetTypes();
				session.setAttribute("assetTypes",assetTypes);
				if(request.getParameter("assetTypeCode")!=null)
				{
					assetCompTypes=commonLists.getAssetComponents(request.getParameter("assetTypeCode"));
				}
				session.setAttribute("assetCompTypes",assetCompTypes);
				if(request.getParameter("assetCompTypeCode")!=null)
				{
					assetSubCompTypes=commonLists.getAssetSubComponents(request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"));
				}
				session.setAttribute("assetSubCompTypes",assetSubCompTypes);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_AssetSubCompTypeEntryAct_assetSubCompParamForm in data is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				String typeOfAsset=assetSubCompParamForm.getAssetTypeCode();
				String assetComp=assetSubCompParamForm.getAssetCompTypeCode();
				String assetSubComp=assetSubCompParamForm.getAssetSubCompTypeCode();
				if(typeOfAsset.indexOf(" ")!=-1)
					typeOfAsset=typeOfAsset.substring(0,2);
				if(assetComp.indexOf(" ")!=-1)
					assetComp=assetComp.substring(0,2);
				if(assetSubComp.indexOf(" ")!=-1)
					assetSubComp=assetSubComp.substring(0,3);
				//System.out.println("asset type="+typeOfAsset+"Asset Comp="+assetComp+"Asset SubComp="+assetSubComp);
			assetSubCompParams=RwsMasterData.getAssetSubCompParmas(typeOfAsset,assetComp,assetSubComp,getDataSource(request));
			session.setAttribute("assetSubCompParams",assetSubCompParams);
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_AssetSubCompTypeEntryAct_assetSubCompParamForm in view is "+e);
			}
		}
		
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
									
				rwsMaster.setAssetTypeCode(assetSubCompParamForm.getAssetTypeCode());
				rwsMaster.setAssetCompTypeCode(assetSubCompParamForm.getAssetCompTypeCode());
				rwsMaster.setAssetSubCompTypeCode(assetSubCompParamForm.getAssetSubCompTypeCode());
				rwsMaster.setDimension(assetSubCompParamForm.getMeasurementType());
				rwsMaster.setUom(assetSubCompParamForm.getUnitOfMeasure());
				
				
				ans=RwsMasterData.insertAssetSubCompParam(rwsMaster,getDataSource(request));
				assetSubCompParamForm.reset(mapping,request);
				
			}
			catch(Exception e)
			{
				System.err.println("The error in rws_assetSubCompParamForm_frm in insert is "+e);
			}
			if(ans <1)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("get"))
		{
			try 
			{
				form = buildAssetSubCompTypeForm(request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),request.getParameter("assetSubCompTypeCode"),request);
				if ("request".equalsIgnoreCase(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_AssetSubCompTypeEntryAct_assetSubCompParamForm in get is "+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				rwsMaster.setAssetTypeCode(assetSubCompParamForm.getAssetTypeCode().substring(0,assetSubCompParamForm.getAssetTypeCode().indexOf(" ")));
				rwsMaster.setAssetCompTypeCode(assetSubCompParamForm.getAssetCompTypeCode().substring(0,assetSubCompParamForm.getAssetCompTypeCode().indexOf(" ")));
				rwsMaster.setAssetSubCompTypeCode(assetSubCompParamForm.getAssetSubCompTypeCode().substring(0,assetSubCompParamForm.getAssetSubCompTypeCode().indexOf(" ")));
				rwsMaster.setDimension(assetSubCompParamForm.getMeasurementType());
				rwsMaster.setUom(assetSubCompParamForm.getUnitOfMeasure());
				
				RwsMasterData.updateAssetSubCompParam(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_AssetSubCompTypeEntryAct_assetSubCompParamForm in edit is "+e);
			}
			
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				ans=RwsMasterData.removeAssetSubCompParam(request.getParameter("assetTypeCode"),request.getParameter("assetCompTypeCode"),request.getParameter("assetSubCompTypeCode"),request.getParameter("dimension"),getDataSource(request));
				if(ans>0)
				{
					displaymess = "Data deleted Succesfully";
				}
				else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				System.err.println("The error in rws_AssetSubCompTypeEntryAct_assetSubCompParamForm in delete is "+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
