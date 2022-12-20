package nic.watersoft.complaints;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;


import org.apache.struts.action.*;

public class Rws_AsstUrbanComplaintActgeneric_frm extends Action{
	
    public Rws_AsstUrbanComplaintActgeneric_frm()
    {
    }
    protected ActionForm buildCompForm(String complaintno, String mode, HttpServletRequest request)
    throws Exception
{
    	UrbanCompForm form = null;
    
    UrbanCompForm compForm = ComplaintMasterData.getUrbanComplaintnooutgeneric(complaintno, getDataSource(request));
    ArrayList urbandistricts = new ArrayList();
    
    ArrayList urbanmandals = new ArrayList();
    ArrayList municipailties = new ArrayList();
    ArrayList Localities = new ArrayList();
    HttpSession session = request.getSession();
   
    
    ArrayList representatives = new ArrayList();
    
    RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
    if(compForm != null)
    {
       
        form = new UrbanCompForm();
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        Debug.println("inside the" + request.getParameter("urbandist") );
        urbandistricts = rwsLocations.getDistricts();
        session.setAttribute("urbandistricts", urbandistricts);
        
        
        
        
        form.setDistrictName(compForm.getDistrictName());
        urbanmandals = rwsLocations.getUrbanMandals(compForm.getUrbandist());
        session.setAttribute("urbanmandals", urbanmandals);
        form.setMandalName(compForm.getMandalName());
        municipailties = rwsLocations.getMunicipalities(compForm.getUrbandist(), compForm.getUrbanmand());
        session.setAttribute("municipailties", municipailties);
        Debug.println("GetMandals" + compForm.getUrbanmand());
        Debug.println("GetMandals1" + form.getUrbanmand());
        form.setPanchayatName(compForm.getPanchayatName());
        Localities = rwsLocations.getPanchayatHabitations(compForm.getUrbandist(), compForm.getUrbanmand(), compForm.getMuncpl());
        session.setAttribute("Localities", Localities);
        
        
        
        form.setHabName(compForm.getHabName());
     //   Debug.println("GetHabitations" + compForm.getHabCode());
        
        
        form.setComplntno(compForm.getComplntno());
     //   Debug.println("GetComplaintno" + compForm.getComplntno());
        form.setComplntdt(compForm.getComplntdt());
      ///  Debug.println("GetComplaintdate" + compForm.getComplntdt());
        form.setComplntdesc(compForm.getComplntdesc());
       // Debug.println(form.getComplntdesc());
     //   Debug.println("GetComplaintdesc" + compForm.getComplntdesc());
        String code=ComplaintMasterData.getCpcode(compForm.getComplntno());
        
                
        
        
        form.setRepCode(compForm.getRepCode());
        representatives = complaintMasterData.getRepresentatives(getDataSource(request));
        session.setAttribute("representatives", representatives);
      //  Debug.println("GetCategory" + compForm.getRepCode());
        form.setName(compForm.getName());
       // Debug.println("GetName" + compForm.getName());
        form.setAddress(compForm.getAddress());
      //  Debug.println("GetAddress" + compForm.getAddress());
        form.setPhoneNo(compForm.getPhoneNo());
        form.setComponentName(compForm.getComponentName());
        form.setEmailId(compForm.getEmailId());
        form.setGrievanceEntryCategory(compForm.getGrievanceEntryCategory());
        form.setGrievanceRelatedTo(compForm.getGrievanceRelatedTo());
        form.setGrievanceCategory(compForm.getGrievanceCategory());
        
        
        
        
    }
    return form;
}



    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
    	HttpSession session=request.getSession();
    	RwsUser user=(RwsUser)session.getAttribute("RWS_USER");
    	String loggedUser=user.getUserId();
    	
    	String page_to_be_displayed = " ";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList urbandistricts = new ArrayList();
        int compCount = 0;
        ArrayList urbanmandals = new ArrayList();
       // ArrayList municipailties = new ArrayList();
        ArrayList Localities = new ArrayList();
        Collection reccomplaints = null;
        reccomplaints = new ArrayList();
        Collection complaints = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        Collection districtcomplaints = new ArrayList();
        Collection mandalcomplaints = new ArrayList();
        Collection panchayatcomplaints = new ArrayList();
        ArrayList wards = new ArrayList();
        ArrayList fromdates = new ArrayList();
        ArrayList todates = new ArrayList();
       /* CompForm compForm = new CompForm();*/
        Collection attendedcomplaints = new ArrayList();
        ArrayList representatives=new ArrayList();
        String compnos="";
        UrbanCompForm frm = (UrbanCompForm)form;
        int i = 0;
        String dmessage = "";
        String tdate = "";
        String frdt = "";
        String frmdt = "";
        int p=0;
        String gmessage="";
        Collection complaintsgeneric=new ArrayList();
        String mode = request.getParameter("mode");
        
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(mode != null && mode.equalsIgnoreCase("get2"))
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
            {
                reset(frm);
               
                session.removeAttribute("compnos");
                session.removeAttribute("representatives");
            }
            try
            {
                complaintMasterData = new ComplaintMasterData();
                urbandistricts = rwsLocations.getUrbanDistricts();
                session.setAttribute("urbandistricts", urbandistricts);
                if(frm.getUrbandist()==null || frm.getUrbandist().equals(""))
                {
                	session.removeAttribute("urbanmandals");
                	//session.removeAttribute("municipailties");
                	session.removeAttribute("wards");
                	session.removeAttribute("Localities");
                }
                if(frm.getUrbandist() != null && !frm.getUrbandist().equals(""))
                {
                	urbanmandals = rwsLocations.getUrbanMandals(frm.getUrbandist());
                    session.setAttribute("urbanmandals", urbanmandals);
                    
                } else
                {
                    session.setAttribute("urbanmandals", new ArrayList());
                }
               /* if(frm.getUrbandist() !=  null && frm.getUrbanmand() != null && !frm.getUrbanmand().equals(""))
                {
                	municipailties = rwsLocations.getMunicipalities(frm.getUrbandist(),frm.getUrbanmand());
                    session.setAttribute("municipailties", municipailties);
                } else
                {
                    session.setAttribute("municipailties", new ArrayList());
                }*/
               
                if(frm.getUrbandist() !=  null && frm.getUrbanmand() != null &&  !frm.getUrbanmand().equals(""))
                {
                    wards = rwsLocations.getWards(frm.getUrbandist(),frm.getUrbanmand());
                    session.setAttribute("wards", wards);
                } else
                {
                    session.setAttribute("wards", new ArrayList());
                }
                
                if(frm.getUrbandist() !=null && frm.getUrbanmand() != null &&  frm.getWard() != null && !frm.getWard().equals("") )
                {
                	//Localities = rwsLocations.getLocalities(frm.getUrbandist(),frm.getUrbanmand(),frm.getMuncpl(),frm.getWard());
                	Localities = rwsLocations.getLocalities(frm.getUrbandist(),frm.getUrbanmand(),frm.getWard());
                    session.setAttribute("Localities", Localities);
                } else
                {
                    session.setAttribute("Localities", new ArrayList());
                }
               
                page_to_be_displayed = "get2";
            }
            catch(Exception e)
            {
                System.out.println("the error in Complaint get2 is " + e);
            }
        }
        if(mode != null && mode.equalsIgnoreCase("view"))
        { 
        	 complaintMasterData=new ComplaintMasterData();
        	 session.removeAttribute("compnos");
        	 
        	
        	 
       //  Debug.println("In genrate mode....");
         try{
        	 
         String localcode=request.getParameter("localcode");
        	 System.out.println("habitationcode uin action"+localcode);
        	 
        	 String location=complaintMasterData.getLocation(localcode);	 
        	 request.setAttribute("location",location);        	 
        	 
         representatives = complaintMasterData.getRepresentatives(getDataSource(request));
         session.setAttribute("representatives", representatives);
         Debug.println("session:"+session.getAttribute("asset"));
         if(frm.getLocalCode()!=null && !frm.getLocalCode().equals("")){
         compnos = ComplaintMasterData.getNextComplaintNoother(frm.getUrbandist(),frm.getUrbanmand(),frm.getWard(), getDataSource(request));
        	 //compnos = ComplaintMasterData.getNextComplaintNoother(frm.getUrbandist(),  frm.getUrbanmand(), getDataSource(request));
        // Debug.println("compnos" + compnos);
         session.setAttribute("compnos", compnos);
         }
         }catch(Exception e)
		 {
         	Debug.println("Exception in Genrate mode:"+e);
		 }
         page_to_be_displayed="view";
        }
        
        
      
        
        
        if(mode != null && mode.equalsIgnoreCase("save"))
        {
            	
            System.out.println("save mode ............");
         	Debug.println("Mode" + mode);
         	ComplaintMasterData dao=new ComplaintMasterData();
         	
             try 
             {
                
                 
             	String targetPath = getServlet().getServletContext().getRealPath(
     					"")
     					+ File.separator + "temp.jpg";
     			
     			
                 message = ComplaintMasterData.insertUrbanComplaintgeneric(frm,targetPath,getServlet(),loggedUser);
                 Debug.println("Compcount" + compCount);
                
                
                 
     			
                 request.setAttribute("message", message);
                 resetsave(frm);
                 compnos = ComplaintMasterData.getNextComplaintNoother(frm.getUrbandist(), frm.getUrbanmand(), frm.getWard(), getDataSource(request));
                
                 Debug.println("compnos" + compnos);
                 session.setAttribute("compnos", compnos);
                
             }
             catch(Exception e)
             {
                 System.out.println("The error is Asset Complaints Save" + e);
             }
             
             page_to_be_displayed = "openNew";
         }
        if(mode != null && mode.equalsIgnoreCase("openNew"))
        	page_to_be_displayed = "openNew";
       
        if(mode != null && mode.equalsIgnoreCase("cdelete"))
        { 

         try{
         String comp=request.getParameter("complntno");
       	 complaintMasterData=new ComplaintMasterData();
    	 p=ComplaintMasterData.deleteUrbangeneric(comp,getDataSource(request));
    
    	 Debug.println("p Value*********aaa**"+p);
    	 if(p>0)
    	 {
    	 	message="Record Deleted Successfully";
    	 }
    	 else
    	 {
    	 	message="Record Cannot be Deleted";
    	 }
    	 request.setAttribute("message",message);
    	 
   //  Debug.println("In genrate mode....");         
         
         }catch(Exception e)
		 {
         	Debug.println("Exception in Genrate mode:"+e);
		 }
         page_to_be_displayed="cview";
        /* return mapping.findForward("closeWithMessage");*/
        }
        //
        if(mode.equalsIgnoreCase("get"))
            try
            {
                form = buildCompForm(request.getParameter("complntno"), mode, request);
                if("request".equalsIgnoreCase(mapping.getScope()))
                    request.setAttribute(mapping.getAttribute(), form);
                else
                    session.setAttribute(mapping.getAttribute(), form);
                page_to_be_displayed = "get";
            }
            catch(Exception exception) { }
        if(mode.equalsIgnoreCase("edit"))
        {
            try
            {
            	UrbanCompForm compForm = new UrbanCompForm();
                compForm.setComplntdesc(frm.getComplntdesc());
                compForm.setComplntdt(frm.getComplntdt());
                
                compForm.setRepCode(frm.getRepCode());
                compForm.setName(frm.getName());
                compForm.setAddress(frm.getAddress());
                compForm.setPhoneNo(frm.getPhoneNo());
                compForm.setComponentName(frm.getComponentName());
                String comp = frm.getComplntno();
                ans = ComplaintMasterData.updateUrbanComplaintnooutgeneric(compForm, comp, getDataSource(request));
                Debug.println("Answer" + ans);
                if(ans == 1)
                    message = "Record Updated Successfully";
                else
                    message = "Record Not Updated";
                request.setAttribute("message", message);
            }
            catch(Exception o)
            {
                System.out.println("Exception" + o);
            }
            return mapping.findForward("closeWithMessage");
        }
        //
        if(mode != null && mode.equalsIgnoreCase("cview"))
        { 

         try{
         
       	 complaintMasterData=new ComplaintMasterData();
    	 complaintsgeneric=ComplaintMasterData.getUrbanComplaintsgeneric(frm.getUrbandist(),getDataSource(request));
    	 Debug.println("complaintsgeneric size**************"+complaintsgeneric.size());
    	 session.setAttribute("complaintsgeneric",complaintsgeneric);
    	 frm.setComplaintsgeneric(complaintsgeneric);
    	 
     Debug.println("In genrate mode....");         
         
         }catch(Exception e)
		 {
         	Debug.println("Exception in Genrate mode:"+e);
		 }
         page_to_be_displayed="cview";
        }

        
        
        return mapping.findForward(page_to_be_displayed);
    }

    public void reset(UrbanCompForm frm)
    {
        frm.setUrbandist("");
        frm.setUrbanmand("");
        frm.setMuncpl("");
        frm.setWard("");
        frm.setLocalCode("");
        frm.setComplntdesc("");
        frm.setRepCode("");
        frm.setName("");
        frm.setAddress("");
        frm.setPhoneNo("");
        frm.setComponentName("");
        frm.setGrievanceCategory("");
        frm.setGrievanceRelatedTo("");
        frm.setEmailId("");
        }
    public void resetsave(UrbanCompForm frm)
    {
    	frm.setUrbandist("");
        frm.setUrbanmand("");
        frm.setMuncpl("");
        frm.setWard("");
        frm.setLocalCode("");
            
        frm.setComplntdesc("");
        frm.setRepCode("");
        frm.setName("");
        frm.setAddress("");
        frm.setPhoneNo("");
        frm.setComponentName("");
        frm.setGrievanceCategory("");
        frm.setGrievanceRelatedTo("");
        frm.setGrievanceEntryCategory("");
        frm.setEmailId("");
    }

}
