<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<script>
function fncheckbox(index)
{
if(document.getElementById("tsp"+index)!=null){
if(document.getElementById("tsp"+index).value=="")
{
  alert("Before Select checkbox Please Provide  TSP/NTSP value ");
  document.getElementById('check['+index+']').checked=false;
}
}else{
	alert("This Is not a ST Habitation");
	 document.getElementById('check['+index+']').checked=false;
}
}
function openEditWindow(url,width,height)
{
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	// alert("url:"+url);
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnHabsave(index)
{
		var checkchoice=0;
		for(var i=1;i<=index;i++)
		{
			if(document.getElementById('check['+i+']').checked)
			{
			checkchoice++;
			}
		}
		if(checkchoice==0)  
		{
		alert("Please Select At least One Checkbox");
		return false;
		}
		else
		{
		document.forms[0].action="switch.do?prefix=/masters&page=/HabSCST.do?mode=Habsave";
		document.forms[0].submit();  
		}
}
function fnSC(index,habname,type)
{
  var zURL = "./rws_Hab_SC_detais_rpt.jsp?habcode="+index+"&habname="+habname+"&type="+type;
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
    myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
function fnAsset(index,habname,scpop,stpop,plpop)
{
  var zURL = "./rws_Hab_Asset_detais_rpt.jsp?habcode="+index+"&habname="+habname+"&scpop="+scpop+"&stpop="+stpop+"&plpop="+plpop;
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
    myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
</script>
<%
	String dcode = request.getParameter("district");
	String mcode = request.getParameter("mandal");
	String pcode = request.getParameter("panch");
	String vcode = request.getParameter("village");
	String habcode = request.getParameter("habitation");
	String dname = request.getParameter("dname");
	String mname = request.getParameter("mname");
	String pname = request.getParameter("pname");
	String vname = request.getParameter("vname");
	String habname = request.getParameter("habname");
	Statement stmtc = null;
	ResultSet rsc = null;
%>
<html>
<form method="post">
	<table>
		<tr>
			<td class=btext>District:&nbsp;&nbsp;<%=dname%> <%
 	if (request.getParameter("mname") != null && !request.getParameter("mname").equals("")) {
 %> &nbsp;&nbsp; Mandal:&nbsp;&nbsp;<%=mname%> <%
 	}
 	if (request.getParameter("pname") != null && !request.getParameter("pname").equals("")) {
 %> &nbsp;&nbsp; Panchayat:&nbsp;&nbsp;<%=pname%> <%
 	}
 	if (request.getParameter("vname") != null && !request.getParameter("vname").equals("")) {
 %> &nbsp;&nbsp; Village:&nbsp;&nbsp;<%=vname%> <%
					}
				%>
			</td>
		</tr>
	</table>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Habitation List" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	<table border=1 cellspacing=0 cellpadding=0 width=100%
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff">
		<tr align="center">
			<td class=btext>Sl.No</td>
			<td class=btext>Select</td>
			<td class=btext>Hab Code</td>
			<td class=btext>Habitation Name</td>
			<td class=btext>Plain Population</td>
			<td class=btext>SC Population</td>
			<td class=btext>ST Population</td>
			<td class=btext>Coverage Status</td>
			<td class=btext>Habitation Type</td>
			<td class=btext>Habitation Sub Type</td>
			<td class=btext>SC <br>Localities
			</td>
			<td class=btext>ST<br>Localities
			</td>
			<td class=btext>Minority<br> Localities
			</td>
			<td class=btext>TSP(ITDA)</td>
			<td class=btext>Asset Status</td>
		</tr>
		<%
			int sno = 0;
			try {
				String qry = " select a.hab_code,b.panch_name,a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,a.coverage_status,a.habitation_sub_type, "
						+" a.TSP_NTSP,habitation_type from rws_habitation_dir_dyna_tbl a,rws_complete_hab_dyna_view b where b.panch_code=a.hab_code and substr(a.hab_code,1,2)=? ";
				if (mcode != null && !mcode.equals("")) {
					qry += " and substr(a.hab_code,6,2)='" + mcode + "' ";
				}
				if (pcode != null && !pcode.equals("")) {
					qry += " and substr(a.hab_code,13,2)='" + pcode + "' ";
				}
				if (vcode != null && !vcode.equals("")) {
					qry += " and substr(a.hab_code,8,3)='" + vcode + "' ";
				}
				if (habcode != null && !habcode.equals("")) {
					qry += " and hab_code='" + habcode + "' ";
				}
				ps = conn.prepareStatement(qry);
				ps.setString(1, dcode);
				rs = ps.executeQuery();
				while (rs.next()) {
		%>
		<tr>
			<td class=rptvalue><%=++sno%></td>
			<td class=rptvalue align="center"><input type=checkbox
				name="check[<%=sno%>]" onclick="fncheckbox(<%=sno%>)"
				value='<%=rs.getString(1)%>'></td>
			<td class=rptvalue><%=rs.getString(1)%></td>
			<td class=rptvalue nowrap><%=rs.getString(2)%></td>
			<td class=rptvalue><%=rs.getString(3)%></td>
			<td class=rptvalue><%=rs.getString(4)%></td>
			<td class=rptvalue><%=rs.getString(5)%></td>
			<td class=rptvalue><%=rs.getString(6)%></td>
			<td class=rptvalue><%=rs.getString(9)%></td>
			<td class=rptvalue><%=rs.getString(7)%></td>
			<%
				String qry1 = "select (select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=? and substr(locality_code,1,2)='SC'),"
									+ "(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=? and substr(locality_code,1,2)='ST'),"
									+ "(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code=? and substr(locality_code,1,2)='MT')  from dual";
						ps = conn.prepareStatement(qry1);
						ps.setString(1, rs.getString(1));
						ps.setString(2, rs.getString(1));
						ps.setString(3, rs.getString(1));
						rsc = ps.executeQuery();
						int val = 0, val1 = 0, val2 = 0;
						if (rsc.next()) {
							val = rsc.getInt(1);
							val1 = rsc.getInt(2);
							val2 = rsc.getInt(3);
						}
			%>
			<td class=rptvalue align="center"><%=val%><input type=button
				name="button1" title="Click to Enter SC Details" Class="btext"
				value="&nbsp;&nbsp;...&nbsp;&nbsp;"
				onclick="fnSC('<%=rs.getString(1)%>','<%=rs.getString(2)%>','sc')" /></td>
			<td class=rptvalue align="center"><%=val1%><input type=button
				name="button1" title="Click to Enter ST Details" Class="btext"
				value="&nbsp;&nbsp;...&nbsp;&nbsp;"
				onclick="fnSC('<%=rs.getString(1)%>','<%=rs.getString(2)%>','st')" /></td>
			<td class=rptvalue align="center"><%=val2%><input type=button
				name="button1" title="Click to Enter Mionrity Details" Class="btext"
				value="&nbsp;&nbsp;...&nbsp;&nbsp;"
				onclick="fnSC('<%=rs.getString(1)%>','<%=rs.getString(2)%>','mt')" /></td>
			<%
				if (rs.getString(8) == null) {
			%>
			<td width="69px"><select name="tsp<%=sno%>" class="mycombo">
					<option value="">-select-</option>
					<option value="tsp">TSP</option>
			</select></td>
			<%
				} else if (rs.getString(8) != null && !rs.getString(8).equals("")) {
			%>
			<td class=rptvalue align="center"><select name="tsp<%=sno%>"
				class="mycombo">
					<%
						if (rs.getString(8) != null && rs.getString(8).equals("TSP")) {
					%>
					<option value="">-select-</option>
					<option value="tsp" selected>TSP</option>
					<%
						}
					%>
			</select></td>
			<%
				} else {
			%>
			<td class=rptvalue align="center"></td>
			<%
				}
			%>
			<td class=btext align="center"><input type=button name="button1"
				title="Click to Enter Asset Details" Class="btext"
				value="&nbsp;&nbsp;...&nbsp;&nbsp;"
				onclick="fnAsset('<%=rs.getString(1)%>','<%=rs.getString(2)%>','<%=rs.getString(4)%>','<%=rs.getString(5)%>','<%=rs.getString(3)%>')" /></td>
		</tr>
		<%
			}
			} catch (Exception e) {
				System.out.println("Exception in Habstatus SC/ST frm:" + e);
			}
		%>
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
		
		<tr>
			<td align="center" colspan="14"><input type=button
				name="savework<%=sno%>" title="Save the Fields" Class="btext"
				value="Save" onclick="fnHabsave(<%=sno%>)" /></td>
			<input type="hidden" name="resultCount" value="<%=sno%>">
		</tr>
	</table>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	<input type="hidden" name="district" value="<%=dcode%>" /> <input
		type="hidden" name="mandal" value="<%=mcode%>" /> <input
		type="hidden" name="panch" value="<%=pcode%>" /> <input type="hidden"
		name="village" value="<%=vcode%>" /> <input type="hidden"
		name="habitation" value="<%=habcode%>" /> <input type="hidden"
		name="dname" value="<%=dname%>" /> <input type="hidden" name="mname"
		value="<%=mname%>" /> <input type="hidden" name="habname"
		value="<%=habname%>" />
</form>
<%@ include file="/commons/rws_alert.jsp"%>
</html>