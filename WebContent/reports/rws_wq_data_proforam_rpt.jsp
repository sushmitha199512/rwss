<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
String dCode = String.valueOf(session.getAttribute("dCode"));
String dName = String.valueOf(session.getAttribute("dName"));
//System.out.println("dName"+dName);
String mCode = String.valueOf(session.getAttribute("mCode"));
String mName = String.valueOf(session.getAttribute("mName"));
String pCode = String.valueOf(session.getAttribute("pCode"));
String pName = String.valueOf(session.getAttribute("pName"));
String vCode = String.valueOf(session.getAttribute("vCode"));
String vName = String.valueOf(session.getAttribute("vName"));
String h1Code = String.valueOf(session.getAttribute("hCode"));
String hName = String.valueOf(session.getAttribute("hName"));

String pcode = request.getParameter("panchayat");
session.setAttribute("pcode",pcode);

String vcode = request.getParameter("village");
session.setAttribute("vcode",vcode);


String hCode = request.getParameter("habitation");
session.setAttribute("hCode",hCode);


//System.out.println("Habitation Name>>>>>>>>> "+hName);



String dcode = request.getParameter("district");
session.setAttribute("dcode",dcode);
//System.out.println("dcode = " +dcode);
String mcode = request.getParameter("mandal");
session.setAttribute("mcode",mcode);
//System.out.println("mcode = " +mcode);
String dname = request.getParameter("dname");
session.setAttribute("dname",dname);
String mname = request.getParameter("mname");
session.setAttribute("mname",mname);
%>
<table border = 0 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" >
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a> |<a href="./rws_wq_data_proforam_Excel.jsp?District:&nbsp;&nbsp;<%=dName%> &nbsp;&nbsp;&nbsp;&nbsp;Mandal:&nbsp;&nbsp;<%=mName%>&nbsp;&nbsp;Panchayat:&nbsp;&nbsp;<%=pName%>&nbsp;&nbsp;Village:&nbsp;&nbsp;<%=vName%>&nbsp;&nbsp;&nbsp;Habitation:&nbsp;&nbsp;<%=hName%>" target=_new>Excel</a></td>
				</tr>
			</table>
			</caption>
</table>
<table border = 0 cellspacing = 0 cellpadding = 0  width=90%  bordercolor=#000000 style="border-collapse:collapse">
<tr><td  align="center" class=btext>Water Quality Data Format</td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=90%  bordercolor=#000000 style="border-collapse:collapse" class="striped">
<tr><td colspan=26 align="center" class=rptvalue><font color="red">District:&nbsp;&nbsp;<%=dName%> &nbsp;&nbsp;&nbsp;&nbsp;Mandal:&nbsp;&nbsp;<%=mName%>&nbsp;&nbsp;</font></td></tr>



<%if(pcode!=null && !pcode.equals("")){ %>
<tr>

<td colspan=26 align="center" class=rptvalue><font color="red">Panchayat:<%=pName%></font></td></tr>

<%}%>

<%if(vcode!=null && !vcode.equals("")){ %>
<tr>

<td colspan=26 align="center" class=rptvalue><font color="red">Village:<%=vName%></font></td></tr>

<%}%>
<%if(hCode!=null && !hCode.equals("")){ %>
<tr>

<td colspan=26 align="center" class=rptvalue><font color="red">Habitation:<%=hCode%>-<%=hName%></font></td></tr>

<%}%>


<tr>


<td class=btext rowspan=2 align="center">Sl.No</td>
<td class=btext rowspan=2 align="center">Panchayat Name</td>
<td class=btext rowspan=2 align="center">Hab Name</td>
<td class=btext rowspan=2 align="center" >Source Code</td>
<td class=btext rowspan=2 align="center" >Source Type</td>

<td class=btext rowspan=2 align="center" >Source Location</td>
<td class=btext rowspan=2 align="center" >Water Level, mbgl</td>

<td class=btext rowspan=2 align="center" >Depth </td>
<td class=btext rowspan=2 align="center" >Type of Aquifer</td>


<td class=btext  colspan=2 align="center">Topo sheet No.</td>
<td class=btext colspan=9  align="center">Element-wise ground water quality parameters</td>
<td class=btext rowspan=2  align="center"> TestDate</td>
<td class=btext rowspan=2  align="center"> Shallow & Deep Aquifers existing <br></br>in the Village/Habitation or not</td>
<td class=btext rowspan=2  align="center"> Lithology / Rock Type</td>
<td class=btext rowspan=2  align="center"> Depth of weathering & Nature<br></br> of Weathered Material</td>

<td class=btext rowspan=2  align="center"> Thickness & Nature<br></br> of Deposited Material</td>
<td class=btext rowspan=2  align="center"> Sub-surface Strata</td>

</tr>
<tr>
  <td class=btext  align="center" >Longitude (N)</td>
<td class=btext  align="center" >Latitude (E)</td>


  <td class=btext  align="center">PH</td>
  <td class=btext  align="center">Total Dissolved Solids</td>
  <td class=btext  align="center">Total Hardness </td>
  <td class=btext  align="center">Total Alkanity  </td>
  <td class=btext  align="center">Fluoride </td>
  <td class=btext  align="center">Chlorides </td>
  <td class=btext  align="center">Iron</td>
  <td class=btext  align="center">Nitrate</td>
  <td class=btext  align="center">Phosphate</td>
</tr>
<%int cnt=0;
//String qry1="";




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
String qry="";
String qry11="";




 qry="select hp_code,a.LOCATION,nvl(a.LATITUDE,0),nvl(a.LONGITUDE,0) ,nvl(a.DEPTH,0) ,nvl(a.STATIC_WL,0),pname,panch_name   from rws_hp_subcomp_param_tbl a ,rws_panchayat_tbl b,rws_panchayat_raj_tbl c  where substr(hp_code,1,2)='"+dcode+"' and substr(hp_code,6,2)='"+mcode+"' and substr(hp_code,1,2)=b.dcode and substr(hp_code,6,2)=b.mcode and substr(hp_code,13,2)=b.pcode and substr(hp_code,1,16)=c.panch_code ";
 if(pcode !=null && !pcode.equals(""))
 {
	 qry+=" and substr(hp_code,13,2)='"+pcode+"'";
 }
 if(vcode !=null && !vcode.equals(""))
 {
	 qry+="and substr(hp_code,8,3)='"+vcode+"'";
 }
 if(hCode !=null && !hCode.equals(""))
 {
	 qry+="and substr(hp_code,1,16)='"+hCode+"'";
 }
 qry+="order by hp_code";

//System.out.println("qry"+qry);
rs1=stmt1.executeQuery(qry);

String testdt="";

while(rs1.next())
{

	String param="",paramdis="",paramhard="",paramalk="",parafloride="",paracholride="",parairon="",paranitrate="";
	//String qry11="select  a.test_id,testing_parameter_value,a.testing_parameter_code from rws_wq_test_results_lnk_tbl a,rws_wq_test_results_tbl b where a.test_id=b.test_id  and source_code='"+rs.getString(1)+"' ";
	
	 qry11="select   a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where test_code=1 and a.source_code='"+rs1.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and substr(a.source_code,1,2)='"+dcode+"' and substr(a.source_code,6,2)='"+mcode+"'";
	 if(pcode !=null && !pcode.equals(""))
	 {
		 qry11+=" and substr(a.source_code,13,2)='"+pcode+"'";
	 }
	 if(vcode !=null && !vcode.equals(""))
	 {
		 qry11+="and substr(a.source_code,8,3)='"+vcode+"'";
	 }
	 if(hCode !=null && !hCode.equals(""))
	 {
		 qry11+="and substr(a.source_code,1,16)='"+hCode+"'";
	 }

	 
	
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

		
		
		
	}

	
	
	
	
	%>
  <tr>
 
	<td class=rptvalue><%=++cnt%></td>
	  <td class=rptvalue><%=rs1.getString(7)%></td>
	    <td class=rptvalue><%=rs1.getString(8)%></td>
	    <td class=rptvalue><%=rs1.getString(1)%></td>
    <td class=rptvalue>HandPump</td>
     <td class=rptvalue><%=rs1.getString(2)%></td>
      <td class=rptvalue><%=rs1.getString(6)%></td>
   <td class=rptvalue><%=rs1.getString(5) %></td>
   <td class=rptvalue>-</td>
   <td class=rptvalue><%=rs1.getString(3)%></td>
   <td class=rptvalue><%=rs1.getString(4)%></td>
   
   <td class=rptvalue><%=param %></td>
   <td class=rptvalue><%=paramdis %></td>
   <td class=rptvalue><%=paramhard%></td>
   <td class=rptvalue><%=paramalk %></td>
   <td class=rptvalue><%=parafloride %></td>
   <td class=rptvalue><%=paracholride %></td>
   <td class=rptvalue><%=parairon %></td>
   <td class=rptvalue><%=paranitrate %></td>
   <td class=rptvalue>-</td>
   <td class=rptvalue><%=testdt%></td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
     <td class=rptvalue>-</td>
     </tr>
   <%
   
   param="";
   
    
}
    //openwell
    String qry3="";
    String qry13="";
    
 qry3="select OPENWELL_CODE ,a.LOCATION ,nvl(a.LATITUDE,0),nvl(a.LONGITUDE,0) ,nvl(a.DEPTH,0),pname,panch_name   from rws_open_well_mast_tbl a ,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where substr(openwell_code,1,2)='"+dcode+"' and substr(openwell_code,6,2)='"+mcode+"' and substr(openwell_code,1,2)=b.dcode and substr(openwell_code,6,2)=b.mcode and substr(openwell_code,13,2)=b.pcode and substr(openwell_code,1,16)=c.panch_code ";
 if(pcode !=null && !pcode.equals(""))
 {
	 qry3+=" and substr(OPENWELL_CODE,13,2)='"+pcode+"'";
 }
 if(vcode !=null && !vcode.equals(""))
 {
	 qry3+="and substr(OPENWELL_CODE,8,3)='"+vcode+"'";
 }
 if(hCode !=null && !hCode.equals(""))
 {
	 qry3+="and substr(OPENWELL_CODE,1,16)='"+hCode+"'";
 }

//System.out.println("qry3"+qry3);
rs3=stmt3.executeQuery(qry3);



while(rs3.next())
{
	
	String param="",paramdis="",paramhard="",paramalk="",parafloride="",paracholride="",parairon="",paranitrate="";
 qry13="select a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY')  from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where test_code=1 and a.source_code='"+rs3.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and substr(a.source_code,1,2)='"+dcode+"' and substr(a.source_code,6,2)='"+mcode+"' ";
 if(pcode !=null && !pcode.equals(""))
 {
	 qry13+=" and substr(a.source_code,13,2)='"+pcode+"'";
 }
 if(vcode !=null && !vcode.equals(""))
 {
	 qry13+="and substr(a.source_code,8,3)='"+vcode+"'";
 }
 if(hCode !=null && !hCode.equals(""))
 {
	 qry13+="and substr(a.source_code,1,16)='"+hCode+"'";
 }

	
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
			 paramalk=rs2.getString(2);
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

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	%>
    <tr>
 
	<td class=rptvalue><%=++cnt%></td>
	<td class=rptvalue><%=rs3.getString(6)%></td>
	<td class=rptvalue><%=rs3.getString(7)%></td>
    <td class=rptvalue><%=rs3.getString(1)%></td>
    <td class=rptvalue>OpenWell</td>
     <td class=rptvalue><%=rs3.getString(2)%></td>
      <td class=rptvalue>-</td>
   <td class=rptvalue><%=rs3.getString(5) %></td>
   <td class=rptvalue>-</td>
   <td class=rptvalue><%=rs3.getString(3)%></td>
   <td class=rptvalue><%=rs3.getString(4)%></td>
   
   <td class=rptvalue><%=param %></td>
   <td class=rptvalue><%=paramdis %></td>
   <td class=rptvalue><%=paramhard%></td>
   <td class=rptvalue><%=paramalk %></td>
   <td class=rptvalue><%=parafloride %></td>
   <td class=rptvalue><%=paracholride %></td>
   <td class=rptvalue><%=parairon %></td>
   <td class=rptvalue><%=paranitrate %></td>
   <td class=rptvalue>-</td>
    <td class=rptvalue><%=testdt%></td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>
   <td class=rptvalue>-</td>

</tr>
<%
	}
}
    
    //Sources
    String qry4="";
    String qry12="";
    
    qry4="select SOURCE_CODE  ,nvl(a.LOCATION,'-') ,nvl(a.LATITUDE,0),nvl(a.LONGITUDE,0) ,nvl(a.DEPTH,0),nvl(a.STATIC_WATER_LEVEL,0),pname,panch_name  from rws_source_tbl a ,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where substr(source_code,1,2)='"+dcode+"' and substr(source_code,6,2)='"+mcode+"' and substr(SOURCE_CODE,1,2)=b.dcode and substr(SOURCE_CODE,6,2)=b.mcode and substr(SOURCE_CODE,13,2)=b.pcode and substr(SOURCE_CODE,1,16)=c.panch_code ";
    if(pcode !=null && !pcode.equals(""))
    {
   	 qry4+=" and substr(source_code,13,2)='"+pcode+"'";
    }
    if(vcode !=null && !vcode.equals(""))
    {
   	 qry4+="and substr(source_code,8,3)='"+vcode+"'";
    }
    if(hCode !=null && !hCode.equals(""))
    {
   	 qry4+="and substr(source_code,1,16)='"+hCode+"'";
    }


  //  System.out.println("qry4"+qry4);
    rs5=stmt5.executeQuery(qry4);
 
   

    while(rs5.next())
    {
    	String param="",paramdis="",paramhard="",paramalk="",parafloride="",paracholride="",parairon="",paranitrate="";
    	 qry12="select   a.test_id,c.testing_parameter_value,c.testing_parameter_code,to_char(a.PREPARED_ON,'DD/MM/YYYY') from rws_wq_test_results_tbl a , rws_wq_test_results_lnk_tbl c where test_code=1 and a.source_code='"+rs5.getString(1)+"' and a.prepared_on=(select max(b.prepared_on) from rws_wq_test_results_tbl b  where b.source_code=a.source_code) and a.test_id=c.test_id and substr(a.source_code,1,2)='"+dcode+"' and substr(a.source_code,6,2)='"+mcode+"'";
    	 if(pcode !=null && !pcode.equals(""))
    	 {
    		 qry12+=" and substr(a.source_code,13,2)='"+pcode+"'";
    	 }
    	 if(vcode !=null && !vcode.equals(""))
    	 {
    		 qry12+="and substr(a.source_code,8,3)='"+vcode+"'";
    	 }
    	 if(hCode !=null && !hCode.equals(""))
    	 {
    		 qry12+="and substr(a.source_code,1,16)='"+hCode+"'";
    	 }

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

    		 %>
    	       <tr>
    	 
    		<td class=rptvalue><%=++cnt%></td>
    		<td class=rptvalue><%=rs5.getString(7)%></td>
    		<td class=rptvalue><%=rs5.getString(8)%></td>
    	    <td class=rptvalue><%=rs5.getString(1)%></td>
    	    <td class=rptvalue>Source</td>
    	     <td class=rptvalue><%=rs5.getString(2)%></td>
    	      <td class=rptvalue><%=rs5.getString(6)%></td>
    	   <td class=rptvalue><%=rs5.getString(5) %></td>
    	   <td class=rptvalue>-</td>
    	   <td class=rptvalue><%=rs5.getString(3)%></td>
    	   <td class=rptvalue><%=rs5.getString(4)%></td>
    	   
    	   <td class=rptvalue><%=param %></td>
    	   <td class=rptvalue><%=paramdis %></td>
    	   <td class=rptvalue><%=paramhard%></td>
    	   <td class=rptvalue><%=paramalk %></td>
    	   <td class=rptvalue><%=parafloride %></td>
    	   <td class=rptvalue><%=paracholride %></td>
    	   <td class=rptvalue><%=parairon %></td>
    	   <td class=rptvalue><%=paranitrate %></td>
    	   <td class=rptvalue>-</td>
    	    <td class=rptvalue><%=testdt%></td>
    	   <td class=rptvalue>-</td>
    	   <td class=rptvalue>-</td>
    	   <td class=rptvalue>-</td>
    	   <td class=rptvalue>-</td>
    	   <td class=rptvalue>-</td>
    	   </tr>
    	     <%
    	}
    	
    	
    
    
      
  
    
    }
    

}catch(Exception e){
e.printStackTrace();
}
%>
</table>


