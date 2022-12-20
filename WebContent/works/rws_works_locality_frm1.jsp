<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>

<%int sno=0;
String wid=request.getParameter("workId");
//System.out.println("AAAAAAAAAAAAAAAAAAA:"+wid);
String wname=request.getParameter("workName");
//System.out.println("workName:"+wname);
%>
<script language="JavaScript">
function fncheckbox(index)
{
   if(document.getElementById('tsp'+index)!=null){
	    if(document.getElementById('tsp'+index).value=="")
	   {
		 alert("Before Select checkbox Please Provide  TSP/NTSP value ");
		 document.getElementById('check['+index+']').checked=false;
	   }
   }else{
	 alert("This Is not a ST Habitation");
	 document.getElementById('check['+index+']').checked=false;
   }
}
function fnSave(index)
{
	
	var checkchoice=0;

		for(var i=1;i<=index;i++)
		{
			
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
		else
		{
 		 var workid='<%=wname.substring(0,14)%>';
		 //alert(workid);
		document.forms[0].action="switch.do?prefix=/works&page=/worklocality.do?mode=stSave&workid="+workid;
		document.forms[0].submit();  

		}
}
function fnSC(code,name,type)
{
	var zURL = "./works/rws_work_locality_detais_rpt.jsp?habcode="+code+"&habname="+name+"&type="+type;
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
    myWin = window.open(zURL,'habs',popFeatures);
	myWin.focus();	
}
function fnWork(habcode,name,workid,scpop,stpop,plainpop)
{
	var zURL = "./works/rws_work_locality_served_rpt.jsp?habcode="+habcode+"&habname="+name+"&workid="+workid+"&scpop="+scpop+"&stpop="+stpop+"&plainpop="+plainpop;
	var popFeatures = "width=895,height=400,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
    myWin = window.open(zURL,'habs1',popFeatures);
	myWin.focus();	

}
</script>
<form  method="post">

<table border = 0 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr><td class=btext align="center">Work:<%=wname%></td></tr>
</table>&nbsp;
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Habitation List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr align="center">
    <td class=btext>Sl.No</td>
	<td class=btext>Select</td>
	<td class=btext>Hab Code</td>
	<td class=btext>Habitation Name</td>
	<td class=btext>Plain Population</td>
	<td class=btext>SC Population</td>
	<td class=btext>ST Population</td>
	<td class=btext>Coverage  Status</td>
	<td class=btext>Habitation Type</td>
	<td class=btext>Habitation Sub Type</td>
	<td class=btext>SC <br>Localities</td>
	<td class=btext>ST<br>Localities</td>
	<td class=btext>Minority<br> Localities</td>
	<td class=btext>TSP(ITDA)</td>
	<td class=btext>Work Coverage</td>
   </tr>
	 <nested:iterate id="hab"  name="habsdata">
	 <tr  bgcolor="#ffffff">
	 <td class="rptValue" width="20px" align="center"><%=++sno%></td>
	
	<td  class=rptvalue align="center"><input type="checkbox"name="check[<%=sno%>]" onclick="fncheckbox(<%=sno%>)" value='<nested:write name="hab" property="habCode"/>'/></td>
	
	 <td  class=rptvalue>
<nested:write name="hab" property="habCode"/>		
<bean:define id="hc" scope="request" >
 <nested:write name="hab" property="habCode"/>	
</bean:define>
	 </td>
	  <td  class=rptvalue nowrap>
	 <nested:write name="hab" property="habName"/>	
	 </td>
	 <td class=rptvalue align="right">
	 <nested:write name="hab" property="plainPop"/>	
	 </td>
	  <td  class=rptvalue align="right">
	 <nested:write name="hab" property="scPop"/>	
	 </td>
	  <td  class=rptvalue align="right">
	 <nested:write name="hab" property="stPop"/>	
	 </td>
      <td  class=rptvalue align="center">
	 <nested:write name="hab" property="codeStatus"/>	
	 </td>
	 <td  class=rptvalue align="right">
	 <nested:write name="hab" property="augType"/>	
	 </td>
	 <td  class=rptvalue align="center">
	 <nested:write name="hab" property="habsCode"/>	
	 </td>
	  <%
	  String qry="select (select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code='"+hc+"' and substr(locality_code,1,2)='SC'),(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code='"+hc+"' and substr(locality_code,1,2)='ST'),(select count(*) from RWS_SC_ST_MIN_LOCALITY_TBL where hab_code='"+hc+"' and substr(locality_code,1,2)='MT')  from dual";
	//System.out.println("qry:"+qry);
	 stmt=conn.createStatement();
	 rs=stmt.executeQuery(qry);
	 int val=0,val1=0,val2=0;
      if(rs.next()){
            val=rs.getInt(1);
			val1=rs.getInt(2);
			val2=rs.getInt(3);
	  }
	  %>
	 <td align="center" class=rptvalue><%=val%>
	 <input type=button name="button1"  value="&nbsp;&nbsp;...&nbsp;&nbsp;"
	  		 Class="btext" onclick="fnSC('<nested:write name='hab' property='habCode'/>','<nested:write name='hab' property='habName'/>','sc')" title="Click to Enter SC Details"/></td>
	 <td align="center"class=rptvalue><%=val1%>
	  <input type=button name="button1"  value="&nbsp;&nbsp;...&nbsp;&nbsp;"
	  		 Class="btext" onclick="fnSC('<nested:write name='hab' property='habCode'/>','<nested:write name='hab' property='habName'/>','st')" title="Click to Enter ST Details"/></td>
<td align="center" class=rptvalue><%=val2%> <input type=button name="button1"  value="&nbsp;&nbsp;...&nbsp;&nbsp;"
	  		 Class="btext" onclick="fnSC('<nested:write name='hab' property='habCode'/>','<nested:write name='hab' property='habName'/>','mt')" title="Click to Enter Minority Details"/></td>

    <td align="center">
	<nested:equal property="stage"  name="hab" value="">
		<select name="tsp<%=sno%>" class="mycombo" >
		<option value="">-select-</option>
		<option value="tsp">TSP</option>
		<!--<option value="ntsp">NTSP</option>-->
		</select>
      </nested:equal>  
	  <nested:equal property="stage"  name="hab" value="TSP">
	<select name="tsp<%=sno%>" class="mycombo" >  
		 <option value="">-select-</option>
		<option value="tsp" selected>TSP</option>
		<!--<option value="ntsp">NTSP</option>-->
	</select>
	</nested:equal>
		 <!--<nested:equal property="stage"  name="hab" value="NTSP">
	<select name="tsp<%=sno%>" class="mycombo" >
		 <option value="">-select-</option>
		<option value="tsp">TSP</option>
		<option value="ntsp" selected>NTSP</option>
	</select>
	</nested:equal>-->
	</td>
	 <td class=btext align="center"><input type=button name="button1" class="btext" value="&nbsp;&nbsp;...&nbsp;&nbsp;"
	  		 onclick="fnWork('<nested:write name='hab' property='habCode'/>','<nested:write name='hab' property='habName'/>','<%=wid%>','<nested:write name='hab' property='scPop'/>','<nested:write name='hab' property='stPop'/>','<nested:write name='hab' property='plainPop'/>')" title="Click to Enter Work Details"/></td>
	 </tr>
	 </nested:iterate>
<tr><td class=btext align="center" colspan=15><tr>
 <td align="center" colspan="15">
 <input type=button name="savework<%=sno%>" title="Save the Fields"  Class="btext" value="Save" onclick="fnSave(<%=sno%>)"/>
</td></tr>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<input type="hidden" name="resultCount" value="<%=sno%>"> 
<input type="hidden" name="workName" value="<%=request.getParameter("workName")%>">

<%@ include file="/commons/rws_alert.jsp" %>
</form>