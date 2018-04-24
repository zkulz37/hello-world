<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script>
function BodyInit()
{
    BindingDataList();
    dat_grid.Call("SELECT");
    
}
//---------------------------------------------------------------------------------------
function BindingDataList()
{
    var ls_Company    = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    var ls_Trantype = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0004') FROM DUAL")%>|All|--- Tất cả ---";
    var ls_Status = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('GFQC0013') FROM DUAL")%>|All|--- Tất cả ---";
    lstCompany.SetDataText(ls_Company);
	lstCompany.SetDataText("2");
	lstCompany.SetEnable(false);
    lstTrantype.SetDataText(ls_Trantype);
    lstTrantype.value= "All";
    lstStatus.SetDataText(ls_Status);
    lstStatus.value="All";
    
   <%=ESysLib.SetGridColumnComboFormat("idgrid",2,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0004' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("gridDetail",4,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0005' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("gridDetail",3,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0011' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("gridDetail",2,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0012' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("idgrid",18,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0012' and a.del_if = 0 and b.del_if = 0")%>;
    <%=ESysLib.SetGridColumnComboFormat("gridDetail",9,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0017' and a.del_if = 0 and b.del_if = 0")%>;
    
    <%=ESysLib.SetGridColumnComboFormat("idgrid",19,"SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'GFQC0011' and a.del_if = 0 and b.del_if = 0")%>;
	 gridDetail.GetGridControl().FrozenCols = 5;
	 idgrid.GetGridControl().FrozenCols = 3;
}
//---------------------------------------------------------------------------------------
function OnAddnew(obj)
{
    switch(obj)
    {
        case 1:
            idgrid.AddRow();
            idgrid.SetGridText(idgrid.rows - 1, 16, lstCompany.value);
        break;
        case 2:
            if(txt_pk.text !="")
            {
                gridDetail.AddRow();
                gridDetail.SetGridText( gridDetail.rows - 1, 17, txt_pk.text); 
                gridDetail.SetGridText( gridDetail.rows - 1, 2, idgrid.GetGridData(idgrid.row, 18)); 
            }
            else
            {
                alert("Please select row master!!");
            }
        break;
    }
    
    
}
//---------------------------------------------------------------------------------------
function OnSearch(obj)
{
    switch(obj)
    {
        case 1:
             DSO_Trans.Call("SELECT");
        break;
        case 2:
             DSO_Detail.Call("SELECT");
        break;
    }
    
    
}
//-------------------------------------------------------------------------------
function OnSelect()
{
            if(event.col!=17 && event.col!=18)
            {
                 txt_pk.SetDataText(idgrid.GetGridData(idgrid.row,0));
            
                flag='search';
                dat_griddetail.Call('SELECT');
            }
           
}
//---------------------------------------------------------------------------------------
function OnDelete(obj)
{
    switch(obj)
    {
        case 1:
            if(gridDetail.rows>1)
            {
                alert("Please delete all rows detail!!");
            }
            else if(confirm("Are you sure you want to delete!!"))
            {
               
                idgrid.DeleteRow();
            }
        break;
        case 2:
            if(confirm("Are you sure you want to delete!!"))
            {
                gridDetail.DeleteRow();
            }
        break;
    }
     
}
function Checked()
{
    if(event.col == 6)
    {
        var l_chk = idgrid.GetGridData(idgrid.row, 6);
        if(l_chk == "-1")
        {
            idgrid.SetColEdit(5,1);
            
        }
        else if(l_chk == "0")
        {
            idgrid.SetColEdit(5,0);
        }
    }
}
//---------------------------------------------------------------------------------------
function OnSave(obj)
{
   switch(obj)
   {
        case 1:
            dat_grid.Call();
        break;
        case 2:
            dat_griddetail.Call();
        break;
   }
        
}

//---------------------------------------------------------------------------------------
function PopUp(obj)
{
    switch(obj)
    {
        case 1:
            if(idgrid.col=="9")
            {
                var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	            var object = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes'); 
                if ((object != null) &&(object[0]!="0"))
                {
                            
                    idgrid.SetGridText( idgrid.row, 14, object[3]);    //ACPK
	                idgrid.SetGridText( idgrid.row, 9, object[0]);    //Account Code
                    idgrid.SetGridText( idgrid.row, 10, object[1]);    //Account Name
                   
                }
            }
       break;
       case 2:
            if(idgrid.col=="11")
            {
                var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_PL";
	            var object = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes'); 
                if ((object != null) &&(object[0]!="0"))
                {
                            
                    idgrid.SetGridText( idgrid.row, 15, object[3]);    //ACPK
	                idgrid.SetGridText( idgrid.row, 11, object[0]);    //Account Code
                    idgrid.SetGridText( idgrid.row, 12, object[1]);    //Account Name
                   
                }
            }
       break;
       case 3:
              if(idgrid.col=="3")
              {
                  //var aa = idgrid.GetGridData(idgrid.row, 2);
                  //alert(aa);
                    if(idgrid.GetGridData(idgrid.row, 2) == 'CIO')
                    {
                            var fpath = System.RootURL + "/form/gf/os/gfos00050_popup.aspx?";
	                         var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                            if (object != null)
                            {
                                        
                                idgrid.SetGridText( idgrid.row, 3, object[1]);    //Account Code
                                idgrid.SetGridText( idgrid.row, 4, object[2]);    //Account Name
                               
                            }
                           
                    }
                    else
                    {
                         var fpath = System.RootURL + "/form/gf/os/gfos00050_popup_1.aspx?";
	                         var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                            if (object != null)
                            {
                                        
                                idgrid.SetGridText( idgrid.row, 3, object[1]);    //Account Code
                                idgrid.SetGridText( idgrid.row, 4, object[2]);    //Account Name
                               
                            }
                    }
              }
       break;
	  case 4:
		var path    = System.RootURL + '/form/gf/os/gfos00070_popup_3.aspx';
		var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
		if ( object != null )
		{
			
			
					txtMagiaodich.text = object[1]+ " - " + object[2];
					//txtLoaiGD_pk.text = object[3];
			
		 }
	 break;
	 //---------------popup acc_dr detail-----
	 case 5:
	     if(gridDetail.col=="5")
            {
                var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_ALL";
	            var object = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes'); 
                if ((object != null) &&(object[0]!="0"))
                {
                            
                    gridDetail.SetGridText( gridDetail.row, 13, object[3]);    //ACPK
	                gridDetail.SetGridText( gridDetail.row, 5, object[0]);    //Account Code
                    gridDetail.SetGridText( gridDetail.row, 6, object[1]);    //Account Name
                   
                }
            }
	 break;
	 //---------------popup acc_cr detail-----
	 case 6:
	     if(gridDetail.col=="7")
            {
               var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + lstCompany.value+'' + "&dsqlid=ACNT.SP_SEL_ACCD_ALL";
	            var object = System.OpenModal( fpath , 800 , 550 , 'resizable:yes;status:yes'); 
                if ((object != null) &&(object[0]!="0"))
                {
                            
                    gridDetail.SetGridText( gridDetail.row, 14, object[3]);    //ACPK
	                gridDetail.SetGridText( gridDetail.row, 7, object[0]);    //Account Code
                    gridDetail.SetGridText( gridDetail.row, 8, object[1]);    //Account Name
                   
                }
            }
	 break;
	 case 7:
	     if(gridDetail.col=="11")
         {
	            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		        var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		        if ( object != null )
		        {
		            if (object[0] != 0)
                    {
                       
                        gridDetail.SetGridText( gridDetail.row, 15, object[0]);    //ACPK
                        gridDetail.SetGridText( gridDetail.row, 11, object[2]); //name
                       
      	            }
		         }  
		 }     
	 break;
	 case 8:
	     if(gridDetail.col=="12")
         {
	            var path = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		        var object = System.OpenModal( path ,800 , 600 , 'resizable:yes;status:yes');
		        if ( object != null )
		        {
		            if (object[0] != 0)
                    {
                       
                        gridDetail.SetGridText( gridDetail.row, 16, object[0]);    //ACPK
                        gridDetail.SetGridText( gridDetail.row, 12, object[2]); //name
                       
      	            }
		         }  
		 }     
	 break;
	 case 9:
	            var path    = System.RootURL + '/form/gf/os/gfos00100_popup.aspx';
			var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
			if ( object != null )
			{
				
				
						txtchinhanh_cd.text = object[1];
						txtchinhanh_nm.text = object[2];
						txtchinhanh.text = object[3];
						
			 }
	 break;
	 case 10:
	         var fpath = System.RootURL + "/form/gf/os/gfos00050_popup.aspx?";
	            var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
                if (object != null)
                {
                            
                    txtnganhang_cd.text = object[1];    //Account Code
                    txtnganhang_nm.text = object[2];    //Account Name
                    
                }
	 break;
	 case 11:
	            var path    = System.RootURL + '/form/gf/os/gfos00100_popup.aspx';
			var object  = System.OpenModal( path, 600, 400,'resizable:yes;status:yes');
			if ( object != null )
			{
				
				
						txtchinhanhd_cd.text = object[1];
						txtchinhanhd_nm.text = object[2];
						
			 }
	 break;
	 case 12:
	                if(event.col == 18)
                    {
                           var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                                var object  = System.OpenModal(fpath , 600 , 400 , 'resizable:yes;status:yes');                     
                                if ( object != null )  
                                {                                             
                                       gridDetail.SetGridText( gridDetail.row , 20, object[2]);    //Center PK
                                       gridDetail.SetGridText( gridDetail.row, 18, object[3]+ ' - ' +object[4]);    //Center Name
                                }
                    }
	 break
	 case 13:
	                if(event.col == 19)
                    {
                           var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
                                var object  = System.OpenModal(fpath , 600 , 400 , 'resizable:yes;status:yes');                     
                                if ( object != null )  
                                {                                             
                                       gridDetail.SetGridText( gridDetail.row , 21, object[2]);    //Center PK
                                       gridDetail.SetGridText( gridDetail.row, 19, object[3]+ ' - ' +object[4]);    //Center Name
                                }
                    }
	 break
   }
   
        
}
//------------------------------------------------------------
function OnGetTrans(index)
{
      var scode;
        switch(index)
        {           
            case 3:
                scode='GFQC0004'; // Loai GD
            break;  
            case 4:
                scode='GFQC0012'; // Chi Nhanh
            break;
         }
        txtComCodeID.text = scode;
        var fpath = System.RootURL + "/form/gf/os/gfos00040_popup_1.aspx?code=" + scode ;
       
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
                    case 3:
                        lstTrantype.value=strcodereturn; // LoaiGD
                    break;  
                   
                   
                }            
            }
        }	     
               
}
//-----------------------------------------------------
function HeaderPopup()
{
    alert('sss');

    if(event.row=0)
    {
        alert("asdasd");
    }
    else
    {
        alert(1);
    }
   /* var scode;
        switch(index)
        {           
            case 4:
                scode='GFQC0012'; // Chi Nhanh
                  txtComCodeID.text = scode;
                 alert(event.row);
                 if(gridDetail.col==2 && gridDetail.row==0)
                 
                 {
                    
                    var fpath = System.RootURL + "/form/gf/os/gfos00040_popup_1.aspx?code=" + scode ;
                    var obj = System.OpenModal( fpath , 900 , 600 , 'resizable:yes;status:yes');
                  }
                  
            break;
         } */ 
}
//------------------------------------------------
 function OnLoadNew(scode)
 {	
        datGetNewCode.Call('SELECT');
 }
//--------------------------------------------------
function OnDataReceive(obj)
{
 var strdata = txtCodeTemp.text;
    if(obj.id == 'datGetNewCode')
    {
        switch(indexCode)
		{
		   case 3:
				lstTrantype.SetDataText(strdata);
				lstTrantype.value=strcodereturn;
			break;  
		}
		
    }
    else if(obj.id =='dat_grid')
    {
//          OnSearch();
    }
}
//--------------------------------------------------
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
</script>
<body>
<gw:data id="DSO_Trans" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00050" > 
            <input  >
                <input bind="lstCompany"/>
                <input bind="lstTrantype"/>
			        <input bind="txtMagiaodich"/>
			        <input bind="lstStatus"/>
			        <input bind="txtnganhang_cd"/>
			        <input bind="txtchinhanh_cd"/>
			        <input bind="txtchinhanh"/>
            </input>
            <output bind="idgrid" /> 
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_grid"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19" function="acnt.sp_sel_gfos00050_1" procedure="acnt.sp_upd_gfos00050"   > 
            <input bind="idgrid">                    
                <input bind="txt_pk" /> 
                
                <input bind="lstCompany"/>
                <input bind="lstTrantype"/>
			        <input bind="txtMagiaodich"/>
			        <input bind="lstStatus"/>
			        <input bind="txtnganhang_cd"/>
			        <input bind="txtchinhanh_cd"/>
			        <input bind="txtchinhanh"/>
            </input> 
            <output bind="idgrid"></output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_griddetail"  onreceive="" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="acnt.sp_sel_gfos00050_detail" procedure="acnt.sp_upd_gfos00050_1"   > 
            <input bind="gridDetail">  
                 <input bind="txtchinhanhd_cd"/>                  
                <input bind="txt_pk" /> 

            </input> 
            <output bind="gridDetail"></output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
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
<!-------------------------------------------------------------------------------------------->
<gw:data id="DSO_Detail" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfos00050_3" > 
            <input  >
				        <input bind="txtchinhanhd_cd"/>
				        <input bind="txt_pk" /> 
            </input>
            <output bind="gridDetail" /> 
        </dso> 
    </xml> 
</gw:data>
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
              <fieldset style="padding: 2; width: 100%; height: 100%">
				<table border="0" width="100%" id="table2">
					<tr>
					    <td align="right" width="10%">Công ty</td>
						<td width="35%"><gw:list id="lstCompany"  styles='width:100%' /></td>
						<td align="right" width="20%"><a title="Nhấp vào đây để chọn loại giao dịch" onclick="OnGetTrans(3)" href="#tips" style="text-decoration : none; color=#0000FF">Loại Giao Dịch</a></td>
						<td width="35%"><gw:list id="lstTrantype"  styles='width:100%'/></td>
						<td><gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch(1)" /></td>
						<td><gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" text="Process" onclick="OnAddnew(1)" /></td>
						<td><gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave(1)" /></td>
						<td><gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete(1)" /></td>
					</tr>
					<tr>
					    <td align="right" width="10%">Trạng thái</td>
						<td width="35%"><gw:list id="lstStatus" onchange="OnSearch(1)" styles='width:100%' /></td>

						<td align="right" width="20%"><a title="Nhấp vào đây để chọn mã giao dịch" onclick="PopUp(4)" href="#tips" style="text-decoration : none; color=#0000FF">Mã giao dịch</a></td>
						<td width="35%" colspan="4"><gw:textbox id="txtMagiaodich"  styles='width:100%'  onenterkey="OnSearch(1)"/></td>
						<td align="left"><gw:imgBtn id="ibtnSearch122" img="reset"  onclick="txtMagiaodich.text='';"/></td>
					</tr>
					<tr>
					        <td  align="right"><a title="Nhấp vào đây để hiển thị chi nhánh" onclick="PopUp(9)" href="#tips" style="text-decoration : none; color=#0000FF">Chi nhánh&nbsp;</a></td>
		                   <td >
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
	                                <tr>
	                                    <td width="30%"><gw:textbox id="txtchinhanh_cd"  styles="width:100%"  /></td>
	                                    <td width="70%"><gw:textbox id="txtchinhanh_nm"  styles="width:100%"  /></td>
	                                    <td align="left"><gw:imgBtn id="ibtnSearch2" img="reset"  onclick="txtchinhanh_cd.text='';txtchinhanh_nm.text='';"/></td>
	                                </tr>
	                            </table>
		                   </td>
		                   <td  align="right"><a title="Nhấp vào đây để hiển thị ngân hàng" onclick="PopUp(10)" href="#tips" style="text-decoration : none; color=#0000FF">Ngân hàng&nbsp;</a></td>
		                    <td colspan="5">
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
	                                <tr>
	                                    <td width="30%"><gw:textbox id="txtnganhang_cd"  styles="width:100%"  /></td>
	                                    <td width="70%"><gw:textbox id="txtnganhang_nm"  styles="width:100%"  /></td>
	                                    
	                                    <td align="left"><gw:imgBtn id="ibtnSearch21" img="reset"  onclick="txtnganhang_cd.text='';txtnganhang_nm.text='';"/></td>
	                                </tr>
	                            </table>
		                   </td>
					</tr>
				</table>
			</fieldset>
                       
            </td>
        </tr>
        <tr style="width: 100%; height: 40%" id="t-left">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr id="content" valign="top">
                        <td width="100%">
                            <!-- 0.pk|1.Seq|2.Trans.Type|3.Bank Id|4.Bank Name|5.Code|6.Auto|7.Name|8.Local Name|9.Debit Account|10.Debit Account Name|11.Credit Account|12.Credit Account Name|13.Description|14.debit_Acc|15.credit_Acc|16.tco_company_pk-->

                            <gw:grid id="idgrid" header="_pk|STT|Loại giao dịch|Mã ngân hàng|Tên ngân hàng|Mã giao dịch|_Auto|_Name|Tên giao dịch|Tài khoản nợ|Tên tài khoản|Tài khoản có|Tên tai khoản|Diễn giải|_debit_Acc_pk|_credit_Acc_pk|_tco_company_pk|Kích hoạt|Chi nhánh|Nhà đầu tư"
                                format="0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0|3|0|0" 
                                aligns="0|1|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0" 
                                defaults="|||||||||||||||||||" 
                               editcol="0|0|0|0|0|1|1|1|1|0|0|0|0|1|0|0|0|0|0|0"
                                widths="0|600|1300|1500|2000|1500|500|2000|2000|1500|2500|1500|2500|3000|0|0|0|900|2000|0" 
                                styles="width:100%; height:100%"
                                sorting="T"  onafteredit="" oncelldblclick="PopUp(1);PopUp(2);PopUp(3)" oncellclick="OnSelect()"/>

                            </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width:100%;height:5%">
               <td>
                <fieldset>
                    <table style="width: 100%; height: 100%">
                        <tr>
                            <td width="8%">
                                 <img status="expand" id="imgArrow1" src="../../../system/images/button/icons_button/up.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('1')" />
                    <img status="expand" id="imgArrow2" src="../../../system/images/button/icons_button/down.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('2')" />
                            </td>
                            <td width="4%" align="left">
                                Detail</td>
                            <td width="18%">
                            </td>
                            <td  align="right" width="20%"><a title="Nhấp vào đây để hiển thị chi nhánh" onclick="PopUp(11)" href="#tips" style="text-decoration : none; color=#0000FF">Chi nhánh&nbsp;</a></td>
		                   <td  width="70%">
		                        <table style="width:100%" cellpadding="0" cellspacing="0">
	                                <tr>
	                                    <td width="30%"><gw:textbox id="txtchinhanhd_cd"  styles="width:100%"  readonly="true"/></td>
	                                    <td width="70%"><gw:textbox id="txtchinhanhd_nm"  styles="width:100%"  readonly="true"/></td>
	                                    <td align="left"><gw:imgBtn id="ibtnSearch24" img="reset"  onclick="txtchinhanhd_cd.text='';txtchinhanhd_nm.text='';"/></td>
	                                </tr>
	                            </table>
		                   </td>
                            <td>
                                <gw:imgbtn id="ibtnUpdate11" img="search" alt="Search" onclick="OnSearch(2)" />
                            </td>
                            <td>
                                <gw:imgbtn id="ibtnReset1" img="new" alt="new" onclick="OnAddnew(2)" />
                            </td>
                            <td>
                                <gw:imgbtn id="ibtnDelete1" img="delete" alt="delete" onclick="OnDelete(2)" />
                            </td>
                            <td>
                                <gw:imgbtn id="ibtnUpdate1" img="save" alt="save" onclick="OnSave(2)" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr id="t-right" valign="top" style="width:100%;height:40%">
             <td width="100%">
                            <!-- 0._pk|1.STT|2.Chi nhanh|3.Nha đau tu|4.San giao dich|5.Tai khoan no|6.Ten tai khoan no|7.Tai khoan co|8.Ten tai khoan co|9.Gia tri mua ban|10.Dien giai|11.Khach hang(No)|12.Khach hang(Co)|13._debit_Acc_pk|14._credit_Acc_pk|15._debit_cus_pk|16.credit_cus_pk|17.mst_pk|18.Phòng ban(Nợ)|19.Phòng ban(Có)|20.cost_center_pk(no)|21.cost_center_pk(co)"-->

                            <gw:grid id="gridDetail" header="_pk|STT|Chi nhánh|Nhà đầu tư|Sàn giao dịch|Tài khoản nợ|Tên tài khoản nợ|Tài khoản có|Tên tài khoản có|Giá trị mua bán|Diễn giải|Khách hàng(Nợ)|Khách hàng(Có)|_debit_Acc_pk|_credit_Acc_pk|_debit_cus_pk|_credit_cus_pk|_mst_pk|Phòng ban(Nợ)|Phòng ban(Có)|_cost_center_pk(no)|_cost_center_pk(co)"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                aligns="0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                defaults="|||||||||||||||||||||" 
                               editcol="0|1|1|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0"
                                widths="0|600|1500|1500|2000|2000|2500|2000|2500|1500|3000|2500|2500|0|0|0|0|0|3500|3500|0|0" 
                                styles="width:100%; height:100%"
                                sorting="T"   oncelldblclick="PopUp(5);PopUp(6);PopUp(7);PopUp(8);PopUp(12);PopUp(13)" onbeforesort=""/>

                            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
    <gw:textbox id="txtComCodeID"  text=""  styles='display:none'  />
    <gw:textbox id="txtCodeTemp"  text=""  styles='display:none'  />
	<gw:textbox id="txtchinhanh"  text=""  styles='display:none'  />
	
   </body>
</html>
