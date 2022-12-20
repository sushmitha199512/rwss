<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>


<%
    String rDistrict = null, rDistrictName = null, yrcreation = null, yrcreation1 = null;
    Statement stmt1 = null, astStmt = null;
    ResultSet rs1 = null, astRs = null;
    
    int numDists = 0;
    int numAstTypes = 9; //except 8, we will ignore that in logic
    
        String query = "select count(distinct dcode) from rws_complete_hab_view";
        stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        rs1 = stmt1.executeQuery(query);
        if (rs1.next()) {
            numDists = rs1.getInt(1)+1;
        }
    
    //String array_type_assets[] = new String[numAstTypes];
    String array_type_assets[] = {"CPWS","PWS","MPWS","Direct Pumping","Hand Pumps","Shallow Hand Pumps","Open Wells","-","Ponds"};
    String array_dist[] = new String[numDists];
    long array_all[][] = new long[numDists][numAstTypes];
    String astCodes = "'01','02','03','04','05','06','07','09'";
    
    HashMap distAstMap = new HashMap();
    HashMap distNameMap = new HashMap();

    rDistrict = "00";//request.getParameter("rDistrict");
    if (rDistrict != null) {
        session.setAttribute("rDistrict", rDistrict);
    }
    yrcreation = "00";//request.getParameter("yrcreation");
    if (yrcreation != null) {
        session.setAttribute("yrcreation", yrcreation);
    }
    if (yrcreation.equals("00")) {
        yrcreation1 = "ALL";
    }
//// // System.out.println("yrcr:"+yrcreation);
    rDistrictName = "ALL";//request.getParameter("rDistrictName");
    System.out.println(" dist name:" + rDistrictName.length());
    if (rDistrictName != null) {
        session.setAttribute("rDistrictName", rDistrictName);
    }
    if (rDistrictName.length() == 0) {
        rDistrictName = "ALL";
    }
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
                    <font color="#889900" face="Maiandra GD" size="3px">Year: <%=yrcreation1%></font>
            </center>
        
        <table align="center" style="margin-top: -25px !important; width: 600px !important;  text-align: center !important;">
                <tr>
                    <td style="width: 620px !important;text-align: left !important;">
                        <a href="" onClick="$('#exportList').toggle(); return false;"><img height="25px" src="/pred/resources/graphs/export.png"/></a></td>
                    <td style="width: 40px !important; text-align: right !important;">
                    <a href="/pred/resources/graphs/astGraphView.jsp?dcode=00&mode=Bar" target="_blank" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a></td>
                    <td style="width: 40px !important; text-align: right !important">
                    <a href="/pred/resources/graphs/astGraphView.jsp?dcode=00&mode=Pie" target="_blank" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/pie.png"></a></td>
                </tr>
                <tr id="exportList" style="display: none; ">
                    <td colspan="2" style="width: 700px !important;text-align: left !important;">
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'9', pdfColWidth: '29', ignoreColumn: [0],escape:'false',htmlContent:'false',colSpace:[10,29,29,29,29,29,29,30,30]});  return false;">
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
        
        
            <table border = 1 cellspacing = 0 class="baseTable" id="tableID" align="center" cellpadding = 0 height=5% width="600px" bordercolor=#000000 style="border-collapse:collapse; margin-top: 5px !important;" bgcolor="#ffffff" align = "center">	

            <%
                try {
                    array_dist[0] = "ALL";
                    distNameMap.put("00", "ALL");
                    //String astQuery = "select substr(hab_code,1,2) as dcode,INITCAP(dname) as dname,type_of_asset_code,count(distinct asset_code),type_of_asset_name from rws_complete_asset_view where type_of_asset_code in (" + astCodes + ") group by dname,substr(hab_code,1,2),type_of_asset_code,type_of_asset_name order by dcode";
                    String astQuery = "select substr(hab_code,1,2) as dcode,INITCAP(dname) as dname,decode(type_of_asset_code,'01','02','02','03','03','01','09','04','04','05','05','06','06','07','07','09') as type_of_asset_code,count(distinct asset_code),type_of_asset_name from rws_complete_asset_view where type_of_asset_code in (" + astCodes + ") and asset_status not in ('Dried','Condemed') group by dname,substr(hab_code,1,2),type_of_asset_code,type_of_asset_name order by dcode";
                    //String astQuery = "select substr(hab_code,1,2) as dcode,dname,type_of_asset_code,count(distinct b.asset_code),type_of_asset_name from rws_complete_asset_view a, rws_asset_scheme_tbl b  where a.asset_code=b.asset_code and type_of_asset_code in (" + astCodes + ") group by dname,substr(hab_code,1,2),type_of_asset_code,type_of_asset_name order by dcode";
                    astStmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    astRs = astStmt.executeQuery(astQuery);
                    while (astRs.next()) {
                        
                        if(distAstMap.containsKey(astRs.getString(1)))
                        {
                            long astValues[] = (long[]) distAstMap.get(astRs.getString(1));
                            astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                            distAstMap.put(astRs.getString(1),astValues);
                        }
                        else
                        {
                            long astValues[] = new long[9];
                            astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                            distAstMap.put(astRs.getString(1),astValues);
                            distNameMap.put(astRs.getString(1), astRs.getString(2));
                        }
                        if(distAstMap.containsKey("Total"))
                        {
                            long astValues[] = (long[]) distAstMap.get("Total");
                            astValues[astRs.getInt(3) - 1] += astRs.getLong(4);
                            distAstMap.put("Total",astValues);
                        }
                        else
                        {
                            long astValues[] = new long[9];
                            astValues[astRs.getInt(3) - 1] += astRs.getLong(4);
                            distAstMap.put("Total",astValues);
                            distNameMap.put("Total", "Total");
                        }
                        
//                        array_all[astRs.getInt(1) - 1][astRs.getInt(3) - 1] = astRs.getLong(4);
//                        array_dist[astRs.getInt(1)] = astRs.getString(2);
//                        //array_type_assets[astRs.getInt(3) - 1] = astRs.getString(5);
//                        //array_totals[astRs.getInt(3) - 1] += astRs.getLong(4);
//                        array_all[numDists-1][astRs.getInt(3) - 1] += astRs.getLong(4);
                    }
            %>
<thead>
            <tr class="thead" align="center" bgcolor="#ffffff">
                <th class=btext style="text-align: left !important; width: 30px !important;">SNO</th>
                <th class=btext >District</th>
                <%
                    for (int j = 0; j < numAstTypes; j++) {
                        // hiding open wells, ponds & others
                        if (j != 7 && j != 6 && j != 8) {
                            %>
                            <th class="btext" align="center"><%=array_type_assets[j]%></th>
                            <%
                        }
                    }
                %>
            </tr>
</thead>
<tbody>
            <%
                
                Set keySet = distAstMap.keySet();
                ArrayList list = new ArrayList(keySet);
                Collections.sort(list);
                
                int count=1;
                for(Object key: list)
                {
                    String DistName = distNameMap.get(key).toString();
//                    String distNameOrg = distNameMap.get(key).toString();
//                    distNameOrg = distNameOrg.replace("  ", " ");
//                    String distNameSplit[] = distNameOrg.split(" ");
//                    String DistName = "";//habNameOrg.substring(0, 1).toUpperCase() + habNameOrg.substring(1).toLowerCase();
//                    for(int x=0;x<distNameSplit.length;x++)
//                    {
//                        DistName += distNameSplit[x].substring(0, 1).toUpperCase() + distNameSplit[x].substring(1).toLowerCase()+" ";
//                    }
                    String styleClass;
                    if(key.equals("Total"))
                    {
                        styleClass = "btext";
                        %>
                        <tr> 
                            <td class="<%=styleClass%>" align="center" style="text-align: center !important; border-right: none !important;"></td>
                            <td class="<%=styleClass%>" align="center" style="text-align: center !important; border-left: none !important;">Total</td>
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
                            <td class="<%=styleClass%>" align="left" style="text-align: left !important; width: 200px !important; padding-left: 20px !important;">
                                <a href="rws_AssetAbstract_mandal_cm_rpt.jsp?dcode=<%=key%>&yrcreation=<%=yrcreation%>&rDistrictName=<%=DistName%>" style="font-size: 13px !important;"><%=DistName%></a>
                            </td>
                            <%
                    }
                    for (int j = 0; j < numAstTypes; j++) {
                    // hiding open wells, ponds & others
                        if (j != 7 && j != 6 && j != 8) { 
                            %>
                            <td class="<%=styleClass%>" align="right" style="max-width: 100px !important;"><%=((long[])distAstMap.get(key))[j]%></td>
                            <%
                            }
                        }
                }
                long[] totInputs = (long[]) distAstMap.get("Total");
                distAstMap.put("00", totInputs);
                distAstMap.remove("Total");
                distNameMap.remove("Total");
            session.setAttribute("assetMap", distAstMap);
            session.setAttribute("distMap", distNameMap);
            session.setAttribute("assetTypes", array_type_assets);
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
