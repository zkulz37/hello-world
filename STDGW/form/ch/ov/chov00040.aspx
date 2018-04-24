<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
/*grdRegister*/
 var 
    v_aprove_status_nm = 10,
     v_card_type = 11,
     v_approve_status = 17,
     v_vis_status = 18,
     v_ga_response = 19 
/*grdRegister*/
/*property grid*/
var v_parent_pk =1;

/*property grid*/
var check_inout =1;

/*mang visitor info mation*/
var arr_obj = new Array()

var p_update = 0 ;
var flag_refresh = 0;
var svis_register_pk=""
function BodyInit()
{
	OnFormDefault()
	//Reset
	datRegiser.StatusInsert();
    lstCardType.value="";
    txtVstNo.text = 1;
    idBtnCheckIn.SetEnable(false)
    idBtnCheckOut.SetEnable(false)
    svis_register_pk = "<%=Request.querystring("p_vis_register_pk")%>";  
	if (svis_register_pk!="")
	{
	    IsPopup()
	}
	else
	{
	    set_Interval(20000) ;
	}
}
function IsPopup()
{
    idSearch1.style.display="none"
	idSearch2.style.display="none"
	idBtnCheckIn.SetEnable(false)
    idBtnCheckOut.SetEnable(false)
    idBtnNew.style.display="none"
    idBtnDel.style.display="none"
    idBtnSave.style.display="none"
    idReport.style.display="none"
    idBtnNewP.style.display="none"
    idBtnDelP.style.display="none"
    idBtnDelUP.style.display="none"
    txtRegisPK.text=svis_register_pk;
    datRegiser.Call("SELECT");
}
function OnFormDefault()
{
    
    txtOutTime.SetEnable(false)
    txtInTime.SetEnable(false)
    lstCardType.SetEnable(false)
    txtVstNm.SetEnable(false)
    txtVstID.SetEnable(false)
    
    idBtnCheckIn.SetEnable(false)
    idBtnCheckOut.SetEnable(false)
    txtDateIn.SetEnable(false)
    txtDateOut.SetEnable(false)
    
    txtCardID.SetEnable(false)
    txtCardName.SetEnable(false)
    
    grdRegister.GetGridControl().FrozenCols = 4;
    
   var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0121' order by code")%>";
    grdRegister.SetComboFormat(v_card_type,t1);
    datSearchRegister.Call('SELECT');
    
}
/*--------------------------------------------------------*/
function OnSearch(obj)
{
    if(obj==1) /*List of register*/
    {
        datSearchRegister.Call('SELECT');
        flag_refresh = 0;
    }
}
/*--------------------------------------------------------*/
function OnClickRegister()
{
    txtRegisPK.text = grdRegister.GetGridData(grdRegister.row,0)
    OnShowNote();
    datRegiser.Call('SELECT')
}
function OnReset(obj)
{
    datRegiser.StatusInsert();
    txtVstNo.text = 1;
    if (obj==1)
        txtAppStatus.text="01"
    idBtnCheckIn.SetEnable(false)
    idBtnCheckOut.SetEnable(false)
    grdProperty.ClearData();
    if (arr_obj != null)
	{
	    if (obj==1)
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
        }
        else
        {
            txtVstPK.text = arr_obj[1];
			txtVstCompPk.text = arr_obj[10];
			txtVstComp.text = arr_obj[11];
			txtVstID.text = arr_obj[3];
			txtVstNm.text = arr_obj[2];			
			lstSEX.value    = arr_obj[4];
			
			txtTel.text     = arr_obj[5];			
			txtVehicle.text = arr_obj[14];
			txtContTo.text = arr_obj[6];
			txtPosition.text = arr_obj[7];
			txtDept.text = arr_obj[12];	
			txtReasonCont.SetDataText(arr_obj[13]);
			txtVstTime.text= arr_obj[9];	
			txtDateIn.value=arr_obj[8];	
			txtVis_App_PK.text=arr_obj[0];	
			lstCardType.value=arr_obj[15];
			txtAppStatus.text=arr_obj[18];
			datWorkDateFr.value=arr_obj[8];	
        }
    }
    
}
function OnSave(pos)
{
    flag_refresh = 1;
    switch (pos)         
      {		        
            case 1 :
                if(txtVstPK.text =="")
                {
                    alert("Please select Visitor! \n (Vui lòng chọn thông tin khách)!")
                }else if(txtContTo.text =="" && txtDept.text=="" && txtPosition.text =="")
                {
                    alert("Please input contact infomation! \n (Vui lòng nhập thông tin của ngừơi cần liên hệ!)!")
                }else{
                     p_update = 1 ;
                    datRegiser.Call();
                   
                 }
            break;
            
            case 2 :
                datProperty.Call();
             break;
      }  
}
function OnDelete(obj)
{
    if(obj==1) //delete master
    {
        
         if(txtRegisPK.text!="")
            {
                if(confirm("Are you sure you want to delete this Visitor! \n(Bạn thật sự muốn xoá thông tin này!)"))
                {
                    datRegiser.StatusDelete();
                     p_update = 1 ;
                    datRegiser.Call()
                }
             }
    }else
    {
        var ctrl = grdProperty.GetGridControl();

	    var row  = ctrl.row;
    		
	    if ( row < 0 ) 
	    {			
			    alert("Please select one row to delete .");
	    }			
	    else 
	    {
		    if ( grdProperty.GetGridData( ctrl.row, 0 ) == "" ) 
	        {						
    		
				    grdProperty.RemoveRow();					
		    }			
		    else 
		    {
			    if ( confirm( "Do you want to mark this row to delete?" ) ) 
			    {
				    grdProperty.DeleteRow();
			    }
		    }
	    }
    }
}
function OnGateCheck(obj)
{
    check_inout = obj;
    if (txtAppStatus.text =='02')
    {
         if(txtVisStatus.text =="" )
        {
             dtDateCheckin.SetDataText(txtDateIn.value)
             if(txtCardPK.text=="")
             {
                alert("Please select a card for visitor! \n(Vui lòng cấp thẻ cho khách để vào cty)!")
                return;
             }
        }
        else
        {
                 dtDateCheckin.SetDataText(txtOutTime.text)
        }
        
        var str_cf ="" 
        if ( check_inout==1)
        {
            str_cf =" Check In";
        }else
        {
            str_cf =" Check Out";
        }
       if(confirm("Do you want to " + str_cf +" ? \n (Bạn thật sự muốn "+ str_cf +" ?)" ))
         {   
             datVisitorGateCheck.Call()
        }
        
    }else
    {
        alert("Visitor invalid state to check in!\n (Khách này chưa được đồng ý vào cty!)");
    }
}
/*--------------------------------------------------------*/
function OnDataReceive(obj)
{
    if(obj.id=="datSearchRegister")
    {
        lblRecord.text=grdRegister.rows-1 + " record(s)";
        grdRegister.GetGridControl().AutoSize(0,grdRegister.cols-1,false,0);
        GridColor()
    }else if(obj.id=="datRegiser")
    {
        if(txtAppStatus.text == '02' && svis_register_pk=="")
        {
            if(txtVisStatus.text == "")
            {
                idBtnCheckIn.SetEnable(true)
                idBtnCheckOut.SetEnable(false)
            }
            else if (txtVisStatus.text == "I")
            {
                idBtnCheckIn.SetEnable(false)
                idBtnCheckOut.SetEnable(true)
            }else
            {
                idBtnCheckIn.SetEnable(false)
                idBtnCheckOut.SetEnable(false)
            }
        }
        else
        {
            idBtnCheckIn.SetEnable(false)
            idBtnCheckOut.SetEnable(false)
        }
          if ( p_update == 1 )
            {
                p_update = 0 ;
                SetParentPKtoGrid();
                OnSave(2)
                
            }
            else
            {
                
                flag_refresh = 0;
                datProperty.Call('SELECT')
            }

    }else if(obj.id =="datProperty" && flag_refresh== 1)
    {
        flag_refresh= 0
       datSearchRegister.Call("SELECT")
    }else if(obj.id =="datVisitorGateCheck")
    {
        //alert(lblCheckResult.text)
       if(check_inout ==1)
       {
        idBtnCheckIn.SetEnable(false)
        }
        else
        {
        idBtnCheckOut.SetEnable(false)
        }
        OnSearch(1)
    }else if(obj.id =="data_CheckExist")
    {
        if(txtRegistPKTemp.text !="")
        {
            alert("Already Register! \n(Khách này đã đăng ký rồi!)")
            txtRegisPK.text = txtRegistPKTemp.text
            datRegiser.Call('SELECT')
        }else
        {
            OnReset(1)
        }
    }
    else if (obj.id=="data_CheckExist_Vis_App")
    {
        if(txtRegistPKTemp.text !="")
        {
            alert("Already Register! \n(Khách này đã đăng ký rồi!)")
            txtRegisPK.text = txtRegistPKTemp.text
            
            datRegiser.Call('SELECT')
        }
        else
        {
            OnReset(2)
        }
    }
}
function GridColor()
{
    for(var i =1 ; i<grdRegister.rows; i++)
    {
        var temp = grdRegister.GetGridData(i,v_approve_status)
        var temp1 = grdRegister.GetGridData(i,v_vis_status)
        if(temp == "02")
        {
            if(temp1 =="I")//da cap the
            {
                 grdRegister.SetCellBgColor( i, 0 , i, grdRegister.cols-1 , 0x99FFFF ); //vàng
            }else if(temp1 =="O")
            {
                grdRegister.SetCellBgColor( i, 0 , i, grdRegister.cols-1 , 0xFFCCCC );//xám 0xFFCCCC
            }else
            {
                grdRegister.SetCellBgColor( i, 0 , i, grdRegister.cols-1 , 0x99FF66 );//xanh0x66FF00
            }
            
        }else if(temp == "03")
        {
              grdRegister.SetCellBgColor( i, 0 , i, grdRegister.cols-1 , 0x9999FF ); // hong0xff99ff  do0x6666FF deny
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
    else if(obj==2) /*cấp thẻ compop01.aspx?*/
    {
       var fpath = System.RootURL + "/form/ch/ov/chov00010_popup.aspx?mSelect=" + "false" + "&popTitle=" + "List of Visitor Card" + "&dsqlid=HR.SP_SEL_VISITOR_LIST_USED&cardtype="+lstCardType.value;
		var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 

		if ((object != null))
		{
			txtCardPK.text = object[0];
			txtCardID.text = object[1];
			txtCardName.text = object[2];
			//lstCardType.value = object[3];
		}
		else 
		{
			txtCardPK.text = "";
			txtCardID.text = "";
			txtCardName.text = "";
		}
    }
    else if(obj==3) /*tìm kiếm cuộc hẹn vistor appointment*/
    {
        var fpath = System.RootURL + "/form/ch/ov/chov00070.aspx?popup_yn=Y&p_ga_approval=02";
		arr_obj = System.OpenModal( fpath , 800 , 600 , 'resizable:yes;status:yes'); 

		if (arr_obj != null)
		{
			txtVstPK.text = arr_obj[1];
			txtVstCompPk.text = arr_obj[10];
			txtVstComp.text = arr_obj[11];
			txtVstID.text = arr_obj[3];
			txtVstNm.text = arr_obj[2];			
			lstSEX.value    = arr_obj[4];
			
			txtTel.text     = arr_obj[5];			
			txtVehicle.text = arr_obj[14];
			txtContTo.text = arr_obj[6];
			txtPosition.text = arr_obj[7];
			txtDept.text = arr_obj[12];	
			txtReasonCont.SetDataText(arr_obj[13]);
			txtVstTime.text= arr_obj[9];	
			txtDateIn.value=arr_obj[8];	
			txtVis_App_PK.text=arr_obj[0];	
			lstCardType.value=arr_obj[15];
			txtAppStatus.text=arr_obj[18];
			datWorkDateFr.value=arr_obj[8];	
		
			if(txtVstPK.text != "")
			{
			    data_CheckExist_Vis_App.Call();
			}
			
		}
    }
}
/*popup*/
//------------------------------------------------------------------
 
 function SetParentPKtoGrid()
 {
        for ( i = 1; i < grdProperty.rows ; i++ )
        {
            if ( grdProperty.GetGridData(i,v_parent_pk) == "" )
            {
                grdProperty.SetGridText( i ,v_parent_pk , txtRegisPK.text ) ;
            }
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
//
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("CheckSearch()",x);
}
function CheckSearch()
{
    if (System.Menu.IsActive("Visitor Register"))
        OnSearch(1)
        
}
//-----------
function OnReport()
{
   var url =System.RootURL + '/reports/ch/ov/rpt_gate_in_out_register.aspx?l_visitor_pk=' + txtRegisPK.text ;
    window.open(url);                    
}
/******************************************************************************/
function OnShowNote()
{
    if(grdRegister.GetGridData(event.row,v_approve_status)=="03")
    {
       var p_note=grdRegister.GetGridData(event.row,v_ga_response);
        if (p_note=="")
        {
            p_note="Kh&#244;ng c&#243; l&#253; do!";
        }
        oPopup = window.createPopup();
        oPopup.document.write("<body style='background-color:eaf8ff;margin:0 0 0 0;border: 1 solid #6b9eb8;'><div>"+ p_note +"</div></body>");
        var pos = new Object();
        FindPos( event.srcElement, pos );
        oPopup.show( pos.x + 1200 ,pos.y  + 20 + event.row*20, 200, 100, document.body );  
    }
   
}
function FindPos( obj , posinfo )
{

	var pobj ;
	
	var x = 0  , y = 0 ;
	
	
	pobj = obj;
	
	while ( pobj )
	{
		x += pobj.offsetLeft;
		y += pobj.offsetTop;
		
		// alert( pobj.offsetLeft + "="+pobj.outerHTML );
		
		if ( pobj != obj && pobj.offsetParent && pobj.tagName != "TABLE")
		{
			// alert( pobj.clientLeft + ":" + pobj.clientTop + "/" + pobj.offsetLeft + "="+pobj.outerHTML);
			x += pobj.clientLeft;
			y += pobj.clientTop;
			
		}
		pobj = pobj.offsetParent;	
	}

	
	posinfo.x = x;
	posinfo.y = y;
	posinfo.width = obj.offsetWidth;
	posinfo.height = obj.offsetHeight;
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
            <dso  type="process" procedure="hr.sp_pro_vis_check_exist " > 
                <input>
                     <input bind="txtVstPK" /> 
                     <input bind="txtDateIn" /> 
                </input> 
                <output> 
                    <output bind="txtRegistPKTemp" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------tim pk cua register--------------------------------->
    <gw:data id="data_CheckExist_Vis_App" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_vis_reg_app " > 
                <input>
                     <input bind="txtVis_App_PK" /> 
                </input> 
                <output> 
                    <output bind="txtRegistPKTemp" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------>
<gw:data id="datRegiser" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25" function="HR.SP_SEL_VIS_REGISTer" procedure="HR.SP_upd_VIS_REGISTer"> 
                <inout>
                    <inout bind="txtRegisPK" /> 
                    <inout bind="txtVstPK" /> 
                    <inout bind="txtVstNm"/>
                    <inout bind="txtVstID"/>
                    <inout bind="lstSEX"/>
                    <inout bind="txtTel"/>
                    
                    <inout bind="txtVstNo"/>
                    <inout bind="txtVehicle"/>
                    <inout bind="txtVstCompPk"/>
                    <inout bind="txtVstComp"/>
                    <inout bind="txtContTo"/>
                    <inout bind="txtPosition"/>
                    
                    <inout bind="txtDept"/>
                    <inout bind="txtVstTime"/>
                    <inout bind="txtReasonCont"/>
                    <inout bind="txtCardPK"/>
                    <inout bind="txtCardID"/>                    
                    <inout bind="txtCardName"/>
                    
                    <inout bind="lstCardType"/>
                    <inout bind="txtDateIn"/>
                    <inout bind="txtInTime"/>
                    <inout bind="txtDateOut"/>                    
                    <inout bind="txtOutTime"/>
                    
                    <inout bind="txtVisStatus"/>
                    <inout bind="txtAppStatus"/>
                    
                    <inout bind="txtVis_App_PK"/>
               </inout> 
            </dso> 
        </xml> 
</gw:data>
<!---------------------------------------------------------->
    <gw:data id="datSearchRegister" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR.SP_SEL_VISITOR_IN_OUT_INFO" > 
                <input bind="grdRegister">
                    <input bind="datWorkDateFr" /> 
                    <input bind="lstApproveStatus" /> 
                    <input bind="txtSearchInfo" /> 
                </input> 
                <output bind="grdRegister"/>
            </dso> 
        </xml> 
    </gw:data>
<!---------------------------------------------------------->
    <gw:data id="datProperty" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR.SP_SEL_VIS_PROPERTY" procedure="HR.sp_upd_vis_property" parameter="0,1,2,3,4,5"> 
                <input bind="grdProperty">
                    <input bind="txtRegisPK" /> 
                 </input> 
                <output bind="grdProperty"/>
            </dso> 
        </xml> 
    </gw:data>
 <!---------------------------------------------------------->

    <gw:data id="datVisitorGateCheck" onreceive="OnDataReceive(this)"  > 
            <xml> 
                <dso  type="process" procedure="HR.SP_PRO_VIS_CHECKIN_OUT" > 
                    <input>
                        <input bind="txtRegisPK" />
					    <input bind="txtCardPK" />
					    <input bind="dtDateCheckin" />
                    </input> 
                    <output>
                        <output bind="lblCheckResult" />
                    </output>
                </dso> 
            </xml> 
    </gw:data>

<table cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;"> 
    <tr style="height:5%">
            <td style="width:80%" ></td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnNew" alt="New" img="New"  onclick="OnReset(1)"  styles="display:none"/>
            </td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnDel" alt="Delete" img="Delete"  onclick="OnDelete(1)" />
            </td>
            <td width="2%" align="right">
                <gw:imgBtn id="idBtnSave" alt="Save" img="Save"  onclick="OnSave(1)" /> 
            </td>
            <td style="width:5%" >
                 <gw:imgBtn id="idReport" alt="Print" img="excel"  onclick="OnReport()" /> 
            </td>
                            
        </tr>
	<tr width="100%" style="height:44%">
		<td width="50%" colspan='5'>
			<fieldset style="width:100%;height:100%" >
				<table cellpadding="1" cellspacing=0 border=0 style="height:100%">
					<tr  style="height:5%">
						<td style="width:10%" colspan="2" align=right >Name <i> (Họ Tên)</i> </td>
                        <td style="width:22%" colspan="5">
                            <gw:textbox id="txtRegisPK"  text="" 	 styles='width:100%;display:none'    />
                            <gw:textbox id="txtVstPK"  text="" 	 styles='width:100%;display:none'    />
                            <gw:textbox id="txtVstNm"  text="" 	 styles='width:100%;' csstype="mandatory"   />
                        </td>
						<td style="width:3%"  align = "left">
						    <gw:imgBtn img="popup" id="btnVisitList"   alt="Chọn khách"  onclick="OnPopup(1)"/>
						</td>
						<td style="width:3%"  align=left ><gw:imgBtn img="popup" id="btnVisitApp"   alt="Chọn khách hẹn trước"  onclick="OnPopup(3)"/></td>
						<td style="width:7%"  align=right >ID <i> (CMND)</i> </td>
                        <td style="width:15%" colspan="3">
                             <gw:textbox id="txtVstID"  text="" 	 styles='width:100%;'   />
                        </td>
                        <td style="width:10%" colspan="2" align=right > Sex <i>(Giới tính)</i> </td>
                        <td style="width:10%" colspan="2">
                            <gw:list  id="lstSEX"  styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>
                                </data>
                                </gw:list>
                        </td>
                        <td  style="width:5%" align=right > Tel<i>(ĐT)</i> </td>
                        <td style="width:15%" colspan="3">
                             <gw:textbox id="txtTel"  text="" 	 styles='width:100%;'   />
                        </td>					
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align=right >Total <i> (Số khách)</i> </td>
                        <td style="width:20%" colspan="4">
                            <gw:textbox id="txtVstNo"  text="1" 	 styles='width:50%;'   />
                        </td>
                        
                        <td style="width:15%" colspan="4" align=right >Vehicle<i>(Số Xe)</i> </td>
                        <td style="width:15%" colspan="3">
                            <gw:textbox id="txtVehicle"  	 styles='width:100%;'   />
                        </td>
                         <td style="width:10%" colspan="2" align=right >Company<i>(Cty)</i> </td>
                        <td style="width:30%" colspan="6">
                            <gw:textbox id="txtVstCompPk"   	 styles='width:100%;display:none'   />
                            <gw:textbox id="txtVstComp"   	 styles='width:100%;'   />
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
                       <td style="width:40%" colspan="8" rowspan="5">
                            <fieldset style="width:100%;height:100%">
                            <table border="0" style="height:100%; width:100% ">
                                <tr style="height:5%; width:100%" >
                                    <td style="width:85%">
                                        <gw:label text='Property <i>(Vật mang theo)</i>'></gw:label>
                                    </td>
                                    <td style="width:5%"><gw:imgBtn id="idBtnNewP" alt="Add Property" img="New"  onclick="grdProperty.AddRow()" />
                                    </td> 
                                    <td style="width:5%"> <gw:imgBtn id="idBtnDelP" alt="Delete" img="Delete"  onclick="OnDelete(2)" /></td>
                                    <td style="width:5%"> <gw:imgBtn id="idBtnDelUP" alt="Un Delete" img="UDelete"  onclick="grdProperty.UnDeleteRow()" /></td>
                                </tr>
                                <tr style="height:100%">
                                    <td colspan="4" style="width:100%;height:100%" >
                                         <gw:grid id='grdProperty'
                                            header='_PK|_THR_VISITOR_REGISTER_PK|Mô Tả(Tên Đồ Vật)|Số Lượng|Số Serial|Mục đích sử dụng'
                                            format='0|0|0|1|0|0'
                                            aligns='0|0|0|0|0|0'
                                            defaults='|||||'
                                            editcol='1|1|1|1|1|1'
                                            widths='0|0|1500|1000|1000|1500'
                                            sorting='T'
                                            styles='width:100%; height:100%'
                                            />
                                    </td>
                                </tr>
                            </table>
                           </fieldset>
                       </td>                        
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align="right" >Dept<i>(Phòng ban)</i> </td>
                        <td style="width:25%" colspan="6">
                           <gw:textbox id="txtDept"  	 styles='width:100%;'   />
                        </td>
                        <td style="width:10%" colspan="2" align="right" >Time<i>(Giờ)</i>  </td>
                        <td style="width:15%" colspan="3">
                            <gw:textbox id="txtVstTime"  	 styles="width:100%;"   />
                        </td>
                        
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align=right >Reason<i> (Lý do)</i> </td>
                        <td style="width:50%" colspan="11">
                            <gw:textarea id="txtReasonCont" 	 styles='width:100%;'   />
                        </td>
                    </tr>
					<tr>
                       <td style="width:10%" colspan="2" align=right >Card ID<i> (Số thẻ)</i> </td>
                       <td style="width:10%" colspan="2" ><gw:textbox id="txtCardID"  text="" 	 styles='width:100%'    /> </td>
                        <td style="width:12%" colspan="3">
                            <gw:textbox id="txtCardPK"  text="" 	 styles='width:100%;display:none'    />
                            <gw:textbox id="txtCardName"  text="" 	 styles='width:100%;'   />
                        </td>
						<td style="width:3%" align = "left">
						    <gw:imgBtn img="popup" id="btnCardList"   alt="Select Card"  onclick="OnPopup(2)"/>
						</td>
					    <td style="width:10%" colspan="2" align=right >Type<i>(Loại Thẻ)</i> </td>
                        <td style="width:15%" colspan="3">
                            <gw:list  id="lstCardType" value="" styles='width:100%'>
                                <data>
                                    <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0121' order by code ")%>||
                                </data>
                             </gw:list>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:10%" colspan="2" align='right'><gw:icon id="idBtnCheckIn" img="in" text="CHECK  IN" onclick="OnGateCheck(1)" /> </td>
                        <td style="width:15%" colspan="3"  align='left'>
                            <gw:datebox id="txtDateIn"  lang="1"	 style='width:100%'    />
                         </td>
                        <td style="width:7%" colspan="2"   align='left'>
                            <gw:textbox id="txtInTime"  text="" 	 styles='width:100%;'   />
                        </td>
                        <td style="width:8%" colspan="2"  align='right'><gw:icon id="idBtnCheckOut" img="in" text="CHECK OUT" onclick="OnGateCheck(2)" /> </td>
                        <td style="width:10%" colspan="2"  align='left'>
                            <gw:datebox id="txtDateOut"  lang="1" 	 style='width:100%'    />
                         </td>
                        <td style="width:10%" colspan="2"  align='left'>
                            <gw:textbox id="txtOutTime"  text="" 	 styles='width:100%;'   />
                        </td>
                    </tr>
			</table>
			</fieldset>
		</td>
		
	</tr>
	<tr style="height:5%"  id="idSearch1"><td colspan = "5">
			<table cellpadding="1" cellspacing="1" border=0>
				<tr>
					<td style="width:10%"  align = "right">Date <i> (Ngày)</i></td>
					<td style="width:10%" align = "right"><gw:datebox id="datWorkDateFr" lang="1" styles="width:100%" ></gw:datebox></td>
					
					<td style="width:14%"  align = "right">Status <i>(Tình trạng)</i></td>
					<td style="width:15%" align = "right">
					<gw:list  id="lstApproveStatus" value="ALL"  styles='width:100%' onchange="OnSearch(1)">
                        <data>
                            <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0124' order by code ")%>|ALL|Select All
                        </data>
                    </gw:list></td>
                    <td style="width:15%"  align = "right">Search<i>(Tìm kiếm)</i></td>
					<td style="width:25%"  align = "right"><gw:textbox id="txtSearchInfo" onenterkey = "OnSearch(1)"/></td>
				    <td style="width:1%"  align = "right"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch(1)"/></td>
					<td colspan="10" align = "right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
				</tr>
			</table>
	</td></tr>
	<tr style="height:44%; width:100%" id="idSearch2">
		<td width="100%" colspan="5"><table border=1 style="width:100%;height:100%;"><tr><td width="75%"  rowspan="2">
                   <gw:grid id='grdRegister'
                    header='_PK|Họ Tên Khách|CMND/Passport|Công Ty|L.hệ Với|Chức Vụ|Phòng Ban|Số Khách|Giờ Hẹn|Lý Do|Tình Trạng|Loại Thẻ|Số Thẻ|Giờ Vào|N.v Cho Vào|Giờ Ra|N.v Cho Ra|_Approve_status|_Vis_status|_GA_response'
                    format='0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='|||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|1500|1500|1500|1500|1500|1000|1000|1500|1000|1000|1000|1000|1000|0|0|0'
                    sorting='T'
                    styles='width:100%; height:100%'
                    oncellclick="OnClickRegister()"
                    />
			</td>
	</tr>
	</table>
	</td></tr>
 </table>
<gw:datebox id="dtDateCheckin"              style="display:none"/>
<gw:textbox id="txtVisStatus"              style="display:none"/>
<gw:textbox id="txtAppStatus"              style="display:none"/>
<gw:textbox id="txtRegistPKTemp"              style="display:none"/>
<gw:label id="lblCheckResult"              style="display:none"/>
<gw:textbox id="txtVis_App_PK"              style="display:none"/>

</body>
</html>
