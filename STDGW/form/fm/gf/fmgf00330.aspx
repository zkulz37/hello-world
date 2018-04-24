<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Daily Inventory Inquiry</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;

    var 
        iG0_No          = 0,
        iG0_Acc_Cd      = 1,
        iG0_Acc_Nm      = 2,
        iG0_Item_Code   = 3,
        iG0_Item_Name   = 4,
		iG0_Item_LName	= 5,
        iG0_UOM         = 6,
        iG0_WH          = 7,
        iG0_PL_CD       = 8,
        iG0_PL_NM       = 9,
        iG0_Open_Qty    = 10,
		iG0_Open_Tramt  = 11,
        iG0_Open_Amt    = 12,
        iG0_IN_Qty      = 13,
		iG0_IN_TrAmt    = 14,
        iG0_IN_Amt      = 15,		
        iG0_OUT_Qty     = 16,
		iG0_OUT_TrAmt   = 17,
        iG0_OUT_Amt     = 18,
        iG0_End_Qty     = 19,
		iG0_End_TrAmt     = 20,
        iG0_End_Amt     = 21;
        
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    txtAccountCode.SetEnable(false);
    txtAccountName.SetEnable(false);
    txtItemCode.SetEnable(false);
    txtItemName.SetEnable(false);
    txtPLCode.SetEnable(false);
    txtPLName.SetEnable(false);
	lstReport.value = 0;
	idGrid.GetGridControl().FrozenCols = iG0_Item_Name;
   idGrid.GetGridControl().ScrollTrack=true;    
    OnFormatGrid();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0 ORDER BY wh_name  ASC" )%>|ALL|ALL";    
    lstWH.SetDataText(data); 
    lstWH.value = 'ALL';       
}
//------------------------------------------------------------------------
function OnPopUp(iObj)
{
    switch(iObj)
    {
    case 'Account':
            if(Trim(lstCompany.value)=='')
            {
                alert('Must select Company!!!');
                return ;
            }            
            var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00050_3&val1=" + lstCompany.value + "&val2=" + lstWH.value + "&val3=" ;

            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
                txtAccountCode.text = object[0];
                txtAccountName.text = object[1];
                txtTAC_ABACCTCODE_PK.text = object[3];
            }    
        break ;
    case 'Item':        
            var path = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
                txtTCO_ITEM_PK.text = object[0] ;
                txtItemCode.text = object[1];
                txtItemName.text = object[2];
            }                        
        break;
    case 'PL':
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }              
        var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" +  + "&val1=" + lstWH.value ;
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
        if(object != null)
        {
            txttac_abplcenter_pk.text = object[2];
            txtPLCode.text = object[0];
            txtPLName.text = object[1];
        }
        break;
    }
}
//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'fmgf00330' :        
            fmgf00330.Call("SELECT")            
        break;
    }
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
    var i ;
    var lOpenQty = 0, lOpenAmt = 0, lInQty = 0, lInAmt = 0, lOutQty = 0, lOutAmt = 0, lEndQty = 0, lEndAmt = 0;          
    switch (obj.id)
    {
        case "fmgf00330" :            
            CalcuSubTotal();                 
			break;
		case "fmgf00330_1":
            CalcuSubTotal();       
			break ; 					
	}
}
//------------------------------------------------------------------------
function OnExcel()
{	
    var l_rpt_opt =  lstReport.value ;
    switch(l_rpt_opt)
    {
        case '1':
            var url = System.RootURL + "/reports/fm/gf/fmgf00330.aspx?std_ym=" + dbDaily.value + "&ac_cd=" + txtAccountCode.text + "&tin_warehouse_pk=" + lstWH.value + "&tco_company_pk=" + lstCompany.value + "&item_code=" + txtItemCode.text ;
            System.OpenTargetPage(url);        
        break ;
        case '0':
            var url = System.RootURL + "/reports/fm/gf/fmgf00110_1.aspx?std_ym=" + dbDaily.value + "&ac_cd=" + txtAccountCode.text + "&tin_warehouse_pk=" + lstWH.value + "&tco_company_pk=" + lstCompany.value + "&tco_item_pk=" + txtTCO_ITEM_PK.text + "&pl_cd=" + txtPLCode.text + "&std_ym_to=" ;
            System.OpenTargetPage(url);        
        break ;
        case '2':
            var url = System.RootURL + "/reports/fm/gf/fmgf00110_3.aspx?std_ym=" + dbDaily.value + "&ac_cd=" + txtAccountCode.text + "&tin_warehouse_pk=" + lstWH.value + "&tco_company_pk=" + lstCompany.value + "&item_code=" + txtItemCode.text ;
            System.OpenTargetPage(url);        
        break ;
	}    
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var trl ;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(iG0_Open_Qty)                 = "###,###,###,###,###.##";
	trl.ColFormat(iG0_Open_Tramt)                 = "###,###,###,###,###";
    trl.ColFormat(iG0_Open_Amt)                 = "###,###,###,###,###.##";
    trl.ColFormat(iG0_IN_Qty)                   = "###,###,###,###,###.##";
    trl.ColFormat(iG0_IN_TrAmt)                   = "###,###,###,###,###";
	trl.ColFormat(iG0_IN_Amt)                   = "###,###,###,###,###.##";
    trl.ColFormat(iG0_OUT_Qty)                  = "###,###,###,###,###.##";
    trl.ColFormat(iG0_OUT_TrAmt)                  = "###,###,###,###,###";
	trl.ColFormat(iG0_OUT_Amt)                  = "###,###,###,###,###.##";
    trl.ColFormat(iG0_End_Qty)                  = "###,###,###,###,###.##";	
    trl.ColFormat(iG0_End_TrAmt)                  = "###,###,###,###,###";
	trl.ColFormat(iG0_End_Amt)                  = "###,###,###,###,###.##";
}
//-----------------------------------------------------
function OnReset(iObj)
{
    switch(iObj)
    {
        case 'Account':
            txtAccountCode.text = "" ;
            txtAccountName.text = "" ;
            txtTAC_ABACCTCODE_PK.text = "" ;
        break;
        case 'Item':
            txtItemCode.text = '' ;
            txtItemName.text = '' ;                    
            txtTCO_ITEM_PK.text = '' ;
        break ;   
        case 'PL':         
            txtPLCode.text = '';
            txtPLName.text = '';
            txttac_abplcenter_pk.text = '' ;
        break ;            
    }
}
//-----------------------------------------------------
//function Upcase()
//{
//    var c = String.fromCharCode (event.keyCode);
//	var x = c.toUpperCase().charCodeAt(0);
//	event.keyCode = x;
//}
//-----------------------------------------------------
function CalcuSubTotal()
{                
        var ctr=idGrid.GetGridControl(); 
        ctr.OutlineBar =2 ;
        //ctr.SubtotalPosition=0;
        var color;
        var caption;
        var operator;        
        for (var igroup=0;igroup<=1;igroup++)
        {
            switch (igroup)
            {
                case 0:
                {
                    color=0xCCFFFF ;
                    caption='Grand Total';
                    break;
                }
                case iG0_Acc_Cd:
                {
                    color = 0xCCFFFF ;
                    caption='%s';
                    break;
                }                
            }
            for(var itotal = iG0_Open_Qty; itotal <= iG0_End_Amt; itotal++)
            {                
                ctr.SubTotal(2, igroup, itotal, '', color, 0x000000, '1', caption, '', true);
            }
        auto_resize_column(idGrid, 0, idGrid.cols-1, 10); 
    }            
}
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
     obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function OnGetData()
{
	if(chkGetData.value == "T")
	{
		fmgf00330_1.Call("SELECT");
	}
}
//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00330" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00330" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany" />
                    <input bind="dbDaily" />
                    <input bind="txtAccountCode" />
                    <input bind="txtAccountName" />
                    <input bind="txtTCO_ITEM_PK" />                    
                    <input bind="txtPLCode" />
                    <input bind="txtPLName" />
                    <input bind="lstWH" />                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00330_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00330_1" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany" />
                    <input bind="dbDaily" />
                    <input bind="txtAccountCode" />
                    <input bind="txtAccountName" />
                    <input bind="txtTCO_ITEM_PK" />                    
                    <input bind="txtPLCode" />
                    <input bind="txtPLName" />
                    <input bind="lstWH" />                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->	
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 8%"></td>
                    <td style="width: 14%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 4%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>				
					<td align="right">Date&nbsp;</td>
					<td align="left" ><gw:datebox id="dbDaily" type="day" lang="1" /></td>
					<td align="right" colspan="1" >Get Data&nbsp;</td>
					<td><gw:checkbox id="chkGetData" align="left" onchange="OnGetData()" /></td>		
                    <td align="right" ><a title="Click here to select Product Item" onclick="OnPopUp('Item')" href="#tips">Item&nbsp;</a></td>
                    <td align="left" ><gw:textbox id="txtItemCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtItemName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
						<gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="OnReset('Item')" />
                    </td>                                                            					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('fmgf00330')" /></td>
                    <td align="right"></td>
                    <td align="right"><gw:imgbtn img="excel" alt="Report" id="btnExcel2" onclick="OnExcel()" /></td>					
				</tr>
				<tr>
                    <td align="right" >WH&nbsp;</td>
                    <td colspan="1" align="left" ><gw:list id="lstWH" styles="width:100%; " onchange="OnSearch('fmgf00330')" /></td>				
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" />
					</td>
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " csstype="mandatory" /></td>                    
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" /></td>                    					
					<td colspan="3" align="right" ><gw:list id="lstReport" styles="width:100%;" >
					<data>DATA|0|Report by Item|1|Report by Item Group|2|Report Input Detais</data>
					</gw:list>
					</td>
				</tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:90%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="|Acc.Cd|Acc.Nm|Item Code|Item Name|Item Localname|UOM|WH|PL CD|PL NM|Begin Qty|Begin Trans Amt|Begin Amt|IN Qty|IN Trans Amt|IN Amt|OUT Qty|Out Trans Amt|OUT Amt|End Qty|End Trans Amt|End Amt"
                            format="0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1" 
                            aligns="2|1|0|2|2|2|1|2|2|2|3|3|3|3|3|3|3|3|3|3|3|3"
                            defaults="|||||||||||||||||||||" 
                            editcol="0|1|1|1|1|0|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1" 
                            widths="1000|1200|2000|1200|3000|2500|800|1800|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T"     
						/>			
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txtTAC_ABACCTCODE_PK" styles="display:none; " />
<gw:textbox id="txtTCO_ITEM_PK" styles="display:none; " />
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
</body>
</html>