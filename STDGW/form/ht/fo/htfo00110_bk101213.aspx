<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Status</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>

function BodyInit()
{
	var data = '';
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE = 'RTYPE'")%>"; 
	data = data + '|ALL|Select All';
	lstRoomType.SetDataText(data);
	lstRoomType.value = 'ALL';
	OnSearch();
}

function OnSearch()
{
	data_htfo00110.Call("SELECT");
}

function OnDataReceive()
{
	if (grdData.rows > 1)
	{
	    grdData.GetGridControl().FrozenCols = 2;
		for (row = 1; row < grdData.rows; row ++ )
		{
			for (col = 2; col < grdData.cols-1; col++ )
			{
				data = grdData.GetGridData(row, col);

				switch(data)
				{
					case 'IN':         
						grdData.SetCellBgColor(row, col, row, col,0XEE82EE);
						grdData.SetGridText(row, col, '');
					break;
					case 'RE':
						grdData.SetCellBgColor(row, col, row, col, 0xB3B3D7);
						grdData.SetGridText(row, col, '');
					break;
					case 'GU':
						grdData.SetCellBgColor(row, col, row, col, 0x336633);
						grdData.SetGridText(row, col, '');
					break;
					case 'OOO':
						grdData.SetCellBgColor(row, col, row, col, 0x0000CE);
						grdData.SetGridText(row, col, '');
					break;
				}
			}
		}
	}
}
function OnShowDetail()
{
    //alert(grdData.col);
    var Tmp_dd= grdData.col-1;
    var dd;
    if(Number(Tmp_dd) < 10)
    {
        dd= "0"+""+Tmp_dd;
    }
    else
    {
        dd=Tmp_dd;
    }
    var yyyymm = dtMonth.GetData();
    var date= yyyymm+dd;
    var room_pk=grdData.GetGridData(grdData.row, 33);//room pk
    var color=grdData.GetCellBgColor(grdData.row, grdData.col, grdData.row, grdData.col);
    if(color != 0)
    {
		if(color == '206')
		{
			return false;
		}
        var path = System.RootURL + "/form/ht/fo/htfo00110_popup.aspx?p_room_pk="+room_pk+"&p_date="+date+"&p_color="+color+"";
            var object = System.OpenModal( path ,630 , 350 ,  'resizable:yes;status:yes');
    }
    else
    {
        alert("room empty");
    }
}
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00110" onreceive="OnDataReceive(this)">
        <xml>
           <dso  type="grid"  function="crm.sp_sel_htfo00110" >
                <input  bind="grdData">
                    <input bind="dtMonth" />
					<input bind="lstRoomType" />
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">Month</td>
                        <td style="width: 10%; white-space: nowrap">
							<gw:datebox id="dtMonth" type="month" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>						
						<td style="width: 10%; white-space: nowrap" align='right'>Room Type</td>
						<td style="width: 23%; white-space: nowrap">
							<gw:list id="lstRoomType" styles='width:100%' onchange='OnSearch()' />
						</td>
						<td style="width: 13%; white-space: nowrap">
							<gw:label id="lbCUS1"  styles="text-align: center; color: white; background-color: #ee82ee;width:100%;font-weight: bold;font-size:13" >INHOUSE 
							</gw:label>
						</td>
						<td style="width: 2%; white-space: nowrap"></td>       
						<td style="width: 15%; white-space: nowrap">
							<gw:label id="lbCUS2"  styles="text-align: center; color: white; background-color: #d7b3b3;width:100%;font-weight: bold;font-size:13" >RESERVED 
							</gw:label>
						</td>
						<td style="width: 2%; white-space: nowrap"></td>
						<td style="width: 17%; white-space: nowrap">
							<gw:label id="lbCUS3"  styles="text-align: center; color: white; background-color: #336633;width:100%;font-weight: bold;font-size:13" >GUARANTED 
							</gw:label>
						</td>
						<td style="width: 23%; white-space: nowrap">
							<gw:label id="lbCUS3"  styles="text-align: center; color: white; background-color: #CE0000;width:100%;font-weight: bold;font-size:13" >OUT OF ORDER 
							</gw:label>
						</td>
						<td style="width: 2%; white-space: nowrap"></td>
						<td style="width: 1%" >
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
						</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdData' header='Room No|Room Type|01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|_room_pk'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='|||||||||||||||||||||||||||||||| '
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%' autosize="T" oncelldblclick="OnShowDetail()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
