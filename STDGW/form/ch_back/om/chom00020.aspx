<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>

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
var flag_all_wg=false;
var check_init=0;
var old_to_dt;
function BodyInit()
{ 	
    dtFrom_Date.SetEnable(false);
    //dtTo_Date.SetEnable(false); cho phep chon lai ngay to
	old_to_dt=dtTo_Date.value;
    
    var tmp="<%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM ||' ' || char_1 || '->' || char_2 from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0030' and num_1=1 ")%>";
    lstSalaryPeriod.SetDataText(tmp);        
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    menu_id.text=System.Menu.GetMenuID();

    ChangeColorItem(lstLocation_dept.GetControl());
    ChangeColorItem(lstOrg_1.GetControl());
    ChangeColorItem(lstOrg_2.GetControl());
    ChangeColorItem(lstOrg_3.GetControl());
    ChangeColorItem(lstOrg_4.GetControl());

    datCheck_View.Call();    
    
}


//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//---------------------------------------------------------------------------

function OnChangeOption(form,obj)
{
    form.optMonthReport[obj-1].checked=true;
    onChange_org(obj);
}
//------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:360;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg_1.value=obj;
        lstOrg_2.value=obj;
        lstOrg_3.value=obj;
        lstOrg_4.value=obj;
        txtorg_tmp.text=obj;
        bChange_All=true;
        datWorkGroup_info.Call();
    }    
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
            txtFact_PK.text=txtFact_PK.text+"|ALL|Select All";
    bChange_All=true;
    
    lstOrg_1.SetDataText(txtorg_tmp.text);
    lstOrg_2.SetDataText(txtorg_tmp.text);
    lstOrg_3.SetDataText(txtorg_tmp.text);
    lstOrg_4.SetDataText(txtorg_tmp.text);
    //datWorkGroup_info.Call();   
}
//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
        {
            if(txtFlag_View.text == 'Y')
            {
                icoProcess.style.display = "none";
            
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                 datGet_Location_dept.Call(); 
            else
			        OnChangeLocation();
            
        }
        break;
        case "datGet_Location_dept":
        {
               lstLocation_dept.SetDataText(txtFact_PK.text);
               datUser_info.Call();
               
               break;
        }
        case "datUser_info":
        {
               SetDeptAll();

                ChangeColorItem(lstLocation_dept.GetControl());
                ChangeColorItem(lstOrg_1.GetControl());
                ChangeColorItem(lstOrg_2.GetControl());
                ChangeColorItem(lstOrg_3.GetControl());
                ChangeColorItem(lstOrg_4.GetControl());

               datGet_period.Call();
               break;
        }
        case "datGet_period":
        {               
               datGet_from_to.Call();
			   
               break;
        } 
        case "datWorkGroup_info":       
        {
            if(document.form2.optMonthReport[0].checked==true)
            {
                
                    lstWG_1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWG_1.value='ALL';
              
            }
            if(document.form2.optMonthReport[1].checked==true)
            {
                  lstWG_2.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWG_2.value='ALL';
               
            }
            if(document.form2.optMonthReport[2].checked==true)
            {
                    lstWG_3.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWG_3.value='ALL';    
                
            }
            if(document.form2.optMonthReport[3].checked==true)
            {
               
                    lstWG_4.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                    lstWG_4.value='ALL';
               
            }
            if(bChange_All==true)
            {
                lstWG_1.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_2.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_3.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_4.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_1.value='ALL';
                lstWG_2.value='ALL';
                lstWG_3.value='ALL';
                lstWG_4.value='ALL';
                //alert(txtwg_tmp.text);
            }
            bChange_All=false;
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
				
			 if(flag_all_wg==false)
			 {
				txtorg_tmp.text=lstLocation_dept.value;
				datWorkGroup_all.Call();
				flag_all_wg=true;
			 }	
			 old_to_dt=dtTo_Date.value; //luu lai ngay to cu
			 check_init=1;
              break;     
	    }
		case "datWorkGroup_all":
		{
				lstWG_1.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_2.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_3.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_4.SetDataText(txtwg_tmp.text+ "|ALL|Select All");
                lstWG_1.value='ALL';
                lstWG_2.value='ALL';
                lstWG_3.value='ALL';
                lstWG_4.value='ALL';
				break;
		}
		case "datProcess_WT":  
		    if(txtResult.text=='0')
		    {
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 2 is processing...";
		        datProcess_OT.Call();
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
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 3 is processing...";
		        datProcess_ABS.Call();
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
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 4 is processing...";
		        datMonth_summary.Call();
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
		        txtResult.text='';
                alert("All Tasks finish.\n Tất công đoạn đã hoàn thành.")
		        idstatus_process.text="All Tasks finish.";
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
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 2 is processing...";
		        datProcess_OT_resign.Call();
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
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 3 is processing...";
		        datProcess_ABS_resign.Call();
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
		        txtResult.text='';
		        clear_Interval(idInterval);
                idstatus_process.text="Task 4 is processing...";
		        datMonth_summary_resign.Call();
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
		        txtResult.text='';
                alert("All Tasks finish.\n Tất công đoạn đã hoàn thành.")
		        idstatus_process.text="All Tasks finish.";
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
                    var url=System.RootURL+ '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_1.value + '&l_dept_nm=' + lstOrg_1.GetText() + '&l_thr_group_pk=' + lstWG_1.value + '&l_status=' + lstStatus_1.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value+ '&l_nation=' + lstNation_1.value+'&l_SalaryPeriod='+lstSalaryPeriod.value  + '&l_lstEmpID=' + txtlstEmpID.text;
		        } 
		        if (Reports.optMonthReport[1].checked)
                {
                    var url=System.RootURL+ '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_2.value + '&l_dept_nm=' + lstOrg_2.GetText() + '&l_thr_group_pk=' + lstWG_2.value + '&l_status=' + lstStatus_2.value + '&l_emp_id=' + txtEmp_ID_2.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value+ '&l_nation=' + lstNation_2.value+'&l_SalaryPeriod='+lstSalaryPeriod.value + '&l_lstEmpID=' + txtlstEmpID.text;
		        } 
                else if (Reports.optMonthReport[2].checked)
                {
                    var url =System.RootURL + '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_3.value + '&l_dept_nm=' + lstOrg_3.GetText() + '&l_thr_group_pk=' + lstWG_3.value + '&l_status=' + lstStatus_3.value + '&l_emp_id=' + txtEmp_ID_3.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value+ '&l_nation=' + lstNation_3.value +'&l_SalaryPeriod='+lstSalaryPeriod.value  + '&l_lstEmpID=' + txtlstEmpID.text;
                }
                else if (Reports.optMonthReport[3].checked)
                {
                    var url =System.RootURL + '/reports/ch/om/' + txtReport_tmp.text + '?l_tco_dept_pk=' + lstOrg_4.value + '&l_dept_nm=' + lstOrg_4.GetText() + '&l_thr_group_pk=' + lstWG_4.value + '&l_status=' + lstStatus_4.value + '&l_emp_id=' + txtEmp_ID_4.text + '&l_work_mon=' + dtMonth.value + '&l_from_dt=' + dtFrom_Date.value + '&l_to_dt=' + dtTo_Date.value+ '&l_nation=' + lstNation_4.value +'&l_SalaryPeriod='+lstSalaryPeriod.value + '&l_lstEmpID=' + txtlstEmpID.text;
                    url+= "&l_user=" + "<%=Session("USER_ID")%>" ;
                }
                
		        window.open(url);
		    }   
		    break;
    }
	
}
//-------------------------------------------------
function on_Process()
{
	if(check_init==1)
	{
		if(confirm("Working Time is processing...do you want to continous?\nHệ thống tính công bắt đầu...Bạn có muốn tiếp tục?"))
		{
			idInterval.text="";
			set_Interval(1000)
			if(txtActive_Resign.text!='1')
				datProcess_WT_resign.Call();
			else
				datProcess_WT.Call();
		}  
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
function OnReport()
{
	if(check_init==1)
	{       
        var temp=Trim(txtEmpID.text);
        var arr= new Array();
        var str="";        
        if(temp!="")
        {  
            
            arr=temp.split(',');                             
            str=Trim(arr[0]);            
            for(var k=1;k<arr.length;k++)
            {
                str=str + '\',' + '\''+ Trim(arr[k]);
            }
           txtlstEmpID.text=str.toUpperCase();          
        }       
		if (Reports.optMonthReport[0].checked)
			{txtReport_tmp.text="rpt_working_summary_v2_ur.aspx";
			txtCompany_pk.text=lstOrg_1.value;
			}
		else if (Reports.optMonthReport[1].checked)
			{txtReport_tmp.text="rpt_in_out_summary_ur.aspx";
			txtCompany_pk.text=lstOrg_2.value;
			}
		else if (Reports.optMonthReport[2].checked)
			{txtReport_tmp.text="rpt_absence_month_v2_ur.aspx";
			txtCompany_pk.text=lstOrg_3.value;
			}
		else if (Reports.optMonthReport[3].checked)
			{txtReport_tmp.text="rpt_attendence_absence_detail_v2_ur.aspx";            
			txtCompany_pk.text=lstOrg_4.value;
			}
		datFind_Report.Call();
	}
     
}
function OnChangeLocation()
{
	datGet_period.Call();
} 

function onChange_org(_num)
{    
    if(_num==1)
        txtorg_tmp.text=lstOrg_1.value;
    if(_num==2)
        txtorg_tmp.text=lstOrg_2.value;
    if(_num==3)
        txtorg_tmp.text=lstOrg_3.value;
    if(_num==4)
        txtorg_tmp.text=lstOrg_4.value;
    datWorkGroup_info.Call();
}





function OnShowPopup_E()
{
    var url = "/form/ch/ba/chba00080_popup.aspx";
    var str="";
	str = System.OpenModal( System.RootURL+ url , 900 , 600 , 'resizable:yes;status:yes') ;
    if ( str != null )
	{ 
        txtEmpID.text=str;
    } 	
}

function check_to_dt()
{
	if(Number(old_to_dt)<Number(dtTo_Date.value))
	{
		alert("You can not change to date more than your period.");
		dtTo_Date.value=old_to_dt;
	}
	if(Number(dtTo_Date.value)<=Number(dtFrom_Date.value))
	{
		alert("You can not change to date less than your period.");
		dtTo_Date.value=old_to_dt;
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
				border-left:1px solid #034D72;
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
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtorg_tmp" />
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
                    <output bind="txtActive_Resign" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datProcess_WT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_WT_UR" > 
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
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_OT_UR" > 
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
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_ABS_UR" > 
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
<gw:data id="datMonth_summary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_SUMMARY_UR" > 
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

<!----resign------------------------>
<gw:data id="datProcess_WT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_WT_RESIGN_UR" > 
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
<gw:data id="datProcess_OT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_OT_RESIGN_UR" > 
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

<gw:data id="datProcess_ABS_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_ABS_RESIGN_UR" > 
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

<gw:data id="datMonth_summary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_SUMMARY_R_UR" > 
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
<gw:data id="datGet_Location_dept" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sp_sel_user_role2" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output>
                    <output bind="txtFact_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtCompany_pk" />                     
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
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
                <td width="30%" colspan=15 align="right" valign="middle" class="topleft">&nbsp;</td>
                <td width="40%" colspan=20  align="center" valign="middle" class="top" style="color:#cc0066; font-size:16">PROCESSING</td>
                <td width="20%" colspan=10 align="right" valign="middle" class="top"><gw:label id="idstatus_process" text="" maxlen="100" styles="width:100%;color:blue" ></gw:label></td>
                <td width="10%" colspan=5 align="right" valign="middle" class="topright">&nbsp;</td>
            </tr>
            <tr>
                <td colspan=3  align="left" valign="middle" class="left" >&nbsp;
                      <gw:list  id="lstStatus" maxlen = "100" styles='width:100%;display:none' onchange="" >
                            <data></data></gw:list>       
                 </td>
                <td colspan=3  align="right" valign="middle"   style="font-size:13">Location</td>
                <td colspan=7  align="left" valign="middle"  >
                            <gw:list  id="lstLocation_dept"  maxlen = "100" styles='width:100%' onchange="OnChangeLocation()" ><data><%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') and nvl(a.p_pk,0)=0 order by a.pk ")%></data></gw:list> 
                            </td>            
                <td colspan=4  align="right" valign="middle"  style="font-size:13"><font>Month</font></td>
                <td colspan=4  align="left" valign="middle"  ><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>" onchange="OnChangeMonth()" /> </td>
                <td colspan=3  align="right" valign="middle" style="font-size:13"><b>Kind</b></td>
                <td colspan=8  align="left" valign="middle"  ><gw:list  id="lstSalaryPeriod" maxlen = "100" styles='width:100%' onchange="OnChangeTimes()" ></gw:list>
                </td> 
                <td colspan=2  align="right" valign="middle"  style="font-size:13">Date</td>
                <td colspan=5  align="right" valign="middle"  ><gw:datebox id="dtFrom_Date"  text="" styles="width:100%"  lang="<%=Session("Lang")%>" /> </td>
                <td colspan=2  align="center" valign="middle"  style="font-size:13"><b >~</b></td>
                <td colspan=4  align="left" valign="middle"  ><gw:datebox id="dtTo_Date"  styles="width:100%"   lang="<%=Session("Lang")%>" onchange="check_to_dt()"/> </td>
                <td colspan=3  align="right" valign="middle" style="color:Blue;"><gw:label id="idInterval" text="" maxlen="100" styles="width:100%" ></gw:label></td>
                <td colspan=2 align="right" valign="middle" class="right" ><gw:icon id="icoProcess" img="in" text="Process" onclick="on_Process()" /></td>
            </tr>
        </table>
      </td>
      
    </tr>
    <tr height="70%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
		        <tr style="width:100%;height:7%" >
                    <td width="20%" colspan="2"  align="right" valign="middle" class="topleft" style="color:#cc0066; font-size:16"><a title="Click here to choice Employee" onclick="OnShowPopup_E()" href="#tips" >Multi Employee </td>
                    <td width="30%" colspan="3" align="right" valign="middle" class="top"style="color:#cc0066; font-size:16"><gw:textbox id="txtEmpID" styles='width:95%' /></td>                    
                    <td width="5%" colspan="4" align="right" valign="middle" class="topright"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport()" /></td>
                </tr>
			    <tr style="width:100%;height:7%"  > 
                    <td width="20%" colspan=2 align="center" class="left"  style="border-right:0"style="color:#0099cc; font-size:13">Report Name</td>
                    <td width="10%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Nation</td>
                    <td width="25%" align="center"  style="border-left:0;border-right:0"><a style="font-size:13" title="Click here to show department" onclick="OnShowPopup()" href="#tips">Organization</a></td>
			        <td width="17%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Work Group</td>
			        <td width="15%" align="center"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13">Status</td>
			        <td width="8%" align="center"   style="border-left:0" style="color:#0099cc; font-size:13">Emp ID</td>
			        <td width="5%" class="right" align="center" valign="middle" style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left" valign="middle" width="2%" valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" checked></td>
                    <td valign="middle" style="font-size:12" width="23%" style="border-left:0;border-right:0">Working Summary</td>
                    <td width="10%" valign="middle" align="center"  style="border-left:0;border-right:0"><gw:list  id="lstNation_1" value='01' maxlen = "100" styles='width:100%' onchange="" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0009'")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_1"  maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,1)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13"><gw:list  id="lstWG_1" value='ALL' maxlen = "100" styles='width:95%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                    
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_1" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="OnChangeOption(document.form2,1);OnReport();" styles='width:100%'/></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Working Detail (IN-OUT)</td>
                    <td width="10%" valign="middle" align="center"  style="border-left:0;border-right:0"><gw:list  id="lstNation_2" value='01' maxlen = "100" styles='width:100%' onchange="" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0009'")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_2"  maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,2)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"style="color:#0099cc; font-size:13"><gw:list  id="lstWG_2" value='ALL' maxlen = "100" styles='width:95%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_2" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle"  style="border-left:0"><gw:textbox id="txtEmp_ID_2" onenterkey   ="OnChangeOption(document.form2,2);OnReport(2)" styles='width:100%' /></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Absence Summary</td>
                    <td width="10%" valign="middle" align="center"  style="border-left:0;border-right:0"><gw:list  id="lstNation_3" value='01' maxlen = "100" styles='width:100%' onchange="" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0009'")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_3"  maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.form2,3)" >
                                        <data>
                                       <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle"  style="border-left:0;border-right:0"style="color:#0099cc; font-size:13"><gw:list  id="lstWG_3" value='ALL' maxlen = "100" styles='width:95%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_3" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,3)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle"  style="border-left:0"><gw:textbox id="txtEmp_ID_3" onenterkey   ="OnChangeOption(document.form2,3);OnReport(3)" styles='width:100%' /></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Working Detail</td>
                    <td class="bottom" valign="middle" width="10%" align="center"  style="border-left:0;border-right:0"><gw:list  id="lstNation_4" value='01' maxlen = "100" styles='width:100%' onchange="" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0009'")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstOrg_4" maxlen = "100" styles='width:80%'onchange="OnChangeOption(document.form2,4)" >
                                        <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                                        </data>
                                        </gw:list></td>
                    <td  class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstWG_4" value='ALL' maxlen = "100" styles='width:95%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0 order by a.workgroup_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstStatus_4" value='ALL' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.form2,4)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="bottom" align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_4" onenterkey   ="OnChangeOption(document.form2,4);OnReport(4)" styles='width:100%'/></td>
			        <td class="bottomright" align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                
            </table>
	    </td>
	</tr>	
 </table>
</form>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtFact_PK" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/> 
<gw:textbox id="txtResult" styles="display:none"/> 
<gw:textbox id="txtProcess" styles="display:none"/> 
<gw:textbox id="txtReport_tmp" styles="display:none"/> 
<gw:textbox id="txtSalary" styles="display:none" text="01"/> 
<gw:textbox id="txtResignTime" styles="display:none" text=""/> 
<gw:textbox id="txtResignCheck" styles="display:none" text=""/>
<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/>    
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />  
<gw:textbox id="txtlstEmpID" styles="display:none"/>  
<gw:textbox id="txtActive_Resign" styles="display:none"/>  
 
</body>
</html>

