<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">


var click_dr = 0;
var click_cr = 0;

var flag_select = false;


function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    lstTRADE.SetDataText("ALL");
    lstRATE.SetDataText("ALL");
    lstLANG.SetDataText("VIE");
    rdoSTATUS.SetDataText("2");
    txtSUM_NET.SetEnable(false);
    txtSUM_VAT.SetEnable(false);
    OnChangCompany();
}

function BindingDataList()
{
    var ls_comp     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_ccy      = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
    var ls_rate     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACCR0110','03','') FROM DUAL")%>|ALL|All Types";
    var ls_trade    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('CODC0120','01','') FROM DUAL")%>|ALL|All Types";    
    var ls_lang      = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('HRAB0180','02','') FROM DUAL")%>";
    var dataLstType = "Data|1|Monthly|2|Quarter|3|Year|4|As current"; 
    rdoType.SetDataText(dataLstType); 
    lstLANG.SetDataText(ls_lang);
    lstCOMPANY.SetDataText(ls_comp);
    lstTRADE.SetDataText(ls_trade);
    lstRATE.SetDataText(ls_rate);
    lstCCY.SetDataText(ls_ccy);  
    
    
}

function OnChangCompany()
{
    sel_busplace.Call();
}

function OnResetInvoice()
{
    if(event.keyCode == 27){
        txtINVOICENO.SetDataText("");
    }

}
function OnSearch()
{
    dso_sel_grd_vat_inquiry.Call("SELECT");
}
function OnSum()
{

    var ctrl = grid.GetGridControl();
    var sum_net = 0;
    var sum_amt = 0;
    for(i = 1; i<ctrl.Rows; i++)
    {
        
        sum_net = sum_net + Number(grid.GetGridData(i,14));
        sum_amt = sum_amt + Number(grid.GetGridData(i,15));
    }
    
    txtSUM_NET.SetDataText(""+sum_net);
    txtSUM_VAT.SetDataText(""+sum_amt);
    lblRECORD.text = (ctrl.Rows -1);
}

function OnSearchCust()
{
	var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	var object = System.OpenModal( path ,800, 600, 'resizable:yes;status:yes');
	if ( object != null )
	{
	    if (object[0] != 0)
        {
            txtCUST_PK.text = object[0];
            txtCUST_NM.text = object[2];
            txtCUST_ID.text = object[1];
        }
    }
}

function OnResetCust()
{   
    //esc:27
    if(event.keyCode == 27){
        txtCUST_PK.SetDataText("");
        txtCUST_NM.SetDataText("");
        txtCUST_ID.SetDataText("");
    }
}
function OnReport()
{
    if(confirm("Are you sure you want to report ?" ))
    {
        //alert(rdoVAT_TYPE.GetData());
        if(rdoVAT_TYPE.GetData()=="1")
        {
            switch (lstLANG.GetData())
            {
                case "VIE":
                    var url = '/reports/gf/lv/gflv00020_rpt_VAT_In.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
                    break;
                case "ENG":
                    var url = '/reports/gf/lv/gflv00020_rpt_VAT_In_ENG.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
                    break;
            }
        }       
        else
        {
            switch (lstLANG.GetData())
            {
                case "VIE":
                    var url = '/reports/gf/lv/gflv00020_rpt_VAT_Out.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
                    break;
                case "ENG":
                    var url = '/reports/gf/lv/gflv00020_rpt_VAT_Out_ENG.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
                    break;
            }
            //var url = '/reports/gf/lv/gflv00020_rpt_VAT_Out.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData();
        }
        //alert(url);
        System.OpenTargetPage( System.RootURL+url , 'newform' )
    }
    
}
function OnReport2()
{
    if(confirm("Are you sure you want to report ?" ))
    {
        //alert(rdoVAT_TYPE.GetData());
        if(rdoVAT_TYPE.GetData()=="1")
        {
            
            var url = '/reports/gf/lv/gflv00400_import_VAT_in.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
             
        }
        else
        {
            var url = '/reports/gf/lv/gflv00400_import_VAT_Out.aspx?com=' + lstCOMPANY.GetData() + '&yyyymm=' + txtMonth.GetData() + '&status=' + rdoSTATUS.GetData() + '&vat_rate='+ lstRATE.GetData() + '&ccy=' + lstCCY.GetData() + '&cust_pk=' + txtCUST_PK.GetData()+'&acc_pk='+txtac_pk.text;
        }
        
        System.OpenTargetPage( System.RootURL+url , 'newform' )
    }
    
}
function RowClick()
{
    var rows =0;
    var rownum =0;
    var colnum =0;
    var pk = 0;
    var status = "";
    var ls_arr = ""; 

    var ctrl = grid.GetGridControl();
    rows = ctrl.Rows;
    rows = rows - 1;
    rownum = ctrl.row;
    pk = grid.GetGridData(ctrl.row, 1);
    status = grid.GetGridData(ctrl.row, 6);
//    for (i = 1; i < grid.rows; i++)
//    {
//        ls_arr = ls_arr + ' ' + grid.GetGridData(i, 1);
//    } 

    if (rownum > 0) 
    {
        var fpath = System.RootURL + '/form/gf/hg/gfhg00020_popup.aspx?PK_ROW=' + pk + '&ROW=' + rownum + '&ROWS=' + rows + '&APPRCANCEL=' + status + "&ARRAY_PK=" + ls_arr;
        var wWidth = 950;
        var wHeight = 600;
        var x = Math.round((screen.availWidth - wWidth)/2);
        var y = Math.round((screen.availHeight - wHeight)/2);

        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +"lef="+ x +",top=" + y;
        this.name = "gflv00020";
        var object = System.OpenModal(fpath, wWidth, wHeight, features, window);
    }
}

function GetRowPK(row_index){
    if((row_index < grid.rows) && (row_index > 1)){
        return grid.GetGridData(row_index, 1);
    }
    return -1;
}

function OnDataReceive(obj)
{   
    if(obj.id =="sel_busplace")
    {
        
    }
}
function OnGetAccount(){
    var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCOMPANY.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
    o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes');	
    if (o != null)
	{
		if(o[0] != 0)
		{
		    txtAC_CD.SetDataText(o[0]);
			txtAC_Name.SetDataText(o[1]);
			txtac_pk.SetDataText(o[3]);
		}
    }
}
function OnResetAccount(){
    if(event.keyCode == 27){
        txtAC_CD.SetDataText("");
	    txtAC_Name.SetDataText("");
	    txtac_pk.SetDataText("");
    }
}
</script>

<body style="margin: 0; padding: 0;">
    <gw:data id="dso_sel_grd_vat_inquiry" onreceive="OnSum()">
        <xml>
            <dso type="grid" function="ACNT.SP_SEL_GRD_VAT_INQUIRY">
                <input bind="grid">
                    <input bind="lstCompany"/>
                    <input bind="txtMonth"/>
                    <input bind="rdoVAT_TYPE"/>
                    <input bind="lstRATE"/>
                    <input bind="lstTRADE"/>
                    <input bind="lstCCY"/>
                    <input bind="rdoSTATUS"/>
                    <input bind="txtCUST_PK"/>
                    <input bind="txtINVOICENO"/>
                    <input bind="txtAC_CD"/>
                    <input bind="txtSeq"/>
                    <input bind="txtVoucherNo"/>
                </input>
                <output bind="grid"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="sel_busplace" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="ACNT.SP_LIST_BIZ" > 
                <input>
                    <input bind="lstCompany" /> 
                </input> 
                <output>
                    <output bind="lstBIZ" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------------------------->
    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="height:2%" valign="top">
            <td style="width:4%">Company</td>
            <td style="width:13%"><gw:list id="lstCOMPANY" onchange="OnChangCompany()"></gw:list></td>
            <td style="width:5%">Biz.Place</td>
            <td style="width:11%"><gw:list id="lstBIZ" styles='width:100%' /></td>
            <td style="width:5%">Trade Origin</td>
            <td style="width:12%"><gw:list id="lstTRADE" styles='width:100%'></gw:list></td>
            <td style="width:4%">Month</td>
            <td style="width:4%"><gw:datebox id="txtMonth" type="month" lang="<%=Session("Lang")%>" onchange="OnSearch()" /></td>
            <td style="width:2%">Seq</td>
            <td style="width:10%"><gw:textbox id="txtSeq" onenterkey="OnSearch()" /></td>
            <td style="width:12%" align="right">VAT Type</td>
            <td style="width:17%"><gw:radio id="rdoVAT_TYPE" value="1" onchange="OnSearch()">
                                          <span value="1">In  </span>
                                          <span value="2">Out</span>
                                </gw:radio></td>
            <td style="width:1%"><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
            <td style="width:1%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" /></td>
            <td style="width:1%"><gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport2()" /></td>
        </tr>
        <tr style="height:2%" valign="top">
            <td ><a href="#" onclick="OnSearchCust()" title="Get customer(press Esc key to reset)">Customer</a></td>
            <td ><gw:textbox id="txtCUST_ID" styles='width=100%' onkeypress="OnResetCust()" onenterkey="OnSearch()" /></td>
            <td colspan="2"><gw:textbox id="txtCUST_NM" styles='width=100%' /></td>
            <td align="right">Currency</td>
            <td ><gw:list id="lstCCY" styles='width:100%' /></td>
            <td align="right">Tax.Rate</td>
            <td colspan="2"><gw:list id="lstRATE" styles='width:100%' onchange="OnSearch()" /></td>
            <td colspan="2" align="right">Voucher No</td>
            <td colspan="4"><gw:textbox id="txtVoucherNo" onenterkey="OnSearch()" styles="width:100%" /></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
        </tr>
         <tr style="height:2%" valign="top">
            <td><a href="#" onclick="OnGetAccount()" title="Get account">Account</a></td>
            <td><gw:textbox id="txtAC_CD" styles="width:100%" onkeypress="OnResetAccount()" onenterkey="OnSearch()" /></td>
            <td colspan="2"><gw:textbox id="txtAC_Name" styles="width:100%" /></td>
            <td align="right">Language</td>
            <td><gw:list id="lstLANG" styles="width:100%" onchange="OnSearch()" /></td>
            <td>Status</td>
            <td colspan="3"><gw:radio id="rdoSTATUS" value="1" onchange="OnSearch()">
                                            <span value="2">Confirmed</span>
                                            <span value="0">Approved</span>
                                  </gw:radio></td>
            <td align="right">&nbsp;Invoice.No</td>
            <td colspan="4"><gw:textbox id="txtINVOICENO" styles='width:100%' onenterkey="OnSearch()" onkeypress="OnResetInvoice()" /></td>
            <td></td>
            <td></td>
            <td"></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr style="height:2%" valign="top">
            <td>Type</td>
            <td colspan="3"><gw:list id="rdoType" styles="width:100%;" onchange="OnChangeDateType()" /></td>
            <td >Report.Type</td>
            <td ><gw:list id="lstReporttype" styles='width:100%' onchange="OnSearch()" /></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
        </tr>
        <tr style="height:90%" valign="top">
            <td colspan="18">
                <gw:grid id="grid" header="NO|Seq|_pk|_comp_pk|_VAT type|Seri No|Invoice date|Invoice No|_cust_pk|Cust Name|Tax code|Address|Item|Ccy|Rate|Net Amt| VAT Amt|Voucher No|Trs. date|User"
                                    format="1|0|1|1|0|0|4|0|0|0|0|0|0|0|0|1|1|0|4|0" aligns="1|1|0|0|0|1|1|0|0|0|0|0|0|1|1|3|3|0|1|0"
                                    acceptnulldate="T" defaults="|||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                    widths="600|600|0|0|0|1200|1600|1600|0|2500|1500|2500|2500|600|800|1800|1800|1800|1200|1200"
                                    styles="width:100%; height:390" sorting="T" oncelldblclick="RowClick()" />
            </td>
        </tr>
        <tr style="height:2%" valign="top">
            <td>Total</td>
            <td><gw:label id="lblRECORD" text="0" /></td>
            <td><font color="red">Invoices&nbsp;</td>
            <td colspan="2" align="right">Sum Net Amt&nbsp;</td>
            <td colspan="2"><gw:textbox id="txtSUM_NET" type="number" format="#,###,###,###,###R"></gw:textbox></td>
            <td></td>
            <td colspan="3" align="right">Sum VAT Amt&nbsp;</td>
            <td colspan="4"><gw:textbox id="txtSUM_VAT" type="number" format="#,###,###,###,###R"></gw:textbox></td>
            <td></td>
            <td></td>
            <td></td>
            
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
            <td ></td>
        </tr>
    </table>
    <!---------------------------------------------------------------------------------------------------->
    <gw:textbox id="txtCUST_PK" styles='display:none'></gw:textbox>
    <gw:textbox id="txtac_pk" styles='display:none'></gw:textbox>
</body>
</html>
