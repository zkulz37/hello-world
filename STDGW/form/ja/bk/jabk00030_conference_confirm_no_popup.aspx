<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Popup Confirm No</title>
    <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	Bingding();
	OnSearch();
}

function Bingding()
{	var data;
	data ="data|10|CONFIRMED|20|TENTATIVE|30|CANCEL|40|WAITING"  
    lstSearchStatus.SetDataText(data);

	OnSearch();
}
function OnGetRoom()
{
	var ctrl = grdRoom.GetGridControl();
	var rtn_value = new Array();
	var index = 0;

	if (grdRoom.row > 0)
	{
		for(j = 0; j < grdRoom.cols -1; j++)
		{
			rtn_value[index] = grdRoom.GetGridData(grdRoom.row, j );
			index ++;
		}
		
		window.returnValue = rtn_value; 
		this.close();
	}
}

function OnSearch()
{
	dsoRoom.Call("SELECT");
}
function OnDataReceive(obj)
{
	if(obj.id=='dsoRoom')
	{
		
	}
}
</script>

</head>
<body>
    <!----------------------------------------------------------------------->
    <gw:data id="dsoRoom" onreceive="OnDataReceive(this)">
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_jabk00030_conference" >
                <input  bind="grdRoom">
                    <input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="txtRSV_GuestName" />
					</input> 
                <output bind="grdRoom" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">Date</td>
                        <td style="width:20%; white-space: nowrap">
							 <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
							~ 
							<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>						
						<td style="width: 10%; white-space: nowrap" align='right'>RSV#</td>
						<td style="width: 20%; white-space: nowrap">
							<gw:textbox id="txtRSV_GuestName" onenterkey="OnSearch()" />
						</td>
						<td style="width: 10%; white-space: nowrap">
							Status
						</td>
						<td style="width: 20%; white-space: nowrap">
							<gw:list id="lstSearchStatus"   onchange="OnSearch()" styles="display: none" />
						</td>
						<td style="width: 10%; white-space: nowrap">
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdRoom' header="_pk|Book Date|Room No|Slip#|Customer Name|Time From|Time To|Conference Name"
                                format="0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|0|0" defaults="|||||||" editcol="0|0|0|0|0|0|0|0"
								autosize="true"
                                widths="1000|1000|1000|1000|1000|1000|1000|1000" styles="width:100%;height:100%"  oncelldblclick="OnGetRoom()" />
            </td> 
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
