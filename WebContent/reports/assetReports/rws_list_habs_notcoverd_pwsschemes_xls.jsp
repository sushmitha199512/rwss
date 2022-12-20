<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp"%>
<form>
	<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_list_habs_notcoverd_schemes_xls.xls");
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String dcode=(String)session.getAttribute("district");
%>
	<table width="80%" border=1 style="border-collapse: collapse"
		ALIGN=CENTER>
		<tr align="center">
			<td align="center" class="gridhdbg" colspan="8">Habs Not Covered
				Schemes Report(CPWS,PWS & MPWS)</td>
		</tr>
		<tr align=center>
			<td class=gridhdbg>Sl.No</td>
			<td class=gridhdbg>District</td>
			<td class=gridhdbg>Mandal</td>
			<td class=gridhdbg>Panchayath</td>
			<td class=gridhdbg>Village</td>
			<td class=gridhdbg>Habcode</td>
			<td class=gridhdbg>HabName</td>
			<td class=gridhdbg>Population</td>
		</tr>
		<% 
try
{
    String query = "",style="";
int sno=1,styleCount=0;
  stmt1=conn.createStatement();
   query="";
   String qry1 = "select distinct ch.dname,ch.mname,ch.pname,ch.vname,ch.panch_code,ch.panch_name,ch.CENSUS_PLAIN_POPU,ch.CENSUS_SC_POPU,ch.CENSUS_ST_POPU,ch.CENSUS_MINORITY_POPU,ch.dcode,ch.mcode,ch.pcode,ch.vcode  from rws_complete_hab_view ch  where  panch_code not in (select b.hab_code from RWS_ASSET_MAST_TBL a,RWS_ASSET_HAB_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TYPE_OF_ASSET_CODE  in ('01','02','03') and a.ASSET_CODE=b.ASSET_CODE and b.HAB_CODE=c.PANCH_CODE and a.HAB_CODE in (select panch_code from rws_complete_hab_view)) ";
   if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
   {
    qry1+=" and  ch.dcode='"+dcode+"'  ";
     }
   qry1+="order by ch.dcode,ch.mcode,ch.pcode,ch.vcode";
//System.out.println("Query"+qry1);
  rs1=stmt1.executeQuery(qry1);
  long sc=0,plain=0,st=0,min=0,totpop=0,gtotpop=0;
  while (rs1.next())
	{
	  if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;			
		 if(rs1.getString(7)!=null){
             plain=Long.parseLong(rs1.getString(7));
				}
if(rs1.getString(8)!=null){
             sc=Long.parseLong(rs1.getString(8));
				}
if(rs1.getString(9)!=null){
             st=Long.parseLong(rs1.getString(9));
				}
if(rs1.getString(10)!=null){
             min=Long.parseLong(rs1.getString(10));
				}	
totpop=plain+sc+st+min;
gtotpop+=totpop;
	%>
		<tr>
			<td class="<%=style%>" style="text-align: left;"><%= sno++ %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(1) %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(2) %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(3) %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(4) %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(5) %></td>
			<td class="<%=style%>" style="text-align: left;"><%=rs1.getString(6) %></td>
			<td class="<%=style%>" style="text-align: right;"><%=totpop %></td>
		</tr>
		<%  
	}
 }
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	}
%>
	</table>
</form>
<%@ include file="/reports/connClose.jsp"%>
<%}finally{}%>
