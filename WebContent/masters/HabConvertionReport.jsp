<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%System.out.println("in HabConvertionReport.jsp"); %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
.style4 {font-family: Verdana; font-size: 12px; }
.style9 {font-family: Verdana; font-size: 12px; font-weight: bold; }
.style11 {font-family: Verdana; font-size: 14px; font-weight: bold; color: #FFFFFF; }
.blinkytext {
     font-family: Arial, Helvetica, sans-serif;
     font-size: 1.2em;
     text-decoration: blink;
     font-style: normal;
 }
-->
</style>
</head>
<%
int[] report = (int[])session.getAttribute("report");
if(report!=null && report.length>0)
{
System.out.println("report length:"+report.length);
for(int j=0;j<report.length;j++)
{
//System.out.println(""+report[j]);
}
String iter = (String)session.getAttribute("iter");
System.out.println("Iter:"+iter);
int iter1 = Integer.parseInt(iter);
//minus 2
%>
<body>
<p align="center"><a href="#" onclick="window.close()"><font face=verdana size=3 color=red><b>Close Window</b></font></a></p>
<p>
<font color=red face=verdana size=2>
Note:*** 1. Once Exception Occured, No table is updated.
</font>
</p>
<table width="508" border="1">
  <tr>
    <td width="295" align="center" bgcolor="#000000"><span class="style11">Table</span></td>
    <td width="197"  align="center" bgcolor="#000000" class="style4"><span class="style11">Action Taken </span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style4"><strong>Habitation Related Tables </strong></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HABITATION_DIRECTORY_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==0){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[0]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_SUPPLY_STATUS_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==3){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[3]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_INSTITUTE_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==4){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[4]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">TEMPSELECTEDHABS_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==5){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[5]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_DIR_40_CREATED_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==6){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[6]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_CONTAMINATION_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==7){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[7]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SOURCE_CONTAMINATION_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==8){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[8]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_QUAN_QUAL_STAT_TBL</span></td>
    <td class="style4"><span class="style4">
    <%if(iter1+2==9){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[9]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_LPCD_CHECK_STATUS_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==10){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[10]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_DIR_40PERCENT_TBL_PREV</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==11){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[11]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_DIR_40PERCENT_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==12){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[12]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HABS_UI_NULL_DELETED_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==13){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[13]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style9">Asset Related Tables </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_ASSET_MAST_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==14){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[14]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_ASSET_SCHEME_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==15){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[15]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_ASSET_SOURCE_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==16){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[16]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_ASSET_HAB_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==17){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[17]+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_WTP_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==18 || iter1+2==19){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[18]+report[19])+" Records Updated");%></td>
  </tr>
  
  <tr>
    <td><span class="style4">RWS_AST_WATCHMAN_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==20 || iter1+2==21){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[20]+report[21])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_SUMP_M_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==22){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[22]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_BPT_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==23){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[23]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_SUMP_M_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==24){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[24]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_SUBCOMP_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==25 || iter1+2==26){out.println("<img src=../images/exceptions.gif>");}else out.println((report[25]+report[26])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_SS_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==27 || iter1+2==28){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[27]+report[28])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_RW_COLLWELL_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==29 || iter1+2==30){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[29]+report[30])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_PUMP_DET_SC_PARAM_TBL</span></td>
    <td class="style4"><p class="style4"><%if(iter1+2==31){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[31]+" Records Updated");%></p>    </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PUMPINGMAIN_PIPES_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==32){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[32]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PUMPINGMAIN_PIPES</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==33){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[33]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PONDS_MST_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==34 || iter1+2==35){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[34]+report[35])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HAB_COMPONENT_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==37){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[37]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SOURCE_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==37 || iter1+2==38){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[37]+report[38])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SOURCE_HABITATION_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==39 || iter1+2==40){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[39]+report[40])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SHALLOWHANDPUMPS_TBL</span></td>
    <td class="style4"><%if(iter1+2==41 || iter1+2==42){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[41]+report[42])+" Records Updated");%></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_OHSR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==43){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[43]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_OHBR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==44 || iter1+2==45){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[44]+report[45])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_OANDM_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==46){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[46]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_GRAVITYMAIN_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==47 || iter1+2==48){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[47]+report[48])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_GLSR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==49 || iter1+2==50){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[49]+report[50])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_GLBR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==51 || iter1+2==52){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[51]+report[52])+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_FP_BRIDGE_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==53 || iter1+2==54){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[53]+report[54])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_DISTRI_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==55 || iter1+2==56){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[55]+report[56])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_DISTRIB_PIPES_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==57){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[57]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_DISTRIB_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==58){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[58]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_PUMPINGMAIN_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==59 || iter1+2==60){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[59]+report[60])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_PUMPHOUSE_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==61 || iter1+2==62){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[61]+report[62])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_PM_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==63){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[63]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_PM_NOOFPIPES_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==64){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[64]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_OTHERS_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==65 || iter1+2==66){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[65]+report[66])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_OHSR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==67){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[67]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_OHGLCI_HAB_LINK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==68 || iter1+2==69){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[68]+report[69])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PWS_SP_HC_PC_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==70){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[70]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_CW_COLLWELL_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==71 || iter1+2==72){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[71]+report[72])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_CP_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==73){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[73]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_CIS_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==74 || iter1+2==75){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[74]+report[75])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_CHLORINATION_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==76 || iter1+2==77){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[76]+report[77])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_AST_BPT_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==78){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[78]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DWTANK_MST_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==79 || iter1+2==80){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[79]+report[80])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_OPEN_WELL_MAST_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==81 || iter1+2==82){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[81]+report[82])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_OPENWELL_POND_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==83 || iter1+2==84){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[83]+report[84])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_GRAVITYMAIN_PIPES_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==85){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[85]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HP_SUBCOMP_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==86){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[86]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_HANDPUMPS_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==87){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[87]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DISTRIBUTION_PIPES_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==88 || iter1+2==89){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println((report[88]+report[89])+" Records Updated");%>
</span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_GLSROHSROHBR_SC_PARAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==90){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[90]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style9">Works Related Tables </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_WORK_ADMN_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==91){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[91]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_ADMN_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==92){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[92]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_REV_ADM_SANC_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==93){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[93]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_NEW_REVISED_EST_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==94){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[94]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_EST_NEW_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==95){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[95]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_REV_EST_NEW_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==96){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[96]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SOURCE_IDEN_FIN_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==97){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[97]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SOURCE_IDEN_FIN_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==98){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[98]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_WORK_COMP_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==99){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[99]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PRAJAPADAM_EXIST_SCH_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==100){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[100]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_TEMP_PROPOSAL_HAB_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==101){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[101]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_TEMP_OM_PROPOSAL_HAB_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==102){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[102]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_OM_PROPOSAL_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==103){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[103]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DDWS_WORKS_MPR_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==104){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[104]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_REP_PROPOSAL_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==105){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[105]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PROPOSAL_HL_MIRROR_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==106){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[106]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PROPOSAL_HAB_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==107){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[107]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_PRAJAPADAM_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==108){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[108]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style9">School Related Tables </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SCHOOL_MASTER_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==109){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[109]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_SCHOOL_ASSET_LNK_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==110){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[110]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DDWS_SCHOOLS_MPR_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==111){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[111]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style9">Water Quality Related Tables </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_WATER_SAMPLE_COLLECT_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==112){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[112]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_WATER_SAMPLE_COLLECT_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==113){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[113]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_WQ_TEST_RESULTS_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==114){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[114]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_FTK_TESTING_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==115){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[115]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td colspan="2"  align="center" bgcolor="#CCCCCC" class="style9">Drought Related Tables </td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DROUGHT_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==116){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[116]+" Records Updated");%></span></td>
  </tr>
  <tr>
    <td><span class="style4">RWS_DROUGHT_EXIST_SCH_TBL</span></td>
    <td class="style4"><span class="style4"><%if(iter1+2==117){out.println("<font color=red><strong>Exception Occured</strong></font>");}else out.println(report[117]+" Records Updated");%></span></td>
  </tr>
</table>
<%}
else
{
 %>
 <table width="508" border="0">
  <tr>
    <td align="center" bgcolor="#000000"><span class="style11">No Habitation Converted Yet</span></td>
  </tr>
 </table>
 <%} %>
</body>
</html>
