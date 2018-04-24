<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Product Receipt History</title>
</head>
<%ESysLib.SetUser("inv");%>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">

//-----------------------------------------------------

var flag;

var G1_PK    = 0 ;

//---------------------------------------------------------
var G1_IOTYPE               = 0,
    G1_Date_of_receipt      = 1,   
    G1_TCO_ITEM_PK          = 2, 
    G1_Product_Code         = 3,   
    G1_Product_Name         = 4,
    G1_CAP                  = 5,
    G1_BODY                 = 6,
    G1_Size                 = 7,
    G1_Printing             = 8,
    G1_LOT_No               = 9, 
    G1_Customer_Name        = 10,
    G1_qty_printed          = 11,
    G1_qty_unprinted        = 12,
    G1_MFG_Date             = 13,
    G1_SO_No                = 14,
    G1_Movement_Type        = 15;

//------------------------------------------------------------

//---------------------------------------------------------
var iCodeID = "" ; 
var initFlag = 1;
//-----------------------------------------------------
function BodyInit()
 {
    System.Translate(document);  // Translate to language session   
    data_shpp00020.Call("SELECT"); 
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
    cboCompany.SetDataText(data);
    FormatGrid();
 }
 //---------------------------------------------------------------------------------------------------
 
 function BindingDataList()
 {  
     var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     
     cboCompany.SetDataText(data);
     cboCompany.value="<%=Session["COMPANY_PK"]%>"; 
     //-----------------------
     
     data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>";    
     lstWH.SetDataText(data); 
     //-----------------------          
 }  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    data_shpp00020.Call("SELECT");
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{           
}
//-------------------------------------------------------------------------------------
function FormatGrid()
{
    var ctrl = grdProduct.GetGridControl();   
     
    ctrl.ColFormat(G1_qty_unprinted)    = "###,###,###.##" ; 
    ctrl.ColFormat(G1_qty_printed)    = "###,###,###.##" ;
}
//----------------------------------------------------------------------------------------
</script>

<body>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_shpp00020" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid"  function="prod.sp_sel_shpp00020"   > 
                <input bind="grdProduct">                    
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtCustomer" />
                    <input bind="txtProduct" />
                    <input bind="txtSize" />
                    <input bind="txtColorCap" />
                    <input bind="txtColorBody" />
                    <input bind="rdPrint" />
                </input> 
                <output bind="grdProduct" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Company
                        </td>
                        <td style="width: 35%">
                            <gw:list id="cboCompany" styles="width:100%;" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            Date of Receipt
                        </td>
                        <td>
                            <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
                            ~
                            <gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap">
                            <b>Customer Code</b>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtCustomer" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            <b>Product</b>
                        </td>
                        <td>
                            <gw:textbox id="txtProduct" styles="width: 95%" onenterkey="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <b>Size</b>
                        </td>
                        <td>
                            <gw:textbox id="txtSize" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td>
                            <b>Color Code</b>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtColorCap" styles="width: 20%" onenterkey="OnSearch()" />
                            <gw:textbox id="txtColorBody" styles="width: 20%" onenterkey="OnSearch()" />
                            &nbsp;&nbsp; <b>Printing</b>
                            <gw:radio id="rdPrint" value="All" styles="width:100%; height:100%" onchange="OnSearch()">                   
		                          <span value="Y" id="rd1"><a style="color:red">Y</a></span>                      
		                          <span value="N" id="rd2"><a style="color:Lime">N</a></span>  
		                          <span value="All" id="rd3"><a style="color:Blue">All</a></span> 
    			            </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="10">
                            <%--<gw:grid id='grdProduct' header='Date of Receipt|_IOTYPE|_TCO_ITEM_PK|Product Code|Product Name|CAP|BODY|Size|Printing|LOT No|Customer Name|Q`ty(Printed)|Q`ty(Unprinted)|MFG Date|S/O No|Movement Type'
                                format='4|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|3|3|0|0|0'
                                check='|||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />--%>
                            <gw:grid id='grdProduct' header='_IOTYPE|Date of Receipt|_TCO_ITEM_PK|Product Code|Product Name|CAP|BODY|Size|Printing|LOT No|Customer Name|Q`ty(Printed)|Q`ty(Unprinted)|MFG Date|S/O No|Movement Type'
                                format='0|4|0|0|0|0|0|0|0|0|0|0|0|4|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|3|3|0|0|0'
                                check='|||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:list id="lstWH" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!------------------------------------------->
<gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
<gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterClose" styles="width:100%; display:none" />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' text="LGPO2001" />
<!---------------------------------------------------------------------------------->
</html>
