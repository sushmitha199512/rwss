<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_drought_ongoing_works_rpt_xls.xls");

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
Statement pst1 = null,pst2=null,pst3=null,pst4=null;
int count=1;
//first time display purpose
String s;
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s = formatter.format(date);
String currentdate=s.replace("/","-");
//System.out.println("current"+currentdate);
String rvalue=(String)session.getAttribute("rvalue");
String rvalue1=(String)session.getAttribute("rvalue1");

//System.out.println("rvalue"+rvalue);
//System.out.println("rvalue1"+rvalue1);

String distcode =(String)session.getAttribute("dcode");
String dname=(String)session.getAttribute("dname");
//System.out.println("xls distcode"+distcode);

%>

<html>
<head>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
</head>
<form name=f1>
<body bgcolor="#edf2f8">


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=25>DROUGHT ONGOING WORKS REPORT OF&nbsp;:&nbsp;&nbsp;<%=dname%>&nbsp;&nbsp;ON:&nbsp;&nbsp;<%=rvalue%>&nbsp;&nbsp;To&nbsp;&nbsp;<%=rvalue1%>&nbsp;&nbsp;<font color="blue"></font></td>	
		</tr>
		
<%
try
{   
     //String distcode =(String)session.getAttribute("dcode");
     //System.out.println("this is dcode..."+distcode);
     String h1values="",h2values="",h3values="",v1="",v2="",v3="",v4="",h2v1="",h2v2="",h2v3="",h2v4="",h2v5="",h2v6="",h2v7="",h3v1="",h3v2="",h3v3="",h3v4="";
     String ext_fac[],tras[],workdet[];
     float v1sum=0,v2sum=0,v3sum=0,v4sum=0;
	%>
		 <tr align="center" bgcolor="#ffffff">
			<td class=btext align="center" rowspan="2">S.No.</td>
			<td class=btext align="center" rowspan="2">Mandal Name</td>
			<td class=btext align="center" rowspan="2">Panchayat Name</td>
			<td class=btext align="center"  rowspan="2">Hab Name </td>
			<td class=btext align="center" rowspan="2">Hab Code</td>
           <td class=btext align="center" rowspan="2">Hab Status</td>
           <td class=btext align="center" colspan="4">On going Works</td>
           <td class=btext align="center" colspan="9">Asset Details</td>
			</tr>
			<tr>
			<td class=btext align="center">Name of<br> the Work</td>
			<td class=btext align="center">Est.Cost<br>(Rs.in Lakhs)</td>
			<td class=btext align="center">Grant</td>
			<td class=btext align="center">Probable date <br>of Completion</td>
			<td class=btext align="center">PWS</td>
			<td class=btext align="center">CPWS</td>
			<td class=btext align="center">MPWS</td>
			<td class=btext align="center">HP</td>
			<td class=btext align="center">DP</td>
			<td class=btext align="center">Sustainability</td>
			<td class=btext align="center">SHP</td>
			<td class=btext align="center">Ponds</td>
			<td class=btext align="center">Open Wells</td>
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
		</tr>
     
        <%
 //queries
           
          
          

	       Hashtable h3=(Hashtable)session.getAttribute("h3");
        Hashtable asset_hash=(Hashtable)session.getAttribute("asset_hash");
        Hashtable cs_hash=(Hashtable)session.getAttribute("cs_hash");
	       String qry1="select distinct mname,pname,PANCH_NAME,PANCH_CODE from RWS_DROUGHT_HAB_TR_PVT_SO_TBL  a,rws_mandal_tbl b ,rws_panchayat_tbl c ,rws_panchayat_raj_tbl d ,RWS_DROUGHT_HABITATION_TBL  e ,RWS_DROUGHT_SCAR_REASONS_TBL f , rws_habitation_directory_tbl g where  substr(habitation_code,1,2)='"+distcode+"' and substr(habitation_code,1,2)=b.dcode and substr(habitation_code,6,2)=b.mcode and substr(habitation_code,13,2)=c.pcode and substr(habitation_code,6,2)=c.mcode and substr(habitation_code,1,2)=c.dcode  and substr(habitation_code,13,2)=substr(d.hab_code,13,2) and substr(habitation_code,6,2)=substr(d.hab_code,6,2) and substr(habitation_code,1,2)=substr(d.hab_code,1,2) and e.habcode=d.panch_code and e.scarcity_code=f.scarcity_code and a.date_of_entry>=to_date('"+rvalue+"','dd-mm-yyyy') and a.date_of_entry<=to_date('"+rvalue1+"','dd-mm-yyyy') and a.habitation_code=g.hab_code order by pname";
	          System.out.println("my qry1 "+qry1);
	          pst1=conn.createStatement();
	          rs1=pst1.executeQuery(qry1);
	          //System.out.println("my qry1 "+qry1);
	            int totpwscnt=0,totcpwscnt=0,totmpwscnt=0,tothpcnt=0,totdpcnt=0,totshpcnt=0,totsuscnt=0,totpondscnt=0,totowcnt=0;
	          while(rs1.next())
	          {
	        	  String covstatus="";
	        	  if(cs_hash.get(rs1.getString(4))!=null){
	        		  covstatus=(String)cs_hash.get(rs1.getString(4));  
	        	  }
	        	  int pwscnt=0,cpwscnt=0,mpwscnt=0,hpcnt=0,dpcnt=0,shpcnt=0,suscnt=0,pondscnt=0,owcnt=0;
	            //System.out.println("111111111"+qry1);
	        	  if(asset_hash.get(rs1.getString(4)+"09")!=null){
	                  dpcnt=(Integer)asset_hash.get(rs1.getString(4)+"09");
	                  totdpcnt+=dpcnt;
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"10")!=null){
	                  	suscnt=(Integer)asset_hash.get(rs1.getString(4)+"10");	
	                  totsuscnt+=suscnt;    
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"05")!=null){
	                  	shpcnt=(Integer)asset_hash.get(rs1.getString(4)+"05");	
	                  totshpcnt+=shpcnt;   
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"06")!=null){
	                      owcnt=(Integer)asset_hash.get(rs1.getString(4)+"06");	
	                  totowcnt+=owcnt;    
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"07")!=null){
	                  	pondscnt=(Integer)asset_hash.get(rs1.getString(4)+"07");	
	                  totpondscnt+=pondscnt;    
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"01")!=null){
	                      pwscnt=(Integer)asset_hash.get(rs1.getString(4)+"01");	
	                  totpwscnt+=pwscnt;    
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"02")!=null){
	                      mpwscnt=(Integer)asset_hash.get(rs1.getString(4)+"02");	
	                  totmpwscnt+=mpwscnt;    
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"03")!=null){
	                      cpwscnt=(Integer)asset_hash.get(rs1.getString(4)+"03");	
	                      totcpwscnt+=cpwscnt;  
	                  }
	                  if(asset_hash.get(rs1.getString(4)+"04")!=null){
	                      hpcnt=(Integer)asset_hash.get(rs1.getString(4)+"04");	
	                      tothpcnt+=hpcnt;   
	                  }         
	           //work details hash values
	            h3values=(String)h3.get(rs1.getString(4));
	            if(h3values!=null)
	            {
	             workdet=h3values.split("#");
	             h3v1=workdet[0];
				 h3v2=workdet[1];
				 h3v3=workdet[2];
	             h3v4=workdet[3];
	             System.out.println("h3v2"+h3v2);
	             }
	           else
				{	
		         h3v1="-";
				 h3v2="0";
				 h3v3="-";
	             h3v4="-";                      
				}
	           
	            //end 
	      // 
	         %>
	      <tr align="center">
	           <td class=rptvalue align="left"><%=count++%></td>
	           <td class=rptvalue align="left"><%=rs1.getString(1)%></td>
	           <td class=rptvalue align="left"><%=rs1.getString(2)%></td>	
	            <td class=rptvalue align="left">&nbsp;<%=rs1.getString(3)%></td>	
				<td class=rptvalue align="left"><%=rs1.getString(4)%></td>	
				<td class=rptvalue align="left"><%=covstatus%></td>	
				 <td class=rptvalue align="center"><%=h3v1%></td>
				<td class=rptvalue align="right"><%=h3v2%></td>
	            <td class=rptvalue align="center"><%=h3v3%></td>
	            <td class=rptvalue align="center"><%=h3v4%></td>
	             <td class=rptvalue align="center"><%=pwscnt %></td>
	            <td class=rptvalue align="center"><%=cpwscnt %></td>
	            <td class=rptvalue align="center"><%=mpwscnt %></td>
	            <td class=rptvalue align="center"><%=hpcnt %></td>
	            <td class=rptvalue align="center"><%=dpcnt %></td>
	            <td class=rptvalue align="center"><%=suscnt %></td>
	            <td class=rptvalue align="center"><%=shpcnt %></td>
	            <td class=rptvalue align="center"><%=pondscnt %></td>
	            <td class=rptvalue align="center"><%=owcnt %></td>
	           </tr>

		<%
	   v1sum+=Float.parseFloat(h3v2);
	}
	    

	%>
	 <tr align="center" class=btext>
	           <td class=btext colspan=7>Totals</td>
	            <td class=btext align="right"><%=v1sum%></td>
				<td class=btext align="right">-</td>
	            <td class=btext align="right">-</td>
	             <td class=btext align="center"><%=totpwscnt %></td>
	            <td class=btext align="center"><%=totcpwscnt %></td>
	            <td class=btext align="center"><%=totmpwscnt %></td>
	            <td class=btext align="center"><%=tothpcnt %></td>
	            <td class=btext align="center"><%=totdpcnt %></td>
	            <td class=btext align="center"><%=totsuscnt %></td>
	            <td class=btext align="center"><%=totshpcnt %></td>
	            <td class=btext align="center"><%=totpondscnt %></td>
	            <td class=btext align="center"><%=totowcnt %></td>
	</tr> 
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
%>
</table>
<br>
<b><font color="red">&nbsp;Note&nbsp;:&nbsp; Amount Displayed in Laksh(s)</font></b>
</body>
</form>
</html>

<%@ include file = "footer.jsp" %>
