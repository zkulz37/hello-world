<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Processing Biz Card</title>
</head>
<body>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";


var lang= "<%=Session("Lang")%>";
var iBizPK          = 0,
    iSelect         = 1,
    iApplicationNo  = 2,
    iEMPNM          = 3,
    iEMPID          = 4,
    iDepartment     = 5,
    iGroup          = 6,
    iCardType       = 7,
    iQty            = 8,
    iUnitPrice      = 9,
    iAmount         = 10,
    iRemark         = 11,
    iSubmitedDate   = 12,
    iStatus         = 13,
    iDistributeDt   = 14,
    iRemarkGA       = 15,
    iCancel         = 16,
    iApprove_level  = 17,
    iRequireDT      = 18,
    iBankNM         = 19,
    iBankAccount    = 20;
    
function BodyInit()
{  
    if (v_language!="ENG")
        System.Translate(document);          
    
    var data = "";

    data = "<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 connect by prior a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All"; 
    lstDept.SetDataText(data);
    lstDept.value = 'ALL';

    
    data = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0079' and A.code IN ('40', '140') ")%>";
    lstStatus.SetDataText(data); 
    lstStatus.value = '40';

    txtEmpPK.text = "<%=session("EMPLOYEE_PK")%>";

    txtManager_PK.text   = "<%=session("EMPLOYEE_PK")%>";
    
    <%=ESysLib.SetGridColumnComboFormat("idGrid", 13, "SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0079' ")%>;
    
    txttotal1.SetEnable(false);
    txttotal2.SetEnable(false);
    
   idBtnSearch.SetEnable(true);
      
    var con = idGrid.GetGridControl();
    con.ColFormat(iQty) = "###,###,###,###,###";
    con.ColFormat(iAmount) = "###,###,###,###,###";
    
    GetLastMonth();
	dso_approver_info.Call();
}

function GetLastMonth()
{
    sysDate = new Date();
    newDate1 = sysDate.getMonth();
    
    if (Number(newDate1) < 10) 
        newDate1="0"+ String(newDate1)
            
    newDate2 = sysDate.getDate() 
        if (Number(newDate2) < 10 )
        
    newdate2="0" +String(newDate2) 
    newDate3 = sysDate.getFullYear()

    sysDate = newDate3 + newDate1 + newDate2 ;

    dtSubFrom.SetDataText(sysDate);
}

function OnChangeDept()
{
    
}

function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'idData_sp_sel_processing_card':
            lblRecord.text = idGrid.rows -1 + " record(s)";
            var qty = 0;
            var amt = 0;
            
            for (var i = 1; i<idGrid.rows; i++)
            {
                qty = qty + parseFloat(idGrid.GetGridData(i, iQty));
                amt = amt + parseFloat(idGrid.GetGridData(i, iAmount));
            }
            
            txttotal1.text = qty.toFixed(3);
            txttotal2.text = amt.toFixed(3);                      
        break ;
		case "dso_approver_info":
			txtManagerLevel.text = txtManager_KIND.text ;
		break ;
    }
}

function onSearch()
{
    idData_sp_sel_processing_card.Call('SELECT');
}

function onSetAll(n)
{
    var con = idGrid.GetGridControl();

    for( var i = 1; i < idGrid.rows; i++ )
    {
        if (idGrid.GetGridData(i, iSelect) != '0')
        {
            switch(n)
            {
                case 1: 
                //idGrid.TextMatrix(i , iStatus) = lstStatus.GetData();
                break;

                case 2:
                    //con.TextMatrix(i , iRemark(GA)) = txtRemark.text;
                    idGrid.SetGridText(i, iRemarkGA, Trim(txtRemark.text) );
                break;
                case 3:
                    idGrid.SetGridText(i, iDistributeDt, dtDistribute.value );
                break ;
            }
        }
        idGrid.SetRowStatus(i, 16);
    }
}

function OnSelect()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var l_Chk = '', l_status = "", l_approve_level = '';
    if(lcol == iSelect )
    {
        l_Chk = idGrid.GetGridData(lrow, iSelect);
        if(l_Chk == '-1')
        {
            l_status = idGrid.GetGridData(lrow, iStatus);
            l_approve_level = idGrid.GetGridData(lrow, iApprove_level);           
        }        
    }
}
/*function onSave()
{
    idData_sp_sel_processing_card.Call('UPDATE');
}*/

function onPrint()
{
    alert('Waiting for new design for reports...');
}
function onReviewed()
{
    var i, l_Chk = '', l_status = '', n = 0 ;
    for (i = 1; i < idGrid.rows; i++)
    {
        l_Chk = idGrid.GetGridData(i, iSelect);
        if(l_Chk == '-1')
        {
            idGrid.SetGridText(i, iStatus, '140'); // Reviewed status
            n += 1;
        }
        else
        {
            idGrid.SetRowStatus(i, 0); 
        }
    }
    if(n > 0)
    {
        lstStatus.value = '140'; //Reviewed
        idData_sp_sel_processing_card.Call();
    }        
}
function OnEnterCol()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var l_status = '';
    if(lcol == iStatus)
    {
        idGrid.row = 0;
    }
    else if(lcol == iDistributeDt || lcol == iRemarkGA )
    {
        l_status = idGrid.GetGridData(lrow, iStatus);
        if(l_status == '120') // distrbuted
        {
            idGrid.row = 0 ;
        }
    }
}
</script>
<gw:data id="idData_sp_sel_processing_card" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" parameter="0,13,14,15" function="hr.sp_sel_processing_card" procedure="hr.sp_upd_processing_card" > 
            <input> 
                <input bind="lstDept" />                             
                <input bind="dtSubFrom" /> 
                <input bind="dtSubTo" />
                <input bind="lstStatus" />
                <input bind="lstSearchBy" />
                <input bind="txtSearch" />
            </input> 
            <output bind="idGrid" /> 
        </dso> 
   </xml> 
</gw:data>
<gw:data id="dso_approver_info" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>                    
                   <input bind="txtManager_PK" />
                </input> 
                <output>    
                    <output bind="txtEmployee_ID" />
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_ID" />
                    <output bind="txtManager_NM" />
                    <output bind="txtManager_KIND" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtApplication_LV" />
                    <output bind="txtPK_Manager" />
                    <output bind="txtCompany_PK" />
                    <output bind="txtTacABPLCenter_PK" />
                    <output bind="txtPLNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<table  border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
    <tr>
        <td width="100%">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                <tr align="top" style="height:5%">
                    <td width="15%" align="right">Department</td>
                    <td width="15%" align="left"><gw:list id="lstDept" styles="width:100%" onChange=""></gw:list> </td>
                    <td width="10%" align="right">Submited Date&nbsp;</td>
                    <td width="10%" align="left"><gw:datebox id="dtSubFrom" maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
                    <td width="1%">~</td>
                    <td width="10%" colspan="2" align="left"><gw:datebox id="dtSubTo"   maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>        
                    <td width="8%" align="right">Employee&nbsp;</td>
                    <td width="10%"><gw:list  id="lstSearchBy" styles="width:100%;" >
                        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data>
                        </gw:list>
                    </td> 
                    <td width="12%"><gw:textbox id="txtSearch" styles="width:100%;" /></td>
                    <td width="9%" colspan="2" >
                        <table width="100%" border="0">
                            <tr>
                                <td width="30%" style="width:100%;border:0"><gw:icon id="idBtnSearch"  styles='width:100%' img="in"  text="Search" onclick="onSearch()"/>
                                <td width="30%" style="width:100%;border:0"><gw:icon id="idBtnReviewer"   styles='width:100%' img="in"  text="Reviewed"   onclick="onReviewed()"/></td>                                
                                <td width="40%" style="width:100%;border:0"><gw:imgBtn id="idBtnPrint"   styles='width:100%' img="excel"  alt="Print"  onclick="onPrint()"/></td>                                                            
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height:5%">                    
                    <td width="15%" align="right">Distributed Date&nbsp;</td>
                    <td width="15%"><gw:datebox id="dtDistribute" lang="1" style="width:100%" /></td> 
                    <td width="11%" colspan="3" align=left>&nbsp;<gw:icon id="btnSetDistributeDT" img="in"  text="Set All" onclick="onSetAll(3)" /></td>
                    <td width="6%" colspan="2" align="right"></td>
                    <td width="13%" align="left"></td>
                    <td style="width:15%" colspan="2"> </td>
                    <td width="10%" align="right"></td>
                    <td width="15%" align="left"></td>
                </tr>                
                <tr style="height:5%" >
                    <td width="15%" align="right">Remark&nbsp;</td>
                    <td width="56%" colspan="7"><gw:textbox  id="txtRemark"   styles="width:100%;" /></td>
                    <td style="width:3%" ><gw:icon id="idBtnRe"   styles='width:5%' img="in"  text="Set All"  onclick="onSetAll(2)"/></td>
                    <td width="12%" align="right"></td>
                    <td style="width:11%" align="left" ></td>                    
                    <td style="width:3%"></td>
                </tr>
                <tr style="height:5%">
                    <td width="10%" >
                        <a style="font-size:12px"><b>Application List &nbsp;</b></a>
                    </td>
                    <td width="90%" align="right" colspan="11"><a style="color:Blue"><gw:label id="lblRecord" text="">record(s)</gw:label></a></td>
                </tr>
                <tr style="height:75%">
                    <td width="100%" colspan="12">
                        <gw:grid   
                            id="idGrid"  
                            header="_PK||Application No|EMP ID|EMP Name|Department|Group|Card Type|Qty|Unit Price|Amount|_Description|Submited Date|Status|Distributed Date|Remark|_Cancel|_approve_level|Required Date|Bank Name|Account"
                            format="0|3|0|0|0|0|0|0|0|1|0|0|0|0|4|0|0|0|4|0|0"
                            aligns="0|0|0|0|0|0|0|0|3|0|3|0|0|0|1|0|0|0|1|0|0"
                            defaults="|||||||||||||||||||||"
                            editcol="0|1|0|0|0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|0"  
                            widths="0|600|1500|1500|2500|2000|2000|2500|1500|1500|1500|0|2000|1500|1500|1500|0|0|1500|1500|1500"
                            styles="width:100%; height:100%" 
                            acceptNullDate="T"
                            oncellclick=""
                            onafteredit="OnSelect()"
                            onentercell="OnEnterCol()"
                            sorting="T"/>    
                    </td>
                </tr>
                <tr style="height:5%">
                    <td width="100%" colspan="12" align="right" >
                        <table width="100%" border="0" style="height:100%" >
                            <tr>
                                <td align=right width="80%"> 
                                    Total &nbsp;
                                </td>
                                <td align=left width="10%"> &nbsp;
                                    <gw:textbox id="txttotal1"  text="" type="number" format="###,###.###" 	styles='width:100%;' csstype="mandatory"  onenterkey="" />
                                </td>
                                <td align=left width="10%"> &nbsp;
                                    <gw:textbox id="txttotal2"  text="" type="number" format="###,###.###" 	styles='width:100%;' csstype="mandatory"  onenterkey="" />
                                </td>
                            </tr>
                        </table>
                    </td>                    
                </tr>
            </table>
        </td>
    </tr>
</table>    
    <gw:textbox id="txtEmpPK"        styles="display:none" /> 
    <gw:textbox id="txtManagerLevel" styles="display:none" /> 
    <gw:textbox id="txtManager_PK"   styles="display:none" /> 
    <gw:list id="lstStatus" value="ALL" maxlen = "100" styles='width:100%;display:none'></gw:list>
	<gw:textbox id="txtEmployee_ID" styles="display:none" /> 
	<gw:textbox id="txtEmployee_NM" styles="display:none" /> 
	<gw:textbox id="txtManager_ID" styles="display:none" /> 
	<gw:textbox id="txtManager_NM" styles="display:none" /> 
	<gw:textbox id="txtManager_KIND" styles="display:none" /> 
	<gw:textbox id="txtManager_DEPT" styles="display:none" /> 
	<gw:textbox id="txtApplication_LV" styles="display:none" /> 
	<gw:textbox id="txtPK_Manager" styles="display:none" /> 
	<gw:textbox id="txtCompany_PK" styles="display:none" /> 
	<gw:textbox id="txtTacABPLCenter_PK" styles="display:none" /> 
	<gw:textbox id="txtPLNM" styles="display:none" /> 
</html>
