<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>STOCK CLOSING</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script language="javascript" type="text/javascript">
//-----------------------------------------------------

var flag;

var G_PK    = 0 ;
//---------------------------------------------------------
var G1_DETAIL_PK    = 0, 
    G1_MASTER_PK    = 1,    
    G1_ITEM_PK      = 2,
    G1_ITEM_CODE    = 3
    G1_ITEM_NAME    = 4,
    G1_UOM          = 5,
    G1_LOT_NO       = 6,
    G1_BEGIN_QTY    = 7
    G1_IN_QTY       = 8,
    G1_SALE_QTY     = 9,   
    G1_ADJUST_QTY   = 10,
    G1_OUT_QTY      = 11
    G1_END_QTY      = 12,
    G1_REMARK       = 13;
    
    var arr_FormatNumber = new Array();

//===================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//===================================================================================

function BodyInit()
{  
    System.Translate(document);  // Translate to language session    
    
    //----------  
    txtChargerName.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    
    BindingDataList();    
    //----------------------------
 }
 
 //======================================================================================
 
 function BindingDataList()
 {  
     var data ;
     
     data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM tlg_in_warehouse  WHERE del_if = 0 and use_yn = 'Y' and wh_type='CL' ORDER BY wh_name  ASC" )%>";    
     lstWarehouse.SetDataText(data);
     
     data = data + '||' ;
     lstWHSearch.SetDataText(data);
     lstWHSearch.value = '' ;      
     //-----------------------  
                           
 }
//=====================================================================================
function OnReport()
{
    if(txtMasterPK.text!="")
    {
//        var url =System.RootURL + '/reports/bi/sa/rpt_bisa00100.aspx?Master_pk='+txtMasterPK.text;
//        window.open(url); 
        
        var url = System.RootURL + "/system/ReportEngine.aspx?file=bi/sa/rpt_bisa00100.rpt&export_pdf=Y&procedure=<%=l_user%>lg_rpt_bisa00100&parameter=" + txtMasterPK.text ;              
	    System.OpenTargetPage(url); 
    }
    else
    {
        alert("Please Select Lotno");
    }
       
}  
//=====================================================================================
function OnProcess(pos)
{
     switch(pos)
     {
        case 'LoadData' :
            if ( confirm('Do you want to close data.') )
            {
                if(lstWarehouse.value != "")
                {
                txtChargerPK.text = "<%=Session["EMPLOYEE_PK"]%>" ;
                pro_bisa00100.Call();
                }else
                {
                    alert('Please select Warehouse first!')
                }
            }    
        break;
        
        case 'Release' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to release data.') )
                {
                    pro_bisa00100_2.Call();
                }
            }
            else
            {
                alert('Pls select data');
            }                     
        break;   
        
        case 'Approve':
            if ( txtMasterPK.text != '' )
            {
                pro_bisa00100_1.Call();
            }
            else
            {
                alert('Pls select data');
            }    
        break;
        
         case 'Cancel':
            if ( txtMasterPK.text != '' )
            {
                pro_bisa00100_3.Call();
            }
            else
            {
                alert('Pls select data');
            }    
        break;
        case 'CloseMat':
             if ( txtMasterPK.text != '' && lbStatus.text =='APPROVED' )
            {
                pro_bisa00100_4.Call()
            }else
            {
                alert('Pls select data');
            } 
        break;
             
     }
}

//=====================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_bisa000100.Call("SELECT");
        break;
    
        case 'Master':
            if ( grdVouchers.row > 0 )
            {
                txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
            }
            
            data_bisa00100_1.Call("SELECT");
        break;
        
        case 'grdDetail':            
            data_bisa00100_2.Call("SELECT");
        break;
    }
}

//===============================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_bisa00100_1": 
            OnSearch('grdDetail');                
        break;

        case "data_bisa00100_2":            
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBold( 1, G1_BEGIN_QTY, grdDetail.rows - 1, G1_BEGIN_QTY, true);	
                grdDetail.SetCellBold( 1, G1_IN_QTY,    grdDetail.rows - 1, G1_IN_QTY,    true);
                grdDetail.SetCellBold( 1, G1_SALE_QTY,  grdDetail.rows - 1, G1_SALE_QTY,   true);
                grdDetail.SetCellBold( 1, G1_ADJUST_QTY,grdDetail.rows - 1, G1_ADJUST_QTY,   true);
                grdDetail.SetCellBold( 1, G1_OUT_QTY,   grdDetail.rows - 1, G1_OUT_QTY,   true);
                grdDetail.SetCellBold( 1, G1_END_QTY,   grdDetail.rows - 1, G1_END_QTY,   true);
                grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);
                
                grdDetail.SetCellBgColor( 1, G1_SALE_QTY , grdDetail.rows - 1, G1_SALE_QTY , 0xCCFFFF );	
                grdDetail.SetCellBgColor( 1, G1_ADJUST_QTY , grdDetail.rows - 1, G1_ADJUST_QTY , 0xCCFFFF );		
            }    
            //----------------------                
        break;
        
        case 'pro_bisa00100':
			OnSearch('grdDetail');
		break;
		
        case 'pro_bisa00100_2':
            alert(txtReturnValue.text);
            
			OnSearch('Master');
		break;	
		
        case 'pro_bisa00100_1':
            alert(txtReturnValue.text);
            
			OnSearch('Master');
		break;	
		
		 case 'pro_bisa00100_3':
            alert(txtReturnValue.text);
            
			OnSearch('Master');
		break;		
		case 'pro_bisa00100_4':
		    alert(txtReturnValue.text);
		break ;					
   }            
}

//===================================================================================
function OnSave()
{
    if ( txtMasterPK.text != '' )
    {
        data_bisa00100_2.Call();        
    }
    else
    {
        alert('Pls select data first.');
    }
} 

//=================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_SALE_QTY || col == G1_ADJUST_QTY )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
         var qty_begin = Number(grdDetail.GetGridData(grdDetail.row,G1_BEGIN_QTY));
         var qty_in    = Number(grdDetail.GetGridData(grdDetail.row,G1_IN_QTY));
                         
        if (Number(dQuantiy))
        {   
             if(col == G1_SALE_QTY && dQuantiy < 0)
            {
                alert(" Sale qty must be greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
           
        }
        else
       {
            grdDetail.SetGridText(row,col,"") ;
       } 
         var qty_sale    = Number(grdDetail.GetGridData(grdDetail.row,G1_SALE_QTY));
        var qty_ad    = Number(grdDetail.GetGridData(grdDetail.row,G1_ADJUST_QTY));
        if(!Number(qty_sale))
        {
            qty_sale = 0
        }
        if(!Number(qty_ad))
        {
            qty_ad = 0
        }
        grdDetail.SetGridText(grdDetail.row,G1_OUT_QTY,qty_sale+qty_ad);
        grdDetail.SetGridText(grdDetail.row,G1_END_QTY,qty_begin+qty_in-(qty_sale+qty_ad)); 
        //----------------------Calculate Amount -----
    }      
}

//===================================================================================

</script>

<body>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_bisa000100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="<%=l_user%>lg_sel_bisa00100" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWHSearch" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bisa00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_bisa00100_1"  > 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstWarehouse" />   
                     <inout  bind="dtStockDate" />                                            
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="lbStatus" />                                       
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_bisa00100_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="<%=l_user%>lg_sel_bisa00100_2" procedure="<%=l_user%>lg_upd_bisa00100_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bisa00100" > 
                <input>
                     <input bind="lstWarehouse" />
                     <input bind="dtStockDate" />
					 <input bind="txtChargerPK" />
                </input> 
                <output> 
                    <output bind="txtMasterPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bisa00100_1" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00100_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bisa00100_3" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00100_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bisa00100_2" > 
                <input>
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00100_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_bisa00100_4" > 
                <input>
                     <input bind="lstWarehouse" />
                     <input bind="dtStockDate" />
                     <input bind="txtChargerPK" />
                     <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="width: 89%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            W/H
                        </td>
                        <td colspan="2">
                            <gw:list id="lstWHSearch" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Status|W/H" format="0|4|0|0" aligns="0|1|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1200|1000|1000" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2,3" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="background-color: #B4E7FF" colspan="11">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 1%">
                                        <gw:icon id="btnRelease" img="2" text="Release" alt="Release Closing Data" styles='width:100%'
                                            onclick="OnProcess('Release')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="btnLoadData" img="2" text="Load Ending Stock" alt="Load Closing Data"
                                            styles='width:100%' onclick="OnProcess('LoadData')" />
                                    </td>
                                    <td style="width: 96%">
                                    </td>
                                  
                                    <td style="width: 1%">
                                        <gw:imgbtn id="ibtnReport" img="excel" alt="Report" text="Report" onclick="OnReport()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />                                        
                                    </td>
                                      <td style="width: 1%">
                                        <gw:icon id="btnApprove" img="2" text="Approve" alt="Approve" styles='width:100%' onclick="OnProcess('Approve')" />
                                    </td>
                                      <td style="width: 1%">
                                        <gw:icon id="btnCancel" img="2" text="Cancel Approve" alt="Cancel" styles='width:100%' onclick="OnProcess('Cancel')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 5%">
                            W/H
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstWarehouse" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Stock Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtStockDate" lang="1" />
                        </td>
                        <td align="right" style="width: 5%">
                            Charger
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="center">
                            <gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt;align:center' text='-' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 5%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                style="cursor: hand" onclick="OnToggle()" /></td>
                        <td colspan="5">
                        </td>
                       <td style="width: 1%">
                            <gw:icon id="btnMatClose" img="2" text="Close Material" alt="Close Material" styles='width:100%' onclick="OnProcess('CloseMat')" />
                       </td>                       
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="7">
                            <gw:grid id='grdDetail' header='_PK|_SA_STOCK_CLOSING_M_PK|_TCO_ITEM_PK|Item Code|Item Name|UOM|Lot No|Begin Qty|In Qty|Sale Qty|Adjust Qty|Cons Qty|End Qty|Remark'
                                format='0|0|0|0|0|0|0|1|1|1|1|1|1|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='|||||||||n|n|||' editcol='0|0|0|0|0|0|0|0|0|1|1|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit="CheckInput()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" />
<!---------------------------------------------------------------------------------->
</html>
