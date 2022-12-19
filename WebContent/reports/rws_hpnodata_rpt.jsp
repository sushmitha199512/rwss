<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>


<%@ include file="conn.jsp" %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>



<html>
<head>
<title>Graphs</title>
<script language="JavaScript">
</script>
<style>
.mystyle
{
	background-color:silver;
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:7pt;
}

.mytext
{
	height:19px;
	font-size:9px;
	
}
.mytbltext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	width:90pt;
	font-family:verdana;
}
.mynobordertext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	font-family:verdana;
	background-color:#DEE3E0
}

.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
.clrborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:8pt;
	color:#993366;
}
.bwborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
}
.textborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	font-weight:bold;
	color:#000000;
}
.mycborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:5pt;
}
.mycborder1
{
	padding:0;
	height:15px;
	font-family:verdana;

	font-size:5pt;
	
}

.mycombo

{
	height:14px;
	border-width:0;
	font-size:9pt;
	font-family:verdana;
}
.mytext2
{
	height:14px;
	border-width:0;
	border-style:none;
	font:menu;
}
.myfontclr
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	font-weight:bold;
}
.thead
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:9pt;
	color:#ffffff;
}
.myfontclr1
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	
	
}
.loginStyle
{
font-family:verdana;
font-width:9pt;
border-width:0;
background-color:#DEE3E0;
color:#6600FF;
font-weight:bold
}
.head
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:10pt;
	color:#000000;
}

.rptHeading
{
	border-width:1;
	color:navy;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.rptLabel
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:navy;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt	
}
.rptValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:#000000;	
}

.rptSubValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:brown;
	font-weight:bold;
}

.prptHeading
{
	border-width:1;
	color:black;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.prptLabel
{
	border-width:1;
	border-color:#000000;
	color:black;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}

.dateFont
{
	color:black;
	font-family:verdana;
	font-size:8pt;
}
A:link{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:visited{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:hover{font-family:verdana;font-size:8pt;text-decoration:underline;color:#316A95}



</style>



</head>
<body>
<form>

<%
String adCode=String.valueOf(session.getAttribute("dCode"));

//String fdate=String.valueOf(session.getAttribute("FDATE"));

//String dname=String.valueOf(session.getAttribute("dName"));


String dcode = request.getParameter("district");
int tot=0;
int total=0;
Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt12=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs12=null;


int hpcount=0;
int ghpcount=0;
int hpcount1=0;
int ghpcount1=0;
int sno=1;
String dname="";
String assethptype="";

try
{
	String query6="select dname from rws_district_tbl where dcode='"+dcode+"'";
stmt6=conn.createStatement();
				rs6=stmt6.executeQuery(query6);
				while(rs6.next())
	{
dname=rs6.getString(1);
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		if(rs6!=null)
		{
			rs6.close();
		}
		if(stmt6!=null)
		{
			stmt6.close();
		}
	}
	catch(Exception o)
	{
		o.printStackTrace();
	}
}


%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
	<%
	if(dcode.equals("51"))
	{
	%>
		<td class=rptValue colspan=14><font color="navy">District:ALL </td>
		<%}
	else if(!dcode.equals("51"))
	{
		%>
		<td class=rptValue colspan=14><font color="navy">District:<%=dname%> </td>
		<%
	}
		%>


	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Assets Handpumps - With out Borewells Details Report </td>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center"><tr align=center>

	
               <td class=btext>Sl.No</td>
               <td class=btext>District</td>
			   <td class=btext>Handpumps No.</td>
			   <td class=btext>Handpumps - With out Borewells Details </td>
			   





			  
                
                
			  
               
   			   
			   </tr>
			   


<%



try
{
	String query = "";
	 if(dcode.equals("51"))
		query="select dcode,dname from rws_district_tbl where dcode<>'16' order by dname";
	else 
		query="select dcode,dname from rws_district_tbl where dcode='"+dcode+"' order by dname";
					

		
		
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query);
		
		
    	while(rs1.next())
	{     
		
		
			
		
		
		 String query4="select count(*) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view r where r.panch_code=a.hab_code and type_of_asset_code='04' and   r.dcode='"+rs1.getString(1)+"' and a.asset_code=b.asset_code"; 
		  
         
		  stmt3=conn.createStatement();
		  stmt7=conn.createStatement();
		 	rs3=stmt3.executeQuery(query4);
			hpcount=0;
		 while(rs3.next())
		{
			 hpcount=rs3.getInt(1);
			// assethptype=rs3.getString(2);

			
			 
			}
			ghpcount=ghpcount+hpcount;
			String query6="select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view s where s.panch_code=a.hab_code and  s.dcode='"+rs1.getString(1)+"' and type_of_asset_code='04' and a.asset_code=b.asset_code   MINUS select a.asset_code from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view p where p.panch_code=a.hab_code and s.asset_code=a.asset_code and p.dcode='"+rs1.getString(1)+"' and type_of_asset_code='04'  and a.asset_code=b.asset_code  ";
			query6 = "select count(*) from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view r,rws_hp_subcomp_param_tbl hp where hp.asset_code=a.asset_code and r.panch_code=a.hab_code and type_of_asset_code='04' and   r.dcode='"+rs1.getString(1)+"' and a.asset_code=b.asset_code";
			rs7=stmt7.executeQuery(query6);
			hpcount1=0;
		if(rs7.next())
		{
			hpcount1 = rs7.getInt(1);
		}
		hpcount1 = hpcount -hpcount1; 
		ghpcount1=hpcount1+ghpcount1;
		
	

		
			
	
	     	
						%>
						
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue align="right"><%=hpcount%></td>
				<td class=rptValue align="right"><a href="rws_borewell_nodetails_rpt.jsp?district=<%=rs1.getString(1)%>&hpassettype=04" ><%=hpcount1%></a></td>
		
               				
				</tr>
<%
	
	}

	%>
	<tr>
	<td colspan=2  align="right" class="btext">Total:</td>
	<td class="btext" align="right"><%=ghpcount%></td>
    <td class="btext" align="right"><%=ghpcount1%></td>
    
	
	


	</tr>
	<%

}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
try
{
	
	if(rs3!=null)
	{
		rs3.close();
	}
	if(stmt3!=null)
	{
		stmt3.close();
	}
	
	if(rs7!=null )
	{
     rs7.close();
	}
	if(stmt7!=null)
	{
		stmt7.close();
	}
	
if(rs1!=null)
{
rs1.close();
}
if(stmt1!=null)
{
stmt1.close();
}
if(conn != null)
	{
	conn.close();
	}
}
catch(Exception o)
{
o.printStackTrace();
}
}




%>
</table>
</form>

</body>


<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</p>
</html>
