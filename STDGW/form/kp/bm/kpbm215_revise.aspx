<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Budget detail</title>
</head>
<%  ESysLib.SetUser("ec111")%>
<script>
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
function BodyInit()
{
    var vendor = document.all("updating_info"); 
    vendor.style.display = "none";
    imgup.src = "../../../system/images/down.gif";
	var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
	lstCOMPANY.SetDataText(ls_company);
	lstCOMPANY.value = "<%=session("company_pk") %>";
    BindingDataList();
	System.Translate(document);
	//FormatGrid();
	grdCONS.GetGridControl().FrozenCols     = CONS_UNIT;
 	txtuser_id.text = "<%=Session("User_ID")%>";

}
//-------------------------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
  	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 15,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 4 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| '' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 22,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 5,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

	var ls_Version = "<%=ESysLib.SetListDataSQL("select pk, UNDERTAKECHANGESEQ from ec111.tecps_undertakectrtbasc where del_if = 0 and CONFIRMYN = 'Y'")%>";
	//lstVersion.SetDataText(ls_Version);
	ls_Category = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('TPS0018') FROM DUAL")%>";
	lstField.SetDataText(ls_Category);
	
	var ls_Filter = "DATA|F|Filter";
	ls_Filter = "DATA|ALL|Select All|1|Code|2|Name|3|Child Node";
	lstSearch.SetDataText(ls_Filter);
    var	data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
    var arr  = data.split("|");
   txtbookccy.SetDataText(arr[1]);
   Merge_grid(grdCONS);

}
//-------------------------------------------------------------------------------------------------------------------------------------
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
            
			fg.ColHidden(CONS_TECPS_ITEM_PK) = true;
            fg.ColHidden(CONS_ORDER_PK) = true;
            fg.ColHidden(CONS_BUDGET_PK) = true;
            fg.ColHidden(CONS_PARENT_PK) = true;
			fg.ColHidden(CONS_LEVEL_PK) = true;
			fg.ColHidden(CONS_TECPS_PERFORMBUDGETBASC_PK) = true;
			

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
	
	//CalcBalane();
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Levelcode':
					var path = System.RootURL + '/form/kp/bm/kpbm215_pitem_4update.aspx?Project_Pk=' + txtProject_Pk.text;
					var obj = System.OpenModal( path ,900 , 600 , 'resizable:yes;status:yes');
					if ( obj != null )
					{
							txtLevel_pk_s.SetDataText(obj[3]);
							txtWork_Breakdown_Nm.text = obj[1];
					}
				break;
				case 'Work_Breakdown':
                            var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProject_Pk.text;
		                    var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		                    if ( obj != null )
		                    {
									txt_orderwork_pk.SetDataText(obj[0]);
									txtWork_Breakdown_Nm.text = obj[1] + '  -  ' +  obj[2];
								    dso_Grid_Budget_bal.Call();
                            }
                break;
                case 'Project':
					var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
					var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
					if(aValue != null)
					{
							txtProject_Pk.text = aValue[0];
							txtProject_Cd.text = aValue[1];
							txtProject_Nm.text = aValue[2];  
							dso_version.Call();
					} 
                break;
              
                case 'Version':
					var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Version.aspx?Project_Pk=" + txtProject_Pk.text;
					var aValue = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
					if(aValue != null)
					{
							lstVersion.value = aValue[0];
					} 
                break;
				case 'Category':
					var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0018';
					var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
					 if (object != null )
					 {
						 lstCategory.SetDataText(object[1]);
					 }
				break;
        }
}  
//-------------------------------------------------------------------------------------------------------------------------------------
function OnNew()
{
            if(txtProject_Pk.text == '' )
            {
                    alert('Please select Project !!');
            } 
            else
            {
              
                var _ccy= '';
                  if(Grid_Top.rows==2)
                  {
                       _ccy =  Grid_Top.GetGridData(Grid_Top.rows-1,0);
                  }
                  else if(Grid_Top.rows==1)
                  {
                    _ccy='USD';
                  }
                  else if(Grid_Top.rows>2)
                  {
                    _ccy='USD';//_ccy =  Grid_Top.GetGridData(Grid_Top.row,0);
                  }
					 var path = System.RootURL + '/form/kp/bm/kpbm215_pitem.aspx?Project_Pk=' + txtProject_Pk.text;
					 var aValue = System.OpenModal( path ,900 , 700 , 'resizable:yes;status:yes');
					 if(aValue != null)
					 {
						var tmp = new Array();
						tmp = aValue[0]; 
						txtLevel_pk.text = tmp[2]; 
						//Upper Code|Item code|Item Name|_Levelcode_pk|_item_pk|Level
						for(var i=0; i<aValue.length; i++)
						{ 
							tmp = aValue[i];
							grdCONS.AddRow();
							SetBackColor();
							grdCONS.SetGridText(grdCONS.rows - 1, 3, tmp[0]);  //level
							grdCONS.SetGridText(grdCONS.rows - 1, 4, tmp[1]); //code
							grdCONS.SetGridText(grdCONS.rows - 1, 5, tmp[2]); //name
							grdCONS.SetGridText(grdCONS.rows - 1, 32, tmp[3]); //_Levelcode_pk 
							grdCONS.SetGridText(grdCONS.rows - 1, 26, tmp[4]); //_item_pk 
							grdCONS.SetGridText(grdCONS.rows - 1, 2, tmp[5]); //Level 
							grdCONS.SetGridText(grdCONS.rows - 1, 30, txtProject_Pk.text); //pk  
							grdCONS.SetGridText(grdCONS.rows - 1, 1, lstVersion.value); //version pk  
							//grdCONS.SetGridText(grdCONS.rows - 1, 3, i ); 
							
							grdCONS.SetGridText(grdCONS.rows - 1, 7, _ccy); //version pk  
						}
					
						if(lstField.value != 'ALL')
						{
									grdCONS.SetGridText(grdCONS.rows - 1, 6, lstField.value); //version pk  
						}
						else
						{return;}
					
					}
                    
           } 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnEditLevel()
{
	
	if(event.col=='14' || event.col=='15')
	{
		var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProject_Pk.GetData();
		var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
		 
		if (object != null)
		{
			grdCONS.SetGridText(grdCONS.row, 28,   object[0]);
			grdCONS.SetGridText(grdCONS.row, 14, object[1]);
			grdCONS.SetGridText(grdCONS.row, 15, object[2]);
		}
	}
	if(event.col=='16' || event.col=='17')
	{
		var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx?p_project_pk=" + txtProject_Pk.GetData();
		var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if(object != null)
		{
			grdCONS.SetGridText(grdCONS.row, 27,   object[0]);
			grdCONS.SetGridText(grdCONS.row, 16, object[1]);
			grdCONS.SetGridText(grdCONS.row, 17, object[2]);
		}
	}
	if(event.col=='18')
	{
		 var fpath = System.RootURL + "/form/kp/ac/kpac00070.aspx"
		var object = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if (object != null)
		{
			grdCONS.SetGridText(grdCONS.row, 29,   object[0]);
			grdCONS.SetGridText(grdCONS.row, 18, object[1]+' - '+object[2]);
		}
	}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function CheckDuplicateLevel()
{
    for(var i = 1; i < grdCONS.rows; i++)
    {
        if(grdCONS.GetGridData(i, 20) == txtLevel_pk.text)
        {
             alert("Duplicated Level Code!! ");
             return false ;
        }
    }
    return true;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnSearch()
{
	if(txtProject_Pk.text != '' )
	{
		if (txt_orderwork_pk.GetData()=='')
		{
			alert('Please select order work.');
			return;
		}
		dso_Update.Call("SELECT");
	}
	else
	{
			alert('Please select a project to search !!');	
	}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCheckSum()
{
    var i=0;
    var j = 0;
    var _total_book_amt = 0;
    var _total_grid_bk = 0;
    var _total_grid_tr = 0;
    
    if(Number(txtBalance.text)<0)
    {
        alert('Contract Amount can not be large than Trans. Amount !!');
        return true;
    }
    return false;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnSave()
{
	/*for(i=1;i<grdCONS.rows;i++)
		{
		    grdCONS.SetGridText(i,31,lstField.GetData());
			if( grdCONS.GetGridData(i,0) =='' && grdCONS.GetGridData(i,33) =='I' )
			{
			   grdCONS.SetRowStatus(i, 0x20);
			}
		}*/

        var ctl = grdCONS.GetGridControl();
		for (row = 2; row < grdCONS.rows; row++)
		{
			if ( grdCONS.GetGridData(row, CONS_LEVEL_NUM) == "1" )
			{
				grdCONS.SetRowEditable(row, false);
				grdCONS.SetCellBgColor(row, 0, row, grdCONS.cols - 1, Number('0XF4E6E0'));
			}
		}
	   dso_Update.Call();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDelete()
{
		if(confirm('Are you sure you want to delete ?'))
        grdCONS.DeleteRow();
		OnSave();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnUnDelete()
{
        grdCONS.UnDeleteRow();

}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
function CalcBalane()
{
    var i=0;
    var _Sum_ContAmt = 0;
    var _Trans_Amt = 0;
    var _Balance = 0;
    var _Sum_BookAmt_Top = 0;
    var j=0;                
    
    
    if(grdCONS.rows>2)
    {
        for(i=2;i<grdCONS.rows;i++)
        {
            _Sum_ContAmt += Math.round(Number(grdCONS.GetGridData(i,32)));
        }
    }
    txtContAmt_Total.text = _Sum_ContAmt;
    if(Grid_Top.rows==2)
    {
        _Trans_Amt = Number(Grid_Top.GetGridData(Grid_Top.rows-1, 2));
        _Balance = Math.round(_Trans_Amt - _Sum_ContAmt);
    }
    else if(Grid_Top.rows>2)
    {
        for(j=1;j<Grid_Top.rows;j++)
        {
            _Sum_BookAmt_Top += Math.round(Number(Grid_Top.GetGridData(j,5)));
        }
        _Balance = Math.round(_Sum_BookAmt_Top - _Sum_ContAmt);
    }
    txtBalance.text = _Balance;
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
         switch(obj.id)
         {
			case "dso_Update":
			/*var ctrl     = grdCONS.GetGridControl();
            for (i=1; i<ctrl.Rows; i++)
            {
                if(grdCONS.GetGridData(i,2) != "")
                {
                    grdCONS.SetCellBold(i,0,i,32,true);
                }
                else
                {   
                    grdCONS.SetCellBold(i,0,i,32,false);
                }
                
                
                if (grdCONS.GetGridData(i,2)== "0" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XF4E6E0'));
                }
                else if (grdCONS.GetGridData(i,2)== "1" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0X99CCFF'));
                }
                else if (grdCONS.GetGridData(i,2)== "2" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XCCFFCC'));
                }
                else if (grdCONS.GetGridData(i,2)== "3" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XCCFF00'));//3 00CCFF
                }
                else if (grdCONS.GetGridData(i,2)== "4" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XFF99CC'));//4
                }
                else if (grdCONS.GetGridData(i,2)== "5" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XCC9999'));//5
                }
                else if (grdCONS.GetGridData(i,2)== "6" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0X009933'));//6m
                }
                else if (grdCONS.GetGridData(i,2)== "7" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XCC6633'));//7
                }
                else if (grdCONS.GetGridData(i,2)== "8" && grdCONS.GetGridData(i,26) == "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0X006666'));//8
                }
                else if (grdCONS.GetGridData(i,4) != "")
                {
                    grdCONS.SetCellBgColor(i,0,i,32, Number('0XEFFFFF'));
                }
				
                
            }*/
			Merge_grid(grdCONS);
			break;
				case "dso_copy":
					dso_Update.Call("SELECT");
					alert(txtReturnValue.text);
				break;
             	case "dso_version":
						dso_top.Call("SELECT");
				break;
                case 'dso_top':
                    var vendor = document.all("updating_info"); 
                    if(Grid_Top.rows>1)
                    {
                        vendor.style.display = "";
                        imgup.src = "../../../system/images/up.gif";
                    }
                    else
                    {
                        vendor.style.display = "none";
                        imgup.src = "../../../system/images/down.gif";
                    }
                    dso_Intergrated_YN.Call();
                break;
				case "dso_Intergrated_YN":
                
						 var fg=grdCONS.GetGridControl(); 	
                         	if(txtIntergrated_YN.text == 'Y')
							{
									fg.ColHidden(11) = true; //Labor Unit Cost
									fg.ColHidden(12) = true; //Labor Amt
									fg.ColHidden(13) = true; //Cost Unit Cost
									fg.ColHidden(14) = true; //Cost Amt
									fg.ColHidden(15) = true; //Material Unit Cost
									fg.ColHidden(16) = true; //Material Amt
									fg.ColHidden(17) = true; //Material Unit Cost
									fg.ColHidden(18) = true; //Material Amt
									fg.ColHidden(19) = true; //Material Amt
									//fg.ColHidden(24) = true; //Cost Amt
									fg.ColHidden(25) = true; //Material Unit Cost
									fg.ColHidden(26) = true; //Material Amt
									fg.ColHidden(27) = true; //Material Unit Cost
									fg.ColHidden(28) = true; //Material Amt
									fg.ColHidden(29) = true; //Material Amt
									fg.ColHidden(30) = true; //Material Amt
							}
							else
							{
									fg.ColHidden(10) = false; //Labor Unit Cost
									fg.ColHidden(11) = false; //Labor Unit Cost
									fg.ColHidden(12) = false; //Labor Amt
									fg.ColHidden(13) = false; //Cost Unit Cost
									fg.ColHidden(14) = false; //Cost Amt
									fg.ColHidden(15) = false; //Material Unit Cost
									fg.ColHidden(16) = false; //Material Amt
									fg.ColHidden(17) = false; //Material Unit Cost
									fg.ColHidden(18) = false; //Material Amt
									fg.ColHidden(19) = false; //Material Amt
									//fg.ColHidden(24) = false; //Cost Amt
									fg.ColHidden(25) = false; //Material Unit Cost
									fg.ColHidden(26) = false; //Material Amt
									fg.ColHidden(27) = false; //Material Unit Cost
									fg.ColHidden(28) = false; //Material Amt
									fg.ColHidden(29) = false; //Material Amt
									fg.ColHidden(30) = false; //Material Amt
							}
							SetBackColor();
							dso_get_book_rate.Call();
				break;
				case "dso_Delete":
						dso_Update.Call("SELECT");
						alert(txtReturnValue.text);
				break;
         }
}


//-------------------------------------------------------------------------------------------------------------------------------------
function SetBackColor()
{
		var fg=grdCONS.GetGridControl(); 	
		for (i = 2; i < fg.Rows; i++)
		{
					/*grdCONS.SetCellBgColor(i,11,i, 19, 0xEDEDED);
					grdCONS.SetCellBgColor(i,26,i, 26, 0xEDEDED);
					grdCONS.SetCellBgColor(i,28,i, 28, 0xEDEDED);
					grdCONS.SetCellBgColor(i,30,i, 30, 0xEDEDED);
					grdCONS.SetCellBgColor(i,32,i, 32, 0xEDEDED);
					grdCONS.SetCellBgColor(i,33,i, 34, 0xEDEDED);*/
		}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
 function OnShowHide(obj)
 {
	 		var fg=grdCONS.GetGridControl(); 	
	 		switch(obj)
			{
				case 1:
						if(cbLevelCode.value == 'N')
						{
								fg.ColHidden(4) = true; //Level Code
						}
						else
						{
								fg.ColHidden(4) = false; //Level Code
						}
				break;
				case 2:
						if(cbStd.value == 'N')
						{
								fg.ColHidden(8) = true; //Standard
						}
						else
						{
								fg.ColHidden(8) = false; //Standard
						}
				break;
				case 3:
						if(cbUnit.value == 'N')
						{
								fg.ColHidden(9) = true; //Unit
						}
						else
						{
								fg.ColHidden(9) = false; //Unit
						}
				break;
				case 4:
						if(cbRaw.value == 'N')
						{
								fg.ColHidden(13) = true;
								fg.ColHidden(15) = true;
								fg.ColHidden(17) = true;
								fg.ColHidden(26) = true;
								fg.ColHidden(28) = true;
								fg.ColHidden(30) = true;
						}
						else
						{
								fg.ColHidden(13) = false;
								fg.ColHidden(15) = false;
								fg.ColHidden(17) = false;
								fg.ColHidden(26) = false;
								fg.ColHidden(28) = false;
								fg.ColHidden(30) = false;
						}
				break;
				case 5:
						if(cbCompared.value == 'N')
						{
								
								fg.ColHidden(11) = true;
								fg.ColHidden(12) = true;
								fg.ColHidden(13) = true;
								fg.ColHidden(14) = true;
								fg.ColHidden(15) = true;
								fg.ColHidden(16) = true;
								fg.ColHidden(17) = true;
								fg.ColHidden(18) = true;
								fg.ColHidden(19) = true;
								fg.ColHidden(33) = true;
								fg.ColHidden(34) = true;
						}
						else
						{
								
								fg.ColHidden(11) = false;
								fg.ColHidden(12) = false;
								fg.ColHidden(13) = false;
								fg.ColHidden(14) = false;
								fg.ColHidden(15) = false;
								fg.ColHidden(16) = false;
								fg.ColHidden(17) = false;
								fg.ColHidden(18) = false;
								fg.ColHidden(19) = false;
								fg.ColHidden(33) = false;
								fg.ColHidden(34) = false;
						}
				break;
			}
 }
//-------------------------------------------------------------------------------------------------------------------------------------
function OnCalculator()
{
	   
		var c_qty = Number(grdCONS.GetGridData(grdCONS.row, 8));
        var c_MUP = Number(grdCONS.GetGridData(grdCONS.row, 9));
        var c_LUP = Number(grdCONS.GetGridData(grdCONS.row, 10));
        var c_EUP = Number(grdCONS.GetGridData(grdCONS.row, 11));
		
		var c_UP = Number(grdCONS.GetGridData(grdCONS.row, 12));
		var c_Material_Amt = 0;
		var _Bk_Material_UP = 0;
		var _Bk_Material_Amt = 0;
		
		var c_Labor_Amt = 0;
		var _Bk_Labor_UP= 0;
		var _Bk_Labor_Amt = 0;
		
		var c_Equipment_Amt = 0;
		var _Bk_Equipment_UP = 0;
		var _Bk_Equipment_Amt = 0;
		
		var c_Sum_UnitPrice = 0;
		var c_Amount = 0;
		var _Amount1 = 0;
		var _Amount_bk = 0;
		var _Amount_bk1 = 0;
		var _Bk_Sum_UnitPrice = 0;
		var _Bk_Sum_UnitPrice1 = 0;
        var _UP=0;
		if (c_qty == '') c_qty = 0;
		if (_Bk_Equipment_UP == '') _Bk_Equipment_UP = 0;			
		
		    c_Material_Amt = Number(c_qty) * Number(c_MUP);
			c_Labor_Amt = Number(c_qty * c_LUP); 
			c_Equipment_Amt = Number(c_qty * c_EUP);
			c_Sum_UnitPrice = Number(c_MUP) + Number(c_LUP) + Number(c_EUP);
			c_Amount = Number( c_Material_Amt + c_Labor_Amt + c_Equipment_Amt);
			_Amount1 = Number(c_qty * c_UP);
	//==========tinh tien book===========================
		var _book_rate = Number(txtBookRate.text);
		var tr_rate = Number(txtTR_RATE.text);
		lstCcy.text = grdCONS.GetGridData(event.row, 10);
		if(txtbookccy.text == 'VND' && _book_rate > 0)
		{
				if(grdCONS.GetGridData(event.row, 10) == 'USD')
				{
						OnGetRate();
						_Bk_Material_UP = Math.round(c_MUP * tr_rate);
						_Bk_Material_Amt = Math.round(c_Material_Amt * tr_rate);
						_Bk_Labor_UP = Math.round(c_LUP * tr_rate);
						_Bk_Labor_Amt = Math.round(c_Labor_Amt * tr_rate);
						_Bk_Equipment_UP = Math.round(c_EUP * tr_rate);
						_Bk_Equipment_Amt = Math.round(c_Equipment_Amt * tr_rate);
						_Bk_Sum_UnitPrice = Math.round(c_Sum_UnitPrice * tr_rate);
						_Amount_bk1 = Math.round(_Amount1 * tr_rate);
						_Amount_bk = Math.round(c_Amount * tr_rate);
						_UP = Math.round(c_UP * tr_rate);
				}
				else if(lstCcy.text == 'VND')
				{
						_Bk_Material_UP = c_MUP ;
						_Bk_Material_Amt = c_Material_Amt;
						_Bk_Labor_UP = c_LUP ;
						_Bk_Labor_Amt = c_Labor_Amt ;
						_Bk_Equipment_UP = c_EUP ;
						_Bk_Equipment_Amt = c_Equipment_Amt;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice ;
						_Amount_bk1 = _Amount1 ;
						_Amount_bk = c_Amount;
						_UP = c_UP ;
				}
                else
                {
                        OnGetRate();
                        _Bk_Material_UP = Math.round(c_MUP * tr_rate);
						_Bk_Material_Amt = Math.round(c_Material_Amt * tr_rate);
						_Bk_Labor_UP = Math.round(c_LUP * tr_rate);
						_Bk_Labor_Amt = Math.round(c_Labor_Amt * tr_rate);
						_Bk_Equipment_UP = Math.round(c_EUP * tr_rate);
						_Bk_Equipment_Amt = Math.round(c_Equipment_Amt * tr_rate);
						_Bk_Sum_UnitPrice = Math.round(c_Sum_UnitPrice * tr_rate);
						_Amount_bk1 = Math.round(_Amount1 * tr_rate);
						_Amount_bk = Math.round(c_Amount * tr_rate);
						_UP = Math.round(c_UP * tr_rate);
                }
		}  
		else if(txtbookccy.text == 'USD' && _book_rate > 0)
		{
				if(lstCcy.text == 'USD')
				{
							_Bk_Material_UP = c_MUP ;
						_Bk_Material_Amt = c_Material_Amt;
						_Bk_Labor_UP = c_LUP ;
						_Bk_Labor_Amt = c_Labor_Amt ;
						_Bk_Equipment_UP = c_EUP ;
						_Bk_Equipment_Amt = c_Equipment_Amt;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice ;
						_Amount_bk1 = _Amount1 ;
						_Amount_bk = c_Amount;
						_UP = c_UP ;
				}
				else if(lstCcy.text == 'VND')
				{
				       
						_Bk_Material_UP = c_MUP / _book_rate ;
						_Bk_Material_Amt = c_Material_Amt / _book_rate ;
						_Bk_Labor_UP = c_LUP  / _book_rate ;
						_Bk_Labor_Amt = c_Labor_Amt  / _book_rate;
						_Bk_Equipment_UP = c_EUP / _book_rate ;
						_Bk_Equipment_Amt = c_Equipment_Amt / _book_rate;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice / _book_rate;
						_Amount_bk1 = _Amount1 / _book_rate ;
						_Amount_bk = c_Amount / _book_rate ;
						_UP = c_UP  / _book_rate ;
				}
                else
                {
                    OnGetRate();
					_Bk_Material_UP =  c_MUP *  tr_rate / _book_rate ;
						_Bk_Material_Amt = c_Material_Amt  *  tr_rate / _book_rate ;
						_Bk_Labor_UP = c_LUP  *  tr_rate  / _book_rate ;
						_Bk_Labor_Amt = c_Labor_Amt   *  tr_rate / _book_rate ;
						_Bk_Equipment_UP = c_EUP   *  tr_rate / _book_rate;
						_Bk_Equipment_Amt = c_Equipment_Amt  *  tr_rate  / _book_rate ;
						_Bk_Sum_UnitPrice = c_Sum_UnitPrice  *  tr_rate  / _book_rate ;
						_Amount_bk1 = _Amount1  *  tr_rate  / _book_rate;
						_Amount_bk =  c_Amount   *  tr_rate / _book_rate ;
						_UP = c_UP   *  tr_rate  / _book_rate ;
                }
		}

		
        CalcBalane();
}
//-------------------------------------------------------------------------------------------------------------------------------
function FormatGrid()
{ 
	var ctrl = grdCONS.GetGridControl();
	
	ctrl.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(10) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(11) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(12) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(13) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(20) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(21) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(22) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(23) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(24) = "#,###,###,###,###,###,###,###,###.##R";
	ctrl.ColFormat(25) = "#,###,###,###,###,###,###,###,###.##R";
}
//-------------------------------------------------------------------------------------------------------------------------------
function OnPrint()
{
		if(txtProject_Pk.text != '')
		{
			var url = System.RootURL + "/reports/kp/bp/kpbp00050.aspx?Project_pk=" +txtProject_Pk.text + "&Work=" + lstWork_Breakdown.text + "&Field=" + lstField.value +  "&Version=" + lstVersion.value + "&Intergrated_YN=" + txtIntergrated_YN.text;
			 System.OpenTargetPage(url);       
		}
		else
		{
				alert('Please select Project !!');	
		}
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnCopy()
{
	dso_copy.Call();
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnGetRate()
{
	dso_get_trans_rate.Call();	
}
//---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDeleteAll()
{
		if(confirm("Are you sure you want to delete all data!!"))
		{
				dso_Delete.Call();
		} 
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnOriginal()
{
	if(lstVersion.GetText() == 0)
	{
		grdCONS.SetGridText(grdCONS.row, 11, grdCONS.GetGridData(grdCONS.row, 24));
		grdCONS.SetGridText(grdCONS.row, 12, grdCONS.GetGridData(grdCONS.row, 25));
		grdCONS.SetGridText(grdCONS.row, 13, grdCONS.GetGridData(grdCONS.row, 26));
		grdCONS.SetGridText(grdCONS.row, 14, grdCONS.GetGridData(grdCONS.row, 27));
		grdCONS.SetGridText(grdCONS.row, 15, grdCONS.GetGridData(grdCONS.row, 28));
		grdCONS.SetGridText(grdCONS.row, 16, grdCONS.GetGridData(grdCONS.row, 29));
		grdCONS.SetGridText(grdCONS.row, 17, grdCONS.GetGridData(grdCONS.row, 30));
		grdCONS.SetGridText(grdCONS.row, 18, grdCONS.GetGridData(grdCONS.row, 31));
		grdCONS.SetGridText(grdCONS.row, 19, grdCONS.GetGridData(grdCONS.row, 32));
	}
}
//-------------------------------------------------------------------------------------------------------------------------------------
function OnShow() 
{
    var vendor = document.all("updating_info"); 
 
    if ( vendor.style.display == "none" )
    {
        vendor.style.display = "";
        imgup.src = "../../../system/images/up.gif";
    }
    else
    {
        vendor.style.display = "none";
        imgup.src = "../../../system/images/down.gif";
    }
}
//------------------------------------------------------
function OnClick(obj)
{
	switch(obj.id)
	{
	    case 'grdCONS':
		break;
	}
}
//-----------------------------------------------------
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
		        
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk=" + txtProject_Pk.text;
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
		        
				var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Budget.aspx?p_project_pk=" + txtProject_Pk.text;
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
			        var fpath = System.RootURL + "/form/kp/bm/kpbm00050_Item.aspx?p_project_pk=" + txtProject_Pk.text
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
//----------------------------------------------------------------------------------------------------
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
	
		    }
		break;
	}
}
//-------------------------------------------------------------------------------------------------------------------------------------

</script>
<body>
    <!-------------------------------------------------------->
    <gw:data id="dso_Update" onreceive="OnDataReceive(this)">
        <xml>
             <dso id="dso_Update" type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12,15,16,17,19,20,21,22,23,24,25,26,28,29,30,32,33,34,35,36" function="EC111.sp_sel_kpbm00050_cons2" procedure="EC111.SP_UPD_KPBM00050_CONS" > 
            <input bind="grdCONS">                    
                <input bind="txtProject_Pk" />
				<input bind="lstVersion" />
				<input bind="txt_orderwork_pk" />
				<input bind="lstSearch" />
				<input bind="txtSearch" />
               <input bind="txtuser_id" />
            </input> 
            <output bind="grdCONS" /> 
            </dso>
        </xml>
    </gw:data>
   <!-------------------------------------------------------->
   <gw:data id="dso_get_book_rate" onreceive="">
        <xml> 
            <dso type="process" procedure="ec111.sp_pro_kpbp00050_getrate"> 
                <input> 
                	 <input bind="txtProject_Pk" />
                </input>
                <output>
                     <output bind="txtBookRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------->
    <gw:data id="dso_version" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.sp_pro_kpbm215_1" > 
            <input> 
                <input bind="txtProject_Pk" />
            </input>
	       <output>
	            <output bind="lstVersion" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
<!---------------------------------------------------------------->
<gw:data id="dso_Intergrated_YN" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="ec111.SP_PRO_SEL_kpbp00050_2" > 
            <input> 
                <input bind="txtProject_Pk" />
                <input bind="lstVersion" />
            </input>
	       <output>
	            <output bind="txtIntergrated_YN" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------------------------------->
<gw:data id="dso_copy" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="process"   procedure="ec111.sp_Pro_kpbp00050_copy"  > 
                <input> 
                    <input bind="lstVersion" /> 
                    <input bind="txtProject_Pk" />
                 </input>
                 <output>
                    <output bind="txtReturnValue"/>
                 </output>
            </dso> 
        </xml> 
    </gw:data>
 <!-------------------------------------------------------->   
<gw:data id="dso_get_trans_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ec111.sp_pro_kpbp00050_get_transrate" > 
                <input> 
                     <input bind="txtProject_Pk"/>
                     <input bind="lstCcy"/>
                </input>
                <output>
                     <output bind="txtTR_RATE"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>    
<!-------------------------------------------------------->    
<gw:data id="dso_Delete" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process" procedure="ec111.sp_Pro_kpbp00050_Delete" >
                <input> 
					<input bind="txtProject_Pk" />
                    <input bind="lstVersion" />             				 
                </input>  
                <output>
                     <output bind="txtReturnValue" />
				</output> 
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------->    
<gw:data id="dso_top" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso id="1" type="grid"  function="ec111.sp_sel_kpbm2151_2"    > 
				<input bind="Grid_Top">                    
					<input bind="txtProject_Pk" /> 
					<input bind="lstVersion" /> 
				</input> 
				<output bind="Grid_Top" /> 
			</dso> 
		</xml> 
	</gw:data>
<!-------------------------------------------------------->    
<gw:data id="dso_Grid_Budget_bal" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso id="1" type="grid"  function="ec111.sp_sel_kpbm2151_1"    > 
				<input bind="Grid_Budget_bal">                    
					<input bind="txtProject_Pk" /> 
					<input bind="lstVersion" /> 
					<input bind="txt_orderwork_pk" /> 
				</input> 
				<output bind="Grid_Budget_bal" /> 
			</dso> 
		</xml> 
	</gw:data>


    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
        <tr style="height: 6%">
            <td width="100%">
                <fieldset style="padding: 0">
                    <table cellpadding="1" cellspacing="1" width="100%">
                        <tr>
                            <td width="100%">
                                <table cellpadding="0" cellspacing="2" width="100%">
                                    <tr>
									   <td align="right" width="10%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">Project</a></td>
                                        <td width="10%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                        <td width="40%" colspan="2"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td>
                                        <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
										<td align="right" width="10%" style="display:">Version</td>
										<td width="10%"><gw:list id="lstVersion" readonly="true" onchange="OnSearch()" styles="width:100%;" /></td> 
									    <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="Select Level Code" text="New" onclick="OnNew()" /></td>						<td width="1%"><gw:imgbtn id="btnNew" img="new" alt="Select item code" text="New" onclick="OnNewFree()" /></td>
										<td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" /></td>
										<td width="1%"><gw:imgbtn id="btnRemove" img="cancel" alt="Clear" text="Delete" onclick="OnClear()"/></td>
										<td width="1%"><gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete()"/></td>
										<td width="1%"><gw:imgbtn id="btnUnDelete" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete()"/></td>
										<td width="1%"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint(1)" /></td>
										<td width="1%"><gw:imgbtn id="btnPrint1" img="excel" alt="Print" text="Print" onclick="onPrint(2)" /></td>
										<td width="1%"><gw:imgbtn id="btnPrint2" img="excel" alt="Total Summary" text="Print" onclick="onPrint(3)" /></td>
                                    </tr>
									<tr>
									   <td align="right" width="10%"><a title="Click here to show Filter" href="#" style="text-decoration: none" onClick="OnPopUp('Category')">Budget field</a></td>
                                         <td width="10%"><gw:list id="lstField" styles="width:100%;" /></td>
                                         <td  width="10%" align="right" ><a title="Click here to show order work" href="#" style="text-decoration: none" onClick="OnPopUp('Work_Breakdown')">Order work</a></td>
                                        <td width="30%"><gw:textbox id="txtWork_Breakdown_Nm" styles="width:100%;display:" /></td>
										<td><gw:imgbtn id="ibtnUpdte" img="reset" alt="Reset" onclick="txtWork_Breakdown_Nm.text='';txt_orderwork_pk.text='';" /></td>
										<td width="10%" align="right">Search by</td>
										<td width="14%" colspan="2"><gw:list id="lstSearch"  onchange="" styles="width:100%;" /></td> 
									    <td width="16%" colspan="7"><gw:textbox id="txtSearch"  onenterkey="OnSearch()"  styles="width:100%;" /></td> 
										<td width="1%"><gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch()" /></td> 
                                    </tr>
                                </table>
                            </td>
                         </tr>
                         
                        <tr>
                        	
                            <td  width="100%" >
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
									       <td align="right"><a title="Column Selection"  style="text-decoration: none; color:#333" >Col. Sel.</a></td>
                                        	<td width="13%"><gw:checkbox id="cbLevelCode" defaultvalue="Y|N" value="Y" onclick="OnShowHide(1)"  /> Level Code</td>
                                            <td width="8%"><gw:checkbox id="cbStd" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(2)" /><a title="Standard" style="color:#333">Std.</a></td>
                                            <td width="8%"><gw:checkbox id="cbUnit" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(3)" /> Unit</td>
                                            <td width="20%"><gw:checkbox id="cbRaw" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(4)" /><a title="Raw Material/Labor/Equipment" style="color:#333">Raw Mtrl/Labor/E</a></td>
                                            <td width="20%"><gw:checkbox id="cbCompared" defaultvalue="Y|N" value="Y"  onclick="OnShowHide(5)" /><a title="Compared with Original" style="color:#333">Compared w/ Ori</a></td>
                                           
                                            
                                          
                                    </tr>
                                </table>           
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr height="2%">
    <td width="100%" align="left"><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow()" /></td>
</tr>
<tr height="14%" id="updating_info">
    <td width="100%">
        <gw:grid   
        id="Grid_Top"  
       header="_Revision|_Approval Request No.|Contract CCY|Ex. Rate|Contract Amount|Book Contract Amt. |Budget ccy|Budget Ex.Rate|Budget Amount|Book Ccy|Book Ex. Rate|Book budget amount|Status|_Approved Date|_Create Date|_Drafter|_pk"
                    format="0|0|0|-2|-2|-2|0|-2|-2|0|-2|-2|0|0|0|0|0" 
                    aligns="0|0|0|3|3|3|0|3|3|0|3|3|0|0|0|0|0" 
                    defaults="||||||||||||||||"
                    editcol="0|0|0|3|3|3|0|3|3|0|3|3|0|0|0|0|0" 
                    widths="900|1200|1000|1000|2000|2000|1000|1000|2000|1000|1000|2000|1000|1200|1200|1200|0"
                    styles="width:100%; height:140%" 
                    sorting="T"  
        /> 
    </td>        
</tr>
<tr height="15%" id="Budget_bal">
    <td width="100%">
        <gw:grid   
        id="Grid_Budget_bal"  
        header="Budget Ccy|Budget amt.(trs.)|Budget Amt.(book.)|Sub.ccy|Outsourcing amt.(trs.)|Outsourcing amt.(book.)|Balance (book.)|Book ex.rate"   
        format  ="1|-2|-2|1|-2|-2|-2|-2"  
        aligns ="1|3|3|1|3|3|3|3"  
        defaults="|||||||"  
        editcol ="0|0|0|0|0|0|0|0"  
        widths  ="1500|2500|2500|1500|2500|2500|2500|1500"  
        styles="width:100%; height:100%"   
        sorting="T" 
        onafteredit=""  
        oncellclick="" 
        /> 
    </td>        
</tr>
        <tr style="height: 72%" id="top">
            <td colspan="" style="background-color:">
                <!-- header="_0.budget_detail_pk|_1.TECPS_PERFORMBUDGETBASC_pk|2.Level|3.Upper Code|4.Level Code|5.Name|6.Unit(1)|7.CCY(2)|8.Quantity(3)|9.RM U/Price(4)|10.Labor U/P(5)|11.Exp. U/P(6)|12.Unit Price (7)=(4)+(5)+(6)|13.Amount(8)=(3)*(7)|14.Ord. W Code(9)|15.Ord. W. Name|16.Buget code(10)|17.Budget name|18.Standard code(11)|19.Booking CCY|20.Booking Ex.rate(12)|21.Booking RM. U/P.(13)|22.Booking Labor U/P.(14)|23.Booking Exp. U/P(15)|24.Booking U/P(16)|25.Booking Amount(17)|26.tecps_item_pk|27.budget_pk|28.orderwork_pk|29.Standard_pk|30.project_pk|31.Field|32_level_code_pk|33.item"-->
                <gw:grid id="grdCONS" 
				header="0|1|2|3|4|5|6|7|8|9|10|11|_12|13|14|15|16|_17|18|19|20|21|22|_23|_24|_25|_26|_27|_28|_29|_30|_31|_32|_33|34|_35|_StandardCode_pk" 
				format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
				aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
				defaults="||||||||||||||||||||||||||||||||" 
				editcol="0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|0|1|1|1|1|1|1|0|0|0|0|0|0|0|0"
				widths="1000|2000|4000|1000|1000|1000|2000|2000|2000|2000|2000|3000|2000|1500|3000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1200|0|0"
				styles="width:100%; height:100%" 
				sorting="T" 
				debug="false"
				oncellclick="OnClick(this)"
				oncelldblclick="OnDBClick(this)"										
				editcolcolor="true"
				onafteredit="CheckData(this)"/>
            </td>
        </tr>
        <tr style="height:2%">
        <td>
                <table width="100%" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse" border="1">
                    <tr style="background:#C5EFF1">
                        <td align="right" width="50%">Contract Amount Total&nbsp;</td>
                        <td width="20%"><gw:textbox id="txtContAmt_Total" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
                        <td align="right" width="10%">Balance&nbsp;</td>
                        <td width="20%"><gw:textbox id="txtBalance" readonly="true" styles='width:100%' type="number" format="###,###.##R" /></td>
                    </tr>
                </table>
        </td>
  </tr>
        <tr style="height: 1%; display:none ">
            <td>
                <fieldset style="padding: 0">
                    <table style="width: 100%" cellpadding="0" cellspacing="0">
                        <tr style="background-color: White">
                            <td width="50%">
                            </td>
                            <td>
                                <img status="expand" id="imgArrow" src="../../../system/images/down.gif" style="cursor: hand;"
                                    onclick="OnToggle()" /></td>
                            <td align="right" width="40%">
                                Level&nbsp;</td>
                            <td width="10%">
                                <gw:list id="lstLevel" onchange="OnSearch()" styles="width:100%;" />
                            </td>
                            <td style="display: none">
                                <gw:datebox id="txtUSE_DATE" lang="1" styles='width:100%;display:none' />
                            </td>
                            <td style="display: none">
                                <gw:textbox id="txt_row" styles='display:none' />
                            </td>
                            <td style="display:none ">
                                 
                                
          <gw:textbox id="txtBK_RATE"  styles='width:100%;display:none' />
          <gw:list id="txtccy" onchange="OnGetRate()" styles='width:100%;display:none' />
                            </td>
                            <td style="display: none">
                                <gw:list id="lstCOMPANY" styles='width:100%;display:none' />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
       
    </table>
    <gw:textbox id="txtLevel_pk" styles='width:100%;display:none' />
	<gw:textbox id="txtLevel_pk_s" styles='width:100%;display:' />
    <gw:textbox id="txtbookccy" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <gw:textbox id="txtIntergrated_YN" styles='width:100%;display:none' />
    <gw:textbox id="txtBookRate" styles='width:100%;display:none' />
    <gw:textbox id="txtTR_RATE" styles="width:100%;display:none" />
    <gw:textbox id="lstCcy" styles="width:100%;display:none" /> 
	<gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
    <gw:textbox id="txt_orderwork_pk" styles="width:100%;display:none" />
	<gw:textbox id="txtuser_id" styles="width:100%;display:none" />
</body>
</html>
