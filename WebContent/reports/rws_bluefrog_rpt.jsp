<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


  
    <link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table-fixed-header.css'/>">
    <script language="JavaScript" src="<rws:context page='/resources/javascript/jquery-1.7.2.min.js'/>"></script>
    <script language="JavaScript" src="<rws:context page='/resources/javascript/table-fixed-header.js'/>"></script>
    

<body>

<%

DecimalFormat  df = new DecimalFormat("##0.00000");
StringBuffer qry=new StringBuffer();
StringBuffer notworkreason=new StringBuffer();
StringBuffer safelpd=new StringBuffer();
StringBuffer district=new StringBuffer();
district.append(request.getParameter("district"));
session.setAttribute("district",district);

//String district=request.getParameter("district");
//String component=request.getParameter("component");

StringBuffer component=new StringBuffer();
component.append(request.getParameter("component"));
session.setAttribute("component",component);

StringBuffer reporttype=new StringBuffer();
reporttype.append(request.getParameter("reporttype"));
//String reporttype=request.getParameter("report");
session.setAttribute("reporttype",reporttype);




//System.out.println("report type is "+reporttype);
//out.println("district "+district);
//out.println("component "+component);

Statement stmt3=null;
ResultSet rs3=null;
//String qry="";

//If "Scheme" is selected
reporttype.append("rpt1");

if(component!=null && component.toString().equals("Scheme"))
{
	
	qry.delete(0,qry.length());		
qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.LATITUDE as lat,c.LONGITUDE as longi,c.sourcecode,c.YIELD,c.SURVEYDATE,c.ASSETSTATUS,c.ASSETNOTWORKINGREASONS ,c.ASSETLOCATION  from rws_asset_mast_tbl a, RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.ASSETCODE  and substr(a.asset_code ,5,2)=d.dcode and substr(a.HAB_CODE ,1,2)=e.dcode and substr(a.HAB_CODE ,6,2)=e.mcode  and substr(a.HAB_CODE,1,2)=f.dcode and substr(a.HAB_CODE ,6,2)=f.mcode and substr(a.HAB_CODE ,13,2)=f.pcode and substr(c.ASSETCODE,7,2)=b.type_of_asset_code and substr(a.asset_code,5,2)='"+district.toString()+"'  ");
	//	System.out.println("scheme qry"+qry);
	
			
}

// If "GLSR" is selected

else if(component!=null && component.toString().equals("GLSR"))
{
	qry.delete(0,qry.length());	
	//qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE as longi ,c.sourcecode,c.YIELD,c.SURVEYDATE,c.ASSETSTATUS,c.ASSETNOTWORKINGREASONS,c.ASSETLOCATION  from RWS_AST_GLSR_SC_PARAM_TBL a, Rws_Bluefrog_Asset_Mast c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.assetcode and substr(a.asset_code ,5,2)=d.dcode and substr(a.GLSR_CODE,1,2)=e.dcode and substr(a.GLSR_CODE,6,2)=e.mcode  and substr(a.GLSR_CODE ,1,2)=f.dcode and substr(a.GLSR_CODE ,6,2)=f.mcode and substr(a.GLSR_CODE ,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='GL'");
	qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE as longi ,c.sourcecode,c.YIELD,nvl(h.SAFE_LPCD,0),to_char(c.SURVEYDATE),c.ASSETSTATUS,nvl(c.ASSETNOTWORKINGREASONS,'-'),c.ASSETLOCATION,nvl(g.ASSET_STATUS,'0')  from RWS_AST_GLSR_SC_PARAM_TBL a,RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_asset_mast_tbl g,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b,rws_habitation_directory_tbl h where h.hab_code=g.hab_code and a.asset_code=c.assetcode and a.asset_code=g.asset_code and c.assetcode=g.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.GLSR_CODE,1,2)=e.dcode and substr(a.GLSR_CODE,6,2)=e.mcode  and substr(a.GLSR_CODE ,1,2)=f.dcode and substr(a.GLSR_CODE ,6,2)=f.mcode and substr(a.GLSR_CODE ,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='GL'");
	//System.out.println("glsr qry"+qry);
}

// If "OHSR" is selected

else if(component!=null && component.toString().equals("OHSR"))
{
	qry.delete(0,qry.length());	
	qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE  as longi,c.sourcecode,c.YIELD,h.SAFE_LPCD,to_char(c.SURVEYDATE),c.ASSETSTATUS,nvl(c.ASSETNOTWORKINGREASONS,'-') ,c.ASSETLOCATION,nvl(g.ASSET_STATUS,'0') from RWS_AST_OHSR_SC_PARAM_TBL a,RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b,rws_habitation_directory_tbl h,rws_asset_mast_tbl g where h.hab_code=g.hab_code and a.asset_code=c.assetcode and a.asset_code=g.asset_code and c.assetcode=g.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.OHSR_CODE ,1,2)=e.dcode and substr(a.OHSR_CODE ,6,2)=e.mcode  and substr(a.OHSR_CODE ,1,2)=f.dcode and substr(a.OHSR_CODE ,6,2)=f.mcode and substr(a.OHSR_CODE ,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='OS' ");
	//System.out.println("ohsr qry"+qry);
}

// If "HP" is selected

else if(component!=null && component.toString().equals("HP"))
{
	qry.delete(0,qry.length());	
	qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE  as longi,c.sourcecode,c.YIELD,nvl(a.SAFE_LPD,0) as lpd,to_char(c.SURVEYDATE),c.ASSETSTATUS,c.ASSETNOTWORKINGREASONS ,c.ASSETLOCATION,nvl(a.STATUS,'-')  from RWS_HP_SUBCOMP_PARAM_TBL a, RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.assetcode and substr(a.asset_code ,5,2)=d.dcode and substr(a.HP_CODE ,1,2)=e.dcode and substr(a.HP_CODE ,6,2)=e.mcode  and substr(a.HP_CODE ,1,2)=f.dcode and substr(a.HP_CODE ,6,2)=f.mcode and substr(a.HP_CODE ,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='HP' ");
	//System.out.println("HPqry"+qry);
}

else if(component!=null && component.toString().equals("OW"))
{
	qry.delete(0,qry.length());	
	qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE  as longi,c.sourcecode,c.YIELD,nvl(a.SAFE_LPD,0) as lpd,to_char(c.SURVEYDATE) as surveydate,c.ASSETSTATUS,nvl(c.ASSETNOTWORKINGREASONS,'-'),c.ASSETLOCATION,nvl(a.STATUS,'-')  from RWS_OPEN_WELL_MAST_TBL a, RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.assetcode and substr(a.asset_code ,5,2)=d.dcode and substr(a.OPENWELL_CODE,1,2)=e.dcode and substr(a.OPENWELL_CODE,6,2)=e.mcode  and substr(a.OPENWELL_CODE,1,2)=f.dcode and substr(a.OPENWELL_CODE,6,2)=f.mcode and substr(a.OPENWELL_CODE,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='OW' ");
	//System.out.println("HPqry"+qry);
}

else if(component!=null && component.toString().equals("SO"))
{
	qry.delete(0,qry.length());	
	qry.append("select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude as lat,c.LONGITUDE as longi,c.sourcecode,c.YIELD,nvl(a.SAFE_LPD,0) as lpd,to_char(c.SURVEYDATE) ,c.ASSETSTATUS,nvl(c.ASSETNOTWORKINGREASONS,'-') ,c.ASSETLOCATION,nvl(a.STATUS,'-')  from RWS_SOURCE_TBL  a, RWS_BLUEFROG_ASSET_MAST_TBL  c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.assetcode and substr(a.asset_code ,5,2)=d.dcode and substr(a.SOURCE_CODE ,1,2)=e.dcode and substr(a.SOURCE_CODE,6,2)=e.mcode  and substr(a.SOURCE_CODE,1,2)=f.dcode and substr(a.SOURCE_CODE,6,2)=f.mcode and substr(a.SOURCE_CODE,13,2)=f.pcode and substr(c.assetcode,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district.toString()+"' and substr(c.sourcecode,20,2)='SO' ");
	//System.out.println("HPqry"+qry);
}
%>

<script language=JavaScript>
	var mess="<%=qry.toString()%>";
	var comp="<%=component.toString() %>";
     var rType="<%=reporttype %>";
	//alert(mess);
	//alert(comp);
	//alert(rType);
	
	</script>
<table border=0 rules=none style="border-collapse: collapse"
		align="right">


		<div class='container'>
		<tr>
			<td align="right" class="bwborder"><a
				href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
			<td class="bwborder"><a href="./rws_bluefrog_frm.jsp">Back|</a>
		</tr>
		</table>
		<table>
		<tr>

	<td>
	<p align=center style="font-size: small">
	<b>Note:</b>
	<br>
	1.&nbsp;&nbsp;<img alt="" src="/pred/images/GREEN.jpg" height="10px" width="10px"> ---> Indicates "No Deviation(Difference)."
	<br>
	&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;<img alt="" src="/pred/images/RED.jpg" height="10px" width="10px"> ---> Indicates "Having Deviation(Diffence)."
	</p>
		
	</td>
	</tr>
	</table>
	  <div class='container'>
	 <h2 id='mynav'></h2>
<table  width="80%" class='table table-bordered table-striped table-fixed-header'> 
	
	<thead  class='header'>
	<tr>

		<th align="center" class="gridhdbg" colspan="22">Blue Frog  Details Report</th>
		
	</tr>
	<tr>
	    <th align="center" class="gridhdbg" colspan="22">Scheme:<%=component.toString()%></th>
	
	</tr>
	
	<tr>
	
	<th align="center" class="gridhdbg" colspan=7 ></th>
	     <th align="center" class="gridhdbg" colspan=2 nowrap><b> RWS </b></th> 
	      <th align="center" class="gridhdbg"  colspan=2 nowrap><b> BLUE FROG </b> </th> 
	       <th align="center" class="gridhdbg" colspan=1 nowrap><b> RWS </b></th> 
	      <th align="center" class="gridhdbg"  colspan=5 nowrap><b> BLUE FROG </b> </th>
	      
	     <th align="center" class="gridhdbg" colspan=2 nowrap><b> DEVIATIONS </b></th>
	      <th align="center" class="gridhdbg"></th>
	    
	</tr>
	<tr>
	<th align="center" class="gridhdbg">Sl.No</th>
    <th align="center" class="gridhdbg">District</th>
    <th align="center" class="gridhdbg">Mandal</th>
    <th align="center" class="gridhdbg">Panchayat</th>
	<th align="center" class="gridhdbg">Asset Code</th>
       <th align="center" class="gridhdbg">Scheme</th>
       <th align="center" class="gridhdbg">Component Code</th>
     
	<th align="center" class="gridhdbg"> Latitude</th>
	<th align="center" class="gridhdbg"> Longitude</th>

	<th align="center" class="gridhdbg">  Latitude</th>
	<th align="center" class="gridhdbg"> Longitude</th>
	
	<th align="center" class="gridhdbg">SAFE_LPD</th>
	<th align="center" class="gridhdbg">SAFE_LPD</th>
	<th align="center" class="gridhdbg">SURVEY DATE</th>
	<th align="center" class="gridhdbg">Asset Status</th>
	<th align="center" class="gridhdbg">Asset Not Working Reason</th>
	<th align="center" class="gridhdbg">Asset Location</th>
	<th align="center" class="gridhdbg">Latitude Deviation</th>
	<th align="center" class="gridhdbg">Longitude Deviation</th>
		
			
		
	</tr>

	</thead>
	<tbody>
	<%
	try{
		//System.out.println("qryyy********** "+reporttype+qry);
	
		
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(qry.toString());
		int i=1;
	
		
		while(rs3.next()){
			
			
			
			// RWS latitude and Longitude variables
			double Rlatitude;
			double Rlongitute;
		
			Rlatitude=rs3.getDouble("latitude");
			Rlongitute=rs3.getDouble("longitude");
			
			
			// Blue Frog latitude and Longitude variables
			double BFlatitude;
			double BFlongitute;
	      
			BFlatitude=rs3.getDouble("lat");
		
			BFlongitute=rs3.getDouble("longi");
			// Deviation latitude and Longitude variables
			double Dlatitude;
			double Dlongitute;
			
			
			
			Dlatitude=Rlatitude - BFlatitude;
			
			Dlongitute=Rlongitute - BFlongitute;
			safelpd.delete(0,safelpd.length());
			safelpd.append(rs3.getString(11));
			if(!safelpd.toString().equals("NA"))
			{
				safelpd.delete(0,safelpd.length());
				safelpd.append(rs3.getString(11));
			}
			
			else
			{
				safelpd.delete(0,safelpd.length());
				safelpd.append("0");
			}
			
			notworkreason.delete(0,notworkreason.length());
			notworkreason.append(rs3.getString(15));
			if(!notworkreason.toString().equals("NA"))
			{
				notworkreason.delete(0,notworkreason.length());
				notworkreason.append(rs3.getString(15));
			}
			else
			{
				notworkreason.delete(0,notworkreason.length());
				notworkreason.append("-");
			}
			
			
	
			
			%>
		
			<tr>
			<td class="gridbg1" style="text-align: right;"><%=i %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("dname") %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("mname") %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("pname") %></td>
			<td class="gridbg1" style="text-align: right;"><%=rs3.getString("asset_code") %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("type_of_asset_name") %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("sourcecode") %></td>
			
			
			<td class="gridbg1" style="text-align: right;"><%=rs3.getDouble("latitude") %></td>
			<td class="gridbg1" style="text-align: right;"><%=rs3.getDouble("longitude") %></td>
			
			
			<td class="gridbg1" style="text-align: right;"><%=df.format(rs3.getDouble("lat"))%> </td>
			<td class="gridbg1" style="text-align: right;"><%=df.format(rs3.getDouble("longi")) %></td>
			
			<td class="gridbg1" style="text-align: right;"><%=rs3.getString(12)%></td>
			<td class="gridbg1" style="text-align: right;"><%=safelpd%></td>
			
			<td class="gridbg1" style="text-align: right;"><%=rs3.getString(13) %></td>
			
			

			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("ASSETSTATUS")%></td>
			<td class="gridbg1" style="text-align: left;"><%=notworkreason%></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString("ASSETLOCATION")%></td>
			
			
			
			
			
			
			<% 
			if(Dlatitude==0.0){
			%>
			<td class="gridbg1" style="text-align: center; color: green"> <img alt="" src="/pred/images/GREEN.jpg" height="10px" width="10px"></td>
			<%	
			}else{
				%>
				<td class="gridbg1" style="text-align: center; color: red"> <img alt="" src="/pred/images/RED.jpg" height="10px" width="10px"></td>
				<%
			}
			%>
			<% 
			if(Dlongitute==0.0){
			%>
			<td class="gridbg1" style="text-align: center; color: green " > <img alt="" src="/pred/images/GREEN.jpg" height="10px" width="10px"></td>
	
			<%	
			}else{
				%>
				<td class="gridbg1" style="text-align: center; color: red"> <img alt="" src="/pred/images/RED.jpg" height="10px" width="10px"></td>
				<%
			}
			%>
			<!--  <td class="gridbg1" style="text-align: right;"> <%=Dlatitude %></td>-->
			<!--<td class="gridbg1" style="text-align: right;"> <%=Dlongitute %></td>-->
			</tr>
			
			<% i++;
			
		}
		
	
		
		if(i==1)
		{
			System.out.println("********************");
			out.println("No Records Available");
			
		%>		
			
			<tr>
			<td colspan=12 align=center > <b style="text-align: center; color: blue"> No Records Available</b></td>
			</tr>
	
		<%}
	
		
		
		if(stmt3!=null){
		  stmt3.close();
	  }
	  if(rs3!=null){
		  rs3.close();
	  }
	}

catch(Exception e)
{
      e.printStackTrace();
}
	%>
	
	
	</tbody>
	</table>
	</div>
	
	<script language='javascript' type='text/javascript'>
      $(document).ready(function(){
      $('.table-fixed-header').fixedHeader();
      });
    </script>


</body>
</html>