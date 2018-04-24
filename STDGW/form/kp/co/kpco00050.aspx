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
        <tr style="height: 1%; width: 100%">
            <td>
                <fieldset style="width: 100%; padding: 0">
                    <table style="width: 100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="right" width="10%">
                                <a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('Project')">
                                    Project&nbsp;</a></td>
                            <td width="50%">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
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
                                    </tr>
                                </table>
                            </td>
                            <td width="15%" style="white-space: nowrap" align="right">
                                Budget Period
                            </td>
                            <td style="width: 15%; white-space: nowrap">
                                <gw:datebox id="dtFrom" lang='1' />
                                ~<gw:datebox id="dtTo" lang='1' />
                            </td>
                            <td style="width: 30%">
                            </td>
                            <td>
                                <gw:imgbtn id="bt2" img="search" alt="Search" onclick="OnSearch()" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 99%; width: 100%">
            <td width="100%">
                <gw:grid id='grdTest' header='Seq|Budget No|Budget Type|Approved Date|Main Contract Amount|Budget Amount|Gross Margin|Gross Margin Ratio'
                    format='0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0' check='|||||||' editcol='1|1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
</body>
</html>
