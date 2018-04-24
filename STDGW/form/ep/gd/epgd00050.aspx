<!-- #include file="../../../system/lib/form.inc"  -->

<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Import Declaration</title>
</head>
<%ESysLib.SetUser("comm");%>

<script language="javascript" type="text/javascript">
    var flag, is_unit_change=0, rowchange;  
    var action, isStart;
    action='select';
    isStart =1;
    
    var G1_pk           =0,    
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
        G1_trans_amt    = 16,
        G1_net_bk_amt   = 17,    
        G1_tim_decl_mst_pk  = 18,    
        G1_tco_item_pk      =19,     
        G1_tim_cinv_dtl_pk  = 20,
        G1_tim_order_pk     = 21,    
        G1_item_origin      = 22,     
        G1_cnv_ratio        = 23,     
        G1_tran_rate        = 24,
        G1_weight_rate      = 25;   
        
     function BodyInit()
     {               
        grdDetails.AddRow()
        grdDetails1.AddRow();
        MergeHeader(0)
        MergeHeader(1)
        FormatDetail(grdDetails);
	    FormatDetail(grdDetails1);
	    
	    System.Translate(document);  // Translate to language session
	    
	    txtDept.SetDataText("<%=Session["DEPT_NAME"]%>");  
	    txtUserName.SetDataText("<%=Session["USER_ID"]%>");
	    txtFullName.SetDataText("<%=Session["USER_NAME"]%>");
	    BindingDataList();
	    
	    onNew();
	    txtSlipSeq.text="<%=Request["decl_pk"]%>" 
	    
	    if(txtSlipSeq.text!='')
        {            
            action='view';
            dat_epgd00010_1.Call('SELECT');
        }
	    
     }
     //-----------------------------------------------------------------------------------
     function BindingDataList()
     {   
         var data1 = "<%=ESysLib.SetListDataSQL("select v.pk, v.COUNTRY_NM from imex.tie_country v where del_if=0 order by 2")%>";  //country
         var data2 = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE_NM FROM comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b WHERE a.TCO_ABCODEGRP_PK = b.PK and b.ID = 'IEBD0020' and a.DEL_IF = 0 and b.DEL_IF = 0 and GRP_CODE = 'IM' order by CODE_NM")%>";  //Declaration type 
         var data3 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0010','','') FROM DUAL")%>";  //trade term
         var data4 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>";  //tradding 
         var data5 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEAB0020','','') FROM DUAL")%>";  //status
         var data6 = "<%=ESysLib.SetListDataFUNC("SELECT INITCAP(comm.F_COMMONCODE('ACCR0140','','')) FROM DUAL")%>";  //payment term         
         var data7 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COCI0200','','') FROM DUAL")%>";  //Intercoms 
         var data8 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
                            
         cboCountryName.SetDataText(data1);         
         cboDecType.SetDataText(data2);
         cboTradeTermName.SetDataText(data3); 
         cboCurrency.SetDataText(data4);  
         cboPayMethod.SetDataText(data6);            
         cboCompany.SetDataText(data8);
         cboTransType.SetDataText(data5);
         
         cboCurrency.value='USD';
         getExRate();
         <%=ESysLib.SetGridColumnComboFormat("grdDetails", 6, "select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM from comm.tco_uom a where del_if=0")%>; 
         <%=ESysLib.SetGridColumnComboFormat("grdDetails", 7, "select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM from comm.tco_uom a where del_if=0")%>; 
         <%=ESysLib.SetGridColumnComboFormat("grdDetails", 8, "select a.UOM_CODE, decode(nvl(a.cnv_ratio,1),1,'',to_char(nvl(a.cnv_ratio,1),'9,990'))|| ' ' || a.UOM_NM from comm.tco_uom a where del_if=0  and upper(DIMENSION_TYPE)='WET'")%>; 
         
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
				
			    if(txtCurrencyCode.GetData()=='VND')
			    {
    		
    		        ctrl.ColFormat(G1_u_price)   = "###,###,###,###,###";
				    ctrl.ColFormat(G1_ext_price)   = "###,###,###,###,###";
				    ctrl.ColFormat(G1_re_ext_price)   = "###,###,###,###,###";
				    ctrl.ColFormat(G1_trans_amt)   = "###,###,###,###,###";
				    ctrl.ColFormat(G1_net_bk_amt)   = "###,###,###,###,###";
			    }
			    else
			    {
			        ctrl.ColFormat(G1_u_price)   = "###,###,###,###,###.##";
				    ctrl.ColFormat(G1_ext_price)   = "###,###,###,###,###.##";
				    ctrl.ColFormat(G1_re_ext_price)   = "###,###,###,###,###.##";
				    ctrl.ColFormat(G1_trans_amt)   = "###,###,###,###,###.##";
				    ctrl.ColFormat(G1_net_bk_amt)   = "###,###,###,###,###.##";
			    }
		    break;
		    case "grdDetails1":
			    if(txtCurrencyCode.GetData()=='VND')
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
	//---------------------------------------------------------------------
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
	         fg.Cell(0, 0,1, 1, 1) = "No."
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
		     fg.Cell(0,0,10,1,10)="Qty."
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
		     fg.ColWidth(6)=1200;  // unit
		     fg.ColWidth(7)=1200;  // unit packing
		     fg.ColWidth(8)=1200;  // unit wt
		     fg.ColWidth(9)=1200;  // U/Price
		     fg.ColWidth(10)=1000;  // Qty
		     fg.ColWidth(11)=1000;  // Qty Packing
		     fg.ColWidth(12)=1000;  // Net Wt
		     fg.ColWidth(13)=1000;  // Gross wt
		     fg.ColWidth(14)=1400; // Quantity	
		     fg.ColWidth(15)=1500; // Extended Price	
	 	     fg.ColWidth(16)=1500; // Retouch Amt	
	  	     fg.ColWidth(17)=1500; // Adj Ext. Price
		     fg.ColWidth(18)=1500; // Adj Ext. Price
	      break;
	      case 1:
	 	        switch(cboTaxType.GetData())
		        {
			        case "IMP":
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
						
																																	
				        fg.ColWidth(1)=1000;  // No.
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
																											
				        fg.ColWidth(1)=1000;  // No.
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
																											
				        fg.ColWidth(1)=1000;  // No.
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
 //--------------------------------------------------------------------------------------
function SetStatus(index)
{
    txtImporter.SetEnable(false);  
    txtImportDesc.SetEnable(false);
    txtRegNo.SetEnable(false);
    txtCountryCode.SetEnable(false);
    txtTradeTermCode.SetEnable(false); 
    txtPlaceDischargeCD.SetEnable(false); 
    txtCurrencyCode.SetEnable(false);
    txtDecTypeCode.SetEnable(false);
    txtSlipSeq.SetEnable(false); 
    txtPlaceLoading.SetEnable(false);  
    txtPlaceDischarge.SetEnable(false);
    
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
    
    txtTransTotalNet.SetEnable(false);  
    txtTransTotalNet1.SetEnable(false);
    txtCalcTotalNet.SetEnable(false); 
    txtCalcTotalNet1.SetEnable(false);
    
    switch(index)
    {
        case '4':
            //view form
            btnSearch.style.display="none";
            btnNew.style.display="none";
            btnSave.style.display="none";
            btnDel.style.display="none";
            btnExcel.style.display="none";
            btnPrtPKL.style.display="none"; 
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
            grdDetails.SetColEdit(G1_qty_packing,0);
            grdDetails.SetColEdit(G1_net_weight,0);
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
            btnPrtPKL.style.display="none"; 
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
            grdDetails.SetColEdit(G1_qty_packing,0);
            grdDetails.SetColEdit(G1_net_weight,0);
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
            btnPrtPKL.style.display=""; 
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
            grdDetails.SetColEdit(G1_qty_packing,0);
            grdDetails.SetColEdit(G1_net_weight,0);
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
            btnPrtPKL.style.display="none"; 
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
            grdDetails.SetColEdit(G1_qty_packing,1);
            grdDetails.SetColEdit(G1_net_weight,1);
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
    //----------------------------------------------------------------------------
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
	                txtOfficeName.SetDataText(aValue[2]); 
	                txtOfficeCode.SetDataText(aValue[1]);  
	                txtOfficePK.SetDataText(aValue[0]);  
	            }	
	        break;
	        case 1:// Importer txtImporterPK
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; 
	            var desc;
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {        
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                txtImporter.SetDataText(aValue[2]);  
	                //txtOfficeCode.SetDataText(aValue[0]);  
	                txtImporterPK.SetDataText(aValue[0]);  
	                txtImportDesc.SetDataText(desc);
	            }	
	        break; 
	        case 2://  Importer txtImporterPK  Exporter  txtExporterPK
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; 
	            var desc;
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {        
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                txtExporter.SetDataText(aValue[2]);  
	                txtExporterPK.SetDataText(aValue[0]);
	                txtExportDesc.SetDataText(desc);  
	            }	
	        break; 
	        case 3:// Importer txtImporterPK  Exporter  txtExporterPK  Consignor   txtConsignorPK  Logistics  txtLogisticsPK
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR"; 
	            var desc;
                aValue = System.OpenModal( fpath , 900 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {     
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];   
	                txtConsignor.SetDataText(aValue[2]);  
	                txtConsignorPK.SetDataText(aValue[0]);  
	                txtConsignorDesc.SetDataText(desc); 
	            }	
	        break; 
	        case 4:// Logistics  
	            var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AR";
	            var desc;
                aValue = System.OpenModal( fpath , 700 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {        
	                desc=aValue[7] + ' Tel: ' + aValue[10] + ' Fax: ' + aValue[12] + ' Email: ' + aValue[11];
	                txtLogistics.SetDataText(aValue[2]); 	               
	                txtLogisticsPK.SetDataText(aValue[0]);  
	                txtLogisticsDesc.SetDataText(desc);
	            }	
	        break; 
	        case 5:
                var fpath = System.RootURL + "/form/ep/gd/epgd00010_1.aspx" ;
                var obj = System.OpenModal( fpath , 800 ,600, 'resizable:yes;status:yes;');
                if (obj!=null)
                { 
                    txtReceiver.text=obj[2];
                    txtReceiverPK.text=obj[0];
                }
            break;
            case 6: // Commercial Invoice
                var fpath = System.RootURL + "/form/ep/gd/epgd00010_Invoice.aspx" ;
                var arrData = System.OpenModal( fpath , 900 ,600, 'resizable:yes;status:yes;');
                if (arrData!=null)
                {        
        // txtExporter  txtExporterPK txtExportDesc
                    var Data =new Array();
                    Data=arrData[0];    // master
                    txttim_cinv_mst_a.text  = Data[0];  //  _PK   
                    txtOfficePK.text        = Data[1];  
                    txtOfficeCode.text      = Data[2];
                    txtOfficeName.text      = Data[3]; 
                    dtInvoiceDate.value     = Data[4];  //  4.	CO_INVOICE_DATE           
                    txtInvoiceNo.text       = Data[5];  //  5.	CO_INVOICE_NO           
                    txtItemOrigin.text      = Data[6];  //  6.	ITEM_ORIGIN          
                    cboTransType.value      = Data[7];  //  7.	TRANSPORT_BY  
                    dtArrivalDate.value     = Data[8];  //  8.	SHIP_DATE  
                    txtConsignorPK.text     = Data[9]; 
                    txtConsignor.text       = Data[10]; 
                    txtConsignorDesc.text   = Data[18];        
                    txtPlaceLoading.text    = Data[11];  //  11.	PLC_LOADING   
                    txtPlaceDischargeCD.text  = Data[12];  //  12.	PLC_DISCHARGE       
                    //cboPlaceDischarge.value = Data[12];     
                    txtTradeTermCode.text   = Data[13];  //  13.	TRADE_TERMS         
                    cboTradeTermName.value  = Data[13];   
                    cboPayMethod.value      = Data[14];  //  14.	PAY_METH           
                    txtCurrencyCode.text    = Data[15];  //  15.	PAY_CCY       
                    cboCurrency.value       = Data[15];     
                    txtExRate.text          = Data[16];  //  16.	PAY_EX_RATE  
                    dtContractExpiry.value  = Data[21];  
                    dtContractDate.value    = Data[20];  
                    txtContractNo.text      = Data[19];
                    
                    // detail
                    var rows;
	                rows=arrData.length;
	                
	                for(var i=1; i<rows; i++)   
	                {
	                    var aValue =new Array();
                        aValue=arrData[i]; 
	                	grdDetails.AddRow();
	                	grdDetails.SetGridText(grdDetails.rows-1, G1_rownum ,i); 
	                	grdDetails.SetGridText(grdDetails.rows-1, G1_tim_cinv_dtl_pk ,aValue[0]);      //_tim_cinv_dtl_PK           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_item_origin ,txtItemOrigin.text );      //1.	_origin
                        grdDetails.SetGridText(grdDetails.rows-1, G1_tco_item_pk ,aValue[2]);      //2.	_TCO_ITEM_PK           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_tim_order_pk ,aValue[3]);      //3.	_TIM_ORDER_PK 
                        grdDetails.SetGridText(grdDetails.rows-1, G1_order_no ,aValue[4]);      //4.	order_no                
                        grdDetails.SetGridText(grdDetails.rows-1, G1_item_code ,aValue[5]);      //5.	ITEM_CODE           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_item_name ,aValue[6]);      //6.	ITEM_NAME           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_hs_code ,aValue[7]);      //7.	HS_CODE           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_unit_cd ,aValue[8]);      //8.	UNIT_CD           
                        grdDetails.SetGridText(grdDetails.rows-1, G1_u_price ,aValue[9]);      //9.	U_PRICE   
                        grdDetails.SetGridText(grdDetails.rows-1, G1_qty ,aValue[10]);     //10.	DECL_QTY  
                        grdDetails.SetGridText(grdDetails.rows-1, G1_cnv_ratio ,aValue[11]); 
                        
                        grdDetails.SetGridText(grdDetails.rows-1, G1_unit_packing ,aValue[12]);  // unit_pack
                        grdDetails.SetGridText(grdDetails.rows-1, G1_qty_packing ,aValue[13]); //qty_pack
                        grdDetails.SetGridText(grdDetails.rows-1, G1_tran_rate ,aValue[14]);  //tran_rate
                        
                        grdDetails.SetGridText(grdDetails.rows-1, G1_unit_weight ,aValue[16]); 
                        grdDetails.SetGridText(grdDetails.rows-1, G1_net_weight ,aValue[17]); 
                        grdDetails.SetGridText(grdDetails.rows-1, G1_gross_weight ,aValue[17]); 
                        grdDetails.SetGridText(grdDetails.rows-1, G1_weight_rate ,aValue[15]); 
                        
                        if(!isNaN(aValue[11])) 
                            grdDetails.SetGridText(grdDetails.rows-1, G1_ext_price ,Number(grdDetails.GetGridData(grdDetails.rows-1, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.rows-1, G1_qty))/Number(aValue[11]));
                        else
                            grdDetails.SetGridText(grdDetails.rows-1, G1_ext_price ,Number(grdDetails.GetGridData(grdDetails.rows-1, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.rows-1, G1_qty)));
                        
                        grdDetails.SetGridText(grdDetails.rows-1, G1_trans_amt ,Number(grdDetails.GetGridData(grdDetails.rows-1, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.rows-1, G1_re_ext_price)));             
                        grdDetails.SetGridText(grdDetails.rows-1, G1_net_bk_amt,(Number(grdDetails.GetGridData(grdDetails.rows-1, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.rows-1, G1_re_ext_price)))*Number(txtExRate.text));             
                        grdDetails.GetGridControl().AutoSize(0,25,false,0);
	                }
	                var NetValue;
                    NetValue=0;
                    var ctrl=grdDetails.GetGridControl();
                    for (i=2; i<ctrl.Rows; i++)
	                {
		                temp= grdDetails.GetGridData(i,G1_trans_amt);
		                NetValue=Number(NetValue) + Number(temp) ;    		
	                }
	                txtTransTotalNet.SetDataText('' + NetValue);	    
	                txtTransTotalNet1.SetDataText('' + NetValue);
                }               
            break;
            case 7:
                var fpath = System.RootURL + "/form/ep/gd/epgd00010_Billing.aspx?tie_bl_mst="+txttie_bl_mst_pk.text ;
                var obj = System.OpenModal( fpath , 1000 ,650, 'resizable:yes;status:yes;');
                if (obj!=null)
                {  
                    txtBillingNo.text=obj[1];
                    dtBillingDate.value=obj[2];
                    txttie_bl_mst_pk.text=obj[0];
                }
            break;
            case 8:
                var fpath = System.RootURL + "/form/ep/gd/epgd00010_SearchDecl.aspx" ; 
                var obj = System.OpenModal( fpath , 930 ,600, 'resizable:yes;status:yes;');
                if (obj!=null)
                {  
                    txtSlipSeq.text=obj[0];
                    dat_epgd00010_1.Call('SELECT');
                }
            break;        
            case 9:        
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPlaceLoading.SetDataText(aValue[3]); 
	                txtPlaceLoadingCD.SetDataText(aValue[2]);  
	            }	
	        break;
	        case 10: 
	            var fpath = System.RootURL + "/form/ep/ac/GetPort.aspx"; //customs
                aValue = System.OpenModal( fpath , 750 , 500, 'resizable:yes;status:yes');
	            if ( aValue != null )
	            {          
	                txtPlaceDischarge.SetDataText(aValue[3]); 
	                txtPlaceDischargeCD.SetDataText(aValue[2]);  
	            }	
	        break;
	        case 11:
	            fpath = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=||Y|Y|Y|Y";
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
//	                    <%--0._PK|1.Item Code|2.Item Name|3._tco_itemgrp_pk|4.Item Group|5.Unit|6.Stock Qty.
        //            |7.Price|8._LisPrice|9._StPrice|10._LmPrice|11._MkPrice|12._pur_type|13._volume
        //            |14._tin_warehouse_pk|15._partner_pk|16._partner_id|17._partner_name|18.Description
        //            |19._HS_CODE|20._cnv_ratio|21._uom_packing|22._tran_rate|23._weight_rate"--%>
          
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
                            grdDetails.SetGridText(grdDetails.rows-1, G1_unit_packing ,aValue[24]);  // unit_pack
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
    //----------------------------------------------------------------------------
     function onSave(index)
     {
        switch (index)
        {
            case 0:
                if(ValidateData())
                {
                    action='save';
                    dat_epgd00010_1.Call('');
                }                
            break;
            case 1:
                action='save';
                grdDetails.SetRowStatus(1,'_');
                for(var i=2;i<grdDetails.rows;i++)
                    if (grdDetails.GetGridData(i,0)=='')
                        grdDetails.SetGridText(i, G1_tim_decl_mst_pk ,txtSlipSeq.text);
                dat_epgd00010_2.Call('');
            break;
            case 2:
                action='save';
                grdDetails1.SetRowStatus(1,'_');
                dat_epgd00010_3.Call('');
            break;
        }
     }
     //----------------------------------------------------------------------------
     function onNew()
     {
        txtSlipSeq.SetDataText("-1");
        SetStatus("1");
        btnSaveItem.SetEnable(false);
        btnCalcSave.SetEnable(false);
        dat_epgd00010_1.StatusInsert();
        grdDetails.ClearData();
        grdDetails1.ClearData();
        onValueChange(1);
        onValueChange(2);
        onValueChange(3);
        onValueChange(4);
        onValueChange(5);
        grdDetails.AddRow()
        grdDetails1.AddRow();
        MergeHeader(0)
        MergeHeader(1)
        txtStatusNum.text="1";
        lbStatus.text= "";
        SetStatus("1");
        isStart =1;
        dat_epgd00010_5.Call('SELECT');
     }
     //-------------------------------------------------------------------
    function OnDataReceive(obj)
    {
        switch(obj.id)
        {
            case 'dat_epgd00010_1' :
                flag=0;
                
                lbStatus.text =txtStatus.text;
                if (txtSlipSeq.text!='')
                {
                    btnSaveItem.SetEnable(true);
                    btnCalcSave.SetEnable(true);
                }
                
                if(action=='view')
                    SetStatus("4");
                else
                    SetStatus(txtStatusNum.text);
                    
                if (action=='save')
                    onSave(1);
                else
                {                                        
                    dat_epgd00010_2.Call('SELECT');
                }
                    
            break;
            case 'dat_epgd00010_2':
                MergeHeader(0);
                for(i=2; i<grdDetails.rows; i++)
                    grdDetails.SetGridText(i, 1, i-1);
                grdDetails.GetGridControl().AutoSize(0,25,false,0); 
               if (action=='save') dat_epgd00010_9.Call();
            break;
            case 'dat_epgd00010_3':            
                MergeHeader(1);
                for(i=2; i<grdDetails1.rows; i++)
                    grdDetails1.SetGridText(i, 1, i-1);
                if (action=='save') dat_epgd00010_6.Call();
            break;
            case 'dat_epgd00010_4':
                if(txtSlipSeq.text!='')
                {
                    action='select';
                    dat_epgd00010_1.Call('SELECT');
                }                    
                else
                    onNew();
            break;
            case 'dat_epgd00010_5':
                if(isStart==1)
                {
                    isStart =0;
                    dat_epgd00010_11.Call();
                }                
            break;
            case 'dat_epgd00010_7':
                if(txtStatusNum.text=="2")
                    lbStatus.text="Confirmed";
                else
                    if(txtStatusNum.text=="3")
                        lbStatus.text="Cancelled";
                SetStatus(txtStatusNum.text);
            break;
            case 'dat_epgd00010_8':
                txtStatusNum.text="1";
                lbStatus.text='Saved';
                SetStatus(txtStatusNum.text);
                dat_epgd00010_1.Call('SELECT');
            break;
            case 'dat_epgd00010_9':               
                txtCalcTotalNet1.text=  txtCalcTotalNet.text;
                dat_epgd00010_3.Call("SELECT"); 
            break;
            case 'dat_epgd00010_10':             
                grdDetails.SetGridText(rowchange, G1_cnv_ratio , txtCnvRatio.text);
                onAfterEditting(G1_u_price);
                if(is_unit_change ==1)
                    onAfterEditting(G1_unit_packing);
            break;
            case 'dat_epgd00010_12':
                grdDetails.SetGridText(rowchange, G1_tran_rate, txtTran_rate.text);
                grdDetails.SetGridText(rowchange, G1_qty_packing,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_tran_rate)));
                if(is_unit_change ==1)
                    onAfterEditting(G1_unit_weight);
            break;
            case 'dat_epgd00010_13':
                grdDetails.SetGridText(rowchange, G1_weight_rate, txtTran_rate.text);            
                is_unit_change =0;
                grdDetails.SetGridText(rowchange, G1_net_weight,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_weight_rate)));
                grdDetails.SetGridText(rowchange, G1_gross_weight,Number(grdDetails.GetGridData(rowchange, G1_qty))*Number(grdDetails.GetGridData(rowchange, G1_weight_rate)));
            break;
            case 'dat_epgd00010_14':
                dat_epgd00010_15.Call();
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
        }    
    } 
    
    //--------------------------------------------------------------------------------------
     function onAfterEditting(colidx)
     {
        if(colidx==G1_unit_cd)
        {
            is_unit_change = 1;
            rowchange = grdDetails.row;
            txtUnit.text= grdDetails.GetGridData(grdDetails.row,G1_unit_cd);
            dat_epgd00010_10.Call();
        }
        
        if(colidx==G1_unit_packing)
        {
            if(is_unit_change ==0)
                rowchange = grdDetails.row;
            txtItemPK.text = grdDetails.GetGridData(grdDetails.row, G1_tco_item_pk);
            txtUnit.text= grdDetails.GetGridData(grdDetails.row, G1_unit_cd);
            txtUnitTran.text = grdDetails.GetGridData(grdDetails.row, G1_unit_packing);
            dat_epgd00010_12.Call();
        } 
        
        if(colidx==G1_unit_weight)
        {
            if(is_unit_change ==0) 
                rowchange = grdDetails.row;
            txtItemPK.text = grdDetails.GetGridData(grdDetails.row, G1_tco_item_pk);
            txtUnit.text= grdDetails.GetGridData(grdDetails.row, G1_unit_cd);
            txtUnitTran.text = grdDetails.GetGridData(grdDetails.row, G1_unit_weight);
            dat_epgd00010_13.Call();
        } 
           
        if ((colidx==G1_u_price)||(colidx==G1_qty)) //Price, Qty.
        {        
//           if ((!isNaN(grdDetails.GetGridData(grdDetails.row,G1_qty))) && (!isNaN(grdDetails.GetGridData(grdDetails.row,G1_u_price))) )
//           {
               grdDetails.SetGridText(grdDetails.row, G1_qty_packing,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_tran_rate)));
               grdDetails.SetGridText(grdDetails.row, G1_net_weight,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_weight_rate)));
               grdDetails.SetGridText(grdDetails.row, G1_gross_weight,Number(grdDetails.GetGridData(grdDetails.row, G1_qty))*Number(grdDetails.GetGridData(grdDetails.row, G1_weight_rate)));
               
               if (!isNaN(grdDetails.GetGridData(grdDetails.row,G1_cnv_ratio))) 
               {                   
                   grdDetails.SetGridText(grdDetails.row, G1_ext_price,Number(grdDetails.GetGridData(grdDetails.row, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.row, G1_qty))/Number(grdDetails.GetGridData(grdDetails.row, G1_cnv_ratio)));
                   grdDetails.SetGridText(grdDetails.row, G1_trans_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
               }
               else
               {
                    grdDetails.SetGridText(grdDetails.row, G1_ext_price,Number(grdDetails.GetGridData(grdDetails.row, G1_u_price))*Number(grdDetails.GetGridData(grdDetails.row, G1_qty)));
                   grdDetails.SetGridText(grdDetails.row, G1_trans_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row, G1_re_ext_price)));
               }
//           }
//           else
//           {
//                alert("You must input a number!");
//                grdDetails1.SetGridText(grdDetails.row,colidx,'');
//           }  
        } 
        if (colidx==G1_re_ext_price) //	Retouch Amt 
        {                
           if(!isNaN(grdDetails.GetGridData(grdDetails.row,G1_re_ext_price)))
           {           
               grdDetails.SetGridText(grdDetails.row, G1_trans_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row,G1_re_ext_price)));
           }
           else
           {
              alert("Retouch Amt must be a number!");
              grdDetails.SetGridText(grdDetails.row,G1_re_ext_price,'')
              grdDetails.SetGridText(grdDetails.row, G1_trans_amt,Number(grdDetails.GetGridData(grdDetails.row, G1_ext_price))+Number(grdDetails.GetGridData(grdDetails.row,G1_re_ext_price)));
           }           
        } 
        var NetValue;
        NetValue=0;
        var ctrl=grdDetails.GetGridControl();
        for (i=2; i<ctrl.Rows; i++)
	    {
		    temp= grdDetails.GetGridData(i, G1_trans_amt);
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
        if (colidx==4)
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,4)))
           {
               grdDetails1.SetGridText(grdDetails1.row,5,Number(grdDetails1.GetGridData(grdDetails1.row,3))+Number(grdDetails1.GetGridData(grdDetails1.row,4)));               
           }
           else
           {
                alert("You must input a number!");
                grdDetails1.SetGridText(grdDetails1.row,4,'');
                grdDetails1.SetGridText(grdDetails1.row,5,Number(grdDetails1.GetGridData(grdDetails1.row,3))+Number(grdDetails1.GetGridData(grdDetails1.row,4)));               
           }
        } 
        
        if (colidx==6) // Import rate
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,6)))
           {
               grdDetails1.SetGridText(grdDetails1.row,7,Number(grdDetails1.GetGridData(grdDetails1.row,6))*Number(grdDetails1.GetGridData(grdDetails1.row,5))/100);               
               grdDetails1.SetGridText(grdDetails1.row,9,Number(grdDetails1.GetGridData(grdDetails1.row,7))+Number(grdDetails1.GetGridData(grdDetails1.row,8)));
               grdDetails1.SetGridText(grdDetails1.row,10,Number(grdDetails1.GetGridData(grdDetails1.row,9))/ Number(txtExRate.text));               
           }
           else 
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,6,'');
               grdDetails1.SetGridText(grdDetails1.row,7,Number(grdDetails1.GetGridData(grdDetails1.row,6))*Number(grdDetails1.GetGridData(grdDetails1.row,5))/100);               
               grdDetails1.SetGridText(grdDetails1.row,9,Number(grdDetails1.GetGridData(grdDetails1.row,7))+Number(grdDetails1.GetGridData(grdDetails1.row,8)));
               grdDetails1.SetGridText(grdDetails1.row,10,Number(grdDetails1.GetGridData(grdDetails1.row,9))/ Number(txtExRate.text));               
           }
        } 
        
        if (colidx==8)  // adj import
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,8)))
           {
               grdDetails1.SetGridText(grdDetails1.row,9,Number(grdDetails1.GetGridData(grdDetails1.row,7))+Number(grdDetails1.GetGridData(grdDetails1.row,8)));               
               grdDetails1.SetGridText(grdDetails1.row,10,Number(grdDetails1.GetGridData(grdDetails1.row,9))/ Number(txtExRate.text));               
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,8,'');
               grdDetails1.SetGridText(grdDetails1.row,9,Number(grdDetails1.GetGridData(grdDetails1.row,7))+Number(grdDetails1.GetGridData(grdDetails1.row,8)));               
               grdDetails1.SetGridText(grdDetails1.row,10,Number(grdDetails1.GetGridData(grdDetails1.row,9))/ Number(txtExRate.text));               
           }
        } 
        grdDetails1.SetGridText(grdDetails1.row,11,Number(grdDetails1.GetGridData(grdDetails1.row,5))+Number(grdDetails1.GetGridData(grdDetails1.row,7))+Number(grdDetails1.GetGridData(grdDetails1.row,8)));               
        
        if (colidx==12) // excise rate
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,12)))
           {
               grdDetails1.SetGridText(grdDetails1.row,13,Number(grdDetails1.GetGridData(grdDetails1.row,11))*Number(grdDetails1.GetGridData(grdDetails1.row,12))/100);               
               grdDetails1.SetGridText(grdDetails1.row,15,Number(grdDetails1.GetGridData(grdDetails1.row,13)));               
               grdDetails1.SetGridText(grdDetails1.row,16,Number(grdDetails1.GetGridData(grdDetails1.row,15))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,12,'');
               grdDetails1.SetGridText(grdDetails1.row,13,Number(grdDetails1.GetGridData(grdDetails1.row,11))*Number(grdDetails1.GetGridData(grdDetails1.row,12))/100);               
               grdDetails1.SetGridText(grdDetails1.row,15,Number(grdDetails1.GetGridData(grdDetails1.row,13)));     
               grdDetails1.SetGridText(grdDetails1.row,16,Number(grdDetails1.GetGridData(grdDetails1.row,15))/ Number(txtExRate.text));                                                    
           }
        } 
        if (colidx==14) // adj excise
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,14)))
           {
               grdDetails1.SetGridText(grdDetails1.row,15,Number(grdDetails1.GetGridData(grdDetails1.row,13))+Number(grdDetails1.GetGridData(grdDetails1.row,14)));   
               grdDetails1.SetGridText(grdDetails1.row,16,Number(grdDetails1.GetGridData(grdDetails1.row,15))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,14,'');
               grdDetails1.SetGridText(grdDetails1.row,15,Number(grdDetails1.GetGridData(grdDetails1.row,13))+Number(grdDetails1.GetGridData(grdDetails1.row,14)));   
               grdDetails1.SetGridText(grdDetails1.row,16,Number(grdDetails1.GetGridData(grdDetails1.row,15))/ Number(txtExRate.text));                                         
           }
        } 
        grdDetails1.SetGridText(grdDetails1.row,17,Number(grdDetails1.GetGridData(grdDetails1.row,11))+Number(grdDetails1.GetGridData(grdDetails1.row,13))+Number(grdDetails1.GetGridData(grdDetails1.row,14)));               
        if (colidx==18) // vat rate
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,18)))
           {
               grdDetails1.SetGridText(grdDetails1.row,19,Number(grdDetails1.GetGridData(grdDetails1.row,17))*Number(grdDetails1.GetGridData(grdDetails1.row,18))/100);               
               grdDetails1.SetGridText(grdDetails1.row,21,Number(grdDetails1.GetGridData(grdDetails1.row,19)));               
               grdDetails1.SetGridText(grdDetails1.row,22,Number(grdDetails1.GetGridData(grdDetails1.row,21))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,18,'');
               grdDetails1.SetGridText(grdDetails1.row,19,Number(grdDetails1.GetGridData(grdDetails1.row,17))*Number(grdDetails1.GetGridData(grdDetails1.row,18))/100);               
               grdDetails1.SetGridText(grdDetails1.row,21,Number(grdDetails1.GetGridData(grdDetails1.row,19)));               
               grdDetails1.SetGridText(grdDetails1.row,22,Number(grdDetails1.GetGridData(grdDetails1.row,21))/ Number(txtExRate.text));                                         
           }
        } 
        if (colidx==20) // adj vat
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,20)))
           {
               grdDetails1.SetGridText(grdDetails1.row,21,Number(grdDetails1.GetGridData(grdDetails1.row,19))+Number(grdDetails1.GetGridData(grdDetails1.row,20)));   
               grdDetails1.SetGridText(grdDetails1.row,22,Number(grdDetails1.GetGridData(grdDetails1.row,21))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,20,'');
               grdDetails1.SetGridText(grdDetails1.row,21,Number(grdDetails1.GetGridData(grdDetails1.row,19))+Number(grdDetails1.GetGridData(grdDetails1.row,20)));   
               grdDetails1.SetGridText(grdDetails1.row,22,Number(grdDetails1.GetGridData(grdDetails1.row,21))/ Number(txtExRate.text));                                         
           }
        } 
        grdDetails1.SetGridText(grdDetails1.row,23,Number(grdDetails1.GetGridData(grdDetails1.row,17))+Number(grdDetails1.GetGridData(grdDetails1.row,19))+Number(grdDetails1.GetGridData(grdDetails1.row,20)));               
        if (colidx==24)  // other rate
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,24)))
           {
               grdDetails1.SetGridText(grdDetails1.row,25,Number(grdDetails1.GetGridData(grdDetails1.row,23))*Number(grdDetails1.GetGridData(grdDetails1.row,24))/100);               
               grdDetails1.SetGridText(grdDetails1.row,27,Number(grdDetails1.GetGridData(grdDetails1.row,25)));               
               grdDetails1.SetGridText(grdDetails1.row,28,Number(grdDetails1.GetGridData(grdDetails1.row,27))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,24,'');
               grdDetails1.SetGridText(grdDetails1.row,25,Number(grdDetails1.GetGridData(grdDetails1.row,23))*Number(grdDetails1.GetGridData(grdDetails1.row,24))/100);               
               grdDetails1.SetGridText(grdDetails1.row,27,Number(grdDetails1.GetGridData(grdDetails1.row,25)));   
               grdDetails1.SetGridText(grdDetails1.row,28,Number(grdDetails1.GetGridData(grdDetails1.row,27))/ Number(txtExRate.text));                                                     
           }
        } 
        if (colidx==26)  // adj other
        {                
           if (!isNaN(grdDetails1.GetGridData(grdDetails1.row,26)))
           {
               grdDetails1.SetGridText(grdDetails1.row,27,Number(grdDetails1.GetGridData(grdDetails1.row,25))+Number(grdDetails1.GetGridData(grdDetails1.row,26)));   
               grdDetails1.SetGridText(grdDetails1.row,28,Number(grdDetails1.GetGridData(grdDetails1.row,27))/ Number(txtExRate.text));                                         
           }
           else
           {
               alert("You must input a number!");
               grdDetails1.SetGridText(grdDetails1.row,26,'');
               grdDetails1.SetGridText(grdDetails1.row,27,Number(grdDetails1.GetGridData(grdDetails1.row,25))+Number(grdDetails1.GetGridData(grdDetails1.row,26)));   
               grdDetails1.SetGridText(grdDetails1.row,28,Number(grdDetails1.GetGridData(grdDetails1.row,27))/ Number(txtExRate.text));                                         
           }
        } 
        Total();      
     }    
     //----------------------------------------------------------------------------
     function ValidateData()
     {
//        if(txtSlipNo.text=='')
//        {
//            alert("You must input Declaration No first!");
//            return false;
//        }  // so to khai ko co truoc, phai doi hải quan cho
        return true;
     }
     //----------------------------------------------------------------------------
     function ValidateConfirm()
     {  
        if(txtOfficePK.text=='')
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
//        if(txtConsignorPK.text=='')
//        {
//            alert("You must input Consignor!");
//            return false;
//        }
//        if(txtLogisticsPK.text=='')
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
     function onCancel()
     {
        if(confirm('Do you want to cancel this declaration ?'))
	    {
	        txtStatusNum.text="3";
            dat_epgd00010_7.Call();
	    }        
     }
     //----------------------------------------------------------------------------
     function onCopy()
     {
        dat_epgd00010_8.Call();   
     }
     //----------------------------------------------------------------------------
     function onConfirm()
     {
        if(ValidateConfirm())
        {
            txtStatusNum.text="2";
            dat_epgd00010_7.Call();
        }
     }
     //----------------------------------------------------------------------------
     function onRegenerate()
     {
        dat_epgd00010_8.Call();
     }
     //----------------------------------------------------------------------------
     function onInputData()
     {
        dat_epgd00010_14.Call();
     }
     //----------------------------------------------------------------------------
     function onDelete(index)
     {
        switch (index)
        {
            case 0: // xoa phieu
                if(confirm('Do you want to delete this declaration ?'))
	            {
	                dat_epgd00010_1.StatusDelete();
	                dat_epgd00010_1.Call('');
	            }    
            break;
            case 1: // xoa item
                if(confirm('Do you want to delete this item ?'))
	            {
	                grdDetails.DeleteRow();
	            }
            break; 
        }
     }              
    //-------------------------------------------------------------------
    function OnCheckTab()
    {
        var index;
        index=idTab.GetCurrentPageNo();    
        if (index==2)
            if (flag==0)
            {
                dat_epgd00010_3.Call("SELECT");   
                flag=1; 
            }  
    }    
    //-------------------------------------------------------------------
    function Total()
    { 
        var ctrl=grdDetails.GetGridControl();
	    var ctrl1=grdDetails1.GetGridControl();
	    var NetValue=0,tax_amt=0;
	
	    // for tax tab	    
	    var Net_Tr_Amt=0, Tr_Amt1=0, Tr_Amt2=0, Tr_Amt3=0, Tr_Amt4=0, Tr_Total=0;
	    var Adj_Tr_Amt=0, Adj_Amt1=0, Adj_Amt2=0, Adj_Amt3=0, Adj_Amt4=0, Adj_Total=0;

	    for(j=2;j<ctrl1.Rows;j++)
	    {
		    temp=grdDetails1.GetGridData(j,5);
		    Adj_Tr_Amt=Number(Adj_Tr_Amt) + Number(temp);
		    txtCalcTotalNet.SetDataText('' + Adj_Tr_Amt);
		    txtCalcTotalNet1.SetDataText('' + Adj_Tr_Amt);
    		
		    temp=grdDetails1.GetGridData(j,10);
		    Tr_Amt1=Number(Tr_Amt1) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,9);
		    Adj_Amt1=Number(Adj_Amt1) + Number(temp);
    		
    		temp=grdDetails1.GetGridData(j,16);
		    Tr_Amt2=Number(Tr_Amt2) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,15);
		    Adj_Amt2=Number(Adj_Amt2) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,22);
		    Tr_Amt3=Number(Tr_Amt3) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,21);
		    Adj_Amt3=Number(Adj_Amt3) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,28);
		    Tr_Amt4=Number(Tr_Amt4) + Number(temp);
    		
		    temp=grdDetails1.GetGridData(j,27);
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
    //-----------------------------------------------------------------------------------    
    function OnLoadNew(scode)
    {	
        datGetNewCode.Call('SELECT');
//	    var t=new Date()
//	    var url =  System.RootURL + "/form/ep/gd/epgd00010_searchidcode.aspx?id=" + scode;
//	    ajax_test2 = null;
//	    ajax_test2 = GetXmlHttpRequest(return_result);
//	    ajax_test2.open("GET", url , true);
//	    ajax_test2.send(null);
    }    
    //-------------------------------------------------------------------------------------
    function OnBackNext(index)
    {
        txtTypeSel.text=index;
        dat_epgd00010_4.Call();
    }
    //--------------------------------------------------------------------------------------
    function onValueChange(index)
    {
        switch(index)
        {
            case 1: 
                dat_epgd00010_11.Call();
                //txtCountryCode.text= cboCountryName.value;
            break;
            case 2:
                 txtTradeTermCode.text= cboTradeTermName.value;
            break;            
            case 4:
                txtCurrencyCode.text= cboCurrency.value;
                getExRate();
            break;
            case 5:
                txtDecTypeCode.text= cboDecType.value
            break;
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
    //-------------------------------------------------------------------------------------

    //ajax function
    function GetRequestState(obj)
    {
     
      if(obj.readyState == 4 && obj.status == 200)
      {
          return true;
      }
      return false;
    }
    //--------------------------------------------------------------------------------------
    function getExRate()
    {    
	    var url =  System.RootURL + "/form/ep/bp/epbp00020_GetExRate.aspx?date=" + dtRegDate.value +"&curr=" + cboCurrency.value;
	    ajax_test1 = null;

	    ajax_test1 = GetXmlHttpRequest(returnExRate);
	    ajax_test1.open("GET", url , true);
	    ajax_test1.send(null); 
    }
    //----------------------------------------------------------------------------------------
    function returnExRate()
    {
        if(GetRequestState(ajax_test1))
	    {	
	        strdata = ajax_test1.responseText;	 	  
	        txtExRate.SetDataText(''+strdata);
	    }
    }
    //-----------------------------------------------------------------------------------------
    function AddCommonCode(index)
    {     
        var scode;
        switch(index)
        {
            case 1:
                scode='IEBD0020'; //cboDecType
            break;
            case 2:
                scode='IEAB0020'; //cboTransType
            break;
            case 3:
                scode='COAB0080'; //cboCountryName
            break;
            case 4:
                scode='IEAB0010'; //cboTradeTermName
            break;
            case 5:
                scode='ACAB0110'; //cboCurrency
            break;
            case 6:
                scode='ACCR0140'; //cboPayMethod
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
                        cboDecType.value= strcodereturn;
                        onValueChange(5);
                    break;
                    case 2:
                        cboTransType.value=strcodereturn;
                    break;
                    case 3:
                        cboCountryName.value=strcodereturn;
                        onValueChange(1);
                    break;
                    case 4:
                        cboTradeTermName.value=strcodereturn;
                        onValueChange(2);
                    break;
                    case 5:
                        cboCurrency.value=strcodereturn;
                        onValueChange(4);
                    break;
                    case 6:
                        cboPayMethod.value=strcodereturn;
                    break;                    
                }            
            }
        }	     
    }    
    //--------------------------------------------------------------------------------------------

    function return_result()
    {	        
	    if(GetRequestState(ajax_test2))
	    {
	        strdata = ajax_test2.responseText;	
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
    //--------------------------------------------------------------------------------------
    function ChangeUpper()
    {
        var c = String.fromCharCode (event.keyCode); 
        var x = c.toUpperCase().charCodeAt(0) ; 
        event.keyCode = x;
    }    
    //-------------------------------------------------------------------------------------------
    function onPrint1()
    { 
        var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00010_PACKING.aspx?" + "decl_pk=" + txtSlipSeq.text + "&company_pk=" + cboCompany.value;
	    System.OpenTargetPage( url, "_blank" );  
    }
    //-------------------------------------------------------------------------------------------
    function onPrint()
    { 
        var  url= System.RootURL + "/reports/ep/gd/rpt_epgd00010_decl.aspx?" + "pk=" + txtSlipSeq.text + "&company_pk=" + cboCompany.value;
	    System.OpenTargetPage( url, "_blank" );  
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
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_epgd00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,70,74,75,76,77,78" function="imex.sp_sel_tim_decl_mst"  procedure="imex.SP_UPD_TIM_DECL_MST"> 
                <inout> 
                     <inout  bind="txtSlipSeq" /> 
                     <inout  bind="txttim_cinv_mst_a" />
                     <inout  bind="txtExporterPK" />
                     <inout  bind="txtConsignorPK" /> 
                     <inout  bind="txtLogisticsPK" />
                     <inout  bind="txtOfficePK" />                 
                     <inout  bind="txtDecTypeCode" />
                     <inout  bind="txtSlipNo" />
                     <inout  bind="dtRegDate" />
                     <inout  bind="dtImportDate" />
                     <inout  bind="txtCurrencyCode" />
                     <inout  bind="txtExRate" />
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
                     <inout  bind="txtDesc" />                
                     <inout  bind="txtStatusNum" /> 
                     <inout  bind="cboTransType" />
                     <inout  bind="txtAcceptNo" />
                     <inout  bind="txtRegNo" />
                     <inout  bind="txtAnnex" />
                     <inout  bind="txtEnclosed" />
                     <inout  bind="txtCarton" />
                     <inout  bind="txtWeight" />
                     <inout  bind="txtCont20" />
                     <inout  bind="txtCont40" />
                     <inout  bind="txttie_bl_mst_pk" />
                     <inout  bind="txtLiceseNo" />
                     <inout  bind="dtLicenseDate" />
                     <inout  bind="dtLicenseExpiryDate" />
                     <inout  bind="cboCompany" />
                     <inout  bind="cboCountryName" />
                     <inout  bind="txtPlaceDischargeCD" />
                     <inout  bind="txtPlaceLoadingCD" />
                     <inout  bind="cboTradeTermName" />  
                     <inout  bind="cboPayMethod" />
                     <inout  bind="txtReceiverPK" />
                     <inout  bind="txtStatus" />  
                     <inout  bind="txtOfficeCode" />
                     <inout  bind="txtOfficeName" />  
                     <inout  bind="txtReceiver" />   
                     <inout  bind="txtExporter" />
                     <inout  bind="txtExportDesc" />
                     <inout  bind="txtConsignor" />
                     <inout  bind="txtConsignorDesc" />
                     <inout  bind="txtLogistics" />
                     <inout  bind="txtLogisticsDesc" />
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
                     <inout  bind="txtBillingNo" />
                     <inout  bind="dtBillingDate" />     
                     <inout  bind="txtTransName" />       
                     <inout  bind="dtArrivalDate" />    
                     <inout  bind="txtPlaceLoading" />
                     <inout  bind="txtPlaceDischarge" />
                     <inout  bind="txtInvoiceNo" />
                     <inout  bind="dtInvoiceDate" /> 
                     <inout  bind="dtContractExpiry" />  
                     <inout  bind="dtContractDate" />
                     <inout  bind="txtContractNo" />
                     <inout  bind="txtCountryCode" />
                     <inout  bind="txtContractPK" />	 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dat_epgd00010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="IMEX.sp_sel_tim_decl_goods_dtl"   procedure="IMEX.sp_upd_tim_decl_goods_dtl"> 
                <input bind="grdDetails">                    
                    <input bind="txtSlipSeq" /> 
                </input> 
                <output bind="grdDetails" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="dat_epgd00010_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,3,4,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,23,24,25,26,27,28" function="IMEX.sp_sel_tim_decl_tax_dtl"   procedure="IMEX.sp_upd_tim_decl_tax_dtl"> 
                <input bind="grdDetails1">                    
                    <input bind="txtSlipSeq" /> 
                </input> 
                <output bind="grdDetails1" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Get Declaration PK -------------------------------------->
    <gw:data id="dat_epgd00010_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_sel_Decl_Next_pk"  > 
                <input> 
                     <input  bind="txtSlipSeq" />
                     <input  bind="txtTypeSel" />
                </input>
                <output>
                    <output  bind="txtSlipSeq" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------Get Company Info -------------------------------------->
    <gw:data id="dat_epgd00010_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,43" function="imex.sp_sel_get_CompanyInfo"  > 
                <inout>     
                     <inout  bind="cboCompany" />
                     <inout  bind="txtImporter" />
                     <inout  bind="txtTMP" />   
                     <inout  bind="txtImporterPK" />
                     <inout  bind="txtImportDesc" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------Update amount--------------------------------------->
    <gw:data id="dat_epgd00010_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="imex.sp_upd_tim_decl_mst_amount"> 
                <input> 
                    <input bind="txtSlipSeq" />
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
                    <output bind="txtSlipSeq" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------Confirm/Cancel------------------------------------>
    <gw:data id="dat_epgd00010_7" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_tim_decl_mst_action" > 
                <input>
                    <input bind="txtSlipSeq" />
                    <input bind="txtStatusNum" /> 
                </input> 
                <output>
                    <output bind="txtSlipSeq" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------Copy/Regenarate------------------------------------>
    <gw:data id="dat_epgd00010_8" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_tim_decl_mst_copy_regen" > 
                <input>
                    <input bind="txtSlipSeq" />
                    <input bind="txtStatusNum" />                
                </input> 
                <output>
                    <output bind="txtSlipSeq" />
                </output>
            </dso>  
        </xml> 
    </gw:data>
    <!-------------------------------cal tax amt------------------------------------>
    <gw:data id="dat_epgd00010_9" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_cal_tax_amt_decl_dtl" > 
                <input>
                    <input bind="txtSlipSeq" />
                    <input bind="txtExRate" />
                </input> 
                <output>
                    <output bind="txtCalcTotalNet" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------get current ratio------------------------------------>
    <gw:data id="dat_epgd00010_10" onreceive="OnDataReceive(this)"> 
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
    <!------------------------get country code -------------------------------------->
    <gw:data id="dat_epgd00010_11" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="imex.sp_pro_get_country_code"  > 
                <input> 
                     <input  bind="cboCountryName" />
                </input>
                <output>
                    <output  bind="txtCountryCode" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------get unit tran----------------------------------------------->
    <gw:data id="dat_epgd00010_12" onreceive="OnDataReceive(this)"> 
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
    <gw:data id="dat_epgd00010_13" onreceive="OnDataReceive(this)"> 
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
    <gw:data id="dat_epgd00010_14" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_epgd00010_1" > 
                <input>   
                    <input bind="txtSlipSeq" />    
                    <input bind="txttim_cinv_mst_a" />     
                    <input bind="txtContractPK" />
                </input> 
                <output>
                    <output bind="txttim_cinv_mst_a" />
                    <output bind="txtContractPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------import detail data to contract master, invoice master-------------------->
    <gw:data id="dat_epgd00010_15" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="imex.sp_pro_epgd00010_2" > 
                <input>   
                    <input bind="txtSlipSeq" />    
                    <input bind="txttim_cinv_mst_a" />
                    <input bind="txtContractPK" />
                </input> 
                <output>                
                    <output bind="txttmp" />
                </output>
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
    <!-------------------------------------------------------------------------------->
    <form id="form1" runat="server">
        <table border="0" width="100%">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td width="2%">
                                <gw:imgbtn img="back" id="ibtnPrev" styles='width:10%' alt="back" img="in" text="<<"
                                    onclick="OnBackNext(1)" />
                            </td>
                            <td width="2%">
                                <gw:imgbtn img="next" id="ibtnNext" styles='width:10%' img="in" alt="next" text=">>"
                                    onclick="OnBackNext(0)" />
                            </td>
                            <td width="2%">
                                Department</td>
                            <td width="15%">
                                <gw:textbox id="txtDept" text="" styles='width:100%;' csstype="mandatory" />
                            </td>
                            <td width="12%" align="right">
                                User name</td>
                            <td width="12%">
                                <gw:textbox id="txtUserName" text="" styles='width:100%;' csstype="mandatory" />
                            </td>
                            <td width="20%">
                                <gw:textbox id="txtFullName" text="" styles='width:100%;' csstype="mandatory" />
                            </td>
                            <td width="19%">
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnSearch" img="popup" alt="Open form to search" text="Search" onclick="openPopup(8)" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="onNew(0)" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave(0)" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnDel" img="delete" alt="Delete" text="Delete" onclick="onDelete(0)" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnExcel" img="excel" alt="Print Declaration" text="Print Declaration"
                                    onclick="onPrint()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnPrtPKL" img="excel" alt="Print Packing List" text="Print Packing List"
                                    onclick="onPrint1()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnConfirm" img="confirm" alt="Confirm" text="Confirm" onclick="onConfirm()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="onCancel()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnRegenerate" img="registration" alt="Regenerate" text="Regenerate"
                                    onclick="onRegenerate()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnCopy" img="copy" alt="Copy" text="Copy" onclick="onCopy()" />
                            </td>
                            <td width="1%">
                                <gw:imgbtn id="btnProcess" img="process" alt="Input data to Contract, Invoice" text="Input data to Contract, Invoice"
                                    onclick="onInputData()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <gw:tab id="idTab" onpageactivate="return OnCheckTab()" style="width: 100%; height: 220;
                        border1px">
                        <table width="100%" border=0 id="GeneralInformation" name="General Information" height="100%" cellpadding=0 cellspacing=0>
                            <tr > 
                                <td >Company</td>
                                <td colspan="2"><gw:list id="cboCompany" styles="width:100%;" onchange="dat_epgd00010_5.Call('SELECT');"></gw:list></td>
                                <td width="1%"></td>
                                <td width="8%" nowrap>Declaration No</td>
                                <td width="1%"></td>
                                <td width="8%"><gw:textbox id="txtSlipSeq"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td width="15%" colspan="4"><gw:textbox id="txtSlipNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td width="1%"></td>
                                <td width="6%">Accept No</td>
                                <td width="1%"></td>
                                <td width="10%"><gw:textbox id="txtAcceptNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td width="1%"></td>
                                <td width="4%">Annex</td>
                                <td width="1%"></td>
                                <td width="8%"><gw:textbox id="txtAnnex"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr>  
                                <td width="8%" nowrap><a title="Click here to select Customs Office" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>Customs Office</b></a></td>
                                <td width="8%"><gw:textbox id="txtOfficePK"  text=""  styles='display:none;' csstype="mandatory" /><gw:textbox id="txtOfficeCode"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td width="16%"><gw:textbox id="txtOfficeName"  text=""  styles='width:100%;' csstype="mandatory" /></td>                                
                                <td ></td>
                                <td >Register Date</td>
                                <td ></td>
                                <td ><gw:datebox id="dtRegDate" lang="1" onchange="getExRate();"/></td>
                                <td width="2%"></td>
                                <td width="2%">No</td>
                                <td width="1%"></td>
                                <td width="10%"><gw:textbox id="txtRegNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td width="1%"></td>
                                <td nowrap >Import Date</td>
                                <td></td>
                                <td ><gw:datebox id="dtImportDate" lang="1" onchange=""/></td>
                                <td ></td>
                                <td >Status</td>
                                <td ></td>
                                <td ><gw:label id="lbStatus"  text=""  styles='width:100%;color:red; font-weight:700;' csstype="mandatory" /></td>
                            </tr>
                            <tr>
                                <td colspan="19">
                                    <table width="100%">
                                        <tr>
                                            <td width="90%" align="right"><gw:imgbtn id="btnFreeItem" img="popup" alt="Open Free Item" text="Search" onclick="openPopup(11)" /></td>  
                                            <td width="2%"><gw:imgbtn id="btnSearchItem" img="popup" alt="Open Item in Invoice" text="Search" onclick="openPopup(6)" /></td>
                                            <td width="2%"><gw:imgbtn id="btnSaveItem" img="save" alt="Save" text="Save" onclick="onSave(0)" /></td>
                                            <td width="2%"><gw:imgbtn id="btnDelItem" img="delete" alt="Delete" text="Delete" onclick="onDelete(1)" /></td>
                                            <td width="2%"><gw:imgbtn id="btnRefreshItem" img="refresh" alt="Refresh" text="Refresh" onclick="dat_epgd00010_2.Call('SELECT');" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="19" >
                                <%--_1|2|3|4|5|6|7|8|9|10|11|12|12_|13_tim_decl_mst_pk|14_tco_item_pk|15_tim_cinv_dtl_pk|16_tim_order_pk|17_item_origin|18_cnv_ratio--%>
                                    <gw:grid 
									    id="grdDetails"  
									    header="_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|_bk_amt|_tim_decl_mst_pk|_tco_item_pk|_tim_cinv_dtl_pk|_tim_order_pk|_item_origin|_cnv_ratio|_tran_rate|_weight_rate"
									    format="0|0|0|0|0|0|2|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    aligns="1|1|2|2|2|2|1|1|1|3|3|3|3|3|3|3|3|3|0|0|0|0|0|0|0|0"  
									    defaults="||||||||||||||||||||||||||"  
									    editcol="0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
									    widths="0|1000|1000|0|0|0|800|0|1000|0|1000|1000|1400|1500|1000|1000|0|0|0|0|0|0|0|0|0|0"    
									    styles="width:100%; height:205"   
									    sorting="T"   
									    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" 
										oncelldblclick=""
										onafteredit="onAfterEditting(this.col)"
						            /> 
                                </td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2"></td>
                                <td colspan=5>Transaction Amount</td>
                                <td colspan="3"></td>
                                <td colspan=5>Tax Calc. Amount</td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">Total Net</td>
                                <td colspan=5><gw:textbox id="txtTransTotalNet" type="number" format="#,###,###,###,###,###,###.##" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcTotalNet" type="number" format="#,###,###,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">Import Tax</td>
                                <td colspan=5><gw:textbox id="txtTransImport"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcImport"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">Excise Tax</td>
                                <td colspan=5><gw:textbox id="txtTransExcise"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcExcise"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">VAT</td>
                                <td colspan=5><gw:textbox id="txtTransVAT"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcVAT"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">Other Tax</td>
                                <td colspan=5><gw:textbox id="txtTransOtherTax"  text="" type="number" format="#,###,###,###,###,###,###.##R"  styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcOtherTax"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                            <tr >
                                <td colspan="4"></td>
                                <td colspan="2">Total Tax</td> 
                                <td colspan=5><gw:textbox id="txtTransTotalTax"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                <td colspan="3"></td>
                                <td colspan=5><gw:textbox id="txtCalcTotalTax"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                            </tr>
                        </table>
                        <table width="100%"  id="Declared Information" name="Declared Information" border=1>                            
                            <tr>
                                <td >
                                    <table width="100%">
                                        <tr>
                                            <td>
                                                <table width="100%" cellpadding=0 cellspacing =0> 
                                                    <tr>
                                                        <td width="10%" rowspan="2" valign=top><a  style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;1. Importer</b></a></td>
                                                        <td width="20%"><gw:textbox id="txtImporterPK"  text=""  styles='display:none;' /><gw:textbox id="txtImporter"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Declaration Type" onClick="AddCommonCode(1)" href="#tips" style="text-decoration : none; color=#0000FF"><b>5. Declaration Type</b></a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 height="75">
                                                                        <tr> 
                                                                           <td width=30%><gw:textbox id="txtDecTypeCode"   styles="width:100%;" /></td>
                                                                           <td width=70%><gw:list id="cboDecType" onchange="onValueChange(5)" styles="width:100%;"></gw:list></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&nbsp;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend><b><font color="black"  >6. License</font> </b></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0>
                                                                        <tr>
                                                                            <td width=30%>No.</td>
                                                                            <td width=70%><gw:textbox id="txtLiceseNo"   styles="width:100%;" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=30%>Date</td>
                                                                            <td width=70%><gw:datebox id="dtLicenseDate" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=35%>Expiry Date</td>
                                                                            <td width=70%><gw:datebox id="dtLicenseExpiryDate" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend><b><font color="black"  >7. Contract</b></font> </legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0>
                                                                        <tr>
                                                                            <td width=30%>No.</td>
                                                                            <td width=70%><gw:textbox id="txtContractNo"   styles="width:100%;" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=30%>Date</td>
                                                                            <td width=70%><gw:datebox id="dtContractDate" lang="1" onchange=""/></td>
                                                                        </tr>   
                                                                        <tr>
                                                                            <td width=35%>Expiry Date</td>
                                                                            <td width=70%><gw:datebox id="dtContractExpiry" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>  
                                                        <td width="20%"><gw:textarea id="txtImportDesc" styles="width:100%;height=65" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="8%"><a title="Click here to select Receiver" onclick="openPopup(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;&nbsp;Receiver</b></a></td>
                                                        <td width="20%"><gw:textbox id="txtReceiver"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                        <td width="20%"><gw:textbox id="txtReceiverPK"  text=""  styles='display:none;'/></td>
                                                        <td width="20%"></td>
                                                        <td width="20%"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="8%" rowspan="2" valign=top><a title="Click here to select Exporter" onclick="openPopup(2)" href="#tips" style="text-decoration : none; color=#0000FF">&nbsp;&nbsp;2. Exporter</a></td>
                                                        <td width="20%"><gw:textbox id="txtExporterPK"  text=""  styles='display:none;' /><gw:textbox id="txtExporter"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                        <td width="8%" rowspan="2" valign="top">
                                                            <fieldset style="padding: 5">
                                                                <legend><b>&nbsp;&nbsp;&nbsp;<a title="Click here to select Commercial Invoice" onclick="openPopup(6)" href="#tips" style="text-decoration : none; color=#0000FF">&nbsp;&nbsp;8. Commercial Invoice</a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=0 border=0 height="75">
                                                                        <tr>
                                                                            <td width=30%>No.</td>
                                                                            <td width=70%><gw:textbox id="txtInvoiceNo"   styles="width:100%;" /></td>
                                                                        </tr>
                                                                        <tr>    
                                                                            <td width=30%>Date</td>
                                                                            <td width=70%><gw:datebox id="dtInvoiceDate" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan=2>&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend><a title="Click here to select Declaration Type" onClick="AddCommonCode(2)" href="#tips" style="text-decoration : none; color=#0000FF"><b>9. Transportation by</b></a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0>
                                                                        <tr>
                                                                            <td width=30%>No.</td>
                                                                            <td width=70%><gw:list id="cboTransType" styles="width:100%;"></gw:list></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=30%>Name</td>
                                                                            <td width=70%><gw:textbox id="txtTransName"   styles="width:100%;" /></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=35%>Arrival Date</td>
                                                                            <td width=70%><gw:datebox id="dtArrivalDate" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend><font color="black"  ><a title="Click here to select Billing" onclick="openPopup(7)" href="#tips" style="text-decoration : none; color=#0000FF">10. Billing</a></font></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 height="75">
                                                                        <tr>
                                                                            <td width=30%>No.</td>
                                                                            <td width=70%><gw:textbox id="txtBillingNo"   styles="width:100%;" /></td>
                                                                        </tr> 
                                                                        <tr> 
                                                                            <td width=30%>Date</td>
                                                                            <td width=70%><gw:datebox id="dtBillingDate" lang="1" onchange=""/></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan=2>&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%"><gw:textarea id="txtExportDesc" styles="width:100%;height=65" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="8%" rowspan="2" valign=top><a title="Click here to select Consignor" onclick="openPopup(3)" href="#tips" style="text-decoration : none; color=#0000FF"><b>3. Consignor</b></a></td>
                                                        <td width="20%" ><gw:textbox id="txtConsignorPK"  text=""  styles='display:none;' /><gw:textbox id="txtConsignor"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend >11. Export Country</legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                                                        <tr>
                                                                           <td width=30%><gw:textbox id="txtCountryCode"   styles="width:100%;" /><gw:textbox id="txtCountryPK"   styles="display:none" /></td>
                                                                           <td width=70%><gw:list id="cboCountryName" styles="width:100%;" onchange="onValueChange(1)"></gw:list></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Place of Loading" onclick="openPopup(9)" href="#tips" style="text-decoration : none; color=#0000FF"><b>12. Place of Loading</b></a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                                                        <tr>                                                                           
                                                                           <td width="100%"><gw:textbox id="txtPlaceLoading" styles="width:100%;"/><gw:textbox id="txtPlaceLoadingCD" styles="display:none;"/></td>
                                                                        </tr>
                                                                    </table>  
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Place of Discharge" onclick="openPopup(10)" href="#tips" style="text-decoration : none; color=#0000FF"><b>13. Place of Discharge</b></a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                                                        <tr> 
                                                                           <td width=30%><gw:textbox id="txtPlaceDischargeCD"   styles="width:100%;" /></td>
                                                                           <td width=70%><gw:textbox id="txtPlaceDischarge"   styles="width:100%;" onchange=""/></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td> 
                                                    </tr>
                                                    <tr>
                                                        <td width="20%"><gw:textarea id="txtConsignorDesc" styles="width:100%;" /></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="8%" rowspan="2" valign=top><a title="Click here to select Local Logistics" onclick="openPopup(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>4. Local Logistics</b></a></td>
                                                        <td width="20%" ><gw:textbox id="txtLogisticsPK"  text=""  styles='display:none;' /><gw:textbox id="txtLogistics"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Trade Terms" onClick="AddCommonCode(4)" href="#tips" style="text-decoration : none; color=#0000FF"><b>14. Trade Terms</b></a> </legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 height=47 >
                                                                        <tr>
                                                                           <td width=30%><gw:textbox id="txtTradeTermCode"   styles="width:100%;" /><gw:textbox id="txtTradeTermPk"   styles="display:none" /></td>
                                                                           <td width=70%><gw:list id="cboTradeTermName"  onchange="onValueChange(2)" styles="width:100%;" /></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Payment Currency<" onClick="AddCommonCode(5)" href="#tips" style="text-decoration : none; color=#0000FF"><b>15. Payment Currency</b></a></legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 >
                                                                        <tr>
                                                                           <td width=30%>Name</td> 
                                                                           <td width=20%><gw:textbox id="txtCurrencyCode"   styles="width:100%;" /></td>
                                                                           <td width=50%><gw:list id="cboCurrency" onchange="onValueChange(4)" styles="width:100%;"></gw:list></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td width=30%>Ex. Rate</td>
                                                                            <td width=70% colspan=2><gw:textbox id="txtExRate" type="number" format="#,###,###,###,###.##R"  styles="width:100%;" /></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td>
                                                        <td width="8%" rowspan="2">
                                                            <fieldset style="padding: 5">
                                                                <legend ><a title="Click here to select Payment Method<" onClick="AddCommonCode(6)" href="#tips" style="text-decoration : none; color=#0000FF"><b>16. Payment Method</b></a> </legend>
                                                                    <table width=100% cellpadding=0 cellspacing=1 border=0 height=47>
                                                                        <tr>
                                                                           <td width=30%>Name</td>
                                                                           <td width=70%><gw:list id="cboPayMethod" styles="width:100%;"></gw:list></td>
                                                                        </tr>
                                                                    </table>
                                                            </fieldset>
                                                        </td> 
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" ><gw:textarea id="txtLogisticsDesc" styles="width:100%;" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table width="100%">
                                                    <tr>
                                                        <td width="13%">Enclosed Document</td>
                                                        <td width="20%"><gw:textbox id="txtEnclosed"   styles="width:100%;" /></td>
                                                        <td width="5%">&nbsp;&nbsp;&nbsp;&nbsp;Carton</td>
                                                        <td width="10%"><gw:textbox id="txtCarton"   styles="width:100%;" /></td>
                                                        <td width="6%">&nbsp;&nbsp;&nbsp;&nbsp;Weight</td>
                                                        <td width="10%"><gw:textbox id="txtWeight"   styles="width:100%;" /></td>
                                                        <td width="7%">&nbsp;&nbsp;&nbsp;&nbsp;Cont 20"</td>
                                                        <td width="10%"><gw:textbox id="txtCont20"   styles="width:100%;" /></td>
                                                        <td width="7%">&nbsp;&nbsp;&nbsp;&nbsp;Cont 40"</td>
                                                        <td width="10%"><gw:textbox id="txtCont40"   styles="width:100%;" /></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table id="Tax Calculation" name="Tax Calculation" width="100%">
                            <tr>
                                <td width="10%" >Tax Calc. Type</td>
                                <td width="15%">
                                    <gw:list id="cboTaxType" styles="width:100%" value='ALL' onchange="MergeHeader(1)" >
                                        <data>Data|IMP|Import Tax|EXC|Excise Tax|VAT|VAT|OTH|Others </data>
                                    </gw:list >
                                </td>
                                <td width="70%"></td>
                                <td width="2%" ><gw:imgbtn id="btnCalcSave" img="save" alt="Save" text="Save" onclick="onSave(2)" /></td>
                            </tr>    
                            <tr>
                                <td colspan=4>
                                    <gw:grid   
									    id="grdDetails1"  
									    header="_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29"   
									    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    aligns="0|1|2|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"  
									    defaults="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
									    editcol="0|0|0|0|1|0|1|0|1|0|0|1|0|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1"  
									    widths="100|1000|1000|1000|1000|1400|1500|1500|1500|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"  
									    styles="width:100%; height:240"   
									    sorting="T"   
									    param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28" 
										oncelldblclick=""
										onafteredit="onAfterEditting1()"			
									 /> 
                                </td>
                            </tr>
                            <tr>
                                <td colspan=4>
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr >
                                            <td width="34%"></td>
                                            <td width="10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Transaction Amount</td>
                                            <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td width="28%">Tax Calc. Amount</td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td width="10%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Net</td>
                                            <td width="20%"><gw:textbox id="txtTransTotalNet1" type="number" format="#,###,###,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                            <td width="9%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td width="28%"><gw:textbox id="txtCalcTotalNet1" type="number" format="#,###,###,###,###,###,###R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Import Tax</td>
                                            <td ><gw:textbox id="txtTransImport1"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td ><gw:textbox id="txtCalcImport1"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Excise Tax</td>
                                            <td ><gw:textbox id="txtTransExcise1"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td ><gw:textbox id="txtCalcExcise1"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;VAT</td>
                                            <td ><gw:textbox id="txtTransVAT1"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td ><gw:textbox id="txtCalcVAT1"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other Tax</td>
                                            <td ><gw:textbox id="txtTransOtherTax1" type="number" format="#,###,###,###,###,###,###.##R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td ><gw:textbox id="txtCalcOtherTax1" type="number" format="#,###,###,###,###,###,###R" text=""  styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                        <tr >
                                            <td width="34%"></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Tax</td>
                                            <td ><gw:textbox id="txtTransTotalTax1"  text="" type="number" format="#,###,###,###,###,###,###.##R" styles='width:100%;' csstype="mandatory" /></td>
                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td ><gw:textbox id="txtCalcTotalTax1"  text="" type="number" format="#,###,###,###,###,###,###R" styles='width:100%;' csstype="mandatory" /></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                </gw:tab>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </form>
</body>
<gw:textbox id="txttim_cinv_mst_a" styles='display:none;' />
<gw:textbox id="txtDesc" styles='display:none;' />
<gw:textbox id="txtItemOrigin" styles='display:none;' />
<gw:textbox id="txttie_bl_mst_pk" styles='display:none;' />
<gw:textbox id="txtStatusNum" text="1" styles='display:none;' />
<gw:textbox id="txtTypeSel" text="0" styles='display:none;' />
<gw:textbox id="txtStatus" text="0" styles='display:none;' />
<gw:textbox id="txtUnit" text="0" styles='display:none;' />
<gw:textbox id="txtCnvRatio" text="0" styles='display:none;' />
<gw:textbox id="txtUnitTran" text="" styles='display:none' />
<gw:textbox id="txtTran_rate" text="" styles='display:none' />
<gw:textbox id="txtItemPK" text="" styles='display:none' />
<gw:textbox id="txtContractPK" text="" styles='display:none' />
<gw:textbox id="txttmp" text="" styles='display:none' />
<gw:textbox id="txtComCodeID" text="" styles='display:none' />
<gw:textbox id="txtCodeTemp" text="" styles='display:none' />
</html>
