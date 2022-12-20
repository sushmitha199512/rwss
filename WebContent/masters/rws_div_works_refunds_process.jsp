
<%@ include file="/reports/conn.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_enc_header1.jsp"%>

<%
String bankorPao=(String)session.getAttribute("bankOrPAO");
//System.out.println("Coming");

String tableName=null;
if(bankorPao!=null && bankorPao.equals("1")){
tableName="rws_div_work_bank_refund_tbl";
System.out.println("Tale name:"+bankorPao);
}else if(bankorPao!=null && bankorPao.equals("2")){
tableName="rws_div_work_pao_refund_tbl";
}else{
  tableName="rws_div_work_bank_refund_tbl";
}
PreparedStatement pstmt=null;
try{
    

int count=0;
String mode=request.getParameter("mode");
	int resCount=Integer.parseInt(request.getParameter("resultCount"));
	String work_id="";

	String update_date="";
for(int i=0;i<resCount;i++){
	
	String s=request.getParameter("check" + i);
	if(s!=null){
	String ar[]=s.split("@#");
	
		work_id=ar[0];
		update_date=ar[1];
	}

System.out.println(work_id);
if(work_id!=null){
	String query="";
	if(mode.equals("accept")){
 		query="update "+tableName+" set refund_flag='p'  where work_id=? and update_date=to_date(?,'dd/mm/yyyy')";
	}
	else if(mode.equals("reject")){
		query="update "+tableName+" set refund_flag='r'  where work_id=? and update_date=to_date(?,'dd/mm/yyyy')";
	}
pstmt=conn.prepareStatement(query);
pstmt.setString(1, work_id);
pstmt.setString(2, update_date);
//System.out.println("Updated Query"+query);
  count =pstmt.executeUpdate();
}
}

if(count>=1)
{
%>
<script>
			alert("Proccessed Successfully");
			document.location.href="rws_div_works_refunds.jsp";
		</script>
<% }else{ %>
<script>
			alert("Failed");
			document.location.href="rws_div_works_refunds.jsp";
		</script>
<% 
}
//System.out.println("Rows Updated"+count);
    
}catch(Exception e){
		System.out.println("Exception at rws_div_works_refunds_process : "+e);//e.printStackTrace();
}finally{
	conn.close();
	pstmt.close();
}
 %>
