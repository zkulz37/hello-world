<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hard-Years Product Planning(Receiving-GEL)</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>
var 
   l_pk                 = 0,
   p_D_YYMM            = 1,
   p_mon               = 2,
   p_SAL_DIV           = 3,
   p_SIZE_CODE           = 4, 
   p_ORD_QTY             = 5, 
   p_ORD_AMT             = 6, 
   p_SAL_QTY             = 7, 
   p_SAL_AMT             = 8, 
   p_PREV_QTY            = 9,
   p_PREV_AMT            = 10,
   p_RES_QTY             = 11, 
   p_RES_AMT             = 12;
    
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    BindingDataList()
    idGrid.AddRow();
    SetHeader()
    OnSearch()
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{ 
    data_shco00010.Call('SELECT')
}
//-----------------------------------------------------------------------------------------------
function SetHeader()
{
     var fg = idGrid.GetGridControl();             
       idGrid.SetCellBold( 1, 1, 1, p_RES_AMT, true);
       fg.FixedRows = 2
       fg.MergeCells = 5  
      
        fg.MergeRow(0) = true
        fg.Cell(0, 0, p_mon,0, p_SAL_AMT) = "Target";
        fg.Cell(0, 1, p_mon, 1) = "Month";
        fg.Cell(0, 1, p_ORD_QTY, 1) = "Order Q'ty";
        fg.Cell(0, 1, p_ORD_AMT, 1) = "Order Amt";
        fg.Cell(0, 1, p_SAL_QTY, 1) = "Delivery Q'ty";
        fg.Cell(0, 1, p_SAL_AMT, 1) = "Delivery Amt";
        
        fg.Cell(0, 0, p_PREV_QTY,0, p_RES_AMT) = "Results of Previous Year";
        fg.Cell(0, 1, p_PREV_QTY, 1) = "Order Q'ty";
        fg.Cell(0, 1, p_PREV_AMT, 1) = "Order Amt";
        fg.Cell(0, 1, p_RES_QTY, 1) = "Delivery Q'ty";
        fg.Cell(0, 1, p_RES_AMT, 1) = "Delivery Amt"; 
       
}
//-----------------------------------------------------------------------------------------------
 function BindingDataList()
 { 
    var data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE||' - '||a.CODE_NM FROM Sale.LG_CODE a, Sale.LG_CODE_GROUP b WHERE  b.GROUP_ID='LGMF0020' AND a.LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>"
    lstSize.SetDataText(data);
    data = "<%=ESysLib.SetListDataFUNC("SELECT comm.f_logistic_code('LGMF0090') FROM DUAL" )%>";    
    lstOrdType.SetDataText(data);
      
 }
//-----------------------------------------------------------------------------------------------
function OnSave()
{
    for (var i = 2; i< idGrid.rows-1 ; i++)
    {
        if(idGrid.GetGridData(i,l_pk) =="")
        {
            idGrid.SetRowStatus(i,48);
        }
    }
	 data_shco00010.Call()
}

//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shco00010':
            SetHeader()
            idGrid.SetCellBgColor( 2, p_PREV_QTY , idGrid.rows - 1, p_RES_AMT , 0xCCFFFF );
            idGrid.Subtotal( 0, 2, -1, '5!6!7!8!9!10!11!12','###,###,##0');  
        break;
    }
}
//================================================================================================
function CalTotal()
{
   var v_row = event.row;
   var v_amt = 0;
   if(isNaN(idGrid.GetGridData(v_row,p_ORD_QTY)+"") == false )
     {
        v_amt = Number(txtUnitPrice.text) * Number(idGrid.GetGridData(v_row,p_ORD_QTY))
        idGrid.SetGridText(v_row,p_ORD_AMT,v_amt)
     }
     if(isNaN(idGrid.GetGridData(v_row,p_SAL_QTY)+"") == false )
     {
        v_amt = Number(txtUnitPrice.text) * Number(idGrid.GetGridData(v_row,p_SAL_QTY))
        idGrid.SetGridText(v_row,p_SAL_AMT,v_amt)
     }
    idGrid.Subtotal( 0, 2, -1, '5!6!7!8!9!10!11!12','###,###,##0'); 
}
//================================================================================================

function OnEnterUP()
{
    var v_amt=0;
    for(var i =2 ; i< idGrid.rows -1; i ++ )
   {
     if(isNaN(idGrid.GetGridData(i,p_ORD_QTY)+"") == false )
     {
        v_amt = Number(txtUnitPrice.text) * Number(idGrid.GetGridData(i,p_ORD_QTY))
        idGrid.SetGridText(i,p_ORD_AMT,v_amt)
     }
     if(isNaN(idGrid.GetGridData(i,p_SAL_QTY)+"") == false )
     {
        v_amt = Number(txtUnitPrice.text) * Number(idGrid.GetGridData(i,p_SAL_QTY))
        idGrid.SetGridText(i,p_SAL_AMT,v_amt)
     }
   }
   idGrid.Subtotal( 0, 2, -1, '5!6!7!8!9!10!11!12','###,###,##0'); 
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shco00010" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="SALE.sp_sel_shco00010" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" procedure = "sale.sp_upd_shco00010" > 
                  <input bind="idGrid" > 
                    <input bind="dtYear" />
                    <input bind="lstOrdType" />
                    <input bind="lstSize" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" >
        <tr style="height: 5%">
            <td style="width: 10%" align="right">
                Year
            </td>
            <td style="width: 30%">
                <gw:datebox id="dtYear" lang="1" styles="width:100%" type='year' onclick="OnSearch()" />
            </td>
            <td style="width: 10%; white-space: nowrap" align="right">
                <b>Sales Type</b>
            </td>
            <td style="width: 30%">
                <gw:list id="lstOrdType" styles='width:100%' onchange="OnSearch()" />
            </td>
            <td style="width: 10%" align="right">
                
            </td>
           <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSave" img="save" alt="Search" onclick="OnSave()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr>
              <td style="width: 10%" align="right">
                Size
            </td>
            <td style="width: 30%">
                <gw:list id="lstSize" styles='width:100%' onchange="OnSearch()" />
            </td>
            <td style="width: 10%; white-space: nowrap" align="right">
               Unit Price
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtUnitPrice"  styles='width:100%' type='number'  format="###,###,###.##R" onenterkey="OnEnterUP()" onBlur="OnEnterUP()"/>
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="7">
               <gw:grid id='idGrid'
                header='_PK|_D_YYMM|MON|_SAL_DIV|_SIZE_CODE|ORD QTY|ORD AMT|SAL QTY|SAL AMT|ORD QTY|ORD AMT|RES QTY|RES AMT'
                format='0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                check='||||||||||||'
                editcol='0|0|0|0|0|1|1|1|1|0|0|1|1'
                widths='0|0|0|0|800|1500|1500|1500|1500|1500|1500|1500|1500'
                sorting='T'
                onafteredit="CalTotal()"
                styles='width:100%; height:100%'
                />
               
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
