<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<script type="text/javascript">
function fnSubmit()
{
  var d=document.getElementById('demo1').value;//date value
  //var y=document.getElementById('year').value;
 // document.f1.mydate.value=d; //setting to jsp var
  // alert(y);
  
  document.f1.action="./rws_drought_daily_rpt.jsp";
  //alert("hai");
  document.f1.mydate.value=d; 
  document.f1.submit();

}
</script>

<%


	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());



ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
Statement pst = null,pst2=null,pst3=null,pst4=null,pst5=null,pst6=null;
int count=1,hcount=0,pvtsum=0,display=0;
int habcount=0,habcount1=0,popcount=0,tankcount=0,qtycount=0,sourcecount=0,popcount1=0,tankcount1=0,qtycount1=0,commcount=0,tripcount=0;
int hab_sum=0,hab_sum1=0,hab_sum2=0,pop_sum=0,tank_sum=0,source_sum=0,pop_sum1=0,pop_sum2=0,comm_sum=0;
float trip_sum=0,trip_sum1=0,qty_sum=0,qty_sum1=0,qty_sum2=0;


//String h1values="";
//String h2values="";
//String h3values="";

StringBuffer h1values = new StringBuffer();
StringBuffer h2values = new StringBuffer();
StringBuffer h3values = new StringBuffer();
StringBuffer h4values = new StringBuffer();

//first time display purpose
//String s;
StringBuffer s=new StringBuffer();

Format formatter;
session=request.getSession(true);
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");

s.append(formatter.format(date));

//String currentdate=s.replace("/","-");
StringBuffer currentdate=new StringBuffer();
currentdate.append(s.toString().replace("/","-"));
session.setAttribute("currentdate",currentdate.toString());
//////System.out.println("current"+currentdate.toString());




//String rDistrict = request.getParameter("rDistrict");
StringBuffer rDistrict=new StringBuffer();
rDistrict.append(request.getParameter("rDistrict"));
if(rDistrict.toString()!=null){
session.setAttribute("rDistrict",rDistrict.toString());
}
//////System.out.println("rDistrict..fff....."+rDistrict.toString());





//String rDistrictName = request.getParameter("rDistrictName");
StringBuffer rDistrictName=new StringBuffer();
rDistrictName.append(request.getParameter("rDistrictName"));
if(rDistrictName.toString()!=null){
session.setAttribute("rDistrictName",rDistrictName.toString());
}




//String rvalue=request.getParameter("mydate");
StringBuffer rvalue=new StringBuffer();
rvalue.append(request.getParameter("mydate"));
if(rvalue!=null){
//session.setAttribute("rvalue",rvalue.toString());
}
if(rvalue==null || rvalue.toString().equals("null")){
	rvalue.delete(0,rvalue.length());	
rvalue.append(currentdate);
}

session.setAttribute("rvalue",rvalue.toString());



String mydatevalues[]=null;
mydatevalues=rvalue.toString().split("-");

//////System.out.println("my date- ravlue......."+rvalue.toString());
//////System.out.println("my date- mydatevalue......."+mydatevalues);

for(int k=0;k<mydatevalues.length;k++)
{
//////System.out.println("myvalues......."+mydatevalues[k]);

}



StringBuffer year=new StringBuffer();
year.append(mydatevalues[2]);
//System.out.println("myyear......."+year.toString());
session.setAttribute("year",year.toString());
%>

<html>
<form name=f1>

<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js">

//Date Time Picker script- by TengYong Ng of http://www.rainforestnet.com
//Script featured on JavaScript Kit (http://www.javascriptkit.com)
//For this script, visit http://www.javascriptkit.com 

</script>

</head>
<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
    <caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
			
		<% 
if(loggedUser.toString()!=null)
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>



			</table>
		</caption>
   <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>DAILY REPORT</td>	
	</tr>
    <tr><td class=rptLabel>Select Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="25" value="<%=rvalue%>">
       <a href="javascript:NewCal('demo1','ddmmyyyy')">
       <img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
      </td>
    </tr> 
 
   <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
  </table>


<input type="hidden" name="mydate" >

<%

//String h1v1="";
//String h1v2="";
//String h1v3="";
//String h1v4="";
//String h1v5="";
//String h1v6="";
StringBuffer h1v1=new StringBuffer();
StringBuffer h1v2=new StringBuffer();
StringBuffer h1v3=new StringBuffer();
StringBuffer h1v4=new StringBuffer();
StringBuffer h1v5=new StringBuffer();
StringBuffer h1v6=new StringBuffer();


//String h2v1="";
//String h2v2="";
//String h2v3="";
//String h2v4="";
//String h2v5="";
//String h2v6="";
StringBuffer h2v1=new StringBuffer();
StringBuffer h2v2=new StringBuffer();
StringBuffer h2v3=new StringBuffer();
StringBuffer h2v4=new StringBuffer();
StringBuffer h2v5=new StringBuffer();
StringBuffer h2v6=new StringBuffer();

//String h3v1="";
//String edate="";
//String cdate="";

StringBuffer h4v1=new StringBuffer();
StringBuffer h4v2=new StringBuffer();
StringBuffer h4v3=new StringBuffer();
StringBuffer h4v4=new StringBuffer();
StringBuffer h4v5=new StringBuffer();
StringBuffer h4v6=new StringBuffer();

StringBuffer h3v1=new StringBuffer();
StringBuffer edate=new StringBuffer();
StringBuffer cdate=new StringBuffer();




DateFormat formatter1;
java.util.Date hdate ; 
float v11=0,v12=0,v13=0,v14=0,v15=0,v16=0,v17=0,v18=0;
float v19=0,v20=0,v21=0,v22=0;
if(rvalue.toString()!=null && !rvalue.toString().equals("") && !rvalue.toString().equals("null"))
{
%>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
			

	<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_drought_daily_rpt_xls.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|
					<a href="#" onclick="window.close()">Close</a>|
					<a href="./rws_drought_daily_rpt_xls.jsp" target=_new>Excel</a></td></tr>
<%} %>



	<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					
					</td>
				</tr>
			</table>
		</caption>
  


		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
StringBuffer query=new StringBuffer();
try
{   
              

          
	%>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=16>DAILY REPORT ON DRINKING WATER SITUATION&nbsp;&nbsp;:&nbsp;&nbsp;<%=rvalue.toString()%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>

		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>
            <td class=btext rowspan=2>Daily report<br>data available<br>as on given date</td>
            <td class=btext colspan="4">Transportation</td>
             <td class=btext colspan="4">Cattle</td>
            <td class=btext colspan="4">Hiring of Private Sources</td>
            <td class=btext rowspan=2>No.of Habitations <br>having irregular<br> Power Supply/Low <br>Voltage/Insufficient <br>Supply</td>
			
 		</tr>
		<tr align="center">
            <td class=btext>No. of Habs</td>	
			<td class=btext>Population Covered</td>	
			<td class=btext>No.of Trips </td>
            <td class=btext>Quantity in KL </td>
            <td class=btext>No. of Habs</td>	
			<td class=btext>Population Covered</td>	
			<td class=btext>No.of Trips </td>
            <td class=btext>Quantity in KL </td>
            
			<td class=btext>No of Habs</td>
			<td class=btext>Population Served</td>
			<td class=btext>No.of Sources</td>
            <td class=btext>Quantity in KL</td>
			
		</tr>
       <tr align="center">
            <td class=btext>1</td>	
			<td class=btext>2</td>	
			<td class=btext>3</td>
            <td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7</td>
            <td class=btext>8</td>
            <td class=btext>9</td>
			<td class=btext>10</td>
            <td class=btext>11</td>
            <td class=btext>12</td>
             <td class=btext>13</td>
			<td class=btext>14</td>
            <td class=btext>15</td>
            <td class=btext>16</td>
			
			
		</tr>
     
        <%
    
        
        query.delete(0,query.length());
        //String qry2="select distinct count(habitation_code),sum(nvl(POPULATION_SER_PVT_HIRED,0)),sum(nvl(PVT_SOURCES_HIRED_NO,'0')),sum(nvl(PVT_SOURCES_QTY,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"'  and ((POPULATION_SER_PVT_HIRED) >0 or (PVT_SOURCES_HIRED_NO)>0 or  (PVT_SOURCES_QTY)>0) group by substr(habitation_code,1,2),date_of_entry";
    query.append("select distinct count(habitation_code),sum(nvl(POPULATION_SER_PVT_HIRED,0)),sum(nvl(PVT_SOURCES_HIRED_NO,'0')),sum(nvl(PVT_SOURCES_QTY,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"'  and ((POPULATION_SER_PVT_HIRED) >0 or (PVT_SOURCES_HIRED_NO)>0 or  (PVT_SOURCES_QTY)>0) group by substr(habitation_code,1,2),date_of_entry");  
        pst2=conn.createStatement();
        //rs2=pst2.executeQuery(qry2);
       rs2=pst2.executeQuery(query.toString()); 
       // ////System.out.println("first qry..."+qry2);
 //      ////System.out.println("first qry..."+query.toString());
       Hashtable h2=new Hashtable();
       while(rs2.next())
          {
             //hcount++;
            h2.put(rs2.getString(7)+rs2.getString(8),rs2.getString(1)+"@"+rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
             //////System.out.println(h1.put(rs1.getString(1),rs1.getString(2)+"@"+rs1.getString(3)+"@"+rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7)+"@"+rs1.getString(8)+"@"+rs1.getString(9)+"@"+rs1.getString(10)+"@"+rs1.getString(11)));
         }

       
       
       query.delete(0,query.length());

       // String qry="select distinct count(habitation_code),sum(nvl(POPULATION_SER_TRANSPORT,0)),sum(nvl(TANKER_NO_OF_TRIPS,'0')),sum(nvl(tanker_qty,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0)  group by substr(habitation_code,1,2),date_of_entry";
     query.append("select distinct count(habitation_code),sum(nvl(POPULATION_SER_TRANSPORT,0)),sum(nvl(TANKER_NO_OF_TRIPS,'0')),sum(nvl(tanker_qty,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0)  group by substr(habitation_code,1,2),date_of_entry");
       pst=conn.createStatement();
       // rs1=pst.executeQuery(qry);
       rs1=pst.executeQuery(query.toString());
       // ////System.out.println("second qry..."+qry);
 //      ////System.out.println("second qry..."+query.toString());
        Hashtable h1=new Hashtable();
        while(rs1.next())
          {
             //hcount++;
            h1.put(rs1.getString(7)+rs1.getString(8),rs1.getString(1)+"@"+rs1.getString(2)+"@"+rs1.getString(3)+"@"+rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6));
             //////System.out.println(h1.put(rs1.getString(1),rs1.getString(2)+"@"+rs1.getString(3)+"@"+rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7)+"@"+rs1.getString(8)));
         }
        
        query.delete(0,query.length());

        // String qry="select distinct count(habitation_code),sum(nvl(POPULATION_SER_TRANSPORT,0)),sum(nvl(TANKER_NO_OF_TRIPS,'0')),sum(nvl(tanker_qty,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' and ((POPULATION_SER_TRANSPORT) >0 or ( TANKER_NO_OF_TRIPS)>0 or  (tanker_qty)>0)  group by substr(habitation_code,1,2),date_of_entry";
      query.append("select distinct count(habitation_code),sum(nvl(CAT_POPULATION_SER_TRANSPORT,0)),sum(nvl(CAT_TANKER_NO_OF_TRIPS,'0')),sum(nvl(CAT_TANKER_QTY,0)),to_char(date_of_entry,'dd/mm/yyyy'),count(POWER_SUPPLY_REG_IRREG_LOW),substr(habitation_code,1,2),to_char(date_of_entry,'yyyy/mm/dd') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"' and ((CAT_POPULATION_SER_TRANSPORT) >0 or ( CAT_TANKER_NO_OF_TRIPS)>0 or  (CAT_TANKER_QTY)>0)  group by substr(habitation_code,1,2),date_of_entry");
        pst4=conn.createStatement();
        // rs1=pst.executeQuery(qry);
        rs4=pst4.executeQuery(query.toString());
          Hashtable h4=new Hashtable();
       
         while(rs4.next())
           {
              //hcount++;
             h4.put(rs4.getString(7)+rs4.getString(8),rs4.getString(1)+"@"+rs4.getString(2)+"@"+rs4.getString(3)+"@"+rs4.getString(4)+"@"+rs4.getString(5)+"@"+rs4.getString(6));
              //////System.out.println(h1.put(rs1.getString(1),rs1.getString(2)+"@"+rs1.getString(3)+"@"+rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7)+"@"+rs1.getString(8)));
          }

  
        
        query.delete(0,query.length());
                  
       // String qry3="select distinct substr(habitation_code,1,2),max(date_of_entry) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year+"'  and date_of_entry >=to_date('01-01-"+year+"','dd-mm-yyyy') and date_of_entry <=to_date('"+rvalue+"','dd-mm-yyyy') group by substr(habitation_code,1,2)";
	   query.append("select distinct substr(habitation_code,1,2),max(date_of_entry) from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b where habitation_code=habcode and  year='"+year.toString()+"'  and date_of_entry >=to_date('01-01-"+year.toString()+"','dd-mm-yyyy') and date_of_entry <=to_date('"+rvalue.toString()+"','dd-mm-yyyy') group by substr(habitation_code,1,2)");
       pst3=conn.createStatement();
	    //rs3=pst3.executeQuery(qry3);
//	   ////System.out.println("third qry..."+query.toString());
	    rs3=pst3.executeQuery(query.toString());
	   // ////System.out.println("third qry..."+qry3);
	   
	    Hashtable h3=new Hashtable();
	    while(rs3.next())
	       {       
	          h3.put(rs3.getString(1),rs3.getString(2));
	          //////System.out.println(h3.put(rs3.getString(1),rs3.getString(2)));
            }

	    session.setAttribute("h1",h1);
	    session.setAttribute("h2",h2);
	    session.setAttribute("h3",h3);
	    session.setAttribute("h4",h4);
	    
	    query.delete(0,query.length());
	    
          //String qry1="select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
        query.append("select dcode,dname from rws_district_tbl where dcode<>'16' order by dcode");  
          pst2=conn.createStatement();
          //rs2=pst2.executeQuery(qry1);
          rs2=pst2.executeQuery(query.toString());
 //         ////System.out.println("fourth-(district) qry..."+query.toString());
          while(rs2.next())
          {
            //h3values
            //h3values=(String)h3.get(rs2.getString(1));
            h3values.delete(0,h3values.length());
            h3values.append(h3.get(rs2.getString(1)));
            if(h3values!=null&& !h3values.toString().equals("null"))
	        {

             //String v3[]=h3values.split("@");
             String v3[]=h3values.toString().split("@");
                      
             h3v1.delete(0,h3v1.length());
             h3v1.append(v3[0]);//entry date
             
             
             edate.delete(0,edate.length());
             edate.append(h3v1.toString().substring(0,10));//string date
             cdate.delete(0,cdate.length());
             cdate.append(edate.toString().replace("-","/"));

	//		////System.out.println("Converted string to date : " + cdate); 
             }
			else
			{
             //h3v1="";
               h3v1.delete(0,h3v1.length());
             h3v1.append("");
			}

            //end
            

          // h1values=(String)h1.get(rs2.getString(1)+cdate);
            h1values.delete(0,h1values.length()); 
            h1values.append(h1.get(rs2.getString(1)+cdate));
             
            if(h1values!=null&& !h1values.toString().equals("null"))
	        {
           
            // String v1[]=h1values.split("@");
            String v1[]=h1values.toString().split("@");
            
            
            h1v1.delete(0,h1v1.length());
            h1v2.delete(0,h1v2.length());
            h1v3.delete(0,h1v3.length());
            h1v4.delete(0,h1v4.length());
            h1v5.delete(0,h1v5.length());
            h1v6.delete(0,h1v6.length());
            
            
             h1v1.append(v1[0]);//count
             h1v2.append(v1[1]);//pop
             h1v3.append(v1[2]);//trips
             h1v4.append(v1[3]);//qty
             h1v5.append(v1[4]);//date
             h1v6.append(v1[5]);//power
             
             

             v17=Integer.parseInt(h1v1.toString().equals("null")?"0":h1v1.toString());//count
			 v11=Integer.parseInt(h1v2.toString().equals("null")?"0":h1v2.toString());//pop
			 v12=Float.parseFloat(h1v3.toString().equals("null")?"0":h1v3.toString());//trips
			 v13=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v4.toString());//qty
			
            hab_sum+=v17; 			
			pop_sum+=v11;
			trip_sum+=v12;
			qty_sum+=v13;
			
			}
          
			else
			{
                 v11=0;
                 v12=0;
                 v13=0;
                 v17=0;
                // h1v5="";//date
                h1v5.delete(0,h1v5.length());
                h1v5.append("");
               
	        } 
            
            h4values.delete(0,h4values.length()); 
            h4values.append(h4.get(rs2.getString(1)+cdate));
             
            if(h4values!=null&& !h4values.toString().equals("null"))
	        {
           
            // String v4[]=h4values.split("@");
            String v4[]=h4values.toString().split("@");
            h4v1.delete(0,h4v1.length());
            h4v2.delete(0,h4v2.length());
            h4v3.delete(0,h4v3.length());
            h4v4.delete(0,h4v4.length());
            h4v5.delete(0,h4v5.length());
            h4v6.delete(0,h4v6.length());
            
            
          
            
            
             h4v1.append(v4[0]);//count
             h4v2.append(v4[1]);//pop
             h4v3.append(v4[2]);//trips
             h4v4.append(v4[3]);//qty
             h4v5.append(v4[4]);//date
             h4v6.append(v4[5]);//power
             v19=Integer.parseInt(h4v1.toString().equals("null")?"0":h4v1.toString());//count
			 v20=Integer.parseInt(h4v2.toString().equals("null")?"0":h4v2.toString());//pop
			 v21=Float.parseFloat(h4v3.toString().equals("null")?"0":h4v3.toString());//trips
			 v22=Float.parseFloat(h4v4.toString().equals("null")?"0":h4v4.toString());//qty
             
             

            
			 hab_sum2+=v19; 			
				pop_sum2+=v20;
				trip_sum1+=v21;
				qty_sum2+=v22;
			
           
			
			}
          
			else
			{
                 v19=0;
                 v20=0;
                 v21=0;
                 v22=0;
                // h1v5="";//date
                h4v5.delete(0,h4v5.length());
                h4v5.append("");
               
	        } 


            
            
            //h2values=(String)h2.get(rs2.getString(1)+cdate);
            h2values.delete(0,h2values.length());
            h2values.append(h2.get(rs2.getString(1)+cdate));
            
            
            if(h2values!=null && !h2values.toString().equals("null"))
	        {
            	   
             //String v2[]=h2values.split("@");
             String v2[]=h2values.toString().split("@");
          
              
              h2v1.delete(0,h2v1.length());
              h2v2.delete(0,h2v2.length());
              h2v3.delete(0,h2v3.length());
              h2v4.delete(0,h2v4.length());
              h2v5.delete(0,h2v5.length());
              h2v6.delete(0,h2v6.length());
              
              
              
             h2v1.append(v2[0]);//count
             h2v2.append(v2[1]);//pop
             h2v3.append(v2[2]);//trips
             h2v4.append(v2[3]);//qty
             h2v5.append(v2[4]);//date
             h2v6.append(v2[5]);//power

             v18=Integer.parseInt(h2v1.toString().equals("null")?"0":h2v1.toString());//count
			 v14=Integer.parseInt(h2v2.toString().equals("null")?"0":h2v2.toString());//pop
			 v15=Float.parseFloat(h2v3.toString().equals("null")?"0":h2v3.toString());//trips
			 v16=Float.parseFloat(h2v4.toString().equals("null")?"0":h2v4.toString());//qty
				
                  
		            hab_sum1+=v18;			
					pop_sum1+=v14;
					source_sum+=v15;
					qty_sum1+=v16;
			    }
          
			else
			{
                 v14=0;
                 v15=0;
                 v16=0;
                 v18=0;
	        } 


          
         %>

            <tr align="center">
            <td class=rptvalue align="left"><%=count++%></td>
            <%if(v17>0||v18>0){ %>   
            <td class=rptvalue align="left"><b><a href="rws_drought_daily_detailed_rpt.jsp?dcode=<%=rs2.getString(1)%>&dname=<%=rs2.getString(2)%><%if(!h1v5.toString().equals("")){%>&edate=<%=h1v5.toString()%><%}else{%>&edate=<%=h2v5.toString()%><%}%>"><%=rs2.getString(2)%></a></b></td>                
	        <%}else{%>
            <td class=rptvalue align="left"><%=rs2.getString(2)%></td>                
            <%}%>
          
            <%if(!h1v5.equals("")){ %>
            <td class=rptvalue align="right"><%=h1v5%></td>
            <%}else{%>
            <td class=rptvalue align="right"><%=h2v5%></td>
            <%}if(v17>0){ %>           
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h1v1%></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h1v2%></td>	
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v12%></td>	
			<td class=rptvalue align="right"  bgcolor="#FFB280"><%=v13%></td>	
             <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>	
			<%}if(v19>0){ %>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h4v1%></td>
           	<td class=rptvalue align="right"  bgcolor="#FFB280"><%=h4v2%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v21%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v22%></td>	
            <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>	
			
            <%}if(v18>0){ %>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=h2v1%></td>
           	<td class=rptvalue align="right"  bgcolor="#FFB280"><%=h2v2%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v15%></td>
		    <td class=rptvalue align="right"  bgcolor="#FFB280"><%=v16%></td>	
            <%}else{ %>
            <td class=rptvalue align="right">-</td>
            <td class=rptvalue align="right">-</td>	
            <td class=rptvalue align="right">-</td>	
			<td class=rptvalue align="right">-</td>	
            <%}%>
		    <td class=rptvalue align="right">-</td>
			
		</tr>
<%
}


 %>
<tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=3><a href="rws_drought_daily_detailed_rpt.jsp?dcode=ALL">Totals</a></b></td></td>
           
            <td class=btext align="right"><%=hab_sum%></td>
            <td class=btext align="right"><%=pop_sum%></td>	
			<td class=btext align="right"><%=trip_sum%></td>	
			<td class=btext align="right"><%=qty_sum%></td>
			<td class=btext align="right"><%=hab_sum2%></td>
            <td class=btext align="right"><%=pop_sum2%></td>	
			<td class=btext align="right"><%=trip_sum1%></td>	
			<td class=btext align="right"><%=qty_sum2%></td>                  
            <td class=btext align="right"><%=hab_sum1%></td>
			<td class=btext align="right"><%=pop_sum1%></td>
            <td class=btext align="right"><%=source_sum%></td>
            <td class=btext align="right"><%=qty_sum1%></td>          
			<td class=btext align="right"><%=comm_sum%></td>
            
			
		</tr>
<%
}

catch(Exception e)
{
	e.printStackTrace();
}


finally
{
	  h1values = null;
	  h2values = null;
	  h3values = null;
	  h4values=null;
	  currentdate=null;
	  rvalue= null;
	  
	  rDistrict=null;
	  rDistrictName=null;
	  mydatevalues=null;
	  edate=null;
	  year=null;
	  h1v1=null;
	  h1v2=null;
	  h1v3=null;
	  h1v4=null;
	  h1v5=null;
	  h1v6=null;
	  h2v1=null;
	  h2v2=null;
	  h2v3=null;
	  h2v4=null;
	  h2v5=null;
	  h2v6=null;
	  h4v1=null;
	  h4v2=null;
	  h4v3=null;
	  h4v4=null;
	  h4v5=null;
	  h4v6=null;
	  h3v1=null;
	  cdate=null;
	  query=null;

			
try
{
	if(pst != null)
	{
	pst.close();
	}
if(pst2 != null)
{
pst2.close();
}
if(pst3 != null)
{
pst3.close();
}
if(rs1 != null)
{
rs1.close();
}
if(rs2 != null)
{
rs2.close();
}
if(rs3 != null)
{
rs3.close();
}
if(rs4 != null)
{
rs4.close();
}
if( conn != null )
{
conn.close();
}
}
catch(SQLException p)
{
p.printStackTrace();
}
}

%>

</table>
 
<%} %>

</body>
</form>
</html>
<input type="hidden" name="dname"/>
<%@ include file = "footer.jsp" %>
