<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Change Budget Period</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
var G1_PK                   =0,
    G1_WORKDATE             =1,
    G1_PERFORMPERDFR        =2,
    G1_PERFORMPERDTO        =3,
    G1_CHANGEREASON         =4,
    G1_PROJECTCODE          =5,
    G1_STATUS               =6;
    
//==========================================================================    
function BodyInit()
{
      System.Translate(document);
      //SetHeader();
      //BindingDataList();
      
}  
//==========================================================================
function BindingDataList()
{
        <%=ESysLib.SetGridColumnComboFormat("grdDetail", 4,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0009' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;
        <%=ESysLib.SetGridColumnComboFormat("grdDetail", 3,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
        <%=ESysLib.SetGridColumnComboFormat("grdDetail", 5,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0010' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>; 
        <%=ESysLib.SetGridColumnComboFormat("grdDetail", 8,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0011' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
		<%=ESysLib.SetGridColumnComboFormat("grdDetail", 9,"SELECT D.CODE, D.CODE_NM FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.PK = D.TAC_COMMCODE_MASTER_PK AND M.ID = 'TPS0017' AND M.DEL_IF = 0 AND D.DEL_IF = 0 ORDER BY ORD")%>;  
} 
//==========================================================================
function SetHeader()
{
      var fg=grdDetail.GetGridControl();
      fg.FixedRows = 1
      fg.MergeCells = 5	
      fg.MergeRow(0) = true
      fg.Cell(0, 0, 13, 0, 14)="Person in Charge";
}
//==========================================================================
function OnSearch()
{
    dso_kpbm00070.Call("SELECT");
}
//==========================================================================
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
    dso_kpbm00070.Call();
}
//==========================================================================
function OnDelete()
{
    if ( grdDetail.row > 0 )
    {
        if(confirm("Are you sure to delete !!!"))
        {
            if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == "" ) 
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
//==========================================================================
function OnUnDelete() 
{
    grdDetail.UnDeleteRow();
}
//==========================================================================
function OnConfirm()
{
    if ( grdDetail.row > 0 )
    {
        var control = grdDetail.GetGridControl();
        for(i=0;i<control.SelectedRows;i++)
        {
            grdDetail.SetGridText( control.SelectedRow(i), G1_STATUS,'Y' ) ;
        }  
        OnSave();
    }    
}
</script>

<body>
    <!------------------------------------------------------------------------------------------------------------------>
    <!------------------------------------------------------------------------------------------------------------------>
    <table cellpadding="1" cellspacing="1" style="width: 100%; height: 120%" border="1">
        <tr style="height: 1%">
            <td style="width: 100%">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="right" width="6%">
                            <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
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
                        <td>
                            <gw:imgbtn id="ibtnUpdte" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnpdte" img="new" alt="New" onclick="OnNew()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtnUpdate" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                        <td>
                            <gw:imgbtn id="ibtUpdate" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>
                       
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 30%">
            <td>
                <gw:grid id="Grid_Detail" header="Outside Work Code|Outside Work Name|Currency|Domestic / Foreign Equipment Description|Service Description|Work|Expected Order Date (MM/YYYY)|Contract Method|Tax Exemption Rate (%)|Subcontract Revision No|Status|Person In Charger Code|Person In Charger Name|_emp_pk|_pro_pk|_pk"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|1|1|1|0|1|1|3|0|1|0|0|0|0|0"
                    defaults="|||||||||||||||" editcol="1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0" widths="2000|3000|1000|4000|3000|2000|3000|2000|2500|2500|1500|2200|2500|0|0|0"
                    styles="width:100%; height:100%" sorting="T" oncelldblclick="OnPopUp('Employee')" />
            </td>
        </tr>
        <tr style="height: 40%">
            <td>
                <gw:grid id="Grid_Detail1" header="Outside Work Code|Outside Work Name|Currency|Domestic / Foreign Equipment Description|Service Description|Work|Expected Order Date (MM/YYYY)|Contract Method|Tax Exemption Rate (%)|Subcontract Revision No|Status|Person In Charger Code|Person In Charger Name|_emp_pk|_pro_pk|_pk"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|1|1|1|0|1|1|3|0|1|0|0|0|0|0"
                    defaults="|||||||||||||||" editcol="1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0" widths="2000|3000|1000|4000|3000|2000|3000|2000|2500|2500|1500|2200|2500|0|0|0"
                    styles="width:100%; height:100%" sorting="T" oncelldblclick="OnPopUp('Employee')" />
            </td>
        </tr>
        <tr style="height: 50%">
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
</html>
