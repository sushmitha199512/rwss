<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<html>
<body>
 <%
 String check=request.getParameter("check");

 //System.out.println("check:"+check);
if(check!=null && check.equals("view"))
{
if (((java.util.ArrayList)session.getAttribute("viewlist"))!=null && !((java.util.ArrayList)session.getAttribute("viewlist")).equals(""))
{
int count1;
  count1=((java.util.ArrayList)session.getAttribute("viewlist")).size();
  //System.out.println(" count in viewlist:"+count1);
  %>
   <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
	<tr  align="center">
  <% java.util.ArrayList sss2 = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("viewlist")).get(1);
	  for(int j=0;j<sss2.size();j++)
	  {
		// System.out.println("ssssssssss:"+sss2.get(j));
		  %>
		  <td class=btext  align="center" colspan=20><%=sss2.get(j)%>&nbsp;</td></tr>
  <%}%>
 <table border="1" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
  <tr  align="center">
  <% java.util.ArrayList sss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("viewlist")).get(0);
	  for(int j=0;j<sss.size();j++)
	  {
		  %>
		  <td class=btext><%=sss.get(j)%>&nbsp;</td>
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
	  <%=ss.get(j)%>&nbsp;</td>
		<%}%></tr>
  <%i++;}%></table>

<%}
} if(check!=null && check.equals("pan"))
{
if (((java.util.ArrayList)session.getAttribute("panlist"))!=null && !((java.util.ArrayList)session.getAttribute("panlist")).equals("")) {
	int count2;
  count2=((java.util.ArrayList)session.getAttribute("panlist")).size();
  //System.out.println(" count in viewlist:"+count1);
  %>
   <table border="0" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
	<tr  align="center">
  <% java.util.ArrayList ssss2 = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(1);
	  for(int j=0;j<ssss2.size();j++)
	  {
		// System.out.println("ssssssssss:"+sss2.get(j));
		  %>
		  <td class=btext  align="center" colspan=15><%=ssss2.get(j)%>&nbsp;</td></tr>
  <%}%>
 <table border="1" cellspacing=0 cellpadding=0 width="100%"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
  <tr  align="center">
  <% java.util.ArrayList ssss = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(0);
	  for(int j=0;j<ssss.size();j++)
	  {
		  %>
		  <td class=btext><%=ssss.get(j)%>&nbsp;</td>
  <%}		  //System.out.println("count1:"+count1);%></tr>
  <%for(int i=2;i<count2;i++)
  {
	  java.util.ArrayList ssd = (java.util.ArrayList)((java.util.ArrayList)session.getAttribute("panlist")).get(i);
	  //System.out.println(ss);
	  for(int j=0;j<ssd.size();j++)
	  {
		 
		   try{
			 double d=Double.parseDouble(""+ssd.get(j));
		  %>
		  <td class=rptvalue  align="right" >
		  <%}catch(Exception e){
		  %>
		    <td class=rptvalue  align="left" nowrap>		  
		  <%}%>
	  <%=ssd.get(j)%>&nbsp;</td>
	<%}%></tr>
  <%i++;}%></table>

  <%}
  
}
  %>
	</body>
	</html>