<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>

<%
    String rDistrict = null, rDistrictName = null, yrcreation = null, yrcreation1 = null, rMdl = null, rMdlName = null;
    Statement stmt1 = null, astStmt = null;
    ResultSet rs1 = null, astRs = null;

    rDistrict = request.getParameter("dcode");
    if (rDistrict != null) {
        session.setAttribute("rDistrict", rDistrict);
    }
    rMdl = request.getParameter("mcode");
    if (rMdl != null) {
        session.setAttribute("rMdl", rMdl);
    }
    rMdlName = request.getParameter("mname");
    if (rMdlName != null) {
        session.setAttribute("rMdlName", rMdlName);
    }
    yrcreation = request.getParameter("yrcreation");
    if (yrcreation != null) {
        session.setAttribute("yrcreation", yrcreation);
    }
    if (yrcreation.equals("00")) {
        yrcreation1 = "ALL";
    }
    rDistrictName = request.getParameter("dname");
    System.out.println(" dist name:" + rDistrictName.length());
    if (rDistrictName != null) {
        session.setAttribute("rDistrictName", rDistrictName);
    }
    if (rDistrictName.length() == 0) {
        rDistrictName = "ALL";
    }
    int numHabs = 0;
    String astCodes = "'01','02','03','04','05','06','07','09'";
    int numAstTypes = 9; //except 8, we will ignore that in logic
        String query = "select count(distinct PANCH_CODE) from rws_complete_hab_view where dcode='"+rDistrict+"' and mcode='"+rMdl+"'";
        stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs1 = stmt1.executeQuery(query);
        if (rs1.next()) {
            numHabs = rs1.getInt(1)+1;
        }
    String array_type_assets[] = {"CPWS","PWS","MPWS","Direct Pumping","Hand Pumps","Shallow Hand Pumps","Open Wells","-","Ponds"};
    HashMap habAstMap = new HashMap();
    HashMap habNameMap = new HashMap();
    
%>
<html>
    <head>
        <title> WaterSoft </title>
            <!-- <script src="/pred/resources/js/jquery-1.10.2.min.js"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
            <script src="/pred/resources/js/jquery-3.6.0.min.js"></script>
            <script type="text/javascript" src="/pred/resources/js/tableExport.js"></script>
            <script type="text/javascript" src="/pred/resources/js/jquery.base64.js"></script>
            <script type="text/javascript" src="/pred/resources/js/sprintf.js"></script>
            <script type="text/javascript" src="/pred/resources/js/jspdf.js"></script>
            <script type="text/javascript" src="/pred/resources/js/base64.js"></script>
            <script type="text/javascript" src="/pred/resources/js/html2canvas.js"></script>
            <style type="text/css">
                .baseTable td {
                    text-align: right !important;
                    padding-right: 10px !important;
                    padding: 6px !important;
                }
                .thead td {
                    text-align: center !important;
                    padding: 6px !important;
                }
				.btext {
					border: 1px solid #777777;
				}
            </style>
        </head>
        <body bgcolor="#edf2f8">
            
            <br/><br/>
            <center>
                <font color="#663899" face="Maiandra GD" size="6px"><b>Asset Abstract</b></font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=rDistrictName%></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <font color="#889900" face="Maiandra GD" size="3px">Mandal: <%=rMdlName%></font>
                <!--font color="#889900" face="Maiandra GD" size="3px">Habitation: </font-->
            </center>

            <table align="center" style="margin-top: -15px !important; width: 600px !important;  text-align: center !important;">
                <tr>
                   <td style="width: 620px !important;text-align: left !important;">
                        <a href="" onClick="$('#exportList').toggle();  return false;"><img height="25px" src="/pred/resources/graphs/export.png"/></a>
                    <td style="width: 80px !important;">
                    <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="25px"/></a></td>
              </tr>
                <tr id="exportList" style="display: none; ">
                    <td colspan="2" style="width: 700px !important;text-align: left !important;">
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'9', pdfColWidth: '29', ignoreColumn: [0],escape:'false',htmlContent:'false',colSpace:[10,29,29,29,29,29,29,30,30]}); return false;">
                        <img height="35px" src="/pred/resources/graphs/pdf.png">
                    </a>&nbsp;
                    <a href="" title="Excel" onClick="$('#tableID').tableExport({type:'excel',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/excel.png">
                    </a>&nbsp;
                    <a href="" title="DOC" onClick="$('#tableID').tableExport({type:'doc',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/doc.png">
                    </a>&nbsp;
                    <a href="" title="CSV" onClick="$('#tableID').tableExport({type:'csv',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/csv.png">
                    </a>&nbsp;
                    <a href="" title="XML" onClick="$('#tableID').tableExport({type:'xml',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/xml.png">
                    </a>&nbsp;
                    <a href="" title="JSON" onClick="$('#tableID').tableExport({type:'json',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/json.png">
                    </a>&nbsp;
                    <a href="" title="SQL" onClick="$('#tableID').tableExport({type:'sql',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/sql.png">
                    </a>&nbsp;
                     <a href="" title="PNG" onClick="$('#tableID').tableExport({type:'png',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/png.png">
                    </a>
                    </td>
                </tr>
            </table>
            <table border = 1 cellspacing = 0 id="tableID" align="center" class="baseTable" cellpadding = 0 height=5% width="600px" bordercolor=#000000 style="border-collapse:collapse; margin-top: 5px !important;" bgcolor="#ffffff" align = "center">	
                
                <%
                try {
                    int habCounter = 0;
                    String astQuery = "select distinct HAB_CODE,INITCAP(LEAD_HABITATION) as LEAD_HABITATION,decode(type_of_asset_code,'01','02','02','03','03','01','09','04','04','05','05','06','06','07','07','09') as type_of_asset_code,count(distinct asset_code),type_of_asset_name from rws_complete_asset_view where type_of_asset_code in (" + astCodes + ") and asset_status not in ('Dried','Condemed') and substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMdl+"' group by LEAD_HABITATION,hab_code,type_of_asset_code,type_of_asset_name order by LEAD_HABITATION";
                    astStmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    astRs = astStmt.executeQuery(astQuery);
                    while (astRs.next()) {
                        if(habAstMap.containsKey(astRs.getString(1)))
                        {
                            long astValues[] = (long[]) habAstMap.get(astRs.getString(1));
                            astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                            habAstMap.put(astRs.getString(1),astValues);
                        }
                        else
                        {
                            long astValues[] = new long[9];
                            astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                            habAstMap.put(astRs.getString(1),astValues);
                            habNameMap.put(astRs.getString(1), astRs.getString(2));
                        }
                        if(habAstMap.containsKey("Total"))
                        {
                            long astValues[] = (long[]) habAstMap.get("Total");
                            astValues[astRs.getInt(3) - 1] += astRs.getLong(4);
                            habAstMap.put("Total",astValues);
                        }
                        else
                        {
                            long astValues[] = new long[9];
                            astValues[astRs.getInt(3) - 1] += astRs.getLong(4);
                            habAstMap.put("Total",astValues);
                            habNameMap.put("Total", "Total");
                        }
                       // array_type_assets[astRs.getInt(3) - 1] = astRs.getString(5);
                    }
            %>
<thead>
            <tr class="thead" align="center" bgcolor="#ffffff">
                <th class=btext style="text-align: left !important; width: 40px !important;">SNO</th>
                <th class=btext >Habitation</th>
                <%
                    for (int j = 0; j < numAstTypes; j++) {
                            // hiding open wells, ponds & others
                        if (j != 7 && j != 6 && j != 8) {
                            %>
                            <th class="btext" align="center" style="width: 100px !important;"><%=array_type_assets[j]%></th>
                            <%
                        }
                    }
                %>
            </tr>
</thead>
<tbody>
            <%
                
                Set keySet = habAstMap.keySet();
                ArrayList list = new ArrayList(keySet);
                Collections.sort(list);
                
                int count=1;
                for(Object key: list)
                {
                    String HabName = habNameMap.get(key).toString();
                    String styleClass;
                    if(key.equals("Total"))
                    {
                        styleClass = "btext";
                        %>
                        <tr> 
                            <td class="<%=styleClass%>" align="center" style="text-align: center !important; border-right: none !important;"></td>
                            <td class="<%=styleClass%>" align="center"style="text-align: center !important; border-left: none !important;">Total</td>
                            <%
                    }
                    else
                    {
                        styleClass = "rptValue";
                        String trSytle="#ffffff";
                        if(count%2==0)
                            trSytle = "#eeeeed";
                         %>
                        <tr style="background-color: <%=trSytle%>;">
                            <td class="<%=styleClass%>" align=left><%=count++%></td>
                            <td class="<%=styleClass%>" align="left" style="text-align: left !important; width: 200px !important; padding-left: 20px !important; font-size: 13px !important;"><%=HabName%></td>
                            <%
                    }
                    for (int j = 0; j < numAstTypes; j++) {
                    // hiding open wells, ponds & others
                        if (j != 7 && j != 6 && j != 8) {
                                if(styleClass.equals("rptValue")&&((long[])habAstMap.get(key))[j]!=0)
                                {
                                %>
                                <td class="<%=styleClass%>" align="right" style="max-width: 100px !important;">
                                    <a href="rws_AssetAbstract_detail_rpt.jsp?dcode=<%=rDistrict%>&yrcreation=<%=yrcreation%>&dname=<%=rDistrictName%>&mcode=<%=rMdl%>&mname=<%=rMdlName%>&hcode=<%=key%>&hname=<%=HabName%>&astCode=<%="0"+j%>"><%=((long[])habAstMap.get(key))[j]%></a>
                                </td>
                                <%
                                }
                                else
                                {
                                %>
                                <td class="<%=styleClass%>" align="right" style="max-width: 100px !important;">
                                    <%=((long[])habAstMap.get(key))[j]%>
                                </td>
                                <%
                                }
                            }
                        }
                }
        }
        catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (astRs != null) {
                astRs.close();
            }
            if (astStmt != null) {
                astStmt.close();
            }
            if (stmt1 != null) {
                stmt1.close();
            }
            if (rs1 != null) {
                rs1.close();
            }
        }
    %>
            </tr>
            </tbody>
        </table>
    <br/>
        <table height="20px" align="center">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
    </body>
</html>
