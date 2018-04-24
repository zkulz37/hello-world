<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>House Sales Reservation</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
//===============================================================

var COL_PK							= 0,
	COL_TYPE						= 1,
	COL_BUILDING					= 2,
	COL_AREA						= 3,
	COL_FLOOR						= 4,
	COL_HOUSE_NO					= 5,
	COL_USING_AREA					= 6,
	COL_LIVING_AREA					= 7,
	COL_SUPPLYING_AREA				= 8,
	COL_PARKING_AREA				= 9,
	COL_SITE_AREA					= 10,
	COL_OFFICIAL_AREA				= 11,
	COL_OTHER_AREA					= 12,
	COL_TOTAL_AREA					= 13,
	COL_VAT_RATE					= 14,
	COL_DESCRIPTION					= 15,
	COL_THS_UNITTYPE_SCALE_HOUSE_PK	= 16,
	COL_THS_RESERVATION_PK			= 17;

var flag_select = false;
var flag_update = false;

function BodyInit()
{
	OnNew(1);
	txtSlipNo.SetReadOnly(true);
	txtCustomer.SetReadOnly(true);
	BindingDataList();
	OnSearch(1);
}

function BindingDataList()
{ 	
	var data = '';
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE='CCY'" )%>"; 
	lstCCY.SetDataText(data);
	lstCCY.value = 'CCY-USD';

}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_rehs00010_main_list.Call('SELECT');
		break;
	}
}

function OnClick(obj)
{
	switch(obj)
	{
		case 'OnToggle':
			var left  = document.all("left");    
			var right = document.all("right");   
			var imgArrow = document.all("imgArrow");

			if(imgArrow.status == "expand")
			{
				left.style.display="none";       
				imgArrow.status = "collapse";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/next_orange.gif";
			}
			else
			{
				left.style.display="";
				imgArrow.status = "expand";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/prev_orange.gif";
			}		
		break;
		case 'MST':
			THS_RESERVATION_PK.text = grdData.GetGridData(grdData.row, 0);
			flag_select = true;
			flag_update = false;
			dso_rehs00010_mst.Call('SELECT');
		break;
	}
}

function OnPopUp(n)
{
	switch(n)
	{
		case 1:
			 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	         
	            TCO_BUSPARTNER_PK.text   = object[0];
                txtCustomer.text		 = object[2];                              
	         }
		break;
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:
			dso_rehs00010_mst.StatusInsert();
			grdDataDTL.ClearData();
		break;
		case 2:
			var path = System.RootURL + "/form/re/hs/rehs00010_popup.aspx?";
			var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
			var temp;

			if ( object != null )
			{
				for(i = 0; i < object.length; i++)
				{
					temp = object[i];
					grdDataDTL.AddRow();
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_UNITTYPE_SCALE_HOUSE_PK	, temp[0]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TYPE							, temp[1]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_BUILDING						, temp[2]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_AREA							, temp[3]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_FLOOR							, temp[4]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_HOUSE_NO						, temp[5]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_USING_AREA					, temp[6]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_LIVING_AREA					, temp[7]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SUPPLYING_AREA				, temp[8]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_PARKING_AREA					, temp[9]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SITE_AREA						, temp[10]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OFFICIAL_AREA					, temp[11]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OTHER_AREA					, temp[12]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TOTAL_AREA					, temp[13]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_VAT_RATE						, temp[14]);
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_RESERVATION_PK			, THS_RESERVATION_PK.text);
				}
			}
		break;
	}
}

function OnDelete(n)
{
	switch(n)
	{
		case 1:
			if (THS_RESERVATION_PK.text != '')
			{
				if (confirm('Are you sure delete data ?'))
				{
					dso_rehs00010_mst.StatusDelete();
					flag_update = true;
					flag_select = false;
					dso_rehs00010_mst.Call();
				}
			}
		break;
		case 2:
			if (grdDataDTL.row > 0)
			{
				for (row = 1; row < grdDataDTL.rows; row++ )
				{
					if (grdDataDTL.GetGridControl().isSelected(row) == true)
					{
						if (grdDataDTL.GetGridData(row, COL_PK) == '')
						{
							grdDataDTL.RemoveRowAt(row);
						}
						else
						{
							grdDataDTL.DeleteRowAt(row);
						}
					}
				}
			}
		break;
	}
}

function OnSave()
{
	if (txtCustomer.text == '')
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		txtCustomer.GetControl().focus();
		return;
	}

	if (txtAMT.text == '' || txtAMT.text == '0' )
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		txtAMT.GetControl().focus();
		return;
	}

	flag_update = true;
	dso_rehs00010_mst.Call();
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_rehs00010_mst':
			if (flag_select == true)
			{
				if (THS_RESERVATION_PK.text != '')
				{
					flag_select = false;					
					grdDataDTL.ClearData();
					dso_rehs00010_dtl.Call('SELECT');
				}
			}			
			
			if (flag_update == true )
			{
				if (grdDataDTL.rows > 1)
				{
					for (row = 1; row < grdDataDTL.rows; row++ )
					{
						if (grdDataDTL.GetGridData(row, COL_THS_RESERVATION_PK) == '')
						{
							grdDataDTL.SetGridText(row, COL_THS_RESERVATION_PK, THS_RESERVATION_PK.text );
						}
					}
					dso_rehs00010_dtl.Call();				
				}
				else
				{
					dso_rehs00010_main_list.Call('SELECT');					
				}
			}
		break;
		case 'dso_rehs00010_dtl':
			if (flag_update == true)
			{
				flag_update = false;
				dso_rehs00010_main_list.Call('SELECT');
			}
		break;
	}
}
</script>
<body>

<gw:data id="dso_rehs00010_main_list"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00010_LST">
			<input bind="grdData">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtSearch" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

<gw:data id="dso_rehs00010_mst" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="control" parameter="0,2,4,5,6,7" function="CRM.SP_SEL_REHS00010_MAIN" procedure="CRM.SP_UPD_REHS00010_MAIN"> 
			<inout>
				<inout bind="THS_RESERVATION_PK" />
				<inout bind="txtSlipNo" />
				<inout bind="TCO_BUSPARTNER_PK" />
				<inout bind="txtCustomer" />
				<inout bind="dtDate" />
				<inout bind="lstCCY" />
				<inout bind="txtAMT"/>
				<inout bind="txtDes"/>
			</inout>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_rehs00010_dtl" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="0,15,16,17" function="CRM.SP_SEL_REHS00010_DTL" procedure="CRM.SP_UPD_REHS00010_DTL"> 
			<input bind="grdDataDTL">
				<input bind="THS_RESERVATION_PK" />
			</input> 
			<output bind="grdDataDTL" /> 
		</dso> 
	</xml> 
</gw:data>

    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr style="height: 100%; width: 100%;">
            <td style="width: 10%; background: white" align="center" id="left">
                <table style="height: 100%; width:100%" border="0">
                    <tr>
                        <td style="width: 25%">
                            <b>&nbsp;&nbsp;&nbsp;&nbsp;Date</b>
                        </td>
                        <td colspan="2" style="width: 75%">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtTo" lang="1" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 25%" nowrap>
                            &nbsp;&nbsp;&nbsp;&nbsp;Slip No.</td>
                        <td style="width: 70%">
                            <gw:textbox id="txtSearch" styles="width: 100%" onenterkey="OnSearch(1)" />
                        </td>
						<td style="width: 5%">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)"/>							
						</td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id="grdData" 
							header="_PK|Slip No|Create Date|Description" 
							format="0|0|0|0" 
							aligns="0|0|0|0"
							defaults="|||" 
							editcol="0|0|0|0" 
							widths="0|2000|2000|1500" 
							styles="width:100%;height:100%" 
							autosize='T'
							oncellclick="OnClick('MST')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:90%; background: white" align="center" id="right">
              <table valign='top' style="height: 100%; width: 100%" border="0">
				<tr style="height: 5%">
					<td style="width: 10%">Slip No</td>
					<td style="width: 25%">
						<gw:textbox id="txtSlipNo" styles="width: 100%" csstype="mandatory"/>
					</td>
					<td style="width: 10%" align="right">Date</td>
					<td style="width: 15%" nowrap>
						<gw:datebox id="dtDate" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right">CCY</td>
					<td style="width: 20%" nowrap> 
						<gw:list id="lstCCY" text="" styles='width:100%'/>
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 88%"></td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="excel" alt="Print" text="Print" id="btnReport" onclick="OnPrint()"/>
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="new" alt="New" id="btnAddNew1" onclick="OnNew(1)" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete(1)" />
								</td>
								<td style="width: 3%" align="right">
									<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>				
				<tr style="height: 5%">
					<td style="width: 15%" nowrap><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">Customer</b></td>
					<td colspan='3' style="width: 45%">
						<gw:textbox id="txtCustomer" styles="width: 100%" csstype="mandatory" check='1'/>
					</td>
					<td style="width: 10%" align="right" nowrap>Deposit AMT</td>
					<td style="width: 20%">
						<gw:textbox id="txtAMT" check="1" type="number" format="###,###,###" styles="width: 100%"/>
					</td>
					<td style="width: 10%" nowrap >
					</td>
				</tr>
				<tr style="height: 5%">
					<td style="width: 15%">Description</td>
					<td colspan="5" style="width: 75%">
						<gw:textbox id="txtDes" styles="width: 100%"/>
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 98%"></td>
								<td style="width: 1%">
									<gw:imgbtn img="new" alt="New" id="btnAddNew2" onclick="OnNew(2)" />
								</td>
								<td style="width: 1%">
									<gw:imgbtn img="delete" alt="Delete" id="btnDelete2" onclick="OnDelete(2)" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 85%">
                        <td colspan="7">
                            <gw:grid id="grdDataDTL" 
							header="_PK|Type|Building|Area|Floor|House No|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Area|Total Area|VAT Rate|Description|_THS_UNITTYPE_SCALE_HOUSE_PK|_THS_RESERVATION_PK" 
							format="0|0|00||0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							aligns="0|0|0|3|0|0|3|3|3|3|3|3|3|3|3|0|0|0"
							defaults="|||||||||||||||||"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0"
							styles="width:100%;height:100%" 
							autosize='T'
							debug="false"/>
                        </td>
                    </tr>
              </table> 
            </td>
        </tr>
    </table>	
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnClick('OnToggle')" />
</body>
<!--------------------------------------------------------------------------------------->
<gw:textbox id="TCO_BUSPARTNER_PK" styles="width: 100%; display:none"/>
<gw:textbox id="THS_RESERVATION_PK" text="" styles="width: 100%; display:none"/>
</html>
