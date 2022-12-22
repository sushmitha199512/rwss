<%@	page import="java.sql.*, java.util.* " %>
<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
	
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
<td rowspan="2" class="rptHeading">Total Schemes</td>
<td colspan="4" class="rptHeading" align=center>Updation Details</td>
</tr>
<tr>
<td class="rptHeading">Cost</td>
<td class="rptHeading">Year</td>
<td class="rptHeading">Sources</td>
<td class="rptHeading">Sr. Reservoirs</td>
</tr>
<% 			

   Statement st =null,st1=null,st2=null,st3=null,st4=null,st5=null; 
   ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
    try
		{
			st = conn.createStatement();
			st1 = conn.createStatement();
			st2 = conn.createStatement();
			st3 = conn.createStatement();
			st4 = conn.createStatement();
			st5 = conn.createStatement();

         String totSchemes="select count(*),dcode from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and (type_of_asset_code='01' or type_of_asset_code='02' or type_of_asset_code='03' or type_of_asset_code='09')  group by dcode ";
         //System.out.println("qry1:"+totSchemes);
				rs=st.executeQuery(totSchemes);
				Hashtable ht1 = new Hashtable();
				while(rs.next())
				{
				ht1.put(rs.getString(2),rs.getString(1)); 
				}
		String cost="select count(*),dcode from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and (type_of_asset_code='01' or type_of_asset_code='02' or type_of_asset_code='03' or type_of_asset_code='09') and asset_cost is not null group by dcode";
		//System.out.println("qry2:"+cost);
				rs1=st1.executeQuery(cost);
				Hashtable ht2 = new Hashtable();
				while(rs1.next())
				{
				ht2.put(rs1.getString(2),rs1.getString(1)); 
				}
		String year="select count(*),dcode from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and (type_of_asset_code='01' or type_of_asset_code='02' or type_of_asset_code='03' or type_of_asset_code='09') and date_creation is not null group by dcode";
		//System.out.println("qry3:"+year);
				rs2=st2.executeQuery(year);
				Hashtable ht3 = new Hashtable();
				while(rs2.next())
				{
				ht3.put(rs2.getString(2),rs2.getString(1)); 
				}
		String source="select count(*),dcode from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and (type_of_asset_code='01' or type_of_asset_code='02' or type_of_asset_code='03' or type_of_asset_code='09') and a.asset_code in (select asset_code from rws_source_tbl) group by dcode";
	//	System.out.println("qry4:"+source);
				rs3=st3.executeQuery(source);
				Hashtable ht4 = new Hashtable();
				while(rs3.next())
				{
				ht4.put(rs3.getString(2),rs3.getString(1)); 
				}
		String reservoirs="select count(*),dcode from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and (type_of_asset_code='01' or type_of_asset_code='02' or type_of_asset_code='03' or type_of_asset_code='09') and a.asset_code in (select asset_code from RWS_AST_OHSR_SC_PARAM_TBL union select asset_code from RWS_AST_OHBR_SC_PARAM_TBL union select asset_code from RWS_AST_GLSR_SC_PARAM_TBL union select asset_code from RWS_AST_GLBR_SC_PARAM_TBL union select asset_code from RWS_AST_BPT_PARAM_TBL union select asset_code from RWS_AST_CIS_SC_PARAM_TBL) group by dcode";
		//System.out.println("qry5:"+reservoirs);
				rs4=st4.executeQuery(reservoirs);
				Hashtable ht5 = new Hashtable();
				while(rs4.next())
				{
				ht5.put(rs4.getString(2),rs4.getString(1)); 
				}
		
	        String qq1 = "select dcode,dname from rws_district_tbl where dcode <> '16'";
			rs5 = st5.executeQuery(qq1);
			int count = 1;
			while(rs5.next())
			{
				String val1 = ""+ht1.get(rs5.getString(1));
				if(val1!=null && !val1.equals("null")){}else{val1="0";}
				String[] values1 = val1.split("@");
				String val2 = ""+ht2.get(rs5.getString(1));
				if(val2!=null && !val2.equals("null")){}else{val2="0";}
		        String[] values2 = val2.split("@");
				String val3 = ""+ht3.get(rs5.getString(1));
				if(val3!=null && !val3.equals("null")){}else{val3="0";}
		        String[] values3 = val3.split("@");
				String val4 = ""+ht4.get(rs5.getString(1));
				if(val4!=null && !val4.equals("null")){}else{val4="0";}
		        String[] values4 = val4.split("@");
				String val5 = ""+ht5.get(rs5.getString(1));
				if(val5!=null && !val5.equals("null")){}else{val5="0";}
		        String[] values5 = val5.split("@");
				
				col1 += Integer.parseInt(values1[0]);
				col2 += Integer.parseInt(values2[0]);
				col3 += Integer.parseInt(values3[0]);
				col4 += Integer.parseInt(values4[0]);
				col5 += Integer.parseInt(values5[0]);
			%>
			<tr>
			<td align="center" class="rptValue"><%=count++%></td>
			<td align="left" class="rptValue"><%=rs5.getString(2)%></td>
			<td align="right" class="rptValue"><%=values1[0]%></td>
			<td align="right" class="rptValue"><%=values2[0]%></td>
			<td align="right" class="rptValue"><%=values3[0]%></td>
			<td align="right" class="rptValue"><%=values4[0]%></td>
			<td align="right" class="rptValue"><%=values5[0]%></td>
			</tr>
			<%			
			
			}
			%>
			<tr>
			<td colspan=2  class="rptHeading">Total</td>
				<td align="right" class="rptHeading"><%=col1%></td>
				<td align="right" class="rptHeading"><%=col2%></td>
				<td align="right" class="rptHeading"><%=col3%></td>
				<td align="right" class="rptHeading"><%=col4%></td>
				<td align="right" class="rptHeading"><%=col5%></td>
			<%
		}
	  catch(Exception e)
   {
 //  System.out.println("Exception in conn"+e);
   }
   	%>
	<p align="left">
	<font face=verdana size=2 color=red>
	Note: Consolidated report on All the Schemes(CPWS,PWS,MPWS,DP)
	</font>
	</p>