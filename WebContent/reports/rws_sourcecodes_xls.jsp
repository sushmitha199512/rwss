<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null;
     code=request.getParameter("code");
     if(code.equals("HP"))
      codename="HANDPUMPS";
   else if(code.equals("POND"))
    codename="PONDS";
    else if(code.equals("SHALLOW"))
    codename="SHALLOWHANDPUMPS";
   else if(code.equals("OPENWELL"))
    codename="OPENWELLS";
   else if(code.equals("PWSSURFACE"))
    codename="PWSSURFACESOURCES";
   else if(code.equals("PWSSUBSURFACE"))
   codename="PWSSUBSURFACESOURCES";
   else if(code.equals("CPWSSURFACE"))
    codename="CPWSSURFACESOURCES";
   else if(code.equals("CPWSSUBSURFACE"))
  codename="CPWSSUBSURFACESOURCES";
   else if(code.equals("MPWSSURFACE"))
    codename="MPWSSURFACESOURCES";
   else if(code.equals("MPWSSUBSURFACE"))
    codename="MPWSSUBSURFACESOURCES";
   else if(code.equals("MPWSPUMPSETS"))
    codename="MPWSPUMPSETS";
   else if(code.equals("CPWSPUMPSETS"))
    codename="CPWSPUMPSETS";
   else if(code.equals("PWSPUMPSETS"))
    codename="PWSPUMPSETS";

  
  dist=request.getParameter("dcode");
 // System.out.println("dist"+dist);
 
  mand=request.getParameter("mcode");

  panch=request.getParameter("pcode");
  
  
  habcode=request.getParameter("hcode");
 

 
 

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 
 
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

%>
<html>
<title> WaterSoft </title>
<head>
<!--<script>
		window.history.forward(1);
	</script>-->
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


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">



	<tr bgcolor="lavander">
		<td class="textborder" align="center" >
			<font color="ffffff">Sources Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
   
<tr>
<td align="center" nowrap class="btext"><font color="navy">Source:<%=codename%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>HABITATION</td>
		<td class="btext" align=center>SOURCECODE</td>
		</tr>


<%
try
{

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


if(code.equals("HP") && dist!=null  )
	{

/*qu="SELECT distinct H.hp_code from RWS_ASSET_MAST_TBL A, RWS_HP_SUBCOMP_PARAM_TBL h where A.ASSET_CODE=H.ASSET_CODE  and substr(h.hp_code,1,2)='"+dist+"' order by h.hp_code";*/

qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,2)='"+dist+"' order by pr.panch_code";
}
	else if(code.equals("POND") && dist!=null )
	{
/*qu="SELECT distinct H.POND_code from RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL h  where A.ASSET_CODE=H.ASSET_CODE and substr(h.POND_code,1,2)='"+dist+"' order by h.pond_code";*/

qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.pond_code,1,16) and substr(h.pond_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("OPENWELL") && dist!=null )
	{
/*qu="SELECT distinct H.openwell_code from RWS_OPEN_WELL_MAST_TBL h,RWS_ASSET_MAST_TBL A where A.ASSET_CODE=H.ASSET_CODE and  substr(h.HABITATION_code,1,2)='"+dist+"' order by h.openwell_code";*/

qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.OPENWELL_code,1,16) and substr(h.OPENWELL_code,1,2)='"+dist+"' order by pr.panch_code";

	}
	else if(code.equals("SHALLOW")&& dist!=null )
	{
/*qu="SELECT distinct h.SHALLOWHP_CODE from RWS_SHALLOWHANDPUMPS_TBL h,RWS_ASSET_MAST_TBL A where A.ASSET_CODE=H.ASSET_CODE and substr(h.HAB_code,1,2)='"+dist+"' order by h.shallowhp_code";*/
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SHALLOWHANDPUMPS_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.shallowhp_code,1,16) and substr(h.SHALLOWHP_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSUBSURFACE")&& dist!=null )
	{
/*qu="SELECT distinct SOURCE_CODE FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S WHERE A.ASSET_CODE=H.ASSET_CODE and H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' AND SUBSTR(H.SOURCE_CODE,1,2)='"+dist+"' order by source_code";*/

 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSURFACE")&& dist!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("PWSPUMPSETS")&& dist!=null )
	{
/*qu="SELECT distinct H.pump_code FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H WHERE A.ASSET_CODE=H.ASSET_CODE and  substr(h.HAB_code,1,2)='"+dist+"' order by h.pump_code";*/

qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSUBSURFACE")&& dist!=null)
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSURFACE")&& dist!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSPUMPSETS")&& dist!=null )
	{
   qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSUBSURFACE")&& dist!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSURFACE")&& dist!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSPUMPSETS")&& dist!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' order by pr.panch_code";
	}
	
	else if(code.equals("HP") && dist!=null && mand!=null )
	{
/*qu="SELECT H.hp_code,pr.panch_name from RWS_ASSET_MAST_TBL A, rws_panchayat_raj_tbl pr,RWS_HP_SUBCOMP_PARAM_TBL h  where A.ASSET_CODE=H.ASSET_CODE AND pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,2)='"+dist+"' order by pr.panch_name";*/

qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,2)='"+dist+"'  and substr(h.hp_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("POND") && dist!=null && mand!=null ) 
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.pond_code,1,16) and substr(h.pond_code,1,2)='"+dist+"' and substr(h.pond_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("OPENWELL") && dist!=null && mand!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.openwell_code,1,16) and substr(h.OPENWELL_code,1,2)='"+dist+"' and substr(h.OPENWELL_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("SHALLOW")&& dist!=null && mand!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SHALLOWHANDPUMPS_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.shallowhp_code,1,16) and substr(h.SHALLOWHP_code,1,2)='"+dist+"' and substr(h.SHALLOWHP_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSUBSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("PWSPUMPSETS")&& dist!=null && mand!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSUBSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSPUMPSETS")&& dist!=null && mand!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSUBSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSURFACE")&& dist!=null && mand!=null )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSPUMPSETS")&& dist!=null && mand!=null )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' order by pr.panch_code";
	}
	
		else if(code.equals("HP") && dist!=null && mand!=null && panch!=null  )
	{
  qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,2)='"+dist+"'   and substr(h.hp_code,6,2)='"+mand+"' and substr(h.hp_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("POND") && dist!=null && mand!=null && panch!=null  ) 
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.pond_code,1,16) and substr(h.pond_code,1,2)='"+dist+"' and substr(h.pond_code,6,2)='"+mand+"' and substr(h.pond_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("OPENWELL") && dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.openwell_code,1,16) and substr(h.OPENWELL_code,1,2)='"+dist+"' and substr(h.OPENWELL_code,6,2)='"+mand+"' and substr(h.OPENWELL_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("SHALLOW")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SHALLOWHANDPUMPS_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.shallowhp_code,1,16) and substr(h.SHALLOWHP_code,1,2)='"+dist+"' and substr(h.SHALLOWHP_code,6,2)='"+mand+"' and substr(h.SHALLOWHP_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'order by pr.panch_code";
	}
	else if(code.equals("PWSSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("PWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"'  order by pr.panch_code";
	}
	else if(code.equals("MPWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSURFACE")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  )
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"' order by pr.panch_code";
	}
	
		

		else if(code.equals("HP") && dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
   qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,2)='"+dist+"'   and substr(h.hp_code,6,2)='"+mand+"' and substr(h.hp_code,13,2)='"+panch+"'  and substr(h.hp_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("POND") && dist!=null && mand!=null && panch!=null  && habcode!=null) 
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPENWELL_POND_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.pond_code,1,16) and substr(h.pond_code,1,2)='"+dist+"' and substr(h.pond_code,6,2)='"+mand+"' and substr(h.pond_code,13,2)='"+panch+"'  and substr(h.pond_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("OPENWELL") && dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_OPEN_WELL_MAST_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.openwell_code,1,16) and substr(h.OPENWELL_code,1,2)='"+dist+"' and substr(h.OPENWELL_code,6,2)='"+mand+"' and substr(h.OPENWELL_code,13,2)='"+panch+"'  and substr(h.OPENWELL_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("SHALLOW")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SHALLOWHANDPUMPS_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.shallowhp_code,1,16) and substr(h.SHALLOWHP_code,1,2)='"+dist+"' and substr(h.SHALLOWHP_code,6,2)='"+mand+"' and substr(h.SHALLOWHP_code,13,2)='"+panch+"'   and substr(h.SHALLOWHP_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE  and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'  and substr(h.SOURCE_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("PWSSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'  and substr(h.SOURCE_code,1,16)='"+habcode+"'  order by pr.panch_code";
	}
	else if(code.equals("PWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"'  and substr(h.HAB_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'   and substr(h.SOURCE_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
 qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'  and substr(h.SOURCE_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("CPWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"'  and substr(h.HAB_code,1,16)='"+habcode+"'   order by pr.panch_code";
	}
	else if(code.equals("MPWSSUBSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'  and substr(h.SOURCE_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSSURFACE")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2'  and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.source_code,1,16) and substr(h.SOURCE_code,1,2)='"+dist+"' and substr(h.SOURCE_code,6,2)='"+mand+"' and substr(h.SOURCE_code,13,2)='"+panch+"'  and substr(h.SOURCE_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
	else if(code.equals("MPWSPUMPSETS")&& dist!=null && mand!=null && panch!=null  && habcode!=null)
	{
qu="SELECT distinct pr.panch_code,pr.panch_name FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.HAB_code,1,2)='"+dist+"' and substr(h.HAB_code,6,2)='"+mand+"' and substr(h.HAB_code,13,2)='"+panch+"'  and substr(h.HAB_code,1,16)='"+habcode+"' order by pr.panch_code";
	}
  rs1=st1.executeQuery(qu);
   rs1.setFetchSize(2000);
	int slno=0,total=0;
	 while(rs1.next())
		{
		//out.println(rs1.getString(1));
		++ slno;
	
%>      <TR>
		<td class=rptValue align=center><%=slno%></td>
        <td class=rptValue align=center><%=rs1.getString(2)%></td>
		<% if(code.equals("HP"))
			{
	         query="SELECT distinct h.hp_code FROM RWS_ASSET_MAST_TBL A,RWS_HP_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.hp_code,1,16) and substr(h.hp_code,1,16)='"+rs1.getString(1)+"' order by h.hp_code";
			}
			else if(code.equals("POND"))
			{
             query="SELECT distinct h.pond_code FROM RWS_ASSET_MAST_TBL A,RWS_openwell_pond_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.pond_code,1,16) and substr(h.pond_code,1,16)='"+rs1.getString(1)+"' order by h.pond_code";
			}
			else if(code.equals("OPENWELL"))
			{
              query="SELECT distinct h.openwell_code FROM RWS_ASSET_MAST_TBL A,RWS_open_well_mast_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.openwell_code,1,16) and substr(h.openwell_code,1,16)='"+rs1.getString(1)+"' order by h.openwell_code";
			}
			else if(code.equals("SHALLOW"))
			{
              query="SELECT distinct h.shallowhp_code FROM RWS_ASSET_MAST_TBL A,RWS_shallowhandpumps_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=substr(h.shallowhp_code,1,16) and substr(h.shallowhp_code,1,16)='"+rs1.getString(1)+"' order by h.shallowhp_code";
			}
			else if(code.equals("PWSPUMPSETS"))
			{
             query="SELECT distinct h.pump_code FROM RWS_ASSET_MAST_TBL A,RWS_PWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.pump_code,1,16)='"+rs1.getString(1)+"' order by h.pump_code";
			}
			else if(code.equals("MPWSPUMPSETS"))
			{
              query="SELECT distinct h.pump_code FROM RWS_ASSET_MAST_TBL A,RWS_MPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.pump_code,1,16)='"+rs1.getString(1)+"' order by h.pump_code";
			}
			else if(code.equals("CPWSPUMPSETS"))
			{
              query="SELECT distinct h.pump_code FROM RWS_ASSET_MAST_TBL A,RWS_CPWS_SUBCOMP_PARAM_TBL H,rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE and pr.panch_code=h.hab_code and substr(h.pump_code,1,16)='"+rs1.getString(1)+"' order by h.pump_code";
			}
			else if(code.equals("PWSSUBSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='1' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
			else if(code.equals("PWSSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '6%' AND H.SOURCE_TYPE_CODE='2' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
			else if(code.equals("CPWSSUBSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='1' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
			else if(code.equals("CPWSSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '8%' AND H.SOURCE_TYPE_CODE='2' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
			else if(code.equals("MPWSSUBSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='1' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
			else if(code.equals("MPWSSURFACE"))
				{
             query="SELECT distinct h.source_code FROM RWS_ASSET_MAST_TBL A,RWS_SOURCE_TBL H,RWS_SOURCE_TYPE_TBL S, rws_panchayat_raj_tbl pr WHERE A.ASSET_CODE=H.ASSET_CODE  AND SUBSTR(H.SOURCE_CODE,17,3) LIKE '4%' AND H.SOURCE_TYPE_CODE='2' and  H.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE and pr.panch_code=substr(h.SOURCE_code,1,16) and substr(h.SOURCE_code,1,16)='"+rs1.getString(1)+"' order by h.SOURCE_code";
			}
				
			 rs2=st2.executeQuery(query);
			 rs2.setFetchSize(500);
			int no1=0;
			 while(rs2.next())
			
		{
			no1++;
		
			if(no1==1)
			{
				//out.println("in if");
			%>
		<td class=rptValue align=center> <%=rs2.getString(1)%></td>
		</tr>
		<% }
	   else
			{
		   //out.println("in if else");
		   %>
			<tr><td colspan=2></td>
			<td class=rptValue align=center > <%=rs2.getString(1)%></td>
		
		  </tr>
              <% } } 
			 
		}
%>

</table>
<%
		
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
</form>
</body>
</html>

