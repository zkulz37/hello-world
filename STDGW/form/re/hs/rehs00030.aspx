<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Contract Cancel</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
//===============================================================

var COL_SELECT			= 0,
	COL_PK				= 1,
	COL_CONTRACT_NO		= 2,
	COL_CONTRACT_DATE	= 3,
	COL_CUSTOMER		= 4,
	COL_PAYMENT_METHOD	= 5,
	COL_DESCRIPTION		= 6,
	COL_CANCEL_REASON	= 7;

function BodyInit()
{
	
}

function BindingDataList()
{ 	

}

function OnSearch()
{
	dso_rehs00030.Call('SELECT');
}

function OnCancel()
{
	for (row = 1; row < grdData.rows; row++)
	{
		if (grdData.GetGridData(row, COL_SELECT) == '-1')
		{
			if (grdData.GetGridData(row, COL_CANCEL_REASON) == '')
			{
				alert('You must input cancel reason at row : ' + row);
				return;
			}
		}
	}
}

function OnCheck()
{
	if (event.col == COL_CANCEL_REASON)
	{
		if (grdData.GetGridData(row, COL_SELECT) != '-1')
		{
			grdData.rows = -1;
		}
	}
}
</script>
<body>

<gw:data id="dso_rehs00030"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00030" procedure="CRM.SP_UPD_REHS00030">
			<input bind="grdData">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtContNo" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr style="height: 100%; width: 100%;">
            <td style="width: 100%; background: white">
                <table style="height: 100%; width:100%" border="0">
                    <tr>
                        <td style="width: 15%" align='right' nowrap><b>Contract Date</b></td>
                        <td style="width: 25%">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtTo" lang="1" styles="width:100%" />
                        </td>
						<td style="width: 10%" align='right' nowrap>Contract No.</td>
                        <td style="width: 25%">
                            <gw:textbox id="txtContNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
						<td style="width: 24%" align='right' nowrap>
							<gw:label id="lblRecord" styles="color: blue; width: 100%">0 record(s)
							</gw:label>
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()"/>
						</td>
						<td style="width: 1%">
							<gw:icon id="idBtnClose" img="2" text="Cancel Contract" alt="Info Contract" styles='width:100%' onclick="OnCancel()()" />
						</td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="7">
                            <gw:grid id="grdData"
							header="Select|_PK|Contract No|Contract Date|Customer|Payment Method|Description|Cancel Reason" 
							format="3|0|0|0|0|0|0|0" 
							aligns="0|0|0|0|0|0|0|0"
							defaults="||||||||" 
							editcol="1|0|0|0|0|0|0|1" 
							widths="0|2000|2000|1500|0|0|0|0" 
							styles="width:100%;height:100%" 
							autosize='T'
							oncellclick='OnCheck()'/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
