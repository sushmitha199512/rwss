package nic.watersoft.wquality;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import nic.watersoft.commons.Debug;
/**
 * 
 * @author 
 *
 */
public class rws_WQAssetAct_frm extends Action {
	public rws_WQAssetAct_frm() {
	}

	//

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page_to_be_displayed = " ";
		
		String message = null;
		String name="";
		
		WQAssetForm frm = (WQAssetForm) form;
		int i = 0;

		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList subdivisions=new ArrayList();
		ArrayList assetypes=new ArrayList();
		ArrayList ongoing=new ArrayList();
		ArrayList testtypes=new ArrayList();
		
		ArrayList sources=new ArrayList();
		ArrayList expyears=new ArrayList();
		
		WQAssetData wqAssetData=new WQAssetData();
		int count=0;
		
		

		
		if (mode != null && mode.equalsIgnoreCase("data")) {
			
				
				
			session.removeAttribute("sources");
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset"))
			{
				reset(frm);
				
			}
			//reset(frm);	
			
						
			try {
				
				Debug.println("dataingp^^^^^^^^*******************"+mode);
			 
			
				circles=wqAssetData.getCircles(getDataSource(request));
			session.setAttribute("circles",circles);
			Debug.println("*****************"+circles.size());
			if(frm.getCircleCode() != null && !frm.getCircleCode().equals(""))
			{
				divisions=wqAssetData.getDivisions(getDataSource(request),frm.getCircleCode());
				session.setAttribute("divisions",divisions);
			}
			else
			{
				session.setAttribute("divisions",new ArrayList());
			}
			if(frm.getCircleCode() != null && !frm.getCircleCode().equals("") && frm.getDivisionCode() != null && !frm.getDivisionCode().equals(""))
			{
				subdivisions=wqAssetData.getSubDivisions(getDataSource(request),frm.getCircleCode(),frm.getDivisionCode());
				session.setAttribute("subdivisions",subdivisions);
			}
			else
			{
				session.setAttribute("subdivisions",new ArrayList());
			}
			
			assetypes=wqAssetData.getAssettypes(getDataSource(request));
			session.setAttribute("assetypes",assetypes);
			testtypes=wqAssetData.getTesttypes(getDataSource(request));
			session.setAttribute("testtypes",testtypes);
			expyears=wqAssetData.getExpYears();
			session.setAttribute("expyears",expyears);
			
			
			
			
			
                 
								
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			page_to_be_displayed="data";
		}
		//
		if (mode != null && mode.equalsIgnoreCase("save")) {
			Debug.println("data1<<<<<<<<<<<<<<<<<<<<<<*********"+mode);
			ArrayList resultData = new ArrayList();
			try {

				Debug.println("dataaftertry<<<<<inside save*********"+mode);
				
				String h1 = request.getParameter("hab1");
				Debug.println("hab1<<<<<<<<<<<<<<****jspdata"+h1);
				String habcode1 = request.getParameter("testId");
				Debug.println("hab1****habcodejspdata"+habcode1); 
				String[] records = h1.split(",");
				Debug.println("recordssplit**************"+records);

//				

				sources = (ArrayList) session.getAttribute("sources");
				Debug.println("data2<<<<<inside save*********"+mode);
				

			

				int k = 0;
				for (i = 0; i < records.length - 1; i++) {

					WQAssetForm wqassetBean = (WQAssetForm) sources
							.get(k);

					wqassetBean.setTestId(records[i]);
					i++;
					wqassetBean.setSourceCode(records[i]);
					i++;
					wqassetBean.setActionTaken(records[i]);
					i++;
					wqassetBean.setRemarks(records[i]);
					i++;
					wqassetBean.setParameter1(records[i]);
					
					
					resultData.add(wqassetBean);
					k++;

				}

				WQAssetData wqassetData=new WQAssetData();
				Debug.println("data3<<<<<<<<<<<<<<<<*********"+mode);
				String testid2 = request.getParameter("testId");
				Debug.println("**********123"+testid2);
				                
				count = wqassetData.saveRemarks(resultData);
				Debug.println("count********inaction" + count);
				if (count > 0)
					request
							.setAttribute("message",
									"Selected Sources are Updated Successfully ");
				else
					request.setAttribute("message", "Failed to Save");
				//
			/*	String year1=frm.getFinYear();
				 int year=Integer.parseInt(year1);
				 year=year+1;
				 Debug.println("year1<<<<<<<<<<<<<<"+mode);
				 Debug.println("year1<<<<<<<<<<<<<<"+year1);
				 Debug.println("year<<<<<<<<<<<<<<"+year);
				//

				sources = wqassetData.getTestedContaminatedSourcedetails(frm,frm.getFinYear(),year);
			   session.setAttribute("sources",sources);*/
			} catch (Exception z) {
				z.printStackTrace();
			}

			Debug.println("1<<<<<<<<<<<<<" + page_to_be_displayed);
			page_to_be_displayed = "save";

		}


		//
		if (mode != null && mode.equalsIgnoreCase("ongoingdata"))
		{
		try
		{
			 String year1=frm.getFinYear();
			 int year=Integer.parseInt(year1);
			 String asset=frm.getAssetType();
			 Debug.println("asset<<<<<<<<<<"+asset);
			 year=year+1;
			 Debug.println("year1<<<<<<<<<<<<<<"+mode);
			 Debug.println("year1<<<<<<<<<<<<<<"+year1);
			 Debug.println("year<<<<<<<<<<<<<<"+year);
			 //if(frm.getCircleCode() != null && !frm.getCircleCode().equals("") && frm.getDivisionCode() != null && !frm.getDivisionCode().equals("") && frm.getAssetType() != null && !frm.getAssetType().equals("") && frm.getFinYear() != null && !frm.getFinYear().equals(""))
			 //{
			 //String assetno=wqAssetData.getAssetdetails(frm, frm.getAssetType(), frm.getFinYear(), year);
			 //String assetname=wqAssetData.getAssetNames(frm, frm.getAssetType());
			 //frm.setAssetNo(assetno);
			 //frm.setAssetName(assetname);
			 
			 //}
			 Debug.println("year1(((((((((((<<<<<<<<<<<<<<");
			 //sources=wqAssetData.getListSourcedetails(frm,frm.getFinYear(),year);
			// sources=wqAssetData.getContaminatedSourcedetails(frm,frm.getFinYear(),year);
			 sources=wqAssetData.getTestedContaminatedSourcedetails(frm,frm.getFinYear(),year,asset,frm.getTestType());
			 
			 Debug.println("year1sourcessize*************<<<<<<<<<<<<<<"+sources.size());
			 frm.setSources(sources);
			 session.setAttribute("sources",sources);
			 String type=frm.getTestType();
			 Debug.println("type<<<<<<<<<"+type);
			 session.setAttribute("type",type);
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		page_to_be_displayed="ongoingdata";
		}

	
		
			
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(WQAssetForm frm) {
		frm.setCircleCode("");
		frm.setDivisionCode("");
		frm.setSubdivisionCode("");
		frm.setAssetType("");
		frm.setTestType("");
		frm.setFinYear("");
		
		
		
		
	}
	

	

}

