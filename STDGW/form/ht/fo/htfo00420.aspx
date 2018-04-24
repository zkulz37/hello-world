<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Guest Arriving</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
var  user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
var  user_name = "<%=Session("USER_NAME")%>" ;
var G1_PK=0,
	G1_Select=1,
	G1_RoomNo=2,
	G1_Room_Type=3,
	G1_Last_Name=4,
	G1_First_Name=5,
	G1_Checkin=6,
	G1_Checkout=7,
	G1_Total_Due=8,
	G1_Room_Charge=9,
	G1_Other_Fee=10,
	G1_FnB_hotel=11,
	G1_Minibar=12,
	G1_Laudry=13,
	G1_Tennis=14,
	G1_Telephone=15,
	G1_Golf_Fnb=16,
	G1_ProShop=17,
	G1_Drv_Range=18,
	G1_Teaching=19,
	G1_Golf_Rental=20,
	G1_Green_fee=21,
	G1_Caddie_Fee=22,
	G1_Cart_Fee=23,
	G1_Bag_Fee=24,
	G1_Adjust=25,
	G1_Customer=26,
	G1_tco_buspartner_pk=27,
	G1_Invoice_No_Acnt=28,
	G1_tac_crca_pk=29;  
var G2_pk=0,
	G2_Issue_YN=1,
	G2_Invoice_No=2,
	G2_Invoice_Date=3,
	G2_Book_Amt=4,
	G2_Service_Rate=5,
	G2_Service_Amt=6,
	G2_SCT_Rate=7,
	G2_SCT_Amt=8,
	G2_VAT_Rate=9,
	G2_VAT_Amt=10,
	G2_Total_Due=11,
	G2_Description=12,
	G2_Local_Description=13,
	G2_PL_Code_Name=14,
	G2_Debit_Acc=15,
	G2_Credit_Acc=16,
	G2_Customer_Name=17,
	G2_tac_crca_pk=18,
	G2_Invoice_No_Acnt=19,
	G2_tac_hgtrh_pk=20;
//==================================================================================
 function BodyInit()
 {
    grdRoomAllocate.GetGridControl().FrozenCols = 6;
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE DESC")%>||Select All";
	lstLocation.SetDataText(data);
	lstLocation.value='';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' ORDER BY CODE DESC")%>";
	grdInvoice.SetComboFormat(2, data);//location
	OnChangeGrid();
	OnSearch('grd1');
 }
 
 function OnSearch(pos) 
 {	  
    if ( pos == 'INVOICE' )//click grid mst--->search item detail(location)
    {
        if ( grdRoomAllocate.row > 0 )
        {
            if(radTab.value == '2')
			{
				txtRoomAllocatePK.text = grdRoomAllocate.GetGridData( grdRoomAllocate.row, 0);
				data_htfo00420_invoice.Call("SELECT");
			}
			else
			{
				if(grdRoomAllocate.GetGridData( grdRoomAllocate.row, 1)==0 && grdRoomAllocate.col !=1)
				{
					//alert("Please,check 'Item Detail' to search.");
				}	
			}
        }    
    }
	if(pos=='2') //btn search down
	{
		var pk_search="";
		var l_customer_pk="",l_crca_acnt_pk="";
		if(grdRoomAllocate.row !='-1')
		{
			for(var i=1;i<grdRoomAllocate.rows;i++)
			{  
				if(grdRoomAllocate.GetGridData(i,G1_Select) == -1)//checked
				{
					//pk_search += grdRoomAllocate.GetGridData(i,G1_PK)+",";//master pk
					if(grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk) != "")//customer_pk
					  {
							if(l_customer_pk == "")
								{
									l_customer_pk=grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk);
									l_crca_acnt_pk=grdRoomAllocate.GetGridData(i,G1_tac_crca_pk);
								}
							if(grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk)==l_customer_pk && grdRoomAllocate.GetGridData(i,G1_tac_crca_pk)== l_crca_acnt_pk)	
							{
								pk_search += grdRoomAllocate.GetGridData(i,G1_PK)+",";//master pk
							}
							else
							{
								alert("these bills are not the same invoice.So can not select together.");
								return;
							}
						}
				  else
				  {
					alert("Please input customer name row at " +i+ " to process.");
					return;
				  }
					
				}
			}
			if(pk_search =="")
			{
				alert("please, choose room to search.");
				return;
			}
			chkAllGrid2.value ='N';
			txtRoomCheckPK.text = pk_search;
			dat_sel_grid2.Call("SELECT");
		}
		else
		{
			alert("please, choose room to search.");
		}		
	}
    if ( pos == 'grd1' )//btn search up
    {
        data_htfo00420.Call("SELECT");
    }    
 }
 var g_lag='';
 //==================================================================================
 function OnDataReceive(obj)
{
    switch(obj.id)
	{
		case 'data_htfo00420':
		        lblRows.text=grdRoomAllocate.rows-1;
				if(grdRoomAllocate.rows > 0)
				{
					for (i = 1; i < grdRoomAllocate.rows; i++)
					{
						if (grdRoomAllocate.GetGridData(i,G1_tac_crca_pk) > 0 )
						{
							grdRoomAllocate.SetCellBgColor(i, G1_PK, i,G1_tac_crca_pk,0XEE82EE);//0xB3B3D7  0x336633  0x0000CE
						}
					}
				}
		break;
		case 'dso_process_inv'://process grid 1
			OnSearch('2');
		break;
		case 'dso_process_preview_inv'://process grid 2
			OnSearch('2');
		break;
		case 'dso_process_cancel_inv':
			OnSearch('2');
		break;
		case 'dso_process_print_inv'://process confirm print invoice
			dso_upd_print_out.Call();//create barcode of report
		break;
		case 'dso_upd_print_out'://process confirm print invoice
			OnSearch('2');
		break;
		case 'dat_sel_grid2':///print view report
				TotalPaymentDetail();
				txt_crca_pk.text="";
				if(grd2.rows < 2)
				{
					//alert("Please,choose gofer to process.");
					return;
				}				
				if(g_lag=="preview_report") ///preview report
				{
					var crca_pk="",InvoiceNo_ACNT="";
					if(grd2.rows > 1)
					{
						var crca_pk="",master_pk_grid2="";
						for(var i=1;i<grd2.rows;i++)//check crca_pk exit?if crca_pk not null-->printview report 
						{
							if(grd2.GetGridData(i,G2_tac_crca_pk) !="" && crca_pk =="")
							{
								crca_pk += grd2.GetGridData(i,G2_tac_crca_pk);//pk
								txt_crca_pk.text=crca_pk;
							}
						}
						if(txt_crca_pk.text!="") //crca_pk is null -->process preview
						{
								g_lag="";
								var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rc/jarc00060_preview_invoice_month.rpt&procedure=ACNT.sp_rpt_dtl_vat|ACNT.sp_rpt_dtl_vat|ACNT.sp_rpt_mst_vat_month&parameter="+txt_crca_pk.GetData()+"|"+txt_crca_pk.GetData()+"|"+txt_crca_pk.GetData()+","+tuser_pk;
								System.OpenTargetPage(url); 
						}
					}
				}
				///print invoice report
				if(g_lag=="print_invoice_report")
				{
					var crca_pk=""; 
					if(grd2.rows > 1)
					{
						var crca_pk="",master_pk_grid2="";
						for(var i=1;i<grd2.rows;i++)//check crca_pk exit?if crca_pk not null-->printview report 
						{
							if(grd2.GetGridData(i,G2_tac_crca_pk) !="" && crca_pk =="")
							{
								crca_pk += grd2.GetGridData(i,G2_tac_crca_pk);//pk
								InvoiceNo_ACNT += grd2.GetGridData(i,G2_Invoice_No_Acnt);//invoice
								txt_crca_pk.text=crca_pk;
								txtInvoiceNo_ACNT.text=InvoiceNo_ACNT;
							}
						}
						if(txtInvoiceNo_ACNT.text!="") //txtInvoiceNo_ACNT not  null --> print invoice report
						{
								g_lag="";
								var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rc/jarc00060_print_invoice_month.rpt&procedure=ACNT.SP_RPT_DTL_VAT|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month&parameter="+txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + ","+ user_pk +"|" + txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + ","+ user_pk +"|"+ txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() +","+ user_pk;
								System.OpenTargetPage(url);
						}
					}
				}
		break; 
    }
}
//===================================================================================
function ShowDetailInvoice(){
	var path = System.RootURL + '/form/ht/fo/htfo00100_1.aspx?pk=' + grdInvoice.GetGridData(grdInvoice.row, 15) + '&sn=' + grdInvoice.GetGridData(grdInvoice.row, 0)+ '&date=' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(6,8) + '/' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(4,6)+ '/' + grdInvoice.GetGridData(grdInvoice.row, 1).substring(0,4)+ '&room=' + grdRoomAllocate.GetGridData(grdRoomAllocate.row, 1);
    var obj = System.OpenModal( path ,550 , 500,  'resizable:yes;status:yes');
}
//----------------------------popup--customer----to--save-----------
function OnPopup()
{		
	var l_customer_pk="",l_crca_acnt_pk="",l_tco_buspartner_pk_popup="",l_G1_Customer_Name_popup="";
		if((grdRoomAllocate.rows > 1) && (grdRoomAllocate.col==G1_Customer))
		{
			if(grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_Select) == -1)
			{
				var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
					var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
					if ( object != null )
					{ 
						l_tco_buspartner_pk_popup= object[0]; //pk
						l_G1_Customer_Name_popup=object[2];//name
					}
			}
			else
			{
				alert("please,check invoice to choose customer!!!");
				return;
			}
		}
		else
		{
			//alert("please,check invoice to choose customer!!!");
			return;
		}
		if(l_tco_buspartner_pk_popup !="")
		{
			for(var i=1;i<grdRoomAllocate.rows;i++)
			{ 
				
				if(grdRoomAllocate.GetGridData(i,G1_Select) == -1)//checked
				{
					if(l_customer_pk == "")
						{
							l_customer_pk=grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk);
							l_crca_acnt_pk=grdRoomAllocate.GetGridData(i,G1_tac_crca_pk);
						}		
					if(grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk)==l_customer_pk && grdRoomAllocate.GetGridData(i,G1_tac_crca_pk)== l_crca_acnt_pk)	
					{
						grdRoomAllocate.SetGridText(i, G1_tco_buspartner_pk, l_tco_buspartner_pk_popup); //pk
						grdRoomAllocate.SetGridText(i, G1_Customer, l_G1_Customer_Name_popup);//name
					}
					else
					{
						alert("these bills are not the same invoice.So can not select together.");
						grdRoomAllocate.SetGridText(i, G1_Select,0); //uncheck
					}
				}
			}
		}
}
//--------------------------save--customer---------------------------------
function OnSave()
{
	if(grdRoomAllocate.row != "-1")
	{
		if((grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_Select) == -1)&& (grdRoomAllocate.GetGridData(grdRoomAllocate.row,G1_tco_buspartner_pk) !=""))
		{
			data_htfo00420.Call();
		}
		else
		{
			alert("Please,check and choose the customer to save.");
			return;
		}
	}
}
//=========================================================================
 function OnProcess(obj)
{
	if(obj=='1')//process grid 1
	{
		var pk="";
		var l_customer_pk="",l_crca_acnt_pk="";
	   if(grdRoomAllocate.row !='-1')
		{
			for(var i=1;i<grdRoomAllocate.rows;i++)
			{ 
				if(grdRoomAllocate.GetGridData(i,G1_Select) == -1)//checked
				{
				  if(grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk) != "")//customer_pk
				  {
					if(l_customer_pk == "")
						{
							l_customer_pk=grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk);
							l_crca_acnt_pk=grdRoomAllocate.GetGridData(i,G1_tac_crca_pk);
						}
					if(grdRoomAllocate.GetGridData(i,G1_tco_buspartner_pk)==l_customer_pk && grdRoomAllocate.GetGridData(i,G1_tac_crca_pk)== l_crca_acnt_pk)	
					{
						pk += grdRoomAllocate.GetGridData(i,G1_PK)+",";//master_pk
					}
					else
					{
						alert("these bills are not the same invoice.So can not select together.");
						return;
					}
				  }
				  else
				  {
					alert("Please input customer name row at " +i+ " to process.");
					return;
				  }
				  
				}
			}
			if(confirm("Are you sure to process the room?"))
			{
				txtRoomCheckPK.text = pk;
				//alert(txtRoomCheckPK.text);
				dso_process_inv.Call();
			}
		}
		else
		{
			alert("You must check room to process.");
		}
	}
	if(obj=='2')//if not ..yet process preview---> process  .if process--->  only printview in report and not need process again grid 2
	{
		txt_crca_pk.text="";	
		if(grd2.rows > 1)
		{
			var crca_pk="",master_pk_grid2="";
			for(var i=1;i<grd2.rows;i++)//check crca_pk exit?if crca_pk not null-->printview report 
			{
				if(grd2.GetGridData(i,G2_tac_crca_pk) !="" && crca_pk =="")
				{
					crca_pk += grd2.GetGridData(i,G2_tac_crca_pk);//pk
					txt_crca_pk.text=crca_pk;
				}
			}
			if(txt_crca_pk.text=="") //crca_pk is null -->process preview
			{  
					for(var i=1;i<grd2.rows;i++)
					{
						if(grd2.GetGridData(i,G2_Issue_YN) == -1)//checked
						{
							master_pk_grid2 += grd2.GetGridData(i,G2_pk)+",";//pk
						}
					}
					if(master_pk_grid2=="")
					{
						alert("You must check issue YN to preview.");
						return;
					}
					else
					{
						if(confirm("Do you want to preview invoice?"))
						{
							g_lag="preview_report";
							txtInvoiceIssuePK.text = master_pk_grid2;
							dso_process_preview_inv.Call();
						}
					}
			}
			else //crca_pk not null-->preview report
			{
				//alert(txt_crca_pk.text);
				if(confirm("Do you want to preview report?"))
					{
						 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rc/jarc00060_preview_invoice_month.rpt&procedure=ACNT.sp_rpt_dtl_vat|ACNT.sp_rpt_dtl_vat|ACNT.sp_rpt_mst_vat_month&parameter="+txt_crca_pk.GetData()+"|"+txt_crca_pk.GetData()+"|"+txt_crca_pk.GetData()+","+user_pk;
						  System.OpenTargetPage(url); 
					}
			}
		} 
		else
			{
				alert("You must check room to process.");
			}
	}	
}
function OnChangeGrid()
{
	var ctr_grd_invoice = document.all("ctr_grd_invoice"); 
    var ctr_grd_item_detail = document.all("ctr_grd_item_detail"); 
     
    if(radTab.value == '1')
    {
        ctr_grd_item_detail.style.display="none";
		ctr_grd_invoice.style.display="";
		document.all("tab_1").style.color = "red"; //id=tab1
		document.all("tab_2").style.color = ""; //id=tab2
    }
    else
    {
		ctr_grd_invoice.style.display="none";
		ctr_grd_item_detail.style.display="";
		document.all("tab_2").style.color = "red"; 
		document.all("tab_1").style.color = ""; 
    }
}
function OnCheck()
{
	if(grd2.rows>1)
	{
		if(chkAllGrid2.value =='Y')
		{
			for (i = 1; i < grd2.rows; i++)
			{
				if(grd2.GetGridData(i,G2_Invoice_No) !="")
				{
					grd2.SetGridText(i,G2_Issue_YN,-1);
				}
			}
			TotalPaymentDetail();
		}
		else
		{
				for (i = 1; i < grd2.rows; i++)
				{
					if(grd2.GetGridData(i,G2_Invoice_No) !="")
					{
						grd2.SetGridText(i,G2_Issue_YN,0);
					}
				}
				TotalPaymentDetail();
		}
	}
}
function TotalPaymentDetail()
{
	var TotalPayDetail=0;
		if(grd2.rows > 1)
		{
			for(var i=1;i<grd2.rows;i++)
			{  
				if(grd2.GetGridData(i,G2_Issue_YN) == -1)//checked
				{
					TotalPayDetail += Number(grd2.GetGridData(i,G2_Total_Due));
				}
			}
			//sum total pay detail!
			txtTotalPaymentDetail.text=TotalPayDetail;
		}
		else
		{
			//not data
		}		
}
function OnPrintInvoice(){
   if(grd2.rows > 1){
   var crca_pk="",InvoiceNo_ACNT="";
		for(var i=1;i<grd2.rows;i++)
		{
			if(grd2.GetGridData(i,G2_tac_crca_pk) !="" && crca_pk =="")
			{
				crca_pk += grd2.GetGridData(i,G2_tac_crca_pk);//pk
				InvoiceNo_ACNT += grd2.GetGridData(i,G2_Invoice_No_Acnt);//invoice
				txt_crca_pk.text=crca_pk;
				txtInvoiceNo_ACNT.text=InvoiceNo_ACNT;
			}
		}
		if(txt_crca_pk.text=="")
		{
			alert("You must preview to print invoice.");
			return;
		}
		if(txtInvoiceNo_ACNT.text=="")
		{
			if(confirm("Do you want to print invoice??"))
			{
				g_lag="print_invoice_report";
				dso_process_print_inv.Call();
			}
		}
		else
		{
				if(confirm("Do you want to print invoice report?"))
				{
					var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rc/jarc00060_print_invoice_month.rpt&procedure=ACNT.SP_RPT_DTL_VAT|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month|ACNT.SP_RPT_DTL_VAT|ACNT.sp_rpt_mst_vat_month&parameter="+txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + ","+ user_pk +"|" + txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() + ","+ user_pk +"|"+ txt_crca_pk.GetData() + "|" + txt_crca_pk.GetData() +","+ user_pk;
					System.OpenTargetPage(url);
				}
		}
	}   
}
function OnPrintAcctSlip(){
  
  if(grd2.rows <= 1){
	 alert("Nothing to print.");	
	 return;
  }
  
  var tac_hgtrh_pk=grd2.GetGridData(1,G2_tac_hgtrh_pk);
 
 if(tac_hgtrh_pk == ""){
	 alert("Please print invoice fisrtly then print accounting slip.");	
	 return;
  }
  
  var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq='+ tac_hgtrh_pk;
  System.OpenTargetPage( url , 'newform' );
		
}
function OnCancel()
{
	if(grd2.rows > 1)
	{
	   var crca_pk="";
	   txtInvoiceNo_ACNT.text="";
			for(var i=1;i<grd2.rows;i++)
			{
				if(grd2.GetGridData(i,G2_tac_crca_pk) !="" && crca_pk =="")
				{
					crca_pk += grd2.GetGridData(i,G2_tac_crca_pk);//pk
					txt_Cancel_crca_pk.text=crca_pk;
					txtInvoiceNo_ACNT.text += grd2.GetGridData(i,G2_Invoice_No_Acnt);//invoice acnt
				}
			}
			if(txt_Cancel_crca_pk.text=="")
			{
				alert("Not data to cancel.");
				return;
			}
			if(txtInvoiceNo_ACNT.text!="")
			{
				alert("This Invoice was confirm. You can't cancel!");
				return;
			}
			else
			{
				if(confirm("Are you sure to cancel the invoice?"))
				{
					dso_process_cancel_inv.Call();
					//alert(txtInvoiceNo_ACNT.text);
				}
			}
	}
}
function OnReport()
{
	 if(grdRoomAllocate.row !="-1") 
	 {
		var url =System.RootURL + '/reports/ht/fo/rpt_htfo00420_print_Hotel_Golf.aspx?p_tht_room_allocate_pk='+grdRoomAllocate.GetGridData(grdRoomAllocate.row,0)+'&p_cashier_pk='+user_pk+'&p_month='+idMonth.value;
		 System.OpenTargetPage(url); 
	}
	
}

</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00420" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid" parameter="0,27" function="CRM.sp_sel_htfo00420" procedure="crm.sp_upd_htfo00420_buspartner">
                <input  bind="grdRoomAllocate">
                    <input bind="idMonth" /> 
                    <input bind="txtRoomGuest" /> 
					<input bind="chkCheckOut" /> 
                </input> 
                <output bind="grdRoomAllocate" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00420_invoice" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="CRM.sp_sel_htfo00420_invoice" >
                <input  bind="grdInvoice">
                    <input bind="txtRoomAllocatePK" />
					<input bind="lstLocation" />
					<input bind="idMonth" /> 
                </input> 
                <output bind="grdInvoice" /> 
            </dso> 
        </xml> 
    </gw:data>
	<!-----------------------process----grid--1------------------------->
	<gw:data id="dso_process_inv" onreceive="OnDataReceive(this)"> 
		<xml> 
			<dso  type="process" procedure="CRM.sp_pro_htfo00420" > 
				<input>
					<input bind="txtRoomCheckPK" />
					<input bind="idMonth" /> 
				</input> 
				<output>
					<output bind="txtReturn" />
				</output>
			</dso> 
		</xml> 
	</gw:data>
    <!-----------------------process----preview-----invoice----grid--2-------------->
<gw:data id="dso_process_preview_inv" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="CRM.sp_pro_htfo00420_create_inv" > 
            <input>
                <input bind="txtInvoiceIssuePK" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!--------------process----print-----invoice------------>
<gw:data id="dso_process_print_inv" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="crm.sp_pro_htfo00420_confirm" > 
            <input>
                <input bind="txt_crca_pk" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!-------select-----grid-----2-------------------->
<gw:data id="dat_sel_grid2" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid"   function="crm.sp_sel_htfo00420_detail" > 
            <input bind="grd2">                    
                <input bind="txtRoomCheckPK" />
				<input bind="idMonth" />	
            </input> 
            <output bind="grd2"></output>
        </dso> 
    </xml> 
</gw:data>
<!--------------cancel----invoice------------>
<gw:data id="dso_process_cancel_inv" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="CRM.sp_pro_htfo00420_cancel" > 
            <input>
                <input bind="txt_Cancel_crca_pk" />
            </input> 
            <output>
                <output bind="txtReturn" />
            </output>
        </dso> 
    </xml> 
</gw:data>
<!---------------------------------------process---create--bacode------------------->
<gw:data id="dso_upd_print_out" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso type="process" procedure="acnt.SP_UPD_VAT_INVOICE_AMB" >
                <input> 
					<input bind="txt_crca_pk" />       
					<input bind="txtPrint_Param" />
                </input>  
                <output>
                     <output bind="txtReturn" />
				</output> 
            </dso> 
        </xml> 
    </gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="0">
        <tr style="height: 50%" id="grd_1"> 
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Month
                        </td>
                        <td style="width: 8%; white-space: nowrap" align="center">
							<gw:datebox id="idMonth" maxlen="10" text="" styles='width:50%' lang="1"
                    type="month" onchange="OnSearch('grd1')" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Room#/Guest Name:
                        </td>
                        <td width="20%" align="right">
                            <gw:textbox id="txtRoomGuest" styles="width: 100%" onenterkey="OnSearch('grd1')" />
                        </td>
						<td style="width: 10%; white-space: nowrap" align="left">
                            Check Out
                            <gw:checkbox id="chkCheckOut" styles="color:blue" defaultvalue="Y|N" value="N" onclick="OnSearch('grd1')">
                            </gw:checkbox>
                        </td>
						<td style="width: 28%" align="left">
                           
                        </td>
						<td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch('grd1')" />
                        </td>
						<td style="width: 1%" align="left">
                            <gw:imgbtn id="ibtnReport3" img="excel" alt="Print Invoice" onclick="OnReport()" />
						<td style="width: 3%" align="right">
							<gw:icon id="btnSave" img="2" text="Process" styles='width:100%' onclick="OnProcess('1')" />
						</td>
						<td style="width: 3%" align="right">
							<gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" />
						</td>
                        <td style="width: 10%; white-space: nowrap">
                            Total Room:
                        </td>
                        <td style="width: 5%">
                            <gw:label id="lblRows" />
                        </td>
                        
                    </tr> 
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id="grdRoomAllocate" header="_PK|Select|RM#|RM Type|Last Name|First Name|Checkin|Checkout|Total Due|Room Charge|Other Fee|FnB(Hotel)|Minibar|Laudry|Tennis|Telephone|Fnb(Golf)|ProShop|Drv_Range|Teaching|Golf Rental|Green Fee|Caddie Fee|Cart Fee|Bag Fee|Adjust|Customer|_tco_buspartner_pk|Invoice No Acnt|_tac_crca_pk" 
								format="0|3|0|0|0|0|4|4|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0"
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 	
								acceptnulldate="T" sorting='T' autosize='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('INVOICE')" oncelldblclick="OnPopup()"
								/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
		
		<tr style="height: 2%" id="ctr_radio">
			<td style="width: 100%; white-space: nowrap" align="left">
				<gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeGrid()">                      
					<span id="tab_1" value="1">Invoice</span>                       
					<span id="tab_2" value="2">Item Detail</span>   			                                
				</gw:radio>
			</td>

		</tr>
		
		<tr style="width: 100%; height: 24%" id="ctr_grd_invoice">
            <td  >
                <table valign='top'  cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
					<tr style="height: 2%">
							<td style="width: 11%"><gw:checkbox id="chkAllGrid2" defaultvalue="Y|N" onchange="OnCheck()"  />Select All</td>
							<td style="width: 33%">
								<b style="color: Red; font-weight: bold">Select Room----->Process------->Preview------->Print Invoice</b>		
							</td>
							<td style="width: 8%" align="right">
								Total Due&nbsp;
							</td>
							<td style="width: 14%" align="right">
								<gw:textbox id="txtTotalPaymentDetail" type="number" format="###,###,###" styles="text-align:right;width:80%;" />&nbsp;&nbsp;
							</td>
							<td style="width: 3%" align="right">
								<gw:imgbtn id="btnSearch2" img="search" width="100%" img="in" text="search" onclick="OnSearch('2')" />
							</td>
							<td style="width: 7%" align="right">
								<gw:icon id="idBtnPreview" img="2" text="Preview" styles='width:100%' onclick="OnProcess('2')" />
							</td>
							<td style="width: 2%" align="right">
							</td>
							<td style="width: 7%" align="right">
							<gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:100%' onclick="OnCancel()" />
							</td>
							<td style="width: 1%" align="right">
							</td>
							<td style="width: 8%" align="right">
								<gw:icon id="idBtnPrintBill" img="2" text="Print Invoice" styles='width:100%' onclick="OnPrintInvoice()" />
							</td>
							<td style="width: 1%" align="right">
							</td>
							<td style="width: 5%" align="right">
								<gw:icon id="idBtnAcctSlip" img="2" text="Acc.Slip" styles='width:100%' onclick="OnPrintAcctSlip()" />
							</td>
					</tr>
				<tr valign="top" style="height: 98%">
					<td colspan="12" >
						<gw:grid id="grd2" header="_pk|Issue YN|Invoice No|Invoice Date|Book Amt|Service Rate|Service Amt|SCT Rate|SCT Amt|VAT Rate|VAT Amt|Total Due|Description|Local Description|PL Code Name|Debit Acc|Credit Acc|Customer Name|_tac_crca_pk|Invoice No(Acnt)|_tac_hgtrh_pk"
							format="0|3|0|0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0|0|0|0|0|0" 
							aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
							styles="width:100%; height:100%" oncellclick="TotalPaymentDetail()"
							sorting="T" autosize="T"  />
					</td>
				</tr>
			</table>
		</td>
	</tr>
		
		
		
        <tr style="height: 24%" id="ctr_grd_item_detail"> 
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width:7%; white-space: nowrap">
                            Location
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:list id="lstLocation" onchange="OnSearch('INVOICE')" />
                        </td>
                        
                        <td style="width:70%; white-space: nowrap" align="center">
						   Double click on the row below to see detail invoice
                        </td>
                        <td style="width: 3%" align="right">
                            
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdInvoice' header='Invoice No|Date|Location|Amount(usd)|Amount(vnd)|SVC Amt|Vat Amt|Discount|Total Due|Room#|Created By|Created date|Modified by|Modified date|Status|_PK'
                                format='0|4|0|-2|-0|-0|-0|-0|-0|0|0|0|0|0|0|0' 
                                aligns='0|0|0|0|0|0|0|0|0|0|1|0|0|0|1|0'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                sorting='T' styles='width:100%; height:100%' autosize="T" 
								oncelldblclick="ShowDetailInvoice()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtRoomAllocatePK" styles='width:100%;display:none' />
	<gw:textbox id="txtRoomCheckPK" style="display: none" /> 
	<gw:textbox id="txtReturn" style="display: none" />
	<gw:textbox id="txtInvoiceIssuePK" style="display: none" /> 
	<gw:textbox id="txt_crca_pk" style="display: none" /> 
	<gw:textbox id="txt_Cancel_crca_pk" style="display: none" /> 
	<gw:textbox id="txtPrint_Param" text="1,2,3" styles="display:none;" />
	<gw:textbox id="txtInvoiceNo_ACNT" style="display: none" />
    <!------------------------------------------------------------------>
</body>
</html>
