<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Night Audit Process</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
function BodyInit()
{
	txtProcessResult.SetReadOnly(true);
	OnSearch();
	
}
function OnSearch()
{
dat_sel_htfo00220.Call();
}
function OnProcess()
{
    if (confirm("Do you want to close date "+ dtFrom.value +" ???.\nAre you sure clear all check-in and check-out guest?"))
		{
			dat_confirm.Call();			
		}
}
function OnUnClose(){
	if (confirm("Do you want to close date "+ dtFrom.value +" ???"))
		{
			//dat_confirm.Call();			
			alert("You have not previlledge to unclose this date.");
		}
}
function OnDataReceive(obj)
{
    if(obj.id == 'dat_confirm')
    {
        alert(txt_rtn_msg.text);
        dat_sel_htfo00220.Call();
    }
}
</script>

<body>
    <gw:data id="dat_sel_htfo00220"> 
        <xml>
            <dso  type="process"  procedure="crm.sp_sel_process_htfo00220"  > 
                <input>
                    <input bind="dtFrom" />
                </input> 
                <output>
                    <output bind="lblLastRun" />
                    <output bind="lblStatus" />
                    <output bind="txtProcessResult" />
                </output>
            </dso> 
        </xml> 
   </gw:data>
   <gw:data id="dat_confirm" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="CRM.sp_pro_night_audit" > 
                <input>
                    <input bind="dtFrom" />
                </input> 
                <output>
                    <output bind="txt_rtn_msg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr style="width: 100%; height: 1%">
            <td style="width: 100%; background: white" valign="top">
                <table style="width: 100%" border="0">
                    <tr>
                        <td style="width: 10%">
                            Last Run :</td>
                        <td style="width: 30%">
                            <gw:label id="lblLastRun" styles="color: blue"></gw:label>
                        </td>
                        <td style="width: 7%">
                            Sucess :</td>
                        <td style="width: 20%">
                            <gw:label id="lblStatus" styles="color: blue"></gw:label>
                        </td>
						<td align="right" style="width: 7%; white-space: nowrap">
                             Date
                        </td>
                        <td style="width: 8%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch();"/>
                        </td>
						<td style="width: 8%">
							<gw:icon id="btnProcess" text="UnClose" onclick="OnUnClose()" />
						 </td>
                        <td style="width: 3%">
                            <gw:icon id="btnProcess" text="Process" onclick="OnProcess()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 30%; background: white">
            <td style="width: 100%; background: white" valign="top">
            <fieldset><legend >Process Result</legend>
                <table style="width: 100%" border="0">
                    <tr>
                        <td style="width: 100%">
                            <gw:textarea id="txtProcessResult" rows="31" styles="width:100%" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtnotParamater" styles="display: none" />
<gw:textbox id="txtnotParamater2" styles="display: none" />
<gw:textbox id="txt_rtn_msg" styles="display: none" />
<!--------------------------------------------------------------------------------------->
</html>
