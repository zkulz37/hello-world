<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";
function BodyInit()
{  
   if (v_language!="ENG")
        System.Translate(document);  
   var l_today = dtRequiredDt_To.value;
   var l_pre_month ;
   l_pre_month=AddDate(l_today,-30)
   dtRequiredDt_From.value = l_pre_month;    
        
   BindingDataList();
   idGrid.GetGridControl().FrozenCols =7;
   idGrid.GetGridControl().ScrollTrack=true; 
   txt_user_id.text="<%=session("USER_ID")%>";
   txt_user_pk.text="<%=session("EMPLOYEE_PK")%>";  
   SetColumnFormat();  
}
function SetColumnFormat(){   
    var ctrl1 = idGrid.GetGridControl();
    ctrl1.ColFormat(18) = "###,###R";     
}
function BindingDataList()
{   
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 15 , "select code,CODE_NM from vhr_hr_code where id='HR0072' order by code_nm") %>;          
}
function AddDate(strDate,intDay)
{
	if (v_language!="ENG")
        System.Translate(document);  
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
function OnSearch()
{
    dat_Dormitory_App_List.Call("SELECT")
}
function OnAddNew()
{
    System.Menu.NewWindow( "form/ch/id/chid00010.aspx" , "Dormitory App Entry", "Dormitory App Entry", "Dormitory App Entry" );
}
function OnModify()
{
    var v_dor_pk;
    v_dor_pk= idGrid.GetGridData(idGrid.row,0);
    System.Menu.NewWindow( "form/ch/id/chid00010.aspx?thr_dor_pk="+v_dor_pk , "Dormitory App Entry", "Dormitory App Entry", "Dormitory App Entry" );
}

function GetDataFromGrid()
{
    var ctrl= idGrid.GetGridControl();   
    txtResponse.SetDataText(idGrid.GetGridData(idGrid.row,23)); 
    txtReasonCancel.SetDataText(idGrid.GetGridData(idGrid.row,24));    
    if ((idGrid.GetGridData(idGrid.row,14))=='70')
    {
        ibtnModify.SetEnable(0);        
        ibtnCancel.SetEnable(1);  
        ibtnDelete.SetEnable(1);     
    }
    else if ((idGrid.GetGridData(idGrid.row,15))=='60')
    {
        ibtnModify.SetEnable(1);        
        ibtnCancel.SetEnable(1);  
        ibtnDelete.SetEnable(0);       
    }
    else if ((idGrid.GetGridData(idGrid.row,15))=='40')
    {
        ibtnModify.SetEnable(0);        
        ibtnCancel.SetEnable(0);  
        ibtnDelete.SetEnable(0);     
    }
    else {
        ibtnModify.SetEnable(0);        
        ibtnCancel.SetEnable(1);  
        ibtnDelete.SetEnable(1);
    }
}
function OnReplicate()
{   
    if(confirm('Are you sure you want to replicate the dormitory application?'))
    {
        txt_dor_pk.text = idGrid.GetGridData(idGrid.row, 0);        
        dat_Dormitory_App_Replicate.Call();
    }    
}
function OnDelete()
{
    idGrid.DeleteRow();
}
function OnSave()
{   
    idGrid.SetGridText(idGrid.row,23,txtResponse.GetData())
    
    idGrid.SetGridText(idGrid.row,24,txtReasonCancel.GetData())      
    dat_Dormitory_App_List.Call();
}
function OnCancel()
{   
    if (txtReasonCancel.GetData()=="")
    {
        alert("Please input cancel reason");
    }
    else
        { 
        if(confirm('Are you sure you want to cancel the request?'))
            {
                txt_dor_pk.text = idGrid.GetGridData(idGrid.row,0);               
                dat_Dormitory_App_Cancel.Call();
            } 
          }    
}
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {      
        case 'dat_Dormitory_App_Cancel':
            dat_Dormitory_App_List.Call('SELECT');
        break ;
        case 'dat_Dormitory_App_Replicate':
            dat_Dormitory_App_List.Call('SELECT');
        break ;  
        case 'dat_Dormitory_App_List':                    
            var i;      
            lblRecord.text=idGrid.rows-1 + " records are found!"      
            for(i=1;i<idGrid.rows;i++)   
            {
                if(idGrid.GetGridData(i,15)=='70')
                {
                    idGrid.SetCellBgColor(i,0,i,idGrid.cols-1,0xC9C299)  
                }
                if(idGrid.GetGridData(i,15)=='60')
                {
                    idGrid.SetCellBgColor(i,0,i,idGrid.cols-1,0xC0C200)  
                }
            }             
    }
}
</script>
<gw:data id="dat_Dormitory_App_List" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" parameter="0,5,6,12,13,14,15,16,18,19,20,21,22,23,24,25" function="hr.sp_sel_dormitory_app_list" procedure="hr.sp_upd_dormitory_processing"> 
                <input> 
                    <input bind="dtRequiredDt_From" /> 
                    <input bind="dtRequiredDt_To" />   
                    <input bind="txt_user_pk" /> 
                    <input bind="txt_user_id" /> 
                    <input bind="rbType"/>   
                    <input bind="lstStatus" />                                        
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data>  
<gw:data id="dat_Dormitory_App_Cancel" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="hr.sp_pro_dormitory_app_cancel"> 
                <input> 
                    <input bind="txt_dor_pk" /> 
                    <input bind="txtReasonCancel" />                                           
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data> 
 
<gw:data id="dat_Dormitory_App_Replicate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="hr.sp_pro_dormitory_app_replicate"> 
                <input> 
                    <input bind="txt_dor_pk" />                                                                      
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>  
    <form id="form1" runat="server">
    <table  border=1 cellpadding=0 cellspacing=0 style="height:100%;width:100%">
    <tr>
        <td width=100% height="90%">
            <table border=0 cellpadding=0 cellspacing=0 style="height:100%;width=100%">
                <tr>
                    <td width=50% align=left style="height:1%;width=100%">
                        <table border=0 cellpadding=0 cellspacing=0 width=100%>
                            <tr>
                                <td width=25% align=left>Required date &nbsp;</td>
                                <td width=10% align=left nowrap><gw:datebox id="dtRequiredDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>
                                <td width=10%  align=center nowrap>~</td>
                                <td width=10% align=left nowrap><gw:datebox id="dtRequiredDt_To" onchange="OnSearch()"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/></td>                        
                                <td width=10% nowrap>Status &nbsp;</td>
                                <td width=20%>
                                    <gw:list  id="lstStatus" value="ALL"  maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0072' order by code_nm")%>|ALL|Select All</data>
                                    </gw:list>
                                </td>
                                <td nowrap width=3%  style="border:0">
                                    <gw:imgBtn id="ibtnSearch" alt="search" img="search" text="search" onclick="OnSearch()" />
                                </td>  
                                <td width=12% align=left nowrap>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td width=50% align=RIGHT>
                        <gw:radio id="rbType" value="1" onchange="OnSearch()"> 
                            <span value="1">My Application</span>
                            <span value="0">All Application</span>		                                   
                        </gw:radio>                     
                    </td>
                </tr>
                <tr style="height:1%;width=100%">
                    <td width=50%>&nbsp;</td>
                    <td width=50% align=right>
                        <table border=0 cellpadding=0 cellspacing=0 width=100%>
                            <tr>
                                <td width=75%>&nbsp;</td>
                                <td width=5% nowrap><gw:icon id="ibtnAddNew" alt="Add New"  text="Add New"  img="in"  styles="width:100%" onclick="OnAddNew()"/></td>
                                <!--<td width=5% nowrap><gw:icon id="ibtnReplicate" alt="Replicate"  text="Replicate" img="in"  styles="width:100%" onclick="OnReplicate()" /></td>-->
                                <td width=5% nowrap><gw:icon id="ibtnModify" alt="Modify"  text="Modify" img="in"  styles="width:100%" onclick="OnModify()" /></td>
                                <td width=5% nowrap><!--<gw:icon id="ibtnSave" alt="Save"  text="Save"  img="in"  styles="width:100%" onclick="OnSave()"/>--></td>
                                <td width=5% nowrap><gw:icon id="ibtnCancel" alt="Cancel"  text="Cancel"  onclick="OnCancel()" img="in"  styles="width:100%" /></td>                        
                                <td width=5% nowrap><gw:icon id="ibtnDelete" alt="Delete"  text="Delete"  onclick="OnDelete()" img="in"  styles="width:100%" /></td>                        
                            </tr>
                        </table>
                    </td>            
                </tr>
                <tr>
                    <td align=center height=1% colspan=2><gw:label id="lblRecord" style="font-family:Tahoma;color:Red;size:12" text="" /></td>
                </tr>
                <tr>
                    <td colspan=2 style="height:97%;width=100%"> 
                        <gw:grid   
                            id="idGrid"  
                            header="_PK|_EMP_PK|Emp ID|Name|App No|Submitted Date|Service Type|Join Date|Education|Current Address|Tel|Marital Status|Required Date|Appointed Date|Reason|Status|Dormitory|Dormitory Type|Unit Cost|Allocated Date|Move-in Date|Move-out Date|_Response|Remark (GA)|_Cancel Reason|_User_PK"   
                            format="0|0|0|0|0|4|0|4|0|0|0|0|4|4|0|0|0|0|0|4|4|4|0|0|0|0"  
                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0"    
                            defaults="|||||||||||||||||||||||"    
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|0|0|0|1|1|1|1|1|1|1"  
                            widths="0|0|1000|2000|1000|1500|1500|1500|1000|2500|1000|1500|1500|1500|2500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0"  
                            styles="width:100%; height:100%" oncellclick="GetDataFromGrid()" acceptnulldate="true"   
                            sorting="T"/>              
                    </td>
                </tr>  
              </table>              
        </td>
    </tr>    
    <tr>
    <td style="height:10%">
        <table style="width:100%" border=0 cellpadding=0 cellspacing=0>
            <tr>
                <td   style="width:50%;height:1%" nowrap>
                <gw:label id="lblResponse" styles="width:100%" text="Response" />
                </td>
                <td width=50% nowrap>        
                <gw:label id="lblResoncacel" styles="width:100%" text="Reason for cancellation" />
                </td>
            </tr>
            <tr>
            <td align=right height="">
                <gw:textarea id="txtResponse" rows=5 text=""  styles='width:100%;'/>
            </td>
            <td align=right>
                <gw:textarea id="txtReasonCancel" rows=5 text=""  styles='width:100%;'/>
            </td>
    </tr>  
        </table>
    </td>        
    </tr>
     
    </table>    
    <gw:textbox id="txt_dor_pk" styles="display:none"/> 
    <gw:textbox id="txt_user_id" styles="display:none"/> 
    <gw:textbox id="txt_user_pk" styles="display:none"/>   
    <gw:textbox id="txtReturn" styles="display:none"/>   
      
    </form>
</body>
</html>
