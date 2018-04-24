<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var check_init =1;
var lstCostGroup_data ;
var lstCostCenter_data ;
var lstCostKind_data ;
var l_cost_version=1;

var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
var p_PK =0;
var p_Organization=1;
var p_WorkGroup= 2;
var p_EmpID=3;
    p_full_nm = 4;
    p_join_date = 5;
    p_emp_type = 6;
    p_position = 7;
    p_cost_group = 8;
    p_cost_kind = 9;
    p_cost_center = 10;
    p_old_org = 11;
    p_pay_type = 12;
    p_bank_type = 13;
    p_bank_branch = 14;
    p_account = 15;
    p_pit_no = 16;
    p_cost_pk = 17;
    p_cost_group_1 = 1;
    p_cost_kind_1 = 3;
    p_cost_center_1 = 2;

    var ls_data;

function BodyInit()
{
    txtCompany_pk.text="<%=Session("COMPANY_PK")%>";

    grdEmployee.GetGridControl().FrozenCols =5;
    grdEmployee.GetGridControl().ScrollTrack = true;
    //grdEmployee_1.GetGridControl().FrozenCols = 5;
    grdEmployee_1.GetGridControl().ScrollTrack = true;

    if (v_language!="ENG")
        System.Translate(document);
    ibtnSave.SetEnable(false);
    ibtnSave_1.SetEnable(false);
    lstCostGroup_data = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from vhr_hr_code where id='HR0092' order by code")%>";
    
    lstCostSet.SetDataText(lstCostGroup_data);
    lstCostSet_1.SetDataText(lstCostGroup_data);

    l_cost_version="<%=ESysLib.SetDataSQL("select nvl(char_2,'1') from vhr_hr_code where id='HR0211' and code='01'")%>";

    if(l_cost_version=='1')
        ls_data = "<%=ESysLib.SetListDataSQL("select 0 PK,'' pl_nm from dual union all SELECT d.pk as pk,D.PL_CD || ':' || D.PL_NM as pl_nm FROM TAC_ABPL D WHERE D.DEL_IF = 0 AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by PL_NM")%>"+"|ALL|Select All";
    else
        ls_data ="<%=ESysLib.SetListDataSQL("select 0 PK,'' pl_nm from dual union all SELECT e.pk as pk,D.PL_CD || ':' || D.PL_NM as pl_nm FROM TAC_ABPL D, TAC_ABPLCENTER E WHERE D.DEL_IF = 0 AND E.DEL_IF = 0 AND E.TAC_ABPL_PK = D.PK AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by PL_NM")%>"+"|ALL|Select All";

            
    lstCost_Center.SetDataText(ls_data);
    lstCost_Center.value="ALL";

    lstCost_Center_1.SetDataText(ls_data);
    lstCost_Center_1.value="ALL";
    
    CreateGrid();
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    idDBUSR.text = "<%=session("APP_DBUSER")%>";
    user="<%=session("USER_ID")%>";
    menu_id.text=System.Menu.GetMenuID();
    BindingDataList();
    ChangeColorItem(lstOrg_Code.GetControl());
    ChangeColorItem(lstOrg_Code_1.GetControl());
    datGet_month.Call();
    

}
//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//---------------------------------------------------------------------------
function OnShowPopup(str)
 {
    if (str == "1") {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj = window.showModalDialog(fpath, this, 'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:' + window.event.screenX + ';dialogTop:' + window.event.screenY + ';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj != null) {
            lstOrg_Code.value = obj;

        }
    }
    else if (str == "4") {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_cost_center.aspx?id=" + txtCost_Center_pk.text + "&company_pk=" + "<%=Session("COMPANY_PK")%>";
        var obj = System.OpenModal(fpath, 900, 600, 'resizable:yes;status:yes');
        // var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
/*        if (obj != null) {
            //alert(obj[0]);
            txtCost_Center_pk.text = obj[0]
            objlist.text = obj[1];

        }   */
    }
    else 
    {
        //var strcom;
        //obj_list_code = objlist;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" + str;
       // var strid = strtemp;

        var obj = System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
    }
}
function BindingDataList()
{   
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_emp_type,t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_position,t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_pay_type,t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_bank_type,t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_cost_group,t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_cost_kind, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0116' order by code_nm")%>";
    grdEmployee.SetComboFormat(p_bank_branch,t1); 
    
    if(l_cost_version=='1')
        t1 = "<%=ESysLib.SetGridColumnDataSQL("SELECT d.pk as pk,D.PL_NM as pl_nm FROM TAC_ABPL D WHERE D.DEL_IF = 0 AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by D.PL_NM")%>";
    else     
        t1 = "<%=ESysLib.SetGridColumnDataSQL("SELECT e.pk as pk,D.PL_NM as pl_nm FROM TAC_ABPL D, TAC_ABPLCENTER E WHERE D.DEL_IF = 0 AND E.DEL_IF = 0 AND E.TAC_ABPL_PK = D.PK AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by D.PL_NM")%>";
    grdEmployee.SetComboFormat(p_cost_center, t1);
    grdEmployee_1.SetComboFormat(p_cost_center_1, t1);

    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>";
    grdEmployee_1.SetComboFormat(p_cost_group_1, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>";
    grdEmployee_1.SetComboFormat(p_cost_kind_1, t1);
    
    

}

//----------------------------------------------
function OnDataReceive(obj) {

    if (obj.id == "datDeptData") {
        if (txtHr_level.text == "6")
            txtDeptData.text = txtDeptData.text + "|ALL|Select All";
        lstOrg_Code.SetDataText(txtDeptData.text);
        lstOrg_Code_1.SetDataText(txtDeptData.text);

        obj = lstOrg_Code.GetControl()
        if (obj.options.length == 2)
            obj.options.selectedIndex = 0;
        else
            obj.options.selectedIndex = 0;

    }

    else if (obj.id == "datEmp_Cost_Management") {
        if (grdEmployee.rows > 1) {
            ibtnSave.SetEnable(true);

            SetColRow();
        }
        else {
            ibtnSave.SetEnable(false);

        }
        lblRecord.text = grdEmployee.rows - 1 + " record(s).";
        auto_resize_column(grdEmployee, 0, grdEmployee.cols - 1, 9);
    }
    else if (obj.id == "datEmp_Cost_Management_sum") {
        if (grdEmployee_1.rows > 1) {
            ibtnSave_1.SetEnable(true);

        }
        else {
            ibtnSave_1.SetEnable(false);

        }
        lblRecord_1.text = grdEmployee_1.rows - 1 + " record(s).";
        auto_resize_column(grdEmployee_1, 0, grdEmployee_1.cols - 1, 9);
    }
    else if (obj.id == "datGet_Org") {

        grdEmployee.SetGridText(rowclick, p_Organization, txtOrgNM.text);
    }
    else if (obj.id == "datGet_month") {
        if (txtResult.text == "Y") {
            lblRecord_sal.text = "Month Closed"
        }
        else {
            if (txtProcess.text == "N")
                lblRecord_sal.text = "Not create"
            else
                lblRecord_sal.text = "Month Open"

        }
    }
    else if (obj.id == "datApp_Sal") {
        if (txtResult.text == "Y") {
            alert("Apply to salary successful!")
        }
    }
    else if (obj.id == "datFind_Report") {
        var url = System.RootURL;
        url = url + '/reports/ch/ae/' + txtReport_tmp.text;
        window.open(url);
    }
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
    obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------
function SetColRow()
{
    grdEmployee.SetCellBgColor(1,p_cost_group,grdEmployee.rows -1 ,p_cost_center,0xFFEEFF);
 
    var ctrl = grdEmployee.GetGridControl();
    var org_nm;
    var old_org_nm;
    for(var i = 1;i < grdEmployee.rows;i++) 
    {
        org_nm = grdEmployee.GetGridData(i,p_Organization);
        old_org_nm = grdEmployee.GetGridData(i,p_old_org);
        //alert(org_nm);
        //alert(old_org_nm);
        if (org_nm != old_org_nm)
        {
            grdEmployee.SetCellBgColor(i,p_Organization,i ,p_Organization,0x300FF3);
            grdEmployee.SetCellBgColor(i,p_old_org,i ,p_old_org,0x300FF3);
        }
    }
}
//------------------------------------------------
function OnChangeOrg()
{
    
}
//----------------------------------------------------
function OnSearch(obj)
{
    if (check_init == 1)
    {
        if (obj == 1)
            datEmp_Cost_Management.Call("SELECT");
        else
            datEmp_Cost_Management_sum.Call("SELECT");
    }
}

//-----------------------------------------------
function OnReport()
{
    if(check_init==1)
    {
        var url=System.RootURL;
        
        txtReport_tmp.text = "rpt_import_cost_manage_template.aspx";
        
        datFind_Report.Call();
    }
    
}
//-----------------------------------------------
function OnSave(obj)
{
    if(check_init ==1)
    {
        if (obj == "1") {
            if (confirm("Do you want to save?"))
                datEmp_Cost_Management.Call();
        }
        else
        {
            if (confirm("Do you want to save?"))
                datEmp_Cost_Management_sum.Call();
        }
    }
}

//-----------------------------------------------

function OnSetGrid(obj)
{
    var ctrl; 
    var tmp;
    var col = 0;
    var n;
    //alert(obj.text);
    if (obj == "1") {
        ctrl = grdEmployee.GetGridControl();
        n = lstSet.value;

        if (ctrl.SelectedRows > 0) {

            switch (n) {
                case "1":
                    col = p_cost_group;
                    tmp = lstCostSet.value;
                    break;
                case "2":
                    col = p_cost_kind;
                    tmp = lstCostSet.value;
                    break;
                case "3":
                    col = p_cost_center;
                    tmp = lstCostSet.value;
                    break;
            }
        }
    }
    else
    {
        ctrl = grdEmployee_1.GetGridControl();
        n = lstSet_1.value;

        if (ctrl.SelectedRows > 0) {

            switch (n) {
                case "1":
                    col = p_cost_group_1;
                    tmp = lstCostSet_1.value;
                    break;
                case "2":
                    col = p_cost_kind_1;
                    tmp = lstCostSet_1.value;
                    break;
                case "3":
                    col = p_cost_center_1;
                    tmp = lstCostSet_1.value;
                    break;
            }
        }
    }
    //alert(col + " / " + tmp);
    
    for (var i = 0 ; i < ctrl.SelectedRows ; i++) {
        var row = ctrl.SelectedRow(i);
        if (row > 0 && col != 0) {
            if (obj == "1")
                grdEmployee.SetGridText(row, col, tmp);
            else
                grdEmployee_1.SetGridText(row, col, tmp);
        }
    }
    
 }
//-----------------------------------------------
function OnChangeMonth()
{
    if(check_init ==1)
    {
        datGet_month.Call();
    }
}

//-----------------------------------------------
function onApplySalary()
{
    if(check_init ==1)
    {
        if(confirm("Do you want apply to Salary Month "+ dtMonth_Sal.text +"?\nBạn muốn áp dụng vào lương tháng "+ dtMonth_Sal.text +"?"))
            datApp_Sal.Call();
    }
}
//-----------------------------------------------
function OnChangeSet(lst,obj)
{
    var n = lst.value;
    var tmp;
    if(check_init ==1)
    {
        switch (n)
        {
            case "1":
                tmp = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from vhr_hr_code where id='HR0092' order by code")%>";
                break;
            case "2":
                tmp = "<%=ESysLib.SetListDataSQL("SELECT code,code_nm from vhr_hr_code where id='HR0093' order by code")%>";
                break;
            case "3":
                if(l_cost_version=='1')
                    tmp = "<%=ESysLib.SetListDataSQL("select 0 PK,'' pl_nm from dual union all SELECT d.pk as pk,D.PL_CD || ':' || D.PL_NM as pl_nm FROM TAC_ABPL D WHERE D.DEL_IF = 0 AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by PL_NM")%>"+"|ALL|Select All";
                else
                    tmp ="<%=ESysLib.SetListDataSQL("select 0 PK,'' pl_nm from dual union all SELECT e.pk as pk,D.PL_CD || ':' || D.PL_NM as pl_nm FROM TAC_ABPL D, TAC_ABPLCENTER E WHERE D.DEL_IF = 0 AND E.DEL_IF = 0 AND E.TAC_ABPL_PK = D.PK AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by PL_NM")%>"+"|ALL|Select All";
            break;
        }
        obj.SetDataText(tmp);
    }
}

function OnImportNew() {
    var currentTime = new Date();
    txtSequence.text = currentTime.getTime();

    var url = System.RootURL + '/system/binary/ReadExcel.aspx?import_seq=' + txtSequence.text + '&p_err_cont=Y' + '&table_name=TES_FILEOBJECT' + '&procedure=GASP.SP_INSERT_IMAGE' + '&procedure_file=' + idDBUSR.text + '.HR_UPD_10010078_IMPORT' + '&p_1=' + '&p_2=' + '&p_3=' + '&p_4=' + '&p_5=';
    alert(url);
    txtRecord.text = System.OpenModal(url, 415, 100, "unadorned:on ; center:yes; edge:sunken ; resizable:yes;status:yes;");

    if (txtRecord.text == 'undefined')
    {
        alert("Had error when import, try again please!");
    }
    else
    {
        alert("Imported : " + txtRecord.text + " record(s)");

        datEmp_Cost_Management_sum.Call("SELECT");
    }

    


}

function CreateGrid() {
    var sHeader, sFormat, sAlign;
    sHeader = "";
    sHeader = "<%=ESysLib.SetListDataSQL("select '',v.DESCRIPTION from THR_SALARY_VIEW_COLS v, vhr_hr_code a where v.DEL_IF =0 and A.CODE = V.SALARY_VIEW_COLUMN and A.ID = 'HR0094' order by nvl(v.seq,0)")%>";
    sHeader = sHeader.replace(/\x7C\x7C/g, "|");
    sHeader = sHeader.replace("DATA", "Num|Cost Group|Cost Center|Group Kind|_Emp_PK|_Work_mon|Organization|Work Group|Emp ID|Full Name|Join Date");

    sFormat = "<%=ESysLib.SetListDataSQL("select '',nvl(v.format,'0') from THR_SALARY_VIEW_COLS v, vhr_hr_code a where v.DEL_IF =0 and A.CODE = V.SALARY_VIEW_COLUMN and A.ID = 'HR0094' order by nvl(v.seq,0)")%>";
    sFormat = sFormat.replace(/\x7C\x7C/g, "|");
    sFormat = sFormat.replace("DATA", "0|0|0|0|0|0|0|0|0|0|0");

    sAlign = "<%=ESysLib.SetListDataSQL("select '',nvl(v.align,'0') from THR_SALARY_VIEW_COLS v, vhr_hr_code a where v.DEL_IF =0 and A.CODE = V.SALARY_VIEW_COLUMN and A.ID = 'HR0094' order by nvl(v.seq,0)")%>";
    sAlign = sAlign.replace(/\x7C\x7C/g, "|");
    sAlign = sAlign.replace("DATA", "0|0|0|0|0|0|0|0|0|0|0");

    grdEmployee_1.setHeader(sHeader);
    grdEmployee_1.setFormat(sFormat);
    grdEmployee_1.setAlign(sAlign);
    grdEmployee_1.SetCellBold(0, 0, 0, grdEmployee_1.cols - 1, true);
    auto_resize_column(grdEmployee_1, 0, grdEmployee_1.cols - 1, 9);
}

function GroupGrid(objid) {
    var obj_grd;
    var i_col_num;
    var icaption;
    i_col_num = 0;
    obj_grd = grdEmployee_1.GetGridControl();
    for (var i = 0; i < obj_grd.cols & i_col_num == 0 ; i++) {
        if (obj_grd.ColDataType(i) != 8)
            i_col_num = i;

    }
/*
    for (var i = 1; i < obj_grd.rows; i++)
    {
        icaption = grdEmployee_1.GetGridData(i, p_cost_group_1);
        grdEmployee_1.SetGridText(i, p_cost_group_1, icaption);
    }   
    alert(icaption);    */
    if (objid == 1) {
        obj_grd.OutlineBar = 2;
        for (var j = i_col_num; j < obj_grd.cols; j++)
        {
            //icaption = grdEmployee_1.GetGridData()
            obj_grd.SubTotal(2, p_cost_group_1, j, '', 0x99FFFF, 0x000000, '1', 'Total %s', '', true);
            //obj_grd.SubTotal(2,1, j,'',0xccffff,0x000000,'1','Total','',true);
            obj_grd.SubTotal(2, p_cost_center_1, j, '', 0xccffff, 0x000000, '1', 'Total %s', '', true);
            for (var i = 1; i < obj_grd.rows; i++) {
                if (obj_grd.IsCollapsed(i) == 0)
                    obj_grd.IsCollapsed(i) = 1;
            }
        }

    }
    else {
        //grdDetail.GetGridControl().OutlineBar =2 ;
        for (var i = 1; i < obj_grd.rows; i++) {
            if (obj_grd.IsCollapsed(i) == 2)
                obj_grd.IsCollapsed(i) = 0;
        }
        //obj_grd.SubTotal(1);
        //grdDetail.GetGridControl().SubTotal(1,0, i,'',0x99FFFF,0x000000,'1','Total %s','',true);

    }
    auto_resize_column(grdEmployee_1, 0, grdEmployee_1.cols - 1, 9);
}

</script>
<body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0" >
<!------------------------------------------>

<gw:data id="datGet_Org" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_ORG" > 
                <input>
                    <input bind="txtOrgPK" />
                </input> 
                <output>
                    <output bind="txtOrgNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->

<gw:data id="datEmp_Cost_Management" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,8,9,10" function="HR_SEL_10010078_EMP_COST_MAN" procedure="HR_UPD_10010078_EMP_COST_MAN"> 
                <input bind="grdEmployee" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstNation" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstPay_Type" />
                    <input bind="lstStatus" />
                    <input bind="dtFrom_LeftDate" />
                    <input bind="dtTo_LeftDate" />
                    <input bind="lstEmpType"/>
                    <input bind="lstCost_Group"/>
                    <input bind="lstCost_Kind"/>
                    <input bind="lstCost_Center"/>
                    <input bind="Month"/>
                </input>
                <output  bind="grdEmployee" />
                
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" />
                    <input bind="txtCompany_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>


<gw:data id="datGet_month" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process"  procedure="HR_PRO_10010078_GET_MONTH" > 
                <input>
                    <input bind="dtMonth_Sal" />
                    <input bind="lstOrg_Code" />
                </input> 
                <output>
                    <output bind="txtResult" />
                    <output bind="txtProcess" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datApp_Sal" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010078_APPLY_SALARY" > 
                <input>
                    <input bind="dtMonth_Sal" />
                    <input bind="lstOrg_Code" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp_Cost_Management_sum" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4" function="HR_SEL_10010078_SUM" procedure="HR_UPD_10010078_SUM" > 
                <input bind="grdEmployee_1" >
                    <input bind="lstOrg_Code_1" />
                    <input bind="lstGrp_Code_1" />
                    <input bind="lstNation_1" />
                    <input bind="lstTemp_1" />
                    <input bind="txtTemp_1" />
                    <input bind="dtFrom_JoinDate_1" />
                    <input bind="dtTo_JoinDate_1" />
                    <input bind="lstPay_Type_1" />
                    <input bind="lstStatus_1" />
                    <input bind="dtFrom_LeftDate_1" />
                    <input bind="dtTo_LeftDate_1" />
                    <input bind="lstEmpType_1"/>
                    <input bind="lstCost_Group_1"/>
                    <input bind="lstCost_Kind_1"/>
                    <input bind="lstCost_Center_1"/>
                    <input bind="dtMonth_Sal_1"/>
                </input>
                <output  bind="grdEmployee_1" />
                
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  >   
    <table name="Management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" style="border:0;" align="right" >
                          <a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>||Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=6 width="12%" style="border:0;" align="right" >Work Group</td>
                        <td colspan=11 width="20%" colspan=2 style="border:0;" align="left" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%= ESysLib.SetListDataSQL("select a.WORKGROUP_ID,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_ID")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=3 width="8%" style="border:0;" align="right">Search by</td>
				        <td colspan=5 width="10%" style="border:0;">
                            <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list></td>
				        <td colspan=6 width="12%" align=right style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
				        </td>
                         
                        <td  width="2%" style="border:0" align="center"></td>
                        <td width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/>
                        </td>
                        <td width="3%" style="border:0" align="center">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(1)"/>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5 style="border:0" align="right" valign="middle">Employee Type</td>
					    <td colspan=6 style="border:0" >
					        <gw:list  id="lstEmpType" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%= ESysLib.SetListDataSQL("select CODE, CODE_NM  from vhr_hr_code  where id='HR0017' order by code_nm")%>|ALL|Select All</data>
                            </gw:list>
				        </td>
				        <td colspan=4 style="border:0;" align="right" >Pay type</td>
                        <td colspan=6 style="border:0" align="right">
                         <gw:list  id="lstPay_Type" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        
                        <td colspan=4 style="border:0;" align="right" >Status</td>
                        <td colspan=7 style="border:0;" align="left" >
                            <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                                </data>
                            </gw:list> 
                        </td>
                        <td colspan=3 style="border:0;" align="right">Join Date</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td width="2%" style="border:0;" align="center">~</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0;" align="right" >Nation</td>
                        <td colspan=4 style="border:0" align="right">
                            <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                                <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                         </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5 style="border:0;" align="right" ><a title="Click here to show Cost Group" onclick="OnShowPopup('HR0092')" href="#tips" >Cost Group</a></td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list  id="lstCost_Group" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL(" select '','' from dual union all SELECT code,code_nm from vhr_hr_code where id='HR0092' ")%>|ALL|Select All
                                </data>
                            </gw:list> 
                        </td>
                        <td colspan=4 style="border:0;" align="right" ><a title="Click here to show Cost Kind" onclick="OnShowPopup('HR0093')" href="#tips" >Cost Kind</a></td>
                        <td colspan=6 align=right style="border:0"> 
					        <gw:list  id="lstCost_Kind" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("SELECT code,code_nm from vhr_hr_code where id='HR0093' order by code")%>|ALL|Select All
                                </data>
                            </gw:list>
				        </td>
                        <td colspan=4 style="border:0;" align="right" ><a title="Click here to show Cost Center" onclick="OnShowPopup(4)" href="#tips" >Cost Center</a></td>
                        <td colspan=7 style="border:0;" align="left" >
                            <gw:list  id="lstCost_Center" value='ALL' maxlen = "100" styles='width:100%'></gw:list> 
                        </td>
                       
                        <td colspan=3 style="border:0" align="right" valign="middle">Left Date</td>
                        <td colspan=4 style="border:0;"><gw:datebox id="dtFrom_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="2%" style="border:0;" align="center">~</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtTo_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=6 style="border:0;" align="center" ><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                    </tr>
                    <tr style="border:0;width:100%;height:7%" valign="middle" >
                        <td colspan=5 style="border:0;" align="center" ><gw:label id="lblSetData"  text="Set Data" maxlen = "100" styles="color:#FF3399;width:90%;font-weight: bold;font-size:13" /></td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list id="lstSet" value = "1" styles='width:100%' onchange="OnChangeSet(lstSet,lstCostSet)">
                                <data>LIST|1|Cost Group|2|Cost Kind|3|Cost Center</data> 
                            </gw:list>
                        </td>
                        <td colspan=10 style="border:0;" align="right" styles='width:100%'>
                            <gw:list id="lstCostSet" onchange="" value = "ALL" styles='width:95%'></gw:list>
                        </td>   
                        <td colspan=4 style="border:0;" align="left" ><gw:imgBtn img="set" id="ibtnSet2"   alt="Set Grid"  onclick="OnSetGrid(1)"/></td>
                        <td colspan=7 style="border:0;" align="right">Appoint Month</td>
                        <td colspan=3 style="border:0;" align="right"><gw:datebox id="Month" text="" styles='width:90%'lang="<%=Session("Lang")%>" type=month /></td>
                        <td colspan=5 style="border:0;" align="right" ><gw:icon id="iProcess" img="in" text="Apply Salary" onclick="onApplySalary()" /></td>
                        <td colspan=4 style="border:0;" align="center"><gw:datebox id="dtMonth_Sal"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month onchange="OnChangeMonth()" /></td>
                        <td colspan=6 style="border:0;" align="center"><gw:label id="lblRecord_sal"  text="" maxlen = "100" styles="color:blue;width:90%;font-weight: bold;font-size:13" /></td>
                    </tr>
                     <tr style="border:1;width:100%;height:75%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="_PK|Organization|Work Group|Emp ID|Full Name|Join Date|Employee Type|Position|Cost Group|Group Kind|Cost Center|Other Organization|Pay Type|Bank Type|Bank Branch|Account|Pit No|_cost_pk"   
                                format="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="||||||||||||||||||"    
                               editcol="0|0|0|1|1|0|1|1|1|1|1|1|1|1|1|1|0|0"  
                                widths="1500|1500|1500|1500|1500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                styles="width:100%; height:100%"   acceptNullDate
                                onafteredit=""
                                onentercell = ""
                                oncelldblclick = ""
                                sorting="T"/> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="Check & Import" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" style="border:0;" align="right" >
                          <a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code_1" value='' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>||Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan=6 width="14%" style="border:0;" align="right" >Work Group</td>
                        <td colspan=10 width="18%" colspan=2 style="border:0;" align="left" ><gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%= ESysLib.SetListDataSQL("select a.WORKGROUP_ID,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td colspan=4 width="8%" style="border:0;" align="right">Search by</td>
				        <td colspan=5 width="10%" style="border:0;">
                            <gw:list  id="lstTemp_1" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list></td>
				        <td colspan=6 width="12%" align=right style="border:0"> 
					        <gw:textbox id="txtTemp_1" onenterkey   ="OnSearch()" styles="width:95%"/>
				        </td>
                         
                        <td  width="2%" style="border:0" align="center"></td>
                        <td width="3%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_1"   alt="Search"  onclick="OnSearch(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="center">
                         <gw:imgBtn img="save" id="ibtnSave_1"    alt="Save"  onclick="OnSave(2)"/>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5 style="border:0" align="right" valign="middle">Employee Type</td>
					    <td colspan=6 style="border:0" >
					        <gw:list  id="lstEmpType_1" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%= ESysLib.SetListDataSQL("select CODE, CODE_NM  from vhr_hr_code  where id='HR0017' order by CODE_NM")%>|ALL|Select All</data>
                            </gw:list>
				        </td>
				        <td colspan=4 style="border:0;" align="right" >Pay type</td>
                        <td colspan=6 style="border:0" align="right">
                         <gw:list  id="lstPay_Type_1" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        
                        <td colspan=4 style="border:0;" align="right" >Status</td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list  id="lstStatus_1" value='A' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                                </data>
                            </gw:list> 
                        </td>
                        <td colspan=4 style="border:0;" align="right">Join Date</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtFrom_JoinDate_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td width="2%" style="border:0;" align="center">~</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtTo_JoinDate_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0;" align="right" >Nation</td>
                        <td colspan=4 style="border:0" align="right">
                            <gw:list  id="lstNation_1" value='01' maxlen = "100" styles='width:100%' >
                                <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                         </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=5 style="border:0;" align="right" ><a title="Click here to show Cost Group" onclick="OnShowPopup('HR0092')" href="#tips" >Cost Group</a></td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list  id="lstCost_Group_1" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL(" select '','' from dual union all SELECT code,code_nm from vhr_hr_code where id='HR0092' ")%>|ALL|Select All
                                </data>
                            </gw:list> 
                        </td>
                        <td colspan=4 style="border:0;" align="right" ><a title="Click here to show Cost Kind" onclick="OnShowPopup('HR0093')" href="#tips" >Cost Kind</a></td>
                        <td colspan=6 align=right style="border:0"> 
					        <gw:list  id="lstCost_Kind_1" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("SELECT code,code_nm from vhr_hr_code where id='HR0093' order by code")%>|ALL|Select All
                                </data>
                            </gw:list>
				        </td>
                        <td colspan=4 style="border:0;" align="right" ><a title="Click here to show Cost Center" onclick="OnShowPopup(4)" href="#tips" >Cost Center</a></td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list  id="lstCost_Center_1" value='ALL' maxlen = "100" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select 0 PK,'' pl_nm from dual union all SELECT e.pk as pk,D.PL_NM as pl_nm FROM TAC_ABPL D, TAC_ABPLCENTER E WHERE D.DEL_IF = 0 AND E.DEL_IF = 0 AND E.TAC_ABPL_PK = D.PK AND D.TCO_COMPANY_PK = DECODE('" + session("COMPANY_PK") + "','ALL',D.TCO_COMPANY_PK,'" + session("COMPANY_PK") + "' ) order by PL_NM")%>|ALL|Select All
                                </data>
                            </gw:list> 
                        </td>
                       
                        <td colspan=4 style="border:0" align="right" valign="middle">Left Date</td>
                        <td colspan=4 style="border:0;"><gw:datebox id="dtFrom_LeftDate_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="2%" style="border:0;" align="center">~</td>
				        <td colspan=4 style="border:0;"><gw:datebox id="dtTo_LeftDate_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=6 style="border:0;" align="center" ><gw:label id="lblRecord_1"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                    </tr>
                    <tr style="border:0;width:100%;height:7%" valign="middle" >
                        <td colspan=5 style="border:0;" align="center" ><gw:label id="lblSetData_1"  text="Set Data" maxlen = "100" styles="color:#FF3399;width:90%;font-weight: bold;font-size:13" /></td>
                        <td colspan=6 style="border:0;" align="left" >
                            <gw:list id="lstSet_1" value = "1" styles='width:100%' onchange="OnChangeSet(lstSet_1,lstCostSet_1)">
                                <data>LIST|1|Cost Group|2|Cost Kind|3|Cost Center</data> 
                            </gw:list>
                        </td>
                        <td colspan=10 style="border:0;" align="right" styles='width:100%'>
                            <gw:list id="lstCostSet_1" onchange="" value = "ALL" styles='width:95%'></gw:list>
                        </td>   
                        <td colspan=2 style="border:0;" align="left" ><gw:imgBtn img="set" id="ibtnSet_1"   alt="Set Grid"  onclick="OnSetGrid(2)"/></td>
                        <td colspan=6 style="border:0;" align="right">Sample excel file</td>
                        <td colspan=2 style="border:0;" align=center ><gw:imgBtn id="ibtnSampleRpt" img="excel" text="Report" onclick="OnReport()" /></td>
                        <td colspan=5 style="border:0;" align="left"><gw:icon id="idBtnImp" img="in" text="Import Data" onclick="OnImportNew()" /></td>   
                        <td colspan=2 style="border:0;" align="right" >Month</td>
                        <td colspan=4 style="border:0;" align="right"><gw:datebox id="dtMonth_Sal_1"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month onchange="OnChangeMonth()" /></td>
                        <td colspan=4 style="border:0;"  align="right">
                            <gw:icon id="ibtnGroup_1" img="in" text="Group Total" onclick="GroupGrid(1)" />
                        </td>
                        <td colspan=4 style="border:0;" align="left">
                           <gw:icon id="ibtnGroup_2" img="in" text="Expand Group" onclick="GroupGrid(2)" />
                        </td>
                    </tr>
                     <tr style="border:1;width:100%;height:75%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee_1"  
                                styles="width:100%; height:100%"   acceptNullDate
                                sorting="T"/> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</gw:tab> 
</body>

    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtOption" text="1" styles="display:none"/> 

    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
    <gw:textbox id="txtOrgData" styles="display:none"/>
    <gw:textbox id="txtUpperOrg" styles="display:none"/>
    <gw:textbox id="txtEmpID" styles="display:none"/>
    <gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtProcess" styles="display:none"/>
    <gw:textbox id="tmpEmpID" styles="display:none"/>
    <gw:textbox id="txtOrgPK" styles="display:none"/>
    <gw:textbox id="txtOrgNM" styles="display:none"/>
    <gw:textbox id="txtCompany_pk" text="" styles="display:none"  />

    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />    
    <gw:textbox id="lstCompany" text="" styles="display:none"  />  
    <gw:textbox id="lstCostGroup" text="" styles="display:none"  />  
    <gw:textbox id="lstCostCenter" text="" styles="display:none"  />  
    <gw:textbox id="lstCostKind" text="" styles="display:none"  />  
    <gw:textbox id="txtCost_Center_pk" text="" styles="display:none"/>
    <gw:textbox id="txtSequence" text="" styles="display:none"  />
    <gw:textbox id="idDBUSR" text="" styles="display:none"  />
    <gw:textbox id="txtRecord" text="" styles="display:none"  />
    
</html>
