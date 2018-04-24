
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  ESysLib.SetUser("comm")
  
%>

<script>
var IsSelectItem ;
function BodyInit()
{   
    System.Translate(document);  // Translate to language session
    
    txtVendorPK.text="<%=request("vendor_pk")%>"    
    IsSelectItem = "<%=request.QueryString("IsSelectItem")%>";
  
    if (IsSelectItem=='1')
    {
        idGrid2.style.display="none";
        ibtnRemove.style.display="none";
        lblCount.style.display="none";
        var ctl = idGrid.GetGridControl(); 
        ctl.style.height="500";
    }
    SetGridFormat();  
}
 //---------------------------------------------------------------------------------------------------
     function SetGridFormat()
     {
        var ctr = idGrid2.GetGridControl(); 
        ctr.ColFormat(7) = "#,###,###,###,###,###.##";
        ctr.ColFormat(8) = "#,###,###,###,###,###.##";
        var ctr = idGrid.GetGridControl(); 
         ctr.ColFormat(7) = "#,###,###,###,###,###.##";
        ctr.ColFormat(8) = "#,###,###,###,###,###.##";
     }
//------------------------------------------------------------------------------------------------
function OnSearch()
{ 
    dsoGetItem.Call("SELECT");	
}
//-----------------------------------------------------------------------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   if(IsSelectItem=='1')
   {    
       var arrTemp=new Array();
             
         for(var j=0;j<oGrid.cols;j++)
         {
            arrTemp[arrTemp.length]= oGrid.GetGridData(oGrid.row,j);
         }
         
         arr_data[arr_data.length]= arrTemp;        
   }
   else
   {
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
       }
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
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
  if(idGrid2.row > 0)
  {
    var col_val = idGrid2.GetGridData(idGrid2.row,0);
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
  if(oGrid.id == "idGrid")
  {
    var col_val = oGrid.GetGridData(event.row,6);
    
    if(IsSelectItem=='1')
    {
        OnSelect(idGrid);
    }
    
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
</script>

<body>
    <gw:data id="dsoGetItem" onreceive=""> 
        <xml> 
           <dso id="1" type="grid" function="imex.sp_sel_get_soTakeout_item" > 
              <input bind="idGrid" >                    
                <input bind="txtSlipNO" /> 
                <input bind="dtFrom" />
                <input bind="dtTo" />
                <input bind="txtItem" />
                <input bind="txtVendorPK" />
              </input> 
            <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table width="100%">
        <tr>
            <td width="8%" align="right">SO No 
            </td>
            <td width="20%">
                <gw:textbox id="txtSlipNO"  styles="width:100%" />
            </td>
            <td width="10%" align=right>
                SO Date
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
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
            </td>
        </tr>
        <tr>
            <td colspan="14">
                <gw:grid id='idGrid'
                    header='_Item_Pk|Item Code|Item Name|Uom|Hs Code|Slip No|_so_Pk|Takeout Qty|Unit Price|Description'
                    format='0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|1|0|0|0|3|3|0'
                    defaults='|||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='0|2000|2500|1000|1200|1500|0|1500|1500|1000'
                    sorting='T'
                    styles='width:100%; height:230'
                    oncelldblclick="OnGridCellDoubleClick(this)" />
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
                <gw:grid id="idGrid2"
                    header='_Item_Pk|Item Code|Item Name|Uom|Hs Code|Slip No|_SO_Pk|Order Qty|Unit Price|Description'
                    format='0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|1|0|0|0|3|3|0'
                    defaults='|||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='0|2000|2500|1000|1200|1500|0|1500|1500|1000'
                    sorting='T'
                    styles='width:100%; height:230'
                    param="0,1,2,3,4,5,5,6,7,8,9" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtVendorPK" style="display: none" />
    <gw:textbox id="txtDeliveryTerm" style="display: none" />
</body>
</html>
