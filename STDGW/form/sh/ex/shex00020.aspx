<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MATERIAL TAKE IN</title>
</head>
<%ESysLib.SetUser("inv");%>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">

//-----------------------------------------------------

var flag;

var G1_PK    = 0 ;

//---------------------------------------------------------
var G1_PK                       = 0,
    G1_tsh_t_neto_t_pk          = 1,
    G1_No                       = 2,   
    G1_Size                     = 3,
    G1_Print                    = 4,
    G1_Tco_item_pk              = 5,   
    G1_Product_code             = 6,
    G1_Item_name                = 7,
    G1_Quantity                 = 8,   
    G1_Payment_amount           = 9,
    G1_Sales_price              = 10,
    G1_Currency                 = 11,
    G1_Freight                  = 12,
    G1_Fees                     = 13,   
    G1_Insurance                = 14, 
    G1_Interest                 = 15,
    G1_Printing                 = 16,
    G1_Size_code                = 17;
//---------------------------------------------------------
var iCodeID = "" ; 
var initFlag = 1;
//-----------------------------------------------------
function BodyInit()
 {
//    System.Translate(document);  // Translate to language session    

//    txtVoucherNo.SetEnable(false);
//    txtStaff.SetEnable(false);
//    txtDeptName.SetEnable(false);
//    txtDeptCode.SetEnable(false);
//    txtSupplier.SetEnable(false);
//    //-------------------------
//    var now = new Date(); 
//    var lmonth, ldate;
//    
//    ldate=dtFrom.value ;         
//    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
//    dtFrom.value=ldate ;
//    //----------------------------
//    
    BindingDataList();    
//    //----------------------------
//         
//    //SetGridFormat();  
//    //----------------------------
//    OnNew();
    
 }
 //---------------------------------------------------------------------------------------------------
 
 function BindingDataList()
 {  
     var data;    
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0100') FROM DUAL" )%>||";    
        cboCurrType.SetDataText(data);
        cboCurrType.value = "";
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0120') FROM DUAL" )%>||";    
        cboPayType.SetDataText(data);
        cboPayType.value="";
        
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGCM0250') FROM DUAL" )%>||";    
        cboShipping.SetDataText(data);
        cboShipping.value="";
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('SHEX0010') FROM DUAL" )%>||";    
        cboSaleType.SetDataText(data);
        cboSaleType.value="";
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGHC0010') FROM DUAL" )%>||";    
        cboCompany.SetDataText(data);
        cboCompany.value="";
     //-----------------------          
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_TakeIn_Qty) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Item_Price) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Amount)     = "#,###,###,###,###,###.##";
 }
 //----------------------------------------------------------
function AddDigit(value, number)
{
    newstr = value;
    for(i=value.length; i< number; i++)
    {
        newstr = '0' + newstr;
    }
    return newstr;
}
 //---------------------------------------------------------------------------------------------------
  
function OnNew()
{
    var path = System.RootURL +  '/form/sh/ex/shex00021.aspx';
    var obj = System.OpenModal( path ,900 , 400 ,  'resizable:yes;status:yes');
    if(data_shex00020.GetStatus()!=20)
    {
        data_shex00020.StatusInsert();
    }
    if(obj!=null)
    {
        txtSlipNo.text=obj[1];
        dtReleaseDate.value=obj[2];
        txtCustomerID.text=obj[8];
        txtCustomerName.text=obj[4];
        txtNation.text=obj[9];
        txtCustomerPK.text=obj[3];
        txtMasterPK.text=obj[0];
        cboCompany.value=obj[7];
        data_shex00020_loaddata.Call("SELECT");
    }
 
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch(pos)
    {
        case'grdVouchers':
            data_shex00020_main_list.Call("SELECT");
        break;
        case'master':
            txtMasterPK.text=grdVouchers.GetGridData(grdVouchers.row,0);
            data_shex00020.Call("SELECT");
        break;
    }
    
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'data_shex00020_loaddata':
            for(i=1;i<grdDetail.rows;i++)
            {
                grdDetail.SetGridText(i,G1_No,i);
            }
            txtMasterPK.text="";
        break;
        case'data_shex00020':
            if(flag=="update")
            {
                OnSave(2);
            }
            else
            {
                shex00020_2.Call("SELECT");
            }
        break;
        case'shex00020_2':
            if(flag=="update")
            {
                data_shex00020_main_list.Call("SELECT");
                flag="";
            }
        break;
    }
}

//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
	       
}

//-------------------------------------------------------------------------------------
var flag="";
function OnSave(pos)
{    
    switch(pos)
    {
        case 1:
            data_shex00020.Call();
            flag="update";
        break;
        case 2:
            for ( i = 1; i < grdDetail.rows ; i++ )
                {
                    if ( grdDetail.GetGridData(i,G1_tsh_t_neto_t_pk) == "" )
                    {
                        grdDetail.SetGridText( i ,G1_tsh_t_neto_t_pk , txtMasterPK.text ) ;
                        grdDetail.SetRowStatus(i,48);
                    } 
                }
           shex00020_2.Call();
        break;
    } 
}

//-------------------------------------------------------------------------------------

function OnGridCellDoubleClick(oGrid)
{

}   

//------------------------------------------------------------------------------------------------

 function OnDelete(obj)
 {
    switch(obj)
    {
        case 'Master':
            if ( confirm( "Do you want to delete?" ) ) 
            {
               flag = 'update';
               data_shex00020.StatusDelete();
               data_shex00020.Call();
            }
        break;
    }
 }
 //------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              

}

//-------------------------------------------------------------------------------------
function Validate()
{   
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData(i,G1_TakeIn_Qty)) == 0)
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
        if ( grdDetail.GetGridData(i,G1_TIN_WAREHOUSE_PK) == "")
        {
            alert("Input Warehouse at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//---------------------------------------------------------------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_TakeIn_Qty || col == G1_Item_Price || col == G1_Amount )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }     
    }
    //----------------------Calculate Amount -----
    if ( col == G1_TakeIn_Qty || col == G1_Item_Price )
    {
        dQuantiy = grdDetail.GetGridData( row, G1_TakeIn_Qty) ;
        dPrice   = grdDetail.GetGridData( row, G1_Item_Price) ;
        
        if(dQuantiy!=""&& dPrice!="")
        {    
            var dAmount = dQuantiy * dPrice;
            
            grdDetail.SetGridText( row, G1_Amount, parseFloat(dAmount+"").toFixed(2));
        }
        else
        {
            grdDetail.SetGridText( row, G1_Amount,"");
        }            
    }    
    //----------------------
}
//----------------------------------------------------------------------------------------
function OnChangeType()
{
    
    
}
//----------------------------------------------------------------------------------------
function OnPrint() 
{
    if(txtMasterPK.text!="")
    {
        var fpath = System.RootURL + "/form/sh/ex/shex00022.aspx?Master_pk="+txtMasterPK.text;
        var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
    }  
    
}
//----------------------------------------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

</script>

<body>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_shex00020_loaddata" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="sale.sp_sel_shex00020_loaddata" >
                <input bind="grdDetail" >
                    <input bind="txtMasterPK" /> 
                </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="data_shex00020" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="sale.sp_sel_shex00020" procedure="sale.sp_upd_shex00020"> 
                <inout> 
                    <inout bind="txtMasterPK" />
                    <inout bind="txtSlipNo" />  
                    <inout bind="dtReleaseDate" />
                    <inout bind="cboCompany" />
                    <inout bind="txtCustomerPK" />
                    <inout bind="txtCustomerID" />
                    <inout bind="txtCustomerName" />
                    <inout bind="txtNation" />
                    <inout bind="cboCurrType" />           
                    <inout bind="dtShipDate" />
                    <inout bind="cboPayType" />
                    <inout bind="txtVNDExRate" /> 
                    <inout bind="txtUSAExRate" />
                    <inout bind="cboShipping" />        
                    <inout bind="cboSaleType" />  
                    <inout bind="dtRemittance" />  
                    <inout bind="txtPoNo" />  
                    <inout bind="txtTotalQty" />       
                    <inout bind="txtTotalAmount" /> 
                    <inout bind="txtClassification" />
                 </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="data_shex00020_main_list" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="sale.sp_sel_shex00020_main_list" >
                <input bind="grdVouchers" >
                    <input bind="txtNoSearch" /> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                </input>
                <output bind="grdVouchers" />
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="shex00020_2" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="sale.sp_sel_shex00020_2"  procedure="sale.sp_upd_shex00020_2" > 
                <input> 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            No.
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdVouchers')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Date</td>
                        <td colspan="2" style="white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Voucher No" format="0|4|0" aligns="0|1|0"
                                defaults="||" editcol="0|0|0" widths="0|1200|1200" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2" oncellclick="OnSearch('master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%">
                            <b onclick="OnNew()" style="color: #0000ff; cursor: hand">Release</b>
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtSlipNo" styles="width:100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Release Date
                        </td>
                        <td>
                            <gw:datebox id="dtReleaseDate" lang="1" />
                        </td>
                        <td style="width: 5%">
                            Plant
                        </td>
                        <td style="width: 30%">
                            <gw:list id="cboCompany" styles="width:100%;">
                            </gw:list>
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                           
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td style="width: 1%; white-space: nowrap">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave(1)" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%">
                            Customer
                        </td>
                        <td colspan="9" style="white-space: nowrap">
                            <gw:textbox id="txtCustomerPK" styles="display:none;" />
                            <gw:textbox id="txtCustomerID" styles="width:18%" />
                            &nbsp;
                            <gw:textbox id="txtCustomerName" styles="width:50%" />
                            &nbsp;
                            <gw:textbox id="txtNation" styles="width:30%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            Currency Type
                        </td>
                        <td>
                            <gw:list id="cboCurrType" styles="width:100%;" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            Shipment Date
                        </td>
                        <td>
                            <gw:datebox id="dtShipDate" lang="1" nullaccept />
                        </td>
                        <td>
                            Payment
                        </td>
                        <td colspan="5">
                            <gw:list id="cboPayType" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            VND Ex. Rate
                        </td>
                        <td>
                            <gw:textbox id="txtVNDExRate" styles="width:100%" type='number'  format="###,###,###"/>
                        </td>
                        <td style="width: 5%">
                            US$ Ex. Rate
                        </td>
                        <td>
                            <gw:textbox id="txtUSAExRate" styles="width:100%" type='number'  format="###,###,###.00R" />
                        </td>
                        <td style="width: 5%">
                            Shipping
                        </td>
                        <td colspan="5">
                            <gw:list id="cboShipping" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap">
                            Sales Type
                        </td>
                        <td>
                            <gw:list id="cboSaleType" styles="width:100%;" />
                        </td>
                        <td>
                        </td>
                        <td>
                          <!--  <button>
                                Enter Adv</button> -->
                        </td>
                        <td>
                            Remittance</td>
                        <td>
                            <gw:datebox id="dtRemittance" lang="1" nullaccept />
                        </td>
                        <td colspan="4" align="center">
                            Classification</td>
                    </tr>
                    <tr>
                        <td>
                            Po No.
                        </td>
                        <td>
                            <gw:textbox id="txtPoNo" styles="width:100%" />
                        </td>
                        <td>
                            Total Qty.
                        </td>
                        <td>
                            <gw:textbox id="txtTotalQty" styles="width:100%" type='number'  format="###,###,###"/>
                        </td>
                        <td style="white-space: nowrap">
                            Total Amount
                        </td>
                        <td>
                            <gw:textbox id="txtTotalAmount" styles="width:100%"  type='number'  format="###,###,###"/>
                        </td>
                        <td colspan="4" align="center">
                            <gw:textbox id="txtClassification" styles="width:20%" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="10">
                            <gw:grid id='grdDetail' header='_PK|_tsh_t_neto_t_pk|No|Size|Print|_TCO_ITEM_PK|Product Code|_ITEM_NAME|Quantity|Payment Amount|Sales Price|Currency/US$|Freight Charges|Fees|Insurance|Interest|Printing|_SIZE_CODE'
                                format='0|0|0|0|0|0|0|0|-0|-2|-2|-2|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='|||||||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!------------------------------------------->
<gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
<gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterClose" styles="width:100%; display:none" />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' text="LGPO2001" />
<!---------------------------------------------------------------------------------->
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</html>
