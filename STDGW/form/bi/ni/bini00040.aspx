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

 var G_WAREHOUSE	= 0,
	 G_SUPPLIER     = 1,
     G_DATE      	= 2,
     G_SLIP_NO      = 3,
     G_SEQ          = 4,
	 G_REF_NO		= 5,
     G_ITEM_CODE    = 6,
     G_ITEM_NAME    = 7,
     G_UOM          = 8,
     G_PO_QTY       = 9,
     G_IN_QTY       = 10,      
     G_UNIT_PRICE   = 11,
	 G_ITEM_AMOUNT	= 12,
     G_TAX_AMOUNT   = 13,
     G_TOTAl_AMOUNT = 14,     
     G_CCY          = 15,	 
     G_REMARK       = 16;
 //===============================================================
 function BodyInit()
 { 
 
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //-----------------
    System.Translate(document);  // Translate to language session
    //----------------
    FormatGrid();     
    //----------------    
 }
 //===============================================================

 function FormatGrid()
 {
		//------------
		data = "<%=ESysLib.SetListDataSQL("select a.pk, lpad('-',level ,'-')||a.grp_cd || ' - ' || a.grp_nm from tlg_it_itemgrp a where a.del_if = 0 and a.use_yn='Y' connect by prior a.pk = A.P_PK start with A.P_PK is null order siblings by grp_cd ")%>||";
    	lstGroup.SetDataText(data);
    	lstGroup.value = '';
		//------------
		data = "<%=ESysLib.SetListDataFUNC("SELECT LG_F_LOGISTIC_CODE('LGIN0210') FROM DUAL" )%>||Select ALL";
		lstWHType.SetDataText(data);
		lstWHType.value = '';

		data = "<%=ESysLib.SetListDataSQL("select pk, wh_id || ' * ' || wh_name from TLG_in_warehouse where del_if = 0 and use_yn='Y' order by wh_id")%>";
		lstWarehouse.SetDataText( data + "||");
		lstWarehouse.value = '';
        //------------     
        grdDetail.GetGridControl().MergeCells  = 2 ;	
        grdDetail.GetGridControl().MergeCol(0) = true ;	
        grdDetail.GetGridControl().MergeCol(1) = true ;   	
        grdDetail.GetGridControl().MergeCol(2) = true ;	
		grdDetail.GetGridControl().MergeCol(3) = true ;	
		grdDetail.GetGridControl().MergeCol(4) = true ;	
        //------------
        var ctrl = grdDetail.GetGridControl();
        ctrl.ColFormat(G_PO_QTY)     	= "###,###,###.##" ;
        ctrl.ColFormat(G_IN_QTY)     	= "###,###,###.##" ;
        ctrl.ColFormat(G_UNIT_PRICE)    = "###,###,###" ;
        ctrl.ColFormat(G_ITEM_AMOUNT)   = "###,###,###" ;
        ctrl.ColFormat(G_TAX_AMOUNT)    = "###,###,###" ;
        ctrl.ColFormat(G_TOTAl_AMOUNT)  = "###,###,###" ;

 }

 //===============================================================
 
 function OnSearch(pos)
 {
    if(pos == 'Item')
    {
        data_bini00040.Call("SELECT");
    }
 }
 
 //===============================================================
 function OnDataReceive(obj)
 {
      switch (obj.id)         
      {
            case 'data_bini00040' :
			    if ( grdDetail.rows > 1 )
		        {            		            		           
		            grdDetail.Subtotal( 0, 2, -1, '9!10!12!13!14');
		           
		        }    
            break;           	            
      }	 
 }
 //===============================================================
 
function OnReport(pos)
{       	
	switch(pos)
	{
		case 'FOSE01':

            var url =System.RootURL + '/reports/bi/ni/rpt_bini00040_FOSE01.aspx?p_wh_type=' + lstWHType.value + '&p_wh_pk=' + lstWarehouse.value + '&p_from_dt=' + dtFrom.value + '&p_to_dt=' + dtTo.value + '&p_po_vendor=' + txtPOVendor.text + '&p_itemgrp_pk=' + lstGroup.value + '&p_item=' + txtItem.text;
            window.open(url, "_blank");
       
        break;	
		
		case 'SG01':
			var url =System.RootURL + '/reports/bi/ni/rpt_bini00040_SG01.aspx?p_wh_type=' + lstWHType.value + '&p_wh_pk=' + lstWarehouse.value + '&p_from_dt=' + dtFrom.value + '&p_to_dt=' + dtTo.value + '&p_po_vendor=' + txtPOVendor.text + '&p_itemgrp_pk=' + lstGroup.value + '&p_item=' + txtItem.text;
			System.OpenTargetPage(url); 		
		break;
    }	
     
}
 //=================================================================
 
 function OnPopUp(pos)
 {
	switch(pos)
	{
		case 'REPORT':
			var path = System.RootURL + '/form/bi/ni/bini00041.aspx';       		
			var object = window.showModalDialog( path , this , 'resizable:yes;toolbar=no;dialogWidth:30;dialogHeight:20');				
		break;
	}
 }
 
 //=================================================================
</script>
<body>
	<!---------------------------------------------------------------->
    <gw:data id="pro_bini00040" onreceive="OnDataReceive(this)">
        <xml>
            <dso  type="list" procedure="<%=l_user%>lg_pro_bini00040" >
                <input>
                    <input bind="lstWHType" />
                </input>
                <output>
                    <output bind="lstWarehouse" />
                </output>
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_bini00040" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_bini00040" > 
                <input bind="grdDetail" >
					<input bind="lstWHType" />
					<input bind="lstWarehouse" />
				    <input bind="dtFrom" />
                    <input bind="dtTo" />                
                    <input bind="txtPOVendor" />
					<input bind="lstGroup" />
                    <input bind="txtItem" />					 
                </input>
                <output bind="grdDetail" />
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
                            W/H
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:list id="lstWHType" styles='width:100%' onchange="pro_bini00040.Call()" />
                        </td>						
                        <td align="right" style="white-space: nowrap; width: 15%">
                            <gw:list id="lstWarehouse" styles='width:100%;' />
                        </td>  
						
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                        </td>
						
                        <td style="width: 5%" align="right">
                            PO/Supplier
                        </td>
                        <td style="width: 10%; white-space: nowrap" colspan="2">
                            <gw:textbox id="txtPOVendor" styles='width:100%' onenterkey="OnSearch('Item')" />
                        </td>
											
						<td style="width: 5%" align="right">
                            Group
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:list id="lstGroup" styles='width:100%' />
                        </td>
                        <td style="width: 10%; white-space: nowrap">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('Item')" />
                        </td>                        																							
						<td style="width: 3%" align="right">
                            
                        </td>						
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnReport" styles="" img="excel" alt="Report" text="Report" onclick="OnPopUp('REPORT')" /> 
                        </td>
						<td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('Item')" />
                        </td>
                    </tr>                  
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="2">
                <gw:grid id='grdDetail' 
					header='W/H|Supplier|Date|Slip No|Seq|Ref No|Item Code|Item Name|UOM|P/O Qty|In Qty|U/Price|Item Amount|Tax Amount|Total Amount|CCY|Remark'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					aligns='0|0|1|0|1|0|0|0|1|3|3|3|3|3|3|1|0'
					editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
					widths='2000|2000|1200|1200|800|1500|1500|3000|800|1200|1200|1200|1500|1500|1500|800|1000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
