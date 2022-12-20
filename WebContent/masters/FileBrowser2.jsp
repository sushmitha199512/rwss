<%System.out.println("innnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn:"+request.getRealPath(""));%>
<%@ include file="/commons/rws_header1.jsp"%>
<script>
function fnNext(path)
{
	document.forms[0].action="FileBrowser2.jsp";
	alert(path);
	document.forms[0].path.value=path;
	document.forms[0].submit();
}
function fnSave(path,actPath)
{
	alert(path);
	alert(actPath);
	 var url = "/bank/masters/FileSave.jsp?fname="+path+"&acPath="+actPath;
	if(confirm("Are You Sure You want to Download")){
	document.forms[0].action=url;
	document.forms[0].submit();
	}
}
</script>
<style>

     html,body {
         color:#333;
         font-family: "verdana";
        
     }
     a{
         color:#FE4902;
         text-decoration:none;
     }
     a:hover{
         color:#000;
     }
    
	 .head{
         background-color:green;
         color:#FFF;
		 font-weight:bold;
      }
tr.even {
  background-color: #ddd;
}
tr.odd {
  background-color: #eee;
}
     </style>
	 <script>
$(document).ready(function(){$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
</script>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<html>
<body>
<form method="post">
<%
String DATE_FORMAT = "dd/MM/yyyy hh:mm a";
SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
String path = request.getParameter("path");
System.out.println("Path from request:"+path);
String path1 = "",fname="";
String realPath = request.getRealPath("");
String realPath2 = request.getRealPath("");
System.out.println("realPath:"+realPath);
realPath = realPath.replace("bank","pred");
System.out.println("realPath1:"+realPath);
String realPath1 = request.getRealPath("");
if(path==null || (path!=null && path.equals("")))
{
	path = realPath+"/downloads/bank";
	realPath2 = realPath2+"/downloads/bank";
}
String qa1 = path;
System.out.println("a1:"+qa1);
final StringBuffer resultq = new StringBuffer();
final StringCharacterIterator iteratorq = new StringCharacterIterator(qa1);
char characterq =  iteratorq.current();
while (characterq != CharacterIterator.DONE ){
 if (characterq == '\\' || characterq == '/') {
	 resultq.append("@");
  }
   else {
	resultq.append(characterq);
  }
  characterq = iteratorq.next();
}
String qa2 = resultq.toString();

System.out.println("a2:"+qa2);
String[] valuees = qa2.split("@");
System.out.println(valuees.length);
String actPath1 = realPath+"/downloads/bank",print="";
for(int i1=8;i1<valuees.length;i1++)
	{
		actPath1 += "/"+valuees[i1];
		print += "<a href=# onclick=fnNext('"+actPath1+"')>"+valuees[i1]+"</a> > ";
	System.out.println(valuees[i1]);
	}
	System.out.println("Print:"+print);

%>
<font face="verdana" size="2" color="magenta">
<%if(print!=null && !print.equals("")){ %>
	You are Here: <%=print%>
<br/><%}%>
</font>
<font face="verdana" size="2" color="magenta">
</font>
<br/><br>
<table border="0" width="988" class="striped">
<tr align="center">
	<td class="head">Name</td>
	<td class="head">Type</td>
	<td class="head">No Of Files/<BR>Size</td>
	<td class="head">Creation Time</td>
	<td class="head">Modified Time</td>
</tr>
<%
File f1 = new File(path);
File[] contents = f1.listFiles();
for (int j=0; j<contents.length; j++) 
	{     
				path1 = path+"/"+contents[j].getName();
				fname = path1;
String ctime = "";
		try{
		String aa = "sh /c dir "+fname+" /tc";
		Process proc = Runtime.getRuntime().exec(aa);
		BufferedReader br = new BufferedReader(new InputStreamReader(proc.getInputStream()));
		System.out.println(br);
		String data ="";
		for(int i=0; i<6; i++){data = br.readLine();}
		System.out.println("data:"+data);
		StringTokenizer st1 = new StringTokenizer(data);
		ctime = st1.nextToken()+" "+st1.nextToken()+" "+st1.nextToken();
		System.out.println("dtime:"+ctime);
		System.out.println("dtime1111:"+ctime.substring(6,10)+"/"+ctime.substring(0,2)+"/"+ctime.substring(3,5)+" "+ctime.substring(11,16));
		
		}catch(IOException e){
 
			e.printStackTrace();
 
		}

%>
			<tr>
			<%
			if(contents[j].isDirectory())
			{
			path1 = path+"/"+contents[j].getName();
			String pathValue = "<a href=# onclick=fnNext('"+path1+"')>"+contents[j].getName()+"</a>";
			File f2 = new File(path1);
			File[] contents1 = f2.listFiles();
			%>

			<td valign="top"><img src="../imagess/Folder.PNG" align="top">&nbsp;<%=pathValue%></td>
			<td class="rptValue">Directory</td>
			<td class="rptValue" style="width:90px"><%=contents1.length%></td>
			<td class="rptValue">-</td>
			<td class="rptValue">-</td>
			<%
			}    
			else    
			{
				path1 = path+"/"+contents[j].getName();
				File f2 = new File(path1);
				long byteSize = f2.length();  
				String byteSize1 = ""+byteSize;
				float  kbSize = Float.parseFloat(byteSize1) / 1024; 
				path = "<a href=# onclick=fnSave('"+path1+"','"+path+"');return false;>"+contents[j].getName()+"</a>";
				Date dd = new Date(f2.lastModified());
				%>
				<td class="rptValue"><img src="../imagess/Text.PNG" align="top">&nbsp;<%=path%></td>
				<td class="rptValue" align="center">File</td>
				<td class="rptValue" align="left" style="width:90px"><%=f2.length()%>&nbsp;Bytes</td>
				<td class="rptValue">-</td>
				<td class="rptValue"><%=sdf.format(dd)%></td>

			<%
				}
			}
			String pathValue1 = "<a href=# onclick=javascript:history.go(-1)>..Back</a>";
			System.out.println("real path2:"+realPath2);
			System.out.println("real path:"+realPath1+"/downloads/bank");
		if(!realPath2.equals(realPath1+"/downloads/bank")){
			%>
		<tr>
			<td class="rptValue"><img src="../images/up.png" align="top"><%=pathValue1%></td>
			<td class="rptValue" align="center"></td>
			<td class="rptValue" align="left" style="width:90px">&nbsp;</td>
			<td class="rptValue" align="center">&nbsp;</td>
			<td class="rptValue" align="center">&nbsp;</td>
		</tr>
<%}%>
<input type="hidden" name="path">
<input type="hidden" name="fname" value="<%=fname%>">
</table>
</form>
</body>
</html>