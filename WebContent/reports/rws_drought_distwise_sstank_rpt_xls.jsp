<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
int count=1;

//String dyear=(String)session.getAttribute("dyear");
StringBuffer dyear=new StringBuffer();
dyear.append(session.getAttribute("dyear"));

//String dname=(String)session.getAttribute("dname");
StringBuffer dname=new StringBuffer();
dname.append(session.getAttribute("dname"));

//String dist_code=(String)session.getAttribute("dcode");
StringBuffer dist_code=new StringBuffer();
dist_code.append(session.getAttribute("dcode"));

//String rvalue=(String)session.getAttribute("rvalue");
StringBuffer rvalue=new StringBuffer();
rvalue.append(session.getAttribute("rvalue"));


//String rvalue1=(String)session.getAttribute("rvalue1");
StringBuffer rvalue1=new StringBuffer();
rvalue1.append(session.getAttribute("rvalue1"));
  
%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		  


		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>DISTRICT WISE DROUGHT SSTANKS REPORT OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp;ON &nbsp;&nbsp;<%=rvalue%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=rvalue1%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		
<%
StringBuffer distcode=new StringBuffer();
StringBuffer dyr=new StringBuffer();

StringBuffer h1values=new StringBuffer();
StringBuffer h2values=new StringBuffer();
StringBuffer h3values=new StringBuffer();
StringBuffer v1=new StringBuffer();
StringBuffer v2=new StringBuffer();
StringBuffer v3=new StringBuffer();
StringBuffer v4=new StringBuffer();
StringBuffer h2v1=new StringBuffer();
StringBuffer h2v2=new StringBuffer();
StringBuffer h2v3=new StringBuffer();
StringBuffer h2v4=new StringBuffer();
StringBuffer h2v5=new StringBuffer();
StringBuffer h2v6=new StringBuffer();
StringBuffer h2v7=new StringBuffer();
StringBuffer h3v1=new StringBuffer();
StringBuffer h3v2=new StringBuffer();
StringBuffer h3v3=new StringBuffer();
StringBuffer h3v4=new StringBuffer();
String ext_fac[]=null;
String tras[]=null;
String workdet[]=null;

StringBuffer query=new StringBuffer();

try
{   
    // String distcode =(String)session.getAttribute("dcode");
    distcode.append(session.getAttribute("dcode"));
     ////System.out.println("this is dcode..."+distcode.toString());
     //String dyr =(String)session.getAttribute("dyr");
     dyr.append(session.getAttribute("dyr"));
     ////System.out.println("this is dyr..."+dyr.toString());
     
    // String h1values="",h2values="",h3values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="";
    // String ext_fac[],tras[],workdet[];
     int v1sum=0,v2sum=0,v4sum=0,v5sum=0;
     double v3sum=0.0;
	%>
		   <tr align="center" bgcolor="#ffffff">
			<tr>	<td class=btext  align=center rowspan="2">Sl.No</td>
					<td class=btext  align=center rowspan="2">HabCode</td>
				     <td class=btext  align=center rowspan="2">Habitation</td>
                    <td class=btext align=center rowspan="2">SSSCode</td>
                     <td class=btext  align="center"  rowspan="2">Population served<br> by Tank</td>
	       <td class=btext  align="center" colspan=2">Scheme details</td>
			<td class=btext  align="center" colspan="2">Source of Feeding</td>
			<td class=btext  align="center" rowspan="2">Tank Capacity(Full)<br> litres in lakhs</td>
		<td class=btext  align="center" rowspan="2">How many days water can be supplied ,<br> if the tank is filled<br> upto full capacity</td>
<td class=btext align="center" rowspan="2">Present status <br> (% of filling)</td>
<td class=btext  align="center" rowspan="2" nowrap>Date of Full Filling</td>
<td class=btext align="center" rowspan="2">Probable date <br>of Canal closure <br>(dd/mm/yy)</td>
<td class=btext  align="center" rowspan="2">Probable date<br> of re opening and<br> intermitant fillings <br>if any (dd/mm/yy)</td>
<td class=btext  align="center" rowspan="2">Whether steps have <br>been taken to fill up  <br>SS Tank to full capacity <br> before canal closure <br> and contingent plan to <br> fill up tank to  <br>full capacity</td>
<td class=btext align="center" rowspan="2">Steps Taken</td>
<td class=btext  align="center" rowspan="2">Identified alternative <br>measures to mitigate<br> scarcity(if araises) in case<br> of longer canal closure due <br>to Mtc./Non filling of<br> Tank to full capacity etc.</td>
<td class=btext align="center" rowspan="2">Identified Alternatives</td>
<td class=btext  align="center" rowspan="2">Remarks<br>(specific problems and also <br>reasons for less than 50% <br>filling and present supply <br>measures for 0% filling))</td>
</tr>
<tr>
<td class=btext align="center">Scheme Name</td>
<td class=btext  align="center">No. of habs covering</td>
<td class=btext  align="center">Name of <br>River/Vagu /etc.</td>
<td class=btext  align="center">Canal Name</td>
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
		</tr>
     
        <%
 //queries

           Hashtable h1=(Hashtable)session.getAttribute("h1");
        
        query.delete(0,query.length());
        query.append("SELECT distinct a.hab_code,b.panch_name,SSSC_CODE,nvl(popu_served,0),river_name,canal_name,tank_capacity,no_of_days_serve,present_status,to_char(fill_date,'dd/mm/yyyy'),to_char(prob_canal_clos_dt,'dd/mm/yyyy') ,to_char(prob_canal_reopen_dt,'dd/mm/yyyy') ,steps_taken,nvl(steps_taken_reason,'-'),identified_alternative,nvl(identified_alternative_reason,'-'),nvl(remarks,'-') FROM RWS_DROUGHT_SSTANK_TBL a,rws_panchayat_raj_tbl b WHERE a.hab_code=b.panch_code and SUBSTR(a.HAB_CODE,1,2)='"+distcode+"' and drought_date>=to_date('"+rvalue+"','dd-mm-yyyy') and drought_date<=to_date('"+rvalue1+"','dd-mm-yyyy')");
          pst1=conn.createStatement();
          rs1=pst1.executeQuery(query.toString());
          ////System.out.println("my qry1 "+query.toString());
          while(rs1.next())
          {
           //hash1 values getting
             h1values.delete(0,h1values.length());
            h1values.append(h1.get(rs1.getString(1)));
           // if(h1values!=null)
        	   if(h1values!=null&& !h1values.toString().equals("null"))
            {
             ext_fac=h1values.toString().split("@");
             v1.delete(0,v1.length());
             v1.append(ext_fac[0]);
             
             v2.delete(0,v2.length());
			 v2.append(ext_fac[1]);
			// v3=ext_fac[2];
			v2sum+=Integer.parseInt(v2.toString().equals("null")?"0":v2.toString());
             }
           else
			{	
	         v1.append("-");
			 v2.append("-");
			// v3="-";
			}
            //end
    
         %>
        <tr align="center">
           <td class=rptvalue align="left"><%=count++%></td>
           <td class=rptvalue align="left">&nbsp;<%=rs1.getString(1)%></td>
            <td class=rptvalue align="left"><%=rs1.getString(2)%></td>
            <td class=rptvalue align="left"><%=rs1.getString(3)%></td>		
			<td class=rptvalue align="center"><%=rs1.getString(4)%></td>	
			 <td class=rptvalue align="center"><%=v1 %></td>
<td class=rptvalue align="center"><%=v2%></td>
<td class=rptvalue align="center"><%=rs1.getString(5)%></td>
			<td class=rptvalue align="right"><%=rs1.getString(6)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(7)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(8)%></td>
           <td class=rptvalue align="center"><%=rs1.getString(9)%></td>
           <td class=rptvalue align="left" nowrap><%=rs1.getString(10)%></td>	
            <td class=rptvalue align="left"><%=rs1.getString(11)%></td>	
			<td class=rptvalue align="left"><%=rs1.getString(12)%></td>	
			 <td class=rptvalue align="center"><%=rs1.getString(13)%></td>
            <td class=rptvalue align="right"><%=rs1.getString(14)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(15)%></td>
			<td class=rptvalue align="right"><%=rs1.getString(16)%></td>
            <td class=rptvalue align="center"><%=rs1.getString(17)%></td>
             </tr>
	<%
   v1sum+=Integer.parseInt(rs1.getString(4));
   v3sum+=Double.parseDouble(rs1.getString(7));
   v4sum+=Integer.parseInt(rs1.getString(8));
   v5sum+=Integer.parseInt(rs1.getString(9));
}
    

%>
       <tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=4>Totals</td>
             <td class=btext align="right"><%=v1sum%></td>
			 <td class=btext align="right">-</td>
             <td class=btext align="right"><%=v2sum%></td>
            <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
			<td class=btext align="right"><%=v3sum%></td>
			<td class=btext align="right"><%=v4sum%></td>
			<td class=btext align="right"><%=v5sum%></td>
           <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
			<td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
<td class=btext align="right">-</td>
             <td class=btext align="right">-</td>
		</tr>
<%
}

catch(Exception e1)
{
	e1.printStackTrace();
}
%>
</table>

</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
