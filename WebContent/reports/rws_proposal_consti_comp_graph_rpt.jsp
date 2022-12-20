<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>

<%@ include file = "header_rpt.jsp" %>
<%	
	try {	
	int repcode=0,totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null;
 // String names1[] = null;
 String district = request.getParameter("district");
 String mandal = request.getParameter("mandal");
 String panchayat = request.getParameter("panchayat");
 String fYear = request.getParameter("finyear");
 //System.out.println("fin**************************** "  +fYear);
 String aType =  request.getParameter("assetType");

 String assetType=request.getParameter("assetType");

String ATName=null;
if(assetType!=null)
{
if(assetType.equals("01")){ATName="PWS";}
else if(assetType.equals("02")){ATName="MPWS";} 
else if(assetType.equals("03")){ATName="CPWS";}
else if(assetType.equals("04")){ATName="HANDPUMPS";}
session.setAttribute("atname",ATName);
}
else
session.setAttribute("atname",null);
// //System.out.println("assetType="+assetType);
 
 // //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

 // //System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
 // //System.out.println("mMMMMMMMMMcode  ="+mCode);
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pCode"));

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	
	 String names1[] =  request.getParameterValues("consq");
	 String sr1[]= new String[names1.length];
	 String sr21[]= new String[names1.length];
		
	 String FYEAR[] =  request.getParameterValues("finyear");
	 String fy1[]= new String[FYEAR.length];
	 //System.out.println("*****************************************************    "+ FYEAR[0]);
	 
	

%>

<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>
</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_proposal_consti_comp_graph_form.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a>
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Contituency Wise Estimate Cost Report </font></td>
	</tr>
<tr><td valign=top align=center>

	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	
	
<tr> 
<%if(names1 != null)
		{%>
		<td align="center" class="mystyle1"><font color="navy">Constituency:
		<%
			for (int M=0; M < names1.length; M++)
			{
			 sr1[M] = names1[M].substring(0,names1[M].lastIndexOf("-"));
			    //System.out.println("YYYYYYYY dddddddddd  "+sr1[M]);
			sr21[M] = names1[M].substring(names1[M].lastIndexOf("-")+1, names1[M].length());
			%>
			 <%=sr21[M] %>&nbsp;&nbsp;&nbsp;
			<%					
			}
		}%>
</font>
<%if(FYEAR != null)
		{%>
		<td align="center" class="mystyle1"><font color="navy">Financial Year:
		<%
			for (int M=0; M < FYEAR.length; M++)
			{
			String  fnyr=FYEAR[M].substring(2,4);
			int fiyr =Integer.parseInt(fnyr);
			fiyr = fiyr + 1;
			if(fiyr>=10)
			{
				fnyr =FYEAR[M] + "-" + fiyr ;
			}
			else 
			fnyr = FYEAR[M] + "-0" + fiyr ;
			%>
			 <%=fnyr %>&nbsp;&nbsp;&nbsp;
			<%					
		}  }%>
<%if(session.getAttribute("atname")!=null){%>
<td align=center colspan=12 class="mystyle1"><font color=navy>Asset Type:&nbsp;&nbsp; <%=session.getAttribute("atname") %> </font></td><%}%>
</table>
	<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>

	
<%
int Count=0,i=0;
// //System.out.println("coount of rows is    ");
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
try	{
String qu1="";
	
			 qu1 = "SELECT rp.constituency_code,sum(estimate_cost) from rws_rep_proposal_tbl rp where (rp.constituency_code is not null ";
			 String a1= "  group by rp.constituency_code ";
			 if(sr1.length<=1)
			{
				  qu1 = qu1 + "   and rp.constituency_code ='" + sr1[0] + "'";
			}
			else
			{
			 for(int l=0;l<sr1.length;l++)
			{
				 qu1 = qu1 + "   or rp.constituency_code ='" + sr1[l] + "'";
			}
			}
			qu1 = qu1 + ")";
			if(aType!=null)
			{
				qu1 = qu1 + "  and rp.TYPE_OF_ASSET  ='" + aType + "'";
			}
			
			 if(FYEAR.length<=1)
			{
				  qu1 = qu1 + "   and SUBSTR(TO_CHAR(rp.REP_DATE, 'dd/MM/yyyy'),7,4) ='" + FYEAR[0] + "'";
			}
			else
			{
				int k;
			 for(k=0;k<FYEAR.length;k++)
			{
			//System.out.println("value of k  is  "+k);	 
			}
			qu1 = qu1 + "   AND SUBSTR(TO_CHAR(rp.REP_DATE, 'dd/MM/yyyy'),7,4) >='" + FYEAR[0]  +"' and   SUBSTR(TO_CHAR(rp.REP_DATE, 'dd/MM/yyyy'),7,4)<='" + FYEAR[k-1]  + "' ";
			
			}

		/*	if(fYear != null && !fYear.equals("0"))
			{
			int yr = Integer.parseInt(fYear);
			yr = yr - 2;
			String finyr = String.valueOf(yr);
			//System.out.println("year is  "+yr);
			query= query + "   AND SUBSTR(TO_CHAR(a.REP_DATE, 'dd/MM/yyyy'),7,4) >='" + finyr +"' and   SUBSTR(TO_CHAR(a.REP_DATE, 'dd/MM/yyyy'),7,4)<='" + fYear + "' ";
			}*/


			/*if(fYear!=null && !fYear.equals("0"))
			{
				qu1 = qu1 + "  and  substr(rp.proposal_id,3,4) ='" + fYear + "'";
			}*/

			 qu1 = qu1 + a1;
			 //System.out.println("query  is    "+qu1);	
			
				r6=st6.executeQuery(qu1);	
		r6.last();
		Count = r6.getRow();
		// //System.out.println("coount of rows is    "+Count);	
		r6.beforeFirst();	
		}
	catch(Exception ee)
	{
	//System.out.println("The error is="+ee);
	}
	if(Count>0)
	{
	%>
	
		<%@ include file = "rws_proposal_consti_comp_graph.jsp" %>	
	<% }
		else
		{%>
			<table border=0 align=center height="70%" width="100%">
				<tr>
					<td align="center" class="btext">
						<font color="navy">
							There are No Records 
						</font>
					</td>
				</tr>
			</table>
<%		}
			%>
</TD></TR>
</TABLE>

</body>
</html>
<%@ include file = "footer.jsp" %>
<% }
catch (Exception e)
{
}
finally
{
	conn.close();
}
%>