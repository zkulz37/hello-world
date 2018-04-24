<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Processing ID Card</title>
</head>

<script>
//---------------
 var    user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var    user_name = "<%=Session("USER_NAME")%>"  ;
 var    dept_pk = "<%=Session("DEPT_PK")%>"  ;
 var    iChk                = 0,
        iPk                 = 1,
        iapplication_no     = 2,
        ithr_emp_pk         = 3,
        iemp_id             = 4,
        ifull_name          = 5,
        idept_pk            = 6,
        idept_nm            = 7,
        ithr_group_pk       = 8,
        igroup_nm           = 9,
        iapp_type           = 10,
        ireason             = 11,
        iamount             = 12,
        icard_type          = 13,
        iRemaining          = 14,
        iTotalBudget        = 15,        
        isubmit_time        = 16,
        istatus             = 17,
        iremark             = 18;
        iprovide            = 19;
//--------------------------------------------------------------
 function OnToggle() {
//    var left  = document.all("left");    
//    var right = document.all("right");   
//    var imgArrow = document.all("imgArrow");   
//    
//    if(imgArrow.status == "expand")
//    {
//        left.style.display="none";       
//        imgArrow.status = "collapse";
//        right.style.width="100%";
//        imgArrow.src = "../../../system/images/next_orange.gif";
//    }
//    else
//    {
//        left.style.display="";
//        imgArrow.status = "expand";
//        right.style.width="80%";
//        imgArrow.src = "../../../system/images/prev_orange.gif";
//    }
 }
 		
//------------------------------------------------------------------------	        
function BodyInit()
{  
    BindingData();
    System.Translate(document);
}
//---------------------------------------------------------------------
function BindingData()
{
// submitted date
    var l_today = dtSubmitTo.value;
    var l_year = l_today.substring(0, 4);
    dtSubmitFr.value = l_year + '0101';  
// department
  var ls_data     = "<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org where del_if = 0 ")%>|ALL|All";  
    lstDept.SetDataText(ls_data); 
    lstDept.value = dept_pk;   
    lstGroup.value = 'ALL';      
// Status    
    ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0089' and A.code not in ('1') ")%>";
    lstStatus.SetDataText(ls_data);
    lstStatus.value = '2';
// combo box of grid
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0091' order by code_nm " ) %> ";       
    idGrid.SetComboFormat(10, ls_data);
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0089' " ) %> ";       
    idGrid.SetComboFormat(17, ls_data);    
    
    idGrid.GetGridControl().FrozenCols =7;
    idGrid.GetGridControl().ScrollTrack=true;        
// status of buttons    
    btnOrder.SetEnable(false);
    btnDeliver.SetEnable(false);
    btnDistribute.SetEnable(false);
    btnSave.SetEnable(false);
    btnPrepared.SetEnable(false);
}
//---------------------------------------------------------------
function OnShowGroup()
{
    datGroupData.Call();    
}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    var i ;
    var l_status ;
    switch(iObj.id)
    {
        case 'datGroupData':                
            lstGroup.SetDataText(txtGroupData.text + '|ALL|All');
            lstGroup.value = 'ALL';
        break ;
        case 'thr_id_card_mst':
            btnOrder.SetEnable(false);
            btnDeliver.SetEnable(false);
            btnDistribute.SetEnable(false);
            btnSave.SetEnable(false);            
            /*for( i =1; i < idGrid.rows ; i++)
            {
                l_status = idGrid.GetGridData(i, istatus);
                if(l_status == '6')
                {
                    idGrid.SetCellBgColor(i, 0, i, idGrid.cols - 1, 0xC9C299);
                }
            }*/
            //format currency
            var ctrl = idGrid.GetGridControl();
            ctrl.ColFormat(iamount)          = "###,###,###,###";  
            ctrl.ColFormat(iRemaining)       = "###,###,###,###";  
            ctrl.ColFormat(iTotalBudget)     = "###,###,###,###";  
        break ;
    }   
}
//---------------------------------------------------------------
function OnSearch()
{
    thr_id_card_mst.Call('SELECT');
}
//---------------------------------------------------------------
function OnSetAllStatus()
{
    var i ;
    for(i = 1; i < idGrid.rows ; i++)
    {
        idGrid.SetGridText(i, istatus, lstStatus.value);
    }
}
//---------------------------------------------------------------
function OnSetAllRemark()
{
    var i ;
    for(i = 1; i < idGrid.rows ; i++)
    {
        idGrid.SetGridText(i, iremark, txtRemark.text);
    }
}
function OnSetAllProvideDate()
{
    var i ;
    var n=0;
    for(i = 1; i < idGrid.rows ; i++)
    {
        if (idGrid.GetGridData(i,0)=="-1")
            n=n+1;
    }
    if (n==0)
    {
        alert("Plese choose row to set grid!");
        return;
    }
    
    for(i = 1; i < idGrid.rows ; i++)
    {
        var submit_dt;
        var yyyy,mm,dd,dt, sDT;
        submit_dt=new Date(idGrid.GetGridData(i,16));
        dt=dtProvideDate.GetData();
        
        yyyy=dt.substr(0,4);
        mm=dt.substr(4,2);
        dd=dt.substr(6,2);
        sDT=new Date(yyyy,mm-1,dd);  
        
        
        if (idGrid.GetGridData(i,0)=="-1")
        {
            if (sDT<=submit_dt)
            {
                alert("Provide date must greater than submited date at row " + i );
                return;
            }
            idGrid.SetGridText(i, iprovide,dtProvideDate.GetData());
         }
    }
}
//---------------------------------------------------------------
/*function OnCheckAll()
{
    var i;
    if(chkAll.value == 'T')
    {
        for ( i = 1; i < idGrid.rows; i++)
        {
            idGrid.SetGridText(i, iChk, '-1');    
        }
    }
    else
    {
        for ( i = 1; i < idGrid.rows; i++)
        {
            idGrid.SetGridText(i, iChk, '0');    
        }            
    }        
}*/
//---------------------------------------------------------------
function OnSave()
{   
    var i;
    for(i = 1; i < idGrid.rows; i++)
    {
        if(idGrid.GetGridData(i, iChk ) == '0')
        {
            idGrid.SetRowStatus(i, 0);            
        }
        else{
            if(idGrid.GetGridData(i, 18 )==""){
                alert("Please input request information at row "+ i);
                return;
            }
            idGrid.SetGridText(i, 17, '7');
        }
    }
    lstStatus.value="7";
    thr_id_card_mst.Call();
}
//---------------------------------------------------------------
function OnEnterData()
{
    var lrow = event.row ;
    var lcol = event.col ;
    if(lcol == istatus || lcol == iapp_type)
    {
        idGrid.row = 0;
    }
}
//---------------------------------------------------------------
function ButtonStatus()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var lsCheck , l_status;
    if(lcol == iChk)
    {
        lsCheck = idGrid.GetGridData(lrow, iChk);        
        if(lsCheck == '-1')
        {
            l_status = idGrid.GetGridData(lrow, istatus);
            //Ordered
            if(l_status == '8')
            {
                btnOrder.SetEnable(true);
                btnSave.SetEnable(true);
            }
            else
            {
                btnOrder.SetEnable(false);
                btnSave.SetEnable(false);
            }
            // Delivered
            if(l_status == '4')
            {
                btnDeliver.SetEnable(true);
            }
            else
            {
                btnDeliver.SetEnable(false);
            }
            // Distributed
            if(l_status == '8' || l_status == '5' )
            {
                btnDistribute.SetEnable(true);
            }
            else
            {
                btnDistribute.SetEnable(false);
            }   
            if (l_status=='2')
            {                        
                btnPrepared.SetEnable(true);
            }                         
            else 
            {               
                btnPrepared.SetEnable(false);
            }        
        }
        else
        {
            btnOrder.SetEnable(false);
            btnDeliver.SetEnable(false);
            btnDistribute.SetEnable(false);
            btnSave.SetEnable(false);
            btnPrepared.SetEnable(false);
        }
    }
}
//---------------------------------------------------------------
function OnOrdered()
{   
    var i, n =0;
    var ls_Chk ;
    var l_status = '';
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            l_status = idGrid.GetGridData(i,istatus);
            if(l_status != '8')
            {
                alert('Please choose the Submitted status to change to Ordered status at row ' + i);
                return ;
            }
        }
    }    
    lstStatus.value = '4';    
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            idGrid.SetGridText(i, istatus, '4');
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);                    
    }
    if( n > 0)
        thr_id_card_mst.Call();
}
//---------------------------------------------------------------
function OnPrepared()
{   
    var i, n =0;
    var ls_Chk ;
    var l_status = '';
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            l_status = idGrid.GetGridData(i, istatus);
            if(l_status != '2')
            {
                alert('Please choose the Submitted status to change to Ordered status at row ' + i);
                return ;
            }
        }
    }    
    lstStatus.value = '8';    
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            idGrid.SetGridText(i, istatus, '8');
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);                    
    }
    if( n > 0)
        thr_id_card_mst.Call();
}

function OnDelivered()
{   
    var i, n =0;
    var ls_Chk ;
    var l_status = '';
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            l_status = idGrid.GetGridData(i, istatus);
            if(l_status != '4')
            {
                alert('Please choose the Ordered status to change to Delivered status at row ' + i);
                return ;
            }
        }
    }    
    lstStatus.value = '5';    
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            idGrid.SetGridText(i, istatus, '5');
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);                    
    }
    if( n > 0)
        thr_id_card_mst.Call();
}
//---------------------------------------------------------------
function OnDistributed()
{   
    var i, n =0;
    var ls_Chk ;
    var l_status = '';
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            l_status = idGrid.GetGridData(i, istatus);
            if(l_status != '5' && l_status != '2')
            {
                alert('Please choose the Submitted or Delivered to change to Distributed status at row ' + i);
                return ;
            }
        }
    }    
    lstStatus.value = '6';    
    for(i = 1; i < idGrid.rows; i++)
    {
        ls_Chk = idGrid.GetGridData(i, iChk);
        if(ls_Chk == '-1')
        {
            idGrid.SetGridText(i, istatus, '6');
            n += 1;
        }
        else
            idGrid.SetRowStatus(i, 0);                    
    }
    if( n > 0)
        thr_id_card_mst.Call();
}
//---------------------------------------------------------------
function checkdate(date1,date2)
{    
    var yyyy_1,mm_l,dd_l;
    var yyyy_2, mm_2, dd_2;   
    var dt_1, dt_2;   
    
    yyyy_1 =date1.substr(0,4);
    mm_l   =date1.substr(4,2);
    dd_l   =date1.substr(6,2);
    
    dt_1 = new Date(yyyy_1,mm_l-1, dd_l);
    
    yyyy_2 =date2.substr(0,4);
    mm_2   =date2.substr(4,2);
    dd_2   =date2.substr(6,2);
    
    dt_2 = new Date(yyyy_2,mm_2-1, dd_2);                                        
    
    if (dt_2>=dt_1)
        { 
            return false;
        }
    return true;
}
</script>
<body>
<!------------------------------------------------------------------------>
<gw:data id="thr_id_card_mst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_id_card_processing" parameter="1,17,18,19" procedure="hr.sp_upd_id_card_processing" > 
            <input bind="idGrid" > 
                 <input bind="dtSubmitFr" />
                 <input bind="dtSubmitTo" /> 
                 <input bind="lstDept" /> 
                 <input bind="lstGroup" />
                 <input bind="lstSearchBy" />
                 <input bind="txtSearchValue" />
                 <input bind="lstStatus" />                 
             </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="height:100%" >
    <tr style="height:12%">
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%" >
                <tr>
                    <td style="width:15%"></td>
                    <td style="width:15%"></td>
                    <td style="width:5%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:10%"></td>
                    <td style="width:35%"></td>
                </tr>
                <tr>
                    <td align="right">Submitted date&nbsp</td>
                    <td align="left"><gw:datebox id="dtSubmitFr" lang="1" styles="width:100%" /></td>
                    <td align="left">~</td>
                    <td align="right"><gw:datebox id="dtSubmitTo" lang="1" styles="width:100%" /></td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                </tr>                
                <tr>
                    <td align="right">Department&nbsp</td>
                    <td align="left"><gw:list id="lstDept" styles="width:100%" onchange="OnShowGroup()" /></td>
                    <td align="right" colspan="1" >Group&nbsp</td>
                    <td align="left">
                        <gw:list id="lstGroup" maxlen = "100" styles="width:100%" >                        
                            <data>DATA|ALL|All</data>
                        </gw:list>
                    </td>
                    <td align="right">Employee&nbsp</td>
                    <td align="left"><gw:list id="lstSearchBy" text="" styles="width:100%" value="1" >
                        <data>
                            DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                        </data>
                        </gw:list>
                    </td>
                    <td align="left"><gw:textbox id="txtSearchValue" text="" styles="width:100%" /></td>                    
                </tr>
                <tr>
                    <td align="right">Status&nbsp</td>
                    <td align="left"><gw:list id="lstStatus" styles="width:100%" /></td>
                    <td align="right"><gw:icon id="btnSetAll" text="Set All" onclick="OnSetAllStatus()" /></td>
                    <td align="right"></td>
                    <td align="right">Provide date</td>
                    <td align="left"><gw:datebox id="dtProvideDate" lang="1" styles="width:100%" nullaccept /></td>
                    <td align="left"><gw:icon id="btnSetAll_3" text="Set All" onclick="OnSetAllProvideDate()"/></td>
                </tr>
                <tr>
                    <td align="right">Remark&nbsp</td>
                    <td align="left" colspan="5"><gw:textbox id="txtRemark" styles="width:100%" /></td>                    
                    <td align="left"><gw:icon id="btnSetAll_2" text="Set All" onclick="OnSetAllRemark()" /></td>
                </tr>
            </table>
    </tr>
    <tr style="height:4%">
        <td style="border-bottom:none; border-left:none; border-right:none; ">
            <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                <tr>
                    <td style="width:10%"></td>
                    <td style="width:5%"></td>
                    <td style="width:65%"></td>
                    <td style="width:3%"></td>
                    <td style="width:4%"></td>
                    <td style="width:4%"></td>
                    <td style="width:4%"></td>
                    <td style="width:5%"></td>
                </tr>
                <tr>
                    <td align="right"></td>
                    <td align="left"></td>
                    <td colspan="1"></td>
                    <td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
                    <td align="right"><gw:icon id="btnPrepared" text="Prepared" onclick="OnPrepared()" /></td>
                    <td align="right"><gw:icon id="btnOrder" text="Ordered" onclick="OnOrdered()" /></td>
                    <td align="right"><gw:icon id="btnDeliver" text="Delivered" onclick="OnDelivered()" /></td>
                    <td align="right"><gw:icon id="btnDistribute" text="Distributed" onclick="OnDistributed()" /></td>                    
                    <td align="right"><gw:icon id="btnSave" text="Request more info" onclick="OnSave()" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="height:84%">
        <td>
            <gw:grid id="idGrid" 
                header="|_thr_id_card_pk|Application No|_thr_emp_pk|EMP ID|EMP Name|_dept_pk|Department|_thr_group_pk|Group|Type|Reason|Amount|Card Type|Remaining|Total Budget|Submit Time|Status|Response|Provide Date"
                format="3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4" 
                aligns="1|0|0|0|0|0|0|0|0|0|0|0|3|0|3|3|0|0|0|0" 
                defaults="|||||||||||||||||||"
                editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0" 
                widths="500|0|1500|0|1500|2500|0|1500|0|1500|1500|2000|1500|1500|1500|1500|1900|1500|2000|1000"
                sorting="T" 
                acceptNullDate="T"
                onentercell="OnEnterData()"
                onafteredit="ButtonStatus()"
                styles="width:100%; height:100%" 
            />        
        </td>
    </tr > 
</table>
<gw:textbox id="txtGroupData" styles="display: none; " />
</body>
</html>
