
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>

<html:html>
<BODY>

 <%
 String check=(String)request.getAttribute("check");
// System.out.println(" check:"+check);
if(check!=null && check.equals("dist"))
{
 int count;
  count=((java.util.ArrayList)session.getAttribute("distlist")).size();
  //System.out.println(" count in jsp:"+count);
  String  atype=request.getParameter("assetType");
  //System.out.println("atype in JSP$$$$$$$:"+ atype);
  int sno=0,gtot=0;

%>
<table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:window.close()">Close</A>
   </table>
		<table border="0" cellspacing="0" cellpadding="0" width="50%"
					 align="center" >
			<tr  align="center">
			<logic:iterate id="rep" name="distlist">
			<td class="btext"><bean:write name="rep" property="astName"/>
			</logic:iterate>
			</tr>
			</table>
			<table border="1" cellspacing="0" cellpadding="0" width="50%"
					bordercolor="#000000" style="border-collapse:collapse"   align="center" >
					<tr align="center">
						<td class=btext>S.NO</td>
						<td class=btext>DISTRICT NAME</td>
						<td class=btext>TOTAL</td >
						</tr>			
					<logic:iterate id="rep" name="distlist">
					<%if(sno!=0){%>
						<tr>	
						<td class="rptvalue"><bean:write name="rep" property="sno"/></td>
						<td class="rptvalue"><a href='./DpDrilldown.do?mode=dpump&assetType=<%=atype%>&ccode=<bean:write name="rep" property="distCode"/>&cname=<%=request.getParameter("cname")%>&scname=<%=request.getParameter("scname")%>&dname=<bean:write name="rep" property="name"/>'><bean:write name="rep" property="name"/></a></td>
						<td class="rptvalue" align="right"><bean:write name="rep" property="total"/></td>
						<bean:define id="tot" scope="request" >
						<bean:write name="rep" property="total"/>	
						</bean:define>	
					   </tr>
					<%
						gtot+=Integer.parseInt(tot);
						}
						
						sno++;%>
					</logic:iterate>
				    <td class="rptvalue">**</td>
					<td class="rptvalue">Total</td>
					<td class="rptvalue" align="right"><%=gtot%></td>
					
				</table>

<%}if(check!=null && check.equals("div"))	
{
	int count1;
  count1=((java.util.ArrayList)session.getAttribute("divlist")).size();
  String  atype=request.getParameter("assetType");
 // System.out.println(" count in jsp:"+count1);
  int sno=0,gtot=0;;
  %>
   <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:history.go(-1)">Back</A>|<a href="javascript:window.close()">Close</a></td></tr></table>
   <table border="0" cellspacing="0" cellpadding="0" width="50%"
					bordercolor="#000000"   style="border-collapse:collapse" align="center" >
<tr  align="center"><td class=btext>DISTRICT :
<logic:iterate id="cpwsReport" name="divlist" >
<bean:write name="cpwsReport" property="distCode"/><br>
<bean:write name="cpwsReport" property="astName"/>
</logic:iterate></td></tr>
</table>
         <table border="1" cellspacing="0" cellpadding="0" width="50%"
					bordercolor="#000000"   style="border-collapse:collapse" align="center" >
					<tr align="center">
						<td class=btext>S.NO</td>
						<td class=btext>DIVISION NAME</td>
						<td class=btext>TOTAL</td >
						</tr>	
						<%%>
					<logic:iterate id="cpwsReport" name="divlist" >
							<%
						       
							if(sno!=0){%>
							<TR>
								<td class="rptvalue"><bean:write name="cpwsReport" property="sno"/></td>
								<td class="rptvalue"><a href='./DpDrilldown.do?mode=dpump&assetType=<%=atype%>&divcode=<bean:write name="cpwsReport" property="divCode"/>&cname=<%=request.getParameter("cname")%>&scname=<%=request.getParameter("scname")%>&ccode=<%=request.getParameter("ccode")%>&divname=<bean:write name="cpwsReport" property="name"/>&dname=<%=request.getParameter("dname")%>'><bean:write name="cpwsReport" property="name"/></a></td>
						     <td class="rptvalue"  align="right"><bean:write name="cpwsReport" property="total"/></td>	
								<bean:define id="tot" scope="request" >
								<bean:write name="cpwsReport" property="total"/>	
								</bean:define>	
								<%								 
								gtot+=Integer.parseInt(tot);
								%>
							</TR> 
							<%
								}sno++;
								%>
								
					</logic:iterate>
					<td class="rptvalue">**</td>
					<td class="rptvalue">Total</td>
					<td class="rptvalue"  align="right"><%=gtot%></td>
					<tr>
					
					</tr>
               </table>
	<%}
					

if(check!=null && check.equals("subdiv"))	
{
	
	int count1;
  count1=((java.util.ArrayList)session.getAttribute("subdivlist")).size();
 // System.out.println(" count in jsp:"+count1);
   String  atype=request.getParameter("assetType");
 int sno=0,gtot=0;
  %>
   <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:history.go(-1)">Back</A>|<a href="javascript:window.close()">Close</a></td></tr></table>
 <table border="0" cellspacing="0" cellpadding="0" width="50%"
	bordercolor="#000000"   style="border-collapse:collapse" align="center" >
<tr  align="center"><td class=btext>
DISTRICT:<%=request.getParameter("dname")%>&nbsp;&nbsp;DIVISION :
<logic:iterate id="cpwsReport" name="subdivlist" >
<bean:write name="cpwsReport" property="divName"/><br>
<bean:write name="cpwsReport" property="astName"/>
</logic:iterate></td></tr>
</table>

 <table border="1" cellspacing="0" cellpadding="0" width="50%"
					bordercolor="#000000" style="border-collapse:collapse"   align="center" >
					<tr align="center">
						<td class=btext>S.NO</td>
						<td class=btext>SUBDIVISION NAME</td>
						<td class=btext>TOTAL</td >
						</tr>		
					<logic:iterate id="rep" name="subdivlist" >
								<%if(sno!=0){%>
							<TR>
								<td class="rptvalue"><bean:write name="rep" property="sno"/></td>
								<td class="rptvalue"><a href='./DpDrilldown.do?mode=dpump&assetType=<%=atype%>&subcode=<bean:write name="rep" property="subdivCode"/>&cname=<%=request.getParameter("cname")%>&scname=<%=request.getParameter("scname")%>&ccode=<%=request.getParameter("ccode")%>&divcode=<%=request.getParameter("divcode")%>&dname=<%=request.getParameter("dname")%>&divname=<%=request.getParameter("divname")%>&subname=<bean:write name="rep" property="name"/>'><bean:write name="rep" property="name"/></a></td>
						     <td class="rptvalue"  align="right"><bean:write name="rep" property="total"/></td>	
							 <bean:define id="tot" scope="request" >
								<bean:write name="rep" property="total"/>	
								</bean:define>	
							</tr>	<%								 
								gtot+=Integer.parseInt(tot);						
							
								}sno++;%>
					</logic:iterate>
					<tr>
					<td class="rptvalue">**</td>
					<td class="rptvalue">Total</td>
					<td class="rptvalue"  align="right"><%=gtot%></td>
					</tr>
               </table>

<%}if(check!=null && check.equals("mand"))	
{
	
	int count1;
  count1=((java.util.ArrayList)session.getAttribute("mandallist")).size();
   String  atype=request.getParameter("assetType");
//  System.out.println(" count in jsp:"+count1);
  int cn=0,sn=0,gtot=0;
  %>
   <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:history.go(-1)">Back</A>|<a href="javascript:window.close()">Close</a></table>
  <table border="0" cellspacing="0" cellpadding="0" width="50%"
	bordercolor="#000000"   style="border-collapse:collapse" align="center" >
<tr  align="center"><td class=btext>
DISTRICT:<%=request.getParameter("dname")%>&nbsp;&nbsp;DIVISION :<%=request.getParameter("divname")%>
&nbsp;&nbsp;SUBDIVISION:<%=request.getParameter("subname")%><br>
<logic:iterate id="cpwsReport" name="mandallist" >
<bean:write name="cpwsReport" property="astName"/>
</logic:iterate></td></tr></table>
         <table border="1" cellspacing="0" cellpadding="0" width="50%"
					bordercolor="#000000"  style="border-collapse:collapse"  align="center" >
					<tr align="center">
						<td class=btext>S.NO</td>
						<td class=btext>MANDAL NAME</td>
						<td class=btext>TOTAL</td >
						</tr>		
					<logic:iterate id="rep" name="mandallist" >
							<%if(sn!=0){%>
							<TR>
								<td class="rptvalue"><%=++cn%></td>
								<td class="rptvalue"><a href='./DpDrilldown.do?mode=dpump&assetType=<%=atype%>&mcode=<bean:write name="rep" property="sno"/>&cname=<%=request.getParameter("cname")%>&scname=<%=request.getParameter("scname")%>&ccode=<%=request.getParameter("ccode")%>&divcode=<%=request.getParameter("divcode")%>'><bean:write name="rep" property="name"/></a></td>
						     <td class="rptvalue"  align="right"><bean:write name="rep" property="total"/></td>	
						    	<bean:define id="tot" scope="request" >
								<bean:write name="rep" property="total"/>	
								</bean:define>	
							</tr>
							<%gtot+=Integer.parseInt(tot);	
						        }	
						
								sn++;%>
					</logic:iterate>
					<tr>
					<td class="rptvalue">**</td>
					<td class="rptvalue">Total</td>
					<td class="rptvalue"  align="right"><%=gtot%></td>
					</tr>
               </table>

	<%}if(check!=null && check.equals("view"))	{
			int count1;
  count1=((java.util.ArrayList)session.getAttribute("viewlist")).size();
  //System.out.println(" count in viewlist:"+count1);
  %>
 <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:history.go(-1)">Back</A>|<a href="javascript:window.close()">Close</a>|<a
			href="./rws_direct_pumping_xls.jsp?check=view" target="_new">Excel</a></td></td> 			
 </table>
  <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
	<tr  align="center">
  <% java.util.ArrayList sss2 = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("viewlist")).get(1);
	  for(int j=0;j<sss2.size();j++)
	  {
		 //System.out.println("ssssssssss:"+sss2.get(j));
		
		  %>
		    <td class=btext  align="center"><%=sss2.get(j)%></td>
		  </tr>
  <%}%>
 <table border="1" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
  <tr  align="center">
  <% java.util.ArrayList sss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("viewlist")).get(0);
	  for(int j=0;j<sss.size();j++)
	  {
		  %>
		  <td class=btext><%=sss.get(j)%></td>
  <%}		  //System.out.println("count1:"+count1);%></tr>
  <%for(int i=2;i<count1;i++)
  {
	  java.util.ArrayList ss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("viewlist")).get(i);
	  //System.out.println(ss);
	  for(int j=0;j<ss.size();j++)
	  {
		 
        try{
			 double d=Double.parseDouble(""+ss.get(j));
		  %>
		  <td class=rptvalue  align="right" >
		  <%}catch(Exception e){
		  %>
		    <td class=rptvalue  align="left" nowrap>		  
		  <%}%>
	  <%=ss.get(j)%></td>

  <%}%></tr>
  <%i++;}%></table>
					
	<%}if(check!=null && check.equals("panch"))	{
			int count1;
  count1=((java.util.ArrayList)session.getAttribute("panlist")).size();
  //System.out.println(" count in viewlist:"+count1);
  %>
    <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
   <tr><td align="right"><A HREF="javascript:history.go(-1)">Back</A>|<a href="javascript:window.close()">Close</a>|<a
			href="./rws_direct_pumping_xls.jsp?check=pan" target="_new">Excel</a></td></td> 		
 </table>
  <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
	<tr  align="center">
  <% java.util.ArrayList sss2 = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(1);
	  for(int j=0;j<sss2.size();j++)
	  {
		 //System.out.println("ssssssssss:"+sss2.get(j));
		  %>
		  <td class=btext  align="center"><%=sss2.get(j)%></td></tr>
  <%}%>
 <table border="1" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
  <tr  align="center">
  <% java.util.ArrayList sss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(0);
	  for(int j=0;j<sss.size();j++)
	  {
		  %>
		  <td class=btext><%=sss.get(j)%></td>
  <%}		  //System.out.println("count1:"+count1);%></tr>
  <%for(int i=2;i<count1;i++)
  {
	  java.util.ArrayList ss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(i);
	  //System.out.println(ss);
	  for(int j=0;j<ss.size();j++)
	  {
		  try{
			 double d=Double.parseDouble(""+ss.get(j));
		  %>
		  <td class=rptvalue  align="right" >
		  <%}catch(Exception e){
		  %>
		    <td class=rptvalue  align="left" nowrap>		  
		  <%}%>
	  <%=ss.get(j)%></td>
  <%}%></tr>
  <%i++;}%></table>
					
	<%}%>
	<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed</font>
</BODY>


</html:html>
<%@ include file="/commons/rws_footer.jsp"%>