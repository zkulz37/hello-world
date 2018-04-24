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
	COL_THS_CONTRACT_PK				= 17;

var flag_select = false;
var flag_update = false;

function BodyInit()
{
	OnChangeTab(1);
	OnNew(1);
	txtContractNo.SetReadOnly(true);
	txtReservationNo.SetReadOnly(true);
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

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE='PMT'" )%>"; 
	lstPay.SetDataText(data);
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_rehs00020_lst.Call('SELECT');
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
			OnChangeTab(1);
			THS_CONTRACT_PK.text = grdData.GetGridData(grdData.row, 0);
			flag_select = true;
			dso_rehs00020_mst.Call('SELECT');
		break;
	}
}

function OnPopUp(n)
{
    var path;
    var object;
    var arr;
	switch(n)
	{
		case 1:
			 path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	         object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
				if (THS_CONTRACT_PK.text != '' && TCO_BUSPARTNER_PK.text != object[0]){
					OnChangeTab(3);
				}

	            TCO_BUSPARTNER_PK.text   = object[0];
                txtCustomer.text		 = object[2];                              
	         }
		break;
		case 2:
			 if (THS_CONTRACT_PK.text != ''){alert("Cannot choose Reservation No.!"); return false;}
			 path = System.RootURL + "/form/re/hs/rehs00020_popup.aspx";
	         object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');			 
			 	
	         if ( object != null )
	         {
					arr = object[0];
					THS_RESERVATION_PK.text = arr[0];
					txtReservationNo.text	= arr[1];
					txtCustomer.text		= arr[3];
					lstCCY.value			= arr[6];
					txtDes.text				= arr[7];
					TCO_BUSPARTNER_PK.text	= arr[8];

					grdDataDTL.ClearData();
					dso_rehs00020_1_dtl.Call('SELECT');
	         }
		break;
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:
			dso_rehs00020_mst.StatusInsert();
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
					for (row = 1; row < grdDataDTL.rows; row++ )
					{
						if(grdDataDTL.GetGridData(row,COL_BUILDING) == temp[COL_BUILDING] && grdDataDTL.GetGridData(row,COL_AREA) == temp[COL_AREA] && grdDataDTL.GetGridData(row,COL_FLOOR) == temp[COL_FLOOR] && grdDataDTL.GetGridData(row,COL_HOUSE_NO) == temp[COL_HOUSE_NO])
						{
							alert('Your house is exist!'); return false;
						}
					}
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
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_CONTRACT_PK				, THS_CONTRACT_PK.text);
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
			if (THS_CONTRACT_PK.text != '')
			{
				if (confirm('Are you sure delete data ?'))
				{
					dso_rehs00020_mst.StatusDelete();
					dso_rehs00020_mst.Call();
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
	/*if (txtReservationNo.text == '')
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		txtReservationNo.GetControl().focus();
		return;
	}*/
	
	if (txtCustomer.text == '')
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		txtCustomer.GetControl().focus();
		return;
	}

	if(txtCondition.GetData() == '' || txtCondition.GetData() == null)
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		txtCondition.GetControl().focus();
		return;
	}

	if(idSeller.GetData() == '' || idSeller.GetData() == null )
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		idSeller.GetControl().focus();
		return;
	}

	if(idBuyer.GetData() == '' || idBuyer.GetData() == null)
	{
		alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
		idBuyer.GetControl().focus();
		return;
	}
	
	flag_update = true;
	dso_rehs00020_mst.Call();
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_rehs00020_mst':
			if(flag_update == true){
				if (THS_CONTRACT_PK.text != ''){
					flag_update = false;
					for (var row = 1; row < grdDataDTL.rows; row++ ){
						grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_CONTRACT_PK				, THS_CONTRACT_PK.text);
					}
					dso_rehs00020_2_dtl.Call();
				}
				else{
					dso_rehs00020_lst.Call('SELECT');
				}
			}else{
				if (THS_CONTRACT_PK.text != '')
					dso_rehs00020_2_dtl.Call('SELECT');
				else{
					grdDataDTL.ClearData();
					dso_rehs00020_lst.Call();
				}
			}
		break;
		case 'dso_rehs00020_lst':
			if (THS_CONTRACT_PK.text != ''){
				
			}
		break;
		case 'dso_rehs00020_2_dtl':
			dso_rehs00020_lst.Call('SELECT');
		break;
		case 'dso_rehs00020_1_dtl':
			for(var i = 1; i < grdDataDTLTemp.rows; i++)
			{
				if(grdDataDTL.rows > 1){
					for (var row = 1; row < grdDataDTL.rows + 1; row++)
					{
						if(row < grdDataDTL.rows){
								if(grdDataDTL.GetGridData(row,COL_BUILDING) == grdDataDTLTemp.GetGridData(i,COL_BUILDING) && grdDataDTL.GetGridData(row,COL_AREA) == grdDataDTLTemp.GetGridData(i,COL_AREA) && grdDataDTL.GetGridData(row,COL_FLOOR) == grdDataDTLTemp.GetGridData(i,COL_FLOOR) && grdDataDTL.GetGridData(row,COL_HOUSE_NO) == grdDataDTLTemp.GetGridData(i,COL_HOUSE_NO))
							{
							}
							else{
								grdDataDTL.AddRow();
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_UNITTYPE_SCALE_HOUSE_PK	, grdDataDTLTemp.GetGridData(i,COL_THS_UNITTYPE_SCALE_HOUSE_PK));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TYPE							, grdDataDTLTemp.GetGridData(i,COL_TYPE));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_BUILDING						, grdDataDTLTemp.GetGridData(i,COL_BUILDING));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_AREA							, grdDataDTLTemp.GetGridData(i,COL_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_FLOOR							, grdDataDTLTemp.GetGridData(i,COL_FLOOR));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_HOUSE_NO						, grdDataDTLTemp.GetGridData(i,COL_HOUSE_NO));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_USING_AREA					, grdDataDTLTemp.GetGridData(i,COL_USING_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_LIVING_AREA					, grdDataDTLTemp.GetGridData(i,COL_LIVING_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SUPPLYING_AREA				, grdDataDTLTemp.GetGridData(i,COL_SUPPLYING_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_PARKING_AREA					, grdDataDTLTemp.GetGridData(i,COL_PARKING_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SITE_AREA						, grdDataDTLTemp.GetGridData(i,COL_SITE_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OFFICIAL_AREA					, grdDataDTLTemp.GetGridData(i,COL_OFFICIAL_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OTHER_AREA					, grdDataDTLTemp.GetGridData(i,COL_OTHER_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TOTAL_AREA					, grdDataDTLTemp.GetGridData(i,COL_TOTAL_AREA));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_VAT_RATE						, grdDataDTLTemp.GetGridData(i,COL_VAT_RATE));
								grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_CONTRACT_PK				, grdDataDTLTemp.GetGridData(i,COL_THS_CONTRACT_PK));
							}
						}
					}
				}else{
					grdDataDTL.AddRow();
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_UNITTYPE_SCALE_HOUSE_PK	, grdDataDTLTemp.GetGridData(1,COL_THS_UNITTYPE_SCALE_HOUSE_PK));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TYPE							, grdDataDTLTemp.GetGridData(1,COL_TYPE));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_BUILDING						, grdDataDTLTemp.GetGridData(1,COL_BUILDING));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_AREA							, grdDataDTLTemp.GetGridData(1,COL_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_FLOOR							, grdDataDTLTemp.GetGridData(1,COL_FLOOR));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_HOUSE_NO						, grdDataDTLTemp.GetGridData(1,COL_HOUSE_NO));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_USING_AREA					, grdDataDTLTemp.GetGridData(1,COL_USING_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_LIVING_AREA					, grdDataDTLTemp.GetGridData(1,COL_LIVING_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SUPPLYING_AREA				, grdDataDTLTemp.GetGridData(1,COL_SUPPLYING_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_PARKING_AREA					, grdDataDTLTemp.GetGridData(1,COL_PARKING_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_SITE_AREA						, grdDataDTLTemp.GetGridData(1,COL_SITE_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OFFICIAL_AREA					, grdDataDTLTemp.GetGridData(1,COL_OFFICIAL_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_OTHER_AREA					, grdDataDTLTemp.GetGridData(1,COL_OTHER_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_TOTAL_AREA					, grdDataDTLTemp.GetGridData(1,COL_TOTAL_AREA));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_VAT_RATE						, grdDataDTLTemp.GetGridData(1,COL_VAT_RATE));
					grdDataDTL.SetGridText(grdDataDTL.rows-1, COL_THS_CONTRACT_PK				, grdDataDTLTemp.GetGridData(i,COL_THS_CONTRACT_PK));
				}
			}
			//dso_rehs00020_lst.Call('SELECT');
		break;
		case 'dso_rehs00020_pc':
			alert(txtResult.text);
		break;
	}
}

function OnInfo()
{
	OnChangeTab(4);
}

function OnClose()
{
	OnChangeTab(2);
}

function OnCancel()
{
	OnChangeTab(3);
}

function OnChangeTab(n)
{
	var tab_Info	= document.all("Info");
    var tab_Close   = document.all("Close");    
    var tab_Cancel	= document.all("Cancel"); 

	switch(n)
	{
		case 4:
		case 1:
			tab_Info.style.display      = "";
			tab_Close.style.display     = "none";
			tab_Cancel.style.display	= "none";	
		break;
		case 2:
			tab_Info.style.display      = "none";
			tab_Close.style.display     = "";
			tab_Cancel.style.display	= "none";	
		break;
		case 3:
			tab_Info.style.display      = "none";
			tab_Close.style.display     = "none";
			tab_Cancel.style.display	= "";	
		break;
	}
}

function OnProcess(obj)
{
	switch(obj)
	{
		case 'Close':
			if(THS_CONTRACT_PK.text == ''){alert("No contract for close!"); return false;}
			if (txtClose.GetData() == '')
			{
				alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
				txtClose.GetControl().focus();
				return false;
			}
			dso_rehs00020_pc.Call();
		break;
		case 'Change':
			if (txtCancel.GetData() == '')
			{
				alert("Please input data for this textbox. \n\nBạn phải nhập dữ liệu cho textbox này.");
				txtCancel.GetControl().focus();
				return;				
			}
		break;
	}
}
</script>
<body>
 <gw:data id="dso_rehs00020_pc" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="crm.sp_upd_rehs00020_pc" > 
                <input>
                    <input bind="THS_CONTRACT_PK" />
                    <input bind="dtClose" />
					<input bind="txtClose" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dso_rehs00020_lst"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00020_LST">
			<input bind="grdData">
				<input bind="dtFrom" />
				<input bind="dtTo" />
				<input bind="txtSearch" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_rehs00020_mst" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="CRM.SP_SEL_REHS00020_MST" procedure="CRM.sp_upd_rehs00020_mst"> 
			<inout>
				<inout bind="THS_CONTRACT_PK" />
				<inout bind="txtContractNo" />
				<inout bind="lstCCY" />
				<inout bind="dtCont" />
				<inout bind="idSeller" />
				<inout bind="idBuyer" />
				<inout bind="txtCondition" />
				<inout bind="dtEffect" />
				<inout bind="txtDes" />
				<inout bind="lstPay" />
				<inout bind="TCO_BUSPARTNER_PK" />
				<inout bind="THS_RESERVATION_PK" />
				<inout bind="txtCustomer" />
				<inout bind="txtReservationNo" />
			</inout>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_rehs00020_1_dtl" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00020_1_DTL"> 
			<input bind="grdDataDTLTemp">
				<input bind="THS_RESERVATION_PK" />
			</input> 
			<output bind="grdDataDTLTemp" />
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_rehs00020_2_dtl"  onreceive="OnDataReceive(this)" >
	<xml> 
		<dso id="1" type="grid" parameter="0,16,17" function="CRM.SP_SEL_REHS00020_2_DTL" procedure="crm.sp_upd_rehs00020_dtl" > 
			<input bind="grdDataDTL"   > 
				<input bind="THS_CONTRACT_PK" />
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
                            &nbsp;&nbsp;&nbsp;&nbsp;Contract No.</td>
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
				<tr style="height: 1%">
					<td style="width: 5%">Cont No</td>
					<td style="width: 15%">
						<gw:textbox id="txtContractNo" styles="width: 100%" csstype="mandatory"/>
					</td>
					<td style="width: 5%" align="right">Cont Date</td>
					<td style="width: 25%" nowrap>
						<gw:datebox id="dtCont" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right"></td>
					<td colspan='2' style="width: 40%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 78%"></td>
								<td style="width: 5%" align="right">									
									<gw:icon id="idBtnClose" img="2" text="Close" alt="Close Contract" styles='width:100%'
                                            onclick="OnClose()" />
								</td>
								<td style="width: 5%" align="right">									
									<gw:icon id="idBtnInfo" img="2" text="Info" alt="Contract Information" styles='width:100%;'
                                            onclick="OnInfo()" />
								</td>
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
				<tr style="height: 1%">
					<td nowrap><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(2)">Reservation No</b></td>
					<td>
						<gw:textbox id="txtReservationNo" styles="width: 100%" csstype="mandatory"/>
					</td>
					<td style="width: 14%" align="right" nowrap>Effect Date</td>
					<td style="width: 18%" >	
						<gw:datebox id="dtEffect" lang="1" styles="width:100%" />			
					</td>
					<td style="width: 10%" align="right" nowrap>Pay Method</td>
					<td colspan="2" style="width: 30%" > 
						<gw:list id="lstPay" styles="width:100%" />
					</td>
				</tr>
				<tr style="height: 1%">
					<td nowrap><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">Customer</b></td>
					<td colspan='3'>
						<gw:textbox id="txtCustomer" styles="width: 100%" csstype="mandatory" check='1'/>
					</td>
					<td align="right" nowrap>CCY</td>
					<td colspan='2'>
						<gw:list id="lstCCY" text="" styles='width:100%'/>
					</td>
				</tr>
				<tr style="height: 1%">
					<td>Description</td>
					<td colspan="3">
						<gw:textbox id="txtDes" styles="width: 100%"/>
					</td>
					<td align="right" nowrap></td>
					<td>
					</td>
					<td>
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
				<tr>
					<td>Condition</td>
					<td colspan="6">
						<gw:textarea id="txtCondition" rows="3" styles="width:100%" />
					</td>
				</tr>
				<tr style="height: 1%">
					<td colspan="7" style="height: 15%; width: 100%">
						<table id="Info" style="height: 100%; width: 100%" border="0">
							<tr>
								<td style="width: 50%">
									<fieldset style="padding:1; width: 100%; height:95%">
										<legend><font color="black" size="2">Seller Info</font></legend>
										<gw:textarea rows="6" styles="width:100%" id="idSeller"/>
									</fieldset>
								</td>
								<td style="width: 50%">
									<fieldset style="padding:1; width: 100%; height:95%">
										<legend><font color="black" size="2">Buyer Info</font></legend>
										<gw:textarea rows="6" styles="width:100%" id="idBuyer"/>
									</fieldset>
								</td>		
							</tr>
						</table>
						<table id="Close" style="height: 100%; width: 100%" border="0">
							<tr>
								<td style="height: 100%;width: 100%">
									<fieldset style="padding:1; width: 100%; height:10%">
										<legend><font color="black" size="2">Close Reason</font></legend>
										<table style="height: 20%; width: 100%" border="0">
											<tr>
												<td style="width: 10%" align='left' nowrap>Close Date</td>
												<td style="width: 15%"	>
													<gw:datebox id="dtClose" lang="1" styles="width:100%"  />
												</td>
												<td style="width: 74%">
												</td>
												<td style="width: 1%"	>
													<gw:icon id="btnClose" img="1" text="Process" styles='width:100%' onclick="OnProcess('Close')" />
												</td>
											</tr>
											<tr>
												<td colspan="4" style="height: 1%; width: 100%"	>
													<gw:textarea id="txtClose" rows="3" styles="width:100%" />
												</td>		
											</tr>
										</table>
									</fieldset>	
								</td>
							</tr>
						</table>
						<table id="Cancel" style="height: 100%; width: 100%" border="0">
							<tr>
								<td style="height: 100%;width: 100%">
									<fieldset style="padding:1; width: 100%; height:10%">
										<legend><font color="black" size="2">Change Customer</font></legend>
										<table style="height: 20%; width: 100%" border="0">
											<tr>
												<td style="width: 10%" align='left' nowrap>Change Date</td>
												<td style="width: 15%"	>
													<gw:datebox id="dtChange" lang="1" styles="width:100%"  />
													<gw:textbox id="TCO_BUSPARTNER_PK_FROM" styles="width: 100%; display:none"/>
													<gw:textbox id="TCO_BUSPARTNER_PK_TO" styles="width: 100%; display:none"/>
												</td>
												<td style="width: 9%" align='center' nowrap>From</td>
												<td style="width: 20%" align='left' nowrap><gw:textbox id="TCO_BUSPARTNER_NAME_FROM" styles="width: 100%;"/></td>
												<td style="width: 5%" align='center' nowrap>To</td>
												<td style="width: 20%" align='left' nowrap><gw:textbox id="TCO_BUSPARTNER_NAME_TO" styles="width: 100%;"/></td>
												<td style="width: 20%">
												</td>
												<td style="width: 1%"	>
													<gw:icon id="btnChange" img="1" text="Process" styles='width:100%' onclick="OnProcess('Change')" />
												</td>
											</tr>
											<tr>
												<td align='left'>Remain AMT</td>
												<td><gw:textbox id="txtRemain_AMT" styles="width: 100%;"/></td>
												<td align='left'>Description</td>
												<td colspan='5'><gw:textbox id="txtDescription" styles="width: 100%;"/></td>
											</tr>
											<tr>
												<td align='left' nowrap>Reason</td>
												<td colspan="7" style="height: 1%; width: 100%"	>
													<gw:textarea id="txtChange" rows="3" styles="width:100%" />
												</td>		
											</tr>
										</table>
									</fieldset>	
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 95%">
                        <td colspan="7">
                            <gw:grid id="grdDataDTL" 
							header="_PK|Type|Building|Area|Floor|House No|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Area|Total Area|VAT Rate|Description|Price|_THS_UNITTYPE_SCALE_HOUSE_PK|_THS_CONTRACT_PK|_ths_unittype_price_pk"
							format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							aligns="0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0"
							defaults="|||||||||||||||||||"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0"
							styles="width:100%;height:100%" 
							autosize='T'
							debug="false"/>
							<gw:grid id="grdDataDTLTemp" 
							header="_PK|Type|Building|Area|Floor|House No|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Area|Total Area|VAT Rate|Description|Price|_THS_UNITTYPE_SCALE_HOUSE_PK|_THS_CONTRACT_PK|_ths_unittype_price_pk" 
							format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							aligns="0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0"
							defaults="|||||||||||||||||||"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0"
							styles="width:100%;height:100%" 
							autosize='T'
							debug="true"
							style="display:none" />
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
<gw:textbox id="THS_CONTRACT_PK" text="" styles="width: 100%; display:none"/>
<gw:textbox id="txtResult" text="" styles="width: 100%; display:none"/>
</html>
