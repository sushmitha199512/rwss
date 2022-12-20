<%@ page contentType = "application/vnd.ms-excel" %>
<%@ include file="/commons/rws_head.jsp"%>
<%@ page import="javax.servlet.http.*"%>
<html:html>
<HEAD>
<%@ page import="java.util.*" language="java" pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE></TITLE>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/menu.js' />">
</script>
<SCRIPT language="JavaScript">
var myWin;
myWin = "";
function popWinOpen(wid) {
//var mylen="'"+wid+"'";

// alert(document.getElementbyId('abcd'));
workid=wid;

var zURL="./reports/showExpenditure.jsp?workid=";
zURL+=workid;
var zWidth=600,zHeight=400;
var popFeatures = "width=" + zWidth + ",height=" + zHeight + ",toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1";
myWin = window.open(zURL,'expenditure',popFeatures);

myWin.focus();
}

function popup(mylink, windowname)
{
alert("in popup");
//if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
   href=mylink;
else
   href=mylink.href;
window.open(href, windowname, 'width=400,height=200,scrollbars=yes');
//return false;
}

</SCRIPT>
</HEAD>
<BODY>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/overlib.js' />">
</script>
<DIV id=overDiv style="Z-INDEX: 999; POSITION: absolute"></DIV>
<table>
	<tr>
		<td>
		<table width="100%">
			<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs)</b></caption>
		</table>
		<table>
			<%HttpSession ses = request.getSession(false);
                ArrayList columns = (ArrayList) ses.getAttribute("column");
%>
			<%if (ses.getAttribute("key").equals("dreport")
                        || ses.getAttribute("key").equals("chlist1")
                        || ses.getAttribute("key").equals("chlist2")
                        || ses.getAttribute("key").equals("chlist3")
                        || ses.getAttribute("key").equals("chlist4")) {

                    %>
			<%if ((ses.getAttribute("disthead")) != null) {
%>
			<tr>
				<td><font face="verdana" color="6600CC"><b>District:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("disthead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("cohead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Circle:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("cohead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("dohead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Division:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("dohead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("sdohead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Sub Division:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("sdohead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("conhead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Constituency:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("conhead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("mandhead")) != null) {
%>
			&nbsp;
			<td><font color="6600CC" face="verdana" size=2><b>Mandal:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("mandhead")%></font>
			<%}
                    if ((ses.getAttribute("dmphead")) != null) {
%>&nbsp; <font color="6600CC"><b>Panchayat:</b></font><font
				face="verdana" size="2"></td>
			<td><%=ses.getAttribute("dmphead")%></font> <%}
                    if ((ses.getAttribute("dmpvhead")) != null) {
%>&nbsp; <font color="6600CC"><b>Village:</b></font><font face="verdana"
				size="2"></td>
			<td><%=ses.getAttribute("dmpvhead")%></font> <%}
                    if ((ses.getAttribute("phead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Program:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("phead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("sphead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Sub Program:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("sphead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("wchead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Work Category:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("wchead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("schemehead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Scheme:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("schemehead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("expyear")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Fin Year:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("expyear")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("planhead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Plan/Non Plan:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("planhead")%></font>
				</td>
			</tr>
			<%}
                    if ((ses.getAttribute("augnewhead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>MainSch/Aug./Main.:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("augnewhead")%></font>
				</td>
			</tr>
		</table>
		<br>
		<%}
                    if ((ses.getAttribute("selection1")) != ""
                            || (ses.getAttribute("selection2")) != ""
                            || (ses.getAttribute("selection3")) != ""
                            || (ses.getAttribute("selection4")) != ""
                            || (ses.getAttribute("selection5")) != ""
                            || (ses.getAttribute("selection6")) != ""
                            || (ses.getAttribute("selection7")) != ""
                            || (ses.getAttribute("selection8")) != ""
                            || (ses.getAttribute("selection9")) != ""
                            || (ses.getAttribute("selection10")) != ""
                            || (ses.getAttribute("selection11")) != "") {

                        %>
		<table>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Selection
				Criteria:</b></font></td>
			</tr>
			<%if ((ses.getAttribute("selection1")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection1")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection2")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection2")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection3")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection3")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection4")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection4")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection5")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection5")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection6")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection6")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection7")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection7")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection8")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection8")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection9")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection9")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection10")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection10")%></font>
			</tr>
			</td>
			<%}
                        if ((ses.getAttribute("selection11")) != null) {

                            %>
			<tr>
				<td><font face="verdana" size="2"><%=ses.getAttribute("selection11")%></font>
			</tr>
			</td>
			<%}
                    }

                    %>
			<table align="center">
				<tr align="left">
					<td align="left">
					<table border="0">
						<tr class="btext">
							<%if ((ses.getAttribute("cp")) != null) {
%>
							<td class="btext" nowrap><b>Census Plain:</b><%=ses.getAttribute("cp_condition")%>
							<font color="black"> <%=ses.getAttribute("cp")%></font></td>
							<%}

                    %>
							<%if ((ses.getAttribute("csc")) != null) {
%>
							<td class="btext" nowrap><b>Census SC:</b><%=ses.getAttribute("csc_condition")%>
							<font color="black"> <%=ses.getAttribute("csc")%></font></td>
							<%}

                    %>
							<%if ((ses.getAttribute("cst")) != null) {
%>
							<td class="btext" nowrap><b>Census ST:</b><%=ses.getAttribute("cst_condition")%>
							<font color="black"> <%=ses.getAttribute("cst")%></font></td>
							<%}

                    %>

							<%if ((ses.getAttribute("flopop")) != null) {
%>
							<td class="btext" nowrap><b>Floating Pop:</b><%=ses.getAttribute("flopop_condition")%>
							<font color="black"> <%=ses.getAttribute("flopop")%></font></td>
							<%}

                    %>

							<%if ((ses.getAttribute("floreason")) != null) {
%>
							<td class="btext" nowrap>Floating Reason: <font color="black"> <%=ses.getAttribute("floreason")%></font></td>
							<%}

                    %>

							<%if ((ses.getAttribute("ctot")) != null) {
%>
							<td class="btext" nowrap><b>Census Total:</b><%=ses.getAttribute("ctot_condition")%>
							<font color="black"> <%=ses.getAttribute("ctot")%></font></td>
							<%}

                    %>
							<%if ((ses.getAttribute("cstat")) != null
                            && !(ses.getAttribute("cstat").equals(""))) {
%>
							<td class="btext">Current Coverage Status: <font color="black"> <%=ses.getAttribute("cstat")%></font></td>
							<%}

                    %>
							<%if ((ses.getAttribute("pstat")) != null
                            && !(ses.getAttribute("pstat").equals(""))) {
%>
							<td class="btext">Previous Yr. Coverage Status:<font
								color="black"> <%=ses.getAttribute("pstat")%></font></td>
							<%}

                    %>
						</tr>
						<%if (((ses.getAttribute("totwat")) != null)
                            || ((ses.getAttribute("extwat")) != null)
                            || ((ses.getAttribute("nearsurface")) != null)
                            || ((ses.getAttribute("nearground")) != null)
                            || ((ses.getAttribute("amntreqd")) != null)
                            || ((ses.getAttribute("propyr")) != null)) {

                        %>
						<tr class="btext">
							<%if ((ses.getAttribute("totwat")) != null) {
%>

							<td class="btext"><b>Total Water Supply:</b><%=ses
                                                    .getAttribute("tot_wat_supl_condition")%>
							<font color="black"><%=ses.getAttribute("totwat")%></font></td>
							<%}

                        %>
							<%if ((ses.getAttribute("extwat")) != null) {
%>
							<td class="btext">Exist Water Level:<%=ses.getAttribute("ext_wat_lvl")%>
							<font color="black"> <%=ses.getAttribute("extwat")%></font></td>
							<%}

                        %>
							<%if ((ses.getAttribute("nearsurface")) != null) {
%>
							<td class="btext">Near Surface Source:<%=ses
                                                    .getAttribute("near_surf_source_condition")%>
							<font color="black"><%=ses.getAttribute("nearsurface")%></font></td>
							<%}

                        %>
							<%if ((ses.getAttribute("nearground")) != null) {
%>
							<td class="btext">Near Ground Source:<%=ses
                                                    .getAttribute("near_ground_source_condition")%>
							<font color="black"><%=ses.getAttribute("nearground")%></font></td>
							<%}

                        %>
							<%if ((ses.getAttribute("amntreqd")) != null) {
%>
							<td cl ass="btext">Prop. FC Amnt:<%=ses.getAttribute("amnt_reqd_condition")%>
							<font color="black"><%=ses.getAttribute("amntreqd")%></font></td>
							<%}

                        %>
							<%if ((ses.getAttribute("propyr")) != null) {
%>
							<td class="btext">Prop.FC Year: <%=ses.getAttribute("propyr")%></td>
							<%}

                    %>
						</tr>
						<%}%>
					</table>
					</td>
				</tr>
				<%}

                %>
				<tr>
					<td align="left">
					<table border="1" cellspacing=0 cellpadding=0 width="740"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">

						<tr>
							<c:forEach items="${column}" var="item" varStatus="status">
								<th class="btext"><c:out value="${item}" /></th>
							</c:forEach>
						</tr>

						<%
						int totexpindex = 0;int workidindex=0;
						for(int jj = 0;jj<columns.size();jj++)
						{
							if((""+columns.get(jj)).equals("Total Expenditure"))
							{	
								totexpindex = jj;
							}
							if((""+columns.get(jj)).equals("Work Id"))
							{	
								workidindex = jj;
							}
						}
						totexpindex--;workidindex--;
						
						int count = 0;
                if (ses.getAttribute("key").equals("dreport")) {
                    int result = 0;
                    for (int ii = 0; ii < columns.size(); ii++) {
                        if (columns.get(ii).equals("Work Name"))
                            result = ii;
                    }
                    for (int i = 0; i < ((ArrayList) ses.getAttribute("rows"))
                            .size(); i++) {
                            						int colcount = 0;
                        count++;
%>
						<tr onmouseover="this.style.background='#E3E4FA'"
							onmouseout="this.style.background='WHITE'">
							<td align="center" class="rptValue" nowrap><%=count%></td>
							<form name="temp"><%ArrayList rows1 = (ArrayList) (((ArrayList) ses
                                .getAttribute("rows")).get(i));
                        int totcolumn = rows1.size() - 1;
						boolean ff = false;
						for (int j = 0; j < rows1.size(); j++) {

							colcount++;
							if(colcount==totexpindex)ff=true;
							//System.out.println("1:"+colcount);
                            if (rows1.get(j)!=null) {
                                request.setAttribute("currentworkid", ""+rows1.get(workidindex));
                                String currentworkid = (String) request.getAttribute("currentworkid");
						%> 
						
							<%
                                if (!(""+rows1.get(j)).equals("0.0")) {
							%> 
							<td align="left" class="rptValue" nowrap>
							<%String hrefstring1 = "'javascript:popWinOpen("+ currentworkid + ")'";
                                    
                                   if(request.getAttribute("totalexpfield")!=null && request.getAttribute("totalexpfield").equals("yes") && !(""+rows1.get(j)).equals("0.0")&&totexpindex==j)                    {
                                   out.println("<a href=" + hrefstring1 + ">"+rows1.get(j)+"</a>");
									}
									else
									{
										if((""+rows1.get(j)).length()==14)
											out.println("&nbsp;"+rows1.get(j));
										else
											out.println(rows1.get(j));
									}

                                    %><%} else {%>
							<td align="left" class="rptValue" nowrap><%=rows1.get(j)%>
							<%}%></td>
							<%} else {%>
							<td align="left" class="rptValue" nowrap><%out.println(rows1.get(j));

                            %></td>
							<%}
                        }
%>
							</form>
						</tr>
						<%}%>
						<b><font face="verdana" color="indigo">Total No. Of Records:</font><font
							face="verdana" size="2"><%=count%></font></b>
						<%}%>
						<!-- CONSOLIDATED REPORT -->
						<%if (ses.getAttribute("key").equals("chlist1")) {

                    %>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr>
								<td class="rptValue"><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="noOfHabs" /></td>
								<%if (columns.contains("Census Plain Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusPop" /></td>
								<%}
                        if (columns.contains("Census SC Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSc" /></td>
								<%}
                        if (columns.contains("Census ST Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSt" /></td>
								<%}
                        if (columns.contains("Census Float Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusFloat" /></td>
								<%}
                        if (columns.contains("Total Population")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusTotal" /></td>
								<%}%>
							</tr>
						</nested:iterate>
						<%}

                %>
						<%if (ses.getAttribute("key").equals("chlist")) {

                    %>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr>
								<td class="rptValue"><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="noOfHabs" /></td>
								<%if (columns.contains("Census Plain Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusPop" /></td>
								<%}
                        if (columns.contains("Census SC Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSc" /></td>
								<%}
                        if (columns.contains("Census ST Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSt" /></td>
								<%}
                        if (columns.contains("Census Float Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusFloat" /></td>
								<%}
                        if (columns.contains("Total Population")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusTotal" /></td>
								<%}%>

							</tr>
						</nested:iterate>
						<%}%>


						<%if (ses.getAttribute("key").equals("chlist2")) {

                    %>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td><bean:write name="default1" property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="noOfHabs" /></td>
								<%if (columns.contains("Census Plain Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusPop" /></td>
								<%}
                        if (columns.contains("Census SC Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSc" /></td>
								<%}
                        if (columns.contains("Census ST Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSt" /></td>
								<%}
                        if (columns.contains("Census Float Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusFloat" /></td>
								<%}
                        if (columns.contains("Total Population")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusTotal" /></td>
								<%}%>

							</tr>
						</nested:iterate>
						<%}%>


						<%if (ses.getAttribute("key").equals("chlist3")) {

                    %>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="noOfHabs" /></td>
								<%if (columns.contains("Census Plain Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusPop" /></td>
								<%}
                        if (columns.contains("Census SC Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSc" /></td>
								<%}
                        if (columns.contains("Census ST Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSt" /></td>
								<%}
                        if (columns.contains("Census Float Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusFloat" /></td>
								<%}
                        if (columns.contains("Total Population")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusTotal" /></td>
								<%}%>

							</tr>
						</nested:iterate>
						<%}%>

						<%if (ses.getAttribute("key").equals("chlist4")) {
%>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="noOfHabs" /></td>
								<%if (columns.contains("Census Plain Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusPop" /></td>
								<%}
                        if (columns.contains("Census SC Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSc" /></td>
								<%}
                        if (columns.contains("Census ST Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusSt" /></td>
								<%}
                        if (columns.contains("Census Float Pop.")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusFloat" /></td>
								<%}
                        if (columns.contains("Total Population")) {%>
								<td class="rptValue"><bean:write name="default1"
									property="censusTotal" /></td>
								<%}%>
							</tr>
						</nested:iterate>
						<%}%>




						<!-- Masters District Detail -->
						<%if (ses.getAttribute("key").equals("masterd")) {

                    %>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="distCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="distName4" /></td>
							</tr>
						</nested:iterate>

						<%}%>

						<!-- Master Mandal Details -->

						<%int l = 0;
                if (ses.getAttribute("key").equals("masterm")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
							</tr>
							<%l++;

                    %>
						</nested:iterate>
						<b>Total No. Of Mandals:</b>
						<font color="660000"><%=l%></font>
						<%}%>
						<!-- Master Panchayat Details -->
						<%int k = 0;
                if (ses.getAttribute("key").equals("masterp")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
							</tr>
							<%k++;

                    %>
						</nested:iterate>
						<b>Total No. Of Panchayats:</b>
						<font color="660000"><%=k%></font>
						<%}%>


						<%if (ses.getAttribute("key").equals("masterp1")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
							</tr>
							<%k++;

                    %>
						</nested:iterate>
						<b>Total No. Of Panchayats:</b>
						<font color="660000"><%=k%></font>
						<%}%>


						<!-- Master Village Details -->
						<%int j = 0;
                if (ses.getAttribute("key").equals("masterv")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						&nbsp;&nbsp;
						<b>Panchayat :</b>
						<font color="660000"><%=ses.getAttribute("dmphead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="villCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villName" /></td>
							</tr>
							<%j++;

                    %>
						</nested:iterate>
						<b>Total No. Of Villages:</b>
						<font color="660000"><%=j%></font>
						<%}%>

						<%if (ses.getAttribute("key").equals("masterv1")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="villCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villName" /></td>
							</tr>
							<%j++;

                    %>
						</nested:iterate>
						<b>Total No. Of Villages:</b>
						<font color="660000"><%=j%></font>
						<%}%>

						<%if (ses.getAttribute("key").equals("masterv2")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villName" /></td>
							</tr>
							<%j++;

                    %>
						</nested:iterate>
						<b>Total No. Of Villages:</b>
						<font color="660000"><%=j%></font>
						<%}%>



						.
						<!-- Master Habitations Details -->
						<%int i = 0;
                if (ses.getAttribute("key").equals("masterh")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Panchayat :</b>
						<font color="660000"><%=ses.getAttribute("dmphead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Village :</b>
						<font color="660000"><%=ses.getAttribute("dmpvhead")%></font>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="habCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="habName" /></td>
							</tr>
							<%i++;

                    %>
						</nested:iterate>
						<b>Total No. Of Habitations:</b>
						<font color="660000"><%=i%></font>
						<%}%>

						<%if (ses.getAttribute("key").equals("masterh1")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Panchayat :</b>
						<font color="660000"><%=ses.getAttribute("dmphead")%></font>
						&nbsp;&nbsp;&nbsp;
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="habCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="habName" /></td>
							</tr>
							<%i++;

                    %>
						</nested:iterate>
						<b>Total No. Of Habitations:</b>
						<font color="660000"><%=i%></font>
						<%}%>

						<%if (ses.getAttribute("key").equals("masterh2")) {

                    %>
						<b>District :</b>
						<font color="660000"><%=ses.getAttribute("dhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<b>Mandal :</b>
						<font color="660000"><%=ses.getAttribute("dmhead")%></font>
						&nbsp;&nbsp;&nbsp;
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="habCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="habName" /></td>
							</tr>
							<%i++;

                    %>
						</nested:iterate>
						<b>Total No. Of Habitations:</b>
						<font color="660000"><%=i%></font>
						<%}%>


						<%if (ses.getAttribute("key").equals("masterh3")) {

                    %>
						<b>District :</b>
						<%=ses.getAttribute("dhead")%>
						<nested:iterate name="dlist1" id="default1">
							<%count++;

                        %>
							<tr class="rptValue">
								<td><%=count%></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="mandalName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="panchName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="villName" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="habCode" /></td>
								<td class="rptValue"><bean:write name="default1"
									property="habName" /></td>
							</tr>
							<%i++;

                    %>
						</nested:iterate>
						<b>Total No. Of Habitations:</b>
						<font color="660000"><%=i%></font>
						<%}%>
						<%if (count == 0) {%>
						<tr class="rptValue">
							<td colspan="30" align="center">No Records</td>
						</tr>
						<%}

            %>
					</table>
					</td>
				</tr>
			</table>
			<center><%@ include file="/commons/rws_footer.jsp"%></center>
			</td>
			</tr>
		</table>
</BODY>
</html:html>
