<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html>
<body>
<%

nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");
 String habcode=request.getParameter("habcode");
 //System.out.println("habcode:"+habcode);
String val=request.getParameter("value");
//System.out.println("val"+val);
String type=request.getParameter("type");
//System.out.println("type"+type);
String check=request.getParameter("check");
//System.out.println("check"+check);
String yearStart=request.getParameter("yearStart");
String yearEnd=request.getParameter("yearEnd");
%>
 <table border = 0 width=740 align=center>   
 <%
 if(type!=null && type.equals("1"))
{%>
<tr>
<td align=right colspan=8>

<%-- <a href="rws_water_nss_habs_xls1.jsp?type=1&&habcode=<%=habcode%>&value=<%=val%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd %>"  target=_new>Excel</a> | --%>
<a href="javascript:window.close()">Close</a></td><tr>
<tr><td class=btext><%=val%></td>

</tr>
<%}
 else
 {
 %>
 
 <tr>
<td align=right colspan=8>

<%-- <a href="rws_water_nss_habs_xls1.jsp?habcode=<%=habcode%>&value=<%=val%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd %>"  target=_new>Excel</a> | --%>
<a href="javascript:window.close()">Close</a></td><tr>
<tr><td class=btext><%=val%></td>

</tr>
 <%} %>
</table>


<table  cellspacing=0 cellpadding=0 width="60%"	 style="border-collapse: collapse" 	align="center">
<tr>
<td class=gridhdbg>SNO</td>
<td class=gridhdbg>Source Code/Source Name</td>
<td class=gridhdbg>Brakish</td>
<td class=gridhdbg>Flouride</td> 
<td class=gridhdbg>Iron</td> 
<td class=gridhdbg>Nitrate</td> 
<td class=gridhdbg>PH</td>
<td class=gridhdbg>HARDNESS</td> 
<td class=gridhdbg>ALKALINITY</td> 
<td class=gridhdbg>CHLORIDE</td> 
<td class=gridhdbg>SULPHATE</td>
</tr>
<%

String query1="",query2="";
int number=0;
String style="";
int styleCount=0;int tds=0;
double nitrate=0.0;
double flouride=0.0,iron=0.0,salinity=0.0,salinity1=0.0;
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
double flouridePPM=0,tdsPPM=0,salinityPPM=0,ironPPM=0,nitratePPM=0;

		 stmt1 = conn.createStatement();
		 query1 = "select TESTING_PARAMETER_CODE,to_number(TRIM(MAX_PERMISSIBLE_VALUE)) from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE in ('13','05','12','16','15')";
		 rs1 = stmt1.executeQuery(query1);
		while(rs1.next())
		{
			if(rs1.getString("TESTING_PARAMETER_CODE").equals("13")){
				flouridePPM=rs1.getDouble(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("05")){
				tdsPPM=rs1.getDouble(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("12")){
				salinityPPM=rs1.getDouble(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("16")){
				ironPPM=rs1.getDouble(2);
			}
			else if(rs1.getString("TESTING_PARAMETER_CODE").equals("15")){
				nitratePPM=rs1.getDouble(2);
			}
		}			
		rs1.close();			
		stmt1.close();

//String query="select distinct source_code  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where substr (source_code,1,16)='"+habcode+"' and a.test_id=b.test_id ";
String query="select  distinct source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where substr(source_code,1,16)='"+habcode+"' and a.test_id=b.test_id and test_code='1' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' group by source_code";
/* if(check.equals("flouride"))
{
	//System.out.println("flouride");
query+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
}
else if(check.equals("tds"))
{
	query+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
}
else if(check.equals("salinity"))
{
	query+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
}
else if(check.equals("iron"))
{
	query+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
}
else if(check.equals("nitrate"))
{
	query+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
}  */

//System.out.println("qry:"+query);
stmt=conn.createStatement();
rs=stmt.executeQuery(query);
while(rs.next())
{
	if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;




%>
	<tr>
	<td class=<%=style %> style="text-align: left;" ><%=++number%></td>

	<%  
	if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("SO") )
      {
		   query2="select   s.source_code ,nvl(source_name,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy')) from rws_source_tbl s, rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and s.source_code=a.source_code and  a.source_code='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'  group by s.source_code,nvl(source_name,'-'),a.test_id";
		  /*  if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			}
		    */
	  }
     else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("HP") )
		  {
	//  query2=" select  hp_code,nvl(location,'-'),a.test_id  from rws_hp_subcomp_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and  h.hp_code=a.source_code and  hp_code='"+rs.getString(1)+"' ";
	
	  query2=" select  hp_code,nvl(location,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from rws_hp_subcomp_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and a.source_code='"+rs.getString(1)+"' and  hp_code='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' group by hp_code,nvl(location,'-'),a.test_id";
	  
	 /*  if(check.equals("flouride"))
		{
			//System.out.println("flouride");
		query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
	 }
		else if(check.equals("tds"))
		{
			query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
		}
	else if(check.equals("salinity"))
		{
		query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
		}
		else if(check.equals("iron"))
		{
			query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
		}
		else if(check.equals("nitrate"))
		{
			query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
		}
		  */
		  }
	else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("PD") )
	      {
			 query2="select   POND_CODE ,nvl(pond_location,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from RWS_OPENWELL_POND_TBL h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.POND_CODE=a.source_code and h.POND_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'  group by POND_CODE,nvl(pond_location,'-'),a.test_id";
			 
			/*  if(check.equals("flouride"))
				{
					//System.out.println("flouride");
				query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
			 }
				else if(check.equals("tds"))
				{
					query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
				}
			else if(check.equals("salinity"))
				{
				query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
				}
				else if(check.equals("iron"))
				{
					query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
				}
				else if(check.equals("nitrate"))
				{
					query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
				} */
		  }
	else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("OW") )
	    {
		  query2="select  OPENWELL_CODE ,nvl(location,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from rws_open_well_mast_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.OPENWELL_CODE=a.source_code and   OPENWELL_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' group by OPENWELL_CODE,nvl(location,'-'),a.test_id";
		  
		/*   if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			}
		 */
	}
    else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("SH") )
		{		
		  query2="select  SHALLOWHP_CODE,nvl(location,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from rws_shallowhandpumps_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.SHALLOWHP_CODE=a.source_code and   SHALLOWHP_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'  group by SHALLOWHP_CODE,nvl(location,'-'),a.test_id";
		  
		  /* if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			} */
		}
    else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("GB") )
		{
		   query2="select  GLBR_CODE ,nvl(GLBR_LOC,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from RWS_ast_glbr_sc_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.GLBR_CODE=a.source_code and   GLBR_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' group by GLBR_CODE,nvl(GLBR_LOC,'-'),a.test_id";
		  
		  /*  if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			} */
		
		}
    else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("GL") )
    	
		{
		  query2="select  GLSR_CODE ,nvl(GLSR_LOC,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from RWS_ast_glsr_sc_param_tbl h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.GLSR_CODE=a.source_code and   GLSR_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'  group by GLSR_CODE,nvl(GLSR_LOC,'-'),a.test_id" ;
		  
		 /*  if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			} */
		 
		}
    else if(rs.getString(1)!=null && rs.getString(1).substring(19,21).equals("OS") )
		{
		  query2="select  OHSR_CODE ,nvl(OHSR_LOC,'-'),a.test_id,max(to_char(PREPARED_ON,'dd/mm/yyyy'))  from RWS_AST_OHSR_SC_PARAM_TBL h , rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id and h.OHSR_CODE=a.source_code and   OHSR_CODE='"+rs.getString(1)+"' and a.PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'  group by OHSR_CODE,nvl(OHSR_LOC,'-'),a.test_id" ;
		  
		  /* if(check.equals("flouride"))
			{
				//System.out.println("flouride");
			query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 }
			else if(check.equals("tds"))
			{
				query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			}
		else if(check.equals("salinity"))
			{
			query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
			}
			else if(check.equals("iron"))
			{
				query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			}
			else if(check.equals("nitrate"))
			{
				query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			} */
		}
     stmt2=conn.createStatement();
	 //System.out.println("qry2:"+query2);
	
	 rs2=stmt2.executeQuery(query2);
	 if(rs2.next())
	 {  //System.out.println("tsrt_id="+rs2.getString(3))	;
	 
	 %>
		<td class=<%=style %> style="text-align: left;"  ><%=rs2.getString(1)%> /<%=rs2.getString(2)%></td> 
	 <%
	
		
	query1="select (select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='05'  and test_id='"+rs2.getString(3)+"')a1,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13'  and test_id='"+rs2.getString(3)+"')b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"')iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
	 
	
	/*  if(check.equals("flouride"))
		{
			//System.out.println("flouride");
		//query2+=" and  b.testing_parameter_code='13' and b.testing_parameter_value>1.5  ";
		 query1="select (select  testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05'  and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13' and testing_parameter_value>1.5  and test_id='"+rs2.getString(3)+"' )b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
	 }
		else if(check.equals("tds"))
		{
			//query2+="  and b.testing_parameter_code='05' and b.testing_parameter_value> 2000 ";
			query1="select (select  testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05' and testing_parameter_value>2000 and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13'  and test_id='"+rs2.getString(3)+"' )b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
		}
	else if(check.equals("salinity"))
		{
		//query2+="  and b.testing_parameter_code='12' and  (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) ";
		query1="select (select  testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05'  and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13'  and test_id='"+rs2.getString(3)+"' )b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and (0.03+((1.806*b.testing_parameter_value)/1000) > 1.836) and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
		}
		else if(check.equals("iron"))
		{
			//query2+="  and b.testing_parameter_code='16' and b.testing_parameter_value> 0.3 ";
			query1="select (select  testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05'  and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13'  and test_id='"+rs2.getString(3)+"' )b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and testing_parameter_value> 0.3 and test_id='"+rs2.getString(3)+"' )iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
		}
		else if(check.equals("nitrate"))
		{
			//query2+="  and b.testing_parameter_code='15' and b.testing_parameter_value> 45 ";
			query1="select (select  testing_parameter_value  from rws_wq_test_results_lnk_tbl where testing_parameter_code='05'  and test_id='"+rs2.getString(3)+"')a1,(select  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='13'  and test_id='"+rs2.getString(3)+"' )b1,(select distinct  testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='16' and test_id='"+rs2.getString(3)+"' )iron ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='15' and testing_parameter_value> 45 and test_id='"+rs2.getString(3)+"') nitrate ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='04' and test_id='"+rs2.getString(3)+"') PH ,(select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='06' and test_id='"+rs2.getString(3)+"') hardness , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='07' and test_id='"+rs2.getString(3)+"') alkalinity , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='12' and test_id='"+rs2.getString(3)+"') chloride , (select distinct testing_parameter_value from rws_wq_test_results_lnk_tbl where testing_parameter_code='14' and test_id='"+rs2.getString(3)+"') sulphate from dual" ;
		} */
	 
	stmt1=conn.createStatement();
	//System.out.println(" qryyyyy:"+query1);
	
	
	rs1=stmt1.executeQuery(query1);
	
	
	rs1.next();
	
	salinity=rs1.getDouble(8);
	salinity1=(0.03+(1.806*salinity/1000));
	//System.out.println("salinity1:"+salinity1);
	tds=rs1.getInt(1);
	iron=rs1.getDouble(3);
	flouride=rs1.getDouble(2);
	/* if(flouride==0.0 || flouride<rs1.getDouble(2)){
		flouride=rs1.getDouble(2);
	} */
	
	nitrate=rs1.getDouble(4);
	//System.out.println(" nitrate:"+nitrate); 
	if( tds<=tdsPPM)
	{%>
	<td class=<%=style %>  style="text-align: center;"><%=tds%></td> 
	
	<%}
	
	else if(tds>tdsPPM && check.equals("tds") ){
	
	%><td class=btext style="text-align: center;" ><%=tds%></td>
	
	<%}
	else
	{%>
	<td class=<%=style %> style="text-align: center;" ><%=tds%></td><%}
	
	if(flouride>flouridePPM && check.equals("flouride"))
	{%>
	<td class=btext style="text-align: center;"  ><%=flouride%></td><%}
	else if(flouride<=flouridePPM){%>
	<td class=<%=style %> style="text-align: center;"  ><%=flouride%></td><%}
	else
	{%>
	<td class=<%=style %> style="text-align: center;"  >-</td><%}
	
	if(check.equals("iron") && iron>ironPPM)
	{%>
	<td class=btext style="text-align: center;"  ><%=iron%></td><%}
	else if(iron<=ironPPM){%>
	<td class=<%=style %> style="text-align: center;" ><%=iron%></td><%}
	
	else
	{%>
	<td class=<%=style %> style="text-align: center;" >-</td><%}
	
	
	
	if(check.equals("nitrate") && nitrate>nitratePPM)
	{%>
	<td class=btext style="text-align: center;"  ><%=nitrate%></td><%}
	else if(nitrate<=nitratePPM)
	{%>
	<td class=<%=style %> style="text-align: center;"  ><%=nitrate%></td><%}
	else
	{%>
	<td class=<%=style %> style="text-align: center;"  >-</td><%}
		
	if(rs1.getString(5)!=null )
	{%><td class=<%=style %> style="text-align: center;"  ><%=rs1.getString(5)%></td><%}
	else{%><td class=<%=style %> style="text-align: center;"  >-</td><%}
 	
	
	if(rs1.getString(6)!=null )
	{%><td class=<%=style %> style="text-align: center;"  ><%=rs1.getString(6)%></td><%}
	else{%><td class=<%=style %> style="text-align: center;"  >-</td><%}
 	
	
	
	if(rs1.getString(7)!=null )
	{%><td class=<%=style %> style="text-align: center;"  ><%=rs1.getString(7)%></td><%}
	
	else{%><td class=<%=style %> style="text-align: center;"  >-</td><%}
 	
	
	if(salinity1>salinityPPM && check.equals("salinity"))
	{%>
	<td class=btext  style="text-align: center;"><%=ndf.format(salinity1)%></td> 
	
	<%}
	
	else if(salinity1<=salinityPPM){
	
	%><td class=<%=style %> style="text-align: center;" ><%=ndf.format(salinity1)%></td>
	
	<%}
	else
	{%>
	<td class=<%=style %> style="text-align: center;" ><%=salinity1%></td><%}
	
	
	
	if(rs1.getString(9)!=null )
	{%><td class=<%=style %> style="text-align: center;"  ><%=rs1.getString(9)%></td><%}
	else{%><td class=<%=style %> style="text-align: center;"  >-</td><%}
 	
	
	
 	}
	 /* else 
	 { */  %>

<%-- <td class=<%=style %> style="text-align: left;"  ><%=rs.getString(1)%></td><td></td><td></td> --%>
    <% /*  } */%>
    
	</tr>
	<%}	%>
</table>

</body>
</html>  