<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
var tien_gs = 6,
    tien_gd = 7,
    tigia = 9;
function BodyInit()
{	
	BindingDataList();
    
    OnFormatGrid();
    OnSearch();
   
}

function BindingDataList()
{
    var ls_comp  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_comp);    
    var loaitien = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>|All|-Chọn tất cả-";  //ccy
     lstLoaitien.SetDataText(loaitien);
     var loai_tk = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0008') FROM DUAL")%>|All|-Chọn tất cả-";
     lstLoai_tk.SetDataText(loai_tk);
     var thoigian = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0010') FROM DUAL")%>|All|-Chọn tất cả-";
     lstThoigian.SetDataText(thoigian);
     lstLoaitien.value = "All";
     lstLoai_tk.value = "All";
     lstThoigian.value = "All";
     
   
    
}


//-----------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        case 'nguoilap':
            var path = System.RootURL + '/form/gf/os/gfos00070_popup_2.aspx';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtNguoi_lap.text    = obj[2];
                txtNguoiLap_pk.text  = obj[0];
                           
            }
        break;
        case 'nguoidautu':
            var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
			var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
			if ( object != null )
			{
				
						txtNguoi_dt.text = object[2];
						txtNguoiDT_pk.text = object[0];
			  
			 }
        break;  
        case 'loaigiaodich':
            var path    = System.RootURL + '/form/gf/os/gfos00070_popup_3.aspx';
			var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
			if ( object != null )
			{
				
				
						txtLoai_gd.text = object[1]+ " - " + object[2];
						txtLoaiGD_pk.text = object[3];
			    
			 }
        break;
        case 'loaitien':
             var path = System.RootURL + "/form/fp/ab/PopUpChangeCommonCode.aspx?code=ACAB0110";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'ACAB0110';
	                iCodeID           = object[1];
	                
                    datGetNewCode.Call("SELECT");                                
	            }
	            else
	                lstCurrency.value = object[1];        
	         }                
        break;  
    }    
}
function GetDataListbox(index)
{
    var scode;
        switch(index)
        {           
            case 1:
                scode='ACAB0110'; //loai tien
            break;
            case 2:
                scode='GFQC0008'; //loai tai khoan
            break;
            case 3:
                scode='GFQC0010'; // thoi gian
            break;
        }
        txtComCodeID.text = scode;
        var fpath = System.RootURL + "/form/gf/os/gfos00070_popup_1.aspx?code=" + scode ;
       
        var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
        if (obj!=null)
        {
            strcodereturn=obj[1];
            indexCode=index;
            
            if (obj[0]==1 ) //modify common code
                OnLoadNew(scode);
                //datGetNewControl.Call();
            else
            {               
                switch(index)
                {                        
                    case 1:
                        lstLoaitien.value=strcodereturn; //loai tien
                    break;
                    case 2:
                        lstLoai_tk.value=strcodereturn; //loai tai khoan
                    break;
                    case 3:
                        lstThoigian.value=strcodereturn; // thoi gian
                    break;
                    
                }            
            }
        }	     
               

}
//-------------------------------------------------------------
function OnDataReceive(obj)
{
   
    var strdata = txtCodeTemp.text;
    if(obj.id == 'datGetNewCode')
    {
        switch(indexCode)
                {
                    case 1:
                        lstLoaitien.SetDataText(strdata);
                        lstLoaitien.value=strcodereturn; //loai tien                   
                    break;
                    case 2:
                        lstLoai_tk.SetDataText(strdata);
                        lstLoai_tk.value=strcodereturn; //loai tai khoan
                    break;
                    case 3:
                        lstThoigian.SetDataText(strdata);
                        lstThoigian.value=strcodereturn; //thoi gian
                    break;
                    
                }
    }
    else if (obj.id == 'dat_process')
    {
          
                     OnSearch();
                        // alert("Process compled!!");
                         
    }
  /*  else if(obj.id == "dso_get_rate")
    {
        idGrid.SetGridText(txt_row.text, 9, txtExrate2.text );
        var l_tramt = 0, l_bkamt = 0, ccy = "", tigia = 0;
        ccy = idGrid.GetGridData(txt_row.text, 8);
        l_tramt = Number(idGrid.GetGridData(txt_row.text, 7));
        tigia = Number(idGrid.GetGridData(txt_row.text, 9));
        if(ccy.value = 'USD')
        {
            l_bkamt = l_tramt/tigia;
        }
        else if('VND')
        {
            
        }
        
    }*/
}
//-------------------------------------------------------------
function OnLoadNew(scode)
 {	
        datGetNewCode.Call('SELECT');
 }
//-----------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
    var x = c.toUpperCase().charCodeAt(0);
    event.keyCode = x;
}
//-----------------------------------------------------------
function Process()
{
        dat_process.Call();
}
function OnSearch()
{
    DSO_MT.Call("SELECT");
}
//-----------------------------------------------------------------
function OnDelete()
{
   
	//var bl = 0;
    for (i = 1; i < idGrid.rows; i++)
	{
		if(idGrid.GetGridData(i,1)=="-1")
		{
			idGrid.DeleteRow();
		}
		else
		{
		    alert("Please check row to delete!!");
		}
	}
	
    
}
//-----------------------------------------------------------------
function OnSave()
{
    dat_grid.Call();
}
//------------------------------------------------------------
function OnFormatGrid()
{
    var trl;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(tien_gs)                  = "###,###,###,###,###.##";    
    trl.ColFormat(tien_gd)                  = "###,###,###,###,###.##";    
    trl.ColFormat(tigia)              = "###,###,###,###,###.##";
    
}
//----------------------------------------------------------------
function OnChangeCcy()
{
    
    dso_get_rate.Call();
    
    
} 
//-----------------------------------------------------------------------
function GetAcc(obj)
{
    switch(obj)
    {
         case 4:
                    if(idGrid.col=="10")
                    {
                        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if ((object != null) &&(object[0]!="0"))
                        {
                                    
                            idGrid.SetGridText( idGrid.row, 15, object[3]);    //ACPK
	                        idGrid.SetGridText( idGrid.row, 10, object[0]+' - '+object[1] );    //Account Code
                            
                           
                        }
                    }
            break;
            case 5:
                    if(idGrid.col=="11")
                    {
                        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	                    var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                        if ((object != null) &&(object[0]!="0"))
                        {
                                    
                            idGrid.SetGridText( idGrid.row, 16, object[3]);    //ACPK
	                        idGrid.SetGridText( idGrid.row, 11, object[0]+ ' - ' +object[1]);    //Account Code
                          
                           
                        }
                    }
            break;
    }
}
</script>

<body>
 <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="acnt.sp_sel_gfos00040_newcomm" > 
                <input> 
                    <input bind="txtComCodeID" /> 
                </input>
	           <output>
	                <input bind="txtCodeTemp" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!----------------------------------------------------------------------------------------------------------------------->
 <gw:data id="dat_process"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2,3,4,5"  procedure="acnt.sp_udp_gfos00070_1"> 
                <input>   
                    <input bind="txt_action" />
                    <input bind="txtTAC_SECCASHTRAN_pk" />
                    <input bind="tac_abacctcode_pk_dr" />
                    <input bind="tac_abacctcode_pk_cr" />
                    
                    <input bind="dtTu_ngay" /> 
                    <input bind="dtDen_ngay" /> 
                    <input bind="dtTu_ngay" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------------------------------------->
<gw:data id="DSO_MT" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00110_1" > 
            <input>
                  <input bind="txtTAC_SECCASHTRAN_pk" />
                  <input bind="dtTu_ngay" />
                  <input bind="dtDen_ngay" />
				  <input bind="lstLoaitien" />
				  <input bind="txtLoaiGD_pk" />
				  <input bind="txtLoai_gd" />
				  
            </input>
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data> 
<!------------------------------------------------------------------------------------------------------>
<gw:data id="dat_grid"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="acnt.sp_sel_gfos00070_2"   procedure="acnt.sp_upd_gfos00070"> 
                <input bind="idgrid">                    
                    <input bind="txtTAC_SECCASHTRAN_pk" /> 
                </input> 
                <output bind="idgrid" /> 
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------------------------->
<!-- <gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dbContractdt"/>
                     <input bind="cboCompany"/>
                     <input bind="listccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtExrate2"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>-->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%" >
	<tr style="height:10%;width:100%">
	    <td>
	        <fieldset>
	            <table>
	                    <tr >
		                    <td align="right" width="15%">Công ty&nbsp;</td>
		                    <td width="25%"><gw:list id="lstCompany" styles="width:100%" /></td>		
		                    <td align="right"  width="15%"><a title="Nhấp vào đây để hiển thị loại giao dịch" onclick="OnPopUp('loaigiaodich')" href="#tips" ><b>Loại giao dịch&nbsp;</b></a></td>
                            <td colspan="3" width="40%"><gw:textbox id="txtLoai_gd"  styles='width:100%' onenterkey="OnSearch()"  /></td>
                            <td width="5%"></td>
                            <td ><gw:imgBtn id="ibtnSearch" img="search" alt="Tìm kiếm" onclick="OnSearch()"/></td>
                            <!--td ><gw:imgBtn id="ibtnSearch1" img="save" alt="Hiệu chỉnh" onclick="OnSave()"/></td>
						    <td ><gw:imgBtn id="ibtnProcess" img="process" alt="Lấy dữ liệu từ hệ thống BOS" onclick="Process()"/></td>
                            <td ><gw:imgBtn id="ibtnSearch2" img="delete" alt="Xóa" onclick="OnDelete()"/></td-->
	                    </tr>
	                     <tr >
	                        <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị thời gian" onclick="GetDataListbox(3)" href="#tips" ><b>Thời gian&nbsp;</b></a></td>
		                    <td width="25%"><gw:list id="lstThoigian" styles="width:100%" /></td>
	                        <td align="right" width="15%">Từ ngày&nbsp;</td>
	                        <td align="left" width="5%">
	                            <table width="100%">
	                                <tr>
	                                    <td ><gw:datebox id="dtTu_ngay" lang="1" /></td>
		                                <td align="center">~</td>
		                                <td ><gw:datebox id="dtDen_ngay" lang="1" /></td>
	                                </tr>
	                            </table>
	                        </td>
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị người lập" onclick="OnPopUp('nguoilap')" href="#tips" ><b>Người lập&nbsp;</b></a></td>
		                    <td width="20%" ><gw:textbox id="txtNguoi_lap"  styles="width:100%"  /></td>
		                    <td width="5%" colspan="5"></td>
		                    <!--td colspan="4"><gw:icon id="btnConfirm19" img="in" text="Hủy hạch toán" onclick="" styles="width:100%" /></td-->
                            
	                    </tr>
	                    <tr >
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị loại tiền" onclick="GetDataListbox(1)" href="#tips" ><b>Loại tiền&nbsp;</b></a></td>
		                    <td width="25%"><gw:list id="lstLoaitien" styles="width:100%" /></td>
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị người đầu tư" onclick="OnPopUp('nguoidautu')" href="#tips" ><b>Người đầu tư&nbsp;</b></a></td>
		                    <td width="5%"><gw:textbox id="txtNguoi_dt"  styles="width:100%"  /></td>
		                    <td width="10%" align="right"><a title="Nhấp vào đây để hiển thị loại tài khoản" onclick="GetDataListbox(2)" href="#tips" ><b>Loại tài khoản&nbsp;</b></a></td>
		                    <td width="25%"><gw:list id="lstLoai_tk" styles="width:100%" /></td>
		                    <td width="5%"  colspan="5"></td>
		                    <!--td colspan="4"><gw:icon id="btnConfirm1" img="in" text="Hạch toán" onclick="" styles="width:100%" /></td-->
                           
	                    </tr>
	                   
	            </table>
	        </fieldset>
	    </td>
	</tr>
	
	
	<tr style="height:90%;width:100%" >
		<td colspan="14" width="100%">
		<!--header  ="0._pk|1.Chọn|2.Ngày|3.Số chứng từ|4.Họ tên|5.Số tài khoản|6.Tiền ghi sổ|7.Tiền giao dịch|8.Loại tiền|9.Tỉ giá|10.Tài khoản nợ|11.Tài khoản có|12.Loại nghiệp vụ|13.Diễn giải|14.Số(SEQ)|15._dr_pk|16.cr_pk"-->
			<gw:grid
				id="idGrid"				
				header  ="Ngày|Mã giao dịch|Tên giao dịch|Số tài khoản|Tên khách hàng|Trị giá|Số tài khoản NH(Nợ)|Tên ngân hàng(Nợ)|Số tài khoản NH(Có)|Tên ngân hàng(Có)"
				format  ="4|0|0|0|0|1|0|0|0|0"
				aligns  ="0|0|0|2|0|3|0|0|0|0"
				defaults="|||||||||"
				editcol ="0|1|1|1|1|0|0|0|0|0"
				widths  ="1300|1400|2500|2500|3500|2000|2500|3500|2500|3500"
				styles  ="width:100%; height:100%"		
				acceptnulldate="T"	
				sorting ="T" oncelldblclick=""/>           
		</td>
	</tr>
</table>	
 
   <gw:textbox id="txtLoaiGD_pk" styles='width:100%;display:none' />   
    <gw:textbox id="txtNguoiDT_pk" styles='width:100%;display:none' />   
      <gw:textbox id="txtNguoiLap_pk" styles='width:100%;display:none' /> 
      
      <gw:textbox id="txtComCodeID" styles='width:100%;display:none' />   
      <gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />  
      
      <gw:textbox id="txtTAC_SECCASHTRAN_pk" styles='width:100%;display:none' />  
      <gw:textbox id="tac_abacctcode_pk_dr"  styles='display:none;'/>
      <gw:textbox id="tac_abacctcode_pk_cr"  styles='display:none;'/>
     
      <gw:textbox id="txt_action" text="INSERT" styles='display:none;'/>
      <gw:textbox id="txtReturn"  styles='display:none;'/>
</body>
</html>
4/21/2010