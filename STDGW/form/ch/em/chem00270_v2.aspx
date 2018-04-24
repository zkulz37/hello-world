<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">        
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 

var l_eva_level;
var check_init=0;
var row_click;
var l_hr0104_eva_logic; //check cap tren co duoc thay du lieu cap duoi hay ko
var showhide_logic =1;
//luoi 1
//Emp ID|Full Name|Status|Status(Lower)|Organization|Work Group|_emp_pk|_eva_master_pk|
//_eva_group_pk_|_pk|_act_confirm|_c_eva_level|_photo_pk|_login_pk|opinion_lv1|opinion_lv2|opinion_lv3"                                       
var c_emp_id_0 = 0,
	c_full_name_0 = 1, 
	c_confirm_yn_0 = 2, 
	c_low_status = 3, 
	c_org_0 = 4, 
	c_wg_0 = 5, 
	c_emp_pk_0 = 6,
	c_eva_master_pk_0 = 7, 
	c_eva_group_pk_0 = 8, 
	c_pk_0 = 9,
	c_act_confrim_0 = 10,
	c_eva_level_0 = 11,
	c_photo_pk_0 = 12,
	c_login_pk = 13,
	c_opinion_lv1 = 14,
	c_opinion_lv2= 15,
	c_opinion_lv3 = 16;
  
var c_seq= 0 ,
	c_element_type_1 = 1,
	c_element_name_1 = 2,
	c_factor_name_1 = 3,
	c_weight_1 = 4,
	c_score_1 = 5,
	c_score_1_2 = 6,
	c_score_1_3 = 7,
	c_opinion_1_1 = 8 ,
	c_opinion_1_2 = 9,
	c_opinion_1_3 = 10,	
	c_pk_1 = 11,
	c_thr_eva_group = 12,
	c_thr_eva_master_pk = 13,	
	c_factor_type = 14,
	c_thr_eva_emp_pk = 15,
	c_eva_level_2 = 16;
function BodyInit()
{     
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>"; 	
	BindDataInit();
    datchem00270_lst.Call();   
}

function BindDataInit()
{    
	var data="";
	data ="#A;Achivement|#C;Competence"; 
	idGrid.SetComboFormat(c_element_type_1,data);
		
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 AND NVL(CLOSE_YN,'N')='N' order by 2 desc")%>";
    lstEvaTimes.SetDataText(ls_data);   
	
	ls_data="<%=ESysLib.SetListDataSQL("select distinct A.pk,A.GROUP_ID||'-'||A.GROUP_NM from thr_eva_factor_v2 b,THR_EVA_GROUP_v2 a,thr_eva_master e where b.del_if=0 and B.FACTOR_TYPE='03' and a.del_if=0 and B.THR_EVA_GROUP_PK=a.pk and e.del_if=0 and NVL(e.CLOSE_YN,'N')='N' and e.pk=A.THR_EVA_MASTER_PK ORDER BY 2 ")%>";
    lstEvaGrp.SetDataText(ls_data);	
	/*
	ls_data="<%=ESysLib.SetListDataSQL("select a.code, a.code|| '-' || a.code_NM from vhr_hr_code a where a.id='HR0103'")%>"
    lstStatus.SetDataText(ls_data);
	*/
	ls_data = "<%=ESysLib.SetListDataSQL("select nvl(a.char_1,'Y'),a.char_1 from vhr_hr_code a where a.id='HR0104' order by seq")%>";
    lstEvalogic.SetDataText(ls_data);
    l_hr0104_eva_logic=lstEvalogic.value;
	
	ls_data="<%=ESysLib.SetListDataSQL("select a.code, a.code|| '-' || a.code_NM from vhr_hr_code a where a.id='HR0220'")%>";
    lstLevel.SetDataText(ls_data);
    lstLevel.value="1";
	onShow_by_level();
	
}
function OnDataReceive(obj)
{    
    
    if (obj.id == "datchem00270_lst")
    { 
        lstEvaGrp.SetDataText(txtEvaGroup.text+"|ALL|Select All");       
        datchem00270.Call("SELECT");		
    }
	if (obj.id =="datchem00270_2")
	{		  
		if (txtflag.text=="Save")
		{		
		txtflag.text="";
		datchem00270_3.Call();
		
		}
	txtflag.text="";		
	}
	if (obj.id =="datchem00270_5")
	{
		if (txtResult.text =="1")
		{
		alert("Clear score success ! \n Xóa điểm thành công");
		datchem00270_2.Call("SELECT");
		}
	}
	if (obj.id == "datchem00270")
	{
		datchem00270_4.Call();
	}
	if (obj.id == "datchem00270_4")
	{
		//datchem00270.Call("SELECT");	
	}
	//
	if(obj.id == "datchem00270_6")
	{
		if (txt_check_save.text=="PASS")
		{
			datchem00270_2.Call();
		}
		else 
		{
            alert(txt_check_save.text);
			txtflag.text="";
		}
			
	}
	check_init=1;	
}
function OnChangeEvaPeriod()
{
    datchem00270_lst.Call();
}
function OnChangeEvaGroup()
{
    datchem00270.Call("SELECT");
}
function OnChangeLevel()
{
    onShow_by_level();
    datchem00270.Call("SELECT");
}
function onShow_by_level()
{

	if (l_hr0104_eva_logic == "Y")
	{
		showhide_logic = 0;
	}	
	
    var i;
    var ctrl=idGrid.GetGridControl();
    l_eva_level=lstLevel.value;

    Area_manager_lv1_Opinion.SetReadOnly(true);
    Area_manager_lv2_Opinion.SetReadOnly(true);
    Area_manager_lv3_Opinion.SetReadOnly(true);

	ClearDetail();
	
    for(i=c_score_1;i<=c_opinion_1_3;i++)
       {
            ctrl.ColHidden(i)=1;
       }
    if(l_eva_level=="1")//level 1 eva
    {       
		idGrid.SetColEdit(c_score_1,1);
		//idGrid.SetColEdit(c_opinion_1_1,0);
		Area_manager_lv1_Opinion.SetReadOnly(false);
		ctrl.ColHidden(c_score_1)=0;        
	}
    if(l_eva_level=="2")//level 2 eva
    {     
		idGrid.SetColEdit(c_score_1,0);
		idGrid.SetColEdit(c_score_1_2,1);
		//idGrid.SetColEdit(c_opinion_1_2,0);
		Area_manager_lv2_Opinion.SetReadOnly(false);
		ctrl.ColHidden(c_score_1)=showhide_logic;
		ctrl.ColHidden(c_score_1_2)=0;       
    }
	  if(l_eva_level=="3")//level 3 eva
    {      
		idGrid.SetColEdit(c_score_1,0);
		idGrid.SetColEdit(c_score_1_2,0);
		idGrid.SetColEdit(c_score_1_3,1);
		//idGrid.SetColEdit(c_opinion_1_2,0);
		Area_manager_lv3_Opinion.SetReadOnly(false);
		ctrl.ColHidden(c_score_1)=showhide_logic;
		ctrl.ColHidden(c_score_1_2)=showhide_logic;  
		ctrl.ColHidden(c_score_1_3)=0;   		
    }
	
	check_init=1;
    //onTextAreaByLevel(l_eva_level);

}
function OnSearch()
{       
        ClearDetail();
        l_eva_level=lstLevel.value;
        datchem00270.Call("SELECT");  
}
function onShowDetail()
{
    var ctrl=idGrid_M.GetGridControl();      
    if(ctrl.row>=1)
    {		
		l_row=ctrl.row;  
		row_click = ctrl.row;  
		ClearDetail();
        txtEva_Emp_PK.text=idGrid_M.GetGridData(ctrl.row,c_pk_0);       
        txtPhoto_PK.text=idGrid_M.GetGridData(ctrl.row,c_photo_pk_0);
        txtEvaGroup_PK.text=idGrid_M.GetGridData(ctrl.row,c_eva_group_pk_0);
		//alert(txtPhoto_PK.text);
        imgEmp.SetDataText(txtPhoto_PK.text);	

		Area_manager_lv1_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv1));   
        Area_manager_lv2_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv2));   
        Area_manager_lv3_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv3));   
		
        datchem00270_2.Call("SELECT");

    }
}
function onShowOpinion()
{
    var ctrl=idGrid_M.GetGridControl();    
    if(ctrl.row>0)
    {
        l_row=ctrl.row;  
		row_click = ctrl.row;  
        //alert(row_click);
		//alert(idGrid.GetGridData(l_row,c_opinion_1_1));
        Area_manager_lv1_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv1));   
        Area_manager_lv2_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv2));   
        Area_manager_lv3_Opinion.SetDataText(idGrid_M.GetGridData(l_row,c_opinion_lv3));   
        
    }
}
function OnSave()
{
	var ctrl=idGrid.GetGridControl();
	
	if(confirm("Do you want to save?\nBạn muốn save?"))
    {   		
		datchem00270_6.Call();
		txtflag.text="Save";
    }
}
function onClearScore()
{
// alert(check_init);
	txtAction.text="CLEAR-SCORE";
    if(check_init==1)
    {
       if(confirm("do you want to clear score"))
       {
            datchem00270_5.Call();
       }
        
    }
}
function onBlurOpinion(p_level)
{    
    var ctrl=idGrid_M.GetGridControl();    
    if(ctrl.row>0)
    {
        //l_row=ctrl.row; 
		l_row =	row_click;
		
		 if(p_level==1)//m1
		{
		     idGrid_M.SetGridText(l_row, c_opinion_lv1, Area_manager_lv1_Opinion.GetData());
		}
		else if(p_level==2)//m2
		{
		    idGrid_M.SetGridText(l_row, c_opinion_lv2, Area_manager_lv2_Opinion.GetData());
		}
		else if(p_level==3)//m3
		{
		    idGrid_M.SetGridText(l_row, c_opinion_lv3, Area_manager_lv3_Opinion.GetData());
		}
		txt_opinion_lv1.text = Area_manager_lv1_Opinion.GetData();
		txt_opinion_lv2.text = Area_manager_lv2_Opinion.GetData();
		txt_opinion_lv3.text = Area_manager_lv3_Opinion.GetData();
	}

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
            datchem00270.Call();
        }
               
    }
}
function ClearDetail()
{
   txtPhoto_PK.text=""; 
   imgEmp.SetDataText(txtPhoto_PK.text);  
   Area_manager_lv1_Opinion.SetDataText("");
   Area_manager_lv2_Opinion.SetDataText("");
   Area_manager_lv3_Opinion.SetDataText("");
   idGrid.ClearData();
    
}
function On_AfterEdit()
{
	var tmp_weight,tmp_score_lv1,tmp_score_lv2,tmp_score_lv3;
	cIdx=event.col;
	tmp_weight=idGrid.GetGridData(event.row,c_weight_1)	;
	//alert(tmp_weight);
	if (cIdx==c_score_1)
	{
	    tmp_score_lv1 =idGrid.GetGridData(event.row,cIdx);	   
	    if ( IsNumeric(tmp_score_lv1) == false)
	    {
	        alert("Input score is not charter \n Điển chấm không được là ký tự ! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
	    }
	    if(Number(tmp_score_lv1) > Number(tmp_weight))
	    {	        
	        alert("Input score is not be larger weight \n Điển chấm không được lớn hơn weight! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
		}
	}
	if (cIdx==c_score_1_2)
	{
	    tmp_score_lv2=idGrid.GetGridData(event.row,cIdx)	;    
	    if ( IsNumeric(tmp_score_lv2) == false)
	    {
	        alert("Input score is not charter \n Điển chấm không được là ký tự ! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
	    }
	    if(Number(tmp_score_lv2) >Number(tmp_weight))
	    {
	        alert("Input score is not be larger weight \n Điển chấm không được lớn hơn weight! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
	    }
	}
	if (cIdx==c_score_1_3)
	{
	    tmp_score_lv3=idGrid.GetGridData(event.row,cIdx)	;  
	    if ( IsNumeric(tmp_score_lv3) == false)
	    {
	        alert("Input score is not charter \n Điển chấm không được là ký tự ! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
	    }
	    if(Number(tmp_score_lv3) > Number(tmp_weight))
	    {
	        alert("Input score is not be larger weight \n Điển chấm không được lớn hơn weight! ");
	        idGrid.SetGridText(event.row,cIdx,'');
	        return;
	    }
	}
}

</script>
<body bgcolor='#F5F8FF'>

<!------------------------------------------------>

<gw:data id="datchem00270_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00270_v2_lst" > 
                <input>
                    <input bind="lstEvaTimes"/> 
                </input> 
                <output>
                    <output bind="txtEvaGroup" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------>	
<gw:data id="datchem00270" onreceive="OnDataReceive(this)">
        <xml>                                     		
            <dso type="grid" parameter="0,1,2,4,5,6,7,8,9,10,11,13" function="HR_sel_chem00270_v2" procedure="HR_upd_chem00270_v2" > 
                <input bind="idGrid_M">
                    <input bind="lstEvaGrp"/>  
                    <input bind="lstEvaTimes" />
                    <input bind="lstLevel" />
                    <input bind="lstStatus" />
                    <input bind="txtEmp_PK" />  
                </input>
                <output bind="idGrid_M"/>
            </dso>
        </xml>
</gw:data> 
<gw:data id="datchem00270_2" onreceive="OnDataReceive(this)">
        <xml>		
            <dso type="grid" parameter="1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="HR_sel_chem00270_2_v2" procedure="HR_upd_chem00270_2_v2" > 
                <input bind="idGrid">
                    <input bind="txtEva_Emp_PK"/>  
					<input bind="txtEvaGroup_PK"/>
					<input bind="lstEvaTimes"/>
					<input bind="lstLevel"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data> 
<gw:data id="datchem00270_3" onreceive=""  > 
        <xml> 
            <dso  type="process" procedure="HR_upd_chem00270_3_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK" /> 
					<input bind="lstLevel" /> 	
					<input bind="txt_opinion_lv1" /> 	
					<input bind="txt_opinion_lv2" /> 		
					<input bind="txt_opinion_lv3" /> 		
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>	
<gw:data id="datchem00270_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00270_3_v2" > 
                <input>
                    <input bind="lstEvaGrp"/>  
                    <input bind="lstEvaTimes" />
                    <input bind="lstLevel" />
                    <input bind="lstStatus" />
                    <input bind="txtEmp_PK" />  
                </input> 
                <output>
                    <output bind="lblInfo" />
                    <output bind="txtNumOfLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datchem00270_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00270_5_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="txtEmp_PK"/>    
                    <input bind="lstLevel"/>
					<input bind="txtAction"/>
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------Check flag save------------------------->
<gw:data id="datchem00270_6" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00270_6_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="txtEmp_PK"/>    
                    <input bind="lstLevel"/>                 
                </input> 
                <output>
                    <output bind="txt_check_save" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr style="height:100%">
        <td width=30%>
            <table id="Table1" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
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
				<tr style="width:100%;height:5%">
					<td colspan=30 align="right">Eva Times &nbsp;</td>
					<td colspan=70><gw:list id="lstEvaTimes"   onchange="OnChangeEvaPeriod()"/></td>
				</tr>
				<tr style="width:100%;height:5%">
					<td colspan=30 align="right">Eva Group &nbsp;</td>
					<td colspan=70><gw:list id="lstEvaGrp"  onchange="OnChangeEvaGroup()"/></td>
				</tr>				
				 <tr style="width:100%;height:5%">
                                <td colspan=30 align="right">Level &nbsp;</td>
                                <td colspan=70><gw:list id="lstLevel"   onchange="OnChangeLevel()"/></td>
                            </tr>
				<tr style="width:100%;height:5%">
					<td colspan=30 align="right">Status &nbsp;</td>
					<td colspan=70><gw:list  id="lstStatus" onchange="OnSearch()"><data>|1020|Not Confirm|30|Confirmed</data></gw:list></td>
				</tr>
				<tr style="height:5%">
					<td colspan=30 align="right"> &nbsp;</td>
					<td align=center colspan=70 style="width:100%;height:5%"><b><gw:label id="lblInfo"  text="label" styles="color:red;font-size:13"/></b></td>                    
				</tr>
			   								
				<tr style="height:5%">
					<td colspan=25><gw:icon id="ibtnSel" alt="Select All"  text="Select All"  img="in"  styles="width:100%" onclick="onSelectAll()"/></td>
					<td colspan=25><gw:icon id="ibtnSearch" alt="New"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
					<td colspan=25><gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('CONFIRM')"/></td>
					<td colspan=25><gw:icon id="ibtnUnConfirm" alt="Un-Confirm"  text="Un-Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('UN-CONFIRM')"/></td>
				</tr>
				<tr style="width:100%;height:69%">
						<td colspan=100>
							 <gw:grid   
								id="idGrid_M" 
								header="Emp ID|Full Name|Status|Status(Lower)|Organization|Work Group|_emp_pk|_eva_master_pk|_eva_group_pk_|_pk|_act_confirm|_c_eva_level|_photo_pk|_login_pk|opinion_lv1|opinion_lv2|opinion_lv3"                                       
								format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                                          
								aligns="0|0|0|0||00|0|0|0|0|0|0|0|0|0|0"    
								defaults="|||||||||||||||"                     
								editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
								widths="1000|2000|1200|1200|3000|3000|0|0|0|0|0|0|0|0|0|0"
								styles="width:100%; height:100%"     
								acceptNullDate="T"  
								sorting="T" oncellclick="onShowDetail()"
								/>  
						</td>    
			    </tr>    
            </table>
        </td>
        <td width=1%>&nbsp;</td>
        <td width=69%>
            <table id="Table2" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
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
	            <tr style="width:100%;height:10%">
                        <td rowspan=2 colspan=15 align="right" valign="top">
                            <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100;height:100;border-top: 1 solid #87b0c6; border-bottom: 1 solid #87b0c6; border-left: 1 solid #87b0c6; border-right: 1 solid #87b0c6 "/>
                        </td>
                        <td colspan=20 align="right"><gw:label id="lblManager_lv1_Opinion"  text="Manager(L1) Opinion" styles="color:blue;font-size:13"/></td>
                        <td colspan=65 align="right"><gw:textarea id="Area_manager_lv1_Opinion"  text="" onblur="onBlurOpinion(1)" styles='width:100%;height:95%'/></td>
                </tr> 
				<tr style="width:100%;height:10%">                      
                        <td colspan=20 width="20%" align="right"><gw:label id="lblManager_lv2_Opinion"  text="Manager(L2) Opinion" styles="color:blue;font-size:13"/></td>
                        <td colspan=80 width="80%" align="right"><gw:textarea id="Area_manager_lv2_Opinion"  text="" onblur="onBlurOpinion(2)" styles='width:100%;height:95%'/></td>
                </tr>  
				<tr style="width:100%;height:10%">
                        <td colspan=15 width="15%" align="right" valign="top">&nbsp;</td>
                        <td colspan=20 width="20%" align="right"><gw:label id="lblManager_lv3_Opinion"  text="Manager(L3) Opinion" styles="color:blue;font-size:13"/></td>
                        <td colspan=65 width="65%" align="right"><gw:textarea id="Area_manager_lv3_Opinion"  text="" onblur="onBlurOpinion(3)" styles='width:100%;height:95%'/></td>
                </tr> 	
                <tr style="width:100%;height:5%">
				        <td colspan=86 width="93%" align="right">&nbsp;</td>
                        <td colspan=5  width="5%" align="right"><gw:icon id="ibtnSave" text="Save"  img="in"  styles="width:100%" onclick="OnSave()"/></td>
						<td colspan=2  width="2%" align="right">&nbsp;</td>  
						<td colspan=5 align="right"><gw:icon id="ibtnClear" text="Clear Score"  img="in"  styles="width:100%" onclick="onClearScore()"/></td>						
						<td colspan=2  width="2%" align="right">&nbsp;</td>    
                </tr>

				<tr id="tr_grid" style="width:100%;height:79%">    
						<td colspan=100 >
							 <gw:grid   
							id="idGrid" 							
							header="Seq|Element Type|Element Name|Factor Name|Weight|Score 1|Score 2|Score 3|_Opinion_1|_Opinion_2|_Opinion_3|_pk|_thr_eva_group|_thr_eva_master_pk|_factor_type|_thr_eva_emp_pk|_eva_level|_Factor_pk"                                       
							format= "0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"   
							aligns=	"1|1|0|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0"    
							defaults="|||||||||||||||||"                     
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
  							widths="1200|2000|2000|2000|2000|1500|1500|1500|0|0|0|1200|1200|1200|1200|1200|1200|1200"
							styles="width:100%; height:100%"     
							acceptNullDate="T" 							
							onafteredit="On_AfterEdit()"
							sorting="T"/>  
						</td>    
				</tr>    
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtflag" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtEva_Emp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textbox id="txtAction" style="display:none" />
<gw:textbox id="txtNumOfLevel" style="display:none" />
<gw:list id="lstEvalogic" style="display:none"/>
<gw:textbox id="txtEvaGroup" style="display:none" />
<gw:textbox id="txtEvaGroup_PK" style="display:none" />
<gw:textbox id="txt_check_save" styles="display:none"/>
<gw:textbox id="txt_opinion_lv1" styles="display:none"/>
<gw:textbox id="txt_opinion_lv2" styles="display:none"/>
<gw:textbox id="txt_opinion_lv3" styles="display:none"/>

</body>



