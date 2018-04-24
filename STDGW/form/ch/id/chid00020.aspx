<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Uppdate App Status</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

var COL_PK              = 0;
    COL_SELECT          = 1,
    COL_DEPT            = 2,
    COL_GORUP           = 3,
    COL_EMP_ID          = 4,
    COL_FULL_NAME       = 5,
    COL_POSITION        = 6,
    COL_JOIN_DT         = 7,
    COL_EDUCATION       = 8,
    COL_CURR_ADD        = 9,
    COL_TEL             = 10,
    COL_MAR_STATUS      = 11,
    COL_SUBMITED_DT     = 12,
    COL_SERVICE_TYPE    = 13,
    COL_REQ_DT          = 14,
    COL_ETD             = 15,
    COL_APP_DT          = 16,
    COL_REASON          = 17,
    COL_STATUS          = 18,
    COL_DORMITORY       = 19,
    COL_DORMITORY_TYPE  = 20,
    COL_UNIT_COST       = 21,
    COL_ALLOCATED_DT    = 22,
    COL_MOVE_IN_DT      = 23,
    COL_MOVE_OUT_DT     = 24,
    COL_GA_RESPONSE     = 25,
    COL_REMARK_GA       = 26,
    COL_CANCEL_REASON   = 27,
    COL_USER_PK         = 28,

function BodyInit()
{
    idGrid.GetGridControl().FrozenCols = COL_POSITION;
    idGrid.GetGridControl().ScrollTrack=true;          
    BindingDataList();
    tr_bottom.style.display="none";   
    tr_Response.style.display="none";   
    tr_top.style.height="95%";
    
    SetStatusOnButton();
    
    if (v_language!="ENG")
        System.Translate(document);     
}
function AddDate(strDate,intDay)
{	
	var strYear;
	var strMonth;
	var strDay;
	var strFullDate;
	strYear=strDate.substr(0,4);
	strMonth=strDate.substr(4,2);
	strDay=strDate.substr(6,2);
	var oDate = new Date(strYear,strMonth-1, strDay);//20060203
	
	
	oDate.setDate(oDate.getDate()+intDay);	
	strYear=oDate.getYear();
	strMonth=oDate.getMonth()+1;
	strDay =oDate.getDate();
	
	strFullDate=strYear.toString()+String(strMonth<10?'0'+strMonth:strMonth) +String(strDay<10?'0'+strDay:strDay);
	return strFullDate;
	
}
function BindingDataList()
{    
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 18 , "select code,CODE_NM from vhr_hr_code where id='HR0072' and code not in ('50','80') order by code") %>;            
     SetColumnFormat();
     var l_today = dtRequiredDt_To.value;
     var l_pre_month ;
     l_pre_month=AddDate(l_today,-30)
     dtRequiredDt_From.value = l_pre_month; 
     
     var l_today1 = dtSubmitDt_To.value;
     var l_pre_month1 ;
     l_pre_month1=AddDate(l_today,-30)
     dtSubmitDt_From.value = l_pre_month; 
}

function OnToggle()
 {
    var bottom  = document.all("tr_bottom");    
    var top = document.all("tr_top");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        bottom.style.display="none";       
        imgArrow.status = "collapse";
        bottom.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        bottom.style.display="";
        imgArrow.status = "expand";
        bottom.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
function SetColumnFormat(){   
    var ctrl1 = idGrid.GetGridControl();
    ctrl1.ColFormat(20) = "###,###R";     
}
function SetStatusOnButton()
{
    var v_status;
    if (lstStatus.GetData()=='10')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(1);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(0);    
        ibtnReject.SetEnable(1); 
        ibtnRequest.SetEnable(1);   
        
        dtAllocatedDt.SetEnable(1);   
        dtMoveIn_Dt.SetEnable(0); 
        dtMoveIn_Dt.text = "";
        dtMoveOut_Dt.SetEnable(0); 
        dtMoveOut_Dt.text = "";
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(1); 
        txtResponse.SetEnable(1);
    }
    else if (lstStatus.GetData()=='20')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(1);
        ibtnMove_out.SetEnable(0); 
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0); 
        
        dtAllocatedDt.SetEnable(0);   
        dtAllocatedDt.text = "";
        dtMoveIn_Dt.SetEnable(1); 
        dtMoveOut_Dt.SetEnable(0); 
        dtMoveOut_Dt.text = "";        
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(0);
        txtResponse.SetEnable(0);                        
    }
    else if (lstStatus.GetData()=='30')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(1);    
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0); 
        
        dtAllocatedDt.SetEnable(0);   
        dtMoveIn_Dt.SetEnable(0);
        dtMoveOut_Dt.SetEnable(1);
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(0);
        txtResponse.SetEnable(0);       
    }
    else if (lstStatus.GetData()=='40')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(0);     
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0); 
        
        dtAllocatedDt.SetEnable(0);   
        dtAllocatedDt.text = "";
        dtMoveIn_Dt.SetEnable(0); 
        dtMoveIn_Dt.text = "";
        dtMoveOut_Dt.SetEnable(0); 
        dtMoveOut_Dt.text = "";        
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(0);
        txtResponse.SetEnable(0);         
    }        
    else if (lstStatus.GetData()=='60')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(0); 
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0);  
        
        dtAllocatedDt.SetEnable(0);   
        dtAllocatedDt.text = "";
        dtMoveIn_Dt.SetEnable(0); 
        dtMoveIn_Dt.text = "";
        dtMoveOut_Dt.SetEnable(0);          
        dtMoveOut_Dt.text = "";
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(1);
        txtResponse.SetEnable(1);          
    }        
    else if (lstStatus.GetData()=='70')
    {
        ibtnETD.SetEnable(0);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(0); 
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0); 
        
        dtAllocatedDt.SetEnable(0);   
        dtAllocatedDt.text = "";
        dtMoveIn_Dt.SetEnable(0); 
        dtMoveIn_Dt.text = "";
        dtMoveOut_Dt.SetEnable(0);          
        dtMoveOut_Dt.text = "";
        dtETD.SetEnable(0);
        dtETD.text = "";
        
        txtReason.SetEnable(0);
        txtResponse.SetEnable(1);            
    }         
    else if (lstStatus.GetData()=='90')
    {
        ibtnETD.SetEnable(1);
        ibtnAllocate.SetEnable(0);
        ibtnMove_in.SetEnable(0);
        ibtnMove_out.SetEnable(0); 
        ibtnReject.SetEnable(0); 
        ibtnRequest.SetEnable(0); 
        
        dtAllocatedDt.SetEnable(0);
        dtAllocatedDt.text = "";
        dtMoveIn_Dt.SetEnable(0); 
        dtMoveIn_Dt.text = "";
        dtMoveOut_Dt.SetEnable(0);
        dtMoveOut_Dt.text = "";
        dtETD.SetEnable(1);
        
        txtReason.SetEnable(0);
        txtResponse.SetEnable(0);
    }
}

function onChangeText(obj)
{
    switch (obj)
    {
        case 0:
              idGrid.SetGridText(idGrid.row, COL_REASON, txtReason.GetData());
              break;
        case 1:
              idGrid.SetGridText(idGrid.row, COL_REMARK_GA, txtResponse.GetData());
              break;
    }
}
function onClickToGrid()
{     
    if  ((event.col) == COL_REASON)
    {                        
        tr_bottom.style.display=""; 
        tr_Response.style.display="none";  
        tr_top.style.height="90%";
        txtReason.SetDataText(idGrid.GetGridData(idGrid.row,COL_REASON));                  
        idGrid.SetGridText(idGrid.row,COL_REASON,txtReason.GetData());          
        r=idGrid.row;      
    }
    else if ((event.col) == COL_REMARK_GA) 
    {                        
        tr_Response.style.display="";     
        tr_bottom.style.display="none";   
        tr_top.style.height="90%";
        txtResponse.SetDataText(idGrid.GetGridData(idGrid.row, COL_REMARK_GA));            
        idGrid.SetGridText(idGrid.row, COL_REMARK_GA, txtResponse.GetData());              
    }
    else 
    {                
        tr_bottom.style.display="none";  
        tr_Response.style.display="none";  
        tr_top.style.height="95%"; 
    }
}
function OnSelectAll()
{	
    var ctrl=idGrid.GetGridControl();
    if( chkSelectAll.GetData()=='T')
    {
        for(var i=1;i<ctrl.rows;i++)
            idGrid.SetGridText(i, COL_SELECT,'-1');
    }
	else
	{
        for(var i=1;i<ctrl.rows;i++)
            idGrid.SetGridText(i, COL_SELECT, '0');
    }
}

function OnSetDataToGrid(pos)
{
    var ctrl = idGrid.GetGridControl();
    var i;
    switch(pos)
    {
        case 1:    
            if (lstStatus.value=='ALL')
            {        
                alert("Please choose dormitory status!");
            } 
                               
            for(i=1;i<ctrl.rows;i++) 
            {   
                if (idGrid.GetGridData(i, COL_SELECT) == '-1')
                {
                    idGrid.SetGridText(i, COL_STATUS, lstStatus.GetData())
                }
            }
            break;
        case 2: 
           var cnt=0;
            var ctrl=idGrid.GetGridControl();
            
            for (i=1;i<idGrid.rows;i++)
            {
                if (idGrid.GetGridData(i, COL_SELECT)=="-1")
                {
                    cnt=cnt+1
                }
            }
            
            if (cnt==0)
            {
                alert("Please select is at least one row");   
                return;             
            }
            
            for(i=1;i<ctrl.rows;i++) 
            { 
                if (idGrid.GetGridData(i, COL_SELECT) == '-1')
                {  
                    if (dtAllocatedDt.GetData()!="")
                        idGrid.SetGridText(i, COL_MOVE_IN_DT,dtAllocatedDt.GetData());
                        
                    if (dtMoveIn_Dt.GetData()!="")
                        idGrid.SetGridText(i, COL_MOVE_OUT_DT,dtMoveIn_Dt.GetData());
                        
                    if (dtMoveOut_Dt.GetData()!="")
                        idGrid.SetGridText(i, COL_GA_RESPONSE,dtMoveOut_Dt.GetData());
                        
                    if (dtETD.GetData()!="")
                        idGrid.SetGridText(i, COL_ETD, dtETD.GetData());
                }
            }
            break;     
    }
}

function OnSearch()
{
    dat_Dormitory_Processing.Call("SELECT")
}

function OnUpdate(obj)
{
    var n=0;
    var cnt=0;
    var ctrl=idGrid.GetGridControl();
    
    for (i=1;i<idGrid.rows;i++)
    {
        if (idGrid.GetGridData(i, COL_SELECT)=="-1")
        {
            cnt=cnt+1
        }          
    }    
    
    if (cnt == 0)
    {
        alert("Please select at least one row"); 
        return ;
    }
    
    for (i=1;i<idGrid.rows;i++)
    {          
        if( idGrid.GetGridData(i, COL_SELECT)=="-1")
        {                        
            switch (obj)
            {
                case 1:
                    if (idGrid.GetGridData(i, COL_MOVE_IN_DT)=="")
                    {
                        alert("Allocate date at row "+ i + " is null, please check again!");
                        return ;
                    }
                    
                    if (checkdate(idGrid.GetGridData(i, COL_SUBMITED_DT),idGrid.GetGridData(i, COL_MOVE_IN_DT)))
                    {
                        alert("Allocate date at row "+ i+ " must greater than summited date, please check again!");
                        return ;
                    }
                    
                    idGrid.SetGridText(i, COL_STATUS,'20')     
                    lstStatus.value='20';                  
                    break;
                case 2:                   
                    if (idGrid.GetGridData(i, COL_MOVE_OUT_DT)=="")
                    {
                        alert("Move-in date at row "+ i + " is null, please check again");
                        return ; 
                    }
                   
                    if (checkdate(idGrid.GetGridData(i, COL_MOVE_IN_DT),idGrid.GetGridData(i, COL_MOVE_OUT_DT)))
                    {
                        alert("Move-in date at row "+ i + " must greater than allocated date, please check again!");
                        return ;
                    } 
                    
                    idGrid.SetGridText(i, COL_STATUS,'30');                  
                    lstStatus.value='30';   
                   break;          
                case 3:
                   if (idGrid.GetGridData(i,COL_GA_RESPONSE)=="")
                   {
                        alert("Move-out date at row "+ i + " is null, please check again");
                        return ; 
                   }
                   if (checkdate(idGrid.GetGridData(i, COL_MOVE_OUT_DT),idGrid.GetGridData(i, COL_GA_RESPONSE)))
                   {
                       alert("Move-out date at row "+ i + " must greater than move-in date, please check again!");
                       return ;
                   }
                   
                   idGrid.SetGridText(i, COL_STATUS,'40')
                   lstStatus.value='40';  
                   break;  
                   case 4:
                        if (idGrid.GetGridData(i, COL_REMARK_GA)=="")
                        {
                            alert("Please input reject information!"); 
                            tr_Response.style.display="";     
                            tr_bottom.style.display="none";   
                            tr_top.style.height="90%";
                            return ;                       
                        } 
                    
                        idGrid.SetGridText(idGrid.row, COL_STATUS,'70')  
                        lstStatus.value='70';      
                   break;
                   case 5:
                        if (idGrid.GetGridData(i, COL_REMARK_GA) == "")
                        {
                            alert("Please input request information!"); 
                            tr_Response.style.display="";     
                            tr_bottom.style.display="none";   
                            tr_top.style.height="90%";
                            return ;                       
                        } 
                         idGrid.SetGridText(i, COL_STATUS,'60');
                         lstStatus.value='60';      
                         break;                         
                    case 6:
                        if (idGrid.GetGridData(i, COL_ETD) == "")
                        {
                            alert("Please input column ETD!");
                            return;
                        }
                    break
             }
             idGrid.SetRowStatus(i,16);
             n+=1;
        }   
        else    
        {
            idGrid.SetRowStatus(i,0);
        }
    }
    
    if (n>0)
        dat_Dormitory_Processing.Call();              
}

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
        return false;
    return true;
}

function OnDataReceive(iObj)
{   
    if (iObj.id=='dat_Dormitory_Processing')
    {        
        dtAllocatedDt.SetDataText("");
        dtMoveIn_Dt.SetDataText("");
        dtMoveOut_Dt.SetDataText("");  

        lblRecord.text=idGrid.rows-1 + " records are found!";
        SetStatusOnButton();
        var ctrl=idGrid.GetGridControl();
        var i;
        
        for(i=1;i<idGrid.rows;i++)   
        {
            if(idGrid.GetGridData(i, COL_STATUS)=='70')
            {
                idGrid.SetCellBgColor(i,0,i,idGrid.cols-1,0xC9C299)  
            }
        }
    }      
}
function OnChangeDept()
{
    datGroupData.Call();
}
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value);
    obj=obj_list.GetControl();
    
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
</script>
<body leftmargin="0" rightmargin="0">
    <gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
            <xml> 
                <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                    <input>
                        <input bind="lstDept" /> 
                    </input> 
                    <output>
                        <output bind="txtGroupData" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>
    <gw:data id="dat_Dormitory_Processing" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" user="hr" parameter="0,12,13,14,15,16,17,18,21,22,23,24,25" function="hr.sp_sel_dormitory_processing" procedure="hr.sp_upd_dormitory_processing"> 
                    <input> 
                        <input bind="dtSubmitDt_From" /> 
                        <input bind="dtSubmitDt_To" /> 
                        <input bind="dtRequiredDt_From" />  
                        <input bind="dtRequiredDt_To" />
                        <input bind="lstDept" />                   
                        <input bind="lstGroup" />  
                        <input bind="lstTemp" />                                         
                        <input bind="txtTemp" />  
                        <input bind="lstStatus" />               
                    </input> 
                    <output bind="idGrid" /> 
                </dso> 
            </xml> 
    </gw:data>  
    <form id="form1" runat="server">  
    <table align="center" cellpadding=0 cellspacing=0 border=0 style="width:100%;height:100%">
        <tr height=3%>
            <td width="100%" valign=top>
                <table align=center cellpadding=0 cellspacing=0  border=0 width=100%>
                    <tr>
                        <td align=left nowrap>&nbsp; Submited date</td>
                        <td width="10%">
                            <gw:datebox id="dtSubmitDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>&nbsp;&nbsp;
                        </td>
                        <td>
                            ~&nbsp;&nbsp;&nbsp;&nbsp;<gw:datebox id="dtSubmitDt_To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>
                        </td>
                        <td width=3% align=center></td>                        
                        <td nowrap align=left>&nbsp; Required Date</td>
                        <td width="10%">
                            <gw:datebox id="dtRequiredDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />&nbsp;&nbsp;~
                        </td>
                        <td>
                            <gw:datebox id="dtRequiredDt_To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
                        </td>
                        <td align=right>
                            <table border=0 cellpadding=0 cellspacing=0>
                            <tr>
                                 <td align=right  style="border:0">
                                    <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                                </td>                                                
                                <td align=right nowrap style="border:0">
                                   <!-- <gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnUpdate()" />-->
                                </td> 
                              </tr>
                            </table>
                        </td>                        
                    </tr>
                    <tr>
                        <td align=left nowrap>&nbsp; Department</td>
                        <td width="10%">
                            <gw:list  id="lstDept" onchange=""  value="ALL" maxlen = "100" styles='width:100%' >
                                <data>
                                     <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 order by org_id")%>|ALL|Select All
                                 </data>
                            </gw:list>
                        </td>
                        <td width=3% nowrap><!--&nbsp; Group--></td>
                        <td>
                            <gw:list  id="lstGroup" value="ALL"  maxlen = "100" styles='width:100%;display:none' >                            
                            </gw:list>
                        </td>
                        <td nowrap align=left>&nbsp; Employee </td>
                        <td width="10%">
                            <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
                        </td>
                        <td>
                            <gw:textbox id="txtTemp"  text="" maxlen = "10" styles='width:100%' onenterkey="OnSearch()"/>
                        </td>
                        <td width=3%>&nbsp;</td>                       
                    </tr>
                    <tr>
                        <td align=left nowrap>&nbsp; Status</td>
                        <td width="10%">
                            <gw:list  id="lstStatus" value="10"  maxlen = "100" styles='width:100%' onchange="SetStatusOnButton(),OnSearch()" >
                                <data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0072' AND CODE NOT IN ('50','80') ORDER BY TO_NUMBER(CODE)")%></data>
                            </gw:list>
                        </td>
                        <td width=3% nowrap>
                           <!-- <gw:icon id="ibtnSetStatus" alt="Set All"  text="Set All"  img="in"  styles="width:50%" onclick="OnSetDataToGrid(1)"/>-->                            
                        </td>
                        <td colspan=5></td>                        
                    </tr>  
                    <tr>
                        <td align=left nowrap>&nbsp; Allocated Date</td>
                        <td width="10%">
                            <gw:datebox id="dtAllocatedDt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td width=3% align=center>&nbsp; Move-in Date</td>
                        <td>
                            <gw:datebox id="dtMoveIn_Dt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td nowrap align=left>&nbsp; Move-out Date</td>
                        <td>
                            <gw:datebox id="dtMoveOut_Dt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td  valign="middle" align="left" nowrap >
                            ETD &nbsp;&nbsp;<gw:datebox id="dtETD"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td>
                            <gw:icon id="ibtnSetRemark" alt="Set All"  text="Set All"  img="in"  styles="width:50%" onclick="OnSetDataToGrid(2)"/>                            
                        </td>
                    </tr>                                       
                </table>                
            </td>
        </tr>
        <tr>
            <td height=2% width=100%>
                <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                    <tr>
                        <td style="font-family:Tahoma;color:Blue;size:12" style="width:20%" align=left>
                            <gw:checkbox id="chkSelectAll" value="F" onclick="OnSelectAll()" >Select All</gw:checkbox >
                        </td>
                        <td style="width:50%" align=center height=2%>
                            <gw:label id="lblRecord" style="font-family:Tahoma;color:Red;size:12" text="" />
                        </td>
                        <td style="width:30%">
                            <table border=0 cellpadding=0 cellspacing=0 width=100%>
                                <tr>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnETD"         alt="ETD"               text="ETD"        img="in"  styles="width:70%" onclick="OnUpdate(6)"/></td>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnAllocate"    alt="Allocated"         text="Allocated"  img="in"  styles="width:70%" onclick="OnUpdate(1)"/></td>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnMove_in"     alt="Move-in"           text="Move-in"    img="in"  styles="width:70%" onclick="OnUpdate(2)"/></td>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnMove_out"    alt="Move-out"          text="Move-out"   img="in"  styles="width:70%" onclick="OnUpdate(3)"/></td>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnReject"      alt="Reject"            text="Reject"     img="in"  styles="width:70%" onclick="OnUpdate(4)"/></td>
                                    <td style="width:25%;align:right"><gw:icon id="ibtnRequest"     alt="Request more info" text="Request more info"  img="in"  styles="width:70%" onclick="OnUpdate(5)"/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>            
        </tr>
        <tr height=85%>
            <td id='tr_top' on>
                <gw:grid   
                    id="idGrid" 
                    header="_PK|Select|Dept|Group|Emp ID|Full Name|Position|Join Date|Educatiom|Current Address|Tel|Marital Status|Submitted Date|Service Type|Required Date|ETD|Appointed Date|Reason|Status|Dormitory|Dormitory Type|Unit Cost|Allocated Date|Move-in Date|Move-out Date|Response|_Remark GA|_Cancel Reason|_User_PK"                                       
                    format="0|3|0|0|0|0|0|4|0|0|0|0|4|0|4|4|4|0|0|0|0|0|4|4|4|0|0|0|0"  
                    aligns="0|0|0|0|0|0|0|1|0|0|0|0|1|0|1|1|1|0|0|0|0|3|1|1|1|0|0|0|0"    
                    defaults="||||||||||||||||||||||||||||"                     
                    editcol="0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|700|1500|1500|1000|2500|1000|1000|1000|2500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500|1500|1500|2000|0|0|0|0"
                    styles="width:100%; height:100%"   
                    acceptNullDate="T"
                    oncellclick="onClickToGrid()" 
                    autosize="true"
                    sorting="T"/> 
            </td>
        </tr>
        <tr>
            <td id='tr_bottom' style="width:100%;height:5%">
                <table border=0 cellpadding=0 cellspacing=0 width=100%>
                    <tr>
                      <td>
                        <gw:textarea id="txtReason" rows=5 text="" onchange="onChangeText(0)" styles='width:100%;'/>
                        
                      </td>  
                    </tr>                   
                </table>
            </td>
        </tr>
        <tr>
            <td id='tr_Response' style="width:100%;height:5%">
                <table border=0 cellpadding=0 cellspacing=0 width=100%>                    
                    <tr>
                      <td>
                        <gw:textarea id="txtResponse" onchange="onChangeText(1)" rows=5 text=""  styles='width:100%;'/>
                      </td>  
                    </tr>
                </table>
            </td>
        </tr>
    </table> 
    <gw:textbox id="txtGroupData" styles="display:none"/>    
    </form>    
</body>
</html>
