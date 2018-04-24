<!-- #include file="../../../system/lib/form.inc"  -->
 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
  <%ESysLib.SetUser("comm")%>
  
<script>
function BodyInit()
{   
    btUpdate.style.display = 'none';
    btSave.style.display = '';
    <%=ESysLib.SetGridColumnComboFormat("grdSpecGrp", 1, "select pk, partner_name from tco_company")%>;
    BindingDataList();
    OnSearch();
}

function DBClick()
{  
    btUpdate.style.display = '';
    btSave.style.display = 'none';
    txtSGPK.SetDataText(grdSpecGrp.GetGridData(grdSpecGrp.row, 0));
    idData_tco_specgrp_detail.StatusSelect();
    idData_tco_specgrp_detail.Call('SELECT');
}

function BindingDataList()
{
   var data = "";
   
   data = "<%=ESysLib.SetListDataSQL("select a.pk, partner_name from tco_company a where a.del_if = 0")%>"; 
   lstCom.SetDataText(data);
   
   data = "Data|T|Table|M|Manual|I|Item definition"
   lstInput.SetDataText(data);  
}

function OnSearch()
{
    idData_tco_specgrp.Call('SELECT');
}

function OnNew()
{
    btUpdate.style.display = 'none';
    btSave.style.display = '';
    
    idData_tco_specgrp_detail.StatusInsert();
}

function OnDelete()
{
    if (confirm("Are you sure delete ?") == true )
    {
        idData_tco_specgrp_detail.StatusDelete();
       
        idData_tco_specgrp_detail.Call('DELETE');
    }
}

function OnSave()
{   
    idData_tco_specgrp_detail.Call('INSERT');
}

function OnUpdate()
{   
    idData_tco_specgrp_detail.Call('UPDATE');
}

function TabPopUp()
{
    if (lstInput.value == 'I')
    {   
        if ( txtSGPK.GetData() == '' )
        {
            alert('Group code not existing !!!');
        }
        else
        {
            txtSQL.SetDataText('');
            var fpath = System.RootURL + "/form/comm/ci/wcoci00101.aspx?specpk=" + txtSGPK.GetData();
            System.OpenModal( fpath , 400 , 300 , 'resizable:yes;status:yes');                    
            OnSave();
        }
    }
}

function OnRece()
{
    if (idData_tco_specgrp_detail.GetStatus() == 20 || idData_tco_specgrp_detail.GetStatus() == 10) // insert - update
    {
        idData_tco_specgrp.Call('SELECT');
    }
    else{}
    
    if (idData_tco_specgrp_detail.GetStatus() == 40) // delete
    {
        lstCom.value = "";
        txtEg.SetDataText("");
        txtLoc.SetDataText("");
        txtFor.SetDataText("");
        checkActive.value = 'F';
        txtDec.SetDataText("");        
        lstInput.value = "";
        txtSQL.SetDataText("");         
        idData_tco_specgrp.Call('SELECT');
    }
    else{}
    
    if ( lstInput.value == 'I' )
    {
        txtSQL.SetEnable(false);
        input.style.cursor = 'hand';
        input.style.color = '#1b2ff2'; 
    }
    else
    {
        txtSQL.SetEnable(true);
        input.style.cursor = '';
        input.style.color = 'black'; 
    }
}
</script>

<html>
<head runat="server">
    <title>Item Spec Group Entry</title>
</head>
<body>

<gw:data id="idData_tco_specgrp" >
    <xml> 
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6" function="comm.sp_get_tco_specgrp"  procedure="comm.sp_process_tco_specgrp"> 
            <input bind="grdSpecGrp" >
                <input bind="txtGName" />
            </input>
            <output bind="grdSpecGrp" />
        </dso>
    </xml>
</gw:data>

<gw:data id="idData_tco_specgrp_detail" onreceive="OnRece()" > 
    <xml>
        <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8" function="comm.sp_get_tco_specgrp_detail" procedure="comm.sp_process_tco_specgrp_detail" >
            <input>
                <inout  bind="txtSGPK" />
                <inout  bind="lstCom" /> 
                <inout  bind="txtEg" /> 
                <inout  bind="txtLoc" /> 
                <inout  bind="txtFor" /> 
                <inout  bind="checkActive" /> 
                <inout  bind="txtDec" /> 
                <inout  bind="lstInput" /> 
                <inout  bind="txtSQL" />                
            </input>
        </dso>
    </xml>
</gw:data>
                   
<table width="100%" style="background: #BDE9FF" >
    <tr>
        <td width="40%">
            <table width="100%" style="background: white" >
                <tr >
                    <td width="8%"><b>Spec Group</b></td>
                    <td width="20%"><gw:textbox id="txtGName" styles="width: 80%" onenterkey="OnSearch()" /></td>
                    <td width="5%"><gw:imgBtn img="search" alt="Search" onclick ="OnSearch()"/></td>                    
                </tr>
                <tr>
                    <td colspan="4" width="100%">
                        <gw:grid
                        id="grdSpecGrp"
                        header="_PK|Company|Group(EG)|Group(Local)|Group(Foreign)"
                        format="0|0|0|0|0"
                        aligns="0|0|0|0|0"
                        defaults="||||"
                        editcol="0|0|0|0|0"
                        widths="0|1500|1000|1500|1200"
                        styles="width:100%;height:430"
                        oncellclick="DBClick()"
                        param="0,1,2,3,4" />
                    </td>
                </tr>
            </table>
        </td>
        <td width="60%" valign="top">
            <table width="100%" style="background: white">
                <tr>
                    <td width="100%">
                        <table width="100%" style="background: white">
                            <tr>                               
                                <td width="10%"><b>Company</b></td>
                                <td width="20%"><gw:list   id="lstCom"   styles="width: 80%" onenterkey="OnSearch()" ></gw:list></td>
                                <td width="2%"><gw:imgBtn  img="new"     alt="New"      onclick ="OnNew()"/></td>
                                <td width="2%"><gw:imgBtn  img="delete"  alt="Delete"   onclick ="OnDelete()"/></td>                                
                                <td width="2%">
                                    <gw:imgBtn  id="btSave"   img="save"    alt="Save"     onclick ="OnSave()"/>
                                    <gw:imgBtn  id="btUpdate" img="save"    alt="Update"     onclick ="OnUpdate()"/>
                                </td>
                            </tr>                           
                            <tr>
                                <td width="10%"><b>Decription(EG)</b></td>
                                <td width="10%"><gw:textbox id="txtEg"  styles="width: 80%"  /></td>                            
                            </tr>
                            <tr>    
                                <td width="10%"><b>Decription(Local)</b></td>
                                <td width="10%"><gw:textbox id="txtLoc"  styles="width: 80%"  /></td>
                            </tr>
                            <tr> 
                                <td width="10%"><b>Decription(Foreign)</b></td>
                                <td width="10%"><gw:textbox id="txtFor"  styles="width: 80%"  /></td>
                            </tr>
                            <tr> 
                                <td width="10%"><b>Active</b></td>
                                <td width="1%" ><gw:checkbox id="checkActive" /></td>
                            </tr>
                            <tr> 
                                <td width="10%"><b>Decription</b></td>
                                <td width="10%"><gw:textbox id="txtDec"  styles="width: 80%"  /></td>
                            </tr>
                            <tr> 
                                <td width="10%" id="input" ><b onclick="TabPopUp()">Input Type</b></td>
                                <td width="10%"><gw:list id="lstInput"  styles="width: 80%" onchange="TabPopUp()" /></td>
                            </tr>
                            <tr>
                                <td width="10%" valign="top" ><b>SQL Text</b></td>
                                <td width="10%" ><gw:textarea id="txtSQL"  styles="width: 100%;height: 265"  /></td>
                            </tr>
                        </table>
                    </td>                                        
                </tr>              
            </table>            
        </td>
    </tr>    
</table>

<gw:textbox id="txtSGPK" styles="display:none" />

</body>
</html>
