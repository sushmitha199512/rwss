<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.util.*"%>
<%
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());

	StringBuffer dcode =new StringBuffer();
	dcode.append(request.getParameter("district"));
	session.setAttribute("dcode", dcode);
	
	StringBuffer dname=new StringBuffer();
	dname.append(request.getParameter("dname"));
	
	session.setAttribute("dname", dname);
	//Systemout.println("d" + dcode);
	
	StringBuffer myphase=new StringBuffer();
	 myphase.append("1");// request.getParameter("myphase");
	session.setAttribute("myphase", myphase);
%>
<html>
<body>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
<%//1 PROJECTS (mvs)
//2 NORMAL   (svs)
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				<td ><a href="./Rws_Ntr_Sujala_Patakam_Abs_Excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" ><a href="#" onclick="window.close()">Close</td></tr>
<%} %>
		</table>
	</caption>
	</table>
	
<table  cellspacing=0 cellpadding=0 width="80%"	 style="border-collapse: collapse" 	align="center">
<tr>
			<td align="center" class="gridhdbg" colspan=21>Sujala Patakam -Phase I Abstract &nbsp;&nbsp;All Districts&nbsp; </td>
	</tr>
	 <tr align="center" >
     <td rowspan=2 class="gridhdbg">SlNo</td>
     <td rowspan=2 class="gridhdbg">District</td>
    <td rowspan=2 class="gridhdbg">No. of Habitations Selected </td>
     <td rowspan=2 class="gridhdbg">Surface Water Based Habitations  </td>
     <td rowspan=2 class="gridhdbg">Ground Water Based Habitations</td>
     <td colspan=3 class="gridhdbg">Schemes Type</td>
     <td rowspan=2 class="gridhdbg">Hand Pumps</td>
     <td rowspan=2 class="gridhdbg">Shallow Hand Pumps</td>
     <td rowspan=2 class="gridhdbg">Direct Pumping</td>
     <td rowspan=2 class="gridhdbg">Open Wells</td>
     <td rowspan=2 class="gridhdbg">Ponds</td>      
     <td colspan=6 class="gridhdbg">No of Plants</td>
     <td rowspan=2 class="gridhdbg">Corporate Houses/ NGOs identified</td>  
     <td rowspan=2 class="gridhdbg">Type Of Plant Installed</td> 		
</tr>
<tr align="center" >
       <td class="gridhdbg">CPWS</td>
       <td class="gridhdbg">PWS</td>
       <td class="gridhdbg">MPWS</td>
       <td class="gridhdbg">RO</td> 
       <td class="gridhdbg">UV</td>
       <td class="gridhdbg">Ultra/ Gravity</td>   
       <td class="gridhdbg">EDF</td> 
       <td class="gridhdbg">Terafil</td>
       <td class="gridhdbg">UV/ Chlorination</td>
        
</tr>
<tr align="center"  class="gridhdbg">
<%
for(int k=1;k<22;k++)
{
%>
<td > <%=k %>  </td>


<%} %>

</tr>
<tr>
<%
Statement stmt1=null , stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
int tot1=0,tot2=0,tot3=0,tot4=0,tot5=0,tot6=0,tot7=0,tot8=0,tot9=0,tot10=0,tot11=0,tot12=0,tot13=0,tot14=0,tot15=0,tot16=0,tot17=0,tot18=0,tot19=0;
int count=1;
int styleCount=0;
StringBuffer style=new StringBuffer();
StringBuffer query=new StringBuffer();
StringBuffer sourceValues=null;
StringBuffer othValues=null;
StringBuffer shpValues=null;
StringBuffer hpValues =null;
StringBuffer owValues=null;
StringBuffer pdValues=null;
StringBuffer schmeValues=null;




  try{
	    
	  query.delete(0, query.length());
	 // String schemecntQry = "select substr(a.hab_code,1,2),sum(case when  d.type_of_asset_code='01' then 1 else 0 end) pwscnt,sum(case when  d.type_of_asset_code='02' then 1 else 0 end) mpwscnt,sum(case when  d.type_of_asset_code='03' then 1 else 0 end) cpwscnt,sum(case when  d.type_of_asset_code='09' then 1 else 0 end) dpscnt from rws_ntr_sujala_master_tbl a,rws_source_tbl b,rws_asset_mast_tbl c,rws_asset_type_tbl d  where a.source_code=b.source_code and b.asset_code=c.asset_code and c.type_of_asset_code=d.type_of_asset_code  group by substr(a.hab_code,1,2)";
	  query.append("select substr(a.hab_code,1,2),sum(case when substr(b.asset_code,7,2)='01' then 1 else 0 end) pwscnt,sum(case when substr(b.asset_code,7,2)='02' then 1 else 0 end) mpwscnt,sum(case when   substr(b.asset_code,7,2)='03' then 1 else 0 end) cpwscnt,sum(case when substr(b.asset_code,7,2)='09' then 1 else 0 end) dpscnt from rws_ntr_sujala_master_tbl a,rws_source_tbl b where a.source_code=b.source_code and substr(a.source_code,20,2)<>'HP' and substr(a.source_code,20,2)<>'OW' AND substr(a.source_code,20,2)<>'SH' AND substr(a.source_code,20,2)<>'PD'  group by substr(a.hab_code,1,2) order by 1");
	  //System.out.println("schemecntQry*********" + query);
	  stmt2=conn.createStatement();	
	  Hashtable schemecntList=new Hashtable();
	  rs2=stmt2.executeQuery(query.toString());	   	
	  while (rs2.next()) 
	  { 
		  schemecntList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
		  //Systemout.println("schemecntQry"+rs2.getString(1)+rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
	  }
	  
	  
	  session.setAttribute("schemecntList", schemecntList);
	  
	  
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  }  
	  
		  query.delete(0, query.length());
	  query.append("select substr(a.hab_code,1,2),count(1) from rws_ntr_sujala_master_tbl a,RWS_OPENWELL_POND_TBL b  where substr(a.source_code,20,2)='PD' and a.source_code=b.POND_CODE   group by substr(a.hab_code,1,2) order by 1");
	  //Systemout.println("pdcnt*********" + pdcntQry);
	  stmt2=conn.createStatement();	
	  Hashtable pdcntList=new Hashtable();
	  rs2=stmt2.executeQuery(query.toString());	   	
	  while (rs2.next()) 
	  { 
		  pdcntList.put(rs2.getString(1),rs2.getString(2));
		  //Systemout.println("pdcntList"+rs2.getString(1)+rs2.getString(5));
	  }
		session.setAttribute("pdcntList", pdcntList);
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  }  
	  
	  
	  
		  query.delete(0, query.length());
		  query.append("select substr(a.hab_code,1,2),count(1) from rws_ntr_sujala_master_tbl a,RWS_OPEN_WELL_MAST_TBL b  where substr(a.source_code,20,2)='OW' and a.source_code=b.OPENWELL_CODE   group by substr(a.hab_code,1,2) order by 1");
	  //Systemout.println("owcnt*********" + owcntQry);
	  stmt2=conn.createStatement();	
	  Hashtable owcntList=new Hashtable();
	  rs2=stmt2.executeQuery(query.toString());	   	
	  while (rs2.next()) 
	  { 
		  owcntList.put(rs2.getString(1),rs2.getString(2));
		  //Systemout.println("owcntList"+rs2.getString(1)+rs2.getString(5));
	  }
		session.setAttribute("owcntList", owcntList);
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  }  
	  
		  query.delete(0, query.length());
		  query.append("select substr(a.hab_code,1,2),count(1) from rws_ntr_sujala_master_tbl a,RWS_SHALLOWHANDPUMPS_TBL b  where substr(a.source_code,20,2)='SH' and a.source_code=b.SHALLOWHP_CODE   group by substr(a.hab_code,1,2) order by 1");
	  //System.out.println("shpscnt*********" + query);
	  stmt2=conn.createStatement();	
	  Hashtable shpscntList=new Hashtable();
	  rs2=stmt2.executeQuery(query.toString());	   	
	  while (rs2.next()) 
	  { 
		  shpscntList.put(rs2.getString(1),rs2.getString(2));
		  //Systemout.println("shpscnt"+rs2.getString(1)+rs2.getString(5));
	  }
		session.setAttribute("shpscntList", shpscntList);
		 if(stmt2!=null)
		  {
			  stmt2.close();
		   }
		  if(rs2!=null)
		  {
			  rs2.close();
		  }   
		  
		  query.delete(0, query.length());
		  query.append("select substr(a.hab_code,1,2),count(1) from rws_ntr_sujala_master_tbl a,rws_hp_subcomp_param_tbl b  where substr(a.source_code,20,2)='HP' and a.source_code=b.HP_CODE  group by substr(a.hab_code,1,2) order by 1");
		  //System.out.println("hpscnt*********" + query);
		  stmt2=conn.createStatement();	
		  Hashtable hpscntList=new Hashtable();
		  rs2=stmt2.executeQuery(query.toString());	   	
		  while (rs2.next()) 
		  { 
			  hpscntList.put(rs2.getString(1),rs2.getString(2));
			  //Systemout.println("hpscnt"+rs2.getString(1)+rs2.getString(5));
		  }
			session.setAttribute("hpscntList", hpscntList);
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  }   
				  
		    
			  query.delete(0, query.length());
			  query.append("select substr(a.hab_code,1,2),sum(case when substr(a.source_code,20,2)='HP' then 1 else 0 end) hpcnt,sum(case when substr(a.source_code,20,2)='SH' then 1 else 0 end) shcnt ,sum(case when substr(a.source_code,20,2)='OW' then 1 else 0 end) owcnt,sum(case when substr(a.source_code,20,2)='PD' then 1 else 0 end) pdcnt    from rws_ntr_sujala_master_tbl a where a.phase='"+myphase+"' group by  substr(a.hab_code,1,2)");
		  //Systemout.println("sourceDetails*********" + otherscnt);
		  stmt2=conn.createStatement();	
		  Hashtable otherscntList=new Hashtable();
		  rs2=stmt2.executeQuery(query.toString());	   	
		  while (rs2.next()) 
		  { 
			  otherscntList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5));
			  //Systemout.println(rs2.getString(1)+rs2.getString(2));
		  }
			session.setAttribute("otherscntList", otherscntList);
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 
		  
			  query.delete(0, query.length());
			  query.append("select substr(b.hab_code,1,2),sum(case when a.source_type_code='2' then 1 else 0 end) subsurfacecnt,sum(case when a.source_type_code='1' then 1 else 0 end) surfacecnt from rws_source_tbl a,rws_ntr_sujala_master_tbl b where substr(a.source_code,20,2)<>'HP' and a.source_code=b.source_code and  b.phase='"+myphase+"' group by  substr(b.hab_code,1,2) order by substr(b.hab_code,1,2)");
		    //Systemout.println("sourceDetails*********" + sourceDetails);
		    stmt2=conn.createStatement();	
		    Hashtable sourceDetailsList=new Hashtable();
		    rs2=stmt2.executeQuery(query.toString());	   	
			while (rs2.next()) 
			{ 
				
				sourceDetailsList.put(rs2.getString(1),rs2.getString(2)+"@"+rs2.getString(3));
				//System.out.println(rs2.getString(2)+"@"+rs2.getString(3));
			}
				session.setAttribute("sourceDetailsList", sourceDetailsList);
			 if(stmt2!=null)
			  {
				  stmt2.close();
			   }
			  if(rs2!=null)
			  {
				  rs2.close();
			  } 	  
		  	  
		  
		  
		  
		  
			  query.delete(0, query.length());
	//////////////////main/////////////////////	
	query.append("select distinct dcode,dname,count(distinct b.hab_code),sum(case when b.TYPE_OF_PLANT ='ROPLANT' then 1 else 0 end) RO,sum(case when b.TYPE_OF_PLANT ='UV' then 1 else 0 end)UV,sum(case when b.TYPE_OF_PLANT ='Ultra Gravity' then 1 else 0 end)UG,sum(case when b.TYPE_OF_PLANT ='EDF' then 1 else 0 end)edf,sum(case when b.TYPE_OF_PLANT ='TERAFIL' then 1 else 0 end)Terafil,sum(case when b.TYPE_OF_PLANT ='UV/ CHLORINATION' or b.TYPE_OF_PLANT ='UV/ Chlorination' then 1 else 0 end) UV ,sum(case when b.TAKE_PROGRAMME_VOL ='Y' then 1 else 0 end)cohouse  from rws_district_tbl a ,rws_ntr_sujala_master_tbl b where a.dcode=substr(b.hab_code,1,2) and phase='"+myphase+"' group by a.dcode,a.dname");
	  System.out.println("query:"+query);
	  stmt1=conn.createStatement();
	  rs1=stmt1.executeQuery(query.toString());
	  int surcnt=0,subsurcnt=0,hpcnt=0,dpcnt=0,shcnt=0,pdcnt=0,owcnt=0;
	  String sourceList[]=null;
	  String othList[]=null;
	  String shpList[]=null;
	  String hpList[]=null;
	  String dpList[]=null;
	  String pdList[]=null;
	  String owList[]=null;
	  String schemeList[]=null;
	  
	  
	  sourceValues =new StringBuffer();
	  othValues=new StringBuffer();
	  shpValues=new StringBuffer();
	  hpValues =new StringBuffer();
	  owValues=new StringBuffer();
	  pdValues=new StringBuffer();
	  schmeValues=new StringBuffer();
	  
	  int shptypecnt=0,hptypecnt=0,owtypecnt=0,dptypecnt=0,pdtypecnt=0,cpwscnt=0,pwscnt=0,mpwscnt=0;
	   	while(rs1.next())
	  	{
	  	
	  		/* String assetValues=(String)assetDetailsList.get(rs1.getString(1));
	  		String cntList[]=assetValues.split("@");
	  		 */
	  		 int totplantsInst=0;
	  		 String queryplants="select count(PLANT_TYPE_INSTALLED) from  RWS_NTR_SUJALA_HAB_IMPL_TBL where  substr(HABITATION_CODE,1,2)='"+rs1.getString(1)+"' ";
	  		 //System.out.println("queryplants"+queryplants);
	  		 Statement statement=conn.createStatement();
	  		 ResultSet resultSet=statement.executeQuery(queryplants);
	  		 if(resultSet.next()){
	  			 System.out.println(resultSet.getInt(1));
	  			totplantsInst=resultSet.getInt(1);
	  		 }
	  		
	  		if(sourceDetailsList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			
	  			sourceValues.delete(0, sourceValues.length());
	  			sourceValues.append(sourceDetailsList.get(rs1.getString(1)));
	  		 //String sourceValues=(String)sourceDetailsList.get(rs1.getString(1));
	  		 sourceList=sourceValues.toString().split("@");
	  		 surcnt=Integer.parseInt(sourceList[0]);
	  		 subsurcnt=Integer.parseInt(sourceList[1]);
	  		}
	  		else
	  		{
	  			surcnt=0;
	  			subsurcnt=0;
	  		}
	  		
	  		if(otherscntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			othValues.delete(0, othValues.length());
	  		othValues.append(otherscntList.get(rs1.getString(1)));
	  		 othList=othValues.toString().split("@");
	  		 hpcnt=Integer.parseInt(othList[0]);
	  		 shcnt=Integer.parseInt(othList[1]);
	  		 owcnt=Integer.parseInt(othList[2]);
	  		 pdcnt=Integer.parseInt(othList[3]);
	  		 //dpcnt=Integer.parseInt(othList[4]);
	  		}
	  		else
	  		{
	  			 hpcnt=0;
		  		 shcnt=0;
		  		 owcnt=0;
		  		 pdcnt=0;
		  		 dpcnt=0;
	  		}
	  		
	  		
	  		if(shpscntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			
	  			shpValues.delete(0, shpValues.length());
	  		 shpValues.append(shpscntList.get(rs1.getString(1)));
	  		 shpList=shpValues.toString().split("@");
	  		 shptypecnt=Integer.parseInt(shpList[0]);
	  		 
	  		}
	  		else
	  		{
	  			shptypecnt=0;
	  			
	  		}	
	  		
	  		if(hpscntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			
	  			hpValues.delete(0, hpValues.length());
	  	hpValues.append(hpscntList.get(rs1.getString(1)));
	  		 hpList=hpValues.toString().split("@");
	  		 hptypecnt=Integer.parseInt(hpList[0]);
	  		 
	  		}
	  		else
	  		{
	  			hptypecnt=0;
	  			
	  		}
	  		
	  		if(owcntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			 
	  			 
	  			owValues.delete(0, owValues.length());
	  		owValues.append(owcntList.get(rs1.getString(1)));
	  		 owList=owValues.toString().split("@");
	  		 owtypecnt=Integer.parseInt(owList[0]);
	  		 
	  		}
	  		else
	  		{
	  			owtypecnt=0;
	  			
	  		}
	  		  		
	  		
	  		if(pdcntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			
	  			 
	  			pdValues.delete(0, pdValues.length());
	  		 pdValues.append(pdcntList.get(rs1.getString(1)));
	  		 pdList=pdValues.toString().split("@");
	  		 pdtypecnt=Integer.parseInt(pdList[0]);
	  		 
	  		}
	  		else
	  		{
	  			pdtypecnt=0;
	  			
	  		}
	  		
	  		
	  		if(schemecntList.get(rs1.getString(1))!=null)
	  		{
	  			
	  			
	  			schmeValues.delete(0, schmeValues.length());
	  	 schmeValues.append(schemecntList.get(rs1.getString(1)));
	  		 schemeList=schmeValues.toString().split("@");
	  		 pwscnt=Integer.parseInt(schemeList[0]);
	  		 mpwscnt=Integer.parseInt(schemeList[1]);
	  		 cpwscnt=Integer.parseInt(schemeList[2]);
	  		 dptypecnt=Integer.parseInt(schemeList[3]);
	  		 
	  		 }
	  		else
	  		{
	  			 pwscnt=0;
		  		 mpwscnt=0;
		  		 cpwscnt=0;
		  		 dptypecnt=0;
	  			
	  		}
	  		
	  		
	  		
	  			
	  	int totsubsurcnt=subsurcnt+hpcnt+shcnt+owcnt+pdcnt+dpcnt;
	  	

  		style.delete(0, style.length());
  		if(styleCount%2==0){
  			 style.append("gridbg1");
  		}else{
  			 style.append("gridbg2");
  		}
  		styleCount++;
		%>
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++%></td>
		    <td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
		    <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(3)%></td>
		    
		    <td class=<%=style %> style="text-align: right;"><%=surcnt%></td>
		    <td class=<%=style %> style="text-align: right;"><%=totsubsurcnt%></td>
	        <td class=<%=style %> style="text-align: right;"><%=cpwscnt%></td>		
	        <td class=<%=style %> style="text-align: right;"><%=pwscnt%></td>
	        <td class=<%=style %> style="text-align: right;"><%=mpwscnt%></td>
		    <td class=<%=style %> style="text-align: right;"><%=hptypecnt%></td>
	        <td class=<%=style %> style="text-align: right;"><%=shptypecnt %></td>		   
		    <td class=<%=style %> style="text-align: right;"><%=dptypecnt%></td>
		    <td class=<%=style %> style="text-align: right;"><%=owtypecnt %></td>
		    <td class=<%=style %> style="text-align: right;"><%=pdtypecnt %></td>
		    <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(4)%></td>	       
	        <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(5)%></td>
	        <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(6)%></td>
	        <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(7)%></td>
		    <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(8)%></td>
		    <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(9)%></td>     
	        <td class=<%=style %> style="text-align: right;"><%=rs1.getInt(10)%></td>
	        <td class=<%=style %> style="text-align: right;"><%=totplantsInst%></td>
		   
       </tr>

		<%
		tot1+=rs1.getInt(3);
		tot2+=surcnt;
		tot3+=totsubsurcnt;
		tot4+=cpwscnt;
		tot5+=pwscnt;
		tot6+=mpwscnt;
		tot7+=hptypecnt;
		tot8+=shptypecnt;
		tot9+=dptypecnt;
		tot10+=owtypecnt;
		tot11+=pdtypecnt;
		tot12+=rs1.getInt(4);
		tot13+=rs1.getInt(5);
		tot14+=rs1.getInt(6);
		tot15+=rs1.getInt(7);
		tot16+=rs1.getInt(8);
		tot17+=rs1.getInt(9);
		tot18+=rs1.getInt(10);	
		tot19+=totplantsInst;
		
		
		
	  	}
	  
	   	%>
	   	
	   	
	   	<tr>
	   	<td class=gridhdbg style="text-align: center;" colspan=2>Total</td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot1 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot2 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot3 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot4 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot5 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot6 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot7 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot8 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot9 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot10 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot11 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot12 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot13 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot14 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot15 %></td>
	    <td class=gridhdbg style="text-align: right;"><%=tot16 %></td>
	   	<td class=gridhdbg style="text-align: right;"><%=tot17 %></td>
	    <td class=gridhdbg style="text-align: right;"><%=tot18 %></td>
	    <td class=gridhdbg style="text-align: right;"><%=tot19 %></td>
	   	</tr>
	   	
	 <% 
	 if(stmt1!=null)
	  {
		  stmt1.close();
	   }
	  if(rs1!=null){
		  rs1.close();
		  	  }
	  
	  

}catch(Exception e){
  e.printStackTrace();
}
  finally{
	  
	  
	   sourceValues=null;
 othValues=null;
 shpValues=null;
 hpValues =null;
 owValues=null;
 pdValues=null;
 schmeValues=null;
 style=null;
 query=null;
 dcode=null;
 dname=null;
 myphase=null;
	  
  }

%>

</table>	

	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>