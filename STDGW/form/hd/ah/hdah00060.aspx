<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<head>
    <title>General Info - Employee</title>

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
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 1 ,  "select pk, workgroup_nm from thr_work_group where del_if=0") %>; //group         
    onClickOption(1);
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
   }/**/
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
        document.LateEarly.option_P[0].checked=true;
    }
    else if(num==2)
    {
        txtFrom.text=FromDT.value;
        txtTo.text=ToDT.value;
        document.LateEarly.option_P[1].checked=true;
    }
    else if(num==3)
    {
        txtFrom.text=dtMonth.value+"01";
        txtTo.text=dtMonth.value+"31";
        document.LateEarly.option_P[2].checked=true;
    }
    else
    {
        txtFrom.text=dtYear.value+"0101";
        txtTo.text=dtYear.value+"1231";
        document.LateEarly.option_P[3].checked=true;
    }
    //alert(txtFrom.text + " *** " +  txtTo.text);
} 

function kuminhCellClick()
{
    var row=idGrid.row;
    var col=idGrid.col;
    //alert(idGrid.GetGridData(row,col));
    if(col>3)
    {
        if(idGrid.GetGridData(row,col)>0)
        {
            var url='/form/hd/ah/hdah00060_01.aspx?emp_pk='+idGrid.GetGridData(row,7)+'&from_dt='+txtFrom.text+'&to_dt='+txtTo.text;
            url += '&col=' + col;
            var arr;
	        arr = System.OpenModal( System.RootURL + url , 800 , 600 , 'resizable:no;status:yes') ;
	    }
    }
}
function OnReport(num)
{    
    if(num==1)
    {
        var url= System.RootURL + '/reports/hd/ah/rpt_employee_late_early.aspx';
        url += '?p_from=' + txtFrom.text;
        url += '&p_to=' + txtTo.text;
        url += '&p_tco_org_pk=' + lst_Org.value;
        url += '&p_wg=' + lstWG.value;
        url += '&p_lsttmp=' + lstTmp.value;
        url += '&p_txttmp=' + txtTmp.text;
        url += '&p_lststatus=' + lstStatus.value;
        window.open(url);
    }
    if(num==2)
    {
        var pk_list=""; 
        var row=idGrid.row;
        if(row==-1)
        {
            alert("Please choose employee in grid to print details");
            return;
        }
        var c=idGrid.GetGridControl();        
        for(var i=0; i<c.SelectedRows;i++)
        {  
            var r = c.SelectedRow(i);                      
            pk_list += idGrid.GetGridData(r,7) + "," ;            
        }      
		if(pk_list=="")
		{
			alert("Please choose employee in grid to print details");
            return;
		}
        var url= System.RootURL + '/reports/hd/ah/rpt_employee_late_early_detail.aspx?emp_pk=' + pk_list ;
        url += '&from_dt=' + txtFrom.text + '&to_dt=' + txtTo.text + '&lstStatus=' + lstStatus.value;
        window.open(url);
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
            <dso  type="grid"  parameter="0" function="HR_SEL_70010006" > 
                <input bind="idGrid" >
                    <input bind="txtFrom" />
                    <input bind="txtTo" />
                    <input bind="lst_Org" />
                    <input bind="lstWG" />
                    <input bind="lstTmp" />
                    <input bind="txtTmp" />
                    <input bind="lstStatus" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<form name="Late in Early out" id="LateEarly" > 
   <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	        <tr style="height:6%;border:1">	
		        <td colspan=2 align=right style="width:10%;border:1;color=Black" ><input type="radio" name="option_P" value="1" checked onclick="onClickOption(1)" ><font size=2>Daily</font></td>
		        <td colspan=2 align=right style="width:10%;border:1"><gw:datebox id="DailyDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onClickOption(1)" /></td>
		        <td colspan=2 align=right style="width:5%;border:0"><input type="radio" name="option_P" value="2" onclick="onClickOption(2)" ><font size=2>From</font></td>
		        <td colspan=1 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="onClickOption(2)"/></td>
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
                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
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
                <td colspan=1 align=right style="width:8%;border:0">
		            <gw:list  id="lstTmp"  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        |1|Emp ID|2|Name|3|Card Num
                    </data>
                    </gw:list>
                </td>
                <td colspan=2 align=right style="width:10%;border:0">
		            <gw:textbox  id="txtTmp"  maxlen = "40" styles='width:100%' onenterkey="OnSearch()"  >
                    
                    </gw:textbox>
                </td>
                <td colspan=2 align=right style="border:1" >
                   Status &nbsp;
                </td>
                <td colspan=2 align=left style="border:1" >
                    <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
                </td>
		        <td colspan=2 align=center style="width:5%;border:0" >
		            <font size=2><i><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></font>
		        </td>
		        <td align=center style="width:3%;border:0" >
		            <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
		        </td>
		        <td align=center style="width:3%;border:0" >
		            <gw:imgBtn id="ibtnRptAll" alt="Report All" img="excel" text="Report" onclick="OnReport(1)" />
		        </td>
                <td align=center style="width:3%;border:0" >
		            <gw:imgBtn id="ibtnRpt" alt="Report Details" img="excel" text="Report" onclick="OnReport(2)" />
		        </td>
		        
            </tr>	
        
	    </table>
	    <table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		    <tr style="height:100%">
			    <td id="master" width="100%">
				    <gw:grid
					    id="idGrid"
					    header="ORG NAME|WGROUP|EMP ID|NAME|LATE IN|EARLY OUT|NONE SCAN CARD|_EMP_PK"
					    format="0|0|0|0|1|1|1|1"
					    aligns="0|0|0|0|1|1|1|1"
					    editcol="0|0|0|0|0|0|0|0"
					    widths="0|3000|1500|3000|2000|2000|2000|0"
					    styles="width:100%;height:100%"
					    sorting="T"
					    oncellclick = ""
					    oncelldblclick="kuminhCellClick()"
					    />
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
</body>
</html>
