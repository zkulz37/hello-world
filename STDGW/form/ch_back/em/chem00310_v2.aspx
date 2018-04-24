<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBO Plan checking</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var data;
var v_language = "<%=Session("SESSION_LANG")%>";

var c_sel=0;
var c_eva_type=3,c_emp_id=4,c_full_name=5;
var c_Manager_L1=8,c_Manager_L2=10,c_Manager_L3=12;
var c_close_yn=14,c_eva_emp_pk=15,c_factor_type=16,c_action=17,c_self_status=18,c_hr_status=19,c_m1_status=20,c_m2_status=21,c_m3_status=22,c_data_close=23;
var check_init=0;



function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);

    idGrid.FrozenCols =6;
    onBindData();

}

function onBindData() 
{
   
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);

    data = "<%=ESysLib.SetListDataSQL("select a.code,a.code||'-'||a.CODE_NM from vhr_hr_code a where a.id='HR0219' order by seq")%>";
    lstFactor_type.SetDataText(data+"|ALL|Select All");
    lstFactor_type.value="ALL";
    

    data = "<%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00310_v2' order by seq")%>";
    lstReportType.SetDataText(data);

    datchem00310_v2_00.Call();

    

}


function OnSearch()
{
    if(check_init==1)
        dso_chem00310_v2_1.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datchem00310_v2_00")
    {
        var ctrl=idGrid.GetGridControl();
        var numLevel=Number(txtNumOfLevel.text);
        for(i=c_Manager_L1;i<=c_Manager_L3+1;i++)
                    ctrl.ColHidden(i)=0;
       
        for(i=c_Manager_L1+numLevel*2;i<=c_Manager_L3+1;i++)
                    ctrl.ColHidden(i)=1;
      
        datchem00310_v2_lst.Call();
    }
    if(obj.id=="dso_chem00310_v2_1")
    {
        lblRecord.text=idGrid.rows-1 +"(s)";
        auto_resize_column(idGrid,0,c_factor_type,8);
    }
    if(obj.id=="datchem00310_v2_lst")
    {
        lstEvaluationGrp.SetDataText(txtEvaGrp.text+"|ALL|Select All");
        lstEvaluationGrp.value="ALL";
        datchem00310_v2_level.Call();
    }
    if(obj.id=="datchem00310_v2_level")
    {
        lstManager.SetDataText(txtLevel.text+"|0|0-Self Eva|HR|HR Eva");
        lstManager.value="0";

        lstManager2.SetDataText(txtLevel.text); 
        check_init=1;
    }
    if(obj.id=="dso_chem00310_v2_2")
    {
        alert(txtResult.text);
        dso_chem00310_v2_1.Call("SELECT");

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
				url = url + "&p2=" + lstFactor_type.value + "&p3=" + lstManager.value ;
				url = url + "&p4=" + lstMConfirm.value + "&p5=" + lstEmp.value + "&p6=" + lstEmp_Search.text ;
				url = url + "&p7=" + lstManager2.value + "&p8=" + lstMan_Search_by.value + "&p9=" + txtMan_search_tmp.text ;
				url = url + "&p10=" + lstMan_Search_by.text;
			    window.open(url, "_blank");

              
}  

function OnChangeEvaPeriod()
{
    datchem00310_v2_00.Call();
}



function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}

function onValidate(p_action)
{
var p_result=true;
//var c_Manager_L1=8,c_Manager_L2=10,c_Manager_L3=12;
//,c_self_status=18,c_hr_status=19,c_m1_status=20,c_m2_status=21,c_m3_status=22;
    var ctrl = idGrid.GetGridControl();
    var l_factor_type;
    var l_self_status,l_hr_status,l_m1_status,l_m2_status,l_m3_status;
    var l_emp_name;
    if(p_action=="CLOSE")
    {
        for ( var i =  1 ; i < ctrl.rows ; i++ )
        {
            if(idGrid.GetGridData(i,c_sel)=="-1")
            {
			    l_factor_type=idGrid.GetGridData(i,c_factor_type);
                var c_eva_type=3,c_emp_id=4,c_full_name=5;
                l_emp_name=idGrid.GetGridData(i,c_eva_type)+"-"+idGrid.GetGridData(i,c_emp_id)+"-"+idGrid.GetGridData(i,c_full_name);

                 l_self_status=idGrid.GetGridData(i,c_self_status);
                    l_hr_status=idGrid.GetGridData(i,c_hr_status);
                    if(idGrid.GetGridData(i,c_Manager_L1)=="")//ko danh gia
                        l_m1_status="60";//coi nhu confirm
                    else
                        l_m1_status=idGrid.GetGridData(i,c_m1_status);

                    if(idGrid.GetGridData(i,c_Manager_L2)=="")//ko danh gia
                        l_m2_status="80";//coi nhu confirm
                    else
                        l_m2_status=idGrid.GetGridData(i,c_m2_status);

                    if(idGrid.GetGridData(i,c_Manager_L3)=="")//ko danh gia
                        l_m3_status="100";//coi nhu confirm
                    else
                        l_m3_status=idGrid.GetGridData(i,c_m3_status);

                if(l_factor_type=="01")//MBO
                {
                   // alert(l_self_status);
                   // alert(l_m1_status);
                   // alert(l_m2_status);
                   // alert(l_m3_status);
                    if(l_self_status!="40" ||l_m1_status!="60" ||l_m2_status!="80" ||l_m3_status!="100")
                    {
                        if(confirm("All manager not yet confirm. Do you want to force Close for: "+l_emp_name))
                            p_result=true;
                        else
                            p_result=false;
                    }
                    else
                        p_result=true;
                }
                else if(l_factor_type=="02")//CAPA
                {
                    if(l_m1_status!="60" ||l_m2_status!="80" ||l_m3_status!="100")
                    {
                        if(confirm("All manager not yet confirm. Do you want to force Close for: "+l_emp_name))
                            p_result=true;
                        else
                            p_result=false;
                    }
                }
                else if(l_factor_type=="03")//hr
                {
                    if(l_hr_status!="120")
                    {
                        if(confirm("All manager not yet confirm. Do you want to force Close for: "+l_emp_name))
                            p_result=true;
                        else
                            p_result=false;
                    }
                }
            }
        }
    }
    else if(p_action=="OPEN")
    {
        p_result=true;
    }
    
    return p_result;
}

function OnAction(p_action)
{
    var ctrl = idGrid.GetGridControl();
    var p_validate=false;
    if(ctrl.rows>1)
    {
        for ( var i =  1 ; i < ctrl.rows ; i++ )
        {
            if(idGrid.GetGridData(i,c_data_close)=="Y")
            {
                alert("Period Data is Closed. You can not do any thing.");
                return;
            }    
            if(idGrid.GetGridData(i,c_sel)=="-1")
            {
			    idGrid.SetGridText(i,c_action,p_action);
                p_validate=true;
            }
        }
        if(p_validate==true)
        {
            
                if(onValidate(p_action)==true)
                {
                    if(confirm("Do you want to "+p_action))
                    {
                        dso_chem00310_v2_1.Call();
                       //alert("fdafa");
                     }
                }
        }
    }
}

</script>

<body>

<gw:data id="datchem00310_v2_00" onreceive="OnDataReceive(this)"  > 
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

<gw:data id="datchem00310_v2_lst" onreceive="OnDataReceive(this)"  > 
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

<gw:data id="datchem00310_v2_level" onreceive="OnDataReceive(this)"  > 
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

<gw:data id="dso_chem00310_v2_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="hr_sel_chem00310_v2_1" procedure="hr_upd_chem00310_v2_1">  
                <input bind="idGrid">  
                    <input bind="lstEvaMaster" />
                    <input bind="lstEvaluationGrp" />
                    <input bind="lstFactor_type" />  
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
            <td colspan=10 align=right>Eva Type</td>
            <td colspan=10>
                <gw:list  id="lstFactor_type" value="ALL" styles='width:100%' onchange=""> 
							        </gw:list>
            </td>

            <td colspan=10>
                <gw:list id="lstManager" value="1" styles='width:100%' onchange="" >
                    <data>|1|Level 1|2|Level 2</data></gw:list>
            </td>
            <td colspan=10><gw:list id="lstMConfirm" value="ALL" styles='width:100%' onchange="" >
                <data>|Y|Confirm=Yes|N|Confirm=No|ALL|Confirm=All</data></gw:list>
            </td>
             <td colspan=5 align=center><gw:icon id="ibtnSearch"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
             <td colspan=5 align=center><gw:icon id="ibtnClose"  text="Close"  img="in"  styles="width:100%" onclick="OnAction('CLOSE')"/></td>
             <td colspan=5 align=center><gw:icon id="ibtnOpen"  text="Open"  img="in"  styles="width:100%" onclick="OnAction('OPEN')"/></td>
             <td colspan=5 align=center><gw:label id="lblRecord" styles="font-weight:bold; color:red; font-size: 11" text="" /></td>
            
        </tr>
        <tr style="width:100%;height:5%">
            <td colspan=2 align=right><gw:checkbox id="chkSel" value="F" onclick="OnSetGrid(chkSel,idGrid,c_sel)" ></gw:checkbox ></td>
            <td colspan=8 align=right>Employee</td>
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
                        header="V|Organization|Eva Group|Eva Type|Emp ID|Full Name|Self Satus|HR Status|Manager L1|L1 Status|Manager L2|L2 Status|Manager L3|L3 Status|Close YN|_Eva_emp_pk|_Factor Type|_Action|_self status|_hr_status|_m1 status|_m2 status|_m3 status|_period close" 
                        format="3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|1|0|1|0|1|1|1|1|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="500|2000|1200|1500|1500|1500|1500|1500|3000|1500|3000|1500|3000|1500|1000|0|0|0|0|0|0|0|0|0" 
                        sorting='T' styles="width:100%; height:100%" />
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
