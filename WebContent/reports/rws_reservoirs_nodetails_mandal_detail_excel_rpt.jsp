<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>
<form>

<%
String adCode=String.valueOf(session.getAttribute("dCode"));
//System.out.println("adCode*****"+adCode);


String district = (String)session.getAttribute("district");
//System.out.println("district*****"+district);


String assettype=(String)session.getAttribute("assettype");
//System.out.println("assettype*****"+assettype);

String assetName = "";
String mandal=(String)session.getAttribute("mandal");
//System.out.println("mandal*****"+mandal);

String mandalname=(String)session.getAttribute("mandalname");
//System.out.println("mandalname*****"+mandalname);
assetName=(String)session.getAttribute("assetName");






int tot=0;
int total=0;
Statement stmt1=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt12=null;
ResultSet rs1=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs12=null;

String pname="";
String vname="";
int ftk=0;
int gtot=0;

String cir="";
int pwscount=0;
int cpwscount=0;
int gpwscount=0;
int gcpwscount=0;
int mpwscount=0;
int gmpwscount=0;
int directcount=0;
int gdirectcount=0;


String dname="";


int sourcecount=0;
int gsourcecount=0;
int reservoircount=0;
int greservoircount=0;
int pwsreservoirs=0;
int gpwsreservoirs=0;
int mpwsreservoirs=0;
int gmpwsreservoirs=0;
int pwssource=0;
int gpwssource=0;
int pcount=0;
int gpcount=0;
int directsource=0;
int mpwssource=0;
int gdirectsource=0;
int gmpwssource=0;

int cpwssource=0;
int gcpwssource=0;
int cpwsreservoirs=0;
int gcpwsreservoirs=0;
int countsource=0;
String assettype2="";
String assetcode="";
int hpcount=0;
int hpcount1=0;
String assethptype="";

//mandalname=request.getParameter("mandalname");










int sno=1;
try
{
      	String query6="select dname from rws_district_tbl where dcode='"+district+"'";
        stmt6=conn.createStatement();
		rs6=stmt6.executeQuery(query6);
		while(rs6.next())
	 		{
				dname=rs6.getString(1);
			}
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	try
	{
		if(rs6!=null)
		{
			rs6.close();
		}
		if(stmt6!=null)
		{
			stmt6.close();
		}
	}
	catch(Exception o)
	{
		o.printStackTrace();
	}
}


%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="#edf2f8" align="center">
			<td class=rptValue colspan=14><font color="navy">District:<%=dname%> &nbsp;&nbsp;&nbsp;Mandal:<%=mandalname%> </td>
		


	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Assets  <%=assetName%> - With out Reservoirs  Report</td>


</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center"><tr align=center>

	
                <td class=btext>Sl.No</td>
			   
               <td class=btext>Asset Name</td>
               <td class=btext>Location</td>
			   <td class=btext>Date Of Creation</td>
               <td class=btext>Asset Status</td>
               <td class=btext>Asset Cost (Rs. In Lakhs)</td>   
               <td class=btext>Habitation Code</td>  
			   <td class=btext>Habitation Name</td>  
			   <td class=btext>Asset Code</td>     
			   
			   
			    
                
			  
               
   			   
			   </tr>



	
              			<%
			





try
{
	
	
	 
	 
	 

	  
	
					

		
	
		
	

		
		
		
    		
			
			
			
		       String query12="select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' MINUS (select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_OHSR_SC_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and  a.asset_code=d.asset_code union select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_OHBR_SC_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and a.asset_code=d.asset_code union select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_GLSR_SC_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and a.asset_code=d.asset_code union select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_GLBR_SC_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and a.asset_code=d.asset_code union select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_BPT_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and a.asset_code=d.asset_code union select A.ASSET_CODE from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view c,RWS_AST_CIS_SC_PARAM_TBL d where a.asset_code=b.asset_code and a.hab_code=c.panch_code and type_of_asset_code='"+assettype+"' and c.dcode='"+district+"' and c.mcode='"+mandal+"' and a.asset_code=d.asset_code)";
				
		       
		       
		       
		       
		       
		       
		       
		     

			 stmt4=conn.createStatement();
			 
             stmt3=conn.createStatement();
             
            // System.out.println("query12*****"+query12);
		 	 rs3=stmt3.executeQuery(query12);
			 while(rs3.next())
				 {
			       assetcode=rs3.getString(1);
               //  System.out.println("assetcode*****"+assetcode);
			      
			       
				   String query44="select  a.asset_name,a.location,to_char(date_creation,'dd/mm/yyyy'),decode(a.asset_status,'1','Working','2','Defunct')result,a.asset_cost,a.hab_code,s.panch_name,a.asset_code from rws_asset_mast_tbl a,rws_asset_scheme_tbl b,rws_complete_hab_view s where s.panch_code=a.hab_code and  s.dcode='"+district+"' and type_of_asset_code='"+assettype+"' and a.asset_code=b.asset_code and s.mcode='"+mandal+"' and a.asset_code='"+assetcode+"' ";
				   // System.out.println("query44*****"+query44);
				   rs4=stmt4.executeQuery(query44);
				   while(rs4.next())
					 {

				
				   
			
			%>
			<tr bgcolor="#ffffff">
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue><%=isNull(rs4.getString(1))%></td>
			<td class=rptValue><%=isNull(rs4.getString(2))%></td>
			<td class=rptValue><%=isNull(rs4.getString(3))%></td>
			<td class=rptValue><%=isNull(rs4.getString(4))%></td>
			<td class=rptValue><%=isNull(rs4.getString(5))%></td>
			<td class=rptValue>&nbsp;<%=isNull(rs4.getString(6))%></td>
			<td class=rptValue>&nbsp;<%=isNull(rs4.getString(7))%></td>
			<td class=rptValue>&nbsp;<%=isNull(rs4.getString(8))%></td>
			</tr>
						
		<%	 
		 }
        }
	
	

	
	


}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
try
{
	if(rs4!=null)
	{
		rs4.close();
	}
	if(stmt4!=null)
	{
		stmt4.close();
	}
	
	
	if(rs3!=null)
	{
	rs3.close();
	}
	if(stmt3 != null )
	{
	stmt3.close();
	}
    if(conn!=null)
	{
	conn.close();
	}
	
	

}
catch(Exception o)
{
o.printStackTrace();
}
}





%>
</table>
</form>




<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


</p>
</html>

           
		 	
		 	
			