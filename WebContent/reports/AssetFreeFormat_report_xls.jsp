<%@ page contentType="application/vnd.ms-excel" %>

<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<html:html>


		<table>
			<%HttpSession ses = request.getSession(false);
        		String some=request.getParameter("offices");
			//System.out.println("s:"+some);
			if(some!=null && !some.equals(""))
			{

           if ((ses.getAttribute("cohead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Circle:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("cohead")%></font>
				</td>
			
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
			
			<%}
			}
			 else{
			if ((ses.getAttribute("disthead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>District:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("disthead")%></font>
				</td>
			
			<%}
              if ((ses.getAttribute("mandhead")) != null) {
  %>
			<tr>
			<td><font color="6600CC" face="verdana" size=2><b>Mandal:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("mandhead")%></font>
			</td>
			
			<%}
			
	      if ((ses.getAttribute("panchhead")) != null) {
  %>
			<tr>
			<td><font color="6600CC" face="verdana" size=2><b>Panchayat:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("panchhead")%></font>
			</td>
			
			<%}
			
			if ((ses.getAttribute("villagehead")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Village:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("villagehead")%></font>
			</td>
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
			</td>
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
			
			<%}
		 if ((ses.getAttribute("yrcreationcond"))!=null ||(ses.getAttribute("yrcreation")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Yr Creation:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("yrcreationcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("yrcreation")%></font></td>
			
			
			<%}
			
			
			
			if ((ses.getAttribute("costassetcond")) != null || (ses.getAttribute("assetcost")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Asset Cost:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("costassetcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("assetcost")%></font>
			
			</td>
			<%}
			if ((ses.getAttribute("nofhabcond")) != null || (ses.getAttribute("Nofhabben")) != null) {
			System.out.println(" hab ");
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>No Of Hab Benefited:</b></font>
			</td>
			<td><font face="verdana" size="2"><%=ses.getAttribute("nofhabcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("Nofhabben")%></font>
			
			</td>
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
          
%>
	 <table border="1" cellspacing=0 cellpadding=0 width="740"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
						<tr>
						<%for(int i=0;i<column.size();i++){ %>
					   <td  align="center" class="btext"><font color="6600CC" face="verdana" size=2><b><%=column.get(i) %></b></font></td><%} %>
					
					</tr>
	  <%
	  int result = 0;
	  int columnSize=column.size();
for(int ii=0;ii<column.size();ii++)
{
	if(column.get(ii).equals("No of Habs Benefited"))	result = ii;
}
System.out.println("position:"+result);
	   int count=0;
	   for (int i = 0; i < ((ArrayList) ses.getAttribute("rows"))
                            .size(); i++) {
						
                        count++;
	  ArrayList rows1 = (ArrayList) (((ArrayList) ses.getAttribute("rows")).get(i));
	
	 // System.out.println("ttttt"+rows1);
	   
	   %><tr onmouseover="this.style.background='#E3E4FA'"
							onmouseout="this.style.background='WHITE'">
			 <td align="center" class="rptValue" nowrap><%=count%></td>
			 <% for (int j = 0; j < rows1.size(); j++) {
			    
			    if(result > j)
			    {
			      %>
			      
	              <td align="left" class="rptValue" nowrap><%=rows1.get(j)%>&nbsp;
				  
				  <%}
						else
						{ 
						  if(!(rows1.get(j).equals("0"))){					
						%>
	                   <td align="left" class="rptValue" nowrap><%=rows1.get(j)%>&nbsp;
						
						
						<%}else{
						%>
	                   <td align="left" class="rptValue" nowrap><%=rows1.get(j)%>&nbsp; 
						
						
						<%}
						
					}
					}%></tr><%}%>
				
	</table>
	</table>

</BODY>
</html:html>

