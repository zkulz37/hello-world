<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";
function BodyInit()
{  
   idGrid.GetGridControl().FrozenCols =3;
   idGrid.GetGridControl().ScrollTrack=true;  
   
   if (v_language!="ENG")
        System.Translate(document);  
        
   var l_today = dtRequiredDt_To.value;
   var l_pre_month ;
   l_pre_month=AddDate(l_today,-30)
   dtRequiredDt_From.value = l_pre_month; 
   txt_user_id.text = "<%=session("USER_ID")%>";  
   txt_user_pk.text = "<%=session("EMPLOYEE_PK")%>";
   dat_Dormitory_Charge.Call("SELECT");  
   <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 4 , "select pk, type_name from thr_unit_cost where CATEGORY_CODE='40' order by type_name") %>;         
   // idGridAppDetal.ColFormat(2) = "###,###.##R"; 
    SetColumnFormat();
}
function SetColumnFormat(){
    var ctrl1 = idGridAppDetal.GetGridControl();
    var ctrl2 = idGrid.GetGridControl();
    ctrl1.ColFormat(2) = "###,###R"; 
    ctrl2.ColFormat(5) = "###,###R"; 
}
function onSearch()
{
    dat_Dormitory_Charge.Call("SELECT");  
}
function ShowDormitoryDetail()
{    
    txt_thr_dor_pk.text=idGrid.GetGridData(idGrid.row,0); 
    txt_move_in_dt.text=idGrid.GetGridData(idGrid.row,7); 
    txt_move_out_dt.text=idGrid.GetGridData(idGrid.row,8);    
   dat_Dormitory_Charge_Detail.Call("SELECT"); 
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
</script>
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <gw:data id="dat_Dormitory_Charge" onreceive=""> 
            <xml> 
                <dso id="1" type="grid" user="hr" parameter="0,3,4,5,6,7" function="hr.sp_sel_dormitory_charge"> 
                    <input>                         
                        <input bind="txt_user_pk" />   
                        <input bind="txt_user_id" />   
                        <input bind="rbType" />  
                        <input bind="dtRequiredDt_From" />  
                        <input bind="dtRequiredDt_To" />                                                        
                    </input> 
                    <output bind="idGrid" /> 
                </dso> 
            </xml> 
    </gw:data>  
    
    <gw:data id="dat_Dormitory_Charge_Detail" onreceive=""> 
            <xml> 
                <dso id="1" type="grid" user="hr"  function="hr.sp_sel_dormitory_charge_detail"> 
                    <input>                         
                        <input bind="txt_thr_dor_pk" />  
                        <input bind="txt_move_in_dt" />  
                        <input bind="txt_move_out_dt" />                                                               
                    </input> 
                    <output bind="idGridAppDetal" /> 
                </dso> 
            </xml> 
    </gw:data> 
    <form id="form1" runat="server">
   <table border=1 cellpadding=0 cellspacing=0 style="height:100%;width:100%">
   <tr>
    <td style="height:10%;width:100%" nowrap colspan=3 style="font-family:Tahoma;color:Blue" align=left>
        <table border=0 cellpadding=0 cellspacing=0 style="height:100%;width:100%">
        <tr>
            <td width=30%>
             <gw:radio id="rbType" value="1" onchange="onSearch()"> 
                    <span value="1">My Application</span>
                    <span value="0">All Application</span>		                                   
                </gw:radio>
            </td>
            <td width=10% nowrap align=left>&nbsp; Required Date</td>
            <td width="10%">
                <gw:datebox id="dtRequiredDt_From"  maxlen = "10" text="" onchange="onSearch()" styles='width:100%'lang="<%=Session("Lang")%>" />&nbsp;&nbsp;~
            </td>
            <td width=10%>
                <gw:datebox id="dtRequiredDt_To"  maxlen = "10" text="" onchange="onSearch()" styles='width:100%'lang="<%=Session("Lang")%>" />
            </td>
            <td>&nbsp;</td>
        </tr>
        </table> 
      </td>
   </tr>
    <tr>
        <td style="height:90%;width:60%">  
        <gw:grid   
            id="idGrid"  
            header="_PK|App No|Emp ID|Full Name|Dormitory Type|Unit Cost|Allocate Date|Move-in Date|Move-out Date"   
            format="0|0|0|0|0|0|4|4|4"  
            aligns="0|0|0|0|0|3|0|0|0"    
            defaults="||||||||"               
            border=1
            editcol="0|0|0|0|0|1|1|0|0"  
            widths="0|1500|1000|2000|1500|1500|1500|1500|1500"  
            styles="width:100%; height:100%" oncellclick="ShowDormitoryDetail()" 
            acceptNullDate="T"  
            sorting="T"/>           
        </td>
        <td width=1%></td>
        <td width=49%>
            <gw:grid   
                id="idGridAppDetal"  
                header="Month|Inhabited Days|Total Amount|Remark (GA)"   
                format="0|0|0|0"  
                aligns="0|3|3|0"    
                defaults="|||"    
                editcol="0|0|0|0"  
                widths="0|1000|1500|1500"  
                styles="width:100%; height:100%"   
                sorting="T"/>            
        </td>
    </tr>
   </table>
   <gw:textbox id="txt_user_id" styles="display:none"/> 
   <gw:textbox id="txt_user_pk" styles="display:none"/> 
   <gw:textbox id="txt_thr_dor_pk" styles="display:none"/> 
   <gw:textbox id="txt_move_in_dt" styles="display:none"/> 
   <gw:textbox id="txt_move_out_dt" styles="display:none"/>
    </form>
</body>
</html>
