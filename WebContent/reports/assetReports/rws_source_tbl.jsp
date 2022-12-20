<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>



<%@ include file="/reports/conn.jsp" %>

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


int psno=0;
int tot=0;
int total=0;
Statement stmt1=null;
ResultSet rs1=null;

String pname="";
String vname="";

String typeassetname="";
typeassetname=request.getParameter("typeassetname");
String assetcode="";
assetcode=request.getParameter("assetcode");
int sno=1;
String districtcode="";
String mandalcode="";
String panchayatcode="";
String villagecode="";
String mandalname="";
String districtname="";
String panchayatname="";
String villagename="";
String sourcetypecode="";
sourcetypecode=request.getParameter("sourcetypecode");

districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");

districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String habcode="";
habcode=request.getParameter("habcode");
String typeassetcode="";
typeassetcode=request.getParameter("typeassetcode");
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
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Assets - SOURCES </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">


<%

try
{
	
//	String qury="select source_code,nvl(source_name,'-'),NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "' and substr(source_code,1,2)='" + districtcode + "' and substr(source_code,6,2)='" + mandalcode + "' and substr(source_code,13,2)='" + panchayatcode + "' and substr(source_code,8,3)='" + villagecode + "'   and source_type_code='" + sourcetypecode + "' "; 
	//String query="select source_code,nvl(source_name,'-'),NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "' and  source_type_code='" + sourcetypecode + "' "; 
	String query1="select source_code,source_name,decode(source_type_code,'1','Sub Surface Source','2','Surface Source') sourcetypecode,decode(SUBSOURCE_TYPE_CODE,'1','Canal','2','River','3','Openwell','4','Reservoir','5','InFiltration Well')subsourcetypecode ,nvl(location,'-'),decode(source_condition,'Yielding uniformly round the year','Yielding uniformly round the year','Seasonal','Seasonal')sourcecondition,nvl(static_water_level,0),nvl(yield,'-'),nvl(depth,0),nvl(dist_near_private_source,0),decode(water_quality,'SS','SafeSource','NSS','NSS')waterquality from rws_source_tbl where asset_code='"+assetcode+"' and source_type_code='"+sourcetypecode+"'";
	//String query=" select source_code,decode(source_type_code,source_name,location,source_condition,static_water_level,yield,dist_near_private_source,decode(water_quality,'SS','SafeSource','NSS','NSS')waterquality from rws_source_tbl where asset_code='"+assetcode+"' and source_type_code='"+sourcetypecode+"'";
 if(sourcetypecode.equals("2"))
		{
		%>
		<tr align=center>
		
               <td class=btext>Sl.No</td>
			   <td class=btext>Source code</td>
			   <td class=btext>Source Name</td>
			   <td class=btext>Source Type</td>
			   <td class=btext>Sub Source Type</td>
			   <td class=btext>Location</td>
			   <td class=btext>Source Condition</td>
			   
			   <td class=btext>Static Water Level From<br>
			   	    Ground(Avg)(in Mts)</td>
			   
			   <td class=btext>Yield</td>
			   <td class=btext>Source Depth(mts)</td>
			   <td class=btext>Alternative Water Source</td>
			   <td class=btext>Water Quality</td>
			   </tr>
		
		<%
		   	
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query1);
		while(rs1.next())
    	{
    	            
		        	
 
		
    	


	     				%>
                <tr bgcolor="#ffffff">
                
                
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString("source_code")%></td>
				<td class=rptValue><%=isNull(rs1.getString("source_name"))%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=isNull(rs1.getString(5))%></td>
				<td class=rptValue><%=isNull(rs1.getString(6))%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(9))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(10))%></td>
				<td class=rptValue><%=isNull(rs1.getString(11))%></td>
				
				</tr>				</tr>

					

<%


			
			
			
		}
		}
				

	  	if(sourcetypecode.equals("1"))
		{
		//   		String srctype=" select source_code,nvl(source_name,'-'),NO_OF_HABITAITONS_COVERD ,population_benifited,nvl(seasonal,'-'),nvl(water_quality,'-'),static_water_level,summer_water_level,nvl(yield,'-'),		dist_near_private_source,nvl(location,'-'),depth,diameter,nvl(source_condition,'-'),nvl(type,'-'),substr(source_code,17,3) from rws_source_tbl where asset_code='" + assetcode + "' and substr(source_code,1,2)='" + districtcode + "' and substr(source_code,6,2)='" + mandalcode + "' and substr(source_code,13,2)='" + panchayatcode + "' and substr(source_code,8,3)='" + villagecode + "'   and source_type_code='" + sourcetypecode + "' ";
String query2="select source_code,decode(source_type_code,'1','SubSurface Source','2','Surface Source')sourcetypecode,decode(subsource_type_code,'1','Borewell','2','filter point','3','infiltraton well','4','open well')subsourcecode,nvl(location,'-'),decode(source_condition,'Yielding uniformly round the year','Yielding uniformly round the year','Seasonal','Seasonal','Silted up','Silted up','Dried up','Dried up')sourcecondition,nvl(static_water_level,0),nvl(yield,'-'),nvl(depth,0),nvl(dist_near_private_source,0),decode(water_quality,'SS','Safe Source','NSS','NSS')waterquality from rws_source_tbl where asset_code='"+assetcode+"' and source_type_code='"+sourcetypecode+"'";

   		
   		%>
   		<tr align=center>
		
               <td class=btext>Sl.No</td>
			   <td class=btext>Source code</td>
			   
			   <td class=btext>Source Type</td>
			   <td class=btext>Sub Source Type</td>
			   <td class=btext>Location</td>
			   <td class=btext>Source Condition</td>
			   
			   <td class=btext>Static Water Level From<br>
			    Ground(Avg)( in Mts )</td>
			   
			   <td class=btext>Yield</td>
			   <td class=btext>Source Depth(mts)</td>
			   <td class=btext>Alternative Water Source</td>
			   <td class=btext>Water Quality</td>
			   </tr>
			   <%
		
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query2);
		while(rs1.next())
    	{
    	
    	
			
				%>
				 <tr bgcolor="#ffffff">
                
                
				<td class=rptValue><%=sno++%></td>
                <td class=rptValue><%=rs1.getString("source_code")%></td>
				
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getString(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=isNull(rs1.getString(5))%></td>
				<td class=rptValue><%=rs1.getString(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(8))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(9))%></td>
				<td class=rptValue><%=isNull(rs1.getString(10))%></td>
				
				</tr>
				<%
}
}
}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
try
{
if(rs1!=null)
{
rs1.close();
}
if(stmt1!=null)
{
stmt1.close();
}
conn.close();
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
