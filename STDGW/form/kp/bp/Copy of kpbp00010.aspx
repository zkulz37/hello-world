<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%  ESysLib.SetUser("acnt")%>
<!-- #include file="../../../system/lib/form.inc"  -->
<script>
//var flag='new';
var _book_rate = 0;
var _Book_CCY = "VND";
var Trans_amt = 4;
function BodyInit()
{
  
   BindingDataList();
   
   //ChangeEx();
   
  //dso_get_rate_book.Call();
  //FormatGrid();
}
//--------------------------------------------------------------------------------------------
function ChangeEx()
{
   //txtExrate2.SetDataText('1');
   //txtexrate1.SetDataText("1");
   //txtexrate1.SetEnable(false);
   //txt_row.text    = 1;
   
    var ls_current  = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
   //listccy.SetDataText(ls_current);
   
   data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
   arr  = data.split("|");
   //txtbookccy.SetDataText(arr[1]);
   
  <%=ESysLib.SetGridColumnComboFormat("GridTerms",2,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'EACAB043' and a.del_if = 0 and b.del_if = 0")%>;
   
}
//------------------------------------------------------------------------------------------
function BindingDataList()
 {      
     var data ;
     var arr;
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('EACBK014') FROM DUAL")%>";
     //lstReport.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
     cboCompany.SetDataText(data);
     cboCompany.value = "<%=Session("COMPANY_PK") %>";
     txtuser_pk.text =  "<%=Session("USER_PK") %>";
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";
     cboStatus.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0010') FROM DUAL")%>";
     arr  = data.split("|");
	 cboStatus.SetDataText(arr[1]);
	 data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','03','') FROM DUAL")%>";
     listccy.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0001') FROM DUAL")%>";
     lstArea.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACCR0110') FROM DUAL")%>";
     lstVatrate.SetDataText(data);
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0002') FROM DUAL")%>";
     lstUnit.SetDataText(data);
     
     
	 /*var trl = GridDetail.GetGridControl();
	 SetControlFormat();
	 trl.FrozenCols = 5;
	 data = "<%=ESysLib.SetGridColumnDataSQL("select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM  from comm.tco_uom a where del_if=0" ) %> "; 
     GridDetail.SetComboFormat(5,data);
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT   code, b.code_nm  FROM tac_commcode_master a, tac_commcode_detail b  WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'ACCR0110' AND a.del_if = 0  AND b.del_if = 0 AND b.use_yn = 'Y' ORDER BY code, b.code_nm" ) %> "; 
     GridDetail.SetComboFormat(9,data);
	*/
     
 }
 //------------------------------------------------------------------------------------------

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
//------------------------------------------------------------------------------------------

function SetControlFormat()
{
    var ctrl1 = GridDetail.GetGridControl();
    ctrl1.ColFormat(6) = "#,###,###,###,###,###,###,###.##R";  
    ctrl1.ColFormat(7) = "#,###,###,###,###,###,###,###.##R";  
    ctrl1.ColFormat(8) = "#,###,###,###,###,###,###,###.##R";
   
    ctrl1.ColFormat(10) = "#,###,###,###,###,###,###,###.##R";
    ctrl1.ColFormat(11) = "#,###,###,###,###,###,###,###.##R";
    ctrl1.ColFormat(12) = "#,###,###,###,###,###,###,###.##R"; 
    
}
//------------------------------------------------------------------------------------------

/*function onSearch(index)
{
    switch(index)
    {
        case 0: // Show data on searching grid
            dat_gfqc00050_3.Call("SELECT"); 
        break;
        case 1: // Show data on control when click on searching grid
            txttac_crcontract_pk.SetDataText(GridSearch.GetGridData(GridSearch.row,0));
            flag='search';
            dat_gfqc00050_2.Call('SELECT');
        break;    
    }
}*/
//------------------------------------------------------------------------------------------
/*function BookAmt()
{
    var l_txtContractamount, l_txtAmtAdj, l_txtTotal, l_txtVatamt, l_txtAdjvatamt = 0;
    var l_txtExrate2 = 0;
    var l_txtcontract_amt = 0;
    l_txtExrate2 = Number(txtExrate2.text);
    
    if(Trim(txtContractamount.text) != "")
            {
                l_txtContractamount = Number(txtContractamount.text);
                
                l_txtcontract_amt = Number(l_txtContractamount*l_txtExrate2);
                txtContract_bamt.text = l_txtcontract_amt;
            }
    if(Trim(txtAmtAdj.text) != "")
            {
                l_txtAmtAdj = Number(txtAmtAdj.text);
                
                l_txtcontract_amt = Number(l_txtAmtAdj*l_txtExrate2);
                txtContract_bAmtAdj.text = l_txtcontract_amt;
            } 
     if(Trim(txtGrandtotal.text) != "")
            {
                l_txtGrandtotal = Number(txtGrandtotal.text);
                
                l_txtcontract_amt = Number(l_txtGrandtotal*l_txtExrate2);
                txtContract_bAmt_Final.text = l_txtcontract_amt;
            }  
      if(Trim(txtVatamt.text) != "")
            {
                l_txtVatamt = Number(txtVatamt.text);
                
                l_txtcontract_amt = Number(l_txtVatamt*l_txtExrate2);
                txtVat_bamt.text = l_txtcontract_amt;
            }  
    if(Trim(txtAdjvatamt.text) != "")
            {
                l_txtAdjvatamt = Number(txtAdjvatamt.text);
                
                l_txtcontract_amt = Number(l_txtAdjvatamt*l_txtExrate2);
                txtbAmt_adj.text = l_txtcontract_amt;
            }
    if(Trim(txtVatamt.text) != "")
            {
                l_txtVatamt = Number(txtVatamt.text);
                
                l_txtcontract_amt = Number(l_txtVatamt*l_txtExrate2);
                txtContract_bVatamt.text = l_txtcontract_amt;
            }  
   else
   
      {
        txtContractamount.text = "";
      }
                
}*/
//------------------------------------------------------------------------------------------
/*function OnChangeAmt_Receive()
{
    dso_get_rate.Call();
    OnChangeAmt();
    
}*/
//--------------------------------------------------------------------------------------
/*function CheckDuplicate()
{       
   for(var i = 1; i < GridSearch.rows; i++)
    {
        if(GridSearch.GetGridData(i, 2) == txtContractNo.text)
        {
            alert("Duplicated ContractNo!! ");
            txtContractNo.GetControl().focus();
            return false ;
        }
    }
    return true;
}*/
//------------------------------------------------------------------------------------------
/*function OnDataReceive(obj)
{
    switch(obj.id)
    {  
         case "dso_get_rate_book":
               dat_gfqc00050_1.Call(); 
        break;
        
        case "dso_get_exrate_list":
            
            dat_gfqc00050_1.Call('SELECT');
        break; 
        case "dso_get_rate":
           BookAmt();
            
        break;
        case "dat_gfqc00050_1":
           if(flag!='search')
           { 
            for(i = 1; i < GridDetail.rows; i++)
                {
                    if(GridDetail.GetGridData(i, 2)=='')
                    {
                        GridDetail.SetGridText(i, 2, txttac_crcontract_pk.text);
                        GridDetail.SetRowStatus(i, 0x20);
                    }    
                }
                
                dat_gfqc00050_4.Call();
           }
           else
           {
                
                dat_gfqc00050_4.Call('SELECT');
           } 
        break;  
        case "dat_gfqc00050_2":
           if(flag== 'delete')
           {
                dat_gfqc00050_3.Call('SELECT');
                return;
            }  
        
           OnChangeAmt();
        
           if(flag!='search')
           {
                for(i=1;i< GridTerms.rows; i++)
                {
                    GridTerms.SetGridText(i, 1, txttac_crcontract_pk.text);
                    if(GridTerms.GetGridData(i,0) == '')
                    {
                    
                        GridTerms.SetRowStatus(i, 0x20);
                    }
                }
                //txttac_crcontract_pk.text = 
                dat_gfqc00050_1.Call();
           }else
           {
             dat_gfqc00050_1.Call("SELECT");
           }
        break; 
        case "dat_gfqc00050_4":
            if(flag == 'new')
            {
                dat_gfqc00050_3.Call('SELECT');
            }
        break;
        case "dso_get_exrate_list":
            _book_rate = GetBookExRate(_Book_CCY);
            lblBookRate.text = _book_rate;        break;
          
    }  
}*/
//------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
/*function onPrint()
{
    var url='';
    switch(lstReport.GetData())
    {
        case "1": // A/R On Progress
            if(txttac_crcontract_pk.text !="")
            {
                url = '/reports/gf/qc/gfqc00050_AR_OnProgress.aspx?p_tac_crcontract_pk=' + txttac_crcontract_pk.GetData() + '&l_company=' + cboCompany.GetData() + '&bookccy=' + listccy.value ;
                System.OpenTargetPage( System.RootURL+url , "newform" );
            }
            else
            {
                alert("Please select code master!!!");
            }
            
        break;
        case "2": // A/R On Progress - Advance From Customer
            url = '/reports/gf/qc/advance.xls';
        break;
        case "3": // A/R On Progress - Turn Over
            url = '/reports/gf/qc/ar_progress_turnover.xls';
        break;
        case "4": // A/R On Progress - Issue Invoice
            url = '/reports/gf/qc/issue_inv.xls';
        break;
        case "5": // A/R On Progress - Collection Money
            url = '/reports/gf/qc/Collection.xls';
        break;
    }
    
} */
//------------------------------------------------------------------------------------------
 
/*function OnPopUp(pos)
{
    switch(pos)
    {
       case 'cust_search':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		        if (object[0] != 0)
                {
                    //txt_CustomerID.SetDataText(object[1]);//customer id
                    txtCustomers_nm.SetDataText(object[2]);//customer name
                    //txt_CustomerPK.SetDataText(object[0]);//customer name
      	        }
		     }       
        break;  
        case 'cust':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		        if (object[0] != 0)
                {
                    txtCust_id.SetDataText(object[1]);//customer id
                    txtCust_nm.SetDataText(object[2]);//customer name
                    txtCust_pk.SetDataText(object[0]);//customer name
      	        }
		     }       
        break; 
        case 'cust_to':
            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		    var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
		        if (object[0] != 0)
                {
                    txtCustto_id.SetDataText(object[1]);//customer id
                    txtCustto_nm.SetDataText(object[2]);//customer name
                    txtCustto_pk.SetDataText(object[0]);//customer name
      	        }
		     }       
        break;  
          
        case 'PL_search':
             fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
             oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            if ( oValue != null )
            {
                txtProject_pk.text = oValue[2]; 
                txtProject_nm.text   = oValue[1];
                txtProject_cd.text   = oValue[0];
            }
          
          
        break;  
        case 'Project':
             fpath  = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
             oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            if ( oValue != null )
            {
                //txtProject_pk.text = oValue[2]; 
                txtProjects_name.text   = oValue[1];
               // txtProject_cd.text   = oValue[0];
            }
         /*
            fpath   = System.RootURL + "/form/gf/qc/gfqc00050_plunit.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + cboCompany.GetData() + '&dsqlid=ACNT.sp_sel_gfqc00050_plunit_tree&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
           
          var object  = System.OpenModal(fpath , 600 , 400 , 'resizable:yes;status:yes'); 
            // var object=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
          var tmp;
            if ( object != null )  
            {
               if (object[0] != 0)
                {
                   txtProject_pk.text=object;     // Center PK
                    dat_gfqc00050_popup.Call();
                }   
                     txtProjects_nm.text   = object[1];    
            }   
        break;      
                                                  
    }	       
} */
//----------------------------------------------------------------------------------
/*function UnDelete()
{ 
    GridDetail.UnDeleteRow();
}  */           
//--------------------------------------------------------------------
/*function OnChangeAmt()
{
    var l_contract_amt =0;
	var l_contract_famt = 0;
	var l_unit_price =Number(txtUnitprice.GetData());
	var l_Qty = Number(txtQuantity.GetData());
	var l_vat_rate = lstVatrate.GetData();
	if(!isNaN(l_vat_rate)){
	    l_vat_rate = Number(l_vat_rate);
	}else
	{
	    l_vat_rate =0;
	}


	
	var l_contract_vat =0;
	var l_contract_fvat =0;
	var l_contract_amt_adj = txtAmtAdj.GetData();
	var l_contract_famt_adj = 0;
	var l_vat_adj =txtAdjvatamt.GetData();
	var l_fvat_adj = 0;
	var l_contract_final_amt = 0;
	var l_contract_final_famt = 0;
	
	var l_FTotalAdjAmount = 0;
	var l_AdjAmtTemp = 0;
	var l_QtyAdj = 0;
	
	var l_TotalVatAdjTmp = 0;
	var l_TotalVatAdj = 0;
	var l_NetTotal = 0;
	var l_amt6 =0 ;
	var l_amt10 =0 ;
	var l_amt11 =0 ;
	var l_amt12 =0 ;
	l_contract_famt = l_unit_price*l_Qty;
	txtContractamount.SetDataText('' +l_contract_famt);
	l_contract_fvat = l_contract_famt*l_vat_rate/100;
	txtVatamt.SetDataText('' +l_contract_fvat);
	l_NetTotal = Number(l_contract_amt_adj)  +  Number(l_contract_famt);
	txtamt5.SetDataText('' +l_NetTotal);
	l_amt6 = Number(l_contract_famt) + Number(txtVatamt.GetData());
	txtTotal.SetDataText('' +l_amt6);
	l_amt10 = Number(l_vat_adj)  + Number(txtVatamt.GetData());
	txtamt9.SetDataText('' +l_amt10);
	l_amt11 = Number(txtAmtAdj.GetData()) + Number(txtAdjvatamt.GetData());
	Totaladj_amt.SetDataText('' +l_amt11);
	l_amt12 = Number(txtamt5.GetData()) + Number(txtamt9.GetData());
	txtGrandtotal.SetDataText('' +l_amt12);
	
	
	l_txtExrate2 = 0;
	l_txtExrate2 = Number(txtExrate2.text);
	
	if(Trim(txtContractamount.text) != "")
            {
                
                
                l_txtcontract_amt = Number(l_contract_famt*l_txtExrate2) / Number(lblBookRate.text) ;
              // alert(lblBookRate.text);
              // alert(l_txtExrate2);
                if(txtbookccy.text = "VND")
                {
                    l_txtcontract_amt = Math.round(l_txtcontract_amt);
                }
                else
                {
                    l_txtcontract_amt = Math.round(l_txtcontract_amt * 100) / 100;
                }
                txtContract_bamt.text = l_txtcontract_amt;
            }
    if(Trim(txtAmtAdj.text) != "")
            {
                
                
                l_txtcontract_amt = Number(l_contract_amt_adj*l_txtExrate2);
                txtContract_bAmtAdj.text = l_txtcontract_amt;
            }    
    if(Trim(txtGrandtotal.text) != "")
            {
                
                
                l_txtcontract_amt = Number(l_amt12*l_txtExrate2) / Number(lblBookRate.text) ;
                if(txtbookccy.text = "VND")
                {
                    l_txtcontract_amt = Math.round(l_txtcontract_amt);
                }
                else
                {
                    l_txtcontract_amt = Math.round(l_txtcontract_amt * 100) / 100;
                }
                txtContract_bAmt_Final.text = l_txtcontract_amt;
            }  
    if(Trim(txtVatamt.text) != "")
            {
                
                
                l_txtVatamt = Number(l_contract_fvat*l_txtExrate2);
                txtVat_bamt.text = l_txtVatamt;
            }
     if(Trim(txtAdjvatamt.text) != "")
            {
                
                
                l_txtAdjvatamt = Number(l_vat_adj*l_txtExrate2);
                txtbAmt_adj.text = l_txtAdjvatamt;
            }
     if(Trim(txtVatamt.text) != "")
            {
                
                
                //l_txtVatamt = Number(l_contract_fvat*l_txtExrate2);
                txtContract_bVatamt.text = l_txtVatamt;
            }
    else
    {
        txtContract_bamt.text = "";
    }
	
	OnEdit();
	
}*/
//--------------------------------------------------------------------
/*var flag ="";
function OnSave()
{
    
    if(onValidate())
    {
        if(txttac_crcontract_pk.GetData()!='') flag='update';
        dat_gfqc00050_2.Call();
    }    
}*/
//--------------------------------------------------------------------
/*function onDelete(index)
{
    switch(index)
    {
        case 0:
            if(txttac_crcontract_pk.GetData()!='')
            {
                if(confirm('Do you want to delete selected contract?'))
                {
                     flag='delete';
                     dat_gfqc00050_2.StatusDelete();
                     dat_gfqc00050_2.Call();
                }
            }    
        break;
        case 1:
            if(confirm('Do you want to delete selected item(s)?'))
            {
                GridDetail.DeleteRow();
                //dat_gfqc00050_4.Call();
            }
        break;
    }         
}*/
//-------------------------------------------------------------------
/*function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
    var x = c.toUpperCase().charCodeAt(0);
    event.keyCode = x;
}*/
//--------------------------------------------------------------------
/*function  OnNew(index)
{
    switch(index)
    {
        case 0: // New master
            flag='new';
            dat_gfqc00050_2.StatusInsert();
            txtuser_pk.text =  "<%=Session("USER_PK") %>";
            GridDetail.ClearData();
           for(var i = 1; i < GridTerms.rows; i++)
           {
                for(var j = 3; j < GridTerms.cols ; j++)
                {
                    GridTerms.SetGridText(i, j, "");
                }                
           }
            chkauto_YN.SetDataText("Y");
            ChangeEx();
        break;
        case 1: // new free detail
            GridDetail.AddRow();
            GridDetail.SetGridText( GridDetail.rows-1, 2, txttac_crcontract_pk.text); //master_pk	  
        break;
        case 2: // new free detail
        if(GridDetail.col=="3")
        {
            var path = System.RootURL + '/form/gf/qc/gfqc00050_1.aspx?group_type=||Y|Y||';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             var isAlready, j ;                                                     
             if ( object != null )
             {
                   
                    for( var i=0; i < object.length; i++)	  
                    {	
                         var arrTemp = new Array();
                         arrTemp = object[i];
                         isAlready = 0 ;
                          for(var k=1; k<GridDetail.rows;k++)
                          {
	                        //alert(GridDetail.GetGridData(k , 15));
	                        //alert(arrTemp[0]);
	                        if (GridDetail.GetGridData(k , 15)== arrTemp[0]) // da co item_pk
					        {					            					            
						        isAlready=1;						        
						        j = k ;						        
						        break;	
					        }		
                         }
                    
                     if(isAlready==0) 
	                    {    
                                if(i!=0)
                                {
                                    arrTemp = object[i];
                                    GridDetail.AddRow();
                                    GridDetail.SetGridText( GridDetail.rows-1, 2, txttac_crcontract_pk.text); //master_pk	    	                                               
                                    GridDetail.SetGridText( GridDetail.rows-1, 15, arrTemp[0]);//item_pk	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 3,   arrTemp[1]);//item_code	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 4,   arrTemp[2]);//item_name	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 5,         arrTemp[5]);//item_uom
                                    GridDetail.SetGridText( GridDetail.rows-1, 8,         arrTemp[7]);//item_uom
                                }
                                else
                                {
                                    arrTemp = object[i];
                                    
                                    GridDetail.SetGridText( GridDetail.rows-1, 2, txttac_crcontract_pk.text); //master_pk	    	                                               
                                    GridDetail.SetGridText( GridDetail.rows-1, 15, arrTemp[0]);//item_pk	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 3,   arrTemp[1]);//item_code	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 4,   arrTemp[2]);//item_name	    
                                    GridDetail.SetGridText( GridDetail.rows-1, 5,         arrTemp[5]);//item_uom
                                    GridDetail.SetGridText( GridDetail.rows-1, 8,         arrTemp[7]);//item_uom
                                }
                         }
                      else 
                        {
                             GridDetail.RemoveRowAt(j) ;
                        }      
                    }		            
             }  
             GridDetail.SetGridText(GridDetail.rows-1,1,'') 
    }
        break;
        case 4: // new free detail
            var path = System.RootURL + '/form/gf/qc/gfqc00050_1.aspx?group_type=||Y|Y||';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             var isAlready, j ;                                                     
             if ( object != null )
             {
                   
                    for( var i=0; i < object.length; i++)	  
                    {	
                         var arrTemp = new Array();
                         arrTemp = object[i];
                         isAlready = 0 ;
                          for(var k=1; k<GridDetail.rows;k++)
                          {
	                        //alert(GridDetail.GetGridData(k , 15));
	                        //alert(arrTemp[0]);
	                       if (GridDetail.GetGridData(k , 15)== arrTemp[0]) // da co item_pk
					        {					            					            
						        isAlready=1;						        
						        //j = k ;						        
						        break;	
					        }		
                         }
                    
                     if(isAlready==0) 
	                    {    
                          //  if(i != 0)
                          //  {
                                arrTemp = object[i];
                                GridDetail.AddRow();
                                GridDetail.SetGridText( GridDetail.rows-1, 2, txttac_crcontract_pk.text); //master_pk	    	                                               
                                GridDetail.SetGridText( GridDetail.rows-1, 15, arrTemp[0]);//item_pk	    
                                GridDetail.SetGridText( GridDetail.rows-1, 3,   arrTemp[1]);//item_code	    
                                GridDetail.SetGridText( GridDetail.rows-1, 4,   arrTemp[2]);//item_name	    
                                GridDetail.SetGridText( GridDetail.rows-1, 5,         arrTemp[5]);//item_uom
                                GridDetail.SetGridText( GridDetail.rows-1, 8,         arrTemp[7]);//item_uom
                            // }
                             else
                             {
                                 arrTemp = object[i];
                               
                                GridDetail.SetGridText( GridDetail.rows-1, 2, txttac_crcontract_pk.text); //master_pk	    	                                               
                                GridDetail.SetGridText( GridDetail.rows-1, 15, arrTemp[0]);//item_pk	    
                                GridDetail.SetGridText( GridDetail.rows-1, 3,   arrTemp[1]);//item_code	    
                                GridDetail.SetGridText( GridDetail.rows-1, 4,   arrTemp[2]);//item_name	    
                                GridDetail.SetGridText( GridDetail.rows-1, 5,         arrTemp[5]);//item_uom
                                GridDetail.SetGridText( GridDetail.rows-1, 8,         arrTemp[7]);//item_uom
                             }
                         }
                      else 
                        {
                             GridDetail.RemoveRowAt(j) ;
                        }      
                    }		            
             }  
             GridDetail.SetGridText(GridDetail.rows-1,1,'') 
             break;
    }        
}*/
//--------------------------------------------------------------------
/*function onValidate()
{
    if(txtContractNo.GetData()=="")
    {
        alert('Please inpput contract no first.');
        txtContractNo.GetControl().focus();
        return false;
    }
    if(txtProject_pk.GetData()=="")
    {
        alert('Please select project first.');
        txtProject_cd.GetControl().focus();
        return false;
    }
    if(txtCust_pk.GetData()=="")
    {
        alert('Please select customer first.');
        txtCust_id.GetControl().focus();
        return false;
    }
    if(txtCustto_pk.GetData()=="")
    {
        alert('Please select customer turnover first.');
        txtCustto_id.GetControl().focus();
        return false;
    }
    return true;
}*/
//--------------------------------------------------------------------

/*function OnChangeCurrent()
{
    
    dso_get_rate.Call();
    
    
} 
function FormatGrid()
{
    var trl;
    trl = GridTerms.GetGridControl();	
    trl.ColFormat(Trans_amt)    = "###,###,###,###,###.##";
}
function OnEdit()
{
//     if ((event.col == 7) || (event.col ==8))
//                {
//                    if (event.row != 4)
//                    {
//                        GridTerms.SetGridText(event.row,event.col,'');   
//                        return;
//                    }
//                }
             
             var ctrl   = GridTerms.GetGridControl();
	            var amount = 0;
            	var n = 0, i ;
	          
	                    
//--------------------------------------------------------------------	                    
	                    
	                    for(i = 1; i < GridTerms.rows; i++)
            	{
	               var strRate = GridTerms.GetGridData(i, 6); // code 
	            
	                    if (strRate =="50")
	                    {
	                            GridTerms.SetGridText(event.row, 4,'');  // amt
	                            GridTerms.SetGridText(event.row, 3,'');  // rate
	                    }
	                    else
	                    {	                                   
                           n += Number(GridTerms.GetGridData(i,3));
                           //alert(n);
                            if(n>100)
                            {
                                 alert("The total value can not large than 100 percent!!");
                                 GridTerms.SetGridText(event.row, 3,''); 
                                 GridTerms.SetGridText(event.row, 4,''); 
                                 return;
                            }
	                     }            

	            }  // for
             amount = Number(txtGrandtotal.GetData());
             for( i = 1; i < GridTerms.rows ; i++)
             {
                 if( Number(GridTerms.GetGridData(i, 3)) != 0 && GridTerms.GetGridData(i, 3) != '') 
                 {
                     GridTerms.SetGridText(i, 4, Math.round(Number(GridTerms.GetGridData(i, 3)) / 100 * amount)) ; 
                 }
             }
}*/
//--------------------------------------------------------------------
/*function OnEditDetail()
{
    var tmp=0;
    var l_qty = GridDetail.GetGridData(GridDetail.row,6);
    var l_u_price = GridDetail.GetGridData(GridDetail.row,7);
    var l_amt = Number(l_qty) * Number(l_u_price);
    GridDetail.SetGridText(GridDetail.row,8,'' + l_amt);
    var l_vat_rate = GridDetail.GetGridData(GridDetail.row,9);
    if(!isNaN(l_vat_rate)){
	    l_vat_rate = Number(l_vat_rate);
	}else
	{
	    l_vat_rate =0;
	}
    var l_vat_amt = (Number(l_vat_rate)/100) * Number(l_amt);
    GridDetail.SetGridText(GridDetail.row,10,'' + l_vat_amt);
    var l_amt_adj=  GridDetail.GetGridData(GridDetail.row,11);
    var l_total = Number(l_amt) + Number(l_vat_amt) + Number(l_amt_adj);
    GridDetail.SetGridText(GridDetail.row,12,'' + l_total);
    
}*/
//--------------------------------------------------------------------
/*function OnSumAmt()
{
    //alert('OnSumAmt');
    var ctrl = GridDetail.GetGridControl();
      var Total  = 0;
      var VAT_Amt = 0;
      var Sum_Adj_Amt = 0;
     var Amt = 0;
    for (i = 1; i < ctrl.rows; i++)
	{
	     Total = Number(Total) + Number(GridDetail.GetGridData(i, 12));
	     VAT_Amt = Number(VAT_Amt)+ Number(GridDetail.GetGridData(i,10));
	    Amt = Number(Amt) + Number(GridDetail.GetGridData(i, 8));
	    Sum_Adj_Amt = Number(Sum_Adj_Amt)+ (Number(Total) - Number(VAT_Amt));
	   
	}
	//var l_amt = System.Round(Amt,2);
	txtAmtAdj.SetDataText( "" + System.Round(Amt,2));
	txtAdjvatamt.text = "" + System.Round(VAT_Amt,2);
	OnChangeAmt();
  
}*/
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
<!---------------------------------------------------------------------------------------->
 
  <!--gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dbContractdt"/>
                     <input bind="cboCompany"/>
                     <input bind="listccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtExrate2"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data-->
<!--------------------------------------------------------------------------------------->   
<!--gw:data id="dso_get_rate_book" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dbContractdt"/>
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
    </gw:data-->
<!----------------------------------------------------------------------------------------------------->
 <!--gw:data id="dso_get_exrate_list" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="list" procedure="acnt.SP_PRO_GET_BOOKCCY"> 
                <input> 
                     <input bind="cboCompany"/>
                     <input bind="dbContractdt" />
                     <input bind="txtbookccy" />
                </input>
                <output>
                     <output bind="lblBookRate"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data-->
<!--------------------------------------------------------------------------------------------->
<!--gw:data id="dat_gfqc00050_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7,8" function="acnt.sp_sel_gfqc00050_1" procedure="acnt.sp_upd_gfqc00050_3"   > 
            <input bind="GridTerms">                    
                <input bind="txttac_crcontract_pk" /> 
            </input> 
            <output bind="GridTerms" /> 
        </dso> 
    </xml> 
</gw:data-->
<!---------------------------------------------------------------------------------------->
<!--gw:data id="dat_gfqc00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,47,48,49" function="acnt.sp_sel_gfqc00050_2" procedure="acnt.sp_upd_gfqc00050_1">
                <input>
                     <inout bind="txttac_crcontract_pk"  />
                     <inout bind="cboCompany"  />
                     <inout bind="txtCust_pk"  />
                     <inout bind="txtProject_pk"  />
                     <inout bind="txtuser_pk"  />
                     
                     <inout bind="dbContractdt"  />
                     <inout bind="txtContractNo"  />
                     <inout bind="dbWorkingFr"  />
                     <inout bind="dbWorkingto"  />
                     <inout bind="dbConfirmdt"  />
                     
                     <inout bind="txtExrate2"  />
                     <inout bind="txtbook_exrate"  />
                     <inout bind="listccy"  />
                     <inout bind="txtContract_bamt"  />
                     <inout bind="txtContract_bAmtAdj"  />
                     
                     <inout bind="txtContract_bAmt_Final"  />
                     <inout bind="txtContractamount"  />
                     <inout bind="txtAmtAdj"  />
                     <inout bind="txtGrandtotal"  />
                     <inout bind="txtUnitprice"  />
                     
                     <inout bind="txtQuantity"  />
                     <inout bind="lstUnit"  />
                     <inout bind="chkauto_YN"  />
                     <inout bind="lstArea"  />
                     <inout bind="txtContract_bVatamt"  />
                     
                     <inout bind="txtVatamt"  />
                     <inout bind="dbConfirmdt"  />
                     <inout bind="txtVatamt"  />
                     <inout bind="txtAdjvatamt"  />
                     <inout bind="txtVat_bamt"  />
                     
                     <inout bind="txtbAmt_adj"  />
                     <inout bind="txtRemark"  />
                     <inout bind="txtLRemark"  />
                     <inout bind="lstVatrate"  />
                     <inout bind="txtCustto_pk"  />
                     
                     <inout bind="txtProvisionrate"  />
                     <inout bind="txtIndirectcost"  />
                     <inout bind="txtProject_cd"  />
                     <inout bind="txtProject_nm"  />
                     <inout bind="txtCust_id"  />
                     
                     <inout bind="txtCust_nm"  />
                     <inout bind="txtCustto_id"  />
                     <inout bind="txtCustto_nm"  />
                     <inout bind="txtamt5"  />
                     <inout bind="txtTotal"  />
                     
                     <inout bind="txtamt9"  />
                     <inout bind="Totaladj_amt"  />
                     <inout bind="cboStatus"  />
                     <inout bind="txtBudgetCost" />
                     <inout bind="txtProfitrate" />
                 </input>
            </dso>
        </xml>
    </gw:data-->
 <!--------------------------------------------------------------------------->   
 <!--gw:data id="dat_gfqc00050_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"    function="acnt.sp_sel_gfqc00050_3"    > 
            <input bind="GridSearch">                    
                <input bind="txtCustomers_nm" /> 
                <input bind="txtProjects_name" /> 
                <input bind="txtContract_s" /> 
            </input> 
            <output bind="GridSearch" /> 
        </dso> 
    </xml> 
</gw:data-->
<!--------------------------------------------------------------------------->   
 

 <!--gw:data id="dat_gfqc00050_4"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="acnt.sp_sel_gfqc00050_4" procedure="acnt.sp_upd_gfqc00050_2"   > 
            <input bind="GridDetail">                    
                <input bind="txttac_crcontract_pk" /> 
            </input> 
            <output bind="GridDetail" /> 
        </dso> 
    </xml> 
</gw:data-->
<!----------------------------------------------------------------------------->
 <!--gw:data id="dat_gfqc00050_popup" onreceive=""  > 
        <xml>
            <dso  type="process"   procedure="acnt.sp_sel_gfqc00050_popup"  > 
                <input>
                    <input bind="txtProject_pk" />
                </input> 
                <output>
                    <output bind="txtProject_cd" />
                    <output bind="txtProject_nm" />
                </output>
            </dso> 
        </xml> 
   </gw:data-->
<!----------------------------------------------------------------------------->
<table border="1" width="100%">
	<tr>
		<td id="left" width=30% valign=top>
		    
		        <table border="0" width="100%" cellpadding=0 cellspacing=0  id="table5">
		            <tr>
		                <td width=100%>
		                    <fieldset style="width: 96%; height: 100%; padding: 2">
		                         <table border="0" width="100%" cellpadding=0 cellspacing=0  id="table5">
		                            
					                <tr>
						                <td width="10%" align=right><a title="Click here to select Customer" onclick="OnPopUp('cust_search')" href="#tips"
                                                     style="text-decoration: none; color=#0000ff"><b>Customer</b></a></td>
                                        <td width="25%" colspan=2 ><gw:textbox id="txtCustomers_nm" onEnterkey="onSearch(0)" styles="width:98%;" /></td>
						                <td width="1%" align=right><gw:imgbtn id="btnreset1" img="reset" alt="reset" onclick="txtCustomers_nm.text='';" /></td>                                     
					                </tr>
					                <tr>
						                <td width="10%" align=right><a title="Click here to select Project" onclick="OnPopUp('Project')" href="#tips"
                                                     style="text-decoration: none; color=#0000ff"><b>Project</b></a></td>
                                        <td width="25%" colspan=2 ><gw:textbox id="txtProjects_name" onEnterkey="onSearch(0)" styles="width:98%;" /></td>
						                <td width="1%" align=right><gw:imgbtn id="btnreset2" img="reset" alt="Reset" onclick="txtProjects_name.text='';" /></td>                                     
					                </tr>
					                <tr>
						                <td width="10%" align=right>Contract</td>
                                        <td width="25%" colspan=1 ><gw:textbox id="txtContract_s" onenterkey="onSearch(0)" styles="width:98%;" /></td>
						                <td width="1%" align=right><gw:imgbtn id="btnreset3" img="reset" alt="Reset" onclick="txtContract_s.text='';" /></td>  
						                <td width="1%" align=right><gw:imgbtn id="btnSearch" img="Search" alt="Search" onclick="onSearch(0)" /></td>                                     
					                </tr>
					              </table>  
		                     </fieldset>
		                </td>
		            </tr>
					
					<tr>
						<td width="100%"  colspan=4>
						    <gw:grid   
		                        id="GridSearch"  
		                        header="_pk|No|Contract|Project"   
		                        format="0|0|0|0"  
		                        aligns="0|1|0|0"  
		                        defaults="|||"  
		                        editcol="1|1|1|1"  
		                        widths="0|600|1200|1500"  
		                        styles="width:100%; height:440"   
		                        sorting="T"   
		                        oncellclick="onSearch(1)"
		                        onselchange="onSearch(1)"
			                   
		                         /> 
						</td>
                    </tr>
				</table>			
		   
		</td>
		<td id="right" width=70% valign=top>
		<table border="0" cellpadding=0 cellspacing=0 width="100%" id="table4">
			<tr>
				<td colspan="2">
				
					<fieldset style="width: 96%; height: 100%; padding: 2">
					
					<table border="1" width="100%" cellpadding=0 cellspacing=0  id="table5">
						<tr>
							<td width="13%">Company</td>
							<td width="40%" colspan=4 ><gw:list id="cboCompany" styles="width:100%;" /></td>
							<td width="12%" align=right >Status</td>
				            <td width="20%" colspan=5><gw:list id="cboStatus" styles="width:100%;" /></td>
				            <td width="1%" align=right><gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew(0)" /></td>
				            <td width="1%" align=right><gw:imgbtn id="btnsaveMST" img="save" alt="Save" onclick="OnSave()" /></td>
				          
						</tr>
						<tr>
							<td width="13%"><a title="Click here to select Project" onclick="OnPopUp('PL_search')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Project</b></a></td>
							<td width="15%" colspan=2 ><gw:textbox id="txtProject_cd" csstype="mandatory" styles="width:98%;" readonly='true' /><gw:textbox id="txtProject_pk" styles="width:98%;display:none" /></td>
							<td width="25%" colspan=7 ><gw:textbox id="txtProject_nm" csstype="mandatory" styles="width:98%;" readonly='true' /></td>
							<td width="1%" align=right><gw:imgbtn id="btnreset4" img="reset" alt="reset" onclick="txtProject_pk.text ='';txtProject_nm.text ='';txtProject_cd.text ='';" /></td>
						   <td width="10%" colspan=1  align=right><a title="Active"  style="color=#ffff00 "><font color="#000000">
				            Active</font></td>
							<td width="1%" align=right><gw:checkbox id="chkauto_YN" defaultvalue="Y|N" value="Y" onclick="chkChange()" /></td>
				            
				           
						</tr>
						<tr>
							<td width="13%"><a title="Create Date"  style="color=#ffff00 "><font color="#000000">
				            Crt. date</font></td>
							<td width="25%" colspan=2 ><gw:datebox id="dbCrtdt" lang="1"  csstype="mandatory" onkeypress="Upcase()"    styles="width:98%;" /></td>
							<td width="15%" align=right><a title="Approval Date"   style="color=#ffff00 "><font color="#000000">
				            App. date</font></td>
							<td width="25%" colspan=2 ><gw:datebox id="dbAppdt"  nullaccept lang="1"  csstype="mandatory" onkeypress="Upcase()"    styles="width:98%;" /></td>
							 <td width="22%" colspan=3 align=center><a title="Joint Execution"  style="color=#ffff00 "><font color="#000000">
				            Joint Exe.</font></td>
				            <td align=left width="10%" colspan=4><gw:list id="lstJointExe"  styles="width:100%;" /></td>
						</tr>
						<tr>
							<td width="13%"><a title="Project category"  style="color=#ffff00 "><font color="#000000">
				            Prj. category</font></td>
							<td width="25%" colspan=2 ><gw:list id="lstPrjcategory"  styles="width:100%;" /></td>
							
							 <td width="22%" colspan=1 align=right><a title="Project type"  style="color=#ffff00 "><font color="#000000">
				            Project type</font></td>
				            <td align=left width="10%" colspan=9> <gw:list id="lstPrjtype"  styles="width:100%;" /></td>
						</tr>
						<tr>
							<td width="13%"><a title="Site address"  style="color=#ffff00 "><font color="#000000">
				            Site addr.</font></td>
							<td width="90%" colspan=12 ><gw:textbox id="txtsiteAdress" csstype="mandatory" styles="width:99%;"  /></td>
						
						</tr>

						<tr>
							<td width="13%"><a title="Click here to select Organization" onclick="OnPopUp('PL_search')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>Organization</b></a></td>
							<td width="15%" colspan=2 ><gw:textbox id="txtOrganization_cd" csstype="mandatory" styles="width:98%;" readonly='true' /><gw:textbox id="txtOrganization_pk" styles="width:98%;display:none" /></td>
							<td width="25%" colspan=9 ><gw:textbox id="txtOrganization_nm" csstype="mandatory" styles="width:98%;" readonly='true' /></td>
							<td width="1%" align=right><gw:imgbtn id="btnreset4" img="reset" alt="reset" onclick="txtOrganization_pk.text ='';txtOrganization_nm.text ='';txtOrganization_cd.text ='';" /></td>
						   </tr>
						<tr>
							<td width="13%"><a title="Click here to select Project Manager" onclick="OnPopUp('PL_search')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>PM</b></a></td>
							<td width="15%" colspan=2 ><gw:textbox id="txtProject_cd" csstype="mandatory" styles="width:98%;" readonly='true' /><gw:textbox id="txtProject_pk" styles="width:98%;display:none" /></td>
							<td width="21%" colspan=1 ><gw:textbox id="txtProject_nm" csstype="mandatory" styles="width:98%;" readonly='true' /></td>
							<td width="1%" align=right><gw:imgbtn id="btnreset4" img="reset" alt="reset" onclick="txtProject_pk.text ='';txtProject_nm.text ='';txtProject_cd.text ='';" /></td>
						    <td width="5%" align=right><a title="Click here to select Project Controller" onclick="OnPopUp('PL_search')" href="#tips"
                                     style="text-decoration: none; color=#0000ff"><b>PC</b></a></td>
							<td width="17%" colspan=2 ><gw:textbox id="txtProject_cd" csstype="mandatory" styles="width:98%;" readonly='true' /><gw:textbox id="txtProject_pk" styles="width:98%;display:none" /></td>
							<td width="21%" colspan=4 ><gw:textbox id="txtProject_nm" csstype="mandatory" styles="width:98%;" readonly='true' /></td>
							<td width="1%" align=right><gw:imgbtn id="btnreset4" img="reset" alt="reset" onclick="txtProject_pk.text ='';txtProject_nm.text ='';txtProject_cd.text ='';" /></td>
						</tr>

					</table>
					</fieldset>
				</td>
			</tr>
			 <tr style="height: 1%">
				<td style="width: 1%" valign="middle" align="left">
				</td>
				<td colspan="4">
					<gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
						<span value="1" id="1">Contract</span> 
						<span value="2" id="2">Progress/Insurance/Bond</span>
						<span value="3" id="3">Joint Contract</span>
					</gw:radio>
				</td>
				<td align="right" style="white-space: nowrap">
					<a title="ReportType" onclick="OnPopUp('ReportType')" href="#tips" style="color: #0000ff">
						Report Type</a></td>
				<td colspan="5" align="right" style="white-space: nowrap">
					<gw:list id="lstReportType" styles='width:100%;' csstype="mandatory" />
				</td>
				<td style="width: 1%">
					<gw:imgbtn id="btnPOSheet" img="excel" alt="PO Sheet" onclick="OnPrint()" />
				</td>
			</tr>
			 <tr style="height: 1%" id="info">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <table style="width: 100%; height: 100%">
                                            <tr>
                                                <td align="right" style="width: 5%; white-space: nowrap">
                                                    <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="color: #0000ff">
                                                        Supplier</a>
                                                </td>
                                                <td style="width: 45%">
                                                    <gw:textbox id="txtSupplierName" styles="width:100%;" onenterkey="" />
                                                    <gw:textbox id="txtSupplierPK" styles="display:none" />
                                                </td>
                                                <td align="right" style="width: 5%; white-space: nowrap">
                                                    <a onclick="OnPopUp('Bill_To')" href="#tips" style="color: #0000ff">Bill to</a>
                                                </td>
                                                <td style="width: 45%">
                                                    <gw:textbox id="txtBillToName" styles="width:100%;" />
                                                    <gw:textbox id="txtBillToPK" styles="display=none" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td style="width: 5%; white-space: nowrap" align="right">
                                        <a title="SO Master" onclick="OnPopUp('PO')" href="#tips" style="color: #0000ff">Ref
                                            No</a></td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtRefNo" styles="width: 100%" />
                                        <gw:textbox id="txtRefTablePK" styles="width: 100%;display: none" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        Price by
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstPriceBy" styles='width:100%;' csstype="mandatory" onchange="OnChangePriceBy()" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('Currency')" href="#tips" style="color: #0000ff">Currency</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstCurrency" styles="width:100%;" onchange="OnChangePriceBy()" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        P/O Amt
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtPOAmount" type="number" format="#,###,###,###,###.###R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        VAT Amt
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtVATAmount" type="number" format="#,###,###,###,###.###R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        Total Amt
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtTotalAmount" type="number" format="#,###,###,###,###.###R" styles="width:100%;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%" id="shipment">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td align="right" style="width: 5%">
                                        <a title="Deliver" onclick="OnPopUp('Deliver')" href="#tips" style="color: #0000ff">
                                            Deliver</a>
                                    </td>
                                    <td style="width: 65%" colspan="3">
                                        <gw:textbox id="txtDeliverName" styles="width:100%;" onenterkey="" />
                                        <gw:textbox id="txtDeliverPK" styles="display=none" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        Sale Rep
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtSaleRep" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 5%">
                                        <a title="Ship To" onclick="OnPopUp('Ship_To')" href="#tips" style="color: #0000ff">
                                            Ship to</a>
                                    </td>
                                    <td style="width: 65%" colspan="3">
                                        <gw:textbox id="txtShipToName" styles="width:100%;" onenterkey="" />
                                        <gw:textbox id="txtShipToPK" styles="display=none" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        Buy Rep
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtBuyRep" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        ETD
                                    </td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:datebox id="dtETDFrom" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                        ~
                                        <gw:datebox id="dtETDTo" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        ETA
                                    </td>
                                    <td style="width: 30%; white-space: nowrap">
                                        <gw:datebox id="dtETAFrom" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                        ~
                                        <gw:datebox id="dtETATo" lang="<%=Application("Lang")%>" mode="01" nullaccept />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('DeliType')" href="#tips" style="color: #0000ff">Deli Type</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstDeliType" styles="width:100%;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%" id="payment">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" border="0">
                                <tr style="height: 1%">
                                    <td colspan="6">
                                        <table style="height: 100%; width: 100%">
                                            <tr style="height: 1%">
                                                <td align="right" style="width: 5%; white-space: nowrap">
                                                    <a title="PLCenter" onclick="OnPopUp('PLCenter')" style="color: #0000ff; cursor: hand">
                                                        Center</a>
                                                </td>
                                                <td style="width: 45%; white-space: nowrap" colspan="3">
                                                    <gw:textbox id="txtPLCenterPK" styles="display: none" />
                                                    <gw:textbox id="txtCenterPK" styles="display: none" />
                                                    <gw:textbox id="txtCenterCode" styles="width: 30%" />
                                                    <gw:textbox id="txtCenterName" styles="width: 70%" />
                                                </td>
                                                <td align="right" style="width: 5%; white-space: nowrap">
                                                    <a title="PLCenter" onclick="OnPopUp('PLCenter')" style="color: #0000ff; cursor: hand">
                                                        P/L</a>
                                                </td>
                                                <td style="width: 45%; white-space: nowrap">
                                                    <gw:textbox id="txtPLPK" styles="display: none" />
                                                    <gw:textbox id="txtPLCode" styles="width: 30%" />
                                                    <gw:textbox id="txtPLName" styles="width: 70%" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('POType')" href="#tips" style="color: #0000ff">P/O Type</a>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstPOType" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('PaymentTerms')" href="#tips" style="color: #0000ff">Pay Term</a>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstPaymentTerm" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('PaymentMethod')" href="#tips" style="color: #0000ff">Pay Method</a>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:list id="lstPaymentMethod" styles="width:100%;" />
                                    </td>
                                </tr>
                                <tr style="height: 1%">
                                    <td align="right" style="width: 5%; white-space: nowrap">
                                        <a onclick="OnPopUp('Incoterms')" href="#tips" style="color: #0000ff">Price Type</a>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:list id="lstPriceType" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        Ex-Rate
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtExRate" type="number" format="#,###,###,###,###.##R" styles="width:100%;" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        Contract No
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtContractNo" styles="width: 100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
           <tr style="height: 89%">
			 <td colspan="2">
			   <gw:tab id="idTab">
					<table style="width: 100%; height: 100%" name="Contract" id="TabContract"
						align="top" style="overflow: scroll">
					   <tr>
							 <td width="100%" colspan=5>
		                    <fieldset style="width: 96%; height: 100%; padding: 2">
		                    <legend>Customer</legend>
                             <table border="0" width="100%"  cellpadding=0 cellspacing=0 id="table1">
		                <tr>
			                <td width="99%">&nbsp;</td>
			                <td width="4%"><gw:imgbtn id="ibtnNewFree" img="new" alt="New free item" onclick="OnNew(1)"/></td>
			                <td width="4%"><gw:imgbtn id="ibtnNewDetail" img="popup" alt="New Detail" onclick="OnNew(4)"/></td>
		                    <td width="4%"><gw:imgbtn id="ibtnDeleteDetail" img="delete" alt="Delete Detail" onclick="onDelete(1)" /></td>
		                    <td width="4%"><gw:imgbtn id="ibtUnDeleteDetail" img="udelete" alt="UnDelete Detail" onclick="UnDelete()" /></td>
		                    
		                </tr>
		                <tr>
		                    <!--0_PK|1.No|2_TAC_CRCONTRACT_PK|3.Item code|4.Item name|5.UOM|6.Quantity|7.U/Price|8.Amount|9.Vat(%)|10.VAT Amt|11.Adjust|12.Total|13.Remark|14.Local Remark|15_tco_item_pk|16_famt_adj|17_vat_famt|18_famt-->
			                <td colspan=5 width="100%">
			                     <gw:grid   
			                            id="grdCust"  
			                            header="_PK|Seq|License No|Customer Name|Portion|Currency|Contract Amount|VAT Y/N|VAT Amount|Cust_pk"   
			                            format="0|0|0|0|0|0|0|0|0|0"  
			                            aligns="0|3|1|1|2|1|3|1|3|3"  
			                            defaults="0|3|1|1|2|1|3|1|3|3"  
			                            editcol="0|1|1|1|1|1|1|1|1|1"  
			                            widths ="0|800|1500|2500|1000|1000|2000|1000|1000|0"  
			                            styles="width:100%; height:100"   
			                            sorting="T"   
				                        onafteredit="OnEditDetail();OnSumAmt()"  
				                        
				                        oncelldblclick="OnNew(2)"
			                     /> 
			                </td>
		                </tr>
	                </table>
		                </td>
					   </tr>
					    <tr>
							 <td width="100%" colspan=5>
		                    <fieldset style="width: 210%; height: 100%; padding: 2">
		                    <legend>Sum</legend>
                             <gw:grid   
					                    id="grdCustSum" 
					                   
					                    header="Currency|Amount|Exchange rate|VAT Y/N|VAT Amount|Booking Currency Amount"   
					                    format="0|0|0|0|0|0"  
					                    aligns="1|3|3|2|3|3"  
					                    defaults="0|0|0|0|0|0"  
					                    editcol="0|0|0|0|0|0"  
					                    widths="800|1800|2000|1000|1200|3000"  
					                    styles="width:100%; height:60"   
					                    sorting="F"   
						                acceptNullDate="T"
						                onafteredit="OnEdit()"
					                     /> 
		                    </fieldset>
		                </td>
					   </tr>
					     <tr>
							 <td width="100%" colspan=5>
		                 
                               <table border="1" width="98%" cellpadding=0 cellspacing=0>
								<tr>
									<td width="15%">Contract Y/N</td>
									<td width="11%"><gw:list id="cboStatus" styles="width:100%;" /></td>
									<td width="8%">Ex.rate dt</td>
									<td width="18%" colspan="5"><gw:datebox id="dbCrtdt" lang="1" styles="width:98%;" /></td>
									
									<td colspan="3">Contract type</td>
									<td width="22%" colspan="2"><gw:list id="cboStatus" styles="width:100%;" /></td>
								</tr>
								<tr>
									<td width="15%">Contract date</td>
									<td width="11%"><gw:datebox id="dbCrtdt" lang="1" styles="width:98%;" /></td>
									<td width="8%">From</td>
									<td width="6%" colspan="2"><gw:datebox id="dbCrtdt" lang="1" styles="width:98%;" /></td>
									<td width="2%">~</td>
									<td width="10%" colspan="2"><gw:datebox id="dbCrtdt" lang="1" styles="width:98%;" /></td>
									<td colspan="3">Exp. Subcontract amt.</td>
									<td width="22%" colspan="2">&nbsp;</td>
								</tr>
								<tr>
									<td width="15%">Penalty for Delay</td>
									<td width="11%">1 day/week</td>
									<td width="8%">&nbsp;</td>
									<td width="3%">%</td>
									<td width="10%" colspan="3">Maximum</td>
									<td width="5%">&nbsp;</td>
									<td width="2%">%</td>
									<td width="15%" colspan="2">Insured</td>
									<td width="9%">&nbsp;</td>
									<td width="14%">&nbsp;</td>
								</tr>
								<tr>
									<td width="15%" rowspan="4">Payment condition</td>
									<td width="11%">Advance</td>
									<td width="8%">&nbsp;</td>
									<td width="3%">%</td>
									<td width="10%" colspan="3">Remark</td>
									<td width="22%" colspan="4">&nbsp;</td>
									<td width="9%">Budget</td>
									<td width="14%">&nbsp;</td>
								</tr>
								<tr>
									<td width="11%">Progress</td>
									<td width="8%">&nbsp;</td>
									<td width="3%">%</td>
									<td width="10%" colspan="3">Remark</td>
									<td width="22%" colspan="4">&nbsp;</td>
									<td width="9%">Contingency</td>
									<td width="14%">&nbsp;</td>
								</tr>
								<tr>
									<td width="11%">Balance</td>
									<td width="8%">&nbsp;</td>
									<td width="3%">%</td>
									<td width="10%" colspan="3">Remark</td>
									<td width="22%" colspan="4">&nbsp;</td>
									<td width="9%">Profit</td>
									<td width="14%">&nbsp;</td>
								</tr>
								<tr>
									<td width="11%">Retention</td>
									<td width="8%">&nbsp;</td>
									<td width="3%">%</td>
									<td width="10%" colspan="3">&nbsp;</td>
									<td width="5%">&nbsp;</td>
									<td width="16%" colspan="2">&nbsp;</td>
									<td width="1%">&nbsp;</td>
									<td width="9%">&nbsp;</td>
									<td width="14%">&nbsp;</td>
								</tr>

							</table>

		               
		                </td>
					   </tr>
					</table>
			       <table style="width: 100%; height: 100%" name="Progress/Insurance/Bond" id="TabProgress"
						align="top" style="overflow: scroll">
					   <tr>
							<td style="width: 15%" align="right">Active</td>
							<td style="width: 35%"><gw:checkbox id="chkActive" defaultvalue="-1|0" value="-1" onchange="" /></td>
							<td style="width: 15%" align="right">Anniversary</td>
							<td style="width: 35%" align="left"><gw:datebox id="dtbAnniversary" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
						</tr>
					</table>
			        <table style="width: 100%; height: 100%" name="General Info" id="TabGeneralInfo2"
						align="top" style="overflow: scroll">
					   <tr>
							<td style="width: 15%" align="right">Active</td>
							<td style="width: 35%"><gw:checkbox id="chkActive" defaultvalue="-1|0" value="-1" onchange="" /></td>
							<td style="width: 15%" align="right">Anniversary</td>
							<td style="width: 35%" align="left"><gw:datebox id="dtbAnniversary" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
						</tr>
					</table>
			   </gw:tab>
			  </td>
		  </tr>			
			
			
		</table>
		</td>
	</tr>
</table>

<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<gw:textbox id="txttac_crcontract_pk"  styles="width:95%;display:none" /> 
<gw:textbox id="txtuser_pk"  styles="width:95%;display:none" /> 
<gw:textbox id="txtbook_exrate"  styles="width:95%;display:none" /> 
<gw:textbox id="txtbookccy" styles="width:95%;display:none"  /> 
<gw:list id="lstBookExRate" styles="width:100%;display:none" />

<gw:textbox id="txtVat_bamt" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 
<gw:textbox id="txtbAmt_adj" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 

<gw:textbox id="txtContract_bamt" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 
<gw:textbox id="txtContract_bAmtAdj" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 
<gw:textbox id="txtContract_bAmt_Final" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 
<gw:textbox id="txtContract_bVatamt" format="#,###,###,###,###,###,###.##R" type="number" styles="width:95%;display:none" /> 

 
<gw:textbox id="txtexratebook" style="display:none " />
<gw:textbox id="txt_row"        styles='display:none'/>

</body>
</html>
