<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="nic.watersoft.commons.*, java.util.*,javax.sql.*,javax.naming.*"%>
		
<%		Context ctx = new InitialContext();
      	DataSource dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/pred");
		RwsLocations rwsLocations = new RwsLocations(dataSource);%>

<script language="JavaScript">
<!--
function fnSubmit()
{

	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="District")
	{
		document.f1.action="./rws_district_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="Mandal")
	{
		document.f1.action="./rws_mandal_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="Panchayat")
	{
		document.f1.action="./rws_panchayat_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="Village")
	{
		document.f1.action="./rws_village_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="Habitation")
	{
		document.f1.action="./rws_habitation_rpt.jsp";
		document.f1.submit();
	}


}
function setDname()
{
var i = document.f1.dist.selectedIndex;
document.f1.dname.value=document.f1.dist.options[i].text;
}
function setMname()
{
var i = document.f1.mand.selectedIndex;
document.f1.mname.value=document.f1.mand.options[i].text;
}
function setPname()
{
var i = document.f1.panch.selectedIndex;
document.f1.pname.value=document.f1.panch.options[i].text;
}
function setVname()
{
var i = document.f1.village.selectedIndex;
document.f1.vname.value=document.f1.village.options[i].text;
}
//-->
</script>

<form name=f1 action="<%= request.getRequestURI()%>">
	<input type="hidden" name="dname" value="">
	<input type="hidden" name="mname" value="">
	<input type="hidden" name="pname" value="">
	<input type="hidden" name="vname" value="">
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String rVillage = null;
%>


<table bgcolor="#8A9FCD" bordercolor= "#000000" width="40%" border=1 rules="none" style="border-collapse:collapse" align=center>
<caption align="right">
<table border=0 rules=none style="border-collapse:collapse">
<tr>
<td><a href="../home.jsp">Home |</td> 
<td><a href="./rws_master_list_frm.jsp">Back</a></td>
</tr>
</table>

</caption>
	<tr bgcolor="#8A9FCD">
		<td class=myfontclr colspan=2><B><font color="#FFFFFF">Masters Query Form</font></B></td>	
		<td align=right><IMG SRC="../images/cloapp.gif" WIDTH="12" HEIGHT="12" style="cursor:hand" onclick="winClose()" alt="Close"></td>
	</tr>
</table>


<table bgcolor="#ffffff" bordercolor= "#000000" width="40%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<% 
	if(request.getParameter("selection")==null)
	{
%>
	<tr>
		<td class = clrborder>Selection</font></td>
		<td class = bwborder><select name="selection" style="width:150px" class="mycombo" onChange="this.form.submit()">
			<option>Please Select...</option>
			<option>District</option>
			<option>Mandal</option>
			<option>Panchayat</option>
			<option>Village</option>
			<option>Habitation</option>
	</tr>
<%
	}
		else
		{
%>
	<tr>
		<td class = clrborder>Selection</font></td>
		<td class = bwborder><select name="selection" style="width:150px" class="mycombo">
		<option><%=request.getParameter("selection")%></select>
	</tr>
<%
		}
		if(request.getParameter("selection")!= null && request.getParameter("selection").equals("Mandal"))
		{
%>
	<tr>
		<td class = clrborder>District</font></td>
		<td class = bwborder><select name="dist" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>		
<%
	rDist = request.getParameter("dist");
	ArrayList districts = rwsLocations.getDistricts();
	String hDCode = null;
	String hDName = null;

	for(int i=0; i<districts.size(); i++)
	{
		RwsLocationBean rwsLocation = (RwsLocationBean) districts.get(i);
		hDCode = rwsLocation.getDistrictCode();
		hDName = rwsLocation.getDistrictName();

		if(rDist != null && rDist.equals(hDCode) )
		{
%>
		<option value="<%= hDCode %>" selected><%= hDName %>
<script language="JavaScript">
<!--
setDname();
//-->
</script>
<% 

		}// END OF IF
		else 
		{
%>
<option value="<%= hDCode %>" ><%= hDName %>
<%		
		} 
	}// END OF FOR
		}// END OF MAIN IF
		else
		if(request.getParameter("selection")!= null && request.getParameter("selection").equals("Panchayat"))
		{
%>
	
	<tr>
		<td class = clrborder>District</font></td>
		<td class = bwborder><select name="dist" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
	rDist = request.getParameter("dist");
	ArrayList districts = rwsLocations.getDistricts();
	String hDCode = null;
	String hDName = null;

	for(int i=0; i<districts.size(); i++)
	{
		RwsLocationBean rwsLocation = (RwsLocationBean) districts.get(i);
		hDCode = rwsLocation.getDistrictCode();
		hDName = rwsLocation.getDistrictName();

		if(rDist != null && rDist.equals(hDCode) )
		{
%>
	<option value="<%= hDCode %>" selected><%= hDName %>
<script language="JavaScript">
<!--
setDname();
//-->
</script>
<% 

		} // END OF IF
		else 
		{
%>
	<option value="<%= hDCode %>" ><%= hDName %>
<%		
		} 
	}// END OF FOR
		
%>

	<tr>
		<td class = clrborder>Mandal</font></td>
		<td class = bwborder>
		<select name="mand" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>

<%
	rMand = request.getParameter("mand");
		if(rDist != null && !rDist.equals("0"))
		{
%>
<script language="JavaScript">
<!--
document.f1.mand.disabled=false;
//-->
</script>
<%		
		ArrayList mandals = rwsLocations.getMandals(rDist);
		String hMCode = null;
		String hMName = null;
		for(int i=0; i<mandals.size(); i++)
		{
			RwsLocationBean rwsLocation = (RwsLocationBean) mandals.get(i);
			hMCode = rwsLocation.getMandalCode();
			hMName = rwsLocation.getMandalName();
			if(rMand != null && rMand.equals(hMCode))
			{
%>
		<option value="<%= hMCode%>" selected><%= hMName %>
<script language="JavaScript">
<!--
setMname();
//-->
</script>
<%
			}// END OF IF
			else
			{
%>
		<option value="<%= hMCode%>"><%= hMName %>
<%	
			}
		}// END OF IF 
		}// END OF FOR
			}// END OF MAIN IF
			else
			if(request.getParameter("selection")!= null && request.getParameter("selection").equals("Village"))
			{
%>
	<tr>
		<td class = clrborder>District</font></td>
		<td class = bwborder><select name="dist" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
	rDist = request.getParameter("dist");
	ArrayList districts = rwsLocations.getDistricts();
	String hDCode = null;
	String hDName = null;

	for(int i=0; i<districts.size(); i++)
	{
		RwsLocationBean rwsLocation = (RwsLocationBean) districts.get(i);
		hDCode = rwsLocation.getDistrictCode();
		hDName = rwsLocation.getDistrictName();

		if(rDist != null && rDist.equals(hDCode) )
		{
%>
	<option value="<%= hDCode %>" selected><%= hDName %>
<script language="JavaScript">
<!--
setDname();
//-->
</script>
<% 

		} // END OF IF
		else 
		{
%>
	<option value="<%= hDCode %>" ><%= hDName %>
<%		
		} 
	}// END OF FOR
		
%>

	<tr>
		<td class = clrborder>Mandal</font></td>
		<td class = bwborder>
		<select name="mand" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>

<%
	rMand = request.getParameter("mand");
		if(rDist != null && !rDist.equals("0"))
		{
%>
<script language="JavaScript">
<!--
document.f1.mand.disabled=false;
//-->
</script>
<%		
		ArrayList mandals = rwsLocations.getMandals(rDist);
		String hMCode = null;
		String hMName = null;
		for(int i=0; i<mandals.size(); i++)
		{
			RwsLocationBean rwsLocation = (RwsLocationBean) mandals.get(i);
			hMCode = rwsLocation.getMandalCode();
			hMName = rwsLocation.getMandalName();
			if(rMand != null && rMand.equals(hMCode))
			{
%>
		<option value="<%= hMCode%>" selected><%= hMName %>
<script language="JavaScript">
<!--
setMname();
//-->
</script>
<%
			}// END OF IF
			else
			{
%>
		<option value="<%= hMCode%>"><%= hMName %>
<%	
			}
		}// END OF FOR
			}// END OF IF		
%>
	<tr>
		<td class = clrborder>Panchayat</font></td>
		<td class = bwborder><select name="panch" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>	
<%
	rPanch = request.getParameter("panch");

	if(rMand != null && !rMand.equals("0"))
	{
%>
<script language="JavaScript">
<!--
document.f1.panch.disabled=false;
//-->
</script>
<%
	ArrayList panchayats = rwsLocations.getPanchayats(rDist, rMand);
	String hPCode = null;
	String hPName = null;
		for(int i=0; i<panchayats.size(); i++)
		{
		RwsLocationBean rwsLocation = (RwsLocationBean) panchayats.get(i);
		hPCode = rwsLocation.getPanchayatCode();
		hPName = rwsLocation.getPanchayatName();
			if(rPanch != null && rPanch.equals(hPCode)) 
			{

%>
	<option value="<%= hPCode%>" selected><%= hPName %>

<script language="JavaScript">
<!--
setPname();
//-->
</script>
<%
			}// END OF IF
			else
			{
%>
<option value="<%= hPCode%>"><%= hPName %>
<%	
			}
		}// END OF FOR
	}// END OF IF
		}// END OF MAIN IF
		else
			if(request.getParameter("selection")!= null && request.getParameter("selection").equals("Habitation"))
			{
%>
	<tr>
		<td class = clrborder>District</font></td>
		<td class = bwborder><select name="dist" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
	rDist = request.getParameter("dist");
	ArrayList districts = rwsLocations.getDistricts();
	String hDCode = null;
	String hDName = null;

	for(int i=0; i<districts.size(); i++)
	{
		RwsLocationBean rwsLocation = (RwsLocationBean) districts.get(i);
		hDCode = rwsLocation.getDistrictCode();
		hDName = rwsLocation.getDistrictName();
		if(rDist != null && rDist.equals(hDCode) )
		{
%>
	<option value="<%= hDCode %>" selected><%= hDName %>
<script language="JavaScript">
<!--
setDname();
//-->
</script>
<% 

		} // END OF IF
		else 
		{
%>
	<option value="<%= hDCode %>" ><%= hDName %>
<%		
		} 
	}// END OF FOR
		
%>

	<tr>
		<td class = clrborder>Mandal</font></td>
		<td class = bwborder>
		<select name="mand" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>

<%
	rMand = request.getParameter("mand");
		if(rDist != null && !rDist.equals("0"))
		{
%>
<script language="JavaScript">
<!--
document.f1.mand.disabled=false;
//-->
</script>
<%		
		ArrayList mandals = rwsLocations.getMandals(rDist);
		String hMCode = null;
		String hMName = null;
		for(int i=0; i<mandals.size(); i++)
		{
			RwsLocationBean rwsLocation = (RwsLocationBean) mandals.get(i);
			hMCode = rwsLocation.getMandalCode();
			hMName = rwsLocation.getMandalName();
			if(rMand != null && rMand.equals(hMCode))
			{
%>
		<option value="<%= hMCode%>" selected><%= hMName %>
<script language="JavaScript">
<!--
setMname();
//-->
</script>
<%
			}// END OF IF
			else
			{
%>
		<option value="<%= hMCode%>"><%= hMName %>
<%	
			}
		}// END OF FOR
			}// END OF IF		
%>
	<tr>
		<td class = clrborder>Panchayat</font></td>
		<td class = bwborder><select name="panch" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>	
<%
	rPanch = request.getParameter("panch");

	if(rMand != null && !rMand.equals("0"))
	{
%>
<script language="JavaScript">
<!--
document.f1.panch.disabled=false;
//-->
</script>
<%
	ArrayList panchayats = rwsLocations.getPanchayats(rDist, rMand);
	String hPCode = null;
	String hPName = null;
		for(int i=0; i<panchayats.size(); i++)
		{
		RwsLocationBean rwsLocation = (RwsLocationBean) panchayats.get(i);
		hPCode = rwsLocation.getPanchayatCode();
		hPName = rwsLocation.getPanchayatName();
			if(rPanch != null && rPanch.equals(hPCode)) 
			{

%>
	<option value="<%= hPCode%>" selected><%= hPName %>

<script language="JavaScript">
<!--
setPname();
//-->
</script>
<%
			}// END OF IF
			else
			{
%>
<option value="<%= hPCode%>"><%= hPName %>
<%	
			}
		}// END OF FOR
	}// END OF IF
%>
	<tr>
		<td class = clrborder>Village</font></td>
		<td class = bwborder><select name="village" style="width:150px" class="mycombo" onchange="this.form.submit()" disabled>
		<option value="0">Please Select...</option>
<%
		rVillage = request.getParameter("village");
		if(rPanch != null && !rPanch.equals("0"))
		{
%>
<script language="JavaScript">
<!--
document.f1.village.disabled=false;
//-->
</script>
<%
		ArrayList villages = rwsLocations.getVillages(rDist, rMand, rPanch);
		String hVCode = null;
		String hVName = null;
			for(int i=0; i<villages.size(); i++)
			{
		RwsLocationBean rwsLocation = (RwsLocationBean) villages.get(i);
		hVCode = rwsLocation.getVillageCode();
		hVName = rwsLocation.getVillageName();

				if(rVillage != null && rVillage.equals(hVCode))
				{
%>
		<option value="<%= hVCode%>" selected><%= hVName %>
<script language="JavaScript">
<!--
setVname();
//-->
</script>
<%
				}// END OF IF
					else
					{
%>
			<option value="<%= hVCode%>"><%= hVName %>
<%	
					}
			}// END OF FOR
		}// END OF IF
			}// END OF MAIN IF
%>
</select></td>
</tr>

</select></td>

</tr>
	
</select></td>
</tr>
</select></td>
</tr>

</select></td>
</tr>
</table>

<table bgcolor="#ffffff" bordercolor= "#000000" width="40%" border=1 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value=Submit class = btext></font>
		</td>
	</tr>
</table>
<%@ include file="/commons/rws_footer.jsp"%>