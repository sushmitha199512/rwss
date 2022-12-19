<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp" %>
<%!
Statement statement;
ResultSet results;%>
</head>
<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
 <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<TH>S.No</TH>
						<TH>Asset Name</TH>
						<TH>Pump Code </TH>
						<TH>Location</TH>
						<TH>Diameter(mm)</TH>
						<TH>Depth(Mts) </TH>
						<TH>Casing(Type) </TH>
					 	<TH>No of GI Pipes </TH>
						<TH>General Condition </TH>
						<TH>Static Water Level(Mts) </TH>
						<TH>Summer Water Level(Mts)(From Ground)  </TH>
						<TH>No Of Hours Serving per day  </TH>
						<TH>No Of Households Served  </TH>
						<TH>HP No Painted  </TH>
					    <TH>Repairs Per Year  </TH>
					    <TH>Platform Condition  </TH>
					    <TH>Drain </TH>
						<TH>Drain Condition </TH>
						<TH>Drain Connected to Side Drains </TH>
						<TH>Leach pit   </TH>
						<TH>Hygiene   </TH>
						<TH>Present Yield (as per Local Enquiry)  </TH>
					    <TH>Yield(l.p.m)   </TH>
</tr>
</thead>
<tbody class="gridText">
<%

String assetcode=request.getParameter("assetCode");
statement=conn.createStatement();
int index = 0;
String query="SELECT ASSET_NAME,HP_CODE,subCompTbl.LOCATION,subCompTbl.DRILL_YEAR,subCompTbl.DIAMETER,subCompTbl.CASING,DECODE (subCompTbl.STATUS,'W','WORKING','N','NOT WORKING') AS STATUS,DECODE (subCompTbl.GEN_CONDITION,'G','GOOD','B','BAD') AS GEN_CONDITION,GI_NO,DECODE(subCompTbl.PAINTED,'Y','YES','N','NO') AS PAINTED,STATIC_WL,SUMMER_WL,NVL(DEPTH,'0.0') AS DEPTH,NVL(SER_HRS,'0') AS SER_HRS,nvl(SER_NO,'0') as SER_NO,decode(subCompTbl.PAINTED ,'Y','YES','N','NO')painted,nvl (REPAIRS,'-') as REPAIRS,DECODE (subCompTbl.PLATFORM_CONDITION,'G','GOOD','B','BAD') AS PLATFORM_CONDITION,DECODE (subCompTbl.DRAIN,'E','EXISTING','N','NOT EXISTING') AS DRAIN,DECODE (subCompTbl.DRAIN_CONDITION,'G','GOOD','B','BAD') AS DRAIN_CONDITION,DECODE (subCompTbl.DRAIN_SD,'Y','YES','N','NO') AS DRAIN_SD,nvl(DECODE (subCompTbl.DRAIN_LP,'Y','YES','N','NO'),'-') AS DRAIN_LP,DECODE (subCompTbl.HYGIENE,'G','GOOD','B','BAD') AS HYGIENE,nvl (PYEILD_LOCAL,'-')as PYEILD_LOCAL,nvl(P_YEILD,'0')as P_YEILD,nvl(REPAIRS,'-') as REPAIRS FROM RWS_ASSET_MAST_TBL M, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and m.asset_code='"+assetcode+"' and M.type_of_asset_code='04' and substr (subCompTbl.HP_CODE,17,3) like '0%' ";
////////System.out.println("bw query:"+query);
try
{
	results=statement.executeQuery(query);
	while(results.next()){

	 %>
	 <tr>
	<td class="mystyle1"><%=++index%></td>
	<td class="mystyle1"><%=results.getString("ASSET_NAME")%></td>
	<td class="mystyle1"><%=results.getString("HP_CODE")%></td>
	<td class="mystyle1"><%=results.getString("LOCATION")%></td>
	<td class="mystyle1"><%=results.getFloat("DIAMETER")%></td>
	<td class="mystyle1"><%=results.getFloat("DEPTH")%></td>
	<td class="mystyle1"><%=results.getString("CASING")%></td> 
	<td class="mystyle1"><%=results.getInt("GI_NO")%></td> 
	<td class="mystyle1"><%=results.getString("GEN_CONDITION")%></td> 
	<td class="mystyle1"><%=results.getFloat("STATIC_WL")%></td> 
	<td class="mystyle1"><%=results.getFloat("SUMMER_WL")%></td> 
	<td class="mystyle1"><%=results.getFloat("SER_HRS")%></td> 
	<td class="mystyle1"><%=results.getInt("SER_NO")%></td> 
	<td class="mystyle1"><%=results.getString("PAINTED")%></td> 
	<td class="mystyle1"><%=results.getString("REPAIRS")%></td>
	<td class="mystyle1"><%=results.getString("PLATFORM_CONDITION")%></td> 
	<td class="mystyle1"><%=results.getString("DRAIN")%></td> 
	<td class="mystyle1"><%=results.getString("DRAIN_CONDITION")%></td> 
	<td class="mystyle1"><%=results.getString("DRAIN_SD")%></td>
	<td class="mystyle1"><%=results.getString("DRAIN_LP")%></td> 
	<td class="mystyle1"><%=results.getString("HYGIENE")%></td> 
	<td class="mystyle1"><%=results.getString("PYEILD_LOCAL")%></td> 
	<td class="mystyle1"><%=results.getInt("P_YEILD")%></td> 
	 </tr>
<%}
}
	 catch(Exception e){}
	 finally{
		 if(results!=null)results.close();
		 if(statement!=null)statement.close();
		 if(conn!=null)conn.close();
	 }
	 %>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="23" align="left">
		Total No. of Borewells:&nbsp;<%=index %>
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
<%@ include file="connClose.jsp" %>
<%}finally{}%>