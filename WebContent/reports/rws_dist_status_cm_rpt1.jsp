<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "conn.jsp" %>

<%
    HashMap mapDistInputs = new HashMap();
    String distInputStr = "";
    HashMap mapCovInputs = new HashMap();
    HashMap mapDistDet = new HashMap();
    
    session.setAttribute("dName", "ALL");
    session.setAttribute("dCode", "51");
    session.setAttribute("mName", null);
    session.setAttribute("mCode", "0");
    session.setAttribute("pName", null);
    session.setAttribute("pCode", "0");
    String fdate = "";
    
    
    Statement stmtt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
//ResultSet rss=stmtt.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_habitation_directory_tbl");
    ResultSet rss = stmtt.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_hab_directory_view");
    while (rss.next()) {
        fdate = rss.getString(1);
    }
    session.setAttribute("FDate", fdate);
    
    Statement st6 = null, st7 = null;
    ResultSet rs6 = null, rs2 = null;
    String query1 = null, qu1 = null;
    
    String district = request.getParameter("district");
    String mandal = request.getParameter("mandal");
    String panchayat = request.getParameter("panchayat");
    String dCode = String.valueOf(session.getAttribute("dCode"));
    String mCode = String.valueOf(session.getAttribute("mCode"));
    String pCode = String.valueOf(session.getAttribute("pCode"));
    String tdate = request.getParameter("TDate");
    int start = 0;
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
                <font color="#663899" face="Maiandra GD" size="6px"><b>Habitation Coverage - Yearly Status</b></font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">( Status As On : </font><font color="#889900" face="Maiandra GD" size="3px"><%=fdate%> )</font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=session.getAttribute("dName")%></font>
            </center>
    
            <table align="center" style="margin-top: -30px !important; width: 700px !important;  text-align: center !important;">
                <tr>
                   <td style="width: 620px !important;text-align: left !important;">
                        <a href="" onClick="$('#exportList').toggle(); return false;"><img height="25px" src="/pred/resources/graphs/export.png"/></a>
                   <td style="width: 100px !important;">
                    <a href="/pred/rws_login_frm.jsp" ><img src="/pred/resources/graphs/home.png" height="25px"/></a></td>
                    <td style="width: 40px !important;">
                    <a href="/pred/resources/graphs/graphView.jsp?dcode=00&mode=Bar" target="_blank" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a></td>
                    <td style="width: 40px !important;">
                    <a href="/pred/resources/graphs/graphView.jsp?cov=FC&dcode=00&mode=Pie" target="_blank" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/pie.png"></a></td>
                </tr>
                <tr id="exportList" style="display: none;">
                    <td colspan="3" style="width: 700px !important;text-align: left !important;">
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'10',ignoreColumn: [0],escape:'false',pageOrientation: 'p'}); return false;">
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
                    <a href="" title="SQL" onClick="$('#tableID').tableExport({type:'sql',ignoreColumn: [0,2],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/sql.png">
                    </a>&nbsp;
                     <a href="" title="PNG" onClick="$('#tableID').tableExport({type:'png',ignoreColumn: [0],escape:'false'}); return false;">
                        <img height="35px" src="/pred/resources/graphs/png.png">
                    </a>&nbsp;
                    <br/>
                    </td>
                </tr>
            </table>
    <INPUT TYPE="hidden" name="start" value="<%=start%>">
                        <%String st = request.getParameter("start");%>
                        <table border = 1 cellspacing = 0 cellpadding = 0 align="center" id="tableID" width="700px"  bordercolor=#000000 class="baseTable" style="border-collapse:collapse" bgcolor="#ffffff">	
                            <thead>                    
                            <tr class="thead">
                                <td class="btext" style="border-bottom: none !important;"></td> 
                                <td class="btext" style="border-bottom: none !important; border-right: none !important;"></td> 
                                <td class="btext" style="border-bottom: none !important; border-left: none !important;"></td>
                                <td class="btext" style="border-bottom: none !important;"></td> 
                                <td align="center" class="btext" colspan=9> Habitation Status</td> 
                            </tr>
                                <tr>
                                     <th class="btext" style="text-align: left !important; width: 30px !important; border-top: none !important;">SNO</th>
                                    <th class="btext" style="border-top: none !important; border-right: none !important;">District Name</th> 
                                    <th class="btext" style="border-top: none !important; border-left: none !important;"></th> 
                                    <th class="btext" style="border-top: none !important;">Total</th> 
                                    <th class="btext">FC </th>
                                    <th class="btext">PC4 </th>
                                    <th class="btext">PC3 </th>
                                    <th class="btext">PC2</th>
                                    <th class="btext">PC1 </th>
                                    <th class="btext">NC </th>
                                    <th class="btext">NSS </th>
                                </tr>
                            </thead>
                        <tbody>
                            <tr>
                            <%
                                String s = request.getParameter("start");
                                String currentprevYear = null, currentYear = null;
                                try {
                                    mapDistDet.put("00", "ALL");
                                    st6 = conn.createStatement();
                                    st7 = conn.createStatement();
                                    //query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
                                    query1 = "select distinct to_char(status_date,'yyyy') from rws_hab_directory_view h where status_date is not null";
                                    //rs2=st7.executeQuery("select distinct to_char(h.status_date,'dd-MON-yyyy'), to_date(h.status_date,'dd-mm-yyyy')from rws_habitation_dir_his_tbl h where h.status_date is not null Union select distinct to_char(h1.status_date,'dd-MON-yyyy'),to_date(h1.status_date,'dd-mm-yyyy') from rws_habitation_directory_tbl h1 where h1.status_date is not null order by 2 desc");
                                    rs2 = st7.executeQuery("select distinct to_char(h.status_date,'dd-MON-yyyy'), to_date(h.status_date,'dd-mm-yyyy')from rws_habitation_dir_his_tbl h where h.status_date is not null Union select distinct to_char(h1.status_date,'dd-MON-yyyy'),to_date(h1.status_date,'dd-mm-yyyy') from rws_hab_directory_view h1 where h1.status_date is not null order by 2 desc");
                                    currentYear = "";
                                    while (rs2.next()) {
                                        currentYear = currentYear + "@" + rs2.getString(1);
                                    }
                                    String values[] = currentYear.split("@");

                                    java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
                                    java.util.Date currentDate = new java.util.Date();
                                    currentYear = dateFormat.format(currentDate).substring(0, 4);
                                    java.util.Date currentMinus1Y = new java.util.Date(currentDate.getTime());
                                    currentMinus1Y.setYear(currentMinus1Y.getYear() - 1);
                                    currentprevYear = dateFormat.format(currentMinus1Y).substring(0, 4);
                                    if (values[1].substring(7, 11).equals(fdate.substring(7, 11))) {
                                        qu1 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_hab_directory_view hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' group by hv.dcode,hv.dname order by hv.dcode";
                                    } else {
                                        qu1 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_habitation_dir_his_tbl hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' group by hv.dcode,hv.dname order by hv.dcode";
                                    }
                                    System.out.print("q1:" + qu1);
                                    rs6 = st6.executeQuery(qu1);
                                    int fcTotal = 0, ncTotal = 0, nssTotal = 0, pc1Total = 0, pc4Total = 0, pc3Total = 0, pc2Total = 0, uiTotal = 0;
                                    int slno = 0, total = 0;

                                    String distInputsFC = "";
                                    String distInputsPC ="";
                                    String distInputsPC4 = "";
                                    String distInputsPC3 = "";
                                    String distInputsPC2 = "";
                                    String distInputsPC1 = "";
                                    String distInputsNC = "";
                                    String distInputsNSS = "";

                                    while (rs6.next()) {
                                        ++slno;

                                        distInputStr += "[" + rs6.getString(3) + "," + (rs6.getInt(4) + rs6.getInt(5) + rs6.getInt(6) + rs6.getInt(7) + rs6.getInt(8)) + "," + rs6.getString(9) + "],";
                                        
                                        distInputsFC += "[" + rs6.getString(3) + "],";
                                        distInputsPC4 += "[" + rs6.getString(4) + "],";
                                        distInputsPC3 += "[" + rs6.getString(5) + "],";
                                        distInputsPC2 += "[" + rs6.getString(6) + "],";
                                        distInputsPC1 += "[" + rs6.getString(7) + "],";
                                        distInputsNC += "[" + rs6.getString(8) + "],";
                                        distInputsPC += "[" + (rs6.getInt(4) + rs6.getInt(5) + rs6.getInt(6) + rs6.getInt(7) + rs6.getInt(8)) + "],";
                                        distInputsNSS += "[" + rs6.getString(9) + "],";
                                                        
                                        mapDistDet.put(rs6.getString(1), rs6.getString(2));

                                        String covInputs = "[" + rs6.getString(3) + "],[" + rs6.getString(4) + "],[" + rs6.getString(5) + "],[" + rs6.getString(6) + "],[" + rs6.getString(7) + "],[" + rs6.getString(8) + "],[" + rs6.getString(9) + "]";
                                        mapCovInputs.put(rs6.getString(1), covInputs);

                            %>
                            <td class=rptValue><%=slno%></td>
                            <td class="mystyle1" style="text-align: left !important; width: 140px !important; border-right: none !important;">
                                <a href="rws_mandal_status_cm_rpt12.jsp?dcode=<%=rs6.getString(1)%>&dname=<%=rs6.getString(2)%>&FDate=<%=fdate%>" style="font-size: 13px !important;"><%=rs6.getString(2)%></a></td>
                            <td class="rptValue" style="border-left: none !important;"></td> 
                            <td class=btext align="right"><%=rs6.getInt(10)%></td>
                            <td class=rptValue align="right"><%=rs6.getString(3)%></td>
                            <% fcTotal += rs6.getInt(3);%>
                            <td class=rptValue align="right"><%=rs6.getString(4)%></td>
                            <% pc4Total += rs6.getInt(4);%>
                            <td class=rptValue align="right"><%=rs6.getString(5)%></td>
                            <% pc3Total += rs6.getInt(5);%>
                            <td class=rptValue align="right"><%=rs6.getString(6)%></td>
                            <% pc2Total += rs6.getInt(6);%>
                            <td class=rptValue align="right"><%=rs6.getString(7)%></td>
                            <% pc1Total += rs6.getInt(7);%>
                            <td class=rptValue align="right"><%=rs6.getString(8)%></td>
                            <% ncTotal += rs6.getInt(8);%>
                            <td class=rptValue align="right"><%=rs6.getString(9)%></td>
                            <% nssTotal += rs6.getInt(9); %>
                </tr>
                <%}
                    mapDistInputs.put("FC", distInputsFC.substring(0, distInputsFC.length() - 1));
                    mapDistInputs.put("PC", distInputsPC.substring(0, distInputsPC.length() - 1));
                    mapDistInputs.put("PC4", distInputsPC4.substring(0, distInputsPC4.length() - 1));
                    mapDistInputs.put("PC3", distInputsPC3.substring(0, distInputsPC3.length() - 1));
                    mapDistInputs.put("PC2", distInputsPC2.substring(0, distInputsPC2.length() - 1));
                    mapDistInputs.put("PC1", distInputsPC1.substring(0, distInputsPC1.length() - 1));
                    mapDistInputs.put("NC", distInputsNC.substring(0, distInputsNC.length() - 1));
                    mapDistInputs.put("NSS", distInputsNSS.substring(0, distInputsNSS.length() - 1));

                    String totInputs = "[" + fcTotal + "],[" + pc4Total + "],[" + pc3Total + "],[" + pc2Total + "],[" + pc1Total + "],[" + ncTotal + "],[" + nssTotal + "]";

                    mapCovInputs.put("00", totInputs);

                    rs6.close();
                    int grandtotal = 0;
                    grandtotal = fcTotal + pc4Total + pc3Total + pc2Total + pc1Total + ncTotal + nssTotal;

                    String statePie = "[[\"FC\", "+fcTotal+"],[\"PC\", "+(pc4Total + pc3Total + pc2Total + pc1Total + ncTotal)+"],[\"NSS\", "+nssTotal+"]]";

                    distInputStr = distInputStr.substring(0, distInputStr.length() - 1);

                    session.setAttribute("distInputMap", mapDistInputs);
                    session.setAttribute("distInputStr", distInputStr);
                    session.setAttribute("covInputs", mapCovInputs);
                    session.setAttribute("distInfo", mapDistDet);
                    session.setAttribute("statePie", statePie);
                %>
                </tr>
                <tr>
                    <td class=btext  align="right" style="border-right: none !important;"></td>
                    <td class=btext style="text-align: center !important; border-left: none !important; border-right: none !important;">Grand Total</td>
                    <td class="btext" style="border-left: none !important;"></td> 
                    <td class=btext  align="right"><%=grandtotal%></td>
                    <td class=btext align="right"><%=fcTotal%></td>
                    <td class=btext align="right"><%=pc4Total%></td>
                    <td class=btext align="right"><%=pc3Total%></td>
                    <td class=btext align="right"><%=pc2Total%></td>
                    <td class=btext align="right"><%=pc1Total%></td>
                    <td class=btext align="right"><%=ncTotal%></td>
                    <td class=btext align="right"><%=nssTotal%></td>
                </tr>
                </tbody>
            </table>
            <%} catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    conn.close();
                }
            %>
<br/>
        <table height="20px" align="center">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.gov.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
</body>
</html>
