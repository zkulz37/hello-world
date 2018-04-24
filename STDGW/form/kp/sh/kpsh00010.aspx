﻿<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Process Plan Registration</title>
</head>
<%  ESysLib.SetUser("EC111")%>
<script>
var project_pk, progplanbase_pk;
var flag_save = false;
var version = '';
var dup = false;

var COL_JAN			 = false,
    COL_FEB          = false,
    COL_MAR          = false,
    COL_APR          = false,
    COL_MAY          = false,
    COL_JUN          = false,
    COL_JUL          = false,
    COL_AUG          = false,
    COL_SEP          = false,
    COL_OCT          = false,
    COL_NOV          = false,
    COL_DEC          = false,
    COL_JAN2         = false,
    COL_FEB2         = false,
    COL_MAR2         = false,
    COL_APR2         = false,
    COL_MAY2         = false,
    COL_JUN2         = false,
    COL_JUL2         = false,
    COL_AUG2         = false,
    COL_SEP2         = false,
    COL_OCT2         = false,
    COL_NOV2         = false,
    COL_DEC2         = false;

var IT_LARGE_DIV	= 0,
	IT_CODE			= 1,
	IT_DTL_ITEM		= 2,
	IT_LEVEL		= 3,
	IT_PK			= 4,
	IT_PROJECT_PK	= 5;

var PLAN_PK			= 0,
	PLAN_LARGE_DIV  = 1,
    PLAN_DTL_ITEM   = 2,
    PLAN_UNIT		= 3,
    PLAN_WEIGHT		= 4,
    PLAN_TOTAL      = 5,
	PLAN_RESULT		= 6,
	PLAN_TRIBUTION  = 7,

    JAN				= 8,
	JAN_MM			= 9,
	PK_JAN			= 10,

    FEB             = 11,
	FEB_MM			= 12,
	PK_FEB          = 13,

    MAR             = 14,
	MAR_MM			= 15,
    PK_MAR          = 16,

    APR             = 17,
	APR_MM			= 18,
    PK_APR          = 19,

    MAY             = 20,
	MAY_MM			= 21,
    PK_MAY          = 22,

    JUN             = 23,
	JUN_MM			= 24,
    PK_JUN          = 25,

    JUL             = 26,
	JUL_MM			= 27,
    PK_JUL          = 28,

    AUG             = 29,
	AUG_MM			= 30,
    PK_AUG          = 31,

    SEP             = 32,
	SEP_MM			= 33,
    PK_SEP          = 34,

    OCT             = 35,
	OCT_MM			= 36,
    PK_OCT          = 37,

    NOV             = 38,
	NOV_MM			= 39,
    PK_NOV          = 40,

    DEC             = 41,
	DEC_MM			= 42,
    PK_DEC          = 43,

    JAN2            = 44,
	JAN2_MM			= 45,
    PK_JAN2         = 46,

    FEB2            = 47,
	FEB2_MM			= 48,
    PK_FEB2         = 49,

    MAR2            = 50,
	MAR2_MM			= 51,
    PK_MAR2         = 52,

    APR2            = 53,
	APR2_MM			= 54,
    PK_APR2         = 55,

    MAY2            = 56,
	MAY2_MM			= 57,
    PK_MAY2         = 58,

    JUN2            = 59,
	JUN2_MM			= 60,
    PK_JUN2         = 61,

    JUL2            = 62,
	JUL2_MM			= 63,
    PK_JUL2         = 64,

    AUG2            = 65,
	AUG2_MM			= 66,
	PK_AUG2         = 67,

    SEP2            = 68,
	SEP2_MM			= 69,
    PK_SEP2         = 70,

    OCT2            = 71,
	OCT2_MM			= 72,
    PK_OCT2         = 73,

    NOV2            = 74,
	NOV2_MM			= 75,
    PK_NOV2         = 76,

    DEC2            = 77,
	DEC2_MM			= 78,
    PK_DEC2         = 79,
	
	PLAN_TECPS_PROPLAN_ITEM_PK	= 80,
	PLAN_TECPS_PROGPLANBASE_PK	= 81,
	PLAN_TECPS_PROJECTSUMM_PK	= 82,
	PLAN_LEVEL					= 83,
	PLAN_PROPLAN_CD				= 84,
	PLAN_CHANGESEQ				= 85;

function BodyInit()
{
	System.Translate(document);

    grdPlan.MergeGridCols();
	grdPlan.MergeByCol(1);
	BindingDataList();
	MergeHeaderRegister();
	MergeHeaderInquiry();
	grdPlan.GetGridControl().FrozenCols = PLAN_UNIT;
	Grid_Inquiry.GetGridControl().FrozenCols = PLAN_UNIT;
	InitControl();
	Debug(false);

	dso_MST.StatusInsert();
} 

function Debug(obj)
{	
	if (obj)
	{
		//grdPlan.GetGridControl().ColHidden(PLAN_PK)    = false ;

		grdPlan.GetGridControl().ColHidden(JAN_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(FEB_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(MAR_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(APR_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(MAY_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(JUN_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(JUL_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(AUG_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(SEP_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(OCT_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(NOV_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(DEC_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(JAN2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(FEB2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(MAR2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(APR2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(MAY2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(JUN2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(JUL2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(AUG2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(SEP2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(OCT2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(NOV2_MM)     = false ;
		grdPlan.GetGridControl().ColHidden(DEC2_MM)     = false ;

		grdPlan.GetGridControl().ColHidden(PK_JAN)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_FEB)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_MAR)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_APR)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_MAY)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_JUN)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_JUL)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_AUG)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_SEP)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_OCT)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_NOV)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_DEC)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_JAN2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_FEB2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_MAR2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_APR2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_MAY2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_JUN2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_JUL2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_AUG2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_SEP2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_OCT2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_NOV2)     = false ;
		grdPlan.GetGridControl().ColHidden(PK_DEC2)     = false ;
	}
	else
	{
		//grdPlan.GetGridControl().ColHidden(PLAN_PK)    = true ;

		grdPlan.GetGridControl().ColHidden(JAN_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(FEB_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(MAR_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(APR_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(MAY_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(JUN_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(JUL_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(AUG_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(SEP_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(OCT_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(NOV_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(DEC_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(JAN2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(FEB2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(MAR2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(APR2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(MAY2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(JUN2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(JUL2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(AUG2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(SEP2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(OCT2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(NOV2_MM)     = true ;
		grdPlan.GetGridControl().ColHidden(DEC2_MM)     = true ;

		grdPlan.GetGridControl().ColHidden(PK_JAN)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_FEB)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_MAR)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_APR)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_MAY)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_JUN)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_JUL)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_AUG)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_SEP)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_OCT)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_NOV)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_DEC)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_JAN2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_FEB2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_MAR2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_APR2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_MAY2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_JUN2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_JUL2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_AUG2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_SEP2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_OCT2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_NOV2)     = true ;
		grdPlan.GetGridControl().ColHidden(PK_DEC2)     = true ;
	}
}

function BindingDataList()
{
	var ls_company = "DATA|1|Saved|2|Confirmed|3|Cancel";
	lstStatus.SetDataText(ls_company);

	<%=ESysLib.SetGridColumnComboFormat("grdPlan", 3 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
}

function MergeHeaderRegister()
{
	var fg = grdPlan.GetGridControl(); 	
	if(fg.Rows < 2)
	{
	   grdPlan.AddRow();     
	}    

	fg.FixedRows	= 2
	fg.MergeCells	= 5	
		
	fg.MergeCol(PLAN_PK) = true
	fg.Cell(0, 0, PLAN_PK, 1, PLAN_PK)					= "PK"	
	fg.MergeCol(PLAN_LARGE_DIV) = true
	fg.Cell(0, 0, PLAN_LARGE_DIV, 1, PLAN_LARGE_DIV)	= "Large Division"	
	fg.MergeCol(PLAN_DTL_ITEM) = true
	fg.Cell(0, 0, PLAN_DTL_ITEM, 1, PLAN_DTL_ITEM)		= "Detail Item"	
	fg.MergeCol(PLAN_UNIT) = true
	fg.Cell(0, 0, PLAN_UNIT, 1, PLAN_UNIT)				= "Unit"	
	fg.MergeCol(PLAN_WEIGHT) = true
	fg.Cell(0, 0, PLAN_WEIGHT, 1, PLAN_WEIGHT)			= "Weight Factor"	
	fg.MergeCol(PLAN_TOTAL) = true
	fg.Cell(0, 0, PLAN_TOTAL, 1, PLAN_TOTAL)			= "Total Plan Qty"	
	fg.MergeCol(PLAN_RESULT) = true
	fg.Cell(0, 0, PLAN_RESULT, 1, PLAN_RESULT)			= "A.Result Qty"	
	fg.MergeCol(PLAN_TRIBUTION) = true
	fg.Cell(0, 0, PLAN_TRIBUTION, 1, PLAN_TRIBUTION)	= "Tribution Back"

	var date1 = dtContractTarget_Fr.value;
	var date2 = dtContractTarget_To.value;

	var year1 = date1.substring(0,4);
	var year2 = date2.substring(0,4);
	
	var month1 = Number(date1.substring(4,6));
	var month2 = Number(date2.substring(4,6));
	
	fg.MergeRow(0) = true
	fg.Cell(0, 0, JAN, 0, PK_DEC)  = year1 + ' Year'  //fg.Cell(0,row, from_col, row, to_col)	
	fg.Cell(0, 1, JAN, 1, JAN) = "Jan"
	fg.Cell(0, 1, FEB, 1, FEB) = "Feb" 
	fg.Cell(0, 1, MAR, 1, MAR) = "Mar" 
	fg.Cell(0, 1, APR, 1, APR) = "Apr"  
	fg.Cell(0, 1, MAY, 1, MAY) = "May"
	fg.Cell(0, 1, JUN, 1, JUN) = "Jun"
	fg.Cell(0, 1, JUL, 1, JUL) = "Jul"
	fg.Cell(0, 1, AUG, 1, AUG) = "Aug"
	fg.Cell(0, 1, SEP, 1, SEP) = "Sep"
	fg.Cell(0, 1, OCT, 1, OCT) = "Oct"
	fg.Cell(0, 1, NOV, 1, NOV) = "Nov"
	fg.Cell(0, 1, DEC, 1, DEC) = "Dec"

	fg.Cell(0, 1, JAN_MM, 1, JAN_MM) = "Jan_MM"
	fg.Cell(0, 1, FEB_MM, 1, FEB_MM) = "Feb_MM" 
	fg.Cell(0, 1, MAR_MM, 1, MAR_MM) = "Mar_MM" 
	fg.Cell(0, 1, APR_MM, 1, APR_MM) = "Apr_MM"  
	fg.Cell(0, 1, MAY_MM, 1, MAY_MM) = "May_MM"
	fg.Cell(0, 1, JUN_MM, 1, JUN_MM) = "Jun_MM"
	fg.Cell(0, 1, JUL_MM, 1, JUL_MM) = "Jul_MM"
	fg.Cell(0, 1, AUG_MM, 1, AUG_MM) = "Aug_MM"
	fg.Cell(0, 1, SEP_MM, 1, SEP_MM) = "Sep_MM"
	fg.Cell(0, 1, OCT_MM, 1, OCT_MM) = "Oct_MM"
	fg.Cell(0, 1, NOV_MM, 1, NOV_MM) = "Nov_MM"
	fg.Cell(0, 1, DEC_MM, 1, DEC_MM) = "Dec_MM"

	fg.Cell(0, 1, PK_JAN, 1, PK_JAN) = "Jan_PK"
	fg.Cell(0, 1, PK_FEB, 1, PK_FEB) = "Feb_PK" 
	fg.Cell(0, 1, PK_MAR, 1, PK_MAR) = "Mar_PK" 
	fg.Cell(0, 1, PK_APR, 1, PK_APR) = "Apr_PK"  
	fg.Cell(0, 1, PK_MAY, 1, PK_MAY) = "May_PK"
	fg.Cell(0, 1, PK_JUN, 1, PK_JUN) = "Jun_PK"
	fg.Cell(0, 1, PK_JUL, 1, PK_JUL) = "Jul_PK"
	fg.Cell(0, 1, PK_AUG, 1, PK_AUG) = "Aug_PK"
	fg.Cell(0, 1, PK_SEP, 1, PK_SEP) = "Sep_PK"
	fg.Cell(0, 1, PK_OCT, 1, PK_OCT) = "Oct_PK"
	fg.Cell(0, 1, PK_NOV, 1, PK_NOV) = "Nov_PK"
	fg.Cell(0, 1, PK_DEC, 1, PK_DEC) = "Dec_PK"
	
	fg.Cell(0, 0, JAN2, 0, PK_DEC2)  = year2 + ' Year'
	fg.Cell(0, 1, JAN2, 1, JAN2) = "Jan" 
	fg.Cell(0, 1, FEB2, 1, FEB2) = "Feb" 
	fg.Cell(0, 1, MAR2, 1, MAR2) = "Mar" 
	fg.Cell(0, 1, APR2, 1, APR2) = "Apr"  
	fg.Cell(0, 1, MAY2, 1, MAY2) = "May"
	fg.Cell(0, 1, JUN2, 1, JUN2) = "Jun"
	fg.Cell(0, 1, JUL2, 1, JUL2) = "Jul"
	fg.Cell(0, 1, AUG2, 1, AUG2) = "Aug"
	fg.Cell(0, 1, SEP2, 1, SEP2) = "Sep"
	fg.Cell(0, 1, OCT2, 1, OCT2) = "Oct"
	fg.Cell(0, 1, NOV2, 1, NOV2) = "Nov"
	fg.Cell(0, 1, DEC2, 1, DEC2) = "Dec"

	fg.Cell(0, 1, JAN2_MM, 1, JAN2_MM) = "Jan_MM" 
	fg.Cell(0, 1, FEB2_MM, 1, FEB2_MM) = "Feb_MM" 
	fg.Cell(0, 1, MAR2_MM, 1, MAR2_MM) = "Mar_MM" 
	fg.Cell(0, 1, APR2_MM, 1, APR2_MM) = "Apr_MM"  
	fg.Cell(0, 1, MAY2_MM, 1, MAY2_MM) = "May_MM"
	fg.Cell(0, 1, JUN2_MM, 1, JUN2_MM) = "Jun_MM"
	fg.Cell(0, 1, JUL2_MM, 1, JUL2_MM) = "Jul_MM"
	fg.Cell(0, 1, AUG2_MM, 1, AUG2_MM) = "Aug_MM"
	fg.Cell(0, 1, SEP2_MM, 1, SEP2_MM) = "Sep_MM"
	fg.Cell(0, 1, OCT2_MM, 1, OCT2_MM) = "Oct_MM"
	fg.Cell(0, 1, NOV2_MM, 1, NOV2_MM) = "Nov_MM"
	fg.Cell(0, 1, DEC2_MM, 1, DEC2_MM) = "Dec_MM"

	fg.Cell(0, 1, PK_JAN2, 1, PK_JAN2) = "Jan_PK" 
	fg.Cell(0, 1, PK_FEB2, 1, PK_FEB2) = "Feb_PK" 
	fg.Cell(0, 1, PK_MAR2, 1, PK_MAR2) = "Mar_PK" 
	fg.Cell(0, 1, PK_APR2, 1, PK_APR2) = "Apr_PK"  
	fg.Cell(0, 1, PK_MAY2, 1, PK_MAY2) = "May_PK"
	fg.Cell(0, 1, PK_JUN2, 1, PK_JUN2) = "Jun_PK"
	fg.Cell(0, 1, PK_JUL2, 1, PK_JUL2) = "Jul_PK"
	fg.Cell(0, 1, PK_AUG2, 1, PK_AUG2) = "Aug_PK"
	fg.Cell(0, 1, PK_SEP2, 1, PK_SEP2) = "Sep_PK"
	fg.Cell(0, 1, PK_OCT2, 1, PK_OCT2) = "Oct_PK"
	fg.Cell(0, 1, PK_NOV2, 1, PK_NOV2) = "Nov_PK"
	fg.Cell(0, 1, PK_DEC2, 1, PK_DEC2) = "Dec_PK" 

	fg.ColAlignment(PLAN_WEIGHT)	= 7;
	fg.ColAlignment(PLAN_TOTAL)		= 7;
	fg.ColAlignment(PLAN_RESULT)	= 7;
	fg.ColAlignment(PLAN_TRIBUTION)	= 7;

	fg.ColFormat(PLAN_WEIGHT)		= "#,###,###,###,###,###,###,###,###.##R";
	fg.ColFormat(PLAN_TOTAL)		= "#,###,###,###,###,###,###,###,###.##R";
	fg.ColFormat(PLAN_RESULT)		= "#,###,###,###,###,###,###,###,###.##R";
	fg.ColFormat(PLAN_TRIBUTION)	= "#,###,###,###,###,###,###,###,###.##R";

	for (col = JAN; col <= PK_DEC2 ; col+=3)
	{
		fg.ColAlignment(col)	= 7;
		fg.ColFormat(col)		= "#,###,###,###,###,###,###,###,###.##R";	
	}

	fg.MergeCol(PLAN_TECPS_PROPLAN_ITEM_PK) = true
	fg.Cell(0, 0, PLAN_TECPS_PROPLAN_ITEM_PK, 1, PLAN_TECPS_PROPLAN_ITEM_PK)	= "TECPS_PROPLAN_ITEM_PK"

	fg.MergeCol(PLAN_TECPS_PROGPLANBASE_PK) = true
	fg.Cell(0, 0, PLAN_TECPS_PROGPLANBASE_PK, 1, PLAN_TECPS_PROGPLANBASE_PK)	= "TECPS_PROGPLANBASE_PK"

	fg.MergeCol(PLAN_TECPS_PROJECTSUMM_PK) = true
	fg.Cell(0, 0, PLAN_TECPS_PROJECTSUMM_PK, 1, PLAN_TECPS_PROJECTSUMM_PK)	= "TECPS_PROJECTSUMM_PK"

	fg.MergeCol(PLAN_LEVEL) = true
	fg.Cell(0, 0, PLAN_LEVEL, 1, PLAN_LEVEL)	= "LEVEL"

	fg.MergeCol(PLAN_PROPLAN_CD) = true
	fg.Cell(0, 0, PLAN_PROPLAN_CD, 1, PLAN_PROPLAN_CD)	= "CODE"

	fg.MergeCol(PLAN_CHANGESEQ) = true
	fg.Cell(0, 0, PLAN_CHANGESEQ, 1, PLAN_CHANGESEQ)	= "SEQ"
	ResetGrid();

	if(year2<=year1)
	{
		//ResetGrid();
		grdPlan.GetGridControl().ColHidden(JAN2)     = true ;
		grdPlan.GetGridControl().ColHidden(FEB2)     = true ;
		grdPlan.GetGridControl().ColHidden(MAR2)     = true ;
		grdPlan.GetGridControl().ColHidden(APR2)     = true ;
		grdPlan.GetGridControl().ColHidden(MAY2)     = true ;
		grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
		grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
		grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
		grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
		grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
		grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
		grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

		COL_JAN2         = true,
		COL_FEB2         = true,
		COL_MAR2         = true,
		COL_APR2         = true,
		COL_MAY2         = true,
		COL_JUN2         = true,
		COL_JUL2         = true,
		COL_AUG2         = true,
		COL_SEP2         = true,
		COL_OCT2         = true,
		COL_NOV2         = true,
		COL_DEC2         = true;
			
		if(month2==11)		
		{
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;
			COL_DEC = true;
		}
		if(month2==10)
		{
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;
			COL_NOV = true;
			COL_DEC = true;
		}
		if(month2==9)
		{
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==8)
		{
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==7)
		{
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==6)
		{
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==5)
		{
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_JUN			= true,
			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==4)
		{
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_MAY			= true,
			COL_JUN			= true,
			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==3)
		{
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_APR			= true,
			COL_MAY			= true,
			COL_JUN			= true,
			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==2)
		{
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;

			COL_MAR			= true,
			COL_APR			= true,
			COL_MAY			= true,
			COL_JUN			= true,
			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		if(month2==1)
		{
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC)     = true ;
			
			COL_FEB			= true,
			COL_MAR			= true,
			COL_APR			= true,
			COL_MAY			= true,
			COL_JUN			= true,
			COL_JUL			= true,
			COL_AUG         = true,
			COL_SEP         = true,
			COL_OCT         = true,
			COL_NOV         = true,
			COL_DEC         = true;
		}
		
		//============================================================
		if(month1==2)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;

			COL_JAN = true;
		}
		if(month1==3)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;

			COL_JAN = true,
			COL_FEB = true;
		}
		if(month1==4)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true;
		}
		if(month1==5)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;

			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true;
		}
		if(month1==6)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true;
		}
		if(month1==7)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true;
		}
		if(month1==8)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;

			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true;

		}
		if(month1==9)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true;
		}
		if(month1==10)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true;
		}
		if(month1==11)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;

			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true,
			COL_OCT = true;
		}
		if(month1==12)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true,
			COL_OCT = true,
			COL_NOV = true;
		}   
	}
	
	//===============================================================================
	else
	{
		//ResetGrid();

		if(month2==11)
		{
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_DEC2 = true;
		}
		if(month2==10)
		{
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;
			COL_NOV2 = true,
			COL_DEC2 = true;
		}
		if(month2==9)
		{
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==8)
		{
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==7)
		{
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==6)
		{
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==5)
		{
			grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_JUN2 = true,
			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==4)
		{
			grdPlan.GetGridControl().ColHidden(MAY2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_MAY2 = true,
			COL_JUN2 = true,
			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==3)
		{
			grdPlan.GetGridControl().ColHidden(APR2)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_APR2 = true,
			COL_MAY2 = true,
			COL_JUN2 = true,
			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==2)
		{
			grdPlan.GetGridControl().ColHidden(MAR2)     = true ;
			grdPlan.GetGridControl().ColHidden(APR2)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_MAR2 = true,
			COL_APR2 = true,
			COL_MAY2 = true,
			COL_JUN2 = true,
			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		if(month2==1)
		{
			grdPlan.GetGridControl().ColHidden(FEB2)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR2)     = true ;
			grdPlan.GetGridControl().ColHidden(APR2)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN2)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL2)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG2)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP2)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV2)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT2)     = true ;
			grdPlan.GetGridControl().ColHidden(DEC2)     = true ;

			COL_FEB2 = true,
			COL_MAR2 = true,
			COL_APR2 = true,
			COL_MAY2 = true,
			COL_JUN2 = true,
			COL_JUL2 = true,
			COL_AUG2 = true,
			COL_SEP2 = true,
			COL_NOV2 = true,
			COL_OCT2 = true,
			COL_DEC2 = true;
		}
		
		//============================================================
		
		if(month1==2)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;

			COL_JAN = true;			
		}
		if(month1==3)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			
			COL_JAN = true,
			COL_FEB = true;
		}
		if(month1==4)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true;
		}
		if(month1==5)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true;
		}
		if(month1==6)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true;
		}
		if(month1==7)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true;
		}
		if(month1==8)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;

			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true;
		}
		if(month1==9)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true;
		}
		if(month1==10)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true;
		}
		if(month1==11)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			
			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true,
			COL_OCT = true;
		}
		if(month1==12)
		{
			grdPlan.GetGridControl().ColHidden(JAN)     = true ;
			grdPlan.GetGridControl().ColHidden(FEB)     = true ;
			grdPlan.GetGridControl().ColHidden(MAR)     = true ;
			grdPlan.GetGridControl().ColHidden(APR)     = true ;
			grdPlan.GetGridControl().ColHidden(MAY)     = true ;
			grdPlan.GetGridControl().ColHidden(JUN)     = true ;
			grdPlan.GetGridControl().ColHidden(JUL)     = true ;
			grdPlan.GetGridControl().ColHidden(AUG)     = true ;
			grdPlan.GetGridControl().ColHidden(SEP)     = true ;
			grdPlan.GetGridControl().ColHidden(OCT)     = true ;
			grdPlan.GetGridControl().ColHidden(NOV)     = true ;

			COL_JAN = true,
			COL_FEB = true,
			COL_MAR = true,
			COL_APR = true,
			COL_MAY = true,
			COL_JUN = true,
			COL_JUL = true,
			COL_AUG = true,
			COL_SEP = true,
			COL_OCT = true,
			COL_NOV = true;
		}   
	}
}

function ResetGrid()
{
	grdPlan.GetGridControl().ColHidden(JAN)     = false ;
    grdPlan.GetGridControl().ColHidden(FEB)     = false ;
    grdPlan.GetGridControl().ColHidden(MAR)     = false ;
    grdPlan.GetGridControl().ColHidden(APR)     = false ;
    grdPlan.GetGridControl().ColHidden(MAY)     = false ;
    grdPlan.GetGridControl().ColHidden(JUN)     = false ;
    grdPlan.GetGridControl().ColHidden(JUL)     = false ;
    grdPlan.GetGridControl().ColHidden(AUG)     = false ;
    grdPlan.GetGridControl().ColHidden(SEP)     = false ;
    grdPlan.GetGridControl().ColHidden(OCT)     = false ;
    grdPlan.GetGridControl().ColHidden(NOV)     = false ;
    grdPlan.GetGridControl().ColHidden(DEC)     = false ;
    grdPlan.GetGridControl().ColHidden(JAN2)     = false ;
    grdPlan.GetGridControl().ColHidden(FEB2)     = false ;
    grdPlan.GetGridControl().ColHidden(MAR2)     = false ;
    grdPlan.GetGridControl().ColHidden(APR2)     = false ;
    grdPlan.GetGridControl().ColHidden(MAY2)     = false ;
    grdPlan.GetGridControl().ColHidden(JUN2)     = false ;
    grdPlan.GetGridControl().ColHidden(JUL2)     = false ;
    grdPlan.GetGridControl().ColHidden(AUG2)     = false ;
    grdPlan.GetGridControl().ColHidden(SEP2)     = false ;
    grdPlan.GetGridControl().ColHidden(OCT2)     = false ;
    grdPlan.GetGridControl().ColHidden(NOV2)     = false ;
    grdPlan.GetGridControl().ColHidden(DEC2)     = false ;

	COL_JAN			 = false,
    COL_FEB          = false,
    COL_MAR          = false,
    COL_APR          = false,
    COL_MAY          = false,
    COL_JUN          = false,
    COL_JUL          = false,
    COL_AUG          = false,
    COL_SEP          = false,
    COL_OCT          = false,
    COL_NOV          = false,
    COL_DEC          = false,
    COL_JAN2         = false,
    COL_FEB2         = false,
    COL_MAR2         = false,
    COL_APR2         = false,
    COL_MAY2         = false,
    COL_JUN2         = false,
    COL_JUL2         = false,
    COL_AUG2         = false,
    COL_SEP2         = false,
    COL_OCT2         = false,
    COL_NOV2         = false,
    COL_DEC2         = false;
}

function MergeHeaderInquiry()
{	
   var fg=Grid_Inquiry.GetGridControl(); 	
	if(fg.Rows < 2)
	{
	   Grid_Inquiry.AddRow();     
	}    
	fg.FixedRows = 2
	fg.MergeCells =5	
	
	fg.MergeRow(0) = true
	fg.Cell(0, 0, 5, 0, 6)  = "2010"   
	
	fg.Cell(0, 1, 5, 1, 5) = "11"
	fg.Cell(0, 1, 6, 1, 6) = "12" 
	
	fg.MergeRow(0) = true
	fg.Cell(0, 0, 7, 0, 18)  = "2011"   
	
	fg.Cell(0, 1, 7, 1, 7) = "1"
	fg.Cell(0, 1, 8, 1, 8) = "2" 
	fg.Cell(0, 1, 9, 1, 9) = "3"
	fg.Cell(0, 1, 10, 1, 10) = "4" 
	fg.Cell(0, 1, 11, 1, 11) = "5"
	fg.Cell(0, 1, 12, 1, 12) = "6" 
	fg.Cell(0, 1, 13, 1, 13) = "7"
	fg.Cell(0, 1, 14, 1, 14) = "8" 
	fg.Cell(0, 1, 15, 1, 15) = "9"
	fg.Cell(0, 1, 16, 1, 16) = "10" 
	fg.Cell(0, 1, 17, 1, 17) = "11"
	fg.Cell(0, 1, 18, 1, 18) = "12" 
	
	fg.MergeCol(0) = true
	fg.Cell(0, 0, 0, 1, 0) = "PK"	
	fg.MergeCol(1) = true
	fg.Cell(0, 0, 1, 1, 1) = "Large Division"	
	fg.MergeCol(2) = true
	fg.Cell(0, 0, 2, 1, 2) = "Detail Item"	
	fg.MergeCol(3) = true
	fg.Cell(0, 0, 3, 1, 3) = "Weight Factor"	
	fg.MergeCol(4) = true
	fg.Cell(0, 0, 4, 1, 4) = "Description"
}

function OnPopUp(obj)
{
    switch(obj)
    {
		case 'Project':
			var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
			var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			if(aValue != null)
			{
				txtProjectPk.text	= aValue[0];
				txtProject_Cd.text	= aValue[1];
				txtProject_Nm.text	= aValue[2];  
				project_pk			= txtProjectPk.text;
				dso_Date.Call();
			}
		break;
		case 'ProjectS':
			var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
			var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			if(aValue != null)
			{
				txtProjectPkS.text = aValue[0];
				txtProject_CdS.text = aValue[1];
				txtProject_NmS.text = aValue[2];
				dso_schedule_no.Call("SELECT");
			}
		break;
	}
}

function InitControl()
{
	switch (lstStatus.value)
	{
		case '1': // save
		case '3':
			btSave.SetEnable(true);
			btCancel.SetEnable(true);
			btConfirm.SetEnable(true);
			btIncrease.SetEnable(true);
			btDelete.SetEnable(true);
			btDown.SetEnable(true);
		break;
		case '2': // confirm
			btSave.SetEnable(false);			
			btCancel.SetEnable(false);
			btConfirm.SetEnable(false);
			btIncrease.SetEnable(false);
			btDelete.SetEnable(false);
			btDown.SetEnable(false);
		break;
	}
}

function OnChangeList()
{
	InitControl();
}

function frm_Onlick(obj)
{
    switch(obj.id)
	{
        case 'btIncrease':
			dso_Increase.StatusInsert();
			txtProjectPk.text = project_pk;
			dso_Increase.Call();	
        break;
		case 'btnRefPrj':
			if (txtProjectPk.text == '')
			{
				alert('Please select Project !!');
				return;
			}

            var fpath	= System.RootURL + "/form/kp/sh/kpsh00010_item_ref.aspx";
            var aValue  = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;');
			
			if (aValue != null)
			{
				txtProjectRefPk.text = aValue;
				dso_RefGetItems.Call('SELECT');
			}
			
		break;
        case 'btRegisItem':
			if (txtProjectPk.text == '')
			{
				alert('Please select Project !!');
				return;
			}

            var fpath	= System.RootURL + "/form/kp/sh/kpsh00010_item.aspx?p_project_pk=" + txtProjectPk.text;
            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			
			dso_GetItems.Call('SELECT');
		break;
		case 'btNew':
			dso_MST.StatusInsert();	
			txtProject_Cd.text = '';
			txtProject_Nm.text = '';
			
			for (row = grdPlan.rows - 1; row >= 2; row--)
			{
				grdPlan.RemoveRowAt(row);
			}
		break;
		case 'btSave':
			version = lstVersion.value;
			flag_save = true;
			lstStatus.value = '1'; // Confirm
			dso_MST.Call();
		break;
		case 'btConfirm':
			version = lstVersion.value;
			flag_save = true;
			lstStatus.value = '2'; // Confirm
			dso_MST.Call();
		break;
		case 'btCancel':
			version = lstVersion.value;
			flag_save = true;
			lstStatus.value = '3'; // Confirm
			dso_MST.Call();
		break;
		case 'btSearch':
			if (txtProjectPk.text == '')
			{
				alert('Please select Project !!');
				return;
			}
			dso_Date.Call("SELECT");
		break;
		case 'btDown':
			if (txtProjectPk.text == '')
			{
				alert('Please select Project !!');
				return;
			}
			
			var url =System.RootURL + '/reports/kp/sh/kpsh00010.aspx?p_project_pk=' + txt_progplanbase_pk.text + "&p_version=" + lstVersion.value + "&p_from=" + dtContractTarget_Fr.value +"&p_to=" + dtContractTarget_To.value;
			System.OpenTargetPage(url , 'newform');
		break;
    }
}

function OnSearchMST()
{
	if (grdSearch.row > 0 && grdSearch.GetGridData(grdSearch.row, 0) != '')
	{
		txt_progplanbase_pk.text = grdSearch.GetGridData(grdSearch.row, 0);
		dso_MST.Call("SELECT");
	}
}

function OnDataReceive(obj)
{
    switch(obj.id)
	{
		case 'dso_MST_Search':
			//progplanbase_pk = txt_progplanbase_pk.text;	
			//dso_schedule_no.Call("SELECT");
		break;
        case "dso_Date":
			txtProjectPk.text = project_pk;
			btSave.SetEnable(true);
			btConfirm.SetEnable(true);
			btCancel.SetEnable(true);
			btIncrease.SetEnable(true);
			btDelete.SetEnable(false);
			btnRefPrj.SetEnable(true); 
			btRegisItem.SetEnable(true);
			dso_schedule_no.Call("SELECT");
			
			return;
			if (txtProjectPk.text == '')
			{
				alert('Please, input 2.2.1[Adjustment Serial No. Registration]');
				txt_progplanbase_pk.text = '';
				btSave.SetEnable(false);
				btConfirm.SetEnable(false);
				btCancel.SetEnable(false);
				btIncrease.SetEnable(false);
				btDelete.SetEnable(false);
				btnRefPrj.SetEnable(false); 
				btRegisItem.SetEnable(false);
				lstVersion.ClearData();
				
				for (row = grdPlan.rows - 1; row >= 2; row--)
				{
					grdPlan.RemoveRowAt(row);
				}
			}
			else
			{
				btSave.SetEnable(true);
				btConfirm.SetEnable(true);
				btCancel.SetEnable(true);
				btIncrease.SetEnable(true);
				btDelete.SetEnable(false);
				btnRefPrj.SetEnable(true); 
				btRegisItem.SetEnable(true);
				dso_schedule_no.Call("SELECT");
				
				/*
				if (flag_save == false)
					dso_schedule_no.Call("SELECT");
				else
					OnChangeVer();
				*/
			}
        break;
        case "dso_schedule_no":
			if (version != '')
				lstVersion.SetDataText(version);
	
		for (row = grdPlan.rows - 1; row >= 2; row--)
		{
			grdPlan.RemoveRowAt(row);
		}
		
		OnChangeVer();
        break;
		case 'dso_MST_PK':
			progplanbase_pk = txt_progplanbase_pk.text;
			dso_status.Call();
		break;
		case 'dso_status':
			lstStatus.SetDataText(txtStatus.text);			
			InitControl();

			if (flag_save == true)
			{
				if (progplanbase_pk != '')
				{					
					if (grdPlan.rows > 2)
					{
						for (row = 2; row < grdPlan.rows; row++)
						{
							grdPlan.SetGridText(row, PLAN_TECPS_PROGPLANBASE_PK, progplanbase_pk);
							grdPlan.SetGridText(row, PLAN_CHANGESEQ, lstVersion.GetData());
						}
						
					dso_grdPlan.Call();
					}
				}
			}
			else
			{
				dso_grdPlan.Call("SELECT");
			}
		break;
		case 'dso_grdPlan':
			flag_save = false;
			MergeHeaderRegister();
			SetColor();
		break;
		case 'dso_GetItems':
		case 'dso_RefGetItems':
			for (i = 1; i < grdItems.rows; i++)
			{
				dup = false;

				for (row = 2; row < grdPlan.rows; row++)
				{
					if (grdItems.GetGridData(i, IT_PK) == grdPlan.GetGridData(row, PLAN_TECPS_PROPLAN_ITEM_PK))
					{
						dup = true;
						break;
					}
				}

				if (dup == false)
				{
					grdPlan.AddRow();
					for (col = PLAN_WEIGHT; col <= PLAN_TRIBUTION; col++ )
					{
						grdPlan.SetGridText(grdPlan.rows-1, col, 0);
					}
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_TECPS_PROGPLANBASE_PK, txt_progplanbase_pk.text);
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_CHANGESEQ, lstVersion.value);

					grdPlan.SetGridText(grdPlan.rows-1, PLAN_LARGE_DIV, grdItems.GetGridData(i, IT_LARGE_DIV));
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_DTL_ITEM,	grdItems.GetGridData(i, IT_DTL_ITEM));
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_PROPLAN_CD, grdItems.GetGridData(i, IT_CODE));
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_LEVEL, grdItems.GetGridData(i, IT_LEVEL));
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_TECPS_PROPLAN_ITEM_PK, grdItems.GetGridData(i, IT_PK));
					grdPlan.SetGridText(grdPlan.rows-1, PLAN_TECPS_PROJECTSUMM_PK, grdItems.GetGridData(i, IT_PROJECT_PK));
				}
			}

			MergeHeaderRegister();			
			SetColor();

			var month1, date1, year1;
			var month2, date2, year2;
			for (row = 2; row < grdPlan.rows; row++ )
			{
				if (grdPlan.GetGridData(row, PLAN_TECPS_PROGPLANBASE_PK) == '')
				{
					grdPlan.SetCellBgColor(row, 0, row, grdPlan.cols-1, 0x6699CC);
				}

				month1 = '1';
				month2 = '1';

				date1 = dtContractTarget_Fr.value;
				year1 = date1.substring(0,4);
				for (col_mm_1 = JAN+1; col_mm_1 <= PK_DEC; col_mm_1+=3 )
				{
					month1 = padLeft(month1, 2);
					grdPlan.SetGridText(row, col_mm_1, year1 + ''+ month1);

					month1 = Number(month1);
					month1++;
				}

				date2 = dtContractTarget_To.value;
				year2 = date2.substring(0,4);
				for (col_mm_2 = JAN2+1; col_mm_2 <= PK_DEC2; col_mm_2+=3 )
				{
					month2 = padLeft(month2, 2);
					grdPlan.SetGridText(row, col_mm_2, year2 + ''+ month2);

					month2 = Number(month2);
					month2++;
				}
			}
		break;
		case 'dso_MST':		
			project_pk = txtProjectPk.text;
			progplanbase_pk = txt_progplanbase_pk.text;
			dso_Date.Call("SELECT");
		break;
		case 'dso_Increase':
			dso_schedule_no.Call("SELECT");			
		break;
    }
}

function SetColor()
{
	for (row = 2; row < grdPlan.rows; row++ )
	{
		grdPlan.SetCellBgColor(row, PLAN_LARGE_DIV, row, PLAN_DTL_ITEM, 0xEDEDED);
		grdPlan.SetCellBgColor(row, PLAN_WEIGHT,	row, PLAN_WEIGHT, 0xEDEDED);
		grdPlan.SetCellBgColor(row, PLAN_RESULT,	row, PLAN_TRIBUTION, 0xEDEDED);
	}
}

function OnChangeData()
{
	var ym1 = dtContractTarget_Fr.value.substring(0,6);
	var ym2 = dtContractTarget_To.value.substring(0,6);

	if (ym2 - ym1 < 0) return;

	MergeHeaderRegister();
}

function AfterEdit()
{
	if (grdPlan.col > PLAN_UNIT)
	{
		if (isNaN(grdPlan.GetGridData(grdPlan.row, grdPlan.col)))
		{
			grdPlan.SetGridText(grdPlan.row, grdPlan.col, 0);
		}
		else
		{
			if (grdPlan.GetGridData(grdPlan.row, grdPlan.col) < 0)
			{
				grdPlan.SetGridText(grdPlan.row, grdPlan.col, 0);
			}
		}

		// Weight Factory
		var total_plan = 0, percent = 0;
		for (row = 2; row < grdPlan.rows; row++)
		{
			total_plan += Number(grdPlan.GetGridData(row, PLAN_TOTAL));
		}
		
		if (total_plan == 0) return;

		percent = 100 / total_plan;	
		for (i = 2; i < grdPlan.rows; i++)
		{
			grdPlan.SetGridText(i, PLAN_WEIGHT, percent * grdPlan.GetGridData(i, PLAN_TOTAL));
		}

		// Distribution
		var total = 0;
		for (col = JAN; col <= DEC2; col+=3 )
		{
			total += Number(grdPlan.GetGridData(grdPlan.row, col));
		}
			
		grdPlan.SetGridText(grdPlan.row, PLAN_TRIBUTION, Number(grdPlan.GetGridData(grdPlan.row, PLAN_TOTAL)) - total);
	}
}

function OnToggle()
{
	var left  = document.all("left");    
    var right = document.all("right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

function OnChangeVer()
{
	if (lstVersion.GetData() != '')
		dso_MST_PK.Call();		
}

function padLeft(n, d) 
{
	return Array(Math.max(0, d - (n + '').length + 1)).join(0) + n;
}

function OnUpload()
{
	alert('Not yet.');
	return;
	if (txtProjectPk.text == '')
	{
		alert('Please select Project !!');
		return;
	}

	var fl = document.getElementById("idtext").value; 
	var excel = new ActiveXObject("Excel.Application");
	var excel_file  = excel.Workbooks.Open(fl);
	
	var excel_sheet = excel.Worksheets("Sheet1");
	var maxRow    = excel.Worksheets("Sheet1").UsedRange.Rows.Count;
	var lrow, lcol, data

	var data;
	var i = 0;

	for (lrow = 3; lrow <= maxRow ; lrow++) 
	{
		for (lcol = 8; lcol <= 31; lcol++)
		{
			i = lcol;
			data = excel_sheet.Cells(lrow, lcol).Value;
			if (excel_sheet.ProtectContents == true)
			{
				excel_sheet.UnProtect("");
			}
			excel_sheet.Cells.Locked = false;
			excel_sheet.Cells.FormulaHidden = false;

			if (data == undefined)
				data = '';
			
			//alert(COL_MAR);
			//grdPlan.SetGridText(lrow-1, lcol, data);
		}
		return;

		//grdPlan.SetGridText(grdPlan.rows-1, G_description_type, lstDescription.value); 
		//grdPlan.SetGridText(grdPlan.rows-1, G_work_division_pk, txtWorkDivision_Pk.text); 
		//grdPlan.SetGridText(grdPlan.rows-1, G_project_pk, txtProject_Pk.text); 
	}
	excel_sheet.Application.ActiveWorkbook.save();
	excel_sheet.Application.Quit();

}
//==============================================================================================  
</script>
<body>
<gw:data id="dso_Date" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_sel_kpsh00010_date_period"  > 
			<input>
                <input bind="txtProjectPk"/>
            </input>
            <output>
                 <output bind="dtContractPeriod_Fr"/>
                <output bind="dtContractPeriod_To"/>
                <output bind="dtContractTarget_Fr"/>
                <output bind="dtContractTarget_To"/>
            </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_schedule_no" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpsh00010_plan_no" > 
            <input> 
                <input bind="txtProjectPk" />
            </input> 
            <output>
                <output bind="lstVersion" /> 
            </output>
        </dso> 
    </xml> 
</gw:data>
<gw:data id="dso_status" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_sel_kpsh00010_status"  > 
			<input> 
				<input bind="txt_progplanbase_pk" />
			 </input>
			 <output>
				<output bind="txtStatus"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_RefGetItems" onreceive="OnDataReceive(this)">
	<xml>
		<dso type="grid"  function="ec111.sp_sel_kpsh00010_plan_items" >
			<input bind="grdItems">
				<input bind="txtProjectRefPk"/>
			</input> 
			<output bind="grdItems"/>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_GetItems" onreceive="OnDataReceive(this)">
	<xml>
		<dso type="grid"  function="ec111.sp_sel_kpsh00010_plan_items" >
			<input bind="grdItems">
				<input bind="txtProjectPk"/>
			</input> 
			<output bind="grdItems"/>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_MST_Search" onreceive="OnDataReceive(this)">
	<xml>
		<dso type="control" function="ec111.sp_sel_kpsh00010_mst_search" >
			<inout>
				<inout bind="txtProjectPk"/>
				<inout bind="txt_progplanbase_pk"/>
				<inout bind="txtProject_Cd"/>
				<inout bind="txtProject_Nm"/>
				<inout bind="lstStatus"/>
			</inout>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_MST" onreceive="OnDataReceive(this)">
	<xml>
		<dso type="control" parameter="0,1,4" function="ec111.sp_sel_kpsh00010_mst" procedure="ec111.sp_upd_kpsh00010_mst" >
			<inout>
				<inout bind="txt_progplanbase_pk"/>
				<inout bind="txtProjectPk"/>
				<inout bind="txtProject_Cd"/>
				<inout bind="txtProject_Nm"/>
				<inout bind="lstStatus"/>
				<inout bind="lstVersion"/>
			</inout>
		</dso>
	</xml>
</gw:data>
<gw:data id="dso_MST_PK" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_sel_kpsh00010_mst_pk"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstVersion" />
			 </input>
			 <output>
				<output bind="txt_progplanbase_pk"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_Increase" onreceive="OnDataReceive(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpsh00010_increase"  > 
			<input> 
				<input bind="txtProjectPk" />
			 </input>
			 <output>
				<output bind="txtProjectPk"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_grdPlan" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="grid" parameter="2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85" 
		function="EC111.sp_sel_kpsh00010_dtl" procedure="EC111.sp_upd_kpsh00010_dtl" > 
            <input bind="grdPlan">
                <input bind="txt_progplanbase_pk" />
				<input bind="lstVersion" />
				<input bind="dtContractTarget_Fr" />
				<input bind="dtContractTarget_To" />
            </input> 
            <output bind="grdPlan" /> 
        </dso> 
    </xml> 
</gw:data>
<table style="width:100%;height:100% " cellpadding="0" cellspacing="0" border="1">
	<tr valign=top style="width:100%;height:100% ">
		<td id="left" style="width: 30%; height:100%; display:none">
			<table style="width: 100%" cellpadding="0" cellspacing="0" border="0" height="100%">
				<tr>
					<td style="width: 15%; height:2%" align="right">
						<a href="#" title="Click here to show Project" style="text-decoration:none" onclick="OnPopUp('ProjectS')">Project&nbsp;</a>
					</td>
					<td width="40%">
						<gw:textbox id="txtProject_CdS" readonly="true"  styles='width:100%' />
					</td>
					<td width="60%">
						<gw:textbox id="txtProject_NmS" readonly="true"  styles='width:100%' />
					</td>
					<td>
						<gw:imgbtn id="bve2" img="reset" alt="Reset"  onclick="txtProject_CdS.text='';txtProject_NmS.text='';txtProjectPkS.text='';" />
					</td>
				</tr>
				<tr>
					<td style="width: 15%; height:2%" align="right">Version</td>
					<td colspan="2">
						<gw:list id="lstVersionS" styles='width:100%' />
					</td>
					<td>
						<gw:imgbtn id="btnSearch" img="search" alt="Search"  onclick="frm_Onlick(this)" />
					</td>
				</tr>
				<tr valign="top">
					<td colspan="5" style="height:98%">
						<gw:grid   
						id="grdSearch"  
						header="_PK|Version|Status"
						format  ="0|0|0"
						aligns ="0|0|0"
						defaults="||"
						editcol ="0|0|0"
						widths="0|1500|1000"
						styles="width:100%; height:100%"   
						sorting="T"
						oncellclick = "OnSearchMST()"/>
					</td>
				</tr>
			</table>
		</td>
		<td  id="right" style="width: 70%;height:100% ">
			<table style="width: 100%" cellpadding="0" cellspacing="0" height="100%">
				<tr>
					<td style="width: 15%;disp" align="right">
						<img style="display:none" status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
						style="cursor: hand" onclick="OnToggle()" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#" title="Click here to show Project" style="text-decoration:none" onclick="OnPopUp('Project')">Project&nbsp;</a></td> 
					<td style="width: 35%">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="40%"><gw:textbox id="txtProject_Cd" readonly="true"  styles='width:100%' /></td>
								<td width="60%"><gw:textbox id="txtProject_Nm" readonly="true"  styles='width:100%' /></td>								
								<td><gw:imgbtn id="bve2" img="reset" alt="Reset"  onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProjectPk.text='';" /></td>
							</tr>
						</table>
					</td> 
					<td style="width: 15%" align="right">Sche Version&nbsp;</td>
					<td style="width: 35%">
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="40%" ><gw:list id="lstVersion" styles='width:100%' onchange="OnChangeVer()" /></td>
								<td width="20%"  align="right">Status&nbsp;</td>
								<td width="40%" ><gw:list id="lstStatus" styles='width:100%' onchange="OnChangeList()" /></td>
							</tr>
						</table>
					</td>
					<td ><gw:imgbtn id="btSearch"   img="search"    alt="Search"            onclick="frm_Onlick(this)"  /></td>
					<td style="display:none"><gw:imgbtn id="btNew"		img="new"		alt="New"				onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btSave"     img="save"      alt="Save"              onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btConfirm"  img="confirm"   alt="Confirm"           onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btCancel"   img="cancel"    alt="Cancel Confirm"    onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btIncrease" img="increase"  alt="Increase Version"  onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btDelete"   img="delete"    alt="Delete Version"    onclick="frm_Onlick(this)"  /></td>
					<td ><gw:imgbtn id="btDown"     img="download"  alt="Download"          onclick="frm_Onlick(this)"  /></td>
				</tr>    
				<tr>
					<td align="right">Main Contract Period&nbsp;</td>
					<td>
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="49%" align="left"><gw:datebox id="dtContractPeriod_Fr" lang="1" /></td>
								<td width="2%" align="center">~</td>
								<td width="49%" align="right"><gw:datebox id="dtContractPeriod_To" lang="1" /></td>
							</tr>
						</table>
					</td>
					<td width="10%"  align="right">Upload&nbsp;</td>
					<td colspan="9">
						<input type="file" id="idtext" size="1"  style="width:100%;" onChange="OnUpload()"  title="Upload"/>
					</td>
				</tr>
				<tr>
					<td align="right">Target Period&nbsp;</td>
					<td>
						<table style="width:100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="49%" align="left"><gw:datebox id="dtContractTarget_Fr" lang="1" onchange="OnChangeData()"/></td>
								<td width="2%" align="center">~</td>
								<td width="49%" align="right"><gw:datebox id="dtContractTarget_To" lang="1" onchange="OnChangeData()" /></td>
							</tr>
						</table>
					</td>
					<td colspan="10">
						
					</td>
				</tr>
				<tr>
					<td colspan="12" style="width: 100%; height:100%">
						<gw:tab id="idTab">
							<table style="width: 100%; height:100%" name="Progress Plan" id="Tab1"  cellpadding="1" cellspacing="1" border="0">
								<tr>
									<td style="height:5%">
										<fieldset style="width:100%;padding:0">
											<table  style="width: 100%" cellpadding="0" cellspacing="0" border="0">
												<tr>
													<td width="70%" align="left">
														<gw:radio id="rdoScheduleItem" value="Q" > 
															<span value="Q">Quantity</span> 
															<span value="P">Percentage</span> 
														</gw:radio >
													</td>
													<td  width="10%" align="center" style="display:none">
														<gw:icon id="btnQtyPPrepare"  img="in" text="Major Q'ty" onclick="Onlick(this)"  />
													</td>
													<td  width="10%" align="center">
														<gw:icon id="btnRefPrj" img="in" text="Ref Ath PJT" onclick="frm_Onlick(this)"  />
													</td>
													<td width="10%" align="center">
														<gw:icon id="btRegisItem" img="in" text="Major Item" onclick="frm_Onlick(this)"  />
													</td>
												</tr>
											</table>
										</fieldset>
								   </td>
								</tr>
								<tr style="display:none">
									<td style="height:50%">
										<gw:grid   
										id="grdItems"  
										header ="Large Division|Code|Dtl Items|Level|PK|project_pk"
										format ="0|0|0|0|0|0"
										aligns ="0|0|0|0|0|0"
										defaults="|||||"
										editcol ="1|1|1|1|1|1"  
										widths="0|0|0|0|0|0"
										styles="width:100%; height:100%"   
										sorting="T"  />
									</td>
								</tr>
								<tr>
									<td style="height:100%">
										<gw:grid id="grdPlan"  
										header="_PK|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|
												21|22|23|24|25|26|27|28|29|30|
												31|32|33|34|35|36|37|38|39|40|
												41|42|43|44|45|46|47|48|49|50|
												51|52|53|54|55|56|57|58|59|60|
												61|62|63|64|65|66|66|68|69|70|
												71|72|73|74|75|76|77|78|79|_80|_81|_82|_83|_84|_85"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
										editcol="0|0|0|0|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
										widths="0|2000|2500|1000|1500|1500|1500|1500|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										styles="width:100%; height:100%"
										debug="false"
										sorting="T" 
										onafteredit="AfterEdit()"/>
									</td>
								</tr>
							</table>
							<table style="width: 100%; height:100%" name="Overall Progress Check" id="Tab2"  cellpadding="0" cellspacing="0">
								<tr>
									<td style="height:5%">
											
									</td>
								</tr>

								<tr style="display:none">
									<td>
										<gw:grid   
										id="Grid_Inquiry"  
										header="_PK|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18"
										format  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
										  aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                                                    defaults="||||||||||||||||||"  
										editcol ="1|1|1|1|1|1|1"  
										widths  ="2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000"  
										styles="width:100%; height:100%"   
										sorting="T"  />
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
</body>
<gw:textbox id="txt_progplanbase_pk" readonly="true"  styles='display:none' />
<gw:textbox id="txtProjectPkS" readonly="true"  styles='width:100%;display:none' />
<gw:textbox id="txtProjectPk" readonly="true"  styles='width:100%;display:none' />
<gw:textbox id="txtStatus" readonly="true"  styles='width:100%;display:none' />
<gw:textbox id="txtProjectRefPk" readonly="true"  styles='width:100%;display:none' />
</html>