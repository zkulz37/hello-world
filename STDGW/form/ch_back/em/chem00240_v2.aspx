<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBO Plan checking</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var data;
var v_language = "<%=Session("SESSION_LANG")%>";

var c_l2_confirm=8;
var check_init=0;

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);

    onBindData();

}

function onBindData() 
{
   
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);
    
    

    data = "<%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00240_v2' order by seq")%>";
    lstReportType.SetDataText(data);
    datchem00240_v2_lst.Call();

}


function OnSearch()
{
    if(check_init==1)
        dso_chem00240_v2_1.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="dso_chem00240_v2_1")
    {
        lblRecord.text=idGrid.rows-1 +"(s)";
        auto_resize_column(idGrid,0,c_l2_confirm,0);
    }
    if(obj.id=="datchem00240_v2_lst")
    {
        lstEvaluationGrp.SetDataText(txtEvaGrp.text+"|ALL|Select All");
        lstEvaluationGrp.value="ALL";
        datchem00240_v2_level.Call();
    }
    if(obj.id=="datchem00240_v2_level")
    {
        lstManager.SetDataText(txtLevel.text);
        lstManager2.SetDataText(txtLevel.text); 
        check_init=1;
    }
    if(obj.id=="dso_chem00240_v2_2")
    {
        alert(txtResult.text);
        dso_chem00240_v2_1.Call("SELECT");

    }
    
    
        
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnReport()
{
    
   var url = System.RootURL + "/reports/ch/em/"+lstReportType.value+"?p0="+lstEvaMaster.value+ "&p1=" + lstEvaluationGrp.value ;
				url = url + "&p2=" + lstSelfConfirm.value + "&p3=" + lstManager.value ;
				url = url + "&p4=" + lstMConfirm.value + "&p5=" + lstEmp.value + "&p6=" + lstEmp_Search.text ;
				url = url + "&p7=" + lstManager2.value + "&p8=" + lstMan_Search_by.value + "&p9=" + txtMan_search_tmp.text ;
				url = url + "&p10=" + lstMan_Search_by.text;
			    window.open(url, "_blank");

              
}  

function OnChangeEvaPeriod()
{
    datchem00240_v2_lst.Call();
}

function OnAction(p_action)
{
    txtAction.text=p_action;
    if(confirm("Do you want to "+p_action+" ?"))
    {
        dso_chem00240_v2_2.Call();
    }
}

</script>

<body>


<gw:data id="datchem00240_v2_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00260_v2_lst" > 
                <input>
                    <input bind="lstEvaMaster"/> 
                </input> 
                <output>
                    <output bind="txtEvaGrp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00240_v2_level" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00000_v2_level" > 
                <input>
                    <input bind="lstEvaMaster"/> 
                </input> 
                <output>
                    <output bind="txtLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dso_chem00240_v2_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="hr_sel_chem00240_v2_1">  
                <input bind="idGrid">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstEvaluationGrp" />
                    <input bind="lstSelfConfirm" />  
                    <input bind="lstManager" /> 
                    <input bind="lstMConfirm" />
                    <input bind="lstEmp" />
                    <input bind="lstEmp_Search" />
                    <input bind="lstManager2" />
                    <input bind="lstMan_Search_by" />
                    <input bind="txtMan_search_tmp" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

<gw:data id="dso_chem00240_v2_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00240_v2_2" > 
                <input>
                    <input bind="lstEvaMaster"/>
                    <input bind="txtAction"/>
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

   <table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
        <tr style="width:100%;height:1%">
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        </tr>
        <tr style="width:100%;height:5%">
            <td colspan=10 align=right>Eva Period</td>
            <td colspan=10>
                <gw:list id="lstEvaMaster" onchange="OnChangeEvaPeriod()" styles='width:100%' />
            </td>
            <td colspan=10 align=right>Eva Group</td>
            <td colspan=10>
                <gw:list id="lstEvaluationGrp" styles='width:100%' onchange="" />
            </td>
            <td colspan=10 align=right>Self Confirm</td>
            <td colspan=10>
                <gw:list  id="lstSelfConfirm" value="ALL" styles='width:100%' onchange=""> 
							        <data>|Y|Yes|N|No|ALL|Select All</data></gw:list>
            </td>

            <td colspan=10>
                <gw:list id="lstManager" value="1" styles='width:100%' onchange="" >
                    <data>|1|Level 1|2|Level 2</data></gw:list>
            </td>
            <td colspan=10><gw:list id="lstMConfirm" value="ALL" styles='width:100%' onchange="" >
                <data>|Y|Yes|N|No|ALL|Select All</data></gw:list>
            </td>
             <td colspan=5 align=center><gw:icon id="ibtnSearch"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
             <td colspan=5 align=center><gw:icon id="ibtnClose"  text="Close"  img="in"  styles="width:100%" onclick="OnAction('CLOSE')"/></td>
             <td colspan=5 align=center><gw:icon id="ibtnOpen"  text="Open"  img="in"  styles="width:100%" onclick="OnAction('OPEN')"/></td>
             <td colspan=5 align=center><gw:label id="lblRecord" styles="font-weight:bold; color:red; font-size: 11" text="" /></td>
            
        </tr>
        <tr style="width:100%;height:5%">
            <td colspan=10 align=right>Employee</td>
            <td colspan=10>
                <gw:list  id="lstEmp" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=20 align=right><gw:textbox id="lstEmp_Search" styles='width:95%' onenterkey="OnSearch()" /></td>
            
            <td colspan=10 align=right>Manager</td>
            <td colspan=10>
                <gw:list id="lstManager2" value="1" styles='width:100%' onchange="" >
                    <data>|1|Level 1|2|Level 2</data></gw:list>
            </td>
            <td colspan=10>
                <gw:list  id="lstMan_Search_by" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=10 align=center><gw:textbox id="txtMan_search_tmp" styles='width:100%' onenterkey="OnSearch()" /></td>

            <td colspan=15 align=right><gw:list id="lstReportType" styles='width:95%' onchange="" /></td>
            <td colspan=5 align=right>
                <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport()" />
            </td>
            

        </tr>
        <tr style="height: 89%">
                <td colspan=100>
                    <gw:grid id="idGrid" 
                        header="Organization|WorkGroup|Emp ID|Full Name|Plan Confirm|Manager L1|L1 Confirm|Manager L2|L2 Confirm|_Manager L3|_L3 Confirm|Plan Close" 
                        format="0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|1|0|1|0|1|0|1|1"
                        defaults="|||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="3000|2000|1200|2000|1500|3000|1500|3000|1500|3000|1500|1000" 
                        sorting='T' styles="width:100%; height:100%" />
                </td>
            </tr>
    </table>


</body>
<gw:textbox id="txtEvaGrp" style="display:none" />
<gw:textbox id="txtLevel" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtAction" style="display:none" />
</html>
