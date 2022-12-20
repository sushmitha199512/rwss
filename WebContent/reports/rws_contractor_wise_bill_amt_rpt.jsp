<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.text.NumberFormat"%>
<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%
NumberFormat formatter = new DecimalFormat("#0.00");
		  int count = 1,sno=0;	
ResultSet rs2=null;
Statement pst2=null;
String cont_code="",cont_name="";
int nowrks=0;
double stateamt=0,centralamt=0,sum1=0,sum2=0,sum3=0;
%>
<html>
<style>
#input_box {
	background-color:#C9DFF4;
	font-weight:bold;
}
</style>
<script language="javascript">

function fnPrint()
{
	var width = 900;
	var height = 600;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_bill_tobe_release_rpt_secy_prt.jsp";
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow1 = window.open(url, "_New", properties);
	newWindow1.focus();
}
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
function fnClose()
{
	document.location.href="../home.jsp";
}
</script>

<body  bgcolor="#edf2f8">
<form>
<table border = 0>	
		<caption>
			<table  border=0 width="960px" rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
						<a href="rws_ENC_homepage_frm.jsp">My Home</a>
					</td>
				</tr>
			</table>
		</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="80%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		

			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>|</td></tr>
	
			</table>
		</caption>
  

<%

		


DecimalFormat ndf = new DecimalFormat("####.00");
try
{   
           
	%>
		<table>

		<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext >Contractor Code </td>
            <td class=btext >Contractor Name</td>
            <td class=btext >No.of Works</td>
            <td class=btext >Bill Amount State</td>
            <td class=btext >Bill Amount Central</td>
			
 		</tr>
	     
        <%
       
          String qry1="select  a.CONTRACTOR_CODE ,b.CONTRACTOR_NAME_COMPANY,count(c.work_id),nvl(sum(c.bill_amout_state),0),nvl(sum(c.bill_amount_central),0) from rws_contractor_selection_tbl a ,rws_contractor_tbl b, rws_bill_bank_bridge_temp_tbl c where a.work_id=c.work_id and a.CONTRACTOR_CODE=b.CONTRACTOR_CODE and c.BILL_ACTIVATION_FLAG ='I' group by a.CONTRACTOR_CODE ,b.CONTRACTOR_NAME_COMPANY";
          pst2=conn.createStatement();
          rs2=pst2.executeQuery(qry1);
          while(rs2.next())
          {
         %>

       <tr align="center">
            <td class=rptvalue align="left"><%=count++%></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=cont_code%></td>
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=cont_name%></td>	
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=nowrks%></td>	
			<td class=rptvalue align="right"  bgcolor="#FFB280"><%=stateamt%></td>	
            <td class=rptvalue align="right"  bgcolor="#FFB280"><%=centralamt%></td>
        </tr>
			<%
			}

sum1+=nowrks;
sum2+=stateamt;
sum3+=centralamt;
 %>
<tr align="center" class=btext bgcolor="#ffffff">
           <td class=btext colspan=3>Totals</td>
            <td class=btext align="right"><%=sum1%></td>
            <td class=btext align="right"><%=sum2%></td>          
			<td class=btext align="right"><%=sum3%></td>
            
			
		</tr>
<%
}

catch(Exception e)
{
	e.printStackTrace();
}
%>
</table> 
</form>
</body>
</html>

