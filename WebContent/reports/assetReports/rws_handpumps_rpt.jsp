<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%@ include file="/reports/conn.jsp" %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>

<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>

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

districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");

districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String panchcode="";
panchcode=request.getParameter("panchcode");
String typeassetcode="";
typeassetcode=request.getParameter("typeassetcode");
String hpcode=request.getParameter("hpcode");
String panchname=request.getParameter("panchname");
ResultSet results=null;
String water="";



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
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%>&nbsp;Habitation:<%=panchname%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Assets - HANDPUMPS </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
<td class=btext>Sl.No</td>

						<td class=btext >Pump Code  </td>
						<td class=btext >Location </td>
						<td class=btext >Diameter(mm) </td>
						<td class=btext >Depth(Mts)  </td>
						<td class=btext >Casing(Type)  </td>
					 	<td class=btext >No of GI Pipes  </td>
						<td class=btext >General Condition  </td>
						<td class=btext >Static Water Level(Mts)  </td>
						<td class=btext >Summer Water Level(Mts)(From Ground) </td>
						<td class=btext >No Of Hours Serving per day  </td>
						<td class=btext >No Of Households Served   </td>
						<td class=btext >HP No Painted   </td>
					    
					    <td class=btext >Platform Condition   </td>
					    <td class=btext >Drain  </td>
						<td class=btext >Drain Condition </td>
						<td class=btext >Drain Connected to Side Drains </td>
						<td class=btext >Leach pit    </td>
						<td class=btext >Hygiene    </td>
						<td class=btext >Present Yield (as per Local Enquiry) </td>
					    <td class=btext >Yield(l.p.m)  </td>
					    <td class=btext >Repairs Per Year   </td>
					    <td class=btext >Water Quality  </td>
					    </tr>


<%

try
{

	 
	//String handpumpquery="select  nvl(location,'-'),,nvl(casing,'-'),nvl(gen_condition,'-'),nvl(gi_no,0),nvl(painted,'-'),nvl(static_wl,0),nvl(summer_wl,0),nvl(p_cond,'-'),nvl(dry_during,0),nvl(service,'-'),nvl(ser_no,0),nvl(ser_hrs,0),nvl(repairs,'-'),nvl(platform_condition,'-'),nvl(drain,'-'),nvl(drain_condition,'-'),nvl(drain_sd,'-'),nvl(drain_lp,'-'),nvl(hygiene,'-'),nvl(avg_time,0),nvl(p_yeild,0),nvl(pyeild_local,'-'),nvl(period,'-'),nvl(depth,'0'),hp_code,nvl(quality_affected,'-'),nvl(flouride,0),nvl(brakish,0),nvl(iron,0),nvl(others_specify_type,'-'),nvl(cont_others_type,'-'),nvl(cont_others_per,'0'),drill_year from rws_hp_subcomp_param_tbl  where  asset_code='"+assetcode+"'  ";
	
	String query="SELECT subCompTbl.HP_CODE,subCompTbl.LOCATION,subCompTbl.DRILL_YEAR,subCompTbl.DIAMETER,subCompTbl.CASING,DECODE (subCompTbl.STATUS,'W','WORKING','N','NOT WORKING') AS STATUS,DECODE (subCompTbl.GEN_CONDITION,'G','GOOD','B','BAD') AS GEN_CONDITION,GI_NO,DECODE(subCompTbl.PAINTED,'Y','YES','N','NO') AS PAINTED,STATIC_WL,SUMMER_WL,NVL(DEPTH,'0.0') AS DEPTH,NVL(SER_HRS,'0') AS SER_HRS,nvl(SER_NO,'0') as SER_NO,decode(subCompTbl.PAINTED ,'Y','YES','N','NO')painted,DECODE (subCompTbl.PLATFORM_CONDITION,'G','GOOD','B','BAD') AS PLATFORM_CONDITION,DECODE (subCompTbl.DRAIN,'E','EXISTING','N','NOT EXISTING') AS DRAIN,DECODE (subCompTbl.DRAIN_CONDITION,'G','GOOD','B','BAD') AS DRAIN_CONDITION,DECODE (subCompTbl.DRAIN_SD,'Y','YES','N','NO') AS DRAIN_SD,nvl(DECODE (subCompTbl.DRAIN_LP,'Y','YES','N','NO'),'-') AS DRAIN_LP,DECODE (subCompTbl.HYGIENE,'G','GOOD','B','BAD') AS HYGIENE,nvl (PYEILD_LOCAL,'-') as PYEILD_LOCAL,nvl(P_YEILD,0) as P_YEILD,nvl(REPAIRS,'-') as REPAIRS,subCompTbl.QUALITY_AFFECTED  FROM  RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE  subCompTbl.asset_code='"+assetcode+"' ";
	String drain1="";
	
	

   
		stmt1=conn.createStatement();
 


		results=stmt1.executeQuery(query);
		

		


	 
 
 

		while(results.next())
    	{
    	if(results.getString("quality_affected")!= null && results.getString("quality_affected").equals("Y"))
    	{
    	water="NSS";
    	}
    	else
    	{
    	water="SAFESOURCE";
    	}
    	%>
    	 <tr>
	<td class="mystyle1"><%=sno++%></td>
	
	<td class="mystyle1"><%=results.getString("HP_CODE")%></td>
	<td class="mystyle1"><%=results.getString("LOCATION")%></td>
	<td class="mystyle1"><%=isNull1(results.getInt("DIAMETER"))%></td>
	<td class="mystyle1"><%=isNull1(results.getInt("DEPTH"))%></td>
	<td class="mystyle1"><%=results.getString("CASING")%></td> 
	<td class="mystyle1"><%=isNull1(results.getInt("GI_NO"))%></td> 
	<td class="mystyle1"><%=results.getString("GEN_CONDITION")%></td> 
	<td class="mystyle1"><%=isNull1(results.getInt("STATIC_WL"))%></td> 
	<td class="mystyle1"><%=isNull1(results.getInt("SUMMER_WL"))%></td> 
	<td class="mystyle1"><%=isNull1(results.getInt("SER_HRS"))%></td> 
	<td class="mystyle1"><%=isNull1(results.getInt("SER_NO"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("PAINTED"))%></td> 
	
	<td class="mystyle1"><%=isNull(results.getString("PLATFORM_CONDITION"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("DRAIN"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("DRAIN_CONDITION"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("DRAIN_SD"))%></td>
	<td class="mystyle1"><%=isNull(results.getString("DRAIN_LP"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("HYGIENE"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("PYEILD_LOCAL"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("P_YEILD"))%></td> 
	<td class="mystyle1"><%=isNull(results.getString("REPAIRS"))%></td>
	<td class="mystyle1"><%=water%></td>
	 </tr>

		

		

			
			
 

				
				


<%


			
			
			
		}
		
		
				

 	
}
catch(Exception e)
{
	//out.println("Exception"+e);
	e.printStackTrace();
	//throw new ServletException(e);
	
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

</html>
