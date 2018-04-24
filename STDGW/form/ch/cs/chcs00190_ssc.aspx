<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
 var tmp = "<%=session("USER_PK")%>";
 var c_emp_id=2;
 var c_work_dt=4;
 var c_abs_type=5;
 var c_abs_time=6;
 var c_remain_ale=7;
 var c_app_status=8;
 var c_approver=9;
 var c_approve_pk=10;
 var c_pk=11;
 var c_emp_pk=12;
 var c_close=13;
 var c_status=14;
function BodyInit()
{ 	
    if (v_language!="ENG")
        System.Translate(document);	
    lblName.text = "<%=session("EMP_ID")%>" + "-" +  "<%=session("USER_NAME")%>";
    txtEMP_ID.text= "<%=session("EMP_ID")%>";
	
	iduser_pk.text = "<%=session("USER_PK")%>";
    
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0003' order by code_nm")%>";
       idGrid.SetComboFormat(c_abs_type,t1);
        
	OnChangeMonth();
    
    
}

//------------------------------------
function OnReport(optobj)
{
    
     rpt_no = optobj.value;
        for(var i=0;i<optobj.length;i++)
            if (optobj[i].checked)
                rpt_no = i + 1;
     
        switch (rpt_no)
        {
            case 1:
            {
                if(txtCheckYear.text=="1")
                    sql=2;
                else
                    sql=1;
			    var url =System.RootURL + '/reports/ch/ba/rpt_annual_leave_genu.aspx?p_month='+ dtMonth.value+ '&p_from=' +  dtFrom_Date.value +'&p_to=' + dtTo_Date.value+'&sql='+sql;
                window.open(url);
                break;
            }
            case 2:
            {
			    var url =System.RootURL + '/reports/ch/ba/rpt_attendence_absence_genu.aspx?l_work_mon='+ dtMonth.value+ '&p_from_date=' +  dtFrom_Date.value +'&p_to_date=' + dtTo_Date.value;
                window.open(url);
                break;
            }
            case 3:
            {
			    var url =System.RootURL + '/reports/ch/cs/rpt_salary_pay_slip_genu.aspx?l_work_mon='+ dtMonth.value;
                window.open(url);
                break;
            }
           
        }
   
   
}

function OnReport2(optobj)
{
    rpt_no = optobj.value;
        for(var i=0;i<optobj.length;i++)
            if (optobj[i].checked)
                rpt_no = i + 1;
     
        switch (rpt_no)
        {
            case 1:
            {
                
			    var url =System.RootURL + '/reports/ch/cs/rpt_event_salary_change_genu.aspx';
                window.open(url);
                break;
            }
            case 2:
            {
			    var url =System.RootURL + '/reports/ch/cs/rpt_income_detail_genu.aspx';
                window.open(url);
                break;
            }
           
           
        }
}

function OnChangeMonth()
{
    txtResult.text="";
	datGetRoleEapprove.Call("SELECT");
	//datGet_from_to.Call();
}
//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datGetRoleEapprove":
		{
			datGet_from_to.Call();
			PIT.optYearReport[0].disabled   = false;
			PIT.optYearReport[1].disabled   = false;
			PIT.optYearReport[2].disabled   = false;
			PIT.opt_his[0].disabled   = false;
			PIT.opt_his[1].disabled   = false;
			break;
		}		
		case "datGet_from_to":
		{
              if(txtResult.text=="")
              {
                alert("This Month Not Register.");
              }
			  setEnableButton();
              break;     
	    }		
	    case "datAbs_app":
		{
              auto_resize_column(idGrid,0,idGrid.cols-1,0);
              lblRecord.text=idGrid.rows-1 + " rec(s)";
              break;     
	    }
	    
		
    }
	
}
function onSearch()
{
    datAbs_app.Call("SELECT");
}    
//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function onCheck(obj)
{
    var tmp;
    var ctrl=idGrid.GetGridControl();
    if( obj.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    idGrid.SetGridText(i,0,tmp);
}	
function setEnableButton()
{
	var tmp;
    var ctrl=idGridRole.GetGridControl();
		//PIT.optYearReport[0].checked = 1;
		//PIT.optYearReport[1].disabled   = true;
		//alert(idGridRole.GetGridData(1,0));
            if(idGridRole.GetGridData(1,0)=="00")
            {         
				PIT.optYearReport[0].checked = 0;	
                PIT.optYearReport[0].disabled   = true;
            }  
			if(idGridRole.GetGridData(2,0)=="00")
			{
				PIT.optYearReport[1].checked = 0;	
				PIT.optYearReport[1].disabled   = true;
			}   
			if(idGridRole.GetGridData(3,0)=="00")
			{    
				PIT.optYearReport[2].checked = 0;		
				PIT.optYearReport[2].disabled   = true;
			}   
			if(idGridRole.GetGridData(4,0)=="00")
			{                
				PIT.opt_his[0].checked   = 0;
				PIT.opt_his[0].disabled   = true;
			}   
			if(idGridRole.GetGridData(5,0)=="00")
			{                
				PIT.opt_his[1].checked   = 0;
				PIT.opt_his[1].disabled   = true;
			}   			
}	
function onRegister()
{
    var tmp;
    var ctrl=idGrid.GetGridControl();
    for ( var i =  1 ; i < ctrl.rows ; i++ )
    {
        if(idGrid.GetGridData(i,0)=='-1')
        {
            if(idGrid.GetGridData(i,c_emp_id)!=txtEMP_ID.text)
            {
                alert("You can only register for yourself");
                idGrid.SetGridText(i,0,'0');
            }
            else if(idGrid.GetGridData(i,c_abs_type)=='')
            {
                alert("Please choose absence type");
                idGrid.SetGridText(i,0,'0');
            }
            else if(idGrid.GetGridData(i,c_app_status)=='Y' || idGrid.GetGridData(i,c_app_status)=='C')
            {
                alert("You can only register if status is approved or cancel");
                idGrid.SetGridText(i,0,'0');
            }
            else if(idGrid.GetGridData(i,c_abs_type)=='01' && Number(idGrid.GetGridData(i,c_remain_ale))<=0)
            {
                alert("Remain annual leave is less then 0");
                idGrid.SetGridText(i,0,'0');
            }
        }
        
        
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


<!------------------------------------------------>
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
<!------------------------------------------------------>
<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_from_to" > 
                <input>
                    <input bind="txtSalary" />
                    <input bind="dtMonth" />
                    <input bind="txtTimes" />
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


<gw:data id="datCheck_year" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030019_check_year" > 
                <input>
                    <input bind="dtMonth" />
                </input> 
                <output>
                    <output bind="txtCheckYear" />
                    <output bind="txtMonthClose" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------------>
<gw:data id="datGetRoleEapprove" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="" function="hr_sp_pro_get_role_eapprove" procedure="" > 
                <input bind="idGridRole">
                    <input bind="txtEMP_ID" />
                    <input bind="dtMonth" />                    
                </input>                 
                    <output bind="idGridRole" />    
            </dso> 
        </xml> 
</gw:data>
<!------------------------------TAB 2--------------------------------->

<gw:data id="datAbs_app" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="sp_sel_absence_app" procedure="sp_upd_absence_app"> 
                <input bind="idGrid" >
                   <input bind="txtEMP_ID" /> 
                   <input bind="dtDate1" /> 
                   <input bind="dtDate2" /> 
                   <input bind="lstApproval" /> 
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;">
<form name="My Reports" id="PIT" > 
<table   cellpadding="0" cellspacing="10" style="width:60%;height:60%"   align="center" border="0" >
	<tr height="10%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%"  border="0" >
            <tr height="95%" style="width:100%;"  valign="top"> 
                <td width="90%" colspan="6"  align="center" valign="middle" class="topleft" style="font-family:Times New Roman"><gw:label id="lblName" text="" styles="width:100%;color:#cc0066;font-size:18;font-weight: bold" ></gw:label></td>
                <td width="10%" align="left" valign="middle" class="topright">&nbsp;</td>
            </tr>
            <tr height="5%" style="width:100%;"  valign="top"> 
                <td width="10%"  align="right" valign="middle" class="bottomleft">&nbsp;</td>
                <td width="20%"  align="left" valign="middle"  class="bottom">&nbsp;</td>
                <td width="10%"  align="right" valign="middle" class="bottom">&nbsp;</td>
                <td width="20%"  align="left" valign="middle"  class="bottom">&nbsp;</td>
                <td width="10%"  align="center" valign="middle" class="bottom">&nbsp;</td>
                <td width="20%"  align="left" valign="middle"  class="bottom">&nbsp;</td>
                <td width="10%"  align="left" valign="middle"  class="bottomright">&nbsp;</td>
            </tr>
            
        </table>
      </td>
    </tr>
    <tr height="50%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
			<tr height="5%" style="width:100%;"  valign="top"> 
                <td width="10%"  align="right" valign="middle" class="topleft">Month</td>
                <td width="20%"  align="left" valign="middle"  class="top"><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>"  onchange="OnChangeMonth()"/> </td>
                <td width="10%"  align="right" valign="middle" class="top">From</td>
                <td width="20%"  align="left" valign="middle"  class="top"><gw:datebox id="dtFrom_Date"  text="" maxlen = "10" type="date" lang="<%=Session("Lang")%>" /> </td>
                <td width="10%"  align="center" valign="middle" class="top"><b>~</b></td>
                <td width="20%"  align="left" valign="middle"  class="top"><gw:datebox id="dtTo_Date"  text="" maxlen = "10" type="date" lang="<%=Session("Lang")%>" /> </td>
                <td width="10%"  align="left" valign="middle"  class="topright">&nbsp;</td>
            </tr>
                <tr height="5%" style="width:100%;"  valign="top"> 
                    <td class="topleft"  width="2%" valign="middle" >&nbsp;</td>
			        <td class="top" align="right" width="16%" valign="middle" ><input type="radio" name="optYearReport" value="1"  onclick="datCheck_year.Call()"></td>
                    <td class="top" valign="middle" colspan=4 style="font-size:12"  >Annual Leave <i>- Chi tiết phép năm</i></td>
			        <td align="center" valign="middle" class="topright"  >&nbsp;</td>
                </tr>
                <tr height="5%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" >&nbsp;</td>
                    <td align="right" valign="middle" style="border-left:0;border-right:0"><input type="radio" name="optYearReport" value="2" ></td>
                    <td class="left" valign="middle" colspan=4 style="font-size:12"  style="border-left:0;border-right:0">Working Detail  <i>- Chi tiết công</i></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="5%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0">&nbsp;</td>
			        <td align="right" valign="middle"  style="border-left:0;border-right:0"><input type="radio" name="optYearReport" value="3"  ></td>
                    <td valign="middle" colspan=4 style="font-size:12"  style="border-left:0;border-right:0">Salary Pay-slip  <i>- Phiếu lương</i></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="5%" style="width:100%;"  valign="top"> 
                    <td class="bottomleft"   valign="middle" >&nbsp;</td>
			        <td align="right" valign="middle" class="bottom"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td align=center valign="middle" class="bottomleft" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" class="bottomleft" style="font-size:12"  style="border-left:0;border-right:0"><gw:imgBtn id="ibtnReport_P" alt="Excel Report" img="excel" text="Print" onclick="OnReport(PIT.optYearReport)" /></td>
                    <td  valign="middle" class="bottomleft" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
                    <td  valign="middle" class="bottomleft" style="font-size:12"  style="border-left:0;border-right:0">&nbsp;</td>
			        <td align="center" valign="middle" class="bottomright"  style="border-left:0">&nbsp;</td>
                </tr>
            </table>
	    </td>
	</tr>	
	<tr height="40%">
	    <td  style="width:100%;height:100%">
		    <table style="width:100%;height:100%" border="0" cellpadding="0" cellspacing="0">
		          <tr height="20%" style="width:100%;"  valign="top"> 
                    <td width="10%"  align="right" valign="middle" >&nbsp;</td>
                    <td width="20%"  align="left" valign="middle"  >&nbsp;</td>
                    <td width="10%"  align="right" valign="middle" >&nbsp;</td>
                    <td width="20%"  align="center" valign="middle" style="font-family:Times New Roman"><gw:label id="lblName2" text="History" styles="width:100%;color:#cc0066;font-size:18;font-weight: bold" ></gw:label></td>
                    <td width="10%"  align="center" valign="middle" >&nbsp;</td>
                    <td width="20%"  align="left" valign="middle"  > &nbsp;</td>
                    <td width="10%"  align="left" valign="middle"  >&nbsp;</td>
                </tr>
                <tr height="20%" style="width:100%;"  valign="top"> 
                    <td class="topleft"  width="2%" valign="middle" style="border-right:0">&nbsp;</td>
			        <td class="top" align="right" width="16%" valign="middle" style="border-left:0;border-right:0"><input type="radio" name="opt_his" value="1"   onclick="">&nbsp;</td>
                    <td class="top" valign="middle" colspan=4 style="font-size:12"  style="border-left:0;border-right:0">Salary Event <i>- Thông kê lương</i></td>
			        <td align="center" valign="middle" class="topright"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="20%" style="width:100%;"  valign="top"> 
                    <td class="left"   valign="middle" style="border-right:0">&nbsp;</td>
                    <td align="right" valign="middle" style="border-left:0;border-right:0"><input type="radio" name="opt_his" value="2" >&nbsp;</td>
                    <td valign="middle" colspan=4 style="font-size:12"  style="border-left:0;border-right:0">Income Detail <i>- Chi tiết thu nhập</i></td>
			        <td align="center" valign="middle" class="right"  style="border-left:0">&nbsp;</td>
                </tr>
                <tr height="20%" style="width:100%;"  valign="top"  > 
                    <td class="bottomleft"  valign="middle" >&nbsp;</td>
			        <td class="bottom"  align="right" valign="middle" >&nbsp;</td>
                    <td align=center valign="middle" class="bottom" style="font-size:12" >&nbsp;</td>
                    <td valign="middle" class="bottom" style="font-size:12" ><gw:imgBtn id="ibtnReport_2" alt="Excel Report" img="excel" text="Print" onclick="OnReport2(PIT.opt_his)" /></td>
                    <td valign="middle" class="bottom" style="font-size:12" >&nbsp;</td>
                    <td  class="bottom" style="font-size:12"  >&nbsp;</td>
			        <td align="center" valign="middle" class="bottomright"  style="border-left:0">&nbsp;</td>
					
					
                </tr>
				
				<tr>
				</tr>          
            </table>
	    </td>
	</tr>	
 </table>
</form>
<form name="Absence Management" id="abs" > 
<table   cellpadding="0" cellspacing="0" style="width:100%;height:100%"   valign="middle" border="0" >
	<tr height="6%" >
      <td style="width:100%">
        <table cellpadding="0" style="line-height:normal; padding:0" cellspacing="0" style="width:100%;height:100%" width="100%"  border="0" >
            <tr height="1%">
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
                <td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
            </tr>
            <tr height="5%">
                <td colspan=3 align=right><font color="black" >Select All</font><gw:checkbox id="chkCheckCreate" value="F" onclick="onCheck(chkCheckCreate)" ></gw:checkbox ></td>
                <td colspan=4 style="border:0;" align="right" >Work Date</td>
                <td colspan=5 style="border:0;" align="left" >
                    <gw:datebox id="dtDate1" styles="width:100%" lang="<%=Session("Lang")%>" />
                </td>
                <td style="border:0;" align="center" ><b>~</b></td>
                <td colspan=5 align="left" style="border:0;">
                    <gw:datebox id="dtDate2" styles="width:100%" lang="<%=Session("Lang")%>" />
                </td>
                <td colspan=5 style="border:0;" align="right" >Aproval Status</td>
                <td colspan=5 style="border:0;" align="right" ><gw:list  id="lstApproval" value='ALL' maxlen = "100" styles='width:100%' >
                                <data>|Y|Approved|C|Cancel|R|Register|N|Not Register|ALL|Select All</data></gw:list></td>
                <td colspan=3 align="center"><gw:icon id="idBtnSea" img="in" text="Search" onclick="onSearch()" /></td>                                    
                <td colspan=3 align="center"><gw:icon id="idBtnReg" img="in" text="Register" onclick="onRegister()" /></td>                    
                <td colspan=3 align="center"><gw:icon id="idBtnApp" img="in" text="Approve" onclick="" /></td>                
                <td colspan=3 align="center"><gw:icon id="idBtnCan" img="in" text="Cancel" onclick="" /></td>     
                <td colspan=10 style="border:0;" align="center" ><gw:label id="lblRecord"  text=" " maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>           
            </tr>                
        </table>
      </td>
    </tr>
    <tr style="border:1;width:100%;height:84%" valign="top">
            <td colspan=50  style="width:100%;height:100%;"> 
                 <gw:grid   
                    id="idGrid"  
                    header="Select|WorkGroup|Emp ID|Full Name|Work Date|Absence Type|Hour(s)|Remain ALE|Approval Status|Approver|approve_pk|pk|emp_pk|close_yn|Status"
                    format="3|0|0|0|4|0|0|0|0|0|0|0|0|0|0"  
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                    defaults="||||||||||||||"  
                    editcol="0|0|0|0|0|1|1|0|0|0|0|0|0|0|0"  
                    widths="0|2000|1500|2000|1500|2000|1500|1200|1200|1200|0|0|0|0|0"  
                    styles="width:100%; height:100%" 
                    sorting="T" acceptNullDate   
                    oncelldblclick=""
                    /> 
            </td>
    </tr>
    <tr style="border:1;width:100%;height:84%" valign="top" style="display:none">
	 <td colspan=50  style="width:100%;height:100%;">
			<gw:grid id="idGridRole"  
			header="rpt_id_role|rpt_id|rpt_nm"
			format="0|0|0"  
			aligns="0|0|0"  
			defaults="||"  
			editcol="0|0|0"  
			widths="0|0|0"
			styles="width:100%; height:100%" 
			sorting="T" acceptNullDate   
			oncelldblclick=""			
		/> 
		</td>
	</tr>
	
	
 </table>
</form>
 </gw:tab>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtSalary" text="01" styles="display:none"/>
<gw:textbox id="txtTimes" styles="display:none" />
<gw:textbox id="txtResult"  styles="display:none"/>
<gw:textbox id="txtProcess" styles="display:none" />
<gw:textbox id="txtCheckYear" styles="display:none"/>
<gw:textbox id="txtMonthClose" styles="display:none"/>
<gw:textbox id="txtEMP_ID" styles="display:none"/>



</body>
</html>

