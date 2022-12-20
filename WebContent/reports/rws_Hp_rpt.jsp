<%@	page import="java.sql.*, java.util.* " %>
<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
	ResultSet datars=null;
					int col1=0,col2=0,col3=0,col4=0,col5=0;
    %>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=white style="border-collapse:collapse" bgcolor="#ffffff" align = "center">

<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td class="bwborder"><a href="javascript:history.go(-1)">Back|</a></td>
				 
			</tr>
		</table>
	</caption>
	<tr>
	<table border = 1 bordercolor="black" style="border-collapse:collapse" bgcolor="#ffffff" >
	<tr><td rowspan="2"  class="rptHeading">S No</td>
<td rowspan="2" class="rptHeading" align=center>District</td>
<td rowspan="2" class="rptHeading">Total HP's <BR>with Borewell<BR> Details</td>
<td colspan="4" class="rptHeading" align=center>Updation Details</td>
</tr>
<tr>
<td class="rptHeading">Cost</td>
<td class="rptHeading">Year</td>
<td class="rptHeading">Location</td>
<td class="rptHeading">Yield</td>
</tr>
<% 			


   Statement stqq =null,st1=null; 
   ResultSet rsqq = null;
    try{
			String qq = "select dcode,dname from rws_district_tbl";
			stqq  = conn.createStatement();
			st1  = conn.createStatement();
			rsqq = stqq.executeQuery(qq);
			int count = 1;
			while(rsqq.next())
			{
				try{
					%>
						<tr>
						<td align="center" class="rptValue"><%=count++%></td>
						<td align="left" class="rptValue"><%=rsqq.getString(2)%></td>
					<%
							qq = "select(select count(*) from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='04' and ASSET_STATUS<>'5' and c.dcode='"+rsqq.getString(1)+"')a,(select count(*) from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='04' and ASSET_STATUS<>'5' and asset_cost is not null and c.dcode='"+rsqq.getString(1)+"')b,(select count(*) from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='04' and ASSET_STATUS<>'5' and DATE_CREATION is not null and c.dcode='"+rsqq.getString(1)+"')c,(select count(*) from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='04' and ASSET_STATUS<>'5' and a.LOCATION is not null and c.dcode='"+rsqq.getString(1)+"')d,(select count(*) from rws_asset_mast_tbl a,rws_hp_subcomp_param_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='04' and ASSET_STATUS<>'5' and P_YEILD is not null and c.dcode='"+rsqq.getString(1)+"')e from dual ";
							datars = st1.executeQuery(qq);
							if(datars.next())
							{
								
							%>
								<td align="right" class="rptValue"><%=datars.getString(1)%></td>
								<td align="right" class="rptValue"><%=datars.getString(2)%></td>
								<td align="right" class="rptValue"><%=datars.getString(3)%></td>
								<td align="right" class="rptValue"><%=datars.getString(4)%></td>
								<td align="right" class="rptValue"><%=datars.getString(5)%></td>
								
							<%
								col1+=datars.getInt(1);col2+=datars.getInt(2);col3+=datars.getInt(3);
								col4+=datars.getInt(4);col5+=datars.getInt(5);
							}
					}
					catch(Exception e)
					{
						//System.out.println("Exception in conn1"+e.getMessage());
					}
					finally{
						if(datars!=null)datars.close();				
					 ////System.out.println("Inserted Rows:"+inCount);
				}
			}
			%>
			<tr>
			<td colspan=2  class="rptHeading">Total</td>
				<td align="right" class="rptHeading"><%=col1%></td>
				<td align="right" class="rptHeading"><%=col2%></td>
				<td align="right" class="rptHeading"><%=col3%></td>
				<td align="right" class="rptHeading"><%=col4%></td>
				<td align="right" class="rptHeading"><%=col5%></td>
				</tr>
			<%
		}
	  catch(Exception e)
   {
   //System.out.println("Exception in conn"+e);
   }finally{
	   try{
			
			rsqq.close();
			stqq.close();		
		}catch(Exception e){}
   }
 
	%>
	<p align="left">
	<font face=verdana size=2 color=red>
	Note: CONDEMED Hand Pumps and Hand Pumps not Having Borewell details are not shown in this report.
	</font>
	</p>
	</table><br/>

	<table border = 0  style="border-collapse:collapse" >
	<tr align="left">
	<td><font face=verdana size=2 color=red>
	Note:
	</font>
	</td>
	<td><font face=verdana size=2 color=blue>
	Cost : </font><font face=verdana size=1>Total number of Hand pumps having updated cost of an asset</font>
	</td>
	</tr>
	<tr align="left">
	<td><font face=verdana size=2 color=red>
	
	</font>
	</td>
	<td><font face=verdana size=2 color=blue>
	Year : </font><font face=verdana size=1>Total number of Hand pumps having updated year of an asset</font>
	</td>
	</tr>
	<tr align="left">
	<td><font face=verdana size=2 color=red>
	
	</font>
	</td>
	<td><font face=verdana size=2 color=blue>
	Location : </font><font face=verdana size=1>Total number of Hand pumps having updated location of an asset</font>
	</td>
	</tr>
	<tr align="left">
	<td><font face=verdana size=2 color=red>
	
	</font>
	</td>
	<td><font face=verdana size=2 color=blue>
	Yield : </font><font face=verdana size=1>Total number of Hand pumps having updated yield of an asset</font>
	</td>
	
	</table>
