 <!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Declaration Liquidation List</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script language="javascript" type="text/javascript">
var action ;
var G1_SEQ     =   0,
	G1_DLANTHANHLYID     =   1,
	G1_LAN_TL     =   2,
	G1_SO_HS_TL     =   3,
	G1_NGAY_BD_TL     =   4,
	G1_NGAY_KT_TL     =   5,
	G1_SO_QDTL     =   6,
	G1_NGAY_QDTL     =   7,
	G1_MA_DV     =   8,
	G1_MA_HQ     =   9,
	G1_TRANG_THAI     =   10,
	G1_KIEU_TL     =   11,
	G1_CUS_NAME     =   12,
	G1_LAN_TL_MAX     =   13;
//------------------------------------------------------------------------------------
function BodyInit()
{
	txtCustomsPK.SetEnable(false);
	txtCustomsCode.SetEnable(false);
	txtCustomsName.SetEnable(false);
	txtHCom_Pk.text  = "<%=Session("COMPANY_PK")%>";
    BindingDataList();
	dat_ephl00020_Get_Cus.Call('SELECT');
}
//-------------------------------------------------------------------------------------
 function BindingDataList()
 { 
 }
 
 //-------------------------------------------------------------------------------------
 function OnFormatGrid()
 {
	var ctrl ;
    ctrl = grdLiquidationList.GetGridControl();
	ctrl.ColFormat(G1_SEQ)             = "#,###,###,###,###,###";
	ctrl.ColFormat(G1_LAN_TL)             = "#,###,###,###,###,###";
	
    ctrl.Cell( 7, 0, G1_LAN_TL, grdLiquidationList.rows - 1, G1_LAN_TL) = 0x0000FF;
	
 }

 //-------------------------------------------------------------------------------------
function OnSearch()
{
    dat_ephl00020.Call('SELECT');
}
//-------------------------------------------------------------------------------------

function OnGridCellDblClick(obj)
{
	var col = event.col;
	var row = event.row;
	switch(obj.id)
	{
		case 'grdLiquidationList':
			
		break;
	}
}
//-------------------------------------------------------------------------------------
function OnPopUp()  
{   
	 var path = System.RootURL + "/form/ep/bs/epbs00040.aspx?pop_type=Y";
	 var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes;scroll:no;');
	 if ( object != null )
	 {	        	                   
		 txtCustomsPK.text   = object[0]; 
		 txtCustomsCode.text = object[1];
		 txtCustomsName.text = object[2];	                
	 }                
       
}
//----------------------------------------------------------------------------------------------------
function OnDataReceive(p_value)
{
    switch(p_value.id)
    {
        case 'dat_ephl00020':
             var iNumRecord    =  grdLiquidationList.rows-1 ;
             lblTotalItem.text = iNumRecord  + " record(s)." ;
			 OnFormatGrid();
        break;       
       case 'dat_ephl00020_Get_Cus':
			txtCustomsPK.text = txtHCus_Pk.text;
			txtCustomsCode.text = txtHCus_Code.text;
			txtCustomsName.text = txtHCus_Name.text;
            dat_ephl00020.Call('SELECT');
       break;
    }
}
function OnPrint()
{
	alert("Fuction is not implement!");
    /*switch(index)
    {
        case 0:
            var  url= System.RootURL + "/reports/ep/hl/rpt_ephl00020_EXPORT.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value;
	        System.OpenTargetPage( url, "_blank" );
        break;
        case 1:
            var  url= System.RootURL + "/reports/ep/hl/rpt_ephl00020_IMPORT.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value;
	        System.OpenTargetPage( url, "_blank" );
        break;
        case 2:
            var  url= System.RootURL + "/reports/ep/hl/rpt_lid_inv_material.aspx?" + "pk=" + txtMasterPK.text + "&com_pk=" + cboCompany.value;
	        System.OpenTargetPage( url, "_blank" );
        break;
        case 3:
            var  url= System.RootURL + "/reports/ep/hl/rpt_lid_inv_material.aspx?" + "mst_pk=" + txtMasterPK.text;
	        System.OpenTargetPage( url, "_blank" );
        break;
    }*/
        
}
</script>

<body>
	<!-------------------------------Lay thong tin cua hai quan, thong tin cong ty------------------------------------------------>
    <gw:data id="dat_ephl00020_Get_Cus" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7" function="<%=l_user%>lg_sel_epim00010_info"> 
                <inout> 
                    <inout  bind="txtHCom_Pk" /> 
                    <inout  bind="txtHCus_Pk" />
                    <inout  bind="txtHCus_Code" />
                    <inout  bind="txtHCus_Name" />
                    
                    <inout  bind="txtHCom_Pk" />                    
                    <inout  bind="txtHCom_Id" />
                    <inout  bind="txtHCom_Name" />
                    <inout  bind="txtHCom_Code" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------List of Declaration--------------------------------------->
    <gw:data id="dat_ephl00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="<%=l_user%>lg_sel_ephl00020" > 
                <input >
                    <input bind="txtHCom_Pk" /> 
					<input bind="txtHCus_Code" /> 
					<input bind="txtHCom_Code" /> 
                </input> 
                <output bind="grdLiquidationList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%">
            <tr style="height: 1%">
                <td style="width: 5%; white-space: nowrap">
                    <a onclick="OnPopUp('Custom')" href="#tips" style="color: #0000ff">Customs</a>
                </td>
                <td style="width: 45%; white-space: nowrap"  >
                    <gw:textbox id="txtCustomsPK" styles='display:none;' />
                    <gw:textbox id="txtCustomsCode" text="" styles='width:20%;' />
                    <gw:textbox id="txtCustomsName" text="" styles='width:80%;' />
                </td>
                <td width="47%" white-space: nowrap" align="Center">
                    <gw:label id="lblTotalItem" text="" styles='width:100%;' />
                </td>
                <td width="1%">
                    <gw:button id="btnPopup" img="popup" alt="View Detail" text="View Detail" onclick="OnPopUp()" />
                </td>
                <td width="1%">
                    <gw:button id="btnSearch" img="search" alt="Search" text="search" onclick="OnSearch()" />
                </td>
                <td width="1%">
                    <gw:button id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                </td>
            </tr>
            <tr style="height: 99%">
                <td colspan="6">
					<gw:grid id='grdLiquidationList'
						header='Seq|_DLANTHANHLYID|Liq Seq|Liq No|Liq Year|Liq Start Date|Liq End Date|Liq Decision No|Liq Decision Date|_MA_DV|_MA_HQ|Status|_KIEU_TL|_CUS_NAME|_LAN_TL_MAX'
						format='1|1|1|0|0|4|4|0|4|0|0|0|0|0|0'
						aligns='0|0|0|0|1|1|1|0|1|0|0|0|0|0|0'
						check='||||||||||||||'
						editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
						widths='500|1000|1200|1500|1000|1500|1500|1500|1800|1000|1000|1000|1000|1000|1000'
						sorting='T'
						styles='width:100%; height:100%'
						oncelldblclick='OnGridCellDblClick(this)'
						acceptnulldate='true' />
                </td>
            </tr>
        </table>
    </form>
	<!-------------------------------MAC DINH HAI QUAN & MA SO DOANH NGHIEP ------------------->
	<gw:textbox id="txtHCom_Pk" style='display:none;width:100%' />
	<gw:textbox id="txtHCom_Code" style='display:none;width:100%' />
	<gw:textbox id="txtHCom_Name" style='display:none;width:100%' />
	<gw:textbox id="txtHCom_Id" style='display:none;width:100%' />
	<gw:textbox id="txtHCus_Pk" style='display:none;width:100%' />
	<gw:textbox id="txtHCus_Code" style='display:none;width:100%' />
	<gw:textbox id="txtHCus_Name" style='display:none;width:100%' />
</body>

</html>
