<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null,sourcecode=null;
                  String colSpaceStr = "";
        
	 code=request.getParameter("code");
                   if(code.equals("Assets"))
                       colSpaceStr = "10,33,20,30,36,36,36";
                   if(code.equals("Works"))
                       colSpaceStr = "10,40,40,42,40,38";
	 dist=request.getParameter("dcode");
	 mand=request.getParameter("mcode");
	 panch=request.getParameter("pcode");
	 habcode=request.getParameter("hcode");
         
                String hName=request.getParameter("hname");
	session.setAttribute("hName",hName); 
            String fdate=(String)session.getAttribute("FDate");
	%>
<html>
<title> WaterSoft </title>
<head>
            <!-- <script src="/pred/resources/js/jquery-1.10.2.min.js"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
            <script src="/pred/resources/js/jquery-3.6.0.min.js"></script>
            <script type="text/javascript" src="/pred/resources/js/utils.js"></script>
            <script type="text/javascript" src="/pred/resources/js/tableExport.js"></script>
            <script type="text/javascript" src="/pred/resources/js/jquery.base64.js"></script>
            <script type="text/javascript" src="/pred/resources/js/sprintf.js"></script>
            <script type="text/javascript" src="/pred/resources/js/jspdf.js"></script>
            <script type="text/javascript" src="/pred/resources/js/base64.js"></script>
            <script type="text/javascript" src="/pred/resources/js/html2canvas.js"></script>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

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
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=session.getAttribute("dName1")%></font>&nbsp;&nbsp;&nbsp;&nbsp;
                    <font color="#889900" face="Maiandra GD" size="3px">Mandal: <%=session.getAttribute("mName1")%></font>&nbsp;&nbsp;&nbsp;&nbsp;
                    <font color="#889900" face="Maiandra GD" size="3px">Panchayat: <%=session.getAttribute("pName")%></font><br/><br/>
                    <font color="#889900" face="Maiandra GD" size="3px">Habitation: <%=session.getAttribute("hName")%></font><br/><br/>            </center>
    
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
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'8', pdfColWidth: '30', ignoreColumn: [0],escape:'false',colSpace: [<%=colSpaceStr%>]}); return false;"">
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
        

<table align="center" border = 1 cellspacing = 0 class="baseTable" id="tableID" cellpadding = 0 width=700px bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
    <thead>
	 <% if(code.equals("Assets"))
	 {
	 %>
                        <tr class="thead">
                            <th class="btext"  style="text-align: center !important; width: 30px !important;">S.NO.</th>
                            <th class="btext" style="text-align: left !important; width: 250px !important; border-right: none !important;">AssetName-AssetCode</th>
                            <th class="btext" style="text-align: left !important; border-left: none !important; border-right: none !important;"></th>
                            <th class="btext" style="text-align: left !important; border-left: none !important;"></th>
                            <th class="btext" align=center style="width: 130px !important;">Location</th>
                            <th class="btext" align=center>Asset Status</th>
                            <th class="btext" align=center style="width: 100px !important;">Date Of Creation</th>
                            <th class="btext" align=center>Cost Of Asset</th>
                        </tr>
     <%
	 }
	else if(code.equals("Works"))
	{
                    %>
                                <tr class="thead">
                                    <th class="btext" align=center style="text-align: center !important; width: 30px !important;">S.NO.</th>
		<th class="btext" align=center style="text-align: center !important; width: 400px !important; border-right: none !important;">Work Name</th>
                                    <th class="btext" style="text-align: left !important; border-left: none !important;"></th>
		<th class="btext" align=center style="text-align: center !important; width: 100px !important;">Programme</th>
		<th class="btext" align=center style="text-align: center !important; width: 60px !important;">Sub Programme</th>
		<th class="btext" align=center style="text-align: center !important; width: 60px !important;">Asset Name</th>
		<th class="btext" align=center style="text-align: center !important; width: 50px !important;">Work Category</th>
                                </tr>
                    <%
	 }
%>
</thead>
<%

try
{

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


if(code.equals("Assets"))
	{
                    //qu="select distinct b.asset_name,b.location,decode(b.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,a.type_of_asset_code,b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code and d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dist+"' and substr(d.panch_code,6,2)='"+mand+"' and substr(d.panch_code,13,2)='"+panch+"' and substr(d.panch_code,1,16)='"+habcode+"' and b.type_of_asset_code=a.type_of_asset_code";
                    //qu = "select distinct b.asset_name,b.location,decode(b.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,a.type_of_asset_code,b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_complete_hab_view d,rws_asset_scheme_tbl s,hab_directory_view h where d.panch_code=h.hab_code and b.asset_code=s.asset_code and d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,16)='"+habcode+"' and b.type_of_asset_code=a.type_of_asset_code";
                    qu = "select distinct b.asset_name,b.location,b.asset_status,to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,b.type_of_asset_code,b.asset_code from rws_complete_asset_view b,rws_hab_directory_view h where b.HAB_CODE='"+habcode+"' and h.hab_code=b.HAB_CODE";
	}
	else if(code.equals("Works"))
	{
                    /*qu="SELECT * from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and w.work_id=a.work_id and substr(pr.panch_code,1,2)='"+dist+"' and  substr(pr.panch_code,6,2)='"+mand+"' and substr(pr.panch_code,13,2)='"+panch+"' and substr(pr.panch_code,1,16)='"+habcode+"'";*/
                    //qu="SELECT distinct w.work_id,w.work_name,p.programme_name,sp.subprogramme_name,t.TYPE_OF_ASSET_NAME,nvl(w.work_category,'-'),w.type_of_asset from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_asset_type_tbl t  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and w.work_id=a.work_id and p.programme_code=w.programme_code and sp.programme_code=w.programme_code and sp.subprogramme_code=w.subprogramme_code and w.TYPE_OF_ASSET=t.TYPE_OF_ASSET_CODE and substr(pr.panch_code,1,2)='"+dist+"' and  substr(pr.panch_code,6,2)='"+mand+"' and substr(pr.panch_code,13,2)='"+panch+"' and substr(pr.panch_code,1,16)='"+habcode+"'";
                       qu = "select distinct w.work_id,w.work_name,w.programme_name,w.subprogramme_name,w.TYPE_OF_ASSET_NAME,nvl(w.work_category,'-'),w.TYPE_OF_ASSET from rws_works_ongoing_notcomm_view w,rws_complete_hab_view pr,rws_hab_directory_view h  where w.LEAD_HABITATION=pr.panch_code and H.hab_code=pr.panch_code and pr.panch_code='"+habcode+"'";
	}
	 rs1=st1.executeQuery(qu);
	 int slno=0,total=0;
	while(rs1.next())
	{
	
	if(code.equals("Assets"))
	 {
		
	%>
        <tbody>
        <TR>
		<td class=rptValue style="text-align: center !important; "><%=++slno%></td>
        <td class=rptValue style="text-align: left !important; border-right: none !important;"><%=rs1.getString(1)%><%="-"+rs1.getString(7)%></td>
        <td class="rptValue" style="text-align: left !important; border-left: none !important; border-right: none !important;"></td>
        <td class="rptValue" style="text-align: left !important; border-left: none !important;"></td>
		<% if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(2)%></td>
		<%}else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(4)!=null)
		 {
		%>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(4)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(5)!=null)
		 {
		%>
		<td class=rptValue align=right><%=rs1.getString(5)%></td>
		<%}
		else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		
		</TR>
                </tbody>
<%
	 }
else if(code.equals("Works"))
	 {
	%>
        <tbody>
                    <TR>
		<td class=rptValue style="text-align: center !important; "><%=++slno%></td>
		<td class=rptValue style="text-align: left !important; border-right: none !important;"><%=rs1.getString(2)%><%="-"+rs1.getString(1)%></td>
                                    
                                    <td class=rptValue style="text-align: left !important; border-left: none !important;"></td>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(3)%></td>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(4)%></TD>
		<td class=rptValue style="text-align: left !important; "><%=rs1.getString(5)%></TD>
		<td class=rptValue style="text-align: center !important; "><%=rs1.getString(6)%></TD>
	</TR>
        </tbody>
<%
	 } 
        }
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
</table>	
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

