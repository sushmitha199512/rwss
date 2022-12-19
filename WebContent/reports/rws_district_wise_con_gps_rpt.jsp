<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

String dcode=request.getParameter("district1");
if(dcode!=null)
{
session.setAttribute("dcode",dcode);
}
String dname=request.getParameter("dname1");
if(dname!=null)
{
session.setAttribute("dname",dname);
}
String mcode=request.getParameter("mandal");
if(mcode!=null)
{
session.setAttribute("mandal",mcode);
}
String mname1=request.getParameter("mname");
if(mname1!=null)
{
session.setAttribute("mname1",mname1);
}

String qry="",qry2="",qry3="",qry4="",qry5="";
Statement stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs2=null,rs3=null,rs4=null,rs5=null;
String mname="",habstatus="",hcode="",cpwslist="",pwslist="",mpwslist="",dplist="",schemetype="",scheme="";
int covstatus=0;
%>
<script language="javascript">
function wopen(url, name, w, h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}



</script>
<form>
<center>
<table width="90%">



			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_district_wise_con_gps_xls.jsp" target="_new">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>




<tr><td align=right>
</tr>
</table>

<p align="center"><font face=verdana size=2><b>District Wise 100% GP's Consolidate Report</b></font><BR>
<font color="black" face=verdana size=2>Under</font>&nbsp;
<font color="blue" face=verdana size=2><b>District:</b></font><font color="black" face=verdana size=2><%=dname%>(Based on Existing Assets)</font>&nbsp; 
&nbsp; </p>
<table>
<tr><td width="5%" bgcolor="green" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Fully Covered - GP's are Fully Covered if all the habitations in the GP covered with any one of the schemes[CPWS/PWS/MPWS/DP]</td></tr>
<tr><td width="5%" bgcolor="orange" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Not Fully Covered- GP's are partially covered if any one habitation is not covered even with a single schemes </td></tr>
</table>

<p align="center">
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext width=20 rowspan="2"><b>S.No</b></td>
<td class=btext rowspan="2"><b>Mandal Name</b></td>
<td class=btext colspan="2"><b>NO.of GP's</b></td>
<td class=btext colspan="2"><b>Fully Covered GP's</b></td>
<td class=btext colspan="3"><b>Not Fully Covered GP's</b></td>
</tr>
<tr>
<td class=btext><b>GP's</b></td>
<td class=btext><b>Habs</b></td>
<td class=btext><b>GP's</b></td>
<td class=btext><b>Habs</b></td>
<td class=btext><b>GP's</b></td>
<td class=btext><b>Covered Habs</b></td>
<td class=btext><b>Not Covered Habs</b></td>

</tr>
<%
  int count=1;
  int pcount=0,habCount=0,fcount=0,nfcount=0,fullyHabCount=0,notfullyHabCount=0,notCovHabCount=0;
  
  int flag=1,flag2=1;
  int fcsum=0,nfcsum=0,psum=0,habSum=0,fullyHabSum=0,notfullyHabSum=0,notCovHabSum=0;
  int habcount=0,schemecount=0;
 try
{
   stmt=conn.createStatement();
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();
   stmt4=conn.createStatement();
   stmt5=conn.createStatement();
   boolean fg=true;
   boolean res=true;

   qry="select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
   rs=stmt.executeQuery(qry);
    while(rs.next())
	 {   nfcount=0;fcount=0;habCount=0;
	 fullyHabCount=0;notfullyHabCount=0;notCovHabCount=0;
		 
         qry2="select count(pcode) from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"' order by pcode";
		 rs2=stmt2.executeQuery(qry2);
	     while(rs2.next())
		 {
            pcount=rs2.getInt(1);
         }
         // System.out.println("panch count........."+qry2);
          psum+=pcount;
         //System.out.println("Mandal name"+rs.getString(2));

         qry5="select distinct pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+rs.getString(1)+"' order by pcode";      
         rs5=stmt5.executeQuery(qry5); 
         while(rs5.next())
          { int fhcount=0,nCovCount=0;
            //System.out.println("Panch name"+rs5.getString(2));
             qry3="select distinct c.hab_code from rws_panchayat_raj_tbl b,rws_habitation_directory_tbl c where c.coverage_status<>'UI' and c.coverage_status is not null and c.hab_code=b.panch_code and  substr(c.hab_code,1,2)='"+dcode+"' and substr(c.hab_code,6,2)='"+rs.getString(1)+"' and substr(c.hab_code,13,2)='"+rs5.getString(1)+"'";
		    rs3=stmt3.executeQuery(qry3);
		    while(rs3.next())
	        {   fhcount=fhcount+1;
		    	habCount=habCount+1;
               // System.out.println("111 hab loop");
                qry4="select distinct b.TYPE_OF_ASSET_NAME from rws_asset_mast_tbl A,RWS_ASSET_TYPE_TBL B,rws_habitation_directory_tbl c where b.type_of_asset_code in ('01','02','03','09') and substr(a.asset_code,7,2)=b.TYPE_OF_ASSET_CODE AND a.hab_code=c.hab_code and a.hab_code='"+rs3.getString(1)+"'";
		        rs4=stmt4.executeQuery(qry4);
                 res=rs4.next();
                 
				 if(!res){
				  nCovCount=nCovCount+1;
                  fg=false;
                  }
            }
				if(!fg)
				{
				nfcount++;
				notfullyHabCount+=fhcount-nCovCount;
				notCovHabCount+=nCovCount;
				}else{
				fcount++;
				fullyHabCount+=fhcount;
				}
				fg=true;
				
                       
      }//end of panchayat
           
           //System.out.println("not fully count...."+nfcount);  
          // System.out.println("fully count...."+(pcount-nfcount));   
   fcsum+=fcount;
   nfcsum+=nfcount;
   habSum+=habCount;
   fullyHabSum+=fullyHabCount;
   notfullyHabSum+=notfullyHabCount;
   notCovHabSum+=notCovHabCount;

%>
    <tr>
	   	<td class=rptvalue align="center"><%=count++ %></td>
        <td class=rptvalue nowrap align="left"><%=rs.getString(2)%></td>
      	<td class=rptvalue nowrap align="right"><%=pcount%></td>
      	<td class=rptvalue nowrap align="right"><%=habCount%></td>
		<td class=rptvalue nowrap align="right"><%=(pcount-nfcount)%></td>
		<td class=rptvalue nowrap align="right"><%=fullyHabCount%></td>
        <td class=rptvalue nowrap align="right"><%=nfcount%></td>
        <td class=rptvalue nowrap align="right"><%=notfullyHabCount %></td>
        <td class=rptvalue nowrap align="right"><%=notCovHabCount %></td>
    </tr>
       
<%
  
  }
%>
 		<tr><td class=btext colspan=2 align="right">Totals</td>
        <td class=btext align="right"><%=psum%></td>   
        <td class=btext align="right"><%=habSum%></td>     
		<td class=btext nowrap align="right"><a href="#" onClick="wopen('rws_fc_con_gps.jsp?dcode=<%=dcode%>','popup',700,300)"><%=fcsum %></a></td>
		<td class=btext align="right"><%=fullyHabSum%></td> 
		<td class=btext nowrap align="right"><a href="#" onClick="wopen('rws_notfc_con_gps.jsp?dcode=<%=dcode%>','popup',700,300)"><%=nfcsum %></a></td>
		<td class=btext align="right"><%=notfullyHabSum%></td> 
		<td class=btext align="right"><%=notCovHabSum%></td> 	
        </tr>  




<%
}

catch(SQLException e)
{
System.out.println(" RWS_HABITATION_directory_tBL  Exception: \n" + e);
}
finally
 {

   if(rs3 != null)
	{
		try
		{
		rs3.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt3 != null)
	{
		try
		{
		stmt3.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }



   if(rs5 != null)
	{
		try
		{
		rs5.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt5 != null)
	{
		try
		{
		stmt5.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }





   if(rs2 != null)
	{
		try
		{
		rs2.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt2 != null)
	{
		try
		{
		stmt2.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }
	if(rs != null)
	{
		try
		{
		rs.close();	
       	}
		catch(SQLException sqle)
	    { 
	    }
    }
    if(stmt != null)
	{
		try
		{
		stmt.close();	
        			
		}
		catch(SQLException sqle)
	    { 
	    }
    }
 }

%>
</center>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

