package nic.watersoft.wquality;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.masters.SubCompMetaData;

public class RwsWQualityData {

    static Connection conn = null;

    static Statement stmt = null;

    static Statement stmt2 = null;

    static ResultSet rs = null;

    static ResultSet rs2 = null;

    static PreparedStatement ps = null;

    static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    public static String errorMessage;

    public static void closeAll() throws Exception {

        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll"+e);
            }
            rs = null;
        }
        if (rs2 != null) {
            try {
                rs2.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll"+e);
            }
            rs2 = null;
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll="+e);
            }
            stmt = null;
        }
        if (stmt2 != null) {
            try {
                stmt2.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll="+e);
            }
            stmt2 = null;
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll="+e);
            }
            conn = null;
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                //System.out.println("The error in closeAll="+e);
            }
            ps = null;
        }
    }

    public static ArrayList getSelectedSources(String source, String habCode)
            throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList selsource = new ArrayList();
        Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
        ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
        String qry = "";
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            if (source != null && source.equals("SS")) {
                qry = "select SOURCE_CODE,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING'),nvl(subCompTbl.source_name,'-'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM	RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09' ) and	SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=1 and	subCompTbl.hab_code='"
                        + habCode + "'";
              //  Debug.println("SElected Sources:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));

                    rwsMaster.setWaterSourcename(rs.getString(5));
                    rwsMaster.setLatitude(rs.getString(6));
                    rwsMaster.setLongitude(rs.getString(7));
                    rwsMaster.setElevation(rs.getString(8));
                    rwsMaster.setWaypoint(rs.getString(9));

                    //	decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DP'),nvl(asset_name,'-')
                    // nvl(subCompTbl.source_name,'-')
                    ////Debug.println("after sourcetype
                    // code1:"+rs.getString(1).substring(16,17));
                    // //Debug.println("after sourcetype
                    // code2:"+rs.getString(1).substring(16,18));
                    String sname = "", scode = "";
                    String sname1 = "", scode1 = "";
                    String sname2 = "", scode2 = "";
                    String sname3 = "", scode3 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode = "0101001";
                        sname = "PWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode = "0301001";
                        sname = "CPWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode = "0201001";
                        sname = "MPWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("45")) {
                        scode = "0901001";
                        sname = "DIRECT PUMPING  SUBSURFACE SOURCE";

                    }

                    ////Debug.println("after sourcetype code");
                    rwsMaster.setSourceTypeCode(scode);
                    rwsMaster.setSourceTypeName(sname);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("SU")) {
                qry = "select SOURCE_CODE ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOTWORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS','09','DIRECT PUMPING'),nvl(subCompTbl.source_name,'-') ,subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or M.TYPE_OF_ASSET_CODE='09') and	SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=2 and	subCompTbl.hab_code='"
                        + habCode + "'";
                ////Debug.println("qrySu:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));

                    rwsMaster.setWaterSourcename(rs.getString(5));

                    rwsMaster.setLatitude(rs.getString(6));
                    rwsMaster.setLongitude(rs.getString(7));
                    rwsMaster.setElevation(rs.getString(8));
                    rwsMaster.setWaypoint(rs.getString(9));
                    String sname = "", scode = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode = "0101002";
                        sname = "PWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode = "0301002";
                        sname = "CPWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode = "0201002";
                        sname = "MPWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("45")) {
                        scode = "0901002";
                        sname = "DIRECT PUMPING SURFACE SOURCE";
                    }

                    rwsMaster.setSourceTypeCode(scode);
                    rwsMaster.setSourceTypeName(sname);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("HP")) {
                try {
                    //qry="select distinct subCompTbl.HP_CODE
                    // ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT
                    // WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM
                    // RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL
                    // S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE
                    // M.ASSET_CODE=subCompTbl.ASSET_CODE AND
                    // M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'
                    // and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and (SUBSTR
                    // (S.SCHEME_CODE,17,3) LIKE '0%'
                    // orSUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or
                    // SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and
                    // substr(subCompTbl.hp_code,1,16)='"+habCode+"' order by
                    // substr(subCompTbl.hp_code,21,24)";
                    qry = "select distinct subCompTbl.HP_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'04','HANDPUMP'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT   FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND	M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.hab_code=substr(subCompTbl.hp_code,1,16) and m.hab_code='"
                            + habCode
                            + "' order by	substr(subCompTbl.hp_code,21,24)";
                  //  Debug.println("qryhp:" + qry);
                    rs = stmt.executeQuery(qry);
                    while (rs.next()) {
                        rwsMaster = new RwsMaster();
                        rwsMaster.setSourceCode(rs.getString(1));
                        rwsMaster.setLocation(rs.getString(2));
                        rwsMaster.setAssetStatus(rs.getString(3));
                        rwsMaster.setWaterAssettype(rs.getString(4));
                        rwsMaster.setLatitude(rs.getString(5));
                        rwsMaster.setLongitude(rs.getString(6));
                        rwsMaster.setElevation(rs.getString(7));
                        rwsMaster.setWaypoint(rs.getString(8));

                        //rwsMaster.setWaterAssetname(rs.getString(5));
                        rwsMaster.setSourceTypeCode("0401001");
                        rwsMaster.setSourceTypeName("HANDPUMPS BOREWELL");
                        selsource.add(rwsMaster);
                    }
                } catch (Exception e) {
                    Debug.println(" Exception in Handpump displaying:" + e);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("OW")) {
                qry = "select subCompTbl.OPENWELL_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT 	WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'06','OPENWELLS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HABITATION_code='"
                        + habCode + "' ";
                ////Debug.println("qryow:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));
                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));
                    rwsMaster.setSourceTypeCode("0601001");
                    rwsMaster.setSourceTypeName("OPEN WELLS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("SHP")) {
                qry = "select distinct subCompTbl.SHALLOWHP_CODE,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT	WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'05','SHALLOWHANDPUMPS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND	M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and	subCompTbl.HAB_CODE='"
                        + habCode + "'";
                //Debug.println("qryShp******************:" + qry);
                rs = stmt.executeQuery(qry);

                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));

                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));

                    rwsMaster.setSourceTypeCode("0501001");
                    rwsMaster.setSourceTypeName("SHALLOW HANDPUMPS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("PO")) {
                qry = "select distinct subCompTbl.POND_CODE,subCompTbl.POND_LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'07','PONDS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE	M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07'	and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HAB_CODE ='"
                        + habCode + "' ";
               // Debug.println("qrypond********:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));
                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));
                    rwsMaster.setSourceTypeCode("0701001");
                    rwsMaster.setSourceTypeName("PONDS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added by sreelaxmi on 1-02-2012
            /*
			 * else if(source!=null && source.equals("DP")) { qry="select
			 * SOURCE_CODE
			 * 
			 * ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOT
			 * 
			 * WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM
			 * RWS_ASSET_MAST_TBL M,
			 * 
			 * RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE
			 * M.ASSET_CODE=subCompTbl.ASSET_CODE AND
			 * 
			 * M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' and
			 * SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE
			 * 
			 * and (source_type_code=1 or source_type_code=2) and
			 * subCompTbl.hab_code='"+habCode+"'";
			 * Debug.println("qrydirectpumping**************:"+qry); rs =
			 * stmt.executeQuery(qry); while (rs.next()) { rwsMaster = new
			 * RwsMaster(); rwsMaster.setSourceCode(rs.getString(1));
			 * rwsMaster.setLocation(rs.getString(2));
			 * rwsMaster.setAssetStatus(rs.getString(3));
			 * rwsMaster.setSourceTypeCode("0901001");
			 * rwsMaster.setSourceTypeName("DIRECT PUMPING SOURCES");
			 * selsource.add(rwsMaster); } if(rs!=null)rs.close();
			 * if(stmt!=null)stmt.close(); }
             */ //Added for GLSR"
            else if (source != null && source.equals("GLSR")) {
                qry = "select subCompTbl.glsr_code,subCompTbl.glsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND	M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglsr******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104003";
                        sname1 = "PWS GLSR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304003";
                        sname1 = "CPWS GLSR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204003";
                        sname1 = "MPWS GLSR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("glsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));
                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added for glsr" 03/02/2012
            //Added for glbr"
            else if (source != null && source.equals("GLBR")) {
                qry = "select subCompTbl.glbr_code,subCompTbl.glbr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS') ,subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glbr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND	M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or	M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglbr*******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104004";
                        sname1 = "PWS GLBR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304004";
                        sname1 = "CPWS GLBR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204004";
                        sname1 = "MPWS GLBR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("glsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));

                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added for glbr"
            //Added for ohbr and ohsr
            else if (source != null && source.equals("OHSR")) {
                qry = "select subCompTbl.ohsr_code,subCompTbl.ohsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),decode(m.type_of_asset_code,'01','PWS','02','MPWS','03','CPWS'),subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_ohsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and	subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglbr*******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104001";
                        sname1 = "PWS OHSR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304001";
                        sname1 = "CPWS OHSR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204001";
                        sname1 = "MPWS OHSR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("ohsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setWaterAssettype(rs.getString(4));

                    rwsMaster.setLatitude(rs.getString(5));
                    rwsMaster.setLongitude(rs.getString(6));
                    rwsMaster.setElevation(rs.getString(7));
                    rwsMaster.setWaypoint(rs.getString(8));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            }
          //bhagya & teja
            else if (source != null && source.equals("OT")) {
               qry = "  select distinct subCompTbl.OTHER_COMP_CODE,nvl(subCompTbl.COMP_LOCATION,'--') as COMP_LOCATION, decode (m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'), decode (m.type_of_asset_code,'08','OTHERS'),  subCompTbl.LATITUDE,subCompTbl.LONGITUDE,subCompTbl.ELEVATION ,subCompTbl.WAY_POINT  FROM RWS_ASSET_MAST_TBL M,  RWS_ASSET_SCHEME_TBL S, rws_ast_others_param_tbl subCompTbl  WHERE  M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND  SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='" + habCode + "'";
               //Debug.println("qry ot  ******************:" + qry);
               rs = stmt.executeQuery(qry);
               while (rs.next()) {

                   rwsMaster = new RwsMaster();
                   String glsr = rs.getString(1);
                   rwsMaster.setSourceCode(rs.getString(1));
                   rwsMaster.setLocation(rs.getString(2));
                   rwsMaster.setAssetStatus(rs.getString(3));
                   rwsMaster.setWaterAssettype(rs.getString(4));
                   rwsMaster.setLatitude(rs.getString(5));
                   rwsMaster.setLongitude(rs.getString(6));
                   rwsMaster.setElevation(rs.getString(7));
                   rwsMaster.setWaypoint(rs.getString(8));
                   rwsMaster.setSourceTypeCode("0801001");
                   rwsMaster.setSourceTypeName("OTHERS");
                   selsource.add(rwsMaster);
          
               }
               if (rs != null) {
                   rs.close();
               }
               if (stmt != null) {
                   stmt.close();
               }
           } 

        } catch (Exception e) {
            Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {

        }

        return selsource;
    }

    public static ArrayList getSelectedSources11(String source, String habCode)
            throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList selsource = new ArrayList();
        Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
        ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
        String qry = "";
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            if (source != null && source.equals("SS")) {
                qry = "select SOURCE_CODE ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=1 and subCompTbl.hab_code='"
                        + habCode + "'";
                ////Debug.println("qrySS:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    ////Debug.println("after sourcetype
                    // code1:"+rs.getString(1).substring(16,17));
                    // //Debug.println("after sourcetype
                    // code2:"+rs.getString(1).substring(16,18));
                    String sname = "", scode = "";
                    String sname1 = "", scode1 = "";
                    String sname2 = "", scode2 = "";
                    String sname3 = "", scode3 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode = "0101001";
                        sname = "PWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode = "0301001";
                        sname = "CPWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode = "0201001";
                        sname = "MPWS SUBSURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("45")) {
                        scode = "0901001";
                        sname = "DIRECT PUMPING  SUBSURFACE SOURCE";

                    }

                    ////Debug.println("after sourcetype code");
                    rwsMaster.setSourceTypeCode(scode);
                    rwsMaster.setSourceTypeName(sname);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("SU")) {
                qry = "select SOURCE_CODE ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and source_type_code=2 and subCompTbl.hab_code='"
                        + habCode + "'";
                ////Debug.println("qrySu:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    String sname = "", scode = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode = "0101002";
                        sname = "PWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode = "0301002";
                        sname = "CPWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode = "0201002";
                        sname = "MPWS SURFACE SOURCE";
                    } else if (rs.getString(1).substring(16, 18).equals("45")) {
                        scode = "0901002";
                        sname = "DIRECT PUMPING SURFACE SOURCE";
                    }

                    rwsMaster.setSourceTypeCode(scode);
                    rwsMaster.setSourceTypeName(sname);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("HP")) {
                try {
                    //qry="select distinct subCompTbl.HP_CODE
                    // ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT
                    // WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM
                    // RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL
                    // S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE
                    // M.ASSET_CODE=subCompTbl.ASSET_CODE AND
                    // M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'
                    // and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and (SUBSTR
                    // (S.SCHEME_CODE,17,3) LIKE '0%' or
                    // SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or
                    // SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%') and
                    // substr(subCompTbl.hp_code,1,16)='"+habCode+"' order by
                    // substr(subCompTbl.hp_code,21,24)";
                    qry = "select distinct subCompTbl.HP_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.hab_code=substr(subCompTbl.hp_code,1,16) and m.hab_code='"
                            + habCode
                            + "' order by  substr(subCompTbl.hp_code,21,24)";
                    //Debug.println("qryhp:" + qry);
                    rs = stmt.executeQuery(qry);
                    while (rs.next()) {
                        rwsMaster = new RwsMaster();
                        rwsMaster.setSourceCode(rs.getString(1));
                        rwsMaster.setLocation(rs.getString(2));
                        rwsMaster.setAssetStatus(rs.getString(3));
                        rwsMaster.setSourceTypeCode("0401001");
                        rwsMaster.setSourceTypeName("HANDPUMPS BOREWELL");
                        selsource.add(rwsMaster);
                    }
                } catch (Exception e) {
                    Debug.println(" Exception in Handpump displaying:" + e);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("OW")) {
                qry = "select subCompTbl.OPENWELL_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HABITATION_code='"
                        + habCode + "' ";
                ////Debug.println("qryow:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode("0601001");
                    rwsMaster.setSourceTypeName("OPEN WELLS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("SHP")) {
                qry = "select distinct subCompTbl.SHALLOWHP_CODE,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HAB_CODE='"
                        + habCode + "'";
                ////Debug.println("qryShp:"+qry);
                rs = stmt.executeQuery(qry);

                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode("0501001");
                    rwsMaster.setSourceTypeName("SHALLOW HANDPUMPS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } else if (source != null && source.equals("PO")) {
                qry = "select distinct subCompTbl.POND_CODE,subCompTbl.POND_LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.HAB_CODE ='"
                        + habCode + "' ";
                ////Debug.println("qrypond:"+qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsMaster = new RwsMaster();
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode("0701001");
                    rwsMaster.setSourceTypeName("PONDS");
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added by sreelaxmi on 1-02-2012
            /*
			 * else if(source!=null && source.equals("DP")) { qry="select
			 * SOURCE_CODE
			 * ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOT
			 * WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM
			 * RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl
			 * subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND
			 * M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' and
			 * SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and (source_type_code=1 or
			 * source_type_code=2) and subCompTbl.hab_code='"+habCode+"'";
			 * Debug.println("qrydirectpumping**************:"+qry); rs =
			 * stmt.executeQuery(qry); while (rs.next()) { rwsMaster = new
			 * RwsMaster(); rwsMaster.setSourceCode(rs.getString(1));
			 * rwsMaster.setLocation(rs.getString(2));
			 * rwsMaster.setAssetStatus(rs.getString(3));
			 * rwsMaster.setSourceTypeCode("0901001");
			 * rwsMaster.setSourceTypeName("DIRECT PUMPING SOURCES");
			 * selsource.add(rwsMaster); } if(rs!=null)rs.close();
			 * if(stmt!=null)stmt.close(); }
             */ //Added for GLSR"
            else if (source != null && source.equals("GLSR")) {
                qry = "select subCompTbl.glsr_code,subCompTbl.glsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglsr******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104003";
                        sname1 = "PWS GLSR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304003";
                        sname1 = "CPWS GLSR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204003";
                        sname1 = "MPWS GLSR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("glsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added for glsr" 03/02/2012
            //Added for glbr"
            else if (source != null && source.equals("GLBR")) {
                qry = "select subCompTbl.glbr_code,subCompTbl.glbr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_glbr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglbr*******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104004";
                        sname1 = "PWS GLBR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304004";
                        sname1 = "CPWS GLBR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204004";
                        sname1 = "MPWS GLBR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("glsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            } //Added for glbr"
            //Added for ohbr and ohsr
            else if (source != null && source.equals("OHSR")) {
                qry = "select subCompTbl.ohsr_code,subCompTbl.ohsr_loc,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_ast_ohsr_sc_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' ) and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and subCompTbl.hab_code='"
                        + habCode + "'";
                //Debug.println("qryglbr*******************:" + qry);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {

                    String sname1 = "", scode1 = "";
                    if (rs.getString(1).substring(16, 17).equals("6")) {
                        scode1 = "0104001";
                        sname1 = "PWS OHSR";
                    } else if (rs.getString(1).substring(16, 17).equals("8")) {
                        scode1 = "0304001";
                        sname1 = "CPWS OHSR";
                    } else if (rs.getString(1).substring(16, 18).equals("40")
                            || rs.getString(1).substring(16, 18).equals("41")
                            || rs.getString(1).substring(16, 18).equals("42")
                            || rs.getString(1).substring(16, 18).equals("43")
                            || rs.getString(1).substring(16, 18).equals("44")) {
                        scode1 = "0204001";
                        sname1 = "MPWS OHSR";
                    }

                    rwsMaster = new RwsMaster();
                    String glsr = rs.getString(1);
                    //Debug.println("ohsr***********1" + glsr);
                    rwsMaster.setSourceCode(rs.getString(1));
                    rwsMaster.setLocation(rs.getString(2));
                    rwsMaster.setAssetStatus(rs.getString(3));
                    rwsMaster.setSourceTypeCode(scode1);
                    rwsMaster.setSourceTypeName(sname1);
                    selsource.add(rwsMaster);
                }
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {

        }

        return selsource;
    }

    public static DAOMessage insertWaterSample(RwsWQuality rwsWQuality,
            DataSource dataSource) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        //System.out.println("sd code1:"+rwsWQuality.getSdoc());
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String query = "insert into RWS_WATER_SAMPLE_COLLECT_TBL(TEST_ID,CIRCLE_OFFICE_CODE,"
                    + "DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,SOURCE_CODE,"
                    + "TEST_CODE,NATURE_OF_TEST,LAB_CODE,SAMP_COLLECTOR_CODE,SAMP_COLLECT_DATE,"
                    + "SAMP_COLLECT_TIME,ASSIGNED_ON,PREPARED_BY,PREPARED_ON,SOURCE_TYPE)"
                    + " values"
                    + "('"
                    + getTestId("sample", rwsWQuality.getLabCode(),
                            (rwsWQuality.getPreparedOn()).substring(6), conn)
                    + "',"
                    + "'"
                    + rwsWQuality.getCoc()
                    + "','"
                    + rwsWQuality.getDoc()
                    + "',"
                    + "'"
                    + rwsWQuality.getSdoc()
                    + "','"
                    + rwsWQuality.getHabCode()
                    + "',"
                    + "'"
                    + rwsWQuality.getSourceCode()
                    + "','"
                    + rwsWQuality.getTestCode()
                    + "',"
                    + "'"
                    + rwsWQuality.getNatureOfTest()
                    + "','"
                    + rwsWQuality.getLabCode()
                    + "',"
                    + "'"
                    + rwsWQuality.getSampCollectCode()
                    + "',"
                    + "TO_DATE('"
                    + rwsWQuality.getSampCollectDate()
                    + "','dd/MM/yyyy'),"
                    + "'"
                    + rwsWQuality.getSampCollectTime()
                    + "',"
                    + "TO_DATE('"
                    + rwsWQuality.getAssignedOn()
                    + "','dd/MM/yyyy'),"
                    + "'"
                    + rwsWQuality.getPreparedBy()
                    + "',"
                    + "TO_DATE('"
                    + rwsWQuality.getPreparedOn()
                    + "','dd/MM/yyyy'),"
                    + "'"
                    + rwsWQuality.getSourceType()
                    + "')";

            //Debug.println("query= "+query);
            stmt = conn.createStatement();

            rowCount = stmt.executeUpdate(query);
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        if (rowCount > 0) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);
        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            daoMessage.setOperationSussess(false);
        }

        return daoMessage;
    }

    public static DAOMessage insertWaterSamplelab(RwsWQuality rwsWQuality, DataSource dataSource) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        int cnt = 0;
        String ftkid = rwsWQuality.getFtktestid();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            if (rwsWQuality.getLabCode().length() == 1) {
                rwsWQuality.setLabCode("0" + rwsWQuality.getLabCode());
            }
            String testId = getTestId("sample", rwsWQuality.getLabCode(), (rwsWQuality.getPreparedOn()).substring(8), conn);
            String query = "INSERT INTO RWS_WATER_SAMPLE_COLLECT_TBL(TEST_ID,CIRCLE_OFFICE_CODE,"
                    + "DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,SOURCE_CODE,"
                    + "TEST_CODE,NATURE_OF_TEST,LAB_CODE,SAMP_COLLECTOR_CODE,SAMP_COLLECT_DATE,"
                    + "SAMP_COLLECT_TIME,ASSIGNED_ON,PREPARED_BY,PREPARED_ON,SOURCE_TYPE,FTK_TEST_ID,OLD_TEST_ID)"
                    + " VALUES( ? , ? , ? , ? , ? , ? , ? , ? , ? , ? , TO_DATE(? ,'dd/MM/yyyy'), ? ,TO_DATE(? ,'dd/MM/yyyy'), ? , TO_DATE( ? ,'dd/MM/yyyy'), ? , ? , ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, testId);
            ps.setString(2, rwsWQuality.getCoc());
            ps.setString(3, rwsWQuality.getDoc());
            ps.setString(4, rwsWQuality.getSdoc());
            ps.setString(5, rwsWQuality.getHabCode());
            ps.setString(6, rwsWQuality.getSourceCode());
            ps.setString(7, rwsWQuality.getTestCode());
            ps.setString(8, rwsWQuality.getNatureOfTest());
            ps.setString(9, rwsWQuality.getLabCode());
            ps.setString(10, rwsWQuality.getSampCollectCode());
            ps.setString(11, rwsWQuality.getSampCollectDate());
            ps.setString(12, rwsWQuality.getSampCollectTime());
            ps.setString(13, rwsWQuality.getAssignedOn());
            ps.setString(14, rwsWQuality.getPreparedBy());
            ps.setString(15, rwsWQuality.getPreparedOn());
            ps.setString(16, rwsWQuality.getSourceType());
            ps.setString(17, rwsWQuality.getFtktestid());
            ps.setString(18, testId);
            rowCount = ps.executeUpdate();
          } catch (Exception e) {
        	  System.out.println("The exception in RwsWQualityData insertWaterSamplelab = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount > 0) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);
        } else if (rowCount == 0) {
            daoMessage.setMessage("Record Cannot be Inserted");
            daoMessage.setOperationSussess(false);
        } else if (rowCount < 0) {
            daoMessage.setMessage("Record Cannot be Inserted,Lab testing is not possible before ftk test");
            daoMessage.setOperationSussess(false);
        }

        return daoMessage;
    }

    public static DAOMessage insertWaterSampleftk(RwsWQuality rwsWQuality,
            DataSource dataSource, String[] phy, String[] che, String[] bat,
            String[] oth, String[] forward, HttpSession session)
            throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        String ftkid = "";
        WaterSampleForm waterSample = new WaterSampleForm();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        //System.out.println("sd code1:"+rwsWQuality.getSdoc());
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String ftklab = rwsWQuality.getFtklab();
            //String
            // ftkid1=getftkTestId(rwsWQuality.getSourceCode(),dataSource);
            ftkid = rwsWQuality.getFtktestid();

            //Debug.println("ftkid :"+ftkid);
            ////Debug.println("ftkid 1 :"+ftkid1);
            String checkBox1 = "";
            String ftktestid = "";
            //Debug.println("ftklab"+ftklab);

            //Debug.println("DOC:"+rwsWQuality.getDoc());
            //Debug.println("SDOC:"+rwsWQuality.getSdoc());
            //String checkQuery = "select * from RWS_FTK_TESTING_TBL where
            // source_code='"+rwsWQuality.getSourceCode()+"' " +
            //		" and forward_date is not null and ftk_test_id in (Select
            // ftk_test_id from rws_water_sample_collect_tbl a " +
            //		"where a.source_code='"+rwsWQuality.getSourceCode()+"')";
            String checkQuery = "select * from RWS_FTK_TESTING_TBL where source_code='"
                    + rwsWQuality.getSourceCode()
                    + "' and ftk_test_id='"
                    + ftkid + "'";
            //Debug.println("checkQuery"+checkQuery);
            Statement chkStmt = conn.createStatement();
            ResultSet chRs = chkStmt.executeQuery(checkQuery);

            if (ftklab.equals("ftk")) {
                rowCount = 0;
                //Debug.println("in ftk");
                //query="insert into RWS_FTK_TESTING_TBL(SOURCE_CODE ,TEST_DATE
                // ,ARSENIC,NITRATE,FLORIDE,SALINITY,IRON,COLIFORM,TURBIDITY,CHLORIDES,"
                // +
                //"MANGANESE,SULPHATES,COPPER
                // ,CALCIUM,TDS,MAGNESIUM,HARDNESS,FORWARD_DATE,FTK_TEST_ID,SOURCE_TYPE)"
                // +
                //"values('"+rwsWQuality.getSourceCode()+"',TO_DATE('"+rwsWQuality.getFtkTestDate()+"','dd/MM/yyyy')";
                //Debug.println("forward Date"+rwsWQuality.getForwardDate());

                if (!chRs.next()) {

                    //Debug.println( " if ftk id is not repeated");
                    query = "insert into RWS_FTK_TESTING_TBL(SOURCE_CODE ,TEST_DATE ,ARSENIC,NITRATE,FLORIDE,SALINITY,IRON,COLIFORM,TURBIDITY,CHLORIDES,"
                            + "MANGANESE,SULPHATES,COPPER ,CALCIUM,TDS,MAGNESIUM,HARDNESS";

                    if (rwsWQuality.getForwardDate() != null
                            && !rwsWQuality.getForwardDate().equals("")) {
                        query += ",FORWARD_DATE";
                    }

                    String checkBox = "";

                    Collection c = new ArrayList();
                    Collection oc = new ArrayList();
                    if (che == null) {
                        //Debug.println("in che null");
                        for (int h = 0; h <= 4; h++) {
                            //Debug.println(""+h);
                            checkBox += ",'N'";
                        }
                    } else {
                        for (int h = 0; h < che.length; h++) {
                            c.add(che[h]);
                        }
                        if (c.contains("Arsenic")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Nitrate")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Fluoride")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Salinity")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Iron")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                    }
                    if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    //Debug.println("bat Completed:"+checkBox);

                    if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    //Debug.println("Physical Completed:"+checkBox);

                    if (oth == null) {
                        //Debug.println("in oth null");
                        for (int h = 0; h <= 7; h++) {
                            //Debug.println(""+h);
                            checkBox += ",'N'";
                        }
                    } else {
                        for (int h = 0; h < oth.length; h++) {
                            c.add(oth[h]);
                        }
                        if (c.contains("Chlorides")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Manganese")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Sulphates")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Copper")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Calcium")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("TDS")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Magnesium")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                        if (c.contains("Hardness")) {
                            checkBox += ",'Y'";
                        } else {
                            checkBox += ",'N'";
                        }
                    }
                    query += ",FTK_TEST_ID,SOURCE_TYPE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE) values('"
                            + rwsWQuality.getSourceCode()
                            + "',TO_DATE('"
                            + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                    ////Debug.println("other chemical
                    // Completed:"+checkBox+"Forward to lab");
                    if (forward != null && forward.length != 0
                            && !forward[0].equals("")) {
                        //checkBox1 += "Y";
                        String forward1 = "Yes";
                        session.setAttribute("forward1", forward);
                        session.setAttribute("forwarded", "YES");

                    } else {
                        //checkBox1 += "N";
                    }
                    //	//Debug.println("Forward to lab:"+checkBox1);

                    //Debug.println("all Completed:"+checkBox);
                    query += checkBox;

                    if (rwsWQuality.getForwardDate() != null
                            && !rwsWQuality.getForwardDate().equals("")) {
                        query += ",TO_DATE('" + rwsWQuality.getForwardDate()
                                + "','dd/MM/yyyy')";
                    }
                    query += ",'" + ftkid + "','" + rwsWQuality.getSourceType()
                            + "','" + rwsWQuality.getDoc() + "','"
                            + rwsWQuality.getSdoc() + "')";

                    //Debug.println("insert query1= " + query);
                    stmt = conn.createStatement();
                    //commented for testing

                    rowCount = rowCount + stmt.executeUpdate(query);
                    if (rowCount > 0) {

                        session.setAttribute("forwardedsrcCode", rwsWQuality
                                .getSourceCode());
                        session.setAttribute("forwardedsrcType", rwsWQuality
                                .getSourceType());
                        session.setAttribute("forwardedftkid", ftkid);

                    }

                } else {
                    //if(chRs.next()){

                    ////Debug.println( " if ftk id is repeated");
                    // //Debug.println("@@@@@@@@@@@@@@1111111111111111111111111111");
                    query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE('"
                            + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                    //Debug.println(" query------->:" +query);
                    String checkBox = "";
                    Collection c = new ArrayList();
                    Collection c1 = new ArrayList();
                    if (che == null) {
                        //Debug.println("in che null");
                        checkBox += ",Arsenic='N'";
                        checkBox += ",Nitrate='N'";
                        checkBox += ",Floride='N'";
                        checkBox += ",Salinity='N'";
                        checkBox += ",Iron='N'";
                    } else {
                        for (int h = 0; h < che.length; h++) {
                            c.add(che[h]);
                        }
                        if (c.contains("Arsenic")) {
                            checkBox += ",Arsenic='Y'";
                        } else {
                            checkBox += ",Arsenic='N'";
                        }
                        if (c.contains("Nitrate")) {
                            checkBox += ",Nitrate='Y'";
                        } else {
                            checkBox += ",Nitrate='N'";
                        }
                        if (c.contains("Fluoride")) {
                            checkBox += ",Floride ='Y'";
                        } else {
                            checkBox += ",Floride ='N'";
                        }
                        if (c.contains("Salinity")) {
                            checkBox += ",Salinity='Y'";
                        } else {
                            checkBox += ",Salinity='N'";
                        }
                        if (c.contains("Iron")) {
                            checkBox += ",Iron='Y'";
                        } else {
                            checkBox += ",Iron='N'";
                        }
                    }
                    ////Debug.println("Chemical Completed:"+checkBox);
                    if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                        checkBox += ",ColiForm='Y'";
                    } else {
                        checkBox += ",ColiForm='N'";
                    }
                    ////Debug.println("bat Completed:"+checkBox);
                    if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                        checkBox += ",Turbidity='Y'";
                    } else {
                        checkBox += ",Turbidity='N'";
                    }
                    ////Debug.println("Physical Completed:"+checkBox);
                    if (oth == null) {
                        //Debug.println("in oth null");
                        checkBox += ",Chlorides='N'";
                        checkBox += ",Manganese='N'";
                        checkBox += ",Sulphates='N'";
                        checkBox += ",Copper='N'";
                        checkBox += ",Calcium='N'";
                        checkBox += ",TDS='N'";
                        checkBox += ",Magnesium='N'";
                        checkBox += ",Hardness='N'";
                    } else {
                        for (int h = 0; h < oth.length; h++) {
                            c1.add(oth[h]);
                        }
                        if (c1.contains("Chlorides")) {
                            checkBox += ",Chlorides='Y'";
                        } else {
                            checkBox += ",Chlorides='N'";
                        }
                        if (c1.contains("Manganese")) {
                            checkBox += ",Manganese='Y'";
                        } else {
                            checkBox += ",Manganese='N'";
                        }
                        if (c1.contains("Sulphates")) {
                            checkBox += ",Sulphates='Y'";
                        } else {
                            checkBox += ",Sulphates='N'";
                        }
                        if (c1.contains("Copper")) {
                            checkBox += ",Copper='Y'";
                        } else {
                            checkBox += ",Copper='N'";
                        }
                        if (c1.contains("Calcium")) {
                            checkBox += ",Calcium='Y'";
                        } else {
                            checkBox += ",Calcium='N'";
                        }
                        if (c1.contains("TDS")) {
                            checkBox += ",TDS='Y'";
                        } else {
                            checkBox += ",TDS='N'";
                        }
                        if (c1.contains("Magnesium")) {
                            checkBox += ",Magnesium='Y'";
                        } else {
                            checkBox += ",Magnesium='N'";
                        }
                        if (c1.contains("Hardness")) {
                            checkBox += ",Hardness='Y'";
                        } else {
                            checkBox += ",Hardness='N'";
                        }
                    }

                    ////Debug.println("oth Chemical Completed:"+checkBox);
                    query += checkBox + ",FORWARD_DATE=TO_DATE('"
                            + rwsWQuality.getForwardDate()
                            + "','dd/MM/yyyy') where source_code='"
                            + rwsWQuality.getSourceCode()
                            + "' and ftk_test_id='" + ftkid + "'";
                    //Debug.println("updquery "+query);
                    stmt = conn.createStatement();
                    //commented for testing
                    rowCount = stmt.executeUpdate(query);
                    //Debug.println("rowCount"+rowCount);
                    if (rowCount > 0) {
                        //Debug.println(" row vcount is greater than 1");
                        if (forward != null && forward.length != 0
                                && !forward[0].equals("")) {
                            //Debug.println("In this loop of success");
                            String forward1 = "Yes";
                            session.setAttribute("forward1", forward);
                            session.setAttribute("forwarded", "YES");

                        }

                        session.setAttribute("forwardedsrcCode", rwsWQuality
                                .getSourceCode());
                        session.setAttribute("forwardedsrcType", rwsWQuality
                                .getSourceType());
                        session.setAttribute("forwardedftkid", ftkid);
                    }
                    //Debug.println("rowCount--->"+rowCount);

                }
                //Debug.println("rowCount"+rowCount);
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            session.setAttribute("forwarded", "NO");
            daoMessage.setOperationSussess(false);
        }

        return daoMessage;
    }

     public static RwsWQuality getWaterSampleftk1(String sourceCode, String ftktestid, String habCode) throws Exception {
        RwsWQuality bean = new RwsWQuality();
        try {
            conn = RwsOffices.getConn();
            PreparedStatement stmt1 = null;
            ResultSet rs1 = null;
            String qry = "select * from RWS_COMPLETE_HAB_VIEW  where panch_code='"+ habCode + "'";
            qry = "select to_char(TEST_DATE,'dd/mm/yyyy') as TEST_DATE,to_char(FORWARD_DATE,'dd/mm/yyyy') as FORWARD_DATE,SOURCE_CODE,SOURCE_TYPE,FTK_TEST_ID,b.* from RWS_FTK_TESTING_TBL a,rws_complete_hab_view b where "
            		+ " Source_code= ? and FTK_TEST_ID= ? and substr(a.source_code,1,16)=b.panch_code";
            ps = conn.prepareStatement(qry);
            ps.setString(1, sourceCode);
            ps.setString(2, ftktestid);
            rs = ps.executeQuery();
            if (rs.next()) {
                Date dt = new Date();
                String qry1 = "select a.dcode,c.circle_office_name,d.division_office_code,d.division_office_name,sd.subdivision_office_code,sd.subdivision_office_name from RWS_mandal_subdivision_tbl a,rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd "
                		+ " where dcode= ? and mcode= ? and a.dcode=c.circle_office_code and c.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and c.circle_office_code=sd.circle_office_code and a.subdivision_office_code=sd.subdivision_office_code and d.division_office_code=sd.division_office_code";
                stmt1 = conn.prepareStatement(qry1);
                stmt1.setString(1, rs.getString("dcode"));
                stmt1.setString(2, rs.getString("mcode"));
                rs1 = stmt1.executeQuery();
                rs1.next();
                bean.setFtkTestDate(rs.getString("TEST_DATE"));
                bean.setForwardDate(rs.getString("FORWARD_DATE"));
                bean.setSourceType(rs.getString("SOURCE_TYPE"));
                bean.setSourceCode(rs.getString("SOURCE_CODE"));
                bean.setFtktestid(rs.getString("FTK_TEST_ID"));
                String SourceCode = rs.getString("SOURCE_CODE");
                bean.setMandalCode(rs.getString("mcode"));
                bean.setMandalName(rs.getString("mname"));
                bean.setPanchCode(rs.getString("pcode"));
                bean.setPanchName(rs.getString("pname"));
                bean.setHabCode(rs.getString("panch_code"));
                bean.setHabName(rs.getString("panch_name"));
                bean.setCircleOfficeCode(rs1.getString("dcode"));
                bean.setCircleOfficeName(rs1.getString("circle_office_name"));
                bean.setDivisionOfficeCode(rs1.getString("division_office_code"));
                bean.setDivisionOfficeName(rs1.getString("division_office_name"));
                bean.setSubdivisionOfficeCode(rs1.getString("subdivision_office_code"));
                bean.setSubDivisionOfficeName(rs1.getString("subdivision_office_name"));

            }
        } catch (Exception e) {
            System.out.println("The Exception is in RwsWQualityData getWaterSampleftk1 =  "+ e.getMessage());
        } finally {
            closeAll();
        }
        return bean;
    }

    public String contaminValue(DataSource dataSource, String ftk) {
        RwsWQuality bean = new RwsWQuality();
        String rss = "";
        try {
            conn = RwsOffices.getConn();
            String qry = "select * from rws_ftk_testing_tbl where (ARSENIC='Y' OR NITRATE='Y' OR FLORIDE='Y' OR SALINITY='Y' OR IRON='Y' OR COLIFORM='Y' OR TURBIDITY='Y' OR CHLORIDES='Y' OR MANGANESE='Y' OR SULPHATES='Y' OR COPPER ='Y' OR CALCIUM='Y' OR TDS='Y' OR MAGNESIUM='Y' OR HARDNESS ='Y') AND ftk_test_id= ? ";
            PreparedStatement stmt = conn.prepareStatement(qry);
            stmt.setString(1, ftk);
            ResultSet rset = stmt.executeQuery();           
            if (rset.next()) {
                rss = "YES";
            } else {
                rss = "NO";
            }
        } catch (Exception e) {
        	System.out.println("The exception is in RwsWQualityData contaminValue = "+e.getMessage());
        }
        return rss;
    }

    public static String contaminStatus(DataSource dataSource, String ftkid) {
        RwsWQuality bean = new RwsWQuality();
        String rss = "";
        try {
            conn = RwsOffices.getConn();

            String qry = "select * from rws_ftk_testing_tbl where (ARSENIC='Y' OR NITRATE='Y' OR FLORIDE='Y' OR SALINITY='Y' OR IRON='Y' OR COLIFORM='Y' OR TURBIDITY='Y' OR CHLORIDES='Y' OR MANGANESE='Y' OR SULPHATES='Y' OR COPPER ='Y' OR CALCIUM='Y' OR TDS='Y' OR MAGNESIUM='Y' OR HARDNESS ='Y') AND ftk_test_id='"
                    + ftkid + "'";

            ////Debug.println("source Y or N Query:"+qry);
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery(qry);
            //Debug.println("Contamin status Qurey:" +qry);

            if (rset.next()) {

                rss = "Y";
            } else {
                rss = "N";
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        }

        return rss;
    }

    public static DAOMessage insertWaterSamplenoftk(RwsWQuality rwsWQuality,
            DataSource dataSource, HttpSession session) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        String ftkid = "";
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        //System.out.println("sd code1:"+rwsWQuality.getSdoc());
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String ftklab = rwsWQuality.getFtklab();
            //String
            // ftkid1=getftkTestId(rwsWQuality.getSourceCode(),dataSource);
            ftkid = rwsWQuality.getFtktestid();

            //Debug.println("ftkid :"+ftkid);
            ////Debug.println("ftkid 1 :"+ftkid1);
            String checkBox1 = "";
            String ftktestid = "";
            //Debug.println("ftklab"+ftklab);
            String checkQuery = "select * from RWS_FTK_TESTING_TBL where source_code='"
                    + rwsWQuality.getSourceCode()
                    + "' and ftk_test_id='"
                    + ftkid + "'";
            //Debug.println("checkQuery"+checkQuery);
            Statement chkStmt = conn.createStatement();
            ResultSet chRs = chkStmt.executeQuery(checkQuery);
            if (ftklab.equals("ftk")) {
                rowCount = 0;
                //Debug.println("in ftk");
                if (!chRs.next()) {
                    query = "insert into RWS_FTK_TESTING_TBL(SOURCE_CODE,FTK_TEST_ID,TEST_DATE,SOURCE_TYPE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE)"
                            + "values('"
                            + rwsWQuality.getSourceCode()
                            + "','"
                            + ftkid
                            + "',TO_DATE('"
                            + rwsWQuality.getFtkTestDate()
                            + "','dd/MM/yyyy'),'"
                            + rwsWQuality.getSourceType()
                            + "','"
                            + rwsWQuality.getDoc()
                            + "','"
                            + rwsWQuality.getSdoc() + "')";
                    //Debug.println("insert No query1= "+query);
                    stmt = conn.createStatement();
                    //Debug.println(" after stamt creation");
                    rowCount = stmt.executeUpdate(query);
                }
                //Debug.println("rowCount"+rowCount);

            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            //Debug.println(" in row couint ");
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            daoMessage.setOperationSussess(false);
        }

        return daoMessage;
    }

    public static ArrayList getftkListDetails(DataSource dataSource, String sourceCode, String ftktestid) {
        RwsWQuality rwsWQuality = null;
        ArrayList wqlist = new ArrayList();
        try {
            String qry = "SELECT * FROM RWS_FTK_TESTING_TBL A WHERE SOURCE_CODE= ? AND FTK_TEST_ID= ?";
            conn = RwsOffices.getConn();
            PreparedStatement stmt = conn.prepareStatement(qry);
            stmt.setString(1, sourceCode);
            stmt.setString(2, ftktestid);
            ResultSet rset = stmt.executeQuery();
            rwsWQuality = new RwsWQuality();
            if (rset.next()) {
                wqlist.add(0, rset.getString(1));
                wqlist.add(1, rset.getString(2));
                for (int i = 3, j = 2; i <= 17; i++, j++) {
                    if (rset.getString(i) != null && !rset.getString(i).equals("") && rset.getString(i).equals("Y")) {
                        wqlist.add(j, "Y");
                    } else {
                        wqlist.add(j, "N");
                    }
                }
            }

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getftkListDetails = "+e.getMessage());
        }
        return wqlist;
    }

    public static ArrayList getftktestids(DataSource dataSource) {
        RwsWQuality rwsWQuality = null;
        ArrayList ftktestids = new ArrayList();
        int i = 0;
        try {
            String qry = "select * from rws_ftk_testing_tbl where forward_date is not null and ftk_test_id not in (select a.source_code from rws_water_sample_collect_tbl a, rws_wq_test_results_tbl b "
                    + " where a.test_id = b.test_id and a.source_code=b.Source_code)";
            conn = RwsOffices.getConn();
            Statement stmt = conn.createStatement();
            ResultSet rset = stmt.executeQuery(qry);
            rwsWQuality = new RwsWQuality();

            while (rset.next()) {
                 ftktestids.add(i++, rset.getString(1) + "-" + rset.getString(2));
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        }

        return ftktestids;
    }

    public static RwsWQuality getWaterSampleftk(String sourceCode, String ftktestid, DataSource dataSource) throws Exception {

        RwsWQuality bean = new RwsWQuality();
        try {
            conn = RwsOffices.getConn();
            String qry = "select to_char(TEST_DATE,'dd/mm/yyyy') as TEST_DATE,to_char(FORWARD_DATE,'dd/mm/yyyy') as FORWARD_DATE,SOURCE_CODE,SOURCE_TYPE,FTK_TEST_ID from RWS_FTK_TESTING_TBL  where Source_code= ? and FTK_TEST_ID= ?";
            ps = conn.prepareStatement(qry);
            ps.setString(1, sourceCode);
            ps.setString(2, ftktestid);
            rs = ps.executeQuery();
            if (rs.next()) {
                Date dt = new Date();
                bean.setFtkTestDate(rs.getString("TEST_DATE"));
                bean.setForwardDate(rs.getString("FORWARD_DATE"));
                bean.setSourceType(rs.getString("SOURCE_TYPE"));
                bean.setSourceCode(rs.getString("SOURCE_CODE"));
                bean.setFtktestid(rs.getString("FTK_TEST_ID"));
                String SourceCode = rs.getString("SOURCE_CODE");
                bean.setCoc(SourceCode.substring(0, 2));
                bean.setMandalCode(SourceCode.substring(5, 7));
                bean.setPanchCode(SourceCode.substring(12, 14));
                bean.setVillageCode(SourceCode.substring(7, 10));
                bean.setHabCode(SourceCode.substring(0, 16));
            }
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getWaterSampleftk = "+e.getMessage());
        } finally {
            closeAll();
        }
        return bean;
    }

    public static RwsWQuality getWaterSamplelab(String sourceCode,
            DataSource dataSource) throws Exception {

        RwsWQuality bean = new RwsWQuality();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String qry = "select w.*, to_char(w.SAMP_COLLECT_DATE,'dd/mm/yyyy') as SAMPDATE from RWS_WATER_SAMPLE_COLLECT_TBL w where Source_code='"
                    + sourceCode + "'";
            //Debug.println("query "+qry);
            rs = stmt.executeQuery(qry);
            if (rs.next()) {
                Date dt = new Date();

                bean.setTestCode(rs.getString("TEST_CODE"));
                bean.setLabCode(rs.getString("LAB_CODE"));
                bean.setNatureOfTest(rs.getString("NATURE_OF_TEST"));
                bean.setLabCode(rs.getString("LAB_CODE"));
                bean.setSampCollectCode(rs.getString("SAMP_COLLECTOR_CODE"));
                bean.setSampCollectDate(rs.getString("SAMPDATE"));
                bean.setSampCollectTime(rs.getString("SAMP_COLLECT_TIME"));
                bean.setAssignedOn(rs.getString("ASSIGNED_ON"));
                bean.setPreparedBy(rs.getString("PREPARED_BY"));
                bean.setPreparedOn(rs.getString("PREPARED_ON"));

            } else {
                bean.setTestCode("");
                bean.setLabCode("");
                bean.setNatureOfTest("");
                bean.setLabCode("");
                bean.setSampCollectCode("");
                bean.setSampCollectDate("");
                bean.setSampCollectTime("");
                bean.setAssignedOn("");
                bean.setPreparedBy("");
                bean.setPreparedOn("");

            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return bean;
    }

   public static DAOMessage updateWaterSampleftk(RwsWQuality rwsWQuality, DataSource dataSource, String[] phy, String[] che, String[] bat, String[] oth, String[] forward, String ftktestid, HttpSession session) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String ftkid = "";
            rowCount = 0;
            String checkQuery1 = "select * from RWS_FTK_TESTING_TBL where source_code= ? and ftk_test_id= ? ";
            PreparedStatement chkStmt1 = conn.prepareStatement(checkQuery1);
            chkStmt1.setString(1, rwsWQuality.getSourceCode());
            chkStmt1.setString(2, ftktestid);
            ResultSet chRs1 = chkStmt1.executeQuery();
            if (chRs1.next()) {
               query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE('" + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                String checkBox = "";
                Collection c = new ArrayList();
                Collection c1 = new ArrayList();
                if (che == null) {
                    checkBox += ",Arsenic='N'";
                    checkBox += ",Nitrate='N'";
                    checkBox += ",Floride='N'";
                    checkBox += ",Salinity='N'";
                    checkBox += ",Iron='N'";
                } else {
                    for (int h = 0; h < che.length; h++) {
                        c.add(che[h]);
                    }
                    if (c.contains("Arsenic")) {
                        checkBox += ",Arsenic='Y'";
                    } else {
                        checkBox += ",Arsenic='N'";
                    }
                    if (c.contains("Nitrate")) {
                        checkBox += ",Nitrate='Y'";
                    } else {
                        checkBox += ",Nitrate='N'";
                    }
                    if (c.contains("Fluoride")) {
                        checkBox += ",Floride ='Y'";
                    } else {
                        checkBox += ",Floride ='N'";
                    }
                    if (c.contains("Salinity")) {
                        checkBox += ",Salinity='Y'";
                    } else {
                        checkBox += ",Salinity='N'";
                    }
                    if (c.contains("Iron")) {
                        checkBox += ",Iron='Y'";
                    } else {
                        checkBox += ",Iron='N'";
                    }
                }
                if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                    checkBox += ",ColiForm='Y'";
                } else {
                    checkBox += ",ColiForm='N'";
                }
                if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                    checkBox += ",Turbidity='Y'";
                } else {
                    checkBox += ",Turbidity='N'";
                }
                if (oth == null) {
                    checkBox += ",Chlorides='N'";
                    checkBox += ",Manganese='N'";
                    checkBox += ",Sulphates='N'";
                    checkBox += ",Copper='N'";
                    checkBox += ",Calcium='N'";
                    checkBox += ",TDS='N'";
                    checkBox += ",Magnesium='N'";
                    checkBox += ",Hardness='N'";
                } else {
                    for (int h = 0; h < oth.length; h++) {
                        c1.add(oth[h]);
                    }
                    if (c1.contains("Chlorides")) {
                        checkBox += ",Chlorides='Y'";
                    } else {
                        checkBox += ",Chlorides='N'";
                    }
                    if (c1.contains("Manganese")) {
                        checkBox += ",Manganese='Y'";
                    } else {
                        checkBox += ",Manganese='N'";
                    }
                    if (c1.contains("Sulphates")) {
                        checkBox += ",Sulphates='Y'";
                    } else {
                        checkBox += ",Sulphates='N'";
                    }
                    if (c1.contains("Copper")) {
                        checkBox += ",Copper='Y'";
                    } else {
                        checkBox += ",Copper='N'";
                    }
                    if (c1.contains("Calcium")) {
                        checkBox += ",Calcium='Y'";
                    } else {
                        checkBox += ",Calcium='N'";
                    }
                    if (c1.contains("TDS")) {
                        checkBox += ",TDS='Y'";
                    } else {
                        checkBox += ",TDS='N'";
                    }
                    if (c1.contains("Magnesium")) {
                        checkBox += ",Magnesium='Y'";
                    } else {
                        checkBox += ",Magnesium='N'";
                    }
                    if (c1.contains("Hardness")) {
                        checkBox += ",Hardness='Y'";
                    } else {
                        checkBox += ",Hardness='N'";
                    }
                }
                query += checkBox + ",FORWARD_DATE=TO_DATE('"
                        + rwsWQuality.getForwardDate()
                        + "','dd/MM/yyyy') where source_code='"
                        + rwsWQuality.getSourceCode() + "' and ftk_test_id='"
                        + ftktestid + "'";
                ps = conn.prepareStatement(query);
                rowCount = ps.executeUpdate();
                if (rowCount > 0) {
                    if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                       String forward1 = "Yes";
                        session.setAttribute("forward1", forward);
                        session.setAttribute("forwarded", "YES");
                    }
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftktestid);
                }
            }
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData updateWaterSampleftk = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Updated Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Updated");
            session.setAttribute("forwarded", "NO");
            daoMessage.setOperationSussess(false);
        }

        return daoMessage;
    }

    public static DAOMessage updateWaterSamplenoftk(RwsWQuality rwsWQuality, DataSource dataSource, String ftktestid) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String ftkid = "";
            rowCount = 0;
            String checkQuery1 = "select * from RWS_FTK_TESTING_TBL where source_code= ? and ftk_test_id= ? ";
            PreparedStatement chkStmt1 = conn.prepareStatement(checkQuery1);
            chkStmt1.setString(1, rwsWQuality.getSourceCode());
            chkStmt1.setString(2, ftktestid);
            ResultSet chRs1 = chkStmt1.executeQuery();

            if (chRs1.next()) {
                query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE( ? ,'dd/MM/yyyy') where source_code= ? and ftk_test_id= ? ";
                ps = conn.prepareStatement(query);
                ps.setString(1, rwsWQuality.getFtkTestDate());
                ps.setString(2, rwsWQuality.getSourceCode());
                ps.setString(3, ftktestid);
                rowCount = ps.executeUpdate();
            }

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData updateWaterSamplenoftk = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Updated Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Updated");
            daoMessage.setOperationSussess(false);
        }
        return daoMessage;
    }

    public static DAOMessage updateWaterSample(RwsWQuality rwsWQuality, DataSource dataSource) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            String query = "UPDATE RWS_WATER_SAMPLE_COLLECT_TBL" + " set "
                    + "TEST_ID= ?,"
                    + "CIRCLE_OFFICE_CODE= ?,"
                    + "DIVISION_OFFICE_CODE= ?,"
                    + "SUBDIVISION_OFFICE_CODE= ?," 
                    + "HAB_CODE= ?"
                    + "SOURCE_CODE= ?,"
                    + "TEST_CODE= ?,"
                    + "NATURE_OF_TEST= ?,"
                    + "LAB_CODE= ?,"
                    + "SAMP_COLLECTOR_CODE= ?,"
                    + "SAMP_COLLECT_DATE=TO_DATE(? ,'dd/MM/yyyy'),"
                    + "SAMP_COLLECT_TIME= ?," 
                    + "ASSIGNED_ON=TO_DATE(? ,'dd/MM/yyyy'),"
                    + "PREPARED_BY= ?,"
                    + "PREPARED_ON=TO_DATE(? ,'dd/MM/yyyy')," 
                    + "SOURCE_TYPE= ? " 
                    + "WHERE TEST_ID= ?";        
            ps = conn.prepareStatement(query);
            ps.setString(1, rwsWQuality.getTestId());
            ps.setString(2, rwsWQuality.getCoc());
            ps.setString(3, rwsWQuality.getDoc());
            ps.setString(4, rwsWQuality.getSdoc());
            ps.setString(5, rwsWQuality.getHabCode());
            ps.setString(6, rwsWQuality.getSourceCode());
            ps.setString(7, rwsWQuality.getTestCode());
            ps.setString(8, rwsWQuality.getNatureOfTest());
            ps.setString(9, rwsWQuality.getLabCode());
            ps.setString(10, rwsWQuality.getSampCollectCode());
            ps.setString(11, rwsWQuality.getSampCollectDate());
            ps.setString(12, rwsWQuality.getSampCollectTime());
            ps.setString(13, rwsWQuality.getAssignedOn());
            ps.setString(14, rwsWQuality.getPreparedBy());
            ps.setString(15, rwsWQuality.getPreparedOn());
            ps.setString(16, rwsWQuality.getSourceType());
            ps.setString(17, rwsWQuality.getTestId());
            rowCount = ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("The Exception is in RwsWQualityData updateWaterSample " + e.getMessage());
        } finally {
            closeAll();
        }        
        if (rowCount > 0) {
            daoMessage.setMessage("Record Updated Successfully");
            daoMessage.setOperationSussess(true);
        } else {
            daoMessage.setMessage("Record Cannot be Updated");
            daoMessage.setOperationSussess(false);
        }
        return daoMessage;
    }

    public static RwsWQuality getWaterSample(String testId, DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        try {
            conn = RwsOffices.getConn();            
            String qry = "SELECT DISTINCT A.TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE,RECOMMENDATIONS FROM RWS_WQ_TEST_RESULTS_LNK_TBL A,RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID=B.TEST_ID AND A.TEST_ID= ? ";
            ps = conn.prepareStatement(qry);
            ps.setString(1,testId);
            ResultSet rss = ps.executeQuery();
            if (rss.next()) {
                String rec = rss.getString("RECOMMENDATIONS");
                String query = "SELECT WC.*,TO_CHAR(WC.SAMP_COLLECT_DATE,'DD/MM/YYYY')AS SAMPLECOLLECTIONDATE,SUBSTR(WC.HAB_CODE,1,2)DCODE,SUBSTR(WC.HAB_CODE,6,2)MCODE,SUBSTR(WC.HAB_CODE,8,3) VCODE,SUBSTR(WC.HAB_CODE,13,2) PCODE FROM RWS_WATER_SAMPLE_COLLECT_TBL WC WHERE WC.TEST_ID= ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, testId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    rwsWQuality = new RwsWQuality();
                    rwsWQuality.setCoc(rs.getString("CIRCLE_OFFICE_CODE"));
                    rwsWQuality.setDoc(rs.getString("DIVISION_OFFICE_CODE"));
                    rwsWQuality.setSdoc(rs.getString("SUBDIVISION_OFFICE_CODE"));
                    rwsWQuality.setCircleOfficeName(RwsMasterData.getCircleOfficeName("1", rs.getString("CIRCLE_OFFICE_CODE"), conn));
                    rwsWQuality.setDivisionOfficeName(RwsMasterData.getDivisionOfficeName("1", rs.getString("CIRCLE_OFFICE_CODE"), rs.getString("DIVISION_OFFICE_CODE"), conn));
                    rwsWQuality.setSubDivisionOfficeName(RwsMasterData.getSubDivisionOfficeName("1", rs.getString("CIRCLE_OFFICE_CODE"), rs.getString("DIVISION_OFFICE_CODE"), rs.getString("SUBDIVISION_OFFICE_CODE"), conn));
                    rwsWQuality.setMandalCode(rs.getString("MCODE"));
                    rwsWQuality.setPanchCode(rs.getString("PCODE"));
                    rwsWQuality.setMandalName(RwsMasterData.getMandalName(rs.getString("DCODE"), rs.getString("MCODE"), conn));
                    rwsWQuality.setPanchName(RwsMasterData.getPanchayatName(rs.getString("DCODE"), rs.getString("MCODE"), rs.getString("PCODE"), conn));
                    rwsWQuality.setVillageCode(RwsMasterData.getVillageName(rs.getString("DCODE"), rs.getString("MCODE"), rs.getString("PCODE"), rs.getString("VCODE"), conn));
                    rwsWQuality.setTestId(rs.getString("TEST_ID"));
                    rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
                    rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                    rwsWQuality.setSourceType(rs.getString("SOURCE_TYPE"));
                    rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
                    rwsWQuality.setNatureOfTest(rs.getString("NATURE_OF_TEST"));
                    rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
                    rwsWQuality.setSampCollectCode(rs.getString("SAMP_COLLECTOR_CODE"));
                    rwsWQuality.setSampCollectDate(rs.getString("sampleCollectionDate"));
                    rwsWQuality.setSampCollectTime(rs.getString("SAMP_COLLECT_TIME"));
                    rwsWQuality.setAssignedOn(df.format(rs.getDate("ASSIGNED_ON")));
                    rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
                    rwsWQuality.setPreparedOn(df.format(rs.getDate("PREPARED_ON")));
                    rwsWQuality.setRecommendations(rec);              
                   }
                ps = conn.prepareStatement("SELECT PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE PANCH_CODE= ?");
                ps.setString(1, rwsWQuality.getHabCode());
                rs = ps.executeQuery();
                if (rs.next()) {
                    rwsWQuality.setHabName(rs.getString(1));
                }
            }
        } catch (Exception e) {
           System.out.println("The exception in RwsWQualityData getWaterSample = "+e.getMessage());
        } finally {
            closeAll();
        }
        return rwsWQuality;
    }

    public static ArrayList getfktdetails(String preparedBy, RwsWQAbstractActionForm waterSample, DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList watersamples = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            String query = "select FTK_TEST_ID,SOURCE_CODE,to_char(TEST_DATE,'dd/mm/yyyy')as TEST_DATE,NVL(to_char(FORWARD_DATE,'dd/mm/yyyy'),'-')as FORWARD_DATE,SOURCE_TYPE,decode(FIELD_TEST_CHEMICAL,'Y','YES','N','NO') as FTC,decode(H2S_VIAL,'Y','YES','N','NO') as HSV from rws_ftk_testing_tbl";
            if (waterSample.getCircleOfficeCode() != null && !waterSample.getCircleOfficeCode().equals("")) {
                query += " Where substr(SOURCE_CODE,0,2)='"+ waterSample.getCircleOfficeCode() + "' ";
            }
            if (waterSample.getDivisionOfficeCode() != null && !waterSample.getDivisionOfficeCode().equals("")) {
                query += " and division_office_code='" + waterSample.getDivisionOfficeCode() + "'";
            }
            if (waterSample.getSubdivisionOfficeCode() != null && !waterSample.getSubdivisionOfficeCode().equals("")) {
                query += " and subdivision_office_code='" + waterSample.getSubdivisionOfficeCode() + "'";
            }
            if (waterSample.getMandalCode() != null && !waterSample.getMandalCode().equals("")) {
                query += " and substr(SOURCE_CODE,6,2)='"+ waterSample.getMandalCode() + "' ";
            }
            if (waterSample.getPanchayatCode() != null && !waterSample.getPanchayatCode().equals("")) {
                query += "and substr(SOURCE_CODE,13,2)='" + waterSample.getPanchayatCode() + "' ";
            }
            if (waterSample.getHabCode() != null && !waterSample.getHabCode().equals("")) {
                query += " and substr(SOURCE_CODE,0,16)='"+ waterSample.getHabCode() + "' ";
            }
            query += " order by TEST_DATE desc";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                try {
                    rwsWQuality = new RwsWQuality();
                    String src = rs.getString("SOURCE_CODE");
                    src = rs.getString("SOURCE_CODE").substring(0, 2);
                    rwsWQuality.setCoc(rs.getString("SOURCE_CODE").substring(0, 2));
                    rwsWQuality.setCircleOfficeName(RwsMasterData.getCircleOfficeName("1", rs.getString("SOURCE_CODE").substring(0, 2), conn));
                    rwsWQuality.setMandalCode(waterSample.getMandalCode());
                    rwsWQuality.setPanchCode(waterSample.getPanchayatCode());
                    rwsWQuality.setFtktestid(rs.getString("FTK_TEST_ID"));
                    rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                    rwsWQuality.setFtkTestDate(rs.getString("TEST_DATE"));
                    rwsWQuality.setForwardDate(rs.getString("FORWARD_DATE"));
                    rwsWQuality.setSourceType(getSourceName(format(rs.getString("SOURCE_TYPE"))));
                    rwsWQuality.setHabCode(rs.getString("SOURCE_CODE").substring(0, 16));
                    rwsWQuality.setHabName(RwsMasterData.getHabName(rs.getString("SOURCE_CODE").substring(0, 16), conn));
                    rwsWQuality.setFtkCtype(rs.getString("FTC"));
                    rwsWQuality.setFtkHtype(rs.getString("HSV"));
                    watersamples.add(rwsWQuality);
                } catch (Exception e) {
                	System.out.println("The exception in RwsWQualityData getfktdetails = "+e.getMessage());
                }
            }

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getfktdetails = "+e.getMessage());
        } finally {
            closeAll();
        }
        return watersamples;
    }

    public static ArrayList getWaterSamples(String preparedBy, RwsWQAbstractActionForm waterSample, DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList watersamples = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            String query = "select SCT.TEST_ID,SCT.CIRCLE_OFFICE_CODE,"
                    + "SCT.DIVISION_OFFICE_CODE,SCT.SUBDIVISION_OFFICE_CODE,"
                    + "SCT.HAB_CODE,SCT.SOURCE_TYPE,SCT.SOURCE_CODE,"
                    + "SCT.TEST_CODE,SCT.NATURE_OF_TEST,SCT.LAB_CODE,"
                    + "D.DESIGNATION_ACR,TO_CHAR(SCT.SAMP_COLLECT_DATE,'DD/MM/YYYY')SAMP_COLLECT_DATE,"
                    + "SCT.SAMP_COLLECT_TIME,SCT.ASSIGNED_ON,"
                    + "SCT.PREPARED_BY,v.dname,v.panch_name,t.test_name,l.lab_name from RWS_WATER_SAMPLE_COLLECT_TBL SCT,RWS_DESIGNATION_TBL D ,rws_complete_hab_view v,RWS_WATER_QUALITY_LAB_TBL l,RWS_WATER_QUALITY_TEST_TBL t "
                    + " where D.DESIGNATION_CODE=SCT.SAMP_COLLECTOR_CODE and sct.hab_code=v.panch_code(+) and sct.lab_code=l.lab_code  and sct.test_code=t.test_code ";
           
            if (waterSample.getCircleOfficeCode() != null && !waterSample.getCircleOfficeCode().equals("")) {
                query += " and SCT.CIRCLE_OFFICE_CODE='" + waterSample.getCircleOfficeCode() + "' ";
            }
            if (waterSample.getDivisionOfficeCode() != null && !waterSample.getDivisionOfficeCode().equals("")) {
                query += " and SCT.DIVISION_OFFICE_CODE='" + waterSample.getDivisionOfficeCode() + "' ";
            }
            if (waterSample.getSubdivisionOfficeCode() != null && !waterSample.getSubdivisionOfficeCode().equals("")) {
                query += " and SCT.SUBDIVISION_OFFICE_CODE='" + waterSample.getSubdivisionOfficeCode() + "' ";
            }
            if (waterSample.getMandalCode() != null && !waterSample.getMandalCode().equals("")) {
                query += " and substr(SCT.SOURCE_CODE,6,2)='" + waterSample.getMandalCode() + "' ";
            }
            if (waterSample.getPanchayatCode() != null && !waterSample.getPanchayatCode().equals("")) {
                query += "and substr(SCT.SOURCE_CODE,13,2)='" + waterSample.getPanchayatCode() + "' ";
            }
            if (waterSample.getHabCode() != null && !waterSample.getHabCode().equals("")) {
                query += " and substr(SCT.SOURCE_CODE,0,16)='" + waterSample.getHabCode() + "' ";
            }
            query += " order by CIRCLE_OFFICE_CODE ,DIVISION_OFFICE_CODE ,SUBDIVISION_OFFICE_CODE,ASSIGNED_ON desc ";
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                try {
                    rwsWQuality = new RwsWQuality();
                    rwsWQuality.setTestId(rs.getString("TEST_ID"));
                    rwsWQuality.setCoc(rs.getString("CIRCLE_OFFICE_CODE"));
                    rwsWQuality.setCircleOfficeName(rs.getString("dname"));
                    rwsWQuality.setDoc(rs.getString("DIVISION_OFFICE_CODE"));
                    rwsWQuality.setSdoc(rs.getString("SUBDIVISION_OFFICE_CODE"));
                    rwsWQuality.setMandalCode(waterSample.getMandalCode());
                    rwsWQuality.setHabCode(rs.getString("SOURCE_CODE").substring(0, 16));
                    rwsWQuality.setHabName(rs.getString("panch_name"));
                    rwsWQuality.setSourceType(getSourceName(format(rs.getString("SOURCE_TYPE"))));
                    rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                    rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
                    rwsWQuality.setTestName(rs.getString("test_name"));
                    int natureOfTestCode = rs.getInt("NATURE_OF_TEST");
                    String natureOfTest = "";
                    switch (natureOfTestCode) {
                        case 1:
                            natureOfTest = "ROUTINE";
                            break;
                        case 2:
                            natureOfTest = "SEASONAL";
                            break;
                        case 3:
                            natureOfTest = "QUARTERLY";
                            break;
                        case 4:
                            natureOfTest = "DISEASE OUTBREAK";
                    }
                    rwsWQuality.setNatureOfTest(natureOfTest);
                    rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
                    rwsWQuality.setLabName(rs.getString("lab_name"));
                    rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
                    rwsWQuality.setSampCollectDate(rs.getString("SAMP_COLLECT_DATE"));
                    rwsWQuality.setSampCollectTime(rs.getString("SAMP_COLLECT_TIME"));
                    rwsWQuality.setAssignedOn(df.format(rs.getDate("ASSIGNED_ON")));
                    rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
                    watersamples.add(rwsWQuality);
                } catch (Exception e) {
                	System.out.println("The exception in RwsWQualityData getWaterSamples inside Catch = "+e.getMessage());
                }
            }           
        } catch (Exception e) {
        	System.out.println("The exception in RwsLocations getWaterSamples outside Catch= "+e.getMessage());
        } finally {
            closeAll();
        }
        return watersamples;
    }
    
    public static int removeWaterSampleftk(String ftktestid, String sourcecode, DataSource dataSource) throws Exception {
        int del = 0;
        try {
            conn = RwsOffices.getConn();
            PreparedStatement stmt1 = null;
            String ftkid = ftktestid;            
            String scode = sourcecode;
            String qry1 = ("DELETE FROM RWS_FTK_TESTING_TBL  WHERE FTK_TEST_ID= ? and SOURCE_CODE= ?");
            ps = conn.prepareStatement(qry1);
            ps.setString(1, ftkid);
            ps.setString(2, scode);
            del = ps.executeUpdate();
        } catch (Exception e) {
        	System.out.println("The exception in RwsLocations removeWaterSampleftk = "+e.getMessage());
        } finally {
            closeAll();
        }        
        return del;
    }

    public static int removeWaterSample(String testId, DataSource dataSource) throws Exception {
		int del = 0;
		int rvalue[]=null;
		PreparedStatement stmt1=null;		
		try {
			conn = RwsOffices.getConn();	
			 String qrylnk = "select distinct a.test_id from RWS_WQ_TEST_RESULTS_TBL a,RWS_WQ_TEST_RESULTS_lnk_TBL b where a.test_id=b.test_id and a.test_id= ?";
			 stmt1 = conn.prepareStatement(qrylnk);	
			 stmt1.setString(1, testId);
			 ResultSet rss =stmt1.executeQuery(); 
			  if(rss.next()) {
				  stmt=conn.createStatement();
				  stmt.addBatch("DELETE FROM  RWS_WQ_TEST_RESULTS_lnk_TBL WHERE TEST_ID='"+testId+"'");
				  stmt.addBatch("DELETE FROM RWS_WQ_TEST_RESULTS_TBL WHERE  TEST_ID='"+testId+"'"); 
				  stmt.addBatch("DELETE FROM RWS_WATER_SAMPLE_COLLECT_TBL WHERE TEST_ID='"+testId+"'");
				  rvalue=stmt.executeBatch(); 
				  del = rvalue.length; 
			  } 
			  else { del = -1; }			 
		} catch (Exception e) {
			System.out.println("The exception in RwsWQualityData removeWaterSample = "+e.getMessage());
		} finally {
			closeAll();
		}		
			return del;
		}

    public static void updateWaterSample(String testId, RwsWQuality rwsWQuality, DataSource dataSource) throws Exception {
        try {
            conn = RwsOffices.getConn();
            ps = conn.prepareStatement("update RWS_WATER_SAMPLE_COLLECT_TBL set HAB_CODE=?,SOURCE_CODE=?,TEST_CODE=?,NATURE_OF_TEST=?,LAB_CODE=?,SAMP_COLLECTOR_CODE=? "
            		+ ", SAMP_COLLECT_DATE=TO_DATE( ? ,'dd/MM/yyyy'),SAMP_COLLECT_TIME=?, ASSIGNED_ON =TO_DATE( ? ,'dd/MM/yyyy'),SOURCE_TYPE=? where test_id= ?");
            ps.setString(1, rwsWQuality.getHabCode());
            ps.setString(2, rwsWQuality.getSourceCode());
            ps.setString(3, rwsWQuality.getTestCode());
            ps.setString(4, rwsWQuality.getNatureOfTest());
            ps.setString(5, rwsWQuality.getLabCode());
            ps.setString(6, rwsWQuality.getSampCollectCode());
            ps.setString(7, rwsWQuality.getSampCollectDate());
            ps.setString(8, rwsWQuality.getSampCollectTime());
            ps.setString(9, rwsWQuality.getSampCollectDate());
            ps.setString(10, rwsWQuality.getSourceType());
            ps.setString(11, testId);            
            ps.executeUpdate();

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData updateWaterSample = "+e.getMessage());
        } finally {
            closeAll();
        }
    }

    public static int[] insertWaterSampleRes(RwsWQuality rwsWQuality,
            ArrayList tests, ArrayList allResults, DataSource dataSource)
            throws Exception {
        int rowCount[] = new int[50];
        String query = "";
        String query1 = "";
        //System.out.println("in insertWaterSampleRes");
        WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
        WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
        try {
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            int size = tests.size();
            ArrayList inserted = new ArrayList();
            for (int i = 0; i < tests.size(); i++) {
                inserted.add(i, "false");
            }

            for (int i = 0; i < tests.size(); i++) {

                waterSampleTestResBean = (WaterSampleTestResBean) tests.get(i);
                if (waterSampleTestResBean.getHabCode() != null) {

                    query1 = "insert into RWS_WQ_TEST_RESULTS_TBL values"
                            + "('" + waterSampleTestResBean.getTestId() + "',"
                            + "'" + rwsWQuality.getRecommendations() + "',"
                            + "'" + rwsWQuality.getCondemnSource() + "'," + "'"
                            + rwsWQuality.getUpdateSource() + "',"
                            + "TO_DATE('" + rwsWQuality.getForwadedOn()
                            + "','dd/MM/yyyy')," + "'"
                            + rwsWQuality.getPreparedBy() + "'," + "TO_DATE('"
                            + rwsWQuality.getPreparedOn() + "','dd/MM/yyyy'),"
                            + "'" + waterSampleTestResBean.getTestCode() + "',"
                            + "'" + waterSampleTestResBean.getLabCode() + "',"
                            + "'" + waterSampleTestResBean.getSourceCode()
                            + "')";
                    ////System.out.println("query is "+query1);
                    //stmt.addBatch(query);

                    for (int k = 0; k < allResults.size(); k++) {
                        ArrayList resultsTmp = (ArrayList) allResults.get(k);
                        for (int j = 0; j < resultsTmp.size(); j++) {
                            waterSampleTestResLnk = (WaterSampleTestResLnk) resultsTmp
                                    .get(j);
                            if (waterSampleTestResBean.getTestId().equals(
                                    waterSampleTestResLnk.getTestId())) {
                                if (((String) inserted.get(i)).equals("false")) {
                                    stmt.addBatch(query1);
                                    //System.out.println("query added is
                                    // "+query1);
                                    inserted.add(i, "true");
                                }
                                query = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL values"
                                        + "('"
                                        + waterSampleTestResLnk.getTestId()
                                        + "',"
                                        + "'"
                                        + waterSampleTestResLnk.getTestPCode()
                                        + "',"
                                        + "'"
                                        + waterSampleTestResLnk.getResult()
                                        + "')";
                                //System.out.println("query is "+query);
                                stmt.addBatch(query);
                            }

                        }
                    }

                }
            }

            rowCount = stmt.executeBatch();
            conn.commit();

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static int insertWaterSampleRes1(RwsWQuality rwsWQuality,
            ArrayList tests, ArrayList carryResults, String selectedRadio,
            DataSource dataSource) throws Exception {
        int rowCount[] = new int[50];
        int rowCountt = 0;
        String testIds = "", testParameter = "", testValue = "";
        String query = "";
        String query1 = "";
        //Debug.println("in insertWaterSampleRes");
        WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
        WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
        //System.out.println("selectedRadio:"+selectedRadio);
        int selectedRadio1 = Integer.parseInt(selectedRadio);
        //System.out.println("selectedRadio1:"+selectedRadio1);
        try {
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            int size = tests.size();

            waterSampleTestResBean = (WaterSampleTestResBean) tests
                    .get(selectedRadio1);
            String checkQuery = "select * from RWS_WQ_TEST_RESULTS_TBL where  test_id='"
                    + waterSampleTestResBean.getTestId() + "'";
            //Debug.println("checkQuery"+checkQuery);
            Statement chkStmt = conn.createStatement();
            ResultSet chRs = chkStmt.executeQuery(checkQuery);
            if (!chRs.next()) {
                ////Debug.println(" test id is not
                // repeated:"+waterSampleTestResBean.getTestId());
                // boolean flag=false;
                /*
				 * for(int j=0,i=0;j <carryResults.size()/3;j++) { i++;i++;
				 * String val = (String)carryResults.get(i++); if(val!=null &&
				 * !val.equals("") && Double.parseDouble(val) > 0) { flag=true; }
				 *  } if(flag==true) {
                 */
                // //Debug.println("ddddd::"+carryResults.size());
                if (waterSampleTestResBean.getTestId() != null
                        && !waterSampleTestResBean.getTestId().equals("")) {
                    //System.out.println("in side if");
                    query1 = "insert into RWS_WQ_TEST_RESULTS_TBL values"
                            + "('" + waterSampleTestResBean.getTestId() + "',"
                            + "'" + rwsWQuality.getRecommendations() + "',"
                            + "''," + "'" + rwsWQuality.getUpdateSource()
                            + "'," + "TO_DATE('" + rwsWQuality.getForwadedOn()
                            + "','dd/MM/yyyy')," + "'"
                            + rwsWQuality.getPreparedBy() + "'," + "TO_DATE('"
                            + rwsWQuality.getPreparedOn() + "','dd/MM/yyyy'),"
                            + "'" + waterSampleTestResBean.getTestCode() + "',"
                            + "'" + waterSampleTestResBean.getLabCode() + "',"
                            + "'" + waterSampleTestResBean.getSourceCode()
                            + "'," + "'')";
                    //Debug.println("query is "+query1);
                    stmt.addBatch(query1);
                    for (int j = 0, i = 0; j < carryResults.size() / 3; j++) {
                        //System.out.println(i+"~~~~~~"+j);
                        testIds = (String) carryResults.get(i++);
                        testParameter = (String) carryResults.get(i++);
                        testValue = (String) carryResults.get(i++);
                        if (testValue != null && !testValue.equals(""))// &&
                        // Double.parseDouble(testValue)
                        // > 0
                        {
                            query = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL values"
                                    + "('"
                                    + testIds
                                    + "',"
                                    + "'"
                                    + testParameter
                                    + "',"
                                    + "'"
                                    + testValue
                                    + "')";
                            //Debug.println("query is for carryResults
                            // "+query);
                            stmt.addBatch(query);
                        }
                    }
                }
                rowCount = stmt.executeBatch();
                //Debug.println("sss:"+rowCount.length);
                conn.commit();
                rowCountt = rowCount.length;
                /*
				 * } else { rowCountt = -1; //Debug.println("No results found
				 * "); }
                 */
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        ////Debug.println("exit from insertWaterSampleRes"+rowCount.length);
        return rowCountt;
    }

    public static String insertWaterSampleRes2(RwsWQuality rwsWQuality,
            ArrayList tests, String selectedRadio, DataSource dataSource)
            throws Exception {
        int rowCount[] = new int[50];
        String rowCountt = "";
        String testIds = "", testParameter = "", testValue = "";
        String query = "";
        String query1 = "";
        //Debug.println("in insertWaterSampleRes222222222222222222222");
        WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
        WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
        //System.out.println("selectedRadio:"+selectedRadio);
        int selectedRadio1 = Integer.parseInt(selectedRadio);
       
        //System.out.println("selectedRadio1:" + selectedRadio1);
        try {
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            Statement stmt1 = conn.createStatement();
            Statement stmt2 = conn.createStatement();
            Statement stmt3 = conn.createStatement();
            ResultSet rs1 = null, rs2 = null, rs3 = null;

            waterSampleTestResBean = (WaterSampleTestResBean) tests
                    .get(selectedRadio1);
            String checkQuery = "select * from RWS_WQ_TEST_RESULTS_TBL where  test_id='"
                    + waterSampleTestResBean.getTestId() + "'";
            Statement chkStmt = conn.createStatement();
            ResultSet chRs = chkStmt.executeQuery(checkQuery);
            if (!chRs.next()) {

                String qryy = "select TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_QUALITY_RESULTS_TMP_TBL where test_id='"
                        + waterSampleTestResBean.getTestId() + "' ";
                //System.out.println("qryy:"+qryy);
                rs2 = stmt2.executeQuery(qryy);
                if (rs2.next()) {
                    query1 = "insert into RWS_WQ_TEST_RESULTS_TBL values"
                            + "('" + rs2.getString(1) + "'," + "'"
                            + rwsWQuality.getRecommendations() + "'," + "'',"
                            + "'" + rwsWQuality.getUpdateSource() + "',"
                            + "TO_DATE('" + rwsWQuality.getForwadedOn()
                            + "','dd/MM/yyyy')," + "'"
                            + rwsWQuality.getPreparedBy() + "'," + "TO_DATE('"
                            + rwsWQuality.getPreparedOn() + "','dd/MM/yyyy'),"
                            + "'" + waterSampleTestResBean.getTestCode() + "',"
                            + "'" + waterSampleTestResBean.getLabCode() + "',"
                            + "'" + waterSampleTestResBean.getSourceCode()
                            + "'," + "'','')";
                    //Debug.println("query1:" + query1);
                    stmt.addBatch(query1);
                    String q1 = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL(TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE) select TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_QUALITY_RESULTS_TMP_TBL where TEST_ID='"
                            + rs2.getString(1) + "'";
                    //Debug.println("q1:" + q1);
                    stmt.addBatch(q1);

                    String q2 = "delete from RWS_QUALITY_RESULTS_TMP_TBL where test_id='"
                            + rs2.getString(1) + "' ";
                    //Debug.println("q2:" + q2);
                    stmt.addBatch(q2);
                }

                rowCount = stmt.executeBatch();
                //Debug.println("rowCount[0]:" + rowCount[0]);
                //Debug.println("rowCount[1]:" + rowCount[1]);
                //Debug.println("rowCount[2]:" + rowCount[2]);
                // Debug.println("rowCount[3]:"+rowCount[3]);
                if (rowCount[0] == 1 && (rowCount[1] == rowCount[2])) {
                    String q3 = " select count(*) from RWS_WQ_TEST_RESULTS_LNK_TBL a,RWS_WQ_TEST_RESULTS_TBL b where a.test_id=b.test_id and a.test_id='"
                            + rs2.getString(1) + "'";
                    //Debug.println("q3:" + q3);
                    rs3 = stmt3.executeQuery(q3);
                    if (rs3.next() && rs3.getInt(1) > 0) {
                        conn.setAutoCommit(true);
                        conn.commit();
                        rowCountt = "Record Inserted Successfully";
                    } else {
                        conn.rollback();
                        rowCountt = "The Record Cant be inserted";
                    }

                } else {
                    conn.rollback();
                    rowCountt = "The Record Cant be inserted";
                }

            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCountt;
    }

    public static RwsWQuality getWaterSampleResult(DataSource dataSource,
            String testId) throws Exception {
        RwsWQuality rwsWQuality = null;

        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            String query = "SELECT * FROM RWS_WQ_TEST_RESULTS_TBL WHERE TEST_ID='"
                    + testId + "'";
            //System.out.println("query is "+query);
            rs = stmt.executeQuery(query);
            if (rs.next()) {
                rwsWQuality = new RwsWQuality();
                //System.out.println("Recommendations in
                // Method:"+rs.getString(2));
                rwsWQuality.setTestId(rs.getString(1));
                rwsWQuality.setRecommendations(rs.getString(2));
                rwsWQuality.setUpdateSource(rs.getString(4));
                rwsWQuality.setForwadedTo(rs.getString(6));
                rwsWQuality.setForwadedOn(df.format(rs.getDate(5)));
                rwsWQuality.setTestCode(rs.getString(8));
                rwsWQuality.setLabCode(rs.getString(9));
                rwsWQuality.setSourceCode(rs.getString(10));
                rwsWQuality.setCondemnSource(rs.getString(11));

            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rwsWQuality;
    }

    // code modfied by sridhar
    public static ArrayList getWaterSampleResults(DataSource dataSource,
            WaterSampleResForm waterSampleResForm, String empcode)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList watersampleres = new ArrayList();
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        try {
            String query = "";
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            query = "select wq.test_id,wq.source_code,t.test_name,l.lab_name,wq.recommendations,decode(wq.potable,'Y','YES','N','NO'),decode(wq.update_source_data,'Y' ,'YES','N','NO'),p.USER_ID,to_char(wq.FORWARDED_ON,'dd/mm/YYYY'),WQ.PREPARED_ON,v.panch_name  from RWS_WQ_TEST_RESULTS_TBL wq,RWS_WATER_QUALITY_TEST_TBL t,RWS_WATER_QUALITY_LAB_TBL l,rws_password_tbl p,rws_complete_hab_view v where ";
            if (waterSampleResForm.getCircleOfficeCode() != null
                    && !waterSampleResForm.getCircleOfficeCode().equals("")) {
                query += " substr(wq.source_code,0,2)='"
                        + waterSampleResForm.getCircleOfficeCode() + "' and ";
            }
            if (waterSampleResForm.getDivisionOfficeCode() != null
                    && !waterSampleResForm.getDivisionOfficeCode().equals("")) {
                ////Debug.println(" in division");
                query += " substr(l.office_code,4,1)='"
                        + waterSampleResForm.getDivisionOfficeCode() + "' and ";
            }
            if (waterSampleResForm.getMandalCode() != null
                    && !waterSampleResForm.getMandalCode().equals("")) {
                ////Debug.println(" in division");
                query += " substr(wq.source_code,6,2)='"
                        + waterSampleResForm.getMandalCode() + "' and ";
            }
            query += " wq.test_code=t.test_code  and wq.lab_code=l.lab_code and substr(source_code,1,16)=v.panch_code(+) and wq.PREPARED_BY=p.user_id order by v.panch_name,wq.FORWARDED_ON";
            Debug.println("Sai:" + query);

            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestId(rs.getString(1));
                rwsWQuality.setSourceName(rs.getString(2));
                rwsWQuality.setTestName(rs.getString(3));
                rwsWQuality.setLabName(rs.getString(4));
                rwsWQuality.setRecommendations(rs.getString(5));
                rwsWQuality.setCondemnSource(rs.getString(6));
                rwsWQuality.setUpdateSource(rs.getString(7));
                rwsWQuality.setForwadedTo(rs.getString(8));
                rwsWQuality.setForwadedOn(rs.getString(9));
                rwsWQuality.setPreparedOn(df.format(rs.getDate(10)));
                //rwsWQuality.setHabName(rwsLocations.getHabName(rs.getString("SOURCE_CODE").substring(0,16),conn));
                rwsWQuality.setHabName(rs.getString(11));
                watersampleres.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return watersampleres;
    }

    public static int removeWaterSampleRes(String testId, DataSource dataSource)
            throws Exception {
        int rowCount = 0;
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String qry = "";
            qry = "DELETE FROM RWS_WQ_TEST_RESULTS_lnk_TBL  WHERE TEST_ID='"
                    + testId + "'";
            stmt.addBatch(qry);
            //		rowCount=stmt.executeUpdate(qry);
            qry = "delete from RWS_WQ_TEST_RESULTS_TBL where test_id='"
                    + testId + "'";
            stmt.addBatch(qry);
            int[] a = stmt.executeBatch();
            //rowCount=stmt.executeUpdate(qry);
            rowCount = a.length;
            //Debug.println("rowCount:"+rowCount);
        } //	rs =stmt.executeQuery("SELECT * FROM rws_watersample_tbl where
        // HAB_CODE='"+habCode+"'");
        //	if(rs.next() == false)
        //	{
        //		rowCount=stmt.executeUpdate("delete from rws_watersample_tbl where
        // HAB_CODE='"+habCode+"' and ENTEREDON='"+employeeCode+"'");
        //	}
        //}
        catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static int updateWaterSampleResult(String testId, ArrayList results,
            RwsWQuality rwsWQuality, DataSource dataSource) throws Exception {
        int rowCount[] = new int[50];
        int rowCountt = 0;
        WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
        try {
          //  System.out.println("testId--------------------" + testId);
            conn = RwsOffices.getConn();
            Statement stmt3 = conn.createStatement();
            ResultSet rs3 = null;
            boolean flag = false;
            conn.setAutoCommit(false);
            String checkQuery = " select TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_QUALITY_RESULTS_TMP_TBL where test_id='"
                    + testId + "'  ";
            Statement chkStmt = conn.createStatement();
            ResultSet chRs = chkStmt.executeQuery(checkQuery);
            if (chRs.next()) {
                String query = "update RWS_WQ_TEST_RESULTS_TBL set RECOMMENDATIONS='"
                        + rwsWQuality.getRecommendations()
                        + "',UPDATE_SOURCE_DATA='"
                        + rwsWQuality.getUpdateSource()
                        + "',FORWARDED_ON=TO_DATE('"
                        + rwsWQuality.getForwadedOn()
                        + "','dd/MM/yyyy') where TEST_ID='"
                        + chRs.getString(1)
                        + "'";
                stmt = conn.createStatement();
                stmt.addBatch(query);
              //  System.out.println("query  is: " + query);
                String qry = "DELETE FROM RWS_WQ_TEST_RESULTS_lnk_TBL  WHERE TEST_ID='"
                        + chRs.getString(1) + "'";
                stmt.addBatch(qry);
                String q1 = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL(TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE) select TEST_ID,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_QUALITY_RESULTS_TMP_TBL where TEST_ID='"
                        + chRs.getString(1) + "'";
                //Debug.println("q1:" + q1);
                stmt.addBatch(q1);
                String q2 = "delete from RWS_QUALITY_RESULTS_TMP_TBL where test_id='"
                        + chRs.getString(1) + "' ";
                //Debug.println("q2:" + q2);
                stmt.addBatch(q2);
            }
           // System.out.println("after loop");
            rowCount = stmt.executeBatch();
          //  System.out.println("rowCount:" + rowCount.length);
            if (rowCount.length > 0) {
              //  System.out.println("in count loop");
                String q3 = " select count(*) from RWS_WQ_TEST_RESULTS_LNK_TBL a,RWS_WQ_TEST_RESULTS_TBL b where a.test_id=b.test_id and a.test_id='"
                        + chRs.getString(1) + "'";
               // System.out.println("q3:" + q3);
                rs3 = stmt3.executeQuery(q3);
              //  System.out.println("after q3 execution:");
                if (rs3.next() && rs3.getInt(1) > 0) {
                    //System.out.println("ainside rs3.next:");
                    conn.setAutoCommit(true);
                    conn.commit();
                    rowCountt = rowCount.length;
                } else {
                    //System.out.println("else 1");
                    conn.rollback();
                    rowCountt = -1;
                }

            } else {
               // System.out.println("else 2");
                conn.rollback();
                rowCountt = -1;
            }

            /*
			 * String query="update RWS_WQ_TEST_RESULTS_TBL set
			 * RECOMMENDATIONS='"+rwsWQuality.getRecommendations()+"',UPDATE_SOURCE_DATA='"+rwsWQuality.getUpdateSource()+"',FORWARDED_ON=TO_DATE('"+rwsWQuality.getForwadedOn()+"','dd/MM/yyyy')
			 * where TEST_ID='"+testId+"'"; stmt=conn.createStatement();
			 * stmt.addBatch(query); System.out.println("query is: "+query);
			 * String qry = "DELETE FROM RWS_WQ_TEST_RESULTS_lnk_TBL WHERE
			 * TEST_ID='"+testId+"'"; stmt.addBatch(qry);
			 * System.out.println("RES:"+results.size());
			 * 
			 * 
			 * for (int j=0;j <results.size();j++) {
			 * System.out.println("sssssss"+results.get(j));
			 * //waterSampleTestResLnk = (WaterSampleTestResLnk)results.get(j);
			 * System.out.println("DDDDDD:"+(WaterSampleTestResLnk)results.get(j));
			 * String val = waterSampleTestResLnk.getResult(); if(val!=null &&
			 * !val.equals("")) { qry="insert into RWS_WQ_TEST_RESULTS_LNK_TBL
			 * values('"+testId+"','"+waterSampleTestResLnk.getTestPCode()+"','"+val+"')";
			 * System.out.println("inner:" +qry); stmt.addBatch(qry); } }
			 * rowCount = stmt.executeBatch(); Debug.println("after
			 * executon:"+rowCount); if(rowCount.length>0) {
			 * rowCountt=rowCount.length; conn.setAutoCommit(true);
			 * conn.commit(); } else { rowCountt = 0; }
			 * System.out.println("rowCountt:"+rowCountt);
             */
        } catch (Exception e) {
            System.out.println("Exception at updateWaterSampleResult in RwsWQualityData " + e.getMessage());
            conn.rollback();
            rowCountt = -1;
        } finally {
            closeAll();
        }
        return rowCountt;
    }

    public static ArrayList getHabCodesForWaterSample(DataSource dataSource,
            String coc, String doc, String sdoc) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList habs = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            //System.out.println("coc="+coc+"***doc="+doc+"****sdoc="+sdoc);
            rs = stmt
                    .executeQuery("SELECT panch_code,panch_name FROM rws_panchayat_raj_tbl WHERE substr(panch_code,0,2)='"
                            + coc + "' order by panch_name");
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setCode(rs.getString("PANCH_CODE"));
                rwsWQuality.setName(rs.getString("PANCH_NAME"));
                rwsWQuality.setCodeName(rs.getString("PANCH_NAME") + " - "
                        + rs.getString("PANCH_CODE"));
                habs.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return habs;
    }

    public static ArrayList getEmpCodesForWaterSample(DataSource dataSource,
            String designation) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList empcodes = new ArrayList();
        String query;

        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            //System.out.println("designation is "+designation);
            if (designation.equals("lab")) {
                query = "SELECT USER_ID FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='13'";
                rs = stmt.executeQuery(query);
            } else if (designation.equals("geologist")) {
                query = "SELECT USER_ID FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='12'";
                rs = stmt.executeQuery(query);
            }
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setEmpcode(rs.getString(1));
                empcodes.add(rwsWQuality);

            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return empcodes;
    }

    public static String getEmpName(String code, Connection conn)
            throws Exception {
        String name = null;
        Statement stmt1 = null;
        ResultSet rs1 = null;
        try {
            //System.out.println("getEmpCode="+code);
            stmt1 = conn.createStatement();
            if (code != null && !code.equals("null")) {
                rs1 = stmt1
                        .executeQuery("SELECT EMPLOYEE_NAME  FROM rws_EMPLOYEE_tbl WHERE EMPLOYEE_CODE  ='"
                                + code + "'");
                rs1.next();
                name = rs1.getString(1);
            } else {
                name = "";
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            stmt1.close();
        }
        //System.out.println("name="+name);
        return name;
    }

    public static String getTestName(String code, Connection conn)
            throws Exception {
        String name = null;
        Statement stmt1 = null;
        ResultSet rs1 = null;
        try {
            //System.out.println("getTestName="+code);
            stmt1 = conn.createStatement();

            rs1 = stmt1
                    .executeQuery("SELECT TEST_NAME  FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE  ='"
                            + code + "'");
            rs1.next();
            name = rs1.getString(1);

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            stmt1.close();
        }
        return name;
    }

    public static String getLabName(String code, Connection conn)
            throws Exception {
        String name = null;
        Statement stmt1 = null;
        ResultSet rs1 = null;
        try {
            //System.out.println("getLabName="+code);
            stmt1 = conn.createStatement();

            rs1 = stmt1
                    .executeQuery("SELECT LAB_NAME  FROM RWS_WATER_QUALITY_LAB_TBL WHERE LAB_CODE  ='"
                            + code + "'");
            rs1.next();
            name = rs1.getString(1);

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            stmt1.close();
        }
        return name;
    }

    // code added by sridhar for quality tests by mandal wise
    public static ArrayList getWQLabTests(DataSource dataSource, String circle,
            String division, String subdivision, String mandal)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        ArrayList watersamples = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            /*
			 * String query="SELECT WS.TEST_ID,T.TEST_CODE,T.TEST_NAME,
			 * WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/MM/YYYY')prepared_on, " + "
			 * TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/MM/YYYY')SAMP_COLLECT_DATE,WS.SOURCE_CODE,L.LAB_CODE," + "
			 * L.LOCATION,WS.TEST_ID FROM RWS_WATER_SAMPLE_COLLECT_TBL
			 * WS,RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D," + "
			 * RWS_WATER_QUALITY_LAB_TBL L WHERE WS.TEST_CODE=T.TEST_CODE AND " + "
			 * WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND
			 * WS.LAB_CODE=L.LAB_CODE AND " + " ws.TEST_ID NOT IN (SELECT
			 * TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL) and " ;
             */
            String query = "SELECT WS.TEST_ID,T.TEST_CODE,T.TEST_NAME, WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/MM/YYYY')prepared_on, "
                    + " TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/MM/YYYY')SAMP_COLLECT_DATE,WS.SOURCE_CODE,L.LAB_CODE,"
                    + " L.LOCATION,WS.TEST_ID,v.panch_name FROM RWS_WATER_SAMPLE_COLLECT_TBL WS,RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D, RWS_WATER_QUALITY_LAB_TBL L,rws_complete_hab_view v WHERE WS.TEST_CODE=T.TEST_CODE AND WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND WS.LAB_CODE=L.LAB_CODE AND ws.hab_code=v.panch_code(+) and ws.TEST_ID NOT IN (SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL) and ";

            if (circle != null && !circle.equals("")) {
                query += " ws.circle_office_code='" + circle + "'  ";
            }
            if (division != null && !division.equals("")) {
                query += " and ws.division_office_code='" + division + "'  ";
            }
            if (subdivision != null && !subdivision.equals("")) {
                query += " and ws.subdivision_office_code='" + subdivision
                        + "'  ";
            }
            if (mandal != null && !mandal.equals("")) {
                query += " and substr(source_code,6,2) ='" + mandal + "'";
            }
            query += " order by v.panch_name,WS.SAMP_COLLECT_DATE asc ";
            //Debug.println("query ismmmmmmmmmmmmmm " + query);

            rs = stmt.executeQuery(query);

            while (rs.next()) {
                //count++;
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
                rwsWQuality.setTestName(rs.getString("TEST_NAME"));
                rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
                ////Debug.println("connection of quality:"+conn);
                //rwsWQuality.setHabName(rwsLocations.getHabName(rs.getString("HAB_CODE"),conn));
                rwsWQuality.setHabName(rs.getString("panch_name"));
                ////Debug.println("0.1");
                rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
                rwsWQuality.setSampCollectDate(rs
                        .getString("SAMP_COLLECT_DATE"));
                rwsWQuality.setAssignedOn(rs.getString("PREPARED_ON"));
                ////Debug.println("1");
                rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                rwsWQuality.setSourceName(rs.getString("SOURCE_CODE"));
                rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
                ////Debug.println("2");
                rwsWQuality.setLabName(rs.getString("LOCATION"));
                rwsWQuality.setTestId(rs.getString("TEST_ID"));
                ////Debug.println("3");
                watersamples.add(rwsWQuality);
            }

            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
        return watersamples;
    }

    public static ArrayList getWQLabTests1(DataSource dataSource,
            String circle, String division, String subdivision, String mandal)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        ArrayList watersamples = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            //Debug.println("subdivision:"+subdivision);
            String query = "";

            //Debug.println("in else");
            query = "SELECT WS.TEST_ID,T.TEST_CODE,T.TEST_NAME, WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/MM/YYYY')prepared_on, "
                    + " TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/MM/YYYY')SAMP_COLLECT_DATE,WS.SOURCE_CODE,L.LAB_CODE,"
                    + " L.LOCATION,WS.TEST_ID FROM RWS_WATER_SAMPLE_COLLECT_TBL WS,RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D,"
                    + " RWS_WATER_QUALITY_LAB_TBL L WHERE WS.TEST_CODE=T.TEST_CODE  AND "
                    + " WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND WS.LAB_CODE=L.LAB_CODE AND"
                    + " ws.circle_office_code='"
                    + circle
                    + "' and  ws.division_office_code='"
                    + division
                    + "' and ws.subdivision_office_code='"
                    + subdivision
                    + "' and substr(source_code,6,2) ='"
                    + mandal
                    + "' order by WS.SAMP_COLLECT_DATE DESC";

            //Debug.println("query is "+query);
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                //count++;
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
                rwsWQuality.setTestName(rs.getString("TEST_NAME"));
                rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
                ////Debug.println("0");
                rwsWQuality.setHabName(rwsLocations.getHabName(rs
                        .getString("HAB_CODE"), conn));
                ////Debug.println("0.1");
                rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
                rwsWQuality.setSampCollectDate(rs
                        .getString("SAMP_COLLECT_DATE"));
                rwsWQuality.setAssignedOn(rs.getString("PREPARED_ON"));
                ////Debug.println("1");
                rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                rwsWQuality.setSourceName(rs.getString("SOURCE_CODE"));
                rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
                ////Debug.println("2");
                rwsWQuality.setLabName(rs.getString("LOCATION"));
                rwsWQuality.setTestId(rs.getString("TEST_ID"));
                ////Debug.println("3");
                watersamples.add(rwsWQuality);
            }

            rs.close();
            stmt.close();
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return watersamples;
    }

    //code end
    public static ArrayList getWQLabTest(DataSource dataSource, String empcode,
            String testcode) throws Exception {
        RwsWQuality rwsWQuality = null;
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        ArrayList watersamples = new ArrayList();
        ArrayList watersamples1 = new ArrayList();
        int i = 0;
        try {
            //System.out.println("getWQLabTest");
            //System.out.println("empcode in getWQLabTest
            // is===="+empcode+"testcode="+testcode);
            if (empcode != null) {
                conn = RwsOffices.getConn();
                stmt = conn.createStatement();
                /*
				 * String query="SELECT T.TEST_CODE,T.TEST_NAME," +
				 * "WS.HAB_CODE,D.DESIGNATION_ACR," +
				 * "TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy')SAMP_COLLECT_DATE," +
				 * "TO_CHAR(G.ASSIGNED_TO_DATE,'dd/mm/yyyy')ASSIGNED_TO_DATE," +
				 * "S.SOURCE_CODE,S.SOURCE_NAME," +
				 * "L.LAB_CODE,L.LOCATION,G.TEST_ID " + "FROM
				 * RWS_WQ_GEOLOGIST_TEST_TBL G," + "RWS_WATER_SAMPLE_COLLECT_TBL
				 * WS," + "RWS_SOURCE_TBL S,RWS_WATER_QUALITY_TEST_TBL T," +
				 * "RWS_DESIGNATION_TBL D,RWS_WATER_QUALITY_LAB_TBL L" + " WHERE
				 * G.TEST_ID=WS.TEST_ID AND " + "WS.SOURCE_CODE=S.SOURCE_CODE
				 * AND " + "WS.TEST_CODE=T.TEST_CODE AND " +
				 * "G.LAB_CODE=L.LAB_CODE AND " +
				 * "WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE " + "AND G.TEST_ID
				 * NOT IN " + "(SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL
				 * where test_code='"+testcode+"') AND " +
				 * "G.ASSIGNED_TO='"+empcode+"' and G.TEST_ID='"+testcode+"'";
                 */

                String query = "SELECT T.TEST_CODE,T.TEST_NAME,"
                        + "WS.HAB_CODE,D.DESIGNATION_ACR,"
                        + "TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy')SAMP_COLLECT_DATE,"
                        + ""
                        + "S.SOURCE_CODE,S.SOURCE_NAME,"
                        + "L.LAB_CODE,L.LOCATION,WS.TEST_ID "
                        + "FROM "
                        + "RWS_WATER_SAMPLE_COLLECT_TBL WS,"
                        + "RWS_SOURCE_TBL S,RWS_WATER_QUALITY_TEST_TBL T,"
                        + "RWS_DESIGNATION_TBL D,RWS_WATER_QUALITY_LAB_TBL L"
                        + " WHERE  "
                        + "WS.SOURCE_CODE=S.SOURCE_CODE AND "
                        + "WS.TEST_CODE=T.TEST_CODE AND "
                        + "WS.LAB_CODE=L.LAB_CODE AND "
                        + "WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE "
                        + "AND WS.TEST_ID NOT IN "
                        + "(SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL where  test_code='"
                        + testcode + "')  " + " and WS.TEST_ID='" + testcode
                        + "'";
                String qq = "select ws.test_id,t.test_code,t.test_name,ws.hab_code,ws.samp_collector_code,ws.source_code,TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy') as SAMP_COLLECT_DATE,ws.lab_code,l.lab_name,d.designation_acr from rws_water_sample_collect_tbl ws,RWS_WATER_QUALITY_LAB_TBL l,RWS_WATER_QUALITY_TEST_TBL t,RWS_DESIGNATION_TBL d where l.lab_code=ws.lab_code and WS.TEST_CODE=T.TEST_CODE and WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE and ws.test_id="
                        + testcode;
                //System.out.println("qq is::"+qq);

                //		System.out.println("query is:: "+query);
                rs = stmt.executeQuery(qq);
                while (rs.next()) {
                    watersamples1.add(0, rs.getString("TEST_CODE"));
                    watersamples1.add(1, rs.getString("TEST_NAME"));
                    watersamples1.add(2, rs.getString("HAB_CODE"));
                    watersamples1.add(3, rwsLocations.getHabName(rs
                            .getString("HAB_CODE"), conn));
                    watersamples1.add(4, rs.getString("DESIGNATION_ACR"));
                    watersamples1.add(5, rs.getString("SAMP_COLLECT_DATE"));
                    watersamples1.add(6, rs.getString("SOURCE_CODE"));
                    watersamples1.add(7, rs.getString("LAB_CODE"));
                    watersamples1.add(8, rs.getString("LAB_NAME"));
                    watersamples1.add(9, rs.getString("TEST_ID"));
                    rwsWQuality = new RwsWQuality();
                    //System.out.println("Test
                    // Code::"+rs.getString("TEST_CODE"));
                    rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
                    rwsWQuality.setTestName(rs.getString("TEST_NAME"));
                    rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
                    rwsWQuality.setHabName(rwsLocations.getHabName(rs
                            .getString("HAB_CODE"), conn));
                    rwsWQuality.setSampCollectCode(rs
                            .getString("DESIGNATION_ACR"));
                    rwsWQuality.setSampCollectDate(rs
                            .getString("SAMP_COLLECT_DATE"));
                    //rwsWQuality.setAssignedOn(rs.getString("ASSIGNED_TO_DATE"));
                    rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
                    //rwsWQuality.setSourceName(rs.getString("SOURCE_NAME"));
                    rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
                    rwsWQuality.setLabName(rs.getString("LAB_NAME"));
                    rwsWQuality.setTestId(rs.getString("TEST_ID"));
                    //System.out.println("HabName::"+rwsWQuality.getHabName());
                    //System.out.println("labcode="+rs.getString("LAB_CODE")+"labName="+rs.getString("LOCATION")+"test
                    // name="+rs.getString("TEST_NAME")+"testcode="+rs.getString("TEST_CODE"));

                    watersamples.add(rwsWQuality);
                }
                //	System.out.println("watersample size:"+watersamples.size());
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }

        //return watersamples;
        return watersamples1;
    }

    public static String getftkTestId(String sourceCode, DataSource dataSource) throws Exception {
        String name = null;
        PreparedStatement stmt1 = null;
        ResultSet rs1 = null;
        String ftktestid = "";
       try {
            conn = RwsOffices.getConn();            
            synchronized (sourceCode) {
            	stmt1 = conn.prepareStatement("SELECT MAX(FTK_TEST_ID) FROM RWS_FTK_TESTING_TBL");
                rs1 = stmt1.executeQuery();
                if (rs1.next()) {
                    if (rs1.getInt(1) < 9) {
                        name = "000000000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 99) {
                        name = "00000000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 999) {
                        name = "0000000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 9999) {
                        name = "000000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 99999) {
                        name = "00000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 999999) {
                        name = "0000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 9999999) {
                        name = "000" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 99999999) {
                        name = "00" + (rs1.getInt(1) + 1);
                    } else if (rs1.getInt(1) < 999999999) {
                        name = "0" + (rs1.getInt(1) + 1);
                    } else {
                        name = String.valueOf(rs1.getInt(1) + 1);
                    }
                } else {
                    name = "0000000001";
                }
            }
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getftkTestId = "+e.getMessage());
        } finally {
            stmt1.close();
            conn.close();
        }
        return name;
    }

    public static String getTestId(String test, String labCode, String yr,
            Connection conn) throws Exception {
        String name = null;
        Statement stmt1 = null;
        ResultSet rs1 = null;
        try {
            //System.out.println(" year="+yr);
            stmt1 = conn.createStatement();
            if (test.equals("sample")) {

                rs1 = stmt1
                        .executeQuery("select max(substr(test_id,4,2)),max(to_number(substr(test_id,6,5))) from rws_water_sample_collect_tbl where substr(test_id,1,3)='"
                                + labCode + "'");
            } else if (test.equals("test")) {
                rs1 = stmt1
                        .executeQuery("select max(substr(test_id,4,2)),max(to_number(substr(test_id,6,5))) from RWS_WQ_TEST_RESULTS_TBL where substr(test_id,1,3)='"
                                + labCode + "'");
            }
            rs1.next();
            if (rs1.getString(1) != null) {
                if (rs1.getString(1).equals(yr)) {
                    if (rs1.getInt(2) < 9) {
                        name = "0000" + (rs1.getInt(2) + 1);
                    } else if (rs1.getInt(2) < 99) {
                        name = "000" + (rs1.getInt(2) + 1);
                    } else if (rs1.getInt(2) < 999) {
                        name = "00" + (rs1.getInt(2) + 1);
                    } else if (rs1.getInt(2) < 9999) {
                        name = "0" + (rs1.getInt(2) + 1);
                    } else if (rs1.getInt(2) < 99999) {
                        name = String.valueOf(rs1.getInt(2) + 1);
                    }
                } else {
                    name = "00001";
                }
            } else {
                name = "00001";
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            stmt1.close();
        }
        //System.out.println("labCode+yr+name="+labCode+yr+name);
        return (labCode + yr + name);
    }

    public static ArrayList getWorkIds(String coc, String doc, String status,
            DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList workIds = new ArrayList();
        String query;
        try {
            if (coc != null && doc != null) {
                conn = RwsOffices.getConn();
                stmt = conn.createStatement();

                if (status.equalsIgnoreCase("none")) {
                    //code changed on 050407
                    /*
					 * query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM
					 * RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" + "
					 * WHERE FIN.CIRCLE_OFFICE_CODE='"+coc+"' AND" + "
					 * FIN.DIVISION_OFFICE_CODE='"+doc+"' AND FIN.FINALISED='Y'" + "
					 * AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";
                     */

 /*
					 * query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM
					 * RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" + "
					 * WHERE substr(fin.office_code,2,2)='"+coc+"' and
					 * substr(fin.office_code,4,1)='"+doc+"'AND FIN.FINALISED is
					 * null" + " AND FIN.WORK_ID=P.WORK_ID ORDER BY
					 * FIN.WORK_ID";
                     */
                    query = "SELECT FIN.WORK_ID,P.PROPOSAL_NAME  FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P"
                            + " WHERE  substr(P.office_code,2,2)='"
                            + coc
                            + "' and substr(P.office_code,4,1)='"
                            + doc
                            + "' "
                            + " AND FIN.FINALISED is null"
                            + " AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";

                    //System.out.println("query is "+query);
                    rs = stmt.executeQuery(query);
                } else if (status.equalsIgnoreCase("status")) {
                    //code changed on 050407
                    /*
					 * query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM
					 * RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" + "
					 * WHERE FIN.CIRCLE_OFFICE_CODE='"+coc+"' AND" + "
					 * FIN.DIVISION_OFFICE_CODE='"+doc+"' AND FIN.FINALISED='Y'" + "
					 * AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";
                     */

                    query = "SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P"
                            + " WHERE substr(fin.office_code,2,2)='"
                            + coc
                            + "' and substr(fin.office_code,4,1)='"
                            + doc
                            + "' AND FIN.FINALISED='Y'"
                            + " AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";
                    //System.out.println("query is "+query);
                    rs = stmt.executeQuery(query);
                }
                while (rs.next()) {
                    rwsWQuality = new RwsWQuality();

                    rwsWQuality.setWorkCode(rs.getString(1));
                    rwsWQuality.setCodeName(rs.getString(2) + " - "
                            + rs.getString(1));
                    //rwsWQuality.setAssetName(rs.getString(2));

                    workIds.add(rwsWQuality);
                }
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return workIds;
    }

    public static ArrayList getTestParameterCodes(DataSource dataSource,
            String testId, String testCode) throws Exception {
        RwsWQuality rwsWQuality = null;
        //ResultSet rss = null;
        ArrayList parameters = new ArrayList();
        //System.out.println("The testCode is-----------------"+testCode);
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            Statement stmt1 = conn.createStatement();
            Statement stmts = conn.createStatement();
            ResultSet rs1 = null;

            /*
			 * String query="SELECT TEST_NAME,TESTING_PARAMETER_CODE," +
			 * "TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE," +
			 * "MAX_PERMISSIBLE_VALUE,UNDESIRE_EFFECT, P.TEST_CODE FROM
			 * RWS_WQ_PARA_TEST_TBL P," + "RWS_WATER_QUALITY_TEST_TBL T " +
			 * "WHERE T.TEST_CODE=P.TEST_CODE AND " + "P.TEST_CODE IN (SELECT
			 * TEST_CODE FROM " + "RWS_WATER_QUALITY_TEST_TBL WHERE
			 * TEST_CODE='"+testCode+"') order by testing_parameter_code";
             */
            String query = "SELECT distinct T.TEST_NAME,p.TESTING_PARAMETER_CODE ,P.TESTING_PARAMETER_NAME, nvl(P.MIN_PERMISSIBLE_VALUE,'-'), nvl(P.MAX_PERMISSIBLE_VALUE,'- '),nvl(P.UNDESIRE_EFFECT,'--') FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.test_code='"
                    + testCode
                    + "' and p.test_code=t.test_code order by p.TESTING_PARAMETER_CODE ";

            // //Debug.println("query is in gettestparameterCodes:"+query);
            ////Debug.println("testId:"+testId);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestId(testId);
                rwsWQuality.setTestName(rs.getString(1));
                rwsWQuality.setTestPCode(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setUndesirableEffect(rs.getString(6));
                String qry1 = "SELECT testing_parameter_value  from RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID = '"
                        + testId
                        + "' and testing_parameter_code='"
                        + rs.getString(2) + "' ";
                ////Debug.println(qry1);
                rs1 = stmts.executeQuery(qry1);
                if (rs1.next()) {
                    rwsWQuality.setResult(rs1.getString(1));
                } else {
                    rwsWQuality.setResult("");
                }
                parameters.add(rwsWQuality);
            }
            /*
			 * int i= 0; while(rs.next())i++; //System.out.println("RS
			 * Size::"+i); rs.close();
			 * 
			 * rs = stmts.executeQuery(query); while(rs.next()) { rwsWQuality =
			 * new RwsWQuality();
			 * 
			 * rwsWQuality.setTestId(testId);
			 * rwsWQuality.setTestName(rs.getString(1));
			 * rwsWQuality.setTestPCode(rs.getString(2));
			 * rwsWQuality.setTestPName(rs.getString(3));
			 * rwsWQuality.setMinPerVal(rs.getString(4));
			 * rwsWQuality.setMaxPerVal(rs.getString(5));
			 * rwsWQuality.setUndesirableEffect(rs.getString(6));
			 * rwsWQuality.setResult(rs.getString(7)); String q = "select
			 * TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_LNK_TBL where
			 * TEST_ID='"+testId+"' and
			 * TESTING_PARAMETER_CODE='"+rs.getString(2)+"'";
			 * ////System.out.println("q is::"+q); rss = stmt.executeQuery(q);
			 * if(rss.next()) rwsWQuality.setResult(rss.getString(1)); else
			 * rwsWQuality.setResult(""); parameters.add(rwsWQuality);
			 *  }
             */

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }

    // added by sridhar for selected parameters list
    public ArrayList getSelectedParameters(String testCode, String testId)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        try {
            conn = RwsOffices.getConn();

            stmt = conn.createStatement();
            String query = "SELECT distinct p.TESTING_PARAMETER_CODE,r.testing_parameter_value FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T ,RWS_QUALITY_RESULTS_TMP_TBL r WHERE T.test_code='"
                    + testCode
                    + "' and p.TESTING_PARAMETER_CODE(+)=r.TESTING_PARAMETER_CODE and r.test_id='"
                    + testId + "' order by p.TESTING_PARAMETER_CODE ";
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestId(testId);
                rwsWQuality.setTestPCode(rs.getString(1));
                rwsWQuality.setResult(rs.getString(2));
                parameters.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }

    public static ArrayList getTestParameterCodes(String testCode, String testId)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        //ResultSet rss = null;
        ArrayList parameters = new ArrayList();
        //System.out.println("The testCode is-----------------"+testCode);
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "SELECT distinct T.TEST_NAME,p.TESTING_PARAMETER_CODE ,P.TESTING_PARAMETER_NAME, nvl(P.MIN_PERMISSIBLE_VALUE,'-'), nvl(P.MAX_PERMISSIBLE_VALUE,'- '),nvl(P.UNDESIRE_EFFECT,'--') FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.test_code='"
                    + testCode
                    + "' and p.test_code=t.test_code order by p.TESTING_PARAMETER_CODE ";
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestId(testId);
                rwsWQuality.setTestName(rs.getString(1));
                rwsWQuality.setTestPCode(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setUndesirableEffect(rs.getString(6));
                rwsWQuality.setResult("");
                parameters.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }
   
    public static ArrayList getWQTestParameterCodes(DataSource dataSource, String testCode, String testId) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        PreparedStatement stmt1 = null;
        ResultSet rs1 = null;
        try {
            conn = RwsOffices.getConn();
            String qry = "SELECT T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT,RL.TESTING_PARAMETER_VALUE,rl.test_id FROM RWS_WQ_PARA_TEST_TBL P,"
                    + "RWS_WATER_QUALITY_TEST_TBL T,RWS_WQ_TEST_RESULTS_LNK_TBL RL,RWS_WQ_TEST_RESULTS_TBL WQ WHERE RL.TEST_ID=WQ.TEST_ID"
                    + " AND T.TEST_CODE=WQ.TEST_CODE AND T.TEST_CODE=P.TEST_CODE AND P.TEST_CODE IN (SELECT TEST_CODE FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE= ?)"
                    + " AND P.TEST_CODE=WQ.TEST_CODE and P.TESTING_PARAMETER_CODE=RL.TESTING_PARAMETER_CODE AND WQ.TEST_ID='"
                    + testId + "'";
            qry = "SELECT  TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT  FROM RWS_WQ_PARA_TEST_TBL P where p.TEST_CODE= ?";
            ps = conn.prepareStatement(qry);
            ps.setString(1, testCode);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setTestPCode(rs.getString(1));
                String qry1 = "select distinct a.test_id,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_TBL b where a.test_id=b.test_id and a.test_id= ? and TESTING_PARAMETER_CODE= ?";
                stmt1 = conn.prepareStatement(qry1);
                stmt1.setString(1, testId);
                stmt1.setString(2, rs.getString(1));
                rs1 = stmt1.executeQuery();
                if (rs1.next()) {
                    rwsWQuality.setResult(rs1.getString(3));
                } else {
                    rwsWQuality.setResult("");
                }
                rwsWQuality.setTestPName(rs.getString(2));
                rwsWQuality.setMinPerVal(rs.getString(3));
                rwsWQuality.setMaxPerVal(rs.getString(4));
                rwsWQuality.setUndesirableEffect(rs.getString(5));
                parameters.add(rwsWQuality);
            }

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getWQTestParameterCodes = "+e.getMessage());
        } finally {
            closeAll();
        }
        return parameters;
    }

    public static ArrayList getWQTestParameterCodes13(DataSource dataSource, String testCode, String testId) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        PreparedStatement stmt1 = null;
        ResultSet rs1 = null;
        try {
            conn = RwsOffices.getConn();
            String qry = "SELECT T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT,RL.TESTING_PARAMETER_VALUE,rl.test_id FROM RWS_WQ_PARA_TEST_TBL P,"
                    + "RWS_WATER_QUALITY_TEST_TBL T,RWS_WQ_TEST_RESULTS_LNK_TBL RL,RWS_WQ_TEST_RESULTS_TBL WQ WHERE RL.TEST_ID=WQ.TEST_ID"
                    + " AND T.TEST_CODE=WQ.TEST_CODE AND T.TEST_CODE=P.TEST_CODE AND P.TEST_CODE IN (SELECT TEST_CODE FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE= ?)"
                    + " AND P.TEST_CODE=WQ.TEST_CODE and P.TESTING_PARAMETER_CODE=RL.TESTING_PARAMETER_CODE AND WQ.TEST_ID='"
                    + testId + "'";
            qry = "SELECT  TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT  FROM RWS_WQ_PARA_TEST_TBL P where TESTING_PARAMETER_CODE in('01','02','04','05','06','07','10','11','12','13','14','15','16') and p.TEST_CODE= ? order by TESTING_PARAMETER_CODE";
            ps = conn.prepareStatement(qry);
            ps.setString(1, testCode);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setTestPCode(rs.getString(1));
                String qry1 = "select distinct a.test_id,TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_TBL b where a.test_id=b.test_id and a.test_id = ? and TESTING_PARAMETER_CODE = ?";
                stmt1 = conn.prepareStatement(qry1);
                stmt1.setString(1, testId);
                stmt1.setString(2, rs.getString(1));
                rs1 = stmt1.executeQuery();
                if (rs1.next()) {
                    rwsWQuality.setResult(rs1.getString(3));
                } else {
                    rwsWQuality.setResult("");
                }
                rwsWQuality.setTestPName(rs.getString(2));
                rwsWQuality.setMinPerVal(rs.getString(3));
                rwsWQuality.setMaxPerVal(rs.getString(4));
                rwsWQuality.setUndesirableEffect(rs.getString(5));
                parameters.add(rwsWQuality);
            }

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getWQTestParameterCodes13 = "+e.getMessage());
        } finally {
            closeAll();
        }
        java.util.Collections.swap(parameters, 4, 5);
        java.util.Collections.swap(parameters, 10, 11);
        return parameters;
    }

    public static ArrayList getUpdatTestPCodes(DataSource dataSource, String testCode) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME,"
                    + "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,"
                    + "RL.TESTING_PARAMETER_VALUE "
                    + "FROM RWS_WQ_PARA_TEST_TBL P,"
                    + "RWS_WQ_TEST_RESULTS_LNK_TBL RL,"
                    + "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE "
                    + "P.TEST_CODE in "
                    + "(select test_code from RWS_WATER_QUALITY_TEST_TBL "
                    + "where test_code='"
                    + testCode
                    + "') and "
                    + "months_between(sysdate,FORWARDED_ON)<=36 and "
                    + "R.update_source_data='Y' "
                    + "AND RL.TEST_ID=R.TEST_ID AND "
                    + "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE "
                    + "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE=R.TEST_CODE";
            rs = stmt.executeQuery(query);
            //System.out.println("query is "+query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
                rwsWQuality.setTestName(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setResult(rs.getString(6));

                parameters.add(rwsWQuality);

            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }

    public static ArrayList getWQUpdatTestPCodes(DataSource dataSource,
            String testCode, String testId, String source) throws Exception {
        RwsWQuality rwsWQuality = null;
        RwsWQuality rwsWQuality1 = null;
        ArrayList parameters = new ArrayList();
        ArrayList parametersnew = new ArrayList();
        //System.out.println("The testCode
        // is-----------------"+testCode+"testId Is---"+testId);
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            /*
			 * String qq = "SELECT distinct
			 * r.test_id,R.PREPARED_ON,WQ.TEST_NAME,decode(r.potable,'Y','YES','N','NO'),r.recommendations "+
			 * "FROM RWS_WQ_PARA_TEST_TBL P," + "RWS_WQ_TEST_RESULTS_LNK_TBL
			 * RL," + "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ
			 * WHERE " + "P.TEST_CODE in " + "(select test_code from
			 * RWS_WATER_QUALITY_TEST_TBL " + ") and " +
			 * "months_between(sysdate,FORWARDED_ON) <=36 and " +
			 * "R.update_source_data='Y' " + "AND RL.TEST_ID=R.TEST_ID AND " +
			 * "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " + "AND
			 * P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND
			 * R.TEST_ID <> '"+testId+"' AND R.SOURCE_CODE='"+source+"'"; //
			 * System.out.println("query new::"+qq); int i = 0; ResultSet rs1 =
			 * stmt.executeQuery(qq); while(rs1.next()) { rwsWQuality1 = new
			 * RwsWQuality(); rwsWQuality1.setTestId(rs1.getString(1));
			 * rwsWQuality1.setPreparedOn(df.format(rs1.getDate(2)));
			 * rwsWQuality1.setTestName(rs1.getString(3));
			 * rwsWQuality1.setCondemnSource(rs1.getString(4));
			 * rwsWQuality1.setRecommendations(rs1.getString(5));
			 * 
			 * parametersnew.add(rwsWQuality1); }
             */
            String query = "SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME,"
                    + "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,"
                    + "RL.TESTING_PARAMETER_VALUE "
                    + "FROM RWS_WQ_PARA_TEST_TBL P,"
                    + "RWS_WQ_TEST_RESULTS_LNK_TBL RL,"
                    + "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE "
                    + "P.TEST_CODE in "
                    + "(select test_code from RWS_WATER_QUALITY_TEST_TBL "
                    + "where test_code='"
                    + testCode
                    + "') and "
                    + "months_between(sysdate,FORWARDED_ON)<=36 and "
                    + "R.update_source_data='Y' "
                    + "AND RL.TEST_ID=R.TEST_ID AND "
                    + "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE "
                    + "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND R.TEST_ID <> '"
                    + testId + "' AND R.SOURCE_CODE='" + source + "'";
            //System.out.println("query in getWQUpdatTestPCodes "+query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
                rwsWQuality.setTestName(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setResult(rs.getString(6));

                parameters.add(rwsWQuality);

            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parametersnew;
    }

    public static ArrayList getWQUpdatTestPCodes1(DataSource dataSource,
            String testId, String testCode) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            Statement stmts = conn.createStatement();
            ResultSet rs1 = null;
            //Debug.println("in wqptest code .....");
            /*
			 * String qry = "SELECT
			 * T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT,RL.TESTING_PARAMETER_VALUE,rl.test_id
			 * FROM RWS_WQ_PARA_TEST_TBL P," + "RWS_WATER_QUALITY_TEST_TBL
			 * T,RWS_WQ_TEST_RESULTS_LNK_TBL RL,RWS_WQ_TEST_RESULTS_TBL WQ WHERE
			 * WQ.TEST_ID=RL.TEST_ID(+)" + " AND T.TEST_CODE=WQ.TEST_CODE AND
			 * T.TEST_CODE=P.TEST_CODE AND P.TEST_CODE IN (SELECT TEST_CODE FROM
			 * RWS_WATER_QUALITY_TEST_TBL )"+ " AND P.TEST_CODE=WQ.TEST_CODE and
			 * P.TESTING_PARAMETER_CODE=RL.TESTING_PARAMETER_CODE AND
			 * WQ.TEST_ID='"+testId+"'"; //Debug.println("query in
			 * getWQTestParameterCodes:"+qry); rs=stmt.executeQuery(qry);
			 * 
			 * while(rs.next()) { rwsWQuality = new RwsWQuality();
			 * rwsWQuality.setTestId(rs.getString(8));
			 * rwsWQuality.setTestName(rs.getString(1));
			 * rwsWQuality.setTestPCode(rs.getString(2));
			 * rwsWQuality.setTestPName(rs.getString(3));
			 * rwsWQuality.setMinPerVal(rs.getString(4));
			 * rwsWQuality.setMaxPerVal(rs.getString(5));
			 * rwsWQuality.setUndesirableEffect(rs.getString(6));
			 * rwsWQuality.setResult(rs.getString(7));
			 * parameters.add(rwsWQuality);
			 *  }
             */
            String query = "SELECT distinct T.TEST_NAME,p.TESTING_PARAMETER_CODE ,P.TESTING_PARAMETER_NAME, nvl(P.MIN_PERMISSIBLE_VALUE,'-'), nvl(P.MAX_PERMISSIBLE_VALUE,'- '),nvl(P.UNDESIRE_EFFECT,'--') FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.test_code='"
                    + testCode
                    + "' and p.test_code=t.test_code order by p.TESTING_PARAMETER_CODE ";

            //Debug.println("query is in gettestparameterCodes:"+query);
            //Debug.println("testId:"+testId);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestId(testId);
                rwsWQuality.setTestName(rs.getString(1));
                rwsWQuality.setTestPCode(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setUndesirableEffect(rs.getString(6));
                String qry1 = "SELECT testing_parameter_value  from RWS_WQ_TEST_RESULTS_LNK_TBL WHERE TEST_ID = '"
                        + testId
                        + "' and testing_parameter_code='"
                        + rs.getString(2) + "' ";
                //Debug.println(qry1);
                rs1 = stmts.executeQuery(qry1);
                if (rs1.next()) {
                    rwsWQuality.setResult(rs1.getString(1));
                } else {
                    rwsWQuality.setResult("");
                }
                parameters.add(rwsWQuality);
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }

    public static ArrayList getWQUpdatTestParameterCodes(DataSource dataSource,
            String testCode, String testId, String sourceCode) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList parameters = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME,"
                    + "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,"
                    + "RL.TESTING_PARAMETER_VALUE,RL.TEST_ID "
                    + "FROM RWS_WQ_PARA_TEST_TBL P,"
                    + "RWS_WQ_TEST_RESULTS_LNK_TBL RL,"
                    + "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE "
                    + "P.TEST_CODE in "
                    + "(select test_code from RWS_WATER_QUALITY_TEST_TBL "
                    + "where test_code='"
                    + testCode
                    + "') and "
                    + "months_between(sysdate,FORWARDED_ON)<=36 and "
                    + "R.update_source_data='Y' "
                    + "AND RL.TEST_ID=R.TEST_ID AND "
                    + "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE "
                    + "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE=R.TEST_CODE AND R.SOURCE_CODE='"
                    + sourceCode + "'" + "and rl.test_id='" + testId + "'";
            //	System.out.println("query is "+query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
                rwsWQuality.setTestName(rs.getString(2));
                rwsWQuality.setTestPName(rs.getString(3));
                rwsWQuality.setMinPerVal(rs.getString(4));
                rwsWQuality.setMaxPerVal(rs.getString(5));
                rwsWQuality.setResult(rs.getString(6));
                rwsWQuality.setTestId(rs.getString(7));

                parameters.add(rwsWQuality);

            }

        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return parameters;
    }

    //**************************Water sample source finalisation and
    // identification methods***********
    public static int insertWQSourceFinIden(RwsWQuality rwsWQuality,
            DataSource dataSource) throws Exception {
        int rowCount = 0;
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        //System.out.println("worid="+rwsWQuality.getWorkCode()+"
        // coc="+rwsWQuality.getCoc()+" doc="+rwsWQuality.getDoc());
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            //code modified on 050407
            /*
			 * String query="UPDATE RWS_SOURCE_IDEN_FIN_TBL SET " +
			 * "SUBDIVISION_OFFICE_CODE='"+rwsWQuality.getSdoc()+
			 * "',HAB_CODE='"+rwsWQuality.getHabCode()+
			 * "',SOURCE_CODE="+rwsWQuality.getSourceCode()+
			 * ",PROGRAMME_CODE='"+rwsWQuality.getPrgmCode()+
			 * "',SUBPROGRAMME_CODE='"+rwsWQuality.getSubprgmCode()+
			 * "',CASING='"+rwsWQuality.getCasing()+
			 * "',DEPTH='"+rwsWQuality.getDepth()+
			 * "',EXPECTED_YIELD='"+rwsWQuality.getYield()+
			 * "',SOURCE1='"+rwsWQuality.getSource1()+
			 * "',DEPTH1='"+rwsWQuality.getDepth1()+
			 * "',YIELD1='"+rwsWQuality.getYield1()+
			 * "',SOURCE2='"+rwsWQuality.getSource2()+
			 * "',DEPTH2='"+rwsWQuality.getDepth2()+
			 * "',YIELD2='"+rwsWQuality.getYield2()+
			 * "',SOURCE3='"+rwsWQuality.getSource3()+
			 * "',DEPTH3='"+rwsWQuality.getDepth3()+
			 * "',YIELD3='"+rwsWQuality.getYield3()+
			 * "',EMPLOYEE_CODE='"+rwsWQuality.getEmpcode()+
			 * "',SITE_IDENT_DATE=TO_DATE('"+rwsWQuality.getSiteIdenData()+
			 * "','dd/MM/yyyy'),FINALISED ='"+rwsWQuality.getFinalised()+
			 * "',FINALISE_DATE=TO_DATE('"+rwsWQuality.getFinalDate()+
			 * "','dd/MM/yyyy'),REMARKS='"+rwsWQuality.getRemarks()+
			 * "',PREPARED_BY='"+rwsWQuality.getPreparedBy()+
			 * "',PREPARED_ON=TO_DATE('"+rwsWQuality.getPreparedOn()+
			 * "','dd/MM/yyyy') WHERE WORK_ID='"+rwsWQuality.getWorkCode()+ "'
			 * AND CIRCLE_OFFICE_CODE='"+rwsWQuality.getCoc()+ "' AND
			 * DIVISION_OFFICE_CODE='"+rwsWQuality.getDoc()+"'";
             */
            String query = "UPDATE RWS_SOURCE_IDEN_FIN_TBL SET " + "HAB_CODE='"
                    + rwsWQuality.getHabCode() + "',TYPE_OF_ASSET_CODE='"
                    + rwsWQuality.getAssetTypeCode()
                    + "',ASSET_COMPONENT_CODE='"
                    + rwsWQuality.getCompTypeCode()
                    + "',ASSET_SUBCOMPONENT_CODE='"
                    + rwsWQuality.getSubCompTypeCode() + "',SOURCE_CODE='"
                    + rwsWQuality.getSourceCode() + "',CASING='"
                    + rwsWQuality.getCasing() + "',DEPTH='"
                    + rwsWQuality.getDepth() + "',EXPECTED_YIELD='"
                    + rwsWQuality.getYield() + "',SOURCE1='"
                    + rwsWQuality.getSourceCode1() + "',DEPTH1='"
                    + rwsWQuality.getDepth1() + "',YIELD1='"
                    + rwsWQuality.getYield1() + "',SOURCE2='"
                    + rwsWQuality.getSourceCode2() + "',DEPTH2='"
                    + rwsWQuality.getDepth2() + "',YIELD2='"
                    + rwsWQuality.getYield2() + "',SOURCE3='"
                    + rwsWQuality.getSourceCode3() + "',DEPTH3='"
                    + rwsWQuality.getDepth3() + "',YIELD3='"
                    + rwsWQuality.getYield3() + "',SITE_IDENT_DATE=TO_DATE('"
                    + rwsWQuality.getSiteIdenData()
                    + "','dd/MM/yyyy'),EMPLOYEE_CODE='"
                    + rwsWQuality.getEmpcode() + "',FINALISED ='"
                    + rwsWQuality.getFinalised() + "',FINALISE_DATE=TO_DATE('"
                    + rwsWQuality.getFinalDate() + "','dd/MM/yyyy'),REMARKS='"
                    + rwsWQuality.getRemarks() + "',OFFICE_CODE ='"
                    + rwsWQuality.getOfficeCode() + "',PREPARED_BY='"
                    + rwsWQuality.getPreparedBy() + "',PREPARED_ON=TO_DATE('"
                    + rwsWQuality.getPreparedOn()
                    + "','dd/MM/yyyy') WHERE WORK_ID='"
                    + rwsWQuality.getWorkCode() + "' AND substr(work_id,5,2)='"
                    + rwsWQuality.getCoc() + "'";
            //System.out.println("query is "+query);
            rowCount = stmt.executeUpdate(query);
        } catch (Exception e) {
        	 Debug.println("Exception at getSelectedSources in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static RwsWQuality getWQSourceFinIden(String workCode,
            DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rs = stmt
                    .executeQuery("select FIN.*,P.PROPOSAL_NAME  WORK_NAME from RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P where FIN.WORK_ID='"
                            + workCode + "' and P.WORK_ID='" + workCode + "'");
            if (rs.next()) {
                rwsWQuality = new RwsWQuality();
                //System.out.println("2");
                //rwsWQuality.setCoc(rs.getString(1));
                rwsWQuality.setCoc(rs.getString("office_code").substring(1, 3));
                //rwsWQuality.setDoc(rs.getString(2));
                rwsWQuality.setDoc(rs.getString("office_code").substring(3, 4));

                //rwsWQuality.setSdoc(rs.getString(3));
                rwsWQuality
                        .setSdoc(rs.getString("office_code").substring(4, 6));

                rwsWQuality.setHabCode(rs.getString("hab_code"));

                rwsWQuality
                        .setAssetTypeCode(rs.getString("TYPE_OF_ASSET_CODE"));
                //System.out.println("assetTypeCode in WQualityDAO is
                // "+rs.getString("TYPE_OF_ASSET_CODE"));
                rwsWQuality.setCompTypeCode(rs
                        .getString("ASSET_COMPONENT_CODE"));
                rwsWQuality.setSubCompTypeCode(rs
                        .getString("ASSET_SUBCOMPONENT_CODE"));

                rwsWQuality.setSourceCode(rs.getString("source_code"));
                rwsWQuality
                        .setPrgmCode(rs.getString("work_id").substring(0, 2));
                rwsWQuality.setSubprgmCode(rs.getString("work_id").substring(2,
                        4));
                rwsWQuality.setWorkCode(rs.getString("work_id") + "-"
                        + rs.getString("WORK_NAME"));
                rwsWQuality.setCasing(rs.getString("casing"));
                rwsWQuality.setDepth(rs.getString("depth"));
                rwsWQuality.setYield(rs.getString("EXPECTED_YIELD"));
                rwsWQuality.setSourceCode1(rs.getString("source1"));
                rwsWQuality.setDepth1(rs.getString("depth1"));
                rwsWQuality.setYield1(rs.getString("yield1"));
                rwsWQuality.setSourceCode2(rs.getString("source2"));
                rwsWQuality.setDepth2(rs.getString("depth2"));
                rwsWQuality.setYield2(rs.getString("yield2"));
                rwsWQuality.setSourceCode3(rs.getString("source3"));
                rwsWQuality.setDepth3(rs.getString("depth3"));
                rwsWQuality.setYield3(rs.getString("yield3"));
                rwsWQuality.setEmpcode(rs.getString("EMPLOYEE_CODE"));
                rwsWQuality.setSiteIdenData(df.format(rs
                        .getDate("SITE_IDENT_DATE")));
                rwsWQuality.setFinalised(rs.getString("FINALISED"));
                rwsWQuality
                        .setFinalDate(df.format(rs.getDate("FINALISE_DATE")));
                rwsWQuality.setRemarks(rs.getString("REMARKS"));
                rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
                rwsWQuality.setPreparedOn(df.format(rs.getDate("PREPARED_ON")));
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getWQSourceFinIden in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rwsWQuality;
    }

    public static ArrayList getWQSourceFinIdens(DataSource dataSource,
            String coc, String doc, String sdoc) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList watersamples = new ArrayList();
        RwsLocations rwsLocations = new RwsLocations(dataSource);
        //System.out.println("coc in view="+coc+"doc in view="+doc+"sdoc in
        // view="+sdoc);
        try {

            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            /*
			 * rs =stmt.executeQuery("SELECT * FROM RWS_SOURCE_IDEN_FIN_TBL" + "
			 * WHERE circle_office_code='"+coc+"' and " +
			 * "division_office_code='"+doc+"' and
			 * subdivision_office_code='"+sdoc+"' and FINALISED IN('Y','N')");
             */
            String query = "SELECT * FROM RWS_SOURCE_IDEN_FIN_TBL"
                    + " WHERE substr(office_code,2,2)='" + coc
                    + "' and substr(office_code,4,1)='" + doc + "' and "
                    + " substr(office_code,5,2)='" + sdoc
                    + "' and FINALISED IN('Y','N')";
            //System.out.println("query is "+query);
            rs = stmt.executeQuery(query);

            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                //rwsWQuality.setCoc(rs.getString(1));
                //rwsWQuality.setDoc(rs.getString(2));
                //rwsWQuality.setSdoc(rs.getString(3));
                rwsWQuality.setHabCode(rwsLocations.getHabName(rs
                        .getString("hab_code"), conn));
                rwsWQuality.setSourceCode(rs.getString("source_code"));
                //rwsWQuality.setPrgmCode(RwsMasterData.getPrgmName(rs.getString(6),conn));
                //rwsWQuality.setSubprgmCode(RwsMasterData.getSubprgmName(rs.getString(6),rs.getString(7),conn));
                rwsWQuality.setWorkCode(rs.getString("WORK_ID"));
                rwsWQuality
                        .setPrgmCode(rs.getString("WORK_ID").substring(0, 2));
                rwsWQuality.setPrgmName(RwsMasterData.getPrgmName(rwsWQuality
                        .getPrgmCode(), conn));
                rwsWQuality.setSubprgmCode(rs.getString("WORK_ID").substring(2,
                        4));
                rwsWQuality.setSubprgmName(RwsMasterData.getSubprgmName(
                        rwsWQuality.getPrgmCode(),
                        rwsWQuality.getSubprgmCode(), conn));
                rwsWQuality.setCasing(rs.getString("casing"));
                rwsWQuality.setDepth(rs.getString("depth"));
                rwsWQuality.setYield(rs.getString("EXPECTED_YIELD"));
                if (rs.getString("source1") != null) //rwsWQuality.setSource1(RwsMasterData.getSourceName(rs.getString("source1"),conn));
                {
                    rwsWQuality.setSource1(rs.getString("source1"));
                } else {
                    rwsWQuality.setSource1("----");
                }

                rwsWQuality.setDepth1(rs.getString("depth1"));
                rwsWQuality.setYield1(rs.getString("yield1"));
                if (rs.getString("source2") != null) {
                    rwsWQuality.setSource2(rs.getString("source2"));
                } else {
                    rwsWQuality.setSource2("----");
                }
                rwsWQuality.setDepth2(rs.getString("depth2"));
                rwsWQuality.setYield2(rs.getString("yield2"));
                if (rs.getString("source3") != null) {
                    rwsWQuality.setSource3(rs.getString("source3"));
                } else {
                    rwsWQuality.setSource3("----");
                }
                rwsWQuality.setDepth3(rs.getString("depth3"));
                rwsWQuality.setYield3(rs.getString("yield3"));
                rwsWQuality.setEmpcode(rs.getString("EMPLOYEE_CODE"));
                rwsWQuality.setOfficeCode(rs.getString("OFFICE_CODE"));
                rwsWQuality.setCoc(rs.getString("OFFICE_CODE").substring(1, 3));
                rwsWQuality.setDoc(rs.getString("OFFICE_CODE").substring(3, 4));
                rwsWQuality
                        .setSdoc(rs.getString("OFFICE_CODE").substring(4, 6));
                if (rs.getDate("SITE_IDENT_DATE") != null
                        && !rs.getDate("SITE_IDENT_DATE").equals("null")) {
                    rwsWQuality.setSiteIdenData(df.format(rs
                            .getDate("SITE_IDENT_DATE")));
                }
                ////System.out.println("finalised="+rs.getString(23));
                if (rs.getString("FINALISED") != null
                        && !rs.getString("FINALISED").equals("null")) {
                    if (rs.getString("FINALISED").equals("Y")) {
                        rwsWQuality.setFinalised("YES");
                    } else {
                        rwsWQuality.setFinalised("NO");
                    }
                } else {
                    rwsWQuality.setFinalised("");
                }
                if (rs.getDate("FINALISE_DATE") != null
                        && !rs.getDate("FINALISE_DATE").equals("null")) {
                    rwsWQuality.setFinalDate(df.format(rs
                            .getDate("FINALISE_DATE")));
                }
                rwsWQuality.setRemarks(rs.getString("REMARKS"));
                rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
                if (rs.getDate("PREPARED_ON") != null
                        && !rs.getDate("PREPARED_ON").equals("null")) {
                    rwsWQuality.setPreparedOn(df.format(rs
                            .getDate("PREPARED_ON")));
                }
                watersamples.add(rwsWQuality);
            }

        } catch (Exception e) {
        	 Debug.println("Exception at getWQSourceFinIden in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return watersamples;
    }

    public static int removeWQSourceFinIdens(String workId,
            DataSource dataSource) throws Exception {
        int rowCount = 0;
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rowCount = stmt
                    .executeUpdate("DELETE FROM RWS_SOURCE_IDEN_FIN_TBL WHERE WORK_ID='"
                            + workId + "'");

        } catch (Exception e) {
        	 Debug.println("Exception at removeWQSourceFinIdens in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static int insertWQDrillStatus(RwsWQuality rwsWQuality,
            DataSource dataSource) throws Exception {
        int rowCount = 0;
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rowCount = stmt
                    .executeUpdate("insert into RWS_WQ_DRILLING_STATUS_TBL values('"
                            + rwsWQuality.getWorkCode()
                            + "','"
                            + rwsWQuality.getDrillStatus()
                            + "',TO_DATE('"
                            + rwsWQuality.getDrillDate()
                            + "','dd/mm/yyyy'),'"
                            + rwsWQuality.getYield()
                            + "','"
                            + rwsWQuality.getPreparedBy()
                            + "',TO_DATE('"
                            + rwsWQuality.getPreparedOn() + "','dd/mm/yyyy'))");
        } catch (SQLException sqle) {
            int errorCode = sqle.getErrorCode();
            if (errorCode == 1) {
                errorMessage = "Record with this name exists.";
            }
        } catch (Exception e) {
        	 Debug.println("Exception at insertWQDrillStatus in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static RwsWQuality getWQDrillStatus(String workId,
            DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;

        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rs = stmt
                    .executeQuery("SELECT * FROM RWS_WQ_DRILLING_STATUS_TBL WHERE WORK_CODE="
                            + workId);
            if (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setWorkCode(rs.getString(1));
                rwsWQuality.setDrillStatus(rs.getString(2));
                rwsWQuality.setDrillDate(df.format(rs.getDate(3)));
                rwsWQuality.setYield(rs.getString(4));
                rwsWQuality.setPreparedBy(rs.getString(5));
                rwsWQuality.setPreparedOn(df.format(rs.getDate(6)));
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getWQDrillStatus in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rwsWQuality;
    }

    public static ArrayList getWQDrillStatuss(String empcode,
            DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList wqDrillStatus = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rs = stmt
                    .executeQuery("SELECT WORK_CODE,DECODE(DRILLING,'1','ONGOING','2','COMPLETED','3','DEFFERED','4','NOTINITIATED'),TO_CHAR(DRILLED_DATE,'DD/MM/YYYY'),YIELD,PREPARED_BY,PREPARED_ON FROM RWS_WQ_DRILLING_STATUS_TBL  WHERE PREPARED_BY='"
                            + empcode + "' ORDER BY WORK_CODE");
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setWorkCode(rs.getString(1));
                rwsWQuality.setDrillStatus(rs.getString(2));
                rwsWQuality.setDrillDate(rs.getString(3));
                rwsWQuality.setYield(rs.getString(4));
                rwsWQuality.setPreparedBy(rs.getString(5));
                rwsWQuality.setPreparedOn(df.format(rs.getDate(6)));

                wqDrillStatus.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getWQDrillStatuss in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return wqDrillStatus;
    }

    public static int removeWQDrillStatus(String workId, DataSource dataSource)
            throws Exception {
        int rowCount = 0;
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rowCount = stmt
                    .executeUpdate("DELETE FROM RWS_WQ_DRILLING_STATUS_TBL WHERE WORK_CODE='"
                            + workId + "'");

        } catch (Exception e) {
        	 Debug.println("Exception at removeWQDrillStatus in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return rowCount;
    }

    public static void updateWQDrillStatus(RwsWQuality rwsWQuality,
            DataSource dataSource) throws Exception {
        try {
            conn = RwsOffices.getConn();

            stmt = conn.createStatement();
            stmt
                    .executeUpdate("update RWS_WQ_DRILLING_STATUS_TBL set DRILLING='"
                            + rwsWQuality.getDrillStatus()
                            + "',DRILLED_DATE=TO_DATE('"
                            + rwsWQuality.getDrillDate()
                            + "','dd/mm/yyyy'),YIELD='"
                            + rwsWQuality.getYield()
                            + "' where WORK_CODE='"
                            + rwsWQuality.getWorkCode() + "'");

        } catch (Exception e) {
        	 Debug.println("Exception at updateWQDrillStatus in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
    }

    public static ArrayList getWQFinalStatus(String workCode,
            DataSource dataSource) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList wqFianlStatus = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            //String query="select
            // sif.work_id,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.panch_name,s.source_name,p.programme_name,su.subprogramme_name,to_char(SITE_IDENT_DATE,'dd/mm/yyyy'),to_char(FINALISE_DATE,'dd/mm/yyyy'),p.user_id
            // from rws_source_iden_fin_tbl sif,rws_panchayat_raj_tbl
            // p,rws_source_tbl s,rws_programme_tbl p,rws_subprogramme_tbl
            // su,RWS_WORK_PROPOSAL_TBL w,rws_password_tbl p where
            // sif.hab_code=p.panch_code and sif.source_code=s.source_code and
            // p.programme_code=sif.programme_code and
            // sif.subprogramme_code=su.subprogramme_code and
            // sif.programme_code=su.programme_code and
            // sif.prepared_by=p.user_id and sif.work_id=w.work_id and
            // sif.work_id='"+workCode+"'";
            String query = "select sif.work_id,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.panch_name,sif.source_code,p.programme_name,su.subprogramme_name,to_char(SITE_IDENT_DATE,'dd/mm/yyyy'),to_char(FINALISE_DATE,'dd/mm/yyyy'),p.user_id  from rws_source_iden_fin_tbl sif,rws_panchayat_raj_tbl p,rws_programme_tbl p,rws_subprogramme_tbl su,RWS_WORK_PROPOSAL_TBL w,rws_password_tbl p where sif.hab_code=p.panch_code and p.programme_code=sif.programme_code and sif.subprogramme_code=su.subprogramme_code and sif.programme_code=su.programme_code and sif.prepared_by=p.user_id and sif.work_id=w.work_id and sif.work_id='"
                    + workCode + "'";
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setWorkCode(rs.getString(1));
                rwsWQuality.setDrillDate(rs.getString(2));
                rwsWQuality.setHabName(rs.getString(3));
                rwsWQuality.setSourceName(rs.getString(4));
                rwsWQuality.setPrgmName(rs.getString(5));
                rwsWQuality.setSubprgmName(rs.getString(6));
                rwsWQuality.setSiteIdenData(rs.getString(7));
                rwsWQuality.setFinalDate(rs.getString(8));
                rwsWQuality.setPreparedBy(rs.getString(9));

                wqFianlStatus.add(rwsWQuality);
            }
        } catch (Exception e) {
        	 Debug.println("Exception at getWQFinalStatus in RwsWQualityData "+ e);
        } finally {
            closeAll();
        }
        return wqFianlStatus;
    }

    public static ArrayList getLabAssistants(DataSource dataSource,
            String officeCode) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList labAssists = new ArrayList();
        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT USER_ID "
                    + "FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='13' "
                    + "AND OFFICE_CODE='" + officeCode + "'");
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setEmpcode(rs.getString(1));

                labAssists.add(rwsWQuality);
            }
        } catch (Exception e) {
            //System.out.println("The error is in getLabAssistants="+e);
        } finally {
            closeAll();
        }
        return labAssists;
    }

    public static ArrayList getForwardedTests(DataSource dataSource,
            String officeCode, String desgnName, String circle, String division)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList forwardTests = new ArrayList();
        //System.out.println("Designation in getForwardedTests
        // is===="+desgnName);

        try {
            if (!desgnName.equalsIgnoreCase("LAB ASST.")) {
                //System.out.println("empcode in getForwardedTests
                // is===="+officeCode);

                conn = RwsOffices.getConn();
                stmt = conn.createStatement();
                stmt2 = conn.createStatement();

                /*
				 * String query="select distinct ws.test_id," +
				 * "to_char(ws.prepared_on,'dd/mm/yyyy')," +
				 * "to_char(ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')," +
				 * "pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE," +
				 * "to_char(sysdate,'dd/mm/yyyy') " + "from
				 * RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p," +
				 * "rws_water_quality_lab_tbl l," + "rws_water_quality_test_tbl
				 * t,rws_panchayat_raj_tbl pr" + " where designation_code!='13'
				 * and l.lab_code=ws.lab_code and ws.prepared_by=p.user_id" + "
				 * and t.test_code=ws.test_code" + " and
				 * ws.hab_code=pr.panch_code " + " and test_id not in(select
				 * test_id from rws_wq_geologist_test_tbl)" + " and
				 * l.office_code='"+officeCode+"'";
                 */
 /*
				 * String query="select distinct ws.test_id," +
				 * "to_char(ws.prepared_on,'dd/mm/yyyy')," +
				 * "to_char(ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')," +
				 * "pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE," +
				 * "to_char(sysdate,'dd/mm/yyyy'),ws.SOURCE_TYPE " + "from
				 * RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p," +
				 * "rws_water_quality_lab_tbl l," + "rws_water_quality_test_tbl
				 * t,rws_panchayat_raj_tbl pr" + " where designation_code!='13'
				 * and l.lab_code=ws.lab_code and ws.prepared_by=p.user_id" + "
				 * and t.test_code=ws.test_code" + " and
				 * ws.hab_code=pr.panch_code " + " and test_id not in(select
				 * test_id from RWS_WQ_TEST_RESULTS_TBL)" + " and
				 * substr(ws.prepared_by,1,4)=substr('"+officeCode+"',1,4)" + "
				 * and ws.source_type is not null" + " order by
				 * to_char(ws.prepared_on,'dd/mm/yyyy')";
                 */
                //String qry = "select distinct
                // ws.test_id,to_char(ws.prepared_on,'dd/mm/yyyy'),to_char
                // (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy'),pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE,to_char
                // (sysdate,'dd/mm/yyyy'),ws.SOURCE_TYPE,l.lab_name,d.division_office_name
                // from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL
                // p,rws_division_office_tbl d,rws_water_quality_lab_tbl
                // l,rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr where
                // ws.circle_office_code='"+circle+"' and
                // ws.division_office_code='"+division+"' and
                // d.circle_office_code=ws.circle_office_code and
                // d.division_office_code = ws.division_office_code and
                // l.lab_code=ws.lab_code and t.test_code=ws.test_code and
                // ws.hab_code=pr.panch_code and test_id not in(select test_id
                // from RWS_WQ_TEST_RESULTS_TBL) and ws.source_type is not null
                // order by to_char (ws.prepared_on,'dd/mm/yyyy')";
                String qry = "select distinct ws.test_id, d.division_office_name, l.lab_name, to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy'), pr.panch_name, ws.SOURCE_TYPE, ws.source_code, t.test_name, desg.DESIGNATION_ACR from RWS_WATER_SAMPLE_COLLECT_TBL ws,rws_division_office_tbl d,rws_water_quality_lab_tbl l,rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr,RWS_DESIGNATION_TBL desg where ws.circle_office_code='"
                        + circle
                        + "' and ws.division_office_code='"
                        + division
                        + "' and d.circle_office_code=ws.circle_office_code and d.division_office_code = ws.division_office_code and l.lab_code=ws.lab_code and t.test_code=ws.test_code and ws.hab_code=pr.panch_code and desg.designation_code=ws.samp_collector_code and test_id not in(select test_id from RWS_WQ_TEST_RESULTS_TBL) and ws.source_type is not null order by to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')";
                //System.out.println("Main:" + qry);
                //System.out.println("query in get forwarded tests:"+query);
                rs = stmt.executeQuery(qry);
                while (rs.next()) {
                    rwsWQuality = new RwsWQuality();
                    rwsWQuality.setCheckedTest(rs.getString(1));
                    rwsWQuality.setTestId(rs.getString(1));
                    rwsWQuality.setDivisionOfficeName(rs.getString(2));
                    rwsWQuality.setLabName(rs.getString(3));
                    rwsWQuality.setSampCollectDate(rs.getString(4));
                    rwsWQuality.setHabCode(rs.getString(5));
                    if (rs.getString("SOURCE_TYPE") != null) {
                        rwsWQuality.setSourceType(getSourceName(rs
                                .getString("SOURCE_TYPE")));
                    } else {
                        rwsWQuality.setSourceType("");
                    }
                    rwsWQuality.setSourceCode(rs.getString(7));
                    rwsWQuality.setTestCode(rs.getString(8));
                    rwsWQuality.setSampCollectCode(rs.getString(9));
                    forwardTests.add(rwsWQuality);
                }
            }
        } catch (Exception e) {
            //System.out.println("The error in getForwardedTests is
            // ==="+e.getMessage());
        } finally {
            closeAll();
        }
        return forwardTests;
    }

    //method added by pranavi
    public static ArrayList getFtklabTests(DataSource dataSource,
            String officeCode, String circle, String division,
            String selectedMonth, String selectedYear) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList forwardTests = new ArrayList();
        //Debug.println("Designation in getftk lab Tests" );

        try {

            //System.out.println("empcode in getForwardedTests
            // is===="+officeCode);
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            stmt2 = conn.createStatement();
            String qry = "select distinct ws.test_id, d.division_office_name, l.lab_name, to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy'), pr.panch_name, ws.SOURCE_TYPE, ws.source_code, t.test_name, desg.DESIGNATION_ACR,ws.ftk_test_id from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p,rws_division_office_tbl d,rws_water_quality_lab_tbl l,rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr,RWS_DESIGNATION_TBL desg where ws.circle_office_code='"
                    + circle
                    + "' and ws.division_office_code='"
                    + division
                    + "' and d.circle_office_code=ws.circle_office_code and d.division_office_code = ws.division_office_code and l.lab_code=ws.lab_code and t.test_code=ws.test_code and ws.hab_code=pr.panch_code and desg.designation_code=ws.samp_collector_code and test_id not in(select test_id from RWS_WQ_TEST_RESULTS_TBL) and ws.source_type is not null and ftk_test_id is not null  ";
            if (selectedMonth.equals("ALL")) {
                qry += " and to_char(ws.SAMP_COLLECT_DATE,'yyyy')='"
                        + selectedYear + "'";
            } else {
                qry += " and to_char(ws.SAMP_COLLECT_DATE,'mm/yyyy')='"
                        + selectedMonth + "/" + selectedYear + "'";
            }
            qry += " order by to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')";
            //Debug.println("query in get ftk lab tests:"+qry);
            //System.out.println("query in get forwarded tests:"+query);
            rs = stmt.executeQuery(qry);
            while (rs.next()) {
                rwsWQuality = new RwsWQuality();
                rwsWQuality.setCheckedTest(rs.getString(1));
                rwsWQuality.setTestId(rs.getString(1));
                rwsWQuality.setDivisionOfficeName(rs.getString(2));
                rwsWQuality.setLabName(rs.getString(3));
                rwsWQuality.setSampCollectDate(rs.getString(4));
                rwsWQuality.setHabCode(rs.getString(5));
                if (rs.getString("SOURCE_TYPE") != null) {
                    rwsWQuality.setSourceType(getSourceName(rs
                            .getString("SOURCE_TYPE")));
                } else {
                    rwsWQuality.setSourceType("");
                }
                rwsWQuality.setSourceCode(rs.getString(7));
                rwsWQuality.setTestCode(rs.getString(8));
                rwsWQuality.setSampCollectCode(rs.getString(9));
                rwsWQuality.setFtktestid(rs.getString(10));
                forwardTests.add(rwsWQuality);
            }

        } catch (Exception e) {
            //System.out.println("The error in getForwardedTests is
            // ==="+e.getMessage());
        } finally {
            closeAll();
        }
        return forwardTests;
    }

    //method modified by sridhar
    public static ArrayList getFtkForwardedTests(DataSource dataSource,
            String officeCode, String circle, String mandal,
            String selectedMonth, String selectedYear) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList forwardTests = new ArrayList();
        //Debug.println("in getFtkForwardedTests ");

        try {

            //System.out.println("empcode in getForwardedTests
            // is===="+officeCode);
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            stmt2 = conn.createStatement();
            String qry = "select distinct f.ftk_test_id,m.mname,to_char (f.TEST_DATE,'dd/mm/yyyy'),NVL(to_char(f.FORWARD_DATE,'dd/mm/yyyy'),'-')as FORWARD_DATE,f.SOURCE_TYPE,f.SOURCE_CODE,p.panch_name from rws_ftk_testing_tbl f ,rws_mandal_tbl m,rws_panchayat_raj_tbl p where"
                    + " substr(f.Source_code,1,2)='"
                    + circle
                    + "' and substr(f.Source_code,6,2)='"
                    + mandal
                    + "' and m.mcode=substr(f.Source_code,6,2) and m.dcode=substr(f.Source_code,1,2) and p.panch_code=substr(f.Source_code,0,16)";
            if (selectedMonth.equals("ALL")) {
                qry += " and to_char(f.TEST_DATE,'yyyy')='" + selectedYear
                        + "'";
            } else {
                qry += " and to_char(f.TEST_DATE,'mm/yyyy')='" + selectedMonth
                        + "/" + selectedYear + "'";
            }

            //Debug.println("query in get ftk forwarded tests:" + qry);
            //System.out.println("query in get forwarded tests:"+query);
            rs = stmt.executeQuery(qry);
            while (rs.next()) {
                ////Debug.println("in while loop");
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setCheckedTest(rs.getString(1));
                rwsWQuality.setFtktestid(rs.getString(1));
                rwsWQuality.setMandalName(rs.getString(2));
                rwsWQuality.setFtkTestDate(rs.getString(3));
                rwsWQuality.setForwardDate(rs.getString(4));
                if (rs.getString("SOURCE_TYPE") != null) {
                    rwsWQuality.setSourceType(getSourceName(rs
                            .getString("SOURCE_TYPE")));
                } else {
                    rwsWQuality.setSourceType("");
                }
                rwsWQuality.setSourceCode(rs.getString(6));
                rwsWQuality.setHabCode(rs.getString(7));
                //Debug.println("status:"+contaminStatus(dataSource,rs.getString(1)));
                rwsWQuality.setNatureOfTest(contaminStatus(dataSource, rs
                        .getString(1)));
                forwardTests.add(rwsWQuality);
            }

        } catch (Exception e) {
            //System.out.println("The error in getForwardedTests is
            // ==="+e.getMessage());
        } finally {
            closeAll();
        }
        return forwardTests;
    }

    //method added by pranavi
    public static ArrayList getFtkNotForwardedTests(DataSource dataSource,
            String officeCode, String circle, String mandal) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList forwardTests = new ArrayList();
        //Debug.println("in getFtkNotForwardedTests ");

        try {
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            stmt2 = conn.createStatement();
            String qry = "select distinct f.ftk_test_id,m.mname,to_char (f.TEST_DATE,'dd/mm/yyyy'),NVL(to_char(f.FORWARD_DATE,'dd/mm/yyyy'),'-')as FORWARD_DATE,f.SOURCE_TYPE,f.SOURCE_CODE,p.panch_name from rws_ftk_testing_tbl f ,rws_mandal_tbl m,rws_panchayat_raj_tbl p,rws_water_sample_collect_tbl  sc where"
                    + " substr(f.Source_code,1,2)='"
                    + circle
                    + "' and substr(f.Source_code,6,2)='"
                    + mandal
                    + "' and m.mcode=substr(f.Source_code,6,2) and m.dcode=substr(f.Source_code,1,2) and p.panch_code=substr(f.Source_code,0,16) and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) and f.forward_date is null";
            //Debug.println("query in get ftk not forwarded tests:"+qry);
            //System.out.println("query in get not forwarded tests:"+query);
            rs = stmt.executeQuery(qry);
            while (rs.next()) {
                ////Debug.println("in while loop");
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setCheckedTest(rs.getString(1));
                rwsWQuality.setFtktestid(rs.getString(1));
                rwsWQuality.setMandalName(rs.getString(2));
                rwsWQuality.setFtkTestDate(rs.getString(3));
                rwsWQuality.setForwardDate(rs.getString(4));
                if (rs.getString("SOURCE_TYPE") != null) {
                    rwsWQuality.setSourceType(getSourceName(rs
                            .getString("SOURCE_TYPE")));
                } else {
                    rwsWQuality.setSourceType("");
                }
                rwsWQuality.setSourceCode(rs.getString(6));
                rwsWQuality.setHabCode(rs.getString(7));
                forwardTests.add(rwsWQuality);
            }

        } catch (Exception e) {
            //System.out.println("The error in getForwardedTests is
            // ==="+e.getMessage());
        } finally {
            closeAll();
        }
        return forwardTests;
    }

    public static ArrayList getTestsSubmittedToSubdivision(
            DataSource dataSource, String officeCode, String desgnName,
            String selectedMonth, String selectedYear, String circle,
            String division) throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList submittedTests = new ArrayList();
        //System.out.println("Circle in getForwardedTests is===="+circle);
        //	System.out.println("division Code is "+division);

        try {
            //code added
            //for division office

            //System.out.println("in EE");
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            String query = "select distinct ws.test_id,ws.prepared_on,"
                    + "to_char(wt.forwarded_on,'dd/mm/yyyy')prepared_on1,"
                    + "pr.panch_name,ws.source_code,t.test_name,"
                    + "wt.prepared_by,to_char(wt.prepared_on,'dd/mm/yyyy')prepared_on,"
                    + "to_char(sysdate,'dd/mm/yyyy')sys_date,ws.SOURCE_TYPE,  "
                    + "decode(wt.update_source_data,'y','YES','Y','YES','n','NO','N','NO')as update_source_data,wt.RECOMMENDATIONS "
                    + "from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p,"
                    + "RWS_WQ_TEST_RESULTS_TBL wt,RWS_WQ_TEST_RESULTS_lnk_TBL wlt,"
                    + "rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr "
                    + "where  wt.test_id=wlt.test_id and p.user_id=wt.prepared_by "
                    + "and ws.test_code=t.test_code and ws.test_id=wt.test_id "
                    + "and pr.panch_code=ws.hab_code and ws.test_id in "
                    + "(select test_id from RWS_WQ_TEST_RESULTS_TBL) "
                    + "AND WS.CIRCLE_OFFICE_CODE='" + circle
                    + "' AND WS.DIVISION_OFFICE_CODE='" + division + "' "
                    + "and ws.source_type is not null";
            if (selectedMonth.equals("ALL")) {
                query += " and to_char(ws.prepared_on,'yyyy')='" + selectedYear
                        + "'";
            } else {
                query += " and to_char(ws.prepared_on,'mm/yyyy')='"
                        + selectedMonth + "/" + selectedYear + "'";
            }
            query += "order by ws.prepared_on desc";

            //System.out.println("query is"+query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                //System.out.println("source type is
                // "+rs.getString("SOURCE_TYPE"));
                //System.out.println("rs.next()");
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setCheckedTest(rs.getString("test_id"));
                rwsWQuality.setTestId(rs.getString("test_id"));
                rwsWQuality
                        .setDateAssignedFromDiv(rs.getString("prepared_on1"));
                rwsWQuality.setHabCode(rs.getString("panch_name"));
                rwsWQuality.setSourceCode(rs.getString("source_code"));
                rwsWQuality.setTestCode(rs.getString("test_name"));
                //the following line should be modified
                rwsWQuality.setForwadedOn("");
                rwsWQuality.setForwadedTo(rs.getString("prepared_by"));
                rwsWQuality.setResultObtainOn(rs.getString("prepared_on"));
                rwsWQuality.setResultForwardOn(rs.getString("sys_date"));
                rwsWQuality.setUpdateSource(rs.getString("UPDATE_SOURCE_DATA"));
                rwsWQuality.setRecommendations(rs.getString("RECOMMENDATIONS"));
                //System.out.println("source name is
                // "+getSourceName(rs.getString("SOURCE_TYPE")));

                if (rs.getString("SOURCE_TYPE") != null) {
                    rwsWQuality.setSourceType(getSourceName(rs
                            .getString("SOURCE_TYPE")));
                } else {
                    rwsWQuality.setSourceType("");
                }
                submittedTests.add(rwsWQuality);
                //System.out.println("added");
            }
            //System.out.println("out of while");

            //end of code added
        } catch (Exception e) {
            //System.out.println("The error in getTestsSubmittedToSubdivision
            // is ==="+e);
        } finally {
            closeAll();
        }
        return submittedTests;
    }

    public static ArrayList getTestResults(DataSource dataSource, String testId)
            throws Exception {
        RwsWQuality rwsWQuality = null;
        ArrayList testResults = new ArrayList();

        try {
            //code added
            //for division office
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "select testResults.test_id,"
                    + "params.TESTING_PARAMETER_CODE,"
                    + "params.TESTING_PARAMETER_NAME,"
                    + "params.MIN_PERMISSIBLE_VALUE,"
                    + "params.MAX_PERMISSIBLE_VALUE,"
                    + "params.UNDESIRE_EFFECT, "
                    + "testLink.TESTING_PARAMETER_VALUE "
                    + "from RWS_WQ_TEST_RESULTS_TBL testResults,"
                    + "RWS_WQ_PARA_TEST_TBL  params,"
                    + "RWS_WQ_TEST_RESULTS_LNK_TBL testLink "
                    + "where testResults.test_id=testLink.test_id "
                    + "and testResults.test_code=params.test_code "
                    + "and testResults.test_id='"
                    + testId
                    + "' "
                    + "and params.TESTING_PARAMETER_CODE =testLink.TESTING_PARAMETER_CODE "
                    + "order by testResults.test_Id,"
                    + "params.test_code,params.TESTING_PARAMETER_CODE";

            //ArrayList testingParameterValues = new ArrayList();
           // System.out.println("query is " + query);
            rs = stmt.executeQuery(query);
            int i = 0;
            while (rs.next()) {
                //System.out.println("rs.next()");
                rwsWQuality = new RwsWQuality();

                rwsWQuality.setTestingParameterCode(rs
                        .getString("TESTING_PARAMETER_CODE"));
                rwsWQuality.setTestingParameterName(rs
                        .getString("TESTING_PARAMETER_NAME"));
                rwsWQuality.setMinPermissibleValue(rs
                        .getString("MIN_PERMISSIBLE_VALUE"));
                rwsWQuality.setMaxPermissibleValue(rs
                        .getString("MAX_PERMISSIBLE_VALUE"));
                rwsWQuality.setTestingParameterValue(rs
                        .getString("TESTING_PARAMETER_VALUE"));
                rwsWQuality.setUndesirableEffect(rs
                        .getString("UNDESIRE_EFFECT"));
                testResults.add(rwsWQuality);
                //testingParameterValues.add(i++,rs.getString("TESTING_PARAMETER_VALUE"));
                //System.out.println("added");
            }
            //System.out.println("TESTING_PARAMETER_VALUEs::"+testingParameterValues.size());

            //end of code added
        } catch (Exception e) {
            //System.out.println("The error in getTestResults is ==="+e);
        } finally {
            closeAll();
        }
        return testResults;
    }

    //************************Water Sample Geologist Forwarded
    // Tests******************************
    public static int[] insertSampleGeoTestsForward(RwsWQuality rwsWQuality,
            ArrayList checkedTests, DataSource dataSource) throws Exception {
        int[] rowCount = new int[5];
        SampleForwardGeoTests sampleForwardGeoTests = new SampleForwardGeoTests();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            String query = "";
            //System.out.println("rwsWQuality.getRoc()="+rwsWQuality.getRoc()+"size="+checkedTests.size());

            for (int i = 0; i < checkedTests.size(); i++) {
                sampleForwardGeoTests = (SampleForwardGeoTests) checkedTests
                        .get(i);
                if (sampleForwardGeoTests.getCheckedTest() != null) {
                    //System.out.println("######### Record No : " + (i+1) + "
                    // ##########");
                    //System.out.println("#########
                    // sampleForwardGeoTests.getCheckedTest() : " +
                    // sampleForwardGeoTests.getCheckedTest() + " ##########");
                    //System.out.println("#########
                    // sampleForwardGeoTests.getTestId() : " +
                    // sampleForwardGeoTests.getTestId() + " ##########");
                    query = "insert into rws_wq_geologist_test_tbl values"
                            + "('" + sampleForwardGeoTests.getTestId() + "',"
                            + "'" + rwsWQuality.getRoc() + "'," + "'"
                            + sampleForwardGeoTests.getTestId().substring(0, 2)
                            + "'," + "'" + rwsWQuality.getPreparedBy() + "',"
                            + "TO_DATE('"
                            + sampleForwardGeoTests.getDateAssignedFromDiv()
                            + "'," + "'dd/MM/yyyy'),TO_DATE('"
                            + sampleForwardGeoTests.getForwadedOn()
                            + "','dd/MM/yyyy')," + "'"
                            + sampleForwardGeoTests.getForwadedTo()
                            + "','','','','" + rwsWQuality.getPreparedBy()
                            + "'," + "TO_DATE('" + rwsWQuality.getPreparedOn()
                            + "','dd/mm/yyyy'))";
                    //System.out.println("query="+query);
                    stmt.addBatch(query);
                }
            }
            rowCount = stmt.executeBatch();
            conn.commit();

        } catch (Exception e) {
            //System.out.println("The error is in RwsWQualityData
            // insertSampleGeoTestsForward "+e.getMessage());
        } finally {
            closeAll();
        }
        //System.out.println("rowcount="+rowCount.length);
        return rowCount;
    }

    public static int[] insertResultsSubmittedToSubdivision(
            RwsWQuality rwsWQuality, ArrayList checkedTests,
            DataSource dataSource) throws Exception {
        int[] rowCount = new int[5];
        SampleForwardGeoTests sampleForwardGeoTests = new SampleForwardGeoTests();

        //System.out.println("in insertResultsSubmittedToSubdivision()");
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        try {
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            //System.out.println("rwsWQuality.getRoc()="+rwsWQuality.getRoc()+"checked
            // test size="+checkedTests.size());

            for (int i = 0; i < checkedTests.size(); i++) {
                ////System.out.println("in for");
                sampleForwardGeoTests = (SampleForwardGeoTests) checkedTests
                        .get(i);
                if (sampleForwardGeoTests.getCheckedTest() != null) {

                    //System.out.println("######### Record No : " + (i+1) + "
                    // ##########");
                    //System.out.println("#########
                    // sampleForwardGeoTests.getCheckedTest() : " +
                    // sampleForwardGeoTests.getCheckedTest() + " ##########");
                    //System.out.println("#########
                    // sampleForwardGeoTests.getTestId() : " +
                    // sampleForwardGeoTests.getTestId() + " ##########");
                    //System.out.println("testid="+sampleForwardGeoTests.getTestId()+"office="+rwsWQuality.getRoc()+"labcode="+sampleForwardGeoTests.getTestId().substring(0,2));
                    //System.out.println("ASSIGNED_BY="+rwsWQuality.getPreparedBy()+"ASSIGNED_FROM_DATE="+sampleForwardGeoTests.getDateAssignedFromDiv()+"ASSIGNED_TO_DATE="+sampleForwardGeoTests.getForwadedOn()+"ASSIGNED_TO="+sampleForwardGeoTests.getForwadedTo());
                    //System.out.println("RESULT_OBTAIN_DATE="+sampleForwardGeoTests.getResultObtainOn()+"FORWARDED_DATE="+sampleForwardGeoTests.getResultForwardOn()+"OFFICE_FORWARD="+sampleForwardGeoTests.getSubdivision()+"PREPARED_BY
                    // ="+rwsWQuality.getPreparedBy()+"PREPARED_ON="+rwsWQuality.getPreparedOn());
                    String query = "update rws_wq_geologist_test_tbl set OFFICE_CODE="
                            + "'"
                            + rwsWQuality.getRoc()
                            + "',LAB_CODE="
                            + "'"
                            + sampleForwardGeoTests.getTestId().substring(0, 2)
                            + "',ASSIGNED_BY="
                            + "'"
                            + rwsWQuality.getPreparedBy()
                            + "',ASSIGNED_FROM_DATE="
                            + "TO_DATE('"
                            + sampleForwardGeoTests.getDateAssignedFromDiv()
                            + "',"
                            + "'dd/MM/yyyy'),ASSIGNED_TO_DATE=TO_DATE('"
                            + sampleForwardGeoTests.getForwadedOn()
                            + "','dd/MM/yyyy'),ASSIGNED_TO="
                            + "'"
                            + sampleForwardGeoTests.getForwadedTo()
                            + "',RESULT_OBTAIN_DATE=TO_DATE('"
                            + sampleForwardGeoTests.getResultObtainOn()
                            + "','dd/MM/yyyy'),FORWARDED_DATE=TO_DATE('"
                            + sampleForwardGeoTests.getResultForwardOn()
                            + "','dd/MM/yyyy'),OFFICE_FORWARD='"
                            + sampleForwardGeoTests.getSubdivision()
                            + "',PREPARED_BY='"
                            + rwsWQuality.getPreparedBy()
                            + "',PREPARED_ON="
                            + "TO_DATE('"
                            + rwsWQuality.getPreparedOn()
                            + "','dd/mm/yyyy') where TEST_ID='"
                            + sampleForwardGeoTests.getTestId() + "'";
                    //System.out.println("query is "+query);
                    stmt.addBatch(query);
                }
            }
            rowCount = stmt.executeBatch();
            conn.commit();

        } catch (Exception e) {
            //System.out.println("The error is in RwsWQualityData
            // insertSampleGeoTestsForward "+e.getMessage());
        } finally {
            closeAll();
        }
        //System.out.println("rowcount="+rowCount.length);
        return rowCount;
    }

    //modified by pranavi
    /*
	 * public static String getSourceName(String sourceType) { String
	 * sourceName=""; if(sourceType==null||sourceType.equals("")) sourceName="";
	 * if(sourceType.equals("0101001")) sourceName="PWS SUBSURFACE SOURCE";
	 * if(sourceType.equals("0101002")) sourceName="PWS SURFACE SOURCE";
	 * if(sourceType.equals("0101003")) sourceName="PWS PUMPSETS";
	 * if(sourceType.equals("0201001")) sourceName="MPWS SUBSURFACE SOURCE";
	 * if(sourceType.equals("0201002")) sourceName="MPWS SURFACE SOURCE";
	 * if(sourceType.equals("0201003")) sourceName="MPWS PUMPSETS";
	 * if(sourceType.equals("0301001")) sourceName="CPWS SUBSURFACE SOURCE";
	 * if(sourceType.equals("0301002")) sourceName="CPWS SURFACE SOURCE";
	 * if(sourceType.equals("0301003")) sourceName="CPWS PUMPSETS";
	 * if(sourceType.equals("0401001")) sourceName="HANDPUMPS BOREWELL";
	 * if(sourceType.equals("0501001")) sourceName="SHALLOW HANDPUMPS";
	 * if(sourceType.equals("0601001")) sourceName="OPEN WELLS";
	 * if(sourceType.equals("0701001")) sourceName="PONDS";
	 * 
	 * return sourceName;
	 *  }
     */
    public static String getSourceType(String sourceCode) {
        String sourceType;
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceCode);
        sourceType = subCompMetaData.getTypeOfAssetCode()
                + subCompMetaData.getAssetCompTypeCode()
                + subCompMetaData.getAssetSubCompTypeCode();
        return sourceType;

    }

    public static ArrayList getSourceCodes(DataSource dataSource,
            String sourceType, String habCode) throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList sourceCodes = new ArrayList();
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType
                .substring(0, 2), sourceType.substring(2, 4), sourceType
                .substring(4, 7));

        try {

            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "";
            //for source
            if ((sourceType.substring(0, 2).equals("01")
                    || sourceType.substring(0, 2).equals("02") || sourceType
                    .substring(0, 2).equals("03"))
                    && (sourceType.substring(2, 4).equals("01") && !sourceType
                    .substring(4, 7).equals("003"))) {
                if (sourceType.substring(4, 7).equals("001")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + " from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=1 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%'";
                } else if (sourceType.substring(4, 7).equals("002")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + " from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=2 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%'";
                }
            } else if ((sourceType.substring(0, 2).equals("04"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + " from " + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '" + "0" + "%'";
            } else {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + " from " + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%'";
            }
            //System.out.println("query is "+query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                //System.out.println("sourceCode in rwsWQualityData is
                // "+rs.getString(1));
                rwsMaster.setSourceCode(rs.getString(1));

                sourceCodes.add(rwsMaster);
            }
        } catch (Exception e) {
            //System.out.println(e.getMessage());
        } finally {
            closeAll();
        }
        return sourceCodes;
    }

    public static ArrayList getSourceCodesWithLocation1(DataSource dataSource, String sourceType, String habCode) throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList sourceCodes = new ArrayList();
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType.substring(0, 2), sourceType.substring(2, 4), sourceType.substring(4, 7));
        String subCompRep = subCompMetaData.getSubCompRep();

        try {
            conn = RwsOffices.getConn();
            String query = "";
            if ((sourceType.substring(0, 2).equals("01") || sourceType.substring(0, 2).equals("02") || sourceType.substring(0, 2).equals("03")) && (sourceType.substring(2, 4).equals("01") && !sourceType.substring(4, 7).equals("003"))) {
                if (sourceType.substring(4, 7).equals("001")) {
                    query = "SELECT "+ subCompMetaData.getSchemeCodeField()
                            + ",location from " + subCompMetaData.getTableName()
                            + " where substr(" + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='" + habCode
                            + "' and source_type_code=1 and substr(" + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '" + subCompMetaData.getSchemeCodeSeries().substring( 0, 1)
                            + "%' and substr(" + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "' "
                            + "and " + subCompMetaData.getSchemeCodeField()
                            + " in (select Source_code from rws_ftk_testing_tbl where forward_date is not null) and "
                            + subCompMetaData.getSchemeCodeField()
                            + " not in (select Source_code from rws_wq_test_results_tbl)";
                } 
                else if (sourceType.substring(4, 7).equals("002")) {
                    query = "SELECT " + subCompMetaData.getSchemeCodeField()
                            + ",location from " + subCompMetaData.getTableName()
                            + " where substr(" + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='" + habCode
                            + "' and source_type_code=2 and substr(" + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '" + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                            + "%' and substr(" + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "' "
                            + "and " + subCompMetaData.getSchemeCodeField()
                            + " in (select Source_code from rws_ftk_testing_tbl where forward_date is not null) and "
                            + subCompMetaData.getSchemeCodeField()
                            + " not in (select Source_code from rws_wq_test_results_tbl)";
                }
            } else if ((sourceType.substring(0, 2).equals("04"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + ",location from " + subCompMetaData.getTableName()
                        + " where substr("  + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='" + habCode
                        + "' and substr(" + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '0%' or substr(" + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '1%' or substr(" + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '2%' and substr(" + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '" + subCompRep
                        + "' and " + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl where forward_date is not null) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";                
            } else if ((sourceType.substring(0, 2).equals("07"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + ",pond_location from " + subCompMetaData.getTableName()
                        + " where substr(" + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='" + habCode
                        + "' and substr(" + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '7%' and substr(" + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '" + subCompRep
                        + "' and " + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl where forward_date is not null) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";               
            } else {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + ",location from " + subCompMetaData.getTableName()
                        + " where substr(" + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='" + habCode + "' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '" + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr(" + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '" + subCompRep + "' and "
                        + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl where forward_date is not null) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();               
                rwsMaster.setSourceCode(rs.getString(1));
                if (rs.getString(2) != null) {
                    rwsMaster.setSourceAndLocation(rs.getString(1) + " At " + rs.getString(2));
                } else {
                    rwsMaster.setSourceAndLocation(rs.getString(1));
                }
                sourceCodes.add(rwsMaster);
            }
            
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getSourceCodesWithLocation1 = "+e.getMessage());
        } finally {
            closeAll();
        }
        return sourceCodes;
    }

   public static ArrayList getSourceCodesWithLocation2(DataSource dataSource, String sourceType, String habCode) throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList sourceCodes = new ArrayList();
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType
                .substring(0, 2), sourceType.substring(2, 4), sourceType
                .substring(4, 7));
        String subCompRep = subCompMetaData.getSubCompRep();

        try {
            // //Debug.println("1111111111111");

            conn = RwsOffices.getConn();
            stmt = conn.createStatement();
            String query = "";
            //for source
            if ((sourceType.substring(0, 2).equals("01")
                    || sourceType.substring(0, 2).equals("02") || sourceType
                    .substring(0, 2).equals("03"))
                    && (sourceType.substring(2, 4).equals("01") && !sourceType
                    .substring(4, 7).equals("003"))) {
                ////Debug.println("333333333333");
                if (sourceType.substring(4, 7).equals("001")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ",location from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=1 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1)
                            + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '"
                            + subCompRep
                            + "' "
                            + "and "
                            + subCompMetaData.getSchemeCodeField()
                            + " in (select Source_code from rws_ftk_testing_tbl) and "
                            + subCompMetaData.getSchemeCodeField()
                            + " not in (select Source_code from rws_wq_test_results_tbl)";
                    //Debug.println("query 1 is " + query);
                } else if (sourceType.substring(4, 7).equals("002")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ",location from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=2 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1)
                            + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '"
                            + subCompRep
                            + "' "
                            + "and "
                            + subCompMetaData.getSchemeCodeField()
                            + " in (select Source_code from rws_ftk_testing_tbl ) and "
                            + subCompMetaData.getSchemeCodeField()
                            + " not in (select Source_code from rws_wq_test_results_tbl)";
                    //Debug.println("query 2 is "+query);
                }
            } else if ((sourceType.substring(0, 2).equals("04"))) {
                query = "SELECT "
                        + subCompMetaData.getSchemeCodeField()
                        + ",location from "
                        + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='"
                        + habCode
                        + "' "
                        + "and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '0%' or substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '1%' or substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '2%' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '"
                        + subCompRep
                        + "'"
                        + "and "
                        + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";
                //Debug.println("query is 3---> "+query);
            } else if ((sourceType.substring(0, 2).equals("07"))) {
                query = "SELECT "
                        + subCompMetaData.getSchemeCodeField()
                        + ",pond_location from "
                        + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='"
                        + habCode
                        + "' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '7%' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '"
                        + subCompRep
                        + "' "
                        + "and "
                        + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl ) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";
                //Debug.println("query 4 is "+query);
            } else {
                query = "SELECT "
                        + subCompMetaData.getSchemeCodeField()
                        + ",location from "
                        + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",1,16)='"
                        + habCode
                        + "' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",20,2)= '"
                        + subCompRep
                        + "'"
                        + " and "
                        + subCompMetaData.getSchemeCodeField()
                        + " in (select Source_code from rws_ftk_testing_tbl ) and "
                        + subCompMetaData.getSchemeCodeField()
                        + " not in (select Source_code from rws_wq_test_results_tbl)";
                //Debug.println("query 5 is "+query);
            }
            //Debug.println("222222222222222222" + query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                //System.out.println("sourceCode in rwsWQualityData is
                // "+rs.getString(1));
                rwsMaster.setSourceCode(rs.getString(1));
                if (rs.getString(2) != null) {
                    rwsMaster.setSourceAndLocation(rs.getString(1) + " At "
                            + rs.getString(2));
                } else {
                    rwsMaster.setSourceAndLocation(rs.getString(1));
                }

                sourceCodes.add(rwsMaster);
            }

        } catch (Exception e) {
            //System.out.println(e.getMessage());
        } finally {
            closeAll();
        }
        return sourceCodes;
    }

    /*
	 * public static ArrayList getSourceCodesWithLocation(DataSource
	 * dataSource,String sourceType,String habCode) throws Exception { RwsMaster
	 * rwsMaster = null; ArrayList sourceCodes = new ArrayList();
	 * SubCompMetaData subCompMetaData=new
	 * SubCompMetaData(sourceType.substring(0,2),sourceType.substring(2,4),sourceType.substring(4,7));
	 * String subCompRep=subCompMetaData.getSubCompRep();
	 * 
	 * try {
	 * 
	 * conn = RwsOffices.getConn(); stmt = conn.createStatement(); String
	 * query=""; //for source Debug.println("sourceType:"+sourceType);
	 * Debug.println("substring 4,7:"+sourceType.substring(4,7));
	 * if((sourceType.substring(0,2).equals("01")||sourceType.substring(0,2).equals("02")||sourceType.substring(0,2).equals("03"))
	 * &&(sourceType.substring(2,4).equals("01") &&
	 * !sourceType.substring(4,7).equals("003"))) {
	 * if(sourceType.substring(4,7).equals("001")) { query="SELECT
	 * "+subCompMetaData.getSchemeCodeField()+",location from
	 * "+subCompMetaData.getTableName()+" where
	 * substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and
	 * source_type_code=1 and
	 * substr("+subCompMetaData.getSchemeCodeField()+",17,3) like
	 * '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'"; }
	 * else if(sourceType.substring(4,7).equals("002")){
	 * 
	 * query="SELECT "+subCompMetaData.getSchemeCodeField()+",location from
	 * "+subCompMetaData.getTableName()+" where
	 * substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and
	 * source_type_code=2 and
	 * substr("+subCompMetaData.getSchemeCodeField()+",17,3) like
	 * '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
	 * Debug.println("query 2 is "+query); } } else
	 * if((sourceType.substring(0,2).equals("04"))) { query="SELECT
	 * "+subCompMetaData.getSchemeCodeField()+",location from
	 * "+subCompMetaData.getTableName()+" where
	 * substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
	 * //Debug.println("query is 3 "+query); } else
	 * if((sourceType.substring(0,2).equals("07"))) { query="SELECT
	 * "+subCompMetaData.getSchemeCodeField()+",pond_location from
	 * "+subCompMetaData.getTableName()+" where
	 * substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '7%' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
	 * //Debug.println("query 4 is "+query); } else{ query="SELECT
	 * "+subCompMetaData.getSchemeCodeField()+",location from
	 * "+subCompMetaData.getTableName()+" where
	 * substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",17,3) like
	 * '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and
	 * substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
	 * //Debug.println("query 5 is "+query); } Debug.println("query is "+query);
	 * rs = stmt.executeQuery(query); while (rs.next()) { rwsMaster = new
	 * RwsMaster(); //System.out.println("sourceCode in rwsWQualityData is
	 * "+rs.getString(1)); rwsMaster.setSourceCode(rs.getString(1));
	 * if(rs.getString(2)!=null)
	 * rwsMaster.setSourceAndLocation(rs.getString(1)+" At "+rs.getString(2));
	 * else rwsMaster.setSourceAndLocation(rs.getString(1));
	 * 
	 * sourceCodes.add(rwsMaster); } } catch (Exception e) {
	 * //System.out.println(e.getMessage()); } finally { closeAll(); } return
	 * sourceCodes; }
     */
    ////Added by sreelaxmidevi on 17/04/2012
    public static String getSourceName(String sourceType) {
        String sourceName = "";
        if (sourceType == null || sourceType.equals("")) {
            sourceName = "";
        }
        if (sourceType.equals("0101001")) {
            sourceName = "PWS SUBSURFACE SOURCE";
        }
        if (sourceType.equals("0101002")) {
            sourceName = "PWS SURFACE SOURCE";
        }
        if (sourceType.equals("0101003")) {
            sourceName = "PWS PUMPSETS";
        }
        if (sourceType.equals("0201001")) {
            sourceName = "MPWS SUBSURFACE SOURCE";
        }
        if (sourceType.equals("0201002")) {
            sourceName = "MPWS SURFACE SOURCE";
        }
        if (sourceType.equals("0201003")) {
            sourceName = "MPWS PUMPSETS";
        }
        if (sourceType.equals("0301001")) {
            sourceName = "CPWS SUBSURFACE SOURCE";
        }
        if (sourceType.equals("0301002")) {
            sourceName = "CPWS SURFACE SOURCE";
        }
        if (sourceType.equals("0301003")) {
            sourceName = "CPWS PUMPSETS";
        }
        if (sourceType.equals("0401001")) {
            sourceName = "HANDPUMPS BOREWELL";
        }
        if (sourceType.equals("0501001")) {
            sourceName = "SHALLOW HANDPUMPS";
        }
        if (sourceType.equals("0601001")) {
            sourceName = "OPEN WELLS";
        }
        if (sourceType.equals("0701001")) {
            sourceName = "PONDS";
        }
        if (sourceType.equals("0901001")) {
            sourceName = "DIRECT PUMPING SUBSURFACE SOURCE";
        }
        if (sourceType.equals("0901002")) {
            sourceName = "DIRECT PUMPING SURFACE SOURCE";
        }
        if (sourceType.equals("0104003")) {
            sourceName = "PWS GLSR";
        }
        if (sourceType.equals("0204003")) {
            sourceName = "MPWS GLSR";
        }
        if (sourceType.equals("0304003")) {
            sourceName = "CPWS GLSR";
        }
        if (sourceType.equals("0104004")) {
            sourceName = "PWS GLBR";
        }
        if (sourceType.equals("0204004")) {
            sourceName = "MPWS GLBR";
        }
        if (sourceType.equals("0304004")) {
            sourceName = "CPWS GLBR";
        }
        if (sourceType.equals("0104001")) {
            sourceName = "PWS OHSR";
        }
        if (sourceType.equals("0204001")) {
            sourceName = "MPWS OHSR";
        }
        if (sourceType.equals("0304001")) {
            sourceName = "CPWS OHSR";
        }

        return sourceName;

    }

    ////Added by sreelaxmidevi on 17/04/2012
    public static ArrayList getFtkTestedSources(String habCode) {
        ArrayList sources = new ArrayList();
        String qry = "";
        qry = "select distinct t.SOURCE_CODE ,subCompTbl.location,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED'),ftk_test_id FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_ftk_testing_tbl t WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and subCompTbl.hab_code='"
                + habCode
                + "' and t.source_code=subCompTbl.source_code and ftk_test_id not in(select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
      //  System.out.println("qry" + qry);

        qry = "select distinct subCompTbl.HP_CODE ,subCompTbl.LOCATION,decode(m.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_ftk_testing_tbl t WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and m.hab_code=substr(subCompTbl.hp_code,1,16) and m.hab_code='"
                + habCode
                + "'  and t.source_code=subCompTbl.hp_code and ftk_test_id not in(select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by  substr(subCompTbl.hp_code,21,24)";

        return sources;
    }

    public static ArrayList getftkSources(DataSource dataSource, String circleOfficeCode, String mandalCode, String habCode, HttpSession session) throws Exception { 
        RwsMaster rwsMaster = null;
        ArrayList sources = new ArrayList();
        ArrayList codes = new ArrayList();
        String compTypeCode = null;
        String subCompTypeCode = null;
        String assetTypeCode = null;
        String sourceTypeName = "";
        String qr = "";
        int i = 0;
        try {

            conn = RwsOffices.getConn();
            SubCompMetaData subCompMetaData = new SubCompMetaData();
            String query = "null";
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {                
                qr = "select a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,"
                        + "rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and substr(a.hab_code,1,16)=c.panch_code and a.HAB_CODE ='"
                        + habCode
                        + "' and a.POND_CODE  in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.POND_CODE=f.source_code"
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by b.pname";
            } else {               
                qr = "select a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and substr(a.hab_code,1,16)=c.panch_code"
                        + " and substr (a.HAB_CODE,1,2) ='"
                        + circleOfficeCode
                        + "' and substr (a.hab_code,6,2) ='"
                        + mandalCode
                        + "' and a.POND_CODE  in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.POND_CODE=f.source_code "
                        + "and  f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by b.pname";
            }
            ps = conn.prepareStatement(qr);            
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(4));
                rwsMaster.setHabName(rs.getString(5));
                rwsMaster.setFtktestid(rs.getString(6));
                codes.add(i++, assetTypeCode + compTypeCode + subCompTypeCode);
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {                
                qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f "
                        + "where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr (a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and substr(a.HABITATION_code,1,14)=c.hab_code and a.HABITATION_CODE='"
                        + habCode
                        + "' and a.OPENWELL_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.OPENWELL_CODE=f.source_code "
                        + "and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null ) order by b.pname";
            } else {                
                qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr (a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and substr(a.HABITATION_code,1,14)=c.hab_code and substr(a.HABITATION_CODE,1,2)='"
                        + circleOfficeCode
                        + "' and substr (a.HABITATION_CODE,6,2)='"
                        + mandalCode
                        + "'and a.OPENWELL_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.OPENWELL_CODE=f.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by b.pname";
            }
            ps = conn.prepareStatement(qr);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(3));
                rwsMaster.setHabName(rs.getString(4));
                rwsMaster.setFtktestid(rs.getString(5));
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f "
                        + "  where  a.HAB_CODE='"+ habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in"
                        + " (select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code"
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            } else {
               query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  substr(a.HAB_CODE,1,2)='" + circleOfficeCode
                        + "' and substr(a.HAB_CODE,13,2)='" + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                rwsMaster.setFtktestid(rs.getString(5));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  a.HAB_CODE='" + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            } else {
                query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  substr(a.HAB_CODE,1,2)='" + circleOfficeCode
                        + "' and substr(a.HAB_CODE,13,2)='" + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code  "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                rwsMaster.setFtktestid(rs.getString(5));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {                
                query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  a.HAB_CODE='" + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code"
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            } else {               
                query = "select distinct a.PUMP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_AST_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  substr(a.HAB_CODE,1,2)='" + circleOfficeCode
                        + "' and substr(a.hab_code,6,2)='" + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.PUMP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.PUMP_CODE=f.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(3));
                rwsMaster.setHabName(rs.getString(4));
                rwsMaster.setFtktestid(rs.getString(5));
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                query = "select distinct SOURCE_CODE ,SOURCE_NAME,b.pname,c.panch_name  from RWS_SOURCE_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c  where  a.HAB_CODE='"
                        + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and source_code in (select Source_code from rws_ftk_testing_tbl where forward_date is not null)";
                query = "select distinct a.SOURCE_CODE ,a.SOURCE_NAME,b.pname,c.panch_name,f.ftk_test_id  from RWS_SOURCE_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  a.HAB_CODE='" + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and "
                        + "substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.source_code in "
                        + "(select Source_code from rws_ftk_testing_tbl) and f.source_code=a.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by f.ftk_test_id";
            } else {               
                query = "select distinct a.SOURCE_CODE ,a.SOURCE_NAME,b.pname,c.panch_name,f.ftk_test_id  from RWS_SOURCE_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f "
                        + " where  substr(a.HAB_CODE,1,2)='" + circleOfficeCode
                        + "' and substr(a.hab_code,6,2)='" + mandalCode
                        + "' and "
                        + "a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.source_code in "
                        + "(select Source_code from rws_ftk_testing_tbl) and f.source_code=a.source_code "
                        + " and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null) order by f.ftk_test_id";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(3));
                rwsMaster.setHabName(rs.getString(4));
                rwsMaster.setFtktestid(rs.getString(5));
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }            
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {                
                qr = "select distinct a.HP_CODE ,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,"
                        + "rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and"
                        + " b.pcode=substr (hp_code,13,2) and b.dcode=substr(hab_code,1,2) and b.mcode=substr (hab_code,6,2) and b.pcode=substr (hab_code,13,2)"
                        + " and substr(a.hp_code,1,16)=c.panch_code and substr(hp_code,1,16)='" + habCode + "' and a.hp_code=f.source_code  "
                        + " and ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null ) order by b.pname";

            } else {
               qr = "select a.HP_CODE ,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and b.pcode=substr (hp_code,13,2) and b.dcode=substr(hab_code,1,2) and b.mcode=substr (hab_code,6,2) and b.pcode=substr (hab_code,13,2) and substr(a.hp_code,1,16)=c.panch_code"
                        + "  and substr(HP_CODE,1,2)='" + circleOfficeCode + "' AND substr(hp_code,6,2)='" + mandalCode + "' and a.hp_code=f.source_code "
                        + " and ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null ) order by b.pname";
            }
            ps = conn.prepareStatement(qr);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(3));
                rwsMaster.setHabName(rs.getString(4));
                rwsMaster.setFtktestid(rs.getString(5));
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                query = "select distinct a.SHALLOWHP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_SHALLOWHANDPUMPS_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  a.HAB_CODE='" + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.SHALLOWHP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.SHALLOWHP_CODE=f.source_code "
                        + "  and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            } else {
                query = "select distinct a.SHALLOWHP_CODE,a.LOCATION,b.pname,c.panch_name,f.FTK_TEST_ID  from RWS_SHALLOWHANDPUMPS_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_ftk_testing_tbl f  "
                        + "where  substr(a.HAB_CODE,1,2)='" + circleOfficeCode + "' and substr(a.HAB_CODE,13,2)='" + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.SHALLOWHP_CODE in "
                        + "(select Source_code from rws_ftk_testing_tbl) and a.SHALLOWHP_CODE=f.source_code"
                        + "  and f.ftk_test_id not in (select ftk_test_id from rws_water_sample_collect_tbl where ftk_test_id is not null)";
            }

            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                rwsMaster.setFtktestid(rs.getString(5));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }            
            session.setAttribute("codes", codes);
            
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getftkSources = "+e.getMessage());
        } finally {
            closeAll();
        }
        return sources;
    }

    //code added by sridhar for getting source names only
    public String getSourceNames(String sourceCode, String stCode)
            throws Exception {
        String sName = "";
        String qry = "";
        conn = RwsOffices.getConn();
        stmt = conn.createStatement();
        try {
            if (stCode.equals("01") || stCode.equals("02")
                    || stCode.equals("03")) {
                qry = "select nvl(location,'-') from rws_source_tbl where source_code='"
                        + sourceCode + "'";
            } else if (stCode.equals("04")) {
                qry = "select nvl(location,'-') from RWS_HP_SUBCOMP_PARAM_TBL where hp_code='"
                        + sourceCode + "'";
            } else if (stCode.equals("05")) {
                qry = "select nvl(location,'-') from RWS_SHALLOWHANDPUMPS_TBL where shallowhp_code='"
                        + sourceCode + "'";
            } else if (stCode.equals("06")) {
                qry = "select nvl(location,'-') from RWS_OPEN_WELL_MAST_TBL where openwell_code='"
                        + sourceCode + "'";
            } else if (stCode.equals("07")) {
                qry = "select nvl(pond_location,'-') from RWS_OPENWELL_POND_TBL where pond_code='"
                        + sourceCode + "'";
            }

            rs = stmt.executeQuery(qry);
            if (rs.next()) {
                sName = rs.getString(1);
            }
        } catch (Exception e) {
            System.out.println("Exception in getSourceNames Method:" + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return sName;
    }

    // code added by sridhar for district and mandal wise source code of source
    // Names
    public Hashtable getSourceNamess(String dcode, String mcode)
            throws Exception {
        String sName = "";
        String qry = "";
        Hashtable ht = new Hashtable();
        conn = RwsOffices.getConn();
        stmt = conn.createStatement();
        try {
            String qry1 = "select distinct  a.source_code,source_type from rws_complete_hab_view v,rws_wq_test_results_tbl a,rws_water_sample_collect_tbl b where substr(a.source_code,1,16)=v.panch_code and a.test_id=b.test_id and b.source_code=a.source_code and a.test_code=b.test_code and a.test_code='1' and source_type is not null and substr(a.source_code,1,2)='"
                    + dcode + "' and substr(a.source_code,6,2)='" + mcode + "'";

            Statement st1 = conn.createStatement();
            ResultSet rs1 = st1.executeQuery(qry1);

            while (rs1.next()) {
                if (rs1.getString(2).substring(0, 2).equals("01")
                        || rs1.getString(2).substring(0, 2).equals("02")
                        || rs1.getString(2).substring(0, 2).equals("03")) {
                    qry = "select nvl(location,'-') from rws_source_tbl where source_code='"
                            + rs1.getString(1) + "'";
                } else if (rs1.getString(2).substring(0, 2).equals("04")) {
                    qry = "select nvl(location,'-') from RWS_HP_SUBCOMP_PARAM_TBL where hp_code='"
                            + rs1.getString(1) + "'";
                } else if (rs1.getString(2).substring(0, 2).equals("05")) {
                    qry = "select nvl(location,'-') from RWS_SHALLOWHANDPUMPS_TBL where shallowhp_code='"
                            + rs1.getString(1) + "'";
                } else if (rs1.getString(2).substring(0, 2).equals("06")) {
                    qry = "select nvl(location,'-') from RWS_OPEN_WELL_MAST_TBL where openwell_code='"
                            + rs1.getString(1) + "'";
                } else if (rs1.getString(2).substring(0, 2).equals("07")) {
                    qry = "select nvl(pond_location,'-') from RWS_OPENWELL_POND_TBL where pond_code='"
                            + rs1.getString(1) + "'";
                }
                rs = stmt.executeQuery(qry);

                if (rs.next()) {
                    sName = rs.getString(1);
                }
                ht.put(rs1.getString(1), sName);

            }
        } catch (Exception e) {
            System.out.println("Exception in getSourceNames Method:" + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return ht;
    }

    public static ArrayList getSourceCodesWithLocation(DataSource dataSource, String sourceType, String habCode) throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList sourceCodes = new ArrayList();
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceType.substring(0, 2), sourceType.substring(2, 4), sourceType.substring(4, 7));
        String subCompRep = subCompMetaData.getSubCompRep();
        try {
            conn = RwsOffices.getConn();
            String query = "";
            String s = sourceType.substring(2, 4);            
            if ((sourceType.substring(0, 2).equals("01") || sourceType.substring(0, 2).equals("02") || sourceType.substring(0, 2).equals("03") || sourceType.substring(0, 2).equals("09")) && (sourceType.substring(2, 4).equals("01") && !sourceType.substring(4, 7).equals("003"))) {
                if (sourceType.substring(4, 7).equals("001")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ",location from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=1 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "'";
                } else if (sourceType.substring(4, 7).equals("002")) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ",location from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "' and source_type_code=2 and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "'";                    
                }

            } else if ((sourceType.substring(0, 2).equals("04"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField()
                        + ",location from " + subCompMetaData.getTableName()
                        + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "' and substr("
                        + subCompMetaData.getSchemeCodeField() + ",20,2)= '"
                        + subCompRep + "'";                
            } //Added for shallowhandpumps
            
            else if ((sourceType.substring(0, 2).equals("05"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField() + ","
                        + subCompMetaData.getLocationField() + "  from "
                        + subCompMetaData.getTableName() + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "'  and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr("
                        + subCompMetaData.getSchemeCodeField() + ",20,2)= '"
                        + subCompRep + "'";
            } //Added for ponds
            
            else if ((sourceType.substring(0, 2).equals("07"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField() + ","
                        + subCompMetaData.getLocationField() + "  from "
                        + subCompMetaData.getTableName() + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "'  and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr("
                        + subCompMetaData.getSchemeCodeField() + ",20,2)= '"
                        + subCompRep + "'";
            }//added for others
            
        else if ((sourceType.substring(0, 2).equals("08"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField() + ","
                        + subCompMetaData.getLocationField() + "  from "
                        + subCompMetaData.getTableName() + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "'  and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr("
                        + subCompMetaData.getSchemeCodeField() + ",20,2)= '"
                        + subCompRep + "'";
            } //Added for openwells
            
            else if ((sourceType.substring(0, 2).equals("06"))) {
                query = "SELECT " + subCompMetaData.getSchemeCodeField() + ","
                        + subCompMetaData.getLocationField() + "  from "
                        + subCompMetaData.getTableName() + " where substr("
                        + subCompMetaData.getSchemeCodeField() + ",1,16)='"
                        + habCode + "'  and substr("
                        + subCompMetaData.getSchemeCodeField()
                        + ",17,3) like '"
                        + subCompMetaData.getSchemeCodeSeries().substring(0, 1)
                        + "%' and substr("
                        + subCompMetaData.getSchemeCodeField() + ",20,2)= '"
                        + subCompRep + "'";
            } 
            
            else {
                if ((sourceType.substring(2, 4).equals("04") && sourceType.substring(4, 7).equals("003") || (sourceType.substring(0, 2).equals("01") || sourceType.substring(0, 2).equals("02") || sourceType.substring(0, 2).equals("03")))) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ","
                            + subCompMetaData.getLocationField()
                            + " from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "'  and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "'";                    
                }
                if ((sourceType.substring(2, 4).equals("04") && sourceType.substring(4, 7).equals("004") || (sourceType.substring(0, 2).equals("01")|| sourceType.substring(0, 2).equals("02") || sourceType.substring(0, 2).equals("03")))) {

                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ","
                            + subCompMetaData.getLocationField()
                            + "  from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "'  and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "'";
                }
                if ((sourceType.substring(2, 4).equals("04") && sourceType.substring(4, 7).equals("001") || (sourceType.substring(0, 2).equals("01") || sourceType.substring(0, 2).equals("02") || sourceType.substring(0, 2).equals("03")))) {
                    query = "SELECT "
                            + subCompMetaData.getSchemeCodeField()
                            + ","
                            + subCompMetaData.getLocationField()
                            + "  from "
                            + subCompMetaData.getTableName()
                            + " where substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",1,16)='"
                            + habCode
                            + "'  and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",17,3) like '"
                            + subCompMetaData.getSchemeCodeSeries().substring(
                                    0, 1) + "%' and substr("
                            + subCompMetaData.getSchemeCodeField()
                            + ",20,2)= '" + subCompRep + "'";
                }
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                if (rs.getString(2) != null) {
                    rwsMaster.setSourceAndLocation(rs.getString(1) + " At " + rs.getString(2));
                } else {
                    rwsMaster.setSourceAndLocation(rs.getString(1));
                }
                sourceCodes.add(rwsMaster);
            }
        } catch (Exception e) {
            System.out.println("The exception in RwsWQualityData getSourceCodesWithLocation = "+e.getMessage());
        } finally {
            closeAll();
        }
        return sourceCodes;
    }

    public static ArrayList getSources(DataSource dataSource, String circleOfficeCode, String mandalCode, String habCode, HttpSession session) throws Exception {
        RwsMaster rwsMaster = null;
        ArrayList sources = new ArrayList();
        ArrayList codes = new ArrayList();
        String compTypeCode = null;
        String subCompTypeCode = null;
        String assetTypeCode = null;
        String sourceTypeName = "";
        String qr = "";
        int i = 0;
        PreparedStatement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
        ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
        try {

            conn = RwsOffices.getConn();           
            SubCompMetaData subCompMetaData = new SubCompMetaData();
            String query = "null";
             if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                query = "select distinct SOURCE_CODE ,SOURCE_NAME,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') from RWS_SOURCE_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d  where  a.HAB_CODE='"
                        + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.asset_code=d.asset_code(+)";
            } else {
                query = "select distinct SOURCE_CODE ,SOURCE_NAME,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') from RWS_SOURCE_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d  where  substr(a.HAB_CODE,1,2)='"
                        + circleOfficeCode
                        + "' and substr(a.hab_code,6,2)='"
                        + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.asset_code=d.asset_code(+)";
            }
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs.getString(1));
                rwsMaster.setLocation(rs.getString(2));
                subCompMetaData.setSubCompDetails(rs.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs.getString(3));
                rwsMaster.setHabName(rs.getString(4));
                rwsMaster.setAssetStatus(rs.getString(5));                
                codes.add(i++, rs.getString(1));
                sources.add(rwsMaster);
            }
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
                qr = "select distinct a.HP_CODE ,a.LOCATION,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and b.pcode=substr (hp_code,13,2) and c.panch_code = substr(a.hp_code,1,16) and substr(hp_code,1,16)='"
                        + habCode
                        + "' and a.asset_code=d.asset_code order by b.pname";
            } else {
                qr = "select distinct a.HP_CODE ,a.LOCATION,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and b.pcode=substr (hp_code,13,2) and c.panch_code = substr(a.hp_code,1,16) and substr(HP_CODE,1,2)='"
                        + circleOfficeCode
                        + "' AND substr(hp_code,6,2)='"
                        + mandalCode
                        + "'  and a.asset_code=d.asset_code order by b.pname";
            }

            stmt1 = conn.prepareStatement(qr);
            rs1 = stmt1.executeQuery();
            while (rs1.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs1.getString(1));
                rwsMaster.setLocation(rs1.getString(2));
                subCompMetaData.setSubCompDetails(rs1.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs1.getString(3));
                rwsMaster.setHabName(rs1.getString(4));
                rwsMaster.setAssetStatus(rs1.getString(5));
                codes.add(i++, rs1.getString(1));
                sources.add(rwsMaster);
            }
            if (rs1 != null) {
                rs1.close();
            }
            if (stmt1 != null) {
                stmt1.close();
            }
            
            
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
            	query = "select distinct SHALLOWHP_CODE,a.LOCATION,b.pname,c.panch_name ,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_SHALLOWHANDPUMPS_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d  where  a.HAB_CODE='"
                        + habCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.asset_code=d.asset_code";
            } else {
                query = "select distinct SHALLOWHP_CODE,a.LOCATION,b.pname,c.panch_name ,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_SHALLOWHANDPUMPS_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d  where  substr(a.HAB_CODE,1,2)='"
                        + circleOfficeCode
                        + "' and substr(a.HAB_CODE,6,2)='"
                        + mandalCode
                        + "' and a.hab_code=c.panch_code and substr(a.HAB_CODE,1,2)=b.dcode and substr(a.hab_code,6,2)=b.mcode and substr(a.hab_code,13,2)=b.pcode and a.asset_code=d.asset_code";
            }

            stmt2 = conn.prepareStatement(query);
            rs2 = stmt2.executeQuery();
            while (rs2.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs2.getString(1));
                rwsMaster.setLocation(rs2.getString(2));

                subCompMetaData.setSubCompDetails(rs2.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs2.getString(3));
                rwsMaster.setHabName(rs2.getString(4));
                rwsMaster.setAssetStatus(rs2.getString(5));
                codes.add(i++, rs2.getString(1));
                sources.add(rwsMaster);
            }
            if (rs2 != null) {
                rs2.close();
            }
            if (stmt2 != null) {
                stmt2.close();
            }
            
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {
               qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and   substr(a.HABITATION_code,1,16)=c.panch_code and a.HABITATION_CODE='"
                        + habCode
                        + "' and a.asset_code = d.asset_code order by b.pname";
            } else {
                  qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and  substr(a.HABITATION_code,1,16)=c.Panch_code and "
                        + "substr(a.HABITATION_CODE,1,2)='"
                        + circleOfficeCode
                        + "' and substr (a.HABITATION_CODE,6,2)='"
                        + mandalCode
                        + "' and a.asset_code=d.asset_code order by b.pname";
            }
            stmt3 = conn.prepareStatement(qr);            
            rs3 = stmt3.executeQuery();
            while (rs3.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs3.getString(1));
                rwsMaster.setLocation(rs3.getString(2));
                subCompMetaData.setSubCompDetails(rs3.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs3.getString(3));
                rwsMaster.setHabName(rs3.getString(4));
                rwsMaster.setAssetStatus(rs3.getString(5));
                codes.add(i++, rs3.getString(1));
                sources.add(rwsMaster);
            }
            if (rs3 != null) {
                rs3.close();
            }
            if (stmt3 != null) {
                stmt3.close();
            }
            
            if (!(habCode == null || habCode == "" || habCode.equals(""))) {               
                qr = "select distinct a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and substr(a.hab_code,1,16)=c.panch_code and a.HAB_CODE ='"
                        + habCode
                        + "' and a.asset_code=d.asset_code order by b.pname";
            } else {                
                qr = "select a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name,decode(d.Asset_status,'1','WORKING','2','NOT WORKING') from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c,rws_asset_mast_tbl d where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and  substr(a.hab_code,1,16)=c.panch_code and substr (a.HAB_CODE,1,2) ='"
                        + circleOfficeCode
                        + "' and substr (a.hab_code,6,2) ='"
                        + mandalCode
                        + "' and a.asset_code=d.asset_code order by b.pname";
            }
            stmt4 = conn.prepareStatement(qr);
            rs4 = stmt4.executeQuery();
            while (rs4.next()) {
                rwsMaster = new RwsMaster();
                rwsMaster.setSourceCode(rs4.getString(1));
                rwsMaster.setLocation(rs4.getString(2));
                subCompMetaData.setSubCompDetails(rs4.getString(1));
                assetTypeCode = subCompMetaData.getTypeOfAssetCode();
                compTypeCode = subCompMetaData.getAssetCompTypeCode();
                subCompTypeCode = subCompMetaData.getAssetSubCompTypeCode();
                sourceTypeName = RwsMasterData.getSourceTypeName(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeCode(assetTypeCode + compTypeCode + subCompTypeCode);
                rwsMaster.setSourceTypeName(sourceTypeName);
                rwsMaster.setPanchName(rs4.getString(4));
                rwsMaster.setHabName(rs4.getString(5));
                rwsMaster.setAssetStatus(rs4.getString(6));
                codes.add(i++, assetTypeCode + compTypeCode + subCompTypeCode);
                sources.add(rwsMaster);
            }
            if (rs4 != null) {
                rs4.close();
            }
            if (stmt4 != null) {
                stmt4.close();
            }
            session.setAttribute("codes", codes);
            
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getSources = "+e.getMessage());
        } finally {
            closeAll();
        }
        return sources;
    }

    public static String getSourceLocation(DataSource dataSource, String sourceCode) throws Exception {
        String location = "";
        SubCompMetaData subCompMetaData = new SubCompMetaData(sourceCode);
        try {
            conn = RwsOffices.getConn();    
            String query = "";
            if ((subCompMetaData.getTypeOfAssetCode().equals("01") || subCompMetaData.getTypeOfAssetCode().equals("02") || subCompMetaData.getTypeOfAssetCode().equals("03")) && (subCompMetaData.getAssetCompTypeCode().equals("01") && !subCompMetaData.getAssetSubCompTypeCode().equals("003"))) {
                if (subCompMetaData.getAssetSubCompTypeCode().equals("001")) {
                    query = "SELECT " + subCompMetaData.getLocationField()
                            + " from " + subCompMetaData.getTableName()
                            + " where " + subCompMetaData.getSchemeCodeField()
                            + "='" + sourceCode + "'";
                } else if (subCompMetaData.getAssetSubCompTypeCode().equals("002")) {
                    query = "SELECT " + subCompMetaData.getLocationField()
                            + " from " + subCompMetaData.getTableName()
                            + " where " + subCompMetaData.getSchemeCodeField()
                            + "='" + sourceCode + "'";
                }
            } else if ((subCompMetaData.getTypeOfAssetCode().equals("04"))) {
                query = "SELECT " + subCompMetaData.getLocationField()
                        + " from " + subCompMetaData.getTableName()
                        + "  where " + subCompMetaData.getSchemeCodeField()
                        + "='" + sourceCode + "'";
            } else {
                query = "SELECT " + subCompMetaData.getLocationField()
                        + " from " + subCompMetaData.getTableName() + " where "
                        + subCompMetaData.getSchemeCodeField() + "='" + sourceCode + "'";
            }
            if (!subCompMetaData.getLocationField().equals("")) {
            	ps = conn.prepareStatement(query);
            	rs = ps.executeQuery();
                while (rs.next()) {
                	location = rs.getString(1);
                }
            }
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData getSourceLocation = "+e.getMessage());
        } finally {
            closeAll();
        }
        return location;
    }

    public static String getWQSourceFinIdenAssetTypeCode(String workCode,
            DataSource dataSource) throws Exception {
        String assetTypeCode = null;
        try {
            //System.out.println("workCode%%%%%%%%%%%%%%%%%%%%%%%%%%%="+workCode);
            conn = RwsOffices.getConn();
            stmt = conn.createStatement();

            rs = stmt
                    .executeQuery("select FIN.*,P.PROPOSAL_NAME  WORK_NAME from RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P where FIN.WORK_ID='"
                            + workCode + "' and P.WORK_ID='" + workCode + "'");
            if (rs.next()) {
                assetTypeCode = rs.getString("TYPE_OF_ASSET_CODE");
            }
        } catch (Exception e) {//Debug.println("Exception in
            // getWQSourceFinIdenAssetTypeCode");

        } finally {
            closeAll();
        }
        return assetTypeCode;
    }

    static String format(String arg) {
        if (arg == null) {
            arg = "";
        }
        return arg;
    }

    public static boolean insertQualityTestResultsTemp(ArrayList results,
            String testId) {
        boolean flag = false;

        try {
            //System.out.println("workCode%%%%%%%%%%%%%%%%%%%%%%%%%%%="+workCode);
            conn = RwsOffices.getConn();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
            WaterSampleTestResLnk ws1 = null;
            WaterSampleTestResLnk w1 = null, w2 = null, w3 = null, w4 = null, w5 = null, w6 = null;
            String qry = "";
            String qry1 = "delete from RWS_QUALITY_RESULTS_TMP_TBL where test_id='"
                    + testId + "'";
            Statement stmt1 = conn.createStatement();
            stmt1.executeUpdate(qry1);
            boolean successFlag = false;
            if (results.size() > 2) {
                w1 = (WaterSampleTestResLnk) results.get(3);
                w2 = (WaterSampleTestResLnk) results.get(4);
                w3 = (WaterSampleTestResLnk) results.get(5);
                w4 = (WaterSampleTestResLnk) results.get(6);
                w5 = (WaterSampleTestResLnk) results.get(9);
                w6 = (WaterSampleTestResLnk) results.get(10);
                if ((w1 != null && !w1.equals(""))
                        && (w2 != null && !w2.equals(""))
                        && (w3 != null && !w3.equals(""))
                        && (w4 != null && !w4.equals(""))
                        && (w5 != null && !w5.equals(""))
                        && (w6 != null && !w6.equals(""))) {
                    successFlag = true;
                }
            } else {
                w1 = (WaterSampleTestResLnk) results.get(0);
                w2 = (WaterSampleTestResLnk) results.get(1);
                if ((w1 != null && !w1.equals(""))
                        && (w2 != null && !w2.equals(""))) {
                    successFlag = true;
                }
            }
            if (successFlag) {
                for (int x = 0; x < results.size(); x++) {
                    ws1 = (WaterSampleTestResLnk) results.get(x);
                    if (ws1.getResult() != null && !ws1.getResult().equals("")) {
                        qry = "insert into RWS_QUALITY_RESULTS_TMP_TBL VALUES('"
                                + ws1.getTestId()
                                + "','"
                                + ws1.getTestPCode()
                                + "','" + ws1.getResult() + "')";
                        //Debug.println("Qry:" + qry);
                        stmt.addBatch(qry);
                    }
                }
                int[] tot = stmt.executeBatch();
                if (tot.length >= 1) {
                    flag = true;
                    conn.setAutoCommit(true);
                    conn.commit();
                } else {
                    conn.rollback();
                }
            }

        } catch (Exception e) {
        } finally {
            try {
                closeAll();
            } catch (Exception e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
        }

        return flag;
    }

    /**
     * @param parameter
     * @return
     */
    public static boolean checkIsExists(String testId) {

        conn = RwsOffices.getConn();
        try {
            stmt = conn.createStatement();
            ResultSet rst = stmt.executeQuery("select test_id from RWS_WQ_TEST_RESULTS_lnk_TBL where test_id='" + testId + "'");

            if (rst.next()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public static DAOMessage insertWaterSampleftktest(RwsWQuality rwsWQuality, DataSource dataSource, String[] phy, String[] che, String[] oth, String[] forward, HttpSession session) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        String ftkid = "";
        String ttype = "";
        WaterSampleForm waterSample = new WaterSampleForm();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        if (rwsWQuality.getTestType().equals("ftk")) {
            ttype = "Y";
        }
        try {
            conn = RwsOffices.getConn();
            String ftklab = rwsWQuality.getFtklab();
            String checkBox1 = "";
            String ftktestid = "";
            String checkQuery = "select FTK_TEST_ID from RWS_FTK_TESTING_TBL where source_code= ? and test_date=to_date( ? ,'dd/mm/yyyy')";            
            PreparedStatement chkStmt = conn.prepareStatement(checkQuery);
            chkStmt.setString(1, rwsWQuality.getSourceCode());
            chkStmt.setString(2, rwsWQuality.getFtkTestDate());
            ResultSet chRs = chkStmt.executeQuery();
            if (chRs.next()) {
                ftkid = chRs.getString(1);
            }            
            rowCount = 0;
            if (ftkid.equals("")) {
                query = "insert into RWS_FTK_TESTING_TBL(SOURCE_CODE ,TEST_DATE ,ARSENIC,NITRATE,FLORIDE,SALINITY,IRON,TURBIDITY,CHLORIDES,"
                        + "MANGANESE,SULPHATES,COPPER ,CALCIUM,TDS,MAGNESIUM,HARDNESS";
                if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",FORWARD_DATE";
                }
                String checkBox = "";
                Collection c = new ArrayList();
                Collection oc = new ArrayList();
                if (che == null) {
                    for (int h = 0; h <= 4; h++) {
                        checkBox += ",'N'";
                    }
                } else {
                    for (int h = 0; h < che.length; h++) {
                        c.add(che[h]);
                    }
                    if (c.contains("Arsenic")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Nitrate")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Fluoride")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Salinity")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Iron")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                }

                if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                    checkBox += ",'Y'";
                } else {
                    checkBox += ",'N'";
                }
                if (oth == null) {
                    for (int h = 0; h <= 7; h++) {
                        checkBox += ",'N'";
                    }
                } else {
                    for (int h = 0; h < oth.length; h++) {
                        c.add(oth[h]);
                    }
                    if (c.contains("Chlorides")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Manganese")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Sulphates")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Copper")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Calcium")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("TDS")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Magnesium")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Hardness")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                }
                query += ",FTK_TEST_ID,SOURCE_TYPE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,FIELD_TEST_CHEMICAL,CONTAMINATION_STATUS) values('"
                        + rwsWQuality.getSourceCode()
                        + "',TO_DATE('"
                        + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                    String forward1 = "Yes";
                    session.setAttribute("forward1", forward);
                    session.setAttribute("forwarded", "YES");

                }
                
                query += checkBox;

                if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",TO_DATE('" + rwsWQuality.getForwardDate() + "','dd/MM/yyyy')";
                }
                query += ",'" + rwsWQuality.getFtktestid() + "','" + rwsWQuality.getSourceType()
                        + "','" + rwsWQuality.getDoc() + "','" + rwsWQuality.getSdoc() + "','"
                        + ttype + "','" + rwsWQuality.getContaminType() + "')";
                
                ps = conn.prepareStatement(query);
                rowCount = rowCount + ps.executeUpdate();
                
                if (rowCount > 0) {
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }

            } else {
                query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE('" +rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                String checkBox = "";
                Collection c = new ArrayList();
                Collection c1 = new ArrayList();
                if (che == null) {
                    checkBox += ",Arsenic='N'";
                    checkBox += ",Nitrate='N'";
                    checkBox += ",Floride='N'";
                    checkBox += ",Salinity='N'";
                    checkBox += ",Iron='N'";
                } else {
                    for (int h = 0; h < che.length; h++) {
                        c.add(che[h]);
                    }
                    if (c.contains("Arsenic")) {
                        checkBox += ",Arsenic='Y'";
                    } else {
                        checkBox += ",Arsenic='N'";
                    }
                    if (c.contains("Nitrate")) {
                        checkBox += ",Nitrate='Y'";
                    } else {
                        checkBox += ",Nitrate='N'";
                    }
                    if (c.contains("Fluoride")) {
                        checkBox += ",Floride ='Y'";
                    } else {
                        checkBox += ",Floride ='N'";
                    }
                    if (c.contains("Salinity")) {
                        checkBox += ",Salinity='Y'";
                    } else {
                        checkBox += ",Salinity='N'";
                    }
                    if (c.contains("Iron")) {
                        checkBox += ",Iron='Y'";
                    } else {
                        checkBox += ",Iron='N'";
                    }
                }

                if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                    checkBox += ",Turbidity='Y'";
                } else {
                    checkBox += ",Turbidity='N'";
                }
               
                if (oth == null) {
                    checkBox += ",Chlorides='N'";
                    checkBox += ",Manganese='N'";
                    checkBox += ",Sulphates='N'";
                    checkBox += ",Copper='N'";
                    checkBox += ",Calcium='N'";
                    checkBox += ",TDS='N'";
                    checkBox += ",Magnesium='N'";
                    checkBox += ",Hardness='N'";
                } else {
                    for (int h = 0; h < oth.length; h++) {
                        c1.add(oth[h]);
                    }
                    if (c1.contains("Chlorides")) {
                        checkBox += ",Chlorides='Y'";
                    } else {
                        checkBox += ",Chlorides='N'";
                    }
                    if (c1.contains("Manganese")) {
                        checkBox += ",Manganese='Y'";
                    } else {
                        checkBox += ",Manganese='N'";
                    }
                    if (c1.contains("Sulphates")) {
                        checkBox += ",Sulphates='Y'";
                    } else {
                        checkBox += ",Sulphates='N'";
                    }
                    if (c1.contains("Copper")) {
                        checkBox += ",Copper='Y'";
                    } else {
                        checkBox += ",Copper='N'";
                    }
                    if (c1.contains("Calcium")) {
                        checkBox += ",Calcium='Y'";
                    } else {
                        checkBox += ",Calcium='N'";
                    }
                    if (c1.contains("TDS")) {
                        checkBox += ",TDS='Y'";
                    } else {
                        checkBox += ",TDS='N'";
                    }
                    if (c1.contains("Magnesium")) {
                        checkBox += ",Magnesium='Y'";
                    } else {
                        checkBox += ",Magnesium='N'";
                    }
                    if (c1.contains("Hardness")) {
                        checkBox += ",Hardness='Y'";
                    } else {
                        checkBox += ",Hardness='N'";
                    }
                }

                query += checkBox + ",FORWARD_DATE=TO_DATE('"
                        + rwsWQuality.getForwardDate()
                        + "','dd/MM/yyyy'),FIELD_TEST_CHEMICAL='" + ttype + "',CONTAMINATION_STATUS='" + rwsWQuality.getContaminType() + "'"
                        + " where source_code='" + rwsWQuality.getSourceCode() + "'"
                        + " and ftk_test_id='" + ftkid + "'";
                ps = conn.prepareStatement(query);                
                rowCount = ps.executeUpdate();
                if (rowCount > 0) {
                    if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                        String forward1 = "Yes";
                        session.setAttribute("forward1", forward);
                        session.setAttribute("forwarded", "YES");
                    }
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }
            }
        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData insertWaterSampleftktest = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            session.setAttribute("forwarded", "NO");
            daoMessage.setOperationSussess(false);
        }
        return daoMessage;
    }

    public static DAOMessage insertWaterSamplefthtest(RwsWQuality rwsWQuality, DataSource dataSource, String[] bat, String[] forward, HttpSession session) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        String ftkid = "";
        String ttype = "";
        WaterSampleForm waterSample = new WaterSampleForm();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }
        if (rwsWQuality.getTestType().equals("fth")) {
            ttype = "Y";
        }
        try {
            conn = RwsOffices.getConn();
            String ftklab = rwsWQuality.getFtklab();
            String checkBox1 = "";
            String ftktestid = "";
            String checkQuery = "select FTK_TEST_ID from RWS_FTK_TESTING_TBL where source_code= ? and test_date=to_date( ? ,'dd/mm/yyyy')";
            PreparedStatement chkStmt = conn.prepareStatement(checkQuery);
            chkStmt.setString(1, rwsWQuality.getSourceCode());
            chkStmt.setString(2, rwsWQuality.getFtkTestDate());
            ResultSet chRs = chkStmt.executeQuery();
            if (chRs.next()) {
                ftkid = chRs.getString(1);
            }
            rowCount = 0;

            if (ftkid.equals("")) {
            	 query = "insert into RWS_FTK_TESTING_TBL(SOURCE_CODE ,TEST_DATE ,COLIFORM ";
            	if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",FORWARD_DATE";
                }
                String checkBox = "";
                Collection c = new ArrayList();
                Collection oc = new ArrayList();
                if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                    checkBox += ",'Y'";
                } else {
                    checkBox += ",'N'";
                }
                query += ",FTK_TEST_ID,SOURCE_TYPE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,H2S_VIAL,CONTAMINATION_STATUS ) values('"
                        + rwsWQuality.getSourceCode()
                        + "',TO_DATE('"
                        + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                    String forward1 = "Yes";
                    session.setAttribute("forward1", forward);
                    session.setAttribute("forwarded", "YES");

                }
                query += checkBox;
                if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",TO_DATE('" + rwsWQuality.getForwardDate()  + "','dd/MM/yyyy')";
                }
                query += ",'" + rwsWQuality.getFtktestid() + "','" + rwsWQuality.getSourceType()
                        + "','" + rwsWQuality.getDoc() + "','"
                        + rwsWQuality.getSdoc() + "','"
                        + ttype + "','"
                        + rwsWQuality.getContaminType() + "')";
                 ps = conn.prepareStatement(query);
                 rowCount = rowCount + ps.executeUpdate();
                if (rowCount > 0) {
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }

            } else {
                query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE('" + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                String checkBox = "";
                Collection c = new ArrayList();
                Collection c1 = new ArrayList();
                if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                    checkBox += ",ColiForm='Y'";
                } else {
                    checkBox += ",ColiForm='N'";
                }
                query += checkBox + ",FORWARD_DATE=TO_DATE('" + rwsWQuality.getForwardDate() + "','dd/MM/yyyy')"
                        + ",H2S_VIAL='" + ttype + "',CONTAMINATION_STATUS='" + rwsWQuality.getContaminType() + "' "
                        + " where source_code='" + rwsWQuality.getSourceCode() + "'"
                        + "and ftk_test_id='" + ftkid + "'";
                ps = conn.prepareStatement(query);
                rowCount = ps.executeUpdate();
                if (rowCount > 0) {
                    if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                        String forward1 = "Yes";
                        session.setAttribute("forward1", forward);
                        session.setAttribute("forwarded", "YES");
                    }
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }               
            }           

        } catch (Exception e) {
        	System.out.println("The exception in RwsWQualityData insertWaterSamplefthtest = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            session.setAttribute("forwarded", "NO");
            daoMessage.setOperationSussess(false);
        }
        return daoMessage;
    }

    public static DAOMessage insertWaterSamplebothtest(RwsWQuality rwsWQuality, DataSource dataSource, String[] phy, String[] che, String[] oth, String[] bat, String[] testtype, String[] forward, HttpSession session) throws Exception {
        DAOMessage daoMessage = new DAOMessage();
        int rowCount = 0;
        String query = "";
        String ftkid = "";
        String ttype = "";
        WaterSampleForm waterSample = new WaterSampleForm();
        if (rwsWQuality.getCoc() == null) {
            rwsWQuality.setCoc("00");
        }
        if (rwsWQuality.getDoc() == null) {
            rwsWQuality.setDoc("0");
        }
        if (rwsWQuality.getSdoc() == null) {
            rwsWQuality.setSdoc("00");
        }

        try {
            conn = RwsOffices.getConn();
            String ftklab = rwsWQuality.getFtklab();
            String checkBox1 = "";
            String ftktestid = "";
            String checkQuery = "select FTK_TEST_ID from RWS_FTK_TESTING_TBL where source_code= ? and test_date=to_date( ? ,'dd/mm/yyyy')";
            PreparedStatement chkStmt = conn.prepareStatement(checkQuery);
            chkStmt.setString(1, rwsWQuality.getSourceCode());
            chkStmt.setString(2, rwsWQuality.getFtkTestDate());
            ResultSet chRs = chkStmt.executeQuery();
            if (chRs.next()) {
                ftkid = chRs.getString(1);
            }
           
            rowCount = 0;

            if (ftkid.equals("")) {
                query = "insert into RWS_FTK_TESTING_TBL(SOURCE_CODE ,TEST_DATE ,ARSENIC,NITRATE,FLORIDE,SALINITY,IRON,TURBIDITY,COLIFORM,CHLORIDES,"
                        + "MANGANESE,SULPHATES,COPPER ,CALCIUM,TDS,MAGNESIUM,HARDNESS,";
                if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",FORWARD_DATE";
                }
                String checkBox = "";
                Collection c = new ArrayList();
                Collection oc = new ArrayList();
                if (che == null) {
                    for (int h = 0; h <= 4; h++) {
                        checkBox += ",'N'";
                    }
                } else {
                    for (int h = 0; h < che.length; h++) {
                        c.add(che[h]);
                    }
                    if (c.contains("Arsenic")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Nitrate")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Fluoride")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Salinity")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Iron")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                }

                if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                    checkBox += ",'Y'";
                } else {
                    checkBox += ",'N'";
                }
                if (bat == null) {
                   for (int h = 0; h <= 4; h++) {
                        checkBox += ",'N'";
                    }
                } else {
                    for (int h = 0; h < bat.length; h++) {
                        c.add(bat[h]);
                    }
                    if (c.contains("ColiForm")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                }
                if (oth == null) {
                    for (int h = 0; h <= 7; h++) {
                        checkBox += ",'N'";
                    }
                } else {
                    for (int h = 0; h < oth.length; h++) {
                        c.add(oth[h]);
                    }
                    if (c.contains("Chlorides")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Manganese")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Sulphates")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Copper")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Calcium")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("TDS")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Magnesium")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                    if (c.contains("Hardness")) {
                        checkBox += ",'Y'";
                    } else {
                        checkBox += ",'N'";
                    }
                }
                if (testtype != null && testtype.length != 0 && !testtype[0].equals("")) {
                    ttype += ",'Y','Y' ";
                } else {
                    ttype += ",'N','N' ";
                }
                query += ",FTK_TEST_ID,SOURCE_TYPE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,FIELD_TEST_CHEMICAL,H2S_VIAL,CONTAMINATION_STATUS) values('"
                        + rwsWQuality.getSourceCode()
                        + "',TO_DATE('"
                        + rwsWQuality.getFtkTestDate() + "','dd/MM/yyyy')";
                if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                    String forward1 = "Yes";
                    session.setAttribute("forward1", forward);
                    session.setAttribute("forwarded", "YES");
                } 
                query += checkBox;
                if (rwsWQuality.getForwardDate() != null && !rwsWQuality.getForwardDate().equals("")) {
                    query += ",TO_DATE('" + rwsWQuality.getForwardDate() + "','dd/MM/yyyy')";
                }
                query += ",'" + rwsWQuality.getFtktestid() + "','" + rwsWQuality.getSourceType()
                        + "','" + rwsWQuality.getDoc() + "','"
                        + rwsWQuality.getSdoc() + "','"
                        + ttype + "','"
                        + rwsWQuality.getContaminType() + "')";
                ps = conn.prepareStatement(query);
                rowCount = rowCount + ps.executeUpdate();
                if (rowCount > 0) {
                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }

            } else {
                query = "update RWS_FTK_TESTING_TBL set TEST_DATE=TO_DATE('"+rwsWQuality.getFtkTestDate()+ "','dd/MM/yyyy')";
                String checkBox = "";
                Collection c = new ArrayList();
                Collection c1 = new ArrayList();
                if (che == null) {
                    checkBox += ",Arsenic='N'";
                    checkBox += ",Nitrate='N'";
                    checkBox += ",Floride='N'";
                    checkBox += ",Salinity='N'";
                    checkBox += ",Iron='N'";
                } else {
                    for (int h = 0; h < che.length; h++) {
                        c.add(che[h]);
                    }
                    if (c.contains("Arsenic")) {
                        checkBox += ",Arsenic='Y'";
                    } else {
                        checkBox += ",Arsenic='N'";
                    }
                    if (c.contains("Nitrate")) {
                        checkBox += ",Nitrate='Y'";
                    } else {
                        checkBox += ",Nitrate='N'";
                    }
                    if (c.contains("Fluoride")) {
                        checkBox += ",Floride ='Y'";
                    } else {
                        checkBox += ",Floride ='N'";
                    }
                    if (c.contains("Salinity")) {
                        checkBox += ",Salinity='Y'";
                    } else {
                        checkBox += ",Salinity='N'";
                    }
                    if (c.contains("Iron")) {
                        checkBox += ",Iron='Y'";
                    } else {
                        checkBox += ",Iron='N'";
                    }
                }
                if (phy != null && phy.length != 0 && !phy[0].equals("")) {
                    checkBox += ",Turbidity='Y'";
                } else {
                    checkBox += ",Turbidity='N'";
                }
                if (bat != null && bat.length != 0 && !bat[0].equals("")) {
                    checkBox += ",COLIFORM='Y'";
                } else {
                    checkBox += ",COLIFORM='N'";
                }
                if (oth == null) {
                    checkBox += ",Chlorides='N'";
                    checkBox += ",Manganese='N'";
                    checkBox += ",Sulphates='N'";
                    checkBox += ",Copper='N'";
                    checkBox += ",Calcium='N'";
                    checkBox += ",TDS='N'";
                    checkBox += ",Magnesium='N'";
                    checkBox += ",Hardness='N'";
                } else {
                    for (int h = 0; h < oth.length; h++) {
                        c1.add(oth[h]);
                    }
                    if (c1.contains("Chlorides")) {
                        checkBox += ",Chlorides='Y'";
                    } else {
                        checkBox += ",Chlorides='N'";
                    }
                    if (c1.contains("Manganese")) {
                        checkBox += ",Manganese='Y'";
                    } else {
                        checkBox += ",Manganese='N'";
                    }
                    if (c1.contains("Sulphates")) {
                        checkBox += ",Sulphates='Y'";
                    } else {
                        checkBox += ",Sulphates='N'";
                    }
                    if (c1.contains("Copper")) {
                        checkBox += ",Copper='Y'";
                    } else {
                        checkBox += ",Copper='N'";
                    }
                    if (c1.contains("Calcium")) {
                        checkBox += ",Calcium='Y'";
                    } else {
                        checkBox += ",Calcium='N'";
                    }
                    if (c1.contains("TDS")) {
                        checkBox += ",TDS='Y'";
                    } else {
                        checkBox += ",TDS='N'";
                    }
                    if (c1.contains("Magnesium")) {
                        checkBox += ",Magnesium='Y'";
                    } else {
                        checkBox += ",Magnesium='N'";
                    }
                    if (c1.contains("Hardness")) {
                        checkBox += ",Hardness='Y'";
                    } else {
                        checkBox += ",Hardness='N'";
                    }
                }
                if (testtype != null && testtype.length != 0 && !testtype[0].equals("")) {
                    ttype += ",FIELD_TEST_CHEMICAL='Y',H2S_VIAL='Y' ";
                } else {
                    ttype += ",FIELD_TEST_CHEMICAL='N',H2S_VIAL='N' ";
                }
                query += checkBox + ",FORWARD_DATE=TO_DATE('"
                        + rwsWQuality.getForwardDate()
                        + "','dd/MM/yyyy')" + ttype + ",CONTAMINATION_STATUS='" + rwsWQuality.getContaminType() + "'"
                        + " where source_code='" + rwsWQuality.getSourceCode() + "'"
                        + " and ftk_test_id='" + ftkid + "'";
                stmt = conn.createStatement();
                rowCount = stmt.executeUpdate(query);
                if (rowCount > 0) {
                    if (forward != null && forward.length != 0 && !forward[0].equals("")) {
                         String forward1 = "Yes";
                        session.setAttribute("forward1", forward);
                        session.setAttribute("forwarded", "YES");

                    }

                    session.setAttribute("forwardedsrcCode", rwsWQuality.getSourceCode());
                    session.setAttribute("forwardedsrcType", rwsWQuality.getSourceType());
                    session.setAttribute("forwardedftkid", ftkid);
                }
                
            }
            
        } catch (Exception e) {
            Debug.println("The Exception is in RwsMasterData insertWaterSamplebothtest = "+e.getMessage());
        } finally {
            closeAll();
        }
        if (rowCount == 1) {
            daoMessage.setMessage("Record Inserted Successfully");
            daoMessage.setOperationSussess(true);

        } else {
            daoMessage.setMessage("Record Cannot be Inserted");
            session.setAttribute("forwarded", "NO");
            daoMessage.setOperationSussess(false);
        }
        return daoMessage;
    }
}
