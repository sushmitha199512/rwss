<%@ include file ="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="",query1=null,currentYear=null,qu1=null,qu2=null,qu3=null;
	int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0,j=0,Count1=0,Count2=0;
	 String dCode;
   String mCode;
  String pCode;
	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String panchayat=request.getParameter("panchayat");
 String fdate=(String)session.getAttribute("FDate");
String tdate=request.getParameter("TDate");
String con=request.getParameter("con");
if(district==null && mandal==null && panchayat==null)
{
   //dCode=String.valueOf(session.getAttribute("dcode"));
 // mCode=String.valueOf(session.getAttribute("mCode")); 
 dCode=request.getParameter("dcode");
  mCode=request.getParameter("mcode");
   pCode=request.getParameter("pcode");
	session.setAttribute("pCode",pCode); 

	 String pName=request.getParameter("pname");
	session.setAttribute("pName",pName); 
}
else
{
dCode=district;
mCode = mandal;
pCode= panchayat;
}
	String dnames=(String)session.getAttribute("dName");
	String mnames=(String)session.getAttribute("mName");
	String vnames=request.getParameter("vName");
//System.out.println("dname:"+dnames);
//System.out.println("mname:"+mnames);


session.setAttribute("dName1",dnames);
session.setAttribute("mName1",mnames);




String s=request.getParameter("start");

int slno=0;
try{
	 if(fdate!=null && !fdate.equals("0") )
	{
		a1 =  " and status_date ='" + fdate +"' ";
	}
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
//query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
query1="select distinct to_char(status_date,'yyyy') from rws_hab_directory_view h where status_date is not null";
query1 += a1;
rs2=st7.executeQuery(query1);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}
 	if(fdate.substring(7,11).equals(currentYear))
	{
		//qu1 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,nvl(hd.coverage_status,'--'),h.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,hd.coverage_status,h.panch_code";
                                    qu1 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,hv.pcode,INITCAP(hv.pname) as pname,INITCAP(hv.panch_name) as panch_name,nvl(hd.coverage_status,'--'),hv.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_hab_directory_view hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='"+fdate+"' and hv.dcode='"+dCode+"' and hv.mcode='"+mCode+"' and hv.pcode='"+pCode+"' group by hv.dcode,hv.dname,hv.mcode,hv.mname,hv.pcode,hv.pname,hv.panch_name,hd.coverage_status,hv.panch_code order by hv.panch_code";
	}
	else
	{
		//qu1 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,nvl(hd.coverage_status,'--'),h.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and  substr(h.hab_code,13,2)='"+pCode+"' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,h.panch_name,hd.coverage_status,h.panch_code";
                                    qu1 = "select DISTINCT hv.dcode,INITCAP(hv.dname) as dname,hv.mcode,INITCAP(hv.mname) as mname,hv.pcode,INITCAP(hv.pname) as pname,INITCAP(hv.panch_name) as panch_name,nvl(hd.coverage_status,'--'),hv.panch_code,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_complete_hab_view hv,rws_habitation_dir_his_tbl hd where substr (hv.panch_code,1,16) = hv.panch_code and hv.panch_code=hd.hab_code  and (hd.coverage_status is not null and hd.coverage_status <> 'UI') and status_date ='"+fdate+"' and hv.dcode='"+dCode+"' and hv.mcode='"+mCode+"' and hv.pcode='"+pCode+"' group by hv.dcode,hv.dname,hv.mcode,hv.mname,hv.pcode,hv.pname,hv.panch_name,hd.coverage_status,hv.panch_code order by hv.panch_code";
	}
	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	r6.beforeFirst();
	
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
            .thead th {
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
                <br/><br/><font color="#889900" face="Maiandra GD" size="3px">District: <%=session.getAttribute("dName")%>,</font>&nbsp;&nbsp;&nbsp;
                    <font color="#889900" face="Maiandra GD" size="3px">Mandal: <%=session.getAttribute("mName")%>,</font>&nbsp;&nbsp;&nbsp;
                    <font color="#889900" face="Maiandra GD" size="3px">Constituncey: <%=con%></font><br/><br/>
                    <font color="#889900" face="Maiandra GD" size="3px">Panchayat: <%=session.getAttribute("pName")%></font><br/><br/>
            </center>
    
            <table align="center" style="margin-top: -15px !important; width: 600px !important;  text-align: center !important;">
                <tr>
                   <td style="width: 520px !important;text-align: left !important;">
                        <a href="" onClick="$('#exportList').toggle(); return false;"><img height="25px" src="/pred/resources/graphs/export.png"/></a>
                  
                   <td style="width: 100px !important;">
                    <a href="/pred/rws_login_frm.jsp" ><img src="/pred/resources/graphs/home.png" height="25px"/></a></td>
                    <td style="width: 80px !important;">
                    <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="25px"/></a></td>
              </tr>
                <tr id="exportList" style="display: none; ">
                    <td colspan="2" style="width: 600px !important;text-align: left !important;">
                    <a href="" title="PDF" onClick="$('#tableID').tableExport({type:'pdf',pdfFontSize:'9', pdfColWidth: '20', ignoreColumn: [0],escape:'false',pageOrientation: 'p'}); return false;">
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



<table border = 1 align="center" id="tableID" cellspacing = 0 cellpadding = 0 width=600px  bordercolor=#000000 class="baseTable" style="border-collapse:collapse" bgcolor="#ffffff">	
    <thead>
        <tr class="thead">
            <th class="btext" style="width: 50px !important;">S.NO.</th>
            <th class="btext" style="width: 150px !important; border-right: none !important;">Habitation</th>
            <th class="btext" style="border-left: none !important;"></th>
            <th class="btext" style="border-right: none !important;">Coverage Status</th> 
            <th class="btext" style="border-left: none !important;"></th>
            <th class="btext" >Assets</th> 
            <th class="btext" >Works</th> 
        </tr>	
    </thead>
    <tbody>
        <tr align=left bgcolor="#ffffff">
<%	 
if(Count!=0){
	while(r6.next())
	{
			
	%>
                        
                        <td class="rptValue"><%=++start%> </td>
                        <td class="rptValue" style="text-align: left !important; border-right: none !important;"><%=r6.getString(7) %> </td> 
                        <td class="rptValue" style="text-align: left !important; border-left: none !important;"></td> 
                        <td class="rptValue" style="text-align: center !important; border-right: none !important;"><%=r6.getString(8) %> </td>
                        <td class="rptValue" style="text-align: left !important; border-left: none !important;"></td> 
			<% 
             
 //qu2="select  distinct  count(*) from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code  and   d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dCode+"' and substr(d.panch_code,6,2)='"+mCode+"' and substr(d.panch_code,13,2)='"+pCode+"' and substr(d.panch_code,1,16)='"+r6.getString(9)+"' and  b.type_of_asset_code=a.type_of_asset_code";
 //qu2 = "select distinct count(*) from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_complete_hab_view d,rws_asset_scheme_tbl s,rws_hab_directory_view h where d.panch_code=h.hab_code and b.asset_code=s.asset_code and d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,16)='"+r6.getString(9)+"' and  b.type_of_asset_code=a.type_of_asset_code";
 qu2 = "select distinct count(*) from rws_complete_asset_view a,rws_hab_directory_view h where a.HAB_CODE=h.hab_code and a.HAB_CODE='"+r6.getString(9)+"'";
//System.out.println("QU2:"+qu2);

		
		r7=st8.executeQuery(qu2);
		r7.last();
	    Count2 = r7.getRow();
	    r7.beforeFirst();
		while(r7.next())
		{
			if(!r7.getString(1).equals("0"))
			{
				
		 %>
<td class="rptValue" align="right"><a href="./rws_cm_assets.jsp?dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(9)%>&hname=<%=r6.getString(7)%>&code=<%="Assets"%>"><%=r7.getString(1)%></a></td>

	<%
			}
	else{%>
<td class="rptValue" align="center"><%="-"%></td>
<%}
	}
	  if(Count2==0)
		{%>
<td class="rptValue" align="center"><%="-"%></td>

<%}
 //qu3="select distinct count(*) from rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and substr(pr.panch_code,1,2)='"+dCode+"' and  substr(pr.panch_code,6,2)='"+mCode+"' and substr(pr.panch_code,13,2)='"+pCode+"' and substr(pr.panch_code,1,16)='"+r6.getString(9)+"'";
//qu3 = "select distinct count(*) from rws_admn_hab_lnk_tbl a,rws_complete_hab_view pr,rws_hab_directory_view h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and substr(pr.panch_code,1,16)='"+r6.getString(9)+"'";
qu3 = "select distinct count(*) from rws_works_ongoing_notcomm_view w,rws_complete_hab_view pr,rws_hab_directory_view h  where w.LEAD_HABITATION=pr.panch_code and H.hab_code=pr.panch_code and pr.panch_code='"+r6.getString(9)+"'";
  //System.out.println("QU3:"+qu3);
    r1=st1.executeQuery(qu3);
	r1.last();
	Count1 = r1.getRow();
	r1.beforeFirst();
		
		while(r1.next())
		{
			if(!r1.getString(1).equals("0"))
			{
				
		 %>
<td class="rptValue" align="right"><a href="./rws_cm_assets.jsp?code=<%="Works"%>&dcode=<%=dCode%>&mcode=<%=mCode%>&pcode=<%=pCode%>&hcode=<%=r6.getString(9)%>&hname=<%=r6.getString(7)%>"><%=r1.getString(1)%>
</a></td>

	<% }
	else{
        %>
<td class="rptValue" align="right"><%="-"%></td>
<%}
	}
	  if(Count1==0)
		{%>
<td class="rptValue" align="right"><%="-"%></td>

<%}
%>
</tr>
</tbody>
<%}
}else { // ////System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}

}
catch(Exception e)
{e.printStackTrace();}
finally
{
	conn.close();
}
%>
</table>
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
