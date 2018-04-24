<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
    <title>BCWS Details Registration</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>

var cons_123 = false;
var flag = '';
var level_pk;

var EQ_LEVEL						= 0,
	EQ_ITEM_CODE					= 1,
	EQ_NAME							= 2,
	EQ_STANDARD						= 3,
	EQ_WEIGHT						= 4,
	EQ_UOM							= 5,
	EQ_CCY							= 6,
	EQ_QTY							= 7,
	EQ_UNIT_COST					= 8,
	EQ_AMT							= 9,
	EQ_ORDER_PK						= 10,
	EQ_ORDER_CODE					= 11,
	EQ_ORDER_NAME					= 12,
	EQ_EX_YN						= 13,
	EQ_BUDGET_PK					= 14,
	EQ_BUDGET_CODE					= 15,
	EQ_STANDARD_PBS					= 16,
	EQ_DEVL_TERM					= 17,
	EQ_ORDER_STATUS					= 18,
	EQ_RSLT_YN						= 19,
	EQ_PROJECT_PK					= 20,
	EQ_TECPS_UNDERTAKECTRTBASC_PK	= 21,
	EQ_UNDERTAKESEQ					= 22,
	EQ_TECPS_PERFORMBUDGETBASC_PK	= 23,
	EQ_BOOKING_AMT					= 24,
	EQ_SEQ_NO						= 25,
	EQ_NUM							= 26,	
	EQ_LEVEL_NUM                    = 27,
	EQ_PK							= 28,
	EQ_LEVEL_PK						= 29
	EQ_TECPS_ITEM_PK                = 30;

var CONS_LEVEL						= 0,
	CONS_CODE						= 1,
	CONS_NAME						= 2,
	CONS_STAN						= 3,
	CONS_UNIT						= 4,
	CONS_CCY						= 5,
	CONS_QTY						= 6,
	CONS_RAW						= 7,
	CONS_LABOR						= 8,
	CONS_EXP_UP						= 9,
	CONS_LABOR_UNIT_PRICE			= 10,
	CONS_AMT						= 11,
	CONS_ORDER_PK					= 12,
	CONS_ORDER_CODE					= 13,
	CONS_ORDER_NAME					= 14,
	CONS_EXEC_YN					= 15,
	CONS_DIR_MGT					= 16,
	CONS_BUDGET_PK					= 17,
	CONS_BUDGET_CODE				= 18,
	CONS_STAN_CODE					= 19,
	CONS_CALC_BASIC					= 20,
	CONS_ORDER_STA					= 21,
	CONS_RSLT_YN					= 22,
	CONS_PROJECT_PK					= 23,
	CONS_TECPS_UNDERTAKECTRTBASC_PK	= 24,
	CONS_UNDERTAKESEQ				= 25,
	CONS_TECPS_PERFORMBUDGETBASC_PK	= 26,
	CONS_BOOKING_AMT				= 27,
	CONS_SEQ_NO						= 28,
	CONS_NUM						= 29,
	CONS_PARENT_PK					= 30,
	CONS_PARENT_AMT					= 31,
	CONS_LEVEL_NUM					= 32,
	CONS_PK							= 33,
	CONS_LEVEL_PK					= 34,
	CONS_TECPS_ITEM_PK              = 35;

var CM_PK								= 0,
	CM_NO								= 1,
	CM_DES								= 2,
	CM_LEVEL_PK							= 3,
	CM_NAME								= 4,
	CM_UOM								= 5,
	CM_QTY								= 6,
	CM_DIRECT_CCY						= 7,
	CM_DIRECT_MM						= 8,
	CM_DIRECT_UNIT_COST					= 9,
	CM_DIRECT_AMT						= 10,
	CM_OUTSRC_CCY						= 11,
	CM_OUTSRC_MM						= 12,
	CM_OUTSRC_UNIT_COST					= 13,
	CM_OUTSRC_AMT						= 14,
	CM_SUM								= 15,
	CM_OUTSITE_PK						= 16,
	CM_OUTSITE_CODE						= 17,
	CM_OUTSITE_NAME						= 18,
	CM_ORDER_STATUS						= 19,
	CM_RSLT_YN							= 20,
	CM_PROJECT_PK						= 21,
	CM_TECPS_UNDERTAKECTRTBASC_PK		= 22,
	CM_UNDERTAKESEQ						= 23,
	CM_TECPS_PERFORMBUDGETBASC_PK		= 24,
	CM_BOOKING_AMT						= 25,
	CM_SEQ_NO							= 26,
	CM_NUM								= 27;

var OTHER_PK							= 0,
	OTHER_LEVEL_PK						= 1,
	OTHER_LEVEL							= 2,
	OTHER_SRVC_FLD						= 3,
	OTHER_NAME							= 4,
	OTHER_STANDARD						= 5,
	OTHER_UNIT							= 6,
	OTHER_CCY							= 7,
	OTHER_QTY							= 8,
	OTHER_UNIT_PRICE					= 9,
	OTHER_AMT							= 10,
	OTHER_ORDER_PK						= 11,
	OTHER_ORDER_CODE					= 12,
	OTHER_ORDER_NAME					= 13,
	OTHER_ORDER_STATUS					= 14,
	OTHER_RSLT_YN						= 15,
	OTHER_PROJECT_PK					= 16,
	OTHER_TECPS_UNDERTAKECTRTBASC_PK	= 17,
	OTHER_UNDERTAKESEQ					= 18,
	OTHER_TECPS_PERFORMBUDGETBASC_PK	= 19,
	OTHER_BOOKING_AMT					= 20,
	OTHER_SEQ_NO						= 21,
	OTHER_NUM							= 22;

var status_control;

function BodyInit()
{ 
	System.Translate(document);
	BindingDataList();
	Merge_grid(grdEQ);
	Merge_grid(grdCONS);
	Merge_grid(grdCM);
	Merge_grid(grdOther);
	grdEQ.GetGridControl().FrozenCols       = EQ_UOM;
    grdCONS.GetGridControl().FrozenCols     = CONS_UNIT;
    grdCM.GetGridControl().FrozenCols       = CM_DIRECT_CCY;
    grdOther.GetGridControl().FrozenCols    = OTHER_UNIT;

	grdEQ.GetGridControl().WordWrap	= true;
	//grdCONS.GetGridControl().WordWrap	= true;f
	grdCM.GetGridControl().WordWrap	= true;
	grdOther.GetGridControl().WordWrap = true;
}

function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProjectPk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2];
				OnSearch('MST');
		    }
	    break;
        case 'Work_Breakdown':
            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProjectPk.text;
            var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
			    if (obj[2] != 0)
			    {
				    txtWork_Breakdown.text		= obj[2];
					txtWork_Breakdown_Cd.text	= obj[0];
					txtWork_Breakdown_Nm.text	= obj[1];
			    }   
                OnChangeCB();
            }
        break;
        case 'OutsideOrderWork':
			if (txtProjectPk.text == '' )
			{
				alert('Please select Project !!');
			}
			else
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk="+ txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					txtOrderWork_Cd.text = object[1];
					txtOrderWork_Nm.text = object[2];
					txtOrderWork_Pk.text = object[0];
				}
			}
        break;
		case 'Version':
			if (txtProjectPk.text == '' )
			{
				alert('Please select Project !!');
			}
			else
			{
				var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Version.aspx?Project_Pk=" + txtProjectPk.text;
				var aValue = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(aValue != null)
				{
					txtContract_Pk.text		= aValue[0];
					txtContract_Seq.text	= aValue[1];
				} 
			} 
		break;
    }    
}

function OnSearch(obj)
{
	if (txtProjectPk.text == '')
	{
		alert('Please, select Project !!!');
		return;
	}

	flag = 'SELECT';
	switch(obj)
	{
		case 'EQ':
			dso_grdEQ.Call('SELECT');
		break;	
		case 'MST':
			flag = 'SELECT';
			dso_BudgetNo.Call('SELECT');
		break;
		case 'CONS':
			dso_grdCONS.Call('SELECT');
		break;
		case 'CM':
			dso_grdCM.Call('SELECT');
		break;
		case 'OTHER':
			dso_grdOther.Call('SELECT');
		break;
	}
}

//---------------------------------------------------------
function OnPopUpList()
{
    var path = System.RootURL + '/form/kp/bm/kpbm00040_popup_list.aspx';
    var object = System.OpenModal( path ,200 , 400 , 'resizable:yes;status:yes');   
}
 //---------------------------------------------------------

function Merge_grid(obj)
{
	switch(obj.id)
	{
		case 'grdEQ':
			if (obj.rows < 2)
			{		
				obj.AddRow();
			}

			var fg = obj.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(EQ_PK) = true
			fg.Cell(0, 0, EQ_PK, 1, EQ_PK)				= "PK"

			fg.MergeCol(EQ_LEVEL_PK) = true
			fg.Cell(0, 0, EQ_LEVEL_PK, 1, EQ_LEVEL_PK)	= "LEVEL_PK"

			fg.MergeCol(EQ_LEVEL) = true
			fg.Cell(0, 0, EQ_LEVEL, 1, EQ_LEVEL)		= "Level"
			
			fg.MergeCol(EQ_ITEM_CODE) = true
			fg.Cell(0, 0, EQ_ITEM_CODE, 1, EQ_ITEM_CODE)	= "Code"

			fg.MergeCol(EQ_NAME) = true
			fg.Cell(0, 0, EQ_NAME, 1, EQ_NAME)			= "Name"
			
			fg.MergeCol(EQ_STANDARD) = true
			fg.Cell(0, 0, EQ_STANDARD, 1, EQ_STANDARD)	= "Standard"
			
			fg.MergeCol(EQ_WEIGHT) = true
			fg.Cell(0, 0, EQ_WEIGHT, 1, EQ_WEIGHT)		= "Weight"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, EQ_UOM, 0, EQ_AMT) = "Working(Changed)"  
			fg.Cell(0, 1, EQ_UOM, 1) 		 = "Unit"
			fg.Cell(0, 1, EQ_CCY, 1) 		 = "CCY"
			fg.Cell(0, 1, EQ_QTY, 1 ) 		 = "Quantity"
			fg.Cell(0, 1, EQ_UNIT_COST, 1) 	 = "Unit Cost"
			fg.Cell(0, 1, EQ_AMT, 1) 		 = "Amount"			
			
			fg.MergeCol(EQ_ORDER_PK) = true
			fg.Cell(0, 0, EQ_ORDER_PK, 1, EQ_ORDER_PK) = "ORDER_PK"

			fg.MergeRow(0) = true
			fg.Cell(0, 0, EQ_ORDER_CODE, 0, EQ_ORDER_NAME) = "Order W. Div."  
			fg.Cell(0, 1, EQ_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, EQ_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(EQ_EX_YN) = true
			fg.Cell(0, 0, EQ_EX_YN, 1, EQ_EX_YN) = "Excution (Yes/No)"

			fg.MergeCol(EQ_BUDGET_PK) = true
			fg.Cell(0, 0, EQ_BUDGET_PK, 1, EQ_BUDGET_PK) = "BUDGET_PK"

			fg.MergeCol(EQ_BUDGET_CODE) = true
			fg.Cell(0, 0, EQ_BUDGET_CODE, 1, EQ_BUDGET_CODE) = "Budget Code"
			
			fg.MergeCol(EQ_STANDARD_PBS) = true
			fg.Cell(0, 0, EQ_STANDARD_PBS, 1, EQ_STANDARD_PBS) = "Standard PBS"
			
			fg.MergeCol(EQ_DEVL_TERM) = true
			fg.Cell(0, 0, EQ_DEVL_TERM, 1, EQ_DEVL_TERM) = "Delivery Term"
			
			fg.MergeCol(EQ_ORDER_STATUS) = true
			fg.Cell(0, 0, EQ_ORDER_STATUS, 1, EQ_ORDER_STATUS) = "Order Status"
			
			fg.MergeCol(EQ_RSLT_YN) = true
			fg.Cell(0, 0, EQ_RSLT_YN, 1, EQ_RSLT_YN) = "A. Rslt Rcpt (Y/N)"
			
			fg.MergeCol(EQ_PROJECT_PK) = true
			fg.Cell(0, 0, EQ_PROJECT_PK, 1, EQ_PROJECT_PK) = "A. Rslt Rcpt (Y/N)"

			fg.MergeCol(EQ_PROJECT_PK) = true
			fg.Cell(0, 0, EQ_PROJECT_PK, 1, EQ_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(EQ_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, EQ_TECPS_UNDERTAKECTRTBASC_PK, 1, EQ_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(EQ_UNDERTAKESEQ) = true
			fg.Cell(0, 0, EQ_UNDERTAKESEQ, 1, EQ_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(EQ_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, EQ_TECPS_PERFORMBUDGETBASC_PK, 1, EQ_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"
			
			fg.MergeCol(EQ_BOOKING_AMT) = true
			fg.Cell(0, 0, EQ_BOOKING_AMT, 1, EQ_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(EQ_SEQ_NO) = true
			fg.Cell(0, 0, EQ_SEQ_NO, 1, EQ_SEQ_NO) = "SEQ"

			fg.MergeCol(EQ_NUM) = true
			fg.Cell(0, 0, EQ_NUM, 1, EQ_NUM) = "NUM"            
			
			fg.MergeCol(EQ_TECPS_ITEM_PK) = true;
			fg.Cell(0, 0, EQ_TECPS_ITEM_PK, 1, EQ_TECPS_ITEM_PK) = "TECPS_ITEM_PK";
			
			fg.MergeCol(EQ_LEVEL_NUM) = true;
			fg.Cell(0, 0, EQ_LEVEL_NUM, 1, EQ_LEVEL_NUM) = "LEVEL_NUM";

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(EQ_WEIGHT)	= 7;
			ctrl.ColAlignment(EQ_QTY)		= 7;
			ctrl.ColAlignment(EQ_UNIT_COST)	= 7;
			ctrl.ColAlignment(EQ_AMT)		= 7;
			
			ctrl.ColFormat(EQ_WEIGHT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_QTY)			= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_AMT)			= "#,###,###,###,###,###,###,###,###.##R";
			break;
		case 'grdCONS':
			if (grdCONS.rows < 2)
			{		
				grdCONS.AddRow();
			}
			
			var fg = grdCONS.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(CONS_PK) = true
			fg.Cell(0, 0, CONS_PK, 1, CONS_PK) = "PK";

			fg.MergeCol(CONS_LEVEL_PK) = true
			fg.Cell(0, 0, CONS_LEVEL_PK, 1, CONS_LEVEL_PK) = "Level_PK"

			fg.MergeCol(CONS_LEVEL) = true
			fg.Cell(0, 0, CONS_LEVEL, 1, CONS_LEVEL) = "Level"

			fg.MergeCol(CONS_CODE) = true
			fg.Cell(0, 0, CONS_CODE, 1, CONS_CODE) = "Code"

			fg.MergeCol(CONS_NAME) = true
			fg.Cell(0, 0, CONS_NAME, 1, CONS_NAME) = "Name"

			fg.MergeCol(CONS_STAN) = true
			fg.Cell(0, 0, CONS_STAN, 1, CONS_STAN) = "Standard"	
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CONS_UNIT, 0, CONS_AMT)	= "Working(Changed)"
			fg.Cell(0, 1, CONS_UNIT, 1) 			= "Unit"
			fg.Cell(0, 1, CONS_CCY, 1 ) 			= "Currency"
			fg.Cell(0, 1, CONS_QTY, 1) 				= "Qty"
			fg.Cell(0, 1, CONS_RAW, 1) 				= "Raw Mtrl. Cost U/P"
			fg.Cell(0, 1, CONS_LABOR, 1) 			= "Labor Cost U/P"
			fg.Cell(0, 1, CONS_EXP_UP, 1) 			= "Exp. U/P"
			fg.Cell(0, 1, CONS_LABOR_UNIT_PRICE, 1) = "Unit Price"
			fg.Cell(0, 1, CONS_AMT, 1) 				= "Amount"

			fg.Cell(0, 0, CONS_ORDER_PK, 0, CONS_ORDER_NAME) = "Order W. Div." 
			fg.Cell(0, 1, CONS_ORDER_PK, 1) 	= "PK"
			fg.Cell(0, 1, CONS_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, CONS_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(CONS_EXEC_YN) = true
			fg.Cell(0, 0, CONS_EXEC_YN, 1, CONS_EXEC_YN) = "Exec. (Y/N)"
			
			fg.MergeCol(CONS_DIR_MGT) = true
			fg.Cell(0, 0, CONS_DIR_MGT, 1, CONS_DIR_MGT) = "Dir. Mgt Outsrc."
			
			fg.MergeCol(CONS_BUDGET_PK) = true
			fg.Cell(0, 0, CONS_BUDGET_PK, 1, CONS_BUDGET_PK) = "Budget_PK"

			fg.MergeCol(CONS_BUDGET_CODE) = true
			fg.Cell(0, 0, CONS_BUDGET_CODE, 1, CONS_BUDGET_CODE) = "Budget Code"
			
			fg.MergeCol(CONS_STAN_CODE) = true
			fg.Cell(0, 0, CONS_STAN_CODE, 1, CONS_STAN_CODE) = "Standard Code"
			
			fg.MergeCol(CONS_CALC_BASIC) = true
			fg.Cell(0, 0, CONS_CALC_BASIC, 1, CONS_CALC_BASIC) = "Calc. Basic"
			
			fg.MergeCol(CONS_ORDER_STA) = true
			fg.Cell(0, 0, CONS_ORDER_STA, 1, CONS_ORDER_STA) = "Order Status"
			
			fg.MergeCol(CONS_RSLT_YN) = true
			fg.Cell(0, 0, CONS_RSLT_YN, 1, CONS_RSLT_YN) = "A. Rslt Rcpt Y/N"				

			fg.MergeCol(CONS_PROJECT_PK) = true
			fg.Cell(0, 0, CONS_PROJECT_PK, 1, CONS_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(CONS_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, CONS_TECPS_UNDERTAKECTRTBASC_PK, 1, CONS_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(CONS_UNDERTAKESEQ) = true
			fg.Cell(0, 0, CONS_UNDERTAKESEQ, 1, CONS_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(CONS_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, CONS_TECPS_PERFORMBUDGETBASC_PK, 1, CONS_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(CONS_BOOKING_AMT) = true
			fg.Cell(0, 0, CONS_BOOKING_AMT, 1, CONS_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(CONS_SEQ_NO) = true
			fg.Cell(0, 0, CONS_SEQ_NO, 1, CONS_SEQ_NO) = "SEQ"

			fg.MergeCol(CONS_NUM) = true
			fg.Cell(0, 0, CONS_NUM, 1, CONS_NUM) = "NUM"
			
			fg.MergeCol(CONS_PARENT_PK) = true
			fg.Cell(0, 0, CONS_PARENT_PK, 1, CONS_PARENT_PK) = "PARENT_PK"
			
			fg.MergeCol(CONS_PARENT_AMT) = true
			fg.Cell(0, 0, CONS_PARENT_AMT, 1, CONS_PARENT_AMT) = "PARENT_AMT"
			
			fg.MergeCol(CONS_LEVEL_NUM) = true
			fg.Cell(0, 0, CONS_LEVEL_NUM, 1, CONS_LEVEL_NUM) = "LEVEL_NUM"
			
			fg.MergeCol(CONS_TECPS_ITEM_PK) = true
			fg.Cell(0, 0, CONS_TECPS_ITEM_PK, 1, CONS_TECPS_ITEM_PK) = "TECPS_ITEM_PK"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(CONS_QTY)			= 7;
			ctrl.ColAlignment(CONS_RAW)			= 7;
			ctrl.ColAlignment(CONS_LABOR)		= 7;
			ctrl.ColAlignment(CONS_EXP_UP)		= 7;
			ctrl.ColAlignment(CONS_LABOR_UNIT_PRICE) = 7;
			ctrl.ColAlignment(CONS_AMT)			= 7;
			ctrl.ColAlignment(CONS_CALC_BASIC)  = 7;
			ctrl.ColAlignment(CONS_CCY)			= 2;

			ctrl.ColFormat(CONS_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_RAW)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_LABOR)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_EXP_UP)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_LABOR_UNIT_PRICE)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_AMT)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_CALC_BASIC)			= "#,###,###,###,###,###,###,###,###.##R";
		break;

		case 'grdCM':
			if (grdCM.rows < 2)
			{		
				grdCM.AddRow();
			}
			
			var fg = grdCM.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(CM_PK) = true
			fg.Cell(0, 0, CM_PK, 1, CM_PK) = "PK"

			fg.MergeCol(CM_NO) = true
			fg.Cell(0, 0, CM_NO, 1, CM_NO) = "No"

			fg.MergeCol(CM_DES) = true
			fg.Cell(0, 0, CM_DES, 1, CM_DES) = "Description"

			fg.MergeCol(CM_LEVEL_PK) = true
			fg.Cell(0, 0, CM_LEVEL_PK, 1, CM_LEVEL_PK) = "LEVEL_PK"

			fg.MergeCol(CM_NAME) = true
			fg.Cell(0, 0, CM_NAME, 1, CM_NAME) = "Name"
			
			fg.MergeCol(CM_UOM) = true
			fg.Cell(0, 0, CM_UOM, 1, CM_UOM) = "UOM"
			
			fg.MergeCol(CM_QTY) = true
			fg.Cell(0, 0, CM_QTY, 1, CM_QTY) = "Quatity"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_DIRECT_CCY, 0, CM_DIRECT_AMT)	= "Direct Management"  
			fg.Cell(0, 1, CM_DIRECT_CCY, 1) 				= "Ccy"
			fg.Cell(0, 1, CM_DIRECT_MM, 1 ) 				= "MM"
			fg.Cell(0, 1, CM_DIRECT_UNIT_COST, 1) 			= "Unit Cost"
			fg.Cell(0, 1, CM_DIRECT_AMT, 1) 				= "Amount"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_OUTSRC_CCY, 0, CM_OUTSRC_AMT)	= "Outsrc."  
			fg.Cell(0, 1, CM_OUTSRC_CCY, 1) 				= "Ccy"
			fg.Cell(0, 1, CM_OUTSRC_MM, 1 ) 				= "MM"
			fg.Cell(0, 1, CM_OUTSRC_UNIT_COST, 1) 			= "Unit Cost"
			fg.Cell(0, 1, CM_OUTSRC_AMT, 1 ) 				= "Amount"
			
			fg.MergeCol(CM_SUM) = true
			fg.Cell(0, 0, CM_SUM, 1, CM_SUM) = "Sum"
			
			fg.MergeCol(CM_OUTSITE_PK) = true
			fg.Cell(0, 0, CM_OUTSITE_PK, 1, CM_OUTSITE_PK) = "OUTSITE_PK"

			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_OUTSITE_CODE, 0, CM_OUTSITE_NAME) = "Outside Work"  
			fg.Cell(0, 1, CM_OUTSITE_CODE, 1) 					= "Code"
			fg.Cell(0, 1, CM_OUTSITE_NAME, 1 ) 				= "Name"
			
			fg.MergeCol(CM_ORDER_STATUS) = true
			fg.Cell(0, 0, CM_ORDER_STATUS, 1, CM_ORDER_STATUS) = "Order Status"
			
			fg.MergeCol(CM_RSLT_YN) = true
			fg.Cell(0, 0, CM_RSLT_YN, 1, CM_RSLT_YN) = "A. Rslt Rcpt (Y/N)"

			fg.MergeCol(CM_PROJECT_PK) = true
			fg.Cell(0, 0, CM_PROJECT_PK, 1, CM_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(CM_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, CM_TECPS_UNDERTAKECTRTBASC_PK, 1, CM_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(CM_UNDERTAKESEQ) = true
			fg.Cell(0, 0, CM_UNDERTAKESEQ, 1, CM_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(CM_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, CM_TECPS_PERFORMBUDGETBASC_PK, 1, CM_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(CM_BOOKING_AMT) = true
			fg.Cell(0, 0, CM_BOOKING_AMT, 1, CM_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(CM_SEQ_NO) = true
			fg.Cell(0, 0, CM_SEQ_NO, 1, CM_SEQ_NO) = "SEQ"

			fg.MergeCol(CM_NUM) = true
			fg.Cell(0, 0, CM_NUM, 1, CM_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(CM_QTY)				= 7;
			ctrl.ColAlignment(CM_DIRECT_MM)			= 7;
			ctrl.ColAlignment(CM_DIRECT_UNIT_COST)	= 7;
			ctrl.ColAlignment(CM_DIRECT_AMT)		= 7;
			ctrl.ColAlignment(CM_OUTSRC_MM)			= 7;
			ctrl.ColAlignment(CM_OUTSRC_UNIT_COST)	= 7;
			ctrl.ColAlignment(CM_OUTSRC_AMT)		= 7;
			ctrl.ColAlignment(CM_SUM)				= 7;

			ctrl.ColFormat(CM_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_MM)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_AMT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_MM)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_AMT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_SUM)				= "#,###,###,###,###,###,###,###,###.##R";
		break;
		case 'grdOther':
			if (grdOther.rows < 2)
			{		
				grdOther.AddRow();
			}
			
			var fg = grdOther.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5
	
			fg.MergeCol(OTHER_PK) = true
			fg.Cell(0, 0, OTHER_PK, 1, OTHER_PK) = "PK"

			fg.MergeCol(OTHER_LEVEL_PK) = true
			fg.Cell(0, 0, OTHER_LEVEL_PK, 1, OTHER_LEVEL_PK) = "LEVEL_PK"

			fg.MergeCol(OTHER_LEVEL) = true
			fg.Cell(0, 0, OTHER_LEVEL, 1, OTHER_LEVEL) = "Level"
			
			fg.MergeCol(OTHER_SRVC_FLD) = true
			fg.Cell(0, 0, OTHER_SRVC_FLD, 1, OTHER_SRVC_FLD) = "Other Srvc Fld"

			fg.MergeCol(OTHER_NAME) = true
			fg.Cell(0, 0, OTHER_NAME, 1, OTHER_NAME) = "Name"
			
			fg.MergeCol(OTHER_STANDARD) = true
			fg.Cell(0, 0, OTHER_STANDARD, 1, OTHER_STANDARD) = "Standard"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, OTHER_UNIT, 0, OTHER_AMT) = "Execution(adjustment)"  
			fg.Cell(0, 1, OTHER_UNIT, 1) 	= "Unit"
			fg.Cell(0, 1, OTHER_CCY, 1) 	= "CYY"
			fg.Cell(0, 1, OTHER_QTY, 1) 	= "Q'ty"
			fg.Cell(0, 1, OTHER_UNIT_PRICE, 1) 	= "U/P"
			fg.Cell(0, 1, OTHER_AMT, 1) 	= "Amount"
			
			fg.MergeCol(OTHER_ORDER_PK) = true
			fg.Cell(0, 0, OTHER_ORDER_PK, 1, OTHER_ORDER_PK) = "ORDER_PK"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, OTHER_ORDER_CODE, 0, OTHER_ORDER_NAME) = "Order W. Div."  
			fg.Cell(0, 1, OTHER_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, OTHER_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(OTHER_ORDER_STATUS) = true
			fg.Cell(0, 0, OTHER_ORDER_STATUS, 1, OTHER_ORDER_STATUS) = "Order Status"

			fg.MergeCol(OTHER_RSLT_YN) = true
			fg.Cell(0, 0, OTHER_RSLT_YN, 1, OTHER_RSLT_YN) = "A. Rslt Rcpt (Y/N)"
			
			fg.MergeCol(OTHER_PROJECT_PK) = true
			fg.Cell(0, 0, OTHER_PROJECT_PK, 1, OTHER_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(OTHER_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, OTHER_TECPS_UNDERTAKECTRTBASC_PK, 1, OTHER_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(OTHER_UNDERTAKESEQ) = true
			fg.Cell(0, 0, OTHER_UNDERTAKESEQ, 1, OTHER_UNDERTAKESEQ) = "UNDERTAKE_SEQ"
			
			fg.MergeCol(OTHER_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, OTHER_TECPS_PERFORMBUDGETBASC_PK, 1, OTHER_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(OTHER_BOOKING_AMT) = true
			fg.Cell(0, 0, OTHER_BOOKING_AMT, 1, OTHER_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(OTHER_SEQ_NO) = true
			fg.Cell(0, 0, OTHER_SEQ_NO, 1, OTHER_SEQ_NO) = "SEQ"

			fg.MergeCol(OTHER_NUM) = true
			fg.Cell(0, 0, OTHER_NUM, 1, OTHER_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(OTHER_QTY)			= 7;
			ctrl.ColAlignment(OTHER_UNIT_PRICE)		= 7;
			ctrl.ColAlignment(OTHER_AMT)			= 7;

			ctrl.ColFormat(OTHER_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(OTHER_UNIT_PRICE)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(OTHER_AMT)				= "#,###,###,###,###,###,###,###,###.##R";
		break;
	}	
}
 //---------------------------------------------------------
 function BindingDataList()
 {
	var data = '';
	data = "DATA|ALL|Select All|1|Level Code|2|Std|3|Wgt|4|Compared w/|5|Compared w/|6|Order Work|7|Order W. Div|8|Exec Y/N|9|Bdgt Code|10|Std PBS|11|Dlvr. Terms|12|Dlvr.(Y/N)|13|Cont. Dtals";
	//lstColumn.SetDataText(data);
	//lstColumn.value = '';
	
	data = "DATA|ALL|Select All|N|Non-Cont.|Y|Cont.";
	//lstContract_YN.SetDataText(data);
	//lstContract_YN.value = 'ALL';

	data = "DATA|ALL|Select All|1|Raw Mtrl. Cost|2|Labor Cost|3|Outsrc. Cost|4|Exp.";
	//lstBudgetItem.SetDataText(data);
	//lstBudgetItem.value = 'ALL';
	
	data = "DATA|ALL|Select All|1|Working Item No.|2|Name|3|Standard|4|Budget Code|5|Standard PBS";
	lstFilter1.SetDataText(data);
	lstFilter1.value = 'ALL';

	data = "DATA|ALL|Select All|1|Code|2|Name|3|Standard|4|Order W. Code|5|Budget Code|6|Standard Code";
	lstFilter2.SetDataText(data);
	lstFilter2.value = 'ALL';

	data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code";
	lstFilter4.SetDataText(data);
	lstFilter4.value = 'ALL';

	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
	lstCOMPANY.SetDataText(ls_company);
	lstCOMPANY.value = "<%=session("company_pk") %>";

	// Equiment
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 13,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 5 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 19,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
	

	// Contruction
	//Exec.YN
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 15,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 4 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 22,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

	// CM
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>|#;";

	grdCM.SetComboFormat(7, data);
	grdCM.SetComboFormat(11, data);

	<%=ESysLib.SetGridColumnComboFormat("grdCM", 5 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdCM", 20,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 

	// OTHER
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 14,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 6 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 7,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
 }

function OnEntryLevelCode()
{
    var path = System.RootURL + '/form/kp/bp/kpbp00050_popup_level.aspx';
	var aValue = System.OpenModal( path ,1024 , 500 , 'resizable:yes;status:yes');
}

function OnNew()
{
	if (txtProjectPk.text == '' )
	{
		alert('Please select Project !!');
	} 
	else
	{
		var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown_1.aspx?Project_Pk=' + txtProjectPk.text;
		var aValue = System.OpenModal( path ,900 , 500 , 'resizable:yes;status:yes');

		var object;
		 if(aValue != null)
		 {
			switch(idTab.GetCurrentPageNo())
			{
				case 0:
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];

						//if(!CheckDuplicateLevel(grdEQ, object[2], object[1])) return;
						grdEQ.AddRow();
						
						if(grdEQ.rows <= 3)
						{
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL_PK						, object[2]);				// pk
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL						, 'Level ' + object[3]);	// level
							grdEQ.SetGridText(grdEQ.rows-1, EQ_NAME							, object[1]);				// name
							grdEQ.SetGridText(grdEQ.rows-1, EQ_QTY							, 1);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_UNIT_COST					, 0);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_AMT							, 0);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_ORDER_STATUS					, 'C');
							grdEQ.SetGridText(grdEQ.rows-1, EQ_PROJECT_PK					, txtProjectPk.text);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_TECPS_PERFORMBUDGETBASC_PK	, lstBudgetNo.value);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_UNDERTAKESEQ					, lstBudgetNo.GetText());
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL_NUM					, 1);
						}
						else
						{							
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL_PK						, object[2]);				// pk
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL						, 'Level ' + object[3]);	// level
							grdEQ.SetGridText(grdEQ.rows-1, EQ_NAME							, object[1]);				// name
							grdEQ.SetGridText(grdEQ.rows-1, EQ_QTY							, 1);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_UNIT_COST					, 0);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_AMT							, 0);
							grdEQ.SetGridText(grdEQ.rows-1, EQ_ORDER_STATUS					, 'C');
							grdEQ.SetGridText(grdEQ.rows-1, EQ_PROJECT_PK					, grdEQ.GetGridData(grdEQ.rows-2, EQ_PROJECT_PK));
							grdEQ.SetGridText(grdEQ.rows-1, EQ_TECPS_PERFORMBUDGETBASC_PK	, grdEQ.GetGridData(grdEQ.rows-2, EQ_TECPS_PERFORMBUDGETBASC_PK));
							grdEQ.SetGridText(grdEQ.rows-1, EQ_UNDERTAKESEQ					, grdEQ.GetGridData(grdEQ.rows-2, EQ_UNDERTAKESEQ));
							grdEQ.SetGridText(grdEQ.rows-1, EQ_SEQ_NO						, grdEQ.GetGridData(grdEQ.rows-2, EQ_SEQ_NO));
							grdEQ.SetGridText(grdEQ.rows-1, EQ_LEVEL_NUM					, 1);
						}
					}
				break;

				case 1:
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];
                        
						if(!CheckDuplicateLevel(grdCONS, object[2], object[1])) return;
						
						grdCONS.AddRow();
						
						if(grdCONS.rows <= 3)
						{
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_PK					, object[2]);			    // pk
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL						, 'Level ' + object[3]);	// level
							grdCONS.SetGridText(grdCONS.rows-1, CONS_CODE						, object[0]);	            // code
							grdCONS.SetGridText(grdCONS.rows-1, CONS_NAME						, object[1]);				// name
							
							grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK					, txtProjectPk.text);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK	, lstBudgetNo.value);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ				, lstBudgetNo.GetText());
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_NUM				    , 1);
						}
						else
						{
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_PK					, object[2]);			    // pk
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL						, 'Level ' + object[3]);	// level
							grdCONS.SetGridText(grdCONS.rows-1, CONS_CODE						, object[0]);	            // code
							grdCONS.SetGridText(grdCONS.rows-1, CONS_NAME						, object[1]);				// name
							
							grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK					, grdCONS.GetGridData(grdCONS.rows-2, CONS_PROJECT_PK));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK	, grdCONS.GetGridData(grdCONS.rows-2, CONS_TECPS_PERFORMBUDGETBASC_PK));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ				, grdCONS.GetGridData(grdCONS.rows-2, CONS_UNDERTAKESEQ));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_SEQ_NO						, grdCONS.GetGridData(grdCONS.rows-2, CONS_SEQ_NO));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_NUM				    , 1);
						}
							
						for (col = CONS_STAN; col <= CONS_RSLT_YN; col++)
						{
						    grdCONS.SetGridText(grdCONS.rows-1, col, '');
						}
					}
				break;
				case 2:
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];

						//if(!CheckDuplicateLevel(grdCM, object[2], object[1])) return;
						grdCM.AddRow();

						if(grdCM.rows <= 3)
						{							
							grdCM.SetGridText(grdCM.rows-1, CM_LEVEL_PK						, object[2]);			// pk
							grdCM.SetGridText(grdCM.rows-1, CM_NAME							, object[1]);				// name
							grdCM.SetGridText(grdCM.rows-1, CM_QTY							, 1);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_MM					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_UNIT_COST				, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_AMT					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_MM					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_UNIT_COST				, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_AMT					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_SUM							, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_PROJECT_PK					, txtProjectPk.text);
							grdCM.SetGridText(grdCM.rows-1, CM_TECPS_PERFORMBUDGETBASC_PK	, lstBudgetNo.value);
							grdCM.SetGridText(grdCM.rows-1, CM_UNDERTAKESEQ					, lstBudgetNo.GetText());
						}
						else
						{
							grdCM.SetGridText(grdCM.rows-1, CM_LEVEL_PK						, object[2]);			// pk
							grdCM.SetGridText(grdCM.rows-1, CM_NAME							, object[1]);				// name
							grdCM.SetGridText(grdCM.rows-1, CM_QTY							, 1);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_MM					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_UNIT_COST				, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_DIRECT_AMT					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_MM					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_UNIT_COST				, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_OUTSRC_AMT					, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_SUM							, 0);
							grdCM.SetGridText(grdCM.rows-1, CM_PROJECT_PK					, txtProjectPk.text);
							grdCM.SetGridText(grdCM.rows-1, CM_TECPS_PERFORMBUDGETBASC_PK	, grdCM.GetGridData(grdCM.rows-2, CM_TECPS_PERFORMBUDGETBASC_PK));
							grdCM.SetGridText(grdCM.rows-1, CM_UNDERTAKESEQ					, grdCM.GetGridData(grdCM.rows-2, CM_UNDERTAKESEQ));
							grdCM.SetGridText(grdCM.rows-1, CM_SEQ_NO						, grdCM.GetGridData(grdCM.rows-2, CM_SEQ_NO));
						}
					}
				break;

				case 3:
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];
							
						//if(!CheckDuplicateLevel(grdOther, object[2], object[1])) return;
						grdOther.AddRow();

						if(grdOther.rows <= 3)
						{
							grdOther.SetGridText(grdOther.rows-1, OTHER_LEVEL_PK				, object[2]);			// pk
							grdOther.SetGridText(grdOther.rows-1, OTHER_LEVEL					, 'Level ' + object[3]);	// level
							grdOther.SetGridText(grdOther.rows-1, OTHER_NAME					, object[1]);			// name
							grdOther.SetGridText(grdOther.rows-1, OTHER_QTY						, 1);
							grdOther.SetGridText(grdOther.rows-1, OTHER_UNIT_PRICE				, 0);
							grdOther.SetGridText(grdOther.rows-1, OTHER_AMT						, 0);
							grdOther.SetGridText(grdOther.rows-1, OTHER_PROJECT_PK				, txtProjectPk.text);
							grdOther.SetGridText(grdOther.rows-1, OTHER_TECPS_PERFORMBUDGETBASC_PK	,lstBudgetNo.value);
							grdOther.SetGridText(grdOther.rows-1, OTHER_UNDERTAKESEQ			, lstBudgetNo.GetText());
						}
						else
						{
							grdOther.SetGridText(grdOther.rows-1, OTHER_LEVEL_PK				, object[2]);			// pk
							grdOther.SetGridText(grdOther.rows-1, OTHER_LEVEL					, 'Level ' + object[3]);	// level
							grdOther.SetGridText(grdOther.rows-1, OTHER_NAME					, object[1]);			// name
							grdOther.SetGridText(grdOther.rows-1, OTHER_QTY						, 1);
							grdOther.SetGridText(grdOther.rows-1, OTHER_UNIT_PRICE				, 0);
							grdOther.SetGridText(grdOther.rows-1, OTHER_AMT						, 0);
							grdOther.SetGridText(grdOther.rows-1, OTHER_PROJECT_PK				, txtProjectPk.text);
							grdOther.SetGridText(grdOther.rows-1, OTHER_TECPS_PERFORMBUDGETBASC_PK	,grdOther.GetGridData(grdOther.rows-2, OTHER_TECPS_PERFORMBUDGETBASC_PK));
							grdOther.SetGridText(grdOther.rows-1, OTHER_UNDERTAKESEQ			, grdOther.GetGridData(grdOther.rows-2, OTHER_UNDERTAKESEQ));
							grdOther.SetGridText(grdOther.rows-1, OTHER_SEQ_NO						, grdOther.GetGridData(grdOther.rows-2, OTHER_SEQ_NO));
						}
					}
				break;
			}
		}
	} 
}

function OnNewFree()
{
    if (txtProjectPk.text == '' )
	{
		alert('Please select Project !!');
	} 
	else
	{
	    switch (idTab.GetCurrentPageNo())
	    {
		    case 0:
		    break;
		    case 1:
		        if (grdCONS.row == -1)
		        {
		            alert('Please, select one row.');
		            return;
		        }
		        
		        var level_pk = grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK)		        
		        if (level_pk != '')
		        {
	                var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Item.aspx?p_project_pk=" + txtProjectPk.text
                    + "&p_project_cd=" + txtProject_Cd.text + "&p_project_nm=" + txtProject_Nm.text
                    + "&p_level_pk=" + grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK)
                    + "&p_status=ADD";
                    
                    var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            	    
                    var temp;
                    if(object != null)
                    {
                        for (i = 0; i < object.length; i++)
                        {
                            temp = object[i];
                                                        
				            // by level_code
                            if(!CheckDuplicateLevelChild(grdCONS, grdCONS.row, level_pk, temp[3], temp[4])) return;
                            
                            grdCONS.AddRow();
                            grdCONS.SetGridText(grdCONS.rows-1, CONS_PARENT_PK , grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK));
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_NUM, Number(grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_NUM)) + 1);
		                    grdCONS.SetGridText(grdCONS.rows-1, CONS_QTY, 1);		            
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_RAW						, 0);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR						, 0);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_EXP_UP						, 0);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR_UNIT_PRICE			, 0);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_AMT						, 0);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK, txtProjectPk.text);
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_UNDERTAKECTRTBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_UNDERTAKECTRTBASC_PK));
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_PERFORMBUDGETBASC_PK));
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ, grdCONS.GetGridData(grdCONS.row, CONS_UNDERTAKESEQ));
				            grdCONS.SetGridText(grdCONS.rows-1, CONS_SEQ_NO, grdCONS.GetGridData(grdCONS.row, CONS_SEQ_NO));
                            grdCONS.SetGridText(grdCONS.rows-1, CONS_CODE,          temp[4]);
                            grdCONS.SetGridText(grdCONS.rows-1, CONS_NAME,          temp[5]);
                            grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_ITEM_PK, temp[3]);
                        }
                    }
                }
                else
                {
                    alert('Please, Select Level Code.');
                }
                
                /*
		        grdCONS.AddRow();
		        if (grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK) != '')
		        {
		            grdCONS.SetGridText(grdCONS.rows-1, CONS_PARENT_PK , grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK));
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_NUM, Number(grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_NUM)) + 1);
		            grdCONS.SetGridText(grdCONS.rows-1, CONS_QTY, 1);		            
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_RAW						, 0);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR						, 0);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_EXP_UP						, 0);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR_UNIT_PRICE			, 0);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_AMT						, 0);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK, txtProjectPk.text);
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_UNDERTAKECTRTBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_UNDERTAKECTRTBASC_PK));
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_PERFORMBUDGETBASC_PK));
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ, grdCONS.GetGridData(grdCONS.row, CONS_UNDERTAKESEQ));
				    grdCONS.SetGridText(grdCONS.rows-1, CONS_SEQ_NO, grdCONS.GetGridData(grdCONS.row, CONS_SEQ_NO));
				}
				else
				{
				    if (grdCONS.GetGridData(grdCONS.row, CONS_PARENT_PK) != '')
				    {
				        grdCONS.SetGridText();
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_PARENT_PK, grdCONS.GetGridData(grdCONS.row, CONS_PARENT_PK));
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL_NUM, grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_NUM));
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_QTY, 1);
					    grdCONS.SetGridText(grdCONS.rows-1, CONS_RAW						, 0);
					    grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR						, 0);
					    grdCONS.SetGridText(grdCONS.rows-1, CONS_EXP_UP						, 0);
					    grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR_UNIT_PRICE			, 0);
					    grdCONS.SetGridText(grdCONS.rows-1, CONS_AMT						, 0);
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK, txtProjectPk.text);
    				    grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_UNDERTAKECTRTBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_UNDERTAKECTRTBASC_PK));
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK, grdCONS.GetGridData(grdCONS.row, CONS_TECPS_PERFORMBUDGETBASC_PK));
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ, grdCONS.GetGridData(grdCONS.row, CONS_UNDERTAKESEQ));
				        grdCONS.SetGridText(grdCONS.rows-1, CONS_SEQ_NO, grdCONS.GetGridData(grdCONS.row, CONS_SEQ_NO));    
				    }
				}	
				*/			
		    break;
		    case 2:
		    break;
		    case 3:
		    break;
	    }
	}   
}

function CheckDuplicateLevel(grd, level_pk, level_name, level_num)
{
    switch (grd.id)
    {
	    case 'grdEQ':	
		    for(var i = 2; i < grd.rows; i++)
		    {
			    if(grd.GetGridData(i, EQ_LEVEL_PK) == level_pk)
			    {
				     alert("Duplicated Level Code : " + level_name);
				     return false ;
			    }
		    }
		    return true;
	    break;
	    case 'grdCONS':
		    for(var i = 2; i < grd.rows; i++)
		    {
			    if(grd.GetGridData(i, CONS_LEVEL_PK) == level_pk)
			    {
				     alert("Duplicated Level Code : " + level_name);
				     return false ;
			    }
		    }
		    return true;
	    break;
	    case 'grdCM':
		    for(var i = 2; i < grd.rows; i++)
		    {
			    if(grd.GetGridData(i, CM_LEVEL_PK) == level_pk)
			    {
				     alert("Duplicated Level Code : " + level_name);
				     return false ;
			    }
		    }
		    return true;
	    break
	    case 'grdOther':
		    for(var i = 2; i < grd.rows; i++)
		    {
			    if(grd.GetGridData(i, OTHER_LEVEL_PK) == level_pk)
			    {
				     alert("Duplicated Level Code : " + level_name);
				     return false ;
			    }
		    }
		    return true;
	    break;
    }
}

function CheckDuplicateLevelChild(grd, num, level_pk, item_pk, item_code)
{
    switch (grd.id)
    {
	    case 'grdEQ':
	    break;
	    case 'grdCONS':
		    for(var i = num; i < grd.rows; i++)
		    {
		        if (grd.GetGridData(i, CONS_PARENT_PK) == level_pk)
		        {		        
			        if(grd.GetGridData(i, CONS_TECPS_ITEM_PK) == item_pk)
			        {
				         alert("Duplicated Item : " + item_code);
				         return false ;
			        }
			    }
			    else
			    {
			        return true;    
			    }
		    }
		    return true;
	    break;
	    case 'grdCM':
	    break;
	    case 'grdOther':
	    break;
    }
}

function OnSave()
{
	flag = '';
	switch(idTab.GetCurrentPageNo())
	{
		case 0:
			grdEQ.SetAllRowStatusModify();
			dso_grdEQ.Call();
		break;
		case 1:
//		    for(row = 2; row < grdCONS.rows; row++)
//		    {   
//		        if (grdCONS.GetGridData(row, CONS_LEVEL_NUM) == 1)
//	            {   
//	                grdCONS.SetGridText(row, CONS_STAN          , '');
//	                grdCONS.SetGridText(row, CONS_UNIT          , '');
//	                grdCONS.SetGridText(row, CONS_CCY           , '');
//	                grdCONS.SetGridText(row, CONS_QTY           , '');
//	                grdCONS.SetGridText(row, CONS_ORDER_PK      , '');
//	                grdCONS.SetGridText(row, CONS_ORDER_CODE    , '');
//	                grdCONS.SetGridText(row, CONS_ORDER_NAME    , '');
//	                grdCONS.SetGridText(row, CONS_EXEC_YN       , '');
//	                grdCONS.SetGridText(row, CONS_DIR_MGT       , '');
//	                grdCONS.SetGridText(row, CONS_BUDGET_PK     , '');
//	                grdCONS.SetGridText(row, CONS_BUDGET_CODE   , '');
//	                grdCONS.SetGridText(row, CONS_STAN_CODE     , '');
//	                grdCONS.SetGridText(row, CONS_CALC_BASIC    , '');
//	                grdCONS.SetGridText(row, CONS_RSLT_YN       , '');
//	                grdCONS.SetGridText(row, CONS_ORDER_STA     , '');
//	            }
//		    }		
			dso_grdCONS.Call();
		break;
		case 2:
			grdCM.SetAllRowStatusModify();
			dso_grdCM.Call();
		break;
		case 3:
			grdOther.SetAllRowStatusModify();
			dso_grdOther.Call();
		break;
	}
}

function OnDelete()
{
	switch(idTab.GetCurrentPageNo())
	{
		case 0:
			dso_grdEQ.RemoveRowAt(grdEQ.row);
		break;
		case 1:
		    if(confirm("Are you sure to delete !!!"))
            {
                for (row = 2; row < grdCONS.rows; row++)
                {
                    if (grdCONS.GetGridControl().isSelected(row))
                    {
                        if (grdCONS.GetGridData(grdCONS.row, CONS_PK) == '')
                        {						            				
                            dso_grdCONS.RemoveRowAt(row);
                        }        			
                        else 
                        {  
                            grdCONS.DeleteRowAt(row);
                        }
                    }
                }
            }       
		break;
		case 2:
			dso_grdCM.RemoveRowAt(grdCM.row);
		break;
		case 3:
			dso_grdOther.RemoveRowAt(grdOther.row);
		break;
	}
}

function OnUnDelete()
{
	switch(idTab.GetCurrentPageNo())
	{
		case 0:
			dso_grdEQ.RemoveRowAt(grdEQ.row);
		break;
		case 1:
            for (row = 2; row < grdCONS.rows; row++)
            {
                if (grdCONS.GetGridControl().isSelected(row))
                {
                    grdCONS.UnDeleteRowAt(row);
                }
            }   
		break;
		case 2:
			dso_grdCM.RemoveRowAt(grdCM.row);
		break;
		case 3:
			dso_grdOther.RemoveRowAt(grdOther.row);
		break;
	}
}

function onPrint(n)
{
    switch (n)
    {
        case 1:
	        switch(idTab.GetCurrentPageNo())
	        {
		        case 0:
			        var path = System.RootURL + "/reports/kp/bm/kpbm00050_eq.aspx?p_project_pk=" + txtProjectPk.text
			        + "&p_budget_no="	+ lstBudgetNo.value + "&p_work="		+ txtWork_Breakdown.text
			        + "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			        + "&p_filter="		+ txtFilter1.text;
			        System.OpenTargetPage(path , 'newform');
		        break;
		        case 1:
			        var path = System.RootURL + "/reports/kp/bm/kpbm00050_cons.aspx?p_project_pk=" + txtProjectPk.text
			        + "&p_budget_no="	+ lstBudgetNo.value + "&p_work="		+ txtWork_Breakdown.text
			        + "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			        + "&p_filter="		+ txtFilter1.text;
			        System.OpenTargetPage(path , 'newform');
		        break;
		        case 2:
			        var path = System.RootURL + "/reports/kp/bm/kpbm00050_cm.aspx?p_project_pk=" + txtProjectPk.text
			        + "&p_budget_no="	+ lstBudgetNo.value + "&p_work="		+ txtWork_Breakdown.text
			        + "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			        + "&p_filter="		+ txtFilter1.text;
			        System.OpenTargetPage(path , 'newform');
		        break;
		        case 3:
			        var path = System.RootURL + "/reports/kp/bm/kpbm00050_other.aspx?p_project_pk=" + txtProjectPk.text
			        + "&p_budget_no="	+ lstBudgetNo.value + "&p_work="		+ txtWork_Breakdown.text
			        + "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			        + "&p_filter="		+ txtFilter1.text;
			        System.OpenTargetPage(path , 'newform');
		        break;
	        }
        break;
        case 2:
            var path = System.RootURL + "/reports/kp/bm/rpt_kpbm215_summary.aspx?p_project_pk=" + txtProjectPk.text + "&p_budget_pk="	+ lstBudgetNo.value;
            System.OpenTargetPage(path , 'newform');
        break;
    }
}

function OnReceiveData(obj)
{
	switch(obj.id)
	{
		case 'dso_BudgetNo':
			//dso_grdEQ.Call('SELECT');
			OnChangeCB();
		break;
		case 'dso_grdEQ':
			if (chkQty.value == 'Y')
			{
				for (row = 2; row < grdEQ.rows; row++ )
				{
					if (grdEQ.GetGridData(row, EQ_QTY) == 0)
					{
						grdEQ.GetGridControl().RowHidden(row) = true;
					}

					if(grdEQ.GetGridData(row, EQ_PK) == '' && grdEQ.GetGridData(row, EQ_TECPS_UNDERTAKECTRTBASC_PK) != '')
					{
						grdEQ.SetCellBgColor(row, 0, row, grdEQ.cols-1, 0x0000FF);
					}
				}
			}

			if (flag == '')
			{
				dso_grdEQ_Pro.Call();
			}
			else
			{
				Merge_grid(grdEQ);
				
				// perform chua nhap, lay tu contract detail qua
				if (grdEQ.rows <= 2)
				{
					txtBudgetNo.text = lstBudgetNo.GetText();
					dso_grdEQ_UNDERTAKE.Call('SELECT');
				}
				else
				{				
					if (lstBudgetNo.GetText() != 0)
					{
						for (row = 2; row < grdEQ.rows; row++ )
						{
							grdEQ.SetGridText(row, EQ_TECPS_PERFORMBUDGETBASC_PK,	lstBudgetNo.value);
							grdEQ.SetGridText(row, EQ_UNDERTAKESEQ, lstBudgetNo.GetText());
						}
					}

					return;
					if (flag == 'SELECT')
						dso_grdCONS.Call('SELECT');
				}
			}
		break;
		case 'dso_grdEQ_Pro':
			OnSearch('EQ');
		break;
		case 'dso_grdCONS':
		    var ctl = grdCONS.GetGridControl();
		    
		    for (row = 2; row < grdCONS.rows; row++)
            {
                if ( grdCONS.GetGridData(row, CONS_LEVEL_NUM) == "1" )
                { 
		            grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols - 1, Number('0XF4E6E0'));
		        }		        
            }
			
            //Merge_grid(grdCONS);
                     
            var j;
			if (chkQty.value == 'Y')
			{
				for (row = 2; row < grdCONS.rows; row++ )
				{
                    if (grdCONS.GetGridData(row, CONS_LEVEL_NUM) != 1)
                    {				    
                        if (grdCONS.GetGridData(row, CONS_QTY) == 0)
                        {
                            grdCONS.GetGridControl().RowHidden(row) = true;
                        }					
                    }
                    
				    if(grdCONS.GetGridData(row, CONS_PK) == '' && grdCONS.GetGridData(row, CONS_TECPS_UNDERTAKECTRTBASC_PK) != '')
				    {
				        // lay tu 1.2.3 qua
					    grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols-1, 0x0000FF);
				    }
				}
			}
                    
			if (flag == '')
			{
			    dso_grdCONS_Pro.Call();
			    
//			    if(!cons_123)
//				{
//			        dso_grdCONS_Pro.Call();
//				}
//				else
//				{
//				    Merge_grid(grdCONS);
//				}
			}
			else
			{
				Merge_grid(grdCONS);

				// perform chua nhap, lay tu contract detail qua
				if (grdCONS.rows <= 2)
				{
					txtBudgetNo.text = lstBudgetNo.GetText();
					dso_grdCONS_UNDERTAKE.Call('SELECT');
				}
				else
				{
					if (lstBudgetNo.GetText() != 0)
					{
						for (row = 2; row < grdCONS.rows; row++ )
						{
							grdCONS.SetGridText(row, CONS_TECPS_PERFORMBUDGETBASC_PK,	lstBudgetNo.value);
							grdCONS.SetGridText(row, CONS_UNDERTAKESEQ, lstBudgetNo.GetText());
						}
					}
				}
			}
		break;
		case 'dso_grdCONS_Pro':
			OnSearch('CONS');
		break;
		case 'dso_grdCM':
			if (chkQty.value == 'Y')
			{
				for (row = 2; row < grdCM.rows; row++ )
				{
					if (grdCM.GetGridData(row, CM_QTY) == 0)
					{
						grdCM.GetGridControl().RowHidden(row) = true;
					}

					if(grdCM.GetGridData(row, CM_PK) == '' && grdCM.GetGridData(row, CM_TECPS_UNDERTAKECTRTBASC_PK) != '')
					{
						grdCM.SetCellBgColor(row, 0, row, grdCM.cols-1, 0x0000FF);
					}
				}
			}

			if (flag == '')
			{
				dso_grdCM_Pro.Call();
			}
			else
			{
				Merge_grid(grdCM);

				// perform chua nhap, lay tu contract detail qua
				if (grdCM.rows <= 2)
				{
					txtBudgetNo.text = lstBudgetNo.GetText();
					dso_grdCM_UNDERTAKE.Call('SELECT');
				}
				else
				{
					if (lstBudgetNo.GetText() != 0)
					{
						for (row = 2; row < grdCM.rows; row++ )
						{
							grdCM.SetGridText(row, CM_TECPS_PERFORMBUDGETBASC_PK,	lstBudgetNo.value);
							grdCM.SetGridText(row, CM_UNDERTAKESEQ, lstBudgetNo.GetText());
						}
					}
					
					return;
					if (flag == 'SELECT')
						dso_grdOther.Call('SELECT');
				}
			}
		break;
		case 'dso_grdCM_Pro':
			OnSearch('CM');
		break;
		case 'dso_grdOther':
			if (chkQty.value == 'Y')
			{
				for (row = 2; row < grdOther.rows; row++ )
				{
					if (grdOther.GetGridData(row, OTHER_QTY) == 0)
					{
						grdOther.GetGridControl().RowHidden(row) = true;
					}

					if(grdOther.GetGridData(row, OTHER_PK) == '' && grdOther.GetGridData(row, OTHER_TECPS_UNDERTAKECTRTBASC_PK) != '')
					{
						grdOther.SetCellBgColor(row, 0, row, grdOther.cols-1, 0x0000FF);
					}
				}
			}

			if (flag == '')
			{
				dso_grdOther_Pro.Call();
			}
			else
			{
				Merge_grid(grdOther);

				// perform chua nhap, lay tu contract detail qua
				if (grdOther.rows <= 2)
				{
					txtBudgetNo.text = lstBudgetNo.GetText();
					dso_grdOther_UNDERTAKE.Call('SELECT');
				}
				else
				{
					if (lstBudgetNo.GetText() != 0)
					{
						for (row = 2; row < grdOther.rows; row++ )
						{
							grdOther.SetGridText(row, OTHER_TECPS_PERFORMBUDGETBASC_PK,	  lstBudgetNo.value);
							grdOther.SetGridText(row, OTHER_UNDERTAKESEQ, lstBudgetNo.GetText());
						}
					}
				}
			}
		break;
		case 'dso_grdOther_Pro':
			OnSearch('OTHER');
		break;
		case 'dso_grdEQ_UNDERTAKE':
			for (row = 2; row < grdEQ.rows; row++ )
			{
				if(grdEQ.GetGridData(row, EQ_PK) == '')
				{
					grdEQ.SetCellBgColor(row, 0, row, grdEQ.cols-1, 0x0000FF);
				}
			}
			Merge_grid(grdEQ);
			//dso_grdCONS.Call('SELECT');
		break;
		case 'dso_grdCONS_UNDERTAKE':
			for (row = 2; row < grdCONS.rows; row++ )
			{
				if(grdCONS.GetGridData(row, CONS_PK) == '')
				{
					grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols-1, 0x3366CC);
					//cons_123 = true;
				}
			}
			Merge_grid(grdCONS);
			//dso_grdCM.Call('SELECT');
		break;
		case 'dso_grdCM_UNDERTAKE':
			for (row = 2; row < grdCM.rows; row++ )
			{
				if(grdCM.GetGridData(row, CM_PK) == '')
				{
					grdCM.SetCellBgColor(row, 0, row, grdCM.cols-1, 0x0000FF);
				}
			}
			Merge_grid(grdCM);
			//dso_grdOther.Call('SELECT');
		break;
		case 'dso_grdOther_UNDERTAKE':
			for (row = 2; row < grdOther.rows; row++ )
			{
				if(grdOther.GetGridData(row, OTHER_PK) == '')
				{
					grdOther.SetCellBgColor(row, 0, row, grdOther.cols-1, 0x0000FF);
				}
			}
			Merge_grid(grdOther);
		break;
	}
}

function Find_Heigher_Level(grd, value, row)
{
	var i = row;
    if ( grd.GetGridData(row, CONS_LEVEL_NUM) == "1" )
    { 
		grd.SetCellBgColor(row, 0, row, grd.cols - 1, 0xEDEDED);
		
        return 0;
    }    
    else
    {
        while (i >= 1)
        {
            if ( grd.GetGridData(i, CONS_LEVEL_NUM) == value - 1 )
            {
                return i;
            }
            i = i - 1
        }
    }    
}

function OnEdit(obj)
{
return;
	switch(obj.id)
	{
		case 'grdEQ':	
			if (grdEQ.col == EQ_ORDER_CODE ||
				grdEQ.col == EQ_ORDER_NAME ||
				grdEQ.col == EQ_BUDGET_CODE)
			{
				grdEQ.row = -1;
			}
		case 'grdCONS':			
			if (grdCONS.col == CONS_ORDER_CODE ||
				grdCONS.col == CONS_ORDER_NAME ||
				grdCONS.col == CONS_BUDGET_CODE)
			{
				grdCONS.row = -1;
			}
		break;
		case 'grdCM':
			if (grdCM.col == CM_OUTSITE_CODE ||
				grdCM.col == CM_OUTSITE_NAME)
			{
				grdCM.row = -1;
			}
		break;
		case 'grdOther':
			if (grdOther.col == OTHER_ORDER_CODE ||
				grdOther.col == OTHER_ORDER_NAME)
			{
				grdOther.row = -1;
			}
		break;
	}
}

function OnClick(obj)
{
	switch(obj.id)
	{
		case 'grdCM':
		if (grdCM.col == CM_DIRECT_MM || grdCM.col == CM_DIRECT_UNIT_COST ||
			grdCM.col == CM_OUTSRC_MM || grdCM.col == CM_OUTSRC_UNIT_COST)
		{
		}
			var dir_amt = 0, outsite_amt = 0, qty = 0;
			if (grdCM.GetGridData(grdCM.row, CM_DIRECT_CCY) != '')
			{
				grdCM.SetGridText(grdCM.row, CM_OUTSRC_CCY, '')
				grdCM.SetGridText(grdCM.row, CM_OUTSRC_MM, '0');
				grdCM.SetGridText(grdCM.row, CM_OUTSRC_UNIT_COST, '0');
			}

			if (grdCM.GetGridData(grdCM.row, CM_OUTSRC_CCY) != '')
			{
				grdCM.SetGridText(grdCM.row, CM_DIRECT_CCY, '');	
				grdCM.SetGridText(grdCM.row, CM_DIRECT_MM, '0');
				grdCM.SetGridText(grdCM.row, CM_DIRECT_UNIT_COST, '0');
			}

			dir_amt		= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) * Number(obj.GetGridData(obj.row, CM_DIRECT_UNIT_COST));
			outsite_amt = Number(obj.GetGridData(obj.row, CM_OUTSRC_MM)) * Number(obj.GetGridData(obj.row, CM_OUTSRC_UNIT_COST));
			qty			= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) + Number(obj.GetGridData(obj.row, CM_OUTSRC_MM));
			
			obj.SetGridText(obj.row, CM_QTY, qty);
			obj.SetGridText(obj.row, CM_DIRECT_AMT, dir_amt);
			obj.SetGridText(obj.row, CM_OUTSRC_AMT, outsite_amt);
			obj.SetGridText(obj.row, CM_SUM, Number(dir_amt) + Number(outsite_amt));
		break;
		case 'grdOther':
			if (obj.GetRowStatus(obj.row) == 32 || obj.GetRowStatus(obj.row) == 48) // status Insert
			{
				
			}
			else
			{
				if (obj.col < OTHER_UNIT)			
					obj.row = -1;
			}
		break;
	}
}

function CheckData(obj)
{
	switch(obj.id)
	{
		case 'grdEQ':
			if (obj.col == EQ_QTY || obj.col == EQ_UNIT_COST || obj.col == EQ_WEIGHT)
			{
				if (isNaN(obj.GetGridData(obj.row, obj.col)))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}

				var amt = 0;
				amt = Number(obj.GetGridData(obj.row, EQ_QTY)) * Number(obj.GetGridData(obj.row, EQ_UNIT_COST));
				obj.SetGridText(obj.row, EQ_AMT, amt);
			}
		break;
		case 'grdCONS':
		var vNum = 0, vLabor = 0, vMat = 0, vExp = 0, vQty = 0;
        var amt = 0, unit_price = 0;
        
			if (obj.col == CONS_QTY || obj.col == CONS_RAW || obj.col == CONS_LABOR ||
				obj.col == CONS_EXP_UP|| obj.col == CONS_LABOR_UNIT_PRICE  || obj.col == CONS_CALC_BASIC )
			{
			    vNum = obj.GetGridData(obj.row, obj.col).replace(",", "").replace("\n", "").replace("\r", "");
			    
				if (isNaN(vNum))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}
                
                vMat    = obj.GetGridData(obj.row, CONS_RAW).replace(",", "").replace("\n", "").replace("\r", "");
                vLabor  = obj.GetGridData(obj.row, CONS_LABOR).replace(",", "").replace("\n", "").replace("\r", "");
                vExp    = obj.GetGridData(obj.row, CONS_EXP_UP).replace(",", "").replace("\n", "").replace("\r", "");
                vQty    = obj.GetGridData(obj.row, CONS_QTY).replace(",", "").replace("\n", "").replace("\r", "");
                
				unit_price = Number(vMat) + Number(vLabor) + Number(vExp);
				amt = Number(vQty) * Number(unit_price);

				obj.SetGridText(obj.row, CONS_LABOR_UNIT_PRICE, unit_price);
				obj.SetGridText(obj.row, CONS_AMT, amt);
			}
		break;
		case 'grdCM':
			var dir_amt = 0, outsite_amt = 0, qty = 0;
			if (obj.col == CM_DIRECT_CCY)
			{
				if (grdCM.GetGridData(grdCM.row, CM_OUTSRC_CCY) != '' || grdCM.GetGridData(grdCM.row, CM_DIRECT_CCY) == '')
				{					
					grdCM.SetGridText(grdCM.row, CM_DIRECT_CCY, '');	
					grdCM.SetGridText(grdCM.row, CM_DIRECT_MM, '0');
					grdCM.SetGridText(grdCM.row, CM_DIRECT_UNIT_COST, '0');

					dir_amt		= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) * Number(obj.GetGridData(obj.row, CM_DIRECT_UNIT_COST));
					outsite_amt = Number(obj.GetGridData(obj.row, CM_OUTSRC_MM)) * Number(obj.GetGridData(obj.row, CM_OUTSRC_UNIT_COST));
					qty			= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) + Number(obj.GetGridData(obj.row, CM_OUTSRC_MM));
					
					obj.SetGridText(obj.row, CM_QTY, qty);
					obj.SetGridText(obj.row, CM_DIRECT_AMT, dir_amt);
					obj.SetGridText(obj.row, CM_OUTSRC_AMT, outsite_amt);
					obj.SetGridText(obj.row, CM_SUM, Number(dir_amt) + Number(outsite_amt));
				}
			}

			if (obj.col == CM_OUTSRC_CCY)
			{
				if (grdCM.GetGridData(grdCM.row, CM_DIRECT_CCY) != '' || grdCM.GetGridData(grdCM.row, CM_OUTSRC_CCY) == '')
				{
					grdCM.SetGridText(grdCM.row, CM_OUTSRC_CCY, '')
					grdCM.SetGridText(grdCM.row, CM_OUTSRC_MM, '0');
					grdCM.SetGridText(grdCM.row, CM_OUTSRC_UNIT_COST, '0');

					dir_amt		= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) * Number(obj.GetGridData(obj.row, CM_DIRECT_UNIT_COST));
					outsite_amt = Number(obj.GetGridData(obj.row, CM_OUTSRC_MM)) * Number(obj.GetGridData(obj.row, CM_OUTSRC_UNIT_COST));
					qty			= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) + Number(obj.GetGridData(obj.row, CM_OUTSRC_MM));
					
					obj.SetGridText(obj.row, CM_QTY, qty);
					obj.SetGridText(obj.row, CM_DIRECT_AMT, dir_amt);
					obj.SetGridText(obj.row, CM_OUTSRC_AMT, outsite_amt);
					obj.SetGridText(obj.row, CM_SUM, Number(dir_amt) + Number(outsite_amt));
				}
			}

			if (obj.col == CM_DIRECT_MM || obj.col == CM_DIRECT_UNIT_COST)
			{
				if (isNaN(obj.GetGridData(obj.row, obj.col)))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}
				
				dir_amt		= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) * Number(obj.GetGridData(obj.row, CM_DIRECT_UNIT_COST));
				outsite_amt = Number(obj.GetGridData(obj.row, CM_OUTSRC_MM)) * Number(obj.GetGridData(obj.row, CM_OUTSRC_UNIT_COST));
				qty			= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) + Number(obj.GetGridData(obj.row, CM_OUTSRC_MM));
				
				obj.SetGridText(obj.row, CM_QTY, qty);
				obj.SetGridText(obj.row, CM_DIRECT_AMT, dir_amt);
				obj.SetGridText(obj.row, CM_OUTSRC_AMT, outsite_amt);
				obj.SetGridText(obj.row, CM_SUM, Number(dir_amt) + Number(outsite_amt));
			}

			if (obj.col == CM_OUTSRC_MM || obj.col == CM_OUTSRC_UNIT_COST)
			{
				if (isNaN(obj.GetGridData(obj.row, obj.col)))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}
				
				dir_amt		= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) * Number(obj.GetGridData(obj.row, CM_DIRECT_UNIT_COST));
				outsite_amt = Number(obj.GetGridData(obj.row, CM_OUTSRC_MM)) * Number(obj.GetGridData(obj.row, CM_OUTSRC_UNIT_COST));
				qty			= Number(obj.GetGridData(obj.row, CM_DIRECT_MM)) + Number(obj.GetGridData(obj.row, CM_OUTSRC_MM));
				
				obj.SetGridText(obj.row, CM_QTY, qty);
				obj.SetGridText(obj.row, CM_DIRECT_AMT, dir_amt);
				obj.SetGridText(obj.row, CM_OUTSRC_AMT, outsite_amt);
				obj.SetGridText(obj.row, CM_SUM, Number(dir_amt) + Number(outsite_amt));
			}
		break;
		case 'grdOther':
			if (obj.col == OTHER_QTY || obj.col == OTHER_UNIT_PRICE)
			{
				if (isNaN(obj.GetGridData(obj.row, obj.col)))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}
				var amt = 0;
				amt = Number(obj.GetGridData(obj.row, OTHER_QTY)) * Number(obj.GetGridData(obj.row, OTHER_UNIT_PRICE));
				obj.SetGridText(obj.row, OTHER_AMT, amt);
			}
		break;
	}
}

function CheckNum(obj)
{
	
}

function OnDBClick(obj)
{
	switch(obj.id)
	{
		case 'grdEQ':
			if (grdEQ.col == EQ_ORDER_CODE || grdEQ.col == EQ_ORDER_NAME)
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					grdEQ.SetGridText(grdEQ.row, EQ_ORDER_PK,   object[0]);
					grdEQ.SetGridText(grdEQ.row, EQ_ORDER_CODE, object[1]);
					grdEQ.SetGridText(grdEQ.row, EQ_ORDER_NAME, object[2]);
				}
			}

			if (grdEQ.col == EQ_BUDGET_CODE)
			{
				var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx";
				var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(object != null)
				{
					grdEQ.SetGridText(grdEQ.row, EQ_BUDGET_PK,   object[0]);
					grdEQ.SetGridText(grdEQ.row, EQ_BUDGET_CODE, object[1]);
				}
			}
		break;
		case 'grdCONS':			
			if (grdCONS.col == CONS_ORDER_CODE || grdCONS.col == CONS_ORDER_NAME)
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_PK,   object[0]);
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_CODE, object[1]);
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_NAME, object[2]);
				}
			}
			else if (grdCONS.col == CONS_BUDGET_CODE)
			{
				var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx";
				var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(object != null)
				{
					grdCONS.SetGridText(grdCONS.row, CONS_BUDGET_PK,   object[0]);
					grdCONS.SetGridText(grdCONS.row, CONS_BUDGET_CODE, object[1]);
				}
			}
			else if (grdCONS.col == CONS_CODE || grdCONS.col == CONS_NAME)
			{
			    if (grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_NUM) != '1')
			    {
			        var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Item.aspx?p_project_pk=" + txtProjectPk.text
			        + "&p_project_cd=" + txtProject_Cd.text + "&p_project_nm=" + txtProject_Nm.text
			        + "&p_level_pk=" + grdCONS.GetGridData(grdCONS.row, CONS_PARENT_PK)
			        + "&p_status=UPDATE";
			        
				    var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
    				
    				var temp;
				    if (object != null)
				    {
				        for (i = 0; i < object.length; i++)
				        {
				            temp = object[i];
				            
				            // by level_code
				            //if(!CheckDuplicateLevelChild(grdCONS, temp[3], temp[4])) return;
				            
				            grdCONS.SetGridText(grdCONS.row, CONS_CODE,          temp[4]);
				            grdCONS.SetGridText(grdCONS.row, CONS_NAME,          temp[5]);
				            grdCONS.SetGridText(grdCONS.row, CONS_TECPS_ITEM_PK, temp[3]);
				        }
				    }
				}
				else
				{
				    OnNewFree();
				}
			}
		break;
		case 'grdCM':
			if (grdCM.col == CM_OUTSITE_CODE || grdCM.col == CM_OUTSITE_NAME)
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					grdCM.SetGridText(grdCM.row, CM_OUTSITE_PK,   object[0]);
					grdCM.SetGridText(grdCM.row, CM_OUTSITE_CODE, object[1]);
					grdCM.SetGridText(grdCM.row, CM_OUTSITE_NAME, object[2]);
				}
			}
		break;
		case 'grdOther':
			if (grdOther.col == OTHER_ORDER_CODE || grdOther.col == OTHER_ORDER_NAME)
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					grdOther.SetGridText(grdOther.row, OTHER_ORDER_PK,   object[0]);
					grdOther.SetGridText(grdOther.row, OTHER_ORDER_CODE, object[1]);
					grdOther.SetGridText(grdOther.row, OTHER_ORDER_NAME, object[2]);
				}
			}
		break;
	}
}

function OnChangeCB()
{ 
	flag = 'SELECT';
	switch (idTab.GetCurrentPageNo())
	{
		case 0:
			dso_grdEQ.Call('SELECT');
		break;
		case 1:
			dso_grdCONS.Call('SELECT');
		break;
		case 2:
			dso_grdCM.Call('SELECT');
		break;
		case 3:
			dso_grdOther.Call('SELECT');
		break;
	}
}

function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, acc_pk) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}

function OnCheckCol(n)
{
	switch(idTab.GetCurrentPageNo())
	{
		case 0:			
			var fg = grdEQ.GetGridControl(); 
			switch(n)
			{
				case 1:
					if (chk1.value == 'Y')
						fg.ColHidden(EQ_LEVEL) = false;
					else
						fg.ColHidden(EQ_LEVEL) = true;
				break;
				case 2:
					if (chk2.value == 'Y')
						fg.ColHidden(EQ_STANDARD) = false;
					else
						fg.ColHidden(EQ_STANDARD) = true;
				break;
				case 3:
					if (chk3.value == 'Y')
						fg.ColHidden(EQ_WEIGHT) = false;
					else
						fg.ColHidden(EQ_WEIGHT) = true;
				break;
				case 4:

				break;
				case 5:

				break;
				case 6:					
					if (chk6.value == 'Y')
					{
						fg.ColHidden(EQ_ORDER_CODE) = false;
						fg.ColHidden(EQ_ORDER_NAME) = false;
					}
					else
					{
						fg.ColHidden(EQ_ORDER_CODE) = true;
						fg.ColHidden(EQ_ORDER_NAME) = true;
					}
				break;
				case 7:
					if (chk7.value == 'Y')
						fg.ColHidden(EQ_EX_YN) = false;
					else
						fg.ColHidden(EQ_EX_YN) = true;
				break;
				case 8:
					if (chk8.value == 'Y')
						fg.ColHidden(EQ_BUDGET_CODE) = false;
					else
						fg.ColHidden(EQ_BUDGET_CODE) = true;
				break;
				case 9:
					if (chk9.value == 'Y')
						fg.ColHidden(EQ_STANDARD_PBS) = false;
					else
						fg.ColHidden(EQ_STANDARD_PBS) = true;	
				break;
				case 10:
					if (chk10.value == 'Y')
						fg.ColHidden(EQ_DEVL_TERM) = false;
					else
						fg.ColHidden(EQ_DEVL_TERM) = true;
				break;
				case 11:
					if (chk11.value == 'Y')
						fg.ColHidden(EQ_RSLT_YN) = false;
					else
						fg.ColHidden(EQ_RSLT_YN) = true;
				break;
				case 12:

				break;
			}
		break;
		case 1:
			var fg = grdCONS.GetGridControl(); 
			switch (n)
			{
				case 1:
					if (chk21.value == 'Y')
						fg.ColHidden(CONS_LEVEL) = false;
					else
						fg.ColHidden(CONS_LEVEL) = true;
				break;	
				case 2:
					if (chk22.value == 'Y')
						fg.ColHidden(CONS_STAN) = false;
					else
						fg.ColHidden(CONS_STAN) = true;				
				break;
				case 3:
					if (chk23.value == 'Y')
					{
						fg.ColHidden(CONS_RAW) = false;
						fg.ColHidden(CONS_LABOR) = false;
						fg.ColHidden(CONS_EXP_UP) = false;
					}
					else
					{
						fg.ColHidden(CONS_RAW) = true;	
						fg.ColHidden(CONS_LABOR) = true;	
						fg.ColHidden(CONS_EXP_UP) = true;	
					}
				break;
				case 4:
					if (chk24.value == 'Y')
					{
						fg.ColHidden(CONS_ORDER_CODE) = false;
						fg.ColHidden(CONS_ORDER_NAME) = false;
					}
					else
					{
						fg.ColHidden(CONS_ORDER_CODE) = true;
						fg.ColHidden(CONS_ORDER_NAME) = true;
					}
				break;
				case 5:
					if (chk25.value == 'Y')
						fg.ColHidden(CONS_EXEC_YN) = false;
					else
						fg.ColHidden(CONS_EXEC_YN) = true;
				break;
				case 6:
					if (chk26.value == 'Y')
						fg.ColHidden(CONS_DIR_MGT) = false;
					else
						fg.ColHidden(CONS_DIR_MGT) = true;
				break;
				case 7:
					if (chk27.value == 'Y')
						fg.ColHidden(CONS_BUDGET_CODE) = false;
					else
						fg.ColHidden(CONS_BUDGET_CODE) = true;
				break;
				case 8:
					if (chk28.value == 'Y')
						fg.ColHidden(CONS_STAN_CODE) = false;
					else
						fg.ColHidden(CONS_STAN_CODE) = true;
				break;
			}
			

		break;
		case 2:
		break;
		case 3:
			var fg = grdOther.GetGridControl(); 
			switch (n)
			{
			case 1:				
				if (chk41.value == 'Y')
					fg.ColHidden(OTHER_LEVEL) = false;
				else
					fg.ColHidden(OTHER_LEVEL) = true;
			break;
			case 2:				
				if (chk42.value == 'Y')
					fg.ColHidden(OTHER_STANDARD) = false;
				else
					fg.ColHidden(OTHER_STANDARD) = true;
			break;
			case 3:				
				if (chk43.value == 'Y')
				{
					fg.ColHidden(OTHER_ORDER_CODE) = false;
					fg.ColHidden(OTHER_ORDER_NAME) = false;
				}
				else
				{
					fg.ColHidden(OTHER_ORDER_CODE) = true;
					fg.ColHidden(OTHER_ORDER_NAME) = true;
				}
			break;
			}
		break;
	}
}

function OnChangeFilter(n)
{
	switch (n)
	{
		case 1:
			if (lstFilter1.value == 'ALL') txtFilter1.text = '';
			OnSearch('EQ');
		break;
		case 2:
			if (lstFilter2.value == 'ALL') txtFilter2.text = '';
			OnSearch('CONS');
		break;
		case 4:
			if (lstFilter4.value == 'ALL') txtFilter4.text = '';
			OnSearch('OTHER');
		break;
	}
}
</script>
<html>
<body>
<gw:data id="dso_BudgetNo" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="1" type="list" procedure="EC111.SP_SEL_KPBM00050_BUDGETNO" > 
			<input> 
				<input bind="txtProjectPk" />
			</input> 
			<output>
				<output bind="lstBudgetNo" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_grdEQ" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="2" type="grid" parameter="0,1,3,5,6,7,8,9,10,11,12,15,16,18,19,20,21,22,23,24,25,27,28" function="EC111.SP_SEL_KPBM00050_EQ" procedure="EC111.SP_UPD_KPBM00050_EQ" > 
            <input bind="grdEQ">
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="txtWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter1" />
				<input bind="txtFilter1" />
            </input> 
            <output bind="grdEQ" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdEQ_UNDERTAKE" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="3" type="grid" function="EC111.SP_SEL_KPBM00050_EQ_UNDER" > 
            <input bind="grdEQ">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" /> 
            </input> 
            <output bind="grdEQ" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdEQ_Pro" onreceive="OnReceiveData(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpbm00050_eq"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
			 </input>
			 <output>
				<output bind="txtReturnValue"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_grdCONS" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="5" type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12,15,16,17,19,20,21,22,23,24,25,26,28,29,30,32,33,34,35" function="EC111.SP_SEL_KPBM00050_CONS" procedure="EC111.SP_UPD_KPBM00050_CONS" > 
            <input bind="grdCONS">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="txtWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter2" />
				<input bind="txtFilter2" />
            </input> 
            <output bind="grdCONS" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdCONS_UNDERTAKE" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="4" type="grid" function="ec111.SP_SEL_KPBM00050_CONS_UNDER" > 
            <input bind="grdCONS">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" /> 
            </input> 
            <output bind="grdCONS" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdCONS_Pro" onreceive="OnReceiveData(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpbm00050_cons"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
			 </input>
			 <output>
				<output bind="txtReturnValue"/>
			 </output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_grdCM" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="7" type="grid" parameter="0,2,3,5,6,7,8,9,10,11,12,13,14,16,19,20,21,22,23,24,26,27" function="EC111.SP_SEL_KPBM00050_CM" procedure="EC111.SP_UPD_KPBM00050_CM" > 
            <input bind="grdCM">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="txtWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
            </input> 
            <output bind="grdCM" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdCM_UNDERTAKE" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="6" type="grid" function="ec111.SP_SEL_KPBM00050_CM_UNDER" > 
            <input bind="grdCM">
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" /> 
            </input> 
            <output bind="grdCM" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdCM_Pro" onreceive="OnReceiveData(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpbm00050_cm"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
			 </input>
			 <output>
				<output bind="txtReturnValue"/>
			 </output>
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_grdOther" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="9" type="grid" parameter="0,1,3,5,6,7,8,9,10,11,14,15,16,17,18,19,21,22" function="EC111.SP_SEL_KPBM00050_OTHER" procedure="EC111.SP_UPD_KPBM00050_OTHER" > 
            <input bind="grdOther">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="txtWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter4" />
				<input bind="txtFilter4" />
            </input> 
            <output bind="grdOther" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdOther_UNDERTAKE" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="8" type="grid" function="EC111.SP_SEL_KPBM00050_OTHER_UNDER" > 
            <input bind="grdOther">
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" /> 
            </input> 
            <output bind="grdOther" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdOther_Pro" onreceive="OnReceiveData(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpbm00050_other"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
			 </input>
			 <output>
				<output bind="txtReturnValue"/>
			 </output>
		</dso> 
	</xml> 
</gw:data>
<table style="background: #BDE9FF; height: 97%; width: 100%" border="0" >
	<tr>
		<td style="width: 100%; background:white">
			<table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
				<tr style="height: 2%">
					<td style="width: 100%">
						<fieldset style="width:100%">
						<table style="width: 100%; height: 100%">
							<tr style="height: 1%">
								<td align="right" width="10%">
									<a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">
									Project&nbsp;</a>
								</td>
								<td width="50%">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="40%">
												<gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
											</td>
											<td width="60%">
												<gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
											</td>
											<td width="">
												<gw:textbox id="txtProjectPk" styles='width:100%;display:none' />
											</td>
											<td>
												<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProjectPk.text='';" />
											</td>
										</tr>											
									</table>
								 </td>
								 <td style="width: 15%" ></td>
								 <td width="25%"></td>
								 <!--td style="width: 15%" align="right">                                      
									Cont. (Y/N)
								</td>
								<td width="25%"><gw:list id="lstContract_YN" styles='width:100%' /></td-->
								<td style="width: 1%">
									<table style="width: 100%; height: 100%">
										<tr>
											<td>
												<gw:imgbtn id="ibnUpdte" img="create" alt="Entry Level Code" onclick="OnEntryLevelCode()" />
											</td>
											<td style="width: 1%" style="display:none">
												<gw:imgbtn id="btnNw" img="popup" onclick="" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnNew" img="new" alt="Add New Level Code" text="New" onclick="OnNew()" />
											</td>											
											<td style="width: 1%">
												<gw:imgbtn id="btnNew" img="new" alt="Add New Free" text="New" onclick="OnNewFree()" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()"/>
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnUnDelete" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete()"/>
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print"
													onclick="onPrint(1)" />
											</td>											
											<td style="width: 1%">
												<gw:imgbtn id="btnPrint1" img="excel" alt="Total Summary" text="Print"
													onclick="onPrint(2)" />
											</td>
										</tr>
									</table>
								</td>
							</tr>                               
							<tr>
								<td  align="right">
								<a href="#"  title="Click here to show Work Division"  onClick="OnPopUp('Work_Breakdown')" style="text-decoration:none">W. Div</a></td>
								<td >
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td style="display:none">
												<gw:textbox id="txtWork_Breakdown" styles="width:100%" onchange="OnChangeCB()" />
											</td>
											<td width="40%">
												<gw:textbox id="txtWork_Breakdown_Cd" readonly="true" styles='width:100%' />
											</td>
											<td width="60%">
												<gw:textbox id="txtWork_Breakdown_Nm" readonly="true" styles='width:100%' />
											</td>											   
											<td>
												<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtWork_Breakdown_Cd.text='';txtWork_Breakdown_Nm.text='';txtWork_Breakdown.text=''" />
											</td>
										</tr>										
									</table>
								</td>
								<!--td align="right"><a href="#"  title="Click here to show Work Division"  onClick="OnPopUp('Version')" style="text-decoration:none">Budget No.</a></td-->
								<td align="center">Budget Statement No.</td>
								<td colspan="2">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td width="28%"><gw:list id="lstBudgetNo"  styles='width:100%' onchange="OnChangeCB()" /></td>
											<!--td style="width: 20%;" align="right">
												Budget Item&nbsp;</td>
											<td style="width: 32%">
												<gw:list id="lstBudgetItem"  styles='width:100%' />
											</td-->
										</tr>
									</table>
								</td>
							</tr>
							 <tr>                                			
								<td align="right" width="10%">
									<a title="Click here to show Order Work Division" href="#" style="text-decoration: none"  onClick="OnPopUp('OutsideOrderWork')"">
										Order W. Div&nbsp;</a>
								</td>
								<td width="50%">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="40%">
												<gw:textbox id="txtOrderWork_Cd" readonly="true" styles='width:100%' />
											</td>
											<td width="60%">
												<gw:textbox id="txtOrderWork_Nm" readonly="true" styles='width:100%' />
											</td>											   
											<td>
												<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtOrderWork_Cd.text='';txtOrderWork_Nm.text='';txtOrderWork_Pk.text=''" />
											</td>
										</tr>
										
									</table>
								 </td>
								 <td align="right">
										<gw:checkbox id="chkQty" value="Y" defaultvalue="Y|N" onchange="OnChangeCB()" />
								 </td>
								 <td colspan="2">Excluding detail of which quantity is "0"</td>
							</tr>
						</table>
						</fieldset>
					</td>
				</tr>

				<tr style="height: 98%">
					<td colspan="7">
						<gw:tab id="idTab" onpageactivate="OnChangeCB()">
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%;"
								name="Equipment" id="Tab1" border="0">
								<tr style="height: 1%">
									<td  align="center" nowrap=" align="center"  style="width:10%"><gw:checkbox id="chk1" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk2" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Standard</td>
										
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk3" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Weight</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk6" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Order W. Div</td>

									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk7" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Exec Y/N</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk8" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Budget Code</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk9" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(9)" />Standard PBS</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk10" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(10)" />Dlvr. Terms</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk11" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(11)" />Dlvr.(Y/N)</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk12" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(12)" />Cont. Dtals</td>
								</tr>								
								<tr style="height: 1%">
									<td colspan="2"  align="right" style="width:20%">
										<gw:list id="lstFilter1" styles="width: 60%" onchange="OnChangeFilter(1)" />
									</td>
									
									<td colspan="2" align="center" style="width:20%">
										<gw:textbox id="txtFilter1" styles="width: 100%" />
									</td>
										
									<td colspan="2" align="right" style="width:20%">
										Total
									</td>
									
									<td colspan="2" align="center" style="width:20%">
										<gw:list id="lstTotal1" styles="width: 100%" />
									</td>

									<td colspan="2" align="right" style="width:20%">
										<gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch('EQ')" />
									</td>
								</tr>
								<tr style="height: 98%">
									<td colspan="10" style="width: 100%">
										<gw:grid id="grdEQ" header="0|1|2|3|4|5|6|7|8|9|_10|11|12|13|_14|15|16|17|18|19|_20|_21|_22|_23|_24|_25|_26|_27|_28|_29|_30" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||||||||||"
										editcol="0|0|0|1|1|1|1|1|1|0|1|0|0|1|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0" 
										widths="1000|1000|1000|1200|2000|1000|1000|1500|1000|1000|1000|1200|1000|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0|0" 
										styles="width:100%; height:100%" 
										sorting="T" debug="true"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
						   
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%;"
								name="Construction" id="Tab2" border="0">
								<tr style="height: 1%">	
									<td  align="center" nowrap=" align="center" " style="width:10%"><gw:checkbox id="chk21" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
									
									<td  align="center" align="center"  style="width:10%"><gw:checkbox id="chk22" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Std</td>
										
									<td colspan="2" align="center" nowrap align="center"  style="width:10%"><gw:checkbox id="chk23" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Raw Mtrl/Labor/Exp</td>
									
									<td  align="center"  align="center"  style="width:10%"><gw:checkbox id="chk24" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(4)" />Order W.</td>

									<td  align="center"  align="center"  style="width:10%"><gw:checkbox id="chk25" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(5)" />Exec Y/N</td>
									
									<td colspan="2" align="center" nowrap align="center"  style="width:10%"><gw:checkbox id="chk26" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Dir. Mgt Outsrc.</td>
									
									<td  align="center"  align="center"  style="width:10%"><gw:checkbox id="chk27" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Bdgt Code</td>
									
									<td  align="center"  align="center"  style="width:10%"><gw:checkbox id="chk28" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Std Code</td>

								</tr>	
								<tr>
									<td colspan="2" style="width: 20%" align="right">
										<gw:list id="lstFilter2" styles="width: 50%" onchange="OnChangeFilter(2)" />
									</td>
									<td colspan="2" width="20%">
										<gw:textbox id="txtFilter2" styles="width: 100%" onenterkey="OnSearch('CONS')" />
									</td>
									<td  colspan="2" style="width: 20%" align="right">Total</td>
									<td colspan="2" style="width: 20%" >
										<gw:list id="lstTotal2" styles="width: 100%" />
									</td>
									<td colspan="2" align="right" style="width: 20%">
										<gw:imgbtn id="btnSearchs1" styles="width: 100%" img="search" onclick="OnSearch('CONS')" />
									</td>
								</tr>
								<tr style="height: 99%">
									<td colspan="10" style="width: 100%">
										<gw:grid id="grdCONS" 
										header="0|1|2|3|4|5|6|7|8|9|10|11|_12|13|14|15|16|_17|18|19|20|21|22|_23|_24|_25|_26|_27|_28|_29|_30|_31|_32|_33|_34|_35" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="|||||||||||||||||||||||||||||||" 
										editcol="0|1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|0|1|1|1|1|1|1|0|0|0|0|0|0|0"
										widths="1000|2000|4000|1000|1000|1000|1200|2000|2000|2000|2000|3000|2000|1500|3000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1200|0"
										styles="width:100%; height:100%" sorting="T" debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
							<table style="width: 100%; height: 100%" name="Construction Management, Supervision" style="overflow: scroll">
								<tr style="height: 1%">
									<td style="width: 15%" align="right"></td>
									<td style="width: 35%" align="left">
									</td>
									<td style="width: 50%" align="right">
									</td>
									<td style="width: 1%">
										<gw:imgbtn id="btnSearchs2" img="search" alt="Search" onclick="OnSearch('CM')" />
									</td>
								</tr>
								<tr style="height: 99%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdCM" header="_0.PK|1.No.|2.Description|_3.LEVEL_PK|4.Name|5.UOM|6.Quantity|7.Ccy|8.MM|9.Unit Cost|10.Amount|11.Ccy|12.MM|13.U/P|14.Amount|15.Sum|_16.OUTSIT_PK|17.Code|18.Name|19.Order Status|20.A. Rslt Rcpt (Y/N)|_21.PROJECT_PK|_22.tecps_undertakectrtbasc_pk|_23.undertakeseq|_24.budgetmst_pk|_25.BOOKING_AMT|_26.SEQ|_27.NUM"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="||||||||||||||||||||||||||"
										editcol="0|0|1|0|0|0|0|1|1|1|0|1|1|1|0|0|1|0|0|1|1|1|1|0|0|0|0"
										widths="1000|1100|2000|1000|2000|1000|1000|1000|1500|1500|1500|1000|1500|1500|1500|2000|1000|1000|2000|1000|1000|1000|1000|0|0|0|0"
										styles="width:100%; height:100%" sorting="T" 
										debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)" 
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
							<table style="width: 100%; height: 100%" name="Other Service" id="Table3"
								align="top" style="overflow: scroll">
								<tr style="height: 1%">
									<td>
										<table>
											<tr>												
												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk41" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk42" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Std</td>

												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk43" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Order W. Div</td>
												
												<td style="width: 20%" ></td>
												<td style="width: 15%" align="left">
													<gw:list id="lstFilter4" styles="width: 100%"  onchange="OnChangeFilter(4)" />
												</td>
												<td colspan="3" width="18%"><gw:textbox id="txtFilter4" styles="width: 100%" /></td>
												<td  style="width: 5%" align="right">Total</td>
												<td colspan="3" style="width: 25%" ><gw:list id="lstTotal4" styles="width: 100%" /></td>
												<td style="width: 1%">				
													<gw:imgbtn id="btnSearchs3" img="search" alt="Search" onclick="OnSearch('OTHER')" />
												</td>
											</tr>	
										</table>
									</td>
								</tr>
								<tr style="height: 99%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdOther" header="_0.PK|_1.LEVEL_PK|2.Level|3.Other Srvc Fld|4.Name|5.Standard
										|6.Unit|7.CCY|8.Q'ty|9.U/P|10.Amount|_11.ORDER_PK|12.Code|13.Name|14.Order Status|15.A. Rslt Rcpt (Y/N)
										|_16.PROJECT_PK|_17.tecps_undertakectrtbasc_pk|_18.undertakeseq|_19.budgetmst_pk|_20.booking_amt|_21.seq|_22.NUM"  
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||" 
									    editcol="1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0|0"
										widths="1000|1000|1000|1500|2000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" 
										sorting="T" 
										debug="false"
										oncellclick="OnClick(this)" 
										oncelldblclick="OnDBClick(this)" 
										onafteredit="CheckData(this)" />
									</td>
								</tr>
							</table>
						</gw:tab>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
    <!----------------------------------------------------------------------------------------->
    <gw:textbox id="txtPartnerPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtParentPk" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtBillToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="imagePK" maxlen="100" styles='width:100%;display:none' csstype="" />
    <gw:textbox id="txtPartID" styles='display:none' />
    <gw:textbox id="txtPartNm" styles='display:none' />
    <gw:textbox id="txtTable" text="tco_buspartner" styles='display:none' />
	<gw:textbox id="txtContract_Pk" styles='display:none' />
	<gw:textbox id="txtContract_Seq" styles='display:none' />
	<gw:textbox id="txtOrderWork_Pk" styles='display:none' />
	<gw:textbox id="txtLevelPK" styles='width:100%;display:none' />
	<gw:textbox id="txtBudgetNo" styles='width:100%;display:none' />
    <gw:textarea id="txtMemo" rows="10" styles="width:100%;display:none" />
	<gw:list id="lstCOMPANY" styles='width:100%;display:none' />
	<gw:textbox id="txtBK_RATE"  styles='width:100%;display:none' />
	<gw:textbox id="txtTR_RATE" styles="width:100%;display:none" />
	<gw:textbox id="txtReturnValue" styles="width:100%;display:none" />
    <!----------------------------------------------------------------------------------------->
</body>
</html>