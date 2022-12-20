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
public class rws_hab_location_status_Act extends Action  
     {
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
		{
		  
		 
		 ArrayList districts=null;
		 ArrayList mandals=null;
		 ArrayList panchayats=null;
		 ArrayList statusDate=null;
		 ArrayList HabDetails=null;
		 String mode=null;
		 
		 try{
		 	//System.out.println("in hab location status action");	
		 HttpSession session =request.getSession();
		 
		 rws_hab_location_status_FormBean hab=( rws_hab_location_status_FormBean )form;
		 mode=(String)hab.get("mode");
		 //System.out.println("mode is "+mode);
		        
		      	districts=new ArrayList();
		      	districts=rws_asset_CheckList_Data.getCircles(getDataSource(request));
		  	    request.setAttribute("CirclesList",districts);
		  	    statusDate=new ArrayList();
		  	    statusDate=rws_asset_CheckList_Data.getStatusDate(getDataSource(request));
		  	    request.setAttribute("statusDates",statusDate);
		  	   
		  	   	//System.out.println("in mandals dcode is"+(String)hab.get("districtCode"));
		  	    mandals=new ArrayList();
		  	    mandals=CheckListMasterData.getMandals(getDataSource(request),(String)hab.get("districtCode"));
		  	    request.setAttribute("mandals",mandals);
		  	    panchayats=CheckListMasterData.getPanchayats(getDataSource(request),(String)hab.get("districtCode"),(String)hab.get("mandalCode"));
		  	    request.setAttribute("panchayats",panchayats);
		  	    {
		  	    HabDetails=new ArrayList();
		  	    HabDetails.add("Census Plain Population");
		  	    HabDetails.add("Census SC Population");
		  	    HabDetails.add("Census ST Population");
		  	    HabDetails.add("Floating Population");
			  	HabDetails.add("Total Water Supply");
			  	HabDetails.add("Existing Water Level");
			  	HabDetails.add("Plain Population Covered");
			  	HabDetails.add("SC Population Covered");
			  	HabDetails.add("ST Population Covered");
			  	request.setAttribute("HabDetails",HabDetails);
			    String[] habdet=(String[])hab.get("habDetails");
			  	for(int i=0;i<habdet.length;i++)
			  	{
			  	//System.out.println("haba details status is "+habdet[i]);
			  	}
			  	
		  	    }
		 }       
		 
		 catch(Exception e)
		 {
		 	//System.out.println("Exception"+e);
		 }
		 return mapping.findForward(mode);
		 }
     }


