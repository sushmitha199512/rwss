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
			href="./reports/AssetFreeFormat_report_xls.jsp" target="_new">Excel</a>
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
			//// System.out.println("s:"+some);
			if(!some.equals(""))
			{

           if ((ses.getAttribute("cohead")) != null) {
%>
			<tr>
				<td><font face="verdana" size=2 color="6600CC"><b>Circle:</b></font></td>
				<td><font face="verdana" size="2"><%=ses.getAttribute("cohead")%></font>
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
			<td align="right"><font face="verdana" size="2"><%=ses.getAttribute("costassetcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("assetcost")%></font>
			
			</td></tr>
			<%}
			if ((ses.getAttribute("nofhabcond")) != null || (ses.getAttribute("Nofhabben")) != null) {
			// System.out.println(" hab ");
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>No Of Hab Benefited:</b></font>
			</td>
			<td align="right"><font face="verdana" size="2"><%=ses.getAttribute("nofhabcond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("Nofhabben")%></font>
			
			</td></tr>
			<%}
			if ((ses.getAttribute("popbenefited")) != null) {
  %>
	         <tr>
	         <td><font color="6600CC" face="verdana" size=2><b>Population Benefited:</b></font>
			</td>
			<td align="right"><font face="verdana" size="2"><%=ses.getAttribute("popbencond")%></font>&nbsp;
			<font face="verdana" size="2"><%=ses.getAttribute("popbenefited")%></font>
			
			
			</td></tr>
			<%}
			 
			%>
              
     
	<% 
                ArrayList column = (ArrayList) ses.getAttribute("column");
             // // System.out.println(" column:" +column.size());
                
                
%>
	 <table border="1" cellspacing=0 cellpadding=0 width="740"
						align="center" bordercolor=#000000
						style="border-collapse:collapse" bgcolor="#ffffff">
						<tr>
						<%for(int i=0;i<column.size();i++){ %>
					   <td  align="center" class="btext"><font color="" face="verdana" size=2><%=column.get(i) %></font></td><%} %>
					
					</tr>
	  <%
	  int result = 0;
	  int columnSize=column.size();
for(int ii=0;ii<column.size();ii++)
{
	if(column.get(ii).equals("No of Habs Benefited"))	result = ii;
} 
// System.out.println("position:"+result);
	   int count=0;
	   for (int i = 0; i < ((ArrayList) ses.getAttribute("rows"))
                            .size(); i++) {
						
                        count++;
	  ArrayList rows1 = (ArrayList) (((ArrayList) ses.getAttribute("rows")).get(i));
	
	 // // System.out.println("ttttt"+rows1);
	   
	   %><tr onmouseover="this.style.background='#E3E4FA'"
							onmouseout="this.style.background='WHITE'">
			 <td align="center" class="rptValue" nowrap><%=count%></td>
			 <% 
			   String acode=(String)rows1.get(0);
			   //System.out.println("0:"+rows1.get(0));
			   //System.out.println("1:"+rows1.get(1));
			   //System.out.println("2:"+rows1.get(2));
			   //System.out.println("3:"+rows1.get(3));
			   //System.out.println("4:"+rows1.get(4));
			  // System.out.println("5:"+rows1.get(5));
			   //System.out.println("6:"+rows1.get(6));
			   //System.out.println("7:"+rows1.get(7));
			   //System.out.println("8:"+rows1.get(8));
			   //System.out.println("9:"+rows1.get(9));
			   //System.out.println("10:"+rows1.get(10)); 

			 for (int j = 0; j < rows1.size(); j++) {
			    
			    if(result > j)
			    {
			     int i1;
			    int pos = 1;
			      for(i1=1;i1<column.size();i1++)
					{
						if(column.get(i1).equals("No of Habs Benefited")){
						// val=;
						//System.out.println("ffffff:"+column.get(i1));
						//System.out.println(i1);
						pos = i1;
						}
					}  
					 pos--;
					
				//System.out.println("POS:"+pos);
				//System.out.println("J:"+j);
			       if(pos==j)
			       {
			       //System.out.println("ssssssssssssss"); %>
			       
		  <td  class="rptValue" align="right" nowrap>
		  <a href="#1" onclick=openEditWindow('switch.do?prefix=/reports&page=/rws_asset_habdetails.jsp?&acode=<%=acode%>')><%=rows1.get(j)%></a></td>
		  

				  <%}else {
				   //System.out.println("dddddddddddddd");
				  %>
	              <td align="left" class="rptValue" nowrap><%=rows1.get(j)%></td>
				   <%
				   }
					}
					else
						{
 							// System.out.println("rows1:"+rows1.get(9));
					  if(!(rows1.get(j).equals("0"))){					
						%>
	                   <td align="right" class="rptValue" nowrap><%=rows1.get(j)%>
						
						 </tr>
						<%}else{
						%>
	                   <td align="right" class="rptValue" nowrap><%=rows1.get(j)%>
						
						 </tr>
						<%}
						
					}
					} }%>
					
	</table>
	</table></td></tr></table>

</BODY>

</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
