<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>

<script type="text/javascript">
	function viewWorks(URL) {
		
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
</script>

<%
	
	String mode="";
	if(request.getParameter("mode")!=null && request.getParameter("mode")!=""){
		mode=request.getParameter("mode");
	}
	
	String dcode="";
	String dname="";
	if(request.getParameter("dcode")!=null){
		dcode=request.getParameter("dcode");
		dname=request.getParameter("dname");
	}
	
	String mcode="";
	String mname="";
	if(request.getParameter("mcode")!=null){
		mcode=request.getParameter("mcode");
		mname=request.getParameter("mname");
	}
	
	String pcode="";
	String pname="";
	if(request.getParameter("pcode")!=null){
		pcode=request.getParameter("pcode");
		pname=request.getParameter("pname");
	}
%>

<body bgcolor="#edf2f8">
	<form>
		<table border=0 cellspacing=0 cellpadding=0 height=5%
			bordercolor=#000000 style="border-collapse: collapse"
			bgcolor="#ffffff" align="center">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right">
					<tr>
						<td align="right" class="bwborder"><a
							href="javascript:history.go(-1)">Back</a>| <a
							href="/pred/home.jsp?loginMode=watersoft">Home </a></td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class=gridhdbg colspan=21>Asset Non Functional Status </td>
			</tr>
			<tr align="center">
				<td class=gridhdbg rowspan=2 align=center>Sno</td>
				<%if(mode.equals("mandal")){ %>
				<td class=gridhdbg rowspan=2 align=center>Mandal</td>
				<% }else if(mode.equals("panchayat")){%>
				<td class=gridhdbg rowspan=2 align=center>Panchayat</td>
				<% }else{%>
				<td class=gridhdbg rowspan=2 align=center>District</td>
				<%} %>
				<td class=gridhdbg  align=center colspan="5">Not Functional Schemes </td>
				<td class=gridhdbg rowspan=2 align=center>Not working</td>
				<td class=gridhdbg rowspan=2 align=center>Seasonal</td>
				<td class=gridhdbg rowspan=2 align=center>Dried/ Condemned</td>
				<td class=gridhdbg  colspan="6" align=center>Type of Problem </td>
				<td class=gridhdbg  align=center colspan="5">Alternate Measures Taken</td>
				
				
			</tr>
			<tr align="center">
				<td class=gridhdbg>CPWS</td>
				<td class=gridhdbg>PWS</td>
				<td class=gridhdbg>MPWS</td>
				<td class=gridhdbg>DP</td>
				<td class=gridhdbg>Total</td>
				<td class=gridhdbg>Source</td>
				<td class=gridhdbg>Head Works</td>
				<td class=gridhdbg>PipeLine</td>
				<td class=gridhdbg>Sr.Reservoirs</td>
				<td class=gridhdbg>Pumping</td>
				<td class=gridhdbg>Others</td>
				<td class=gridhdbg>Through other schemes</td>
				<td class=gridhdbg>DP</td>
				<td class=gridhdbg>Transportation</td>
				<td class=gridhdbg>Hiring of Source </td>
				<td class=gridhdbg>Total</td>
			</tr>
			<tr align="center">
				<td class=gridhdbg>1</td>
				<td class=gridhdbg>2</td>
				<td class=gridhdbg>3</td>
				<td class=gridhdbg>4</td>
				<td class=gridhdbg>5</td>
				<td class=gridhdbg>6</td>
				<td class=gridhdbg>7</td>
				<td class=gridhdbg>8</td>
				<td class=gridhdbg>9</td>
				<td class=gridhdbg>10</td>
				<td class=gridhdbg>11</td>
				<td class=gridhdbg>12</td>
				<td class=gridhdbg>13</td>
				<td class=gridhdbg>14</td>
				<td class=gridhdbg>15</td>
				<td class=gridhdbg>16</td>
				<td class=gridhdbg>17</td>
				<td class=gridhdbg>18</td>
				<td class=gridhdbg>19</td>
				<td class=gridhdbg>20</td>
				<td class=gridhdbg>21</td>
			</tr>
			<%
			Hashtable counts_hash=new Hashtable();
			Statement statement = null;
			ResultSet resultSet = null;
			String countQuery="select c.dcode,";
			  	if(mode.equals("mandal"))
		        	countQuery+=" c.mcode,";
		        else if(mode.equals("panchayat"))	
		        	countQuery+=" c.mcode,c.pcode,";
		        
		        	countQuery+="sum(case when TYPE_OF_ASSET_CODE='03' and ASSET_STATUS=2 then 1 else 0 end) as cpws,"
					  +" sum(case when TYPE_OF_ASSET_CODE='01' and ASSET_STATUS=2 then 1 else 0 end) as pws,"
					  +" sum(case when TYPE_OF_ASSET_CODE='02' and ASSET_STATUS=2 then 1 else 0 end) as mpws,"
					  +" sum(case when TYPE_OF_ASSET_CODE='09' and ASSET_STATUS=2 then 1 else 0 end) as dp,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then 1 else 0 end) as totSchemes,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then 1 else 0 end) as notWorking,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=4 then 1 else 0 end) as seasonal,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS in(3,5) then 1 else 0 end) as driedCondemned,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='SOURCE') else 0 end) as source,"
			 		  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='HEADWORKS') else 0 end) as headWorks,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='PIPELINE') else 0 end) as pipeline,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='SR.RESERVOIRS') else 0 end) as srreservoirs,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='PUMPING') else 0 end) as pumping,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d where d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME='OTHERS') else 0 end) as others,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d,RWS_ASSET_COMPONENT_REPAIR_TBL e where d.ASSET_CODE=e.ASSET_CODE and d.SOURCE_CODE=e.ASSET_COMP_CODE and  d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS') AND ALT_ARNGMT='Through other scheme') else 0 end) as throughOtherSchemes,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d,RWS_ASSET_COMPONENT_REPAIR_TBL e where d.ASSET_CODE=e.ASSET_CODE and d.SOURCE_CODE=e.ASSET_COMP_CODE and  d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS') AND ALT_ARNGMT='Direct Pumping') else 0 end) as altDp,"
				      +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d,RWS_ASSET_COMPONENT_REPAIR_TBL e where d.ASSET_CODE=e.ASSET_CODE and d.SOURCE_CODE=e.ASSET_COMP_CODE and  d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS') AND ALT_ARNGMT='Transportation') else 0 end) as transportation,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d,RWS_ASSET_COMPONENT_REPAIR_TBL e where d.ASSET_CODE=e.ASSET_CODE and d.SOURCE_CODE=e.ASSET_COMP_CODE and  d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS') AND ALT_ARNGMT='Hiring of source') else 0 end) as hiringOfSource,"
					  +" sum(case when TYPE_OF_ASSET_CODE in (01,02,03,09) and ASSET_STATUS=2 then (select count(*) from RWS_AST_ALL_COMP_ALL_IMG_VIEW d,RWS_ASSET_COMPONENT_REPAIR_TBL e where d.ASSET_CODE=e.ASSET_CODE and d.SOURCE_CODE=e.ASSET_COMP_CODE and  d.STATUS='N' and a.asset_code=d.ASSET_CODE and b.ASSET_CODE=d.ASSET_CODE and TYPENAME in ('SOURCE','HEADWORKS','PIPELINE','SR.RESERVOIRS','PUMPING','OTHERS') AND ALT_ARNGMT in ('Through other scheme','Direct Pumping','Transportation','Hiring of source')) else 0 end) as altMeasures"
			          +" from rws_asset_mast_tbl a,rws_asset_image_tbl b,rws_complete_hab_view c where a.hab_code=c.panch_code and a.asset_code=b.asset_code ";
			        if(mode.equals("mandal"))
			        	countQuery+=" and  c.dcode='"+dcode+"' group by c.dcode,c.mcode order by c.dcode,c.mcode";
			        else if(mode.equals("panchayat")){	
			        	countQuery+=" and  c.dcode='"+dcode+"' and  c.mcode='"+mcode+"' group by c.dcode,c.mcode,c.pcode order by c.dcode,c.mcode,c.pcode";
			        }else{
			        if(dcode!=null && !dcode.equals(""))
			        	countQuery+=" and  c.dcode='"+dcode+"' ";
			        
			        countQuery+=" group by c.dcode order by c.dcode";
			        }
			        //System.out.println(countQuery);
				statement = conn.createStatement();
				resultSet = statement.executeQuery(countQuery);
				while(resultSet.next()){
					if(mode.equals("mandal")){
				        counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"cpws", resultSet.getInt("cpws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"pws", resultSet.getInt("pws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"mpws", resultSet.getInt("mpws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"dp", resultSet.getInt("dp"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"totSchemes", resultSet.getInt("totSchemes"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"notWorking", resultSet.getInt("notWorking"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"seasonal", resultSet.getInt("seasonal"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"driedCondemned", resultSet.getInt("driedCondemned"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"source", resultSet.getInt("source"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"headWorks", resultSet.getInt("headWorks"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"pipeline", resultSet.getInt("pipeline"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"srreservoirs", resultSet.getInt("srreservoirs"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"pumping", resultSet.getInt("pumping"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"others", resultSet.getInt("others"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"throughOtherSchemes", resultSet.getInt("throughOtherSchemes")); 
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"altDp", resultSet.getInt("altDp"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"transportation", resultSet.getInt("transportation"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"hiringOfSource", resultSet.getInt("hiringOfSource"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+"altMeasures", resultSet.getInt("altMeasures"));
					}else if(mode.equals("panchayat"))	{
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"cpws", resultSet.getInt("cpws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"pws", resultSet.getInt("pws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"mpws", resultSet.getInt("mpws"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"dp", resultSet.getInt("dp"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"totSchemes", resultSet.getInt("totSchemes"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"notWorking", resultSet.getInt("notWorking"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"seasonal", resultSet.getInt("seasonal"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"driedCondemned", resultSet.getInt("driedCondemned"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"source", resultSet.getInt("source"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"headWorks", resultSet.getInt("headWorks"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"pipeline", resultSet.getInt("pipeline"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"srreservoirs", resultSet.getInt("srreservoirs"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"pumping", resultSet.getInt("pumping"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"others", resultSet.getInt("others"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"throughOtherSchemes", resultSet.getInt("throughOtherSchemes")); 
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"altDp", resultSet.getInt("altDp"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"transportation", resultSet.getInt("transportation"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"hiringOfSource", resultSet.getInt("hiringOfSource"));
						counts_hash.put(resultSet.getString("dcode")+resultSet.getString("mcode")+resultSet.getString("pcode")+"altMeasures", resultSet.getInt("altMeasures"));
					}else{
						counts_hash.put(resultSet.getString(1)+"cpws", resultSet.getInt("cpws"));
						counts_hash.put(resultSet.getString(1)+"pws", resultSet.getInt("pws"));
						counts_hash.put(resultSet.getString(1)+"mpws", resultSet.getInt("mpws"));
						counts_hash.put(resultSet.getString(1)+"dp", resultSet.getInt("dp"));
						counts_hash.put(resultSet.getString(1)+"totSchemes", resultSet.getInt("totSchemes"));
						counts_hash.put(resultSet.getString(1)+"notWorking", resultSet.getInt("notWorking"));
						counts_hash.put(resultSet.getString(1)+"seasonal", resultSet.getInt("seasonal"));
						counts_hash.put(resultSet.getString(1)+"driedCondemned", resultSet.getInt("driedCondemned"));
						counts_hash.put(resultSet.getString(1)+"source", resultSet.getInt("source"));
						counts_hash.put(resultSet.getString(1)+"headWorks", resultSet.getInt("headWorks"));
						counts_hash.put(resultSet.getString(1)+"pipeline", resultSet.getInt("pipeline"));
						counts_hash.put(resultSet.getString(1)+"srreservoirs", resultSet.getInt("srreservoirs"));
						counts_hash.put(resultSet.getString(1)+"pumping", resultSet.getInt("pumping"));
						counts_hash.put(resultSet.getString(1)+"others", resultSet.getInt("others"));
						counts_hash.put(resultSet.getString(1)+"throughOtherSchemes", resultSet.getInt("throughOtherSchemes")); 
						counts_hash.put(resultSet.getString(1)+"altDp", resultSet.getInt("altDp"));
						counts_hash.put(resultSet.getString(1)+"transportation", resultSet.getInt("transportation"));
						counts_hash.put(resultSet.getString(1)+"hiringOfSource", resultSet.getInt("hiringOfSource"));
						counts_hash.put(resultSet.getString(1)+"altMeasures", resultSet.getInt("altMeasures"));
					}
				}
				statement.close();
				resultSet.close();
				int sno = 1;

				int styleCount = 0;
				String style = "";

				String query = "";
				String whereCondition="";
				int cpwsTot=0,pwsTot=0,mpwsTot=0,dpTot=0,totalSchemesTot=0,notWorkingTot=0,seasonalTot=0,driedCondemnedTot=0,sourceTot=0,headWorksTot=0,pipelineTot=0,srreservoirsTot=0,pumpingTot=0,othersTot=0,throughOtherSchemesTot=0,altDpTot=0,transportationTot=0,hiringOfSourceTot=0,altMeasuresTot=0;
				
				try {
					if(mode.equals("mandal")){
						query = "select mcode,mname from rws_mandal_tbl  where dcode='"+dcode+"' order by mcode";
					}
					else if(mode.equals("panchayat")){
						query = "select pcode,pname from rws_panchayat_tbl where  dcode='"+dcode+"' and mcode='"+mcode+"' order by mcode";
					}
					else{
						query = "select dcode,dname from rws_district_tbl ";
						if(!dcode.equals("")){
							query+=" where dcode='"+dcode+"'";
						}
						query+="order by dcode";
					}
					stmt = conn.createStatement();
					rs = stmt.executeQuery(query);
					while (rs.next()) {
						int cpws=0,pws=0,mpws=0,dp=0,totalSchemes=0,notWorking=0,seasonal=0,driedCondemned=0,source=0,headWorks=0,pipeline=0,srreservoirs=0,pumping=0,others=0,throughOtherSchemes=0,altDp=0,transportation=0,hiringOfSource=0,altMeasures=0;
						if(mode.equals("panchayat")){
							pname=rs.getString("pname");
							pcode=rs.getString("pcode");
							//whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' and substr(a.hab_code,13,2)='"+pcode+"' ";
						}
						else if(mode.equals("mandal")){
							mname=rs.getString("mname");
							mcode=rs.getString("mcode");
							//whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' ";
						}
						else{
							dname=rs.getString("dname");
							dcode=rs.getString("dcode");
							//whereCondition=" substr(a.hab_code,1,2)='"+dcode+"' ";
						}
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						
						if(mode.equals("mandal")){
							if((Integer)counts_hash.get(dcode+mcode+"cpws")!=null)
								cpws=(Integer)counts_hash.get(dcode+mcode+"cpws");
							else
								cpws=0;
							if((Integer)counts_hash.get(dcode+mcode+"pws")!=null)
								pws=(Integer)counts_hash.get(dcode+mcode+"pws");
							else
								pws=0;
							if((Integer)counts_hash.get(dcode+mcode+"mpws")!=null)
								mpws=(Integer)counts_hash.get(dcode+mcode+"mpws");
							else
								mpws=0;
							if((Integer)counts_hash.get(dcode+mcode+"dp")!=null)
								dp=(Integer)counts_hash.get(dcode+mcode+"dp");
							else
								dp=0;
							if((Integer)counts_hash.get(dcode+mcode+"totSchemes")!=null)
								totalSchemes=(Integer)counts_hash.get(dcode+mcode+"totSchemes");
							else
								totalSchemes=0;
							if((Integer)counts_hash.get(dcode+mcode+"notWorking")!=null)
								notWorking=(Integer)counts_hash.get(dcode+mcode+"notWorking");
							else
								notWorking=0;
							if((Integer)counts_hash.get(dcode+mcode+"seasonal")!=null)
								seasonal=(Integer)counts_hash.get(dcode+mcode+"seasonal");
							else
								seasonal=0;
							if((Integer)counts_hash.get(dcode+mcode+"driedCondemned")!=null)
								driedCondemned=(Integer)counts_hash.get(dcode+mcode+"driedCondemned");
							else
								driedCondemned=0;
							if((Integer)counts_hash.get(dcode+mcode+"source")!=null)
								source=(Integer)counts_hash.get(dcode+mcode+"source");
							else
								source=0;
							if((Integer)counts_hash.get(dcode+mcode+"headWorks")!=null)
								headWorks=(Integer)counts_hash.get(dcode+mcode+"headWorks");
							else
								headWorks=0;
							if((Integer)counts_hash.get(dcode+mcode+"pipeline")!=null)
								pipeline=(Integer)counts_hash.get(dcode+mcode+"pipeline");
							else
								pipeline=0;
							if((Integer)counts_hash.get(dcode+mcode+"srreservoirs")!=null)
								srreservoirs=(Integer)counts_hash.get(dcode+mcode+"srreservoirs");
							else
								srreservoirs=0;
							if((Integer)counts_hash.get(dcode+mcode+"pumping")!=null)
								pumping=(Integer)counts_hash.get(dcode+mcode+"pumping");
							else
								pumping=0;
							if((Integer)counts_hash.get(dcode+mcode+"others")!=null)
								others=(Integer)counts_hash.get(dcode+mcode+"others");
							else
								others=0;
							if((Integer)counts_hash.get(dcode+mcode+"throughOtherSchemes")!=null)
								throughOtherSchemes=(Integer)counts_hash.get(dcode+mcode+"throughOtherSchemes");
							else
								throughOtherSchemes=0;
							if((Integer)counts_hash.get(dcode+mcode+"altDp")!=null)
								altDp=(Integer)counts_hash.get(dcode+mcode+"altDp");
							else
								altDp=0;
							if((Integer)counts_hash.get(dcode+mcode+"transportation")!=null)
								transportation=(Integer)counts_hash.get(dcode+mcode+"transportation");
							else
								transportation=0;
							if((Integer)counts_hash.get(dcode+mcode+"hiringOfSource")!=null)
								hiringOfSource=(Integer)counts_hash.get(dcode+mcode+"hiringOfSource");
							else
								hiringOfSource=0;
							if((Integer)counts_hash.get(dcode+mcode+"altMeasures")!=null)
								altMeasures=(Integer)counts_hash.get(dcode+mcode+"altMeasures");
							else
								altMeasures=0;
							
						}else if(mode.equals("panchayat")){
							if((Integer)counts_hash.get(dcode+mcode+pcode+"cpws")!=null)
								cpws=(Integer)counts_hash.get(dcode+mcode+pcode+"cpws");
							else
								cpws=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"pws")!=null)
								pws=(Integer)counts_hash.get(dcode+mcode+pcode+"pws");
							else
								pws=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"mpws")!=null)
								mpws=(Integer)counts_hash.get(dcode+mcode+pcode+"mpws");
							else
								mpws=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"dp")!=null)
								dp=(Integer)counts_hash.get(dcode+mcode+pcode+"dp");
							else
								dp=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"totSchemes")!=null)
								totalSchemes=(Integer)counts_hash.get(dcode+mcode+pcode+"totSchemes");
							else
								totalSchemes=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"notWorking")!=null)
								notWorking=(Integer)counts_hash.get(dcode+mcode+pcode+"notWorking");
							else
								notWorking=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"seasonal")!=null)
								seasonal=(Integer)counts_hash.get(dcode+mcode+pcode+"seasonal");
							else
								seasonal=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"driedCondemned")!=null)
								driedCondemned=(Integer)counts_hash.get(dcode+mcode+pcode+"driedCondemned");
							else
								driedCondemned=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"source")!=null)
								source=(Integer)counts_hash.get(dcode+mcode+pcode+"source");
							else
								source=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"headWorks")!=null)
								headWorks=(Integer)counts_hash.get(dcode+mcode+pcode+"headWorks");
							else
								headWorks=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"pipeline")!=null)
								pipeline=(Integer)counts_hash.get(dcode+mcode+pcode+"pipeline");
							else
								pipeline=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"srreservoirs")!=null)
								srreservoirs=(Integer)counts_hash.get(dcode+mcode+pcode+"srreservoirs");
							else
								srreservoirs=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"pumping")!=null)
								pumping=(Integer)counts_hash.get(dcode+mcode+pcode+"pumping");
							else
								pumping=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"others")!=null)
								others=(Integer)counts_hash.get(dcode+mcode+pcode+"others");
							else
								others=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"throughOtherSchemes")!=null)
								throughOtherSchemes=(Integer)counts_hash.get(dcode+mcode+pcode+"throughOtherSchemes");
							else
								throughOtherSchemes=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"altDp")!=null)
								altDp=(Integer)counts_hash.get(dcode+mcode+pcode+"altDp");
							else
								altDp=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"transportation")!=null)
								transportation=(Integer)counts_hash.get(dcode+mcode+pcode+"transportation");
							else
								transportation=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"hiringOfSource")!=null)
								hiringOfSource=(Integer)counts_hash.get(dcode+mcode+pcode+"hiringOfSource");
							else
								hiringOfSource=0;
							if((Integer)counts_hash.get(dcode+mcode+pcode+"altMeasures")!=null)
								altMeasures=(Integer)counts_hash.get(dcode+mcode+pcode+"altMeasures");
							else
								altMeasures=0;
						}else{
							if((Integer)counts_hash.get(dcode+"cpws")!=null)
								cpws=(Integer)counts_hash.get(dcode+"cpws");
							else
								cpws=0;
							if((Integer)counts_hash.get(dcode+"pws")!=null)
								pws=(Integer)counts_hash.get(dcode+"pws");
							else
								pws=0;
							if((Integer)counts_hash.get(dcode+"mpws")!=null)
								mpws=(Integer)counts_hash.get(dcode+"mpws");
							else
								mpws=0;
							if((Integer)counts_hash.get(dcode+"dp")!=null)
								dp=(Integer)counts_hash.get(dcode+"dp");
							else
								dp=0;
							if((Integer)counts_hash.get(dcode+"totSchemes")!=null)
								totalSchemes=(Integer)counts_hash.get(dcode+"totSchemes");
							else
								totalSchemes=0;
							if((Integer)counts_hash.get(dcode+"notWorking")!=null)
								notWorking=(Integer)counts_hash.get(dcode+"notWorking");
							else
								notWorking=0;
							if((Integer)counts_hash.get(dcode+"seasonal")!=null)
								seasonal=(Integer)counts_hash.get(dcode+"seasonal");
							else
								seasonal=0;
							if((Integer)counts_hash.get(dcode+"driedCondemned")!=null)
								driedCondemned=(Integer)counts_hash.get(dcode+"driedCondemned");
							else
								driedCondemned=0;
							if((Integer)counts_hash.get(dcode+"source")!=null)
								source=(Integer)counts_hash.get(dcode+"source");
							else
								source=0;
							if((Integer)counts_hash.get(dcode+"headWorks")!=null)
								headWorks=(Integer)counts_hash.get(dcode+"headWorks");
							else
								headWorks=0;
							if((Integer)counts_hash.get(dcode+"pipeline")!=null)
								pipeline=(Integer)counts_hash.get(dcode+"pipeline");
							else
								pipeline=0;
							if((Integer)counts_hash.get(dcode+"srreservoirs")!=null)
								srreservoirs=(Integer)counts_hash.get(dcode+"srreservoirs");
							else
								srreservoirs=0;
							if((Integer)counts_hash.get(dcode+"pumping")!=null)
								pumping=(Integer)counts_hash.get(dcode+"pumping");
							else
								pumping=0;
							if((Integer)counts_hash.get(dcode+"others")!=null)
								others=(Integer)counts_hash.get(dcode+"others");
							else
								others=0;
							if((Integer)counts_hash.get(dcode+"throughOtherSchemes")!=null)
								throughOtherSchemes=(Integer)counts_hash.get(dcode+"throughOtherSchemes");
							else
								throughOtherSchemes=0;
							if((Integer)counts_hash.get(dcode+"altDp")!=null)
								altDp=(Integer)counts_hash.get(dcode+"altDp");
							else
								altDp=0;
							if((Integer)counts_hash.get(dcode+"transportation")!=null)
								transportation=(Integer)counts_hash.get(dcode+"transportation");
							else
								transportation=0;
							if((Integer)counts_hash.get(dcode+"hiringOfSource")!=null)
								hiringOfSource=(Integer)counts_hash.get(dcode+"hiringOfSource");
							else
								hiringOfSource=0;
							if((Integer)counts_hash.get(dcode+"altMeasures")!=null)
								altMeasures=(Integer)counts_hash.get(dcode+"altMeasures");
							else
								altMeasures=0;
						}
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<%if(mode.equals("panchayat")){%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><%=pname%></td>
				<%}else if(mode.equals("mandal")){ %>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Asset_Non_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&mode=panchayat"><%=mname%></a></td>
				<%}else{%>
				<td class="<%=style%>" class="rptValue" style="text-align: left;"><a href="Rws_Asset_Non_Functional_Status_Rpt.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mode=mandal"><%=dname%></a></td>
				<%}%>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=03&scheme=CPWS')"><%=cpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01&scheme=PWS')"><%=pws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=02&scheme=MPWS')"><%=mpws%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=09&scheme=Direct Pumping')"><%=dp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Total Schemes')"><%=totalSchemes%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working')"><%=notWorking%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Seasonal)"><%=seasonal%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Dried/Condemned')"><%=driedCondemned%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Sources&mode=source')"><%=source%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Head Works&mode=headWorks')"><%=headWorks%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working PipeLines&mode=pipeline')"><%=pipeline%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working SR Reservoirs&mode=srreservoirs')"><%=srreservoirs%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Pumping&mode=pumping')"><%=pumping%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Others&mode=others')"><%=others%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Components&mode=throughOtherSchemes')"><%=throughOtherSchemes%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Components&mode=altDp')"><%=altDp%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Components&mode=transportation')"><%=transportation%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Components&mode=hiringOfSource')"><%=hiringOfSource%></a></td>
				<td class="<%=style%>" class="rptValue" style="text-align: right;"><a href="#" onclick="viewWorks('Rws_Asset_Non_Functional_Status_Drill.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=pcode%>&dname=<%=dname%>&mname=<%=mname%>&pname=<%=pname%>&typeOfasset=01,02,03,09&scheme=Not Working Components&mode=altMeasures')"><%=altMeasures%></a></td>  
			</tr>
			<%
					cpwsTot += cpws;
					pwsTot+=pws;
					mpwsTot+=mpws;
					dpTot+=dp;
					totalSchemesTot+=totalSchemes;
					notWorkingTot+=notWorking;
					seasonalTot+=seasonal;
					driedCondemnedTot+=driedCondemned;
					sourceTot+=source;
					headWorksTot+=headWorks;
					pipelineTot+=pipeline;
					srreservoirsTot+=srreservoirs;
					pumpingTot+=pumping;
					othersTot+=others;		
					throughOtherSchemesTot+=throughOtherSchemes;
					altDpTot+=altDp;
					transportationTot+=transportation;
					hiringOfSourceTot+=hiringOfSource;	
					altMeasuresTot+=altMeasures;
				}
				rs.close();
				stmt.close();
			%>
			<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=cpwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=pwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=mpwsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=dpTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=totalSchemesTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=notWorkingTot%></td>
			    <td class=gridhdbg style="text-align: right;"><%=seasonalTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=driedCondemnedTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=sourceTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=headWorksTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=pipelineTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=srreservoirsTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=pumpingTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=othersTot%></td> 
				<td class=gridhdbg style="text-align: right;"><%=throughOtherSchemesTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=altDpTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=transportationTot%></td>
				<td class=gridhdbg style="text-align: right;"><%=hiringOfSourceTot%></td> 
				<td class=gridhdbg style="text-align: right;"><%=altMeasuresTot%></td>
			</tr>
		</table>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (conn != null)
					conn.close();
			}
		%>
	</form>
</body>
<p align=center>
	<%@ include file="/commons/rws_footer.jsp"%>
</p>