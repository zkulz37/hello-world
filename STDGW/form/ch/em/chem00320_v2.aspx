<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBO Plan checking</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var data;
var v_language = "<%=Session("SESSION_LANG")%>";

//"PK|Organization|Eva Group|Emp ID|Full Name|Eva Status|MBO Score|Capa Score|HR Score|Final Score|Final Grade|MBO Satus|HR Status
//|Capa Status|Manager L1|Manager L2|Manager L3|Close YN" 

var c_pk=0,c_org=1,c_eva_group=2,c_emp_id=3,c_full_name=4,c_eva_status=5,c_MBO_YN=6,c_mbo_score=7,c_capa_score=8,c_hr_score=9,c_final_score=10,c_final_grade=11;
var c_mbo_status=12,c_hr_status=13,c_capa_status=14,c_manager_l1=15,c_manager_l2=16,c_manager_l3=17,c_close_yn=18,c_mbo_close=19,c_hr_close=20,c_capa_close=21,c_eva_group_pk=22;
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

    data = "<%=ESysLib.SetListDataSQL("select code,code||'-'||CODE_NM from vhr_hr_code where id='HR0103' order by seq")%>";    
    lstFinalStatus.SetDataText(data+"|ALL|Select All");
    lstFinalStatus.value="ALL";

    data = "<%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00320_v2' order by seq")%>";
    lstReportType.SetDataText(data);

    datchem00320_v2_00.Call();

    

}


function OnSearch()
{
    if(check_init==1)
        dso_chem00320_v2_1.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datchem00320_v2_00")
    {
        var ctrl=idGrid.GetGridControl();
        var numLevel=Number(txtNumOfLevel.text);
        for(i=c_manager_l1;i<=c_manager_l3+1;i++)
                    ctrl.ColHidden(i)=0;
       
        for(i=c_manager_l1+numLevel;i<=c_manager_l3;i++)
                    ctrl.ColHidden(i)=1;
                    
      
        datchem00320_v2_lst.Call();
    }
    
    if(obj.id=="dso_chem00320_v2_1")
    {
        lblRecord.text=idGrid.rows-1 +"(s)";
        auto_resize_column(idGrid,0,c_capa_close,8);
    }
    if(obj.id=="datchem00320_v2_lst")
    {
        lstEvaluationGrp.SetDataText(txtEvaGrp.text+"|ALL|Select All");
        lstEvaluationGrp.value="ALL";
        datchem00320_v2_level.Call();
       
    }
    
    if(obj.id=="datchem00320_v2_level")
    {

        lstManager2.SetDataText(txtLevel.text); 
        check_init=1;
    }

    if(obj.id=="dso_chem00320_v2_2")
    {
          dso_chem00320_v2_1.Call("SELECT");
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
				url = url + "&p5=" + lstEmp.value + "&p6=" + txtEmp_Input.text ;
				url = url + "&p7=" + lstManager2.value + "&p8=" + lstMan_Search_by.value + "&p9=" + txtMan_search_tmp.text ;
				url = url + "&p10=" + lstMan_Search_by.text;
			    window.open(url, "_blank");

              
}  

function OnChangeEvaPeriod()
{
    datchem00320_v2_00.Call();
}

function OnGetResult()
{
    dso_chem00320_v2_2.Call();
}


function onPopUP()
{
    var ctrl=idGrid.GetGridControl();
    var l_col=ctrl.col;
    if(ctrl.rows>1)
    {
        if(l_col==c_emp_id || l_col==c_full_name)
        {
            var l_temp=idGrid.GetGridData(ctrl.row,c_emp_id)+"-"+idGrid.GetGridData(ctrl.row,c_full_name);
            var path = System.RootURL + '/form/ch/em/chem00320_v2_01.aspx?p_eva_emp_pk='+idGrid.GetGridData(ctrl.row,c_pk)+'&p_emp_name='+encodeURI(l_temp);
            var object = System.OpenModal(path ,1200 , 500 , 'resizable:yes;status:yes',window);
        }
        else if(l_col==c_final_score || l_col==c_final_grade)
        {
            
            var l_temp=idGrid.GetGridData(ctrl.row,c_emp_id)+"-"+idGrid.GetGridData(ctrl.row,c_full_name);
            var l_eva_group_pk=idGrid.GetGridData(ctrl.row,c_eva_group_pk);
            var l_group_kind=idGrid.GetGridData(ctrl.row,c_MBO_YN);
            if(l_group_kind=="Y")
                l_group_kind="1";
            else
                l_group_kind="2";
            
            var path = System.RootURL + '/form/ch/em/chem00040_v2.aspx?p_pop_up=Y'+'&p_eva_master_pk='+lstEvaMaster.value+'&p_eva_group='+l_eva_group_pk+'&p_grade_kind='+l_group_kind;
            var object = System.OpenModal(path ,900 , 400 , 'resizable:yes;status:yes',window);
        }
    }
       
}


</script>

<body>

<gw:data id="datchem00320_v2_00" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00001_V2" > 
                <input>
                    <input bind="lstEvaMaster"/>  
                </input> 
                <output>
                    <output bind="txtNumOfLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00320_v2_level" onreceive="OnDataReceive(this)"  > 
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

<gw:data id="datchem00320_v2_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
                <input>
                    <input bind="lstEvaMaster"/> 
                </input> 
                <output>
                    <output bind="txtEvaGrp" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="dso_chem00320_v2_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0" function="hr_sel_chem00320_v2_1" procedure="">  
                <input bind="idGrid">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstEvaluationGrp" />
                    <input bind="lstFinalStatus" />
                    <input bind="txtGrade_Input" />
                    <input bind="lstEmp" />
                    <input bind="txtEmp_Input" />
                    <input bind="lstManager2" />
                    <input bind="lstMan_Search_by" />
                    <input bind="txtMan_search_tmp" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

<gw:data id="dso_chem00320_v2_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00320_v2_2" > 
                <input>
                    <input bind="lstEvaMaster"/>  
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
            <td colspan=10 align=right>Final Status</td>
            <td colspan=10>
                <gw:list id="lstFinalStatus" styles='width:100%' onchange="" />
            </td>
            <td colspan=10 align=right>Final Grade</td>
            <td colspan=10 align=right><gw:textbox id="txtGrade_Input" styles='width:95%' onenterkey="OnSearch()" /></td>
           
             <td colspan=5 align=center><gw:icon id="ibtnSearch"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
             <td colspan=5 align=center><gw:icon id="ibtnOpen"  text="Get Result"  img="in"  styles="width:100%" onclick="OnGetResult()"/></td>
             <td colspan=10 align=center><gw:label id="lblRecord" styles="font-weight:bold; color:red; font-size: 13" text="" /></td>
            
        </tr>
        <tr style="width:100%;height:5%">
            <td colspan=10 align=right>Employee</td>
            <td colspan=10>
                <gw:list  id="lstEmp" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=20 align=right><gw:textbox id="txtEmp_Input" styles='width:95%' onenterkey="OnSearch()" /></td>
            
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
                        header="_PK|Organization|Eva Group|Emp ID|Full Name|Eva Status|MBO YN|MBO|Capa|HR|F-Score|F-Grade|MBO Satus|HR Status|Capa Status|Manager L1|Manager L2|Manager L3|Period Close|MBO Close|HR Close|Capa Close|_Eva_group_pk" 
                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="||||||||||||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0"
                        sorting='T' styles="width:100%; height:100%" 
                        oncelldblclick="onPopUP()"
                        />
                </td>
            </tr>
    </table>


</body>
<gw:textbox id="txtEvaGrp" style="display:none" />
<gw:textbox id="txtLevel" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtAction" style="display:none" />
<gw:textbox id="txtNumOfLevel" style="display:none" />
</html>
