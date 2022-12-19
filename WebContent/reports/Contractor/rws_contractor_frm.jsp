<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();


String checkb = request.getParameter("contractRadio");
if(checkb==null)checkb="";
%>


<html:html>
<script language="JavaScript">
function init()
{
	var value = '<%=checkb%>';
	//if(value=="2")
	//{
		//document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='block';
		//document.getElementById('text3').style.display='none';
		//document.getElementById('r2').checked=true;
	//}
}
function fnSearch()
{
    if(document.forms[0].firstName.value=="" || document.forms[0].firstName.value == null)
    {
    	alert("Please Enter Contactor name or Starting Letter");
//		document.forms[0].firstName.focus();
		return false;
    }
    else
    {
    	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=ViewContractor";
        document.forms[0].submit();
    }
}

function fnDivisionwise()
{
 document.forms[0].btn.disabled=true;
		if(document.forms[0].district.value=='')
			{
				alert("Please Select District");
				return false;
			}
		


	else
	{
    	document.forms[0].action="rws_contractor_division_rpt.jsp";
        document.forms[0].submit();
	}
}
function fnContactorsList()
{
        
		document.forms[0].amnt.value=document.getElementById("amount").value;
    	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=amountwisecontractors";
        document.forms[0].submit();

}

function getDivisions()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=getCircles&contractRadioVal=2";
    document.forms[0].submit();
	
	
}
function show()
{
	if(document.forms[0].contractRadio[1].checked)
	{
		document.getElementById('text1').style.display='block';
		document.getElementById('text2').style.display='none';
		document.getElementById('text3').style.display='none';
	}
/*
	else if(document.forms[0].contractRadio[1].checked)
	{
		document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='block';
		document.getElementById('text3').style.display='none';
	}
	else if(document.forms[0].contractRadio[2].checked)
	{
		document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='none';
		document.getElementById('text3').style.display='block';
	}
*/
	
}
</script>

<body onload="init()";>
<form >
<table border=0 width="340">	

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="./pred/home.jsp?loginMode=watersoft">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

		
		</table>

<jsp:include page="/commons/TableHeader3.jsp">
	<jsp:param name="TableName" value="Contractor Status " />
	<jsp:param name="TWidth" value="300" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" align="center">
<tr>
	<!--  <td><input type=radio id="r1" name="contractRadio"   value="1"   onclick="show()" visible=false />Contractor Wise</td> -->
	<!--  <td><input type=radio id="r2" name="contractRadio"  onclick="show()"   value="2" />Office Wise</td> -->
   <!--   <td><input type=radio id="r3" name="contractRadio"  onclick="show()"   value="3" visible=false/>Amount Wise</td> -->

	
</tr>
</table>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" align="center">

	<tr>
		<td>

		<div id="text1"  style="display:none;">
		<table>
    	<tr>
    	<td class="textborder" align="center" >Enter Starting Letter of Contractor:&nbsp;<input type="text"   style="width:80px" maxlength="25"  onkeypress="return alpha(event)"   /><input type="submit"  title="View"   value="View " onclick="return fnSearch()" /></td></tr>
		</tr>
       </table>
	  </div>
	  <div id="text2"  style="display:none;">
  		<table>
	  	<% 


try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
	//System.out.println("divcode:"+divcode);
%>
	<tr><td class=textborder>District&nbsp;<font color="red">*</font></td>
		<td class=textborder>
		<%
		if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.SEC_USER)))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
								
	if(rs.getString(1).equals(dcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
				}
				else
				{
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
	<%
				}
			}
						rs.close();			
						stmt.close();
		}
		else
		{
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></SELECT></td></tr>

		<tr>
		<%if(loggedUser!=null && (loggedUser.equals(Constants.ADMIN)||loggedUser.equals(Constants.LAKH_USER) ||loggedUser.equals(Constants.SEC_USER)))
		{%>
		<td class="textborder">Division&nbsp;</td>
		<td class="textborder">
		<SELECT name="division" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="">-Select-</option>
<%
			if(dcode!=null && !dcode.equals(""))
			{
				stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl d where circle_office_code='"+dcode+"' order by 3";
				rs.close();
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rs.getString(3).equals(divcode))
					{
		%>
						 <option value="<%=rs.getString(3)%>" selected><%=rs.getString(4)%></option> 
		<%
					}
					else
					{
		%>
						 <option value="<%=rs.getString(3)%>"><%=rs.getString(4)%></option> 
		<%
					}
				}
			}
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
			%>
				</SELECT>
			<%
		}
		else
		{
						%>
			<td class="textborder">Division&nbsp;<font color="red">*</font></td>
			<td>
			<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl where circle_office_code='"+dcode+"' and division_office_code='"+loggedUser.substring(3,4)+"'";
				//System.out.println("div qry:"+query);
				rs = stmt.executeQuery(query);
				if(rs.next())
				{
					divcode=rs.getString(3);
		%>
					<input type="text" name="divname" class="mytext" style="width:150px" value="<%=rs.getString(4)%>">
					<input type="hidden" name="division" value="<%=rs.getString(3)%>">
		<%
				}
		}


}catch(Exception e){
e.printStackTrace();
}
%>
		</td></tr>


<tr><td class="textborder">Category</td><td class="textborder"> 
	
		<SELECT name="cat"   style="width:140px">
		<option value=''>Select</option>
		<option value='1'>Projects</option>
		<option value='2'>Normal</option>
		<option value='3'>District Level</option>
		 </SELECT></td>
	
</tr>

	
	<tr><td></td><td></td>
	<td align="center"><input type="submit"  name="btn"  value="View Status" onclick="return fnDivisionwise()" /></td>
	</tr>
	</table>
	</div>

	  <div id="text3"  style="display:none;">
		<table>
    	<tr>
    	<td class="textborder" align="center" >Sanction Amount(In Lakhs):>=</td><td><select name="amount"><option value="100">100</option><option value="1000">1000</option></select></td>

<tr><td></td><td align=center><input type="submit"  value="View " onclick="return fnContactorsList()" /></td></tr>
		    
	  </table>
</div>
</td>
</tr>
<tr><td>

    	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="300"/>
	</jsp:include>
</table>
<input type="hidden" id="amnt">

</body>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>


