﻿<!-- #include file="../../../system/lib/form.inc"  -->
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
var value_before;
var flag=0;
var settle_status=0;
var flag_request=0;

function BodyInit()
{
    
    if (v_language!="ENG")
        System.Translate(document);  
    
     idGrid1.GetGridControl().ColFormat(10) = "(###,###,###.##)";
     idGrid1.GetGridControl().ColFormat(13) = "(###,###,###.##)";
     idGrid2.GetGridControl().ColFormat(5) = "(###,###,###.##)";
     idGrid2.GetGridControl().ColFormat(7) = "(###,###,###.##)";
     idGrid3.GetGridControl().ColFormat(4) = "(###,###,###.##)";
     idGrid3.GetGridControl().ColFormat(6) = "(###,###,###.##)";
     idGrid4.GetGridControl().ColFormat(7) = "(###,###,###.##)";
     idGrid5.GetGridControl().ColFormat(4) = "(###,###,###.##)";
        
    <%=ESysLib.SetGridColumnComboFormat( "idGrid2" , 4 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0063' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "idGrid2" , 8 , "select a.code,a.char_1 from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "idGrid3" , 2 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0062' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "idGrid3" , 7 , "select a.code,a.char_1 from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "idGrid4" , 8 , "select a.code,a.char_1 from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "idGrid5" , 5 , "select a.code,a.char_1 from vhr_hr_code a where a.id='HR0040' ORDER BY A.seq") %>; 
    txtemp_pk.text="<%=Session("EMPLOYEE_PK")%>";
    txtAppcant_id.SetEnable(0);
    txtAppcant_nm.SetEnable(0);
    txtAppr_id.SetEnable(0);
    txtAppr_nm.SetEnable(0);
    enable_button(0);  
    txtAppNo.text="<%=Request.querystring("p_temp_pk")%>";
   if (txtAppNo.text!="")
        datSettle_exp.Call("SELECT");
   else
        datGet_empid.Call();  
      
    
}
function enable_button(n)
{
    txtApplied.SetEnable(n);
    txtactual.SetEnable(n); 
    txtApplied1.SetEnable(n);
        txtAct1.SetEnable(n);
    txtApplied2.SetEnable(n);
        txtAct2.SetEnable(n);  
        txtAct3.SetEnable(n);
        txtAct4.SetEnable(n);
    
        ibtnNew2.SetEnable(n);
        ibtnSave2.SetEnable(n);
        ibtnDel2.SetEnable(n);
        
        ibtnNew3.SetEnable(n);
        ibtnSave3.SetEnable(n);
        ibtnDel3.SetEnable(n);
        
        ibtnNew4.SetEnable(n);
        ibtnSave4.SetEnable(n);
        ibtnDel4.SetEnable(n);
        
        ibtnNew5.SetEnable(n);
        ibtnSave5.SetEnable(n);
        ibtnDel5.SetEnable(n);    
}
//------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//--------------------------------
function OnShowEmp(objid)
{
    switch (objid)
    {
        case 1:
        {
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
            var obj  = System.OpenModal(  fpath , 800 ,500, 'resizable:yes;status:yes;');
	        if (obj!=null)
	        {
                txtemp_pk.text=obj[0];
                txtAppcant_id.text=obj[1];
                txtAppcant_nm.text=obj[2];
                
                txtApprover_PK.text=obj[15];
                txtAppr_id.text=obj[16];
                txtAppr_nm.text=obj[17];
                
	            
	        }
	        /*else
	        {
	            if(lblApplicant_Level.text!="")//manager hoặc ga manager
	            {
	                txtemp_pk.text="";
                    txtAppcant_id.text="";
                    txtAppcant_nm.text="";
                
                    txtApprover_PK.text="";
                    txtAppr_id.text="";
                    txtAppr_nm.text="";
	            }
	        }*/
	        break;
	    }
	    case 2:
	    {
	        var strcom
            var fpath = System.RootURL + "/form/ch/fd/chfd00020_search_emp.aspx";
            var obj  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes');
            if (obj!=null)
	        {
                txtApprover_PK.text=obj[0];
                txtAppr_id.text=obj[1];
                txtAppr_nm.text=obj[2];
	        }
            break;
        }
    }    
}
function onPage_active()
{
    
    if(txtSettle_pk.text!="")
    {
        switch (tabMain.GetCurrentPageNo())
            {
                case 0://trans
                        dat_Settle_trans.Call("SELECT");
                        break;
                case 1://OTHER
                        dat_settle_other.Call("SELECT");
                        break;  
                case 2://lodging
                    dat_settle_lodging.Call("SELECT");
                    break; 
                case 3://meal
                    dat_settle_meal.Call("SELECT");
                    break;                           
            }
     }       
}
function OnSearch()
{
    flag_request=0;
    datSettle_exp.Call("SELECT");
}
function OnDataReceive(obj)
{
    if(obj.id=="datSettle_exp")
    {
        lbrecord.text=idGrid1.rows-1 +" rec(s)";
        auto_resize_column(idGrid1,0,idGrid1.cols-1,0);   
    }    
    if(obj.id=="datGet_total")   
    {
        if(flag==0)
        {
           
            switch (tabMain.GetCurrentPageNo())
            {
                case 0://trans
                        dat_Settle_trans.Call("SELECT");
                        break;
                case 1://OTHER
                        dat_settle_other.Call("SELECT");
                        break;        
                case 2://lodging
                        dat_settle_lodging.Call("SELECT");
                        break; 
                case 3://meal
                        dat_settle_meal.Call("SELECT");
                        break;                 
            }
        }
        else if(settle_status=='05'&&flag_request==1)
            datSettle_exp.Call("SELECT");
                
        
    }
    if(obj.id=="dat_Settle_trans")
    {
        var t1=0;
        var t2=0;
        for(var i=1;i<idGrid2.rows;i++)
        {
            t1+=Number(idGrid2.GetGridData(i,5));
            t2+=Number(idGrid2.GetGridData(i,7));
        }
        txtApplied1.text=String(t1);
        txtAct1.text=String(t2);
        flag=1;
        datGet_total.Call();
        
    }
    if(obj.id=="dat_settle_other")
    {
        var t1=0;
        var t2=0;
        for(var i=1;i<idGrid3.rows;i++)
        {
            t1+=Number(idGrid3.GetGridData(i,4));
            t2+=Number(idGrid3.GetGridData(i,6));
        }
        txtApplied2.text=String(t1);
        txtAct2.text=String(t2);
        flag=1;
        datGet_total.Call();
        
    }
    if(obj.id=="dat_settle_lodging")
    {
        var t1=0;
        for(var i=1;i<idGrid4.rows;i++)
             t1+=Number(idGrid4.GetGridData(i,7));
        txtAct3.text=String(t1);
        flag=1;
        
        datGet_total.Call();
        
     }
    if(obj.id=="dat_settle_meal")
    {
        var t1=0;
        for(var i=1;i<idGrid5.rows;i++)
             t1+=Number(idGrid5.GetGridData(i,4));
        txtAct4.text=String(t1);
        flag=1;
        datGet_total.Call();
        
    }  
    if(obj.id=="datGet_empid")
    {
        if(txtAppcant_id.text!="")
            datSettle_exp.Call("SELECT");
    }
    if(obj.id=="datGet_approval")
    {
        alert(txtResult.text);
        ibtnNew2.SetEnable(0);
        ibtnSave2.SetEnable(0);
        ibtnDel2.SetEnable(0);
        
        ibtnNew3.SetEnable(0);
        ibtnSave3.SetEnable(0);
        ibtnDel3.SetEnable(0);
        
        ibtnNew4.SetEnable(0);
        ibtnSave4.SetEnable(0);
        ibtnDel4.SetEnable(0);
        
        ibtnNew5.SetEnable(0);
        ibtnSave5.SetEnable(0);
        ibtnDel5.SetEnable(0);    
        datSettle_exp.Call("SELECT");
    }

    
    
     
}
function on_click()
{
    var ctrl=idGrid1.GetGridControl()
    if(ctrl.rows>1)
    {
        
        settle_status=idGrid1.GetGridData(ctrl.row,14);
       // alert(settle_status);
        if(settle_status=='01'||settle_status=='05')//save,request info
        {
            ibtnConfirm.SetEnable(1);    
            ibtnSave.SetEnable(1);  
            ibtnDel.SetEnable(1);  
            ibtnDel.SetEnable(1);
            
            ibtnNew2.SetEnable(1);
            ibtnSave2.SetEnable(1);
            ibtnDel2.SetEnable(1);
            
            ibtnNew3.SetEnable(1);
            ibtnSave3.SetEnable(1);
            ibtnDel3.SetEnable(1);
            
            ibtnNew4.SetEnable(1);
            ibtnSave4.SetEnable(1);
            ibtnDel4.SetEnable(1);
            
            ibtnNew5.SetEnable(1);
            ibtnSave5.SetEnable(1);
            ibtnDel5.SetEnable(1);
        }
        else if(settle_status=='04') //reject 
        {
            ibtnDel.SetEnable(1);
            ibtnSave.SetEnable(1);  
            
            ibtnSearch.SetEnable(0);
            
            ibtnConfirm.SetEnable(0);
            
            ibtnNew2.SetEnable(0);
            ibtnSave2.SetEnable(0);
            ibtnDel2.SetEnable(0);
            
            ibtnNew3.SetEnable(0);
            ibtnSave3.SetEnable(0);
            ibtnDel3.SetEnable(0);
            
            ibtnNew4.SetEnable(0);
            ibtnSave4.SetEnable(0);
            ibtnDel4.SetEnable(0);
            
            ibtnNew5.SetEnable(0);
            ibtnSave5.SetEnable(0);
            ibtnDel5.SetEnable(0);
        }
        else
        {
            ibtnConfirm.SetEnable(0);
            ibtnSave.SetEnable(0);  
            ibtnDel.SetEnable(0);
            ibtnNew2.SetEnable(0);
            ibtnSave2.SetEnable(0);
            ibtnDel2.SetEnable(0);
            
            ibtnNew3.SetEnable(0);
            ibtnSave3.SetEnable(0);
            ibtnDel3.SetEnable(0);
            
            ibtnNew4.SetEnable(0);
            ibtnSave4.SetEnable(0);
            ibtnDel4.SetEnable(0);
            
            ibtnNew5.SetEnable(0);
            ibtnSave5.SetEnable(0);
            ibtnDel5.SetEnable(0);
        }
        txtBiz_pk.text=idGrid1.GetGridData(ctrl.row,0);
        txtSettle_pk.text=idGrid1.GetGridData(ctrl.row,12);
        flag=0;
        flag_request=0;
        datGet_total.Call();
    }    
    
}
function on_save_before(n)
{
    
    switch(n)
    {   
        case 1: 
            value_before=idGrid2.GetGridData(event.row,event.col);
            if(idGrid2.GetGridData(event.row,11)!="")
                if(event.col<=4)
                {
                    alert("You only can add new.\nBạn chỉ có thể thêm mới.");
                }
            break;    
        case 2: 
            value_before=idGrid3.GetGridData(event.row,event.col);
            if(idGrid3.GetGridData(event.row,9)!="")
                if(event.col<=3)
                {
                    alert("You only can add new.\nBạn chỉ có thể thêm mới.");
                }
            break;        
    }       
}

function OnAddNew(n)
{
    switch(n)
    {
        case 2://trans
            idGrid2.AddRow();
            idGrid2.SetGridText(idGrid2.rows-1,1,txtSettle_pk.text);
            idGrid2.GetGridControl().TopRow = idGrid2.rows;
            break;
        case 3://other 
            idGrid3.AddRow();
            idGrid3.SetGridText(idGrid3.rows-1,1,txtSettle_pk.text);
            idGrid3.GetGridControl().TopRow = idGrid3.rows;
            break;    
        case 4://lodging 
            idGrid4.AddRow();
            idGrid4.SetGridText(idGrid4.rows-1,1,txtSettle_pk.text);
            idGrid4.GetGridControl().TopRow = idGrid4.rows;
            break;    
        case 5://meal 
            idGrid5.AddRow();
            idGrid5.SetGridText(idGrid5.rows-1,1,txtSettle_pk.text);
            idGrid5.GetGridControl().TopRow = idGrid5.rows;
            break;        
    }
}
function OnSave(n)
{
    switch(n)
    {
        case 1://main
            if(confirm("Are you sure to save?\nBạn đã chắc chắn save?"))
            {
                datSettle_exp.Call();
            }    
            break;
        case 2://trans
            if(confirm("Are you sure to save?\nBạn đã chắc chắn save?"))
            {
                flag_request=1;
                dat_Settle_trans.Call();
            }    
            break;
        case 3://other
            if(confirm("Are you sure to save?\nBạn đã chắc chắn save?"))
            {
                flag_request=1;
                dat_settle_other.Call();
            }    
            break;    
        case 4://lodging
            if(confirm("Are you sure to save?\nBạn đã chắc chắn save?"))
            {
                flag_request=1;
                dat_settle_lodging.Call();
            }    
            break;     
        case 5://meal
            if(confirm("Are you sure to save?\nBạn đã chắc chắn save?"))
            {
                flag_request=1;
                dat_settle_meal.Call();
            }    
            break;         
    }
}
function OnDelete(n)
{
    switch(n)
    {
        case 1://main
            if(confirm("Are you sure to delete?\nBạn đã chắc chắn xóa?"))
                idGrid1.DeleteRow();
            break;
        case 2://trans
            if(confirm("Are you sure to delete?\nBạn đã chắc chắn xóa?"))
                idGrid2.DeleteRow();
            break;
        case 3://trans
            if(confirm("Are you sure to delete?\nBạn đã chắc chắn xóa?"))
                idGrid3.DeleteRow();
            break;    
        case 4://trans
            if(confirm("Are you sure to delete?\nBạn đã chắc chắn xóa?"))
                idGrid4.DeleteRow();
            break;  
        case 5://trans
            if(confirm("Are you sure to delete?\nBạn đã chắc chắn xóa?"))
                idGrid5.DeleteRow();
            break;     
               
    }
}
function OnApprove()
{
    var ctrl=idGrid1.GetGridControl()
    
    if(ctrl.SelectedRows==1)
    {
        var settle_status=idGrid1.GetGridData(ctrl.row,14);
        if(settle_status=='01'||settle_status=='05')
        {
            if(confirm("You won't modify application if you get approval, do you want to do?\nBạn không thể sửa thêm nếu bạn đã xác nhận, Bạn muốn xác nhận?"))
                datGet_approval.Call();
        }    
    }
    else
        alert("Select only one application and get approval please.\nBạn vui lòng chọn duy nhất 1 đơn yêu cầu để xác nhận.")
    
    
}

</script>
<body >
<gw:data id="datGet_empid" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>
                    <input bind="txtemp_pk" />
                </input> 
                <output>
                    <output bind="txtAppcant_id" />
                    <output bind="txtAppcant_nm" />
                    <output bind="txtAppr_id" />
                    <output bind="txtAppr_nm" />
                    <output bind="txt_manager_kind" />
                    <output bind="txtDept_tmp" />
                    <output bind="lblApplicant_Level" />
                    <output bind="txtManager_pk" />
                    <output bind="txtCompany_pk" />
                    <output bind="txtTmp" />
                    <output bind="txtTmp" />
                    
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datSettle_exp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_settle_exp" procedure="hr.sp_upd_settle_exp" parameter="0"> 
                <input>
                    <input bind="p_from" />
                    <input bind="p_to" />
                    <input bind="lstType" />
                    <input bind="txtAppcant_id" />
                    <input bind="txtAppcant_nm" />
                    <input bind="s_from" />
                    <input bind="s_to" />
                    <input bind="lstB_Type" />
                    <input bind="lstB_Object" />
                    <input bind="txtAppNo" />
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_total" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_total" > 
                <input>
                    <input bind="txtBiz_pk" />
                </input> 
                <output>
                    <output bind="txtApplied" />
                    <output bind="txtactual" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Settle_trans" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_settle_trans" procedure="hr.sp_upd_settle_trans" parameter="0,1,2,3,4,7,8,9,10,11"> 
                <input>
                    <input bind="txtSettle_pk" />
                </input>
                <output  bind="idGrid2" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_settle_other" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_settle_other" procedure="hr.sp_upd_settle_other" parameter="0,1,2,3,6,7,8,9"> 
                <input>
                    <input bind="txtSettle_pk" />
                </input>
                <output  bind="idGrid3" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_settle_lodging" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_settle_lodging" procedure="hr.sp_upd_settle_lodging" parameter="0,1,2,3,4,5,6,7,8,9"> 
                <input>
                    <input bind="txtSettle_pk" />
                </input>
                <output  bind="idGrid4" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_settle_meal" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_settle_meal" procedure="hr.sp_upd_settle_meal" parameter="0,1,2,3,4,5,6"> 
                <input>
                    <input bind="txtSettle_pk" />
                </input>
                <output  bind="idGrid5" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_approval" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_sett_approval" > 
                <input>
                    <input bind="txtSettle_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
    
<table id="Settle" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:50%;">
        <tr style="width:100%;height:40%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:10%" valign="center" >
                        <td colspan=3 width="6%" style="border:0;" align="right" ><b>Login ID</b></td>
                        <td colspan=3 width="6%" style="border:0;" align="center" ><gw:label id="lblLoginID"  text="<%=session("USER_ID")%>" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                        <td colspan=6 width="12%" style="border:0;" align="center" ><gw:label id="lblApplicant_Level"  text="" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                        <td colspan=4 width="8%" style="border:0;" align="right" >Applicant</td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><gw:textbox id="txtAppcant_id"  text="" maxlen = "100"  styles="color:blue;width:100%;font-weight:bold" onenterkey="OnSearch()"  /></td>
                        <td colspan=10 width="20%" style="border:0;" align="right" ><gw:textbox id="txtAppcant_nm"  text="" maxlen = "100" styles="color:red;width:100%;font-weight: bold" onenterkey="OnSearch()" /></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><a title="Click here to change Approver" onclick="OnShowEmp(2)" href="#tips" >Approver</a></td>
                        <td colspan=4 width="8%" style="border:0;" align="right" ><gw:textbox id="txtAppr_id"  text="" maxlen = "100"  styles="color:blue;width:100%;font-weight:bold" onenterkey=""  /></td>
                        <td colspan=10 width="20%" style="border:0;" align="right" ><gw:textbox id="txtAppr_nm"  text="" maxlen = "100" styles="color:red;width:100%;font-weight: bold" onenterkey="" /></td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:10%" valign="center" >
                        <td colspan=6 width="12%" style="border:0;" align="right" ><b>Application No</b></td>
                        <td colspan=6 width="12%" style="border:0;" align="right" ><gw:textbox id="txtAppNo"  text="" maxlen = "100"  styles="color:blue;width:100%;font-weight:bold" onenterkey="OnSearch()"  /></td>
                        <td colspan=3 width="6%" style="border:0;" align="right" ><b>Period</b></td>
                        <td colspan=5 width="10%" style="border:0;" align="right" ><gw:datebox id="p_from" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept /></td>
                        <td width="2%" style="border:0;" align="right" ><b>~</b></td>
                        <td colspan=5 width="10%" style="border:0;" align="right" ><gw:datebox id="p_to" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td colspan=7 width="14%" style="border:0;" align="right" ><b>Type</b></td>
                        <td colspan=8 width="16%" style="border:0;" align="right" ><gw:list  id="lstType" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0058' and code='02' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                        
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                        <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave(1)"/></td>
                        <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnDel"   alt="Delete"  onclick="OnDelete(1)"/></td>
                        <td width="2%" style="border:0;" align="right" ><gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport(1)"/></td>
                        <td width="6%" style="border:0;" align="right" ><gw:icon id="ibtnConfirm" img="in" text="Approval Request" onclick="OnApprove()" /></td>
                    </tr>
                     <tr style="border:0;width:100%;height:10%" valign="center" >
                        <td colspan=4  style="border:0;" align="left" ><gw:label id="lbrecord"  maxlen = "100" styles="color:red;width:90%;font-weight: bold" /></td>
                        <td colspan=5  style="border:0;" align="right" ><b>Submit date</b></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:datebox id="s_from" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept /></td>
                        <td width="2%" style="border:0;" align="right" ><b>~</b></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:datebox id="s_to" styles="width:100%" lang="<%=Session("Lang")%>" nullaccept/></td>
                        <td colspan=3  style="border:0;" align="right" ><b>B_Type</b></td>
                        <td colspan=6  style="border:0;" align="right" ><gw:list  id="lstB_Type" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0060' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list >
                        </td>
                        <td colspan=4  style="border:0;" align="right" ><b>Biz Object</b></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:list  id="lstB_Object" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0059' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list >
                        </td>
                        <td colspan=3  style="border:0;" align="right" ><b>App/Act&nbsp;</b></td>
                        <td colspan=4  style="border:0;" align="right" ><gw:textbox id="txtApplied" type="number"  format="#,###,###,###.##R" maxlen = "100" styles="color:red;width:100%;font-weight: bold"  /></td>
                        <td colspan=5  style="border:0;" align="right" ><gw:textbox id="txtactual"  type="number"  format="#,###,###,###.##R" maxlen = "100" styles="color:red;width:100%;font-weight: bold"  /></td>
                    </tr>
                    <tr style="border:0;width:100%;height:90%" valign="center" >
                        <td colspan=50 style="width:100%;height:90%;"> 
                             <gw:grid   
                                id="idGrid1"  
                                header="_Biz_PK|Application No|Sumit date|Applicant|Emp ID|Settle Status|From|To|Biz Type|Biz Object|Applied Amt|_App Status|_Settle_pk|Actual Amt|_settle_status_code|Approve Level"   
                                format="0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||||||"    
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1500|1500|2000|2500|1000|1500|1200|1200|1500|1500|1500|1500|0|1500|0|0"  
                                styles="width:100%; height:100%"   
                                sorting="T" onclick="on_click()" /> 
                        </td>
                    </tr>
                </table> 
            </td>
        </tr>  
</table>
<gw:tab id="tabMain"  border=1 style="width:100%;height:50%;" onpageactivate="onPage_active()"  > 
    <table name="Trans Expenses" id="Table2" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">        
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:100%" border=1 cellpadding="0" cellspacing="0">        
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" style="border:0;" align="left" ><b>Applied Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtApplied1" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=5 width="10%" style="border:0;" align="left" ><b>Actual Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtAct1" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=12 width="24%" style="border:0;" align="right" >&nbsp;</td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="new" id="ibtnNew2"   alt="Add New"  onclick="OnAddNew(2)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="save" id="ibtnSave2"    alt="Save"  onclick="OnSave(2)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnDel2"   alt="Delete"  onclick="OnDelete(2)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                    </tr>
                    <tr style="border:0;width:100%;height:95%" valign="center" >
                        <td colspan=50 style="width:100%;height:95%;"> 
                             <gw:grid   
                                id="idGrid2"  
                                header="_PK|_SETTLE_PK|Departure|Arrival|Transportation|Applied Amt|_Currency|Actual Amt|_Currency|Reason|Remark|_Biz_trans_pk"   
                                format="0|0|0|0|0|1|0|1|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||"    
                                editcol="0|0|1|1|1|0|0|1|1|1|1|0"  
                                widths="0|0|2000|2000|1500|1500|1000|1500|1000|3000|2000|0"  
                                styles="width:100%; height:100%"   
                                sorting="T" 
				                onKeyPressEdit    = "on_save_before(1)"
				                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="Other Expenses" id="Table3" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">        
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table4" style="height:100%" border=1 cellpadding="0" cellspacing="0">        
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=5 width="10%" style="border:0;" align="left" ><b>Applied Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtApplied2" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=5 width="10%" style="border:0;" align="left" ><b>Actual Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtAct2" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=12 width="24%" style="border:0;" align="right" >&nbsp;</td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="new" id="ibtnNew3"   alt="Add New"  onclick="OnAddNew(3)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="save" id="ibtnSave3"    alt="Save"  onclick="OnSave(3)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnDel3"   alt="Delete"  onclick="OnDelete(3)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                    </tr>
                    <tr style="border:0;width:100%;height:95%" valign="center" >
                        <td colspan=50 style="width:100%;height:95%;"> 
                             <gw:grid   
                                id="idGrid3"  
                                header="_PK|_SETTLE_PK|Type|Description|Amount|_Currency|Actual Amt|_Currency|Reason|_biz_other_pk"   
                                format="0|0|0|0|1|0|1|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0"    
                                defaults="|||||||"    
                                editcol="0|0|1|1|0|0|1|1|1|0"  
                                widths="0|0|1500|2500|1500|1500|1500|1500|3000|0"  
                                styles="width:100%; height:100%"  
                                onKeyPressEdit    = "on_save_before(2)" 
                                sorting="T" /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="Lodging" id="Table5" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">        
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table6" style="height:100%" border=1 cellpadding="0" cellspacing="0">        
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=10 width="20%" style="border:0;" align="left" >&nbsp;</td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><b>Total Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtAct3" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=12 width="24%" style="border:0;" align="right" >&nbsp;</td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="new" id="ibtnNew4"   alt="Add New"  onclick="OnAddNew(4)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="save" id="ibtnSave4"    alt="Save"  onclick="OnSave(4)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnDel4"   alt="Delete"  onclick="OnDelete(4)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                    </tr>
                    <tr style="border:0;width:100%;height:95%" valign="center" >
                        <td colspan=50 style="width:100%;height:95%;"> 
                             <gw:grid   
                                id="idGrid4"  
                                header="_PK|_SETTLE_PK|From|To|Country|City|Name|Amount|_Currency|Remark"   
                                format="0|0|4|4|0|0|0|1|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||"    
                                editcol="0|0|1|1|1|1|1|1|1|1"  
                                widths="0|0|2500|1500|1500|1500|1500|3000|1500|2500"  
                                styles="width:100%; height:100%"   
                                sorting="T" acceptNullDate /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    <table name="Meal" id="Table7" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">        
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table8" style="height:100%" border=1 cellpadding="0" cellspacing="0">        
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan=10 width="20%" style="border:0;" align="left" >&nbsp;</td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><b>Total Amount</b></td>
                        <td colspan=10 width="20%" style="border:0;" align="left" ><gw:textbox id="txtAct4" type="number" text="" format="#,###,###,###.##" maxlen = "100" styles="color:red;width:80%;font-weight: bold"  /></td>
                        <td colspan=12 width="24%" style="border:0;" align="right" >&nbsp;</td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="new" id="ibtnNew5"   alt="Add New"  onclick="OnAddNew(5)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="save" id="ibtnSave5"    alt="Save"  onclick="OnSave(5)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" ><gw:imgBtn img="delete" id="ibtnDel5"   alt="Delete"  onclick="OnDelete(5)"/></td>
                        <td colspan=2 width="4%" style="border:0;" align="right" >&nbsp;</td>
                    </tr>
                    <tr style="border:0;width:100%;height:95%" valign="center" >
                        <td colspan=50 style="width:100%;height:95%;"> 
                             <gw:grid   
                                id="idGrid5"  
                                header="_PK|_SETTLE_PK|From|To|Amount|_Currency|Remark"   
                                format="0|0|4|4|1|0|0"  
                                aligns="0|0|0|0|0|0|0"    
                                defaults="||||||"    
                                editcol="0|0|1|1|1|1|1"  
                                widths="0|0|1500|1500|1500|1200|5000"  
                                styles="width:100%; height:100%"   
                                sorting="T" acceptNullDate/> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
 </gw:tab>   
<!----------------------------------->
<gw:textbox id="txtBiz_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtSettle_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtemp_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtDept_tmp"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txt_manager_kind"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtApprover_PK"  text="" maxlen = "100"  styles="display:none"/>

<gw:textbox id="txtResult"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtManager_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtCompany_pk"  text="" maxlen = "100"  styles="display:none"/>
<gw:textbox id="txtTmp"  text="" maxlen = "100"  styles="display:none"/>


</body>
</html>


