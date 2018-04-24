<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>P/O Checking</title>
</head>

<script>
 
 var G_PARTNER_PK     = 0,
     G_PARTNER_ID     = 1,
     G_PARTNER_NAME   = 2,
     G_PO_M_PK        = 3,
     G_PO_NO    	  = 4,
     G_PO_DATE    	  = 5,
     G_REF_NO         = 6,
	 G_PO_D_PK 		  = 7,
	 G_SEQ        	  = 8,
	 G_ITEM_PK  	  = 9,
	 G_ITEM_CODE	  = 10,
	 G_ITEM_NAME	  = 11,
	 G_PO_UOM 		  = 12,
     G_PO_QTY         = 13,    
     G_UPRICE         = 14,
     G_PO_AMT    	  = 15,
     G_TAX_RATE       = 16,
     G_TAX_AMT        = 17,
     G_TOTAL_AMT      = 18,
     G_PO_CCY         = 19,
     G_REMARK         = 20,
     G_LC_QTY         = 21,  
     G_BAL_QTY        = 22;  
//======================================================================

function BodyInit()
{
     System.Translate(document);
	 
     //---------------------------------------
     FormatGrid();
    
}
//======================================================================
 function FormatGrid()
 {           
    var ctrl = grdPOITEM.GetGridControl(); 
     
    ctrl.ColFormat(G_PO_QTY) 	= "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_UPRICE)  	= "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_PO_AMT) 	= "#,###,###,###,###,###.##";
	ctrl.ColFormat(G_TAX_RATE) 	= "#,###,###,###,###,###";
	ctrl.ColFormat(G_TAX_AMT) 	= "#,###,###,###,###,###.##";
	ctrl.ColFormat(G_TOTAL_AMT) = "#,###,###,###,###,###.##";
	ctrl.ColFormat(G_PO_AMT) 	= "#,###,###,###,###,###.##";
   
    grdPOITEM.GetGridControl().MergeCells  = 2 ;	
    grdPOITEM.GetGridControl().MergeCol(0) = true ;	
    grdPOITEM.GetGridControl().MergeCol(1) = true ;   	
    grdPOITEM.GetGridControl().MergeCol(2) = true ;	
    grdPOITEM.GetGridControl().MergeCol(3) = true ;	
    grdPOITEM.GetGridControl().MergeCol(4) = true ; 
 } 
//======================================================================

function OnSearch()
{
    data_bini00032.Call("SELECT");
}        
//======================================================================
function OnSelect(oGrid)
{   
        var arr_data = new Array();
        
        var l_po_no      = "";
        var l_po_pk      = "";
		var l_partner_pk = "";
		var l_partner_nm = "";
		
		var l_po_ccy = "";
        var l_comma  = "";
        
        for(var i = 1; i < grdPOITEM.rows; i++ )
        {
            if ( grdPOITEM.GetGridControl().isSelected(i) == true )
            {
                 if ( l_po_pk != grdPOITEM.GetGridData(i,G_PO_M_PK) )
                 {
                     l_po_no = l_po_no + l_comma + grdPOITEM.GetGridData(i,G_PO_NO);					 					 
                     l_po_pk = grdPOITEM.GetGridData(i,G_PO_M_PK);
					 
					 l_comma = ',' ;                     
                 }
				 
				 l_po_ccy     = grdPOITEM.GetGridData( i, G_PO_CCY       );
				 l_partner_pk = grdPOITEM.GetGridData( i, G_PARTNER_PK   );
				 l_partner_nm = grdPOITEM.GetGridData( i, G_PARTNER_NAME );
                 //------------------------------------------
                 var arrTemp = new Array();
                     
                 for( var j = 0; j < grdPOITEM.cols; j++ )
                 {
                      arrTemp[arrTemp.length]= grdPOITEM.GetGridData(i,j);
                 }
                     
                 arr_data[arr_data.length]= arrTemp;
            }
        }      
        //--------------------------------------------------------------
        
        window.returnValue =  arr_data;
        window.close();	          	
}

//======================================================================
function OnDataReceive(obj)
{
    if ( grdPOITEM.rows > 1 )
    {
         grdPOITEM.SetCellBgColor( 1, G_ITEM_CODE, grdPOITEM.rows-1, G_ITEM_NAME, 0xCCFFFF );
       //  grdPOITEM.SetCellBgColor( 1, G_BAL_QTY,   grdPOITEM.rows-1, G_BAL_QTY,   0xCCFFFF );
         
         grdPOITEM.SetCellBold( 1, G_PO_NO,     grdPOITEM.rows - 1, G_PO_NO,     true); 
         grdPOITEM.SetCellBold( 1, G_ITEM_CODE, grdPOITEM.rows - 1, G_ITEM_CODE, true);         
         grdPOITEM.SetCellBold( 1, G_PO_QTY,    grdPOITEM.rows - 1, G_PO_QTY,    true);  
    }
}

//======================================================================

</script>

<body>
    <!--------------------------------------------------------->
    <gw:data id="data_bini00032" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="<%=l_user%>lg_sel_kblc00011" > 
                <input> 
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
					<input bind="txtPartnerNo" />
                    <input bind="txtItem" />
                    <input bind="chkBalance" />
                </input> 
                <output bind="grdPOITEM" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Date</td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtTo" lang="1" width="10%" />
                        </td>
						<td style="width: 5%; white-space: nowrap" align="right">
                            No/Partner</td>
                        <td style="width: 15%">
                            <gw:textbox id="txtPartnerNo" styles="width:100%;" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Item</td>
                        <td style="width: 15%">
                            <gw:textbox id="txtItem" styles="width:100%;" onenterkey="OnSearch()" />
                        </td>
                                          
                        <td style="width: 10%; white-space: nowrap">
							Bal
                            <gw:checkbox id="chkBalance" styles="color:blue" defaultvalue="Y|N" value="Y" onclick="OnSearch()" />
                        </td> 
						<td style="width: 3%">
						</td>                      
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnExit" img="cancel" alt="Exit" text="Exit" onclick="OnSelect(grdPOITEM)" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" text="Select" onclick="OnSelect(grdPOITEM)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="5">
                <gw:grid id='grdPOITEM'
                    header='_SUPPLIER_PK|Partner ID|Partner Name|_TLG_PO_PO_M_PK|Po No|Po Date|Ref No|_TLG_PO_PO_D_PK|SEQ|_PO_ITEM_PK|Item Code|Item Name|UOM|Po Qty|Unit Price|Po Amt|Vat Rate|Vat Amt|Total Amt|Po CCY|Description|LC_QTY|BAL_QTY'
                    format='0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|2500|0|1500|1200|1500|0|800|0|1500|1500|800|1500|1500|1500|1000|1500|1500|800|1500|150|0'
                    sorting='T'
                    autosize='T' 
                    styles='width:100%; height:100%'
                    />            
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>

