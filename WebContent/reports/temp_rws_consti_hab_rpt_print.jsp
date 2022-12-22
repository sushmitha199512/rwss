<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@page import="java.sql.*" %>
<%@	taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<%		
//java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	int start,end,limit =20,j,slno=0,pgcnt,pgno=0,rowno,LNO=0;
	int line=0;	
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	String st=request.getParameter("start");
	ArrayList labelcol2 = (ArrayList)session.getAttribute("arrayLabel");
	Iterator label1 = labelcol2.iterator();
	int cnty=labelcol2.size();
	////System.out.println("name of  count is  "+cnty);
	String labelNames[]=null;
	String record[]=null;
	labelNames =(String[]) label1.next();
	////System.out.println("lebal are  count  "+labelNames.length);
	ArrayList mList1 = (ArrayList)session.getAttribute("arrayList");
	Iterator iterator = mList1.iterator();
	int mylists1=mList1.size();
	////System.out.println("VVVVVVVVVV    "+mylists1);
	if(request.getParameter("start") !=  null) 
		{
			start = Integer.parseInt(request.getParameter("start"));
			////System.out.println("start is    "+start);

		}
		else
		{
			start = 0;
	
		}
		end = start + limit;
		////System.out.println("end value is   "+end);
		if(request.getParameter("pgcnt") !=  null) {
			pgcnt = Integer.parseInt(request.getParameter("pgcnt"));
			////System.out.println("pgcnt is     "+pgcnt);

		}
		else
		{
			pgcnt = 1;
			////System.out.println("pgcnt is    "+pgcnt);	
		}
	

String FDATE = String.valueOf(session.getAttribute("fdate"));
	String TDATE = String.valueOf(session.getAttribute("tdate"));
	
 %>
 <html>
<head>
<title>WaterSoft</title>

<!-- <link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css"> -->
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font><br>
<br>
<table align="center" width="100%">
	<tr>
		<td align="center" class="mystyle1"><font color="navy"><h5>Constituency wise Habitation  Status  Report</h3></font></td>
	</tr>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
.btest1
{
	border-width:1;
	color:black;
	font-weight:bold;
	font-family:verdana;
	font-size:7pt;
}

</style>

</head>
<body><%	//out.println(query);%>
		<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
		<tr>
			<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("constiName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Constituency: <%=session.getAttribute("constiName") %></font></td>
<%}if(!FDATE.equals("null") && !FDATE.equals("0") && !TDATE.equals("null") && !TDATE.equals("0"))
	{%>
<tr >
		<td class="textborder" align="center">
				<font size=2>Status Dates Between: </font><font color=#F2A80D> <%=FDATE %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= TDATE %></font></td>
	</tr>
	<% }%>
</table>
<br>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" rules="cols">	
	<tr >
		<td rowspan=3 class = btest1>S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		<% if(session.getAttribute("dName")==null){ %>
		<td rowspan=3 class = btest1>District Name</td> <% } %>

		<!-- <td class="mystyle">Mandal Name</td>	 -->
		<% if(session.getAttribute("mName")==null){ %>
		<td rowspan=3 class = btest1>Mandal Name</td> <% } %>

		<!-- <td class="mystyle">Panchayat Name</td> -->
		<% if(session.getAttribute("pName")==null){ %>
		<td rowspan=3 class = btest1>Panchayat Name</td> <% } %>

		<td rowspan=3 class = btest1>Habitation Name</td>

		<%
			for(j=4; j<labelNames.length;j++ )
			{
				if(j<=9)
				{
			%>
				<td class = btest1><%= labelNames[j] %></td>
			<%
				} 
			}%>
			</tr>
			<tr> 
			<c:forEach begin="1" end="6">
				<td><hr size=1 color=black ></td>
			</c:forEach>	
			</tr>
			<tr>
			<%		
			for(j=9; j<labelNames.length;j++ ) {
			if(j>9){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td class = btest1><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
	</tr>	
	<tr> 
	
	<c:forEach  begin="1" end="10">
		
		<td><hr size=1 color=black ></td>
	</c:forEach>
	
	
	
	</tr>
			
<%
	try
	{		
		
		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";
		LNO=6;
		for(int z = start,sno=start+1; z<mylists1; z++,sno++)
		{	
			//System.out.println("VaLN O IS "+LNO);

			
			if(mylists1>z && LNO<=50)
			{		
				String[] record1 =(String[])mList1.get(z);		
				////System.out.println("valiue of   "+record1.length);
				String distcode=record1[0];
				String mandcode=record1[1];
				String panchcode=record1[2];

				slno++;
				if(temp.equals(distcode))
				{
					if(temp1.equals(mandcode))
					{
						if(temp2.equals(panchcode))
						{
		%>					<tr align=left bgcolor="#ffffff">
								<td class="mystyle1"><%= sno%></td>
								<!-- <td class="mystyle1"></td> -->
								<% if(session.getAttribute("dName")==null){ %>
								<td class="mystyle1"> </td> <% } %>

								<!-- <td class="mystyle1"></td> -->
								<% if(session.getAttribute("mName")==null){ // //System.out.println("888888888888888888"); %>
								<td class="mystyle1"> </td> <% } %>

							<!-- 	<td class="mystyle1"></td> -->
					<% if(session.getAttribute("pName")==null){ // //System.out.println("888888888888888888"); %>
		<td class="mystyle1"> </td> <% } %>
			
					<td class="mystyle1"><%=record1[3]%></td>
					<%		
						for(int k=4; k<labelNames.length;k++){
							if(k<=9){
								if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==10){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>9){ if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
		}
			if(k==labelNames.length && k>9){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

			}
				else
				{	temp=record1[0];
					temp1=record1[1];
					temp2=record1[2];
%>
					<tr align=left bgcolor="#ffffff">
					<td class="mystyle1"><%= sno%></td>
					<!-- <td class="mystyle1"></td> -->
					 <% if(session.getAttribute("dName")==null){ %>
					<td class="mystyle1"> </td> <% } %>

					<!-- <td class="mystyle1"></td> -->
					<% if(session.getAttribute("mName")==null){ // //System.out.println("999999999999");%>
					<td class="mystyle1"> </td> <% } %>


					<% if(session.getAttribute("pName")==null){  %>
		<td class="mystyle1"><%=record1[2]%> </td> <% } %>
					<td class="mystyle1"><%=record1[3]%></td>
					
					<% 
						for(int k=4;k<labelNames.length;k++){
							if(k<=9){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==10){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>9)
				{if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}	}
			if(k==labelNames.length && k>9){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

				}
			}
			else
			{
					temp=record1[0];  
					temp1=record1[1];
					temp2=record1[2];
		%>
			<tr align=left bgcolor="#ffffff">
				<td class="mystyle1"><%= sno%></td>
				<!-- <td class="mystyle1"></td> -->
			
				 <c:if test="${sessionScope.dName==null}">
					<td class="mystyle1"> </td> 
				</c:if>
				

				<c:if test="${sessionScope.mName==null}">
				 		<td class="mystyle1"><%= record1[1]%> </td> 
				</c:if>
				
				 <c:if test="$(sessionScope.pName==null}">
					<td class="mystyle1"><%= record1[2]%> </td> 
				 </c:if>
				
				<td class="mystyle1"><%=record1[3]%></td>
					<% 

						 for(int k=4;k<labelNames.length;k++)
						{
							if(k<=9){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}} 

						 else if(k==10){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			if(k<labelNames.length && k>9){if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
		}
			if(k==labelNames.length && k>9){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
}

}
	
		}
		else
		{
					temp=record1[0];
					temp1=record1[1];
					temp2=record1[2];
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%= sno%></td>

			<% if(session.getAttribute("dName")==null){ %>
		<td class="mystyle1"> <%=record1[0]%> </td> <% } %>


<% if(session.getAttribute("mName")==null){ %>
		<td class="mystyle1"> <%=record1[1]%> </td> <% } %>


<% if(session.getAttribute("pName")==null){ %>
		<td class="mystyle1"> <%=record1[2]%> </td> <% } %>

			<td class="mystyle1"><%=record1[3]%></td>
				<% 			
						for(int k=4;k<labelNames.length;k++){
							if(k<=9){
								if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
	
						<%}
									}

						 else if(k==10){	%>
					</tr>
				<tr>
			<% if(session.getAttribute("mName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}	
			else if(session.getAttribute("pName")==null){%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			else
			{%>
			<td class="mystyle1"></td>
			<td class="mystyle1"></td>
			<%}
			}  
			 if(k<labelNames.length && k>9){
			 
			 if(record1[k]!=null)
								{%>
						<td class="mystyle1"><%=record1[k]%></td>
						<%} else { %>
						<td class="mystyle1"><%="--"%></td>
						<%}
			
			} if(k==labelNames.length && k>9){ %>
						<tr>
						<td colspan=10 class="mystyle1"><%= "_"%></td></tr>
						<%}
			 
}%>

</tr>
<%	}
		if(j>10)
				LNO=LNO+2;
		else
				LNO++;
			}	 
				 
			else{
				rowno=0;
				LNO=6;
				z--; sno--;
				////System.out.println("Valie os Z ias "+z);
				%>
<table align=center>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>

</table>
</TABLE>
	<p style="page-break-before:always">
	
<table align="center" width="100%">
	<tr>
		<td align="center" class="mystyle1"><font color="navy"><h5>Constituency wise Habitation  Status  Report</h3></font></td>
	</tr>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
	
	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align=center>	
		<tr>
		<td align="center" class="mystyle1" ><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	<%  
		
	%>
<% if(session.getAttribute("mName")!=null){
		
	%>
<td  align="center"  class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){
		
		%>
<td  align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("constiName")!=null){
		
			%>
<td align="center" class="mystyle1"><font color="navy">Constituency: <%=session.getAttribute("constiName") %></font></td>
<%}%>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" rules="cols">
	<tr>
		<td rowspan=3 class = btest1  >S.No</td>
		<!-- <td class="mystyle">District Name</td> -->
		<% if(session.getAttribute("dName")==null){ %>
		<td rowspan=3 class = btest1  >District Name</td  > <% } %>

		<!-- <td class="mystyle">Mandal Name</td>	 -->
		<% if(session.getAttribute("mName")==null){ %>
		<td rowspan=3 class = btest1  >Mandal Name</td> <% } %>

		<!-- <td class="mystyle">Panchayat Name</td> -->
		<% if(session.getAttribute("pName")==null){ %>
		<td rowspan=3 class = btest1  >Panchayat Name</td> <% } %>

		<td rowspan=3 class = btest1  >Habitation Name</td>

		<%
			for(j=4; j<labelNames.length;j++ )
			{
				if(j<=9)
				{
			%>
				<td class = btest1><%= labelNames[j] %></td>
			<%
				} 
			}%>
			</tr>
			<tr> 
			<c:forEach begin="1" end="6">
				<td><hr size=1 color=black ></td>
			</c:forEach>	
			</tr>
			
			<tr>
			<%		
			for(j=9; j<labelNames.length;j++ ) {
			if(j>9){
				//  //System.out.println("get columb lables are  "+rsm.getColumnLabel(j));
			
				%>
				<td class = btest1><%= labelNames[j] %></td>
	<%
			} 	 } %>
		
	<tr> 
			<c:forEach begin="1" end="10">
				<td><hr size=1 color=black ></td>
			</c:forEach>	
			</tr>
			<tr>
			</p>
				<%
		
			}

			
				
	}
	}
	catch(Exception ee)
	{
	//System.out.println("sadiq The error is="+ee);
	}
finally
{
	
	}
%>
</table>

</TD></TR>

<table align=center>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>
</TABLE>
</P>
</body>
</html>
