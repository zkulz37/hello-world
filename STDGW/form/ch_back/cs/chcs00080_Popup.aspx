<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var col
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    idGrid.GetGridControl().ScrollTrack=true;
    idtxtEmp_id.text="<%=request.QueryString("emp_id")%>";
    lstAll_kind.value="<%=request.QueryString("kind")%>";
    dtWMonth.value="<%=request.QueryString("work_mon")%>";
    col="<%=request.QueryString("rule_kind")%>";
        lstRule_kind.value=col;
    define_grid(idGrid,col);
    datGet_from_to.Call();
    
}
function define_grid(obj,rule_kind)
{
    var ctrl=obj.GetGridControl();
    switch(rule_kind)
    {
        case '1'://time rule
            obj.SetGridText(0,3,"Work Date");
            obj.SetGridText(0,4,"Work Shift");
            obj.SetGridText(0,5,"In Time");
            obj.SetGridText(0,6,"Out Time");
            obj.SetGridText(0,7,"No Scan Time");
            obj.SetGridText(0,8,"In Late");
            obj.SetGridText(0,9,"Our Early");
            break;
        case '2'://Absence rule
            obj.SetGridText(0,3,"Work Date");
            obj.SetGridText(0,4,"Absence Type");
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '3'://Contract rule
            obj.SetGridText(0,3,"Contract Type");
            obj.SetGridText(0,4,"Start Contract");
            obj.SetGridText(0,5,"End Contract");
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '4'://Status rule
            obj.SetGridText(0,3,"Employee Status");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '5'://Discipline rule
            obj.SetGridText(0,3,"Discipline Date");
            obj.SetGridText(0,4,"Level");
            obj.SetGridText(0,5,"Reason");
            obj.SetGridText(0,6,"Remark");
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '6'://work day rule
            obj.SetGridText(0,3,"Work days (Days)");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '7'://Work mon rule
            obj.SetGridText(0,3,"Work Months (Months)");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '8'://Employee type rule
            obj.SetGridText(0,3,"Employee Type");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '9'://Progress type rule    
            obj.SetGridText(0,3,"Work Months");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True"; 
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
        case '10'://Probation rule
            obj.SetGridText(0,3,"Probation Status");
            ctrl.ColHidden(4)="True";
            ctrl.ColHidden(5)="True";
            ctrl.ColHidden(6)="True";
            ctrl.ColHidden(7)="True";
            ctrl.ColHidden(8)="True";
            ctrl.ColHidden(9)="True";
            break;
    }    
       
}
function onChangeMonth()
{
    idGrid.ClearData();
    datGet_from_to.Call();
}
function onChange_rule()
{
     define_grid(idGrid,lstRule_kind.value);
     OnSearch();
}
function OnSearch()
{
    if(txtTMP.text=="") //chua co thang nay
    {
            alert("This month is not define in period close form.\nTháng này chưa được định nghĩa ở form period close.")
            return;
    }
    if(Trim(idtxtEmp_id.text)=="")
        alert("You must input employee id.\nBạn phải nhập mã nhân viên.")
    else
        datUnfix_allowance_popup.Call("SELECT");    
}
function OnDataReceive(obj)
{
    if(obj.id=="datGet_from_to")
    {
        if(txtTMP.text=="") //chua co thang nay
        {
            alert("This month is not define in period close form.\nTháng này chưa được định nghĩa ở form period close.");
            return;
        }
        OnSearch();
    }
    if(obj.id=="datUnfix_allowance_popup")
    {
        auto_resize_column(idGrid,0,idGrid.GetGridControl().cols-1,0)
    }
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_from_to" > 
                <input>
                    <input bind="dtWMonth" />
                </input> 
                <output>
                    <output bind="idFrom" />
                    <output bind="idTo" />
                    <output bind="txtTMP" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datUnfix_allowance_popup" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,15" function="hr_sel_10030008_UNFIX_ALLOW_POPUP"> 
                <input bind="idGrid" >
                    <input bind="idtxtEmp_id" />
                    <input bind="lstAll_kind" />
                    <input bind="lstRule_kind" />
                    <input bind="dtWMonth" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:5%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=2 style="width:10%" >Emp ID</td>
		            <td align=right colspan=3 style="width:15%"><gw:textbox id="idtxtEmp_id" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>
                    <td align=right colspan=2 style="width:15%">Allowance Name</td>
		            <td align=left colspan=2 style="width:10%"><gw:list id="lstAll_kind"  value="ALL" styles='width:100%'><data><%=ESysLib.SetListDataSQL("SELECT kind,name FROM THR_ALLOWANCE_MASTER WHERE DEL_IF = 0 order by KIND")%>|ALL|Select All</data></gw:list></td>
		            <td align=right colspan=2 style="width:10%">Rule Name</td>
		            <td align=right colspan=3 style="width:15%"><gw:list id="lstRule_kind" onchange="onChange_rule()"  value="ALL" styles='width:100%'><data>|1|Time Rule|2|Absence Rule|3|Contract Rule|4|Status Rule|5|Discipline Rule|6|Work Day Rule|7|Work Mon Rule|8|Employee Type Rule|9|Progressvie Rule|10|Probation Rule</data></gw:list></td>
		            <td align=right colspan=2 style="width:10%">Work Month</td>
		            <td align=right colspan=2 style="width:10%"><gw:datebox id="dtWMonth"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type="month" onchange="onChangeMonth()" /></td>
                </tr>	
	        </table>
	        <table id="tblMain" style="width:100%;height:95%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Emp ID|Full Name|Join Date|column 1|column 2|column 3|column 4|column 5|column 6|column 7"   
				        format="0|0|0|0|0|0|0|0|0|0"  
				        aligns="0|0|0|0|0|0|0|0|0|0"  
				        defaults="|||||||||"  
				        editcol="1|0|0|0|0|0|0|0|0"  
				        widths="1500|3000|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>

   <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="idFrom" styles="display:none"/>
    <gw:textbox id="idTo" styles="display:none"/>
    <gw:textbox id="txtTMP" styles="display:none"/>
    
</body>
</html>

