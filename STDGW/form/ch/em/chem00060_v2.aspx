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
   
    //alert(txtCompany_PK.text);

    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0  order by 2 desc")%>";
    lstYear.SetDataText(ls_data); 
    ls_eva_grp_data="<%=ESysLib.SetListDataSQL("select a.pk, a.GROUP_ID|| '-' || a.GROUP_NM from THR_EVA_GROUP_V2 a where a.DEL_IF=0")%>"
    
    lstEvaGrp.SetDataText(ls_eva_grp_data);
    lstEvaGrp.value="ALL";

    l_data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0112'  order by seq")%>";
	idGrid.SetComboFormat(c_level,l_data);
     
    l_data ="#A;Achivement|#C;Competence"; 
    idGrid.SetComboFormat(c_type,l_data);
    
    imgEmp.SetEnable(0); 
    lstEvaGrp.SetEnable(0); 
   
    idGrid.GetGridControl().FrozenCols =2;
    idGrid.GetGridControl().ScrollTrack=true;   
    dat_get_emp_info_chem00060.Call(); 
}
function SetControlStatus()
{
    txtName.SetEnable(0);    
    txtDept.SetEnable(0);
    txtGroup.SetEnable(0);
    txtPos.SetEnable(0);
    txtPos_Time.SetEnable(0);
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
    if (obj.id == "dat_get_emp_info_chem00060"){        
        imgEmp.SetDataText(txtPhoto_PK.text);
        datchem00050_1.Call();
    }    
    else if (obj.id == "datchem00050_1")
    {     
        //alert(txtResult.text);
        if(txtResult.text=="Y")
        {
            ibtnConfirm.SetEnable(0);
            ibtnAddNew.SetEnable(0);
            ibtnSave.SetEnable(0);
            ibtnDelete.SetEnable(0);
            ibtnUnConfirm.SetEnable(1);
        }  
        else
        {
            ibtnConfirm.SetEnable(1);
            ibtnAddNew.SetEnable(1);
            ibtnSave.SetEnable(1);
            ibtnDelete.SetEnable(1);
            ibtnUnConfirm.SetEnable(0);
        }
         
        datchem00060_5.Call();               
    }
    else if (obj.id == "datchem00060_5"){       
        datchem00060_4.Call();               
    }
    else if (obj.id == "datchem00060_4"){   
        ChoseList_box(lstEvaGrp,txtGroupEval.text);      
        datchem00060.Call("SELECT");  
    }      
    else if (obj.id == 'datchem00060')
    {      
        SetGridFormat();
        check_init=1;
    } 
    else if (obj.id == 'datchem00060_6')
    {      
        alert(txtResult_2.text);
        //alert(txtResult.text);

        if(txtResult.text=="Y")
        {
            ibtnConfirm.SetEnable(0);
            ibtnAddNew.SetEnable(0);
            ibtnSave.SetEnable(0);
            ibtnDelete.SetEnable(0);
            ibtnUnConfirm.SetEnable(1);
        }  
        else
        {
            ibtnConfirm.SetEnable(1);
            ibtnAddNew.SetEnable(1);
            ibtnSave.SetEnable(1);
            ibtnDelete.SetEnable(1);
            ibtnUnConfirm.SetEnable(0);
        }

        datchem00060.Call("SELECT");  
    } 
     
     
}
function OnNew()
{    
    if(check_init==1)
    {
        var ctrl=idGrid.GetGridControl();

        //alert(ctrl.rows);
        if(ctrl.rows>2)
        {


            idGrid.AddRow(); 
            ctrl.TopRow =  idGrid.rows-1;

            var l_row=idGrid.rows-1;
            var l_thr_eva_emp_pk=idGrid.GetGridData(2,c_thr_eva_emp_pk);//dong dau tien phai co

            idGrid.SetGridText(l_row,c_eva_master_pk,lstYear.value);
            idGrid.SetGridText(l_row,c_thr_eva_emp_pk,l_thr_eva_emp_pk);
            if(l_row-1>0)
            {
                idGrid.SetGridText(l_row,c_type,idGrid.GetGridData(l_row-1,c_type));
            }
        }
        else
        {
            alert("There is no define for MBO factor");
        }
             
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
        datchem00060.Call("SELECT");
}







function OnDelete()
{
    if(check_init==1)
    {
        var ctrl=idGrid.GetGridControl();
        if(ctrl.row>0)
        {
            if(idGrid.GetGridData(ctrl.row,c_confirm_yn)=="N")
            {
                if(confirm("Do you want to delete?"))
                {
                    idGrid.DeleteRow();
                    datchem00060.Call();
                }

            }
            else
            {
                alert("This data confirm already!");
            }
        }
    }
}

function OnValidate()
{
    var ctrl=idGrid.GetGridControl();
    var l_total_weight=0;
    if(idGrid.rows<=2)
        {
            alert("There is no data to confirm");
            return 0;
        }
    for(var i=2;i<idGrid.rows;i++)
    {
       l_total_weight+=Number(idGrid.GetGridData(i,c_weight)); 
    }
    if(l_total_weight!=100)
    {
        
        alert("Total weight is not equal=100");
        return 0;
    }
    return 1;
}

function OnConfirm(p_action)
{
    txtAction.text=p_action;
    if(OnValidate()==1)
    {
        if(confirm("Do you want to "+p_action+"?"))
                datchem00060_6.Call();
    }
}

function onOpenPopup()
{
    var ctrl=idGrid.GetGridControl();
    var write_yn="";
    var p_data;
    var l_col=ctrl.col;
    var l_row=ctrl.row;

    
    if(l_col==c_mbo_result || l_col==c_target_1 || l_col==c_target_2)
    {
        if(idGrid.GetGridData(ctrl.row,c_confirm_yn)=="Y")
            write_yn="N";   
        else
            write_yn="Y";

        txtArea_Tmp.SetDataText(idGrid.GetGridData(l_row,l_col));

        if(l_col==c_mbo_result)
            p_data="MBO RESULT";
        else if(l_col==c_target_1)
            p_data="TARGET FIRST 6 MONTHS";
        else if(l_col==c_target_2)
            p_data="TARGET LAST 6 MONTHS";

        //alert(write_yn);
        var path = System.RootURL + '/form/ch/em/chem00060_v2_1.aspx?p_data='+p_data+"&write_yn="+write_yn;
        var object = System.OpenModal(path ,700 , 500 , 'resizable:yes;status:yes',window);
        if(object!=null)
        {
			idGrid.SetGridText(l_row,l_col,object[0]);
		}	
            
    }

}

function GetContent()
{
    return txtArea_Tmp.GetData();
}

</script>
<body bgcolor='#F5F8FF'>



<gw:data id="dat_get_emp_info_chem00060" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00060_v2" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>                    
                    <output bind="txtName"/>
                    <output bind="txtDept" />          
                    <output bind="txtGroup" />
                    <output bind="txtPhoto_PK" />
                    <output bind="txtPos" /> 
                    <output bind="txtPos_Time" />                                                                                                        
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00050_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00060_3_v2" > 
                <input>
                    <input bind="lstYear" /> 
                    <input bind="txtCompany_PK" /> 
                    <input bind="txtEmp_PK" />
                </input> 
                <output>
                    <output bind="txtEvalPeriod" />
                    <output bind="txtSchedule" />
                    <output bind="txtGradeEvatype" />
                    <output bind="txtGradeEvatimes" />
                    <output bind="txtResult"/>
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datchem00060_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00060_4_v2" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                    <input bind="lstYear" />
                </input> 
                <output>
                    <output bind="txtGroupEval" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00060_5_v2" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                    <input bind="lstYear" />
                </input> 
                <output>
                    <output bind="txt_thr_eva_emp_pk" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00060_1_v2" > 
                <input>
                    <input bind="lstEvaGrp" /> 
                </input> 
                <output>
                    <output bind="txtGroupFactor" />                                     
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00060" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="HR_sel_chem00060_v2" procedure="HR_upd_chem00060_v2" > 
                <input bind="idGrid">
                    <input bind="lstYear"/>  
                    <input bind="txtEmp_PK" />  
                    <input bind="lstEvaGrp" /> 
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>       

<gw:data id="datchem00060_6" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_chem00060_6_v2" > 
                <input bind="idGrid">
                    <input bind="lstYear"/>  
                    <input bind="txtEmp_PK" />  
                    <input bind="lstEvaGrp" />
                    <input bind="txtAction" />
                </input>
                <output>
                    <output bind="txtResult" />
                    <output bind="txtResult_2" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<!---------------------------------------------->
<table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
	<tr>
    	<td style="width:58%;height:25%">
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
                        	<td width="30%" height="10%">&nbsp;</td>
                            <td width="65%"></td>
                            <td width="5%"></td>
                        </tr>
                        <tr>
                        	<td nowrap align="right">Evaluation #&nbsp;</td>
                            <td nowrap><gw:list id="lstYear"   onchange="datchem00050_1.Call()"/></td>
                            <td></td>
                        </tr>
                        <tr>
                        	<td align="right">Evaluation Period&nbsp;</td>
                            <td><gw:label id="txtEvalPeriod"  text="" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                            <td></td>
                        </tr>
                        <tr>
                        	<td align="right">Schedule &nbsp;</td>
                            <td><gw:label id="txtSchedule"  text="" 	maxlen = "20" styles='border-width:1;width:100%;'/></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2"><gw:label id="txtName"  text=""  styles='border-width:1;width:100%;'/></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                        	<td colspan="2"><gw:label id="txtDept"  text="" 	styles='border-width:1;width:100%;'/></td>                            
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                        	<td><gw:label id="txtPos"  text="" styles='border-width:1;width:100%;'/></td>
                            <td><gw:label id="txtPos_Time"  text="" styles='border-width:1;width:100%;'/></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
 	         </tr>           
        </table>
     </fieldset>
    </td>
    	<td style="width:2%">&nbsp;</td>
  	 	<td style="width:40%;height:25%">
    	    <fieldset style="padding: 5;height:85%"><legend>Evaluation Group Infomation</legend>
            <table border=0 cellpadding=3 cellspacing=0 style="width:100%;height:100%">
                <tr style="height:10%">
                	<td width="30%"></td>
                    <td width="70%"></td>
                </tr>
                <tr style="height:10%">
                	<td align="right">Evaluation Group &nbsp;</td>
                    <td><gw:list id="lstEvaGrp"  onchange=""/></td>
                </tr>
                <tr style="height:10%">
                	<td></td>
                    <td>
                    	<table width="100%">
							<tr>
                            	<td width="20%">&nbsp;</td>
                            	<td width="20%">&nbsp;</td>
                                <td width="20%"><gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('CONFIRM')"/></td>
                                <td width="20%"><gw:icon id="ibtnUnConfirm" alt="UnConfirm"  text="UnConfirm"  img="in"  styles="width:100%" onclick="OnConfirm('UN-CONFIRM')"/></td>
                                <td width="20%">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
		         </tr>
                <tr style="height:60%">
                	<td align="right" colspan=2>&nbsp;</td>                    
                </tr>
                <tr style="height:10%">
                	<td></td>
                    <td>
                    	<table width="100%">
							<tr>
                            	<td><gw:icon id="ibtnSearch" alt="New"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
                            	<td><gw:icon id="ibtnAddNew" alt="New"  text="New"  img="in"  styles="width:100%" onclick="OnNew()"/></td>
                                <td><gw:icon id="ibtnSave" alt="Save"  text="Save"  img="in"  styles="width:100%" onclick="OnSave()"/></td>
                                <td><gw:icon id="ibtnDelete" alt="Delete"  text="Delete"  img="in"  styles="width:100%" onclick="OnDelete()"/></td>
                            </tr>
                        </table>
                    </td>
		         </tr>
		         
        	</table>
            </fieldset>
    	</td>
    </tr>  
    <tr>
        <td colspan=3 style="height:1%">&nbsp;</td>
    </tr> 
  
    <tr>
        <td style="width:100%;height:63%" colspan=3>
             <gw:grid   
            id="idGrid" 
            header="_Type|Element|Person MBO Result|Target 1|Target 2|Weight|Level|Confirm YN|SEQ|_eva_master_pk|_Factor_PK|_thr_eva_emp_pk|_THR_EVA_MBO_V2_pk"                                       
            format="0|0|0|0|0|0|2|0|0|0|0|0|0"   
            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0"    
            defaults="||||||||||||"                     
            editcol="1|1|1|1|1|1|1|0|1|0|0|0|0"  
            widths="1200|3000|3000|3000|3000|1200|1200|1200|0|0|0|0|0"
            styles="width:100%; height:100%"  onafteredit="checkNumberInvalid()" oncelldblclick="onOpenPopup()"   
            acceptNullDate="T" editcolcolor="true" 
            sorting="T"/>  
        </td>    
    </tr>    
   
</table>
 
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtGradeEvatype" style="display:none" />
<gw:textbox id="txtGradeEvatimes" style="display:none" />
<gw:textbox id="txtEmpTotal" style="display:none" />
<gw:textbox id="txtGroupEval" style="display:none" />
<gw:textbox id="txtGroupFactor" style="display:none" />
<gw:textbox id="txt_thr_eva_emp_pk" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textbox id="txtGroup" style="display:none" />
<gw:textbox id="txtFactor" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtResult_2" style="display:none" />
<gw:textbox id="txtAction" style="display:none" />
<gw:textarea id="txtArea_Tmp"  text="" onchange="" styles='width:100%;display:none'/>


</body>



