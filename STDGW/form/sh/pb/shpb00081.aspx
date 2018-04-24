<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
function BodyInit()
{
    data = "<%=ESysLib.SetListDataSQL("select pk, WH_NAME from inv.tin_warehouse where del_if = 0 ")%>|ALL|Select all"; 
    lstWH.SetDataText(data);
    lstWH.value = 'ALL' ;
}
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 1:
                 data_fpab00080_popup.Call("SELECT");
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
/*function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}*/
//-------------------------------------------------------------------------------------------------
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

//-------------------------------------------------------------------------------------------------
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
     // countItem()
}
//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_fpab00080_popup':
            lblRecord2.text = idGrid.rows-1 + " item(s)";
        break;
    }
}
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData( idGrid2.row, 0);
    
    idGrid2.RemoveRowAt(idGrid2.row);
    
    SetRowBackGroundColor(idGrid,col_val,0x000000); 
   
  }
}
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//================================================================================================

</script>

<body>
    <gw:data id="data_fpab00080_popup" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_shpb00080_popup" > 
                  <input bind="idGrid" > 
                    <input bind="lstWH" />
                    <input bind="txtItem" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap" align="right">
                WH
            </td>
            <td style="width: 44%" colspan="2">
                <gw:list id="lstWH" onchange="OnSearch(1)"/>
            </td>
            <td style="width: 5%" align="right">
                Item
            </td>
            <td style="width: 35%">
                <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch(1)" />
            </td>
            <td style="width: 14%" align="center">
                <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="7">
                <gw:grid id="idGrid" header="_PK|Item Code|Item Name|End Balance|Test No|Unit|Spec|WH"
                    format="0|0|0|0|0|0|0|0" aligns="0|0|0|3|0|0|0|0"
                    editcol="0|0|0|0|0|0|0|0" widths="0|2000|4000|2000|2500|800|1500|1500"
                    styles="width:100%; height:100%" sorting="T" autosize='T' oncelldblclick="OnGridCellDoubleClick(this)"/>
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="7">
                <table>
                    <tr>
                        <td colspan="5"></td>
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
                <gw:grid id="idGrid2" header="_PK|Item Code|Item Name|End Balance|Test No|Unit|Spec|WH"
                    format="0|0|0|0|0|0|0|0" aligns="0|0|0|3|0|0|0|0"
                    editcol="0|0|0|0|0|0|0|0" widths="0|2000|4000|2000|2500|800|1500|1500"
                    styles="width:100%; height:100%" sorting="T" autosize='T'/>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
