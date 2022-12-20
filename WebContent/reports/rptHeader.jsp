
<head>
<style>
.mystyle2
{
	
	border-width:1;
	color:blue;
	font-family:verdana;
	font-size:7pt;
}
</style>
</head>

<table   class="mystyle2" cellspacing = 4 cellpadding = 0 height=1%  bordercolor=#000000 style="border-collapse:collapse"   bgcolor="#ffffff" align = "left">
<tr class="mystyle2">

<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getCircle().equals("")){ %>
<td >Circle</td>
<td><bean:write name="rptHeaderBean" property="circle"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getDivision().equals("")){ %>
<td>Division</td>
<td><bean:write name="rptHeaderBean" property="division"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getSubdivision().equals("")){ %>
<td>SubDivision</td>
<td><bean:write name="rptHeaderBean" property="subdivision"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getDistrict().equals("")){ %>
<td>District</td>
<td><bean:write name="rptHeaderBean" property="district"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getMandal().equals("")){ %>
<td>Mandal</td>
<td><bean:write name="rptHeaderBean" property="mandal"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getPanchayat().equals("")){ %>
<td>Panchayat</td>
<td><bean:write name="rptHeaderBean" property="panchayat"/>&nbsp;&nbsp;</td>
<%} %>
<% if(!((CheckListFormBean)request.getAttribute("rptHeaderBean")).getVillage().equals("")){ %>
<td>Village</td>
<td><bean:write name="rptHeaderBean" property="village"/>&nbsp;&nbsp;</td>
<%} %>
</tr></table>
