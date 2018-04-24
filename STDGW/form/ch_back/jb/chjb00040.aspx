<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Reason of Cancellation</title>
</head>
<script>

var flag_YN    = 'N';
var emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var emp_name   = "<%=Session("USER_NAME")%>";
var emp_id     = "<%=Session("User_ID")%>";
var v_language = "<%=Session("SESSION_LANG")%>";

var l_status;
var col_amount    = 8;
var col_req_qty   = 9;
var col_status    = 12;
var col_provid    = 13;
var col_remark    = 15;
var col_remark_ga = 16;
var col_cancel    = 17;

var submited = 10;
var prepared = 20;
var ordered  = 30;
var provided = 50;
var save     = 60;
var request  = 70;
var reject   = 80;
var cancel   = 90;

function BodyInit()
{   
    if (v_language!="ENG")
        System.Translate(document); 
        
    var con = grdData.GetGridControl();
    con.FrozenCols = 6; 
    con.ColFormat(col_amount) = "###,###,###,###,###"; 
    con.ColFormat(col_req_qty) = "###,###,###,###,###"; 
    GetLastMonth();
    
    txtName.text  = emp_name;
    txtEmpPK.text = emp_pk;
    txtEmpID.text = emp_id;
    
    txtName.SetEnable(false);
    txtRemarkGA.SetEnable(false);
    
    <%=ESysLib.SetGridColumnComboFormat("grdData", 12, "select code, code_nm from thr_code_detail  where del_if = 0 and thr_code_master_pk = 709 order by code")%>;
    <%=ESysLib.SetGridColumnComboFormat("grdData", 6, "select pk, type_id||'-'||type_name from thr_unit_cost  where del_if = 0 and category_code = '50' order by 2")%>;
    
    var data = "";
    data = "<%=ESysLib.SetListDataSQL("select code, code_nm from thr_code_detail  where del_if = 0 and thr_code_master_pk = 709 order by code")%>|ALL|Select All";
    lstStatus.SetDataText(data);    
    lstStatus.value = 'ALL';
    
    idData_sp_sel_chjb00040.Call('SELECT');
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
    
    dtDateF.SetDataText(sysDate);
}

function OnSearch()
{
    idData_sp_sel_chjb00040.Call('SELECT');
}

function OnNew()
{
    System.Menu.NewWindow( "form/ch/jb/chjb00020.aspx" , "Uniform App Entry", "Uniform App Entry", "Uniform App Entry" );
}

function OnModify()
{
	if (grdData.row != -1)
	{	
	    System.Menu.NewWindow( "form/ch/jb/chjb00020.aspx?p_app_pk=" + grdData.GetGridData(grdData.row, 0) , "Uniform App Entry", "Uniform App Entry", "Uniform App Entry" );
	}
}

function ReceiveData()
{
    lbRecord.text = grdData.rows-1 + " record(s)";
}

function OnSave()
{
    for(var i=1; i<grdData.rows;i++)
    {
        if(grdData.GetGridData(i, col_status) == "")
        {
            alert('You must input data at column Status. Row : ' + i);
            return;
        }
    }
    idData_sp_sel_chjb00040.Call();
}

function OnDBClick()
{
    if (grdData.col == col_cancel)
    {
        OnCancel();
    }
}

function OnClick()
{
    if (grdData.GetGridData(grdData.row, col_status) == 10) // Submited
    {
        grdData.row = -1;
        return;
    }   
    else if (grdData.GetGridData(grdData.row, col_status) == 20) // Prepared
    {        
        txtRemark.SetEnable(true);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(false);
        idBtnDelete.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 30) // Ordered
    {        
        txtRemark.SetEnable(true);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(false);
        idBtnDelete.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 50) // Provided
    {
        txtRemark.SetEnable(false);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(false);
        idBtnDelete.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 60) // Save
    {
        idBtnCancel.SetEnable(true);
        idBtnModify.SetEnable(true);
        idBtnDelete.SetEnable(true);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 70) // Request Info
    {
        txtRemark.SetEnable(false);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(true);
        idBtnDelete.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 80) // Reject
    {
        txtRemark.SetEnable(false);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(false);
        idBtnDelete.SetEnable(false);
    }
    else if (grdData.GetGridData(grdData.row, col_status) == 90) // Cancel
    {
        txtRemark.SetEnable(false);
        idBtnCancel.SetEnable(false);
        idBtnModify.SetEnable(false);
        idBtnDelete.SetEnable(false);
        
        if (grdData.GetGridData(grdData.row, col_cancel) == "")
            OnCancel();
        else
        {
            grdData.row = -1;
            return;
        }
    }
    else
    {
       txtRemark.SetEnable(true);
       idBtnModify.SetEnable(true);
       idBtnDelete.SetEnable(true);
       idBtnCancel.SetEnable(true);
    }
    
    txtRemark.SetDataText(grdData.GetGridData(grdData.row, col_remark));
    txtRemarkGA.SetDataText(grdData.GetGridData(grdData.row, col_remark_ga));
}

function OnDelete()
{
    grdData.DeleteRow();
}

function OnUnDelete()
{
    grdData.UnDeleteRow();
}


function OnCancel()
{
    if (grdData.row == -1)
    {
        alert('You must select one row.');
        return;
    }
    
    if (grdData.GetGridData(grdData.row, col_status) == 60)
    {
        var fpath = System.RootURL + "/form/ch/jb/chjb00040_1.aspx?p_cancel=" + grdData.GetGridData(grdData.row, col_cancel);
        var obj = System.OpenModal( fpath , 700 , 220 , 'resizable:yes;status:yes');
        
        if ( obj != null)
        {
            var con = grdData.GetGridControl();
        
            for( var i = 0; i < grdData.rows; i++ )
            {
                if (con.IsSelected(i)) 
                {
                    grdData.SetGridText(grdData.row, col_status, 90);
                    grdData.SetGridText(grdData.row, col_cancel, obj);
                    grdData.SetRowStatus(i, 16);
                    idData_sp_sel_chjb00040.Call();
                }
            }
        }
    }
}

//function OnSet(n)
//{
//    var con = grdData.GetGridControl();
//    
//    if (grdData.GetGridData(grdData.row, col_status) != 10)
//    {
//        switch(n)
//        {
//            case 8: // Cancel
//                con.TextMatrix(i , col_status) = cancel;
//                
//                var fpath = System.RootURL + "/form/ch/jb/chjb00040_1.aspx?p_cancel=" + grdData.GetGridData(grdData.row, col_cancel);
//                var obj = System.OpenModal( fpath , 700 , 220 , 'resizable:yes;status:yes');
//                
//                if ( obj != null)
//                {
//                    var con = grdData.GetGridControl();                
//                    grdData.SetGridText(grdData.row, col_cancel, obj);
//                    grdData.SetRowStatus(grdData.row, 16);
//                    idData_sp_sel_chjb00040.Call();
//                }
//                break;
//        }
//    }
//}

</script>

<body>
<gw:data id="idData_sp_sel_chjb00040" onreceive="ReceiveData()">
    <xml>
        <dso id="1" type="grid" parameter="0,4,5,6,7,8,9,10,11,12,14,15,17,18" function="hr.sp_sel_chjb00040" procedure="hr.sp_upd_chjb00040">
            <input bind="grdData" >
                <input bind="txtEmpPK" />
                <input bind="txtEmpID" />
                <input bind="dtDateF" />
                <input bind="dtDateT" />
                <input bind="lstStatus" />
                <input bind="rbType" />
            </input>
            <output bind="grdData" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF">
    <tr height="5%">
        <td style="background: white">
            <table width="100%" border="0">
                <tr>
                    <td width="5%">Date</td>
                    <td width="6%"><gw:datebox id="dtDateF" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="OnSearch()"/></td>
                    <td width="1%">~</td>
                    <td width="6%"><gw:datebox id="dtDateT" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="OnSearch()"/></td>
                    <td width="6%">&nbsp;Name</td>
                    <td width="25%"><gw:textbox id="txtName"  styles="width:100%;" /></td>
                    <td width="5%">Status</td>
                    <td width="17%"><gw:list id="lstStatus" value="ALL" maxlen = "100" styles='width:100%' onchange="OnSearch()" ></gw:list></td>
                    <td width="15%"></td>
                    <td width="3%"><gw:imgBtn img="search"   alt="Search"   onclick ="OnSearch()"/></td>
                    <td width="3%"><gw:icon id="idBtnNew"     img="in" text="New"    onclick="OnNew()" /></td>
                    <td width="3%"><gw:icon id="idBtnModify"  img="in" text="Modify" onclick="OnModify()" /></td>
                    <td width="3%"><gw:icon id="idBtnDelete"  img="in" text="Delete" onclick="OnDelete()" /></td>
                    <td width="3%"><gw:icon id="idBtnCancel"  img="in" text="Cancel" onclick="OnCancel()" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td width="100%" style="background: white">
            <table width="100%" border="0">
                <tr width="100%" >
                    <td style="width: 75%" align="right" nowrap >
                        <gw:radio id="rbType" value="1" onchange="OnSearch()">
                            <span value="1">My application</span>
                            <span value="2">All application I made</span>
                        </gw:radio> 
                    </td>
                    <td width="25%" align="right"><b style="color: Blue; cursor: hand" ><gw:label id="lbRecord">record(s)</gw:label></b></td>            
                </tr>
            </table>
        </td>
    </tr>
    <tr height="95%">
        <td width="100%">
            <gw:grid   
            id="grdData"
            header="_PK|_Select|Emp ID|Emp Name|Order No|Submited Date|Item|Size|Amount|Req Qty|Receiving Location|Laundry Location|Status|_Status|Provided Date|Remark|Remark(GA)|Cancel|_Emp_PK"
            format="0|3|0|0|0|4|0|2|2|2|0|0|0|0|4|0|0|0|0"
            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
            defaults="||||||||||||||||||"
            editcol="0|0|0|0|0|1|0|0|0|0|0|1|1|0|0|0|1|0|0|0"
            widths="0|0|1500|2500|1500|1500|1500|1000|1000|1500|2500|2000|1500|1500|1500|1500|1500|0|0"
            styles="width:100%; height:100%"
            sorting="T" acceptNullDate="true" oncellclick="OnClick()" oncelldblclick="OnDBClick()"   
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
<gw:textbox id="txtEmpID"     styles="width:100%;display:none" />
</body>