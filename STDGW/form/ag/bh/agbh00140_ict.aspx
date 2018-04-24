<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtUser_PK.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 6 , "select code,CODE_NM from vhr_hr_code where id='HR0056' order by num_1") %>;   
   
   idGrid.GetGridControl().FrozenCols =2;
   idGrid.GetGridControl().ScrollTrack=true;

   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
     datUser_info.Call(); 
   else  
  ChangeLocation();
    
}
function OnAdd()
{
    var ctrl=idGrid.GetGridControl();
    idGrid.AddRow();
	ctrl.TopRow = ctrl.rows;
	idGrid.SetGridText(ctrl.rows-1,5,lstCompany.value)
		
}
function OnSave()
{
    if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
        datWork_Group_Entry.Call();
}
function OnDel()
{
    if(confirm("Do you want to delete?\nBạn đã chắc chắn xóa?"))
        idGrid.DeleteRow();
}
function onSearch()
{
    datWork_Group_Entry.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datUser_info")
        datWork_Group_Entry.Call("SELECT");
    else if (obj.id=="datWork_Group_Entry")
        auto_resize_column(idGrid,0,idGrid.GetGridControl().cols-1,0);  
}
function ChangeLocation()
{
    datWork_Group_Entry.Call("SELECT");
}  

//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
    obj.GetGridControl().AutoSize(col1,col2,false,0);  
}        
</script>
<body>
<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_company_user"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstCompany" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->
<gw:data id="datWork_Group_Entry" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="HR_sel_80020012_wg_ict" procedure="HR_upd_80020012_wg_ict">
                <input bind="idGrid"> 
                <input bind="lstCompany"/>
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    
	    <tr style="height:5%;border:1">	
    	   <td  style="width:5%;font-size:larger;color:Red;white-space:nowrap;border:1">Company</td>
    	    <td align=left style="width:70%;border:1" ><gw:list  id="lstCompany"  maxlen = "100" styles='width:70%'onchange="ChangeLocation()" >
                            <data>
                                <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                            </data>
                        </gw:list></td>
		    <td align=right style="width:3%;border:1" > <gw:imgBtn img="new" id="idBtnNew"   alt="Add"  onclick="OnAdd()"/></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnSave" img="save" alt="Save" onclick="OnSave()" /></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn img="delete" id="idBtnDelete"  alt="Delete" onclick="OnDel()" /></td>
        </tr>	
		<tr style="height:95%">
			<td colspan=7  id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="WorkGroup ID|Work Group Name|Work Group Fname|Address|Address Eng|Remark|Seq|_pk|_p_company_pk|Meal Q.ty|Unit price|Environment Allow|Ha Tinh Allow|Salary Type"
					format="0|1|0|0|0|0|0|0|0|-0|-0|-0|-0|2"
					aligns="1|2|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="|||||||||||||"
					editcol="1|1|1|1|1|1|0|0|1|1|1|1|1|1"
					widths="2000|2000|2000|3000|3000|2000|500|0|0|1000|1000|1500|1500|1500"
					styles="width:100%;height:100%"
					sorting="F"
					onafteredit=""
					oncellclick = ""
					acceptNullDate="T"
					 oncelldblclick = ""/>
			</td>
		</tr>	
	</table>
<gw:textbox id="txtpk" styles="display:none"/>
    <gw:textbox id="txtfrom" styles="display:none"/>
    <gw:textbox id="txtto" styles="display:none"/>
    <gw:textbox id="txtflag" styles="display:none"/>
    <gw:textbox id="txtresult" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtUser_PK" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</body>
</html>
