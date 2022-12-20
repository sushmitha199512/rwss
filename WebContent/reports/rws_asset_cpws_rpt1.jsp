
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%try{

	Statement stmt1 = null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
 %>

<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
function fnSubmit()
	{   
	//10/8/2009alert(document.f1.asset.value);
	    if(document.f1.district.selectedIndex=="")
		{
	    alert("Please Select Circle...");
		return false;
		}
		if(document.f1.asset.value=="-1")
		{
		 alert("Please Select Asset Type...");
		 return false;
		}
		if(document.f1.asset.value=="01" || document.f1.asset.value=="02" || document.f1.asset.value=="03" || document.f1.asset.value=="09")
		{		
	     document.f1.action="./WsPager1.jsp";
	     document.f1.submit();
	     }
		if(document.f1.asset.value=="04")
		{		
	     document.f1.action="./WsPagerHp.jsp";
	     document.f1.submit();
	     }
		 if(document.f1.asset.value=="06")
		{		
	     document.f1.action="./WsPagerOw.jsp";
	     document.f1.submit();
	     }
		 if(document.f1.asset.value=="07")
		{		
	     document.f1.action="./WsPagerPond.jsp";
	     document.f1.submit();
	     }
		 if(document.f1.asset.value=="05")
		{		
	     document.f1.action="./WsPagerShp.jsp";
	     document.f1.submit();
	     }
		 if(document.f1.asset.value=="08")
		{		
	     document.f1.action="./WsPagerOther.jsp";
	     document.f1.submit();
	     }

	}
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Assets  - Check List Report</font>
			</td>	
		</tr>
		
		
		
	<% String rDist = null,rMandal="";
	   String assetcode = null;
	   
	   String query="";
	  
	  rDist = request.getParameter("district");
  	  rMandal = request.getParameter("mandal");
  	  String rPanchayat = request.getParameter("panchayat");
  	  String rVillage = request.getParameter("village");
  	  String rHab = request.getParameter("hab");
   	  String rAsset = request.getParameter("assetName");
	  assetcode= request.getParameter("asset");
	  String rAssetLoc = request.getParameter("assetLoc");
	  %>
	  <TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	
	 if(rDist == null || rDist.equals("-1"))
	{
		////////System.out.println("IN Circle STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:250px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00">All</option>
 --><%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			////////System.out.println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:250px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00" SELECTED>All</option>
 --><% 
				session.setAttribute("circleCode",rDist);
                session.setAttribute("circleName","ALL");
				
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:250px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00">ALL</option>
 --><%
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct sc.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_asset_mast_tbl sc  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE  order by c.circle_office_name";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						session.setAttribute("circleName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						}
				}			
					//rs.close();			
					//stmt.close();


%>
</SELECT></td></tr>
<tr>
  <%
  //////System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+rMandal);
  if(rDist != null && rDist.equals("00"))
		{ %>
  	<tr>
		<td class = btext> 
				<font color=navy><b>Mandal</b> </font>
		<td class=btext>
			<select name="mandal" id="mand1" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00">All</option>
 --><%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", null);
				
	}
		
	
	else
		if(rMandal != null && rMandal.equals("00"))
		{
			////////System.out.println("IN rMandal ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Mandal</b> </font>
		<td class=btext>
			<select name="mandal" id="circ1" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00" SELECTED>All</option>
 --><% 
				session.setAttribute("mandalCode",rMandal);
                session.setAttribute("mandalName","ALL");
				
		
		} 
		//else if(rMandal == null || rMandal.equals("00"))
		//	{
%>
		<td class = btext> 
				<font color=navy><b>Mandal</b> </font>
		<td class=btext>
			<SELECT name="mandal" id="mand1" class="mycombo" style="width:250px"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<!-- 				<option value="00">ALL</option>
 --><%
					session.setAttribute("mandalCode",rMandal);
			
				stmt = conn.createStatement();
				
				 query = "SELECT distinct m.mcode, m.mname from rws_mandal_tbl m  where m.dcode='"+rDist+"' order by m.mname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rMandal != null && rMandal.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						session.setAttribute("mandalName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						}
				}	
			//}		
					//rs.close();			
					//stmt.close();


%>
</SELECT></td></tr>
<tr>
		<td class = btext> 
				<font color=navy><b>Panchayat</b> </font>
		<td class=btext>
			<select name="panchayat" id="panch1" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query = "SELECT distinct p.pcode, p.pname from rws_panchayat_tbl p  where p.dcode='"+rDist+"' and p.mcode='"+rMandal+"' order by p.pname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rPanchayat != null && rPanchayat.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("panchCode", rPanchayat);
						session.setAttribute("panchName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("panchCode", rPanchayat);
						}
				}	
 %></select></td></tr>
 <tr>
		<td class = btext> 
				<font color=navy><b>Village</b> </font>
		<td class=btext>
			<select name="village" id="hab1" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				//query = "SELECT distinct h.panch_code, h.panch_name from rws_panchayat_raj_tbl h  where substr(panch_code,1,2)='"+rDist+"' and substr(panch_code,6,2)='"+rMandal+"' substr(panch_code,13,2)='"+rPanchayat+"' substr(panch_code,8,3)='"+rVillage+"'";
				query = "SELECT distinct v.vcode, v.vname from rws_village_tbl v  where v.dcode='"+rDist+"' and v.mcode='"+rMandal+"' and v.pcode='"+rPanchayat+"' order by v.vname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rVillage != null && rVillage.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
					}
					else
					{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
					}
				}	
 %></select></td></tr>
 <tr>
		<td class = btext> 
				<font color=navy><b>Habitation</b> </font>
		<td class=btext>
			<select name="hab" id="vill1" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query = "SELECT distinct h.panch_code, h.panch_name from rws_panchayat_raj_tbl h  where substr(panch_code,1,2)='"+rDist+"' and substr(panch_code,6,2)='"+rMandal+"' and substr(panch_code,13,2)='"+rPanchayat+"' and substr(panch_code,8,3)='"+rVillage+"' order by h.panch_name";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rHab != null && rHab.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
					//	session.setAttribute("villCode", rVillage);
					//	session.setAttribute("villName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						//session.setAttribute("villCode", rVillage);
						}
				}	
 %></select></td></tr>
  <tr>
		<td class = btext> 
				<font color=navy><b>Asset Type</b> </font><font color=red><b>*</b> </font>
		<td class=btext>
			<select name="asset" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query = "select type_of_asset_code,type_of_asset_name from rws_asset_type_tbl where type_of_asset_code in (01,02,03,04,09,06,07,05) order by 1";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(assetcode != null && assetcode.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
				}	
 %></select></td></tr>
  
  
 <tr>
		<td class = btext nowrap> 
				<font color=navy><b>Asset Name</b> </font>
		<td class=btext>
			<select name="assetName" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
//				query = "SELECT distinct asset_code, asset_name from rws_asset_mast_tbl  where  hab_code='"+rHab+"' and type_of_asset_code='"+assetcode+"' order by asset_name";
				//query = "SELECT distinct asset_code, asset_name from rws_asset_mast_tbl  where  type_of_asset_code='"+assetcode+"'";
				query = "SELECT distinct asset_name from rws_asset_mast_tbl  where  type_of_asset_code='"+assetcode+"'";
				if(rDist!=null && !rDist.equals("-1"))query += " and substr(hab_code,1,2)='"+rDist+"'";
				if(rMandal!=null && !rMandal.equals("-1"))query += " and substr(hab_code,6,2)='"+rMandal+"'";
				if(rPanchayat!=null && !rPanchayat.equals("-1"))query += " and substr(hab_code,13,2)='"+rPanchayat+"'";
				if(rVillage!=null && !rVillage.equals("-1"))query += " and substr(hab_code,8,3)='"+rVillage+"'";
				if(rHab!=null && !rHab.equals("-1"))query += " and hab_code='"+rHab+"'";
				query +=" and asset_name is not null  order by asset_name";
				//////System.out.println("final asset names query:"+query);
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rAsset != null && rAsset.equals(rs.getString(1)))
					{					
%>
				<option value='<%=rs.getString(1)%>' SELECTED><%=rs.getString(1)%></option>
<%
					}
					else
						{					
%>
				<option value='<%=rs.getString(1)%>'><%=rs.getString(1)%></option>
<%
						}
				}	
 %></select></td></tr>
 <tr>
		<td class = btext nowrap> 
				<font color=navy><b>Asset Location</b> </font>
		<td class=btext>
			<select name="assetLoc" style="width:250px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
//				query = "SELECT distinct asset_code, location from rws_asset_mast_tbl  where  type_of_asset_code='"+assetcode+"'";
				query = "SELECT distinct location from rws_asset_mast_tbl  where  type_of_asset_code='"+assetcode+"'";
				if(rDist!=null && !rDist.equals("-1"))query += " and substr(hab_code,1,2)='"+rDist+"'";
				if(rMandal!=null && !rMandal.equals("-1"))query += " and substr(hab_code,6,2)='"+rMandal+"'";
				if(rPanchayat!=null && !rPanchayat.equals("-1"))query += " and substr(hab_code,13,2)='"+rPanchayat+"'";
				if(rVillage!=null && !rVillage.equals("-1"))query += " and substr(hab_code,8,3)='"+rVillage+"'";
				if(rHab!=null && !rHab.equals("-1"))query += " and hab_code='"+rHab+"'";
				if(rAsset!=null && !rAsset.equals("-1"))query += " and asset_name like '"+rAsset+"'";
				query +=" and location is not null order by location";
				////System.out.println("Location Query:"+query);
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rAssetLoc != null && rAssetLoc.equals(rs.getString(1)))
					{					
%>
				<option value='<%=rs.getString(1)%>' SELECTED><%=rs.getString(1)%></option>
<%
					}
					else
						{					
%>
				<option value='<%=rs.getString(1)%>'><%=rs.getString(1)%></option>
<%
						}
				}	
 %></select></td></tr>
<TR>
<TD colspan=2 align=center valign=top>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
	

</table>



	

<%}catch(Exception e)
{
 e.printStackTrace();
 }
  finally{
  conn.close();
  
  } 
 
 %>	  
	</TD></TR></table>
	</TD></TR></table>
	</form>
	</body>
	</html>
	  
	