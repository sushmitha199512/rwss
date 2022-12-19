<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="nic.watersoft.commons.*, java.util.*,javax.sql.*,javax.naming.*"%>
		
<%		Context ctx = new InitialContext();
      	DataSource dataSource = (DataSource)ctx.lookup("java:comp/env/jdbc/pred");
		RwsOffices rwsOffices = new RwsOffices(dataSource);%>

<script language="JavaScript">
<!--
function fnSubmit()
{

	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="HeadOffice")
	{
		document.f1.action="./rws_head_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="CircleOffice")
	{
		document.f1.action="./rws_circle_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="DivisionOffice")
	{
		document.f1.action="./rws_division_rpt.jsp";
		document.f1.submit();
	}
	if(document.f1.selection.options[document.f1.selection.selectedIndex].text=="SubDivisionOffice")
	{
		document.f1.action="./rws_subdivision_rpt.jsp";
		document.f1.submit();
	}
}
function setHname()
{
var i = document.f1.head.selectedIndex;
document.f1.hname.value=document.f1.head.options[i].text;
}
function setCname()
{
var i = document.f1.circle.selectedIndex;
document.f1.cname.value=document.f1.circle.options[i].text;
}
function setDname()
{
var i = document.f1.division.selectedIndex;
document.f1.dname.value=document.f1.division.options[i].text;
}
function setSdname()
{
var i = document.f1.subdivision.selectedIndex;
document.f1.sdname.value=document.f1.subdivision.options[i].text;
}
//-->
</script>

<form name=f1 action="<%= request.getRequestURI()%>">
	<input type="hidden" name="hname" value="">
	<input type="hidden" name="cname" value="">
	<input type="hidden" name="dname" value="">
	<input type="hidden" name="sdname" value="">
	
	
	
<%
	String rHead = null;
	String rCircle = null;
	String rDivision = null;
	String rSubdivision = null;
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
		<td class=myfontclr colspan=2><B><font color="#FFFFFF">Offices Query Form</font></B></td>	
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
			<option>HeadOffice</option>
			<option>CircleOffice</option>
			<option>DivisionOffice</option>
			<option>SubDivisionOffice</option>
			
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
		if(request.getParameter("selection")!= null && request.getParameter("selection").equals("CircleOffice"))
		{
			//System.out.println(request.getParameter("selection"));
%>
	
	
	<tr>
		<td class = clrborder>Head Office</font></td>
		<td class = bwborder><select name="head" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
	rHead = request.getParameter("head");
	ArrayList head = rwsOffices.getHeads();
	String hHCode = null;
	String hHName = null;

	for(int i=0; i<head.size(); i++)
	{
		LabelValueBean rwsOffice = (LabelValueBean) head.get(i);
		hHCode = rwsOffice.getValue();
		hHName = rwsOffice.getLabel();

		if(rHead != null && rHead.equals(hHCode) )
		{
%>
		<option value="<%= hHCode %>" selected><%= hHName %>
<script language="JavaScript">
<!--
setHname();
//-->
</script>
<% 

		}// END OF IF
		else 
		{
%>
<option value="<%= hHCode %>" ><%= hHName %>
<%		
		} 
	}// END OF FOR
		}// END OF MAIN IF
		
		else
		if(request.getParameter("selection")!= null && request.getParameter("selection").equals("DivisionOffice"))
		{
			//System.out.println(request.getParameter("selection"));
	%>
	<tr>
		<td class = clrborder>Head Office</font></td>
		<td class = bwborder><select name="head" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
			

		ArrayList head = rwsOffices.getHeads();
		String hHCode = null;
		String hHName = null;
		for(int i=0; i<head.size(); i++)
		{
			LabelValueBean rwsOffice = (LabelValueBean) head.get(i);
			hHCode = rwsOffice.getValue();
			hHName = rwsOffice.getLabel();

		if(request.getParameter("head") != null && request.getParameter("head").equals(hHCode) )
		{
%>
		<option value="<%= hHCode %>" selected><%= hHName %>
<script language="JavaScript">
<!--
setHname();
//-->
</script>
<% 
		
		}// END OF IF
		else 
		{
%>
<option value="<%= hHCode %>" ><%= hHName %>
<%		
	}
		
	}// END OF FOR
%>
	<tr>
		<td class = clrborder>Circle Office :</td>
		<td class = bwborder>
		<select name="circle" style="width:150px" class = "mycombo" onchange = "this.form.submit()" disabled>
		<option value="00">Please Select...</option>
<%
		
		//System.out.println("rCircle : "+rCircle);
		if (request.getParameter("head") != null)
		{
			ArrayList circle = rwsOffices.getCircles(request.getParameter("head"));
		
			//System.out.println("cirlce.size()= "+circle.size());
			String hCCode = null;
			String hCName = null;		
		for(int i=0; i<circle.size(); i++)
		{		

			LabelValueBean rwsOffice = (LabelValueBean) circle.get(i);
			hCCode = rwsOffice.getValue();
			hCName = rwsOffice.getLabel();
			
		if(request.getParameter("circle") != null && request.getParameter("circle").equals(hCCode) )				
		{
%>			
		<option value="<%= hCCode %>" selected><%= hCName %>
		<script language="JavaScript">
		<!--
		setCname();
		//-->
		</script>		
<%
		}// END OF IF
		else 
		{
%>
		
		<option value="<%= hCCode %>" ><%= hCName %>
		<script language="JavaScript">
		<!--
		document.f1.circle.disabled=false;
		//-->
		</script>
<%		
		
		}
		}
	}// END OF FOR
			

}// END OF MAIN IF

	else
		if(request.getParameter("selection")!= null && request.getParameter("selection").equals("SubDivisionOffice"))
		{
			//System.out.println(request.getParameter("selection"));
		
%>
	<tr>
		<td class = clrborder>Head Office</font></td>
		<td class = bwborder><select name="head" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">Please Select...</option>
<%
			

		ArrayList head = rwsOffices.getHeads();
		String hHCode = null;
		String hHName = null;
		for(int i=0; i<head.size(); i++)
		{
			LabelValueBean rwsOffice = (LabelValueBean) head.get(i);
			hHCode = rwsOffice.getValue();
			hHName = rwsOffice.getLabel();

		if(request.getParameter("head") != null && request.getParameter("head").equals(hHCode) )
		{
%>
		<option value="<%= hHCode %>" selected><%= hHName %>
<script language="JavaScript">
<!--
setHname();
//-->
</script>
<% 
		
		}// END OF IF
		else 
		{
%>
<option value="<%= hHCode %>" ><%= hHName %>
<%		
	}
		
	}// END OF FOR
	
%>
<tr>
		<td class = clrborder>Circle Office :</td>
		<td class = bwborder>
		<select name="circle" style="width:150px" class = "mycombo" onchange = "this.form.submit()" disabled>
		<option value="00">Please Select...</option>
<%
		
		//System.out.println("rCircle : "+rCircle);
		if (request.getParameter("head") != null)
		{
			ArrayList circle = rwsOffices.getCircles(request.getParameter("head"));
		
			//System.out.println("cirlce.size()= "+circle.size());
			String hCCode = null;
			String hCName = null;		
		for(int i=0; i<circle.size(); i++)
		{		

			LabelValueBean rwsOffice = (LabelValueBean) circle.get(i);
			hCCode = rwsOffice.getValue();
			hCName = rwsOffice.getLabel();
			
		if(request.getParameter("circle") != null && request.getParameter("circle").equals(hCCode) )				
		{
%>			
		<option value="<%= hCCode %>" selected><%= hCName %>
		<script language="JavaScript">
		<!--
		setCname();
		//-->
		</script>		
<%
		}// END OF IF
		else 
		{
%>
		
		<option value="<%= hCCode %>" ><%= hCName %>
		<script language="JavaScript">
		<!--
		document.f1.circle.disabled=false;
		//-->
		</script>
<%		
		
		}
		}
	}// END OF FOR
%>
	<tr>
		<td class = clrborder>Division Office :</td>
		<td class = bwborder>
		<select name="division" style="width:150px" class = "mycombo" onchange = "this.form.submit()" disabled>
		<option value="0">Please Select...</option>
<%
		rDivision = request.getParameter("division");
		//System.out.println("rDivision : "+rDivision);
		if (request.getParameter("head") != null && request.getParameter("circle") != null)
		{
			ArrayList division = rwsOffices.getDivisions(request.getParameter("head"),request.getParameter("circle"));
		
			
			String hDCode = null;
			String hDName = null;		
		for(int i=0; i<division.size(); i++)
		{		

			LabelValueBean rwsOffice = (LabelValueBean) division.get(i);
			hDCode = rwsOffice.getValue();
			hDName = rwsOffice.getLabel();
			
		if(request.getParameter("division") != null && request.getParameter("division").equals(hDCode))				
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
		<script language="JavaScript">
		<!--
		document.f1.division.disabled=false;
		//-->
		</script>
<%		
		
		}
		}
	}// END OF FOR
			

}// END OF MAIN IF
%>
	
	

		</select>
		</td>
	</tr>
		</select>
		</td>
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