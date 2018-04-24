<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var row=0;
var value_before;
var flag=0;
var icstatus,icstatus_text,icreason,icbiz_trip_pk;
function BodyInit()
{
    ibtnCancel.SetEnable(false);
    icbiz_trip_pk=0;
    icstatus=11;
    icstatus_text=10;
    icreason=12;
    if (v_language!="ENG")
        System.Translate(document);  
    grdEmployee.GetGridControl().ColFormat(8) = "(###,###,###.##)"; 
}
function enable_button(n)
{
    
}

//---------------------------------------
function OnSearch()
{
    datView_Biz_Trip.Call("SELECT");
}
//---------------------------------------

function OnDataReceive(obj)
{
    if(obj.id=="datView_Biz_Trip")
        lblRecord.text=grdEmployee.rows-1 +" rec(s)";
    else if (obj.id=="datGetCancel_Biztrip")
    {
        if (txtStatus.text!=-1)
        {
            alert("Cancel this applicant successful! \n Huỷ đơn thành công!");
            grdEmployee.SetGridText(irow,icstatus_text,txtStatus_Text.text);
            grdEmployee.SetGridText(irow,icstatus,txtStatus.text);
        }
        else
            alert("Cancel this applicant unsuccessful! \n Huỷ đơn thất bại!") 
    }    
     
}
//---------------------------------------

function on_click()
{
    var ctrl=idGrid1.GetGridControl()
    if(ctrl.rows>1)
    {
        txtBiz_pk.text=idGrid1.GetGridData(ctrl.row,0)
        flag=0;
        datGet_total.Call();
    }    
    
}
//------------------------------------------
function OnShowEmp()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	{
	        txtEmp_PK.text=obj[0];
	        txtEmp_ID.text=obj[1];
	        txtFull_Name.text=obj[2];
	}
}
//-----------------------------------------------------------
function OnSelect()
{
    irow=grdEmployee.row;
    if (irow>=1)
    {
        txtaReason.SetDataText(grdEmployee.GetGridData(irow,icreason));
        if (grdEmployee.GetGridData(irow,icstatus) == 4 ||grdEmployee.GetGridData(irow,icstatus) == 5 )  // Request information or Reject
            ibtnCancel.SetEnable(true);
        else
            ibtnCancel.SetEnable(false);   
            
    }
    
    
}
//---------------------------------------------
function OnReset()
{
    txtEmp_PK.text="";
    txtEmp_ID.text="";
    txtFull_Name.text="";
}
function OnCancel()
{
    irow=grdEmployee.row;
    if (irow >=1)
    {
        txtBiz_pk.text=grdEmployee.GetGridData(irow,icbiz_trip_pk);
        if (confirm("Do you want to cancel this applicant? \n Bạn có muốn huỷ đơn này không?"))
            datGetCancel_Biztrip.Call();
    }
}
</script>
<body >

<!-------------------data control----------------------->
<!----------------------------------->
<gw:data id="datView_Biz_Trip" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_view_biz_trip"> 
                <input  bind="grdEmployee" >
                    <input bind="txtPeriod_From" />
                    <input bind="txtPeriod_To" />
                    <input bind="lstStatus" />
                    <input bind="txtEmp_ID" />
                    <input bind="txtFull_Name" />
                    <input bind="txtEmp_PK" />
                    <input bind="txtSubmit_From" />
                    <input bind="txtSubmit_To" />
                    <input bind="lstB_Type" />
                    <input bind="lstB_Object" />
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>    
<!----------------------------------->
<gw:data id="datGetCancel_Biztrip" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_cancel_biztrip" > 
                <input>                    
                   <input bind="txtBiz_pk" />
                </input> 
                <output>
                   <output bind="txtStatus" />
                   <output bind="txtStatus_Text" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<table id="Settle" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        
                        <td colspan=3 width="8%" style="border:0;" align="right" ><b>Period</b></td>
                        <td colspan=5 width="10%" style="border:0;" align="right" ><gw:datebox id="txtPeriod_From" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept /></td>
                        <td width="2%" style="border:0;" align="right" ><b>~</b></td>
                        <td colspan=5 width="10%" style="border:0;" align="right" ><gw:datebox id="txtPeriod_To" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td colspan=3 width="8%" style="border:0;" align="right" ><b>Status</b></td>
                        <td colspan=6 width="14%" style="border:0;" align="right" ><gw:list  id="lstStatus" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0069' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><a title="Click here to show applicant" onclick="OnShowEmp()" href="#tips" >Applicant</a></td>
                        <td colspan=4 width="9%" style="border:0;" align="right" ><gw:textbox id="txtEmp_ID"  text="" maxlen = "100"  styles="color:green;width:100%;font-weight:bold" onenterkey="OnSearch()"  /></td>
                        <td colspan=8 width="16%" style="border:0;" align="right" ><gw:textbox id="txtFull_Name"  text="" maxlen = "100" styles="color:red;width:100%;font-weight: bold" onenterkey="OnSearch()" /></td>
                        <td width="3%" style="border:0;" align="right" ><gw:imgBtn img="reset" id="ibtnReset"   alt="Reset"  onclick="OnReset()"/></td>
                        <td width="3%" style="border:0;" align="right" ></td>
                        <td width="3%" style="border:0;" align="right" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="3%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnCancel"   alt="Cancel"  onclick="OnCancel()"/></td>
                        <td width="3%" style="border:0;" align="right" ><gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/></td>
                    </tr>
                     <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=3  style="border:0;" align="right" ><b>Submit date</b></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:datebox id="txtSubmit_From" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept /></td>
                        <td  style="border:0;" align="right" ><b>~</b></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:datebox id="txtSubmit_To" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td colspan=3  style="border:0;" align="right" ><b>B_Type</b></td>
                        <td colspan=6  style="border:0;" align="right" ><gw:list  id="lstB_Type" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0060' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list >
                        </td>
                        <td colspan=4  style="border:0;" align="right" ><b>Biz Object</b></td>
                        <td colspan=8  style="border:0;" align="right" ><gw:list  id="lstB_Object" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0059' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list >
                        </td>
                        <td colspan=4  style="border:0;" align="right" ></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
                    </tr>
                    <tr style="border:0;width:100%;height:65%" valign="center" >
                        <td colspan=46 style="width:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="_Biz_PK|Sumit time|Application No|Applicant ID|Full Name|From|To|Type|Object|Total Expenses|Status|_Status_PK|_Reason"   
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|3|0|0|0"    
                                defaults="||||||||||||"    
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1400|1400|1500|2400|1200|1200|1500|1500|1500|1500|0|0"  
                                styles="width:100%; height:100%"   
                                sorting="T" onclick="OnSelect()" /> 
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=46 style="width:100%">Reason 
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:20%" valign="center" >
                        <td colspan=46 style="width:100%;"><gw:textarea id="txtaReason" styles="width:100%;height:96%;font-size:15"/>
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>  
</table>

<!----------------------------------->
<gw:textbox id="txtBiz_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtEmp_PK"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtStatus"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtStatus_Text"  text="" maxlen = "100"  styles="display:none"/>
</body>
</html>


