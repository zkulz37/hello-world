<!-- #include file="../../../system/lib/form.inc"  -->
<%   ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>

<script>
function BodyInit(){
   OnNew(); 
   dtJoinDateFrom.SetDataText("20061113");
   BindDataList();
   txtSeq.SetEnable(false);
   chkClose.SetEnable(false);
}
function BindDataList(){
    var data = "";
        data = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0105' order by seq ")%>";    
        lstGrade_type.SetDataText(data);
        //<%=ESysLib.SetGridColumnComboFormat("grdEvalMaster",3,"select code,CODE_NM from vhr_hr_code where id='HR0105' order by code_nm")%>;
        <%=ESysLib.SetGridColumnComboFormat("grdEvalMaster",2,"select code,CODE_NM from vhr_hr_code where id='HR0105' order by code_nm")%>;
        
        OnChangeYear();
        
}
function OnChangeYear()
{
    dso_chem00030.Call("SELECT");
}
function GridOnCellClick()
{
    if ( grdEvalMaster.row > 0 )
    {
        txtMasterPK.text = grdEvalMaster.GetGridData( grdEvalMaster.row,0);
        gSave = false;
        dso_chem00030_1.Call("SELECT");
    }
}
function OnNew()
{
    dso_chem00030_1.StatusInsert();
    btnSave.SetEnable(true);
    ClearData();
}
function ClearData()
{
    txtDescription.text="";
    grdSummary.ClearData();
}
function OnDataReceive(obj)
{
    if (obj.id == "dso_chem00030_1")
    {
          if(chkClose.GetData() == "Y"){
            SetControlState(false);
          }
          else{
            SetControlState(true);
          }
      
          if(gSave == true){
            gSave = false;
            dso_chem00030.Call("SELECT");
          }
          else{
            dso_chem00030_3.Call("SELECT");
          }
    }
    else if (obj.id == "dso_chem00030_2")
    {
        gSave = false;
        dso_chem00030_1.Call("SELECT");
    }
}

function SetControlState(flag){
    btnSave.SetEnable(flag);
    btnDelete.SetEnable(flag);
    ibtnClose.SetEnable(flag);
    if(flag==true)
        ibtnOPEN.SetEnable(false);
    else
        ibtnOPEN.SetEnable(true);

}
function OnDelete()
{
    if(confirm('Do you want to delete?'))
            {
                gSave = true;
                dso_chem00030_1.StatusDelete();
                dso_chem00030_1.Call();
            }   
    
}
var gSave = false;
function OnSave()
{  
   gSave = true;
   dso_chem00030_1.Call();
}
function OnClose(flag)
{  
    txtFlag.text=flag;

  if(txtMasterPK.text > 0)
  {
    if(confirm("Do you want to "+flag+" this evaluation master?"))
    {
       gSave = true;
       dso_chem00030_2.Call();
    }
  }
  else{
    alert("Please select an evaluation number to be closed.");
  }
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dso_chem00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="HR_sel_chem00030"  >  
                 <input bind="grdEvalMaster" >
                   <input bind="dtSearchYear" />														
                  </input> 
                <output bind="grdEvalMaster" /> 
            </dso> 
        </xml> 
 </gw:data>
 <gw:data id="dso_chem00030_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="HR_sel_chem00030_3"  >  
                 <input bind="grdSummary" >
                   <input bind="txtMasterPK" />														
                  </input> 
                <output bind="grdSummary" /> 
            </dso> 
        </xml> 
 </gw:data>
 <gw:data id="dso_chem00030_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" parameter="0,1"  procedure="HR_proc_chem00030_2"> 
            <input> 
                <input bind="txtMasterPK" />
                <input bind="txtFlag" />
            </input>
            <output>
                <output bind="txtCloseStatus" />
            </output>
        </dso> 
    </xml> 
</gw:data> 
    <gw:data id="dso_chem00030_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,10,11" function="HR_sel_chem00030_1"  procedure="HR_upd_chem00030_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtYear" />
                     <inout  bind="txtSeq" />
                     <inout  bind="Eva_dtFrom" />                          
                     <inout  bind="Eva_dtTo" />
                     <inout  bind="dtFromSchedule" />                          
                     <inout  bind="dtToSchedule" />
                     <inout  bind="lstGrade_type" />
                     <inout  bind="txtDescription" />   
                     <inout  bind="chkClose" />  
                     <inout  bind="dtJoinDateFrom" />    
                     <inout  bind="dtJoinDateTo" />                            
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" >
        <tr>
            <td width="22%">
                <table style="width: 100%; height: 100%" border="1">
                    <tr style="height: 2%">
                        <td width="45%">
                            Evaluation Year
                        </td>
                        <td width="50%">
                            <gw:datebox id="dtSearchYear" text="" maxlen="10" type="year" lang="1" onchange="OnChangeYear()" />
                        </td>
                        <td width="5%">
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdEvalMaster' header='_PK|SEQ|EVALUATION TIMES' format='0|0|0'
                                aligns='0|0|0' defaults='||' editcol='1|0|0' widths='0|450|1400' sorting='T'
                                oncellclick="GridOnCellClick()" styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td width="78%" valign="top">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                        <fieldset style="color:Green">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td width="15%">
                                        Eval.Year</td>
                                    <td width="8%">
                                        <gw:datebox id="dtYear" text="" maxlen="10" type="year" lang="1" />
                                    </td>
                                    <td width="2%">
                                        -
                                    </td>
                                    <td width="13%">
                                        <gw:textbox id="txtSeq" styles="width:50px;" />
                                    </td>
                                    <td width="17%">
                                        Eval.Period</td>
                                    <td width="10%">
                                        <gw:datebox id="Eva_dtFrom" lang="1" />
                                    </td>
                                    <td width="2%">
                                        ~
                                    </td>
                                    <td width="10%">
                                        <gw:datebox id="Eva_dtTo" lang="1" />
                                    </td>
                                    <td width="3%">
                                    </td>
                                   
                                    <td with="3%">
                                        <gw:imgbtn id="btnNew" img="New" alt="New" onclick="OnNew()" />
                                    </td>
                                    <td with="3%">
                                        <gw:imgbtn id="btnSave" img="Save" alt="Save" onclick="OnSave()" />
                                    </td>
                                    <td with="3%">
                                        <gw:imgbtn id="btnDelete" img="Delete" alt="Delete" onclick="OnDelete()" />
                                    </td >
                                    <td width"5%"><gw:icon id="ibtnClose" img="in" text="Close" onclick="OnClose('CLOSE')" /></td>
                                    <td width"5%"><gw:icon id="ibtnOPEN" img="in" text="Open" onclick="OnClose('OPEN')" /></td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td>
                        <fieldset>
                            <table style="width: 100%; height: 100%">
                                <tr tr style="height: 100%">
                                
                                    <td width="24%">
                                        Evaluation Times</td>
                                    <td width="26%" colspan="3">
                                        <gw:list id="lstGrade_type" />
                                    </td>
                                    <td width="22%" align="right">
                                        Evaluation Schedule</td>
                                    <td>
                                        <td width="13%">
                                            <gw:datebox id="dtFromSchedule" lang="1" />
                                        </td>
                                        <td width="2%">
                                            ~
                                        </td>
                                        <td width="13%">
                                            <gw:datebox id="dtToSchedule" lang="1" width="10%" />
                                        </td>
                                    </td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 2%" valign="top">
                        <td>
                        <fieldset>
                            <table style="width: 100%; height: 100%">
                                <tr tr style="height: 100%">
                                    <td width="10%">
                                        Description
                                    </td>
                                    <td width="45%" align="left">
                                        <gw:textbox id="txtDescription" />
                                    </td>
                                    <td width="14%">Join Date
                                    </td>
                                    <td width="10%"><gw:datebox id="dtJoinDateFrom" lang="1" /></td>
                                    <td width="3%"> ~
                                    </td>
                                    <td width="10%"><gw:datebox id="dtJoinDateTo" lang="1" /></td>
                                    <td width="3%"><gw:checkbox id="chkClose" defaultvalue="Y|N" /></td>
                                    <td width="5%">Close</td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 94%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="1">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id='grdSummary' 
                                        header='Organization|_Team Section|Employee W/O Eva.Group|Of Emp with Eva.Group|Of 1st Evaluation|Of 2nd Evaluation' 
                                            format='0|0|0|0|0|0' aligns='0|0|1|1|3|3'
                                            defaults='|||||' editcol='0|0|0|0|0|0' 
                                            widths='3750|0|2250|1980|1800|1450' sorting='T' 
                                            styles='width:100%; height:100%' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="display:none;" />
    <gw:textbox id="txtCloseStatus" styles="display:none;" />
    <gw:textbox id="txtFlag" styles="display:none;" />
</body>
