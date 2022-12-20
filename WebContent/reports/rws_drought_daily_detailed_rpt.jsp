<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%@page import="java.util.Date" %>
<%

nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());




ResultSet rs1=null,rs2=null,rs3=null;
Statement pst = null,pst2=null,pst3=null;
int count=1,hcount=0,pvtsum=0,display=0;
int popcount=0,prv_pop=0,catpopcount=0;
int pop_sum=0,prv_popsum=0,catpop_sum=0;
float qtycount=0,qty_supp=0,sourcount=0,tank_cap=0,trip_sum=0,tripcount=0,cattripcount=0,tant_sum=0,qty_sum=0,qty_suppsum=0,cattank_cap=0,catqtycount=0;
float cattant_sum=0,cattrip_sum=0,catqty_sum=0,sour_sum=0;

//String h1v1="",h1v3="",h1v5="",h1v7="",h1v8="",h1v9="",h1v10="",h1v11="",h1v12="",h1v13="",h1v14="",h1v15="",h1v4="",h1v2="",h1v6="",h1v16="";
StringBuffer h1v1=new StringBuffer();
StringBuffer h1v2=new StringBuffer();
StringBuffer h1v3=new StringBuffer();
StringBuffer h1v4=new StringBuffer();
StringBuffer h1v5=new StringBuffer();
StringBuffer h1v6=new StringBuffer();
StringBuffer h1v7=new StringBuffer();
StringBuffer h1v8=new StringBuffer();
StringBuffer h1v9=new StringBuffer();
StringBuffer h1v10=new StringBuffer();
StringBuffer h1v11=new StringBuffer();
StringBuffer h1v12=new StringBuffer();
StringBuffer h1v13=new StringBuffer();
StringBuffer h1v14=new StringBuffer();
StringBuffer h1v15=new StringBuffer();
StringBuffer h1v16=new StringBuffer();
StringBuffer h1v17=new StringBuffer();
StringBuffer h1v18=new StringBuffer();
StringBuffer h1v19=new StringBuffer();
StringBuffer h1v20=new StringBuffer();
StringBuffer h1v21=new StringBuffer();


//String h1values="",h2values="";
StringBuffer h1values=new StringBuffer();
StringBuffer h2values=new StringBuffer();



//first time display purpose
//String s;
StringBuffer s=new StringBuffer();
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s.append(formatter.format(date));





//String currentdate=s.replace("/","-");
StringBuffer currentdate=new StringBuffer();
currentdate.append(s.toString().replace("/","-"));
//System.out.println("current"+currentdate);




//String rDistrict = request.getParameter("rDistrict");
StringBuffer rDistrict=new StringBuffer();
rDistrict.append(request.getParameter("rDistrict"));
if(rDistrict.toString()!=null){
session.setAttribute("rDistrict",rDistrict.toString());
}




//String rDistrictName =(String)session.getAttribute("rDistrictName");
StringBuffer rDistrictName=null;
rDistrictName=new StringBuffer(String.valueOf(session.getAttribute("rDistrictName")));
//System.out.println("dname value........"+rDistrictName.toString());




//String rvalue=(String)session.getAttribute("rvalue");
StringBuffer rvalue=null;
rvalue=new StringBuffer(String.valueOf(session.getAttribute("rvalue")));
if(rvalue.toString()==null)
rvalue.append(currentdate.toString());
//System.out.println("detailed rvalue........"+rvalue.toString());



//String dcode=request.getParameter("dcode");
StringBuffer dcode=new StringBuffer();
dcode.append(request.getParameter("dcode"));

//System.out.println("dcode value........"+dcode.toString());



//String edate = request.getParameter("edate");
StringBuffer edate=new StringBuffer();
edate.append(request.getParameter("edate"));
//System.out.println("edate value........"+edate.toString());



//String dname=request.getParameter("dname");
StringBuffer dname=new StringBuffer();
dname.append(request.getParameter("dname"));
//System.out.println("dname value........"+dname.toString());




String mydatevalues[]=null;
mydatevalues=edate.toString().split("/");
//////System.out.println("my date value......."+edate);
for(int k=0;k<mydatevalues.length;k++)
{
//////System.out.println("myvalues......."+mydatevalues[k]);

}


SimpleDateFormat df = new SimpleDateFormat("yyyy");
Date date1= new Date();


StringBuffer year=new StringBuffer();
year=new StringBuffer(String.valueOf(session.getAttribute("year")));
//////System.out.println("myyear......."+year.toString());



session.setAttribute("dcode",dcode.toString());
session.setAttribute("edate",edate.toString());
session.setAttribute("year",year.toString());
session.setAttribute("dname",dname.toString());
%>

<html>
<form name=f1>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">

					<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_drought_daily_detailed_xls.jsp" target=_new>Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a>|<a href="./rws_drought_daily_detailed_xls.jsp" target=_new>Excel</a></td></tr>
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
  


		<%if(dcode.toString().equals("ALL")){ %>
  			
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>DETAILED DAILY REPORT ON DRINKING WATER SITUATION&nbsp;&nbsp;&nbsp;&nbsp;OF <%=dcode.toString()%>&nbsp;&nbsp;:&nbsp;&nbsp;<%=rvalue.toString()%> &nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		<% }else{ %>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=23>DETAILED DAILY REPORT ON DRINKING WATER SITUATION&nbsp;&nbsp;&nbsp;&nbsp;OF <%=dname%>&nbsp;&nbsp;:&nbsp;&nbsp;<%=rvalue.toString()%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		<% } 
StringBuffer query=new StringBuffer();
try
{   

	%>
		   <tr align="center" bgcolor="#ffffff">
			<td class=btext align="center" rowspan="2">S.No.</td>
			<% if(dcode.toString().equals("ALL")){ %>
				<td class=btext align="center" rowspan="2">District S.No.</td>
				<td class=btext align="center" rowspan="2">District</td>
			<% } %>
			<td class=btext align="center" rowspan="2">Mandal</td>
			<td class=btext align="center" rowspan="2">Hab Code</td>
			<td class=btext align="center"  rowspan="2">Hab Name </td>
           <td class=btext rowspan=2>Daily report<br>data available<br>as on given date</td>
			<td class=btext align="center" colspan="5">Transport </td>
			<td class=btext align="center" colspan="5">Cattle </td>
			<td class=btext align="center" colspan="6">Private Sources </td>
			<td class=btext align="center" colspan="2">Power Supply </td>
			</tr>
			<tr>
			<td class=btext align="center">Population Served</td>
			<td class=btext align="center">Tanker Capacity(KL)</td>
			<td class=btext align="center">No.of Trips </td>
			<td class=btext align="center">Quantity(KL) </td>
			<td class=btext align="center">Remarks</td>
			<td class=btext align="center">Population Served</td>
			<td class=btext align="center">Tanker Capacity(KL)</td>
			<td class=btext align="center">No.of Trips </td>
			<td class=btext align="center">Quantity(KL) </td>
			<td class=btext align="center">Remarks</td>
			<td class=btext align="center">Population Served </td>
			<td class=btext align="center">Type</td>
			<td class=btext align="center">No.of PriviteSources Hired</td>
			<td class=btext align="center">Mode of Supply from hired Sources</td>
			<td class=btext align="center">Quantity Supplied(KL)</td>
			<td class=btext align="center">Remarks</td>
			<td class=btext align="center">Irregular power<br>Supply</td>
			<td class=btext align="center">Remarks</td>
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
			<td class=btext>17</td>
			<td class=btext>18</td>
			<td class=btext>19</td>
            <td class=btext>20</td>
			<td class=btext>21</td>
			<td class=btext>22</td>
			<td class=btext>23</td>
			<%if(dcode.toString().equals("ALL")){ %>
			<td class=btext>24</td>
			<td class=btext>25</td>
			<%} %>
			
		</tr>
     
         <%
         
        if(dcode.toString().equals("ALL")){
        	 query.delete(0,query.length());
        	 query.append("select distinct substr(habitation_code,1,2),to_char(max(date_of_entry),'dd/mm/yyyy') from rws_drought_hab_tr_pvt_so_tbl a, rws_drought_habitation_tbl b,rws_district_tbl c where substr(habitation_code,1,2)=c.dcode and habitation_code=habcode and  year='"+year.toString()+"'  and date_of_entry >=to_date('01-01-"+year.toString()+"','dd-mm-yyyy') and date_of_entry <=to_date('"+rvalue.toString()+"','dd-mm-yyyy') group by substr(habitation_code,1,2) order by substr(habitation_code,1,2)");
        	// query.append("select distinct dcode,dname,max(date_of_entry) from rws_district_tbl order by dcode");
				//System.out.println("my qry1 "+query);
                pst3=conn.createStatement();
                    rs3=pst3.executeQuery(query.toString());
              
                //////System.out.println("my qry1 "+qry1);
                while(rs3.next()){
                	 int i=0;
                 query.delete(0,query.length());
        	query.append("select distinct mcode,mname from rws_mandal_tbl where dcode='"+rs3.getString(1)+"'");
        	//System.out.println("my qry bbbbbbbbb"+query);
       pst2=conn.createStatement();
           rs2=pst2.executeQuery(query.toString());
                    while(rs2.next())        {
                  
         query.delete(0,query.length());
        // String qry="select distinct habitation_code,panch_name,POPULATION_SER_TRANSPORT,TANKER_CAPACITY,TANKER_NO_OF_TRIPS,tanker_qty,nvl(TANKER_REMARKS,'-'),POPULATION_SER_PVT_HIRED,ASSET_TYPE_CODE,pvt_sources_hired_no,PVT_MODE_OF_SUPPLY ,pvt_sources_qty,nvl(PVT_SOURCES_REMARKS,'-'),nvl(power_supply_reg_irreg_low,'-'),nvl(POWER_SUPPLY_REMARKS,'-'),to_char(date_of_entry,'dd/mm/yyyy') from rws_drought_hab_tr_pvt_so_tbl a,rws_panchayat_raj_tbl b ,rws_drought_habitation_tbl c where a.habitation_code=c.habcode and c.year='"+year+"' and  substr(habitation_code,1,2)='"+dcode+"' and substr(habitation_code,6,2)='"+rs2.getString(1)+"' and a.habitation_code=b.panch_code and date_of_entry=to_date('"+edate+"','dd-mm-yyyy') and (POPULATION_SER_TRANSPORT>0 or TANKER_CAPACITY>0 or TANKER_NO_OF_TRIPS>0 or POPULATION_SER_PVT_HIRED>0 or pvt_sources_hired_no>0 or pvt_sources_qty>0 )";
         query.append("select distinct habitation_code,panch_name,POPULATION_SER_TRANSPORT,TANKER_CAPACITY,TANKER_NO_OF_TRIPS,tanker_qty,nvl(TANKER_REMARKS,'-'),POPULATION_SER_PVT_HIRED,ASSET_TYPE_CODE,pvt_sources_hired_no,PVT_MODE_OF_SUPPLY ,pvt_sources_qty,nvl(PVT_SOURCES_REMARKS,'-'),nvl(power_supply_reg_irreg_low,'-'),nvl(POWER_SUPPLY_REMARKS,'-'),to_char(date_of_entry,'dd/mm/yyyy'),nvl(CAT_POPULATION_SER_TRANSPORT,0),nvl(CAT_TANKER_CAPACITY,0),nvl(CAT_TANKER_NO_OF_TRIPS,0),nvl(CAT_TANKER_QTY,0),nvl(CAT_TANKER_REMARKS,'-') from rws_drought_hab_tr_pvt_so_tbl a,rws_panchayat_raj_tbl b ,rws_drought_habitation_tbl c where a.habitation_code=c.habcode and c.year='"+year.toString()+"' and  substr(habitation_code,1,2)='"+rs3.getString(1)+"' and substr(habitation_code,6,2)='"+rs2.getString(1)+"' and a.habitation_code=b.panch_code and date_of_entry=to_date('"+rs3.getString(2)+"','dd-mm-yyyy') and (POPULATION_SER_TRANSPORT>0 or TANKER_CAPACITY>0 or TANKER_NO_OF_TRIPS>0 or POPULATION_SER_PVT_HIRED>0 or pvt_sources_hired_no>0 or pvt_sources_qty>0 or CAT_TANKER_CAPACITY>0 or CAT_POPULATION_SER_TRANSPORT>0 or CAT_TANKER_NO_OF_TRIPS>0 or CAT_TANKER_QTY>0 or CAT_TANKER_CAPACITY>0)");
        //System.out.println("my qry bbbbbbbbb"+query);
          pst=conn.createStatement();
          //rs1=pst.executeQuery(qry);
          rs1=pst.executeQuery(query.toString());
           while(rs1.next())   {
        	   i=i+1;
	           
        	   
        	   h1v1.delete(0,h1v1.length());
        	   h1v2.delete(0,h1v2.length());
        	   h1v3.delete(0,h1v3.length());
        	   h1v4.delete(0,h1v4.length());
        	   h1v5.delete(0,h1v5.length());
        	   h1v6.delete(0,h1v6.length());
        	   h1v7.delete(0,h1v7.length());
        	   h1v8.delete(0,h1v8.length());
        	   h1v9.delete(0,h1v9.length());
        	   h1v10.delete(0,h1v10.length());
        	   h1v11.delete(0,h1v11.length());
        	   h1v12.delete(0,h1v12.length());
        	   h1v13.delete(0,h1v13.length());
        	   h1v14.delete(0,h1v14.length());
        	   h1v15.delete(0,h1v15.length());
        	   h1v16.delete(0,h1v16.length());
        	   h1v17.delete(0,h1v17.length());
        	   h1v18.delete(0,h1v18.length());
        	   h1v19.delete(0,h1v19.length());
        	   h1v20.delete(0,h1v20.length());
        	   h1v21.delete(0,h1v21.length());
        	  
        	
        	   
                h1v1.append(rs1.getString(1));
				h1v2.append(rs1.getString(2));
	            h1v3.append(rs1.getString(3));
				h1v4.append(rs1.getString(4));
				h1v5.append(rs1.getString(5));
				h1v6.append(rs1.getString(6));
				h1v7.append(rs1.getString(7));
				h1v8.append(rs1.getString(8));
				h1v9.append(rs1.getString(9));
				h1v10.append(rs1.getString(10));
				h1v11.append(rs1.getString(11));
				h1v12.append(rs1.getString(12));
				h1v13.append(rs1.getString(13));
				h1v14.append(rs1.getString(14));
				h1v15.append(rs1.getString(15));
                h1v16.append(rs1.getString(16));
                h1v17.append(rs1.getString(17));
				h1v18.append(rs1.getString(18));
				h1v19.append(rs1.getString(19));
				h1v20.append(rs1.getString(20));
                h1v21.append(rs1.getString(21));
                
               
                
             popcount=Integer.parseInt(h1v3.toString().equals("null")?"0":h1v3.toString());
             tank_cap=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v4.toString());
			 tripcount=Float.parseFloat(h1v5.toString().equals("null")?"0":h1v5.toString());
			 qtycount=Float.parseFloat(h1v6.toString().equals("null")?"0":h1v6.toString());
			 catpopcount=Integer.parseInt(h1v3.toString().equals("null")?"0":h1v17.toString());
             cattank_cap=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v18.toString());
			 cattripcount=Float.parseFloat(h1v5.toString().equals("null")?"0":h1v19.toString());
			catqtycount=Float.parseFloat(h1v6.toString().equals("null")?"0":h1v20.toString());
			 prv_pop=Integer.parseInt(h1v8.toString().equals("null")?"0":h1v8.toString());
    		 sourcount=Float.parseFloat(h1v10.toString().equals("null")?"0":h1v10.toString());
			 qty_supp=Float.parseFloat(h1v12.toString().equals("null")?"0":h1v12.toString());


            pop_sum+=popcount;
			tant_sum+=tank_cap;
			trip_sum+=tripcount;
			qty_sum+=qtycount;
			 catpop_sum+=catpopcount;
				cattant_sum+=cattank_cap;
				
				catqty_sum+=catqtycount;
				cattrip_sum+=cattripcount;
			
			prv_popsum+=prv_pop;
			sour_sum+=sourcount;
			qty_suppsum+=qty_supp;
         
         %>
      <tr align="center">
            <td class=rptvalue align="left"><%=count++%></td>
             <td class=rptvalue align="left"><%=i%></td>
            <%String q1="select dname from rws_district_tbl where dcode='"+rs3.getString(1)+"'";
            	Statement stmt1=conn.createStatement();
            	ResultSet rs4=stmt1.executeQuery(q1);
            	if(rs4.next()){
            	%>
            <td class=rptvalue align="left"><%=rs4.getString("dname")%></td>  
            <%}rs4.close();
            stmt1.close();%>   
            <td class=rptvalue align="left"><%=rs2.getString(2)%></td>                    
            <td class=rptvalue align="left"><%=h1v1.toString()%></td>	
            <td class=rptvalue align="left"><%=h1v2.toString()%></td>	
            <td class=rptvalue align="left"><%=h1v16.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v3.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v4.toString()%></td>
            <td class=rptvalue align="right"><%=h1v5.toString()%></td>
			<td class=rptvalue align="right"><%=h1v6.toString()%></td>
            <td class=rptvalue align="center"><%=h1v7.toString()%></td>
            <td class=rptvalue align="right"><%=h1v17.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v18.toString()%></td>
            <td class=rptvalue align="right"><%=h1v19.toString()%></td>
			<td class=rptvalue align="right"><%=h1v20.toString()%></td>
            <td class=rptvalue align="center"><%=h1v21.toString()%></td>
            <td class=rptvalue align="right"><%=h1v8.toString()%></td>
			<td class=rptvalue align="right"><%=h1v9.toString()%></td>
            <td class=rptvalue align="right"><%=h1v10.toString()%></td>
			<td class=rptvalue align="right"><%=h1v11.toString()%></td>
			<td class=rptvalue align="right"><%=h1v12.toString()%></td>
            <td class=rptvalue align="center"><%=h1v13.toString()%></td>
            <td class=rptvalue align="right"><%=h1v14.toString()%></td>
            <td class=rptvalue align="center"><%=h1v15.toString()%></td>
            
            
		</tr>
			<%
  			 		}rs1.close();pst.close();
				}rs2.close();pst2.close();
          	}rs3.close();pst3.close();
        }else{

        query.append("select distinct mcode,mname from rws_mandal_tbl where dcode='"+dcode.toString()+"'");
       // String qry1="select distinct mcode,mname from rws_mandal_tbl where dcode='"+dcode+"'";         
          //////System.out.println("my qry1 "+qry1);
          pst2=conn.createStatement();
         // rs2=pst2.executeQuery(qry1);
         rs2=pst2.executeQuery(query.toString());
          //////System.out.println("my qry1 "+qry1);
          
          
          while(rs2.next())
          {
         query.delete(0,query.length());
        //  String qry="select distinct habitation_code,panch_name,POPULATION_SER_TRANSPORT,TANKER_CAPACITY,TANKER_NO_OF_TRIPS,tanker_qty,nvl(TANKER_REMARKS,'-'),POPULATION_SER_PVT_HIRED,ASSET_TYPE_CODE,pvt_sources_hired_no,PVT_MODE_OF_SUPPLY ,pvt_sources_qty,nvl(PVT_SOURCES_REMARKS,'-'),nvl(power_supply_reg_irreg_low,'-'),nvl(POWER_SUPPLY_REMARKS,'-'),to_char(date_of_entry,'dd/mm/yyyy') from rws_drought_hab_tr_pvt_so_tbl a,rws_panchayat_raj_tbl b ,rws_drought_habitation_tbl c where a.habitation_code=c.habcode and c.year='"+year+"' and  substr(habitation_code,1,2)='"+dcode+"' and substr(habitation_code,6,2)='"+rs2.getString(1)+"' and a.habitation_code=b.panch_code and date_of_entry=to_date('"+edate+"','dd-mm-yyyy') and (POPULATION_SER_TRANSPORT>0 or TANKER_CAPACITY>0 or TANKER_NO_OF_TRIPS>0 or POPULATION_SER_PVT_HIRED>0 or pvt_sources_hired_no>0 or pvt_sources_qty>0 )";
        query.append("select distinct habitation_code,panch_name,POPULATION_SER_TRANSPORT,TANKER_CAPACITY,TANKER_NO_OF_TRIPS,tanker_qty,nvl(TANKER_REMARKS,'-'),POPULATION_SER_PVT_HIRED,ASSET_TYPE_CODE,pvt_sources_hired_no,PVT_MODE_OF_SUPPLY ,pvt_sources_qty,nvl(PVT_SOURCES_REMARKS,'-'),nvl(power_supply_reg_irreg_low,'-'),nvl(POWER_SUPPLY_REMARKS,'-'),to_char(date_of_entry,'dd/mm/yyyy'),nvl(CAT_POPULATION_SER_TRANSPORT,0),nvl(CAT_TANKER_CAPACITY,0),nvl(CAT_TANKER_NO_OF_TRIPS,0),nvl(CAT_TANKER_QTY,0),nvl(CAT_TANKER_REMARKS,'-') from rws_drought_hab_tr_pvt_so_tbl a,rws_panchayat_raj_tbl b ,rws_drought_habitation_tbl c where a.habitation_code=c.habcode and c.year='"+year.toString()+"' and  substr(habitation_code,1,2)='"+dcode+"' and substr(habitation_code,6,2)='"+rs2.getString(1)+"' and a.habitation_code=b.panch_code and date_of_entry=to_date('"+edate+"','dd-mm-yyyy') and (POPULATION_SER_TRANSPORT>0 or TANKER_CAPACITY>0 or TANKER_NO_OF_TRIPS>0 or POPULATION_SER_PVT_HIRED>0 or pvt_sources_hired_no>0 or pvt_sources_qty>0 or CAT_TANKER_CAPACITY>0 or CAT_POPULATION_SER_TRANSPORT>0 or CAT_TANKER_NO_OF_TRIPS>0 or CAT_TANKER_QTY>0 or CAT_TANKER_CAPACITY>0)");
        //System.out.println("my qry bbbbbbbbb"+query);
          pst=conn.createStatement();
          //rs1=pst.executeQuery(qry);
          rs1=pst.executeQuery(query.toString());
           while(rs1.next())
           {
	           
        	   
        	   h1v1.delete(0,h1v1.length());
        	   h1v2.delete(0,h1v2.length());
        	   h1v3.delete(0,h1v3.length());
        	   h1v4.delete(0,h1v4.length());
        	   h1v5.delete(0,h1v5.length());
        	   h1v6.delete(0,h1v6.length());
        	   h1v7.delete(0,h1v7.length());
        	   h1v8.delete(0,h1v8.length());
        	   h1v9.delete(0,h1v9.length());
        	   h1v10.delete(0,h1v10.length());
        	   h1v11.delete(0,h1v11.length());
        	   h1v12.delete(0,h1v12.length());
        	   h1v13.delete(0,h1v13.length());
        	   h1v14.delete(0,h1v14.length());
        	   h1v15.delete(0,h1v15.length());
        	   h1v16.delete(0,h1v16.length());
        	   h1v17.delete(0,h1v17.length());
        	   h1v18.delete(0,h1v18.length());
        	   h1v19.delete(0,h1v19.length());
        	   h1v20.delete(0,h1v20.length());
        	   h1v21.delete(0,h1v21.length());
        	   
                h1v1.append(rs1.getString(1));
				h1v2.append(rs1.getString(2));
	            h1v3.append(rs1.getString(3));
				h1v4.append(rs1.getString(4));
				h1v5.append(rs1.getString(5));
				h1v6.append(rs1.getString(6));
				h1v7.append(rs1.getString(7));
				h1v8.append(rs1.getString(8));
				h1v9.append(rs1.getString(9));
				h1v10.append(rs1.getString(10));
				h1v11.append(rs1.getString(11));
				h1v12.append(rs1.getString(12));
				h1v13.append(rs1.getString(13));
				h1v14.append(rs1.getString(14));
				h1v15.append(rs1.getString(15));
                h1v16.append(rs1.getString(16));
                h1v17.append(rs1.getString(17));
				h1v18.append(rs1.getString(18));
				h1v19.append(rs1.getString(19));
				h1v20.append(rs1.getString(20));
                h1v21.append(rs1.getString(21));
 
                
               
                
             popcount=Integer.parseInt(h1v3.toString().equals("null")?"0":h1v3.toString());
             tank_cap=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v4.toString());
			 tripcount=Float.parseFloat(h1v5.toString().equals("null")?"0":h1v5.toString());
			 qtycount=Float.parseFloat(h1v6.toString().equals("null")?"0":h1v6.toString());
			 catpopcount=Integer.parseInt(h1v3.toString().equals("null")?"0":h1v17.toString());
             cattank_cap=Float.parseFloat(h1v4.toString().equals("null")?"0":h1v18.toString());
			 cattripcount=Float.parseFloat(h1v5.toString().equals("null")?"0":h1v19.toString());
			catqtycount=Float.parseFloat(h1v6.toString().equals("null")?"0":h1v20.toString());
			 prv_pop=Integer.parseInt(h1v8.toString().equals("null")?"0":h1v8.toString());
    		 sourcount=Float.parseFloat(h1v10.toString().equals("null")?"0":h1v10.toString());
			 qty_supp=Float.parseFloat(h1v12.toString().equals("null")?"0":h1v12.toString());


            pop_sum+=popcount;
			tant_sum+=tank_cap;
			trip_sum+=tripcount;
			qty_sum+=qtycount;
			 catpop_sum+=catpopcount;
				cattant_sum+=cattank_cap;
				cattrip_sum+=cattripcount;
				catqty_sum+=catqtycount;
			prv_popsum+=prv_pop;
			sour_sum+=sourcount;
			qty_suppsum+=qty_supp;
         
         %>
      <tr align="center">
            <td class=rptvalue align="left"><%=count++%></td>
            <td class=rptvalue align="left"><%=rs2.getString(2)%></td>                    
            <td class=rptvalue align="left"><%=h1v1.toString()%></td>	
            <td class=rptvalue align="left"><%=h1v2.toString()%></td>	
            <td class=rptvalue align="left"><%=h1v16.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v3.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v4.toString()%></td>
            <td class=rptvalue align="right"><%=h1v5.toString()%></td>
			<td class=rptvalue align="right"><%=h1v6.toString()%></td>
            <td class=rptvalue align="center"><%=h1v7.toString()%></td>
            <td class=rptvalue align="right"><%=h1v17.toString()%></td>	
			<td class=rptvalue align="right"><%=h1v18.toString()%></td>
            <td class=rptvalue align="right"><%=h1v19.toString()%></td>
			<td class=rptvalue align="right"><%=h1v20.toString()%></td>
            <td class=rptvalue align="center"><%=h1v21.toString()%></td>
            <td class=rptvalue align="right"><%=h1v8.toString()%></td>
			<td class=rptvalue align="right"><%=h1v9.toString()%></td>
            <td class=rptvalue align="right"><%=h1v10.toString()%></td>
			<td class=rptvalue align="right"><%=h1v11.toString()%></td>
			<td class=rptvalue align="right"><%=h1v12.toString()%></td>
            <td class=rptvalue align="center"><%=h1v13.toString()%></td>
            <td class=rptvalue align="right"><%=h1v14.toString()%></td>
            <td class=rptvalue align="center"><%=h1v15.toString()%></td>
            
		</tr>
	<%
           }rs1.close();pst.close();

          }rs2.close();pst2.close();
                  }

%>
<tr align="center" class=btext bgcolor="#ffffff">
          <%if(dcode.toString().equals("ALL")) {%>
		<td class=btext colspan=7>Totals</td>
		<%}else{ %>
           <td class=btext colspan=5>Totals</td>
           <%} %>
            <td class=btext align="right"><%=pop_sum %></td>	
			<td class=btext align="right"><%=tant_sum%></td>
            <td class=btext align="right"><%=trip_sum %></td>
			<td class=btext align="right"><%=qty_sum%></td>
            <td class=btext align="right"></td>
             <td class=btext align="right"><%=catpop_sum %></td>	
			<td class=btext align="right"><%=cattant_sum%></td>
            <td class=btext align="right"><%=cattrip_sum %></td>
			<td class=btext align="right"><%=catqty_sum%></td>
			 <td class=btext align="right"></td>
            <td class=btext align="right"><%=prv_popsum %></td>
			<td class=btext align="right"></td>
            <td class=btext align="right"><%=sour_sum %></td>
			<td class=btext align="right"></td>
            <td class=btext align="right"><%= qty_suppsum%></td>
            <td class=btext align="right"></td>
			<td class=btext align="right"></td>
            <td class=btext align="right"></td>
			
		</tr>
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	  h1v1=null;
	  h1v2=null;
	  h1v3=null;
	  h1v4=null;
	  h1v5=null;
	  h1v6=null;
	  h1v7=null;
	  h1v8=null;
	  h1v9=null;
	  h1v10=null;
	  h1v11=null;
	  h1v12=null;
	  h1v13=null;
	  h1v14=null;
	  h1v15=null;
	  h1v16=null;
	  h1v16=null;
	  h1v17=null;
	  h1v18=null;
	  h1v19=null;
	  h1v20=null;
	  h1v21=null;
	  h1values=null;
	  h2values=null;
	  s=null;
	  currentdate=null;
	  rDistrict=null;
	  rDistrictName=null;
	  rvalue=null;
	  dcode=null;
	  edate=null;
	  dname=null;
	  mydatevalues=null;
	  year=null;

	  query=null;

			
try
{
if(pst != null)
{
pst.close();
}
if(rs1 != null)
{
rs1.close();
}
if(pst2 != null)
{
pst2.close();
}
if(rs2 != null)
{
rs2.close();
}
if(pst3 != null)
{
pst3.close();
}
if(rs3 != null)
{
rs3.close();
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
</body>
</form>
</html>
<%@ include file = "footer.jsp" %>
