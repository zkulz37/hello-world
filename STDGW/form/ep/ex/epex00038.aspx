<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser("SALE")
    Dim l_user As String
    l_user = "SALE."
%>
<head id="Head1" runat="server">
    <title>POP UP GET ITEM FROM SALE ORDER</title>
</head>

<script>
// grdDetail
   
var G_PO_NO			= 0,
	G_SO_ITEM_NO	= 1,		 
	G_ITEM_PK		= 2,
	G_ITEM_CODE		= 3,
	G_ITEM_NAME		= 4,
	G_PARTNER_NAME	= 5,
	G_VIRTUAL_CODE	= 6,
	G_UOM			= 7,
	G_ORD_QTY 		= 8,
	G_UNIT_PRICE	= 9,
	G_ITEM_AMT 		= 10,
    G_TAX_AMT 		= 11,
    G_TOTAL_AMT 	= 12,
	G_PROD_QTY		= 13,
	G_DELI_QTY		= 14,
	G_DELI_BAL		= 15,	
	G_STOCK_BAL		= 16,
	G_SO_D_PK		= 17, 	
	G_REMARK		= 18; 

	var arr_FormatNumber = new Array(); 
//==============================================================================================

 function BodyInit()
 {
    System.Translate(document);
    var callerWindowObj = dialogArguments;  
	
	txtCustPK.text 	 = callerWindowObj.txtCustPK.text;
    lblCustName.text = callerWindowObj.txtCustName.text;	     
         
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-30));
	
    OnFormatGrid();
 } 

//==============================================================================================

function OnFormatGrid()
{
		var data = "";
        data = "DATA|O|Order|E|ETD";
        idList.SetDataText(data);
        idList.value = 'O';
		
		data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 order by partner_name")%>||";
    	lstCompany.SetDataText(data);
    	lstCompany.value = "<%=Session("COMPANY_PK")%>" ;	
				
    	var trl;
    	trl = grdDetail.GetGridControl();

		trl.ColFormat(G_UNIT_PRICE) = "###,###,###,###,###.#####"; 
		trl.ColFormat(G_ITEM_AMT)   = "###,###,###,###,###.##";   
    	trl.ColFormat(G_TAX_AMT)   	= "###,###,###,###,###.##";    		 
    	trl.ColFormat(G_TOTAL_AMT)  = "###,###,###,###,###.##"; 		
    	trl.ColFormat(G_ORD_QTY)    = "###,###,###,###,###.##"; 
		trl.ColFormat(G_PROD_QTY)   = "###,###,###,###,###.##";   
    	trl.ColFormat(G_DELI_QTY)   = "###,###,###,###,###.##";    		 
    	trl.ColFormat(G_DELI_BAL)   = "###,###,###,###,###.##"; 
		trl.ColFormat(G_STOCK_BAL)  = "###,###,###,###,###.##"; 
		
		trl = grdItem.GetGridControl();	
		
		trl.ColFormat(G_UNIT_PRICE) = "###,###,###,###,###.#####"; 
		trl.ColFormat(G_ITEM_AMT)   = "###,###,###,###,###.##";   
    	trl.ColFormat(G_TAX_AMT)   	= "###,###,###,###,###.##";    		 
    	trl.ColFormat(G_TOTAL_AMT)  = "###,###,###,###,###.##"; 		
    	trl.ColFormat(G_ORD_QTY)    = "###,###,###,###,###.##"; 
		trl.ColFormat(G_PROD_QTY)   = "###,###,###,###,###.##";   
    	trl.ColFormat(G_DELI_QTY)   = "###,###,###,###,###.##";    
    	trl.ColFormat(G_DELI_BAL)   = "###,###,###,###,###.##"; 
		trl.ColFormat(G_STOCK_BAL)  = "###,###,###,###,###.##"; 
		
		arr_FormatNumber[G_DELI_BAL] = 2;  
		
		grdDetail.GetGridControl().MergeCells  = 2 ;	
		grdDetail.GetGridControl().MergeCol(0) = true;  
		
		grdDetail.GetGridControl().Cell( 7, 0, G_DELI_BAL, 0, G_DELI_BAL ) = 0x3300cc;		
		grdItem.GetGridControl().Cell( 7, 0, G_DELI_BAL, 0, G_DELI_BAL ) = 0x3300cc;	
		
		grdDetail.GetGridControl().Cell( 7, 0, G_STOCK_BAL, 0, G_STOCK_BAL ) = 0xCC0000;		
		grdItem.GetGridControl().Cell( 7, 0, G_STOCK_BAL, 0, G_STOCK_BAL ) = 0xCC0000;	 
		
		lstCompany.value = "<%=Session("COMPANY_PK")%>" ;
}

//==============================================================================================

 function OnSearch()
 {
       data_epex00038.Call("SELECT");
 } 
 
//==============================================================================================

 function OnDataReceive(po_oData)
 {
      switch (po_oData.id)         
      {  
        case "data_epex00038" :
            if ( grdDetail.rows > 1)
            {
				grdDetail.SetCellBold( 1, G_PO_NO,   grdDetail.rows - 1, G_PO_NO,   true);
				
				grdDetail.SetCellBold( 1, G_ITEM_CODE, grdDetail.rows - 1, G_ITEM_CODE, true);
				grdDetail.SetCellBold( 1, G_ORD_QTY,   grdDetail.rows - 1, G_ORD_QTY,   true);
				
				grdDetail.GetGridControl().Cell( 7, 1, G_DELI_BAL, grdDetail.rows - 1, G_DELI_BAL ) = 0x3300cc;
				
				grdDetail.GetGridControl().Cell( 7, 1, G_STOCK_BAL, grdDetail.rows - 1, G_STOCK_BAL ) = 0xCC0000;

                grdDetail.SetCellBgColor( 1, G_ITEM_CODE , grdDetail.rows - 1, G_ITEM_NAME , 0xCCFFFF ); 								   
            }
        break;
      }  
 }

//================================================================================================
function OnAdd(oGrid)
{
	for (j = 1; j<oGrid.rows ; j++)
	{
		if ( oGrid.GetGridControl().isSelected(j) == true )
		{
        	var col_val = oGrid.GetGridData( j, G_SO_D_PK);		
		
        	if ( !CheckDataExist( grdItem, col_val) )
        	{
            	SetRowBackGroundColor( oGrid, col_val, 0x3300cc);
            
	        	grdItem.AddRow();
    			
				for(var i=0;i<oGrid.cols;i++)
		    	{
		          	grdItem.SetGridText( grdItem.rows-1, i, oGrid.GetGridData(j,i) );
		    	}	
			}			 
        }		
	}
    
    countItem();    
}
//==============================================================================================

function CheckDataExist(p_oGrid,p_value)
{
    if ( chkDuplicate.value == 'Y' )
    {
        return false ;
    }
    
       for(var i=1;i<p_oGrid.rows;i++)
       {
              if(p_oGrid.GetGridData(i, G_SO_D_PK) == p_value)
              {
                 return true;
              }
       }
       return false;
}
//==============================================================================================
function OnRemove()
{
  if(grdItem.row > 0)
  {
    var col_val = grdItem.GetGridData( grdItem.row, G_SO_D_PK);
    
    grdItem.RemoveRowAt(grdItem.row);
    
    SetRowBackGroundColor(grdDetail,col_val,0x000000); 
    
    countItem()
  }
}
//==============================================================================================

function countItem()
{
    lblCount.text=grdItem.rows-1 + " item(s)."
}
//==============================================================================================
function OnGridCellDoubleClick(oGrid)
{
      if(oGrid.id == "grdDetail" && event.row > 0 )
      {
            var col_val = grdDetail.GetGridData(event.row, G_SO_D_PK );
            
            if(event.row > 0 && ( !CheckDataExist(grdItem,col_val)) )
            {
                SetRowBackGroundColor(oGrid,col_val,0x0000FF);
				
		        grdItem.AddRow();
				
			    for(var i=0;i<oGrid.cols;i++)
		    	{
		          	grdItem.SetGridText(grdItem.rows-1,i,oGrid.GetGridData(event.row,i));
		    	}	
            }
      }
      countItem()
}  
//==============================================================================================
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, G_SO_D_PK) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
//==============================================================================================
function OnCheckInput()
{
    var col, row
    
    col = event.col
    row = event.row  

    if ( col == G_DELI_BAL )
	{
 		var dQuantiy ;
        
        dQuantiy =  grdItem.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdItem.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdItem.SetGridText( row, col, "");
            }
        }
        else
        {
            grdItem.SetGridText(row,col,"") ;
        }  	
	}	    
}

//==============================================================================================
function OnSelect(oGrid)
{
   var arr_data = new Array();
   
   var l_last_po_no = "";
   var l_comma = "";
   
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
				
				if ( l_last_po_no != oGrid.GetGridData(i,G_PO_NO) )
				{
					txtArrayPONo.text = txtArrayPONo.text + l_comma + oGrid.GetGridData(i,G_PO_NO);
					
					l_last_po_no = oGrid.GetGridData(i,G_PO_NO);
					l_comma = ",";
				}		 
      }
      
	  if ( arr_data !=null )
	  {	  
	 		var callerWindowObj = dialogArguments;    

            callerWindowObj.txtRefPONo.text = txtArrayPONo.text ;  
				
			window.returnValue =  arr_data;
			window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }	  
	  
}
 
//====================================================================
 function OnProcess(pos)
 {
	switch(pos)
	{
		case 'MAP-SO-D':
			if ( confirm("Do you want to reset sale order details to goods delivery?") )
			{
				
				if ( grdDetail.row > 0 )
				{
					var callerWindowObj = dialogArguments;    
					
					for ( var i=1; i<callerWindowObj.grdDetail.rows ; i++ )
					{					 
						if ( callerWindowObj.grdDetail.GetGridControl().isSelected(i) == true )
						{
							callerWindowObj.grdDetail.SetGridText( i, callerWindowObj.G1_SO_D_PK, grdDetail.GetGridData( grdDetail.row, G_SO_D_PK) );
						}
					}
					
					window.close();
				}
			}	
		break;
	}
 }
  
 //====================================================================
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epex00038" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="prod"  parameter="0,1,2,3,4" function="<%=l_user%>lg_sel_epex00038" > 
                <input>
					<input bind="lstCompany" />
					<input bind="txtCustPK" />
					<input bind="idList" />
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" />  
                    <input bind="txtSOPONo" />  
					<input bind="txtItem" />                  
                    <input bind="chkBal" />                 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 10%" >
                Company
            </td>
			<td align="right" style="width: 20%">
				<gw:list id="lstCompany" styles='width:100%' onchange="OnSearch()" />
			</td>
            <td colspan="3">
                <gw:textbox id="txtCustPK" styles='display:none' />
                <gw:label id="lblCustName" styles='width:100%;color:cc0000;font:9pt' />
            </td>
            <td style="width: 8%" align="center">
            </td>
            <td align="right" style="width: 1%">
            </td>
            <td align="right" style="width: 1%">
                <gw:imgbtn img="search" alt="Search" id="btnSearch_1" onclick="OnSearch()" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td align="right" style="width: 10%">
                <gw:list id="idList" styles="color:blue;width:100%" value="O" onchange="OnSearch()" />
            </td>
            <td style="width: 20%">
                <gw:datebox id="dtFrom" lang="1" />
                ~<gw:datebox id="dtTo" lang="1" />
            </td>
            <td align="right" style="width: 5%; white-space: nowrap">
                SO/PO No</td>
            <td style="width: 25%">
                <gw:textbox id="txtSOPONo" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td align="right" style="width: 5%">
                Item
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td style="width: 10%; white-space: nowrap" align="center" colspan="3">
                <gw:checkbox id="chkBal" styles="color:red" defaultvalue="Y|N" value="Y">Balance</gw:checkbox>
            </td>
        </tr>
        <tr style="height: 48%">
            <td colspan="9">               
				<gw:grid id='grdDetail' 
					header='P/O No|S/O Item No|_ITEM_PK|Item Code|Item Name|Partner Item|Virtual Code|UOM|Ord Qty|U/Price|Item Amt|Tax Amt|Total Amt|Prod Qty|Deli Qty|Deli Bal|Stock Bal|_SO_D_PK|Remark'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|1|3|3|3|3|3|3|3|3|3|0|0' 
					check='||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0' 
					widths='1500|1500|0|1500|3000|1500|1500|800|1200|1200|1200|1200|1200|1200|1200|1200|1200|0|0'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="9">
                <table>
                    <tr>
						<td style="width: 5%" align="center">
                            <gw:icon id="idBtnMapSO" img="2" text="Map S/O" styles='width:100%' onclick="OnProcess('MAP-SO-D')" />
                        </td>
						
                        <td style="width: 45%" align="center">
                            <gw:label id="lblRecord2" styles="color: blue; white-space:nowrap"></gw:label>
                        </td>
                        <td style="width: 46%" align="center">
                            <gw:label id="lblCount" styles='width:100%;color:cc0000;font:9pt' />
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                            <gw:checkbox id="chkDuplicate" defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 1%" style="white-space: nowrap">
                            Duplicate
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnAdd" img="new" alt="Add" onclick="OnAdd(grdDetail)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdItem)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td colspan="9">
				<gw:grid id='grdItem' 
					header='P/O No|S/O Item No|_ITEM_PK|Item Code|Item Name|Partner Item|Virtual Code|UOM|Ord Qty|U/Price|Item Amt|Tax Amt|Total Amt|Prod Qty|Deli Qty|Deli Bal|Stock Bal|_SO_D_PK|Remark'
                    format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|0|0|0|0|0|1|3|3|3|3|3|3|3|3|3|0|0' 
					check='||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0' 
					widths='1500|1500|0|1500|3000|1500|1500|800|1200|1200|1200|1200|1200|1200|1200|1200|1200|0|0'									
                    sorting='T' styles='width:100%; height:100%' onafteredit="OnCheckInput()" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtArrayPONo" styles="width: 100%;display: none" />
</body>
</html>
