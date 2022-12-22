<%@ page import = "nic.watersoft.commons.*, java.util.*"%>
<%@ page import = "javax.naming.*, javax.sql.*"%>

<%
	

String programmeCode = request.getParameter("programmeCode");
CommonLists commonLists = new CommonLists();
ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);

%>

<script language="JavaScript">
<!--
var noOfWorks = top.document.getElementById("noOfWorks").value;
document.write("noOfWorks" + noOfWorks);
noOfWorks = noOfWorks-1;
document.write("proposals["+noOfWorks+"].subprogrammeCode");
top.document.getElementById("proposals["+noOfWorks+"].subprogrammeCode").options.length=0;
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
	var noOfWorks = top.document.getElementById("noOfWorks").value;
	noOfWorks = noOfWorks-1;
	var opt = new Option("<%= label%>", "<%= value%>");
	top.document.getElementById("proposals["+noOfWorks+"].subprogrammeCode").options["<%= i%>"]=opt;
	//-->
	</script>
<%
}
%>
