<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Register Evaluation (Manager -MBO)</title>
</head>
<script>
var v_language   = "<%=Session("SESSION_LANG")%>";
var v_company_pk = "<%=Session("COMPANY_PK")%>";
var v_emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var v_user_pk    = "<%=Session("USER_PK")%>";
var v_show_2ndReviewer = false ;
// global variables of grid grdSpecGrp
var iG_Type 		= 0,
	iG_Name			= 1,	
	iG_1st_Score	= 2,
	iG_2nd_Score	= 3,
	iG_Weight		= 4,
	iG_Contents		= 5,
	iG_MBO			= 6,
	iG_MBO_Result	= 7,
	iG_Indicator	= 8,		
	iG_Self_Score	= 9,
	iG_manager1_PK	= 10,
	iG_manager2_PK	= 11,
	iG_status		= 12,
	iG_level		= 13,
	iG_thr_eva_mbo_pk = 14,
	iG_thr_eva_master_pk	= 15,
	iG_thr_employee_pk		= 16,
	iG_manager1_nm			= 17,
	iG_manager2_nm			= 18,
	iG_thr_eva_emp_reviewer_pk = 19,
	iG_Unit 				= 20,
	iG_Present 				= 21,
	iG_Target 				= 22,
	iG_Result				= 23;
// grid Employee
var Emp_thr_eva_emp_pk		   = 0,
	Emp_Stage				   = 1,
    Emp_Eva_EmpStatus_name		   = 2,
	Emp_Eva_EmpStatus		   = 14,
	Emp_Emp_ID				   = 3,
	Emp_Emp_Name			   = 4,	
	Emp_THR_EVA_GROUP_PK	   = 5,
	Emp_thr_employee_PK		   = 6,
	Emp_manager_pk			   = 7,
	Emp_thr_eva_emp_reviewer_pk	= 8,
	Emp_status					= 9,
	Emp_opinion_evaluation		= 10,
	Emp_opinion_position		= 11,
	Emp_Self_Evaluation			= 12,
	Emp_Self_Position			= 13;

var l_thr_eva_emp_status,l_level;
var l_current_grid_emp_row;
	
var oPopup = null ;
var mousex,mousey;
var g_save = false ;
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
//--------------------------------------------------------------------
function OnShowPopup(opt){//show same with toolstrip <- textarea
    if(opt == 1)
	{
		var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo1"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 2)
	{
		var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=0&CTRL=txtInfo2"  ;
		var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes', window);        		
    }
    else if(opt == 3)
	{
		if(event.col == iG_MBO || event.col == iG_MBO_Result )
		{
			var l_self_score = 0, l_1stscore = 0, l_2ndscore = 0;
			l_self_score = grdSpecGrp.GetGridData(grdSpecGrp.row, iG_Self_Score);
			l_1stscore = grdSpecGrp.GetGridData(grdSpecGrp.row, iG_1st_Score);
			l_2ndscore = grdSpecGrp.GetGridData(grdSpecGrp.row, iG_2nd_Score);
			var l_eva_level = grdSpecGrp.GetGridData(grdSpecGrp.row, iG_level);
			var l_eva_status = grdEmp.GetGridData(grdEmp.row, Emp_status);
			var path = System.RootURL + "/form/ch/em/chem00080_popup_2.aspx?SelfScore=" + l_self_score + "&1stScore=" + l_1stscore + "&2ndScore=" + l_2ndscore + "&Level=" + l_eva_level ;
			var object = System.OpenModal( path , 700, 500 ,  'resizable:yes;status:yes', window);        				
			if(object != null)
			{
				if(l_eva_status != "20" && l_eva_status != "30")
				{
					grdSpecGrp.SetGridText(grdSpecGrp.row, iG_1st_Score, object[0]);
					grdSpecGrp.SetGridText(grdSpecGrp.row, iG_2nd_Score, object[1]);
					OnSave();
				}
				else
				{
				    alert('Already confirmed, Please not modify');
				}	
			}
		}
	}	
}
//--------------------------------------------------------------------
function BodyInit()
{   
   txtPeriod.SetReadOnly(true);
   txtSche.SetReadOnly(true);
   BindingData();   
}
//--------------------------------------------------------------------
function BindingData()
{
    var ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and CLOSE_YN = 'N' order by 2 desc")%>";
	lstYear.SetDataText(ls_data);
	txtUser_PK.text = v_emp_pk;
	txtCompany.text = v_company_pk;
	imgEmp.SetEnable(false);
	txtInfo1.SetReadOnly(true);
	txtInfo2.SetReadOnly(true);
	txtInfo3.SetReadOnly(true);
	txtInfo4.SetReadOnly(true);
	txtInfo5.SetReadOnly(true);
	txtInfo6.SetReadOnly(true);	
	imgEmp.SetEnable(false);
	ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, org_nm FROM tco_org WHERE DEL_IF=0 order by 2 asc")%>";
	lstDept.SetDataText(ls_data);
	txtLanguage.text = v_language;	
	//<%=ESysLib.SetGridColumnComboFormat("grdEmp", 2,"select a.CODE, a.CODE_NM FROM THR_CODE_detail a, thr_code_master b	WHERE a.DEL_IF=0 and b.del_if = 0 AND a.thr_code_master_pk = b.pk and b.id = 'HR0102' ")%>;
	datchem0080.Call();
}
//--------------------------------------------------------------------
function OnClickChange()
{
	grdEmp.ClearData();
	grdSpecGrp.ClearData();
	lstDept.ClearData();
	lbName.text = '';
	lbName1.text = '';
	lbName2.text = '';
	lbName3.text = '';
	lbName4.text = '';	
	txtInfo1.SetDataText('');
	txtInfo2.SetDataText('');
	txtInfo3.SetDataText('');
	txtInfo4.SetDataText('');
	txtInfo5.SetDataText('');
	txtInfo6.SetDataText('');	
	txtDesc.SetDataText('');
	lbl2ndReviewer.text = "2nd Reviewer";
	lbl1stReviewer.text = "1st Reviewer";	
	datchem0080.Call();
}
//--------------------------------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
		case 'datchem0080':
			datchem0080_1.Call('SELECT');
		break ;
		case 'datchem0080_1':
			treeItemOnclick();
		break ;
		case 'dat_get_emp_info_chem00060':
			imgEmp.SetDataText(txtPhoto_PK.text);
			txtLevel.text = grdEmp.GetGridData(grdEmp.row, Emp_Stage);
			datchem000080_3.Call('SELECT');
		break ;
		case 'datchem000080_3':
			var i ;
			if(Number(txtConfirmStatus.text) > 0 )
			{
				HightLightConfirmStatus('2');
			}
			txtApprover1_PK.text = "";
			txtApprover2_PK.text = "";
			if(grdSpecGrp.rows > 1)
			{
				if(grdSpecGrp.GetGridData(1, iG_manager1_PK) == v_emp_pk )
				{
					txtInfo3.SetReadOnly(false);
					txtInfo4.SetReadOnly(false);
					txtLevel.text = '1';
					txtApprover1_PK.text = grdSpecGrp.GetGridData(1, iG_manager1_PK); 
					grdSpecGrp.SetColEdit(iG_Self_Score, 0);
					grdSpecGrp.SetColEdit(iG_1st_Score, 1);
					grdSpecGrp.SetColEdit(iG_2nd_Score, 0);					
				}
				if(grdSpecGrp.GetGridData(1, iG_manager2_PK) == v_emp_pk)
				{
					txtInfo5.SetReadOnly(false);
					txtInfo6.SetReadOnly(false);
					txtLevel.text = '2';
					txtApprover2_PK.text = grdSpecGrp.GetGridData(1, iG_manager2_PK);
					grdSpecGrp.SetColEdit(iG_Self_Score, 0);
					grdSpecGrp.SetColEdit(iG_1st_Score, 0);
					grdSpecGrp.SetColEdit(iG_2nd_Score, 1);					
					for(i = 1; i < grdSpecGrp.rows ; i++)
					{
						if( Number(grdSpecGrp.GetGridData(i, iG_1st_Score)) == 0 || Trim(grdSpecGrp.GetGridData(i, iG_1st_Score)) == "" )
						{
							grdSpecGrp.SetColEdit(iG_2nd_Score, 0);										
							break ;
						}
					}
				}
			}	
		// to mau
		if(grdEmp.row > 0)
		{
			var l_stage = grdEmp.GetGridData(grdEmp.row, Emp_Stage);
			if(l_stage == "1")
			{
				if(grdSpecGrp.rows > 1)
					grdSpecGrp.SetCellBgColor(1, iG_1st_Score, grdSpecGrp.rows - 1, iG_1st_Score, 0xCCFFFF);
				txtInfo3.GetControl().style.backgroundColor = 0xFFFFCC;
				txtInfo4.GetControl().style.backgroundColor = 0xFFFFCC;
				txtInfo5.GetControl().style.backgroundColor = 0xFFFFFF;
				txtInfo6.GetControl().style.backgroundColor = 0xFFFFFF;				
			}
			else if(l_stage == "2")
			{
				if(grdSpecGrp.rows > 1)
					grdSpecGrp.SetCellBgColor(1, iG_2nd_Score, grdSpecGrp.rows - 1, iG_2nd_Score, 0xCCFFFF);			
				txtInfo5.GetControl().style.backgroundColor = 0xFFFFCC;
				txtInfo6.GetControl().style.backgroundColor = 0xFFFFCC;
				txtInfo3.GetControl().style.backgroundColor = 0xFFFFFF;
				txtInfo4.GetControl().style.backgroundColor = 0xFFFFFF;				
			}
		}	

            if(g_save==true)
            {
                g_save = false ;
                //THAY DOI STATUS EMP EVA STATUS
                if(l_level=="1")
                {
                    grdEmp.SetGridText(l_current_grid_emp_row, Emp_Eva_EmpStatus_name,"1st PROCESSING");
                    grdEmp.SetGridText(l_current_grid_emp_row, Emp_Eva_EmpStatus,"30");

                }
                else if(l_level=="2")
                {
                    grdEmp.SetGridText(l_current_grid_emp_row, Emp_Eva_EmpStatus_name,"2nd PROCESSING");
                    grdEmp.SetGridText(l_current_grid_emp_row, Emp_Eva_EmpStatus,"50");
                }
            }

			dat_get_total_evaluation.Call();
		break ;
		case 'datchem0080_2':
			HightLightConfirmStatus('1');
			if(g_save)
			{

				datchem000080_3.Call();				
			}
			else
			{
				dat_get_total_evaluation.Call();
			}
		break ;
		case 'dat_get_total_evaluation':		   
			lblReqEvaluation.text = "Request Evaluation (" + txtTotal_Req.text + "/" + txtTotal.text + ")" ;
			lblEvaluation.text = "Evaluation (" + txtTotal_Eva.text + "/" + txtTotal.text + ")" ;
		break ;
	}
}
//------------------------------------------------
function treeItemOnclick()
{    
    var l_dept_pk = lstDept.value;
    if (l_dept_pk!='')
	{
        txtDeptPK.text = l_dept_pk;
	}
	lbName.text = '';
	lbName1.text = '';
	lbName2.text = '';
	lbName3.text = '';
	lbName4.text = '';		
	txtInfo1.SetDataText('');
	txtInfo2.SetDataText('');
	txtInfo3.SetDataText('');
	txtInfo4.SetDataText('');
	txtInfo5.SetDataText('');
	txtInfo6.SetDataText('');
	datchem0080_2.Call('SELECT');
}
//------------------------------------------------
function OnClickGrid()
{
	var l_thr_eva_emp_pk = '';
	var ctrl = grdSpecGrp.GetGridControl();

    l_current_grid_emp_row=grdEmp.row;
	l_thr_eva_emp_pk = grdEmp.GetGridData(grdEmp.row, Emp_thr_eva_emp_pk);
    l_thr_eva_emp_status=grdEmp.GetGridData(grdEmp.row, Emp_Eva_EmpStatus);
    l_level=grdEmp.GetGridData(grdEmp.row, Emp_Stage);

	txtthr_eva_emp_pk.text = l_thr_eva_emp_pk;	
	txtthr_eva_emp_reviewer_pk.text = grdEmp.GetGridData(grdEmp.row, Emp_thr_eva_emp_reviewer_pk);
	txtEmp_PK.text = grdEmp.GetGridData(grdEmp.row, Emp_thr_employee_PK);	
	txtInfo1.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_Self_Evaluation));
	txtInfo2.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_Self_Position));
	txtInfo3.SetDataText('');
	txtInfo4.SetDataText('');
	txtInfo5.SetDataText('');
	txtInfo6.SetDataText('');
	lbl2ndReviewer.text = "2nd Reviewer";
	lbl1stReviewer.text = "1st Reviewer";
	txtDesc.SetDataText("");
	txtConfirmStatus.text = grdEmp.GetGridData(grdEmp.row, Emp_status);
	txtrowgrdEmp.text = grdEmp.row ;
	if(v_emp_pk == grdEmp.GetGridData(grdEmp.row, Emp_manager_pk)) 
	{
		if(grdEmp.GetGridData(grdEmp.row, Emp_Stage)== "1") // 1st Reviewer login vao 
		{
			ctrl.ColWidth(iG_2nd_Score) = 0;
			v_show_2ndReviewer = false ;
			txtInfo3.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_opinion_evaluation));
			txtInfo4.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_opinion_position));
		}
		else if(grdEmp.GetGridData(grdEmp.row, Emp_Stage)== "2") // 2nd Reviewer login vao 
		{
			ctrl.ColWidth(iG_2nd_Score) = 900;
			v_show_2ndReviewer = true;
			txtInfo5.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_opinion_evaluation));
			txtInfo6.SetDataText(grdEmp.GetGridData(grdEmp.row, Emp_opinion_position));			
		}
	}
	dat_get_emp_info_chem00060.Call();
}
//------------------------------------------------
function OnSave()
{		
	
    //alert('1');
    var l_eva_level = grdEmp.GetGridData(grdEmp.row, Emp_Stage );
	if(l_eva_level == "1")
	{
		grdEmp.SetGridText(grdEmp.row, Emp_opinion_evaluation, txtInfo3.GetData() );
		grdEmp.SetGridText(grdEmp.row, Emp_opinion_position, txtInfo4.GetData() );
		for (var i=1;i<grdSpecGrp.rows;i++){
		   if(grdSpecGrp.GetGridData(i,2) == "" || grdSpecGrp.GetGridData(i,2) < 30){
		      alert("Please input score at row "+ i +" and score must greater than 30.");
			  return;
		   }
		}
	}
	else if(l_eva_level == "2")
	{
		grdEmp.SetGridText(grdEmp.row, Emp_opinion_evaluation, txtInfo5.GetData() );
		grdEmp.SetGridText(grdEmp.row, Emp_opinion_position, txtInfo6.GetData() );
		for (var i=1;i<grdSpecGrp.rows;i++){
		   if(grdSpecGrp.GetGridData(i,3) == "" || grdSpecGrp.GetGridData(i,3) < 30){
		      alert("Please input score at row "+ i +" and score must greater than 30.");
			  return;
		   }
		}
	}
	g_save = true;
	datchem0080_2.Call();
}
//------------------------------------------------
function OnDisplayContents(flag,content)
{
     var obj = document.getElementById("content");
     obj.innerHTML = content;
     if(flag=='none')obj.style.display = 'none';
     else obj.style.display = 'block';
 }
//------------------------------------------------------
function OnShowDetails(){		
	var l_desc = "";	
	if(Trim(grdSpecGrp.GetGridData(event.row, iG_manager1_nm)) != "")
		lbl1stReviewer.text = "1st Reviewer " + "<br>" + grdSpecGrp.GetGridData(event.row, iG_manager1_nm) ;
	else
		lbl1stReviewer.text = "";
		
	if(Trim(grdSpecGrp.GetGridData(event.row, iG_manager2_nm)) != "")
		lbl2ndReviewer.text = "2nd Reviewer " + "<br>" + grdSpecGrp.GetGridData(event.row, iG_manager2_nm) ;
	else
		lbl2ndReviewer.text = "";	
	l_desc = "";	
	l_desc = "Element: ";
	l_desc = l_desc + grdSpecGrp.GetGridData(event.row, iG_Type) + " " + grdSpecGrp.GetGridData(event.row, iG_Name) + " Weight: " + grdSpecGrp.GetGridData(event.row, iG_Weight) + " Indicator: ";
	l_desc += grdSpecGrp.GetGridData(event.row, iG_Indicator) + " " ;
	l_desc += "Present " ;
	l_desc += grdSpecGrp.GetGridData(event.row, iG_Present) + "%, " ;
	l_desc += "Target " + grdSpecGrp.GetGridData(event.row, iG_Target) + "%, " ;
	l_desc += "Result " + grdSpecGrp.GetGridData(event.row, iG_Result) + "%, " ;
	l_desc += "Score " + grdSpecGrp.GetGridData(event.row, iG_Self_Score) ;	
	txtDesc.SetDataText(l_desc);
	txtInfo1.SetDataText(grdSpecGrp.GetGridData(event.row, iG_MBO));
	txtInfo2.SetDataText(grdSpecGrp.GetGridData(event.row, iG_MBO_Result));				
	txtDesc.SetReadOnly(true);
	txtPeriod.SetReadOnly(true);
}
//------------------------------------------------------
function OnNewPopUp(flag, content)
{
	if(flag != 'none')
	{
		if(oPopup == null)
			oPopup = window.createPopup();
			
		oPopup.document.body.innerHTML = "";
	    oPopup.document.write("<body style='margin:1 1 1 1;overflow:hidden;border-width: 1 1 1 1; background-color:#eaf8ff;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black; '><div>" + content +"</div></body>");
	    var ChildMenu = oPopup.document.body.childNodes(0);
		var h =  ChildMenu.scrollHeight   ;
		var w =  ChildMenu.scrollWidth ; 
	//alert(h);
	    oPopup.show( 100 ,100, 200, 200, document.body );
	}
	else
	{
		oPopup.hide();
	}
}
//---------------------------------------------------
function ShowOpinionDetails(iObj)
{
	var l_level = '';
	var l_stage = "";
	if(grdEmp.row < 1) {
	    alert("Please select an employee firstly.");
	    return;
	}
	l_stage = grdEmp.GetGridData(grdEmp.row, Emp_Stage); // Reviewer Level 
	
	if(txtApprover1_PK.text == v_emp_pk )
	{
		l_level = '1';
		txtLevel.text = '1';
	}		
	else if (txtApprover2_PK.text == v_emp_pk )
	{
		l_level = '2';
		txtLevel.text = '2';
	}		
	switch(iObj)
	{
		case 'txtInfo3':	
			var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=" + l_level + "&CTRL=txtInfo3"  ;
			var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes',window);        
			if(object!=null)
			{
				txtInfo3.SetDataText(object[0]);
			}
		break;
		case 'txtInfo4':
			var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=" + l_level + "&CTRL=txtInfo4"  ;
			var object = System.OpenModal( path ,600 , 500 ,  'resizable:yes;status:yes',window);        
			if(object!=null)
			{
				txtInfo4.SetDataText(object[0]);
			}
		break;
		case 'txtInfo5':
			var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=" + l_level + "&CTRL=txtInfo5" ;
			var object = System.OpenModal( path , 600, 500,  'resizable:yes;status:yes',window);        
			if(object!=null)
			{
				txtInfo5.SetDataText(object[0]);
			}				
		break;
		case 'txtInfo6':
			var path = System.RootURL + "/form/ch/em/chem00080_popup.aspx?VIEW_LEVEL=" + l_level + "&CTRL=txtInfo6" ;
			var object = System.OpenModal( path , 600,500,  'resizable:yes;status:yes',window);        
			if(object!=null)
			{
				txtInfo6.SetDataText(object[0]);
			}				
		break;
	}		
}
//--------------------------------------------------------------
function HightLightConfirmStatus(opt){
	var i;
	if(opt == '1')
	{
	    for(i=1;i<grdEmp.rows;i++){
	        if(Number(grdEmp.GetGridData(i, Emp_status)) == 20 || Number(grdEmp.GetGridData(i, Emp_status)) == 30)
			{
	            grdEmp.SetCellBgColor(i, 0, i, grdEmp.cols - 1, 0X7AA0FF);			
	        }
	    }
	}
	else if(opt == '2')
	{
        var flag;
		if(Number(txtConfirmStatus.text) == 20 || Number(txtConfirmStatus.text) == 30) //score confirm
		{
		    for(i=1;i<grdSpecGrp.rows;i++)
		        grdSpecGrp.SetCellBgColor(i, 0, i, grdSpecGrp.cols - 1, 0X7AA0FF);		
            flag=0;							
			//ibtnSave.SetEnable(false);			
	    }
		else
		{			
			if(grdSpecGrp.rows > 1)
			{
				//ibtnSave.SetEnable(true);				
                flag=1;
			}				
			else
			{
				//ibtnSave.SetEnable(false);				
                flag=0;
			}
		}	

        if(l_level=='2')
            if(l_thr_eva_emp_status=="10" ||l_thr_eva_emp_status=="20"||l_thr_eva_emp_status=="30"||l_thr_eva_emp_status=="80")
                flag=0;
        ibtnSave.SetEnable(flag);



	}		
}
//--------------------------------------------------------------
function CheckScore()
{
	var i;
	if(grdSpecGrp.rows == 1)
		return false;				
	for(i = 1; i < grdSpecGrp.rows ; i++)
	{				
		if(txtApprover1_PK.text == v_emp_pk )
		{
			if(isNaN(grdSpecGrp.GetGridData(i, iG_1st_Score)))
			{
				alert("First Score must be number...");
				return false;
			}		
			else if(!( Number(grdSpecGrp.GetGridData(i, iG_1st_Score)) > 0 && Number(grdSpecGrp.GetGridData(i, iG_1st_Score)) <= 100 ) ) //_Score	
			{
				alert("First-score must greater than 0 and less than or equal to 100...");
				return false;
			}		
		}
		if(txtApprover2_PK.text == v_emp_pk )
		{					
			if(isNaN(grdSpecGrp.GetGridData(i, iG_2nd_Score)))
			{
				alert("Second Score must be number...");
				return false;
			}
			else if(!(Number(grdSpecGrp.GetGridData(i, iG_2nd_Score)) > 0 && Number(grdSpecGrp.GetGridData(i, iG_2nd_Score)) <= 100)  ) //Self_Score	
			{
				alert('Second-score must greater than 0 and less than or equal to 100...');						
				return false ;
			}
		}
	}
	return true;
}
//--------------------------------------------------------------
function GetOpinionEva_1St()
{
	return txtInfo3.GetData();
}
//--------------------------------------------------------------

function GetOpinionPos_1St()
{
	return txtInfo4.GetData();
}
//--------------------------------------------------------------
function GetOpinionEva_2nd()
{
	return txtInfo5.GetData();
}
//--------------------------------------------------------------

function GetOpinionPos_2nd()
{
	return txtInfo6.GetData();
}
//--------------------------------------------------------------
function GetMBOPlan()
{
	return txtInfo1.GetData();
}
//--------------------------------------------------------------
function GetMBOResult()
{
	return txtInfo2.GetData();
}
//--------------------------------------------------------------
function GetMBO()
{
	return grdSpecGrp.GetGridData(grdSpecGrp.row, iG_MBO);
}
//--------------------------------------------------------------
function GetMBOResult_2()
{
	return grdSpecGrp.GetGridData(grdSpecGrp.row, iG_MBO_Result);
}
//--------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------>
<gw:data id="datchem0080" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem00050_1" > 
            <input>
                <input bind="lstYear" />
				<input bind="txtCompany" />
            </input>
	       <output>	            
	            <output bind="txtPeriod" /> 
	            <output bind="txtSche" />
	            <output bind="txtgradetype" />
	            <output bind="txtgradetime" />
	            <output bind="txtTotal" />
	       </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------>
<gw:data id="datchem0080_1" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="list" procedure="sp_pro_chem00080_2" > 
            <input >
                <input bind="txtCompany" />
				<input bind="lstYear" />
				<input bind="txtUser_PK" />
            </input> 
			<output>
            	<output bind="lstDept" /> 
			</output>				
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------>
<gw:data id="datchem0080_2" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="grid" parameter="8,10,11" function="sp_sel_chem000080_4" procedure="sp_upd_chem000080_4" > 
            <input bind="grdEmp" >
                <input bind="txtDeptPK" />
                <input bind="txtUser_PK" />
				<input bind="lstYear" />
            </input>
            <output  bind="grdEmp" />
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------>
<gw:data id="dat_get_total_evaluation" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso type="process" procedure="sp_pro_chem00080_3" > 
                <input>
					<input bind="lstYear" />
                    <input bind="txtUser_PK" />					
                </input> 
                <output>                    
                    <output bind="txtTotal"/>
                    <output bind="txtTotal_Req" />          
                    <output bind="txtTotal_Eva" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------>

<gw:data id="datchem000080_3" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" parameter="0,2,3,10,11,13,14,15,24,25,30" function="sp_sel_chem000080_5" procedure="sp_upd_chem000080_5" > 
            <input bind="grdSpecGrp" >
                <input bind="txtthr_eva_emp_pk" />				
				<input bind="txtLevel" />
				<input bind="txtLanguage" />
            </input>
            <output  bind="grdSpecGrp" />
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------>
<gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="sp_pro_get_emp_info_chem00060" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="lbName"/>
                    <output bind="lbName1" />          
                    <output bind="lbName2" />
                    <output bind="txtPhoto_PK" />
                    <output bind="lbName3" /> 
                    <output bind="lbName4" />                                                                
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------>
<table id="main" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr style="height:100%">
        <td width="35%" valign="top">
            <table width="100%" border="0" height="100%">
                <tr style="height:19%">
                    <td>
                        <table border="0" style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" style="background-color:#BDE9FF">
                            <tr>
                                <td width="30%" align="right">Eva. #</td>
                                <td width="70%" nowrap colspan="4" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                                <gw:list  id="lstYear"  maxlen = "100" styles='width:100%'onchange="OnClickChange()" />                                   
								</td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Evaluation Period</td>
                                <td width="70%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" nowrap colspan="4"><gw:textbox id="txtPeriod"  text="01-Oct-2008 ~ 31-Mar-2009" styles='width:100%'></gw:textbox></td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Schedule</td>
                                <td width="70%" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" nowrap colspan="4" ><gw:textbox id="txtSche"  text="01-Apr-2009 ~ 15-Apr-2009" styles='width:100%'></gw:textbox></td>
                            </tr>
                        </table>  
                    </td>
                </tr>
                <tr style="height:81%">
                    <td >
                        <table style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" border="0">
                            <tr style="height:6%" >
                                <td><gw:label id="lblReqEvaluation" styles="width:100%; border:1px solid #6B9EB8;color: #000000; " text="Request Evaluation" /></td>
								<td><gw:label id="lblEvaluation" styles="width:100%; border:1px solid #6B9EB8;color: #000000; " text="Evaluation" /></td>
                            </tr>
                            <tr style="height:6%" >
                                <td colspan="2"><gw:list id="lstDept" styles="width:100%; " onchange="treeItemOnclick()" /></td>								
                            </tr>							
                            <tr style="height:43%" >
                                <td colspan="2" >
									<table style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" border="0" >
										<tr style="height:100%" >
											<td style="width:65%">
												<table style="width:100%; height:100%; " border="0" cellpadding="0" cellspacing="0">
						                            <tr>
                        						        <td width="100%" ><gw:label id="lbName">AAA NAME</gw:label></td>
                            						</tr>		
													<tr>
						                                <td width="40%" ><gw:label id="lbName1">&nbsp;GA & Welfares</gw:label></td>																							
													</tr>
													<tr>
						                                <td width="60%" ><gw:label id="lbName2">&nbsp;LABOUR & WELFARE TEAM</gw:label></td>													
													</tr>		
													<tr>
														<td width="40%" ><gw:label id="lbName3">&nbsp;STAFF</gw:label></td>													
													</tr>
													<tr>
						                                <td width="60%" ><gw:label id="lbName4"></gw:label></td>
													</tr>												
												</table>
											</td>
											<td style="width:35%" align="center">
												<gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:150;height:155"  />
											</td>
										</tr>
									</table>
			                    </td> 
                            </tr>
                            <tr style="height:45%" >
                                <td style="width:100%;border-bottom: solid 1 Black" colspan="2" >
                                    <gw:grid id="grdEmp" 
                                    header="_thr_eva_emp_pk|Level|Status|Emp ID|Emp Name|_THR_EVA_GROUP_PK|_thr_employee_PK|_manager_pk|_thr_eva_emp_reviewer_pk|_status|_OpiEvaluation|_OpiPosition|_Self_Evaluation|_Self_Position|_EMP_EVA_STATUS" 
                                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                    aligns="0|1|0|1|0|0|0|0|0|0|0|0|0|0|0" 
                                    defaults="||||||||0||||||" 
                                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
									editcolcolor="true"
                                    widths="0|700|1800|1000|3000|0|0|0|0|0|0|0|0|0|0"
                                    styles="width:100%;height:100%" 
                                    oncellclick="OnClickGrid()" 
                                    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" />
                                </td>
                            </tr>							
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td style="width:65%;height:100%" valign="top">
            <table width="100%" cellpadding="0" cellspacing="1" border="1" style="height:100%;width:100%" >
                <tr style="height:1%"  >
                    <td colspan="1">
                        <table width="100%" >
                            <tr>
                                <td width="94%">
								</td>
                                <td width="3%" ><gw:icon id="ibtnSave" img="in" text="Save" onclick="OnSave()" /></td>
                                <td width="3%" >&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr  >
                    <td colspan="1" style="height:89%"  style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                        <gw:grid id="grdSpecGrp" 
                        header="Type|Name|1st Score|2nd Score|MBO.Weight|_Contents|MBO Plan|MBO Result|Indication|Self Score|_manager1_PK|_manager2_PK|_status|_level|_thr_eva_mbo_pk|_thr_eva_master_pk|_thr_employee_pk|_manager1_nm|_manager2_nm|_thr_eva_emp_reviewer_pk|Unit|Present|Target|Result|_opinion_evaluation_1|_opinion_position_1|_self_opi_eva|_self_opi_pos|_opinion_evaluation_2|_opinion_position_2|_thr_eva_mbo_result_pk"
                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|3|3|3|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0|1|3|3|3|0|0|0|0|0|0|0" 
                        defaults="||||||||||||||||||||||||" 
                        editcol="0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
						editcolcolor="true" 
                        widths="1300|1500|1100|900|1100|0|2500|1000|1100|0|0|0|0|0|0|0|0|0|0|800|1000|1000|0|0|0|0|0|0|0|0|0"
                        styles="width:100%;height:100%" 
                        oncellclick="OnShowDetails()" 						
						onselchange="OnShowDetails()"
						oncelldblclick="OnShowPopup(3)"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30" />
                    </td>
                </tr>
                <tr style="height:10%"  >
                    <td colspan="1" style="height:20%"  >
                       <table style="width:100%;height:100%" border="0" >
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
														<td align="left" rowspan="1" style="width:100%;border-bottom: solid 1 Black; border-right: solid 1 Black;border-top: solid 1 Black;border-left: solid 1 Black;" ><gw:textarea id="txtDesc" text="" rows="3" styles="width:100%" /></td>											
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td align="left" style="width:40%;"><b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(1)">MBO PLAN&nbsp;</b></td>
											<td align="left" style="width:40%;"><b style="color: #1b2ff2; cursor: hand" onclick="OnShowPopup(2)">MBO RESULT&nbsp;</b></td>
										</tr>
										<tr>
											<td align="left" style="width:40%;"><gw:textarea id="txtInfo1" text="" styles="width:100%" rows="4" /></td>
											<td align="left" style="width:40%;"><gw:textarea id="txtInfo2" text="" styles="width:100%" rows="4" /></td>
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
								<td align="left"><gw:textarea id="txtInfo3" text="" rows="3" styles="width:100%" /></td>
								<td><img status="large" id="img1" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="ShowOpinionDetails('txtInfo3')"  /></td>
								<td align="left"><gw:textarea id="txtInfo4" text="" rows="3" styles="width:100%" /></td>
								<td><img status="large" id="img2" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="ShowOpinionDetails('txtInfo4')"  /></td>
							</tr>
							<tr style="width:100%; height:20%">
								<td align="left"><gw:label id="lbl2ndReviewer" text="2nd Evaluation" /></td>			
								<td align="left"><gw:textarea id="txtInfo5" text="" rows="3" styles="width:100%" /></td>
								<td><img status="large" id="img3" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="ShowOpinionDetails('txtInfo5')"  /></td>
								<td align="left"><gw:textarea id="txtInfo6" text="" rows="3" styles="width:100%" /></td>
								<td><img status="large" id="img4" alt="Show more details" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="ShowOpinionDetails('txtInfo6')"  /></td>	
							</tr>
                       </table>
                    </td>
                </tr>
            </table>
        </td>        
    </tr>    
</table>

<gw:textbox id="txtCompany" styles="display: none;" />
<gw:textbox id="txtgradetype" styles="display: none;" />
<gw:textbox id="txtgradetime" styles="display: none;" />
<gw:textbox id="txtUser_PK" styles="display: none;" />
<gw:textbox id="txtDeptPK" styles="display: none;" />
<gw:textbox id="txtthr_eva_emp_pk" styles="display: none;" />
<gw:textbox id="txtthr_eva_emp_reviewer_pk" styles="display: none;" />
<gw:textbox id="txtPhoto_PK" styles="display: none;" />
<gw:textbox id="txtEmp_PK" styles="display: none;" />
<gw:textbox id="txtApprover1_PK" styles="display: none;" />
<gw:textbox id="txtApprover2_PK" styles="display: none;" />
<gw:textbox id="txtReturnValue" styles="display: none;" />
<gw:textbox id="txtTotal" styles="display: none;" />
<gw:textbox id="txtTotal_Req" styles="display: none;" />
<gw:textbox id="txtTotal_Eva" styles="display: none;" />
<gw:textbox id="txtConfirmStatus" styles="display: none;" />
<gw:textbox id="txtLevel" styles="display: none;" />
<gw:textbox id="txtLanguage" styles="display: none;" />
<gw:textbox id="txtrowgrdEmp" styles="display: none;" />
</body>
</html>

