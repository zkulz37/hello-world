<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var sun_day=new Array();
var mon_day=new Array();
var sun_col=new Array();
var dem_sun,dem_mon,dem_sun_col;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    
    <%=ESysLib.SetGridColumnComboFormatString2( "idGrid1" , 5 , "-1|None|0|Posco VN|1|Visitor|2|Sub Contract|3|Posco VN and Visitor|4|Visitor and Sub Contract|5|Posco VN and Sub Contract|6|All Information") %>;  

}
function OnShowPopup(num)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(num==1)
        {
            lstOrg.value=obj
        }
        
    }
    
}
function OnSearch()
{
    datRollingUser.Call("SELECT");
}
function OnSave()
{
    if(confirm("Do you want to save data?"))
    {
       datRollingUser.Call(); 
    }
}
function OnDataReceive(obj)
{
     if (obj.id=="datRollingUser")
     {
        idRecord.text=idGrid1.rows-1+" Records.";
     }
}
//-------------------------------------------------------------------------------------------
</script>
<body>

<gw:data id="datRollingUser" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr.SP_Rolling_User" procedure="hr.SP_Udp_Rolling_User" parameter="0,5"> 
                <input bind="idGrid1"> 
                    <input bind="lstOrg" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                </input> 
                <output bind="idGrid1"/>
            </dso> 
        </xml> 
</gw:data>

   <!--------------------main table----------------------------------->
    <table name="Rolling User" id="Rolling" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:5%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:6%;border:0" ><a title="Click here to show department" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
		            <td colspan=12 align=right style="width:24%;border:0"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstOrg)" >
                        <data>
                            <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=4 align=right style="width:8%">Search</td>
		            <td colspan=5 align=right style="width:10%"><gw:list  id="idSearch" value="1" styles="width:96%" onChange="">
                            <data>|1|Emp ID|2|User ID|3|Name</data></gw:list></td>
		            <td colspan=8 align=right style="width:16%"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:96%" onenterkey="OnSearch()" /></td>
		            <td colspan=12 align=right style="width:24%"style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
                    <td align=right colspan=1 style="width:2%;border:0"></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
                    <td align=right style="width:2%;border:0">&nbsp;</td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnsave" alt="Search" img="save" text="Save" onclick="OnSave()" /></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:95%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid1"  
	                            header="_PK|Organization|Emp ID|Full Name|User ID|Rolling Information"   
	                            format="0|0|0|0|0|0"  
	                            aligns="0|0|0|0|0|0"  
	                            defaults="|||||"  
	                            editcol="0|0|0|0|0|1"  
	                            widths="0|3000|1200|3000|2000|3000"  
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = ""  
	                            /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    </gw:tab>
    <gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>  
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
</body>

   
</html>
