<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>
    
</head>
<%ESysLib.SetUser("acnt")%>
<script type="text/javascript" language="javascript">
function BodyInit()
{	
	BindingDataList();
	MergeHeaderLeft();
	//GridLeftFormat();
	GridRightFormat();
}
//-------------------------------------------------------------------------------------------------------------------
function BindingDataList()
{
    var ls_comp  = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_comp);    
    lstCompany.SetDataText("2");
	lstCompany.SetEnable(false);
     var loai_tk = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0008') FROM DUAL")%>|All|-Chọn tất cả-";
    
     
     lstLoai_tk.SetDataText(loai_tk);
     lstLoai_tk.value = "All";
     
    
     
     <%=ESysLib.SetGridColumnComboFormat("GridLeft",3,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0012' and a.del_if = 0 and b.del_if = 0")%>;
	 //GridLeft.GetGridControl().FrozenCols = 3
}
//-----------------------------------------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        
        case 'nguoidautu':
            var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
			var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
			if ( object != null )
			{
				
						txtNguoi_dt_cd.text = object[1];
						txtNguoi_dt_nm.text = object[2];
						txtNguoiDT_pk.text = object[0];
			  
			 }
        break;  
        case 'loaigiaodich':
            var path    = System.RootURL + '/form/gf/os/gfos00070_popup_3.aspx';
			var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
			if ( object != null )
			{
				
				
						txtLoai_gd_cd.text = object[1];
						txtLoai_gd_nm.text = object[2];
						//txtLoaiGD_pk.text = object[3];
						
			 }
        break;
        case 'chinhanh':
            var path    = System.RootURL + '/form/gf/os/gfos00100_popup.aspx';
			var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
			if ( object != null )
			{
				
				
						txtchinhanh_cd.text = object[1];
						txtchinhanh_nm.text = object[2];
						
						
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
           
            case 2:
                scode='GFQC0008'; //loai tai khoan
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
                    
                    case 2:
                        lstLoai_tk.value=strcodereturn; //loai tai khoan
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
           
            case 2:
                lstLoai_tk.SetDataText(strdata);
                lstLoai_tk.value=strcodereturn; //loai tai khoan
            break;

        }
    }
      else if(obj.id =='DSO_GridLeft')
    {
		MergeHeaderLeft();
       
		 GridLeft.Subtotal (0,2 ,1, '4!5!6!7!8!9!10!11!12','',true,1,'Tổng cộng');
		  
		 GridLeft.SetCellBgColor(GridLeft.rows - 1,0,GridLeft.rows - 1, GridLeft.cols - 1,Number("0xabcdef"));
		  for(i=2;i<GridLeft.rows;i++)
		   {
				if (GridLeft.GetGridData(i,1)=="Tổng cộng")
				{
					GridLeft.SetGridText(i,0,"");
					GridLeft.SetCellBgColor(i,0,i,1,0xabcdef);
				}
		   }
    }
 
}
//-------------------------------------------------------------
function OnLoadNew(scode)
 {	
        datGetNewCode.Call('SELECT');
 }
//----------------------------------------------------
function OnToggle(pos)
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");   
    var imgArrow1 = document.all("imgArrow1");   
    var imgArrow2 = document.all("imgArrow2"); 
    
    if ( pos == '1' ) 
    { 
        if ( imgArrow1.status == "expand" && imgArrow2.status == "expand" )
        {
            left.style.display  ="none";
            right.style.display ="";      
            
            right.style.width  ="100%";
            
            imgArrow1.status = "collapse";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="none";
            imgArrow2.style.display="";                         
        }
        else if ( imgArrow1.status == "expand" && imgArrow2.status == "collapse" )
        {
            left.style.display  ="";
            right.style.display ="";
            
            left.style.width   ="40%";
            right.style.width  ="60%";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="";
        }
    }    
    else
    {
        if ( imgArrow1.status == "expand" && imgArrow2.status == "expand" )
        {
            left.style.width ="100%";
            
            right.style.display ="";       
            right.style.display ="none";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "collapse";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="none";                        
        }
        else if ( imgArrow1.status == "collapse" && imgArrow2.status == "expand" )
        {
            left.style.display  ="";
            right.style.display ="";
                    
            left.style.width   ="40%";
            right.style.width  ="60%";
            
            imgArrow1.status = "expand";
            imgArrow2.status = "expand";
            
            imgArrow1.style.display="";
            imgArrow2.style.display="";
        }
    }    
}
//--------------------------------------------------
function OnSearch()
{
    DSO_GridLeft.Call("SELECT");
}
var flag="";
function OnClick()
{
    txtLoai_gd_cd1.text = GridLeft.GetGridData(GridLeft.row,14);
    dtTu_ngay1.text = GridLeft.GetGridData(GridLeft.row,1);
    txtchinhanh_cd1.text = GridLeft.GetGridData(GridLeft.row,15);
   // flag = 'search';
    DSO_GridRight.Call("SELECT");
}

//--------------------------
function GridRightFormat()
{
    var fg = GridRight.GetGridControl();
    fg.ColFormat(3) = "###,###.##R"; 
   
}
//---------------------------------------------------
function MergeHeaderLeft()
{
    var fg=GridLeft.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   GridLeft.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
	    
	    fg.Cell(0, 0, 5,0, 7)  = "HOSE"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 5, 1, 5) = "Trong nước"
	    fg.Cell(0, 1, 6, 1, 6) = "Nước ngoài"
	    fg.Cell(0, 1, 7, 1, 7) = "Tự doanh" 
	  
	    fg.Cell(0, 0, 8,0, 10)  = "HNX"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 8, 1) = "Trong nước"
	    fg.Cell(0, 1, 9, 1) = "Nước ngoài"
	    fg.Cell(0, 1, 10, 1) = "Tự doanh"
	    
	    fg.Cell(0, 0, 11,0, 13)  = "UPCOM"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 11, 1) = "Trong nước"
	    fg.Cell(0, 1, 12, 1) = "Nước ngoài"
	    fg.Cell(0, 1, 13, 1) = "Tự doanh"
	    
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Ngày giao dịch"	
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Ngày hạch toán"	
		fg.MergeCol(2) = true
		fg.Cell(0, 0, 2, 1, 2) = "Chi nhánh"	
		fg.MergeCol(3) = true
		fg.Cell(0, 0, 3, 1, 3) = "Loại giao dịch"	
		fg.MergeCol(4) = true
		fg.Cell(0, 0, 4, 1, 4) = "Trị giá"	
		
        fg.ColFormat(4) = "#,###,###,###,###,###,###R"; 
        fg.ColFormat(5) = "#,###,###,###,###,###,###R";
        fg.ColFormat(6) = "#,###,###,###,###,###,###R";
        fg.ColFormat(7) = "#,###,###,###,###,###,###R";
        fg.ColFormat(8) = "#,###,###,###,###,###,###R"; 
        fg.ColFormat(9) = "#,###,###,###,###,###,###R"; 
        fg.ColFormat(10) = "#,###,###,###,###,###,###R"; 
        fg.ColFormat(11) = "#,###,###,###,###,###,###R";
        fg.ColFormat(12) = "#,###,###,###,###,###,###R";
        fg.ColFormat(13) = "#,###,###,###,###,###,###R"; 
		
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
<!------------------------------------------------------------------->
<gw:data id="DSO_GridLeft" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00130_1" > 
            <input  >
                <input bind="txtLoai_gd_cd"/>
                <input bind="dtTu_ngay"/>
				<input bind="dtDen_ngay"/>
				<input bind="lstLoai_tk"/>
				<input bind="txtNguoi_dt_cd"/>
				<input bind="txtchinhanh_cd"/>
				
            </input>
            <output bind="GridLeft" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="DSO_GridRight" > 
    <xml> 
        <dso id="2" type="grid" function="acnt.sp_sel_gfos00100_2" > 
            <input  >
                <input bind="txtLoai_gd_cd1"/>
                <input bind="dtTu_ngay1"/>
				<input bind="txtNguoi_dt_cd"/>
				<input bind="txtchinhanh_cd1"/>
				
            </input>
            <output bind="GridRight" /> 
        </dso> 
    </xml> 
</gw:data>
<table style="height:100%;width:100%;background:#BDE9FF;" >
	<tr  style="height:10%;width:100%">
	    <td style="background:white" colspan="3">
	        <fieldset style="width:100%;padding-top:10;padding-bottom:5;padding-left:0;padding-right:0" >
	            <table style="width:100%">
	                    <tr >
		                    <td align="right" width="13%">Công ty&nbsp;</td>
		                    <td width="22%" colspan="3"><gw:list id="lstCompany" styles="width:100%" /></td>		
		                    <td align="right"  width="15%"><a title="Nhấp vào đây để hiển thị loại giao dịch" onclick="OnPopUp('loaigiaodich')" href="#tips" ><b>Loại giao dịch&nbsp;</b></a></td>
                            <td width="50%" colspan="2">
                                <table style="width:100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td  width="30%"><gw:textbox id="txtLoai_gd_cd"  styles='width:100%'    /></td>
                                        <td  width="70%"><gw:textbox id="txtLoai_gd_nm"  styles='width:100%'   /></td>
                                        <td align="left"><gw:imgBtn id="ibtnSearch12" img="reset"  onclick="txtLoai_gd_cd.text='';txtLoaiGD_pk.text='';txtLoai_gd_nm.text='';"/></td>
                                    </tr>
                                </table>
                            </td>
                            
                            
                            <td ><gw:imgBtn id="ibtnSearch" img="search" alt="Tìm kiếm" onclick="OnSearch()"/></td>
	                    </tr>
	                    <tr>
		                   <td  align="right">Ngày xử lý&nbsp;</td>
		                   <td ><gw:datebox id="dtTu_ngay" lang="1" /></td>
		                   <td>~</td>
		                   <td ><gw:datebox id="dtDen_ngay" lang="1" /></td>
		                   
	                       <td align="right" width="15%"><a title="Nhấp vào đây để hiển thị người đầu tư" onclick="OnPopUp('nguoidautu')" href="#tips" >Người đầu tư&nbsp;</a></td>
	                        <td colspan="2" width="50%">
	                            <table style="width:100%" cellpadding="0" cellspacing="0">
	                                <tr>
	                                    <td width="30%"><gw:textbox id="txtNguoi_dt_cd"  styles="width:100%"  /></td>
	                                    <td width="70%"><gw:textbox id="txtNguoi_dt_nm"  styles="width:100%"  /></td>
	                                    <td align="left"><gw:imgBtn id="ibtnSearch122" img="reset"  onclick="txtNguoi_dt_cd.text='';txtNguoiDT_pk.text='';txtNguoi_dt_nm.text='';"/></td>
	                                </tr>
	                            </table>
	                        </td>
		                   
	                       <td ></td>
	                    </tr>
	                  <tr>
	                        <td align="right" width="13%"><a title="Nhấp vào đây để hiển thị loại tài khoản" onclick="GetDataListbox(2)" href="#tips" >Loại tài khoản&nbsp;</a></td>
		                    <td width="22%" colspan="3"><gw:list id="lstLoai_tk" styles="width:100%" /></td>
	                       
	                        
	                        
	                        
	                         <td  align="right"><a title="Nhấp vào đây để hiển thị chi nhánh" onclick="OnPopUp('chinhanh')" href="#tips" >Chi nhánh&nbsp;</a></td>
		                   <td colspan="2" width="30%">
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
	                                <tr>
	                                    <td width="30%"><gw:textbox id="txtchinhanh_cd"  styles="width:100%"  /></td>
	                                    <td width="70%"><gw:textbox id="txtchinhanh_nm"  styles="width:100%"  /></td>
	                                    <td align="left"><gw:imgBtn id="ibtnSearch2" img="reset"  onclick="txtchinhanh_cd.text='';txtchinhanh_nm.text='';"/></td>
	                                </tr>
	                            </table>
		                   </td>
	                        <td></td>
	                  </tr>

	            </table>
	        </fieldset>
	    </td>
	</tr>
	
	
	<tr style="height:90%;width:100%" >
		<td style="background:white;width:38%"   id="t-left">
		            
		                   
		                   <gw:grid
				             id="GridLeft"				
				            header  ="|Ngày|Chinhánh|Loạigiaodịch|Trịgiá|trongnước_HOSE|nướcngoài_HOSE|tựdoanh_HOSE|trongnước_HNX|nuocngoai_HNX|tudoanh_HNX|trongnuoc_UP|nuocngoai_UP|tudoanh_UP|_tr_code|_brch_code|_trd_dt"
				            format  ="4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
				            aligns  ="1|1|0|0|3|3|3|3|3|3|3|3|3|3|0|0|0"
				            defaults="||||||||||||||||"
				            editcol ="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"
				            widths  ="1600|1600|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0"
				            styles  ="width:100%; height:100%"		
				            acceptnulldate="T"	
				            sorting ="T" oncellclick="OnClick()"  />     
		                  
		                
		</td>
		<td style="width: 2%; white-space: nowrap;" align="center">
                    <img status="expand" id="imgArrow1" src="../../../system/images/button/previous.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('1')" />
                    <img status="expand" id="imgArrow2" src="../../../system/images/button/next.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('2')" />
        </td>
        <td style="background:white;width:60%"  id="t-right">
			<gw:grid
				id="GridRight"				
				header  ="Người đầu tư|Số tài khoản|stt (gdịch)|Trị giá|Số chứng từ(BOS)|Số tài khoản NH(Nợ)|Tên ngân hàng(Nợ)|Số tài khoản NH(Có)|Tên ngân hàng(Có)"
				format  ="0|0|0|0|0|0|0|0|0"
				aligns  ="0|1|1|3|0|0|0|0|0"
				defaults="||||||||"
				editcol ="1|1|1|1|0|1|1|1|0"
				widths  ="2500|1500|1000|2000|2000|3000|3000|3000|3000"
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

<gw:textbox id="txtLoai_gd_cd1" styles='width:100%;display:none' />   
<gw:textbox id="dtTu_ngay1" styles='width:100%;display:none' />   
<gw:textbox id="txtchinhanh_cd1" styles='width:100%;display:none' /> 

</body>
</html>
