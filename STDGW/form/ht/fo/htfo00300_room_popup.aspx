<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>vina genuwin</title>
    <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	Bingding();
	//HideShowColumn();
	OnSearch();
}
function OnSearch()
{
	dsoRoom.Call("SELECT");
}
function Bingding()
{
	var data = '';
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE = 'RTYPE'")%>"; 
	data = data + '|ALL|Select All';
	lstRoomType.SetDataText(data);
	lstRoomType.value = 'ALL';
	//dtDate.SetDataText(System.AddMonth(dtDate.GetData(),1));

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
</script>

</head>
<body>
    <!----------------------------------------------------------------------->
    <gw:data id="dsoRoom" onreceive="">
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00300_room_popup" >
                <input  bind="grdRoom">
					<input bind="lstRoomType" />
					<input bind="txtRoom" />
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
                        <td style="width: 5%; white-space: nowrap" align="right"></td>
                        <td style="width: 8%; white-space: nowrap">
							
                        </td>	
						
						<td style="width: 5%; white-space: nowrap" align='right'>Room Type</td>
						<td style="width: 21%; white-space: nowrap">
							<gw:list id="lstRoomType" styles='width:100%' onchange='OnSearch()' />
						</td>
						<td style="width: 5%; white-space: nowrap" align="right">Room</td>
                        <td style="width: 8%; white-space: nowrap">
							 <gw:textbox id="txtRoom" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>	
						<td style="width: 10%; white-space: nowrap">
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
           <td>
                <gw:grid id='grdRoom' header='RM|Type|RM Status'
                    format='0|0|0' 
					aligns='0|0|0'
					editcol='0|0|0'
			        widths='0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick='OnGetRoom();' />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
