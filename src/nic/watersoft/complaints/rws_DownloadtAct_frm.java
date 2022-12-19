// Decompiled by DJ v3.11.11.95 Copyright 2009 Atanas Neshkov  Date: 15/02/2011 11:29:24
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   rws_DownloadtAct_frm.java

package nic.watersoft.complaints;

import java.util.ArrayList;
import javax.servlet.http.*;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import org.apache.struts.action.*;

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class rws_DownloadtAct_frm extends Action
{

    public rws_DownloadtAct_frm()
    {
    }

    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
        throws Exception
    {
        String page_to_be_displayed = "";
        ComplaintMasterData complaintMasterData = new ComplaintMasterData();
        String message = null;
        int count = 0;
        String message4 = null;
        CompForm compForm = new CompForm();
        String tablename = null;
        String resulthab = "";
        CompForm frm = (CompForm)form;
        String mode = request.getParameter("mode");
        Debug.println("Mode" + mode);
        HttpSession session = request.getSession();
        ArrayList districts = new ArrayList();
        String result = null;
        String message1 = null;
        String dcode = "";
        boolean exists = false;
        boolean exist = false;
        String message2 = null;
        frm.reset5(mapping, request);
        if(mode != null && mode.equalsIgnoreCase("init"))
        {
            complaintMasterData.getMsaccessDatabase();
            page_to_be_displayed = "init";
        }
        if(mode != null && mode.equalsIgnoreCase("module"))
            try
            {
                RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
                districts = rwsLocations.getDistricts();
                session.setAttribute("districts", districts);
                dcode = frm.getDistrictCode();
                Debug.println("dcode" + dcode);
                result = request.getParameter("result");
                Debug.println("result" + result);
                if(result.equals("work"))
                    page_to_be_displayed = "workmode";
                else
                if(result.equals("hab"))
                    page_to_be_displayed = "habmode";
                else
                if(result.equals("asset"))
                    page_to_be_displayed = "assetmode";
                else
                if(result.equals("school"))
                    page_to_be_displayed = "schoolmode";
                else
                if(result.equals("water"))
                    page_to_be_displayed = "waterqualitymode";
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        if(mode != null && mode.equalsIgnoreCase("schoolmode"))
            try
            {
                resulthab = request.getParameter("habresult");
                Debug.println("resulthab" + resulthab);
                if(resulthab != null && resulthab.equals("schoolform"))
                {
                    tablename = "RWS_SCHOOL_MASTER_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("schoolcategory"))
                {
                    tablename = "RWS_SCHOOL_CATEGORY_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        if(mode != null && mode.equalsIgnoreCase("assetmode"))
        {
            try
            {
                resulthab = request.getParameter("habresult");
                Debug.println("resulthab" + resulthab);
                if(resulthab != null && resulthab.equals("bpt"))
                {
                    tablename = "RWS_AST_BPT_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("assethab"))
                {
                    tablename = "rws_asset_hab_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("assetmast"))
                {
                    tablename = "rws_asset_mast_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("assetscheme"))
                {
                    tablename = "rws_asset_scheme_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("rw"))
                {
                    tablename = "RWS_AST_RW_COLLWELL_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("cw"))
                {
                    tablename = "rws_ast_cw_collwell_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("source"))
                {
                    tablename = "rws_source_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("sstank"))
                {
                    tablename = "rws_ast_ss_sc_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("filter"))
                {
                    tablename = "rws_ast_wtp_sc_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("sump"))
                {
                    tablename = "rws_ast_ss_sc_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("fp"))
                {
                    tablename = "rws_ast_fp_bridge_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("pumphouse"))
                {
                    tablename = "rws_ast_pumphouse_param_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("watch"))
                {
                    tablename = "RWS_AST_WATCHMAN_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("cw"))
                {
                    tablename = "RWS_AST_CW_COLLWELL_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("ohsr"))
                {
                    tablename = "RWS_AST_OHSR_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("ohbr"))
                {
                    tablename = "RWS_AST_OHBR_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("ohbr"))
                {
                    tablename = "RWS_AST_OHBR_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("glbr"))
                {
                    tablename = "RWS_AST_GLBR_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("glsr"))
                {
                    tablename = "RWS_AST_GLSR_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("cis"))
                {
                    tablename = "RWS_AST_CIS_SC_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("other"))
                {
                    tablename = "RWS_AST_OTHERS_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("other"))
                {
                    tablename = "RWS_AST_OTHERS_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("cl"))
                {
                    tablename = "RWS_AST_CHLORINATION_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("oandm"))
                {
                    tablename = "RWS_AST_OANDM_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("pumpset"))
                {
                    tablename = "RWS_AST_SUBCOMP_PARAM_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            page_to_be_displayed = "assetmode";
        }
        if(mode != null && mode.equalsIgnoreCase("waterqualitymode"))
        {
            try
            {
                resulthab = request.getParameter("habresult");
                Debug.println("resulthab" + resulthab);
                if(resulthab != null && resulthab.equals("watersample"))
                {
                    tablename = "rws_water_sample_collect_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("waterlab"))
                {
                    tablename = "rws_water_quality_lab_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("watertest"))
                {
                    tablename = "rws_water_quality_test_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("ftk"))
                {
                    tablename = "rws_ftk_testing_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            page_to_be_displayed = "waterqualitymode";
        }
        if(mode != null && mode.equalsIgnoreCase("workmode"))
        {
            try
            {
                RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
                districts = rwsLocations.getDistricts();
                session.setAttribute("districts", districts);
                dcode = request.getParameter("dist");
                resulthab = request.getParameter("habresult");
                Debug.println("resulthab" + resulthab);
                if(resulthab != null && resulthab.equals("admn"))
                {
                    tablename = "rws_work_admn_tbl";
                    exists = ComplaintMasterData.tabExists(tablename);
                    if(exists)
                    {
                        count = ComplaintMasterData.tabExistsdata(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("count**" + count);
                        if(count > 0)
                        {
                            message2 = ComplaintMasterData.tabExistsdel(tablename, dcode, getDataSource(request), resulthab);
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        } else
                        {
                            Debug.println("startfrom here");
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        }
                    } else
                    {
                        Debug.println("start from here*");
                        message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                        Debug.println("start from here**");
                        message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("start from here***");
                    }
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("workcomp"))
                {
                    tablename = "rws_work_completion_tbl";
                    exists = ComplaintMasterData.tabExists(tablename);
                    if(exists)
                    {
                        count = ComplaintMasterData.tabExistsdata(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("count**" + count);
                        if(count > 0)
                        {
                            message2 = ComplaintMasterData.tabExistsdel(tablename, dcode, getDataSource(request), resulthab);
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        } else
                        {
                            Debug.println("startfrom here");
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        }
                    } else
                    {
                        Debug.println("start from here*");
                        message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                        Debug.println("start from here**");
                        message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("start from here***");
                    }
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("workcategory"))
                {
                    tablename = "rws_work_category_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("workexpenditure"))
                {
                    tablename = "rws_work_expenditure_tbl";
                    exists = ComplaintMasterData.tabExists(tablename);
                    if(exists)
                    {
                        count = ComplaintMasterData.tabExistsdata(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("count**" + count);
                        if(count > 0)
                        {
                            message2 = ComplaintMasterData.tabExistsdel(tablename, dcode, getDataSource(request), resulthab);
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        } else
                        {
                            Debug.println("startfrom here");
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        }
                    } else
                    {
                        Debug.println("start from here*");
                        message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                        Debug.println("start from here**");
                        message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("start from here***");
                    }
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("workcommencement"))
                {
                    tablename = "rws_work_commencement_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("workexpenditureprevious"))
                {
                    tablename = "rws_work_exp_upto_pre_year_tbl";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("condet"))
                {
                    tablename = "RWS_CONTRACTOR_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("admnhablnk"))
                {
                    tablename = "RWS_ADMN_HAB_LNK_TBL";
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            page_to_be_displayed = "workmode";
        }
        if(mode != null && mode.equalsIgnoreCase("habmode"))
        {
            try
            {
                RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
                districts = rwsLocations.getDistricts();
                session.setAttribute("districts", districts);
                Debug.println("districts" + districts);
                dcode = request.getParameter("dist");
                Debug.println("distcode1*" + dcode);
                resulthab = request.getParameter("habresult");
                Debug.println("resultanttables" + resulthab);
                if(resulthab != null && resulthab.equals("dist"))
                {
                    tablename = "rws_district_tbl";
                    Debug.println("tablename" + tablename);
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    Debug.println("message" + message);
                    request.setAttribute("message", message);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("man"))
                {
                    tablename = "rws_mandal_tbl";
                    Debug.println("tablename" + tablename);
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("pan"))
                {
                    tablename = "rws_panchayat_tbl";
                    Debug.println("tablename" + tablename);
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    Debug.println("message" + message);
                    request.setAttribute("message", message);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("panraj"))
                {
                    tablename = "rws_panchayat_raj_tbl";
                    Debug.println("tablename" + tablename);
                    exists = ComplaintMasterData.tabExists(tablename);
                    if(exists)
                    {
                        count = ComplaintMasterData.tabExistsdata(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("count**" + count);
                        if(count > 0)
                        {
                            message2 = ComplaintMasterData.tabExistsdel(tablename, dcode, getDataSource(request), resulthab);
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        } else
                        {
                            Debug.println("startfrom here");
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        }
                    } else
                    {
                        message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                        message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    }
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("vil"))
                {
                    tablename = "rws_village_tbl";
                    Debug.println("tablename" + tablename);
                    message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                    message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    Debug.println("message" + message);
                    request.setAttribute("message", message1);
                }
                if(resulthab != null && resulthab.equals("habitation"))
                {
                    tablename = "rws_habitation_directory_tbl";
                    Debug.println("tablename" + tablename);
                    exists = ComplaintMasterData.tabExists(tablename);
                    if(exists)
                    {
                        count = ComplaintMasterData.tabExistsdata(tablename, dcode, getDataSource(request), resulthab);
                        Debug.println("count**" + count);
                        if(count > 0)
                        {
                            message2 = ComplaintMasterData.tabExistsdel(tablename, dcode, getDataSource(request), resulthab);
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        } else
                        {
                            Debug.println("startfrom here");
                            message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                        }
                    } else
                    {
                        message = ComplaintMasterData.getCreateTable(tablename, getDataSource(request));
                        message1 = ComplaintMasterData.getInserttablesw1(tablename, dcode, getDataSource(request), resulthab);
                    }
                    request.setAttribute("message", message1);
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
            Debug.println("bbbbbbbbbbb");
            page_to_be_displayed = "habmode";
        }
        return mapping.findForward(page_to_be_displayed);
    }
}
