<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
   
    idUserID.text= "<%=session("USER_ID")%>";
    idGrid1.GetGridControl().ScrollTrack=true;
	datFind_User.Call();
	  

}
function OnDataReceive(obj)
{
    var obj_lst;
       if (obj.id=="datFind_User")
       {
        //alert(txtReturn.text)
         switch(txtReturn.text)
         {  
            case '-1':
                    ibtnSearch.SetEnable(0);
                    ibtnRpt.SetEnable(0);
                    idRecord.text="Deny Use"
                    break;
            case '0': //staff 
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|0|Posco VN");
                    break;      
            case '1': //visitor  
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|1|Visitor");
                    break;      
            case '2': //sub contract 
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|2|Sub Contract");
                    break;       
            case '3': //staff, vis  
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|0|Posco VN|1|Visitor");
                    break;      
            case '4': //vis, sub   
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|1|Visitor|2|Sub Contract");
                    break;   
            case '5': //staff, sub   
                    lstInfor_type.ClearData();
                    lstInfor_type.SetDataText("|0|Posco VN|2|Sub Contract");
                    break;  
                                       
         }   
         
       }
       if(obj.id=="datRollinGate")
       {
          idRecord.text=idGrid1.rows-1+" Records."; 
       }
      
}   
function OnSearch()
{
    datRollinGate.Call("SELECT");
}
//---------------------------------
function OnReport(n)
{
    if(n==2)
        var url =System.RootURL + '/reports/ch/ba/rpt_rolling_date_infor_sum.aspx?p_lstinfo_type=' + lstInfor_type.value + '&p_lstinfo_type_t=' + lstInfor_type.GetText() + '&p_from=' + FromDT.value + '&p_to=' + ToDT.value + '&p_search=' + idSearch.value  + '&P_input=' +  idtxtTmp.text  ;
    else
        var url =System.RootURL + '/reports/ch/ba/rpt_rolling_date_infor.aspx?p_lstinfo_type=' + lstInfor_type.value + '&p_lstinfo_type_t=' + lstInfor_type.GetText() + '&p_from=' + FromDT.value + '&p_to=' + ToDT.value + '&p_search=' + idSearch.value  + '&P_input=' +  idtxtTmp.text  ;
    window.open(url);
     
     
}
//-------------------------------------------------------------------------------------------
</script>
<body>
<!------------------------------------------------>
<gw:data id="datFind_User" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_sel_user_hr_tmp" > 
                <input>
                    <input bind="idUserID" /> 
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datRollinGate" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_sel_10020013_Roll_Gate" procedure="" parameter="1"> 
                <input bind="idGrid1"> 
                    <input bind="lstInfor_type" /> 
                    <input bind="FromDT" /> 
                    <input bind="ToDT" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                </input> 
                <output bind="idGrid1"/>
            </dso> 
        </xml> 
</gw:data>

   <!--------------------main table----------------------------------->
    <table name="Rolling Gate" id="Rolling" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:10%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=7 align=right style="width:14%;border:0" >Information Type</td>
		            <td colspan=5 align=right style="width:10%;border:0"><gw:list  id="lstInfor_type" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                        <data>|0|Posco VN|1|Visitor|2|Sub Contract|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=4 style="width:8%" align="right">Work DT</td>
                    <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right style="width:2%;border:0"><b>~</b></td>
		            <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td colspan=4 align=right style="width:8%">Search by</td>
		            <td colspan=4 align=right style="width:8%"><gw:list  id="idSearch" value="1" styles="width:96%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td colspan=4 align=right style="width:8%"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:96%" onenterkey="OnSearch()" /></td>
		            <td colspan=8 align=right style="width:16%"style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report Detail" img="excel" text="Report" onclick="OnReport(1)" /></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report Summary" img="excel" text="Report" onclick="OnReport(2)" /></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:90%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid1"  
	                            header="Organization|Emp Id|Full Name|Card ID|Check Date|Check Time"   
	                            format="0|0|0|0|4|0"  
	                            aligns="0|0|0|0|0|0"  
	                            defaults="|||||"  
	                            editcol="0|0|0|0|0|0"  
	                            widths="4000|1200|3000|1200|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = ""  
	                            /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    <gw:textbox id="idUserID" styles="display:none"/>
    <gw:textbox id="txtReturn" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>  
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
</body>

   
</html>
