<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>IQC Request Entry</title>
 <%ESysLib.SetUser("prod")%>
 <script>
 //---------------------------------------------------------
 var status_control = 0; //1 :Delete , 2 :Save
 
 function BodyInit()
 { 
    BindingDataList();
   datRequestIQC.StatusInsert(); 
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 ="<%= ESysLib.SetListDataSQL(" select pk,partner_id from tco_company where del_if = 0") %>";
        cboCompany.SetDataText(data1);
        txtRequester.SetEnable(false);
 }
 
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="80%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

function onRequesterClick()
{
        var fpath;
        var oValue;
        fpath = System.RootURL + "/form/bd/dp/bddp00011.aspx";
        oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');

        if ( oValue != null )
        {
                txtRequesterPK.text = oValue[0];
                txtRequester.text = oValue[2];
        }
}

function OnGetItemPOClick()
{
        var fpath;
        var oValue;
        fpath = System.RootURL + "/form/ep/di/epdi00010_2.aspx";
        oValue = System.OpenModal( fpath , 1000 , 650 , 'resizable:yes;status:yes');

        if ( oValue != null )
        {
               for ( var i=0; i<oValue.length;i++)
                {
                    var aTemp = oValue[i];
                    grdRequestIQCDetail.AddRow();
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 1, txtIQC_PK.text); // Master PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 2, aTemp[10]); //_tpr_purordd_pk
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 3, aTemp[0]); // Item PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 4, aTemp[1]); // Item Code
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 5, aTemp[2]); // Item Name
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 6, aTemp[3]); // Unit
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 7, aTemp[4]); // Lot No
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 8, aTemp[5]); // _TCO_BUSPARTNER_PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 9, aTemp[6]); // Vendor
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 10, aTemp[7]); // Receiver PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 11, aTemp[8]); // Receiver Name
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 12, aTemp[9]); // PO No
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 14, 'DOMESTIC'); // BL YN
                }
        }
}

function OnGetItemSeaClick()
{
        var fpath;
        var oValue;
        fpath = System.RootURL + "/form/ep/di/epdi00010_1.aspx";
        oValue = System.OpenModal( fpath , 1000 , 650 , 'resizable:yes;status:yes');

        if ( oValue != null )
        {
               for ( var i=0; i<oValue.length;i++)
                {
                    var aTemp = oValue[i];
                    grdRequestIQCDetail.AddRow();
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 1, txtIQC_PK.text); // Master PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 2, aTemp[9]); //_tpr_purordd_pk
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 3, aTemp[0]); // Item PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 4, aTemp[1]); // Item Code
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 5, aTemp[2]); // Item Name
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 6, aTemp[3]); // Unit
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 8, aTemp[5]); // _TCO_BUSPARTNER_PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 9, aTemp[6]); // Vendor
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 12, aTemp[4]); // CInvoice No
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 14, 'OVERSEA'); // BL YN
                }
        }

}

function OnGetItemFreeClick()
{
        var fpath;
        var oValue;
        fpath = System.RootURL + "/form/ep/gm/PopUpGetItem.aspx";
         //fpath = System.RootURL + "/form/ep/di/epdi00010_3.aspx";
        oValue = System.OpenModal( fpath , 900 , 700 , 'resizable:yes;status:yes');

        if ( oValue != null )
        {
               for ( var i=0; i<oValue.length;i++)
                {
                    var aTemp = oValue[i];
                    grdRequestIQCDetail.AddRow();
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 1, txtIQC_PK.text); // Master PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 3, aTemp[0]); // Item PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 4, aTemp[1]); // Item Code
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 5, aTemp[2]); // Item Name
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 6, aTemp[5]); // Unit
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 10, aTemp[15]); // Receiver PK
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 11, aTemp[17]); // Receiver Name
                    grdRequestIQCDetail.SetGridText(grdRequestIQCDetail.rows-1, 14, 'DOMESTIC'); // BL YN
                }

        }
}

function OnSearchClick()
{
    grdIQCSearch.ClearData();
    datRequestIQC_Search.Call('SELECT');
}

function OnGridSearchClick()
{
    if (grdIQCSearch.row >0)
    { 
        txtIQC_PK.text = grdIQCSearch.GetGridData(grdIQCSearch.row,0);
        grdRequestIQCDetail.ClearData();
        datRequestIQC.StatusSelect();
        datRequestIQC.Call('SELECT');
     }
}

function  onReceiveSearch()
{
    if (status_control==1)
   {
        status_control = 0;
        onMasterNew();
   }
}

function onSaveMaster()
{
    if (txtVoucherNo.text =="")
   {
        alert("Please enter Voucher No");
        return;
   } 
   if (txtRequesterPK.text =="")
   {
        alert("Please enter Requester");
        return;
   }
    
    if (confirm("Do you want to save ?"))
   {
        status_control = 2;
        switch (datRequestIQC.GetStatus())
        {
                case 10 :
                        datRequestIQC.StatusUpdate();
                        datRequestIQC.Call('UPDATE'); 
                break; 
                case 20 :
                    datRequestIQC.Call('INSERT'); 
                break;
        }
   } 
}

function onNewMaster()
{
     grdRequestIQCDetail.ClearData();
     datRequestIQC.StatusInsert();
}

function onReceiveData(obj)
{
    
   if (obj.id =="datRequestIQC") //
   {
        if (status_control ==2) //save detail
        {
            status_control = 0;
            onSaveDetail();
        }
        else //Load Detail
        {
              datRequestIQCDetail.Call('SELECT');
        }
   }   
}

function onSaveDetail()
{
       datRequestIQCDetail.Call('');
}

function onUnDeleteDetail()
{
    if (confirm("Do you want to undelete the selected row ?"))
   {
        grdRequestIQCDetail.UnDeleteRow();
   }
}

function onDeleteDetail()
{
    if (confirm("Do you want to delete the selected row ?"))
    {
        grdRequestIQCDetail.DeleteRow();
     }
}
 </script>
  </head>
<body>
 <gw:data id="datRequestIQC_Search"   onreceive="onReceiveSearch()">
    <xml> 
        <dso id="1" type="grid" function="prod.sp_sel_reqiqc_search" > 
            <input bind="grdIQCSearch" >
                <input bind="txtVNoSearch" />
				<input bind="dtbSearchFrom" />
                <input bind="dtbSearchTo" />
            </input>
            <output bind="grdIQCSearch" />
        </dso>
    </xml>
</gw:data>

 <gw:data id="datRequestIQC"   onreceive="onReceiveData(this)">
    <xml> 
        <dso id="2" type="control" user="prod" parameter="0,1,2,3,4,5" function="prod.sp_sel_reqiqc" procedure = "prod.sp_upd_reqiqc"> 
            <input>
                    <inout bind="txtIQC_PK" />
                    <inout bind="cboCompany" />
                    <inout bind="dtbVoucherDate" />
                    <inout bind="txtVoucherNo" />
                    <inout bind="txtRequesterPK" />
                    <inout bind="txtDescription" />
                    <inout bind="txtRequester" />
            </input>
        </dso>
    </xml>
</gw:data>

<gw:data id="datRequestIQCDetail"   onreceive="onReceiveData(this)">
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,7,8,10,12,13,14,15" function="prod.sp_sel_reqiqc_detail" procedure = "prod.sp_upd_reqiqcd" > 
            <input bind="grdRequestIQCDetail" >
                <input bind="txtIQC_PK" />
            </input>
            <output bind="grdRequestIQCDetail" />
        </dso>
    </xml>
</gw:data>

<table width="100%" border="0" style="background: #BDE9FF" id="tableID1" >
    <tr>
        <td width="34%" align="left" valign="top" id="left" >
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background:#FFFFFF;">
                <tr>
                    <td width="50%"><b>&nbsp;Voucher No</b></td>
                    <td width="40%" ><gw:textbox id="txtVNoSearch" styles="width:98%;margin-left:3px;" onenterkey="OnSearchClick()" /></td>
                    <td width="10%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearchClick()" /></td>
                </tr>
                <tr>
                    <td ><b>&nbsp;Voucher Date</b></td>
                    <td  align="left">
                        <table border="0" cellpadding="1" cellspacing="2" width="100%">
                            <tr>
                                <td width="40%"><gw:datebox id="dtbSearchFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                                <td width="20%"><b>&nbsp;~&nbsp;</b></td>
                                <td width="40%"><gw:datebox id="dtbSearchTo" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                            </tr>
                        </table>
                   </td>
                    <td >&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="3">
                        <gw:grid
                        id="grdIQCSearch"
                        header="_pk|Voucher Date|Voucher No"
                        format="0|4|0"
                        aligns="0|0|0"
                        defaults="|||"
                        editcol="0|0|0"
                        widths="0|1400|1800"
                        styles="width:100%; height:400"
                        sorting="F"
                        oncellclick="OnGridSearchClick()"
                        param="0,1,2" />
                    </td>
                </tr>
            </table>
        </td>
        <td width="66%" valign="top" id="right" >
            <table  border="0" cellpadding="0" cellspacing="0" width="100%" style="background:#FFFFFF;">
                <tr>
                       <td width="15%">&nbsp;&nbsp;&nbsp;Company&nbsp;&nbsp;</td>
                       <td width="30%"><gw:list id="cboCompany"   styles="width:100%;"  ></gw:list></td>
                       <td width="15%">&nbsp;</td>
                       <td width="40%" align="right">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr align="right">
                                        <td ><gw:imgBtn id="ibtnExcel" img="excel" alt="Excel" text="Excel" onclick="onExcelClick()" /></td>
                                        <td ><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNewMaster()" /></td>
                                       <td ><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSaveMaster()" /></td> 
                                        <td ><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="onDeleteMaster()" /></td>
                                    </tr>
                                </table>
                       </td>
                </tr>
                <tr>
                       <td>&nbsp;&nbsp;&nbsp;Voucher No&nbsp;&nbsp;</td>
                       <td><gw:textbox id="txtVoucherNo"  styles="width:100%;" csstype="mandatory"  /></td>
                       <td>&nbsp;&nbsp;&nbsp;Voucher Date</td>
                       <td><gw:datebox id="dtbVoucherDate" lang="<%=Application("Lang")%>" mode="01" styles="width:100%;background-color : #fffaaf;" /></td>
                </tr> 
                <tr>
                         <td>&nbsp;&nbsp;&nbsp;<b style="color: #1b2ff2; cursor: hand" onclick="onRequesterClick()">Requester </b>&nbsp;&nbsp;</td>
                       <td><gw:textbox id="txtRequester"  styles="width:100%;"   /></td> 
                       <td>&nbsp;&nbsp;&nbsp;Description&nbsp;&nbsp;</td>
                       <td><gw:textbox id="txtDescription"  styles="width:100%;"   /></td>
                </tr> 
               <tr>
                       <td align="right" colspan="4">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr align="right">
                                    <td ><gw:icon id="ibtnItemFree" img="in" alt="Get Free Item" text="Get Free Item" onclick="OnGetItemFreeClick()" /></td>
                                    <td ><gw:icon id="ibtnItemSea" img="in" alt="Get Item from Sea stock" text="Get Item from Sea stock" onclick="OnGetItemSeaClick()" /></td>
                                   <td ><gw:icon id="ibtnItemPO" img="in" alt="Get Item from PO" text="Get Item from PO" onclick="OnGetItemPOClick()" /></td> 
                                    <td ><gw:imgbtn id="btnDeleteD" img="delete" alt="Delete" text="Delete" onclick="onDeleteDetail()" /></td>
                                    <td ><gw:imgbtn id="btnUDeleteD" img="udelete" alt="UnDelete" text="UnDelete" onclick="onUnDeleteDetail()" /></td>
                                </tr>
                            </table>
                    </td>
                </tr> 
               <tr>
                    <td colspan="4">
                            <gw:grid id='grdRequestIQCDetail'
                                header='_PK|_TPR_REQIQC_PK|_tpr_purordd_pk|_Item_PK|Item Code|Item Name|Unit|Lot No|_TCO_BUSPARTNER_PK|Vendor|_RECEIVE_FROM_PK|Receiver From|Invoice No|Req. Qty|Trading Type|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0'
                                aligns='0|0|0|0|0|0|1|0|0|0|0|0|0|0|1|0'
                                defaults='|||||||||||||||'
                                editcol='0|0|0|0|0|0|1|1|0|0|0|0|0|1|0|1'
                                widths='1000|1000|1000|1000|1200|1500|1000|1000|1245|1485|1000|1365|1125|1000|1200|1000'
                                sorting='T'
                                styles='width:100%; height:360'
                            />
                    </td>
               </tr> 
            </table>
        </td>
    </tr>
    </table>
   <gw:textbox id="txtRequesterPK"  styles="display:none;"   />
   <gw:textbox id="txtIQC_PK"  styles="display:none;"   />
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:1;top:0;" onclick="OnToggle()" /> 
</body>
</html>