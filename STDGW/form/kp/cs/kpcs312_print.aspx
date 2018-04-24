<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Subcontract registration</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
var G1_PK                   =0,
    G1_WORKDATE             =1,
    G1_PERFORMPERDFR        =2,
    G1_PERFORMPERDTO        =3,
    G1_CHANGEREASON         =4,
    G1_PROJECTCODE          =5,
    G1_STATUS               =6;
    
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
	gr_confirm = 55,
	Total = 56,
	tecps_1200_pk = 57,
	project_pk = 58,
	Item_pk = 59,
	Level_pk = 60
	;  
//==========================================================================    
function BodyInit()
{
      OnAddNew();
      System.Translate(document);
      var vendor = document.all("updating_info"); 
      vendor.style.display = "none";
      imgup.src = "../../../system/images/down.gif";
      BindingDataList();
     MerGrid(); 
      OnChangeTab();
      dso_get_rate_book.Call();
      Grid_Detail.GetGridControl().FrozenCols =  Standard;
}  
//==========================================================================
function BindingDataList()
{
        data = "<%=ESysLib.SetListDataSQL("SELECT a.pk,ORDERINGCONTTYPECODE || '-' || a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
        lstOutOrdWk.SetDataText(data);
        data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
        lstCurrency.SetDataText(data); 
        lstBdgtCcy.SetDataText(data); 
		txt_row.text    = 1;
		txtExRate.SetDataText('1');
	   txtExRate_B.SetDataText("1");
	   txtExRate.SetEnable(false);
		var _Company = "<%=Session("COMPANY_PK")%>"; 
		cboCompany.SetDataText(_Company);
		  data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
           arr  = data.split("|");
           txtbookccy.SetDataText(arr[1]);
           
             data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
     		Grid_Detail.SetComboFormat(Unit,data);
} 
//==========================================================================
function OnAddNew()
{
    dat_kpbp00150.StatusInsert();
}
//==========================================================================
function AttachFiles()
    {
            if(txtMasterPK.text != '')
           { 
		
                    imgFile.MasterPK=txtMasterPK.text;
                    imgFile.ChangeImage();
		   
                    if( imgFile.oid == 0 )
                    {
                        return false;
                    }
                    else
                    {
						Grid_Attach.SetGridText( Grid_Attach.rows - 1, 3, txtMasterPK.text);   		
                        DSO_ATTACH_FILE.Call();
                    }
                    imgFile.oid= "";     
            } 
        else
        {
                alert('Please save data first!!');
        }     
}
//==========================================================================
function OnSearch(pos)
{
    switch(pos)
    {
        case 'grdSearch':
            dat_kpbp00150_1.Call("SELECT");
        break;
        case 'Detail':
            txtMasterPK.text=grdSearch.GetGridData(grdSearch.row,0);
            flag='search';
            dat_kpbp00150.Call("SELECT");
        break;
    }
    
}
//==========================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var obj = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( obj != null )
		    {
			    txtProject_Pk.text = obj[0];
                txtProject_Cd.text = obj[1];
                txtProject_Nm.text = obj[2]; 
                txtPONoSearch.text = obj[1];
				txtTAC_ABPL_pk.text = obj[3];
				dso_Outsitelist.Call();
			    //OnSearch();
		    }
	    break;
	    case 'subcontractor':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
            var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
			
            if ( obj != null )
            {
			
                     txtsubConTor.SetDataText(obj[2]);//customer name
                    txtsubConTorPK.SetDataText(obj[0]);//customer name
                    txtsubConTor_Cd.SetDataText(obj[1]); 
            
            }
        break;   
        case 'currency':        
             var path = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=ACAB0110";
	         var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
			 if (obj != null )
             {
				 lstCurrency.SetDataText(obj[1]);
			 }
        break;  
        case 'OutsideOrderWork':
             var path = System.RootURL + "/form/kp/bm/kpbm00010.aspx";
	         var obj = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         data = "<%=ESysLib.SetListDataSQL("SELECT a.pk, a.orderingconttypename  FROM ec111.tecps_orderingconttype a WHERE a.del_if = 0 order by a.pk desc")%>"; 
             lstOutOrdWk.SetDataText(data);
        break; 
		case 'AccSubContNo':
			//if(txtTAC_ABPL_pk.text != '')
//			{
				var path = System.RootURL + '/form/kp/cs/kpcs312_popup_AccSubCont.aspx?TAC_ABPL_pk=' + txtTAC_ABPL_pk.text;
				var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
				if ( obj != null )
				{
					txtAccSubContNo.SetDataText(obj[1]);
					txtAccSubContNo_Pk.SetDataText(obj[0]);
					
					txtsubConTor.SetDataText(obj[4]);//customer name
                    txtsubConTorPK.SetDataText(obj[2]);//customer name
                    txtsubConTor_Cd.SetDataText(obj[3]); 
				}
			//}
//			else
//			{
//				alert('Please select Project again !!');	
//			}
		break;
        case 'Create_Item':
			System.Menu.NewWindow( "form/kp/ac/kpac1011.aspx?project_pk=" + txtProject_Pk.text + "&project_cd=" + txtProject_Cd.text + "&project_nm=" + txtProject_Nm.text, "Item Entry", "Item Entry", "Item Entry" );
            //System.Menu.NewWindow( "form/kp/cs/kpcs311_subcontract_request.aspx?p_pk="+Grid_Detail.GetGridData(Grid_Detail.row, 0)+"&p_code="+Grid_Detail.GetGridData(Grid_Detail.row, 1)+"&p_nuture_of_w="+Grid_Detail.GetGridData(Grid_Detail.row, 2)+"&p_project_pk="+txtProject_Pk.text+"&p_project_code="+txtProject_Cd.text+"&p_project_name="+txtProject_Nm.text+"&p_currency="+Grid_Detail.GetGridData(Grid_Detail.row, 6)+"&p_BCWS_adj="+Grid_Detail.GetGridData(Grid_Detail.row, 7)+"&p_service_type="+Grid_Detail.GetGridData(Grid_Detail.row, 12) , "Subcontract Request", "Subcontract Request", "Subcontract Request" );

        break;
    }
    
}

//=========================================================================  
function OnAddRow()
{
    if(txtProject_Pk.text != '')
        { 
            grdDetail.AddRow();
            grdDetail.SetGridText(grdDetail.rows-1, G1_PROJECTCODE, txtProject_Cd.text) 
            grdDetail.SetGridText(grdDetail.rows-1, G1_STATUS,'N')
            grdDetail.SetGridText(grdDetail.rows-1, G1_PERFORMPERDFR,dtPeriod_Fr.value)
            grdDetail.SetGridText(grdDetail.rows-1, G1_PERFORMPERDTO,dtPeriod_To.value)
        }
        else
        {
            alert('Please select the Project first !!');
        }   
    
}
//========================================================================== 
function OnSave()
{
        if(txtMasterPK.text != '')
        {
                flag = 'save';
				if(!CheckData())
				{
                    
                	dat_kpbp00150.Call();
				}
        }
        else
        {
                alert('Please select grid master !!');
        }
}

function CheckData()
{
	if(txtAccSubContNo.text == '')
	{
		alert('Please input Acc. SubCont. No !!');	
		txtAccSubContNo.GetControl().focus();
        return true;
	}
    else if(Number(txtBudSub_FAmt.text) < 0 || Number(txtBudSubAmt.text) < 0)
    {
        alert('Subcontract Amount is over. Please modify it !!');
        return true;
    }
    else if(Number(txtSupAmt_B.text) > Number(txtBudgetAmt_B.text))
    {
        alert('Supplied Amt can not be large than Budget Amt !!');
        return true;
    }
	return false;
}


//==========================================================================
function DeleteAtt()
{
    if(confirm('Do you want to delete selected file ?'))
			{
			     Grid_Attach.DeleteRow();
			     DSO_ATTACH_FILE.Call();
			}
}
//==========================================================================
function OnDelete()
{
    if ( txtMasterPK.text!="")
    {
        if(confirm("Are you sure to delete !!!"))
        {
            dat_kpbp00150.StatusDelete();
            dat_kpbp00150.Call();
        }
        
    }    
}
//==========================================================================
function OnChangeTab()
{ 
	switch(radTab.value)
	{
		case '1':
			Span3.style.color      = "red";   
			Span4.style.color      = ""; 
		break;		
		case '2' :
			Span3.style.color      = "";   
			Span4.style.color      = "red"; 
		break;        

		 
     }
}
//==========================================================================
function OnUnDelete() 
{
    grdDetail.UnDeleteRow();
}
//==========================================================================
function OnConfirm()
{
//    if ( grdDetail.row > 0 )
//    {
//        var control = grdDetail.GetGridControl();
//        for(i=0;i<control.SelectedRows;i++)
//        {
//            grdDetail.SetGridText( control.SelectedRow(i), G1_STATUS,'Y' ) ;
//        }  
    if(txtMasterPK.text != '')
    {
            if(confirm('Are you sure you want to confirm?'))
            {
                    txtConfirm.text = '2';
                    OnSave();
            }
        }
        else
        {
                alert('Please select grid master !!');
        }
}

function OnCancel()
{
    if(txtMasterPK.text != '')
    {
            if(confirm('Are you sure you want to cancel?'))
            {
                    txtConfirm.text = '1';
                    OnSave();
            }
        }
        else
        {
                alert('Please select grid master !!');
        }
}
//=========================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";

    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";

    }
}
var flag="";
//========================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case'dat_kpbp00150':
            if(txtConfirm.text == '2')
            {
                    btnConfirm.SetEnable(false);
                    btnNew.SetEnable(false);
                    btnSave.SetEnable(false);
                    btnDelete.SetEnable(false);
            }
            else
            {
                    btnConfirm.SetEnable(true);
                    btnNew.SetEnable(true);
                    btnSave.SetEnable(true);
                    btnDelete.SetEnable(true);
            }
            if(flag=='save')
            {
                    dso_grdDetail.Call();
            }
            else
            {
                    DSO_ATTACH_FILE.Call("SELECT");
            }
        break;
       case 'DSO_ATTACH_FILE':
                dso_grdDetail.Call("SELECT");
       break; 
       case 'dso_grdDetail':
                MerGrid();
                for(var i = 2; i < Grid_Detail.rows;i++)
                {
                        Grid_Detail.SetGridText(i, WkngItemNo, i-1)
                }
       break; 
       case 'dso_get_rate':
            OnCalc();
       break;
    }
}
//========================================================================
function OnOpenFile()
{
        var img_pk = Grid_Attach.GetGridData(Grid_Attach.GetGridControl().row,2)	;
        var url = System.RootURL + "/system/binary/viewfile.aspx?img_pk=" + img_pk + "&table_name=tecps_substrp12000_file";	
        window.open(url);
}
//========================================================================
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
		fg.Cell(0, 1, 9, 1) 	= "Labor Cost Amt"
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
}
//========================================================================
function OnChangeCurrent()
{
    dso_get_rate.Call();
} 
//========================================================================
function OnCalc()
{
    var _B_BudgetAmt = Number(txtBudgetAmt_B.text);
    var _T_BudgetAmt = Number(txtBudgetAmt.text);
	var _T_SuppliedAmt =  Number(txtSupAmt.text);
	var _B_SuppliedAmt = Number(txtSupAmt_B.text);
	var _T_VAT = Number(txtVat.text);
	var _B_VAT = Number(txtVat_B.text);
	var _T_SubconAmt = 0;
	var _B_SubconAmt = 0;
	var _Balance = 0;
    var _T_Balance = 0;
	_T_SubconAmt = Math.round(_T_SuppliedAmt + _T_VAT);
	_B_SubconAmt =  Math.round(_B_SuppliedAmt + _B_VAT);
	_Balance = Math.round(_B_BudgetAmt - _B_SuppliedAmt);
	txtSubcontAmt.SetDataText(_T_SubconAmt);
	txtSubcontAmt_B.SetDataText(_B_SubconAmt);
	txtBudSubAmt.SetDataText(_Balance);
    if(lstCurrency.value == lstBdgtCcy.value)
    {
        _T_Balance = _T_BudgetAmt - _T_SuppliedAmt;
    }
    else
    {
        _T_Balance = 0;
    }
    txtBudSub_FAmt.text = _T_Balance;
    var _Supplied_FAmt = Number(txtSupAmt.text);
        var _FVAT = Number(txtVat.text);
        var _Subcon_FAmt = Number(txtSubcontAmt.text);  
        var _Balance = 0;

        var _Budget_Amt = 0;
        var _Supplied_Amt = 0;
        var _VAT = 0;
        var _Subcon_Amt = 0;  

        var _bk_rate = Number(lblBookRate.text);
        var _tr_rate = Number(txtExRate_B.text);
            if(txtbookccy.text == lstBdgtCcy.value)
            {
                _Budget_Amt = Number(txtBudgetAmt.text);
            }
            else if(lstBdgtCcy.value=='VND')
            {
                if(_bk_rate != 0)
                {
                    _Budget_Amt = Number(txtBudgetAmt.text)/_bk_rate;
                }
            }
            else
            {
                if(_bk_rate != 0)
                {
                    _Budget_Amt = Number(txtBudgetAmt.text) * _tr_rate / _bk_rate;
                }
            }
            //====================================================================
            if(txtbookccy.text == lstCurrency.value)
            {
                _Supplied_Amt = _Supplied_FAmt;
                _VAT = _FVAT;
                _Subcon_Amt = _Subcon_FAmt;
                _Balance = Number(txtBudgetAmt_B.text) - Number(txtSupAmt.text);
            }
            else if(lstCurrency.value=='VND')
            {
                if(_bk_rate != 0)
                {
                    _Supplied_Amt = _Supplied_FAmt/_bk_rate;
                    _VAT = _FVAT/_bk_rate;
                    _Subcon_Amt = _Subcon_FAmt/_bk_rate;
                    _Balance = Number(txtBudgetAmt_B.text) - _Supplied_Amt;
                }
            }
            else
            {
                if(_bk_rate != 0)
                {
                    _Supplied_Amt = Number(txtSupAmt.text) * _tr_rate / _bk_rate;
                    _VAT = Number(txtVat.text) * _tr_rate / _bk_rate;
                    _Subcon_Amt = Number(txtSubcontAmt.text) * _tr_rate / _bk_rate;
                    _Balance = Number(txtBudgetAmt_B.text) - _Subcon_Amt;
                }
            }
            
            
            txtBudgetAmt_B.text = _Budget_Amt;
            txtSupAmt_B.text = _Supplied_Amt;
            txtVat_B.text = _VAT;
            txtSubcontAmt_B.text = _Subcon_Amt;
            txtBudSubAmt.text = _Balance;
            /**/
}
//========================================================================
function OnNewDetail()
{
        if(txtMasterPK.text != '')
        {
            
				var path = System.RootURL + '/form/kp/ac/PopUpGetItem.aspx?project_pk=' + txtProject_Pk.text + '&project_cd=' + txtProject_Cd.text + '&project_nm=' + escape(txtProject_Nm.text) ;
				var aValue = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
				
				var obj;
				 if(aValue != null)
				 {
					
					for (i = 0; i < aValue.length; i++ )
					{
						obj = aValue[i];

						Grid_Detail.AddRow();
						Grid_Detail.SetGridText(Grid_Detail.rows-1, tecps_1200_pk, txtMasterPK.text);
						//Grid_Detail.SetGridText(Grid_Detail.rows-1, vendorbasc_pk, txtPk.text);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, project_pk, txtProject_Pk.text);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, VAT_Rate, '10');
						Grid_Detail.SetGridText(Grid_Detail.rows-1, DetailsLevelCode, obj[4]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Name, obj[5]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Item_pk, obj[3]);
						Grid_Detail.SetGridText(Grid_Detail.rows-1, Level_pk, obj[0]);
					}
						
				}
              
        }
        else
        {
                alert('Please select master !!');
        }
		
}
function OnGridCellDoubleClick()
{
        if(Grid_Detail.col == DetailsLevelCode || Grid_Detail.col == Name)
        {
	            var path = System.RootURL + '/form/kp/ac/PopUpGetItem.aspx?project_pk=' + txtProject_Pk.text + '&project_cd=' + txtProject_Cd.text + '&project_nm=' + escape(txtProject_Nm.text) ;
				var aValue = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		            var obj;
				 if(aValue != null)
				 {
					
					for (i = 0; i < aValue.length; i++ )
					{
						obj = aValue[i];
	                    Grid_Detail.SetGridText(Grid_Detail.row, DetailsLevelCode, obj[4]);
			            Grid_Detail.SetGridText(Grid_Detail.row, Name, obj[5]);
			            Grid_Detail.SetGridText(Grid_Detail.row, Item_pk, obj[3]);
			            Grid_Detail.SetGridText(Grid_Detail.row, Level_pk, obj[0]);
		            }
		        }
		}
}
function OnSaveDetail()
{
            dso_grdDetail.Call();
}

function OnEdit()
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
       
       Ctr_MtrlAmt = Math.round(Ctr_Qty * Ctr_MtrlUP);
       Ctr_LaborAmt = Math.round(Ctr_Qty * Ctr_LaborUP);
       Ctr_ExpAmt = Math.round(Ctr_Qty * Ctr_ExpUP);
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
       
       Wkg_MtrlAmt = Math.round(Wkg_Qty * Wkg_RawMtrlUP);
       Wkg_LaborAmt = Math.round(Wkg_Qty * Wkg_LaborUP);
       Wkg_ExpAmt = Math.round(Wkg_Qty * Wkg_ExpUP);
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
       
       Bf_MtrlAmt = Math.round(Bf_Qty * Bf_MtrlCostUP);
       Bf_LaborAmt = Math.round(Bf_Qty * Bf_LaborCostUP);
       Bf_ExpAmt = Math.round(Bf_Qty * Bf_ExpUP);
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
        //=================sum =====================
        //var _Budget_FAmt = Number(txtBudgetAmt.text);
        var _Supplied_FAmt = 0;
        var _FVAT = 0;
        var _Subcon_FAmt = 0;  
        var _Balance = 0;

        var _Budget_Amt = 0;
        var _Supplied_Amt = 0;
        var _VAT = 0;
        var _Subcon_Amt = 0;  

        var _bk_rate = Number(lblBookRate.text);
        var _tr_rate = Number(txtExRate_B.text);
        var i = 0;
        if(Grid_Detail.rows>1)
        {
            for(i=2;i<Grid_Detail.rows;i++)
            {
                _Supplied_FAmt += Number(Grid_Detail.GetGridData(i,W_Amt)); 
                _FVAT += Number(Grid_Detail.GetGridData(i,VAT_Amt)); 
                _Subcon_FAmt += Number(Grid_Detail.GetGridData(i,Total)); 
            }
            txtSupAmt.text = _Supplied_FAmt;
            txtVat.text = _FVAT;
            txtSubcontAmt.text = _Subcon_FAmt;
            OnCalc();
            /*
            if(txtbookccy.text == lstCurrency.value)
            {
                //alert();
                
                _Supplied_Amt = _Supplied_FAmt;
                _VAT = _FVAT;
                _Subcon_Amt = _Subcon_FAmt;
                _Balance = _Budget_Amt - Number(txtSupAmt.text);
            }
            else if(lstCurrency.value=='VND')
            {
                if(_bk_rate != 0)
                {
                    _Supplied_Amt = _Supplied_FAmt/_bk_rate;
                    _VAT = _FVAT/_bk_rate;
                    _Subcon_Amt = _Subcon_FAmt/_bk_rate;
                    _Balance = _Budget_Amt - _Supplied_Amt;
                }
            }
            else
            {
                if(_bk_rate != 0)
                {
                    
                    _Supplied_Amt = Number(txtSupAmt.text) * _tr_rate / _bk_rate;
                    _VAT = Number(txtVat.text) * _tr_rate / _bk_rate;
                    _Subcon_Amt = Number(txtSubcontAmt.text) * _tr_rate / _bk_rate;
                    _Balance = _Budget_Amt - _Subcon_Amt;
                }
            }
            
            if(txtbookccy.text == lstBdgtCcy.value)
            {
                _Budget_Amt = Number(txtBudgetAmt.text);
            }
            else if(lstBdgtCcy.value=='VND')
            {
                if(_bk_rate != 0)
                {
                    _Budget_Amt = Number(txtBudgetAmt.text)/_bk_rate;
                }
            }
            else
            {
                if(_bk_rate != 0)
                {
                    _Budget_Amt = Number(txtBudgetAmt.text) * _tr_rate / _bk_rate;
                }
            }
            txtBudgetAmt_B.text = _Budget_Amt;
            txtSupAmt_B.text = _Supplied_Amt;
            txtVat_B.text = _VAT;
            txtSubcontAmt_B.text = _Subcon_Amt;
            txtBudSubAmt.text = _Balance;
            /**/
        }
}

function onDelete_d()
{
        if(confirm('Are you sure you want to delete?'))
        {
                Grid_Detail.DeleteRow();
                dso_grdDetail.Call();
        }
}

function OnPrint(obj)
{
    switch(obj) 
    {
        case 'Detail':
            if(txtMasterPK.text != '')
            {
                var url = System.RootURL + "/reports/kp/cs/kpcs312.aspx?pk=" + txtMasterPK.GetData() + '&Ccy=' + lstCurrency.value;
                System.OpenTargetPage(url);   
            }
            else
            {
                alert('Please select grid master !!');
            }
        break;
        case 'Compare':
            if(txtMasterPK.text != '')
            {
                var url = System.RootURL + "/reports/kp/cs/kpcs312_compare.aspx?pk=" + txtMasterPK.GetData();
                System.OpenTargetPage(url);  
            }
            else
            {
                alert('Please select grid master !!');
            } 
        break;
    }    
}

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

</script>

<body>
    <!------------------------------------------------------------------------------------------------------------------>
    <gw:data id="dat_kpbp00150" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51" function="ec111.sp_sel_kpcs312_m1" procedure="ec111.sp_upd_kpcs312_M">
                <input>
                     <inout bind="txtMasterPK"  />
                     <inout bind="txtProject_Pk"  />
                     <inout bind="txtProject_Cd"  />
                     <inout bind="txtProject_Nm"  />
                     <inout bind="txtsubCode"  />
                     
                     <inout bind="txtsubName"  />
                     <inout bind="lstOutOrdWk"  />
                     <inout bind="txtsubConTorPK"  />
                     <inout bind="txtsubConTor_Cd"  />
                     <inout bind="txtsubConTor"  />
                     
                     <inout bind="txtHandover"  />
                     <inout bind="dtSubCont"  />
                     <inout bind="dtSubContFr"  />
                     <inout bind="dtSubContTo"  />                     
                     <inout bind="txtAdvance"  />
                     
                     <inout bind="txtProgress"  />
                     <inout bind="txtWithholding"  />
                     <inout bind="txtAdPayBond"  />
                     <inout bind="txtPerBond"  />
                     <inout bind="txtProviRate"  /> 
                                         
                     <inout bind="txtPerDay"  />
                     <inout bind="txtWarPeriod"  /> 
                     <inout bind="radTab"  />                   
					 <inout bind="lstCurrency"  />
                     <inout bind="txtBudgetAmt"  /> 
                                         
                     <inout bind="txtVat"  />                    
                     <inout bind="txtSupAmt"  />
                     <inout bind="txtSubcontAmt"  />                  
   					 <inout bind="txtBudSubAmt"  />					 
                     <inout bind="txtWorkscope"  />   
                                       
                     <inout bind="chkCont"  />
                     <inout bind="chkSubQuo"  />
                     <inout bind="chkTechRev"  />
                     <inout bind="chkReqSub"  />
                     <inout bind="chkOrther"  />
                     
                     <inout bind="txtOrther"  />
                     <inout bind="txtRemark"  /> 
                     <inout bind="txtScale"  />
                     <inout bind="txtRetention"  />
                     <inout bind="lblBookRate"  />
                     
                     <inout bind="txtConfirm"  />
                     <inout bind="txtExRate_B"  />
                     <inout bind="txtAccSubContNo_Pk"  />
                     <inout bind="txtAccSubContNo"  />
                     <inout bind="txtTAC_ABPL_pk"  />

                     <inout bind="lstBdgtCcy"  />
                     <inout bind="txtBudSub_FAmt"  />
                     <inout bind="txtBudgetAmt_B"  />
                     <inout bind="txtSupAmt_B"  />
                     <inout bind="txtVat_B"  />

                     <inout bind="txtSubcontAmt_B"  />
                     <inout bind="txtBudSubAmt"  />
                    
                     
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="dat_kpbp00150_1" onreceive="OnDataReceive(this)"> 
			<xml> 
				<dso id="1" type="grid"    function="ec111.sp_sel_kpbp00150_1"    > 
					<input bind="grdSearch">                    
						<input bind="dtFrom" /> 
						<input bind="dtTo" /> 
						<input bind="txtPONoSearch" />
                        <input bind="txtSubcontractSearch" />
					</input> 
					<output bind="grdSearch" /> 
				</dso> 
			</xml> 
     </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="DSO_ATTACH_FILE" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid" parameter="2"  function="ec111.sp_sel_kpbp00150_3"  procedure="ec111.sp_upd_kpbp00150_3">
          <input bind="Grid_Attach" >
          <input bind="txtMasterPK" />
          </input>
          <output bind="Grid_Attach" />
        </dso>
      </xml>
    </gw:data>
	<!---------------------------------------------------------------->
	<gw:data id="dso_Outsitelist" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="2" type="list" procedure="ec111.sp_sel_kpbm312_outorder" > 
			<input> 
				<input bind="txtProject_Pk" />
			</input> 
			<output>
				<output bind="lstOutOrdWk" /> 
			</output>
		</dso> 
	</xml> 
</gw:data>
    <!------------------------------------------------------------------------------------------------------------------>
   <gw:data id="dso_grdDetail" onreceive="OnDataReceive(this)">
      <xml>
        <dso id="1" type="grid"   function="ec111.sp_sel_kpcs312_1_detail"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60"   procedure="ec111.sp_upd_312_detail"   >
          <input bind="Grid_Detail" >
          <input bind="txtMasterPK" />
          </input>
          <output bind="Grid_Detail" />
        </dso>
      </xml>
    </gw:data>  
    
<gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtSubCont"/>
                     <input bind="cboCompany"/>
                     <input bind="lstCurrency" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtExRate_B"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>    
    
<gw:data id="dso_get_rate_book" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtSubCont"/>
                     <input bind="cboCompany"/>
                     <input bind="txtbookccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="lblBookRate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<table style="width: 100%; height: 100%;border-collapse: collapse" bordercolor="#00CCFF"  border="1" >
        <tr style="height:100%" valign="top">
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%" cellpadding="1" cellspacing="1">
                    <tr style="height:4%">
                            <td>
                                    <fieldset style="padding:0">
                                        <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                                 <tr style="height:">
                                                        <td style="width: 10%" align="right">Date&nbsp;</td>
                                                        <td style="width: 89%; white-space: nowrap"><gw:datebox id="dtFrom" lang="1" />~<gw:datebox id="dtTo" lang="1" /></td>
                                                        <td style="width: 1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" /></td>
                                                    </tr>
                                                    <tr style="height: " >
                                                        <td style="width: 10%" align="right">Project&nbsp;</td>
                                                        <td colspan="2"><gw:textbox id="txtPONoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                                    </tr>
                                                    <tr style="height: " >
                                                        <td style="width: 10%; white-space: nowrap" align="right">SubCont.&nbsp;</td>
                                                        <td colspan="2"><gw:textbox id="txtSubcontractSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" /></td>
                                                    </tr>
                                        </table>
                                      </fieldset>  
                            </td>
                    </tr>
                    <tr style="height: 96%" valign="top">
                        <td colspan="">
                            <gw:grid id='grdSearch' header='_PK|Subcontract No. |Contract name|Project|Contract Date' 
							    format='0|0|0|0|4'
                                aligns='0|0|0|0|0' 
								check='||||' 
								editcol='1|1|1|1|0' 
								widths='1000|1000|1000|1000|1000' sorting='T'
                                autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('Detail')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%;height:100%" valign="top">
                 <table cellpadding="1" cellspacing="1" style="width: 100%; height: " border="0">
                        <tr style="background:#C5EFF1">
                            <td width="22%" align="right"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project</a></td>
                            <td style="width: 78%; " colspan="">
                            	<table cellpadding="0" cellspacing="0" width="100%">
                                	<tr>
                                    	<td width="38%"><gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' /></td>
                                        <td width="60%"><gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' /></td>
                                        <td><gw:imgbtn id="btnonfirm" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" /></td>
                                        <td><gw:textbox id="txtProject_Pk" styles='width:100%;display:none' /></td>
                                        <td width="2%"></td>
                                        <td><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm"  styles='width:100%;display:none'  onclick="OnConfirm()" /></td>
                                        <td style="display:"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" styles='width:100%;display:none'  onclick="OnCancel()" /></td>
                                        <td style="display:none"><gw:imgbtn id="btnNew" img="new" alt="New" styles='width:100%;display:none'  onclick="OnAddNew()" /></td>
                                        <td><gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()"  styles='width:100%;display:none'  /></td>
                                        <td style="display:none"><gw:imgbtn id="btnDelete" img="delete" styles='width:100%;display:none'  alt="Delete" onclick="OnDelete()" /></td>
                                        <td><gw:imgbtn id="btnPrint" img="excel" alt="Print Report" onclick="OnPrint('Detail')" /></td>
                                        <td><gw:imgbtn id="btnPrint" img="excel" alt="Report Compare" styles='width:100%;display:none'  onclick="OnPrint('Compare')" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="background:#C5EFF1">
                            <td  align="right"><a title="SubContractor Code" style="color:#333">SubCont. Cde</a></td>
                            <td  colspan="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="35%"><gw:textbox id="txtsubCode" styles='width:100%' /></td>
                                        <td  align="right" width="30%"><a title="SubContractor Name" style="color:#333">SubCont. Name&nbsp;</a></td>
                                        <td style="width: 35%" ><gw:textbox id="txtsubName" styles='width:100%' /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="background:#C5EFF1">
                        	<td align="right"><a href="#" title="Click here to show Outside Order Work" style="text-decoration: none" onClick="OnPopUp('OutsideOrderWork')">Outside Order W.</a></td>
                            <td colspan="">
                            	<table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                    	<td width="35%"><gw:list id="lstOutOrdWk" styles='width:100%' /></td>
                                        <td width="30%" align="right"><a title="Handover Condition" style="color:#333">Handover Cond.&nbsp;</a></td>
                            			<td width="35%"><gw:textbox id="txtHandover" styles='width:100%' /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="background:#C5EFF1">
                        	<td align="right" ><a href="#" title="Click here to show Subcontractor" style="text-decoration: none" onClick="OnPopUp('subcontractor')">Subcontractor</a></td>
                            <td colspan="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="37%"><gw:textbox id="txtsubConTor_Cd" styles='width:100%' readonly="T" /></td>
                                        <td width="73%" ><gw:textbox id="txtsubConTor" styles='width:100%' readonly="T" /></td>
                                        <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtsubConTor_Cd.text='';txtsubConTor.text='';txtsubConTorPK.text='';" /></td>
                                        <td width=""><gw:textbox id="txtsubConTorPK" styles='width:0%;display:none' /></td>
                                    </tr>
                                </table>
                            </td>  
                        </tr>
                        <tr style="background:#C5EFF1">
                        	<td align="right" ><a href="#" title="Click here to show Accounting Subcontract No" style="text-decoration: none" onClick="OnPopUp('AccSubContNo')">Acc. SubCont. No</a></td>
                            <td colspan="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="100%"><gw:textbox id="txtAccSubContNo" csstype="mandatory" styles='width:100%' readonly="T" /></td>
                                        <td><gw:imgbtn id="btnnfim" img="reset" alt="Reset" onclick="txtAccSubContNo.text='';txtAccSubContNo_Pk.text='';" /></td>
                                        <td width=""><gw:textbox id="txtAccSubContNo_Pk" styles='width:0%;display:none' /></td>
                                    </tr>
                                </table>
                            </td>  
                        </tr>
                        <tr style="background:#C5EFF1">
                        	<td width="20%" align="right"><a title="Subcontract Date" style="color:#333">SubCont. Date&nbsp;</a></td>
                            <td colspan="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td ><gw:datebox id="dtSubCont" lang="1" styles='width:100%' /></td>
                                        <td align="right" width="100%"><a title="Subcontract Period" style="color:#333">SubCont. Per.&nbsp;</a></td>
                                        <td><gw:datebox id="dtSubContFr" lang="1" styles='width:100%' /></td>
                                        <td>~</td>
                                        <td><gw:datebox id="dtSubContTo" lang="1" styles='width:100%' /></td>
                                    </tr>
                    			</table>
                           </td>
                       </tr>    
                        <tr>
        	<td colspan="2">
            	<table cellpadding="0" cellspacing="0" width="100%" bordercolor="#00CCFF" style="border-collapse: collapse" border="1" >
            	    <tr style="background:#C5EFF1">
            	        <td align="right" style="width:22%  "><a href="#" style="text-decoration: none" onClick="OnPopUp('currency')">Currency&nbsp;</a></td>    
            	        <td width="78%">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="14%"><gw:list id="lstCurrency" onchange="OnChangeCurrent()" styles='width:100%' /></td>
                                    <td width="15%" align="right"><a title="Exchange Rate" style="color:#333">Ex. Rate&nbsp;</a></td>
                                    <td width="4%"><gw:textbox id="txtExRate" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="13%"><gw:textbox id="txtExRate_B" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="13%" align="right">Bdgt. Ccy:&nbsp;</td>
                                    <td width="14%"><gw:list id="lstBdgtCcy" onchange="OnCalc()" styles='width:100%' /></td>
                                    <td width="13%" align="right">Book rate:&nbsp;</td>
                                     <td width="14%"><gw:textbox id="lblBookRate" onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
            	    </tr>
                	<tr style="background:#C5EFF1">
                    	<td align="right" style="width:">Budget Amt (1)&nbsp;</td>
                        <td >
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="50%"><gw:textbox id="txtBudgetAmt" onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="50%"><gw:textbox id="txtBudgetAmt_B" readonly="true"  onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1">
                        <td align="right" style="width: ">Supplied Amt (2)&nbsp;</td>
                        <td >
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="50%"><gw:textbox id="txtSupAmt" onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="50%"><gw:textbox id="txtSupAmt_B" readonly="true"  onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1">
                        <td align="right" style="width: ">VAT (3)&nbsp;</td>
                        <td >
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="50%"><gw:textbox id="txtVat" onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="50%"><gw:textbox id="txtVat_B" readonly="true"  onenterkey="OnCalc()" onBlur="OnCalc()" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1">
                        <td align="right" style="width: "><a title="Subcontract Amount (4) = (2) + (3)" style="color:#333">Subcon. Amt (4)&nbsp;</a></td>
                        <td >
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="50%"><gw:textbox id="txtSubcontAmt"  readonly="true" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="50%"><gw:textbox id="txtSubcontAmt_B"  readonly="true" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background:#C5EFF1">
                        <td align="right" style="width: "><a title="Balance (5) = (1) - (2)" style="color:#333">Balance (5)&nbsp;</a></td>
                        <td width="">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td width="50%"><gw:textbox id="txtBudSub_FAmt" readonly="true" styles='width:100%' type="number" format="###,###.#" /></td>
                                    <td width="50%"><gw:textbox id="txtBudSubAmt" readonly="true" styles='width:100%' type="number" format="###,###.#" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
                        <tr>
                                <td colspan="2">
                                        <fieldset style="border:0" >
                                                <legend><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;"  onclick="OnShow()" /></legend>
                                                <table style="width:100%" id="updating_info" border="0" cellpadding="0" cellspacing="0">
                                                         <tr>
                                                                <td width="100%" colspan="2">
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td width="50%">
                                                                                <fieldset style="padding:0" >
                                                                                    <legend >Payment Condition</legend>
                                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td style="width:45%" align="right">Advance&nbsp;</td>
                                                                                            <td style="width:55%"><gw:textbox id="txtAdvance" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width: " align="right">Progress&nbsp;</td>
                                                                                            <td style="widows: "><gw:textbox id="txtProgress" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width:" align="right">Withholding tax&nbsp;</td>
                                                                                            <td style="width:"><gw:textbox id="txtWithholding" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width:" align="right">Retention&nbsp;</td>
                                                                                            <td style="width:"><gw:textbox id="txtRetention" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                            <td width="50%">
                                                                                <fieldset style="padding:0">
                                                                                    <legend>Guarantee Condition</legend>
                                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td style="width: 50%" align="right"><a title="Advance Payment Bond" style="color:#333">Adv. Pay. Bond&nbsp;</a></td>
                                                                                            <td style="width: 50%"><gw:textbox id="txtAdPayBond" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width:;" align="right">Performance Bond&nbsp;</td>
                                                                                            <td style="width:"><gw:textbox id="txtPerBond" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td style="width:" align="right">Provision Rate&nbsp;</td>
                                                                                            <td style="width:"><gw:textbox id="txtProviRate" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                             <td style="width:" align="right">Warranty Period&nbsp;</td>
                                                                                            <td style="width:"><gw:textbox id="txtWarPeriod" styles='width:60%' type="number" format="###,###.#" />Month</td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width="50%">
                                                                                <fieldset style="padding:0">
                                                                                    <legend>Penalty for Delay</legend>
                                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td style="width:50%" align="right">Period day&nbsp;</td>
                                                                                            <td style="width:50%"><gw:textbox id="txtPerDay" styles='width:88%' type="number" format="###,###.#" />%</td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                            <td width="50%">
                                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                                    <tr>
                                                                                        <td style="width: 50% " align="right" colspan=""><a title="Payment Guarantee Yes/No" style="color:#333"> Pay. Guar. Y/N</a></td>
                                                                                        <td width="50%">    
                                                                                            <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                                                                            <span value="1" id="Span3">Yes</span> 
                                                                                            <span value="2" id="Span4">No</span>
                                                                                            </gw:radio>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                        <tr style="background:#C5EFF1">
                                <td colspan="2">
                                    <table cellpadding="0" cellspacing="0" width="100%" style="border-collapse: collapse" bordercolor="#00CCFF" border="1" >
                                        <tr >
                                            <td align="right" style="width:22% " >Work Scope&nbsp;</td>
                                            <td width="78%"><gw:textarea id="txtWorkscope" styles='width:100%' /></td>
                                        </tr>
                                        <tr>
                                             <td align="right" style="width:"><a title="Attach Document" style="color:#333" rowspan="2">Att. Doc.&nbsp;</a></td>
                                        <td >
                                            <table border="0" width="100%" height="100%">
                                                <tr>
                                                    <td style="width:20% "><gw:checkbox id="chkTechRev" value="F"><a title="Technical Review" style="color:#333">Tech. Review</a></gw:checkbox></td>
                                                    <td style="width:40%"><gw:checkbox id="chkSubQuo" value="F"><a title="Subcontractor's Quotation" style="color:#333">SubCont. Quotation</a></gw:checkbox></td>
                                                    <td style="width:40% "><gw:checkbox id="chkCont" value="F"><a title="Contract" style="color:#333">Cont.</a></gw:checkbox></td>
                                                    
                                                </tr>
                                                <tr>
                                                    <td style="width:40%"><gw:checkbox id="chkReqSub" value="F"><a title="Request for Subcontract" style="color:#333">Req. for SubCont.</a></gw:checkbox></td>
                                                    <td colspan="2" style="width:60%"><gw:checkbox id="chkOrther" value="F">Orther&nbsp;</gw:checkbox><gw:textbox id="txtOrther" styles='width:70%' /> </td>
                                                </tr>
                                            </table>
                                        </td>
                                        </tr>
                                        <tr>
                                               <td  align="right" style="width:">Attach File&nbsp;</td> 
                                               <td >
                                                        <table border="0" width="100%" height="100%">
                                                            <tr>
                                                                    <td style="width:100%">
                                                                        <gw:grid id="Grid_Attach" header="File Name|Size|_pk|_project_pk" format="0|0|0|0"
                                                                            aligns="0|0|0|0" defaults="|||" editcol="0|0|0|0" widths="3000|500|0|0" styles="width:100%; height:70"
                                                                            sorting="T" oncelldblclick="OnOpenFile()" />
                                                                    </td>
                                                                    <td><button id="Button3" onClick="AttachFiles()">Attach</button><p></p><button id="Button4" onClick="DeleteAtt()">Delete</button></td>
                                                            
                                                            </tr>
                                                        </table>
                                                </td>
                                        </tr>
                                         <tr >
                                                <td  align="right">Execution Scale&nbsp;</td>
                                                <td><gw:textarea id="txtScale" styles='width:100%' /></td>
                                         </tr>
                                          <tr >
                                                <td  align="right">Remark&nbsp;</td>
                                                <td ><gw:textarea id="txtRemark" styles='width:100%' /> </td>
                                            </tr>
                                    </table>
                                </td>
                        </tr>
                                                </table>
                                        </fieldset>
                                </td>
                        </tr>
                        <tr>
                                    <td colspan="2">
                                            <fieldset style="width:100%;padding:0">
                                                    <table cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                        <td width="98%"></td>
                                                                        <td><gw:imgbtn id="btnPrint" img="create" alt="Create Item"  styles='width:100%;display:none'  onclick="OnPopUp('Create_Item')" /></td>
                                                                        <td width="1%"></td>
                                                                        <td ><gw:imgbtn id="ibtnew_d" img="new" alt="New" onclick="OnNewDetail()"  styles='width:100%;display:none'  /></td>
                                                                        <td width="1%"></td>
                                                                        <td style="display:none"><gw:imgbtn id="ibtnUpte1" img="save" alt="Save" onclick="OnSaveDetail()" /></td>
                                                                        <td ><gw:imgbtn id="ibtnDel" img="delete" alt="Delete item" onclick="onDelete_d()" styles='width:100%;display:none'  /></td>
                                                            </tr>
                                                    </table>
                                            </fieldset>
                                    </td>
                            </tr>
                        <tr valign="top">
                                    <td colspan="2" width="100%" >
                                            <gw:grid id="Grid_Detail" 
                                            header="0.Wkng Item No.|1.Details Level Code|_2.Details Level Seq. No.|3.Name|4.Standard|5.Weight|6.Unit|_7.Q'ty|_8.Raw Mtrl. Cost U/P|_9.Raw Mtrl. Cost Amt|_10.Labor Cost U/P|_11.Labor Cost Amt|_12.Exp. U/P|_13.Exp. Amt|_14.U/P|_15.Amt|16.Q'ty|17.Raw Mtrl. Cost U/P|18.Raw Mtrl. Cost Amt|19.Labor Cost U/P|20.Labor Cost Amt|21.Exp. U/P|22.Exp. Amt|23.U/P|24.Amt|_25.Q'ty|_26.Raw Mtrl. Cost U/P|_27.Raw Mtrl. Cost Amt|_28.Labor Cost U/P|_29.Labor Cost Amt|_30.Exp. U/P|_31.Exp. Amt|_32.U/P|_33.Amt|_34.Q'ty|_35.Raw Mtrl. Cost U/P|_36.Raw Mtrl. Cost Amt|_37.Labor Cost U/P|_38.Labor Cost Amt|_39.Exp. U/P|_40.Exp. Amt|_41.U/P|_42.Amt|_43.Q'ty|_44.Raw Mtrl. Cost U/P|_45.Raw Mtrl. Cost Amt|_46.Labor Cost U/P|_47.Labor Cost Amt|_48.Exp. U/P|_49.Exp. Amt|_50.U/P|_51.Amt|52.VAT Rate|53.VAT Amount|_54.pk|_55.Confirm|56.Total|_57.tecps_1200_pk|_58.project_pk|_59.Item_pk|_60.Level_pk"
                                            format="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|1|0|0|1|0|0|0|0" 
                                            aligns  ="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0"
                                            defaults="||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||" 
                                           editcol ="0|0|0|0|0|0|0|0|1|0|1|0|1|0|0|0|1|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|0|1|0|1|0|1|0|0|0|1|1|0|0|0|0|0|0|0" 
                                            widths="600|1700|2000|2500|1500|1500|1500|1500|1500|2000|1500|1500|2000|1500|1500|2000|1700|2000|2500|1500|1500|1500|1500|1500|2000|1500|1500|2000|1500|1500|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1500|2000|0|0|2000|0|0|0|0"
                                            styles="width:100%; height:200" 
                                            sorting="T" 
                                            oncelldblclick="OnGridCellDoubleClick()"
                                            onafteredit="OnEdit()" />
                                  </td>
                            </tr> 
                            <tr  style="display:none">
                                <td colspan="2">
                                    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
                                    <gw:textbox id="cboCompany" styles='width:100%;display:none' />
                                    <gw:textbox id="txt_row"        styles='display:none'/>
                                    <gw:textbox id="txtTAC_ABPL_pk"        styles='display:none'/>
                                    <gw:image id="imgFile" table_name="tecps_substrp12000_file" view="/binary/ViewFile.aspx"  post="/binary/PostFile.aspx" styles="width:100;height:100;display:none" />
                                    
                                    <gw:textbox id="txtConfirm"        styles='display:none'/>
                                </td>
                            </tr> 
                    </table>    
            </td> 
         </tr>
</table>
          
</body>

 <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onClick="OnToggle()" />
<gw:textbox id="txtbookccy"        styles='display:none;width:100%'/>

</html>
