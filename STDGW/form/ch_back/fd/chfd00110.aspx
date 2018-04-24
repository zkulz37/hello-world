<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
function BodyInit()
{
    idGrid.AddRow();
    idGrid.AddRow();
    idGrid.AddRow();
    idGrid.AddRow();
}

</script>
<body >
<!-------------------data control----------------------->

<table style=" width:100%; height:10%" >
    <tr>
        
        <td align="center" style="font-size:medium">Beneficiary</td>
    </tr>
    <tr>
        <td style="width:10%" align="center">
        EMP ID
        </td>
        <td style="width:10%" align="center">
        <gw:textbox id="txtEMP_ID" onenterkey   ="" styles='width:100%'/>
        </td>
        <td style="width:10%" align="center">
        Name
        </td>
        <td style="width:10%" align="center">
        <gw:textbox id="txtName" onenterkey   ="" styles='width:100%'/>
        </td>
        <td style="width:10%" align="center">
        Location
        </td>
        <td style="width:10%" align="center">
        <gw:textbox id="txtLocation" onenterkey   ="" styles='width:100%'/>
        </td>
        <td style="width:10%" align="center">
        Over Sea
        </td>
        <td style="width:10%" align="center">
        <gw:textbox id="txtOver_Sea" onenterkey   ="" styles='width:100%'/>
        </td>
        
        <td style="width:10%" align="center">
        Department
        </td>
        <td style="width:10%" align="center">
        <gw:textbox id="txtDeparment" onenterkey   ="" styles='width:100%'/>
        </td>
    </tr>
</tabe>

<table style="width:100%; height:80%">
    <tr>
        <td colspan=8 align="left" style="font-size:medium">Summary of Benifit</td>
    </tr>
    <tr>
        <td colspan=8 align=right>(Unit:VND/KRW)</td>
    </tr>
    <tr>    
        <td style="width:10%"></td>
        <td style="width:10%"></td>
        <td style="width:10%"></td>
        <td style="width:10%"></td>
        <td style="width:10%"></td>
        <td  style="width:20%" align="right"><gw:label id="lblCount"  text="[Count: 3]"  styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
        <td colspan=2 style="width:30%" align="right"><gw:label id="lblCount"  text="[Amount: 1,000,000,000]" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
    </tr>
    <tr style="height:70%">
        <td colspan=8>
            <gw:grid
					    id="idGrid"
					    header="Benificiary|Date|Type|Amount|Applied Date|Appliant"
					    format="0|0|0|0|0|0"
					    aligns="1|1|1|1|1|1"
					    defaults="||||||"
					    editcol="0|0|0|0|0|0"
					    widths="2500|2000|2000|2000|2000|1500"
					    styles="width:100%;height:100%"
					    sorting="F"
					    onafteredit=""
					    oncellclick = ""
					    acceptNullDate="T"
					    oncelldblclick = ""/>
        </td>
    </tr>
    
</table>
<!----------------------------------->

</body>
</html>
