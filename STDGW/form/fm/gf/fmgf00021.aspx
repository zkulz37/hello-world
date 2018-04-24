<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Consumption Slip Entry - Pop Up Get Item from Transaction</title>
</head>

<script>
//------------------------------------------------------------------------------------------------
var G1_PK                   = 0 ,
    G1_Trans_No             = 1 ,
    G1_Date                 = 2 ,
    G1_TR_STATUS            = 3 ,    
    G1_TAC_ABPLCENTER_PK    = 4 ,
    G1_P_L                  = 5 ,
    G1_TIN_WAREHOUSE_PK     = 6 ,
    G1_WH_Name              = 7 ,
    G1_Month                = 8 ,
    G1_TAC_ABACCTCODE_PK    = 9 ,
    G1_Account_CD           = 10 ,
    G1_Account_Name         = 11 ,
    G1_TCO_ITEM_PK          = 12 ,
    G1_Item_Code            = 13 ,
    G1_Item_Name            = 14 ,
    G1_UOM                  = 15 ,
    G1_TROUT_TYPE           = 16 ,
    G1_Qty                  = 17 ,
    G1_UPrice               = 18 ,
    G1_Amt                  = 19 ,
    G1_CCY                  = 20 ,
    G1_TrAmt                = 21 ,
    G1_Remark               = 22 ,
    G1_Remark2              = 23 ,
    G1_Description          = 24 ;
   
//------------------------------------------------------------------------------------------------
function BodyInit()
{
   	OnFormatGrid();
   	dtFromDate.value = System.AddDate(dtToDate.value, -7);
}
//------------------------------------------------------------------------------------------------
function OnFormatGrid()
{
    var trl;
    
    trl = idGrid.GetGridControl();	
    trl.ColFormat(G1_Qty)           = "###,###,###,###,###.##";  
    trl.ColFormat(G1_UPrice)        = "###,###,###,###,###.##";
    trl.ColFormat(G1_Amt)           = "###,###,###,###,###.##";
    trl.ColFormat(G1_TrAmt)         = "###,###,###,###,###.##";
      
    trl = idGrid2.GetGridControl();	
    trl.ColFormat(G1_Qty)           = "###,###,###,###,###.##";  
    trl.ColFormat(G1_UPrice)        = "###,###,###,###,###.##";
    trl.ColFormat(G1_Amt)           = "###,###,###,###,###.##";
    trl.ColFormat(G1_TrAmt)         = "###,###,###,###,###.##";
}

//-----------------------------------------------------------------------------------------------

function OnSearch()
{ 
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-30));
    //-------
	fmgf00021.Call("SELECT");
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
    var col_val = idGrid2.GetGridData( idGrid2.row, G1_PK);
    
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
      if(p_oGrid.GetGridData( i, G1_PK) == p_col_val)
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
      if(p_oGrid.GetGridData(i, G1_PK) == p_value)
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
    var col_val = oGrid.GetGridData(event.row, G1_PK );
    
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
//------------------------------------------------------------------------------------------------
function OnResetDate()
{
    if(rbDate.value == 0)
    {
        dtFromDate.value = System.AddDate(dtToDate.value, -7);
    }
    else if(rbDate.value == 1)
    {
        dtFromDate.value = System.AddDate(dtToDate.value, -14);
    }
    else if(rbDate.value == 2)
    {
        dtFromDate.value = System.AddDate(dtToDate.value, -30);
    }
}
//------------------------------------------------------------------------------------------------
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="fmgf00021" onreceive=""> 
    <xml> 
           <dso id="1" type="grid" function="acnt.sp_sel_fmgf00021" > 
                  <input bind="idGrid" > 
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />              
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 100%" colspan="2">
                <table width="100%" style="height: 100%" cellpadding="0">
                    <tr align="right" style="height: 5%; width: 100%">
                        <td style="width: 20%" s>
                            <b>Transaction Date</b>
                        </td>
                        <td style="width: 15%" align="right">
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                        </td>
                        <td style="width: 15%" align="left">
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
                        </td>
                        <td style="width: 40%" align="left">
                            <gw:radio id="rbDate" value="0" styles="width: 100%; " onchange="OnResetDate()"> 
                            <span value="0">1 Week</span>
                            <span value="1">2 Weeks</span>
                            <span value="2">1 Month</span>
                            </gw:radio>                            
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="2">
                <gw:grid id="idGrid" header='_PK|Trans No|Date|_TR_STATUS|_TAC_ABPLCENTER_PK|P/L|_TIN_WAREHOUSE_PK|WH Name|Month|_TAC_ABACCTCODE_PK|Account CD|Account Name|_TCO_ITEM_PK|Item Code|Item Name|UOM|_TROUT_TYPE|Qty|UPrice|Amt|CCY|TrAmt|Remark|Remark2|Description'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|0|1|0|0|0|0|0|0|1|0|3|3|3|1|3|0|0|0'
                    defaults='||||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1200|1200|1000|1000|1000|1000|1500|1000|0|1200|2500|0|1200|3000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles="width:100%; height:100%" oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 2%">
            <td align="center">
                <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td align="right">
                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="2">
                <gw:grid id="idGrid2" header='_PK|Trans No|Date|_TR_STATUS|_TAC_ABPLCENTER_PK|P/L|_TIN_WAREHOUSE_PK|WH Name|Month|_TAC_ABACCTCODE_PK|Account CD|Account Name|_TCO_ITEM_PK|Item Code|Item Name|UOM|_TROUT_TYPE|Qty|UPrice|Amt|CCY|TrAmt|Remark|Remark2|Description'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|0|1|0|0|0|0|0|0|1|0|3|3|3|1|3|0|0|0'
                    defaults='||||||||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1200|1200|1000|1000|1000|1000|1500|1000|0|1200|2500|0|1200|3000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
