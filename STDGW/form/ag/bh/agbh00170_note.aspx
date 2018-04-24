<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Help</title>
</head>
<script>

function BodyInit()
{ 	
    System.Translate(document); 
    var sresponse;
    sresponse="Note:" +
              "\n1.Title:   Please add <c> tag to begin and </c> to close coding to display system date" + 
	          "\n   Exp. " +
	          "\n       <c>to_char(sysdate,'mm/yyyy')</c>" +
	          "\n"+
              "\n2.Content: Please add <c> tag to begin and </c> to close coding to display system date" +
	          "\n   Exp. " + 
		      "\n       <c>to_char(sysdate,'mm/yyyy')</c>"   +
		      "\n"+
              "\n3. At time:" + 
              "\n   + Date   : announcement will display at (day of system date if is null)"+
	          "\n   + Month : announcement will display at (month of system date if is null)"+
              "\n   + Year   : announcement will display at (year of system date if is null) "+
              "\n   + Every day	: announcement will display every day" +
              "\n"+
              "\n4.SQL:     Please add SQL statement to display data following information of announcement (can null) "+
              "\n"+
              "\n5.Columns: Columns of data grid, combining with SQL ( is null if SQL is null) " +
              "\n"+
              "\n6.Cycle: Announcement will repeat with cycle (day,month,year) or not repeat " +
              "\n"+
              "\n7.Times: times will repeat    " +
              "\n"+
              "\n8.URL: link form to user manage information of announcement	" +
              "\n"+
              "\n9.Search Key: Option to search data	"
    txtaResponse.SetDataText(sresponse);
}

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->

<!--------------table------------------------------->
<table  align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr style="height:100%"> 
	    <td  align = top style="height:100%">
		    <table align="top" border="0" cellpadding="0" cellspacing="0" style="height: 100%"
                width="100%">
		        <tr>
		            <td height="95%" colspan=2 align="Left" >
				        <gw:textarea id="txtaResponse" styles="width:100%;height:100%;font-size:15"  />
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	
  
    
</table>


</body>
</html>

				
