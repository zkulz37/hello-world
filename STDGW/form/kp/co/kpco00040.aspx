<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Project</title>
</head>
<%  ESysLib.SetUser("EC111")%>

<script>
function BodyInit()
{
        System.Translate(document);

}  
//============================================================================================

//============================================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
				case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
									dso_version.Call();
                            } 
                break;
		}
}
</script>

<body>
    <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 1%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" width="1%">
                            <a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('Project')">
                                Project&nbsp;</a>
                        </td>
                        <td width="40%">
                            <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                        </td>
                        <td width="60%">
                            <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                        </td>
                        <td width="">
                            <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                        </td>
                        <td>
                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibSearch" img="search" alt="Search" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td style="width: 20%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <gw:textbox id="1" styles='width:100%' text="Notice     2/11/2010" csstype="mandatory" readonly="true" />
                        </td>
                    </tr>
                    <tr style="height: 20%">
                        <td style="width: 100%">
                            <gw:textarea id="2" styles='width:100%;height:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <gw:textbox id="3" styles='width:100%' text="Project Summary" csstype="mandatory" readonly="true"/>
                        </td>
                    </tr>
                    <tr style="height: 68%">
                        <td style="width: 100%">
                            <gw:textarea id="4" styles='width:100%;height:50%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <gw:textbox id="6" styles='width:100%' text="Project Progress Status" csstype="mandatory" readonly="true"/>
                        </td>
                    </tr>
                    <tr style="height: 22%">
                        <td style="width: 100%">
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 20%">
                                        Progress Rate
                                    </td>
                                    <td style="width: 80%">
                                        <gw:textbox id="txtProgressRate" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 20%">
                                        Plan
                                    </td>
                                    <td style="width: 80%">
                                        <gw:textbox id="txtPlan" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 20%">
                                        Result
                                    </td>
                                    <td style="width: 80%">
                                        <gw:textbox id="txtResult" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <gw:textbox id="6" styles='width:100%' text="Daily Plan & Result" csstype="mandatory" readonly="true"/>
                        </td>
                    </tr>
                    <tr style="height: 30%">
                        <td style="width: 100%">
                            <gw:grid id='grdTest' header='Today`s Plan|Last Day`s Result' format='0|0' aligns='0|0'
                                check='|' editcol='1|1' widths='1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 100%">
                            <gw:textbox id="6" styles='width:100%' text="Resource Input" csstype="mandatory" readonly="true"/>
                        </td>
                    </tr>
                    <tr style="height: 45%">
                        <td style="width: 100%">
                            <gw:grid id='grdTest1' header='Job|Korean |Vienamses' format='0|0|0|' aligns='0|0|0'
                                check='||' editcol='1|1|1' widths='1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 50%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            Main Contract Amount
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtMainContAmt" styles='width:100%' />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Budget Amount
                        </td>
                        <td style="width: 10%">
                            <gw:textbox id="txtBudgetAmt" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 50%">
                        <td colspan="4" style="width: 100%">
                            <fieldset style="padding: 2; width: 100%; height: 99%">
                                <legend><font size="2"><b><i>Status of Fund and Profit/Loss (unit: USD)</i></b></font></legend>
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 100%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdTest2' header='Type|Plan |Result|Difference|Plan|Result|Difference'
                                                format='0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0' check='||||||' editcol='1|1|1|1|1|1|1'
                                                widths='1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 25%">
                        <td colspan="4" style="width: 100%">
                            <fieldset style="padding: 2; width: 100%; height: 99%">
                                <legend><font size="2"><b><i>Subcontract Status</i></b></font></legend>
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 100%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdTest3' header='Total of Planned Subcontract|Signed Subcontract |Budget for Suncontract|Subcontract Amount|Unsigned Subcontract'
                                                format='0|0|0|0|0' aligns='0|0|0|0|0' check='||||' editcol='1|1|1|1|1' widths='1000|1000|1000|1000|1000'
                                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 25%">
                        <td colspan="4" style="width: 100%">
                            <fieldset style="padding: 2; width: 100%; height: 99%">
                                <legend><font size="2"><b><i>Subcontract Progress</i></b></font></legend>
                                <table style="width: 100%; height: 100%">
                                    <tr style="height: 100%">
                                        <td style="width: 100%">
                                            <gw:grid id='grdTest4' header='Total Amount|Last Progress|Cumulated Progress' format='0|0|0'
                                                aligns='0|0|0' check='||' editcol='1|1|1' widths='1000|1000|1000' sorting='T'
                                                autosize='T' styles='width:100%; height:100%' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
