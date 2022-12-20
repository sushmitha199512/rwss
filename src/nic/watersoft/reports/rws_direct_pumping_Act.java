/*
 * Created on 05-Oct-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
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
import nic.watersoft.masters.SubCompMetaData;
/**
 * @author sadiq
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_direct_pumping_Act extends Action {
	
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
	{
		String mode="";
		mode =request.getParameter("mode");
		HttpSession session=request.getSession();
		rws_direct_puming_DAo master=new rws_direct_puming_DAo();
		//rws_asset_CheckList_Bean bean =new rws_asset_CheckList_Bean();
		//SubCompMetaData data=new SubCompMetaData();
		try{
		if(mode.equals("dpump"))
		{
		 String cname=request.getParameter("cname");
		 String scname=request.getParameter("scname");
		 String ccode=request.getParameter("ccode");
		 String divcode=request.getParameter("divcode");
		 String scode=request.getParameter("subcode");
		 String mcode=request.getParameter("mcode");
		 String pcode=request.getParameter("pcode");
		 String vcode=request.getParameter("vcode");
		 String habcode=request.getParameter("habcode");
		 String assetType=request.getParameter("assetType");
		 String codeSeries="";
		 
		 Debug.println("cn:"+cname);
		 Debug.println("scn:"+scname);
		 
		 Debug.println("dcode:"+ccode);
		 Debug.println("mcode:"+mcode);
		 Debug.println("pcode:"+pcode);
		 Debug.println("vcode:"+vcode);
		 Debug.println("habcode:"+habcode);
		 ArrayList distlist=new ArrayList();
		 ArrayList divlist=new ArrayList();
		 ArrayList subdivlist=new ArrayList();
		 ArrayList mandallist=new ArrayList();
		 ArrayList viewlist=new ArrayList();
		 ArrayList panlist=new ArrayList();
		 SubCompMetaData subCompMetaData = new SubCompMetaData(assetType,cname,scname);
		 String check="null";
		 Debug.println("tname:"+subCompMetaData.getTableName());
		 Debug.println("code:"+subCompMetaData.getSchemeCodeField());
		
		if(ccode==null || ccode.equals(""))
		{
		 check="dist";
		distlist=master.getDistValues(subCompMetaData.getTableName(),cname,scname,assetType);
		Debug.println("size:"+distlist.size());
		session.setAttribute("distlist",distlist);
		request.setAttribute("check",check);
		} 
		
		if(ccode!=null && !ccode.equals(""))  
		{
		check="div";
		String dname=request.getParameter("dname");
		//String dname1=bean.getCircleName();
		//Debug.println("dname1:"+dname1);
		divlist=master.getDivValues(subCompMetaData.getTableName(),cname,scname,assetType,ccode,dname);
		session.setAttribute("divlist",divlist);
		request.setAttribute("check",check);
		}
		if(divcode!=null && !divcode.equals(""))
		{
		 check="subdiv";
		// String dname=request.getParameter("dname");
		 //Debug.println("dist name in subdiv check"+dname);
		 String divname=request.getParameter("divname");
		 subdivlist=master.getSubdivValues(subCompMetaData.getTableName(),cname,scname,assetType,ccode,divcode,divname);
		 session.setAttribute("subdivlist",subdivlist);
		 request.setAttribute("check",check);
		}
		if(scode!=null && !scode.equals(""))
		{
		 check="mand";
		 mandallist=master.getMandalValues(subCompMetaData.getTableName(),cname,scname,assetType,ccode,divcode,scode);
		 session.setAttribute("mandallist",mandallist);
		 request.setAttribute("check",check);
	    }
		if(mcode!=null && !mcode.equals(""))
		{
		 check="view";
		 viewlist=master.getViewValues(subCompMetaData.getTableName(),cname,scname,assetType,ccode,divcode,scode,mcode);
		 session.setAttribute("viewlist",viewlist);
		 request.setAttribute("check",check);
		} 
		
		if((pcode!=null && !pcode.equals("")) || (vcode!=null && !vcode.equals(""))|| (habcode!=null && !habcode.equals("")) )
		{
		 check="panch";
		 panlist=master.getPanchValues(subCompMetaData.getTableName(),cname,scname,assetType,ccode,divcode,scode,mcode,pcode,vcode,habcode);
		 session.setAttribute("panlist",panlist);
		 request.setAttribute("check",check);
		}
		
		}
		}catch(Exception e)
		{
			Debug.println("Exception in Direct Pumping Action Class:"+e);
		}
		
	return mapping.findForward(mode);
	}

}
