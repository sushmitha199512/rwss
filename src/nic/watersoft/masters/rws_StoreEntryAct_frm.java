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

public class rws_StoreEntryAct_frm extends Action
{
	
protected ActionForm buildStoreForm(String storeCode,HttpServletRequest request) throws Exception 
{
		StoreForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getStore(storeCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new StoreForm();

				form.setDistrict(rwsMaster.getDistrict());
				form.setMandal(rwsMaster.getMandal());
				form.setSubdivision(rwsMaster.getSubdivision());
				form.setStoreCode(rwsMaster.getStoreCode());
				form.setLocation(rwsMaster.getLocation());
				form.setStoreInCharge(rwsMaster.getStoreInCharge());
				form.setEmpcode(rwsMaster.getEmpcode());
				form.setPostheld(rwsMaster.getPostheld());
				
			}
			return form;
}
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int ans = 0;
		String message=null;
		ArrayList stores=null;
		ArrayList dists=null;
		ArrayList mandals=new ArrayList();
		ArrayList subdivs=new ArrayList();
		ArrayList empcodes=new ArrayList();
		StoreForm frm=(StoreForm) form;
		String mode=frm.getMode();
		RwsOffices rwsOffices = new RwsOffices (getDataSource(request));
		RwsLocations rwsLocations = new RwsLocations (getDataSource(request));
		HttpSession session=request.getSession();
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
				dists=rwsLocation.getDistricts();
				session.setAttribute("dists",dists);
				if(request.getParameter("district")!=null)
				{
					mandals=rwsLocations.getMandals(request.getParameter("district"));
					subdivs=rwsOffices.getDivisions("1",request.getParameter("district"));
				}
				session.setAttribute("mandals",mandals);
				session.setAttribute("subdivs",subdivs);

				request.setAttribute("code",RwsMasterData.getStoreCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}
			try
			{	
				if(request.getParameter("subdivision")!=null)
				{
					empcodes = RwsMasterData.getEmpCodesOnSubDiv(request.getParameter("district"),request.getParameter("subdivision"),getDataSource(request));
				}
				session.setAttribute("empcodes",empcodes);
			}
			catch(Exception e)
			{
				//System.out.println("The empCodes in Stores list"+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				stores=RwsMasterData.getStores(getDataSource(request));
				session.setAttribute("stores",stores);
				
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}
		}
		if(mode.equalsIgnoreCase("save"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
				
				rwsMaster.setDistrict(frm.getDistrict());
				rwsMaster.setMandal(frm.getMandal());
				rwsMaster.setSubdivision(frm.getSubdivision());
				rwsMaster.setStoreCode(frm.getStoreCode());
				rwsMaster.setLocation(frm.getLocation());
				rwsMaster.setStoreInCharge(frm.getStoreInCharge());
				rwsMaster.setEmpcode(frm.getEmpcode());
				rwsMaster.setPostheld(frm.getPostheld());
				
				ans=RwsMasterData.insertStore(rwsMaster,getDataSource(request));
				request.setAttribute("code",RwsMasterData.getStoreCode(getDataSource(request)));
				frm.reset(mapping,request);
				
			}
			catch(Exception e)
			{
				//System.out.println("the error is in Store "+e);
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
				form = buildStoreForm(request.getParameter("storeCode"),request);
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
				//System.out.println("the error is"+e);
			}
		}
		if(mode.equalsIgnoreCase("edit"))
		{
			try
			{
				RwsMaster rwsMaster = new RwsMaster();
						
				rwsMaster.setDistrict(frm.getDistrict());
				rwsMaster.setMandal(frm.getMandal());
				rwsMaster.setSubdivision(frm.getSubdivision());                 
				rwsMaster.setStoreCode(frm.getStoreCode());							
				rwsMaster.setLocation(frm.getLocation());						
				rwsMaster.setStoreInCharge(frm.getStoreInCharge());					
				rwsMaster.setEmpcode(frm.getEmpcode());						
				rwsMaster.setPostheld(frm.getPostheld());
				
				RwsMasterData.updateStore(rwsMaster,getDataSource(request));
				
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e);
			}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				RwsMasterData.removeStore(request.getParameter("storeCode"),getDataSource(request));
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e);
			}
		}
		
		return(mapping.findForward(mode));
	}
}

	