﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Progress payment inquiry</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
//---------------------------------------------------------------------------------------------
function BodyInit()
{
   // MerGrid();
	gridMST.GetGridControl().FrozenCols = 3;
	gridMST.GetGridControl().WordWrap = true;
    gridMST.GetGridControl().RowHeight(0) = 380 ;
}
//---------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProjectPK.text = object[0];
                txtProjectCode.text = object[1];
                txtProjectName.text = object[2]; 
			  //  OnSearch();
		    }
	    break;
		case 'Subcontract':
		   if (txtProjectPK.text == '')
			{
				alert('Please, Select project first.');
			}
			else
			{
				var path = System.RootURL + '/form/kp/ar/kpar30_Subcontract.aspx?Project_pk=' + txtProjectPK.text;
				var obj = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
				
				if ( obj != null )
				{
					txtSubctpk.SetDataText(obj[0]);
					txtSubctCode.SetDataText(obj[3]);
					txtSubctName.SetDataText(obj[2]); 
				 					
				}
			}
		break;
		case 'sub_d':
			 var url = System.RootURL + "/reports/kp/cs/kpcs315_d.aspx?pk=" + gridMST.GetGridData(gridMST.row,1);
			 System.OpenTargetPage(url);
			
		break;
		
    }
    
}
//---------------------------------------------------------------------------------------------
function OnSearch()
{
	dso_search.Call('SELECT');

}

//---------------------------------------------------------------------------------------------
function MerGrid()
{
    if (gridMST.rows < 2)
		{
			
			gridMST.AddRow();
		}
	var fg=gridMST.GetGridControl();
		fg.FixedRows = 2
		fg.MergeCells = 5

		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "PK"
		
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Work Code"
		
        fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Work Name"

		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Subcontractor"

		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 2) = "Work Name"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 4, 0, 5) = "Subcontract Period"  
		fg.Cell(0, 1, 4, 1) 	= "Start Date"
		fg.Cell(0, 1, 5, 1 ) 	= "Finish Date"

        fg.MergeRow(0) = true
		fg.Cell(0, 0, 6, 0, 7) = "Subcontract Amount"  
		fg.Cell(0, 1, 6, 1) 	= "Currency"
		fg.Cell(0, 1, 7, 1 ) 	= "Amount"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 8, 0, 11) = "Advance Payment Amount"  
		fg.Cell(0, 1, 8, 1) 	= "Paid Amount"
		fg.Cell(0, 1, 9, 1 ) 	= "Deduction Amount(current)"
		fg.Cell(0, 1, 10, 1 ) 	= "cumulative deduction Amount"
		fg.Cell(0, 1, 11, 1 ) 	= "Remain Advance Payment"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 12, 0, 15) = "Progress Payment Amount"  
		fg.Cell(0, 1, 12, 1) 	= "Final date"
		fg.Cell(0, 1, 13, 1 ) 	= "Current "
		fg.Cell(0, 1, 14, 1 ) 	= "Accumulation"
		fg.Cell(0, 1, 15, 1 ) 	= "Remain"
		
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 16, 0, 17) = "Payment Progress Rate"  
		fg.Cell(0, 1, 16, 1) 	= "Current"
		fg.Cell(0, 1, 17, 1 ) 	= "Accumulation"		
}
//---------------------------------------------------------------------------------------------
function OnReset(pos)
{
    switch(pos)
    {
        case '1':
				txtProjectPK.text = "";
                txtProjectCode.text = "";
                txtProjectName.text = ""; 
	    break;
		
    }
	
}
//---------------------------------------------------------------------------------------------
function OnChangeCurrency()
{
    dso_get_rate.Call();
}
//--------------------------------------------------------------------------------------------
function onDataReceive(obj)
{
	switch(obj.id)
	{
		case "dso_search":
		 gridMST.Subtotal(1,2,0,"9!10!11!12!13!14!15!16!17!18!20!22","Total",true,0,"Total %s");
		 //  gridMST.Subtotal(1,2,0,"8!9!10!11!12!13!14!15!16!17!18","Total",true,0,3);
		   
			//MerGrid();
		 /*	var adv_amt=0;
            var deduct_amt=0;
			var remain=0;
			var contact_amt =0;
			var acc_pp_amt = 0;
			var pp_remain = 0;
			var current_rate =0;
			var acc_rate =0;
			var current_pp_amt =0 ;
			for(var i=2;i<gridMST.rows;i++)
			{
				adv_amt = 	gridMST.GetGridData(i,8);
				deduct_amt = 	gridMST.GetGridData(i,10);
				remain = Number(adv_amt) - Number(deduct_amt) ; 
                gridMST.SetGridText(i,11,remain);
				contact_amt = 	gridMST.GetGridData(i,7);
                acc_pp_amt = 	gridMST.GetGridData(i,14);
				pp_remain  = Number(contact_amt) - Number(acc_pp_amt);
                gridMST.SetGridText(i,15,pp_remain);
				current_pp_amt = gridMST.GetGridData(i,13);
				if(Number(contact_amt) !=0 )
				{
					current_rate = (current_pp_amt/ contact_amt )*100;
                    acc_rate = (acc_pp_amt/ contact_amt)*100;
                    gridMST.SetGridText(i,16,current_rate);
					gridMST.SetGridText(i,17,acc_rate);
				}
            } */
		break;
	}
}
function OnPrint()
{
  
    //var url = '/reports/kp/cs/kpcs315_rpt_asForm.aspx?p_tecps_projectsumm_pk=' + txtProjectPK.text + '&p_month=' + dtProgressMonth.value;
    var url = '/reports/kp/cs/rpt_kpcs315m.aspx?p_tecps_projectsumm_pk=' + txtProjectPK.text + '&p_month=' + dtProgressMonth.value + '&Subcontract_Pk=' + txtSubctpk.text + '&Project_Cd=' + txtProjectCode.text + '&Project_Nm=' + txtProjectName.text + '&p_month1=' + escape(dtProgressMonth.text);
	
	    System.OpenTargetPage( System.RootURL+url);
}

//---------------------------------------------------------------------------------------------
</script>

<body>
 <!-------------------------------------------------------------------------------------->
   <gw:data id="dso_search" onreceive="onDataReceive(this)"> 
		<xml> 
			<dso id="1" type="grid"    function="ec111.SP_SEL_KPCS315"    > 
				<input bind="gridMST">                    
					<input bind="txtProjectPK" /> 
                    <input bind="dtProgressMonth" /> 
                     <input bind="txtSubctpk" /> 
				</input> 
				<output bind="gridMST" /> 
			</dso> 
		</xml> 
	</gw:data>
 <!-------------------------------------------------------------------------------------->

    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr style="height: 4%">
            <td>
                <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 10%">
                                        <a title="Click here to select Project" onclick="OnPopUp('project')" href="#tips"
                                            style="text-decoration: none; color: #0000ff"><b>Project</b></a>
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtProjectCode" styles='width:100%' />
                                    </td>
                                    <td style="width: 50%"><gw:textbox id="txtProjectName" styles='width:100%' /></td>
                                    <td style="width: 3%"><gw:imgbtn id="bt_ResetUpper" img="reset" alt="Reset" onclick="OnReset('1')" /></td>
									<td style="width: 10%; white-space: nowrap"> </td>
                                    <td style="width: 5%; white-space: nowrap">Progress Month</td>
                                    <td style="width: 5%; white-space: nowrap"><gw:datebox id="dtProgressMonth" lang="1" type="month" /></td>
                                    <td style="width: 10%; white-space: nowrap"> </td>
                                   <td><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
								   <td>
									 <gw:imgbtn img="excel" alt="Print" text="Print" id="btnReport" onclick="OnPrint()" />
								  </td>
                                </tr>
								 <tr>
                                    <td style="width: 10%">
                                        <a title="Click here to select Project" onclick="OnPopUp('Subcontract')" href="#tips"
                                            style="text-decoration: none; color: #0000ff"><b>Subcontract</b></a>
                                    </td>
                                    <td style="width: 30%"><gw:textbox id="txtSubctCode" styles='width:100%' /><gw:textbox id="txtSubctpk" styles='width:100%;display:none' /></td>
                                    <td style="width: 50%" colspan="7"><gw:textbox id="txtSubctName" styles='width:100%' /></td>
                                    <td style="width: 3%"><gw:imgbtn id="bt_ResetUpper" img="reset" alt="Reset" onclick="txtSubctCode.text='';txtSubctpk.text='';txtSubctName.text=''" /></td>
									
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
		<!--0_PK|1.Work Code|2.Work Name|3.Contract No.|4.Subcontractor|5.Start date|6.Finish date|7.CCY|8.Contract amt.|9.Claim amt.|10.Advance amt.|11.Vat Amt.|12.Advance deduct|13.Retention|14.Withholding tax|15.Total deduct|16.Net payable|17.Total payable|18.Rate payable|19.Balance-->
        <tr style="height: 96%">
            <td style="background: white; width: 60%; height: 100%" id="left">
                <gw:grid id='gridMST' 
				    header='ccy|_PK|Work Code|Work Name|Contract No.|Subcontractor|Start date|Finish date|CCY|Contract amt.|Vat amt.(ctr.)|Advance amt.|Progress amt.|Claim Vat |Advance deduct|Retention|Withholding tax|Total deduct|Actual Payment(amt.)|Actual Payment(%)|Retention amt.|Retention rate(%)|Balance claim'
                    format='0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|0|1|0|1' 
                    aligns='0|0|0|0|0|0|0|0|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3' 
					defaults='||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    widths='0|0|1200|2000|2000|3200|1200|1200|800|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000|2000'
                    sorting='T' 
					styles='width:100%; height:100%' 
					oncellclick=''
                    oncelldblclick="OnPopUp('sub_d')" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtProjectPK" styles='width:100%;display:none' />
</body>
</html>
