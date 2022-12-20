package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_ItemMasterEntryAct_frm extends Action
{
	protected ActionForm buildItemForm(String itemCode,HttpServletRequest request) throws Exception 
	{
		ItemForm form = null;
		RwsMaster rwsMaster=RwsMasterData.getItem(itemCode,getDataSource(request));
		
			if(rwsMaster!=null)
			{
				form = new ItemForm();

				form.setItemCode(rwsMaster.getItemCode());
				form.setItemName(rwsMaster.getItemName());
				form.setDistCode(rwsMaster.getDistCode());
				form.setFinyear(rwsMaster.getFinyear());
				form.setUnits(rwsMaster.getUnits());
				form.setRate(rwsMaster.getRate());
				
			}
			return form;
	}


public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		int ans = 0;
		String message=null;
		ArrayList items=null;
		ArrayList dists=null;
		HttpSession session=request.getSession();
		ItemForm frm=(ItemForm) form;
		String mode=frm.getMode();
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{	
				RwsLocations rwsLocation = new RwsLocations(getDataSource(request));
				dists=rwsLocation.getDistricts();
				session.setAttribute("dists",dists);
				request.setAttribute("code",RwsMasterData.getItemCode(getDataSource(request)));
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
				items=RwsMasterData.getItems(getDataSource(request));
				session.setAttribute("items",items);
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
										
				rwsMaster.setItemCode(frm.getItemCode());
				rwsMaster.setItemName(frm.getItemName());
				rwsMaster.setDistCode(frm.getDistCode());
				rwsMaster.setFinyear(frm.getFinyear());
				rwsMaster.setUnits(frm.getUnits());
				rwsMaster.setRate(frm.getRate());
				
				ans=RwsMasterData.insertItem(rwsMaster,getDataSource(request));
				request.setAttribute("code",RwsMasterData.getItemCode(getDataSource(request)));
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
				form = buildItemForm(request.getParameter("itemCode"),request);
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
				
				rwsMaster.setItemCode(frm.getItemCode());
				rwsMaster.setItemName(frm.getItemName());
				rwsMaster.setDistCode(frm.getDistCode());
				rwsMaster.setFinyear(frm.getFinyear());
				rwsMaster.setUnits(frm.getUnits());
				rwsMaster.setRate(frm.getRate());;
		
				RwsMasterData.updateItem(rwsMaster,getDataSource(request));
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
				RwsMasterData.removeItem(request.getParameter("itemCode"),getDataSource(request));
			}
			catch (Exception e) 
			{
				//System.out.println("the error is"+e);
			}
			
		}
		return(mapping.findForward(mode));
	}
}
