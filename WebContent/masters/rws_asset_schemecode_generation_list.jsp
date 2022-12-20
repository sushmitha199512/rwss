<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL){
	var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h){
	w += 32;
	h += 96;
 	var win = window.open(url,
  	name, 
  	'width=' + w + ', height=' + h + ', ' +
  	'location=yes, menubar=no, ' +
 	'status=yes, toolbar=no, scrollbars=yes, resizable=yes'); 
	 win.focus();
}
</script>
<form>
<%
	String qry="";
    int styleCount=0;
    String style="";
  	ArrayList assets=(ArrayList)session.getAttribute("assets");  
%>
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">	
				<td ><a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a>	</td>
				<td ><a href="javascript:onclick=history.go(-1)">Back |&nbsp;</a> </td>
				<td ><a href="rws_asset_schemecode_generation_list_xls.jsp">Excel  &nbsp;</a> </td>	 
			</tr>  	
		</table>
	</caption>
   	 
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   		<tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Asset Scheme Code Generated List</b></td>		
		</tr>  
	 	<tr>	
			<td class=gridhdbg>Sl.No</td>
		    <td class=gridhdbg>Asset Code</td>
		    <td class=gridhdbg>Scheme Code</td>
		    <td class=gridhdbg>Asset Name</td>
		    <td class=gridhdbg>Location</td>
		    <td class=gridhdbg>Cost of Asset</td>
		    <td class=gridhdbg>Start Year</td>
		    <td class=gridhdbg>District</td>
		    <td class=gridhdbg>Mandal</td>
		    <td class=gridhdbg>Panchayat</td>
		    <td class=gridhdbg>Village</td>
		    <td class=gridhdbg>Habitation Name</td>
		    <td class=gridhdbg>Habitation Code</td>   
       </tr>	
     <%    
     	try{
	    	 PreparedStatement stmt1=null;
	         ResultSet rs1=null;
	         int sno=1;
	         Iterator iterator=assets.iterator();
	         while(iterator.hasNext()){
        	 	String asset_code=(String)iterator.next();
         		qry="select a.ASSET_CODE as ASSET_CODE,nvl(ASSET_NAME,'--') as ASSET_NAME,HAB_CODE,nvl(LOCATION,'--') as LOCATION,DATE_CREATION,ASSET_STATUS,ASSET_COST,nvl(START_YEAR,'--') as START_YEAR,scheme_code,DNAME,MNAME,PNAME,VNAME,PANCH_CODE,PANCH_NAME  from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and a.asset_code= ? ";
         		stmt1=conn.prepareStatement(qry);   
         		stmt1.setString(1, asset_code);
         		rs1=stmt1.executeQuery();       
         		if(rs1.next())	{        	
					 if(styleCount%2==0){
						 style="gridbg1";
					 }else{
						 style="gridbg2";
					 }
 					styleCount++;
	 %>   
      <tr>	
		  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>      
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("ASSET_CODE")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("SCHEME_CODE")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("ASSET_NAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("LOCATION")%></td>
	      <td class="<%=style%> "style="text-align: right;"><%= rs1.getString("ASSET_COST")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("START_YEAR")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("DNAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("MNAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PNAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("VNAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PANCH_NAME")%></td>
	      <td class="<%=style%> "style="text-align: left;"><%= rs1.getString("PANCH_CODE")%></td>            
     </tr>    
    <%			}
         	}
    	 } catch(Exception e){
    		 System.out.println("The Exception in rws_asset_schemecode_generation_list is  = "+e.getMessage());
	     }
    %>
   </table>
</table>
<p align=center>
	<%@ include file = "/commons/rws_footer.jsp" %>
</p>
<%
 	if(request.getAttribute("message")!=null) {	
		 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
		var mess="<%=message%>";
		alert(mess)
	</script>
<% } %>