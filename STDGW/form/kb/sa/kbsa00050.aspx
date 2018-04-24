<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Sale Maket Price Setting</title>
</head>

<script>
var G_PRICE_PK 		= 0,
    G_MARKET        = 1,
	G_GRP           = 2,
	G_TCO_ITEM_PK   = 3,
	G_ITEM_CODE     = 4,
	G_ITEM_NAME     = 5,
	G_UOM           = 6,
	G_UNIT_PRICE    = 7,
	G_CYY           = 8,
	G_PRICE_TYPE    = 9,
	G_APPLY_DT      = 10,
	G_USE_YN        = 11,
	G_PRICE_BY      = 12,    
	G_REMARK        = 13;

	
var arr_FormatNumber = new Array();	
//------------------------------------------------------------ 
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    data_kbsa00050.Call('SELECT')
} 

//------------------------------------------------------------

function BindingDataList()
{
	 var data = '';
	 
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGKB0240') FROM DUAL" )%>||";    
     lstMarket.SetDataText(data); 
	 lstMarket.value = '' ;
	 
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>||";    
     lstPriceType.SetDataText(data); 
	 lstPriceType.value = '' ;
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>||";    
     lstCurrency.SetDataText(data);
	 lstCurrency.value = '' ;
        
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code ||' - '|| a.code_nm  FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGKB0240' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm " ) %> ";       
     grdItem.SetComboFormat(G_MARKET,data); 
     
      data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code ||' - '|| a.code_nm  FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGKB0220' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm " ) %> ";       
     grdItem.SetComboFormat(G_GRP,data);     
        
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code ||' - '|| a.code_nm  FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGCM0130' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm " ) %> ";       
     grdItem.SetComboFormat(G_PRICE_TYPE,data);   
     
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code   FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGCM0100' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm " ) %> ";       
     grdItem.SetComboFormat(G_CYY,data);	      
        
        
	 var trl = grdItem.GetGridControl();      	
     trl.ColFormat(G_UNIT_PRICE )     = "###,###,###,###,###.##";
	 
	 arr_FormatNumber[G_UNIT_PRICE] = 6;  
}	



//-------------------------------------------------------------- 
function OnDataReceive(p_oData)
{
    switch (p_oData.id)
    {
       
		
		case 'data_kbsa00050_1':
		    if (grdItem.rows >1)
		    {
		        grdItem.SetCellBold( 1, G_UNIT_PRICE, grdItem.rows-1, G_UNIT_PRICE,   true);
		        grdItem.SetCellBgColor( 1, G_UNIT_PRICE,     grdItem.rows - 1, G_UNIT_PRICE,     0xCCFFFF );
		    }
		    /*if (chkCus.value=="Y" && txtPartnerPK.text !="" )
		    {
		        for(var i = 1 ; i< grdItem.rows ; i++)
		        {
		            if(grdItem.GetGridData(i,G_BILL_TO_PK)=="") 
		            {
		                grdItem.SetGridText(i,G_BILL_TO_PK,txtPartnerPK.text)
		                grdItem.SetGridText(i,G_partner_nm,txtPartnerName.text)
		            }
		        }
		    }*/
		    
        break;
        
        case 'pro_kbsa00050_1' :
            alert( txtReturnValue.text );
            data_kbsa00050_1.Call('SELECT')
        break;
		
		case 'pro_kbsa00050_2' :
            alert( txtReturnValue.text );
        break;
    }
}
//--------------------------------------------------------
function OnSearch()
{        
        data_kbsa00050_1.Call("SELECT");   
}
//--------------------------------------------------------
function onExcel()
{
    if ( radSearchPage.value == 1 )
    {
        var url =System.RootURL + '/reports/ag/ci/kbsa00050.aspx?Item_CD=' + txtItem.text+'&Item_GP=' +txtGroup_PK.text;
        window.open(url);    
    }
    else
    {
        var url =System.RootURL + '/reports/ag/ci/kbsa00050_1.aspx?Item_CD=' + txtItem.text+'&Item_GP=' +txtGroup_PK.text;
        window.open(url);    
    }     
}
//--------------------------------------------------------
function Upcase()
{
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}

//-------------------------------------------------------
 function OnEdit(grid)
 {
    col = event.col ;
    //----------
		if (col == G_UNIT_PRICE)
		{
		    if(!isNaN(grid.GetGridData(event.row, G_UNIT_PRICE)))
		    {
			    var vUPRICE = Number(grid.GetGridData( row, G_UNIT_PRICE ));
			    grid.SetGridText( row, G_UNIT_PRICE, System.Round(vUPRICE,arr_FormatNumber[G_UNIT_PRICE]));
	        }
	        else
	        {
	            grid.SetGridText( event.row, G_UNIT_PRICE, "");
	        }
		}
 }
//====================================================================== 
 function OnProcess(pos)
 {
 	switch(pos)
	{
		case 'GENE-ITEM':
			if ( txtGroup_PK.text != '' )
		    {
		        if ( confirm("Are you want to generate unit price for item ?") )
		        {
		            pro_kbsa00050_1.Call();
		        }    
		    }  
			else
			{
				alert('Pls select one Group.');
			}  			
		break;
		
		case 'SO-RESET':
			/*if ( txtPartnerPK.text != '' )
		    {
				if ( grdItem.row > 0 )
				{
					txtItemPK.text = grdItem.GetGridData( grdItem.row, G_TCO_ITEM_PK);
					
					if ( confirm("Do you want to reset unit price for Sale Order ?") )
		        	{
		            	pro_kbsa00050_2.Call();
		        	} 
				}
				else
				{
					alert('Pls select one Item.');
				}		           
		    } 
			else
			{
				alert('Pls select one Customer.');
			}   */
		break;
	}    
 }
//====================================================================== 

 function OnSave()
 {
        if ( confirm("Are you want to save change of item ?") )
        {
            data_kbsa00050_1.Call();
        }     
 }
//======================================================================
function OnCellDoubleClick()
{
    var col=event.col;
    var row=event.row;
    if(row>0 && col==G_partner_nm)
    {
         var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
         if ( object != null )
         {	         
            grdItem.SetGridText(row,G_BILL_TO_PK,object[0]);
            grdItem.SetGridText(row,G_partner_nm,object[2]);                                   
         }
    }
}
//====================================================================== 
function OnAddNew()
{
    var path = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y";
	var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
     if ( object != null )
       {
            for( var i=0; i < object.length; i++)	  
            {	
                var arrTemp = object[i];
                grdItem.AddRow();     
                grdItem.SetGridText( grdItem.rows-1, G_TCO_ITEM_PK,   arrTemp[0] );
                grdItem.SetGridText( grdItem.rows-1, G_ITEM_CODE, arrTemp[1] );
                grdItem.SetGridText( grdItem.rows-1, G_ITEM_NAME, arrTemp[2] );
                grdItem.SetGridText( grdItem.rows-1, G_UOM, arrTemp[5] );
               // grdItem.SetGridText( grdItem.rows-1, G_MARKET, arrTemp[5] );
                //grdItem.SetGridText( grdItem.rows-1, G_PRICE_TYPE, arrTemp[5] );
                grdItem.SetGridText( grdItem.rows-1, G_USE_YN, -1 );
            }		
       }  
}
//==================================================================================
 function OnDeleteItem()
 {
    var ctrl = grdItem.GetGridControl();

	var row  = ctrl.row;
		
	if ( row < 0 ) 
	{			
			alert("Please select one row to delete .");
	}			
	else 
	{
		if ( grdItem.GetGridData( ctrl.row, 0 ) == "" ) 
	    {						
		
				grdItem.RemoveRow();					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				grdItem.DeleteRow();
			}
		}
	}

 }
//==================================================================================
 function OnUnDeleteItem() 
 {
		
	grdItem.UnDeleteRow()
		
 }
//==================================================================================
function OnPopUp(obj)
{
    switch(obj)
    {
         
	        case'Price':
	             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGCM0130";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if(object !=null)
	             {
	                var data = '';
	                data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>||";    
                    lstPriceType.SetDataText(data); 
	             }
	        break;
	        
	        case'Market':
	             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0240";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if(object !=null)
	             {
	                var data = '';
	                data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGKB0240') FROM DUAL" )%>||";    
                    lstMarket.SetDataText(data); 
	             }
	        break;
    }
}

//==================================================================================
function window_onunload() {

}
//==================================================================================
</script>

<body onunload="return window_onunload()">
  
    <!-----------------grdItem ---------------------------------------->
    <gw:data id="data_kbsa00050_1" onreceive="OnDataReceive(this)"> 
            <xml> 
               <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="<%=l_user%>lg_sel_kbsa00050"  procedure="<%=l_user%>lg_upd_kbsa00050"  > 
                    <input bind="grdItem" > 
						<input bind="lstMarket" />
						 <input bind="txtItem" />
                        <input bind="lstPriceType" /> 
                        <input bind="lstCurrency" />  
                        <input bind="chkUseYN" />                         
                    </input> 
                    <output bind="grdItem" /> 
                </dso> 
            </xml> 
    </gw:data>

	<!---------------------------------------------------------------->
    <gw:data id="pro_kbsa00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_kbsa00050_2" > 
                <input>
              		<input bind="txtItemPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%; white-space: nowrap">
                <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Market')">Market</b>
            </td>
            <td style="width: 15%" colspan="3">
                 <gw:list id="lstMarket" styles='width:100%' />
            </td>           
            <td style="width: 5%; white-space: nowrap">
                Item
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch()" onkeypress="Upcase()" />
            </td>
            <td style="width: 5%; white-space: nowrap">
                 <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Price')">CCY</b>
            </td>
            <td style="width: 15%">
                <gw:list id="lstCurrency" styles='width:100%' />
            </td>
             <td style="width: 5%; white-space: nowrap">
                <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Price')">Price Type</b>
            </td>
            <td style="width: 15%" colspan="4">
                <gw:list id="lstPriceType" styles='width:100%' />
            </td>
            
           
             <td style="width: 1%" align="right">
                <gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
            </td>		 
            <td style="width: 1%" align="right">
                <gw:imgbtn id="ibtnExcel" img="excel" alt="Export to Excel" text="Export to Excel"
                    onclick="onExcel()" />
            </td>
            
        </tr>
        <tr>
           
            <td style="width: 95%; " colspan="10" align="left">
                     <gw:checkbox id="chkUseYN" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch()">Use YN</gw:checkbox>
             </td>
           
            <td style="width: 1%; background-color: CCFFFF" align="right">
                <gw:imgbtn id="ibtnProcess" img="process" alt="Get Price" text="View Spec" onclick="OnProcess('GENE-ITEM')" />
            </td>	
            <td style="width: 1%; background-color: CCFFFF" align="right">
                <gw:imgbtn id="ibtNew" img="new" alt="Add New" text="Add New" onclick="OnAddNew()" />
            </td>
            <td style="width: 1%; background-color: CCFFFF" align="right">
                <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDeleteItem()" />
            </td>
            <td style="width: 1%; background-color: CCFFFF" align="right">
                <gw:imgbtn id="ibtnUDelete" img="udelete" alt="Un Delete" text="UnDelete" onclick="OnUnDeleteItem()" />
            </td>
            <td style="width: 1%; background-color: CCFFFF" align="right">
                <gw:imgbtn id="ibtnSave" img="save" alt="Save" text="OnSave" onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="15">
            <gw:grid id='grdItem'
                    header='_PK|Market|Item Group|_TLG_IT_ITEM_PK|Item Code|Item Name|Unit|Unit Price|CCY|Price Type|Apply DT|Use YN|Price By|Remark'
                    format='0|0|0|0|0|0|0|0|0|0|4|3|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    check='|||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|1500|1500|0|1500|2000|1000|1500|1000|1500|1200|1000|1500|2000'
                    sorting='T'
                    autosize='T' 
                    acceptnulldate="true"
                    styles='width:100%; height:100%'
                    />
            </td>
        </tr>
    </table>
            
    <!---------------------------------------------------------------------->
    <gw:textbox id="txtGroup_PK" styles='width:100%;display:none;' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none;' />
	 <gw:textbox id="txtItemPK" styles='width:100%;display:none;' />
    <!---------------------------------------------------------------------->
</body>
</html>
