<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>

<%@ page import = "java.util.*" %>
<style>
tr.even {
  background-color: #ddd;
  width:80px;
  height:15px;
}
tr.odd {
  background-color: #eee;
  width:80px;
  height:15px;
  }
</style>

<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "Post Monsoon Data.xls");

%>
<%
//String dcode = String.valueOf(session.getAttribute("dCode"));
//System.out.println("dCode******####$%%%%"+dcode);
String dName = String.valueOf(session.getAttribute("dName"));
//System.out.println("dName"+dName);
String mCode = String.valueOf(session.getAttribute("mCode"));
String mName = String.valueOf(session.getAttribute("mName"));
String pCode = String.valueOf(session.getAttribute("pCode"));
String pName = String.valueOf(session.getAttribute("pName"));
String vCode = String.valueOf(session.getAttribute("vCode"));
String vName = String.valueOf(session.getAttribute("vName"));
String hCode = String.valueOf(session.getAttribute("hCode"));
String hName = String.valueOf(session.getAttribute("hName"));

//String pcode = request.getParameter("panchayat");

String vcode = request.getParameter("village");

String hcode = request.getParameter("habitation");

String y=(String)session.getAttribute("year");

String pcode=(String)session.getAttribute("panchayat");
String dcode=(String)session.getAttribute("district");
String mcode=(String)session.getAttribute("mandal");


//System.out.println("year********jjjj*******"+y);



int styleCount=0;
String style="";



/*
String dcode = request.getParameter("district");
//System.out.println("dcode = " +dcode);
String mcode = request.getParameter("mandal");
//System.out.println("mcode = " +mcode);
String dname = request.getParameter("dname");
String mname = request.getParameter("mname");
*/
%>
<table border = 0 cellspacing = 0 cellpadding = 0  width=100% style="border-collapse:collapse">
<tr><td  align="center" class=gridhdbg>Water Quality Ground Data  Post-Monsoon (01-OCT-<%=y %> to 31-DEC-<%=y %>)</td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=100% style="border-collapse:collapse" class="striped">
<tr><td colspan=22 align="center" class=gridhdbg>District:&nbsp;&nbsp;<%=dName%> </td></tr>
<tr>
<td class=gridhdbg rowspan=2 align="center">Sl.No</td>
<td class=gridhdbg rowspan=2 align="center" >Mandal</td>
<td class=gridhdbg rowspan=2 align="center" >Panchayat</td>
<td class=gridhdbg rowspan=2 align="center" >Village</td>
<td class=gridhdbg rowspan=2 align="center" >Habitation Name</td>
<td class=gridhdbg rowspan=2 align="center" >Habitation Code</td>


<td class=gridhdbg rowspan=2 align="center" >Source Code</td>
<td class=gridhdbg rowspan=2 align="center" >Source Type</td>

<td class=gridhdbg rowspan=2 align="center" >Source Location</td>
<td class=gridhdbg rowspan=2 align="center" >Water Level, mbgl</td>

<td class=gridhdbg rowspan=2 align="center" >Depth </td>
<td class=gridhdbg rowspan=2 align="center" >Type of Aquifer</td>


<td class=gridhdbg  colspan=2 align="center">Topo sheet No.</td>
<td class=gridhdbg colspan=9  align="center">Element-wise ground water quality parameters(Post-Monsoon(OCT<%=y %> to DEC<%=y %>))</td>
<td class=gridhdbg rowspan=2  align="center"> TestDate</td>



</tr>
<tr>
  <td class=gridhdbg  align="center" >Longitude (N)</td>
<td class=gridhdbg  align="center" >Latitude (E)</td>


  <td class=gridhdbg  align="center">PH<br>(Max 8.5)</br></td>
  <td class=gridhdbg  align="center">Total Dissolved Solids<br>(Max 2000)</td>
  <td class=gridhdbg  align="center">Total Hardness<br>(Max 600)</br> </td>
  <td class=gridhdbg  align="center">Total Alkanity<br>(Max 600)</br>  </td>
  <td class=gridhdbg  align="center">Fluoride<br>(Max 1.5)</br> </td>
  <td class=gridhdbg  align="center">Chlorides <br>(Max 1000)</br></td>
  <td class=gridhdbg  align="center">Iron<br>(Max 1.0)</br></td>
  <td class=gridhdbg align="center">Nitrate<br>(Max 45)</br></td>
  <td class=gridhdbg  align="center">Sulphate<br>(Max 400)</br></td>
  
  
  
  
  
  
</tr>
<%int cnt=0;


String habcode="",temphabcode="";


nic.watersoft.wquality.RwsWQualityData rwsdata=new  nic.watersoft.wquality.RwsWQualityData(); 
java.util.ArrayList sourcelist =new  java.util.ArrayList();
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
try{
Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();

Statement stmt4=conn.createStatement();
Statement stmt5=conn.createStatement();
Statement stmt6=conn.createStatement();
String qry="",qry3="",qry4="";
//hand pump
//String qry="select  hp_code,LOCATION,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0) ,STATIC_WL   from rws_hp_subcomp_param_tbl where LATITUDE is not null and LONGITUDE is not null and substr(HP_CODE,1,16)='"+hCode+"'";
//no mandal
//String qry="select distinct hp_code,LOCATION,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0) ,STATIC_WL   from rws_hp_subcomp_param_tbl where LATITUDE<>0 and LONGITUDE<>0 and substr(HP_CODE,1,2)='"+dcode+"'";

 qry="select distinct hp_code,LOCATION,nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(DEPTH,0) ,STATIC_WL,h.MNAME,h.PNAME,h.VNAME,PANCH_NAME,PANCH_CODE  from rws_hp_subcomp_param_tbl a, rws_complete_hab_view h where LATITUDE<>0 and LONGITUDE<>0 and substr(a.hp_code,1,16)=h.panch_code and substr(HP_CODE,1,2)='"+dcode+"'  ";
 if(mcode!=null && !mcode.equals("00"))
 {
 	qry+=" and substr(HP_CODE,6,2)='"+mcode+"' ";
 }
 
 if(pcode!=null && !pcode.equals("00"))
 {
 	qry+=" and substr(HP_CODE,13,2)='"+pcode+"' ";
 }
 
 
 qry+=" order by h.MNAME,h.PNAME,h.VNAME,PANCH_NAME ";
  
System.out.println("qrystart1"+qry);
rs1=stmt1.executeQuery(qry);

String testdt="";

while(rs1.next())
{
	  String param="-",paramdis="-",paramhard="-",paramalk="-",parafloride="-",paracholride="-",parairon="-",paranitrate="-",parasulphate="-";

	habcode=rs1.getString(11);
	//System.out.println("habcode"+habcode+"--result is"+(!habcode.equals(temphabcode)));
	  if(!habcode.equals(temphabcode)){
	  

	//String qry11="select  a.test_id,testing_parameter_value,a.testing_parameter_code from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id  and source_code='"+rs.getString(1)+"' ";
	
	
	//original final querry
	//String qry11="select  a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where a.source_code='"+rs1.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and to_date(a.PREPARED_ON)>='01-OCT-"+y+"' and to_date(a.PREPARED_ON)<='31-DEC-"+y+"' ";
	
	String qry11="select distinct a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')as a1  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where a.source_code='"+rs1.getString(1)+"' and  a.test_id=c.test_id and to_char(a.PREPARED_ON,'yyyy') in('2009','2010','2011','2012','2013') and to_char(a.PREPARED_ON,'MON') in ('OCT','NOV','DEC') order by substr(a1,5,8) desc ";
	
	
	
	rs2=stmt2.executeQuery(qry11);
	//System.out.println("qry11"+qry11);
	
  while(rs2.next())
	{
	  testdt=rs2.getString(4);
		//PH
		if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("04")){
		param=rs2.getString(2);
		 }
		 
		 //disolveed solids
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("05")){
		paramdis=rs2.getString(2);
		 }
			
		//total hardness
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("06")){
			 paramhard=rs2.getString(2);
		 }
		
		//total Alkanity
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("07")){
			 paramalk=rs2.getString(2);
		 }
		//total Flourid
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("13")){
			 parafloride=rs2.getString(2);
		 }
		
		//total Flourid
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("12")){
			 paracholride=rs2.getString(2);
		 }
		//total Iran
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("16")){
			 parairon=rs2.getString(2);
		 }

		//total Nitrate
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("15")){
			 paranitrate=rs2.getString(2);
		 }

		//total sulphate
		 if(rs2.getString(3)!=null &&  !rs2.getString(3).equals("null") && rs2.getString(3).equals("14")){
			 parasulphate=rs2.getString(2);
		 }
	
		
		
	}
	
	
  if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 System.out.println("param is"+param);
	if(!param.equals("-"))
	{
	%>
  <tr>
 
	<td class=<%=style %>><%=++cnt%></td>
	
	<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(7)%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(8)%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(9)%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(10)%></td>
	<td class="<%=style %>" style="text-align: left;"><%=rs1.getString(11)%></td>
	
	
	
    <td class="<%=style %>"style="text-align: right;"><%=rs1.getString(1)%></td>
    <td class=<%=style %>>HandPump</td>
     <td class="<%=style %>"style="text-align: left;"><%=rs1.getString(2)%></td>
      <td class="<%=style %>" style="text-align: right;"><%=rs1.getString(6)%></td>
   <td class="<%=style %>" style="text-align: right;"><%=rs1.getString(5) %></td>
   <td class=<%=style %>>-</td>
   <td class="<%=style %>" style="text-align: right;"><%=rs1.getString(3)%></td>
   <td class="<%=style %>" style="text-align: right;"><%=rs1.getString(4)%></td>
   
   <td class="<%=style %>" style="text-align: right;"><%=param %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramdis %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramhard%></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramalk %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parafloride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paracholride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parairon %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paranitrate %></td>
   <td class="<%=style %>"style="text-align: right;"><%=parasulphate %></td>
   <td class="<%=style %>" style="text-align: right;"><%=testdt%></td>
   </tr>
   <%
	  
	}
   
	  }
	  temphabcode=rs1.getString(11);
}
habcode="";temphabcode="";

    //openwell
    
//String qry3="select distinct OPENWELL_CODE ,LOCATION ,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0)   from rws_open_well_mast_tbl where LATITUDE is not null and LONGITUDE is not null and substr(OPENWELL_CODE,1,16)='"+hCode+"'";
//String qry3="select distinct OPENWELL_CODE ,LOCATION ,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0) from rws_open_well_mast_tbl where LATITUDE<>0 and LONGITUDE<>0 and substr(OPENWELL_CODE,1,2)='"+dcode+"' ";
     qry3="select distinct OPENWELL_CODE ,LOCATION,nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(DEPTH,0),h.MNAME,h.PNAME,h.VNAME,PANCH_NAME,PANCH_CODE  from rws_open_well_mast_tbl a, rws_complete_hab_view h where LATITUDE<>0 and LONGITUDE<>0 and substr(a.OPENWELL_CODE,1,16)=h.panch_code and substr(OPENWELL_CODE,1,2)='"+dcode+"' ";
     if(mcode !=null && !mcode.equals("00"))
     {
     	qry3+=" and substr(OPENWELL_CODE,6,2)='"+mcode+"' ";
     }
     
     if(pcode!=null && !pcode.equals("00"))
     {
     	qry3+=" and substr(OPENWELL_CODE,13,2)='"+pcode+"' ";
     }
     qry3+=" order by h.MNAME,h.PNAME,h.VNAME,PANCH_NAME";
      
System.out.println("qry3"+qry3);
rs3=stmt3.executeQuery(qry3);


while(rs3.next())
{
	String param="-",paramdis="-",paramhard="-",paramalk="-",parafloride="-",paracholride="-",parairon="-",paranitrate="-",parasulphate="-";
//original query max date	 
//String qry13="select distinct a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY'),SOURCE_CODE   from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl c where a.source_code='"+rs3.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and to_date(a.PREPARED_ON)>='01-OCT-"+y+"' and to_date(a.PREPARED_ON)<='31-DEC-"+y+"'";
habcode=rs3.getString(10);
	//System.out.println("habcode"+habcode+"--result is"+(!habcode.equals(temphabcode)));
	  if(!habcode.equals(temphabcode)){
	 
String qry13="select distinct a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')as a1,SOURCE_CODE   from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl c where a.source_code='"+rs3.getString(1)+"' and  a.test_id=c.test_id and to_char(a.PREPARED_ON,'yyyy') in('2009','2010','2011','2012','2013') and to_char(a.PREPARED_ON,'MON') in ('OCT','NOV','DEC')order by substr(a1,5,8) desc";

	rs4=stmt4.executeQuery(qry13);
	//System.out.println("qry13"+qry13);
	
  while(rs4.next())
	{
	  testdt=rs4.getString(4);
		//PH
		if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("04")){
		param=rs4.getString(2);
		 }
		 
		 //disolveed solids
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("05")){
		paramdis=rs4.getString(2);
		 }
			
		//total hardness
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("06")){
			 paramhard=rs4.getString(2);
		 }
		
		//total Alkanity
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("07")){
			 paramalk=rs4.getString(2);
		 }
		//total Flourid
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("13")){
			 parafloride=rs4.getString(2);
		 }
		
		//total Flourid
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("12")){
			 paracholride=rs4.getString(2);
		 }
		//total Iran
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("16")){
			 parairon=rs4.getString(2);
		 }

		//total Nitrate
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("15")){
			 paranitrate=rs4.getString(2);
		 }

		//total sulphate
		 if(rs4.getString(3)!=null &&  !rs4.getString(3).equals("null") && rs4.getString(3).equals("14")){
			 parasulphate=rs4.getString(2);
		 }
		
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		
	}
	  
	  

		 
  if(!param.equals("-"))
	{
		 
	%>
    <tr>
 
	<td class=<%=style %>><%=++cnt%></td>
	
	<td class="<%=style %>"style="text-align: left;"><%=rs3.getString(6)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs3.getString(7)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs3.getString(8)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs3.getString(9)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs3.getString(10)%></td>
	
	
	
	
    <td class="<%=style %>"style="text-align: left;"><%=rs3.getString(1)%></td>
    <td class="<%=style %>"style="text-align: left;">OpenWell</td>
     <td class="<%=style %>"style="text-align: left;"><%=rs3.getString(2)%></td>
      <td class="<%=style %>" >-</td>
   <td class="<%=style %>" style="text-align: right;"><%=rs3.getString(5) %></td>
   <td class=<%=style %>>-</td>
   <td class="<%=style %>" style="text-align: right;"><%=rs3.getString(3)%></td>
   <td class="<%=style %>" style="text-align: right;"><%=rs3.getString(4)%></td>
   
   <td class="<%=style %>" style="text-align: right;"><%=param %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramdis %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramhard%></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramalk %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parafloride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paracholride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parairon %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paranitrate %></td>
  <td class="<%=style %>" style="text-align: right;"><%=parasulphate%></td>
    <td class="<%=style %>" style="text-align: right;"><%=testdt%></td>
   
</tr>

<%

	}

	
}
	temphabcode=rs3.getString(10);
  
}
habcode="";temphabcode="";   
    //Sources
  
 //   String qry4="select  distinct SOURCE_CODE,nvl(LOCATION,'-') ,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0),nvl(STATIC_WATER_LEVEL,0)    from rws_source_tbl where LATITUDE is not null and LONGITUDE is not null and  substr(SOURCE_CODE ,1,16)='"+hCode+"'";
//String qry4="select  distinct SOURCE_CODE,nvl(LOCATION,'-') ,nvl(LATITUDE,0),nvl(LONGITUDE,0) ,nvl(DEPTH,0),nvl(STATIC_WATER_LEVEL,0)    from rws_source_tbl where LATITUDE<>0 and LONGITUDE<>0 and  substr(SOURCE_CODE ,1,2)='"+dcode+"'";
  
 qry4="select distinct SOURCE_CODE,nvl(LOCATION,'-'),nvl(LATITUDE,0),nvl(LONGITUDE,0),nvl(DEPTH,0) ,nvl(STATIC_WATER_LEVEL,0),h.MNAME,h.PNAME,h.VNAME,PANCH_NAME,PANCH_CODE  from rws_source_tbl a, rws_complete_hab_view h where LATITUDE<>0 and LONGITUDE<>0 and substr(a.Source_code,1,16)=h.panch_code and  substr(SOURCE_CODE,1,2)='"+dcode+"' ";

if(mcode!=null && !mcode.equals("00"))
{
qry4+=" and  substr(SOURCE_CODE ,6,2)='"+mcode+"'  ";
}

if(pcode!=null && !pcode.equals("00"))
{
	qry4+=" and substr(SOURCE_CODE,13,2)='"+pcode+"' ";
}

qry4+=" order by h.MNAME,h.PNAME,h.VNAME,PANCH_NAME";
 System.out.println("qry4"+qry4);
    rs5=stmt5.executeQuery(qry4);
 
    while(rs5.next())
    {
    	String param="-",paramdis="-",paramhard="-",paramalk="-",parafloride="-",paracholride="-",parairon="-",paranitrate="-",parasulphate="-";
    	habcode=rs5.getString(11);
    	//System.out.println("habcode"+habcode+"--result is"+(!habcode.equals(temphabcode)));
    	  if(!habcode.equals(temphabcode)){
    //original query 	
   // 	String qry12="select distinct  a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY'),SOURCE_CODE  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where a.source_code='"+rs5.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and to_date(a.PREPARED_ON)>='01-OCT-"+y+"' and to_date(a.PREPARED_ON)<='31-DEC-"+y+"' ";
   
    	String qry12="select distinct a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')as a1,SOURCE_CODE  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where a.source_code='"+rs5.getString(1)+"' and  a.test_id=c.test_id and to_char(a.PREPARED_ON,'yyyy') in('2009','2010','2011','2012','2013') and to_char(a.PREPARED_ON,'MON') in ('OCT','NOV','DEC') order by substr(a1,5,8) desc ";	
    	//System.out.println("qry12"+qry12);    	
    	rs6=stmt6.executeQuery(qry12);
    	
      while(rs6.next())
    	{
    	  testdt=rs6.getString(4);
    		//PH
    		if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("04")){
    		param=rs6.getString(2);
    		 }
    		 
    		 //disolveed solids
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("05")){
    		paramdis=rs6.getString(2);
    		 }
    			
    		//total hardness
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("06")){
    			 paramhard=rs6.getString(2);
    		 }
    		
    		//total Alkanity
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("07")){
    			 paramalk=rs6.getString(2);
    		 }
    		//total Flourid
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("13")){
    			 parafloride=rs6.getString(2);
    		 }
    		
    		//total Flourid
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("12")){
    			 paracholride=rs6.getString(2);
    		 }
    		//total Iran
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("16")){
    			 parairon=rs6.getString(2);
    		 }

    		//total Nitrate
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("15")){
    			 paranitrate=rs6.getString(2);
    		 }

    		//total sulphate
    		 if(rs6.getString(3)!=null &&  !rs6.getString(3).equals("null") && rs6.getString(3).equals("14")){
    			 parasulphate=rs6.getString(2);
    		 }

    		
    		
    		
    	}
      if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		
		 if(!param.equals("-"))
			{
    
    	%>
       <tr>
 
	<td class=<%=style %>><%=++cnt%></td>
	
	
	
	<td class="<%=style %>"style="text-align: left;"><%=rs5.getString(7)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs5.getString(8)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs5.getString(9)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs5.getString(10)%></td>
	<td class="<%=style %>"style="text-align: left;"><%=rs5.getString(11)%></td>
	
	
    <td class="<%=style %>"style="text-align: left;"><%=rs5.getString(1)%></td>
    <td class="<%=style %>" style="text-align: left;">Source</td>
     <td class="<%=style %>"style="text-align: left;"><%=rs5.getString(2)%></td>
      <td class="<%=style %>" style="text-align: right;"><%=rs5.getString(6)%></td>
   <td class="<%=style %>" style="text-align: right;"><%=rs5.getString(5) %></td>
   <td class=<%=style %>>-</td>
   <td class="<%=style %>" style="text-align: right;"><%=rs5.getString(3)%></td>
   <td class="<%=style %>" style="text-align: right;"><%=rs5.getString(4)%></td>
   
   <td class="<%=style %>" style="text-align: right;"><%=param %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramdis %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramhard%></td>
   <td class="<%=style %>" style="text-align: right;"><%=paramalk %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parafloride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paracholride %></td>
   <td class="<%=style %>" style="text-align: right;"><%=parairon %></td>
   <td class="<%=style %>" style="text-align: right;"><%=paranitrate %></td>
  <td class="<%=style %>"style="text-align: right;"><%=parasulphate%></td>
    <td class="<%=style %>" style="text-align: right;"><%=testdt%></td>
   </tr>
     <%
    
			}
    
    	  }
    

    
    
    	  temphabcode=rs5.getString(11);
}
}catch(Exception e){
e.printStackTrace();
}

%>
</table>

<%@ include file="/commons/rws_footer.jsp"%>

