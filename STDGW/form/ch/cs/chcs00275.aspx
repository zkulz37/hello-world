<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var dt1, dt2,flag_tmp
var v_language = "<%=Session("SESSION_LANG")%>";
var company_pk=0
var company_nm=1
var w_month=2
var times=3
var from=4
var to=5
var close_yn=6
var close_dt=7
var confirm_yn=8
var pk=9
var id=10
var kind_of_sal=11


function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
		
	iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";	
	menu_id.text=System.Menu.GetMenuID();
    idBtnOpen.SetEnable(0);
    idBtnClose.SetEnable(0);
	datCheck_View.Call();
	
    
	
}
function OnCheck()
{
    //idGrid.SetAllRowStatusModify()
    //datMonth_close.Call();
}
function OnSave()
{
    //datMonth_close.Call();
}

function OnDataReceive(obj)
{
	/*
    var flag=0;
       
	   if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                idBtnCheck.style.display = "none";
                idBtnSave.style.display = "none";
                idBtnOpen.style.display = "none";
                idBtnClose.style.display = "none";
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
            {
                datCompany_info.Call(); 
            }
	        else
		        datMonth_close.Call("SELECT");
            
       }
	   if (obj.id=="datCompany_info")
       {			
			datPeriod_info.Call();
	   }
	   if (obj.id=="datPeriod_info")
       {			
			datMonth_close.Call("SELECT");
	   }
       if (obj.id=="datOpenClose")
       {
            if(txtresult.text=='0')
            {
                alert(flag_tmp+" Successful."+"\n"+flag_tmp+" thành công.")
                datMonth_close.Call("SELECT");
             }   
             else   
                alert(flag_tmp+" unSuccessful."+"\n"+flag_tmp+" không thành công.")
                    
       }
      /**/
       
}    

function onSearch()
{   
    //datMonth_close.Call("SELECT");
}
function on_click()
{
   */*if(idGrid.GetGridData(event.row,close_yn)=='Y')
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
    /**/
}
function on_afteredit()
{
    /*if(idGrid.GetGridData(event.row,close_yn)=='Y')
    {
        if(event.col==from||event.col==to)
        {
            alert("You can't change when the month is closed.\nBạn không thể thay đổi khi dữ liệu đã đóng.")
            idGrid.SetGridText(event.row,from,dt1);
            idGrid.SetGridText(event.row,to,dt2);
        }
    }/**/
}
//----------------------------------------------------------------------
function OnOpen_Close(n)
{
    /*var ctrl=idGrid.GetGridControl();
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
        if(n=='OPEN')
            txtflag.text='N'
        else
            txtflag.text='Y'
			
        txtwork_mon.text=idGrid.GetGridData(ctrl.SelectedRow(0),w_month);       
        txtfrom.text=idGrid.GetGridData(ctrl.SelectedRow(0),from);
        txtto.text=idGrid.GetGridData(ctrl.SelectedRow(0),to);
        txtpk.text=idGrid.GetGridData(ctrl.SelectedRow(0),pk);
        txtKind_of_sal.text=idGrid.GetGridData(ctrl.SelectedRow(0),kind_of_sal);
		txtPeriod_id.text=idGrid.GetGridData(ctrl.SelectedRow(0),id);
        datOpenClose.Call();
    }/**/
}
//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
 // if(font_size!=0)
 //       obj.GetGridControl().FontSize =font_size;   
 // obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function onChange_Company()
{
	//alert(lst_company.value);
	//datPeriod_info.Call();
}
</script>
<body>
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<table style="width:100%;height:6%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	    <!--<tr style="height:100%;border:1">	
	        <td colspan=2 align=right style="width:10%;border:1" >Company</td>
	        <td colspan=5 align=right style="width:25%;border:1" ><gw:list  id="lst_company" value="" onchange="onChange_Company()" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>|ALL|Select All</data></gw:list></td>
							
			<td colspan=1 align=right style="width:5%;border:1" >&nbsp;</td>
	        			
            
		    
		    <td colspan=1 align=right style="width:5%;border:1" >Year</td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:datebox id="IDYear" onchange="onSearch()"  maxlen = "10" styles='width:100%'lang="<%=Session("Lang")%>" type=year /></td>
			
		    <td colspan=6 align=right style="width:30%;border:1" ></td>
		     
		    <td colspan=1 align=right style="width:5%;border:1" >&nbsp;</td>
		    <td colspan=1 align=right style="width:5%;border:1" ><gw:icon id="idBtnSearch1" img="in" text="Search" onclick="OnSearch1('')" /></td>
		    <td colspan=1 align=right style="width:5%;border:1" ><gw:icon id="idBtnPost1" img="in" text="Post" onclick="OnPost1('')" /></td>
		    <td colspan=1 align=right style="width:5%;border:1" ><gw:icon id="idBtnClose1" img="in" text="Close" onclick="OnClose1('')" /></td>
		    <td colspan=1 align=right style="width:5%;border:1" ></td>
        </tr>	-->
	
		<tr id="tr1" style="border:0;width:100%;height:1%" valign="center" >
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
			<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
		</tr> 
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=20 style="border:0;"></td>
			<td colspan=3 style="border:0;">Year</td>
		    <td colspan=2 align=center style="border:0;"><gw:datebox id="IDYear" onchange="onSearch()"  maxlen = "10" styles='width:100%'lang="<%=Session("Lang")%>" type=year /></td>
			<td colspan=4 style="border:0;" ><gw:icon id="idBtnSearch1" img="in" text="Search" onclick="OnSearch1('')" /></td>
		    <td colspan=4 style="border:0;" ><gw:icon id="idBtnPost1" img="in" text="Post" onclick="OnPost1('')" /></td>
		    <td colspan=4 style="border:0;" ><gw:icon id="idBtnClose1" img="in" text="Close" onclick="OnClose1('')" /></td>
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=5 align=center  style="border:0;">국세청 제출 보고서</td>
			<td colspan=20 style="border:0;"></td>
		    <td colspan=5 align=center style="border:0;"></td>
			<td colspan=5 align=center style="border:0;" ></td>
		    <td colspan=5 style="border:0;" ></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">Seq</td>
			<td colspan=20 align=center  style="border:0;">Item</td>
		    <td colspan=5 align=center  align=center style="border:0;">Item Code</td>
			<td colspan=5 align=center  style="border:0;" >Unit</td>
		    <td colspan=5 style="border:0;" >Person / Amount</td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">1</td>
			<td colspan=20 style="border:0;">Total labourers:</td>
		    <td colspan=5 align=center style="border:0;">[21]</td>
			<td colspan=5 align=center  style="border:0;" >Người/Person</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt01"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">1.1</td>
			<td colspan=20 style="border:0;">In which : Resident individuals with labour contracts</td>
		    <td colspan=5 align=center style="border:0;">[22]</td>
			<td colspan=5 align=center  style="border:0;" >Người/Person</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt02"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">2</td>
			<td colspan=20 style="border:0;">Total individuals subject to withholding tax [23]=[24]+[25]</td>
		    <td colspan=5 align=center style="border:0;">[23]</td>
			<td colspan=5 align=center  style="border:0;" >Người/Person</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt03"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">2.1</td>
			<td colspan=20 style="border:0;">Resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[24]</td>
			<td colspan=5 align=center  style="border:0;" >Người/Person</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt04"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">2.2</td>
			<td colspan=20 style="border:0;">Non-resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[25]</td>
			<td colspan=5 align=center  style="border:0;" >Người/Person</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt05"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">3</td>
			<td colspan=20 style="border:0;">Taxable income paid for individuals [26]=[27]+[28]</td>
		    <td colspan=5 align=center style="border:0;">[26]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt06"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">3.1</td>
			<td colspan=20 style="border:0;">Resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[27]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt07"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">3.2</td>
			<td colspan=20 style="border:0;">Non-resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[28]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt08"/></td>		    
		</tr>
		
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">4</td>
			<td colspan=20 style="border:0;">Taxable income paid for individuals subject to withholding tax</td>
		    <td colspan=5 align=center style="border:0;">[29]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt09"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">4.1</td>
			<td colspan=20 style="border:0;">Resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[30]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt10"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">4.2</td>
			<td colspan=20 style="border:0;">Non-resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[31]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt11"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">5</td>
			<td colspan=20 style="border:0;">Total PIT withheld [32]=[33]+[34]</td>
		    <td colspan=5 align=center style="border:0;">[32]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt12"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">5.1</td>
			<td colspan=20 style="border:0;">Resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[33]</td>
			<td colspan=5  align=center style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt13"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5  align=center style="border:0;">5.2</td>
			<td colspan=20 style="border:0;">Non-resident individuals</td>
		    <td colspan=5 align=center style="border:0;">[34]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt14"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">6</td>
			<td colspan=20 style="border:0;">Total taxable income from life insurance, from other optional insurance of insurance company not established in Vietnam for labourers</td>
		    <td colspan=5 align=center style="border:0;">[35]</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt13"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">7</td>
			<td colspan=20 style="border:0;">Total PIT withheld on life insurance, from other optional insurance of insurance company not established in Vietnam for labourers</td>
		    <td colspan=5 align=center style="border:0;">[36]</td>
			<td colspan=5 align=center style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt14"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=5 align=center  style="border:0;">SBV 제출 보고서</td>
			<td colspan=20 style="border:0;"></td>
		    <td colspan=5 align=center style="border:0;"></td>
			<td colspan=5 align=center style="border:0;" ></td>
		    <td colspan=5 style="border:0;" ></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5  align=center style="border:0;">1</td>
			<td colspan=20 style="border:0;">Total salary(Except BB, CC)</td>
		    <td colspan=5 align=center style="border:0;">AA</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt15"/></td>		    
		</tr>
		
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">2</td>
			<td colspan=20 style="border:0;">Bonus</td>
		    <td colspan=5 align=center style="border:0;">BB</td>
			<td colspan=5 align=center  style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt16"/></td>		    
		</tr>
		<tr  style="border:0;width:100%;height:4%" valign="center" >
			<td colspan=3 align=center  style="border:0;"></td>
			<td colspan=5 align=center  style="border:0;">3</td>
			<td colspan=20 style="border:0;">Other incomes</td>
		    <td colspan=5 align=center style="border:0;">CC</td>
			<td colspan=5 align=center style="border:0;" >VND</td>
		    <td colspan=5 style="border:0;" ><gw:textbox id="txt17"/></td>		    
		</tr>
		
		
		
		
		
		
	</table>
	<!--<table id="tbl" style="width:100%;height:94%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="_Company_pk|Company Name|Month|Times|From|To|Close Y/N|Close DT|Confirm Y/N|_pk|PERIOD ID|_k_of_Salary"
					format="0|0|0|0|4|4|0|4|0|0|0|0"
					aligns="0|0|0|1|1|1|0|1|0|0|0|0"
					defaults="|||||||||||"
					editcol="0|0|0|0|1|1|0|0|0|0|0|0"
					widths="1000|4000|1000|1500|2000|2000|1500|1500|1500|500|500|500"
					styles="width:100%;height:100%"
					sorting="T"
					onafteredit="on_afteredit()"
					oncellclick = "on_click()"
					acceptNullDate="T"
					param="0,1,2,3,4,5,6,7,8,9,10,11" oncelldblclick = ""/>
			</td>
		</tr>	
	</table>-->
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
