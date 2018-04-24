<!-- #include file="../../../system/lib/form.inc"  --> 
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Register Evaluation (Manager - MBO)</title>
</head>
<script>
var v_language   = "<%=Session("SESSION_LANG")%>";
var v_company_pk = "<%=Session("COMPANY_PK")%>";
var v_emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var v_user_pk    = "<%=Session("USER_PK")%>";
var v_flag; // Y: Insert/Update
var v_confirm    = 'N'; // Y-N
var v_level      = '';
var v_reload    = 'N'; // Y-N
var THR_EVA_EMP_REVIEWER_PK;
var v_status;

var COL_THR_EVA_EMP_PK          = 0;
var COL_REVIEW_LEVEL                   = 1;
var COL_STATUS                  = 2;
var COL_EMP_ID                  = 3;
var COL_EMP_NAME                = 4;
var COL_THR_EVA_GROUP_PK        = 5;
var COL_THR_EMPLOYEE_PK         = 6;
var COL_MANAGER_PK              = 7;
var COL_THR_EVA_EMP_REVIEWER_PK = 8;

function BodyInit()
{   
    if ( v_language != "ENG" )
        System.Translate(document);
    
    v_flag = 'N';
    txtEmp_PK.text   = v_emp_pk;
    txtUser_PK.text  = v_user_pk;
    txtcompany.text  = v_company_pk;
    txtLanguage.text = v_language;
        
    var data = "";
    data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 AND CLOSE_YN = 'N' ORDER BY EVA_YYYY ||' - ' || EVA_SEQ DESC")%>";
    lstYear.SetDataText(data);
    data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0 order by a.GROUP_ID")%>";
    lstEvaluationGrp.SetDataText(data+ "|ALL|Select ALL");
    lstEvaluationGrp.value = "2";
    imgEmp.SetEnable(0);
    txtSchedule.enabled = false;   
    
    datchem000100_2.Call();
}

function OnToggle()
{
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    var obj = grdEmpStatus.GetGridControl();
    
    if(imgArrow.status == "expand")
    {        
        obj.ColWidth(3) = 9000;
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        obj.ColWidth(3) = 2000;
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

function OnClickChange(n)
{
    switch(n)
    {
        case 1:
            ResetData();
            datchem000100_2.Call();    
        break;
        
        case 2:
            txtDeptPK.text = lstOrg.GetData();
            datchem000100_4.Call('SELECT');
        break;
    }
}

function ResetData()
{
    lstOrg.ClearData();
    grdEmp.ClearData();
    grdEmpStatus.ClearData();
    imgEmp.SetDataText('');
    lbName.SetDataText('');
    lbDept.SetDataText('');
    lbGroup.SetDataText('');
    lbPos.SetDataText('');
    lbDate.SetDataText('');
    lbInfo.SetDataText('');
    lblManager1_Name.SetDataText('');
    lblManager2_Name.SetDataText('');
    txtInfo3.SetDataText('');
    txtInfo4.SetDataText('');
    txtInfo5.SetDataText('');
    txtInfo6.SetDataText('');
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'datchem000100_1':
            imgEmp.SetDataText(txtPhoto_PK.text);
            
            if (grdEmp.rows > 1 )
            {   
                thr_eva_emp_pk.text = grdEmp.GetGridData(grdEmp.row ,COL_THR_EVA_EMP_PK);
                datchem000100_8.Call();
            }
        break;
        
        case 'datchem000100_8':
            var tmp = txtDisc.text;
            var tmp = tmp.substring(5, tmp.length);
            var arr = tmp.split("|");
            var s = "";
            var i = 0;
            //alert(arr.length);
            if (arr.length > 1) {
                while (i < arr.length) {
                    
                    s = s + "**" + arr[i] + arr[i + 1] + "<br>";
                    i = i + 2;
                }
                s = s.substring(0, s.length - 1);
            }
            
            
            lbDisc.text = s;
            datchem000100_9.Call();
            break;
        case 'datchem000100_9':
            var tmp = txtReward.text;
            var tmp = tmp.substring(5, tmp.length);
            var arr = tmp.split("|");
            var s = "";
            var i = 0;
            //alert(arr.length);
            if (arr.length > 1) {
                while (i < arr.length) {

                    s = s + "**" + arr[i] + arr[i + 1] + "<br>";
                    i = i + 2;
                }
                s = s.substring(0, s.length - 1);
            }


            lbReward.text = s;
            datchem000100_5.Call('SELECT');
            break;
        case 'datchem000100_2':
            datchem000100_3.Call();
        break;
        
        case 'datchem000100_3':
            if (lstOrg.GetData() != '')
            {
                if (grdEmpStatus.rows <= 1)
                {
                    txtDeptPK.text = lstOrg.GetData();
                    datchem000100_4.Call('SELECT');
                }
            }
            else
            {
                grdEmpStatus.ClearData();
                grdEmp.ClearData();
                imgEmp.SetDataText('');
                lbName.text  = '';
                lbDept.text  = '';
                lbGroup.text = '';
                lbPos.text   = '';
                lbDate.text  = '';
                lbInfo.text  = '';
            }
        break;
        
        case 'datchem000100_4':
        break;
        
        case 'datchem000100_5':
        if (v_flag == 'N')
        {
            if (grdEmpStatus.rows > 1)
            {
                if (v_status == '1st PROCESSING' || v_status == 'WAITING' || (v_status == '2nd PROCESSING' && v_level == 2) || (v_status == '1st CONFIRMED' && v_level == 2))
                {
                    ibtnSave.SetEnable(true); 
                }
                else
                {
                    ibtnSave.SetEnable(false);
                }           
                
                if (v_level == 1) 
                {
                    grdEmpStatus.SetCellBgColor(1, 5, grdEmpStatus.rows-1, 5, 0X00ffcc);
                    grdEmpStatus.SetColEdit(5, 1 ); // edit column Score 1
                    grdEmpStatus.SetColEdit(6, 0 ); // do not edit column Score 2
                    grdEmpStatus.GetGridControl().ColWidth(3) = 3100;
                    grdEmpStatus.GetGridControl().ColHidden(5) = false;//show column score 1
                    grdEmpStatus.GetGridControl().ColHidden(6) = true; // hide colum Score 2
                    txtInfo3.SetReadOnly(false);
                    txtInfo4.SetReadOnly(false);
                    txtInfo5.SetReadOnly(true);
                    txtInfo6.SetReadOnly(true);
                    //alert(1)
                }
                else if (v_level == 2) 
                {
                    grdEmpStatus.SetCellBgColor(1, 6, grdEmpStatus.rows-1, 6, 0X00ffcc);
                    grdEmpStatus.SetColEdit(5, 0 ); // do not edit column Score 1
                    grdEmpStatus.SetColEdit(6, 1 ); // edit column Score 1
                    grdEmpStatus.GetGridControl().ColWidth(3) = 2300;
                    grdEmpStatus.GetGridControl().ColHidden(5) = true;//hide column score 1
                    grdEmpStatus.GetGridControl().ColHidden(6) = false; //show column 2
                    grdEmpStatus.SetCellBgColor(1, 5, grdEmpStatus.rows-1, 5, 0xeeeeee);          
                    txtInfo3.SetReadOnly(true);
                    txtInfo4.SetReadOnly(true);
                    txtInfo5.SetReadOnly(false);
                    txtInfo6.SetReadOnly(false);
                }
                
                txt_eva_emp_reviewer_pk.text = THR_EVA_EMP_REVIEWER_PK;
                datchem000100_6.Call('SELECT');
            }
        }
        else
        {
            datchem000100_6.StatusUpdate();
            txt_eva_emp_reviewer_pk.text = THR_EVA_EMP_REVIEWER_PK;
            
            txtInfoTemp_1.SetDataText(txtInfo3.GetData());
            txtInfoTemp_2.SetDataText(txtInfo4.GetData());
            txtInfoTemp_3.SetDataText(txtInfo5.GetData());
            txtInfoTemp_4.SetDataText(txtInfo6.GetData());
            v_reload='Y';                                 
            datchem000100_6.Call();
        }
        break;
        
        case 'datchem000100_6':
            if(v_confirm == 'N')           
            {
                if (v_level == 1)
                {
                    txtInfo3.SetDataText(txtInfoTemp_1.text);
                    txtInfo4.SetDataText(txtInfoTemp_2.text);
                    txtInfo5.SetDataText('');
                    txtInfo6.SetDataText('');
                }
                else
                {
                    txtInfo3.SetDataText(txtInfoTemp_1.text);
                    txtInfo4.SetDataText(txtInfoTemp_2.text);
                    txtInfo5.SetDataText(txtInfoTemp_3.text);
                    txtInfo6.SetDataText(txtInfoTemp_4.text);
                }
                
                txtMana1_PK.text = grdEmpStatus.GetGridData(1, 7);
                txtMana2_PK.text = grdEmpStatus.GetGridData(1, 8);
                
                datchem000100_7.Call();
            }
            else
            {
                alert('Confirm Successfull.')                
                txtDeptPK.text = lstOrg.GetData();
                datchem000100_4.Call('SELECT');
            }
        break;
        
        case 'datchem000100_7':
            if(v_reload == 'Y')
            {
                v_reload = 'N';
                datchem000100_4.Call('SELECT');
            }


        break;
    }
}

function treeItemOnclick()
{
    var obj = treeDept.GetCurrentNode();
    
    if (obj!=null)
        txtDeptPK.text = obj.oid;
        
    datchem000100_4.Call('SELECT');
}

function OnSave()
{
	
	/*if((txtInfo3.text.length<2 || txtInfo4.text.length<2)&& v_level==1)
	{
		alert("Please input opininon and assign position")
		return;
	}
	if((txtInfo5.text.length<2 || txtInfo6.text.length<2)&& v_level==2)
	{
		alert("Please input opininon and assign position")
		return;
	}*/
    if (grdEmpStatus.rows > 1)
    {
        for(var i=1; i<grdEmpStatus.rows; i++)
        {                    
            if (grdEmpStatus.GetGridData(i, 9) == '')
            {
                grdEmpStatus.SetGridText(i, 9, 'S');
            }
            
            if (grdEmpStatus.GetGridData(i, 7) == txtEmp_PK.text) // level 1
            {
                if (grdEmpStatus.GetGridData(i, 5) == '0' )
                {
                    alert('You must input number at row : ' + i);
                    return;
                }
                
                grdEmpStatus.SetColEdit(5, 1 ); // edit column Score 1
                grdEmpStatus.SetGridText(i, 10, '1');
            }
            
            if (grdEmpStatus.GetGridData(i, 5) != '' )
            {
                if (grdEmpStatus.GetGridData(i, 8) == txtEmp_PK.text && v_level==2) // level 2
                {
                    if (grdEmpStatus.GetGridData(i, 6) == '0' )
                    {
                        alert('You must input number at row : ' + i);
                        return;
                    }
                    
                    grdEmpStatus.SetColEdit(6, 1); // edit column Score 2
                    grdEmpStatus.SetGridText(i, 10, '2');
                }
            }
        }
        
        v_flag    = 'Y';
        v_confirm = 'N';
        datchem000100_5.Call();
    }
}

function OnSubmit()
{
    if (grdEmpStatus.rows > 1)
    {   
        if(confirm('Do you want to confirm selected item?'))
        {
            for(var i=1; i<grdEmpStatus.rows; i++)
            {                      
                if (grdEmpStatus.GetGridData(i, 9) == '')
                {
                    grdEmpStatus.SetGridText(i, 9, 'C');
                }
                
                if (grdEmpStatus.GetGridData(i, 7) == txtEmp_PK.text) // level 1
                {
                    if (grdEmpStatus.GetGridData(i, 5) == '0' )
                    {
                        alert('You must input number at row : ' + i);
                        return;
                    }
                    
                    grdEmpStatus.SetColEdit(5, 1 ); // edit column Score 1
                    grdEmpStatus.SetGridText(i, 10, '1');
                }
                
                if (grdEmpStatus.GetGridData(i, 5) != '' )
                {
                    if (grdEmpStatus.GetGridData(i, 8) == txtEmp_PK.text) // level 2
                    {
                        if (grdEmpStatus.GetGridData(i, 6) == '0' )
                        {
                            alert('You must input number at row : ' + i);
                            return;
                        }
                        grdEmpStatus.SetColEdit(6, 1); // edit column Score 2
                        grdEmpStatus.SetGridText(i, 10, '2');
                    }
                }
            }
        }
        v_flag    = 'Y';
        v_confirm = 'Y';
        datchem000100_5.Call();
    }
}

function AfterEdit()
{
   /* if (v_level == 2)
    {
        if (grdEmpStatus.GetGridData(grdEmpStatus.row, 5) == 0 || grdEmpStatus.GetGridData(grdEmpStatus.row, 5) == '')
        {
            grdEmpStatus.SetGridText(grdEmpStatus.row, 6, '0');
            alert("The first reviewer has not input score for this staff. So you cannot input score.");
            return;
        }
    }*/

	if (grdEmpStatus.GetGridData(grdEmpStatus.row, 5) > 100 )
	{
		grdEmpStatus.SetGridText(grdEmpStatus.row, 5, '100');
		return;
	}
	
	if ( grdEmpStatus.GetGridData(grdEmpStatus.row, 5) < 0)
	{
	    grdEmpStatus.SetGridText(grdEmpStatus.row, 5, '0');
		return;
	}

	if (grdEmpStatus.GetGridData(grdEmpStatus.row, 6) > 100 )
	{
		grdEmpStatus.SetGridText(grdEmpStatus.row, 6, '100');
		return;
	}
	
	if ( grdEmpStatus.GetGridData(grdEmpStatus.row, 6) < 0)
	{
	    grdEmpStatus.SetGridText(grdEmpStatus.row, 6, '0');
		return;
	}

    if (isNaN(grdEmpStatus.GetGridData(grdEmpStatus.row, 5)))
    {
        grdEmpStatus.SetGridText(grdEmpStatus.row, 5, '0');
        return;
    }
    
    if (isNaN(grdEmpStatus.GetGridData(grdEmpStatus.row, 6)))
    {
        grdEmpStatus.SetGridText(grdEmpStatus.row, 6, '0');
        return;
    }
}

function OnGridCellClick(obj)
{    
    if (obj.id == "grdEmp")
    {
        txtInfo3.SetDataText('');
        txtInfo4.SetDataText('');
        txtInfo5.SetDataText('');
        txtInfo6.SetDataText('');
        v_flag    = 'N';
        v_confirm = 'N';

        if (grdEmp.rows <= 1)
            return;
            
        THR_EVA_EMP_REVIEWER_PK = grdEmp.GetGridData(grdEmp.row ,COL_THR_EVA_EMP_REVIEWER_PK);
        txtEmpTmp_PK.text       = grdEmp.GetGridData(grdEmp.row ,COL_THR_EMPLOYEE_PK);
        txtReviewLevel.text     = grdEmp.GetGridData(grdEmp.row ,COL_REVIEW_LEVEL);
        v_status                = grdEmp.GetGridData(grdEmp.row ,COL_STATUS);
        v_level                 = grdEmp.GetGridData(grdEmp.row, COL_REVIEW_LEVEL);
        datchem000100_1.Call();
    }
    
    if(obj.id == "grdEmpStatus" && event.col == 3)
    {
        OnShowPopup(5);
    }
}

function FindPos( obj , posinfo )
{
	var pobj ;
	
	var x = 0  , y = 0 ;
		
	pobj = obj;
	
	while ( pobj )
	{
		x += pobj.offsetLeft;
		y += pobj.offsetTop;
		
		// alert( pobj.offsetLeft + "="+pobj.outerHTML );
		
		if ( pobj != obj && pobj.offsetParent && pobj.tagName != "TABLE")
		{
			// alert( pobj.clientLeft + ":" + pobj.clientTop + "/" + pobj.offsetLeft + "="+pobj.outerHTML);
			x += pobj.clientLeft;
			y += pobj.clientTop;
			
		}
		pobj = pobj.offsetParent;	
	}

	posinfo.x = x;
	posinfo.y = y;
	posinfo.width = obj.offsetWidth;
	posinfo.height = obj.offsetHeight;
}

function GetOpinionContent(opt)
{
    if(opt == 1){
        return txtInfo3.GetData();
    }
    else if(opt == 2){
        return txtInfo4.GetData();
    }
    else if(opt == 3){
        return txtInfo5.GetData();
    }
    else if(opt == 4){
        return txtInfo6.GetData();
    }
    else if(opt == 5){
        return grdEmpStatus.GetGridData(grdEmpStatus.row, 3);
    }
}

function OnShowPopup(n)
{
    var url = System.RootURL + "/form/ch/em/chem00110_1.aspx";
    
    switch(n)
    {
        case 1:
            if (v_level == 1 && (v_status == '1st PROCESSING' || v_status == 'WAITING' || v_status == '2nd PROCESSING'))
                url = url + "?opt=1&yn=Y";
            else
                url = url + "?opt=1&yn=N";
                
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
            
            if ( winObj )
                txtInfo3.SetDataText(winObj);
        break;
        
        case 2:
            if (v_level == 1 && (v_status == '1st PROCESSING' || v_status == 'WAITING' || v_status == '2nd PROCESSING'))
                url = url + "?opt=2&yn=Y";
            else
                url = url + "?opt=2&yn=N";
                
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
            
            if ( winObj )
                txtInfo4.SetDataText(winObj);
        break;
        
        case 3:
            if (v_level == 2 && (v_status == '1st PROCESSING' || v_status == 'WAITING' || v_status == '2nd PROCESSING'))
                url = url + "?opt=3&yn=Y";
            else
                url = url + "?opt=3&yn=N";
                        
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
            
            if ( winObj )
                txtInfo5.SetDataText(winObj);
        break;
        
        case 4:
            if (v_level == 2 && (v_status == '1st PROCESSING' || v_status == 'WAITING' || v_status == '2nd PROCESSING'))
                url = url + "?opt=4&yn=Y";
            else
                url = url + "?opt=4&yn=N";
                
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
            
            if ( winObj )
                txtInfo6.SetDataText(winObj);
        break;
        
        case 5:
            if (v_status == '1st PROCESSING' || v_status == 'WAITING' || v_status == '2nd PROCESSING')
                url = url + "?opt=5&yn=Y";
            else 
                url = url + "?opt=5&yn=N";
            
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
            
            if (winObj)
                grdEmpStatus.SetGridText(grdEmpStatus.row, 3, winObj);
        break;
    }    
}

</script>
<body>
<gw:data id="datchem000100_1" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="process" procedure="sp_pro_get_emp_info_chem00060" > 
            <input>
                <input bind="txtEmpTmp_PK" />
            </input> 
            <output>                    
                <output bind="lbName"/>
                <output bind="lbDept" />          
                <output bind="lbGroup" />
                <output bind="txtPhoto_PK" />
                <output bind="lbPos" />
                <output bind="lbDate" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_8" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="list" procedure="sp_sel_chem000100_8" > 
            <input>
                <input bind="lstYear" />
                <input bind="txtEmpTmp_PK" />
            </input> 
            <output>                    
                <output bind="txtDisc" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_9" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="list" procedure="sp_sel_chem000100_9" > 
            <input>
                <input bind="lstYear" />
                <input bind="txtEmpTmp_PK" />
            </input> 
            <output>                    
                <output bind="txtReward" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_2" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem000100_2" > 
            <input>
                <input bind="lstYear" />
                <input bind="txtEmp_PK" />
            </input>
	       <output>	            
	            <output bind="lblPeriod" /> 
	            <output bind="txtSchedule" />
	            <output bind="lblTotal_1" />
	            <output bind="lblTotal_2" />
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_3" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="list" procedure="sp_sel_chem000100_3">
            <input>
                <input bind="txtcompany" />
                <input bind="lstYear" />
                <input bind="txtEmp_PK" />
            </input> 
            <output>
                <output bind="lstOrg" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_4" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="grid"  parameter="" function="sp_sel_chem000100_4" procedure=""> 
            <input bind="grdEmp" >
                <input bind="txtDeptPK" />
                <input bind="txtEmp_PK" />
                <input bind="lstYear" />
                <input bind="lstEvaluationGrp" />
            </input>
            <output  bind="grdEmp" />
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_5" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="grid"  parameter="5,6,9,10,11,12,13" function="sp_sel_chem000100_5" procedure="sp_upd_chem000100_5"> 
            <input bind="grdEmpStatus" >
                <input bind="thr_eva_emp_pk" />
                <input bind="txtLanguage" />
                <input bind="txtReviewLevel" />
            </input>
            <output  bind="grdEmpStatus" />
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000100_6" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="control" parameter="0,1,2,3,4" function="sp_sel_chem000100_6" procedure="sp_upd_chem000100_6"> 
            <inout>
                <inout bind="txt_eva_emp_reviewer_pk" />
                <inout bind="txtInfoTemp_1" />
                <inout bind="txtInfoTemp_2" />
                <inout bind="txtInfoTemp_3" />
                <inout bind="txtInfoTemp_4" />
            </inout>
        </dso>
    </xml>
</gw:data>

<gw:data id="datchem000100_7" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem000100_7" > 
            <input>
                <input bind="txtMana1_PK" />
                <input bind="txtMana2_PK" />
            </input>
	       <output>	            
	            <output bind="lblManager1_Name" />
	            <output bind="lblManager2_Name" />
	       </output>
        </dso> 
    </xml> 
</gw:data>

<table id="main" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr>
        <td width="45%" valign="top" id="left">
            <table style="width:100%; height:100%" border="0">
                <tr style="height:16%">
                    <td>
                        <table border="0" style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" style="background-color:#BDE9FF">
                            <tr>
                                <td width="30%" align="right">Evaluation #</td>
                                <td width="70%" colspan="4" style="">
                                    <gw:list  id="lstYear" styles='width:100%' onchange="OnClickChange(1)" ></gw:list>
                                </td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Evaluation Period</td>
                                <td width="70%" style="width:100%; font-size:larger" nowrap colspan="4"><gw:label id="lblPeriod" text=""/></td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Schedule</td>
                                <td width="70%" style="width:100%; font-size:larger" nowrap colspan="4" ><gw:label id="txtSchedule" text="" /></td>
                            </tr>
                        </table>  
                    </td>
                </tr>
                <tr style="height:84%">
                    <td valign="top" >
                        <table style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" border="1">
                            <tr style="height:5%" >
                                <td colspan="2" style="width:100%">
                                    <table style="width:100%;height:100%" border="0">
                                        <td width="10%">Group</td>
                                        <td width="30%">
                                        <gw:list id="lstEvaluationGrp" styles="width:100%" onchange="datchem000100_4.Call('SELECT');" />
                                        </td>
                                        <td width="35%" >
                                            <gw:label id="lblTotal_1"  onchange=""/>
                                        </td>
                                        <td width="25%" >
                                            <gw:label id="lblTotal_2"  onchange=""/>
                                        </td>    
                                    </table>
                                </td>
                            </tr>
                            <tr style="height:95%" >
                                <td style="width:60%; height:100%" valign="top">
                                    <table style="width:100%;height:100%" border="0">
                                        <tr valign="top">
                                            <td style="width:100%; height:100%" valign="top">
                                                <table style="width:100%;height:100%" border="0">
                                                    <tr valign="top">
                                                        <td style="width:30%; height:10%" valign="middle">Organization</td>
                                                        <td style="width:70%; height:10%" valign="middle"><gw:list  id="lstOrg" styles='width:150px' onchange="OnClickChange(2)" ></gw:list></td>
                                                    </tr>
                                                    <tr >
                                                        <td colspan="2" style="width:50%; height:90%">
                                                            <gw:grid id="grdEmp" 
                                                            header="_thr_eva_emp_pk|Level|Status|Emp ID|Emp Name|_THR_EVA_GROUP_PK|_THR_EMPLOYEE_PK|_MANAGER_PK|_THR_EVA_EMP_REVIEWER_PK|Group" 
                                                            format="0|0|0|0|0|0|0|0|0|0"
                                                            aligns="0|1|0|1|0|0|0|0|0|0" 
                                                            defaults="|||||||0|0|" 
                                                            editcol="0|0|0|0|0|0|0|0|0|0"
                                                            widths="0|600|1000|900|2500|0|0|0|0|0"
                                                            styles="width:100%;height:100%" 
                                                            oncellclick="OnGridCellClick(this)"
                                                            editcolcolor="true"
                                                             />
                                                        </td> 
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>                                
                                <td style="width:40%; height:100%" valign="top" >
                                    <table width="100%" cellpadding="0" cellspacing="1" border="0" style="height:100%;" >
                                        <tr style="height:30%" >
                                            <td width="20%" valign="top" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                                                <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:180;height:155"  />
                                            </td>
                                        </tr>
                                        <tr style="height:70%" >
                                            <td nowrap width="80%" valign="top" style="background-color:#BDE9FF;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                                                <table width="100%" cellpadding="0" cellspacing="1" border="1" style="height:100%;" >
                                                    <tr>
                                                        <td width="100%" colspan="2" style="font-size:larger">&nbsp;<gw:label id="lbName" styles="width:95%"  ></gw:label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="45%" style="font-size:larger">&nbsp;<gw:label id="lbDept" styles="width:95%"></gw:label></td>
                                                        <td width="55%" style="font-size:larger">&nbsp;<gw:label id="lbGroup" styles="width:95%"></gw:label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="45%" style="font-size:larger">&nbsp;<gw:label id="lbPos" styles="width:95%"></gw:label></td>
                                                        <td width="55%" style="font-size:larger"><gw:label id="lbDate" styles="width:100%"></gw:label></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="45%" style="font-size:larger">&nbsp;<gw:label id="lbDisc" styles="width:95%"></gw:label></td>
                                                        <td width="55%" style="font-size:larger">&nbsp;<gw:label id="lbReward" styles="width:95%"></gw:label></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width:100%;font-size:larger" colspan="2"><gw:label id="lbInfo" styles="width:100%" ></gw:label></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>                                
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="55%"  valign="top" id="right">
            <table width="100%" cellpadding="0" cellspacing="1" border="0" style="height:100%;" >
                <tr style="height:5%"  >
                    <td colspan="2">
                        <table width="100%" >
                            <tr>
                                <td width="97%">
                                    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
                                    style="cursor: hand" onclick="OnToggle()" />
                                </td>
                                <td width="3%" ><gw:icon id="ibtnSave"   img="in" text="Save" onclick="OnSave()" /></td>
                                <td width="3%" ><gw:icon id="ibtnSubmit" img="in" text="Confirm" onclick="OnSubmit()" style="display:none" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height:25%"  >
                    <td colspan="2" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                        <gw:grid id="grdEmpStatus" 
                        header="_PK|Element Type|Element|Contents|Weight|1st Score|2nd Score|_Manager1|_Manager2|_Status|_level|_thr_eva_factor_pk|_thr_eva_master_pk|_thr_employee_pk" 
                        format="0|0|0|0|1|1|1|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        defaults="|||||||||||||" 
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        widths="0|1500|1000|2500|1000|1000|1000|0|0|0|0|0|0|0"
                        styles="width:100%;height:100%" 
                        oncellclick="OnGridCellClick(this)"
                        onafteredit="AfterEdit()"
                        editcolcolor="true"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13" />
                    </td>
                </tr>
                <tr style="height:70%"  >
                    <td colspan="2" >
                       <table style="width:100%;height:100%" >
                            <tr style="width:100%; height:10%">
                                <td align="center" style="width:10%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black; font-size:larger">Level</td>
                                <td align="center" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black;font-size:larger">Opinion on Evaluation</td>
                                <td align="center" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black;font-size:larger">Opinion on the Assignment of Position</td>
                            </tr>
                            <tr style="width:100%;height:30%" >
                                <td align="center" style="width:10%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black">1st<gw:label id="lblManager1_Name" text=""/></td>
                                <td align="right" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(1)">Details</b>
                                <gw:textarea id="txtInfo3" styles="width: 100%;height:90%;" /></td>
                                <td align="right" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(2)">Details</b>
                                <gw:textarea id="txtInfo4" styles="width: 100%;height:90%" /></td>
                            </tr>
                            <tr style="width:100%;height:30%" >
                                <td align="center" style="width:10%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black">2nd<gw:label id="lblManager2_Name" text=""/></td>
                                <td align="right" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-top: solid 1 Black">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(3)">Details</b>
                                <gw:textarea id="txtInfo5" styles="width: 100%;height:90%" /></td>
                                <td align="right" style="width:45%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                                <b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(4)">Details</b>
                                <gw:textarea id="txtInfo6" styles="width: 100%;height:90%" /></td>
                            </tr>
                       </table>
                    </td>
                </tr>
            </table>
        </td>        
    </tr>    
</table>

<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtEmpTmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtgradetype" style="display:none" />
<gw:textbox id="txtgradetime" style="display:none" />
<gw:textbox id="txtcompany" style="display:none" />
<gw:textbox id="txtUser_PK" styles="display:none"/>
<gw:textbox id="txtDeptPK" styles="display:none"/>
<gw:textbox id="txGroup_pk" style="display:none" />
<gw:textbox id="txt_eva_emp_reviewer_pk" style="display:none" />
<gw:textbox id="txtScore_A" style="display:none" />
<gw:textbox id="txtScore_C" style="display:none" />
<gw:textbox id="txtInfoTemp_1" style="display:none" />
<gw:textbox id="txtInfoTemp_2" style="display:none" />
<gw:textbox id="txtInfoTemp_3" style="display:none" />
<gw:textbox id="txtInfoTemp_4" style="display:none" />
<gw:textbox id="txtTotal" style="display:none" />
<gw:textbox id="thr_eva_emp_pk" style="display:none" />
<gw:textbox id="manager_pk" style="display:none" />
<gw:textbox id="txtMana1_PK" style="display:none" />
<gw:textbox id="txtMana2_PK" style="display:none" />
<gw:textbox id="txtMana1_Name" style="display:none" />
<gw:textbox id="txtMana2_Name" style="display:none" />
<gw:textbox id="txtStatus" style="display:none" />
<gw:textbox id="txtLanguage" style="display:none" />
<gw:textbox id="txtReviewLevel" style="display:none" />
    <gw:textbox id="txtDisc" style="display:none" />
    <gw:textbox id="txtReward" style="display:none" />
</body>



