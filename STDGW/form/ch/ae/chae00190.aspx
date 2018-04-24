<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var ctlGroup;
var bChange_All=false;
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var startTime,interval_time
function BodyInit()
{ 	
    if (v_language!="ENG")
        System.Translate(document);
}

//------------------------------------
function OnChangeOption(form,obj)
{
    form.optMonthReport[obj-1].checked=true;
}
//------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:360;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstDept_Code_1.value=obj;
        lstDept_Code_2.value=obj;
        lstDept_Code_3.value=obj;
    }
    
}

//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    var obj;
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//------------------------------------


function SetDeptAll()
{
    if(txtHr_level.text=="6")
            txtDeptData.text=txtDeptData.text+"|ALL|Select All";
    bChange_All=true;
    lstDept_Code_1.SetDataText(txtDeptData.text);
    lstDept_Code_2.SetDataText(txtDeptData.text);
    lstDept_Code_3.SetDataText(txtDeptData.text);
    txtDept.text=lstDept_Code_1.value;
    
}
//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datDeptData":
        {
               SetDeptAll();
               break;
        }
		    case "datFind_Report":
		    {
		        if (Reports.optMonthReport[0].checked)
                {
                    var url=System.RootURL+ '/reports/ch/ae/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstDept_Code_1.value + '&l_dept_nm=' + lstDept_Code_1.GetText() + '&l_thr_group_pk=' + lstGrp_Code_1.value + '&l_status=' + lstStatus_1.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value ;
		        } 
		        if (Reports.optMonthReport[1].checked)
                {
                    var url=System.RootURL+ '/reports/ch/ae/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstDept_Code_2.value + '&l_dept_nm=' + lstDept_Code_2.GetText() + '&l_thr_group_pk=' + lstGrp_Code_2.value + '&l_status=' + lstStatus_1.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value ;
		        }
                else if (Reports.optMonthReport[2].checked)
                {
                    var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text+ '?l_tco_dept_pk=' + lstDept_Code_3.value + '&l_dept_nm=' + lstDept_Code_3.GetText() + '&l_thr_group_pk=' + lstGrp_Code_3.value+ '&l_emp_id=' + txtEmp_ID_3.text + '&l_work_mon=' + dtMonth.value ;
                }
		        else if (Reports.optMonthReport[3].checked)
                {
                    var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text+ '?l_emp_type=' + lstEmp_Type.value + '&l_work_mon=' + dtMonth.value ;
                }
		        window.open(url);
		    }   
		    break;
    }
	
}

//--------------------------------
function OnReport()
{
    if (Reports.optMonthReport[0].checked)
    {
        txtReport_tmp.text="rpt_new_workers.aspx";
        datFind_Report.Call();
    } 
    //    var url =System.RootURL + '/reports/ch/ba/rpt_working_summary.aspx?l_tco_dept_pk=' + lstDept_Code_1.value + '&l_dept_nm=' + lstDept_Code_1.GetText() + '&l_thr_group_pk=' + lstGrp_Code_1.value + '&l_status=' + lstStatus_1.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value ;
    else if (Reports.optMonthReport[1].checked)
    {
        txtReport_tmp.text="rpt_extension_contract.aspx";
        datFind_Report.Call();
    }
    else if (Reports.optMonthReport[2].checked)
    {
        txtReport_tmp.text="rpt_resigned_workers.aspx";
        datFind_Report.Call();
        
    }
    else if (Reports.optMonthReport[3].checked)
    {
        txtReport_tmp.text="rpt_labor_using.aspx";
        datFind_Report.Call();
        
    } 
}
</script>
<style type="text/css">
<!--
.textColor {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	color: #FFFFFF;
	font-weight: bold;
	font-size: 11px;
}
-->
</style>

<style>
.top { border-top:1px solid #034D72; }
.topright { border-top :1px solid #034D72;
			border-right: 1px solid #034D72;;padding-right:10px
			}
.topleft {border-left:1px solid #034D72; 
			border-top :1px solid #034D72;
			}
.left { border-left:1px solid #034D72; }
.right { border-right:1px solid #034D72;padding-right:10px }
.bottomright { border-bottom:1px solid #034D72; 
				border-right:1px solid #034D72; padding-right:10px
				}
.bottomleft { border-bottom:1px solid #034D72; 
				border-left:1px solid #034D72;;
			}
.bottom { border-bottom:1px solid #034D72; }

.topleftbottom { border-left:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }

.topbottom {border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }

.toprightbottom { border-right:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }
	
#up { background-color:#DFF2FF; }
#down { background-color:#EAEAEA; }

</style>

<body>
<!------------main control---------------------->


<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<form name="Reports" id="form2" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:50%"   valign="middle" border="0" >
	<tr height="15%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr>
                <td width="45%"  align="right" valign="middle" class="topleftbottom" style="font-size:13"><font>Month</font></td>
                <td width="55%"  align="left" valign="middle"  class="toprightbottom"><gw:datebox id="dtMonth"  text=""  style="width:60%" type="month" lang="<%=Session("Lang")%>"  /> </td>
                </tr>
        </table>
      </td>
      
    </tr>
    <tr height="90%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
		        <tr style="width:100%;height:7%" >
                    <td width="95%" colspan="5"  align="center" valign="middle" class="topleft"style="color:#cc0066; font-size:16">REPORT</td>
                    <td width="5%" align="right" valign="middle" class="topright"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport()" /></td>
                </tr>
			    <tr style="width:100%;height:7%"  > 
                    <td width="25%" colspan=2 align="center" class="left"  style="border-right:0"style="color:#0099cc; font-size:13">Report Name</td>
                    <td width="25%" align="center"  style="border-left:0;border-right:0"><a style="font-size:13" title="Click here to show organization" onclick="OnShowPopup()" href="#tips">Organization</a></td>
			        <td width="25%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Group</td>
			        <td width="16%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Status</td>
			        <td width="10%" align="center" class="right"  style="border-left:0"style="color:#0099cc; font-size:13">Emp ID</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  width="2%" valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" checked></td>
                    <td valign="middle" style="font-size:12" width="23%" style="border-left:0;border-right:0">New Workers</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_1" value='ALL' maxlen = "100" styles='width:60%' onchange="OnChangeOption(document.form2,1);OnChangeDept(lstDept_Code_1,lstGrp_Code_1)" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by nvl(a.seq,0)")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:60%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_1" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="OnChangeOption(document.form2,1);OnReport();" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Extension Contracts</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_2" value='ALL' maxlen = "100" styles='width:60%' onchange="OnChangeOption(document.form2,2);OnChangeDept(lstDept_Code_2,lstGrp_Code_2)" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by nvl(a.seq,0)")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_2" value='ALL' maxlen = "100" styles='width:60%'  onchange="OnChangeOption(document.form2,2)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_2" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_2" onenterkey   ="OnChangeOption(document.form2,2);OnReport(2)" styles='width:100%' /></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Resigned Workers</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_3" value='ALL' maxlen = "100" styles='width:60%'onchange="OnChangeOption(document.form2,3);OnChangeDept(lstDept_Code_3,lstGrp_Code_3)" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by nvl(a.seq,0)")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_3" value='ALL' maxlen = "100" styles='width:60%' onchange="OnChangeOption(document.form2,3)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_3" onenterkey   ="OnChangeOption(document.form2,3);OnReport(3)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Labour Using</td>
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0">Employee Type</td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstEmp_Type" value="ALL" onchange="OnChangeOption(document.form2,4)" styles='width:60%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list></td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0">&nbsp;</td>
			        <td class="bottomright" align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                
            </table>
	    </td>
	</tr>	
 </table>
</form>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/> 
<gw:textbox id="txtResult" styles="display:none"/> 
<gw:textbox id="txtReport_tmp" styles="display:none"/> 

</body>
</html>

