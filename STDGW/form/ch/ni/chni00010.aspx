<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("HR")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var flag_page_load=0;
var v_dor_pk;
function BodyInit()
{ 
	datIdcard_User_info.Call();
	
	txtOption.text = "0";
	txtName.SetEnable(false);
	txtEmpId.SetEnable(false);
	txtPersonalId.SetEnable(false);
	txtPos.SetEnable(false);
	txtDept.SetEnable(false);
	txtTel.SetEnable(false);
	txtUnitCost.SetEnable(0); 
	idBtnSubmit.SetEnable(false);   
	
	maxid="<%=ESysLib.SetDataSQL("select 1 from thr_id_card where del_if=0 and rownum=1")%>";
	if (maxid!="1") 
        txtApp.SetEnable(true);
    else
        txtApp.SetEnable(false);
       
    v_card_pk ="<%=Request("id_card_pk") %>";
    datCardInfo_Submit.StatusInsert();
    if (v_card_pk!="")
        {
            flag_page_load=1;
            txtCard_pk.text=v_card_pk;
            datCardInfo.Call("SELECT"); 
         }
    else
        {
            //datIdcard_User_info.Call("SELECT");           
            datCardInfo.StatusInsert();
        }
}

function OnPopup(n)
{
    if(n==1)
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
        var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	    if (obj!=null)
	    {
	        txtName.text=obj[2]
	        txtEmpId.text=obj[1]
	        txtPersonalId.text=obj[20]
	        txtPos.text=obj[10]
	        txtDept.text=obj[4]
	        txtTel.text=obj[7]
	        idemp_pk.text=obj[0]
	        iddept_pk.text=obj[13]
	        idpos_code.text=obj[12]
	    }
	 }  
	 if(n==2)
	 {
	    var strcom
        var fpath = System.RootURL + "/form/ch/ae/chae00010_emp_id_code.aspx?idcode=IdCard";
        var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
	 } 
	 if(n==3)
	 {
	    var fpath = System.RootURL + "/form/ch/ni/chni00010_search_card_info.aspx" ;
        var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	    if (obj!=null)
	    {
	        txtCard_pk.text=obj[0];
	        datCardInfo.Call("SELECT");
	    }
	 }
}

function onRefresh()
{
    idBtnSubmit.SetEnable(true);
    idBtnSave.SetEnable(true);
    datIdcard_User_info.Call();
    datCardInfo.StatusInsert();
}
function onChangeCardKind()
{
    var v_unit_cost;    
    lstUnitCost.value=lstCardType.value;
    v_unit_cost=lstUnitCost.GetText();
    txtUnitCost.SetDataText(v_unit_cost);
}
function CheckDataIsValid(){
    if(lstCardType.GetData() == ""){
        alert("Please select card type.");
        return false;
    }
    return true;
}
function onSave()
{
   if(!CheckDataIsValid()) return;
   
   if (datCardInfo.GetStatus()==10 || datCardInfo.GetStatus()==0)
    {   
        if (confirm("Do you want to update? \n Bạn có muốn save?"))
        {
            datCardInfo.StatusUpdate();
            datCardInfo.Call();
         }   
    }
    else if (datCardInfo.GetStatus()==20)
    {
        if (confirm("Do you want to add new employee? \n Bạn muốn thêm mới?"))
            datCardInfo.Call();
            
    }
 
}

function onSubmit()
{
    if (confirm("Do you want to submit? \n Bạn muốn xác nhận?"))
    {        
        datCardInfo_Submit.StatusUpdate();
        datCardInfo_Submit.Call();
    }    
}

function OnDataReceive(obj)
{
        if(txtStatus.text == '1' || txtStatus.text == '7')	        
        {
            idBtnSubmit.SetEnable(true);
            idBtnSave.SetEnable(true);
        }
        else
        {
            idBtnSubmit.SetEnable(false);
            idBtnSave.SetEnable(false);
        }      
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ID Card Entry</title>
</head>
<body>

<gw:data id="datIdcard_User_info" onreceive=""  > 
        <xml>
            <dso  type="process" procedure="hr.sp_sel_idcard_user_info"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtName" />
                    <output bind="txtEmpId" />
                    <output bind="txtPersonalId" />
                    <output bind="txtPos" />
                    <output bind="txtDept" />
                    <output bind="txtTel" />
                    <output bind="idemp_pk" />
                    <output bind="iddept_pk" />
                    <output bind="idpos_code" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCardInfo" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16" procedure="hr.sp_upd_card_info" function="hr.sp_sel_card_info"> 
                <inout>
                    <inout bind="txtCard_pk" />
                    <inout bind="txtName" /> 
                    <inout bind="txtEmpId"/>
                    <inout bind="txtPersonalId"/>
                    <inout bind="txtPos"/>
                    <inout bind="txtDept"/>
                    <inout bind="txtTel"/>
                    <inout bind="idemp_pk"/>
                    <inout bind="iddept_pk"/>
                    <inout bind="idpos_code"/>
                    <inout bind="txtApp"/>
                    <inout bind="lstCardTypeRequest"/>
                    <inout bind="txtRemark"/>
                    <inout bind="lstCardType"/>
                    <inout bind="txtUnitCost"/>
                    <inout bind="txtStatus"/>
                    <inout bind="dtRequireDate"/>
                 </inout> 
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCardInfo_Submit" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0" procedure="hr.sp_upd_card_info_submit" function="hr.sp_sel_card_info"> 
                <inout>
                    <inout bind="txtCard_pk" />
                    <inout bind="txtName" /> 
                    <inout bind="txtEmpId"/>
                    <inout bind="txtPersonalId"/>
                    <inout bind="txtPos"/>
                    <inout bind="txtDept"/>
                    <inout bind="txtTel"/>
                    <inout bind="idemp_pk"/>
                    <inout bind="iddept_pk"/>
                    <inout bind="idpos_code"/>
                    <inout bind="txtApp"/>
                    <inout bind="lstCardTypeRequest"/>
                    <inout bind="txtRemark"/>
                    <inout bind="lstCardType"/>
                    <inout bind="txtUnitCost"/>
                    <inout bind="txtStatus"/>
                    <inout bind="dtRequireDate"/>
                 </inout> 
            </dso> 
        </xml> 
</gw:data>

<table id="Settle" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
        <tr style="width:100%;height:35%" valign="top">
            <td align=center>
            <fieldset style="width:90%;height:70%" > 
            <legend><font color="fuchsia" size="1" >Requestor Information</font></legend>
                   <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                        <tr style="border:0;width:100%;height:10%" valign="center" >
                            <td colspan=10 width="20%" style="border:0;" align="right" ><b style="font-size:15">&nbsp;</b></td>
                            <td colspan=10 width="20%" style="border:0;" align="left" >&nbsp;</td>
                            <td colspan=18 width="36%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=2 width="6%" style="border:0;" align="right" ><gw:icon id="idBtnPopup"  styles='width:30%' img="in"  text="Search"  onclick="OnPopup(3)"/></td>
                            <td colspan=2 width="2%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=2 width="6%" style="border:0;" align="right" ><gw:icon id="idBtnRefresh"  styles='width:30%' img="in"  text="New"  onclick="onRefresh()"/></td>
                            <td colspan=2 width="2%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=2 width="6%" style="border:0;" align="right" ><gw:icon id="idBtnSave"  styles='width:30%' img="in"  text="Save"  onclick="onSave()"/></td>
                            <td colspan=2 width="2%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=2 width="6%" style="border:0;" align="right" ><gw:icon id="idBtnSubmit"  styles='width:30%' img="in"  text="Submit"  onclick="onSubmit()"/></td>
                            <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                        </tr>
                        <tr style="border:0;width:100%;height:10%" valign="center" >
                            <td colspan=5 style="border:0;" align="right" ><b style="font-size:12">Name&nbsp;</b></td>
                            <td colspan=8  style="border:0;" align="right" ><gw:textbox id="txtName" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                            <td colspan=3 style="border:0;" align="right" ><gw:icon id="idBtnChangeApprover"  styles='width:30%' img="in"  text="Change"  onclick="OnPopup(1)"/></td>
                            <td colspan=5 style="border:0;" align="right" ><b style="font-size:12">Emp Id&nbsp;</b></td>
                            <td colspan=10 width="10%" style="border:0;" align="right" ><gw:textbox id="txtEmpId" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                            <td colspan=5  style="border:0;" align="right" ><b style="font-size:12">Persional Id&nbsp;</b></td>
                            <td colspan=13 width="10%" style="border:0;" align="right" ><gw:textbox id="txtPersonalId" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                        </tr>
                        <tr style="border:0;width:100%;height:10%" valign="center" >
                            <td colspan=5 style="border:0;" align="right" ><b style="font-size:12">Position&nbsp;</b></td>
                            <td colspan=11  style="border:0;" align="right" ><gw:textbox id="txtPos" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                            <td colspan=5 style="border:0;" align="right" ><b style="font-size:12">Department&nbsp;</b></td>
                            <td colspan=10 width="10%" style="border:0;" align="right" ><gw:textbox id="txtDept" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                            <td colspan=5  style="border:0;" align="right" ><b style="font-size:12">Tel&nbsp;</b></td>
                            <td colspan=13 width="10%" style="border:0;" align="right" ><gw:textbox id="txtTel" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                        </tr>
                      
                    </table> 
                </fieldset>
            </td>
        </tr>  
        <tr style="width:100%;height:50%" valign="top">
            <td align=center>
            <fieldset style="width:90%;height:70%" > 
                <legend><font color="fuchsia" size="1" >Card Information</font></legend>
                   <table width="100%" id="Table1" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                        <tr style="border:0;width:100%;height:10%" valign="center" >
                            <td colspan=8 width="16%" style="border:0;" align="right" ><a title="Click here to select application no" onclick="OnPopup(2)" href="#tips" style="font-size:15" >Application No&nbsp;</a></td>
                            <td colspan=10 width="20%" style="border:0;" align="right" ><gw:textbox id="txtApp" styles="width:100%;font-size:15" csstype="mandatory"/></td>
                            <td colspan=7 width="14%" style="border:0;" align="right" >Required date</td>
                            <td colspan=8 width="16%" style="border:0;" align="right" ><gw:datebox id="dtRequireDate" lang="1" csstype="mandatory" /></td>
                            <td colspan=5 width="10%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=11 width="22%" style="border:0;" align="right" >&nbsp;</td>
                            <td colspan=3 width="6%" style="border:0;" align="right" >&nbsp;</td>
                        </tr>
                        <tr style="border:0;width:100%;height:10%" valign="center" >
                            <td colspan=8 style="border:0;" align="right" ><b style="font-size:15">Application Type&nbsp;</b></td>
                            <td nowrap colspan=10  style="border:0;" align="right" >
                                <gw:list  id="lstCardTypeRequest"  value="30" styles='width:70%'>
                                        <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0091' order by code_nm")%></data>
                                </gw:list></td>                                                  
                            <td colspan=24 style="border:0;" align="right" >
                                <table cellpadding=0 cellspacing=0 border=0 style="width:100%">
                                <tr>
                                    <td nowrap width="20%" align=right><b style="font-size:12">Card Type</b></td>
                                    <td nowrap width=25% align=left>
                                        <gw:list  id="lstCardType"  value=" " csstype="mandatory" styles='width:100%' onchange="onChangeCardKind()" >
                                                <data><%=ESysLib.SetListDataSQL("select pk, type_name from thr_unit_cost where del_if=0  and CATEGORY_CODE='30' order by type_name")%>||</data>
                                        </gw:list>
                                    </td>
                                    <td nowrap width="15%" align=left><b style="font-size:12">Unit Cost&nbsp;</b></td>
                                    <td nowrap width=30% align=left>
                                        <gw:textbox id="txtUnitCost" type="number" format="###,###C" maxlen = "10" text="" styles='width:100%'/>
                                    </td>
                                </tr>                               
                                </table>
                            </td>
                        </tr>
                        <tr style="border:0;width:100%;height:30%" valign="center" >
                            <td colspan=8 style="border:0;" align="right" ><b style="font-size:15">Reason&nbsp;</b></td>
                            <td colspan=41 style="border:0;" align="right" ><gw:textarea id="txtRemark" styles="width:100%;height:90%;font-size:15"/></td>
                            <td colspan=1  style="border:0;" align="right" >&nbsp;</td>
                        </tr>
                    </table> 
                </fieldset>
            </td>
        </tr>  
      <tr style="width:100%;height:15%" valign="top">
            <td align=center>&nbsp;</td>
        </tr>  
</table>
<gw:textbox id="iduser_pk" text="<%=session("USER_PK")%>" styles="display:none"/>
<gw:textbox id="idemp_pk"  styles="display:none"/>
<gw:textbox id="iddept_pk"  styles="display:none"/>
<gw:textbox id="idpos_code"  styles="display:none"/>
<gw:textbox id="txtOption" value="0" styles="display:none"/>
<gw:textbox id="txtCard_pk"  styles="display:none"/>
<gw:textbox id="txtCard_Status"  styles="display:none"/>
<gw:list  id="lstUnitCost"  value="" maxlen = "100" styles='width:100%;display:none' >
        <data><%=ESysLib.SetListDataSQL("select pk, AMOUNT from thr_unit_cost where CATEGORY_CODE='30' order by type_name")%>||</data>
</gw:list>
<gw:textbox id="txtStatus" styles="display:none" />
</body>
</html>
