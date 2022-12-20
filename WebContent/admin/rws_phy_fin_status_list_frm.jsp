<%@ page import ="java.util.ArrayList" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<Script language="javascript">
function main()
{
	window.location="/pred/home.do";
}
</script>
<body bgcolor="#edf2f8">
<html:form action="MonPhyFin.do">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			<tr align="right">
			<td class="bwborder">
				<a href="<rws:context page='/switch.do?prefix=/admin&page=/MonPhyFin.do?mode=init'/>">Back|</a>
				 <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
			</td>
		</tr>
	</table>
</caption>
<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
		<font color="ffffff">Monthly Physical  Financial Status Report </font></td>
</tr>
</table>
<table  align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >
<tr>
		<td class="textborder" align="center">
			<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status As On :<%=request.getParameter("mfin_year")%> </font><font color=#F2A80D> </font></td>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td class="btext" >S.NO.</td>
		<td class="btext" >District Name</td> 
		<td class="btext">APR </td>
		<td class="btext">MAY </td>
		<td class="btext">JUN </td>
		<td class="btext">JUL</td>
		<td class="btext">AUG</td>
		<td class="btext">SEP</td>
		<td class="btext">OCT</td>
		<td class="btext">NOV</td>
        <td class="btext">DEC</td>
        <td class="btext">JAN</td>
        <td class="btext">FEB</td>
        <td class="btext">MAR</td>		
</tr>
<tr>


<% 
 int j=1; 
 int n=((ArrayList)session.getAttribute("district")).size();
 ArrayList mdistrict= (ArrayList)session.getAttribute("district");
 String[][] status = new String[22][13];
 status=(String[][])session.getAttribute("status");
 System.out.println("getting dcode");
 ArrayList dcode=(ArrayList)session.getAttribute("dcode");
 System.out.println("dcode size is "+dcode.size());
 int k=0;
 for (int i=0;i<n;i++) {%>
    <td class="btext"><%=j%></td>
    <td class=label><%nic.watersoft.commons.LabelValueBean district =(nic.watersoft.commons.LabelValueBean)mdistrict.get(i);%><%=district.getLabel() %></td>
    <% for (k=1; k<=12;k++) {
		
  //   if ((dcode.get(i) != null) && (Integer.parseInt(((nic.watersoft.commons.LabelValueBean)dcode.get(i)).getValue())==i)) 
      if (status[i][k] != null) 
      {%>
        <td class="text" bgcolor=green></td>  
        <%; 
      }
      else  
      { %>
          <td class="text" bgcolor= maroon>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;</td>
          <%; 
      }
 }
%>
</tr>
<tr> 
<% j++; }%>				 		
</tr> 
<tr>
</tr>
</table>
<table align =left border=0 bgcolor="#ffffff" width=100%>
<tr><td class="text" bgcolor= green>&nbsp&nbsp</td><td>Data Entered </td></tr>
<tr><td class="text" bgcolor= maroon> &nbsp&nbsp</td><td> Data Not Entered </td></tr>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>

