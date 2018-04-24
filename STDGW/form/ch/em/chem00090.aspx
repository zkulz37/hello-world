<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Confirm Evaluation Grade (Manager - MBO)</title>
</head>

<script>
    var  user_pk 	= "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name 	= "<%=Session("USER_NAME")%>" ;
    var  user_id 	= "<%=Session("USER_ID")%>" ;
	var v_company_pk = "<%=Session("COMPANY_PK")%>";
	var v_language = "<%=Session("SESSION_LANG")%>";
	var g_confirm = false ;
	var g_show_2nd_reviewer = false ;
// grdEmp
var iG_thr_eva_emp_pk	= 0,
	iG_Department				= 1,
	iG_EMP_ID					= 2,
	iG_Name						= 3,
	iG_Evaluated_Time			= 4,
	iG_Evaluated_Date			= 5,
	iG_Total					= 6,
	iG_A						= 7,
	iG_C						= 8,
	iG_Rank						= 9,
	iG_Grade					= 10,
	iG_eva_opi					= 11,
	iG_eva_position				= 12,
	iG_self_opi_evaluation		= 13,
	iG_self_opi_position		= 14,
	iG_thr_employee_pk			= 15,
	iG_thr_eva_emp_reviewer_pk	= 16,
	iG_status					= 17,
	iG_reviewer_1 				= 18,
	iG_reviewer_2				= 19,
	iG_Manager_PK				= 20;
    iG_emp_eva_status			= 21;
    
// 	grdElement
	iG2_Type					= 0,
	iG2_Name					= 1,
	iG2_MBO_Weight			    = 2,
	iG2_Self_Score				= 3,
	iG2_1st_Score				= 4,
	iG2_2nd_Score				= 5,
	iG2_MBO_Plan				= 6,
	iG2_MBO_Result				= 7,
	iG2_Desc					= 8,
	iG2_Unit					= 9,
	iG2_Present					= 10,
	iG2_Target					= 11,
	iG2_Result					= 12,
	iG2_manager1_pk				= 13,
	iG2_manager2_pk				= 14,
	iG2_E_weight				= 15;
	
//----------------------------------------------------------------------------
var oPopup=null;
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
//----------------------------------------------------------------------------
function GetOpinionContent(opt){
    if(opt == 1){
        //return txtInfo3.GetData();
    }
    else if(opt == 2){
        //return txtarSelfOpiEvalPos.GetData();
    }
    else if(opt == 3){
        return txtInfo3.GetData();
    }
    else if(opt == 4){
        return txtInfo4.GetData();
    }
	else if(opt == 5){
		return txtInfo5.GetData();
	}
	else if(opt == 6){
		return txtInfo6.GetData();
	}
}
//----------------------------------------------------------------------------
function SetOpinionContent(opt,content){
    if(opt == 1){
        //return txtInfo3.SetDataText(content);
    }
    else if(opt == 2){
        //return txtarSelfOpiEvalPos.SetDataText(content);
    }
    else if(opt == 3){
       return txtInfo3.SetDataText(content);
    }
    else if(opt == 4){
        return txtInfo4.SetDataText(content);
    }
    else if(opt == 5){
        return txtInfo5.SetDataText(content);
    }
    else if(opt == 6){
        return txtInfo6.SetDataText(content);
    }
}
//--------------------------------------------------------------------
function OnShowPopup(opt){//show same with toolstrip <- textarea
    if(opt == 1){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo1"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 2){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo2"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 3){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo3"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 4){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo4"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 5){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo5"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 6){
		var path = System.RootURL + "/form/ch/em/chem00090_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo6"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 7){
		if(event.col == iG2_MBO_Plan || event.col == iG2_MBO_Result )
		{
			var path = System.RootURL + "/form/ch/em/chem00080_popup_2.aspx?write_yn=N"  ;
			var object = System.OpenModal( path ,700 , 500 ,  'resizable:yes;status:yes', window);        					
		}	
    }
}
//--------------------------------------------------------------------
function BodyInit()
{  
    System.Translate(document);
    BindingData();     	
    //idBtnUnConfirm.SetEnable(false);
	datchem00050_1_N.Call();		
}

function BindingData()
{
	var ls_data = "";
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and close_yn = 'N' order by 2 desc")%>";
    lstYear.SetDataText(ls_data);
	ls_data = "<%=ESysLib.SetListDataSQL("select a.code, a.code_nm from thr_code_detail a, thr_code_master b where a.del_if=0 and b.del_if = 0 and  a.thr_code_master_pk = b.pk and b.id = 'HR0105' AND a.code not in (0) ")%>"	
	lstEvaTimes.SetDataText(ls_data);
	txtLOGGED_EMP_PK.text = user_pk ;
    <%=ESysLib.SetGridColumnComboFormat("grdEmp", 10,"select A.CODE, A.CODE CODE_NM FROM THR_CODE_detail A, thr_code_master B WHERE A.DEL_IF=0 AND A.thr_code_master_pk = B.PK and B.ID = 'HR0101' and A.CODE in('S','A','B') order by a.seq asc")%>;
	txtCompany.text = v_company_pk;
	imgEmp.SetEnable(false);
	
	txtInfo1.SetReadOnly(true);
	txtInfo2.SetReadOnly(true);
	txtInfo3.SetReadOnly(true);
	txtInfo4.SetReadOnly(true);
	txtInfo5.SetReadOnly(true);
	txtInfo6.SetReadOnly(true);	

	/*
	if(user_id == "s.nam" || user_id == "jy.kim"){
		lstEvaTimes.value = '2';
	}*/
	
	txtLanguage.text = v_language;
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
    l_fg.Cell(13, 1, 0, 1, l_fg.Cols - 1) = true ;    
    l_fg.MergeCells = 5;
    l_fg.MergeRow(0) = true;   
    l_fg.MergeCol(iG_Department) = true ;            
    l_fg.Cell(0, 0, iG_Department, 1, iG_Department) = 'Organization';
	
	l_fg.MergeCol(iG_EMP_ID) = true ;               
	l_fg.Cell(0, 0, iG_EMP_ID, 1, iG_EMP_ID) = 'EMP ID';
	
	l_fg.MergeCol(iG_Name) = true ;               
	l_fg.Cell(0, 0, iG_Name, 1, iG_Name) = 'Name';
	
	l_fg.MergeCol(iG_Evaluated_Time) = true ;               
	l_fg.Cell(0, 0, iG_Evaluated_Time, 1, iG_Evaluated_Time) = 'Evaluated Time';
	
	l_fg.MergeCol(iG_Evaluated_Date) = true ;               
	l_fg.Cell(0, 0, iG_Evaluated_Date, 1, iG_Evaluated_Date) = 'Evaluated Date';
            
	l_fg.Cell(0, 0, iG_Total, 0, iG_thr_eva_emp_reviewer_pk) = 'Score';
	
	l_fg.Cell(0, 1, iG_Total, 1, iG_Total) = 'Total';
	l_fg.Cell(0, 1, iG_A, 1, iG_A) = 'A';
	l_fg.Cell(0, 1, iG_C, 1, iG_C) = 'C';
	l_fg.Cell(0, 1, iG_Rank, 1, iG_Rank) = 'Rank';
	l_fg.Cell(0, 1, iG_Grade, 1, iG_Grade) = 'Grade';	
}

function OnMergeHeader2()
{
	// grdElement
	var l_grdElement = grdElement.GetGridControl();
	if(grdElement.rows == 1)
	{
		grdElement.AddRow();
	}
	l_grdElement.FixedRows = 2; 
    l_grdElement.Cell(13, 1, 0, 1, l_grdElement.Cols - 1) = true ;    
    l_grdElement.MergeCells = 5;
    l_grdElement.MergeRow(iG2_Type) = true;   
	l_grdElement.MergeCol(iG2_Type) = true ;
	l_grdElement.Cell(0, 0, iG2_Type, 1, iG2_Type) = 'Type';
	l_grdElement.MergeCol(iG2_Name) = true ;
	l_grdElement.Cell(0, 0, iG2_Name, 1, iG2_Name) = 'Name';
	l_grdElement.MergeCol(iG2_MBO_Weight) = true ;
	l_grdElement.Cell(0, 0, iG2_MBO_Weight, 1, iG2_MBO_Weight) = 'MBO Weight';
	
	l_grdElement.Cell(0, 0,iG2_Self_Score, 0, iG2_2nd_Score) = 'Score';
	l_grdElement.Cell(0, 1,iG2_Self_Score, 1, iG2_Self_Score) = 'Self Score';
	l_grdElement.Cell(0, 1,iG2_1st_Score, 1, iG2_1st_Score) = '1St Score';
	l_grdElement.Cell(0, 1,iG2_2nd_Score, 1, iG2_2nd_Score) = '2nd Score';
	
	l_grdElement.MergeCol(iG2_MBO_Plan) = true ;
	l_grdElement.Cell(0, 0, iG2_MBO_Plan, 1, iG2_MBO_Plan) = 'MBO Plan';
	
	l_grdElement.MergeCol(iG2_MBO_Result) = true ;
	l_grdElement.Cell(0, 0, iG2_MBO_Result, 1, iG2_MBO_Result) = 'MBO Result';		
	
	l_grdElement.Cell(0, 0, iG2_Desc, 0, iG2_Result) = 'Indicator';
	l_grdElement.Cell(0, 1, iG2_Desc, 1, iG2_Desc) = 'Desc';
	l_grdElement.Cell(0, 1, iG2_Unit, 1, iG2_Unit) = 'Unit';
	l_grdElement.Cell(0, 1, iG2_Present, 1, iG2_Present) = 'Present';
	l_grdElement.Cell(0, 1, iG2_Target, 1, iG2_Target) = 'Target';
	l_grdElement.Cell(0, 1, iG2_Result, 1, iG2_Result) = 'Result';
}

function OnSearch(iCase)
{
	var l_row, l_thr_eva_emp_reviewer_pk = "", l_Emp_ID = "", l_Eva_Time = "", l_opi_eva = "", l_opi_position = "";
	var ctrl = grdElement.GetGridControl();
	var l_manager_pk = "";
	l_row = grdEmp.row ;
	switch(iCase)
	{
		case '1':
		break;
		case '2':
			lblDesc.SetDataText("");
			txtInfo1.SetDataText("");
			txtInfo2.SetDataText("");
			txtInfo3.SetDataText("");
			txtInfo4.SetDataText("");
			txtInfo5.SetDataText("");
			txtInfo6.SetDataText("");
					
			lbl1stReviewer.text = "1st Reviewer";
			lbl2ndReviewer.text = "2nd Reviewer";			
			
			l_thr_eva_emp_reviewer_pk = grdEmp.GetGridData(l_row, iG_thr_eva_emp_pk);
			txtthr_eva_emp_reviewer_pk.text = l_thr_eva_emp_reviewer_pk; 
			// SHOW Opinion on Evaluation, Assignment of Position		
			l_Emp_ID = grdEmp.GetGridData(l_row, iG_EMP_ID);
			l_Eva_Time = grdEmp.GetGridData(l_row, iG_Evaluated_Time);
			l_opi_eva = grdEmp.GetGridData(l_row, iG_eva_opi);
			l_opi_position = grdEmp.GetGridData(l_row, iG_eva_position);
			l_manager_pk = grdEmp.GetGridData(l_row, iG_Manager_PK);
			var l_self_opi_eva = grdEmp.GetGridData(l_row, iG_self_opi_evaluation);
			var l_self_opi_eva_pos = grdEmp.GetGridData(l_row, iG_self_opi_position);
			if(l_Eva_Time == '1')
			{
				if(user_pk == l_manager_pk)
				{
					g_show_2nd_reviewer = false;
					ctrl.ColWidth(iG2_2nd_Score) = 0;
					txtInfo5.SetDataText("");
					txtInfo6.SetDataText("");
				}
					
				txtInfo3.SetDataText(l_opi_eva);
				txtInfo4.SetDataText(l_opi_position);
				lbl1stReviewer.text = "1st Reviewer<br>" + grdEmp.GetGridData(l_row, iG_reviewer_1);
				if(grdElement.rows > 2)
					grdElement.SetCellBgColor(1, iG2_1st_Score, grdElement.rows - 1, iG2_1st_Score, 0xCCFFFF);
				txtInfo3.GetControl().style.backgroundColor    = 0xFFFFCC;
				txtInfo4.GetControl().style.backgroundColor    = 0xFFFFCC;
				txtInfo5.GetControl().style.backgroundColor 	= 0xFFFFFF;
				txtInfo6.GetControl().style.backgroundColor 	= 0xFFFFFF;
			}
			else if(l_Eva_Time == '2')
			{
				if(user_pk == l_manager_pk)
				{
					g_show_2nd_reviewer = true;
					ctrl.ColWidth(iG2_2nd_Score) = 1000;
				}				
				txtInfo5.SetDataText(l_opi_eva);
				txtInfo6.SetDataText(l_opi_position);					
				lbl2ndReviewer.text = "2nd Reviewer<br>" + grdEmp.GetGridData(l_row, iG_reviewer_2);
				txtInfo3.GetControl().style.backgroundColor = 0xFFFFFF;
				txtInfo4.GetControl().style.backgroundColor = 0xFFFFFF;
				txtInfo5.GetControl().style.backgroundColor = 0xFFFFCC;
				txtInfo6.GetControl().style.backgroundColor = 0xFFFFCC;				
			}			
			txtEmp_PK.text = grdEmp.GetGridData(l_row, iG_thr_employee_pk);		
			var l_status = grdEmp.GetGridData(l_row, iG_status);
			if(l_status == '30')
			{
				idBtnGetRank.SetEnable(false);
				//idBtnConfirm.SetEnable(false);
			}
			else
			{
				idBtnGetRank.SetEnable(true);
				//idBtnConfirm.SetEnable(true);			
			}				
			dat_get_emp_info_chem00060.Call();
		break;
	}
}

function OnDataReceive(iObj)
{
	var l_EvaTimes_Code = '';
	switch(iObj.id)
	{
		case 'datchem00050_1_N':
			if(txtGrdEvaType.text == 'FINAL LEVEL')
			{
				lstEvaTimes.SetEnable(false);
			}
			else if(txtGrdEvaType.text == 'EACH LEVEL')
			{
				lstEvaTimes.SetEnable(true);
				if(lstEvaTimes.value == '0')
					lstEvaTimes.value = '1';
			}	

            if(lstEvaTimes.value=='1')
                idBtnCancel.SetEnable(false);
            else
                idBtnCancel.SetEnable(true);
                		
			datchem00090.Call('SELECT');
		break ;

        case 'datGetRank':
            alert("Get Rank Result finish!")
			datchem00090.Call('SELECT');
		    break ;
	    case 'datchem00090':
			if(g_confirm)
			{
				g_confirm = false ;
				datchem00090_3.Call();
			}
			OnMergeHeader();
			//lblTotEmp.text = "T/O " + Number(grdEmp.rows - 2) + " Employees Option";						
			HightLightConfirmStatus();			
		break ;
		case 'dat_get_emp_info_chem00060':
	        imgEmp.SetDataText(txtPhoto_PK.text);
			lblEmpName.text = "" + "  " + lblEmpName.text ;
			txtSection.text = " Organization:  " + " " + txtSection.text;
			txtTeam.text = " Group :  " + txtTeam.text ;
			txtPosition.text = " Position:  " + txtPosition.text;			
			if(grdEmp.row > 1)
			{
				if(Trim(grdEmp.GetGridData(grdEmp.row, iG_status)) == "30")
                {
					idBtnConfirm.SetEnable(false);
                }
                else
                {
					idBtnConfirm.SetEnable(true);
                    
                }
			}								
			datchem00090_1.Call('SELECT');
		break ;
		case 'datchem00090_3':
			alert(txtReturn.text);
			datchem00090.Call("SELECT");
		break ;
		case 'datchem00090_1':
			var l_manager1_pk = '';
			var l_manager2_pk = '';
			var l_eva_times;
			OnMergeHeader2();
			if(grdEmp.row > 0)
			{
				l_eva_times = grdEmp.GetGridData(grdEmp.row, iG_Evaluated_Time);
			}				
			if(grdElement.rows > 2)
			{			
				l_manager1_pk = grdElement.GetGridData(2, iG2_manager1_pk);
				l_manager2_pk = grdElement.GetGridData(2, iG2_manager2_pk);
				if(l_manager1_pk == user_pk && l_eva_times == '1') //reviewer level : 1
				{
					if(grdElement.rows > 2)
						grdElement.SetCellBgColor(2, iG2_1st_Score, grdElement.rows - 1, iG2_1st_Score, 0xCCFFFF);					
				}
				else if(l_manager2_pk == user_pk && l_eva_times == '2') //reviewer level : 2
				{
					if(grdElement.rows > 2)
						grdElement.SetCellBgColor(2, iG2_2nd_Score, grdElement.rows - 1, iG2_2nd_Score, 0xCCFFFF);									
				}
			}				
		break ;
		case 'datchem00110_4':
		    datchem00090.Call("SELECT");			
		break ;

        case 'datCancel':
            alert(txtReturn.text);
		    datchem00090.Call("SELECT");			
		break ;
        
	}
}
//--------------------------------------------------------------
function HightLightConfirmStatus(){
	var l_cnt = 0;
    var l_level=0;
    var l_emp_eva_status="10";
	
    for(var i = 2; i < grdEmp.rows; i++)
    {
        if(Trim(grdEmp.GetGridData(i, iG_status)) == "30")
        {
            grdEmp.SetCellBgColor(i, 0, i, grdEmp.cols - 1, 0X7AA0FF);						
			l_cnt += 1;			
        }
        l_level=grdEmp.GetGridData(i, iG_Evaluated_Time);
        l_emp_eva_status=grdEmp.GetGridData(i, iG_emp_eva_status);
    }

	if(l_cnt == grdEmp.rows - 2 && l_cnt > 0)
	{
		idBtnConfirm.SetEnable(false);
		idBtnGetRank.SetEnable(false);

        if(l_level=="2")
            idBtnUnConfirm.SetEnable(true);
        else if(l_level=="1" && Number(l_emp_eva_status)<=40)
            idBtnUnConfirm.SetEnable(true);
        else
            idBtnUnConfirm.SetEnable(false);
	}
    else
    {
        
        idBtnConfirm.SetEnable(true);
		idBtnGetRank.SetEnable(true);
        idBtnUnConfirm.SetEnable(false);
    }

    if(grdEmp.rows<=2) //ko co du lieu
    {
        idBtnConfirm.SetEnable(false);
		idBtnGetRank.SetEnable(false);
        idBtnUnConfirm.SetEnable(false);
        idBtnCancel.SetEnable(false);
    }
}
//----------------------------------------------------------------------------
function OnConfirm()
{
	if(CheckScore())
		if(confirm("Are you sure you want to confirm score of this employee? (after you confirmed, you couldn't modify information more.)"))
		{
			OnSave();
			g_confirm = true;			
		}			
}
function OnUnConfirm()
{
   if(confirm("Are you sure you want to unconfirm grade for these staffs ?")){
	    datchem00110_4.Call();
	}
}
//----------------------------------------------------------------------------
function OnSave()
{
	datchem00090.Call();
}

function Get_Rank()
{
    
	datGetRank.Call();

}

//----------------------------------------------------------------------------
function OnChangeEvaTimes() 
{
	if(txtGrdEvaType.text == 'EACH LEVEL')
	{
		if(lstEvaTimes.value == '0')
		{
			alert('You cannot select Evaluation Time is ALL, only select 1 or 2...');
			lstEvaTimes.value = '1';
			return;
		}
	}

    if(lstEvaTimes.value=='1')
         idBtnCancel.SetEnable(false);
    else
         idBtnCancel.SetEnable(true);

	datchem00090.Call("SELECT");
	grdElement.ClearData();
	txtInfo1.SetDataText("");
	txtInfo2.SetDataText("");
	txtInfo3.SetDataText("");
	txtInfo4.SetDataText("");
	txtInfo5.SetDataText("");
	txtInfo6.SetDataText("");
	lblDesc.SetDataText("")
	
	lbl1stReviewer.text = "1st Reviewer";
	lbl2ndReviewer.text = "2nd Reviewer";
	imgEmp.SetDataText("");
	lblEmpName.text = "";
	txtSection.text = ""; 
	txtTeam.text = ""; 
	txtPosition.text = "";  
	txtWorkPrd.text = "";
}
//----------------------------------------------------------------------------
function CheckScore()
{
	var i;
	if(grdEmp.rows <= 2)
		return false ;
	for(i = 2; i < grdEmp.rows; i ++)
	{
		if(Number(grdEmp.GetGridData(i, iG_Total)) == 0)
		{
			alert('Total cannot be empty, must be greater than 0...');
			return false;
		}
		else if(Number(grdEmp.GetGridData(i, iG_A)) == 0)	
		{
			alert('A Score cannot be empty, must be greater than 0...');
			return false;
		}
		else if(Number(grdEmp.GetGridData(i, iG_C)) == 0)	
		{
			alert('C Score cannot be empty, must be greater than 0...');
			return false;
		}
		else if(Number(grdEmp.GetGridData(i, iG_Rank)) == 0)	
		{
			alert('Rank cannot be empty, must be greater than 0...');
			return false;
		}
		else if(Trim(grdEmp.GetGridData(i, iG_Grade)) == "")	
		{
			alert('Grade cannot be empty, must select grade in list...');
			return false;
		}					
	}
	return true;
}
//----------------------------------------------------------------------------
function OnGridCellClick(obj){
   
    if(obj.id == "grdElement" ){
        var l_mbo_plan = obj.GetGridData(event.row, iG2_MBO_Plan);
		var l_mbo_result = obj.GetGridData(event.row, iG2_MBO_Result);
		txtInfo1.SetDataText(l_mbo_plan);
		txtInfo2.SetDataText(l_mbo_result);		
	var l_desc = "";	
	l_desc = "Element: ";
	l_desc = l_desc + grdElement.GetGridData(event.row, iG2_Type) + " " + grdElement.GetGridData(event.row, iG2_Name) + " Weight: " + grdElement.GetGridData(event.row, iG2_MBO_Weight) + "/" + grdElement.GetGridData(event.row, iG2_E_weight) + " Indicator: ";
	l_desc += grdElement.GetGridData(event.row, iG2_Desc) + " " ;
	l_desc += "Present " ;
	l_desc += grdElement.GetGridData(event.row, iG2_Present) + "%, " ;
	l_desc += "Target " + grdElement.GetGridData(event.row, iG2_Target) + "%, " ;
	l_desc += "Result " + grdElement.GetGridData(event.row, iG2_Result) + "%, " ;
	l_desc += "Score " + grdElement.GetGridData(event.row, iG2_Self_Score) ;	
	lblDesc.text = l_desc;
		
    }
}
//----------------------------------------------------------------------------
function OnChangeEvaNo()
{
	datchem00050_1_N.Call();
	grdElement.ClearData();
	txtInfo1.SetDataText("");
	txtInfo2.SetDataText("");
	txtInfo3.SetDataText("");
	txtInfo4.SetDataText("");
	txtInfo5.SetDataText("");
	txtInfo6.SetDataText("");
	lblDesc.SetDataText("")
	lbl1stReviewer.text = "1st Reviewer";
	lbl2ndReviewer.text = "2nd Reviewer";
	imgEmp.SetDataText("");
	lblEmpName.text = "";
	txtSection.text = ""; 
	txtTeam.text = ""; 
	txtPosition.text = "";  
	txtWorkPrd.text = "";
}	
//-------------------------------------------------------------------------------
function OnClick_Confirm()
{
	var l_status ;
	if(grdEmp.row < 2)
		return ;
	else
	{	
		if(grdEmp.GetGridData(2, iG_status) == "30")
			grdEmp.row = 0;
	}		
}
//-------------------------------------------------------------------------------
function  GetMBOPlan()
{
	return txtInfo1.GetData();
}
//-------------------------------------------------------------------------------
function GetOpinionEva_1St()
{
	return txtInfo3.GetData();
}
//-------------------------------------------------------------------------------
function GetOpinionEva_2nd()
{
	return txtInfo5.GetData();
}
//-------------------------------------------------------------------------------
function GetOpinionPos_1St()
{
	return txtInfo4.GetData();
}
//-------------------------------------------------------------------------------
function GetOpinionPos_2nd()
{
	return txtInfo6.GetData();
}
//-------------------------------------------------------------------------------
function GetMBO()
{
	return grdElement.GetGridData(grdElement.row, iG2_MBO_Plan);
}
//--------------------------------------------------------------
function GetMBOResult_2()
{
	return grdElement.GetGridData(grdElement.row, iG2_MBO_Result);
}
//--------------------------------------------------------------
function GetMBOResult()
{
	return txtInfo2.GetData();
}

function OnCanCel()
{
    //alert(grdEmp.rows);
    if(grdEmp.rows>2 && lstEvaTimes.value=='2')
    {
        if(confirm("Do you want to cancel?"))
        {
            datCancel.Call();
        }
    }
}

//--------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------------>
<gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_get_emp_info_chem00060" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="lblEmpName"/>
                    <output bind="txtSection" />          
                    <output bind="txtTeam" />
                    <output bind="txtPhoto_PK" />
                    <output bind="txtPosition" /> 
                    <output bind="txtWorkPrd" />                                                                
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------------>
<gw:data id="datchem00050_1_N" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem00050_1_N" > 
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
                    <output bind="lstEvaTimes" />                                    
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------------------------------>
<gw:data id="datGetRank" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0090_5" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />					
					<input bind="lstEvaTimes" />
                </input> 
                <output>
                    <output bind="txtReturn" />                  
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------------------------------>
<gw:data id="datchem00090" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="grid" parameter="10,16" function="sp_sel_chem0090" procedure="sp_upd_chem0090" > 
                <input bind="grdEmp" >
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />					
					<input bind="lstEvaTimes" />
                   </input>
                <output  bind="grdEmp" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------------>
<gw:data id="datchem00090_1" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="grid" function="sp_sel_chem0090_1" > 
                <input bind="grdElement" >
                    <input bind="txtthr_eva_emp_reviewer_pk" />
					<input bind="txtLanguage" />
                   </input>
                <output  bind="grdElement" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------------>
<gw:data id="datchem00090_3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0090_3" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />					
					<input bind="lstEvaTimes" />
                </input> 
                <output>
                    <output bind="txtReturn" />                  
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00110_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem00090_unconfirm" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />
					<input bind="lstEvaTimes" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------------------------------>
<gw:data id="datCancel" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_chem0090_cancel" > 
                <input>
                    <input bind="lstYear" />
                    <input bind="txtLOGGED_EMP_PK" />					
					<input bind="lstEvaTimes" />
                </input> 
                <output>
                    <output bind="txtReturn" />                  
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------------>

<table border="1" height="100%" width="100%" cellpadding="0" cellspacing="0" >
	<tr style="height:10%">
		<td colspan="2" >
			<table border="0" height="100%" width="100%" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<td style="width:14%"></td>
					<td style="width:10%"></td>
					<td style="width:14%"></td>
					<td style="width:17%"></td>
					<td style="width:14%"></td>					
					<td style="width:10%"></td>
					<td style="width:5%"></td>
					<td style="width:5%"></td>
					<td style="width:11%"></td>
				</tr>
				<tr style="height:50%; " valign="middle" >
					<td align="right" style="border-top:1">Eva. #&nbsp;</td>
					<td align="left" style="border-top:1"><gw:list id="lstYear" styles="width:100%" onchange="OnChangeEvaNo()" >
					</gw:list>
					</td>					
					<td align="right" style="border-top:1">Evaluation Period&nbsp;</td>
					<td colspan="1" style="border-top:1"><gw:textbox id="txtEvaPrd" styles="width:100%" sss/></td>				
					<td align="right">Eva. Times&nbsp;</td>
					<td align="left"><gw:list id="lstEvaTimes" styles="width:100%" onchange="OnChangeEvaTimes()" />
					</td>

				</tr>
				<tr style="height:50%" valign="middle">
					<td align="right">Grade Eva. Type&nbsp;</td>
					<td align="left"><gw:textbox id="txtGrdEvaType" styles="width:100%" />
					</td>					
					<td align="right">Schedule&nbsp;</td>
					<td colspan="1"><gw:textbox id="txtSchedule" styles="width:100%"  /></td>				
					<td align="right">&nbsp;</td>
					<td align="left"><gw:icon id="idBtnGetRank" text="Get Rank Result" img="in" onclick="Get_Rank()" /></td>					
					<td align="right"><gw:icon id="idBtnConfirm" text="Confirm" img="in" onclick="OnConfirm()" /></td>					
					<td align="center"><gw:icon id="idBtnUnConfirm"  text="Unconfirm" img="in" onclick="OnUnConfirm()" /></td>
                    <td align="center"><gw:icon id="idBtnCancel"  text="Cancel" img="in" onclick="OnCanCel()" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="height:60%">
		<td colspan="2">
	       <gw:grid id='grdEmp' 
	       header='_thr_eva_emp_pk|Organization|EMP ID|Name|Evaluated Time|Evaluated Date|Total|A|C|Rank|Grade|_eva_opi|_eva_position|_self_opi_evaluation|_self_opi_position|_thr_employee_pk|_thr_eva_emp_reviewer_pk|_eva status|_reviewer_1|_reviewer_2|_manager_pk|_emp status' 
	       format='0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
	       aligns='0|0|0|0|1|1|3|3|3|3|1|0|0|0|0|0|0|0|0|0|0|0'
	       defaults='|||||||||||||||||||||' 
	       editcol='0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0'
		   editcolcolor="true"
	       widths='0|1800|1500|2500|1500|1500|1500|1500|1500|1500|1000|0|0|0|0|0|0|0|0|0|0|0' 
	       styles='width:100%; height:150'
	       acceptNullDate="T" 
	       oncellclick="OnSearch('2')"
		   onclick="OnClick_Confirm()"
		   />                        			
		</td>
	</tr>
	<tr style="height:10%" >
		<td colspan="2">
			<table style="width:100%; height:100%" cellpadding="0" cellspacing="0" >
				<tr>					
					<td style="width:16%" ></td>
					<td style="width:84%"></td>					
				</tr>
				<tr>
					<td align="center" rowspan="1" >
	                    <gw:image id="imgEmp" view="/binary/ViewFile.aspx"
	                             post="/binary/PostFile.aspx" styles="width:130;height:120" />
					</td>							   
					<td colspan="1" rowspan="1" >
				       <gw:grid id='grdElement' 
				       header='Type|Name|MBO Weight|Self Score|1st Score|2nd Score|MBO Plan|MBO Result|Desc|Unit|Present|Target|Result|_manager1_pk|_manager2_pk|_E_weight' 
				       format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
				       aligns='0|0|3|3|3|3|0|0|0|1|3|3|3|0|0|0'
				       defaults='|||||||||||||||' 
				       editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
					   editcolcolor="true"
				       widths='1200|2000|1150|1000|1000|1000|2500|2500|1000|800|900|900|900|0|0|0' 
				       styles='width:100%; height:150'
				       oncellclick="OnGridCellClick(this)"
					   onselchange="OnGridCellClick(this)"
					   oncelldblclick="OnShowPopup(7)"
					   />                        											
					</td>					
				</tr>
			</table>
		</td>
	</tr>					
	<tr style="height:20%" > 
		<td style="width:30%" >
			<table width="100%" height="100%" cellpadding="0" cellspacing="0">
				<tr style="height:20%">
					<td align="left" rowspan="1"><b><gw:label id="lblEmpName" text="" styles="width:100%" /></b></td>			
				</tr>	
				<tr style="height:16%">
					<td align="left"  ><b><gw:label id="txtSection" text="GA & Welfares" styles="width:100%; "  /></b></td>
				</tr>
				<tr style="height:16%">
					<td align="left"><b><gw:label id="txtTeam" text="LABOUR & WELLFARE TEAM" styles="width:100%" /></b></td>
				</tr>
				<tr style="height:16%">
					<td align="left" ><b><gw:label id="txtPosition" text="STAFF" styles="width:100%" /></b></td>
				</tr>
				<tr style="height:16%">
					<td align="left" ><gw:label id="txtWorkPrd" text="01-Jan-2009 ~ 31-Mar-2009" style="width:100%; " /></td>
				</tr>
				<tr style="height:16%">
					<td align="center"><gw:label id="txtDesc" text="ADDITIONAL INFO..." styles="width:100%; display:none; " /></td>
				</tr>
			</table>				
		</td>
		<td style="width:70%">
			<table width="100%" height="100%" cellpadding="0" cellspacing="0">
		   		<tr>
			   		<td style="width:20%"></td>
					<td style="width:39%"></td>
					<td style="width:1%"></td>
					<td style="width:39%"></td>
					<td style="width:1%"></td>
				</tr>
				<tr style="width:100%; height:50%">
					<td colspan="5">
						<table style="width:100%;height:100%" >
							<tr>
								<td align="left" style="width:20%;" rowspan="3" >Self-Evaluation</td>
								<td align="center" style="width:80%" colspan="2" >
									<table style="width:100%;height:100%" >
										<tr>
											<td align="left" rowspan="1" style="width:76%;border-bottom: solid 1 Black; border-right: solid 1 Black;border-top: solid 1 Black;border-left: solid 1 Black;" ><gw:label id="lblDesc" text="" styles="width:100%" /></td>											
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td align="left" style="width:40%;"><b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('1')">MBO PLAN</b>&nbsp;</td>
								<td align="left" style="width:40%;"><b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup('2')">MBO RESULT</b>&nbsp;</td>
							</tr>
							<tr>
								<td align="left" style="width:40%;"><gw:textarea id="txtInfo1" text="" styles="width:100%" rows="2" /></td>
								<td align="left" style="width:40%;"><gw:textarea id="txtInfo2" text="" styles="width:100%" rows="2" /></td>
							</tr>
						</table>	
					</td>																											
				</tr>
				<tr style="width:100%; height:10%">
					<td></td>	
					<td align="left" colspan="2" ><b>Opinion on Evaluation </b></td>
					<td align="left" colspan="2" ><b>Opinion on the Assignment of Position </b></td>
				</tr>
				<tr style="width:100%; height:20%">
					<td align="left"><gw:label id="lbl1stReviewer" text="1St Evaluation" /></td>			
					<td align="left"><gw:textarea id="txtInfo3" text="" rows="2" styles="width:100%" /></td>
					<td><img status="large" id="img1" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnShowPopup(3)"  /></td>
					<td align="left"><gw:textarea id="txtInfo4" text="" rows="2" styles="width:100%" /></td>
					<td><img status="large" id="img2" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnShowPopup(4)"  /></td>	
				</tr>
				<tr style="width:100%; height:20%">
					<td align="left"><gw:label id="lbl2ndReviewer" text="2nd Evaluation" /></td>			
					<td align="left"><gw:textarea id="txtInfo5" text="" rows="2" styles="width:100%" /></td>
					<td><img status="large" id="img3" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnShowPopup(5)"  /></td>
					<td align="left"><gw:textarea id="txtInfo6" text="" rows="2" styles="width:100%" /></td>
					<td><img status="large" id="img4" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnShowPopup(6)"  /></td>
				</tr>			
			</table>						
		</td>
	</tr>
</table>
<!-------------------------------------------------------------------------------->
<gw:datebox id="dtToday" lang="1" style="display:none;" />
<gw:textbox id="txtLOGGED_EMP_PK" style="display:none;" />
<gw:textbox id="txtthr_eva_emp_reviewer_pk" style="display:none;" />
<gw:textbox id="txtEmp_PK" style="display:none;" />
<gw:textbox id="txtPhoto_PK" style="display:none;" />
<gw:textbox id="txtReturn" style="display:none;" />
<gw:textbox id="txtEvaTimes" style="display:none;" />
<gw:textbox id="txtTotEmp" style="display:none;" />
<gw:textbox id="txtCompany" style="display:none;" />
<gw:textbox id="txtLanguage" style="display:none;" />
</body>

</html>