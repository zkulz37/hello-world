<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Request for payment</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>

var G1_PK				= 0,
	G1_PARTNER_PK		= 1,
	G1_PARTNER_CODE		= 2,
	G1_PARTNER_NAME		= 3,
	G1_OUTSIDE_PK		= 4,
	G1_OUTSIDE_CODE		= 5,
	G1_OUTSIDE_NAME		= 6,
	G1_START			= 7,
	G1_EXPIRED			= 8,
	G1_CURRENCY			= 9,
	G1_SUPPLY_PRICE		= 10,
	G1_VAT				= 11,
	G1_CONTRACT_DATE	= 12,
	G1_BALANCE			= 13,
	G1_AMT				= 14,
	G1_SUB_CD           = 15,
	G1_SUB_NM           = 16,
	G1_SUB_PK           = 17;

var G2_PK						= 0,
    G2_SLIP_NO					= 1,
    G2_INSPEC_DATE				= 2,
	G2_INVOICE_DATE				= 3,
	G2_DUE_DATE					= 4,
    G2_PAY_DES					= 5,
    G2_TAX_TYPE					= 6,
    G2_PAY_REQ_AMT				= 7,
	G2_ACC_RATE					= 8,
    G2_PAY_REQ_RATE				= 9,
	G2_PAY_EV_AMT				= 10,
	G2_PAY_RATE					= 11,
	G2_PAY_DEDUCTION			= 12,
	G2_REQ_AMT					= 13,
	G2_VAT						= 14,
	G2_TAX						= 15,
	G2_RETENTION_AMT			= 16,
	G2_TOTAL					= 17,
	G2_PRO_PAY_RATE				= 18,
	G2_STATUS					= 19,
	G2_PAY_METHOD				= 20,
	G2_TECPS_SUBSTRP12000_PK	= 21,
	G2_TECPS_PROJECTSUMM_PK		= 22,
	G2_TAC_ABACCTCODE_PK_DR		= 23,
	G2_D_CODE					= 24,
	G2_D_NAME					= 25,
	G2_TAC_ABACCTCODE_PK_CR		= 26,
	G2_C_CODE					= 27,
	G2_C_NAME					= 28,
	G2_DEBIT_VAT				= 29,
	G2_D_VAT_CODE				= 30,
	G2_D_VAT_NAME				= 31,
	G2_CREDIT_VAT				= 32,
	G2_C_VAT_CODE				= 33,
	G2_C_VAT_NAME				= 34,
	G2_DEBIT_WITHHOLDING		= 35,
	G2_D_W_CODE					= 36,
	G2_D_W_NAME					= 37,
	G2_CREDIT_WITHHOLDING		= 38,
	G2_C_W_CODE					= 39,
	G2_C_W_NAME					= 40,
	G2_DEBIT_RETENTION			= 41,
	G2_D_R_CODE					= 42,
	G2_D_R_NAME					= 43,
	G2_CREDIT_RETENTION			= 44,
	G2_C_R_CODE					= 45,
	G2_C_R_NAME					= 46,
	G2_SEQ						= 47;

function BodyInit()
{
	System.Translate(document);
	BindingDataList();
	grdDetail.GetGridControl().WordWrap = true;
	grdDetail.GetGridControl().RowHeight(0) = 450;
	var ctl = grdMST.GetGridControl();
	ctl.ColAlignment(G1_SUPPLY_PRICE)	= 7;
	ctl.ColAlignment(G1_VAT)			= 7;
	ctl.ColAlignment(G1_BALANCE)		= 7;
	ctl.ColAlignment(G1_AMT)			= 7;
	
	ctl.ColFormat(G1_SUPPLY_PRICE)	= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_VAT)			= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_BALANCE)		= "#,###,###,###,###,###,###,###,###.##R";
	ctl.ColFormat(G1_AMT)			= "#,###,###,###,###,###,###,###,###.##R";

	var conn = grdDetail.GetGridControl();
	conn.FrozenCols = G2_PAY_REQ_AMT;
	for (col = G2_PAY_REQ_AMT; col <= G2_PRO_PAY_RATE; col++)
	{
		conn.ColAlignment(col)	= 7;
		conn.ColFormat(col)		= "#,###,###,###,###,###,###,###,###.##R";
	}
}	

function BindingDataList()
{
	<%=ESysLib.SetGridColumnComboFormat("grdDetail", 5,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0030' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;
	<%=ESysLib.SetGridColumnComboFormat("grdDetail", 6,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0041' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;
	<%=ESysLib.SetGridColumnComboFormat("grdDetail", 20,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0043' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;

} 

function OnSearch()
{
    dso_kpbm00070.Call("SELECT");
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
			    txtProject_Pk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2]; 
				OnSearch();
		    }
	    break;
		case 'proposal':
		    if (grdDetail.row > 0)
		    {
		        if (grdDetail.GetGridData(grdDetail.row, G2_PAY_DES) == '01')
		        {
		            var path = System.RootURL + '/reports/kp/cs/kpcs314_request4payment_2.aspx?p_pk=' + grdDetail.GetGridData(grdDetail.row, G2_PK);
		            System.OpenTargetPage(path);
		        }
		        else
		        {
		            var path = System.RootURL + '/reports/kp/cs/kpcs314_request4payment_1.aspx?p_pk=' + grdDetail.GetGridData(grdDetail.row, G2_PK);
		            System.OpenTargetPage(path);
		        }
		    }
	    break;
		case 'Make':
			if (grdDetail.GetGridData(grdDetail.row, G2_PK))
			{				
				txtAction.text = "INSERT";
				txtMakeDT.text = grdDetail.GetGridData(grdDetail.row, G2_INSPEC_DATE);
				txtReqPK.text = grdDetail.GetGridData(grdDetail.row, G2_PK);
				dso_MakeSlip.Call();	
			}
		break;
		case 'Cancel':
			txtAction.text = "DELETE";
			txtReqPK.text = grdDetail.GetGridData(grdDetail.row, G2_PK);
			dso_MakeSlip.Call();	
		break;
    }
}
function OnSearchDTL()
{
	dso_grdDetail.Call("SELECT");
}

function OnAddRow()
{
    
}

function OnSave()
{
    dso_kpbm00070.Call();
}

function OnDelete()
{
    if ( grdDetail.row > 0 )
    {
        if(confirm("Are you sure to delete !!!"))
        {
            if ( grdDetail.GetGridData( grdDetail.row, G2_PK ) == "" ) 
            {						            				
                grdDetail.RemoveRow();					
            }        			
            else 
            {  
                grdDetail.DeleteRow();
            }
        }        
    }    
}

function OnUnDelete() 
{
    grdDetail.UnDeleteRow();
}

function OnSearch()
{
	dso_outsourcing.Call("SELECT");
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_outsourcing':
			if (grdMST.rows > 1)
			{
				grdMST.SelectRow(1);
				CellClick();
			}
		break;	      
	}
}

function CellClick()
{
	if (grdMST.row > 0)
	{
		txtMSTPK.text = grdMST.GetGridData(grdMST.row, G1_PK);
		dso_grdDetail.Call("SELECT");
	}
}

function GridDTLClick()
{
	if (grdDetail.col == G2_SLIP_NO)
	{
		var path = System.RootURL + '/form/kp/cs/kpcs314_request.aspx?p_prj_pk=' + txtProject_Pk.text 
				+ "&p_payment_pk="	+ grdDetail.GetGridData(grdDetail.row, G2_PK) 			
				+ "&p_prj_code="	+ txtProject_Cd.text + "&p_prj_name=" + txtProject_Nm.text
				+ "&p_subno_pk="	+ grdMST.GetGridData(grdMST.row, G1_SUB_PK) 
				+ "&p_subno_code="	+ grdMST.GetGridData(grdMST.row, G1_SUB_CD) 
				+ "&p_subno_name="	+ grdMST.GetGridData(grdMST.row, G1_SUB_NM)
				+ "&p_sub_pk="		+ grdMST.GetGridData(grdMST.row, G1_PARTNER_PK) 
				+ "&p_sub_code="	+ grdMST.GetGridData(grdMST.row, G1_PARTNER_CODE) 
				+ "&p_sub_name="	+ grdMST.GetGridData(grdMST.row, G1_PARTNER_NAME)
				+ "&p_ccy="			+ grdMST.GetGridData(grdMST.row, G1_CURRENCY)
				+ "&p_status=update";
				var object = System.OpenModal( path, 900, 700, 'resizable:yes;status:yes');
		OnSearchDTL();
	}

	if (grdDetail.col == G2_D_CODE || grdDetail.col == G2_D_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_TAC_ABACCTCODE_PK_DR, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_D_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_D_NAME, tmp[3]);
		}
	}
	 
	if (grdDetail.col == G2_C_CODE || grdDetail.col == G2_C_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_TAC_ABACCTCODE_PK_CR, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_C_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_C_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_D_VAT_CODE || grdDetail.col == G2_D_VAT_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_DEBIT_VAT, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_D_VAT_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_D_VAT_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_C_VAT_CODE || grdDetail.col == G2_C_VAT_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_CREDIT_VAT, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_C_VAT_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_C_VAT_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_D_W_CODE || grdDetail.col == G2_D_W_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_DEBIT_WITHHOLDING, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_D_W_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_D_W_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_C_W_CODE || grdDetail.col == G2_C_W_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_CREDIT_WITHHOLDING, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_C_W_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_C_W_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_D_R_CODE || grdDetail.col == G2_D_R_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_DEBIT_RETENTION, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_D_R_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_D_R_NAME, tmp[3]);
		}
	}

	if (grdDetail.col == G2_C_R_CODE || grdDetail.col == G2_C_R_NAME)
	{		
		var fpath   = System.RootURL + "/form/kp/cs/kpcs314_Transaction.aspx?dsqlid=EC111.SP_SEL_KPCS314_ACC" + "&p_type=";
		aValue = System.OpenModal(  fpath , 750 , 550 , 'resizable:yes;status:yes');

		if (aValue != null)
		{
			var tmp = aValue[0];
			grdDetail.SetGridText(grdDetail.row, G2_CREDIT_RETENTION, tmp[1]);
			grdDetail.SetGridText(grdDetail.row, G2_C_R_CODE, tmp[2]);
			grdDetail.SetGridText(grdDetail.row, G2_C_R_NAME, tmp[3]);
		}
	}
}

function CheckData()
{
	var total = 0;

	if (grdDetail.col >= G2_PAY_REQ_AMT && grdDetail.col <= G2_PRO_PAY_RATE)
	{
		if (isNaN(grdDetail.GetGridData(grdDetail.row, grdDetail.col)))
		{
			grdDetail.SetGridText(grdDetail.row, grdDetail.col, '0');
		}

		if (grdDetail.col == G2_REQ_AMT || grdDetail.col == G2_VAT
		 || grdDetail.col == G2_TAX || grdDetail.col == G2_RETENTION_AMT)
		{
			total = Number(grdDetail.GetGridData(grdDetail.row, G2_REQ_AMT)) + Number(grdDetail.GetGridData(grdDetail.row, G2_VAT)) - Number(grdDetail.GetGridData(grdDetail.row, G2_TAX)) - Number(grdDetail.GetGridData(grdDetail.row, G2_RETENTION_AMT))

			grdDetail.SetGridText(grdDetail.row, G2_TOTAL, total);
		}
	}
}

function OnClickBtn(obj)
{
	switch (obj.id)
	{
		case 'btnAdd':
			if (txtProject_Pk.text == '')
			{
				alert('Please, select Project !!!');
				return;
			}

			if (grdMST.GetGridData(grdMST.row, G1_PARTNER_PK) == '')
			{
				alert('Please, input Outsourcing Company !!!');
				return;
			}
			
			var seq = '';
			
			if (grdDetail.rows == 1)
				seq = '';
			else
				seq = Number(grdDetail.GetGridData(grdDetail.rows - 1, G2_SEQ)) + 1;
			
			var path = System.RootURL + '/form/kp/cs/kpcs314_request.aspx?p_prj_pk=' + txtProject_Pk.text 
				+ "&p_payment_pk="	+ ''
				+ "&p_mst_pk="		+ grdMST.GetGridData(grdMST.row, G1_PK)
				+ "&p_prj_code="	+ txtProject_Cd.text 
				+ "&p_prj_name="	+ txtProject_Nm.text
				+ "&p_subno_pk="	+ grdMST.GetGridData(grdMST.row, G1_SUB_PK) 
				+ "&p_subno_code="	+ grdMST.GetGridData(grdMST.row, G1_SUB_CD) 
				+ "&p_subno_name="	+ grdMST.GetGridData(grdMST.row, G1_SUB_NM)
				+ "&p_sub_pk="		+ grdMST.GetGridData(grdMST.row, G1_PARTNER_PK) 
				+ "&p_sub_code="	+ grdMST.GetGridData(grdMST.row, G1_PARTNER_CODE) 
				+ "&p_sub_name="	+ grdMST.GetGridData(grdMST.row, G1_PARTNER_NAME)
				+ "&p_ccy="			+ grdMST.GetGridData(grdMST.row, G1_CURRENCY)
				+ "&p_status=new" 
				+ "&p_seq="			+ seq ;
				var aValue = System.OpenModal( path , 900 ,700 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
			
				OnSearchDTL();
		break;
		case 'btnSave':
			dso_grdDetail.Call();	
		break;
		case 'btnDelete':	
			if ( grdDetail.row > 0 )
			{
				if (confirm('Are you sure delete Slip [' + grdDetail.GetGridData(grdDetail.row, G2_SLIP_NO) + '] ?'))
				{
					if ( grdDetail.GetGridData( grdDetail.row, G2_PK) == "" ) 
					{						            				
						grdDetail.RemoveRow();					
					}        			
					else 
					{  
						grdDetail.DeleteRow();
						dso_grdDetail.Call();
					}
				}
			}
		break;
		case 'btnUDelete':
			grdDetail.UnDeleteRow();
		break;
	}
}
//-------------------------------------------------------------------------
</script>

<body>
<!------------------------------------------------------------------------------------------------------------------>
<gw:data id="dso_outsourcing" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid" function="ec111.sp_sel_kpcs314_1"> 
			<input bind="grdMST">                    
				<input bind="txtProject_Pk" /> 
			</input> 
			<output bind="grdMST" />
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_grdDetail" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="2" type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,26,29,32,35,38,41,44" function="ec111.sp_sel_kpcs314_3" procedure="ec111.sp_upd_kpcs314_3">
			<input bind="grdDetail">
				<input bind="txtMSTPK" /> 
			</input> 
			<output bind="grdDetail" />
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_MakeSlip" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="process" parameter="0,1,2,3" procedure="ec111.sp_pro_kpcs314_makeslip"> 
			<input> 
				 <input bind="txtAction" />
				 <input bind="dtActual"/>
				 <input bind="txtMakeDT" />
				 <input bind="txtReqPK"/>
			</input>
			<output>
				 <output bind="lbStatus"/>
		   </output> 
		</dso> 
	</xml> 
</gw:data>
<!------------------------------------------------------------------------------------------------------------------>
    <table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td style="width: 100%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="right" width="6%">
                            <a title="Click here to show Project" href="#" style="text-decoration: none" onclick="OnPopUp('project')">
                                Project&nbsp;</a></td>
                        <td width="20%">
                            <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                        </td>
                        <td width="30%">
                            <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                        </td>
                        <td width="">
                            <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                        </td>
                        <td>
                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="white-space: nowrap">
                            Applied Month
                        </td>
                        <td>
                            <gw:datebox type="month" id="dtActual" lang="1" />
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td><gw:imgbtn id="ibtnsearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 40%">
            <td>
                <gw:grid id="grdMST" 
					header="_PK|_PART_PK|_Outsourcing Code|Outsourcing Company|_PK|Outside Work Code|Outside Work Name|Start Date|Expired Date|Currency|Supply Price|VAT|Contract Date|Advance Pay Balance|Pay Cumulative Amount|_SUB_CD|_SUB_NM|_SUB_PK"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					aligns="0|0|0|0|0|0|0|1|1|1|1|1|1|1|0|0|0|0"
                    defaults="|||||||||||||||||" 
					editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="2000|3000|1000|4000|3000|2000|3000|2000|2500|2500|1500|2200|0|0|0|0|0"
                    styles="width:100%; height:100%" sorting="T" autosize="T" 
					debug="false"
					oncellclick="CellClick()" />
            </td>
        </tr>
		<tr style="height: 5%">
			<td>
				<table>
					<tr>
						<td style="width: 60%;" align="left">
							<font color="#FF0000">* Double click Slip No</font>
						</td>
						<td style="width: 23%;" align="right">
							<gw:label id="lbStatus" styles='width:100%' />
						</td>
						<td style="width: 5%">
							<gw:icon id="btnCancel" img="in" text="Cancel Slip" onclick="OnPopUp('Cancel')"  />
						</td>
						<td style="width: 5%">
							<gw:icon id="btnMake" img="in" text="Make Slip" onclick="OnPopUp('Make')"  />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="btnAdd" img="new" alt="Add" onclick="OnClickBtn(this)" />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnClickBtn(this)" />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnClickBtn(this)" />
						</td>
						<td style="width: 1%">
							<gw:imgbtn id="btnUdelete" img="udelete" alt="UnDelete" onclick="OnClickBtn(this)" />
						</td>
						<td style="width: 1%">
						    <gw:imgbtn id="ibtnexcel" img="excel" alt="excel" onclick="OnPopUp('proposal')" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
        <tr style="height: 50%">
            <td>
                <gw:grid id="grdDetail" 
				header="_PK|Slip No|Inspection Date|Invoice Date|Due Date|Progress Payment Description|Tax Type|Progress Payment Request Amount|ACC Rate|Progress Payment Request Rate|_Progress Payment Evaluation Amount|Ex. Rate|Advance Pay Deduction|Request Amount(A)|VAT(B)|Witholding Tax(C)|Retention Money(D)|Total(A+B-C-D)|_Cumulative Progress Payment  Rate|Progress Status|Pay Method|_TECPS_SUBSTRP12000_PK|_TECPS_PROJECTSUMM_PK|_tac_abacctcode_pk_dr|Debit Code|Debit Name|_tac_abacctcode_pk_cr|Credit Code|Credit Name|_debitvat|Debit VAT Code|Debit VAT Name|_creditvat|Credit VAT Code|Credit VAT Name|_debitwithholding|Debit Withholding Code|Debit Withholding Name|_creditwithholding|Credit Withholding Code|Credit Withholding Name|_debitretention|Debit Retention Code|Debit Retention Name|_creditretention|Credit Retention Code|Credit Retention Name|_SEQ"
				format="0|0|4|4|4|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
				aligns="0|0|1|1|1|0|0|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
				defaults="|||||||||||||||||||||||||||||||||||||||||||||||" 
			    editcol="1|1|1|1|1|1|1|0|0|1|1|1|1|1|1|1|1|0|1|0|1|0|0|0|0|0|0|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
				widths="2000|1000|1500|1500|1500|1700|1000|1700|1700|1700|1700|1700|1700|1700|1700|1700|1700|2000|0|0|3000|0|0|0|1700|3000|0|1700|3000|0|1700|3000|0|1700|3000|0|1700|3000|0|1700|3000|0|1700|3000|0|1700|3000|0"
				styles="width:100%; height:100%" 
				sorting="T" 
				debug="false"
				oncelldblclick="GridDTLClick()" 
				onafteredit="CheckData()"/>
            </td>
        </tr>
        <tr style="height: 50%;display:none">
            <td>     
                <table style="width: 100%; height: 100%" border="1" cellpadding="1" cellspacing="0">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Inspection Date
                        </td>
                        <td style="width: 30%">
                            <gw:datebox id="dtInspDt" lang="1" styles='width:100%' />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Process Type
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstPayment" styles='width:100%' />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Currency/Ex Rate
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:list id="lstCurrency" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtExrate" lang="1" styles='width:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Tax Y/N
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstTaxYNs" styles='width:100%' />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Applied Progress Amount
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtAppProAmt1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtAppProAmt2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Applied Progress Rate
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtAppProRate" lang="1" styles='width:90%' />
                            %
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Assessed Progress Amount
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtAssProAmt1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtAssProAmt2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Progress Payment Rate
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtProPayRate" lang="1" styles='width:90%' />
                            %
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Down Payment Document
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtDowPayDo1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtDowPayDo2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 10%; white-space: nowrap" rowspan="2" align="right">
                            Sum
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtSumUSD" lang="1" styles='width:90%' />
                            USD
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Requested Amount
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtReqAmt1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtReqAmt2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtSumVND" lang="1" styles='width:90%' />
                            VND
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            VAT
                        </td>
                        <td style="white-space: nowrap; width: 30%" colspan="3">
                            <table style="width: 38%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtVat1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtVat2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%;" align="right">
                            Cumulative Progress Payment Amount
                        </td>
                        <td style="white-space: nowrap; width: 30%">
                            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtCumProPayAmt1" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%">
                                        <gw:textbox id="txtCumProPayAmt2" lang="1" styles='width:100%' />
                                    </td>
                                    <td style="width: 1%">
                                        VND
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 10%;" align="right">
                            Cumulative Progress Payment Rate
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtCumProPayRate" lang="1" styles='width:90%' />
                            %
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%;" align="right">
                            Inspection Result
                        </td>
                        <td style="white-space: nowrap; width: 30%" colspan="3">
                            <gw:textarea id="txtremark" styles='width:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtMSTPK" lang="1" styles='width:100%;display:none' />
<gw:textbox id="txtMakeDT" lang="1" styles='width:100%;display:none' />
<gw:textbox id="txtAction" lang="1" styles='width:100%;display:none' />
<gw:textbox id="txtReqPK" lang="1" styles='width:100%;display:none' />
</html>
