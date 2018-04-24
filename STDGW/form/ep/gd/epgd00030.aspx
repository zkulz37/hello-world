<%@ Page Language="C#" %>

<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Export Declaration</title>
</head>
 <%ESysLib.SetUser("comm");%>
<script language="javascript" type="text/javascript">
	var flag, is_unit_change=0;
	var action, isStart, rowchange;
	var strcodereturn, indexCode;
    action='select';
	flag=0;
	isStart=1;
	
	var G1_pk           = 0,  
	    G1_rownum       = 1,  
	    G1_order_no     = 2,  
	    G1_item_code    = 3,  
	    G1_item_name    = 4,  
	    G1_hs_code      = 5,  
	    G1_unit_cd      = 6,  
	    G1_unit_packing = 7, 
	    G1_unit_weight  = 8,  
	    G1_u_price      = 9,  
	    G1_qty          = 10,  
	    G1_qty_packing  = 11,  
	    G1_net_weight   = 12,  
	    G1_gross_weight = 13,  
	    G1_ext_price    = 14,  
	    G1_re_ext_price = 15,  
	    G1_net_tr_amt   = 16,  
	    G1_net_bk_amt   = 17,  
	    G1_tex_decl_mst_pk  = 18,  
	    G1_tco_item_pk      = 19,  
	    G1_tex_cinv_dtl_pk  = 20,  
	    G1_tex_order_pk     = 21,  
	    G1_item_origin      = 22,  
	    G1_cnv_ratio        = 23,   
	    G1_tran_rate        = 24,  
	    G1_weight_rate      = 25;
	    
var     G2_pk               = 0,
        G2_rownum           = 1,     
        G2_item_code        = 2,     
        G2_im_tax_calc_amt  = 3,     
        G2_re_im_tax_calc_amt = 4,     
        G2_adjamt           = 5,     
        G2_im_tax_rate      = 6,     
        G2_im_tax_amt       = 7,     
        G2_re_im_tax_amt    = 8,     
        G2_im_tax_bk_amt    = 9,     
        G2_im_tax_tr_amt    = 10,     
        G2_exc_amt          = 11,     
        G2_exc_rate         = 12,     
        G2_adjexc           = 13,     
        G2_re_exc_amt       = 14,     
        G2_exc_bk_amt       = 15,     
        G2_exc_tr_amt       = 16,     
        G2_vat_amt          = 17,     
        G2_vat_rate         = 18,     
        G2_adjvat           = 19,     
        G2_re_vat_amt       = 20,     
        G2_vat_bk_amt       = 21,     
        G2_vat_tr_amt       = 22,     
        G2_ot_tax_calc_amt  = 23,     
        G2_ot_tax_rate      = 24,     
        G2_ot_tax_amt       = 25,     
        G2_re_ot_tax_amt    = 26,     
        G2_ot_tax_bk_amt    = 27,     
        G2_ot_tax_tr_amt    = 28;	    
	    
function BodyInit()
 {       
    System.Translate(document);  // Translate to language session
    
    grdDetails.GetGridControl().FrozenCols = G1_unit_cd;
    BindingDataList();
    onNew();
    
    FormatDetail(grdDetails);
    FormatDetail(grdDetails1);
    txtMasterPK.text="<%=Request["decl_pk"]%>" 
    
    if(txtMasterPK.text!='')
    {            
        action='view';
        dat_epgd00030_1.Call('SELECT');
    }
   // dat_epgd00030_18.Call();
 }
//----------------------------------------------------------------------------
 function BindingDataList()
 {   
     var data2 = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE_NM FROM comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b WHERE a.TCO_ABCODEGRP_PK = b.PK and b.ID = 'IEBD0020' and a.DEL_IF = 0 and b.DEL_IF = 0 and GRP_CODE = 'EX' order by CODE_NM")%>";  //Declaration type 
     var data3 = "<%=ESysLib.SetListDataFUNC("SELECT Upper(comm.F_COMMONCODE('IEAB0010','','')) FROM DUAL")%>";  //trade term
     var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //tradding 
     var data6 = "<%=ESysLib.SetListDataFUNC("SELECT INITCAP(comm.F_COMMONCODE('ACCR0140','','')) FROM DUAL")%>";  //payment term         
     var data8 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
     var data7 = "<%=ESysLib.SetListDataSQL("select v.pk, v.COUNTRY_NM from imex.tie_country v where del_if=0 order by 2")%>";  //country
                              
     cboDeclType.SetDataText(data2);
     cboTradeTerms.SetDataText(data3); 
     cboPayCurr.SetDataText(data4);  
     cboPayMethod.SetDataText(data6);       
     cboCompany.SetDataText(data8);
     cboExpGate.SetDataText(data7);
     cboImpCountry.SetDataText(data7);
     cboPayCurr.value='USD';
     //cboTransType.SetDataText(data5);
     <%=ESysLib.SetGridColumnComboFormat("grdDetails", 6 , "select a.UOM_CODE,a.UOM_NM from comm.tco_uom a where del_if=0 order by a.UOM_NM ")%>; 
     <%=ESysLib.SetGridColumnComboFormat("grdDetails", 7 , "select a.UOM_CODE,a.UOM_NM from comm.tco_uom a where del_if=0 order by a.UOM_NM")%>; 
     <%=ESysLib.SetGridColumnComboFormat("grdDetails", 8 , "select a.UOM_CODE,a.UOM_NM from comm.tco_uom a where del_if=0 and upper(DIMENSION_TYPE)='WET' order by a.UOM_NM")%>; 
     
     <%=ESysLib.SetGridColumnComboFormat("grdDetails1", 6, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0050' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
    <%=ESysLib.SetGridColumnComboFormat("grdDetails1", 12, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0050' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
    <%=ESysLib.SetGridColumnComboFormat("grdDetails1", 18, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0050' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
    <%=ESysLib.SetGridColumnComboFormat("grdDetails1", 24, "select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b where TCO_ABCODEGRP_PK=b.pk and b.id='IEBD0050' and a.del_if=0 and b.del_if=0 order by a.CODE ")%>; 
 }
 //-------------------------------------------------------------------
function FormatDetail(Grid)
{ 
    var ctrl=Grid.GetGridControl();
    switch(Grid.id) 
    {
	    case "grdDetails":
	        ctrl.ColFormat(G1_qty)   = "###,###,###,###,###.##";
	        ctrl.ColFormat(G1_qty_packing)   = "###,###,###,###,###.##";
	        ctrl.ColFormat(G1_net_weight)   = "###,###,###,###,###.##";
	        ctrl.ColFormat(G1_gross_weight)   = "###,###,###,###,###.##";
	        ctrl.ColFormat(G1_ext_price)   = "###,###,###,###,###.##";
	        
		    if(txtPayCurr.GetData()=='VND')
		    {
		        ctrl.ColFormat(G1_u_price)   = "###,###,###,###,###";			    
			    ctrl.ColFormat(G1_ext_price)   = "###,###,###,###,###";
			    ctrl.ColFormat(G1_re_ext_price)   = "###,###,###,###,###";
			    ctrl.ColFormat(G1_net_tr_amt)   = "###,###,###,###,###";
			    ctrl.ColFormat(G1_net_bk_amt)   = "###,###,###,###,###";
		    }
		    else
		    {
		        ctrl.ColFormat(G1_u_price)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(G1_ext_price)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(G1_re_ext_price)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(G1_net_tr_amt)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(G1_net_bk_amt)   = "###,###,###,###,###.##";
		    }
	    break;
	    case "grdDetails1":
		    if(txtPayCurr.GetData()=='VND')
		    {
			    ctrl.ColFormat(3)   = "###,###,###,###,###";
			    ctrl.ColFormat(4)   = "###,###,###,###,###";
			    ctrl.ColFormat(5)   = "###,###,###,###,###";
			    ctrl.ColFormat(6)   = "###,###,###,###,###";
			    ctrl.ColFormat(7)   = "###,###,###,###,###";
			    ctrl.ColFormat(8)   = "###,###,###,###,###";
			    ctrl.ColFormat(9)   = "###,###,###,###,###";
			    ctrl.ColFormat(10)   = "###,###,###,###,###";
			    ctrl.ColFormat(11)   = "###,###,###,###,###";
			    ctrl.ColFormat(12)   = "###,###,###,###,###";
			    ctrl.ColFormat(13)   = "###,###,###,###,###";
			    ctrl.ColFormat(14)   = "###,###,###,###,###";
			    ctrl.ColFormat(15)   = "###,###,###,###,###";
			    ctrl.ColFormat(16)   = "###,###,###,###,###";
			    ctrl.ColFormat(17)   = "###,###,###,###,###";
			    ctrl.ColFormat(18)   = "###,###,###,###,###";
			    ctrl.ColFormat(19)   = "###,###,###,###,###";
			    ctrl.ColFormat(20)   = "###,###,###,###,###";
			    ctrl.ColFormat(21)   = "###,###,###,###,###";
			    ctrl.ColFormat(22)   = "###,###,###,###,###";
			    ctrl.ColFormat(23)   = "###,###,###,###,###";
			    ctrl.ColFormat(24)   = "###,###,###,###,###";
			    ctrl.ColFormat(25)   = "###,###,###,###,###";
			    ctrl.ColFormat(26)   = "###,###,###,###,###";
			    ctrl.ColFormat(27)   = "###,###,###,###,###";
			    ctrl.ColFormat(28)   = "###,###,###,###,###";
		    }
		    else
		    {
			    ctrl.ColFormat(3)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(4)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(5)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(6)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(7)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(8)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(9)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(10)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(11)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(12)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(13)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(14)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(15)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(16)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(17)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(18)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(19)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(20)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(21)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(22)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(23)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(24)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(25)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(26)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(27)   = "###,###,###,###,###.##";
			    ctrl.ColFormat(28)   = "###,###,###,###,###.##";
		    }
	    break;
	}
} 
  //--------------------------------------------------------------------------------------
function SetStatus(index)
{
    txtSeqNo.SetEnable(false);
    txtTransImport.SetEnable(false);
    txtCalcImport.SetEnable(false);
    txtTransExcise.SetEnable(false);	
    txtCalcExcise.SetEnable(false);
    txtTransVAT.SetEnable(false);	
    txtCalcVAT.SetEnable(false);	
    txtTransOtherTax.SetEnable(false);	
    txtCalcOtherTax.SetEnable(false);
    txtTransTotalTax.SetEnable(false);	
    txtCalcTotalTax.SetEnable(false);
    txtTransTotalNet.SetEnable(false); 
    txtCalcTotalNet.SetEnable(false);   
    
    txtCalcTotalNet1.SetEnable(false);	
    txtTransTotalNet1.SetEnable(false);	
    txtTransImport1.SetEnable(false);
    txtCalcImport1.SetEnable(false);
    txtTransExcise1.SetEnable(false);	
    txtCalcExcise1.SetEnable(false);
    txtTransVAT1.SetEnable(false);
    txtCalcVAT1.SetEnable(false);
    txtTransOtherTax1.SetEnable(false);
    txtCalcOtherTax1.SetEnable(false);	
    txtTransTotalTax1.SetEnable(false);	
    txtCalcTotalTax1.SetEnable(false);
    
    switch(index)
    {
        case '4':
            //view form
            btnSearch.style.display="none";
            btnNew.style.display="none";
            btnSave.style.display="none";
            btnDel.style.display="none";
            btnExcel.style.display="none";
            btnConfirm.style.display="none";
            btnCancel.style.display="none";
            btnRegenerate.style.display="none";
            btnCopy.style.display="none";
            
            btnSearchItem.style.display="none";   
            btnSaveItem.style.display="none"; 
            btnDelItem.style.display="none";  
            btnRefreshItem.style.display="none"; 
            btnCalcSave.style.display="none";
            
            grdDetails.SetColEdit(G1_u_price,0);
            grdDetails.SetColEdit(G1_qty,0);
            grdDetails.SetColEdit(G1_gross_weight,0);
            grdDetails.SetColEdit(G1_re_ext_price,0);
            
            grdDetails1.SetColEdit(4,0);
            grdDetails1.SetColEdit(6,0);
            grdDetails1.SetColEdit(8,0);
            grdDetails1.SetColEdit(12,0);
            grdDetails1.SetColEdit(14,0);
            grdDetails1.SetColEdit(18,0);
            grdDetails1.SetColEdit(20,0);
            grdDetails1.SetColEdit(24,0);
            grdDetails1.SetColEdit(26,0);
        break;
        case '3':
            //Cancelled	Chỉ hiển thị : Popup,New,Regenerate button
            btnSearch.style.display=""; 
            btnNew.style.display="";
            btnSave.style.display="none"; 
            btnDel.style.display="none"; 
            btnExcel.style.display="none"; 
            btnConfirm.style.display="none"; 
            btnCancel.style.display="none"; 
            btnRegenerate.style.display=""; 
            btnCopy.style.display="none";
            
            btnSearchItem.style.display="none";   
            btnSaveItem.style.display="none"; 
            btnDelItem.style.display="none";  
            btnRefreshItem.style.display="none"; 
            btnCalcSave.style.display="none";
            
            grdDetails.SetColEdit(G1_u_price,0);
            grdDetails.SetColEdit(G1_qty,0);
            grdDetails.SetColEdit(G1_gross_weight,0);
            grdDetails.SetColEdit(G1_re_ext_price,0);
            
            grdDetails1.SetColEdit(4,0);
            grdDetails1.SetColEdit(6,0);
            grdDetails1.SetColEdit(8,0);
            grdDetails1.SetColEdit(12,0);
            grdDetails1.SetColEdit(14,0);
            grdDetails1.SetColEdit(18,0);
            grdDetails1.SetColEdit(20,0);
            grdDetails1.SetColEdit(24,0);
            grdDetails1.SetColEdit(26,0);
        break;
        case '2':
            //Approved	Chỉ hiển thị : Popup,New,Copy,Cancel,Print button

            btnSearch.style.display=""; 
            btnNew.style.display="";
            btnSave.style.display=""; 
            btnDel.style.display="none"; 
            btnExcel.style.display=""; 
            btnConfirm.style.display="none"; 
            btnCancel.style.display=""; 
            btnRegenerate.style.display="none"; 
            btnCopy.style.display="";
            
            btnSearchItem.style.display="none";   
            btnSaveItem.style.display="none"; 
            btnDelItem.style.display="none";  
            btnRefreshItem.style.display="none"; 
            btnCalcSave.style.display="none";
                           
            grdDetails.SetColEdit(G1_u_price,0);
            grdDetails.SetColEdit(G1_qty,0);
            grdDetails.SetColEdit(G1_gross_weight,0);
            grdDetails.SetColEdit(G1_re_ext_price,0);
            
            grdDetails1.SetColEdit(4,0);
            grdDetails1.SetColEdit(6,0);
            grdDetails1.SetColEdit(8,0);
            grdDetails1.SetColEdit(12,0);
            grdDetails1.SetColEdit(14,0);
            grdDetails1.SetColEdit(18,0);
            grdDetails1.SetColEdit(20,0);
            grdDetails1.SetColEdit(24,0);
            grdDetails1.SetColEdit(26,0);
        break;
        case '1':
            //Saved	Chỉ hiển thị : Popup,New,Save,Delete,Approve button

            btnSearch.style.display=""; 
            btnNew.style.display="";
            btnSave.style.display=""; 
            btnDel.style.display=""; 
            btnExcel.style.display="none"; 
            btnConfirm.style.display=""; 
            btnCancel.style.display="none"; 
            btnRegenerate.style.display="none"; 
            btnCopy.style.display="none";
            
            btnSearchItem.style.display="";   
            btnSaveItem.style.display=""; 
            btnDelItem.style.display="";  
            btnRefreshItem.style.display=""; 
            btnCalcSave.style.display="";
            
            grdDetails.SetColEdit(G1_u_price,1);
            grdDetails.SetColEdit(G1_qty,1);
            grdDetails.SetColEdit(G1_gross_weight,1);
            grdDetails.SetColEdit(G1_re_ext_price,1);
            
            grdDetails1.SetColEdit(4,1);
            grdDetails1.SetColEdit(6,1);
            grdDetails1.SetColEdit(8,1);
            grdDetails1.SetColEdit(12,1);
            grdDetails1.SetColEdit(14,1);
            grdDetails1.SetColEdit(18,1);
            grdDetails1.SetColEdit(21,1);
            grdDetails1.SetColEdit(24,1);
            grdDetails1.SetColEdit(26,1);
        break;	      
    }
}
 //---------------------------------------------------------------------------------
function openPopup(index)
 {
 
    var fpath = '';
    switch(index)
    {	        	         
       case 0:// Customs Office
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?partner_type=90"; //customs
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {          
                txtCusOffName.SetDataText(aValue[2]); 
                txtCusOff.SetDataText(aValue[1]);  
                txtCusOffPK.SetDataText(aValue[0]);  
            }	
        break;
        case 1:// Importer
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?"; 
            var desc;   
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {        
                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
                txtImporter.SetDataText(aValue[2]);    
                txtImporterPK.SetDataText(aValue[0]);  
                txtImpDesc.SetDataText(desc);
            }	
        break; 
        case 2:// Exporter  
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?"; 
            var desc;
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {          
                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
                txtExporter.SetDataText(aValue[2]); 
                txtExporterPK.SetDataText(aValue[0]);
                txtExpDesc.SetDataText(desc);  
            }	
        break; 
        case 3:// Consignor  
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?"; 
            var desc;
            aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {       
                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];   
                txtConsignor.SetDataText(aValue[2]);  
                txtCondignorPK.SetDataText(aValue[0]);  
                txtConsDesc.SetDataText(desc); 
            }	
        break; 
        case 4:// Forwarder     
            var fpath = System.RootURL + "/form/ep/gd/PopUpGetCustoms.aspx?";
            var desc;
            aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
            if ( aValue != null )
            {        
                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
                txtForwarder.SetDataText(aValue[2]); 	               
                txtForwarderPK.SetDataText(aValue[0]);  
                txtForwarderDesc.SetDataText(desc);
            }	
        break;
        case 5: // Commercial Invoice
            var fpath = System.RootURL + "/form/ep/gd/epgd00030_Invoice.aspx" ;
            var arrData = System.OpenModal( fpath , 900 ,600, 'resizable:yes;status:yes;');
            if (arrData!=null)
            { 
                var Data =new Array();
                Data=arrData[0];    // master
                txtCusOffName.text = Data[3];
                txtCusOff.text      = Data[2];  
                txtCusOffPK.text = Data[1];
                cboPayCurr.value =  Data[11];
                txtExRate.text = Data[12]; 
                cboPayMethod.value = Data[10]; 
                txtInvocePk.text = Data[0];
                txtInvoceNo.text = Data[5];
                dtInvDate.value =  Data[4];
                txtContract.text =  Data[6];
                dtContractDate.value = Data[7]; 
                dtExpContDate.value = Data[8];
                
                // detail
                var rows;
                rows=arrData.length;
                
                for(var i=1; i<rows; i++)   
                {
                    var aValue =new Array();
                    aValue=arrData[i]; 
                	grdDetails.AddRow();
                	grdDetails.SetGridText(grdDetails.rows-1, G1_rownum ,i); 
                	grdDetails.SetGridText(grdDetails.rows-1, G1_tex_cinv_dtl_pk ,aValue[0]);      //_tim_cinv_dtl_PK           
                    //grdDetails.SetGridText(grdDetails.rows-1,17,txtItemOrigin.text );      //1.	_origin
                    grdDetails.SetGridText(grdDetails.rows-1, G1_tco_item_pk ,aValue[2]);      //2.	_TCO_ITEM_PK           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_tex_order_pk ,aValue[3]);      //3.	_TIM_ORDER_PK 
                    grdDetails.SetGridText(grdDetails.rows-1, G1_order_no ,aValue[4]);      //4.	order_no                
                    grdDetails.SetGridText(grdDetails.rows-1, G1_item_code ,aValue[5]);      //5.	ITEM_CODE           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_item_name ,aValue[6]);      //6.	ITEM_NAME           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_hs_code ,aValue[7]);      //7.	HS_CODE           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_unit_cd ,aValue[8]);      //8.	UNIT_CD           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_u_price ,aValue[9]);      //9.	U_PRICE   
                    grdDetails.SetGridText(grdDetails.rows-1, G1_qty ,aValue[10]);     //10.	DECL_QTY   
                    grdDetails.SetGridText(grdDetails.rows-1, G1_cnv_ratio ,aValue[11]);     //10.	cnv_ratio                           
                    grdDetails.SetGridText(grdDetails.rows-1, G1_unit_packing ,aValue[12]);  // unit_pack
                    grdDetails.SetGridText(grdDetails.rows-1, G1_qty_packing ,aValue[13]); //qty_pack
                    grdDetails.SetGridText(grdDetails.rows-1, G1_tran_rate ,aValue[14]);  //tran_rate
                    
                    grdDetails.SetGridText(grdDetails.rows-1, G1_unit_weight ,aValue[16]); 
                    grdDetails.SetGridText(grdDetails.rows-1, G1_net_weight ,aValue[17]); 
                    grdDetails.SetGridText(grdDetails.rows-1, G1_gross_weight ,aValue[17]); 
                    grdDetails.SetGridText(grdDetails.rows-1, G1_weight_rate ,aValue[15]); 
                    
                    grdDetails.SetGridText(grdDetails.rows-1, G1_ext_price ,Number(grdDetails.GetGridData(grdDetails.rows-1, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.rows-1, G1_qty))/Number(aValue[11]));
                    grdDetails.SetGridText(grdDetails.rows-1, G1_net_tr_amt,Number(grdDetails.GetGridData(grdDetails.rows-1, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.rows-1, G1_re_ext_price)));             
                    grdDetails.SetGridText(grdDetails.rows-1, G1_net_bk_amt,(Number(grdDetails.GetGridData(grdDetails.rows-1, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.rows-1, G1_re_ext_price)))*Number(txtExRate.text));             
                    grdDetails.GetGridControl().AutoSize(0,25,false,0);  
                }
//	                Total();
                var NetValue;
                NetValue=0;
                var ctrl=grdDetails.GetGridControl();
                for (i=2; i<ctrl.Rows; i++)
                {
	                temp= grdDetails.GetGridData(i, G1_net_tr_amt);
	                NetValue=Number(NetValue) + Number(temp) ;    		
                }
                txtTransTotalNet.SetDataText('' + NetValue);	    
                txtTransTotalNet1.SetDataText('' + NetValue);	   
            }
        break;
        case 6:
            var fpath = System.RootURL + "/form/ep/gd/epgd00030_SearchDecl.aspx" ;
            var obj = System.OpenModal( fpath , 930 ,600, 'resizable:yes;status:yes;');
            if (obj!=null)
            {  
                txtMasterPK.text=obj[0];
                dat_epgd00030_1.Call('SELECT');
            }
        break;
        case 7:
	            fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|||";
                oValue = System.OpenModal( fpath , 900 , 580 , 'resizable:yes;status:yes'); 
                var isAlready;
              
                isAlready=0;
               
                if (oValue != null)
                {  
                    for ( var i=0; i<oValue.length;i++)
                    {                 
                        aValue=oValue[i];
	                    
	                    for(var k=0; k<grdDetails.rows;k++)
	                        if (grdDetails.GetGridData(k , G1_tco_item_pk )== aValue[0]) // da co
					        {
						        isAlready=1;
						        break;	
					        }		
					    if(isAlready==0) 
	                    {               
                            var aValue = oValue[i];  
                            grdDetails.AddRow();
                            grdDetails.SetGridText(grdDetails.rows-1, G1_rownum ,grdDetails.rows-2); 
//                	        grdDetails.SetGridText(grdDetails.rows-1, G1_tex_cinv_dtl_pk ,aValue[0]);      //_tim_cinv_dtl_PK                                       
                            grdDetails.SetGridText(grdDetails.rows-1, G1_tco_item_pk ,aValue[0]);      //2.	_TCO_ITEM_PK           
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_tex_order_pk ,aValue[3]);      //3.	_TIM_ORDER_PK 
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_order_no ,aValue[4]);      //4.	order_no                
                            grdDetails.SetGridText(grdDetails.rows-1, G1_item_code ,aValue[1]);      //5.	ITEM_CODE           
                            grdDetails.SetGridText(grdDetails.rows-1, G1_item_name ,aValue[2]);      //6.	ITEM_NAME           
                            grdDetails.SetGridText(grdDetails.rows-1, G1_hs_code ,aValue[22]);      //7.	HS_CODE           
                            grdDetails.SetGridText(grdDetails.rows-1, G1_unit_cd ,aValue[5]);      //8.	UNIT_CD           
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_u_price ,aValue[9]);      //9.	U_PRICE   
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_qty ,aValue[10]);     //10.	DECL_QTY   
                            grdDetails.SetGridText(grdDetails.rows-1, G1_cnv_ratio ,aValue[23]);     //10.	cnv_ratio                           
                            grdDetails.SetGridText(grdDetails.rows-1, G1_unit_packing ,aValue[5]);  // unit_pack
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_qty_packing ,aValue[13]); //qty_pack
                            grdDetails.SetGridText(grdDetails.rows-1, G1_tran_rate ,aValue[25]);  //tran_rate                            
                            grdDetails.SetGridText(grdDetails.rows-1, G1_unit_weight, 'KG'); 
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_net_weight ,aValue[17]); 
//                            grdDetails.SetGridText(grdDetails.rows-1, G1_gross_weight ,aValue[17]); 
                            grdDetails.SetGridText(grdDetails.rows-1, G1_weight_rate ,aValue[26]); 
                        }
                    }
                }                
	        break;
    }
}
 //---------------------------------------------------------------------------------------
 function onSave(index)
 {
    switch (index)
    {
        case 0:
            if(ValidateData())
            {
                action='save';
                dat_epgd00030_1.Call('');
            }
        break;
        case 1:
            action='save';
            grdDetails.SetRowStatus(1,'_');
            for(var i=2;i<grdDetails.rows;i++)
                if (grdDetails.GetGridData(i,0)=='')
                    grdDetails.SetGridText(i, G1_tex_decl_mst_pk ,txtMasterPK.text);
            dat_epgd00030_2.Call('');
        break;
        case 2:
            action='save';
            grdDetails1.SetRowStatus(1,'_');
            dat_epgd00030_3.Call('');
        break;
    }
}   
//----------------------------------------------------------------------------
 function onNew(index)
 {
    txtCompany.text = "<%=Session["COMPANY_PK"]%>" ;
    txtMasterPK.SetDataText("-1");
    dat_epgd00030_1.StatusInsert();
    onValueChange(1);
    onValueChange(2);
    onValueChange(3);
    onValueChange(4);
    onValueChange(5);
    onValueChange(6);
    txtStatus.text=1;
    grdDetails.ClearData();
    grdDetails1.ClearData();
    grdDetails.AddRow();
    grdDetails1.AddRow();
    MergeHeader(0);
    MergeHeader(1);
    SetStatus("1");    
    lbStatus.text = "";
    txtExRate.text ="1";
    isStart=1;
    dat_epgd00030_17.Call('SELECT');
 }   
 //---------------------------------------------------------------------------------
function OnDataReceive(obj)
{ 
    switch(obj.id)
    {
         case 'dat_epgd00030_1' :
             
            lbStatus.text =txtlbStatus.text;
            if (txtMasterPK.text!='')
            {
                btnSaveItem.SetEnable(true);
                btnCalcSave.SetEnable(true);
            }
            
            if(action=='view')
                SetStatus("4");
            else
                SetStatus(txtStatus.text);
                
            if (action=='save')
                onSave(1);
            else
            {                                        
                dat_epgd00030_2.Call('SELECT');
            }
         break;
         case 'dat_epgd00030_2':
             MergeHeader(0);                 
             //if ((action=='save')) dat_epgd00030_6.Call();
             for(i=2; i<grdDetails.rows; i++)
                    grdDetails.SetGridText(i, 1, i-1);
             grdDetails.GetGridControl().AutoSize(0, 25,false,0);   
             if (action=='save') dat_epgd00030_12.Call();
         break;  
		 case 'dat_epgd00030_3':
		 	 MergeHeader(1);	
		 	 for(i=2; i<grdDetails1.rows; i++)
                grdDetails1.SetGridText(i, 1, i-1);		 	
		 	 if ((action=='save')) dat_epgd00030_6.Call();
		 break;   
		 case 'dat_epgd00030_7':
            if(txtStatus.text=="2")
                lbStatus.text="Confirmed";
            else
                if(txtStatus.text=="3")
                    lbStatus.text="Cancelled";
            SetStatus(txtStatus.text);
         break; 
         case 'dat_epgd00030_8':
            txtStatus.text="1";  
            lbStatus.text='Saved';
            SetStatus(txtStatus.text);
            dat_epgd00030_1.Call('SELECT');
        break;
        case 'dat_epgd00030_9':                
		 	 if(isStart==1)
		 	 {
		 	     isStart=0;
		 	     dat_epgd00030_10.Call();
		 	 }
		break; 
		case 'dat_epgd00030_11':
            grdDetails.SetGridText(rowchange, G1_cnv_ratio , txtCnvRatio.text);
            onAfterEditting(G1_u_price);
            if(is_unit_change ==1)
                onAfterEditting(G1_unit_packing);
        break;
        case 'dat_epgd00030_12':
            txtCalcTotalNet1.text=  txtCalcTotalNet.text;
            dat_epgd00030_3.Call("SELECT"); 
        break;
        case 'dat_epgd00030_13':
            grdDetails.SetGridText(rowchange, G1_tran_rate, txtTran_rate.text);
            grdDetails.SetGridText(rowchange, G1_qty_packing,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_tran_rate)));
            if(is_unit_change ==1)
                onAfterEditting(G1_unit_weight);
        break;
        case 'dat_epgd00030_14':
            grdDetails.SetGridText(rowchange, G1_weight_rate, txtTran_rate.text);            
            is_unit_change =0;
            grdDetails.SetGridText(rowchange, G1_net_weight,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_weight_rate)));
            grdDetails.SetGridText(rowchange, G1_gross_weight,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_weight_rate)));
        break; 
        case 'dat_epgd00030_15':
            dat_epgd00030_16.Call();
        break;    
        case 'datGetNewCode':
            var strdata = txtCodeTemp.text;
            
            switch(indexCode)
            {    
                case 1:
                    cboDeclType.SetDataText(strdata);
                    cboDeclType.value= strcodereturn;
                break;
                case 2:
                    cboTradeTerms.SetDataText(strdata);
                    cboTradeTerms.value=strcodereturn;
                break;
                case 3:
                    cboPayCurr.SetDataText(strdata);
                    cboPayCurr.value=strcodereturn;
                break;
                case 4:
                    cboPayMethod.SetDataText(strdata);
                    cboPayMethod.value=strcodereturn;
                break;
                case 5:
                    cboExpGate.SetDataText(strdata);
                    cboExpGate.value=strcodereturn;
                break;
                case 6:
                    cboImpCountry.SetDataText(strdata);
                    cboImpCountry.value=strcodereturn;
                break;                                
            }
        break; 
        case 'dat_epgd00030_17':
            dat_epgd00030_18.Call();
        break;    
    }        
}
  //--------------------------------------------------------------------------------------
 function onAfterEditting(colidx)
 {

    if(colidx==G1_unit_cd)
    {
        is_unit_change =1;
        rowchange = grdDetails.row;
        txtUnit.text = grdDetails.GetGridData(grdDetails.row, G1_unit_cd);
        dat_epgd00030_11.Call();
    } 
    
    if(colidx==G1_unit_packing)
    {
        if(is_unit_change ==0)
            rowchange = grdDetails.row;
        txtItemPK.text = grdDetails.GetGridData(grdDetails.row, G1_tco_item_pk);
        txtUnit.text= grdDetails.GetGridData(grdDetails.row, G1_unit_cd);
        txtUnitTran.text = grdDetails.GetGridData(grdDetails.row, G1_unit_packing);
        dat_epgd00030_13.Call();
    } 
    
    if(colidx==G1_unit_weight)
    {
        if(is_unit_change ==0)
            rowchange = grdDetails.row;
        txtItemPK.text = grdDetails.GetGridData(grdDetails.row, G1_tco_item_pk);
        txtUnit.text= grdDetails.GetGridData(grdDetails.row, G1_unit_cd);
        txtUnitTran.text = grdDetails.GetGridData(grdDetails.row, G1_unit_weight);
        dat_epgd00030_14.Call();
    } 
    
    if(colidx==G1_qty)
    {
        grdDetails.SetGridText(grdDetails.row, G1_qty_packing,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_tran_rate)));
        grdDetails.SetGridText(grdDetails.row, G1_net_weight,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_weight_rate)));
        grdDetails.SetGridText(grdDetails.row, G1_gross_weight,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_weight_rate)));
    }
    
    if ((colidx==G1_u_price)||(colidx==G1_qty)) //Price, Qty.
    {                
       if ((!isNaN(grdDetails.GetGridData(grdDetails.row, G1_qty))) && (!isNaN(grdDetails.GetGridData(grdDetails.row, G1_u_price))) )
          if(!isNaN(grdDetails.GetGridData(grdDetails.row,23)))
           {
               grdDetails.SetGridText(grdDetails.row, G1_ext_price,Number(grdDetails.GetGridData(grdDetails.row, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.row, G1_qty))/Number(grdDetails.GetGridData(grdDetails.row,23)));
               grdDetails.SetGridText(grdDetails.row, G1_net_tr_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
           }
           else
           {
               grdDetails.SetGridText(grdDetails.row, G1_ext_price,Number(grdDetails.GetGridData(grdDetails.row, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.row, G1_qty)));
               grdDetails.SetGridText(grdDetails.row, G1_net_tr_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
           }
       else
       {
            alert("You must input a number!");
            grdDetails1.SetGridText(grdDetails.row,colidx,'');
       }
    } 
    if (colidx==G1_re_ext_price) //	Retouch Amt 
    {                
       if(!isNaN(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)))
       {           
           grdDetails.SetGridText(grdDetails.row, G1_net_tr_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
       }
       else
       {
          alert("Retouch Amt must be a number!");
          grdDetails.SetGridText(grdDetails.row, G1_re_ext_price,'')
          grdDetails.SetGridText(grdDetails.row, G1_net_tr_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
       }           
    } 
    var NetValue;
    NetValue=0;
    var ctrl=grdDetails.GetGridControl();
    for (i=2; i<ctrl.Rows; i++)
    {
	    temp= grdDetails.GetGridData(i,G1_net_tr_amt);
	    NetValue=Number(NetValue) + Number(temp) ;    		
    }
    txtTransTotalNet.SetDataText('' + NetValue);	    
    txtTransTotalNet1.SetDataText('' + NetValue);	   
 }
  //--------------------------------------------------------------------------------------
 function onAfterEditting1()
 {
    var colidx;

    colidx= grdDetails1.col;
    
    if (colidx==G2_re_im_tax_calc_amt)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_calc_amt)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_adjamt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_calc_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_calc_amt)));               
       }
       else
       {
            alert("You must input a number!");
            grdDetails1.SetGridText(grdDetails1.row,G2_re_im_tax_calc_amt,'');
            grdDetails1.SetGridText(grdDetails1.row,G2_adjamt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_calc_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_calc_amt)));               
       }
    } 
    
    if (colidx==G2_im_tax_rate)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_rate)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_rate))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjamt))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)));
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_bk_amt))/ Number(txtExRate.text));               
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_rate,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_rate))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjamt))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)));
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_bk_amt))/ Number(txtExRate.text));               
       }
    } 
    
    if (colidx==G2_re_im_tax_amt)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)));               
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_bk_amt))/ Number(txtExRate.text));               
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_re_im_tax_amt,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)));               
           grdDetails1.SetGridText(grdDetails1.row,G2_im_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_bk_amt))/ Number(txtExRate.text));               
       }
    } 
    grdDetails1.SetGridText(grdDetails1.row,G2_exc_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjamt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_im_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_im_tax_amt)));               
    
    if (colidx==G2_exc_rate)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_exc_rate)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_adjexc,Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjexc)));               
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_rate,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_adjexc,Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjexc)));                
       }
    } 
    if (colidx==G2_re_exc_amt)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_re_exc_amt)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,13))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_exc_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_bk_amt))/ Number(txtExRate.text));                                         
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_re_exc_amt,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjexc))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_exc_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_exc_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_bk_amt))/ Number(txtExRate.text));                                         
       }
    } 
    grdDetails1.SetGridText(grdDetails1.row,G2_vat_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_exc_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjexc))+Number(grdDetails1.GetGridData(grdDetails1.row,14)));               
    if (colidx==G2_vat_rate)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_vat_rate)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_adjvat,Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat)));               
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_rate,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_adjvat,Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat)));               
       }
    } 
    if (colidx==G2_re_vat_amt)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_re_vat_amt)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_vat_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_bk_amt))/ Number(txtExRate.text));                                         
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_re_vat_amt,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_adjvat,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_vat_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_vat_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat))/ Number(txtExRate.text));                                         
       }
    } 
    grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_calc_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_vat_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_adjvat))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_vat_amt)));               
    if (colidx==G2_ot_tax_rate)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_rate)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_calc_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_amt)));               
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_rate,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_calc_amt))*Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_rate))/100);               
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_amt)));               
       }
    } 
    if (colidx==G2_re_ot_tax_amt)
    {                
       if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,G2_re_ot_tax_amt)))
       {
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_ot_tax_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_bk_amt))/ Number(txtExRate.text));                                         
       }
       else
       {
           alert("You must input a number!");
           grdDetails1.SetGridText(grdDetails1.row,G2_re_ot_tax_amt,'');
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_bk_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_amt))+Number(grdDetails1.GetGridData(grdDetails1.row,G2_re_ot_tax_amt)));   
           grdDetails1.SetGridText(grdDetails1.row,G2_ot_tax_tr_amt,Number(grdDetails1.GetGridData(grdDetails1.row,G2_ot_tax_bk_amt))/ Number(txtExRate.text));                                         
       }
    } 
    Total();      
 }   
  //----------------------------------------------------------------------------
 function onDelete(index)
 {
    switch (index)
    {
        case 0: // xoa phieu
            if(confirm('Do you want to delete this declaration ?'))
            {
                dat_epgd00030_1.StatusDelete();
                dat_epgd00030_1.Call('');
            }    
        break;
        case 1: // xoa item
            if(confirm('Do you want to delete this item ?'))
            {
                action='delete';
                grdDetails.DeleteRow();
            }
        break; 
    }
 }  
 //----------------------------------------------------------------------------
 function ValidateData()
 {
//        if(txtSlipNo.text=='')
//        {
//            alert("You must input Declaration No first!");
//            return false;
//        }
    return true;
 }
 //----------------------------------------------------------------------------
 function ValidateConfirm()
 {  
    if(txtCusOffPK.text=='')
    {
        alert("You must input Customs Office!");
        return false;
    }               
    if(txtImporterPK.text=='')
    {
        alert("You must input Importer!");
        return false;
    }
    if(txtExporterPK.text=='')
    {
        alert("You must input Exporter!");
        return false;
    }
    if(txtCondignorPK.text=='')
    {
        alert("You must input Consignor!");
        return false;
    }
//        if(txtForwarderPK.text=='')
//        {
//            alert("You must input Logistics!");
//            return false;
//        }
    if(grdDetails.rows<=2)
    {
        alert("You must input detail!");
        return false;
    }
    return true;
 }
//----------------------------------------------------------------------------
 function onConfirm()
 {
    if(ValidateConfirm())
    {
        txtStatus.text="2";
        dat_epgd00030_7.Call();
    }
 }
//----------------------------------------------------------------------------
 function onCancel()
 {
    if(confirm('Do you want to cancel this declaration ?'))
    {
        txtStatus.text="3";
        dat_epgd00030_7.Call();
    }        
 }
 //----------------------------------------------------------------------------
 function onRegenerate()
 {
    dat_epgd00030_8.Call();
 } 
 function onInputData()
 {
    dat_epgd00030_15.Call();
 }
 //-------------------------------------------------------------------------------
 function onValueChange(index)
{
    switch(index)
    {       
        case 1: 
            txtDeclType.text= cboDeclType.value;
        break;
        case 2:
             txtTradeTerms.text= cboTradeTerms.value;
        break;
        case 3:
            txtPayCurr.text= cboPayCurr.value;                
            dat_epgd00030_18.Call();
        break;
        case 4:
            dat_epgd00030_10.Call();  
            //txtExpGate.text= cboExpGate.value;
        break;
        case 5:
            dat_epgd00030_9.Call();
            //txtImpCountry.text= cboImpCountry.value;
        break;              
        case 6:
            txtPayMethod.text= cboPayMethod.value;
        break;
    }         
}  
//---------------------------------------------------------------------------------    
function OnCheckTab()
{
    var index;
    index=idTab.GetCurrentPageNo();    	
    
	if (index==2)
        if (flag==0)
        {
            dat_epgd00030_3.Call("SELECT");   
            flag=1; 
        }     
}    
//---------------------------------------------------------------------------------------
function GetXmlHttpRequest(handler)
{ 
    var objXmlHttp=null;
	
    if (navigator.userAgent.indexOf("Opera")>=0)
    {
	    alert("Sorry! Ajax doesn't work in Opera"); 
	    return; 
    }
	
    if (navigator.userAgent.indexOf("MSIE")>=0)
    { 
	    var strName="Msxml2.XMLHTTP";
	    if (navigator.appVersion.indexOf("MSIE 5.5")>=0)
	    {
		    strName="Microsoft.XMLHTTP";			
	    } 
	    try
	    { 
		    objXmlHttp=new ActiveXObject(strName);
		    objXmlHttp.onreadystatechange=handler; 
			
		    return objXmlHttp;
	    } 
	    catch(e)
	    { 
		    alert("Error. Scripting for ActiveX might be disabled");
		    return; 
	    } 
    } 
	
    if (navigator.userAgent.indexOf("Mozilla")>=0)
    {
	    objXmlHttp=new XMLHttpRequest();
	    objXmlHttp.onload=handler;
	    objXmlHttp.onerror=handler;
		
	    return objXmlHttp;
    }
} 
//-------------------------------------------------------------------------------------------
//ajax function
function GetRequestState(obj)
{ 
  if(obj.readyState == 4 && obj.status == 200)
  {
      return true;
  }
  return false;
}
//-----------------------------------------------------------------------------------------
function AddCommonCode(index)
{     
    var scode;
    switch(index)
        {
            case 1:
                scode='IEBD0020';
            break;
            case 2:
                scode='IEAB0010';
            break;
            case 3:
                scode='ACAB0110';
            break;
            case 4:
                scode='ACCR0140';
            break;
            case 5:
                scode='COAB0080';
            break;
            case 6:
                scode='COAB0080';
            break;                    
        }
    txtComCodeID.text = scode;        
    var fpath = System.RootURL + "/form/fp/ab/PopUpChangeCommonCode.aspx?code=" + scode ;
   
    var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
    if (obj!=null)
    {
        strcodereturn=obj[1];
        indexCode=index;
        
        if (obj[0]==1 ) //modify common code
            OnLoadNew(scode);
        else
        {               
            switch(index)
            {
                case 1:
                    cboDeclType.value= strcodereturn;
                    onValueChange(1);
                break;
                case 2:
                    cboTradeTerms.value=strcodereturn;
                    onValueChange(2);
                break;
                case 3:
                    cboPayCurr.value=strcodereturn;
                    onValueChange(3);
                break;
                case 4:
                    cboPayMethod.value=strcodereturn;
                    onValueChange(6);
                break;
                case 5:
                    cboExpGate.value=strcodereturn;
                    onValueChange(4);
                break;
                case 6:
                    cboImpCountry.value=strcodereturn;
                    onValueChange(5);
                break;                    
            }            
        }
    }	     
}
//-----------------------------------------------------------------------------------------
function OnLoadNew(scode)
{	
    datGetNewCode.Call('SELECT');
//    var url =  System.RootURL + "/form/ep/bp/epbp00020_searchidcode.aspx?id=" + scode;
//    ajax_test = null;
//    ajax_test = GetXmlHttpRequest(return_result);
//    ajax_test.open("GET", url , true);
//    ajax_test.send(null);
}
//--------------------------------------------------------------------------------------------

function return_result()
{	        
    if(GetRequestState(ajax_test))
    {
        strdata = ajax_test.responseText;	
        switch(indexCode)
            {
                case 1:
                    cboDeclType.SetDataText(strdata);
                    cboDeclType.value= strcodereturn;
                break;
                case 2:
                    cboTradeTerms.SetDataText(strdata);
                    cboTradeTerms.value=strcodereturn;
                break;
                case 3:
                    cboPayCurr.SetDataText(strdata);
                    cboPayCurr.value=strcodereturn;
                break;
                case 4:
                    cboPayMethod.SetDataText(strdata);
                    cboPayMethod.value=strcodereturn;
                break;
                case 5:
                    cboExpGate.SetDataText(strdata);
                    cboExpGate.value=strcodereturn;
                break;
                case 6:
                    cboImpCountry.SetDataText(strdata);
                    cboImpCountry.value=strcodereturn;
                break;                    
            }
    }
}
//-----------------------------------------------------------------------------------------
function MergeHeader(index)
{    	
    switch(index)
    {
        case 0:
	        var fg=grdDetails.GetGridControl();
		    grdDetails.SetCellBold(1,1,1,12,true);
		    fg.FixedRows = 2
		    fg.MergeCells = 5
		     fg.MergeCol(1) = true
	         fg.Cell(0, 0, 1, 1, 1) = "No."
		     fg.MergeCol(2) = true
		     fg.Cell(0, 0, 2, 1, 2) = "Order No."
				
		    fg.MergeRow(0) = true
		    fg.Cell(0, 0, 3, 0, 5) = "Description of Goods"
			    fg.Cell(0, 1, 3, 1) 	= "Code"
			    fg.Cell(0, 1, 4, 1 ) 	= "Name"
			    fg.Cell(0, 1, 5, 1) 	= "HS Code"
	 	     fg.MergeCol(6)=true
		     fg.Cell(0,0,6,1,6)="Unit"
		     fg.MergeCol(7)=true
		     fg.Cell(0,0,7,1,7)="Unit Packing"
		     fg.MergeCol(8)=true
		     fg.Cell(0,0,8,1,8)="Unit Wt"
		     fg.MergeCol(9)=true
		     fg.Cell(0,0,9,1,9)="U/ Price"
		     fg.MergeCol(10)=true
		     fg.Cell(0,0,10,1,10)="Quantity"
		     fg.MergeCol(11)=true
		     fg.Cell(0,0,11,1,11)="Qty. Packing"
		     fg.MergeCol(12)=true
		     fg.Cell(0,0,12,1,12)="Net Wt"
		     fg.MergeCol(13)=true
		     fg.Cell(0,0,13,1,13)="Gross Wt"
		     fg.MergeCol(14)=true
		     fg.Cell(0,0,14,1,14)="Extended price"
		     fg.MergeCol(15)=true
		     fg.Cell(0,0,15,1,15)="Retouch Amt."
		     fg.MergeCol(16)=true
		     fg.Cell(0,0,16,1,16)="Net Tr. Amt"
		 		 
		     fg.ColWidth(1)=800;  // No.
		     fg.ColWidth(2)=1400; // Order No.
		     fg.ColWidth(3)=1300; // Code
		     fg.ColWidth(4)=2000; // Name
		     fg.ColWidth(5)=1800; // HS Code	
		     fg.ColWidth(6)=1200;  // Acc. Code
		     fg.ColWidth(7)=1200;  // Unit
		     fg.ColWidth(9)=1000;  // U/Price
		     fg.ColWidth(10)=1400; // Quantity	
		     fg.ColWidth(11)=1400; // Extended Price	
	 	     fg.ColWidth(14)=1400; // Retouch Amt	
	  	     fg.ColWidth(15)=1400; // Adj Ext. Price
		     fg.ColWidth(16)=1400; // Adj Ext. Price
		     fg.ColWidth(17)=1400; 
		     fg.ColWidth(18)=1400; 
	      break; 
	      case 1:
	 	        switch(cboTaxType.GetData())
		        {
			        case "Exp":
			 	        var fg=grdDetails1.GetGridControl();
				        grdDetails1.SetCellBold(1,1,1,28,true);
				        fg.FixedRows = 2;
				        fg.MergeCells = 5;
				        fg.MergeCol(1) = true;
		    	        fg.Cell(0, 0,1, 1, 1) = "No.";
				        fg.MergeCol(2) = true;
		    	        fg.Cell(0, 0,2, 1, 2) = "Code";
			 	        fg.MergeRow(0) = true;
				        fg.Cell(0, 0, 3, 0, 28) = cboTaxType.GetText(); 
				        fg.Cell(0, 1, 3, 1) 	= "Calculated Amt.";
				        fg.Cell(0, 1, 4, 1 ) 	= "Retouch Amt.";
				        fg.Cell(0, 1, 5, 1) 	= "Adj Cal. Amt.";	
				        fg.Cell(0, 1, 6, 1) 	= "Rate"	;
				        fg.Cell(0, 1, 7, 1) 	= "Bef Adj. Amt."	;
				        fg.Cell(0, 1, 8, 1) 	= "Retouch Amt.";					
				        fg.Cell(0, 1, 9, 1) 	= "Aft. Adj. Amt."	;
				        fg.Cell(0, 1, 10, 1) 	= "Tr. Amt.";	
						
				        fg.Cell(0, 1, 11, 1) 	= "Calculated Amt."	;						
				        fg.Cell(0, 1, 12, 1) 	= "Rate";													
				        fg.Cell(0, 1, 13, 1) 	= "Bef Adj. Amt.";
				        fg.Cell(0, 1, 14, 1) 	= "Retouch Amt."	;
				        fg.Cell(0, 1, 15, 1) 	= "Aft. Adj. Amt."		;
				        fg.Cell(0, 1, 16, 1) 	= "Tr. Amt"		;
						
				        fg.Cell(0, 1, 17, 1) 	= "Calculated Amt."	;						
				        fg.Cell(0, 1, 18, 1) 	= "Rate";													
				        fg.Cell(0, 1, 19, 1) 	= "Bef Adj. Amt.";
				        fg.Cell(0, 1, 20, 1) 	= "Retouch Amt."	;
				        fg.Cell(0, 1, 21, 1) 	= "Aft. Adj. Amt."		;
				        fg.Cell(0, 1, 22, 1) 	= "Tr. Amt"		;
											
				        fg.Cell(0, 1, 23, 1) 	= "Calculated Amt. "							
				        fg.Cell(0, 1, 24, 1) 	= "Rate other"													
				        fg.Cell(0, 1, 25, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 26, 1) 	= "Retouch Amt. "	
				        fg.Cell(0, 1, 27, 1) 	= "Aft. Adj. Amt. "		
				        fg.Cell(0, 1, 28, 1) 	= "Tr. Amt "
						
				        fg.ColWidth(1)=800;  // No.
				        fg.ColWidth(2)=1800; // Code
				        fg.ColWidth(3)=2000; // 
				        fg.ColWidth(4)=1500; // 
				        fg.ColWidth(5)=1500; // 
				        fg.ColWidth(6)=1400;  //
				        fg.ColWidth(7)=1500;  //
				        fg.ColWidth(8)=1500;  //
				        fg.ColWidth(9)=1500;
				        fg.ColWidth(10)=1500;
						
				        fg.ColWidth(11)=0;	
				        fg.ColWidth(12)=0;	
				        fg.ColWidth(13)=0;
						
				        fg.ColWidth(14)=0;
				        fg.ColWidth(15)=0;
				        fg.ColWidth(16)=0;
				        fg.ColWidth(17)=0;
				        fg.ColWidth(18)=0;
						
				        fg.ColWidth(19)=0;
				        fg.ColWidth(20)=0;
				        fg.ColWidth(21)=0;
				        fg.ColWidth(22)=0;
				        fg.ColWidth(23)=0;	
				        fg.ColWidth(24)=0;	
				        fg.ColWidth(25)=0;	
				        fg.ColWidth(26)=0;	
				        fg.ColWidth(27)=0;	
				        fg.ColWidth(28)=0;	
			        break;
					
			        case "EXC":
				        var fg=grdDetails1.GetGridControl();
				        grdDetails1.SetCellBold(1,1,1,28,true);
				        fg.FixedRows = 2
				        fg.MergeCells = 5
				        fg.MergeCol(1) = true
		    	        fg.Cell(0, 0,1, 1, 1) = "No."
				        fg.MergeCol(2) = true
		    	        fg.Cell(0, 0,2, 1, 2) = "Code"
			 	        fg.MergeRow(0) = true
				        fg.Cell(0, 0, 3, 0, 28) = cboTaxType.GetText(); 
				        fg.Cell(0, 1, 3, 1) 	= "Calculated Amt."
				        fg.Cell(0, 1, 4, 1 ) 	= "Retouch Amt."
				        fg.Cell(0, 1, 5, 1) 	= "Adj Cal. Amt."	
				        fg.Cell(0, 1, 6, 1) 	= "Rate"	
				        fg.Cell(0, 1, 7, 1) 	= "Bef Adj. Amt."	
				        fg.Cell(0, 1, 8, 1) 	= "Retouch Amt."					
				        fg.Cell(0, 1, 9, 1) 	= "Aft. Adj. Amt."	
				        fg.Cell(0, 1, 10, 1) 	= "Tr. Amt"	
						
				        fg.Cell(0, 1, 11, 1) 	= "Calculated Amt."							
				        fg.Cell(0, 1, 12, 1) 	= "Rate"													
				        fg.Cell(0, 1, 13, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 14, 1) 	= "Retouch Amt."	
				        fg.Cell(0, 1, 15, 1) 	= "Aft. Adj. Amt."		
				        fg.Cell(0, 1, 16, 1) 	= "Tr. Amt"		

				        fg.Cell(0, 1, 17, 1) 	= "Calculated Amt."	;						
				        fg.Cell(0, 1, 18, 1) 	= "Rate";													
				        fg.Cell(0, 1, 19, 1) 	= "Bef Adj. Amt.";
				        fg.Cell(0, 1, 20, 1) 	= "Retouch Amt."	;
				        fg.Cell(0, 1, 21, 1) 	= "Aft. Adj. Amt."		;
				        fg.Cell(0, 1, 22, 1) 	= "Tr. Amt"		;
					
				        fg.Cell(0, 1, 23, 1) 	= "Calculated Amt. other"							
				        fg.Cell(0, 1, 24, 1) 	= "Rate other"													
				        fg.Cell(0, 1, 25, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 26, 1) 	= "Retouch Amt. other"	
				        fg.Cell(0, 1, 27, 1) 	= "Aft. Adj. Amt. other"		
				        fg.Cell(0, 1, 28, 1) 	= "Tr. Amt other"
						
																																	
				        fg.ColWidth(1)=800;  // No.
				        fg.ColWidth(2)=1800; // Code
				        fg.ColWidth(3)=0; // Code
				        fg.ColWidth(4)=0; // Name
				        fg.ColWidth(5)=0; // HS Code	
				        fg.ColWidth(6)=0;  // Acc. Code
				        fg.ColWidth(7)=0;  // Unit
				        fg.ColWidth(8)=0;  // U/Price	
				        fg.ColWidth(9)=0;
				        fg.ColWidth(10)=0;
						
				        fg.ColWidth(11)=2000;
				        fg.ColWidth(12)=2000;
				        fg.ColWidth(13)=2000;
				        fg.ColWidth(14)=2000;
				        fg.ColWidth(15)=2000;
				        fg.ColWidth(16)=2000;
						
				        fg.ColWidth(17)=0;
				        fg.ColWidth(18)=0;
						
				        fg.ColWidth(19)=0;
				        fg.ColWidth(20)=0;
				        fg.ColWidth(21)=0;
				        fg.ColWidth(22)=0;
				        fg.ColWidth(23)=0;	
				        fg.ColWidth(24)=0;	
				        fg.ColWidth(25)=0;	
				        fg.ColWidth(26)=0;	
				        fg.ColWidth(27)=0;	
				        fg.ColWidth(28)=0;	
			        break;
					
			        case "VAT":
				        var fg=grdDetails1.GetGridControl();
				        grdDetails1.SetCellBold(1,1,1,28,true);
				        fg.FixedRows = 2
				        fg.MergeCells = 5
				        fg.MergeCol(1) = true
		    	        fg.Cell(0, 0,1, 1, 1) = "No."
				        fg.MergeCol(2) = true
		    	        fg.Cell(0, 0,2, 1, 2) = "Code"
			 	        fg.MergeRow(0) = true
				        fg.Cell(0, 0, 3, 0, 28) = cboTaxType.GetText(); 
				        fg.Cell(0, 1, 3, 1) 	= "Calculated Amt."
				        fg.Cell(0, 1, 4, 1 ) 	= "Retouch Amt."
				        fg.Cell(0, 1, 5, 1) 	= "Adj Cal. Amt."	
				        fg.Cell(0, 1, 6, 1) 	= "Rate"	
				        fg.Cell(0, 1, 7, 1) 	= "Bef Adj. Amt."	
				        fg.Cell(0, 1, 8, 1) 	= "Retouch Amt."					
				        fg.Cell(0, 1, 9, 1) 	= "Aft. Adj. Amt."	
				        fg.Cell(0, 1, 10, 1) 	= "Tr. Amt"	
						
				        fg.Cell(0, 1, 11, 1) 	= "Calculated Amt."							
				        fg.Cell(0, 1, 12, 1) 	= "Rate"													
				        fg.Cell(0, 1, 13, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 14, 1) 	= "Retouch Amt."	
				        fg.Cell(0, 1, 15, 1) 	= "Aft. Adj. Amt."		
				        fg.Cell(0, 1, 16, 1) 	= "Tr. Amt"		
						
				        fg.Cell(0, 1, 17, 1) 	= "Calculated Amt."							
				        fg.Cell(0, 1, 18, 1) 	= "Rate"													
				        fg.Cell(0, 1, 19, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 20, 1) 	= "Retouch Amt."	
				        fg.Cell(0, 1, 21, 1) 	= "Aft. Adj. Amt."		
				        fg.Cell(0, 1, 22, 1) 	= "Tr. Amt"																		
										
				        fg.Cell(0, 1, 23, 1) 	= "Calculated Amt. other"							
				        fg.Cell(0, 1, 24, 1) 	= "Rate other"													
				        fg.Cell(0, 1, 25, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 26, 1) 	= "Retouch Amt. other"	
				        fg.Cell(0, 1, 27, 1) 	= "Aft. Adj. Amt. other"		
				        fg.Cell(0, 1, 28, 1) 	= "Tr. Amt other"
																											
				        fg.ColWidth(1)=800;  // No.
				        fg.ColWidth(2)=1800; // Code
				        fg.ColWidth(3)=0; // Code
				        fg.ColWidth(4)=0; // Name
				        fg.ColWidth(5)=0; // HS Code	
				        fg.ColWidth(6)=0;  // Acc. Code
				        fg.ColWidth(7)=0;  // Unit
				        fg.ColWidth(8)=0;  // U/Price	
				        fg.ColWidth(9)=0;
				        fg.ColWidth(10)=0;
						
				        fg.ColWidth(11)=0;
				        fg.ColWidth(12)=0;
				        fg.ColWidth(13)=0;
				        fg.ColWidth(14)=0;
				        fg.ColWidth(15)=0;
				        fg.ColWidth(16)=0;
					
				        fg.ColWidth(17)=2000;
				        fg.ColWidth(18)=2000;
				        fg.ColWidth(19)=2000;
				        fg.ColWidth(20)=2000;
				        fg.ColWidth(21)=2000;
				        fg.ColWidth(22)=2000;
						
				        fg.ColWidth(23)=0;	
				        fg.ColWidth(24)=0;	
				        fg.ColWidth(25)=0;	
				        fg.ColWidth(26)=0;	
				        fg.ColWidth(27)=0;	
				        fg.ColWidth(28)=0;	
			        break;
					
			        case "OTH":
				        var fg=grdDetails1.GetGridControl();
				        grdDetails1.SetCellBold(1,1,1,28,true);
				        fg.FixedRows = 2
				        fg.MergeCells = 5
				        fg.MergeCol(1) = true
		    	        fg.Cell(0, 0,1, 1, 1) = "No."
				        fg.MergeCol(2) = true
		    	        fg.Cell(0, 0,2, 1, 2) = "Code"
			 	        fg.MergeRow(0) = true
				        fg.Cell(0, 0, 3, 0, 28) = cboTaxType.GetText(); 
				        fg.Cell(0, 1, 3, 1) 	= "Calculated Amt."
				        fg.Cell(0, 1, 4, 1 ) 	= "Retouch Amt."
				        fg.Cell(0, 1, 5, 1) 	= "Adj Cal. Amt."	
				        fg.Cell(0, 1, 6, 1) 	= "Rate"	
				        fg.Cell(0, 1, 7, 1) 	= "Bef Adj. Amt."	
				        fg.Cell(0, 1, 8, 1) 	= "Retouch Amt."					
				        fg.Cell(0, 1, 9, 1) 	= "Aft. Adj. Amt."	
				        fg.Cell(0, 1, 10, 1) 	= "Tr. Amt"	
						
				        fg.Cell(0, 1, 11, 1) 	= "Calculated Amt."							
				        fg.Cell(0, 1, 12, 1) 	= "Rate"													
				        fg.Cell(0, 1, 13, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 14, 1) 	= "Retouch Amt."	
				        fg.Cell(0, 1, 15, 1) 	= "Aft. Adj. Amt."		
				        fg.Cell(0, 1, 16, 1) 	= "Tr. Amt"		
						
				        fg.Cell(0, 1, 17, 1) 	= "Calculated Amt."							
				        fg.Cell(0, 1, 18, 1) 	= "Rate"													
				        fg.Cell(0, 1, 19, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 20, 1) 	= "Retouch Amt."	
				        fg.Cell(0, 1, 21, 1) 	= "Aft. Adj. Amt."		
				        fg.Cell(0, 1, 22, 1) 	= "Tr. Amt"																		
						
				        fg.Cell(0, 1, 23, 1) 	= "Calculated Amt. other"							
				        fg.Cell(0, 1, 24, 1) 	= "Rate other"													
				        fg.Cell(0, 1, 25, 1) 	= "Bef Adj. Amt."																			
				        fg.Cell(0, 1, 26, 1) 	= "Retouch Amt. other"	
				        fg.Cell(0, 1, 27, 1) 	= "Aft. Adj. Amt. other"		
				        fg.Cell(0, 1, 28, 1) 	= "Tr. Amt other"
																											
				        fg.ColWidth(1)=800;  // No.
				        fg.ColWidth(2)=1800; // Code
				        fg.ColWidth(3)=0; // Code
				        fg.ColWidth(4)=0; // Name
				        fg.ColWidth(5)=0; // HS Code	
				        fg.ColWidth(6)=0;  // Acc. Code
				        fg.ColWidth(7)=0;  // Unit
				        fg.ColWidth(8)=0;  // U/Price	
				        fg.ColWidth(9)=0;
				        fg.ColWidth(10)=0;
						
				        fg.ColWidth(11)=0;
				        fg.ColWidth(12)=0;
				        fg.ColWidth(13)=0;
				        fg.ColWidth(14)=0;
				        fg.ColWidth(15)=0;
				        fg.ColWidth(16)=0;
					
				        fg.ColWidth(17)=0;
				        fg.ColWidth(18)=0;
				        fg.ColWidth(19)=0;
				        fg.ColWidth(20)=0;
				        fg.ColWidth(21)=0;
				        fg.ColWidth(22)=0;
												
				        fg.ColWidth(23)=2000;	
				        fg.ColWidth(24)=2000;	
				        fg.ColWidth(25)=2000;	
				        fg.ColWidth(26)=2000;	
				        fg.ColWidth(27)=2000;	
				        fg.ColWidth(28)=2000;	
			        break; 
		        }			
	     break; 
    }      
}

 //----------------------------------------------------------------------------------------
function Total()
{ 
    var ctrl=grdDetails.GetGridControl();
    var ctrl1=grdDetails1.GetGridControl();
    var NetValue=0,tax_amt=0,temp=0;
   	   
    NetValue=0;
    var ctrl=grdDetails.GetGridControl();
    for (i=2; i<ctrl.Rows; i++)
    {
	    temp= grdDetails.GetGridData(i, G1_net_tr_amt);
	    NetValue=Number(NetValue) + Number(temp) ;    		
    }
    txtTransTotalNet.SetDataText('' + NetValue);	    
    txtTransTotalNet1.SetDataText('' + NetValue);

    // for tax tab	    
    var Net_Tr_Amt=0, Tr_Amt1=0, Tr_Amt2=0, Tr_Amt3=0, Tr_Amt4=0, Tr_Total=0;
    var Adj_Tr_Amt=0, Adj_Amt1=0, Adj_Amt2=0, Adj_Amt3=0, Adj_Amt4=0, Adj_Total=0;

    for(j=2;j<ctrl1.Rows;j++)
    {
	    temp=grdDetails1.GetGridData(j,G2_adjamt);
	    Adj_Tr_Amt=Number(Adj_Tr_Amt) + Number(temp);
	    txtCalcTotalNet.SetDataText('' + Adj_Tr_Amt);
	    txtCalcTotalNet1.SetDataText('' + Adj_Tr_Amt);
		
	    temp=grdDetails1.GetGridData(j,G2_im_tax_tr_amt);
	    Tr_Amt1=Number(Tr_Amt1) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_im_tax_bk_amt);
	    Adj_Amt1=Number(Adj_Amt1) + Number(temp);
		
		temp=grdDetails1.GetGridData(j,G2_exc_tr_amt);
	    Tr_Amt2=Number(Tr_Amt2) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_exc_bk_amt);
	    Adj_Amt2=Number(Adj_Amt2) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_vat_tr_amt);
	    Tr_Amt3=Number(Tr_Amt3) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_vat_bk_amt);
	    Adj_Amt3=Number(Adj_Amt3) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_ot_tax_tr_amt);
	    Tr_Amt4=Number(Tr_Amt4) + Number(temp);
		
	    temp=grdDetails1.GetGridData(j,G2_ot_tax_bk_amt);
	    Adj_Amt4=Number(Adj_Amt4) + Number(temp) ;    		 
    }
    Tr_Total=Number(Tr_Amt1) + Number(Tr_Amt2) + Number(Tr_Amt3) + Number(Tr_Amt4);
    Adj_Total=Number(Adj_Amt1) + Number(Adj_Amt2) + Number(Adj_Amt3) + Number(Adj_Amt4);
	    	
    txtTransImport.SetDataText('' + Tr_Amt1);
    txtCalcImport.SetDataText('' + Adj_Amt1);
    txtTransExcise.SetDataText('' + Tr_Amt2);	
    txtCalcExcise.SetDataText('' + Adj_Amt2);
    txtTransVAT.SetDataText('' + Tr_Amt3);	
    txtCalcVAT.SetDataText('' + Adj_Amt3);	
    txtTransOtherTax.SetDataText('' + Tr_Amt4);	
    txtCalcOtherTax.SetDataText('' + Adj_Amt4);	
    txtTransTotalTax.SetDataText('' + Tr_Total);	
    txtCalcTotalTax.SetDataText('' + Adj_Total); 
    	
    txtTransImport1.SetDataText('' + Tr_Amt1);
    txtCalcImport1.SetDataText('' + Adj_Amt1);
    txtTransExcise1.SetDataText('' + Tr_Amt2);	
    txtCalcExcise1.SetDataText('' + Adj_Amt2);
    txtTransVAT1.SetDataText('' + Tr_Amt3);	
    txtCalcVAT1.SetDataText('' + Adj_Amt3);	
    txtTransOtherTax1.SetDataText('' + Tr_Amt4);	
    txtCalcOtherTax1.SetDataText('' + Adj_Amt4);	
    txtTransTotalTax1.SetDataText('' + Tr_Total);	
    txtCalcTotalTax1.SetDataText('' + Adj_Total);
}   
//--------------------------------------------------------------
function getExRate()
{    
    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtRegDate.value +"&curr=" + cboPayCurr.value;
    ajax_test1 = null;

    ajax_test1 = GetXmlHttpRequest(returnExRate);
    ajax_test1.open("GET", url , true);
    ajax_test1.send(null); 
}
//---------------------------------------------------------
function returnExRate()
{
    if(GetRequestState(ajax_test1))
    {	
        strdata = ajax_test1.responseText;	 	  
        txtExRate.SetDataText(''+strdata);
    }
}
//-------------------------------------------------------------------------------------------
function onPrint(index)
{
    switch(Number(index))
    {
        case 1:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_declaration.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + cboCompany.value;
            System.OpenTargetPage( url, "_blank" );        
        break;
        case 2:
            var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00030_packinglist.aspx?" + "pk=" + txtMasterPK.text + "&company_pk=" + cboCompany.value;
            System.OpenTargetPage( url, "_blank" );  
        break;
    }
    
}
//----------------------------------------------------------------------------------------
function returnFileName()
{    
    if(GetRequestState(ajax_test))
    {	
        strdata = ajax_test.responseText;
        if (strdata.substr(0,5)=='Error')
            alert(strdata);
        else
        {
            var  url= System.RootURL + "/reports/ep/gd/" + strdata 
            System.OpenTargetPage( url, "window" ); 	 
        }       
    }
}
 //--------------------------------------------------------------------------------     
</script>
<body>
<gw:data id="dat_epgd00030_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,72,73,74,75,76,79" function="imex.sp_sel_tex_decl_mst"  procedure="imex.sp_upd_tex_decl_mst"> 
            <inout> 
                <inout  bind="txtMasterPK" /> 
                <inout  bind="txtInvocePk" /> 
                <inout  bind="txtCusOffPK" />
                <inout  bind="txtExporterPK" />
                <inout  bind="txtImporterPK" />
                <inout  bind="txtCondignorPK" />
                <inout  bind="txtForwarderPK" />
                <inout  bind="cboCompany" />
                <inout  bind="cboDeclType" />
                <inout  bind="txtSlipNo" />
                <inout  bind="dtRegDate" />
                <inout  bind="dtExportDate" />
                <inout  bind="cboPayCurr" /> 
                <inout  bind="txtExRate" />
                <inout  bind="txtStatus" />
                <inout  bind="cboPayMethod" />
                <inout  bind="txtAcceptNo" />
                <inout  bind="txtSeqNo" />
                <inout  bind="txtAnnex" />
                <inout  bind="txtDoc" />
                <inout  bind="txtCarton" />
                <inout  bind="txtWeight" />
                <inout  bind="txtCon20" />
                <inout  bind="txtCon40" />
                <inout  bind="txtLicense" />   
                <inout  bind="dtLicenseDate" />
                <inout  bind="dtExpDate" />
                <inout  bind="chkTaxYN" />
                <inout  bind="txtOwner" />
                <inout  bind="cboImpCountry" />  
                <inout  bind="cboExpGate" />  
                <inout  bind="txtCusOff" />     
                <inout  bind="txtCusOffName" />      
                <inout  bind="txtExporter" />
                <inout  bind="txtExpDesc" />     
                <inout  bind="txtImporter" />    
                <inout  bind="txtImpDesc" />  
                <inout  bind="txtConsignor" />
                <inout  bind="txtConsDesc" />   
                <inout  bind="txtForwarder" /> 
                <inout  bind="txtForwarderDesc" />   
                <inout  bind="txtDeclType" />       
                <inout  bind="txtPayCurr" />   
                <inout  bind="txtImpCountry" />   
                <inout  bind="txtExpGate" /> 
                <inout  bind="txtTransTotalNet1" />
                <inout  bind="txtCalcTotalNet1" />
                <inout  bind="txtCalcImport1" />  
                <inout  bind="txtTransImport1" />                  
                <inout  bind="txtCalcExcise1" /> 
                <inout  bind="txtTransExcise1" />
                <inout  bind="txtCalcVAT1" />            
                <inout  bind="txtTransVAT1" />
                <inout  bind="txtCalcOtherTax1" />
                <inout  bind="txtTransOtherTax1" /> 
                <inout  bind="txtTransTotalTax" />              
                <inout  bind="txtCalcTotalTax" />
                <inout  bind="txtTransTotalTax1" />
                <inout  bind="txtCalcTotalTax1" />
                <inout  bind="txtTransTotalNet" />
                <inout  bind="txtCalcTotalNet" />
                <inout  bind="txtCalcImport" />  
                <inout  bind="txtTransImport" />               
                <inout  bind="txtCalcExcise" /> 
                <inout  bind="txtTransExcise" /> 
                <inout  bind="txtCalcVAT" />            
                <inout  bind="txtTransVAT" />
                <inout  bind="txtCalcOtherTax" />   
                <inout  bind="txtTransOtherTax" /> 
                <inout  bind="txtlbStatus" />  
                <inout  bind="txtImpCountry" />       
                <inout  bind="txtExpGate" />
                <inout  bind="txtInvoceNo" />		  
                <inout  bind="dtInvDate" /> 		
                <inout  bind="dtExpContDate" />		
                <inout  bind="dtContractDate" />		
                <inout  bind="txtContract" />	
                <inout  bind="txtContractPK" />	 
                <inout  bind="cboTradeTerms" />	
                <inout  bind="txtTradeTerms" />	  
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
<gw:data id="dat_epgd00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="IMEX.sp_sel_tex_decl_goods_dtl"   procedure="IMEX.sp_upd_tex_decl_goods_dtl"> 
            <input bind="grdDetails">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdDetails" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------>
<gw:data id="dat_epgd00030_3"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" parameter="0,3,4,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,23,24,25,26,27,28" function="IMEX.sp_sel_tex_decl_tax_dtl"   procedure="IMEX.sp_upd_tex_decl_tax_dtl"> 
            <input bind="grdDetails1">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdDetails1" /> 
        </dso> 
    </xml> 
</gw:data> 
<!---------------------------Update amount--------------------------------------->
<gw:data id="dat_epgd00030_6"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process"  procedure="imex.sp_upd_tex_decl_mst_amount"> 
            <input> 
                <input bind="txtMasterPK" />
                <input  bind="txtTransTotalNet" />
                <input  bind="txtCalcTotalNet" />
                <input  bind="txtCalcImport" />  
                <input  bind="txtTransImport" />               
                <input  bind="txtCalcExcise" /> 
                <input  bind="txtTransExcise" />
                <input  bind="txtCalcVAT" />            
                <input  bind="txtTransVAT" />
                <input  bind="txtCalcOtherTax" />
                <input  bind="txtTransOtherTax" /> 
            </input>
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Confirm/Cancel------------------------------------>
<gw:data id="dat_epgd00030_7" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_tex_decl_mst_action" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="txtStatus" /> 
            </input> 
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------Copy/Regenarate------------------------------------>
<gw:data id="dat_epgd00030_8" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_tex_decl_mst_copy_regen" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="txtStatus" /> 
            </input> 
            <output>
                <output bind="txtMasterPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------get im country code -------------------------------------->
<gw:data id="dat_epgd00030_9"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" procedure="imex.sp_pro_get_country_code"  > 
            <input> 
                 <input  bind="cboImpCountry" />
            </input>
            <output>
                <output  bind="txtImpCountry" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------get im country code -------------------------------------->
<gw:data id="dat_epgd00030_10"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" procedure="imex.sp_pro_get_country_code"  > 
            <input> 
                 <input  bind="cboExpGate" />
            </input>
            <output>   
                <output  bind="txtExpGate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get current ratio------------------------------------>
<gw:data id="dat_epgd00030_11" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_get_cnv_ratio" > 
            <input>
                <input bind="txtUnit" /> 
            </input> 
            <output>
                <output bind="txtCnvRatio" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------cal tax amt------------------------------------>
<gw:data id="dat_epgd00030_12" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_cal_tax_amt_exdecl_dtl" > 
            <input>
                <input bind="txtMasterPK" />
                <input bind="txtExRate" />
            </input> 
            <output>
                <output bind="txtCalcTotalNet" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get unit tran----------------------------------------------->
<gw:data id="dat_epgd00030_13" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_dat_epac00030_13" > 
            <input>   
                <input bind="txtItemPK" />
                <input bind="txtUnit" />
                <input bind="txtUnitTran" />
            </input> 
            <output>
                <output bind="txtTran_rate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------------------------------get weight tran----------------------------------------------->
<gw:data id="dat_epgd00030_14" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_dat_epac00030_13" > 
            <input>   
                <input bind="txtItemPK" />
                <input bind="txtUnit" />
                <input bind="txtUnitTran" />
            </input> 
            <output>
                <output bind="txtTran_rate" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------import master data to contract master, invoice master-------------------->
<gw:data id="dat_epgd00030_15" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_epgd00030_1" > 
            <input>   
                <input bind="txtMasterPK" />    
                <input bind="txtInvocePk" />
                <input bind="txtContractPK" />
            </input> 
            <output>
                <output bind="txtInvocePk" />
                <output bind="txtContractPK" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------import detail data to contract master, invoice master-------------------->
<gw:data id="dat_epgd00030_16" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="imex.sp_pro_epgd00030_2" > 
            <input>   
                <input bind="txtMasterPK" />    
                <input bind="txtInvocePk" />
                <input bind="txtContractPK" />
            </input> 
            <output>                
                <output bind="txttmp" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!------------------------Get Company Info -------------------------------------->
<gw:data id="dat_epgd00030_17"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="control" parameter="0,43" function="imex.sp_sel_get_CompanyInfo"  > 
            <inout>           
                 <inout  bind="txtCompany" />
                 <inout  bind="txtExporter" />
                 <inout  bind="txtTMP" />   
                 <inout  bind="txtExporterPK" />
                 <inout  bind="txtExpDesc" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------>
    <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_new_commoncode" > 
                <input> 
                    <input bind="txtComCodeID" /> 
                </input>
	           <output>
	                <output bind="txtCodeTemp" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------> 
    <gw:data id="dat_epgd00030_18" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="IMEX.sp_pro_epgd00010_16" > 
                <input>
                    <input bind="txtPayCurr" /> 
                    <input bind="dtRegDate" /> 
                </input> 
                <output>
                    <output bind="txtExRate" />
                </output>
            </dso>  
        </xml> 
    </gw:data>
<!--------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table width="100%" cellpadding=0 cellspacing=0>
            <tr>
                <td colspan="15"> 
                    <table>
                        <tr>
                            <td width="8%">Company</td>
                            <td width="1%"></td>
                            <td width="20%"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                            <td width="3%"></td>
                            <td width="10%" nowrap >Declaration No</td>
                            <td width="10%"><gw:textbox id="txtSeqNo" csstype="mandatory"  text=""  styles='width:100%;' /></td>
                            <td width="15%"><gw:textbox id="txtSlipNo" csstype="mandatory"  text=""  styles='width:100%;' /></td>
                            <td width="3%"></td>
                            <td width="6%">Status</td>
                            <td width="10%"><gw:label id="lbStatus"  text=""  styles='width:100%;color:red; font-weight:700;' csstype="mandatory" /></td>
                            <td width="5%"></td>
                            <td width="1%"><gw:imgbtn id="btnSearch" img="popup" alt="Open form to search" text="Search" onclick="openPopup(6)" /></td>
                            <td width="1%"><gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" /></td>
                            <td width="1%"><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                            <td width="1%"><gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" /></td>
                            <td width="1%"><gw:imgbtn id="btnExcel" img="excel" alt="Print Declaration" text="Print Declaration" onclick="onPrint(1)" /></td>
                            <td width="1%"><gw:imgbtn id="btnPacking" img="excel" alt="Print Packing List" text="Print Packing List" onclick="onPrint(2)" /></td>
                            <td width="1%"><gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm()" /></td>
                            <td width="1%"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onCancel()" /></td>
                            <td width="1%"><gw:imgbtn id="btnRegenerate" img="registration" alt="Regenerate" text="Regenerate" onclick="onRegenerate()" /></td>
                            <td width="1%"><gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy()" /></td>
                            <td width="1%"><gw:imgbtn id="btnProcess" img="process" alt="Input data to Contract, Invoice" text="Input data to Contract, Invoice" onclick="onInputData()" /></td>
                        </tr>
                    </table>
                </td>                
            </tr>
            <tr>
                <td colspan="15">
                    <gw:tab id="idTab" onpageactivate="return OnCheckTab()" style="width: 100%; height: 220; border1px">    
                        <table width="100%" cellpadding=0 cellspacing=0 id="DeclareInfo" name="Declaration Info" border=0>                            
                            <tr>
                                <td>
                                    <fieldset style="padding: 4">
                                        <table cellpadding=0 cellspacing=0 border=0>  
                                            <tr>
                                                <td width="9%" nowrap><a title="Click here to select Customs Office" onClick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Customs Office</b></a></td>
                                                <td width="8%"><gw:textbox id="txtCusOff"  text=""  styles='width:100%;' /><gw:textbox id="txtCusOffPK"  styles='display:none;' /></td>
                                                <td width="20%"><gw:textbox id="txtCusOffName"  text=""  styles='width:100%;' /></td>
                                                <td width="1%"></td>
                                                <td width="8%" nowrap>Register date</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:datebox id="dtRegDate" lang="1" onchange="dat_epgd00030_18.Call();"/></td>
                                                <td width="1%"></td>
                                                <td width="7%" nowrap>Export date</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:datebox id="dtExportDate" lang="1" onchange=""/></td>
                                                <td width="1%"></td>
                                                <td width="6%">Accept No.</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:textbox id="txtAcceptNo"  text=""  styles='width:100%;' /></td>
                                                <td width="1%"></td>
                                                <td width="4%">Annex</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:textbox id="txtAnnex"  text=""  styles='width:100%;' /></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>   
                            <tr>
                                <td>
                                    <fieldset style="padding: 4">
                                        <table cellpadding=0 cellspacing=0 width="100%" border=0> 
                                            <tr>  
                                                <td width="10%"><a title="Click here to select Exporter" onClick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>1. Exporter</b></a></td>
                                                <td width="39%"><gw:textbox id="txtExporterPK" styles='display:none;'/><gw:textbox id="txtExporter"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                <td width="2%"></td>   
                                                <td width="10%" nowrap><a title="Click here to select Declaration type" onClick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>5. Declaration type</b></a></td>                                              
                                                <td width="39%" colspan="7">
                                                    <table cellpadding=0 cellspacing=0 width="100%">
                                                        <tr>
                                                            <td width="20%"><gw:textbox id="txtDeclType"  text=""  styles='width:100%;' /></td>
                                                            <td width="40%"><gw:list id="cboDeclType" styles="width:100%;" onchange="onValueChange(1);"></gw:list></td>                                                            
                                                            <td width="2%"></td>
                                                            <td width="8%" align="right"><gw:checkbox id="chkTaxYN" onchange="" defaultvalue="Y|N" value="Y"/></td>
                                                            <td width="8%">Tax Y/N</td>
                                                        </tr>
                                                    </table>
                                                </td> 
                                            </tr>
                                            <tr> 
                                                <td colspan="2" rowspan="2">
                                                    <gw:textarea id="txtExpDesc" styles="width:100%;" rows="3"  />
                                                </td>
                                                <td></td>
                                                <td >6. License</td>
                                                <td colspan="7"><gw:textbox id="txtLicense"  text=""  styles='width:100%;' /></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td >Date</td>
                                                <td width="8%" colspan="2" ><gw:datebox id="dtLicenseDate" lang="1" onchange=""/></td>
                                                <td width="8%" ></td>
                                                <td width="1%"></td>
                                                <td width="8%" nowrap>Expire date</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:datebox id="dtExpDate" lang="1" onchange=""/></td>
                                            </tr>
                                            <tr>
                                                <td width="10%"><a title="Click here to select Importer" onClick="openPopup(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>2. Importer</b></a></td>
                                                <td width="39%"><gw:textbox id="txtImporterPK" styles='display:none;'/><gw:textbox id="txtImporter"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                <td width="2%"></td> 
                                                <td ><a title="Click here to select Invoice" onClick="openPopup(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>7. Invoice</b></a></td>
                                                <td width="8%" colspan="2" ><gw:textbox id="txtInvoceNo"  text=""  styles='width:100%;' /><gw:textbox id="txtInvocePk"  text=""  styles='display:none;' /></td>
                                                <td></td>
                                                <td width="1%"></td>  
                                                <td width="8%" nowrap>Invoice date</td> 
                                                <td width="1%"></td>
                                                <td width="8%"><gw:datebox id="dtInvDate" lang="1" onchange=""/></td>
                                            </tr>
                                            <tr>  
                                                <td colspan="2" rowspan="2">
                                                    <gw:textarea id="txtImpDesc" styles="width:100%;" rows="3"  />
                                                </td>
                                                <td></td>
                                                <td >8. Contract</td>
                                                <td colspan="7"><gw:textbox id="txtContract" styles='width:100%;'/></td>
                                            </tr>
                                            <tr>  
                                                <td></td>
                                                <td >Date</td>
                                                <td width="8%" colspan="2" ><gw:datebox id="dtContractDate" lang="1" onchange=""/></td>
                                                <td></td>
                                                <td width="1%"></td>
                                                <td width="8%" nowrap>Expire date</td>
                                                <td width="1%"></td>
                                                <td width="8%"><gw:datebox id="dtExpContDate" lang="1" onchange=""/></td>
                                            </tr>
                                            <tr> 
                                                <td width="10%"><a title="Click here to select Consignor" onClick="openPopup(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>3. Consignor</b></a></td>
                                                <td width="39%"><gw:textbox id="txtCondignorPK" styles='display:none;'/><gw:textbox id="txtConsignor"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                <td width="2%"></td> 
                                                <td >9. Import Country</td>
                                                <td><gw:textbox id="txtImpCountry" styles='width:100%;'/></td>
                                                <td colspan="6"><gw:list id="cboImpCountry" styles="width:100%;" onchange="onValueChange(5);"></gw:list></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" rowspan="2">  
                                                    <gw:textarea id="txtConsDesc" styles="width:100%;" rows="3"  />
                                                </td>
                                                <td></td>
                                                <td >10. Export Gate</td>
                                                <td><gw:textbox id="txtExpGate" styles='width:100%;'/></td>
                                                <td colspan="6"><gw:list id="cboExpGate" styles="width:100%;" onchange="onValueChange(4);"></gw:list></td>
                                            </tr>
                                            <tr>
                                                <td></td>  
                                                <td ><a title="Click here to select Trade terms" onClick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>11. Trade terms</b></a></td>
                                                <td><gw:textbox id="txtTradeTerms" styles='width:100%;'/></td>
                                                <td colspan="6"><gw:list id="cboTradeTerms" styles="width:100%;" onchange="onValueChange(2);"></gw:list></td>
                                            </tr>
                                            <tr>
                                                <td width="10%"><a title="Click here to select Forwarder" onClick="openPopup(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>4. Forwarder</b></a></td>
                                                <td width="39%"><gw:textbox id="txtForwarderPK" styles='display:none;'/><gw:textbox id="txtForwarder"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                <td width="2%"></td>
                                                <td nowrap ><a title="Click here to select Payment Method" onClick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>12. Payment Method</b></a></td>  
                                                <td><gw:textbox id="txtPayMethod" styles='width:100%;'/></td>
                                                <td colspan="6"><gw:list id="cboPayMethod" styles="width:100%;" onchange="onValueChange(6);"></gw:list></td>
                                            </tr>
                                            <tr valign="top"> 
                                                <td colspan="2" rowspan="2">
                                                    <gw:textarea id="txtForwarderDesc" styles="width:100%;" rows="3"  />
                                                </td>
                                                <td></td>
                                                <td nowrap ><a title="Click here to select Payment Currency" onClick="AddCommonCode(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>13. Payment Currency</b></a></td>
                                                <td colspan="3">
                                                    <table width="100%" cellpadding=0 cellspacing=0>
                                                        <tr>
                                                            <td width="30%"><gw:textbox id="txtPayCurr" styles='width:100%;' /></td>
                                                            <td width="70%"><gw:list id="cboPayCurr" styles="width:95%;" onchange="onValueChange(3);"></gw:list></td>
                                                        </tr>
                                                    </table>
                                                </td>                                                
                                                <td></td>
                                                <td>Ex. Rate</td>
                                                <td></td>
                                                <td><gw:textbox id="txtExRate" type="number" format="#,###,###,###,###" text="1"  styles='width:100%;'/></td>
                                            </tr>
                                            <tr>
                                                <td colspan ="9"></td>
                                            </tr>
                                            <tr>
                                                <td>Owner</td>
                                                <td><gw:textbox id="txtOwner" styles='width:100%;'/></td>
                                                <td></td>
                                                <td>Carton</td>
                                                <td colspan="3"><gw:textbox id="txtCarton" styles='width:95%;'/></td>
                                                <td></td>
                                                <td>Weight</td>
                                                <td></td>
                                                <td><gw:textbox id="txtWeight" styles='width:100%;'/></td>
                                            </tr>
                                            <tr>
                                                <td>Enclosed Document</td>
                                                <td><gw:textbox id="txtDoc" styles='width:100%;'/></td>
                                                <td></td>
                                                <td>Cont 20"</td>
                                                <td colspan="3"><gw:textbox id="txtCon20" styles='width:95%;'/></td>
                                                <td></td>
                                                <td>Con 40"</td>
                                                <td></td>
                                                <td><gw:textbox id="txtCon40" styles='width:100%;'/></td>
                                            </tr>
                                        </table>
                                    </fieldset>                                 
                                </td>
                            </tr>                          
                        </table>
                        <table name="Declared Items" cellpadding=0 cellspacing=0 width="100%" >
                            <tr>
                                <td width="96%" align="right"><gw:imgbtn id="btnSearchItemFree" img="popup" alt="Get Free Items" text="Get Items" onclick="openPopup(7)" /></td>
                                <td width="1%" ><gw:imgbtn id="btnSearchItem" img="popup" alt="Get Items from Invoice" text="Get Items" onclick="openPopup(5)" /></td>
                                <td width="1%" ><gw:imgbtn id="btnSaveItem" img="save" alt="Save" text="Save" onclick="onSave(1)" /></td>
                                <td width="1%" ><gw:imgbtn id="btnDelItem" img="delete" alt="Delete" text="Delete" onclick="onDelete(1)" /></td>
                                <td width="1%" ><gw:imgbtn id="btnRefreshItem" img="refresh" alt="Refresh" text="Refresh" onclick="dat_epgd00030_2.Call('SELECT');" /></td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                <%--0._1|1.2|2.3|3.4|4.5|5.6|6.7|7.8|8.9|9.10|10.11|11.12|12._|13._tim_decl_mst_pk
                                |14._tco_item_pk|15._tim_cinv_dtl_pk|16._tim_order_pk|17._item_origin|18._cnv_ratio"--%>
                                    <gw:grid   
									    id="grdDetails"  
									    header="_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|_|_tim_decl_mst_pk|_tco_item_pk|_tim_cinv_dtl_pk|_tim_order_pk|_item_origin|_cnv_ratio|_tran_rate|_weight_rate"
									    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    aligns="1|1|2|2|2|2|2|2|2|3|3|3|3|3|3|3|3|3|0|0|0|0|0|0|0|0"  
									    defaults="||||||||||||||||||||||||||"  
									    editcol="0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
									    widths="0|1000|1000|0|0|0|800|0|1000|0|1000|1000|1400|1500|1000|1000|0|0|0|0|0|0|0|0|0|0"  
									    styles="width:100%; height:275"   
									    sorting="T"   
									    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" 
										oncelldblclick=""
										onafteredit="onAfterEditting(this.col)"
						            /> 
                                </td>                                
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr >
                                            <td ></td>
                                            <td ></td>
                                            <td >Transaction Amount</td>
                                            <td ></td>
                                            <td >Tax Calc. Amount</td>
                                        </tr>
                                        <tr >
                                            <td width="67%"></td>
                                            <td width="7%">Total Net</td>
                                            <td width="12%"><gw:textbox id="txtTransTotalNet" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                            <td width="2%"></td>
                                            <td width="12%"><gw:textbox id="txtCalcTotalNet" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >Import Tax</td>
                                            <td ><gw:textbox id="txtTransImport"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcImport"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >Excise Tax</td>
                                            <td ><gw:textbox id="txtTransExcise"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcExcise"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >VAT</td>
                                            <td ><gw:textbox id="txtTransVAT"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcVAT"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >Other Tax</td>
                                            <td ><gw:textbox id="txtTransOtherTax"  text="" type="number" format="#,###,###,###,###.##R"  styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcOtherTax"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >Total Tax</td> 
                                            <td ><gw:textbox id="txtTransTotalTax"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcTotalTax"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table name="Tax Calculation" width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="10%" align="right">Tax Calc. Type</td>
                                <td width="2%"></td>
                                <td width="15%">
                                    <gw:list id="cboTaxType" styles="width:95%" value='ALL' onchange="MergeHeader(1)" >
                                        <data>Data|Exp|Export Tax|EXC|Excise Tax|VAT|VAT|OTH|Others </data>
                                    </gw:list >
                                </td>
                                <td width="70%"></td>
                                <td width="1%"><gw:imgbtn id="btnCalcSave" img="save" alt="Save" text="Save" onclick="onSave(2)" /></td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <gw:grid   
									    id="grdDetails1"  
									    header="_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29"   
									    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    aligns="0|1|2|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"  
									    defaults="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    editcol="0|0|0|0|1|0|1|0|1|0|0|1|0|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1"  
									    widths="100|1000|1000|1000|1000|1400|1500|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"  
									    styles="width:100%; height:275"   
									    sorting="T"   
									    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28" 
										oncelldblclick=""
										onafteredit="onAfterEditting1()"			
									 /> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan=5>
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr >
                                            <td width="67%"></td>
                                            <td width="7%"></td>
                                            <td width="12%">Transaction Amount</td>
                                            <td width="2%"></td>
                                            <td width="12%">Tax Calc. Amount</td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td >Total Net</td>
                                            <td ><gw:textbox id="txtTransTotalNet1" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                            <td ></td>
                                            <td ><gw:textbox id="txtCalcTotalNet1" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td>Import Tax</td>
                                            <td ><gw:textbox id="txtTransImport1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtCalcImport1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td>Excise Tax</td>
                                            <td ><gw:textbox id="txtTransExcise1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtCalcExcise1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td>VAT</td>
                                            <td ><gw:textbox id="txtTransVAT1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtCalcVAT1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td>Other Tax</td>
                                            <td ><gw:textbox id="txtTransOtherTax1" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtCalcOtherTax1" type="number" format="#,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td ></td>
                                            <td>Total Tax</td>
                                            <td ><gw:textbox id="txtTransTotalTax1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td></td>
                                            <td ><gw:textbox id="txtCalcTotalTax1"  text="" type="number" format="#,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </gw:tab>
                </td>
            </tr>
        </table>
    </form> 
</body>
<gw:textbox id="txtMasterPK" styles='display:none;'/>
<gw:textbox id="txtStatus" styles='display:none;'/>
<gw:textbox id="txtlbStatus" styles='display:none;'/>
<gw:textbox id="txtUnit" text="0" styles='display:none;'  />
<gw:textbox id="txtCnvRatio" text="0" styles='display:none;'  />
<gw:textbox id="txtUnitTran"  text=""  styles='display:none'  />  
<gw:textbox id="txtTran_rate"  text=""  styles='display:none'  />
<gw:textbox id="txtItemPK"  text=""  styles='display:none'  />
<gw:textbox id="txtContractPK"  text=""  styles='display:none'  />
<gw:textbox id="txttmp"  text=""  styles='display:none'  />  
<gw:textbox id="txtCompany"  text=""  styles='display:none'  />
<gw:textbox id="txtComCodeID"  text=""  styles='display:none'  />
<gw:textbox id="txtCodeTemp"  text=""  styles='display:none'  />
</html>
