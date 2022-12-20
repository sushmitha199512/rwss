<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<form name="f1">
<%
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null;

ResultSet rs6=null;
ResultSet rs3=null;

//String attend="";
StringBuffer attend=new StringBuffer();
attend.append("");

//String a="";
StringBuffer a=new StringBuffer();
a.append("");




int sno=1;
int gcount=0;
int gcomplaintcount=0;
int dcount=0;
int gncomplaintcount=0;
int f1,gf1=0;
int d1,gd1=0;

//String cDate=null;
StringBuffer cDate=new StringBuffer();
cDate.append("");

//String s;
StringBuffer s=new StringBuffer();
Format formatter;
java.util.Date date = new java.util.Date();
formatter = new SimpleDateFormat("dd/MM/yyyy");
s.append(formatter.format(date));

StringBuffer currentdate=new StringBuffer();
currentdate.append(s.toString().replace("/","-"));
//////////System.out.println("currentdate"+currentdate.toString());


//String rvalue=request.getParameter("mydate");
StringBuffer rvalue=new StringBuffer();
rvalue.append(request.getParameter("mydate"));
if(rvalue!=null){
	session.setAttribute("rvalue",rvalue.toString());
	}
	if(rvalue==null || rvalue.toString().equals("null")){
		rvalue.delete(0,rvalue.length());	
	rvalue.append(currentdate);
	}

boolean flag=false;

//String stankCode=null;
StringBuffer stankCode=new StringBuffer();
stankCode.append("");
%>

<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js">

//Date Time Picker script- by TengYong Ng of http://www.rainforestnet.com
//Script featured on JavaScript Kit (http://www.javascriptkit.com)
//For this script, visit http://www.javascriptkit.com 

</script>
<script type="text/javascript">
function fnSubmit()
{

  var d=document.getElementById('demo1').value;//date value
  document.f1.action="./rws_sstank_consolidated_rpt.jsp";
  document.f1.mydate.value=d; 
  document.f1.submit();

}
</script>

<table border = 1 cellspacing = 0 cellpadding = 0 height=2% width="30%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
    <caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					
					</td>
				</tr>
			</table>
		</caption>
   <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>DAILY SS TANK REPORT</td>	
	</tr>
    <tr><td class=rptLabel>Select Date&nbsp;<font color="red">*</font></td>
		<td class=btext><input id="demo1" type="text" size="25" value="<%=rvalue.toString()%>">
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

<table border = 1 cellspacing = 0 cellpadding = 0 width="90%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
	
				 <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a>
				<a href="./rws_drought_sstank_xls_rpt.jsp" target=_new>Excel</a></td>
			
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">ABSRACT - FILLING OF SS TANKS and DW Tanks</td>
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse"  ALIGN=CENTER ><tr align=center>

               <td class=btext rowspan=2>Sl.No</td>
               <td class=btext rowspan=2>District</td>
               <td class=btext colspan=2>SS TANKS</td> 
			   <td class=btext colspan=6>Status of Filling of S.S Tanks and DW Tanks</td>
			   </tr>
			   <tr>
			   <td class=btext>Type</td>
			   <td class=btext>No</td>
			   <td class=btext>>90%</td>
			   <td class=btext>>=75%(90% to 75%)</td>
			   <td class=btext>=50%(<75% to 50%)</td>
			   <td class=btext>=25%<50% to 25%)</td>
			   <td class=btext>Less than 25%</td>
			   <td class=btext>0%</td>
			   
			   
		   
			   </tr>
<%
StringBuffer query=new StringBuffer();

try
{
	int count=1;
	int total=0;
	int gtotal=0;
	int  gtg90=0,gtg25=0,gtg50=0,gtg75=0,gtl25=0,gtzero=0;
	int g90=0,g75=0,g50=0,g25=0,l25=0,zero=0;
	int tg90=0,tg75=0,tg50=0,tg25=0,tl25=0,tzero=0;
	int mpws=0,pws=0,cpws=0,others=0;
    
	  query.append("select  dcode,dname from rws_district_tbl" );
	
  ////////////System.out.println("query*********"+query);
   stmt1=conn.createStatement();
   stmt2=conn.createStatement();
   stmt3=conn.createStatement();

  rs1=stmt1.executeQuery(query.toString());
  int k=3;
  
  while (rs1.next())
	{
	flag=true;
	while(k!=0){
		query.delete(0,query.length());
 query.append("SELECT count(*),A.SSSC_CODE FROM RWS_AST_SS_SC_PARAM_TBL A, rws_asset_mast_tbl B WHERE A.ASSET_CODE=B.ASSET_CODE  AND SUBSTR(A.HAB_CODE,1,2)='"+rs1.getString(1)+"' AND TYPE_OF_ASSET_CODE='0"+k+"' GROUP BY (A.SSSC_CODE)");
   rs6=stmt2.executeQuery(query.toString());
   ////////////System.out.println("Q1"+q1);
   while (rs6.next())
	{
	
	
  	         if(k==3)
{
            cpws=cpws+rs6.getInt(1);
}else if(k==2)
{
 mpws=mpws+rs6.getInt(1);			 
	}
	else{
pws=pws+rs6.getInt(1);			 

	}
	
//stankCode=rs6.getString(2);
stankCode.delete(0,stankCode.length());
stankCode.append(rs6.getString(2));

query.delete(0,query.length());

	query.append("select * from rws_drought_sstank_tbl where SSSC_CODE='"+stankCode+"' and DROUGHT_DATE=to_date('"
					+ rvalue
					+ "','dd/mm/yyyy')");
  rs3=stmt3.executeQuery(query.toString());
  ////////////System.out.println("query4"+query4);
  boolean f=rs3.next();
 if(f){ 
 int val=Integer.parseInt(rs3.getString(10)); 
   //////////System.out.println("Value:"+ val);
  if(val > 90)
  { 
         g90+=1;  
  }else if(val < 90 && val >75)
{
          g75+=1;
}  
else if(val < 75 && val >50)
{
          g50+=1;
}  if(val < 50 && val > 25)
{
          g25+=1;
}
else if(val>0 && val<25)
{
 l25+=1;
} else if(val==0)
{
 zero+=1;
}


  }
   
}



	

 
	  if (flag) {%>
	
	<tr>
	<td rowspan=6><%= count++ %>
	<td rowspan=6 class=rptvalue><%=rs1.getString(2)%></td>
	</tr>
	
	<%  flag=false;} if(k==3) { %>
	
	
	<tr><td class=rptvalue>CPWS</td><td><%= cpws %></td><td ><%= g90 %></td><td ><%= g75 %></td><td><%= g50 %></td><td><%= g25 %></td><td><%= l25 %></td><td><%= zero %></td></tr>
	<%} else if(k==2) {%>
<tr><td class=rptvalue>MPWS</td><td><%= mpws %></td><td><%= g90 %></td><td><%= g75 %></td><td><%= g50 %></td><td><%= g25 %></td><td><%= l25 %></td><td><%= zero %></td></tr>
	</tr>
	<% } else if(k==1) { %>
	
	<tr><td class=rptvalue>PWS</td><td><%= pws %></td><td><%= g90 %></td><td><%= g75 %></td><td><%= g50 %></td><td><%= g25 %></td><td><%= l25 %></td><td><%= zero %></td></tr>
	
	<tr><td class=rptvalue>ORHERS </td><td><%= others %></td><td><%= g90 %></td><td><%= g75 %></td><td><%= g50 %></td><td><%= g25 %></td><td><%= l25 %></td><td><%= zero %></td></tr>
	
	<% } else { %>
	
	
	<%}
	 k--;
	 tg90+=g90;
	 tg25+=g25;
	 tg50+=g50;
	 tg75+=g75;
	 tl25+=l25;
	 tzero+=zero;
	 
	 g25=0;g50=0;g90=0;g75=0;l25=0;zero=0;
	}
k=3; 
total=cpws+mpws+pws+others;

%>
<tr><td class=rptvalue ><font color="GREEN"><B>Total:</B></font></td><td><font color="GREEN"><%= total%></font></td><td><font color="GREEN"><%= tg90 %></font></td><td><font color="GREEN"><%= tg75 %></font></td><td><font color="GREEN"><%= tg50 %></font></td><td><font color="GREEN"><%= tg25 %></font></td><td><font color="GREEN"><%= tl25 %></font></td><td><font color="GREEN"><%= tzero %></font></td></tr>
	<%


 gtotal+=total;
 gtg90+=tg90;
 gtg25+=tg25;
 gtg50+=tg50;
 gtg75+=tg75;
 gtl25+=tl25;
 gtzero+=tzero;
 
 total=0;
 tg90=0;
	 tg25=0;
	 tg50=0;
	 tg75=0;
	 tl25=0;
	 tzero=0;

cpws=0;
mpws=0;pws=0;



} // distrcit change

%>


<tr><td></td><td></td><td><font color="RED"><b>Grand Total:</b></font></td><td><font color="RED"><b><%= gtotal %></b></font></td><td><font color="RED"><b><%= gtg90 %></b></font></td><td><font color="RED"><b><%= gtg75 %></b></font></td><td><font color="RED"><b><%= gtg50 %></b></font></td><td><font color="RED"><b><%= gtg25 %></b></font></td><td><font color="RED"><b><%= gtl25 %></b></font></td><td><font color="RED"><b><%= gtzero %></b></font></td></tr>

<%

	}
catch(Exception e)
{
	
}
finally
{
	try
	{
		if(rs1 != null )
		{
			rs1.close();
		}
		if(stmt1 != null )
		{
			stmt1.close();
		}
		if(rs2 != null )
		{
			rs2.close();
		}
		if(stmt2 != null )
		{
			stmt2.close();
		}
		if( conn != null )
		{
			conn.close();
		}
	}
	catch(Exception r)
	{
		r.printStackTrace();
	}
}

%>
</table>
</form>

<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


