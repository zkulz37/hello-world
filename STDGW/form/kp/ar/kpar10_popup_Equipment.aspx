<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Item</title>
</head>
<%  ESysLib.SetUser("ec111")
  
%>

<script>

var G_tco_item_pk       = 0,
    G_Item_Code         = 1,
    G_Item_Name         = 2,
    G_Spec              = 3,
    G_Unit_CD           = 4,
    G_Unit              = 5;
   // G_AlterUnit_CD      = 6,
//    G_AlterUnit         = 7,
//    G_Last_Price        = 15;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
	 BindingDataList();
	 var p_Project_Pk = "<%=Request.querystring("Project_Pk")%>"; 
	 txtProject_Pk.SetDataText(p_Project_Pk);
	 dso_update.Call("SELECT");
}
//-----------------------------------------------------------------------------------------------
function BindingDataList()
 {    
     data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
	 idGrid.SetComboFormat(3,data);
 }
//-----------------------------------------------------------------------------------------------
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
                 dso_update.Call("SELECT");
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
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G_tco_item_pk) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      if( oGrid.row > 0 )
      {
            var col_val = oGrid.GetGridData(oGrid.row, G_tco_item_pk );
            if(oGrid.GetGridData(oGrid.row,0)!="")
            {
                if(oGrid.row > 0 && ( !CheckDataExist(idGrid2,col_val)) )
                {
                     SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		            idGrid2.AddRow();
		            for(var i=0;i<oGrid.cols;i++)
		            {
		              idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(oGrid.row,i));
		            }
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
        case 'dso_update':
            lblRecord2.text = idGrid.rows-1 + " record(s)";
        break;
    }
}
//================================================================================================
function OnAddNew()
{
    idGrid.AddRow();
	idGrid.SetGridText(idGrid.rows-1, 6, txtProject_Pk.text);
}
//================================================================================================
function OnSave()
{
    dso_update.Call();
}
//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, G_tco_item_pk);		
		
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
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row,G_tco_item_pk);
    
    idGrid2.RemoveRowAt(idGrid2.row);
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
    
    countItem()
  }
}

function OnRemoveAll()
{
   var col_val;
    for(var i=1;i<idGrid2.rows;i++)
    {
        col_val = idGrid2.GetGridData(i,1);
        SetRowBackGroundColor(idGrid,col_val,0x000000); 
    }
    idGrid2.SetData("");
    countItem();
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="dso_update" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="ec111.sp_sel_kpar10_Equipment" parameter="0,1,2,3,4,5,6" procedure="ec111.sp_upd_kpar10_equipment"> 
                  <input bind="idGrid" > 
                    <input bind="txtCategory" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 1%">
			<td>
			<fieldset style="padding:0">
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
							<td style="width: 5%" align="right">Category</td>
							<td style="width: 35%"><gw:textbox id="txtCategory" styles="width:100%" onenterkey="OnSearch(1)" /></td>
							<td style="width: 14%" align="center"><gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label></td>
							<td style="width: 1%" align="right"><gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" /></td>
							<td style="width: 1%" align="right"><gw:imgbtn id="btnAddNew" img="new" alt="Add New" onclick="OnAddNew()" /></td>
							<td style="width: 1%" align="right"><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" /></td>
                            <td style="width: 1%" align="right"><gw:imgbtn id="btnSave" img="delete" alt="Delete" onclick="OnDelete()" /></td>
					</tr>
				</table>
			</fieldset>	
			</td>
        </tr>
        <tr style="height: 49%">
            <td colspan="">
                <gw:grid id='idGrid' 
				header='_PK|Category|Category Name|Unit|_Align. Seq.|Use Y/N|_Project_Pk' 
				format='0|0|0|0|0|0|0' 
				aligns='0|0|0|0|0|0|0'
                check='||||||' 
				editcol='1|1|1|1|1|1|0' 
				widths='0|1000|2000|1500|0|1000|0' 
				sorting='T' 
                styles='width:100%; height:100%' 
				oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="">
				<fieldset style="padding:0">
				<table cellpadding="0" cellspacing="0" width="100%">
					<tr>
							<td style="width: 96%" align="center"><gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' /></td>
                        <td style="width: 1%" style="white-space: nowrap"><gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />Duplicate</td>
                        <td style="width: 1%"><gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(idGrid)" /></td>
                        <td style="width: 1%"><gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemoveAll()" /></td>
                        <td style="width: 1%"><gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" /></td>
					</tr>
				</table>
			</fieldset>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="6">
                 <gw:grid id='idGrid2' 
				header='_PK|Category|Category Name|Unit|_Align. Seq.|Use Y/N|_Project_Pk' 
				format='0|0|0|0|0|0|0' 
				aligns='0|0|0|0|0|0|0'
                check='||||||' 
				editcol='1|1|1|1|1|1|1' 
				widths='0|1000|2000|1500|0|1000|0' 
				sorting='T' 
                styles='width:100%; height:100%' 
				oncelldblclick="OnRemove()" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
<gw:textbox id="txtProject_Pk" styles="width:100%;display:none" />	
</body>
</html>
