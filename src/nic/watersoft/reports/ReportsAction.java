/* Created on Aug 6, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
/**
 * @author vikas
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class ReportsAction extends Action
{
	ArrayList districts=new ArrayList();
	ArrayList mandals=new ArrayList();
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
	{
		ArrayList state=new ArrayList();
		
		ReportsMasterData reportsMasterData=new ReportsMasterData();
		ReportsForm frm=(ReportsForm)form;
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		
		HttpSession session=request.getSession();
		String mode=frm.getMode();
		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				districts=rwsOffices.getDistricts();	
				session.setAttribute("districts",districts);
		
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals",mandals);
				
			}catch(Exception e)
			{
				//System.out.println("error in data"+e);
			}
			
		}
				
		if(mode.equalsIgnoreCase("Submit"))
		{
			java.text.DateFormat dateFormat=new java.text.SimpleDateFormat("yyyy");
			java.util.Date currentDate=new java.util.Date();
			
			/*String currentYear=dateFormat.format(currentDate).substring(0,4);
			/*currentYear=""+(Integer.parseInt(currentYear)-1);//code added for displaying previous year data
			String prevYear="01-APR-"+(Integer.parseInt(currentYear)-1);*/
		
			/*currentYear=""+(Integer.parseInt(currentYear));//code modified by ramesh on 110609
			String prevYear="01-APR-"+(Integer.parseInt(currentYear));*/
			java.util.Calendar calendar = java.util.Calendar.getInstance(); 
			String currentYear="";
			//if(calendar.get(java.util.Calendar.MONTH)<=03)  
			//{
				//currentYear=Integer.toString(calendar.get(java.util.Calendar.YEAR)-1);
			    //Debug.println("currentYear**********?1"+currentYear);
			//}
			  //else
			  //{
			  	currentYear=Integer.toString(calendar.get(java.util.Calendar.YEAR));
			  	
			//Debug.println("currentYear**********1"+currentYear);
			  //}
			String prevYear="01-APR-"+(Integer.parseInt(currentYear));
			
			request.setAttribute("currentYear",currentYear);
			Debug.println("currentYear***********"+currentYear);
			Debug.println("currentYear***********"+prevYear);
			request.setAttribute("prevYear",prevYear);
			
			
			try
			{
			String level=request.getParameter("level");
			String dist=request.getParameter("district");
			String mand=request.getParameter("mandal");
		//	System.out.println("Mandal in Action"+mand);		
			
			session.setAttribute("districtsrep",dist);
			session.setAttribute("mandalsrep",mand);
		
			//System.out.println(session.getAttribute("mandalsrep"));
			if(request.getParameter("level").equals("S"))
			{
				//mode="state";
				int i = ReportsMasterData.getState(getDataSource(request),session);
				java.util.ArrayList state13=(java.util.ArrayList)session.getAttribute("stateDist");
				//java.util.ArrayList state14=(java.util.ArrayList)session.getAttribute("stateDist1");
				//System.out.println("SIZE1 state "+state13.size());
				//System.out.println("SIZE2 "+state14.size());
			}
			
			if(request.getParameter("level").equals("D"))
			{
				ArrayList records=null;
				ArrayList records1=null;
				
				if(dist.equals("ALL"))
				{
				//	mode="District";
					records=ReportsMasterData.getDistricts(getDataSource(request),session);
					request.setAttribute("records",records);
					System.out.println(records.size());
				
					
					/*java.util.ArrayList stateDist11=(java.util.ArrayList)session.getAttribute("stateDist");
					java.util.ArrayList stateDist12=(java.util.ArrayList)session.getAttribute("stateDist1");
					System.out.println("SIZE1 "+stateDist11.size());
					System.out.println("SIZE2 "+stateDist12.size());*/
				}
				else if(!dist.equals("ALL"))
				{
			//	mode="mandal";
				records1=ReportsMasterData.getMandals(getDataSource(request),session);
				request.setAttribute("records1",records1);
				}
				
				//frm.reset1(mapping,request);					
			}	
			}catch(Exception e)
			{
				System.out.println("Exception in submit"+e);
			}
			
		}	
				
		if(mode.equalsIgnoreCase("Assets"))
		{
			try
			{
				districts=rwsOffices.getDistricts();
				session.setAttribute("assetDistricts",districts);
				
				mandals=rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("assetMandals",mandals);
				
			
			if(request.getParameter("level")!=null && request.getParameter("level").equals("S"))
			{
				int i=ReportsMasterData.getAssetDistricts(getDataSource(request),session);
				java.util.ArrayList stateDist11=(java.util.ArrayList)session.getAttribute("stateAssets");
				java.util.ArrayList stateDist12=(java.util.ArrayList)session.getAttribute("stateAssets1");
				String total=(String)session.getAttribute("totalAssets");			
			}
			//if(request.getParameter("level").equals("D"))
			{
				
				
			}				
			}catch(Exception e)
			{
					System.out.println("Exception in assets"+e);
			}
				
		}
		
		
				
	//System.out.println("mode returned"+mode);
	return (mapping.findForward(mode));
	}
	
		

}//end of main function
