package nic.watersoft.reports;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import nic.watersoft.commons.*;

/**
 * @version 	1.0
 * @author
 */
public class DistrictListAction extends Action

{

    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {


    	Debug.println("in DistrictListAction");
    	
    	String districtcode;
    	String distname;
    	String target=new String("success");
    	String mode=request.getParameter("mode");
    	districtcode=request.getParameter("dcode");
    	
    	HttpSession session=request.getSession(true);
    	session.setAttribute("districtcode",districtcode);
    	ArrayList panchayatdisplays=new ArrayList();
    	ArrayList mandaldisplay=new ArrayList();
    	ArrayList panchayatdisplay=new ArrayList();
    	ArrayList villagedisplay=new ArrayList();
    	ArrayList habitationdisplay=new ArrayList();
    	int i=0;
    	int p=0;
    	int v=0;
    	int pc=0;
    	
        try
		{
        	
        	StateBean state=new StateBean();
            StateForm stateForm=(StateForm)form;
            StateData empData=new StateData();
            state.setDcode(stateForm.getDcode());
            state.setDname(stateForm.getDname());
            state.setMcount(stateForm.getMcount());
            state.setPcount(stateForm.getPcount() );
            state.setVcount(stateForm.getVcount() );
            state.setPanchcount(stateForm.getPanchcount() );
            
            
            panchayatdisplays=StateData.getPanchayatdisplays(getDataSource(request));
            //i=StateData.getManCount(districtcode,getDataSource(request) );
           // p=StateData.getPanCount(getDataSource(request) );
           // v=StateData.getVillCount(getDataSource(request) );
           // pc=StateData.getPanchCount(getDataSource(request) );
           // Integer s=new Integer(i);
            //session.setAttribute("s",s);
           // Integer pa=new Integer(p);
           // session.setAttribute("pa",pa);
            //Integer vi=new Integer(v);
            //Integer pca=new Integer(pc);
            //session.setAttribute("vi",vi);
            //session.setAttribute("pca",pca);
            
            
            session.setAttribute("panchayatdisplays",panchayatdisplays);
            //System.out.println("panchayatdisplays"+panchayatdisplays);
            if(mode != null && mode.equals("mandal"))
            {
            	target="mandal";
            	distname=StateData.getDistrictname(districtcode,getDataSource(request));
            	session.setAttribute("distname",distname);
            	state.setMcode(  stateForm.getMcode() );
            	state.setMname( stateForm.getMname() );
             mandaldisplay=StateData.getMandal(districtcode,getDataSource(request));
             session.setAttribute("mandaldisplay",mandaldisplay);
            }
            if(mode != null && mode.equals("panchayat"))
            {
            	target="panchayat";
            	distname=StateData.getDistrictname(districtcode,getDataSource(request));
            	session.setAttribute("distname",distname);
            	state.setMcode(stateForm.getMcode() );
            	state.setPcode(  stateForm.getPcode() );
            	state.setPname( stateForm.getPname() );
             panchayatdisplay=StateData.getPanchayat(districtcode,getDataSource(request));
             session.setAttribute("panchayatdisplay",panchayatdisplay);
            }
            if(mode != null && mode.equals("village"))
            {
            	target="village";
            	distname=StateData.getDistrictname(districtcode,getDataSource(request));
            	session.setAttribute("distname",distname);
            	state.setPcode(stateForm.getPcode() );
            	state.setVcode(  stateForm.getVcode() );
            	state.setVname( stateForm.getVname() );
             villagedisplay=StateData.getVillage(districtcode,getDataSource(request));
             session.setAttribute("villagedisplay",villagedisplay);
            }
            if(mode != null && mode.equals("habitation"))
            {
            	target="habitation";
            	distname=StateData.getDistrictname(districtcode,getDataSource(request));
            	session.setAttribute("distname",distname);
            	state.setPanchcode(stateForm.getPanchcode() );
            	state.setPanchname(  stateForm.getPanchname() );
            	
             habitationdisplay=StateData.getHabitation(districtcode,getDataSource(request));
             session.setAttribute("habitationdisplay",habitationdisplay);
            }
		}
		
        
        catch(Exception e)
		{
        	//System.out.println("error is "+e);
		}
        Debug.println("Target:"+target);
         return (mapping.findForward(target));

    }
}


    	
    	
        
