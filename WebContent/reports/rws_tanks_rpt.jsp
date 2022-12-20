<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
////System.out.println("dlfgdkljglkdjg");
String dcode=request.getParameter("district");
if(dcode!=null){
session.setAttribute("dcode",dcode);
}
String dname=request.getParameter("dname");
//System.out.println("dname"+dname);
if(dname!=null){
session.setAttribute("dname",dname);
}

String mcode=request.getParameter("mandal");
//System.out.println("mcode"+mcode);
if(mcode!=null){
session.setAttribute("mcode",mcode);
}

String mname=request.getParameter("mname");
//System.out.println("mname"+mname);
if(mname!=null){
session.setAttribute("mname",mname);
}

Statement stmt2=null,stmt1=null,stmt3=null,stmt4=null;

ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
String qry=null;

//qry for OHSR

/*stmt2=conn.createStatement();


String ohsr_qry="select distinct substr(a.ohsr_code,1,2),substr(a.ohsr_code,1,16),nvl(OHSR_LOC,'-'),nvl(OHSR_CAP_LTS,0)  from RWS_AST_OHSR_SC_PARAM_TBL a,RWS_ASSET_MAST_TBL  b,rws_complete_hab_view c where substr(a.ohsr_code,1,2)="+dcode+" and substr(a.ohsr_code,6,2)="+mcode+" and a.asset_code=b.asset_code  and a.hab_code=c.panch_code order by substr(a.ohsr_code,1,2)";


rs2=stmt2.executeQuery(ohsr_qry);
System.out.println("ohsrqry"+ohsr_qry);
Hashtable ohsr_hash=new Hashtable();
while(rs2.next())
{
	ohsr_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
	
}

if(rs2!=null){
	rs2.close();
}if(stmt2!=null){
	stmt2.close();
}
//qry for GLSR

//System.out.println("glsr_qry");
stmt2=conn.createStatement();
String glsr_qry="select distinct substr(a.glsr_code,1,2),substr(a.glsr_code,1,16),nvl(GLSR_LOC,'-'),nvl(GLSR_CAP_LTS,0) from RWS_AST_GLSR_SC_PARAM_TBL a,RWS_ASSET_MAST_TBL  b,rws_complete_hab_view c where substr(a.glsr_code,1,2)="+dcode+" and substr(a.glsr_code,6,2)="+mcode+" and a.asset_code=b.asset_code  and a.hab_code=c.panch_code order by substr(a.glsr_code,1,2)";

//System.out.println("glsr_qry"+glsr_qry);
rs2=stmt2.executeQuery(glsr_qry);
System.out.println("glsr_qry"+glsr_qry);
Hashtable glsr_hash=new Hashtable();
while(rs2.next())
{
	glsr_hash.put(rs2.getString(1)+rs2.getString(2),rs2.getString(3)+"@"+rs2.getString(4));
}

if(rs2!=null){
	rs2.close();
}
if(stmt2!=null){
	stmt2.close();
}*/
%>
<table>
<tr><td class=btext>Drinking Water Facilities available through Schemes</td></tr></table>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a href="/pred/home.jsp?loginMode=watersoft">Home</a>|<a href="./rws_tanks_rpt_excel.jsp" target="_new">Excel</a>
			</td>
		</tr>
</table>
</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr >
   <td class=gridhdbg colspan=13 align="center"><b>District :<%=dname%></b> &nbsp;&nbsp;&nbsp; <b>Mandal:<%=mname%></b></td>
</tr>
<tr align=center>
<td class=gridhdbg rowspan="2" ><b>Sl.No</b></td>
<td class=gridhdbg rowspan="2"><b>Panchayat</b></td>
<td class=gridhdbg rowspan="2"><b>Habitation</b></td>
<td class=gridhdbg rowspan="2" ><b>Total Population</b></td>
<td class=gridhdbg colspan="2"><b>OHSR</b></td>
<td class=gridhdbg colspan="2"><b>GLSR</b></td>
<!-- 
<td class=gridhdbg rowspan="2"><b>Total Capacity(in Ltrs.)</b></td>   
<td class=gridhdbg rowspan="2"><b>LPCD (Total Capacity/Population)</b></td> -->
</tr>
<tr>
<td class=gridhdbg ><b>Location</b></td>
<td class=gridhdbg ><b>Tank Capacity(in Ltrs)</b></td>
<td class=gridhdbg ><b>Location</b></td>
<td class=gridhdbg ><b>Tank Capacity(in Ltrs)</b></td>
</tr>

 <tr>
  <%
  try{
	  ////System.out.println("fjslSSSS");
	  int count=1;
	  String q1="",qry1="";
	  int styleCount=0,ohsr_capacity=0,glsr_capacity=0;
	  String ohsr_loc="",glsr_loc="";
	  int flag=1,flag2=1,ohsr_tot=0,glsr_tot=0,tot_capacity=0;
	  String pcode="",pname="",prevpname="";
	  double poptot=0.0,lpcd=0.0;
	  String style="",ohsrloc="",glsrloc="";
	  int ohsrcapacity=0,glsrcapacity=0,ocnt=0;
	  
	  stmt1=conn.createStatement();
	  stmt2=conn.createStatement();
	  stmt3=conn.createStatement();
	  stmt4=conn.createStatement();
		 
	  qry="select distinct dcode,mname,pcode,pname from rws_complete_hab_view where dcode="+dcode+" and mcode="+mcode+" order by mname,pname";
      rs1=stmt1.executeQuery(qry);
	 // System.out.println("queryyy1"+qry);
	  
	  while(rs1.next())
	  {
		  if(styleCount%2==0){
				 style="gridbg1";
			}else{
				 style="gridbg2";
			}
			styleCount++;

		  flag2=1;
		  
		  qry1="select distinct PANCH_CODE,PANCH_NAME,(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU) as popu from rws_complete_hab_view where dcode="+dcode+" and mcode="+mcode+" and pcode='"+rs1.getString(3)+"' and  PANCH_CODE is not null order by 1";
	      rs3=stmt3.executeQuery(qry1);
		//  System.out.println("queryyy2"+qry1);
		  while(rs3.next())
		  {
			 	ocnt++;
		    	//System.out.println("ocnt"+ocnt);
			  if(styleCount%2==0){
					 style="gridbg1";
				}else{
					 style="gridbg2";
				}
				styleCount++;
  
		  //pname=rs1.getString(5);
		    flag=1;
%>		  
<tr>

<%   if(flag2==1) 
      {     
	          flag2=0;  %>
	          
	          <td  class="<%=style %>" style="text-align: left;"><%=count++%> </td>
              <td  class="<%=style %>" style="text-align: left;"><%=rs1.getString(4)%> </td>
      
 <%  } else {   %>
             <td  class="<%=style %>" style="text-align: left;"></td>
            <td  class="<%=style %>" style="text-align: left;"></td>
         
 <% }%>
 
     <td  class="<%=style %>" style="text-align: left;"><%=rs3.getString(2)%> </td>
     <td  class="<%=style %>" style="text-align: center;"><%=rs3.getString(3)%> </td>
<%   
		     String ohsr_qry="select distinct a.ohsr_code,nvl(OHSR_LOC,'-'),nvl(OHSR_CAP_LTS,0) from RWS_AST_OHSR_SC_PARAM_TBL a,RWS_ASSET_MAST_TBL  b,rws_complete_hab_view c where substr(a.ohsr_code,1,2)="+dcode+" and substr(a.ohsr_code,6,2)="+mcode+" and a.asset_code=b.asset_code  and a.hab_code=c.panch_code and c.panch_code='"+rs3.getString(1)+"' and c.pcode='"+rs1.getString(3)+"'order by a.ohsr_code";
		    rs2=stmt2.executeQuery(ohsr_qry);
		   //System.out.println("ohsr_qry"+ohsr_qry);
		   boolean f=false;
		   int lcnt=0;
		    while(rs2.next())
			  {
		    	f=true;
		    	if(styleCount%2==0){
					 style="gridbg1";
				}else{
					 style="gridbg2";
				}
				styleCount++;
		      
				  //System.out.println("string2"+rs2.getString(2));
				   ohsrloc=rs2.getString(2);
				   ohsrcapacity=Integer.parseInt(rs2.getString(3));
	
					if(flag==0)
					{  %>
					
					<tr>
					<td  class="<%=style %>" style="text-align: left;"></td>
					<td  class="<%=style %>" style="text-align: left;"></td>
					<td  class="<%=style %>" style="text-align: left;">''</td>
					<td  class="<%=style %>" style="text-align: center;">''</td>
		    
			      <%  } %>
			                                                               
	           <td  class="<%=style %>" style="text-align: center;"><%=ohsrloc%></td>
			   <td  class="<%=style %>" style="text-align: right;"><%=ohsrcapacity%> </td>
	<%   
	          flag=0;
	         ohsr_tot+=ohsrcapacity;
	         //System.out.println("ohsr_tot"+ohsr_tot);
			}
		   
		    if(!f)
		    {  
		    	ohsrloc="-";
		    	ohsrcapacity=0;
		    %>
		    <td  class="<%=style %>" style="text-align: center;"><%=ohsrloc%></td>
			<td  class="<%=style %>" style="text-align: right;"><%=ohsrcapacity%> </td>
		       
<% }	//qry for glsr tank
	
	
	  String glsr_qry="select distinct a.glsr_code,nvl(GLSR_LOC,'-'),nvl(GLSR_CAP_LTS,0)  from RWS_AST_GLSR_SC_PARAM_TBL a,RWS_ASSET_MAST_TBL  b,rws_complete_hab_view c where substr(a.glsr_code,1,2)="+dcode+" and substr(a.glsr_code,6,2)="+mcode+" and a.asset_code=b.asset_code  and a.hab_code=c.panch_code and c.panch_code='"+rs3.getString(1)+"' and c.pcode='"+rs1.getString(3)+"'order by a.glsr_code";
		    rs4=stmt4.executeQuery(glsr_qry);
		  //System.out.println("glsr_qry"+glsr_qry);
		    boolean f1=false;
		   
		    while(rs4.next())
			  {
		    	f1=true;
		    	lcnt++;
		    	if(styleCount%2==0){
					 style="gridbg1";
				}else{
					 style="gridbg2";
				}
				styleCount++;
		      
				   //System.out.println("lcnt:::::::::::::::"+lcnt);
				   glsrloc=rs4.getString(2);
				   glsrcapacity=Integer.parseInt(rs4.getString(3));
				 
				   if(lcnt>1 && flag==0)
					   
					   {  %>
			           <td  class="<%=style %>" style="text-align: center;"></td>
			            <td  class="<%=style %>" style="text-align: center;"></td>
			             <td  class="<%=style %>" style="text-align: center;"></td>
			              <td  class="<%=style %>" style="text-align: center;"></td>
			               <td  class="<%=style %>" style="text-align: center;"></td>
			                <td  class="<%=style %>" style="text-align: center;"></td>
			    
			     <%}
					     %>
			    
			   <td  class="<%=style %>" style="text-align: center;"><%=glsrloc%></td>
			   <td  class="<%=style %>" style="text-align: right;"><%=glsrcapacity%></td></tr>
			
	<%   
	           flag=0;
	           glsr_tot+=glsrcapacity;
			  }
		    if(!f1)
		    {  
		    	glsrloc="-";
		    	glsrcapacity=0;
		  
		   %> 
		   
		   <td  class="<%=style %>" style="text-align: center;"><%=glsrloc%></td>
		  <td  class="<%=style %>" style="text-align: right;"><%=glsrcapacity%> </td>
		   
		 <% }
		    
		   
		 /*String ohsr_key=(String)ohsr_hash.get(rs1.getString(1)+rs3.getString(1));
		 System.out.println("ohsr_key****"+ohsr_key);
		  if(ohsr_key!=null && !ohsr_key.equals("null")&& !ohsr_key.equals("")){
			  String ohsrvalues[]=ohsr_key.split("@");
			  ohsr_loc=ohsrvalues[0];
			  ohsr_capacity=Integer.parseInt(ohsrvalues[1]);
		  }
		  
		  else{
			  ohsr_loc="-";
			  ohsr_capacity=0;
		  }
		  String glsr_key=(String)glsr_hash.get(rs1.getString(1)+rs3.getString(1));
		  
		  if(glsr_key!=null&&!glsr_key.equals("null") && !glsr_key.equals("") )
		  {
			  ////System.out.println("hi");
			  String glsrvalues[]=glsr_key.split("@");
			  glsr_loc=glsrvalues[0];
			  glsr_capacity=Integer.parseInt(glsrvalues[1]);
		  }
		  else{
			  glsr_loc="-";
			  glsr_capacity=0;
		  }
	  
	 */
	 
	  ////System.out.println("pcode"+pcode);
	  ////System.out.println("query2"+s1);
	  


 //amt+=rs1.getInt(12);
%> 
 
<%
			  
   flag=0;



  poptot+=Double.parseDouble(rs3.getString(3));

 
}		 
		  tot_capacity=ohsr_tot+glsr_tot;	
		  lpcd=tot_capacity/poptot;
		 
%>
<tr>
<td  class=gridhdbg colspan=8 align="center" >Total Capacity(in Ltrs.): <%=tot_capacity%>&nbsp;&nbsp;&nbsp;&nbsp;LPCD(Total Capacity/Population): <%=ndf.format(lpcd) %> </td></td>
</tr>
<%
	  if(count==0)
	  {%>
	  <tr align=center>
	  <td colspan='9'>No Records</td>
	  </tr>
	  <%}
ohsr_tot=0;
glsr_tot=0;
poptot=0;
	  }
	  
  }
catch(Exception e)
     {
     e.printStackTrace();
     } 
finally{
	rs1.close();			
	stmt1.close();
	rs3.close();			
	stmt3.close();
	rs2.close();			
	stmt2.close();
	rs4.close();			
	stmt4.close();
}
	%>
  





</table>
</body>
</html>
  
  </table>
 