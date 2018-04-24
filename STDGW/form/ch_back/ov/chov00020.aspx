<!-- #include file="../../../system/lib/form.inc" -->
<%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<title>Card Visitor Entry</title>
</head>

<script>

var isPopUp ="N";
var update_flage =0;
function BodyInit()
{ 
    isPopUp = "<%=Request.querystring("popup_yn")%>";  

	 OnReset()
	 txtComID.SetEnable(false);
	 txtComNM.SetEnable(false);
	 idBtnSelect2.style.display='none'
	  <%=ESysLib.SetGridColumnComboFormat("grdVisitor",6,"select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm") %>
	 if(isPopUp =="Y" )
    {
        idinfor.style.display='none'
        idbutton.style.display='none'
    }
}

function OnSearch()
{
    
        datSearchVisitor.Call('SELECT');

}
function OnDataReceive(obj)
{
    if(obj.id=="datSearchVisitor")
    {
        lblRecord.text=grdVisitor.rows-1 + " record(s)";
    }else if(obj.id=="datVisitor" && update_flage == 1)
    {
        txtSName.text = txtVstNm.text;
        datSearchVisitor.Call('SELECT')
    }
}

function OnSave()
{
    if(txtVstNm.text =="" || txtID.text=="" )
    {
        alert("Please insert Visitor name Personal ID. \n (Vui lòng nhập tên khách và số CMND hoặc số hộ chiếu) ! ")

    }else
    {   
        update_flage = 1;
        datVisitor.Call()
    }
}
function OnDelete()
{
    if(txtVsPK.text!="")
    {
        if(confirm("Are you sure you want to delete this Visitor! \n(Bạn thật sự muốn xoá thông tin Khách này!)"))
        {
            datVisitor.StatusDelete();
            update_flage = 1;
            datVisitor.Call()
        }
     }
}

/*----------------------------------------------*/
function OnSelect(oGrid)
{
   var arr_data = new Array();
   var control = oGrid.GetGridControl();
   var rows = control.Rows;
	
	if (control.SelectedRows >0)
	{
		//for (i=0; i<control.SelectedRows ; i++)
		//{
			var row = control.SelectedRow(0);
			
			
             for(var j=0;j<oGrid.cols;j++)
             {
                 arr_data[arr_data.length]= oGrid.GetGridData(row,j);
             }
             
		//}
		window.returnValue =  arr_data;
		window.close();
    }
	
	  else
	  {
	    alert("Vui lòng chọn một visitor trên lưới!");
	  }
}
function OnClickVisitor()
{
    txtVsPK.text = grdVisitor.GetGridData(grdVisitor.row,0)
    update_flage = 0
    datVisitor.Call('SELECT')
}
function OnReset()
{
    datVisitor.StatusInsert();
}
function OnShowVisCompanyPopup()
{
	
		var fpath = System.RootURL + "/form/ch/ov/chov00030.aspx?showType=" + "popup"
		var obj = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes'); 
		if (obj!=null)
        {
            txtComPK.text = obj[0]
            txtComID.text = obj[1]
            txtComNM.text = obj[2]
        }
		
	
}

</script>
<body>
    <!------------------------------------>
<gw:data id="datVisitor" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="HR.SP_SEL_VIS_MASTER" procedure="HR.sp_upd_vis_master"> 
                <inout>
                    <inout bind="txtVsPK" /> 
                    <inout bind="txtVstNm"/>
                    <inout bind="txtID"/>
                    <inout bind="txtVstTel"/>
                    <inout bind="lstSEX"/>
                    <inout bind="txtComPK"/>
                    <inout bind="txtComID"/>
                    <inout bind="txtComNM"/>
                    <inout bind="txtContactTo"/>
                    <inout bind="txtPostion"/>
                    <inout bind="txtDept"/>
                    <inout bind="txtDescription"/>
               </inout> 
            </dso> 
        </xml> 
</gw:data>
   <!---------------------------------------------------------->
    <gw:data id="datSearchVisitor" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr.SP_SEL_VIS_List" > 
                <input bind="grdVisitor">
                    <input bind="txtSCompany" /> 
                    <input bind="txtSName" /> 
                </input> 
                <output bind="grdVisitor"/>
            </dso> 
        </xml> 
    </gw:data>
 <table  cellpadding="1" cellspacing="1" border=1 style="width:100%;height:100%;">
        <tr style="height:5%" id="idbutton">
            <td style="width:80%" ></td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnNew" alt="New" img="New"  onclick="OnReset()" />
            </td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnDel" alt="Delete" img="Delete"  onclick="OnDelete()" />
            </td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnSave" alt="Save" img="Save"  onclick="OnSave()" /> 
            </td>
                                        
        </tr>
       <tr style="height:25%" id='idinfor'>
            <td colspan='5' align=center>
                    <table width="100%"  style="height:90%" border=0 cellpadding="0" cellspacing="0">
                        <tr style="height:10%">
                            <td style="width:15%" colspan="3" align=right > Name <i> (Họ tên)</i></i> </td>
                            <td style="width:30%" colspan="6">
                                <gw:textbox id="txtVsPK"  text="" 	 styles='width:100%;display:none'    />
                                <gw:textbox id="txtVstNm"  text="" 	 styles='width:100%;' csstype="mandatory"   />
                            </td>
                             <td style="width:15%" colspan="3" align=right > ID<i> (CMND/Hộ chiếu)</i></td>
                            <td style="width:20%" colspan="4">
                                <gw:textbox id="txtID"  text=""  styles='width:100%;' csstype="mandatory"   />
                            </td>
                            <td style="width:10%" colspan="2" align=right > Tel<i>(ĐT)</i></td>
                            <td style="width:20%" colspan="4">
                                <gw:textbox id="txtVstTel"  text=""  maxlen = "10"	 styles='width:100%;'    />
                            </td>
                        </tr>
                        <tr style="height:10% ">
                            <td style="width:15%" colspan="3" align=right > Sex<i> (Giới tính)</i></td>
                            <td style="width:10%" colspan="2">
                                <gw:list  id="lstSEX"  styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>
                                </data>
                                </gw:list>
                            </td>
                            <td style="width:10%" colspan="2" align=right >
                            <a title="Click here to show list of visitor company" 
															onclick="OnShowVisCompanyPopup('MOD')" 
															href="#tips" >Company<i> (Cty)</i>													</a>
                            </td>
                            <td style="width:20%" colspan="2">
                                <gw:textbox id="txtComPK"  text=""  styles='width:100%;display:none'    />
                                <gw:textbox id="txtComID"  text=""  styles='width:100%;'    />
                            </td>
                            <td style="width:35%" colspan="7">
                                <gw:textbox id="txtComNM"  text=""  styles='width:100%;'    />
                            </td>
                            <td style="width:10%" colspan="2" align=right >Vehicle<i> (Số xe)</i></td>
                            <td style="width:20%" colspan="4">
                                <gw:textbox id="txtVehicle"  text="" 	 styles='width:100%;'    />
                            </td>
                        </tr>
                        <tr style="height:10% ">
                            <td style="width:15%" colspan="3" align=right > Contact To<i> (Liên hệ với)</i> </td>
                            <td style="width:30%" colspan="6">
                                <gw:textbox id="txtContactTo"  text="" 	 styles='width:100%;'    />
                            </td>
                             <td style="width:15%" colspan="3" align=right > Position<i> (Chức vụ)</i></td>
                            <td style="width:20%" colspan="4">
                                <gw:textbox id="txtPostion"  text=""  styles='width:100%;'    />
                            </td>
                            <td style="width:10%" colspan="2" align=right > Dept<i> (Phòng ban)</i> </td>
                            <td style="width:20%" colspan="4">
                                <gw:textbox id="txtDept"  text="" 	 styles='width:100%;'    />
                            </td>
                        </tr>
                        <tr>
                            <td style="width:15%" colspan="3" align=right >Desc<i> (Ghi chú)</i> </td>
                            <td colspan="18">
                                <gw:textbox id="txtDescription"  text="" 	 styles='width:100%;'    />
                            </td>
                        </tr>
                    </table>
              </td>
           
       </tr>
       <tr style="height:70%">
             <td colspan='5' align=center>
                    <table width="100%"  style="height:100%" border=0 cellpadding="0" cellspacing="0">
                        <tr style="height:10%">
                            <td style="width:10%"  align=right > Company<i> (Tên Cty)</i> </td>
                            <td style="width:20%">
                                <gw:textbox id="txtSCompany"  onenterkey="OnSearch()" text="" 	 styles='width:100%;'   />
                            </td>
                            <td style="width:15%" align=right > Name/ID<i> (Tên/CMND)</td>
                            <td style="width:25%">
                                <gw:textbox id="txtSName" onenterkey="OnSearch()"  text="" 	 styles='width:100%;'    />
                            </td>
                            <td style="width:10%" align="right">
                                <gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                            </td>
                            <td style="width:5%" >
                                <gw:imgBtn id="idBtnSearch" alt="search" img="search"  onclick="OnSearch()" />
                            </td>
                            <td style="width:5%" >
                                <gw:imgBtn id="idBtnSelect2" alt="select" img="Select"  onclick="OnSelect(grdVisitor)" />
                            </td>
                            
                        </tr>
                       
                        <tr style="height:90%">
                             <td  colspan="7">
                                 <gw:grid id='grdVisitor'
                                    header='_Visit_PK|_Com_PK|Mã C.ty|Tên Cty|CMND/Passport|Họ Tên|Giớ Tính|Điện Thoại|Số Xe|L.hệ Với|Chức Vụ|Phòng Ban|_Purpose'
                                    format='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                    defaults='||||||||||||'
                                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                                    widths='0|0|1500|2500|1200|2500|800|1000|1000|1500|1500|1500|0'
                                    sorting='T'
                                    styles='width:100%; height:100%'
                                    oncelldblclick="OnSelect(grdVisitor)"
                                    oncellclick="OnClickVisitor()"
                                    />
                              </td>
                        </tr>
                         
                    </table>
             </td>
       </tr>
      
</table>
<gw:textbox id="txtStatus" styles="display:none" />
</body>
</html>
