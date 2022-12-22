<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
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
 String OffType = request.getParameter("offType");
 String Circle = request.getParameter("Cir");
 String district = request.getParameter("district");
 String mandal = request.getParameter("mandal");
 String panchayat = request.getParameter("panchayat");
 String fYear = request.getParameter("finyear");
 //System.out.println("fin**************************** "  +fYear);
 String aType =  request.getParameter("assetType");
 String assetType=request.getParameter("assetType");

 //System.out.println(" OFFICE TYPE   "+	OffType);
 //System.out.println(" Circle TYPE   "+	Circle);
 //System.out.println(" district TYPE   "+	district);
 //System.out.println(" mandal TYPE   "+	mandal);
 //System.out.println(" panchayat TYPE   "+	panchayat);
 //System.out.println(" fYear TYPE   "+	fYear);
 //System.out.println(" assetType TYPE   "+	assetType);
//System.out.println("mandal name is    "+String.valueOf(session.getAttribute("mName")));



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
 /*
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); */

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	String FYEAR[] =  request.getParameterValues("finyear");
	 String fy1[]= new String[FYEAR.length];
	 String qu1="";
	  String a1= "";
	

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
			 
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_proposal_offices_comp_graph_form.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a>
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Office Wise Cost Details</font></td>
	</tr>
<tr><td valign=top align=center>

	<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	
	
<tr> 
	
<%
	if(request.getParameter("district") == null && request.getParameterValues("consq")!=null)
	{
	 String names1[] =  request.getParameterValues("consq");
	 String sr1[]= new String[names1.length];
	 sr1[0] = names1[0].substring(0,names1[0].lastIndexOf("-"));
	 String sr21[]= new String[names1.length];
	if(names1 != null)
		{
		
		 qu1 = "SELECT c.circle_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, RWS_CIRCLE_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code and  substr(rp.office_code,2,2) in ( "+sr1[0];
		%>
		<td align="center" class="mystyle1"><font color="navy">Circle:
		<%
			for (int M=0; M < names1.length; M++)
			{
				sr1[M] = names1[M].substring(0,names1[M].lastIndexOf("-"));
			    //System.out.println("YYYYYYYY dddddddddd  "+sr1[M]);
				sr21[M] = names1[M].substring(names1[M].lastIndexOf("-")+1, names1[M].length());
				qu1 = qu1 + ","  + sr1[M] ;
				//System.out.println(" QUW IS   "+qu1);
			%>
			 <%=sr21[M] %>&nbsp;&nbsp;&nbsp;
			<%					
			}
			qu1 = qu1 + ")";
		//System.out.println(" QUW IS   "+qu1);
		}
		
		 a1 = "  group by c.circle_office_name";
	}
		else
	{	%>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	<%
		//	qu1 = "SELECT c.circle_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, 	RWS_CIRCLE_OFFICE_TBL c where substr(rp.office_code,2,2)=c.circle_office_code  and substr(rp.office_code,2,2)='"+ request.getParameter("district") +"' ";
		//	a1 = "  group by c.circle_office_name";
			}		
		%>
</font>
<%	if( request.getParameterValues("consq")==null  && request.getParameterValues("divi")!=null)
	{
	 String division[] =  request.getParameterValues("divi");
	 String rDivi[]= new String[division.length];
	 String rDivi1[]= new String[division.length];
	 
	 //System.out.println(" DIVSION VALUE IS   "+division[0]);
	 if(division != null)
		{
			rDivi[0] = division[0].substring(0,division[0].lastIndexOf("-"));
		 qu1 ="SELECT c.division_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, RWS_division_OFFICE_TBL c where substr(rp.office_code,4,1)=c.division_office_code  and substr(rp.office_code,2,2)=c.circle_office_code  and substr(rp.office_code,2,2)='"+  request.getParameter("district")+"' and substr(rp.office_code,4,1) in ("+rDivi[0] ;
		 %>
		<td align="center" class="mystyle1"><font color="navy">Division:
		<%
		 for (int M=0; M < division.length; M++)
			{
			 rDivi[M] = division[M].substring(0,division[M].lastIndexOf("-"));
			 //System.out.println("YYYYYYYY dddddddddd  "+rDivi[M]);
			rDivi1[M] = division[M].substring(division[M].lastIndexOf("-")+1, division[M].length());

				qu1 = qu1 + ","  + rDivi[M] ;
		 %>
			 
			  <%= rDivi1[M] %>&nbsp;&nbsp;&nbsp;
			<%					
			}
			qu1 = qu1 + ")";
		}
		
		a1 = "  group by c.division_office_name";

	}

	else if(session.getAttribute("mName")!=null)
		{%>
		<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	<% 
		//qu1 ="SELECT c.division_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, RWS_division_OFFICE_TBL c where substr(rp.office_code,4,1)=c.division_office_code  and substr(rp.office_code,2,2)=c.circle_office_code  and substr(rp.office_code,2,2)='"+  request.getParameter("district")+"' and substr(rp.office_code,4,1)="+ request.getParameter("mandal")  ;
		//a1 = "  group by c.division_office_name";


		}

	if(request.getParameterValues("subdivi")!=null)
	{
	 String subdivision[] =  request.getParameterValues("subdivi");
	 String rSubdivi[]= new String[subdivision.length];
	 String rSubdivi1[]= new String[subdivision.length];

	 if(subdivision != null)
		{
		 rSubdivi[0] = subdivision[0].substring(0,subdivision[0].lastIndexOf("-"));
		 qu1 = "SELECT c.subdivision_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, RWS_subdivision_OFFICE_TBL c where  substr(rp.office_code,2,2)=c.circle_office_code  and substr(rp.office_code,4,1)=c.division_office_code  and substr(rp.office_code,5,2)=c.subdivision_office_code  and substr(rp.office_code,2,2)='"+  request.getParameter("district")+"' and substr(rp.office_code,4,1)="+ request.getParameter("mandal") +"  and substr(rp.office_code,5,2) in ( "+rSubdivi[0];
		
		 %>
		<td align="center" class="mystyle1"><font color="navy"> Sub Division:
		<%
		 for (int M=0; M < subdivision.length; M++)
			{
			  rSubdivi[M] = subdivision[M].substring(0,subdivision[M].lastIndexOf("-"));
			 //System.out.println("YYYYYYYY dddddddddd  "+rSubdivi[M]);
			rSubdivi1[M] = subdivision[M].substring(subdivision[M].lastIndexOf("-")+1, subdivision[M].length());

			 qu1 = qu1 +  "," + rSubdivi[M];
			 %>
			 
			  <%= rSubdivi1[M] %>&nbsp;&nbsp;&nbsp;
			<%					
			}
			qu1 = qu1 + ")";
		}
		a1 = "  group by c.subdivision_office_name ";

	}
	else if(session.getAttribute("pName")!=null){%>
		<td align="center" class="mystyle1"><font color="navy">Sub Division: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	<%
		//qu1 = "SELECT c.subdivision_office_name,sum(estimate_cost) from rws_rep_proposal_tbl rp, RWS_subdivision_OFFICE_TBL c where  substr(rp.office_code,2,2)=c.circle_office_code  and substr(rp.office_code,4,1)=c.division_office_code  and substr(rp.office_code,5,2)=c.subdivision_office_code  and substr(rp.office_code,2,2)='"+  request.getParameter("district")+"' and substr(rp.office_code,4,1)="+ request.getParameter("mandal")  + "  and substr(rp.office_code,5,2)="+ request.getParameter("mandal")  ;

		//a1 = "   group by c.subdivision_office_name ";
		}
		if(FYEAR != null)
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
			qu1 = qu1 + "   AND SUBSTR(TO_CHAR(a.REP_DATE, 'dd/MM/yyyy'),7,4) >='" + FYEAR[0]  +"' and   SUBSTR(TO_CHAR(rp.REP_DATE, 'dd/MM/yyyy'),7,4)<='" + FYEAR[k-1]  + "' ";
			
			}

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
	
		<%@ include file = "rws_proposal_offices_comp_graph.jsp" %>	
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