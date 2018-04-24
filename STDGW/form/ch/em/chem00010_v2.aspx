<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Evaluation Group Entry</title>
</head>

<script>
var p_pk 			=0,
     p_group_id		=1,
 p_group_nm 		=2,
 p_group_lnm		=3,
p_group_fnm 		=4,
p_mbo_yn 			=5,
p_group_kind 		=6,
p_description 		=7,
p_thr_eva_master_pk =8;

var check_init=0;

function BodyInit() {
var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0183' order by code")%>";
       grdGroupEntry.SetComboFormat(6,t1);
    
    dat_chem00003.Call();
}
function OnSearch()
{
    if(check_init==1)
        dsoGroupEntry.Call("SELECT");
}
function OnDelete()
{
    if(check_init==1)
        grdGroupEntry.DeleteRow();  
}
function OnUnDelete()
{
    if(check_init==1)
        grdGroupEntry.UnDeleteRow();
}
function OnNew()
{
    if(check_init==1)
    {
        grdGroupEntry.AddRow();
	    var ctrl = grdGroupEntry.GetGridControl();
	    grdGroupEntry.SetGridText(ctrl.rows - 1, p_thr_eva_master_pk,lstEveMaster.value);
    }
}
function OnSave()
{
    if(CheckDataIsValid())
    {          
        dsoGroupEntry.Call();    
    }
}
function CheckDataIsValid()
{
    for(var i=1;i<grdGroupEntry.rows;i++)
    {
        if(grdGroupEntry.GetGridData(i,1)=="")
        {
            alert("Please input group ID !");
            return false;
        }
        else if(grdGroupEntry.GetGridData(i,2)=="")
        {
            alert("Please input group name!");
            return false;
        } 
    }
   return true;
}
function OnCopy()
{
	if(lstEveMaster.value==tolstEveMaster.value)
	{
		alert("Data copy have to different!");
		return;
	}
		
	if(confirm("Are you sure want to copy!"))
		dsoGroupEntry_copy.Call(); 
}
function OnDataReceive(obj)
{
	if (obj.id == "dsoGroupEntry_copy")
    {
		 if(txtResult.text=="1")
		{
			  alert("Copy Sucssess!");
		 }
         else if(txtResult.text=="0"){
	
			  alert("Can not copy this data. It was already!");
		 }
    }
    if (obj.id == "dat_chem00003")
    {
        if(txtResult.text=="Y")
        {
            btnNew.SetEnable(0);
            btnSave.SetEnable(0);
            btnDelete.SetEnable(0);
            btnUnDelete.SetEnable(0);
        }
        else
        {
            btnNew.SetEnable(1);
            btnSave.SetEnable(1);
            btnDelete.SetEnable(1);
            btnUnDelete.SetEnable(1);
        }
        check_init=1;
    }
}
</script>

<body bgcolor='#F5F8FF'>

    <gw:data id="dat_chem00003"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="HR_pro_chem00003_V2">  
                <input>
                     <input bind="lstEveMaster" />  	
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="dsoGroupEntry"> 
        <xml> 
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8" function="hr_sel_chem00010_v2" procedure="hr_upd_chem00010_v2">  
                <input bind="grdGroupEntry"   >  
                    <input bind="txtGroup" />  	
					<input bind="lstEveMaster"/>
                </input> 
                <output bind="grdGroupEntry" /> 
            </dso> 
        </xml> 
    </gw:data>
<!----------------------------------------------------------------------------------------->	
	<gw:data id="dsoGroupEntry_copy"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="hr_pro_chem00010_copy_v2">  
                <input>
                     <input bind="lstEveMaster" />  	
					<input bind="tolstEveMaster"/>
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>
	
	
<!----------------------------------------------------------------------------------------->	
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%" >
                    <tr>
                        <td width="10%" align="right">Group</td>
                        <td width="15%"><gw:textbox id="txtGroup" /></td>
                       
						<td width="15%" align="right">
                            Evaluation#
                        </td>
                        <td width="15%">
                            <gw:list id="lstEveMaster"  onchange="dat_chem00003.Call()" >
							<data>
                                <%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0  order by  EVA_YYYY ||' - ' || EVA_SEQ desc" )%>
                            </data>
							</gw:list>
                        </td>
						 <td width="5%">Copy to</td>
						 <td width="10%">
                            <gw:list id="tolstEveMaster"  onchange="" >
							<data>
                                <%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 and CLOSE_YN='N' order by  EVA_YYYY ||' - ' || EVA_SEQ desc" )%>
                            </data>
							</gw:list>
                        </td>
						
						<td width="5%" align="center"> <gw:icon id="btnCopy" img="in" text="Copy" onclick="OnCopy()" styles="width:100%" /></td>
						 
                        <td width="5%">
                            <gw:icon id="btnSearch" img="in" text="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 5%">
                            <gw:icon id="btnNew" img="in" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 5%">
                            <gw:icon id="btnSave" img="in" text="Save" onclick="OnSave()" />
                        </td>
                        <td style="width: 5%">
                            <gw:icon id="btnDelete" img="in" text="Delete"  onclick="OnDelete()" />
                        </td>
                        <td style="width: 5%">
                            <gw:icon id="btnUnDelete" img="in" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="12">
                            <gw:grid id='grdGroupEntry' header='_PK|GROUP_ID|GROUP_NM|GROUP_LNM|GROUP_FNM|MBO_YN|_GROUP KIND|DESCRIPTION|_THR_EVA_MASTER_PK'
                                format='0|0|0|0|0|3|0|0|0' aligns='0|0|0|0|0|0|0|0|0' defaults='||||||||' editcol='1|1|1|1|1|1|1|1|0'
                                widths='1000|1500|1500|1500|1500|1500|1500|1500|1500' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtResult" styles="display:block"/> 
</html>
