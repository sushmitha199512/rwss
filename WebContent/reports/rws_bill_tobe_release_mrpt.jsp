<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<script language="JavaScript">


function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

function isSaveAttended()
{
		if(document.f1.fyear.value=="" || document.f1.fyear.value==null || document.f1.fyear.value=="0")
		{
			alert("Select financial year");
		}
		else
		{
			var h=document.f1.fyear.value;
			//alert(h);
			document.f1.action="./rws_bill_tobe_release_modified_rpt.jsp?fyear="+h;
			document.f1.submit();
			init();
		}
}


function isSaveAttended1()
{
		if(document.f1.fyear.value=="" || document.f1.fyear.value==null || document.f1.fyear.value=="0")
		{
			alert("Select financial year");
		}
		else
		{
			var h=document.f1.fyear.value;
			//alert(h);
			document.f1.action="./rws_exp_voucher_div_rpt.jsp?fyear="+h;
			document.f1.submit();
			init();
		}
}

	
function init()
{
document.f1.fyear.value='0';
}

</script>

<%String rDist=null; %>

<form name=f1 >

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
           <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		   </table>	

		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
			
                <font color="#FFFFFF">Select Financial Year</font>
			</td>	
		</tr>






		<tr>
		<td>
		<table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
		<!-- <table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center> -->
		
		
        
		<tr align="center">
		<td class="textborder" width="200">Select Year <font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">

		<SELECT name="fyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>

<%

	try{
Statement stmt11=conn.createStatement();
String fy="";
int fy1=0;
			String finquery="select distinct  substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_bill_bank_bridge_TBL where BANK_SEND_DATE is not null";
		System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			while(rs11.next())
			{
 fy=rs11.getString(1);
				 fy1=Integer.parseInt(fy)+1;
				
	%>
			<option value="<%=fy.substring(2,4)%>"><%=fy+"-"+fy1%></option> 

<% 

			}
						if(rs11!=null)rs11.close();
						if(stmt11!=null)stmt11.close();
		
}catch(Exception e){

e.printStackTrace();}
%>

</SELECT>
		</td>
	
		
		</table>
		</td>
			 		 
			 	
		
		</tr>
		
	<tr>
		<td class="textborder" align=center>			 
		<input type=button value="Submit" styleClass="btext"  onclick="isSaveAttended1();">
		
		</td>
	</tr>
	

</table>



</form>

<%@ include file="/commons/rws_footer.jsp"%>

<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>


