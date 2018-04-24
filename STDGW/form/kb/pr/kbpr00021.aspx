<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Stock</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G1_ITEM_LOT_NO = 0,
    G1_WH_PK       = 1,
    G1_WH_Name     = 2,
    G1_ITEM_PK     = 3,
    G1_ITEM_CODE   = 4,
    G1_ITEM_NAME   = 5,
    G1_UOM         = 6,
    G1_STOCK_QTY   = 7,
    G1_LOT_NO      = 8;  
    
var G_ITEM_LOT_NO = 0,
    G_WH_PK       = 1,
    G_WH_Name     = 2,
    G_ITEM_PK     = 3,
    G_ITEM_CODE   = 4,
    G_ITEM_NAME   = 5,
    G_UOM         = 6,
    G_STOCK_QTY   = 7,
    G_Select      = 8,
    G_Balance     = 9,
    G_LOT_NO      = 10;  
//-------------------------------------------

function BodyInit()
{
	System.Translate(document);
	//-------------------------
	var p_group_type = "<%=Request.querystring("group_type")%>";
	var p_warehouse = "<%=Request.querystring("warehouse")%>";
	
    var data = "";  
    
    data = "data|VIE|VIE|ENG|ENG|KOR|KOR";
    lstLang1.SetDataText(data);      
    lstLang1.value = "<%=Session("SESSION_LANG")%>";
    
    data = "<%=ESysLib.SetListDataSQLPara("select pk, grp_cd || ' - ' || grp_nm from tlg_it_itemgrp where del_if = 0 and use_yn='Y' and leaf_yn = 'Y' and ( SALE_YN ={0} or PUR_YN ={1} or  PROD_YN ={2} or  SEMI_PROD_YN ={3} or MAT_YN ={4} or SUB_MAT_YN ={5}) order by grp_cd ", Request.querystring("group_type")) %>||";     
    lstGroup.SetDataText(data);
    lstGroup.value = '';
    
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id || ' * ' || wh_name  FROM tlg_in_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>||";    
    lstWH.SetDataText(data);     
    lstWH.value = '';
    
    
    if(p_warehouse!="")
	{
	    lstWH.value = p_warehouse;
	}
	
    var group_pk = "<%=request.QueryString("group_pk")%>";
    
    if ( Number(group_pk) > 0 )
    {
        lstGroup.value = group_pk ;
        lstGroup.SetEnable(false);
    }    
	//----------------------------------
	OnFormatGrid();
}

var arr_FormatNumber = new Array(); 
//======================================================================

function OnFormatGrid()
{
    var trl;
    
    trl = idGrid.GetGridControl();	
    trl.ColFormat(G1_STOCK_QTY)           = "###,###,###,###,###.##"; 
     
       
    trl = idGrid2.GetGridControl();	
    trl.ColFormat(G_STOCK_QTY)           = "###,###,###,###,###.##";   

}

//======================================================================
function OnSearch(obj)
{ 
    switch(obj)
    {
        case '1':
	            data_kbpr00021.Call("SELECT");
        break;
    }
   
}
//======================================================================
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

//======================================================================

function OnReceiveData(obj)
{
   switch(obj.id)
    {
        case 'data_kbpr00021':
        break;
      }
}
//======================================================================

function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "idGrid" && event.row > 0 )
  {
    var col_val_1 = oGrid.GetGridData(event.row, G1_ITEM_LOT_NO );
	var col_val_2 = oGrid.GetGridData(event.row, G1_WH_PK       );
    
    if(event.row > 0 && ( !CheckDataExist( idGrid2, col_val_1, col_val_2) ) )
    {
        SetRowBackGroundColor( oGrid, col_val_1, col_val_2, 0x0000FF);
		
		idGrid2.AddRow();
        for(var i=0;i<oGrid.cols;i++)
        {
          idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
        }
     }
  }
  countItem()
}
//======================================================================

function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
//================================================================================================

function CheckDataExist(p_oGrid,p_value_1,p_value_2)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
      for(var i=1;i<p_oGrid.rows;i++)
       {
          if(p_oGrid.GetGridData(i, G_ITEM_LOT_NO) == p_value_1 && p_oGrid.GetGridData(i, G_WH_PK) == p_value_2 )
          {
             return true;
          }
       }
       return false;
}
//================================================================================================

function SetRowBackGroundColor(p_oGrid, p_col_val_1, p_col_val_2, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if( p_oGrid.GetGridData( i, G_ITEM_LOT_NO) == p_col_val_1 && p_oGrid.GetGridData( i, G_WH_PK) == p_col_val_2)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}

//================================================================================================
function OnAdd(oGrid)
{
	for (var i = 1; i<oGrid.rows ; i++)
	{		
		var col_val_1 = oGrid.GetGridData( i, G_ITEM_LOT_NO);
		var col_val_2 = oGrid.GetGridData( i, G_IWH_PK     );
				      				
        if ( oGrid.GetGridControl().isSelected(i) == true && ( !CheckDataExist( idGrid2, col_val_1, col_val_2 )) )
        {
						
            SetRowBackGroundColor( oGrid, col_val_1, col_val_2, 0x0000FF);
    		
			idGrid2.AddRow();
	        for(var i=0;i<oGrid.cols;i++)
	        {
	          idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
	        }
        }
		
	}
    
    countItem();    
}
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  	if(idGrid2.row > 0)
  	{
    	var col_val_1 = idGrid2.GetGridData(idGrid2.row,G_ITEM_LOT_NO);
		var col_val_2 = idGrid2.GetGridData(idGrid2.row,G_ITEM_LOT_NO);
		
    	idGrid2.RemoveRowAt(idGrid2.row);
		
    	SetRowBackGroundColor( idGrid, col_val_1, col_val_2, 0x000000); 
		
    	countItem();
  	}
}
//======================================================================
function OnGridEdit()
{
    
    var col = event.col;
    var row = event.row;
	
    if( col==G_Select )
    {
		var dQuantiy ;
        
        dQuantiy =  idGrid2.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                idGrid2.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {                 
                idGrid2.SetGridText( row, col, "");
            }
        }
        else
        {
            idGrid2.SetGridText(row,col,"") ;
        }  	
		//-------------------------------------
        var bal_qty = Number(idGrid2.GetGridData(row,G_STOCK_QTY)) - Number(idGrid2.GetGridData(row,G_Select));
		
        idGrid2.SetGridText( row, G_Balance, System.Round( bal_qty, arr_FormatNumber[G_Balance] ) );
		//-------------------------------------
    }
}
//======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_kbpr00021" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="<%=l_user%>lg_sel_kbpr00021" > 
                  <input bind="idGrid" > 
                    <input bind="lstWH" />
                    <input bind="lstGroup" />
                    <input bind="txtItem" />
                    <input bind="lstLang1" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                <gw:list id="lstLang1" styles='width:60' onchange="OnSearch('1')" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                W/H
            </td>
            <td style="width: 30%">
                <gw:list id="lstWH" styles="width:100%" onchange="OnSearch('1')" csstype="mandatory" />
            </td>
            <td style="width: 5%; white-space: nowrap" align="right">
                Group
            </td>
            <td style="width: 30%">
                <gw:list id="lstGroup" styles="width:100%" onchange="OnSearch('1')" csstype="mandatory" />
            </td>           
            <td style="width: 20%">
                <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('1')" />
            </td>
			<td style="width: 4%" align="right">              
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('1')" />
            </td>
        </tr>
        <!---------------------------------------------------------------------------------------------->
        <tr style="height: 49%">
            <td colspan="10">
                <gw:grid id="idGrid" header="_PK|_WH_PK|W/H Name|_ITEM_PK|Item Code|Item Name|UOM|Stock|Lot No|Weight(Kg/BL)|HI|Mic|Mat|SCI|Len|Amt|Unf|SFI|Str|Elg|Moist|Rd|+b|Tr Cnt|Tr Area|UQL(w)|SFC(W)|Nep Cnt/g|SCN Cnt/g"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|1|3|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" defaults="||||||||||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|0|2500|0|2000|2500|800|1200|0|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200" styles="width:100%; height:100%" sorting="T"
                    oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="10">
                <table border="0">
                    <tr>
                        <td align="center" style="width: 100%">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td align="right" style="white-space: nowrap">
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                            Duplicate
                        </td>
                        <td align="right">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="10">
                 <gw:grid id="idGrid2" header="_PK|_WH_PK|W/H Name|_ITEM_PK|Item Code|Item Name|UOM|Stock|Lot No|Weight(Kg/BL)|HI|Mic|Mat|SCI|Len|Amt|Unf|SFI|Str|Elg|Moist|Rd|+b|Tr Cnt|Tr Area|UQL(w)|SFC(W)|Nep Cnt/g|SCN Cnt/g"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|1|3|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" defaults="||||||||||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|0|2500|0|2000|2500|800|1200|0|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200" styles="width:100%; height:100%" sorting="T"
                    onafteredit="OnGridEdit(this)" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------------------------------->
</body>

</html>
