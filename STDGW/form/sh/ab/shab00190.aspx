<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Sale Order</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>

var G_pk                        = 0,
    G_order_no                  = 1,
    G_release_date              = 2,
    G_tco_item_pk               = 3,
    G_product_code              = 4,
    G_product_name              = 5,
    G_sale_type                 = 6,
    G_release_inst_qty          = 7,
    G_release_qty               = 8,
    G_unit_price                = 9,
    G_Amount                    = 10,
    G_vat_amount                = 11;
    
var G1_pk                        = 0,
    G1_order_no                  = 1,
    G1_release_date              = 2,
    G1_tco_item_pk               = 3,
    G1_product_code              = 4,
    G1_product_name              = 5,
    G1_sale_type                 = 6,
    G1_release_inst_qty          = 7,
    G1_release_qty               = 8,
    G1_unit_price                = 9,
    G1_Amount                    = 10,
    G1_vat_amount                = 11;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    data_shab00190.Call("SELECT");
     FormatGrid();
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{ 
    data_shab00190.Call("SELECT");
}
//-----------------------------------------------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(oGrid.rows > 1)
   {   
      for(var i=1;i<oGrid.rows;i++)
      {
         var arrTemp=new Array();
         
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
         }
         
         arr_data[arr_data.length]= arrTemp;
      }
      
	  if ( arr_data !=null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, 0);		
		
        if ( row > 0 && ( !CheckDataExist( idGrid2, col_val)) )
        {
            SetRowBackGroundColor( oGrid, col_val, 0x0000FF);
            
	        idGrid2.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            idGrid2.SetGridText( idGrid2.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }		
	}
    
    countItem(); 
}
function CheckDataExist(p_oGrid,p_value)
{
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, 0) == p_value)
              {
                 return true;
              }
       }
       return false;
}
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, 0 );
            
            if(event.row > 0 && ( !CheckDataExist(idGrid2,col_val)) )
            {
                SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		        idGrid2.AddRow();
		        for(var i=0;i<oGrid.cols;i++)
		        {
		          idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
		        }
            }
      }
      countItem()
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, 0);
    
    idGrid2.RemoveRowAt(idGrid2.row);
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
    
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, G_tco_item_pk) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_shab00190':
            lblRecord2.text = idGrid.rows-1 + " Item(s)";
        break;
    }
}
//=====================================================================
function FormatGrid()
{
    var ctrl = idGrid.GetGridControl();   
     
    ctrl.ColFormat(11)    = "###,###,###.##" ;
    ctrl.ColFormat(10)    = "###,###,###.##" ;
    ctrl.ColFormat(9)    = "###,###,###.##" ;
    ctrl.ColFormat(8)     = "###,###,###.##" ;
    ctrl.ColFormat(7)     = "###,###,###.##" ;
    
    //---------------------
    var ctrl = idGrid2.GetGridControl();   
     
    ctrl.ColFormat(11)    = "###,###,###.##" ;
    ctrl.ColFormat(10)    = "###,###,###.##" ;
    ctrl.ColFormat(9)    = "###,###,###.##" ;
    ctrl.ColFormat(8)     = "###,###,###.##" ;
    ctrl.ColFormat(7)     = "###,###,###.##" ;   
}
//================================================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shab00190" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function=" sale.sp_sel_shab00190" > 
                  <input bind="idGrid" > 
                    <input bind="txtOrderNo" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                Order No
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtOrderNo" styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Delivery Date
            </td>
            <td style="width: 25%">
                <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch()"/>
                ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch()"/>
            </td>
            <td style="width: 1%" align="right">
            </td>
            <td style="width: 1%">
            </td>
            <td style="width: 14%" align="center">
                <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="7">
                <gw:grid id='idGrid' header='_PK|Order No|Release Date|_TCO_ITEM_PK|Product Code|Product Name|Sales Type|Release Inst Qty|Release Qty|Unit Price|Amount|VAT Amount'
                    format='0|0|4|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|1|3|3|3|3|3' check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="7">
                <table>
                    <tr>
                        <td style="width: 96%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="7">
                <gw:grid id='idGrid2' header='_PK|Order No|Release Date|_TCO_ITEM_PK|Product Code|Product Name|Sales Type|Release Inst Qty|Release Qty|Unit Price|Amount|VAT Amount'
                    format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|2|3|3|3|3|3' check='|||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPro_YN" styles="width:100%;display:none" />
    <!---------------------------------------------------------------->
</body>
</html>
