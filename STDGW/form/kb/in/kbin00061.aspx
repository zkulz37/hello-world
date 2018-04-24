<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Cotton Incoming Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

//-----------------------------------------------------

var flag;

var GS_MASTER_PK = 0,
    GS_SLIP_NO   = 1,
    GS_DATE    = 2,
    GS_INVOICE    = 3;

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1,
    G1_SEQ              = 2,
    G1_TLG_IT_ITEM_PK   = 3,
    G1_ITEM_CODE        = 4,
    G1_ITEM_NAME        = 5,
    G1_LOT_NO           = 6,
    G1_NET_KG           = 7,
    G1_BALES            = 8,
    G1_NET_BALES        = 9,
    G1_UNIT_PRICE       = 10,
    G1_AMOUNT           = 11,
    G1_AVERAGE          = 12,
    G1_DESCRIPTION      = 13;
    
var arr_FormatNumber = new Array();    
 //===============================================================================================
function OnToggle()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //===============================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
    txtUser_PK.text = "<%=session("USER_PK")%>";
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
	
	txtLang.text = "<%=Session("SESSION_LANG")%>";
	
    dtVoucherDate.SetEnable(false);
    txtSlipNo.SetEnable(false);
    txtSupplierPK.SetEnable(false); 
    txtSupplierName.SetEnable(false);
    txtStaffPK.SetEnable(false); 
    txtStaffName.SetEnable(false);        
    txtPONo.SetEnable(false);   
    lstWH.SetEnable(false);
    lstShipComp.SetEnable(false);
    txtLCNo.SetEnable(false); 
    txtPLPK.SetEnable(false); 
    txtPLName.SetEnable(false); 
    txtInvoiceNo.SetEnable(false); 
    txtBLNo.SetEnable(false); 
    txtTax.SetEnable(false); 
    txtMark.SetEnable(false); 
    lstCCY.SetEnable(false);
    txtLotNo.SetEnable(false);
    txtNetW.SetEnable(false);
    txtTareW.SetEnable(false);
    txtGrossW.SetEnable(false);
    txtItemAmt.SetEnable(false); 
    txtTaxAmt.SetEnable(false); 
    txtTotalAmt.SetEnable(false); 
    txtRemark.SetEnable(false); 
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    BindingDataList();    
 }
 //==================================================================================
 
 function BindingDataList()
 { 
     var data = ""; 
     //----------------------- 
     data = "<%=ESysLib.SetListDataSQL("SELECT TRANS_CODE ,TRANS_CODE || ' - ' || trans_name  FROM tlg_in_trans_code  WHERE del_if = 0 and trans_type = 'I' and TRANS_CODE = 'I10' ORDER BY trans_code" )%>";    
     lstTransType.SetDataText(data);
     //---------------------------
     data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
     lstCCY.SetDataText(data);               
     
     data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
     lstShipComp.SetDataText(data); 
     lstShipComp.value = '' ;
	 
     pro_kbin00061_lst.Call();  
     
 }
 //==================================================================================
function  OnChangeDate()
{
	var	ldate=dtVoucherDate.value ;       
    ldate = ldate.substr(2,4)  ; 
    lstInType.value = ldate;
}
 //==================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_kbin00061_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
        break;  
    }
}  
//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbin00061.Call("SELECT");
        break;
    
        case 'grdMaster':
        
            if ( data_kbin00061_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                    }
                    flag = 'view' ;
                    data_kbin00061_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                }
                
                flag = 'view' ;
                data_kbin00061_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kbin00061_2.Call("SELECT");
        break;
    }
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_kbin00061_1": 
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    } 
                }
                //----------------------------
                OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }
                            
        break;

        case "data_kbin00061_2":
            if ( grdDetail.rows > 1 )
            {
                var dBales = 0;
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    dBales  += Number(grdDetail.GetGridData( i, G1_BALES)) ;
                }        
                lblSOBales.text = addCommas(dBales);      
            }         
        break;
        
        case 'pro_kbin00061_1':
            alert(txtReturnValue.text);
        break; 
		
        case 'pro_kbin00061_lst':
            lstWH.SetDataText(txtWHStr.text);
            lstWH2.SetDataText(txtWHStr.text +"||");
            lstWH2.value =''
            OnAddNew('Master');
        break;    
		
		case 'data_fpab00220_2':
			 if ( txtLGGroupCodeID.text == 'LGIN0301')
			 {
				 lstInType.SetDataText(txtLGCodeList.text);
				 lstInType.value = rtnLGCode;
			 }
		break;
		
		case 'pro_kbin00061_3':
			alert("Copy finish.");
			
			flag = 'view' ;
            data_kbin00061_1.Call("SELECT");
		break;
		case 'pro_kbin00061_4':
			alert(txtReturnValue.text);
		break;
		case 'data_kbin00061_setting':
		    SetGridFormat();
		break;

   }            
}
//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
		case 'CAL-AMOUNT':
			if ( confirm('Do you want to auto calculate Amount ?') )
            {
                InputProcess();
			}
		break;               
    }
}
//======================================================================
function InputProcess()
{
    for(var row = 1; row < grdDetail.rows; row++)
    {
         var dQuantiy = grdDetail.GetGridData( row, G1_NET_BALES) ;
         var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
         var dBales   = grdDetail.GetGridData( row, G1_BALES) ;
         
         var dNetBales= Number(dQuantiy) * 0.454;
         grdDetail.SetGridText( row, G1_NET_BALES, dNetBales);
         
         var dAmount = Number(dNetBales) * Number(dPrice);
         grdDetail.SetGridText( row, G1_AMOUNT, dAmount);
         
         var dDverage = Number(dQuantiy)/Number(dBales);
         grdDetail.SetGridText( row, G1_AVERAGE, dDverage);
         lblSOBales.text = addCommas(Number(lblSOBales.text) + Number(dBales));
    }
            TotalAmount();  
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_kbin00061_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_kbin00061_2.Call();
        break;
    }
}
//=================================================================================
function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_kbin00061_1.StatusDelete();
                data_kbin00061_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_DETAIL_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
            }            
        break;            

    }     
}
//=================================================================================
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//=================================================================================
function Validate()
{   
    for( var i = 1; i < grdDetail.rows; i++)
    {
        if ( Number(grdDetail.GetGridData( i, G1_NET_KG)) == 0 )
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
    }
    return true;
}
//=================================================================================
var gPreviousRow = -1 ;
function CheckInput()
{   
    var col, row
    
    col = event.col;
    row = event.row; 
	
    if ( col == G1_NET_KG || col == G1_BALES || col == G1_UNIT_PRICE)
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, System.Round( dQuantiy, 2 ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }  
        //----------------------Calculate Amount -----
        if ( chkAutoCal.value == 'Y' )
        {
            if ( col == G1_NET_KG || col == G1_BALES || col == G1_UNIT_PRICE )
            {
                var dQuantiy = grdDetail.GetGridData( row, G1_NET_KG) ;
                var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
                var dBales   = grdDetail.GetGridData( row, G1_BALES) ;
                
                var dNetBales= Number(dQuantiy) * 0.454;
                grdDetail.SetGridText( row, G1_NET_BALES, dNetBales);
                
                var dAmount =Number(dNetBales) * Number(dPrice);
                grdDetail.SetGridText( row, G1_AMOUNT, dAmount);
                
                var dDverage = Number(dQuantiy)/Number(dBales);
                grdDetail.SetGridText( row, G1_AVERAGE, dDverage);
            } 
            TotalAmount();  
        } 
    }
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
	var sumItemAmt  = 0 ;
	var sumTaxAmt   = 0 ;
    var sumTotalAmt = 0 ;
    var sumNetQty   = 0 ;
    var sumBales    = 0 ;
    
    for ( i=1; i<grdDetail.rows; i++ )
    {
		sumItemAmt  = sumItemAmt  + Number(grdDetail.GetGridData( i, G1_AMOUNT ));
		sumNetQty  = sumNetQty  + Number(grdDetail.GetGridData( i, G1_NET_KG ));
		sumBales  = sumBales  + Number(grdDetail.GetGridData( i, G1_BALES ));
    }
    sumTaxAmt   = sumItemAmt  * (Number(txtTax.text)/100);
    sumTotalAmt = sumTaxAmt + sumItemAmt;
    
	txtItemAmt.text  = System.Round( sumItemAmt,  2 ) ;
	txtTaxAmt.text   = System.Round( sumTaxAmt,   2 ) ;
    txtTotalAmt.text = System.Round( sumTotalAmt, 2 ) ;
    txtNetW.text     = System.Round( sumNetQty, 2 ) ;
    lblSOBales.text  = addCommas(sumBales);
    OnNetW();
} 
//====================================================================================
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1))
	{
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
 //================================================================================================
function OnNetW()
{
     if (IsNumeric(txtNetW.text))
     {
         lblNetW.text  = Number(txtNetW.text) * 2.20460000186 ;   
         lblNetW.text  = addCommas(System.Round( lblNetW.text,  2 )) + " (LBS)";
     }     
     if (IsNumeric(txtTareW.text))
     {
         txtGrossW.text = Number(txtNetW.text) + Number(txtTareW.text);
         lblTareW.text  = Number(txtTareW.text) * 2.20460000186 ;   
         lblTareW.text  = addCommas(System.Round( lblTareW.text,  2 )) + " (LBS)";
     }     
     if (IsNumeric(txtGrossW.text))
     {
         lblGrossW.text  = Number(txtGrossW.text) * 2.20460000186 ;   
         lblGrossW.text  = addCommas(System.Round( lblGrossW.text,  2 )) + " (LBS)";
     }
}
//================================================================================================
function OnSelect()
{
    var arr_data = new Array();
    // the last row is sub total --> no need to select 
    for(var i = 1; i < grdDetail.rows; i++ )
    {
         var arrTemp = new Array();
             
         for( var j = 0; j < grdDetail.cols; j++ ) 
         {
              arrTemp[arrTemp.length]= grdDetail.GetGridData(i,j);
         }
             
         arr_data[arr_data.length]= arrTemp;
    }            
    
    if ( arr_data != null )
    {
        var callerWindowObj = dialogArguments;  
            
        callerWindowObj.dtIncomingDate.text = dtVoucherDate.text; 
        
        callerWindowObj.txtIncomingSlip.text   = txtSlipNo.text ; 
        
        callerWindowObj.txtSupplierPK.text   = txtSupplierPK.text ; 
        callerWindowObj.txtSupplierName.text = txtSupplierName.text ;
        
        callerWindowObj.txtStaffPK.text   = txtStaffPK.text ; 
        callerWindowObj.txtStaffName.text = txtStaffName.text ;        
        
        callerWindowObj.txtPONo.text = txtPONo.text ;  
        
        callerWindowObj.txtLCNo.text   = txtLCNo.text ;
        
        callerWindowObj.txtPLPK.text   = txtPLPK.text ;
        callerWindowObj.txtPLName.text   = txtPLName.text ;
        
        callerWindowObj.txtInvoiceNo.text   = txtInvoiceNo.text ;
        callerWindowObj.txtBLNo.text   = txtBLNo.text ;
        callerWindowObj.txtTax.text   = txtTax.text ;
        callerWindowObj.txtMark.text   = txtMark.text ;
        
        callerWindowObj.lstCCY.value = lstCCY.value ;
        callerWindowObj.lstShipComp.value = lstShipComp.value ;
        
        callerWindowObj.txtLotNo.text = txtLotNo.text;
        callerWindowObj.txtNetW_INVC_KG.text = txtNetW.text;
        callerWindowObj.txtTareW_INVC_KG.text = txtTareW.text;
        callerWindowObj.txtTareW_ACT_KG.text = txtTareW.text;
        callerWindowObj.txtGrossW_INVC_KG.text = txtGrossW.text;
        
        callerWindowObj.txtSumInvAmt.text   = txtItemAmt.text ;
        
        callerWindowObj.txtNetW_INVC_LBS.text   = lblNetW_LBS.text ;
        callerWindowObj.txtTareW_INVC_LBS.text   = lblTareW_LBS.text ;
        callerWindowObj.txtGrossW_INVC_LBS.text   = lblGrossW_LBS.text ;

        callerWindowObj.txtRemark.text   = txtRemark.text ;
    }
              
    window.returnValue =  arr_data;
    window.close();
            
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_kbin00061_lst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_kbin00061_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbin00061" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_kbin00061_1" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWH2" />
                    <input bind="txtNoSearch" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />                      
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbin00061_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="<%=l_user%>lg_sel_kbin00061_2"  procedure="<%=l_user%>lg_upd_kbin00061_1"> 
                <inout>      
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtVoucherDate" />
                     <inout  bind="txtSlipNo" />                          
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierName" />
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="txtPONo" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtLCNo" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtInvoiceNo" />
                     <inout  bind="lstShipComp" /> 
					 <inout  bind="txtBLNo" />
					 <inout  bind="txtTax" />
                     <inout  bind="txtMark" /> 
                     <inout  bind="lstCCY" /> 
                     <inout  bind="txtLotNo" /> 
                     <inout  bind="txtNetW" /> 
                     <inout  bind="lblNetW_LBS" />
                     <inout  bind="txtTareW" /> 
                     <inout  bind="lblTareW_LBS" />
                     <inout  bind="txtGrossW" /> 
                     <inout  bind="lblGrossW_LBS" />
                     <inout  bind="txtItemAmt" /> 
                     <inout  bind="txtTaxAmt" /> 
                     <inout  bind="txtTotalAmt" />
                     <inout  bind="txtRemark" />  
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbin00061_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="<%=l_user%>lg_sel_kbin00061_4"   procedure="<%=l_user%>lg_upd_kbin00061_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_kbin00061" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>LG_PRO_kbin00061"> 
                <input> 
			        <input bind="txtPONo" />  		
			    </input> 
                <output>
                    <output bind="txtSupplierPK" />
                    <output bind="txtSupplierName" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_kbin00061_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbin00061_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:list id="lstWH2" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            No.
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Date|Invoice No' format='0|0|4|0' aligns='0|0|0|0'
                                check='|||' editcol='1|1|1|1' widths='1000|1000|1000|1000' sorting='T' autosize='T'
                                styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                        </td>
                        <td style="width: 15%" align="center">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Supplier
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtSupplierPK" styles="display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%">
                            Charger
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/O No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtPONo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLCNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/L
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Shipper
                        </td>
                        <td style="white-space: nowrap" colspan="3">
                            <gw:list id="lstShipComp" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            W/H
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Invoice No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtInvoiceNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            B/L No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtBLNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            Tax %
                        </td>
                        <td>
                            <gw:textbox id="txtTax" styles="display:100%" onchange="TotalAmount()" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            CCY
                        </td>
                        <td colspan="11">
                            <gw:list id="lstCCY" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Lot No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLotNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Mark
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtMark" styles="width:100%" />
                        </td>
                        <td align="right">
                            Remark
                        </td>
                        <td colspan="10">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="14">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF">
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Item Amt
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtItemAmt" styles="width:100%;" type="number" format="#,###,###.###" />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Tax Amt
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTaxAmt" styles="width:100%;" type="number" format="#,###,###.###" />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Total Amt
                                </td>
                                <td style="width: 35%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTotalAmt" styles="width:100%;" type="number" format="#,###,###.###" />
                                </td>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="14" style="padding: 0">
                            <table style="height: 100%; width: 100%; background-color: #FAE396">
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Net Weight
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtNetW" styles="width:100%;" type="number" format="#,###,###.###"
                                        onchange="OnNetW()" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblNetW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Tare Weight
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTareW" styles="width:100%;" type="number" format="#,###,###.###"
                                        onchange="OnNetW()" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblTareW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Gross Weight
                                </td>
                                <td style="width: 35%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtGrossW" styles="width:100%;" type="number" format="#,###,###.###"
                                        onchange="OnNetW()" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblGrossW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="16">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" style="white-space: nowrap">
                                        <gw:label id="lblBales" styles='width:100%;font:9pt' text="Sum of Bales: " />
                                    </td>
                                    <td style="white-space: nowrap">
                                        <gw:label id="lblSOBales" styles='width:100%;color:cc0000;font:9pt' />
                                    </td>
                                    <td style="width: 64%" align="right">
                                        <gw:imgbtn img="process" style="display: none" alt="Cal Amount" id="btnCalAmount"
                                            onclick="OnProcess('CAL-AMOUNT')" />
                                    </td>
                                    <td style="width: 15%; white-space: nowrap" align="center">
                                        <gw:checkbox id="chkAutoCal" onchange="" defaultvalue="Y|N" value="Y" style="display: none" />
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn img="select" alt="Select Incoming No" id="btnSelect1" onclick="OnSelect()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="16">
                            <gw:grid id='grdDetail' header='_tlg_kb_cotton_income_d_pk|_tlg_kb_cotton_income_m_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|Lot No|Net KG|Bales|Net Bales|Unit Price|Amount|Average|Description'
                                format='0|0|0|0|0|0|0|1|1|1|1|1|1|0' aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|500|0|1200|2500|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit='CheckInput()' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:list id="lstTransType" styles='width:100%;display: none' />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtLang" styles='width:100%;display:none' />
<gw:textbox id="txtItemCD_Search" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtItemNM_Search" maxlen="100" styles='width:100%;display:none' />
<!---------------------------------------------------------------------------------->
<gw:grid id="grdItem_Search" header="pk|item_cd|item_nm" format="0|0|0" aligns="0|0|0"
    defaults="||" editcol="1|1|1" widths="0|0|0" styles="width:100%; height:200;display:none"
    sorting="F" param="0,1,2" />
<!--------------------------------------------------------------------------------->
<gw:textbox id="txtNumReqQty" styles='width:100%;display:none' />
<gw:textbox id="txtNumInQTy" styles='width:100%;display:none' />
<gw:textbox id="txtNumRefQTy" styles='width:100%;display:none' />
<gw:textbox id="txtNumPrice" styles='width:100%;display:none' />
<gw:textbox id="txtNumItemAmt" styles='width:100%;display:none' />
<gw:textbox id="txtNumRate" styles='width:100%;display:none' />
<gw:textbox id="txtNumTaxAmt" styles='width:100%;display:none' />
<gw:textbox id="txtNumTotalAmt" styles='width:100%;display:none' />
<gw:textbox id="txtMaskReqQty" styles='width:100%;display:none' />
<gw:textbox id="txtMaskRefQTy" styles='width:100%;display:none' />
<gw:textbox id="txtMaskInQTy" styles='width:100%;display:none' />
<gw:textbox id="txtMaskPrice" styles='width:100%;display:none' />
<gw:textbox id="txtMaskAmount" styles='width:100%;display:none' />
<gw:textbox id="txtMaskRate" styles='width:100%;display:none' />
<gw:textbox id="txtMaskVatAmt" styles='width:100%;display:none' />
<gw:textbox id="txtMaskTotalAmt" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------------->
</html>
