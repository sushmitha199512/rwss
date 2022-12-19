<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function viewWorks(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:550,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
}

</script>

<form>
<%
 
String dcode=request.getParameter("dcode");
//System.out.println("dcode"+dcode);
String dname=request.getParameter("dname");
//System.out.println("dname"+dname);
String mcode=request.getParameter("mcode");
//System.out.println("mcode"+mcode);
String mname=request.getParameter("mname");
//System.out.println("mname"+mname);
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
DecimalFormat ndf = new DecimalFormat("####.##");


    String qry="";
    int styleCount=0;
    String style="";

    
    
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
	<td class="btext">
Mandal:</td><td class="rptvalue"><%=mname%></td>
</tr>
  
	</table>
	</caption>
	<tr >
	<td align="center" class="rptHeading" >Panchayat Wise Habitation Status Report</td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
    <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	
    <td class=gridhdbg rowspan=2>Pancahayat Name</td>
    <td class=gridhdbg rowspan=1 colspan="6">Habitations</td>
    <td class=gridhdbg rowspan=1 colspan="8">Assets</td>
    
	
	
       </tr>
	<tr>
	
	<td class=gridhdbg>FC</td>
    <td class=gridhdbg>PC4</td>
    <td class=gridhdbg>PC3</td>
    <td class=gridhdbg>PC2</td>
    <td class=gridhdbg>PC1</td>
    <td class=gridhdbg>QA</td>
    <td class=gridhdbg>MVS Habitations</td>
    <td class=gridhdbg>MVS</td>
     <td class=gridhdbg>SVS Habitations</td>
	<td class=gridhdbg>SVS</td>
	 <td class=gridhdbg>DP/HP/SHP Habitations</td>
	<td class=gridhdbg>DP/HP/SHP</td>
	 <td class=gridhdbg>Other Habitations</td>
	<td class=gridhdbg>Others</td>
    
    
	</tr>
	
       
<%
try
{
	


	   //main qry
	   Statement stmt8=null;
	   ResultSet rs8=null;
	   int sno=1;
	   stmt8=conn.createStatement();
	   
	   int totalfc=0,totpc4=0,totpc3=0,totpc2=0,totpc1=0,totqa=0,totmvs=0,totsvs=0,totdhs=0,totothers=0,totmvshabs=0,totsvshabs=0,totdphabs=0,totothershabs=0;
	   Double toiletcost=0.0;
	   
	  
	  ///////////query for mvs///
	  qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='03' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
	   Statement	stmt80=conn.createStatement();
		//System.out.println("qry mvs:"+qry);
		ResultSet rs80=stmt80.executeQuery(qry);
		Hashtable mvs=new Hashtable();
			while(rs80.next())
		{
				mvs.put(rs80.getString(2),rs80.getString(1));
				
		}
			
		
			/////query for pws///
			
			qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='01' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
			
			// qry="select sum(case when type_of_asset_code='01' or type_of_asset_code='02' then 1 else 0 end),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where  a.asset_code=b.asset_code group by substr(a.hab_code,1,2) ";
			   Statement	stmt81=conn.createStatement();
				//System.out.println("schoolcount0:"+schoolcount0);
				ResultSet rs81=stmt81.executeQuery(qry);
				Hashtable svs=new Hashtable();
					while(rs81.next())
				{
						svs.put(rs81.getString(2),rs81.getString(1));
				}
					
					////query  for mpws/
					
					
					qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='02' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
			
			// qry="select sum(case when type_of_asset_code='01' or type_of_asset_code='02' then 1 else 0 end),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where  a.asset_code=b.asset_code group by substr(a.hab_code,1,2) ";
			   Statement	stmt90=conn.createStatement();
				//System.out.println("schoolcount0:"+schoolcount0);
				ResultSet rs90=stmt90.executeQuery(qry);
				Hashtable mpws=new Hashtable();
					while(rs90.next())
				{
						mpws.put(rs90.getString(2),rs90.getString(1));
				}
					
					/////query for SHALLOW HAND PUMPS
	   
					qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='05' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"' group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
					// qry="select sum(case when type_of_asset_code='04' or type_of_asset_code='05' or type_of_asset_code='09' then 1 else 0 end),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where  a.asset_code=b.asset_code group by substr(a.hab_code,1,2)";
					   Statement	stmt91=conn.createStatement();
					//	System.out.println("schoolcount0:"+schoolcount0);
						ResultSet rs91=stmt91.executeQuery(qry);
						Hashtable shp=new Hashtable();
							while(rs91.next())
						{
								shp.put(rs91.getString(2),rs91.getString(1));
						}
		//////query for handpumps///					
							
							
			qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='04' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
					// qry="select sum(case when type_of_asset_code='04' or type_of_asset_code='05' or type_of_asset_code='09' then 1 else 0 end),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where  a.asset_code=b.asset_code group by substr(a.hab_code,1,2)";
					   Statement	stmt92=conn.createStatement();
					//	System.out.println("schoolcount0:"+schoolcount0);
						ResultSet rs92=stmt92.executeQuery(qry);
						Hashtable hp=new Hashtable();
							while(rs92.next())
						{
								shp.put(rs92.getString(2),rs92.getString(1));
						}				
							
	/////query for diret pumping ///////////
					
			qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='09' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
					// qry="select sum(case when type_of_asset_code='04' or type_of_asset_code='05' or type_of_asset_code='09' then 1 else 0 end),substr(a.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where  a.asset_code=b.asset_code group by substr(a.hab_code,1,2)";
					   Statement	stmt93=conn.createStatement();
					//	System.out.println("schoolcount0:"+schoolcount0);
						ResultSet rs93=stmt93.executeQuery(qry);
						Hashtable dp=new Hashtable();
							while(rs93.next())
						{
								dp.put(rs93.getString(2),rs93.getString(1));
						}		

							
							
							 qry="select count(*),substr(hab_code,13,2) from rws_asset_mast_tbl  where type_of_asset_code='08' and  substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  group by substr(hab_code,13,2) order by substr(hab_code,13,2)";
							   Statement stmt83=conn.createStatement();
							//	System.out.println("schoolcount0:"+schoolcount0);
								ResultSet rs83=stmt83.executeQuery(qry);
								Hashtable others=new Hashtable();
									while(rs83.next())
								{
										others.put(rs83.getString(2),rs83.getString(1));
								}
									
									
									
		qry="select distinct count(b.Hab_code),substr(a.hab_code,13,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.type_of_asset_code='03' and a.asset_code=b.asset_code and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' group by substr(a.hab_code,13,2)";
		
		Statement stmt94=conn.createStatement();
		//	System.out.println("schoolcount0:"+schoolcount0);
			ResultSet rs94=stmt94.executeQuery(qry);
			Hashtable totmvsh=new Hashtable();
				while(rs94.next())
			{
					totmvsh.put(rs94.getString(2),rs94.getString(1));
			}
		
		qry="select distinct sum(case when a.type_of_asset_code='01' or a.type_of_asset_code='02' then 1 else 0 end),substr(a.hab_code,13,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.asset_code=b.asset_code  and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' group by substr(a.hab_code,13,2)";
				
			Statement stmt95=conn.createStatement();
				//	System.out.println("schoolcount0:"+schoolcount0);
			ResultSet rs95=stmt95.executeQuery(qry);
			Hashtable totsvsh=new Hashtable();
			while(rs95.next())
				{
				totsvsh.put(rs95.getString(2),rs95.getString(1));
				}
			
			
			
			qry="select count(distinct a.hab_code),substr(a.hab_code,13,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.asset_code=b.asset_code  and  a.type_of_asset_code in ('09','04','05') and substr(a.hab_code,1,2)='"+dcode+"'  and substr(a.hab_code,6,2)='"+mcode+"' group by substr(a.hab_code,13,2)";
			
			Statement stmt96=conn.createStatement();
				//	System.out.println("schoolcount0:"+schoolcount0);
			ResultSet rs96=stmt96.executeQuery(qry);
			Hashtable totdph=new Hashtable();
			while(rs96.next())
				{
				totdph.put(rs96.getString(2),rs96.getString(1));
				}
			
			
			
			qry="select distinct sum(case when a.type_of_asset_code='08' then 1 else 0 end),substr(a.hab_code,13,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b where a.asset_code=b.asset_code and substr(a.hab_code,1,2)='"+dcode+"' and substr(a.hab_code,6,2)='"+mcode+"' group by substr(a.hab_code,13,2)";
			
			Statement stmt97=conn.createStatement();
				//	System.out.println("schoolcount0:"+schoolcount0);
			ResultSet rs97=stmt97.executeQuery(qry);
			Hashtable totothersh=new Hashtable();
			while(rs97.next())
				{
				totothersh.put(rs97.getString(2),rs97.getString(1));
				}				
							
	qry="select distinct pcode,pname,SUM(Case When b.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When b.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When b.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When b.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When b.coverage_status='PC1' then 1 Else 0 End) as PC1,sum(case when b.coverage_status='NSS' then 1 else 0 end) as QA from rws_complete_hab_view a,rws_habitation_directory_tbl b WHERE b.HAB_CODE=a.panch_code and dcode='"+dcode+"' and mcode='"+mcode+"' group by pcode,pname order by dcode";
	  // System.out.println("qry is"+qry);
	   
		 
	   rs8=stmt8.executeQuery(qry);
	   while(rs8.next())
	   {
		   
		   String ss13=(String)totothersh.get(rs8.getString(1));
		   //System.out.println("ss0"+ss0);
		   if(ss13 !=null && !ss13.equals(""))
		   {
			   
		   }
		   else
		   {
			   ss13="0";
		   }
		   int s13=Integer.parseInt(ss13);
		   
		   String ss12=(String)totdph.get(rs8.getString(1));
		   //System.out.println("ss0"+ss0);
		   if(ss12 !=null && !ss12.equals(""))
		   {
			   
		   }
		   else
		   {
			   ss12="0";
		   }
		   int s12=Integer.parseInt(ss12);
		   
		   String ss11=(String)totsvsh.get(rs8.getString(1));
		   //System.out.println("ss0"+ss0);
		   if(ss11 !=null && !ss11.equals(""))
		   {
			   
		   }
		   else
		   {
			   ss11="0";
		   }
		   int s11=Integer.parseInt(ss11);
		   

		   String ss10=(String)totmvsh.get(rs8.getString(1));
		   //System.out.println("ss0"+ss0);
		   if(ss10 !=null && !ss10.equals(""))
		   {
			   
		   }
		   else
		   {
			   ss10="0";
		   }
		   int s10=Integer.parseInt(ss10);
		   
		    
			   String ss0=(String)mvs.get(rs8.getString(1));
			   //System.out.println("ss0"+ss0);
			   if(ss0 !=null && !ss0.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss0="0";
			   }
			   int s0=Integer.parseInt(ss0);
			   
			   
			   String ss1=(String)svs.get(rs8.getString(1));
			   //System.out.println("ss1"+ss1);
			   if(ss1 !=null && !ss1.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss1="0";
			   }
			   int s1=Integer.parseInt(ss1);
			
			   String ss5=(String)mpws.get(rs8.getString(1));
			   if(ss5 !=null && !ss5.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss5="0";
			   }
			   int s5=Integer.parseInt(ss5);
			   
			   
			   
			   
			   
			   String ss2=(String)shp.get(rs8.getString(1));
			   //System.out.println("ss2"+ss2);
			   if(ss2 !=null && !ss2.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss2="0";
			   }
			   int s2=Integer.parseInt(ss2);
			   
			   String ss3=(String)others.get(rs8.getString(1));
			   //System.out.println("ss2"+ss2);
			   if(ss3 !=null && !ss3.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss3="0";
			   }
			   int s3=Integer.parseInt(ss3);
			
			   
			   String ss6=(String)hp.get(rs8.getString(1));
			   //System.out.println("ss0"+ss0);
			   if(ss6 !=null && !ss6.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss6="0";
			   }
			   int s7=Integer.parseInt(ss6);  
			   
			   String ss7=(String)dp.get(rs8.getString(1));
			   //System.out.println("ss0"+ss0);
			   if(ss7 !=null && !ss7.equals(""))
			   {
				   
			   }
			   else
			   {
				   ss7="0";
			   }
			   int s8=Integer.parseInt(ss7);  
			   
			   
		   
	  	int s6=s1+s5;
	  	int s9=s8+s7+s2;
	  	
	  	
	  	//System.out.println("s6"+s6);
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		

		 
	%>
	 <tr>
		
	     <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	    <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_cm_habitation_assetstatus_habitation_drill.jsp?dcode=<%=dcode%>&dname=<%=dname%>&mcode=<%=mcode%>&mname=<%=mname%>&pcode=<%=rs8.getString(1)%>&pname=<%=rs8.getString(2)%>')"><%=rs8.getString(2)%></a></td>
	    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(3)%></td>
	      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(4)%></td>
	      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(5)%></td>   
	      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(6)%></td> 
	      <td class="<%=style%> "style="text-align: right;"> <%=rs8.getInt(7)%></td> 
	      <td class="<%=style%> "style="text-align: right;"><%=rs8.getInt(8)%></td> 
	      <td class="<%=style%> "style="text-align: right;"><%=s10%></td>
	      <td class="<%=style%> "style="text-align: right;"><%=s0%></td>  
	      <td class="<%=style%> "style="text-align: right;"><%=s11%></td> 
	      <td class="<%=style%> "style="text-align: right;"><%=s6%></td> 
	       <td class="<%=style%> "style="text-align: right;"><%=s12 %></td> 
	      <td class="<%=style%> "style="text-align: right;"><%=s9%></td>
	      <td class="<%=style%> "style="text-align: right;"><%=s13%></td> 
	       <td class="<%=style%> "style="text-align: right;"><%=s3%></td>        
	      	</tr>
		
	   	
	   	
	<%
	totalfc+=rs8.getInt(3);
	totpc4+=rs8.getInt(4);
	totpc3+=rs8.getInt(5);
	totpc2+=rs8.getInt(6);
	totpc1+=rs8.getInt(7);
	totqa+=rs8.getInt(8);
	totmvshabs+=s10;
	totsvshabs+=s11;
	 totmvs+=s0;
	totsvs+=s6;
	totdhs+=s9;
	totothers+=s3;
	totdphabs+=s12;
	totothershabs+=s13;


	}
	   %>
	  <tr>
		
	      <td class=gridhdbg colspan="2" style="text-align: center;"> Total</td>
	   <td  class=gridhdbg style="text-align: right;"><%=totalfc%></td>
	    <td  class=gridhdbg style="text-align: right;"><%=totpc4%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totpc3%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totpc2%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totpc1%></td>
	       <td  class=gridhdbg style="text-align: right;"><%=totqa%></td>
	        <td  class=gridhdbg style="text-align: right;"><%=totmvshabs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totmvs%></td>
	       <td  class=gridhdbg style="text-align: right;"><%=totsvshabs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totsvs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totdphabs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totdhs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totothershabs%></td>
	      <td  class=gridhdbg style="text-align: right;"><%=totothers%></td>
	      
	      
	   
	      	</tr>
	   	
	   
	   <%
	   
		if(rs8!=null){
			rs8.close();
		}
		if(stmt8!=null){
			stmt8.close();
		}
		if(rs80!=null)
		{
			rs80.close();
		}
		if(stmt80!=null){
			stmt80.close();
		}
		
		if(rs81!=null)
		{
			rs81.close();
		}
		if(stmt81!=null){
			stmt81.close();
		}
		
		
		if(rs83!=null)
		{
			rs83.close();
		}
		if(stmt83!=null){
			stmt83.close();
		}

		if(rs90!=null)
		{
			rs90.close();
		}
		if(stmt90!=null){
			stmt90.close();
		}
		
		

		if(rs91!=null)
		{
			rs91.close();
		}
		if(stmt91!=null){
			stmt91.close();
		}
		
		

		if(rs92!=null)
		{
			rs92.close();
		}
		if(stmt92!=null){
			stmt92.close();
		}
		
		

		if(rs93!=null)
		{
			rs93.close();
		}
		if(stmt93!=null){
			stmt93.close();
		}
		
		if(rs94!=null)
		{
			rs94.close();
		}
		if(stmt94!=null){
			stmt94.close();
		}
		if(rs95!=null)
		{
			rs95.close();
		}
		if(stmt95!=null){
			stmt95.close();
		}
		
		if(rs96!=null)
		{
			rs96.close();
		}
		if(stmt96!=null){
			stmt96.close();
		}
		if(rs97!=null)
		{
			rs97.close();
		}
		if(stmt97!=null){
			stmt97.close();
		}
		}catch(Exception e)
		{
		e.printStackTrace();
		}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>