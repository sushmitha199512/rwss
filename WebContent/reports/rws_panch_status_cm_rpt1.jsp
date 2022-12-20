
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
    String dCode;
    String mCode;
    String con = request.getParameter("con");

    if (district == null && mandal == null) {
        //dCode=String.valueOf(session.getAttribute("dcode"));
        dCode = request.getParameter("dcode");
        mCode = request.getParameter("mcode");
        session.setAttribute("mCode", mCode);
        String mname = request.getParameter("mname");
        session.setAttribute("mName", mname);

    } else {
        dCode = district;
        mCode = mandal;
    }

    String fdate = (String) session.getAttribute("FDate");
    int start = 0, end, limit = 10;
    int Cnt, pgn, tpn;

%>

<%    int Count = 0, i = 0;
// System.out.println("coount of rows is    ");
    try {

        if (fdate != null && !fdate.equals("0")) {
            a1 = " and status_date ='" + fdate + "' ";
        }
        String currentYear = null, qq2 = null;
        st7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        query1 = "select distinct to_char(status_date,'yyyy') from rws_hab_directory_view h where status_date is not null";
        query1 += a1;
        System.out.println("$$$$$$$$$$$$$$" + query1);
        rs2 = st7.executeQuery(query1);
        while (rs2.next()) {
            currentYear = rs2.getString(1);
        }
        /*java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);*/

        if (fdate.substring(7, 11).equals(currentYear)) {
//	   qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
            //qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";
            qq2 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,hv.pcode,INITCAP(hv.pname) as pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_hab_directory_view hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' and hv.dcode='" + dCode + "' and hv.mcode='" + mCode + "' group by hv.dcode,hv.dname,hv.mcode,hv.mname,hv.pcode,hv.pname order by hv.pcode";
            //System.out.println("$$$$$$$$$$$$$$"+qq2);
        } else {

            //		qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3, SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_habitation_dir_his_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
            //qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";
            qq2 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,hv.pcode,INITCAP(hv.pname) as pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_habitation_dir_his_tbl hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='" + fdate + "' and hv.dcode='" + dCode + "' and hv.mcode='" + mCode + "' group by hv.dcode,hv.dname,hv.mcode,hv.mname,hv.pcode,hv.pname order by hv.pcode";
        }

        //qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";
        System.out.println("$$$$$$$$$$$$$$" + qq2);
        st6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
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
        </style>
    </head>
    <body bgcolor="#edf2f8">

                        
            <br/><br/>
            <center>
                <font color="#663899" face="Maiandra GD" size="6px"><b>Habitation Coverage - Yearly Status</b></font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">( Status As On : </font><font color="#889900" face="Maiandra GD" size="3px"><%=fdate%> )</font>
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=session.getAttribute("dName")%></font>&nbsp;&nbsp;&nbsp;&nbsp;
                <font color="#889900" face="Maiandra GD" size="3px">Mandal: <%=session.getAttribute("mName")%></font><br/><br/>
                <font color="#889900" face="Maiandra GD" size="3px">Constituency: <%=con%></font>&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/>
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
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'10', pdfColWidth: '18', ignoreColumn: [0],escape:'false',pageOrientation: 'p'}); return false;">
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
                
                        
                        
                        

                        <table border="1" align="center" id="tableID" cellspacing = 0 cellpadding = 0 width=700px  bordercolor=#000000 style="border-collapse:collapse" class="baseTable"  bgcolor="#ffffff">	
                            <thead>
                            <tr class="thead">
                                 <td class="btext" style="border-bottom: none !important;"></td> 
                                <td class="btext" style="border-bottom: none !important; border-right: none !important;"></td> 
                                <td class="btext" style="border-bottom: none !important; border-left: none !important;"></td>
                                <td class="btext" style="border-bottom: none !important;"></td>
                                <td align="center" class="btext" colspan=9> Habitation Status</td> 
                            <tr>
                                <th class="btext" style="text-align: left !important; width: 30px !important; border-top: none !important;">SNO</th>
                                <th class="btext" style="border-top: none !important; border-right: none !important;">Panchayat Name</th> 
                                <th class="btext" style="border-top: none !important; border-left: none !important;"></th> 
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
                            <%		int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
                                int slno = 0, total = 0;
                                while (rs6.next()) {

                                    ++slno;

                            %>
                            <td class=rptValue ><%=slno%></td>
                            <td class="mystyle1" style="text-align: left !important; border-right: none !important;">
                                <a href="rws_panch_only_status_cm_rpt.jsp?pcode=<%=rs6.getString(5)%>&pname=<%=rs6.getString(6)%>&FDate=<%=fdate%>&dcode=<%=dCode%>&mcode=<%=mCode%>&con=<%=con%>" style="font-size: 13px !important;"><%=rs6.getString(6)%></a></td>
                            <td class="rptValue" style="border-left: none !important;"></td> 
                            <%  /*total=rs6.getInt(3)+rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6)+rs6.getInt(7)+rs6.getInt(8)+rs6.getInt(9)+rs6.getInt(10);
                             System.out.println("total is "+total);*/
                            %>

                            <td class=btext><%=rs6.getInt(14)%></td>
                            <td class=rptValue><%=rs6.getString(7)%></td>
                            <% fcTotal += rs6.getInt(7);%>
                            <td class=rptValue><%=rs6.getString(8)%></td>
                            <% pc4Total += rs6.getInt(8);%>
                            <td class=rptValue><%=rs6.getString(9)%></td>
                            <% pc3Total += rs6.getInt(9);%>
                            <td class=rptValue><%=rs6.getString(10)%></td>
                            <% pc2Total += rs6.getInt(10);%>
                            <td class=rptValue><%=rs6.getString(11)%></td>
                            <% pc1Total += rs6.getInt(11);%>
                            <td class=rptValue><%=rs6.getString(12)%></td>
                            <% ncTotal += rs6.getInt(12);%>
                            <td class=rptValue><%=rs6.getString(13)%></td>
                            <% nssTotal += rs6.getInt(13); %>

                </tr>
                <%
                    }
                    rs6.close();

                    int grandtotal = 0;
                    grandtotal = fcTotal + pc4Total + pc3Total + pc2Total + pc1Total + ncTotal + nssTotal;

                %>

                <tr>
                    <td class=btext  align="right" style="border-right: none !important;"></td>
                    <td class=btext style="text-align: center !important; border-left: none !important; border-right: none !important;">Grand Total</td>
                    <td class=btext  align="right" style="border-left: none !important;"></td>
                    <td class=btext><font color="blue"><%=grandtotal%></font></td>
                    <td class=btext><%=fcTotal%></td>
                    <td class=btext><%=pc4Total%></td>
                    <td class=btext><%=pc3Total%></td>
                    <td class=btext><%=pc2Total%></td>
                    <td class=btext><%=pc1Total%></td>
                    <td class=btext><%=ncTotal%></td>
                    <td class=btext><%=nssTotal%></td>

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
