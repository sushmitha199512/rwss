package nic.watersoft.wquality;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;
import org.apache.commons.lang.StringUtils;

public class rws_WQ_Finalise_Iden_frm extends Action
{
	
	protected ActionForm buildWaterFinalForm(String workCode,HttpServletRequest request) throws Exception 
	{
		ArrayList programmes=new ArrayList();
		ArrayList subprogrammes = new ArrayList();
		ArrayList sources=new ArrayList();
		ArrayList habs=new ArrayList();
		ArrayList sourceCodes=new ArrayList();
		ArrayList assetTypes=new ArrayList();
		ArrayList subCompTypes=new ArrayList();
		
		HttpSession session=request.getSession();
		WQFinalise_IdenForm finalIdenForm = null;
		CommonLists commonLists = new CommonLists(getDataSource(request));
		RwsUser rwsUser=(RwsUser)session.getAttribute("RWS_USER");
		RwsWQuality rwsWQuality=RwsWQualityData.getWQSourceFinIden(workCode,getDataSource(request));
		
			if(rwsWQuality!=null)
			{
				finalIdenForm = new WQFinalise_IdenForm();
				
				finalIdenForm.setHabCode(rwsWQuality.getHabCode());
				finalIdenForm.setSourceCode(rwsWQuality.getSourceCode());
				finalIdenForm.setPrgmCode(rwsWQuality.getPrgmCode());
				if(rwsWQuality.getPrgmCode() != null)
				{
					subprogrammes=commonLists.getSubprogrammes(rwsWQuality.getPrgmCode());
				}
				session.setAttribute("subprogrammes",subprogrammes);
				finalIdenForm.setSubprgmCode(rwsWQuality.getSubprgmCode());
				//System.out.println("work code in build water final form="+workCode+"work code="+rwsWQuality.getWorkCode());						
				
				finalIdenForm.setAssetTypeCode(rwsWQuality.getAssetTypeCode());
				finalIdenForm.setCompTypeCode(rwsWQuality.getCompTypeCode());
				finalIdenForm.setSubCompTypeCode(rwsWQuality.getSubCompTypeCode());
				
				finalIdenForm.setWorkCode(rwsWQuality.getWorkCode());
				finalIdenForm.setSitePlan(rwsWQuality.getSitePlan());
				finalIdenForm.setCasing(rwsWQuality.getCasing());
				finalIdenForm.setDepth(rwsWQuality.getDepth());
				finalIdenForm.setYield(rwsWQuality.getYield());
				finalIdenForm.setSourceCode1(rwsWQuality.getSourceCode1());
				finalIdenForm.setDepth1(rwsWQuality.getDepth1());
				finalIdenForm.setYield1(rwsWQuality.getYield1());
				finalIdenForm.setSourceCode2(rwsWQuality.getSourceCode2());
				finalIdenForm.setDepth2(rwsWQuality.getDepth2());
				finalIdenForm.setYield2(rwsWQuality.getYield2());
				finalIdenForm.setSourceCode3(rwsWQuality.getSourceCode3());
				finalIdenForm.setDepth3(rwsWQuality.getDepth3());
				finalIdenForm.setYield3(rwsWQuality.getYield3());
				finalIdenForm.setEmpcode(rwsWQuality.getEmpcode());
				finalIdenForm.setSiteIdenData(rwsWQuality.getSiteIdenData());
				finalIdenForm.setFinalised(rwsWQuality.getFinalised());
				finalIdenForm.setFinalDate(rwsWQuality.getFinalDate());
				finalIdenForm.setRemarks(rwsWQuality.getRemarks());
				
				
				finalIdenForm.setRemarks(rwsWQuality.getRemarks());
				finalIdenForm.setSourceType(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode()));
				finalIdenForm.setSource1(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode1()));
				finalIdenForm.setSource2(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode2()));
				finalIdenForm.setSource3(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode3()));
				
				
				if(rwsUser.getCircleOfficeCode() != null)				
				{
					habs=RwsWQualityData.getHabCodesForWaterSample(getDataSource(request),rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode(),rwsUser.getSubdivisionOfficeCode());
				}
				session.setAttribute("habs",habs);
				//the following line was commented
				sources=RwsMasterData.getSources(getDataSource(request));//this line was commented
				session.setAttribute("sources",sources);
				
				//System.out.println("sourceType0 is "+RwsWQualityData.getSourceType(rwsWQuality.getSourceCode()));
				//System.out.println("sourceType1 is "+RwsWQualityData.getSourceType(rwsWQuality.getSourceCode1()));
				//System.out.println("sourceType2 is "+RwsWQualityData.getSourceType(rwsWQuality.getSourceCode2()));
				//System.out.println("sourceType3 is "+RwsWQualityData.getSourceType(rwsWQuality.getSourceCode3()));
				
				assetTypes=commonLists.getAssetTypes();
				session.setAttribute("assetTypes",assetTypes);
				//System.out.println("sourceType is "+request.getParameter("sourceType"));
				
				if(finalIdenForm.getAssetTypeCode()!=null && !finalIdenForm.getAssetTypeCode().equals(""))
					subCompTypes=commonLists.getAssetSubComponents(finalIdenForm.getAssetTypeCode(), finalIdenForm.getCompTypeCode());
				session.setAttribute("subCompTypes",subCompTypes);
				
				if(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode())!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),RwsWQualityData.getSourceType(rwsWQuality.getSourceCode()),rwsWQuality.getHabCode());
				session.setAttribute("sourceCodes",sourceCodes);
				
				
				if(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode1())!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),RwsWQualityData.getSourceType(rwsWQuality.getSourceCode1()),rwsWQuality.getHabCode());
				session.setAttribute("sourceCodes1",sourceCodes);
					
				if(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode2())!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),RwsWQualityData.getSourceType(rwsWQuality.getSourceCode2()),rwsWQuality.getHabCode());
				session.setAttribute("sourceCodes2",sourceCodes);
						
				if(RwsWQualityData.getSourceType(rwsWQuality.getSourceCode3())!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),RwsWQualityData.getSourceType(rwsWQuality.getSourceCode3()),rwsWQuality.getHabCode());
				session.setAttribute("sourceCodes3",sourceCodes);
			}
			return finalIdenForm;
	}
	
public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException
{
		int ans = 0;
		String message=null;
		String displaymess=null;
		ArrayList waterSrcFinIden=null;
		ArrayList sources=new ArrayList();
		ArrayList programmes=new ArrayList();
		ArrayList empcodes=new ArrayList();	 
		ArrayList subprogrammes = new ArrayList();
		ArrayList workIds = new ArrayList();
		ArrayList habs = new ArrayList();
		ArrayList assetTypes=new ArrayList();
		ArrayList subCompTypes=new ArrayList();
		
		String workcode=null;
		
		StringUtils stringUtils=new StringUtils();
	
		HttpSession session=request.getSession();
		RwsWQuality rwsWQuality = new RwsWQuality();
		CommonLists commonLists = new CommonLists(getDataSource(request));
		WQFinalise_IdenForm finalIdenForm=(WQFinalise_IdenForm) form;
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String mode=finalIdenForm.getMode();
		ArrayList sourceCodes=new ArrayList();
		//System.out.println("in rws_wq_finalise_iden_frm.java");		
		if(mode.equalsIgnoreCase("data"))
		{
			try
			{
				if(rwsUser.getCircleOfficeCode() != null)				
				{
					habs=RwsWQualityData.getHabCodesForWaterSample(getDataSource(request),rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode(),rwsUser.getSubdivisionOfficeCode());
				}
				session.setAttribute("habs",habs);
				
				if(finalIdenForm.getWorkCode()!=null && !finalIdenForm.getWorkCode().equals("") && (finalIdenForm.getAssetTypeCode().equals("")||finalIdenForm.getAssetTypeCode()==null))
				{
					String assetTypeCode=RwsWQualityData.getWQSourceFinIdenAssetTypeCode(finalIdenForm.getWorkCode(),getDataSource(request));
					finalIdenForm.setAssetTypeCode(assetTypeCode);
					finalIdenForm.setPrgmCode(finalIdenForm.getWorkCode().substring(0,2));
					finalIdenForm.setSubprgmCode(finalIdenForm.getWorkCode().substring(2,4));
					//System.out.println("finalIdenForm.getWorkCode().substring(2,4)="+finalIdenForm.getWorkCode().substring(2,4));
					//System.out.println("assetTypeCode is "+assetTypeCode);
				}
				
				
				//the following line was commented
				sources=RwsMasterData.getSources(getDataSource(request));
				session.setAttribute("sources",sources);
				//this line was commented
				
				assetTypes=commonLists.getAssetTypes();
				session.setAttribute("assetTypes",assetTypes);
				//System.out.println("sourceType is "+request.getParameter("sourceType"));
				
				if(finalIdenForm.getAssetTypeCode()!=null && !finalIdenForm.getAssetTypeCode().equals(""))
				subCompTypes=commonLists.getAssetSubComponents(finalIdenForm.getAssetTypeCode(), finalIdenForm.getCompTypeCode());
				session.setAttribute("subCompTypes",subCompTypes);
				
				/*if(request.getParameter("sourceType")!=null && !request.getParameter("sourceType").equals("") && request.getParameter("habCode")!=null)
				sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),request.getParameter("sourceType"),request.getParameter("habCode"));
				System.out.println("sourceTypes size is "+sourceCodes.size());
				session.setAttribute("sourceCodes",sourceCodes);
				*/
				
				if(request.getParameter("subCompTypeCode")!=null && !request.getParameter("subCompTypeCode").equals("") && request.getParameter("habCode")!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),request.getParameter("assetTypeCode")+request.getParameter("compTypeCode")+request.getParameter("subCompTypeCode"),request.getParameter("habCode"));
			//	System.out.println("sourceTypes size is "+sourceCodes.size());
				session.setAttribute("sourceCodes",sourceCodes);
				
			//	System.out.println("rwsUser.getCircleOfficeCode()="+rwsUser.getCircleOfficeCode()+" rwsUser.getDivisionOfficeCode()="+rwsUser.getDivisionOfficeCode()+" rwsUser.getsubDivisionOfficeCode()="+rwsUser.getSubdivisionOfficeCode());
				
				programmes=commonLists.getProgrammes();
				session.setAttribute("programmes",programmes);
				//code modified on 050407
				//empcodes=RwsWQualityData.getEmpCodesForWaterSample(getDataSource(request),"geologist");
				empcodes=RwsWQualityData.getEmpCodesForWaterSample(getDataSource(request),"lab");
				session.setAttribute("empcodes",empcodes);
				if(finalIdenForm.getPrgmCode() != null)
				{
					if(!finalIdenForm.getPrgmCode().equals("0"))
					{
						subprogrammes=commonLists.getSubprogrammes(finalIdenForm.getPrgmCode());
						//System.out.println("subprogrammes.size()= "+subprogrammes.size());
					}
				}
				session.setAttribute("subprogrammes",subprogrammes);
				
				
				if(!rwsUser.getCircleOfficeCode().equals("00") && !rwsUser.getDivisionOfficeCode().equals("0") && rwsUser.getSubdivisionOfficeCode().equals("00"))
				{
				//	System.out.println("rwsUser.getCircleOfficeCode()="+rwsUser.getCircleOfficeCode()+" rwsUser.getDivisionOfficeCode()="+rwsUser.getDivisionOfficeCode()+" rwsUser.getsubDivisionOfficeCode()="+rwsUser.getSubdivisionOfficeCode());
					//System.out.println("getting workids");
					workIds=RwsWQualityData.getWorkIds(rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode(),"none",getDataSource(request));
				}
				
				session.setAttribute("workIds",workIds);
				
				if(request.getParameter("source1")!=null && !request.getParameter("source1").equals("") && request.getParameter("habCode")!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),request.getParameter("source1"),request.getParameter("habCode"));
				//	System.out.println("sourceTypes size is "+sourceCodes.size());
					session.setAttribute("sourceCodes1",sourceCodes);
					
				if(request.getParameter("source2")!=null && !request.getParameter("source2").equals("") && request.getParameter("habCode")!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),request.getParameter("source2"),request.getParameter("habCode"));
			//	System.out.println("sourceTypes size is "+sourceCodes.size());
				session.setAttribute("sourceCodes2",sourceCodes);
						
				if(request.getParameter("source3")!=null && !request.getParameter("source3").equals("") && request.getParameter("habCode")!=null)
					sourceCodes=RwsWQualityData.getSourceCodes(getDataSource(request),request.getParameter("source3"),request.getParameter("habCode"));
			//	System.out.println("sourceTypes size is "+sourceCodes.size());
				session.setAttribute("sourceCodes3",sourceCodes);
			//	System.out.println("finalIdenForm.getSubprgmCode()="+finalIdenForm.getSubprgmCode());
			}
			catch(Exception e)
			{
				System.out.println("The error in data in rws_WQ_Finalise_Iden_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("view"))
		{
			try
			{
				waterSrcFinIden=RwsWQualityData.getWQSourceFinIdens(getDataSource(request),rwsUser.getCircleOfficeCode(),rwsUser.getDivisionOfficeCode(),rwsUser.getSubdivisionOfficeCode());
				session.setAttribute("waterSrcFinIden",waterSrcFinIden);
			//	System.out.println("waterSrcFinIden.size()="+waterSrcFinIden.size());
			}
			catch(Exception e)
			{
				System.out.println("The error in view in rws_WQ_Finalise_Iden_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("save")||mode.equalsIgnoreCase("edit"))
		{
			try
			{
				FormFile sitePlan = finalIdenForm.getSitePlan();
				String fileExtension = null;
				String fileLocation = null;
				InputStream in = null;
				OutputStream out = null;

				String fileName = sitePlan.getFileName();
				//System.out.println("The File name is:" + fileName + "U");
				
				if(fileName != null && fileName.length() > 0)
				{
					fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
					fileLocation = "webapps\\pred\\uploads\\wquality\\NW_DD_"+finalIdenForm.getWorkCode()+fileExtension;
					in = sitePlan.getInputStream();
					out = new BufferedOutputStream (new FileOutputStream(fileLocation));
					
					byte[] buffer = new byte[512];
					while (in.read(buffer) != -1)
					{
						out.write(buffer);
					}
				}
			}
				catch(Exception e)
				{	
					System.out.println("Water Quality FormFile Exception");
					System.out.println(e+"");
					message = "Cannot upload file.\n" + e.getMessage();
				}
				try{
				rwsWQuality.setCoc(finalIdenForm.getCircleOfficeCode());
				rwsWQuality.setDoc(finalIdenForm.getDivisionOfficeCode());
				rwsWQuality.setSdoc(finalIdenForm.getSubdivisionOfficeCode());
				rwsWQuality.setHabCode(finalIdenForm.getHabCode());
				rwsWQuality.setAssetTypeCode(finalIdenForm.getAssetTypeCode());
				rwsWQuality.setCompTypeCode(finalIdenForm.getCompTypeCode());
				rwsWQuality.setSubCompTypeCode(finalIdenForm.getSubCompTypeCode());
				rwsWQuality.setSourceCode(finalIdenForm.getSourceCode());
				rwsWQuality.setPrgmCode(finalIdenForm.getPrgmCode());
				rwsWQuality.setSubprgmCode(finalIdenForm.getSubprgmCode());
				if(mode.equalsIgnoreCase("edit")){
					 workcode=finalIdenForm.getWorkCode().substring(0,finalIdenForm.getWorkCode().indexOf("-"));
					 //System.out.println("work code in edit="+workcode);
					 rwsWQuality.setWorkCode(workcode);
				}
				else
				rwsWQuality.setWorkCode(finalIdenForm.getWorkCode());
				rwsWQuality.setSitePlan(finalIdenForm.getSitePlan());
				rwsWQuality.setCasing(finalIdenForm.getCasing());
				rwsWQuality.setDepth(finalIdenForm.getDepth());
				rwsWQuality.setYield(finalIdenForm.getYield());
				rwsWQuality.setSource1(finalIdenForm.getSource1());
				rwsWQuality.setSourceCode1(finalIdenForm.getSourceCode1());
				rwsWQuality.setDepth1(finalIdenForm.getDepth1());
				rwsWQuality.setYield1(finalIdenForm.getYield1());
				rwsWQuality.setSource2(finalIdenForm.getSource2());
				rwsWQuality.setSourceCode2(finalIdenForm.getSourceCode2());
				rwsWQuality.setDepth2(finalIdenForm.getDepth2());
				rwsWQuality.setYield2(finalIdenForm.getYield2());
				rwsWQuality.setSource3(finalIdenForm.getSource3());
				rwsWQuality.setSourceCode3(finalIdenForm.getSourceCode3());
				rwsWQuality.setDepth3(finalIdenForm.getDepth3());
				rwsWQuality.setYield3(finalIdenForm.getYield3());
				rwsWQuality.setEmpcode(finalIdenForm.getEmpcode());
				rwsWQuality.setSiteIdenData(finalIdenForm.getSiteIdenData());
				rwsWQuality.setFinalised(finalIdenForm.getFinalised());
				rwsWQuality.setFinalDate(finalIdenForm.getFinalDate());
				rwsWQuality.setRemarks(finalIdenForm.getRemarks());
				rwsWQuality.setPreparedBy(finalIdenForm.getPreparedBy());
				rwsWQuality.setPreparedOn(finalIdenForm.getPreparedOn());
				rwsWQuality.setOfficeCode(rwsUser.getOfficeCode());
				
				ans=RwsWQualityData.insertWQSourceFinIden(rwsWQuality,getDataSource(request));
				
				finalIdenForm.reset(mapping,request);
			}
			catch(Exception e)
			{
				System.out.println("The error in insert in rws_WQ_Finalise_Iden_frm is  "+e);	
			}
			if(ans <1)
			{
				message="The Record Cant be inserted   ";
			}
			else
			{
				message="Record Inserted Successfully";
			}
			request.setAttribute("message",message);
		}
		if(mode.equalsIgnoreCase("get") || mode.equalsIgnoreCase("update"))
		{
			try 
			{
				
				form = buildWaterFinalForm(request.getParameter("workCode"),request);
				if ("request".equals(mapping.getScope())) 
				{
					request.setAttribute(mapping.getAttribute(), form);
				}
				else 
				{
					session.setAttribute(mapping.getAttribute(), form);
				}
			}
			catch (Exception e) 
			{
				System.out.println("The error in get in rws_WQ_Finalise_Iden_frm is  "+e);
			}
		}
		if(mode.equalsIgnoreCase("delete"))
		{
			try 
			{
				workcode=request.getParameter("workCode");
				//workcode=workcode.substring(0,workcode.indexOf("-"));
				//System.out.println("Work Code In Delete="+workcode);
				ans=RwsWQualityData.removeWQSourceFinIdens(workcode,getDataSource(request));
				if(ans>0)
				{
					displaymess = "Data deleted Succesfully";
				}
				else
				{
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess",displaymess);
			}
			catch (Exception e) 
			{
				System.out.println("the error in rws_WQ_Finalise_Iden_frm delete is "+e);	
			}
		}	
		if(mode.equalsIgnoreCase("newSource"))
		{
			ArrayList schemeCodes=new ArrayList();
			ArrayList rnos=new ArrayList();
			finalIdenForm.setNewSource("true");
			//System.out.println("sourceType is "+finalIdenForm.getSourceType());
			SubCompMetaData subCompMetaData=new SubCompMetaData(finalIdenForm.getAssetTypeCode(),finalIdenForm.getCompTypeCode(),finalIdenForm.getSubCompTypeCode());
			finalIdenForm.setSchemeRep(subCompMetaData.getSubCompRep());
			//System.out.println("schemeCodeRep="+subCompMetaData.getSubCompRep());
			///
			
			if(finalIdenForm.getAssetTypeCode()!=null && finalIdenForm.getSubCompTypeCode()!=null)
			{
				
				
				String schemeCodeSeries=subCompMetaData.getSchemeCodeSeries();
//				System.out.println("schemeCodeSeries is "+schemeCodeSeries);
				for(int i=Integer.parseInt(schemeCodeSeries);i<=Integer.parseInt(schemeCodeSeries)+99;i++)
				{
					LabelValueBean labelValueBean=new LabelValueBean();
					labelValueBean.setValue(i+"");
					labelValueBean.setLabel(i+"");
					schemeCodes.add(labelValueBean);
				
				}
				String value="";
				for(int i=1;i<=999;i++)
				{
					LabelValueBean labelValueBean=new LabelValueBean();
					if(i<10)
						value="00"+i;
					else if(i<100)
						value="0"+i;
					else
						value=""+i;
					labelValueBean.setValue(value);
					labelValueBean.setLabel(value);
					rnos.add(labelValueBean);
					
				}
			}
			///
			session.setAttribute("newSource","true");
			session.setAttribute("schemeCodes",schemeCodes);
			session.setAttribute("rnos",rnos);
			//System.out.println("schemeCodes size is "+schemeCodes.size());
			//System.out.println("rnos size is "+rnos.size());
		}
		
		//System.out.println("opType is "+request.getParameter("opType"));
		if(request.getParameter("opType")!=null && request.getParameter("opType").equals("edit"))
		return mapping.findForward("get");
			
		return(mapping.findForward(mode));
	}
}
