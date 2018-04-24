<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">

<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<head>
    <title>Goods Delivery Checking 2</title>
</head>

<script>
 
 var G_CUSTOMER     = 0,
 	 G_ORD_DATE     = 1,
 	 G_DELI_LOC		= 2,
     G_TR_DATE      = 3,
	 G_SLIP_NO		= 4,
     G_REF_NO       = 5,
     G_SEQ          = 6,
     G_ITEM_CODE    = 7,
     G_ITEM_NAME    = 8,
     G_UOM          = 9,
	 G_LOT_NO		= 10,
     G_TR_QTY       = 11,
     G_UP           = 12,
     G_ITEM_AMT     = 13,
     G_VAT_RATE     = 14,
     G_VAT_AMT      = 15,
     G_TOTAL_AMT    = 16,
     G_CCY          = 17,
	 G_SEL_CCY		= 18,
	 G_WH           = 19,
	 G_CHARGER		= 20,
	 G_GD_TYPE      = 21,
     G_REMARK       = 22;
  
 //===============================================================
 function BodyInit()
 { 
    System.Translate(document); 
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //-----------------
    System.Translate(document);  // Translate to language session
    //----------------
    FormatGrid();
    OnChangeTab('chkGroup');
    //----------------    
    
 }
 //===============================================================

 function FormatGrid()
 {        
		var data = "";
		
        data = "data|10|Grand Total|20|Cust Subtotal|30|Cust/Date Subtotal";
        lstGridType.SetDataText(data);  
        lstGridType.value = '10'; 
		
        data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
        lstCurrency.SetDataText(data);
		
        data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0304') FROM DUAL" )%>||Select All";    
        lstInOutType.SetDataText(data);
		lstInOutType.value = "";			

		data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGSA7020') FROM DUAL" )%>||Select All";    
        lstGDType.SetDataText(data);
		lstGDType.value = "";
		
		data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGSA1020') FROM DUAL" )%>||Select All"; 
    	lstOrderType.SetDataText(data);
    	lstOrderType.value = '';
		
		data = "<%=ESysLib.SetListDataFUNC("SELECT LG_F_LOGISTIC_CODE('LGIN0210') FROM DUAL" )%>||Select All";
    	lstWHType.SetDataText(data);
    	lstWHType.value = '';

		
	             
		data = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || ' * ' || grp_nm from TLG_IT_itemgrp where del_if = 0 and use_yn = 'Y' order by grp_cd ")%>||Select All";
    	lstItemGroup.SetDataText(data);
    	lstItemGroup.value = ''; 
    	
    	data = "<%=ESysLib.SetListDataFUNC("select lg_get_report_lst2('dscd00030',1) FROM DUAL")%>";
        lstReportType.SetDataText(data);  
					 
        grdGDItem.GetGridControl().MergeCells  = 2 ;	
        grdGDItem.GetGridControl().MergeCol(0) = true ;	
        grdGDItem.GetGridControl().MergeCol(1) = true ;   	
        grdGDItem.GetGridControl().MergeCol(2) = true ;	
		grdGDItem.GetGridControl().MergeCol(3) = true ;	
		grdGDItem.GetGridControl().MergeCol(4) = true ;	
		grdGDItem.GetGridControl().MergeCol(5) = true ;	
        //------------
        var ctrl = grdGDItem.GetGridControl();
        ctrl.ColFormat(G_TR_QTY)    = "###,###,###.###" ;
        ctrl.ColFormat(G_UP)        = "###,###,###.###" ;
        ctrl.ColFormat(G_ITEM_AMT)  = "###,###,###.###" ;
        ctrl.ColFormat(G_VAT_RATE)  = "###,###,###.###" ;
        ctrl.ColFormat(G_VAT_AMT)   = "###,###,###.###" ;
        ctrl.ColFormat(G_TOTAL_AMT) = "###,###,###.###" ;
		ctrl.ColFormat(G_SEL_CCY)   = "###,###,###.###" ;
        
        var ctrl = grdGDGroup.GetGridControl();
        ctrl.ColFormat(G_TR_QTY)    = "###,###,###.###" ;
        ctrl.ColFormat(G_UP)        = "###,###,###.###" ;
        ctrl.ColFormat(G_ITEM_AMT)  = "###,###,###.###" ;        
        ctrl.ColFormat(G_VAT_RATE)  = "###,###,###.###" ;   
        ctrl.ColFormat(G_VAT_AMT)   = "###,###,###.###" ;     
        ctrl.ColFormat(G_TOTAL_AMT) = "###,###,###.###" ;
		ctrl.ColFormat(G_SEL_CCY)   = "###,###,###.###" ;
		
		grdGDItem.GetGridControl().Cell( 7 , 0 , G_SEL_CCY , 0, G_SEL_CCY ) = 0x3300cc;         
 }

 //===============================================================
 
 function OnSearch()
 {
    switch(chkGroup.value)
    {
        case 'N':
            data_dscd00030.Call("SELECT");
        break;
        
        case 'Y':
            grdGDGroup.GridRefresh();
            data_dscd00030_1.Call("SELECT");
        break;
    }
 }
 
 //===============================================================
 function OnDataReceive(obj)
 {
      switch (obj.id)         
      {
            case 'data_dscd00030' :
			    if ( grdGDItem.rows > 1 )
		        {            
		            grdGDItem.SetCellBold( 1, G_ITEM_CODE, grdGDItem.rows-1, G_ITEM_CODE, true);
		            grdGDItem.SetCellBold( 1, G_TR_QTY,    grdGDItem.rows-1, G_TR_QTY,    true); 
		            grdGDItem.SetCellBold( 1, G_TOTAL_AMT, grdGDItem.rows-1, G_TOTAL_AMT, true);
		            
		            if ( lstGridType.value == '10' )
		            {
		                grdGDItem.Subtotal( 0, 2, -1, '11!13!15!16!18');
		            }
		            else if ( lstGridType.value == '20' )
		            {
		                grdGDItem.Subtotal( 0, 2, 0, '11!13!15!16!18');
		            }
		            else if ( lstGridType.value == '30' )
		            {
		                grdGDItem.Subtotal( 0, 2, 1, '11!13!15!16!18');
		            } 	
		        }    
            break;           	            
      }	 
 }
 //===============================================================
 
function OnReport()
{     
    var url =System.RootURL + "/reports/ds/cd/"+lstReportType.value+"?p_from_date=" + dtFrom.value + "&p_to_date=" + dtTo.value + "&p_order_type=" + lstOrderType.value;  
            url += "&p_po_vendor=" + txtPOVendor.text + "&p_item_group_pk=" + lstItemGroup.value + "&p_item=" + txtItem.text + "&p_type=" + radSearchType.value;
            url += "&p_inout_type=" + lstInOutType.value + "&p_wh_type=" + lstWHType.value + "&p_wh_pk=" + lstWareHouse.value+"&p_gd_type="+lstGDType.value;
			
            System.OpenTargetPage(url);
}
 
function OnReport_old(para)
{     
    switch (para)
    {
	
		//-------
        case 'ST01' :   
           
            var url =System.RootURL + "/reports/ds/cd/rpt_dscd00030_ST01.aspx?p_from_date=" + dtFrom.value + "&p_to_date=" + dtTo.value + "&p_order_type=" + lstOrderType.value;  
            url += "&p_po_vendor=" + txtPOVendor.text + "&p_item_group_pk=" + lstItemGroup.value + "&p_item=" + txtItem.text + "&p_type=" + radSearchType.value;
            url += "&p_inout_type=" + lstInOutType.value + "&p_wh_type=" + lstWHType.value + "&p_wh_pk=" + lstWareHouse.value;
			
            System.OpenTargetPage(url);
        break; 

		case 'ST02' :   
           
            var url =System.RootURL + "/reports/ds/cd/rpt_dscd00030_ST02.aspx?p_from_date=" + dtFrom.value + "&p_to_date=" + dtTo.value + "&p_order_type=" + lstOrderType.value;  
            url += "&p_po_vendor=" + txtPOVendor.text + "&p_item_group_pk=" + lstItemGroup.value + "&p_item=" + txtItem.text + "&p_type=" + radSearchType.value;
            url += "&p_inout_type=" + lstInOutType.value + "&p_wh_type=" + lstWHType.value + "&p_wh_pk=" + lstWareHouse.value;
			
            System.OpenTargetPage(url);
        break;  		
		
        case '10' :   
           
		   var url =System.RootURL + '/reports/ds/cd/rpt_dscd00030.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value + '&p_order_type=' + lstOrderType.value + '&p_po_vendor=' + url_encode(txtPOVendor.text) + '&p_item_group=' + lstItemGroup.value + '&p_item=' + url_encode(txtItem.text) +'&p_searchtype=' + radSearchType.value + '&p_curr=' + lstCurrency.value + ' &p_io_type=' + lstInOutType.value + '&p_sale_yn='+ chkSalePrice.value + '&p_wh_type=' + lstWHType.value + '&p_wh_pk='+ lstWareHouse.value;
           window.open(url);  
        break;     
        //-------
        case '20' :   
           /*var url =System.RootURL + '/reports/ep/bp/rpt_dscd00030_1.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value + '&p_po_vendor=' + url_encode(txtPOVendor.text) +'&p_item=' + url_encode(txtItem.text) ;
           window.open(url);   */
		   
            var url =System.RootURL + "/reports/ds/cd/rpt_dscd00030_ST01.aspx?p_from_date=" + dtFrom.value + "&p_to_date=" + dtTo.value + "&p_order_type=" + lstOrderType.value;  
            url += "&p_po_vendor=" + txtPOVendor.text + "&p_item_group_pk=" + lstItemGroup.value + "&p_item=" + txtItem.text + "&p_type=" + radSearchType.value;
            url += "&p_inout_type=" + lstInOutType.value + "&p_wh_type=" + lstWHType.value + "&p_wh_pk=" + lstWareHouse.value;
            System.OpenTargetPage(url);
        break;  
        //-------
        case '30' :   
           var url =System.RootURL + '/reports/ep/bp/rpt_dscd00030_1.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value + '&p_po_vendor=' + url_encode(txtPOVendor.text) +'&p_item=' + url_encode(txtItem.text) ;
           window.open(url);  
        break;  
        //-------
        case '40' :   
           var url =System.RootURL + '/reports/ep/bp/rpt_dscd00030_3.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value + '&p_po_vendor=' + url_encode(txtPOVendor.text) +'&p_item=' + url_encode(txtItem.text) ;
           window.open(url);  
        break;  
        //-------
        case '50' :   
           var url =System.RootURL + '/reports/ep/bp/rpt_dscd00030_4.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value + '&p_po_vendor=' + url_encode(txtPOVendor.text) +'&p_item=' + url_encode(txtItem.text) ;
           window.open(url);  
        break; 
        //-------   
        case '60' :   
           var url =System.RootURL + '/reports/ds/cd/rpt_dscd00031.aspx?p_from_date='+ dtFrom.value + '&p_to_date=' + dtTo.value;
           window.open(url);  
        break;                                           
    }     
}
 
 //===============================================================
 function OnChangeTab(pos)
 {
    switch(pos)
    {
        case 'chkGroup':
            var strRad = chkGroup.GetData();
                     
	        switch (strRad)
	        {
		        case 'N':        		    
		            grdGDItem.style.display  = "";        		      
		            grdGDGroup.style.display = "none";		     
                break;
                
                case 'Y':
		            grdGDItem.style.display  = "none";        		      
		            grdGDGroup.style.display = "";			    	   		    
                break;	
            }                
        break;
    } 
 }
  //===============================================================
 function OnChangeCurr()
 {
    	grdGDItem.SetGridText(0,G_SEL_CCY,lstCurrency.value +" Amt")
    	grdGDGroup.SetGridText(0,G_SEL_CCY,lstCurrency.value +" Amt")
 }
  
 //=================================================================
 
	function url_encode(s) 
	{
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
	
		for (var n = 0; n < string.length; n++) 
		{
	
			var c = string.charCodeAt(n);
	
			if (c < 128) 
			{
				utftext += String.fromCharCode(c);
			}
			else if ((c > 127) && (c < 2048)) 
			{
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else 
			{
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}
		return escape(utftext);
	}
	//==================================================================================================

	function OnPopUp(pos)
	{
		switch(pos)
		{
			case 'Report':
				var path = System.RootURL + '/form/ds/cd/dscd00031.aspx';
				var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
			break;
		}
	}
	
	//==================================================================================================

function OnPopUp_WH(obj_list,n)
{
//fpab00790   :  P0=USER_PK,P1=parent_pk,p2=not_in_wh_pk,p3=storage_type,p4=use_yn,p5=wh_type,p6=get_parent_yn
    
         var l_get_parent;
         if(n==1)
            l_get_parent='Y';
         else    
            l_get_parent='N';
        
        var path = System.RootURL + '/form/fp/ab/fpab00790.aspx?p0=0&p3=0'+'&p4=Y'+'&p6='+l_get_parent;
        var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
        if ( obj != null )
        {
            obj_list.value = obj[0];                 
        }
         
}

function ChangeColorItem(lstctl) {
        var slevel1, slevel2, slevel3, slevel4;
        for (var i = 0; i < lstctl.options.length; i++) {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......") {
                if (slevel3 == ".....") {
                    lstctl.options.item(i).style.color = "FF00FF";
                }
                else {
                    if (slevel2 == "...") {
                        lstctl.options.item(i).style.color = "0066CC";
                    }
                    else {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF4500";  //FF3333
                    }
                }
            }
        }
    }  	
 
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_dscd00030" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dscd00030" > 
                <input bind="grdGDItem" >
				    <input bind="dtFrom" />
                    <input bind="dtTo" />    
					<input bind="lstOrderType" />
                    <input bind="txtPOVendor" />
					<input bind="lstItemGroup" />
                    <input bind="txtItem" />
					<input bind="radSearchType" />
                    <input bind="lstCurrency" />
					<input bind="lstInOutType" />					 
					<input bind="chkSalePrice" />
					<input bind="lstWHType" />
					<input bind="lstWareHouse" />
					<input bind="lstGDType"	/>
                </input>
                <output bind="grdGDItem" />
            </dso>
        </xml>
    </gw:data>
    <!-------------------------------------------------------------------------->
    <gw:data id="data_dscd00030_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_dscd00030_1" > 
                <input bind="grdGDGroup" >
				    <input bind="dtFrom" />
                    <input bind="dtTo" />     
					<input bind="lstOrderType" />					
                    <input bind="txtPOVendor" />
					<input bind="lstItemGroup" />
                    <input bind="txtItem" />
					<input bind="radSearchType" />
                    <input bind="lstCurrency" />
					<input bind="lstInOutType" />					 
					<input bind="chkSalePrice" />
					<input bind="lstWHType" />
					<input bind="lstWareHouse" />		
					<input bind="lstGDType"	/>	
                </input>
                <output bind="grdGDGroup" />
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
                        <td style="width: 10%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Application("Lang")%>" mode="01" onchange="" />
                            ~
                            <gw:datebox id="dtTo" lang="<%=Application("Lang")%>" mode="01" onchange="" />							 
                        </td>
                        <td style="width: 5%" align="right">
                            No/Cust
                        </td>
						<td style="width: 25%; white-space: nowrap"  >
                            <gw:list id="lstOrderType" styles='width:100%;' onchange="OnSearch()"  />
                        </td>
                        <td style="width: 20%; white-space: nowrap"  >
                            <gw:textbox id="txtPOVendor" styles='width:100%' onenterkey="OnSearch()" />
                        </td>
						
						
						<td align="right" style="white-space: nowrap; width: 5%">Sub Total</td>
                        <td colspan=4 align="right" style="white-space: nowrap; width: 25%">
                            <gw:list id="lstGridType" styles='width:100%;' />
                        </td>
						
                    </tr>
                    <tr style="height: 2%">
						 
                        <td style="width: 15%; white-space: nowrap;background-color: CCFFFF" align="center" colspan=2 >						                            							
							
							<gw:radio id="radSearchType" value="OUT" styles="width:100%" onchange="OnSearch()" >
								<span value="REQ"  id="tab_REQ">REQ</span> 
                                <span value="OUT"  id="tab_OUT">OUT</span> 
                                <span value="RETURN" id="tab_RETURN">RETURN</span> 
                            </gw:radio>														
							
                        </td>
                        <td style="width: 5%" align="right">
                            Item
                        </td>
						<td style="width: 25%; white-space: nowrap"   >
                            <gw:list id="lstItemGroup" styles='width:100%;' onchange="OnSearch()"  />
                        </td>
                        <td style="width: 20%; white-space: nowrap"   >
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
												
                        <td align="right" style="white-space: nowrap; width: 5%">
                            G/D Type
                        </td>
                        <td align="right" style="white-space: nowrap; width: 25%" colspan=3 >
                            <gw:list id="lstGDType" styles='width:100%;' />
                        </td>
												
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
 					<tr style="height: 2%">
						 
                        <td style="width: 20%; white-space:nowrap" align="center" colspan=2 >						                            														
							<gw:checkbox id="chkGroup" defaultvalue="Y|N" value="N" onchange="OnChangeTab('chkGroup')" /> <b style="color: Purple">Group</b>	
														
							<gw:checkbox id="chkSalePrice" defaultvalue="Y|N" value="Y" onchange="OnSearch()" /> <b style="color: Blue">S/O Price</b>																					
                        </td>
						
                        <td align="RIGHT" style="width: 5%; white-space: nowrap">
							<a title="W/H" onclick="OnPopUp_WH(lstWareHouse,1)" href="#tips" style="color: #0000ff">
                                <b>W/H</b></a>
						</td> 
						<td style="width: 25%; white-space: nowrap" >  
							<gw:list id="lstWHType" styles="width:100%" onchange="" />
							
                        </td>
                        <td style="width: 20%; white-space: nowrap" >  
							<gw:list  id="lstWareHouse" value='ALL' maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT to_char(w.pk), LPAD ('.', LEVEL * 2 - 1, '.')|| w.wh_id||' * ' || w.wh_name wh_name FROM tlg_in_warehouse w WHERE w.del_if = 0 AND w.use_yn = 'Y' START WITH NVL (w.parent_pk, 0) = 0 CONNECT BY PRIOR w.pk = w.parent_pk ORDER SIBLINGS BY w.wh_id")%>||Select All
                            </data>
                        </gw:list>
                        </td>
						<td align="RIGHT" styles="width:100%; white-space:nowrap" >
							Slip Type 
						</td> 
                        <td colspan=3 >
                            <gw:list id="lstInOutType" styles="width:100%" onchange="" />
                        </td>
						 
                        <td style="width: 5%" align="right">
                            
                        </td>
                    </tr>		
                    <tr>
                        <td align="right" style="white-space: nowrap; width: 3%">&nbsp;</td>
                        <td align="right" style="white-space: nowrap; width: 3%">&nbsp;</td>
                        
                        
                        <td align="right" style="white-space: nowrap; width: 3%">CCY</td>
                        <td align="right" style="white-space: nowrap; width: 8%">
                            <gw:list id="lstCurrency" styles='width:100%;' onchange="OnChangeCurr()" />
                        </td>
                        <td align="right" style="white-space: nowrap; width: 3%">&nbsp;</td>
                        <td align="right" style="white-space: nowrap; width: 3%">Report List</td>	
                        <td colspan=3><gw:list id="lstReportType" styles='width:100%;' /></td>					                       
						
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="ibtnReport" img="excel" alt="Report" text="Report" onclick="OnReport()" />
                        </td>
                    </tr>			
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="2">
                <gw:grid id="grdGDItem" 
                    header="Customer|Ord Date|Deli Loc|Tr Date|Slip No|Ref No|Seq|Item Code|Item Name|UOM|Lot No|Out Qty|U/P|Item Amt|VAT (%)|VAT Amt|Total Amt|CCY|Amt|W/H|Charger|G/D Type|Remark"					         
                    format="0|4|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    aligns="0|1|0|1|0|1|1|0|0|1|1|3|3|3|3|3|3|1|3|0|0|0|0"					 
                    defaults="|||||||||||||||||||||||" 
					editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    widths="2000|1200|1500|1200|1500|1500|800|1500|3000|1000|1200|1200|1200|1200|1200|1200|1200|800|1200|1500|1500|1200|1000"
                    styles="width:100%; height:100%" param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" />
                <gw:grid id="grdGDGroup" 
					header="Customer|Ord Date|Deli Loc|Date|Slip No|Ref No|Seq|Item Code|Item Name|UOM|Lot No|Tr Qty|U/P|Item Amt|VAT (%)|VAT Amt|Total Amt|CCY|Amt|W/H|G/D Type|Remark"
                    format="0|4|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    aligns="0|1|0|1|0|1|1|0|0|1|1|3|3|3|3|3|3|1|3|0|0|0"					 
                    defaults="||||||||||||||||||||||" 
					editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    widths="2000|1200|1500|1200|1500|1500|800|1500|3000|1000|1200|1200|1200|1200|1200|1200|1200|800|1200|1500|1200|1000"
                    styles="width:100%; height:100%" param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" group="T" />
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------->
</body>
</html>
