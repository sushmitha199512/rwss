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
public class rws_hab_publicinstitution_rpt_act extends Action  
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
		 ArrayList publicInsts=null;
		 String mode=null;
	 	 try{
		 HttpSession session =request.getSession();
		 
		 rws_asset_CheckList_FormBean check=(rws_asset_CheckList_FormBean )form;
		
		 mode=(String)request.getParameter("mode");
		 Debug.println("mode is "+mode);
		 try{
		 	session.setAttribute("Asset","");
		     if(mode.equalsIgnoreCase("data"))
		     {
		  	   circles=new ArrayList();
		  	   circles=rws_asset_CheckList_Data.getCircles(getDataSource(request));
		  	//   System.out.println("Circles ArrayList");
		  	   counts=new ArrayList();
		  	//   System.out.println("Counts ArrayList");
		       request.setAttribute("CirclesList",circles);
		     //  System.out.println("CirclesList session");
		      }
		     if(mode.equalsIgnoreCase("div"))
		     {
		     	try
				{	
		         Debug.println("cirle code"+check.get("circleCode"));
		 	     session.setAttribute("cCode",check.get("circleCode"));
		 	      
		 	     String div= rws_asset_CheckList_Data.getDivisions(getDataSource(request),"1",(String)check.get("circleCode"));
		 	     response.setContentType("text/html/XML");
		 	     java.util.Date date=new java.util.Date();
 	             long now=date.getTime();
 	             mode=null;
 	             response.setHeader("Expires",(now-(1000*60*60))+"");
		 	     java.io.PrintWriter out=response.getWriter();
		 	     out.println(div);
		 	     out.flush();
		     	}
		     	catch(Exception e){Debug.println("in geting divisoins"+e);}
		     }
		     if(mode.equalsIgnoreCase("subDiv"))
		     {
		     	  String subdiv=rws_asset_CheckList_Data.getSubDivisions(getDataSource(request),"1",(String)check.get("circleCode"),(String)check.getString("divisionCode"));
			 	  response.setContentType("text/html/XML");
			 	  java.util.Date date=new java.util.Date();
	 	          long now=date.getTime();
	 	          mode=null;
	 	          response.setHeader("Expires",(now-(1000*60*60))+"");
			 	  java.io.PrintWriter out=response.getWriter();
			 	  out.println(subdiv);
			 	  out.flush();
		     }
		     if(mode.equalsIgnoreCase("mandals"))
		     {
		     	   try{
		          String mandal=rws_asset_CheckList_Data .getMandals(getDataSource(request),"1",(String)check.get("circleCode"),(String)check.get("divisionCode"),(String)check.getString("subdivisionCode"));
			 	  response.setContentType("text/html/XML");
			 	  java.util.Date date=new java.util.Date();
	 	          long now=date.getTime();
	 	          mode=null;
	 	          response.setHeader("Expires",(now-(1000*60*60))+"");
			 	   java.io.PrintWriter out=response.getWriter();
			 	   out.println(mandal);
			 	   out.flush();
		     	   }
		     	   catch(Exception e)
				   {
		     	   	Debug.println("Exception e"+e);
				   }
		     	
		     }
		     if(mode.equalsIgnoreCase("panchayats"))
		     {
		     	    try{
		     	   String panchayat= rws_asset_CheckList_Data.getpanchayats(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"));
			 	   response.setContentType("text/html/XML");
			 	   java.util.Date date=new java.util.Date();
	 	           long now=date.getTime();
	 	           mode=null;
	 	           response.setHeader("Expires",(now-(1000*60*60))+"");
			 	   java.io.PrintWriter out=response.getWriter();
			 	   out.println(panchayat);
			 	   out.flush();
		     	    }
		     	   catch(Exception e)
				   {
		     	   	Debug.println("Exception e"+e);
				   }
		     }
		     if(mode.equalsIgnoreCase("village"))
		     {
		     	   try{
		           String village=rws_asset_CheckList_Data.getvillages(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"));
			 	   response.setContentType("text/html/XML");
			 	   java.util.Date date=new java.util.Date();
	 	           long now=date.getTime();
	 	           mode=null;
	 	           response.setHeader("Expires",(now-(1000*60*60))+"");
			 	   java.io.PrintWriter out=response.getWriter();
			 	   out.println(village);
			 	   out.flush();
		     	   }
		     	  catch(Exception e)
				   {
		     	   	Debug.println("Exception e"+e);
				   }
		     }
		     if(mode.equalsIgnoreCase("habitation"))
		     {    try{
		     	   String habitation= rws_asset_CheckList_Data.getHabitations(getDataSource(request),(String)check.get("circleCode"),(String)check.get("mandalCode"),(String)check.get("panchayatCode"),(String)check.get("villageCode"));
			 	   response.setContentType("text/html/XML");
			 	   java.util.Date date=new java.util.Date();
	 	           long now=date.getTime();
	 	           mode=null;
	 	           response.setHeader("Expires",(now-(1000*60*60))+"");
			 	   java.io.PrintWriter out=response.getWriter();
			 	   out.println(habitation);
			 	   out.flush();
			 	   mode="view";
		          }
		         catch(Exception e)
			     {
	     	     	Debug.println("Exception e"+e);
			     }
		     }
		     if(mode.equalsIgnoreCase("view"))
		     {
		     	Debug.println("mode is "+mode);
		     
		     	   String dist=(String)request.getParameter("dcode");
		     	   String mandal=(String)request.getParameter("mcode");
		     	   String panchayat=(String)request.getParameter("pcode");
		     	   String village=(String)request.getParameter("vcode");
		     	   String habitation=(String)request.getParameter("hcode");
		     	   try{
			     	   if(mandal==null)
			     	   {
			     	   	mandal="";
			     	    panchayat="";
			     	    village="";
			     	    habitation="";
			     	    }
		     	      }
			     	   catch(Exception e)
					   {
			     	   	Debug.println("Exception e"+e);
			     	    mandal="";
			     	    panchayat="";
			     	    village="";
			     	    habitation="";
					   }
		     	    
 	     	       Debug.println("@@99999999@@@@@@@"+"Circle:"+dist+"    mandal: "+mandal+
		     	   		" Pan: "+panchayat+" village: "+village+"  hab: "+habitation);
 	     	     publicInsts=new ArrayList();
 	     	     if(dist.equals(""))
 	     	     {
 	     	      publicInsts=CheckListMasterData.getPublicInstitutions(getDataSource(request));
	 	     	    if(publicInsts.size()>0)
	  	     	   {
	  	     	    Debug.println("in if");
	  	     	    request.setAttribute("PublicInstitutions",publicInsts);
	  	     	    request.setAttribute("VIEW","YES");
	  	     	   }
 	     	     }
 	     	     if(!dist.equals(""))
 	     	     {
 	     	     	if(habitation.equals("")&&panchayat.equals("")&&village.equals("")&&mandal.equals(""))
 	     	     	{
 	    	     	    publicInsts=CheckListMasterData.getManPublicInstitutions(getDataSource(request),dist );
	 	    	     	Debug.println("publicInst is "+publicInsts.size());
 	    	     	    if( publicInsts.size()>0)
			  	     	   {
			   	     	    request.setAttribute("PublicInstitutionsMan",publicInsts);
			   	     	    request.setAttribute("VIEW","YES");
			  	       	   }
 	     	     	}
 	     	     	if(habitation.equals("")&&village.equals("")&&panchayat.equals("")&&!mandal.equals(""))
 	     	     	{
 	     	     		Debug.println("in if");
 	     	     	 publicInsts=CheckListMasterData.getPnPublicInstitutions(getDataSource(request),dist,mandal);
 	     	     	  if( publicInsts.size()>0)
		  	     	   {
		   	     	    request.setAttribute("PublicInstitutionsPan",publicInsts);
		   	     	    request.setAttribute("VIEW","YES");
		  	       	   }
  	     	      	}
 	     	     	if(habitation.equals("")&&village.equals("")&&!panchayat.equals("")&&!mandal.equals(""))
 	     	     	{
 	     	     		Debug.println("in if");
 	     	     	 publicInsts=CheckListMasterData.getVilPublicInstitutions(getDataSource(request),dist,mandal,panchayat);
 	     	     	  if( publicInsts.size()>0)
		  	     	   {
		   	     	    request.setAttribute("PublicInstitutionsVil",publicInsts);
		   	     	    request.setAttribute("VIEW","YES");
		  	       	   }
  	     	      	}
 	     	     	if(!village.equals("")&&!panchayat.equals("")&&!mandal.equals(""))
 	     	     	{
 	     	     		Debug.println("in if");
 	     	     	 publicInsts=CheckListMasterData.getHabPublicInstitutions(getDataSource(request),dist,mandal,panchayat,village,habitation);
 	     	     	  if(publicInsts.size()>0)
		  	     	   {
		   	     	    request.setAttribute("PublicInstitutionsHab",publicInsts);
		   	     	    request.setAttribute("VIEW","YES");
		  	       	   }
  	     	      	}
 	     	     	 
 	     	     }
  	         }
		     if(mode.equalsIgnoreCase("report"))
			 {
		   	   String dist=(String)request.getParameter("dcode");
	     	   String mandal=(String)request.getParameter("mcode");
	     	   String panchayat=(String)request.getParameter("pcode");
	     	   String village=(String)request.getParameter("vcode");
	     	   String habitation=(String)request.getParameter("hcode");
	     	   try{
		     	   if(mandal==null)
		     	   {
		     	   	mandal="";
		     	    panchayat="";
		     	    village="";
		     	    habitation="";
		     	    }
	     	      }
		     	   catch(Exception e)
				   {
		     	   	Debug.println("Exception e"+e);
		     	    mandal="";
		     	    panchayat="";
		     	    village="";
		     	    habitation="";
				   }
	     	    
	     	     Debug.println("@@99999999@@@@@@@ in Test REportptp  "+"Circle:"+dist+"    mandal: "+mandal+
	     	   		" Pan: "+panchayat+" village: "+village+"  hab: "+habitation);
	     	     publicInsts=new ArrayList();
	     	     if(dist.equals(""))
	     	     {
	     	      publicInsts=CheckListMasterData.getPublicInstitutions(getDataSource(request));
 	     	    if(publicInsts.size()>0)
  	     	   {
  	     	    Debug.println("in if");
  	     	    request.setAttribute("PublicInstitutions",publicInsts);
  	     	    request.setAttribute("VIEW","YES");
  	     	   }
	     	     }
			 	
			 }
		     
		     if(mode.equalsIgnoreCase("report"))//code added for generating report from the login page
			 {//code added on 18-09-08
		   	   String dist=(String)request.getParameter("dcode");
	     	   String mandal=(String)request.getParameter("mcode");
	     	   String panchayat=(String)request.getParameter("pcode");
	     	   String village=(String)request.getParameter("vcode");
	     	   String habitation=(String)request.getParameter("hcode");
	     	   try{
		     	   if(mandal==null)
		     	   {
		     	   	mandal="";
		     	    panchayat="";
		     	    village="";
		     	    habitation="";
		     	    }
	     	      }
		     	  catch(Exception e)
				  {
		     	   	Debug.println("Exception e"+e);
		     	    mandal="";
		     	    panchayat="";
		     	    village="";
		     	    habitation="";
				  }
	     	    
	     	     Debug.println("@@99999999@@@@@@@ in Test REportptp  "+"Circle:"+dist+" mandal: "+mandal+" Pan: "+panchayat+" village: "+village+"  hab: "+habitation);
	     	     publicInsts=new ArrayList();
	     	     if(dist.equals(""))
	     	     {
	     	       publicInsts=CheckListMasterData.getPublicInstitutions(getDataSource(request));
	     	       ArrayList publicInsts1 = new ArrayList();
	     	       for(int x = publicInsts.size()-1;x<publicInsts.size();x++)//code for getting the last array index from the array returned by the method
	     	       {
	     	      	 publicInsts1.add(0,publicInsts.get(x));
	     	       }
	     	      
	 	     	   if(publicInsts.size()>0)
	  	     	   {
	  	     	    request.setAttribute("PublicInstitutions",publicInsts);
	  	     	    request.setAttribute("PublicInstitutions1",publicInsts1);
	  	     	    request.setAttribute("VIEW","YES");
	  	     	   }
	     	     }
			 }
		     
 		  }		 
		 catch(Exception e)
		 {
		 	Debug.println("Exceptione"+e);
		 }
		 }
		 catch(Exception e)
		 {
		 	Debug.println("Exception "+e);
		 }
		// System.out.println("mode returned"+mode);
		 return mapping.findForward(mode);
	   }
     }


