<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

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
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 3 , "select code,code_nm from vhr_hr_code where id='HR0033' order by code_nm " ) %>; 
    datCheck_View.Call();
}
function OnDataReceive(obj)
{
    if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                idBtnNew.style.display = "none";
                idBtnSave.style.display = "none";
                idBtnDelete.style.display = "none";
            }
        
            datTax_Detail.Call("SELECT");
            
       }
}
function OnAdd()
{
     var ctrl=idGrid.GetGridControl();
        idGrid.AddRow();
		idGrid.SetGridText(idGrid.rows-1,3,lst_tax_kind.value);
		ctrl.TopRow = ctrl.rows;
}
function OnSave()
{
    datTax_Detail.Call();
}
function OnDel()
{
    if(confirm("Do you want to delete?\nBạn đã chắc chắn xóa?"))
        idGrid.DeleteRow();
}
function onSearch()
{
    datTax_Detail.Call("SELECT");
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
<gw:data id="datTax_Detail" onreceive="" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5" function="hr_sel_10030004_tax" procedure="hr_upd_10030004_tax"> 
                <input bind="idGrid" >
                   <input bind="lst_tax_kind" /> 
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    <tr style="height:5%;border:1">	
		    <td  align=right style="width:40%;border:1" >Tax Kind</td>
		    <td  align=right style="width:10%;border:1" ><gw:list  id="lst_tax_kind" onchange="onSearch()" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0033' ORDER BY B.CODE")%></data></gw:list></td>
		    
		     <td align=right style="width:31%;border:1" ></td>
		    <td align=right style="width:3%;border:1" > <gw:imgBtn img="new" id="idBtnNew"   alt="Add"  onclick="OnAdd()"/></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn img="delete" id="idBtnDelete"  alt="Delete" onclick="OnDel()" /></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnSave" img="save" alt="Save" onclick="OnSave()" /></td>
        </tr>	
		<tr style="height:95%">
			<td colspan=7  id="master" width="100%">
				<gw:grid
					id="idGrid"
					header="Tax ID|Amount|Rate(%)|Tax Kind|Remark|_pk"
					format="0|1|1|0|0|0"
					aligns="1|0|0|1|0|0"
					defaults="|||||"
					editcol="1|1|1|1|1|0"
					widths="1500|2000|1500|2000|5000|0"
					styles="width:100%;height:100%"
					sorting="F"
					onafteredit=""
					oncellclick = ""
					acceptNullDate="T"
					param="0,1,2,3,4,5" oncelldblclick = ""/>
			</td>
		</tr>	
	</table>
<gw:textbox id="txtpk" styles="display:none"/>
    <gw:textbox id="txtfrom" styles="display:none"/>
    <gw:textbox id="txtto" styles="display:none"/>
    <gw:textbox id="txtflag" styles="display:none"/>
    <gw:textbox id="txtresult" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</body>
</html>
