
<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>

<%
String bankorPao=(String)session.getAttribute("bankOrPAO");
System.out.println("Coming");

String tableName="RWS_DIV_WORK_spill_REFUND_TBL";

PreparedStatement pstmt=null;
try{
    

int count=0;
	int resCount=Integer.parseInt(request.getParameter("resultCount"));
for(int i=0;i<resCount;i++){
String work_id=request.getParameter("check" + i);
if(work_id!=null){
String query="update "+tableName+" set refund_flag='p'  where work_id=?";
pstmt=conn.prepareStatement(query);
pstmt.setString(1, work_id);
//System.out.println("Updated Query"+query);
  count =pstmt.executeUpdate();
}
}
if(count>=1)
{
%>
<script>
			alert("Proccessed Successfully");
			document.location.href="rws_div_spillworks_refunds.jsp";
		</script>
<% }else{ %>
<script>
			alert("Failed");
			document.location.href="rws_div_spillworks_refunds.jsp";
		</script>
<% 
}
//System.out.println("Rows Updated"+count);
    
}catch(Exception e){
		System.out.println("Exeption at rws_div_spillworks_refunds_process : "+e);//e.printStackTrace();
}finally{
	conn.close();
	pstmt.close();
}
 %>
