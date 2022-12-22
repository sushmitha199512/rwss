
<%@ include file="conn.jsp"%>
<%@ page import="java.text.DecimalFormat"%>

<body>
<%

DecimalFormat  df = new DecimalFormat("##0.00000");

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_bluefrog_rpt_excel. xls");


String district=(String)session.getAttribute("district");
String component=(String)session.getAttribute("component");
String reporttype=(String)session.getAttribute("report");




//System.out.println("report type is "+reporttype);
//out.println("district "+district);
//out.println("component "+component);

Statement stmt3=null;
ResultSet rs3=null;
String qry="";

//If "Scheme" is selected
reporttype="rpt1";

if(component!=null && component.equals("Scheme"))
{
	
			
qry="select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude,c.longitute,c.source_code from rws_asset_mast_tbl a, rws_blue_frog_assets_tbl c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.HAB_CODE ,1,2)=e.dcode and substr(a.HAB_CODE ,6,2)=e.mcode  and substr(a.HAB_CODE ,1,2)=f.dcode and substr(a.HAB_CODE ,6,2)=f.mcode and substr(a.HAB_CODE ,13,2)=f.pcode and substr(c.asset_code,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district+"'  ";
	
	
			
}

// If "GLSR" is selected

else if(component!=null && component.equals("GLSR"))
{
	qry="select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude,c.longitute,c.source_code from RWS_AST_GLSR_SC_PARAM_TBL a, rws_blue_frog_assets_tbl c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.GLSR_CODE ,1,2)=e.dcode and substr(a.GLSR_CODE ,6,2)=e.mcode  and substr(a.GLSR_CODE ,1,2)=f.dcode and substr(a.GLSR_CODE ,6,2)=f.mcode and substr(a.GLSR_CODE ,13,2)=f.pcode and substr(c.asset_code,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district+"' and substr(c.source_code,20,2)='GL'";	

}

// If "OHSR" is selected

else if(component!=null && component.equals("OHSR"))
{
	qry="select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude,c.longitute,c.source_code from RWS_AST_OHSR_SC_PARAM_TBL a, rws_blue_frog_assets_tbl c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.OHSR_CODE ,1,2)=e.dcode and substr(a.OHSR_CODE ,6,2)=e.mcode  and substr(a.OHSR_CODE ,1,2)=f.dcode and substr(a.OHSR_CODE ,6,2)=f.mcode and substr(a.OHSR_CODE ,13,2)=f.pcode and substr(c.asset_code,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district+"' and substr(c.source_code,20,2)='OS'";
}

// If "HP" is selected

else if(component!=null && component.equals("HP"))
{
	qry="select d.dname,e.mname,f.pname,a.asset_code,b.type_of_asset_name,a.latitude,a.longitude,c.latitude,c.longitute,c.source_code from RWS_HP_SUBCOMP_PARAM_TBL a, rws_blue_frog_assets_tbl c,rws_district_tbl d, rws_mandal_tbl e,rws_panchayat_tbl f,rws_asset_type_tbl b where a.asset_code=c.asset_code and substr(a.asset_code ,5,2)=d.dcode and substr(a.HP_CODE ,1,2)=e.dcode and substr(a.HP_CODE ,6,2)=e.mcode  and substr(a.HP_CODE ,1,2)=f.dcode and substr(a.HP_CODE ,6,2)=f.mcode and substr(a.HP_CODE ,13,2)=f.pcode and substr(c.asset_code,7,2)=b.type_of_asset_code and substr(a.asset_code ,5,2)='"+district+"' and substr(c.source_code,20,2)='HP' ";
	
}
%>

<script language=JavaScript>
	//var mess="<%=qry%>";
	//var comp="<%=component %>";
	//var rType="<%=reporttype %>";
	//alert(mess);
	//alert(comp);
	//alert(rType);
	
	</script>

<table border=1 cellspacing=0 cellpadding=0 width="80%"
	bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff"
	align="center">
	<tr>

		<td align="center" class="gridhdbg" colspan="13">Blue Frog Asset Deviation Details Report</td>
		
	</tr>
	<tr>
	    <td align="center" class="gridhdbg" colspan="13">Scheme:<%=component%></td>
	
	</tr>
	<tr>
	
	<td align="center" class="gridhdbg" colspan=7 ></td>
	     <td align="center" class="gridhdbg" colspan=2 nowrap><b> RWS </b></td> 
	      <td align="center" class="gridhdbg"  colspan=2 nowrap><b> BLUE FROG </b> </td> 
	      <td align="center" class="gridhdbg" colspan=2 nowrap><b> DEVIATIONS </b></td>
	      <td align="center" class="gridhdbg"></td>
	    
	</tr>
	<tr>
	<td align="center" class="gridhdbg">Sl.No</td>
    <td align="center" class="gridhdbg">District</td>
    <td align="center" class="gridhdbg">Mandal</td>
    <td align="center" class="gridhdbg">Panchayat</td>
	<td align="center" class="gridhdbg">Asset Code</td>
       <td align="center" class="gridhdbg">Scheme</td>
       <td align="center" class="gridhdbg">Component Code</td>
     
	<td align="center" class="gridhdbg"> Latitude</td>
	<td align="center" class="gridhdbg"> Longitude</td>
	
	<td align="center" class="gridhdbg">  Latitude</td>
	<td align="center" class="gridhdbg"> Longitude</td>
	
	<td align="center" class="gridhdbg">Latitude Deviation</td>
	<td align="center" class="gridhdbg">Longitude Deviation</td>
		
	
	</tr>
	
	<%
	try{
		System.out.println("qryyy********** "+reporttype+qry);
	
		
		stmt3=conn.createStatement();
		rs3=stmt3.executeQuery(qry);
		int i=1;
	
		
		while(rs3.next()){
			
			
			//////////////////////////////////////////////
			
			// RWS latitude and Longitude variables
			double Rlatitude;
			double Rlongitute;
			Rlatitude=rs3.getDouble(6);
			Rlongitute=rs3.getDouble(7);
			
			
			// Blue Frog latitude and Longitude variables
			double BFlatitude;
			double BFlongitute;
			BFlatitude=rs3.getDouble(8);
			BFlongitute=rs3.getDouble(9);
			
			
			// Deviation latitude and Longitude variables
			double Dlatitude;
			double Dlongitute;
			Dlatitude=Rlatitude - BFlatitude;
			
			Dlongitute=Rlongitute - BFlongitute;
			
			
			//////////////////////////////////////////////
			
			%>
			<tr>
			<td class="gridbg1" style="text-align: right;"><%=i %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString(1) %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString(2) %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString(3) %></td>
			<td class="gridbg1" style="text-align: right;"><%=rs3.getString(4) %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString(5) %></td>
			<td class="gridbg1" style="text-align: left;"><%=rs3.getString(10) %></td>
			
			
			<td class="gridbg1" style="text-align: right;"><%=rs3.getDouble(6) %></td>
			<td class="gridbg1" style="text-align: right;"><%=rs3.getDouble(7) %></td>
			
			
			<td class="gridbg1" style="text-align: right;"><%=df.format(rs3.getDouble(8)) %></td>
			<td class="gridbg1" style="text-align: right;"><%=df.format(rs3.getDouble(9)) %></td>
		
			 <td class="gridbg1" style="text-align: right;"> <%=Dlatitude %></td>
			<td class="gridbg1" style="text-align: right;"> <%=Dlongitute %></td>
			</tr>
			
			<% i++;
			
		}
		
		
		///////
		
		if(i==1)
		{
			System.out.println("********************");
			out.println("No Records Available");
			//alert("No records Available");
		%>		
			
			<tr>
			<td colspan=12 align=center > <b style="text-align: center; color: blue"> No Records Available</b></td>
			</tr>
	
		<%}
	
		
		
		///////
		
		
		
		
		if(stmt!=null){
		  stmt.close();
	  }
	  if(rs!=null){
		  rs.close();
	  }
	}

catch(Exception e)
{
      e.printStackTrace();
}
	%>
	
	
	</table>
	


</body>
</html>