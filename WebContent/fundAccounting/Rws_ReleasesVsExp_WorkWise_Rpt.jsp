<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<script language="javascript">
var workIdList=[
<c:forEach items="${releasesVsExpenditureList}" var="item" varStatus="status">
	'<c:out value="${item.workId}"/>',
</c:forEach>
];
function funcInit()
{
document.getElementById("releasesVsExpenditureTable").style.height="10%";
<%if(request.getParameter("selectedWorkId")!=null){%>
var workId="<%=request.getParameter("selectedWorkId")%>";
toggleItem("collapseWork_"+workId,workId);      
toggleItem("collapseWorkExpenditure_"+workId,workId);   
toggleItemForExpenditure("expenditureUptoPrevYear_"+workId,workId);  

showOnlySelected(workId);
<%}%>
}
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

function toggleItem(id,workId)
    {   
        //this line redraws the table adjusting the size
        document.getElementById("releasesVsExpenditureTable").style.height="10%";
        itm = getItem(id);
        var im = "onea_"+workId;
        if(!itm)
            return false;
        if(itm.style.display == 'none'){
            itm.style.display = '';
            if (document.images[im]) {
			document.images[im].src = "/pred/images/collapse.gif";
		    }
        }    
        else{
		      itm.style.display = 'none';
		      if (document.images[im]) {
			document.images[im].src = "/pred/images/expand.gif";
		   }
	    }	      

        return false;
    }
 function showTitleForExpenditure(id,idOfDiv)
    {
     	itm = getItem(id);
     	if(itm.style.display == 'none')
     		document.getElementById(idOfDiv).title="click to expand";
     	else
     		document.getElementById(idOfDiv).title="click to collapse";
   }
 function toggleItemForExpenditure(id,workId)
    {   
        //this line redraws the table adjusting the size
        document.getElementById("releasesVsExpenditureTable").style.height="10%";
        itm = getItem(id);
        var im = "oneb_"+workId;
        if(!itm)
            return false;
        if(itm.style.display == 'none'){
            itm.style.display = '';
            if (document.images[im]) {
			document.images[im].src = "/pred/images/collapse.gif";
		    }
        }    
        else{
		      itm.style.display = 'none';
		      if (document.images[im]) {
			document.images[im].src = "/pred/images/expand.gif";
		   }
	    }	      

        return false;
    }
    
    function collapseAllReleases()
    {   
        //this line redraws the table adjusting the size
		document.getElementById("releasesVsExpenditureTable").style.height="10%";
        for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="collapseWork_"+workId;
        		itm = getItem(id);
        		var im = "onea_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = 'none';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/expand.gif";
		    	}
        
		   	}
	    }	      

     }
     
     function showOnlySelected(selectedWorkId)
    {   
        //this line redraws the table adjusting the size
		document.getElementById("releasesVsExpenditureTable").style.height="10%";
       
        for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		if(workId!=selectedWorkId)
        		{
	        		id="workHeaderRow_"+workId;
	        		itm = getItem(id);
	        		itm.style.display = 'none';
	        		
	        		id="collapseWork_"+workId;
        			itm = getItem(id);
        			itm.style.display = 'none';
        			
        			id="collapseWorkExpenditure_"+workId;
        			itm = getItem(id);
        			itm.style.display = 'none';
        			
        			id="expandableReleasesDiv_"+workId;
        			itm = getItem(id);
        			itm.style.display = 'none';
        			
        			id="expandableExpenditureDiv_"+workId;
        			itm = getItem(id);
        			itm.style.display = 'none';
        			
        			
        			id="rowBreak_"+workId;
        			if(document.getElementById(id))
        			{
        			itm = getItem(id);
        			itm.style.display = 'none';
        			}
        			
        			
	            }
		   	}
	    }	      
		
     }
     
     function collapseAllExpenditure()
    {   
        //this line redraws the table adjusting the size
		document.getElementById("releasesVsExpenditureTable").style.height="10%";
        for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="collapseWorkExpenditure_"+workId;
        		itm = getItem(id);
        		var im = "oneb_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = 'none';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/expand.gif";
		    	}
        
		   	}
	    }
	    for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="expenditureUptoPrevYear_"+workId;
        		itm = getItem(id);
        		var im = "oneb_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = 'none';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/expand.gif";
		    	}
        
		   	}
	    }
	    
	    	      

     }
     function expandAllReleases()
    {   
        //this line redraws the table adjusting the size
		document.getElementById("releasesVsExpenditureTable").style.height="10%";
        for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="collapseWork_"+workId;
        		itm = getItem(id);
        		var im = "onea_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = '';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/collapse.gif";
		    	}
		    	
		    	
		    	//for expanding headers
		    	id="expandableReleasesDiv_"+workId;
    			itm = getItem(id);
    			itm.style.display = '';
        
		   	}
	    }	      

     }
     
     
     function expandAllExpenditure()
    {   
        //this line redraws the table adjusting the size
		document.getElementById("releasesVsExpenditureTable").style.height="10%";
        for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="collapseWorkExpenditure_"+workId;
        		itm = getItem(id);
        		var im = "oneb_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = '';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/collapse.gif";
		    	}
		    	
		    	//for expanding headers
 				id="expandableExpenditureDiv_"+workId;
    			itm = getItem(id);
    			itm.style.display = '';
    			
    			id="rowBreak_"+workId;
			    if(document.getElementById(id))
			    {
			    	itm = getItem(id);
			        itm.style.display = '';
			    }
			    
			    id="workHeaderRow_"+workId;
	        	itm = getItem(id);
	        	itm.style.display = '';
        
		   	}
		   	
		   
	    }	
	    
	    for(var i=0;i<workIdList.length;i++)
        {
        	if(workIdList[i])
        	{
        		workId=workIdList[i];
        		id="expenditureUptoPrevYear_"+workId;
        		itm = getItem(id);
        		var im = "oneb_"+workId;
        		if(!itm)
            	return false;
	        	itm.style.display = '';
	            if (document.images[im]) 
	            {
					document.images[im].src = "/pred/images/collapse.gif";
		    	}
        
		   	}
	    }	            

     }
 
 function collapseAll()
 {
 	collapseAllReleases();
 	collapseAllExpenditure();
 }
 function expandAll()
 {
 	
   	expandAllReleases();
 	expandAllExpenditure();
 	
 	
 }
</script>
<body onload="funcInit()">
<html:form action="releasesVsExpenditureWorkWise.do">
</html:form>
<%if(request.getParameter("selectedWorkId")==null){%>
<a href="#1" onclick="expandAll()">Expand All</a>&nbsp;|
<a href="#1" onclick="collapseAll()">Collapse All</a>
<%}else {%>
<a href="#1" onclick="expandAll()">Show All</a>
<%} %>
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor="black" id="releasesVsExpenditureTable">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder">
				<table border="0" width="100%"><tr><td><font color="#FFFFFF" size="2">Releases Vs Expenditure For Projects Summary</font>
				<font color="#FFFFFF" size="2">&nbsp;&nbsp;&nbsp;</font></td>
				<td align="right"><font color="#FFFFFF" size="3"><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="13" HEIGHT="13" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td>
				</tr>
				</table>
			</td>	
</tr>
</thead>
<!-- 
<tfoot>
<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF" size="1">&nbsp;</font>
			</td>	
</tr>
</tfoot>
 -->
<tbody bgcolor="#DEE3E0">
<tr>
<td>
	<fieldset>
	<legend></legend>
	<label>
	<c:if test="${not empty releasesVsExpenditureList}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<!-- 
	<tr>
		<th>Work Id</th>
		<th>Work Name</th>
		<th>Total Amount Released</th>
		<th>Total Expenditure</th>
		<th>Value Of WorkDone But Not Paid</th>
		
		
	</tr>
	 -->
	</thead>
	<tbody class="label">
	
	<c:forEach items="${releasesVsExpenditureList}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${index != 0}">
	<tr id='rowBreak_<c:out value='${item.workId}'/>'><td colspan="6">&nbsp;</td></tr>
	</c:if>
	
	<tr class="gridHeader" id='workHeaderRow_<c:out value='${item.workId}'/>'>
		<td width="145"><b><a name="at<c:out value='${item.workId}'/>" >
	<bean:message key="app.workId" />: </b><c:out value="${item.workId}"/></a></td>
		<td width="145"><b>Work Name: </b><c:out value="${item.workName}"/></td>
		<td width="145"><b>Total Amount Released: </b><c:out value="${item.totalReleases}"/></td>
		<td width="145"><b>Total Expenditure: </b><c:out value="${item.totalExpenditure}"/></td>
		<td width="145" colspan="2"><b>Value Of WorkDone But Not Paid: </b><c:out value="${item.valueOfWorkDoneButNotPaid}"/></td>
		
	</tr>	
	<!-- displaying details -->
	<c:set var="workIdTmp" value="" />
	<c:set var="workIdTmp2" value="" />
	
	<tr class="<c:out value='row${index%2}'/>" id='expandableReleasesDiv_<c:out value='${item.workId}'/>'>
	<td  colspan="6" >
	<div onmouseover="showTitleForExpenditure('collapseWork_<c:out value='${item.workId}'/>','collapseWorkDiv_<c:out value='${item.workId}'/>')" onclick="return toggleItem('collapseWork_<c:out value='${item.workId}'/>','<c:out value='${item.workId}'/>')" style="cursor:hand" id="collapseWorkDiv_<c:out value='${item.workId}'/>"><img style="WIDTH: 13px; HEIGHT: 11px" src="/pred/images/expand.gif" name="onea_<c:out value='${item.workId}'/>"><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >
					&nbsp;<b>Details Of Releases</b></font></div>		
	
	</td>
	</tr>
	
	<tr id="collapseWork_<c:out value='${item.workId}'/>"  style="display:none"><td colspan="6">
	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse" >
	<tr class="<c:out value='row${index%2}'/>" >
	<td><b><small>Bro Id</small></b></td>
	<td><b><small>Loc Id</small></b></td>
	<td><b><small>Programme Name</small></b></td>
	<td><b><small>Head Of Account</small></b></td>
	<td><b><small>Loc Reference</small></b></td>
	<td><b><small>Loc Amount</small></b></td>
	</tr>
	<%int i=-1; %>
	<c:forEach items="${releasesVsExpenditureDetailsList}" var="detailsItem" varStatus="detailsStatus">
	<c:set var="detailsIndex" value="${detailsStatus.index}" />
	<c:if test="${detailsItem.workId == item.workId}">
	<%i++; %>
	
	<c:if test="${detailsItem.workId != workIdTmp}">
	<c:set var="workIdTmp" value="${detailsItem.workId}" />
	
	</c:if>
	<tr>
	
	<td colspan="6">
	
	<tr class="<c:out value='row${index%2}'/>">
	<td><c:out value="${detailsItem.broId}"/></td>
	<td><c:out value="${detailsItem.locId}"/></td>
	<td><c:out value="${detailsItem.programmeName}"/></td>
	<td><c:out value="${detailsItem.headOfAccount}"/></td>
	<td><c:out value="${detailsItem.locReference}"/></td>
	<td><c:out value="${detailsItem.locAmount}"/></td>
	</tr>
	
	
	</c:if>
	</c:forEach>	
	<%if(i==-1){ %>
	<tr class="<c:out value='row${index%2}'/>"><td colspan="6" align="center"><small>No Data</small></td></tr>
	<%} %>
	</table>
	</td>
	</tr>
	<!-- code to display expenditure details -->
	<c:set var="workIdTmpForWorkExp" value="" />
	<c:set var="workIdTmp2ForWorkExp" value="" />
	<tr class="<c:out value='row${index%2}'/>" id='expandableExpenditureDiv_<c:out value='${item.workId}'/>'>
	<td  colspan="6">
	<div onmouseover="showTitleForExpenditure('collapseWorkExpenditure_<c:out value='${item.workId}'/>','collapseWorkExpDiv_<c:out value='${item.workId}'/>')" onclick="toggleItemForExpenditure('collapseWorkExpenditure_<c:out value='${item.workId}'/>','<c:out value='${item.workId}'/>');toggleItemForExpenditure('expenditureUptoPrevYear_<c:out value='${item.workId}'/>','<c:out value='${item.workId}'/>')" style="cursor:hand" id="collapseWorkExpDiv_<c:out value='${item.workId}'/>"><img style="WIDTH: 13px; HEIGHT: 11px" src="/pred/images/expand.gif" name="oneb_<c:out value='${item.workId}'/>"><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >
					&nbsp;<b>Details Of Expenditure</b></font></div>		
	
	</td>
	</tr>
	
	<tr style="border-collapse: collapse" id="expenditureUptoPrevYear_<c:out value='${item.workId}'/>"  style="display:none"><td colspan="6">
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse" >
	<tr class="<c:out value='row${index%2}'/>">
	<td><b><small>Programme Name</small></b></td>
	<td><b><small>Expenditure Upto Previous Year</small></b></td>
	</tr>
	<%i=-1; %>
	<c:forEach items="${expenditureUptoPrevYearList}" var="expenditureUptoPrevYearListItem" varStatus="expenditureUptoPrevYearListStatus">
	<c:set var="expenditureUptoPrevYearListIndex" value="${expenditureUptoPrevYearListStatus.index}" />
	<c:if test="${expenditureUptoPrevYearListItem.workId == item.workId}">
	<%i++; %>
	
	<c:if test="${expenditureUptoPrevYearListItem.workId != workIdTmpForexpenditureUptoPrevYearList}">
	<c:set var="workIdTmpForexpenditureUptoPrevYearList" value="${expenditureUptoPrevYearListItem.workId}" />
	
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
	<td><c:out value="${expenditureUptoPrevYearListItem.programmeName}"/></td>
	<td><c:out value="${expenditureUptoPrevYearListItem.expenditureUptoPrevYear}"/></td>
	</tr>
	
	</c:if>
	</c:forEach>
	<%System.out.println("i is "+i); %>	
	<%if(i==-1){ %>
	<tr class="<c:out value='row${index%2}'/>"><td align="center" colspan="6"><small>No Data</small></td></tr>
	<%} %>
	
	</table>
	
	
	
	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse" id="collapseWorkExpenditure_<c:out value='${item.workId}'/>"  style="display:none">
	<tr class="<c:out value='row${index%2}'/>">
	<td><b><small>Programme Name</small></b></td>
	<td><b><small>Year</small></b></td>
	<td><b><small>Month</small></b></td>
	<td><b><small>Expenditure During The Month</small></b></td>
	<td><b><small>Value Of WorkDone But Not Paid</small></b></td>
	</tr>
	
	
	<%i=-1; %>
	<c:forEach items="${expenditureDetailsList}" var="workExpDetailsItem" varStatus="workExpDetailsStatus">
	<c:set var="workExpDetailsIndex" value="${workExpDetailsStatus.index}" />
	<c:if test="${workExpDetailsItem.workId == item.workId}">
	<%i++; %>
	
	<c:if test="${workExpDetailsItem.workId != workIdTmpForWorkExp}">
	<c:set var="workIdTmpForWorkExp" value="${workExpDetailsItem.workId}" />
	
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
	<td><c:out value="${workExpDetailsItem.programmeName}"/></td>
	<td><c:out value="${workExpDetailsItem.year}"/></td>
	<td><c:out value="${workExpDetailsItem.month}"/></td>
	<td><c:out value="${workExpDetailsItem.expenditureDuring}"/></td>
	<td><c:out value="${workExpDetailsItem.valueOfWorkDoneButNotPaid}"/></td>
	</tr>
	
	</c:if>
	</c:forEach>
	<%System.out.println("i is "+i); %>	
	<%if(i==-1){ %>
	<tr class="<c:out value='row${index%2}'/>"><td align="center" colspan="6"><small>No Data</small></td></tr>
	<%} %>
	</table>
	</td>
	</tr>
	<!-- end of code to display expenditure details -->
	
	<!-- end of displaying details -->
	
	</c:forEach>
	</tbody>
	</table>
	</c:if>
	
	
	</label>
	</fieldset>
	</td>
	</tr>
	</tbody>
	</table>

</body>
<%@ include file="/commons/rws_footer.jsp"%>