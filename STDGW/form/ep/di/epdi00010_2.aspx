
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
function BodyInit()
{   
    SetGridFormat();  
}
 //-----------------------------------------------------------------------------------------------
     function SetGridFormat()
     {
        var ctr = grdItemPO.GetGridControl(); 
        ctr.ColFormat(11) = "#,###,###,###,###,###.##";
     }
//------------------------------------------------------------------------------------------------
function OnSearch()
{ 
    datGetItemFromPO.Call("SELECT");
	
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
  if(grdItemPO2.row > 0)
  {
    var col_val = grdItemPO2.GetGridData(grdItemPO2.row,0);
    grdItemPO2.RemoveRowAt(grdItemPO2.row);
    SetRowBackGroundColor(grdItemPO,col_val,0x000000); 
    countItem()
  }
}
//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//-------------------------------------------------------------------------------------------------
function CheckDataExist(p_oGrid,p_value)
{
  for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData(i,0) == p_value)
      {
         return true;
      }
   }
   return false;
}
//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
  if(oGrid.id == "grdItemPO")
  {
    var col_val = oGrid.GetGridData(event.row,0);
    
    if(event.row > 0 && ( !CheckDataExist(grdItemPO2,col_val)) )
    {
        SetRowBackGroundColor(oGrid,col_val,0x0000FF);
		grdItemPO2.AddRow();
		for(var i=0;i<oGrid.cols;i++)
		{
		  grdItemPO2.SetGridText(grdItemPO2.rows-1,i,oGrid.GetGridData(event.row,i));
		}
     }
  }
  countItem()
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=grdItemPO2.rows-1 + " item(s)."
}
</script>

<body>
    <gw:data id="datGetItemFromPO" onreceive=""> 
    <xml> 
           <dso id="1" type="grid" function="INV.sp_sel_reqiqc_itempo" > 
                  <input bind="grdItemPO" >                    
                    <input bind="txtPONO" /> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtItem" />
                  </input> 
                <output bind="grdItemPO" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%">
        <tr>
            <td width="8%" align="right">PO No 
            </td>
            <td width="20%">
                <gw:textbox id="txtPONO"  styles="width:100%" />
            </td>
            <td width="10%" align=right>
                PO Date
            </td>
            <td width="10%" align="right">
                <b><gw:datebox id="dtFrom" lang="1" width="10%" csstype="filter"/></b>
            </td>
            <td width=1%> ~ </td>
            <td width="10%">
                <gw:datebox id="dtTo" lang="1" width="10%" csstype="filter"/>
            </td>
            <td width="10%" align="right">
                <b>Item</b>
            </td>
            <td width="35%">
                <gw:textbox id="txtItem" styles="width:100%"  onenterkey="OnSearch()" />
            </td>
            <td width="2%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="2%" align="right">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdItemPO2)" />
            </td>
        </tr>
        <tr>
            <td colspan="14">
            <gw:grid id='grdItemPO'
                header='_PK|Item Code|Item Name|Unit|Lot No|_TCO_BUSPARTNER_PK|Vendor|_RECEIVE_FROM_PK|Receiver From|PO No|_tpr_purordd_pk|PO Q.Ty|Description'
                format='0|0|0|0|0|0|0|0|0|0|0|1|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                defaults='||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='0|1500|2000|800|1000|0|1500|0|1500|1200|0|1200|1000'
                sorting='T'
               param="0,1,2,3,4,5,5,6,7,8,9,10,11,12"  
                styles='width:100%; height:250'
               oncelldblclick="OnGridCellDoubleClick(this)" 
                />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td colspan="12" align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr>
            <td colspan="14">
            <gw:grid id='grdItemPO2'
                header='_PK|Item Code|Item Name|Unit|Lot No|_TCO_BUSPARTNER_PK|Vendor|_RECEIVE_FROM_PK|Receiver From|PO No|_tpr_purordd_pk|PO Q.Ty|Description'
                format='0|0|0|0|0|0|0|0|0|0|0|1|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                defaults='||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='0|1500|2000|800|1000|0|1500|0|1500|1200|0|1200|1000'
                sorting='T'
               param="0,1,2,3,4,5,5,6,7,8,9,10,11,12"  
                styles='width:100%; height:250'
               oncelldblclick="OnGridCellDoubleClick(this)" 
                />            
            </td>
        </tr>
    </table>
</body>
</html>