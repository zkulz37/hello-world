<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock In Price Update</title>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

    <script>

var G_WAREHOUSE  = 0,
    G_IN_DATE    = 1,
    G_SLIP_NO    = 2,
    G_IN_TYPE    = 3,
    G_CCY        = 4,
    G_EX_RATE    = 5,   
    G_SEQ        = 6,
    G_ITEM_CODE  = 7,
    G_ITEM_NAME  = 8,
    G_IN_QTY     = 9,
    G_UPRICE     = 10,
    G_AMOUNT     = 11,
    G_SUPPLIER   = 12,
    G_TABLE_NAME = 13,
    G_TABLE_PK   = 14,
    G_TRIN_TYPE  = 15,
    G_STOCKTR_PK = 16;

var arr_FormatNumber = new Array();  
//========================================================================
  function BodyInit()
  {
        System.Translate(document); 
        //-------------------------
        var now = new Date(); 
        var lmonth, ldate;
        
        ldate=dtFrom.value ;         
        ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
        dtFrom.value=ldate ;
        //------------------------- 
        
        SetGridFormat();            
  }
  //========================================================================

 function SetGridFormat()
 {
    var ctr = grdStock.GetGridControl(); 
    
    ctr.ColFormat(G_EX_RATE)= "#,###,###,###,###,###.###";
    ctr.ColFormat(G_IN_QTY) = "#,###,###,###,###,###.###";
    ctr.ColFormat(G_UPRICE) = "#,###,###,###,###,###.###";    
    ctr.ColFormat(G_AMOUNT) = "#,###,###,###,###,###.###";
    
    arr_FormatNumber[G_EX_RATE]= 3;
    arr_FormatNumber[G_IN_QTY] = 3;
    arr_FormatNumber[G_UPRICE] = 3;     
    arr_FormatNumber[G_AMOUNT] = 3;
    
    //-----------------------------------------------
    grdStock.GetGridControl().MergeCells  = 2 ;	
    grdStock.GetGridControl().MergeCol(0) = true ;	
    grdStock.GetGridControl().MergeCol(1) = true ;   	
    grdStock.GetGridControl().MergeCol(2) = true ;    
    grdStock.GetGridControl().MergeCol(3) = true ; 
    grdStock.GetGridControl().MergeCol(4) = true ; 
    grdStock.GetGridControl().MergeCol(5) = true ; 
    //-----------------------------------------------
    var data="";
        
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id||' * '||wh_name  FROM tlg_in_warehouse  WHERE del_if = 0  ORDER BY wh_ID ASC" )%>||";    
    lstWH.SetDataText(data);
    lstWH.value = '';      
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGIN0301') FROM DUAL" )%>||";    
     lstInType.SetDataText(data); 
	 lstInType.value = ""; 

    data = "<%=ESysLib.SetGridColumnDataSQL("  SELECT code, code FROM tlg_lg_code a, tlg_lg_code_group b  WHERE     a.tlg_lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGCM0100' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, 1" )%>||";    
    grdStock.SetComboFormat(G_CCY,data);

    data = "<%=ESysLib.SetGridColumnDataSQL("  SELECT code, code_nm FROM tlg_lg_code a, tlg_lg_code_group b  WHERE     a.tlg_lg_code_group_pk = b.pk AND b.GROUP_ID = 'LGIN0301' AND a.use_if = 'Y' AND a.del_if = 0 AND b.del_if = 0 ORDER BY a.def_yn DESC, 1" )%>|| ";    
    grdStock.SetComboFormat(G_IN_TYPE,data);
    
 }
//========================================================================
  
  function OnSearch()
  {
      data_bisa00080.Call("SELECT");
  }
//========================================================================
  function OnSave()
  {       
        if ( confirm("Do you want to save ?"))
        {
            data_bisa00080.Call();
        }
  }
//========================================================================
  
function CheckInput()
{   
    var col, row;
    
    col = event.col;
    row = event.row;
    
    if ( col == G_IN_QTY || col == G_UPRICE || col == G_AMOUNT || col == G_EX_RATE )
    {
        var dQuantiy ;
        
        dQuantiy =  grdStock.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdStock.SetGridText( row, col, System.Round( dQuantiy, arr_FormatNumber[col] ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdStock.SetGridText( row, col, "");
            }
        }
        else
        {
            grdStock.SetGridText(row,col,"") ;
        }   
        
         //---- Calculate Amount ---- 
        if ( col == G_IN_QTY || col == G_UPRICE )
        {
                dQuantiy   = grdStock.GetGridData( row, G_IN_QTY) ;
                var dPrice = grdStock.GetGridData( row, G_UPRICE) ;
                
                var dAmount = dQuantiy * dPrice;
                
                grdStock.SetGridText( row, G_AMOUNT, System.Round( dAmount, arr_FormatNumber[G_AMOUNT] ));
        }                         
    }                
}
//========================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {         
        case "data_bisa00080":
           
            if ( grdStock.rows > 1 )
            {
	            grdStock.SetCellBold( 1, G_WAREHOUSE, grdStock.rows - 1, G_WAREHOUSE,  true);
	            
                grdStock.SetCellBold( 1, G_ITEM_CODE, grdStock.rows - 1, G_ITEM_CODE, true);
                grdStock.SetCellBold( 1, G_IN_QTY,    grdStock.rows - 1, G_AMOUNT,    true);
                
                grdStock.SetCellBgColor( 1, G_UPRICE , grdStock.rows - 1, G_AMOUNT , 0xCCFFFF );                                 
                //--------------------------------                
                grdStock.Subtotal( 0, 2, -1, '9!11');
            }         
        break;                           
   }            
} 

//========================================================================
function OnSetPrice()
{   
     var event_row;
     
     if ( grdStock.row > 0 )
     {
         event_row = grdStock.row ;
     }
     else
     {
         alert("Pls select one row");
     }   
  
       var l_unit_price = grdStock.GetGridData( event_row, G_UPRICE);
       
       for (var i=event_row+1; i<grdStock.rows-1; i++ )
       {
            if ( grdStock.GetGridData(i,G_UPRICE) == '' || Number(grdStock.GetGridData(i,G_UPRICE)) == 0 )
            {
                grdStock.SetGridText( i, G_UPRICE, System.Round( l_unit_price, arr_FormatNumber[G_UPRICE] ));
                
                var dQuantiy = grdStock.GetGridData( i, G_IN_QTY) ;
                var dPrice   = grdStock.GetGridData( i, G_UPRICE) ;
                
                var dAmount = dQuantiy * dPrice;
                                                                      
                grdStock.SetGridText( i, G_AMOUNT, System.Round( dAmount, arr_FormatNumber[G_AMOUNT] ));                      
                
                grdStock.GetGridControl().Cell( 7, i, G_UPRICE, i, G_UPRICE ) = 0x3300cc;
            }
      }                       
}
//======================================================================

    </script>

</head>
<body>
    <!----------------------------------------------->
    <gw:data id="data_bisa00080" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="<%=l_user%>lg_sel_bisa00080" procedure="<%=l_user%>lg_upd_bisa00080">  
                <input bind="grdStockAdjust"   >  
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWH" /> 	 
                    <input bind="txtItem" />
                    <input bind="txtSupplier"/>  	
					<input bind="lstInType"/> 
                </input> 
                <output bind="grdStock" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr>
            <td style="width: 5%" align="right">
                Date
            </td>
            <td style="width: 15%; white-space: nowrap">
                <gw:datebox id="dtFrom" lang="1" />
                ~
                <gw:datebox id="dtTo" lang="1" />
            </td>
            <td style="width: 5%" align="right">
                W/H
            </td>
            <td style="width: 15%">
                <gw:list id="lstWH" styles="width:100%;" />
            </td>
			<td style="width: 5%;white-space: nowrap" align="right">
				In-Type
			</td>
			<td style="width: 10%">
				<gw:list id="lstInType" styles="width:100%"/>
			</td>
            <td style="width: 5%" align="right">
                Item
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtItem" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>

            <td style="width: 5%" align="right">
                Supplier
            </td>
            <td style="width: 15%">
                <gw:textbox id="txtSupplier" text="" styles="width:100%" onenterkey="OnSearch()" />
            </td>
			<td style="width: 2%"></td>
            <td style="width: 1%">
                <gw:imgbtn id="idSearch" img="search" alt="search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:icon id="idBtn" img="2" text="Set Price" styles='width:100%' onclick="OnSetPrice()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn img="save" alt="Save" id="idBtnUpdate" styles='width:100%' onclick="OnSave()" />
            </td>
        </tr>
        <tr style="height: 96%" valign="top">
            <td colspan="14">
                <gw:grid id='grdStock' header='W/H|In Date|Slip No|In Type|CCY|Ex Rate|Seq|Item Code|Item Name|In Qty|U/Price|Amount|Supplier|_TABLE_NAME|_TABLE_PK|_TRIN_TYPE|_PK'
                    format='0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|1|0|0|1|3|1|0|0|3|3|3|0|0|0|0|0' 
                    editcol='0|0|0|1|1|1|0|0|0|0|1|1|0|0|0|0|0'
                    widths='2000|1200|1500|1200|1000|1500|800|1500|2500|1500|1500|1500|2000|0|0|0|0' sorting='T'
                    styles='width:100%; height:100%' onafteredit="CheckInput()"/>
            </td>
        </tr>
    </table>
</body>
</html>
