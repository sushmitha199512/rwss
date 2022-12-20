<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/commons/rws_header1.jsp"%>
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
	
	Statement st=null;
	ResultSet rst=null;
	int sno=1;
String assettype=request.getParameter("name");
String rpttype=request.getParameter("type");
String dcode=request.getParameter("dcode");
System.out.println(rpttype+"@"+assettype+"@"+dcode);
String qry="";
if(rpttype.equals("asset")){
if(assettype.equals("cpws")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("pws")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("mpws")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("dp")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09'  and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("hp")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('04','05') and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("ow")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='06' and c.dcode='"+dcode+"' ";
	
}
else if(assettype.equals("o")){
	qry="select distinct a.asset_code,nvl(a.ASSET_NAME,'-'),nvl(a.LOCATION,'-'),nvl(to_char(a.DATE_CREATION,'dd-mm-yyyy'),'-'),nvl(ASSET_COST,0) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('07','08','10','11','12') and c.dcode='"+dcode+"' ";
	
}
}else{
	if(assettype.equals("cpws")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='03' and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("pws")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='01' and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("mpws")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='02' and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("dp")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='09'  and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("dpSet");
		habset3=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("hp")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('04','05') and c.dcode='"+dcode+"' ";
	habset=(HashSet)session.getAttribute("hpSet");
	habset4=(HashSet)session.getAttribute("dpSet");
	habset3=(HashSet)session.getAttribute("mpwsSet");
	habset2=(HashSet)session.getAttribute("pwsSet");
	habset1=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("ow")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code='06' and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("openwell");
		habset5=(HashSet)session.getAttribute("hpSet");
		habset4=(HashSet)session.getAttribute("dpSet");
		habset3=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}
	else if(assettype.equals("o")){
		qry="select distinct nvl(c.dname,'-'),nvl(c.mname,'-'),nvl(c.pname,'-'),nvl(c.vname,'-'),nvl(c.panch_code,'-'),nvl(c.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,0),nvl(CENSUS_SC_POPU,0),nvl(CENSUS_ST_POPU,0),nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(c.COVERAGE_STATUS,'-'),a.TYPE_OF_ASSET_CODE from rws_asset_mast_tbl a,rws_asset_hab_tbl b,rws_complete_hab_View c where a.asset_code=b.asset_code and b.hab_code=c.panch_code and type_of_asset_code in ('07','08','10','11','12') and c.dcode='"+dcode+"' ";
		habset=(HashSet)session.getAttribute("othersSet");
		habset6=(HashSet)session.getAttribute("openwell");
		habset5=(HashSet)session.getAttribute("hpSet");
		habset4=(HashSet)session.getAttribute("dpSet");
		habset3=(HashSet)session.getAttribute("mpwsSet");
		habset2=(HashSet)session.getAttribute("pwsSet");
		habset1=(HashSet)session.getAttribute("cpwsSet");
	}
}
System.out.println("qry is="+qry);
st=conn.createStatement();
rst=st.executeQuery(qry);
if(rpttype.equals("asset")){
%>
<tr>
		<td align="center" class="gridhdbg" colspan="6">Asset Details</td>
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
		<td align="center" class="gridhdbg" colspan="8">Habitation Details</td>
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
		if(habset1.contains(rst.getString(5))){}else{
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
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5))){}else{
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
	else{
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
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5)) || habset4.contains(rst.getString(5))){}else{
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
	}else if(assettypecode.equals("06")){
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5)) || habset4.contains(rst.getString(5)) || habset5.contains(rst.getString(5))){}else {
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
	}else{
	if(habset1.contains(rst.getString(5)) || habset2.contains(rst.getString(5)) || habset3.contains(rst.getString(5)) || habset4.contains(rst.getString(5)) || habset5.contains(rst.getString(5)) || habset6.contains(rst.getString(5))){}else{
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
	}
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