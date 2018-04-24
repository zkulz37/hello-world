<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Changed SubContract Registration</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script type="text/javascript" language="javascript">
 var WkngItemNo = 0,
	DetailsLevelCode = 1,
	DetailsLevelSeqNo = 2,
	Name = 3,
	Standard = 4,
	Weight = 5,
	Unit = 6,

	C_Qty = 7,
	C_RawMtrlCostUP = 8,
	C_RawMtrlCostAmt = 9,
	C_LaborCostUP = 10,
	C_LaborCostAmt = 11,
	C_ExpUP = 12,
	C_ExpAmt = 13,
	C_UP = 14,
	C_Amt = 15,

	W_Qty = 16,
	W_RawMtrlCostUP = 17,
	W_RawMtrlCostAmt = 18,
	W_LaborCostUP = 19,
	W_LaborCostAmt = 20,
	W_ExpUP = 21,
	W_ExpAmt = 22,
	W_UP = 23,
	W_Amt = 24,

	B_Qty = 25,
	B_RawMtrlCostUP = 26,
	B_RawMtrlCostAmt = 27,
	B_LaborCostUP = 28,
	B_LaborCostAmt = 29,
	B_ExpUP = 30,
	B_ExpAmt = 31,
	B_UP = 32,
	B_Amt = 33,

	A_Qty = 34,
	A_RawMtrlCostUP = 35,
	A_RawMtrlCostAmt = 36,
	A_LaborCostUP = 37,
	A_LaborCostAmt = 38,
	A_ExpUP = 39,
	A_ExpAmt = 40,
	A_UP = 41,
	A_Amt = 42,

	ID_Qty = 43,
	ID_RawMtrlCostUP = 44,
	ID_RawMtrlCostAmt = 45,
	ID_LaborCostUP = 46,
	ID_LaborCostAmt = 47,
	ID_ExpUP = 48,
	ID_ExpAmt = 49,
	ID_UP = 50,
	ID_Amt = 51,
	
	VAT_Rate = 52,
	VAT_Amt = 53,
	pk = 54,
	confirm_ = 55,
	Total = 56,
	tecps_1200_pk = 57,
	vendorbasc_pk = 58,
	project_pk = 59,
	Item_pk = 60
	Level_pk = 61
	;  
function BodyInit()
{
      System.Translate(document);
      var vendor = document.all("updating_info"); 
      vendor.style.display = "none";
      imgup.src = "../../../system/images/down.gif";
	  BindingDataList();
      MerGrid();
}  
//===================================================================================================================================
function BindingDataList()
{
     // thieu cmc
} 
//===================================================================================================================================
function Hide()
{
	txtCurrCode.SetEnable(false);
	txtBCWS_A.SetEnable(false);
	txtSupplyAmt_B.SetEnable(false);
	txtCont_Amt.SetEnable(false);
	txtIncrDecr_Amt.SetEnable(false);
	txtVAT.SetEnable(false);

	dtFrom.SetEnable(false);
	dtTo.SetEnable(false);

	txtAdvPay.SetEnable(false);
	txtPP.SetEnable(false);
	txtBall.SetEnable(false);
	txtCash.SetEnable(false);
	txtNote.SetEnable(false);

	txtAdvPayReturnGuar.SetEnable(false);
	txtContBond.SetEnable(false);
	txtDGuar.SetEnable(false);
	txtDGuarPer.SetEnable(false);
	
	txtIncr_Date.SetEnable(false);
	txtRetentionRate.SetEnable(false);
}
//===================================================================================================================================
function OnSearch()
{
	if(txtProject_Pk.text != '')
	{
		dso_search.Call();	
	}
	else
	{
		alert('Please select Project !!');
	}
}
//===================================================================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'prj':
		    var path = System.RootURL + '/form/61/05/61050020_popup.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProject_Pk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2]; 
				dso_ContCode.Call()
		    }
	    break;
	    
    }
    
}

function Calc_IncrDecrAmt()
{
//        var Cont_Amt_1 = Number(Grid_Mst.GetGridData(Grid_Mst.rows-1, 11));
//		var Cont_Amt_2 = Number(Grid_Mst.GetGridData(Grid_Mst.rows-2, 11));
//		var  IncrDecr_Amt = 0;
//		IncrDecr_Amt =  Math.round(Cont_Amt_1 - Cont_Amt_2);
//		alert(IncrDecr_Amt);
//		Grid_Mst.SetGridText(Grid_Mst.rows-1 = )
}
//-------------------------------------------------------------------------
function onDelete_d()
{
	if(confirm('Do you want to delete selected item?'))
	{
		 Grid_Detail.DeleteRow();
		 dso_grdDetail.Call();
	 }
    
}
//===================================================================================================================================
function OnDataReceive(obj)
{
		switch (obj.id)
		{
			case "dso_ContCode":
				dso_search.Call();
			break;
			case 'dso_search':
			    dso_BdgtAmt.Call();
			break;
			case 'dso_BdgtAmt':
			        dso_grid.Call('SELECT');
			break;
			case 'dso_update':
				OnVisible('Per');
				OnVisible('Supply');
				OnVisible('Pay');
				OnVisible('Guar');
				if(Grid_Mst.rows > 2)
			    {
						    var Cont_Amt = Number(Grid_Mst.GetGridData(Grid_Mst.rows-1, 6));
						    var  Cont_Amt_F = Number(Grid_Mst.GetGridData(Grid_Mst.rows-2, 6));
						    var  IncrDecr_Amt = 0;
						    IncrDecr_Amt =  Math.round(Cont_Amt - Cont_Amt_F);
						    //txtIncrDecr_Amt.SetDataText(IncrDecr_Amt);
//                            alert(Cont_Amt);
//                            alert(Cont_Amt_F);
						    Grid_Mst.SetGridText(Grid_Mst.rows-1, 7, IncrDecr_Amt);
			    }
			    else
			    {
						    txtIncrDecr_Amt.SetDataText(0);
			    }
                if(flag=='update')
                {
                    dso_grid.Call();
                }
                else
                {
                    dso_grdDetail.Call('SELECT');
                }
			break;
			case 'dso_grid':
			//alert(Grid_Mst.rows);
			    if(Grid_Mst.rows==2)
			    {
			            Grid_Mst.SetGridText(Grid_Mst.rows-1, 1, '0');
			    }
			    if(flag=='update')
			    {
			        dso_grdDetail.Call();
			    }
				else
				{
					 dso_grdDetail.Call('SELECT');
				}
               
			break;
            case 'dso_grdDetail':
                MerGrid();
                //dso_grid.Call('SELECT');
            break;
            case 'dso_Inrease':
                    dso_grid.Call('SELECT');
            break;
		}
}
//===================================================================================================================================
function OnVisible(obj)
{
			switch(obj)
			{
					case 'Per':
							if(chkPer.value == 'Y')
							{
									dtFrom.SetEnable(true);
			 						dtTo.SetEnable(true);	
							}
							else
							{
									dtFrom.SetEnable(false);
			 						dtTo.SetEnable(false);	
							}
					break;
					case 'Supply':
							if(chkSupply_Amt.value == 'Y')
							{
									txtVAT.SetEnable(true);
									//txtVAT.GetControl().focus();
									vat.style.background='#F69';
							}
							else
							{
									txtCurrCode.SetEnable(false);
									txtBCWS_A.SetEnable(false);
									txtSupplyAmt_B.SetEnable(false);
									txtCont_Amt.SetEnable(false);
									txtIncrDecr_Amt.SetEnable(false);
									txtVAT.SetEnable(false);
									vat.style.background='none';
							}
					break;
					case 'Pay':
							if(chkPay_Terms.value == 'Y')
							{
									txtAdvPay.SetEnable(true);
									txtPP.SetEnable(true);
									txtBall.SetEnable(true);
									txtCash.SetEnable(true);
									txtNote.SetEnable(true);
									a.style.background='#F69';
									b.style.background='#F69';
									c.style.background='#F69';
									d.style.background='#F69';
									e.style.background='#F69';
							}
							else
							{
									txtAdvPay.SetEnable(false);
									txtPP.SetEnable(false);
									txtBall.SetEnable(false);
									txtCash.SetEnable(false);
									txtNote.SetEnable(false);
									a.style.background='none';
									b.style.background='none';
									c.style.background='none';
									d.style.background='none';
									e.style.background='none';
							}
					break;
					case 'Guar':
							if(chkGuar_Terms.value == 'Y')
							{
									txtAdvPayReturnGuar.SetEnable(true);
									txtContBond.SetEnable(true);
									txtDGuar.SetEnable(true);
									txtDGuarPer.SetEnable(true);
									f.style.background='#F69';
									g.style.background='#F69';
									h.style.background='#F69';
									k.style.background='#F69';
							}
							else
							{
									txtAdvPayReturnGuar.SetEnable(false);
									txtContBond.SetEnable(false);
									txtDGuar.SetEnable(false);
									txtDGuarPer.SetEnable(false);
									f.style.background='none';
									g.style.background='none';
									h.style.background='none';
									k.style.background='none';
							}
					break;
			}
}
//===================================================================================================================================
function OnClick()
{
    if(Grid_Mst.GetGridData(Grid_Mst.row, 2) == 'Yes')
    {
        btnSave.SetEnable(false);
        btnConfirm.SetEnable(false);
        btnCancel.SetEnable(true);
        btnDelete.SetEnable(false);
        ibtnew_d.SetEnable(false);
        ibtnDel.SetEnable(false);
    }
    else 
    {
        btnCancel.SetEnable(false);
        btnSave.SetEnable(true);
        btnConfirm.SetEnable(true);
        btnDelete.SetEnable(true);
        ibtnew_d.SetEnable(true);
        ibtnDel.SetEnable(true);
    }

    if(Grid_Mst.GetGridData(Grid_Mst.row, 1) == '0')
    {
        ibtnew_d.SetEnable(false);
        ibtnDel.SetEnable(false);
        btnExcel1.SetEnable(false);
        btnExcel2.SetEnable(false);
        btnDelete.SetEnable(false);
    }
    else
    {
        
        btnExcel1.SetEnable(true);
        btnExcel2.SetEnable(true);
    }    
			txtPk.text = Grid_Mst.GetGridData(Grid_Mst.row, 14);
			txtTECPS_SUBSTRP12000_pk.text = Grid_Mst.GetGridData(Grid_Mst.row, 0);
			txtserial_no.text = Grid_Mst.GetGridData(Grid_Mst.row, 1);
			flag='search';
			dso_update.Call('SELECT');
}
var flag;
//===================================================================================================================================
function  OnSave()
{
//        if(Grid_ContAmt.row < 1)
//		{
//			Grid_Detail.SetGridText(Grid_Detail.rows -1, 7, '');
//		}
//		else
//		{
//			Grid_Detail.SetGridText(Grid_Detail.rows -1, 7, Grid_ContAmt.GetGridData(Grid_ContAmt.rows -1, 1));
//		}
        var _Supply_Amt = 0;
        var _VAT_Amt = 0;
        var i =0;
        for(i=2;i<Grid_Detail.rows;i++)
        {
            _Supply_Amt += Number(Grid_Detail.GetGridData(i,W_Amt));
            _VAT_Amt += Number(Grid_Detail.GetGridData(i,VAT_Amt));
        }
        txtSupplyAmt_B.text=_Supply_Amt;
        txtVAT.text = _VAT_Amt;
        flag = 'update';
        dso_update.StatusUpdate();
		dso_update.Call();
}
//===================================================================================================================================
function OnConfirm()
{
	if(confirm("Are you sure you want to confirm?"))
	{
		Grid_Mst.SetGridText(Grid_Mst.row,10,'confirmed');
	    dso_grid.Call();
    }
}
//===================================================================================================================================
function OnCancel()
{
	if(confirm("Are you sure you want to cancel ?"))
	 {
		Grid_Mst.SetGridText(Grid_Mst.row,10,'cancel');
	    dso_grid.Call();
     }
}
//===================================================================================================================================
function CheckNumeric()
{
   var key = window.event.keyCode;
   if ( key > 47 && key < 58 )
      return; // if so, do nothing
   else
      window.event.returnValue = null; // otherwise,    
}
//===================================================================================================================================
function MerGrid()
{
        if (Grid_Detail.rows < 2)
		{
			Grid_Detail.AddRow();
		}
		var fg=Grid_Detail.GetGridControl();
		fg.FixedRows = 2
		fg.MergeCells = 5

		fg.MergeCol(WkngItemNo) = true
		fg.Cell(0, 0, WkngItemNo, 1, WkngItemNo) = "No."
		
		fg.MergeCol(DetailsLevelCode) = true
		fg.Cell(0, 0, DetailsLevelCode, 1, DetailsLevelCode) = "Details Level Code"
		
		fg.MergeCol(DetailsLevelSeqNo) = true
		fg.Cell(0, 0, DetailsLevelSeqNo, 1, DetailsLevelSeqNo) = "Details Level Seq. No."
		
		fg.MergeCol(Name) = true
		fg.Cell(0, 0, Name, 1, Name) = "Name"
		
		fg.MergeCol(Standard) = true
		fg.Cell(0, 0, Standard, 1, Standard) = "Specification"
		
		fg.MergeCol(Weight) = true
		fg.Cell(0, 0, Weight, 1, Weight) = "Weight"
		
		fg.MergeCol(Unit) = true
		fg.Cell(0, 0, Unit, 1, Unit) = "Unit"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, C_Qty, 0, C_Amt) = "Contract" 
		fg.Cell(0, 1, C_Qty, 1 ) 	= "Q'ty"
		fg.Cell(0, 1, C_RawMtrlCostUP, 1 ) 	= "Raw Mtrl Cost U/P"
		fg.Cell(0, 1, C_RawMtrlCostAmt, 1 ) 	= "Raw Mtrl Cost Amt"
		fg.Cell(0, 1, C_LaborCostUP, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, C_LaborCostAmt, 1) 	= "Labor Cost Amt"
		fg.Cell(0, 1, C_ExpUP, 1) 	= "Exp U/P"
		fg.Cell(0, 1, C_ExpAmt, 1) 	= "Exp Amt"
		fg.Cell(0, 1, C_UP, 1 ) 	= "U/P"
		fg.Cell(0, 1, C_Amt, 1) 	= "Amt"
		
		fg.Cell(0, 0, W_Qty, 0, W_Amt) = "Working" 
		fg.Cell(0, 1, W_Qty, 1 ) 	= "Q'ty"
		fg.Cell(0, 1, W_RawMtrlCostUP, 1 ) 	= "Raw Mtrl Cost U/P"
		fg.Cell(0, 1, W_RawMtrlCostAmt, 1 ) 	= "Raw Mtrl Cost Amt"
		fg.Cell(0, 1, W_LaborCostUP, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, W_LaborCostAmt, 1) 	= "Labor Cost Amt"
		fg.Cell(0, 1, W_ExpUP, 1) 	= "Exp U/P"
		fg.Cell(0, 1, W_ExpAmt, 1) 	= "Exp Amt"
		fg.Cell(0, 1, W_UP, 1 ) 	= "U/P"
		fg.Cell(0, 1, W_Amt, 1) 	= "Amt"
		
		fg.Cell(0, 0, B_Qty, 0, B_Amt) = "Before Change" 
		fg.Cell(0, 1, B_Qty, 1 ) 	= "Q'ty"
		fg.Cell(0, 1, B_RawMtrlCostUP, 1 ) 	= "Raw Mtrl Cost U/P"
		fg.Cell(0, 1, B_RawMtrlCostAmt, 1 ) 	= "Raw Mtrl Cost Amt"
		fg.Cell(0, 1, B_LaborCostUP, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, B_LaborCostAmt, 1) 	= "Labor Cost Amt"
		fg.Cell(0, 1, B_ExpUP, 1) 	= "Exp U/P"
		fg.Cell(0, 1, B_ExpAmt, 1) 	= "Exp Amt"
		fg.Cell(0, 1, B_UP, 1 ) 	= "U/P"
		fg.Cell(0, 1, B_Amt, 1) 	= "Amt"

		fg.Cell(0, 0, A_Qty, 0, A_Amt) = "After Change" 
		fg.Cell(0, 1, A_Qty, 1 ) 	= "Q'ty"
		fg.Cell(0, 1, A_RawMtrlCostUP, 1 ) 	= "Raw Mtrl Cost U/P"
		fg.Cell(0, 1, A_RawMtrlCostAmt, 1 ) 	= "Raw Mtrl Cost Amt"
		fg.Cell(0, 1, A_LaborCostUP, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, A_LaborCostAmt, 1) 	= "Labor Cost Amt"
		fg.Cell(0, 1, A_ExpUP, 1) 	= "Exp U/P"
		fg.Cell(0, 1, A_ExpAmt, 1) 	= "Exp Amt"
		fg.Cell(0, 1, A_UP, 1 ) 	= "U/P"
		fg.Cell(0, 1, A_Amt, 1) 	= "Amt"

		fg.Cell(0, 0, ID_Qty, 0, ID_Amt) = "Incr./Decr." 
		fg.Cell(0, 1, ID_Qty, 1 ) 	= "Q'ty"
		fg.Cell(0, 1, ID_RawMtrlCostUP, 1 ) 	= "Raw Mtrl Cost U/P"
		fg.Cell(0, 1, ID_RawMtrlCostAmt, 1 ) 	= "Raw Mtrl Cost Amt"
		fg.Cell(0, 1, ID_LaborCostUP, 1) 	= "Labor Cost U/P"
		fg.Cell(0, 1, ID_LaborCostAmt, 1) 	= "Labor Cost Amt"
		fg.Cell(0, 1, ID_ExpUP, 1) 	= "Exp U/P"
		fg.Cell(0, 1, ID_ExpAmt, 1) 	= "Exp Amt"
		fg.Cell(0, 1, ID_UP, 1 ) 	= "U/P"
		fg.Cell(0, 1, ID_Amt, 1) 	= "Amt"
		fg.MergeCol(VAT_Rate) = true
		fg.Cell(0, 0, VAT_Rate, 1, VAT_Rate) = "VAT Rate"
		fg.MergeCol(VAT_Amt) = true
		fg.Cell(0, 0, VAT_Amt, 1, VAT_Amt) = "VAT Amount"
		fg.MergeCol(Total) = true
		fg.Cell(0, 0, Total, 1, Total) = "Total"
		/**/
}
//===================================================================================================================================
function OnIncrease()
{
			if(txtProject_Pk.text != '' && Grid_Mst.rows > 1 && Grid_Mst.GetGridData(Grid_Mst.row, 2) == 'Yes')
			{
					Grid_Mst.AddRow();

					Grid_Mst.SetGridText(Grid_Mst.rows -1, 0, Grid_Mst.GetGridData(Grid_Mst.rows -2, 0));//pk

					Grid_Mst.SetGridText(Grid_Mst.rows -1, 1, 1 + Number(Grid_Mst.GetGridData(Grid_Mst.rows -2, 1)));//S/No
					Grid_Mst.SetGridText(Grid_Mst.rows -1, 2, 'No');//Confirm (Y/N)
					Grid_Mst.SetGridText(Grid_Mst.rows -1, 3, Grid_Mst.GetGridData(Grid_Mst.rows -2, 3));//Change Date
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 4, Grid_Mst.GetGridData(Grid_Mst.rows -2, 4));//Contract Period
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 5, Grid_Mst.GetGridData(Grid_Mst.rows -2, 5));//Currency
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 6, Grid_Mst.GetGridData(Grid_Mst.rows -2, 6));//Supply Price
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 7, Grid_Mst.GetGridData(Grid_Mst.rows -2, 7));//Incr./Decr. Amt
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 8, Grid_Mst.GetGridData(Grid_Mst.rows -2, 8));//Incr. Days
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 9, Grid_Mst.GetGridData(Grid_Mst.rows -2, 9));//Change Reason
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 12, txtProject_Pk.text);
                    Grid_Mst.SetGridText(Grid_Mst.rows -1, 13, txtTECPS_ORDERINGCONTTYPE_PK.text);
                    
                    dso_Inrease.Call();
			}
			else
			{
					alert('Please select Project !!' + '\n' + 'Please check data !!' + '\n' + 'Please  confirm data first!!');	
			}
}
//===================================================================================================================================
function OnModification()
{
    
}
//===================================================================================================================================
function OnModification_Request()
{
    if(Grid_Mst.row > 0 && Grid_Mst.GetGridData(Grid_Mst.row, 1)!= '0')
    { 
            var path = System.RootURL + "/reports/61/05/rpt_61050030_Request.aspx?Project_pk=" + txtProject_Pk.text + '&tecps_VendorBasc_pk=' + Grid_Mst.GetGridData(Grid_Mst.row, 14) + '&TECPS_SUBSTRP12000_PK=' + txtTECPS_SUBSTRP12000_pk.text;
            System.OpenTargetPage(path);  
    }
    else
    {
        alert('Please select a row and version large than 0 !!');
    }   
}
//-------------------------------------------------------------------------------
function format_number(dec, fix) 
{
	fixValue = parseFloat(Math.pow(10,fix));
	rtn_value = parseInt(Math.round(dec * fixValue)) / fixValue;	
	return rtn_value ;
}
//===================================================================================================================================
function OnCalc()
{
        //=================Contract======================
        var Ctr_Qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, C_Qty));
        var Ctr_MtrlUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, C_RawMtrlCostUP));
       var Ctr_LaborUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, C_LaborCostUP));
       var Ctr_ExpUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, C_ExpUP));
       
       var Ctr_MtrlAmt = 0;
       var Ctr_LaborAmt = 0;
       var Ctr_ExpAmt = 0;
       var Ctr_UP = 0;
       var Ctr_Amt = 0;
       
       Ctr_MtrlAmt = format_number(Ctr_Qty * Ctr_MtrlUP,2);
       Ctr_LaborAmt =format_number(Ctr_Qty * Ctr_LaborUP,2);
       Ctr_ExpAmt = format_number(Ctr_Qty * Ctr_ExpUP,2);
       Ctr_UP = Ctr_MtrlUP + Ctr_LaborUP + Ctr_ExpUP;
       Ctr_Amt = Ctr_MtrlAmt + Ctr_LaborAmt + Ctr_ExpAmt;
       
       Grid_Detail.SetGridText(Grid_Detail.row, C_RawMtrlCostAmt, Ctr_MtrlAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, C_LaborCostAmt, Ctr_LaborAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, C_ExpAmt, Ctr_ExpAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, C_UP, Ctr_UP);
       Grid_Detail.SetGridText(Grid_Detail.row, C_Amt, Ctr_Amt);
       //=================Working======================
       var Wkg_Qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, W_Qty));
       var Wkg_RawMtrlUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, W_RawMtrlCostUP));
       var Wkg_LaborUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, W_LaborCostUP));
       var Wkg_ExpUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, W_ExpUP));
       
       var Wkg_MtrlAmt = 0;
       var Wkg_LaborAmt = 0;
       var Wkg_ExpAmt = 0;
       var Wkg_UP = 0;
       var Wkg_Amt = 0;
       
       Wkg_MtrlAmt = format_number(Wkg_Qty * Wkg_RawMtrlUP,2);
       Wkg_LaborAmt = format_number(Wkg_Qty * Wkg_LaborUP,2);
       Wkg_ExpAmt = format_number(Wkg_Qty * Wkg_ExpUP,2);
       Wkg_UP = Wkg_RawMtrlUP + Wkg_LaborUP + Wkg_ExpUP;
       Wkg_Amt = Wkg_MtrlAmt + Wkg_LaborAmt + Wkg_ExpAmt;
       
       Grid_Detail.SetGridText(Grid_Detail.row, W_RawMtrlCostAmt, Wkg_MtrlAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, W_LaborCostAmt, Wkg_LaborAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, W_ExpAmt, Wkg_ExpAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, W_UP, Wkg_UP);
       Grid_Detail.SetGridText(Grid_Detail.row, W_Amt, Wkg_Amt);
       //=================Before======================
       var Bf_Qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, B_Qty));
       var Bf_MtrlCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, B_RawMtrlCostUP));
       var Bf_LaborCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, B_LaborCostUP));
       var Bf_ExpUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, B_ExpUP));
       
       var Bf_MtrlAmt = 0;
       var Bf_LaborAmt = 0;
       var Bf_ExpAmt = 0;
       var Bf_UP = 0;
       var Bf_Amt = 0;
       
       Bf_MtrlAmt =format_number(Bf_Qty * Bf_MtrlCostUP,2);
       Bf_LaborAmt = format_number(Bf_Qty * Bf_LaborCostUP,2);
       Bf_ExpAmt = format_number(Bf_Qty * Bf_ExpUP,2);
       Bf_UP = Bf_MtrlCostUP + Bf_LaborCostUP + Bf_ExpUP;
       Bf_Amt = Bf_MtrlAmt + Bf_LaborAmt + Bf_ExpAmt;
       
       Grid_Detail.SetGridText(Grid_Detail.row, B_RawMtrlCostAmt, Bf_MtrlAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, B_LaborCostAmt, Bf_LaborAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, B_ExpAmt, Bf_ExpAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, B_UP, Bf_UP);
       Grid_Detail.SetGridText(Grid_Detail.row, B_Amt, Bf_Amt);
       //=================After======================
       var Af_Qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, A_Qty));
       var Af_MtrlCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, A_RawMtrlCostUP));
       var Af_LaborCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, A_LaborCostUP));
       var Af_ExpUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, A_ExpUP));
       
       var Af_MtrlCostAmt = 0;
       var Af_LaborCostAmt = 0;
       var Af_ExpAmt = 0;
       var Af_UP = 0;
       var Af_Amt = 0;
       
       Af_MtrlCostAmt = Math.round(Af_Qty * Af_MtrlCostUP);
       Af_LaborCostAmt = Math.round(Af_Qty * Af_LaborCostUP);
       Af_ExpAmt = Math.round(Af_Qty * Af_ExpUP);
       Af_UP = Af_MtrlCostUP + Af_LaborCostUP + Af_ExpUP;
       Af_Amt = Af_MtrlCostAmt + Af_LaborCostAmt + Af_ExpAmt;
       
       Grid_Detail.SetGridText(Grid_Detail.row, A_RawMtrlCostAmt, Af_MtrlCostAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, A_LaborCostAmt, Af_LaborCostAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, A_ExpAmt, Af_ExpAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, A_UP, Af_UP);
       Grid_Detail.SetGridText(Grid_Detail.row, A_Amt, Af_Amt);
        //=================Incr/Decr======================
       var IrDr_Qty = Number(Grid_Detail.GetGridData(Grid_Detail.row, ID_Qty));
       var IrDr_MtrlCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, ID_RawMtrlCostUP));  
       var IrDr_LaborCostUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, ID_LaborCostUP));  
       var IrDr_ExpUP = Number(Grid_Detail.GetGridData(Grid_Detail.row, ID_ExpUP));  
       
       var IrDr_MtrlAmt  = 0;
       var IrDr_LaborAmt  = 0;
       var IrDr_ExpAmt  = 0;
       var IrDr_UP  = 0;
       var IrDr_Amt  = 0;
       
       IrDr_MtrlAmt = Math.round(IrDr_Qty * IrDr_MtrlCostUP);
       IrDr_LaborAmt = Math.round(IrDr_Qty * IrDr_LaborCostUP);
       IrDr_ExpAmt = Math.round(IrDr_Qty * IrDr_ExpUP);
       IrDr_UP = IrDr_MtrlCostUP + IrDr_LaborCostUP + IrDr_ExpUP;
       IrDr_Amt = IrDr_MtrlAmt + IrDr_LaborAmt + IrDr_ExpAmt;
       
       Grid_Detail.SetGridText(Grid_Detail.row, ID_RawMtrlCostAmt, IrDr_MtrlAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, ID_LaborCostAmt, IrDr_LaborAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, ID_ExpAmt, IrDr_ExpAmt);
       Grid_Detail.SetGridText(Grid_Detail.row, ID_UP, IrDr_UP);
       Grid_Detail.SetGridText(Grid_Detail.row, ID_Amt, IrDr_Amt);
       //=================VAT======================
       var _VAT_Rate = Number(Grid_Detail.GetGridData(Grid_Detail.row, VAT_Rate));
       var _VAT_Amt = 0;
       _VAT_Amt = Math.round(Wkg_Amt * _VAT_Rate / 100);
       Grid_Detail.SetGridText(Grid_Detail.row, VAT_Amt, _VAT_Amt);

        //=================Total======================
        var _Total = 0;
        _Total = Math.round(Wkg_Amt + _VAT_Amt);
        Grid_Detail.SetGridText(Grid_Detail.row, Total, _Total);
        //CheckTotal();
        //=================Check Total======================
//        var i = 0;
//        var _SumTotal = 0;
//        for(i= 2; i < Grid_Detail.rows;i++)
//        {
//                _SumTotal +=  Number(Grid_Detail.GetGridData(i, Total));
//        }
//        var _Balance  = Number(txtBalance.text);
//        if(_SumTotal > _Balance)
//        {
//                alert('Sum of  total cannot be large than balance !!');
//        }
//        else
//        {
//                return;
//        }
}
function CheckTotal()
{
        var i = 0;
        var _SumTotal = 0;
        for(i= 2; i < Grid_Detail.rows;i++)
        {
                _SumTotal +=  Number(Grid_Detail.GetGridData(i, Total));
        }
        var _Balance  = Number(txtBalance.text);
        if(_SumTotal > _Balance)
        {
                alert('Sum of  total cannot be large than balance !!');
        }
        else
        {
                return false;
        }
}
//===================================================================================================================================
function OnSaveDetail()
{
        if(!CheckTotal())
        {
            dso_grdDetail.Call();
        }
}
//===================================================================================================================================
function OnNewDetail()
{
        if(txtPk.text != '')
        {
				var path = System.RootURL + '/form/61/05/61050020_PopUpGetItem.aspx?project_pk=' + txtProject_Pk.text + '&project_cd=' + txtProject_Cd.text + '&project_nm=' + escape(txtProject_Nm.text) ;
				var aValue = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
				
				var object;   
				 if(aValue != null)
				 {
					
					for (i = 0; i < aValue.length; i++ )
					{
						object = aValue[i];
						Grid_Detail.AddRow();
						Grid_Detail.SetGridText(Grid_Detail.rows-1, tecps_1200_pk, txtTECPS_SUBSTRP12000_pk.text);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, vendorbasc_pk, txtPk.text);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, project_pk, txtProject_Pk.text);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, DetailsLevelCode, object[4]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Name, object[5]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Item_pk, object[3]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Level_pk, object[0]);
					}
				}
        }
        else
        {
                alert('Please select master !!');
        }
		
}
//----------------------------------------------------------------------------------------------------------------------------------
function OnGridCellDoubleClick(idx)
{
    if(event.col==1 || event.col==3)
    {
	    var path = System.RootURL + '/form/61/05/61050020_PopUpGetItem.aspx?project_pk=' + txtProject_Pk.text + '&project_cd=' + txtProject_Cd.text + '&project_nm=' + escape(txtProject_Nm.text) ;
	    var aValue = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
	
	    var object;
	     if(aValue != null)
	     {
					
					    for (i = 0; i < aValue.length; i++ )
					    {
						    object = aValue[i];
	                        Grid_Detail.SetGridText(Grid_Detail.row, DetailsLevelCode, object[4]);
			                Grid_Detail.SetGridText(Grid_Detail.row, Name, object[5]);
			                Grid_Detail.SetGridText(Grid_Detail.row, Item_pk, object[3]);
			                Grid_Detail.SetGridText(Grid_Detail.row, Level_pk, object[0]);
			            }
		    }
    }
}
//===================================================================================================================================
function Calc_ContractAmt()
{
            var p_SupplyAmt = Number(txtSupplyAmt_B.text); 
            var p_VAT = Number(txtVAT.text);
            var p_ContractAmt = 0;
            p_ContractAmt = Math.round(p_SupplyAmt + p_VAT);
            txtCont_Amt.SetDataText(p_ContractAmt);
}
//===================================================================================================================================
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
//===================================================================================================================================
function OnPrint()
{
    if(Grid_Mst.row > 0 && Grid_Mst.GetGridData(Grid_Mst.row, 1)!= '0')
    { 
            var path = System.RootURL + "/reports/61/05/rpt_61050030_BOQ.aspx?Pk=" + txtPk.text + '&Project=' + txtProject_Nm.text + '&Nature_Work=' + txtOutsideOrderWork.text + '&TECPS_PROJECTSUMM_PK=' + txtProject_Pk.text + '&TECPS_SUBSTRP12000_PK='+ txtTECPS_SUBSTRP12000_pk.text + '&Unit=' + Grid_Mst.GetGridData(Grid_Mst.row,5);
            System.OpenTargetPage(path);  
    }
    else
    {
        alert('Please select a row and version large than 0 !!');
    }   
}
//===================================================================================================================================
function OnDelete()
{
    if(Grid_Mst.GetGridData(Grid_Mst.row, 2)=='No')
    {
        if(confirm('Are you sure you wanna delete?'))
        {
            Grid_Mst.DeleteRow(); 
            dso_grid.Call();
        }   
    }
    else
    {
        alert('Can not delete. The Data is confirmed !!');
    }
}
</script>
<body>
<gw:data id="dso_search" onreceive="OnDataReceive(this)">
  <xml>
    <dso type="process"  procedure="pm_pro_61050030"  >
      <input>
		  <input bind="txtProject_Pk"/>
		  <input bind="lstContCode"/>
     </input>
	 <output>
     	  <output bind="txtTECPS_SUBSTRP12000_pk"/>
		  <output bind="txtCont_Nm"/>
          <output bind="txtOutsrcCo_Cd"/>
          <output bind="txtOutsrcCo_Nm"/>
          <output bind="txtDlvr_Terms"/>
          <output bind="txtCont_Cd"/>
          <output bind="txtOutsideOrderWork"/>
		  <output bind="txtTECPS_ORDERINGCONTTYPE_PK"/>
	  </output>
    </dso>
  </xml>
</gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
<gw:data id="dso_ContCode" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="pm_sel_61050030_contcode" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstContCode" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
       <!------------------------------------------------------------------------------------------------------------------>
   <gw:data id="dso_grid" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso id="1" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14"     function="pm_sel_61050030_1"   procedure="pm_upd_61050030_1"   > 
				<input bind="Grid_Mst">                    
					<input bind="lstContCode" /> 
				</input> 
				<output bind="Grid_Mst" /> 
			</dso> 
		</xml> 
	</gw:data>    
    <!------------------------------------------------------------------------------------------------------------------>
<gw:data id="dso_update" onreceive="OnDataReceive(this)">
  <xml>
    <dso type="control"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26"  function="pm_sel_61050030_contr"  procedure="pm_upd_61050030_contr"   >
      <input>
          <inout bind="txtPk"/>
          <inout bind="chkPer"/>
          <inout bind="chkSupply_Amt"/>
          <inout bind="chkPay_Terms"/>
          <inout bind="chkGuar_Terms"/>
          
          <inout bind="dtChange_Date"/>
          <inout bind="lstTax_Type"/>
          <inout bind="dtFrom"/>
          <inout bind="dtTo"/>
          <inout bind="txtIncr_Date"/>
          
          <inout bind="txtRetentionRate"/>
          <inout bind="txtCurrCode"/>
          <inout bind="txtBCWS_A"/>
          <inout bind="txtSupplyAmt_B"/>
          <inout bind="txtVAT"/>
          
          <inout bind="txtCont_Amt"/>
          <inout bind="txtIncrDecr_Amt"/>
          <inout bind="txtAdvPay"/>
          <inout bind="txtPP"/>
          <inout bind="txtBall"/>
          
          <inout bind="txtCash"/>
          <inout bind="txtNote"/>
          <inout bind="txtAdvPayReturnGuar"/>
          <inout bind="txtContBond"/>
          <inout bind="txtDGuar"/>
          
          <inout bind="txtDGuarPer"/>
          <inout bind="txtTECPS_SUBSTRP12000_pk"/>
          
      </input>
    </dso>
  </xml>
</gw:data> 
 <!------------------------------------------------------------------------------------------------------------------>
 <gw:data id="dso_grdDetail" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid"   function="pm_sel_61050030_dtl"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61"   procedure="pm_upd_61050030_dtl"  >
          <input bind="Grid_Detail" >
          <input bind="txtTECPS_SUBSTRP12000_pk" />
          <input bind="txtPk" />
          <input bind="txtserial_no" />
          </input>
          <output bind="Grid_Detail" />
        </dso>
      </xml>
    </gw:data>  
 <!------------------------------------------------------------------------------------------------------------------>    
<gw:data id="dso_BdgtAmt" onreceive="OnDataReceive(this)">
  <xml>
    <dso type="process"  procedure="pm_pro_61050030_1"  >
      <input>
		  <input bind="txtProject_Pk"/>
		  <input bind="txtTECPS_ORDERINGCONTTYPE_PK"/>
     </input>
	 <output>
		  <output bind="txtBudgetAmt"/>
		  <output bind="txtOtherSubcont"/>
		  <output bind="txtBalance"/>
	  </output>
    </dso>
  </xml>
</gw:data>   
 <!------------------------------------------------------------------------------------------------------------------>
<gw:data id="dso_Inrease" onreceive="OnDataReceive(this)">
  <xml>
    <dso type="process"  procedure="pm_pro_61050030_inrease"  >
      <input>
		  <input bind="txtProject_Pk"/>
		  <input bind="txtTECPS_SUBSTRP12000_pk"/>
          <input bind="txtPk"/>
          <input bind="dtChange_Date"/>
     </input>
     <output>
		  <output bind="txtRtn"/>
	  </output>
    </dso>
  </xml>
</gw:data>   
 <!------------------------------------------------------------------------------------------------------------------>
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: ">
        <tr style="height: " valign=top>
            <td width="100%">
                <fieldset style="padding:0">
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                                <td align="right" width="10%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('prj')">Project&nbsp;</a></td>
                                <td width="90%">
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td width="25%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                                <td width="45%"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td>
                                                <td width=""><gw:textbox id="txtProject_Pk" readonly="true" styles='width:100%;display:none' /></td>
                                                <td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
                                                                        
                                                <td style="display:none" align="right" width=""><gw:icon id="ibtnCancel" img="in" text="Modification Agreement" onclick="OnModification()"  style="width: 100%" /></td>
                                                <td width="2%"></td>
                                                
                                                                        
                                                <td><gw:button id="ibtnUpdte111" img="search" alt="Search" onclick="OnSearch()" /></td>
                                                <td><gw:button id="ibtnUpdte111" img="Increase" alt="Increase" onclick="OnIncrease()" /></td>
                                                <td><gw:button id="btnConfirm" img="confirm" alt="Confirm" onclick="OnConfirm()" /></td>
                                                <td><gw:button id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel()" /></td>
                                                <td ><gw:button id="btnSave" img="save" alt="Save" onclick="OnSave()" /></td>
                                                <td><gw:button id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" /></td>
                                                <td style="display:none"><gw:button id="ibtUpdate3" img="printer" alt="Print" onclick="OnPrint()" /></td>
                                                <td><gw:button id="btnExcel1" img="excel" text="Print" alt="Modification Request" onclick="OnModification_Request()" /></td>    
                                                <td><gw:button id="btnExcel2" img="excel" text="Print" alt="Print BOQ" onclick="OnPrint()" /></td>    
                                            </tr>
                                        </table>
                                </td>
                        </tr>
                        <tr>
                                <td align="right" width=""><a title="Contract Code" style="color:#333">Cont. Code&nbsp;</a></td>
                                <td width=""><gw:list id="lstContCode" onchange="OnSearch()" styles='width:50%' /></td>
                        </tr>
                    </table>
            </fieldset>	
            </td>
        </tr>
		 <tr height="" valign=top>
        		<td>
                		<table border="1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse">
                        			<tr height="50%">
                                    			<td width="10%" align="right" style="background:#C5EFF1"><a title="Contract Name" style="color:#333">Cont. Name&nbsp;</a></td>
                                                <td width="90%" align="left" colspan="3"><gw:textbox id="txtCont_Nm"  styles='width:100%' /></td>
                                    </tr>
                                    <tr height="50%">
                                    			<td width="10%" align="right" style="background:#C5EFF1"><a title="Outsource Company" style="color:#333">Outsrc. Co.&nbsp;</a></td>
                                                <td width="40%" align="left">
                                                			<table width="100%" cellpadding="0" cellspacing="0">
                                                            				<tr>
                                                                            				<td width="40%"><gw:textbox id="txtOutsrcCo_Cd"  styles='width:100%' /></td>
                                                                                            <td width="60%"><gw:textbox id="txtOutsrcCo_Nm"  styles='width:100%' /></td>
                                                                            </tr>
                                                            </table>
                                                </td>
                                                <td width="15%" align="right" style="background:#C5EFF1"><a title="Delivery Terms" style="color:#333">Dlvr. Terms&nbsp;</a></td>
                                                <td width="35%" align="left"><gw:textbox id="txtDlvr_Terms"  styles='width:100%' /></td>
                                    </tr>
                                    <tr height="50%" style="background:#C5EFF1">
                                    			<td width="10%" align="right" style="background:#C5EFF1">Outside Order Work&nbsp;</td>
                                                <td width="40%" colspan="3">
                                                	<table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td width="30%"><gw:textbox id="txtOutsideOrderWork"  styles='width:100%' /></td>
                                                            <td width="11%" align="right" ><a title="Budget Amount" style="color:#333">Budget Amt&nbsp;</a></td>
                                                            <td width="13%"><gw:textbox id="txtBudgetAmt" type="number" format="###,###.##R" styles='width:100%' /></td>
                                                            <td width="12%" align="right" ><a title="Other Subcontract" style="color:#333">Other Subcont.&nbsp;</a></td>
                                                            <td width="13%"><gw:textbox id="txtOtherSubcont" type="number" format="###,###.##R" styles='width:100%' /></td>
                                                            <td width="8%" align="right" >Balance&nbsp;</td>
                                                            <td width="13%"><gw:textbox id="txtBalance" type="number" format="###,###.##R" styles='width:100%' /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                    </tr>
                        </table>
                </td>
        </tr>
        <tr style="height: ">
        <!--header="_pk|S/No.|Confirm (Y/N)|Change Date|Currency|Cont. Start Date|Cont. Expiry Date|Change Cont. Amt|Cont. Incr./Decr. Amt|Cont. Incr./Decr. Days|Status|project_pk"-->
            <td >
                	<gw:grid id="Grid_Mst" 
                	header="_TECPS_SUBSTRP12000_PK|S/No.|Confirm (Y/N)|Change Date|Contract Period|Currency|Supply Price|Incr./Decr. Amt|Incr. Days|Change Reason|_status|_Contract Amt|_TECPS_PROJECTSUMM_PK|_TECPS_ORDERINGCONTTYPE_PK|_PK"
                    format="0|0|0|0|0|0|1|1|0|0|0|0|0|0|0" 
                    aligns="0|1|1|1|0|1|3|3|3|0|0|0|0|0|0"
                    defaults="||||||||||||||" 
                   editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    widths="0|800|1500|1500|2000|1000|2000|2000|1000|2000|0|0|0|0|0"
                    styles="width:100%; height:200" 
                    sorting="T" 
                    onafteredit=""
                    oncellclick="OnClick()"
					
                    />
            </td>
        </tr>
		  <tr height=""  valign="top" >
        		<td>
                    <fieldset style="border:0;padding:0;background-color:White" >
                       <legend style=""><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow()" /></legend>
                		<table id="updating_info"  border="1" style="width:100%;background:#C5EFF1" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse">
                        	<tr height="">
                                    	<td width="13%" align="right" style="background:#C5EFF1"><a title="Change Contents" style="color:#333">Chg Contents&nbsp;</a></td>
                                        <td width="47%" align="right" >
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                                	<td width="4%"><gw:checkbox id="chkPer" defaultvalue="Y|N" value="N" styles="width:100%" onclick="OnVisible('Per')" /></td>
                                                                    <td align="left" width="14%">Period</td>
                                                                    <td width="4%"><gw:checkbox id="chkSupply_Amt" defaultvalue="Y|N" value="N" styles="width:100%" onclick="OnVisible('Supply')" /></td>
                                                                    <td align="left" width="24%"><a title="Supply Amount" style="color:#333">Supply Amt</a></td>
                                                                    <td width="4%"><gw:checkbox id="chkPay_Terms" defaultvalue="Y|N" value="N" styles="width:100%" onclick="OnVisible('Pay')" /></td>
                                                                    <td align="left" width="24%"><a title="Term of Payment " style="color:#333">Pay. Terms</a></td>
                                                                    <td width="4%"><gw:checkbox id="chkGuar_Terms" defaultvalue="Y|N" value="N" styles="width:100%" onclick="OnVisible('Guar')" /></td>
                                                                    <td align="left" width="22%"><a title="Guarantee Term" style="color:#333">Guar. Terms</a></td>
                                                        </tr>
                                                </table>
                                        </td>
                                        <td align="right" width="10%" style="background:#C5EFF1"><a title="Change Date" style="color:#333">Chg Date&nbsp;</a></td>
                                        <td  width="5%"><gw:datebox id="dtChange_Date" lang="1" /></td>
                                        <td align="right" width="10%" style="background:#C5EFF1">Tax Type&nbsp;</td>
                                        <td width="15%"><gw:list id="lstTax_Type"  styles='width:100%' /></td>
                            </tr>
                            <tr height="">
                                    	<td align="right" width="" style="background:#C5EFF1"><a title="Contract Period" style="color:#333">Cont. Per.&nbsp;</a></td>
                                        <td width="" align="right" >
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                                	<td ><gw:datebox id="dtFrom" lang="1" /></td>
                                                                    <td >~</td>
                                                                    <td ><gw:datebox id="dtTo" lang="1" /></td>
                                                                    <td width="100%"></td>
                                                        </tr>
                                                </table>
                                        </td>
										<td align="right" width="" style="background:#C5EFF1"><a title="Increase Date" style="color:#333">Incr. Date&nbsp;</a></td>
										<td width=""  style="background:#C5EFF1"><gw:textbox id="txtIncr_Date"  styles='width:70%;text-align:right' />&nbsp;Day</td>
										<td align="right" width="" style="background:#C5EFF1">Retention Rate&nbsp;</td>
										<td width="" ><gw:textbox id="txtRetentionRate"  styles='width:100%' /></td>
                            </tr>
							<tr height="">
										<td rowspan="1" align="right" width="" style="background:#C5EFF1"><a title="Contract Amount" style="color:#333">Cont. Amt&nbsp;</a></td>
										<td colspan="5">	
												<table style="height:;width:100%" cellpadding="0" cellspacing="0"  border="1" style="border-collapse: collapse">
                                                        <tr height="20">
                                                            <td width="10%" align="center"  style="background:#C5EFF1"><a title="Currency Code" style="color:#333">Curr. Code</a></td>
															<td align="center" width="18%" style="background:#C5EFF1"><a title="Budgeted Cost of Work Scheduled (A)" style="color:#333">BCWS (A)</a></td>
															<td align="center" width="18%" style="background:#C5EFF1"><a title="Supply Amount (B)" style="color:#333">Supply Amt (B)</a></td>
															<td  align="center" width="18%" style="background:#C5EFF1"><a title="Value Added Tax" style="color:#333">VAT</a></td>
															<td align="center" width="18%" style="background:#C5EFF1"><a title="Contract Amount" style="color:#333">Cont. Amt</a></td>
															<td align="center" width="18%" style="background:#C5EFF1"><a title="Increase/Decrease Amount" style="color:#333">Incr./Decr. Amt</a></td>
                                                        </tr>
														<tr height="">
															<td width="10%" align="center"  ><gw:textbox id="txtCurrCode"  styles='width:100%;text-align:center' /></td>
															<td align="center" width="18%" ><gw:textbox id="txtBCWS_A"  type="number" format="###,###.##R" styles='width:100%' /></td>
															<td align="center" width="18%"><gw:textbox id="txtSupplyAmt_B"  type="number" format="###,###.##R" onenterkey="Calc_ContractAmt()" onBlur="Calc_ContractAmt()"  styles='width:100%' /></td>
															<td id="vat" align="center" width="18%" ><gw:textbox id="txtVAT"  type="number"  format="###,###.##" onenterkey="Calc_ContractAmt()" onBlur="Calc_ContractAmt()"  styles='width:100%;' /></td>
															<td align="center" width="18%" ><gw:textbox id="txtCont_Amt" type="number" format="###,###.##R" onenterkey="Calc_ContractAmt()" onBlur="Calc_ContractAmt()"  styles='width:100%' /></td>
															<td align="center" width="18%" ><gw:textbox id="txtIncrDecr_Amt" type="number"  format="###,###.##R"  styles='width:100%' /></td>
														</tr>
                                                </table>
										</td>
							</tr>
							<tr height="">
										<td  align="right" width="" style="background:#C5EFF1"><a title="Payment Conditions" style="color:#333">Pay. Cond.&nbsp;</a></td>
										<td colspan="5">	
												<table width="100%" cellpadding="0" cellspacing="0"  style="background:">
                                                        <tr >
                                                            <td width="5%" align="right" style="background:#C5EFF1" ><a title="Advanced" style="color:#333">Adv.</a></td>
															<td id="a" width="10%" align="left"  ><gw:textbox id="txtAdvPay" onkeypress="" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td  width="10%" align="right" style="background:#C5EFF1" ><a title="Progress" style="color:#333">Prog.</a></td>
															<td id="b" width="10%" align="left"  ><gw:textbox id="txtPP"  onkeypress="" type="number" format="###,###.##R"  styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="15%" align="right" style="background:#C5EFF1" ><a title="Withholding Tax" style="color:#333">Withholding Tax</a></td>
															<td id="c" width="10%" align="left"  ><gw:textbox id="txtBall"  onkeypress="" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="10%" align="right" style="background:#C5EFF1" >Retention</td>
															<td id="d" width="10%" align="left"  ><gw:textbox id="txtCash"  onkeypress="" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="10%" align="right" style="background:#C5EFF1;display:none">Note</td>
															<td id="e" width="10%" align="left"  style="display:none"><gw:textbox id="txtNote" onkeypress="CheckNumeric()"   styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1;display:none">%</td>
														</tr>
                                                </table>
										</td>
							</tr>
							<tr height="">
										<td  align="right" width="" style="background:#C5EFF1"><a title="Guarantee Term" style="color:#333">Guar. Term&nbsp;</a></td>
										<td colspan="5">	
												<table width="100%" cellpadding="0" cellspacing="0"  >
                                                        <tr >
                                                            <td width="22%" align="right" style="background:#C5EFF1" ><a title="Advanced Payment Return Guarantee" style="color:#333">Adv. Pay. Return Guar.</a></td>
															<td id='f' width="10%" align="left"  ><gw:textbox id="txtAdvPayReturnGuar" onkeypress="CheckNumeric()"   styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="15%" align="right" style="background:#C5EFF1" ><a title="Contract Performance Bond" style="color:#333">Cont. P. Bond</a></td>
															<td id='g' width="10%" align="left"  ><gw:textbox id="txtContBond"  onkeypress="CheckNumeric()"  styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="10%" align="right" style="background:#C5EFF1"><a title="Defect Guarantee" style="color:#333">D. Guar.</a></td>
															<td id='h' width="10%" align="left"  ><gw:textbox id="txtDGuar"  onkeypress="CheckNumeric()"  styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
															<td width="13%" align="right" style="background:#C5EFF1"><a title="Defect Guarantee Period" style="color:#333">D. Guar. Per.</a></td>
															<td id='k' width="10%" align="left" colspan="2" ><gw:textbox id="txtDGuarPer"  onkeypress="CheckNumeric()"  styles='width:100%;text-align:right' /></td>
															<td align="left" style="background:#C5EFF1">%</td>
														</tr>
                                                </table>
										</td>
							</tr>
                        </table>
                    </fieldset>
                </td>
        </tr>
        <tr>
                <td>
                        <fieldset style="width:100%;padding:0">
                                <table cellpadding="0" cellspacing="0">
                                        <tr>
                                                    <td width="99%"></td>
                                                    <td ><gw:button id="ibtnew_d" img="new" alt="New" onclick="OnNewDetail()" /></td>
                                                    <td width="1%"></td>
                                                    <td style="display:none"><gw:button id="ibtnUpte1" img="save" alt="Save" onclick="OnSaveDetail()" /></td>
												    <td ><gw:button id="ibtnDel" img="delete" alt="Delete item" onclick="onDelete_d()" /></td>
                                        </tr>
                                </table>
                        </fieldset>
                </td>
        </tr>
         <tr valign="top">
                                        <td colspan="" width="100%">
                                    <gw:grid id="Grid_Detail" 
                                    header="0.Wkng Item No.|1.Details Level Code|_2.Details Level Seq. No.|3.Name|4.Standard|5.Weight|6.Unit|_7.Q'ty|_8.Raw Mtrl. Cost U/P|_9.Raw Mtrl. Cost Amt|_10.Labor Cost U/P|_11.Labor Cost Amt|_12.Exp. U/P|_13.Exp. Amt|_14.U/P|_15.Amt|16.Q'ty|17.Raw Mtrl. Cost U/P|18.Raw Mtrl. Cost Amt|19.Labor Cost U/P|20.Labor Cost Amt|21.Exp. U/P|22.Exp. Amt|23.U/P|24.Amt|_25.Q'ty|_26.Raw Mtrl. Cost U/P|_27.Raw Mtrl. Cost Amt|_28.Labor Cost U/P|_29.Labor Cost Amt|_30.Exp. U/P|_31.Exp. Amt|_32.U/P|_33.Amt|_34.Q'ty|_35.Raw Mtrl. Cost U/P|_36.Raw Mtrl. Cost Amt|_37.Labor Cost U/P|_38.Labor Cost Amt|_39.Exp. U/P|_40.Exp. Amt|_41.U/P|_42.Amt|_43.Q'ty|_44.Raw Mtrl. Cost U/P|_45.Raw Mtrl. Cost Amt|_46.Labor Cost U/P|_47.Labor Cost Amt|_48.Exp. U/P|_49.Exp. Amt|_50.U/P|_51.Amt|52.VAT Rate|53.VAT Amount|_54.pk|_55.Confirm|56.Total|_57.TECPS_SUBSTRP12000_pk|_58.vendor_basc_pk|_59.project_pk|_60.Item_pk|_61.Level_pk"
                                    format="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|1|0|0|1|0|0|0|0|0" 
                                    aligns  ="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0"
                                    defaults="|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||" 
                                   editcol ="0|1|0|1|1|1|1|0|1|0|1|0|1|0|0|0|1|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|1|0|0|0|0|0|0|0|0|0" 
                                    widths="600|1700|2000|2500|1500|1500|1500|1500|1500|2000|1500|1500|2000|1500|1500|2000|1700|2000|2500|1500|1500|1500|1500|1500|2000|1500|1500|2000|1500|1500|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1500|2000|0|0|2000|0|0|0|0|0"
                                    styles="width:100%; height:250" 
                                    sorting="T" 
                                    onafteredit="OnCalc()"
									oncelldblclick="OnGridCellDoubleClick(this)"
									/>
                  </td>
                              </tr>  
    </table>
    <gw:textbox id="txtPk"  styles='width:100%;display:none' />
    <gw:textbox id="txtCont_Cd"  styles='width:100%;display:none' />
	<gw:textbox id="txtTECPS_ORDERINGCONTTYPE_PK"  styles='width:100%;display:none' />
	<gw:textbox id="txtTECPS_SUBSTRP12000_pk"  styles='width:100%;display:none' />
    <gw:textbox id="txtserial_no"  styles='width:100%;display:none' />
        <gw:textbox id="txtRtn"  styles='width:100%;display:none' />

    
</body>

</html>
