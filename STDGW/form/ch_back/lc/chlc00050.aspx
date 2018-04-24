<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>APPLICATION PROCESS</title>
</head>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    
    var G1_tpr_poreq_pk     = 0,    
        G1_mr_no            = 1,    
        G1_doc_date         = 2,    
        G1_pl_nm            = 3,   
        G1_line_name        = 4,    
        G1_mrdescription    = 5,    
        G1_tco_company_pk   = 6,    
        G1_tac_abpl_pk      = 7,    
        G1_req_emp_pk       = 8,    
        G1_select           = 9,       
        G1_tpr_poreqd_pk    = 10,    
        G1_tco_item_pk      = 11,    
        G1_item_code        = 12,    
        G1_item_name        = 13,    
        G1_item_unit        = 14,    
        G1_req_qty          = 15,    
        G1_po_qty           = 16,    
        G1_unit_price       = 17,    
        G1_amount           = 18,    
        G1_itemdescription  = 19;
        
    var G2_tpr_purord_pk    = 0,   
        G2_po_date          = 1,   
        G2_po_no            = 2,   
        G2_pl_nm            = 3,   
        G2_incoterm         = 4,   
        G2_payment_form     = 5,   
        G2_payment_term     = 6,   
        G2_po_ccy           = 7,   
        G2_ex_rate          = 8,   
        G2_po_amt           = 9,   
        G2_vat_amt          = 10,   
        G2_po_tot_amt       = 11,   
        G2_tac_abpl_pk      = 12,   
        G2_tco_company_pk   = 13,   
        G2_tpr_purordd_pk   = 14,   
        G2_tpr_poreqd_pk    = 15,   
        G2_tco_item_pk      = 16,   
        G2_select           = 17,    
        G2_item_code        = 18,   
        G2_item_name        = 19,   
        G2_item_unit        = 20,   
        G2_po_qty           = 21,   
        G2_pur_lot          = 22,   
        G2_po_lotqty        = 23,   
        G2_item_price       = 24,    
        G2_lot_price        = 25,   
        G2_po_amt           = 26,   
        G2_vat_rate         = 27,   
        G2_total_amt        = 28,   
        G2_etd_date         = 29,   
        G2_eta_date         = 30,   
        G2_description      = 31;
        
    var G3_tin_mattakein_pk = 0,    
        G3_slip_no          = 1,    
        G3_doc_date         = 2,    
        G3_description      = 3,    
        G3_tin_mattakeind_pk = 4,    
        G3_tpr_purordd_pk   = 5,    
        G3_takein_date      = 6,    
        G3_takein_wh_pk     = 7,    
        G3_wh_name          = 8,    
        G3_tco_item_pk      = 9,    
        G3_item_code        = 10,    
        G3_item_name        = 11,   
        G3_item_unit        = 12,    
        G3_tpr_lotno_pk     = 13,    
        G3_lot_no           = 14,    
        G3_takein_qty       = 15,    
        G3_item_price       = 16,    
        G3_takein_amount    = 17,   
        G3_ccy              = 18,    
        G3_description      = 19;
         
 //---------------------------------------------------------
 function BodyInit()
 {

      txt_user_pk.text = user_pk;
      //---------------------- 
      dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
      dtTakeInDate.SetDataText(System.AddDate(dtTo.GetData(),-7));
      dtPODate.SetDataText(System.AddDate(dtTo.GetData(),-7));
      
      //----------------------
      BindingDataList();
      OnFormatGrid();
    } 
 //---------------------------------------------------------
 
 function BindingDataList()
 {
    var data ;
    
    data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0  ORDER BY wh_name  ASC" )%>";    
    data = data + "||Select All";
    lstWH.SetDataText(data); 
    lstWH.value='';
    
     //----------------------- 
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACCR0020' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>";  //payment term
     grdDetailPO.SetComboFormat(G2_payment_form,data); 
     //----------------------- 
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACCR0140' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ")%>";  //payment term
     grdDetailPO.SetComboFormat(G2_payment_term,data); 
     //----------------------- 
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACAB0110' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " )%>";    
     grdDetailPO.SetComboFormat(G2_po_ccy,data);   
     //----------------------- 
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='COCI0200' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM " )%>";    
     grdDetailPO.SetComboFormat(G2_incoterm,data); 
     //-----------------------     
 }        
 
 //------------------------------------------------------------------------------------------------
 function OnFormatGrid()
 {
    var ctrl ;
    ctrl = grdDetailMR.GetGridControl();
    grdDetailMR.GetGridControl().FrozenCols  = G1_select  ;
    ctrl.ColFormat(G1_req_qty)   = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_po_qty)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G1_unit_price)= "###,###,###,###,###.##";
    ctrl.ColFormat(G1_amount)    = "###,###,###,###,###.##";
    //-----------------------------------------------------
    ctrl.MergeCells  = 2 ;	    
    ctrl.MergeCol(G1_tpr_poreq_pk)       = true ;	
    ctrl.MergeCol(G1_mr_no)         = true ; 
    ctrl.MergeCol(G1_doc_date)         = true ;
    ctrl.MergeCol(G1_tac_abpl_pk)      = true ;	
    ctrl.MergeCol(G1_pl_nm)  = true ; 
    ctrl.MergeCol(G1_line_name)  = true ;
    ctrl.MergeCol(G1_req_emp_pk)        = true ;	
    ctrl.MergeCol(G1_mrdescription)  = true ;

    ctrl = grdDetailPO.GetGridControl();
    grdDetailPO.GetGridControl().FrozenCols  = G2_incoterm ;
    ctrl.ColFormat(G2_ex_rate)   = "###,###,###,###,###.##";
    ctrl.ColFormat(9)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_vat_amt)   = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_po_tot_amt)= "###,###,###,###,###.##";  
    ctrl.ColFormat(G2_po_qty)   = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_po_lotqty) = "###,###,###,###,###.##";
    ctrl.ColFormat(G2_item_price)= "###,###,###,###,###.##";
    ctrl.ColFormat(G2_lot_price) = "###,###,###,###,###.##";    
    ctrl.ColFormat(G2_po_amt)    = "###,###,###,###,###.##"; 
    ctrl.ColFormat(G2_vat_rate)  = "###,###,###,###,###.##"; 	
    ctrl.ColFormat(G2_total_amt) = "###,###,###,###,###.##"; 
 
    //-----------------------------------------------------
    ctrl.MergeCells  = 2 ;	
    ctrl.MergeCol(G2_tpr_purord_pk) = true ;	
    ctrl.MergeCol(G2_po_date)       = true ;	
    ctrl.MergeCol(G2_po_no)         = true ; 
    ctrl.MergeCol(G2_pl_nm)         = true ;
    ctrl.MergeCol(G2_incoterm)      = true ;	
    ctrl.MergeCol(G2_payment_form)  = true ; 
    ctrl.MergeCol(G2_payment_term)  = true ;
    ctrl.MergeCol(7)        = true ;	
    ctrl.MergeCol(8)       = true ; 
    ctrl.MergeCol(9)        = true ;
    ctrl.MergeCol(10)       = true ;	
    ctrl.MergeCol(G2_po_tot_amt)    = true ; 
    
    ctrl = grdDetailTakeIn.GetGridControl();
    grdDetailTakeIn.GetGridControl().FrozenCols  = G3_tco_item_pk ;
    ctrl.ColFormat(G3_takein_qty)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G3_item_price)    = "###,###,###,###,###.##";
    ctrl.ColFormat(G3_takein_amount) = "###,###,###,###,###.##";
     //-----------------------------------------------------
    ctrl.MergeCells  = 3 ;	
    ctrl.MergeCol(G3_tin_mattakein_pk) = true ;	
    ctrl.MergeCol(G3_slip_no)          = true ; 
    ctrl.MergeCol(G3_doc_date)         = true ;
    ctrl.MergeCol(3)      = true ;	
 }

 //---------------------------------------------------------
 function OnSearch(pos)
 {
       switch (pos)         
      {		        
            case 0 :
                data_epbp00100_1.Call("SELECT");
            break;             
            case 1 :
                data_epbp00100_2.Call("SELECT"); 
            break;             
            case 2 :
                data_epbp00100_3.Call("SELECT"); 
            break;
      }  
 }
//-------------------------------------------------------------
 function OnDataReceive(po_oData)
 {
    switch( po_oData.id)
    {
        case 'data_epbp00100_4':
            data_epbp00100_2.Call('');
        break;
        case 'data_epbp00100_5':
            data_epbp00100_3.Call('');
        break;
    }    
 } 
 //--------------------------------------------------------- 
 function OnSave(pos)
 {
      switch (pos)         
      {		        
            case 1 :
                data_epbp00100_4.Call('');
            break;
            case 2 :
            
                for(i=1; i<grdDetailTakeIn.rows; i++)
                {
                    grdDetailTakeIn.SetGridText(i, G3_takein_wh_pk, lsWH.value );
                }
                data_epbp00100_5.Call('');
            break;
      }  
 }
 //---------------------------------------------------------
 function OnEditPO()
 {                   
    var po_no = grdDetailPO.GetGridData(grdDetailPO.row,G2_po_no);
    var fpath = System.RootURL + "/form/ch/lc/chlc00051.aspx?po_no=" + po_no; //customs
                
    aValue = System.OpenModal( fpath , 950 , 600, 'resizable:yes;status:yes',this);
    
    if ( aValue != null )
    {    
        txtPONo.text =  aValue[0];
        dtPODate.value = aValue[1];
        data_epbp00100_2.Call('SELECT');         
    }
 }
 //---------------------------------------------------------
 function OnEditTakeIn()
 {
    var slip_no = grdDetailTakeIn.GetGridData(grdDetailTakeIn.row,G3_slip_no );
    var fpath = System.RootURL + "/form/ch/lc/chlc00052.aspx?slip_no=" + slip_no; //customs
                
    aValue = System.OpenModal( fpath , 950 , 600, 'resizable:yes;status:yes',this);
    
    if ( aValue != null )
    {    
        txtTakeInNo.text = aValue[0]; 
        dtTakeInDate.value = aValue[1]; 
        data_epbp00100_3.Call('SELECT');       
    }
 }
 //---------------------------------------------------------
 function onProcess(index)
 {
    switch(index)
    {
        case 0:
            if(Validate(0))
            {
                var fpath = System.RootURL + "/form/ch/lc/chlc00053.aspx"; 
                
                aValue = System.OpenModal( fpath , 950 , 600, 'resizable:yes;status:yes',this);
                
                if ( aValue != null )
                {    
                    txtPONo.text =  aValue[0];
                    dtPODate.value = aValue[1];
                    data_epbp00100_2.Call('SELECT');         
                }
            }	
        
        break;
        case 1:
            if(Validate(1))
            {
                var fpath = System.RootURL + "/form/ch/lc/chlc00054.aspx"; 
                
                aValue = System.OpenModal( fpath , 850 , 600, 'resizable:yes;status:yes',this);
                
                if ( aValue != null )
                {     
                    txtTakeInNo.text = aValue[0]; 
                    dtTakeInDate.value = aValue[1]; 
                    data_epbp00100_3.Call('SELECT');     
                }	
            } 
        break;
    }
 }
 //-----------------------------------------------------------------------------
 function Validate(index)
 {
    var ischeck=0;
    switch(index)
    {
        case 0:
            for(i=1; i< grdDetailMR.rows; i++)
            {
                if(grdDetailMR.GetGridData(i,G1_select) =='-1')
                {
                    ischeck = 1;
                    break;
                }
            }
            if(ischeck ==0)
            {
                alert("Please check Item to make PO!");
                return false;
            }
        break;
        
        case 1:
            for(i=1; i< grdDetailPO.rows; i++)
            {
                if(grdDetailPO.GetGridData(i,G2_select) =='-1')
                {
                    ischeck = 1;
                    break;
                }
            }
            if(ischeck ==0)
            {
                alert("Please check Item to Take in!");
                return false;
            }
        break;
        
       
    }
     return true;
 }
 //----------------------------------------------------------------------------- 
function OnToggle()
{
    var trMR = document.all("trMR"); 
    var trPO = document.all("trPO"); 
    var trTakein = document.all("trTakein"); 
    var imgArrow = document.all("imgArrow"); 
    var tdSrchMR = document.all("tdSrchMR"); 
    var tdMakePO = document.all("tdMakePO"); 
    var tdtxtMRNo = document.all("tdtxtMRNo"); 
    var trReqDate = document.all("trReqDate"); 
    var trReqDate1 = document.all("trReqDate1");
    var tdReqNo = document.all("tdReqNo"); 
  
    if(imgArrow.status == "expand"){
    trMR.style.display="none";
    tdSrchMR.style.display="none"; 
    tdMakePO.style.display="none";  
    tdtxtMRNo.style.display="none"; 
    tdReqNo.style.display="none";
    trReqDate.style.display="none";
    trReqDate1.style.display="none";
    imgArrow.status = "collapse";
    trPO.style.width="48%";
    trTakein.style.width="48%";     
    imgArrow.src = "../../../system/images/down_orange.gif";
    }
    else{
    trMR.style.display="";
    tdSrchMR.style.display=""; 
    tdMakePO.style.display="";  
    tdtxtMRNo.style.display=""; 
    tdReqNo.style.display="";
    trReqDate.style.display="";
    trReqDate1.style.display="";
    imgArrow.status = "expand";
    trPO.style.width="32%";
    trTakein.style.width="32%"; 
    imgArrow.src = "../../../system/images/up_orange.gif";
    }
}
//----------------------------------------------------------------------------- 
function OnToggle1()
{
    var trMR = document.all("trMR"); 
    var trPO = document.all("trPO"); 
    var trTakein = document.all("trTakein"); 
    var imgArrow = document.all("imgArrow1"); 

    if(imgArrow.status == "expand"){
    trTakein.style.display="none";
    imgArrow.status = "collapse";
    trPO.style.width="48%";
    trMR.style.width="48%"; 
    imgArrow.src = "../../../system/images/up_orange.gif";
    }
    else{
    trTakein.style.display="";
    imgArrow.status = "expand";
    trPO.style.width="32%";
    trMR.style.width="32%"; 
    imgArrow.src = "../../../system/images/down_orange.gif";
    }
}
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  function="prod.sp_sel_epbp00100_1" > 
                <input bind="grdDetailMR">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtMRNo" />               
                </input> 
                <output bind="grdDetailMR" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00100_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  function="prod.sp_sel_epbp00100_2" > 
                <input bind="grdDetailPO">   
                    <input bind="dtPODate" /> 
                    <input bind="dtPOTo" />
                    <input bind="txtPONo" />           
                </input> 
                <output bind="grdDetailPO" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_epbp00100_3" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" user="prod"  function="prod.sp_sel_epbp00100_3" > 
                <input bind="grdDetailTakeIn">    
                    <input bind="dtTakeInDate" />
                    <input bind="dtTakeInDateTo" />
                    <input bind="txtTakeInNo" />  
                    <input bind="lstWH" />             
                </input> 
                <output bind="grdDetailTakeIn" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" valign="middle">
                <img status="expand" id="imgArrow" src="../../../system/images/up_orange.gif"
                    style="cursor: hand;" onclick="OnToggle()" />
            </td>
            <td style="width: 10%; color: BlueViolet; white-space: nowrap" align="left">
                Request Info.</td>
            <td id="trReqDate" align="right" style="width: 10%; white-space: nowrap">
                Req Date</td>
            <td id="trReqDate1" style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" />
                ~
                <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" />
            </td>
            <td id="tdReqNo" style="width: 10%; white-space: nowrap" align="right">
                Req No
            </td>
            <td id="tdtxtMRNo" style="width: 15%" align="right">
                <gw:textbox id="txtMRNo" text="" styles='width:100%;' onenterkey="dat_epac00030_7.Call('SELECT');" />
            </td>
            <td style="width: 10%">
            </td>
            <td id="tdMakePO" style="width: 15%" align="right">
                <gw:icon id="btnCrtPO" styles='width:100%' text="Purchase" onclick="onProcess(0)" />
            </td>
            <td style="width: 4%">
            </td> 
            <td id="tdSrchMR" style="width: 1%" align="right">
                <gw:imgbtn id="ibtnSearchMR" img="search" alt="Search" onclick="OnSearch(0)" />
            </td>
        </tr>
        <tr style="height: 32%" id="trMR">
            <td colspan="10">
                <gw:grid id='grdDetailMR' header='_Tpr_Poreq_Pk|Req. No|Req. Date|_PL Nm|_Line Name|Req. Description|_Tco_Company_Pk|_Tac_Abpl_Pk|_Req_Emp_Pk|Select|_Tpr_Poreqd_Pk|_Tco_Item_Pk|Item Code|Item Name|Unit|Req. Qty|Po Qty|Unit Price|Amount|Itemdescription'
                    format='0|0|4|0|0|0|0|0|0|3|0|0|0|0|2|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3|3|0'
                    defaults='|||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|1200|1500|1200|1500|0|0|700|0|0|0|1500|2000|1000|1200|1200|1200|1200|2000'
                    sorting='T' styles='width:100%; height:100%' />
            </td>
        </tr>
        <tr style="height: 2%">
            <td style="width: 5%">
            </td>
            <td style="width: 10%; color: BlueViolet; white-space: nowrap" align="left">
                Purchasing Info.</td>
            <td style="width: 10%" align="right" nowrap>
                Purchasing Dt</td>
            <td style="width: 20%; white-space: nowrap" align="left">
                <gw:datebox id="dtPODate" lang="<%=Session("Lang")%>" />
                ~
                <gw:datebox id="dtPOTo" lang="<%=Session("Lang")%>" />
            </td>
            <td align="right" style="width: 10%; white-space: nowrap">
                Purchasing No</td>
            <td style="width: 15%">
                <gw:textbox id="txtPONo" text="" styles='width:100%;' />
            </td>
            <td style="width: 10%">
            </td>
            <td align="right" style="width: 15%">
                <gw:icon id="btnCrtTakeIn" styles='width:100%' text="Deliver" onclick="onProcess(1)" />
            </td>
            <td style="width: 4%">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="ibtnSearchPO" img="search" alt="Search" onclick="OnSearch(1)" />
            </td>
        </tr>
        <tr style="height: 32%" id="trPO">
            <td colspan="10">
                <gw:grid id='grdDetailPO' header='_Tpr_Purord_Pk|Slip Date|Slip No|_PL Nm|_Incoterm|_Payment Form|_Payment Term|_PO CCY|_Ex Rate|Amt|Vat Amt|Total Amt|_Tac_Abpl_Pk|_Tco_Company_Pk|_Tpr_Purordd_Pk|_Tpr_Poreqd_Pk|_Tco_Item_Pk|Select|Item Code|Item Name|Unit|Qty|_Pur Lot|_PO Lot qty|Item Price|_Lot Price|Amt|Vat Rate|Total Amt|_ETD Date|_ETA Date|Description'
                    format='0|4|0|0|2|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0|0|4|4|0' aligns='0|0|0|0|0|0|0|0|0|3|3|3|3|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3|0|0|0'
                    defaults='|||||||||||||||||||||||||||||||' editcol='0|0|0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|1200|1500|1500|1500|1300|1300|1300|1300|1300|1300|1400|0|0|0|0|0|800|1500|2000|800|1400|1200|1500|1500|1500|1500|1500|1500|1200|1200|2000'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="OnEditPO()"/>
            </td>
        </tr>
        <tr style="height: 1%">
            <td style="width: 5%" valign="middle">
                <img status="expand" id="imgArrow1" src="../../../system/images/down_orange.gif"
                    style="cursor: hand;" onclick="OnToggle1()" />
            </td>
            <td style="width: 10%; color: BlueViolet; white-space: nowrap" align="left">
                Delivery Info</td>
            <td style="width: 10%" align="right">
                Voucher Date</td>
            <td style="width: 20%; white-space: nowrap" align="left">
                <gw:datebox id="dtTakeInDate" lang="<%=Session("Lang")%>" />
                ~
                <gw:datebox id="dtTakeInDateTo" lang="<%=Session("Lang")%>" />
            </td>
            <td align="right" style="width: 10%; white-space: nowrap">
                Voucher No</td>
            <td style="width: 15%">
                <gw:textbox id="txtTakeInNo" text="" styles='width:100%;' />
            </td>
            <td align="right" style="width: 10%">
                
            </td>
            <td style="width: 15%">
                <gw:list id="lstWH" styles='width:100%;display:none' />
            </td>
            <td style="width: 4%">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="ibtnSearchTakeIn" img="search" alt="Search" onclick="OnSearch(2)" />
            </td>
        </tr>
        <tr style="height: 32%" id="trTakein">
            <td colspan="10">
                <gw:grid id='grdDetailTakeIn' header='_Tin_Mattakein_Pk|Slip No|Slip Date|Description|_Tin_Mattakeind_Pk|_Tpr_Purordd_Pk|Receive Date|_Takein_Wh_Pk|_Wh_Name|_Tco_Item_Pk|Item Code|Item Name|Item Unit|_Tpr_Lotno_Pk|_Lot No|Receive Qty|Item Price|Takein Amount|Ccy|Description'
                    format='0|0|4|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|3|0|0'
                    defaults='|||||||||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='0|1500|1200|1500|0|0|1200|0|1500|0|1500|2000|1000|0|1300|1300|1300|1500|1200|1500'
                    sorting='T' styles='width:100%; height:100%' oncelldblclick="OnEditTakeIn()"/>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
   
 <gw:textbox id="txt_user_pk" styles="width: 100%;display: none" />
    <!------------------------------------------------------------------>
</body>
</html>
