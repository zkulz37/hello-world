<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">        
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var iFactor=1;

//luoi 1
var c_emp_id_0=0, c_full_name_0=1, c_confirm_yn_0=2, c_org_0=3, c_wg_0=4, c_emp_pk_0=5;
var c_eva_master_pk_0=6, c_eva_group_pk_0=7, c_pk_0=8,c_act_confrim_0=9,c_eva_level_0=10;


//"Type|Element|Person MBO Result|Target 1|Target 2|Weight|Level|Confirm YN|eva_master_pk|Factor_PK|thr_eva_emp_pk|THR_EVA_MBO_V2_pk|SEQ"
var c_type=0, c_element=1, c_mbo_result=2, c_target_1=3, c_target_2=4, c_weight=5;
var c_level=6, c_confirm_yn=7, c_seq=8, c_eva_master_pk=9, c_factor_pk=10, c_thr_eva_emp_pk=11, c_THR_EVA_MBO_V2_pk=12;


var l_data;
var check_init=0;
function BodyInit()
{     
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>";  
   
    SetGridFormat();
    BindDataInit();
    datchem00070_lst.Call();
    //
}

function BindDataInit()
{
    
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 order by 2 desc")%>";
    lstEvaTimes.SetDataText(ls_data); 

    ls_data="<%=ESysLib.SetListDataSQL("select a.pk, a.GROUP_ID|| '-' || a.GROUP_NM from THR_EVA_GROUP_v2 a where a.DEL_IF=0 and a.MBO_YN='Y' ")%>"
    lstEvaGrp.SetDataText(ls_data);

    ls_data="<%=ESysLib.SetListDataSQL("select a.code, a.code|| '-' || a.code_NM from vhr_hr_code a where a.id='HR0220'")%>"
    lstLevel.SetDataText(ls_data);
    
    imgEmp.SetEnable(0); 
   
    idGrid.GetGridControl().FrozenCols =2;
    idGrid.GetGridControl().ScrollTrack=true;   
}

function SetControlStatus()
{
    txtName.SetEnable(0);    
    txtDept.SetEnable(0);
    txtGroup.SetEnable(0);
        txtSchedule.SetEnable(0);
    txtEvalPeriod.SetEnable(0);
    
}
function ChoseList_box(obj_list,value)
{
    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1; 
	
}


function SetGridFormat()
{
    var stt;
       if(idGrid.rows <2)
       {
            idGrid.AddRow();
       } 
        var fg=idGrid.GetGridControl();
        //set bold
        /*fg.Cell(13, 0, 0, 0, fg.Cols-2) = true;
		fg.Cell(13, 0, 0, 1, fg.Cols-2) = true;*/

        

        fg.FixedRows = 2;
        fg.MergeCells = 5;
		fg.MergeRow(0) = true;

        
		fg.MergeCol(c_type) = true;
		fg.Cell(0, 0, c_type, 1, c_type) = "Type";
		
        
		fg.MergeCol(c_element) = true;
        fg.Cell(0, 0, c_element, 1, c_element) = "Content"; //fg.Cell(0,row, from_col, row, to_col)

        
		fg.MergeCol(c_mbo_result) = true;
		fg.Cell(0, 0, c_mbo_result, 1, c_mbo_result) = "Action Plan";


		fg.MergeCol(c_target_1) = true;
        fg.Cell(0, 0, c_target_1, 0, c_target_2) = "Target";
        fg.Cell(0, 1, c_target_1, 1, c_target_1) = "First 6 months";
        fg.Cell(0, 1, c_target_2, 1, c_target_2) = "Last 6 months";

		fg.MergeCol(c_weight) = true;
		fg.Cell(0, 0, c_weight, 1, c_weight) = "Weight";

        fg.MergeCol(c_level) = true;
		fg.Cell(0, 0, c_level, 1, c_level) = "Level";

        fg.MergeCol(c_confirm_yn) = true;
		fg.Cell(0, 0, c_confirm_yn, 1, c_confirm_yn) = "Confirm YN";

        fg.MergeCol(c_seq) = true;
		fg.Cell(0, 0, c_seq, 1, c_seq) = "Seq";

        /*
		
		fg.ColWidth(0)=800;
		fg.ColWidth(1)=2000;
		fg.ColWidth(2)=1000;
		fg.ColWidth(3)=5000;
		
		fg.ColWidth(4)=1000;
		fg.ColWidth(5)=2000;
		fg.ColWidth(6)=800;
		fg.ColWidth(7)=800;
		fg.ColWidth(8)=800;
		fg.ColWidth(9)=800;
		fg.ColWidth(10)=800;
		fg.ColWidth(11)=800;
		fg.ColAlignment(0) = flexAlignCenterCenter;
		fg.ColAlignment(4) = flexAlignRightCenter;
		fg.ColAlignment(6) = flexAlignCenterCenter;		
		fg.ColAlignment(7) = flexAlignRightCenter;
		fg.ColAlignment(8) = flexAlignRightCenter;		*/
}
function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var Char;

   for (i = 0; i < sText.length; i++) 
   { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
      {
         return false;
      }
   }
   return true;
}

function checkNumberInvalid()
{  

    if (IsNumeric(idGrid.GetGridData(idGrid.row,c_weight))==false)
    {
        alert("Value of MBO Weight must be numeri.");
        return false;
     }         
     
     return true;    
}


function OnDataReceive(obj)
{    
    
    if (obj.id == "datchem00070_lst")
    {     
        datchem00260_level.Call();           
    }
    if (obj.id == "datchem00260_level")
    { 
        datchem00070.Call("SELECT");
    }

    if (obj.id == "datchem00070_1")
    {        
        imgEmp.SetDataText(txtPhoto_PK.text);
        datchem00070_2.Call("SELECT");
    }
    if (obj.id == "datchem00070_2")
    {        
        SetGridFormat();
    }  
    if(obj.id == "datchem00070")
    {
        datchem00070_3.Call();
    }
    if(obj.id == "datchem00070")
    {
        check_init=1;
    }
    
     
}



function OnSave()
{    
    if(check_init==1)
        datchem00060.Call();
}

function OnSearch()
{   
    if(check_init==1) 
        datchem00070.Call("SELECT");
}





function OnConfirm(p_action)
{
    var ctrl=idGrid_M.GetGridControl();
    var tmp;
    if (ctrl.SelectedRows>=1)
    {
        if(confirm("Do you want to "+p_action+"?"))
        {
            for(var i=0;i<ctrl.SelectedRows;i++)
            {
                tmp=ctrl.SelectedRow(i);
                idGrid_M.SetGridText(tmp,c_act_confrim_0,p_action);
            }
            datchem00070.Call();
        }
               
    }
}


function onShowDetail()
{
    var ctrl=idGrid_M.GetGridControl();
    //alert(ctrl.row);
    if(ctrl.row>=1)
    {

    
         txtName.text=idGrid_M.GetGridData(ctrl.row,c_full_name_0);
         txtDept.text=idGrid_M.GetGridData(ctrl.row,c_org_0);

        txtEva_Emp_PK.text=idGrid_M.GetGridData(ctrl.row,c_pk_0);
        txtEva_master_PK.text=idGrid_M.GetGridData(ctrl.row,c_eva_master_pk_0);
        txtGrid_Emp_PK.text=idGrid_M.GetGridData(ctrl.row,c_emp_pk_0);

        if(txtEva_Emp_PK.text!="" && txtEva_master_PK.text!="" && txtGrid_Emp_PK.text!="")
        {
            datchem00070_1.Call();
        }
    }
}


function onSelectAll()
{
    var ctrl=idGrid_M.GetGridControl();
    for(var i=1;i<ctrl.Rows;i++)
    {
        ctrl.IsSelected(i)="True";
    }


}

function onOpenPopup()
{
    if(check_init==1) 
    {
        var ctrl=idGrid.GetGridControl();
        var write_yn="";
        var p_data;
        var l_col=ctrl.col;
        var l_row=ctrl.row;

       
        if(l_col==c_mbo_result || l_col==c_target_1 || l_col==c_target_2)
        {
             write_yn="N";

            txtArea_Tmp.SetDataText(idGrid.GetGridData(l_row,l_col));

            if(l_col==c_mbo_result)
                p_data="MBO RESULT";
            else if(l_col==c_target_1)
                p_data="TARGET FIRST 6 MONTHS";
            else if(l_col==c_target_2)
                p_data="TARGET LAST 6 MONTHS";
            // alert(l_col);
            var path = System.RootURL + '/form/ch/em/chem00060_v2_1.aspx?p_data='+p_data+"&write_yn="+write_yn;
            var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
        
            
        }
    }
}

function GetContent()
{
    return txtArea_Tmp.GetData();
}

function OnChangeEvaPeriod()
{
    datchem00070_lst.Call();
}

</script>
<body bgcolor='#F5F8FF'>

<gw:data id="datchem00070_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00260_v2_lst" > 
                <input>
                    <input bind="lstEvaTimes"/> 
                </input> 
                <output>
                
                    <output bind="lstEvaGrp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00260_level" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00260_v2_level" > 
                <input>
                    <input bind="lstEvaTimes"/> 
                </input> 
                <output>
                    <output bind="lstLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datchem00070" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10" function="HR_sel_chem00070_v2" procedure="HR_upd_chem00070_v2" > 
                <input bind="idGrid_M">
                    <input bind="lstEvaGrp"/>  
                    <input bind="lstEvaTimes" />
                    <input bind="lstLevel" />
                    <input bind="lstConfirmYN" />
                    <input bind="txtEmp_PK" />  
                </input>
                <output bind="idGrid_M"/>
            </dso>
        </xml>
    </gw:data>  

<gw:data id="datchem00070_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00070_1_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/> 
                    <input bind="txtEva_master_PK"/>
                    <input bind="txtGrid_Emp_PK"/>
                </input> 
                <output>
                
                    <output bind="txtPhoto_PK" />
                    <output bind="txtEvalPeriod" />
                    <output bind="txtSchedule" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00070_3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00070_3_v2" > 
                <input>
                    <input bind="lstEvaGrp"/>  
                    <input bind="lstEvaTimes" />
                    <input bind="lstLevel" />
                    <input bind="lstConfirmYN" />
                    <input bind="txtEmp_PK" />  
                </input> 
                <output>
                    <output bind="lblInfor" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datchem00070_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0" function="HR_sel_chem00070_2_v2" procedure="" > 
                <input bind="idGrid">
                    <input bind="txtEva_Emp_PK"/>  
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data> 


<table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr style="width:100%;height:1%">
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
    </tr>
	<tr style="width:100%;height:35%">
        <td colspan=30>
    	    <fieldset style="padding: 5;height:85%"><legend>Evaluation Infomation</legend>
                <table border=0 cellpadding=3 cellspacing=0 style="width:100%;height:100%">
                    
                    <tr style="height:10%">
                	   <td width="30%" align="right">Eva Times</td>
                       <td width="70%"><gw:list id="lstEvaTimes"   onchange="OnChangeEvaPeriod()"/></td>
		             </tr>
                     <tr style="height:10%">
                	    <td width="30%" align="right">Eva Group &nbsp;</td>
                        <td width="70%"><gw:list id="lstEvaGrp"  onchange="OnSearch()"/></td>
                    </tr>
                     <tr style="height:10%">
                	   <td align="right">Level</td>
                       <td ><gw:list id="lstLevel"   onchange="OnSearch()"/></td>
		             </tr>
                     <tr style="height:10%">
                	   <td align="right">Confirm</td>
                       <td ><gw:list  id="lstConfirmYN" value="N" styles='width:100%' onchange="OnSearch()"> 
							        <data>LIST|Y|Y|N|N|ALL|Select All</data> 
					        </gw:list>
                        </td>
		             </tr>
                     <tr style="height:10%">
                	    <td align=center colspan=2 style="width:100%;height:10%"><b><gw:label id="lblInfor"  text="" styles="color:red;font-size:13"/></b></td>                    
                    </tr>
                    <tr style="height:30%">
                	    <td align="right" colspan=2>&nbsp;</td>                    
                    </tr>
                    <tr style="height:10%">
                        <td colspan=2>
                    	    <table width="100%">
							    <tr>
                                    <td><gw:icon id="ibtnSel" alt="Select All"  text="Select All"  img="in"  styles="width:100%" onclick="onSelectAll()"/></td>
                                    <td>&nbsp;</td>
                            	    <td><gw:icon id="ibtnSearch" alt="New"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
                            	    <td><gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('CONFIRM')"/></td>
                                    <td><gw:icon id="ibtnUnConfirm" alt="Un-Confirm"  text="Un-Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('UN-CONFIRM')"/></td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </td>
		             </tr>
        	    </table>
            </fieldset>
    	</td>
        <td colspan=1>&nbsp;</td>
    	<td colspan=69>
            <fieldset style="padding: 5;height:100%"><legend>Employee infomation</legend>
                <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                    <tr>
                        <td align="right" width="20%">
                            <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130;border-top: 1 solid #87b0c6; border-bottom: 1 solid #87b0c6; border-left: 1 solid #87b0c6; border-right: 1 solid #87b0c6 "/>
                        </td>
                        <td width="5%">&nbsp;</td>
                        <td valign="top" width="75%">
                            <table width="100%">
                                <tr>
                        	        <td width="30%" align="right">Evaluation Period&nbsp;</td>
                                    <td width="65%"><gw:label id="txtEvalPeriod"  text="" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                                    <td width="5%"></td>
                                </tr>
                                <tr>
                        	        <td align="right">Schedule &nbsp;</td>
                                    <td><gw:label id="txtSchedule"  text="" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td align="right">Full Name &nbsp;</td>
                                    <td ><gw:label id="txtName"  text=""  styles='border-width:1;width:100%;'/></td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td align="right">Organization Name &nbsp;</td>
                        	        <td ><gw:label id="txtDept"  text="" 	styles='border-width:1;width:100%;'/></td>                            
                                    <td>&nbsp;</td>
                                </tr>
                                
                            </table>
                        </td>
 	                 </tr>           
                </table>
             </fieldset>
        </td>
    	
  	 	
    </tr>  
    <tr style="width:100%;height:64%">
        <td colspan=30>
             <gw:grid   
                id="idGrid_M" 
                header="Emp ID|Full Name|C|Organization|Work Group|_emp_pk|_eva_master_pk|_eva_group_pk_|_pk|_act_confirm|_eva_level"                                       
                format="0|0|0|0|0|0|0|0|0|0|0"                                          
                aligns="0|0|0|0|0|0|0|0|0|0|0"    
                defaults="||||||||||"                     
                editcol="0|0|0|0|0|0|0|0|0|0|0"  
                widths="1000|2000|500|3000|3000|0|0|0|0|0|0"
                styles="width:100%; height:100%"     
                acceptNullDate="T"  
                sorting="T" oncellclick="onShowDetail()"
                />  
        </td>    
        <td  colspan=1>&nbsp;</td>
        <td colspan=69 >
             <gw:grid   
            id="idGrid" 
            header="_Type|Element|Person MBO Result|Target 1|Target 2|Weight|Level|_Confirm YN|_SEQ"                                       
            format="0|0|0|0|0|0|2|0|0"   
            aligns="0|0|0|0|0|0|0|0|0"    
            defaults="||||||||"                     
            editcol="0|0|0|0|0|0|0|0|0"  
            widths="1200|1500|3000|3000|3000|1200|1200|1200|0|0|0|0|0"
            styles="width:100%; height:100%"     
            acceptNullDate="T" oncelldblclick="onOpenPopup()"
            sorting="T"/>  
        </td>    
    </tr>    
   
</table>
 
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />



<gw:textbox id="txtGroupEval" style="display:none" />

<gw:textbox id="txt_thr_eva_emp_pk" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textbox id="txtGroup" style="display:none" />
<gw:textbox id="txtFactor" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />

<gw:textbox id="txtEva_Emp_PK" style="display:none" />
<gw:textbox id="txtEva_master_PK" style="display:none" />
<gw:textbox id="txtGrid_Emp_PK" style="display:none" />

<gw:textarea id="txtArea_Tmp"  text="" onchange="" styles='width:100%;display:none'/>


</body>



