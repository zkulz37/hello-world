<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Process Dormitory Request (GA)</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

var COL_PK                 = 0,
    COL_SELECT             = 1,
    COL_DEPT               = 2,
    COL_GROUP              = 3,
    COL_EMP_ID             = 4,
    COL_FULL_NAME          = 5,
    COL_TT_SCORE           = 6,
    COL_POS                = 7,
    COL_JOIN_DATE          = 8,
    COL_EDUCATION          = 9,
    COL_CURR_ADD           = 10,
    COL_TEL                = 11,
    COL_MAR_STATUS         = 12,
    COL_SUB_DATE           = 13,
    COL_SERVICE_TYPE       = 14,
    COL_REQ_DATE           = 15,
    COL_APPOINTED_DATE     = 16,
    COL_STATUS             = 17,
    COL_DORMITORY          = 18,
    COL_DORMITORY_TYPE     = 19,
    COL_UNIT_COST          = 20,
    COL_REVIEWED_DT        = 21,
    COL_REJECTED_DT        = 22,
    COL_GA_REJECT_REASON   = 23,
    COL_RESPONSE_DT        = 24,
    COL_GA_RESPONSE_REASON = 25,
    COL_REMARK_GA          = 26,
    COL_CANCEL_REASON      = 27,
    COL_USER_PK            = 28;

function BodyInit()
{    
    idGrid.GetGridControl().FrozenCols = COL_POS;
    idGrid.GetGridControl().ScrollTrack = true;          
    BindingDataList();
    tr_bottom.style.display="none";   
    tr_Response.style.display="none";   
    tr_top.style.height="95%";
    
    if (v_language!="ENG")
        System.Translate(document);  
        
    OnSearch();   
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
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 17, "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0072' AND CODE IN ('20', '60', '70', '80') ORDER BY TO_NUMBER(CODE)") %>;            
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
    var bottom   = document.all("tr_bottom");    
    var top      = document.all("tr_top");   
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
 
function SetColumnFormat()
{
    var ctrl1 = idGrid.GetGridControl();
    ctrl1.ColFormat(COL_UNIT_COST) = "###,###R";
}

function SetStatusOnButton()
{
    var v_status;   
    if (lstStatus.GetData()=='20') // Submited
    {
        btnReviewed.SetEnable(1);
        btnRejected.SetEnable(1);
        ibtnResponse.SetEnable(1);
        dtReviewed.SetEnable(1);
        dtRejected.SetEnable(1);
        dtResponse.SetEnable(1);
    }
    else if (lstStatus.GetData()=='60') // Reviewed
    {
        btnReviewed.SetEnable(0);
        btnRejected.SetEnable(0);
        ibtnResponse.SetEnable(0);
        dtReviewed.SetEnable(0);
        dtRejected.SetEnable(0);
        dtResponse.SetEnable(0);
    }
    else if (lstStatus.GetData()=='70') // Rejected
    {
        btnReviewed.SetEnable(0);
        btnRejected.SetEnable(0);
        ibtnResponse.SetEnable(0); 
        dtReviewed.SetEnable(0);
        dtRejected.SetEnable(0);
        dtResponse.SetEnable(0);
    }
    if (lstStatus.GetData()=='80')      // Response
    {
        btnReviewed.SetEnable(0);
        btnRejected.SetEnable(0);
        ibtnResponse.SetEnable(0); 
        dtReviewed.SetEnable(0);
        dtRejected.SetEnable(0);
        dtResponse.SetEnable(0);
    }
}

function onChangeText(obj)
{
    switch (obj)
    {
        case 0:
            idGrid.SetGridText(idGrid.row, COL_GA_REJECT_REASON, txtReject.GetData());
        break;
        case 1:
            idGrid.SetGridText(idGrid.row, COL_GA_RESPONSE_REASON, txtGAResponse.GetData());
        break;
    }
}

function onClickToGrid()
{    
    if ((event.col)== COL_GA_REJECT_REASON)
    {
        lblName_Reject.text = "Emp Name : " + idGrid.GetGridData(event.row, COL_FULL_NAME) + " - Reject Mess";
        tr_bottom.style.display=""; 
        tr_Response.style.display="none";  
        tr_top.style.height="90%";
        txtReject.SetDataText(idGrid.GetGridData(idGrid.row,COL_GA_REJECT_REASON));                  
        idGrid.SetGridText(idGrid.row,COL_GA_REJECT_REASON,txtReject.GetData());          
        r=idGrid.row;
    }
    else if ((event.col) == COL_GA_RESPONSE_REASON) 
    {                        
        lblName_Response.text = "Emp Name : " + idGrid.GetGridData(event.row, COL_FULL_NAME) + " - Response Mess";;
        tr_Response.style.display="";     
        tr_bottom.style.display="none";   
        tr_top.style.height="90%";
        txtGAResponse.SetDataText(idGrid.GetGridData(idGrid.row, COL_GA_RESPONSE_REASON));            
        idGrid.SetGridText(idGrid.row, COL_GA_RESPONSE_REASON, txtGAResponse.GetData());
        r=idGrid.row;
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
            idGrid.SetGridText(i, COL_SELECT, '-1');
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
        case 2:
            var cnt=0;
            var ctrl=idGrid.GetGridControl();
            
            for (i=1;i<idGrid.rows;i++)
            {
                if (idGrid.GetGridData(i, COL_SELECT) == "-1")
                {
                    cnt=cnt+1
                }
            }    
            
            if (cnt==0)
            {
                alert("Please select is at least one row");   
                return;             
            }        
            
            for(i = 1 ; i < ctrl.rows; i++) 
            { 
                if (idGrid.GetGridData(i, COL_SELECT)=='-1')
                {  
                    //if (dtReviewed.GetData()!= "")
                        idGrid.SetGridText(i, COL_REVIEWED_DT, dtReviewed.GetData());
                        
                    //if (dtRejected.GetData()!= "")
                        idGrid.SetGridText(i, COL_REJECTED_DT, dtRejected.GetData());
                        
                    //if (dtResponse.GetData()!= "")
                        idGrid.SetGridText(i, COL_RESPONSE_DT, dtResponse.GetData());
                }
            }
            break;
    }
}

function OnSearch()
{
    dat_chid00060.Call("SELECT");
}

function OnUpdate(obj)
{
    var n=0;
    var cnt=0;
    var ctrl=idGrid.GetGridControl();
    
    for (i=1;i<idGrid.rows;i++)
    {
        if (idGrid.GetGridData(i, COL_SELECT)== "-1")
        {
            cnt=cnt+1
        }          
    }
    
    if (cnt == 0)
    {
        alert("Please select at least one row."); 
        return ;
    }
    
    for (i = 1; i < idGrid.rows; i++)
    {          
        if( idGrid.GetGridData(i, COL_SELECT) == "-1")
        {
            switch (obj)
            {
                case 1: // Reviewed                   
                    if (idGrid.GetGridData(i, COL_REVIEWED_DT) == "")
                    {
                        alert("Reviewed date at row " + i + " is null, please check again!");
                        return ;
                    }
                    
                    if (checkdate(idGrid.GetGridData(i, COL_SUB_DATE), idGrid.GetGridData(i, COL_REVIEWED_DT)))
                    {
                        alert("Reviewed date at row " + i + " must greater than summited date, please check again!");
                        return ;
                    }
                    
                    if(confirm("Do you want set status 'Reviewed' ?"))
                    {
                        dtRejected.SetDataText("");
                        dtResponse.SetDataText("");
                        OnSetDataToGrid(2);
                        
                        idGrid.SetGridText(i, COL_STATUS, '60'); // 60: Reviewed
                        lstStatus.value = '60';
                    }                                   
                break;
                
                case 2: // Rejected                    
                    if (idGrid.GetGridData(i, COL_REJECTED_DT) == "")
                    {
                        alert("Rejected date at row " + i + " is null, please check again!");
                        return ;
                    }
                    
                    if (idGrid.GetGridData(i, COL_GA_REJECT_REASON) == "")
                    {
                        alert("Rejected reason at row " + i + " is null, please check again!");
                        return ;
                    }
                    
                    if (checkdate(idGrid.GetGridData(i, COL_SUB_DATE), idGrid.GetGridData(i, COL_REJECTED_DT)))
                    {
                        alert("Rejected date at row " + i + " must greater than summited date, please check again!");
                        return ;
                    }
                    
                    if(confirm("Do you want set status 'Rejected' ?"))
                    {
                        dtReviewed.SetDataText("");
                        dtResponse.SetDataText("");
                        OnSetDataToGrid(2);
                        
                        idGrid.SetGridText(i, COL_STATUS, '70'); // 70: Rejected
                        lstStatus.value = '70';                        
                    }     
                break;
                
                case 3: // Response
                    
                    if (idGrid.GetGridData(i, COL_RESPONSE_DT) == "")
                    {
                        alert("Response date at row " + i + " is null, please check again!");
                        return ;
                    }
                    
                    if (idGrid.GetGridData(i, COL_GA_RESPONSE_REASON) == "")
                    {
                        alert("Response reason at row " + i + " is null, please check again!");
                        return ;
                    }
                    
                    if (checkdate(idGrid.GetGridData(i, COL_SUB_DATE), idGrid.GetGridData(i, COL_RESPONSE_DT)))
                    {
                        alert("Response date at row " + i + " must greater than summited date, please check again!");
                        return ;
                    }
                    
                    if(confirm("Do you want set status 'Response' ?"))
                    {
                        dtReviewed.SetDataText("");
                        dtRejected.SetDataText("");
                        OnSetDataToGrid(2);
                        
                        idGrid.SetGridText(i, COL_STATUS, '80'); // 80: Response
                        lstStatus.value = '80';
                    }
                break;
            }
            
            idGrid.SetRowStatus(i, 16);
            n+=1;
        }   
        else
        {
            idGrid.SetRowStatus(i,0);
        }
    }
    
    if (n > 0)
        dat_chid00060.Call();
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
    
    if (dt_2 >= dt_1)
        return false;
    return true;
}

function OnDataReceive(iObj)
{   
    tr_Response.style.display="none";
    tr_bottom.style.display="none";
    if (iObj.id == 'dat_chid00060')
    {
        lblRecord.text = idGrid.rows-1 + " records are found!";
        
        dtReviewed.SetDataText("");
        dtRejected.SetDataText("");
        dtResponse.SetDataText("");
        
        SetStatusOnButton();
        
        //var ctrl=idGrid.GetGridControl();
        
        //for(i=1;i<idGrid.rows;i++)   
        //{
        //    if(idGrid.GetGridData(i, COL_STATUS) == '60') // Reviewed
        //    {
        //        idGrid.SetCellBgColor(i,0,i,idGrid.cols-1,0xC9C299)  
        //    }
        //}
    }      
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
<gw:data id="dat_chid00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" parameter="0,13,14,15,16,17,18,20,21,22,23,24,25,26,27,28" function="hr.sp_sel_chid00060" procedure="hr.sp_upd_chid00060"> 
                <input> 
                    <input bind="dtSubmitDt_From" /> 
                    <input bind="dtSubmitDt_To" /> 
                    <input bind="dtRequiredDt_From" />  
                    <input bind="dtRequiredDt_To" />
                    <input bind="lstDept" />
                    <input bind="lstTemp" />                                         
                    <input bind="txtTemp" />  
                    <input bind="lstStatus" />               
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data>  
<form id="form1" runat="server">  
    <table align="center" cellpadding="0" cellspacing="1" border="0" style="width:100%;height:100%;background: #BDE9FF">
        <tr height=3%>
            <td width="100%" valign=top style="background: white">
                <table align=center cellpadding="0" cellspacing="0"  border="0" width=100%>
                    <tr>                       
                        <td width="20%" align="left" nowrap >&nbsp; Submited date</td>
                        <td width="10%">
                            <gw:datebox id="dtSubmitDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>
                        </td>
                        <td width="1%" align="center" valign="middle" >~</td>
                        <td width="10%">
                            <gw:datebox id="dtSubmitDt_To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>
                        </td>
                        <td width="10%" nowrap >&nbsp; Required Date</td>
                        <td width="10%">
                            <gw:datebox id="dtRequiredDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
                        </td>
                        <td width="1%" align="center" valign="middle" >~</td>
                        <td width="10%">
                            <gw:datebox id="dtRequiredDt_To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
                        </td>
                        <td width="10%">
                            <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td width="18%"></td>
                    </tr>
                    <tr>
                        <td width="10%" align=left nowrap>&nbsp; Department</td>
                        <td colspan=3 width="21%">
                            <gw:list  id="lstDept" onchange=""  value="ALL" maxlen = "100" styles='width:100%' >
                                <data>
                                     <%=ESysLib.SetListDataSQL("SELECT PK,ORG_NM FROM COMM.TCO_ORG A WHERE DEL_IF=0 ORDER BY ORG_ID")%>|ALL|Select All
                                 </data>
                            </gw:list>
                        </td>
                        <td width="10%" nowrap >&nbsp; Employee </td>
                        <td width="10%">
                            <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
				                    <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
		                    </gw:list>
                        </td>
                        <td width="1%"></td>
                        <td colspan="3" width="10%">
                            <gw:textbox id="txtTemp"  text="" maxlen = "10" styles='width:100%' onenterkey="OnSearch()"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="10%"align=left nowrap>&nbsp; Status</td>
                        <td colspan="3" width="21%">
                            <gw:list  id="lstStatus" value="20"  maxlen = "100" styles='width:100%' onchange="SetStatusOnButton(), OnSearch()" >
                                <data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0072' AND CODE IN ('20', '60', '70', '80') ORDER BY CODE")%></data>
                            </gw:list>
                        </td>
                        <td colspan="6" width="69%"></td>                        
                    </tr>  
                    <tr>
                        <td width="10%" align=left nowrap>&nbsp; Reviewed Date</td>
                        <td width="10%">
                            <gw:datebox id="dtReviewed"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td colspan="2" width=11% >&nbsp; &nbsp; &nbsp;Rejected Date </td>
                        <td>
                            <gw:datebox id="dtRejected"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td width=10% nowrap align="right">&nbsp; Response Date</td>
                        <td width=1% ></td>
                        <td width=10%>
                            <gw:datebox id="dtResponse"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td  align="right">&nbsp;</td>
                        <td align="right">
                            <gw:icon id="ibtnSetRemark" alt="Set All"  text="Set All"  img="in"  styles="width:50%" onclick="OnSetDataToGrid(2)"/>
                        </td>
                    </tr> 
                </table>                
            </td>
        </tr>
        <tr>
            <td height=2% width=100% style="background: white">
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
                                    <td style="width:25%;"></td>
                                    <td style="width:25%;"></td>
                                    <td style="width:25%;"><gw:icon id="btnReviewed"     alt="Reviewed"     text="Reviewed"  img="in"  styles="width:70%" onclick="OnUpdate(1)"/></td>
                                    <td style="width:25%;"><gw:icon id="btnRejected"     alt="Rejected"     text="Rejected"  img="in"  styles="width:70%" onclick="OnUpdate(2)"/></td>
                                    <td style="width:25%;"><gw:icon id="ibtnResponse"    alt="Response"     text="Response"  img="in"  styles="width:70%" onclick="OnUpdate(3)"/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>            
        </tr>
        <tr height=85% valign="top">
            <td id='tr_top' style="background: white">
                <gw:grid   
                    id="idGrid" 
                    header="_PK|Select|Dept|_Group|Emp ID|Full Name|TT Score|Position|Join Date|Educatiom|Current Address|Tel|Marital Status|Submited Date|Service Type|Required Date|Appointed Date|Status|Dormitory|Dormitory Type|Unit Cost|Reviewed Date|Rejected Date|Rejected Reason|Response Date|GA Response Reason|_Remark GA|_Cancel Reason|_User_PK"
                    format="0|3|0|0|0|0|1|0|4|0|0|0|0|4|0|4|4|0|0|0|0|4|4|0|4|0|0|0|0"  
                    aligns="0|0|0|0|0|0|0|0|1|0|0|0|0|1|0|1|1|0|0|0|3|1|1|0|1|0|0|0|0"    
                    defaults="||||||||||||||||||||||||||||"                     
                    editcol="0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                    widths="0|700|2500|1500|1000|2500|1000|1000|1200|1000|2500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500|1500|1500|0|0|0|0"
                    styles="width:100%; height:100%"   
                    acceptNullDate="T"
                    oncellclick="onClickToGrid()" 
                    autosize="true"
                    sorting="T"/> 
            </td>
        </tr>
        <tr>
            <td id='tr_bottom' style="width:100%;height:5%">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <td align="left" >
                            <gw:label id="lblName_Reject" style="font-family:Tahoma;color:Red;size:12" text="" />                            
                        </td>
                    <tr>
                      <td>
                        <gw:textarea id="txtReject" rows="5" text="" onchange="onChangeText(0)" styles='width:100%;'/>                        
                      </td>  
                    </tr>                   
                </table>
            </td>
        </tr>
        <tr>
            <td id='tr_Response' style="width:100%;height:5%">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="left" >
                            <gw:label id="lblName_Response" style="font-family:Tahoma;color:Red;size:12" text="" />                            
                        </td>
                    </tr>
                    <tr>
                      <td>
                        <gw:textarea id="txtGAResponse" onchange="onChangeText(1)" rows="5" text=""  styles='width:100%;'/>
                      </td>  
                    </tr>
                </table>
            </td>
        </tr>
    </table> 
    </form>    
</body>
</html>
