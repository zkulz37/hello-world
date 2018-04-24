<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP : PROD RESULT ENTRY</title>
</head>
<%ESysLib.SetUser("stm");%>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">

//-----------------------------------------------------

var flag;

var G1_PK    = 0 ;

//---------------------------------------------------------
var G2_PK                   = 0 ,
    G2_P_TST_PRODRESULT_PK  = 1 ,
    G2_TST_ORDERD_PK        = 2 ,
    G2_Order_ID             = 3 ,
    G2_Style_ID             = 4 ,
    G2_Style                = 5 ,
    G2_Color_ID             = 6 ,
    G2_Color_Name           = 7 ,
    G2_Size                 = 8 ,
    G2_Ord_Qty              = 9 ,
    G2_Previous_qty         = 10 ,
    G2_Prod_Qty             = 11 ,
    G2_Adjust_Qty           = 12 ,
    G2_Balance_Qty          = 13 ,
    G2_Defect_Qty           = 14 ,
    G2_Description          = 15 ; 
    
//---------------------------------------------------------
var iCodeID = "" ; 

//-----------------------------------------------------

function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
    
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    
    BindingDataList();   
    FormatGrid(); 
    //----------------------------
 }
 //---------------------------------------------------------------------------------------------------
 
 function FormatGrid()
 {
      var trl ;
      
      trl = grdTakeinItems.GetGridControl();
      	
      trl.ColFormat(G2_Ord_Qty )          = "###,###,###,###,###";
      trl.ColFormat(G2_Previous_qty)      = "###,###,###,###,###";
      trl.ColFormat(G2_Prod_Qty)          = "###,###,###,###,###";
      trl.ColFormat(G2_Adjust_Qty)        = "###,###,###,###,###";
      trl.ColFormat(G2_Balance_Qty)       = "###,###,###,###,###";
      trl.ColFormat(G2_Defect_Qty)        = "###,###,###,###,###";
 }
 
   //---------------------------------------------------------


 function BindingDataList()
 {  
     var data ;   
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('WS001','','') FROM DUAL" )%>";    
     lstWorkShift.SetDataText(data);
     
     data = "<%=ESysLib.SetListDataSQL("SELECT   pk, line_name FROM stm.tst_line WHERE del_if = 0 ORDER BY line_name" )%>|ALL|Select ALL";    
     lstLine.SetDataText(data);  
     lstLine.value = 'ALL' ; 

     data = "<%=ESysLib.SetListDataSQL("SELECT   pk, line_name FROM stm.tst_line WHERE del_if = 0 ORDER BY line_name" )%>";         
     lstLineResult.SetDataText(data);       
     
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   pk, line_name FROM stm.tst_line WHERE del_if = 0 ORDER BY line_name " ) %> ";       
     grdVouchers.SetComboFormat(2,data);         
     //-----------------------          
 }

 //---------------------------------------------------------------------------------------------------
  
function OnNew()
{
    data_ippr0010_1.StatusInsert();
    btnSave.SetEnable(true);
    //------------------------------------------- 
    grdTakeinItems.ClearData();
    
    flag="view"; 
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_ippr0010.Call("SELECT");
        break;
    
        case 'data_ippr0010_1':
        
            if ( data_ippr0010_1.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('data_ippr0010_1');
                }
                else
                {
                    if ( grdVouchers.row > 0 )
                    {
                        txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                    }
                    flag = 'view' ;
                    data_ippr0010_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdVouchers.row > 0 )
                {
                    txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                }
                flag = 'view' ;
                data_ippr0010_1.Call("SELECT");
            }                               
        break;
        
        case 'grdTakeinItems':            
            data_ippr0010_2.Call("SELECT");
        break;
    }
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_ippr0010_1": 
            //-------------------        
            if ( flag == "save" )
            {
               for (var i = 1; i<grdTakeinItems.rows; i++)   
               {
                    if ( grdTakeinItems.GetGridData( i, G2_P_TST_PRODRESULT_PK) == '' )
                    {
                        grdTakeinItems.SetGridText(i, G2_P_TST_PRODRESULT_PK,  txtMasterPK.GetData()); 
                    }     
               }                                     
               //---------------------   
               OnSave('data_ippr0010_2');                
            }
            else
            {                
                //---------------------------- 
                OnSearch('grdTakeinItems');
                  
            }                 
        break;

        case "data_ippr0010_2":
            if ( flag != 'view' ) 
            {
                OnSearch('grdVouchers');
            }                  
        break;
 
        case "pro_ippr0010":
            alert(txtReturnValue.text);
        break;        
   }            
}

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {       
        case 'SOITEM':
             var path = System.RootURL + '/form/ip/wi/ipwi0011.aspx?line_pk='+ lstLineResult.value;
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                            
                        grdTakeinItems.AddRow();  
                       
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_P_TST_PRODRESULT_PK, txtMasterPK.text); //master_pk	    	                                               
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_TST_ORDERD_PK,    arrTemp[7]);
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Order_ID,         arrTemp[1]);
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Style_ID,         arrTemp[2]);
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Style,            arrTemp[3]);
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Color_ID,         arrTemp[4]);   
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Color_Name,       arrTemp[5]);	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Size,             arrTemp[6]);  
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Ord_Qty,          arrTemp[8]);
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Previous_qty,     arrTemp[9]);  
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Balance_Qty,      arrTemp[10]);
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G2_Prod_Qty,         Number(arrTemp[8]) - Number(arrTemp[10]) );                           
                        
                    }		            
             }        
        break;                                      
    }	       
}

//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'data_ippr0010_1':
            if( Validate() )
            {
                data_ippr0010_1.Call();
                flag='save';
            }            
        break;
        case 'data_ippr0010_2':        
            data_ippr0010_2.Call();
        break;
    }
}

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Voucher':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_ippr0010_1.StatusDelete();
                data_ippr0010_1.Call();
            }   
        break;

        case 'GridItem':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdTakeinItems.GetGridData( grdTakeinItems.row,  G2_PK ) == '' )
                {
                    grdTakeinItems.RemoveRow();
                }
                else
                {   
                    grdTakeinItems.DeleteRow();
                }    
            }            
        break;            

    }     
}
 //------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              
     grdTakeinItems.UnDeleteRow();
}

//-------------------------------------------------------------------------------------
function Validate()
{   
    //---------------
    for( var i = 1; i < grdTakeinItems.rows; i++)
    {
        //---------------
        if ( Number(grdTakeinItems.GetGridData(i,G2_Prod_Qty)) <= 0 )
        {
            alert("Input correct take in Qty. at " + i + ",pls!")
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
    
    if ( col == G2_Prod_Qty || col == G2_Defect_Qty || col == G2_Adjust_Qty )
    {
        var dQuantiy ;
        
        dQuantiy =  grdTakeinItems.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy > 0 )
            {
                grdTakeinItems.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(0));
            }
            else if ( col == G2_Adjust_Qty )
            {
                grdTakeinItems.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(0));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdTakeinItems.SetGridText( row, col, "");
            }
        }
        else
        {
            grdTakeinItems.SetGridText(row,col,"") ;
        }     
    }
    //----------------------
}

//----------------------------------------------------------------------------------------
</script>

<body>  
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_ippr0010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2" function="stm.sp_sel_ippr0010" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstLine" /> 
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_ippr0010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4" function="stm.sp_sel_ippr0010_1"  procedure="stm.sp_upd_ippr0010_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtVoucherDate" />                          
                     <inout  bind="lstWorkShift" />
                     <inout  bind="lstLineResult" />
                     <inout  bind="txtRemark" />                    
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_ippr0010_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="stm.sp_sel_ippr0010_2"   procedure="stm.sp_upd_ippr0010_2"> 
                <input bind="grdTakeinItems">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdTakeinItems" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 20%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 20%">
                            Date</td>
                        <td style="width: 79%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%">
                            Line</td>
                        <td style="width: 80%" colspan="2">
                            <gw:list id="lstLine" styles='width:100%' />
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Line" format="0|4|0" aligns="0|1|0" defaults="||"
                                editcol="0|0|0" widths="0|1200|1200" styles="width:100%; height:100%" sorting="T"
                                param="0,1,2" oncellclick="OnSearch('data_ippr0010_1')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 80%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            Date
                        </td>
                        <td style="width: 25%">
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                        <td align="right" style="width: 10%">
                            Work Shift
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstWorkShift" styles='width:100%' />
                        </td>
                        <td align="right" style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 2%" align="right">                          
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Voucher')" />
                        </td>
                        <td style="width: 2%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('data_ippr0010_1')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            Line
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstLineResult" styles='width:100%' />
                        </td>
                        <td align="right" style="width: 10%">
                            Remark
                        </td>
                        <td colspan="8">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 10%" align="right">
                        </td>
                        <td colspan="3">
                        </td>
                        <td align="right">
                        </td>
                        <td align="center">
                        </td>
                        <td>
                        </td>
                        <td align="right">
                        </td>
                        <td align="right">
                            <gw:imgbtn id="btnGetSOItem" img="popup" alt="Get item from SO" text="Get Item from SO"
                                onclick="OnPopUp('SOITEM')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('GridItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="11">
                            <gw:grid id='grdTakeinItems' 
                                header='_PK|_P_TST_PRODRESULT_PK|_TST_ORDERD_PK|Order ID|Style ID|Style|Color ID|Color Name|Size|Ord_Qty|Previous Qty|Daily Qty|Adjust Qty|Balance Qty|Defect Qty|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|3|3|3|3|3|0' defaults='||||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|1|1|1|1' widths='1000|1000|1000|1500|1200|1200|1200|1200|1200|1500|1500|1500|1500|1500|1000'
                                sorting='T' onafteredit="CheckInput()" styles='width:100%; height:100%' />
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
</html>
