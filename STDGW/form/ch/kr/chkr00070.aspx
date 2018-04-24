<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Training List</title>
</head>
<script>

var flag_YN    = 'N';
var emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var emp_name   = "<%=Session("USER_NAME")%>";
var emp_id     = "<%=Session("User_ID")%>";
var v_language = "<%=Session("SESSION_LANG")%>";

var col_train_cost = 6;
var col_status     = 7;
var col_cancel     = 9;

function BodyInit()
{   
    if (v_language!="ENG")
        System.Translate(document); 
    
    var con = grdMst.GetGridControl();
    con.ColFormat(col_train_cost) = "###,###"; 
    
    txtName.SetEnable(false);
    txtName.SetDataText(emp_name);
    txtEmpPK.SetDataText(emp_pk);
    txtEmpID.SetDataText(emp_id);
    
    var data  = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' order by code")%>|ALL|Select All";
    lstStatus.SetDataText(data);
    lstStatus.value = 'ALL';
    
    GetLastMonth();
    
    OnSearch();
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
    idData_sp_sel_chkr00070.Call('SELECT');
}

function OnGridCellClick(n)
{
    var p_pk = grdMst.GetGridData(grdMst.row, 0);
    txtCoursePK.text = p_pk;
    txtReason.SetDataText(grdMst.GetGridData(grdMst.row, 9));
    switch(n)
    {
        case 1:
            idData_sp_sel_chkr00071.Call('SELECT');
            break;
    }
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'idData_sp_sel_chkr00070':
            if (grdMst.rows-1 > 0)
            {
                txtCoursePK.text = grdMst.GetGridData(1, 0);                
                idData_sp_sel_chkr00071.Call('SELECT');
            }
            break;
    
        case 'idData_sp_sel_chkr00071':
            lbRecord.text = grdDetail.rows-1 + " record(s)";
            
            if(grdMst.row == -1)
                grdMst.row = 1;
            
            
            if (grdMst.GetGridData(grdMst.row, col_status) == 10) // Save
            { 
                txtReason.SetEnable(true);
                idBtnModify.SetEnable(true);
                idBtnDelete.SetEnable(true);
                idBtnCancel.SetEnable(true);
            }
            else if (grdMst.GetGridData(grdMst.row, col_status) == 20) // Submited
            {
                txtReason.SetEnable(true);
                idBtnModify.SetEnable(true);
                idBtnDelete.SetEnable(true);
                idBtnCancel.SetEnable(true);
            }
            else
            {
                txtReason.SetEnable(false);
                idBtnModify.SetEnable(false);
                idBtnDelete.SetEnable(false);
                idBtnCancel.SetEnable(false);
            }

            break;
    }
}

function OnNew()
{
    System.Menu.NewWindow( "form/ch/kr/chkr00060.aspx" , "Training Request Entry", "Training Request Entry", "Training Request Entry" );
}

function OnModify()
{
    System.Menu.NewWindow( "form/ch/kr/chkr00060.aspx?master_pk=" + grdMst.GetGridData(grdMst.row,0) , "Training Request Entry", "Training Request Entry", "Training Request Entry" );
}



function OnSave()
{

    
}

function OnDelete()
{
	
}

function OnUnDelete()
{

}

function OnCancel()
{
    if (grdMst.row == -1)
    {
        alert('You must select one row.');
        return;
    }
    
    if (txtReason.GetData() == '')
    {    
        alert('You must input Reason.');
        return;
    }
            
    grdMst.SetGridText(grdMst.row, col_status, 90);
    grdMst.SetGridText(grdMst.row, col_cancel, txtReason.GetData());
    idData_sp_sel_chkr00070.Call();
}

</script>

<body>

<gw:data id="idData_sp_sel_chkr00070" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" user="hr" parameter="0,7,9" function="HR_CHKR10200008_sel_Train_List" procedure="HR_CHKR10200008_upd_Train_List"> 
            <input> 
                <input bind="dtDateF" />
                <input bind="dtDateT" />
                <input bind="txtEmpPK" />
                <input bind="lstStatus" />
            </input> 
            <output bind="grdMst" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="idData_sp_sel_chkr00071" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" user="hr" parameter="" function="HR_CHKR10200008_Train_List_1" procedure=""> 
            <input> 
                <input bind="txtCoursePK" />
                <input bind="rbType" />
                <input bind="txtEmpID" />
                <input bind="txtEmpPK" />
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="1" style="background: #BDE9FF">
    <tr height="10%">
        <td style="background: white" colspan="2">
            <table width="100%" border="0">
                <tr>
                    <td width="5%">Date</td>
                    <td width="6%"><gw:datebox id="dtDateF" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="OnSearch()"/></td>
                    <td width="1%">~</td>
                    <td width="6%"><gw:datebox id="dtDateT" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="OnSearch()"/></td>
                    <td width="6%">&nbsp;Name</td>
                    <td width="25%">
                        <gw:textbox id="txtName"  styles="width:100%;" />
                        <gw:textbox id="txtEmpPK"  styles="width:100%;display:none" />
                        <gw:textbox id="txtEmpID"  styles="width:100%;display:none" />
                        <gw:textbox id="txtCoursePK"  styles="width:100%;display:none" />
                    </td>
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
    <tr height="5%">
        <td width="100%" style="background: white" colspan="2">
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
    <tr height="85%">
        <td width="45%" style="background: white" >
            <gw:grid id='grdMst'
            header='_PK|App No|Emp ID|Approver|Course Name|Submit Dated|Train Cost|_Status|Status|_Cancel'
            format='0|0|0|0|0|0|2|0|0|0'
            aligns='0|0|0|0|0|0|0|0|0|0'
            defaults='|||||||||'
            editcol='1|1|1|1|1|1|1|1|1|1'
            widths='1000|1200|1000|2500|2000|1400|0|0|0|0'
            sorting='T'
            styles='width:100%; height:80%'
            oncellclick='OnGridCellClick(1)'
            />
           <a><gw:label id="lblReason" styles="width:100%;font-size:16px" text="Reason" /></a>
           <gw:textarea id="txtReason" rows="4" styles="width:100%" />
        </td>
        <td width="55%" style="background: white">
            <gw:grid id='grdDetail'
            header='_PK|Seq No|Emp ID|Emp Name|Train Cost|Close|Remark'
            format='0|0|0|0|2|3|0'
            aligns='0|0|0|0|0|0|0'
            defaults='||||||'
            editcol='1|1|1|1|1|1|1'
            widths='0|1000|1200|2500|1000|1000|1000'
            sorting='T'
            styles='width:100%; height:80%'
            />            
        </td>
    </tr>    
</table>

</body>