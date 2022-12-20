<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<html>
<head>
	<script language="JavaScript">
		function wopen(url, name, w, h){
			w += 32;
			h += 96;
			var win = window.open(url, name, 
			  'width=' + w + ', height=' + h + ', ' +
			  'location=yes, menubar=no, ' +
			  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');	 
			 win.focus();
		}
		
		function viewWorks(URL){
			var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
			if(URL!=""){
				myNewWin = window.open(URL,'newWinddow',popFeatures);
				myNewWin.focus();	
			}	
		}
	</script>
</head>
<body>
<form>
	<%
		String dcode=request.getParameter("district");
		session.setAttribute("dcode",dcode);
		String mcode=request.getParameter("mandal");
		session.setAttribute("mcode",mcode);
		String habcode=request.getParameter("hab");
		session.setAttribute("habcode",habcode);
		String data=request.getParameter("datadwn");
		nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
		int sno=1;
	    String qry="";
	    int styleCount=0;
	    String style="";     
   	%>
	<table width="60%" border=1 style="border-collapse:collapse"  align="center" >
    	<tr colspan="14">
			<td align="center" class="rptHeading" >Data For Download</td>
		</tr> 
	    <% 	if(data!=null && !data.equals("") && data.equals("SO")){  %>
		<tr>	
			<td>Sl.No</td>
		    <td>District</td>
		    <td>Mandal</td>
		    <td>Panchayat</td> 
			<td>Village</td>
		    <td>Habitation Code /<Br>Habitation Name</td>
		    <td>Source Code</td>
		    <td>Source Name</td>
		    <td>Asset Code</td>
		    <td>Location</td>
		    <td>Safe Lpcd</td>  
		</tr>
		<% } else{	%>		
		<tr>		
			<td>Sl.No</td>
		    <td>District</td>
		    <td>Mandal</td>
		    <td>Panchayat</td> 
			<td>Village</td>
		    <td>Habitation Code /<Br>Habitation Name</td>
		    <td>Asset Code</td>
		    <td>Asset Name</td>
		    <td>Location</td>
		    <td>Asset Status</td>  
		</tr>	
		<% } try {
	   		PreparedStatement stmt8=null;
	   		ResultSet rs8=null;
	   		if(data!=null && !data.equals("") && data.equals("SO")){
	   			qry="select dname,mname,pname,vname,hab_code,panch_name,source_code,nvl(Source_name,'-'),asset_code,nvl(Location,'-'),safe_lpcd from rws_source_tbl a,rws_complete_hab_view b  where a.hab_code=b.panch_code and  a.hab_code= ? ";
			} else  {
		   		qry="select dname,mname,pname,vname,HAB_CODE,panch_name,asset_code,nvl(asset_name,'-'),nvl(location,'-'),ASSET_STATUS  from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and a.hab_code= ? "; 
			}
	   		stmt8=conn.prepareStatement(qry);
	   		stmt8.setString(1, habcode);
	   		rs8=stmt8.executeQuery();
	   		while(rs8.next()) {  	
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;	
			 if(data!=null && !data.equals("") && data.equals("SO")){
		%>
		<tr>	
			<td> <%=sno++%></td>
			<td> <%=rs8.getString(1)%></td>
			<td> <%=rs8.getString(2)%></td>
			<td> <%=rs8.getString(3)%></td>
			<td> <%=rs8.getString(4)%></td>
			<td> <%=rs8.getString(5)%>&nbsp;</br><%=rs8.getString(6)%></td>
			<td> <%=rs8.getString(7)%></td>
			<td> <%=rs8.getString(8)%></td>
			<td> <%=rs8.getString(9)%></td>
			<td> <%=rs8.getString(10)%></td>
			<td> <%=rs8.getString(11)%></td>
	   	</tr> 
	   	<%	}else{ 		%>
	   	<tr>
	   		<td> <%=sno++%></td>
	   		<td> <%=rs8.getString(1)%></td>
			<td> <%=rs8.getString(2)%></td>
			<td> <%=rs8.getString(3)%></td>
			<td> <%=rs8.getString(4)%></td>
			<td> <%=rs8.getString(5)%>&nbsp;</br><%=rs8.getString(6)%></td>
	   		<td> <%=rs8.getString(7)%></td>	
	   		<td> <%=rs8.getString(8)%></td>	
	   		<td> <%=rs8.getString(9)%></td>	
	   		<td> <%=rs8.getString(10)%></td>	   		
	   	</tr>
	   	<%		}
			  }	
		   }catch(Exception e){
				System.out.println("The Exception is in the rws_DataDownload_Excel : " + e.getMessage());
			}
		%>    
	</table>
	<p align=center>
		<%@ include file = "/commons/rws_footer.jsp" %>
	</p>
</form>
</body>
</html>