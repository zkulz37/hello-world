<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Income Return Entry</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var G_DETAIL_PK   = 0,
    G_MASTER_PK   = 1,
    G_SEQ         = 2,
    G_REF_NO      = 3,
    G_NULL_01     = 4,
    G_NULL_02     = 5,
    G_NULL_03     = 6,
    G_ITEM_PK     = 7,
    G_ITEM_CODE   = 8,
    G_ITEM_NAME   = 9,    
    G_NULL_04     = 10,
    G_NULL_05     = 11,
	G_RTN_UOM     = 12,
    G_RTN_QTY     = 13,       
    G_UNIT_PRICE  = 14,
    G_ITEM_AMOUNT = 15,
	G_LOT_NO      = 16,	
    G_REMARK      = 17;

var user_name = "<%=Session("USER_NAME")%>"   ;
var user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
var comp_pk   = "<%=Session("COMPANY_PK") %>" ;

var arr_FormatNumber = new Array();  
//====================================================================================
function BodyInit()
{
    System.Translate(document); 
	
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
	
    txtSlipNo.SetEnable(false);
    txtChargerName.SetEnable(false);
    txtPLName.SetEnable(false);
    
    SetGridFormat();
      
    OnAddNew('Master'); 
	    
 } 
//====================================================================================
 function SetGridFormat()
 {
 
    var ldate;    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    
    var data="";

	data = "<%=ESysLib.SetListDataSQL("select pk,DEPT_ID || ' * '|| DEPT_NAME from TLG_PO_DEPT a where a.use_yn='Y' and del_if=0 order by DEPT_ID")%>||"; 
    lstDept.SetDataText(data);
	lstDept.value = "";
	 
    data = "<%=ESysLib.SetListDataSQL(" SELECT   a.pk, a.line_id || ' - ' || a.line_name FROM tlg_pb_line a WHERE a.del_if = 0 ORDER BY a.line_id ")%>";     
    lstLine.SetDataText(data); 
            
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_id||' * '||wh_name  FROM tlg_in_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>"; 	
	lstReWH.SetDataText(data); 
	
	data = data + "||";   
    lstWH.SetDataText(data);
	lstWH.value = "";  
 
    var ctrl = grdDetail.GetGridControl(); 
    
    ctrl.ColFormat(G_RTN_QTY)     = "#,###,###,###,###,###.##";
	ctrl.ColFormat(G_UNIT_PRICE)  = "#,###,###,###,###,###.##";
    ctrl.ColFormat(G_ITEM_AMOUNT) = "#,###,###,###,###,###.##";
	
    arr_FormatNumber[G_RTN_QTY] 	= 2;
	arr_FormatNumber[G_UNIT_PRICE]  = 2;
	arr_FormatNumber[G_ITEM_AMOUNT] = 2;
 }
//====================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("img1"); 

    if(imgArrow.status == "expand")
    {
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/button/next.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}
 
//====================================================================================
 
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_bias00050.Call('SELECT');
        break;
        
        case 'Master':
			if ( data_bias00050_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0 );
                    }
                    flag = 'view' ;
                    data_bias00050_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, 0 );
                }
                
                flag = 'view' ;
                data_bias00050_1.Call("SELECT");
            }         					            
        break;
    }
}
//====================================================================================
var flag ;

function OnAddNew()
{             
    data_bias00050_1.StatusInsert();    
    txtSlipNo.text   = '***New Voucher***';
    //-------------------------------------------
    txtChargerName.text = "<%=Session("USER_NAME")%>";
    txtChargerPK.text   = "<%=Session("EMPLOYEE_PK")%>";
    //------------------------------------------- 
    grdDetail.ClearData(); 
}
//====================================================================================

function OnSave(pos)
{   
    switch(pos)
    { 
        case 'Master':
            if(flag == "delete")
            {
                data_bias00050_2.Call();
            }
            else
            {
                data_bias00050_1.Call();   
                flag = "save";         
            }
        break;
        //----------------
        case 'Detail':
            data_bias00050_2.Call();
        break;
    }    
}
//====================================================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_bias00050_1":   
            if(flag == "save")
            { 
                for(var i=1; i < grdDetail.rows;i++)
                {
                        if ( grdDetail.GetGridData( i, G_MASTER_PK) == '' )
                        {
                            grdDetail.SetGridText( i, G_MASTER_PK, txtMasterPK.text);
                        } 
                }
                    data_bias00050_2.Call();
            }
            else
            {
               data_bias00050_2.Call('SELECT');
            }
        break;  
        //----------------------
        case "data_bias00050_2":   
            if(grdDetail.rows > 1)
            {
                grdDetail.SetCellBold( 1, G_ITEM_CODE , grdDetail.rows - 1, G_ITEM_CODE ,  true);
               
                grdDetail.SetCellBold( 1, G_RTN_QTY, grdDetail.rows - 1, G_RTN_QTY,  true);                              
            }
        break;    
        //--------------------
        case 'pro_bias00050':
            alert(txtReturnValue.text);
            
			flag = "view";
            data_bias00050_1.Call('SELECT');			
        break;                 
    }
} 
//====================================================================================
function OnPopUp(obj)
{
    switch(obj)
    {
		case 'WAREHOUSE':
            var path = System.RootURL + '/form/fp/ab/fpab00240.aspx' ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                lstReWH.value = obj[0];                 
            }
        break;
			
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
            }
        break;  
        //----------------------------
        case 'PL': 
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[6]; 
                txtPLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;
		
        case 'Report': 
            if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/bi/as/bias00052.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
 	        }
	        else
	        {
		        alert("Please, select one slip no to print!");
	        }	
        break;
        //------------------------
        case 'StockOutgo':
                     var path = System.RootURL + '/form/bi/as/bias00051.aspx';
                     var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
                     
                     if ( object != null )
                     {
                            var arrTemp;
	                        //-----------------                  
                            for ( var i=0; i< object.length; i++)
                            {
                               var arrTemp = object[i];
                                
                               grdDetail.AddRow();        
                               
                               grdDetail.SetGridText( grdDetail.rows-1, G_SEQ       , grdDetail.rows-1);
                               
                               grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK , txtMasterPK.text);
                               grdDetail.SetGridText( grdDetail.rows-1, G_REF_NO    , arrTemp[3]);                                
                                
                               grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK   , arrTemp[4]);
                               grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE , arrTemp[5]);    
                               grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME , arrTemp[6]);                                
                                                              
                               grdDetail.SetGridText( grdDetail.rows-1, G_RTN_QTY , arrTemp[7]);
                               grdDetail.SetGridText( grdDetail.rows-1, G_RTN_UOM , arrTemp[8]);
                                                         
                               grdDetail.SetGridText( grdDetail.rows-1, G_LOT_NO , arrTemp[9]);
                               grdDetail.SetGridText( grdDetail.rows-1, G_REMARK , arrTemp[10]); 
                            }             
                     }        
        break;
        //----------------------------
        case 'FreeItem':
                 var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=|Y|||Y|Y';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];
                                    
                                grdDetail.AddRow();                            
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G_SEQ                   , grdDetail.rows-1);
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G_MASTER_PK  , txtMasterPK.text); //master_pk	    	                                                                              
                                
                                grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_PK   , arrTemp[0]); 
                                grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_CODE , arrTemp[1]);      
                                grdDetail.SetGridText( grdDetail.rows-1, G_ITEM_NAME , arrTemp[2]);      
                                grdDetail.SetGridText( grdDetail.rows-1, G_RTN_UOM   , arrTemp[5]);                                                                            
                        }
                 }              
        break;        
    }
}
//====================================================================================
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;
                
                 //-------------------------
                 if ( event_col == G_RTN_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 } 
                //------------------------
                if ( event_col == G_ITEM_CODE || event_col == G_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G_ITEM_PK  ,   object[0] );
                            grdDetail.SetGridText( event_row, G_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G_ITEM_NAME,   object[2] );
                       }                       
                 }                                 
            break;             
      }         
}
//====================================================================================
function OnDelete(obj)
{
    if(obj == "Master")
    {
        if(confirm('Do you want to delete this request?'))
        {
            flag = "delete";
            data_bias00050_1.StatusDelete();
            data_bias00050_1.Call();
        }        
    }
    if(obj == "Detail")
    {
        if(confirm('Do you want to delete this Item?'))
        {
                if ( grdDetail.GetGridData( grdDetail.row, G_DETAIL_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
        }        
    }
}
//====================================================================================
function OnUnDelete()
{
    grdDetail.UnDeleteRow();
}
//====================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'Confirm' :
            if ( confirm('Do you want to submit this Slip?'))
            {
                pro_bias00050.Call();
            }               
        break;
    }
}
 
//===================================================
function CheckInput()
{
      var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G_RTN_QTY || col == G_UNIT_PRICE || col == G_ITEM_AMOUNT )
    {
         var dQuantity ;
        
        dQuantity =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantity))
        {   
            grdDetail.SetGridText( row, col, System.Round( dQuantity, arr_FormatNumber[col] ));
        }
		else
        {
            grdDetail.SetGridText(row,col,"") ;
        }
		//------------------------
		if ( col == G_RTN_QTY || col == G_UNIT_PRICE )	
		{
			var dQuantiy = grdDetail.GetGridData( row, G_RTN_QTY) ;
            var dPrice   = grdDetail.GetGridData( row, G_UNIT_PRICE) ;
                
            var dAmount = dQuantiy * dPrice;
                
            grdDetail.SetGridText( row, G_ITEM_AMOUNT, System.Round( dAmount, arr_FormatNumber[G_ITEM_AMOUNT]));
		}
		
    }
}
//============================================================================

function OnReport(pos)
{
    switch(pos)
    {
        case'0':
            var url =System.RootURL + '/reports/bi/as/rpt_bias00051.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
        case'1':
            var url =System.RootURL + '/reports/bi/as/rpt_bias00052.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
		case'2':
            var url =System.RootURL + '/reports/bi/as/rpt_bias00050.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
    }
}

//============================================================================
</script>

<body>
    <!------------------------------------------------------------------->
    <gw:data id="data_bias00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_bias00050" > 
                <input>                     
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtVoucherSearch" />
                    <input bind="lstWh" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bias00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="<%=l_user%>lg_sel_bias00050_1"  procedure="<%=l_user%>lg_upd_bias00050_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="lstReWH" />
                     <inout  bind="dtReDate" />  
                     <inout  bind="txtRefNo" />                         
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="txtRemark" />
                     <inout  bind="lstLine" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="lblStatus" />  
					 <inout  bind="lstDept" />	
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <gw:data id="data_bias00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="<%=l_user%>lg_sel_bias00050_2" procedure="<%=l_user%>lg_upd_bias00050_2"> 
                <input> 
                    <input bind="txtMasterPK" />                
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bias00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bias00050" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="width: 94%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" onchange="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            No
                        </td>
                        <td style="width: 94%" >
                            <gw:textbox id="txtVoucherSearch" styles="width:100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
						<td style="width: 1%">
							<gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
						</td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Status|Slip No|Date|Line" format="0|0|0|4|0"
                                aligns="0|1|0|1|0" defaults="|||||" editcol="0|0|0|0|0" widths="0|1200|1500|1200|1000"
                                styles="width:100%; height:100%" sorting="T" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Slip No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 2%">
                            Date
                        </td>
                        <td>
                            <gw:datebox id="dtReDate" lang="1" />
                        </td>
                        <td style="width: 100%" colspan="2" align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td>
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Confirm')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Ref No
                        </td>
                        <td style="width: 40%" colspan="3">
                            <gw:textbox id="txtRefNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td style="width: 5%" align="right">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color=#0000ff"><b>
                                Charger</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            <a title="WareHouse" onclick="OnPopUp('WAREHOUSE')" href="#tips" style="color: #0000ff">
                                <b>W/H</b></a>
                        </td>
                        <td colspan="3">
                            <gw:list id="lstReWH" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right">
                            Line
                        </td>
                        <td colspan="6">
                            <gw:list id="lstLine" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>                    
                    <tr style="height: 1%">
                        <td style="white-space: nowrap" align="right" >
                            Dept
                        </td>
                        <td colspan="3">
                            <gw:list id="lstDept" styles='width:100%'  />
                        </td>
                        <td align="right">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color=#0000ff"><b>P/L</b></a>
                        </td>
                        <td colspan="6">
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                    </tr>
					<tr style="height: 1%">
                        <td style="white-space: nowrap">
                            Remark
                        </td>
                        <td colspan="10">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>                        
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="11">
                            <table border="0">
                                <tr>
                                    <td style="width: 1%" align="left">
                                        <img status="expand" id="img1" src="../../../system/images/button/previous.gif" style="cursor: hand"
                                            onclick="OnToggle()" />
                                    </td>                                    
                                    <td style="width: 100%" colspan="2" align="right">
                                        <gw:icon id="idBtnFreeItem" img="2" text="Free Item" styles='width:10%' onclick="OnPopUp('FreeItem')" />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        <gw:icon id="idBtnRequest" img="2" text="Stock Outgo" styles='width:10%; display:none' onclick="OnPopUp('StockOutgo')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 95%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' 
							    header='_detail_pk|_master_pk|Seq|Ref No|_null_01|_null_02|_null_03|_req_return_pk|Item Code|Item Name|_null|_null|UOM|Rtn Qty|U/P|Item Amount|Lot No|Remark'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
								aligns='0|0|1|0|0|0|0|0|0|0|0|0|1|3|3|3|1|0'
                                check='|||||||||||||||||' 
								editcol='0|0|1|1|0|0|0|0|0|0|0|0|0|1|1|1|1|1' 
								widths='0|0|500|1500|0|0|0|0|1500|3500|0|0|800|1500|1500|1500|1500|1000'
                                sorting='T' styles='width:100%; height:100%' 
                                onafteredit="CheckInput()"
                                oncelldblclick='OnGridCellDoubleClick(this)' />
                        </td>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="display:none"></gw:textbox>
	<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
    <!------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <!------------------------------------------------------------------->
</body>
</html>
