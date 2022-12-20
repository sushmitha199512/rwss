package nic.watersoft.complaints;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import nic.watersoft.commons.*;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;


public class rws_AsstComplaintAct_frm extends Action
{
	String cmpCode="";
    public rws_AsstComplaintAct_frm()
    {
        complaintprint = new ArrayList();
        dname = "";
        
    }

    protected ActionForm buildCompForm(String complaintno, String mode, HttpServletRequest request)
        throws Exception
    {
        CompForm form = null;
        
        CompForm compForm = ComplaintMasterData.getComplaintno(complaintno, getDataSource(request));
        ArrayList districts = new ArrayList();
        ArrayList mandals = new ArrayList();
        ArrayList panchayats = new ArrayList();
        HttpSession session = request.getSession();
        ArrayList habitations = new ArrayList();
        ArrayList assts = new ArrayList();
        ArrayList assettypes = new ArrayList();
        ArrayList representatives = new ArrayList();
        ArrayList categorytypes=new ArrayList();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        if(compForm != null)
        {
            Debug.println("inside if");
            form = new CompForm();
            ComplaintMasterData complaintMasterData = new ComplaintMasterData();
            Debug.println("inside the" + request.getParameter("dist") + compForm.getDist());
            districts = rwsLocations.getDistricts();
            session.setAttribute("districts", districts);
            form.setAssetName(compForm.getAssetName());
            Debug.println("Asset" + compForm.getAsset());
            assettypes = ComplaintMasterData.getAssetTypes(getDataSource(request));
            session.setAttribute("assettypes", assettypes);
            form.setAsset(compForm.getAsset());
            form.setDistrictName(compForm.getDistrictName());
            mandals = rwsLocations.getMandals(compForm.getDist());
            session.setAttribute("mandals", mandals);
            form.setMandalName(compForm.getMandalName());
            panchayats = rwsLocations.getPanchayats(compForm.getDist(), compForm.getMand());
            session.setAttribute("panchayats", panchayats);
            Debug.println("GetMandals" + compForm.getMand());
            Debug.println("GetMandals1" + form.getMand());
            form.setPanchayatName(compForm.getPanchayatName());
            habitations = rwsLocations.getPanchayatHabitations(compForm.getDist(), compForm.getMand(), compForm.getPanch());
            session.setAttribute("habitations", habitations);
            assts = ComplaintMasterData.getAssts(compForm.getHabCode(), compForm.getAsset(), getDataSource(request));
            form.setAssts(compForm.getAssts());
            Debug.println("GetPanchyats" + compForm.getPanch());
            form.setHabName(compForm.getHabName());
            Debug.println("GetHabitations" + compForm.getHabCode());
            assts = ComplaintMasterData.getAssts(compForm.getHabCode(), compForm.getAsset(), getDataSource(request));
            session.setAttribute("assts", assts);
            form.setComplntno(compForm.getComplntno());
            Debug.println("GetComplaintno" + compForm.getComplntno());
            form.setComplntdt(compForm.getComplntdt());
            Debug.println("GetComplaintdate" + compForm.getComplntdt());
            form.setComplntdesc(compForm.getComplntdesc());
            Debug.println(form.getComplntdesc());
            Debug.println("GetComplaintdesc" + compForm.getComplntdesc());
                    
            form.setCategory(compForm.getCategory());
            String code=ComplaintMasterData.getCpcode(compForm.getComplntno());
            categorytypes = ComplaintMasterData.getCategoryTypes(form.getAsset(),code);
            session.setAttribute("categorytypes",categorytypes);
            Debug.println("GetCategory" + compForm.getCategory());
            form.setRepCode(compForm.getRepCode());
            representatives = complaintMasterData.getRepresentatives(getDataSource(request));
            session.setAttribute("representatives", representatives);
            Debug.println("GetCategory" + compForm.getRepCode());
            form.setName(compForm.getName());
            Debug.println("GetName" + compForm.getName());
            form.setAddress(compForm.getAddress());
            Debug.println("GetAddress" + compForm.getAddress());
            form.setPhoneNo(compForm.getPhoneNo());
            form.setInwardNo(compForm.getInwardNo());
        }
        return form;
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String page_to_be_displayed = "get2";
        ComplaintMasterData ComplaintMasterData = new ComplaintMasterData();
        int ans = 0;
        String message = null;
        ArrayList districts = new ArrayList();
        ArrayList representatives = new ArrayList();
        int compCount = 0;
        ArrayList mandals = new ArrayList();
        String compnos = "";
        ArrayList categorytypes = new ArrayList();
        ArrayList panchayats = new ArrayList();
        ArrayList habitations = new ArrayList();
        ArrayList assettypes = new ArrayList();
        ArrayList assts = new ArrayList();
        Collection complaints = new ArrayList();
        RwsMaster rwsMaster = new RwsMaster();
        CompForm frm = (CompForm)form;
        int i = 0;
        String dmessage = "";
        String asst = "";
        String mode = request.getParameter("mode");
        System.out.println("mode:" + mode);
        HttpSession session = request.getSession();
        RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
        int compno = 0;
        try
        {
            if(request.getParameter("special") != null && request.getParameter("special").equals("reset"))
              resetasset(frm);
            
            if(mode != null && mode.equalsIgnoreCase("data"))
            {
            	Debug.println("in data mode :" + frm.getAsset());
            	asst = frm.getAsset();
            	System.out.println("requested asset:"+request.getParameter("asset"));
            	System.out.println("form value asset:"+asst);
                session.setAttribute("asst", request.getParameter("asset"));
            	if(frm.getAsset() != null && !frm.getAsset().equalsIgnoreCase(""))
                { 
            		Debug.println("11111111");
                 	districts = rwsLocations.getDistricts();
                    Debug.println("dist size:"+districts.size());
                    session.setAttribute("districts", districts);
                    session.setAttribute("mandals", new ArrayList());
                    session.setAttribute("panchayats", new ArrayList());
                    session.setAttribute("habitations", new ArrayList());
                    session.setAttribute("assts1",new ArrayList());
                    session.setAttribute("assts",new ArrayList());
                    session.setAttribute("categorytypes",new ArrayList());
                    
                }else{
                	Debug.println("22222222");
                	 session.setAttribute("districts", new ArrayList());
                	 session.setAttribute("mandals", new ArrayList());
                     session.setAttribute("panchayats", new ArrayList());
                     session.setAttribute("habitations", new ArrayList());
                     session.setAttribute("assts1",new ArrayList());
                     session.setAttribute("assts",new ArrayList());
                     session.setAttribute("categorytypes",new ArrayList());
                }
            }
            if(mode != null && mode.equalsIgnoreCase("get2"))
            {
            	Debug.println("get21");
                if(frm.getDist() != null && !frm.getDist().equals(""))
                {
                    mandals = rwsLocations.getMandals(frm.getDist());
                    session.setAttribute("mandals", mandals);
                    session.setAttribute("assts", new ArrayList());
                } else
                {
                    session.setAttribute("mandals", new ArrayList());
                    session.setAttribute("assts1",new ArrayList());
                    session.setAttribute("assts",new ArrayList());
                }
               
                if(frm.getDist() != null && frm.getMand() != null && !frm.getMand().equals(""))
                {
                    panchayats = rwsLocations.getPanchayats(frm.getDist(), frm.getMand());
                    session.setAttribute("panchayats", panchayats);
                } else
                {
                    session.setAttribute("panchayats", new ArrayList());
                    session.setAttribute("assts1",new ArrayList());
                    session.setAttribute("assts",new ArrayList());
                }
               if(frm.getDist() != null && frm.getMand() != null && frm.getPanch() != null && !frm.getPanch().equals(""))
                {
                    habitations = rwsLocations.getPanchayatHabitations(frm.getDist(), frm.getMand(), frm.getPanch());
                    session.setAttribute("habitations", habitations);
                } else
                {
                    session.setAttribute("habitations", new ArrayList());
                    session.setAttribute("assts1",new ArrayList());
                    session.setAttribute("assts",new ArrayList());
                }
               if(frm.getAsset() == null || frm.getAsset().equals(""))
                 {
               		Debug.println("3333333");
               		session.setAttribute("districts", new ArrayList());
                    session.setAttribute("mandals", new ArrayList());
                    session.setAttribute("panchayats", new ArrayList());
                    session.setAttribute("habitations", new ArrayList());
                }
                
               /* if(frm.getAsset().equals("03"))  
                {
                assts = ComplaintMasterData.getAsstsastss(frm.getHabCode(), frm.getAsset(),frm.getDist(),getDataSource(request));
                session.setAttribute("assts1",((ArrayList)assts.get(0)));
                session.setAttribute("assts",((ArrayList)assts.get(1)));
                Debug.println("size:"+assts.size());
                }*/
            }    
        } 
        catch(Exception e)
        {
            System.out.println("the error in  get2 is in complaints Registration " + e);
        }
        
        if(mode != null && mode.equalsIgnoreCase("view"))
        {
            try
            {
                Debug.println("In view mode");
                resetassetsave(frm);
              
                String a = frm.getAsset();
                if(a==null || (a!=null && a.equals(""))){
                	frm.setAsset(request.getParameter("asset"));}
                if(frm.getDist()==null || ( frm.getDist()!=null &&  frm.getDist().equals(""))){
                	frm.setDist(request.getParameter("dcode"));}
                if(frm.getMand()==null || ( frm.getMand()!=null &&  frm.getMand().equals(""))){
                	frm.setMand(request.getParameter("mcode"));}
                if(frm.getPanch()==null || ( frm.getPanch()!=null &&  frm.getPanch().equals(""))){
                	frm.setPanch(request.getParameter("pcode"));}
                if(frm.getPanch()==null || ( frm.getPanch()!=null &&  frm.getPanch().equals(""))){
                	frm.setHabCode(request.getParameter("hcode"));	
                }
                Debug.println("Type of Assetcode:" + a);
                Debug.println("Type of Assetcode1:" + frm.getAsset());
                Debug.println("frm.getDist():"+frm.getDist());
                Debug.println("frm.getMand()"+frm.getMand());
                Debug.println("panch:"+frm.getPanch());  
                Debug.println("hab:"+frm.getHabCode());
                if(frm.getAsset() != null && !frm.getAsset().equalsIgnoreCase("") && frm.getDist() != null && !frm.getDist().equalsIgnoreCase("") && frm.getHabCode() != null && !frm.getHabCode().equalsIgnoreCase(""))
                {
                    Debug.println("In view mode 111111");
                    a = frm.getAsset();
                    if(frm.getAsset().equals("01") || frm.getAsset().equals("02") || frm.getAsset().equals("03") || frm.getAsset().equals("09"))
                    {
                        Debug.println(" inside 01 || 02 || 03 ");
                        assts = nic.watersoft.complaints.ComplaintMasterData.getAsstsastss(frm.getHabCode(), frm.getAsset(),frm.getDist(),getDataSource(request));
                        session.setAttribute("assts1",((ArrayList)assts.get(0)));
                        session.setAttribute("assts",((ArrayList)assts.get(1)));
                        frm.setAssts(((ArrayList)assts.get(1)));
                        
                    } else
                    if(frm.getAsset().equals("04") || frm.getAsset().equals("05") || frm.getAsset().equals("06") || frm.getAsset().equals("07"))
                    {
                        Debug.println("In view mode else part");
                        assts = nic.watersoft.complaints.ComplaintMasterData.getAssts(frm.getHabCode(), frm.getAsset(),getDataSource(request));
                        Debug.println("sssssss:"+assts);
                        session.setAttribute("assts",assts);
                        frm.setAssts(assts);
                    }
                } 
                else{
                	session.setAttribute("assts",new ArrayList());
                	session.setAttribute("assts1",new ArrayList());
                }
         
            }
            catch(Exception e)
            {
                System.out.println("The error in Asst View is " + e);
            }
            page_to_be_displayed = "view";
            session.setAttribute("asst", request.getParameter("asset"));
        }
        
        if(mode != null && mode.equalsIgnoreCase("genrate"))
        { 
         Debug.println("In genrate mode....");
         try{
         cmpCode=request.getParameter("cmpcode");
         Debug.println("cmpCode:"+cmpCode);
         frm.setCompCode(cmpCode);
         categorytypes = ComplaintMasterData.getCategoryTypes(frm.getAsset(),cmpCode);
         Debug.println("categorytypes:"+categorytypes);
         Debug.println("size::"+categorytypes.size()); 
         session.setAttribute("categorytypes", categorytypes);
         representatives = ComplaintMasterData.getRepresentatives(getDataSource(request));
         session.setAttribute("representatives", representatives);
         Debug.println("session:"+session.getAttribute("asset"));
         
         compnos = nic.watersoft.complaints.ComplaintMasterData.getNextComplaintNo(frm.getDist(), frm.getAsset(), frm.getMand(), frm.getPanch(), getDataSource(request));
         Debug.println("compnos" + compnos);
         session.setAttribute("compnos", compnos);
         }catch(Exception e)
		 {
         	Debug.println("Exception in Genrate mode:"+e);
		 }
         page_to_be_displayed="genrate";
        }
        if(mode != null && mode.equalsIgnoreCase("save"))
        {
           System.out.println("save mode ............");
        	Debug.println("Mode" + mode);
            try 
            {
                RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
                String officecode = user.getOfficeCode();
                Debug.println("officecode" + officecode);
                CompForm compForm = new CompForm();
                String assetcode = frm.getAssetCode();
                String sourcecode = frm.getSourceCode();
                Debug.println("assetcode" + assetcode);
                Debug.println("sourcecode111:" + sourcecode);
                Debug.println(" frm.getComplntno() $$$$$$$$:"+ frm.getComplntno());
                String complaintno = frm.getComplntno();
                String inwardno = frm.getInwardNo();
                String date = frm.getComplntdt();
                String category = frm.getCategory();
                String desc = frm.getComplntdesc();
                String givenby = frm.getRepCode();
                String name = frm.getName();
                String address = frm.getAddress();
                String phone = frm.getPhoneNo();
                String cmpCode=frm.getCompCode();
               // String cmpCode=request.getParameter("cmpcode");
                Debug.println("frm.getCompCode():"+cmpCode);
                int as = 0;
                Collection a = (ArrayList)session.getAttribute("assts");
                if(a != null)
                    as = a.size();
                System.out.println("A Size in before::" + as);
                compCount = nic.watersoft.complaints.ComplaintMasterData.insertComplaint(complaintno, inwardno, date, category, desc, givenby, name, address, phone, compForm, assetcode, sourcecode, officecode,cmpCode, getDataSource(request));
                Debug.println("Compcount" + compCount);
                String co = frm.getComplntno();
                if(compCount < 1)
                	message = "Record Can't be inserted";
                    
                else
                	message = "Your Complaint is Registered with Complaint Number : " + co;
                Debug.println("message" + message);
                request.setAttribute("message", message);
                resetassetsave(frm);
                if(frm.getAsset().equals("01") || frm.getAsset().equals("02") || frm.getAsset().equals("03") || frm.getAsset().equals("09"))
                {
                    Debug.println(" inside 01 || 02 || 03 ");
                    assts = nic.watersoft.complaints.ComplaintMasterData.getAsstsastss(frm.getHabCode(), frm.getAsset(),frm.getDist(),getDataSource(request));
                    Debug.println("inside 01 || 02 || 03");
                }
                if(frm.getAsset().equals("04") || frm.getAsset().equals("05") || frm.getAsset().equals("06") || frm.getAsset().equals("07"))
                {
                    Debug.println("04-handpumps");
                    assts = nic.watersoft.complaints.ComplaintMasterData.getAssts(frm.getHabCode(), frm.getAsset(), getDataSource(request));
                }
                session.setAttribute("assts", assts);
                frm.setAssts(assts);
                
                compnos = nic.watersoft.complaints.ComplaintMasterData.getNextComplaintNo(frm.getDist(), frm.getAsset(), frm.getMand(), frm.getPanch(), getDataSource(request));
                Debug.println("compnos" + compnos);
                session.setAttribute("compnos", compnos);
                session.setAttribute("asst", request.getParameter("asset"));
            }
            catch(Exception e)
            {
                System.out.println("The error is Asset Complaints Save" + e);
            }
            int as = 0;
            Collection a = (ArrayList)session.getAttribute("assts");
            if(a != null)
                as = a.size();
            System.out.println("A Size::" + as);
            page_to_be_displayed = "openNew";
        }
        if(mode != null && mode.equalsIgnoreCase("openNew"))
            page_to_be_displayed = "openNew";
        if(mode != null && mode.equalsIgnoreCase("cview"))
        {
            Debug.println("Mode" + mode);
            try
            {
                complaints = nic.watersoft.complaints.ComplaintMasterData.getComplaints(frm.getAsset(), frm.getDist(), getDataSource(request));
                Debug.println("Complaints" + complaints);
                Debug.println("size" + complaints.size());
                session.setAttribute("complaints", complaints);
            }
            catch(Exception e)
            {
                System.out.println("The error is Asset Complaints CView" + e);
            }
            page_to_be_displayed = "cview";
        }
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
                CompForm compForm = new CompForm();
                compForm.setComplntdesc(frm.getComplntdesc());
                compForm.setComplntdt(frm.getComplntdt());
                compForm.setCategory(frm.getCategory());
                compForm.setRepCode(frm.getRepCode());
                compForm.setName(frm.getName());
                compForm.setAddress(frm.getAddress());
                compForm.setInwardNo(frm.getInwardNo());
                compForm.setPhoneNo(frm.getPhoneNo());
                Debug.println("frm.getCategory()" + frm.getCategory());
                String comp = frm.getComplntno();
                ans = nic.watersoft.complaints.ComplaintMasterData.updateComplaintno(compForm, comp, getDataSource(request));
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
        if(mode != null && mode.equalsIgnoreCase("cdelete"))
        {
            Debug.println("Cdelete2");
            Debug.println("Mode" + mode);
            try
            {
                String cono = request.getParameter("complntno");
                Debug.println("cono" + cono);
                Debug.println("cono" + cono);
                i = ComplaintMasterData.deleteComplaints(cono, getDataSource(request));
                if(i == 1)
                    dmessage = " Record Deleted Successfully";
                else
                    dmessage = " Record Not Deleted ";
                request.setAttribute("message", dmessage);
                Debug.println("dmessage" + dmessage);
            }
            catch(Exception e)
            {
                System.out.println("The error is Asset Complaints cdelete" + e);
            }
            return mapping.findForward("closeWithMessage");
        } else
        {
            System.out.println("exi mode:" + page_to_be_displayed);
            return mapping.findForward(page_to_be_displayed);
        }
    }

    public void resetasset(CompForm frm)
    {
        frm.setAsset("");
        frm.setDist("");
        frm.setMand("");
        frm.setPanch("");
        frm.setHabCode("");
        frm.setName("");
        frm.setAddress("");
        frm.setComplntdesc("");
        frm.setRepCode("");
        frm.setPhoneNo("");
        frm.setInwardNo("");
        frm.setCategory("");
        frm.setComplntdt("");
    }

    public void resetassetsave(CompForm frm)
    {
        
        frm.setName("");
        frm.setAddress("");
        frm.setComplntdesc("");
        frm.setRepCode("");
        frm.setPhoneNo("");
        frm.setInwardNo("");
        frm.setCategory("");
        frm.setComplntdt("");
    }

    ArrayList complaintprint;
    String dname;
}
