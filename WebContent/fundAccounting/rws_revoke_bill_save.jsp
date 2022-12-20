<%@ include file="/reports/conn.jsp" %>
<%
try{
	String dist=request.getParameter("dist");
	String div=request.getParameter("div");
	String frmDt=request.getParameter("fromDate");
	String toDt=request.getParameter("toDate");
	String dname=request.getParameter("dname");
	String divname=request.getParameter("divname");
	String qry1="",qry2="",qq="",qry="";int rcount=0;
	int recno=Integer.parseInt(request.getParameter("count"));
	conn.setAutoCommit(false);
	stmt =conn.createStatement();
	for(int i = 1; i < recno; i++)
	{
		String CentralAmt="",StateAmt="";
		if(request.getParameter("check["+i+"]")!=null && !request.getParameter("check["+i+"]").equals(""))
		{
		    rcount++; 
		    qq="delete from rws_bill_bank_bridge_tbl where work_id='"+request.getParameter("check["+i+"]")+"' and bill_sl_no='"+request.getParameter("blsno"+i)+"'";
			//System.out.println("qq:"+qq);
			stmt.addBatch(qq);	
		
			 qry="delete from rws_bill_bank_bridge_det_tbl where work_id='"+request.getParameter("check["+i+"]")+"' and bill_sl_no='"+request.getParameter("blsno"+i)+"'";
			//System.out.println("qry:"+qry);
			 stmt.addBatch(qry);	
			
			qry="delete from rws_bill_pao_bridge_det_tbl where work_id='"+request.getParameter("check["+i+"]")+"' and bill_sl_no='"+request.getParameter("blsno"+i)+"'";
			//System.out.println("qry:"+qry);
			
			 stmt.addBatch(qry);	

			 qry="update rws_work_bill_tbl set EE_FWD_DATE =null where work_id='"+request.getParameter("check["+i+"]")+"' and bill_sl_no='"+request.getParameter("blsno"+i)+"'";
			//System.out.println("qry:"+qry);
			 stmt.addBatch(qry);	
			}
		}
			int[] tot = stmt.executeBatch();
			if(tot.length>0)
			{
				conn.setAutoCommit(true);
				conn.commit();
				%>			
				 <script>
				var dist='<%=dist%>' ;
				var div='<%=div%>' ;	
				var frmDt='<%=frmDt%>';
				var toDt='<%=toDt%>';
				var dname='<%=dname%>';
				var divname='<%=divname%>';
				alert('<%=rcount%>'+" Bill(s) Revoked Scuessfully");
				document.location.href="rws_revoke_bill_process.jsp?district="+dist+"&division="+div+"&fromDate="+frmDt+"&toDate="+toDt+"&dname="+dname+"&divname="+divname;
				</script>
				<%
			 }
			else
			{ conn.rollback();
			 %>
			<script>
			var dist='<%=dist%>' ;
			var div='<%=div%>' ;
			var frmDt='<%=frmDt%>';
			var toDt='<%=toDt%>';
			var dname='<%=dname%>';
			var divname='<%=divname%>';
			alert("Failed to Save - Try Again");
			document.location.href="rws_revoke_bill_process.jsp?district="+dist+"&division="+div+"&fromDate="+frmDt+"&toDate="+toDt+"&dname="+dname+"&divname="+divname;
			</script>
			<%}   
	
}catch(Exception e){
	
//System.out.println("Exception In Revoke Bill Save Jsp"+e);	
}finally{
if(stmt!=null)stmt.close();
if(conn!=null)conn.close();
}%>