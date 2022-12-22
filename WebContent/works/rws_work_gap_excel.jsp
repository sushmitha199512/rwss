
<%@ page contentType="application/vnd.ms-excel" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.rws_works_WorkStatus_form"%>

<html:html>
<form>
<%
//System.out.println("jsp of arraylist:"+(ArrayList)session.getAttribute("viewworks"));
String stage1=request.getParameter("workStage");
//System.out.println("sssssstage:"+stage1);
 if(stage1!=null && stage1.equals("01"))
 {%>

<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Sanctioned Amount(Rs.in Lakhs)</th>
			  	 
			</tr>
			</thead>
 <%}else if(stage1!=null && stage1.equals("02")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
			 style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Technical Sanction No</th>
				 <th>Technical Sanction Date</th>
				 <th>Technical Sanction Amount(Rs.in Lakhs) </th>
			  	 </tr>
			</thead>
			
			
	<%}else if(stage1!=null && stage1.equals("03")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Tender Id</th>
				 <th>Contactor Name</th>
				 <th>Aggrement Date</th>
				 <th>Aggrement Value</th>
				
			  	 </tr>
			</thead>
			
			
	<%}
	else if(stage1!=null && stage1.equals("04")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Grounding Date</th>
				
			  	 </tr>
			</thead>
			
			
	<%}
	else if(stage1!=null && stage1.equals("05")){%>
			<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
				<th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Admin Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Year</th>
				 <th>Month</th>
				  </tr>
			</thead>
			
			
	<%}
	
	
	else  if(stage1!=null && stage1.equals("06")){%>

<table width="700" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
				   
			<thead class="gridHeader">
			<tr>
				<th nowrap>S.No.</th>
				<th>Work Id</th>
				<th>Work Name</th>
				<th>Division Name</th>
				<th>Plan Name</th>
				<th>Category Name</th>
                <th>Work Type</th>
                <th>Admin No</th> 
				<th>Admin Date</th>
				 <th>Sanctioned Amount(Rs.in Lakhs)</th>
				 <th>Date Of Completion</th>
			  	 
			</tr>
			</thead>


			<%}else{%>

			 
			<%}

 if((java.util.ArrayList)session.getAttribute("viewworks")!=null){
 
	 int sno=0;
	 if(stage1!=null && stage1.equals("01")){%>
		
		
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td>	<bean:write name="rep" property="adminDate" />	</td>
<td><bean:write name="rep" property="samount" /></td>
</tr>

</logic:iterate>
	<%}else  if(stage1!=null && stage1.equals("02")){%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="divName" /></td>
<td>	<bean:write name="rep" property="plan" />	</td>
<td><bean:write name="rep" property="workCat" /></td>
<td><bean:write name="rep" property="augType" /></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td><bean:write name="rep" property="adminDate" /></td>
<td><bean:write name="rep" property="samount" /></td>
<td><bean:write name="rep" property="tsNo" /></td>
<td><bean:write name="rep" property="tsDate" /></td>
<td><bean:write name="rep" property="tsAmnt" /></td>
</tr>

</logic:iterate>

        <% }
		else  if(stage1!=null && stage1.equals("03")){%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="divName" /></td>
<td>	<bean:write name="rep" property="plan" />	</td>
<td><bean:write name="rep" property="workCat" /></td>
<td><bean:write name="rep" property="augType" /></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td><bean:write name="rep" property="adminDate" /></td>
<td><bean:write name="rep" property="samount" /></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>

</logic:iterate>

        <% }else  if(stage1!=null && stage1.equals("04")){%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="divName" /></td>
<td>	<bean:write name="rep" property="plan" />	</td>
<td><bean:write name="rep" property="workCat" /></td>
<td><bean:write name="rep" property="augType" /></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td><bean:write name="rep" property="adminDate" /></td>
<td><bean:write name="rep" property="samount" /></td>
<td></td>
</tr>

</logic:iterate>

        <% }else  if(stage1!=null && stage1.equals("05")){%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="divName" /></td>
<td>	<bean:write name="rep" property="plan" />	</td>
<td><bean:write name="rep" property="workCat" /></td>
<td><bean:write name="rep" property="augType" /></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td><bean:write name="rep" property="adminDate" /></td>
<td><bean:write name="rep" property="samount" /></td>
<td></td>
<td></td>
</tr>

</logic:iterate>

        <% }else  if(stage1!=null && stage1.equals("06")){%>
		<logic:iterate id="rep" name="viewworks">
<tr align="left" >
<td ><%=++sno%></td>
<td>&nbsp;<bean:write name="rep" property="workId" /></td>
<td><bean:write name="rep" property="workName"/></td>
<td><bean:write name="rep" property="divName" /></td>
<td>	<bean:write name="rep" property="plan" />	</td>
<td><bean:write name="rep" property="workCat" /></td>
<td><bean:write name="rep" property="augType" /></td>
<td><bean:write name="rep" property="adminNo" /></td>
<td><bean:write name="rep" property="adminDate" /></td>
<td><bean:write name="rep" property="samount" /></td>
<td></td>

</tr>

</logic:iterate>
<% }
}
		else{%>
			
		<%}%>

</form>

</html:html>
