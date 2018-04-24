<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">        
    <title>Untitled Page</title>
</head>
<script>

// grid 1  idGrid_M
//EvaGroup Name|Emp ID|Full Name|Status|Organization|Work Group|_emp_pk|_eva_master_pk|_eva_group_pk|_pk|_act_confirm|_photo_pk|_emp_login_pk|_eva_status_code|HR Opinion
var p1_eva_master_pk=7;
var p1_eva_group_pk=8;
var p1_pk=9;
var p1_act_confirm=10;
var p1_photo_pk=11;
var p1_eva_status_code=13;
var p1_hr_opinion=14;

// grid 2  idGrid
//_pk|_thr_eva_master_pk|_thr_eva_group_pk|Seq|Element Type|Element Name|Factor Name|Weight|Score|_Opinion|thr_eva_emp_pk|thr_eva_score_pk
var p2_element_type=4;
var p2_weight=7;
var p2_score=8;
var p2_Opinion=9;


var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 


var l_row=0;
var check_alert="";
var check_init=0;
var flag_save=false;  // check have click save button? false: no click, true: click save
var l_row_master=0;  // de khi search lai dat input tai dong hien tai dang confirm , unconfirm, cai nay chi ap dung cho truong hop confirm, unconfirm cho 1 nguoi 
var l_select_all=0;  // = select all

//-----------------------
function BodyInit()
{     
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK_login.text="<%=session("EMPLOYEE_PK")%>";
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>"; 	
	BindDataInit();
	txtEva_Emp_PK.text="";
	ibtnSave.SetEnable(false);
	ibtnDelete.SetEnable(false);
	
	//alert(txtEmp_PK_login.text);
    datchem00280_lst.Call();   
}
//-----------------------------
function BindDataInit()
{    
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 AND NVL(CLOSE_YN,'N')='N' order by 2 desc")%>";
    lstEvaTimes.SetDataText(ls_data);   
	
	//ls_data="<%=ESysLib.SetListDataSQL("select distinct A.pk,A.GROUP_ID||'-'||A.GROUP_NM from thr_eva_factor_v2 b,THR_EVA_GROUP_v2 a,thr_eva_master e where b.del_if=0 and B.FACTOR_TYPE='03' and a.del_if=0 and B.THR_EVA_GROUP_PK=a.pk and e.del_if=0 and NVL(e.CLOSE_YN,'N')='N' and e.pk=A.THR_EVA_MASTER_PK ORDER BY 2 ")%>";
    //lstEvaGrp.SetDataText(ls_data);	
	
	//ls_data="<%=ESysLib.SetListDataSQL("select a.code, a.code|| '-' || a.code_NM from vhr_hr_code a where a.id='HR0103' union select 'ALL','Select ALL' from dual order by 2 ")%>"
		
    //lstStatus.SetDataText(ls_data);
	//lstStatus.value="ALL";
	
	var data="";
	data ="#A;Achivement|#C;Competence"; 
	idGrid.SetComboFormat(p2_element_type,data);
}
//-----------------------------
function OnDataReceive(obj)
{    
    
    if (obj.id == "datchem00280_lst")
    {  		
		var tmp=txtEvaGroupData_tmp.text		
		if(tmp.substring(4)!="")  // bo di 4 ky tu dau, do 4 ky tu dau la DATA  ,  // co eva_group
		{
			txtEvaGroupData_tmp.text=txtEvaGroupData_tmp.text+"|ALL|Select All";			
		}	
		else   // khong co eva_group nao
		{
			txtEvaGroupData_tmp.text=txtEvaGroupData_tmp.text;
		}
		lstEvaGrp.SetDataText(txtEvaGroupData_tmp.text);	
		txtEva_Group_PK.text=lstEvaGrp.value;
        datchem00280_1.Call("SELECT");		
    }
	if (obj.id == "datchem00280_1")  
    {    
		if(l_select_all!=0)
		{
			idGrid_M.SelectRow(l_row_master);
		}
		datchem00280_2.Call();
    }
	if (obj.id == "datchem00280_2")  // get factor for eva group
    {   
		if(flag_save==true) // click save button
		{
			flag_save=false;
			alert("Edit Sucessful!");
			return;
		}
		else
		{			
			Action_EvaClose();
			if(idGrid_M.rows>1)
			{				
				if(lstEvaGrp.value=="ALL")
				{
					txtEva_Group_PK.text=idGrid_M.GetGridData(1,p1_eva_group_pk); 					
				}
				else
				{
					txtEva_Group_PK.text=lstEvaGrp.value;
				}
				datchem00280_3.Call("SELECT");
			} 
			else
			{
				check_init=1;
			}
		}
    }
    if (obj.id == "datchem00280_3")
    {   
		if(flag_save==true) // click save button
		{
			datchem00280_4.Call();  // update eva status
		}			
		else
		{
			check_init=1;
		}		
    }
	if (obj.id == "datchem00280_4")
    {
		if(txtResult.text==0)
		{
			datchem00280_1.Call("SELECT");
		}
		else
		{
			flag_save=false;
			l_row_master=0;
			l_select_all=0;
			if(txtResult.text=="1")  // eva master closed
			{
				alert("ERROR!!(EVA MASTER CLOSED.PLEASE CHECK DATA)");
				return;
			}
			else
			{
				alert("UPDATE EVA STATUS ERROR!");
				return;
			}
			
		}
	}   	
}
//-----------------------------
function Action_EvaClose()
{
	if(txtEvaPeriod_close_yn.text=="N")  
	{
		ibtnConfirm.SetEnable(true);
		ibtnUnConfirm.SetEnable(true);
	}
	else  // EVA PERIOD CLOSED
	{
		ibtnConfirm.SetEnable(false);
		ibtnUnConfirm.SetEnable(false);
	}
}
//-----------------------------
function OnChangeEvaPeriod()
{
	if(check_init==1) 
    {
		datchem00280_lst.Call();
	}
}
//-----------------------------
function OnChangeStatus()
{
	var temp_lstStatus="";
	if(lstStatus.value=="ALL")
	{
		temp_lstStatus="1020"
	}
	else
	{
		temp_lstStatus=lstStatus.value;
	}
	disableButton1(temp_lstStatus);	
	OnSearch();
}
//-----------------------------
function onShowFactor()
{
    var ctrl=idGrid_M.GetGridControl();  	
    if(ctrl.row>=1)
    {
		l_row=ctrl.row;
		ClearDetail();			
        txtEva_Emp_PK.text=idGrid_M.GetGridData(ctrl.row,p1_pk);
		txtEva_Group_PK.text=idGrid_M.GetGridData(ctrl.row,p1_eva_group_pk);        
        txtPhoto_PK.text=idGrid_M.GetGridData(ctrl.row,p1_photo_pk);
        imgEmp.SetDataText(txtPhoto_PK.text);
		Area_Self_Opinion.SetDataText(idGrid_M.GetGridData(l_row,p1_hr_opinion));   
		
		txtStatus_code.text=idGrid_M.GetGridData(ctrl.row,p1_eva_status_code);
		disableButton1(txtStatus_code.text);		
        datchem00280_3.Call("SELECT");

    }
}
//-----------------------------
function disableButton1(obj)
{
	if(obj=="30")
	{
		ibtnSave.SetEnable(false);
		ibtnDelete.SetEnable(false);
		Area_Self_Opinion.SetReadOnly(true);
	}
	else
	{
		ibtnSave.SetEnable(true);
		ibtnDelete.SetEnable(true);
		Area_Self_Opinion.SetReadOnly(false);
	}
}
//-----------------------------
/*function show_textArea()
{
    var ctrl=idGrid.GetGridControl();   
    var tmp;	
    if(ctrl.row>=1)
    {
		l_row=ctrl.row;		
		tmp=idGrid.GetGridData(l_row,p2_Opinion);
        Area_Self_Opinion.SetDataText(tmp);
    }
}*/
//-----------------------------
function onBlurOpinion()
{
	var ctrl=idGrid_M.GetGridControl();  
	if(ctrl.row>=1)
    {		
		if (l_row>0)
		{
			idGrid_M.SetGridText(l_row, p1_hr_opinion, Area_Self_Opinion.GetData());
			txtHROpinion.text = Area_Self_Opinion.GetData();
		}
	}
}
//-----------------------------
function OnSave()
{	
	//alert(txtEva_Emp_PK.text);
	var ctrl=idGrid_M.GetGridControl();
	if(txtEva_Emp_PK.text=="")	
	{
		alert("CHOOSE EVA EMP.");
		return;
	}
	if(check_save())
	{		
		if(confirm("Do you want to save?\nBạn muốn save?"))
		{    
			if(ctrl.SelectedRows==1)  // khuc nay chu yen lay lai dong dang DUOC CHON thoi
			{
				l_row_master=l_row;
				l_select_all=1;
			}
			else
			{
				l_row_master=0;
				l_select_all=0;
			}
			flag_save=true;			
			datchem00280_3.Call();
		}
	}
	else
	{
		alert(check_alert);
		return;
	}	
}
//-----------------------------
function check_save()
{	
	var ctrl=idGrid.GetGridControl();
	for (var i=1;i<ctrl.rows;i++) 
	{				
		if (idGrid.GetGridData(i,p2_weight)=="" )
		{
			check_alert="Please input weight at row " + i ;
			return 0;
		}	
		if(Number(idGrid.GetGridData(i,p2_score))>Number(idGrid.GetGridData(i,p2_weight)) && idGrid.GetGridData(i,p2_score)!="" && idGrid.GetGridData(i,p2_weight)!="")
		{
			check_alert="Score >weight at row " + i ;
			return 0;
		}
			
	}		
	return 1;
}
//-----------------------------
function OnDelete()
{	
	var ctrl = idGrid.GetGridControl();
	if(idGrid.rows <= 1)
	{
		alert("No data to delete");  // not have factor on grid
		return; 
	}
	if (confirm("do you want to DELETE?"))
	{
		for(i=1; i<idGrid.rows;i++)
		{
			if (ctrl.IsSelected(i)) 
			{
				idGrid.DeleteRowAt(i);
			}			
		}	
        	
	}        
}

//-----------------------------
function On_AfterEdit()
{
	cIdx=event.col;
	var tmpValue=idGrid.GetGridData(event.row,cIdx);		
	if(cIdx==p2_score)
	{		
		if(isNaN(tmpValue))	
		{
			alert("Input number for column score ");
			idGrid.SetGridText(event.row,cIdx,'')
			return;
		}
		else
		{
			if(Number(tmpValue)<0)
			{
				alert("Invalid data.Input number score >=0 and <= weight ");
				idGrid.SetGridText(event.row,cIdx,'')
				return;
			}
			if(Number(tmpValue)>Number(idGrid.GetGridData(event.row,p2_weight)))
			{
				alert("Invalid data.Input number score > weight ");
				idGrid.SetGridText(event.row,cIdx,'')
				return;
			}
		}
	}

}
//-----------------------------
function OnSearch()
{
	if(check_init==1) 
    {		
		ClearDetail();
		txtEva_Group_PK.text=lstEvaGrp.value;
		datchem00280_1.Call("SELECT");	
	}	
}
//-----------------------------
function onSelectAll()
{
    var ctrl=idGrid_M.GetGridControl();
    for(var i=1;i<ctrl.Rows;i++)
    {
        ctrl.IsSelected(i)="True";
    }


}
//-----------------------------
function OnConfirm(p_action)
{
    var ctrl=idGrid_M.GetGridControl();
    var tmp;
    if (ctrl.SelectedRows>=1)
    {
        if(confirm("Do you want to "+p_action+"?"))
        {
			if(ctrl.SelectedRows==1)  // khuc nay chu yen lay lai dong dang confirm thoi
			{
				l_row_master=ctrl.SelectedRow(i);
				l_select_all=1;
			}
			else
			{
				l_row_master=0;
				l_select_all=0;
			}
            for(var i=0;i<ctrl.SelectedRows;i++)
            {
                tmp=ctrl.SelectedRow(i);
                idGrid_M.SetGridText(tmp,p1_act_confirm,p_action);
            }
            datchem00280_1.Call();
        }
               
    }
}
//-----------------------------
function ClearDetail()
{
   txtPhoto_PK.text=""; 
   imgEmp.SetDataText(txtPhoto_PK.text); 
   Area_Self_Opinion.SetDataText("");   
   idGrid.ClearData();
   txtEva_Emp_PK.text="";   
   txtStatus_code.text="";
   //ibtnSave.SetEnable(false);
   //ibtnDelete.SetEnable(false);
    
}
//-----------------------------
function OnDataError(oData)
{
  var msg, code;
  var arr = System.Menu.getArrErr(oData);
  code = arr[0]; msg = arr[1];
  //alert(code);
  if(code=="20887")  // eva master closed  // error when save factor
  {
		flag_save=false;
		l_row_master=0;
		l_select_all=0;
		 alert("EVA MASTER CLOSED.PLEASE CHECK DATA.");
		return;
  }
  else if(code=="20888")  //DATA HAVE CONFIRMED  // error when save factor
  {
		flag_save=false;
		l_row_master=0;
		l_select_all=0;
		 alert("DATA HAVE CONFIRMED.PLEASE CHECK DATA.");
		return;
  }
  else if(code=="20890")  // error when confirm or unconfirm
  {		
		alert("EVA MASTER CLOSED.PLEASE CHECK DATA.");
		datchem00280_1.Call("SELECT");		
  }
  else if(code=="20891")  // error when confirm or unconfirm
  {		
		alert("EVA SCORE HAVE CLOSED. PLEASE CHECK DATA.");
		datchem00280_1.Call("SELECT");
  }
  else if(code=="20892")  // error when confirm or unconfirm
  {		
		alert("YOU NOT YET FINISH INPUT SCORE");
		datchem00280_1.Call("SELECT");
  }
  
  
  //var str = eval(oData).errmsg;
  //var str = eval(oData).errmsg.toString();
  //alert(str);
  //var msg = str.split('|')[0];
 // var msg = str.split('|')[0].split(":")[1];
  //alert(msg);
  //var code = str.split('|')[0].split(":")[0].split("-")[1];
  //alert(msg + " --- " + code);  
}
//-----------------------------
</script>
<body bgcolor='#F5F8FF'>
<!-------------------------LOAD EVA GROUP by eva times----------------------->
<gw:data id="datchem00280_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00280_v2_lst" > 
                <input>
                    <input bind="lstEvaTimes"/> 
                </input> 
                <output>
                
                    <output bind="txtEvaGroupData_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!---------------------LOAD EVA EMP V2 by eva group va eva times--------------------------->
<gw:data id="datchem00280_1" onreceive="OnDataReceive(this)" onerror="OnDataError(this)">
        <xml>
            <dso type="grid" parameter="7,8,9,10,12" function="HR_sel_chem00280_1_v2" procedure="HR_upd_chem00280_1_v2" > 
                <input bind="idGrid_M">                    
                    <input bind="lstEvaTimes" />
					<input bind="txtEva_Group_PK"/>                      
                    <input bind="lstStatus" /> 
					<input bind="txtEmp_PK_login" /> 
                </input>
                <output bind="idGrid_M"/>
            </dso>
        </xml>
    </gw:data>  

<!------------------------GET label------------------------>	
<gw:data id="datchem00280_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00280_2_v2" > 
                <input>
                    <input bind="lstEvaTimes"/>  
                    <input bind="txtEva_Group_PK" />                                      
                </input> 
                <output>
                    <output bind="lblInfor" /> 
					<output bind="txtEvaPeriod_close_yn" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>	
<!------------------------GET FACTOR by eva group------------------------>
<gw:data id="datchem00280_3" onreceive="OnDataReceive(this)" onerror="OnDataError(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,4,6,7,8,9,10,11" function="HR_sel_chem00280_3_v2" procedure="HR_upd_chem00280_3_v2" > 
                <input bind="idGrid">                    
                    <input bind="lstEvaTimes" />
				    <input bind="txtEva_Group_PK"/> 
					<input bind="txtEva_Emp_PK"/> 					
                </input>
                <output bind="idGrid"/>				
            </dso>
        </xml>
    </gw:data>  
<!------------------------THE SAME TIME INSERT EVA STATUS------------------------>
<gw:data id="datchem00280_4"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" parameter="" function="" procedure="HR_pro_chem00280_4_v2">  
                <input>
					<input bind="lstEvaTimes"/>
					<input bind="txtEva_Group_PK" />  
					<input bind="txtEva_Emp_PK"/>
					<input bind="txtEmp_PK_login" /> 	
					<input bind="txtHROpinion" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
               
            </dso> 
        </xml> 
    </gw:data>

	
<!------------------------------------------------>	
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
					<td colspan=70><gw:list id="lstEvaGrp"  onchange="OnSearch()"/></td>
				</tr>				
				<tr style="width:100%;height:5%">
					<td colspan=30 align="right">Status</td>
					<td colspan=70><gw:list  id="lstStatus" value="ALL" onchange="OnChangeStatus()">
									<data>|1020|Not Confirm|30|Confirmed|ALL|Select All</data>
					              </gw:list></td>
				</tr>
				<tr style="height:5%">
					<td align=center colspan=100 style="width:100%;height:5%"><b><gw:label id="lblInfor"  text="Total (s):" styles="color:red;font-size:13"/></b></td>                    
				</tr>
			   								
				<tr style="height:5%">
					<td colspan=25><gw:icon id="ibtnSel" alt="Select All"  text="Select All"  img="in"  styles="width:100%" onclick="onSelectAll()"/></td>
					<td colspan=25><gw:icon id="ibtnSearch" alt="New"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
					<td colspan=25><gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('CONFIRM')"/></td>
					<td colspan=25><gw:icon id="ibtnUnConfirm" alt="Un-Confirm"  text="Un-Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('UN-CONFIRM')"/></td>
				</tr>
				<tr style="width:100%;height:74%">
						<td colspan=100>
							 <gw:grid   
								id="idGrid_M" 
								header="EvaGroup Name|Emp ID|Full Name|Status|Organization|Work Group|_emp_pk|_eva_master_pk|_eva_group_pk|_pk|_act_confirm|_photo_pk|_emp_login_pk|_eva_status_code|_HR Opinion"                                       
								format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                                          
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
								defaults="||||||||||||||"                     
								editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
								widths="2000|1000|2000|2000|3000|3000|0|0|0|0|0|0|0|0|0"
								styles="width:100%; height:100%"     
								acceptNullDate="T"  
								sorting="T" oncellclick="onShowFactor()"
								/>  
						</td>    
			    </tr>    
            </table>
        </td>
        <td width=3%>&nbsp;</td>
        <td width=67%>
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
                        <td colspan=20 align="right"><gw:label id="lblSelf_Opinion"  text="HR Opinion" styles="color:blue;font-size:13"/></td>
                        <td colspan=65 align="right"><gw:textarea id="Area_Self_Opinion"  text="" onblur="onBlurOpinion()" styles='width:100%;height:95%'/></td>
                </tr> 
				<tr style="width:100%;height:10%">
                        <td colspan=14 align="right" valign="top">
                            &nbsp;
                        </td>
                        <td colspan=20 align="right">&nbsp;</td>
                        <td colspan=65 align="right">&nbsp;</td>
                </tr>  	
                <tr style="width:100%;height:5%">
				        <td colspan=86 align="right">&nbsp;</td>
                        <td colspan=5 align="right"><gw:icon id="ibtnSave" text="Save"  img="in"  styles="width:100%" onclick="OnSave()"/></td>
						<td colspan=2 align="right">&nbsp;</td>
						<td colspan=5 align="right"><gw:icon id="ibtnDelete" text="Delete"  img="in"  styles="width:100%" onclick="OnDelete()"/></td>
						<td colspan=2 align="right">&nbsp;</td>
                       
                        
                       
                </tr>


				<tr id="tr_grid" style="width:100%;height:74%">    
						<td colspan=100 >
							 <gw:grid   
							id="idGrid" 
							header="_pk|_thr_eva_master_pk|_thr_eva_group_pk|Seq|Element Type|Element Name|Factor Name|Weight|Score|_Opinion|_thr_eva_emp_pk|_thr_eva_score_pk"                                       
							format="0|0|0|0|2|0|0|0|0|0|0|0"   
							aligns="0|0|0|0|0|0|0|1|1|0|0|0"    
							defaults="||||||||||||"                     
							editcol="0|0|0|0|0|0|0|0|1|1|0|0"  
							widths="0|0|0|1000|2500|4000|4000|1200|1200|2000|0|0"
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
<gw:textbox id="txtEmp_PK_login" style="display:none" />
<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />
<gw:textbox id="txtEva_Emp_PK" text="" style="display:none" />
<gw:textbox id="txtEvaGroupData_tmp" text="" style="display:none" />
<gw:textbox id="txtEvaPeriod_close_yn" style="display:none" />
<gw:textbox id="txtEva_Group_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />
<gw:textbox id="txtStatus_code" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtHROpinion" text="" style="display:none" />
</body>



