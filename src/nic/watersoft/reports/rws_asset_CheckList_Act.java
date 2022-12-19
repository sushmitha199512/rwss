package nic.watersoft.reports;
import java.io.IOException;
import nic.watersoft.commons.Debug;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import javax.sql.DataSource;
public class rws_asset_CheckList_Act extends Action  

{
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		ArrayList circles=null;
		ArrayList divisions=null;
		ArrayList subdivisions=null;
		ArrayList districts=null;
		ArrayList mandals=null;
		ArrayList panchayats=null;
		ArrayList villages=null;
		ArrayList habitations=null;
		ArrayList counts=null;
		String mode=null;
		
		try{
			HttpSession session =request.getSession();
			rws_asset_CheckList_FormBean check=( rws_asset_CheckList_FormBean )form;
			
			mode=(String)request.getParameter("mode");
					
			try{
			session.setAttribute("Asset","");
					
			
				if(mode!=null && mode.equalsIgnoreCase("data"))
				{
					try
					{
					circles=new ArrayList();
					circles=rws_asset_CheckList_Data.getCircles(getDataSource(request));
					counts=new ArrayList();
					//Debug.println(" circle count ............");
					counts=rws_asset_CheckList_Data.getCounts(getDataSource(request));
					//Debug.println("  circle count end");
					request.setAttribute("CirclesList",circles);
					Debug.println("length is"+counts.size());
					rws_asset_CheckList_Bean bean =(rws_asset_CheckList_Bean )counts.get(0);
					check.set("pwsCount",(String)bean.getPwsCount());
					check.set("cpwsCount",(String)bean.getCpwsCount());
					check.set("mpwsCount",(String)bean.getMpwsCount());
					check.set("handPumpCount",(String)bean.getHandPumpCount());
					check.set("shalHpCount",(String)bean.getShallowHandPumps());
					check.set("wellsCount",(String)bean.getOpenWells());
					check.set("pondsCount",(String)bean.getPonds());
					check.set("dpCount",(String)bean.getDpCount());
					Debug.println("out of data mode"+(String)bean.getDpCount());
					}catch(Exception e)
					{
						Debug.println("Exception in datamode"+e);
					}
					
				}
				if(mode!=null && mode.equalsIgnoreCase("div"))
				{
					try
					{	 
						counts=new ArrayList();
						Debug.println("cirle code"+check.get("circleCode"));
						Debug.println("in division mode");
						session.setAttribute("cCode",check.get("circleCode"));
						
						String div= rws_asset_CheckList_Data.getDivisions(getDataSource(request),"1",(String)check.get("circleCode"));
						Debug.println("div size is"+div.length());
						
						//counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"));//added on july 4th
						counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));
						Debug.println("333333333333333333333333");
						
						String responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(div),(rws_asset_CheckList_Bean)counts.get(0)));
						Debug.println("response text is :"+responseText);						
						
						response.setContentType("text/html/XML");
						java.util.Date date=new java.util.Date();
						long now=date.getTime();
						mode=null;
						response.setHeader("Expires",(now-(1000*60*60))+"");
						java.io.PrintWriter out=response.getWriter();
						out.println(responseText);
						out.flush();
						Debug.println("out of div mode");
					}
					catch(Exception e){Debug.println("in geting divisoins"+e);}
				}
				
				if(mode!=null && mode.equalsIgnoreCase("subDiv"))
				{
					String subdiv="";  
					String responseText="";
					
					try{
						Debug.println("divcode:"+check.getString("divisionCode"));
						if(check.getString("divisionCode")!=null && !check.getString("divisionCode").equals("")){
							 subdiv=rws_asset_CheckList_Data.getSubDivisions(getDataSource(request),"1",(String)check.get("circleCode"),(String)check.getString("divisionCode"));
							 counts=rws_asset_CheckList_Data.getAssetCounts1(getDataSource(request),(String)check.get("circleCode"),(String)check.getString("divisionCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode")); 
							Debug.println("counts:"+counts);	
							 responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(subdiv),(rws_asset_CheckList_Bean)counts.get(0)));
						
						}
					    else
					    {
					    	 //responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(subdiv),new rws_asset_CheckList_Bean()));
					    	subdiv =rws_asset_CheckList_Data.getDivisions1(getDataSource(request),"1",(String)check.get("circleCode")); 
					    	counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));
							Debug.println("333333333333333333333333");
							
							responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(subdiv),(rws_asset_CheckList_Bean)counts.get(0)));
							Debug.println("response text is :"+responseText);						
												
							
					    }
					
					Debug.println("response text in Div is "+responseText);
					Debug.println("subdiv size is"+subdiv.length());
				 	  response.setContentType("text/html/XML");
				 	  java.util.Date date=new java.util.Date();
		 	          long now=date.getTime();
		 	          mode=null;
		 	          response.setHeader("Expires",(now-(1000*60*60))+"");
				 	  java.io.PrintWriter out=response.getWriter();
				 	  out.println(responseText);
				 	  out.flush();
				 	 Debug.println("out of subdiv mode");
					}catch(Exception e)
					{
						Debug.println("Exception in subdivmode"+e);
					}
				}
				if(mode!=null && mode.equalsIgnoreCase("mandals"))
				{
					String mandal="";
					String responseText="";
					try
					{
						if(check.getString("subdivisionCode")!=null && !check.getString("subdivisionCode").equals("")){
							
						mandal=rws_asset_CheckList_Data.getMandals(getDataSource(request),"1",(String)check.get("circleCode"),(String)check.get("divisionCode"),(String)check.getString("subdivisionCode"));
						counts=rws_asset_CheckList_Data.getAssetCounts2(getDataSource(request),(String)check.get("circleCode"),(String)check.getString("divisionCode"),(String)check.getString("subdivisionCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));  
						 responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(mandal),(rws_asset_CheckList_Bean)counts.get(0)));
						}
						else
						{
							counts=rws_asset_CheckList_Data.getAssetCounts1(getDataSource(request),(String)check.get("circleCode"),(String)check.getString("divisionCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode")); 
							Debug.println("counts:"+counts);	
							responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(mandal),(rws_asset_CheckList_Bean)counts.get(0)));

							
						}
					   
					Debug.println("div size is"+mandal.length());
					
				 	 Debug.println("response text of mandals is:"+responseText);
					  response.setContentType("text/html/XML");
				 	  java.util.Date date=new java.util.Date();
		 	          long now=date.getTime();
		 	          mode=null;
		 	          response.setHeader("Expires",(now-(1000*60*60))+"");
				 	   java.io.PrintWriter out=response.getWriter();
				 	   out.println(responseText);
				 	   out.flush();
					Debug.println("out of mandals mode");
					}catch(Exception e)
					{
						Debug.println("Exception in mandalsmode"+e);
					}
				}
				if(mode!=null && mode.equalsIgnoreCase("panchayats"))
				{
					try
					{
						Debug.println("111111111:"+request.getParameter("subdivisionCode"));
						Debug.println("22222222:"+check.getString("mandalCode"));
					counts=new ArrayList();
					String panchayat= rws_asset_CheckList_Data.getpanchayats(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"));
					Debug.println("div size is"+panchayat.length());
					counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));
					String responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(panchayat),(rws_asset_CheckList_Bean)counts.get(0)));
					Debug.println("response text is "+responseText);
					
					response.setContentType("text/html/XML");
					java.util.Date date=new java.util.Date();
					long now=date.getTime();
					mode=null;
					response.setHeader("Expires",(now-(1000*60*60))+"");
					java.io.PrintWriter out=response.getWriter();
					out.println(responseText);
					out.flush();
					Debug.println("out of panchayats mode");
					}catch(Exception e) 
					{
						Debug.println("Exception in panchaystsmode"+e);
					}
				}
				if(mode!=null && mode.equalsIgnoreCase("village"))
				{ 
					try
					{
					counts=new ArrayList();
					String village=rws_asset_CheckList_Data.getvillages(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"));
					Debug.println("div size is"+village.length());
					
					//counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode")); // added
					counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));//removed
					String responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(village),(rws_asset_CheckList_Bean)counts.get(0)));
					Debug.println("response text is "+responseText);
					
					response.setContentType("text/html/XML");
					java.util.Date date=new java.util.Date();
					long now=date.getTime();
					mode=null;
					response.setHeader("Expires",(now-(1000*60*60))+"");
					java.io.PrintWriter out=response.getWriter();
					out.println(responseText);
					out.flush();
					Debug.println("out of village mode");
					}catch(Exception e)
					{
						Debug.println("Exception in villagemode"+e);
					}
				}
				if(mode!=null && mode.equalsIgnoreCase("habitation"))
				{
					try
					{					
					counts=new ArrayList();
					String habitation= rws_asset_CheckList_Data.getHabitations(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"));
					Debug.println("div size is hab"+habitation.length());
					
					//counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"));//added
					counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));//removed
					String responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(habitation),(rws_asset_CheckList_Bean)counts.get(0)));
					Debug.println("response text is "+responseText);
					
					response.setContentType("text/html/XML");
					java.util.Date date=new java.util.Date();
					long now=date.getTime();
					mode=null;
					response.setHeader("Expires",(now-(1000*60*60))+"");
					java.io.PrintWriter out=response.getWriter();
					out.println(responseText);
					out.flush();
					Debug.println("out of Habitations mode");
					}catch(Exception e)
					{ 
						Debug.println("Exception in habitationmode"+e);
					}
				}
				if(mode!=null && mode.equalsIgnoreCase("counts"))
				{
					String circle=(String)check.get("circleCode");
					String div=(String)check.get("divisionCode");
					String subdiv=(String)check.get("subdivisionCode");
					String mandal=(String)check.get("mandalCode");
					String panchayat=(String)check.get("panchayatCode");
					String village=(String)check.get("villageCode");
					String habitation=(String)check.get("habitationCode");
					String asset=(String)check.get("assetCode");
					session.setAttribute("Asset",asset);
					Debug.println("@@99999999@@@@@@@"+"Circle:"+circle+" div: "+div+" SUB: "+subdiv+"  mandal: "+mandal+
							" Pan: "+panchayat+" village: "+village+"  hab: "+habitation+" asset: "+asset);
					
					String subComps= rws_asset_CheckList_Data.getsubcomps(getDataSource(request),asset,circle,div,subdiv,mandal,panchayat,village,habitation);
					
					counts=rws_asset_CheckList_Data.getAssetCounts(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"),(String)check.get("habitationCode"));
					
					Debug.println(" before response text");
					String responseText=new String(appendAssetCounts(getDataSource(request),new StringBuffer(subComps),(rws_asset_CheckList_Bean)counts.get(0)));
					Debug.println(" after response text");
					
					Debug.println("response text is "+responseText);
					
					response.setContentType("text/html/XML");
					java.util.Date date=new java.util.Date();
					long now=date.getTime();
					mode=null;
					response.setHeader("Expires",(now-(1000*60*60))+"");
					java.io.PrintWriter out=response.getWriter();
					out.println(responseText);
					out.flush();
					Debug.println("out of panchayat mode");
				}
			}
			catch(Exception e)
			{
				Debug.println("Exception in mode "+e);
			}
		}
		catch(Exception e)
		{
			Debug.println("Exception out of mode  "+e);
		}
		
		return mapping.findForward(mode);
	}
	
	public StringBuffer appendAssetCounts(DataSource dataSource,StringBuffer responseText,rws_asset_CheckList_Bean bean)
	{
		ArrayList counts=null;
		try{
			responseText.append("<///>");
			responseText.append((String)bean.getPwsCount());
			responseText.append("<>");
			responseText.append((String)bean.getMpwsCount());
			responseText.append("<>");
			responseText.append((String)bean.getCpwsCount());
			responseText.append("<>");
			responseText.append((String)bean.getHandPumpCount());
			responseText.append("<>");
			responseText.append((String)bean.getShallowHandPumps());
			responseText.append("<>");
			responseText.append((String)bean.getOpenWells());
			responseText.append("<>");
			responseText.append((String)bean.getPonds());
			responseText.append("<>");
			responseText.append((String)bean.getDpCount());
			
		}catch(Exception e){Debug.println("Exception in appendAssetCounts is "+e);}
		
		return responseText;
	}
}
 

