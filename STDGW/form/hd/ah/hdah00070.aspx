<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<head>
    <title>Change Group</title>

    <script>
 //---------------------------------------------------------
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var flag=0;
var main_col=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";   
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    else
        lst_Org.value="ALL";
    <%=ESysLib.SetGridColumnComboFormat( "idGridChange" , 2 ,  "SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by  workGroup_NM") %>; //group         
    onClickOption(1);
    idGrid.GetGridControl().ScrollTrack = true;
 }
 
 
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {      
        //datGroupData.Call();
   }
   if (obj.id=="datGroupData")
   {
        lstWG.SetDataText(txtGroupData.text);
        var obj=lstWG.GetControl();
        if (obj.options.length ==2)
		    obj.options.selectedIndex=0;
	    else
		    obj.options.selectedIndex=obj.options.length-1;/**/
   }
   if (obj.id=="datEmp")
   {
        idRecord.text= idGrid.rows-1 + " record(s)";
   }
    
}
 //---------------------------------------------------------
function OnSearch()
{
    datEmp.Call("SELECT");
}
 
function OnChangeDept(depObj)
{
    txtDeptData.text=depObj.value;
    //datGroupData.Call();
}

function onClickOption(num)
{
    if(num==1)
    {
        txtFrom.text=DailyDT.value;
        txtTo.text=DailyDT.value;
        DailyDT.SetEnable(1);
        FromDT.SetEnable(0);
        ToDT.SetEnable(0);
        dtMonth.SetEnable(0);
        dtYear.SetEnable(0);
    }
    else if(num==2)
    {
        txtFrom.text=FromDT.value;
        txtTo.text=ToDT.value;
        DailyDT.SetEnable(0);
        FromDT.SetEnable(1);
        ToDT.SetEnable(1);
        dtMonth.SetEnable(0);
        dtYear.SetEnable(0);
    }
    else if(num==3)
    {
        txtFrom.text=dtMonth.value+"01";
        txtTo.text=dtMonth.value+"31";
        DailyDT.SetEnable(0);
        FromDT.SetEnable(0);
        ToDT.SetEnable(0);
        dtMonth.SetEnable(1);
        dtYear.SetEnable(0);
    }
    else
    {
        txtFrom.text=dtYear.value+"0101";
        txtTo.text=dtYear.value+"1231";
        DailyDT.SetEnable(0);
        FromDT.SetEnable(0);
        ToDT.SetEnable(0);
        dtMonth.SetEnable(0);
        dtYear.SetEnable(1);
    }
} 


function OnReport(num)
{    
    if (num == 1)
    {
        var url= System.RootURL + '/reports/hd/ah/rpt_change_group_list.aspx';
        url += '?p_from=' + txtFrom.text;
        url += '&p_to=' + txtTo.text;
        url += '&p_tco_org_pk=' + lst_Org.value;
        url += '&p_wg=' + lstWG.value;
        url += '&p_lsttmp=' + lstTmp.value;
        url += '&p_txttmp=' + txtTmp.text;
        window.open(url);
    }
    else
    {
        var url= System.RootURL + '/reports/hd/ah/rpt_change_group_list_detail.aspx';
        url += '?&p_from=' + txtFrom.text + '&p_to=' + txtTo.text
        url += '&p_tco_org_pk=' + lst_Org.value;
        url += '&p_wg=' + lstWG.value;
        url += '&p_lsttmp=' + lstTmp.value;
        url += '&p_txttmp=' + txtTmp.text;
        window.open(url);
    }
}

function LoadChangeGroup()
{
    if (idGrid.rows-1 > 0)
   {
        txtEmp_PK.text=idGrid.GetGridData(idGrid.row,5);
        //alert(txtEmp_PK.text);
        datLoadChangeGroup.Call("SELECT");
    }
}
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        lst_Org.value=obj
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
    
}

</script>

</head>
<body>
 <gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lst_Org" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                   <input bind="txtDeptData" />
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR_SEL_70010007" > 
                <input bind="idGrid" >
                    <input bind="lst_Org" />
                    <input bind="lstWG" />
                    <input bind="lstTmp" />
                    <input bind="txtTmp" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datLoadChangeGroup" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR_SEL_70010007_1" > 
                <input bind="idGridChange" >
                    <input bind="txtEmp_PK" />
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                </input>
                <output  bind="idGridChange" />
            </dso> 
        </xml> 
</gw:data>

<form name="Change Group" id="ChangeGroup" > 
   <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	        <tr style="height:6%;border:1">	
		        <td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font size=2>Daily</font></td>
		        <td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onClickOption(1)" /></td>
		        <td colspan=2 align=right style="width:10%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=2>From</font></td>
		        <td colspan=1 align=right style="width:5%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onClickOption(2)"/></td>
		        <td align=right style="width:5%;border:0"><font size=2>To</font> </td>
		        <td colspan=2 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onClickOption(2)"/></td>
                <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="3" onclick="onClickOption(3)" ><font size=2>Month</font> </td>
		        <td align=left colspan=2 style="width:10%;border:0"><gw:datebox id="dtMonth"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=month onchange="onClickOption(3)"/></td>
		        <td align=right colspan=2 style="width:10%;border:0"><input type="radio" name="option_P" value="4" onclick="onClickOption(4)" ><font size=2>Year</font> </td>
		        <td align=left colspan=2 style="width:10%;border:0"><gw:datebox id="dtYear"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" type=year onchange="onClickOption(4)"/></td>
		        <td align=right valign="bottom" style="width:5%;border:0" >&nbsp;</td>
            </tr>	
            <tr style="height:6%;border:1">	                
                <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF"><font size=2>Organization</font></a></td>
		        <td colspan=3 align=right style="width:20%;border:0">
		            <gw:list  id="lst_Org"  maxlen = "100" styles='width:100%' onchange="" >
                    <data>
                        <%= ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td colspan=1 align=right style="width:5%;border:0">
		            <font size=2>WGroup</font>
                </td>
                <td colspan=1 align=right style="width:10%;border:0">
		            <gw:list  id="lstWG" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td colspan=1 align=right style="width:8%;border:0">
		            <font size=2>Search by</font>
                </td>
                <td colspan=1 align=right style="width:5%;border:0">
		            <gw:list  id="lstTmp"  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        |1|Emp ID|2|Name|3|Card Num
                    </data>
                    </gw:list>
                </td>
                <td colspan=1 align=right style="width:8%;border:0">
		            <gw:textbox  id="txtTmp"  maxlen = "40" styles='width:100%' onenterkey="OnSearch()"  >
                    </gw:textbox>
                </td>
                <td colspan=3 align=center style="width:50%;border:1;color='red'" >
                    <font size=2><i><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></font>
                </td>
                <td colspan=3 align=right style="width:5%;border:0">
                    <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
                </td>
		        <td align=center style="width:5%;border:0" >
		            <gw:imgBtn id="ibtnRptAll" alt="Report Employee Change List" img="excel" text="Report" onclick="OnReport(1)" />
		        </td>
		        <td align=left style="width:5%;border:0" >
		            <gw:imgBtn id="ibtnRptAll" alt="Report Detail" img="excel" text="Report" onclick="OnReport(2)" />
		        </td>
            </tr>	
        
	    </table>
	    <table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		    <tr style="height:100%">
			    <td id="master" width="55%">
				    <gw:grid
					    id="idGrid"
					    header="Organization|EMP ID|FULL NAME|JOIN DATE|CHANGE|_EMP_PK"
					    format="0|0|0|1|1|1"
					    aligns="0|0|0|1|1|1"
					    editcol="0|0|0|0|0|0"
					    widths="2500|1500|3000|2000|1000|0"
					    styles="width:100%;height:100%"
					    sorting="T"
					    oncellclick = "LoadChangeGroup();"
					    oncelldblclick=""
					    />
			    </td>
			    <td id="detail" width="45%">
				    <gw:grid
					    id="idGridChange"
					    header="_EMP_PK|DATE CHANGE|OLD WGROUP|NEW WGROUP"
					    format="0|0|0|0"
					    aligns="0|0|0|0"
					    defaults="||||"
					    editcol="0|0|1|1"
					    widths="0|2000|3000|3000"
					    styles="width:100%;height:100%"
					    sorting="T"
					    oncelldblclick = ""/>
			</td>
		    </tr>	
	    </table>
	    
	    
</table>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtFrom" styles="display:none"/>
    <gw:textbox id="txtTo" styles="display:none"/>
    <gw:textbox id="txtSearchType" styles="display:none"/>
    <gw:textbox id="txttest" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtEmpType" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>     
</body>
</html>
