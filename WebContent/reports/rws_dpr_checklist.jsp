<%
String qurysdd ="";
	query ="select a.*,to_char(DPRCOMPDATE,'dd/mm/yyyy') as dprDate,to_char(PARTACLEARNCEDATE,'dd/mm/yyyy') as partADate from RWS_NOTGROUNDWORKS_STATUS_TBL a where a.work_id='"+wCode+"'";
			
	 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	 rs = stmt.executeQuery(query);
	// System.out.println("qq::"+query);
	 rs.setFetchSize(500);
	 rs.last();
	 Count = rs.getRow();
	 //Debug.println("Total Records = "+Count);
	 rs.beforeFirst();
	 
	 String reqPerms="",obtPerms="";
	 
	 
	
	 
	 
	 
	 
	 
	 
	 %>

	<table >
	
	<tr>
		<td align="left" class="rptHeading" colspan=8>II. DPR & Part-A Details</td>	
	</tr>
		
<%	
	if(Count!=0)
	{%>
	
	<% while(rs.next())
	{
		
		if(rs.getString("LANDAQUISITION")!=null && rs.getString("LANDAQUISITION").equals("Y")){
			
			reqPerms+= " LAND AQUISITION ,";
		}
if(rs.getString("WATERDRAWLPERMISSION")!=null && rs.getString("WATERDRAWLPERMISSION").equals("Y")){
			
			reqPerms+= " Water Drawl Permission ,";
		}
if(rs.getString("RAILWAYCROSSINGPERMISSION")!=null && rs.getString("RAILWAYCROSSINGPERMISSION").equals("Y")){
	
	reqPerms+= " RAILWAYCROSSINGPERMISSION ";
}
if(rs.getString("ROADCROSSINGPERMISSIONSTATE")!=null && rs.getString("ROADCROSSINGPERMISSIONSTATE").equals("Y")){
	
	reqPerms+= " ROADCROSSINGPERMISSIONSTATE ";
}
if(rs.getString("ROADCROSSINGPERMISSIONNHAI")!=null && rs.getString("ROADCROSSINGPERMISSIONNHAI").equals("Y")){
	
	reqPerms+= " ROADCROSSINGPERMISSIONNHAI  ";
}
if(rs.getString("FORESTCLEARANCE")!=null && rs.getString("FORESTCLEARANCE").equals("Y")){
	
	reqPerms+= " FORESTCLEARANCE  ";
}

if(rs.getString("OTHERSREASON")!=null && rs.getString("OTHERSREASON").equals("Y")){
	
	reqPerms+= " OTHERSREASON  ";
}

if(rs.getString("LANDAQUISITIONOBTAINDATE")!=null){
	obtPerms+= " LAND AQUISITION ";
}
if(rs.getString("WATERDRAWLPERMISSIONOBTAINDATE")!=null){
	obtPerms+= " WATERDRAWLPERMISSIONOBTAINDATE  ";
}
if(rs.getString("RAILWAYCROSSINGPEROBTAIN")!=null){
	obtPerms+= " RAILWAYCROSSINGPEROBTAIN  ";
}
if(rs.getString("ROADCROSSINGPEROBTAINDATE")!=null){
	obtPerms+= " ROADCROSSINGPEROBTAINDATE  ";
}
if(rs.getString("ROADCROSSINGNHAIOBTAINDATE")!=null){
	obtPerms+= " ROADCROSSINGNHAIOBTAINDATE  ";
}
if(rs.getString("FORESTCLEARANCEOBTAINDATE")!=null){
	obtPerms+= " FORESTCLEARANCEOBTAINDATE";
}

if(rs.getString("OTHERSOBTAINDATE")!=null){
	obtPerms+= " OTHERSOBTAINDATE ";
}

	//System.out.println("tech rs.getFloat(4)"+rs.getFloat(4));
	%>	
	    <tr bgcolor="#ffffff">
			<td class="btext2">1. Part-A Sanction:<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue"><%=rs.getFloat("PARTAAMOUNT")%></td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext2">2. Required&nbsp;Permissions:</td>
		<td class="rptValue"><%=reqPerms %></td>			
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">3.Obtained&nbsp;Permissions:</td>
    	<td class=rptValue><%=obtPerms %></td>
    	</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">4.DPR Status:</td>
    	<td class=rptValue><%=rs.getString("DPRSTATUS")%></td>
    	</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">5.DPR Completed Date:</td>
    	<td class=rptValue><%=rs.getString("dprDate")%></td>
    	</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">6.Part-A Clearance</td>
    	<td class=rptValue><%=rs.getString("partADate")==null?"-":rs.getString("partADate")%></td>
    	</tr>
		<% }
	
	}else {
	%>
	<tr bgcolor="#ffffff">
			<td class="btext2">1. Part-A Sanction:<br>&nbsp;&nbsp;&nbsp;&nbsp;Amt(Rs In Lakhs)</td>
			<td class="rptValue">-</td>
		</tr>
	    <tr bgcolor="#ffffff">
	    <td class="btext2">2. Required&nbsp;Permissions:</td>
		<td class="rptValue">-</td>			
		</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">3.Obtained&nbsp;Permissions:</td>
    	<td class=rptValue>-</td>
    	</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">4.DPR Status:</td>
    	<td class=rptValue>-</td>
    	</tr>
    	<tr bgcolor="#ffffff">
    	<td class="btext2">5.DPR Completed Date:</td>
    	<td class=rptValue>-</td>
    	</tr>
    	
    	<tr bgcolor="#ffffff">
    	<td class="btext2">5.Part-A Clearance</td>
    	<td class=rptValue>-</td>
    	</tr>
	<% } %>

</table>
<br><br>
