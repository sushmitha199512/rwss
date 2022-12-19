<%//System.out.println(" in detail report JSP"); %>
<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<html:html>
<HEAD>
<%@ page import="java.util.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE></TITLE>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/menu.js' />">
</script>
<script language="javascript">
function openEditWindow(url)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
</script>
</HEAD>
<BODY>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/overlib.js' />">
</script>
<DIV id=overDiv style="Z-INDEX: 999; POSITION: absolute"></DIV>
<table>
	<tr>
		<td align=right><A HREF="javascript:history.go(-1)">Back</A>&nbsp;|&nbsp;
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;<a
			href="./reports/AssetFreeFormat_detailreport_xls.jsp" target="_new">Excel</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%">
			<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs)</b></caption>
		</table>
		<table>
			<%HttpSession ses = request.getSession(false);
           	String some=request.getParameter("offices");
			////System.out.println("s:"+some);
			if(!some.equals(""))
			{

           if ((ses.getAttribute("cohead")) != null) {
%>
			<tr>
				<td ><font face="verdana" size=2 color="6600CC"><b>Circle:</b></font></td>
				<td ><font face="verdana" size="2"><%=ses.getAttribute("cohead")%></font>
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
			}
			 else{
			if ((ses.getAttribute("disthead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>District:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("disthead")%></font>
				</td>
			</tr>
			<%}
              if ((ses.getAttribute("mandhead")) != null) {
  %>
			<tr>
			<td><font color="6600CC" face="verdana" size=2><b>Mandal:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("mandhead")%></font>
			</td>
			</tr>
			<%}
			
	      if ((ses.getAttribute("panchhead")) != null) {
  %>
			<tr>
			<td><font color="6600CC" face="verdana" size=2><b>Panchayat:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("panchhead")%></font>
			</td>
			</tr>
			<%}
			
			if ((ses.getAttribute("villagehead")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Village:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("villagehead")%></font>
			</td></tr>
			<%}
				if ((ses.getAttribute("habhead")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Habitation:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("habhead")%></font>
			</td></tr>
			<%}
			}
			
			if ((ses.getAttribute("assetname")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Asset Type:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("assetname")%></font>
			</td></tr>
			<%}
			if ((ses.getAttribute("assetstatus")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Asset Status:</b></font>
			</td>
			<% String as="";
			if(ses.getAttribute("assetstatus").equals("1")){as="WORKING";}
			if(ses.getAttribute("assetstatus").equals("2")){as="NOT WORKING";}
			if(ses.getAttribute("assetstatus").equals("3")){as="DIRED";}
			if(ses.getAttribute("assetstatus").equals("4")){as="SEASONAL";}
			if(ses.getAttribute("assetstatus").equals("5")){as="CONDEMED";}
			%>
			
			<td><font face="verdana" size="2"><%=as%></font>
			</td>
			</tr>
			<%}
		 if ((ses.getAttribute("yrcreationcond"))!=null ||(ses.getAttribute("yrcreation")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Yr Creation:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("yrcreationcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("yrcreation")%></font></td>
			
			</tr>
			<%}
			
			
			
			if ((ses.getAttribute("costassetcond")) != null || (ses.getAttribute("assetcost")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Asset Cost:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("costassetcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("assetcost")%></font>
			
			</td></tr>
			<%}
			if ((ses.getAttribute("nofhabcond")) != null || (ses.getAttribute("Nofhabben")) != null) {
			//System.out.println(" hab ");
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>No Of Hab Benefited:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("nofhabcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("Nofhabben")%></font>
			
			</td></tr>
			<%}
			if ((ses.getAttribute("popbenefited")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Population Benefited:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("popbencond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("popbenefited")%></font>
			
			
			</td></tr>
			<%}
			 
			%>
      
	<% 
                ArrayList column = (ArrayList) ses.getAttribute("column");
                 //System.out.println(" column:" +column.size());
               %> 
                <table border="1" cellspacing=0 cellpadding=0 width="740"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
              
  <%
 
	  int result = 0;
	  int columnSize=column.size();
for(int ii=0;ii<column.size();ii++)
{
	if(column.get(ii).equals("No of Habs Benefited"))	result = ii;
}
//System.out.println("position:"+result); 
	   int count=1;
	   for (int i = 0; i < ((ArrayList) ses.getAttribute("rows"))
                            .size(); i++) {
		   
                     ////System.out.println("1");        
                            %>
                        
						<%
//System.out.println("1.1");
    ArrayList rows1 = (ArrayList) (((ArrayList) ses.getAttribute("rows")).get(i));
     
    
      if(rows1!=null && rows1.size()>2)
      {//System.out.println("rows1:"+rows1.size());
     if(rows1!=null && rows1.size()>0)
		 {
     System.out.println("2:"+rows1.get(0));
	 System.out.println("2:"+rows1.get(1));
	 System.out.println("2:"+rows1.get(2));
	 
ArrayList rowsss2=(ArrayList)rows1.get(0);
				
				    %>
	                <tr><td class="btext" colspan=<%=((ArrayList)rows1.get(1)).size() %>><b><font color="" face="verdana" size=2><%=rowsss2.get(0)%></font></b></td></tr>
	             <tr>  <%
			     
				ArrayList rowss2=(ArrayList)rows1.get(1);
				
				  for(int k=0;k<rowss2.size();k++)
				    {
					  System.out.println("2:"+rowss2.get(k));
				    %>
	                <td  align="left" class="btext"><font color="" face="verdana" size=2><%=rowss2.get(k)%></font></td>
			      <%
			      }
			      %>
			      </tr>
			      <% 
			      //System.out.println("rows1111111:"+rows1.size());
			     
	    for (int j = 2; j < rows1.size(); j++) {
	     ArrayList rows2=(ArrayList)rows1.get(j);
	      String acode=(String)rows2.get(0);
		  //System.out.println("acode:"+acode);
	  //System.out.println("rows2.size():"+rows2.size());
	     %><tr onmouseover="this.style.background='#E3E4FA'"
							onmouseout="this.style.background='WHITE'">
			 <td align="left" class="rptValue" nowrap><%=count++%></td><%
				  //System.out.println("rows2:"+rows2);
				   for(int k=0;k<rows2.size();k++)
				    {
					//System.out.println("k:"+k);
					 int pos=0;
					 for(int i1=0;i1<((ArrayList)rows1.get(1)).size();i1++)
					  {
						  if(((ArrayList)rows1.get(1)).get(i1).equals("No of Habs Benefited"))
						  {
						    pos=i1;
						  }
					  } 
					  pos--;
					 // System.out.println(pos);
					  if(pos==k)
					  { %>
					   
					    <td align="left" class="rptValue" nowrap><a href="#1" onclick=openEditWindow('switch.do?prefix=/reports&page=/rws_asset_habdetails.jsp?&acode=<%=acode%>')><%=rows2.get(k)%></a></tr>
					  <%}else{
					  %>
	                   <td align="left" class="rptValue" nowrap><%=rows2.get(k)%> </tr>
					  <%
					 }
					 
					 }%></tr><%	
					
					 
					} %>
					<br><tr><td colspan=<%=((ArrayList)rows1.get(1)).size() %>>&nbsp;&nbsp;</td></tr><%}
					}
					
					%>
					
					 </table>
					<table border="1" cellspacing=0 cellpadding=0 width="740"
						align="" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">	
					<%
					count=1;
					}
				%>
	  </tr></table>
	
	
</BODY>

</html:html>
<%@ include file="/commons/rws_footer.jsp"%>

