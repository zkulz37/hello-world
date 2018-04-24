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
var c_emp_id_0=0, c_full_name_0=1, c_confirm_yn_0=2,c_low_status=3, c_org_0=4, c_wg_0=5, c_emp_pk_0=6;
var c_eva_master_pk_0=7, c_eva_group_pk_0=8, c_pk_0=9,c_act_confrim_0=10,c_eva_level_0=11,c_photo_pk_0=12,c_eva_status_0=13;
var c_l1_pk=14,c_l2_pk=15,c_l3_pk=16,c_login_emp_pk=17;
var c_self_opinion_m=18, c_m1_opinion_m=19, c_m2_opinion_m=20, c_m3_opinion_m=21;


//"_Type|Element|Person MBO Result|Target 1|Target 2|Weight(A)|S.Rate(B)|S.Eva|M1.Rate(B)|M1.Eva|M2.Rate(B)|M2.Eva|M3.Rate(B)|M3.Eva
//|Self Opinion|M1 Opinion|M2 Opinion|M3 Opinion
//|_Confirm YN|_SEQ|Eva_master_pk|factor_pk|eva_emp_pk|eva_mbo_pk"                                       
var c_type=0, c_element=1, c_mbo_result=2, c_target_1=3, c_target_2=4, c_weight=5;
var c_s_rate=6,c_s_eva=7,c_m1_rate=8,c_m1_eva=9,c_m2_rate=10,c_m2_eva=11,c_m3_rate=12,c_m3_eva=13, c_seq=14;
var c_self_opinion=15, c_m1_opinion=16, c_m2_opinion=17, c_m3_opinion=18; //opinion o detail chuyen sang opinion cho master
var c_eva_master_pk=19, c_factor_pk=20, c_thr_eva_emp_pk=21, c_THR_EVA_MBO_V2_pk=22, c_eva_level=23;
var c_self_pk=24,c_m1_pk=25,c_m2_pk=26,c_m3_pk=27,c_eva_status=28;


var l_data;
var check_init=0;

var l_eva_level;
var l_row=0;
var l_row_master=0;
var flag_save=0;
var l_hr0104_eva_logic; //check cap tren co duoc thay du lieu cap duoi hay ko

function BodyInit()
{     
    if (v_language!="ENG")
        System.Translate(document); 
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
    txtCompany_PK.text="<%=session("COMPANY_PK")%>";
    txtLang.text="<%=session("SESSION_LANG")%>";  

    
   
    SetGridFormat();
    BindDataInit();
    datchem00260_lst.Call();
    //
}

function BindDataInit()
{
    
    ls_data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 order by 2 desc")%>";
    lstEvaTimes.SetDataText(ls_data); 

    ls_data="<%=ESysLib.SetListDataSQL("select a.pk, a.GROUP_ID|| '-' || a.GROUP_NM from THR_EVA_GROUP_v2 a where a.DEL_IF=0 and a.MBO_YN='Y' ")%>";
    lstEvaGrp.SetDataText(ls_data);

    ls_data = "<%=ESysLib.SetListDataSQL("select nvl(a.char_1,'Y'),a.char_1 from vhr_hr_code a where a.id='HR0104' order by seq")%>";

    lstEvalogic.SetDataText(ls_data);
    l_hr0104_eva_logic=lstEvalogic.value;

    imgEmp.SetEnable(0); 
   
    idGrid.GetGridControl().FrozenCols =5;
    idGrid.GetGridControl().ScrollTrack=true;
    
    
}

function onValidate()
{
    var ctrl=idGrid.GetGridControl();
    //c_s_rate=6,c_s_eva=7,c_m1_rate=8,c_m1_eva=9,c_m2_rate=10,c_m2_eva=11,c_m3_rate=12,c_m3_eva=13
    if(ctrl.rows>2)
    {
        for(var i=2;i<ctrl.rows;i++)
        {
            if(idGrid.GetGridData(i,c_s_rate)!="")
            {
                if (IsNumeric(idGrid.GetGridData(i,c_s_rate))==false)
                {
                    alert("Value of Self rate must is numeric.");
                    return 0;
                 } 
                 if (Number(idGrid.GetGridData(i,c_s_rate))>100)
                {
                    alert("Value of Self rate must <=100.");
                    return 0;
                 } 
            }
            if(idGrid.GetGridData(i,c_m1_rate)!="")
            {
                if (IsNumeric(idGrid.GetGridData(i,c_m1_rate))==false)
                {
                    alert("Value of M1 rate must is numeric.");
                    return 0;
                 } 
                 if (Number(idGrid.GetGridData(i,c_m1_rate))>100)
                {
                    alert("Value of M1 rate must <=100.");
                    return 0;
                 } 
            }
            if(idGrid.GetGridData(i,c_m2_rate)!="")
            {
                if (IsNumeric(idGrid.GetGridData(i,c_m2_rate))==false)
                {
                    alert("Value of M2 rate must is numeric.");
                    return 0;
                 } 
                 if (Number(idGrid.GetGridData(i,c_m1_rate))>100)
                {
                    alert("Value of M2 rate must <=100.");
                    return 0;
                 } 
            }
            if(idGrid.GetGridData(i,c_m3_rate)!="")
            {
                if (IsNumeric(idGrid.GetGridData(i,c_m3_rate))==false)
                {
                    alert("Value of M3 rate must is numeric.");
                    return 0;
                 } 
                 if (Number(idGrid.GetGridData(i,c_m3_rate))>100)
                {
                    alert("Value of M3 rate must <=100.");
                    return 0;
                 } 
            }
        }
        return 1;
     }
     else
     {
        alert("No data to save");
        return 0;
     }
             
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

        fg.MergeCol(c_s_rate) = true;
		fg.Cell(0, 0, c_s_rate, 1, c_s_rate) = "S.Rate";

        fg.MergeCol(c_s_eva) = true;
		fg.Cell(0, 0, c_s_eva, 1, c_s_eva) = "S.Eva";

        fg.MergeCol(c_m1_rate) = true;
		fg.Cell(0, 0, c_m1_rate, 1, c_m1_rate) = "M1.Rate";

        fg.MergeCol(c_m1_eva) = true;
		fg.Cell(0, 0, c_m1_eva, 1, c_m1_eva) = "M1.Eva";

        fg.MergeCol(c_m2_rate) = true;
		fg.Cell(0, 0, c_m2_rate, 1, c_m2_rate) = "M2.Rate";

        fg.MergeCol(c_m2_eva) = true;
		fg.Cell(0, 0, c_m2_eva, 1, c_m2_eva) = "M2.Eva";

        fg.MergeCol(c_m3_rate) = true;
		fg.Cell(0, 0, c_m3_rate, 1, c_m3_rate) = "M3.Rate";

        fg.MergeCol(c_m3_eva) = true;
		fg.Cell(0, 0, c_m3_eva, 1, c_m3_eva) = "M3.Eva";

       

        fg.MergeCol(c_seq) = true;
		fg.Cell(0, 0, c_seq, 1, c_seq) = "Seq";


        /*
        var c_s_rate=6,c_s_eva=7,c_m1_rate=8,c_m1_eva=9,c_m2_rate=10,c_m2_eva=11,c_m3_rate=12,c_m3_eva=13, c_confirm_yn=14, c_seq=15, c_eva_master_pk=16;
        var c_self_opinion=16, c_m1_opinion=17, c_m2_opinion=18, c_m3_opinion=19;
var c_factor_pk=17, c_thr_eva_emp_pk=18, c_THR_EVA_MBO_V2_pk=19;

        "_Type|Element|Person MBO Result|Target 1|Target 2|Weight(A)|S.Rate(B)|S.Eva|M1.Rate(B)|M1.Eva|M2.Rate(B)|M2.Eva|M3.Rate(B)|M3.Eva|Confirm YN|SEQ|Eva_master_pk|factor_pk|eva_emp_pk|eva_mbo_pk"                                       
		
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




function OnDataReceive(obj)
{    
    
    if (obj.id == "datchem00260_lst")
    {   
        lstEvaGrp.SetDataText(txtEvaGroup.text+"|ALL|Select All");     
        datchem00260_level.Call();
    }
    if (obj.id == "datchem00260_level")
    {        
        datchem00260.Call("SELECT");
    }
    if (obj.id == "datchem00260_2")
    {        
        //alert(idGrid.rows);
        SetGridFormat();
    }  
    if(obj.id == "datchem00260")
    {
        auto_resize_column(idGrid_M,0,idGrid_M.cols-1,8);           
        datchem00260_3.Call();
    }
    if(obj.id == "datchem00260_3")
    {
        
        if(txtNumOfLevel.text=="2")//ko su dung level 3
        {
            Table_M2.style.display='';  
            Table_M2.style.height='10%';
            Table_M3.style.display='none';  
            Table_M3.style.height='0%';
            Table_grid_D.style.height='70%'; 
        }
        if(txtNumOfLevel.text=="1")//ko su dung level 2,3
        {
            Table_M2.style.display='none';  
            Table_M2.style.height='0%';
            Table_M3.style.display='none';  
            Table_M3.style.height='0%';
            Table_grid_D.style.height='80%'; 
        }
        

        onShow_by_level();

        check_init=1;
    }
    if(obj.id == "datchem00260_2")
    {
        if(flag_save==1)//co save
        {
            flag_save=0;//tra lai trang thai
            datchem00260_4.Call();
        }
    }
    if(obj.id == "datchem00260_5")
    {
       datchem00260_2.Call("SELECT");
    }
    if(obj.id == "datchem00260_6")
    {
       if(txtResult.text=="PASS")  
            datchem00260_2.Call();
        else 
            alert(txtResult.text);
    }
    
    
     
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function OnSearch()
{   
    if(check_init==1) 
    {
        ClearDetail();
        l_eva_level=lstLevel.value;
        if(lstStatus.value=="30") //score confirmed
        {
            ibtnSave.SetEnable(0);
            ibtnClear.SetEnable(0);
        }
        else
        {
            ibtnSave.SetEnable(1);
            ibtnClear.SetEnable(1);
        }

        datchem00260.Call("SELECT");
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
            datchem00260.Call();
        }
               
    }
}


function onShowDetail()
{
    var ctrl=idGrid_M.GetGridControl();
    //alert(ctrl.row);
    l_row_master=ctrl.row;

    if(ctrl.row>=1)
    {

        txtEva_Emp_PK.text=idGrid_M.GetGridData(ctrl.row,c_pk_0);
        
        txtPhoto_PK.text=idGrid_M.GetGridData(ctrl.row,c_photo_pk_0);
        txtEvaStatus.text=idGrid_M.GetGridData(ctrl.row,c_eva_status_0);
        imgEmp.SetDataText(txtPhoto_PK.text);
        show_textArea(l_row_master);

        datchem00260_2.Call("SELECT");

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
    datchem00260_lst.Call();
}

function ClearDetail()
{
   txtPhoto_PK.text=""; 
   imgEmp.SetDataText(txtPhoto_PK.text); 
   Area_Self_Opinion.SetDataText("");
   Area_M1_Opinion.SetDataText("");
   Area_M2_Opinion.SetDataText("");
   Area_M3_Opinion.SetDataText("");
   idGrid.ClearData();
    
}


function onShow_by_level()
{
    var i;
    var ctrl=idGrid.GetGridControl();
    l_eva_level=lstLevel.value;

    idGrid.SetColEdit(c_s_rate,1);
    idGrid.SetColEdit(c_m1_rate,1);
    idGrid.SetColEdit(c_m2_rate,1);
    idGrid.SetColEdit(c_m3_rate,1);

    for(i=c_m1_rate;i<=c_m3_eva;i++)
       {
            ctrl.ColHidden(i)=0;
       }


    if(l_eva_level=="0")//self eva
    {
       
       for(i=c_m1_rate;i<=c_m3_eva;i++)
       {
            ctrl.ColHidden(i)=1;
       }

        idGrid.SetColEdit(c_s_rate,1);

    }


    if(l_eva_level=="1")//level 1 eva
    {
       

        idGrid.SetColEdit(c_s_rate,0);
        idGrid.SetColEdit(c_m1_rate,1);
        

       for(i=c_m2_rate;i<=c_m3_eva;i++)
       {
            ctrl.ColHidden(i)=1;
       }


       if(l_hr0104_eva_logic=="Y")//ko duoc thay cap sel
       {
        
            for(i=c_s_rate;i<=c_s_eva;i++)
                ctrl.ColHidden(i)=0;
        
       }
       else
       {
            for(i=c_s_rate;i<=c_s_eva;i++)
                ctrl.ColHidden(i)=1;
       }


    }

    if(l_eva_level=="2")//level 2 eva
    {
       

       idGrid.SetColEdit(c_s_rate,0);
       idGrid.SetColEdit(c_m1_rate,0);
       idGrid.SetColEdit(c_m2_rate,1);

       for(i=c_m3_rate;i<=c_m3_eva;i++)
       {
            ctrl.ColHidden(i)=1;
       }
       if(l_hr0104_eva_logic=="Y")//ko duoc thay cap sel
       {
        
            for(i=c_s_rate;i<=c_m1_eva;i++)
                ctrl.ColHidden(i)=0;
        
       }
       else
       {
            for(i=c_s_rate;i<=c_m1_eva;i++)
                ctrl.ColHidden(i)=1;
       }

    }

    if(l_eva_level=="3")//level 3 eva
    {
       

       idGrid.SetColEdit(c_s_rate,0);
       idGrid.SetColEdit(c_m1_rate,0);
       idGrid.SetColEdit(c_m2_rate,0);

       idGrid.SetColEdit(c_m3_rate,1);

       for(i=c_m3_rate;i<=c_m3_eva;i++)
       {
            ctrl.ColHidden(i)=1;
       }
       if(l_hr0104_eva_logic=="Y")//ko duoc thay cap sel
       {
        
            for(i=c_s_rate;i<=c_m2_eva;i++)
                ctrl.ColHidden(i)=0;
        
       }
       else
       {
            for(i=c_s_rate;i<=c_m2_eva;i++)
                ctrl.ColHidden(i)=1;
       }

    }

    onTextAreaByLevel(l_eva_level);

}

function OnChangeLevel()
{
    
    //alert(check_init);
    ClearDetail();
    onShow_by_level();
    datchem00260.Call("SELECT");
}

function show_textArea(l_row_master)
{
   
    
    if(l_row_master>=1)
    {
        
        //var c_self_opinion=15, c_m1_opinion=16, c_m2_opinion=17, c_m3_opinion=18;
        //alert(l_row_master);
        Area_Self_Opinion.SetDataText(idGrid_M.GetGridData(l_row_master,c_self_opinion_m));   
        Area_M1_Opinion.SetDataText(idGrid_M.GetGridData(l_row_master,c_m1_opinion_m));   
        Area_M2_Opinion.SetDataText(idGrid_M.GetGridData(l_row_master,c_m2_opinion_m));   
        Area_M3_Opinion.SetDataText(idGrid_M.GetGridData(l_row_master,c_m3_opinion_m));   
    }

    

}


function onBlurOpinion(p_level)
{
    if(p_level==0)//self
    {
        idGrid_M.SetGridText(l_row_master, c_self_opinion_m, Area_Self_Opinion.GetData());
    }
    else if(p_level==1)//m1
    {
        idGrid_M.SetGridText(l_row_master, c_m1_opinion_m, Area_M1_Opinion.GetData());
    }
    else if(p_level==2)//m2
    {
        idGrid_M.SetGridText(l_row_master, c_m2_opinion_m, Area_M2_Opinion.GetData());
    }
    else if(p_level==3)//m3
    {
        idGrid_M.SetGridText(l_row_master, c_m3_opinion_m, Area_M3_Opinion.GetData());
    }

}

function onSetEditTextArea(flag_edit)
{
        Area_Self_Opinion.SetReadOnly(flag_edit);
        Area_M1_Opinion.SetReadOnly(flag_edit);
        Area_M2_Opinion.SetReadOnly(flag_edit);
        Area_M3_Opinion.SetReadOnly(flag_edit);
}

function onTextAreaByLevel(p_level)
{
    if(p_level=="0") //for self
    {
        Area_Self_Opinion.SetReadOnly(false);
        Area_M1_Opinion.SetReadOnly(true);
        Area_M2_Opinion.SetReadOnly(true);
        Area_M3_Opinion.SetReadOnly(true);
    }
    else if(p_level=="1") //for m1
    {
        Area_Self_Opinion.SetReadOnly(true);
        Area_M1_Opinion.SetReadOnly(false);
        Area_M2_Opinion.SetReadOnly(true);
        Area_M3_Opinion.SetReadOnly(true);
    }
    else if(p_level=="2") //for m2
    {
        Area_Self_Opinion.SetReadOnly(true);
        Area_M1_Opinion.SetReadOnly(true);
        Area_M2_Opinion.SetReadOnly(false);
        Area_M3_Opinion.SetReadOnly(true);
    }
    else if(p_level=="3") //for m3
    {
        Area_Self_Opinion.SetReadOnly(true);
        Area_M1_Opinion.SetReadOnly(true);
        Area_M2_Opinion.SetReadOnly(true);
        Area_M3_Opinion.SetReadOnly(false);
    }
}

function onSave()
{
    if(check_init==1)
    {
        if(onValidate()==1)
        {
            flag_save=1;
            datchem00260_6.Call();
            
        }
    }
}

function onClearScore()
{
    if(check_init==1)
    {
       if(confirm("do you want to clear score"))
       {
            datchem00260_5.Call();
       }
        
    }
}


</script>
<body bgcolor='#F5F8FF'>

<gw:data id="datchem00260_lst" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00260_v2_lst" > 
                <input>
                    <input bind="lstEvaTimes"/> 
                </input> 
                <output>
                    <output bind="txtEvaGroup" />
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

<gw:data id="datchem00260" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="HR_sel_chem00260_v2" procedure="HR_upd_chem00260_v2" > 
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


<gw:data id="datchem00260_3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00260_3_v2" > 
                <input>
                    <input bind="lstEvaGrp"/>  
                    <input bind="lstEvaTimes" />
                    <input bind="lstLevel" />
                    <input bind="lstStatus" />
                    <input bind="txtEmp_PK" />  
                </input> 
                <output>
                    <output bind="lblInfor" />
                    <output bind="txtNumOfLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datchem00260_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28" function="HR_sel_chem00260_2_v2" procedure="HR_upd_chem00260_2_v2" > 
                <input bind="idGrid">
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="lstLevel"/>  
                    <input bind="txtEvaStatus"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data> 

<gw:data id="datchem00260_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00260_4_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="txtEmp_PK"/>    
                    <input bind="lstLevel"/>
                    <input bind="Area_Self_Opinion"/>
                    <input bind="Area_M1_Opinion"/>
                    <input bind="Area_M2_Opinion"/>
                    <input bind="Area_M3_Opinion"/>                 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00260_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00260_5_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="txtEmp_PK"/>    
                    <input bind="lstLevel"/>                 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00260_6" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00260_6_v2" > 
                <input>
                    <input bind="txtEva_Emp_PK"/>  
                    <input bind="txtEmp_PK"/>    
                    <input bind="lstLevel"/>                 
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
                                <td colspan=25 align="right">E. Period</td>
                                <td colspan=45><gw:list id="lstEvaTimes"   onchange="OnChangeEvaPeriod()"/></td>
                                <td colspan=30 rowspan=4 align="right">
                                    <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:100;height:100;border-top: 1 solid #87b0c6; border-bottom: 1 solid #87b0c6; border-left: 1 solid #87b0c6; border-right: 1 solid #87b0c6 "/>
                                </td>
                            </tr>
                            <tr style="width:100%;height:5%">
                                <td colspan=25 align="right">E. Group</td>
                                <td colspan=45><gw:list id="lstEvaGrp"  onchange="OnSearch()"/></td>
                            </tr>
                            <tr style="width:100%;height:5%">
                                <td colspan=25 align="right">Level</td>
                                <td colspan=45><gw:list id="lstLevel"   onchange="OnChangeLevel()"/></td>
                            </tr>
                            <tr style="width:100%;height:5%">
                                <td colspan=25 align="right">Status</td>
                                <td colspan=45><gw:list  id="lstStatus" value="1020" styles='width:100%' onchange="OnSearch()">
                                                <data>|1020|Not Confirm|30|Confirmed</data></gw:list>
					                </gw:list>
                                </td>
                            </tr>
                            <tr style="height:5%">
                	            <td align=center colspan=100 style="width:100%;height:5%"><b><gw:label id="lblInfor"  text="" styles="color:red;font-size:13"/></b></td>                    
                            </tr>
                           
                            <tr style="height:5%">
                	            <td align=center colspan=100 style="width:100%;height:5%">&nbsp;</td>                    
                            </tr>
                            <tr style="height:5%">
                	            <td align=center colspan=100 style="width:100%;height:5%">&nbsp;</td>                    
                            </tr>
                             <tr style="height:5%">
                                <td colspan=25><gw:icon id="ibtnSel" alt="Select All"  text="Select All"  img="in"  styles="width:100%" onclick="onSelectAll()"/></td>
                            	<td colspan=25><gw:icon id="ibtnSearch" alt="New"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>
                            	<td colspan=25><gw:icon id="ibtnConfirm" alt="Confirm"  text="Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('CONFIRM')"/></td>
                                <td colspan=25><gw:icon id="ibtnUnConfirm" alt="Un-Confirm"  text="Un-Confirm"  img="in"  styles="width:100%" onclick="OnConfirm('UN-CONFIRM')"/></td>
                            </tr>
                            <tr style="width:100%;height:59%">
                                    <td colspan=100>
                                         <gw:grid   
                                            id="idGrid_M" 
                                            header="Emp ID|Full Name|Status|Status(Lower)|Organization|Work Group|_emp_pk|_eva_master_pk|_eva_group_pk_|_pk|_act_confirm|_eva_level|_photo_pk|_eva_status|_M1_PK|_M2_PK|_M3_PK|_login_emp_pk|self_opinion|l1_opinion|l2_opinion|l3_opinion"                                       
                                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                                          
                                            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                            defaults="|||||||||||||||||||||"                     
                                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                            widths="1000|2000|1200|1200|3000|3000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            styles="width:100%; height:100%"     
                                            acceptNullDate="T"  
                                            sorting="T" oncellclick="onShowDetail()"
                                            />  
                                    </td>    
                                </tr>    
                         </table>
            </td>
            <td width=1%>&nbsp;</td>
            <td width=60%>
                <table id="Table4" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:10%; margin-left:0; margin-top:0">
	                <tr style="width:100%;height:100%">
                        <td style="width:20%" align="right"><gw:label id="lblSelf_Opinion"  text="Self Opinion" styles="color:blue;font-size:13"/></td>
                        <td style="width:80%" align="right"><gw:textarea id="Area_Self_Opinion"  text="" onblur="onBlurOpinion(0)" styles='width:100%;height:95%'/></td>
                     </tr>   
                </table>
                <table id="Table5" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:10%; margin-left:0; margin-top:0">
	                <tr style="width:100%;height:100%">
                        <td style="width:20%" align="right"><gw:label id="lblM1_Opinion"  text="Manager(L1) Opinion" styles="color:blue;font-size:13"/></td>
                        <td style="width:80%" align="right"><gw:textarea id="Area_M1_Opinion"  text="" onblur="onBlurOpinion(1)" styles='width:100%;height:95%'/></td>
                     </tr>   
                </table>
                <table id="Table_M2" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:10%; margin-left:0; margin-top:0">
	                <tr style="width:100%;height:100%">
                        <td style="width:20%" align="right"><gw:label id="lblM2_Opinion"  text="Manager(L2) Opinion" styles="color:blue;font-size:13"/></td>
                        <td style="width:80%" align="right"><gw:textarea id="Area_M2_Opinion"  text="" onblur="onBlurOpinion(2)" styles='width:100%;height:95%'/></td>
                     </tr>   
                </table>
                <table id="Table_M3" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:10%; margin-left:0; margin-top:0">
	                <tr style="width:100%;height:100%">
                        <td style="width:20%" align="right"><gw:label id="lblM3_Opinion"  text="Manager(L3) Opinion" styles="color:blue;font-size:13"/></td>
                        <td style="width:80%" align="right"><gw:textarea id="Area_M3_Opinion"  text="" onblur="onBlurOpinion(3)" styles='width:100%;height:95%'/></td>
                     </tr>   
                </table>
                <table id="Table_grid_D" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:60%; margin-left:0; margin-top:0">
                    <tr style="width:100%;height:10%">
                        <td style="width:85%;height:5%">&nbsp;</td>
                        <td style="width:5%;height:5%"><gw:icon id="ibtnSave" text="Save"  img="in"  styles="width:100%" onclick="onSave()"/></td>
                        <td style="width:5%;height:5%">&nbsp;</td>
                        <td style="width:5%;height:5%"><gw:icon id="ibtnClear" text="Clear Score"  img="in"  styles="width:100%" onclick="onClearScore()"/></td>
                     </tr>
    	            <tr id="tr_grid" style="width:100%;height:90%">    
                        <td colspan=4 style="width:100%;height:100%" >
                             <gw:grid   
                                id="idGrid" 
                                header="_Type|Element|Person MBO Result|Target 1|Target 2|Weight(A)|S.Rate(B)|S.Eva|M1.Rate(B)|M1.Eva|M2.Rate(B)|M2.Eva|M3.Rate(B)|M3.Eva|_SEQ|_Self Opinion|_M1 Opinion|_M2 Opinion|_M3 Opinion|_Eva_master_pk|_factor_pk|_eva_emp_pk|_eva_mbo_pk|_eva_level|_self_pk|_m1_pk|_m2_pk|_m3_pk|_eva_status"                                       
                                format="0|0|0|0|0|0|-0|0|-0|0|-0|0|-0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"   
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||||||||||||||||||"                     
                                editcol="0|0|0|0|0|0|1|0|1|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1200|1200|2000|2000|2000|1200|1200|800|800|800|800|800|800|800|800|1200|1200|1200|1200|1200|0|0|0|0|0|0|0|0|0|0|0|0"
                                styles="width:100%; height:100%"     
                                acceptNullDate="T" oncelldblclick="onOpenPopup()"
                                
                                sorting="T"/>  
                        </td>    
                    </tr>    
                </table>
        </td>
    </tr>
</table>
 
<gw:textbox id="txtEmp_PK" style="display:none" />
<gw:textbox id="txtPhoto_PK" style="display:none" />

<gw:textbox id="txtCompany_PK" style="display:none" />
<gw:textbox id="txtLang" style="display:none" />


<gw:textbox id="txtEva_Emp_PK" style="display:none" />
<gw:textbox id="txtNumOfLevel" style="display:none" />

<gw:textarea id="txtArea_Tmp"  text="" onchange="" styles='width:100%;display:none'/>
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtEvaStatus" style="display:none" />
 <gw:list id="lstEvalogic" style="display:none"/>
 <gw:textbox id="txtEvaGroup" style="display:none" />




</body>



