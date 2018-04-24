<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
//var ctlGroup;
//var bChange_All=false;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{ 	
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    ChangeColorItem(lstDept_Code_1.GetControl());
    ChangeColorItem(lstDept_Code_2.GetControl());
    ChangeColorItem(lstDept_Code_3.GetControl());
    ChangeColorItem(lstDept_Code_4.GetControl());
    ChangeColorItem(lstDept_Code_5.GetControl());
    ChangeColorItem(lstDept_Code_6.GetControl());
    ChangeColorItem(lstDept_Code_7.GetControl());
    ChangeColorItem(lstDept_Code_8.GetControl());
    ChangeColorItem(lstDept_Code_9.GetControl());
    ChangeColorItem(lstDept_Code_10.GetControl());
    ChangeColorItem(lstDept_Code_11.GetControl());
    ChangeColorItem(lstDept_Code_12.GetControl());

    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN
        datUser_info.Call();
    //lstTimes_resign.SetVisiable(false);
    lstTimes_resign.style.display="none";
    lbTimes.text="";
}

//----------------------------------
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
//------------------------------------
function OnChangeDept(n,objDept)
{    
	flag_wg=n;	
	txtorg_tmp.text=objDept.value;
	datWorkGroup_info.Call();	
}
//------------------------------------
function OnChangeOption(form,obj)
{
   // form.optMonthReport[obj-1].checked=true;
   if(lstStatus.value=="R")
  { lstTimes_resign.style.display="";
    lbTimes.text="Times";
    
  }
   else 
   { lstTimes_resign.style.display="none";
    lbTimes.text="";
    lstTimes_resign.value='ALL';
   }
   
}
//------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        lstDept_Code_1.SetDataText(txtUpperDept.text);
		lstDept_Code_2.SetDataText(txtUpperDept.text);
		lstDept_Code_3.SetDataText(txtUpperDept.text);
		lstDept_Code_4.SetDataText(txtUpperDept.text);
		lstDept_Code_5.SetDataText(txtUpperDept.text);
		lstDept_Code_6.SetDataText(txtUpperDept.text);
		lstDept_Code_7.SetDataText(txtUpperDept.text);
		lstDept_Code_8.SetDataText(txtUpperDept.text);
		lstDept_Code_9.SetDataText(txtUpperDept.text);
		lstDept_Code_10.SetDataText(txtUpperDept.text);
		lstDept_Code_11.SetDataText(txtUpperDept.text);
		lstDept_Code_12.SetDataText(txtUpperDept.text);
		//datDeptData.Call();
    }
    
}


//-------------------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datUser_info")
   {
		lstDept_Code_1.SetDataText(txtdept_temp.text);   
		lstDept_Code_2.SetDataText(txtdept_temp.text);
		lstDept_Code_3.SetDataText(txtdept_temp.text);
		lstDept_Code_4.SetDataText(txtdept_temp.text);
		lstDept_Code_5.SetDataText(txtdept_temp.text);
		lstDept_Code_6.SetDataText(txtdept_temp.text);
		lstDept_Code_7.SetDataText(txtdept_temp.text);
		lstDept_Code_8.SetDataText(txtdept_temp.text);
		lstDept_Code_9.SetDataText(txtdept_temp.text);
		lstDept_Code_10.SetDataText(txtdept_temp.text);
		lstDept_Code_11.SetDataText(txtdept_temp.text);
		lstDept_Code_12.SetDataText(txtdept_temp.text);

        ChangeColorItem(lstDept_Code_1.GetControl());
        ChangeColorItem(lstDept_Code_2.GetControl());
        ChangeColorItem(lstDept_Code_3.GetControl());
        ChangeColorItem(lstDept_Code_4.GetControl());
        ChangeColorItem(lstDept_Code_5.GetControl());
        ChangeColorItem(lstDept_Code_6.GetControl());
        ChangeColorItem(lstDept_Code_7.GetControl());
        ChangeColorItem(lstDept_Code_8.GetControl());
        ChangeColorItem(lstDept_Code_9.GetControl());
        ChangeColorItem(lstDept_Code_10.GetControl());
        ChangeColorItem(lstDept_Code_11.GetControl());

		//txtDept.text=lstDept_Code_1.value;
		//bChange_All=true;  
        OnChangeDept(0,lstDept_Code_1);	      
		//datGroupData.Call();       
   }
   else if (obj.id=="datWorkGroup_info")
   {
        if(flag_wg==0)
		{
			lstGrp_Code_1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_2.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_3.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_4.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_5.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_6.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_7.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_8.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_9.SetDataText(txtwg_tmp.text + "|ALL|Select All");
			lstGrp_Code_10.SetDataText(txtwg_tmp.text + "|ALL|Select All");
            lstGrp_Code_11.SetDataText(txtwg_tmp.text + "|ALL|Select All");
            lstGrp_Code_12.SetDataText(txtwg_tmp.text + "|ALL|Select All");

            lstGrp_Code_1.value='ALL';
			lstGrp_Code_2.value='ALL';
			lstGrp_Code_3.value='ALL';
			lstGrp_Code_4.value='ALL';
			lstGrp_Code_5.value='ALL';
			lstGrp_Code_6.value='ALL';
			lstGrp_Code_7.value='ALL';
			lstGrp_Code_8.value='ALL';
			lstGrp_Code_9.value='ALL';
			lstGrp_Code_10.value='ALL';
			lstGrp_Code_11.value='ALL';
			lstGrp_Code_12.value='ALL';	
		}
		else
		{
			switch (flag_wg)
			{
				case 1:
					{
						lstGrp_Code_1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_1.value='ALL';
						break;
					}
				case 2:
					{
						lstGrp_Code_2.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_2.value='ALL';
						break;
					}
				case 3:
					{
						lstGrp_Code_3.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_3.value='ALL';
						break;
					}		
				case 4:
					{
						lstGrp_Code_4.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_4.value='ALL';
						break;
					}	
				case 5:
					{
						lstGrp_Code_5.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_5.value='ALL';
						break;
					}
				case 6:
					{
						lstGrp_Code_6.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_6.value='ALL';
						break;
					}
				case 7:
					{
						lstGrp_Code_7.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_7.value='ALL';
						break;
					}
				case 8:
					{
						lstGrp_Code_8.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_8.value='ALL';
						break;
					}
				case 9:
					{
						lstGrp_Code_9.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_9.value='ALL';
						break;
					}	
				case 10:
					{
						lstGrp_Code_10.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_10.value='ALL';
						break;
					}	
                case 11:
					{
						lstGrp_Code_11.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_11.value='ALL';
						break;
					}
                case 12:
					{
						lstGrp_Code_12.SetDataText(txtwg_tmp.text + "|ALL|Select All");
						lstGrp_Code_12.value='ALL';
						break;
					}
			}
		}	 
   }
//   else if (obj.id=="datDeptData")
//   {
//        if(txtHr_level.text=="6")
//            txtDeptData.text=txtDeptData.text+"|ALL|Select All";
//        //bChange_All=true;
//        if (tabMain.GetCurrentPageNo()==0)
//        {
//            lstDept_Code_1.SetDataText(txtDeptData.text);
//            lstDept_Code_2.SetDataText(txtDeptData.text);
//            lstDept_Code_3.SetDataText(txtDeptData.text);
//            lstDept_Code_4.SetDataText(txtDeptData.text);
//            lstDept_Code_5.SetDataText(txtDeptData.text);
//            lstDept_Code_6.SetDataText(txtDeptData.text);
//            lstDept_Code_7.SetDataText(txtDeptData.text);
//            lstDept_Code_8.SetDataText(txtDeptData.text);
//            lstDept_Code_9.SetDataText(txtDeptData.text);
//            lstDept_Code_10.SetDataText(txtDeptData.text);
//            lstDept_Code_11.SetDataText(txtDeptData.text);
//            lstDept_Code_12.SetDataText(txtDeptData.text);
//            txtDept.text=lstDept_Code_9.value;
//        }        
//        //datGroupData.Call(); 
//   }   
   else if (obj.id = "datFind_Report")
   {
        var url = System.RootURL;
        if(tabMain.GetCurrentPageNo()==0)
        {
            switch (rpt_no)
            {
                case 1:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_1.value  + '&l_group=' + lstGrp_Code_1.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_1.value + '&l_type=' + lstType_1.value + '&l_m_type=' + lstMoney_Type_1.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 2:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_2.value  + '&l_group=' + lstGrp_Code_2.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_2.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_2.value + '&l_type=' + lstType_2.value + '&l_m_type=' + lstMoney_Type_2.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 3:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_3.value  + '&l_group=' + lstGrp_Code_3.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_3.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_3.value + '&l_type=' + lstType_3.value + '&l_m_type=' + lstMoney_Type_3.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 4:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_4.value  + '&l_group=' + lstGrp_Code_4.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_4.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_4.value + '&l_type=' + lstType_4.value + '&l_m_type=' + lstMoney_Type_4.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 5:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_5.value  + '&l_group=' + lstGrp_Code_5.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_5.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_5.value + '&l_type=' + lstType_5.value + '&l_m_type=' + lstMoney_Type_5.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 6:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_6.value  + '&l_group=' + lstGrp_Code_6.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_6.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstBank_6.value + '&l_type=' + lstType_6.value + '&l_m_type=' + lstMoney_Type_6.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 7:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_7.value  + '&l_group=' + lstGrp_Code_7.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_7.text + '&l_work_mon=' + dtMonth.value +  '&l_type=' + lstType_7.value + '&l_m_type=' + lstMoney_Type_7.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 8:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_8.value  + '&l_group=' + lstGrp_Code_8.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_8.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_8.value + '&l_type=' + lstType_8.value + '&l_m_type=' + lstMoney_Type_8.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 9:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_9.value  + '&l_group=' + lstGrp_Code_9.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_9.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_9.value + '&l_type=' + lstType_9.value + '&l_m_type=' + lstMoney_Type_9.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 10:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_10.value  + '&l_group=' + lstGrp_Code_10.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_10.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_10.value + '&l_type=' + lstType_10.value + '&l_m_type=' + lstMoney_Type_10.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 11:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_11.value  + '&l_group=' + lstGrp_Code_11.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_11.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_11.value + '&l_type=' + lstType_11.value + '&l_m_type=' + lstMoney_Type_11.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
                case 12:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_12.value  + '&l_group=' + lstGrp_Code_12.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_12.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_12.value + '&l_type=' + lstType_12.value + '&l_m_type=' + lstMoney_Type_12.value+"&l_Times_r="+lstTimes_resign.value;
                    break;
                }
            }
        }        
        System.OpenTargetPage( url , 'newform' );
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
function OnReport(optobj)
{
    if(tabMain.GetCurrentPageNo()==0)
    {    
        rpt_no = optobj.value;
        for(var i=0;i<optobj.length;i++)
            if (optobj[i].checked)
                rpt_no = i + 1;
        
        switch (rpt_no)
        {
            case 1:
            {
			    if (lstMoney_Type_1.value=="02")
			    {
				    txtReport_tmp.text = "rpt_employee_payroll_usd_ur.aspx";
			    }
			    else
				    txtReport_tmp.text = "rpt_employee_payroll_ur.aspx";
                break;
            }
            case 2:
            {
                txtReport_tmp.text = "rpt_salary_pay_slip_ur.aspx";
                break;
            }
            case 3:
            {
                txtReport_tmp.text = "rpt_payroll_summary_ur.aspx";
                break;
            }
            case 4:
            {
                txtReport_tmp.text = "rpt_income_tax_ur.aspx";
                break;
            }
            case 5:
            {
                txtReport_tmp.text = "rpt_severance_summary_ur.aspx";
                break;
            }
            case 6:
            {
                txtReport_tmp.text = "rpt_atm_transferring_ur.aspx";
                break;
            }
            case 7:
            {
                txtReport_tmp.text = "rpt_cash_payment_ur.aspx";
                break;
            }
            case 8:
            {
                txtReport_tmp.text = "rpt_classification_detail_ur.aspx";
                break;
            }
            case 9:
            {
                txtReport_tmp.text = "rpt_classification_group_ur.aspx";
                break;
            }
            case 10:
            {
                txtReport_tmp.text = "rpt_insurance_payment_ur.aspx";
                break;
            }
            case 11:
            {
                txtReport_tmp.text = "rpt_month_total_salary_ur.aspx";
                break;
            }
            case 12:
            {
                txtReport_tmp.text = "rpt_comparison_salary_ur.aspx";
                break;
            }
        }
    }    
    datFind_Report.Call();
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
			
.toprightbottomleft { border-right:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72;
			border-left:1px solid #034D72; }			
	
#up { background-color:#DFF2FF; }
#down { background-color:#EAEAEA; }

</style>

<body>
<!------------main control---------------------->

<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
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

<%--<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>--%>
<!------------------------------------->

<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;">
<form name="General Reports" id="Salary" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:80%" class="toprightbottomleft"  valign="middle" border="0" >
	<tr height="15%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr style="" >
                <td width="30%"  align="right" valign="middle" class="left"><font size="5" color="cc0066">SALARY MONTH</font>&nbsp;</td>
                <td width="15%" valign="middle" align="left" style="border-left:0;border-right:0"><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" styles='width:60%' lang="<%=Session("Lang")%>" /> </td>
                <td width="5%" valign="middle" align="left" style="border-left:0;border-right:0">Status</td>
                <td width="20%" valign="middle" align="left" style="border-left:0;border-right:0"><gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                 <td width="5%" valign="middle" align="left" style="border-left:0;border-right:0"><gw:label id="lbTimes" text="" styles="width:100%" ></gw:label></td>
                 <td width="20%" valign="middle" align="left" style="border-left:0;border-right:0"><gw:list  id="lstTimes_resign" value='ALL' maxlen = "100" styles='width:80%;' onchange="OnChangeOption(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0117' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                
                <td width="5%" align="left" valign="middle" class="right"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport(Salary.optMonthReport)" /></td>
            </tr>
        </table>
      </td>
      
    </tr>
    <tr height="80%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
			    <tr style="width:100%;height:7%"  > 
                    <td width="15%" colspan="2" align="center" class="topleft" style="border-right:0">Report Name</td>
                    <td width="18%" align="center" class="top" style="border-left:0;border-right:0">
                        <a  title="Click here to show Organization" onclick="OnShowPopup()" href="#tips">Organization</a>
                    </td>
			        <td width="20%" align="center" class="top" style="border-left:0;border-right:0">WorkGroup</td>
			        
			        <td width="10%" align="center" class="top" style="border-left:0;border-right:0">Pay Type</td>
			        <td width="10%" align="center" class="top" style="border-left:0;border-right:0">Money Type</td>
			        <td width="7%" align="center" class="top" style="border-left:0;border-right:0">Type</td>
			        <td width="20%" align="center" class="topright" style="border-left:0">Emp ID</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  width="2%" valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" checked></td>
                    <td valign="middle" style="font-size:12" width="23%" style="border-left:0;border-right:0">Salary Payment</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,1);OnChangeDept(1,lstDept_Code_1)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			      
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_1" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_1" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,1)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="OnChangeOption(document.Salary,1);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Pay-slip</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_2" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,2);OnChangeDept(2,lstDept_Code_2)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_2" value='ALL' maxlen = "100" styles='width:80%'  onchange="OnChangeOption(document.Salary,2)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			     
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_2" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_2" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_2" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,2)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_2" onenterkey   ="OnChangeOption(document.Salary,2);OnReport(Salary.optMonthReport)" styles='width:100%' /></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Payroll Group Summary</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_3" value='ALL' maxlen = "100" styles='width:80%'onchange="OnChangeOption(document.Salary,3);OnChangeDept(3,lstDept_Code_3)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_3" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,3)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_3" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,3)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_3" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,3)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_3" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,3)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_3" onenterkey   ="OnChangeOption(document.Salary,3);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Income Tax</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_4" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,4);OnChangeDept(4,lstDept_Code_4)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_4" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,4)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			      
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_4" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,4)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_4" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,4)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_4" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,4)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_4"  onenterkey="OnChangeOption(document.Salary,4);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Severance Pay</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_5" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,5);OnChangeDept(5,lstDept_Code_5)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_5" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,5)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_5" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,5)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_5" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,5)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_5" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,5)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_5" onenterkey   ="OnChangeOption(document.Salary,5);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Salary Payment by Bank</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_6" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,6);OnChangeDept(6,lstDept_Code_6)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_6" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,6)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			      
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstBank_6" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,6)">
                                        <data><%=ESysLib.SetListDataSQL("select a.NUM_1,MAX(a.code_Knm) from vhr_hr_code a where a.id='HR0020' group by a.num_1")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_6" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,6)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%></data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_6" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,6)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_6" onenterkey   ="OnChangeOption(document.Salary,6);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Salary Payment by Cash</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_7" value='ALL' maxlen = "100" styles='width:80%'onchange="OnChangeOption(document.Salary,7);OnChangeDept(7,lstDept_Code_7)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_7" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,7);">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			      
                    <td></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_7" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,7)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_7" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,7);">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_7" onenterkey   ="OnChangeOption(document.Salary,7);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Money's Classification</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_8" value='ALL' maxlen = "100" styles='width:80%'onchange="OnChangeOption(document.Salary,8);OnChangeDept(8,lstDept_Code_8)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_8" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,8)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_8" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,8)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_8" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,8)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' and a.code='01' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_8" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,8)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td  class="right" align="center" valign="middle" style="border-left:0"><gw:textbox id="txtEmp_ID_8" onenterkey   ="OnChangeOption(document.Salary,8);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Money's Classification by Group</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_9" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,9);OnChangeDept(9,lstDept_Code_9)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_9" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,9)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_9" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,9)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_9" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,9)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' and a.code='01' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>                                        
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_9" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,9)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_9" onenterkey   ="OnChangeOption(document.Salary,9);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Insurance payment</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_10" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,10);OnChangeDept(10,lstDept_Code_10)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_10" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,10)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_10" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,10)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_10" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,10)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' and a.code='01' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_10" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,10)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_10" onenterkey   ="OnChangeOption(document.Salary,10);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Total Salary</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_11" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,11);OnChangeDept(11,lstDept_Code_11)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_11" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,11)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_11" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,11)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_11" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,11)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_11" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,11)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_11" onenterkey   ="OnChangeOption(document.Salary,11);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Salary Comparison</td>
                    
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_12" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,12);OnChangeDept(12,lstDept_Code_12)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_12" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,12)">
                                        <data><%=ESysLib.SetListDataSQL("SELECT pk,WorkGroup_NM FROM Thr_Work_Group WHERE DEL_IF = 0 order by WorkGroup_id")%>|ALL|Select All</data>
                                        </gw:list></td>
			       
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_12" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,12)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_12" value='ALL' maxlen = "100" styles='width:80%' onchange="OnChangeOption(document.Salary,12)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_12" value='>0' maxlen = "100" styles='width:70%' onchange="OnChangeOption(document.Salary,12)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="bottomright" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_12" onenterkey   ="OnChangeOption(document.Salary,12);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
            </table>
	    </td>
	</tr>	
 </table>
 </form>
 </gw:tab>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtReport_tmp" styles="display:none"/>

<gw:textbox id="txtdept_temp" styles="display:none"/>

<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/>    
</body>
</html>

