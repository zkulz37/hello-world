<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Response</title>
</head>
<script>

function BodyInit()
{ 	
    var callerWindowObj = dialogArguments;
   var irow="<%=Request["p_row"]%>";
   var icol="<%=Request["p_col"]%>";
   var igrid=callerWindowObj.igrid
   if (igrid==1)
        sresponse=callerWindowObj.grdVisitor.GetGridData(irow,icol);
    else
        sresponse=callerWindowObj.grdVisAppointment.GetGridData(irow,icol);
    txtaResponse.SetDataText(sresponse);
}
function OnSave()
{
    window.returnValue = txtaResponse.GetData(); 
	this.close();
}
function OnExit()
{
	window.returnValue = null; 
	this.close();
}
function DecodeString(utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
 
		while ( i < utftext.length ) 
		{
 
			c = utftext.charCodeAt(i);
 
			if (c < 128) 
			{
				string += String.fromCharCode(c);
				i++;
			}
			else if((c > 191) && (c < 224)) 
			{
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else 
			{
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
 
		}
 
		return string;
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
		        <tr >
		            <td height="5%" align="right" width="90%">
				        <gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnSave()" />
			        </td>
			        <td align="right" width="10%">
				        <gw:imgBtn id="ibtnExit" alt="Exit" img="cancel" text="Exit" onclick="OnExit()" />
			        </td>
		        </tr>
		        <tr  >
		            <td height="95%" colspan=2 align="Left" >
				        <gw:textarea id="txtaResponse" styles="width:100%;height: 100%"  />
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	
  
    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="idInterval"/>

</body>
</html>

				
