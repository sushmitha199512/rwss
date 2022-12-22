
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>


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






String district = String.valueOf(session.getAttribute("district"));


int tot=0;
int total=0;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;

String pname="";
String vname="";
int ftk=0;
int gtot=0;
int gtotftk=0;
String cir="";
int pwscount=0;
int cpwscount=0;
int gpwscount=0;
int gcpwscount=0;
int pwshabcount=0;
int gpwshabcount=0;
int cpwshabcount=0;
int gcpwshabcount=0;
String dname="";
int mpwscount=0;
int gmpwscount=0;
int directpumpcount=0;
int gdirectpumpcount=0;;
int mpwshabcount=0;
int gmpwshabcount=0;
int directpumphabcount=0;
int gdirectpumphabcount=0;
int hpcount=0;
int ghpcount=0;
String mname="";

String assettype="";
String assetcode="";
String mandalcode="";
String mandal=String.valueOf(session.getAttribute("mandal"));


 assettype=String.valueOf(session.getAttribute("assettype"));

String mandalname=String.valueOf(session.getAttribute("mandalname"));


int count=0;




int sno=1;
try
{
	String query6="select dname from rws_district_tbl where dcode='"+district+"'";
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
	<tr bgcolor="#edf2f8" align="center">
	
	
		<td class=rptValue colspan=14><font color="navy">District:<%=dname%>&nbsp;&nbsp;&nbsp;Mandal:<%=mandalname%> </td>
	


	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Assets Handpumps - With No Borewell Details Report</td>
</tr>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center"><tr align=center>
<tr align=center>
	
                <td class=btext>Sl.No</td>
			   
               <td class=btext>Asset Name</td>
               <td class=btext>Location</td>
			   <td class=btext>Date Of Creation</td>
               <td class=btext>Asset Status</td>
               <td class=btext>Asset Cost (Rs. In Lakhs)</td>   
               <td class=btext>Habitation Code</td>  
			   <td class=btext>Habitation Name</td>  
			   <td class=btext>Asset Code</td>     
			   
			   
			    
                
			  
               
   			   
			   </tr>


<%



try
{
			
    	
		
			
		
		
		 
		// String query44="select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where  a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' MINUS select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,rws_hp_subcomp_param_tbl d where   a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and a.asset_code=d.asset_code ";
			 	    
		
			 //	String query66="select A.ASSET_CODE,m.mname from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,rws_mandal_tbl m where c.mcode=m.mcode and a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and a.asset_code='"+assetcode+"' ";
		   
			
			stmt2=conn.createStatement();
			stmt3=conn.createStatement();
			
			String query22="select a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view s where s.panch_code=a.hab_code and  s.dcode='"+district+"' and type_of_asset_code='04' and a.asset_code=b.asset_code and s.mcode='"+mandal+"'  MINUS select a.asset_code from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view p where p.panch_code=a.hab_code and s.asset_code=a.asset_code and p.dcode='"+district+"' and type_of_asset_code='04'  and a.asset_code=b.asset_code and p.mcode='"+mandal+"'  ";
			rs2=stmt2.executeQuery(query22);
			
			while(rs2.next())
			{
			assetcode=rs2.getString(1);
			String query33="select  a.asset_name,a.location,to_char(date_creation,'dd/mm/yyyy'),decode(a.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed')result,a.asset_cost,a.hab_code,s.panch_name,a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view s where s.panch_code=a.hab_code and  s.dcode='"+district+"' and type_of_asset_code='04' and a.asset_code=b.asset_code and s.mcode='"+mandal+"' and a.asset_code='"+assetcode+"' ";
			rs3=stmt3.executeQuery(query33);
			while(rs3.next())
			{
			
			
			
			
			
			
			
			
			
			 
			 
			
			
		 	
		
		
			

 			  
		
	
	     	
						%>
						<tr bgcolor="#ffffff">
				        <td class=rptValue><%=sno++%></td>
						<td class=rptValue><%=isNull(rs3.getString(1))%></td>
						<td class=rptValue><%=isNull(rs3.getString(2))%></td>
						<td class=rptValue><%=isNull(rs3.getString(3))%></td>
						<td class=rptValue><%=isNull(rs3.getString(4))%></td>
						<td class=rptValue><%=isNull(rs3.getString(5))%></td>
						<td class=rptValue>&nbsp;&nbsp;&nbsp;<%=isNull(rs3.getString(6))%></td>
						<td class=rptValue><%=isNull(rs3.getString(7))%></td>
						<td class=rptValue><%=isNull(rs3.getString(8))%></td>
						
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
if(rs3!=null)
	{
		rs3.close();
	}
	if(stmt3!=null)
	{
		stmt3.close();
		
	}

if(rs2!=null)
	{
		rs2.close();
	}
	if(stmt2!=null)
	{
		stmt2.close();
		
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
