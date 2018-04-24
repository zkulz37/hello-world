
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

//header='_pk|_emp_pk|Organization|Emp ID|Full Name|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction|WDay|Basic|Addition|Transportation|Special Area|Welfare Point
//|Extra Fee|Medical Fee|School Fee|Total Won|Total USD|Amount of Transfer|_wmon|_ext2'

var c_pk=0;
var c_emp_pk=1;
var c_org=2;
var c_emp_id=3;
var c_full_name=4;
var c_basic=5;
var c_overtime=6;
var c_annual=7;
var c_extra=8;
var c_year_hol=9;
var c_total=10;
var c_tax_deduct=11;
var c_wday=12;
var c_basic_2=13;
var c_addition=14;
var c_transportation=15;
var c_special=16;
var c_welfare=17;
var c_extra_fee=18;
var c_medical=19;
var c_school=20;
var c_total_won=21;
var c_total_usd=22;
var c_total_transfer=23;
var c_work_year=24;
var c_ext_rate=25;



var flag_check=0;

function BodyInit()
{
    grdSalary.GetGridControl().FrozenCols =5;
     if (v_language!="ENG")
        System.Translate(document);	
    hide_col_for_bonus(c_wday,c_school);
    datCheck_month.Call();
    
}

function change_header(n)
{
    //header='pk|emp_pk|Organization|Emp ID|Full Name|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction
    //|WDay|Basic|Addition|Transportation|Special Area|Welfare Point|Extra Fee|Medical Fee|School Fee|Total Won|Total USD|Amount of Transfer|wmon|ext2'


    if(n==0)//all
    {
        
        grdSalary.SetGridText(0,c_basic,"Basic");
        grdSalary.SetGridText(0,c_overtime,"Over Time");
        grdSalary.SetGridText(0,c_annual,"Annuti Ins");
        grdSalary.SetGridText(0,c_extra,"Bonus & Extra");
        grdSalary.SetGridText(0,c_year_hol,"Year Holiday");
        grdSalary.SetGridText(0,c_total,"Total");
        grdSalary.SetGridText(0,c_tax_deduct,"Tax Deduction");
        for(i=c_basic; i<=c_total_transfer;i++)
            grdSalary.GetGridControl().ColHidden(i)=0;
        grdSalary.GetGridControl().ColHidden(c_wday)=1;
    }
    else if(n==1) //vietnam
    {
        grdSalary.SetGridText(0,c_basic,"Basic($)");
        grdSalary.SetGridText(0,c_overtime,"Over Time($)");
        grdSalary.SetGridText(0,c_annual,"Annuti Ins($)");
        grdSalary.SetGridText(0,c_extra,"Bonus & Extra($)");
        grdSalary.SetGridText(0,c_year_hol,"Year Holiday($)");
        grdSalary.SetGridText(0,c_total,"Total($)");
        grdSalary.SetGridText(0,c_tax_deduct,"Tax Deduction($)");
        grdSalary.GetGridControl().ColHidden(c_overtime)=1;
        grdSalary.GetGridControl().ColHidden(c_annual)=1;
        grdSalary.GetGridControl().ColHidden(c_basic_2)=1;
        grdSalary.GetGridControl().ColHidden(c_addition)=1;
        grdSalary.GetGridControl().ColHidden(c_transportation)=1;
        grdSalary.GetGridControl().ColHidden(c_special)=1;
        grdSalary.GetGridControl().ColHidden(c_basic_2)=1;
        grdSalary.GetGridControl().ColHidden(c_addition)=1;
        grdSalary.GetGridControl().ColHidden(c_transportation)=1;
        grdSalary.GetGridControl().ColHidden(c_special)=1;
        grdSalary.GetGridControl().ColHidden(c_total_won)=1;
        

    }
     else if(n==2) //korea
    {
        grdSalary.SetGridText(0,c_basic,"Basic(W)");
        grdSalary.SetGridText(0,c_overtime,"Over Time(W)");
        grdSalary.SetGridText(0,c_annual,"Annuti Ins(W)");
        grdSalary.SetGridText(0,c_extra,"Bonus & Extra(W)");
        grdSalary.SetGridText(0,c_year_hol,"Year Holiday(W)");
        grdSalary.SetGridText(0,c_total,"Total(W)");
        grdSalary.SetGridText(0,c_tax_deduct,"Tax Deduction(W)");

        grdSalary.GetGridControl().ColHidden(c_overtime)=0;
        grdSalary.GetGridControl().ColHidden(c_annual)=0;
        grdSalary.GetGridControl().ColHidden(c_basic_2)=0;
        grdSalary.GetGridControl().ColHidden(c_addition)=0;
        grdSalary.GetGridControl().ColHidden(c_transportation)=0;
        grdSalary.GetGridControl().ColHidden(c_special)=0;
        grdSalary.GetGridControl().ColHidden(c_basic_2)=0;
        grdSalary.GetGridControl().ColHidden(c_addition)=0;
        grdSalary.GetGridControl().ColHidden(c_transportation)=0;
        grdSalary.GetGridControl().ColHidden(c_special)=0;
        grdSalary.GetGridControl().ColHidden(c_total_won)=0;
    }
    hide_col_for_bonus(c_wday,c_school);
}

function hide_col_for_bonus(n1,n2)
{
    var i;
    for(i=n1; i<=n2;i++)
            grdSalary.GetGridControl().ColHidden(i)=1;
}

function onchange_source()
{
    if(lstMoney_kind.value=="ALL")
    {
        change_header(0);
    }
    else if(lstMoney_kind.value=="02")
    {
        change_header(1);
    }
    else if(lstMoney_kind.value=="03")
    {
        change_header(2);
    }
    datForeignerSalary.Call("SELECT");

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
        var tmp=1;
        lblRecord.text=grdSalary.rows-1 + " record(s)";
        auto_resize_column(grdSalary,0,grdSalary.cols-1,0);
        if(grdSalary.rows>1)
        {
            for(i=1;i<grdSalary.rows;i++)
            {
                if(tmp<Number(grdSalary.GetGridData(i,c_ext_rate)))
                    tmp=Number(grdSalary.GetGridData(i,c_ext_rate))
            }
            txtExt2.text=tmp;
        }
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
            idBtnDel.SetEnable(0);
        }
        else
        {
            ibtnSave.SetEnable(1);
            idBtnProcess2.SetEnable(1);
            idBtnOpen.SetEnable(0);
            idBtnClose.SetEnable(1);
            idBtnDel.SetEnable(1);
        }
        datForeignerSalary.Call("SELECT");
        
   }
   if (obj.id=="datCloseOpen")
   {
        if(txtFlag2.text=='0')
        {
            if(flag_check==2)//open
            {
                alert("Open Successful.")
                ibtnSave.SetEnable(1);
                idBtnProcess2.SetEnable(1);
                idBtnOpen.SetEnable(0);
                idBtnClose.SetEnable(1);
                idBtnDel.SetEnable(1);

            }
            else if(flag_check==3)//close
            {
                alert("Close Successful.")
                ibtnSave.SetEnable(0);
                idBtnProcess2.SetEnable(0);
                idBtnOpen.SetEnable(1);
                idBtnClose.SetEnable(0);
                idBtnDel.SetEnable(0);
            }
            else if(flag_check==4)//del
            {
                alert("Del Successful.")
                ibtnSave.SetEnable(1);
                idBtnProcess2.SetEnable(1);
                idBtnOpen.SetEnable(0);
                idBtnClose.SetEnable(1);
                idBtnDel.SetEnable(1);
                datForeignerSalary.Call("SELECT");
            }
        }
        else
            alert("There is Error occur!")


   }
   
  
}
//-------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}



//----------------------------------------------------
function OnSave()
{
    var i;
    if (confirm("Do you want to save data? \n Bạn có lưu không?"))
    {
        for(i=1;i<grdSalary.rows;i++)
        {
            if(grdSalary.GetGridData(i,c_pk)=='')
            {
                grdSalary.SetRowStatus(i,16);
                grdSalary.SetGridText(i,c_ext_rate,txtExt2.text);
            }
        }
        datForeignerSalary.Call();
    }
}


//----------------------------------------------------
function OnReport(obj)
{
    if(lstRpt.value=="01")   
        var url =System.RootURL + '/reports/ch/cs/rpt_foreigner_bonus_posco_ss.aspx?p_year='+dtYear.value+'&p_tco_org_pk='+lstOrg.value;
    else
        var url =System.RootURL + '/reports/ch/cs/rpt_foreigner_bonus_posco_ss.aspx?p_year='+dtYear.value+'&p_tco_org_pk='+lstOrg.value;
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
                grdSalary.SetGridText(i,c_ext_rate,txtExt2.text);
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
    else if(n==4)
    {
        txtFlag2.text="DEL";
        flag_check=4;
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
        grdSalary.SetCellBgColor(1, c_extra,grdSalary.rows-1, c_extra, 0xCC9900 );
        grdSalary.SetCellBold(1, c_extra,grdSalary.rows-1, c_extra, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_tax_deduct,grdSalary.rows-1, c_tax_deduct, 0xCC9900 );
        grdSalary.SetCellBold(1, c_tax_deduct,grdSalary.rows-1, c_tax_deduct, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_wday,grdSalary.rows-1, c_wday, 0xCC9900 );
        grdSalary.SetCellBold(1, c_wday,grdSalary.rows-1, c_wday, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_welfare,grdSalary.rows-1, c_welfare, 0xCC9900 );
        grdSalary.SetCellBold(1, c_welfare,grdSalary.rows-1, c_welfare, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_medical,grdSalary.rows-1, c_medical, 0xCC9900 );
        grdSalary.SetCellBold(1, c_medical,grdSalary.rows-1, c_medical, 0xCC9900 );

        grdSalary.SetCellBgColor(1, c_school,grdSalary.rows-1, c_school, 0xCC9900 );
        grdSalary.SetCellBold(1, c_school,grdSalary.rows-1, c_school, 0xCC9900 );
        
    }
}
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datCheck_month" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_month_00230" > 
                <input>
					<input bind="dtYear" />	
                </input> 
                <output>
                    <output bind="txtFlag" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCloseOpen" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_close_open_00230" > 
                <input>
					<input bind="dtYear" />
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
            <dso  type="grid"  function="HR_sp_sel_sal_00230" procedure="HR_sp_upd_sal_00230" parameter="0,1,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25"> 
                <input bind="grdSalary">
                    <input bind="lstMoney_kind" />
					<input bind="lstOrg" />
					<input bind="dtYear" /> 
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
                        <td colspan=3  align=right><font color="black">Source </font></td>
                        <td colspan=5 align=right ><gw:list  id="lstMoney_kind" value='03' maxlen = "100" styles='width:100%' onchange="onchange_source()" >
                            <data>|02|VietNam|03|Korea|ALL|Select All</data></gw:list></td>
                        <td colspan=5  align=right><font color="black">Organization </font></td>
						<td colspan=12 style="border:0;" align="left" ><gw:list  id="lstOrg" value='ALL' onchange=""   styles='width:100%' >
									<data><%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')||a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan=3 align=right><font color="black">Year </font></td>
			            <td colspan=4 align="left"   ><gw:datebox id="dtYear" type="year" styles='width:100%'   lang="<%=Session("Lang")%>" onchange="onChangeMonth()"/></td>
			            
                        <td colspan=3 align=right>Emp ID</td>
                        <td colspan=3 align="left" ><gw:textbox id="txtEmpID"   styles='width:100%' onenterkey="OnSearch(datForeignerSalary)"/> </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                            <gw:imgBtn img="Search" id="ibtnSearch"    alt="Search"  onclick="OnSearch(datForeignerSalary)"/>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                           <gw:imgBtn img="save" id="ibtnSave"   alt="Save"  onclick="OnSave()"/></td>
                        <td align="right">&nbsp;</td>
                        <td colspan=5 align=right ><gw:list  id="lstRpt" value='01' maxlen = "100" styles='width:100%' >
                            <data>|01|Bonus Payment</data></gw:list></td>
                       
                        <td align="right"><gw:imgBtn img="excel" id="ibtnReport"   alt="Report"  onclick="OnReport()"/></td>
                        <td align="right">&nbsp;</td>

                    </tr>
					
                    <tr style="border:0;width:100%;height:5%" valign="middle"  >

                        <td colspan=2 align=left>&nbsp;</td>
                        <td colspan=3 align=right>USD/WON:</td>
                        <td colspan=4 align="left" ><gw:textbox id="txtExt2" type="number" format="#,###,###,###.##R"  styles='width:100%' onenterkey=""/> </td>
                        <td colspan=4 align="center" ><gw:icon id="idBtnProcess2" img="in" text="Calculate All" onclick="on_Process(1)" /></td>
                        <td colspan=2 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="on_Process(2)" /></td>
                        <td colspan=2 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="on_Process(3)" /></td>
                        <td colspan=4 align="center" ><gw:icon id="idBtnDel" img="in" text="Delete" onclick="on_Process(4)" /></td>
                        <td colspan=2 align="center" >&nbsp;</td>
                        <td colspan=20 align=center><gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                    </tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                         <gw:grid id='grdSalary'
                            header='_pk|_emp_pk|Organization|Emp ID|Full Name|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction|_WDay|Basic|Addition|Transportation|Special Area|Welfare Point|Extra Fee|Medical Fee|School Fee|Total Won|Total USD|Amount of Transfer|_wyear|_ext2'
                            format='0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|1'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='|||||||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|1|1|0|1|1|0|0|0|0|1|0|1|1|0|0|0|0|0'
                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
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
