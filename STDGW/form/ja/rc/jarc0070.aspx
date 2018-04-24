<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Caddy Entry</title>
</head>
<%  ESysLib.SetUser("crm")%>
   
<script>
var   
   v_golfer_pk          =0,
   v_member_fee_pk      =1,
   v_order              =2,
   v_member_type_pk     =3,
   v_member_id          =4, 
   v_member_nm          =5,
   v_gender             =6,
   v_card_no            =7,
   v_bag_no              =8,
   v_Nation=9,
   v_Booking_golfer_pk =10,
   v_group              =11,
   v_Start_Hole=12,
   v_Book_Cart=13,
   v_Book_Bag           =14,
   v_member_pk           =15,
   v_Green_Fee=16,
   v_Caddie_Fee=17,
   v_checkin            =18;
function BodyInit()
 {
    OnToggle();
    var data="";
    data = "data|9|9|18|18|27|27|36|36";
	lstHoles.SetDataText(data); 
    
    data = "<%=ESysLib.SetListDataSQL(" SELECT  pk, COURSE_ID || ' - ' || COURSE_NAME from crm.tgm_golf_course where del_if = 0 and ACTIVE_YN='Y' order by pk ")%>"+"||";
	lstGolfer.SetDataText(data);
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	grdGolfer.SetComboFormat(6,data);
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT' order by ord " )%>"; 
	grdGolfer.SetComboFormat(9,data);
	
	grdGolfer.SetComboFormat(11,'#1;A|#2;B|#3;C');
	grdBooking.SetComboFormat(8,'#1;A|#2;B|#3;C');
	data = "<%=ESysLib.SetGridColumnDataSQL("select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and a.USE_YN ='Y'   order by a.NAME" )%>"; 
	grdGolfer.SetComboFormat(3,data);
	grdBooking.SetComboFormat(2,data);
	data = "<%=ESysLib.SetListDataSQL("select to_char(sysdate,'yyyymmdd'),to_char(sysdate,'yyyymmdd')  from dual" )%>";	
	lstDate.SetDataText(data);
	dtCheckin.SetEnable(false);
	lstLocation.SetEnable(false);
	lstLocation.value="20";
	txtGroupNo.SetReadOnly(true);
	grdGolfer.SetComboFormat(12,'|#1;1|#2;2|#3;3|#4;4|#5;5|#6;6|#7;7|#8;8|#9;9|#10;10|#11;11|#12;12|#13;13|#14;14|#15;15|#16;16|#17;17|#18;18');
	OnResetM();
	dsoBooking.Call("SELECT");
 }

 function OnSearch(pos)
 {
     switch(pos)
     {
        case 1:
		    p_update = 'g_select';
            data_listofCheckIn.Call('SELECT');
        break;
        case 2: //search master
		     p_update = 'g_select';
             data_getMaster.Call('SELECT')
        break;
     }
 }
 var TransDate_item="";
 function OnCelClickItem()
 {
    txtMasterPK.text=grdSearch.GetGridData(grdSearch.row,0);
    TransDate_item=grdSearch.GetGridData(grdSearch.row,6);
    txtMasterPK.text=grdSearch.GetGridData(grdSearch.row,0);
    OnSearch(2);
 }
 function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function OnResetM()
{
     if(txtMasterPK.text == "" && txtFullName.text != ""){
		if(confirm("You have not saved data yet. Do you want to save?")){
			OnSave(1);
		}
	}
     txtMasterPK.text="";
     txtTeeTime.text=""; 
     lstHoles.value="18";
     txtCustomerPK.text="";
     txtFullName.text="";
     lstGolfer.value="";
     idBtnCheckIn.SetEnable(true);
     data_getMaster.StatusInsert();
     lstLocation.value="20";
     grdGolfer.ClearData();
	 
     
}
function SetParentPKtoGrid(p_grdId)
{
	for ( i = 1; i < p_grdId.rows ; i++ )
	{
		if ( p_grdId.GetGridData(i,0) == "" )
		{
			p_grdId.SetGridText( i ,1 , txtMasterPK.GetData());
		}
	}
}
function CheckSaveValid()
{
    
    if(txtTeeTime.text =="")
    {
        alert('Please, input TeeTime!') ; 
        return false;
    }
	if(txtTeeTime.text.length != 5)
    {
        alert('Invalid tee time format(hh:mi).');
        return false;
    }
    if(lstGolfer.value == "")
    {
        alert('Please select golf course.');
        lstGolfer.GetControl().focus();
        return false;
    }    
	for (var i = 1; i< grdGolfer.rows; i++)
    {
        
		if(grdGolfer.GetGridData(i,v_member_type_pk) == "")
            {
                alert('Please, input member type in grid!');
                 return false;
            }
		if(grdGolfer.GetGridData(i,v_member_nm) =="")
            {
                alert('Please, input player name in grid!');
                 return false;
            }
        if(grdGolfer.GetGridData(i,v_bag_no) =="")
            {
                alert('Please, input bag tag number!');
                 return false;
            }
        if(grdGolfer.GetGridData(i,v_card_no) =="")
            {
                alert('Please, input locker number!');
                 return false;
            }    
         
    }
    return true;
}
var p_update = 'g_select';
var p_update_dtl = 'select_dtl';
function OnSave(pos)
    {
      switch (pos)         
      {		        
            case 1 :
			    
				    if(CheckSaveValid())
				    {
					    p_update = 'gsave';
						data_getMaster.Call();
					}
			  
            break;
            case 2:
                SetParentPKtoGrid(grdGolfer);
                data_ReceiptGolfer.Call();
            break;

      }  
 }

function OnSaveDTL()
{
		p_update = 'gsave';
        data_ReceiptGolfer.Call();
}
function MandatoryColor()
{
    if (grdGolfer.rows >1)
    {
		grdGolfer.SetCellBgColor( 1, v_member_id , grdGolfer.rows - 1, v_member_id , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_member_nm , grdGolfer.rows - 1, v_member_nm , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_card_no , grdGolfer.rows - 1, v_card_no , 0xCCFFFF );
    }
}
function OnDataReceive(po_oData)
 {
     switch(po_oData.id)
     {
        case "data_getMaster":
            if(p_update == 'gsave'|| p_update == 'delete')
            {
                if(p_update == 'gsave')
                {
                     SetParentPKtoGrid(grdGolfer);
                     OnSaveDTL();
                }
                else
                {
                    p_update = 'end_rc_dl';
                    OnSearch(1);
                }
            }
            else
            {
                data_ReceiptGolfer.Call("SELECT");
                p_update ='end_rc';
            }
			
             
        break;
        case "data_ReceiptGolfer":
            
            if(p_update == 'gsave')
            {
                p_update ='g_select';
                OnSearch(1);
            }
            MandatoryColor();
        break;
        case "data_listofCheckIn":
            txtCount.text=grdSearch.rows-1 + " item(s).";
			grdSearch.GetGridControl().TopRow = grdSearch.rows-1;
			dsoBooking.Call("SELECT");
        break;
        case "dsoBooking":
            lblBKRemain.text = grdBooking.rows-1;
        break;
        case "dsoLookupMember":
           if(grdMemberList.rows == 2){
                grdGolfer.SetGridText(grdGolfer.row,v_member_id, grdMemberList.GetGridData(1,0));
                grdGolfer.SetGridText(grdGolfer.row,v_member_nm, grdMemberList.GetGridData(1,1));
                grdGolfer.SetGridText(grdGolfer.row,v_member_type_pk, grdMemberList.GetGridData(1,2));
				grdGolfer.SetGridText(grdGolfer.row,v_member_pk, grdMemberList.GetGridData(1,3))//member pk
           }
           else{
                OnGetMember(txtTmpMemberID.text);
           }
        break;   
     }
 }
function OnNewGolfer()
 {
    if(lstGolfer.value == "")
     {
            alert('Please select golf course firstly.');
            lstGolfer.GetControl().focus();
            return;
     }
    grdGolfer.AddRow();
	grdGolfer.SetGridText(grdGolfer.rows -1,v_member_fee_pk, txtMasterPK.text);
    grdGolfer.SetGridText(grdGolfer.rows -1,v_order,grdGolfer.rows -1);
    grdGolfer.SetGridText(grdGolfer.rows -1,v_gender,'GEN-M');
    grdGolfer.SetGridText(grdGolfer.rows -1,v_group,'1');
    if(grdGolfer.rows -1< 2)
    {
        grdGolfer.SetGridText(1,v_member_nm, txtFullName.text);
    }
    //Out course or E9 course
    if(lstGolfer.value == 1 || lstGolfer.value == 3){    
        grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,1);//start hole 
    }
    else{
        //In course
        grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,10);//start hole 
    }
    for(var i=1;i<grdGolfer.rows-1;i++)
     {
        if(grdGolfer.GetGridData(i,v_member_id) !="")
            {
               //grdGolfer.SetGridText(grdGolfer.rows-1,v_member_type_pk, 6);//add member type pk
            }
      }      
    MandatoryColor();
 }
 function OnDelete(obj)
 {
    var ctrl = obj.GetGridControl();

	var row  = ctrl.row;
		
	if ( row > 0  ) 
	{
		if ( obj.GetGridData( ctrl.row, 0 ) == "" ) 
	    {						
		
				obj.RemoveRow();
				txtNoGuest.text = grdGolfer.rows-1					
		}			
		else 
		{
			if ( confirm( "Do you want item this row to delete?" ) ) 
			{
				obj.DeleteRow();
				data_ReceiptGolfer.Call();
			}
		}
	}

 }
 function OnDeleteM()
    {
       if(txtMasterPK.text !="")
       {
           if(confirm("Do you want to delete this check in?")){
                p_update = 'delete';
                data_getMaster.StatusDelete();
                data_getMaster.Call();
           }
        }
        else
        {
            alert("Please check item delete.");
		return;
        }
    }
 function OnPopUp(id)
 {
      switch (id)         
      {
        case 1:
			if(lstGolfer.value!="")
			{
			    var path = System.RootURL + "/form/ja/bk/jabk0032.aspx?golf_type="+lstGolfer.value+"&day="+dtCheckin.GetData()+"";
                var obj = System.OpenModal( path ,730 , 350,  'resizable:yes;status:yes');

                if ( obj != null )
                {
                      txtTeeTime.text	= obj[0];
                      lstDate.value	= obj[1];
                }
            }
            else
            {
                alert('Please, input golf course.');
                 return false;
            }	        
	    break;     		        
	    case 2 :
	         if(lstGolfer.value == "")
             {
                    alert('Please select golf course firstly.');
                    lstGolfer.GetControl().focus();
                    return;
             }
	         var path = System.RootURL + "/form/ja/bk/jabk0010_popup_booking.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( object != null )
	             {
                        for( var i=0; i < object.length; i++)	  
                        {	
                                var arrTemp = object[i];
                                    grdGolfer.AddRow()    	    
		                            grdGolfer.SetGridText(grdGolfer.rows -1,v_member_fee_pk, txtMasterPK.text);
		                            grdGolfer.SetGridText(grdGolfer.rows -1,v_gender,'GEN-M');
                                    grdGolfer.SetGridText(grdGolfer.rows -1,8,'1');
		                            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_id, arrTemp[2]);//Member No
		                            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_nm, arrTemp[5]);//Player Name     
		                            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_pk, arrTemp[1]);//Member_pk  
		                            grdGolfer.SetGridText( grdGolfer.rows-1, v_Booking_golfer_pk,arrTemp[20]);//v_Booking_golfer_pk    
		                              
		                            //Out course or E9 course
                                    if(lstGolfer.value == 1 || lstGolfer.value == 3){    
                                        grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,1);//start hole 
                                    }
                                    else{
                                        //In course
                                        grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,10);//start hole 
                                    }
		                            grdGolfer.SetGridText( grdGolfer.rows-1, v_Book_Cart,arrTemp[22]);//book cart YN   
                                    txtBookingPK.text=arrTemp[0];
                                    txtFullName.text=arrTemp[4] ;
                                    lstHoles.value=arrTemp[16];
				                    txtTeeTime.text = arrTemp[18];                 
                                    lstGolfer.value=arrTemp[19];
                       }		            
	             }
                 MandatoryColor();
        break;
         case 3:
	        if (txtBookingPK.text == "")
	        {
	        var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( obj != null )
             { 
                 txtFullName.text   = obj[2];
             }  
           } else
           {
                alert('Cannot change customer!')
           }
           
	    break;
	 }  
 }
 function OnGetMember(p_member_id)
 {
         var path = System.RootURL + "/form/ja/rc/jarc0010_member.aspx?member_no="+p_member_id;
	         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,v_member_pk,arrTemp[0])//member pk
	              grdGolfer.SetGridText(grdGolfer.row,v_member_id ,arrTemp[1])//member Id
	              grdGolfer.SetGridText(grdGolfer.row,v_member_nm ,arrTemp[2])//member name
	              grdGolfer.SetGridText(grdGolfer.row,v_gender ,arrTemp[4])//gender
	              grdGolfer.SetGridText(grdGolfer.row,v_member_type_pk,arrTemp[13])//member pk
	         }
 }   
 function OnGolferDouble()
 {
    if((event.col == v_member_id && event.row >0))
    {
         var path = System.RootURL + "/form/ja/rc/jarc0010_member.aspx";
	         var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,v_member_pk,arrTemp[0])//member pk
	              grdGolfer.SetGridText(grdGolfer.row,v_member_id ,arrTemp[1])//member Id
	              grdGolfer.SetGridText(grdGolfer.row,v_member_nm ,arrTemp[2])//member name
	              grdGolfer.SetGridText(grdGolfer.row,v_gender ,arrTemp[4])//gender
	              grdGolfer.SetGridText(grdGolfer.row,v_member_type_pk,arrTemp[13])//member pk
	         }
    }  
    else if(event.col == v_card_no && event.row >0)//card no
    {
       /*        
		var path = System.RootURL + "/form/ja/bs/jabs00050_Popup.aspx";
	         var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp;
	            arrTemp = object[0];
	            grdGolfer.SetGridText(grdGolfer.row,v_card_no,arrTemp[1])//card no
	         }
	   */		 
    }      
    
 }
 function OnBKDblClick(){
    if(lstGolfer.value == "")
    {
        alert('Please select golf course firstly.');
        lstGolfer.GetControl().focus();
        return;
    }    
    if(event.row > 0 )
    {
            grdGolfer.AddRow();
            //grdGolfer.SetGridText(grdGolfer.rows -1,8,'1');
            grdGolfer.SetGridText(grdGolfer.rows -1,v_member_type_pk, grdBooking.GetGridData(event.row,2));
            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_id, grdBooking.GetGridData(event.row,3));//Member No
            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_nm, grdBooking.GetGridData(event.row,4));//Player Name     
            grdGolfer.SetGridText(grdGolfer.rows -1, v_group, grdBooking.GetGridData(event.row,8));//player group
            grdGolfer.SetGridText( grdGolfer.rows-1, v_member_pk, grdBooking.GetGridData(event.row,1));//Member_pk  
            grdGolfer.SetGridText( grdGolfer.rows-1, v_Booking_golfer_pk,grdBooking.GetGridData(event.row,0));//v_Booking_golfer_pk
         
           if( grdBooking.GetGridData(event.row,2) != "11"){   
               //Out course or E9 course
                if(lstGolfer.value == 1 || lstGolfer.value == 3){    
                    grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,1);//start hole 
                }
                else{
                    //In course
                    grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,10);//start hole 
                }
            }
            else{
                grdGolfer.SetGridText( grdGolfer.rows-1, v_Start_Hole,grdBooking.GetGridData(event.row,9));//start hole 
            }
            for(var i=1;i<grdGolfer.rows-1;i++)
             {
                if(grdGolfer.GetGridData(i,v_member_id) !="")
                    {
                       //grdGolfer.SetGridText(grdGolfer.rows-1,v_member_type_pk, 6);//add member type pk
                    }
              } 
              
            grdGolfer.SetGridText( grdGolfer.rows-1, v_Book_Cart,grdBooking.GetGridData(event.row,10));//book cart YN   
			grdGolfer.SetGridText( grdGolfer.rows-1, v_Book_Bag,grdBooking.GetGridData(event.row,11));//book bag YN   
			
            txtTeeTime.text = grdBooking.GetGridData(event.row,7);//book time        
            grdBooking.SetCellBgColor( event.row, 0 , event.row, grdBooking.cols-2 , 0x00FFFF );
    }
 }
 function OnAfterCellEdit(obj){
    if(obj.id == "grdGolfer")
    {
        if(event.col == 4){
            txtTmpMemberID.text = obj.GetGridData(event.row,4);
            if(txtTmpMemberID.text != ""){
                dsoLookupMember.Call("SELECT");
            }
        }
    }
 }
</script>

<body>
<gw:data id="dsoLookupMember" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3" function="CRM.sp_sel_jarc0010_lkp_member" > 
                <input> 
                    <input bind="txtTmpMemberID" /> 
                </input> 
                <output bind="grdMemberList" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="data_listofCheckIn" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm"   parameter="0,1,2,3" function="CRM.sp_sel_jarc0010_search" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtIDSearch" /> 
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------>
    <gw:data id="data_getMaster" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8" function="crm.sp_sel_jarc0010_mastercheckin" procedure=" crm.sp_upd_jarc0010_mastercheckin"> 
                <inout> 
                    <inout bind="txtMasterPK" />
                    <inout bind="lstLocation" />
                    <inout bind="txtBookingPK" /> 
                    <inout bind="txtFullName" />
                    <inout bind="lstHoles" />
                    <inout bind="lstGolfer" /> 
                    <inout bind="txtTeeTime" />  
                    <inout bind="dtCheckin" />
                    <inout bind="txtGroupNo" />  
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------>
    <gw:data id="data_ReceiptGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="CRM.sp_sel_jarc0010_dtlcheckin" procedure="CRM.sp_upd_jarc0010_detailcheckin" > 
                <input> 
                     <inout bind="txtMasterPK" />
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------------>
    <gw:data id="dsoBooking" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jarc0010_booking"> 
                <input> 
                    <input bind="txtBKPlayer" />
                </input> 
                <output bind="grdBooking" /> 
            </dso> 
        </xml> 
    </gw:data>
    
    <table style="height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 20%" id="idLEFT">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 30%">
                            <b>Date</b>
                        </td>
                        <td style="width: 79%">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                            ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnOrderNoSearch" img="search" onclick='OnSearch(1)' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 20%; white-space: nowrap">
                            <b>Name</b></td>
                        <td>
                            <gw:textbox id="txtIDSearch" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 20%; white-space: nowrap">
                            <b>Total Record</b></td>
                        <td align="center">
                            <gw:label id="txtCount" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Group#|Locker#|Golfer Name|Player Type|Time|Date"
                                format="0|0|0|0|0|0|4" aligns="0|0|0|0|0|0" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true" autosize="T" oncellclick="OnCelClickItem()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 80%" id="idRIGHT">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%" valign="top">
                        <td>
                            <table width="100%">
                                <tr>
                                    <td style="width:10%" align="center">
                                        Group#</td>
                                    <td style="width: 10%">
                                        <gw:textbox id="txtGroupNo" styles='width:100%;' csstype="mandatory" onenterkey="" />
                                    </td>
                                    <td style="width: 15%">
                                        Golf Course</td>
                                    <td style="width:20%">
                                        <gw:list id="lstGolfer" styles='width:100%' />
                                    </td>
                                    <td style="width:5%">
                                        Date</td>
                                    <td style="width:10%">
                                        <gw:datebox id="dtCheckin" styles='width:100%' lang="1"/>
                                    </td>
                                    <td style="width:15%" >
                                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">
                                        <b style="color: Red">*</b>Tee Time </td>
                                    <td style="width:10%">
                                        <gw:textbox id="txtTeeTime" />
                                    </td>
                                    <td width="10%"></td>
                                    <td style="width:5%">
                                        <gw:icon id="idBtnNew" img="2" text="New" alt="New" styles='width:100%' onclick="OnResetM()" />
                                    </td>
                                    <td style="width:5%">
                                        <gw:icon id="idBtnDelete" img="2" text="Delete" styles='width:100%' onclick="OnDeleteM()" />
                                    </td>
                                    <td style="width:5%">
                                        <gw:icon id="idBtnCheckIn" img="2" text="Save" styles='width:100%' onclick="OnSave(1)" />
                                    </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="height: 2%" valign="top">
                    <td>
                        <table style="height: 100%; width: 100%">
                            <tr style="height: 100%;">
                                <td style="width:15%">Checkin Location:</td>
                                <td style="width:20%">
                                    <gw:list id="lstLocation">
                                      <data>Data|10|Club house|20|Academy</data>
                                    </gw:list>  
                                </td>
                                <td width="40%"></td>
                                <td style="width: 11%" align="right">
                                    <gw:icon id="btnGetReservation" img="2" text="Get Reservation" alt="New" styles='width:100%'
                                        onclick="OnPopUp(2)" />
                                </td>
                                <td style="width: 3%">
                                    <gw:imgbtn id="idBtnNewM" img="new" text="Add" alt="New" styles='width:100%' onclick="OnNewGolfer()" />
                                </td>
                                <td style="width: 3%">
                                    <gw:imgbtn id="idBtnDelM" img="delete" alt="Delete" text="Delete" styles='width:100%'
                                        onclick="OnDelete(grdGolfer)" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height: 30%" valign="top">
                    <td>
                        <gw:grid id='grdGolfer' header='_GOLFER_PK|_MEMBERFEE_PK|No|*Player Type|Member#|*Player Name|_Gender|*Locker#|*Bagtag#|Nation|_Booking_golfer_pk|Group|Start Hole|Book Cart|Book Bag|_Member_pk|Green Fee|Caddie Fee|Check In Time'
                            format='0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|0|0|0|0' 
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            editcol='1|1|0|0|1|1|1|1|1|1|1|1|1|1|0|1|0|0|0' 
                            defaults='||||||||||||||||||'
                            widths='0|0|800|0|1500|2500|1000|1000|1000|1000|1500|1000|0|1000|1000|1000|100|100|100'
                            sorting='T' autosize='T' oncelldblclick="OnGolferDouble()" onafteredit="OnAfterCellEdit(this)" styles='width:100%; height:100%' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Player Name:&nbsp<gw:textbox id="txtBKPlayer" styles="width:30%" onenterkey="dsoBooking.Call('SELECT');" />
                        Remain:&nbsp<gw:label id="lblBKRemain" styles="width:10%" />
                    </td>
                </tr>
                <tr style="height: 60%" valign="top">
                    <td>
                        <gw:grid id='grdBooking' header='_PK|_Member_pk|Player Type|Member#|Player Name|Contact Person|Play Date|Tee Time|Group|Start Hole|Book Cart|Book Bag|Contact phone|_master_pk|_holes|_course_pk'
                            format='0|0|0|0|0|0|4|0|0|0|3|3|0|0|0|0' aligns='0|0|0|0||00|0|0|0|0|0|0|0|0|0|0' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='0|0|800|0|1500|2500|1000|1000|1000|1000|1000|1500|0|0|0|0' sorting='T' autosize='T'
                            oncelldblclick="OnBKDblClick()" styles='width:100%; height:100%' />
                    </td>
                </tr>
                </table>
                </td>
            </tr>    
    </table>
    <!---------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <gw:textbox id="txtCustomerPK" styles="display:none" />
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtBookingPK" styles="display:none" />
    <gw:textbox id="txtMemberNo" text="" styles="display:none" />
    <gw:list id="lstDate" styles="display:none" />
    <gw:textbox id="txtFullName" styles='width:100%;display:none' csstype="mandatory"
        onenterkey="" />
    <gw:textbox id="txtTmpMemberID" text="" styles="display:none" />
    <gw:grid id='grdMemberList' header='MemberID|Name|Member Type|PK'
     format='0|0|0|0'  styles='display:none' />
     <gw:list id="lstHoles" styles='width:100%;display:none'  />
    <!--------------------------------------