<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
        String loggedUser = user.getUserId();
		
%>
<html>
<head>
<script>
function fnSubmit()
{
	if(document.f1.component.value=="")
	{
		alert("Please Select component");
	}
	document.f1.action="./rws_bluefrog_frm.jsp";
	 document.f1.submit();
	
}

function getReport()
{
	if(document.f1.component.value=="")
	{
		alert("Please Select component");
	}
	if(document.f1.district.value=="")
	{
		alert("Please Select District");
	}
	
	
	else
		{
	document.f1.action="./rws_bluefrog_rpt.jsp";
	 document.f1.submit();
		}
	
}

</script>

</head>
<%
StringBuffer qry=new StringBuffer();
StringBuffer myasset=new StringBuffer();

Statement stmt1=null;
ResultSet rs1=null;

if(request.getParameter("component")!=null)
{
 myasset.append(request.getParameter("component"));

}

%>



<form name="f1">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=400>
 <caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=2>Blue Frog Asset  Details Report</td>	
	</tr>
	
	<%if(myasset.toString().equals("")){ %>
     <tr><td class=rptLabel>Component:&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
	    <SELECT name="component" id="component" class="mycombo" style="width:150px"  onchange="fnSubmit()">
		<option value="">-Select-</option>
		<option value="SO">Sources</option>
		<option value="GLSR">GLSR</option>
		<option value="OHSR">OHSR</option>
		<option value="HP">Hand Pumps</option>
		<option value="OW">Open Wells</option>
		
		</SELECT>
	</td>
	</tr>

   

<%}else{%>
	<tr><td class=rptLabel>Component:&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
	   	<input type="text" name="component" id="component" class="mycombo" style="width:150px" value="<%=myasset.toString()%>" />

	</td>
	</tr>
	
	
	<%
	
}
try{

	
	
////////////////////////////////////////////  SCHEME    /////////////////////////////
if(myasset!=null && myasset.toString().equals("Scheme"))
{%>
  <tr>
  	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
  	<td class=btext>
	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
	    <option value="">-Select-</option>
	     
	    
	    
  <% 
 	  stmt1=conn.createStatement();
  qry.delete(0,qry.length());
 
  if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
	{
	  qry.append("select distinct dcode,dname from rws_district_tbl,RWS_BLUEFROG_ASSET_MAST_TBL  b,rws_asset_mast_tbl a where b.ASSETCODE =a.ASSET_CODE  and substr(a.asset_code,5,2)=dcode and substr(b.sourcecode,1,2)=dcode  order by dcode");
	}
else
	  {
	 qry.append("select distinct dcode,dname from rws_district_tbl,RWS_BLUEFROG_ASSET_MAST_TBL  b,rws_asset_mast_tbl a where b.ASSETCODE =a.ASSET_CODE  and substr(a.asset_code,5,2)=dcode and substr(b.sourcecode,1,2)=dcode and dcode='"+loggedUser.substring(1,3)+"'  order by dcode");
	 
	  }
	 
	  //System.out.println("from query--anu--> "+qry);
	  rs1=stmt1.executeQuery(qry.toString());
	  
	    
	  
	  while(rs1.next())
	  {
	  %>
	  <option value="<%=rs1.getString(1)%>"> <%=rs1.getString(2) %></option>
	  <% 
	  }
	    
	  %></SELECT></td>
	  </tr>
	
	  <%
	  
  
}
/////////////////////////////////////////////    G L S R   //////////////////////////////////////
 if(myasset!=null && myasset.toString().equals("GLSR"))
{%>
<tr>
	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
	<td class=btext>
	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
	    <option value="">-Select-</option>
	     
	    
	    
<% 


	  stmt1=conn.createStatement();
qry.delete(0,qry.length());
if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
	{
  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_AST_GLSR_SC_PARAM_TBL  a  where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode order by dcode");
	}
else
{
	qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_AST_GLSR_SC_PARAM_TBL  a  where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode and d.dcode='"+loggedUser.substring(1,3)+"' order by dcode");
	}
	  rs1=stmt1.executeQuery(qry.toString());
	 // System.out.println("from query--glsr--> "+qry);
	    
	  
	  while(rs1.next())
	  {
	  %>
	  <option value="<%=rs1.getString(1)%>"> <%=rs1.getString(2) %></option>
	  <% 
	  }
	    
	  %></SELECT></td>
	  </tr>
	
	  <%
	  


}

/////////////////////////////////////////   O H S R //////////////////////////////////
 if(myasset!=null && myasset.toString().equals("OHSR"))
  {%>
  <tr>
  	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
  	<td class=btext>
  	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
  	    <option value="">-Select-</option>
  	     
  	    
  	    
  <% 
   	  stmt1=conn.createStatement();
  qry.delete(0,qry.length());
  if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
	{
 	  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_AST_OHSR_SC_PARAM_TBL a  where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode order by dcode");
	}
  else
	  {
	  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_AST_OHSR_SC_PARAM_TBL a  where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode and d.dcode='"+loggedUser.substring(1,3)+"' order by dcode");
	  }
  	  rs1=stmt1.executeQuery(qry.toString());
  	 // System.out.println("from query--ohsr--> "+qry);
  	    
  	  
  	  while(rs1.next())
  	  {
  	  %>
  	  <option value="<%=rs1.getString(1)%>"> <%=rs1.getString(2) %></option>
  	  <% 
  	  }
  	    
  	  %></SELECT></td>
  	  </tr>
  	
  	  <%
  	  



    }
////////////////////////////////////////      HP        //////////////////////////////////

if(myasset!=null && myasset.toString().equals("HP"))
    {%>
    <tr>
    	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
    	<td class=btext>
    	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
    	    <option value="">-Select-</option>
    	     
    	    
    	    
    <% 
   
 
    	  stmt1=conn.createStatement();
    	  
    	  
    qry.delete(0,qry.length());
    if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
	{
    	  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_HP_SUBCOMP_PARAM_TBL a where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode order by dcode");
	}
    else
    {
    	qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL  bf,RWS_HP_SUBCOMP_PARAM_TBL a where a.asset_code=bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode and d.dcode='"+loggedUser.substring(1,3)+"'  order by dcode");
    }
    	  rs1=stmt1.executeQuery(qry.toString());
    	  //System.out.println("from query--HP--> "+qry);
    	    
    	  
    	  while(rs1.next())
    	  {
    	  %>
    	  <option value="<%=rs1.getString(1)%>"> <%=rs1.getString(2) %></option>
    	  <% 
    	  }
    	    
    	  %></SELECT></td>
    	  </tr>
    	
    	  <%
 }

  /////////open wells
  
  if(myasset!=null && myasset.toString().equals("OW"))
    {%>
    <tr>
    	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
    	<td class=btext>
    	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
    	    <option value="">-Select-</option>
    	     
    	    
    	    
    <% 
   
 
    	  stmt1=conn.createStatement();
    	  
    qry.delete(0,qry.length());
    if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
	{
    	  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL bf,RWS_OPEN_WELL_MAST_TBL a where a.ASSET_CODE =bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode order by dcode");
	}
    else
    {
    	qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL bf,RWS_OPEN_WELL_MAST_TBL a where a.ASSET_CODE =bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode  and d.dcode='"+loggedUser.substring(1,3)+"' order by dcode");
    }
    	  rs1=stmt1.executeQuery(qry.toString());
    	 // System.out.println("from query--HP--> "+qry);
    	    
    	  
    	  while(rs1.next())
    	  {
    	  %>
    	  <option value="<%=rs1.getString(1)%>"> <%=rs1.getString(2) %></option>
    	  <% 
    	  }
    	    
    	  %></SELECT></td>
    	  </tr>
    	
    	  <%
 }
  
  ////////sources///////
  
   if(myasset!=null && myasset.toString().equals("SO"))
    {%>
    <tr>
    	<td class=rptLabel>District: &nbsp;&nbsp;<font color="red">*</font></td>
    	<td class=btext>
    	    <SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
    	    <option value="">-Select-</option>
    	     
    	    
    	    
    <% 
   
 
    	  stmt1=conn.createStatement();
    	  
           qry.delete(0,qry.length());
           if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
       	{
    	  qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL bf,RWS_SOURCE_TBL a where a.ASSET_CODE =bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode order by dcode");
       	}
           else
        	   {
        	   qry.append("SELECT  distinct d.dcode,d.dname from rws_district_tbl d,RWS_BLUEFROG_ASSET_MAST_TBL bf,RWS_SOURCE_TBL a where a.ASSET_CODE =bf.assetcode and substr(a.asset_code,5,2)=d.dcode and substr(bf.sourcecode,1,2)=d.dcode    and d.dcode='"+loggedUser.substring(1,3)+"' order by dcode");
        	   }
    	  rs1=stmt1.executeQuery(qry.toString());
    	 // System.out.println("from query--SO--> "+qry);
    	    
    	
    	  while(rs1.next())
    	  {
    	  %>
    	  <option value="<%=rs1.getString("dcode")%>"> <%=rs1.getString("dname") %></option>
    	  <% 
    	  }
    	    
    	  %></SELECT></td>
    	  </tr>
    	
    	  <%
 }
  
  
  

if(stmt1!=null){
	  stmt1.close();
}
if(rs1!=null){
	  rs1.close();
}
}

  catch(Exception e)
  {
        e.printStackTrace();
  }
  %>
 <tr><td colspan="2"  ><font size="2">
 <!--  
 
  <input type="radio" name="report" value="rpt3" checked/>Coordinates available in both blue frog and RWS</font> -->
  </td></tr>

<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type="button" id="vbutton" onclick="getReport()" class=btext value="View Report">
		
			
		</td>
	</tr>
</table>

</form>
</html>
<%@ include file="/commons/rws_alert.jsp"%>