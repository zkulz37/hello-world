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
var flag_tab=1;
var check_init=0;
function BodyInit()
{ 	
    if (v_language!="ENG") 
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    var tmp="<%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM ||' ' || char_1 || '->' || char_2 from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0030' ")%>";
    lstSalaryPeriod.SetDataText(tmp);        
    //alert(tmp)

    ChangeColorItem(lstDept_Code_1.GetControl());

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

function onChange_org(tab,n,obj)
{
	flag_wg=n;
	flag_tab=tab;
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
        if (tabMain.GetCurrentPageNo()==0)
        {
            lstDept_Code_1.value=obj;
            onChange_org(1,0,lstDept_Code_1);
        }
        
    }
    
}
//-------------------------------------------------------------
function OnDataReceive(obj)
{


   if (obj.id == "datFind_Report")
   {
        var url = System.RootURL;
        
        url = url + '/reports/ch/cs/' + txtReport_tmp.text + '?l_dept=' + lstDept_Code_1.value  + '&l_group=' + lstGrp_Code_1.value + '&l_status=' + lstStatus.value + '&l_emp_id=' + txtEmp_ID_1.text + '&l_work_mon=' + dtMonth.value + '&l_pay_type=' + lstPay_Type_1.value + '&l_type=' + lstType_1.value + '&l_m_type=' + lstMoney_Type_1.value + "&l_sal_period="+lstSalaryPeriod.value + "&l_CT_Type="+lstCT_Type.value;
                    
        System.OpenTargetPage( url , 'newform' );
   }
   else if (obj.id == "datUser_info")
   {
            lstDept_Code_1.SetDataText(txtdept_temp.text);
        
            ChangeColorItem(lstDept_Code_1.GetControl());

			onChange_org(0,0,lstDept_Code_1);	
   }
   else if (obj.id == "datWorkGroup_info")
   {
		if(flag_tab==0)
		{
				lstGrp_Code_1.SetDataText(txtwg_tmp.text + "|ALL|Select All");

                lstGrp_Code_1.value='ALL';
		}
		else if(flag_tab==1)
		{
			if(flag_wg==0)
			{
				lstGrp_Code_1.SetDataText(txtwg_tmp.text + "|ALL|Select All");
                lstGrp_Code_1.value='ALL';
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
				}
			}
		}
		
   }
   check_init=1;
}
//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    var obj;
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//------------------------------------
function OnReport()
{
    
    if(check_init==1)
	{
		 
					if (lstMoney_Type_1.value=="02")
					{
						txtReport_tmp.text = "rpt_payroll_usd_check.aspx";
					}
					else
						txtReport_tmp.text = "rpt_payroll_check.aspx";
					
	    
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
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;">
<form name="General Reports" id="Salary" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:40%"   valign="middle" border="0" >
	<tr height="50%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr>
                <td width="94%" colspan=11 align="center" valign="middle" class="topleft" style="font-family:Times New Roman"><font size="5" color="cc0066">SALARY REPORTS FOR CHECKING</font></td>
                 <td width="3%" align="center" valign="middle" class="top">&nbsp;</td>
                 <td width="3%" align="left" valign="middle" class="topright">&nbsp;</td>
                </tr>
            <tr>
                <td width="10%"  align="right" valign="middle" class="bottomleft" >Month</td>
                <td width="10%" valign="middle" align="left" class="bottom" ><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" styles='width:60%' lang="<%=Session("Lang")%>" /> </td>
                <td width="7%" valign="middle" align="right" class="bottom" >CT Type</td>
                <td width="10%" valign="middle" align="left" class="bottom" style="border-left:0;border-right:0"><gw:list  id="lstCT_Type" value='ALL' maxlen = "100" styles='width:80%;' onchange="">
                                        <data>|Y|Normarl|N|Temporary|ALL|Select All
                                        </data>
                                        </gw:list></td> 
                <td width="7%"  align="right" valign="middle" style="font-size:13" class="bottom"><b>Sal Period</b></td>
                <td colspan=3 width="28%"  align="left" valign="middle" class="bottom"  ><gw:list  id="lstSalaryPeriod" maxlen = "100" styles='width:100%' onchange="" ></gw:list>
               
                <td width="2%" align="center"  class="bottom" >&nbsp;</td>
                <td width="10%" align="right"  class="bottom" >Status</td>
                <td colspan=2 width="14%" valign="middle" align="left" class="bottom" ><gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:80%;' onchange="">
                                        <data>|A|Active|R|Resign|ALL|Select All
                                        </data>
                                        </gw:list></td>
                <td width="3%" valign="middle" align="left" class="bottomright" >&nbsp;</td>
             
            </tr>
        </table>
      </td>
      
    </tr>
    <tr height="60%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
			    <tr style="width:100%;height:25%"  > 
                    <td width="2%" colspan="2" align="center" class="topleft" style="border-right:0;color:Navy">&nbsp;</td>
                    <td width="20%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">
                        <a  title="Click here to show Organization" onclick="OnShowPopup()" href="#tips">Organization</a>
                    </td>
			        <td width="20%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Group</td>
			        
			        <td width="15%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Pay Type</td>
			        <td width="15%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Money Type</td>
			        <td width="13%" align="center" class="top" style="border-left:0;border-right:0;color:Navy">Type</td>
			        <td width="15%" align="center" class="topright" style="border-left:0;color:Navy">Emp ID</td>
                </tr>
                <tr height="25%" style="width:100%;"  valign="top"> 
                    <td class="left" colspan="2"  width="2%" valign="middle" style="border-right:0">&nbsp;</td>
                    
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstDept_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="onChange_org(1,1,lstDept_Code_1)" >
                                        <data>
                                        <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstGrp_Code_1" value='ALL' maxlen = "100" styles='width:80%' onchange="">
                                        <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_nm FROM thr_work_group WHERE DEL_IF = 0   order by workgroup_id" )%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstPay_Type_1" value='ALL' maxlen = "100" styles='width:80%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0023' ORDER BY A.seq")%>|ALL|Select All
                                        </data>
                                        </gw:list></td>
                    <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstMoney_Type_1" value='01' maxlen = "100" styles='width:80%' onchange="">
                                        <data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq")%>|ALL|Select All</data>
                                        </gw:list></td>                                        
			        <td align="center" valign="middle" style="border-left:0;border-right:0"><gw:list  id="lstType_1" value='>0' maxlen = "100" styles='width:70%' onchange="">
                                        <data>|>0|>0|=0|=0|<0|<0|>=0|>=0|ALL|ALL</data>
                                        </gw:list></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0"><gw:textbox id="txtEmp_ID_1" onenterkey   ="OnReport()" styles='width:100%'/></td>
                </tr>
                <tr height="25%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"  valign="middle" style="border-right:0">&nbsp;</td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td class="bottom">&nbsp;</td>
                    
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td class="bottom" valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
			        <td class="bottomright" align="center" valign="middle"   style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="25%" style="width:100%;"  valign="top"> 
                    <td   valign="middle" style="border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td >&nbsp;</td>
                    
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
			        <td  align="center" valign="middle"   style="border-left:0">&nbsp;</td>
                </tr>
                
                 <tr height="25%" style="width:100%;"  valign="top"> 
                    <td   valign="middle" style="border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td ><gw:icon id="btnSLip" img="in" text="Report Check" styles="width:100" onclick="OnReport()" /></td>
                    
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
			        <td  align="center" valign="middle"   style="border-left:0">&nbsp;</td>
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

