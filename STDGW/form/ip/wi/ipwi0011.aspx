<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Item</title>
</head>
<%  ESysLib.SetUser("stm")
  
%>

<script>

var G1_tst_orderm_pk       = 0 ;
var G1_tst_orderd_pk       = 7 ;
//------------------------------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //------------------------------------
    var line_pk   = "<%=request.QueryString("line_pk") %>"  ;
    var prod_date = "<%=request.QueryString("prod_date") %>"  ;
    //------------------------------------
    txtLinePK.text   = line_pk ;
    txtProdDate.text = prod_date ;
    
    //------------------------------------
   
    FormatGrid();
}
//-----------------------------------------------------------------------------------------------
 function FormatGrid()
 {
      var trl ;
      
      trl = idGrid.GetGridControl();
      	
      trl.ColFormat(8)          = "###,###,###,###,###";
      trl.ColFormat(9)          = "###,###,###,###,###";
      trl.ColFormat(10)         = "###,###,###,###,###";
      
      trl = idGrid2.GetGridControl();
      	
      trl.ColFormat(8)          = "###,###,###,###,###";
      trl.ColFormat(9)          = "###,###,###,###,###";
      trl.ColFormat(10)         = "###,###,###,###,###";      
 }
 
//-----------------------------------------------------------------------------------------------
function OnSearch()
{
    dat_ipwi0011_1.Call('SELECT');
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
    var col_val = idGrid2.GetGridData( idGrid2.row, G1_tst_orderd_pk);
    
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
      if(p_oGrid.GetGridData( i, G1_tst_orderd_pk) == p_col_val)
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
      if(p_oGrid.GetGridData(i, G1_tst_orderd_pk) == p_value)
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
    var col_val = oGrid.GetGridData(event.row, G1_tst_orderd_pk );
    
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
  countItem();
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    lblCount.text=idGrid2.rows-1 + " item(s)."
}
function OnReceiveData(obj)
{    
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="dat_ipwi0011_1" onreceive="OnReceiveData(this)"> 
        <xml> 
           <dso id="1" type="grid" function="STM.sp_sel_ipwi0011" > 
                  <input bind="idGrid" > 
                    <input bind="txtOrderID" />
                    <input bind="txtStyle" />
                    <input bind="txtLinePK" />
                    <input bind="txtProdDate" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 5%">
            <td width="100%">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="7%" align="right" nowrap>
                            <b>Order ID</b>
                        </td>
                        <td width="25%">
                            <gw:textbox id="txtOrderID" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td width="5%">
                        </td>
                        <td width="5%" align="right">
                            <b>Style</b>
                        </td>
                        <td width="25%">
                            <gw:textbox id="txtStyle" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td width="30%">
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td width="1%" align="right">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 45%">
            <td colspan="13">
                <gw:grid id='idGrid' header='_Tst_Orderm_Pk|Order Id|Style Id|Style Desc|Color Id|Color Name|Size|_Tst_Orderd_Pk|Ord Qty|Previous Qty|Bal Qty'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|3|3|3' editcol='0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1575|1665|2430|1500|2115|1530|0|1500|1500|1000' sorting='T' styles='width:100%; height:100%'
                    oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 5%">
            <td colspan="2" align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td colspan="11" align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr style="height: 40%">
            <td colspan="13">
                <gw:grid id='idGrid2' header='_Tst_Orderm_Pk|Order Id|Style Id|Style Desc|Color Id|Color Name|Size|_Tst_Orderd_Pk|Ord Qty|Previous Qty|Bal Qty'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|3|3|3' editcol='0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1575|1665|2430|1500|2115|1530|0|1500|1500|1000' sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
    <gw:textbox id="txtLinePK" styles="display: none" />
    <gw:textbox id="txtProdDate" styles="display: none" />
    <!---------------------------------------------------------------->
</body>
</html>
