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

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author user
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_MultipleSource_Entry_Action extends Action 
{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response) throws Exception
	 {
			
		Rws_MultipleSource_Entry_form frm= (Rws_MultipleSource_Entry_form)form;
		HttpSession ses=request.getSession(); 
	 	String mode="",mode1=""; 
	 	String circleCode,divCode,subDivCode;
	 	String workid,workname,adminno,admindate,samount,assettype,astwork,assets;
	 	//Debug.println("1");
	 	ArrayList mandalCode = null;
		ArrayList scTypes = null;
		ArrayList extSourceCodes = new ArrayList();
		ArrayList siteHab1 = null;
		ArrayList subSources=null;
		int i=0;
	 	try
		{ 
	 		RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
	 		HttpSession session=request.getSession();
	 		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			Debug.println("user:"+user);
			if(user==null)
				return mapping.findForward("expire");
			session = request.getSession();
		
			Rws_MultipleSource_Entry_DAO dao=new Rws_MultipleSource_Entry_DAO();
		    mode=request.getParameter("mode");
		    mode1=request.getParameter("mode1");
		    
		      
			    if(mode.equals("init"))
			    {
			    	reset(frm);
			    	mode = "data";
			    	Debug.println("......................init mode");
			    	
			    }
			  	    
			    if(mode.equals("viewSource"))
			    {

			 		request.setAttribute("spradgroup", "existSource");
			    	String Work_id=frm.getNwork();
			    	Debug.println("my work_id:"+Work_id);
			    	ArrayList rows;
			    	
			    	rows=dao.getWorkDetails(Work_id,request);
			    	Debug.println("my rows size:"+rows.size());
			    	if(rows.size() == 0 || rows == null)
					{
			    		mode = "viewSource";
						request.setAttribute("message","No Record Matches with this Selection Criteria");
					}
					else      
					{
						mode = "viewSource";
						//request.setAttribute("rows",rows);
						ses.setAttribute("rows",rows);
						Debug.println("mode"+mode);
						frm.setRows(rows);
						//ses.setAttribute("rows",rows);
					
				    }
			    	
			            
			    }
			    
			    if(mode.equals("mandals"))
			    {
			    	try {
			    		 Debug.println("mode"+mode);
			    		 Debug.println("frm.getNwork()"+frm.getNwork());
					     mandalCode = dao.getMandals(frm.getNwork());
						 session.setAttribute("mandalCode", mandalCode);	
						 frm.setSchemeCode(frm.getNwork().substring(6, 8));
						 request.setAttribute("assetCodee", frm.getSchemeCode());
							
					     }
					     catch (Exception e)
						 {
						   Debug.println("Error in source Mandals:"	+ e.getMessage());
						   e.printStackTrace();
						 }
					     mode = "data"; 
					    
			    }
			    
			    
			    if(mode.equals("habs"))
			    {
				   try
				   {siteHab1 = dao.getMandalHabs(frm.getNwork(),frm.getMandalCode());
				    session.setAttribute("siteHab1", siteHab1);
				    frm.setSchemeCode(frm.getNwork().substring(6, 8));
					request.setAttribute("assetCodee", frm.getSchemeCode());
					
				   }
				   catch (Exception e)
					 {
					   Debug.println("Error in source Mandals:"	+ e.getMessage());
					   e.printStackTrace();
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
					   Debug.println("Error in source Mandals:"	+ e.getMessage());
					   e.printStackTrace();
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
					   Debug.println("Error in source Mandals:"	+ e.getMessage());
					   e.printStackTrace();
					 }
				   mode = "data"; 
			    }
	
			    if(mode.equals("sourceDetails") && mode1.equals("existSource"))
			    {
				   try
				   { 
				        String sourceType="";
						Debug.println("in exist source");
						
						Debug.println("frm.getSubcompType()"+frm.getSubcompType());
				       	Debug.println("frm.getSubSourceType"+frm.getSubSourceType());
				       	
				       	frm.setSchemeCode(frm.getNwork().substring(6, 8));
						request.setAttribute("assetCodee", frm.getSchemeCode());
						
						sourceType = frm.getNwork().substring(6, 8) + "01"+ frm.getSubcompType()+ frm.getSubSourceType();
						
						extSourceCodes = dao.getSourceCodes(sourceType, frm.getSitehab());
						
						session.setAttribute("extSourceCodes", extSourceCodes);

				 		request.setAttribute("spradgroup", "existSource");
						
					 				   	
				   }
				   catch (Exception e)
					 {
					   Debug.println("Error in source Mandals:"	+ e.getMessage());
					   e.printStackTrace();
					 }
				   mode = "data"; 
			    }
			    
			    if(mode.equals("sourceDetails") && mode1.equals("newSource"))
			    {
				   try
				   {    String newsourceCode = "",sourceType="";
				   	
						Debug.println("in newSource ");
						frm.setSchemeCode(frm.getNwork().substring(6, 8));
						request.setAttribute("assetCodee", frm.getSchemeCode());
						
						sourceType = frm.getNwork().substring(6, 8) + "01"+ frm.getSubcompType()+ frm.getSubSourceType();
						Debug.println("sourceType"+sourceType);				       				        
						newsourceCode= dao.getNewSourceCodes(sourceType,frm.getSitehab(),frm.getNwork() );
				       	frm.setNewSourceCode(newsourceCode);
				       	Debug.println("my new source code"+newsourceCode);
				       	
						//session.setAttribute("srcCode", srcCode);
						request.setAttribute("spradgroup", "newSource");
					 				   	
				   }
				   catch (Exception e)
					 {
					   Debug.println("Error in source Mandals:"	+ e.getMessage());
					   e.printStackTrace();
					 }
				   mode = "data"; 
			    }
			   
			    
			    if(mode.equals("save"))
			    {
			    	mode = "viewSource"; 
				   try
				   {    Debug.println("hai i am in save mode with existSrc");
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
	 	    catch(Exception e)
			{
		 		//Debug.println("Exception in Rws_MultipleSource_Entry_Action:" +e);
		 		e.printStackTrace();
			}
		 	//Debug.println("mode:"+mode);		
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
