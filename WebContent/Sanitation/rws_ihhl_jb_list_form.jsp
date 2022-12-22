<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="javax.servlet.http.*" %>

<html:html>
<HEAD>
<%@ page import="java.util.*" language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">

<TITLE></TITLE>
</HEAD>
<BODY>
<table>
<tr><td class=btext align="center">IHHL Free Format Report</td></tr>
<tr>
<td align=right>
<A HREF="/pred/switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=inFlexi">Back</A>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>
<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
</td>
</tr>
<tr><td>
<%
HttpSession ses=request.getSession(false);
ArrayList columns=(ArrayList)ses.getAttribute("column");
//System.out.println("columns"+columns);
%>
<%if (ses.getAttribute("key").equals("dreport") || ses.getAttribute("key").equals("chlist1") || ses.getAttribute("key").equals("chlist2") || ses.getAttribute("key").equals("chlist3") || ses.getAttribute("key").equals("chlist4")){ %>
<%if((ses.getAttribute("dhead"))!=null)
{
%>
<font color="6600CC"><b>District:</b></font><%= ses.getAttribute("dhead") %>
<%
}
if((ses.getAttribute("dmhead"))!=null)
{
%>
&nbsp;
<font color="6600CC"><b>Mandal:</b></font><%= ses.getAttribute("dmhead") %>
<%
}
if((ses.getAttribute("dmphead"))!=null)
{
%>&nbsp;
<font color="6600CC"><b>Panchayat:</b></font><%= ses.getAttribute("dmphead") %>
<%
}
if((ses.getAttribute("dmpvhead"))!=null)
{
%>&nbsp;
<font color="6600CC"><b>Village:</b></font><%= ses.getAttribute("dmpvhead") %>
<%
}
if((session.getAttribute("dmphvhead"))!=null)
{
%>&nbsp;
<font color="6600CC"><b>Habitation:</b></font><%= session.getAttribute("dmphvhead") %>
<%
}
%>
<table align="center">
<tr align="left"><td align="left">
<table border="0"><tr class="btext">

</tr>
<%
if ( ((ses.getAttribute("totwat"))!=null) || ((ses.getAttribute("extwat"))!=null) || ((ses.getAttribute("nearsurface"))!=null) || ((ses.getAttribute("nearground"))!=null) || ((ses.getAttribute("amntreqd"))!=null) || ((ses.getAttribute("propyr"))!=null) )
{
%>
<tr class="btext">
<%
if ((ses.getAttribute("totwat"))!=null)
{
%>

<td class="btext"><b>Total Water Supply:</b><%= ses.getAttribute("tot_wat_supl_condition") %>
<font color="black"><%= ses.getAttribute("totwat")%></font></td>
<% } %>
<%
if ((ses.getAttribute("extwat"))!=null)
{
%><td class="btext">
Exist Water Level:<%= ses.getAttribute("ext_wat_lvl_condition") %>
<font color="black">
<%= ses.getAttribute("extwat")%></font></td>
<% } %>
<%
if ((ses.getAttribute("nearsurface"))!=null)
{
%>
<td class="btext">Near Surface Source:<%= ses.getAttribute("near_surf_source_condition") %>
<font color="black"><%= ses.getAttribute("nearsurface")%></font></td>
<% } %>
<%
if ((ses.getAttribute("nearground"))!=null)
{
%><td class="btext">
Near Ground Source:<%= ses.getAttribute("near_ground_source_condition") %>
<font color="black"><%= ses.getAttribute("nearground")%></font></td>
<% } %>
<%
if ((ses.getAttribute("amntreqd"))!=null)
{
%>
<td class="btext">
Prop. FC Amnt:<%= ses.getAttribute("amnt_reqd_condition")%>
<font color="black"><%= ses.getAttribute("amntreqd")%></font></td>
<% } %>
<%
if ((ses.getAttribute("propyr"))!=null)
{
%>
<td class="btext">
Prop.FC Year:
<%= ses.getAttribute("propyr")%></td>
<% } %>
</tr>
<%}%>
</table></td></tr>
<%} %>
<tr><td align="left">
<table border = "1" cellspacing = 0 cellpadding = 0 width="740" align="center" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	

<tr><c:forEach items="${column}" var="item" varStatus="status">
<th class="btext"><c:out value="${item}"/>
</th></c:forEach></tr>

<%  int count=0;
//System.out.println("key-------->"+ses.getAttribute("key"));
if (ses.getAttribute("key").equals("dreport"))
{
for (int i=0;i<((ArrayList)ses.getAttribute("rows")).size();i++)
{
count++;
%>
<tr><td align="center" class="rptValue" nowrap><%= count%></td>
<%
ArrayList rows1=(ArrayList)(((ArrayList)ses.getAttribute("rows")).get(i));
//System.out.println("rows1"+rows1);
String prevcount=(String)session.getAttribute("prevstatuscount");
String prescount=(String)session.getAttribute("presstatuscount");
String slippagecount = (String)session.getAttribute("slipcount");
//System.out.println("prevcount"+prevcount+"prescount"+prescount+"slippagecount"+slippagecount);
String previousStat=null,presentStat=null;
int prstatus=0,prestatus=0;
int previouscnt=0,slcount=0,presentcnt=0;

if(prevcount!=null && previouscnt==0){
		previouscnt=Integer.parseInt(prevcount)-1;
	
		}
if(prescount!=null && presentcnt==0){
		presentcnt=Integer.parseInt(prescount)-1;
		
		}
if(slippagecount!=null && slcount==0){
		slcount=Integer.parseInt(slippagecount)-1;
	
		}
		
for(int j=0;j<rows1.size();j++)
{
	try
	{
	double d=Double.parseDouble(""+rows1.get(j));%>
<td align="right" class="rptValue" nowrap> 
<%
	}
	catch(Exception e)
	{%>
<td align="left" class="rptValue" nowrap> 
<%}
    if(previouscnt>0){
    	
				previousStat=(String)rows1.get(previouscnt);
				presentStat=(String)rows1.get(presentcnt);
				if(previousStat.equals("FC")){prstatus=1;}
		 	    if(previousStat.equals("PC4")){prstatus=2;}
		        if(previousStat.equals("PC3")){prstatus=3;}
		        if(previousStat.equals("PC2")){prstatus=4;}
		        if(previousStat.equals("PC1")){prstatus=5;}
		        if(previousStat.equals("NC")){prstatus=6;}
		        if(previousStat.equals("NSS")){prstatus=7;}
		        if(presentStat.equals("FC")){prestatus=1;}
		        if(presentStat.equals("PC4")){prestatus=2;}
		        if(presentStat.equals("PC3")){prestatus=3;}
		        if(presentStat.equals("PC2")){prestatus=4;}
		        if(presentStat.equals("PC1")){prestatus=5;}
		        if(presentStat.equals("NC")){prestatus=6;}
		        if(presentStat.equals("NSS")){prestatus=7;}
				//System.out.println("prevstatus"+previousStat+"prstatus"+prstatus);				
				//System.out.println("prestatus"+presentStat+"prestatus"+prestatus);
				}
				if(slcount>0 &&  j==slcount){
				if(prstatus>=prestatus ){				
				 out.println("--");
			    }else{
					if((""+rows1.get(j)).length()==16)
											out.println("&nbsp;"+rows1.get(j));
										else
											out.println(rows1.get(j));
				  //out.println(rows1.get(j));
				}
				}
				else{
					if((""+rows1.get(j)).length()==16)
											out.println("&nbsp;"+rows1.get(j));
										else
											out.println(rows1.get(j));
					//out.println(rows1.get(j));
					}
%>
</td>
<%
}
%>
</tr>
<%}%>
<b><font color="indigo">Total No. Of Records:</font><%= count %></b>
<%}%>
<!-- CONSOLIDATED REPORT -->
<%
if (ses.getAttribute("key").equals("chlist1"))
{ System.out.println("chlist5");%>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr >
<td class="rptValue" align="right">
<%= count %>
</td>
<td class="rptValue" align="center"> 
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue" >
<bean:write name="default1" property="distName4"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="categoryName"/>
</td>

<td class="rptValue" align="right">
<bean:write name="default1" property="noOfCategory"/>
</td>

</tr>
</nested:iterate>
<% } %>
<%
if (ses.getAttribute("key").equals("chlist"))
{//System.out.println("chlist"); %>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr>
<td class="rptValue">
<%= count %>
</td>
<td  class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="districtName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="cardName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfCardtype"/>
</td>




</tr>
</nested:iterate>
<%}%>

<%
if (ses.getAttribute("key").equals("chlist5"))
{System.out.println("chlist5");
	%>
	
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr>
<td class="rptValue">
<%= count %>
</td>
<td  class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="distName4"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="categoryName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfCategory"/>
</td>


</tr>
</nested:iterate>
<%}%>


<%
if (ses.getAttribute("key").equals("chlist6"))
{System.out.println("chlist6");
	%>
	
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr>
<td class="rptValue">
<%= count %>
</td>
<td  class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="districtName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="gender"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfFM"/>
</td>


</tr>
</nested:iterate>
<%}%>
<%
if (ses.getAttribute("key").equals("chlist7"))
{System.out.println("chlist7");
	%>
	
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr>
<td class="rptValue">
<%= count %>
</td>
<td  class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="districtName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="categoryName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfCategory"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="subcategory"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfSubCategory"/>
</td>

</tr>
</nested:iterate>
<%}%>





<%
if (ses.getAttribute("key").equals("chlist2"))
{ %>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue">
<td>
<%= count %>
</td>
<td>
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="distName4"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<%if(columns.contains("Census Plain Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusPop"/>
</td>
<%} if(columns.contains("Census SC Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusSc"/>
</td>
<% }if(columns.contains("Census ST Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusSt"/>
</td>
<%}if(columns.contains("Census Float Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusFloat"/>
</td>
<%}if(columns.contains("Total Population"))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusTotal"/>
</td>
<%}%>

</tr>
</nested:iterate>
<%}%>


<%
if (ses.getAttribute("key").equals("chlist3"))
{ %>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue">
<td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="distName4"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>
<%if(columns.contains("Census Plain Pop."))
{%>
<td class="rptValue">
<bean:write name="default1" property="censusPop"/>
</td>
<%} if(columns.contains("Census SC Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusSc"/>
</td>
<% }if(columns.contains("Census ST Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusSt"/>
</td>
<%}if(columns.contains("Census Float Pop."))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusFloat"/>
</td>
<%}if(columns.contains("Total Population"))
{%>
<td class="rptValue" align="right">
<bean:write name="default1" property="censusTotal"/>
</td>
<%}%>

</tr>
</nested:iterate>
<%}%>

<%
if (ses.getAttribute("key").equals("chlist4"))
{
	//System.out.println("done");
%>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue">
<td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="distName4"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villName"/>
</td>
<td class="rptValue" align="right">
<bean:write name="default1" property="noOfHabs"/>
</td>

</tr>
</nested:iterate>
<%}%>




<!-- Masters District Detail -->
<%
if (ses.getAttribute("key").equals("masterd"))
{ %>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="distCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="distName4"/>
</td>
</tr>
</nested:iterate>

<%}%>

<!-- Master Mandal Details -->

<%
int l=0;
if (ses.getAttribute("key").equals("masterm"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalName"/>
</td>
</tr>
<% l++; %>
</nested:iterate>
<b>Total No. Of Mandals:</b><font color="660000"><%= l %></font>
<%}%>
<!-- Master Panchayat Details -->
<%
int k=0;
if (ses.getAttribute("key").equals("masterp"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;<b>Constituency :</b><font color="660000"><%= ses.getAttribute("conhead") %></font>&nbsp;&nbsp;<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead") %></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
</tr>
<% k++; %>
</nested:iterate>
<b>Total No. Of Panchayats:</b><font color="660000"><%= k %></font>
<%}%>


<%
if (ses.getAttribute("key").equals("masterp1"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue" nowrap>
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
</tr>
<% k++; %>
</nested:iterate>
<b>Total No. Of Panchayats:</b><font color="660000"><%= k %></font>
<%}%>


<!-- Master Village Details -->
<%
int j=0;
if (ses.getAttribute("key").equals("masterv"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;<b>Constituency :</b><font color="660000"><%= ses.getAttribute("conhead") %></font>
&nbsp;&nbsp;<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead") %></font>&nbsp;&nbsp;<b>Panchayat :</b><font color="660000"><%= ses.getAttribute("dmphead") %></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td><td class="rptValue">
<bean:write name="default1" property="villCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villName"/>
</td>
</tr>
<% j++; %>
</nested:iterate>
<b>Total No. Of Villages:</b><font color="660000"><%= j %></font>
<%}%>

<%
if (ses.getAttribute("key").equals("masterv1"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;
<b>Constituency :</b><font color="660000"><%= ses.getAttribute("conhead")%></font>&nbsp;&nbsp;&nbsp
<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead") %></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td><td class="rptValue">
<bean:write name="default1" property="villCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villName"/>
</td>
</tr>
<% j++; %>
</nested:iterate>
<b>Total No. Of Villages:</b><font color="660000"><%= j %></font>
<%}%>

<%
if (ses.getAttribute("key").equals("masterv2"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villName"/>
</td>
</tr>
<% j++; %>
</nested:iterate>
<b>Total No. Of Villages:</b><font color="660000"><%= j %></font>
<%}%>




<!-- Master Habitations Details -->
<%
int i=0;
if (ses.getAttribute("key").equals("masterh"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;&nbsp;
<b>Constituency :</b><font color="660000"><%= ses.getAttribute("conhead")%></font>&nbsp;&nbsp;&nbsp
<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead")%></font>&nbsp&nbsp;&nbsp&nbsp&nbsp;
&nbsp;&nbsp;&nbsp&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp&nbsp&nbsp;
<b>Panchayat :</b><font color="660000"><%= ses.getAttribute("dmphead") %></font>&nbsp;&nbsp;
<b>Village :</b><font color="660000"><%= ses.getAttribute("dmpvhead") %></font>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td><td class="rptValue">
<bean:write name="default1" property="habCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="habName"/>
</td>
</tr>
<% i++; %>
</nested:iterate>
<b>Total No. Of Habitations:</b><font color="660000"><%= i %></font>
<%}%>

<%
if (ses.getAttribute("key").equals("masterh1"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;&nbsp;<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead") %></font>&nbsp;&nbsp;&nbsp;<b>Panchayat :</b><font color="660000"><%= ses.getAttribute("dmphead") %></font>&nbsp;&nbsp;&nbsp;
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td><td class="rptValue">
<bean:write name="default1" property="habCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="habName"/>
</td>
</tr>
<% i++; %>
</nested:iterate>
<b>Total No. Of Habitations:</b><font color="660000"><%= i %></font>
<%}%>

<%
if (ses.getAttribute("key").equals("masterh2"))
{ %>
<b>District :</b><font color="660000"><%= ses.getAttribute("dhead")%></font>&nbsp;&nbsp;&nbsp;
<b>Constituency :</b><font color="660000"><%= ses.getAttribute("conhead")%></font>&nbsp;&nbsp;&nbsp
<b>Mandal :</b><font color="660000"><%= ses.getAttribute("dmhead") %></font>&nbsp;&nbsp;&nbsp;
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td><td class="rptValue">
<bean:write name="default1" property="habCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="habName"/>
</td>
</tr>
<% i++; %>
</nested:iterate>
<b>Total No. Of Habitations:</b><font color="660000"><%= i %></font>
<%}%>


<%
if (ses.getAttribute("key").equals("masterh3"))
{ %>
<b>District :</b><%= ses.getAttribute("dhead")%>
<nested:iterate name="dlist1" id="default1">
<% count++; %>
<tr class="rptValue"><td>
<%= count %>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="constituencyName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="mandalCode"/>
</td>
<td class="rptValue" nowrap>
<bean:write name="default1" property="mandalName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="panchName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="villName"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="habCode"/>
</td>
<td class="rptValue">
<bean:write name="default1" property="habName"/>
</td>
</tr>
<% i++; %>
</nested:iterate>
<b>Total No. Of Habitations:</b><font color="660000"><%= i %></font>
<%}%>
<%
if (count==0)
{%>
<tr class="rptValue"><td colspan="30" align="center"> No Records </td></tr>
<%}
 ses.removeAttribute("tot_wat_supl_condition"); %>
</table></td></tr></table>
<center><%@ include file="/commons/rws_footer.jsp"%></center></td></tr></table>
</BODY>
</html:html>

