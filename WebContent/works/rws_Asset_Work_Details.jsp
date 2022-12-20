<%@	page import="java.sql.*, java.util.* " %>
<%@ include file = "/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<script language="javascript">


 function sourceSelected(index)
{
var index1='<%=request.getParameter("index")%>';
if(document.forms[0].astradio.length==undefined)
{
  if(document.forms[0].astradio.checked==true)
 {
  var workid=document.forms[0].astradio.value;   

 window.opener.document.getElementById("assets"+index1).value=workid;  
 self.close(); 
  }
}
else{
for(var i=0;i<document.forms[0].astradio.length;i++)
{
 if(document.forms[0].astradio[i].checked==true)
 {
  var workid=document.forms[0].astradio[i].value;   
 window.opener.document.getElementById("assets"+index1).value=workid;  
break;
}
 }

self.close(); 
 }
}

function winclose()
{
 window.close();
}
 
</script>
<html>
<body>
<form>


<% 		
String astwrk=request.getParameter("astwrk");
String asttype = request.getParameter("asttype");
String index = request.getParameter("index");
String cir=request.getParameter("circle");
String div=request.getParameter("divcode");
String subdiv=request.getParameter("subdiv");

%>
<% String qry1="select CIRCLE_OFFICE_NAME,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_NAME from rws_complete_office_view where ";
     if(cir!=null && !cir.equals(""))
	   {
		   qry1 +="  circle_office_code='"+cir+"'";
	   }
	    if(div!=null && !div.equals(""))
	   {
		 qry1 +=" and  division_office_code='"+div+"'";
	   }
	    if(subdiv!=null && !subdiv.equals(""))
	   {
	     qry1 +=" and  subdivision_office_code='"+subdiv+"'";
	   }
  PreparedStatement st1 = null;
   ResultSet rs1 = null;
   st1=conn.prepareStatement(qry1);
   rs1=st1.executeQuery();%>
 <table border = 0 width=740 align=center>   
<tr>
<td align=right colspan=8>
<A HREF="javascript:winclose()">Close</A>&nbsp;</td></tr>
<%if(rs1.next()){ %>
  
  <tr>
  <td class=btext colspan=8 nowrap align=center>
     <%if(cir!=null && !cir.equals("")){%>
	 Circle:<font face=verdana size=2><%=rs1.getString(1)%></font>&nbsp;&nbsp;&nbsp;&nbsp;
     <%}if(div!=null && !div.equals("")){ %> 
	Division:<font face=verdana size=2><%=rs1.getString(2)%>&nbsp;&nbsp;&nbsp;&nbsp;
	 <% }if(subdiv!=null && !subdiv.equals("")){%>
	 Subdivision:<font face=verdana size=2><%=rs1.getString(3)%>	
		<%} %>
<%}%>
</tr>
</table>

<table border="1" cellspacing=0 cellpadding=0 width="740"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">

   

<%
	try{

   String getMandals = "";
   if(astwrk.equals("1")){
	
	   getMandals = "select asset_code,asset_name,nvl(LOCATION,'-'),nvl(to_char(DATE_CREATION,'dd-MM-yyyy'),'-'),decode(ASSET_STATUS,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED','','-'),nvl(ASSET_COST,0),b.mname,b.pname,b.panch_name from rws_asset_mast_tbl a,rws_complete_hab_view b where a.hab_code=b.panch_code and type_of_asset_code='"+asttype+"'";
	   if(cir!=null && !cir.equals(""))
	   {
		   getMandals +=" and  circle_office_code='"+cir+"'";
	   }
	    if(div!=null && !div.equals(""))
	   {
		 getMandals +=" and  division_office_code='"+div+"'";
	   }
	    if(subdiv!=null && !subdiv.equals(""))
	   {
	     getMandals +=" and  subdivision_office_code='"+subdiv+"'";
	   }%>
	   <tr>
				 <td class=btext>S.No.</td>
				<td class=btext>select</td>
				<td class=btext>Asset Code</td>
				<td class=btext>Asset Name</td>
				<td class=btext>Asset Hab Mandal</td>
				<td class=btext>Asset Hab Panchayat</td>
				<td class=btext>Asset Main Habitation</td>
				<td class=btext>Asset Location</td>
				<td class=btext>Date&nbsp;of&nbsp;Creation</td>
				<td class=btext>Asset Status</td>
				<td class=btext>Asset Cost<br>(Rs. In Lakhs)</td>			
			 
			</tr>
		
	 <% 
	 PreparedStatement gmst = conn.prepareStatement(getMandals);
   ResultSet gmrs = gmst.executeQuery();
   String ast1="";
   if(request.getParameter("asts")!=null && !request.getParameter("asts").equals(""))
   ast1=request.getParameter("asts");
   int slno=0;
  while(gmrs.next())
  {
   
%>

	   <tr>
	     <td class=rptValue><%=++slno%></td>
	     <%
	     // System.out.println("ast1:"+ast1);
	     if(ast1!=null && !ast1.equals("") && ast1.substring(0,14).equals(gmrs.getString(1))){ %>
	     <td class=rptValue><input type="radio" name="astradio" checked onclick="sourceSelected(<%=slno%>)" value="<%=gmrs.getString(1)%>-<%=gmrs.getString(2)%>"></td>
	     <% }else{ %>
	     <td class=rptValue><input type="radio" name="astradio" onclick="sourceSelected(<%=slno%>)" value="<%=gmrs.getString(1)%>-<%=gmrs.getString(2)%>"></td><%}%>
	     <td class=rptValue><%=gmrs.getString(1)%></td>
	     <td class=rptValue><%=gmrs.getString(2)%></td>
	     <td class=rptValue><%=gmrs.getString(7)%></td>
	     <td class=rptValue><%=gmrs.getString(8)%></td>
		 <td class=rptValue><%=gmrs.getString(9)%></td>
		 <td class=rptValue><%=gmrs.getString(3)%></td>
	     <td class=rptValue><%=gmrs.getString(4)%></td>
	     <td class=rptValue><%=gmrs.getString(5)%></td>
	     <td class=rptValue><%=gmrs.getString(6)%></td>
	   </tr>
	   <%}
	   if(slno==0)
	   {%>
	   <tr>
	  <td colspan=8 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
	   <%}
	  } 
   else   if(astwrk.equals("2"))
		{
		getMandals = "select work_id,work_name,ADMIN_NO,to_char(ADMIN_DATE,'dd-MM-yyyy'),SANCTION_AMOUNT,lead_habitation  from rws_work_admn_tbl where substr(work_id,7,2)='"+asttype+"' and aug_new_code='1'";
		if(cir!=null && !cir.equals(""))
	   {
		   getMandals +=" and  substr(office_code,2,2)='"+cir+"'";
	   }
	    if(div!=null && !div.equals(""))
	   {
		 getMandals +=" and  substr(office_code,4,1)='"+div+"'";
	   }
	   if(subdiv!=null && !subdiv.equals(""))
	   {
	     getMandals +=" and  substr(office_code,5,2)='"+subdiv+"'";
	   } 
	   %>
	    <tr>
				 <td class=btext>S.No.</td>
				<td class=btext>select</td>
				<td class=btext>Work Id</td>
				<td class=btext>Work Name</td>
				<td class=btext>LeadHab Mandal</td>
				<td class=btext>LeadHab Panchayat</td>
				<td class=btext>Lead Habitation</td>
				<td class=btext>Admin Sanction No</td>
				<td class=btext>AdminSanction Date</td>
				<td class=btext>Sanction Amount<br>(Rs. In Lakhs)</td>		
	   
		<%
		
	PreparedStatement gmst = conn.prepareStatement(getMandals);
   ResultSet gmrs = gmst.executeQuery();
    String ast1="";
   if(request.getParameter("asts")!=null && !request.getParameter("asts").equals(""))
   ast1=request.getParameter("asts");
   int slno=0;
  
  
  while(gmrs.next())
  {
	  String mname="-",pname="-",habname="-";
	  if(gmrs.getString(6)!=null && !gmrs.getString(6).equals(""))
	  {
		  String qqq = "select * from rws_complete_hab_view where panch_code='"+gmrs.getString(6)+"'";
		  PreparedStatement qqqst = conn.prepareStatement(qqq);
		  ResultSet qqqrs = qqqst.executeQuery();
		  if(qqqrs.next())
		  {
				mname = qqqrs.getString("mname");
				pname = qqqrs.getString("pname");
				habname = qqqrs.getString("panch_name");
		  }
	  }
%>

	   <tr>
	      <td class=rptValue><%=++slno%></td>
	    
        <%if(ast1!=null && !ast1.equals("") && ast1.substring(0,14).equals(gmrs.getString(1))){ %>
	     <td class=rptValue><input type="radio" name="astradio" checked onclick="sourceSelected(<%=slno%>)" value="<%=gmrs.getString(1)%>-<%=gmrs.getString(2)%>"></td>
	     <% }else{ %>
	     <td class=rptValue><input type="radio" name="astradio" onclick="sourceSelected(<%=slno%>)" value="<%=gmrs.getString(1)%>-<%=gmrs.getString(2)%>"></td><%}%>
	     <td class=rptValue><%=gmrs.getString(1)%></td>
	     <td class=rptValue><%=gmrs.getString(2)%></td>
	     <td class=rptValue><%=mname%></td>
	     <td class=rptValue><%=pname%></td>
	     <td class=rptValue><%=habname%></td>
	     <td class=rptValue><%=gmrs.getString(3)%></td>
	     <td class=rptValue><%=gmrs.getString(4)%></td>
	     <td class=rptValue><%=gmrs.getString(5)%></td>
	   </tr>
	   <%}
	    if(slno==0){%>
	  <tr>
	  <td colspan=8 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
		<%} 
      }
	   }catch(Exception e)
	   {
		 System.out.println("exception in rws-Asset_Work_Details-- " +e);
	   }%>
</table>
</form>
</body>
</html>
