<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
var tien_gs = 7,
    tien_gd = 8,
    tigia = 9;
function BodyInit()
{	
	BindingDataList();
    OnFormatGrid();
    OnSearch();
   


}
//-------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
    var ls_comp  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_comp);    
    var loaitien = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0110','','') FROM DUAL")%>|All|-Chọn tất cả-";  //ccy
     lstLoaitien.SetDataText(loaitien);
     var loai_tk = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0008') FROM DUAL")%>|All|-Chọn tất cả-";
     lstLoai_tk.SetDataText(loai_tk);
     var thoigian = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0010') FROM DUAL")%>|All|-Chọn tất cả-";
     //lstThoigian.SetDataText(thoigian);
     lstLoaitien.value = "All";
     lstLoai_tk.value = "All";
    // lstThoigian.value = "All";
     
     <%=ESysLib.SetGridColumnComboFormat("idGrid",9,"SELECT B.CODE, B.CODE FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACAB0110' and a.del_if = 0 and b.del_if = 0")%>;
    
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
						txt_sttr_code.text = object[1] ;
						
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
//---------------------------------------------------------------------------------------
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
    }
    else if (obj.id == 'dat_delete_All')
    {
        dat_grid.Call("SELECT");
      
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
//-----------------------------------------------------------
function onGenerate()
{
        dat_generate_slip.Call();
}

//-----------------------------------------------------------
function onGenerateCancel()
{
	if(confirm('Bạn có muốn hủy hạch toán ngày:' + dtTu_ngay.text))
	{
        dat_generate_slip_cancel.Call();
	}
}
//-----------------------------------------------------------
function OnSearch()
{
    DSO_MT.Call("SELECT");
}
//-----------------------------------------------------------------
function OnDelete()
{
  
	var bl = 0;
    for (i = 1; i < idGrid.rows; i++)
	{
		if(idGrid.GetGridData(i,1)=="-1")
		{
		        
		        idGrid.SetRowStatus(i, Number("0x40"));
		        
		        bl = 1;   
		   
		    
		}
	}
	
	if (bl==0)
	{
		alert("Please check row to delete!!");
		return;
		
	}
	else if(bl==1)
	{
	    if(confirm("Are you sure you want to delete?"))
	    {
	        dat_grid.Call();
	    }
	    return;
	    
	}
    
}
function OnCancel()
{
    if(confirm("Are you sure you want to delete all data?"))
    {
       // idGrid.DeleteAll();
        dat_delete_All.Call();
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
	                    var object = System.OpenModal( fpath , 1000 , 600 , 'resizable:yes;status:yes'); 
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
	                    var object = System.OpenModal( fpath , 1000 , 600 , 'resizable:yes;status:yes'); 
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
<!-------------------------------------------------------------------------------------------------------------->
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
            <dso id="1" type="process" parameter="0,1,2,3,4,5"  procedure="acnt.sp_udp_gfos00070_11"> 
                <input>   
                    <input bind="txt_action" />
                    <input bind="txtTAC_SECCASHTRAN_pk" />
                    <input bind="tac_abacctcode_pk_dr" />
                    <input bind="tac_abacctcode_pk_cr" />
                    
                    <input bind="dtTu_ngay" /> 
                    <input bind="dtDen_ngay" /> 
                    <input bind="lstCompany" />
                    <input bind="txtLoaiGD_pk" />   
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------------------------->
<gw:data id="dat_generate_slip"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2,3,4,5"  procedure="acnt.sp_udp_gfos00070_2"> 
                <input>   
                    <input bind="txt_action" />
                    <input bind="txtTAC_SECCASHTRAN_pk" />
                    <input bind="tac_abacctcode_pk_dr" />
                    <input bind="tac_abacctcode_pk_cr" />
                    
                    <input bind="dtTu_ngay" /> 
                    <input bind="dtDen_ngay" /> 
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------------------------->
<gw:data id="dat_generate_slip_cancel"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2,3,4,5"  procedure="acnt.SP_pro_gfos00070_3"> 
                <input>   
                    <input bind="lstCompany" />
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
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00070_1" > 
            <input>
                  <input bind="txtTAC_SECCASHTRAN_pk" />
                  <input bind="dtTu_ngay" />
                  <input bind="dtTu_ngay" />
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
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="acnt.sp_sel_gfos00070_2"   procedure="acnt.sp_upd_gfos00070"> 
                <input bind="idgrid">                    
                    <input bind="txtTAC_SECCASHTRAN_pk" /> 
                </input> 
                <output bind="idgrid" /> 
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------------------------->
<gw:data id="dat_delete_All"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1"  procedure="acnt.sp_upd_gfos00070_3"> 
                <input>   
                    <input bind="txt_action1" />
                    <input bind="lstCompany" />
                    <input bind="dtTu_ngay" />
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>
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
<table width="100%" cellpadding="0" cellspacing="0" border="1" style="height:100%" >
	<tr style="height:10%;width:100%">
	    <td>
	        <fieldset>
	            <table>
	                    <tr >
		                    <td align="right" width="15%">Công ty&nbsp;</td>
		                    <td width="25%"><gw:list id="lstCompany" styles="width:100%" /></td>		
		                    <td align="right"  width="15%"><a title="Nhấp vào đây để hiển thị loại giao dịch" onclick="OnPopUp('loaigiaodich')" href="#tips" ><b>Loại giao dịch&nbsp;</b></a></td>
                            <td colspan="4" width="40%"><gw:textbox id="txtLoai_gd"  styles='width:100%'  onenterkey="OnSearch()"  /></td>
                          
                            <td ><gw:imgBtn id="ibtnSearch" img="search" alt="Tìm kiếm" onclick="OnSearch()"/></td>
                            <td ><gw:imgBtn id="ibtnSearch1" img="save" alt="Hiệu chỉnh" onclick="OnSave()"/></td>
						    <td ><gw:imgBtn id="ibtnProcess" img="process" alt="Lấy dữ liệu từ hệ thống BOS" onclick="Process()"/></td>
                            <td ><gw:imgBtn id="ibtnSearch2" img="delete" alt="Xóa" onclick="OnDelete()"/></td>
                            <td ><gw:imgBtn id="ibtnSearch3" img="cancel" alt="Xóa tất cả dữ liệu" onclick="OnCancel()"/></td>
	                    </tr>
	                    <tr >
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị loại tiền" onclick="GetDataListbox(1)" href="#tips" >Loại tiền&nbsp;</a></td>
		                    <td width="25%"><gw:list id="lstLoaitien" styles="width:100%" /></td>
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị người đầu tư" onclick="OnPopUp('nguoidautu')" href="#tips" >Người đầu tư&nbsp;</a></td>
		                    <td width="55%" colspan="4"><gw:textbox id="txtNguoi_dt"  styles="width:100%"  /></td>
		                   <td colspan="5"><gw:icon id="btngenerate" img="in" text="Hạch toán" onclick="onGenerate()" styles="width:100%" /></td>
                           
	                    </tr>
						     <td width="15%" align="right">Ngày xử lý&nbsp;</td>
		                    <td width="25%"><gw:datebox id="dtTu_ngay" lang="1" /></td>
		                    <td width="15%" align="right"><a title="Nhấp vào đây để hiển thị loại tài khoản" onclick="GetDataListbox(2)" href="#tips" >Loại tài khoản&nbsp;</a></td>
		                    <td width="55%" colspan="4">
								<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%" >
									<tr>
										
										<td   width="15%"><gw:list id="lstLoai_tk" styles="width:100%" /></td>
										<td width="15%" align="right"><a title="Nhấp vào đây để hiển thị người lập" onclick="OnPopUp('nguoilap')" href="#tips" >Người lập</a></td>
										 <td width="20%" ><gw:textbox id="txtNguoi_lap"  styles="width:100%"  /></td>
										
									</tr>
								</table>
							</td>
		                   <td colspan="5"><gw:icon id="btnConfirm1" img="in" text="Hủy hạch toán" onclick="onGenerateCancel()" styles="width:100%" /></td>
                           
	                    </tr>

	            </table>
	        </fieldset>
	    </td>
	</tr>
	
	
	<tr style="height:90%;width:100%" >
		<td colspan="14" width="100%">
		<!--header  ="0_pk|1.Chọn|2.Ngày|3.Số chứng từ|4.Giao dịch|5.Họ tên|6.Số tài khoản|7.Tiền ghi sổ|8.Tiền giao dịch|9.Loại tiền|10.Tỉ giá|11.Tài khoản nợ|12.Tài khoản có|13_Loại nghiệp vụ|14.Diễn giải|15,Số(SEQ)|16_dr_pk|17._cr_pk|18.Ngày xử lý|19.Số chứng từ(BOS)"-->
			<gw:grid
				id="idGrid"				
				header  ="_pk|Chọn|Ngày|Số chứng từ|Giao dịch|Họ tên|Số tài khoản|Tiền ghi sổ|_Tiền giao dịch|Loại tiền|Tỉ giá|Tài khoản nợ|Tài khoản có|_Loại nghiệp vụ|Diễn giải|Số(SEQ)|_dr_pk|_cr_pk|Ngày xử lý|Số chứng từ(BOS)|_com_pk|Số tài khoản NH(Nợ)|Tên ngân hàng(Nợ)|Số tài khoản NH(Có)|Tên ngân hàng(Có)"
				format  ="0|3|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0"
				aligns  ="0|0|0|2|0|0|0|3|3|1|3|2|2|0|0|0|0|0|0|0|0|0|0|0|0"
				defaults="||||||||||||||||||||||||"
				editcol ="0|1|1|1|1|0|1|1|1|1|0|0|1|1|1|1|0|0|0|0|0|0|0|0|0"
				widths  ="0|700|1300|1400|3000|2500|1500|2000|2000|1000|1000|3000|3000|1500|2500|1000|0|0|1200|2000|0|2500|3500|2500|3500"
				styles  ="width:100%; height:100%"		
				acceptnulldate="T"	
				sorting ="T" oncelldblclick="GetAcc(4);GetAcc(5)"/>             
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
	  <gw:datebox id="dtDen_ngay" lang="1" />
	  <gw:textbox id="txt_action1" text="DELETE" styles='display:none;'/>
	  <gw:textbox id="txt_sttr_code" text="DELETE" styles='display:none;'/>
</body>
</html>
