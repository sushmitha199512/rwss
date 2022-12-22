<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%String userId = request.getParameter("userId");%>
<script>
function fnDelete()
{
	if(document.forms[0].number.value!="")
	{
		var userId = '<%=userId%>';
		var url = "switch.do?prefix=/admin&page=/EditUser.do&mode=Del&userId="+userId+"&number="+document.forms[0].number.value;
		document.getElementById('del').disabled=true;
		document.getElementById('del').value="Wait......";
		document.location.href= url;
		return false;
	}
	else return false;
}
</script>

<form action="EditUser.do&mode=Delete">
<p align=center><b><font face=verdana color=red size=3>To Delete the User <BR> Please Enter Security Code </font></b></p>
<div  id="captcha"><%@include file="./Captcha/form.jsp"%></div>
<p align=center><input type="button" id="del" name="delete" value="Proceed to Delete" class="btext" onclick="return fnDelete()"></p>
</form>