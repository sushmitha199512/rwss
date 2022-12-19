<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp" %>
<body>
<form  name=f1 action="<%= request.getRequestURI()%>" method="post">
<%
  nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
  String userid = users.getUserId(); 
  System.out.println("my report userid"+userid);
  String loginuserid=userid;
  String myuserid="";
  int size=loginuserid.length();	
            if(loginuserid.equals("admin") || loginuserid.equals("100000") || loginuserid.equals("secrwss"))
			{
				myuserid="";
			}
			if(!loginuserid.equals("admin") && !loginuserid.equals("100000") && (size==6))
			{
					if(!loginuserid.substring(1,3).equals("00") && loginuserid.substring(3,4).equals("0") && loginuserid.substring(4,6).equals("00"))
					{
						myuserid="where TO_OFFICE_LEVEL ='HO,CO'";
					}
					if(!loginuserid.substring(1,3).equals("00") && !loginuserid.substring(3,4).equals("0") && loginuserid.substring(4,6).equals("00"))
					{
						myuserid="where TO_OFFICE_LEVEL ='HO,CO,DO'";
					}
					if(!loginuserid.substring(1,3).equals("00") && !loginuserid.substring(3,4).equals("0") && !loginuserid.substring(4,6).equals("00"))
					{
						myuserid="where TO_OFFICE_LEVEL ='HO,CO,DO,SO'";
					}
                    if(!loginuserid.substring(1,3).equals("00") && !loginuserid.substring(3,4).equals("0") && !loginuserid.substring(4,6).equals("00"))
					{
						myuserid="where TO_OFFICE_LEVEL ='HO,CO,DO,SO'";
					}

			}
			System.out.println("myuserid>>>>>>>>>>112202>>"+myuserid);

  try
     { 
      %>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
         	<td class="bwborder"><a href="#" onclick="window.close();">Close&nbsp; </a></td>
			</tr>  
		</table>
	</caption>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" >Message List</td>
</tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
<td class=btext ><b>SLNO </b></td>
<td class=btext ><b>Sender</b></td>  
<td class=btext ><b>Message</b></td> 
<td class=btext ><b>Date</b></td> 
</tr>
       <%
       int count=1;
       Statement stmt1=null,stmt2=null,stmt3=null;
       ResultSet rs1=null,rs2=null,rs3=null;
       String qry="",qry1="",qry2="",mbgcolor="",mfcolor="",mstatus="";
       stmt1=conn.createStatement();
       stmt2=conn.createStatement();
       int p=0,msid=0;
           qry="select FROM_USERID,substr(MESSAGE_DETAILS,1,10),to_char(MESSAGE_DATE,'dd-MON-yyyy'),MESSAGE_PRIORITY,READ_STATUS,MESG_ID  from rws_secretary_message_tbl "+myuserid+" order by 3 desc";
	       System.out.println("qry***********"+qry);
	       rs1=stmt1.executeQuery(qry);
	            while(rs1.next())
             {      
    
                  p=rs1.getInt(4);
                  mstatus=rs1.getString(5);
                  msid=rs1.getInt(6);

                  if(p==1 && mstatus.equals("N"))
                 { 
                   mbgcolor="Red";
                   mfcolor="black";
                 }
				 else if(p==2 && mstatus.equals("N"))
                 { 
                   mbgcolor="orange";
                   mfcolor="black";
                 }
				 else if(p==3 && mstatus.equals("N"))
                 { 
                   mbgcolor="green";
                   mfcolor="white";
                 }
                 else if(mstatus.equals("R"))
                 { 
                   mbgcolor="lightgray";
                   mfcolor="black";
                 }
                 else
                 {  mbgcolor="white";
                    mfcolor="white";
                 }

             %>   
		        <tr bgcolor='<%=mbgcolor%>' onmouseover="this.style.background='lightblue'" onmouseout="this.style.background='<%=mbgcolor%>'"> 
                <td class=rptValue><font color='<%=mfcolor%>'><%=count++%> </font></td>
                <td class=rptValue><font color='<%=mfcolor%>'><%=rs1.getString(1)%></font></td>  
				<td class=rptValue><a href="#" onClick="window.open('./rws_secrep_message_details_rpt.jsp?msid=<%=msid%>','mywindow','width=400,height=200,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no');"><font color='<%=mfcolor%>'><%=rs1.getString(2)%>....</font></a></td>  
                <td class=rptValue><font color='<%=mfcolor%>'><%=rs1.getString(3)%></font></td> 
                
               	</tr>
		   <%
              
              }
      
%>
</table>
<%
   }
   catch(Exception e)
     {
     e.printStackTrace();
     } 

%><br>
<table width="30%" align=center>
<tr><td class=rptValue nowrap colspan=4><font color="red">&nbsp;Note&nbsp;:&nbsp;&nbsp;</font>Click on the Message to View Details of the Message.<br><br></td></tr>
<tr><td width="5%" bgcolor="Red" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;High priority&nbsp;&nbsp;&nbsp;</td><td width="5%" bgcolor="Orange" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Medium priority</td></tr>
<tr><td width="5%" bgcolor="green" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Low priority&nbsp;&nbsp;&nbsp;</td><td width="5%" bgcolor="lightgray" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Already Read Meassages</td></tr>

</table>
</form>
</body>


