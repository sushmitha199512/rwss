<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
 <%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%@page import="java.util.*"%> 
<html:html>
<BODY>
<%
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,r1=null,r2=null,r3=null,r4=null,r5=null,r6=null;
    PreparedStatement ps1=null,ps2=null,ps3=null,ps4=null,p1=null,p2=null,p3=null,p4=null,p5=null,p6=null;
    int slno=0;
    ArrayList districts=new ArrayList();
    ArrayList svs_ohsr_list=new ArrayList();
    ArrayList svs_glsr_list=new ArrayList();
    ArrayList mvs_ohsr_list=new ArrayList();
    ArrayList mvs_glsr_list=new ArrayList();
    String svs_ohsr_stat="svs_ohsr";
    String svs_glsr_stat="svs_glsr";
    String mvs_ohsr_stat="mvs_ohsr";
    String mvs_glsr_stat="mvs_glsr";
    
    
    %>
	<table  class=gridbg1 border="1" cellspacing="0" cellpadding="0" width="60%" height="60%"
					bordercolor="#000000" style="border-collapse:collapse"   align="center" >
					<!-- <tr rowspan="1" align="center"><td  >*** REPORT  ***</td></tr>   -->
					
					<caption>
					
		<table border=0 rules=none style="border-collapse:collapse" align = "right">		
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home</td>
	<!-- <td ><a href="javascript:onclick=history.go(-1)">Back  </td> -->
	</tr>  
	</table>
	</caption>
	<td class="gridhdbg" colspan="17"><b>SR.RESERVOIRS-REPORT </b></td>
	<!--  <tr>ANDHRA PRADESH</tr> -->
	                   <!-- <tr align="center">
	
						<td rowspan="2" class=btext style="width: 8%;">S No</td>
						<td rowspan="2"class=btext align="left" >DISTRICT NAME</td>
						<td  colspan="2" class=btext>SVS</td >
						<td  colspan="2" class=btext>MVS</td >
						</tr>
						<tr>
						<td class=btext align="right">OHSR</td>
						<td class=btext align="right">GLSR</td>
						<td class=btext align="right">OHSR</td>
						<td class=btext align="right">GLSR</td>
						</tr> -->
						<tr align="center">
						<td rowspan="3" class=btext style="width: 8%;">S No</td>
						<td rowspan="3"class=btext align="center" >DISTRICT</td>
						<td  colspan="8" class=btext>SVS</td>
						<td   colspan="4" class=btext>MVS</td>
						</tr>
						<tr>
						<td  colspan="4" class=btext >OHSR</td>
						<td  colspan="4" class=btext >GLSR</td>
						<td  rowspan="2" class=btext align="right">OHSR</td>
						<td  rowspan="2" class=btext align="right">GLSR</td>
						</tr>
						<tr>
						<td class=btext align="right">PWS</td>
						<td class=btext align="right">MPWS</td>
						<td class=btext align="right">DP</td>
						<td class=btext align="right">Total</td>
						<td class=btext align="right">PWS</td>
						<td class=btext align="right">MPWS</td>
						<td class=btext align="right">DP</td>
						<td class=btext align="right">Total</td>
						</tr>
						
						
						 <%
						String districts_array[]={"ANANTAPUR","CHITTOOR","EAST GODAVARI","GUNTUR","KADAPA","KRISHNA","KURNOOL","NELLORE","PRAKASAM","SRIKAKULAM","VISAKHAPATNAM","VIZIANAGARAM","WEST GODAVARI"};
						Map map=new TreeMap();
						//int[] values =new int[]{"0","0","0","0"};
						int svs_ohsr_sum=0,svs_glsr_sum=0,mvs_ohsr_sum=0,mvs_glsr_sum=0,pws_ohsr_sum=0,mpws_ohsr_sum=0,dp_ohsr_sum=0,pws_glsr_sum=0,mpws_glsr_sum=0,dp_glsr_sum=0;
						for(String district: districts_array)
							map.put(district, new int[]{0,0,0,0,0,0,0,0,0,0});
						
						%> 
						
						
						
						<%
						//String pws_ohsr="select count(*)COUNT ,DNAME,DCODE from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('01')    group by DNAME,DCODE order by Dname";
						
						String pws_ohsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('01') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						// System.out.println("#############"+pws_ohsr);
						p1=conn.prepareStatement(pws_ohsr);
						 r1=p1.executeQuery();
						 while(r1.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r1.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[0]= r1.getInt(1);
							pws_ohsr_sum+=r1.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p1.close();
						 r1.close();%>
						 
						 
						 <%
					String mpws_ohsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('02') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 p2=conn.prepareStatement(mpws_ohsr);
						 r2=p2.executeQuery();
						 
						 while(r2.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r2.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[1]= r2.getInt(1);
							mpws_ohsr_sum+=r2.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p2.close();
						 r2.close();%>
						
						
						<%
						String dp_ohsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('09') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 p3=conn.prepareStatement(dp_ohsr);
						 r3=p3.executeQuery();
						 
						 while(r3.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r3.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[2]= r3.getInt(1);
							dp_ohsr_sum+=r3.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p3.close();
						 r3.close();%>
						
						<%
						String svs_ohsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('01','02','09') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 ps1=conn.prepareStatement(svs_ohsr);
						 rs1=ps1.executeQuery();
						 
						 while(rs1.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = rs1.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[3]= rs1.getInt(1);
							svs_ohsr_sum+=rs1.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 ps1.close();
						 rs1.close();%>
						
						 <%
							String pws_glsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('01') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 p4=conn.prepareStatement(pws_glsr);
						 r4=p4.executeQuery();
						 while(r4.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r4.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[4]= r4.getInt(1);
							pws_glsr_sum+=r4.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p4.close();
						 r4.close();%>
						
						<%
						String mpws_glsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('02') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 p5=conn.prepareStatement(mpws_glsr);
						 r5=p5.executeQuery();
						 while(r5.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r5.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[5]= r5.getInt(1);
							mpws_glsr_sum+=r5.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p5.close();
						 r5.close();%> 
						
						 <%
							String dp_glsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('09') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 p6=conn.prepareStatement(dp_glsr);
						 r6=p6.executeQuery();
						 while(r6.next())
					   {
							//districts.add(rs1.getString(2));
							//svs_ohsr_list.add(rs1.getString(1));
							
							//rs1.getString(2)
							String dName = r6.getString("DNAME");
							int[] districtResultValues = (int[])map.get(dName);
							districtResultValues[6]= r6.getInt(1);
							dp_glsr_sum+=r6.getInt(1);
							map.put(dName,districtResultValues);
							
					   }
						 p6.close();
						 r6.close();%>
						 
						
						  <%
							String svs_glsr="select count(1)COUNT ,d.DNAME, d.dcode from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t ,rws_complete_hab_view v where  a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and  a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code in ('01','02','09') and a.hab_code=v.panch_code and subcomptbl.hab_code=v.panch_code and v.coverage_status <> 'UI' group by d.DNAME,d.dcode order by d.dname";
						 ps2=conn.prepareStatement(svs_glsr);
						 rs2=ps2.executeQuery();
						 while(rs2.next())
					   {
							 //svs_glsr_list.add(rs2.getString(1));
							 String dName = rs2.getString("DNAME");
								int[] districtResultValues = (int[])map.get(dName);
								districtResultValues[7]= rs2.getInt(1);
								svs_glsr_sum+=rs2.getInt(1);
								map.put(dName,districtResultValues);
							 
						} 
						 ps2.close();
						 rs2.close();
						%> 
						
						<%
						String mvs_ohsr="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code='03' group by DNAME,DCODE order by Dname";
						 ps3=conn.prepareStatement(mvs_ohsr);
						 rs3=ps3.executeQuery();
						 while(rs3.next())
					   {
							//mvs_ohsr_list.add(rs3.getString(1));
							 String dName = rs3.getString("DNAME");
								int[] districtResultValues = (int[])map.get(dName);
								districtResultValues[8]= rs3.getInt(1);
								mvs_ohsr_sum+=rs3.getInt(1);
								map.put(dName,districtResultValues);
						
						
					   } ps3.close();
						 rs3.close();%>
					   
					   
					   <%
						String mvs_glsr="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code    and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and a.type_of_asset_code=t.type_of_asset_code  and a.type_of_asset_code='03' group by DNAME,DCODE order by Dname";
						 ps4=conn.prepareStatement(mvs_glsr);
						 rs4=ps4.executeQuery();
						 while(rs4.next())
					   {
							 //mvs_glsr_list.add(rs4.getString(1));
							 String dName = rs4.getString("DNAME");
								int[] districtResultValues = (int[])map.get(dName);
								districtResultValues[9]= rs4.getInt(1);
								mvs_glsr_sum+=rs4.getInt(1);
								map.put(dName,districtResultValues);
							 
						} 
						 ps4.close();
						 rs4.close();
						%> 
						
						 <%
						//Traversing Map  
					    Set set=map.entrySet();//Converting to Set so that we can traverse  
					    Iterator itr=set.iterator();  
					    while(itr.hasNext()){  
					        //Converting to Map.Entry so that we can get key and value separately  
					        Map.Entry entry=(Map.Entry)itr.next(); 
					        int[] res_array=(int[])entry.getValue();
					        %>
						
						<tr >
							<td   style="text-align: right;"><%=++slno%></td>
							<td   style="text-align: left;"><%=entry.getKey()%></td>
							<td   style="text-align: right;" ><%=res_array[0]%></td>
							<td   style="text-align: right;" ><%=res_array[1]%></td>
							<td   style="text-align: right;" ><%=res_array[2]%></td>
                           <td  style="text-align: right;" style="font-weight:bold"><a href="division_wise_components_list.jsp?id=<%=entry.getKey()%>&scode=<%=svs_ohsr_stat%>"><%=res_array[3]%></a></td>						    
				           <td   style="text-align: right;" ><%=res_array[4]%></td>
							<td   style="text-align: right;" ><%=res_array[5]%></td>
							<td   style="text-align: right;" ><%=res_array[6]%></td>
				           <td  style="text-align: right;" style="font-weight:bold"><a href="division_wise_components_list.jsp?id=<%=entry.getKey()%>&scode=<%=svs_glsr_stat%>"><%=res_array[7]%></a></td>				
						   <td  style="text-align: right;" style="font-weight:bold"><a href="division_wise_components_list.jsp?id=<%=entry.getKey()%>&scode=<%=mvs_ohsr_stat%>"><%=res_array[8]%></a></td>						    
						<td  style="text-align: right;" style="font-weight:bold"><a href="division_wise_components_list.jsp?id=<%=entry.getKey()%>&scode=<%=mvs_glsr_stat%>"><%=res_array[9]%></a></td>
						</tr>
						
						<% }%> 
							
						 <tr>
							<td   style="text-align: right;"></td>
							<td   style="text-align: left;" style="font-weight:bold">TOTAL</td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_ohsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_ohsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_ohsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=svs_ohsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=pws_glsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=mpws_glsr_sum%></td>
							<td   style="text-align: right;" style="font-weight:bold"><%=dp_glsr_sum%></td>
						    <td   style="text-align: right;" style="font-weight:bold"><%=svs_glsr_sum%></td>
						    <td   style="text-align: right;" style="font-weight:bold"><%=mvs_ohsr_sum%></td>
						    <td   style="text-align: right;" style="font-weight:bold"><%=mvs_glsr_sum%></td>
							</tr> 			
						
						</table>
						<font color="red" face="verdana" size="2">Note: Assets Which are having components are displayed<br/>Un Identified(UI) Habitations are not displayed</font>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>
</BODY>
</html:html>