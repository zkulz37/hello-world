<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
///  Popup get item from Takeout Finished Goods 
var iBook_Ccy = 'VND';
var iTr_Rate = 0;
var iBook_Rate = 0;
var iTR_Ccy = '';
var i_update = 0 ;
var i_search = 0 ; // search luoi grdDtl
var i_Inv_Qty = 0;
var i_tsa_sotakeoutd_pk = 0,
    i_Item_Code         = 1,
    i_Item_Name         = 2,
    i_ItemUOM           = 3,
    i_UnitPrice         = 4,
    i_TAKEOUT_QTY       = 5,
    i_load_qty          = 6,
    i_BAL_QTY           = 7,
    i_saleorder_no      = 8,
    i_TAKOUT_ITEM_PK    = 9,
    i_Ccy            = 10;                         
var i2_tac_so_takeout_ar_pk     = 0,
    i2_tsa_sotakeoutd_pk        = 1,
    i2_tac_crcad_pk             = 2,
    i2_Chk                      = 3,
    i2_item_code                = 4,
    i2_item_name                = 5,    
    i2_item_uom                 = 6,
    i2_unit_price               = 7,
    i2_qty                      = 8,
    i2_saleorder_no             = 9,
    i2_ccy                      = 10,
    i2_actural_qty              = 11, 
    i2_diff_qty                 = 12,
    i2_takout_item_pk           = 13,         
    i2_Inv_Qty_Origin           = 14, 
    i2_tr_famt                  = 15,
    i2_tr_amt                   = 16,
    i2_acnt_yn                  = 17,
    i2_Acc_Pk                   = 18,
    i2_Acc_Code                 = 19,
    i2_Acc_Name                 = 20;
              
function BodyInit()
{
    System.Translate(document);
    var ls_date_fr = "<%=ESysLib.SetDataSQL("SELECT TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE, -1)) + 1, 'YYYYMMDD') FROM DUAL")%>";
    dtInvoiceDatefr.SetDataText(ls_date_fr);
    txtcompk.text = "<%=Request.querystring("company")%>";
    iBook_Ccy = "<%=Request.querystring("book_ccy")%>";
    iTr_Rate = "<%=Request.querystring("trans_rate")%>";
    iBook_Rate = "<%=Request.querystring("book_rate")%>";
    iTR_Ccy = "<%=Request.querystring("tr_ccy")%>";
    // trang thai cua cac nut xoa , delete
    idBtnDel.SetEnable(false);
    idBtnSave.SetEnable(false);
    idBtnOK.SetEnable(false); 
    // format number
    FormatGrid();           
}

function OnSelect()
{
    var i ;
    /*for(i = 1; i < grdDtl2.rows; i++)
    {
        if(grdDtl2.GetGridData(i,i2_Ccy ) != iTR_Ccy)
        {
            alert('Please you review the currency at row ' + i);
            return;
        }
    }*/
	var aValue = new Array();
	for(i=1; i < grdDtl2.rows; i++)
    {
		if(grdDtl2.GetGridData(i, i2_Chk)== "-1")
		{
			tmp= new Array();
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_tac_so_takeout_ar_pk);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_item_code);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_item_name);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_item_uom);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_unit_price);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_qty);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_saleorder_no);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_actural_qty);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_diff_qty);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_takout_item_pk);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_tr_famt);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_tr_amt);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_Acc_Pk);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_Acc_Code);
			tmp[tmp.length] = grdDtl2.GetGridData(i, i2_Acc_Name);
			aValue[aValue.length]=tmp;
		}
    }
	window.returnValue = aValue;
	window.close();
}

/*function OnCancel()
{
	var code_data=new Array();
	tmp= new Array();
	tmp[0]       = 0
	code_data[0] = tmp;
	
	window.returnValue = code_data; 
	this.close();
}
*/
function onSearch()
{
    dso_upd_grd_dtl_search.Call('SELECT');
    i_search = 1;
}

function SumRow()
{
    if (grdDtl.rows < 2)
    {
        lblsum.text = "0";
    }
    else
    {
        lblsum.text = grdDtl.rows - 1;
    }
}

function DBPopupClickDtl()
{
    var lrow = event.row ;
    
    var i, lnew_row;
    if (grdDtl.rows > 1)
    {
        grdDtl2.AddRow();
        lnew_row = grdDtl2.rows - 1;
        grdDtl2.SetGridText(lnew_row, i2_tsa_sotakeoutd_pk, grdDtl.GetGridData(lrow, i_tsa_sotakeoutd_pk) );
        grdDtl2.SetGridText(lnew_row, i2_item_code, grdDtl.GetGridData(lrow, i_Item_Code) );
        grdDtl2.SetGridText(lnew_row, i2_item_name, grdDtl.GetGridData(lrow, i_Item_Name) );
        grdDtl2.SetGridText(lnew_row, i2_item_uom, grdDtl.GetGridData(lrow, i_ItemUOM) );
        grdDtl2.SetGridText(lnew_row, i2_unit_price, grdDtl.GetGridData(lrow, i_UnitPrice) );
        grdDtl2.SetGridText(lnew_row, i2_qty, grdDtl.GetGridData(lrow, i_BAL_QTY) );
        grdDtl2.SetGridText(lnew_row, i2_saleorder_no, grdDtl.GetGridData(lrow, i_saleorder_no) );
        grdDtl2.SetGridText(lnew_row, i2_ccy, grdDtl.GetGridData(lrow, i_Ccy) );
        grdDtl2.SetGridText(lnew_row, i2_actural_qty, grdDtl.GetGridData(lrow, i_TAKEOUT_QTY) );
        grdDtl2.SetGridText(lnew_row, i2_diff_qty, grdDtl.GetGridData(lrow, i_load_qty) );
        grdDtl2.SetGridText(lnew_row, i2_takout_item_pk, grdDtl.GetGridData(lrow, i_TAKOUT_ITEM_PK) );
        grdDtl2.SetGridText(lnew_row, i2_Inv_Qty_Origin, grdDtl.GetGridData(lrow, i_BAL_QTY) );
        grdDtl2.SetGridText(lnew_row, i2_Inv_Qty_Origin, grdDtl.GetGridData(lrow, i_BAL_QTY) );
        
        grdDtl.RemoveRow(lrow);
        if(grdDtl2.rows > 1)
        {
                idBtnDel.SetEnable(true);
                idBtnSave.SetEnable(true);
                idBtnOK.SetEnable(true);        
        }
        else
        {
                idBtnDel.SetEnable(false);
                idBtnSave.SetEnable(false);
                idBtnOK.SetEnable(false);        
        }
    }
}

function onSearchVen()
{
    var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes;toolbar:no;location:no;directories:no;status:no;menubar:no;scrollbars:no;resizable:no;');
	if ( object != null )
	{
	    if (object[0] != 0)
        {
            txtven_cd.text = object[1];
            txtven_nm.text = object[2];
            txtven_pk.text = object[0];
        }
    }
}

function onResetVen()
{
    txtven_cd.text = '';
    txtven_nm.text = '';
    txtven_pk.text = '';
}

function OnDelete()
{
    var i , lnew_row = 0, j = 0;
    var l_arr = new Array();
    var ctrl = grdDtl2.GetGridControl();
    if(grdDtl2.rows > 1)
    {
        for( i = 1; i < grdDtl2.rows ; i++)
        {
            if(ctrl.IsSelected(i))
            {
                if(Trim(grdDtl2.GetGridData(i, i2_tac_so_takeout_ar_pk)) == '')
                {
                    grdDtl.AddRow();
                    lnew_row = grdDtl.rows - 1;
                    grdDtl.SetGridText(lnew_row, i_tsa_sotakeoutd_pk, grdDtl2.GetGridData(i, i2_tsa_sotakeoutd_pk) ); // sales details take out Pk
                    grdDtl.SetGridText(lnew_row, i_Item_Code, grdDtl2.GetGridData(i, i2_item_code) );
                    grdDtl.SetGridText(lnew_row, i_Item_Name, grdDtl2.GetGridData(i, i2_item_name) ); //
                    grdDtl.SetGridText(lnew_row, i_ItemUOM, grdDtl2.GetGridData(i, i2_item_uom) ); //UOM
                    grdDtl.SetGridText(lnew_row, i_UnitPrice, grdDtl2.GetGridData(i, i2_unit_price) ); // U/Price
                    grdDtl.SetGridText(lnew_row, i_TAKEOUT_QTY, grdDtl2.GetGridData(i, i2_actural_qty) ); // actural qty
                    grdDtl.SetGridText(lnew_row, i_load_qty, grdDtl2.GetGridData(i, i2_diff_qty) ); // diffrence qty
                    grdDtl.SetGridText(lnew_row, i_BAL_QTY, grdDtl2.GetGridData(i, i2_Inv_Qty_Origin) ); // balance qty
                    grdDtl.SetGridText(lnew_row, i_saleorder_no, grdDtl2.GetGridData(i, i2_saleorder_no) ); // sales order
                    grdDtl.SetGridText(lnew_row, i_TAKOUT_ITEM_PK, grdDtl2.GetGridData(i, i2_takout_item_pk) ); // item pk
                    grdDtl.SetGridText(lnew_row, i_Ccy, grdDtl2.GetGridData(i, i2_ccy) ); // currency                    
                    l_arr[j] = i;
                    j++;
                }
                else
                {
                    // delete row 
                    grdDtl2.SetRowStatus(i, 64);                    
                    i_update = 1 ;
                } // if
            } // if
        } //for
        for(i = 0 ; i < l_arr.length ; i++)
        {
            grdDtl2.RemoveRow(l_arr[i]);
        }    
        if(grdDtl2.rows > 1)
        {
                idBtnDel.SetEnable(true);
                idBtnSave.SetEnable(true);
                idBtnOK.SetEnable(true);        
        }
        else
        {
                idBtnDel.SetEnable(false);
                idBtnSave.SetEnable(false);
                idBtnOK.SetEnable(false);        
        }        
        if(i_update == 1)   
            dso_fgtakeout_ar.Call();
    }
}
//--------------------------------------------
function OnBeforeChangeInvQty()
{	
	i_Inv_Qty = Number(grdDtl2.GetGridData(event.row, i2_qty ));
}
//--------------------------------------------
function OnChangeInvQty()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var lQty = 0, luprice = 0, ltr_famt = 0, ltr_amt = 0, lccy = '';
    if(lcol == i2_qty)
    {
        lQty = Number(grdDtl2.GetGridData(lrow, i2_qty ));
		if(i_Inv_Qty < lQty)
		{
			grdDtl2.SetGridText(lrow, i2_qty, i_Inv_Qty );
			alert("Cannot edit invoice quantity greater than " + i_Inv_Qty);
			return ;
		}
        lccy = grdDtl2.GetGridData(lrow, i2_ccy ); 
        luprice = grdDtl2.GetGridData(lrow, i2_unit_price );        
        ltr_famt = FormatCalculate(lccy, Number(luprice * lQty) ) ;
        ltr_amt = FormatCalculate(iBook_Ccy, Number(luprice * lQty * iTr_Rate / iBook_Rate) ) ;
        grdDtl2.SetGridText(lrow, i2_tr_famt, ltr_famt); // tien transaction 
        grdDtl2.SetGridText(lrow, i2_tr_amt, ltr_amt); // tien book
    }
}
// lam tron tien
function FormatCalculate(ccy, pnum)
{
	var rValue =0 ;
	if(ccy == "VND")
	{
		rValue = Math.round(Number(pnum));
	}
	else
	{
		rValue = Math.round(Number(pnum) * 100)/100;
	}	
	return rValue;
}
//--------------------------------------------
function OnSave()
{
    //if(ValidateData())
    {
        dso_fgtakeout_ar.Call();
        i_update = 1 ;
    }        
}   
//--------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'dso_upd_grd_dtl_search':
            if(i_search == 1)
            {
                i_search = 0;                
                dso_fgtakeout_ar.Call("SELECT");                    
            }
        break ;
        case 'dso_fgtakeout_ar':
                    
            if(grdDtl2.rows <= 1)
            {
                idBtnDel.SetEnable(false);
                idBtnSave.SetEnable(false);
                idBtnOK.SetEnable(false);
            }
            else
            {
                idBtnDel.SetEnable(true);
                idBtnSave.SetEnable(true);
                idBtnOK.SetEnable(true);            
            }
            dso_upd_grd_dtl_search.Call('SELECT');            
                    
        break ;
    }    
}
//--------------------------------------------
function ValidateData()
{
    var i ;
    for(i = 1; i < grdDtl2.rows ; i++)
    {
        if(Trim(grdDtl2.GetGridData(i, i2_qty)) == '')
        {
            alert('Please input invoice quantity at row ' + i);
            return false;
        }
        else if(Trim(grdDtl2.GetGridData(i, i2_tr_famt)) == '')
        {
            alert('Please input invoice quantity at row ' + i + ' and then press tab key to calculate amount');
            return false;            
        }
        else if(Trim(grdDtl2.GetGridData(i, i2_tr_amt)) == '')
        {
            alert('Please input invoice quantity at row ' + i + ' and then press tab key to calculate amount');
            return false;            
        }
    } 
    return true ;
}
function FormatGrid()
{
    var ctrl = grdDtl.GetGridControl();
    ctrl.ColFormat(i_load_qty) = "#,###,###,###,###,###,###,###.##R";
    ctrl.ColFormat(i_UnitPrice) = "#,###,###,###,###,###,###,###.##R";
    ctrl.ColFormat(i_TAKEOUT_QTY) = "#,###,###,###,###,###,###,###.##R";
    ctrl.ColFormat(i_BAL_QTY) = "#,###,###,###,###,###,###,###.##R";
    var ctrl2 = grdDtl2.GetGridControl();
    ctrl2.ColFormat(i2_unit_price) = "#,###,###,###,###,###,###,###.##R";
    ctrl2.ColFormat(i2_qty) = "#,###,###,###,###,###,###,###.##R";
    ctrl2.ColFormat(i2_actural_qty) = "#,###,###,###,###,###,###,###.##R";
    ctrl2.ColFormat(i2_diff_qty) = "#,###,###,###,###,###,###,###.##R";
    ctrl2.ColFormat(i2_tr_famt) = "#,###,###,###,###,###,###,###.##R";
    ctrl2.ColFormat(i2_tr_amt) = "#,###,###,###,###,###,###,###R";
}

</script>
<body style="margin:0; padding:0;">
<!----------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_upd_grd_dtl_search" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="ACNT.SP_SEL_GRD_AR_DO_FROM_LOG" >
                <input bind="grdDtl">
                    <input bind="txtvoucher_no" />
                    <input bind="dtInvoiceDatefr" />
                    <input bind="dtInvoiceDateto" />
                    <input bind="txtven_pk" />
                    <input bind="txtcompk" />
                </input>
                <output bind="grdDtl" />
            </dso>
        </xml>
    </gw:data>
<!----------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_fgtakeout_ar" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.sp_sel_so_takeout_ar" parameter="0,1,8,15,16" procedure="acnt.sp_upd_so_takeout_ar" >
                <input bind="grdDtl2">
                    <input bind="txtvoucher_no" />
                    <input bind="dtInvoiceDatefr" />
                    <input bind="dtInvoiceDateto" />
                    <input bind="txtven_pk" />
                    <input bind="txtcompk" />
                </input>
                <output bind="grdDtl2" />
            </dso>
        </xml>
    </gw:data>    
<!----------------------------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
<tr style="height:0%" >    
    <td width="8%"></td>
    <td width="12%"></td>
    <td width="8%"></td>
    <td width="10%"></td>
    <td width="3%"></td>
    <td width="10%"></td>
    <td width="5%"></td>
    <td width="27%"></td>
    <td width="12%"></td>
    <td width="3%"></td>
</tr>
    <tr style="height:5%; " >
        <td align="right">SO No&nbsp</td>
        <td ><gw:textbox id="txtvoucher_no" styles="width:100%" onenterkey="onSearch()"/></td>
        <td align="right">Trans Date&nbsp</td>
        <td><gw:datebox id="dtInvoiceDatefr" lang="1" /></td>
        <td align="center">~</td>
        <td><gw:datebox id="dtInvoiceDateto" styles="width:100%" lang="1" /></td>
        <td align="right">Customer&nbsp</td>
        <td>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0" style="height:100%">
            <tr>
                <td width="30%"><gw:textbox id="txtven_cd" styles='width:100%' onenterkey="onEnter()" onkeypress="CheckNumeric()"/></td>
                <td width="60%"><gw:textbox id="txtven_nm" styles='width:100%'/></td>
                <td width="0%"><gw:textbox  id="txtven_pk" styles='display:none'/></td>
                <td width="5%"><gw:imgBtn   img="popup"	id="idSearchVen" alt="Popup" onclick="onSearchVen()"/></td> 
                <td width="5%"><gw:imgBtn   img="reset"	id="idResetVen"  alt="Reset" onclick="onResetVen()"/></td>
            </tr>
            </table>
        </td>
        <td>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0" style="height:100%">
            <tr>
                <td align="center" width="40%"><gw:label id="lblsum" text="0" styles="color:red;width:90%;font-weight: bold;font-size:12"/></td>
                <td align="right" width="60%"><gw:label id="lblLabel" text="record(s)" styles="color:red;width:90%;font-weight: bold;font-size:12"/>&nbsp;</td>
            </tr>
            </table>
        </td>
        <td><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
    </tr>
    <tr style="height:45%;">
        <td colspan="10" >
            <gw:grid
                id      ="grdDtl"  
                header  ="_tsa_sotakeoutd_pk|Item Code|Item Name|UOM|Unit Price|Actural Q'ty|Invoce Q'ty|Diff Q'ty|SO|_ItemPK|Ccy"
                format  ="0|0|0|0|0|0|0|0|0|0|0"
                aligns  ="0|1|0|1|3|3|3|3|0|0|0"
                defaults="||||||||||"
                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0"
                widths  ="0|1300|2500|800|1500|1500|1500|1400|2000|0|1000"
                styles  ="width:100%; height:100%"                
                sorting ="F"
                oncelldblclick  = "DBPopupClickDtl()"
            />
        </td>
    </tr>
    <tr style="height:5%" >
        <td colspan="10" >
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width=85%></td>
                <td width=5%><gw:imgBtn id="idBtnDel" img="delete" alt="Delete" onclick="OnDelete()" /></td>
                <td width=5%><gw:imgBtn id="idBtnSave" img="save" alt="Save" onclick="OnSave()" /></td>            
                <td width=5%><gw:imgBtn id="idBtnOK" alt="Select" img="select" onclick="OnSelect()" /></td>            
            </tr>
        </table>
        </td>
    </tr>        
    <tr style="height:40%">
        <td colspan="10">
            <gw:grid
                id      ="grdDtl2"  
                header  ="_pk|_tsa_sotakeoutd_pk|_tac_crcad_pk||Item Code|Item Name|UOM|UPrice|Invoice Q'ty|SO No|Ccy|_Actural_Qty|_DiffQty|_ItemPK|_Inv_Qty_Origin|Amount Trans|Amount Books|_acnt_yn|Acc PK|Acc Code|Acc Name"
                format  ="0|0|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                aligns  ="0|0|0|1|0|0|0|1|3|3|0|0|0|0|0|3|3|0|0|0|0"
                defaults="||||||||||||||||||||"
                editcol ="0|0|0|1|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0"
                widths  ="0|0|0|500|1500|1500|2500|1000|1500|1500|2000|1000|0|0|0|1500|1500|0|0|0|0"
                styles  ="width:100%; height:100%"
                sorting ="F"                
                onafteredit="OnChangeInvQty()"
				onbeforeedit="OnBeforeChangeInvQty()"
            />
        </td>
    </tr>    
</table>

<gw:textbox id="txtcompk"           style="display:none" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>