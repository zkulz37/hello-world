<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("inv")%>
<head>
    <title>Stock Outgoing Checking</title>
</head>

<script>

 var G_WH       = 0,
     G_OutDate  = 1,
     G_Slip_No  = 2,
     G_Ref_No   = 3,
     G_Seq      = 4,
     G_Item_Code= 5,
     G_Item_Name= 6,
     G_Out_Qty  = 7,
     G_Out_UOM  = 8,
     G_UP       = 9,
     G_Amount   = 10,
     G_VAT_Rate = 11,
     G_VAT_Amt  = 12,
     G_Total_Amt= 13,
     G_CYY      = 14,
     G_Supplier = 15,
     G_Line     = 16,
     G_PL       = 17,
     G_Remark   = 18;
  
 //===============================================================
 function BodyInit()
 { 
    //---------------------------------- 
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ; 
    //----------------
    
    FormatGrid();
    OnChangeTab('radType');

 }
 //===============================================================

 function FormatGrid()
 {
         //----------------
        var data = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_id || ' - ' || wh_name FROM inv.tin_warehouse  where del_if=0 order by wh_id ")%>||Select ALL";   
        lstWH.SetDataText(data);
        lstWH.value = '' ;
    
        data = "data|10|Type 1|20|Type 2";
        lstReportType.SetDataText(data);  
        lstReportType.value = '10'; 

        data = "data|10|Grand Total|20|W/H Subtotal|30|W/H-Date Subtotal";
        lstGridType.SetDataText(data);  
        lstGridType.value = '10'; 
             
        grdItem.GetGridControl().MergeCells  = 2 ;	
        grdItem.GetGridControl().MergeCol(0) = true ;	
        grdItem.GetGridControl().MergeCol(1) = true ;   	
        grdItem.GetGridControl().MergeCol(2) = true ;	
        grdItem.GetGridControl().MergeCol(3) = true ;
        //------------
        var ctrl = grdItem.GetGridControl();
        ctrl.ColFormat(G_Out_Qty)= "###,###,###.###" ;
        ctrl.ColFormat(G_UP)     = "###,###,###.###" ;
        ctrl.ColFormat(G_Amount) = "###,###,###.###" ;
        ctrl.ColFormat(G_VAT_Rate)  = "###,###,###.###" ;
        ctrl.ColFormat(G_VAT_Amt)   = "###,###,###.###" ;
        ctrl.ColFormat(G_Total_Amt) = "###,###,###.###" ;
 }

 //===============================================================
 
 function OnSearch(pos)
 {
    switch(radType.value)
    {
        case 'Item':
            data_bini00090.Call("SELECT");
        break;
            
        case 'Group':
            grdGroup.GridRefresh();
            data_bini00090_1.Call("SELECT");
        break;
    }
 }
 
 //===============================================================
 function OnDataReceive(obj)
 {
      switch (obj.id)         
      {
            case 'data_bini00090' :
			    if ( grdItem.rows > 1 )
		        {      
		            grdItem.SetCellBold( 1, G_WH,        grdItem.rows-1, G_WH,        true);
		            grdItem.SetCellBold( 1, G_Ref_No,    grdItem.rows-1, G_Ref_No,    true);      
		            grdItem.SetCellBold( 1, G_Item_Code, grdItem.rows-1, G_Item_Code, true);
		            grdItem.SetCellBold( 1, G_Out_Qty,   grdItem.rows-1, G_Out_Qty,   true); 
		            grdItem.SetCellBold( 1, G_Amount,    grdItem.rows-1, G_Amount,    true);
		            grdItem.SetCellBold( 1, G_Total_Amt, grdItem.rows-1, G_Total_Amt, true);
		            
		            if ( lstGridType.value == '10' )
		            {
		                grdItem.Subtotal( 0, 2, -1, '7!10!12!13');
		            }
		            else if ( lstGridType.value == '20' )
		            {
		                grdItem.Subtotal( 0, 2, 0, '7!10!12!13');
		            }
		            else if ( lstGridType.value == '30' )
		            {
		                grdItem.Subtotal( 0, 2, 1, '7!10!12!13');
		            } 	
		            
		            data_bini00090_1.Call("SELECT");
		        }    
            break;            	            
      }	 
 }
 //===============================================================
 
function OnReport()
{     
    switch (lstReportType.value)
    {
        case '10' :   
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00090.aspx?p_tin_warehouse_pk='+ lstWH.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value +'&p_ref_no_vendor='+txtRefNoSupplier.text+'&p_item='+txtItem.text;
            window.open(url);                
        break;     
        case '20' :   
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00091.aspx?p_tin_warehouse_pk='+ lstWH.value +'&p_from_date='+ dtFrom.value +'&p_to_date='+ dtTo.value;
            window.open(url);                
        break;   
    }     
}
 //===============================================================
 function OnChangeTab(pos)
 {
    switch(pos)
    {
        case 'radType':
            var strRad = radType.GetData();
                     
	        switch (strRad)
	        {
		        case 'Item':        		    
		            grdItem.style.display  = "";        		      
		            grdGroup.style.display = "none";		     
                break;
                
                case 'Group':
		            grdItem.style.display  = "none";        		      
		            grdGroup.style.display = "";			    	   		    
                break;	
            }                
        break;
    } 
 }
 //===============================================================

</script>

<body>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_bini00090" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="inv.sp_sel_bini00090" > 
                <input bind="grdItem" >
                    <input bind="lstWH" />
				    <input bind="dtFrom" />
                    <input bind="dtTo" />                
                    <input bind="txtRefNoSupplier" />
                    <input bind="txtItem" />
                </input>
                <output bind="grdItem" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_bini00090_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="inv.sp_sel_bini00090_1" > 
                <input bind="grdGroup" >
                    <input  bind="lstWH" />
				    <input bind="dtFrom" />
                    <input bind="dtTo" />                
                    <input bind="txtRefNoSupplier" />
                    <input bind="txtItem" />
                </input>
                <output bind="grdGroup" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <table border="1" style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 100%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            No/Sup/Line
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtRefNoSupplier" styles='width:100%' onenterkey="OnSearch('Detail')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Report
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:list id="lstReportType" styles='width:100%;' />
                        </td>
                        <td align="right" style="white-space: nowrap; width: 5%">
                            <gw:imgbtn id="ibtnReport" img="excel" alt="Report" text="Report" onclick="OnReport()" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:list id="lstWH" styles="width:100%;" />
                        </td>
                        <td style="width: 5%" align="right">
                            Item
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('Detail')" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Sub Total
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:list id="lstGridType" styles='width:100%;' />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Detail')" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%" align="left" colspan="7">
                            <gw:radio id="radType" value="Item" styles="width:100%" onchange="OnChangeTab('radType')"> 
                                <span value="Item"  id="tab_Item">Item</span> 
                                <span value="Group" id="tab_Group">Group</span> 
                            </gw:radio>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td>
                <gw:grid id='grdItem' header='W/H|Out Date|Slip No|Ref No|Seq|Item Code|Item Name|Out Qty|UOM|U/P|Amount|VAT(%)|VAT Amt|Total Amt|CYY|Supplier|Line|P/L|Description'
                    format='0|4|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|3|1|0|3|3|3|3|1|0|0|0|0'
                    check='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='2000|1200|1200|1200|800|1500|2500|1200|1000|1200|1200|1200|1200|1200|1000|2000|2000|2000|1000'
                    sorting='T' styles='width:100%; height:100%' />
                <gw:grid id='grdGroup' header='W/H|Out Date|Slip No|Ref No|Seq|Item Code|Item Name|Out Qty|UOM|U/P|Amount|VAT(%)|VAT Amt|Total Amt|CYY|Supplier|Line|P/L|Description'
                    format='0|4|0|0|0|0|0|1|0|1|1|0|1|1|0|0|0|0|0' aligns='0|1|0|0|1|0|0|3|1|0|3|3|3|3|1|0|0|0|0'
                    check='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='2000|1200|1200|1200|800|1500|2500|1200|1000|1200|1200|1200|1200|1200|1000|2000|2000|2000|1000'
                    sorting='T' styles='width:100%; height:100%' group="T" />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
