<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Basic Info for Uniform</title>
</head>
<script>
var emp_pk   = "<%=Session("EMPLOYEE_PK")%>";
var emp_id   = "<%=Session("EMP_ID")%>";
var emp_name = "<%=Session("USER_NAME")%>";
var dept     = "<%=Session("DEPT_NAME")%>";
var pos      = "<%=Session("POSITION_NAME")%>";
var flag_yn  = 'N';
var v_language = "<%=Session("SESSION_LANG")%>";
var temp_pk;

function BodyInit()
{   
    if (v_language!="ENG")
        System.Translate(document); 

    txtEmpID.SetEnable(false);
    txtName.SetEnable(false);
    txtDep.SetEnable(false);
    txtPos.SetEnable(false);
    
    idCheck.SetData(-1);
    
    var data = "";
    data = "<%=ESysLib.SetListDataSQL("select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '924' order by seq")%>|ALL|Select All";
    lstJacket.SetDataText(data);
      
    data = "<%=ESysLib.SetListDataSQL("select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '925' order by seq")%>|ALL|Select All";
    lstTrousers.SetDataText(data);
    
    data = "<%=ESysLib.SetListDataSQL("select pk, code_nm from thr_code_detail where del_if = 0 and thr_code_master_pk = '926' order by seq")%>|ALL|Select All";
    lstShoes.SetDataText(data);
    
    txtEmpPK.text  = emp_pk;
    txtTempPK.text = emp_pk; 
    txtEmpID.text  = emp_id;
    txtName.text   = emp_name;
    txtDep.text    = dept;
    txtPos.text    = pos;        
    idData_thr_emp_uniform.Call('SELECT');
}

function OnSave()
{
    if (txtEmpID.text == "")
    {
        alert("You must input Employee ID");
        return;
    }
        
    if (txtName.text == "")
    {
        alert("You must input Name");
        return;
    }
    
    idData_thr_emp_uniform.Call();
}

function OnShowPopup(n)
{
    switch(n)
    {
        case 1:
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
            var obj = System.OpenModal( fpath , 900 ,600, 'resizable:yes;status:yes;');
            
            if (obj!=null)
            {
                txtEmpPK.text = obj[0];
                txtEmpID.text = obj[1];
                txtName.text  = obj[2];
                txtDep.text   = obj[4];
                txtPos.text   = obj[10];
                
                txtTempPK.text = txtEmpPK.text;
            }
            
            idData_thr_emp_uniform.StatusSelect();
            idData_thr_emp_uniform.Call('SELECT');
            break;
    }
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "idData_thr_emp_uniform":
            if (idData_thr_emp_uniform.GetStatus() == 0) // select
            {
                if (txtEmpPK.text == '')
                {
                    lstJacket.value   = 'ALL';
                    lstTrousers.value = 'ALL';
                    lstShoes.value    = 'ALL';
                    //flag_yn           = 'N'
                    txtEmpPK.text = txtTempPK.text;
                }
//                else
//                {
//                    flag_yn = 'Y';
//                }
            }
            break;
    }
}

function CheckNum()
{
    if (isNaN(String.fromCharCode(event.keyCode)))
        event.keyCode = "";
}

</script>
<body>
<gw:data id="idData_thr_emp_uniform" onreceive="OnDataReceive(this)" > 
    <xml>
        <dso id="1" type="control" parameter="0,1,2,3,4,5,6,7,8" function="hr.sp_sel_thr_emp_uniform" procedure="hr.sp_upd_thr_emp_uniform" >
        <input>
            <inout bind="txtEmpPK" />            
            <inout bind="txtHeight" />
            <inout bind="txtWeight" />
            <inout bind="lstJacket" />
            <inout bind="lstTrousers" />
            <inout bind="lstShoes" />
            <inout bind="txtReceiving" />
            <inout bind="txtLaundry" />
            <inout bind="idCheck" />
        </input>
        </dso>
    </xml>
</gw:data>


<table width="100%" cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="97%"></td>
        <td width="3%"><gw:imgBtn img="save"   alt="Save"    onclick ="OnSave()"/></td>
    </tr>
</table>
<table width="100%" cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="100%">
            <fieldset style="padding: 5">
                <legend><font color="black"  ><b>Employee Info</b></font></legend>
                <table width="100%" cellpadding="0" cellspacing="1" border="0">
                    <tr>
                        <td width="10%" ><a title="Click here to choose Employee" onclick="OnShowPopup(1)" href="#tips" >Employee ID</a></td>
                        <td width="20%"><gw:textbox id="txtEmpID" csstype="mandatory"  styles="width:100%;" /></td>
                        <td width="5%"></td>
                        <td width="10%">Name</td>
                        <td width="20%"><gw:textbox id="txtName"   styles="width:100%;" /></td>                        
                        <td width="35%"></td>
                    </tr>
                    <tr>
                        <td width="10%">Department</td>
                        <td width="20%""><gw:textbox id="txtDep"   styles="width:100%;" /></td>
                        <td width="5%"></td>
                        <td width="10%">Position</td>
                        <td width="20%"><gw:textbox id="txtPos"   styles="width:100%;" /></td>
                        <td width="35%"></td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>
<table>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
</table>
<table width="100%" cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="100%">
            <fieldset style="padding: 5">
                <legend><font color="black"><b>Uniform Size</b></font></legend>
                <table width="100%" cellpadding="0" cellspacing="1" border="0">
                    <tr>
                        <td width="10%">Height</td>
                        <td width="20%"><gw:textbox id="txtHeight" type="number" format="###,###.##"   styles="width:100%;" onkeypress="CheckNum()" /></td>
                        <td width="5%">&nbsp; &nbsp;cm</td>                        
                        <td width="10%">Weight</td>
                        <td width="20%"><gw:textbox id="txtWeight" type="number" format="###,###.##"   styles="width:100%;" onkeypress="CheckNum()" /></td>
                        <td width="5%">&nbsp; &nbsp;kg</td>
                        <td width="10%" align="center"></td>
                        <td width="20%" align="center"></td>
                    </tr>
                    <tr>
                        <td width="10%">Jacket size</td>
                        <td width="20%"><gw:list id="lstJacket" value="ALL" maxlen = "100" styles='width:100%'></gw:list></td>
                        <td width="5%" align="center"></td>
                        <td width="10%">Trousers  size</td>
                        <td width="20%"><gw:list id="lstTrousers" value="ALL" maxlen = "100" styles='width:100%'></gw:list></td>
                        <td width="5%" align="center"></td>
                        <td width="10%">Shoes  size</td>
                        <td width="20%"><gw:list id="lstShoes" value="ALL" maxlen = "100" styles='width:100%'></gw:list></td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>
<table>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
    <tr><td></td></tr>
</table>
<table width="100%" cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="100%">
            <fieldset style="padding: 5">
                <legend><font color="black"><b>Receiving Location</b></font></legend>
                <table width="100%" cellpadding="0" cellspacing="1" border="0">
                    <tr>
                        <td width="10%">Receiving</td>
                        <td width="20%"><gw:textbox id="txtReceiving"   styles="width:100%;" /></td>
                        <td width="5%" >&nbsp;</td>                        
                        <td width="10%">Laundry</td>
                        <td width="20%"><gw:textbox id="txtLaundry"   styles="width:100%;" /></td>
                        <td width="5%" ></td>
                        <td width="10%" >Active</td>
                        <td width="20%" ><gw:checkbox id="idCheck" mode="01" /></td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>

<gw:textbox id="txtUpperDept" styles="width:100%;display:none" />
<gw:textbox id="txtDeptData"  styles="width:100%;display:none" />
<gw:textbox id="txtEmpPK"     styles="width:100%;display:none" />
<gw:textbox id="txtYN"        styles="width:100%;display:none" />
<gw:textbox id="txtPK"        styles="width:100%;display:none" />
<gw:textbox id="txtTempPK"    styles="width:100%;display:none" />
</body>
