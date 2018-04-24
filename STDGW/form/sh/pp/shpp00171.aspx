<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>GET PRODUCT FROM DAILY PRODUCTION INSTRUCTION</title>
</head>

<script>

var iM_Status       = 3 ;

var iD_PK           = 0,
    iD_Req_Qty      = 14,
    iD_PO_Qty       = 15,
    iD_TakeIn_Qty   = 16;
    
 //---------------------------------------------------------
 function OnToggle()
 {
    var top  = document.all("top");    
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        top.style.display="none";       
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/down.gif";
    }
    else
    {
        top.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/up.gif";
    }
 }

 //---------------------------------------------------------
 function BodyInit()
 {
    var mat_type;

    mat_type = "<%=Request.querystring("group_type")%>"; 
    
    if ( Number(mat_type) > 0  )
    {
        txtMatType.text = mat_type ;
    }    
    //-------------------
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-30)); 
    //-------------------
 } 
//---------------------------------------------------------
 function OnSearch(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            data_shpp00171.Call('SELECT');
        break;         
      }  
 }
 
 //---------------------------------------------------------
 function OnDataReceive(po_oData)
 {
 
      switch (po_oData.id)         
      {
        case "data_shpp00011" :
        
            txtWIPK.text = '' ;
            data_shpp00171.Call('SELECT');
            
        break;
      }  
 }
 
//-------------------------------------------------------------------------------------------------
function OnRemove()
{
    for ( var i=1; i<grdItemSelect.rows; i++ )
    {
        if ( grdItemSelect.GetGridControl().isSelected(i) == true )
        {
            var col_val = grdItemSelect.GetGridData(i,0);
            
            grdItemSelect.RemoveRowAt(i);
            
            SetRowBackGroundColor(grdReqItemList,col_val,0x000000);         
        }
    }
    
    countItem();

}

//-------------------------------------------------------------------------------------------------
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for (var i=1; i<p_oGrid.rows; i++ )
   {
      if ( p_oGrid.GetGridData(i,0) == p_col_val )
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
      if(p_oGrid.GetGridData(i,1) == p_value)
      {
         return true;
      }
   }
   return false;
}

//---------------------------------------------------------
    var gPreviousRow = -1 ;
//-------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdReqItemList" :
            
                var col_val = oGrid.GetGridData(event.row,1);
                
                if ( event.row > 0 && ( !CheckDataExist(grdItemSelect,col_val) ) )
                {
                    SetRowBackGroundColor(oGrid,col_val,0x0000FF);
                    
		            grdItemSelect.AddRow();
            		
		            for(var i=0;i<oGrid.cols;i++)
		            {
		              grdItemSelect.SetGridText(grdItemSelect.rows-1,i,oGrid.GetGridData(event.row,i));
		            }
                 }

                countItem();
            break;
      }        
}
//------------------------------------------------------------------------------------------------
function countItem()
{
    txtCount.text=grdItemSelect.rows-1 + " item(s)."
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
//================================================================================================
function OnAdd(oGrid)
{
	for (i = 0; i<oGrid.GetGridControl().SelectedRows ; i++)
	{
		var row = oGrid.GetGridControl().SelectedRow(i);
        var col_val = oGrid.GetGridData( row, iD_PK);		
		
        if ( row > 0 && ( !CheckDataExist( grdItemSelect, col_val)) )
        {
            SetRowBackGroundColor( oGrid, col_val, 0x0000FF);
            
	        grdItemSelect.AddRow();
    		
	        for(var j=0; j<oGrid.cols; j++)
	        {
	            grdItemSelect.SetGridText( grdItemSelect.rows-1, j, oGrid.GetGridData( row, j) );
	        }
        }
		
	}
    
    countItem();    
}
//================================================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpp00171" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="prod"  parameter="0" function="prod.sp_sel_shpp00171" > 
                <input> 
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                    <input bind="txtReqNo" />
                    <input bind="txtItem" />
                    <input bind="chkBalance" /> 
                </input> 
                <output bind="grdReqItemList" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <form id="form1" runat="server">
        <table style="width: 100%; height: 100%" border="1">
            <tr style="height: 1%">
                <td>
                    <table style="width: 100%; height: 100%">
                        <tr>
                            <td align="right" style="width: 5%; white-space: nowrap">
                                MR/PO/SO No
                            </td>
                            <td style="width: 25%">
                                <gw:textbox id="txtReqNo" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(1)" />
                            </td>
                            <td align="right" style="width: 5%">
                                Date
                            </td>
                            <td style="width: 20%; white-space: nowrap">
                                <gw:datebox id="dtFromDate" lang="1" />
                                ~
                                <gw:datebox id="dtToDate" lang="1" />
                            </td>
                            <td style="width: 5%" align="right">
                                Item
                            </td>
                            <td style="width: 30%">
                                <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch(1)" />
                            </td>
                            <td style="width: 9%; white-space: nowrap" align="center">
                                Balance
                                <gw:checkbox id="chkBalance" defaultvalue="Y|N" value="Y" onchange="OnSearch(1)" />
                            </td>
                            <td align="right" style="width: 1%">
                                <gw:imgbtn img="search" alt="Search" id="btnSearch_1" onclick="OnSearch(1)" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 38%">
                <td>
                    <gw:grid id='grdReqItemList' header='_tsh_batlot_m_pk|Lotno|_tsa_saleorderd_pk|S/O No|_tco_item_pk|Item Code|Item Name|Size|Cap Col|Body Col|Print Y/N|Target Qty|Prod Qty|Bal Qty|_tco_buspartner_pk|Customer ID|Customer NM|Country NM|D-Weight'
                        format='0|0|0|0|0|0|0|0|0|0|0|-2|-2|-2|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|3|3|3|0|0|0|0|3'
                        check='||||||||||||||||||'  editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|1500|0|1200|0|1200|2000|800|800|800|800|1000|1000|1000|0|1000|1000|1000|1200'
                        sorting='T' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
                </td>
            </tr>
            <tr style="height: 1%">
                <td>
                    <table style="width: 100%; height: 100%">
                        <tr>
                            <td style="width: 97%" align="center">
                                <gw:label id="txtCount" />
                            </td>
                            <td align="right" style="width: 1%">
                                <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(grdReqItemList)" />
                            </td>
                            <td align="right" style="width: 1%">
                                <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                            </td>
                            <td align="right" style="width: 1%">
                                <gw:imgbtn img="select" alt="Select" id="Select" onclick="OnSelect(grdItemSelect)" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 30%">
                <td>
                    <gw:grid id='grdItemSelect' header='_tsh_batlot_m_pk|Lotno|_tsa_saleorderd_pk|S/O No|_tco_item_pk|Item Code|Item Name|Size|Cap Col|Body Col|Print Y/N|Target Qty|Prod Qty|Bal Qty|_tco_buspartner_pk|Customer ID|Customer NM|Country NM|D-Weight'
                        format='0|0|0|0|0|0|0|0|0|0|0|-2|-2|-2|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|3|3|3|0|0|0|0|3'
                        check='||||||||||||||||||'  editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|1500|0|1200|0|1200|2000|800|800|800|800|1000|1000|1000|0|1000|1000|1000|1200'
                        sorting='T' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
                </td>
            </tr>
        </table>
    </form>
    <!-------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/up.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!-------------------------------------------------------------------->
    <gw:textbox id="txtWIPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtMatType" maxlen="100" styles='width:100%;display:none' />
    <!-------------------------------------------------------------------->
</body>
</html>
