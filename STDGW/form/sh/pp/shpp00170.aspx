<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hard-Years Product Planning(Receiving-GEL)</title>
</head>
<%  ESysLib.SetUser("sale")
  
%>

<script>

    var G_pk            =0,
        G_IO_Date       =1,
        G_Matl_Code     =2,
        G_Matl_Name     =3,
        G_Lot_No        =4,
        G_Product_Code  =5,
        G_D_Weight      =6,
        G_Qty_Printed   =7,
        G_Qty_Unprinted =8,
        G_Weight        =9,
        G_Product_Name  =10,
        G_Size          =11,
        G_Printing      =12,
        G_Cap_Color     =13,
        G_Body_Color    =14,
        G_Tco_Item_pk   =15;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    data_shpp00170.Call("SELECT");
    OnFormatGrid();
    BindingDataList();
}
//-----------------------------------------------------------------------------------------------
function OnSearch()
{
    data_shpp00170.Call("SELECT");
}
//----------------------------------------------------------------------------------------------
function OnDataReceive (obj)
{
    lblTotalItem.text = (idGrid.rows -1) +" record(s)"
}
//-----------------------------------------------------------------------------------------------
function OnAddNew()
{
    idGrid.AddRow();
    idGrid.SetGridText(idGrid.rows-1,G_IO_Date,dtInstDate.value);
}
//-----------------------------------------------------------------------------------------------
function OnDelete()
{
    var ctrl = idGrid.GetGridControl();
	var row  = ctrl.row;
    if ( idGrid.GetGridData( ctrl.row, G_pk ) == "" ) 
	{						
        				
		idGrid.RemoveRow();					
	}
        			
	else 
	{
		if ( confirm( "Do you want to mark this row to delete?" ) ) 
		{
			idGrid.DeleteRow();
		}
	}
}
//----------------------------------------------------------------------------------------------
function OnGriddblClick()
{
    var row,col
            
    col = event.col ;
    row = event.row ;
            
    if ( col == G_Matl_Code || col == G_Matl_Name )
    {
        var path = System.RootURL + '/form/fp/ab/fpab00220.aspx?code_group=LGMF0130';
        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');                    
        if ( obj != null )
        {           
		    idGrid.SetGridText( row,G_Matl_Code,   obj[1]);
            idGrid.SetGridText( row,G_Matl_Name,   obj[3]);	        
  		 }
    }
//    if ( col == G_Lot_No)
//    {
//        var path = System.RootURL + '/form/sh/ab/shab00180.aspx';
//        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');                    
////        if ( obj != null )
////        {           
////		    idGrid.SetGridText( row,G_Matl_Code,   obj[1]);
////            idGrid.SetGridText( row,G_Matl_Name,   obj[3]);	        
////  		 }
//    }
}
//---------------------------------------------------------------------------------
function OnSave()
{
    data_shpp00170.Call();
}
//---------------------------------------------------------------------------------
function Calculate()
{
    var col=event.col;
    var row=event.row;
    if(col==G_Qty_Printed||col==G_Qty_Unprinted)
    {
        if(idGrid.GetGridData(row,G_Matl_Code)=="501")
        {
             var b= (Number(idGrid.GetGridData(row,G_Qty_Printed)) + Number(idGrid.GetGridData(row,G_Qty_Unprinted)))* Number(idGrid.GetGridData(row,G_D_Weight))/1000000;
            idGrid.SetGridText( idGrid.row, G_Weight,               b); 
        }
       
    }
}
//---------------------------------------------------------------------------------
function BindingDataList()
{
    var data = "";
    data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   a.code, a.code||' - '||a.code_nm FROM sale.lg_code a, sale.lg_code_group b WHERE a.del_if = 0 AND a.lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGMF0130' ORDER BY a.ord  " ) %> ";       
    idGrid.SetComboFormat(G_Matl_Code ,data);             
}
//---------------------------------------------------------------------------------
function OnFormatGrid()
 {
    var ctrl ;
    //=================================
    ctrl = idGrid.GetGridControl();    
    ctrl.ColFormat(G_Weight)   = "###,###,###,###,###.###,###";
    ctrl.ColFormat(G_D_Weight) = "###,###,###,###,###.###";
    //-----------------------------------------------------
	
 }
//---------------------------------------------------------------------------------
function OnPopUp()
{
             var path = System.RootURL + '/form/sh/pp/shpp00171.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                var arrTemp
                for( var i=0; i < object.length; i++)	  
                {	
                    arrTemp = object[i];
                      
                    idGrid.AddRow(); 
                    idGrid.SetGridText( idGrid.rows-1, G_IO_Date,               dtInstDate.value);                           
                    idGrid.SetGridText( idGrid.rows-1, G_Lot_No,                arrTemp[1]);  
                    idGrid.SetGridText( idGrid.rows-1, G_Product_Code,          arrTemp[5]);
                    idGrid.SetGridText( idGrid.rows-1, G_Product_Name,                arrTemp[6]);  
                    idGrid.SetGridText( idGrid.rows-1, G_Size,                arrTemp[7]); 
                    idGrid.SetGridText( idGrid.rows-1, G_Cap_Color,                arrTemp[8]);	
                    idGrid.SetGridText( idGrid.rows-1, G_Body_Color,                arrTemp[9]);
                    var a="";
                    if(arrTemp[10]=="Y")
                    {
                        a="P";
                    }
                    else
                    {
                        a="";
                    }
                    idGrid.SetGridText( idGrid.rows-1, G_Printing,                a);    
                    idGrid.SetGridText( idGrid.rows-1, G_D_Weight,                arrTemp[18]);   
                    idGrid.SetGridText( idGrid.rows-1, G_Tco_Item_pk,                arrTemp[4]);                                       
                }		            
             }        
}
//======================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_shpp00170" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" function="prod.sp_sel_shpp00170" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" procedure="prod.sp_upd_shpp00170" > 
                  <input bind="idGrid" > 
                    <input bind="dtInstDate" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 5%">
            <td style="width: 10%" align="right">
                Date
            </td>
            <td style="width: 60%; white-space: nowrap">
                <gw:datebox id="dtInstDate" lang="1" styles="width:100%" onchange="OnSearch()" />
            </td>
            <td style="width: 20%; white-space: nowrap" align="center">
                <gw:label id="lblTotalItem" styles='width:100%;color:cc0000;font:9pt' text='item' />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
            </td>
            <td align="right">
                <gw:imgbtn id="btnGetPOItem" img="popup" alt="Get item from PO" text="Get Item from PO"
                    onclick="OnPopUp('POItem')" />
            </td>
            
            <td style="width: 1%" align="right">
                <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="Udelete" alt="UnDelete" id="btnUDeleteCap" onclick="OnUnDelete()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 50%">
            <td colspan="8">
                <gw:grid id='idGrid' header='_PK|_IO_DATE|Matl Code/Name|_Matl Name|Lot No.|Product Code|D weight|Qty(Printed)|Qty (unprinted)|Weight(Kg)|Product Name|Size|Printing|Cap Color|Body Color|_tco_item_pk'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|3|3|3|3|0|0|0|0|0|0'
                    check='||0|||||n|n|||||||' editcol='0|0|0|0|0|0|0|1|1|1|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%' oncelldblclick="OnGriddblClick()" onafteredit="Calculate()" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
<gw:textbox id="txtMasterPK" styles="width: 100%;display:none" />
<gw:textbox id="txtColpack_M_PK" styles="width: 100%;display:none" />
</html>
