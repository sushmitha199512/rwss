<%@ page import = "nic.watersoft.commons.*, java.util.*"%>
<%@ page import = "javax.naming.*, javax.sql.*"%>

<%
	

String programmeCode = request.getParameter("programmeCode");
String index = request.getParameter("index");
CommonLists commonLists = new CommonLists();
ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);

%>

<script language="JavaScript">
<!--
top.document.getElementById("WORK[<%= index%>].subprogrammeCode").options.length=0;
var opt = new Option("Select...", "");
top.document.getElementById("WORK[<%= index%>].subprogrammeCode").options["0"]=opt;
//-->
</script>

<%
for(int i=0; i<subprogrammes.size(); i++)
{
	LabelValueBean labelValueBean = (LabelValueBean)subprogrammes.get(i);
	String value = labelValueBean.getValue();
	String label = labelValueBean.getLabel();
%>
	<script language="JavaScript">
	<!--
	var opt = new Option("<%= label%>", "<%= value%>");
	top.document.getElementById("WORK[<%= index%>].subprogrammeCode").options["<%= i+1%>"]=opt;
	//-->
	</script>
<%
}
%>
