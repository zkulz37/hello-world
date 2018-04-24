<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Business Card List</title>
</head>
<body>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";
var irow=0;

var iChk                = 0,
    iPK                 = 1,
    iApplicationNo      = 2,
    iEmp_ID             = 3,
    iEmp_NM             = 4,
    iDept               = 5,
    iSubmitedTime       = 6,
    iCardType           = 7,
    iQuantity           = 8,
    iAmount             = 9,
    iRemark             = 10,
    iStatus             = 11,
    iModifyDate         = 12,
    iRemarkGA           = 13,
    iEmppk              = 14,
    iCancel             = 15,
    iManagerRes         = 16,
    iGAResponse         = 17,
    iStatus_Code        = 18,
    iApproveLevel       = 19,
    iApprove_NM         = 20;

 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;

function BodyInit()
{  
   if (v_language!="ENG")
        System.Translate(document);          

   txt_user_id.text="<%=session("USER_ID")%>";
   txt_user_pk.text="<%=session("USER_PK")%>"; 
    txtEmployeePK.text = user_pk ;
   
   txttotal1.SetEnable(false);
   txttotal2.SetEnable(false);
   
   SetColumnFormat(); 
   GetLastMonth();
   BindingDataList();
   //OnSearch();
}

function BindingDataList()
{
    // status
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0079' and A.code <> '20' ")%>|ALL|All";
    lstStatus.SetDataText(ls_data); 
    lstStatus.value = 'ALL'; 
    txtValue.text = user_name ;                    
    ibtnReplicate.SetEnable(false);
    ibtnDelete.SetEnable(false);
    ibtnCancel.SetEnable(false);
    
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

    sysDate = newDate3 + newDate1 + newDate2

    dtLastModDt_From.SetDataText(sysDate);
}

function SetColumnFormat()
{   
    var con = idGrid.GetGridControl();
    con.ColFormat(iAmount) = "###,###,###,###,###"; 
}

function OnSearch()
{
    idData_sel_business_app_list.Call("SELECT")
}

function OnAddNew()
{
    System.Menu.NewWindow( "form/ch/mb/chmb00010.aspx" , "Business Card Entry", "Business Card Entry", "Business Card Entry" );
}

function GetDataFromGrid()
{
    var ctrl= idGrid.GetGridControl();   
    //txtResponse.SetDataText(idGrid.GetGridData(idGrid.row,7)); 
    txtReasonCancel.SetDataText(idGrid.GetGridData(idGrid.row, iCancel));    
}

function OnReplicate()
{ 
    if (idGrid.row <= 0)
    {
        alert('Please select one row.');
        return;
    }
    var l_status = '';
    l_status = idGrid.GetGridData(idGrid.row, iStatus_Code) ;  
    if(l_status == '10')
    {
        txt_bus_card_pk.text = idGrid.GetGridData(idGrid.row, iPK);    
        System.Menu.NewWindow( "form/ch/mb/chmb00010.aspx?thr_business_card_pk=" + txt_bus_card_pk.text, "Business Card Entry", "Business Card Entry", "Business Card Entry" );
    }
    else
    {
        alert('Only modify business card in Save Status ...');
    }            
}

function OnDelete()
{
    var lChk = '', l_status = '', n = 0 ;
    if (idGrid.row <= 0)
    {
        alert('Please select one row.');
        return;
    }
    for(i = 1; i < idGrid.rows; i++)
    {    
        lChk = idGrid.GetGridData(i, iChk);
        if(lChk =='-1')
        {
            l_status = idGrid.GetGridData(i, iStatus_Code);
            if(l_status == '10')        
            {                
                idGrid.SetRowStatus(i, 64);
                n += 1;
            }                
            else
            {
                alert('Please choose the Save status to delete at row ' + i);
                return ;
            }                                       
        }
        else
            idGrid.SetRowStatus(i, 0);        
    }   
    if(n > 0)
        idData_sel_business_app_list.Call();               
}

function OnCancel()
{   
    if (idGrid.row <= 0)
    {
        alert('Please select one row.');
        return;
    }
    var i ;
    var l_Chk = '', l_status = '', l_approve_level = '', n = 0;
    for(i = 1; i < idGrid.rows; i++)
    {
        lChk = idGrid.GetGridData(i, iChk);
        if(lChk =='-1')
        {
            l_status = idGrid.GetGridData(i, iStatus_Code);
            l_approve_level = idGrid.GetGridData(i, iApproveLevel);
            if( (l_status == '10') || (l_status=='40' && l_approve_level == '02'))                        
            {
                if(Trim(txtReasonCancel.GetData()) =='')
                {
                    alert('Please input cancelled response');
                    return ;
                }
                idGrid.SetGridText(i, iStatus_Code, '30');   
                n += 1;             
            }             
            else
            {
                alert('Please choose the Save or Approved(GA manager) to cancel at row ' + i);
                return ;
            }
        }
        else
            idGrid.SetRowStatus(i, 0);                
    } 
    if(n > 0)
        idData_sel_business_app_list.Call();      
}

function OnDataReceive(iObj)
{
    switch(iObj.id)
    {              
        case 'idData_del_business_app_list':
            idData_sel_business_app_list.Call('SELECT');
            break ;
        
        case 'idData_sel_business_app_list':                    
            lblRecord.text=idGrid.rows - 1 + " records are found!";
            var qty = 0;
            var amt = 0;
            
            for (var i = 1; i<idGrid.rows; i++)
            {
                qty = qty + parseFloat(idGrid.GetGridData(i, iQuantity));
                amt = amt + parseFloat(idGrid.GetGridData(i, iAmount));
            }
            
            txttotal1.text = qty.toFixed(3);
            txttotal2.text = amt.toFixed(3);
            ibtnReplicate.SetEnable(false);
            ibtnDelete.SetEnable(false);
            ibtnCancel.SetEnable(false);
            break;
    }
}
function OnSelect()
{
    var lrow = event.row ;
    var lcol = event.col ;
    var l_Chk = '', l_status = '', l_approve_level = '';
    if(lcol ==iChk )
    {
        l_Chk = idGrid.GetGridData(lrow, iChk)   ;        
        if(l_Chk == -1)
        {
            l_status = idGrid.GetGridData(lrow, iStatus_Code);
            l_approve_level = idGrid.GetGridData(lrow, iApproveLevel);
                ibtnReplicate.SetEnable(false);
                ibtnDelete.SetEnable(false);
                ibtnCancel.SetEnable(false);            
            
            if(l_status == '10') //save
            {
                ibtnReplicate.SetEnable(true);
                ibtnDelete.SetEnable(true);
                ibtnCancel.SetEnable(true);
            }
            else if(l_status == '40' && l_approve_level == '02')
            {
                ibtnCancel.SetEnable(true);
            }
        }
    }
}
function OnChangeMyPage()
{
    if(rdoAppli.value == '1')
        txtValue.text = user_name ;
    else
        txtValue.text = '';        
        
}

</script>
<gw:data id="idData_sel_business_app_list" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="hr.sp_sel_business_app_list" parameter="1,15,18" procedure="sp_upd_business_app_list" > 
                <input> 
                    <input bind="dtLastModDt_From" /> 
                    <input bind="dtLastModDt_To" />   
                    <input bind="lstStatus" />   
                    <input bind="lstSearchBy" />   
                    <input bind="txtValue" />
                    <input bind="rdoAppli" /> 
                    <input bind="txtEmployeePK" />   
                    <input bind="txt_user_id" />                                         
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data>

<gw:data id="idData_upd_business_app_list" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="hr.sp_upd_business_app_list"> 
                <input> 
                    <input bind="txt_bus_card_pk" /> 
                    <input bind="txtReasonCancel" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data> 

<gw:data id="idData_del_business_app_list" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="hr.sp_del_business_app_list"> 
                <input> 
                    <input bind="txt_bus_card_pk" />
                </input>
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data> 
    <table  border=1 cellpadding=0 cellspacing=0 width=100% style="height:100%">
    <tr style="height:76%">
        <td width=100% style="height:100%">
            <table border=0 cellpadding=0 cellspacing=0 width=100% style="height:100%">
                <tr style="height:5%" >
                    <td width=100% align=left>
                        <table border=0 cellpadding=0 cellspacing=0 width=100% style="height:100%">
                            <tr>
                                <td style="width:15%"></td>
                                <td style="width:10%"></td>
                                <td style="width:2%"></td>
                                <td style="width:10%"></td>
                                <td style="width:10%"></td>                                
                                <td style="width:34%"></td>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:5%"></td>
                                <td style="width:3%"></td>
                                <td style="width:5%"></td>
                                
                            </tr>
                            <tr>
                                <td align="right">Last Modified Date &nbsp;</td>
                                <td align=left ><gw:datebox id="dtLastModDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
                                <td align=center >~</td>
                                <td align=left ><gw:datebox id="dtLastModDt_To" onchange=""  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>                                
                                <td></td>
                                <td align="left" colspan="1"><gw:radio id="rdoAppli" value="1" onchange="OnChangeMyPage()" >
                                    <span value="1">My application</span>
                                    <span value="2">All application I made</span>
                                    </gw:radio>                        
                                </td>                                                            
                            </tr>
                            <tr>
                                <td align="right">Status&nbsp;</td>
                                <td align="left" colspan="2"><gw:list id="lstStatus" styles="width:100%" onchange="OnSearch()" /></td>
                                <td align="right" >Employee&nbsp;</td>
                                <td align="left" colspan="1" ><gw:list id="lstSearchBy" styles="width:100%" >
                                    <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data>
                                    </gw:list>
                                </td>
                                <td align="left" ><gw:textbox id="txtValue" text="" styles="width:100%" /></td>
                                <td align="right"><gw:imgBtn id="ibtnSearch" alt="search" img="search" text="search" onclick="OnSearch()" /></td>
                                <td align="right"><gw:imgBtn id="ibtnAddNew"    alt="Add New"        img="new"            onclick="OnAddNew()"/></td>
                                <td align="right"><gw:icon id="ibtnReplicate"    text="Modify"      img="in"  styles="width:100%" onclick="OnReplicate()" /></td>
                                <td align="right"><gw:imgBtn id="ibtnDelete"    alt="Delete"         img="delete"         onclick="OnDelete()" /></td> 
                                <td align="right"><gw:icon id="ibtnCancel"    alt="Cancel" text="Cancel" img="in"  styles="width:100%" onclick="OnCancel()" /></td>                                                                
                            </tr>
                        </table>
                    </td>                    
                </tr>
                <tr style="height:5%" >
                    <td align=center colspan=2><gw:label id="lblRecord" style="font-family:Tahoma;color:Red;size:12" text="" /></td>
                </tr>
                <tr style="height:80%" >
                    <td colspan="1"> 
                        <gw:grid   
                            id="idGrid"  
                            header="Select|_PK|Application No|EMP ID|EMP Name|Department|Submited Time|Card Type|Quantity|Amount|Remark|Status|Modify Date|Remark (GA)|_Emp pk|Cancel Reason|Manager Response|GA Manager Response|_status|_approve_level|Approve Level"
                            format="3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                            aligns="1|0|0|0|0|0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0"    
                            defaults="|||||||||||||||||||||"
                            editcol="1|1|1|0|0|0|1|1|0|0|1|0|1|1|1|0|0|0|0|0|0"  
                            widths="700|0|2000|1400|2000|2000|1500|2500|1500|1500|2500|1500|2000|2500|0|2000|2000|2000|0|0|1500"
                            acceptNullDate="T"
                            styles="width:100%; height:100%" 
                            oncellclick="GetDataFromGrid()"   
                            onafteredit="OnSelect()"
                            sorting="T"/>              
                    </td>
                </tr>  
                <tr style="height:5%">
                    <td>
                    <table border=0 cellpadding=0 cellspacing=0 width=100% style="height:100%">
                        <tr>
                            <td align=right style="width:50%">Total &nbsp;
                                <gw:textbox id="txttotal1"  text="" type="number" format="###,###.###" 	styles='width:20%;' csstype="mandatory"  onenterkey="" />
                            </td>
                            <td align=left style="" style="width:50%"> &nbsp;
                                <gw:textbox id="txttotal2"  text="" type="number" format="###,###.###" 	styles='width:20%;' csstype="mandatory"  onenterkey="" />
                            </td>
                        </tr>                            
                    </table>                        
                    </td>
                </tr>  
              </table>              
        </td>
    </tr>        
    <tr style="height:5%">
        <td><a>        
        <gw:label id="lblResoncacel" styles="width:100%;font-size:11px" text="Reason for cancellation" /></a>
        </td>
    </tr>
    <tr style="height:20%">
        <td align=center>
            <gw:textarea id="txtReasonCancel" rows="5" text=""  styles='width:100%;'/>
        </td>
    </tr>
    </table>    
    <gw:textbox id="txt_bus_card_pk" styles="display:none"/> 
    <gw:textbox id="txt_user_id" styles="display:none"/> 
    <gw:textbox id="txt_user_pk" styles="display:none"/>     
    <gw:textbox id="txtEmployeePK" styles="display:none"/>   
    <gw:textbox id="txtReturn" styles="display:none"/>   
</body>
</html>
