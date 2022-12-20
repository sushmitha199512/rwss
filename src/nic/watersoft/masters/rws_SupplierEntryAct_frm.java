package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_SupplierEntryAct_frm extends Action
{
	protected ActionForm buildSupplierForm(String supplierCode,HttpServletRequest request) throws Exception 
	{
		SupplierForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getSupplier(supplierCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new SupplierForm();

				form.setSupplierCode(rwsMaster.getSupplierCode());
				form.setSupplierName(rwsMaster.getSupplierName());
				form.setLocation(rwsMaster.getLocation());
				form.setAddress(rwsMaster.getAddress());
				form.setArea(rwsMaster.getArea());
				form.setCity(rwsMaster.getCity());
				form.setPin(rwsMaster.getPin());
				form.setPhone(rwsMaster.getPhone());
				form.setFax(rwsMaster.getFax());
				form.setEmail(rwsMaster.getEmail());
				form.setSupplierRegNo(rwsMaster.getSupplierRegNo());
				
			}
			return form;
	}

	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		ArrayList suppliers=null;
		SupplierForm frm=(SupplierForm) form;
		String mode=frm.getMode();
		HttpSession session=request.getSession();
		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				request.setAttribute("code",RwsMasterData.getSupplierCode(getDataSource(request)));
			}
			catch(Exception e)
			{
				//System.out.println(e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
			suppliers=RwsMasterData.getSuppliers(getDataSource(request));
			session.setAttribute("suppliers",suppliers);
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
						
				rwsMaster.setSupplierCode(frm.getSupplierCode());
				rwsMaster.setSupplierName(frm.getSupplierName());
				rwsMaster.setLocation(frm.getLocation());
				rwsMaster.setAddress(frm.getAddress());
				rwsMaster.setArea(frm.getArea());
				rwsMaster.setCity(frm.getCity());
				rwsMaster.setPin(frm.getPin());
				rwsMaster.setPhone(frm.getPhone());
				rwsMaster.setFax(frm.getFax());
				rwsMaster.setEmail(frm.getEmail());
				rwsMaster.setSupplierRegNo(frm.getSupplierRegNo());
				
				ans=RwsMasterData.insertSupplier(rwsMaster,getDataSource(request));
				request.setAttribute("code",RwsMasterData.getSupplierCode(getDataSource(request)));
				frm.reset(mapping,request);
				
			}
			catch(Exception e)
			{
				//System.out.println("the error is"+e);
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
				form = buildSupplierForm(request.getParameter("supplierCode"),request);
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
				
		
				rwsMaster.setSupplierCode(frm.getSupplierCode());
				rwsMaster.setSupplierName(frm.getSupplierName());
				rwsMaster.setLocation(frm.getLocation());
				rwsMaster.setAddress(frm.getAddress());
				rwsMaster.setArea(frm.getArea());
				rwsMaster.setCity(frm.getCity());
				rwsMaster.setPin(frm.getPin());
				rwsMaster.setPhone(frm.getPhone());
				rwsMaster.setFax(frm.getFax());
				rwsMaster.setEmail(frm.getEmail());
				rwsMaster.setSupplierRegNo(frm.getSupplierRegNo());

				RwsMasterData.updateSupplier(rwsMaster,getDataSource(request));
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
				RwsMasterData.removeSupplier(request.getParameter("supplierCode"),getDataSource(request));
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e);
			}
		}
		return(mapping.findForward(mode));
	}
}
