package nic.watersoft.works;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Ntr_Sujala_Asset_Convert_Action extends Action
{
			String message = null;

			String page_to_be_displayed = " ";
			int ans = 0;

			public ActionForward execute(ActionMapping mapping, ActionForm form,
					HttpServletRequest request, HttpServletResponse response)
					throws ServletException, IOException 
					{

				Rws_Ntr_Sujala_Asset_Convert_Form frm = (Rws_Ntr_Sujala_Asset_Convert_Form) form;

				HttpSession session = request.getSession();

				RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
				if (user == null) 
				{
					return mapping.findForward("expire");
				}
				
				if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN)
						|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
					return mapping.findForward("unAuthorise");
				}
				session = request.getSession();

				Rws_Ntr_Sujala_Asset_Convert_DAO dao = new Rws_Ntr_Sujala_Asset_Convert_DAO();

				String mode = request.getParameter("mode");
				Connection conn = RwsOffices.getConn();
				
         
				if (mode != null && mode.equalsIgnoreCase("init")) 
				{

					reset(frm);
					frm.getHabList().clear();
					page_to_be_displayed = "data";
				}

				if (mode != null && mode.equalsIgnoreCase("data"))
				{
					if (request.getParameter("special") != null
							&& request.getParameter("special").equals("reset")) {
						reset(frm);
					}
					try 
					{
						frm.getHabList().clear();
						frm.setCircles(dao.getCircles(conn));
						session.setAttribute("circles", frm.getCircles());
						
					} catch (Exception e)
					{
						System.out.println("circles Display exception in Rws_Ntr_Sujala_Asset_Convert_Action--  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    		System.out.println("circles Display exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
						       }

					}

					page_to_be_displayed = "data";
				}

				if (mode != null && mode.equalsIgnoreCase("mandals"))
				{
					if (request.getParameter("special") != null
							&& request.getParameter("special").equals("reset")) {
						reset(frm);
						frm.getHabList().clear();
					}
					try {

						if (frm.getCircleCode() != null)

						{
							frm.getHabList().clear();
							frm.setMandals(dao.getMandals(frm.getCircleCode(),conn));
							session.setAttribute("mandals", frm.getMandals());

						} else 
						{
							session.setAttribute("mandals", new ArrayList());
						}

					} catch (Exception e) {
						System.out.println("mandals display exception in Rws_Ntr_Sujala_Asset_Convert_Action--  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    		System.out.println("mandals display exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
						       }

					}
					page_to_be_displayed = "data";
				}

				if (mode != null && mode.equalsIgnoreCase("years"))
				{
					if (request.getParameter("special") != null
							&& request.getParameter("special").equals("reset")) {
						reset(frm);
						frm.getHabList().clear();
					}
					try {
						if (frm.getCircleCode() != null && frm.getMandal()!=null)

						{
							frm.getHabList().clear();
							frm.setYears(dao.getYears(frm.getCircleCode(),frm.getMandal(),conn));
							session.setAttribute("years", frm.getYears());

						} else 
						{
							session.setAttribute("years", new ArrayList());
						}

					} catch (Exception e) {
						System.out.println("years display exception in Rws_Ntr_Sujala_Asset_Convert_Action --  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    	   System.out.println("years display exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
						       }

					}
					page_to_be_displayed = "data";
				}
				

				if (mode != null && mode.equalsIgnoreCase("habList")) 
				{
					if (request.getParameter("special") != null
							&& request.getParameter("special").equals("reset")) 
					{
						reset(frm);
					}
					try {
						if (frm.getCircleCode() != null 
								&& frm.getMandal() != null
								&& frm.getYear() != null
								&& !frm.getCircleCode().equals("")  
								&& !frm.getMandal().equals("")
								&& !frm.getYear().equals(""))
						{
							
							frm.setHabList(dao.getHabitations(frm.getCircleCode(),frm.getMandal(),conn,frm.getYear()));			
							
						} else
						{		
							frm.getHabList().clear();
							
						}

					} catch (Exception e) {
						 System.out.println("habList display exception in Rws_Ntr_Sujala_Asset_Convert_Action --  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    	   System.out.println("habList display exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
						       }

					}
					page_to_be_displayed = "data";
				}

			if (mode != null && mode.equalsIgnoreCase("save")) 
			{
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					try {
						ValidationUtils validation = new ValidationUtils();
						
						if (!validation.ValidLatitude(frm.getLatitude())) {
							message = "Invalid Input (Latitude)";
							request.setAttribute("message", message);
							return mapping.findForward("save");
						}
						if (!validation.ValidLongitude(frm.getLongitude())) {
							message = "Invalid Input (Longitude)";
							request.setAttribute("message", message);
							return mapping.findForward("save");
						}
						String targetPath = getServlet().getServletContext().getRealPath("") + "temp.jpg";
						
						String message = dao.saveAssetSource(frm,conn,targetPath,getServlet());
						
						request.setAttribute("message",message);
						
						page_to_be_displayed = "save";
						
					} catch (Exception e)
					{
						System.out.println("exception in save of Rws_Ntr_Sujala_Asset_Convert_Action-- "+e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
										
									}
						       } 
						       catch (Exception e) 
						       {
						    	   System.out.println("exception in save of Rws_Ntr_Sujala_Asset_Convert_Action finally-- "+e);
						       }

					}
					page_to_be_displayed = "save";
				}
			}
			
			if (mode != null && mode.equalsIgnoreCase("ROConvertToAsset")) 
			{
				String habCode=request.getParameter("habCode");
					String implDate=request.getParameter("implDate");
					String typeOfplant=request.getParameter("typeOfplant");
					try {
						reset1(frm);
						String progCode="81";
						String subProgCode="01";
						String typeOfAsset="08";
						String assetCode=progCode+subProgCode+frm.getCircleCode()+typeOfAsset+frm.getYear().substring(2,4);
						String shortSchemeCode=dao.getShortSchemeCode(habCode, conn);
						RwsOffices offices=new RwsOffices();
						
						frm.setSplantType(typeOfplant);
						frm.setImplDate(implDate);
						frm.setStartYear(frm.getYear());
						frm.setDateCreation("01-04-"+frm.getYear());
						frm.setAssetName("DONOR-TP");
						frm.setAssetCost("0");
						frm.setSourceCount(1);
						frm.setLocation(offices.getDistrictName(frm.getCircleCode()));
						
						assetCode=dao.getAssetCode(assetCode, conn);
						
						if(assetCode.length()==10){
						assetCode=dao.getAssetCodeGen(assetCode,conn);
						}
						else{
							Rws_Ntr_Sujala_Asset_Convert_Form asset_Convert_Form=new Rws_Ntr_Sujala_Asset_Convert_Form();
							asset_Convert_Form=dao.getAssetDetails(assetCode,conn);
							frm.setAssetName(asset_Convert_Form.getAssetName());
							frm.setAssetType(asset_Convert_Form.getAssetType());
							frm.setHabCode(habCode);
							frm.setLocation(asset_Convert_Form.getLocation());
							frm.setDateCreation(asset_Convert_Form.getDateCreation());
							frm.setAssetStatus(asset_Convert_Form.getAssetStatus());
							frm.setAssetCost(asset_Convert_Form.getAssetCost());
							frm.setStartYear(asset_Convert_Form.getStartYear());
							frm.setSourceCount(asset_Convert_Form.getSourceCount());
							shortSchemeCode=asset_Convert_Form.getSchemeCode();
						}
						frm.setAssetCode(assetCode);
						String sourceCode=dao.getSourceCodeGen(habCode,shortSchemeCode,typeOfplant, conn);
						frm.setSourceCode(sourceCode);
						frm.setCompImageStatus("No");
						
					} catch (Exception e)
					{
						System.out.println("ROConvertToAsset exception in Rws_Ntr_Sujala_Asset_Convert_Action --  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    	   System.out.println("ROConvertToAsset exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
						       }

					}
					page_to_be_displayed = "ROConvertToAsset";
				}
			if (mode != null && mode.equalsIgnoreCase("ROConvertToAssetEdit")) 
			{
				String habCode=request.getParameter("habCode");
					try {
						reset1(frm);
						String progCode="81";
						String subProgCode="01";
						String typeOfAsset="08";
						String assetCode=progCode+subProgCode+frm.getCircleCode()+typeOfAsset+frm.getYear().substring(2,4);
						assetCode=dao.getAssetCode(assetCode, conn);
						
						
							Rws_Ntr_Sujala_Asset_Convert_Form asset_Convert_Form=new Rws_Ntr_Sujala_Asset_Convert_Form();
							asset_Convert_Form=dao.getAssetDetails(assetCode,conn);
							frm.setAssetName(asset_Convert_Form.getAssetName());
							frm.setAssetType(asset_Convert_Form.getAssetType());
							frm.setHabCode(habCode);
							frm.setLocation(asset_Convert_Form.getLocation());
							frm.setDateCreation(asset_Convert_Form.getDateCreation());
							frm.setAssetStatus(asset_Convert_Form.getAssetStatus());
							frm.setAssetCost(asset_Convert_Form.getAssetCost());
							frm.setStartYear(asset_Convert_Form.getStartYear());
							frm.setSourceCount(asset_Convert_Form.getSourceCount());
							frm.setAssetCode(assetCode);
						
							asset_Convert_Form=dao.getSourceDetails(assetCode, habCode, conn);
							
							frm.setSourceCode(asset_Convert_Form.getSourceCode());
							frm.setSourceLocation(asset_Convert_Form.getSourceLocation());
							frm.setCapacity(asset_Convert_Form.getCapacity());
							frm.setNoofUnits(asset_Convert_Form.getNoofUnits());
							frm.setNoOfHoursUsage(asset_Convert_Form.getNoOfHoursUsage());
							frm.setNoofStandByUnits(asset_Convert_Form.getNoofStandByUnits());
							frm.setRawWaterStorageTankExisting(asset_Convert_Form.getRawWaterStorageTankExisting());
							frm.setProductWaterStorageTankExisting(asset_Convert_Form.getProductWaterStorageTankExisting());
							frm.setShelterExisting(asset_Convert_Form.getShelterExisting());
							frm.setCompStatus(asset_Convert_Form.getCompStatus());
							frm.setCompCost(asset_Convert_Form.getCompCost());
							frm.setLatitude(asset_Convert_Form.getLatitude());
							frm.setLongitude(asset_Convert_Form.getLongitude());
							frm.setElivation(asset_Convert_Form.getElivation());
							frm.setWayPoint(asset_Convert_Form.getWayPoint());
							frm.setCompImageStatus(dao.getImageStatus(asset_Convert_Form.getSourceCode(), conn));
							frm.setAveCanSupplied(asset_Convert_Form.getAveCanSupplied());
						
					} catch (Exception e)
					{
						System.out.println("ROConvertToAssetEdit exception in Rws_Ntr_Sujala_Asset_Convert_Action --  " + e);
					}
					finally 
					{
						   try {
									if (conn!= null) 
									{
										conn.close();
									}
						       } 
						       catch (Exception e) 
						       {
						    	   System.out.println("ROConvertToAssetEdit exception in Rws_Ntr_Sujala_Asset_Convert_Action finally --  " + e);
						       }

					}
					page_to_be_displayed = "ROConvertToAssetEdit";
				}
			
			if (mode != null && mode.equalsIgnoreCase("delete")) 
			{
				if (request.getParameter("special") != null
						&& request.getParameter("special").equals("reset")) 
				{
					reset(frm);
				}
				try {
					
						
						//frm.setHabList(dao.getConvertedHabitations(conn));			
					

				} catch (Exception e) {
					 System.out.println("habList display exception in Rws_Ntr_Sujala_Asset_Convert_Action --  " + e);
				}
				finally 
				{
					   try {
								if (conn!= null) 
								{
									conn.close();
								}
					       } 
					       catch (Exception e) 
					       {
					    	   System.out.println("habList display exception in Rws_Ntr_Sujala_Asset_Convert_Action finally--  " + e);
					       }

				}
				page_to_be_displayed = "data";
			}
			
				return mapping.findForward(page_to_be_displayed);
				
         
			}

			

			public void reset(Rws_Ntr_Sujala_Asset_Convert_Form frm)
			{
				frm.setCircleCode("");
				frm.setMandal("");
				frm.setPanchCode("");
				frm.setCurrentDate("");
				frm.setYear("");
				frm.setHabList(new ArrayList());
				

			}
			public void reset1(Rws_Ntr_Sujala_Asset_Convert_Form frm)
			{
				frm.setAssetCode("");
				frm.setAssetName("");
				frm.setAssetStatus("");
				frm.setAssetCost("");
				frm.setLocation("");
				frm.setStartYear("");
				frm.setDateCreation("");
				frm.setAssetType("");
				frm.setSourceCode("");
				frm.setSourceLocation("");
				frm.setCapacity("");
				frm.setNoofUnits("");
				frm.setNoOfHoursUsage("");
				frm.setNoofStandByUnits("");
				frm.setRawWaterStorageTankExisting("");
				frm.setProductWaterStorageTankExisting("");
				frm.setShelterExisting("");
				frm.setLatitude("");
				frm.setLongitude("");
				frm.setElivation("");
				frm.setWayPoint("");
				frm.setCompCost("");
				frm.setCompStatus("");
				frm.setAveCanSupplied("");
				

			}
		}
