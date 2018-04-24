<%@ Page Language="C#" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Tac Refund Entry</title>
</head>
<%ESysLib.SetUser("comm");%>
<script language ="javascript" type="text/javascript">
function BodyInit()
{
    BindingDataList();
    grdExpProd.AddRow();
    MergeHeader(2);
//    SetGridFormat();
}
//-----------------------------------------------------------------------------------
function OnCheckTab()
{

}
//-----------------------------------------------------------------------------------
 function BindingDataList()
 { 
    var data1 = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    var data2 = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('IEBD0020','','') FROM DUAL")%>";  //Declaration type 
     cboCompany.SetDataText(data1);
 }
 //-------------------------------------------------------------------------------------
function MergeHeader(index)
{
    switch(index)
    {
        case 0:
	        var fg=grdExpDecl.GetGridControl();
		    grdExpDecl.SetCellBold(1,1,1,10,true);
		    //obj.Cell(13, row1, col1, row2, col2) = bBold;
		    fg.FixedRows = 2
		    fg.MergeCells = 5
		     fg.MergeCol(1) = true
	         fg.Cell(0, 0,1, 1, 1) = "No."
		     				
		    fg.MergeRow(0) = true
		    fg.Cell(0, 0, 2, 0, 5) = "Export Declaration"
			    fg.Cell(0, 1, 2, 1) 	= "Decl. No."
			    fg.Cell(0, 1, 3, 1 ) 	= "Type"
			    fg.Cell(0, 1, 4, 1) 	= "Register Date"
			    fg.Cell(0, 1, 5, 1) 	= "Export Date"
	 	     fg.MergeCol(6)=true
		     fg.Cell(0,0,6,1,6)="Curr."
		     fg.MergeCol(7)=true
		     fg.Cell(0,0,7,1,7)="Tr. Amt."
		     fg.MergeCol(8)=true
		     fg.Cell(0,0,8,1,8)="Ex. Rate"
		     fg.MergeCol(9)=true
		     fg.Cell(0,0,9,1,9)="Custom Office"
		     fg.MergeCol(10)=true
		     fg.Cell(0,0,10,1,10)="Description"
		    	 		 
		     fg.ColWidth(1)=700;  // No.
		     fg.ColWidth(2)=1600; // Decl. No.
		     fg.ColWidth(3)=1400; // Type
		     fg.ColWidth(4)=1400; // Register Date	
		     fg.ColWidth(5)=1300; // Export Date
		     fg.ColWidth(6)=1200;  // Curr.
		     fg.ColWidth(7)=1400;  // Tr. Amt.
		     fg.ColWidth(8)=1000;  // Ex. Rate
		     fg.ColWidth(9)=3000;  // Custom Office
		     fg.ColWidth(10)=1500; //
	     break;	    
	     case 1:
	        var fg=grdImpDecl.GetGridControl();
		    grdImpDecl.SetCellBold(1,1,1,10,true);
		    //obj.Cell(13, row1, col1, row2, col2) = bBold;
		    fg.FixedRows = 2
		    fg.MergeCells = 5
		     fg.MergeCol(1) = true
	         fg.Cell(0, 0,1, 1, 1) = "No."
		     				
		    fg.MergeRow(0) = true
		    fg.Cell(0, 0, 2, 0, 5) = "Import Declaration"
			    fg.Cell(0, 1, 2, 1) 	= "Decl. No."
			    fg.Cell(0, 1, 3, 1 ) 	= "Type"
			    fg.Cell(0, 1, 4, 1) 	= "Register Date"
			    fg.Cell(0, 1, 5, 1) 	= "Export Date"
	 	     fg.MergeCol(6)=true
		     fg.Cell(0,0,6,1,6)="Curr."
		     fg.MergeCol(7)=true
		     fg.Cell(0,0,7,1,7)="Tr. Amt."
		     fg.MergeCol(8)=true
		     fg.Cell(0,0,8,1,8)="Ex. Rate"
		     fg.MergeCol(9)=true
		     fg.Cell(0,0,9,1,9)="Custom Office"
		     fg.MergeCol(10)=true
		     fg.Cell(0,0,10,1,10)="Description"
		    	 		 
		     fg.ColWidth(1)=700;  // No.
		     fg.ColWidth(2)=1600; // Decl. No.
		     fg.ColWidth(3)=1400; // Type
		     fg.ColWidth(4)=1400; // Register Date	
		     fg.ColWidth(5)=1300; // Export Date
		     fg.ColWidth(6)=1200;  // Curr.
		     fg.ColWidth(7)=1400;  // Tr. Amt.
		     fg.ColWidth(8)=1000;  // Ex. Rate
		     fg.ColWidth(9)=3000;  // Custom Office
		     fg.ColWidth(10)=1500; //
	     break;	  
	     case 2:
	        var fg=grdExpProd.GetGridControl();
		    grdExpProd.SetCellBold(1,1,1,16,true);
		    //obj.Cell(13, row1, col1, row2, col2) = bBold;
		    fg.FixedRows = 2
		    fg.MergeCells = 5
		     fg.MergeCol(1) = true
	         fg.Cell(0, 0,1, 1, 1) = "No."
		     	
		    fg.MergeRow(0) = true
		    fg.Cell(0, 0, 2, 0, 6) = "Export Contract"
			    fg.Cell(0, 1, 2, 1) 	= "Contract No."
			    fg.Cell(0, 1, 3, 1) 	= "Contract Date"
			    fg.Cell(0, 1, 4, 1) 	= "Product"
			    fg.Cell(0, 1, 5, 1) 	= "Amount"
			    fg.Cell(0, 1, 6, 1) 	= "Curr."
		
			fg.Cell(0, 0, 7, 0, 10) = "Export Declaration"
			    fg.Cell(0, 1, 7, 1) 	= "Decl. No."
			    fg.Cell(0, 1, 8, 1) 	= "Decl. Date"
			    fg.Cell(0, 1, 9, 1) 	= "Amount"
			    fg.Cell(0, 1, 10, 1) 	= "Curr."
		    
            fg.Cell(0, 0, 11, 0, 16) = "Collection Information"
			    fg.Cell(0, 1, 11, 1) 	= "Account No."
			    fg.Cell(0, 1, 12, 1) 	= "Date"
			    fg.Cell(0, 1, 13, 1) 	= "Collection method"
			    fg.Cell(0, 1, 14, 1) 	= "Amount"
			    fg.Cell(0, 1, 15, 1) 	= "Curr."
			    fg.Cell(0, 1, 16, 1) 	= "Description"
 
		    	 		 
		     fg.ColWidth(1)=700;  // No
		     fg.ColWidth(2)=1600; // "Contract No."
		     fg.ColWidth(3)=1300; // "Contract Date"
		     fg.ColWidth(4)=1300; // "Product"
		     fg.ColWidth(5)=1200; // "Amount"
		     fg.ColWidth(6)=1200;  // "Curr."
		     fg.ColWidth(7)=1400;  // "Decl. No."
		     fg.ColWidth(8)=1300;  // "Decl. Date"
		     fg.ColWidth(9)=1200;  // "Amount"
		     fg.ColWidth(10)=1000; // "Curr."
		     fg.ColWidth(11)=1200;  // "Account No."
		     fg.ColWidth(12)=1300; // "Date"
		     fg.ColWidth(13)=1600; // "Collection method"
		     fg.ColWidth(14)=1200; // "Amount"
		     fg.ColWidth(15)=1200; // "Curr."
		     fg.ColWidth(16)=1200; // "Description"
	     break;	 
	}
}
//-------------------------------------------------------------------------------------
function SetGridFormat()
{
    var ctr = grdExpDecl.GetGridControl(); 
    ctr.ColFormat(6) = "#,###,###,###,###,###.##";
    ctr.ColFormat(7) = "#,###,###,###,###,###";
    
    var ctr = grdImpDecl.GetGridControl(); 
    ctr.ColFormat(6) = "#,###,###,###,###,###.##";
    ctr.ColFormat(7) = "#,###,###,###,###,###";
    
}
//--------------------------------------------------------------------------------------
function openPopup(index)
{
    switch(index)
    {
        case 0:
            var fpath = System.RootURL + "/form/ep/hl/ephl00040_ExDecl.aspx"; //customs
            aValue = System.OpenModal( fpath , 950 , 560, 'resizable:yes;status:yes');
            if ( aValue != null )
            {             
            //0._Pk|1.No|2.Select|3.Customer|4.Decl. Type|5.Decl. No|6.Reg. Date|7.Export Date|8.Close Y/N
            //|9.Close Date|10.Trans. Curr|11.Ex. Rate|12.Trans. Amt|13.Booking Amt|14.Description|15.buspartner_pk'
             
             //grdExpDecl
            //0.pk|1.No|2.decl_no|3.decl_type|4.decl_date|5.export_date|6.tr_ccy|7.tot_net_tr_amt
            //|8.ex_rate|9.partner_name|10.tie_liquiddoc_pk|11.tex_decl_mst_pk|12.tco_busp--%> 
            
                var iValue = new Array();
                
                for(i=0;i<aValue.length;i++)
                {
                    iValue=aValue[i];
                    grdExpDecl.AddRow();
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,1,grdExpDecl.rows-2);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,2,iValue[5]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,3,iValue[4]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,4,iValue[6]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,5,iValue[7]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,6,iValue[10]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,7,iValue[12]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,8,iValue[11]);
                    grdExpDecl.SetGridText(grdExpDecl.rows-1,9,iValue[3]);
//                    grdExpDecl.SetGridText(grdExpDecl.rows-1,11,iValue[0]);
//                    grdExpDecl.SetGridText(grdExpDecl.rows-1,12,iValue[15]);
                }
            }
        break;
        case 1 :
            var fpath = System.RootURL + "/form/ep/hl/ephl00040_ImDecl.aspx"; //customs
            aValue = System.OpenModal( fpath , 950 , 560, 'resizable:yes;status:yes');
            if ( aValue != null )
            {             
            //0._Pk|1.No|2.Select|3.Customer|4.Decl. Type|5.Decl. No|6.Reg. Date|7.Export Date|8.Close Y/N
            //|9.Close Date|10.Trans. Curr|11.Ex. Rate|12.Trans. Amt|13.Booking Amt|14.Description|15.buspartner_pk'
             
             //grdExpDecl
            //0.pk|1.No|2.decl_no|3.decl_type|4.decl_date|5.export_date|6.tr_ccy|7.tot_net_tr_amt
            //|8.ex_rate|9.partner_name|10.tie_liquiddoc_pk|11.tex_decl_mst_pk|12.tco_busp--%> 
            
                var iValue = new Array();
                
                for(i=0;i<aValue.length;i++)
                {
                    iValue=aValue[i];
                    grdImpDecl.AddRow();
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,1,grdImpDecl.rows-2);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,2,iValue[5]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,3,iValue[4]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,4,iValue[6]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,5,iValue[7]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,6,iValue[10]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,7,iValue[12]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,8,iValue[11]);
                    grdImpDecl.SetGridText(grdImpDecl.rows-1,9,iValue[3]);
//                    grdImpDecl.SetGridText(grdImpDecl.rows-1,11,iValue[0]);
//                    grdImpDecl.SetGridText(grdImpDecl.rows-1,12,iValue[15]);
                }
            }	
        break;
    }    
}
</script>
<body>
    <form id="form1" runat="server">
        <table width="100%" cellpadding=0 cellspacing=0>
            <tr>
                <td>Company</td>
                <td colspan="2"><gw:list id="cboCompany" styles="width:100%;"></gw:list></td>
                <td colspan="5">
                    <table width="100%" cellpadding=0 cellspacing=0>
                        <tr>
                            <td width="93%"></td>
                            <td width="1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="" /></td>
                            <td width="1%"><gw:imgbtn id="btnPopup" img="popup" alt="popup" text="Open to select Declaration" onclick="openPopup(0)" /></td>
                            <td width="1%"><gw:imgbtn id="btnSave" img="Save" alt="Save" text="Save" onclick="" /></td>
                            <td width="1%"><gw:imgbtn id="btnDelete" img="Delete" alt="Delete" text="Delete" onclick="" /></td>
                            <td width="1%"><gw:imgbtn id="btnRefresh" img="Refresh" alt="Refresh" text="Refresh" onclick="" /></td>
                            <td width="1%"><gw:imgbtn id="btnProcess" img="Process" alt="Process" text="Process" onclick="" /></td>
                            <td width="1%"><gw:imgbtn id="btnCancel" img="Cancel" alt="Cancel" text="Cancel" onclick="" /></td>
                        </tr>
                    </table>
                </td> 
            </tr>
            <tr>
                <td width="10%" nowrap >Voucher No.</td>
                <td width="10%"><gw:textbox id="txtSeq"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                <td width="10%"><gw:textbox id="txtSlipNo"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                <td width="2%"></td>
                <td width="10%" align="right" nowrap >Voucher date</td>
                <td width="1%"></td>
                <td width="10%"><gw:datebox id="dtVoucherFrom" lang="1" onchange=""/></td>
                <td width="47%"></td>
            </tr>
            <tr>
                <td colspan="8">
                    <gw:tab id="idTab" onpageactivate="return OnCheckTab()" style="width: 100%; height: 220; border1px">
                        <table id="RefundInfo" name="Refund Info" width="100%" cellpadding=0 cellspacing=0>
                            <tr>
                                <td width="97%"></td>
                                <td width="1%"><gw:imgbtn id="btnSearchProd" img="Search" alt="Search" text="Search" onclick="" /></td>
                                <td width="1%"><gw:imgbtn id="btnProcessProd" img="Process" alt="Process" text="Process" onclick="" /></td>
                                <td width="1%"><gw:imgbtn id="btnCancelProd" img="Cancel" alt="Cancel" text="Cancel" onclick="" /></td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <gw:grid id='grdExpProd'
                                        header='_Pk|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16'
                                        format='0|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                        aligns='0|1|1|0|0|0|1|0|0|0|0|0|0|0|0|0|0'
                                        defaults='||||||||||||||||'
                                        editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                                        widths='0|600|1200|2500|3500|1500|1200|3500|1500|1200|0|11|12|13|14|15|16'
                                        sorting='T'
                                        styles='width:100%; height:230'
                                        oncelldblclick=""
                                        acceptNullDate='true'
                                    />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%" cellpadding=0 cellspacing=0>
                                        <tr>
                                            <td width="97%"></td>
                                            <td width="1%"><gw:imgbtn id="btnNewRef" img="new" alt="New" text="New" onclick="" /></td>
                                            <td width="1%"><gw:icon id="btnMapping" alt="Mapping" text="Mapping" onclick="" /></td>
                                            <td width="1%"><gw:imgbtn id="btnCancelRef" img="Cancel" alt="Cancel" text="Cancel" onclick="" /></td>
                                        </tr>
                                        <tr>			 				

                                            <td colspan="4">
                                                <gw:grid id='grdTaxRefund'
                                                    header='_Pk|No|Customer|Tax code|Description|Customs|Amount|Tax rate|Tax Amount|Curr.'
                                                    format='0|0|0|3|0|0|0|0|0|0'
                                                    aligns='0|0|1|1|0|0|0|1|0|0'
                                                    defaults='|||||||||'
                                                    editcol='1|1|1|1|1|1|1|1|1|1'
                                                    widths='0|600|2500|1500|2500|3000|1500|1000|1300|1000'
                                                    sorting='T'
                                                    styles='width:100%; height:230'
                                                    oncelldblclick=""
                                                    acceptNullDate='true'
                                                />
                                            </td>
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
</html>
