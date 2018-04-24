<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>BCWS Details Registration</title>
</head>
<%  ESysLib.SetUser("comm")%>
<%  ESysLib.SetUser("esys")%>

<script>

var flag = '';

var EQ_PK							= 0,
	EQ_LEVEL_PK						= 1,
	EQ_LEVEL						= 2,
	EQ_ITEM_NO						= 3,
	EQ_NAME							= 4,
	EQ_STANDARD						= 5,
	EQ_WEIGHT						= 6,
	EQ_UOM							= 7,
	EQ_CCY							= 8
	EQ_QTY							= 9,
	EQ_UNIT_COST					= 10,
	EQ_AMT							= 11,
	EQ_ORDER_PK						= 12,
	EQ_ORDER_CODE					= 13,
	EQ_ORDER_NAME					= 14,
	EQ_EX_YN						= 15,
	EQ_BUDGET_PK					= 16,
	EQ_BUDGET_CODE					= 17,
	EQ_STANDARD_PBS					= 18,
	EQ_DEVL_TERM					= 19,
	EQ_ORDER_STATUS					= 20,
	EQ_RSLT_YN						= 21,
	EQ_PROJECT_PK					= 22,
	EQ_TECPS_UNDERTAKECTRTBASC_PK	= 23,
	EQ_UNDERTAKESEQ					= 24,
	EQ_TECPS_PERFORMBUDGETBASC_PK	= 25,
	EQ_BOOKING_AMT					= 26,
	EQ_SEQ_NO						= 27;

var CONS_PK							= 0,
	CONS_TAKE_LEVEL					= 1,
	CONS_LEVEL						= 2,
	CONS_NAME						= 3,
	CONS_STAN						= 4,
	CONS_UNIT						= 5,
	CONS_CCY						= 6,
	CONS_QTY						= 7,
	CONS_UNIT_PRICE					= 8,
	CONS_RAW						= 9,
	CONS_LABOR						= 10,
	CONS_EXP_UP						= 11,
	CONS_LABOR_UNIT_PRICE			= 12,
	CONS_AMT						= 13,
	CONS_ORDER_PK					= 14,
	CONS_ORDER_CODE					= 15,
	CONS_ORDER_NAME					= 16,
	CONS_EXEC_YN					= 17,
	CONS_DIR_MGT					= 18,
	CONS_BUDGET_PK					= 19,
	CONS_BUDGET_CODE				= 20,
	CONS_STAN_CODE					= 21,
	CONS_CALC_BASIC					= 22,
	CONS_ORDER_STA					= 23,
	CONS_RSLT_YN					= 24,
	CONS_PROJECT_PK					= 25,
	CONS_TECPS_UNDERTAKECTRTBASC_PK	= 26,
	CONS_UNDERTAKESEQ				= 27,
	CONS_TECPS_PERFORMBUDGETBASC_PK	= 28,
	CONS_BOOKING_AMT				= 29,
	CONS_SEQ_NO						= 30;

var CM_PK								= 0,
	CM_NO								= 1,
	CM_DES								= 2,
	CM_LEVEL_PK							= 3
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
	CM_SEQ_NO							= 26;

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
	OTHER_SEQ_NO						= 21;

var status_control;

function BodyInit()
{ 
	System.Translate(document);
	BindingDataList();
	Merge_grid(grdEQ);
	Merge_grid(grdCONS);
	Merge_grid(grdCM);
	Merge_grid(grdOther);
	grdEQ.GetGridControl().WordWrap	= true;
	grdCONS.GetGridControl().WordWrap	= true;
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
            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx';
            var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
			    if (obj[2] != 0)
			    {
				    lstWork_Breakdown.SetDataText(obj[2]);
			    }   
            }
        break;
        case 'OutsideOrderWork':
			if (txtProjectPk.text == '' )
			{
				alert('Please select Project !!');
			}
			else
			{
				var path = System.RootURL + "/form/kp/bm/kpda00050_Order_W_Div.aspx?p_project_pk="+ txtProjectPk.text;
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
			
			fg.MergeCol(EQ_ITEM_NO) = true
			fg.Cell(0, 0, EQ_ITEM_NO, 1, EQ_ITEM_NO)	= "Item No."

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
			fg.Cell(0, 0, CONS_PK, 1, CONS_PK) = "PK"

			fg.MergeCol(CONS_TAKE_LEVEL) = true
			fg.Cell(0, 0, CONS_TAKE_LEVEL, 1, CONS_TAKE_LEVEL) = "Level_PK"

			fg.MergeCol(CONS_LEVEL) = true
			fg.Cell(0, 0, CONS_LEVEL, 1, CONS_LEVEL) = "Level"
			
			fg.MergeCol(CONS_NAME) = true
			fg.Cell(0, 0, CONS_NAME, 1, CONS_NAME) = "Name"

			fg.MergeCol(CONS_STAN) = true
			fg.Cell(0, 0, CONS_STAN, 1, CONS_STAN) = "Standard"	
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CONS_UNIT, 0, CONS_AMT)	= "Working(Changed)"
			fg.Cell(0, 1, CONS_UNIT, 1) 			= "Unit"
			fg.Cell(0, 1, CONS_CCY, 1 ) 			= "Currency"
			fg.Cell(0, 1, CONS_QTY, 1) 				= "Qty"
			fg.Cell(0, 1, CONS_UNIT_PRICE, 1) 		= "---"
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
			fg.Cell(0, 0, CONS_CALC_BASIC, 1, CONS_CALC_BASIC) = "Calc. Basis"
			
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

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(CONS_QTY)			= 7;
			ctrl.ColAlignment(CONS_UNIT_PRICE)	= 7;
			ctrl.ColAlignment(CONS_RAW)			= 7;
			ctrl.ColAlignment(CONS_LABOR)		= 7;
			ctrl.ColAlignment(CONS_EXP_UP)		= 7;
			ctrl.ColAlignment(CONS_LABOR_UNIT_PRICE) = 7;
			ctrl.ColAlignment(CONS_AMT)			= 7;
			ctrl.ColAlignment(CONS_CALC_BASIC)  = 7;
			ctrl.ColAlignment(CONS_CCY)			= 2;

			ctrl.ColFormat(CONS_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_UNIT_PRICE)			= "#,###,###,###,###,###,###,###,###.##R";
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

	data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code|5|Budget Code|6|Standard Code";
	lstFilter2.SetDataText(data);
	lstFilter2.value = 'ALL';

	data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code";
	lstFilter4.SetDataText(data);
	lstFilter4.value = 'ALL';

	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
	lstCOMPANY.SetDataText(ls_company);
	lstCOMPANY.value = "<%=session("company_pk") %>";

	// Equiment
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 15,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 7 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 21,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 8,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
	

	// Contruction
	//Exec.YN
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 17,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 5 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 24,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

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

    var ls_Work_Breakdown = "<%=ESysLib.SetListDataSQL("select pk, undertakelevelname from ec111.tecps_undertakelevelcode where del_if = 0 order by undertakelevelname")%>|ALL|Select All";
    lstWork_Breakdown.SetDataText(ls_Work_Breakdown); 
    lstWork_Breakdown.value = 'ALL'; 
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
		var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown_1.aspx';
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
						}
					}
				break;

				case 1:
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];

						//if(!CheckDuplicateLevel(grdCONS, object[2], object[1])) return;
						grdCONS.AddRow();

						if(grdCONS.rows <= 3)
						{
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TAKE_LEVEL					, object[2]);			// pk
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL						, 'Level ' + object[3]);	// level
							grdCONS.SetGridText(grdCONS.rows-1, CONS_NAME						, object[1]);				// name
							grdCONS.SetGridText(grdCONS.rows-1, CONS_QTY						, 1);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_RAW						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_EXP_UP						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR_UNIT_PRICE			, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_AMT						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK					, txtProjectPk.text);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK	, lstBudgetNo.value);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ				, lstBudgetNo.GetText());
						}
						else
						{
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TAKE_LEVEL					, object[2]);			// pk
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LEVEL						, 'Level ' + object[3]);	// level
							grdCONS.SetGridText(grdCONS.rows-1, CONS_NAME						, object[1]);				// name
							grdCONS.SetGridText(grdCONS.rows-1, CONS_QTY						, 1);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_RAW						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_EXP_UP						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_LABOR_UNIT_PRICE			, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_AMT						, 0);
							grdCONS.SetGridText(grdCONS.rows-1, CONS_PROJECT_PK					, grdCONS.GetGridData(grdCONS.rows-2, CONS_PROJECT_PK));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_TECPS_PERFORMBUDGETBASC_PK	, grdCONS.GetGridData(grdCONS.rows-2, CONS_TECPS_PERFORMBUDGETBASC_PK));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_UNDERTAKESEQ				, grdCONS.GetGridData(grdCONS.rows-2, CONS_UNDERTAKESEQ));
							grdCONS.SetGridText(grdCONS.rows-1, CONS_SEQ_NO						, grdCONS.GetGridData(grdCONS.rows-2, CONS_SEQ_NO));
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

function CheckDuplicateLevel(grd, level_pk, level_name )
{
	switch (grd.id)
	{
		case 'grdEQ':		
			for(var i = 1; i < grd.rows; i++)
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
			for(var i = 1; i < grd.rows; i++)
			{
				if(grd.GetGridData(i, CONS_TAKE_LEVEL) == level_pk)
				{
					 alert("Duplicated Level Code!! ");
					 return false ;
				}
			}
			return true;
		break;
		case 'grdCM':
			for(var i = 1; i < grd.rows; i++)
			{
				if(grd.GetGridData(i, CM_LEVEL_PK) == level_pk)
				{
					 alert("Duplicated Level Code!! ");
					 return false ;
				}
			}
			return true;
		break;
		case 'grdOther':
			for(var i = 1; i < grd.rows; i++)
			{
				if(grd.GetGridData(i, OTHER_LEVEL_PK) == level_pk)
				{
					 alert("Duplicated Level Code!! ");
					 return false ;
				}
			}
			return true;
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
			grdCONS.SetAllRowStatusModify();
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
			dso_grdEQ.RemoveRowAt(dso_grdEQ.row);
		break;
		case 1:
			dso_grdCONS.RemoveRowAt(dso_grdCONS.row);
		break;
		case 2:
			dso_grdCM.RemoveRowAt(dso_grdCM.row);
		break;
		case 3:
			dso_grdOther.RemoveRowAt(dso_grdOther.row);
		break;
	}
}

function OnReceiveData(obj)
{
	switch(obj.id)
	{
		case 'dso_BudgetNo':
			dso_grdEQ.Call('SELECT');
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
					return;
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
			if (chkQty.value == 'Y')
			{
				for (row = 2; row < grdCONS.rows; row++ )
				{
					if (grdCONS.GetGridData(row, CONS_QTY) == 0)
					{
						grdCONS.GetGridControl().RowHidden(row) = true;
					}					

					if(grdCONS.GetGridData(row, CONS_PK) == '' && grdCONS.GetGridData(row, CONS_TECPS_UNDERTAKECTRTBASC_PK) != '')
					{
						grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols-1, 0x0000FF);
					}
				}
			}

			if (flag == '')
			{
				dso_grdCONS_Pro.Call();
			}
			else
			{
				Merge_grid(grdCONS);

				// perform chua nhap, lay tu contract detail qua
				if (grdCONS.rows <= 2)
				{
					return;
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

					return;
					if (flag == 'SELECT')
						dso_grdCM.Call('SELECT');
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
					return;
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
					return;
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
					grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols-1, 0x0000FF);
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
			if (obj.col == CONS_QTY || obj.col == CONS_RAW || obj.col == CONS_LABOR ||
				obj.col == CONS_EXP_UP|| obj.col == CONS_LABOR_UNIT_PRICE  || obj.col == CONS_CALC_BASIC )
			{
				if (isNaN(obj.GetGridData(obj.row, obj.col)))
				{
					obj.SetGridText(obj.row, obj.col, 0);
				}

				var amt = 0, unit_price = 0;

				unit_price = Number(obj.GetGridData(obj.row, CONS_RAW)) + Number(obj.GetGridData(obj.row, CONS_LABOR)) + Number(obj.GetGridData(obj.row, CONS_EXP_UP));
				amt = Number(obj.GetGridData(obj.row, CONS_QTY)) * Number(unit_price);

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
				var path = System.RootURL + "/form/kp/bm/kpda00020_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
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
				var fpath = System.RootURL + "/form/kp/bm/kpda00020_Budget.aspx";
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
				var path = System.RootURL + "/form/kp/bm/kpda00020_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_PK,   object[0]);
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_CODE, object[1]);
					grdCONS.SetGridText(grdCONS.row, CONS_ORDER_NAME, object[2]);
				}
			}

			if (grdCONS.col == CONS_BUDGET_CODE)
			{
				var fpath = System.RootURL + "/form/kp/bm/kpda00020_Budget.aspx";
				var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(object != null)
				{
					grdCONS.SetGridText(grdCONS.row, CONS_BUDGET_PK,   object[0]);
					grdCONS.SetGridText(grdCONS.row, CONS_BUDGET_CODE, object[1]);
				}
			}
		break;
		case 'grdCM':
			if (grdCM.col == CM_OUTSITE_CODE || grdCM.col == CM_OUTSITE_NAME)
			{
				var path = System.RootURL + "/form/kp/bm/kpda00020_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
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
				var path = System.RootURL + "/form/kp/bm/kpda00020_Order_W_Div.aspx?p_project_pk=" + txtProjectPk.text;
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

<body>
<gw:data id="dso_BudgetNo" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="1" type="list" procedure="EC111.SP_SEL_kpda00020_BUDGETNO" > 
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
        <dso id="2" type="grid" parameter="0,1,3,5,6,7,8,9,10,11,12,15,16,18,19,20,21,22,23,24,25,27" function="EC111.SP_SEL_kpda00020_EQ" procedure="EC111.SP_UPD_kpda00020_EQ" > 
            <input bind="grdEQ">
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="lstWork_Breakdown" />
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
        <dso id="3" type="grid" function="EC111.SP_SEL_kpda00020_EQ_UNDER" > 
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
		<dso id="1" type="process" procedure="ec111.sp_pro_kpda00020_eq"  > 
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
        <dso id="5" type="grid" parameter="0,1,4,5,6,7,9,10,11,12,13,14,17,18,19,21,22,23,24,25,26,27,28,30" function="EC111.SP_SEL_kpda00020_CONS" procedure="EC111.SP_UPD_kpda00020_CONS" > 
            <input bind="grdCONS">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="lstWork_Breakdown" />
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
        <dso id="4" type="grid" function="ec111.SP_SEL_kpda00020_CONS_UNDER" > 
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
		<dso id="1" type="process" procedure="ec111.sp_pro_kpda00020_cons"  > 
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
        <dso id="7" type="grid" parameter="0,2,3,5,6,7,8,9,10,11,12,13,14,16,19,20,21,22,23,24,26" function="EC111.SP_SEL_kpda00020_CM" procedure="EC111.SP_UPD_kpda00020_CM" > 
            <input bind="grdCM">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="lstWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
            </input> 
            <output bind="grdCM" /> 
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_grdCM_UNDERTAKE" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="6" type="grid" function="ec111.SP_SEL_kpda00020_CM_UNDER" > 
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
		<dso id="1" type="process" procedure="ec111.sp_pro_kpda00020_cm"  > 
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
        <dso id="9" type="grid" parameter="0,1,3,5,6,7,8,9,10,11,14,15,16,17,18,19,21" function="EC111.SP_SEL_kpda00020_OTHER" procedure="EC111.SP_UPD_kpda00020_OTHER" > 
            <input bind="grdOther">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="lstWork_Breakdown" />
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
        <dso id="8" type="grid" function="EC111.SP_SEL_kpda00020_OTHER_UNDER" > 
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
		<dso id="1" type="process" procedure="ec111.sp_pro_kpda00020_other"  > 
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
												<gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" style="display:none" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnPrint" img="excel" alt="List of business partner" text="Print"
													onclick="onPrint()" />
											</td>
										</tr>
									</table>
								</td>
							</tr>                               
							<tr>
								<td  align="right">
								<a href="#"  title="Click here to show Work Division"  onClick="OnPopUp('Work_Breakdown')" style="text-decoration:none">W. Div</a></td>
								<td ><gw:list id="lstWork_Breakdown" styles="width:100%" onchange="OnChangeCB()" /></td>
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
										<gw:checkbox id="chkQty" value="Y" defaultvalue="Y|N" onchange="" />
								 </td>
								 <td colspan="2">Excluding detail of which quantity is "0"</td>
							</tr>
						</table>
						</fieldset>
					</td>
				</tr>
				<tr style="height: 98%">
					<td colspan="7">
						<gw:tab id="idTab">
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%;"
								name="Equipment" id="Tab1" border="0">
								<tr style="height: 1%">
									<td  align="center" nowrap=" align="center"  style="width:10%"><gw:checkbox id="chk1" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk2" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Standard</td>
										
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk3" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Weight</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk6" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" /><a title="Placement Order Work Division" style="color:#333">Order W. Div</a></td>

									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk7" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" /><a title="Execution Y/N" style="color:#333">Exec Y/N</a></td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk8" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Budget Code</td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk9" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(9)" /><a title="Standard Physical Breakdown System" style="color:#333">Standard PBS</a></td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk10" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(10)" /><a title="Delivery Terms" style="color:#333">Dlvr. Terms</a></td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk11" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(11)" /><a title="Delivery (Y/N)" style="color:#333">Dlvr.(Y/N)</a></td>
									
									<td  align="center" =" align="center"  style="width:10%"><gw:checkbox id="chk12" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(12)" /><a title="Contract Details" style="color:#333">Cont. Dtals</a></td>
								</tr>								
								<tr style="height: 1%">
									<td colspan="2"  align="center" nowrap=" align="center" nowrap" style="width:20%">
										<gw:list id="lstFilter1" styles="width: 100%" onchange="OnChangeFilter(1)" />
									</td>
									
									<td colspan="2" align="center" nowrap=" align="center" nowrap" style="width:20%">
										<gw:textbox id="txtFilter1" styles="width: 100%" />
									</td>
										
									<td colspan="2"  align="right" nowrap=" align="center" nowrap" style="width:20%">
										Total
									</td>
									
									<td colspan="2"  align="center" nowrap=" align="center" nowrap" style="width:20%">
										<gw:list id="lstTotal1" styles="width: 100%" />
									</td>

									<td colspan="2"  align="right" nowrap=" align="center" nowrap" style="width:20%">
										<gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch('EQ')" />
									</td>
								</tr>
								<tr style="height: 98%">
									<td colspan="10" style="width: 100%">
										<gw:grid id="grdEQ" header="_0.PK|_1.LEVEL_PK|2.Level|3.Item No|4.Name|5.Standard|6.Weight|7.UOM|8.Unit|9.Qty
										|10.Unit Cost|11.Amount|_12.Order_PK|13.Order Code|14.Order Name|15.Execution (Yes/No)|_16._Budget_PK|17.Budget Code|18.Standard PBS|19.Delivery Term|20.Order Status
										|21.A. Rslt Rcpt (Y/N)|_22.PROJECT_PK|_23.tecps_undertakectrtbasc_pk|_24.undertakeseq|_25.budgetmst_pk|_26.booking_amt|_27.seq_num" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="|||||||||||||||||||||||||||"
										editcol="0|0|0|0|0|1|1|1|1|1|1|0|1|0|0|1|0|1|1|1|1|1|1|1|0|0|0|0" 
										widths="1000|1000|1000|1200|2000|1000|1000|1500|1000|1000|1000|1200|1000|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0" 
										styles="width:100%; height:100%" 
										sorting="T" debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
						   
							<table style="width: 100%; height: 100%" name="Construction" style="overflow: scroll">
								<tr style="height: 1%">
									<td>
										<table style="width: 100%;" border="0">
											<tr>												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk21" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk22" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" /><a title="Standard" style="color:#333">Std</a></td>
													
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk23" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" /><a title="Raw Material/Labor/Expenditure" style="color:#333">Raw Mtrl/Labor/Exp</a></td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk24" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(4)" /><a title="Order Work Division" style="color:#333">Order W.</a></td>

												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk25" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(5)" /><a title="Execution Yes/No" style="color:#333">Exec Y/N</a></td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk26" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" /><a title="Direct Management Outsourcing" style="color:#333">Dir. Mgt Outsrc.</a></td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk27" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" /><a title="Budget Code" style="color:#333">Bdgt Code</a></td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:10%"><gw:checkbox id="chk28" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" /><a title="Standard Code" style="color:#333">Std Code</a></td>

												<td style="width:10%"></td>
												<td style="width:10%"></td>
											</tr>	
											<tr>
												<td colspan="2" style="width: 20%" align="left">
													<gw:list id="lstFilter2" styles="width: 100%" onchange="OnChangeFilter(2)" />
												</td>
												<td colspan="2" width="20%">
													<gw:textbox id="txtFilter2" styles="width: 100%" />
												</td>
												<td  colspan="2" style="width: 20%" align="right">Total</td>
												<td colspan="2" style="width: 20%" >
													<gw:list id="lstTotal2" styles="width: 100%" />
												</td>
												<td colspan="2" style="width: 20%">
													<gw:imgbtn id="btnSearchs1" img="search" alt="Search" onclick="OnSearch('CONS')" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height: 99%">
									<td>
										<gw:grid id="grdCONS" 
										header="_0.PK|_1.LEVL_PK|2.Level|3.Name|4.Standard|5.Unit|6.Currency|7.Qty|_8.|9.Raw Mtrl. Cost U/P|10.Labor Cost U/P|11.Exp. U/P|12. Unit Price|13.Amount|_14.Order_PK|15.Order Code|16.Order Name|17.Exec. (Y/N)|18.Dir. Mgt Outsrc.|_19.Budget_PK|20.Budget Code|21.Standard Code|22.Calc. Basis|23.Order Status|24.A. Rslt Rcpt Y/N|_25.PROJECT_PK|_26.tecps_undertakectrtbasc_pk|_27.undertakeseq|_28.budgetmst_pk|_29.BOOKING_AMT|_30.SEQ" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="|||||||||||||||||||||||||||||" 
										editcol="0|0|0|0|1|1|1|1|1|1|1|1|0|0|1|0|0|1|1|1|0|1|1|1|1|1|1|0|0|0"
										widths="1200|2000|1000|2000|1000|1000|1000|1000|1200|2000|1500|1000|1000|1000|1000|1000|1500|1000|1000|1000|2000|0|0|0|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" sorting="T" debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
							<table style="width: 100%; height: 100%" name="CM, Sprv" style="overflow: scroll">
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
										<gw:grid id="grdCM" header="_0.PK|1.No.|2.Description|_3.LEVEL_PK|4.Name|5.UOM|6.Quantity|7.Ccy|8.MM|9.Unit Cost|10.Amount|11.Ccy|12.MM|13.U/P|14.Amount|15.Sum|_16.OUTSIT_PK|17.Code|18.Name|19.Order Status|20.A. Rslt Rcpt (Y/N)|_21.PROJECT_PK|_22.tecps_undertakectrtbasc_pk|_23.undertakeseq|_24.budgetmst_pk|_25.BOOKING_AMT|_26.SEQ"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="|||||||||||||||||||||||||"
										editcol="0|0|1|0|0|0|0|1|1|1|0|1|1|1|0|0|1|0|0|1|1|1|1|0|0|0"
										widths="1000|1100|2000|1000|2000|1000|1000|1000|1500|1500|1500|1000|1500|1500|1500|2000|1000|1000|2000|1000|1000|1000|1000|0|0|0"
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
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk42" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" /><a title="Standard" style="color:#333">Std</a></td>

												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk43" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" /><a title="Order Work Division" style="color:#333">Order W. Div</a></td>
												
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
										|_16.PROJECT_PK|_17.tecps_undertakectrtbasc_pk|_18.undertakeseq|_19.budgetmst_pk|_20.booking_amt|_21.seq"  
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="|||||||||||||||||||||" 
									    editcol="1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0"
										widths="1000|1000|1000|1500|2000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0|0|0|0|0"
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