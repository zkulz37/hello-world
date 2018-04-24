<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Magic Working Time Report</title>
</head>
<script>
var ctlGroup;
var bChange_All=false;
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var startTime,interval_time
function BodyInit()
{ 	
    dtFrom_Date.SetEnable(false);
    dtTo_Date.SetEnable(false);
    txtResignCheck.text="<%=ESysLib.SetDataSQL("SELECT 1 FROM VHR_HR_CODE A WHERE A.ID='HR0117' AND ROWNUM=1") %>";
    /*if(txtResignCheck.text=="1")
    {
        var tmp="<%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0117'")%>";
        tmp+="|ALL|Select All";
        lstTimes.SetDataText(tmp);
    }
    else
        lstTimes.SetDataText("|ALL|Select All");        
    /**/
    //idTimes.style.display   = 'none';
    //lstTimes.style.display   = 'none';
   
    //lstTimes.value='ALL';
    if (v_language!="ENG")
        System.Translate(document);
    idemp_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
         datGet_Location_dept.Call(); 
    else
		OnChangeLocation();     
//    else
//    {
//        binit=false;
//        datGet_from_to.Call();
//    }
    
}
//------------------------------------
function OnChangeDept(objDept,objGroup)
{
    txtDept.text=objDept.value ;
    ctlGroup=objGroup;
}
//------------------------------------
function OnChangeOption(form,obj)
{
    form.optMonthReport[obj-1].checked=true;
}
//------------------------------------
function OnShowPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg_1.value=obj;
        lstOrg_2.value=obj;
        lstOrg_3.value=obj;        
        txtorg_tmp.text=obj;
        bChange_All=true;
        datWorkGroup_info.Call();
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

//------------------------------------
function OnChangeMonth()
{
    txtResult.text="";
	datGet_from_to.Call();
}
function OnChangeTimes()
{
    
        txtResult.text="";
	    datGet_from_to.Call();
	 
}

function SetDeptAll()
{
    if(txtHr_level.text=="6")
            txtDeptData.text=txtDeptData.text+"|ALL|Select All";
    bChange_All=true;
    lstOrg_1.SetDataText(txtorg_tmp.text);
    lstOrg_2.SetDataText(txtorg_tmp.text);
    lstOrg_3.SetDataText(txtorg_tmp.text);
    //txtDept.text=lstOrg_1.value;
}
//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datGet_Location_dept":
        {
               lstLocation_dept.SetDataText(txtFact_PK.text);
               //SetDeptAll();
               datUser_info.Call();
               
               break;
        }
        case "datUser_info":
        {
               SetDeptAll();
               datGet_period.Call();
               break;
        }
        case "datGet_period":
        {               
               datGet_from_to.Call();
			   
               break;
        }
        case "datDeptData":
        {
               SetDeptAll();
               break;
        }
        
		    
		case "datGet_from_to":
		{
               if(txtResult.text=="")
              {
                alert("This Month Not Register.");
                icoProcess.SetEnable(0);
              }
              else
                icoProcess.SetEnable(1);
              txtorg_tmp.text=lstLocation_dept.value;
				datWorkGroup_all.Call();  
              break;     
	    }
	    case "datWorkGroup_all":
		{
				lstWG_1.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_2.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_3.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                //lstWG_4.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_1.value='ALL';
                lstWG_2.value='ALL';
                lstWG_3.value='ALL';
                //lstWG_4.value='ALL';
				break;
		}
		 case "datProcess_WT":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 1(Working Month) completed? Continous?\n Bước 1(Bảng Công) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datProcess_OT.Call();
		        } 
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		  case "datProcess_OT":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 2(Extra Month) completed? Continous?\n Bước 2(Bảng T.Ca) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datProcess_ABS.Call();
		        } 
		        else
		            clear_Interval(idInterval);  
		    }
		    else
		    {
		        alert("Error:Step 2(Extra Month) Uncomplete.\n Lỗi: Bảng T.Ca tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		 case "datProcess_ABS":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 3(Absence Month) completed? Continous?\n Bước 3(Bảng Vắng) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datMonth_summary.Call();
		        }    
		        else
		            clear_Interval(idInterval);
		        
		    }
		    else
		    {
		        alert("Error:Step 3(Absence Month) Uncomplete.\n Lỗi: Bảng vắng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		case "datMonth_summary":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 4(Month Summary) completed.Finish ALL!\n Bước 4(Bảng tóm tắt) đã hoàn thành.Tất cả hoàn thành!"))   
		        {
		            txtResult.text='';
		            idInterval.text='Successful';
		        }    
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 4(Month Summary) Uncomplete.\n Lỗi: Bảng tóm tắt tháng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break; 
		 case "datProcess_WT_resign":   
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 1(Working Month) completed? Continous?\n Bước 1(Bảng Công) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datProcess_OT_resign.Call();
		        } 
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		 case "datProcess_OT_resign":   
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 2(Extra Month) completed? Continous?\n Bước 2(Bảng T.Ca) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datProcess_ABS_resign.Call();
		        } 
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;   
		 case "datProcess_ABS_resign":   
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 3(Absence Month) completed? Continous?\n Bước 3(Bảng Vắng) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            datMonth_summary_resign.Call();
		        } 
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;   
		 case "datMonth_summary_resign":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 4(Month Summary) completed.Finish ALL!\n Bước 4(Bảng tóm tắt) đã hoàn thành.Tất cả hoàn thành!"))   
		        {
		            txtResult.text='';
		            idInterval.text='Successful';
		        }    
		        else
		            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Step 4(Month Summary) Uncomplete.\n Lỗi: Bảng tóm tắt tháng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;       
		 case "datFind_Report":
		    {
		        
		        if (Reports.optMonthReport[0].checked)
                {
                    var url=System.RootURL+ '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_1.value + '&l_dept_nm=' + lstOrg_1.GetText() + '&l_thr_group_pk=' + lstWG_1.value + '&l_status=' + lstStatus_1.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value + '&l_nation=' + lstForeigner_1.value + '&l_SalaryPeriod=' + lstSalaryPeriod.value  ;
		        } 
		        if (Reports.optMonthReport[1].checked)
                {
                    var url=System.RootURL+ '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_2.value + '&l_dept_nm=' + lstOrg_1.GetText() + '&l_thr_group_pk=' + lstWG_2.value + '&l_status=' + lstStatus_2.value + '&l_emp_id=' + txtEmp_ID_2.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value + '&l_nation=' + lstForeigner_2.value + '&l_SalaryPeriod=' + lstSalaryPeriod.value;
		        }
                else if (Reports.optMonthReport[2].checked)
                {
                    var url =System.RootURL + '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_3.value + '&l_dept_nm=' + lstOrg_3.GetText() + '&l_thr_group_pk=' + lstWG_3.value + '&l_status=' + lstStatus_3.value + '&l_emp_id=' + txtEmp_ID_3.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value + '&l_nation=' + lstForeigner_3.value + '&l_SalaryPeriod=' + lstSalaryPeriod.value;
                }
		        window.open(url);
		    }   
		    break;
    }
	
}
//-------------------------------------------------
function on_Process()
{
    if(confirm("Working Time is processing...do you want to continous?\nHệ thống tính công bắt đầu...Bạn có muốn tiếp tục?"))
    {
        idInterval.text="";
        set_Interval(1000)
        if(lstStatus.value=='R')
            datProcess_WT_resign.Call();
        else
            datProcess_WT.Call();
    }    
}
//-------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
//------------------------------
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}
//-------------------------------
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//--------------------------------
function OnReport()
{
    if (Reports.optMonthReport[0].checked)
        txtReport_tmp.text="rpt_working_summary_ur.aspx";
    else if (Reports.optMonthReport[1].checked)
        txtReport_tmp.text="rpt_in_out_summary_ur.aspx";
    else if (Reports.optMonthReport[2].checked)
        txtReport_tmp.text="rpt_absence_month_ur.aspx";
    datFind_Report.Call();
     
}
function onChangeStatus()
{
  txtSalary.text="01";  
  if(lstStatus.value=='R')
  {
    if(txtResignCheck.text=="1")
    {   
        idTimes.style.display   = '';
        lstTimes.style.display   = '';
        lstTimes.GetControl().options.selectedIndex=0;
        txtSalary.text="02";
    }
  }  
 else
    {  
        lstTimes.value='ALL';
        txtSalary.text="01"; 
        idTimes.style.display   = 'none';
        lstTimes.style.display   = 'none';
    }
    
  txtResult.text="";
	datGet_from_to.Call();  
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
<!------------------------------------->
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="sp_pro_dept_data_all" > 
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

<!------------------------------------->
<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_from_to_2" > 
                <input>
                    <input bind="lstLocation_dept" />
                    <input bind="dtMonth" />
                    <input bind="lstSalaryPeriod" />
                </input> 
                <output>
                    <output bind="dtFrom_Date" />
                    <output bind="dtTo_Date" />
                    <output bind="txtResult" />
                    <output bind="txtProcess" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datProcess_WT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PROCESS_MONTH_WT_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstSalaryPeriod" />
                    
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datProcess_OT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PROCESS_MONTH_OT_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstSalaryPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datProcess_ABS" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PROCESS_MONTH_ABS_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstSalaryPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_MONTH_SUMMARY_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstSalaryPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--
<gw:data id="datProcess_WT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_MONTH_WT_RESIGN_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstTimes" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datProcess_OT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_MONTH_OT_RESIGN_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstTimes" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_ABS_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_MONTH_ABS_RESIGN_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstTimes" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="SP_PRO_MONTH_SUMMARY_RESIGN_UR" > 
                <input>
                    <input bind="dtMonth" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                    <input bind="lstLocation_dept" />
                    <input bind="lstTimes" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

-->
<!------------------------------------->
<!--<gw:data id="datGet_Location_dept" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="SP_PRO_GET_DEPT_PARENT" > 
                <input>
                    <input bind="idemp_pk" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data> -->
<gw:data id="datGet_Location_dept" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sp_sel_user_role2" > 
                <input>
                    <input bind="idemp_pk" /> 
                </input> 
                <output>
                    <output bind="txtFact_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="idemp_pk" />
                </input> 
                <output>
                    <output bind="txtorg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datGet_period" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_period_by_org"  > 
                <input>
                    <input bind="lstLocation_dept" />
                </input> 
                <output>
                    <output bind="lstSalaryPeriod" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datWorkGroup_all" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<form name="Reports" id="form2" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:50%"   valign="middle" border="0" >
	<tr height="30%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr>
                <td width="90%" colspan=45  align="center" valign="middle" class="topleft" style="color:#cc0066; font-size:16">DATA PROCESSING</td>
                <td width="10%" colspan=5 align="right" valign="middle" class="topright">&nbsp;</td>
            </tr>
            <tr>
                <td colspan=4  align="right" valign="middle" class="left" style="font-size:13">Location</td>
                <td colspan=10  align="left" valign="middle"  >
                            <gw:list  id="lstLocation_dept" value='ALL' maxlen = "100" styles='width:100%' ><data><%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') and nvl(a.p_pk,0)=0 order by a.pk ")%></data></gw:list> 
                 </td>
                <!--<td colspan=3  align="right" valign="middle" style="font-size:13">Status</td>
                <td colspan=4  align="left" valign="middle"  ><gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' onchange="onChangeStatus()" >
                            <data>|A|Active|R|Resign|ALL|Select All</data></gw:list> </td>     -->        
                <td colspan=4  align="right" valign="middle"  style="font-size:13"><font>Month</font></td>
                <td colspan=4  align="left" valign="middle"  ><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>" onchange="OnChangeMonth()" /> </td>
                <!--<td colspan=3  align="right" valign="middle" style="font-size:13"><b><gw:label id="idTimes" text="Times" styles="width:100%" ></gw:label></b></td>-->
                <td colspan=9  align="left" valign="middle"  ><gw:list  id="lstSalaryPeriod" value='ALL' maxlen = "100" styles='width:100%' onchange="OnChangeTimes()" ></gw:list>
                </td> 
                <td colspan=3  align="right" valign="middle"  style="font-size:13">Date</td>
                <td colspan=5  align="right" valign="middle"  ><gw:datebox id="dtFrom_Date"  text="" styles="width:100%"  lang="<%=Session("Lang")%>" /> </td>
                <td colspan=2  align="center" valign="middle"  style="font-size:13"><b >~</b></td>
                <td colspan=4  align="left" valign="middle"  ><gw:datebox id="dtTo_Date"  styles="width:100%"   lang="<%=Session("Lang")%>" /> </td>
                <td colspan=3  align="right" valign="middle" style="color=#FF3300"><gw:label id="idInterval" text="" maxlen="100" styles="width:100%" ></gw:label></td>
                <td colspan=2 align="right" valign="middle" class="right" ><gw:icon id="icoProcess" img="in" text="Process" onclick="on_Process()" /></td>
            </tr>
        </table>
      </td>      
    </tr>
    <tr height="70%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
		        <tr style="width:100%;height:7%" >
                    <td width="90%" colspan="6"  align="center" valign="middle" class="topleft"style="color:#cc0066; font-size:16">REPORT</td>
                    <td width="10%" align="right" valign="middle" class="topright"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport()" /></td>
                </tr>
			    <tr style="width:100%;height:7%"  > 
                    <td width="15%" colspan=2 align="center" class="left"  style="border-right:0"style="color:#0099cc; font-size:13">Report Name</td>
                    <td width="15%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Nation</td>
                    <td width="25%" align="center"  style="border-left:0;border-right:0"><a style="font-size:13" title="Click here to show Organization" onclick="OnShowPopup()" href="#tips">Organization</a></td>
			        <td width="20%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">WGroup</td>
			        <td width="15%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Status</td>
			        <td width="10%" align="center" class="right"  style="border-left:0"style="color:#0099cc; font-size:13">Emp ID</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  width="2%" valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" checked></td>
                    
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Working Summary</td>
                     
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstForeigner_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,1)" >
                                        <data>|01|Vietnamese|02|Other|ALL|Select All</data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,1);OnChangeDept(lstOrg_1,lstWG_1)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstWG_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
                   <td  align="center" valign="middle" style="border-left:0;border-right:0">
                            <gw:list  id="lstStatus_1" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list>
                                        </td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="OnChangeOption(document.form2,1);OnReport();" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Working Detail (IN-OUT)</td>
                      <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstForeigner_2" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,2)" >
                                        <data>|01|Vietnamese|02|Other|ALL|Select All</data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_2" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,2);OnChangeDept(lstOrg_2,lstWG_2)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstWG_2" value='ALL' maxlen = "100" styles='width:80%'  onchange="OnChangeOption(document.form2,2)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
                    <td class="center" align="center" valign="middle" style="border-left:0;border-right:0">
                        <gw:list  id="lstStatus_2" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list>
                    </td>                    
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_2" onenterkey   ="OnChangeOption(document.form2,2);OnReport(2)" styles='width:100%' /></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Absence Summary</td>
                     
                    <td  class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstForeigner_3" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,3)" >
                                        <data>|01|Vietnamese|02|Other|ALL|Select All</data>
                                        </gw:list></td>
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_3" value='ALL' maxlen = "100" styles='width:80%'onchange="OnChangeOption(document.form2,3);OnChangeDept(lstOrg_3,lstWG_3)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </gw:list></td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstWG_3" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,3)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0">
                        <gw:list  id="lstStatus_3" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list>
                    </td>                    
			        <td class="bottomright" align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_3" onenterkey   ="OnChangeOption(document.form2,3);OnReport(3)" styles='width:100%'/></td>
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
<gw:textbox id="idemp_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/> 
<gw:textbox id="txtResult" styles="display:none"/> 
<gw:textbox id="txtReport_tmp" styles="display:none"/> 
<gw:textbox id="txtProcess_YN" styles="display:none"/> 
<!-- -->
<gw:textbox id="txtSalary" styles="display:none" text="01"/> 
<gw:textbox id="txtResignTime" styles="display:none" text=""/> 
<gw:textbox id="txtResignCheck" styles="display:none" text=""/>
<gw:textbox id="txtFact_PK" styles="display:none" text=""/>
<gw:textbox id="txtorg_tmp" styles="display:none" text=""/>
<gw:textbox id="txtwg_tmp" styles="display:none" text=""/>
<gw:textbox id="txtProcess" styles="display:none"/>

</body>
</html>

