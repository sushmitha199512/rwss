<%@ include file="/commons/rws_header1.jsp" %>
 
<%@ page import="java.io.*,jxl.*,java.util.*,jxl.Workbook,jxl.Sheet" %>
<body>

<% 
     try
     {
      String filename = request.getParameter("file");
      String file=filename.substring(filename.lastIndexOf("\\")+1,filename.length());
      //System.out.println("file="+file);
      String temp="";
	  if(filename.indexOf("\\")>0){
       StringTokenizer st = new StringTokenizer(filename, "\\", true);
       while (st.hasMoreTokens()) {
        String w = st.nextToken();
        if (w.equals("\\")) 
            temp = temp +"\\"+"\\";
        else 
            temp = temp + w;
       }
      }
	   //System.out.println("value="+temp);
 
      WorkbookSettings ws = new WorkbookSettings();
      ws.setLocale(new Locale("en", "EN"));
      Workbook w = Workbook.getWorkbook(new File(temp),ws);
       Sheet s = w.getSheet(0);
        //System.out.println("sheet name="+s.getName());
        Cell[] row = null;
        Cell[] column = null;
        //System.out.println("no of rows="+s.getRows());
        row = s.getRow(0);
        int k=0;
        %>
        <font color="#8A9FCD" class="bwborder" ><B>Uploaded File:</B><%=file %><br>
        <table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="black"  style="border-collapse:collapse;display:block">
		<thead class="gridLabel">
		<tr bgcolor="#079dd9" bordercolor="black"> 
		<% 
        if (row.length > 0)
        {
            for (int j = 0; j < row.length; j++)
            {  
               if(!row[j].getContents().trim().equals("")){
               k=k+1;
         %>      
        <td><font color="white"><b><%=row[j].getContents()%></b></font></td>
        <%}}} %>
        </tr>
        </thead>
        <tbody class="label"  >
        
        <%
          //System.out.println("col len="+k);
        for (int i = 1 ; i < s.getRows() ; i++)
        {
          row = s.getRow(i);
          
          if (row.length > 0)
          { %>
            <tr>             
         <%
            for (int j = 0; j <k; j++)
            {
              if(!row[j].getContents().trim().equals(""))
           %>
              <td><%=row[j].getContents()%></td>
              <% 
              
            }
           } 
         }
      
    }
    catch (UnsupportedEncodingException e)
    {
      //System.err.println(e.toString());
    }
    catch (IOException e)
    {
      //System.err.println(e.toString());
    }
    catch (Exception e)
    {
      //System.err.println(e.toString());
    }
   
 %>
 </tbody>
 </table>

<%@ include file="/commons/rws_alert.jsp"%>

