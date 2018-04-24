<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
    <title>BCWS Details Registration</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>

var flag = '';
var cons_uder = false;
var level_pk;
var budgetNo;
var arrayBudget;


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
	CONS_TECPS_ITEM_PK              = 35,
    CONS_STAN_CODE_PK = 36
    ;



var status_control;

function BodyInit()
{ 
	System.Translate(document);
	BindingDataList();
	Merge_grid(grdCONS);
    grdCONS.GetGridControl().FrozenCols     = CONS_UNIT;
 	txtuser_id.text = "<%=Session("User_ID")%>";
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
				dso_BudgetNo.Call('SELECT');
		    }
	    break;
        case 'Work_Breakdown':
            if (txtProjectPk.text == '')
            {
                alert('Please, select Project !!!');
                return;
            }
	    
            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProjectPk.text;
            var obj = System.OpenModal(path , 600, 600, 'resizable:yes;status:yes');
            if ( obj != null )
            {
	            if (obj[2] != 0)
	            {
                    switch(idTab.GetCurrentPageNo())
                    {
                        case 0:
                            txtFilter1.text	= obj[0];
                        break;
                        case 1:
                            txtFilter2.text	= obj[0];
                        break;
                    }
                }
			    
                OnSearch();
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
				var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (obj != null)
		        {
                    switch(idTab.GetCurrentPageNo())
                    {
                        case 0:
                            txtFilter1.text	= obj[1];
                        break;
                        case 1: 
                            txtFilter2.text	= obj[1];
                        break;
                    }
			    
                OnSearch();
				}
			}
        break;
    }    
}

function OnSearch()
{
	if (txtProjectPk.text != '')
	{
	    flag = 'SELECT';
	    switch(idTab.GetCurrentPageNo())
	    {
		    
		    case 1:
			    dso_grdCONS.Call('SELECT');
		    break;
		  
	    }
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
			fg.Cell(0, 0, CONS_UNIT, 0, CONS_AMT)	= "Working (Version No : 0)"
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

		
	}
	
	CalcBalane();
}
 //---------------------------------------------------------
 function BindingDataList()
 {
	var data = '';
	data = "DATA|ALL|Select All|1|Level Code|2|Std|3|Wgt|4|Compared w/|5|Compared w/|6|Order Work|7|Order W. Div|8|Exec Y/N|9|Bdgt Code|10|Std PBS|11|Dlvr. Terms|12|Dlvr.(Y/N)|13|Cont. Dtals";
	
	data = "DATA|ALL|Select All|N|Non-Cont.|Y|Cont.";

	data = "DATA|ALL|Select All|1|Raw Mtrl. Cost|2|Labor Cost|3|Outsrc. Cost|4|Exp.";
	
	data = "DATA|ALL|Select All|1|Code|2|Name|3|Child Node|4|Order W. Code";
	lstFilter1.SetDataText(data);
	lstFilter1.value = 'ALL';
    txtFilter1.text = '';
	txtFilter1.style.display = 'none';
    idCode1.style.display = "none";
    
	//data = "DATA|ALL|Select All|1|Code|2|Name|3|Standard|4|Order W. Code|5|Budget Code|6|Standard Code";
	data = "DATA|ALL|Select All|1|Code|2|Name|3|Child Node|4|Order W. Code";
	lstFilter2.SetDataText(data);
	lstFilter2.value = 'ALL';
	txtFilter2.text = '';
	txtFilter2.style.display = 'none';
	btnLevelCode2.style.display = "none";
	btnLevelCode3.style.display = "none";
    
	data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code";
	lstFilter4.SetDataText(data);
	lstFilter4.value = 'ALL';

	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
	lstCOMPANY.SetDataText(ls_company);
	lstCOMPANY.value = "<%=session("company_pk") %>";

	

	// Contruction
	//Exec.YN
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 15,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 4 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| '' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 22,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

	
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
		    break;
		   
		    
	    }
	}   
}

function CheckDuplicateLevel(grd, level_pk, level_name, level_num)
{
    switch (grd.id)
    {
	   
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
	    
    }
}

function CheckDuplicateLevelChild(grd, num, level_pk, item_pk, item_code)
{
    switch (grd.id)
    {
	    
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
	   
    }
}

function OnSave()
{
    dso_Status.Call();
}

function OnClear()
{
    switch(idTab.GetCurrentPageNo())
	{
	    
	    case 1:
	        for (row = 2; row < grdCONS.rows; row++)
            {
                if (grdCONS.GetGridControl().isSelected(row))
                {
	                if (grdCONS.col == CONS_ORDER_CODE || grdCONS.col == CONS_ORDER_NAME)
	                {
	                    grdCONS.SetGridText(row, CONS_ORDER_PK, '');           
	                    grdCONS.SetGridText(row, grdCONS.col, '');
	                }
        	        
	                if (grdCONS.col == CONS_BUDGET_CODE)
	                {
	                    grdCONS.SetGridText(row, CONS_BUDGET_PK, '');
	                    grdCONS.SetGridText(row, grdCONS.col, '');
	                }
	            }
            }
	    break;
	   
	}
}

function OnDelete()
{
	switch(idTab.GetCurrentPageNo())
	{
		
		case 1:
		    if(confirm("Are you sure to delete !!!"))
            {
                for (row = 2; row < grdCONS.rows; row++)
                {
                    if (grdCONS.GetGridControl().isSelected(row))
                    {
                        if (grdCONS.GetGridData(grdCONS.row, CONS_PK) == '')
                        {						            				
                            grdCONS.RemoveRowAt(row);
                        }        			
                        else 
                        {  
                            grdCONS.DeleteRowAt(row);
                        }
                    }
                }
            }
		break;
		
	}
}

function OnUnDelete()
{
	switch(idTab.GetCurrentPageNo())
	{
		
		case 1:
            for (row = 2; row < grdCONS.rows; row++)
            {
                if (grdCONS.GetGridControl().isSelected(row))
                {
                    grdCONS.UnDeleteRowAt(row);
                }
            }   
		break;
		
	}
}

function onPrint(n)
{
    if (txtProjectPk.text != "")
    {    
        switch (n)
        {
            case 1:
                switch(idTab.GetCurrentPageNo())
                {
	               
	                case 1:
		                var path = System.RootURL + "/reports/kp/bm/kpbm00050_cons.aspx?p_project_pk=" + txtProjectPk.text
		                + "&p_budget_no="	+ lstBudgetNo.value + "&p_work="		+ ''
		                + "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter2.value
		                + "&p_filter="		+ txtFilter2.text;
		                System.OpenTargetPage(path , 'newform');
	                break;
	              
                }
            break;
            case 2:
                switch(idTab.GetCurrentPageNo())
                {
	               
	                case 1:
		                var path = System.RootURL + "/reports/kp/bm/kpbm00050_cons_1.aspx?p_project_pk=" + txtProjectPk.text
		                + "&p_budget_no="	+ lstBudgetNo.value ;
		                System.OpenTargetPage(path , 'newform');
	                break;
	                
                }
            break;
            case 3:
                var path = System.RootURL + "/reports/kp/bm/rpt_kpbm215_summary.aspx?p_project_pk=" + txtProjectPk.text + "&p_budget_pk="	+ lstBudgetNo.value;
                System.OpenTargetPage(path , 'newform');
            break;

        }
    }
}

function CalcBalane()
{
	var _Sum_ContAmt 	 = 0;
    var _Trans_Amt 		 = 0;
    var _Balance 		 = 0;
    var _Sum_BookAmt_Top = 0;        
	
	switch(idTab.GetCurrentPageNo())
	{
		case 0:
			txtBudgetAMT_Total.text = _Sum_ContAmt;
			txtBalance.text = _Balance;
		break;	
		case 1:
			for ( i = 2; i < grdCONS.rows; i++)
			{
				if (grdCONS.GetGridData(i, CONS_TECPS_ITEM_PK) != '')
					_Sum_ContAmt += System.Round(Number(grdCONS.GetGridData(i, CONS_AMT)),0);
			}	
			txtBudgetAMT_Total.text = _Sum_ContAmt;
			
			if (Grid_Top.rows == 2)
			{
				_Trans_Amt = Number(Grid_Top.GetGridData(Grid_Top.rows-1, 2));
				_Balance = Math.round(_Trans_Amt - _Sum_ContAmt);
			}
			else if (Grid_Top.rows > 2)
			{
				for( j = 1; j < Grid_Top.rows; j++)
				{
					_Sum_BookAmt_Top += Math.round(Number(Grid_Top.GetGridData(j, 5)));
				}
				_Balance = Math.round(_Sum_BookAmt_Top - _Sum_ContAmt);
			}
			txtBalance.text = _Balance;
		break;
		case 2:
			txtBudgetAMT_Total.text = _Sum_ContAmt;
			txtBalance.text = _Balance;
		break;
		case 3:
			txtBudgetAMT_Total.text = _Sum_ContAmt;
			txtBalance.text = _Balance;
		break;
	}
}

function OnReceiveData(obj)
{
	switch(obj.id)
	{
		case 'dso_BudgetNo':
			dso_top.Call("SELECT");
		break;
		case 'dso_top':
			OnSearch();
		break;
		case 'dso_Status':
			  flag = '';
	            switch(idTab.GetCurrentPageNo())
	            {
		           
		            case 1:	
			            dso_grdCONS.Call();
		            break;
		           
	            }
      
		break;
		
		case 'dso_grdCONS':
		    var ctl = grdCONS.GetGridControl();
		    
		    for (row = 2; row < grdCONS.rows; row++)
            {
                if ( grdCONS.GetGridData(row, CONS_LEVEL_NUM) == "1" )
                {
                    grdCONS.SetRowEditable(row, false);
		            grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols - 1, Number('0XF4E6E0'));
		        }
		        
		        if (chkQty.value == 'Y')
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
			            alert('');
				        grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols-1, 0x8B8B52);
				        grdCONS.SetGridText(row, grdCONS.cols-1, 0x10);
			        }
                }
            }
			//alert(flag);
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
					txtBudgetNo.text = lstBudgetNo.GetText();
					dso_grdCONS_UNDERTAKE.Call('SELECT');
				}
				
			}
		break;
		case 'dso_grdCONS_Pro':
			OnSearch();
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

function OnClick(obj)
{
	switch(obj.id)
	{
	    case 'grdEQ':		    
		break;
		case 'grdCONS':
		break;
		case 'grdCM':
		break;
		case 'grdOther':
		break;
	}
}

function CheckData(obj)
{
	switch(obj.id)
	{
		
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

			/*	if (event.col == CONS_QTY || event.col == CONS_RAW || event.col == CONS_LABOR || event.col == CONS_EXP_UP )
				{
					
				}*/
				
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
		
		case 'grdCONS':			
			if (grdCONS.col == CONS_ORDER_CODE || grdCONS.col == CONS_ORDER_NAME)
			{
			    if (grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK) != '') 
		        {
		            grdCONS.row = -1;
		            return;
		        }
		        
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
			    if (grdCONS.GetGridData(grdCONS.row, CONS_LEVEL_PK) != '') 
		        {
		            grdCONS.row = -1;
		            return;
		        }
		        
				var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx?p_project_pk=" + txtProjectPk.text;
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
            else if(grdCONS.col == CONS_STAN_CODE)
            {
                var fpath = System.RootURL + "/form/kp/ac/kpac00070.aspx"
				var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                if (object != null)
				{
					grdCONS.SetGridText(grdCONS.row, CONS_STAN_CODE_PK,   object[0]);
					grdCONS.SetGridText(grdCONS.row, CONS_STAN_CODE, object[1]+' - '+object[2]);
				}
            }
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
	
	}
}

function OnChangeFilter()
{
    switch(idTab.GetCurrentPageNo())
    {
        
        case 1:
	        if (lstFilter2.value == 'ALL')
			{
			    txtFilter2.text = '';
                txtFilter2.style.display = 'none';
				btnLevelCode2.style.display = "none";
				btnLevelCode3.style.display = "none";
				OnSearch();
			}
			else if (lstFilter2.value == '1' || lstFilter2.value == '2' || lstFilter2.value == '3')
			{
			    txtFilter2.style.display = '';
				btnLevelCode2.style.display = "";
				btnLevelCode3.style.display = "none";
			}
			else if (lstFilter2.value == '4')
			{
			    txtFilter2.style.display = '';				
				btnLevelCode2.style.display = "none";
				btnLevelCode3.style.display = "";
			}
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
<gw:data id="dso_Status" onreceive="OnReceiveData(this)"> 
	<xml>                                                               
		<dso id="1" type="process" procedure="ec111.sp_pro_kpbm00050_status"  > 
			<input> 
				<input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
			 </input>
			 <output>
				<output bind="txtStatus"/>
			 </output>
		</dso> 
	</xml>
</gw:data>
<gw:data id="dso_grdCONS" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="5" type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12,15,16,17,19,20,21,22,23,24,25,26,28,29,30,32,33,34,35,36" function="EC111.sp_sel_kpbm00050_cons1" procedure="EC111.SP_UPD_KPBM00050_CONS" > 
            <input bind="grdCONS">                    
                <input bind="txtProjectPk" />
				<input bind="lstBudgetNo" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter2" />
				<input bind="txtFilter2" />
               <input bind="txtuser_id" />
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
<gw:data id="dso_top" onreceive="OnReceiveData(this)"> 
	<xml> 
		<dso id="1" type="grid"  function="ec111.sp_sel_kpbp122"    > 
			<input bind="Grid_Top">                    
				<input bind="txtProjectPk" /> 
			</input> 
			<output bind="Grid_Top" /> 
		</dso> 
	</xml> 
</gw:data>
<table style="background: #BDE9FF; height: 97%; width: 100%" border="0" >
	<tr>
		<td style="width: 100%; height:98%; background:white">
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
								 <td width="25%">
								    <table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
								        <tr>						    
								            <td width="40%">Version</td>
								            <td width="60%" align="right"><gw:list id="lstBudgetNo"  styles='width:100%' onchange="OnSearch()" /></td>
								         </td>								        
								        </tr>
								    </table>		
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
												<gw:imgbtn id="btnRemove" img="cancel" alt="Clear" text="Delete" onclick="OnClear()"/>
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
												<gw:imgbtn id="btnPrint1" img="excel" alt="Print" text="Print"
													onclick="onPrint(2)" />
											</td>
											<td style="width: 1%">
												<gw:imgbtn id="btnPrint2" img="excel" alt="Total Summary" text="Print"
													onclick="onPrint(3)" />
											</td>
										</tr>
									</table>
								</td>
							</tr>                               
							<tr>
								<!--td  align="right">
								<a href="#"  title="Click here to show Work Division"  onClick="OnPopUp('Work_Breakdown')" style="text-decoration:none">W. Div</a></td>
								<td >
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td style="display:none">
												<gw:textbox id="txtWork_Breakdown" styles="width:100%" onchange="OnSearch()" />
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
								</td-->
							</tr>
							 <tr>                                			
								<!--td align="right" width="10%">
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
								 </td-->
								 <td align="right">
										<gw:checkbox id="chkQty" value="Y" defaultvalue="Y|N" onchange="OnSearch()" />
								 </td>
								 <td colspan="2">Excluding detail of which quantity is "0"</td>
							</tr>
						</table>
						</fieldset>
					</td>
				</tr>

				<tr style="height: 98%">
					<td colspan="7">
						<gw:tab id="idTab" onpageactivate="OnSearch()">
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%;"
								name="Equipment" id="Tab1" border="0">
								<tr style="height: 1%">
									<td style="width: 100%;">
										<table style="width: 100%; height: 100%;" border="0">
											<tr style="width: 100%; height: 100%;">
												<td  align="center" style="display:none">
													<gw:checkbox id="chk1" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code
												</td>												
												<td align="center"  style="display:none">
													<gw:checkbox id="chk2" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Standard
												</td>													
												<td align="center"  style="width:10%">
													<gw:checkbox id="chk3" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Weight
												</td>												
												<td align="center"  style="width:10%">
													<gw:checkbox id="chk6" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Order W. Div
												</td>
												<td align="center"  style="width:10%">
													<gw:checkbox id="chk7" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Exec Y/N
												</td>												
												<td align="center"  style="width:10%"><gw:checkbox id="chk8" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Budget Code</td>
												
												<td align="center"  style="width:10%" nowrap><gw:checkbox id="chk9" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(9)"/>Standard PBS</td>
												
												<td align="center"  style="width:10%"><gw:checkbox id="chk10" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(10)" />Dlvr. Terms</td>
												
												<td align="center"  style="width:10%"><gw:checkbox id="chk11" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(11)" />Dlvr.(Y/N)</td>
												
												<td align="center"  style="width:10%"><gw:checkbox id="chk12" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(12)" />Cont. Dtals</td>
											</tr>								
											<tr style="width: 100%; height: 100%;">
												<td colspan="2"  align="right" style="width:20%">
													<gw:list id="lstFilter1" styles="width: 60%" onchange="OnChangeFilter()" />
												</td>												
												<td colspan="2" align="center" style="width:20%">
													<gw:textbox id="txtFilter1" styles="width: 100%" />
												</td>
												<td id="idCode1" style="width: 10%" align="left">
													<gw:icon id="btnLevelCode1" img="in" text="Popup" onClick="OnPopUp('Work_Breakdown')"   />
												</td>		
												<td colspan="2" align="right" style="width:20%">
													Total
												</td>
												
												<td colspan="2" align="center" style="width:20%">
													<gw:list id="lstTotal1" styles="width: 100%" />
												</td>

												<td align="right" style="width:20%">
													<gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch()" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height: 98%">
									<td style="width: 100%">
										<gw:grid id="grdEQ" header="0|1|2|3|4|5|6|7|8|9|_10|11|12|13|_14|15|16|17|18|19|_20|_21|_22|_23|_24|_25|_26|_27|_28|_29|_30|_31|_32" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||||||||||||" editcol="0|0|0|1|1|1|1|1|1|0|1|0|0|1|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0" 				widths="1000|2000|4000|1200|2000|1000|1000|2000|2000|1000|1000|1200|1000|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0|0|0" 
										styles="width:100%; height:100%" 
										sorting="T" debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"										
										editcolcolor="true"
										onafteredit="CheckData(this)"/>
									</td>
								</tr>
							</table>
						   
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%;"
								name="Construction" id="Tab2" border="0">
								<tr style="height: 1%">
									<td style="width: 100%;">
										<table style="width: 100%; height: 100%;" border="0">
											<tr style="width: 100%; height: 100%;">
												<td  align="center" style="width:10%" nowrap=" align="center" ><gw:checkbox id="chk21" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
												<td  align="center" style="width:10%"><gw:checkbox id="chk22" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Std</td>
												<td  align="center" style="width:10%" nowrap ><gw:checkbox id="chk23" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Raw Mtrl/Labor/Exp</td>
												<td  align="center" style="width:10%"><gw:checkbox id="chk24" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(4)" />Order W.</td>
												<td  align="center" style="width:10%"><gw:checkbox id="chk25" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(5)" />Exec Y/N</td>
												<td  align="center" style="width:10%" nowrap><gw:checkbox id="chk26" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Dir. Mgt Outsrc.</td>
												<td  align="center" style="width:10%"><gw:checkbox id="chk27" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Bdgt Code</td>
												<td  align="center" style="width:10%"><gw:checkbox id="chk28" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Std Code</td>
												<td colspan=2 align="right" style="width:10%">
													<gw:imgbtn id="btnSearchs1"styles="width: 100%" img="search" onclick="OnSearch()" />
												</td>
											</tr>
											<tr style="width: 100%; height: 100%;">
												<td style="width: 10%" align="right">
													<gw:list id="lstFilter2" styles="width: 100%" onchange="OnChangeFilter()" />
												</td>
												<td width="10%">
													<gw:textbox id="txtFilter2" styles="width: 100%" onenterkey="OnSearch()" />
												</td>
												<td style="width: 10%" align="left" nowrap>
													<gw:icon id="btnLevelCode2" img="in" text="Popup" onClick="OnPopUp('Work_Breakdown')"   />													
													<gw:icon id="btnLevelCode3" img="in" text="Popup" onClick="OnPopUp('OutsideOrderWork')"   />
												</td>
												<td style="width: 10%" align="left">
												</td>
												<td style="width: 10%" align="right"></td>
												<td style="width: 10%" >
													
												</td>
												<td align="right" style="width: 10%"></td>
												<td align="right" style="width:10%">
												</td>
												<td align="right" style="width:10%"></td>
												<td align="right" style="width:10%">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr style="height: 98%">
									<td style="width: 100%">
										<gw:grid id="grdCONS" 
										header="0|1|2|3|4|5|6|7|8|9|10|11|_12|13|14|15|16|_17|18|19|20|21|22|_23|_24|_25|_26|_27|_28|_29|_30|_31|_32|_33|34|_35|_StandardCode_pk" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||||||||||||" 
										editcol="0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|0|1|1|1|1|1|1|0|0|0|0|0|0|0|0"
										widths="1000|2000|4000|1000|1000|1000|2000|2000|2000|2000|2000|3000|2000|1500|3000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1200|0|0"
										styles="width:100%; height:100%" sorting="T" debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)"										
										editcolcolor="true"
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
										<gw:imgbtn id="btnSearchs2" img="search" alt="Search" onclick="OnSearch()" />
									</td>
								</tr>
								<tr style="height: 99%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdCM" header="_0|1|2|_3|4|5|6|7|8|9|10|11|12|13|14|15|16|_17|18|19|20|21|_22|_23|_24|_25|_26|_27|_28|_29|_30|_31"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="||||||||||||||||||||||||||||||"
										editcol="0|0|1|0|0|0|0|0|1|1|1|0|1|1|1|0|0|1|0|0|1|1|1|1|0|0|0|0|0|0|0"
										widths="1000|1100|2000|1000|2000|4000|1000|2000|1000|1500|2000|1500|1000|1500|2000|1500|2000|1000|1000|2000|1000|1000|1000|1000|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" sorting="T" 
										debug="false"
										oncellclick="OnClick(this)"
										oncelldblclick="OnDBClick(this)" 
										editcolcolor="true"
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
													<gw:list id="lstFilter4" styles="width: 100%"  onchange="OnChangeFilter()" />
												</td>
												<td colspan="3" width="18%"><gw:textbox id="txtFilter4" styles="width: 100%" /></td>
												<td  style="width: 5%" align="right">Total</td>
												<td colspan="3" style="width: 25%" ><gw:list id="lstTotal4" styles="width: 100%" /></td>
												<td style="width: 1%">				
													<gw:imgbtn id="btnSearchs3" img="search" alt="Search" onclick="OnSearch()" />
												</td>
											</tr>	
										</table>
									</td>
								</tr>
								<tr style="height: 99%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdOther" header="_0|_1|2|3|4|5|6|7|8|9|10|11|_12|13|14|15|16|_17|_18|_19|_20|_21|_22|_23|_24|_25|_26"  
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||||||" 
									    editcol="1|1|1||0|1|1|1|1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0|0|0|0|0"
										widths="1000|1000|1000|3000|4000|2000|1500|1000|1000|2000|2000|2500|1000|1000|1000|1000|1000|0|0|0|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" 
										sorting="T" 
										debug="true"
										oncellclick="OnClick(this)" 
										oncelldblclick="OnDBClick(this)" 
										editcolcolor="true"
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
	<tr >
		<td style="width: 100%; height:98%; background:white">
			<table width="100%" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse" border="1">
				<tr style="background:#C5EFF1">
					<td align="right" width="50%">Budget Amount Total&nbsp;</td>
					<td width="20%"><gw:textbox id="txtBudgetAMT_Total" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
					<td align="right" width="10%">Balance&nbsp;</td>
					<td width="20%"><gw:textbox id="txtBalance" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="display:none" >
		<td>
			<gw:grid id="Grid_Top" 
			header="Trans Ccy|Ex.Rate|Trans Amt|Book Ccy|Book Ex.Rate|Book Amt" 
			format="0|1|1|0|1|1"  
			aligns="1|3|3|1|3|3"  
			defaults="|||||"  
			editcol ="1|1|1|1|1|1"  
			widths  ="1000|1500|3000|1000|1500|2000"  
			styles="width:100%; height:100%"   
			sorting="T" />
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
	<gw:textbox id="txtStatus" styles="width:100%;display:none" />
	<gw:textbox id="txtuser_id" styles="width:100%;display:none" />
    <!----------------------------------------------------------------------------------------->
</body>
</html>