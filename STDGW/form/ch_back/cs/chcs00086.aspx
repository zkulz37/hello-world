
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

//header='_pk|_emp_pk|WORK_YEAR|FROM|TO|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction|Basic|Addition|Transportation|Special Area|Extra Fee'

var c_pk=0;
var c_emp_pk=1;
var c_emp_id=2;
var c_full_name=3;
var c_work_year=4;
var c_from=5;
var c_to=6;
var c_basic=7;
var c_overtime=8;
var c_annual=9;
var c_extra=10;
var c_year_hol=11;
var c_total=12;
var c_tax_deduct=13;
var c_basic_2=14;
var c_addition=15;
var c_transportation=16;
var c_special=17;
var c_extra_fee=18;




var flag_check=0;

function BodyInit()
{
    grdSalary.GetGridControl().FrozenCols =5;
     if (v_language!="ENG")
        System.Translate(document);	
    datCheck_year.Call();
    
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
    datYearlyBasic.Call("SELECT");

}
function change_header(n)
{
    //header='pk|emp_pk|FULL NAME|WORK_YEAR|FROM|TO|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction
    //|Basic($)|Addition($)|Transportation($)|Special Area(W)'
    if(n==0)//all
    {
        
        grdSalary.SetGridText(0,c_basic,"Basic");
        grdSalary.SetGridText(0,c_overtime,"Over Time");
        grdSalary.SetGridText(0,c_annual,"Annuti Ins");
        grdSalary.SetGridText(0,c_extra,"Bonus & Extra");
        grdSalary.SetGridText(0,c_year_hol,"Year Holiday");
        grdSalary.SetGridText(0,c_total,"Total");
        grdSalary.SetGridText(0,c_tax_deduct,"Tax Deduction");
        for(i=c_basic; i<=c_extra_fee;i++)
            grdSalary.GetGridControl().ColHidden(i)=0;
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
    }
}

//-------------------------------
function OnSearch(datobj)
{
    datobj.Call("SELECT");
}
//-------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datYearlyBasic")
   {
        
        lblRecord.text=grdSalary.rows-1 + " record(s)";
        auto_resize_column(grdSalary,0,grdSalary.cols-1,0);
       
   }
   if (obj.id=="datCheck_year")
   {
        if(txtFlag.text=='Y')// da dong
        {
            ibtnSave.SetEnable(0);
            idBtnRelicate.SetEnable(0);
            idBtnOpen.SetEnable(1);
            idBtnClose.SetEnable(0);
            idBtnDel.SetEnable(0);
        }
        else
        {
            ibtnSave.SetEnable(1);
            idBtnOpen.SetEnable(0);
            idBtnClose.SetEnable(1);
            if(txtFlag.text=='X') //chua co du lieu
            {
                idBtnRelicate.SetEnable(1);
                idBtnDel.SetEnable(0);
            }
            else
            {
                idBtnRelicate.SetEnable(0);
                idBtnDel.SetEnable(1);
            }

                
        }
        datYearlyBasic.Call("SELECT");
       
        
   }
   if (obj.id=="datCloseOpen")
   {
      
      if(txtFlag2.text=='0')  
      {
            if(flag_check==2)
            {
                alert("Open Successful.")
                ibtnSave.SetEnable(1);
                idBtnOpen.SetEnable(0);
                idBtnClose.SetEnable(1);
                idBtnDel.SetEnable(1);

            }
            else if(flag_check==3)
            {
                alert("Close successful.")
                ibtnSave.SetEnable(1);
                idBtnOpen.SetEnable(0);
                idBtnClose.SetEnable(1);
                idBtnDel.SetEnable(0);
            }
            else if(flag_check==4)
            {
                alert("Delete successful.")
                ibtnSave.SetEnable(1);
                idBtnOpen.SetEnable(0);
                idBtnClose.SetEnable(1);
                idBtnDel.SetEnable(1);
                datCheck_year.Call();
            }
        }
   }

   if(obj.id=="datCheck_Replicate")
   {
        if(txtFlag2.text=='1')
        {
             if(confirm("Do you want to make replicate?"))
                datReplicate.Call();
        }
   }
   if(obj.id=="datReplicate")
   {
        datCheck_year.Call();
        
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
    if (confirm("Do you want to save data? \n Bạn có lưu không?"))
    {
        for(i=1;i<grdSalary.rows;i++)
            {
                if(grdSalary.GetGridData(i,c_from)=='')
                {
                    grdSalary.SetGridText(i,c_from,dtMonth_f.value);
                    grdSalary.SetGridText(i,c_to,dtMonth_t.value);    
                    grdSalary.SetRowStatus(i,16);
                }
            }
        datYearlyBasic.Call();
    }
}


//----------------------------------------------------
function OnReport(obj)
{
    var url =System.RootURL + '/reports/ch/cs/rpt_pit_posco_ss.aspx?p_work_mon='+dtMonth.value+'&p_tco_org_pk='+lstOrg.value;
   window.open(url);
}


function onChangeMonth()
{
    datCheck_month.Call();
}
function on_Replicate()
{
    if(dtYear.value!=dtYear2.value)
        datCheck_Replicate.Call();
    else 
        alert("You can't replicate as same current year");
    


    
}
function on_Process(n)
{
    flag_check=n;
    if(n==2)
    {
        if(confirm("Do you want to open?"))
        {
            txtFlag2.text="OPEN";
            datCloseOpen.Call();
        }
    }
    else if(n==3)
    {
        if(confirm("Do you want to close?"))
        {
            txtFlag2.text="CLOSE";
            datCloseOpen.Call();
        }
    }
    else if(n==4)
    {
        if(confirm("Do you want to delete?"))
        {
            txtFlag2.text="DEL";
            datCloseOpen.Call();
        }
    }
}

</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datCheck_year" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_year_00086" > 
                <input>
					<input bind="dtYear" />	
                </input> 
                <output>
                    <output bind="txtFlag" />
                    <output bind="dtMonth_f" />
                    <output bind="dtMonth_t" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCheck_Replicate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_year_00086_2" > 
                <input>
					<input bind="dtYear2" />	
                </input> 
                <output>
                    <output bind="txtFlag2" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datCloseOpen" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_close_open_00086" > 
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

<gw:data id="datReplicate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_replicate_00086" > 
                <input>
					<input bind="dtYear" />
                    <input bind="dtYear2" />
                    <input bind="dtMonth_f" /> 
                    <input bind="dtMonth_t" /> 
                </input> 
                <output>
                    <output bind="txtFlag2" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datYearlyBasic" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="HR_sp_sel_yearly_00086" procedure="HR_sp_upd_yearly_00086" parameter="0,1,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"> 
                <input bind="grdSalary">
                    <input bind="lstMoney_kind" />
                    <input bind="lstOrg" />
					<input bind="dtYear" /> 
                    <input bind="dtMonth_f" /> 
                    <input bind="dtMonth_t" /> 
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
                        <td colspan=4  align=right><font color="black">Source </font></td>
                        <td colspan=4 align=right ><gw:list  id="lstMoney_kind" value='ALL' maxlen = "100" styles='width:100%' onchange="onchange_source()" >
                            <data>|02|VietNam|03|Korea|ALL|Select All</data></gw:list></td>
                        <td colspan=5  align=right><font color="black">Organization </font></td>
						<td colspan=10 style="border:0;" align="left" ><gw:list  id="lstOrg" value='ALL' onchange=""   styles='width:100%' >
									<data><%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')||a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan=3 align=right><font color="black">Year </font></td>
			            <td colspan=3 align="left"   ><gw:datebox id="dtYear" type="year" styles='width:100%'   lang="<%=Session("Lang")%>" onchange="datCheck_year.Call()"/></td>
                        <td colspan=5 align="right">Month From</td>
                        <td colspan=3 align="left"   ><gw:datebox id="dtMonth_f" type="month" styles='width:100%'   lang="<%=Session("Lang")%>" onchange=""/></td>
                        <td colspan=1 align="center" >~</td>
                        <td colspan=3 align="left"   ><gw:datebox id="dtMonth_t" type="month" styles='width:100%'   lang="<%=Session("Lang")%>" onchange=""/></td>
			            
                        <td colspan=3 align=right>Emp ID</td>
                        <td colspan=5 align="left" ><gw:textbox id="txtEmpID"   styles='width:100%' onenterkey="OnSearch(datYearlyBasic)"/> </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                            <gw:imgBtn img="Search" id="ibtnSearch"    alt="Search"  onclick="OnSearch(datYearlyBasic)"/>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="right">
                           <gw:imgBtn img="save" id="ibtnSave"   alt="Save"  onclick="OnSave()"/></td>
                        
                    </tr>
					
                    <tr style="border:0;width:100%;height:5%" valign="middle"  >

                        <td colspan=8 align=right><font color="black">Replicate From </font></td>
			            <td colspan=5 align="left"   ><gw:datebox id="dtYear2" type="year" styles='width:100%'   lang="<%=Session("Lang")%>" onchange=""/></td>
                        <td colspan=5 align="center" ><gw:icon id="idBtnRelicate" img="in" text="Replicate" onclick="on_Replicate()" /></td>
                        <td colspan=2 align=left>&nbsp;</td>
                        <td colspan=3 align=right>&nbsp;</td>
                        <td colspan=4 align="center" >&nbsp;</td>
                        <td colspan=2 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="on_Process(2)" /></td>
                        <td colspan=1 align="center" >&nbsp;</td>
						<td colspan=4 align="center" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="on_Process(3)" /></td>
                        <td colspan=1 align="center" >&nbsp;</td>
                        <td colspan=4 align="center" ><gw:icon id="idBtnDel" img="in" text="Delete" onclick="on_Process(4)" /></td>
                        <td colspan=8 align=center><gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                    </tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                         <gw:grid id='grdSalary'
                            header='_pk|_emp_pk|Emp ID|FULL NAME|_WORK_YEAR|_FROM|_TO|Basic|Over Time|Annuti Ins|Bonus & Extra|Year Holiday|Total|Tax Deduction|Basic($)|Addition($)|Transportation($)|Special Area(W)|Extra Fee($)'
                            format='0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='||||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|1|1|1|1|1|0|1|1|1|1|1|1'
                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
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
