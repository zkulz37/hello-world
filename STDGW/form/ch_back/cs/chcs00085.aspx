
<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var bgrp=false;
var v_language = "<%=Session("SESSION_LANG")%>";
var c_pk=0;
var c_emp_pk=1;
var c_org=2;
var c_emp_id=3;
var c_full_name=4;
var c_sal=5;
var c_bonus=6;
var c_annual=7;
var c_birthday=8;
var c_active=9;
var c_total_net=10;
var c_sal_before_pit=11;
var c_gross_before_pit=12;
var c_gross_before_deduct=13;
var c_health_ins=14;
var c_medical=15;
var c_school_fee=16;
var c_passport_fee=17;
var c_visa_fee=18;
var c_work_permit=19;
var c_residence_card=20;
var c_air_ticket=21;
var c_golf_fee=22;
var c_other_fee=23;
var c_sub_other=24;
var c_total_income_1=25;
var c_house_pay=26;
var c_taxable_housing=27;
var c_total_income_2=28;
var c_sal_taxable_1=29;
var c_payalbe_income=30;
var c_payable_payer=31;
var c_sal_taxable_2=32;
var c_pit_1=33;
var c_pit_2=34;
var c_total_pit=35;
var c_work_mon=36;
var c_usd_vnd=37;


var flag_check=0;

function BodyInit()
{
    grdSalary.GetGridControl().FrozenCols =5;
     if (v_language!="ENG")
        System.Translate(document);	
    datCheck_month.Call();
    
}

//-------------------------------
function OnSearch(datobj)
{
    datobj.Call("SELECT");
}
//-------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datForeignerSalary")
   {
        
        lblRecord.text=grdSalary.rows-1 + " record(s)";
        auto_resize_column(grdSalary,0,grdSalary.cols-1,0);
        if(grdSalary.rows>1)
            txtExt2.text=grdSalary.GetGridData(1,c_usd_vnd);

        col_edit_color();
   }
   if (obj.id=="datCheck_month")
   {
        if(txtFlag.text=='1')// da dong
        {
            ibtnSave.SetEnable(0);
            idBtnProcess2.SetEnable(0);
            idBtnOpen.SetEnable(1);
            idBtnClose.SetEnable(0);
        }
        else
        {
            ibtnSave.SetEnable(1);
            idBtnProcess2.SetEnable(1);
            idBtnOpen.SetEnable(0);
            idBtnClose.SetEnable(1);
        }
        datForeignerSalary.Call("SELECT");
        
   }
   if (obj.id=="datCloseOpen")
   {
        if(flag_check==2)
        {
            alert("Open Successful.")
            ibtnSave.SetEnable(1);
            idBtnProcess2.SetEnable(1);
            idBtnOpen.SetEnable(0);
            idBtnClose.SetEnable(1);

        }
        else
        {
            alert("Close Successful.")
            ibtnSave.SetEnable(0);
            idBtnProcess2.SetEnable(0);
            idBtnOpen.SetEnable(1);
            idBtnClose.SetEnable(0);
        }

   }
   
  
}
//-------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------
function OnPrint(obj)
{
   
    
    
}



//----------------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save data? \n Bạn có lưu không?"))
    {
        datForeignerSalary.Call();
    }
}


//----------------------------------------------------
function OnReport(obj)
{
    if(lstRpt.value=="01")
        var url =System.RootURL + '/reports/ch/cs/rpt_pit_posco_ss.aspx?p_work_mon='+dtMonth.value+'&p_tco_org_pk='+lstOrg.value;
    else
        var url =System.RootURL + '/reports/ch/cs/rpt_request_payment_pit.aspx?p_work_mon='+dtMonth.value+'&p_tco_org_pk='+lstOrg.value;
   window.open(url);
}

function on_Process(n)
{
    var i;
    if(n==1) //calculate all
    {
        if(txtExt2.text=='0' || txtExt2.text=='' || txtExt2.text=='1')
        {
            alert("Please input ext rate");
            return;
        }
        else
        {
            for(i=1;i<grdSalary.rows;i++)
            {
                grdSalary.SetGridText(i,c_usd_vnd,txtExt2.text);
                grdSalary.SetRowStatus(i,16);
            }
           if(confirm("Do you want to calculate all?"))
                datForeignerSalary.Call();
        }

    }
    else if(n==2)
    {
        txtFlag2.text="OPEN";
        flag_check=2;
        datCloseOpen.Call();
    }
    else if(n==3)
    {
        txtFlag2.text="CLOSE";
        flag_check=3;
        datCloseOpen.Call();
    }

}
function onChangeMonth()
{
    datCheck_month.Call();
}
function col_edit_color()
{
    var i;
    if(grdSalary.rows>1)
    {
        grdSalary.SetCellBgColor(1, c_birthday,grdSalary.rows-1, c_birthday, 0xCC9900 );
        grdSalary.SetCellBold(1, c_birthday,grdSalary.rows-1, c_birthday, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_active,grdSalary.rows-1, c_active, 0xCC9900 );
        grdSalary.SetCellBold(1, c_active,grdSalary.rows-1, c_active, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_medical,grdSalary.rows-1, c_medical, 0xCC9900 );
        grdSalary.SetCellBold(1, c_medical,grdSalary.rows-1, c_medical, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_passport_fee,grdSalary.rows-1, c_passport_fee, 0xCC9900 );
        grdSalary.SetCellBold(1, c_passport_fee,grdSalary.rows-1, c_passport_fee, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_visa_fee,grdSalary.rows-1, c_visa_fee, 0xCC9900 );
        grdSalary.SetCellBold(1, c_visa_fee,grdSalary.rows-1, c_visa_fee, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_work_permit,grdSalary.rows-1, c_work_permit, 0xCC9900 );
        grdSalary.SetCellBold(1, c_work_permit,grdSalary.rows-1, c_work_permit, 0xCC9900 );
        

        grdSalary.SetCellBgColor(1, c_residence_card,grdSalary.rows-1, c_residence_card, 0xCC9900 );
        grdSalary.SetCellBold(1, c_residence_card,grdSalary.rows-1, c_residence_card, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_air_ticket,grdSalary.rows-1, c_air_ticket, 0xCC9900 );
        grdSalary.SetCellBold(1, c_air_ticket,grdSalary.rows-1, c_air_ticket, 0xCC9900 );
        

        grdSalary.SetCellBgColor(1, c_golf_fee,grdSalary.rows-1, c_golf_fee, 0xCC9900 );
        grdSalary.SetCellBold(1, c_golf_fee,grdSalary.rows-1, c_golf_fee, 0xCC9900 );
        
        grdSalary.SetCellBgColor(1, c_other_fee,grdSalary.rows-1, c_other_fee, 0xCC9900 );
        grdSalary.SetCellBold(1, c_other_fee,grdSalary.rows-1, c_other_fee, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_house_pay,grdSalary.rows-1, c_house_pay, 0xCC9900 );
        grdSalary.SetCellBold(1, c_house_pay,grdSalary.rows-1, c_house_pay, 0xCC9900 );
        
        
    }
}
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datCheck_month" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_month_00085" > 
                <input>
					<input bind="dtMonth" />	
                </input> 
                <output>
                    <output bind="txtFlag" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCloseOpen" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_close_open_00085" > 
                <input>
					<input bind="dtMonth" />
                    <input bind="txtFlag2" />
                </input> 
                <output>
                    <output bind="txtFlag2" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datForeignerSalary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_sp_sel_sal_foreigner" procedure="HR_sp_upd_sal_foreigner" parameter="0,1,5,6,7,8,9,15,16,17,18,19,20,21,22,23,26,36,37"> 
                <input bind="grdSalary">
					<input bind="lstOrg" />
					<input bind="dtMonth" /> 
                    <input bind="txtEmpID" /> 
                </input> 
                <output bind="grdSalary"/>
            </dso> 
        </xml> 
</gw:data>

    <table name="Detail" id="management" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:12%" border=0 cellpadding="0" cellspacing="0">
				<tr style="border:0;width:100%;height:1%" valign="center" >
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
				</tr>   
				 <tr style="border:0;width:100%;height:5%" valign="middle"  >
                        <td colspan=5  align=right><font color="black">Organization </font></td>
						<td colspan=12 style="border:0;" align="left" ><gw:list  id="lstOrg" value='ALL' onchange=""   styles='width:100%' >
									<data><%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')||a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan=5 align=right><font color="black">Month </font></td>
			            <td colspan=5 align="left"   ><gw:datebox id="dtMonth" type="month" styles='width:100%'   lang="<%=Session("Lang")%>" onchange="onChangeMonth()"/></td>
			            <td colspan=1 align="left"   >&nbsp;</td>
                        <td colspan=3 align=right>Emp ID</td>
                        <td colspan=5 align="left" ><gw:textbox id="txtEmpID"   styles='width:100%' onenterkey="OnSearch(datForeignerSalary)"/> </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                            <gw:imgBtn img="Search" id="ibtnSearch"    alt="Search"  onclick="OnSearch(datForeignerSalary)"/>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                           <gw:imgBtn img="save" id="ibtnSave"   alt="Save"  onclick="OnSave()"/></td>
                        <td align="right">&nbsp;</td>
                        <td colspan=6 align=right ><gw:list  id="lstRpt" value='01' maxlen = "100" styles='width:100%' >
                            <data>|01|PIT Information|02|Request Payment</data></gw:list></td>
                       
                        <td align="right"><gw:imgBtn img="excel" id="ibtnReport"   alt="Report"  onclick="OnReport()"/></td>
                         <td colspan=2 align="right">&nbsp;</td>

                    </tr>
					
                    <tr style="border:0;width:100%;height:5%" valign="middle"  >
                        <td colspan=2 align=left>&nbsp;</td>
                        <td colspan=3 align=right>USD/VND:</td>
                        <td colspan=5 align="left" ><gw:textbox id="txtExt2" type="number" format="#,###,###,###.##R"  styles='width:100%' onenterkey=""/> </td>
						<td colspan=3 align=right>&nbsp;</td>
                        <td colspan=2 align="left" >&nbsp; </td>
                        <td colspan=5 align="center" ><gw:icon id="idBtnProcess2" img="in" text="Calculate All" onclick="on_Process(1)" /></td>
                        <td colspan=2 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="on_Process(2)" /></td>
                        <td colspan=2 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="on_Process(3)" /></td>
                        <td colspan=18 align=center><gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                    </tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                         <gw:grid id='grdSalary'
                            header='_pk|_emp_pk|Organization|Emp ID|Full Name|Salary($)|Bonus($)|Annual($)|Birthday($)|Active Allow(Đ)|Total Net(Đ)|Salary Before PIT|Gross Before PIT|Gross Before Deduct|Medical Ins(Đ)|Medical Fee(Đ)|School Fee(Đ)|Passport Fee|Visa Fee(Đ)|Work Permit(Đ)|Residence Card(Đ)|Air Ticket(Đ)|Golf Fee(Đ)|Other Fee(Đ)|Sub Other|Total Income|House pay|Taxable Housing|Total Income|Sal Taxable|Payable Income|Payable(Payer)|Sal Taxable(2)|PIT|PIT2|Total PIT|_wmon|_ext2'
                            format='0|0|0|0|0|1|1|1|1|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|0|-0'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='||||||||||||||||||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0|1|0|0|0|0|0|0|0|0|0|0'
                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='F'
                            styles='width:100%; height:100%'
                            onafteredit=""
                            oncelldblclick="" /> 
                             />
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
 
</body>
<gw:textbox id="txtFlag"   styles='width:100%;display:none' onenterkey=""/> 
<gw:textbox id="txtFlag2"   styles='width:100%;display:none' onenterkey=""/> 

</html>
