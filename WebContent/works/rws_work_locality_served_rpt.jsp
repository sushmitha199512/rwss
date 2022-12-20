<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>

<%
Statement stmt1=null;
ResultSet rs1=null;
String habcode=request.getParameter("habcode");
String habname=request.getParameter("habname");
//System.out.println("code:"+habcode);
//System.out.println("name:"+habname);
String loctype=request.getParameter("loctype");
//System.out.println("loctype:"+loctype);
String workid=request.getParameter("workid");
//System.out.println("workid:"+workid);
String scpop=request.getParameter("scpop");
String stpop=request.getParameter("stpop");
String plainpop=request.getParameter("plainpop");
//System.out.println("plainpop:"+plainpop);

%>
<script language>
function fncheck(index)
{
  // alert(document.getElementById("popser"+index).value);
   if(document.getElementById("popser"+index).value=="")
{
  alert("Before Select checkbox Please Provide  Population value ");
  document.getElementById('check['+index+']').checked=false;
}
}
function fnSave(index,type)
{
var count=0;
var checkchoice=0;
//alert(type);
//alert('<%=stpop%>');
var scpop;
if(type=="SC")  {
scpop='<%=scpop%>';
}else if(type=="ST"){ 
scpop='<%=stpop%>';
}else if(type=="MT"){ 
scpop='<%=plainpop%>';
}

		for(var i=1;i<=index;i++)
		{
			if(document.getElementById("popser"+i).value!=""){
			 count+=parseInt(document.getElementById("popser"+i).value);
			}
			 //alert("count in for:"+count)
			if(document.getElementById('check['+i+']').checked)
			{
			checkchoice++;
			}
		}
		
		if(checkchoice==0)  
		{
		alert("Please Select At least One Checkbox");
		return false;
		}
		
		if(count > parseInt(scpop))
	   {
			alert("Population served Should be less than or equal to "+type+"  Populaion ("+scpop+")");
	   }
		else
		{
		 document.forms[0].action="switch.do?prefix=/works&page=/worklocality.do?mode=workSave";
		 document.forms[0].submit();  
		}
}

</script>
<html>
<form method="post">
<table border = 0 cellspacing = 0 cellpadding = 0 width=45%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">
<tr><td class=btext align="center">Habitation:<%=request.getParameter("habcode")%>-<%=request.getParameter("habname")%></td></tr>
<tr>
<%if(loctype==null || loctype.equals("")){%>
<td align="center" class=btext>Locality Type:<select name="loctype" class="mycombo"  onchange="this.form.submit()">
	<option value="">-select-</option>
	<option value="SC">SC</option>
	<option value="ST">ST</option>
	<option value="MT">Minority</option>
	</select></td>
<%} else if (loctype!=null && !loctype.equals("")){%>
<td align="center" class=btext>Locality Type:<select name="loctype" class="mycombo"  onchange="this.form.submit()">
<%if(loctype!=null && loctype.equals("SC")){%>
	<option value="">-select-</option>
	<option value="SC" selected>SC</option>
	<option value="ST">ST</option>
	<option value="MT">Minority</option>
	</select>
<%} else if(loctype!=null && loctype.equals("ST")){%>
<option value="">-select-</option>
	<option value="SC" >SC</option>
	<option value="ST" selected>ST</option>
	<option value="MT">Minority</option>
	</select>
<%}else if(loctype!=null && loctype.equals("MT")){%>
<option value="">-select-</option>
	<option value="SC" >SC</option>
	<option value="ST" >ST</option>
	<option value="MT" selected>Minority</option>
	</select>
<%}%>
	</td>
<%}
if(loctype!=null && loctype.equals("SC")) {%>
<tr><td class="btext" align="center">Total SC Population :<%=scpop%></td></tr>
<%}else  if(loctype!=null && loctype.equals("ST")) {%>
<tr><td class="btext" align="center">Total ST Population :<%=stpop%></td></tr>
<%}else  if(loctype!=null && loctype.equals("MT")) {%>
<tr><td class="btext" align="center">Total Plain Population :<%=plainpop%></td></tr>
<%}%>
</table>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<table  border = 1 cellspacing = 0 cellpadding = 0 width=45%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">

<thead>
<tr>
<td class=btext>Sl.No</td>
<td class=btext>Select</td>
<td class=btext>Locality Code</td>
<td class=btext>Locality Name</td>
<td class=btext>Population <br>Served</td>
</tr>
</thead>
<%
int sno=0;
String qry="select  locality_code,locality_name from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code='"+habcode+"'  and substr(locality_code,1,2)='"+loctype+"' order by locality_code";
stmt=conn.createStatement();
stmt1=conn.createStatement();
//System.out.println("qry:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{%>
<tr>
<td class=rptvalue><%=++sno%></td>
<td class=rptvalue><input type=checkbox name="check[<%=sno%>]"  value='<%=habcode%>'  onclick="fncheck(<%=sno%>)" /></td>
<td class=rptvalue><input type="text" name="code<%=sno%>"  readonly=true size="10" value='<%=rs.getString(1)%>'/></td>
<td class=rptvalue><input type="text" name="name<%=sno%>" readonly=true  size="15" value='<%=rs.getString(2)%>'/></td>
<%String qry1="select population_served from RWS_ASSET_LOCALITY_SERVE_TBL  where asset_code='"+workid+"' and locality_code='"+rs.getString(1)+"'  and hab_code='"+habcode+"' ";
//System.out.println("qry11111:"+qry1);
rs1=stmt1.executeQuery(qry1);
if(rs1.next()){%>
<td ><input  type="text" name="popser<%=sno%>" size="15" maxlength=5  value='<%=rs1.getString(1)%>'/></td>
<%}else{%>
<td ><input  type="text" name="popser<%=sno%>" size="15" maxlength=5  value=""/></td>
<%}%>
</tr>
<%}
if(sno==0)
{%>
<tr>
<td colspan=5 align="center"><input type="button" name="save" value ="Save" onclick="fnSave(<%=sno%>,'<%=loctype%>')" disabled></td>
</tr>
<%}else {%>
<tr>
<td colspan=5 align="center"><input type="button" name="save" value ="Save" onclick="fnSave(<%=sno%>,'<%=loctype%>')" ></td>
</tr>

<%}%>
</table>
<input type="hidden" name ="habcode" value="<%=habcode%>"/>
<input type="hidden" name ="habname" value="<%=habname%>"/>
<input type="hidden" name ="loctype" value="<%=loctype%>"/>
<input type="hidden" name="sno" value="<%=sno%>">
<input type="hidden" name="astcode" value="<%=workid%>">
</form>
</html>