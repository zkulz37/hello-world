<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Processing Uniform</title>
</head>
<script>
var systemdate   = "";
var v_language   = "<%=Session("SESSION_LANG")%>";
var emp_pk       = "<%=Session("EMPLOYEE_PK")%>";
var emp_id       = "<%=Session("EMP_ID")%>";
var emp_name     = "<%=Session("USER_NAME")%>";
var emp_dept     = "<%=Session("DEPT_PK")%>";
var emp_grp      = "<%=Session("GROUP_PK")%>";
var log_id       = "<%=Session("LOGIN_ID")%>";

var col_req_qty   = 8;
var col_item_pk   = 9;
var col_amount    = 11;
var col_status    = 14;
var col_sta_name  = 15;
var col_provid    = 16;
var col_remark_ga = 18;
var l_status;

function BodyInit()
{        
    if (v_language!="ENG")
        System.Translate(document); 
        
    var con = grdData.GetGridControl();
    con.FrozenCols = 5; 
    con.ColFormat(col_req_qty) = "###,###,###,###,###";
    con.ColFormat(col_amount)  = "###,###,###,###,###.##";
    
    GetLastMonth();
    BindingData();    
        
    txtLogID.text = log_id;
    txtRemark.SetEnable(false);
    
    OnSearch();
}

function BindingData()
{
    //<%=ESysLib.SetGridColumnComboFormat("grdData", 15, "select code, code_nm from thr_code_detail  where del_if = 0 and thr_code_master_pk = 709 and code <> 10 order by code")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdData", 9, "select pk, type_id||'-'||type_name from thr_unit_cost  where del_if = 0 and category_code = '50' order by 2")%>;
    var data = "";

    data = "<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All"; 
    lstOrg.SetDataText(data);
    lstOrg.value = 'ALL';
    
    data = "<%=ESysLib.SetListDataSQL("select code, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = 709 and code not in(60, 90) order by code")%>";
    lstStatus.SetDataText(data);    
    lstStatus.value = '10';
    
    data = "<data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID";
    lstType.SetDataText(data);
    lstType.value = 2;
}

function GetLastMonth()
{
    sysDate = new Date()
    newDate1 = sysDate.getMonth() 
    if (Number(newDate1) < 10)    
        newDate1="0"+ String(newDate1) 
    newDate2 = sysDate.getDate() 
    if (Number(newDate2) < 10 )
        newdate2="0" +String(newDate2) 
    newDate3 = sysDate.getFullYear()
    
    sysDate = newDate3 + newDate1 + newDate2
    
    dtSubmitF.SetDataText(sysDate);
}

function GetSysdate()
{
    sysDate = new Date()
    newDate1 = sysDate.getMonth()+1 
    if (Number(newDate1) < 10)    
        newDate1="0"+ String(newDate1) 
    newDate2 = sysDate.getDate() 
    if (Number(newDate2) < 10 )
        newdate2="0" +String(newDate2) 
    newDate3 = sysDate.getFullYear()
    
    systemdate = newDate3 + newDate1 + newDate2
}

function OnShowPopup(n)
{
    switch(n)
    {
        case 2:
            var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
            
            if (obj!=null)
            {
                 lstOrg.value=obj;
            }
            break;
    }    
}

function OnSearch()
{
    idData_sp_sel_chjb00030.Call('SELECT');
}

function ReceiveData(obj)
{
    switch(obj.id)
    {
        case 'idData_sp_sel_chjb00030':
            lbRecord.text = grdData.rows-1 + " record(s)"; 
            txtRemark.SetDataText('');
            txtRemarkGA.SetDataText('');
            
            if (lstStatus.GetData() == 10) // Submited
            {
                idBtnPrepare.SetEnable(true);
                idBtnOrder.SetEnable(true);
                idBtnProvide.SetEnable(true);
                idBtnRequest.SetEnable(true);
                idBtnReject.SetEnable(true);
                txtRemarkGA.SetEnable(true);
            }
            else if (lstStatus.GetData() == 20) // Prepared
            {
                idBtnPrepare.SetEnable(false);
                idBtnOrder.SetEnable(true);
                idBtnProvide.SetEnable(true);   
                idBtnRequest.SetEnable(false);
                idBtnReject.SetEnable(false);
                txtRemarkGA.SetEnable(true);
            }
            else if (lstStatus.GetData() == 30) // Ordered
            {
                idBtnPrepare.SetEnable(false);
                idBtnOrder.SetEnable(false);
                idBtnProvide.SetEnable(true);   
                idBtnRequest.SetEnable(false);
                idBtnReject.SetEnable(false);
                txtRemarkGA.SetEnable(true);
            }
            else if (lstStatus.GetData() == 50) // Provided
            {
                idBtnPrepare.SetEnable(false);
                idBtnOrder.SetEnable(false);
                idBtnProvide.SetEnable(false);   
                idBtnRequest.SetEnable(false);
                idBtnReject.SetEnable(false);
                txtRemarkGA.SetEnable(false);
            }
            else if (lstStatus.GetData() == 70) // Request Info
            {
                idBtnPrepare.SetEnable(false);
                idBtnOrder.SetEnable(false);
                idBtnProvide.SetEnable(false);
                idBtnRequest.SetEnable(false);
                idBtnReject.SetEnable(false);
                txtRemarkGA.SetEnable(false);
            }
            else if (lstStatus.GetData() == 80) // Reject
            {
                idBtnPrepare.SetEnable(false);
                idBtnOrder.SetEnable(false);
                idBtnProvide.SetEnable(false);   
                idBtnRequest.SetEnable(false);
                idBtnReject.SetEnable(false);
                txtRemarkGA.SetEnable(false);
            }
            else
            {
                idBtnPrepare.SetEnable(true);
                idBtnRequest.SetEnable(true);
                idBtnReject.SetEnable(true);
                idBtnOrder.SetEnable(true);
                idBtnProvide.SetEnable(true);
                txtRemarkGA.SetEnable(true);
            }            
            break;
    }    
}

function AfterEdit()
{
    if (grdData.col == col_status)
    {
        if (grdData.GetGridData(grdData.row, col_status) == '50') // Provided
        {
            GetSysdate();
            grdData.SetGridText(grdData.row, col_provid, systemdate);
        }
        else
            grdData.SetGridText(grdData.row, col_provid, '');
    }
}

function OnClick()
{
    if (grdData.GetGridData(grdData.row, col_status) == 20) // Prpared
    {        
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(true);
        idBtnProvide.SetEnable(true);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(true);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 30) // Ordered
    {        
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(false);
        idBtnProvide.SetEnable(true);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(true);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 50) // Provided
    {
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(false);
        idBtnProvide.SetEnable(false);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 70) // Request Info
    {
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(false);
        idBtnProvide.SetEnable(false);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 80) // Reject
    {
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(false);
        idBtnProvide.SetEnable(false);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 90) // Cancel
    {
        idBtnPrepare.SetEnable(false);
        idBtnOrder.SetEnable(false);
        idBtnProvide.SetEnable(false);
        idBtnRequest.SetEnable(false);
        idBtnReject.SetEnable(false);
        txtRemarkGA.SetEnable(true);
    }
    else
    {
        idBtnPrepare.SetEnable(true);
        idBtnOrder.SetEnable(true);
        idBtnProvide.SetEnable(true);
        idBtnRequest.SetEnable(true);
        idBtnReject.SetEnable(true);
    }
    
    txtRemark.SetDataText(grdData.GetGridData(grdData.row, 17));
    txtRemarkGA.SetDataText(grdData.GetGridData(grdData.row, 18));
}

function OnSet(n)
{    
    var con = grdData.GetGridControl();
    
    for( var i = 1; i < grdData.rows; i++ )
    {
        if (grdData.GetGridData(i, 1) == '-1')
        {
            switch(n)
            {
                case 1:                    
                    con.TextMatrix(i , col_provid) = dtProvided.text;
                    l_status = con.TextMatrix(i , col_status) = 50;
                    break;
                    
                case 4: // Prepared
                    con.TextMatrix(i , col_status) = 20;
                    l_status = 20;
                    break;
                    
                case 5: // Order
                    con.TextMatrix(i , col_status) = 30;
                    l_status = 30;
                    break;
                    
                case 6: // Provide
                    if (grdData.GetGridData(i, col_provid) == "") 
                    {
                        alert('You must input Provide Date');
                        return;
                    }
                    else 
                    {
                        con.TextMatrix(i , col_status) = 50;
                        l_status = 50;
                    }
                    break;
                    
                case 7: // Request Info
                    if (txtRemarkGA.GetData() == "")
                    {
                        alert('You must input Remark(GA)');
                        return;
                    }
                    
                    con.TextMatrix(i , col_status) = 70;
                    l_status = 70;
                    break;
                    
                case 8: // Reject
                    if (txtRemarkGA.GetData() == "")
                    {
                        alert('You must input Remark(GA)');
                        return;
                    }
                    con.TextMatrix(i , col_status) = 80;
                    l_status = 80;
                    break;
            }
            lstStatus.value = l_status;
            grdData.SetGridText(grdData.row, 18, txtRemarkGA.GetData());
            grdData.SetRowStatus(i, 16);
            idData_sp_sel_chjb00030.Call();
        }
    }
}

</script>

<body>

<gw:data id="idData_sp_sel_chjb00030" onreceive="ReceiveData(this)">
    <xml>
        <dso id="1" type="grid" parameter="0,9,11,14,16,17,18" function="hr.sp_sel_chjb00030" procedure="hr.sp_upd_chjb00030">
            <input bind="grdData" >
                <input bind="dtSubmitF" />
                <input bind="dtSubmitT" />
                <input bind="dtProvided" />
                <input bind="lstOrg" />
                <input bind="lstStatus" />
                <input bind="lstType" />
                <input bind="txtName" />
            </input>
            <output bind="grdData" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr height="10%">
        <td style="background: white">
            <table width="100%" border="0" >
                <tr>
                    <td width="10%" align="right" >Submitted date</td>
                    <td width="10%"><gw:datebox id="dtSubmitF" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>
                    <td width="5%" align="center">~</td>
                    <td width="10%"><gw:datebox id="dtSubmitT" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>
                    <td width="10%">&nbsp; &nbsp; &nbsp;Provided Date</td>
                    <td width="10%"><gw:datebox id="dtProvided" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/></td>
                    <td width="14%"><gw:icon id="idBtnSetPro" img="in" text="Set All" onclick="OnSet(1)" /></td>
                    <td width="6%" ></td>
                    <td width="38%" colspan="3" >
                        <table width="100%">
                            <tr> 
                                <td width="3%"><gw:imgBtn img="search" alt="Search" onclick ="OnSearch()"/></td>
                                <!--td width="3%"><gw:imgBtn img="excel"  alt="Print"  onclick ="OnPrint()"/></td-->
                                <td width="10%"><gw:icon id="idBtnPrepare" img="in" text="Prepared"     onclick="OnSet(4)" /></td>
                                <td width="10%"><gw:icon id="idBtnOrder"   img="in" text="Ordered"      onclick="OnSet(5)" /></td>
                                <td width="10%"><gw:icon id="idBtnProvide" img="in" text="Provided"     onclick="OnSet(6)" /></td>
                                <td width="10%"><gw:icon id="idBtnRequest" img="in" text="Request Info" onclick="OnSet(7)" /></td>
                                <td width="10%"><gw:icon id="idBtnReject"  img="in" text="Reject"       onclick="OnSet(8)" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="10%" align="right"><a title="Click here to show Org" onclick="OnShowPopup(2)" href="#tips" >Org</a></td>
                    <td width="25%" colspan="3"><gw:list id="lstOrg" value="ALL" maxlen = "100" styles='width:100%'onchange="OnSearch()" ></gw:list></td>
                    <td width="10%">&nbsp; &nbsp; &nbsp;Employee</td>
                    <td width="10%"><gw:list  id="lstType" value="" styles='width:100%' /></td> 
                    <td width="14%"><gw:textbox id="txtName"   styles="width:100%;" onenterkey="OnSearch()" /></td> 
                    <td width="6%">&nbsp; &nbsp; &nbsp;Status</td>
                    <td width="10%"><gw:list id="lstStatus" value="ALL" maxlen = "100" styles='width:100%' onchange="OnSearch()" ></gw:list></td>
                    <td width="18%"></td>
                    <td width="10%"><b style="color: Blue; cursor: hand" ><gw:label id="lbRecord">record(s)</gw:label></b></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr  height="90%">
        <td>
            <gw:grid   
            id="grdData"
            header="_PK|Select|Dept|_Group|Emp ID|Emp Name|Order No|Submited Date|Req Qty|Item|Size|Amount|Receiving Location|Laundry Location|_Status|Status|Provided Date|Remark|Remark(GA)"
            format="0|3|0|0|0|0|0|4|2|0|2|2|0|0|0|0|4|0|0"
            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
            defaults="||||||||||||||||||"
            editcol="0|0|0|0|0|0|0|0|0|1|0|0|0|0|1|0|1|0|0"
            widths="0|0|2500|2500|1500|2500|1500|2000|1000|2000|1000|2000|2500|2500|1500|1500|1500|1500|1500"
            styles="width:100%; height:100%"   
            sorting="T" onafteredit="AfterEdit()" acceptNullDate="true" oncellclick="OnClick()"
            />
        </td>
    </tr>
    <tr>
        <td >
            <table width="100%" border="0">
                <tr>
                    <td width="50%" style="background: white"><a><gw:label id="lblRemark"   styles="width:100%;font-size:16px" text="Remark" /></a></td>
                    <td width="50%" style="background: white"><a><gw:label id="lblRemarkGA" styles="width:100%;font-size:16px" text="Remark(GA)" /></a></td>
                </tr>
                <tr>
                    <td style="background: white" width="50%"><gw:textarea id="txtRemark" rows="5" styles="width:100%" /></td>
                    <td style="background: white" width="50%"><gw:textarea id="txtRemarkGA" rows="5" styles="width:100%" /></td>
                </tr>
            </table>
        </td>        
    </tr>
</table>
<gw:textbox id="txtEmpPK"     styles="width:100%;display:none" />
<gw:textbox id="txtLogID"     styles="width:100%;display:none" />
</body>