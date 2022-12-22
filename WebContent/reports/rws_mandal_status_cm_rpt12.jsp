<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>


<%
    Statement st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null, st8 = null;
    ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null;
    ResultSetMetaData rsm = null;
    ResultSet r1 = null, r2 = null, r3 = null, r4 = null, r5 = null, r6 = null, r7 = null, r8 = null;
    int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal = 0, nodatatotal = 0;
    String query = null, a1 = "", query1 = null;

    String district = request.getParameter("district");
    String mandal = request.getParameter("mandal");
    String panchayat = request.getParameter("panchayat");
    String dcode;

    if (district == null) {
        dcode = request.getParameter("dcode");
        session.setAttribute("dcode", dcode);
        String dname = request.getParameter("dname");
        session.setAttribute("dName", dname);
        session.setAttribute("pName", null);
    } else {
        dcode = district;
        session.setAttribute("dcode", dcode);
    }

    String fdate = (String) session.getAttribute("FDate");
    if (fdate != null && !fdate.equals("0")) {
        a1 = " and status_date ='" + fdate + "' ";
    }
    int start = 0, end, limit = 10;
    int Cnt, pgn, tpn;
    int Count = 0, i = 0;

%>


<%    String conqry = "";
    String s = request.getParameter("start");
    String currentYear = null, qq2 = null;
    st7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
//query1="select max( to_char(status_date,'yyyy')) from rws_habitation_directory_tbl h where status_date is not null";
    query1 = "select max( to_char(status_date,'yyyy')) from rws_hab_directory_view h where status_date is not null";
    query1 += a1;
    rs2 = st7.executeQuery(query1);
    while (rs2.next()) {
        currentYear = rs2.getString(1);
    }
    System.out.println("currentYear:" + currentYear);
    System.out.println("fdate" + fdate);
    if (fdate.substring(7, 11).equals(currentYear)) {
        //qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dcode+"'group by d.dcode,d.dname,m.mcode,m.mname order by d.dcode,m.mcode";
        qq2 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_hab_directory_view hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' and substr(HD.hab_code,1,2)='" + dcode + "' group by hv.dcode,hv.dname,hv.mcode,hv.mname order by hv.mcode";
    } else {
        //qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dcode+"'group by d.dcode,d.dname,m.mcode,m.mname order by d.dcode,m.mcode";
        qq2 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_habitation_dir_his_tbl hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' and substr(HD.hab_code,1,2)='" + dcode + "' group by hv.dcode,hv.dname,hv.mcode,hv.mname order by hv.mcode";
    }

    try {
        st6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        System.out.println("qq2:" + qq2);
        rs6 = st6.executeQuery(qq2);
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
            img {
                border: none !important;
            }

        </style>
    </head>
    <body bgcolor="#edf2f8">

                
                <br/><br/>
            <center>
                <font color="#663899" face="Maiandra GD" size="6px"><b>Habitation Coverage - Yearly Status</b></font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">( Status As On : </font><font color="#889900" face="Maiandra GD" size="3px"><%=fdate%> )</font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=session.getAttribute("dName")%></font><br/>
            </center>
    
            <table align="center" style="margin-top: -15px !important; width: 700px !important;  text-align: center !important;">
                <tr>
                   <td style="width: 620px !important;text-align: left !important;">
                        <a href="" onClick="$('#exportList').toggle(); return false;"><img height="25px" src="/pred/resources/graphs/export.png"/></a>
                   <td style="width: 100px !important;">
                    <a href="/pred/rws_login_frm.jsp" ><img src="/pred/resources/graphs/home.png" height="25px"/></a></td>
                    <td style="width: 80px !important;">
                    <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="25px"/></a></td>
              </tr>
                <tr id="exportList" style="display: none; ">
                    <td colspan="2" style="width: 700px !important;text-align: left !important;">
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'8', pdfColWidth: '13', ignoreColumn: [0],escape:'false',pageOrientation: 'p'}); return false;">
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
    <INPUT TYPE="hidden" name="start" value="<%=start%>">
                        <%String st = request.getParameter("start");%>
                
                
                
                
                
                <table border = 1 cellspacing = 0 align="center" cellpadding = 0 width=700px id="tableID"  bordercolor=#000000 class="baseTable" style="border-collapse:collapse; " bgcolor="#ffffff">	
            <thead>
                    <tr class="thead">
                        <td class="btext" style="border-bottom: none !important;"></td> 
                        <td class="btext" style="border-bottom: none !important;border-right: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important; border-left: none !important; border-right: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important; border-left: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important;border-right: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important; border-left: none !important; border-right: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important; border-left: none !important;"></td>
                        <td class="btext" style="border-bottom: none !important;"></td> 
                        <td align="center" class="btext" colspan=9> Habitation Status</td>
                    </tr>
                    <tr>
                        <th class="btext" style="text-align: left !important; width: 30px !important; border-top: none !important;">S.NO.</th>
                        <th class="btext" style="border-top: none !important; border-right: none !important;">Mandal Name</th>
                        <th class="btext" style=" border: none !important;"></th>
                        <th class="btext" style=" border-top: none !important; border-bottom: none !important; border-left: none !important;"></th>
                        <th class="btext" style="border-top: none !important; border-right: none !important;">Constituency</th> 
                        <th class="btext" style="border: none !important;"></th>
                        <th class="btext" style=" border-top: none !important; border-bottom: none !important; border-left: none !important;"></th>
                        <th class="btext" style="border-top: none !important;">Total</th>
                        <th class="btext">FC </th>
                        <th class="btext">PC4 </th>
                        <th class="btext">PC3 </th>
                        <th class="btext">PC2</th>
                        <th class="btext">PC1</th>
                        <th class="btext">NC</th>
                        <th class="btext">NSS</th>
                    </tr>
            </thead>
            <tbody>
                    <tr>
                    <%
                        stmt = conn.createStatement();
                    //System.out.println(" qry:"+qq2);
                        int fcTotal = 0, ncTotal = 0, nssTotal = 0, pc1Total = 0, pc4Total = 0, pc3Total = 0, pc2Total = 0, uiTotal = 0;
                        int slno = 0, total = 0;
                        while (rs6.next()) {

                            ++slno;

                    %>
                    <td class=rptValue><%=slno%></td>

                    <%
                        conqry = "select  constituency_code, INITCAP(constituency_name) as constituency_name from rws_constituency_view where dcode='" + dcode + "' and mcode='" + rs6.getString(3) + "' ";

                        rs = stmt.executeQuery(conqry);
                        String concode = "-", conname = "-";
                        if (rs.next()) {
                            concode = rs.getString(1);
                            conname = rs.getString(2);
            }
            if (concode != null && !concode.equals("-")) {%>
                    <td class="mystyle1" style="text-align: left !important; width: 140px !important; border-right: none !important;">
                        <a href="rws_panch_status_cm_rpt1.jsp?mcode=<%=rs6.getString(3)%>&mname=<%=rs6.getString(4)%>&FDate=<%=fdate%>&dcode=<%=dcode%>&con=<%=conname%>" style="font-size: 13px !important;"><%=rs6.getString(4)%></a></td>
                    <td class="rptValue" style=" border-right: none !important; border-left: none !important;"></td>
                    <td class="rptValue" style="border-bottom: none !important; border-left: none !important;"></td>
                    <td class=rptValue style="text-align: left !important; width: 140px !important; border-right: none !important;"><%=conname%>-<%=concode%></td> 
                    <td class="rptValue" style=" border-right: none !important; border-left: none !important;"></td>
                    <td class="rptValue" style="border-bottom: none !important; border-left: none !important;"></td>
                    <%} else {%>
                    <td class=rptValue style="border-right: none !important;"><a href="rws_panch_status_cm_rpt1.jsp?mcode=<%=rs6.getString(3)%>&mname=<%=rs6.getString(4)%>&FDate=<%=fdate%>&dcode=<%=dcode%>&con=-" style="font-size: 13px !important;"><%=rs6.getString(4)%></a></td> 
                    <td class="rptValue" style=" border: none !important;"></td>
                    <td class="rptValue" style="border-bottom: none !important; border-left: none !important;"></td>
                    <td class=rptValue style="border-right: none !important;">-</td> 
                    <td class="rptValue" style=" border: none !important;"></td>
                    <td class="rptValue" style="border-bottom: none !important; border-left: none !important;"></td>
                    <%}%>
                    <td class=btext align="right"><%=rs6.getInt(12)%></td>
                    <td class=rptValue align="right"><%=rs6.getString(5)%></td>
                    <% fcTotal += rs6.getInt(5);%>
                    <td class=rptValue align="right"><%=rs6.getString(6)%></td>
                    <% pc4Total += rs6.getInt(6);%>
                    <td class=rptValue align="right"><%=rs6.getString(7)%></td>
                    <% pc3Total += rs6.getInt(7);%>
                    <td class=rptValue align="right"><%=rs6.getString(8)%></td>
                    <% pc2Total += rs6.getInt(8);%>
                    <td class=rptValue align="right"><%=rs6.getString(9)%></td>
                    <% pc1Total += rs6.getInt(9);%>
                    <td class=rptValue align="right"><%=rs6.getString(10)%></td>
                    <% ncTotal += rs6.getInt(10);%>
                    <td class=rptValue align="right"><%=rs6.getString(11)%></td>
                    <% nssTotal += rs6.getInt(11); %>

        </tr>
        <%
            }
            rs6.close();

            int grandtotal = 0;
            grandtotal = fcTotal + pc4Total + pc3Total + pc2Total + pc1Total + ncTotal + nssTotal;

        %>

    <tr>
        <td class=btext  align="right" style="border-right: none !important;"></td>
        <td class=btext  align="right" style="border-right: none !important; border-left: none !important;">&nbsp;.&nbsp;</td>
        <td class="btext" style=" border: none !important;"></td>
        <td class="btext" style="border-bottom: none !important; border-left: none !important; border-right: none !important;"></td>
        <td class=btext style="text-align: center !important; border-left: none !important; border-right: none !important;">Grand Total</td>
        <td class="btext" style=" border: none !important;"></td>
        <td class="btext" style="border-bottom: none !important; border-left: none !important;"></td>
        <td class=btext align="right"><%=grandtotal%></td>
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
<%
    } catch (Exception e) {
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
<br/>
</body>
</html>
