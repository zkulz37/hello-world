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
var flag=0;

function BodyInit()
{
    
    if (v_language!="ENG")
        System.Translate(document);  
    idemp_id.SetEnable(0);
    idemp_name.SetEnable(0);
       
    
}


function OnSearch()
{
    datManage_list.Call("SELECT");
}
function OnDataReceive(obj)
{
    if(obj.id=="datManage_list")
       lbRec.text=idGrid1.rows-1+" Recs"
    if(obj.id=="datSignature")   
    {
        idGrid1.SetGridText(row,4,txtResult.text)
        imgFile.SetDataText(txtResult.text);
    }
       
    
}
function on_click()
{
    var ctrl=idGrid1.GetGridControl();
    idemp_id.text=idGrid1.GetGridData(ctrl.row,3)
    idemp_name.text=idGrid1.GetGridData(ctrl.row,2)
    txtEmp_PK.text=idGrid1.GetGridData(ctrl.row,0)
    txtPhoto_PK.text=idGrid1.GetGridData(ctrl.row,4)
    row=ctrl.row;
    if(txtPhoto_PK.text!="")
        imgFile.SetDataText(txtPhoto_PK.text);
//    datSignature.Call("SELECT");
}
function on_Save()
{
    txtPhoto_PK.text=imgFile.GetData();
    if(txtPhoto_PK.text!="")
    {
        if(confirm("Do you want to save?"))
        {
            txtFlag.text="UPDATE";
            datSignature.Call();
        }    
    }    
}

function on_Del()
{
    txtPhoto_PK.text=imgFile.GetData();
    if(txtPhoto_PK.text!="")
    {
        if(confirm("Do you want to delete signature image?"))
        {
            txtFlag.text="DELETE";
            datSignature.Call();
        }    
    }    
}

</script>
<body >

<gw:data id="datManage_list" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_manager_list"> 
                <input>
                    <input bind="lstDept_Code" />
                    <input bind="lstSign" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datSignature" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_signature" > 
                <input>
                    <input bind="txtFlag" />
                    <input bind="txtEmp_PK" />
                     <input bind="txtPhoto_PK" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
    
<table id="Settle" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:5%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:6%" valign="center" >
                        <td colspan=6 width="12%" style="border:0;" align="right" ><gw:label id="lbRec"  text="" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                        <td colspan=4 width="8%" style="border:0;" align="right" >Department</td>
                        <td colspan=10 width="20%" style="border:0;" align="right" ><gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06'")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><b>Signature</b></td>
                        <td colspan=8 width="16%" style="border:0;" align="right" ><gw:list  id="lstSign" value='ALL'  maxlen = "100" styles='width:100%' >
                            <data>|01|Don't have image sign|02|Have image sign|ALL|Select All</data></gw:list>
                         </td>
                         <td colspan=2 width="4%" align=right style="border:0">Search</td>
		                <td colspan=3 width="6%" align=right style="width:10%;border:0"><gw:list  id="idSearch" value="1" styles="width:95%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><gw:textbox id="idtxtTmp"  text="" maxlen = "100"  styles="color:blue;width:100%;font-weight:bold" onenterkey="OnSearch()"  /></td>
                        <td width="2%" style="border:0;" align="right" >&nbsp;</td>
                         <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="2%" style="border:0;" align="right" >&nbsp;</td>
                        <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/></td>
                        <td colspan=5 width="10%" style="border:0;" align="right" >&nbsp;</td>
                        
                    </tr>
                    
                    <tr style="border:0;width:100%;height:95%" valign="center" >
                        <td colspan=24 style="width:48%;height:100%;"> 
                             <gw:grid   
                                id="idGrid1"  
                                header="EMP_PK|Organization|Full Name|Emp ID|photo_pk"   
                                format="0|0|0|0|0"  
                                aligns="0|0|0|0|0"    
                                defaults="||||"    
                                editcol="0|0|0|0|0"  
                                widths="0|3000|3000|1000|0"  
                                styles="width:100%; height:100%"   
                                sorting="T" oncellclick = "on_click()" /> 
                        </td>
                        <td colspan=26 style="width:52%;height:100%;"> 
                             <table width="100%" id="Table1" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:10%" >
                                    <td colspan=46 align=center style="width:92%;border:0"><gw:label id="lbltmp"  text="Electrical Signature" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                                    <td colspan=2 style="width:4%;border:0" align="right" ><gw:imgBtn img="save" id="ibtnSave"   alt="Save signature"  onclick="on_Save()"/></td>
                                    <td colspan=2 style="width:4%;border:0" align="right" ><gw:imgBtn img="delete" id="ibtnDel"   alt="Delete signature"  onclick="on_Del()"/></td>
                                 </tr>
                                 <tr style="border:1;width:100%;height:10%" >
                                    <td colspan=7 align=right style="width:14%;border:0">Emp ID</td>
                                    <td colspan=13 style="width:26%;border:0"><gw:textbox id="idemp_id"  text="" maxlen = "100"  styles="color:blue;width:100%;font-weight:bold" onenterkey=""  /></td>
                                    <td colspan=7 align=right style="width:14%;border:0">Full Name</td>
                                    <td colspan=23 style="width:46%;border:0"><gw:textbox id="idemp_name"  text="" maxlen = "100"  styles="color:blue;width:90%;font-weight:bold" onenterkey=""  /></td>
                                 </tr>
                                 <tr style="border:1;width:100%;height:80%" valign=top align=center>
                                    <td colspan=50 style="width:100%"><gw:image id="imgFile"   view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130"  /></td>
                                 </tr>
                             </table>
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>  
</table>
</body>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>
    <gw:textbox id="txtPhoto_PK" styles="display:none"/>
    <gw:textbox id="txtResult" styles="display:none"/>
</html>


