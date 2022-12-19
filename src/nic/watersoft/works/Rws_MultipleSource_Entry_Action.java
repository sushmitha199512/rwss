/*
 * Created on 26-04-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_MultipleSource_Entry_Action extends Action 
{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
	 {
			
		Rws_MultipleSource_Entry_form frm= (Rws_MultipleSource_Entry_form)form;
		HttpSession ses=request.getSession(); 
	 	String mode="",mode1=""; 
	 	ArrayList mandalCode = null;
		ArrayList scTypes = null;
		ArrayList extSourceCodes = new ArrayList();
		ArrayList siteHab1 = null;
		ArrayList subSources=null;
		int i=0;
	 	try
		{ 
	 		HttpSession session=request.getSession();
	 		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			if(user==null)
				return mapping.findForward("expire");
			
			if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
				return mapping.findForward("unAuthorise");	
			}
			
			Rws_MultipleSource_Entry_DAO dao=new Rws_MultipleSource_Entry_DAO();
		    mode=request.getParameter("mode");
		    mode1=request.getParameter("mode1");
		    
		      
			    if(mode.equals("init"))
			    {
			    	reset(frm);
			    	mode = "data";
			    	
			    }
			  	    
			    if(mode.equals("viewSource"))
			    {

			 		request.setAttribute("spradgroup", "existSource");
			    	String Work_id=frm.getNwork();
			    	ArrayList rows;
			    	
			    	rows=dao.getWorkDetails(Work_id,request);
			    	if(rows.size() == 0 || rows == null)
					{
			    		mode = "viewSource";
						request.setAttribute("message","No Record Matches with this Selection Criteria");
					}
					else      
					{
						mode = "viewSource";
						ses.setAttribute("rows",rows);
						frm.setRows(rows);
					
				    }
			    	
			            
			    }
			    
			    if(mode.equals("mandals"))
			    {
			    	try {
					     mandalCode = dao.getMandals(frm.getNwork());
						 session.setAttribute("mandalCode", mandalCode);	
						 frm.setSchemeCode(frm.getNwork().substring(6, 8));
						 request.setAttribute("assetCodee", frm.getSchemeCode());
						 request.setAttribute("stype","addnew");
							
					     }
					     catch (Exception e)
						 {
						   Debug.println("Exception in source Mandals mode:"	+ e.getMessage());
						 }
					     mode = "data"; 
					    
			    }
			    
			    
			    if(mode.equals("habs"))
			    {
				   try
				   {
					siteHab1 = dao.getMandalHabs(frm.getNwork(),frm.getMandalCode());
				    session.setAttribute("siteHab1", siteHab1);
				    frm.setSchemeCode(frm.getNwork().substring(6, 8));
					request.setAttribute("assetCodee", frm.getSchemeCode());
					
				   }
				   catch (Exception e)
					 {
					   Debug.println("Exception in source habs mode:"	+ e.getMessage());
					 }
				   mode = "data"; 
			    }
			    
			    
					
			    if(mode.equals("sourceTypes"))
			    {
				   try
				   {
				   	scTypes = dao.getSubCompType(frm.getNwork().substring(6,8));				
				    session.setAttribute("scTypes", scTypes);
				    frm.setSchemeCode(frm.getNwork().substring(6, 8));
					request.setAttribute("assetCodee", frm.getSchemeCode());
					
				   }
				   catch (Exception e)
					 {
					   Debug.println("Exception in source sourceTypes mode:"	+ e.getMessage());
					 }
				   mode = "data"; 
			    }
				 
			    
			    if(mode.equals("subsourceTypes"))
			    {
				   try
				   {
						 subSources=dao.getSubSourceTypes(frm.getSubcompType(), frm.getNwork().substring(6,8));
						 session.setAttribute("subSources", subSources);
						 frm.setSchemeCode(frm.getNwork().substring(6, 8));
						 request.setAttribute("assetCodee", frm.getSchemeCode());
							
					    
				   }
				   catch (Exception e)
					 {
					   Debug.println("Exception in source subsourceTypes mode:"	+ e.getMessage());
					 }
				   mode = "data"; 
			    }
	
			    if(mode.equals("sourceDetails") && mode1.equals("existSource"))
			    {
				   try
				   { 
				        String sourceType="";
				       	
				       	frm.setSchemeCode(frm.getNwork().substring(6, 8));
						request.setAttribute("assetCodee", frm.getSchemeCode());
						
						sourceType = frm.getNwork().substring(6, 8) + "01"+ frm.getSubcompType()+ frm.getSubSourceType();
						
						extSourceCodes = dao.getSourceCodes(sourceType, frm.getSitehab());
						
						session.setAttribute("extSourceCodes", extSourceCodes);

				 		request.setAttribute("spradgroup", "existSource");
						
					 				   	
				   }
				   catch (Exception e)
					 {
					   Debug.println("Exception in source sourceDetails existSource mode:"	+ e.getMessage());
					 }
				   mode = "data"; 
			    }
			    
			    if(mode.equals("sourceDetails") && mode1.equals("newSource"))
			    {
				   try
				   {    String newsourceCode = "",sourceType="";
				   	
						frm.setSchemeCode(frm.getNwork().substring(6, 8));
						request.setAttribute("assetCodee", frm.getSchemeCode());
						
						sourceType = frm.getNwork().substring(6, 8) + "01"+ frm.getSubcompType()+ frm.getSubSourceType();
						newsourceCode= dao.getNewSourceCodes(sourceType,frm.getSitehab(),frm.getNwork() );
				       	frm.setNewSourceCode(newsourceCode);
				       	
						request.setAttribute("spradgroup", "newSource");
					 				   	
				   }
				   catch (Exception e)
					 {
					   Debug.println("Exception in source sourceDetails newSource mode:"	+ e.getMessage());
					   e.printStackTrace();
					 }
				   mode = "data"; 
			    }
			   
			    
			    if(mode.equals("save"))
			    {
			    	mode = "viewSource";
			    	session = request.getSession();
				    String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {
				   try
				   {    
				   	    request.setAttribute("spradgroup", request.getParameter("spradgroup"));
				   	    frm.setSchemeCode(frm.getNwork().substring(6, 8));
						request.setAttribute("assetCodee", frm.getSchemeCode());
						
				        i = dao.SourceIdenInsert(frm, user.getOfficeCode());
				        
				      	if (i == 1)
					   	{
							request.setAttribute("message","Inserted Successfully");
						} else if (i == 2)
						{
							request.setAttribute("message","Updated Successfully");
						} else 
						{
							request.setAttribute("message", "Insertion Failed");
						}
				   }
				   catch (Exception e)
					 {
					   
				   	   e.printStackTrace();
				   	   
					 }
				    }
			    }
			    
			    
			    
			    
		 	}
	 	    catch(Exception e)
			{
		 		e.printStackTrace();
			}
			return mapping.findForward(mode);
			}
	
	public void reset(Rws_MultipleSource_Entry_form frm)
	{
		frm.setNwork("");
		frm.setWorkname("");
		frm.setWorkid("");
		frm.setMandal("");
		frm.setPanchayat("");
		frm.setSourcehab("");
		frm.setSourcetype("");
		frm.setSubSourceType("") ;
		frm.setSource("");
		frm.setSourcename("");
		frm.setCodeStatus("");
		frm.setExtSourceCode("");
		frm.setExtSourceCodes("");
		frm.setExtSourceName("");
		frm.setMandalCode("");
		frm.setNewSourceCode("");
		frm.setNewSourceName("");
		frm.setRecommend("");
		frm.setSchemeCode("");
		frm.setScTypes("");
		frm.setSitehab("");
		frm.setSiteHODate("");
		frm.setSourceIdentby("");
		frm.setSpradgroup("");
		frm.setRows(new ArrayList());
		

	}
	
		
}
