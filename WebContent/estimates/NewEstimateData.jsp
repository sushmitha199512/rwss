<%@ page import = "nic.watersoft.commons.*"%>
<%@ page import = "java.util.*"%>


<%
String assetType = request.getParameter("assetType");
String componentCode = request.getParameter("componentCode");
String index = request.getParameter("index");
out.println("assetType: " + assetType);
out.println("componentCode: " + componentCode);
out.println("index: " + index);

if( !(assetType.equals("null") || componentCode.equals("null") || index.equals("null")) )
{
%>
	<script language="JavaScript">
	<!--
	top.document.getElementById("component[<%= index%>].assetSubComponent").options.length=0;
	var opt = new Option("Select...","");
	top.document.getElementById("component[<%= index%>].assetSubComponent").options[0]=opt;
	//-->
	</script>

<%
	CommonLists commonLists = new CommonLists();
	ArrayList subComponents = commonLists.getAssetSubComponents(assetType, componentCode);
	for(int i=0; i<subComponents.size(); i++)
	{
		LabelValueBean labelValueBean = (LabelValueBean)subComponents.get(i);
		String value = labelValueBean.getValue();
		String label = labelValueBean.getLabel();

%>
		<script language="JavaScript">
		<!--
			var opt = new Option("<%= label%>", "<%= value%>");
			top.document.getElementById("component[<%= index%>].assetSubComponent").options["<%= i+1%>"]= opt;
		//-->
		</script>

<%
	}
}
%>