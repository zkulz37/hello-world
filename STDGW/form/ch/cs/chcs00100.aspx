<!-- #include file="../../../system/lib/form.inc" -->
<%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Untitled Page</title>
</head>

<script>
function BodyInit()
{
    datView_sal.Call("SELECT");
	
}



</script>

<body>

<gw:data id="datView_sal" onreceive="" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="hr.sp_sel_sal_acc" procedure=""> 
                <input bind="idGridView" >
                </input>
                <output  bind="idGridView" />
            </dso> 
        </xml> 
</gw:data>

<table style="height:100%" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr >
    <td width="100%" colspan="3" >
        <table style="height:100%" width="100%" border="1" cellspacing="0" cellpadding="0">
            <tr style="height:100%">
                <td width="100%" style="height:100%" > 
                    <gw:grid 
					id="idGridView"
					header="Code|Name|Item"
					format="0|0|0"
					aligns="1|0|0"
					defaults="||"
					editcol="0|1|0"
					widths="2000|4000|8000"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit=""
					oncellclick = ""
					oncelldblclick = ""/>
                </td>
            </tr>
        </table>
	</td>
  </tr>
</table>
</body>

<gw:textbox id="txtQuery" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtCountView" styles="display:none"/>
<gw:textbox id="txtGridView" styles="display:none"/>

</html>
