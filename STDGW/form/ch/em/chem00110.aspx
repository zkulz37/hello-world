<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Confirm Evaluation Grade</title>
</head>

<script>
    var user_pk      = "<%=Session("EMPLOYEE_PK")%>" ;
    var user_name    = "<%=Session("USER_NAME")%>" ;
    var user_id      = "<%=Session("USER_ID")%>" ;
	var v_company_pk = "<%=Session("COMPANY_PK")%>";
	var g_language   = "<%=Session("SESSION_LANG")%>";
	var g_admin_yn   = "<%=Session("CODEADMIN_YN")%>";
	
	var l_thr_eva_emp_pk;
	var l_thr_eva_emp_reviewer_pk;
	var v_status;
// grdEmp
var iGeva_emp_pk 	        = 0,
	iGDepartment			= 1,
	iGEMP_ID				= 2,
	iGName					= 3,
	iGEvaluated_Time		= 4,
	iGEvaluated_Date		= 5,
	iGTotal					= 6,
	iGA						= 7,
	iGC						= 8,
	iGRank					= 9,
	iGGrade = 10,
    iGa_rank = 11;
	iGa_grade = 12;
	iGc_rank = 13;
	iGc_grade = 14;
	iGopinion_eva			= 15,
	iGopinion_position		= 16,
	iGEmp_PK				= 17;
	iGstatus                = 18;
	iGeva_emp_reviewer = 19;
	iGeva_group_pk = 23;
	iGflag = 24;
	iGreviewer_status = 25;
	

// grdElement
var
    col_seq       = 0;
    col_type      = 1;
    col_name      = 2;
    col_contents  = 3;
    col_weight    = 4;
    col_score_1   = 5;
    col_score_2   = 6;
    col_manager_1 = 7;
    col_manager_2 = 8;
        
	var mousex,mousey;
	document.onmousemove=getMouseXY;//use to func getMouseXY(e)
	function getMouseXY(e) // works on IE6,FF,Moz,Opera7
    { 
      if (!e) e = window.event; // works on IE, but not NS (we rely on NS passing us the event)

      if (e)
      { 
        if (e.pageX || e.pageY)
        { // this doesn't work on IE6!! (works on FF,Moz,Opera7)
          mousex = e.pageX;
          mousey = e.pageY;
        }
        else if (e.clientX || e.clientY)
        { // works on IE6,FF,Moz,Opera7
          mousex = e.clientX + document.body.scrollLeft;
          mousey = e.clientY + document.body.scrollTop;
        }  
      }
    }

//iGthr_eva_emp_reviewer_pk = 14;

function BodyInit()
{
    grdEmp.GetGridControl().ScrollTrack = true;

    System.Translate(document);
	OnMergeHeader();
    BindingData();
    setEnable();
    //idBtnUnConfirm.SetEnable(false);
	datchem00050_1.Call();	
	//OnSearch('1');
}

function setEnable()
{
    txtarOpiEva1.SetReadOnly(true);
    txtarOpiEva2.SetReadOnly(true);
    txtarOpiEvaPos1.SetReadOnly(true);
    txtarOpiEvaPos2.SetReadOnly(true);
}

function BindingData()
{
    var ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and close_yn='N' order by 2 desc")%>";
	lstYear.SetDataText(ls_data);
	ls_data = "DATA|1|1";
	lstTOEmpOpt.SetDataText(ls_data);
	txtLOGGED_EMP_PK.text = user_pk;
	ls_data = "<%=ESysLib.SetListDataSQL("select a.code, a.code_nm from thr_code_detail a, thr_code_master b where a.del_if=0 and b.del_if = 0 and  a.thr_code_master_pk = b.pk and b.id = 'HR0105'")%>"
	lstEvaTimes.SetDataText(ls_data);
	lstEvaTimes.value = '0';
	ls_data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.GROUP_ID || '-' || a.group_nm FROM thr_eva_group a WHERE a.del_if = 0 order by 2")%>";
    lstEvaluationGrp.SetDataText(ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0102'")%>";
    grdEmp.SetComboFormat(iGstatus, ls_data);

	txtCompany.text = v_company_pk ;	
	imgEmp.SetEnable(false);
	txtLanguage.text = g_language; 
}
//---------------------------------------------------
function auto_resize_column(obj, col1, col2, font_size) {
    if (font_size != 0)
        obj.GetGridControl().FontSize = font_size;
    obj.GetGridControl().AutoSize(col1, col2, false, 0);
}
//---------------------------------------------------------------------
function OnMergeHeader()
{
	var l_fg = grdEmp.GetGridControl();
	if(grdEmp.rows == 1)
	{
		grdEmp.AddRow();
	}
	l_fg.FixedRows = 2; 
    //l_fg.Cell(13, 0, 0, 0, l_fg.Cols - 1) = true ; 
    l_fg.Cell(12, 0, 0, 1, l_fg.Cols-2) = 8;   
    l_fg.MergeCells = 5;
    l_fg.MergeRow(0) = true;   
    l_fg.MergeCol(iGDepartment) = true ;            
    l_fg.Cell(0, 0, iGDepartment, 1, iGDepartment) = 'Organization';
	
	l_fg.MergeCol(iGEMP_ID) = true ;               
	l_fg.Cell(0, 0, iGEMP_ID, 1, iGEMP_ID) = 'Emp ID';
	
	l_fg.MergeCol(iGName) = true ;               
	l_fg.Cell(0, 0, iGName, 1, iGName) = 'Name';
	
	l_fg.MergeCol(iGEvaluated_Time) = true ;               
	l_fg.Cell(0, 0, iGEvaluated_Time, 1, iGEvaluated_Time) = 'Eva Time';
	
	l_fg.MergeCol(iGEvaluated_Date) = true ;               
	l_fg.Cell(0, 0, iGEvaluated_Date, 1, iGEvaluated_Date) = 'Eva Date';
            
	l_fg.Cell(0, 0, iGTotal, 0, iGc_grade) = 'Score';
	
	l_fg.Cell(0, 1, iGTotal, 1, iGTotal) = 'T-Score';
	l_fg.Cell(0, 1, iGA, 1, iGA) = 'A-Score';
	l_fg.Cell(0, 1, iGC, 1, iGC) = 'C-Score';
	l_fg.Cell(0, 1, iGRank, 1, iGRank) = 'T-Rank';
	l_fg.Cell(0, 1, iGGrade, 1, iGGrade) = 'T-Grade';	
	l_fg.Cell(0, 1, iGa_rank, 1, iGa_rank) = 'A-Rank';
	l_fg.Cell(0, 1, iGa_grade, 1, iGa_grade) = 'A-Grade';
	l_fg.Cell(0, 1, iGc_rank, 1, iGc_rank) = 'C-Rank';
	l_fg.Cell(0, 1, iGc_grade, 1, iGc_grade) = 'C-Grade';

	l_fg.MergeCol(iGstatus) = true;
	l_fg.Cell(0, 0, iGstatus, 1, iGstatus) = 'Status';
}

function OnSearch(iCase)
{
	var l_row, i, l_Emp_ID = "", l_opi_eva = "", l_opi_position = "", l_Eva_Time;
	l_row = grdEmp.row ;
	_getoption = true;
	switch(iCase)
	{
		case '1':
		    if(lstEvaTimes.value == "0"){
			    alert("You can only select level 1 or level 2");
			    lstEvaTimes.value = "1";
			}
			ls_data = "DATA|1|1";
	        lstTOEmpOpt.SetDataText(ls_data);
	        datchem00110.Call('SELECT');
		break;
		case '2':
			// reset data
			txtarOpiEva1.SetDataText('');
			txtarOpiEvaPos1.SetDataText('');
			txtarOpiEva2.SetDataText('');
			txtarOpiEvaPos2.SetDataText('');
			
			if (grdEmp.rows <= 1)
	            return;	        
	        
			l_thr_eva_emp_pk          = grdEmp.GetGridData(l_row, iGeva_emp_pk);
			l_thr_eva_emp_reviewer_pk = grdEmp.GetGridData(l_row, iGeva_emp_reviewer);
			
			// SHOW Opinion on Evaluation, Assignment of Position		
			l_Emp_ID       = grdEmp.GetGridData(l_row, iGEMP_ID);
			l_Eva_Time     = grdEmp.GetGridData(l_row, iGEvaluated_Time);
			
			if(l_Eva_Time == '1')
			{
				grdElement.GetGridControl().ColWidth(col_contents) = 5800;
				grdElement.GetGridControl().ColHidden(col_score_1) = false; // view colum Score 1
				grdElement.GetGridControl().ColHidden(col_score_2) = true; // hide colum Score 2
			}
			else if(l_Eva_Time == '2')
			{
				grdElement.GetGridControl().ColWidth(col_contents) = 5000;
				grdElement.GetGridControl().ColHidden(col_score_1) = false; // view colum Score 1
				grdElement.GetGridControl().ColHidden(col_score_2) = false; // view colum Score 2
			}
			
	        txtEmp_PK.text = grdEmp.GetGridData(l_row, iGEmp_PK);
	        
	        dat_get_emp_info_chem00060.Call();
		break;
	}
}
//--------------------------------------------------------------------
function OnDataReceive(iObj)
{
	var l_EvaTimes_Code = '';
	switch(iObj.id)
	{
		case 'datchem00050_1':
		    _getoption = true;
		    ls_data = "DATA|1|1";
	        lstTOEmpOpt.SetDataText(ls_data);
	        if(txtGrdEvaType.text == "FINAL LEVEL"){
                lstEvaTimes.value = "0" ;
                lstEvaTimes.SetEnable(false);    
            }
            else{
                lstEvaTimes.value = "1";
                lstEvaTimes.SetEnable(true);
            }
			datchem00110.Call('SELECT');
		break ;

        case 'datchem00050_2':
			    datchem00110.Call('SELECT');
		        break ;

		case 'datchem00110':
			OnMergeHeader();		
			lblTotEmp.text = "T/O " + Number(grdEmp.rows - 2) + " Employees";
			if(_getoption == true)
			{
			    if (grdEmp.rows > 2)
			    {
			            if (grdEmp.GetGridData(2, iGreviewer_status) == "30") {
			                v_status = 'Confirm';
			                grdEmp.SetCellBgColor(2, 0, grdEmp.rows - 1, grdEmp.cols - 1, 0X7AA0FF);
			                idBtnConfirm.SetEnable(false);
			                idBtnUnConfirm.SetEnable(true);
			                idBtnResult.SetEnable(false);
			                idBtnCancel.SetEnable(false);
			            }
			            else {
			                v_status = 'Processing';
			                idBtnConfirm.SetEnable(true);
			                idBtnResult.SetEnable(true);
			                idBtnUnConfirm.SetEnable(false);
			                idBtnCancel.SetEnable(true);
			            }
			        
			    }
			    if(grdEmp.rows > 2){
			    	txtTotalEmp.text = Number(grdEmp.rows - 2);
	    		        datGetOption.Call();
			    }	
			}
			auto_resize_column(grdEmp, 0, grdEmp.cols - 1, 0);
			ClearData();			
		break;
		
		case 'dat_get_emp_info_chem00060':
	        imgEmp.SetDataText(txtPhoto_PK.text);
			
			lblEmpName.text  = " Name:" + "  " + lblEmpName.text ;
			lblSection.text  = " Organization:  " + " " + lblSection.text;
			lblTeam.text     = " Group :  " + lblTeam.text ;
			lblPosition.text = " Position:  " + lblPosition.text;
			
	        txt_eva_emp_reviewer_pk.text = l_thr_eva_emp_reviewer_pk;
	        datchem000100_6.Call('SELECT');
			
		break ;
		
		case 'datchem000100_6':
            txtthr_eva_emp_reviewer.text = l_thr_eva_emp_pk; 
		    datchem00110_1.Call('SELECT');
		break;
		
		case 'datchem00110_1':		
		if ( grdElement.rows <= 1 )
		        return;
		    
	    txtMana1_PK.text        = grdElement.GetGridData(1, col_manager_1);
        txtMana2_PK.text        = grdElement.GetGridData(1, col_manager_2);
        txt_thr_eva_emp_pk.text = grdEmp.GetGridData(grdEmp.row, iGeva_emp_pk);
        datchem000110_7.Call();
		break;
			
		case 'datchem000110_7':
            if (user_pk == grdElement.GetGridData(1, col_manager_1)) // level 1
            {
                txtarOpiEva1.SetDataText(txtInfoTemp_1.text);
		        txtarOpiEvaPos1.SetDataText(txtInfoTemp_2.text);
		        txtarOpiEva2.SetDataText('');
		        txtarOpiEvaPos2.SetDataText('');	
            }
            
            if (user_pk == grdElement.GetGridData(1, col_manager_2)) // level 2
            {
                txtarOpiEva1.SetDataText(txtInfoTemp_1.text);
		        txtarOpiEvaPos1.SetDataText(txtInfoTemp_2.text);
		        txtarOpiEva2.SetDataText(txtInfoTemp_3.text);
		        txtarOpiEvaPos2.SetDataText(txtInfoTemp_4.text);	
            }
		break;
			
		case 'datchem00110_3':
		    datchem00110.Call("SELECT");			
		break ;
/*		
		case 'datchem00110_4':
		    datchem00110.Call("SELECT");			
		break ;

        case 'datchem00110_5':
		     datchem00110.Call("SELECT");		
		break ;
        */
        
	}	
}

function ClearData()
{
    grdElement.ClearData();
    imgEmp.SetDataText('');
    lblEmpName.SetDataText('');
    lblSection.SetDataText('');
    lblTeam.SetDataText('');  
    lblPosition.SetDataText(''); 
    txtWorkPrd.SetDataText('');
    txtDesc.SetDataText('');
    txtarOpiEva1.SetDataText('');
    txtarOpiEvaPos1.SetDataText('');
    txtarOpiEva2.SetDataText('');
    txtarOpiEvaPos2.SetDataText('');
    lblManager1_Name.SetDataText('');
    lblManager2_Name.SetDataText('');
}

    //--------------------------------------------------------------------
    /*
function OnConfirm()
{
    
    if(grdEmp.rows>2)
    {
       if(grdEmp.GetGridData(2,iGRank)!="") 
       {
            if(confirm("Are you sure you want to confirm grade for these staffs ?"))
            {
	            datchem00110_3.Call();
	        }
       }
       else
            alert("Please get result first")
    }
    else
        alert("There is no data to confirm")
    
   
}

function OnUnConfirm()
{
   if(confirm("Are you sure you want to unconfirm grade for these staffs ?")){
	    datchem00110_4.Call();
	}
}

function OnCancel()
{
   if(confirm("Are you sure you want to cancel grade for these staffs ?")){
	    datchem00110_5.Call();
	}
}

*/

function GetOpinionContent(opt){
    if(opt == 1){
        return txtarOpiEva1.GetData();
    }
    else if(opt == 2){
        return txtarOpiEvaPos1.GetData();
    }
    else if(opt == 3){
        return txtarOpiEva2.GetData();
    }
    else if(opt == 4){
        return txtarOpiEvaPos2.GetData();
    }
    else if(opt == 5){
        return grdElement.GetGridData(grdElement.row, col_contents);
    }
}

function SetOpinionContent(opt,content){
    if(opt == 1){
        return txtarOpiEva1.SetDataText(content);
    }
    else if(opt == 2){
        return txtarOpiEvaPos1.SetDataText(content);
    }
    else if(opt == 3){
        return txtarOpiEva2.SetDataText(content);
    }
    else if(opt == 4){
        return txtarOpiEvaPos2.SetDataText(content);
    }
}

//--------------------------------------------------------------------
var oPopup=null;
function OnGridCellClick(obj)
{
    if ( obj.id == "grdElement" && event.col == col_contents )
    {
        OnShowPopup(5);
    }
}

function OnShowPopup(n)
{
    var url = System.RootURL + "/form/ch/em/chem00110_1.aspx";    
    
    switch(n)
    {
        case 1:
            url = url + "?opt=1&yn=N";    
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
        break;
        
        case 2:
            url = url + "?opt=2&yn=N";    
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
        break;
        
        case 3:
            url = url + "?opt=3&yn=N";    
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
        break;
        
        case 4:        
            url = url + "?opt=4&yn=N";    
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
        break;
        
        case 5:
            url = url + "?opt=5&yn=N";    
            var winObj = System.OpenModal(url,700,550,"resizable:yes;status:yes", window);
        break;
    }    
}

var _getoption = true;
function OnChangeOption(){
    _getoption = false;
    datchem00110.Call("SELECT");
}

function OnChangeEvaYear(){
    datchem00050_1.Call();
}

//----------------------------------
function OnToggle()
{
   
        if(img1.status == "expand")
        {
            tr3.style.display="none";
            img1.status = "collapse";
            img1.src = "../../../system/images/up_orange.gif";
            tr1.style.height="70%";
            
        }
        else
        {
            tr3.style.display="";
            img1.status = "expand";
             img1.src = "../../../system/images/down_orange.gif";
            tr1.style.height="60%";
            
        }
   
}
/*
function onGetResult()
{
    
    if(grdEmp.rows>2)
    {
       datchem00050_2.Call();
    }
    else
        alert("There is no data to do")


}
*/
function onPopup(flag)
{
    txtflag.text = flag;
    var i, tmp, nSelected;
    var ctrl = grdEmp.GetGridControl();
    var iflag = false;
    //alert(flag);
    switch(flag)
    {
        case 'RESULT':
            if (grdEmp.rows > 2) {
                datchem00050_2.Call();
            }
            else
                alert("There is no data to do")
            break;

        case 'CONFIRM':
            if (grdEmp.rows > 2) {
                if (grdEmp.GetGridData(2, iGRank) != "") {
                    if (confirm("Are you sure you want to confirm grade for these staffs ?")) {
                        datchem00110_3.Call();
                    }
                }
                else
                    alert("Please get result first")
                //if (ctrl.SelectedRows < 1) {
/*                    
                        if (confirm("Are you sure you want to confirm grade for all of staffs ?")) {
                            for (i = 2; i < ctrl.rows; i++) {
                                if (grdEmp.GetGridData(i, iGRank) == "") {
                                    iflag = true;
                                }
                                grdEmp.SetGridText(i, iGflag, flag);
                                grdEmp.SetRowStatus(i, 16);  //update
                            }
                            if (iflag == true) {
                                alert("Please get result first!");
                                iflag = false;
                            }
                            else
                                datchem00110.Call();
                        }
                    }
                    else {
                        nSelected = ctrl.SelectedRows;
                        //tmp = ctrl.SelectedRow(i);
                        if (confirm("Are you sure you want to confirm grade for " + nSelected + " staffs ?")) {
                            for (i = 0; i < ctrl.SelectedRows; i++) {
                                if (grdEmp.GetGridData(ctrl.SelectedRow(i), iGRank) == "") {
                                    iflag = true;
                                }
                                grdEmp.SetGridText(ctrl.SelectedRow(i), iGflag, flag);
                                grdEmp.SetRowStatus(ctrl.SelectedRow(i), 16);  //update

                            }

                            if (iflag == true) {
                                alert("Please get result first!");
                                iflag = false;
                            }
                            else
                                datchem00110.Call();
                        }
                    }   */

                
            }
            else
                alert("There is no data to confirm");
            
            break;

        case 'UNCONFIRM':

            if (confirm("Are you sure you want to unconfirm grade for these staffs ?")) {
                datchem00110_3.Call();
            }
/*            //if (ctrl.SelectedRows < 1) {
                if (confirm("Are you sure you want to unconfirm grade for all of staffs ?")) {
                    for (i = 2; i < ctrl.rows; i++) {
                        grdEmp.SetGridText(i, iGflag, flag);
                        grdEmp.SetRowStatus(i, 16);  //update
                    }
                    datchem00110.Call();
                }
            }
            else {
                nSelected = ctrl.SelectedRows;

                if (confirm("Are you sure you want to unconfirm grade for " + nSelected + " staffs ?")) {
                    for (i = 0; i < ctrl.SelectedRows; i++) {
                        grdEmp.SetGridText(ctrl.SelectedRow(i), iGflag, flag);
                        grdEmp.SetRowStatus(ctrl.SelectedRow(i), 16);  //update
                        
                    }
                    datchem00110.Call();
                }
            }   */
            break;

        case 'CANCEL':
            if (confirm("Are you sure you want to cancel for these staffs ?")) {
                datchem00110_3.Call();
            }
 /*           //if (ctrl.SelectedRows < 1) {
                if (confirm("Are you sure you want to cancel for all of staffs ?")) {
                    for (i = 2; i < ctrl.rows; i++) {
                        
                        grdEmp.SetGridText(i, iGflag, flag);
                        grdEmp.SetRowStatus(i, 16);  //update
                    }
                    
                    datchem00110.Call();
                }
            }
            else {
                nSelected = ctrl.SelectedRows;
                if (confirm("Are you sure you want to cancel for " + nSelected + " staffs ?")) {
                    for (i = 0; i < ctrl.SelectedRows; i++) {
                        
                        grdEmp.SetGridText(ctrl.SelectedRow(i), iGflag, flag);
                        grdEmp.SetRowStatus(ctrl.SelectedRow(i), 16);  //update

                    }
                    
                    datchem00110.Call();
                }
            }   */
            break;
    }

    //datchem00110.Call("SELECT");

}

</script>
<body>
    <!------------------------------------------------------------------------------>
    <gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_get_emp_info_chem00060" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="lblEmpName"/>
                    <output bind="lblSection" />          
                    <output bind="lblTeam" />
                    <output bind="txtPhoto_PK" />
                    <output bind="lblPosition" /> 
                    <output bind="txtWorkPrd" />                                                                
                </output>
            </dso> 
        </xml> 
</gw:data>
<!---------------------------------------------------------------------------------->
<gw:data id="datGetOption" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="sp_sel_get_to_option" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtTotalEmp" />
                </input> 
                <output>                    
                    <output bind="lstTOEmpOpt" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------------>
    <gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem00050_1" > 
                <input>
                    <input bind="lstYear" /> 
					<input bind="txtCompany" /> 
                </input> 
                <output>
                    <output bind="txtEvaPrd" />
                    <output bind="txtSchedule" />
                    <output bind="txtGrdEvaType" />
                    <output bind="txtEvaTimes" />
                  	<output bind="txtTotEmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------------------------------>
    <gw:data id="datchem00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem00050_2" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstTOEmpOpt" />
					<input bind="lstEvaTimes" />
					<input bind="lstEvaluationGrp" />
                </input> 
                <output>
                    <output bind="txttmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <!------------------------------------------------------------------------------>
    <gw:data id="datchem00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,17,19,20,21,22,23,24" function="sp_sel_chem0110" procedure="sp_upd_chem0110"> 
                <input bind="grdEmp" >
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstTOEmpOpt" />
					<input bind="lstEvaTimes" />
					<input bind="lstEvaluationGrp" />
                   </input>
                <output  bind="grdEmp" />
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------------------>
    <gw:data id="datchem00110_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="sp_sel_chem0110_1" >
                <input bind="grdElement" >
                    <input bind="txtthr_eva_emp_reviewer" />
					<input bind="txtLanguage" />
                   </input>
                <output  bind="grdElement" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem000100_6" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="control" parameter="0,1,2,3,4" function="sp_sel_chem000100_6" procedure=""> 
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

<gw:data id="datchem000110_7" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem000110_7" > 
            <input>
                <input bind="txtMana1_PK" />
                <input bind="txtMana2_PK" />
                <input bind="txt_thr_eva_emp_pk" />
            </input>
	       <output>	            
	            <output bind="lblManager1_Name" />
	            <output bind="lblManager2_Name" />
	       </output>
        </dso> 
    </xml> 
</gw:data>
    
    <!------------------------------------------------------------------------------>
    <gw:data id="datchem00110_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0110_4" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstTOEmpOpt" />
					<input bind="lstEvaTimes" />
					<input bind="lstEvaluationGrp" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>

 <gw:data id="datchem00110_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0110_5" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstTOEmpOpt" />
					<input bind="lstEvaTimes" />
					<input bind="lstEvaluationGrp" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datchem00110_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0110_1" > 
                <input>
                    <input bind="txtflag" />
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstTOEmpOpt" />
					<input bind="lstEvaTimes" />
					<input bind="lstEvaluationGrp" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <!------------------------------------------------------------------------------>
    <table border="1" height="100%" width="100%" cellpadding="0" cellspacing="0">
        <tr style="height: 10%">
            <td colspan="2">
                <table border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
                    <tr valign="top">
                        <td style="width: 10%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 14%"></td>
                        <td style="width: 17%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 9%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 10%"></td>
                    </tr>
                    <tr style="height: 50%;" valign="middle">
                        <td align="right" style="border-top: 1">Eva. #&nbsp;</td>
                        <td align="left" style="border-top: 1"><gw:list id="lstYear" styles="width:100%" onchange="OnChangeEvaYear()" />                        </td>
                        <td align="right" style="border-top: 1">Evaluation Period&nbsp;</td>
                        <td style="border-top: 1"><gw:textbox id="txtEvaPrd" styles="width:100%" readonly="true"  /></td>                    </td>
                        <td align="right">Eva. Times&nbsp;</td>
                        <td align="left"><gw:list id="lstEvaTimes" styles="width:100%"  onchange="OnSearch('1')" /></td>
                        <td colspan="4">
                            <table width="100%">
                            <tr>
                            <td align="right" >Group</td>
                            <td width="100">
                               <gw:list id="lstEvaluationGrp" styles="width:100%" onchange="datchem00110.Call('SELECT');" />
                            </td>
                            <td align="center"><gw:label id="lblTotEmp" text="T/O 10 Employees Option" /></td>
                            </tr>
                            </table>
                        </td>
                        
                        
                    </tr>
                    <tr style="height: 50%" valign="middle">
                        <td align="right">Grade Eva. Type&nbsp;</td>
                        <td align="left"><gw:textbox id="txtGrdEvaType" readonly="true" styles="width:100%" /></td>
                        <td align="right">Schedule&nbsp;</td>
                        <td><gw:textbox id="txtSchedule" readonly="true" styles="width:100%"  /></td>
                        <td align="right">Option&nbsp;</td>
                  		<td align="left"><gw:list id="lstTOEmpOpt" styles="width:100%" onchange="OnChangeOption()" ></gw:list></td>
                        <td align="center"><gw:icon id="idBtnResult" text="Get Result" img="in" onclick="onPopup('RESULT')" /></td> <!--onGetResult()-->
                        <td align="center"><gw:icon id="idBtnConfirm" text="Confirm" img="in" onclick="onPopup('CONFIRM')" /></td>
                        <td align="center"><gw:icon id="idBtnUnConfirm"  text="Unconfirm" img="in" onclick="onPopup('UNCONFIRM')" /></td>
                        <td align="center"><gw:icon id="idBtnCancel"  text="Cancel" img="in" onclick="onPopup('CANCEL')" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="tr1" style="height: 60%">
            <td colspan="2"><gw:grid id='grdEmp' 
            header='_thr_eva_emp_pk|Organization|EMP ID|Name|Eva Time|Eva Date|Total|A-Score|C-Score|Rank|Grade|A-Rank|A-Grade|C-Rank|C-Grade|_opinion_eva|_opinion_position|_thr_employee_pk|status|_thr_eva_emp_reviewer_pk|_master_pk|_eva_level|_option_seq|_eva_group_pk|_flag|_reviewer_status'
                    format='0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    aligns='0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0' 
                    defaults='|||||||||||||||||||||||||'
                    editcol='0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    widths='0|1700|1000|2500|1200|1200|700|700|700|700|700|700|700|700|700|700|700|700|700|700|0|0|0|0|0|0'
                    styles='width:100%; height:100%' 
                    sorting="T"
                    acceptnulldate="T" oncellclick="OnSearch('2')" editcolcolor="true"/>
            </td>
        </tr>
        <tr id="tr2" style="height: 10%">
            <td colspan="2">
                <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 0%">
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 2%">
                        </td>
                        <td style="width: 78%">
                        </td>
                    </tr>
                    <tr>
                        <td><img status="expand" id="img1" src="../../../system/images/down_orange.gif" style="cursor:hand;position:absolute;left:4;top:10;" onclick="OnToggle()"  />
                        </td>
                        <td align="left">
                            <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130" />
                        </td>
                        <td>
                        </td>
                        <td colspan="1">
                            <gw:grid id='grdElement' 
                            header='Seq|Type|Name|Contents|Weight|1st Score|2nd Score|_Mana1|_Mana2' 
                            format='0|0|0|0|0|0|0|0|0'
                                aligns='2|0|0|0|3|3|3|0|0' defaults='||||||||' editcol='0|0|0|0|0|0|0|0|0' widths='500|1500|1500|4200|700|1000|700|0|0|0|0'
                                styles='width:100%; height:100%; ' oncellclick="OnGridCellClick(this)" editcolcolor="true" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="tr3" style="height: 27%">
            <td style="width: 20%">
                <table width="100%" height="100%" cellpadding="0" cellspacing="0">
                    <tr height="10%">
                    	<td></td>
                    </tr>
                    <tr style="height: 12%" valign="top">
                        <td><b><gw:label id="lblEmpName" /></b></td>
                    </tr>
                    <tr style="height: 12%">
                        <td align="left"><b><gw:label id="lblSection" /></b></td>
                    </tr>
                    <tr style="height: 12%">
                        <td align="left"><b><gw:label id="lblTeam" /></b></td>
                    </tr>
                    <tr style="height: 12%">
                        <td align="left"><b><gw:label id="lblPosition" /></b></td>
                    </tr>
                    <tr style="height: 12%">
                        <td align="left"><gw:label id="txtWorkPrd" text="" style="width: 100%; display: none" /></td>
                    </tr>
                    <tr style="height: 12%">
                        <td align="center"><gw:label id="txtDesc" text="" styles="width:100%; display:none; " /></td>
                    </tr>
                    <tr height="18%">
                    	<td></td>
                    </tr>
                </table>
            </td>
            <td style="width: 73%">
                <table width="100%" height="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 20%"></td>
                        <td style="width: 40%"></td>
                        <td style="width: 40%"></td>
                    </tr>
                    <tr>
                        <td align="center">Level</td>
                        <td align="left">
                        	<table width="100%">
                            	<tr>
                                	<td width="50%" align="left">Opinion on Evaluation&nbsp;</td>
                                    <td width="50%" align="right"><b style="color: #1b2ff2; cursor: hand" onClick="OnShowPopup(1)">Detail&nbsp; </b></td>
                                </tr>
                            </table>
                        </td>
                        <td align="left">
                        	<table width="100%">
                            	<tr>
                                	<td width="50%" align="left">Opinion on Assignment of Position&nbsp;</td>
                                    <td width="10%" align="right"><b style="color: #1b2ff2; cursor: hand" onClick="OnShowPopup(2)">Detail&nbsp; </b></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">1st <gw:label id="lblManager1_Name" text=""/>&nbsp;</td>
                        <td align="left"><gw:textarea id="txtarOpiEva1" rows="4" styles="width:100%" ondblclick="" /></td>
                        <td align="left"><gw:textarea id="txtarOpiEvaPos1" rows="4" styles="width:100%" ondblclick=""/></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="right"><a style="color: #1b2ff2; cursor: hand" onClick="OnShowPopup(3)">Detail &nbsp; </a></td>
                        <td align="right"><a style="color: #1b2ff2; cursor: hand" onClick="OnShowPopup(4)">Detail &nbsp; </a></td>
                    </tr>
                    <tr>
                        <td align="center">2nd <gw:label id="lblManager2_Name" text=""/>&nbsp;</td>
                        <td align="left"><gw:textarea id="txtarOpiEva2" rows="4" styles="width:100%"  ondblclick=""/></td>
                        <td align="left"><gw:textarea id="txtarOpiEvaPos2" rows="4" styles="width:100%" ondblclick=""/></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-------------------------------------------------------------------------------->
     
    
    <gw:datebox id="dtToday" lang="1" style="display: none;" />
   <gw:textbox id="txttmp" style="display: none;" />
    <gw:textbox id="txtLOGGED_EMP_PK" style="display: none;" />
    <gw:textbox id="txtthr_eva_emp_reviewer" style="display: none;" />
    <gw:textbox id="txtEmp_PK" style="display: none;" />
    <gw:textbox id="txtPhoto_PK" style="display: none;" />
    <gw:textbox id="txtReturn" style="display: none;" />
    <gw:textbox id="txtEvaTimes" style="display: none;" />
    <gw:textbox id="txtTotEmp" style="display: none;" />
    <gw:list id="txtCompany" style="display: none;" />
    <gw:textbox id="txtLanguage" style="display: none;" />
    <gw:textbox id="txtTotalEmp" style="display: none;" />
	<gw:textbox id="txtInfoTemp_1" style="display: none;" />
	<gw:textbox id="txtInfoTemp_2" style="display: none;" />
	<gw:textbox id="txtInfoTemp_3" style="display: none;" />
	<gw:textbox id="txtInfoTemp_4" style="display: none;" />
	<gw:textbox id="txtMana1_PK" style="display:none" />
    <gw:textbox id="txtMana2_PK" style="display:none" />
	<gw:textbox id="txt_eva_emp_reviewer_pk" style="display: none;" />
	<gw:textbox id="txt_thr_eva_emp_pk" style="display: none;" />
    <gw:textbox id="txtflag" style="display:none" />
</body>
</html>
