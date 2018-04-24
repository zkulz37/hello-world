<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
/*grdAppointment*/
 var v_approve_status = 10,
     v_card_type = 11,
     v_vis_status = 15
/*grdAppointment*/

/*action =1:insert,2:update,3:delete*/
var saction=0;
var isex=4
var icard_type=15
var isPopUp; //hien thi luoi 
var svis_app_pk=""; //hien thi chi tiet 
function BodyInit()
{   
    
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0121' order by code")%>";
    grdAppointment.SetComboFormat(icard_type,t1);
	var t2 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code")%>";
    grdAppointment.SetComboFormat(isex,t2);
	txtCardType.SetEnable(false);
	txtVstComp.SetEnable(false);
	txtVstNm.SetEnable(false);
	//Reset
	datAppointment.StatusInsert();
	isPopUp = "<%=Request.querystring("popup_yn")%>";  
    txtGA_Approval.text= "<%=Request.querystring("p_ga_approval")%>";  
    svis_app_pk= "<%=Request.querystring("p_vis_app_pk")%>";  
    if (svis_app_pk!="") //hien thi chi tiet 
        IsShowDetail()
    if (isPopUp=="") //hien thi luoi danh sach 
        isPopUp='N'
    if  (txtGA_Approval.text=="")
        txtGA_Approval.text='ALL'
    if (isPopUp=='Y')
    {
        idinfor.style.display='none'
        idbutton.style.display='none'
    }
    
}
//---------------------
function IsShowDetail()
{
    idSearch1.style.display="none"
	idSearch2.style.display="none"
    idBtnNew.style.display="none"
    idBtnDel.style.display="none"
    idBtnSave.style.display="none"
    idReport.style.display="none"
    txtAppointPK.text=svis_app_pk;
    datAppointment.Call("SELECT");
}
//----------------------
function IsPopup()
{
    idSearch1.style.display="none"
	idSearch2.style.display="none"
    idBtnNew.style.display="none"
    idBtnDel.style.display="none"
    idBtnSave.style.display="none"
    idReport.style.display="none"
    
}
/*--------------------------------------------------------*/
function OnSearch(obj)
{
    if(obj==1) /*List of register*/
    {
        datSearchApp.Call('SELECT');
    }
}
/*--------------------------------------------------------*/
function OnClickRegister()
{
    txtAppointPK.text = grdAppointment.GetGridData(grdAppointment.row,0)
    datAppointment.Call('SELECT')
}
function OnReset()
{
   // datAppointment.StatusInsert();
    if (arr_obj != null)
	{
	    txtVstPK.text = arr_obj[0];
	    txtVstCompPk.text = arr_obj[1];
	    txtVstComp.text = arr_obj[3];
	    txtVstID.text = arr_obj[4];
	    txtVstNm.text = arr_obj[5];			
	    lstSEX.value    = arr_obj[6];
    	
	    txtTel.text     = arr_obj[7];			
	    txtVehicle.text = arr_obj[8];
	    txtContTo.text = arr_obj[9];
	    txtPosition.text = arr_obj[10];
	    txtDept.text = arr_obj[11];
	    txtVstTime.text="";
	    txtCardType.text="";
	    txtGAStatus.text="";
	    txtTeamStatus.text="";
    }
    
}
function OnSave(pos)
{
    if(txtVstPK.text =="")
    {
        alert("Please select Visitor! \n (Vui lòng chọn thông tin khách)!")
    }else if(txtContTo.text =="" && txtDept.text=="" && txtPosition.text =="")
    {
        alert("Please input contact infomation! \n (Vui lòng nhập thông tin của ngừơi cần liên hệ!)!")
    }else
    {
        if (txtAppointPK.text=="") //insert
            saction=1;
        else 
            saction=2;
            datAppointment.Call();
     }
}
		  
//--------------------------------------------------------

function OnDelete(obj)
{
    if(obj==1) //delete master
    {
         if(txtAppointPK.text!="")
            {
                if(confirm("Are you sure you want to delete this Visitor! \n(Bạn thật sự muốn xoá thông tin này!)"))
                {
                    datAppointment.StatusDelete();
                    saction=3;
                    datAppointment.Call()
                }
             }
    }
}

/*--------------------------------------------------------*/
function OnDataReceive(obj)
{
    if(obj.id=="datSearchApp")
    {
        lblRecord.text=grdAppointment.rows-1 + " record(s)";
        grdAppointment.GetGridControl().AutoSize(0,grdAppointment.cols-1,false,0);
        GridColor()
    }
    else if(obj.id=="datAppointment")
    {
          if (saction==1)
            if (txtAppointPK.text!="")  
                alert("Inserting successful \n Đăng ký thành công");
            else
                alert("Inserting fail \n Đăng ký không thành công");
          else if (saction==2)
                alert("Updating successful \n Chỉnh sửa thành công");
          else if (saction==3)
                txtAppointPK.text="";
          if (saction!=0)
          {
                saction=0;
                datSearchApp.Call("SELECT");
          }
    }
    else if(obj.id =="data_CheckExist")
    {
        if(txtRegistPKTemp.text !="")
        {
            alert("Already Register! \n(Khách này đã đăng ký rồi!)")
            txtAppointPK.text = txtRegistPKTemp.text
            datAppointment.Call('SELECT')
        }else
        {
            OnReset()
        }
    }
    else if(obj.id =="datVisReplicate")
    {
        if(txtResult.text!='0')
        {
            alert("Replicate successful!\nTạo bảng copy thành công, vui lòng chỉnh sửa thông tin, ngày, giờ hẹn hoàn chỉnh");
            txtAppointPK.text=txtResult.text;
            datAppointment.Call("SELECT");
        }
        else
            alert("Replicate Error!!!")
    }
    
}
function GridColor()
{
    for(var i =1 ; i<grdAppointment.rows; i++)
    {
        var temp = grdAppointment.GetGridData(i,v_approve_status)
        var temp1 = grdAppointment.GetGridData(i,v_vis_status)
        if(temp == "02")
        {
            if(temp1 =="I"||temp1 =="O" )//da cap the
            {
                 grdAppointment.SetCellBgColor( i, 0 , i, grdAppointment.cols-1 , 0xCCFFFF ); //vàng
            }else
            {
                grdAppointment.SetCellBgColor( i, 0 , i, grdAppointment.cols-1 , 0x99FF66 );//xanh0x66FF00
            }
            
        }else if(temp == "03")
        {
              grdAppointment.SetCellBgColor( i, 0 , i, grdAppointment.cols-1 , 0x0099FF );
        }
       
    }
}
/*popup*/
function OnPopup(obj)
{
    if(obj==1)/*tìm kiếm visitor*/
    {
        var fpath = System.RootURL + "/form/ch/ov/chov00020.aspx?popup_yn=N";
		arr_obj = System.OpenModal( fpath , 800 , 600 , 'resizable:yes;status:yes'); 

		if (arr_obj != null)
		{
			txtVstPK.text = arr_obj[0];
			txtVstCompPk.text = arr_obj[1];
			txtVstComp.text = arr_obj[3];
			txtVstID.text = arr_obj[4];
			txtVstNm.text = arr_obj[5];			
			lstSEX.value    = arr_obj[6];
			
			txtTel.text     = arr_obj[7];			
			txtVehicle.text = arr_obj[8];
			txtContTo.text = arr_obj[9];
			txtPosition.text = arr_obj[10];
			txtDept.text = arr_obj[11];	
			if(txtVstPK.text != "")
			{
			    data_CheckExist.Call()
			}
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
			var row = control.SelectedRow(0);
             for(var j=0;j<oGrid.cols;j++)
             {
                 arr_data[arr_data.length]= oGrid.GetGridData(row,j);
             }
		window.returnValue =  arr_data;
		window.close();
    }
	
	  else
	  {
	    alert("Vui lòng chọn một visitor trên lưới!");
	  }
}
/*#######################################################################################*/
function OnDataError(obj)
{
	AlertDBError(obj.errmsg);
}

/*#######################################################################################*/
function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}

//-----------
function OnReport()
{
   var url =System.RootURL + '/reports/ch/ov/rpt_gate_in_out_register.aspx?l_visitor_pk=' + txtAppointPK.text ;
    window.open(url);                    
}
//-------------------------------
function OnReplicate()
{
    if(txtAppointPK.text=="")
    {
        alert("Please choose one application\nBạn phải chọn 1 phiếu đăng ký để thực hiện chức năng này.")
        return;
    }
    if (confirm("Do you want to replicate this applicant? \n Bạn có muốn tạo bảng copy của đơn này không?"))
    {
        datVisReplicate.Call();
    }
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Visitor Check-In Check-Out</title>
</head>
<body>
 <!---------------------------------tim pk cua register--------------------------------->
    <gw:data id="data_CheckExist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_vis_app_check_exist " > 
                <input>
                     <input bind="txtVstPK" /> 
                     <input bind="dtAppointedDate" /> 
                </input> 
                <output> 
                    <output bind="txtRegistPKTemp" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------>
<gw:data id="datAppointment" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,12,13,14" function="HR.SP_SEL_VIS_APPOINTMENT" procedure="HR.SP_UPD_VIS_APP"> 
                <inout>
                    <inout bind="txtAppointPK" /> 
                    <inout bind="txtVstPK" /> 
                    <inout bind="txtVstNm"/>
                    <inout bind="txtVstID"/>
                    <inout bind="lstSEX"/>
                    <inout bind="txtTel"/>
                    
                    <inout bind="txtContTo"/>
                    <inout bind="txtPosition"/>
                    <inout bind="dtAppointedDate"/>
                    <inout bind="txtVstTime"/>
                    <inout bind="txtVstCompPk"/>
                    <inout bind="txtVstComp"/>
                    
                    <inout bind="txtDept"/>
                    <inout bind="txtReasonCont"/>
                    <inout bind="txtVehicle"/>
                    <inout bind="txtCardType"/>
                    <inout bind="txtGAStatus"/>
                    <inout bind="txtTeamStatus"/>
                    
                    
               </inout> 
            </dso> 
        </xml> 
</gw:data>
<!---------------------------------------------------------->
    <gw:data id="datSearchApp" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR.SP_SEL_VISITOR_APP_INFO" > 
                <input bind="grdAppointment">
                    <input bind="dtAppFr" /> 
                    <input bind="dtAppTo" /> 
                    <input bind="lstApproveStatus" /> 
                    <input bind="txtSearchInfo" /> 
                    <inout bind="txtGA_Approval"/>
                </input> 
                <output bind="grdAppointment"/>
            </dso> 
        </xml> 
    </gw:data>

<!----------------------------------->
<gw:data id="datVisReplicate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_vis_replicate" > 
                <input>                    
                   <input bind="txtAppointPK" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>    
<table cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;"> 
    <tr style="height:5%" id='idbutton'>
            <td style="width:83%" ></td>
            <td align="right" width="5%"><gw:icon id="ibtnReplicate" img="in" text="Replicate" onclick="OnReplicate()" /></td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnNew" alt="New" img="New"  onclick="OnReset()"  styles="display:none"/>
            </td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnDel" alt="Delete" img="Delete"  onclick="OnDelete(1)" />
            </td>
            <td width="3%" align="right">
                <gw:imgBtn id="idBtnSave" alt="Save" img="Save"  onclick="OnSave(1)" /> 
            </td>
            <td style="width:3%" align="right">
                 <gw:imgBtn id="idReport" alt="Print" img="excel"  onclick="OnReport()" /> 
            </td>
                            
        </tr>
	<tr width="100%" style="height:25%" id='idinfor'>
		<td width="50%" colspan='6'>
			<fieldset style="width:100%;height:100%" >
				<table cellpadding="1" cellspacing=0 border=0 style="height:100%">
					<tr  style="height:5%">
						<td style="width:12%" colspan="2" align=right >Name <i> (Họ Tên)</i> </td>
                        <td style="width:22%" colspan="5">
                            <gw:textbox id="txtAppointPK"  text="" 	 styles='width:100%;display:none'    />
                            <gw:textbox id="txtVstPK"  text="" 	 styles='width:100%;display:none'    />
                            <gw:textbox id="txtVstNm"  text="" 	 styles='width:100%;' csstype="mandatory"   />
                        </td>
						<td style="width:3%"  align = "left">
						    <gw:imgBtn img="popup" id="btnVisitList"   alt="Select Visitor"  onclick="OnPopup(1)"/>
						</td>
						<td style="width:12%" colspan="2" align=right >ID <i> (CMND)</i> </td>
                        <td style="width:15%" colspan="3">
                             <gw:textbox id="txtVstID"  text="" 	 styles='width:100%;'   />
                        </td>
                        <td style="width:10%" colspan="2" align=right > Sex <i>(Giới tính)</i> </td>
                        <td style="width:8%" colspan="2">
                            <gw:list  id="lstSEX"  styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>
                                </data>
                                </gw:list>
                        </td>
                        <td  style="width:7%" align=right > Tel<i>(ĐT)</i> </td>
                        <td style="width:10%" colspan="3">
                             <gw:textbox id="txtTel"  text="" 	 styles='width:100%;'   />
                        </td>					
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align=right >Cont.to<i> (L.hệ với)</i> </td>
                        <td style="width:25%" colspan="6">
                            <gw:textbox id="txtContTo" 	 styles='width:100%;'   />
                        </td>
                        <td style="width:10%" colspan="2" align=right >Pos<i>(Chức vụ)</i> </td>
                        <td style="width:15%" colspan="3">
                            <gw:textbox id="txtPosition"  	 styles='width:100%;'   />
                        </td>
                        
                         <td style="width:10%"  colspan="2" align=right ><font style='color:Red'> Date<i>(Ngày)</i></font> </td>
                        <td style="width:8%" colspan="2">
                            <gw:datebox id="dtAppointedDate" lang="1" styles="width:100%" ></gw:datebox>
                        </td>
                        <td  align=right ><font style='color:Red'>Time<i>(Giờ)</i></font> </td>
                        <td colspan="3">
                            <gw:textbox id="txtVstTime"  	 styles="width:100%;"   />
                        </td>
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align="right" >Company<i>(Cty)</i> </td>
                        <td style="width:25%" colspan="6">
                          <gw:textbox id="txtVstCompPk"   	 styles='width:100%;display:none'   />
                            <gw:textbox id="txtVstComp"   	 styles='width:100%;'   />
                        </td>
                        <td style="width:10%" colspan="2" align="right" > Dept<i>(Phòng ban)</i>   </td>
                        <td style="width:15%" colspan="3">
                             <gw:textbox id="txtDept"  	 styles='width:100%;'   />
                        </td>
                       <td style="width:10%"  colspan="2" rowspan="2" align=right >Reason<i> (Lý do)</i> </td>
                        <td  colspan="6" rowspan="2" >
                            <gw:textarea id="txtReasonCont" 	 styles='width:100%;height:90%'   />
                        </td>                   
                    </tr>
                    <tr>
                        
                        <td style="width:10%" colspan="2" align=right >Vehicle No <i> (Số xe)</i> </td>
                        <td style="width:20%" colspan="4">
                            <gw:textbox id="txtVehicle"  text="1" 	 styles='width:50%;'   />
                        </td>
                        
                        <td style="width:15%" colspan="4" align=right >Card Type<i>(Loại thẻ)</i> </td>
                        <td style="width:15%" colspan="3">
                            <gw:textbox id="txtCardType"  	 styles='width:100%;'   />
                        </td>
                    </tr>
			</table>
			</fieldset>
		</td>
		
	</tr>
	<tr style="height:5%" id="idSearch1"><td colspan = "6">
			<table cellpadding="1" cellspacing="1" border=0>
				<tr>
					<td style="width:8%"  align = "right">Date <i> (Ngày)</i></td>
					<td style="width:10%" align = "right"><gw:datebox id="dtAppFr" lang="1" styles="width:100%" ></gw:datebox></td>
					<td style="width:4%"  align = "right"><b>~</b></td>
					<td style="width:10%" align = "right"><gw:datebox id="dtAppTo" lang="1" styles="width:100%" ></gw:datebox></td>
					<td style="width:12%"  align = "right">Status <i>(Tình trạng)</i></td>
					<td style="width:15%" align = "right">
					<gw:list  id="lstApproveStatus" value="ALL"  styles='width:100%' onchange="OnSearch(1)">
                        <data>
                            <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0124' order by code ")%>|ALL|Select All
                        </data>
                    </gw:list></td>
                    <td style="width:12%"  align = "right">Search<i>(Tìm kiếm)</i></td>
					<td style="width:18%"  align = "right"><gw:textbox id="txtSearchInfo" onenterkey = "OnSearch(1)"/></td>
				    <td style="width:1%"  align = "right"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/></td>
					<td colspan="10" align = "right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
				</tr>
			</table>
	</td></tr>
	<tr style="height:65%; width:100%"  id="idSearch2">
		<td width="100%" colspan="6"><table border=1 style="width:100%;height:100%;"><tr><td width="75%"  rowspan="2">
                   <gw:grid id='grdAppointment'
                    header='_APP_PK|_THR_VIS_MASTER_PK|Họ Tên Khách|CMND/Passport|Giới tính|Điện Thoại|L.hệ Với|Chức Vụ|Ngày Hẹn|Giờ Hẹn|_THR_VIS_COMPANY_PK|Công Ty|Phòng Ban|Lý Do|Số Xe|Loại thẻ|Tình Trạng(Team)|Tình trạng (GA)|_GA Approval Code'
                    format='0|0|0|0|2|0|0|0|4|0|0|0|0|0|0|2|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1000|870|1500|1500|1000|1410|1425|2190|1215|1155|1065|1500|1590|1710|1365|1455|1680|1000|0'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncelldblclick="OnSelect(grdAppointment)"
                    oncellclick="OnClickRegister()"
                    />
			</td>
	</tr>
	</table>
	</td></tr>
 </table>
<gw:datebox id="txtTeamStatus"              style="display:none"/>
<gw:textbox id="txtGAStatus"              style="display:none"/>
<gw:textbox id="txtRegistPKTemp"              style="display:none"/>
<gw:label id="lblCheckResult"              style="display:none"/>
<gw:label id="txtGA_Approval"              style="display:none"/>
<gw:textbox id="txtResult"  styles="display:none"/>
</body>
</html>
