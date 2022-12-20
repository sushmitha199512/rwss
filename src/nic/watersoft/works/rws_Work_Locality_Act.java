package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsHabStatusData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_Work_Locality_Act extends Action {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
	 
		CommonLists	commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		
		if (user == null)
			return mapping.findForward("expire");
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		
		RwsOffices rwsoffice=new RwsOffices(getDataSource(request));
		rws_Aug_Link_Mainscheme_Dao dao=new rws_Aug_Link_Mainscheme_Dao();
		
		rws_works_WorkStatus_form frm= (rws_works_WorkStatus_form)form;
		String mode=frm.getMode();
		String mode1=frm.getMode1();
		if(mode!=null && mode.equals("data")){
		try{
		String ccode=frm.getCircleOfficeCode();
		String divcode=frm.getDivisionOfficeCode();
		String subcode=frm.getSubdivisionOfficeCode();
		String workcat=frm.getWorkCat();
		if(user==null||user.getUserId()==null){
 		return mapping.findForward("expire");
 	 	}
		 
		if(mode1==null)  
		{  
		ArrayList circles = rwsoffice.getCircles();
		session.setAttribute("circles", circles);
		}
		if(mode1!=null && mode1.equals("divisions")){
		ArrayList divisions = rwsoffice.getDivisions1(ccode);
		session.setAttribute("divisions", divisions);
		} 
		if(mode1!=null &&  mode1.equals("subdivisions")){
			ArrayList subdivisions = rwsoffice.getSubDivisions1(ccode,divcode);
			session.setAttribute("subdivisions", subdivisions);
			}
		
		ArrayList assetTypes = commonLists.getLocalityAssetTypes(ccode,divcode,subcode);
		session.setAttribute("assetTypes", assetTypes);
		
		if(mode1!=null && mode1.equals("works")){
			ArrayList workIds = commonLists.getWorks(ccode,divcode,subcode,workcat);
			session.setAttribute("workIds", workIds);
			}
		}catch(Exception e)	
		{
		Debug.println("Exception in works locality data mode:"+e);	
		}
		}
		
		if(mode!=null && mode.equals("lcSave"))
		{

	 	String habcode=request.getParameter("habcode");
	 	String type=request.getParameter("type");
	 	int sno=Integer.parseInt(request.getParameter("sno"));
	 	String sc="";
	 	int count=0;
	 	try{
	 	for(int i=1;i<=sno;i++)
	 	{
	 	  if(i<=9)
	 	  	sc=type+"0"+i;
	 	  else sc=type+i;
	 	if(request.getParameter("locname"+i)!=null && !request.getParameter("locname"+i).equals(""))
	 	{
	 	 count+=dao.insertScData(habcode,sc,request.getParameter("locname"+i)); 	
	 	}
	 	
	 	} 
	 	}catch(Exception e)
		{
	 		Debug.println("Exception in lcSave mode:"+e);
		}
		 if(count>0)
		 	request.setAttribute("message",count+" Localites(s) Inserted/Updated Successfully");
		 else
		 	request.setAttribute("message","Failed to Insert/Update");
		 mode="close";
	 
		} 
		if(mode!=null && mode.equals("workSave"))
		{

		 	String astcode=request.getParameter("astcode");
		 	int recno=Integer.parseInt(request.getParameter("sno"));
		 	int count=0;
		  try{
		 	for(int i = 1; i < recno+1; i++){
		if((request.getParameter("check["+i+"]")!=null && !request.getParameter("check["+i+"]").equals("")) && request.getParameter("popser"+i)!=null && !request.getParameter("popser"+i).equals(""))
		   {
			count+=dao.insertAssetData(request.getParameter("check["+i+"]"),astcode,request.getParameter("code"+i),request.getParameter("popser"+i));
		   }
		  }
		  }catch(Exception e){
		  	Debug.println("Exception in assetSave mode:"+e);
		  }
			 if(count>0)
			 	request.setAttribute("message",count+" Works Localites(s) Inserted Successfully");
			 else
			 	request.setAttribute("message","Failed to Insert");
			 mode="close";
		 	
		}
		if(mode!=null && mode.equals("stSave"))
		{

		 	int recno=0;
		 	String checking[]=null;   
			int count = 0;
		 	try{
		 	
			recno=Integer.parseInt(request.getParameter("resultCount"));
			
			checking=new String[recno+1];
			checking[0]=" ";  
			recno=Integer.parseInt(request.getParameter("resultCount"));	
			
			 for(int i = 1; i < recno+1; i++){
			 	
			 	if(request.getParameter("tsp"+i)!=null)
				  { 
				       checking[i]="1";     
				      if((request.getParameter("check["+i+"]")!=null && !request.getParameter("check["+i+"]").equals("")) && request.getParameter("tsp"+i)!=null && !request.getParameter("tsp"+i).equals(""))
				       {
				       	count+=RwsHabStatusData.insertHabsData(request.getParameter("check["+i+"]"),request.getParameter("tsp"+i));
				         }
				  } 
			 }
		 	}catch(Exception e)  
			{
		 	 Debug.println("Exception in stSave mode:"+e.getMessage());	
			}
			 if(count>0)
			 	request.setAttribute("message",count+" Habitation(s) Updated Successfully");
			 else
			 	request.setAttribute("message","Failed to Update");
			 mode="getHabs";
		 
		}
		if(mode!=null && mode.equals("getHabs"))
		{
		 String workid=frm.getWorkId();
		 if(workid==null || (workid!=null && workid.length()<14))
		   workid=request.getParameter("workid");
		 ArrayList Habs=dao.getHabsData(workid);
		 session.setAttribute("habsdata",Habs);
		}
		
	 return mapping.findForward(mode);
	} 

}
