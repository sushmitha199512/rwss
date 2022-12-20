<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<table bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER>
<%
try{
	Set habset=new HashSet();
	Set habset1=new HashSet();
	Set habset2=new HashSet();
	Set habset3=new HashSet();
	Set habset4=new HashSet();
	Set habset5=new HashSet();
	Set habset6=new HashSet();	
	Set habsetSurface=new HashSet();
	Set habset1Surface=new HashSet();
	Set habset2Surface=new HashSet();
	Statement st=null;
	ResultSet rst=null;
	int sno=1;
	
String assettype=request.getParameter("name");
String rpttype=request.getParameter("type");
String dcode=request.getParameter("dcode");
StringBuffer finYear = new StringBuffer();
if (request.getParameter("finYear") != null) {
	finYear.append(request.getParameter("finYear"));
} else {
	finYear.append(session.getAttribute("finYear"));
}
String ys=finYear.toString().substring(0, 4);
String ye=finYear.toString().substring(5, 9);
Calendar cal = Calendar.getInstance();
StringBuffer year = new StringBuffer();
year.append(String.valueOf(cal.get(Calendar.YEAR)));
int prevYear = Integer.parseInt(year.toString()) - 1;
StringBuffer habTableName = new StringBuffer();
java.util.Date d = new java.util.Date();
StringBuffer s = new StringBuffer();
s.append(finYear.substring(0, 4));

if (finYear.toString().substring(0, 4).equals(year.toString())) {
	habTableName.append("rws_habitation_directory_tbl");
} else if (finYear.toString().substring(0, 4)	.equals(String.valueOf(prevYear))) {
	habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
} else {
	habTableName.append("RWS_HABITATION_DIR_HIS" + s + "_TBL");
}
String dname="";
Statement ssmt = conn.createStatement();
if (dcode != null && !dcode.equals("") && !dcode.equals("00")) {
	String qry = "select  dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
   rs=ssmt.executeQuery(qry);
   if(rs.next())
	   dname=rs.getString("dname");
}else{
	dcode="00";
}

String qry="";
if(rpttype.equals("asset")){
	if(assettype.equals("cpws")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and type_of_asset_code='03' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and  a.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and type_of_asset_code='03' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";		
	
	}else if(assettype.equals("pws")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and  a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";		
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";				
	}else if(assettype.equals("mpws")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code  and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}else if(assettype.equals("dp")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='09'  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='09'  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}else if(assettype.equals("hp")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code in ('04','05') and c.coverage_status is not null and c.coverage_status not in ('UI','NW')  ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}else if(assettype.equals("cpwsSurface")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and type_of_asset_code='03'  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and type_of_asset_code='03'  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' ";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}else if(assettype.equals("pwsSurface")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and  a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2'";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and  a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2'";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}else if(assettype.equals("mpwsSurface")){
		qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2'";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
		qry+=" union select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2'";
		if(!dcode.equals("00"))
			qry+=" and substr(a.asset_code,5,2)='"+dcode+"' ";
	}
}else{
	if(assettype.equals("cpws")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='03' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')   ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("cpwsSet");
	}else if(assettype.equals("pws")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')    ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}else if(assettype.equals("mpws")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')   ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}else if(assettype.equals("dp")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='09'  and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW') ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("dpSet");
		habset3=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}else if(assettype.equals("hp")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and b.hab_code=c.hab_code and type_of_asset_code in ('04','05')  and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status  not in ('UI','NW') ";
		if(!dcode.equals("00"))
			qry+=" and d.dcode='"+dcode+"' ";
	habset=(HashSet)session.getAttribute("hpSet");
	habset4=(HashSet)session.getAttribute("dpSet");
	habset3=(HashSet)session.getAttribute("mpwsSet");
	habset2=(HashSet)session.getAttribute("pwsSet");
	habset1=(HashSet)session.getAttribute("cpwsSet");
	}else if(assettype.equals("cpwsSurface")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='03' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')   ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("cpwsSetSurface");
	}else if(assettype.equals("pwsSurface")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where  a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='01' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')   ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("pwsSetSurface");
		habset1=(HashSet)session.getAttribute("cpwsSetSurface");
	}else if(assettype.equals("mpwsSurface")){
		qry="select distinct nvl(d.dname,'-'),nvl(m.mname,'-'),nvl(p.pname,'-'),nvl(v.vname,'-'),nvl(c.hab_code,'-'),nvl(panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h where a.asset_code=b.asset_code and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and b.hab_code=c.hab_code and type_of_asset_code='02' and d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=c.hab_code and c.coverage_status is not null and c.coverage_status not in ('UI','NW')  ";
		if(!dcode.equals("00"))
			qry+="  and d.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("mpwsSetSurface");
		habset2=(HashSet)session.getAttribute("pwsSetSurface");
		habset1=(HashSet)session.getAttribute("cpwsSetSurface");
	}
	
}
//System.out.println("qry is="+qry);
st=conn.createStatement();
rst=st.executeQuery(qry);
if(rpttype.equals("asset")){
%>
<tr>
		<td align="center" class="gridhdbg" colspan="6">Asset Details for F.Y. (<%=finYear.toString() %>) <%	if(!dcode.equals("00")) {%> & District: <%=dname %><%} %></td>
</tr>
<tr align=center>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>Asset Code  </b></td>
<td class=gridhdbg ><b>Asset Name</b></td>
<td class=gridhdbg ><b>Location</b></td>
<td class=gridhdbg ><b>Creation Date</b></td>
<td class=gridhdbg ><b>Asset Cost</b></td>
</tr>
<%
int styleCount=0;
String style="";
while(rst.next()){
	if(styleCount%2==0){
		 style="gridbg1";
	}else{
		 style="gridbg2";
	}
	styleCount++;	
	%>
	<tr>
	 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>
      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5) %></td>	  
	</tr>	
	<%
}
}else{	
	%><tr >
		<td align="center" class="gridhdbg" colspan="8">Habitation Details for the F.Y.(<%=finYear.toString() %>)  & District: <%=dname%></td>
</tr>
<tr align=center>
<td class=gridhdbg ><b>SLNO   </b></td>
<td class=gridhdbg ><b>District  </b></td>
<td class=gridhdbg ><b>Mandal</b></td>
<td class=gridhdbg ><b>Panchayat</b></td>
<td class=gridhdbg ><b>Village</b></td>
<td class=gridhdbg ><b>Hab Code/Name</b></td>
<td class=gridhdbg ><b>Coverage Status</b></td>
<td class=gridhdbg ><b>Population</b></td>
</tr><%
int styleCount=0;
String style="";
while(rst.next()){
	String assettypecode=rst.getString(12);
	if(styleCount%2==0){
		 style="gridbg1";
	}else{
		 style="gridbg2";
	}
	styleCount++;
	//System.out.println(rst.getString(5)+"@"+habset.contains(rst.getString(5)));
	if(assettypecode.equals("03")){
		if(habset.contains(rst.getString(5))){
		%>
		<tr>
		 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
	  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
		  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
		 </tr>		
		<%}
	}else if(assettypecode.equals("01")){
	//	System.out.println("size is"+habset1.size());
		if(habset1.contains(rst.getString(5))){			
		}else if(habset.contains(rst.getString(5))) {
		%>
		<tr>
		 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
	  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
		  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
		</tr>		
		<%
		}
	}else if(assettypecode.equals("02")){
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5))){		
	}else if(habset.contains(rst.getString(5))) {
	%>
		<tr>
		 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
	  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
		  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
		 </tr>		
		<%
	}
	}else if(assettypecode.equals("09")){
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5))){}
	else  if(habset.contains(rst.getString(5))) {
	%>
		<tr>
		 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
	  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
		  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
		</tr>		
		<%
	}
	}else if(assettypecode.equals("04") || assettypecode.equals("05")){
		if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5)) || habset4.contains(rst.getString(5))){}
		else if(habset.contains(rst.getString(5))) {
		%>
			<tr>
			 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
		      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
		  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
			  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
		      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
			  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
			  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
			  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
			 </tr>		
			<%
		}
	}/*  else{
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5)) || habset4.contains(rst.getString(5)) || habset5.contains(rst.getString(5)) || habset6.contains(rst.getString(5))){
		
	}else  if(habset.contains(rst.getString(5))) { */
	%>
		<%-- <tr>
		 <td class="<%=style%>" style="text-align: left;" ><%= sno++ %></td>	      
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(1) %></td> 
	  	  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(2) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(3) %></td>
	      <td class="<%=style%>" style="text-align: left;"><%=rst.getString(4) %></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(5)%>/<%=rst.getString(6)%></td>
		  <td class="<%=style%>" style="text-align: left;"><%=rst.getString(11) %></td>
		  <td class="<%=style%>" style="text-align: right;"><%=rst.getInt(10) %></td>		  
		</tr>		 --%>
		<%
	/* }
	}  */
}}
if(rst!=null){
	rst.close();
}
if(st!=null){
	st.close();
}
} catch(Exception e)
{
e.printStackTrace();
} %>
</table>
</body>
</html>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
<%@ include file="/commons/rws_footer.jsp" %>