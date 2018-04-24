<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var ctlGroup;
var bChange_All=false;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
var flag_wg=0;
var check_init=0;
function BodyInit()
{ 	
    if (v_language!="ENG") 
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    var tmp="<%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM ||' ' || char_1 || '->' || char_2 from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0030' ")%>";
    lstSalaryPeriod.SetDataText(tmp);        
        
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
	ChangeColorItem(lstDept_Code_13.GetControl());
	ChangeColorItem(lstDept_Code_14.GetControl());

       
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); 
	else
		check_init=1;            
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

//----------------------------------------------

function onChoose_opt(form,obj)
{
	form.optMonthReport[obj-1].checked=true;
}

function onChange_org(n,obj)
{
	flag_wg=n;	
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
}

//------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {        
            lstDept_Code_1.value=obj;
            lstDept_Code_2.value=obj;
            lstDept_Code_3.value=obj;
            lstDept_Code_4.value=obj;
            lstDept_Code_5.value=obj;
            lstDept_Code_6.value=obj;
            lstDept_Code_7.value=obj;
            lstDept_Code_8.value=obj;
            lstDept_Code_9.value=obj;
            lstDept_Code_10.value=obj;
            lstDept_Code_11.value=obj;
            lstDept_Code_12.value=obj;
            lstDept_Code_13.value=obj;
            lstDept_Code_14.value=obj;
            onChange_org(0,lstDept_Code_1);                
    }
    
}
//-------------------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id == "datFind_Report")
   {
        var url = System.RootURL;        
            switch (rpt_no)
            {
                case 1:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_1.value  + '&l_group=' + lstGrp_Code_1.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_1.value + '&l_type=' + lstType_1.value + '&l_m_type=' + lstMoney_Type_1.value + "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 2:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_2.value  + '&l_group=' + lstGrp_Code_2.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_2.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_2.value + '&l_type=' + lstType_2.value + '&l_m_type=' + lstMoney_Type_2.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 3:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_3.value  + '&l_group=' + lstGrp_Code_3.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_3.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_3.value + '&l_type=' + lstType_3.value + '&l_m_type=' + lstMoney_Type_3.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 4:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_4.value  + '&l_group=' + lstGrp_Code_4.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_4.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_4.value + '&l_type=' + lstType_4.value + '&l_m_type=' + lstMoney_Type_4.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 5:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_5.value  + '&l_group=' + lstGrp_Code_5.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_5.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_5.value + '&l_type=' + lstType_5.value + '&l_m_type=' + lstMoney_Type_5.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 6:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_6.value  + '&l_group=' + lstGrp_Code_6.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_6.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstBank_6.value + '&l_type=' + lstType_6.value + '&l_m_type=' + lstMoney_Type_6.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 7:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_7.value  + '&l_group=' + lstGrp_Code_7.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_7.text + '&l_work_mon=' + dtMonth.value +  '&l_type=' + lstType_7.value + '&l_m_type=' + lstMoney_Type_7.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 8:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_8.value  + '&l_group=' + lstGrp_Code_8.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_8.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_8.value + '&l_type=' + lstType_8.value + '&l_m_type=' + lstMoney_Type_8.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 9:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_9.value  + '&l_group=' + lstGrp_Code_9.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_9.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_9.value + '&l_type=' + lstType_9.value + '&l_m_type=' + lstMoney_Type_9.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 10:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_10.value  + '&l_group=' + lstGrp_Code_10.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_10.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_10.value + '&l_type=' + lstType_10.value + '&l_m_type=' + lstMoney_Type_10.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 11:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_11.value  + '&l_group=' + lstGrp_Code_11.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_11.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_11.value + '&l_type=' + lstType_11.value + '&l_m_type=' + lstMoney_Type_11.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
				case 12:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_12.value  + '&l_group=' + lstGrp_Code_12.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_12.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstBank_12.value + '&l_type=' + lstType_12.value + '&l_m_type=' + lstMoney_Type_11.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 13:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_13.value  + '&l_group=' + lstGrp_Code_13.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_13.text + '&l_work_mon=' + dtMonth.value + '&l_type=' + lstType_13.value + '&l_m_type=' + lstMoney_Type_11.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
                case 14:
                {
                    url = url + '/reports/ch/om/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_14.value  + '&l_group=' + lstGrp_Code_14.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_14.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_14.value + '&l_type=' + lstType_14.value + '&l_m_type=' + lstMoney_Type_11.value+ "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    break;
                }
            }                        
        System.OpenTargetPage( url , 'newform' );
   }
   else if (obj.id == "datUser_info")
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
			lstDept_Code_13.SetDataText(txtdept_temp.text);
			lstDept_Code_14.SetDataText(txtdept_temp.text);
                    
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
			ChangeColorItem(lstDept_Code_13.GetControl());
			ChangeColorItem(lstDept_Code_14.GetControl());
            
			onChange_org(0,lstDept_Code_1);	
   }
   else if (obj.id == "datWorkGroup_info")
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
				}  //switch
			}	//else	
   }
   check_init=1;
}

//------------------------------------
function OnChangeStatus()
{
    if (lstStatus.value=="N")
    {
         for(var i=1;i<Salary.optMonthReport.length;i++)
         {
            Salary.optMonthReport[i].disabled =true;
         }
         
    }
    else
    {
         for(var i=0;i<Salary.optMonthReport.length;i++)
         {
            Salary.optMonthReport[i].disabled =false;
         }
         
    }
    
}
function OnReport(optobj)
{
    if(check_init==1)
	{
		 rpt_no = optobj.value;
			for(var i=0;i<optobj.length;i++)
				if (optobj[i].checked)
					rpt_no = i + 1;		    
			switch (rpt_no)
			{
				case 1:
				{
				    if (lstStatus.value=="N")
					    txtReport_tmp.text = "rpt_salary_payment_npay_ur_yujin.aspx";
					else
					{
					    if (lstMoney_Type_1.value=="02")
					    {
						    txtReport_tmp.text = "rpt_employee_payroll_usd_ur.aspx";
					    }
					    else
					    {	if (lstCT_Type.value=="02") 
							    txtReport_tmp.text = "rpt_employee_payroll_temp_ur_yujin.aspx";
						    else 
							    txtReport_tmp.text = "rpt_employee_payroll_ur.aspx";
					    }	
					}	
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
					txtReport_tmp.text = "rpt_tax_detail_ur.aspx";
					break;
				}
				case 12:
				{
					txtReport_tmp.text = "rpt_atm_save_company_ur.aspx";
					break;
				}
				case 13:
				{
					txtReport_tmp.text = "rpt_cash_company_ur.aspx";
					break;
				}
				case 14:
				{
					txtReport_tmp.text = "rpt_cash_payment_ur_yujin.aspx";
					break;
				}
			}
								
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
.topcenter { border-top:1px solid #034D72; }
.bottom { border-bottom:1px solid #034D72; }

.topleftbottom { border-left:1px solid #034D72; 
			border-top :1px solid #034D72;
			border-bottom:1px solid #034D72; }
.topcenterbottom { 
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

<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
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
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
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
<!--------------------main table--------------------------------->

<form name="General Reports" id="Salary" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:80%"   valign="middle" border="0" >
	<tr height="15%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr>
                <td width="94%" colspan=11 align="center" valign="middle" class="topleft" style="font-family:Times New Roman"><font size="5" color="cc0066">SALARY REPORTS</font></td>
                 <td width="3%" align="center" valign="middle" class="top"><gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="Print" onclick="OnReport(Salary.optMonthReport)" /></td>
                 <td width="3%" align="left" valign="middle" class="topright">&nbsp;</td>
                </tr>
            <tr>
                <td width="10%"  align="right" valign="middle" class="bottomleft" >Month</td>
                <td width="10%" valign="middle" align="left" class="bottom" ><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" styles='width:60%' lang="<%=Session("Lang")%>" /> </td>
                <td width="7%" valign="middle" align="right" class="bottom" >CT Type</td>
                <td width="10%" valign="middle" align="left" class="bottom" style="border-left:0;border-right:0"><gw:list  id="lstCT_Type" value='ALL' maxlen = "100" styles='width:80%;' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0056' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td> 
                <td width="7%"  align="right" valign="middle" style="font-size:13" class="bottom"><b>Sal Period</b></td>
                <td colspan=3 width="28%"  align="left" valign="middle" class="bottom"  ><gw:list  id="lstSalaryPeriod" maxlen = "100" styles='width:100%' onchange="" ></gw:list>
               
                <td width="2%" align="center"  class="bottom" >&nbsp;</td>
                <td width="10%" align="right"  class="bottom" >Status</td>
                <td colspan=2 width="14%" valign="middle" align="left" class="bottom" ><gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:80%;' onchange="OnChangeStatus()">
                                        <data>|A|Active|R|Resign|ALL|Select All|N|Not Pay
                                        </data>
                                        </gw:list></td>
                <td width="3%" valign="middle" align="left" class="bottomright" >&nbsp;</td>
             
            </tr>
        </table>
      </td>
      
    </tr>
    <tr height="80%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
			    <tr style="width:100%;height:7%"  > 
                    <td width="15%" colspan="2" align="center" class="topleft" style="border-right:0;color:Navy">Report Name</td>
                    <td width="20%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">
                        <a  title="Click here to show Organization" onclick="OnShowPopup()" href="#tips">Organization</a>
                    </td>
			        <td width="20%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Group</td>
			        
			        <td width="10%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Pay Type</td>
			        <td width="10%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Money Type</td>
			        <td width="10%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Type</td>
			        <td width="15%" align="center" class="topright" style="border-left:0;color:Navy">Emp ID</td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  width="2%" valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" checked></td>
                    <td valign="middle" style="font-size:12" width="20%" style="border-left:0;border-right:0">Salary Payment</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,1);onChange_org(1,lstDept_Code_1)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,1)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_1" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_1" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,1)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_1" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,1)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="onChoose_opt(document.Salary,1);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Pay-slip</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_2" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,2);onChange_org(2,lstDept_Code_2)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_2" value='ALL' maxlen = "100" styles='width:80%'  onchange="onChoose_opt(document.Salary,2)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_2" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_2" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,2)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_2" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,2)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_2" onenterkey   ="onChoose_opt(document.Salary,2);OnReport(Salary.optMonthReport)" styles='width:100%' /></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Payroll Group Summary</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_3" value='ALL' maxlen = "100" styles='width:80%'onchange="onChoose_opt(document.Salary,3);onChange_org(3,lstDept_Code_3)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_3" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,3)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_3" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,3)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_3" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,3)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_3" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,3)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_3" onenterkey   ="onChoose_opt(document.Salary,3);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Income Tax(02_KK)</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_4" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,4);onChange_org(4,lstDept_Code_4)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_4" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,4)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_4" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,4)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_4" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,4)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_4" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,4)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_4"  onenterkey="onChoose_opt(document.Salary,4);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Severance Pay</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_5" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,5);onChange_org(5,lstDept_Code_5)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_5" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,5)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_5" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,5)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_5" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,5)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_5" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,5)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_5" onenterkey   ="onChoose_opt(document.Salary,5);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Salary Payment by Bank</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_6" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,6);onChange_org(6,lstDept_Code_6)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_6" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,6)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstBank_6" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,6)">
                                        <data><%=ESysLib.SetListDataSQL("select a.NUM_1,MAX(a.code_Knm) from vhr_hr_code a where a.id='HR0020' group by a.num_1")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_6" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,6)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_6" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,6)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_6" onenterkey   ="onChoose_opt(document.Salary,6);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Salary Payment by Cash</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_7" value='ALL' maxlen = "100" styles='width:80%'onchange="onChoose_opt(document.Salary,7);onChange_org(7,lstDept_Code_7)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_7" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,7);">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_7" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,7)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_7" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,7);">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_7" onenterkey   ="onChoose_opt(document.Salary,7);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Money's Classification</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_8" value='ALL' maxlen = "100" styles='width:80%'onchange="onChoose_opt(document.Salary,8);onChange_org(8,lstDept_Code_8)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_8" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,8)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_8" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,8)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_8" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,8)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' and a.code='01' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_8" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,8)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td  class="right" align="center" valign="middle" style="border-left:0"><gw:textbox id="txtEmp_ID_8" onenterkey   ="onChoose_opt(document.Salary,8);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Money's Classification by Group</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_9" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,9);onChange_org(9,lstDept_Code_9)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_9" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,9)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_9" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,9)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_9" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,9)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' and a.code='01' ORDER BY A.seq")%>
                                        </data>
                                        </gw:list></td>                                        
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_9" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,9)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_9" onenterkey   ="onChoose_opt(document.Salary,9);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Insurance payment</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_10" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,10);onChange_org(10,lstDept_Code_10)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_10" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,10)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_10" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,10)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_10" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,10)">
                                        <data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_10" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,10)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_10" onenterkey   ="onChoose_opt(document.Salary,10);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td class="middle" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Income tax detail</td>
                    
                    <td class="center" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_11" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,11);onChange_org(11,lstDept_Code_11)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="center" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_11" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,11)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="center" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_11" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,11)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td class="center" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_11" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,11)">
                                        <data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td class="center" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_11" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,11)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_11" onenterkey   ="onChoose_opt(document.Salary,11);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
				
				<tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Bank For Company</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_12" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,12);onChange_org(12,lstDept_Code_12)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td " align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_12" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,12)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>										
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstBank_12" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,12)">
                                        <data><%=ESysLib.SetListDataSQL("select a.NUM_1,MAX(a.code_Knm) from vhr_hr_code a where a.id='HR0020' group by a.num_1")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_12" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,12)">
                                        <data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_12" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,12)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_12" onenterkey   ="onChoose_opt(document.Salary,12);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
               <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="left"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Cash For Company</td>
                    
                    <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_13" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,13);onChange_org(13,lstDept_Code_13)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_13" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,13)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td  align="center" valign="middle" style="border-left:0;border-right:0">
                                        </td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_13" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,13)">
                                        <data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td  align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_13" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,13)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td class="right" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_13" onenterkey   ="onChoose_opt(document.Salary,13);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
                </tr>
                <tr height="7%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"  valign="middle" style="border-right:0"><input type="radio" name="optMonthReport" value="1" ></td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">Many Sheet of Cash</td>
                    
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_14" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,14);onChange_org(14,lstDept_Code_14)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_14" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,14)">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_14" value='ALL' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,14)">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_14" value='01' maxlen = "100" styles='width:80%' onchange="onChoose_opt(document.Salary,14)">
                                        <data><%= ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>                                        
			        <td class="bottom" align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_14" value='>0' maxlen = "100" styles='width:70%' onchange="onChoose_opt(document.Salary,14)">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td class="bottomright" align="center" valign="middle"   style="border-left:0"><gw:textbox id="txtEmp_ID_14" onenterkey   ="onChoose_opt(document.Salary,14);OnReport(Salary.optMonthReport)" styles='width:100%'/></td>
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
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtdept_temp" styles="display:none"/>


<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/>    
</body>
</html>

