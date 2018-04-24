<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>ITEM PRICE CHECKING</title>
</head>

<script>
var G_PRICE_PK 		= 0,
	G_GRP_NAME      = 1,
	G_TCO_ITEM_PK   = 2,
	G_ITEM_CODE     = 3,
	G_ITEM_NAME     = 4,
	G_UOM           = 5,
	G_UNIT_PRICE    = 6
	G_CYY           = 7,
	G_PRICE_TYPE    = 8,
	G_BILL_TO_PK    = 9,
	G_partner_nm    = 10,
	G_SPEC1         = 11,
	G_SPEC2         = 12,
	G_SPEC3         = 13,
	G_SPEC4         = 14,
	G_SPEC5         = 15,
	G_SPEC6         = 16,
	G_SPEC7         = 17,
	G_SPEC8         = 18,
	G_SPEC9         = 19,
	G_SPEC10        = 20,
	G_USE_YN        = 21;
	
var arr_FormatNumber = new Array();	
//------------------------------------------------------------ 
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    data_dspc00080.Call('SELECT')
    txtPartnerName.SetEnable(false);
} 

//------------------------------------------------------------

function BindingDataList()
{
	 var data = '';
	 data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0130') FROM DUAL" )%>||";    
     lstPriceType.SetDataText(data); 
	 lstPriceType.value = '' ;
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>||";    
     lstCurrency.SetDataText(data);
	 lstCurrency.value = '' ;
        
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code ||' - '|| a.code_nm  FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGCM0130' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.code, a.code_nm " ) %> ";       
     grdItem.SetComboFormat(G_PRICE_TYPE,data);   
     
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.code,a.code   FROM TLG_lg_code a, TLG_lg_code_group b WHERE b.GROUP_ID = 'LGCM0100' AND a.TLG_lg_code_group_pk = b.pk   AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY 1 " ) %> ";       
     grdItem.SetComboFormat(G_CYY,data);	      
        
	 var trl = grdItem.GetGridControl();      	
     trl.ColFormat(G_UNIT_PRICE )     = "###,###,###,###,###.##";
	 
	 arr_FormatNumber[G_UNIT_PRICE] = 6;  
}	

//=================================================================================
function OnToggle(direction)
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }   
 }  
//------------------------------------------------------------
function OnTreeClick()
{ 
   var obj = event.srcElement.GetCurrentNode(); 
      
   txtGroup_PK.text  = '' + obj.oid; 

   OnSearch();
}

//-------------------------------------------------------------- 
function OnDataReceive(p_oData)
{
    switch (p_oData.id)
    {
        case 'data_dspc00080':
            OnSearch();
        break;
		
		case 'data_dspc00080_1':
		    if (grdItem.rows >1)
		    {
		        grdItem.SetCellBold( 1, G_UNIT_PRICE, grdItem.rows-1, G_UNIT_PRICE,   true);
		        grdItem.SetCellBgColor( 1, G_UNIT_PRICE,     grdItem.rows - 1, G_UNIT_PRICE,     0xCCFFFF );
		    }
		    if (chkCus.value=="Y" && txtPartnerPK.text !="" )
		    {
		        for(var i = 1 ; i< grdItem.rows ; i++)
		        {
		            if(grdItem.GetGridData(i,G_BILL_TO_PK)=="") 
		            {
		                grdItem.SetGridText(i,G_BILL_TO_PK,txtPartnerPK.text)
		                grdItem.SetGridText(i,G_partner_nm,txtPartnerName.text)
		            }
		        }
		    }
		    
        break;
        
        case 'pro_dspc00080_1' :
            alert( txtReturnValue.text );
            data_dspc00080_1.Call('SELECT')
        break;
		
		case 'pro_dspc00080_2' :
            alert( txtReturnValue.text );
        break;
		
		case 'pro_dspc00080_3' :
            alert( txtReturnValue.text );
        break;
		
    }
}
//--------------------------------------------------------
function OnSearch()
{        
        data_dspc00080_1.Call("SELECT");   
}
//--------------------------------------------------------
function onExcel()
{
    if ( radSearchPage.value == 1 )
    {
        var url =System.RootURL + '/reports/ag/ci/dspc00080.aspx?Item_CD=' + txtItem.text+'&Item_GP=' +txtGroup_PK.text;
        window.open(url);    
    }
    else
    {
        var url =System.RootURL + '/reports/ag/ci/dspc00080_1.aspx?Item_CD=' + txtItem.text+'&Item_GP=' +txtGroup_PK.text;
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
		            pro_dspc00080_1.Call();
		        }    
		    }  
			else
			{
				alert('Pls select one Group.');
			}  			
		break;
		
		case 'GENE-SO':
			if ( txtGroup_PK.text != '' )
		    {
		        if ( confirm("Are you want to update unit price for item from sale order?") )
		        {
		            pro_dspc00080_3.Call();
		        }    
		    }  
			else
			{
				alert('Pls select one Group.');
			}  			
		break;
		
		case 'SO-RESET':
			if ( txtPartnerPK.text != '' )
		    {
				if ( grdItem.row > 0 )
				{
					txtItemPK.text = grdItem.GetGridData( grdItem.row, G_TCO_ITEM_PK);
					
					if ( confirm("Do you want to reset unit price for Sale Order ?") )
		        	{
		            	pro_dspc00080_2.Call();
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
			}   
		break;
	}    
 }
//====================================================================== 

 function OnSave()
 {
        if ( confirm("Are you want to save change of item ?") )
        {
            data_dspc00080_1.Call();
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
    var i_row = grdItem.row
    if (i_row >0) 
    {
         grdItem.AddRow();
		 
         grdItem.SetGridText( grdItem.rows -1, G_GRP_NAME,    grdItem.GetGridData( i_row, G_GRP_NAME    ));
         grdItem.SetGridText( grdItem.rows -1, G_TCO_ITEM_PK, grdItem.GetGridData( i_row, G_TCO_ITEM_PK ));
         grdItem.SetGridText( grdItem.rows -1, G_ITEM_CODE,   grdItem.GetGridData( i_row, G_ITEM_CODE   ));
         grdItem.SetGridText( grdItem.rows -1, G_ITEM_NAME,   grdItem.GetGridData( i_row, G_ITEM_NAME   ));
         grdItem.SetGridText( grdItem.rows -1, G_UOM,         grdItem.GetGridData( i_row, G_UOM         ));
        
         grdItem.SetGridText( grdItem.rows -1, G_SPEC1,  grdItem.GetGridData( i_row, G_SPEC1 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC2,  grdItem.GetGridData( i_row, G_SPEC2 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC3,  grdItem.GetGridData( i_row, G_SPEC3 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC4,  grdItem.GetGridData( i_row, G_SPEC4 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC5,  grdItem.GetGridData( i_row, G_SPEC5 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC6,  grdItem.GetGridData( i_row, G_SPEC6 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC7,  grdItem.GetGridData( i_row, G_SPEC7 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC8,  grdItem.GetGridData( i_row, G_SPEC8 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC9,  grdItem.GetGridData( i_row, G_SPEC9 ));
         grdItem.SetGridText( grdItem.rows -1, G_SPEC10, grdItem.GetGridData( i_row, G_SPEC10));
                        
        if(chkPrice.value =='Y')
        {
            grdItem.SetGridText(grdItem.rows -1,G_PRICE_TYPE,lstPriceType.value);
        }
		
        if(chkCus.value =='Y')
        {
            grdItem.SetGridText(grdItem.rows -1,G_BILL_TO_PK,txtPartnerPK.text);
            grdItem.SetGridText(grdItem.rows -1,G_partner_nm,txtPartnerName.text);
        }
		
        grdItem.SetGridText(grdItem.rows -1, G_CYY, lstCurrency.value);
		
		grdItem.SetCellBgColor( grdItem.rows -1, 1, grdItem.rows -1, grdItem.cols - 1, 0xCCFFFF ); 
    }
	else
    {
        alert("Please select this an item to add new price!")
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
           case 'Custom' :
                 var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {	         
	                txtPartnerPK.text   = object[0];
                    txtPartnerName.text =  object[1]+"-"+ object[2];                                              
	             }
	        break;
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
    }
}
//==================================================================================
function OnClearCus()
{
    txtPartnerPK.text = ""
    txtPartnerName.text =""
}
//==================================================================================
function window_onunload() {

}
//==================================================================================

//==================================================================================
</script>

<body onunload="return window_onunload()">
    <!------------------------------------------------------------------------------->
    <gw:data id="data_dspc00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" user="sale" function="<%=l_user%>lg_sel_dspc00080" > 
                <input />
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------grdItem ---------------------------------------->
    <gw:data id="data_dspc00080_1" onreceive="OnDataReceive(this)"> 
            <xml> 
               <dso id="1" type="grid" user="sale" parameter="0,1,2,3,4,5,6,7,8,9,10" function="<%=l_user%>lg_sel_dspc00080_1"  procedure="<%=l_user%>lg_upd_dspc00080_1"  > 
                    <input bind="grdItem" > 
						<input bind="txtGroup_PK" />
						<input bind="txtPartnerPK" />						
                        <input bind="txtItem" />
                        <input bind="lstPriceType" /> 
                        <input bind="lstCurrency" />                         
                    </input> 
                    <output bind="grdItem" /> 
                </dso> 
            </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_dspc00080_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dspc00080_1" > 
                <input>
                    <input bind="txtGroup_PK" />  
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
	<!---------------------------------------------------------------->
    <gw:data id="pro_dspc00080_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dspc00080_3" > 
                <input>
                    <input bind="txtGroup_PK" />  
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
	<!---------------------------------------------------------------->
    <gw:data id="pro_dspc00080_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dspc00080_2" > 
                <input>
                    <input bind="txtPartnerPK" /> 
					<input bind="txtItemPK" />
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 30%" id="left">
                <gw:tree id="oTree" style="width: 100%; height: 100%; overflow: auto;" onclicknode="OnTreeClick()" />
            </td>
            <td style="width: 70%" id="right">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Custom')">Customer</b>
                        </td>
                        <td style="width: 55%" colspan="3">
                            <gw:textbox id="txtPartnerPK" styles='width:100%;display:none' />
                            <gw:textbox id="txtPartnerName" styles='width:100%' onenterkey="OnSearch()" onkeypress="Upcase()" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="ibtnReset" img="reset" alt="Clear Customer" onclick="OnClearCus()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            <gw:checkbox id="chkCus" defaultvalue="Y|N" value="N" />
                        </td>
						<td ></td>
                        <td >
							<gw:icon id="idBtnResetPrice" img="2" text="S/O Price Reset" styles='width:100%' onclick="OnProcess('SO-RESET')" />
                        </td>
						<td><gw:imgbtn id="ibtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" /></td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnExcel" img="excel" alt="Export to Excel" text="Export to Excel"
                                onclick="onExcel()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnProcess" img="process" alt="Get Price" text="View Spec" onclick="OnProcess('GENE-SO')" />
                        </td>
                        <td style="width: 1%; background-color: CCFFFF" align="right">
                            <gw:imgbtn id="ibtnProcess" img="process" alt="Get Price" text="View Spec" onclick="OnProcess('GENE-ITEM')" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; white-space: nowrap">
                            Item
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtItem" styles='width:100%' onenterkey="OnSearch()" onkeypress="Upcase()" />
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp('Price')">Price Type</b>
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstPriceType" styles='width:100%' />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="center">
                            <gw:checkbox id="chkPrice" defaultvalue="Y|N" value="N" />
                        </td>
                        <td>
                        </td>
                        <td style="width: 5%; white-space: nowrap">
                            CCY
                        </td>
                        <td style="width: 20%">
                            <gw:list id="lstCurrency" styles='width:100%' />
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
                            <gw:grid id='grdItem' header='_CO_ITEM_PRICE_PK|Grp Name|_TCO_ITEM_PK|Item Code|Item Name|UOM|Price|CCY|Price Type|_BILL_TO_PK|Bill To|Spec 1|Spec 2|Spec 3|Spec 4|Spec 5|_Spec 6|_Spec 7|_Spec 8|_Spec 9|_Spec 10|_USE|Price Dt|Price By|Price Slip'
                                format='0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0' aligns='0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||||||||||||||||' editcol='0|0|0|0|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='0|2500|0|1500|2000|800|1500|1000|1500|0|2000|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|800|1500|1500|1500'
                                sorting='T' styles='width:100%; height:100%' onafteredit="OnEdit(this)" oncelldblclick="OnCellDoubleClick(this)"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle('SearchList')" />
    <!---------------------------------------------------------------------->
    <gw:textbox id="txtGroup_PK" styles='width:100%;display:none;' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none;' />
	 <gw:textbox id="txtItemPK" styles='width:100%;display:none;' />
    <!---------------------------------------------------------------------->
</body>
</html>
