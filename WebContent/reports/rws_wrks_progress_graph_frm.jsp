<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<% try {


	ResultSet rs1=null,rs3=null,rs4=null;
    Statement stmt1=null,stmt4=null,stmt3=null;
    String query = null,query1=null,query3=null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
    String programe="",nextyr="";
	String[] program=request.getParameterValues("program");
	ArrayList aa = new ArrayList();
		//System.out.println("ppppppppppp"+request.getParameterValues("program"));
if(request.getParameterValues("program")!=null)
{
  for(int i=0;i<program.length;i++)
{
programe += program[i]+",";
aa.add(program[i]);
}
//System.out.println("programe::"+programe);
programe = programe.substring(0,programe.length()-1);
//System.out.println("programe::"+programe);
if(programe!=null)
{
session.setAttribute("programe",programe);
}
} %>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="0")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}
function fnSubmit()
{

     if(document.f1.chart.selectedIndex=="")
	{
	
		alert("SELECT TYPE OF GRAPH...");		
		return false;
	}
	if(document.f1.district.selectedIndex=="")
	{
	
		alert("SELECT DISTRICT...");		
		return false;
	}
   if(document.f1.program.value=='')
	{
		alert("Please Select program");
		return false;
	}
       else
	{
		document.f1.prgname.value = document.f1.program.options[document.f1.program.selectedIndex].text;                   
        document.f1.action="./rws_wrks_progress_graph_rpt.jsp";
        document.f1.submit();
	}
		
		
}
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">

<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Work Status Progress Graph</font>
                
			</td>	
		</tr>


<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Tchart = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String dCode=null;
	String mCode=null;
	String pCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;	
	
%>
<TR> 
	<TD   valign=top  align="center" height="35%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>

	<td class = btext nowrap><font color="navy"><b>Type of Chart</b></font>
	<font color="red">*</font></td>
	<td class = btext colspan=3>
	<SELECT name="chart" style="width:150px" class="mycombo">
		<option value="0">SELECT...</option>
		
<%
	Tchart = request.getParameter("chart");
	//System.out.println("Type of chart is   "   +Tchart);
	
	if(Tchart != null && !Tchart.equals("0"))
		{ System.out.println("Type of chart is 111111111111  "   +Tchart);
		if(Tchart.equals("p"))
			{
				//System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Pie</option>
					<option value="b">Bar</option>		
					<option value="l">Horizantal Bar</option>
					<option value="d">Area</option>

			<%} else if(Tchart.equals("b"))
			{
				//System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Bar </option>
					<option value="p">Pie </option>
					<option value="l">Horizantal Bar</option>
					<option value="d">Area</option>

			<%} else if(Tchart.equals("l"))
			{
				//System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Horizantal Bar </option>
					<option value="p">Pie </option>
					<option value="b">Bar</option>		
					<option value="d">Area</option>


			<%} else if(Tchart.equals("d"))
			{
				//System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Area </option>
					<option value="p">Pie </option>
					<option value="b">Bar</option>		
					<option value="l">Horizantal Bar</option>
		
			<%} 
		}
		else
		{
            System.out.println("Type of chart is 3333333333333  "   +Tchart);

           %>
			<option value="p">Pie </option>
			<option value="b">Bar</option>		
			<option value="l">Horizantal Bar</option>
			<option value="d">Area</option>

		<%}%>
	
</SELECT></td>

</tr>
<tr>
		<% 
	rDist = request.getParameter("district");
	//out.println("Rdist   "   +rDist);
	if(rDist==null || rDist.equals("0"))
	{
	%>
		<td class = btext ><font color=navy><b>District</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="district" id="circ1" style="width:150px" class="mycombo" onchange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	else if(rDist != null && rDist.equals("51"))
	{%>
	<td class = btext><font color=navy><b>District</b> </font>
	<font color="red"><b>*</b></font></td>
	<td class = btext colspan=3><SELECT name="district" id="circ1" style="width:150px" class="mycombo" onchange="this.form.submit()">
	<option value="0">SELECT...</option>
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",rDist);

		
	} 
	else if(!rDist.equals("0"))  
	{
	%>
	 <td class = btext><font color=navy><b>District</b> </font>
	 <font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" id="circ1" style="width:150px" class="mycombo" onchange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dcode,d.dname");
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
	<% 			
			session.setAttribute("dName",rs.getString(2));
			session.setAttribute("dCode",rDist);


		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
		//session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
    int yy=0;
	%>
	
	
   <tr><td class=rptLabel>Select Programme&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>

			<SELECT name="program" id="combo"  style="width:150px"  class="hightlongcombo">
			<option value="">SELECT</option>
			<%//System.out.println("program:sssssssss"+request.getParameter("program"));
			if(request.getParameter("program")!=null && request.getParameter("program").equals(Constants.NRDWP_RELATED))
			{%>
			<option value=<%=Constants.NRDWP_RELATED %> selected >NRDWP Related</option>
			<%}else{%>
			<option value=<%=Constants.NRDWP_RELATED %> >NRDWP Related</option>
			<%}%>
			<%
                       
			stmt3 = conn.createStatement();
			query3="select * from  rws_programme_tbl  where programme_code not in("+Constants.NRDWP_RELATED+") order by 1";
			rs3 = stmt3.executeQuery(query3);
			while(rs3.next())
			{
			    if(aa.contains(rs3.getString(1)))
			{
			%>
			 <option value="<%=rs3.getString(1)%>" selected><%=rs3.getString(2)%></option> 
			<%
			}
			else
			{
			%>
			  <option value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option> 
			<%
			}
			}
			rs3.close();			
			stmt3.close();
			%></select>
			</td>

</tr> 

<% }
	catch(Exception e)
		{
			e.printStackTrace();
        }
%>
</table>

</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	
	//if(rDist!=null && !rDist.equals("0"))

		//{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id ="circ" onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<INPUT type="hidden" name="prgname">	
</TD></TR>
</TABLE>
<%} catch(Exception e){	
			//System.out.println("Error is  "+e);
			//response.sendRedirect("./ErrorPage.jsp");
			}
	finally
	{
		conn.close();
	}
%>
<p>
<table>
<tr>
<td><font color="red">Note&nbsp;:&nbsp;&nbsp;&nbsp;Scheme Considered&nbsp;-&nbsp;CPWS</font></td>
</tr>
</table>
</p>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>