<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>

var G_tco_item_pk       = 0,
    G_Item_Code         = 1,
    G_Item_Name         = 2,
    G_Spec              = 3,
    G_Unit_CD           = 4,
    G_Unit              = 5,
    G_stock             = 6,
    G_lotno             = 7,
    G_testno            = 8,
    
    G_AlterUnit_CD      = 9,
    G_AlterUnit         = 10,
    G_Last_Price        = 17;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
	 BindingDataList();
	// data_shab00010_1.Call("SELECT");
}
//-----------------------------------------------------------------------------------------------
function BindingDataList()
 {    
        var data="";
           
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,GRP_CD||' - '||GRP_NM from  comm.tco_itemgrp where del_if=0 and Mat_yn='Y' order by GRP_NM ")%>|ALL|SELECT ALL";
        lstGroup.SetDataText(data);
        lstGroup.value="ALL";         
 }
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
                 data_shab00010_1.Call("SELECT");
        break;
    }
   
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
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
      var col_val = idGrid2.GetGridData( idGrid2.row, G_tco_item_pk);
    col_val = col_val + idGrid2.GetGridData( idGrid2.row, G_lotno );
    col_val = col_val + idGrid2.GetGridData( idGrid2.row, G_testno );
    
    idGrid2.RemoveRow();
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
    
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      var v_temp = p_oGrid.GetGridData( i, G_tco_item_pk) +  p_oGrid.GetGridData( i, G_lotno ) + p_oGrid.GetGridData( i, G_testno) 
      
      if(v_temp == p_col_val )
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
       var col_val = p_oGrid.GetGridData( i, G_tco_item_pk);
        col_val = col_val + p_oGrid.GetGridData( i, G_lotno );
        col_val = col_val + p_oGrid.GetGridData( i, G_testno );
            
          if(col_val == p_value)
          {
             return true;
          }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "idGrid" && event.row > 0 )
      {
            var col_val = oGrid.GetGridData(event.row, G_tco_item_pk );
            col_val = col_val + oGrid.GetGridData(event.row, G_lotno );
            col_val = col_val + oGrid.GetGridData(event.row, G_testno );            
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
        case 'data_shab00010_1':
            lblRecord2.text = idGrid.rows-1 + " (s)";
        break;
    }
}
//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, G_tco_item_pk);		
		col_val = col_val +  oGrid.GetGridData( row, G_lotno);	
		col_val = col_val +  oGrid.GetGridData( row, G_testno);	
		
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
//================================================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shab00010_1" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_shab00220" > 
                  <input bind="idGrid" > 
                    <input bind="lstGroup" />
                    <input bind="txtItem" />
                    <input bind="txtLotNo" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Group
            </td>
            <td style="width: 25%">
                <gw:list id="lstGroup" styles="width:100%" onchange="OnSearch(1)" csstype="mandatory" />
            </td>
            <td style="width: 5%" align="right">
                Item
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
             <td style="width: 10%" align="right">
                Test No/Lot No
            </td>
            <td style="width: 20%">
                <gw:textbox id="txtLotNo" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
             <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr >
            <td colspan="6" style="width: 14%" align="right">
                <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="7">
                <gw:grid id="idGrid" 
                header="_PK|Item Code|Item Name|Spec|_code|Unit|Stock|Lot No|Test No|_code|Alt Unit|_tco_buspartner_pk|Partner ID|Partner Name|_TAC_ABACCTCODE_PK|Account|Account Name|Last Price" 
                format="0|0|0|0|0|0|-5|0|0|0|0|0|0|0|0|0|0|0|0"
                aligns="0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|3|0" 
                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                widths="0|2000|4000|2000|0|800|1500|1000|1000|0|800|0|0|0|0|0|0|0|0" styles="width:100%; height:100%"
                autosize="T" sorting="T" oncelldblclick="OnGridCellDoubleClick(this)" />               
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
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                            Duplicate
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
                <gw:grid id="idGrid2"  header="_PK|Item Code|Item Name|Spec|_code|Unit|Stock|Lot No|Test No|_code|Alt Unit|_tco_buspartner_pk|Partner ID|Partner Name|_TAC_ABACCTCODE_PK|Account|Account Name|Last Price" 
                format="0|0|0|0|0|0|-5|0|0|0|0|0|0|0|0|0|0|0|0"
                aligns="0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|3|0" 
                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                widths="0|2000|4000|2000|0|800|1500|1000|1000|0|800|0|0|0|0|0|0|0|0" styles="width:100%; height:100%"
                autosize="T" sorting="T"  />   
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
