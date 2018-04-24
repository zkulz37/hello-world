<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Accounting Period</title>
</head>
<script>
var dt1, dt2,flag_tmp;
var v_language = "<%=Session("SESSION_LANG")%>";
var company_pk=0;
var company_nm=1, partner_pk = 2, partner_id= 3, partner_nm = 4;
var pl_pk = 5, pl_id = 6, pl_nm = 7;
var w_month=8;
var times=9;
var from=10;
var to=11;
var close_yn=12;
var close_dt=13;
var pk=14;
var _id=15, _wh_pk = 16, _wh_name=17, _wh_acc_code = 19, _exp_acc_code = 22, _exp_wh_pk = 24, _exp_wh_name = 25;

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
		
	iduser_pk.text = "<%=session("USER_PK")%>";
	<%=ESysLib.SetGridColumnComboFormat("idGrid",15,"select TRIM(CODE) code, A.code_nm FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'ACBG0205'" )%>;
		
	idGrid.GetGridControl().FrozenCols = 9 ;
	
   // menu_id.text=System.Menu.GetMenuID();
    //idBtnOpen.SetEnable(0);
   // idBtnClose.SetEnable(0);
	//datCheck_View.Call();
	onSearch();
}
function OnSelectPartner()
{
    var f_path    = System.RootURL + '/form/60/01/60010140_multi_partner.aspx?com_pk=' + lst_company.value+'&AP=Y';  
    var object  = System.OpenModal( f_path, 800, 550,'resizable:yes;status:yes');
	if ( object != null )
		{
		     var l_month = IDYear.value;
		    for(var i =0 ; i< object.length; i++)
		    {
		        idGrid.AddRow();
		        idGrid.SetGridText(idGrid.rows-1,company_pk,lst_company.value);
		       idGrid.SetGridText(idGrid.rows-1,company_nm,lst_company.GetText());
		        
		        idGrid.SetGridText(idGrid.rows-1,partner_pk,object[i][0]);
		        idGrid.SetGridText(idGrid.rows-1,partner_id,object[i][1]);
		        idGrid.SetGridText(idGrid.rows-1,partner_nm,object[i][2]);
		        
		        idGrid.SetGridText(idGrid.rows-1,w_month,(l_month.substr(4,2)+'/'+l_month.substr(0,4)));
		        idGrid.SetGridText(idGrid.rows-1,_id,lst_ID.value);
		    }
		    
		}		
}
function OnSelectPopup()
{   var l_col = event.col;
    
    if(l_col==pl_id||l_col==pl_nm)
    {
         if(idGrid.GetGridData(event.row,close_yn)=='Y')
        {
        alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
        }else
        {
            var fpath   = System.RootURL + "/form/60/09/60090010_CtrItem2.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lst_company.value + '&dsqlid=sp_sel_pl_popup_plpk&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                   idGrid.SetGridText(idGrid.selrow, pl_pk, object[2]);     // PK
                   idGrid.SetGridText(idGrid.selrow, pl_id, object[0]);     // PL Code
                   idGrid.SetGridText(idGrid.selrow, pl_nm, object[1]);     // PL Name
                }
            }
        }
    }else if(l_col==_wh_name)
    {
         if(idGrid.GetGridData(event.row,close_yn)=='Y')
        {
        alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
        }else
        {
            var fpath = System.RootURL + "/form/60/09/60090010_GetWareHouse.aspx?company_pk=" + lst_company.value ;
            var o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
            if (o != null)
            {
                if(o[0] != 0)
                {
                    idGrid.SetGridText(idGrid.selrow, _wh_pk, o[0]);
                    idGrid.SetGridText(idGrid.selrow, _wh_name, o[2]);
                }
             
            }
        }

    }else if(l_col==_wh_acc_code)
	{
		var path = System.RootURL + "/form/60/03/60030010_popup_ifrs.aspx?comm_nm=&comm_code=&comm_nm2=" + "" + "&val1=Y" + '' + "&val2=Y" + '' + "&val3=" + lst_company.value+'' + "&dsqlid=ac_sel_60170010_acct_open";
	 
		var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
		
		if(object!=null)
		{
			if(object[3] != 0)
			{
				idGrid.SetGridText( idGrid.selrow , 18, object[3]); 
				idGrid.SetGridText( idGrid.selrow , _wh_acc_code, object[0]); 
				idGrid.SetGridText( idGrid.selrow , 20, object[1]); 				
			}
		}	
	}else if(l_col==_exp_acc_code)
	{
		var path = System.RootURL + "/form/60/03/60030010_popup_ifrs.aspx?comm_nm=&comm_code=631&comm_nm2=" + "" + "&val1=Y" + '' + "&val2=Y" + '' + "&val3=" + lst_company.value+'' + "&dsqlid=ac_sel_60080050_acct";
	 
		var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
		
		if(object!=null)
		{
			if(object[3] != 0)
			{
				idGrid.SetGridText( idGrid.selrow , 21, object[3]); 
				idGrid.SetGridText( idGrid.selrow , _exp_acc_code, object[0]); 
				idGrid.SetGridText( idGrid.selrow , 23, object[1]); 				
			}
		}	
	}else if(l_col==_exp_wh_name)
    {
         if(idGrid.GetGridData(event.row,close_yn)=='Y')
        {
        alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
        }else
        {
            var fpath = System.RootURL + "/form/60/09/60090010_GetWareHouse.aspx?company_pk=" + lst_company.value ;
            var o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
            if (o != null)
            {
                if(o[0] != 0)
                {
                    idGrid.SetGridText(idGrid.selrow, _exp_wh_pk, o[0]);
                    idGrid.SetGridText(idGrid.selrow, _exp_wh_name, o[2]);
                }
             
            }
        }
    }    
	/*
	else if(l_col==partner_id||l_col==partner_nm)
    {
         if(idGrid.GetGridData(event.row,close_yn)=='Y')
        {
        alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
        }else
        {
            var fpath = System.RootURL + '/form/60/09/60090010_vendor_popup.aspx?com_pk=' + lst_company.value+'&AP=Y';
            var o = System.OpenModal( fpath , 800, 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
            if (o != null)
            {
                if(o[0] != 0)
                {
                    idGrid.SetGridText(idGrid.selrow, partner_id, o[1]);
                    idGrid.SetGridText(idGrid.selrow, partner_nm, o[2]);
                    idGrid.SetGridText(idGrid.selrow, partner_pk, o[0]);
                }
             
            }
        }
    }
	*/
}
function OnCopy()
{
    //idGrid.SetAllRowStatusModify()
    datPeriodCopy.Call();
}
function OnSave()
{
    datUpdatePeriod.Call();
}
function OnDelete()
{
    idGrid.DeleteRow();
    datUpdatePeriod.Call();
}
function OnDataReceive(obj)
{
      
       if (obj.id=="datMonthOpen")
       {
            if(txtresult.text=='0')
            {
                alert("Open Successful."+"\n"+"Open thành công.")
                datUpdatePeriod.Call("SELECT");
             }   
             else   
                alert("Open unSuccessful."+"\n"+"Open không thành công.")
                    
       }
       
       if (obj.id=="datMonthClose")
       {
            if(txtresult.text=='0')
            {
                alert("Close Successful."+"\n"+"Close thành công.")
                datUpdatePeriod.Call("SELECT");
             }   
             else   
                alert("Open unSuccessful."+"\n"+"Open không thành công.")
                    
       }
       if(obj.id=="datPeriodCopy")
       {
            if(txtresult.text ==-1)
            {
                 alert("Copy error!"+"\n"+"Sao chép không thành công!")
            }else
            {
                alert("Copy finished."+"\n"+"Sao chép hoàn tất!")
            }
            datUpdatePeriod.Call("SELECT");
       }
	   if( obj.id=="datUpdatePeriod")
	   {
			if(idGrid.rows > 1)
			{
				idGrid.SetCellBgColor(1, 6,idGrid.rows-1, 6, 0x2EFEF7); // PL Code
				idGrid.SetCellBgColor(1, 22,idGrid.rows-1, 22, 0x2EFEF7); // EXP Account code
				idGrid.SetCellBgColor(1, 19,idGrid.rows-1, 19, 0x2EFEF7); // WH Account code
			}
		}
       
}    

function onSearch()
{   
    datUpdatePeriod.Call("SELECT");
}
function on_click()
{
   if(idGrid.GetGridData(event.row,close_yn)=='Y')
    {
        idBtnOpen.SetEnable(1);
        idBtnClose.SetEnable(0);
    }   
    else
    {
        idBtnOpen.SetEnable(0);
        idBtnClose.SetEnable(1);
    }
    dt1=idGrid.GetGridData(event.row,from)
    dt2=idGrid.GetGridData(event.row,to)
    
}
function on_afteredit()
{
    if(idGrid.GetGridData(event.row,close_yn)=='Y')
    {
        if(event.col==from||event.col==to)
        {
            alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
            idGrid.SetGridText(event.row,from,dt1);
            idGrid.SetGridText(event.row,to,dt2);
        }
    }
}
//----------------------------------------------------------------------
function OnOpen_Close(n)
{
    var ctrl=idGrid.GetGridControl();
    if(ctrl.SelectedRows<1)
        return;
    if(ctrl.SelectedRows>1)
    {
        alert("Only one row accept.\nBạn chỉ được phép chọn 1 dòng.")
        return;
    }
    flag_tmp=n;
    if(confirm("Do you want to "+n+"?"+"\nBạn có muốn "+n+"?"))
    {
        txtpk.text=idGrid.GetGridData(ctrl.SelectedRow(0),pk);
        if(n=='OPEN')
        {
            datMonthOpen.Call();
        }
        else
        {
            datMonthClose.Call();
        }
        
    }
}
//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function onChange_Company()
{
	datUpdatePeriod.Call("SELECT");
}
//-------------------------------------------------------
</script>
<body>
     <!-------------------data control----------------------->
<gw:data id="datMonthClose" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="tac_pro_60010140_month_close" > 
                <input>
                    <input bind="txtpk" /> 
                </input> 
                <output>
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
 <!-------------------data copy----------------------->
<gw:data id="datPeriodCopy" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="tac_pro_60010140_copy" > 
                <input>
                    <input bind="lst_company" />
                    <input bind="IDYear" />
					<input bind="lst_ID" />
                </input> 
                <output>
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
 <!-------------------data control----------------------->
<gw:data id="datMonthOpen" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="tac_pro_60010140_month_open" > 
                <input>
                    <input bind="txtpk" /> 
                </input> 
                <output>
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
   <!-------------------data control----------------------->
<gw:data id="datUpdatePeriod" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,21,24" function="ac_SEL_60010140" procedure="ac_upd_60010140"> 
                <input bind="idGrid" >
                    <input bind="lst_ID" />
                    <input bind="IDYear" />
					<input bind="lst_company" />
					<input bind="txtPartner" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>   
 <!-------------------data control----------------------->
  
   
	<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	    <tr style="height:10%;border:1">	
	        <td  align="right" style="width:5%;border:1" >Company</td>
	        <td  align="right" style="width:20%;border:1" ><gw:list  id="lst_company" onchange="onChange_Company()" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%></data></gw:list></td>
							
			<td  align="right" style="width:5%;border:1" >Partner</td>
	        <td  align="right" style="width:15%;border:1" > 
	        <gw:textbox id="txtPartner" styles='width:100%' onenterkey="onSearch()"/>	</td>		
            
		    
		    <td  align="right" style="width:5%;border:1" >Year</td>
		    <td  align="right" style="width:10%;border:1" ><gw:datebox id="IDYear" onchange="onSearch()"  maxlen = "10" styles='width:100%'lang="<%=Session("Lang")%>" type=month /></td>
			
		    <td  align="right" style="width:30%;border:1" ><gw:list  id="lst_ID" onchange="onSearch()" maxlen = "100" styles='width:100%' >
                            <data><%= ESysLib.SetListDataSQL("select TRIM(CODE) code, A.code_nm   FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'ACBG0205' ")%></data>
                            </gw:list></td>
		     
		    <td  align="right" style="width:2%;border:1" >&nbsp;</td>
		    <td align="right" style="width:2%;border:1" ><gw:imgBtn id="idBtnCopy" img="copy" text="Copy" onclick="OnCopy()" /></td>
            <td align="right" style="width:2%;border:1" ><gw:imgBtn id="idBtnNew" img="new" text="New" onclick="OnSelectPartner()" /></td>
		    <td  align="right" style="width:2%;border:1" ><gw:imgBtn id="idBtnSave" img="save" text="Save" onclick="OnSave()" /></td>
		    <td  align="right" style="width:2%;border:1" ><gw:imgBtn id="idBtnDel" img="delete" text="Delete" onclick="OnDelete()" /></td>
		    <td  align="right" style="width:2%;border:1" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="OnOpen_Close('OPEN')" /></td>
		    <td align="right" style="width:2%;border:1" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="OnOpen_Close('CLOSE')" /></td>
        </tr>
        <tr style="height:90%">
            <td colspan=14 style="width:100%">
	        <gw:grid
		        id="idGrid"
		        header="_Company_pk|_Company Name|_partner_pk|Customer Id|Customer Nm|_pl_pk|PL CD|PL Nm|Month|_Times|From|To|Close Y/N|Close DT|_pk|_PERIOD ID|_WH_pk|Ware House|_WH_ACC_PK|WH ACC. Code|WH ACC. Name|_EXP_ACC_PK|EXP. ACC. Code|EXP. ACC. Name|_WH_PK_EXP|EXP. WH Name|-"
		        format="0|0|0|0|0|0|0|0|0|0|4|4|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0"
		        aligns="0|0|0|0|0|0|0|0|1|1|1|1|1|1|0|0|0|0|0|1|0|0|1|0|0|0|0"
		        defaults="||||||||||||||||||||||||||"
		        editcol="0|0|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
		        widths="0|2000|0|1500|2000|1000|2000|1500|1200|800|1200|1200|800|800|1200|1500|0|2000|0|1500|2500|0|1500|2500|0|1800|300"
		        styles="width:100%;height:100%"
		        sorting="T"
		        onafteredit="on_afteredit()"
		        oncelldblclick = "OnSelectPopup()"
		        oncellclick = "on_click()"
		        acceptNullDate="T"
		        param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" />
            </td>
        </tr>	
	</table>


<gw:textbox id="txtpk" styles="display:none"/>
<gw:textbox id="txtwork_mon" styles="display:none"/>
    <gw:textbox id="txtfrom" styles="display:none"/>
    <gw:textbox id="txtto" styles="display:none"/>
    <gw:textbox id="txtflag" styles="display:none"/>
    <gw:textbox id="txtresult" styles="display:none"/>
	<gw:textbox id="iduser_pk" styles="display:none"/>
	<gw:textbox id="txtHr_level" styles="display:none"/>
	<gw:textbox id="txtKind_of_sal" styles="display:none"/>
	<gw:textbox id="txtPeriod_id" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
</body>
</html>
