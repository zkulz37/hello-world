<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hard-Years Product Planning(Receiving-GEL)</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>
var 
   G_PK                       = 0,
   G_BATCH_NO                 = 1,
   G_TSH_COLPACK_M_PK         = 2,
   G_COL_CODE                 = 3,
   G_COLOR_ENG_NAME           = 4, 
   G_PACK_QTY                 = 5, 
   G_PACK_WGT                 = 6, 
   G_MAFG_DATE                = 7, 
   G_PACK_QTY_2               = 8, 
   G_WEIGHT_KG                = 9,
   G_YONGEK_QTY               = 10,
   G_GELATIN_PACK_QTY         = 11, 
   G_BATCH_QTY                = 12,
   G_INST_DATE                = 13;
   
var
    G2_TSH_COLD_D_PK          = 0,
    G2_TCO_ITEM_PK            = 1,
    G2_Malt_Code              = 2,
    G2_Malt_Name              = 3,
    G2_Unit                   = 4,
    G2_Mixing_Ratio           = 5,
    G2_Instructed_Qty         = 6,
    G2_Actual_A               = 7,
    G2_Actual_B               = 8,
    G2_Test_No                = 9,
    G2_TSH_COLP_M_PK          = 10,
    G2_TSH_COLPACK_D_PK       = 11;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    idGrid.AddRow();
    SetHeader();
    OnSearch('1');
    FormatGrid();
}
//-----------------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch(pos) 
    {
        case '1':
            data_shbo00250.Call('SELECT');
        break;
        case '2':
            txtMasterPK.text=idGrid.GetGridData(idGrid.row,G_PK);
            txtColpack_M_PK.text=idGrid.GetGridData(idGrid.row,G_TSH_COLPACK_M_PK);
            data_shbo00250_1.Call('SELECT');
        break;
    }
    
}
//----------------------------------------------------------------------------------------------
function FormatGrid()
 {
      var trl ;
	  trl = grdTest.GetGridControl();
      trl.ColFormat(G2_Mixing_Ratio )      = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Instructed_Qty )    = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Actual_A )              = "###,###,###,###,##0.##0";
      trl.ColFormat(G2_Actual_B )              = "###,###,###,###,##0.##0";
      var trl ;
	  trl = idGrid.GetGridControl();
	  trl.ColFormat(G_PACK_WGT )      = "###,###,###,###,##0.##0";
      trl.ColFormat(G_WEIGHT_KG )    = "###,###,###,###,##0.##0";
      trl.ColFormat(G_BATCH_QTY )    = "###,###,###,###,##0.##0";
      
 }
//-----------------------------------------------------------------------------------------------
function SetHeader()
{
     var fg = idGrid.GetGridControl();             
       idGrid.SetCellBold( 1, 1, 1, G_INST_DATE, true);
       fg.FixedRows = 2
       fg.MergeCells = 5  
        fg.MergeCol(G_BATCH_NO ) = true;
        fg.Cell(0, 0, G_BATCH_NO,1,G_BATCH_NO) = "Batch No";
        fg.MergeCol(G_COL_CODE ) = true;
        fg.Cell(0, 0, G_COL_CODE,1,G_COL_CODE) = "Color Code";
        fg.MergeCol(G_COLOR_ENG_NAME ) = true;
        fg.Cell(0, 0, G_COLOR_ENG_NAME,1,G_COLOR_ENG_NAME) = "Color Name";
        fg.MergeRow(0) = true;
        fg.Cell(0, 0, G_PACK_QTY,0,G_PACK_WGT) = "Instructed Q'ty";
        fg.Cell(0, 1, G_PACK_QTY, 1) = "Q'ty(Packs)";
        fg.Cell(0, 1, G_PACK_WGT, 1) = "Weight(Kg)";
        fg.MergeRow(0) = true;
        fg.Cell(0, 0, G_MAFG_DATE,0,G_WEIGHT_KG) = "Manufactured Q'ty";
        fg.Cell(0, 1, G_MAFG_DATE, 1) = "MFG Date";
        fg.Cell(0, 1, G_PACK_QTY_2, 1) = "Q'ty(Packs)";
        fg.Cell(0, 1, G_WEIGHT_KG, 1) = "Weight(Kg)";
        fg.MergeCol(G_YONGEK_QTY ) = true;
        fg.Cell(0, 0, G_YONGEK_QTY,1,G_YONGEK_QTY) = "Gelatin Q'ty/Pack";
        fg.MergeCol(G_GELATIN_PACK_QTY ) = true;
        fg.Cell(0, 0, G_GELATIN_PACK_QTY,1,G_GELATIN_PACK_QTY) = "Gelatin Q'ty";
        fg.MergeCol(G_BATCH_QTY ) = true;
        fg.Cell(0, 0, G_BATCH_QTY,1,G_BATCH_QTY) = "BATCH Q'ty";
        fg.MergeCol(G_INST_DATE ) = true;
        fg.Cell(0, 0, G_INST_DATE,1,G_INST_DATE) = "Instructed Date";       
}
//-----------------------------------------------------------------------------------------------
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shbo00250':
            SetHeader();
            if(flag=="update")
            {
                data_shbo00250_1.Call();
                flag="";
            }
            else
            {
                data_shbo00250_1.Call("SELECT");
            }
        break;
        case'data_shbo00250_1':
            grdTest.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
        break;
    }
}
//----------------------------------------------------------------------------------------------
function Calculate(pos)
{
    switch(pos)
    {
        case'1':
            var col=event.col;
            var row=event.row;
            if(col==G_PACK_QTY_2)
            {
                var a= idGrid.GetGridData(row,G_PACK_QTY_2)*idGrid.GetGridData(row,G_PACK_WGT);
                idGrid.SetGridText(row,G_WEIGHT_KG,a);
            }
            
        break;
        case'2':
            var col=event.col;
            var row=event.row;
            if(col==G2_Actual_A||col==G2_Actual_B)
            {
                grdTest.Subtotal( 0, 2, -1, '5!6!7!8','###,###,##0.##0');
            }
        break;
    }
    
}
//---------------------------------------------------------------------------------
var flag="";
function OnSave()
{
    flag="update";
	data_shbo00250.Call();
}
//======================================================================
</script>
<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shbo00250" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shbo00250" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" procedure="prod.sp_upd_shbo00250" > 
                  <input bind="idGrid" > 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtColorCode" />
                    <input bind="txtBatchNo" />
                    <input bind="rdClass" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_shbo00250_1" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shbo00250_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11" procedure="prod.sp_upd_shbo00250_1" > 
                  <input bind="grdTest" > 
                    <input bind="txtMasterPK" />
                    <input bind="txtColpack_M_PK" />
                  </input> 
                <output bind="grdTest" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 5%">
            <td style="width: 10%" align="right">
                Period
            </td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch('1')" />
                ~
                <gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch('1')" />
            </td>
            <td style="width: 10%; white-space: nowrap" align="right">
                Class
            </td>
            <td style="width: 30%">
                <gw:radio id="rdClass" value="Y" styles="width:100%; height:100%" onchange="OnSearch('1')">                   
		             <span value="N" id="rd1">Instructed</span>                     
		             <span value="Y" id="rd2">Completed</span>  
    			</gw:radio>
            </td>
            <td style="width: 10%" align="right">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSave" img="save" alt="Search" onclick="OnSave()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('1')" />
            </td>
        </tr>
        <tr>
            <td style="width: 10%; white-space: nowrap" align="right">
                <b>Color Code</b>
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtColorCode" styles='width:50%' onenterkey="OnSearch('1')" />
            </td>
            <td style="width: 10%" align="right">
                Batch No
            </td>
            <td style="width: 30%">
                <gw:textbox id="txtBatchNo" styles='width:100%' onenterkey="OnSearch('1')" />
            </td>
        </tr>
        <tr style="height: 50%">
            <td colspan="7">
                <gw:grid id='idGrid' header='_PK|BATCH_NO|_TSH_COLPACK_M_PK|COL_CODE|COLOR_ENG_NAME|PACK_QTY|PACK_WGT|MAFG_DATE|PACK_QTY|WEIGHT_KG|YONGEK_QTY|GELATIN_PACK_QTY|BATCH_QTY|INST_DATE'
                    format='0|0|0|0|0|0|0|4|0|0|0|0|0|4' aligns='0|0|0|0|0|3|3|3|3|3|3|3|3|3' check='|||||||n||||||'
                    editcol='0|0|0|0|0|0|0|1|1||0|0|0|0' widths='1500|1500|1500|1000|2000|1500|1500|1500|1500|1500|1700|1500|1500|1500'
                    sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('2')" acceptnulldate='T'onafteredit="Calculate('1')"/>
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="7">
                <gw:grid id='grdTest' header='_TSH_COLD_D_PK|_TCO_ITEM_PK|Malt Code|Malt Name|Unit|Mixing Ratio(%)|Instructed Qty|Actual Qty A(g)|Actual Qty B(g)|Test No|_TSH_COLP_M_PK|_TSH_COLPACK_D_PK'
                    format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|1|3|3|3|3|0|0|0' check='|||||||n|n|||'
                    editcol='0|0|0|0|0|0|0|1|1|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%'onafteredit="Calculate('2')" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtColpack_M_PK" styles="width: 100%;display:none" />
</html>
