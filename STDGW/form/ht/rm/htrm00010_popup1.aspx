<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Status Daily Report</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
 function BodyInit()
 {
	dtDate.value = "<%=Request.QueryString("d")%>" ;
    txtType.text  = "<%=Request.QueryString("type")%>" ;

	dtDate.SetEnable(false);
	
   dsoDetail.Call("SELECT");
 }
//=========================================================================
 function OnDataReceive(dso){
		if(grdDetail.rows > 1){
			lblTotalRoom.text = grdDetail.GetGridData(1,5);
			lblNARooms.text = grdDetail.rows-1;
			lblAVRooms.text = Number(lblTotalRoom.text)-Number(lblNARooms.text);
		}
 }
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="dsoDetail" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="crm.sp_sel_htrm00010_popup1" >
                <input  bind="grdDetail">
                    <input bind="dtDate" />
					<input bind="txtType" />
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
					    <td align="right" style="width:5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width:10%; white-space: nowrap">
                            <gw:datebox id="dtDate" lang="1" />
                        </td>
                        <td align="right" style="width:15%; white-space: nowrap">
                            Total rooms:
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            <gw:label id="lblTotalRoom"/>
                        </td>
                        <td align="right" style="width:15%; white-space: nowrap">
                            N/A Rooms:
                        </td>
                        <td style="width:5%; white-space: nowrap">
                            <gw:label id="lblNARooms"/>
                        </td>
						<td align="right" style="width:15%; white-space: nowrap">
                            Available Rooms:
                        </td>
                        <td style="width:5%; white-space: nowrap">
                            <gw:label id="lblAVRooms"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan=8>
                <gw:grid id='grdDetail' 
				    header='Last Name|First Name|Arrival|Departure|RSV#/RM#|_Total_Room'
                    format='0|0|0|0|0|0'
                    sorting='T' styles='width:100%; height:100%'
                    autosize="T" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtType" styles="display: none" />
</body>

</html>
