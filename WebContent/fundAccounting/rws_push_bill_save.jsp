<%@ include file="/reports/conn.jsp" %>
<%
try{
	String dist=request.getParameter("dist");
	String div=request.getParameter("div");
	String vc=request.getParameter("vc");
	String frmDt=(String)session.getAttribute("fromDate");
	String toDt=(String)session.getAttribute("toDate");
	
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
		 if(request.getParameter("central"+i)!=null && !request.getParameter("central"+i).equals("")){CentralAmt=request.getParameter("central"+i);}
		 else{CentralAmt="0";}
		 if(request.getParameter("State"+i)!=null && !request.getParameter("State"+i).equals("")){StateAmt=request.getParameter("State"+i);}
		 else{StateAmt="0";}
		  rcount++; 
		    qq="update rws_work_bill_tbl set EE_FWD_DATE=SYSDATE where work_id='"+request.getParameter("check["+i+"]")+"' and bill_sl_no='"+request.getParameter("blsno"+i)+"' ";
			stmt.addBatch(qq);	
		
			 qry=" insert into rws_bill_bank_bridge_tbl (WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUT_STATE,BILL_AMOUNT_CENTRAL, BANK_SEND_DATE,STATE_FLAG,CENTRAL_FLAG,TXID,BILL_ACTIVATION_FLAG,STATE_TXID,STATE_SEND_DATE) values('"+request.getParameter("check["+i+"]")+"','','"+request.getParameter("blsno"+i)+"',"+StateAmt+","+CentralAmt+",sysdate,'Y','Y','','P','','') ";
			
			////System.out.println("qry:"+qry);
			stmt.addBatch(qry);	
			if(!CentralAmt.equals("0"))
			{
				qry1="insert into rws_bill_bank_bridge_det_tbl (WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUNT_CENTRAL,BANK_SEND_DATE, CENTRAL_FLAG,TXID,BILL_ACTIVATION_FLAG) values('"+request.getParameter("check["+i+"]")+"','','"+request.getParameter("blsno"+i)+"',"+CentralAmt+",sysdate,'Y','','P') ";
				stmt.addBatch(qry1);	
				////System.out.println("qry1:"+qry1);
			}
			if(!StateAmt.equals("0"))
			{
				qry2="insert into rws_bill_pao_bridge_det_tbl (WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUT_STATE,STATE_SEND_DATE,STATE_FLAG,STATE_TXID,BILL_ACTIVATION_FLAG ) values('"+request.getParameter("check["+i+"]")+"','','"+request.getParameter("blsno"+i)+"',"+StateAmt+",sysdate,'Y','','P') ";
				////System.out.println("qry2:"+qry2);
				stmt.addBatch(qry2);	
			}
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
				var vc='<%=vc%>' ;	
				var frmDt='<%=frmDt%>';
				var toDt='<%=toDt%>';
				var dname='<%=dname%>';
				var divname='<%=divname%>';
				alert('<%=rcount%>'+" Bill(s) Saved Scuessfully");
				document.location.href="rws_push_bill_rpt.jsp?district="+dist+"&division="+div+"&voucher="+vc+"&fromDate="+frmDt+"&toDate="+toDt+"&dname="+dname+"&divname="+divname;
				</script>
				<%
			 }
			else
			{ conn.rollback();
			 %>
			<script>
			var dist='<%=dist%>' ;
			var div='<%=div%>' ;
			var vc='<%=vc%>' ;	
			var frmDt='<%=frmDt%>';
			var frmDt='<%=toDt%>';
			var dname='<%=dname%>';
			var divname='<%=divname%>';
			alert("Failed to Save - Try Again");
			document.location.href="rws_push_bill_rpt.jsp?district="+dist+"&division="+div+"&voucher="+vc+"&fromDate="+frmDt+"&toDate="+toDt+"&dname="+dname+"&divname="+divname;
			</script>
			<%}   
	
}catch(Exception e){
	
//System.out.println("Exception In Push Bill Save Jsp"+e);	
}finally{
try{
if(stmt!=null)stmt.close();
if(conn!=null)conn.close(); }catch(Exception e){e.printStackTrace();}
}%>